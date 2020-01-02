Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99AF12E660
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgABNNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:13:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33319 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgABNNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:13:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so12768631oie.0;
        Thu, 02 Jan 2020 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9QcNKEGDiVHTxJaK9sSzJDKZz/8tGzml6xrrUnRcC94=;
        b=DNR98hYT9md7ibZzsf9cAHpaUhqIkw6rzfrvVCQnyhjys9mXDaxNYjMkoKaiCf/8xV
         sF/2eNukwqj4A4uV/9LRCWxUJnCqmZxJ+sKTgYPD5Gw5iG9QRrTDEpEQBuC6n0ZvumFe
         RkQ0Cpkm5gu1sspOyH+C7+wtYnudr3LYA9SfSZA23VSbq1yEiboHbiva+zBFOYBlqzcg
         bmhc7LIkzw13ELHo822ShA49LOz7NUh46ZOxzsiTlwwG/jcZ6fpsKg/9csyVxofHLMXg
         J12zmFqTeV+0UzM7W+pXK6HNTwO3G7WlKh73QCFTz7SswKPKsCcD8GV0iXvah3ho/BoQ
         /9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9QcNKEGDiVHTxJaK9sSzJDKZz/8tGzml6xrrUnRcC94=;
        b=Wg/rb255qmSedlvRfJ0bcp1ioz0woKTMO01+hB+6NgvvlQForYSokKQt2q5eqMU1lI
         lDes9rzavcybjMpYuC9nS95sZERBcviNKmjSsGNTliSv41yK6GIY2FGZeM75GhG0d04n
         y+4YwiElcN1Zi2nZBHY/4BZ6tFkz/gws0gVjbWkhq60wEATH8YfW5q7zf7Qdl6M1z0hU
         HxgCxUBQqhqU6KpEih+FPw+6Z7VO1vS7vLqtN635MPFMmCuYZJWVnLodEZYiTzXRfuyS
         CYGoFIeBhrRtouWeiWZUC5cnLPh8HjGc9gJaZANCxvRcC8jf0pOY1NPsb4KVulp32S2r
         V2Tw==
X-Gm-Message-State: APjAAAU9pA22SyMRjly7Nr16w+3tdDqR1f9jcOBXIP77Z7A3MpbMT2db
        dGiBUUKWmd8EBtOvvzfPylMs+9/y7NpoURrrqew=
X-Google-Smtp-Source: APXvYqwPehMWtJxpOaaDSRC5EVqb7sCbG3k7EcqpXmvX7UerLZdVhfLa0kbWa6l+HdzzZAWcAWnCyf7PZl2YIf0XRNo=
X-Received: by 2002:a05:6808:a11:: with SMTP id n17mr1949987oij.94.1577970831213;
 Thu, 02 Jan 2020 05:13:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 05:13:50 -0800 (PST)
In-Reply-To: <20200102083029.uv2gtig3ski23dpe@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p31665a3ae968ab8c70d91a3cddf529e73@epcas1p3.samsung.com>
 <20191220062419.23516-3-namjae.jeon@samsung.com> <20191229134025.qb3mmqatsn5c4gao@pali>
 <000701d5c132$bed73c80$3c85b580$@samsung.com> <20200102083029.uv2gtig3ski23dpe@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 2 Jan 2020 22:13:50 +0900
Message-ID: <CAKYAXd-CUyC9vTLH7ANumLxrAQCmb8Xi=2v4-uotLFBuxf_+Cw@mail.gmail.com>
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

2020-01-02 17:30 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> On Thursday 02 January 2020 15:06:16 Namjae Jeon wrote:
>> > > +static const struct fs_parameter_spec exfat_param_specs[] =3D {
>> > > +	fsparam_u32("uid",			Opt_uid),
>> > > +	fsparam_u32("gid",			Opt_gid),
>> > > +	fsparam_u32oct("umask",			Opt_umask),
>> > > +	fsparam_u32oct("dmask",			Opt_dmask),
>> > > +	fsparam_u32oct("fmask",			Opt_fmask),
>> > > +	fsparam_u32oct("allow_utime",		Opt_allow_utime),
>> > > +	fsparam_string("iocharset",		Opt_charset),
>> > > +	fsparam_flag("utf8",			Opt_utf8),
>> >
>> > Hello! What is the purpose of having extra special "utf8" mount option=
?
>> > Is not one "iocharset=3Dutf8" option enough?
>> utf8 nls_table supports utf8<->utf32 conversion and does not support
>> surrogate character conversion.
>
> So in other words, this is just subset of UTF-8 just to 3 byte long
> sequences (for Unicode code points up to the U+FFFF).
>
>> The utf8 option can support the surrogate
>> character conversion of utf16 using utf16s_to_utf8s/utf8s_to_utf16s of
>> the nls base.
>
> So this is full UTF-8 support, right?
>
> And what is the point to have two options for UTF-8 support, when one is
> incomplete / broken? I see no benefit to have first option at all.
> Providing incomplete / broken support to userspace does not make much
> sense if we already have full and working support via different mount
> option. Maybe second option with full UTF-8 support should be used also
> by iocharset=3Dutf8 and then we do not need utf8 option at all?
Make sense. I will make it one option.

Thanks!
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
