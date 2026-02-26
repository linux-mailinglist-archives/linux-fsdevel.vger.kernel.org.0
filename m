Return-Path: <linux-fsdevel+bounces-78627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VfDnJP+ioGkvlQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:46:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098901AE9E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF97431746B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67245348F;
	Thu, 26 Feb 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U81oa8Dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1954508F8;
	Thu, 26 Feb 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134701; cv=fail; b=Mt3hP02ny3jL8vlVSpreCiHhNECigFxXHz5NuRqHfoQq8aPb5eBg7fk585LHyINO5qo1RZeeyyOKkvZaIhgyw3k4QGGsoQN841doY28WfRiVQ/hE7gSS5oVo2j/r4wHWY14lnUk0rq1gAO/sukolezkdyMCYIz0gMs7fRQqTbvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134701; c=relaxed/simple;
	bh=EAcRJUjA6qFQ3Qprj+u9ydkV9nD17myYo+iArta8jf0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=akZtrKzoTX81k/Iy02psveoE1yjxcCzqXxexP5eSNtwmw+lEw7XcktogYI2wvQFA9VOkhwYHNgN1gA0er2otKubYNRGdQjQt6YZ6HMD6Q1333HvV+ba4Qwhhi6HxTFd+9r7sfnKjebYuGMYCOxCrbqbypYPoHeNLN+CSE8gQvFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U81oa8Dx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QFck8L2346011;
	Thu, 26 Feb 2026 19:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=EAcRJUjA6qFQ3Qprj+u9ydkV9nD17myYo+iArta8jf0=; b=U81oa8Dx
	VJIYahgTlQ1qw5SGtBpnX4KPgnD/2Y+JxaDfR0UfMM3k0iVxoqDDTaoMuYWQNQqG
	Z0qmfg4uzUXv094Nlbo5gq3PkTN4hK4Eosu4xyXGv2CfViQx7ZlmMYGoHJ0AfHC9
	8mEvAxYHTTS5mBDHlM/H0Md46Dlmq4pHqKKJ0pVDfRCNTyh1E4s5/1wJFtDdsh3H
	5onUtygOGBfFtVGDLWEWK9MP5fFDRgW43cemoauSyoXwMPcVs48psw0g470ZOUjT
	eicMER9xhebqV00xLhXEo/8sOGpJ2xWYhv93/o2Qb5byVp/Sp0F5ECT2RilpPUBd
	3+5cHNvIMJPEWQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858x2vp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:37:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXi5Fzt9BklonDHRH745U2Kp6t/tb9gcuMex6xhBDTrWzURc4UxQb+zIKT8z1diPnkzycQWwl2zCyjfJ8V/lQ+DHtb/hUECvHXd99QsiyWI/mWSUaz6BWoJyHCJ2m2lz02yr1WnIFGcMcwQISlvtn1677zL8A7rF6WEbLPUA2Pei9KeDkjJGOYfzYvzV3TSmNBBWuLWl9YpApayNMLs7VIoeEjTTA/fyYhnc8RgUy6SkUiQbpZWasdGj2HF4GIsrLzD5ZG0+Q0Fg2MQPwBLKexH0BOslTwLg+9QSUXo8JszR8Nmat/aks6ZE5p3josNvhR3haiT2gW74Tiswd7x17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAcRJUjA6qFQ3Qprj+u9ydkV9nD17myYo+iArta8jf0=;
 b=MlXssxLyAsZ3VmaxA9ev73BmW41KyrTkGmBy7Ozz2OUlwROfBN0aNM6gtfKH7Aar1o86eEvYyI2vkRLz9GF4IBYrk2PVPQFvpX1I2ytHXHu0s9EOELJ2puKRaFcLam4SOlTAT0lnxBIJ+5lPe90SyGLRQQxHmXKhKhBbys15DTE0eZiLBjDOPtIzpSXwasrKcnhdE6KqG2rTnlaA6TLzjh+Eh317uKWH+7zdwSExFQXIkCby7z0bRSUXzBJ9U4tl79BbfzYAa4Lg+ITtv2/NycIVKBXJ8gyk4lKp25evRU/nEHVFQ1/ix9hLbti2wScpWxPUkmhN4tHj6RH666j2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3979.namprd15.prod.outlook.com (2603:10b6:303:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 19:37:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:37:12 +0000
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
Thread-Topic: [EXTERNAL] [PATCH 25/61] ceph: update format strings for u64
 i_ino
Thread-Index: AQHcpz/qP+5RsTPDR0u+eFzUdkpQnbWVYBsA
Date: Thu, 26 Feb 2026 19:37:12 +0000
Message-ID: <2dc7436752b669bc89d6dd93383c2d39984c46c5.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
	 <20260226-iino-u64-v1-25-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-25-ccceff366db9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3979:EE_
x-ms-office365-filtering-correlation-id: a5adee3c-c3f3-4ed9-2e8a-08de756e7071
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020|38070700021;
x-microsoft-antispam-message-info:
 5fAop6Y+c0rBIIAM5zdAFzmRMfjmCzBGaVG/qQGQ6CjcvM886WFhhh76f+2dLvyUUXJhpxgKsGUckO8EKr6r16GCPPZU/m/yNeJt9zBBaz5uKsDgz0T3NeN8fXCavMt73c1cMsJiM8VaOhs4/m7lZU86aOuON1CHtOcJJrV11dQvmK6wkEzMTFAeFkecCPqaor0+1woQGNsEUexs0r5GUL7jg+qlIbgL7yrBNu9R5mULR8wsnVTa8P0V8vSILW6Sz9grUwkA/ieJuakRCHxy+vE9j7n4E1vpK2w4+j34+WOa3uDbT9ZUe2zJmXC+BvhMzchZ7MpZAr1f3DeyTCQRwiYOM1r25l1lryhZwkqZATx4nfvS3sFUrt+xDqW6j3RdyYbPLVHVR/zZGg6u8zOaZc6pKozMuYbkAuIl6JhYcfBGW7GyVofjaEdHPHf5Z381ElhJAfNc3/Eg1hLSqnQLFgOztGVWoK4MW2YbcPQLVxkL/a88b6ox+gwTrpD2lA5NmsyA6oIfP/Aeal7QZJV2eWgElQvWGqXLnJZvzpOlEVBfLgjIUGlx0EEYBQc584solqtSIZETwocFATv6cIBS34xI+Hpdm2ZI4W95hymoW9yBuipViqiAs6LOyoIoTQC+v3Csmya9JWFobwSYKoUBYOnARA0yDXyBGGrJ4efdDFs/Eh/Fheg8bcFMX8lI2OrDzokzS/G/xO8bWxrIavaWdnr+1Sm2WcqkLLK7JWSliX5Acs68D+F+c5qrsR+GCqq6nxtxy3bbUQWJEUDYsT8vVz9QH0d/RB6hoPIV6QIeaNkqtNy8Uf06PuOZ8ADGIpX2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cC9aQVZOZWtnc1h5REptT0hOZ1F3VitIeVFDOUtGdCtDcjJiZTkxVWZEeFBO?=
 =?utf-8?B?RVdFMUlUbzJIbzRDZ3QySERRZk1JbGtZYnowbUMvY2FxaWlBdldoVlFYMXpk?=
 =?utf-8?B?MzlOSGVFT3Y0R2U4em9Mc2J6eS8yTXZ4TWRWZTVTb0tGa0dwVzJobXRDVXdV?=
 =?utf-8?B?TXllNHp0Zjl1czRnbHFWc2tsSERtRzVYQVJ1aDE0Q2g5OUFDakZhYzlaVTlz?=
 =?utf-8?B?NjVDVEcwWmVaWjhsQXI1TWpWcmh2cE5ScEE4MmZGaVd1SFJuU2g2emlhMy9o?=
 =?utf-8?B?RFExNzZGdXdOOVpoZEJkdHM0YUs0ZWZKLytOaURKbGVhRTEySmZFdGhjUEJl?=
 =?utf-8?B?RnNQRG1qZTBFN1lkcHFTZ2wzcUp1SEg0TFQ4N0dxT2dXZzRWdGRiakRkbkV3?=
 =?utf-8?B?bGJIUEtDY05La05QNTA0K0YySFNTbDhpT3MrM3Jna0tnRXZHL1V1K0k0ZU55?=
 =?utf-8?B?RS9vd2RNbDlUNlhCMFovYXMzVC9JUm9Kc3EzSVUxNXRvK0RIdElsV3lISlFX?=
 =?utf-8?B?SW9Va1lNb2ZBNzNkS2R2bEZXUmlmMm9wdEVnQkc3TElRNXE5Ylh4UC9Sak5C?=
 =?utf-8?B?N3NiczN5emc5b3NuQ3IvbG5ndUx3MUVlcXg4cVZ4cWRpbmZ1cW9ibVIxN0hm?=
 =?utf-8?B?bGFiRVlCUVVzUHZYUWsyaEhRaHhDMC91V3JHZVlqcEJVb0lhRWlXNFR2RHpi?=
 =?utf-8?B?Vm9uaG1rVURXV0QxUDhIdHZ2d1psa3FrOWNHSFhZMXQxK1BwWHN5cGhVZy9X?=
 =?utf-8?B?Tnp4QTQ0dDlQS1ZYTG9UK3g5b1hwS2dMV3VYWWdNNGY0ajJxYnhBMm4vdnhl?=
 =?utf-8?B?UDN2a3pha2hKWVZDQ2E4MnRTMFRyMk9RR3g3dlNlN2FqNTJQOGY3Qi9sb1JQ?=
 =?utf-8?B?TVdyNlpWc2hSa0o2aStGZ3crc244R0hhY2JvSUhMSzhpajROREIxUm5na0pw?=
 =?utf-8?B?L29mT3NNcTlNL0dQOVM2ZE1RVmVESUgrRWNuUk1HOVJJT0tWNGpGUzJHT2tv?=
 =?utf-8?B?L09OMjFhTVZqY29hT09oUzhXNVYwWVpqdm1PZ3hEcUd3eForMVpqdTYxSm42?=
 =?utf-8?B?bVVQSUJoa1ozYnZTMzdwMzZ0TWcwTmMwdHI0UjMwU1hnd29NNHRwYlhRbXR4?=
 =?utf-8?B?TTNDaTJPbGVZemFyQWJNS2dVa2VSNDFzSnREbTZNcDNKQmN0NitYc3ZoZmpG?=
 =?utf-8?B?V0xoTnBnL3BjQ2t3SjdHZXJ6ZGFiQU9NQUVBRlQvZkdqTnJuT0o2VUdoNDg2?=
 =?utf-8?B?YUVDc3VqVjN6NS9Fc21TQXNSNFNkSjVNYm1WSXZxaXVhV05jSEJQV0lvVW0r?=
 =?utf-8?B?QUpsY2pmSmVyUTk1cXluc25QUjNkdlBWZGRiL2hzOVVjbmJTKzB4WS9zKzRi?=
 =?utf-8?B?cEpyNnFsaGNsYi9mNVdZVlJnVlBacDZsR2U3U3A2Q0hvU1FmWnBGcUI5ZDB3?=
 =?utf-8?B?anI3aDI1SzRNUGdSUkw4aHRNOHIxSlRmVnplcFN3K3ZGcm5Na1BpMmxsaXVl?=
 =?utf-8?B?U3NHcjJSWFUvRmNkcGUrOTVyV21DOS9sNjlESE9TY0FrQU00ZktrWGhmVFBh?=
 =?utf-8?B?RG80ZG9KNXEyT2JxdjZtSVBQdHEyc0lxRUU3YXhPTDBaVU9nNG12T3QrZ3pM?=
 =?utf-8?B?bkhxNlJhUm9lbHZMaVFUdmhsd0FkRi9ydzZJQ21VaHY3OFFheWNtano1Yys2?=
 =?utf-8?B?c1ZrRCtFNVhMT0Y2K1ZUOTRkY3RPRzlTejQ2YmlITnRBSzN5U2NsdlhiNjBB?=
 =?utf-8?B?SG5SWXNmYUZBUzhVUFdMSHVmUm0zKy9kOEcrM3Q0aStieXhEQ0FOUWxRczRV?=
 =?utf-8?B?OThycHF4d1ZnLzVjdTJqckFHNXZXUVVhK1k3eHZRYUtlV1hsWVZHRkhqaStL?=
 =?utf-8?B?VkU3Tjd0NUNVZUt2a3VNc1NQckhEWnYxaEh6T0NJQ0ZBUTFEeC9SOVFKbU0y?=
 =?utf-8?B?a1pSNnNMMDRMbFg3aWM3K2RoU1NZNElocUhxUXRGMnZxYjY3VW9waDNGeE9l?=
 =?utf-8?B?MUUzSmxicUp5Rm5LNnhGVlJxekV6RHpLVXlndDkxUXNRN3RUbEZha2ZwMHd0?=
 =?utf-8?B?M1BsM3dPTFdHdXRGQzhLdjdMS0VrMzBMUy9tNlc2Wm93ZzhkK0JJeDBJcG5n?=
 =?utf-8?B?L3NSSmY5ZEJ0RVVjOStLUXp1VkQ4RDdDVThPblVlTXA0eVVGY3VVQ0o1cVpm?=
 =?utf-8?B?SVgvbUNlRDlYZFpvZ3dmRnZ3Vm93WG5hODZZaERyTXBhRnFmRWhibHBKTEU1?=
 =?utf-8?B?MjZ3VU9vR1ExdFpYV3gybGtQWmkyUkpNL3FJU0lVQWxMVTRpUCtld3drajRH?=
 =?utf-8?B?dnFTeEpVQU8yYThkbzJMYlBERGJRbTJLVTRsUXlCVUcwZjFTaW5Sa2Nmd1ND?=
 =?utf-8?Q?Q/PNynifrdCZV+7AIWflqeYiP/1hBJ6+f7CkR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AADC9488CFA3047AEEB4B0F579550AD@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5adee3c-c3f3-4ed9-2e8a-08de756e7071
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:37:12.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KMX2W1ASDUFAixb3cwXeAo4woeyJLGEvs/YWKCYUMSHP/utu3m71iZmf0Yus9pG48RkVfQ0cHwonftiiqUksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3979
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX9Yb6rprrLuG0
 EdoUA25RyZ8C1JXklwLIAyfJsRMXBwIgmywZ2Lx1W7c7rJq9R2BBbf8GVfLspx5Dtt7H59YQMmo
 d2O8OQ/99u85DxfxsAK774CjC3OD2HDDJkGdmhJjpho0kBBcdBYiTO7WmcsrcJbVxNMyqQPcrql
 1bMnDnblZq55lrYf70GcVtwIOr81piRjASILMg92Obp1oPHEKSdg9TVoS7l726PiJf3bsxuuXUt
 Zd1WqxySsRrLdylQsAu9s5a1xiGwo4KeL6ahvel7+ZYINgbbyLIKBKjHkZ0NZpDEex02OwQJCip
 nGrZxPYag4Xy+u1g+/Va1AomzJ4V1ku1rDtwX+brvAgu2w4zg7Z2yDu5uijQUcCeO5e5OY918vs
 vmiW9IL3UoQh3mVdsWyt9IyP4ni3bHE120Hgcb5zuUJrck2hlqk9sZIQYat54eyF59vYvm/eGs7
 MBXS3BETkUSWE2c6J+w==
X-Proofpoint-GUID: ZSNUJj-G8XVs6dTtXRH28J7QAgD_mhRT
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a0a0ed cx=c_pps
 a=a15oepxCFtbapkdjUscCyA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=zr94bLkQGwJZMLBWZqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9voucK_jFeHexuibvw3JeTspnur0tvyu
Subject: Re:  [PATCH 25/61] ceph: update format strings for u64 i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78627-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,dev.tdt.de,linux.intel.com,suse.cz,arm.com,schaufler-ca.com,physik.fu-berlin.de,szeredi.hu,linaro.org,canonical.com,gmail.com,dubeyko.com,infradead.org,mit.edu,codewreck.org,hallyn.com,cs.cmu.edu,ffwll.ch,google.com,omnibond.com,linux.dev,samba.org,brown.name,namei.org,evilplan.org,oracle.com,ionkov.net,intel.com,themaw.net,amd.com,efficios.com,talpey.com,fasheh.com,artax.karlin.mff.cuni.cz,microsoft.com,suse.de,manguebit.org,wdc.com,vivo.com,suse.com,linux.ibm.com,tyhicks.com,fluxnic.net,zeniv.linux.org.uk,paul-moore.com,nod.at,goodmis.org,linux.alibaba.com,alarsen.net,huawei.com,crudebyte.com,dilger.ca,auristor.com,paragon-software.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 098901AE9E1
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDEwOjU1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
VXBkYXRlIGZvcm1hdCBzdHJpbmdzIGFuZCBsb2NhbCB2YXJpYWJsZSB0eXBlcyBpbiBjZXBoIGZv
ciB0aGUNCj4gaV9pbm8gdHlwZSBjaGFuZ2UgZnJvbSB1bnNpZ25lZCBsb25nIHRvIHU2NC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgZnMvY2VwaC9jcnlwdG8uYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2Ny
eXB0by5jIGIvZnMvY2VwaC9jcnlwdG8uYw0KPiBpbmRleCBmM2RlNDNjY2I0NzBkZGJkNzk0NTQy
NmQ3OWY5MDI0YWU2MTVjMTI3Li4zYzhhMjFhNTcyZDgyMzBiNTU4ZjIwYmIwMjcyMTE4NGNhZTM1
ZWU2IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsrKyBiL2ZzL2NlcGgvY3J5
cHRvLmMNCj4gQEAgLTI3Miw3ICsyNzIsNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2Ru
YW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBlbGVuKQ0KPiAgCS8qIFRv
IHVuZGVyc3RhbmQgdGhlIDI0MCBsaW1pdCwgc2VlIENFUEhfTk9IQVNIX05BTUVfTUFYIGNvbW1l
bnRzICovDQo+ICAJV0FSTl9PTihlbGVuID4gMjQwKTsNCj4gIAlpZiAoZGlyICE9IHBhcmVudCkg
Ly8gbGVhZGluZyBfIGlzIGFscmVhZHkgdGhlcmU7IGFwcGVuZCBfPGludW0+DQo+IC0JCWVsZW4g
Kz0gMSArIHNwcmludGYocCArIGVsZW4sICJfJWxkIiwgZGlyLT5pX2lubyk7DQo+ICsJCWVsZW4g
Kz0gMSArIHNwcmludGYocCArIGVsZW4sICJfJWxsZCIsIGRpci0+aV9pbm8pOw0KPiAgDQo+ICBv
dXQ6DQo+ICAJa2ZyZWUoY3J5cHRidWYpOw0KPiBAQCAtMzc3LDcgKzM3Nyw3IEBAIGludCBjZXBo
X2ZuYW1lX3RvX3Vzcihjb25zdCBzdHJ1Y3QgY2VwaF9mbmFtZSAqZm5hbWUsIHN0cnVjdCBmc2Ny
eXB0X3N0ciAqdG5hbWUsDQo+ICAJaWYgKCFyZXQgJiYgKGRpciAhPSBmbmFtZS0+ZGlyKSkgew0K
PiAgCQljaGFyIHRtcF9idWZbQkFTRTY0X0NIQVJTKE5BTUVfTUFYKV07DQo+ICANCj4gLQkJbmFt
ZV9sZW4gPSBzbnByaW50Zih0bXBfYnVmLCBzaXplb2YodG1wX2J1ZiksICJfJS4qc18lbGQiLA0K
PiArCQluYW1lX2xlbiA9IHNucHJpbnRmKHRtcF9idWYsIHNpemVvZih0bXBfYnVmKSwgIl8lLipz
XyVsbGQiLA0KPiAgCQkJCSAgICBvbmFtZS0+bGVuLCBvbmFtZS0+bmFtZSwgZGlyLT5pX2lubyk7
DQo+ICAJCW1lbWNweShvbmFtZS0+bmFtZSwgdG1wX2J1ZiwgbmFtZV9sZW4pOw0KPiAgCQlvbmFt
ZS0+bGVuID0gbmFtZV9sZW47DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVz
bGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

