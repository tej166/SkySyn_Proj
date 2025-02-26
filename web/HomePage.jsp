<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkySync Weather</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <style>
        body {
            background-color: #ffffff; 
            font-family: 'Arial', sans-serif;
            color: #008080; 
        }
        .navbar {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

        }
        .card {
            background: #ffffff; 
            color: black;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
/*            opacity: 0.8;*/
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #008080;
        }
        .card-text {
            font-size: 1.2rem;
        }
        .form-control {
            border-radius: 20px;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            
        }
        .btn-primary {
            border-radius: 20px;
            background-color: #008080;
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-primary:hover {
            background-color: #005F5F; 
        }
        .form-container {
            padding: 20px 40px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
/*            opacity: 0.8;*/
        }
        .add-card-btn {
            background-color: #008080; 
            color: #ffffff; 
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 24px;
            border: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #008080;
            margin-bottom: 20px;
        }
        .weather-card {
            background: #ffffff; 
            color: black;
            margin: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            width: 40rem;
        }
        .current-weather-card {
            background-color: #f8f9fa;
            border-left: 5px solid #007bff;
        }
    </style>
</head>
</head>
<body style="background: url(imgs/pexels.jpg); background-size: cover; background-attachment: fixed">

    <%
    String uname = (String) session.getAttribute("uname");
    System.out.println("Session attribute uname: " + uname);

    if (uname == null) {
        response.sendRedirect("signup.jsp");
    }
    %>
    
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">SkySync Weather</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="signup.jsp">Sign Out</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="row">
<!--Search by Coordinates -->
            <div class="col-md-6 form-container">
                <div class="card">
                    <h2>Search by Coordinates</h2>
                    <form id="coordinatesForm">
                        <div class="form-group">
                            <input type="text" class="form-control" id="latitude" name="latitude" placeholder="Enter latitude">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="longitude" name="longitude" placeholder="Enter longitude">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Search</button>
                    </form>
                </div>
            </div>

            <!-- Search by Place -->
            <div class="col-md-6 form-container">
                <div class="card">
                    <h2>Search by Place</h2>
                    <form id="placeForm">
                        <div class="form-group">
                            <input type="text" class="form-control" id="place" name="place" placeholder="Enter place">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Search</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="row">
        <!--Calculate Average Temperature for a Year -->
            <div class="col-md-6 form-container">
                <div class="card">
                    <h2>Calculate Average Temperature </h2>
                    <form id="AvgTempForm">
                        <div class="form-group">
                            <input type="text" class="form-control" id="startDate" name="startDate" placeholder="Start Date (YYYY-MM-DD)">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="endDate" name="endDate" placeholder="End Date (YYYY-MM-DD)">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Calculate</button>
                    </form>
                </div>
            </div>

<!--Yearly Average Temperature -->
            <div class="col-md-6 form-container">
                <div class="card">
                    <h2>Yearly Average Temperature</h2>
                    <form id="yearlyAvgForm">
                        <div class="form-group">
                            <input type="text" class="form-control" id="yearInput" name="yearInput" placeholder="Enter year (e.g., 2024)">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Search</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    

    <!-- Weather Result Section -->
    <div id="weatherResult" class="mt-4">
    </div>

    <!-- Additional weather results section -->
    <div id="additionalWeatherResults" class="mt-4">
        <h2>Pinned Places</h2>
        <div id="additionalWeatherResults"></div>
    </div>
</div>

<!-- Button to Add Weather Results Card -->
<button id="addCardBtn" class="add-card-btn">+</button>



<script>
    $(document).ready(function() {
        let weatherDataArray = [];

        // Coordinate Card
        $('#coordinatesForm').submit(function(event) {
            event.preventDefault();
            $.ajax({
                type: 'POST',
                url: 'weather',
                data: $(this).serialize(),
                success: function(response) {
                    weatherDataArray.push(response);
                    $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + response + '</div></div>');
                },
                error: function() {
                    $('#weatherResult').html('<p>Invalid Input</p>');
                }
            });
        });

        // Place Card
        $('#placeForm').submit(function(event) {
            event.preventDefault();
            $.ajax({
                type: 'POST',
                url: 'weather',
                data: $(this).serialize(),
                success: function(response) {
                    if (response === "City not found") {
                        alert("City not found. Please enter a valid city.");
                    } else {
                        weatherDataArray.push(response);
                        $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + response + '</div></div>');
                    }
                },
                error: function() {
                    alert("City Not Found");
                }
            });
        });


// Custom Average Temperature Card (usinf servlet)
    //    $(document).ready(function() {
    //        $('#AvgTempForm').submit(function(event) {
    //            event.preventDefault();
    //            let startDate = $('#startDate').val();
    //            let endDate = $('#endDate').val();
    //            fetchAndCalculateAverage(startDate, endDate);
    //        });
    //
    //        function fetchAndCalculateAverage(startDate, endDate) {
    //            $.ajax({
    //                type: 'POST',
    //                url: 'averageTemperature',
    //                data: {
    //                    action: 'calculateAverageTemperature',
    //                    startDate: startDate,
    //                    endDate: endDate
    //                },
    //                success: function(response) {
    //                    if (response.averageTemperature) {
    //                        let result = 'Average temperature between <strong>' + response.startDate + '</strong> and <strong>' + response.endDate + '</strong> is <strong>' + response.averageTemperature.toFixed(2) + ' °C</strong>';
    //                        $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + result + '</div></div>');
    //                    } else {
    //                        $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + response.message + '</div></div>');
    //                    }
    //                },
    //                error: function(xhr, status, error) {
    //                    console.error('Error fetching average temperature:', error);
    //                    $('#weatherResult').html('<p>Error fetching average temperature</p>');
    //                }
    //            });
    //        }
    //    });


        $('#AvgTempForm').submit(function(event) {
            event.preventDefault();
            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            fetchAndCalculateAverage(startDate, endDate);
        });

        function fetchAndCalculateAverage(startDate, endDate) {
            fetch('./tempdata.json')
                .then(res => res.json())
                .then(data => {
                    const temperatures = data.temperatures;
                    let total = 0;
                    let count = 0;
                    for (const date in temperatures) {
                        if (date >= startDate && date <= endDate) {
                            total += temperatures[date];
                            count++;
                        }
                    }
                    if (count > 0) {
                        const average = total / count;
                        var response = 'Average temperature between <strong>' + startDate + '</strong> and <strong>' + endDate + '</strong> is <strong>' + average.toFixed(2) + ' °C</strong>';
                        $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + response + '</div></div>');
                    } else {
                        $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">No temperature data found</div></div>');
                    }
                })
                .catch(err => console.error('Error fetching data:', err));
        }



        // Year Average Card
    $('#yearlyAvgForm').submit(function(event) {
        event.preventDefault();
        let year = $('#yearInput').val().trim();
        fetch('./YearData.json')
            .then(function(res) {
                return res.json();
            })
            .then(function(data) {
                let temperature = data.temperatures[year];
                if (temperature !== undefined) {
                    let response = 'Average temperature for <strong>' + year + '</strong> is <strong>' + temperature.toFixed(2) + ' °C</strong>';
                    $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">' + response + '</div></div>');
                } else {
                    $('#weatherResult').html('<div class="card weather-card current-weather-card"><div class="card-body">No data found  </div></div>');
                }
            })
            .catch(function(err) {
                console.error('Error fetching data:', err);
            });
    });



        // Add Card Button
    $('#addCardBtn').click(function() {
        if (weatherDataArray.length > 0) {
            let latestWeatherData = weatherDataArray[weatherDataArray.length - 1];
            let userName = getCookie('username'); 
            let tempDiv = document.createElement('div');
            tempDiv.innerHTML = latestWeatherData;

            let place = extractValue(latestWeatherData, "Place");
            let latitudeStr = extractValue(latestWeatherData, "Latitude");
            let longitudeStr = extractValue(latestWeatherData, "Longitude");
            let temperatureStr = extractValue(latestWeatherData, "Temperature");

            let latitude = parseFloat(latitudeStr);
            let longitude = parseFloat(longitudeStr);
            let temperature = parseFloat(temperatureStr.replace("°C", ""));

            $.ajax({
                type: 'POST',
                url: 'addWeatherInfo',
                data: {
                    place: place,
                    latitude: latitude,
                    longitude: longitude,
                    temperature: temperature,
                    userName: userName
                },
                success: function(response) {
                    console.log(response);
                    $('#additionalWeatherResults').append('<div class="card weather-card"><div class="card-body">' + latestWeatherData + '</div></div>');
                },
                error: function(xhr, status, error) {
                    if (xhr.status === 409) {
                        console.error('Error adding weather info:', xhr.responseText);
                        alert(xhr.responseText); // Show alert message for duplicate entry
                    } else {
                        console.error('Error adding weather info:', xhr.responseText);
                    }
                }
            });
        }
    });

        function extractValue(data, key) {
            let startIndex = data.indexOf(key);
            if (startIndex === -1) return "";
            let endIndex = data.indexOf("<", startIndex);
            return data.substring(startIndex + key.length + 2, endIndex);
        }

        // Fetch Pinned Weather Data on Load
        function fetchPinnedWeatherData() {
            $.ajax({
                type: 'GET',
                url: 'fetchPinnedWeather',
                success: function(response) {
                    var weatherCardsHtml = '';
                    response.forEach(function(weatherData) {
                        weatherCardsHtml += '<div class="weather-card" style="width: 20rem; margin: 10px;">';
                        weatherCardsHtml += '<div class="card-body">';
                        weatherCardsHtml += '<h5 class="card-title">' + weatherData.place + '</h5>';
                        weatherCardsHtml += '<p class="card-text">Latitude: ' + weatherData.latitude + '</p>';
                        weatherCardsHtml += '<p class="card-text">Longitude: ' + weatherData.longitude + '</p>';
                        weatherCardsHtml += '<p class="card-text">Temperature: ' + weatherData.temperature + '°C</p>';
                        weatherCardsHtml += '</div></div>';

                    });
                    $('#additionalWeatherResults').html('<div class="d-flex flex-nowrap">' + weatherCardsHtml + '</div>');
                },
                error: function() {
                    $('#additionalWeatherResults').html('<p>Error fetching pinned weather data</p>');
                }
            });
        }

        fetchPinnedWeatherData();

        $('#fetchPinnedWeatherForm').submit(function(event) {
            event.preventDefault();
            fetchPinnedWeatherData();
        });

        function getCookie(cookieName) {
            let name = cookieName + "=";
            let decodedCookie = decodeURIComponent(document.cookie);
            let cookieArray = decodedCookie.split(';');
            for (let i = 0; i < cookieArray.length; i++) {
                let cookie = cookieArray[i];
                while (cookie.charAt(0) === ' ') {
                    cookie = cookie.substring(1);
                }
                if (cookie.indexOf(name) === 0) {
                    return cookie.substring(name.length, cookie.length);
                }
            }
            return "";
        }
    });
</script>




</body>
</html>
