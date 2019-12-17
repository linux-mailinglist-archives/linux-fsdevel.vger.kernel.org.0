Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDD122C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfLQNLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 08:11:36 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:45603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfLQNLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:11:36 -0500
Received: from [192.168.1.155] ([95.114.21.161]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McpW6-1i8PmK0D1G-00a12l; Tue, 17 Dec 2019 14:11:22 +0100
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and
 headers
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Markus Elfring' <Markus.Elfring@web.de>
Cc:     linux-kernel@vger.kernel.org, 'Christoph Hellwig' <hch@lst.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        =?UTF-8?Q?=27Valdis_Kl=c4=93tnieks=27?= <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
 <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
 <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de>
 <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <c6698d0c-d909-c9dc-5608-0b986d63a471@metux.net>
Date:   Tue, 17 Dec 2019 14:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mh372I7jZZSLHn3TFj2C4vjsq8xUP2bJNTgyJkEC5Ux0+Q+dvGX
 xduxo7XdAI059eJX9/44Yq1irmLdP5UBBY+ObsaLvHjYn95DPmiz+YTuxxHDBmv6SCQv55G
 U4uujJDDY6ac+c4b+1mjOokJtGGEX++sEOpJyzMJPrbHHZqDKy48brfkVNi21uuE8m906G5
 omOFg0/1HD//Avp3Jp33w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yv7qDD8T/Ss=:C85R98w7NY3LaLz4fH72+J
 CO+BMGRbLbJDjY5Qga2WpvOMLY6UgQ4UYeqy33ixeCYRvRjnIaOdbHwDFoJOdJm5Pdm2VsFn3
 zWh3DNIIRqL7Xxj4sINX4W3BBKXUvdlwx10/jJVucKdSA0sJtckKA46mw8xu/AlR04f1htgyG
 7hlQv8gg3AIfxTg1RFVJwG9DjF7ZumWA2eIEXg7v6Jc1qYT7XgsDhTuxkl37gtPpMbUgm5vLc
 9QyVbWaIEg6j+WA1asbMiRM/0o2yif70shJk2UUl4nwAlRqsgZToERDMJS6rSeNLJfhnE/vnx
 ISWWxLubVufrIw9SL5ve5Ap6DkikkqAcI1yP+gYHyLvTIZPhmjZ0SI7r9xUYwTE5Bs2zxvDoW
 GJhhG+QskV7GFVX1Gw/McK66cWz6+SLrnHgoIdSKpw6zXl/IXurqUxPdaEQK28Fd2vmT7ZP6O
 PNok5eT2CzxlZFGvlBzl1QByynWUMve0PVV3SYx0cZomauHCotpfRizVrLyQvgLsSRiCU09ay
 M9r/VFccNmwmc4hgwwZUYqLAlcWYk+aXbFw4EaPGKqLoqeMVi40neS8AJVWVd9UgU1rVI+dP3
 mpMnPWJ+Uu/cbOQ7e5N/TrTctlcgDWT1CGnlBHlnakHAtEVEUrPSvOX+47HX0T310S6HgP2gp
 jouZliDWWxccY4D4zrktZshUO/bZaEkEJeS0Po9biAY4C7k1Rr/94iyPwTMW8Tq9BtWiNFchW
 L2ZD+2uO4Q9OOnsh7pyaOQvN1pEgqQNUr8jJJ88+tOUzfYNi6J3wF5+ejcjL6yV5txECnYAW8
 cqlKSewU9wHqvFFBbH8AR52mTyd7ss4xyJjq5CLtmnLgNCLteSP1RNGrI/mh4OGemypiI/W1u
 0sNQoSx5ojcEPZs5MYBg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.19 01:02, Namjae Jeon wrote:
>> 2. Which source file should provide the corresponding implementation?
>>    (I did not find it in the update step “[PATCH v7 06/13] exfat: add exfat
>>    entry operations” so far.)
> Good catch, I will move it on next version.

By the way: do you think the driver is already stable enough for
production use ? Are there any limitations we have to consider ?

I just have a client, who wants to use it in a semi-embedded (telemetry)
device, for recording to an external USB drive.


--mtx


-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
