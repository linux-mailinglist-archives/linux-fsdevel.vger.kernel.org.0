Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF212E727
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgABONg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 09:13:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35892 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgABONf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:13:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so39378698wru.3;
        Thu, 02 Jan 2020 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ae5j7SkNQl3JPhQ5RUwHeVy0F/34DwcVNdDsaKuNKpM=;
        b=NpXArpnXe/W+XrixGJ+l44J8tWcn7Kg1ye66o0E8cFLDT8GFvYamZguXRBCE2c27VI
         FZbt8B0Uo6sAAjBOukf86blhUzyM4r35Th+arBvnc2YbZ7sRR5s6z3HLER5Xm7EEJgF2
         Y3w/7vo9T5rILwVH99odIpmIPdRSKJw/C8qESd58sVgzHGxaYNX2Rfo+BorGblUDxLn4
         r76l6nCz6sn6pGUrIYonEV5oqRbh4OT8kjBGAPJRy77tuVu5Brg6NfvPF7WCPqayj9XK
         MRHq1zywd3WFDzaaH9zx11aH3U5fEEng7FkCJUO+cohvCCyqjbOcc1dTlBOLVv+0TXnn
         BAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ae5j7SkNQl3JPhQ5RUwHeVy0F/34DwcVNdDsaKuNKpM=;
        b=m0+AIGq3TMMvCDZ8/hVTDNFkE1JKeAu65hHz/oCHzzPDiwkTzT0PnzJWl7CKzfjg/q
         5WpV5rShgqMZCoDg5JTN7NvG3MSM1xkQszE8bFFv8ymVRn1XnqQlvViLqUtvDWUde1Zj
         0yRD4SYRopcFAgjRX/4PGlDrQ7pINQ809JB7X06uDNBqOrtdqiA5x+O3oa3V2BTrsF6l
         pYF0b5fv/y8xAEym2sBVztJ4/4K1ln5LNz2p+UfetCwfAGzdufcktL8m7/QCQFvYA3eG
         13sL1vjiZGAVgjssy/3pxFG7w8UcP73Zxs6q9V9IF6cJYPwYHiV7cMSq8FTzeDi2OMWo
         /OLA==
X-Gm-Message-State: APjAAAXplYZUkaF2IZfzNbZPn8wLKu+k/tqjf7qwXK4wxjQrD0Vf9EPk
        3ziZrUXJA3KBSJtQwOKYT00=
X-Google-Smtp-Source: APXvYqyHTMsoc2dJ5aflQJBoQBf61+UZnoDdqXZWW/+wV9gv2YAZvyP6raUFxJtD4Qr0ai7K+6SyoQ==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr79749653wrn.283.1577974413990;
        Thu, 02 Jan 2020 06:13:33 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f17sm8688420wmc.8.2020.01.02.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:13:33 -0800 (PST)
Date:   Thu, 2 Jan 2020 15:13:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
Message-ID: <20200102141332.ibdj7gfwyyrfhkhi@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com>
 <20191229134025.qb3mmqatsn5c4gao@pali>
 <000701d5c132$bed73c80$3c85b580$@samsung.com>
 <20200102083029.uv2gtig3ski23dpe@pali>
 <20200102131659.r2lxzcyhvtgxmz7m@pali>
 <CAKYAXd_YHxRiFg=6m1eyXFmBWTXnEg4e-0VirNBS5q24Lz7jMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_YHxRiFg=6m1eyXFmBWTXnEg4e-0VirNBS5q24Lz7jMg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 22:41:40 Namjae Jeon wrote:
> 2020-01-02 22:16 GMT+09:00, Pali Rohár <pali.rohar@gmail.com>:
> > On Thursday 02 January 2020 09:30:29 Pali Rohár wrote:
> >> On Thursday 02 January 2020 15:06:16 Namjae Jeon wrote:
> >> > > > +static const struct fs_parameter_spec exfat_param_specs[] = {
> >> > > > +	fsparam_u32("uid",			Opt_uid),
> >> > > > +	fsparam_u32("gid",			Opt_gid),
> >> > > > +	fsparam_u32oct("umask",			Opt_umask),
> >> > > > +	fsparam_u32oct("dmask",			Opt_dmask),
> >> > > > +	fsparam_u32oct("fmask",			Opt_fmask),
> >> > > > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
> >> > > > +	fsparam_string("iocharset",		Opt_charset),
> >> > > > +	fsparam_flag("utf8",			Opt_utf8),
> >> > >
> >> > > Hello! What is the purpose of having extra special "utf8" mount
> >> > > option?
> >> > > Is not one "iocharset=utf8" option enough?
> >> > utf8 nls_table supports utf8<->utf32 conversion and does not support
> >> > surrogate character conversion.
> >>
> >> So in other words, this is just subset of UTF-8 just to 3 byte long
> >> sequences (for Unicode code points up to the U+FFFF).
> >
> > Anyway, this is limitation of kernel's NLS framework? Or limitation in
> > current exfat driver implementation?
> This is not exfat driver issue. Please check fatfs, cifs, etc..
> >
> > Because if it is in kernel's NLS framework then all kernel drivers would
> > be affected by this limitation, and not only exfat.
> Yes, FATfs also has two options and There seems to be
> CONFIG_FAT_DEFAULT_UTF8 option to avoid the issue you said.
> 
> config FAT_DEFAULT_UTF8
>         bool "Enable FAT UTF-8 option by default"
>         depends on VFAT_FS
>         default n
>         help
>           Set this if you would like to have "utf8" mount option set
>           by default when mounting FAT filesystems.
> 
>           Even if you say Y here can always disable UTF-8 for
>           particular mount by adding "utf8=0" to mount options.
> 
>           Say Y if you use UTF-8 encoding for file names, N otherwise.

I know that VFAT has two options for it, but I think this is historic
relict (backward compatibility). There are also other suspicious options
which today do nothing (e.g. cvf_format). So I would rather do not
compare it with 20 years old fat code...

But I have already looked at kernel's NLS implementation and it is
really limited to Unicode code points up to the U+FFFF. Kernel's wchar_t
type is is just for Plane-0 (u16) and all NLS encodings works with
wchar_t.

For "full Unicode" there is kernel type unicode_t.

And there is another thing, utf8 NLS encoding does not have defined
charset2upper/charset2lower tables.

So for iocharset=utf8 you really do not want to use utf8 NLS module.

But seem that above limitation for Plane-0 in kernel's NLS is not a
problem as all encodings (except utf8) fit into Plane-0. So only UTF-8
needs special handling, other encodings can use kernel's NLS tables.

> But the way you suggested looks better.
> 
> Thanks!

-- 
Pali Rohár
pali.rohar@gmail.com
