Return-Path: <linux-fsdevel+bounces-78632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHR2CcKooGnilQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:10:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B38541AEE61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F9A1300D354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18D23ABB9;
	Thu, 26 Feb 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gW6f2LzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F3368953;
	Thu, 26 Feb 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136638; cv=fail; b=lODmiKa/3NIY+vi+Z7xSLpwq+Cp9K5tyJuE0pt/G4lizb0onFoLIxiF699Ox4uWhMFhvVgMWld0old5Ou+jtHdimUbQiI/j+dhHGxamZ6ioZ0s12PDu4RTvaWwrT6pguXTbsLx0X5YIqRM2Er+ybqHQ1fOBgvAXGXOrh0YxaxOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136638; c=relaxed/simple;
	bh=sbRbkgbamZT1xRBfw3iQ9lifOMz6fP5JgL+HdMWGQak=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BhI4uqpzlhzqQzeWFq6WfuDeAdTQMn2Jmqm1yCageZz49fQSwCP4lD0StDceUSKxHVn/BvfHHdOsdxXniRagI0JD0ErzMdmCTBYOth0s/O0I+OTPMwP3tYarCBcqpsFEgH3fWJZQ4DIuATTXM/1lkOUo055bTx5xyrf/dLX8be0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gW6f2LzW; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QF4PZ92832046;
	Thu, 26 Feb 2026 20:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sbRbkgbamZT1xRBfw3iQ9lifOMz6fP5JgL+HdMWGQak=; b=gW6f2LzW
	SlWMsjlijPpvgNoZGYlm6wUZtpltpuszWKZ1UX15pLoHD+BEsprhuMhul3Oaz4b8
	LYMhWnPbBk/PXETDBE2Wy0kroiInTozsorj58aGdanT12gY5UFiS7g9xOGDZj2ja
	pu1bkLIJHfUGAWIC/jjmv60ado9zVkgpJjl9xIwZSbnJqNolFzkxOor94RMHnysR
	Ff6DZgZul6laKU+oF9GYdIV6vEQNkS6+08dx7MY6Q6KIqlHcC8Qtiotk1GWU16A2
	Bmto33pNoqi/XQwjXblBaOAtbvcnEUjFjh5ChQmWnyqbkTOVdRncM4rqZDhAXowU
	t8zMYjdFzWOVDw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs7w4p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:09:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFUG71e7hSZBMqpKmaa4nqG1aOMn6BhOJCBzYyl7esQxuqoSlkHgtIH/piSdrC/WS6y/AxYpf6ljWHsEZbjKjQ+26RD+pf9rpmJzNhn1U3IzCAJkbGFoL8CPfTVhYYlRLPlneJW2KexEc1ixFWyoOmbzxInFNfnsDl23BAvGdVkXF+YUfvrYtXV6iAG5swk8CW6xOZEPwyj+kzV/FDbnoR7ljx2b6xb4medjm8qyyKGQ32s4E3psfo33I+hWOsBIjh/NMRi9SGlbPdfB1r1JNA6wBd9++y0RdTn300Q7tHgHa8G8jcsdkxM9rpgs1jKI955qqFjogWIm8Sm7gCjixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbRbkgbamZT1xRBfw3iQ9lifOMz6fP5JgL+HdMWGQak=;
 b=jeMjGJr1zb/iahCS5kgFrakPPEuBwjSbxCBsr8oIGEG103OmERt1dpGK0AyRuA7G+cuTwqgtV2AUMRU1kP+JEZD0gSkLI1j/bEMi2r5z6aZE+d5OXfqBRgnbhqd6vU/Jiz27nUPUjbK6EeaYLtftUUFh2i3tUqAeEJMnJcB0/53SFqXj7V8pIsXrcMPhVItuOiwR4XXGvOTDK7pMC9SgIQ961fhDKeFqAFgzsT73ZJK3NEZe4Dn2K1ySDF1M5UslFpW3558NPtn3hHIC4tFDb31TrMYUOZ8mOchgzDexFgc22moSW7kpb0oNkrVtGshHAmXZIhpG782XwySk67RN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5598.namprd15.prod.outlook.com (2603:10b6:8:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 20:09:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 20:09:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "david@kernel.org" <david@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "hch@infradead.org" <hch@infradead.org>,
        Paolo Abeni
	<pabeni@redhat.com>, "anna@kernel.org" <anna@kernel.org>,
        "ms@dev.tdt.de"
	<ms@dev.tdt.de>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>,
        "casey@schaufler-ca.com"
	<casey@schaufler-ca.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>, Ondrej Mosnacek <omosnace@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>, "serge@hallyn.com" <serge@hallyn.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "jaharkes@cs.cmu.edu"
	<jaharkes@cs.cmu.edu>,
        "willemb@google.com" <willemb@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ericvh@kernel.org"
	<ericvh@kernel.org>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "aivazian.tigran@gmail.com"
	<aivazian.tigran@gmail.com>,
        "asmadeus@codewreck.org"
	<asmadeus@codewreck.org>,
        "hubcap@omnibond.com" <hubcap@omnibond.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "neil@brown.name"
	<neil@brown.name>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "lucho@ionkov.net"
	<lucho@ionkov.net>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "raven@themaw.net"
	<raven@themaw.net>,
        Alex Markuze <amarkuze@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "christian.koenig@amd.com"
	<christian.koenig@amd.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>,
        "tom@talpey.com" <tom@talpey.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "mikulas@artax.karlin.mff.cuni.cz"
	<mikulas@artax.karlin.mff.cuni.cz>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        Olga Kornievskaia
	<okorniev@redhat.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "osalvador@suse.de"
	<osalvador@suse.de>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "martin@omnibond.com"
	<martin@omnibond.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "dsterba@suse.com"
	<dsterba@suse.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "dwmw2@infradead.org"
	<dwmw2@infradead.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "nico@fluxnic.net"
	<nico@fluxnic.net>,
        "jack@suse.com" <jack@suse.com>,
        "dlemoal@kernel.org"
	<dlemoal@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "salah.triki@gmail.com" <salah.triki@gmail.com>,
        David Howells
	<dhowells@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "luisbg@kernel.org" <luisbg@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, "richard@nod.at" <richard@nod.at>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "al@alarsen.net"
	<al@alarsen.net>,
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
        "irogers@google.com" <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "namhyung@kernel.org"
	<namhyung@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "marc.dionne@auristor.com" <marc.dionne@auristor.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "coda@cs.cmu.edu"
	<coda@cs.cmu.edu>
CC: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>,
        "autofs@vger.kernel.org" <autofs@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
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
        "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>,
        "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>,
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
Thread-Topic: [EXTERNAL] Re:  [PATCH 17/61] nilfs2: update for u64 i_ino
Thread-Index: AQHcp1tifCxj4OBv6UGtddD/YF69PLWVaOEA
Date: Thu, 26 Feb 2026 20:09:23 +0000
Message-ID: <42116e23351321ff92376fbc3ea8cac91b886dc1.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
			 <20260226-iino-u64-v1-17-ccceff366db9@kernel.org>
		 <34b1d1f43043ca1b71a3ca9ea5ebce597a4c02aa.camel@ibm.com>
	 <d8d47ebf099b21bf20f7284837f8164a19590010.camel@kernel.org>
In-Reply-To: <d8d47ebf099b21bf20f7284837f8164a19590010.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5598:EE_
x-ms-office365-filtering-correlation-id: 02955584-6f1f-405d-042d-08de7572ef28
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 dS5J3+FI3hjDIKtDeDSgxj+OCCZrSWZpBJjhjSoIZxH0BCHct88W5t3r1QWr8YQmmAIo9TuM8K291NRHMLZTSTb9TFqiDKjF+SQumSw2f+hT2v/8BkLHhyQZlUGetxpnaoCvAMCsGyrR6aCx42bG/CcV9J6cBfJEjKjAeb5aWGmI8SGZv0xXUvJZIWdLLlMjh05Zz1uTGcC1Pyh/WKTGjuW1eI8Rm9w8xPSufZKVOvgSFxMvA06psCjZlgmmpL0KoalNYTSTktjA7FQ9msHL7sMymbM+PEwOQjMLnyynyoabjusnbvMxNNkoKv4uTnn4zFKq1zPypLnm6HQPJ67qKKJxeRxt78V3hlDV/1sczyKFEYDm52wAya7scEGc+YsbqOZa88cKTGPTXZ+g1q+ws24e2UaXgBIDRY8kkkQ9q96rHMhmQPcgdAP3oR2EvUSLKmYZHFfTXB67JedtYTIiBuMAmD07WbAnH8j2sdCygjUyNBIxsUziIr5WGkkw6EAmWD6rllmpH6tshjZLjW1RYYLDZDXLbxaEoZg+Tec/RXyTepTEKn5fW1EoNpmWMJGpDv/3p8iQPkRojSGVvRsAC8btfRyJjFH5Iy0Y4RltijV8jV+ekDSLJaWHBjsJLvC07Hkcf9cMzoKUs/iDwl7FfHyBo/uWlrq5QS6umiHbuYZEnvtbTkSBW6cwGrGEaOjFSvFjnf09v9Xvb3szsrg2i/6/kI/CfOgHE9Lv/Pdmx4830+p074tQmRdExAIX5bwkSVcqBTkkxdMplCvlF0lNJv3b/Dsx5XN0powWVPp+3Kg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlEzaWxzZHJXYUlzUVR0c2h1QzZXUUoya0JjUWl0d0x3amQ2Y2ROQkF2OFRo?=
 =?utf-8?B?cTRJL1F3a0xwTGFFSFhGNEZYYWFHK2pXeURNVEFTV1JsdXBEK3dVN2c5MW9B?=
 =?utf-8?B?QkVXUFJJSG8ybGxLK2VTZFV6dEMrUzkrNXgwR3RRTmdJNm55eWZUSUNhdDZs?=
 =?utf-8?B?eHNuRkZrcjRBbS94TmZNMFJiZkl0eGNrUnp5Z0hKWUcwQ245RytmZEVSTUpY?=
 =?utf-8?B?VVZzZEMrVTAvZUVCbGxEd2xtVUIyaEdCTTRwWTVydERPWi9YSWdtaVFTS1px?=
 =?utf-8?B?cUxaVjI5cjdiT0tWby9zUkEvdzZDbDBOMW5DUllPZTBoSjRWaUxLb29WL2tC?=
 =?utf-8?B?ZERURjFabjdFT3ZiczdKMnJuL1hjZDJjVW1HMkovNThHVWNKMFNjbisrdjNC?=
 =?utf-8?B?SnlweERQeVZ3QjAvQmlOZGNYMkY1bjI5UTFRUXdoWDdUWlVFV1BCWjBNWUZ4?=
 =?utf-8?B?Y1RZTGtIK3g5Q0FoMktGeVFQMnczL3diRXVkS1o3S3JzcEw4ejlBaTJiNDJD?=
 =?utf-8?B?cm1rbXF3bnBqZXdIVnE2b1RxUStDMUN3Q3FVODJtYUp3Y25kVHUwQ0syUW00?=
 =?utf-8?B?cExmUG55eFBJOWtSTFdlVC94Mzd2WHZ4MTVoZHhTVGNHSE5ZdXg1WmFKUFNK?=
 =?utf-8?B?TGF1c2pSSEEyUG9PSFNVcWxJOWJZZzJ3T1R2SHVpUmRlSU1DZ0tidGhMd1I4?=
 =?utf-8?B?L2RIOVlNMlVHTHZoZXJqbXljRDAxR0FRdkQydzlBb0xCbHllLzRocTkxdE9w?=
 =?utf-8?B?SU4wTFl3ZXlUZ0wyS3I2SGRiaXA4UVZLTUY1SWRZZnpoKzROK0FBMmlsYXZ3?=
 =?utf-8?B?dTNJbmZKaUxlQk1UR2NFRCtkQ2gvd0hXaVo1aFdWUDdmZW45cDU1R3pENTZ1?=
 =?utf-8?B?b3dsSmluUWNMSjUzeGpLL3hhQ25zWlQxeU52UHgzM3A3YzhQcmxpUnBWNktV?=
 =?utf-8?B?UVdMNFg1ZWc4TUJiYU5MSUhUS1ZXcDJxU2UxRVRKQ3B0WE9pbVgyYmZKRlNn?=
 =?utf-8?B?am1hNXd4dUZvTEc5cUZsNU9Lc212aXNvSm5Ia0ZqR2dCcGVOTHZWcVpQRkla?=
 =?utf-8?B?YzQxWHh0WFIrU0ZsUERoazNKK3pZSzc4RXppUHdjMU1DY3BjRC9oc2wzQ05l?=
 =?utf-8?B?UHdKejIwcldRQkVlVGNCSDR1R3lWQ1NBUWNiaXZHNE9ZeGpuUDBwZGUwejZC?=
 =?utf-8?B?ZGEwM0Y4K1lJOVg1eFJzQmN6L1p4ZCtTV09LekxIVDdmVDlwaXR4TWJCYWxL?=
 =?utf-8?B?b2REUlhtekxGZHgwQnJ1bW9OTnQvUUZVM2xUcjJ0NjBNVXZsZEYyVW9Xb1Nx?=
 =?utf-8?B?NnJiL1NaSTN6QkhSbSs0d05HSTc0N0ZoWmxDVGltYlNZR3NZU1FQTDdsZU5n?=
 =?utf-8?B?UjhLZi9hM01ZMWIybHlYZmZ6NjZzS0xMbGwra0tzdTd5N2JzbmlOdml0bGFP?=
 =?utf-8?B?Q3hHNHI3SE12Z0hRWllNOUpkRFcxT2xPaE5XTGU2NnhMVE8zWis0OVpXdy8x?=
 =?utf-8?B?bldjWWtJcEJia1ZOcWZXZ0dtblpZTDZsakJlODFqNGJiMUtFczFFc2ErV3Z3?=
 =?utf-8?B?WkxZUFRIeEwxOFUwN0xObHFhRU9mOEd6TENhM3UxbVNBV3FyRkRRenZJeEV1?=
 =?utf-8?B?RS9nWDRaek1veGZOVjViTGRNTmg1L20rWDRISXJpMnpHbEhCMXhyVExkN0Vo?=
 =?utf-8?B?NWNFOTNMemtkd0xZUXhiRDh4cjlUMnlHdFpBemtZMkU1VUs0TTkvWVhLZ1M0?=
 =?utf-8?B?UGVsYUx4SlN4eDR6T0YvNlRIbGdod2VUQ1JYSnl5WTNwQmxuRjc3VTlpWHBK?=
 =?utf-8?B?OGVBZFVRR1YzRENJV1BkUFFYY1NHMk96dW9nK1RnRERuUUNydHdmNThCd1Fw?=
 =?utf-8?B?K0h1bE04MkdaYnZWYVBGVlRMZXBRSGs2aHM1c0NrMUVFTzZ0Q05nWmpqS2ZT?=
 =?utf-8?B?ck1NNkFUR2RBRGlhaWRzYmc0ckNzR3Y0V3owdlVsTDBkdEpTZGIzQ2RxMzkz?=
 =?utf-8?B?NnRCRXRiYm1majVhMzNIUzBWNzdHajZWQ3l4Qjdud1FvTmM1RW5xT281a1lQ?=
 =?utf-8?B?OE04ejJEM3hUc1o1VmIxMHJLbTh3OS9UdzQ1VmJVVStpNm80WmFtdkNZSFN3?=
 =?utf-8?B?d0pVcDUxYXRVL0xCaEpEVi9TME1wQ0RTekYvMFFHSEorVzQyRkI3emZ5OTQ4?=
 =?utf-8?B?c09ISGJyTnNjSTJwWFI1a2dtbFVpbjk1dGdLb21KZDlneTE2Nkc4MnBlOTBJ?=
 =?utf-8?B?eEsxdVRYN2ZXdVJhdEVaZWpMQnQySDRQby9oWG1UemExdDR5TkVMWTNkdnNy?=
 =?utf-8?B?UU5iRjMrR1BmTEZqQ0RXWENZR0xmRGZRL2t2bzZOQm1vT2FWOU9lWXYxL3Yy?=
 =?utf-8?Q?oI34N2nWMbInutuymk6HvzdH6VT3GanrLkxwr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4156F00146CDC54DA613BB820FCD501A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02955584-6f1f-405d-042d-08de7572ef28
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:09:23.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QifnMmouOs0w8b3DVcxXNL/qCsHaH7d2bpZEXJ7MYHLnR3q/xHuIzmaMZ4hTkK/Ld9GITyMWsEzGOAe0w3lmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5598
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bJ8moxjzktFB5eQX0v-Gf1txVgzLTS1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfX4JSnMQtLWzjw
 JwMpMP2bv2OE5z5GYvkP4hgtDgR0AFCPaH3DW9u9B/CX9Ikn5rVGuybJ6vzKrWgZlVgLID7+ZaC
 9N8DSyPtza/BmROqqa9/UXNrG2PR3S/y5D1XGm7kog64rNAWlIbHwYCUNryogtZOMufDrhcI0f6
 xICFTJl6DXDE5kWaGaMhgWzqW23Ch63Gwukl1iLumSADJTYFWGaQ06Ajka0pIS2PGyJ7OF7ljml
 Fwtve8d71Mqfxuqvh2GB8dJLdNxZ/oCbFHwi2R2Eobc1JEDo+FiuRLTqg/ez4twel7bTtuYBqnj
 4mBmW/6lPvzTc59sAUMgdFiDryWAUifxxGDj5Sw0/uoC8xtv+JmPvAfakT1u3t8f3TM0eyriSu/
 QG9acVVhGU6TzbMmF8Syfpj+S1QxvUZnJUSLzZB36BdsMYv6aQM+6hQ87ssvAMYwo5B2eMJMBrI
 DJDHSdx2Gbwuch6zxjg==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a0a87b cx=c_pps
 a=uZgmHucj+isDzLb5E5/Wlw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=eAq9-sxpoI3TfA6Y_TAA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: kUxmxzd_sDD93eD4n_Y5tdgLx2owxvkv
Subject: RE:  [PATCH 17/61] nilfs2: update for u64 i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260184
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
	TAGGED_FROM(0.00)[bounces-78632-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,infradead.org,redhat.com,dev.tdt.de,linux.intel.com,schaufler-ca.com,suse.cz,arm.com,physik.fu-berlin.de,szeredi.hu,linaro.org,canonical.com,gmail.com,dubeyko.com,mit.edu,hallyn.com,cs.cmu.edu,google.com,ffwll.ch,codewreck.org,omnibond.com,linux.dev,brown.name,samba.org,namei.org,ionkov.net,evilplan.org,oracle.com,efficios.com,intel.com,themaw.net,amd.com,talpey.com,fasheh.com,artax.karlin.mff.cuni.cz,microsoft.com,suse.de,manguebit.org,wdc.com,vivo.com,suse.com,linux.ibm.com,tyhicks.com,fluxnic.net,zeniv.linux.org.uk,paul-moore.com,nod.at,goodmis.org,linux.alibaba.com,alarsen.net,huawei.com,crudebyte.com,dilger.ca,auristor.com,paragon-software.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dubeyko.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B38541AEE61
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE1OjA2IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE5OjQ2ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+ID4gT24gVGh1LCAyMDI2LTAyLTI2IGF0IDEwOjU1IC0wNTAwLCBKZWZmIExheXRvbiB3
cm90ZToNCj4gPiA+IFVwZGF0ZSBuaWxmczIgdHJhY2UgZXZlbnRzIGFuZCBmaWxlc3lzdGVtIGNv
ZGUgZm9yIHU2NCBpX2lubzoNCj4gPiA+IA0KPiA+ID4gLSBDaGFuZ2UgX19maWVsZChpbm9fdCwg
Li4uKSB0byBfX2ZpZWxkKHU2NCwgLi4uKSBpbiB0cmFjZSBldmVudHMNCj4gPiA+IC0gVXBkYXRl
IGZvcm1hdCBzdHJpbmdzIGZyb20gJWx1IHRvICVsbHUNCj4gPiA+IC0gQ2FzdCB0byAodW5zaWdu
ZWQgbG9uZyBsb25nKSBpbiBUUF9wcmludGsNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
SmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gIGZzL25p
bGZzMi9hbGxvYy5jICAgICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPiA+ID4gIGZzL25pbGZz
Mi9ibWFwLmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiA+ICBmcy9uaWxmczIvYnRub2RlLmMg
ICAgICAgICAgICB8ICAyICstDQo+ID4gPiAgZnMvbmlsZnMyL2J0cmVlLmMgICAgICAgICAgICAg
fCAxMiArKysrKystLS0tLS0NCj4gPiA+ICBmcy9uaWxmczIvZGlyLmMgICAgICAgICAgICAgICB8
IDEyICsrKysrKy0tLS0tLQ0KPiA+ID4gIGZzL25pbGZzMi9kaXJlY3QuYyAgICAgICAgICAgIHwg
IDQgKystLQ0KPiA+ID4gIGZzL25pbGZzMi9nY2lub2RlLmMgICAgICAgICAgIHwgIDIgKy0NCj4g
PiA+ICBmcy9uaWxmczIvaW5vZGUuYyAgICAgICAgICAgICB8ICA4ICsrKystLS0tDQo+ID4gPiAg
ZnMvbmlsZnMyL21kdC5jICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+ID4gIGZzL25pbGZzMi9u
YW1laS5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiA+ICBmcy9uaWxmczIvc2VnbWVudC5jICAg
ICAgICAgICB8ICAyICstDQo+ID4gPiAgaW5jbHVkZS90cmFjZS9ldmVudHMvbmlsZnMyLmggfCAx
MiArKysrKystLS0tLS0NCj4gPiA+ICAxMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCsp
LCAzNSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9h
bGxvYy5jIGIvZnMvbmlsZnMyL2FsbG9jLmMNCj4gPiA+IGluZGV4IGU3ZWViYjA0ZjlhNDA4MGEz
OWYxN2Q0MTIzZTU4ZWQ3ZGY2YjJmNGIuLjdiMWNkMmJhZWZjZjIxZTU0ZjkyNjA4NDViMDJjN2M5
NWMxNDhjNjQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uaWxmczIvYWxsb2MuYw0KPiA+ID4gKysr
IGIvZnMvbmlsZnMyL2FsbG9jLmMNCj4gPiA+IEBAIC03MDcsNyArNzA3LDcgQEAgdm9pZCBuaWxm
c19wYWxsb2NfY29tbWl0X2ZyZWVfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiA+ICAN
Cj4gPiA+ICAJaWYgKCFuaWxmc19jbGVhcl9iaXRfYXRvbWljKGxvY2ssIGdyb3VwX29mZnNldCwg
Yml0bWFwKSkNCj4gPiA+ICAJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJICAg
IiVzIChpbm89JWx1KTogZW50cnkgbnVtYmVyICVsbHUgYWxyZWFkeSBmcmVlZCIsDQo+ID4gPiAr
CQkJICAgIiVzIChpbm89JWxsdSk6IGVudHJ5IG51bWJlciAlbGx1IGFscmVhZHkgZnJlZWQiLA0K
PiA+ID4gIAkJCSAgIF9fZnVuY19fLCBpbm9kZS0+aV9pbm8sDQo+ID4gPiAgCQkJICAgKHVuc2ln
bmVkIGxvbmcgbG9uZylyZXEtPnByX2VudHJ5X25yKTsNCj4gPiA+ICAJZWxzZQ0KPiA+ID4gQEAg
LTc0OCw3ICs3NDgsNyBAQCB2b2lkIG5pbGZzX3BhbGxvY19hYm9ydF9hbGxvY19lbnRyeShzdHJ1
Y3QgaW5vZGUgKmlub2RlLA0KPiA+ID4gIA0KPiA+ID4gIAlpZiAoIW5pbGZzX2NsZWFyX2JpdF9h
dG9taWMobG9jaywgZ3JvdXBfb2Zmc2V0LCBiaXRtYXApKQ0KPiA+ID4gIAkJbmlsZnNfd2Fybihp
bm9kZS0+aV9zYiwNCj4gPiA+IC0JCQkgICAiJXMgKGlubz0lbHUpOiBlbnRyeSBudW1iZXIgJWxs
dSBhbHJlYWR5IGZyZWVkIiwNCj4gPiA+ICsJCQkgICAiJXMgKGlubz0lbGx1KTogZW50cnkgbnVt
YmVyICVsbHUgYWxyZWFkeSBmcmVlZCIsDQo+ID4gPiAgCQkJICAgX19mdW5jX18sIGlub2RlLT5p
X2lubywNCj4gPiA+ICAJCQkgICAodW5zaWduZWQgbG9uZyBsb25nKXJlcS0+cHJfZW50cnlfbnIp
Ow0KPiA+ID4gIAllbHNlDQo+ID4gPiBAQCAtODYxLDcgKzg2MSw3IEBAIGludCBuaWxmc19wYWxs
b2NfZnJlZXYoc3RydWN0IGlub2RlICppbm9kZSwgX191NjQgKmVudHJ5X25ycywgc2l6ZV90IG5p
dGVtcykNCj4gPiA+ICAJCQlpZiAoIW5pbGZzX2NsZWFyX2JpdF9hdG9taWMobG9jaywgZ3JvdXBf
b2Zmc2V0LA0KPiA+ID4gIAkJCQkJCSAgICBiaXRtYXApKSB7DQo+ID4gPiAgCQkJCW5pbGZzX3dh
cm4oaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJCQkgICAiJXMgKGlubz0lbHUpOiBlbnRyeSBudW1i
ZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gPiA+ICsJCQkJCSAgICIlcyAoaW5vPSVsbHUpOiBl
bnRyeSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gPiA+ICAJCQkJCSAgIF9fZnVuY19f
LCBpbm9kZS0+aV9pbm8sDQo+ID4gPiAgCQkJCQkgICAodW5zaWduZWQgbG9uZyBsb25nKWVudHJ5
X25yc1tqXSk7DQo+ID4gPiAgCQkJfSBlbHNlIHsNCj4gPiA+IEBAIC05MDYsNyArOTA2LDcgQEAg
aW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBfX3U2NCAqZW50cnlf
bnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiA+ID4gIAkJCQkJCQkgICAgICBsYXN0X25yc1trXSk7DQo+
ID4gPiAgCQkJaWYgKHJldCAmJiByZXQgIT0gLUVOT0VOVCkNCj4gPiA+ICAJCQkJbmlsZnNfd2Fy
bihpbm9kZS0+aV9zYiwNCj4gPiA+IC0JCQkJCSAgICJlcnJvciAlZCBkZWxldGluZyBibG9jayB0
aGF0IG9iamVjdCAoZW50cnk9JWxsdSwgaW5vPSVsdSkgYmVsb25ncyB0byIsDQo+ID4gPiArCQkJ
CQkgICAiZXJyb3IgJWQgZGVsZXRpbmcgYmxvY2sgdGhhdCBvYmplY3QgKGVudHJ5PSVsbHUsIGlu
bz0lbGx1KSBiZWxvbmdzIHRvIiwNCj4gPiA+ICAJCQkJCSAgIHJldCwgKHVuc2lnbmVkIGxvbmcg
bG9uZylsYXN0X25yc1trXSwNCj4gPiA+ICAJCQkJCSAgIGlub2RlLT5pX2lubyk7DQo+ID4gPiAg
CQl9DQo+ID4gPiBAQCAtOTIzLDcgKzkyMyw3IEBAIGludCBuaWxmc19wYWxsb2NfZnJlZXYoc3Ry
dWN0IGlub2RlICppbm9kZSwgX191NjQgKmVudHJ5X25ycywgc2l6ZV90IG5pdGVtcykNCj4gPiA+
ICAJCQlyZXQgPSBuaWxmc19wYWxsb2NfZGVsZXRlX2JpdG1hcF9ibG9jayhpbm9kZSwgZ3JvdXAp
Ow0KPiA+ID4gIAkJCWlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpDQo+ID4gPiAgCQkJCW5pbGZz
X3dhcm4oaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJCQkgICAiZXJyb3IgJWQgZGVsZXRpbmcgYml0
bWFwIGJsb2NrIG9mIGdyb3VwPSVsdSwgaW5vPSVsdSIsDQo+ID4gPiArCQkJCQkgICAiZXJyb3Ig
JWQgZGVsZXRpbmcgYml0bWFwIGJsb2NrIG9mIGdyb3VwPSVsdSwgaW5vPSVsbHUiLA0KPiA+ID4g
IAkJCQkJICAgcmV0LCBncm91cCwgaW5vZGUtPmlfaW5vKTsNCj4gPiA+ICAJCX0NCj4gPiA+ICAJ
fQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9ibWFwLmMgYi9mcy9uaWxmczIvYm1hcC5j
DQo+ID4gPiBpbmRleCBjY2MxYTdhYTUyZDIwNjRkNTZiODI2MDU4NTU0MjY0YzQ5OGQ1OTJmLi44
MjRmMmJkOTFjMTY3OTY1ZWMzYTY2MDIwMmI2ZTZjNWYxZmUwMDdlIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZnMvbmlsZnMyL2JtYXAuYw0KPiA+ID4gKysrIGIvZnMvbmlsZnMyL2JtYXAuYw0KPiA+ID4g
QEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGludCBuaWxmc19ibWFwX2NvbnZlcnRfZXJyb3Ioc3Ry
dWN0IG5pbGZzX2JtYXAgKmJtYXAsDQo+ID4gPiAgDQo+ID4gPiAgCWlmIChlcnIgPT0gLUVJTlZB
TCkgew0KPiA+ID4gIAkJX19uaWxmc19lcnJvcihpbm9kZS0+aV9zYiwgZm5hbWUsDQo+ID4gPiAt
CQkJICAgICAgImJyb2tlbiBibWFwIChpbm9kZSBudW1iZXI9JWx1KSIsIGlub2RlLT5pX2lubyk7
DQo+ID4gPiArCQkJICAgICAgImJyb2tlbiBibWFwIChpbm9kZSBudW1iZXI9JWxsdSkiLCBpbm9k
ZS0+aV9pbm8pOw0KPiA+ID4gIAkJZXJyID0gLUVJTzsNCj4gPiA+ICAJfQ0KPiA+ID4gIAlyZXR1
cm4gZXJyOw0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9idG5vZGUuYyBiL2ZzL25pbGZz
Mi9idG5vZGUuYw0KPiA+ID4gaW5kZXggNTY4MzY3MTI5MDkyMDE3NzU5MDc0ODM4ODdlOGEwMDIy
ODUxYmJlYy4uMmU1NTNkNjk4ZDBmMzk4MGRlOThmY2VkNDE1ZGZkODE5ZGRiY2EwYSAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2ZzL25pbGZzMi9idG5vZGUuYw0KPiA+ID4gKysrIGIvZnMvbmlsZnMyL2J0
bm9kZS5jDQo+ID4gPiBAQCAtNjQsNyArNjQsNyBAQCBuaWxmc19idG5vZGVfY3JlYXRlX2Jsb2Nr
KHN0cnVjdCBhZGRyZXNzX3NwYWNlICpidG5jLCBfX3U2NCBibG9ja25yKQ0KPiA+ID4gIAkJICog
Y2xlYXJpbmcgb2YgYW4gYWJhbmRvbmVkIGItdHJlZSBub2RlIGlzIG1pc3Npbmcgc29tZXdoZXJl
KS4NCj4gPiA+ICAJCSAqLw0KPiA+ID4gIAkJbmlsZnNfZXJyb3IoaW5vZGUtPmlfc2IsDQo+ID4g
PiAtCQkJICAgICJzdGF0ZSBpbmNvbnNpc3RlbmN5IHByb2JhYmx5IGR1ZSB0byBkdXBsaWNhdGUg
dXNlIG9mIGItdHJlZSBub2RlIGJsb2NrIGFkZHJlc3MgJWxsdSAoaW5vPSVsdSkiLA0KPiA+ID4g
KwkJCSAgICAic3RhdGUgaW5jb25zaXN0ZW5jeSBwcm9iYWJseSBkdWUgdG8gZHVwbGljYXRlIHVz
ZSBvZiBiLXRyZWUgbm9kZSBibG9jayBhZGRyZXNzICVsbHUgKGlubz0lbGx1KSIsDQo+ID4gPiAg
CQkJICAgICh1bnNpZ25lZCBsb25nIGxvbmcpYmxvY2tuciwgaW5vZGUtPmlfaW5vKTsNCj4gPiA+
ICAJCWdvdG8gZmFpbGVkOw0KPiA+ID4gIAl9DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMy
L2J0cmVlLmMgYi9mcy9uaWxmczIvYnRyZWUuYw0KPiA+ID4gaW5kZXggZGQwYzhlNTYwZWY2YTJj
OTY1MTUwMjUzMjE5MTRlMGQ3M2Y0MTE0NC4uM2MwM2Y1YTc0MWQxNDRkMjJkMWZmYjVhY2Y0M2Ew
MzVlODhjMDBkYyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25pbGZzMi9idHJlZS5jDQo+ID4gPiAr
KysgYi9mcy9uaWxmczIvYnRyZWUuYw0KPiA+ID4gQEAgLTM1Myw3ICszNTMsNyBAQCBzdGF0aWMg
aW50IG5pbGZzX2J0cmVlX25vZGVfYnJva2VuKGNvbnN0IHN0cnVjdCBuaWxmc19idHJlZV9ub2Rl
ICpub2RlLA0KPiA+ID4gIAkJICAgICBuY2hpbGRyZW4gPD0gMCB8fA0KPiA+ID4gIAkJICAgICBu
Y2hpbGRyZW4gPiBOSUxGU19CVFJFRV9OT0RFX05DSElMRFJFTl9NQVgoc2l6ZSkpKSB7DQo+ID4g
PiAgCQluaWxmc19jcml0KGlub2RlLT5pX3NiLA0KPiA+ID4gLQkJCSAgICJiYWQgYnRyZWUgbm9k
ZSAoaW5vPSVsdSwgYmxvY2tucj0lbGx1KTogbGV2ZWwgPSAlZCwgZmxhZ3MgPSAweCV4LCBuY2hp
bGRyZW4gPSAlZCIsDQo+ID4gPiArCQkJICAgImJhZCBidHJlZSBub2RlIChpbm89JWxsdSwgYmxv
Y2tucj0lbGx1KTogbGV2ZWwgPSAlZCwgZmxhZ3MgPSAweCV4LCBuY2hpbGRyZW4gPSAlZCIsDQo+
ID4gPiAgCQkJICAgaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9uZyBsb25nKWJsb2NrbnIsIGxl
dmVsLA0KPiA+ID4gIAkJCSAgIGZsYWdzLCBuY2hpbGRyZW4pOw0KPiA+ID4gIAkJcmV0ID0gMTsN
Cj4gPiA+IEBAIC0zODQsNyArMzg0LDcgQEAgc3RhdGljIGludCBuaWxmc19idHJlZV9yb290X2Jy
b2tlbihjb25zdCBzdHJ1Y3QgbmlsZnNfYnRyZWVfbm9kZSAqbm9kZSwNCj4gPiA+ICAJCSAgICAg
bmNoaWxkcmVuID4gTklMRlNfQlRSRUVfUk9PVF9OQ0hJTERSRU5fTUFYIHx8DQo+ID4gPiAgCQkg
ICAgIChuY2hpbGRyZW4gPT0gMCAmJiBsZXZlbCA+IE5JTEZTX0JUUkVFX0xFVkVMX05PREVfTUlO
KSkpIHsNCj4gPiA+ICAJCW5pbGZzX2NyaXQoaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJICAgImJh
ZCBidHJlZSByb290IChpbm89JWx1KTogbGV2ZWwgPSAlZCwgZmxhZ3MgPSAweCV4LCBuY2hpbGRy
ZW4gPSAlZCIsDQo+ID4gPiArCQkJICAgImJhZCBidHJlZSByb290IChpbm89JWxsdSk6IGxldmVs
ID0gJWQsIGZsYWdzID0gMHgleCwgbmNoaWxkcmVuID0gJWQiLA0KPiA+ID4gIAkJCSAgIGlub2Rl
LT5pX2lubywgbGV2ZWwsIGZsYWdzLCBuY2hpbGRyZW4pOw0KPiA+ID4gIAkJcmV0ID0gMTsNCj4g
PiA+ICAJfQ0KPiA+ID4gQEAgLTQ1Myw3ICs0NTMsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2J0cmVl
X2JhZF9ub2RlKGNvbnN0IHN0cnVjdCBuaWxmc19ibWFwICpidHJlZSwNCj4gPiA+ICAJaWYgKHVu
bGlrZWx5KG5pbGZzX2J0cmVlX25vZGVfZ2V0X2xldmVsKG5vZGUpICE9IGxldmVsKSkgew0KPiA+
ID4gIAkJZHVtcF9zdGFjaygpOw0KPiA+ID4gIAkJbmlsZnNfY3JpdChidHJlZS0+Yl9pbm9kZS0+
aV9zYiwNCj4gPiA+IC0JCQkgICAiYnRyZWUgbGV2ZWwgbWlzbWF0Y2ggKGlubz0lbHUpOiAlZCAh
PSAlZCIsDQo+ID4gPiArCQkJICAgImJ0cmVlIGxldmVsIG1pc21hdGNoIChpbm89JWxsdSk6ICVk
ICE9ICVkIiwNCj4gPiA+ICAJCQkgICBidHJlZS0+Yl9pbm9kZS0+aV9pbm8sDQo+ID4gPiAgCQkJ
ICAgbmlsZnNfYnRyZWVfbm9kZV9nZXRfbGV2ZWwobm9kZSksIGxldmVsKTsNCj4gPiA+ICAJCXJl
dHVybiAxOw0KPiA+ID4gQEAgLTUyMSw3ICs1MjEsNyBAQCBzdGF0aWMgaW50IF9fbmlsZnNfYnRy
ZWVfZ2V0X2Jsb2NrKGNvbnN0IHN0cnVjdCBuaWxmc19ibWFwICpidHJlZSwgX191NjQgcHRyLA0K
PiA+ID4gICBvdXRfbm9fd2FpdDoNCj4gPiA+ICAJaWYgKCFidWZmZXJfdXB0b2RhdGUoYmgpKSB7
DQo+ID4gPiAgCQluaWxmc19lcnIoYnRyZWUtPmJfaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJICAi
SS9PIGVycm9yIHJlYWRpbmcgYi10cmVlIG5vZGUgYmxvY2sgKGlubz0lbHUsIGJsb2NrbnI9JWxs
dSkiLA0KPiA+ID4gKwkJCSAgIkkvTyBlcnJvciByZWFkaW5nIGItdHJlZSBub2RlIGJsb2NrIChp
bm89JWxsdSwgYmxvY2tucj0lbGx1KSIsDQo+ID4gPiAgCQkJICBidHJlZS0+Yl9pbm9kZS0+aV9p
bm8sICh1bnNpZ25lZCBsb25nIGxvbmcpcHRyKTsNCj4gPiA+ICAJCWJyZWxzZShiaCk7DQo+ID4g
PiAgCQlyZXR1cm4gLUVJTzsNCj4gPiA+IEBAIC0yMTA0LDcgKzIxMDQsNyBAQCBzdGF0aWMgaW50
IG5pbGZzX2J0cmVlX3Byb3BhZ2F0ZShzdHJ1Y3QgbmlsZnNfYm1hcCAqYnRyZWUsDQo+ID4gPiAg
CWlmIChyZXQgPCAwKSB7DQo+ID4gPiAgCQlpZiAodW5saWtlbHkocmV0ID09IC1FTk9FTlQpKSB7
DQo+ID4gPiAgCQkJbmlsZnNfY3JpdChidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gPiA+IC0JCQkJ
ICAgIndyaXRpbmcgbm9kZS9sZWFmIGJsb2NrIGRvZXMgbm90IGFwcGVhciBpbiBiLXRyZWUgKGlu
bz0lbHUpIGF0IGtleT0lbGx1LCBsZXZlbD0lZCIsDQo+ID4gPiArCQkJCSAgICJ3cml0aW5nIG5v
ZGUvbGVhZiBibG9jayBkb2VzIG5vdCBhcHBlYXIgaW4gYi10cmVlIChpbm89JWxsdSkgYXQga2V5
PSVsbHUsIGxldmVsPSVkIiwNCj4gPiA+ICAJCQkJICAgYnRyZWUtPmJfaW5vZGUtPmlfaW5vLA0K
PiA+ID4gIAkJCQkgICAodW5zaWduZWQgbG9uZyBsb25nKWtleSwgbGV2ZWwpOw0KPiA+ID4gIAkJ
CXJldCA9IC1FSU5WQUw7DQo+ID4gPiBAQCAtMjE0Niw3ICsyMTQ2LDcgQEAgc3RhdGljIHZvaWQg
bmlsZnNfYnRyZWVfYWRkX2RpcnR5X2J1ZmZlcihzdHJ1Y3QgbmlsZnNfYm1hcCAqYnRyZWUsDQo+
ID4gPiAgCSAgICBsZXZlbCA+PSBOSUxGU19CVFJFRV9MRVZFTF9NQVgpIHsNCj4gPiA+ICAJCWR1
bXBfc3RhY2soKTsNCj4gPiA+ICAJCW5pbGZzX3dhcm4oYnRyZWUtPmJfaW5vZGUtPmlfc2IsDQo+
ID4gPiAtCQkJICAgImludmFsaWQgYnRyZWUgbGV2ZWw6ICVkIChrZXk9JWxsdSwgaW5vPSVsdSwg
YmxvY2tucj0lbGx1KSIsDQo+ID4gPiArCQkJICAgImludmFsaWQgYnRyZWUgbGV2ZWw6ICVkIChr
ZXk9JWxsdSwgaW5vPSVsbHUsIGJsb2NrbnI9JWxsdSkiLA0KPiA+ID4gIAkJCSAgIGxldmVsLCAo
dW5zaWduZWQgbG9uZyBsb25nKWtleSwNCj4gPiA+ICAJCQkgICBidHJlZS0+Yl9pbm9kZS0+aV9p
bm8sDQo+ID4gPiAgCQkJICAgKHVuc2lnbmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yKTsNCj4g
PiA+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvZGlyLmMgYi9mcy9uaWxmczIvZGlyLmMNCj4gPiA+
IGluZGV4IGIyNDMxOTkwMzZkZmExYWIyMjk5ZWZhYWE1YmRmNWRhMmQxNTlmZjIuLjM2NTNkYjVj
ZGI2NTEzN2QxZTY2MGJiNTA5YzE0ZWM0Y2JjODg0MGIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9u
aWxmczIvZGlyLmMNCj4gPiA+ICsrKyBiL2ZzL25pbGZzMi9kaXIuYw0KPiA+ID4gQEAgLTE1MCw3
ICsxNTAsNyBAQCBzdGF0aWMgYm9vbCBuaWxmc19jaGVja19mb2xpbyhzdHJ1Y3QgZm9saW8gKmZv
bGlvLCBjaGFyICprYWRkcikNCj4gPiA+ICANCj4gPiA+ICBFYmFkc2l6ZToNCj4gPiA+ICAJbmls
ZnNfZXJyb3Ioc2IsDQo+ID4gPiAtCQkgICAgInNpemUgb2YgZGlyZWN0b3J5ICMlbHUgaXMgbm90
IGEgbXVsdGlwbGUgb2YgY2h1bmsgc2l6ZSIsDQo+ID4gPiArCQkgICAgInNpemUgb2YgZGlyZWN0
b3J5ICMlbGx1IGlzIG5vdCBhIG11bHRpcGxlIG9mIGNodW5rIHNpemUiLA0KPiA+ID4gIAkJICAg
IGRpci0+aV9pbm8pOw0KPiA+ID4gIAlnb3RvIGZhaWw7DQo+ID4gPiAgRXNob3J0Og0KPiA+ID4g
QEAgLTE2OSw3ICsxNjksNyBAQCBzdGF0aWMgYm9vbCBuaWxmc19jaGVja19mb2xpbyhzdHJ1Y3Qg
Zm9saW8gKmZvbGlvLCBjaGFyICprYWRkcikNCj4gPiA+ICAJZXJyb3IgPSAiZGlzYWxsb3dlZCBp
bm9kZSBudW1iZXIiOw0KPiA+ID4gIGJhZF9lbnRyeToNCj4gPiA+ICAJbmlsZnNfZXJyb3Ioc2Is
DQo+ID4gPiAtCQkgICAgImJhZCBlbnRyeSBpbiBkaXJlY3RvcnkgIyVsdTogJXMgLSBvZmZzZXQ9
JWx1LCBpbm9kZT0lbHUsIHJlY19sZW49JXpkLCBuYW1lX2xlbj0lZCIsDQo+ID4gPiArCQkgICAg
ImJhZCBlbnRyeSBpbiBkaXJlY3RvcnkgIyVsbHU6ICVzIC0gb2Zmc2V0PSVsdSwgaW5vZGU9JWx1
LCByZWNfbGVuPSV6ZCwgbmFtZV9sZW49JWQiLA0KPiA+IA0KPiA+IEkgdGhpbmsgeW91IG1pc3Nl
ZCAnaW5vZGU9JWx1JyBoZXJlLiANCj4gDQo+IFRoYXQgaXMgYWN0dWFsbHkgdGhlIHBsYWNlaG9s
ZGVyIGZvciB0aGlzOg0KPiANCj4gICAgICh1bnNpZ25lZCBsb25nKWxlNjRfdG9fY3B1KHAtPmlu
b2RlKQ0KPiANCj4gLi4ud2hpY2ggaXMgbm90IGlub2RlLT5pX2luby4gSSBkbyBhZ3JlZSB0aGF0
IHRoZSBjYXN0IHByb2JhYmx5IG5vDQo+IGxvbmdlciBtYWtlcyBzZW5zZSB3aXRoIHRoaXMgY2hh
bmdlLCBidXQgSSdkIHByb2JhYmx5IGxlYXZlIHRoYXQgdG8gYQ0KPiBsYXRlciBjbGVhbnVwIHNv
IHdlIGNhbiBrZWVwIHRoaXMgc2V0IGZvY3VzZWQgb24gdGhlIGlfaW5vIGNoYW5nZS4NCg0KSSBz
ZWUgeW91ciBwb2ludC4gTWFrZXMgc2Vuc2UuIFRoZSByZXN0IGxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KDQpUaGFua3Ms
DQpTbGF2YS4NCg0KPiANCj4gDQo+ID4gPiAgCQkgICAgZGlyLT5pX2lubywgZXJyb3IsIChmb2xp
by0+aW5kZXggPDwgUEFHRV9TSElGVCkgKyBvZmZzLA0KPiA+ID4gIAkJICAgICh1bnNpZ25lZCBs
b25nKWxlNjRfdG9fY3B1KHAtPmlub2RlKSwNCj4gPiA+ICAJCSAgICByZWNfbGVuLCBwLT5uYW1l
X2xlbik7DQo+ID4gPiBAQCAtMTc3LDcgKzE3Nyw3IEBAIHN0YXRpYyBib29sIG5pbGZzX2NoZWNr
X2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8sIGNoYXIgKmthZGRyKQ0KPiA+ID4gIEVlbmQ6DQo+
ID4gPiAgCXAgPSAoc3RydWN0IG5pbGZzX2Rpcl9lbnRyeSAqKShrYWRkciArIG9mZnMpOw0KPiA+
ID4gIAluaWxmc19lcnJvcihzYiwNCj4gPiA+IC0JCSAgICAiZW50cnkgaW4gZGlyZWN0b3J5ICMl
bHUgc3BhbnMgdGhlIHBhZ2UgYm91bmRhcnkgb2Zmc2V0PSVsdSwgaW5vZGU9JWx1IiwNCj4gPiA+
ICsJCSAgICAiZW50cnkgaW4gZGlyZWN0b3J5ICMlbGx1IHNwYW5zIHRoZSBwYWdlIGJvdW5kYXJ5
IG9mZnNldD0lbHUsIGlub2RlPSVsdSIsDQo+ID4gDQo+ID4gRGl0dG8uIFlvdSBtaXNzZWQgJ2lu
b2RlPSVsdScgaGVyZS4NCj4gPiANCj4gPiANCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+ID4gPiAg
CQkgICAgZGlyLT5pX2lubywgKGZvbGlvLT5pbmRleCA8PCBQQUdFX1NISUZUKSArIG9mZnMsDQo+
ID4gPiAgCQkgICAgKHVuc2lnbmVkIGxvbmcpbGU2NF90b19jcHUocC0+aW5vZGUpKTsNCj4gPiA+
ICBmYWlsOg0KPiA+ID4gQEAgLTI1MSw3ICsyNTEsNyBAQCBzdGF0aWMgaW50IG5pbGZzX3JlYWRk
aXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPiA+ID4gIA0K
PiA+ID4gIAkJa2FkZHIgPSBuaWxmc19nZXRfZm9saW8oaW5vZGUsIG4sICZmb2xpbyk7DQo+ID4g
PiAgCQlpZiAoSVNfRVJSKGthZGRyKSkgew0KPiA+ID4gLQkJCW5pbGZzX2Vycm9yKHNiLCAiYmFk
IHBhZ2UgaW4gIyVsdSIsIGlub2RlLT5pX2lubyk7DQo+ID4gPiArCQkJbmlsZnNfZXJyb3Ioc2Is
ICJiYWQgcGFnZSBpbiAjJWxsdSIsIGlub2RlLT5pX2lubyk7DQo+ID4gPiAgCQkJY3R4LT5wb3Mg
Kz0gUEFHRV9TSVpFIC0gb2Zmc2V0Ow0KPiA+ID4gIAkJCXJldHVybiAtRUlPOw0KPiA+ID4gIAkJ
fQ0KPiA+ID4gQEAgLTMzNiw3ICszMzYsNyBAQCBzdHJ1Y3QgbmlsZnNfZGlyX2VudHJ5ICpuaWxm
c19maW5kX2VudHJ5KHN0cnVjdCBpbm9kZSAqZGlyLA0KPiA+ID4gIAkJLyogbmV4dCBmb2xpbyBp
cyBwYXN0IHRoZSBibG9ja3Mgd2UndmUgZ290ICovDQo+ID4gPiAgCQlpZiAodW5saWtlbHkobiA+
IChkaXItPmlfYmxvY2tzID4+IChQQUdFX1NISUZUIC0gOSkpKSkgew0KPiA+ID4gIAkJCW5pbGZz
X2Vycm9yKGRpci0+aV9zYiwNCj4gPiA+IC0JCQkgICAgICAgImRpciAlbHUgc2l6ZSAlbGxkIGV4
Y2VlZHMgYmxvY2sgY291bnQgJWxsdSIsDQo+ID4gPiArCQkJICAgICAgICJkaXIgJWxsdSBzaXpl
ICVsbGQgZXhjZWVkcyBibG9jayBjb3VudCAlbGx1IiwNCj4gPiA+ICAJCQkgICAgICAgZGlyLT5p
X2lubywgZGlyLT5pX3NpemUsDQo+ID4gPiAgCQkJICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcp
ZGlyLT5pX2Jsb2Nrcyk7DQo+ID4gPiAgCQkJZ290byBvdXQ7DQo+ID4gPiBAQCAtMzgyLDcgKzM4
Miw3IEBAIHN0cnVjdCBuaWxmc19kaXJfZW50cnkgKm5pbGZzX2RvdGRvdChzdHJ1Y3QgaW5vZGUg
KmRpciwgc3RydWN0IGZvbGlvICoqZm9saW9wKQ0KPiA+ID4gIAlyZXR1cm4gbmV4dF9kZTsNCj4g
PiA+ICANCj4gPiA+ICBmYWlsOg0KPiA+ID4gLQluaWxmc19lcnJvcihkaXItPmlfc2IsICJkaXJl
Y3RvcnkgIyVsdSAlcyIsIGRpci0+aV9pbm8sIG1zZyk7DQo+ID4gPiArCW5pbGZzX2Vycm9yKGRp
ci0+aV9zYiwgImRpcmVjdG9yeSAjJWxsdSAlcyIsIGRpci0+aV9pbm8sIG1zZyk7DQo+ID4gPiAg
CWZvbGlvX3JlbGVhc2Vfa21hcChmb2xpbywgZGUpOw0KPiA+ID4gIAlyZXR1cm4gTlVMTDsNCj4g
PiA+ICB9DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2RpcmVjdC5jIGIvZnMvbmlsZnMy
L2RpcmVjdC5jDQo+ID4gPiBpbmRleCAyZDhkYzZiMzViNTQ3Nzk0N2NhMTJhNzAyODhkM2EzY2Nl
ODU4YWFiLi44YmQwYjEzNzRlMjVmOGZmNTEwZjNiMzZkYmRlMmFjYzAxYWFmYzFlIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZnMvbmlsZnMyL2RpcmVjdC5jDQo+ID4gPiArKysgYi9mcy9uaWxmczIvZGly
ZWN0LmMNCj4gPiA+IEBAIC0zMzgsNyArMzM4LDcgQEAgc3RhdGljIGludCBuaWxmc19kaXJlY3Rf
YXNzaWduKHN0cnVjdCBuaWxmc19ibWFwICpibWFwLA0KPiA+ID4gIAlrZXkgPSBuaWxmc19ibWFw
X2RhdGFfZ2V0X2tleShibWFwLCAqYmgpOw0KPiA+ID4gIAlpZiAodW5saWtlbHkoa2V5ID4gTklM
RlNfRElSRUNUX0tFWV9NQVgpKSB7DQo+ID4gPiAgCQluaWxmc19jcml0KGJtYXAtPmJfaW5vZGUt
Pmlfc2IsDQo+ID4gPiAtCQkJICAgIiVzIChpbm89JWx1KTogaW52YWxpZCBrZXk6ICVsbHUiLA0K
PiA+ID4gKwkJCSAgICIlcyAoaW5vPSVsbHUpOiBpbnZhbGlkIGtleTogJWxsdSIsDQo+ID4gPiAg
CQkJICAgX19mdW5jX18sDQo+ID4gPiAgCQkJICAgYm1hcC0+Yl9pbm9kZS0+aV9pbm8sICh1bnNp
Z25lZCBsb25nIGxvbmcpa2V5KTsNCj4gPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gQEAg
LTM0Niw3ICszNDYsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2RpcmVjdF9hc3NpZ24oc3RydWN0IG5p
bGZzX2JtYXAgKmJtYXAsDQo+ID4gPiAgCXB0ciA9IG5pbGZzX2RpcmVjdF9nZXRfcHRyKGJtYXAs
IGtleSk7DQo+ID4gPiAgCWlmICh1bmxpa2VseShwdHIgPT0gTklMRlNfQk1BUF9JTlZBTElEX1BU
UikpIHsNCj4gPiA+ICAJCW5pbGZzX2NyaXQoYm1hcC0+Yl9pbm9kZS0+aV9zYiwNCj4gPiA+IC0J
CQkgICAiJXMgKGlubz0lbHUpOiBpbnZhbGlkIHBvaW50ZXI6ICVsbHUiLA0KPiA+ID4gKwkJCSAg
ICIlcyAoaW5vPSVsbHUpOiBpbnZhbGlkIHBvaW50ZXI6ICVsbHUiLA0KPiA+ID4gIAkJCSAgIF9f
ZnVuY19fLA0KPiA+ID4gIAkJCSAgIGJtYXAtPmJfaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9u
ZyBsb25nKXB0cik7DQo+ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+IGRpZmYgLS1naXQg
YS9mcy9uaWxmczIvZ2Npbm9kZS5jIGIvZnMvbmlsZnMyL2djaW5vZGUuYw0KPiA+ID4gaW5kZXgg
NTYxYzIyMDc5OWM3YWVlODc5YWQ4NjY4NjVlMzc3Nzk5YzhlZTZiYi4uNjJkNGMxYjc4N2U5NWM5
NjFhMzYwYTQyMTRkNjIxZDU2NGFkOGI0YyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25pbGZzMi9n
Y2lub2RlLmMNCj4gPiA+ICsrKyBiL2ZzL25pbGZzMi9nY2lub2RlLmMNCj4gPiA+IEBAIC0xMzcs
NyArMTM3LDcgQEAgaW50IG5pbGZzX2djY2FjaGVfd2FpdF9hbmRfbWFya19kaXJ0eShzdHJ1Y3Qg
YnVmZmVyX2hlYWQgKmJoKQ0KPiA+ID4gIAkJc3RydWN0IGlub2RlICppbm9kZSA9IGJoLT5iX2Zv
bGlvLT5tYXBwaW5nLT5ob3N0Ow0KPiA+ID4gIA0KPiA+ID4gIAkJbmlsZnNfZXJyKGlub2RlLT5p
X3NiLA0KPiA+ID4gLQkJCSAgIkkvTyBlcnJvciByZWFkaW5nICVzIGJsb2NrIGZvciBHQyAoaW5v
PSVsdSwgdmJsb2NrbnI9JWxsdSkiLA0KPiA+ID4gKwkJCSAgIkkvTyBlcnJvciByZWFkaW5nICVz
IGJsb2NrIGZvciBHQyAoaW5vPSVsbHUsIHZibG9ja25yPSVsbHUpIiwNCj4gPiA+ICAJCQkgIGJ1
ZmZlcl9uaWxmc19ub2RlKGJoKSA/ICJub2RlIiA6ICJkYXRhIiwNCj4gPiA+ICAJCQkgIGlub2Rl
LT5pX2lubywgKHVuc2lnbmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yKTsNCj4gPiA+ICAJCXJl
dHVybiAtRUlPOw0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9pbm9kZS5jIGIvZnMvbmls
ZnMyL2lub2RlLmMNCj4gPiA+IGluZGV4IDUxYmRlNDVkNTg2NTA5ZGRhM2VmMGNiN2M0NmZhY2I3
ZmIyYzYxZGQuLjUxZjdlMTI1YTMxMWI4Njg4NjBlM2UxMTE3MDBkNDlkNGNiOThmYTYgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9mcy9uaWxmczIvaW5vZGUuYw0KPiA+ID4gKysrIGIvZnMvbmlsZnMyL2lu
b2RlLmMNCj4gPiA+IEBAIC0xMDgsNyArMTA4LDcgQEAgaW50IG5pbGZzX2dldF9ibG9jayhzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzZWN0b3JfdCBibGtvZmYsDQo+ID4gPiAgCQkJCSAqIGJlIGxvY2tl
ZCBpbiB0aGlzIGNhc2UuDQo+ID4gPiAgCQkJCSAqLw0KPiA+ID4gIAkJCQluaWxmc193YXJuKGlu
b2RlLT5pX3NiLA0KPiA+ID4gLQkJCQkJICAgIiVzIChpbm89JWx1KTogYSByYWNlIGNvbmRpdGlv
biB3aGlsZSBpbnNlcnRpbmcgYSBkYXRhIGJsb2NrIGF0IG9mZnNldD0lbGx1IiwNCj4gPiA+ICsJ
CQkJCSAgICIlcyAoaW5vPSVsbHUpOiBhIHJhY2UgY29uZGl0aW9uIHdoaWxlIGluc2VydGluZyBh
IGRhdGEgYmxvY2sgYXQgb2Zmc2V0PSVsbHUiLA0KPiA+ID4gIAkJCQkJICAgX19mdW5jX18sIGlu
b2RlLT5pX2lubywNCj4gPiA+ICAJCQkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpYmxrb2ZmKTsN
Cj4gPiA+ICAJCQkJZXJyID0gLUVBR0FJTjsNCj4gPiA+IEBAIC03ODksNyArNzg5LDcgQEAgc3Rh
dGljIHZvaWQgbmlsZnNfdHJ1bmNhdGVfYm1hcChzdHJ1Y3QgbmlsZnNfaW5vZGVfaW5mbyAqaWks
DQo+ID4gPiAgCQlnb3RvIHJlcGVhdDsNCj4gPiA+ICANCj4gPiA+ICBmYWlsZWQ6DQo+ID4gPiAt
CW5pbGZzX3dhcm4oaWktPnZmc19pbm9kZS5pX3NiLCAiZXJyb3IgJWQgdHJ1bmNhdGluZyBibWFw
IChpbm89JWx1KSIsDQo+ID4gPiArCW5pbGZzX3dhcm4oaWktPnZmc19pbm9kZS5pX3NiLCAiZXJy
b3IgJWQgdHJ1bmNhdGluZyBibWFwIChpbm89JWxsdSkiLA0KPiA+ID4gIAkJICAgcmV0LCBpaS0+
dmZzX2lub2RlLmlfaW5vKTsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiBAQCAtMTAyNiw3ICsx
MDI2LDcgQEAgaW50IG5pbGZzX3NldF9maWxlX2RpcnR5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVu
c2lnbmVkIGludCBucl9kaXJ0eSkNCj4gPiA+ICAJCQkgKiB0aGlzIGlub2RlLg0KPiA+ID4gIAkJ
CSAqLw0KPiA+ID4gIAkJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+ID4gPiAtCQkJCSAgICJj
YW5ub3Qgc2V0IGZpbGUgZGlydHkgKGlubz0lbHUpOiB0aGUgZmlsZSBpcyBiZWluZyBmcmVlZCIs
DQo+ID4gPiArCQkJCSAgICJjYW5ub3Qgc2V0IGZpbGUgZGlydHkgKGlubz0lbGx1KTogdGhlIGZp
bGUgaXMgYmVpbmcgZnJlZWQiLA0KPiA+ID4gIAkJCQkgICBpbm9kZS0+aV9pbm8pOw0KPiA+ID4g
IAkJCXNwaW5fdW5sb2NrKCZuaWxmcy0+bnNfaW5vZGVfbG9jayk7DQo+ID4gPiAgCQkJcmV0dXJu
IC1FSU5WQUw7IC8qDQo+ID4gPiBAQCAtMTA1Nyw3ICsxMDU3LDcgQEAgaW50IF9fbmlsZnNfbWFy
a19pbm9kZV9kaXJ0eShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgZmxhZ3MpDQo+ID4gPiAgCWVy
ciA9IG5pbGZzX2xvYWRfaW5vZGVfYmxvY2soaW5vZGUsICZpYmgpOw0KPiA+ID4gIAlpZiAodW5s
aWtlbHkoZXJyKSkgew0KPiA+ID4gIAkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gPiA+IC0J
CQkgICAiY2Fubm90IG1hcmsgaW5vZGUgZGlydHkgKGlubz0lbHUpOiBlcnJvciAlZCBsb2FkaW5n
IGlub2RlIGJsb2NrIiwNCj4gPiA+ICsJCQkgICAiY2Fubm90IG1hcmsgaW5vZGUgZGlydHkgKGlu
bz0lbGx1KTogZXJyb3IgJWQgbG9hZGluZyBpbm9kZSBibG9jayIsDQo+ID4gPiAgCQkJICAgaW5v
ZGUtPmlfaW5vLCBlcnIpOw0KPiA+ID4gIAkJcmV0dXJuIGVycjsNCj4gPiA+ICAJfQ0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9tZHQuYyBiL2ZzL25pbGZzMi9tZHQuYw0KPiA+ID4gaW5k
ZXggOTQ2YjBkMzUzNGE1ZjIyZjM0YWM0NGE5MWZiMTIxNTQxODgxYzU0OC4uMDlhZGI0MGM2NWU1
MDVkOTIwMTJhM2QyZjVmZThhNTY5NmUxMDA1NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25pbGZz
Mi9tZHQuYw0KPiA+ID4gKysrIGIvZnMvbmlsZnMyL21kdC5jDQo+ID4gPiBAQCAtMjAzLDcgKzIw
Myw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfbWR0X3JlYWRfYmxvY2soc3RydWN0IGlub2RlICppbm9k
ZSwgdW5zaWduZWQgbG9uZyBibG9jaywNCj4gPiA+ICAJZXJyID0gLUVJTzsNCj4gPiA+ICAJaWYg
KCFidWZmZXJfdXB0b2RhdGUoZmlyc3RfYmgpKSB7DQo+ID4gPiAgCQluaWxmc19lcnIoaW5vZGUt
Pmlfc2IsDQo+ID4gPiAtCQkJICAiSS9PIGVycm9yIHJlYWRpbmcgbWV0YS1kYXRhIGZpbGUgKGlu
bz0lbHUsIGJsb2NrLW9mZnNldD0lbHUpIiwNCj4gPiA+ICsJCQkgICJJL08gZXJyb3IgcmVhZGlu
ZyBtZXRhLWRhdGEgZmlsZSAoaW5vPSVsbHUsIGJsb2NrLW9mZnNldD0lbHUpIiwNCj4gPiA+ICAJ
CQkgIGlub2RlLT5pX2lubywgYmxvY2spOw0KPiA+ID4gIAkJZ290byBmYWlsZWRfYmg7DQo+ID4g
PiAgCX0NCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvbmFtZWkuYyBiL2ZzL25pbGZzMi9u
YW1laS5jDQo+ID4gPiBpbmRleCA0MGY0YjFhMjg3MDViNmUwZWI4ZjA5NzhjZjNhYzE4YjQzYWEx
MzMxLi40MGFjNjc5ZWM1NmU0MDBiMWRmOThlOWJlNmZlOWNhMzM4YTliYTUxIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZnMvbmlsZnMyL25hbWVpLmMNCj4gPiA+ICsrKyBiL2ZzL25pbGZzMi9uYW1laS5j
DQo+ID4gPiBAQCAtMjkyLDcgKzI5Miw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfZG9fdW5saW5rKHN0
cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ID4gPiAgDQo+ID4gPiAg
CWlmICghaW5vZGUtPmlfbmxpbmspIHsNCj4gPiA+ICAJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2Is
DQo+ID4gPiAtCQkJICAgImRlbGV0aW5nIG5vbmV4aXN0ZW50IGZpbGUgKGlubz0lbHUpLCAlZCIs
DQo+ID4gPiArCQkJICAgImRlbGV0aW5nIG5vbmV4aXN0ZW50IGZpbGUgKGlubz0lbGx1KSwgJWQi
LA0KPiA+ID4gIAkJCSAgIGlub2RlLT5pX2lubywgaW5vZGUtPmlfbmxpbmspOw0KPiA+ID4gIAkJ
c2V0X25saW5rKGlub2RlLCAxKTsNCj4gPiA+ICAJfQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25p
bGZzMi9zZWdtZW50LmMgYi9mcy9uaWxmczIvc2VnbWVudC5jDQo+ID4gPiBpbmRleCAwOThhM2Jk
MTAzZTA0Y2QwOWIwNjg5ZmUyMDE3MzgwZDc0NjY0NDk2Li40YjFiZjU1OWYzNTI0YjFjYzM5NjVk
YWU5ZmQzZTU3NDU3MTg1NjlkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmlsZnMyL3NlZ21lbnQu
Yw0KPiA+ID4gKysrIGIvZnMvbmlsZnMyL3NlZ21lbnQuYw0KPiA+ID4gQEAgLTIwMjQsNyArMjAy
NCw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfc2VnY3Rvcl9jb2xsZWN0X2RpcnR5X2ZpbGVzKHN0cnVj
dCBuaWxmc19zY19pbmZvICpzY2ksDQo+ID4gPiAgCQkJCWlmaWxlLCBpaS0+dmZzX2lub2RlLmlf
aW5vLCAmaWJoKTsNCj4gPiA+ICAJCQlpZiAodW5saWtlbHkoZXJyKSkgew0KPiA+ID4gIAkJCQlu
aWxmc193YXJuKHNjaS0+c2Nfc3VwZXIsDQo+ID4gPiAtCQkJCQkgICAibG9nIHdyaXRlcjogZXJy
b3IgJWQgZ2V0dGluZyBpbm9kZSBibG9jayAoaW5vPSVsdSkiLA0KPiA+ID4gKwkJCQkJICAgImxv
ZyB3cml0ZXI6IGVycm9yICVkIGdldHRpbmcgaW5vZGUgYmxvY2sgKGlubz0lbGx1KSIsDQo+ID4g
PiAgCQkJCQkgICBlcnIsIGlpLT52ZnNfaW5vZGUuaV9pbm8pOw0KPiA+ID4gIAkJCQlyZXR1cm4g
ZXJyOw0KPiA+ID4gIAkJCX0NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RyYWNlL2V2ZW50
cy9uaWxmczIuaCBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL25pbGZzMi5oDQo+ID4gPiBpbmRleCA4
ODgwYzExNzMzZGQzMDdjMjIzY2M2MmVlMzRlYmVmZjY1MGVjYjEyLi44NmEwMDExYzllZWFmMDMx
Y2ZhMGI3OTg3NWIyYjEwNmVmOGI3Y2ZkIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS90cmFj
ZS9ldmVudHMvbmlsZnMyLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL25pbGZz
Mi5oDQo+ID4gPiBAQCAtMTY1LDE0ICsxNjUsMTQgQEAgVFJBQ0VfRVZFTlQobmlsZnMyX3NlZ21l
bnRfdXNhZ2VfZnJlZWQsDQo+ID4gPiAgDQo+ID4gPiAgVFJBQ0VfRVZFTlQobmlsZnMyX21kdF9p
bnNlcnRfbmV3X2Jsb2NrLA0KPiA+ID4gIAkgICAgVFBfUFJPVE8oc3RydWN0IGlub2RlICppbm9k
ZSwNCj4gPiA+IC0JCSAgICAgdW5zaWduZWQgbG9uZyBpbm8sDQo+ID4gPiArCQkgICAgIHU2NCBp
bm8sDQo+ID4gPiAgCQkgICAgIHVuc2lnbmVkIGxvbmcgYmxvY2spLA0KPiA+ID4gIA0KPiA+ID4g
IAkgICAgVFBfQVJHUyhpbm9kZSwgaW5vLCBibG9jayksDQo+ID4gPiAgDQo+ID4gPiAgCSAgICBU
UF9TVFJVQ1RfX2VudHJ5KA0KPiA+ID4gIAkJICAgIF9fZmllbGQoc3RydWN0IGlub2RlICosIGlu
b2RlKQ0KPiA+ID4gLQkJICAgIF9fZmllbGQodW5zaWduZWQgbG9uZywgaW5vKQ0KPiA+ID4gKwkJ
ICAgIF9fZmllbGQodTY0LCBpbm8pDQo+ID4gPiAgCQkgICAgX19maWVsZCh1bnNpZ25lZCBsb25n
LCBibG9jaykNCj4gPiA+ICAJICAgICksDQo+ID4gPiAgDQo+ID4gPiBAQCAtMTgyLDcgKzE4Miw3
IEBAIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfaW5zZXJ0X25ld19ibG9jaywNCj4gPiA+ICAJCSAg
ICBfX2VudHJ5LT5ibG9jayA9IGJsb2NrOw0KPiA+ID4gIAkJICAgICksDQo+ID4gPiAgDQo+ID4g
PiAtCSAgICBUUF9wcmludGsoImlub2RlID0gJXAgaW5vID0gJWx1IGJsb2NrID0gJWx1IiwNCj4g
PiA+ICsJICAgIFRQX3ByaW50aygiaW5vZGUgPSAlcCBpbm8gPSAlbGx1IGJsb2NrID0gJWx1IiwN
Cj4gPiA+ICAJCSAgICAgIF9fZW50cnktPmlub2RlLA0KPiA+ID4gIAkJICAgICAgX19lbnRyeS0+
aW5vLA0KPiA+ID4gIAkJICAgICAgX19lbnRyeS0+YmxvY2spDQo+ID4gPiBAQCAtMTkwLDcgKzE5
MCw3IEBAIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfaW5zZXJ0X25ld19ibG9jaywNCj4gPiA+ICAN
Cj4gPiA+ICBUUkFDRV9FVkVOVChuaWxmczJfbWR0X3N1Ym1pdF9ibG9jaywNCj4gPiA+ICAJICAg
IFRQX1BST1RPKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ID4gPiAtCQkgICAgIHVuc2lnbmVkIGxv
bmcgaW5vLA0KPiA+ID4gKwkJICAgICB1NjQgaW5vLA0KPiA+ID4gIAkJICAgICB1bnNpZ25lZCBs
b25nIGJsa29mZiwNCj4gPiA+ICAJCSAgICAgZW51bSByZXFfb3AgbW9kZSksDQo+ID4gPiAgDQo+
ID4gPiBAQCAtMTk4LDcgKzE5OCw3IEBAIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfc3VibWl0X2Js
b2NrLA0KPiA+ID4gIA0KPiA+ID4gIAkgICAgVFBfU1RSVUNUX19lbnRyeSgNCj4gPiA+ICAJCSAg
ICBfX2ZpZWxkKHN0cnVjdCBpbm9kZSAqLCBpbm9kZSkNCj4gPiA+IC0JCSAgICBfX2ZpZWxkKHVu
c2lnbmVkIGxvbmcsIGlubykNCj4gPiA+ICsJCSAgICBfX2ZpZWxkKHU2NCwgaW5vKQ0KPiA+ID4g
IAkJICAgIF9fZmllbGQodW5zaWduZWQgbG9uZywgYmxrb2ZmKQ0KPiA+ID4gIAkJICAgIC8qDQo+
ID4gPiAgCQkgICAgICogVXNlIGZpZWxkX3N0cnVjdCgpIHRvIGF2b2lkIGlzX3NpZ25lZF90eXBl
KCkgb24gdGhlDQo+ID4gPiBAQCAtMjE0LDcgKzIxNCw3IEBAIFRSQUNFX0VWRU5UKG5pbGZzMl9t
ZHRfc3VibWl0X2Jsb2NrLA0KPiA+ID4gIAkJICAgIF9fZW50cnktPm1vZGUgPSBtb2RlOw0KPiA+
ID4gIAkJICAgICksDQo+ID4gPiAgDQo+ID4gPiAtCSAgICBUUF9wcmludGsoImlub2RlID0gJXAg
aW5vID0gJWx1IGJsa29mZiA9ICVsdSBtb2RlID0gJXgiLA0KPiA+ID4gKwkgICAgVFBfcHJpbnRr
KCJpbm9kZSA9ICVwIGlubyA9ICVsbHUgYmxrb2ZmID0gJWx1IG1vZGUgPSAleCIsDQo+ID4gPiAg
CQkgICAgICBfX2VudHJ5LT5pbm9kZSwNCj4gPiA+ICAJCSAgICAgIF9fZW50cnktPmlubywNCj4g
PiA+ICAJCSAgICAgIF9fZW50cnktPmJsa29mZiwNCg==

