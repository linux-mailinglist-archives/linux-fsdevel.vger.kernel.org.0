Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD656E7213
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 06:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjDSEHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 00:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDSEHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:07:13 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964F1AD;
        Tue, 18 Apr 2023 21:07:10 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id p1so1328860vsi.6;
        Tue, 18 Apr 2023 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681877230; x=1684469230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=125xcY+7eR4AjSYyVNtbZyRb1u9zQjLjiffTEAmBdY8=;
        b=WO7LdWq8ep/F0bdDJziedLPagmehZMSnYN5IEFDbnCZuhNU/XrITXA/kpBh8d3gltb
         Ibnf3dlIuwmcANwRZHdcx+Xo0YVf8N+BE+B62H39U52UC/mh7w/mJzdYD81kjh6Q37/j
         4KBnnTJ7pOsh9qOtsw2VscA3GPz/7W+qi7vcl+qrc5ayBT+13pJfxGYvlwOC5McY7VsO
         LLy2PUFVsmteU08fBsAkGRHC+aNJCI0BG8LI5o5sc0/T993RCNaOPW1Iesi3Tw+XYslC
         iM9n+JDWHmRGWCmkmExtLQGVmxKWiWdXTiMjkwCz51mXNc8Ex+F60toVczfvd8V/sU1t
         8sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681877230; x=1684469230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=125xcY+7eR4AjSYyVNtbZyRb1u9zQjLjiffTEAmBdY8=;
        b=ZKFeJdhi4QuniVwWTNKeVfbTsrZiRIOmtjgVzlSU6AvHfe3zZR9UCfV5uuDeAA3tO1
         1CgcepLiddY/mtLOeXhYZXK2By63xcr9D92GAyFd29AlnH27sx0BtlPyCoBmfNdz+jpi
         XmQeiMjS0czSQ9aYXV+af6/l3F9+EkEYkKnCm6d1c0QcGh/TMH+IU6IpOKwdtsSGh0EK
         pxVfaylJRQoeOR+2u3kwmFT6T8eCjZwL37YcGJoPsD82fx55sArgx/Q5hL8Svzvzo5nA
         axCmYEKJWpHaAK7oDOiqtxXQ9ZiwPvt6+4k6+/Uf71jC1/pEOdk+/GfC31Jn3l9FFjkr
         Johg==
X-Gm-Message-State: AAQBX9cFlCBFGyu0D/iKzT24vAf1T+/zuleYRZ84XvdN25/42/s62nz+
        vl4QQwWBvpIEJYZdP5lxoRCaqAJ8qqvYzajFasm/9Bsv
X-Google-Smtp-Source: AKy350YeAUX+0YGPaOUyEdSVsnCfL5SffHM/pbbz6tMEwiNofOV64faz1c1ZOCBYDP+AZNs1QPc9Lal7SgL/vfrC9x8=
X-Received: by 2002:a67:d99e:0:b0:42e:63a5:c0d6 with SMTP id
 u30-20020a67d99e000000b0042e63a5c0d6mr7277691vsj.0.1681877229723; Tue, 18 Apr
 2023 21:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y/5ovz6HI2Z47jbk@magnolia> <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs> <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
 <20230419021146.GE360889@frogsfrogsfrogs>
In-Reply-To: <20230419021146.GE360889@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Apr 2023 07:06:58 +0300
Message-ID: <CAOQ4uxjmTBi9B=0mMKf6i8usLJ2GrAp88RhxFcQcGFK1LjQ_Lw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 5:11=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
> > On Tue, Apr 18, 2023 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
> > > > On Tue, Feb 28, 2023 at 10:49=E2=80=AFPM Darrick J. Wong <djwong@ke=
rnel.org> wrote:
> > ...
> > > > Darrick,
> > > >
> > > > Quick question.
> > > > You indicated that you would like to discuss the topics:
> > > > Atomic file contents exchange
> > > > Atomic directio writes
> > >
> > > This one ^^^^^^^^ topic should still get its own session, ideally wit=
h
> > > Martin Petersen and John Garry running it.  A few cloud vendors'
> > > software defined storage stacks can support multi-lba atomic writes, =
and
> > > some database software could take advantage of that to reduce nested =
WAL
> > > overhead.
> > >
> >
> > CC Martin.
> > If you want to lead this session, please schedule it.
> >
> > > > Are those intended to be in a separate session from online fsck?
> > > > Both in the same session?
> > > >
> > > > I know you posted patches for FIEXCHANGE_RANGE [1],
> > > > but they were hiding inside a huge DELUGE and people
> > > > were on New Years holidays, so nobody commented.
> > >
> > > After 3 years of sparse review comments, I decided to withdraw
> > > FIEXCHANGE_RANGE from general consideration after realizing that very
> > > few filesystems actually have the infrastructure to support atomic fi=
le
> > > contents exchange, hence there's little to be gained from undertaking
> > > fsdevel bikeshedding.
> > >
> > > > Perhaps you should consider posting an uptodate
> > > > topic suggestion to let people have an opportunity to
> > > > start a discussion before LSFMM.
> > >
> > > TBH, most of my fs complaints these days are managerial problems (Are=
 we
> > > spending too much time on LTS?  How on earth do we prioritize project=
s
> > > with all these drive by bots??  Why can't we support large engineerin=
g
> > > efforts better???) than technical.
> >
> > I penciled one session for "FS stable backporting (and other LTS woes)"=
.
> > I made it a cross FS/IO session so we can have this session in the big =
room
> > and you are welcome to pull this discussion to any direction you want.
>
> Ok, thank you.  Hopefully we can get all the folks who do backports into
> this one.  That might be a big ask for Chandan, depending on when you
> schedule it.
>
> (Unless it's schedule for 7pm :P)
>

Oh thanks for reminding me!
I moved it to Wed 9am, so it is more convenient for Chandan.

Thanks,
Amir.
