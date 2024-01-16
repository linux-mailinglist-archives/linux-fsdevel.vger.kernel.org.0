Return-Path: <linux-fsdevel+bounces-8034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BD82EAF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E04D1C22CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994212B7A;
	Tue, 16 Jan 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="bCYy+LAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757B125D8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd81b09e83so62313791fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705394359; x=1705999159; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1CvrrNcIkgS+m/4ZjQFdMQQSZGMBxfOVQFgXMc67Lo=;
        b=bCYy+LARQOsxTtrKuNTZR/GI9HCJXaJw1BmktfQS+P5p6oRtQb/U6zkuPhxm1YJRNs
         woI7+ru2XJiMBN655of4X0cpByvVG1JEETNe34ZLn/3C1DwxEz6+Yw+DCdX+Dr1zcU1m
         0gSho1pDgmgLurMoOqwDo+JNWnblUrOdpytT+X6hFg8U8M7jaUdnoDxSR/2RtGHW4a1L
         bTkJYH0m24qU4LkmAkAoeddBmArez/A8L1uyUvW2ZkXCcA9K5e99kT2TFGfFvczgxlBZ
         zjq4UOYdsK1PkBiq6bRiWYqMc+iWGJBc04WYnFqXI1FxbJ6r9QN5m2+TQ6VXSCbgzv8X
         d/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705394359; x=1705999159;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1CvrrNcIkgS+m/4ZjQFdMQQSZGMBxfOVQFgXMc67Lo=;
        b=dg4LOauy+mb9hV6SFqlwa4qjyr7CY5yBOhy1nM3fb4C4VAZrCxpD+zyNFgnk2MyTv4
         DtjQjwyTIv9hi2DSVBTVt/8g6/3LLv/b6bXSxpIJvcg4rpFty9RHZDAhKAgVlZlrIdW6
         p6BYovTaYcWhH4oxwEk79HaBtbI/iYBRHpprIaVzW10TThD8CAJORCAzYD8S3TsDPMjc
         YW3b0Tf9bVtvRPfFvm4ZYBeDEK4eNQ2bov/glvgNnLMdMXh6f1MsnPl8issU3Zqz0ciA
         1Q++tHitF1xOj5s7GaqrCCcgiTKu4FDvZayiXjTyKTmKokUr93R51e3OPPcxiIgbg0Xh
         VPeQ==
X-Gm-Message-State: AOJu0Yyl1m4AC1N9JNGzIcngrY4mLPqPPAckKpYXsphSkY6EH1Lst+F/
	XRVnrok2wnqXQ0/wJ+2BTSOHilD4IDudww==
X-Google-Smtp-Source: AGHT+IHzpBPMFejAuhe5xiepHjjQFUz2ftX3lyYNgoaOeP7qb8f9VKs4w9CNnTQlg+H0ndEF+6okqQ==
X-Received: by 2002:a2e:b1c7:0:b0:2cc:5546:1ee0 with SMTP id e7-20020a2eb1c7000000b002cc55461ee0mr1298482lja.133.1705394358825;
        Tue, 16 Jan 2024 00:39:18 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:5d31:9b9f:2cc5:3e9c])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9912000000b002cd46eb25f1sm1576357lji.59.2024.01.16.00.39.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:39:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
Date: Tue, 16 Jan 2024 11:39:16 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 slava@dubeiko.com,
 Kanchan Joshi <joshi.k@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
 <20240115084631.152835-1-slava@dubeyko.com>
 <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 15, 2024, at 8:54 PM, Javier Gonz=C3=A1lez =
<javier.gonz@samsung.com> wrote:
>=20
> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>> Hi Javier,
>>=20
>> Samsung introduced Flexible Data Placement (FDP) technology
>> pretty recently. As far as I know, currently, this technology
>> is available for user-space solutions only. I assume it will be
>> good to have discussion how kernel-space file systems could
>> work with SSDs that support FDP technology by employing
>> FDP benefits.
>=20
> Slava,
>=20
> Thanks for bringing this up.
>=20
> First, this is not a Samsung technology. Several vendors are building
> FDP and several customers are already deploying first product.
>=20
> We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
> block layer until we had a clear idea on use-cases. We have been
> following and reviewing Bart's write hint series and it covers all the
> block layer and interface needed to support FDP. Currently, we have
> patches with small changes to wire the NVMe driver. We plan to submit
> them after Bart's patches are applied. Now it is a good time since we
> have LSF and there are also 2 customers using FDP on block and file.
>=20
>>=20
>> How soon FDP API will be available for kernel-space file systems?
>=20
> The work is done. We will submit as Bart's patches are applied.
>=20
> Kanchan is doing this work.
>=20
>> How kernel-space file systems can adopt FDP technology?
>=20
> It is based on write hints. There is no FS-specific placement =
decisions.
> All the responsibility is in the application.
>=20
> Kanchan: Can you comment a bit more on this?
>=20
>> How FDP technology can improve efficiency and reliability of
>> kernel-space file system?
>=20
> This is an open problem. Our experience is that making data placement
> decisions on the FS is tricky (beyond the obvious data / medatadata). =
If
> someone has a good use-case for this, I think it is worth exploring.
> F2FS is a good candidate, but I am not sure FDP is of interest for
> mobile - here ZUFS seems to be the current dominant technology.
>=20

If I understand the FDP technology correctly, I can see the benefits for
file systems. :)

For example, SSDFS is based on segment concept and it has multiple
types of segments (superblock, mapping table, segment bitmap, b-tree
nodes, user data). So, at first, I can use hints to place different =
segment
types into different reclaim units. The first point is clear, I can =
place different
type of data/metadata (with different =E2=80=9Chotness=E2=80=9D) into =
different reclaim units.
Second point could be not so clear. SSDFS provides the way to define
the size of erase block. If it=E2=80=99s ZNS SSD, then mkfs tool uses =
the size of zone
that storage device exposes to mkfs tool. However, for the case of =
conventional
SSD, the size of erase block is defined by user. Technically speaking, =
this size
could be smaller or bigger that the real erase block inside of SSD. =
Also, FTL could
use a tricky mapping scheme that could combine LBAs in the way making
FS activity inefficient even by using erase block or segment concept. I =
can see
how FDP can help here. First of all, reclaim unit makes guarantee that =
erase
blocks or segments on file system side will match to erase blocks =
(reclaim units)
on SSD side. Also, I can use various sizes of logical erase blocks but =
the logical
erase blocks of the same segment type will be placed into the same =
reclaim unit.
It could guarantee the decreasing the write amplification and =
predictable reclaiming on
SSD side. The flexibility to use various logical erase block sizes =
provides
the better efficiency of file system because various workloads could =
require
different logical erase block sizes.

Technically speaking, any file system can place different types of =
metadata in
different reclaim units. However, user data is slightly more tricky =
case. Potentially,
file system logic can track =E2=80=9Chotness=E2=80=9D or frequency of =
updates of some user data
and try to direct the different types of user data in different reclaim =
units.
But, from another point of view, we have folders in file system =
namespace.
If application can place different types of data in different folders, =
then, technically
speaking, file system logic can place the content of different folders =
into different
reclaim units. But application needs to follow some =E2=80=9Cdiscipline=E2=
=80=9D to store different
types of user data (different =E2=80=9Chotness=E2=80=9D, for example) in =
different folders.

Thanks,
Slava.


