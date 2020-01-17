Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4708014096A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgAQL7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:59:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46122 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgAQL7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:59:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id 13so21907035oij.13;
        Fri, 17 Jan 2020 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEpbeENWmzxz4rGGPG2emBNNwpm/eUYhVctDWE6aqOA=;
        b=ClagO6lmFYVU4PjTVkAjUeiFz/iZJDASj1yHyrmIbXHJIpW0xyGpdvPsSABrkqWEYD
         U4Y60z60SdQg8EEUCx4/a9OobAGfsS3lM9W7NwaY5dOxvTYCxiKB9EJnclM2YQ+uD2un
         DCBTpv+jVAYpbFoXE2q6icaCHLpAJt2kv+Ig7MhSBvLgxW/iKXalJqJ7M3PXJo4Xpa2H
         bSOEePsokNBqXVlgrPUrrnmDu7bdyEPgphi8cWb9DTInRLIROAETn7fPAv9llKtNer4O
         EvwHCHEiOV4TYnNhoBHSi+sHDtu/GPBIFt7QXqLNzhoR4nqvF+THkMVuC+nJfu2sVgXe
         buHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEpbeENWmzxz4rGGPG2emBNNwpm/eUYhVctDWE6aqOA=;
        b=Z2NUM7u/PaKZU6Yjb4Il7p8fHmzLwHyw0wtqWBQaY0n5hfA7DAMnShGXmEi+Ekcu8g
         1wB1C/HFp0wgNV1/au4dBeB0Gygvw+Z5cOB0He24xn1Jzu7bW9LaAhQGYRUyEbZF3ppg
         6H+7R3m4fGliFGKuAp19yCsCzGjVbKiJuIjWsfgRE7h2SasRR0JY+PstroDIBOsvgaMp
         cS9OV5XDvWPtwL1f26dmVdMGkuP0zKzOT4/heo52BYLlbDsEMYokFkIgTwMkfmRG1ZQm
         zJD0MaeEzYyrCa3fWdgftLXardAVoMwghWFV5Kh5HZ91iveM8g9BcfwgQh4gXZaIpjY/
         eGCA==
X-Gm-Message-State: APjAAAUwFAF7DIi9i8zY9C/vNiNbke1LwBWce8GxjsR/ilMNx9fQ0Y4U
        HGMt1skLJ/SoiNBxoh5CCQ4Mcz0iCouoV+dw6JA=
X-Google-Smtp-Source: APXvYqwNPPeN5UZgmUnicJrQewCoV7WMpviMutktzeujCAP9/GQ1G6oTxNl2s9Rikfx5Lsn+VBGIu+OCrMIti+8Be44=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr3196649oib.62.1579262387623;
 Fri, 17 Jan 2020 03:59:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Fri, 17 Jan 2020 03:59:47 -0800 (PST)
In-Reply-To: <20200117091245.ginzffry7anqofju@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59@epcas1p1.samsung.com>
 <20200115082447.19520-12-namjae.jeon@samsung.com> <20200115093915.cjef2jadiwe2eul4@pali>
 <002f01d5cced$ba0828b0$2e187a10$@samsung.com> <20200117091245.ginzffry7anqofju@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Fri, 17 Jan 2020 19:59:47 +0800
Message-ID: <CAKYAXd9Gq33qxs=tQvg0v2qOUncDmM2wEeepeiC9Rv18ek56vQ@mail.gmail.com>
Subject: Re: [PATCH v10 11/14] exfat: add Kconfig and Makefile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Hi Pali,
>>
>> Could you please review updated description ?
>>
>> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
>> index 9eeaa6d06..f2b0cf2c1 100644
>> --- a/fs/exfat/Kconfig
>> +++ b/fs/exfat/Kconfig
>> @@ -15,7 +15,7 @@ config EXFAT_DEFAULT_IOCHARSET
>>         default "utf8"
>>         depends on EXFAT_FS
>>         help
>> -         Set this to the default input/output character set you'd
>> -         like exFAT to use. It should probably match the character set
>> -         that most of your exFAT filesystems use, and can be overridden
>> -         with the "iocharset" mount option for exFAT filesystems.
>> +         Set this to the default input/output character set to use for
>> +         converting between the encoding is used for user visible
>> filename and
>> +         UTF-16 character that exfat filesystem use. and can be
>> overridden with
>> +         the "iocharset" mount option for exFAT filesystems.
>
> Hello! This is much better. Fine for me.
Thanks for your review!
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
