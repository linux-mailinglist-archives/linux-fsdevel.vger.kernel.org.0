Return-Path: <linux-fsdevel+bounces-74323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B37D39A83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E662C30019EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7930E0F8;
	Sun, 18 Jan 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="qZcO2pTb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="N51dnn1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-124.smtp-out.amazonses.com (a11-124.smtp-out.amazonses.com [54.240.11.124])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CF30C345;
	Sun, 18 Jan 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775360; cv=none; b=Bo4G4EKK5yiDcrRYsG0Sqr4OuH5X0J+VT3dc0yFIm9P/kSZ6OQgvLa6H4W6iJgHr5OHD2pnhY785jF68QnCm98KJU0g/trH5X894Lk77tGCSd0Oy7sj8mePaRg671K5yNjF621g1K/BdN/gAodrVOSODJrvT15k1SjiumNEMDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775360; c=relaxed/simple;
	bh=yKHfUeZ7rs6sbyWVsDWPsIJqM94R8Uy96Q9wQ2otEC8=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=kkzRm3FB9zkBf+kQBSCgJ+mOfBQC4aqKrq/UVFtBJ55P7OkjIY/o04s0/v4E2JuG6Za9zI3szT6uMofPOjhb/20Nyvymq2tRdbliXSObs1JuPSPwcH7+vPDaijH6nEwrRdM4Snvw+imr8UdhaaCsmooFcfpD5HkJ6tk3bZ1TRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=qZcO2pTb; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=N51dnn1M; arc=none smtp.client-ip=54.240.11.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775358;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=yKHfUeZ7rs6sbyWVsDWPsIJqM94R8Uy96Q9wQ2otEC8=;
	b=qZcO2pTbh4f8Hn1yFa/hBEyNCIJxfD+rueU3mXfqeg09GtALjuvRC/Nki7ntcXEi
	Zpy92SY0gtvIJpdA/sfMYfiq8yXn598c2FD5AKE87gCH8rT+r/YJXEN1LlKQOlRTPfs
	GNcf9UnrnrGg17i6ojcpX+A3QpdHP5y7VGmK7JDI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775358;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=yKHfUeZ7rs6sbyWVsDWPsIJqM94R8Uy96Q9wQ2otEC8=;
	b=N51dnn1MjvuHmJPh6t5XDRX8jsBPW7oq/2qpJB4eKvqSRQLNctWCssTYzCWuKw/z
	HAs55cTwiM25Bjw2xGoCB4n+LA83KzyWyhZ+J21D9xZ7YZY6LU5ywXP5Af7JGP6/wbR
	ouN8FYifrvVD0lNGC165tnpQAdTLUuBxAKqMm9t0=
Subject: [PATCH BUNDLE v7] famfs: Fabric-Attached Memory File System
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Sun, 18 Jan 2026 22:29:18 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20260118222911.92214-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQ==
Thread-Topic: [PATCH BUNDLE v7] famfs: Fabric-Attached Memory File System
X-Wm-Sent-Timestamp: 1768775357
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.124

This is a coordinated patch submission for famfs (Fabric-Attached Memory=0D=
=0AFile System) across three repositories:=0D=0A=0D=0A  1. Linux kernel (=
cover + 19 patches) - dax fsdev driver + fuse/famfs=20=0D=0A     integrat=
ion=0D=0A  2. libfuse (cover + 3 patches) - famfs protocol support for fu=
se servers=0D=0A  3. ndctl/daxctl (cover + 2 patches) - support for the n=
ew "famfs" devdax=0D=0A     mode=0D=0A=0D=0AEach series is posted as a re=
ply to this cover message, with individual=0D=0Apatches replying to their=
 respective series cover.=0D=0A=0D=0AOverview=0D=0A--------=0D=0AFamfs ex=
poses shared memory as a file system. It consumes shared memory=0D=0Afrom=
 dax devices and provides memory-mappable files that map directly to=0D=0A=
