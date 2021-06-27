Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9043B53E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jun 2021 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhF0OxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhF0OxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:53:05 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D6C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Jun 2021 07:50:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a14so11572578oie.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Jun 2021 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bmsKv1KnXmsYwtGJMPUHBcsdr0nGhadkSK4wYbQk+40=;
        b=t9YKwdqE93MSWLdnQuFtd8lY685bfMo1FhiEn63z1IgBa92gRLF58mHTbmGaUnWLel
         qfFrePtDYv0SqAcxMs+O35X2Wl/wRbtnZWSczGQLZ4+qrIW73ptEqplKkr9cWqb9xC5J
         8ZHxV5EgpVNq+o2NoYgQS2B1fDnkA8uox++hcRZ8bYBQSWBFPwGhDE8zmR0LUjrxoxt9
         qLzfd8WBifTT6jTs3RbwejLOs/yZEQEGeAyVTACdh7uj6KLHJCoXRQSSWO1ZlPUX5frB
         QvDTIYGWy9/sGuVR2iYKWG/5NAkRzgcsHMTjLmPzS0GYck71ZV8/dygn/5PwUM4FcXlt
         S1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bmsKv1KnXmsYwtGJMPUHBcsdr0nGhadkSK4wYbQk+40=;
        b=fgEg0ZdL6r1OTy72/HX1m9m1DmAnRWCBRyQjcjoI0bXw/kRhGxMpyHQ8sWcaOsSk2V
         inZRiwJF1IrK8klDQ8J8vtFTJG5GLBZbpI8td0hbMTeyRt5KrbYn9dyi4B9a1i0+4E0f
         MBUblGZZpzDfsRTkq1QCsasK3Brbtw2aoa0euadQ6vPIJxcXJa3GrPCSu3aEkM45+HIg
         WT9C55Po4d+rvRIK7Su6PmQBGU+0ijhQdc9W3pqry4MtpN6Ty1h3tTpAMCZnVPvqXcZ/
         7bJ+TsaSh69C0kGucHCtbzCwH6dFi1xqzI7VcD8KXwnhb5gWMlQj99orq6UVop0N+m8L
         /nkQ==
X-Gm-Message-State: AOAM5301uDYf1peGzzbAlu7zArUsnGCy/sptSwgxkDNP4POAItu0z/6N
        ik6B90cg5I8i9jkMmt4pid4cZ5DK4jbplTNfkSZmBCdNnF8Y5TB7
X-Google-Smtp-Source: ABdhPJwK9tngPo9HKAQKSWV7Si22TTStsKej/SfmsM/vivSwVqa6/B9VxutyjM7EtJlWJHIhOJBaWFu6QfF5TowfQlE=
X-Received: by 2002:aca:190a:: with SMTP id l10mr632708oii.174.1624805440882;
 Sun, 27 Jun 2021 07:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOg9mSR9CM-DV1eqL58HM+m_6fbwgU7KFs3Sab0=A7BOvqoPYQ@mail.gmail.com>
 <CAHk-=wgL3d6iZz5s=pCQAx+tz8BMPFUNp8dMmBtGqYCUKg50uQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgL3d6iZz5s=pCQAx+tz8BMPFUNp8dMmBtGqYCUKg50uQ@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sun, 27 Jun 2021 10:50:30 -0400
Message-ID: <CAOg9mSQAuFtPtGogf+KGspk8C-QCxqQ7zssmk-MNTEtpePkwgQ@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs: an adjustment and a fix...
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fair enough... I promise it is my generally my habit to do
this and pay attention to the output before I send stuff
to you:

 1011  rm fs/orangefs/*.o
 1012  make

>>so clearly this has gotten absolutely zero testing.

I wouldn't do you that way :-) ... I ran this through xfstests
and left it on linux-next for a cycle.

-Mike

On Sat, Jun 26, 2021 at 1:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jun 26, 2021 at 7:14 AM Mike Marshall <hubcap@omnibond.com> wrote=
:
> >
> > If it is not too late for these... the readahead adjustment
> > was suggested by Matthew Wilcox and looks like how I should
> > have written it in the first place...
>
> It wasn't too late - I pulled these.
>
> And then I un-pulled them. You removed all the uses of "file", but
> left the variable, so it all warns about
>
>   fs/orangefs/inode.c: In function =E2=80=98orangefs_readahead=E2=80=99:
>   fs/orangefs/inode.c:252:22: warning: unused variable =E2=80=98file=E2=
=80=99
> [-Wunused-variable]
>     252 |         struct file *file =3D rac->file;
>         |                      ^~~~
>
> so clearly this has gotten absolutely zero testing.
>
>            Linus
