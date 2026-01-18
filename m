Return-Path: <linux-fsdevel+bounces-74343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA3D39AC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 278D1300C36C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489E2C15A3;
	Sun, 18 Jan 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="b0lO11ZA";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IV1iW4/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a8-208.smtp-out.amazonses.com (a8-208.smtp-out.amazonses.com [54.240.8.208])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4330F92D;
	Sun, 18 Jan 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775686; cv=none; b=ZhXKuCKkJgZfCLJuFEeB/6OUtfe3M+G2/GR8cRd9KiT5hwy5p6cO4G1fLJnmr1GAmhzI4HGYsO6gXxHcZZ9nLC0JEJgEqAfLsZc8Mc0ljShKeSqc7GxeY6Vo0yzSOtAVdQmQplCOPwtVLqVKBVfn/f22GcImrQRXlwjDcfwmWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775686; c=relaxed/simple;
	bh=rQEgQ0JGo10vv2LMzcyy4/RuVUmGQ2+gkrNAtrLbTRo=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=AjPTF12P/KefZ2Oe+K88Q1OmzvZmjxGlQfR3sqUlukfaSOcwBPybyP9RSjzzlZBVf6fPElAOZQIyNkiihrOMW/qJtMIXicFLqxKnnVvAuXWsyuMNbM+ZvM9cQhCZSgFZGe8lz6WeJvnmNjA+/yNxbdsJXrCaiUv+S/WZgloPZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=b0lO11ZA; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=IV1iW4/m; arc=none smtp.client-ip=54.240.8.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775670;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=rQEgQ0JGo10vv2LMzcyy4/RuVUmGQ2+gkrNAtrLbTRo=;
	b=b0lO11ZAun+fpoxGgPk12REgqVQGpJ78Ps1+n65MOfJPGnd6DfCfrgqbRwBLp7zT
	H/1yBNX8S/EKu7ZWjGwdDE0AE7Ih4TXeXGFPiezDhaP6YQRo8BGip7u/O4nLHmHcCAR
	xvuT8kYFOyoWcR4coK0o92RVoxD4GglxYAIL/qBE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775670;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=rQEgQ0JGo10vv2LMzcyy4/RuVUmGQ2+gkrNAtrLbTRo=;
	b=IV1iW4/mabkuqtreiSsXeDQOch5IjUGJA4F/hJINO2NbMtK0e+lBP6xpBxxlBm0i
	gXmlC1wTom1oMjawBQot6cdDugNIr1ai7IFrH1zJXpt+v1T/A+epBY6R2sMzqkn2MYg
	ujCigvlxNuToiHywY0aManZjrFQcHL+Qky03Kso8=
Subject: [PATCH V7 19/19] famfs_fuse: Add documentation
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>, 
	=?UTF-8?Q?Jonathan_Cameron?= <jonathan.cameron@huawei.com>
Date: Sun, 18 Jan 2026 22:34:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
References: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com> 
 <20260118223420.92690-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAuf2A=
Thread-Topic: [PATCH V7 19/19] famfs_fuse: Add documentation
X-Wm-Sent-Timestamp: 1768775668
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33ed831-615df3db-7b06-4137-9877-97c0d0fc0a05-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.8.208

From: John Groves <john@groves.net>=0D=0A=0D=0AAdd Documentation/filesyst=
ems/famfs.rst and update MAINTAINERS=0D=0A=0D=0AReviewed-by: Randy Dunlap=
 <rdunlap@infradead.org>=0D=0ATested-by: Randy Dunlap <rdunlap@infradead.=
org>=0D=0AReviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>=0D=0A=
Signed-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A Documentation=
/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++=0D=0A Documenta=
tion/filesystems/index.rst |   1 +=0D=0A MAINTAINERS                     =
    |   1 +=0D=0A 3 files changed, 144 insertions(+)=0D=0A create mode 10=
