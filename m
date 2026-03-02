Return-Path: <linux-fsdevel+bounces-79084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMaQHA4YpmmOKQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:06:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 712591E64C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9D2430CBF9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5E33F5BA;
	Mon,  2 Mar 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRHykEpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63F31F9BA;
	Mon,  2 Mar 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491016; cv=fail; b=qpJfGWe8olPC5wGXRXw62vWNZCM9Qa4MnXVGq2tUGpocErj31QLvXQwy3EDQHpyqBXbNpa/b4rTDSY0hv/9m/5zzp0M07fL+PisoSugwIk7vzggPRs3E5xvAsemv3Bv0epjzYSu2y+1d+nHdRFpEVb/P1vgNjNQkN7dSpM0bkDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491016; c=relaxed/simple;
	bh=0PKTLEeP4Tx9A96nY8i3BwXfQLUOJVGNDzDnFjj7ESs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=alCWcUCModLS8a6OI1lTfbkne5AfhYXMty/MFypnfoX120A3rKjVriaVO/P4bfUYY4I0zEDsnn44IbIjNm5XEnVY1yFKVlh3cAotgkyDr/77bITSJz3pjvrFF7As6h8+NXcm6GmoZOECiDsHe4mrwBgzmRhbYS1pnqlRw2rTVxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRHykEpj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EYAtk2165137;
	Mon, 2 Mar 2026 22:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0PKTLEeP4Tx9A96nY8i3BwXfQLUOJVGNDzDnFjj7ESs=; b=RRHykEpj
	9MDPPjMZaP2txMNKCn4mj6Gqg7eRXRc++bC46+fXJW72IGBHqHlfi3q8+KNq3LgF
	Me9y9bvp2zH+nBoZIabmA6krVB4xZlA7mVVHbEbDORftrDJCaVlEAK5qqZWXfMTB
	eHHyjBQEUWxvP+2jFe3T4nGWtJsf+6QfI+AyS228DKjxN9bipQOOrTU2H4r49Qeb
	5mmlxWQFUf+WjlOarorrR95iZFH41rN1uStfk8PSpV6DhcGbfiXxvbCAfypW5kMB
	lCTyB6tgswGZZwnox4tNcgV4jDiLkZA0GfYWVAvqItXRJZls+v2cptrkMu3Mjs0N
	SXUNJQY3nUo4OA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd8qpj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:36:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+voMDjYmu62tnO+xyuks06DW624lpOzFVJ/dbG8A/4GQpWirojdVLOtoZcBdMjuIUkQV5E/YvpwUqoPLzXT6T4V4eilOpFtUQIduc2XxeR/2B+vWBqLLn8cQznV5opWKMVyTG6qmXY1NSYNbk6AqGV74DRNQep05C+V7Jw0wBZYcBRg2cY9KzcvTdTm+rncDcPTG5Mh1PN8p2eF3nMtVW4GuO6aOuMjKLcgNzh6knmEYCDf8xNZf5MQz3SvsofcabS/tN+21IRrfU1Scx9iU1dc1DgUE2icDSRJXNsSOOk4DvCU+AjQuugnxSlQukAQEYx0V2cIAVfhj7h/UtX70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PKTLEeP4Tx9A96nY8i3BwXfQLUOJVGNDzDnFjj7ESs=;
 b=Aw2FrhQuWONSXn4YTFjqAtjhjwDSQITQHpLSjCEgyqKY62fFQ9JtujxCOYAHwGOuHnFBJx8Wh5govNrtmNyAhidi9yqYb1GVy3k9WbCeIyr4QMdnz4eo2Y/+eDjVBpNFeHtcFn4L3DtbrCWLeZLlKy3s/u/aXPJPAG4tcYM9p3/7TZZW9eup1hDXxVYOqLvFP9J3GpWVxvAPgMB9sI/9WDGXoDlo2jRwfPYXAXMiseklfS676izdtSUYgj88o5Ky+JWodTuh4ut2dChVY4oMduuVjft2q+IucgeVM7ey8rSDMWMrqYpZDFeHiIA1r75nPC383Dzwedpzo/884hRrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4155.namprd15.prod.outlook.com (2603:10b6:a03:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:36:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:36:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "jreuter@yaina.de" <jreuter@yaina.de>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        Ondrej Mosnacek
	<omosnace@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "miklos@szeredi.hu"
	<miklos@szeredi.hu>,
        "john.johansen@canonical.com"
	<john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com"
	<stephen.smalley.work@gmail.com>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        Olga
 Kornievskaia <okorniev@redhat.com>,
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "asmadeus@codewreck.org"
	<asmadeus@codewreck.org>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "linux_oss@crudebyte.com" <linux_oss@crudebyte.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "bharathsm@microsoft.com"
	<bharathsm@microsoft.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        Eric Paris
	<eparis@redhat.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "james.clark@linaro.org"
	<james.clark@linaro.org>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "hch@infradead.org"
	<hch@infradead.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dwmw2@infradead.org"
	<dwmw2@infradead.org>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "sprasad@microsoft.com" <sprasad@microsoft.com>,
        "marcelo.leitner@gmail.com"
	<marcelo.leitner@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jack@suse.com" <jack@suse.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "luisbg@kernel.org" <luisbg@kernel.org>,
        "ms@dev.tdt.de" <ms@dev.tdt.de>, "jth@kernel.org" <jth@kernel.org>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "aivazian.tigran@gmail.com" <aivazian.tigran@gmail.com>,
        "anna@kernel.org"
	<anna@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "willemb@google.com" <willemb@google.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "acme@kernel.org"
	<acme@kernel.org>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "jaharkes@cs.cmu.edu" <jaharkes@cs.cmu.edu>,
        David Howells
	<dhowells@redhat.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "courmisch@gmail.com" <courmisch@gmail.com>,
        "martin@omnibond.com"
	<martin@omnibond.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "coda@cs.cmu.edu" <coda@cs.cmu.edu>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "raven@themaw.net"
	<raven@themaw.net>,
        "horms@kernel.org" <horms@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "hubcap@omnibond.com"
	<hubcap@omnibond.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "mikulas@artax.karlin.mff.cuni.cz" <mikulas@artax.karlin.mff.cuni.cz>,
        "ericvh@kernel.org" <ericvh@kernel.org>,
        "salah.triki@gmail.com"
	<salah.triki@gmail.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "sfrench@samba.org"
	<sfrench@samba.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "wufan@kernel.org" <wufan@kernel.org>,
        "al@alarsen.net" <al@alarsen.net>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "ast@kernel.org" <ast@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "lucho@ionkov.net"
	<lucho@ionkov.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "marc.dionne@auristor.com" <marc.dionne@auristor.com>,
        "neil@brown.name"
	<neil@brown.name>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "david@kernel.org"
	<david@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "jack@suse.cz"
	<jack@suse.cz>, "code@tyhicks.com" <code@tyhicks.com>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "zohar@linux.ibm.com"
	<zohar@linux.ibm.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "irogers@google.com" <irogers@google.com>
CC: "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
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
        "audit@vger.kernel.org" <audit@vger.kernel.org>,
        "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>,
        "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
        "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-x25@vger.kernel.org"
	<linux-x25@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
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
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Thread-Topic: [EXTERNAL] [PATCH v2 032/110] hfsplus: use PRIino format for
 i_ino
Thread-Index: AQHcqobOGSQlvE2NLkaLDaZOgevjgLWb1N2A
Date: Mon, 2 Mar 2026 22:36:08 +0000
Message-ID: <25821493fe809c348a24231518c53d493c37674b.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-32-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-32-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4155:EE_
x-ms-office365-filtering-correlation-id: 8f8f1127-0bee-4b79-8224-08de78ac1967
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 liri0jEh5M5wGbC4pxkNU0y01oCzOU744CzLQ7rQbRTGMlcUVvz0gbe6DDbFEmvJSDKjkVuBYuavDjbNSFFAnrxKpX0C0Ywp9Lo9kRJwmppRfDSaMm52Q2SPMvu4Z10iuBcYIylR2WGo0J9mvQAVywFZQa3UGrrvmWxyGP3t1D17abZ1qBuIl3BnaePBIrd53jhaFeRxF3507uD0nT1a/xZQqq/U/1pj3kzd3lD3n6R+nSwKcRAWFd7rxQM0bu74DYK77kPimsl+lujD7VyQaaYjHRshpc6jQN9wYVS08AgyaC6hjlK5w+QeSEygM+FCGXHPKZLSe9wuY00WNxO4W9hK5ChMwFXQAntSmZZtwD/iA40CIg4oSUMrpFHAu+m/zrJ4mcuX8+2OIZhV4QnChtOubr7T0mUSEHpNLCWS0gRZzi3OzMJgi7Kbqo0qyqK5EIJqPyAHJzF0BydPAuYe58n+wTq6FJdaFoPCIZaDeYjoLSKVPKLCDUe/4z4paTV6sGHu/A3eWfceC0C/NH6Pwhd1ORKTclQKLVQlTCJrquzGjaqz6OWa6Yxg7SSadhU4GevDzHKJk8djN8GTbXiiyoxFccTDRM/g/830KCIkrl03kGvXGm5q8NZ6ZlQ6cdudkLyeUFEpPngcE+KElYuDWmlUMHIuVt8oEErjFoBH31YWsnwzNtxrQ7++CJTlPWIQcVf/DH+KCvEtHwa+4M45GXFQcE2RiebWHsoZkj+bdB1kbManXthWh5ruYWjKMNLFvtFGC7dW8as4R70A0CqjWJkgsRSCky/hVdVOXUPe8OZPKJ3GRSLyNjvgB1VmUWUD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nm4wc0QvUThrV0wyZW13and5THBtWjdQTmozYnVYS0RpS3duL1pMSkUxTlVj?=
 =?utf-8?B?U2tLTWhKdnBNbmNFUm43cnBYVGNDV0IzSjVEMEhmeFFSSmFxekxWZElidG53?=
 =?utf-8?B?SzN0K1Z1QUprdVhlWjZUVm9qUVQxTHZNbFZKVCt6NGxlK015cGw2bGZZKzlW?=
 =?utf-8?B?aDhEQnVqK0JKNXlTRk54S0hxdnkrUU9abW1WKzdrRGJzZ01tMURwalg2QUFu?=
 =?utf-8?B?NFUxQnZiaHFzb3Z0bGJxb1ZuWWs0dFFTeEc4MWU3Y2U5UUllbmxWRlhzNW9r?=
 =?utf-8?B?V3p6V05udkQzdWNCdThvajdmNDZLTk9LMkl3bmNuN2NDdUd4ZmpyYWdpQ3Zk?=
 =?utf-8?B?N1FJdW9KVmFhYnhjOTl3bmY5OWpCY2wrbno3U3RSN1pnaWNrWDZhWmFTM0lm?=
 =?utf-8?B?L1pOV3hQY296TlJtRnAwdENzMlhXV2dnd0VpRFArR3JJVnNqY0UvejNsdjBS?=
 =?utf-8?B?UUdyRTlwdGc1bWRzVkcySGlHTmcwOXhocnp4QUhoa0MrNXhtbWVJb3AvQTNI?=
 =?utf-8?B?VW9rMmF6YmVHS0xiT1RJYkVwS3pSSHlwblhRQ25Ga2wyRDdBQVFGeWlVejlY?=
 =?utf-8?B?bXQra0tuR3JHRVVUSVlhaXBrY292dU1iOEtpWjFDc0FJWUpDWVFiMFJDWTNl?=
 =?utf-8?B?Z0tLdEtMdGpsUWlsVXVqcWdyV1FBbllFQnhacE5jcDMxQ21LZEJHT3BTY1R3?=
 =?utf-8?B?Q3hGclljOU1KR1VMSG55K2RuWWtTbVBvM3VFajc1MERsQSt1OS9Da05BTE84?=
 =?utf-8?B?QUtVZG1mazB0M3VtajNDLzBEaGg0eTdCNWxyWnFqUE5ab3V1ME4yOWhkaDUv?=
 =?utf-8?B?RHZhNGJvNnFKMFVPeEJyVXQzUWE1TEJKOTNPcGROSiszMzhrUkgrVHNMR2dJ?=
 =?utf-8?B?RlEvY0ZvNklwcXhIRU1KN2VERTNWR25TOWE0YnliWjJyZlpsdDVSWTQ1MDFP?=
 =?utf-8?B?NEhXS3RrUytTUFNnL2UrUk5GcW5XalhWK0k4R3VCVHB0VzQ3aWVCK3QwdEcz?=
 =?utf-8?B?Z21mOHlKOUVBNlphMWx6aDZVVTI2SjhNQ1p4YVd3TWlYSmtwSnhOVG82MWVh?=
 =?utf-8?B?dUN6M24vM3JYcXpHY211Z1JlZW1JbTVCdFVTS0UvUmd5azk1K3VpRDk5MDVO?=
 =?utf-8?B?aDFLeHpWOVVhbzhoTjhzMXJibjMvRE1SbFMyK3NRYi9aQlBBOVdxZktGcjNI?=
 =?utf-8?B?TFV3TFl2eFlCM0taeGkvY3ZpK2U1d0doNVRaQi9kc0JPb3VORnNCQTU5WjdX?=
 =?utf-8?B?d2IwdDcwVDBmMWtKZTFibDZqeHFZVlRJUFUzYjJCTEdNM3lHaENia1ViSVlD?=
 =?utf-8?B?bFpHcVR0N0RSbVF6VktFKzJmTVNodTc0dFZOWEZvOHU5aElCZTQweS9WaXIx?=
 =?utf-8?B?elczTnNoM0ErcGxoenlMNFJ4eDhwd1FHalNDVEhzaWFBWWdaNXBBckJ6Wm9Y?=
 =?utf-8?B?Q0NNMVZISWZMZEttMk9jcHZNTlFOM3pITlVwb3JyRkc2VFJBdlU1RHV1OHh4?=
 =?utf-8?B?by9CUlFyWnR6aXpkdjloaVBnZTJubnRTWm0xSkx3QWdxaENuaEJZV1ZXZ0x0?=
 =?utf-8?B?bFMzTGdENW5QalEvbjdpQzBCcUdtVXk2VXNOOUw2RkYvYnBoVkFsNzN2a2hJ?=
 =?utf-8?B?SGxzZnZvSVFqZEc3UEc1dHQwcURWTngzTXg2b2UwNC95dUlPOW8zQkVSUmNt?=
 =?utf-8?B?VTU0OVR0a1AzMFR4emxiQlIxYWhjYXBVVjJzcjdubVYycisyL3VUK0k5M1ZV?=
 =?utf-8?B?aWpLU3h0OTRGY2o1R2hTTm5nL1NWUXpPbW1CeDVadFl0SUxjOXlLdjA1MVFr?=
 =?utf-8?B?Q1puU2JPSWdTNmdKaVNJbVNkdHNLalNzOFl4UlpyV1ZlNVRrZnZaaHVQWno3?=
 =?utf-8?B?MGxoNEJwaE43Q25xUzBSbGt3UlJvblQ5QlYrTWh2eHI3b2Z2ZFNaUFlmY0Nr?=
 =?utf-8?B?VXlzOUJzQmZkVHdGSXhsR1paR3U3clF4R3JKZHNyTFJTZUlKdUdKWXFUTGFr?=
 =?utf-8?B?MmRhUU5CTDVIM3dXKytLdnAwcmdPanMxU0NqaTBxSlVpTXZzYzV5ZG53RDlC?=
 =?utf-8?B?Rk9pWjlxK01nYkNRL1VwbjhiemlTd1hBS1pxVjAyWUxYMG1UR0VNVnVLdGJj?=
 =?utf-8?B?NDFoMlg4VnRUVVBta1hyZTBuUlFuMmU5a1cxMW9LMHp0OHhJb0FLSmg0SDBF?=
 =?utf-8?B?R2s1Uk9hMitsNFBGd3NDa0RNSXJNVW9YK0VMQVVkZ2V0bnkwVTNCMzJ6clpT?=
 =?utf-8?B?ZWczK0Rjd3ZnNjNtZ01pWTZJT0puZXI5Tit1eHhBNTZxd0xuNDY4b1J3WDMw?=
 =?utf-8?B?aDNsSmx6dGsvSnhLcDRFYXBuc2ZCODYxTVhsbE5FQUI1VUF4MTBYZEdrZGRy?=
 =?utf-8?Q?FzhdrfgINKINxzCFRTeDluNJpjZ8xzKCNvsgm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFDC9A9F2A3EC144BE37C0068935254C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8f1127-0bee-4b79-8224-08de78ac1967
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:36:08.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ib+ltyxk4clMYYMsAZHWOx0KaEFvLfCaDk0uPr1zSgejRLoUx7ioeW+AKU5Zf0gZuOyp67VU7RcHPTmFFhe3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4155
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a610de cx=c_pps
 a=NPM8+NhlmoQiEOpqaaNCjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=TooETclPppUkavAUpccA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: glA8nXs6PGjLL15TqRkEikFC0nNRiIpg
X-Proofpoint-GUID: XJ3Ky6SEB_key2GF0K69GNh4ocy7hiOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NCBTYWx0ZWRfX2JFXAaLhC392
 Kwc1+dR93YB2BZCH0RVJ4TONXFzEuVGwGWpGV0K8zHu7+nx5TJp+pv6LxLrCWE4ltO7lresz0//
 EcsTRTs/qp5k5GJun/EHoGrVmvNIrlhrn5GjY0ueMYYtUXhywm3X1A+FGjSfDJKXieq7gwztYRs
 icOso7WrxXJjEgaLj2IFKI6V/MOG4Ce8770SrA0eDcEp+8xU2GJ9RNYACA0NUdhEON11tHNWbyL
 8aKKwbiVW2oHjqlROYpmu63uwr4GrGRfeNo6AONDN7QUiCBKHOpMGgM/JbLgHn3Q8zziNbYk0Bc
 d6zMrBadzclxp2aQa4tx+dY+Uy90yb6nFjyauKl4VzsYrEP/iExjRhOPmxaydoWq3QkUoP6aL3P
 GGgVMeyT+/EaW3RoXNrwet+hsWwRrn6fe1EazPPwSGMLQ7954isKRxgyv2L8H1HAYXf7zErcktS
 sNSl6YpOOm7mFPktcDQ==
Subject: Re:  [PATCH v2 032/110] hfsplus: use PRIino format for i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020164
X-Rspamd-Queue-Id: 712591E64C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79084-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hartkopp.net,gondor.apana.org.au,kernel.org,yaina.de,oracle.com,redhat.com,davemloft.net,paragon-software.com,szeredi.hu,canonical.com,gmail.com,fluxnic.net,intel.com,talpey.com,linux.alibaba.com,paul-moore.com,codewreck.org,linux.intel.com,fasheh.com,crudebyte.com,amd.com,zeniv.linux.org.uk,infradead.org,microsoft.com,holtmann.org,linaro.org,ffwll.ch,arm.com,suse.com,google.com,iogearbox.net,goodmis.org,vivo.com,dev.tdt.de,evilplan.org,mit.edu,cs.cmu.edu,omnibond.com,namei.org,dilger.ca,physik.fu-berlin.de,schaufler-ca.com,themaw.net,linux.dev,efficios.com,fomichev.me,huawei.com,artax.karlin.mff.cuni.cz,suse.de,samba.org,hallyn.com,alarsen.net,manguebit.org,dubeyko.com,ionkov.net,nod.at,auristor.com,brown.name,pengutronix.de,suse.cz,tyhicks.com,secunet.com,wdc.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,str.name:url,dubeyko.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjI0IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Q29udmVydCBoZnNwbHVzIGlfaW5vIGZvcm1hdCBzdHJpbmdzIHRvIHVzZSB0aGUgUFJJaW5vIGZv
cm1hdA0KPiBtYWNybyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIHdpZGVuaW5nIG9mIGlfaW5vIHZp
YSBraW5vX3QuDQo+IA0KPiBBbHNvIGNvcnJlY3Qgc2lnbmVkIGZvcm1hdCBzcGVjaWZpZXJzIHRv
IHVuc2lnbmVkLCBzaW5jZSBpbm9kZQ0KPiBudW1iZXJzIGFyZSB1bnNpZ25lZCB2YWx1ZXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIGZzL2hmc3BsdXMvYXR0cmlidXRlcy5jIHwgMTAgKysrKystLS0tLQ0KPiAgZnMvaGZz
cGx1cy9jYXRhbG9nLmMgICAgfCAgMiArLQ0KPiAgZnMvaGZzcGx1cy9kaXIuYyAgICAgICAgfCAg
NiArKystLS0NCj4gIGZzL2hmc3BsdXMvZXh0ZW50cy5jICAgIHwgIDYgKysrLS0tDQo+ICBmcy9o
ZnNwbHVzL2lub2RlLmMgICAgICB8ICA4ICsrKystLS0tDQo+ICBmcy9oZnNwbHVzL3N1cGVyLmMg
ICAgICB8ICA2ICsrKy0tLQ0KPiAgZnMvaGZzcGx1cy94YXR0ci5jICAgICAgfCAxMCArKysrKy0t
LS0tDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvYXR0cmlidXRlcy5jIGIvZnMvaGZzcGx1
cy9hdHRyaWJ1dGVzLmMNCj4gaW5kZXggNGI3OWNkNjA2Mjc2ZTMxYzIwZmExOGVmM2EwOTk1OTZm
NTBlOGEwZi4uZDBiM2Y1ODE2NmEwNTdjMGE1YmYyZTQxY2Y2ZmM4Mzk3OThjMGRlZCAxMDA2NDQN
Cj4gLS0tIGEvZnMvaGZzcGx1cy9hdHRyaWJ1dGVzLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9hdHRy
aWJ1dGVzLmMNCj4gQEAgLTIwMyw3ICsyMDMsNyBAQCBpbnQgaGZzcGx1c19jcmVhdGVfYXR0cl9u
b2xvY2soc3RydWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hhciAqbmFtZSwNCj4gIAlpbnQgZW50
cnlfc2l6ZTsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IC0JaGZzX2RiZygibmFtZSAlcywgaW5vICVs
ZFxuIiwNCj4gKwloZnNfZGJnKCJuYW1lICVzLCBpbm8gJSIgUFJJaW5vICJ1XG4iLA0KPiAgCQlu
YW1lID8gbmFtZSA6IE5VTEwsIGlub2RlLT5pX2lubyk7DQo+ICANCj4gIAlpZiAobmFtZSkgew0K
PiBAQCAtMjU1LDcgKzI1NSw3IEBAIGludCBoZnNwbHVzX2NyZWF0ZV9hdHRyKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsDQo+ICAJaGZzcGx1c19hdHRyX2VudHJ5ICplbnRyeV9wdHI7DQo+ICAJaW50IGVy
cjsNCj4gIA0KPiAtCWhmc19kYmcoIm5hbWUgJXMsIGlubyAlbGRcbiIsDQo+ICsJaGZzX2RiZygi
bmFtZSAlcywgaW5vICUiIFBSSWlubyAidVxuIiwNCj4gIAkJbmFtZSA/IG5hbWUgOiBOVUxMLCBp
bm9kZS0+aV9pbm8pOw0KPiAgDQo+ICAJaWYgKCFIRlNQTFVTX1NCKHNiKS0+YXR0cl90cmVlKSB7
DQo+IEBAIC0zMzcsNyArMzM3LDcgQEAgaW50IGhmc3BsdXNfZGVsZXRlX2F0dHJfbm9sb2NrKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJc3RydWN0IHN1cGVyX2Js
b2NrICpzYiA9IGlub2RlLT5pX3NiOw0KPiAgCWludCBlcnI7DQo+ICANCj4gLQloZnNfZGJnKCJu
YW1lICVzLCBpbm8gJWxkXG4iLA0KPiArCWhmc19kYmcoIm5hbWUgJXMsIGlubyAlIiBQUklpbm8g
InVcbiIsDQo+ICAJCW5hbWUgPyBuYW1lIDogTlVMTCwgaW5vZGUtPmlfaW5vKTsNCj4gIA0KPiAg
CWlmIChuYW1lKSB7DQo+IEBAIC0zNjcsNyArMzY3LDcgQEAgaW50IGhmc3BsdXNfZGVsZXRlX2F0
dHIoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hhciAqbmFtZSkNCj4gIAlzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQo+ICAJc3RydWN0IGhmc19maW5kX2RhdGEgZmQ7
DQo+ICANCj4gLQloZnNfZGJnKCJuYW1lICVzLCBpbm8gJWxkXG4iLA0KPiArCWhmc19kYmcoIm5h
bWUgJXMsIGlubyAlIiBQUklpbm8gInVcbiIsDQo+ICAJCW5hbWUgPyBuYW1lIDogTlVMTCwgaW5v
ZGUtPmlfaW5vKTsNCj4gIA0KPiAgCWlmICghSEZTUExVU19TQihzYiktPmF0dHJfdHJlZSkgew0K
PiBAQCAtNDM2LDcgKzQzNiw3IEBAIGludCBoZnNwbHVzX3JlcGxhY2VfYXR0cihzdHJ1Y3QgaW5v
ZGUgKmlub2RlLA0KPiAgCWhmc3BsdXNfYXR0cl9lbnRyeSAqZW50cnlfcHRyOw0KPiAgCWludCBl
cnIgPSAwOw0KPiAgDQo+IC0JaGZzX2RiZygibmFtZSAlcywgaW5vICVsZFxuIiwNCj4gKwloZnNf
ZGJnKCJuYW1lICVzLCBpbm8gJSIgUFJJaW5vICJ1XG4iLA0KPiAgCQluYW1lID8gbmFtZSA6IE5V
TEwsIGlub2RlLT5pX2lubyk7DQo+ICANCj4gIAlpZiAoIUhGU1BMVVNfU0Ioc2IpLT5hdHRyX3Ry
ZWUpIHsNCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvY2F0YWxvZy5jIGIvZnMvaGZzcGx1cy9j
YXRhbG9nLmMNCj4gaW5kZXggMDJjMWVlZTRhNGI4NjA1OWNlYWFiN2E3YzY4YWI2NWFkYmE2ZmEy
Ni4uZDQyMmYxMTdjNjBkZWU2ZmQ4ZWNlMGQwMWQ0Y2U2NmUwNDQyMWU0YSAxMDA2NDQNCj4gLS0t
IGEvZnMvaGZzcGx1cy9jYXRhbG9nLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9jYXRhbG9nLmMNCj4g
QEAgLTQ0MSw3ICs0NDEsNyBAQCBpbnQgaGZzcGx1c19yZW5hbWVfY2F0KHUzMiBjbmlkLA0KPiAg
CWludCBlbnRyeV9zaXplLCB0eXBlOw0KPiAgCWludCBlcnI7DQo+ICANCj4gLQloZnNfZGJnKCJj
bmlkICV1IC0gaW5vICVsdSwgbmFtZSAlcyAtIGlubyAlbHUsIG5hbWUgJXNcbiIsDQo+ICsJaGZz
X2RiZygiY25pZCAldSAtIGlubyAlIiBQUklpbm8gInUsIG5hbWUgJXMgLSBpbm8gJSIgUFJJaW5v
ICJ1LCBuYW1lICVzXG4iLA0KPiAgCQljbmlkLCBzcmNfZGlyLT5pX2lubywgc3JjX25hbWUtPm5h
bWUsDQo+ICAJCWRzdF9kaXItPmlfaW5vLCBkc3RfbmFtZS0+bmFtZSk7DQo+ICAJZXJyID0gaGZz
X2ZpbmRfaW5pdChIRlNQTFVTX1NCKHNiKS0+Y2F0X3RyZWUsICZzcmNfZmQpOw0KPiBkaWZmIC0t
Z2l0IGEvZnMvaGZzcGx1cy9kaXIuYyBiL2ZzL2hmc3BsdXMvZGlyLmMNCj4gaW5kZXggZDU1OWJm
ODYyNWY4NTNkNTBmZDMxNmQxNTdjZjhhZmUyMjA2OTU2NS4uZTcwMWIxMTQzN2YwOTE3MmY4OGQ2
OGI0ZTRmNTk5ODU5MTU3MmIzOCAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9kaXIuYw0KPiAr
KysgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IEBAIC0zMTMsNyArMzEzLDcgQEAgc3RhdGljIGludCBo
ZnNwbHVzX2xpbmsoc3RydWN0IGRlbnRyeSAqc3JjX2RlbnRyeSwgc3RydWN0IGlub2RlICpkc3Rf
ZGlyLA0KPiAgCWlmICghU19JU1JFRyhpbm9kZS0+aV9tb2RlKSkNCj4gIAkJcmV0dXJuIC1FUEVS
TTsNCj4gIA0KPiAtCWhmc19kYmcoInNyY19kaXItPmlfaW5vICVsdSwgZHN0X2Rpci0+aV9pbm8g
JWx1LCBpbm9kZS0+aV9pbm8gJWx1XG4iLA0KPiArCWhmc19kYmcoInNyY19kaXItPmlfaW5vICUi
IFBSSWlubyAidSwgZHN0X2Rpci0+aV9pbm8gJSIgUFJJaW5vICJ1LCBpbm9kZS0+aV9pbm8gJSIg
UFJJaW5vICJ1XG4iLA0KPiAgCQlzcmNfZGlyLT5pX2lubywgZHN0X2Rpci0+aV9pbm8sIGlub2Rl
LT5pX2lubyk7DQo+ICANCj4gIAltdXRleF9sb2NrKCZzYmktPnZoX211dGV4KTsNCj4gQEAgLTM4
NSw3ICszODUsNyBAQCBzdGF0aWMgaW50IGhmc3BsdXNfdW5saW5rKHN0cnVjdCBpbm9kZSAqZGly
LCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ICAJaWYgKEhGU1BMVVNfSVNfUlNSQyhpbm9kZSkp
DQo+ICAJCXJldHVybiAtRVBFUk07DQo+ICANCj4gLQloZnNfZGJnKCJkaXItPmlfaW5vICVsdSwg
aW5vZGUtPmlfaW5vICVsdVxuIiwNCj4gKwloZnNfZGJnKCJkaXItPmlfaW5vICUiIFBSSWlubyAi
dSwgaW5vZGUtPmlfaW5vICUiIFBSSWlubyAidVxuIiwNCj4gIAkJZGlyLT5pX2lubywgaW5vZGUt
PmlfaW5vKTsNCj4gIA0KPiAgCW11dGV4X2xvY2soJnNiaS0+dmhfbXV0ZXgpOw0KPiBAQCAtMzkz
LDcgKzM5Myw3IEBAIHN0YXRpYyBpbnQgaGZzcGx1c191bmxpbmsoc3RydWN0IGlub2RlICpkaXIs
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gIAlpZiAoaW5vZGUtPmlfaW5vID09IGNuaWQgJiYN
Cj4gIAkgICAgYXRvbWljX3JlYWQoJkhGU1BMVVNfSShpbm9kZSktPm9wZW5jbnQpKSB7DQo+ICAJ
CXN0ci5uYW1lID0gbmFtZTsNCj4gLQkJc3RyLmxlbiA9IHNwcmludGYobmFtZSwgInRlbXAlbHUi
LCBpbm9kZS0+aV9pbm8pOw0KPiArCQlzdHIubGVuID0gc3ByaW50ZihuYW1lLCAidGVtcCUiIFBS
SWlubyAidSIsIGlub2RlLT5pX2lubyk7DQo+ICAJCXJlcyA9IGhmc3BsdXNfcmVuYW1lX2NhdChp
bm9kZS0+aV9pbm8sDQo+ICAJCQkJCSBkaXIsICZkZW50cnktPmRfbmFtZSwNCj4gIAkJCQkJIHNi
aS0+aGlkZGVuX2RpciwgJnN0cik7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2V4dGVudHMu
YyBiL2ZzL2hmc3BsdXMvZXh0ZW50cy5jDQo+IGluZGV4IDhlODg2NTE0ZDI3ZjFlNWQ0ZDk0YmU3
NTE0MmYxOTc2NjllNjIyMzQuLjFkYmZkZjQ0Zjk1NGYyNzY4ODUyNjc4ZDFlMzg2YTkxNzU4ODQ4
ZjkgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3BsdXMvZXh0ZW50cy5jDQo+ICsrKyBiL2ZzL2hmc3Bs
dXMvZXh0ZW50cy5jDQo+IEBAIC0yNzUsNyArMjc1LDcgQEAgaW50IGhmc3BsdXNfZ2V0X2Jsb2Nr
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNlY3Rvcl90IGlibG9jaywNCj4gIAltdXRleF91bmxvY2so
JmhpcC0+ZXh0ZW50c19sb2NrKTsNCj4gIA0KPiAgZG9uZToNCj4gLQloZnNfZGJnKCJpbm8gJWx1
LCBpYmxvY2sgJWxsdSAtIGRibG9jayAldVxuIiwNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJaW5v
ICJ1LCBpYmxvY2sgJWxsdSAtIGRibG9jayAldVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5vLCAobG9u
ZyBsb25nKWlibG9jaywgZGJsb2NrKTsNCj4gIA0KPiAgCW1hc2sgPSAoMSA8PCBzYmktPmZzX3No
aWZ0KSAtIDE7DQo+IEBAIC00NzYsNyArNDc2LDcgQEAgaW50IGhmc3BsdXNfZmlsZV9leHRlbmQo
c3RydWN0IGlub2RlICppbm9kZSwgYm9vbCB6ZXJvb3V0KQ0KPiAgCQkJZ290byBvdXQ7DQo+ICAJ
fQ0KPiAgDQo+IC0JaGZzX2RiZygiaW5vICVsdSwgc3RhcnQgJXUsIGxlbiAldVxuIiwgaW5vZGUt
PmlfaW5vLCBzdGFydCwgbGVuKTsNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJaW5vICJ1LCBzdGFy
dCAldSwgbGVuICV1XG4iLCBpbm9kZS0+aV9pbm8sIHN0YXJ0LCBsZW4pOw0KPiAgDQo+ICAJaWYg
KGhpcC0+YWxsb2NfYmxvY2tzIDw9IGhpcC0+Zmlyc3RfYmxvY2tzKSB7DQo+ICAJCWlmICghaGlw
LT5maXJzdF9ibG9ja3MpIHsNCj4gQEAgLTU0NSw3ICs1NDUsNyBAQCB2b2lkIGhmc3BsdXNfZmls
ZV90cnVuY2F0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAgCXUzMiBhbGxvY19jbnQsIGJsa19j
bnQsIHN0YXJ0Ow0KPiAgCWludCByZXM7DQo+ICANCj4gLQloZnNfZGJnKCJpbm8gJWx1LCBwaHlz
X3NpemUgJWxsdSAtPiBpX3NpemUgJWxsdVxuIiwNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJaW5v
ICJ1LCBwaHlzX3NpemUgJWxsdSAtPiBpX3NpemUgJWxsdVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5v
LCAobG9uZyBsb25nKWhpcC0+cGh5c19zaXplLCBpbm9kZS0+aV9zaXplKTsNCj4gIA0KPiAgCWlm
IChpbm9kZS0+aV9zaXplID4gaGlwLT5waHlzX3NpemUpIHsNCj4gZGlmZiAtLWdpdCBhL2ZzL2hm
c3BsdXMvaW5vZGUuYyBiL2ZzL2hmc3BsdXMvaW5vZGUuYw0KPiBpbmRleCA5MjJmZjQxZGYwNDJh
ODNkNDczNjRmMmQ5NDFjNDVkYWJkYTI5YWZiLi5mNjEzOTdkYjk3NmU4YjE1ZmExODZjM2IzMWFm
NzFlNTVmOWUyNmE2IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2lub2RlLmMNCj4gKysrIGIv
ZnMvaGZzcGx1cy9pbm9kZS5jDQo+IEBAIC0yMzAsNyArMjMwLDcgQEAgc3RhdGljIGludCBoZnNw
bHVzX2dldF9wZXJtcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgCQlpbm9kZS0+aV9mbGFncyAm
PSB+U19BUFBFTkQ7DQo+ICAJcmV0dXJuIDA7DQo+ICBiYWRfdHlwZToNCj4gLQlwcl9lcnIoImlu
dmFsaWQgZmlsZSB0eXBlIDAlMDRvIGZvciBpbm9kZSAlbHVcbiIsIG1vZGUsIGlub2RlLT5pX2lu
byk7DQo+ICsJcHJfZXJyKCJpbnZhbGlkIGZpbGUgdHlwZSAwJTA0byBmb3IgaW5vZGUgJSIgUFJJ
aW5vICJ1XG4iLCBtb2RlLCBpbm9kZS0+aV9pbm8pOw0KPiAgCXJldHVybiAtRUlPOw0KPiAgfQ0K
PiAgDQo+IEBAIC0zMjgsNyArMzI4LDcgQEAgaW50IGhmc3BsdXNfZmlsZV9mc3luYyhzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5kLA0KPiAgCXN0cnVjdCBoZnNwbHVz
X3ZoICp2aGRyID0gc2JpLT5zX3ZoZHI7DQo+ICAJaW50IGVycm9yID0gMCwgZXJyb3IyOw0KPiAg
DQo+IC0JaGZzX2RiZygiaW5vZGUtPmlfaW5vICVsdSwgc3RhcnQgJWxsdSwgZW5kICVsbHVcbiIs
DQo+ICsJaGZzX2RiZygiaW5vZGUtPmlfaW5vICUiIFBSSWlubyAidSwgc3RhcnQgJWxsdSwgZW5k
ICVsbHVcbiIsDQo+ICAJCWlub2RlLT5pX2lubywgc3RhcnQsIGVuZCk7DQo+ICANCj4gIAllcnJv
ciA9IGZpbGVfd3JpdGVfYW5kX3dhaXRfcmFuZ2UoZmlsZSwgc3RhcnQsIGVuZCk7DQo+IEBAIC02
MzksNyArNjM5LDcgQEAgaW50IGhmc3BsdXNfY2F0X3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpDQo+ICAJaGZzcGx1c19jYXRfZW50cnkgZW50cnk7DQo+ICAJaW50IHJlcyA9IDA7DQo+
ICANCj4gLQloZnNfZGJnKCJpbm9kZS0+aV9pbm8gJWx1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiAr
CWhmc19kYmcoImlub2RlLT5pX2lubyAlIiBQUklpbm8gInVcbiIsIGlub2RlLT5pX2lubyk7DQo+
ICANCj4gIAlpZiAoSEZTUExVU19JU19SU1JDKGlub2RlKSkNCj4gIAkJbWFpbl9pbm9kZSA9IEhG
U1BMVVNfSShpbm9kZSktPnJzcmNfaW5vZGU7DQo+IEBAIC03MTYsNyArNzE2LDcgQEAgaW50IGhm
c3BsdXNfY2F0X3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAJaWYgKCFyZXMp
IHsNCj4gIAkJcmVzID0gaGZzX2J0cmVlX3dyaXRlKHRyZWUpOw0KPiAgCQlpZiAocmVzKSB7DQo+
IC0JCQlwcl9lcnIoImItdHJlZSB3cml0ZSBlcnI6ICVkLCBpbm8gJWx1XG4iLA0KPiArCQkJcHJf
ZXJyKCJiLXRyZWUgd3JpdGUgZXJyOiAlZCwgaW5vICUiIFBSSWlubyAidVxuIiwNCj4gIAkJCSAg
ICAgICByZXMsIGlub2RlLT5pX2lubyk7DQo+ICAJCX0NCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9m
cy9oZnNwbHVzL3N1cGVyLmMgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gaW5kZXggNzIyOWE4YWU4
OWY5NDY5MTA5YjFjM2EzMTdlZTliNzcwNWE4M2Y4Yi4uYjc2ODY1ZTJlYWM1MjYwYjY4MWZjNDZi
Mjk3ZjE2NjVmMWJjMTBkYSAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsr
KyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAtMTU2LDcgKzE1Niw3IEBAIHN0YXRpYyBpbnQg
aGZzcGx1c19zeXN0ZW1fd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkNCj4gIAkJaW50
IGVyciA9IGhmc19idHJlZV93cml0ZSh0cmVlKTsNCj4gIA0KPiAgCQlpZiAoZXJyKSB7DQo+IC0J
CQlwcl9lcnIoImItdHJlZSB3cml0ZSBlcnI6ICVkLCBpbm8gJWx1XG4iLA0KPiArCQkJcHJfZXJy
KCJiLXRyZWUgd3JpdGUgZXJyOiAlZCwgaW5vICUiIFBSSWlubyAidVxuIiwNCj4gIAkJCSAgICAg
ICBlcnIsIGlub2RlLT5pX2lubyk7DQo+ICAJCQlyZXR1cm4gZXJyOw0KPiAgCQl9DQo+IEBAIC0x
NjksNyArMTY5LDcgQEAgc3RhdGljIGludCBoZnNwbHVzX3dyaXRlX2lub2RlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsDQo+ICB7DQo+ICAJaW50IGVycjsNCj4gIA0KPiAtCWhmc19kYmcoImlubyAlbHVc
biIsIGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vICUiIFBSSWlubyAidVxuIiwgaW5v
ZGUtPmlfaW5vKTsNCj4gIA0KPiAgCWVyciA9IGhmc3BsdXNfZXh0X3dyaXRlX2V4dGVudChpbm9k
ZSk7DQo+ICAJaWYgKGVycikNCj4gQEAgLTE4NCw3ICsxODQsNyBAQCBzdGF0aWMgaW50IGhmc3Bs
dXNfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwNCj4gIA0KPiAgc3RhdGljIHZvaWQg
aGZzcGx1c19ldmljdF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAgew0KPiAtCWhmc19k
YmcoImlubyAlbHVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICsJaGZzX2RiZygiaW5vICUiIFBSSWlu
byAidVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gIAl0cnVuY2F0ZV9pbm9kZV9wYWdlc19maW5hbCgm
aW5vZGUtPmlfZGF0YSk7DQo+ICAJY2xlYXJfaW5vZGUoaW5vZGUpOw0KPiAgCWlmIChIRlNQTFVT
X0lTX1JTUkMoaW5vZGUpKSB7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL3hhdHRyLmMgYi9m
cy9oZnNwbHVzL3hhdHRyLmMNCj4gaW5kZXggOTkwNDk0NGNiZDU0ZTNkMzI2NTkxZmE2NWE1ZWQ2
NzhmMzhjYTU4My4uZWY5MTIxODQzNDgyZTgxOTYxZmE1NDFjNTNjOTA2YWIwNGQ2ZmMzMyAxMDA2
NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy94YXR0ci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMveGF0dHIu
Yw0KPiBAQCAtMjc3LDcgKzI3Nyw3IEBAIGludCBfX2hmc3BsdXNfc2V0eGF0dHIoc3RydWN0IGlu
b2RlICppbm9kZSwgY29uc3QgY2hhciAqbmFtZSwNCj4gIAl1MTYgZm9sZGVyX2ZpbmRlcmluZm9f
bGVuID0gc2l6ZW9mKERJbmZvKSArIHNpemVvZihEWEluZm8pOw0KPiAgCXUxNiBmaWxlX2ZpbmRl
cmluZm9fbGVuID0gc2l6ZW9mKEZJbmZvKSArIHNpemVvZihGWEluZm8pOw0KPiAgDQo+IC0JaGZz
X2RiZygiaW5vICVsdSwgbmFtZSAlcywgdmFsdWUgJXAsIHNpemUgJXp1XG4iLA0KPiArCWhmc19k
YmcoImlubyAlIiBQUklpbm8gInUsIG5hbWUgJXMsIHZhbHVlICVwLCBzaXplICV6dVxuIiwNCj4g
IAkJaW5vZGUtPmlfaW5vLCBuYW1lID8gbmFtZSA6IE5VTEwsDQo+ICAJCXZhbHVlLCBzaXplKTsN
Cj4gIA0KPiBAQCAtNDQ3LDcgKzQ0Nyw3IEBAIGludCBoZnNwbHVzX3NldHhhdHRyKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJCU5MU19NQVhfQ0hBUlNFVF9TSVpF
ICogSEZTUExVU19BVFRSX01BWF9TVFJMRU4gKyAxOw0KPiAgCWludCByZXM7DQo+ICANCj4gLQlo
ZnNfZGJnKCJpbm8gJWx1LCBuYW1lICVzLCBwcmVmaXggJXMsIHByZWZpeGxlbiAlenUsICINCj4g
KwloZnNfZGJnKCJpbm8gJSIgUFJJaW5vICJ1LCBuYW1lICVzLCBwcmVmaXggJXMsIHByZWZpeGxl
biAlenUsICINCj4gIAkJInZhbHVlICVwLCBzaXplICV6dVxuIiwNCj4gIAkJaW5vZGUtPmlfaW5v
LCBuYW1lID8gbmFtZSA6IE5VTEwsDQo+ICAJCXByZWZpeCA/IHByZWZpeCA6IE5VTEwsIHByZWZp
eGxlbiwNCj4gQEAgLTYwNyw3ICs2MDcsNyBAQCBzc2l6ZV90IGhmc3BsdXNfZ2V0eGF0dHIoc3Ry
dWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hhciAqbmFtZSwNCj4gIAlpbnQgcmVzOw0KPiAgCWNo
YXIgKnhhdHRyX25hbWU7DQo+ICANCj4gLQloZnNfZGJnKCJpbm8gJWx1LCBuYW1lICVzLCBwcmVm
aXggJXNcbiIsDQo+ICsJaGZzX2RiZygiaW5vICUiIFBSSWlubyAidSwgbmFtZSAlcywgcHJlZml4
ICVzXG4iLA0KPiAgCQlpbm9kZS0+aV9pbm8sIG5hbWUgPyBuYW1lIDogTlVMTCwNCj4gIAkJcHJl
Zml4ID8gcHJlZml4IDogTlVMTCk7DQo+ICANCj4gQEAgLTcxNyw3ICs3MTcsNyBAQCBzc2l6ZV90
IGhmc3BsdXNfbGlzdHhhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY2hhciAqYnVmZmVyLCBz
aXplX3Qgc2l6ZSkNCj4gIAlzaXplX3Qgc3RyYnVmX3NpemU7DQo+ICAJaW50IHhhdHRyX25hbWVf
bGVuOw0KPiAgDQo+IC0JaGZzX2RiZygiaW5vICVsdVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gKwlo
ZnNfZGJnKCJpbm8gJSIgUFJJaW5vICJ1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiAgDQo+ICAJaWYg
KCFpc194YXR0cl9vcGVyYXRpb25fc3VwcG9ydGVkKGlub2RlKSkNCj4gIAkJcmV0dXJuIC1FT1BO
T1RTVVBQOw0KPiBAQCAtODE5LDcgKzgxOSw3IEBAIHN0YXRpYyBpbnQgaGZzcGx1c19yZW1vdmV4
YXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpuYW1lKQ0KPiAgCWludCBpc194
YXR0cl9hY2xfZGVsZXRlZDsNCj4gIAlpbnQgaXNfYWxsX3hhdHRyc19kZWxldGVkOw0KPiAgDQo+
IC0JaGZzX2RiZygiaW5vICVsdSwgbmFtZSAlc1xuIiwNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJ
aW5vICJ1LCBuYW1lICVzXG4iLA0KPiAgCQlpbm9kZS0+aV9pbm8sIG5hbWUgPyBuYW1lIDogTlVM
TCk7DQo+ICANCj4gIAlpZiAoIUhGU1BMVVNfU0IoaW5vZGUtPmlfc2IpLT5hdHRyX3RyZWUpDQoN
ClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KDQpU
aGFua3MsDQpTbGF2YS4NCg==

