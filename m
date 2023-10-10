Return-Path: <linux-fsdevel+bounces-6-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C87C446F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67821C20E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453929D09;
	Tue, 10 Oct 2023 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCIxWwV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF03551F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:43:10 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F6106
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:43:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso71192466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977785; x=1697582585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiiBrXOxoUPtOhsPD+IILs+FkUT2KdEPOOeHI47Xduo=;
        b=eCIxWwV1lTaS+uvTo7+1oPxzEG8sL3be2j4na7IBZZF9X30gGPoSADeTIxSn6RODPy
         CCerajLaIGvRPOkpU3k9spBaJia6oWS5jvO8jrH6BmHfcHqiJeBEjosuZYmxjVsfcCmA
         KXATWGosnj5Kk4M58rhXiB30zSwE8z2p2zbxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977785; x=1697582585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiiBrXOxoUPtOhsPD+IILs+FkUT2KdEPOOeHI47Xduo=;
        b=dWKYGPUI3MZY8bQDidA45qXC4N5bsLePqmt0POFK0lbEHyv16fb+2nQ7PpbyT0sLGN
         ghU76xrIfDYYUMqeoFgnL/VBo4RllIfE9dUuO1r7FLqHhsBhx6+csJQNt1+2BaG50JEC
         74qT1WTaB1Vm+5LLonpJtLnenjEtRcp1ifQfGov2RZQfh0mYQx5Yz2uyNUibh8lKm/0r
         kbgxppO97Gx5xL+MP7h8PENazAos8H/quxZh4iUR+W4XT4ZMEJp8zFGeVgcjk2+iS1rR
         5L3pqailDGvEDJzeJcAcLHJ+tcd+ZmQ0o3nChZ92pe99/npzp5MYgEPZWGNZtXjtzQ8F
         Gcrg==
X-Gm-Message-State: AOJu0Yyy2f4yEUZQFDs8qYzo3w89bYH54qwNM1vnLJDUkfMI4CPNkvgI
	igyzCQ4yJnKK+3of2Vij38539qF5pdgenJK/wyOZPw==
X-Google-Smtp-Source: AGHT+IFotSdmS/weR8N0yeiFGDMN5c3jV8goT8FK1+WcHfetybABPHYPGgBblpU1FPb+bHDpyd0PwqqzLwRCp1nlk34=
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id
 dm17-20020a170907949100b009a5962ccb6cmr15511476ejc.31.1696977785597; Tue, 10
 Oct 2023 15:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org> <ZSNANlreccIVXuo+@dread.disaster.area>
In-Reply-To: <ZSNANlreccIVXuo+@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Tue, 10 Oct 2023 15:42:53 -0700
Message-ID: <CAG9=OMMM3S373Y6UEeXxnOyvMvA9wmAVd4Jrdjt3gzkz9d2yUg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Introduce provisioning primitives
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 4:50=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Oct 06, 2023 at 06:28:12PM -0700, Sarthak Kukreti wrote:
> > Hi,
> >
> > This patch series is version 8 of the patch series to introduce
> > block-level provisioning mechanism (original [1]), which is useful for =
provisioning
> > space across thinly provisioned storage architectures (loop devices
> > backed by sparse files, dm-thin devices, virtio-blk). This series has
> > minimal changes over v7[2].
> >
> > This patch series is rebased from the linux-dm/dm-6.5-provision-support=
 [1] on to
> > (cac405a3bfa2 Merge tag 'for-6.6-rc3-tag'). In addition, there's an
> > additional patch to allow passing through an unshare intent via REQ_OP_=
PROVISION
> > (suggested by Darrick in [4]).
>
> The XFS patches I just posted were smoke tested a while back against
> loop devices and then forward ported to this patchset. Good for
> testing that userspace driven file preallocation gets propagated by
> the filesystem down to the backing device correctly and that
> subsequent IO to the file then does the right thing (e.g. fio
> testing using fallocate() to set up the files being written to)....
>

Thanks! I've been testing with a WIP patch for ext4, I'll give your
patches a try. Once we are closer to submitting the filesystem
support, we can formalize the test into an xfstest (sparse file + loop
+ filesystem, fallocate() file, check the size of the underlying
sparse file).

Best
Sarthak


- Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