0644 Documentation/filesystems/famfs.rst=0D=0A=0D=0Adiff --git a/Document=
ation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst=0D=0Ane=
w file mode 100644=0D=0Aindex 000000000000..bf0c0e6574bb=0D=0A--- /dev/nu=
ll=0D=0A+++ b/Documentation/filesystems/famfs.rst=0D=0A@@ -0,0 +1,142 @@=0D=
=0A+.. SPDX-License-Identifier: GPL-2.0=0D=0A+=0D=0A+.. _famfs_index:=0D=0A=
+=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+famfs: Th=
e fabric-attached memory file system=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D=0A+=0D=0A+- Copyright (C) 2024-2026 Micron Technolo=
gy, Inc.=0D=0A+=0D=0A+Introduction=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D=0A+Compute Express Link (CXL) provides a mechanism for disaggregat=
ed or=0D=0A+fabric-attached memory (FAM). This creates opportunities for =
data sharing;=0D=0A+clustered apps that would otherwise have to shard or =
replicate data can=0D=0A+share one copy in disaggregated memory.=0D=0A+=0D=
=0A+Famfs, which is not CXL-specific in any way, provides a mechanism for=
=0D=0A+multiple hosts to concurrently access data in shared memory, by gi=
ving it=0D=0A+a file system interface. With famfs, any app that understan=
ds files can=0D=0A+access data sets in shared memory. Although famfs supp=
orts read and write,=0D=0A+the real point is to support mmap, which provi=
des direct (dax) access to=0D=0A+the memory - either writable or read-onl=
y.=0D=0A+=0D=0A+Shared memory can pose complex coherency and synchronizat=
ion issues, but=0D=0A+there are also simple cases. Two simple and eminent=
ly useful patterns that=0D=0A+occur frequently in data analytics and AI a=
re:=0D=0A+=0D=0A+* Serial Sharing - Only one host or process at a time ha=
s access to a file=0D=0A+* Read-only Sharing - Multiple hosts or processe=
s share read-only access=0D=0A+  to a file=0D=0A+=0D=0A+The famfs fuse fi=
le system is part of the famfs framework; user space=0D=0A+components [1]=
 handle metadata allocation and distribution, and provide a=0D=0A+low-lev=
el fuse server to expose files that map directly to [presumably=0D=0A+sha=
red] memory.=0D=0A+=0D=0A+The famfs framework manages coherency of its ow=
n metadata and structures,=0D=0A+but does not attempt to manage coherency=
 for applications.=0D=0A+=0D=0A+Famfs also provides data isolation betwee=
n files. That is, even though=0D=0A+the host has access to an entire memo=
ry "device" (as a devdax device), apps=0D=0A+cannot write to memory for w=
hich the file is read-only, and mapping one=0D=0A+file provides isolation=
 from the memory of all other files. This is pretty=0D=0A+basic, but some=
 experimental shared memory usage patterns provide no such=0D=0A+isolatio=
n.=0D=0A+=0D=0A+Principles of Operation=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+=0D=0A+Famfs is a file s=
ystem with one or more devdax devices as a first-class=0D=0A+backing devi=
ce(s). Metadata maintenance and query operations happen=0D=0A+entirely in=
 user space.=0D=0A+=0D=0A+The famfs low-level fuse server daemon provides=
 file maps (fmaps) and=0D=0A+devdax device info to the fuse/famfs kernel =
component so that=0D=0A+read/write/mapping faults can be handled without =
up-calls for all active=0D=0A+files.=0D=0A+=0D=0A+The famfs user space is=
 responsible for maintaining and distributing=0D=0A+consistent metadata. =
This is currently handled via an append-only=0D=0A+metadata log within th=
e memory, but this is orthogonal to the fuse/famfs=0D=0A+kernel code.=0D=0A=
+=0D=0A+Once instantiated, "the same file" on each host points to the sam=
e shared=0D=0A+memory, but in-memory metadata (inodes, etc.) is ephemeral=
 on each host=0D=0A+that has a famfs instance mounted. Use cases are free=
 to allow or not=0D=0A+allow mutations to data on a file-by-file basis.=0D=
=0A+=0D=0A+When an app accesses a data object in a famfs file, there is n=
o page cache=0D=0A+involvement. The CPU cache is loaded directly from the=
 shared memory. In=0D=0A+some use cases, this is an enormous reduction re=
ad amplification compared=0D=0A+to loading an entire page into the page c=
ache.=0D=0A+=0D=0A+=0D=0A+Famfs is Not a Conventional File System=0D=0A+-=
--------------------------------------=0D=0A+=0D=0A+Famfs files can be ac=
cessed by conventional means, but there are=0D=0A+limitations. The kernel=
 component of fuse/famfs is not involved in the=0D=0A+allocation of backi=
