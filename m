Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF127AC2E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjIWO7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIWO7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:59:04 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238ABD3;
        Sat, 23 Sep 2023 07:58:58 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1301915241.1;
        Sat, 23 Sep 2023 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695481137; x=1696085937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r98I0fZ1wJbdSD3JMwSiiPBmbA+sefSlclinhcfpiEo=;
        b=acGnbekDRyUQrnuqGWpQR6OcY5ZJRFeBy1DTH/DMYRFFzD6ZJW8WktXsm2sWqh2/Po
         5QDgkc9lEJ7bpjjlaZmb01PpuHvyo8EGiGmbp11rTZ+JPbA996/j135H9ela+Qmlvcfw
         lypBv8wbIvUUqWgvfZc87lOwSHi3UbzXI8lpvNqALDHoHxc5A/WRVaG66+zmwcfHWPqv
         mbw+yceDtgMkKw5toPDq1DWJVYbidv9xw2ktm+d/WuSTDtve0mompHYrQZBpHJdAEle/
         LWnDsQHe1K3QO7XYUo5G7wM6/2M0LlIXh4odSN07Q32W76+UnQu/T6+L7uscy0+qupEN
         iylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481137; x=1696085937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r98I0fZ1wJbdSD3JMwSiiPBmbA+sefSlclinhcfpiEo=;
        b=L+mUleMJc3WXamUgMtYdh6RJ0V0bLLzp5nPMZiIgGEMhzzk6yYEclzCeFyefHycHnV
         /SGnOr32VRa0jtmtnJOtBlsEkN1po6Duzz6VjZ8qtvNOqnqbThR/1gRCpS6NrHsJiyCT
         o4Pu6YVhBYDtgr77RdxW+GSrcauiAeDDuOS+kbndjGbaU469EiFjG1j5oKNB5ohpo0U4
         tuQ4xyFZJs7lPsd4VHueRpUC+BglZShWh1TF6H9h9D9QJcjOd3uAvftB4LXutxYN8P8m
         Ct1mEV08V8fDt33ovtXEeDqLM8XYfcZQ0JFarJUa9hw1Ez/OEkODv6o6ME7U7J/X+HJA
         yd5Q==
X-Gm-Message-State: AOJu0YxRLtkCe4L13LrMl682Z9MfcA5R6DT0Vwzjdc0/zxK1Z+vPwCkw
        RJ5VWtPQmss2FU3fFGr6PMAt4+yMOUg0V2BEW8Q=
X-Google-Smtp-Source: AGHT+IG5ZvcNAkNBWJkc33wC7vFLVTly0S1g7Q8j7KrbOK4fdGdSfTWVOk1jqhV7Tm+3T7uLwadkGnYhL1ncI1eoS6g=
X-Received: by 2002:a67:f842:0:b0:452:5c6d:78c9 with SMTP id
 b2-20020a67f842000000b004525c6d78c9mr1535362vsp.12.1695481137204; Sat, 23 Sep
 2023 07:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org> <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
 <4b106847d5202aec0e14fdbbe93b070b7ea97477.camel@kernel.org>
In-Reply-To: <4b106847d5202aec0e14fdbbe93b070b7ea97477.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 17:58:46 +0300
Message-ID: <CAOQ4uxjfbq=u3PYi_+ZiiAjub92o0-KeNT__ZRKSmRogLtF75Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 1:22=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > My initial goal was to implement multigrain timestamps on most major
> > > filesystems, so we could present them to userland, and use them for
> > > NFSv3, etc.
> > >
> > > With the current implementation however, we can't guarantee that a fi=
le
> > > with a coarse grained timestamp modified after one with a fine graine=
d
> > > timestamp will always appear to have a later value. This could confus=
e
> > > some programs like make, rsync, find, etc. that depend on strict
> > > ordering requirements for timestamps.
> > >
> > > The goal of this version is more modest: fix XFS' change attribute.
> > > XFS's change attribute is bumped on atime updates in addition to othe=
r
> > > deliberate changes. This makes it unsuitable for export via nfsd.
> > >
> > > Jan Kara suggested keeping this functionality internal-only for now a=
nd
> > > plumbing the fine grained timestamps through getattr [1]. This set ta=
kes
> > > a slightly different approach and has XFS use the fine-grained attr t=
o
> > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > >
> > > While we keep fine-grained timestamps in struct inode, when presentin=
g
> > > the timestamps via getattr, we truncate them at a granularity of numb=
er
> > > of ns per jiffy,
> >
> > That's not good, because user explicitly set granular mtime would be
> > truncated too and booting with different kernels (HZ) would change
> > the observed timestamps of files.
> >
>
> That's a very good point.
>
> > > which allows us to smooth over the fuzz that causes
> > > ordering problems.
> > >
> >
> > The reported ordering problems (i.e. cp -u) is not even limited to the
> > scope of a single fs, right?
> >
>
> It isn't. Most of the tools we're concerned with don't generally care
> about filesystem boundaries.
>
> > Thinking out loud - if the QERIED bit was not per inode timestamp
> > but instead in a global fs_multigrain_ts variable, then all the inodes
> > of all the mgtime fs would be using globally ordered timestamps
> >
> > That should eliminate the reported issues with time reorder for
> > fine vs coarse grained timestamps.
> >
> > The risk of extra unneeded "change cookie" updates compared to
> > per inode QUERIED bit may exist, but I think it is a rather small overh=
ead
> > and maybe worth the tradeoff of having to maintain a real per inode
> > "change cookie" in addition to a "globally ordered mgtime"?
> >
> > If this idea is acceptable, you may still be able to salvage the revert=
ed
> > ctime series for 6.7, because the change to use global mgtime should
> > be quite trivial?
> >
>
> This is basically the idea I was going to look at next once I got some
> other stuff settled here: Basically, when we apply a fine-grained
> timestamp to an inode, we'd advance the coarse-grained clock that
> filesystems use to that value.
>
> It could cause some write amplification: if you are streaming writes to
> a bunch of files at the same time and someone stats one of them, then
> they'd all end up getting an extra inode transaction. That doesn't sound
> _too_ bad on its face, but I probably need to implement it and then run
> some numbers to see.
>

Several journal transactions within a single jiffie tick?
If ctime/change_cookie of an inode is updated once within the scope
of a single running transaction, I don't think it matters how many
times it would be updated, but maybe I am missing something.

The problem is probably going to be that the seqlock of the coarse
grained clock is going to be invalidated way too frequently to be
"read mostly" in the presence of ls -lR workload, but again, I did
not study the implementation, so I may be way off.

Thanks,
Amir.
