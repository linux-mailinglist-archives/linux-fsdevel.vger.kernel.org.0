Return-Path: <linux-fsdevel+bounces-2699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94B7E7942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7963281779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C379C6AA5;
	Fri, 10 Nov 2023 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jyjzjcwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A44A40
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:25:48 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F336FA5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:25:47 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9df8d0c2505so352862066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699597546; x=1700202346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31LtcSKpeisTVB2mz3N5vJ0iqQnYWaagnM9xZbOW8hI=;
        b=JyjzjcwauyTtcqhBS8UvrLRTbz/zUtlAfQ/ZBJxVLh76smFgqA+WZ7GuiZ813f1BVl
         ngJOkXJaeOON3kqLxp94JoTUjLr+38G0uBJ7+8lZ0nM8PZD+vWMQt7msWN06gtq+wqDD
         dZBhYBz1HsnaKdMzAgMyFYHJbxaLepMG+D9DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597546; x=1700202346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31LtcSKpeisTVB2mz3N5vJ0iqQnYWaagnM9xZbOW8hI=;
        b=QwF4hTN7ky38ssInp39f9oWeJkUDD1ZgZTVLRhAidu8Aq5NZUelFGgyTi9F+X1kZvb
         petycJ1kDnvV8ghMgME2Rsi1xJ0Cjd0Gs3TH3/QNKkSGdLbc32gZ0cwS2JQRTZCO1WsA
         +k6UKUOJk3PZXQ4lw6Y+tj3+tCQH20MTDN4/qnDuGxV3H8f8+7YqGTELRyFEEJyeL8ih
         xPOAskQjTY5KWGUIgbPxxK/pcf+khSf4FmxdlCIVbukEcld+yv2mFBCq8uVfhaJdne17
         aq2uuumCQ0AXD9jBqoSrblmpSNExxyHFPo5QPUrP+/1Q1WE+E27FbHBjAkIZyDpKLPjl
         dEGQ==
X-Gm-Message-State: AOJu0Yye1iGGCB0xFHCfG29Zzov2TsOSl3Z3a0pPGKqSnoI4HPcplqWb
	O93eycrrDCQbifv3EqB7lL+H2ef8BAFrFc1qMNvFMA==
X-Google-Smtp-Source: AGHT+IEXD1W//MfsTwxhlIUHRcn5eqbDoMdzk+7vyDeixRhGaCIaTU8BxZfUm8hNFI4xtXjq/4To+Yc/OCr/8S2kIzQ=
X-Received: by 2002:a17:906:5ad1:b0:9ae:3768:f0ce with SMTP id
 x17-20020a1709065ad100b009ae3768f0cemr1340464ejs.0.1699597545623; Thu, 09 Nov
 2023 22:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <20231110010139.3901150-5-sarthakkukreti@chromium.org> <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
In-Reply-To: <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Thu, 9 Nov 2023 22:25:33 -0800
Message-ID: <CAG9=OMOsurTDASByqXWiY9W2arWsd6-vNLnRUk2SvgEbPSg5VQ@mail.gmail.com>
Subject: Re: [PATCH] loop/010: Add test for mode 0 fallocate() on loop devices
To: Yi Zhang <yi.zhang@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I meant to add a reference to the latest REQ_OP_PROVISION patch series
that this patch accompanied, I'll reword the commit so that it is
clearer:

[1] https://lore.kernel.org/lkml/20231110010139.3901150-1-sarthakkukreti@ch=
romium.org/

Best
Sarthak

On Thu, Nov 9, 2023 at 5:28=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> On Fri, Nov 10, 2023 at 9:02=E2=80=AFAM Sarthak Kukreti
> <sarthakkukreti@chromium.org> wrote:
> >
> > A recent patch series[1] adds support for calling fallocate() in mode 0
>
> The patch link is missing in this patch.
>
> > on block devices. This test adds a basic sanity test for loopback devic=
es
> > setup on a sparse file and validates that writes to the loopback device
> > succeed, even when the underlying filesystem runs out of space.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  tests/loop/010     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/loop/010.out |  2 ++
> >  2 files changed, 62 insertions(+)
> >  create mode 100644 tests/loop/010
> >  create mode 100644 tests/loop/010.out
> >
> > diff --git a/tests/loop/010 b/tests/loop/010
> > new file mode 100644
> > index 0000000..091be5e
> > --- /dev/null
> > +++ b/tests/loop/010
> > @@ -0,0 +1,60 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2023 Google LLC.
> > +# Author: sarthakkukret@google.com (Sarthak Kukreti)
> > +#
> > +# Test if fallocate() on a loopback device provisions space on the und=
erlying
> > +# filesystem and writes on the loop device succeed, even if the lower
> > +# filesystem is filled up.
> > +
> > +. tests/loop/rc
> > +
> > +DESCRIPTION=3D"Loop device fallocate() space provisioning"
> > +QUICK=3D1
> > +
> > +requires() {
> > +       _have_program mkfs.ext4
> > +}
> > +
> > +test() {
> > +       echo "Running ${TEST_NAME}"
> > +
> > +       local mount_dir=3D"$TMPDIR/mnt"
> > +       mkdir -p ${mount_dir}
> > +
> > +       local image_file=3D"$TMPDIR/img"
> > +       truncate -s 1G "${image_file}"
> > +
> > +       local loop_device
> > +       loop_device=3D"$(losetup -P -f --show "${image_file}")"
> > +
> > +       mkfs.ext4 ${loop_device} &> /dev/null
> > +       mount -t ext4 ${loop_device} ${mount_dir}
> > +
> > +       local provisioned_file=3D"${mount_dir}/provisioned"
> > +       truncate -s 200M "${provisioned_file}"
> > +
> > +       local provisioned_loop_device
> > +       provisioned_loop_device=3D"$(losetup -P -f --show "${provisione=
d_file}")"
> > +
> > +       # Provision space for the file: without provisioning support, t=
his fails
> > +       # with EOPNOTSUPP.
> > +       fallocate -l 200M "${provisioned_loop_device}"
> > +
> > +       # Fill the filesystem, this command will error out with ENOSPC.
> > +       local fs_fill_file=3D"${mount_dir}/fill"
> > +       dd if=3D/dev/zero of=3D"${fs_fill_file}" bs=3D1M count=3D1024 s=
tatus=3Dnone &>/dev/null
> > +       sync
> > +
> > +       # Write to provisioned loop device, ensure that it does not run=
 into ENOSPC.
> > +       dd if=3D/dev/zero of=3D"${provisioned_loop_device}" bs=3D1M cou=
nt=3D200 status=3Dnone
> > +       sync
> > +
> > +       # Cleanup.
> > +       losetup --detach "${provisioned_loop_device}"
> > +       umount "${mount_dir}"
> > +       losetup --detach "${loop_device}"
> > +       rm "${image_file}"
> > +
> > +       echo "Test complete"
> > +}
> > \ No newline at end of file
> > diff --git a/tests/loop/010.out b/tests/loop/010.out
> > new file mode 100644
> > index 0000000..068c489
> > --- /dev/null
> > +++ b/tests/loop/010.out
> > @@ -0,0 +1,2 @@
> > +Running loop/009
> > +Test complete
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >
> >
>
>
> --
> Best Regards,
>   Yi Zhang
>

