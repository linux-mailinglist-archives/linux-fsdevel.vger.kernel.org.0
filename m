Return-Path: <linux-fsdevel+bounces-78626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCD+FeygoGlVlAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:37:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 310BB1AE72E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C940F300C31C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C7451061;
	Thu, 26 Feb 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SlM6mN2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD044E05B;
	Thu, 26 Feb 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134614; cv=fail; b=N5i63YjH2f0WdRoY63uy8i3Qe81vHozuj/yIh3XxkLToF3GG/sfo8dFexqv5ob5AKQBUjgThh65T6HlCahbswbIK8KhxJ1UkdbUD9xfxCUmqxmeEhSTuYWz+TTPVLCE0gPwaWLlrKeGtajvT/fVEgOtlM7sgjliWD1JS2aANjA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134614; c=relaxed/simple;
	bh=TqZOgJUo5w0naj9n652qC/qV6uDX2lxzr746Qlg35vM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nqrqqG+YC+7rKtoFBMPtcojwedQhv5IbkFtPDNboQcFWoYZN9ZcUDRZFTTXYyksfkFBeOMlLNmRKZI3/Gr0KrG69TePqGwDAq3BvJCpjpCG3vMF8RdjTw/JaN5h5TdxAaHIW+OzIAdmGqkwWG/GRLSk5WSizEE/Gn43qy4HUMj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SlM6mN2a; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHbMBM2585712;
	Thu, 26 Feb 2026 19:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=TqZOgJUo5w0naj9n652qC/qV6uDX2lxzr746Qlg35vM=; b=SlM6mN2a
	+sr6igf+TYgFKuFUN9zToyzg8PMvmr3qaVbgYGi4Ycr/KDxvZjOZB/tLShw4J/7s
	v3WXPPw7x+l9T+DGPwA31/RiLDh+WvkOWL3RA8V/QM6Qjh7zpJv3CO+3kfAnWSHQ
	Hjdcpv4u/X2z8SVqiCZYcKgYBhsIxNwzQBEncI0B9m+0LZbJL7AmBrxGtIS2fkU9
	kBvCoIvN61Aj+mEFMtl+37IJ2fsvcMi8JY13QNWKGWjk3kUFVDMzPQIqT2jF0kbe
	uOtYIzEvj2gOkCgikpMBUFoNSVi6A/k+kxAeJVEqEHtA26WicfBJgbhijGZd9bJ4
	1BFG7anaE9M9PA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4728rd4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:35:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqrFKSac9+zTKyMMjgIHKWwQmuq+buAGUzfKNMkTYns9BTNak9Eks2+mS7vLO+UM1GxfO+g4jldZVdnFxWRijFe2qEekFziUFU6E57cE2zBYhPUQrmVPtl02h2ylqtx6g9ujJcHJSqujoj0Mm4dqLb7FkJWCWf376UZ/5QG2EPlxNzaeqGMUzS4e07dh/QnEjAwt7hQFG1vG0n7IZeMAyjJ48fPvkBpVqEUPse096XgOVZdTx6elu4TyX0+vo376yjTQt/nbbcjK0/jyEBVk5hqW027vxB+7YaoTPyVa0YOjgREbKKUqbDyg02wpzOiNruK8O/WCs+B9xXbQY8qVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqZOgJUo5w0naj9n652qC/qV6uDX2lxzr746Qlg35vM=;
 b=h2pjN9oqBIBBfQ7B30RP/tHkoEt9J6ib+fVZyHW2KmEBwYkG5CTQ6XbfuwNWIUCn90FpefwRAtvGSkVV3UN0YNKIGX1zXGfvqQ/fuNL1jwLmd8UkoC4/BDH9eK1tRN2fTo2S9HMjT2YkBrCmp2QU3MO4XMzwLrUMW3QoFbx4nGF29v5hQCCCf0NjsHui4gYmw+ykEjXU4gmXryXiXfTh8dUnimpyfqaLq0K2KxMSsZqp1uUBl9aJujuBG5tD3IxgRdkdpJwFovkZ2bsxjAb96vftEX/9ZYFTCR/+9ye0TQhUXSjqbMQh1LFYmclA489uuveKSPV70rK5CrYPFSNYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB5249.namprd15.prod.outlook.com (2603:10b6:303:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 19:35:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:35:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "david@kernel.org" <david@kernel.org>,
        "namhyung@kernel.org"
	<namhyung@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "anna@kernel.org"
	<anna@kernel.org>, "ms@dev.tdt.de" <ms@dev.tdt.de>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "sumit.semwal@linaro.org"
	<sumit.semwal@linaro.org>,
        "john.johansen@canonical.com"
	<john.johansen@canonical.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
        "jth@kernel.org"
	<jth@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "jaharkes@cs.cmu.edu" <jaharkes@cs.cmu.edu>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "ericvh@kernel.org" <ericvh@kernel.org>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "willemb@google.com" <willemb@google.com>,
        "aivazian.tigran@gmail.com"
	<aivazian.tigran@gmail.com>,
        "hubcap@omnibond.com" <hubcap@omnibond.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "sfrench@samba.org"
	<sfrench@samba.org>,
        "neil@brown.name" <neil@brown.name>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "ronniesahlberg@gmail.com"
	<ronniesahlberg@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "raven@themaw.net"
	<raven@themaw.net>,
        Alex Markuze <amarkuze@redhat.com>,
        "mhiramat@kernel.org"
	<mhiramat@kernel.org>,
        "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "tom@talpey.com" <tom@talpey.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "mikulas@artax.karlin.mff.cuni.cz" <mikulas@artax.karlin.mff.cuni.cz>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Olga Kornievskaia <okorniev@redhat.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "osalvador@suse.de"
	<osalvador@suse.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "pc@manguebit.org"
	<pc@manguebit.org>,
        "martin@omnibond.com" <martin@omnibond.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "code@tyhicks.com"
	<code@tyhicks.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "nico@fluxnic.net" <nico@fluxnic.net>, "jack@suse.com" <jack@suse.com>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com"
	<stephen.smalley.work@gmail.com>,
        "salah.triki@gmail.com"
	<salah.triki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "luisbg@kernel.org"
	<luisbg@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "acme@kernel.org" <acme@kernel.org>, "richard@nod.at" <richard@nod.at>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>,
        "al@alarsen.net" <al@alarsen.net>,
        "james.clark@linaro.org" <james.clark@linaro.org>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "sprasad@microsoft.com" <sprasad@microsoft.com>,
        "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>,
        "linux_oss@crudebyte.com" <linux_oss@crudebyte.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "chao@kernel.org"
	<chao@kernel.org>,
        "wufan@kernel.org" <wufan@kernel.org>,
        "coda@cs.cmu.edu"
	<coda@cs.cmu.edu>, Ingo Molnar <mingo@redhat.com>,
        "alex.aring@gmail.com"
	<alex.aring@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "marc.dionne@auristor.com" <marc.dionne@auristor.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "hch@infradead.org" <hch@infradead.org>
CC: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "autofs@vger.kernel.org" <autofs@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-x25@vger.kernel.org"
	<linux-x25@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
        "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>,
        "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>,
        "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>,
        "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-hams@vger.kernel.org"
	<linux-hams@vger.kernel.org>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "codalist@coda.cs.cmu.edu"
	<codalist@coda.cs.cmu.edu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Thread-Topic: [EXTERNAL] [PATCH 34/61] hfsplus: update format strings for u64
 i_ino
Thread-Index: AQHcpz3KaJJHUfFDvEGTnwq9cpElgrWVX5SA
Date: Thu, 26 Feb 2026 19:35:23 +0000
Message-ID: <a7a46e6253a75dd2bed88061caedbe8dc6f6f96c.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
	 <20260226-iino-u64-v1-34-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-34-ccceff366db9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB5249:EE_
x-ms-office365-filtering-correlation-id: 10c0be15-aad3-40ca-ca0a-08de756e2f72
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 IeD8erDnrrOpY4hzImQApc2Gn1xDIQMmQ33hGhpqr/UEjBO7GE3R1/6/Rwuo9ARMHQN6YqthkkL+4K6zbLg1cy5HxnGU4uQGifX9IiXKreqTee4LEElF3zcNkYQFxk259QTZfaC+T3cNa2EEWJJGl6/AS0TCogyTreyHxlabXeUTGKXOxMdY0c/EIaUQjFG9QE3VHu1xXrVdRNzqQ5LeANLqbPMKVEIVMX2xWyzu+wjtmJLNwpOyg/u6VmRIPdm3Mz9vpyVHrcXFOV9olL+AkJy2zwpeZ6KAZb/Q2oHGLr2QM5cPjmZ/PFyibD4bLjB4kiFuLnvFgE/U5xdUb1S1687NRiG+ag1ydxICvE5gGUSBMM787CSWXE3kTCZVMA4hxKpWVY52G1cmpHIPPcU248orOZ8FYT1tQnttralxiV+iR6SPjMS+Xq/K5ikHSZURe02jkDLl/GW70Tje/D4ZiehJgjcJcMk4lEDN7b02erxybU1d4+hN21Lt9eYSMOjMlkwrD6yPKOjYB5RQEwF6ie0PuzF5JWC8x8snUFuZZXLWqIWV6AXTRcO2jA0JhziZceXbPyRBSSzXCKidaWpWOy3wJrg6S31SrfCHDfGnYXID+H6Io/5HqWMqnhI5xNavTjaet+NO2Q8H9yz2YYbBPhgrIvItrUsfqArdZ6M2WZjKp2/bLrc97rzIXS3Njz17/O8+AIGlvH+FnrXBu+9deH5bLtUk3iDtVTw6heIpNIpVhBdiLl3A8m4I+4V1mFHPBHhdWS5zvHB3BRen2ZE7kcGeiC5jwtVttG+PbOZx2b/pGZ7EamFX+dxFFsPeJf3j
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFVUb1lXb0JRVmI0QWVpdUh1UjRZY2dmUnVUVmVtNGRxc3VXd2hjZnVTR3ZG?=
 =?utf-8?B?UnVZKzY0aXpCanBJUnBrTDVZUFRSNXpMdy8zUG8rem93cXNkczMvV1JjTXly?=
 =?utf-8?B?NlJna0FPcEtkL20xSVlrZjZvbENzN25tS1c5SkVYU3dtNnhoNFN0eHJlaklZ?=
 =?utf-8?B?OWNLYnlKM0lrT0hzaWJqcTI3TkllZ3pQeWNKa2s0VHQ0Ry91dnkweWhHL2c0?=
 =?utf-8?B?ODE1M2xQV1Noay9EaEs3Ky8vcXJpMkI4YXVVdmRyZU9CK1hzbm5PVHp4Uno0?=
 =?utf-8?B?LzdHSE1YeCtaM2ovcmdXZkh2L0VtM3J2dko0bFNqeE1jNHNnWmlMYk5CVG9C?=
 =?utf-8?B?dW95d2RjLzh0VG1iSTJTZHgzZzlPejBkYzdYNEJEYzJPd0RTejEvcTd2Q2xr?=
 =?utf-8?B?eG9zMURyUVphTWNTTzQ1WjVOZ2FPdk9qKzFRZUpQSUNFdEc4MUM0alBHd0FK?=
 =?utf-8?B?ZFpDUW04WFd4bDBzaWhuQlRXc0Z3Uzh0ZmtKNDEzS0FUSzJKblE0VlpMU2VO?=
 =?utf-8?B?TlJvUG5PTDJqTjVoOWtSNUExSVo0c3RCYzZnVmp5K1lQL3RUK2VkdFlwZ3ha?=
 =?utf-8?B?KzBjamMrZmFPNE5vTC81anlIdFprMmhydFJ0emFPTldJUUFHemw5UVlWei9N?=
 =?utf-8?B?Y0RZeWU5dmFkcjNPSlRML2phTHBWMGU0M25jMHNteEJ0dXFySzNDTzRtc2Nj?=
 =?utf-8?B?OEt6SWhnUGpTNUNTTDRlVkJqOWhIU1cxMlhJUWViSlFRTmNvZzlYM3k1RU1K?=
 =?utf-8?B?c25GdWZ6dTZFSjFEVzdQdm5WNzdYY0IwNTRrN0Q0K3NBSnZZWEhuQXMrTmdW?=
 =?utf-8?B?UlRBa1lRaHRaZzA3eDM3WXdvOU54R2JTdHFMUzArZ0w1SnhZRmxqMjVlOHJ2?=
 =?utf-8?B?Njk5Z0xGbWFEVUZoTjF0N3VaZFhYZHEvbUxuTC9MNnFjYkZBNFNlQTJvR2Np?=
 =?utf-8?B?Nm82YktBT1JWTG1oTElBL0syWC9OSjJBOTV4UWdCZW5iMEVWSUZtT2RPdWF3?=
 =?utf-8?B?YjRxdFJzMnV4UjhOc09Vd1h0bTNpQVpDN3AyNWFHQXpGOVYrZmlmVFlxTmgx?=
 =?utf-8?B?WkVvTXBlRzNXek5FU1BrNVhtbUIyRlZEejhaRjJvQ1NJckhOa1lHM1ZTTnJO?=
 =?utf-8?B?V3VFTDlXS3pJRC8yRGFmcmcrOGJJZzZaWmJFY09JZzJETUxtTCtYVE9od0Q5?=
 =?utf-8?B?ZTFUYmw1RVVJdGhQcjEzUSsvM1RONGlLaGh1SUtDZWpQN1Q1RytrUUR0Nkpu?=
 =?utf-8?B?NSs0VXppTmd1QWJvL1lYL2RIQ0pxblV6ZGMyZU5SNVZJaDdsUE12UnJYb3FF?=
 =?utf-8?B?WFEzeEZGOEZMbzY2akt4dFN3ZUtZbFY0MFU4Qi9zV0hJUW9nanloY3RnOW9Z?=
 =?utf-8?B?aWVnUHo0M0g0N0ZHTmRCLytDZXlhK1ZvMzZ3cmN3L3B5SDNyelp0SXBHTzRj?=
 =?utf-8?B?VzF5R1BQVDdjSlZQSFdjaWRrYjF1SVJoZEN1K1dtaE1lRSt3OVFQbWMxQjlL?=
 =?utf-8?B?SGUxRU5pRGYxMlBIRG5FU044N1V6dmlJQ1NKRXJWSUhWRzNaUWh1T055MVBi?=
 =?utf-8?B?bGdPK2QraVQ0UmZCdTMxTkJQVG0wVW5KNENRZjExWGZDMzFTQ0dRQ0JUMDZj?=
 =?utf-8?B?cVcyWmJYRWlVQmREMnJQSkVCZmlUMEJpVDg0K2NLUWU4OXhYTXpQOWJ2elIy?=
 =?utf-8?B?UlVrVmpMVlBrOUtLUlRlVDg1UDl2TUh4ZThPbVRzWUlhRU9waXVmWkdJOTFT?=
 =?utf-8?B?ci9tTlhrSU02QXJPeGg5cnREblJBajR3djZtZDNNRkJpNUpRbXE3RE5ic3Mz?=
 =?utf-8?B?RjJlM3VwMTdtRnFCdCt6eXZzZE9HZWdLUWpCYVd0K1V2L3o4NzNJeVVTNDhO?=
 =?utf-8?B?dEFRWnJtRXdkeDFZRWppcjVsTXU2bXBsdUlFMXAxZEUwRGtYejNJLzFzRGZl?=
 =?utf-8?B?UzJyZE9hbEZRVG8zSUhtV1lvbVBBWGZsTnQ4c2VtVGN0T3BhV0htYW5uQm02?=
 =?utf-8?B?U29rbStvNTEyTEpzZ2JrZzEvZ0tQbFRiZFJRdUE0bnVtODNNU0Vla0o2K0t0?=
 =?utf-8?B?RTUwallvSEZjdGU2ZnVoSkFBM0dHeVgyaEJJV3BJRTJsWk5pa2w3ZHNCa05a?=
 =?utf-8?B?ampOeEIrc2R6NkxnNlNmYVdPQXBQYWVOaGJZNWVXdFFWL0hKc1pBWGxQMXBJ?=
 =?utf-8?B?OHIyYUdxcFpuVVYzclRaeU9HeXNURUw5dVc0L3ptWHpYWEJhbXQ4bDIvOWta?=
 =?utf-8?B?N1BPQnpVeGtVRTVqK3JrNjdrWW81UHliZDFDenlQZGxTNTh5WVdzQnBOWmhM?=
 =?utf-8?B?TEJlZWE1eWhjUHhUSWRHSERyYWFTZk5WQW9vMWY0S29WUTl6VUEwOThpTXRs?=
 =?utf-8?Q?lBFMYdCW0Ar6gsuj7oSnRuAqPlEljGrIO0BsO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <788EA72B6A7BC0479F1D2F30F9DB3213@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c0be15-aad3-40ca-ca0a-08de756e2f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:35:23.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjXw+2jm9STzGNY9nMBhYbMJxzAa+xMOmIZmM1q+3yzdkoEghvBGZyg5KRj/sY2u4UolDn1UrTOGjm+gHaYnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5249
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cX87CUbbAEl88Rx6-vKjzh_zTCF4-1-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX8/x0qwufys3v
 gcrR0GnOJKOIHdxlyxryh6w76Vc27Np0IFCzi9S1kzQIjNGxADxCa0was6yvo3vs98sDcufl0fS
 pLpKZ3zrXaZJbDsERFpWMQK3QhDa8SBMxOIFIsXRQt3g3SJ7kCHrAm2Qbwaywqw2Q5UojqyHS+7
 BCAfwOjv1HDd5e6qsuib6TD147wVl6tz2m8a2309OKX8oP8AHGjZP8PJzjOH1l7dyohV89cIcZ6
 em8aMD/aVTEWwGbZZcZ3FXzITha92+1BL7SgRdIRuTnITFVxhmYI1v3M1K71Kct9+5TZ3Dm5LIE
 HsXJWyMhov9WZqViL+59dOjZIGdUCEXHc2farS+u1HY6ZxS/Cm4acl9WBM7NKNhSl1GJ2L6ynen
 P19g6hOaudAixcDk+iwy6PaSjG9tr3rALs3SvWvKvnClHTjwSOfx55MilqImiXEQYsMGK7pNlGK
 Fzm2E6d0/Bjih806S4Q==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a0a08e cx=c_pps
 a=EtrKi/+kAVY73poqiPL3VQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=YkTVa5DhDZSreRIMWfMA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: HyW4t0gQJZzgCHMKKeK7i0-DFkhXhwz3
Subject: Re:  [PATCH 34/61] hfsplus: update format strings for u64 i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78626-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,dev.tdt.de,linux.intel.com,suse.cz,arm.com,schaufler-ca.com,physik.fu-berlin.de,szeredi.hu,linaro.org,canonical.com,gmail.com,dubeyko.com,infradead.org,mit.edu,codewreck.org,hallyn.com,cs.cmu.edu,ffwll.ch,google.com,omnibond.com,linux.dev,samba.org,brown.name,namei.org,evilplan.org,oracle.com,ionkov.net,intel.com,themaw.net,amd.com,efficios.com,talpey.com,fasheh.com,artax.karlin.mff.cuni.cz,microsoft.com,suse.de,manguebit.org,wdc.com,vivo.com,suse.com,linux.ibm.com,tyhicks.com,fluxnic.net,zeniv.linux.org.uk,paul-moore.com,nod.at,goodmis.org,linux.alibaba.com,alarsen.net,huawei.com,crudebyte.com,dilger.ca,auristor.com,paragon-software.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dubeyko.com:email,str.name:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 310BB1AE72E
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDEwOjU1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
VXBkYXRlIGZvcm1hdCBzdHJpbmdzIGFuZCBsb2NhbCB2YXJpYWJsZSB0eXBlcyBpbiBoZnNwbHVz
IGZvciB0aGUNCj4gaV9pbm8gdHlwZSBjaGFuZ2UgZnJvbSB1bnNpZ25lZCBsb25nIHRvIHU2NC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgZnMvaGZzcGx1cy9hdHRyaWJ1dGVzLmMgfCAxMCArKysrKy0tLS0tDQo+ICBmcy9o
ZnNwbHVzL2NhdGFsb2cuYyAgICB8ICAyICstDQo+ICBmcy9oZnNwbHVzL2Rpci5jICAgICAgICB8
ICA2ICsrKy0tLQ0KPiAgZnMvaGZzcGx1cy9leHRlbnRzLmMgICAgfCAgNiArKystLS0NCj4gIGZz
L2hmc3BsdXMvaW5vZGUuYyAgICAgIHwgIDggKysrKy0tLS0NCj4gIGZzL2hmc3BsdXMvc3VwZXIu
YyAgICAgIHwgIDYgKysrLS0tDQo+ICBmcy9oZnNwbHVzL3hhdHRyLmMgICAgICB8IDEwICsrKysr
LS0tLS0NCj4gIDcgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9hdHRyaWJ1dGVzLmMgYi9mcy9oZnNw
bHVzL2F0dHJpYnV0ZXMuYw0KPiBpbmRleCA0Yjc5Y2Q2MDYyNzZlMzFjMjBmYTE4ZWYzYTA5OTU5
NmY1MGU4YTBmLi5lM2Q4ZmUxZTdlNzVkOTg5NWM0YWUzMDgxMGEzMzQ0MTJiNGMxMDVhIDEwMDY0
NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2F0dHJpYnV0ZXMuYw0KPiArKysgYi9mcy9oZnNwbHVzL2F0
dHJpYnV0ZXMuYw0KPiBAQCAtMjAzLDcgKzIwMyw3IEBAIGludCBoZnNwbHVzX2NyZWF0ZV9hdHRy
X25vbG9jayhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPiAgCWludCBl
bnRyeV9zaXplOw0KPiAgCWludCBlcnI7DQo+ICANCj4gLQloZnNfZGJnKCJuYW1lICVzLCBpbm8g
JWxkXG4iLA0KPiArCWhmc19kYmcoIm5hbWUgJXMsIGlubyAlbGxkXG4iLA0KPiAgCQluYW1lID8g
bmFtZSA6IE5VTEwsIGlub2RlLT5pX2lubyk7DQo+ICANCj4gIAlpZiAobmFtZSkgew0KPiBAQCAt
MjU1LDcgKzI1NSw3IEBAIGludCBoZnNwbHVzX2NyZWF0ZV9hdHRyKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsDQo+ICAJaGZzcGx1c19hdHRyX2VudHJ5ICplbnRyeV9wdHI7DQo+ICAJaW50IGVycjsNCj4g
IA0KPiAtCWhmc19kYmcoIm5hbWUgJXMsIGlubyAlbGRcbiIsDQo+ICsJaGZzX2RiZygibmFtZSAl
cywgaW5vICVsbGRcbiIsDQo+ICAJCW5hbWUgPyBuYW1lIDogTlVMTCwgaW5vZGUtPmlfaW5vKTsN
Cj4gIA0KPiAgCWlmICghSEZTUExVU19TQihzYiktPmF0dHJfdHJlZSkgew0KPiBAQCAtMzM3LDcg
KzMzNyw3IEBAIGludCBoZnNwbHVzX2RlbGV0ZV9hdHRyX25vbG9jayhzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPiAgCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9k
ZS0+aV9zYjsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IC0JaGZzX2RiZygibmFtZSAlcywgaW5vICVs
ZFxuIiwNCj4gKwloZnNfZGJnKCJuYW1lICVzLCBpbm8gJWxsZFxuIiwNCj4gIAkJbmFtZSA/IG5h
bWUgOiBOVUxMLCBpbm9kZS0+aV9pbm8pOw0KPiAgDQo+ICAJaWYgKG5hbWUpIHsNCj4gQEAgLTM2
Nyw3ICszNjcsNyBAQCBpbnQgaGZzcGx1c19kZWxldGVfYXR0cihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBjb25zdCBjaGFyICpuYW1lKQ0KPiAgCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+
aV9zYjsNCj4gIAlzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSBmZDsNCj4gIA0KPiAtCWhmc19kYmcoIm5h
bWUgJXMsIGlubyAlbGRcbiIsDQo+ICsJaGZzX2RiZygibmFtZSAlcywgaW5vICVsbGRcbiIsDQo+
ICAJCW5hbWUgPyBuYW1lIDogTlVMTCwgaW5vZGUtPmlfaW5vKTsNCj4gIA0KPiAgCWlmICghSEZT
UExVU19TQihzYiktPmF0dHJfdHJlZSkgew0KPiBAQCAtNDM2LDcgKzQzNiw3IEBAIGludCBoZnNw
bHVzX3JlcGxhY2VfYXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgCWhmc3BsdXNfYXR0cl9l
bnRyeSAqZW50cnlfcHRyOw0KPiAgCWludCBlcnIgPSAwOw0KPiAgDQo+IC0JaGZzX2RiZygibmFt
ZSAlcywgaW5vICVsZFxuIiwNCj4gKwloZnNfZGJnKCJuYW1lICVzLCBpbm8gJWxsZFxuIiwNCj4g
IAkJbmFtZSA/IG5hbWUgOiBOVUxMLCBpbm9kZS0+aV9pbm8pOw0KPiAgDQo+ICAJaWYgKCFIRlNQ
TFVTX1NCKHNiKS0+YXR0cl90cmVlKSB7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2NhdGFs
b2cuYyBiL2ZzL2hmc3BsdXMvY2F0YWxvZy5jDQo+IGluZGV4IDAyYzFlZWU0YTRiODYwNTljZWFh
YjdhN2M2OGFiNjVhZGJhNmZhMjYuLjBlOTYxZTk5Yjk4NTZhYjdkOTVkYTVkMDcwYjRmYmNlMWU2
N2ViZGUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvY2F0YWxvZy5jDQo+ICsrKyBiL2ZzL2hm
c3BsdXMvY2F0YWxvZy5jDQo+IEBAIC00NDEsNyArNDQxLDcgQEAgaW50IGhmc3BsdXNfcmVuYW1l
X2NhdCh1MzIgY25pZCwNCj4gIAlpbnQgZW50cnlfc2l6ZSwgdHlwZTsNCj4gIAlpbnQgZXJyOw0K
PiAgDQo+IC0JaGZzX2RiZygiY25pZCAldSAtIGlubyAlbHUsIG5hbWUgJXMgLSBpbm8gJWx1LCBu
YW1lICVzXG4iLA0KPiArCWhmc19kYmcoImNuaWQgJXUgLSBpbm8gJWxsdSwgbmFtZSAlcyAtIGlu
byAlbGx1LCBuYW1lICVzXG4iLA0KPiAgCQljbmlkLCBzcmNfZGlyLT5pX2lubywgc3JjX25hbWUt
Pm5hbWUsDQo+ICAJCWRzdF9kaXItPmlfaW5vLCBkc3RfbmFtZS0+bmFtZSk7DQo+ICAJZXJyID0g
aGZzX2ZpbmRfaW5pdChIRlNQTFVTX1NCKHNiKS0+Y2F0X3RyZWUsICZzcmNfZmQpOw0KPiBkaWZm
IC0tZ2l0IGEvZnMvaGZzcGx1cy9kaXIuYyBiL2ZzL2hmc3BsdXMvZGlyLmMNCj4gaW5kZXggZDU1
OWJmODYyNWY4NTNkNTBmZDMxNmQxNTdjZjhhZmUyMjA2OTU2NS4uMDU0ZjZkYTQ2MDMzNDA0YmJi
Y2YyOTliZWI1ZDg3NjU0OTVjMGRlMyAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9kaXIuYw0K
PiArKysgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IEBAIC0zMTMsNyArMzEzLDcgQEAgc3RhdGljIGlu
dCBoZnNwbHVzX2xpbmsoc3RydWN0IGRlbnRyeSAqc3JjX2RlbnRyeSwgc3RydWN0IGlub2RlICpk
c3RfZGlyLA0KPiAgCWlmICghU19JU1JFRyhpbm9kZS0+aV9tb2RlKSkNCj4gIAkJcmV0dXJuIC1F
UEVSTTsNCj4gIA0KPiAtCWhmc19kYmcoInNyY19kaXItPmlfaW5vICVsdSwgZHN0X2Rpci0+aV9p
bm8gJWx1LCBpbm9kZS0+aV9pbm8gJWx1XG4iLA0KPiArCWhmc19kYmcoInNyY19kaXItPmlfaW5v
ICVsbHUsIGRzdF9kaXItPmlfaW5vICVsbHUsIGlub2RlLT5pX2lubyAlbGx1XG4iLA0KPiAgCQlz
cmNfZGlyLT5pX2lubywgZHN0X2Rpci0+aV9pbm8sIGlub2RlLT5pX2lubyk7DQo+ICANCj4gIAlt
dXRleF9sb2NrKCZzYmktPnZoX211dGV4KTsNCj4gQEAgLTM4NSw3ICszODUsNyBAQCBzdGF0aWMg
aW50IGhmc3BsdXNfdW5saW5rKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50
cnkpDQo+ICAJaWYgKEhGU1BMVVNfSVNfUlNSQyhpbm9kZSkpDQo+ICAJCXJldHVybiAtRVBFUk07
DQo+ICANCj4gLQloZnNfZGJnKCJkaXItPmlfaW5vICVsdSwgaW5vZGUtPmlfaW5vICVsdVxuIiwN
Cj4gKwloZnNfZGJnKCJkaXItPmlfaW5vICVsbHUsIGlub2RlLT5pX2lubyAlbGx1XG4iLA0KPiAg
CQlkaXItPmlfaW5vLCBpbm9kZS0+aV9pbm8pOw0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmc2JpLT52
aF9tdXRleCk7DQo+IEBAIC0zOTMsNyArMzkzLDcgQEAgc3RhdGljIGludCBoZnNwbHVzX3VubGlu
ayhzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPiAgCWlmIChpbm9k
ZS0+aV9pbm8gPT0gY25pZCAmJg0KPiAgCSAgICBhdG9taWNfcmVhZCgmSEZTUExVU19JKGlub2Rl
KS0+b3BlbmNudCkpIHsNCj4gIAkJc3RyLm5hbWUgPSBuYW1lOw0KPiAtCQlzdHIubGVuID0gc3By
aW50ZihuYW1lLCAidGVtcCVsdSIsIGlub2RlLT5pX2lubyk7DQo+ICsJCXN0ci5sZW4gPSBzcHJp
bnRmKG5hbWUsICJ0ZW1wJWxsdSIsIGlub2RlLT5pX2lubyk7DQo+ICAJCXJlcyA9IGhmc3BsdXNf
cmVuYW1lX2NhdChpbm9kZS0+aV9pbm8sDQo+ICAJCQkJCSBkaXIsICZkZW50cnktPmRfbmFtZSwN
Cj4gIAkJCQkJIHNiaS0+aGlkZGVuX2RpciwgJnN0cik7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNw
bHVzL2V4dGVudHMuYyBiL2ZzL2hmc3BsdXMvZXh0ZW50cy5jDQo+IGluZGV4IDhlODg2NTE0ZDI3
ZjFlNWQ0ZDk0YmU3NTE0MmYxOTc2NjllNjIyMzQuLjQ3NGZkZTFhMTY1M2JlNmNmNzRiMjZlNzU3
YzZkOGE2ZjhkMjkwNmEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvZXh0ZW50cy5jDQo+ICsr
KyBiL2ZzL2hmc3BsdXMvZXh0ZW50cy5jDQo+IEBAIC0yNzUsNyArMjc1LDcgQEAgaW50IGhmc3Bs
dXNfZ2V0X2Jsb2NrKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNlY3Rvcl90IGlibG9jaywNCj4gIAlt
dXRleF91bmxvY2soJmhpcC0+ZXh0ZW50c19sb2NrKTsNCj4gIA0KPiAgZG9uZToNCj4gLQloZnNf
ZGJnKCJpbm8gJWx1LCBpYmxvY2sgJWxsdSAtIGRibG9jayAldVxuIiwNCj4gKwloZnNfZGJnKCJp
bm8gJWxsdSwgaWJsb2NrICVsbHUgLSBkYmxvY2sgJXVcbiIsDQo+ICAJCWlub2RlLT5pX2lubywg
KGxvbmcgbG9uZylpYmxvY2ssIGRibG9jayk7DQo+ICANCj4gIAltYXNrID0gKDEgPDwgc2JpLT5m
c19zaGlmdCkgLSAxOw0KPiBAQCAtNDc2LDcgKzQ3Niw3IEBAIGludCBoZnNwbHVzX2ZpbGVfZXh0
ZW5kKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGJvb2wgemVyb291dCkNCj4gIAkJCWdvdG8gb3V0Ow0K
PiAgCX0NCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHUsIHN0YXJ0ICV1LCBsZW4gJXVcbiIsIGlu
b2RlLT5pX2lubywgc3RhcnQsIGxlbik7DQo+ICsJaGZzX2RiZygiaW5vICVsbHUsIHN0YXJ0ICV1
LCBsZW4gJXVcbiIsIGlub2RlLT5pX2lubywgc3RhcnQsIGxlbik7DQo+ICANCj4gIAlpZiAoaGlw
LT5hbGxvY19ibG9ja3MgPD0gaGlwLT5maXJzdF9ibG9ja3MpIHsNCj4gIAkJaWYgKCFoaXAtPmZp
cnN0X2Jsb2Nrcykgew0KPiBAQCAtNTQ1LDcgKzU0NSw3IEBAIHZvaWQgaGZzcGx1c19maWxlX3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAJdTMyIGFsbG9jX2NudCwgYmxrX2NudCwg
c3RhcnQ7DQo+ICAJaW50IHJlczsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHUsIHBoeXNfc2l6
ZSAlbGx1IC0+IGlfc2l6ZSAlbGx1XG4iLA0KPiArCWhmc19kYmcoImlubyAlbGx1LCBwaHlzX3Np
emUgJWxsdSAtPiBpX3NpemUgJWxsdVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5vLCAobG9uZyBsb25n
KWhpcC0+cGh5c19zaXplLCBpbm9kZS0+aV9zaXplKTsNCj4gIA0KPiAgCWlmIChpbm9kZS0+aV9z
aXplID4gaGlwLT5waHlzX3NpemUpIHsNCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvaW5vZGUu
YyBiL2ZzL2hmc3BsdXMvaW5vZGUuYw0KPiBpbmRleCA5MjJmZjQxZGYwNDJhODNkNDczNjRmMmQ5
NDFjNDVkYWJkYTI5YWZiLi4wMmJlMzJkYzY4MzNkZmRkNzY3YzQwN2VjMDI2MzQ4NWQxYTJjM2M2
IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2lub2RlLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9p
bm9kZS5jDQo+IEBAIC0yMzAsNyArMjMwLDcgQEAgc3RhdGljIGludCBoZnNwbHVzX2dldF9wZXJt
cyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgCQlpbm9kZS0+aV9mbGFncyAmPSB+U19BUFBFTkQ7
DQo+ICAJcmV0dXJuIDA7DQo+ICBiYWRfdHlwZToNCj4gLQlwcl9lcnIoImludmFsaWQgZmlsZSB0
eXBlIDAlMDRvIGZvciBpbm9kZSAlbHVcbiIsIG1vZGUsIGlub2RlLT5pX2lubyk7DQo+ICsJcHJf
ZXJyKCJpbnZhbGlkIGZpbGUgdHlwZSAwJTA0byBmb3IgaW5vZGUgJWxsdVxuIiwgbW9kZSwgaW5v
ZGUtPmlfaW5vKTsNCj4gIAlyZXR1cm4gLUVJTzsNCj4gIH0NCj4gIA0KPiBAQCAtMzI4LDcgKzMy
OCw3IEBAIGludCBoZnNwbHVzX2ZpbGVfZnN5bmMoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBz
dGFydCwgbG9mZl90IGVuZCwNCj4gIAlzdHJ1Y3QgaGZzcGx1c192aCAqdmhkciA9IHNiaS0+c192
aGRyOw0KPiAgCWludCBlcnJvciA9IDAsIGVycm9yMjsNCj4gIA0KPiAtCWhmc19kYmcoImlub2Rl
LT5pX2lubyAlbHUsIHN0YXJ0ICVsbHUsIGVuZCAlbGx1XG4iLA0KPiArCWhmc19kYmcoImlub2Rl
LT5pX2lubyAlbGx1LCBzdGFydCAlbGx1LCBlbmQgJWxsdVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5v
LCBzdGFydCwgZW5kKTsNCj4gIA0KPiAgCWVycm9yID0gZmlsZV93cml0ZV9hbmRfd2FpdF9yYW5n
ZShmaWxlLCBzdGFydCwgZW5kKTsNCj4gQEAgLTYzOSw3ICs2MzksNyBAQCBpbnQgaGZzcGx1c19j
YXRfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gIAloZnNwbHVzX2NhdF9lbnRy
eSBlbnRyeTsNCj4gIAlpbnQgcmVzID0gMDsNCj4gIA0KPiAtCWhmc19kYmcoImlub2RlLT5pX2lu
byAlbHVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vZGUtPmlfaW5vICVsbHVc
biIsIGlub2RlLT5pX2lubyk7DQo+ICANCj4gIAlpZiAoSEZTUExVU19JU19SU1JDKGlub2RlKSkN
Cj4gIAkJbWFpbl9pbm9kZSA9IEhGU1BMVVNfSShpbm9kZSktPnJzcmNfaW5vZGU7DQo+IEBAIC03
MTYsNyArNzE2LDcgQEAgaW50IGhmc3BsdXNfY2F0X3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpDQo+ICAJaWYgKCFyZXMpIHsNCj4gIAkJcmVzID0gaGZzX2J0cmVlX3dyaXRlKHRyZWUp
Ow0KPiAgCQlpZiAocmVzKSB7DQo+IC0JCQlwcl9lcnIoImItdHJlZSB3cml0ZSBlcnI6ICVkLCBp
bm8gJWx1XG4iLA0KPiArCQkJcHJfZXJyKCJiLXRyZWUgd3JpdGUgZXJyOiAlZCwgaW5vICVsbHVc
biIsDQo+ICAJCQkgICAgICAgcmVzLCBpbm9kZS0+aV9pbm8pOw0KPiAgCQl9DQo+ICAJfQ0KPiBk
aWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIvZnMvaGZzcGx1cy9zdXBlci5jDQo+IGlu
ZGV4IDcyMjlhOGFlODlmOTQ2OTEwOWIxYzNhMzE3ZWU5Yjc3MDVhODNmOGIuLmIzOTE3MjQ5YzIw
NmMzYTI1ZmU5OGIzOWE1ZWIyMTY4Yjc0MDRkYzIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMv
c3VwZXIuYw0KPiArKysgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gQEAgLTE1Niw3ICsxNTYsNyBA
QCBzdGF0aWMgaW50IGhmc3BsdXNfc3lzdGVtX3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUpDQo+ICAJCWludCBlcnIgPSBoZnNfYnRyZWVfd3JpdGUodHJlZSk7DQo+ICANCj4gIAkJaWYg
KGVycikgew0KPiAtCQkJcHJfZXJyKCJiLXRyZWUgd3JpdGUgZXJyOiAlZCwgaW5vICVsdVxuIiwN
Cj4gKwkJCXByX2VycigiYi10cmVlIHdyaXRlIGVycjogJWQsIGlubyAlbGx1XG4iLA0KPiAgCQkJ
ICAgICAgIGVyciwgaW5vZGUtPmlfaW5vKTsNCj4gIAkJCXJldHVybiBlcnI7DQo+ICAJCX0NCj4g
QEAgLTE2OSw3ICsxNjksNyBAQCBzdGF0aWMgaW50IGhmc3BsdXNfd3JpdGVfaW5vZGUoc3RydWN0
IGlub2RlICppbm9kZSwNCj4gIHsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IC0JaGZzX2RiZygiaW5v
ICVsdVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gKwloZnNfZGJnKCJpbm8gJWxsdVxuIiwgaW5vZGUt
PmlfaW5vKTsNCj4gIA0KPiAgCWVyciA9IGhmc3BsdXNfZXh0X3dyaXRlX2V4dGVudChpbm9kZSk7
DQo+ICAJaWYgKGVycikNCj4gQEAgLTE4NCw3ICsxODQsNyBAQCBzdGF0aWMgaW50IGhmc3BsdXNf
d3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwNCj4gIA0KPiAgc3RhdGljIHZvaWQgaGZz
cGx1c19ldmljdF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAgew0KPiAtCWhmc19kYmco
ImlubyAlbHVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vICVsbHVcbiIsIGlu
b2RlLT5pX2lubyk7DQo+ICAJdHJ1bmNhdGVfaW5vZGVfcGFnZXNfZmluYWwoJmlub2RlLT5pX2Rh
dGEpOw0KPiAgCWNsZWFyX2lub2RlKGlub2RlKTsNCj4gIAlpZiAoSEZTUExVU19JU19SU1JDKGlu
b2RlKSkgew0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy94YXR0ci5jIGIvZnMvaGZzcGx1cy94
YXR0ci5jDQo+IGluZGV4IDk5MDQ5NDRjYmQ1NGUzZDMyNjU5MWZhNjVhNWVkNjc4ZjM4Y2E1ODMu
LmM3MGJiNmY0OTRiMjJiMWUzZjc0ZTE4YTllZjM3OGUwYzg3ZjgxOTQgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2hmc3BsdXMveGF0dHIuYw0KPiArKysgYi9mcy9oZnNwbHVzL3hhdHRyLmMNCj4gQEAgLTI3
Nyw3ICsyNzcsNyBAQCBpbnQgX19oZnNwbHVzX3NldHhhdHRyKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJdTE2IGZvbGRlcl9maW5kZXJpbmZvX2xlbiA9IHNpemVv
ZihESW5mbykgKyBzaXplb2YoRFhJbmZvKTsNCj4gIAl1MTYgZmlsZV9maW5kZXJpbmZvX2xlbiA9
IHNpemVvZihGSW5mbykgKyBzaXplb2YoRlhJbmZvKTsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAl
bHUsIG5hbWUgJXMsIHZhbHVlICVwLCBzaXplICV6dVxuIiwNCj4gKwloZnNfZGJnKCJpbm8gJWxs
dSwgbmFtZSAlcywgdmFsdWUgJXAsIHNpemUgJXp1XG4iLA0KPiAgCQlpbm9kZS0+aV9pbm8sIG5h
bWUgPyBuYW1lIDogTlVMTCwNCj4gIAkJdmFsdWUsIHNpemUpOw0KPiAgDQo+IEBAIC00NDcsNyAr
NDQ3LDcgQEAgaW50IGhmc3BsdXNfc2V0eGF0dHIoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3Qg
Y2hhciAqbmFtZSwNCj4gIAkJTkxTX01BWF9DSEFSU0VUX1NJWkUgKiBIRlNQTFVTX0FUVFJfTUFY
X1NUUkxFTiArIDE7DQo+ICAJaW50IHJlczsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHUsIG5h
bWUgJXMsIHByZWZpeCAlcywgcHJlZml4bGVuICV6dSwgIg0KPiArCWhmc19kYmcoImlubyAlbGx1
LCBuYW1lICVzLCBwcmVmaXggJXMsIHByZWZpeGxlbiAlenUsICINCj4gIAkJInZhbHVlICVwLCBz
aXplICV6dVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5vLCBuYW1lID8gbmFtZSA6IE5VTEwsDQo+ICAJ
CXByZWZpeCA/IHByZWZpeCA6IE5VTEwsIHByZWZpeGxlbiwNCj4gQEAgLTYwNyw3ICs2MDcsNyBA
QCBzc2l6ZV90IGhmc3BsdXNfZ2V0eGF0dHIoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hh
ciAqbmFtZSwNCj4gIAlpbnQgcmVzOw0KPiAgCWNoYXIgKnhhdHRyX25hbWU7DQo+ICANCj4gLQlo
ZnNfZGJnKCJpbm8gJWx1LCBuYW1lICVzLCBwcmVmaXggJXNcbiIsDQo+ICsJaGZzX2RiZygiaW5v
ICVsbHUsIG5hbWUgJXMsIHByZWZpeCAlc1xuIiwNCj4gIAkJaW5vZGUtPmlfaW5vLCBuYW1lID8g
bmFtZSA6IE5VTEwsDQo+ICAJCXByZWZpeCA/IHByZWZpeCA6IE5VTEwpOw0KPiAgDQo+IEBAIC03
MTcsNyArNzE3LDcgQEAgc3NpemVfdCBoZnNwbHVzX2xpc3R4YXR0cihzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksIGNoYXIgKmJ1ZmZlciwgc2l6ZV90IHNpemUpDQo+ICAJc2l6ZV90IHN0cmJ1Zl9zaXpl
Ow0KPiAgCWludCB4YXR0cl9uYW1lX2xlbjsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHVcbiIs
IGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vICVsbHVcbiIsIGlub2RlLT5pX2lubyk7
DQo+ICANCj4gIAlpZiAoIWlzX3hhdHRyX29wZXJhdGlvbl9zdXBwb3J0ZWQoaW5vZGUpKQ0KPiAg
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+IEBAIC04MTksNyArODE5LDcgQEAgc3RhdGljIGludCBo
ZnNwbHVzX3JlbW92ZXhhdHRyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKm5hbWUp
DQo+ICAJaW50IGlzX3hhdHRyX2FjbF9kZWxldGVkOw0KPiAgCWludCBpc19hbGxfeGF0dHJzX2Rl
bGV0ZWQ7DQo+ICANCj4gLQloZnNfZGJnKCJpbm8gJWx1LCBuYW1lICVzXG4iLA0KPiArCWhmc19k
YmcoImlubyAlbGx1LCBuYW1lICVzXG4iLA0KPiAgCQlpbm9kZS0+aV9pbm8sIG5hbWUgPyBuYW1l
IDogTlVMTCk7DQo+ICANCj4gIAlpZiAoIUhGU1BMVVNfU0IoaW5vZGUtPmlfc2IpLT5hdHRyX3Ry
ZWUpDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNs
YXZhQGR1YmV5a28uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

