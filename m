Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59E12E6DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgABNlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:41:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43020 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgABNlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:41:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so20688032oth.10;
        Thu, 02 Jan 2020 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9F6arg+1GHkDfvfkGXNTjMEzkXmAh86YzkPy0mDsP2g=;
        b=hn/OvXHr5zwXxonk1Y/MbRTLH/2tk4hCD5ykLHCwQu99jktnnB5kbrEcbk8Z4AlhtQ
         x8vCt1rjrHKIIrCnZFl2kON4rj3MRdq985dtFLZksY1a+aV4TkJajAePF134Vf50t0MF
         lAKaBKgu07zoHIOpRc9fxNshMpU0EEkb1IAy1KWTdxyTr+ifAzmwCKnZJ3k60u1mURak
         mOjaVLZ/Lbl3JFL0RB9yB7+iks1As5qN33ZPSdE4pmnJtyYKmLqbjPf+0DmCXgQc5tHv
         3C9Z3iNjZQoh6BnvZXs0Bf69xKM/mKvUJhqsIS9HCrzExBEEJN4zOIReNpHZetsu/9DR
         p/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9F6arg+1GHkDfvfkGXNTjMEzkXmAh86YzkPy0mDsP2g=;
        b=BRYZwWYyoCLVwT79cpzXXags5f7SDHknmJv02nC1F1HghzB/JTXEWqiVYUoEN1t9Jd
         7TNlXf4Q1RzpxVAWwguiFdWKqchb/fcZRJ5cd6z/dCEEVuwrmlUH7B0bj5Ds2+ZDKRGr
         A0JBtQuVUC/4MYzTNMtuVjHB4F3CxCUqoznO9L3FAacM9zGeXdcxSY5zDlQnm1iwALGL
         6n8P44xUl+AcybQPpkuWAdxRHD0UmITZQ4PG2LbN8InQcRszR83Gf4EfR4mRTjCqjaC3
         O0n1xURubl2UD2Zq57ZYx32x7MFmxtSCm6IaIJKez1Cu56C8BthFEgxxiCCbelf18ECv
         x3Sw==
X-Gm-Message-State: APjAAAWOX0O6Lvl3Db39opOum0e8OocELdpTF7WaorqZtIGbMTS+VYly
        zpBD6sf828DY6hCryQgOl0ZLi2fsTApBedEqcsA=
X-Google-Smtp-Source: APXvYqwM9X7I5gCcvZRgL4MVkeskmW4NqZB2bmNnQeGiPkBh9S4+ecPP2Wi3PIL/T+hDtNZAJRIKUgC3Kwap/d9zdYA=
X-Received: by 2002:a9d:6196:: with SMTP id g22mr95379977otk.204.1577972501544;
 Thu, 02 Jan 2020 05:41:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 05:41:40 -0800 (PST)
In-Reply-To: <20200102131659.r2lxzcyhvtgxmz7m@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com> <20191229134025.qb3mmqatsn5c4gao@pali>
 <000701d5c132$bed73c80$3c85b580$@samsung.com> <20200102083029.uv2gtig3ski23dpe@pali>
 <20200102131659.r2lxzcyhvtgxmz7m@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 2 Jan 2020 22:41:40 +0900
Message-ID: <CAKYAXd_YHxRiFg=6m1eyXFmBWTXnEg4e-0VirNBS5q24Lz7jMg@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] exfat: add super block operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-02 22:16 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> On Thursday 02 January 2020 09:30:29 Pali Roh=C3=A1r wrote:
>> On Thursday 02 January 2020 15:06:16 Namjae Jeon wrote:
>> > > > +static const struct fs_parameter_spec exfat_param_specs[] =3D {
>> > > > +	fsparam_u32("uid",			Opt_uid),
>> > > > +	fsparam_u32("gid",			Opt_gid),
>> > > > +	fsparam_u32oct("umask",			Opt_umask),
>> > > > +	fsparam_u32oct("dmask",			Opt_dmask),
>> > > > +	fsparam_u32oct("fmask",			Opt_fmask),
>> > > > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
>> > > > +	fsparam_string("iocharset",		Opt_charset),
>> > > > +	fsparam_flag("utf8",			Opt_utf8),
>> > >
>> > > Hello! What is the purpose of having extra special "utf8" mount
>> > > option?
>> > > Is not one "iocharset=3Dutf8" option enough?
>> > utf8 nls_table supports utf8<->utf32 conversion and does not support
>> > surrogate character conversion.
>>
>> So in other words, this is just subset of UTF-8 just to 3 byte long
>> sequences (for Unicode code points up to the U+FFFF).
>
> Anyway, this is limitation of kernel's NLS framework? Or limitation in
> current exfat driver implementation?
This is not exfat driver issue. Please check fatfs, cifs, etc..
>
> Because if it is in kernel's NLS framework then all kernel drivers would
> be affected by this limitation, and not only exfat.
Yes, FATfs also has two options and There seems to be
CONFIG_FAT_DEFAULT_UTF8 option to avoid the issue you said.

config FAT_DEFAULT_UTF8
        bool "Enable FAT UTF-8 option by default"
        depends on VFAT_FS
        default n
        help
          Set this if you would like to have "utf8" mount option set
          by default when mounting FAT filesystems.

          Even if you say Y here can always disable UTF-8 for
          particular mount by adding "utf8=3D0" to mount options.

          Say Y if you use UTF-8 encoding for file names, N otherwise.

But the way you suggested looks better.

Thanks!
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
