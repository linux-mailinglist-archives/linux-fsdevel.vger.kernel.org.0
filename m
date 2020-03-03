Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2286177453
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCCKeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 05:34:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41192 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCCKeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:34:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so2483217oie.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9VmsIZewgFG4BQQWz1oxJk1kr5h4oup+Ad6oeZpXNM=;
        b=qCfEHrQ7hnwBLGa3e/zU5LGGzRjhKWQjwTHHZagx7KQCJEQMsUlf8RwsdIAo/1eg8t
         FxEnEM6KCt/vMuMdmwwGC7D6Jw0YEZ2B105Kuyt01r7gmJy1e4R69UBhRxvzgLAaVwkW
         zNcHaS3X2JSojJM/8uN7uRH/4WwLKME9guXU1izGZ2gdWEAx/dwWL2QdQ8Ukn/8AzFWp
         fH/Vy5XSCrE9wy5GTSQ8KdGgTnvA3ZY9jd7job4qwA3cNx04Elr923Pxk015XeCe5Xv9
         s7pgAg5pcUvd3dEXLe4nBUS353e3eaGz1fS3bcjdHi0iS/TWoPswpN7+yrkO+yMZOOuX
         2hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9VmsIZewgFG4BQQWz1oxJk1kr5h4oup+Ad6oeZpXNM=;
        b=ak5cS51SVuArvujI/QeCGXJXMxXs/aojfGqnW+3lU1tPFjZAcUabSfj2PLzEqB5TxP
         1l24kA1jTuPK5TzRpYm/pwWadQT4n11gs6T5DEYgNbnd/sopTzTz1CG2iIn27FT0eqdQ
         58pAkoPf9c4SvXl1eH6rpUW6pSgQq+oOIvZI+gxOI2mD/MPlZjUZdzaYteNXjudxnxUD
         0xlTNwmmcq+gpERIYdbjiWRuEOwh2n6kpz/DiZzIen+0hMVlMJP5wS0kxsXQ2KftvZ0Q
         E6Tz0OBEFVCHEWtZCOr7gg6dX2HI3x9QFLvNAvokYVo3Mg6Nuhe1M/cgbMPK8TmiMFaA
         xbWQ==
X-Gm-Message-State: ANhLgQ3cwSLSTjow1kIR9xvu1YZ2rVoT0r9nK84lyz6PzYpJfQYQADkT
        v9QyFp+n8Pt0++VOoi07RF1IaR3OP5PttFp6OX/N+g==
X-Google-Smtp-Source: ADFU+vvji4fARHK9nDfdxs/FQYCRzfLzhXebo3fJ5pM2RqxUk8XqmFRERwkXmdEzjcSwIVnh/yyIGfUSe5I0Dhortsk=
X-Received: by 2002:aca:ed86:: with SMTP id l128mr2018604oih.75.1583231673902;
 Tue, 03 Mar 2020 02:34:33 -0800 (PST)
MIME-Version: 1.0
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com> <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
In-Reply-To: <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Tue, 3 Mar 2020 11:34:22 +0100
Message-ID: <CANnVG6kPCHV8p6FtX0g5b_R4USTXpc_ns=PJk6xtT-hT5qDb_g@mail.gmail.com>
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Tejun Heo <tj@kernel.org>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tejun, friendly ping? Any thoughts on this? Thanks!

On Wed, Feb 26, 2020 at 9:00 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Adding more CC and re-attaching the reproducer and the 25s log.
>
> On Wed, Feb 26, 2020 at 11:03 AM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
> >
> > Find attached two logs:
> >
> > fuse-1s.log shows the expected case
> >
> > fuse-25s.log shows the issue. Note that the log spans 2 days. I
> > started the cp at 10:54:53.251395. Note how the first WRITE opcode is
> > only received at 10:55:18.094578!
>
> Observations:
>
> - apparently memcpy is copying downwards (from largest address to
> smallest address).  Not sure why, when I run the reproducer, it copies
> upwards.
> - there's a slow batch of reads of the first ~4MB of data, then a
> quick writeback
> - there's a quick read of the rest (~95MB) of data, then a quick
> writeback of the same
>
> Plots of the whole and closeups of slow and quick segments attached.
> X axis is time, Y axis is offset.
>
> Tejun, could this behavior be attributed to dirty throttling?  What
> would be the best way to trace this?
>
> Thanks,
> Miklos
>
>
> >
> > Is there some sort of readahead going on that=E2=80=99s then being thro=
ttled somewhere?
> >
> > Thanks,
> >
> > On Mon, Feb 24, 2020 at 3:23 PM Miklos Szeredi <miklos@szeredi.hu> wrot=
e:
> > >
> > > On Mon, Feb 24, 2020 at 3:18 PM Michael Stapelberg
> > > <michael+lkml@stapelberg.ch> wrote:
> > > >
> > > > Sorry, to clarify: the hang is always in the memcpy call. I.e., the
> > > > =E2=80=9CMapped=E2=80=9D message is always printed, and it takes a =
long time until
> > > > =E2=80=9Cmemcpy done=E2=80=9D is printed.
> > >
> > > Have you tried running the fuse daemon with debugging enabled?  Is
> > > there any observable difference between the fast and the slow runs?
> > >
> > > Thanks,
> > > Miklos
