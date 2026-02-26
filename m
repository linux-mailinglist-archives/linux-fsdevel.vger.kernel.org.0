Return-Path: <linux-fsdevel+bounces-78625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHPUN8ehoGlVlAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:40:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 808561AE8CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1266F30B84AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBE44DB81;
	Thu, 26 Feb 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sNP/T8BS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB844D695;
	Thu, 26 Feb 2026 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134516; cv=fail; b=FM14fq3hpa81g2q9T5IA3m/r0YRKp84lp86f1PmF3iPN1sEf4mmxBdWr2ewQk+MqtQdf0WVnfaga/fXINrvnL33i6Ow/alE7X358cScVrxdWvOEUMbJzVpkYUeMW8qwAqH5y0DwfgVmGWIFGf5jhPj/HlPPMlgRo5frToIjOQzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134516; c=relaxed/simple;
	bh=LILfmGjZqKoX4SxkAinliX4KD5JtQIXnFpvI7AAiOtM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IxgJwtHApdoNS992QsMq4Yazz2+jOqmALfBwop+M2TYx6k9dDFf8dz5UJVoNYV3+LqvJMEiCrPGlZQnVrVsrA3FCdoUzzLczJ05n+lufoV3CujiTktSb/h0jwSzm9mnyJTHndN6C+LDnJ2V9cDa0PgjzTWBUQ3DeKE3xMISTGTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sNP/T8BS; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIuUWg2346005;
	Thu, 26 Feb 2026 19:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LILfmGjZqKoX4SxkAinliX4KD5JtQIXnFpvI7AAiOtM=; b=sNP/T8BS
	JO9xuFg2jGdAZZv19ntk3EIagQdH/11b4uWWozLL5KqjhhA5YRevSv0Vh8y7oW6V
	HGQYZJ32apoYLqHN/8NOU8mBQeiJ/kSu7qbcGb7Ld70dyrqpFNBq+iZV+ycMTNLv
	HjKOc8yF5T5d0Lm9A6nADkG1q583M+PBr1Xlud2yVXYHG79pz00DZTsoawUKI0rE
	foQUbtQvtLtNdH/gVnuZOCJZN6hZXvINt57izE05sTTU+GfLC0p0ed517ql4/J5v
	+Offuuz/PehR8wzwXIAzAcg+CDplik6jQFwhntHOJSpP4yPC85NoU6NtuB4lN0Ga
	3JIaYsMwQUYtQA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858x26j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:33:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTEVROjL1MpGC37SBIVoReLpQ0Va4hNcQbJvgn7X3fL2SrXMBxEJIDd/McrU9k8G2SFRJgI8btykTT18oY8jBXzvLwLk3ydqsrElAjbj8KNQ/htYNRgUae0/s8QSI4G/bRHOBZzJSkv+4L3Sp8VdjqwuH3e4iWKQk3jC3kVfZ7ofi8IhzOXun33OrWcK61/SJOymg3ztjz55g2W7mcQYsMtAGippbZUnCkt3NL7Da8sx/JITpgfBXw1zuM2Arl91GNsgXl5EngolXtlJS4uShFo4XlpfP4V/0e04rNbZjmmDkvKzoZut63f+A09Tf6n/C7W7ZqfELxRrAOvTcMS+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LILfmGjZqKoX4SxkAinliX4KD5JtQIXnFpvI7AAiOtM=;
 b=YO4RqbqURYeCTWkCP9IvWw3ilw/uc/3KBxzCPXq8sdBcR272n1stFAweHqdpHd2JpwlU3aSKIDkuCi6VHgZyyw1v1CZMW+3DA0aKCf2V4Bf75VR4yO9rnCcV+768CpbzL6zBTnKqLBcaJiMubmFvjofw4vDpE2xZf2XOS7ua5qyMDGpd8TtOh43c5/jUG/aCB+zg7Bz/6N3oDoiGYeIAop4SVUy4a+QICq9Xs6avg1GrnLLyyda7Qr501e3b6XCRlhArPGHzqXB011tYrj8PsHIbxbC2vwWGLSdkJwslElGCuLLnYOkvilTW5+GzRRI79nM+dtl/JIQaWQjtbEF7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5693.namprd15.prod.outlook.com (2603:10b6:510:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 19:33:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:33:37 +0000
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
Thread-Topic: [EXTERNAL] [PATCH 33/61] hfs: update format strings for u64
 i_ino
Thread-Index: AQHcpz2x4TUu0p1b1UOrTR9iSPzcyLWVXx4A
Date: Thu, 26 Feb 2026 19:33:37 +0000
Message-ID: <0bc9e485e475a12e1e2c9a73b781308fd94a97a4.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
	 <20260226-iino-u64-v1-33-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-33-ccceff366db9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5693:EE_
x-ms-office365-filtering-correlation-id: ae649948-3a84-4c30-576a-08de756deff5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 cahQUZvB1A3MAJEwPbxU3hSrLW7Ns8lPCLl5gpVuCZSGcPU97Z+M3LcXk87iMbetSbW04W5Y7KY2xx9pu+9IuBXZyYoB+CBXBnhWhAYPUi4bwz7zuYCOJJ0XITR9SnKqJmZsmk9ygX2gXymHaLEZelkJcGMk8BzplRZkpHXBzdPTBVeUFt6MWpp6O4aSttrBl0W56A9WmRcCNgqB+tIMdA3lYWTKg0RYOb7M3D1AqlUScc3Z/eRfRAJLkcMAL+muO6rQUX55/qmzgc8O2RNyLvsFWBjQq2dhONyQTeU91TL0weMZwz3jeZFwFrZqH3kp8pPfe/WIqJ74hz2M3jWbxixjMNE263BFamcUH+41CbgexFmz4ch30Wz8DFx3dFZlu52m0RfmYo2za74W55Pg2I34K1amiVsxHS7NNQ05R7jrjiVkrQZ6XuD1iMaIBniaM6O+fc5KK8mcNY1ZhiwpQRaYs92ar4qJAXl9cSgAgsp6K8LBdwooJsnqpTv9Hjpkdr/pgAnMJEft3YiD0h2n7ZPtUPFuPENO+nJammUVtXXBxs0eMBp3MrRSX53cf2fE+lYIVZSRCTzTTliwz+fRoH2GdFUS2GwIl/yx85nFdmJWbWOZ462PZPlfvOZpM6nq1V+RN+vIWpRycJydjxxbP1tgbEboW9AdgguT699AtVQnOOkszAkJglsu2liZCtBCkh5TJ+/16yclEpJyln5IxMKvRACrPR2GwjAUljw5fTU7YEZVUDmhpSebx46g6vut8S8BG1geJQv7gJGZEx5wgmnJn9ysa5KMSBFD+ySRq19PR1oDT+16n2X9rgd6WRIM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnBDZ3NhcjNmZ1FPemRzOE1haldNZXdIK1dnT3FES3BleTFNVVE1TURQaVJD?=
 =?utf-8?B?UzE1azFuTFgwRUxKYkU4QytIeTk0MnU3ZEptajdTbjRvWkRqRFE5a3ZoakN1?=
 =?utf-8?B?QlNuUUd1M3VDWis2clRCdFF6ODlQUVkxeGtBTk9ZUHRzWWZMVmdlaEJvT1NH?=
 =?utf-8?B?TFNxbktKT3c3QmFuSGhYT1JGTGhYclhMaVV1ZkRhZUloeTVmQTRDajgxM1o0?=
 =?utf-8?B?Z2VtdExvMUhXZU9yYk90dllqZUNuQkdtamJrdTBZK3B2emVCNjFmeTdwdHRh?=
 =?utf-8?B?dEhVSnVOYkJKVlVBaFJKb01sNUZJNFVPR1BveFFGVkIxamEzdGRrdTRnallq?=
 =?utf-8?B?bjB3a29UVTVsbENyVjF4U1FNaEx5TGY5bG0zbGhwRU53aWRqUkJSSU9aSFA2?=
 =?utf-8?B?NzM5VmRwak1qdjVHNzFMTFdnTkttUWRUUEZNSHFyak5GMS9KL3Z0NUV1RG1Q?=
 =?utf-8?B?TjB2UG9DNnNjZVBPRk1JbkxxVFVIeko1T2ZVTXRBSnFFZ3lSbHpLaWZnTVJ4?=
 =?utf-8?B?R1ladkpFcG92dEFkS3RpbUNLMDNXQlkxcFJpMVZ4bENFSFVYZ2EzcTJvMStT?=
 =?utf-8?B?d3BYTkRKR2diVTRmYmF3RW1HQjF6RkNnWkswbkZFQ0tzcyswdEJGNWpSVUtP?=
 =?utf-8?B?VWdkWkhLSHEyMFlJZXR2UmlGOXdjRGUyK01zanBvWWxZa2ZmMW5hNTdLMDhV?=
 =?utf-8?B?VWJGOGZ2b1VvekhjeTVtZE1TWS9MdnNDTDJLY015VFVkb1NveHNEZ0VTckhw?=
 =?utf-8?B?TXFvUU96Mk9KL0JQcFJzdmkwclRSYytPUmpvT1pWWVJtVTFON2FEVm5iRkUv?=
 =?utf-8?B?NDJhcHhrbjc2UnVZVmxrSnNDQkpiSU5HWURnV0UwcHg0MitNZGRUOWo5NDVv?=
 =?utf-8?B?U0czY1NlZmJldDhHN25GOTE1UVloUllsdldKTG1kYkhBamtOQjFkNldFVFBq?=
 =?utf-8?B?S2ovRk03QTZ0cS9SNmJ5cVo5WStoOVo1Q3JEbCt6aTBVbC9IUFNNbjdpYms2?=
 =?utf-8?B?RTVaV2FIL2gwTllFTUVJd3JQQmJHMVlQN0QyYmJVTWRtSzljK1paN2lqV3Fq?=
 =?utf-8?B?NGhTdlRnVkd3WXZzUUY4SEpDTXQ4cUttL0xIVmVHaFJ2OE1wcEFOVzMrcnJF?=
 =?utf-8?B?b3Rsa242NUFYU0dhK2xSQUR3dWdORFphOE8vN1duenBTK2FaQU5qUEg2RlR3?=
 =?utf-8?B?eEM4Qi9wZzBtRis3eGdUYXJIb0k0TnJhMy9RRktYeGx0LzFKbXRLVml0OWk1?=
 =?utf-8?B?c2NiMlJlbFNtK0w4Tm10WkN3TStia08vRWw2L2NMQTZGK3NmbjBHeEI5WjQ1?=
 =?utf-8?B?c0QwL3NMUlY3VjkrLzRCN3U1cjhCMDIwNkNTT2xmVzV6ZWlYaS9ZZnpyTWNs?=
 =?utf-8?B?b2FPTjQ0ZklhMTJEdWo3OTBIV3FWazRyempBYno4SjVwZDNmMHFha3o4WTh0?=
 =?utf-8?B?YmxydlNjbFZRd3JJVXJDZ1dMQ0dicTJxMXJzaWlMc1EycVZ0ajlBeUduSmcx?=
 =?utf-8?B?aWprZTF4L3R2MXI2YVowZU5PckkyYVpZWEZ1NFg1YytzMGNKLzI4KzlkaFVW?=
 =?utf-8?B?Yk1xcHQyVlErbjB0YWFXY28vQVUwWVV6TGk3OGsrQWlGTldUVUtyNlJnaHdQ?=
 =?utf-8?B?bGhOM1Q5V2JXclAvdU42M0RxZlEvNFk2dzF4THRXbTZ0SUpOb29GYndBTi82?=
 =?utf-8?B?OFh1VXVSZGxGY2dxbUdOVldsaFZheU1VOUFKYlFLdUw2VURZdkEyT1RVK1NU?=
 =?utf-8?B?RHYrUHJoc2FpeXg5a2tXTU1zZjMydFNzbHh2MVF3WEVaVTc4YytBVXpYM3Fp?=
 =?utf-8?B?NXFIcWx5bUpVTmp0aG1PRkpmeE1Cc1FFdTJxNVRXWmc0TmFZaTRrR2p4ZDh1?=
 =?utf-8?B?OGhSQWtJM25NYmgwQlhPNXBRYVcycUdYRXAwamQ5aGtJKzRpMGwwaTArakxj?=
 =?utf-8?B?TjlBeFhuUnpEYlJrUEVETnBIMFI0djZTNDg4SWp4alAwZHVoRnhlWnliVEZ0?=
 =?utf-8?B?SUdBZmpQZDUrVlNpTHh6SFh4QWNqM092ZnNWMU8vUENTNy9sSXBFWlVzait0?=
 =?utf-8?B?TXlNRFhhbi93Q2xaZ2VkU3pJaDB1YTlPd2tMamxBaTU4SGdibW83OWpMTk5H?=
 =?utf-8?B?NHN3UTJjbzRyUGpTN2hkTlV0ZU83ZnFEZm1XRU05YUJyZFI3TEdWSkQxSUdO?=
 =?utf-8?B?NVNIcnpGMU5ybHhSMzgyTlNZTUYwUk53N1hQRmRUQmY2WHRMclFQSjdMcGpn?=
 =?utf-8?B?Y1F0VVVYZ2o5WDRwUzhGZnZzQ3N1WTM5MWJ4Z1BOa2IramxpK2ttR1l5cXlS?=
 =?utf-8?B?ZjRXYm1WYUlDcFpNVWVmYXgzOG9yZFJjTjA2RmNKTlQ5b3R0a0xJV2E4TytM?=
 =?utf-8?Q?afM8HRvGgw/e39HF8UrsDNex8gAAAp5LZ70om?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7670BFBF0951D141B560A656DB2C329E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae649948-3a84-4c30-576a-08de756deff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:33:37.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adyAmpJa7swZ6AcvnPyJYk2pY8i3CfPRcdpdV9jL/28MJfjDrmc+Bvpmn9egnZikqJYDqcTSZHSuFmAxkfCPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5693
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX+ChE7NJba+Se
 xlhStllv5ZamUeo+RBh7vS+HuMO7eDYyGxeBUDv/itpR45KikbJW0pQpTmL852IxlQY+UMrgYhm
 8wyp8laR8xFWvLS9aPJ15cpZ/YbnphMZH55XXBFPNWApjZ6l9F2XFMyOB6fO5JlL2ANLk5DxXyb
 1Cd2G4x3Obw0fNVZhlXZRzn5Ejy0dHIWWPc8HvM7CN2vz1DXN9sKUVLUo4V0o/AkS3nbOX44o+K
 fdigmJCgpr9jlzSMfpeVipjfv/ra3jS0B+qxAVcejy9H+GeuXwa2fX936SvyDNSRLCT4u7UQJFi
 8HcHp+wnTL7oaqSTHKnNnsbyGjV1rhWEeonR+QtzS1TcAZ8nDWg9V/G+jRouuWKueBsIH2O/sg2
 oegqM+ToRCfeJD38IYy012bA6OI2zAMpo+7Xho85JBt1k2gAdYAFesdSiGdlbMcb6jGr4u4EKHr
 Cm36PlD4g3Jdmh2nAzg==
X-Proofpoint-GUID: s8Cy8G7RLCTAYofI-Fb-MvbcVZyaT8xK
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a0a01a cx=c_pps
 a=ItoRIIcZIWT0tNr6APkIeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=p87Qy_SXhRj_V6A2eicA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: A99ac75_wtlLubPgvGPQMPkpOYw2QEeg
Subject: Re:  [PATCH 33/61] hfs: update format strings for u64 i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78625-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,dev.tdt.de,linux.intel.com,suse.cz,arm.com,schaufler-ca.com,physik.fu-berlin.de,szeredi.hu,linaro.org,canonical.com,gmail.com,dubeyko.com,infradead.org,mit.edu,codewreck.org,hallyn.com,cs.cmu.edu,ffwll.ch,google.com,omnibond.com,linux.dev,samba.org,brown.name,namei.org,evilplan.org,oracle.com,ionkov.net,intel.com,themaw.net,amd.com,efficios.com,talpey.com,fasheh.com,artax.karlin.mff.cuni.cz,microsoft.com,suse.de,manguebit.org,wdc.com,vivo.com,suse.com,linux.ibm.com,tyhicks.com,fluxnic.net,zeniv.linux.org.uk,paul-moore.com,nod.at,goodmis.org,linux.alibaba.com,alarsen.net,huawei.com,crudebyte.com,dilger.ca,auristor.com,paragon-software.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 808561AE8CD
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDEwOjU1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
VXBkYXRlIGZvcm1hdCBzdHJpbmdzIGFuZCBsb2NhbCB2YXJpYWJsZSB0eXBlcyBpbiBoZnMgZm9y
IHRoZQ0KPiBpX2lubyB0eXBlIGNoYW5nZSBmcm9tIHVuc2lnbmVkIGxvbmcgdG8gdTY0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gLS0t
DQo+ICBmcy9oZnMvY2F0YWxvZy5jIHwgMiArLQ0KPiAgZnMvaGZzL2V4dGVudC5jICB8IDQgKyst
LQ0KPiAgZnMvaGZzL2lub2RlLmMgICB8IDQgKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2Nh
dGFsb2cuYyBiL2ZzL2hmcy9jYXRhbG9nLmMNCj4gaW5kZXggYjgwYmE0MGUzODc3NjEyMzc1OWRm
NGI4NWM3ZjY1ZGFhMTljNjQzNi4uN2Y1MzM5ZWU1N2MxNWFhZTJkNWQwMDQ3NDEzM2E5ODViZTNh
ZjZjYSAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzL2NhdGFsb2cuYw0KPiArKysgYi9mcy9oZnMvY2F0
YWxvZy5jDQo+IEBAIC00MTcsNyArNDE3LDcgQEAgaW50IGhmc19jYXRfbW92ZSh1MzIgY25pZCwg
c3RydWN0IGlub2RlICpzcmNfZGlyLCBjb25zdCBzdHJ1Y3QgcXN0ciAqc3JjX25hbWUsDQo+ICAJ
aW50IGVudHJ5X3NpemUsIHR5cGU7DQo+ICAJaW50IGVycjsNCj4gIA0KPiAtCWhmc19kYmcoImNu
aWQgJXUgLSAoaW5vICVsdSwgbmFtZSAlcykgLSAoaW5vICVsdSwgbmFtZSAlcylcbiIsDQo+ICsJ
aGZzX2RiZygiY25pZCAldSAtIChpbm8gJWxsdSwgbmFtZSAlcykgLSAoaW5vICVsbHUsIG5hbWUg
JXMpXG4iLA0KPiAgCQljbmlkLCBzcmNfZGlyLT5pX2lubywgc3JjX25hbWUtPm5hbWUsDQo+ICAJ
CWRzdF9kaXItPmlfaW5vLCBkc3RfbmFtZS0+bmFtZSk7DQo+ICAJc2IgPSBzcmNfZGlyLT5pX3Ni
Ow0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2V4dGVudC5jIGIvZnMvaGZzL2V4dGVudC5jDQo+IGlu
ZGV4IGEwOTc5MDhiMjY5ZDBhZDE1NzU4NDdkZDAxZDZkNGE0NTM4MjYyYmYuLmYwNjZhOTlhODYz
YmM3Mzk5NDhhYWM5MjFiYzkwNjg3NGM2MDA5YjIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9leHRl
bnQuYw0KPiArKysgYi9mcy9oZnMvZXh0ZW50LmMNCj4gQEAgLTQxMSw3ICs0MTEsNyBAQCBpbnQg
aGZzX2V4dGVuZF9maWxlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAJCWdvdG8gb3V0Ow0KPiAg
CX0NCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHUsIHN0YXJ0ICV1LCBsZW4gJXVcbiIsIGlub2Rl
LT5pX2lubywgc3RhcnQsIGxlbik7DQo+ICsJaGZzX2RiZygiaW5vICVsbHUsIHN0YXJ0ICV1LCBs
ZW4gJXVcbiIsIGlub2RlLT5pX2lubywgc3RhcnQsIGxlbik7DQo+ICAJaWYgKEhGU19JKGlub2Rl
KS0+YWxsb2NfYmxvY2tzID09IEhGU19JKGlub2RlKS0+Zmlyc3RfYmxvY2tzKSB7DQo+ICAJCWlm
ICghSEZTX0koaW5vZGUpLT5maXJzdF9ibG9ja3MpIHsNCj4gIAkJCWhmc19kYmcoImZpcnN0X2V4
dGVudDogc3RhcnQgJXUsIGxlbiAldVxuIiwNCj4gQEAgLTQ4Miw3ICs0ODIsNyBAQCB2b2lkIGhm
c19maWxlX3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAJdTMyIHNpemU7DQo+ICAJ
aW50IHJlczsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHUsIHBoeXNfc2l6ZSAlbGx1IC0+IGlf
c2l6ZSAlbGx1XG4iLA0KPiArCWhmc19kYmcoImlubyAlbGx1LCBwaHlzX3NpemUgJWxsdSAtPiBp
X3NpemUgJWxsdVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5vLCAobG9uZyBsb25nKUhGU19JKGlub2Rl
KS0+cGh5c19zaXplLA0KPiAgCQlpbm9kZS0+aV9zaXplKTsNCj4gIAlpZiAoaW5vZGUtPmlfc2l6
ZSA+IEhGU19JKGlub2RlKS0+cGh5c19zaXplKSB7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnMvaW5v
ZGUuYyBiL2ZzL2hmcy9pbm9kZS5jDQo+IGluZGV4IDg3ODUzNWRiNjRkNjc5OTk1Y2QxZjVjMjE1
ZjU2YzUyNThjM2M3MjAuLjk1ZjAzMzNhNjA4YjBmYjU3MjM5Y2Y1ZWVjN2Q5NDg5YTI1ZWZiM2Eg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2hmcy9pbm9kZS5jDQo+
IEBAIC0yNzAsNyArMjcwLDcgQEAgdm9pZCBoZnNfZGVsZXRlX2lub2RlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpDQo+ICB7DQo+ICAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOw0K
PiAgDQo+IC0JaGZzX2RiZygiaW5vICVsdVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gKwloZnNfZGJn
KCJpbm8gJWxsdVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gIAlpZiAoU19JU0RJUihpbm9kZS0+aV9t
b2RlKSkgew0KPiAgCQlhdG9taWM2NF9kZWMoJkhGU19TQihzYiktPmZvbGRlcl9jb3VudCk7DQo+
ICAJCWlmIChIRlNfSShpbm9kZSktPmNhdF9rZXkuUGFySUQgPT0gY3B1X3RvX2JlMzIoSEZTX1JP
T1RfQ05JRCkpDQo+IEBAIC00NTUsNyArNDU1LDcgQEAgaW50IGhmc193cml0ZV9pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYykNCj4gIAloZnNf
Y2F0X3JlYyByZWM7DQo+ICAJaW50IHJlczsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHVcbiIs
IGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vICVsbHVcbiIsIGlub2RlLT5pX2lubyk7
DQo+ICAJcmVzID0gaGZzX2V4dF93cml0ZV9leHRlbnQoaW5vZGUpOw0KPiAgCWlmIChyZXMpDQo+
ICAJCXJldHVybiByZXM7DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2
IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

