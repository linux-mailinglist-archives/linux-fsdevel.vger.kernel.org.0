Return-Path: <linux-fsdevel+bounces-79086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMCgIAoSpmnlJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:41:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1851E5D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01B13060B11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABEE34750C;
	Mon,  2 Mar 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sB+Sp+5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A239098C;
	Mon,  2 Mar 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491211; cv=fail; b=jJqcor+/wpqP/xABD1khEFK7Manl6JfV3/lZfzt78pwOv3E9ycw5E82pi4Gdhl6jH0mcZt8dDoEFrQSe2GPOpbT5jjsEgzdZO0FtcLuuaHE+Vt1HbbGh91wEpYSXYgsyWwZ+e+FSdBwJhzZ9PPzRgaaHd9BdGBz+vXd2euJYDvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491211; c=relaxed/simple;
	bh=N/G62JhCN08BwvKuGUwa9MSbzChBGBirQKzbud1KX4c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=J4KOfomlxar9ikrvfDv1EhDb0x2oaMZOgNQlz1XWurKoyl8gJDrQb//x8WRwhU2asPSjDyVN8b/5C7ttCF5ZvJTXlfep7ws0qsFZ7uWNaRiU8lwFr33iy+Bh61MdCVqB4qydhuAEhPgRvt6LaZf3CRKemZRpnf9RrT6Km8+RRLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sB+Sp+5f; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EDwbq2397074;
	Mon, 2 Mar 2026 22:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=N/G62JhCN08BwvKuGUwa9MSbzChBGBirQKzbud1KX4c=; b=sB+Sp+5f
	s7Xbe7mVzRyEilJDP0bo7TxSph3x3VGdMKO9tZZxbXuzRzW093uZFwk3hiwRt0tz
	B/eeQBQFEGnuysqAAC43laapO+lDC6YGOt/FO+iCKeMM3/jzgzHft/h5Y2QA5Mne
	SsDsrWSa56km65fifUUS2qza+CmMArVcYiUX+HB0KyLhIBiAbv1t4oeaL2qm2+Bs
	Akz91YLCxFMYEi0IEUe6mLhcFwqpBDf+13vmGM0je4pNIW9To/hS2DUeuIgS23+F
	i53CbCnKvbM2PEWkedd+whmiPfaUwD2L1XeYXWHLMs2EDl8afqgZBAKitMOwwozr
	kFGyl4s1NjP7OA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj0qet-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:39:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnEE2FIJAa+WesSBRLXiHBEv+iTHEwttugbP5esTQ9PoK2aFjJ5ri+xUPrs4EfgViZRUqjwlDOJjaNwIK0HW8q6ZdUx3Wsfkf1iDNn/Xn24XAZBNYftLIUCTfUUFazeFrbsIzdMzaDYrWdZ5X93WiEbyNX602/xLz1nLCpyygxgPrd5y6Ks6UjeKz0axg+bqfbURiUFyAVtsmlfWylGmD4bfv1ohw+Ht3iyitPUpm+HCsCYR3DvObkO+JSjV0nWQB03l74KHFP8GcOXhhXio23IuXqNOzfEJ9vmprLadkyWpr4ZYUkL5/WfFwvtjthf+cxb/AI+Azn77rnQKF6FUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/G62JhCN08BwvKuGUwa9MSbzChBGBirQKzbud1KX4c=;
 b=l6n8oPPdQpgLbvuzCoZd5gLghS0mIEbmQjO/30reKFUPRcwjmaUe5IWmfbjyXNsH3PK45sQ/948+DofT+yWTgPa740LV+2z1tCxkxybBt9ur98xDMPQvQ2Z4DmdaT60GxzAl3NJ2ND4FUDEWkcr75sFynifJF/nPKbiRunwJGOZRd46lfU4HCUde7lwPGpE8ZHjrHTHu0ShOyLX7KTLiGd4B0JYDg48ZZJ6mydsEfIh1nphu7gF/LWhzQB+VrE9jVfX8Cz/KjWSv6tQ6TRuOJmB4ctqDI6Ih5TbdNiexrn2OVHnmoP/tMGypRUeeNeEF2JCy9ZqJZ6tWj7ZR5mHRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPFE061D9768.namprd15.prod.outlook.com (2603:10b6:518:1::4cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:39:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:39:24 +0000
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
Thread-Topic: [EXTERNAL] [PATCH v2 076/110] ceph: replace PRIino with
 %llu/%llx format strings
Thread-Index: AQHcqowWsQ3iP9CtvEGa6huypOhw+LWb1b2A
Date: Mon, 2 Mar 2026 22:39:24 +0000
Message-ID: <f9a2b53b518a4154847b2ac1eeb3f9807a8c6a19.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-76-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-76-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPFE061D9768:EE_
x-ms-office365-filtering-correlation-id: 42e1ad80-9c05-4c2a-0da8-08de78ac8dee
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 bN7dZpSfZ8UkUdOHlLFv9lIGIona2w3coeS+Cn/mrdzyyXt94HgZcVI1xL1vbXpL86t4WlOewX7/7+l8OTjV1TaeViEMfHUtxXHQIveObleWZGXX/X2jAJKNfAbBhIQkm58cS31uRkGZwl5XHPip9jFC2Nxawvqe1l7WEx5011wFc24bZoH4NFEF/eODFjNqZmvTPDVDI7j/RtBmVgHzCPV//KDc+i/tt8Dw/EluKzW0muzPPWibDDCN6TM8bpmoaSjzqJ9jqeyAF5h+j/uC2vmit/DucARdg/uYldFCHwGUT/QHsDTrojpPD452TgaWJBSHY6n3G/lijBDTisnYHIlv6oteQFtmJFK6NqHjE+4BUMDLoF4JvUs/iLNv1P2WNJ9HcvqlmqF4Ns/kWn4Yr1eBxg8U/xn3nUwi61AGyANHTp+D4QPT5YtrQUAAcV9zyjOVHahT0ZQEmASA9lI13nQ/AtVgJ/6LV6NA329o2G7xjVrb1cSdr6c0vHQzmselB/mvtVFmP0ILwl6sSUcV4MpxC2P7njIgL9F53dWUxECfbreSHQvTFuc8RY0ufHLbC/H3J24i+7OBH+ipqQFskp0Elc5B1ZLqNh3ZjQ6sGKeuypunkCYF8IoM4siOIVlFKwtXcjZafNYJVstE8zY/6A2PR+42hGCAi+WtspX+VQy2jwLF/eUsHh22qlX9dAXNXgxEk0x4tVUFDycOnmtZa9COO0amoM2h7klzrakDI7TBb/BzohZSlC59nRbaNKe3NBEmrWuLiRMvGWl0+bHgCUxyQBQksbQyBZfNNlTAEVUGFF5wRlZm6IducRrLXbaV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUZQZmJTRTdqUnVUTjV3QU1KMEFmdCtyNXRKZjFWQUc4ZE9rTFNiQWRTWjg2?=
 =?utf-8?B?cUwrM01SVEhSMzh4cExhTnZSY3FGN3QzTWVIeGlaN2dNVVlYVHZpVTJyeDFh?=
 =?utf-8?B?OWtpbkdzdzhoL3RrTkNSbmIzTEgvYVVjUkJMZFJhQm5kMHVJUWZNNVB2U0Ny?=
 =?utf-8?B?NW1pRlJFMG1EeG5ScGFIMGUrRFNpUnJzWFFDdU53ck5ZOG5UUERhUm01eEsw?=
 =?utf-8?B?cDhOelYxS0xpNmlCZ2tKUXppQVBKMk9yZCsrRVU5eUx1aTRqSGNmK0tvanlR?=
 =?utf-8?B?SXZlblU0bkpPaThMQk9ZK29seDVWWnpJWm5MS3FlWDh2UlRDc29Gb2dwMU9v?=
 =?utf-8?B?cWVMNkdCNzhjdWxLeXhQejBSV0FsYVBXWDhwMlR5WjdjM2cvZjBydm5iVzZi?=
 =?utf-8?B?K0JOTHYvTHB0ejBJYThReldLWTYrODFqMkNlSTgxaVUzcCtPNzYxSUl0Y1Yy?=
 =?utf-8?B?QnRuS0M4ZkFwRzdvQjN5dm9oMzdKZWJZTW5kVnZzZkZ2QVA5UGc1MjZlTDd1?=
 =?utf-8?B?Z0xyNCtUdlJZVnlBNktpV3d3TTExZHdKeTlETnlEaVd5ZXNHRFlmWU91d0ln?=
 =?utf-8?B?Wnh4R1JITEllRjUya2U0Y2hhVVFNU003cFlOc3l5MEkvQXp1Y0pwdXB6QVQx?=
 =?utf-8?B?K21WcEFpcHFnSHNubnRDNHY2MGtGQlQ1RTNWMk94NXhIU2FjUlJHUHgwN1hF?=
 =?utf-8?B?ZHhucC9OcG5sRGI2QnV6aDVPZEd1UGw5bUwwN1dZS0hlaXVmU25UVXEwSHNU?=
 =?utf-8?B?NzIyaUdsaFdkZXZLbFNEZTZwSjIzbEpIN1FrbUlhSVlIVmV5ZUp4U21uZ0pp?=
 =?utf-8?B?b2diZEpxWW15eWJ2RE8wb1hReEhvbVZZNDFqRERzZjA2bDJWQnFjNHM2Z2tp?=
 =?utf-8?B?RWxzc3Y4dnNlaXF0dEhaR0Y1cER5djJJUnIvMnNQVmMrWVZqMzg5TXdxSDNw?=
 =?utf-8?B?elNEZCtUUHZqMVBmMk96YmZlckV4UjUxd2hPZ292dnhKTXlwSjg4dUErMXBv?=
 =?utf-8?B?OEpIWVBxdlZRZnNWdTdGMzlJdUFzWnJzS29WU3FjTkRMeFJFY1pMM2MvcFRQ?=
 =?utf-8?B?bVQ0MHdwTEFOS2EyNzZScVg4Q3plb1FZNlhCbHhYVTN6cXNKSkVQaDh5Q2VT?=
 =?utf-8?B?VitJY292ekRmK0s4QWRlcjJpazJ5dVBOUUIvTGkrSnE0WEYxM21DWloydmJ0?=
 =?utf-8?B?di9EWUJPN2NHcHArS1JURTk2eW5ubGpQbm5JbmYrbkF4VWhNbDRDb2N2YlV5?=
 =?utf-8?B?N1lsVkFYVXpGbHdoZWJ3cjlSWGFFcHBGbTBPYzE2N1JmcnlYVHd2d2lmUFlu?=
 =?utf-8?B?S202ZkdtT2tzM2RWcEo3N3R2Nld2aXRlM0tpR1N5RGxnNG8yTG5IeGhpcncv?=
 =?utf-8?B?Mys4QStKNWtrZXhUNE8xaDNUTmNSNmd1ZC9qRDlLK0Z4Nk1Xd3loZGlMdVkz?=
 =?utf-8?B?QnNIQit5YWljbUVnYTVyc1NqSHMrMjhwKzN3M1FqRlJ6MXVqbE9XZjhIdm4y?=
 =?utf-8?B?ZHc0TXVjVGpGMC83SEpDM2lXYzQxM1U4ZytBSmhvc2s2TCtOL0ZwYWVjRitM?=
 =?utf-8?B?NkttVlRLWlE2NFB2NW1nVDh0YmJITE1HWXFlNzdqNDRzOWwwUmtGcmdDMkI4?=
 =?utf-8?B?aTlPS1pjYldzSlYzTDlrOUVBZlNGMnFZWlZWOU5tMUdxZXBnazZMODl2SDlS?=
 =?utf-8?B?cWtYbWU5a01wTUhNdUNrVHJIb3g4eGh6K3YxSXhYa0o3b3VrVTZycXFLM1Ji?=
 =?utf-8?B?SE9WbzVLWWhibURVSWFSVktTK21vTzBWdlc5YVYweU53MGMzR0pUazVIVlJ4?=
 =?utf-8?B?Mi9mK0RJK0d2cTE1VVlXbUdaQUNXeVcwSTFRK3BUSmU3NEVhbkZ2RS9WVzZI?=
 =?utf-8?B?a09PNDRPeUJOck1ray9GU1RTZFVaa1c1TWgvYkVnalp2V3Bpai9vcU9DblJJ?=
 =?utf-8?B?THpCcDVHT0dPUWNJc3ZlWDRhVExmYUdkRU9ZUjlHQVhueFRnMloxMXM0Wlda?=
 =?utf-8?B?Y2FocE52VWFBVDgvT2pSZU9WTGdmVjh0M212UU1KOTlFZERZamVGNUNhMGVE?=
 =?utf-8?B?TFdsSnRjYTFVTmFxemJ4UEtyWVFrdzMrU0hpbUxmZmlnSUNvTmNVa0dJUkZM?=
 =?utf-8?B?dk9MT29GVzczS0dvdUhGZGVYaVgvRDR6cTlnYzJqcS9OYUlkc0h6d1F3WjVk?=
 =?utf-8?B?cDBpRFpUeWJNL0hPclB3Q01hQ2JwOVEyTlVPM3RZVFZyOVhiR1RUelNnSlMz?=
 =?utf-8?B?TjFlQS9HNlcrRzVRWFZrNXZCVFV0Y3NHYjNORklzK1h4M2haSE94bjBPV3NE?=
 =?utf-8?B?L2RVajdCTzlhKzY5a2c1ZTJ5aGlTYUlpU0RDN2p1WmpqTXZlUGgrK3hEUXE1?=
 =?utf-8?Q?h0IcOa5IVP6bLMrbWf/KOarnhInsuYr7xQRbC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A08375D7B8845F4FA238852084288CE0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e1ad80-9c05-4c2a-0da8-08de78ac8dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:39:24.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQYXPAwIwPvfgGWWALb/opqzhxwXIiIgreK3jCqjbAQKP2Dq09i6vYpuGJVZj6lY0+CGYMJGO6Bhd+74WS2xNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE061D9768
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a611a3 cx=c_pps
 a=F30aWN9Bm7kNfdI93JtEUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=zr94bLkQGwJZMLBWZqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NyBTYWx0ZWRfX1rR6Tnq4Qqpg
 kqs7+xhiCFjGcgNTQedSA0r/iuOVPPKRF/3KXxv19QP75PHy4R9UjnV5yBMzgOl5NmJk4IhGExg
 kNvfdZzof0Fa0XCNcYnUhyKTPdSAGsGxKJEWsg3Njl4p40zK5O4sNWEPJJkB45ucrQoUQOarlrj
 YvADnglgyCQrq9OPGX6BR01hX1Z+sMxp6CyFhMGoPZ79fq56HGDVKgMTQfCLlKLdMiq+uvt8tPc
 sFtQewHiFMG3u8orj3+yaFD9IPXOs+iyyfSVLJj/b9nGG3kdS2eVZXD6gGhlr/fpy+7+sVlOn76
 IYChymsxi7odsZG7eKlinZiwrY8+tWRr/Rn7F+5O4kQa4jWyg1Z6lBCCy5UXYiGyVAfrYxWhPcx
 90b53j9qXavj8ytYR2BdnnwTFpzxrz75CI8g8sGWHuudjzzixPc4qWFyAzFotireNnzxi6UzQiE
 2SYh/QcCBz2+vqfLFpg==
X-Proofpoint-GUID: wAHWO7AIhd_eiEtwNQVjoHH536mRyHyx
X-Proofpoint-ORIG-GUID: jVK4Lp_MX4Bgm_h0yJKMdIbd2BR59aRH
Subject: Re:  [PATCH v2 076/110] ceph: replace PRIino with %llu/%llx format
 strings
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020167
X-Rspamd-Queue-Id: 3A1851E5D34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79086-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hartkopp.net,gondor.apana.org.au,kernel.org,yaina.de,oracle.com,redhat.com,davemloft.net,paragon-software.com,szeredi.hu,canonical.com,gmail.com,fluxnic.net,intel.com,talpey.com,linux.alibaba.com,paul-moore.com,codewreck.org,linux.intel.com,fasheh.com,crudebyte.com,amd.com,zeniv.linux.org.uk,infradead.org,microsoft.com,holtmann.org,linaro.org,ffwll.ch,arm.com,suse.com,google.com,iogearbox.net,goodmis.org,vivo.com,dev.tdt.de,evilplan.org,mit.edu,cs.cmu.edu,omnibond.com,namei.org,dilger.ca,physik.fu-berlin.de,schaufler-ca.com,themaw.net,linux.dev,efficios.com,fomichev.me,huawei.com,artax.karlin.mff.cuni.cz,suse.de,samba.org,hallyn.com,alarsen.net,manguebit.org,dubeyko.com,ionkov.net,nod.at,auristor.com,brown.name,pengutronix.de,suse.cz,tyhicks.com,secunet.com,wdc.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjI1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Tm93IHRoYXQgaV9pbm8gaXMgdTY0IGFuZCB0aGUgUFJJaW5vIGZvcm1hdCBtYWNybyBoYXMgYmVl
biByZW1vdmVkLA0KPiByZXBsYWNlIGFsbCB1c2VzIGluIGNlcGggd2l0aCB0aGUgY29uY3JldGUg
Zm9ybWF0IHN0cmluZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRv
bkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGZzL2NlcGgvY3J5cHRvLmMgfCA0ICsrLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZnMvY2VwaC9jcnlwdG8uYyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gaW5kZXggNzE4
YzE5NGJhNWQ4Y2UyMmM2YTVkMWRkNjg3ZWMzNzYxMjYzZTdlMS4uNjRkMjQwNzU5Mjc3MmVkNjFm
Yjk1YjYyNDAxZGIxOTQxMTJmNDhhOCAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9jcnlwdG8uYw0K
PiArKysgYi9mcy9jZXBoL2NyeXB0by5jDQo+IEBAIC0yNzIsNyArMjcyLDcgQEAgaW50IGNlcGhf
ZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgY2hhciAqYnVmLCBp
bnQgZWxlbikNCj4gIAkvKiBUbyB1bmRlcnN0YW5kIHRoZSAyNDAgbGltaXQsIHNlZSBDRVBIX05P
SEFTSF9OQU1FX01BWCBjb21tZW50cyAqLw0KPiAgCVdBUk5fT04oZWxlbiA+IDI0MCk7DQo+ICAJ
aWYgKGRpciAhPSBwYXJlbnQpIC8vIGxlYWRpbmcgXyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQg
XzxpbnVtPg0KPiAtCQllbGVuICs9IDEgKyBzcHJpbnRmKHAgKyBlbGVuLCAiXyUiIFBSSWlubyAi
dSIsIGRpci0+aV9pbm8pOw0KPiArCQllbGVuICs9IDEgKyBzcHJpbnRmKHAgKyBlbGVuLCAiXyVs
bHUiLCBkaXItPmlfaW5vKTsNCj4gIA0KPiAgb3V0Og0KPiAgCWtmcmVlKGNyeXB0YnVmKTsNCj4g
QEAgLTM3Nyw3ICszNzcsNyBAQCBpbnQgY2VwaF9mbmFtZV90b191c3IoY29uc3Qgc3RydWN0IGNl
cGhfZm5hbWUgKmZuYW1lLCBzdHJ1Y3QgZnNjcnlwdF9zdHIgKnRuYW1lLA0KPiAgCWlmICghcmV0
ICYmIChkaXIgIT0gZm5hbWUtPmRpcikpIHsNCj4gIAkJY2hhciB0bXBfYnVmW0JBU0U2NF9DSEFS
UyhOQU1FX01BWCldOw0KPiAgDQo+IC0JCW5hbWVfbGVuID0gc25wcmludGYodG1wX2J1Ziwgc2l6
ZW9mKHRtcF9idWYpLCAiXyUuKnNfJSIgUFJJaW5vICJ1IiwNCj4gKwkJbmFtZV9sZW4gPSBzbnBy
aW50Zih0bXBfYnVmLCBzaXplb2YodG1wX2J1ZiksICJfJS4qc18lbGx1IiwNCj4gIAkJCQkgICAg
b25hbWUtPmxlbiwgb25hbWUtPm5hbWUsIGRpci0+aV9pbm8pOw0KPiAgCQltZW1jcHkob25hbWUt
Pm5hbWUsIHRtcF9idWYsIG5hbWVfbGVuKTsNCj4gIAkJb25hbWUtPmxlbiA9IG5hbWVfbGVuOw0K
DQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+
DQoNClRoYW5rcywNClNsYXZhLg0K

