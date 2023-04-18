Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A76E5AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDRHqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDRHqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:45 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F64C29;
        Tue, 18 Apr 2023 00:46:44 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id v10so25275907vsf.6;
        Tue, 18 Apr 2023 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681804003; x=1684396003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncHlgBW8+huHnPie0F7ibuUGA9YonZ6zPvQILgCUzFo=;
        b=PVe3z9LMwF1plhRq1djm3jKH3wBpqalEmUjxaKIeojp4jXCInAW/YLtEM82EYNjSv0
         3XaHrxlpTVYslSLJgdHr4wehYafJoIN/2QGnio9j/4vRbtCTtXYYGK4Jq8dLFHy1Kdaf
         ISRgocwdrHcWrrewxlZjtPJJZU31RRmTxqkK0D7uu90CkuYyo09U78FOJQd1l5j56I5o
         oVMGJxL13GDAB9/q6KK/a9PBdZJj4Lrk/oZ3T8Ty0nl0PMJpoH2npCEEqn+xs6uvRagn
         RUY2Xdlb5N0Z9ZnwO3bAyBrCtj8QRgRUnQiN/oibVelul4g0OGmigE463NVtj/pB1NDe
         ncmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804003; x=1684396003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncHlgBW8+huHnPie0F7ibuUGA9YonZ6zPvQILgCUzFo=;
        b=IPY4t9qwtf1jR23EsKJtcyePInOOpwFvIID9r1IzJh+jFjUuaFYlcIkNhsVmM1dKvn
         PPIGGHX251smSvq+bVAiP4lgxDmjXFkQUxvfM2bpvI52YQNAKN/k5VHX0zWtdDxYOa66
         0LbNFCSpuqriDGbSZFO0NJuZt0MQwZwQEH0ugQsEXNTwQ1HS9nwHmA+EfaMLt2Cps2Ra
         a7sQENJSk/g/+6uCGDyWEMIcSTv+oQk/tAOqKyLMHCVPkxZCfNQ7ni6o53Z66dqSO7NL
         1Ev4QG+fHsI5NcroWDZkgtBD+Ioa1DAT33lPMUnatPq41ez0yejgYv+T/5vqtUzev6Ye
         DxEA==
X-Gm-Message-State: AAQBX9ddEFgx22rCDOIqs3V9lY1Z88iofxj2aShnp5rekLMuqENiEvjI
        8+gobtvLs9oCX16GS7OX2sHc8aUIQetWB7/HOIk=
X-Google-Smtp-Source: AKy350aSHzHEEr+8K0Sr/CsAHaDwtlIUDJduCnBUdsumah8HkhAvyAgUVuUKlh2+nJPer3otBTvqywmiNHmp0poMRBw=
X-Received: by 2002:a67:c102:0:b0:42f:f598:9f3b with SMTP id
 d2-20020a67c102000000b0042ff5989f3bmr2356334vsj.0.1681804003394; Tue, 18 Apr
 2023 00:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <Y/5ovz6HI2Z47jbk@magnolia> <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
In-Reply-To: <20230418044641.GD360881@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Apr 2023 10:46:32 +0300
Message-ID: <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
> > On Tue, Feb 28, 2023 at 10:49=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
...
> > Darrick,
> >
> > Quick question.
> > You indicated that you would like to discuss the topics:
> > Atomic file contents exchange
> > Atomic directio writes
>
> This one ^^^^^^^^ topic should still get its own session, ideally with
> Martin Petersen and John Garry running it.  A few cloud vendors'
> software defined storage stacks can support multi-lba atomic writes, and
> some database software could take advantage of that to reduce nested WAL
> overhead.
>

CC Martin.
If you want to lead this session, please schedule it.

> > Are those intended to be in a separate session from online fsck?
> > Both in the same session?
> >
> > I know you posted patches for FIEXCHANGE_RANGE [1],
> > but they were hiding inside a huge DELUGE and people
> > were on New Years holidays, so nobody commented.
>
> After 3 years of sparse review comments, I decided to withdraw
> FIEXCHANGE_RANGE from general consideration after realizing that very
> few filesystems actually have the infrastructure to support atomic file
> contents exchange, hence there's little to be gained from undertaking
> fsdevel bikeshedding.
>
> > Perhaps you should consider posting an uptodate
> > topic suggestion to let people have an opportunity to
> > start a discussion before LSFMM.
>
> TBH, most of my fs complaints these days are managerial problems (Are we
> spending too much time on LTS?  How on earth do we prioritize projects
> with all these drive by bots??  Why can't we support large engineering
> efforts better???) than technical.

I penciled one session for "FS stable backporting (and other LTS woes)".
I made it a cross FS/IO session so we can have this session in the big room
and you are welcome to pull this discussion to any direction you want.

>
> (I /am/ willing to have a "Online fs metadata reconstruction: How does
> it work, and can I have some of what you're smoking?" BOF tho)
>

I penciled a session for this one already.
Maybe it would be interesting for the crowd to hear some about
"behind the scenes" - how hard it was and still is to pull off an
engineering project of this scale - lessons learned, things that
you might have done differently.

Cheers,
Amir.
