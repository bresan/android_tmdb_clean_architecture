package com.rodrigobresan.cache.movie_category.dao

import android.arch.persistence.room.*
import com.rodrigobresan.cache.movie_category.MovieCategoryQueries
import com.rodrigobresan.cache.movie_category.model.MovieCategoryCached

@Dao
interface MovieCategoryDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(movieCategory: MovieCategoryCached)

    @Query("SELECT MovieCategory.movieId, MovieCategory.categoryId, MovieCategory.description" +
            " FROM MovieCategory " +
            " WHERE MovieCategory.movieId = :arg0 " +
            " AND MovieCategory.categoryId LIKE :arg1")
    fun getMovieInCategory(movieId: Long, name: String): List<MovieCategoryCached>

    @Query("SELECT * FROM MovieCategory")
    fun getMovieCategories(): List<MovieCategoryCached>

    @Delete
    fun delete(mapToCached: MovieCategoryCached)
}