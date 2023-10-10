Return-Path: <linux-fsdevel+bounces-5-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879127C4469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FB81C20E52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588429D09;
	Tue, 10 Oct 2023 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvU9EPj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15335518
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:42:55 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1C98
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso1035155066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977771; x=1697582571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=CvU9EPj1lUJQyOfAGhYeGOjHZqZh94H8624ZCxtj/g4utxU07Pzp9HavSi9mU6cImZ
         p8KwpzKyS38reVcjErdfotvGWGeX62qduqXmHaCwNdXi9MaP0w2ZdfAcvbDL/66LhvoA
         Rnqj9gBEYjcg319GJ4vHBeHraFRVuGXeDWdU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977771; x=1697582571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=poqrewd/xB+e913KT6hgw7y2OyCN036Evo4SVO3Zd+kjQQ17hwigl0cdNngmd/zB4H
         sAWlrGwFjKDwlTOz75J6V+YZNHSmv6KBFl8QcFj0jJSJ0e6TjbsahrTw/vz9zx6bJ18q
         NplVsebzG9d98m9MQbyUMTdRdSrzO3t8xrbjbasYTUORP8nOyAx/p1Q1DVVE2PG7ktBf
         n8f4D9MD6eTdX9IzvqS5NZ0T1sb82P/i8cwq+FsKP+0U+nZazPfCxE2wIF3y54vgNSQs
         CqgWu6TC7AHSaYpjTf/tf1u6B5VplUDpsrq9sHlYVE3kGkSvasEMe3SYCHtnuRL7g4fi
         0NwA==
X-Gm-Message-State: AOJu0YzjpwEuJgxUKumxpRxGu8HtPiJNC/hqwcZL3CJoVMGGWF5GuqQI
	NztdYFzrRceZ5BdWTn1Xq9GL3YpQEDV4ZgeVC8eIRA==
X-Google-Smtp-Source: AGHT+IHovl1AnfLJUnwNPKM37IAziJkKti9gYfE82FUNcROx92edpN/rECBAy7Ui9Lg+Iqjm2+QUlHjRja83n7tAqZI=
X-Received: by 2002:a17:906:9a:b0:9b2:b149:b818 with SMTP id
 26-20020a170906009a00b009b2b149b818mr17960595ejc.70.1696977771190; Tue, 10
 Oct 2023 15:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org> <ZSM64EOTVyKNkc/X@dread.disaster.area>
In-Reply-To: <ZSM64EOTVyKNkc/X@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Tue, 10 Oct 2023 15:42:39 -0700
Message-ID: <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
To: Dave Chinner <david@fromorbit.com>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Brian Foster <bfoster@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Bart Van Assche <bvanassche@google.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 4:27=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > annotate unshare requests to underlying layers. Layers that support
> > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > fallocate() mode to use.
> >
> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-lib.c           |  6 +++++-
> >  block/fops.c              |  6 ++++--
> >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> >  include/linux/blk_types.h |  3 +++
> >  include/linux/blkdev.h    |  3 ++-
> >  5 files changed, 43 insertions(+), 10 deletions(-)
>
> I have no idea how filesystems (or even userspace applications, for
> that matter) are supposed to use this - they have no idea if the
> underlying block device has shared blocks for LBA ranges it already
> has allocated and provisioned. IOWs, I don't know waht the semantics
> of this function is, it is not documented anywhere, and there is no
> use case present that tells me how it might get used.
>
> Yes, unshare at the file level means the filesystem tries to break
> internal data extent sharing, but if the block layers or backing
> devices are doing deduplication and sharing unknown to the
> application or filesystem, how do they ever know that this operation
> might need to be performed? In what cases do we need to be able to
> unshare block device ranges, and how is that different to the
> guarantees that REQ_PROVISION is already supposed to give for
> provisioned ranges that are then subsequently shared by the block
> device (e.g. by snapshots)?
>
> Also, from an API perspective, this is an "unshare" data operation,
> not a "provision" operation. Hence I'd suggest that the API should
> be blkdev_issue_unshare() rather than optional behaviour to
> _provision() which - before this patch - had clear and well defined
> meaning....
>
Fair points, the intent from the conversation with Darrick was the
addition of support for FALLOC_FL_UNSHARE_RANGE in patch 2 of v4
(originally suggested by Brian Forster in [1]): if we allow
fallocate(UNSHARE_RANGE) on a loop device (ex. for creating a
snapshot, similar in nature to the FICLONE example you mentioned on
the loop patch), we'd (ideally) want to pass it through to the
underlying layers and let them figure out what to do with it. But it
is only for situations where we are explicitly know what the
underlying layers are and what's the mecha

I agree though that it clouds the API a bit and I don't think it
necessarily needs to be a part of the initial patch series: for now, I
propose keeping just mode zero (and FALLOC_FL_KEEP_SIZE) handling in
the block series patch and drop this patch for now. WDYT?

Best
Sarthak

[1] https://patchwork.ozlabs.org/project/linux-ext4/patch/20230414000219.92=
640-2-sarthakkukreti@chromium.org/#3097746




> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

