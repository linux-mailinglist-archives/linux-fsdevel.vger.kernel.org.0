Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AF138404
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgAKXfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 18:35:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbgAKXfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 18:35:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id z64so5195928oia.4;
        Sat, 11 Jan 2020 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6nsqiMT9oMX01YJWr2NQaCFjUFg9E87lTHlKtmL/4JU=;
        b=jyDXLARC4k7VXdXWwWGocAv7u6XXI1C3kObhkXU7msPtMaC1AKSSX4qoZ0+hHGbEEc
         p6Q47yLsjt0o0908SGKRRiYTgx7Kub3t3oQzIqOIVPPQug++rKL5LoTHOWOwIFghzq/k
         tYjl79RptnOa38hS8LUdT0vnkZT5x4rm1pIvnpvYDQbpnLhEImOg5laNAV9ZMvMjAON0
         cnElF3OTMOvoyORRpX+GuclcTSdWeW4N5YGjGKnz1aNqWMkFzXyKMwqE+f+wyKWBISD+
         ArrhJdFnr2tNZbrrvqig3m9jjav2i/WRE1XpdXJVxNnJTGeawQqwheVAwpaojgoWW2Zf
         OrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6nsqiMT9oMX01YJWr2NQaCFjUFg9E87lTHlKtmL/4JU=;
        b=brYZVtfy0RJmYfgYAsa3nmz0HtHY3/Dc9cMXxgf8JxGfWfUlWDL5gDyzTOfoqegl/t
         JVlG8GoRAiito0AeXdjM0F7u7moYXgesaJJFgYoxD3FOQiKDXsfmJ/J9TbLNZPsLGANk
         jVEbgFR1sGAvVP32o3IZKE2bhULO6vvHGUlWsGf79O8fOZwh658i+qCpOSAm0QkaGADe
         quSkwsEaptB8iC2eRtJ8qAaIOhM83n+Xtd40oJGxeDd7Pac6C4GygEWTST3lHsrEHHQs
         RTjKdDJsx9XgvAUKmCwUaZzY0Ance20z5KITC5SMYC/c4YMj4c//r4ihdSWG3+ff2KZ+
         6RrQ==
X-Gm-Message-State: APjAAAWT/cm2WtHTgMPd2kiUx99nAIP3xUNnQNZ8XVa5EMPxKkzpavAw
        qBT2blcLHxqVGPIeKRaBnD141w1nXpixb9h2xQH/5w==
X-Google-Smtp-Source: APXvYqyUB0xeTnDpzHjEuZdGxoOL5/li0WIDrMMHdo+U4FwFwZTbhGAUZVZRm78WL5ug4KSpmT9xG14s300ZUTE+3dk=
X-Received: by 2002:a05:6808:a11:: with SMTP id n17mr7456835oij.94.1578785721361;
 Sat, 11 Jan 2020 15:35:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Sat, 11 Jan 2020 15:35:20 -0800 (PST)
In-Reply-To: <20200111175611.GA422540@kroah.com>
References: <20200111121419.22669-1-linkinjeon@gmail.com> <20200111175611.GA422540@kroah.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Sun, 12 Jan 2020 08:35:20 +0900
Message-ID: <CAKYAXd-+o-cmn17r0Z-k9gmrQW=8Pj_PDFNvG+jP8eCSPDbV9Q@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: make staging/exfat and fs/exfat mutually exclusive
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        Namjae Jeon <namjae.jeon@samsung.com>, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-12 2:56 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Sat, Jan 11, 2020 at 09:14:19PM +0900, Namjae Jeon wrote:
>> From: Namjae Jeon <namjae.jeon@samsung.com>
>>
>> Make staging/exfat and fs/exfat mutually exclusive to select the one
>> between two same filesystem.
>>
>> Suggested-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
>> ---
>>  drivers/staging/exfat/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/exfat/Kconfig
>> b/drivers/staging/exfat/Kconfig
>> index 292a19dfcaf5..9a0fccec65d9 100644
>> --- a/drivers/staging/exfat/Kconfig
>> +++ b/drivers/staging/exfat/Kconfig
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  config STAGING_EXFAT_FS
>>  	tristate "exFAT fs support"
>> -	depends on BLOCK
>> +	depends on BLOCK && !EXFAT_FS
>
> There is no such symbol in the kernel tree, so this isn't going to do
> anything :(
>
> When/if EXFAT_FS does show up, I will be glad to add this.  Or better
> yet, just have this as part of the "real" exfat patchset, that would
> make the most sense, right?
Right,
Thanks!
>
> thanks,
>
> greg k-h
>
