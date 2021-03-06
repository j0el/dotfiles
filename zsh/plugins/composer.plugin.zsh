#!/usr/bin/env zsh

#compdef composer
# ------------------------------------------------------------------------------
# Copyright (c) 2011 Github zsh-users - http://github.com/zsh-users
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# * Neither the name of the zsh-users nor the
# names of its contributors may be used to endorse or promote products
# derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL ZSH-USERS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# ------------------------------------------------------------------------------
# Description
# -----------
#
#  Completion script for composer (https://getcomposer.org/).
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
#  * Daniel Gomes (me@danielcsgomes.com)
#  * Valerii Hiora (https://github.com/vhbit)
#  * loranger (https://github.com/loranger)
#
# ------------------------------------------------------------------------------

local curcontext=$curcontext state line
declare -A opt_args

_composer_get_command_list () {
    composer --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/ [a-z]+/ { print $1 }'
}

_composer_get_required_list () {
    composer show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_composer () {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments \
    '1: :->command'\
    '*: :->args'
  if [ -f composer.json ]; then
    case $state in
      command)
        compadd "$(_composer_get_command_list)"
        ;;
      *)
        compadd "$(_composer_get_required_list)"
        ;;
    esac
  else
   compadd create-project init search selfupdate show
  fi
}

compdef _composer composer

PATH="$HOME/.composer/vendor/bin:$PATH"
