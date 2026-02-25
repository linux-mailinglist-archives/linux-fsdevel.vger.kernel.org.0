Return-Path: <linux-fsdevel+bounces-78350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OItjBn7Mnmm0XQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:18:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199D195A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95F1C3079B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B584168BD;
	Wed, 25 Feb 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UwmxbtOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA8392802
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014529; cv=pass; b=kg28sfxD4Mr2ubwKv5zzt6ek8vI74LqDKr6kF2czGhZ3DKbIiOxV3VXEba+Pkjaw9hYtp6DSqgzVSExyk34UeJm00nPszW+b2CQa6XSGCub1RTkTV1542+giLmVn/gh7gV1cO0eQQ363fIPta/0bC0gpnWQS444ZdzqBn9FcdRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014529; c=relaxed/simple;
	bh=cEhN1Iv+3+5AHAwjY+4bbx1KSfiXSQ19i96bxSRH5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHgTsIt7dmAVaZtcb6+sHYk1Cspya0cWKQKmm2+awbGqOjhAPtlOPPR7w7JDpW6QJ3/aYR5H+cFHQX2OCGFLIrQikuMFOBjS/KIygp3f0mpkGY+ABQUvIfOceZcWGoWq1TVJ7qJvVBUlNOTFasDh4Rbx5OjbX4QFUiNaxi+a5wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UwmxbtOV; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-389e71756d8so4019641fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 02:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014522; cv=none;
        d=google.com; s=arc-20240605;
        b=HGEtzkJCDvyiTmjkTMmsLnoeJuBnEOHhGBvTNnHMT9H/jdCB1TXVOZjcQFG9kSoHYk
         LHSS8uAZrJKrlmxf495rSlt2bqMcFV2tH5daMz1KISftObgx6JjqAK3fPx3NfuN34txr
         5aYOPGRYD/g8+A2cjQ0F3lWnZ9XTYVL1DDba8a1fr6Tx6ovnRx2udtKhFzlxmkU49eIK
         qyKQHZU168vqCU3Y4FtZkau3VurV77NtJyEUa65ogrFpn+DwHTkR5/uBxPIsy86mmRsl
         6ZQZNVnBR+ziafFcFFpvVFObjwkOYEYP1l5HIKzluMtDYyXtJv4Uk+EGcU7zGh44LGfL
         Fhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        fh=qebdMxCyGhmlHEvKIgHwLnSBYRsUqeakfGeFS02ZpEw=;
        b=WlBogENPEv+dWh4K8MN8Zc+y8kVxWin613kx4Dz6rSb/kaiuEmOjH0lsn5tvjYX/0o
         MsnBfar1ErNZGY/kqsVZ9gRCiWA4dR7CoyTDNiyUrO3G3RRVtK7Eo6zSUTslqZmekpND
         8A3XNXz7QmAnRUHCNshYeOuwr1crSJI7KUU3yJlSsIykTvtE44apjWMr1Fm9v6Op5nFx
         IMC5Aqe2Sixrthsvm1mzZVe+HP0GjYJ9b1myCiCNckqIiVk+fqoSyLWFeDG0ndOmJtz8
         S9L6+HmokW5EJemS0BWgSmwsoT+oJr7fofZpK4G9meeBrzEhcK3c1TZVPiHLOtMiehkR
         qKuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014522; x=1772619322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=UwmxbtOV/nmBYuGKi6UEDOpjEpvqRBEHYzg6GXhGFuCv6F2c0ln5jRhSEuGWXMEIas
         ZGbF66mk1OBxyZTgEzdiq9SqaR6dkIUffoTe3ofa+8HgaJFzpC/yLt32HJBx73UmMB9r
         RlGPIsC6Gt32pLnpp4Ek19kkYGsNPcGCZFrBt+WLj4sBWaioDuOe+1Vh7oBMuIAUmyLX
         2Ss/ANz3rtwZUZsvzXZjGAYkhtTJSKsvR62bhCpCJkMlOXGSPYAgCMgc/ooJRgfRkVTI
         Zp/Sm1X3mB4H/9EnvLBwsS8QH2ewFtV+LLo5BYzDGJiBRc+AyHg042erl0IVfydZyCM7
         1Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014522; x=1772619322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=vb0zRIBEgcfuyNMS29kDS2WZhfpI6FgsPoI/5vfWKJgpQ8FX1kQGxO23tk73l3KGXV
         YBdOiQYDE/A7iRbgOZiq7dwYuDrp4x7wnmaQTCl9Yfo6ew+Ikntn+UM/WjjHtm0nK+a5
         ALmf6bZuIh3oL6p5q+U8S++pvsMhYFKCNVMih+FHBcwFZGZAUabEo09QiVLHvGLteJ5C
         AP+DaN95Vft1+huAWQal6EDbKrySa4Rs9OEbD1j0pazNcPZqws+6qOY9thxbqDa4R2qn
         1Y96nyb7aGZlue4WsGG7Mtx8TTWbpeQpVxF0X/ODsN0W0xxNB4oCgFPIBVDcpXbBRapL
         VR5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhlM6lTlsfr72Rifyi28TrOKdegZhziHk6yHA6o3ArKopxn7aalqAoGoETenjJtJXDctpAp8RJpNfOGh4u@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpqGO5bVZVzcBsiWgIU4NDbPXqeGuOSpy2S0dVDvyZ7Fecdyk
	wm4xPGokQXNrJ9+kNSaGEkH+AJjm/ZpxoZ+AEMFwUfMgtNSsOOqmi5jPgjA0vGPgsn5uhlYpPFG
	amtToGBlMF450lJDtnLUWFAGGZ/IyGZUvVS6R6sWXcg==
