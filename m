Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3317D19F0BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDFH1P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 6 Apr 2020 03:27:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgDFH1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:27:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id x11so14297108otp.6;
        Mon, 06 Apr 2020 00:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZNGhaP+QG4HxousMGWitkhhXTfkQsmbM3E23YiyjtWU=;
        b=qNMR0HY3bhjJ61VYibicSCfhlHXHmY/03wzI8tKChBrTxrvedMNkByNUL784Jaap8C
         xtREEmQP11dEP1jtkxZSqiMh66hgE6JP9jPkFIxwBfRiT7esqf8pRvfSL9JKZU1gvvLc
         h6cq7D3pU+q+FO0O8vuD56izHhli3pUCxiMNVuAGly0WMcpZFuRF5quA34KDRGOWwGDd
         vJKO+3zG62VRmzaBdfhERT6Clpgjk1XYqRh1/x3120lRilSaskMl28Y2mGhinyFB2mWT
         MFniSVHehZ+5myJRDxqnwOXcTjxao/Lj+AF6gqE7LCDn+XUJn9vOjW8hOUEpxVa6wcOR
         nzzw==
X-Gm-Message-State: AGi0PubX7jdD2dhKWI8Bwo5I1JzhTFCVOHI1aacoX+ZuBvaX6L+KuG1t
        z+I7P32Fyo0d9J1iFmjvFIlkT7nXiBMdM/8EY9Y=
X-Google-Smtp-Source: APiQypLoUcs5r963YYsffOMrgIHvA8vqsOhLURk+ZBO2lVrs1QldVOrkf3fGGpyKv3foSgjdb433PtNsABTO/LJevvY=
X-Received: by 2002:a05:6830:15c2:: with SMTP id j2mr15644001otr.107.1586158032516;
 Mon, 06 Apr 2020 00:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200302062625epcas1p200c53fabe17996e92257a409b7a9c857@epcas1p2.samsung.com>
 <20200302062145.1719-1-namjae.jeon@samsung.com> <20200302062145.1719-12-namjae.jeon@samsung.com>
In-Reply-To: <20200302062145.1719-12-namjae.jeon@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Apr 2020 09:27:01 +0200
Message-ID: <CAMuHMdXdGDnvGYi1v1OhjCz=61moVRZQdZOtiKLG3m8q7vwkTg@mail.gmail.com>
Subject: Re: [PATCH v14 11/14] exfat: add Kconfig and Makefile
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linkinjeon@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae,

On Mon, Mar 2, 2020 at 7:28 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
> This adds the Kconfig and Makefile for exfat.
>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This is now commit b9d1e2e6265f5dc2 ("exfat: add Kconfig and Makefile").

> --- /dev/null
> +++ b/fs/exfat/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config EXFAT_FS
> +       tristate "exFAT filesystem support"
> +       select NLS
> +       help
> +         This allows you to mount devices formatted with the exFAT file system.
> +         exFAT is typically used on SD-Cards or USB sticks.
> +
> +         To compile this as a module, choose M here: the module will be called
> +         exfat.
> +
> +config EXFAT_DEFAULT_IOCHARSET
> +       string "Default iocharset for exFAT"
> +       default "utf8"
> +       depends on EXFAT_FS
> +       help
> +         Set this to the default input/output character set to use for
> +         converting between the encoding is used for user visible filename and
> +         UTF-16 character that exfat filesystem use, and can be overridden with

exFAT

> +         the "iocharset" mount option for exFAT filesystems.

I think the above paragraph should be reworded.
I tried to do it myself:

          Set this to the default input/output character set to use for
          converting between the encoding that is used for user visible
          filenames, and the UTF-16 character set that the exFAT filesystem
          uses.  This can be overridden with the "iocharset" mount option for
          the exFAT filesystems.

but then I got puzzled by the _3_ encodings that are part of it:
  1. the default input/output character set to use for conversion,
  2. encoding that is used for user visible filenames,
  3. UTF-16 character set that the exFAT filesystem uses.
I assume 1 == 2, but there may be more to it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