ng memory for files at all; the famfs user space=0D=0A+creates files and =
responds as a low-level fuse server with fmaps and=0D=0A+devdax device in=
fo upon request.=0D=0A+=0D=0A+Famfs differs in some important ways from c=
onventional file systems:=0D=0A+=0D=0A+* Files must be pre-allocated by t=
he famfs framework; allocation is never=0D=0A+  performed on (or after) w=
rite.=0D=0A+* Any operation that changes a file's size is considered to p=
ut the file=0D=0A+  in an invalid state, disabling access to the data. It=
 may be possible to=0D=0A+  revisit this in the future. (Typically the fa=
mfs user space can restore=0D=0A+  files to a valid state by replaying th=
e famfs metadata log.)=0D=0A+=0D=0A+Famfs exists to apply the existing fi=
le system abstractions to shared=0D=0A+memory so applications and workflo=
ws can more easily adapt to an=0D=0A+environment with disaggregated share=
d memory.=0D=0A+=0D=0A+Memory Error Handling=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+=0D=0A+Possible memory erro=
rs include timeouts, poison and unexpected=0D=0A+reconfiguration of an un=
derlying dax device. In all of these cases, famfs=0D=0A+receives a call f=
rom the devdax layer via its iomap_ops->notify_failure()=0D=0A+function. =
If any memory errors have been detected, access to the affected=0D=0A+dax=
dev is disabled to avoid further errors or corruption.=0D=0A+=0D=0A+In al=
l known cases, famfs can be unmounted cleanly. In most cases errors=0D=0A=
+can be cleared by re-initializing the memory - at which point a new famf=
s=0D=0A+file system can be created.=0D=0A+=0D=0A+Key Requirements=0D=0A+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+=0D=0A+The primary re=
quirements for famfs are:=0D=0A+=0D=0A+1. Must support a file system abst=
raction backed by sharable devdax memory=0D=0A+2. Files must efficiently =
handle VMA faults=0D=0A+3. Must support metadata distribution in a sharab=
le way=0D=0A+4. Must handle clients with a stale copy of metadata=0D=0A+=0D=
=0A+The famfs kernel component takes care of 1-2 above by caching each fi=
le's=0D=0A+mapping metadata in the kernel.=0D=0A+=0D=0A+Requirements 3 an=
d 4 are handled by the user space components, and are=0D=0A+largely ortho=
gonal to the functionality of the famfs kernel module.=0D=0A+=0D=0A+Requi=
rements 3 and 4 cannot be met by conventional fs-dax file systems=0D=0A+(=
e.g. xfs) because they use write-back metadata; it is not valid to mount=0D=
=0A+such a file system on two hosts from the same in-memory image.=0D=0A+=
=0D=0A+=0D=0A+Famfs Usage=0D=0A+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+=0D=
=0A+Famfs usage is documented at [1].=0D=0A+=0D=0A+=0D=0A+References=0D=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A+=0D=0A+- [1] Famfs user space repos=
itory and documentation=0D=0A+      https://github.com/cxl-micron-reskit/=
famfs=0D=0Adiff --git a/Documentation/filesystems/index.rst b/Documentati=
on/filesystems/index.rst=0D=0Aindex f4873197587d..e6fb467c1680 100644=0D=0A=
--- a/Documentation/filesystems/index.rst=0D=0A+++ b/Documentation/filesy=
stems/index.rst=0D=0A@@ -89,6 +89,7 @@ Documentation for filesystem imple=
mentations.=0D=0A    ext3=0D=0A    ext4/index=0D=0A    f2fs=0D=0A+   famf=
s=0D=0A    gfs2/index=0D=0A    hfs=0D=0A    hfsplus=0D=0Adiff --git a/MAI=
NTAINERS b/MAINTAINERS=0D=0Aindex 6f8a7c813c2f..43141ee4fd4e 100644=0D=0A=
--- a/MAINTAINERS=0D=0A+++ b/MAINTAINERS=0D=0A@@ -10385,6 +10385,7 @@ M:=09=
John Groves <John@Groves.net>=0D=0A L:=09linux-cxl@vger.kernel.org=0D=0A =
L:=09linux-fsdevel@vger.kernel.org=0D=0A S:=09Supported=0D=0A+F:=09Docume=
ntation/filesystems/famfs.rst=0D=0A F:=09fs/fuse/famfs.c=0D=0A F:=09fs/fu=
se/famfs_kfmap.h=0D=0A=20=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

