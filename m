Return-Path: <linux-fsdevel+bounces-2670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A4A7E768B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 02:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5FC1C20D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 01:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B2ED7;
	Fri, 10 Nov 2023 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq5y27aI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE8A40
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 01:28:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162D44B9
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699579689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC+u4Re2AoTUGpqWOoMx+tYjldUA5tL8xtOql2ozAF4=;
	b=Nq5y27aIi9g2X1iiPBLVLkoG60ff5VCeNf2O0kcI+SKNHOR6zfWgJ3lKhIW5TmF6lhg3aa
	1jyA7BU/+hdg7e7GrPjhm61NE2nRgh9wFIfHWqtDkAkKCi7WqHZ+l/QxXjQunjrxzYBjun
	2z3/7lC9mxoV65YG5QvvCfJLtntgTvs=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-PDSrZqLiMkuazCJXpKkdBw-1; Thu, 09 Nov 2023 20:28:05 -0500
X-MC-Unique: PDSrZqLiMkuazCJXpKkdBw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1d5f4d5d848so1392746fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 17:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699579685; x=1700184485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC+u4Re2AoTUGpqWOoMx+tYjldUA5tL8xtOql2ozAF4=;
        b=vRFL2ftZl2KObQOMdQhJbFMSGrNbivgvfZ1UwnAOzL4ZGLTV8s1YAI5tVb+XnNB46q
         jQezTTHtzVBOOsL86McQRTvShO8A9DKvmvdKxNOe44ZytRJ+9JKOtxU6Wtsgu7tS/lr9
         dKAEiIs+QM4cQMIdpEcLN0ILsHcZTMatwPzoEMWd8Gmerv+sZMI420bDw1zi6C7FKayZ
         p0AfShSdEt2xWzZ0nX5rG6uexhW3nlhM5LdxQeSup3oUummhoRkiX38pA6U3h1izNvD/
         cimIZIhPZOqP9XrQDHIuXZxuPT4HGtlrMEVzG1JPKzLzsWJK2cweYsLZl5OfCLlWNyCR
         T77Q==
X-Gm-Message-State: AOJu0Yw0MCmUDnnfp2JwbjjVeWCrexXCB4d+aW3/eZKMq5ASwN+2i708
	hHH31LDEdmNVA96qSafHzgPMuAls87b1clTZLE/snjrDf4gAzxg3cNHOGqkZ4w7OMw0CTWHKTxR
	qcdKn6SIPL+WrqVEUA0pPz1OtwCYhb6q5obL6oZwpVA==
X-Received: by 2002:a05:6870:1314:b0:1ea:d76b:1457 with SMTP id 20-20020a056870131400b001ead76b1457mr6624731oab.7.1699579685237;
        Thu, 09 Nov 2023 17:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY6J8ZouDEA5qQMJiaMxmBZIrQRVPu28NAIQ+CGdUvmcYPLrHluYLqjgbiUv9YwzmkiYQWWU0SJT6gXHqvqxY=
X-Received: by 2002:a05:6870:1314:b0:1ea:d76b:1457 with SMTP id
 20-20020a056870131400b001ead76b1457mr6624714oab.7.1699579684985; Thu, 09 Nov
 2023 17:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org> <20231110010139.3901150-5-sarthakkukreti@chromium.org>
In-Reply-To: <20231110010139.3901150-5-sarthakkukreti@chromium.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 10 Nov 2023 09:27:48 +0800
Message-ID: <CAHj4cs9pS0hgWBpz9bzoJBGwh1iK+0Nuzc5RmJNyZOR5s-7oLw@mail.gmail.com>
Subject: Re: [PATCH] loop/010: Add test for mode 0 fallocate() on loop devices
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 9:02=E2=80=AFAM Sarthak Kukreti
<sarthakkukreti@chromium.org> wrote:
>
> A recent patch series[1] adds support for calling fallocate() in mode 0

The patch link is missing in this patch.

> on block devices. This test adds a basic sanity test for loopback devices
> setup on a sparse file and validates that writes to the loopback device
> succeed, even when the underlying filesystem runs out of space.
>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  tests/loop/010     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/010.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100644 tests/loop/010
>  create mode 100644 tests/loop/010.out
>
> diff --git a/tests/loop/010 b/tests/loop/010
> new file mode 100644
> index 0000000..091be5e
> --- /dev/null
> +++ b/tests/loop/010
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Google LLC.
> +# Author: sarthakkukret@google.com (Sarthak Kukreti)
> +#
> +# Test if fallocate() on a loopback device provisions space on the under=
lying
> +# filesystem and writes on the loop device succeed, even if the lower
> +# filesystem is filled up.
> +
> +. tests/loop/rc
> +
> +DESCRIPTION=3D"Loop device fallocate() space provisioning"
> +QUICK=3D1
> +
> +requires() {
> +       _have_program mkfs.ext4
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       local mount_dir=3D"$TMPDIR/mnt"
> +       mkdir -p ${mount_dir}
> +
> +       local image_file=3D"$TMPDIR/img"
> +       truncate -s 1G "${image_file}"
> +
> +       local loop_device
> +       loop_device=3D"$(losetup -P -f --show "${image_file}")"
> +
> +       mkfs.ext4 ${loop_device} &> /dev/null
> +       mount -t ext4 ${loop_device} ${mount_dir}
> +
> +       local provisioned_file=3D"${mount_dir}/provisioned"
> +       truncate -s 200M "${provisioned_file}"
> +
> +       local provisioned_loop_device
> +       provisioned_loop_device=3D"$(losetup -P -f --show "${provisioned_=
file}")"
> +
> +       # Provision space for the file: without provisioning support, thi=
s fails
> +       # with EOPNOTSUPP.
> +       fallocate -l 200M "${provisioned_loop_device}"
> +
> +       # Fill the filesystem, this command will error out with ENOSPC.
> +       local fs_fill_file=3D"${mount_dir}/fill"
> +       dd if=3D/dev/zero of=3D"${fs_fill_file}" bs=3D1M count=3D1024 sta=
tus=3Dnone &>/dev/null
> +       sync
> +
> +       # Write to provisioned loop device, ensure that it does not run i=
nto ENOSPC.
> +       dd if=3D/dev/zero of=3D"${provisioned_loop_device}" bs=3D1M count=
=3D200 status=3Dnone
> +       sync
> +
> +       # Cleanup.
> +       losetup --detach "${provisioned_loop_device}"
> +       umount "${mount_dir}"
> +       losetup --detach "${loop_device}"
> +       rm "${image_file}"
> +
> +       echo "Test complete"
> +}
> \ No newline at end of file
> diff --git a/tests/loop/010.out b/tests/loop/010.out
> new file mode 100644
> index 0000000..068c489
> --- /dev/null
> +++ b/tests/loop/010.out
> @@ -0,0 +1,2 @@
> +Running loop/009
> +Test complete
> --
> 2.42.0.758.gaed0368e0e-goog
>
>


--=20
Best Regards,
  Yi Zhang