the memory with no page cache involvement. Famfs differs from conventiona=
l=0D=0Afile systems in fs-dax mode in that it handles in-memory metadata =
in a=0D=0Asharable way (which begins with never caching dirty shared meta=
data).=0D=0A=0D=0AFamfs started as a standalone file system [1,2], but th=
e consensus at=0D=0ALSFMM 2024 and 2025 [3,4] was that it should be porte=
d into fuse.=0D=0A=0D=0AThe key performance requirement is that famfs mus=
t resolve mapping faults=0D=0Awithout upcalls. This is achieved by fully =
caching the file-to-devdax=0D=0Ametadata for all active files via two fus=
e client/server message/response=0D=0Apairs: GET_FMAP and GET_DAXDEV.=0D=0A=
=0D=0APatch Series Summary=0D=0A--------------------=0D=0A=0D=0ALinux Ker=
nel (V7, 19 patches):=0D=0A  - dax: New fsdev driver (drivers/dax/fsdev.c=
) providing a devdax mode=0D=0A    compatible with fs-dax. Devices can be=
 switched among 'devdax', 'fsdev'=0D=0A    and 'system-ram' modes via dax=
ctl or sysfs.=0D=0A  - fuse: Famfs integration adding GET_FMAP and GET_DA=
XDEV messages for=0D=0A    caching file-to-dax mappings in the kernel.=0D=
=0A=0D=0Alibfuse (V7, 3 patches):=0D=0A  - Updates fuse_kernel.h to kerne=
l 6.19 baseline=0D=0A  - Adds famfs DAX fmap protocol definitions=0D=0A  =
- Implements famfs DAX fmap support for fuse servers=0D=0A=0D=0Andctl/dax=
ctl (V4, 2 patches):=0D=0A  - Adds daxctl support for the new "famfs" mod=
e of devdax=0D=0A  - Adds test/daxctl-famfs.sh for testing mode transitio=
ns=0D=0A=0D=0AChanges Since V2 (kernel)=0D=0A-------------------------=0D=
=0A- Dax: Completely new fsdev driver replaces the dev_dax_iomap modifica=
tions.=0D=0A  Uses MEMORY_DEVICE_FS_DAX type with order-0 folios for fs-d=
ax compatibility.=0D=0A- Dax: The "poisoned page" problem is properly fix=
ed via fsdev_clear_folio_state()=0D=0A  which clears stale mapping/compou=
nd state when fsdev binds.=0D=0A- Dax: Added dax_set_ops() and driver unb=
ind protection while filesystem mounted.=0D=0A- Fuse: Famfs mounts requir=
e CAP_SYS_RAWIO (exposing raw memory devices).=0D=0A- Fuse: Added DAX add=
ress_space_operations with noop_dirty_folio.=0D=0A- Rebased to latest ker=
nels, compatible with recent dax refactoring.=0D=0A=0D=0ATesting=0D=0A---=
----=0D=0AThe famfs user space [5] includes comprehensive smoke and unit =
tests that=0D=0Aexercise all three components together. The ndctl series =
includes a=0D=0Adedicated test for famfs mode transitions.=0D=0A=0D=0ARef=
erences=0D=0A----------=0D=0A[1] https://lore.kernel.org/linux-cxl/cover.=
1708709155.git.john@groves.net/=0D=0A[2] https://lore.kernel.org/linux-cx=
l/cover.1714409084.git.john@groves.net/=0D=0A[3] https://lwn.net/Articles=
/983105/ (LSFMM 2024)=0D=0A[4] https://lwn.net/Articles/1020170/ (LSFMM 2=
025)=0D=0A[5] https://famfs.org (famfs user space)=0D=0A[6] https://lore.=
kernel.org/linux-cxl/20250703185032.46568-1-john@groves.net/ (V2)=0D=0A[7=
] https://lore.kernel.org/linux-fsdevel/20260107153244.64703-1-john@grove=
s.net/T/#m0000d8c00290f48c086b8b176c7525e410f8508c (related ndctl series)=
=0D=0A--=0D=0AJohn Groves=0D=0A

