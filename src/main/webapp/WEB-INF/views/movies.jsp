<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/styles.css'/>"/>
    <style>
        .container {
            text-align: center;
            margin: 0 auto;
            padding: 20px;
        }
        .movie-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .movie-item {
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .movie-item img {
            width: 100%;
            border-radius: 10px;
        }
        .movie-item h2 {
            font-size: 18px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Movie List</h1>
        <div class="movie-list">
            <c:forEach var="movie" items="${movies}">
                <div class="movie-item">
                    <img src="http://image.tmdb.org/t/p/original${movie.poster_path}" alt="${movie.title}">
                    <h2>${movie.title}</h2>
                    <p>Rank: ${movie.vote_count}</p>
                    <p>Release Date: ${movie.release_date}</p>
                    <p>Audience: ${movie.vote_average}</p>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
