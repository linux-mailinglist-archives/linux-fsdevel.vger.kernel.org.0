Return-Path: <linux-fsdevel+bounces-61-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EC7C53FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E3B2822BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BF1F190;
	Wed, 11 Oct 2023 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cN/B8LVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115461F17F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:28:04 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F3D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:28:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c28e35752cso87324021fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697027281; x=1697632081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhRvlvbfNNUdcA0ulFhXxzCGgb7/Qvy9mlYrvDGbA4o=;
        b=cN/B8LVK20ID3cbRoHCdy85aDxhYW2bmTgNYSKyMhID1L5XtN/oCGUaoeKe0Y8qR6V
         wWIcc9/V+S7SiC8cULvP2OrtOpaMyKK/xw44uWnuv/OkNfMDBwPReT3JjL3YgoFjQ2JG
         eMvcAX/djqNLa4MIq12a/tDfzZDrCO9MP10S907p8KYEdGanslH0PbbiUukqTbaTDgT7
         FpCz5dp/as2SM+evOuVmYCY4dAdRPCjrzoB8LMab9XyIXK+uF75rd5yfdaDlfU3NgzI3
         AijvrX3A4+QD/dwiAEzS9mMaz/jjwOUg82oUPDYbQT27fy5FIf7apoAf6Za5649y3D/c
         lsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027281; x=1697632081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhRvlvbfNNUdcA0ulFhXxzCGgb7/Qvy9mlYrvDGbA4o=;
        b=lc6i7JObWSg85Ci5po0mohpPQAPn3fkZFC5ZD1IOLq/MZuSn1uAOjvCqR4IJfL5jMa
         +fx4ZLbQdUSDCc0KssFN+og9fC3J6MLfNiVQ2TRcwmdAmCHDSXaQjSZ3m0pbzMX6SSpa
         h/qS6b9ujW1chBHZxdzHuG8Sg0LOevQw/lrPBLUgHoMmigLyQfNi+eXwpM8dJOS4GyHv
         Men1kiO6g5RtK9stBBOVHE7lb6IUZAPJ0fvbzYp2Yg4gigQQ5q0DF4PZyHYxF9/PMRWz
         YyR2Exf/6aUSRytP+gH1RyBtPUvUVhhDPVzZUIZE6+6xS9MPlR1XcHcWEGDa0kSPc2ZG
         QAVQ==
X-Gm-Message-State: AOJu0YwZemEqTgfFDvKz2L7oRqWjUmHUumkPBbkXRdE+jv4n6KC7NjQm
	jFGFxYxEcoFx4Ds33RSZ2qBvaWMYL4ky6m91wt1KMA==
X-Google-Smtp-Source: AGHT+IHm4h91Xo0Sfo6un9kAB1YWATtgKcIRKV/DG0s/oi+mth9sdLaot9TMvdLIG7eI6nTPi6+7LH1TSKKK+oU/b40=
X-Received: by 2002:a2e:998a:0:b0:2bc:b75e:b8b with SMTP id
 w10-20020a2e998a000000b002bcb75e0b8bmr18178845lji.38.1697027280733; Wed, 11
 Oct 2023 05:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com> <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3> <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3> <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
In-Reply-To: <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 11 Oct 2023 14:27:49 +0200
Message-ID: <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
To: Jan Kara <jack@suse.cz>
Cc: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	Christian Brauner <brauner@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:18=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> But without the other filesystems. I'll resend it with just the
> posix_acl.h hunk.

Thinking again, I don't think this is the proper solution. This may
server as a workaround so those broken filesystems don't suffer from
this bug, but it's not proper.

posix_acl_create() is only supposed to appy the umask if the inode
supports ACLs; if not, the VFS is supposed to do it. But if the
filesystem pretends to have ACL support but the kernel does not, it's
really a filesystem bug. Hacking the umask code into
posix_acl_create() for that inconsistent case doesn't sound right.

A better workaround would be this patch:
https://patchwork.kernel.org/project/linux-nfs/patch/151603744662.29035.491=
0161264124875658.stgit@rabbit.intern.cm-ag/
I submitted it more than 5 years ago, it got one positive review, but
was never merged.

This patch enables the VFS's umask code even if the filesystem
prerents to support ACLs. This still doesn't fix the filesystem bug,
but makes VFS's behavior consistent.

Max

