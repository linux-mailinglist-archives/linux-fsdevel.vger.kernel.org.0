Return-Path: <linux-fsdevel+bounces-79085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHhjIYMYpmmeKQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:08:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E11E6562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B46723070B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FF345CCD;
	Mon,  2 Mar 2026 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="br1YtjuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BD39098A;
	Mon,  2 Mar 2026 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491169; cv=fail; b=qdj7wH/6tWYy3RX24t9KCrg941loy3kqcD3THNnt8l/t0OIIFsxcu7GxJY6pZLrcFRiZdfmQHvj1tiSW2HkTCHssebivcnBYxZrf6t4n3H86OvqTHvL1WBPPZZPUvQSiO4601KMbAOmbqefuAUmhtP/6aA3dQESDJZsnQoXKfIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491169; c=relaxed/simple;
	bh=h7I7wjgcUqISfPVWpWjKqRnS9Lv/J3K4YnumqX9WKiA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Tge4q/dONkrSmKhqXtOuOruktms4uZjXgBQ5VN/Dg4ES8T4DOu//VLYIWZot/993txT1ekwFuPIRG0xkdvG2xuBX+Mk6SLz9lr9k8zr0/ohCtdLF/z3c43r9LxG+CL4HYGKFvi90XwRMs3rjdtCnzEPk/Yw+oWnci4PK25uNNjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=br1YtjuC; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EdxYQ2438123;
	Mon, 2 Mar 2026 22:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=h7I7wjgcUqISfPVWpWjKqRnS9Lv/J3K4YnumqX9WKiA=; b=br1YtjuC
	VnJYs5uIhqf26EBJXh9VRoa5dTvrLjySCROg3YdRoRRUn8BLFwnVe2KcwteHEML5
	YkMLXDfkw1pi/qMQ94QqDBFeMWe0EZxLIEigCN6VGMXAzhm/NQTEtnQBPQQFfcGR
	zoNeKuZdO2EYB9MKx4mqZKQsCOAYpMkU48YUiCIxo6m/tRd9aw38+Od2NqTMAZoU
	StoY/ZHu6IPzDuwHm2C2Ur+HKg5DdV7dp9PogNcmlcEDp10stKD2m7yzrEj1CA1F
	OMK2IMs/QLOrPZfYIYYnV//b+R12C1Cwo4GxUEfMN5nja+uGaUGFjgQfLyD1NWW1
	oZV4+DCmb3c68g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj0qcs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:38:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1KwGFCL1F3MU5b9FItWe50DI4Jc7GptoQNxAZOWjFOutW/Xbo+3X5xWb9LabXKi53WrBDteEXT952xe4rJ0is8Dhl5zNNW9Xm8qq6MK/pfX3wzi8ML3WgjGs7p4JbQcUP36oeyQcy4yRSDd6cSKpco7FNMONHbD3CzgocDqaIEekbk7EqoRKUYs40dpgc+y9W1cmdCoDlUDHI0fOmXRkWmMN++vl7Iy9SNlgT9aXgczTqCA7vft/jbc6AAtxRh4NRgAjwV6T9DuV/+4eXuMnekFKFM2il+Dt8gkRKYUhyT8rqOlK/bo4gcPgs0g8Lzj7CqQA0YLV8J1RLn2tscU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7I7wjgcUqISfPVWpWjKqRnS9Lv/J3K4YnumqX9WKiA=;
 b=xWsrgfiVK5vQGJJRyrqe9y9fU8ky2YGtAEXxnJ0nfMLa/0PYlU9VdNsziQ2NR+5f+GcgGOOabxk7ygIVaeeOHfhMUEh8/6MgCn/Y740Eqnc2KevczFxN0rFmx32KvVXJGDBiMCue3aDk0Q1KYqRng/zwSE4mf/hxhLC+z+B5qZJppw4Bb2Hpomj9g0Tlc4PE5kuD07p09izjnY6xKos2Ad3eQOm8SwfNMPgCsTc40T08PHBqKb0qbwtzhn/GGux9kZE+vSyH3iiUO4/6urI++Ps9uc2tUyN7fm0/bjHqZXKEuaCXm0IO5MvTYZjnJJbBP7Hz1S8y/3bT6stArwyIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPFE061D9768.namprd15.prod.outlook.com (2603:10b6:518:1::4cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:38:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:38:40 +0000
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
Thread-Topic: [EXTERNAL] [PATCH v2 068/110] nilfs2: replace PRIino with
 %llu/%llx format strings
Thread-Index: AQHcqpH1veHvAidnr0qVoTrVuSHHfLWb1XsA
Date: Mon, 2 Mar 2026 22:38:40 +0000
Message-ID: <8800abc03ee286db813b902f1c32300962381dea.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-68-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-68-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPFE061D9768:EE_
x-ms-office365-filtering-correlation-id: 638af32c-265e-4f20-d04e-08de78ac73d5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 qg5tOpyFMlWHx7QSsCOFGeOSusoHGwrW7/BifelEfBRbedjVwEJuWZvRs1J6sYngDRoCyO8NcyAYCqkz4nM1v0+lRdCYw2I5VASGl1SGsUAkrpmNNXakQtIkq3vPKvpvYnn7BTggjq/6T7WAYMNokh3Kp+noFTT1A5XJxjrUi6T4eiBGwVGo/gFdLiZmqBZ0iBU4I9zOhJ8uBzr6MXHmbU2GoZlyG+Xte7mv+HIjIDDUrNpq8j2avR3r+LSqLUlSwgz0K8pheviXnBkYeiC44HY3Fi6CX0LOnDPkBnADadJ38dvu9EPCnLxly43xV0v6G3PaSkgup49wZPKyMc7UVmQ8UDfC/88nEund6jINGTbaKCQbPCO4eeiad9YBedNERDid4VeNWjB2ZrW5Kc+NbChGQHMeIiVUfu7wiBuEZjkREUtJjx+Zs86atNC5qSCYCMLEx3Ann52dlRFBt91eL9pcDZD8bXs2o/0ymDa2MJ6llwlLfkMQJ3gbPpAhAWP8aLxv5FPoEBRteNZ9XKA7ifT5HH7JNTY2YagRT1krWP50X3z1Ale9qmJQkF0MktFNf1BNPRNISv6Yq/w7JsrewOnIsM1fb0gwTMiq+uD39cdcWSCWx/tIQBkV3GBASl9GDROFoww0h6JYX7izxQmCobgiQ1YjZ1usKBfoVA+Y8pFV6bGVp7arOEEiLAu5TxjFrZI6RWJ+BfejPgt2Nvt7MwuIxvn/w3KYoZR0phdiR9OUkh0+CKPKOUiLB4tUNx0f9mBivYHI4iaNNW9dfv/EJ9nG+hZZ8xgJfOVd/3SE1vg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlNPRUxsbnVsNGtnWTZUV3V2UE5vZVA0NGlFbk9DT2x3ai9oeUF1NXJuYTNF?=
 =?utf-8?B?TVZRaUFTa3BQUmR6dllENVJmaE52cDJGdlZQRDlFM2oraUxVWmpNTWlPTXd1?=
 =?utf-8?B?M3p6VnRUOWZuUm1tcHRlNUJDbjNoUmNFeWVCSVRkWUZTWVZYOUlsWEtBdXVJ?=
 =?utf-8?B?Z1loSURvTitON2tCNUdSQzh0Y1k5SGJBNXVzb1FpOXJKYkVnR2dBSERaQkx3?=
 =?utf-8?B?NHAzYmZoanNra3A2WE9JaUh4U0hpNDA3Z2hGbWZHb0NJeTM1NER6NWxLTW1p?=
 =?utf-8?B?WnFkR1E3U0Z6M2xGTk1OeU5sSUJpbndYUGl2VUttODRDVUF2MXoyMnFlQStp?=
 =?utf-8?B?NW9JZVpPWlc0S3ZBQ1JtMnJlUUxBVkc0OHV5NnNwSUxVMlFpQUI4ZUcvTXhz?=
 =?utf-8?B?UVdseS9hZWFqSHNBWnhwcGd3T2U5OU5teEpTL0U3azlFL2RaNk9UcDVlZUdF?=
 =?utf-8?B?bFdsRnRKbnBYZmFGL0NoeE44K0x2OXV6UUxONVlPK2k4dWVyaFpiMTNwSndS?=
 =?utf-8?B?MnZRZzgwM2h0QjBwSHprUFNWV3JaQ0xCZDhEMjJSMnRwNGRTSDZNMG5teldp?=
 =?utf-8?B?VytLNHRPeFBmdFFDU3FTNU9Gc0YxTmdkWUNObyszZXlxSDJUdzIwRjBCK01C?=
 =?utf-8?B?QlNlMzZVRzlmaTVHTGxkcWFQYjZJSHhYMlNPMi9jSUtHNDM1K2NmTkl3S3NI?=
 =?utf-8?B?UVNzYVlRZWxjZWcrb1dhMVdsR21IOHdrNmVIU0lEVEluNmZKdHpYZlNLU3JP?=
 =?utf-8?B?MWkydHZBTEpGTVBteTZnR0dSSHFDdU1IMXVuUmpGcWg2UWg3T2ovSmVMR1Bk?=
 =?utf-8?B?UTRxd2pHbldXcTlibUNra2pYWmxySXdnL3Y1enJUOCtySStJbTdFUzQwVTBR?=
 =?utf-8?B?WTdMRTY1T1prVFBFZ0NhOElFdmdVRzRLeXRWN1psSk5tYkxrTUlZRUl3MGlT?=
 =?utf-8?B?L2dyUzBWQ1F0ZEJqdW16STNFNDNCMnk5WmFJdEdtL1hrRy9MeGk4NGMrOURu?=
 =?utf-8?B?bThFMU1saUF0U1NVRDVDWTc2WHJPOTg0M2Vycyt3cDBtb25aSTdCeE1VYzQr?=
 =?utf-8?B?ZGVHRTg1ajJUV2xuL1RFeTJtaTZXeFNERkFjaHc0cTZKcXd0czJ5RVhMaGda?=
 =?utf-8?B?bXVZRnFkWXdJZmltUXZoWW9YbEtrQkRiQytGQ3RjbFZsWENGWnIrQVptZ28v?=
 =?utf-8?B?NXdxQ21yNWx5Snd4L1BiTEtsd0dYeDBQTm1mNXpEcHQwYVhmQjUzVE15aTJY?=
 =?utf-8?B?U3pDc1d4eW1IK2wySWMrUEg3STl3WXlRRmFsakhEMHNjemt0ODh5ZHFLZjlC?=
 =?utf-8?B?MDBGd3R5enA0STFkSWFkbzZKRHRQYTRUWXNMaDY5dUtHZkRkNkV3WkpGRThL?=
 =?utf-8?B?OFhYRFBxSVhQd1UzN3B2Y2FlNmxIZmFuQ0hnRW50VW5tRmRXelhUTnA0Vjh0?=
 =?utf-8?B?RitYbDRmOGd0ZkhGMUIvNFVMMm1XOFpSRzFGN2lXUjhBQVhEUnl2K2YrNS9Q?=
 =?utf-8?B?OW9iU2xMSmpMTzdydTY0dGw5aU5kbE15N3g3TXFuVHR3N0l5Wm95U1Vmelln?=
 =?utf-8?B?amN0MVhSWVNKeXRRT3BjWGFlbUNac0FDaTRMaEl0d25oQUpNVDVmMzF5b2lk?=
 =?utf-8?B?dTFGVnM2eEFwaUFRWk5ua1VqN3V4WDBPcmZpWmNmTE9lVFVOSCtyNU5PMCt6?=
 =?utf-8?B?Z3VlZ2V0ckU0eDB1dWVnZCtTV3FNcWRzRlc3VERnSy9UT1V3TkdrQnl4ZXRQ?=
 =?utf-8?B?M3RwMFp0RXJpVXFIdzE5UFFxMExMcXloQVF3RXk5NHJYdzNtRFlhaHh1NUFX?=
 =?utf-8?B?UUNNVkhRK3YwT2Z3Vjg4dmlqT2lyNytYRldXRFlxaW9LYkJzS0JCUlc5VW5B?=
 =?utf-8?B?VDVTS3EvYWhCSUZpNjBud0o2Q3Y5ZkxBaHl6L2c2cVMzcm9uSG8xdElFVUdk?=
 =?utf-8?B?TlVTZDg4REhhYm1QQWYwVHM4Y3RTZ21lanZUL2VRak9ERkJGRW1zWDNBUVdq?=
 =?utf-8?B?bkJjZ2ZORDdmV2lsRjVLUWdVNzU5dlZGNzhxUTZFWmlvQnhEUUR5TkFjQlpK?=
 =?utf-8?B?SS9BeUhrZHNRZjJhK1ZxUEZmckp0VXNqVW1IQXNMT3R2RmRtKytBM09jcm54?=
 =?utf-8?B?YW1YZU10bHQ2Zk45VTBud0JGb2lWTE5RK0JZKy9IQW5abTRYUXlFNGF1Yng1?=
 =?utf-8?B?Y2dydEN2MzRmc1VFSG8vaC81OVVZTWY3ckpkcWh3Ylkvc0VoZ3d5aDg0cHZW?=
 =?utf-8?B?Q0ZESGdoTm83dyt1L1BtaWxoMGJ0amszWnljb3h6T00zR09UeWRSaStZVjRH?=
 =?utf-8?B?a2N4NzJXYVhFeWF3OVZDYU4rQWFMSVlrbStpQ2QwdURxekhDVForcXJHckkx?=
 =?utf-8?Q?8em0l4CGDzUplP9dVcDgv/bEk2D3za16kNnxh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <664D2E1D3580A24698ABC711B55984CB@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 638af32c-265e-4f20-d04e-08de78ac73d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:38:40.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ujg2UeUfPihWwvhBUqhvDS8Kxh4MSayZL4EBwsygLQ03M4iOh8foehVIqV1rMjLEZLRDRsva+P5vLkxMMr2i/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE061D9768
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a61177 cx=c_pps
 a=ggyiYYPOIDPuJa++h0h3+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=1Koa7OJEvVN96EddKCQA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NyBTYWx0ZWRfX9OmTZ5v55DML
 38XrIclCEXvNUIHIDGCfy2FUVfrd+wxdG+kgNoNTTn6dhDzwYtN0XLenLycRfKVi7YPJNLrzAut
 +slGlKUzanRn+svTZL4+ru8r3Do6Svomq7elur7qJxP7/Ab1cbqt8ggOJmYsf1pP3tMA5tHccPe
 Y5LMi4nRN51pZFNJnnK0UmSaO2NtGWc2xoml02Glq+d8f84eZdHq5QGFlioeAuThmH7w3Y54FTK
 nJ/DQxswgsdDgbMsJm1Q6vbh2qLOwj1IV5tUbRbchua3jAzIJ4jPGGA1dTKGWEnePR1Oy06uG8D
 r7MnmCNRCB1Ety4seL2oDR6Ly8IXf2XWsvFHVBey+JcI5+zwRUaGP4LNFd+EzpQ26zMKwHtH/KE
 FlTRW+TAA5MyvdiFTFzq+S6euSOmHslSmQjOhml3tGiEILRbPXKoqeR8pSfg9GkyMCV9OTiMt42
 b8kjHBMoinVB9khDQAw==
X-Proofpoint-GUID: SYkWJ6TCO5AIr3IVxWs2cRDM1HMq0pl9
X-Proofpoint-ORIG-GUID: 3uG7sZ71mfYRremJjcb0bgEF-ZR1G-iW
Subject: Re:  [PATCH v2 068/110] nilfs2: replace PRIino with %llu/%llx format
 strings
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020167
X-Rspamd-Queue-Id: 2B3E11E6562
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79085-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hartkopp.net,gondor.apana.org.au,kernel.org,yaina.de,oracle.com,redhat.com,davemloft.net,paragon-software.com,szeredi.hu,canonical.com,gmail.com,fluxnic.net,intel.com,talpey.com,linux.alibaba.com,paul-moore.com,codewreck.org,linux.intel.com,fasheh.com,crudebyte.com,amd.com,zeniv.linux.org.uk,infradead.org,microsoft.com,holtmann.org,linaro.org,ffwll.ch,arm.com,suse.com,google.com,iogearbox.net,goodmis.org,vivo.com,dev.tdt.de,evilplan.org,mit.edu,cs.cmu.edu,omnibond.com,namei.org,dilger.ca,physik.fu-berlin.de,schaufler-ca.com,themaw.net,linux.dev,efficios.com,fomichev.me,huawei.com,artax.karlin.mff.cuni.cz,suse.de,samba.org,hallyn.com,alarsen.net,manguebit.org,dubeyko.com,ionkov.net,nod.at,auristor.com,brown.name,pengutronix.de,suse.cz,tyhicks.com,secunet.com,wdc.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dubeyko.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjI0IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Tm93IHRoYXQgaV9pbm8gaXMgdTY0IGFuZCB0aGUgUFJJaW5vIGZvcm1hdCBtYWNybyBoYXMgYmVl
biByZW1vdmVkLA0KPiByZXBsYWNlIGFsbCB1c2VzIGluIG5pbGZzMiB3aXRoIHRoZSBjb25jcmV0
ZSBmb3JtYXQgc3RyaW5ncy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZnMvbmlsZnMyL2FsbG9jLmMgICB8IDEwICsrKysr
LS0tLS0NCj4gIGZzL25pbGZzMi9ibWFwLmMgICAgfCAgMiArLQ0KPiAgZnMvbmlsZnMyL2J0bm9k
ZS5jICB8ICAyICstDQo+ICBmcy9uaWxmczIvYnRyZWUuYyAgIHwgMTIgKysrKysrLS0tLS0tDQo+
ICBmcy9uaWxmczIvZGlyLmMgICAgIHwgMTIgKysrKysrLS0tLS0tDQo+ICBmcy9uaWxmczIvZGly
ZWN0LmMgIHwgIDQgKystLQ0KPiAgZnMvbmlsZnMyL2djaW5vZGUuYyB8ICAyICstDQo+ICBmcy9u
aWxmczIvaW5vZGUuYyAgIHwgIDggKysrKy0tLS0NCj4gIGZzL25pbGZzMi9tZHQuYyAgICAgfCAg
MiArLQ0KPiAgZnMvbmlsZnMyL25hbWVpLmMgICB8ICAyICstDQo+ICBmcy9uaWxmczIvc2VnbWVu
dC5jIHwgIDIgKy0NCj4gIDExIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDI5IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9hbGxvYy5jIGIvZnMvbmls
ZnMyL2FsbG9jLmMNCj4gaW5kZXggYTNjNTU5Yzg2ZTVhNGM2M2IxYzlkZDRjYTEzN2YyNDc0OWMz
ZWU4Ny4uN2IxY2QyYmFlZmNmMjFlNTRmOTI2MDg0NWIwMmM3Yzk1YzE0OGM2NCAxMDA2NDQNCj4g
LS0tIGEvZnMvbmlsZnMyL2FsbG9jLmMNCj4gKysrIGIvZnMvbmlsZnMyL2FsbG9jLmMNCj4gQEAg
LTcwNyw3ICs3MDcsNyBAQCB2b2lkIG5pbGZzX3BhbGxvY19jb21taXRfZnJlZV9lbnRyeShzdHJ1
Y3QgaW5vZGUgKmlub2RlLA0KPiAgDQo+ICAJaWYgKCFuaWxmc19jbGVhcl9iaXRfYXRvbWljKGxv
Y2ssIGdyb3VwX29mZnNldCwgYml0bWFwKSkNCj4gIAkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwN
Cj4gLQkJCSAgICIlcyAoaW5vPSUiIFBSSWlubyAidSk6IGVudHJ5IG51bWJlciAlbGx1IGFscmVh
ZHkgZnJlZWQiLA0KPiArCQkJICAgIiVzIChpbm89JWxsdSk6IGVudHJ5IG51bWJlciAlbGx1IGFs
cmVhZHkgZnJlZWQiLA0KPiAgCQkJICAgX19mdW5jX18sIGlub2RlLT5pX2lubywNCj4gIAkJCSAg
ICh1bnNpZ25lZCBsb25nIGxvbmcpcmVxLT5wcl9lbnRyeV9ucik7DQo+ICAJZWxzZQ0KPiBAQCAt
NzQ4LDcgKzc0OCw3IEBAIHZvaWQgbmlsZnNfcGFsbG9jX2Fib3J0X2FsbG9jX2VudHJ5KHN0cnVj
dCBpbm9kZSAqaW5vZGUsDQo+ICANCj4gIAlpZiAoIW5pbGZzX2NsZWFyX2JpdF9hdG9taWMobG9j
aywgZ3JvdXBfb2Zmc2V0LCBiaXRtYXApKQ0KPiAgCQluaWxmc193YXJuKGlub2RlLT5pX3NiLA0K
PiAtCQkJICAgIiVzIChpbm89JSIgUFJJaW5vICJ1KTogZW50cnkgbnVtYmVyICVsbHUgYWxyZWFk
eSBmcmVlZCIsDQo+ICsJCQkgICAiJXMgKGlubz0lbGx1KTogZW50cnkgbnVtYmVyICVsbHUgYWxy
ZWFkeSBmcmVlZCIsDQo+ICAJCQkgICBfX2Z1bmNfXywgaW5vZGUtPmlfaW5vLA0KPiAgCQkJICAg
KHVuc2lnbmVkIGxvbmcgbG9uZylyZXEtPnByX2VudHJ5X25yKTsNCj4gIAllbHNlDQo+IEBAIC04
NjEsNyArODYxLDcgQEAgaW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBfX3U2NCAqZW50cnlfbnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiAgCQkJaWYgKCFuaWxmc19jbGVh
cl9iaXRfYXRvbWljKGxvY2ssIGdyb3VwX29mZnNldCwNCj4gIAkJCQkJCSAgICBiaXRtYXApKSB7
DQo+ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCQkJICAgIiVzIChpbm89JSIg
UFJJaW5vICJ1KTogZW50cnkgbnVtYmVyICVsbHUgYWxyZWFkeSBmcmVlZCIsDQo+ICsJCQkJCSAg
ICIlcyAoaW5vPSVsbHUpOiBlbnRyeSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gIAkJ
CQkJICAgX19mdW5jX18sIGlub2RlLT5pX2lubywNCj4gIAkJCQkJICAgKHVuc2lnbmVkIGxvbmcg
bG9uZyllbnRyeV9ucnNbal0pOw0KPiAgCQkJfSBlbHNlIHsNCj4gQEAgLTkwNiw3ICs5MDYsNyBA
QCBpbnQgbmlsZnNfcGFsbG9jX2ZyZWV2KHN0cnVjdCBpbm9kZSAqaW5vZGUsIF9fdTY0ICplbnRy
eV9ucnMsIHNpemVfdCBuaXRlbXMpDQo+ICAJCQkJCQkJICAgICAgbGFzdF9ucnNba10pOw0KPiAg
CQkJaWYgKHJldCAmJiByZXQgIT0gLUVOT0VOVCkNCj4gIAkJCQluaWxmc193YXJuKGlub2RlLT5p
X3NiLA0KPiAtCQkJCQkgICAiZXJyb3IgJWQgZGVsZXRpbmcgYmxvY2sgdGhhdCBvYmplY3QgKGVu
dHJ5PSVsbHUsIGlubz0lIiBQUklpbm8gInUpIGJlbG9uZ3MgdG8iLA0KPiArCQkJCQkgICAiZXJy
b3IgJWQgZGVsZXRpbmcgYmxvY2sgdGhhdCBvYmplY3QgKGVudHJ5PSVsbHUsIGlubz0lbGx1KSBi
ZWxvbmdzIHRvIiwNCj4gIAkJCQkJICAgcmV0LCAodW5zaWduZWQgbG9uZyBsb25nKWxhc3RfbnJz
W2tdLA0KPiAgCQkJCQkgICBpbm9kZS0+aV9pbm8pOw0KPiAgCQl9DQo+IEBAIC05MjMsNyArOTIz
LDcgQEAgaW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBfX3U2NCAq
ZW50cnlfbnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiAgCQkJcmV0ID0gbmlsZnNfcGFsbG9jX2RlbGV0
ZV9iaXRtYXBfYmxvY2soaW5vZGUsIGdyb3VwKTsNCj4gIAkJCWlmIChyZXQgJiYgcmV0ICE9IC1F
Tk9FTlQpDQo+ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCQkJICAgImVycm9y
ICVkIGRlbGV0aW5nIGJpdG1hcCBibG9jayBvZiBncm91cD0lbHUsIGlubz0lIiBQUklpbm8gInUi
LA0KPiArCQkJCQkgICAiZXJyb3IgJWQgZGVsZXRpbmcgYml0bWFwIGJsb2NrIG9mIGdyb3VwPSVs
dSwgaW5vPSVsbHUiLA0KPiAgCQkJCQkgICByZXQsIGdyb3VwLCBpbm9kZS0+aV9pbm8pOw0KPiAg
CQl9DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2JtYXAuYyBiL2ZzL25pbGZzMi9i
bWFwLmMNCj4gaW5kZXggZTEyOTc5YmFjM2MzZWU1ZWI3ZmNjMmJmMTU2ZmU2ZTQ4ZmM2NWE3ZC4u
ODI0ZjJiZDkxYzE2Nzk2NWVjM2E2NjAyMDJiNmU2YzVmMWZlMDA3ZSAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmlsZnMyL2JtYXAuYw0KPiArKysgYi9mcy9uaWxmczIvYm1hcC5jDQo+IEBAIC0zMyw3ICsz
Myw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfYm1hcF9jb252ZXJ0X2Vycm9yKHN0cnVjdCBuaWxmc19i
bWFwICpibWFwLA0KPiAgDQo+ICAJaWYgKGVyciA9PSAtRUlOVkFMKSB7DQo+ICAJCV9fbmlsZnNf
ZXJyb3IoaW5vZGUtPmlfc2IsIGZuYW1lLA0KPiAtCQkJICAgICAgImJyb2tlbiBibWFwIChpbm9k
ZSBudW1iZXI9JSIgUFJJaW5vICJ1KSIsIGlub2RlLT5pX2lubyk7DQo+ICsJCQkgICAgICAiYnJv
a2VuIGJtYXAgKGlub2RlIG51bWJlcj0lbGx1KSIsIGlub2RlLT5pX2lubyk7DQo+ICAJCWVyciA9
IC1FSU87DQo+ICAJfQ0KPiAgCXJldHVybiBlcnI7DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIv
YnRub2RlLmMgYi9mcy9uaWxmczIvYnRub2RlLmMNCj4gaW5kZXggM2Q2NGYzYTkyMjNlNTYwMWRj
MjMzMmFlNmUxMDA3ZWRkNWI0ODI3Yi4uMmU1NTNkNjk4ZDBmMzk4MGRlOThmY2VkNDE1ZGZkODE5
ZGRiY2EwYSAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2J0bm9kZS5jDQo+ICsrKyBiL2ZzL25p
bGZzMi9idG5vZGUuYw0KPiBAQCAtNjQsNyArNjQsNyBAQCBuaWxmc19idG5vZGVfY3JlYXRlX2Js
b2NrKHN0cnVjdCBhZGRyZXNzX3NwYWNlICpidG5jLCBfX3U2NCBibG9ja25yKQ0KPiAgCQkgKiBj
bGVhcmluZyBvZiBhbiBhYmFuZG9uZWQgYi10cmVlIG5vZGUgaXMgbWlzc2luZyBzb21ld2hlcmUp
Lg0KPiAgCQkgKi8NCj4gIAkJbmlsZnNfZXJyb3IoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAgInN0
YXRlIGluY29uc2lzdGVuY3kgcHJvYmFibHkgZHVlIHRvIGR1cGxpY2F0ZSB1c2Ugb2YgYi10cmVl
IG5vZGUgYmxvY2sgYWRkcmVzcyAlbGx1IChpbm89JSIgUFJJaW5vICJ1KSIsDQo+ICsJCQkgICAg
InN0YXRlIGluY29uc2lzdGVuY3kgcHJvYmFibHkgZHVlIHRvIGR1cGxpY2F0ZSB1c2Ugb2YgYi10
cmVlIG5vZGUgYmxvY2sgYWRkcmVzcyAlbGx1IChpbm89JWxsdSkiLA0KPiAgCQkJICAgICh1bnNp
Z25lZCBsb25nIGxvbmcpYmxvY2tuciwgaW5vZGUtPmlfaW5vKTsNCj4gIAkJZ290byBmYWlsZWQ7
DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2J0cmVlLmMgYi9mcy9uaWxmczIvYnRy
ZWUuYw0KPiBpbmRleCA1NzE2M2U5OTFmYmM0OWUyYmZiYTJmYTU0M2YxYjhkYmQ3NzcxOGY0Li4z
YzAzZjVhNzQxZDE0NGQyMmQxZmZiNWFjZjQzYTAzNWU4OGMwMGRjIDEwMDY0NA0KPiAtLS0gYS9m
cy9uaWxmczIvYnRyZWUuYw0KPiArKysgYi9mcy9uaWxmczIvYnRyZWUuYw0KPiBAQCAtMzUzLDcg
KzM1Myw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfYnRyZWVfbm9kZV9icm9rZW4oY29uc3Qgc3RydWN0
IG5pbGZzX2J0cmVlX25vZGUgKm5vZGUsDQo+ICAJCSAgICAgbmNoaWxkcmVuIDw9IDAgfHwNCj4g
IAkJICAgICBuY2hpbGRyZW4gPiBOSUxGU19CVFJFRV9OT0RFX05DSElMRFJFTl9NQVgoc2l6ZSkp
KSB7DQo+ICAJCW5pbGZzX2NyaXQoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiYmFkIGJ0cmVlIG5v
ZGUgKGlubz0lIiBQUklpbm8gInUsIGJsb2NrbnI9JWxsdSk6IGxldmVsID0gJWQsIGZsYWdzID0g
MHgleCwgbmNoaWxkcmVuID0gJWQiLA0KPiArCQkJICAgImJhZCBidHJlZSBub2RlIChpbm89JWxs
dSwgYmxvY2tucj0lbGx1KTogbGV2ZWwgPSAlZCwgZmxhZ3MgPSAweCV4LCBuY2hpbGRyZW4gPSAl
ZCIsDQo+ICAJCQkgICBpbm9kZS0+aV9pbm8sICh1bnNpZ25lZCBsb25nIGxvbmcpYmxvY2tuciwg
bGV2ZWwsDQo+ICAJCQkgICBmbGFncywgbmNoaWxkcmVuKTsNCj4gIAkJcmV0ID0gMTsNCj4gQEAg
LTM4NCw3ICszODQsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2J0cmVlX3Jvb3RfYnJva2VuKGNvbnN0
IHN0cnVjdCBuaWxmc19idHJlZV9ub2RlICpub2RlLA0KPiAgCQkgICAgIG5jaGlsZHJlbiA+IE5J
TEZTX0JUUkVFX1JPT1RfTkNISUxEUkVOX01BWCB8fA0KPiAgCQkgICAgIChuY2hpbGRyZW4gPT0g
MCAmJiBsZXZlbCA+IE5JTEZTX0JUUkVFX0xFVkVMX05PREVfTUlOKSkpIHsNCj4gIAkJbmlsZnNf
Y3JpdChpbm9kZS0+aV9zYiwNCj4gLQkJCSAgICJiYWQgYnRyZWUgcm9vdCAoaW5vPSUiIFBSSWlu
byAidSk6IGxldmVsID0gJWQsIGZsYWdzID0gMHgleCwgbmNoaWxkcmVuID0gJWQiLA0KPiArCQkJ
ICAgImJhZCBidHJlZSByb290IChpbm89JWxsdSk6IGxldmVsID0gJWQsIGZsYWdzID0gMHgleCwg
bmNoaWxkcmVuID0gJWQiLA0KPiAgCQkJICAgaW5vZGUtPmlfaW5vLCBsZXZlbCwgZmxhZ3MsIG5j
aGlsZHJlbik7DQo+ICAJCXJldCA9IDE7DQo+ICAJfQ0KPiBAQCAtNDUzLDcgKzQ1Myw3IEBAIHN0
YXRpYyBpbnQgbmlsZnNfYnRyZWVfYmFkX25vZGUoY29uc3Qgc3RydWN0IG5pbGZzX2JtYXAgKmJ0
cmVlLA0KPiAgCWlmICh1bmxpa2VseShuaWxmc19idHJlZV9ub2RlX2dldF9sZXZlbChub2RlKSAh
PSBsZXZlbCkpIHsNCj4gIAkJZHVtcF9zdGFjaygpOw0KPiAgCQluaWxmc19jcml0KGJ0cmVlLT5i
X2lub2RlLT5pX3NiLA0KPiAtCQkJICAgImJ0cmVlIGxldmVsIG1pc21hdGNoIChpbm89JSIgUFJJ
aW5vICJ1KTogJWQgIT0gJWQiLA0KPiArCQkJICAgImJ0cmVlIGxldmVsIG1pc21hdGNoIChpbm89
JWxsdSk6ICVkICE9ICVkIiwNCj4gIAkJCSAgIGJ0cmVlLT5iX2lub2RlLT5pX2lubywNCj4gIAkJ
CSAgIG5pbGZzX2J0cmVlX25vZGVfZ2V0X2xldmVsKG5vZGUpLCBsZXZlbCk7DQo+ICAJCXJldHVy
biAxOw0KPiBAQCAtNTIxLDcgKzUyMSw3IEBAIHN0YXRpYyBpbnQgX19uaWxmc19idHJlZV9nZXRf
YmxvY2soY29uc3Qgc3RydWN0IG5pbGZzX2JtYXAgKmJ0cmVlLCBfX3U2NCBwdHIsDQo+ICAgb3V0
X25vX3dhaXQ6DQo+ICAJaWYgKCFidWZmZXJfdXB0b2RhdGUoYmgpKSB7DQo+ICAJCW5pbGZzX2Vy
cihidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCSAgIkkvTyBlcnJvciByZWFkaW5nIGItdHJl
ZSBub2RlIGJsb2NrIChpbm89JSIgUFJJaW5vICJ1LCBibG9ja25yPSVsbHUpIiwNCj4gKwkJCSAg
IkkvTyBlcnJvciByZWFkaW5nIGItdHJlZSBub2RlIGJsb2NrIChpbm89JWxsdSwgYmxvY2tucj0l
bGx1KSIsDQo+ICAJCQkgIGJ0cmVlLT5iX2lub2RlLT5pX2lubywgKHVuc2lnbmVkIGxvbmcgbG9u
ZylwdHIpOw0KPiAgCQlicmVsc2UoYmgpOw0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gQEAgLTIxMDQs
NyArMjEwNCw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfYnRyZWVfcHJvcGFnYXRlKHN0cnVjdCBuaWxm
c19ibWFwICpidHJlZSwNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlpZiAodW5saWtlbHkocmV0
ID09IC1FTk9FTlQpKSB7DQo+ICAJCQluaWxmc19jcml0KGJ0cmVlLT5iX2lub2RlLT5pX3NiLA0K
PiAtCQkJCSAgICJ3cml0aW5nIG5vZGUvbGVhZiBibG9jayBkb2VzIG5vdCBhcHBlYXIgaW4gYi10
cmVlIChpbm89JSIgUFJJaW5vICJ1KSBhdCBrZXk9JWxsdSwgbGV2ZWw9JWQiLA0KPiArCQkJCSAg
ICJ3cml0aW5nIG5vZGUvbGVhZiBibG9jayBkb2VzIG5vdCBhcHBlYXIgaW4gYi10cmVlIChpbm89
JWxsdSkgYXQga2V5PSVsbHUsIGxldmVsPSVkIiwNCj4gIAkJCQkgICBidHJlZS0+Yl9pbm9kZS0+
aV9pbm8sDQo+ICAJCQkJICAgKHVuc2lnbmVkIGxvbmcgbG9uZylrZXksIGxldmVsKTsNCj4gIAkJ
CXJldCA9IC1FSU5WQUw7DQo+IEBAIC0yMTQ2LDcgKzIxNDYsNyBAQCBzdGF0aWMgdm9pZCBuaWxm
c19idHJlZV9hZGRfZGlydHlfYnVmZmVyKHN0cnVjdCBuaWxmc19ibWFwICpidHJlZSwNCj4gIAkg
ICAgbGV2ZWwgPj0gTklMRlNfQlRSRUVfTEVWRUxfTUFYKSB7DQo+ICAJCWR1bXBfc3RhY2soKTsN
Cj4gIAkJbmlsZnNfd2FybihidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCSAgICJpbnZhbGlk
IGJ0cmVlIGxldmVsOiAlZCAoa2V5PSVsbHUsIGlubz0lIiBQUklpbm8gInUsIGJsb2NrbnI9JWxs
dSkiLA0KPiArCQkJICAgImludmFsaWQgYnRyZWUgbGV2ZWw6ICVkIChrZXk9JWxsdSwgaW5vPSVs
bHUsIGJsb2NrbnI9JWxsdSkiLA0KPiAgCQkJICAgbGV2ZWwsICh1bnNpZ25lZCBsb25nIGxvbmcp
a2V5LA0KPiAgCQkJICAgYnRyZWUtPmJfaW5vZGUtPmlfaW5vLA0KPiAgCQkJICAgKHVuc2lnbmVk
IGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yKTsNCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9kaXIu
YyBiL2ZzL25pbGZzMi9kaXIuYw0KPiBpbmRleCBiMTgyZGEwNzZjNThjNDgxMzE0NWJjM2U1MDFh
MWU5YTE4OGJjZTg1Li4zNjUzZGI1Y2RiNjUxMzdkMWU2NjBiYjUwOWMxNGVjNGNiYzg4NDBiIDEw
MDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvZGlyLmMNCj4gKysrIGIvZnMvbmlsZnMyL2Rpci5jDQo+
IEBAIC0xNTAsNyArMTUwLDcgQEAgc3RhdGljIGJvb2wgbmlsZnNfY2hlY2tfZm9saW8oc3RydWN0
IGZvbGlvICpmb2xpbywgY2hhciAqa2FkZHIpDQo+ICANCj4gIEViYWRzaXplOg0KPiAgCW5pbGZz
X2Vycm9yKHNiLA0KPiAtCQkgICAgInNpemUgb2YgZGlyZWN0b3J5ICMlIiBQUklpbm8gInUgaXMg
bm90IGEgbXVsdGlwbGUgb2YgY2h1bmsgc2l6ZSIsDQo+ICsJCSAgICAic2l6ZSBvZiBkaXJlY3Rv
cnkgIyVsbHUgaXMgbm90IGEgbXVsdGlwbGUgb2YgY2h1bmsgc2l6ZSIsDQo+ICAJCSAgICBkaXIt
PmlfaW5vKTsNCj4gIAlnb3RvIGZhaWw7DQo+ICBFc2hvcnQ6DQo+IEBAIC0xNjksNyArMTY5LDcg
QEAgc3RhdGljIGJvb2wgbmlsZnNfY2hlY2tfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywgY2hh
ciAqa2FkZHIpDQo+ICAJZXJyb3IgPSAiZGlzYWxsb3dlZCBpbm9kZSBudW1iZXIiOw0KPiAgYmFk
X2VudHJ5Og0KPiAgCW5pbGZzX2Vycm9yKHNiLA0KPiAtCQkgICAgImJhZCBlbnRyeSBpbiBkaXJl
Y3RvcnkgIyUiIFBSSWlubyAidTogJXMgLSBvZmZzZXQ9JWx1LCBpbm9kZT0lbHUsIHJlY19sZW49
JXpkLCBuYW1lX2xlbj0lZCIsDQo+ICsJCSAgICAiYmFkIGVudHJ5IGluIGRpcmVjdG9yeSAjJWxs
dTogJXMgLSBvZmZzZXQ9JWx1LCBpbm9kZT0lbHUsIHJlY19sZW49JXpkLCBuYW1lX2xlbj0lZCIs
DQo+ICAJCSAgICBkaXItPmlfaW5vLCBlcnJvciwgKGZvbGlvLT5pbmRleCA8PCBQQUdFX1NISUZU
KSArIG9mZnMsDQo+ICAJCSAgICAodW5zaWduZWQgbG9uZylsZTY0X3RvX2NwdShwLT5pbm9kZSks
DQo+ICAJCSAgICByZWNfbGVuLCBwLT5uYW1lX2xlbik7DQo+IEBAIC0xNzcsNyArMTc3LDcgQEAg
c3RhdGljIGJvb2wgbmlsZnNfY2hlY2tfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywgY2hhciAq
a2FkZHIpDQo+ICBFZW5kOg0KPiAgCXAgPSAoc3RydWN0IG5pbGZzX2Rpcl9lbnRyeSAqKShrYWRk
ciArIG9mZnMpOw0KPiAgCW5pbGZzX2Vycm9yKHNiLA0KPiAtCQkgICAgImVudHJ5IGluIGRpcmVj
dG9yeSAjJSIgUFJJaW5vICJ1IHNwYW5zIHRoZSBwYWdlIGJvdW5kYXJ5IG9mZnNldD0lbHUsIGlu
b2RlPSVsdSIsDQo+ICsJCSAgICAiZW50cnkgaW4gZGlyZWN0b3J5ICMlbGx1IHNwYW5zIHRoZSBw
YWdlIGJvdW5kYXJ5IG9mZnNldD0lbHUsIGlub2RlPSVsdSIsDQo+ICAJCSAgICBkaXItPmlfaW5v
LCAoZm9saW8tPmluZGV4IDw8IFBBR0VfU0hJRlQpICsgb2ZmcywNCj4gIAkJICAgICh1bnNpZ25l
ZCBsb25nKWxlNjRfdG9fY3B1KHAtPmlub2RlKSk7DQo+ICBmYWlsOg0KPiBAQCAtMjUxLDcgKzI1
MSw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfcmVhZGRpcihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0
IGRpcl9jb250ZXh0ICpjdHgpDQo+ICANCj4gIAkJa2FkZHIgPSBuaWxmc19nZXRfZm9saW8oaW5v
ZGUsIG4sICZmb2xpbyk7DQo+ICAJCWlmIChJU19FUlIoa2FkZHIpKSB7DQo+IC0JCQluaWxmc19l
cnJvcihzYiwgImJhZCBwYWdlIGluICMlIiBQUklpbm8gInUiLCBpbm9kZS0+aV9pbm8pOw0KPiAr
CQkJbmlsZnNfZXJyb3Ioc2IsICJiYWQgcGFnZSBpbiAjJWxsdSIsIGlub2RlLT5pX2lubyk7DQo+
ICAJCQljdHgtPnBvcyArPSBQQUdFX1NJWkUgLSBvZmZzZXQ7DQo+ICAJCQlyZXR1cm4gLUVJTzsN
Cj4gIAkJfQ0KPiBAQCAtMzM2LDcgKzMzNiw3IEBAIHN0cnVjdCBuaWxmc19kaXJfZW50cnkgKm5p
bGZzX2ZpbmRfZW50cnkoc3RydWN0IGlub2RlICpkaXIsDQo+ICAJCS8qIG5leHQgZm9saW8gaXMg
cGFzdCB0aGUgYmxvY2tzIHdlJ3ZlIGdvdCAqLw0KPiAgCQlpZiAodW5saWtlbHkobiA+IChkaXIt
PmlfYmxvY2tzID4+IChQQUdFX1NISUZUIC0gOSkpKSkgew0KPiAgCQkJbmlsZnNfZXJyb3IoZGly
LT5pX3NiLA0KPiAtCQkJICAgICAgICJkaXIgJSIgUFJJaW5vICJ1IHNpemUgJWxsZCBleGNlZWRz
IGJsb2NrIGNvdW50ICVsbHUiLA0KPiArCQkJICAgICAgICJkaXIgJWxsdSBzaXplICVsbGQgZXhj
ZWVkcyBibG9jayBjb3VudCAlbGx1IiwNCj4gIAkJCSAgICAgICBkaXItPmlfaW5vLCBkaXItPmlf
c2l6ZSwNCj4gIAkJCSAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKWRpci0+aV9ibG9ja3MpOw0K
PiAgCQkJZ290byBvdXQ7DQo+IEBAIC0zODIsNyArMzgyLDcgQEAgc3RydWN0IG5pbGZzX2Rpcl9l
bnRyeSAqbmlsZnNfZG90ZG90KHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZm9saW8gKipmb2xp
b3ApDQo+ICAJcmV0dXJuIG5leHRfZGU7DQo+ICANCj4gIGZhaWw6DQo+IC0JbmlsZnNfZXJyb3Io
ZGlyLT5pX3NiLCAiZGlyZWN0b3J5ICMlIiBQUklpbm8gInUgJXMiLCBkaXItPmlfaW5vLCBtc2cp
Ow0KPiArCW5pbGZzX2Vycm9yKGRpci0+aV9zYiwgImRpcmVjdG9yeSAjJWxsdSAlcyIsIGRpci0+
aV9pbm8sIG1zZyk7DQo+ICAJZm9saW9fcmVsZWFzZV9rbWFwKGZvbGlvLCBkZSk7DQo+ICAJcmV0
dXJuIE5VTEw7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvZGlyZWN0LmMgYi9mcy9u
aWxmczIvZGlyZWN0LmMNCj4gaW5kZXggMTA4NGQ0ZDU4NmUwNzhhYjY4MjUxNjc5NzZkZDJhNzFk
NTJiYzhhYS4uOGJkMGIxMzc0ZTI1ZjhmZjUxMGYzYjM2ZGJkZTJhY2MwMWFhZmMxZSAxMDA2NDQN
Cj4gLS0tIGEvZnMvbmlsZnMyL2RpcmVjdC5jDQo+ICsrKyBiL2ZzL25pbGZzMi9kaXJlY3QuYw0K
PiBAQCAtMzM4LDcgKzMzOCw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfZGlyZWN0X2Fzc2lnbihzdHJ1
Y3QgbmlsZnNfYm1hcCAqYm1hcCwNCj4gIAlrZXkgPSBuaWxmc19ibWFwX2RhdGFfZ2V0X2tleShi
bWFwLCAqYmgpOw0KPiAgCWlmICh1bmxpa2VseShrZXkgPiBOSUxGU19ESVJFQ1RfS0VZX01BWCkp
IHsNCj4gIAkJbmlsZnNfY3JpdChibWFwLT5iX2lub2RlLT5pX3NiLA0KPiAtCQkJICAgIiVzIChp
bm89JSIgUFJJaW5vICJ1KTogaW52YWxpZCBrZXk6ICVsbHUiLA0KPiArCQkJICAgIiVzIChpbm89
JWxsdSk6IGludmFsaWQga2V5OiAlbGx1IiwNCj4gIAkJCSAgIF9fZnVuY19fLA0KPiAgCQkJICAg
Ym1hcC0+Yl9pbm9kZS0+aV9pbm8sICh1bnNpZ25lZCBsb25nIGxvbmcpa2V5KTsNCj4gIAkJcmV0
dXJuIC1FSU5WQUw7DQo+IEBAIC0zNDYsNyArMzQ2LDcgQEAgc3RhdGljIGludCBuaWxmc19kaXJl
Y3RfYXNzaWduKHN0cnVjdCBuaWxmc19ibWFwICpibWFwLA0KPiAgCXB0ciA9IG5pbGZzX2RpcmVj
dF9nZXRfcHRyKGJtYXAsIGtleSk7DQo+ICAJaWYgKHVubGlrZWx5KHB0ciA9PSBOSUxGU19CTUFQ
X0lOVkFMSURfUFRSKSkgew0KPiAgCQluaWxmc19jcml0KGJtYXAtPmJfaW5vZGUtPmlfc2IsDQo+
IC0JCQkgICAiJXMgKGlubz0lIiBQUklpbm8gInUpOiBpbnZhbGlkIHBvaW50ZXI6ICVsbHUiLA0K
PiArCQkJICAgIiVzIChpbm89JWxsdSk6IGludmFsaWQgcG9pbnRlcjogJWxsdSIsDQo+ICAJCQkg
ICBfX2Z1bmNfXywNCj4gIAkJCSAgIGJtYXAtPmJfaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9u
ZyBsb25nKXB0cik7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmls
ZnMyL2djaW5vZGUuYyBiL2ZzL25pbGZzMi9nY2lub2RlLmMNCj4gaW5kZXggNzE0OTYyZDAxMGRh
NGEyM2U5YjVmNDBkZThhYWFjYThiOTVhNzRkYS4uNjJkNGMxYjc4N2U5NWM5NjFhMzYwYTQyMTRk
NjIxZDU2NGFkOGI0YyAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2djaW5vZGUuYw0KPiArKysg
Yi9mcy9uaWxmczIvZ2Npbm9kZS5jDQo+IEBAIC0xMzcsNyArMTM3LDcgQEAgaW50IG5pbGZzX2dj
Y2FjaGVfd2FpdF9hbmRfbWFya19kaXJ0eShzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoKQ0KPiAgCQlz
dHJ1Y3QgaW5vZGUgKmlub2RlID0gYmgtPmJfZm9saW8tPm1hcHBpbmctPmhvc3Q7DQo+ICANCj4g
IAkJbmlsZnNfZXJyKGlub2RlLT5pX3NiLA0KPiAtCQkJICAiSS9PIGVycm9yIHJlYWRpbmcgJXMg
YmxvY2sgZm9yIEdDIChpbm89JSIgUFJJaW5vICJ1LCB2YmxvY2tucj0lbGx1KSIsDQo+ICsJCQkg
ICJJL08gZXJyb3IgcmVhZGluZyAlcyBibG9jayBmb3IgR0MgKGlubz0lbGx1LCB2YmxvY2tucj0l
bGx1KSIsDQo+ICAJCQkgIGJ1ZmZlcl9uaWxmc19ub2RlKGJoKSA/ICJub2RlIiA6ICJkYXRhIiwN
Cj4gIAkJCSAgaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9uZyBsb25nKWJoLT5iX2Jsb2NrbnIp
Ow0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9pbm9kZS5jIGIv
ZnMvbmlsZnMyL2lub2RlLmMNCj4gaW5kZXggMGJjMWM1MTQxZWM1OTZiM2MzMWU3ZDE4ZTRiYTM1
NDFiZjYxODQwNi4uNTFmN2UxMjVhMzExYjg2ODg2MGUzZTExMTcwMGQ0OWQ0Y2I5OGZhNiAxMDA2
NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2lub2RlLmMNCj4gKysrIGIvZnMvbmlsZnMyL2lub2RlLmMN
Cj4gQEAgLTEwOCw3ICsxMDgsNyBAQCBpbnQgbmlsZnNfZ2V0X2Jsb2NrKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHNlY3Rvcl90IGJsa29mZiwNCj4gIAkJCQkgKiBiZSBsb2NrZWQgaW4gdGhpcyBjYXNl
Lg0KPiAgCQkJCSAqLw0KPiAgCQkJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkJCSAg
ICIlcyAoaW5vPSUiIFBSSWlubyAidSk6IGEgcmFjZSBjb25kaXRpb24gd2hpbGUgaW5zZXJ0aW5n
IGEgZGF0YSBibG9jayBhdCBvZmZzZXQ9JWxsdSIsDQo+ICsJCQkJCSAgICIlcyAoaW5vPSVsbHUp
OiBhIHJhY2UgY29uZGl0aW9uIHdoaWxlIGluc2VydGluZyBhIGRhdGEgYmxvY2sgYXQgb2Zmc2V0
PSVsbHUiLA0KPiAgCQkJCQkgICBfX2Z1bmNfXywgaW5vZGUtPmlfaW5vLA0KPiAgCQkJCQkgICAo
dW5zaWduZWQgbG9uZyBsb25nKWJsa29mZik7DQo+ICAJCQkJZXJyID0gLUVBR0FJTjsNCj4gQEAg
LTc4OSw3ICs3ODksNyBAQCBzdGF0aWMgdm9pZCBuaWxmc190cnVuY2F0ZV9ibWFwKHN0cnVjdCBu
aWxmc19pbm9kZV9pbmZvICppaSwNCj4gIAkJZ290byByZXBlYXQ7DQo+ICANCj4gIGZhaWxlZDoN
Cj4gLQluaWxmc193YXJuKGlpLT52ZnNfaW5vZGUuaV9zYiwgImVycm9yICVkIHRydW5jYXRpbmcg
Ym1hcCAoaW5vPSUiIFBSSWlubyAidSkiLA0KPiArCW5pbGZzX3dhcm4oaWktPnZmc19pbm9kZS5p
X3NiLCAiZXJyb3IgJWQgdHJ1bmNhdGluZyBibWFwIChpbm89JWxsdSkiLA0KPiAgCQkgICByZXQs
IGlpLT52ZnNfaW5vZGUuaV9pbm8pOw0KPiAgfQ0KPiAgDQo+IEBAIC0xMDI2LDcgKzEwMjYsNyBA
QCBpbnQgbmlsZnNfc2V0X2ZpbGVfZGlydHkoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQg
aW50IG5yX2RpcnR5KQ0KPiAgCQkJICogdGhpcyBpbm9kZS4NCj4gIAkJCSAqLw0KPiAgCQkJbmls
ZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCQkgICAiY2Fubm90IHNldCBmaWxlIGRpcnR5IChp
bm89JSIgUFJJaW5vICJ1KTogdGhlIGZpbGUgaXMgYmVpbmcgZnJlZWQiLA0KPiArCQkJCSAgICJj
YW5ub3Qgc2V0IGZpbGUgZGlydHkgKGlubz0lbGx1KTogdGhlIGZpbGUgaXMgYmVpbmcgZnJlZWQi
LA0KPiAgCQkJCSAgIGlub2RlLT5pX2lubyk7DQo+ICAJCQlzcGluX3VubG9jaygmbmlsZnMtPm5z
X2lub2RlX2xvY2spOw0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7IC8qDQo+IEBAIC0xMDU3LDcgKzEw
NTcsNyBAQCBpbnQgX19uaWxmc19tYXJrX2lub2RlX2RpcnR5KHN0cnVjdCBpbm9kZSAqaW5vZGUs
IGludCBmbGFncykNCj4gIAllcnIgPSBuaWxmc19sb2FkX2lub2RlX2Jsb2NrKGlub2RlLCAmaWJo
KTsNCj4gIAlpZiAodW5saWtlbHkoZXJyKSkgew0KPiAgCQluaWxmc193YXJuKGlub2RlLT5pX3Ni
LA0KPiAtCQkJICAgImNhbm5vdCBtYXJrIGlub2RlIGRpcnR5IChpbm89JSIgUFJJaW5vICJ1KTog
ZXJyb3IgJWQgbG9hZGluZyBpbm9kZSBibG9jayIsDQo+ICsJCQkgICAiY2Fubm90IG1hcmsgaW5v
ZGUgZGlydHkgKGlubz0lbGx1KTogZXJyb3IgJWQgbG9hZGluZyBpbm9kZSBibG9jayIsDQo+ICAJ
CQkgICBpbm9kZS0+aV9pbm8sIGVycik7DQo+ICAJCXJldHVybiBlcnI7DQo+ICAJfQ0KPiBkaWZm
IC0tZ2l0IGEvZnMvbmlsZnMyL21kdC5jIGIvZnMvbmlsZnMyL21kdC5jDQo+IGluZGV4IDg2Mjlj
NzJiNjJkYjMzMjE3ZDQ3NDcxMjQ4ODViNmY3MjdmMTgyYmUuLjA5YWRiNDBjNjVlNTA1ZDkyMDEy
YTNkMmY1ZmU4YTU2OTZlMTAwNTYgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9tZHQuYw0KPiAr
KysgYi9mcy9uaWxmczIvbWR0LmMNCj4gQEAgLTIwMyw3ICsyMDMsNyBAQCBzdGF0aWMgaW50IG5p
bGZzX21kdF9yZWFkX2Jsb2NrKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGxvbmcgYmxv
Y2ssDQo+ICAJZXJyID0gLUVJTzsNCj4gIAlpZiAoIWJ1ZmZlcl91cHRvZGF0ZShmaXJzdF9iaCkp
IHsNCj4gIAkJbmlsZnNfZXJyKGlub2RlLT5pX3NiLA0KPiAtCQkJICAiSS9PIGVycm9yIHJlYWRp
bmcgbWV0YS1kYXRhIGZpbGUgKGlubz0lIiBQUklpbm8gInUsIGJsb2NrLW9mZnNldD0lbHUpIiwN
Cj4gKwkJCSAgIkkvTyBlcnJvciByZWFkaW5nIG1ldGEtZGF0YSBmaWxlIChpbm89JWxsdSwgYmxv
Y2stb2Zmc2V0PSVsdSkiLA0KPiAgCQkJICBpbm9kZS0+aV9pbm8sIGJsb2NrKTsNCj4gIAkJZ290
byBmYWlsZWRfYmg7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL25hbWVpLmMgYi9m
cy9uaWxmczIvbmFtZWkuYw0KPiBpbmRleCAyOWVkYjg0YTA2NjNjYWE0YjI5ZmE0ODhjMDQ5NWZj
NTMzNThjYTAwLi40MGFjNjc5ZWM1NmU0MDBiMWRmOThlOWJlNmZlOWNhMzM4YTliYTUxIDEwMDY0
NA0KPiAtLS0gYS9mcy9uaWxmczIvbmFtZWkuYw0KPiArKysgYi9mcy9uaWxmczIvbmFtZWkuYw0K
PiBAQCAtMjkyLDcgKzI5Miw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfZG9fdW5saW5rKHN0cnVjdCBp
bm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ICANCj4gIAlpZiAoIWlub2RlLT5p
X25saW5rKSB7DQo+ICAJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiZGVsZXRp
bmcgbm9uZXhpc3RlbnQgZmlsZSAoaW5vPSUiIFBSSWlubyAidSksICVkIiwNCj4gKwkJCSAgICJk
ZWxldGluZyBub25leGlzdGVudCBmaWxlIChpbm89JWxsdSksICVkIiwNCj4gIAkJCSAgIGlub2Rl
LT5pX2lubywgaW5vZGUtPmlfbmxpbmspOw0KPiAgCQlzZXRfbmxpbmsoaW5vZGUsIDEpOw0KPiAg
CX0NCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9zZWdtZW50LmMgYi9mcy9uaWxmczIvc2VnbWVu
dC5jDQo+IGluZGV4IDlhOGJjM2ZhMzVjZTliNDQ3YWJiYzJmYjU2Y2JkMmIwY2M1Zjc2ZGUuLjRi
MWJmNTU5ZjM1MjRiMWNjMzk2NWRhZTlmZDNlNTc0NTcxODU2OWQgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25pbGZzMi9zZWdtZW50LmMNCj4gKysrIGIvZnMvbmlsZnMyL3NlZ21lbnQuYw0KPiBAQCAtMjAy
NCw3ICsyMDI0LDcgQEAgc3RhdGljIGludCBuaWxmc19zZWdjdG9yX2NvbGxlY3RfZGlydHlfZmls
ZXMoc3RydWN0IG5pbGZzX3NjX2luZm8gKnNjaSwNCj4gIAkJCQlpZmlsZSwgaWktPnZmc19pbm9k
ZS5pX2lubywgJmliaCk7DQo+ICAJCQlpZiAodW5saWtlbHkoZXJyKSkgew0KPiAgCQkJCW5pbGZz
X3dhcm4oc2NpLT5zY19zdXBlciwNCj4gLQkJCQkJICAgImxvZyB3cml0ZXI6IGVycm9yICVkIGdl
dHRpbmcgaW5vZGUgYmxvY2sgKGlubz0lIiBQUklpbm8gInUpIiwNCj4gKwkJCQkJICAgImxvZyB3
cml0ZXI6IGVycm9yICVkIGdldHRpbmcgaW5vZGUgYmxvY2sgKGlubz0lbGx1KSIsDQo+ICAJCQkJ
CSAgIGVyciwgaWktPnZmc19pbm9kZS5pX2lubyk7DQo+ICAJCQkJcmV0dXJuIGVycjsNCj4gIAkJ
CX0NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+
DQoNClRoYW5rcywNClNsYXZhLg0KDQo=

