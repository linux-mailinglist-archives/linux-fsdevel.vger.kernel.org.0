Return-Path: <linux-fsdevel+bounces-10-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1727C45D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 02:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D36281E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A3375;
	Wed, 11 Oct 2023 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XKCdBT4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A418F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:03 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9791
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:07:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so5194595b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696982821; x=1697587621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pi+6fuCZ7nV+P3VswapuyLpGimJN9EBPXoRWDqou4vc=;
        b=XKCdBT4xDLdhql/mIXTy0D/GZJwAroDCsmYkeaBpzG8J8bvZDgIY4Kylq9B2KfM6K7
         j9iz/Aip7gxKYAsg+6LLcM0QLoHs2MH0LUyjSdYzClKGRFc6CV3/KtVsNj95oKYwXIDt
         kSmOtJawACxFtedvM6VOe9++eDFqRxFZXq3by6LBCY749IwZSrGmUguKTqX3yI4RpRJt
         T1b8YatNVCHuwpQRMV7Ov7FpFQK/4qrkLZZtskdIZ1AANbVx/FtDVgc/vejiz+GYycIG
         KbCi/hoQbKcxaHFAsjWlyve5f8Lk7o5ACYb5yfiZacfBFjlJLXTTaY6zCZTHnFFW3mgR
         DJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982821; x=1697587621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi+6fuCZ7nV+P3VswapuyLpGimJN9EBPXoRWDqou4vc=;
        b=XYhyQn+j4VlzXAITXp9XZ1vXeq2ytgmTkEuo1SLrptjyBTL3sSbA1U1lGkvetNkIbp
         8QVsgyj8lddwbpyt236eVmeBvw28h1ohZkPLhLiU9xHpjEYtnaLMi1bTJL5babI0o7IJ
         6/FShHrNU0Jy4R73O6T8yRVCkAyUKZlSx7vT39Qj9FYC5TZWlQoEYpxpzNjyejItibr0
         g5nzQ8ZAxhY0MA89hZm8LTnQbZDrbcl+7b1NxbsMd2IOP1bpNTW2GJmYWeKFMsAmqeMu
         IHxBaYhEb35P+d64xmstdDA2t/VzPJYVvHNx074OWzs07+t8LbiCW+uQIHaZevqQkqj2
         IcKQ==
X-Gm-Message-State: AOJu0YymA958byIWURh7uwPurcR9D5muUPLSuU42ToKKKNN8/H7zA3YQ
	R0vUpGhpyL8QXEr18JCFo7wJo5/CrZfBO3KMJ78=
X-Google-Smtp-Source: AGHT+IFaQsl6J0oGbAmpi1RKpoyAS4x5TyIMLa9yejYUMWdd4HdS26Ku+N4gQppaQiaJj/ZVu9D0qw==
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33cb with SMTP id wl27-20020a056a216d9b00b0014b802333cbmr25670485pzb.11.1696982820871;
        Tue, 10 Oct 2023 17:07:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001c5900c9e8fsm12483875plb.81.2023.10.10.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:07:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qqMkb-00CB10-3B;
	Wed, 11 Oct 2023 11:06:58 +1100
Date: Wed, 11 Oct 2023 11:06:57 +1100
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
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
Message-ID: <ZSXnIYejKVo74doY@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org>
 <ZSM64EOTVyKNkc/X@dread.disaster.area>
 <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 03:42:39PM -0700, Sarthak Kukreti wrote:
> On Sun, Oct 8, 2023 at 4:27 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> > > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > > annotate unshare requests to underlying layers. Layers that support
> > > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > > fallocate() mode to use.
> > >
> > > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  block/blk-lib.c           |  6 +++++-
> > >  block/fops.c              |  6 ++++--
> > >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> > >  include/linux/blk_types.h |  3 +++
> > >  include/linux/blkdev.h    |  3 ++-
> > >  5 files changed, 43 insertions(+), 10 deletions(-)
> >
> > I have no idea how filesystems (or even userspace applications, for
> > that matter) are supposed to use this - they have no idea if the
> > underlying block device has shared blocks for LBA ranges it already
> > has allocated and provisioned. IOWs, I don't know waht the semantics
> > of this function is, it is not documented anywhere, and there is no
> > use case present that tells me how it might get used.
> >
> > Yes, unshare at the file level means the filesystem tries to break
> > internal data extent sharing, but if the block layers or backing
> > devices are doing deduplication and sharing unknown to the
> > application or filesystem, how do they ever know that this operation
> > might need to be performed? In what cases do we need to be able to
> > unshare block device ranges, and how is that different to the
> > guarantees that REQ_PROVISION is already supposed to give for
> > provisioned ranges that are then subsequently shared by the block
> > device (e.g. by snapshots)?
> >
> > Also, from an API perspective, this is an "unshare" data operation,
> > not a "provision" operation. Hence I'd suggest that the API should
> > be blkdev_issue_unshare() rather than optional behaviour to
> > _provision() which - before this patch - had clear and well defined
> > meaning....
> >
> Fair points, the intent from the conversation with Darrick was the
> addition of support for FALLOC_FL_UNSHARE_RANGE in patch 2 of v4
> (originally suggested by Brian Forster in [1]): if we allow
> fallocate(UNSHARE_RANGE) on a loop device (ex. for creating a
> snapshot, similar in nature to the FICLONE example you mentioned on
> the loop patch), we'd (ideally) want to pass it through to the
> underlying layers and let them figure out what to do with it. But it
> is only for situations where we are explicitly know what the
> underlying layers are and what's the mecha
> 
> I agree though that it clouds the API a bit and I don't think it
> necessarily needs to be a part of the initial patch series: for now, I
> propose keeping just mode zero (and FALLOC_FL_KEEP_SIZE) handling in
> the block series patch and drop this patch for now. WDYT?

Until we have an actual use case for unsharing (which explicitly
breaks extent sharing) as opposed to provisioning (which ensures
overwrites always succeed regardless of extent state) then let's
leave it out of this -provisioning- series.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

