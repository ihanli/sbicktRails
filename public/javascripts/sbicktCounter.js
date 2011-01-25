/*
#################################################
#            s'bickt Android Client             #
# Bildungseinrichtung:  Fachhochschule Salzburg #
#         Studiengang:  MultiMediaTechnology    #
#               Zweck:  Qualifikationsprojekt   #
#################################################################################
#                                                                               #
# This is the client for the augmented reality and social community app s'bickt #
# Copyright Alexander Flatscher, Ismail Hanli                                   #
#                                                                               #
# This file is part of s'bickt.                                                 #
#                                                                               #
# S'bickt is free software: you can redistribute it and/or modify               #
# it under the terms of the GNU Affero General Public License as published by   #
# the Free Software Foundation, either version 3 of the License, or             #
# (at your option) any later version.                                           #
#                                                                               #
# S'bickt is distributed in the hope that it will be useful,                    #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 #
# GNU Affero General Public License for more details.                           #
#                                                                               #
# You should have received a copy of the GNU Affero General Public License      #
# along with s'bickt.  If not, see <http://www.gnu.org/licenses/>.              #
#################################################################################
*/

var sbicktCounter;
var requestURL = "http://localhost:3000/geotags/count";
var currentTarget = 0;

var initCounter = function() {
	var count = 0;

	$.getJSON(requestURL, function(json) {
		if (json.status == 'ok') {
			count = json.count;
		}
		
		sbicktCounter = new flipCounter('counter', {
			value : count,
			pace : 100,
			auto : false
		});
	});
};

var refreshCounter = function() {
	$.getJSON(requestURL, function(json) {
		if (json.status == 'ok') {
			if(currentTarget != json.count){
				currentTarget = json.count;
				
				intervalId = setInterval(function() {
					currentValue = sbicktCounter.getValue();
					if (currentValue < 50)
						sbicktCounter.setValue(currentValue + 1);
					else
						clearInterval(intervalId);
				}, 250);
			}
		}
		else {
			sbicktCounter.setValue(0);
		}
	});
};