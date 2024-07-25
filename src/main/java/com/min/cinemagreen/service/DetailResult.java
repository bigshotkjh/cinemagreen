package com.min.cinemagreen.service;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class DetailResult {
	private boolean adult;
	private String backdrop_path;
	private String belongs_to_collection;
	private Long budget;
	private List<Genre> genres;
	private int id;
	private String imdb_id;
	private String original_title;
	private String overview;
	private int popularity;
	private String poster_path;
	private String release_date;
	private int revenue;
	private int runtime;
	private String title;
	private int vote_average;
	private int vote_count;
}
