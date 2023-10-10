Return-Path: <linux-fsdevel+bounces-9-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D4B7C45C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF98281F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB73E495;
	Tue, 10 Oct 2023 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BruM3DZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC93D3BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 23:59:49 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856D91
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 16:59:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692ada71d79so4884893b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696982387; x=1697587187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuBhbcRCY14Ehqi0PTSDL9AEIBFyvO42CHNfxwJX88M=;
        b=BruM3DZNS7ZwvtNBAEFkyeZZhxE3DpEpWC5sgAyG2IPC5wbLxGs2LMI8xfToh0inuj
         LzKU/5lszTGZoXyMWTDlymXPDdUmQOnXxxGNFbt9xRgbxCqxI7LN3jLENsi5GoV/rsCb
         knyUT+6SkLaBFAJxAgAxTaBqZSU2DxDhszgWA1nfmR+/clUa+YVxjuxCxd94S1KdzrPq
         lf7aylN+jV97Wn9H2SDQDV25gsKkSJzVJezZLXBZ51634uKrGy82kv+az37blcFpit9l
         SL6P0to3t1/QAoiwbEj9QLqa0L6u65QIrHjZp4CsZO5CNjBLZZ6tI79slGLKpX6Nwrmz
         CDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982387; x=1697587187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuBhbcRCY14Ehqi0PTSDL9AEIBFyvO42CHNfxwJX88M=;
        b=JlWilIuajXzQpP6WCpomnV1k6zQZr+xJfYvHkurGLGV4duQN/jucrvQUgAU9oIE3n3
         oA+xaG7L2a6dHShGaFUv9yiB1rPqN6PDrJ+hcHWKd80X9oObytcOZx0hedTL1XN66Iyw
         k4YNCP2X22aX1fYzNKR8yS+EJ6d9bbNcvP/4l0C2FyZMo2Ky450Tp7y9HRWjSMuuqUFc
         KaFOWd0VS0v9OcWy4QYaExTTgFBb8TdJ5JU+6VvbPkb+y8iPyojI3qk2H0EpYssONtHx
         Vrhalo7AsK8VFk0mawDI/O5mBnee2tJMj0eKhjG5eL7rf+bXQttXJ8dyW+XGpzeRqMiN
         9hBQ==
X-Gm-Message-State: AOJu0YzBX2qnGBD3BKknodhbv0pCbq/Vhv6LEjovobaveAutJpxPzgWB
	jAevOizEx5lR1pNvpsF5X2t+1A==
X-Google-Smtp-Source: AGHT+IFpjvyQUUCRBkdDh5nJwuhEhTd0rb4+c3As4mtWp5MPb97dXj/O7IfeEAEjzA3aYXTJpB6kTA==
X-Received: by 2002:a05:6a21:329c:b0:15c:b7b9:fc21 with SMTP id yt28-20020a056a21329c00b0015cb7b9fc21mr19831702pzb.14.1696982387504;
        Tue, 10 Oct 2023 16:59:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a056a001c9100b0068fcc7f6b00sm2559718pfw.74.2023.10.10.16.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:59:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qqMdc-00CAvp-1A;
	Wed, 11 Oct 2023 10:59:44 +1100
Date: Wed, 11 Oct 2023 10:59:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Foster <bfoster@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Bart Van Assche <bvanassche@google.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 3/5] loop: Add support for provision requests
Message-ID: <ZSXlcM2sUeFkHOnb@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-4-sarthakkukreti@chromium.org>
 <ZSM9UDMFNs0050pr@dread.disaster.area>
 <CAG9=OMNPK2s4vsun4B=xQ9nt3qR_fevNP1zSkYq9YG5QPPTsfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMNPK2s4vsun4B=xQ9nt3qR_fevNP1zSkYq9YG5QPPTsfQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 03:43:10PM -0700, Sarthak Kukreti wrote:
> On Sun, Oct 8, 2023 at 4:37 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 06:28:15PM -0700, Sarthak Kukreti wrote:
> > > Add support for provision requests to loopback devices.
> > > Loop devices will configure provision support based on
> > > whether the underlying block device/file can support
> > > the provision request and upon receiving a provision bio,
> > > will map it to the backing device/storage. For loop devices
> > > over files, a REQ_OP_PROVISION request will translate to
> > > an fallocate mode 0 call on the backing file.
> > >
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >
> >
> > Hmmmm.
> >
> > This doesn't actually implement the required semantics of
> > REQ_PROVISION. Yes, it passes the command to the filesystem
> > fallocate() implementation, but fallocate() at the filesystem level
> > does not have the same semantics as REQ_PROVISION.
> >
> > i.e. at the filesystem level, fallocate() only guarantees the next
> > write to the provisioned range will succeed without ENOSPC, it does
> > not guarantee *every* write to the range will succeed without
> > ENOSPC. If someone clones the loop file while it is in use (i.e.
> > snapshots it via cp --reflink) then all guarantees that the next
> > write to a provisioned LBA range will succeed without ENOSPC are
> > voided.
> >
> > So while this will work for basic testing that the filesystem is
> > issuing REQ_PROVISION based IO correctly, it can't actually be used
> > for hosting production filesystems that need full REQ_PROVISION
> > guarantees when the loop device backing file is independently
> > shapshotted via FICLONE....
> >
> > At minimuim, this set of implementation constraints needs tobe
> > documented somewhere...
> >
> Fair point. I wanted to have a separate fallocate() mode
> (FALLOC_FL_PROVISION) in the earlier series of the patchset so that we
> can distinguish between a provision request and a regular fallocate()
> call; I dropped it from the series after feedback that the default
> case should suffice. But this might be one of the cases where we need
> an explicit intent that we want to provision space.

ISTR that I commented that filesystems like XFS can't implement
REQ_PROVISION semantics for extents without on-disk format
changes. Hence that needs to happen before we expose a new API to
userspace....

> Given a separate FALLOC_FL_PROVISION mode in the scenario you
> mentioned, the filesystem could copy previously 'provisioned' blocks
> to new blocks (which implicitly provisions them) or reserve blocks for
> use (and passing through REQ_OP_PROVISION below). That also means that
> the filesystem should track 'provisioned' blocks and take appropriate
> actions to ensure the provisioning guarantees.

Yes, tracking provisioned ranges persistently and the reservations
they require needs on-disk filesytem format changes compared to just
preallocating space.  None of this functionality currently exists in
any filesystem that supports shared extents, and it's a fairly
significant chunk of development work to support it.

Nobody has planned to do this sort of complex surgery to XFS at
this point in time. I doubt that anyone on the btrfs side of
things is really even following this discussion because this is
largely for block device thinp and snapshot support
and btrfs just doesn't care about that.

> For filesystems without copy-on-write semantics (eg. ext4),
> REQ_OP_PROVISION should still be equivalent to mode == 0.

Well, yes. This is the same situation as "for non-sparse block
devices, REQ_PROVISION can just be ignored." This is not an
interesting use case, nor a use case that the functionality or APIs
should be designed around.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

