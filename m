Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC341A1C6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH2OJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 10:09:34 -0400
Received: from mout.web.de ([212.227.15.3]:36983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfH2OJe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567087746;
        bh=v0Udfz8+vrJdTmzBpUeGxpkVKYZBssqSqLWqH1nIup0=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=PBQRrG4mZDL5hHIvLATbqaAIyKuSmm4s+sow4HmJKOPlw8K6ouargHJ/jvIrPOXTi
         hOSiIkCc9C7AkIG33srug7Ampn+jacC0ku1zfhWcc4RJahCzdg7InBCgFJ70eT93ob
         +76qsBi/sj3nYaT9YA56d/FsYzJVvX3UgTwy8IT0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.172.157]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09z2-1iLopq2DF6-00uMrO; Thu, 29
 Aug 2019 16:09:06 +0200
To:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <60dbaf22-226d-a2dc-2fbd-547f29da6887@web.de>
Date:   Thu, 29 Aug 2019 16:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:++WnNzneJmiUqaQDo/a7Jqi5KhFUbYMK7W4DMw/n3r/lyL/IzJa
 bMtPF4Y+pBTNLjsQhBChLA6CIpi1bhskEYbDzJNFzeeIItofEPtbmSjQ5Y+/VTkLy9PtPro
 9b8/06BuGTtsCQGNZhzPjwbOg0+esJyROZqQvjpDSFSe0z96VA4Z19tt5Pwagcmf6KMU5Tt
 wv5FWVNjWaXoW8oEGHqXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DVRlympRWJ8=:BGlFKUEsF/uNYKtOXOSobe
 nY8mpfYBz0SREZ/Vi7a670qu9hwrNuBCzEp5gMKTPPBXz/MVGn4ZUZ3uBBq0+Y6M8+RzMZWN2
 gTODTEue0itWRMNwrYLEwubyhB3VH/DCUURKIgwJY9PuH4030DVWA2IHa5rLpwhaYlTGPeXdb
 nAH8XjtyM7REDyZmV2M2sv9X3Bsu18S/PKN0qhmnAZfcW6WTpwCl5p+mXD6LdlZP9yIwg8vse
 l6787yzscofY3hYdvyrB88BHJsUz7sDen5FclOT/FnKhEgsmGZyToJyyW0UJNWCDLT2StOc+5
 Vqh9UlEkoGC0kvOQBiXhvyYhTiyn02DRFNCwXDsGNc+5jS+i1K+Nleo6a3dBE/HhTcJ6XF6FM
 YrcK2a6dvAxVsCZUBhPIG+VsG9uxGEnHrIHyPI5v7Z3m2oDKE9XWYupUSNZdjbptYw/VBtSk/
 3mspZ4+y8CwV4HKGoiwS77im8G6/xXn8VywHBaqDN8OMRIFxWVX+0nU0kUPuVIRcV6qFpq7po
 zfeGop7iR1UubOFpdpcs6LfeDok7kamJDRj8RNNjeinR5BIyjkz/V0wBxz8XC2zMYg9nQJbXM
 OfEa6kx/KvV/JHMi0ZgvzJdvbL5wnuVDkfAFWnJ2hgoFYQOlGHKoChVOJ34/9AqbLOZzEZf2f
 b+eAc9lJnNZ1lLv6mij1eaH/Mq6vCfLbgtyqG/D0d7NLZPAdWtSEUm1/GYOUJcdK5bP8rdPBE
 dBdtLYjhc6yRi4fsK/K00dHTUpPbIXcXS+y1pc9mpYMjxaXx4FCvnC78hkqCJ0ERI9LLGsqGn
 obH3wrpsqkt/uBulTl1TQv8C2mhJRte/U9mrUt+Zb0PQmtE40nFvlYQk+Ox+WTBuyX7w88w8W
 M2ciIdFIi2gEaOZ840oyeYyuC6ofqSb4BYnBE3AoGxXQyy9F3Jxw8HoHSVBjAeXEY81uFe08J
 fcjsVLKhxxV7poF+pqdXm/em0qX/kSGbI2KA4lhA/67jEfAamE7qzxg05puMeDjhetj2YXMKO
 pUBKD9IhjMiZ42Hyx7vQ2po29ExEyIUJZpI3UxJB402CkLwTOR4Pj0dXsYIruHcJFJHOF9EIa
 4CE3lBXJGAJPhHnourfRzAdj9UamZzEjMsMIPrTX/Vy0XOexuizF7z+GlLuysskonpXqt3jJe
 PScU30z882c6wU9oO0bhkhJ3rNix91jBUKRxGOtJgEd54E3w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +++ b/drivers/staging/exfat/exfat.h
> @@ -0,0 +1,973 @@
=E2=80=A6
> +/* file types */
> +#define TYPE_UNUSED		0x0000
> +#define TYPE_DELETED		0x0001
=E2=80=A6
> +/* time modes */
> +#define TM_CREATE		0
> +#define TM_MODIFY		1

Will it be helpful to work with enumerations at such places?

Regards,
Markus
