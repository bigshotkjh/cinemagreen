package com.min.cinemagreen.service;

import lombok.Data;
import java.util.List;

@Data
public class Grade {
    private int id; 
    private List<Result> results;
}

@Data
class Result {
    private String iso_3166_1;
    private List<ReleaseDate> release_dates;
}

@Data
class ReleaseDate {
    private String certification;
    private List<String> descriptors;
    private String iso_639_1;
    private String note;
    private String release_date;
    private int type;
}