X-Gm-Gg: ATEYQzyoGz4ytnvEGDPfkwzVTKqqMMYoCL/bYj6jDA2d/snmQEU3IOmaNj75qOzdAu6
	Ik/vc8SZMuyl29pwApRjSgLG75AdbWjDECL9gYqxZfjLz3cyaSmvWOFzteOFlD064qLwdspg+oA
	wj5+X5NxASrHNiKuPOb35ZwAhBT4FwPq6A+zEwdxeJQOwbzk+BCPLAmrS5Ye7mGj9dOlqs2fVMV
	RPEN8s5ooe6mf2GCt18F5ojzO5+tzFuncSPH1NVCnAYUGATdczSizkvM3rw5Cla3lt/wLHt6fSd
	tqPo4KDY/n3klx7Rdyxf+G1YD36L7Ep/0jKTNmdJSwM559eRAJwrnu5SfzYxjNqwFzCg
X-Received: by 2002:a05:651c:981:b0:385:9b50:91a8 with SMTP id
 38308e7fff4ca-389a5d4e691mr49137391fa.15.1772014521621; Wed, 25 Feb 2026
 02:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
In-Reply-To: <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:15:10 +0100
X-Gm-Features: AaiRm526FWUEGWm_hy7H18Kx_R9h0RTFeFOS6FCw0pCWHIRaUmeSA-DegrV6Fgs
Message-ID: <CAJpMwyiys85=WG-EQtsioo3OOiRDToUh1jE18Uj2Be2JdzNXDA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78350-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wdc.com,suse.de,nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,lst.de,kernel.dk,grimberg.me,mit.edu,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run-fstests.sh:url,ionos.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7199D195A6E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:44=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/15/26 10:18 PM, Haris Iqbal wrote:
> >>  From my view, blktests keep on finding kernel bugs. I think it demons=
trates the
> >> value of this community effort, and I'm happy about it. Said that, I f=
ind what
> >> blktests can improve more, of course. Here I share the list of improve=
ment
> >> opportunities from my view point (I already mentioned the first three =
items).
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
>
> This is actually rather trivial to solve I have some pre-made things for
> fstests and that can be adopted for blktests as well:
>
> vng \
>      --user=3Droot -v --name vng-tcmu-runner \
>      -a loglevel=3D3 \
>      --run $KDIR \
>      --cpus=3D8 --memory=3D8G \
>      --exec "~johannes/src/ci/run-fstests.sh" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi0 -drive
> file=3D/dev/sda,format=3Draw,if=3Dnone,id=3Dzbc0 -device
> scsi-block,bus=3Dscsi0.0,drive=3Dzbc0" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi1 -drive
> file=3D/dev/sdb,format=3Draw,if=3Dnone,id=3Dzbc1 -device
> scsi-block,bus=3Dscsi1.0,drive=3Dzbc1"
>
> and run-fstests.sh is:
>
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
>
> DIR=3D"/tmp/"
> MKFS=3D"mkfs.btrfs -f"
> FSTESTS_DIR=3D"/home/johannes/src/fstests"
> HOSTCONF=3D"$FSTESTS_DIR/configs/$(hostname -s)"
> TESTDEV=3D"$(grep TEST_DEV $HOSTCONF | cut -d '=3D' -f 2)"
>
> mkdir -p $DIR/{test,scratch,results}
> $MKFS $TESTDEV
>
> cd $FSTESTS_DIR
> ./check -x raid
>
> I'm not sure it'll make sense to include this into blktests other than
> maybe providing an example in the README.

You're right. It is pretty trivial to run on VMs, but only after
everything is set up.
Adding it to blktests would allow this setup to be done (and run tests
after that) on any system by running just a couple of commands.

>
>
> Byte,
>
>      Johannes
>

