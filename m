Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F40371E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfFFKlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 06:41:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41996 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfFFKlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:41:31 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so1400837ior.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZz9VH+++n/ml8QwihoeTjKhf7ccky00th8eHkY3Vfc=;
        b=oot9uwD2GIpRoIuiprplBae2RMkW7KHHuPXHbgBj1Zt1IPLHAzmAkeTV2A8L3H6kbE
         VMITsJ3j1aP5tPlEBV5gwgwKMPxdeZziwToVkctXyoxGl+yY0AkPbnIWvUYup80/H0NX
         HFoxUK484DU5KeF4HHdJL4D9xn0wDWMZaZ67j3I91i/b5sOYSmRAxdvpR7Be07dZftDk
         IahAOMUqupe11t5rWpUgRweVeJ2OZQAzrW1KnW7Nk/R4ZcGRq9MY3VbhmMg1r82MfFHZ
         9rCjSz5txBMtwphptFvApsmk9GG73EU0SgZk56kRNPbypGjefr5xI3xEwJwvhjetPsUx
         Uamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZz9VH+++n/ml8QwihoeTjKhf7ccky00th8eHkY3Vfc=;
        b=WWwuaHiAB3rpph9UpsU1Gq1b5jJdvqPiKblJZZWIyRKgqeK/vM2AYaprIXMMKkdQ1K
         4yvtIC0ffykMD7gTmPY9bJmhGA7CRFhI2VxqWFNIaugrXdjgDLJULWXdCOjxHkRVCR9M
         vHGtQYRCuw8OeW6RJXeChOXeA0bCvLMGW7nO2k815rFU/crFeoBzcyPAEqvDWqJGLLMh
         B2mOq7/mJUhAMyFWIpO0dHjwurOcXWnows0L/vlcCGgFLWz0myqWGe/WgIo7ti/0QRkH
         SvLJulgexYweYQMqd9/PrevaWGCZSGKxDjLmRpNOrz634NBPs4ubfGiqTb7Jd+1dPvgQ
         +CMQ==
X-Gm-Message-State: APjAAAWK29QkSv3JKR9Artlnnumdg4XZeyDQrXGgdld3UKIxR9rsjhm2
        GfzmyTo3rU8Lkfrc2WErXUgoW6O8L9dd5X8woocJAQ==
X-Google-Smtp-Source: APXvYqwaJmD1w0iqf+JJabWNMhpH1dQz4fhXhzeUXTh/S05TOrPkTAmbtOEly66HV1vfKvkRhB1R5D3CqSbES520EyU=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr25670814ion.65.1559817690897;
 Thu, 06 Jun 2019 03:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190604233434.nx5tXmlsH%akpm@linux-foundation.org> <a4bfdf4c-de88-31a2-8f8d-f32c1ebdbd02@infradead.org>
In-Reply-To: <a4bfdf4c-de88-31a2-8f8d-f32c1ebdbd02@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 12:41:17 +0200
Message-ID: <CAKv+Gu9=b1ewM8p9y8T7zCiQi=qYEA-webkFns-hg5rhu6=26g@mail.gmail.com>
Subject: Re: mmotm 2019-06-04-16-33 uploaded (drivers/crypto/atmel)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 Jun 2019 at 20:56, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 6/4/19 4:34 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-06-04-16-33 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
>
> (problem seen in mmotm, but this is not an mmotm patch; it's from linux-next)
>
> on x86_64:
>
> ld: drivers/crypto/atmel-i2c.o: in function `atmel_i2c_checksum':
> atmel-i2c.c:(.text+0x1b): undefined reference to `crc16'
>
> because CONFIG_CRC16=m and CONFIG_CRYPTO_DEV_ATMEL_I2C=y.
> The latter selects the former.
> I don't know how to make CRC16 be builtin in this case. ???
> I changed the 'select' to 'imply' but that didn't make any difference.
>
> Full randconfig file is attached.
>

CONFIG_CRYPTO_DEV_ATMEL_I2C was lacking the 'select' entirely, but it
has now been added (as a fix to the crypto tree)
