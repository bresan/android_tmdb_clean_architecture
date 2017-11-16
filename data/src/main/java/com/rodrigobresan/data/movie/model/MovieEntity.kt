package com.rodrigobresan.data.movie.model

data class MovieEntity(val id: Long, val title: String, val rating: Double, val posterPath: String) {

    override fun equals(other: Any?): Boolean {
        other as MovieEntity
        if (id != other.id) return false
        if (title != other.title) return false
        if (rating != other.rating) return false
        if (posterPath != other.posterPath) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id.hashCode()
        result = 31 * result + title.hashCode()
        result = 31 * result + rating.hashCode()
        result = 31 * result + posterPath.hashCode()
        return result
    }

}