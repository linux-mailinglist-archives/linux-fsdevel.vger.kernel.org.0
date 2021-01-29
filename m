Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4B308542
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 06:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhA2Fd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 00:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhA2Fdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:33:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B7C061573;
        Thu, 28 Jan 2021 21:33:13 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 16so8123153ioz.5;
        Thu, 28 Jan 2021 21:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7AOsWbJq4kXN8Mk4kn1DaUkid6WA7Y0hq382eyltmJA=;
        b=tfbrIjR8f4W8//+e6+mYd5f4VQoKRqqj1BeJtQfwhUp8dnYcCGI51hJeaQ9DSEd5ol
         WJ7JdZ/lGKZQ5ye8jffDYc/TQLkGZdDtUM3wjctSox0aCTsh/LFek+S+icwWuJAif45Z
         pL2iTUs6ioSeJklcfZfuvqf1R2QrIWKHozEONUp5r8A8/P6XxFrVks3AZbM7kWRUzt6Z
         uo0J+abdHrmeib153qybO5i8RRklcKSWRWMynKHkANNEP/4gIMdIjV+oIoQEUEDLO1QX
         jMdHHGNIGEgWMGAHH8mRUTnXCiIjx88XYGJJKVAtJzhmpWouDUPH57L0tPcHgGA3WTAO
         pDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7AOsWbJq4kXN8Mk4kn1DaUkid6WA7Y0hq382eyltmJA=;
        b=fl4jhNwIfWdNk/Khx2JYd72FaiYdYpvq/dnyZ2UCuJoSVSSaAPr44TORIJdLVrXvMu
         qIuyvuOL2n/m2PNWOea02CI9g7F4Lum1LxOYuwrEGxa8KeH8iIWjiGZ9dTE2qCJtd8zd
         kf2zGmz86Zg17yK2tRazXAopIdTr+Qr4XLDhR8zHeRlgevOdgpwlGA7nNh9p3LmCcqLx
         HwJlDG+QQ5A+lNKFza+4vuFJJ3x6zScV1aM3wUMZx83UfAygf2T1JdUmpD7OR6wFZdMN
         YbFA0+nRtUI4bmlXTycjtD7Nd9cR4YxvWGNoAkWucKfAfgaUAn1kwS2Xuy/7uAlzBPyw
         t16w==
X-Gm-Message-State: AOAM531FQk5SlZSo6t+tuGi9uJ7YDRmrgkW3g6iHUW1Ihlrestl9FkA5
        7eg5u7idrvLWOoGmOsiWGjlX/CmNMKK22ZtqUtk=
X-Google-Smtp-Source: ABdhPJzdPDRzWcjM3sIpd5IJ4u5Uz+GAFJkhMVB+D9UvIU/Geey1C7tx+qO8QaF17jzGjQjw+a3U6qq614XDEIRv1WM=
X-Received: by 2002:a6b:b50a:: with SMTP id e10mr2546538iof.50.1611898392315;
 Thu, 28 Jan 2021 21:33:12 -0800 (PST)
MIME-Version: 1.0
References: <1611817947-2839-1-git-send-email-bingjingc@synology.com>
 <20210128105501.GC3324@quack2.suse.cz> <20210128141856.GX308988@casper.infradead.org>
 <82e0e4d1-efd0-46d9-aee2-61288efcc3ed@Mail>
In-Reply-To: <82e0e4d1-efd0-46d9-aee2-61288efcc3ed@Mail>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Fri, 29 Jan 2021 13:33:01 +0800
Message-ID: <CAMmgxWGY9SAsKRj4u7qZr=-tjO2+gcbJ9TeME1hwk_ajJFTW0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] handle large user and group ID for isofs and udf
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, jack@suse.com, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cccheng@synology.com, robbieko@synology.com, rdunlap@infradead.org,
        David Howells <dhowells@redhat.com>,
        bingjingc <bingjingc@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan & Matthew,

Thank you for your kind notices and comments. Please see my message
below.

bingjingc <bingjingc@synology.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [loop bxxxjxxg@gmail.com] in order to reply in plain-text
>
> Matthew Wilcox <willy@infradead.org> =E6=96=BC 2021-01-28 22:20 =E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Thu, Jan 28, 2021 at 11:55:01AM +0100, Jan Kara wrote:
> > On Thu 28-01-21 15:12:27, bingjingc wrote:
> > > From: BingJing Chang <bingjingc@synology.com>
> > >
> > > The uid/gid (unsigned int) of a domain user may be larger than INT_MA=
X.
> > > The parse_options of isofs and udf will return 0, and mount will fail
> > > with -EINVAL. These patches try to handle large user and group ID.
> > >
> > > BingJing Chang (3):
> > >   parser: add unsigned int parser
> > >   isofs: handle large user and group ID
> > >   udf: handle large user and group ID
> >
> > Thanks for your patches! Just two notes:
> >
> > 1) I don't think Matthew Wilcox gave you his Reviewed-by tag (at least =
I
> > didn't see such email). Generally the rule is that the developer has to
> > explicitely write in his email that you can attach his Reviewed-by tag =
for
> > it to be valid.
>
> Right, I didn't.

Sorry, I don't know how Reviewed-by tag works in emailing code review
procedures. Thank for talking me the rule. I drop Matthew's Reviewed-by
tag in the third patch.

>
> Looking at fuse, they deleted their copy of match_uint
> in favour of switching to the fs_parameter_spec (commit
> c30da2e981a703c6b1d49911511f7ade8dac20be) and I wonder if isofs & udf
> shouldn't receive the same attention.

That's true. New mount API can handle uint_32 by fs_parse.
It may take a little larger coding and review works converting isofs and ud=
f
to use the new mount API. And we also want these fixes can be also applied
back to previous stable kernels. So we'd like to submit this patch to solve=
 the
iso image mounting bugs first.


Thanks,
BingJing
