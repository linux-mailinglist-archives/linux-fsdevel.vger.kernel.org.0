Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2843AA31B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 09:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfH3H4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 03:56:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfH3H4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:56:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so6283697wml.0;
        Fri, 30 Aug 2019 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pzjr7IHiDTSGbuYdOJZ1L0KgTpVtEtYyO9Tpe0cPJug=;
        b=NtVlF12toJ1KoXMdiq99sxClGtZEzzFmf0XNJHYt0HTv3nvOdbK88TVUbzZ24Ze0Cu
         rAE0nDAKKiyckW4pbD2kQdZGNHArvwdSwRGxsdoltWwo5B0vGzRTV4Ca36sAdHEP+mcv
         3jttKn0nj73Az4MoDZ4k2pkh9gnJgF+j6zNI5wlDvgaqu5Y6h5zzT49MKm+aCFGcsThk
         U013AU29RAjFJ0g62c99AIM86GDG1qudks0pzraKP6AHCRebJGi1JRJXHqajAbcHPC1+
         RrzaN+cGYIEU9zrcHYjWS03AT2vyxkaLXSkxtEV3UGrSpwwia2E+m8elKQSIWtU6Yhp8
         vOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pzjr7IHiDTSGbuYdOJZ1L0KgTpVtEtYyO9Tpe0cPJug=;
        b=A7Oq1Vbj4rrppyCysOfopyhxnMIp+NDsXzi++wsELzDT+IIBCJc6Ji50YXZ8FyDSJs
         diWEFSTyNieCGSUNi+LWSPofRO01ionlQKoZ54IdifnJiUY16l18btevdPB6lRse7N/+
         cspUOajXWnOgKY2LzB66wlv5kS13oqZgO4MnKdhOS7KvjFMXh6wO445NG2QVNMmQxFUX
         6+9AtpDHDRJfjt+D1sMs636khN+17lBeASce4AQAnQcEVUbZ+11Jc3Tm9jDz6CiRhEGy
         JBbMN0JqdjtWl1eFkOh44lPCN1zqvjHiA0TglHu1JkBrG18b1JPxzzYcuoIzi3cQ+7WA
         0khA==
X-Gm-Message-State: APjAAAVRN9z5DL8JTWTDn7KWpj+p9ZOX0yvrLFEi8Xl9olCueglvaPM1
        Vl3xFALjVhUv2Fst0uc5+MMr9Kt09hI=
X-Google-Smtp-Source: APXvYqwWMhz6AYO79cLTfS4NU4cvhssRYhUgKGpZd5SwJOl1epDbyaSO+NOuQGPbFztqXTq0jw2Z7g==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr6972934wmm.75.1567151809265;
        Fri, 30 Aug 2019 00:56:49 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u128sm1610168wmg.34.2019.08.30.00.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 00:56:48 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:56:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830075647.wvhrx4asnkrfkkwk@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829233506.GT5281@sasha-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, thank you for input!

On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
> On Thu, Aug 29, 2019 at 07:18:16PM -0400, Valdis Klētnieks wrote:
> > On Thu, 29 Aug 2019 22:56:31 +0200, Pali Roh?r said:
> > 
> > > I'm not really sure if this exfat implementation is fully suitable for
> > > mainline linux kernel.
> > > 
> > > In my opinion, proper way should be to implement exFAT support into
> > > existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
> > > new (now staging) fat implementation.
> > 
> > > In linux kernel we really do not need two different implementation of
> > > VFAT32.
> > 
> > This patch however does have one major advantage over "patch vfat to
> > support exfat" - which is that the patch exists.
> > 
> > If somebody comes forward with an actual "extend vfat to do exfat" patch,
> > we should at that point have a discussion about relative merits....
> 
> This patch going into staging doesn't necessarily mean that one day
> it'll get moved to fs/exfat/. It's very possible that the approach would
> instead be to use the staging code for reference, build this
> functionality in fs/fat/, and kill off the staging code when it's not
> needed anymore.

So, if current exfat code is just going to be "reference" how to
implement exfat properly in fs/fat, is this correct usage of "staging"?

I was in impression that staging is there for drivers which needs
cleanup as they are not ready to be part of mainline. But not that it is
for "random" implementation of something which is going to be just a
"code example" or "reference" for final implementation which would be
different.

Maybe other people could clarify state of staging, if this is how
staging should be used or not.

> With regards to missing specs/docs/whatever - our main concern with this
> release was that we want full interoperability, which is why the spec
> was made public as-is without modifications from what was used
> internally. There's no "secret sauce" that Microsoft is hiding here.

Ok, if it was just drop of "current version" of documentation then it
makes sense.

> How about we give this spec/code time to get soaked and reviewed for a
> bit, and if folks still feel (in a month or so?) that there are missing
> bits of information related to exfat, I'll be happy to go back and try
> to get them out as well.

Basically external references in that released exFAT specification are
unknown / not released yet. Like TexFAT. So if you have an input in MS
could you forward request about these missing bits?

Also, MS already released source code of FAT32 kernel driver
(fastfat.sys) and from code can be seen that it does not match MS FAT
specification, and include some "secret sauce" bits. Source code is on:
https://github.com/microsoft/Windows-driver-samples/tree/master/filesys/fastfat

In fastfat.sys there is e.g. usage of undocumented bits in directory
entry or usage of undocumented bits for marking filesystem as "dirty" --
incorrectly unmounted.

Would it be possible for MS to release in same way code of exFAT NT
driver? I'm really a bit sceptical that exFAT MS implementation is
really according to standard as I already known that FAT32 is not.

Just to note that I did some investigation in FAT32 level how are
handled volume labels and I found more bugs in current implementations
(mtools, dosfstools, util-linux and even in fastfat.sys). Some
references are on: https://www.spinics.net/lists/kernel/msg2640891.html

Fixes for mtools, dosfstools and util-linux were already applied and fix
for MS's fastfat.sys is pending in opened pull request:
https://github.com/microsoft/Windows-driver-samples/pull/303

Could you please forward my pull request for fastfat.sys fixes to
appropriate people/team in MS?

-- 
Pali Rohár
pali.rohar@gmail.com
