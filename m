Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CEF711B01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjEZAG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZAG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:06:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866C195;
        Thu, 25 May 2023 17:05:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af316b4515so1365941fa.1;
        Thu, 25 May 2023 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685059538; x=1687651538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic3WsKMPF4rIwx8HLozqrwGou1Sinksz8ctxoPlHRzI=;
        b=r0OAb0fTQ8LnAKl5d0OU6ACOoRHNGak8ZEnNET+efzOJx0y98C2cygU5YM4jutcbfp
         INN36/VaaIimw9lQoUhC0abC/K3zGOF2FY6rVhco4r1bz5y2q3ZvQ6aqOjzR112o6gNa
         AaQVYhE2cZPdFJJnlJxocMyn7Iap10OwlHFa+l5cj9a2HbMBhRYZocdFKUatiB0cZxv1
         xe7QEP6guFSH8YQTYGBaD5vl2l2gZoex8YGLm7g0zG5KVqWJAAJkHWH6wRPP6kjrM/u4
         RJC4ZupXP3DpkLWv1C05hDo65BtOeN2rXBYY1/YlAneFeji1gDmLLUK/ECTzpXHFuVlF
         D4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685059538; x=1687651538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic3WsKMPF4rIwx8HLozqrwGou1Sinksz8ctxoPlHRzI=;
        b=CMRx5ZJAMNlriwDEyPgu1clpvBG+LY2q821FD5ceRuARlWFfK23VLs3VNjIZCGEank
         Ear7J9q3lAYYm5F79mwN3/WvLtVc5YEnL5KOMTbcrAU4HcJt1z7BIFUsbNuSHFuqX7YF
         2B3XqsClZAh4U/q33FWl37ZdTzGUBOKPDtEEvM3J9A8YGiKLU9gSmKqXa0mVTZw5JgMy
         akibH5ksd3mfbgZ0MP/VsvWvTMAC/pVuAMikS9v4ogWqk3NWb6qXQ6YmXB3Ml96B3+LA
         4vrgoO9/gGqaR9ggl7v50HhhnzSdkUfy0N3fJDqp8wVew2orYNUSi3wzXFafy3s0gqC5
         rbaA==
X-Gm-Message-State: AC+VfDwg0Yg10LQemfdc68G8viiJROiwIYK1rg4zpY+LIm8WChhnC9Ke
        Sc0N3gGmDlzdkhZxCbK6KKaQdMxVnNu0q/8DbmA=
X-Google-Smtp-Source: ACHHUZ5dyQnqqW3d2AY3VwNHX1NgTJhmX4caiv5qKE0Ob10OKJQ2PB4+pFN90Hr2dqWkK5yTnNafRoVfxUawlRpyKx4=
X-Received: by 2002:a2e:9557:0:b0:2ad:d6cd:efdd with SMTP id
 t23-20020a2e9557000000b002add6cdefddmr79186ljh.32.1685059537431; Thu, 25 May
 2023 17:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev> <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan> <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org> <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
 <ZG/tTorh8G2919Jz@moria.home.lan>
In-Reply-To: <ZG/tTorh8G2919Jz@moria.home.lan>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 26 May 2023 02:05:26 +0200
Message-ID: <CAHpGcMKQke0f5-y6fg3O5dBwcTYX69dEbxZgDiFABgOLCc+zGw@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
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

Am Fr., 26. Mai 2023 um 01:20 Uhr schrieb Kent Overstreet
<kent.overstreet@linux.dev>:
> On Fri, May 26, 2023 at 12:25:31AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Di., 23. Mai 2023 um 18:28 Uhr schrieb Christoph Hellwig <hch@infrad=
ead.org>:
> > > On Tue, May 23, 2023 at 03:34:31PM +0200, Jan Kara wrote:
> > > > I've checked the code and AFAICT it is all indeed handled. BTW, I'v=
e now
> > > > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da=
25
> > > > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a dif=
ferent
> > > > way (by prefaulting pages from the iter before grabbing the problem=
atic
> > > > lock and then disabling page faults for the iomap_dio_rw() call). I=
 guess
> > > > we should somehow unify these schemes so that we don't have two mec=
hanisms
> > > > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> > > >
> > > > Also good that you've written a fstest for this, that is definitely=
 a useful
> > > > addition, although I suspect GFS2 guys added a test for this not so=
 long
> > > > ago when testing their stuff. Maybe they have a pointer handy?
> > >
> > > generic/708 is the btrfs version of this.
> > >
> > > But I think all of the file systems that have this deadlock are actua=
lly
> > > fundamentally broken because they have a mess up locking hierarchy
> > > where page faults take the same lock that is held over the the direct=
 I/
> > > operation.  And the right thing is to fix this.  I have work in progr=
ess
> > > for btrfs, and something similar should apply to gfs2, with the added
> > > complication that it probably means a revision to their network
> > > protocol.
> >
> > We do disable page faults, and there can be deadlocks in page fault
> > handlers while no page faults are allowed.
> >
> > I'm roughly aware of the locking hierarchy that other filesystems use,
> > and that's something we want to avoid because of two reasons: (1) it
> > would be an incompatible change, and (2) we want to avoid cluster-wide
> > locking operations as much as possible because they are very slow.
> >
> > These kinds of locking conflicts are so rare in practice that the
> > theoretical inefficiency of having to retry the operation doesn't
> > matter.
>
> Would you be willing to expand on that? I'm wondering if this would
> simplify things for gfs2, but you mention locking heirarchy being an
> incompatible change - how does that work?

Oh, it's just that gfs2 uses one dlm lock per inode to control access
to that inode. In the code, this is called the "inode glock" ---
glocks being an abstraction above dlm locks --- but it boils down to
dlm locks in the end. An additional layer of locking will only work
correctly if all cluster nodes use the new locks consistently, so old
cluster nodes will become incompatible. Those kinds of changes are
hard.

But the additional lock taking would also hurt performance, forever,
and I'd really like to avoid taking that hit.

It may not be obvious to everyone, but allowing page faults during
reads and writes (i.e., while holding dlm locks) can lead to
distributed deadlocks. We cannot just pretend to be a local
filesystem.

Thanks,
Andreas

> > > I'm absolutely not in favour to add workarounds for thes kind of lock=
ing
> > > problems to the core kernel.  I already feel bad for allowing the
> > > small workaround in iomap for btrfs, as just fixing the locking back
> > > then would have avoid massive ratholing.
> >
> > Please let me know when those btrfs changes are in a presentable shape =
...
>
> I would also be curious to know what btrfs needs and what the approach
> is there.
