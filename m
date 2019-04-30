Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77150F253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfD3I5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 04:57:05 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33672 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3I5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:57:05 -0400
Received: by mail-ua1-f67.google.com with SMTP id x6so1889991uaq.0;
        Tue, 30 Apr 2019 01:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puIGi24wIuf2ssUhgOZZ8q3Cgq96WU+0YjV2qSEyOwM=;
        b=TOwr+mF3P76j8efYf/G36PVSbv8YRXCVnhIQorjfb6fZgSjqYvgut0UF75WCpq6ONL
         2P7vANvwPC/n6lvZcXR65ErPkjcvItsk4WemLeONvm93yBFUV6s8DTNJNp+0m1ov0KCs
         GZLuL21j30ocCwOTcRABumZXtOl7mKIGsG09kOCSXQ0p5h59IwNH4g+teNAosFalAEsQ
         0bp836215e1KTIViStJrtHtKJu6N38jADOHql/ChjLTXmZV/gNOKOOnEjZV7+lXQMC3+
         RzPQSMqBV9TRxRXxhGl4NN6pKf7xWmlyvhcrSrb3cEPcKAgOUU44V8wgEeR7R+qV6jvO
         tbAQ==
X-Gm-Message-State: APjAAAWsQdIIwRZ1xF0Y9pYZtPcK5XhSHmqt8EMnJ4RPkaYsIl273oxu
        OFTxjtFj2TFB510S2RVfw//kYn0LTWC5Npyy6GYKSg==
X-Google-Smtp-Source: APXvYqw2REY+7n7OPJYnYhgdtq2cSjs4nK9bZYrSZtQZ0ZPJsCDtzuYCmn5jgCzzc62pE0P7Sb8R4WoQCNIYwDJBZi8=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr34011934uao.86.1556614624152;
 Tue, 30 Apr 2019 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190401115357.28734-1-geert@linux-m68k.org>
In-Reply-To: <20190401115357.28734-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Apr 2019 10:56:52 +0200
Message-ID: <CAMuHMdUFEpHdx9O4oi4_d_3OiqZCTKaReGjkb+M_kYf=g2eT7Q@mail.gmail.com>
Subject: Re: [PATCH] fs: VALIDATE_FS_PARSER should default to n
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Mon, Apr 1, 2019 at 1:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CONFIG_VALIDATE_FS_PARSER is a debugging tool to check that the parser
> tables are vaguely sane.  It was set to default to 'Y' for the moment to
> catch errors in upcoming fs conversion development.
>
> Make sure it is not enabled by default in the final release of v5.1.
>
> Fixes: 31d921c7fb969172 ("vfs: Add configuration parser helpers")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Ping?
Final release of v5.1 is imminent.

> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -10,7 +10,6 @@ config DCACHE_WORD_ACCESS
>
>  config VALIDATE_FS_PARSER
>         bool "Validate filesystem parameter description"
> -       default y
>         help
>           Enable this to perform validation of the parameter description for a
>           filesystem when it is registered.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
