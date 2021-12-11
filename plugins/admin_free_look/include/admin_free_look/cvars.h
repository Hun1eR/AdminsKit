/*
 *  Copyright (C) 2020 the_hunter
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

#pragma once

#include <amxx/api.h>
#include <core/cvar.h>

namespace admin_free_look::cvars
{
    inline const cssdk::CVar* cvar_enable{};
    inline const cssdk::CVar* cvar_access{};

    inline bool Enable()
    {
        return core::cvar::GetValue<bool>(cvar_enable);
    }

    inline int Access()
    {
        return amxx::ReadFlags(core::cvar::GetValue<const char*>(cvar_access));
    }

    inline bool Register()
    {
        cvar_enable = core::cvar::Register("afl_enable", "0");
        cvar_access = core::cvar::Register("afl_access", "d");

        return cvar_enable && cvar_access;
    }
}
