package org.iesch.a02_registro_superheroes.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize
// 6 - Me creo el objeto SuperHeroe y lo hago parcelizable
@Parcelize
data class SuperHeroe (
    val nombre: String,
    val alterEgo: String,
    val bio: String,
    val power: Float
) : Parcelable