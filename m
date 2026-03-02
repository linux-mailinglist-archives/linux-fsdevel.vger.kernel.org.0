Return-Path: <linux-fsdevel+bounces-79083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCNuN/MQpmnlJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:36:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF731E5B0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BBDE302FB0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AE31F987;
	Mon,  2 Mar 2026 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SJCWJnp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B41AF0BB;
	Mon,  2 Mar 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490938; cv=fail; b=rvcpHNvUM260RWq3slzE/zp4TngkWc5S92TGXlZjlog9+FAyLvuezYwEQN8U4MMY96ATTnpdUZgdtnCmvvYzXQx88emR+HJBia4pAgvbGadpyxvP2g3p0GD37wy6/gceCNAn1eodmoxniq1DiwdBf6O+iPErLDqPLPSPNxqnVIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490938; c=relaxed/simple;
	bh=vDsuLKCSUzn9/6h7Xgj+KY7G2hTsAHT32tVyBSuo5Gc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=P2WYK5AdEwBNGMOAGUsRfh67xGUMYPmlFyHQyielAgnice3G74zqP4JpK/ebVEKWqu5Y4HCytNVZYm0n5HvZabUNIujLqxIdOYoA55qrfJrUyHOoJHyhr435gjal2T5FmXQMq26YcQd0RBB+tEiUlxfslkSQD0MBh9L2iyAgcvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SJCWJnp6; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622KLS7l614134;
	Mon, 2 Mar 2026 22:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=vDsuLKCSUzn9/6h7Xgj+KY7G2hTsAHT32tVyBSuo5Gc=; b=SJCWJnp6
	AqmATCEZ+8251RnnrqxexeJqRuu87Xri5t2ItJAy54T9zQ17pFb2wgPzSLulLySl
	GXVr/iYaFf1s3Yj/JFgZkFrN0zKg/Sq8u8p9LqhKXZzrMk9wa+N2LwOu4BeRExBt
	1PJNz+pwpsna3akOj/d+62bq2TsAvc/zo6mN95lB+xBmF1LK/kFOkJSJJgetYJBw
	jxkSgcE01Nl7shUfj/uIT8ZsfQaBUAcWSXRKoAqF/x1rhAdnCXmkVVRDKlj4IIVu
	S7oNQHmV75qbv0j1/YT4AIUlqNy+k0eM8Uyso8+K396w5e7gBqjs3SwKsTTZyTM4
	OxEx7xdGKQ9FfA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmgfwm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:34:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFDVksJBMERlu9Fy6oiFkXxvFfvbIEPB1dO2daYv1q053ldMFEqNZqP1RVv4aj9cPzvWsqlGKwgmiwr2irQErZUdegFQFk9RN4XBfaC6Z+X61KoApdZ4C8gXc0YPBiFBJ3xU8X6qaItqrYtoWkYkRcgw84qFIgIwqSHlFxsUc2dTYxi8eDCXZ2jxDdnKPfb/7yGTmUy2ZW57VoqBH75fkHqp7dKOGVQvtruSVwVdQxLDqjItsEBd4mqQTFmoUQz5+5QJprRilnjJ/Nj3V90vAZCeEU8lmCKp4ngsg/r01jLonO3ObhcgmS5clc0dvQh5ICd56evbtMBt/Xaxm7yj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDsuLKCSUzn9/6h7Xgj+KY7G2hTsAHT32tVyBSuo5Gc=;
 b=sCiM/PhiVnRjH9I6VgHBmzcmCeWuRfOHhj95KN/Ui2lN4wbCob17yLfJVstjddQWDO5aEC8j0z6zpSKHZ/zw3akLw6Ll0rTYe2Kt3hzvfd0gcid1sdQ3UG9vej6Ih4M4BmVqFIqhkHadC7kxqjHNV013OrsswKsgityLQCsJFLj4HEx5gIIXQmF+UEUUEterjscQOWdK5LHDNSyWLM69pYWs4+OcjYaG70DxuyuoLmxgGbU2LXO3RQrtx7RoKEOE/nGINRsCJ6JHL4q+83Il5fL4XyyOFO6X8ytJM0n/4bgtzw+sZVz+sMuuuKW1/NXuUGiIUPd6UC0X+ri66TSmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4155.namprd15.prod.outlook.com (2603:10b6:a03:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:34:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:34:46 +0000
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
Thread-Topic: [EXTERNAL] [PATCH v2 015/110] nilfs2: use PRIino format for
 i_ino
Thread-Index: AQHcqoQRgDHOLEzPOEupU0/5WkpicbWb1IAA
Date: Mon, 2 Mar 2026 22:34:45 +0000
Message-ID: <399d2efe1490481738549c02aa2f6abc87058c88.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-15-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-15-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4155:EE_
x-ms-office365-filtering-correlation-id: 6cdda2f5-1759-4436-50b2-08de78abe7f2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 baa7gcpAsfOf3p8EBkdUuo+xbox+G5XbYh1/Zj24Ia8dxS53bNXO3HYYfqldoPsYBdhn1Q4dJgwtIYp0+2TzJHXe4K2/69CUskf7L4Uh+to4hT5UK+RVqIzZ53tpCpEXXm7/W3pz/KOqgNZ0NedyUCie3McUIBcC7nXXub54fLThYadav0Z3ICaTL3ULBYlC8T5IIIPVnplaNrAY4jL1GwLXoU1h2UPXbIbnlT9biP+NO0cG934ggqM7DmzdbgCIMxjDY1pIRqzEapD1eiQRoWYao8VEDRLfR7uBdpSVFltwgw8uyq0r05wiogiZLwMGY9HFdoyvCWU/w4Y01cpcbVlRhYnjkqVR8FdDQyaO12Xz2YVfjwa83orAH2mdxgsjd3BpNUhlEYX4IbIgE33cFoFoyORg1nLk+COnNY8Za0Oqnf2tsPLrGDgFOMY99aVb+fH1/5y2EkNXHtlPcECzLdaro4ijrDiSTZ53WjCivgDhpr7BXlUIe2XxHrFql94K1wn3ZI3ZcxXv8sEKEQZ2bbVp42KQJ9cTK2E5fS6wB8j1wKgnr/u/4PpiE6H2/JhsUugAHRFO3yzc5f6r0pENWRqS4uuHvpjgWebWjXrxto1z1ZpVP8XGinbADzO6vCThSV3Q0Gg/WqicWEXYzk355vYPU4pyspcSSpTLO2CWSj0ymxzuFmi0YASuyAMRGcOSLsH3hckJT1VMUL7aOzAC3hln1Yz+DR1p5fo6G8FIoKrwMXPScAJh24tufhbRjH4uhHW7507plWZTwW1+f5fNhnQvmcaYFAjNXFazC4mcd4g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTNsU29DMXFDakhyeWhDamlaRmRJdlJKZ2JyRGNGbWxVdXA5MnVoQ1Y0cjNr?=
 =?utf-8?B?TENQMFE5cm1CVHM5UDlVTmYzMzdVc3pMZkplcWJ0MWZONlAyQ0lEYi9DQzhB?=
 =?utf-8?B?ZExJSUNIZkVmYk1YUjI2WGpROHFwVFdNdTZpb3dpSXhHbjJUQ014VnIycnBJ?=
 =?utf-8?B?UC9mM3daVjhyeXJDbHUzVW9hbWpwRElwWTBrcEpvL3l0bkxwSXQ5OGQwdnZ0?=
 =?utf-8?B?Rm1jaVE5QVhYVmZrc08xU3pzT3RMaUtYRUFjRURwSkxLdHNSZUxLam1KTzNW?=
 =?utf-8?B?Zk8zVjdIZ2hRc3N3S2tKQVVqcitMeEVsTEFoTnpTbHdybWFTRGJ6RUlhYWlO?=
 =?utf-8?B?L25ySjBZUWR3WTh2M1lnbmhlbDBRcisxRTg1bEc5NTlNdjVYaTRCczdvVUty?=
 =?utf-8?B?aVMxOXhsNHVrOVNBbUdHNi9PdlVjTVNmUTFPcy80c2p4RndYTVExOTROelE5?=
 =?utf-8?B?L2ZhZzFxOGg3VVBHRzVyWW5ZVFdYSlRHMTdGdjNqQ2JnL1dxUmVrbVV0RkRC?=
 =?utf-8?B?YUZlblYrVkxyWS92ME01MG5jc2lEbC8vU0RkeUxtV0NWWFUyMjZhbDRzVGxD?=
 =?utf-8?B?L3NhRktyc0trUk54Q1hyengyVkJoZ0J2VEdTL3pmMXBMZXBqWTd3bk5kWTdO?=
 =?utf-8?B?cnFybWxuOGJySEdUc2tMdVhuNFRvSzJZcUFhYXlaeU9WNERydmNNc0pjSjJh?=
 =?utf-8?B?OWVMZzZ0L1R6bU1XbS9kc0trWTlndE02aS9YWG9xSWY1Zy9DbVJqbkdRN3Fn?=
 =?utf-8?B?ZUx5Q21HZ2VzK1FDMS91NGZHTnRTVGlvSWtMRDhXbi9ycGhYb3czbksxS2x4?=
 =?utf-8?B?VVBQY3Y0NWQwYW9JdzFwcUpiMWlSVEI4NUNkc1ZEekROeHB3b29pVVpMYmhO?=
 =?utf-8?B?UWt6WCtQZjRHZFRjRjZ2Tml5MktzTURjWmczbzkrUWdpNlprMC9lWFJERVJZ?=
 =?utf-8?B?c1pOZkpRK0xmTHhBUzVtblN3YWhWZjhLK3pEOVZWbXJqZkxZcnZvQzFhWWNw?=
 =?utf-8?B?RC9jamxCSVhpSXJYcGNqUXpiRzVXa3k1K1ZLQ0RSNytOMk5hSUJnMGF4cjRG?=
 =?utf-8?B?N0g1TDRNUU1xS0JuZkhTcjZCTysySER4dDY2REZ0SXFGcUM4VTVBbUlKWGly?=
 =?utf-8?B?T05lTEp4bDNya1ViS2txL29yUzVOM3pmUjZqTm1CeHFyRG01dStFWnZENjdk?=
 =?utf-8?B?bFFwQ21vNmV4NjVzemdBOUx3WDY0Y0xBc2tUT282bkpYNUFXQ01rN245K1Zm?=
 =?utf-8?B?UEtlSGZoeGI4Vzlsc2NiaW5HTHluTWNkOUlEbFV2K25ya21UL1FraDFWSUxy?=
 =?utf-8?B?WktXY3IrRXA1M3NGMXBiMXhpN0tSN0c1YVUrY2Z1ajNWNVJmWlVlY1U0RzZ4?=
 =?utf-8?B?R1QxanMxVlNWU1A2NVNyL2Y4YzRrOWN6VFpVVTBqMnBWWjRyZ2t6dUszK2ty?=
 =?utf-8?B?N281V29CNkp2TnJBcHYrVW9lYzFxdEJ4RDczMVlzQ3VuUEU3REszUjgwS1BH?=
 =?utf-8?B?MnZ6QVplVXMrY3J3OXlVYXZuYUpYellmVWwxTzZ2MEZSZ3lpM2RNT0tjSHNr?=
 =?utf-8?B?NzMwQXhDQ2xIeGVtcE1yN1R1a2ZTMGhya0RNZkxpR1J5cnhZdkdJQ3FlWVpi?=
 =?utf-8?B?WTdhalZCWjhNWEh5bUx4QXBKTE1UVUplWitldWdQOUI5amc2MkZNWDF1VUtC?=
 =?utf-8?B?Z253aFc4Yi9XZ2Z0dS82WFIyYlZNZ0NFbXVhWVRuc1NVWXdteWJ5aVAzS2tx?=
 =?utf-8?B?cUZhbU9LSXhYT085dm1qQTNDSFB1dUM4VFdaMnJYMVFsN2d2TUgrK2hOem1j?=
 =?utf-8?B?WlFEUTdHcTNHSVVzV2tTTW9sR3laLy9BWVJaeEl5c0xpcGd1K0lEaWh5dStv?=
 =?utf-8?B?WmdnNExNeStiTEM4eXJRUkJ0Wmo2QUU4WURGMXcxTFVWRTJla1Q0SjZ6aXFq?=
 =?utf-8?B?OGZuRUQ0Njhiamp1N1RJMWdqQTZLR0wxTjQwSUFXNkRyN3YrLyt3dHFwaThI?=
 =?utf-8?B?YkI1VVlZL0w2TnJ6cTg1VGM0cXV1SnVOV2ZFSkJUQ1lNbEZaTjM1UHZZRC9i?=
 =?utf-8?B?K3duR3EvNzViVWdablROWUF0enhrK0poTk5zT2tyckVzMjZOczFiQmFlSW16?=
 =?utf-8?B?Zm5MbVp5SENnWHhQb041MW8zSmllZFAxNlhZK1lnWFZNMWt0UURFQ3Z6UWZv?=
 =?utf-8?B?NWpkTjJwZnZqbW1uVndDQUF0TzBhWkpUak5XVis3UFgxdlJnRFl4Tml5SWNR?=
 =?utf-8?B?emI5Ry9rbWh4eWRKc2JQRVdkUnUrbDluWGNYa2gvcFJScUVwSGtKSzNpRXpD?=
 =?utf-8?B?azB5RGhhQnhJNXJVRXRMcnhjUGRpMUJJVzJzYlBoNGlsc3oraGo3bVJETUVE?=
 =?utf-8?Q?Z1cYHh43WNWrSm6dE62cZjVJHMl/MPovAqEo7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BEFFFA29157BC4D94F1C67D38DDA4CF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdda2f5-1759-4436-50b2-08de78abe7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:34:45.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpjgQJsZlkWaylefBuxfaKNZf4yBj/+xwCzJoLXJK92xbDVhv7/1hQ6Arle3RHFFsneUK1TyQqluB6Z0oqtAkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4155
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NCBTYWx0ZWRfX2Ou3lwnAYEjq
 /x0BkrjXTEq+fZWdhfTUZvx0dkXnzbWq4PTRXrvFjE1sV0LSFqSKanO6A6OEoR0m13xE298hQ0j
 CW/mCRBSbKAaz/0kArkTc5Jtwol2DtntHxSQgV9sUoaC7t+VHPGXE6/vqY5dHWX9y9MBi7Jc5vt
 +wReSlQ5a+plYcy6ycDJopBEOUtTTPxziph6KHLTWUba7Jglld39o+57/+efMLm9znzP5hr89pG
 ztqNo6UR1e+5wGHvZu5IRACH/Bz55AnqsWYnvhdak4fgGuQJHINBaFsz/jP+UH6E7CiZb3RMjFU
 dwTcaWP2Gbcs1mx8CKlrX9u3jeRe1DBIcFzwSYX7IWWMb9iWC3zO7zKhOFtwf2DvAlOB9p0A/It
 UKuVIb3orLdKdkoRxKNUwHqWB5UkB3zMpp5CkjQPzjmd/ti2OyB6gsdLBccUDg6UeVkax3muuKt
 nucP+dYaQaYQMiRFmKg==
X-Proofpoint-ORIG-GUID: Cm-t3NK1pt6s23IAvB84zaLPlK7rZrgG
X-Proofpoint-GUID: Z32dTpnyulzny6wZAzPCvIJMKyTCuJgZ
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6108e cx=c_pps
 a=F1HhE1toGRAZ88wdd1wKFg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=uJr3N5FLDLMZiT7H3mwA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
Subject: Re:  [PATCH v2 015/110] nilfs2: use PRIino format for i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020164
X-Rspamd-Queue-Id: 7FF731E5B0C
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
	TAGGED_FROM(0.00)[bounces-79083-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hartkopp.net,gondor.apana.org.au,kernel.org,yaina.de,oracle.com,redhat.com,davemloft.net,paragon-software.com,szeredi.hu,canonical.com,gmail.com,fluxnic.net,intel.com,talpey.com,linux.alibaba.com,paul-moore.com,codewreck.org,linux.intel.com,fasheh.com,crudebyte.com,amd.com,zeniv.linux.org.uk,infradead.org,microsoft.com,holtmann.org,linaro.org,ffwll.ch,arm.com,suse.com,google.com,iogearbox.net,goodmis.org,vivo.com,dev.tdt.de,evilplan.org,mit.edu,cs.cmu.edu,omnibond.com,namei.org,dilger.ca,physik.fu-berlin.de,schaufler-ca.com,themaw.net,linux.dev,efficios.com,fomichev.me,huawei.com,artax.karlin.mff.cuni.cz,suse.de,samba.org,hallyn.com,alarsen.net,manguebit.org,dubeyko.com,ionkov.net,nod.at,auristor.com,brown.name,pengutronix.de,suse.cz,tyhicks.com,secunet.com,wdc.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjIzIC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Q29udmVydCBuaWxmczIgaV9pbm8gZm9ybWF0IHN0cmluZ3MgdG8gdXNlIHRoZSBQUklpbm8gZm9y
bWF0DQo+IG1hY3JvIGluIHByZXBhcmF0aW9uIGZvciB0aGUgd2lkZW5pbmcgb2YgaV9pbm8gdmlh
IGtpbm9fdC4NCj4gDQo+IEluIHRyYWNlIGV2ZW50cywgY2hhbmdlIF9fZmllbGQoaW5vX3QsIC4u
LikgdG8gX19maWVsZCh1NjQsIC4uLikNCj4gYW5kIHVwZGF0ZSBUUF9wcmludGsgZm9ybWF0IHN0
cmluZ3MgdG8gJWxsdS8lbGx4IHRvIG1hdGNoIHRoZQ0KPiB3aWRlbmVkIGZpZWxkIHR5cGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIGZzL25pbGZzMi9hbGxvYy5jICAgICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPiAg
ZnMvbmlsZnMyL2JtYXAuYyAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvbmlsZnMyL2J0bm9k
ZS5jICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvbmlsZnMyL2J0cmVlLmMgICAgICAgICAgICAg
fCAxMiArKysrKystLS0tLS0NCj4gIGZzL25pbGZzMi9kaXIuYyAgICAgICAgICAgICAgIHwgMTIg
KysrKysrLS0tLS0tDQo+ICBmcy9uaWxmczIvZGlyZWN0LmMgICAgICAgICAgICB8ICA0ICsrLS0N
Cj4gIGZzL25pbGZzMi9nY2lub2RlLmMgICAgICAgICAgIHwgIDIgKy0NCj4gIGZzL25pbGZzMi9p
bm9kZS5jICAgICAgICAgICAgIHwgIDggKysrKy0tLS0NCj4gIGZzL25pbGZzMi9tZHQuYyAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gIGZzL25pbGZzMi9uYW1laS5jICAgICAgICAgICAgIHwgIDIg
Ky0NCj4gIGZzL25pbGZzMi9zZWdtZW50LmMgICAgICAgICAgIHwgIDIgKy0NCj4gIGluY2x1ZGUv
dHJhY2UvZXZlbnRzL25pbGZzMi5oIHwgMTIgKysrKysrLS0tLS0tDQo+ICAxMiBmaWxlcyBjaGFu
Z2VkLCAzNSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uaWxmczIvYWxsb2MuYyBiL2ZzL25pbGZzMi9hbGxvYy5jDQo+IGluZGV4IGU3ZWViYjA0
ZjlhNDA4MGEzOWYxN2Q0MTIzZTU4ZWQ3ZGY2YjJmNGIuLmEzYzU1OWM4NmU1YTRjNjNiMWM5ZGQ0
Y2ExMzdmMjQ3NDljM2VlODcgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9hbGxvYy5jDQo+ICsr
KyBiL2ZzL25pbGZzMi9hbGxvYy5jDQo+IEBAIC03MDcsNyArNzA3LDcgQEAgdm9pZCBuaWxmc19w
YWxsb2NfY29tbWl0X2ZyZWVfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwNCj4gIA0KPiAgCWlm
ICghbmlsZnNfY2xlYXJfYml0X2F0b21pYyhsb2NrLCBncm91cF9vZmZzZXQsIGJpdG1hcCkpDQo+
ICAJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiJXMgKGlubz0lbHUpOiBlbnRy
eSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gKwkJCSAgICIlcyAoaW5vPSUiIFBSSWlu
byAidSk6IGVudHJ5IG51bWJlciAlbGx1IGFscmVhZHkgZnJlZWQiLA0KPiAgCQkJICAgX19mdW5j
X18sIGlub2RlLT5pX2lubywNCj4gIAkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpcmVxLT5wcl9l
bnRyeV9ucik7DQo+ICAJZWxzZQ0KPiBAQCAtNzQ4LDcgKzc0OCw3IEBAIHZvaWQgbmlsZnNfcGFs
bG9jX2Fib3J0X2FsbG9jX2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICANCj4gIAlpZiAo
IW5pbGZzX2NsZWFyX2JpdF9hdG9taWMobG9jaywgZ3JvdXBfb2Zmc2V0LCBiaXRtYXApKQ0KPiAg
CQluaWxmc193YXJuKGlub2RlLT5pX3NiLA0KPiAtCQkJICAgIiVzIChpbm89JWx1KTogZW50cnkg
bnVtYmVyICVsbHUgYWxyZWFkeSBmcmVlZCIsDQo+ICsJCQkgICAiJXMgKGlubz0lIiBQUklpbm8g
InUpOiBlbnRyeSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gIAkJCSAgIF9fZnVuY19f
LCBpbm9kZS0+aV9pbm8sDQo+ICAJCQkgICAodW5zaWduZWQgbG9uZyBsb25nKXJlcS0+cHJfZW50
cnlfbnIpOw0KPiAgCWVsc2UNCj4gQEAgLTg2MSw3ICs4NjEsNyBAQCBpbnQgbmlsZnNfcGFsbG9j
X2ZyZWV2KHN0cnVjdCBpbm9kZSAqaW5vZGUsIF9fdTY0ICplbnRyeV9ucnMsIHNpemVfdCBuaXRl
bXMpDQo+ICAJCQlpZiAoIW5pbGZzX2NsZWFyX2JpdF9hdG9taWMobG9jaywgZ3JvdXBfb2Zmc2V0
LA0KPiAgCQkJCQkJICAgIGJpdG1hcCkpIHsNCj4gIAkJCQluaWxmc193YXJuKGlub2RlLT5pX3Ni
LA0KPiAtCQkJCQkgICAiJXMgKGlubz0lbHUpOiBlbnRyeSBudW1iZXIgJWxsdSBhbHJlYWR5IGZy
ZWVkIiwNCj4gKwkJCQkJICAgIiVzIChpbm89JSIgUFJJaW5vICJ1KTogZW50cnkgbnVtYmVyICVs
bHUgYWxyZWFkeSBmcmVlZCIsDQo+ICAJCQkJCSAgIF9fZnVuY19fLCBpbm9kZS0+aV9pbm8sDQo+
ICAJCQkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpZW50cnlfbnJzW2pdKTsNCj4gIAkJCX0gZWxz
ZSB7DQo+IEBAIC05MDYsNyArOTA2LDcgQEAgaW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBfX3U2NCAqZW50cnlfbnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiAgCQkJCQkJ
CSAgICAgIGxhc3RfbnJzW2tdKTsNCj4gIAkJCWlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpDQo+
ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCQkJICAgImVycm9yICVkIGRlbGV0
aW5nIGJsb2NrIHRoYXQgb2JqZWN0IChlbnRyeT0lbGx1LCBpbm89JWx1KSBiZWxvbmdzIHRvIiwN
Cj4gKwkJCQkJICAgImVycm9yICVkIGRlbGV0aW5nIGJsb2NrIHRoYXQgb2JqZWN0IChlbnRyeT0l
bGx1LCBpbm89JSIgUFJJaW5vICJ1KSBiZWxvbmdzIHRvIiwNCj4gIAkJCQkJICAgcmV0LCAodW5z
aWduZWQgbG9uZyBsb25nKWxhc3RfbnJzW2tdLA0KPiAgCQkJCQkgICBpbm9kZS0+aV9pbm8pOw0K
PiAgCQl9DQo+IEBAIC05MjMsNyArOTIzLDcgQEAgaW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBfX3U2NCAqZW50cnlfbnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiAgCQkJ
cmV0ID0gbmlsZnNfcGFsbG9jX2RlbGV0ZV9iaXRtYXBfYmxvY2soaW5vZGUsIGdyb3VwKTsNCj4g
IAkJCWlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpDQo+ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+
aV9zYiwNCj4gLQkJCQkJICAgImVycm9yICVkIGRlbGV0aW5nIGJpdG1hcCBibG9jayBvZiBncm91
cD0lbHUsIGlubz0lbHUiLA0KPiArCQkJCQkgICAiZXJyb3IgJWQgZGVsZXRpbmcgYml0bWFwIGJs
b2NrIG9mIGdyb3VwPSVsdSwgaW5vPSUiIFBSSWlubyAidSIsDQo+ICAJCQkJCSAgIHJldCwgZ3Jv
dXAsIGlub2RlLT5pX2lubyk7DQo+ICAJCX0NCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxm
czIvYm1hcC5jIGIvZnMvbmlsZnMyL2JtYXAuYw0KPiBpbmRleCBjY2MxYTdhYTUyZDIwNjRkNTZi
ODI2MDU4NTU0MjY0YzQ5OGQ1OTJmLi5lMTI5NzliYWMzYzNlZTVlYjdmY2MyYmYxNTZmZTZlNDhm
YzY1YTdkIDEwMDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvYm1hcC5jDQo+ICsrKyBiL2ZzL25pbGZz
Mi9ibWFwLmMNCj4gQEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGludCBuaWxmc19ibWFwX2NvbnZl
cnRfZXJyb3Ioc3RydWN0IG5pbGZzX2JtYXAgKmJtYXAsDQo+ICANCj4gIAlpZiAoZXJyID09IC1F
SU5WQUwpIHsNCj4gIAkJX19uaWxmc19lcnJvcihpbm9kZS0+aV9zYiwgZm5hbWUsDQo+IC0JCQkg
ICAgICAiYnJva2VuIGJtYXAgKGlub2RlIG51bWJlcj0lbHUpIiwgaW5vZGUtPmlfaW5vKTsNCj4g
KwkJCSAgICAgICJicm9rZW4gYm1hcCAoaW5vZGUgbnVtYmVyPSUiIFBSSWlubyAidSkiLCBpbm9k
ZS0+aV9pbm8pOw0KPiAgCQllcnIgPSAtRUlPOw0KPiAgCX0NCj4gIAlyZXR1cm4gZXJyOw0KPiBk
aWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2J0bm9kZS5jIGIvZnMvbmlsZnMyL2J0bm9kZS5jDQo+IGlu
ZGV4IDU2ODM2NzEyOTA5MjAxNzc1OTA3NDgzODg3ZThhMDAyMjg1MWJiZWMuLjNkNjRmM2E5MjIz
ZTU2MDFkYzIzMzJhZTZlMTAwN2VkZDViNDgyN2IgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9i
dG5vZGUuYw0KPiArKysgYi9mcy9uaWxmczIvYnRub2RlLmMNCj4gQEAgLTY0LDcgKzY0LDcgQEAg
bmlsZnNfYnRub2RlX2NyZWF0ZV9ibG9jayhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqYnRuYywgX191
NjQgYmxvY2tucikNCj4gIAkJICogY2xlYXJpbmcgb2YgYW4gYWJhbmRvbmVkIGItdHJlZSBub2Rl
IGlzIG1pc3Npbmcgc29tZXdoZXJlKS4NCj4gIAkJICovDQo+ICAJCW5pbGZzX2Vycm9yKGlub2Rl
LT5pX3NiLA0KPiAtCQkJICAgICJzdGF0ZSBpbmNvbnNpc3RlbmN5IHByb2JhYmx5IGR1ZSB0byBk
dXBsaWNhdGUgdXNlIG9mIGItdHJlZSBub2RlIGJsb2NrIGFkZHJlc3MgJWxsdSAoaW5vPSVsdSki
LA0KPiArCQkJICAgICJzdGF0ZSBpbmNvbnNpc3RlbmN5IHByb2JhYmx5IGR1ZSB0byBkdXBsaWNh
dGUgdXNlIG9mIGItdHJlZSBub2RlIGJsb2NrIGFkZHJlc3MgJWxsdSAoaW5vPSUiIFBSSWlubyAi
dSkiLA0KPiAgCQkJICAgICh1bnNpZ25lZCBsb25nIGxvbmcpYmxvY2tuciwgaW5vZGUtPmlfaW5v
KTsNCj4gIAkJZ290byBmYWlsZWQ7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2J0
cmVlLmMgYi9mcy9uaWxmczIvYnRyZWUuYw0KPiBpbmRleCBkZDBjOGU1NjBlZjZhMmM5NjUxNTAy
NTMyMTkxNGUwZDczZjQxMTQ0Li41NzE2M2U5OTFmYmM0OWUyYmZiYTJmYTU0M2YxYjhkYmQ3Nzcx
OGY0IDEwMDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvYnRyZWUuYw0KPiArKysgYi9mcy9uaWxmczIv
YnRyZWUuYw0KPiBAQCAtMzUzLDcgKzM1Myw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfYnRyZWVfbm9k
ZV9icm9rZW4oY29uc3Qgc3RydWN0IG5pbGZzX2J0cmVlX25vZGUgKm5vZGUsDQo+ICAJCSAgICAg
bmNoaWxkcmVuIDw9IDAgfHwNCj4gIAkJICAgICBuY2hpbGRyZW4gPiBOSUxGU19CVFJFRV9OT0RF
X05DSElMRFJFTl9NQVgoc2l6ZSkpKSB7DQo+ICAJCW5pbGZzX2NyaXQoaW5vZGUtPmlfc2IsDQo+
IC0JCQkgICAiYmFkIGJ0cmVlIG5vZGUgKGlubz0lbHUsIGJsb2NrbnI9JWxsdSk6IGxldmVsID0g
JWQsIGZsYWdzID0gMHgleCwgbmNoaWxkcmVuID0gJWQiLA0KPiArCQkJICAgImJhZCBidHJlZSBu
b2RlIChpbm89JSIgUFJJaW5vICJ1LCBibG9ja25yPSVsbHUpOiBsZXZlbCA9ICVkLCBmbGFncyA9
IDB4JXgsIG5jaGlsZHJlbiA9ICVkIiwNCj4gIAkJCSAgIGlub2RlLT5pX2lubywgKHVuc2lnbmVk
IGxvbmcgbG9uZylibG9ja25yLCBsZXZlbCwNCj4gIAkJCSAgIGZsYWdzLCBuY2hpbGRyZW4pOw0K
PiAgCQlyZXQgPSAxOw0KPiBAQCAtMzg0LDcgKzM4NCw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfYnRy
ZWVfcm9vdF9icm9rZW4oY29uc3Qgc3RydWN0IG5pbGZzX2J0cmVlX25vZGUgKm5vZGUsDQo+ICAJ
CSAgICAgbmNoaWxkcmVuID4gTklMRlNfQlRSRUVfUk9PVF9OQ0hJTERSRU5fTUFYIHx8DQo+ICAJ
CSAgICAgKG5jaGlsZHJlbiA9PSAwICYmIGxldmVsID4gTklMRlNfQlRSRUVfTEVWRUxfTk9ERV9N
SU4pKSkgew0KPiAgCQluaWxmc19jcml0KGlub2RlLT5pX3NiLA0KPiAtCQkJICAgImJhZCBidHJl
ZSByb290IChpbm89JWx1KTogbGV2ZWwgPSAlZCwgZmxhZ3MgPSAweCV4LCBuY2hpbGRyZW4gPSAl
ZCIsDQo+ICsJCQkgICAiYmFkIGJ0cmVlIHJvb3QgKGlubz0lIiBQUklpbm8gInUpOiBsZXZlbCA9
ICVkLCBmbGFncyA9IDB4JXgsIG5jaGlsZHJlbiA9ICVkIiwNCj4gIAkJCSAgIGlub2RlLT5pX2lu
bywgbGV2ZWwsIGZsYWdzLCBuY2hpbGRyZW4pOw0KPiAgCQlyZXQgPSAxOw0KPiAgCX0NCj4gQEAg
LTQ1Myw3ICs0NTMsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2J0cmVlX2JhZF9ub2RlKGNvbnN0IHN0
cnVjdCBuaWxmc19ibWFwICpidHJlZSwNCj4gIAlpZiAodW5saWtlbHkobmlsZnNfYnRyZWVfbm9k
ZV9nZXRfbGV2ZWwobm9kZSkgIT0gbGV2ZWwpKSB7DQo+ICAJCWR1bXBfc3RhY2soKTsNCj4gIAkJ
bmlsZnNfY3JpdChidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCSAgICJidHJlZSBsZXZlbCBt
aXNtYXRjaCAoaW5vPSVsdSk6ICVkICE9ICVkIiwNCj4gKwkJCSAgICJidHJlZSBsZXZlbCBtaXNt
YXRjaCAoaW5vPSUiIFBSSWlubyAidSk6ICVkICE9ICVkIiwNCj4gIAkJCSAgIGJ0cmVlLT5iX2lu
b2RlLT5pX2lubywNCj4gIAkJCSAgIG5pbGZzX2J0cmVlX25vZGVfZ2V0X2xldmVsKG5vZGUpLCBs
ZXZlbCk7DQo+ICAJCXJldHVybiAxOw0KPiBAQCAtNTIxLDcgKzUyMSw3IEBAIHN0YXRpYyBpbnQg
X19uaWxmc19idHJlZV9nZXRfYmxvY2soY29uc3Qgc3RydWN0IG5pbGZzX2JtYXAgKmJ0cmVlLCBf
X3U2NCBwdHIsDQo+ICAgb3V0X25vX3dhaXQ6DQo+ICAJaWYgKCFidWZmZXJfdXB0b2RhdGUoYmgp
KSB7DQo+ICAJCW5pbGZzX2VycihidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCSAgIkkvTyBl
cnJvciByZWFkaW5nIGItdHJlZSBub2RlIGJsb2NrIChpbm89JWx1LCBibG9ja25yPSVsbHUpIiwN
Cj4gKwkJCSAgIkkvTyBlcnJvciByZWFkaW5nIGItdHJlZSBub2RlIGJsb2NrIChpbm89JSIgUFJJ
aW5vICJ1LCBibG9ja25yPSVsbHUpIiwNCj4gIAkJCSAgYnRyZWUtPmJfaW5vZGUtPmlfaW5vLCAo
dW5zaWduZWQgbG9uZyBsb25nKXB0cik7DQo+ICAJCWJyZWxzZShiaCk7DQo+ICAJCXJldHVybiAt
RUlPOw0KPiBAQCAtMjEwNCw3ICsyMTA0LDcgQEAgc3RhdGljIGludCBuaWxmc19idHJlZV9wcm9w
YWdhdGUoc3RydWN0IG5pbGZzX2JtYXAgKmJ0cmVlLA0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJ
CWlmICh1bmxpa2VseShyZXQgPT0gLUVOT0VOVCkpIHsNCj4gIAkJCW5pbGZzX2NyaXQoYnRyZWUt
PmJfaW5vZGUtPmlfc2IsDQo+IC0JCQkJICAgIndyaXRpbmcgbm9kZS9sZWFmIGJsb2NrIGRvZXMg
bm90IGFwcGVhciBpbiBiLXRyZWUgKGlubz0lbHUpIGF0IGtleT0lbGx1LCBsZXZlbD0lZCIsDQo+
ICsJCQkJICAgIndyaXRpbmcgbm9kZS9sZWFmIGJsb2NrIGRvZXMgbm90IGFwcGVhciBpbiBiLXRy
ZWUgKGlubz0lIiBQUklpbm8gInUpIGF0IGtleT0lbGx1LCBsZXZlbD0lZCIsDQo+ICAJCQkJICAg
YnRyZWUtPmJfaW5vZGUtPmlfaW5vLA0KPiAgCQkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpa2V5
LCBsZXZlbCk7DQo+ICAJCQlyZXQgPSAtRUlOVkFMOw0KPiBAQCAtMjE0Niw3ICsyMTQ2LDcgQEAg
c3RhdGljIHZvaWQgbmlsZnNfYnRyZWVfYWRkX2RpcnR5X2J1ZmZlcihzdHJ1Y3QgbmlsZnNfYm1h
cCAqYnRyZWUsDQo+ICAJICAgIGxldmVsID49IE5JTEZTX0JUUkVFX0xFVkVMX01BWCkgew0KPiAg
CQlkdW1wX3N0YWNrKCk7DQo+ICAJCW5pbGZzX3dhcm4oYnRyZWUtPmJfaW5vZGUtPmlfc2IsDQo+
IC0JCQkgICAiaW52YWxpZCBidHJlZSBsZXZlbDogJWQgKGtleT0lbGx1LCBpbm89JWx1LCBibG9j
a25yPSVsbHUpIiwNCj4gKwkJCSAgICJpbnZhbGlkIGJ0cmVlIGxldmVsOiAlZCAoa2V5PSVsbHUs
IGlubz0lIiBQUklpbm8gInUsIGJsb2NrbnI9JWxsdSkiLA0KPiAgCQkJICAgbGV2ZWwsICh1bnNp
Z25lZCBsb25nIGxvbmcpa2V5LA0KPiAgCQkJICAgYnRyZWUtPmJfaW5vZGUtPmlfaW5vLA0KPiAg
CQkJICAgKHVuc2lnbmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yKTsNCj4gZGlmZiAtLWdpdCBh
L2ZzL25pbGZzMi9kaXIuYyBiL2ZzL25pbGZzMi9kaXIuYw0KPiBpbmRleCBiMjQzMTk5MDM2ZGZh
MWFiMjI5OWVmYWFhNWJkZjVkYTJkMTU5ZmYyLi5iMTgyZGEwNzZjNThjNDgxMzE0NWJjM2U1MDFh
MWU5YTE4OGJjZTg1IDEwMDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvZGlyLmMNCj4gKysrIGIvZnMv
bmlsZnMyL2Rpci5jDQo+IEBAIC0xNTAsNyArMTUwLDcgQEAgc3RhdGljIGJvb2wgbmlsZnNfY2hl
Y2tfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywgY2hhciAqa2FkZHIpDQo+ICANCj4gIEViYWRz
aXplOg0KPiAgCW5pbGZzX2Vycm9yKHNiLA0KPiAtCQkgICAgInNpemUgb2YgZGlyZWN0b3J5ICMl
bHUgaXMgbm90IGEgbXVsdGlwbGUgb2YgY2h1bmsgc2l6ZSIsDQo+ICsJCSAgICAic2l6ZSBvZiBk
aXJlY3RvcnkgIyUiIFBSSWlubyAidSBpcyBub3QgYSBtdWx0aXBsZSBvZiBjaHVuayBzaXplIiwN
Cj4gIAkJICAgIGRpci0+aV9pbm8pOw0KPiAgCWdvdG8gZmFpbDsNCj4gIEVzaG9ydDoNCj4gQEAg
LTE2OSw3ICsxNjksNyBAQCBzdGF0aWMgYm9vbCBuaWxmc19jaGVja19mb2xpbyhzdHJ1Y3QgZm9s
aW8gKmZvbGlvLCBjaGFyICprYWRkcikNCj4gIAllcnJvciA9ICJkaXNhbGxvd2VkIGlub2RlIG51
bWJlciI7DQo+ICBiYWRfZW50cnk6DQo+ICAJbmlsZnNfZXJyb3Ioc2IsDQo+IC0JCSAgICAiYmFk
IGVudHJ5IGluIGRpcmVjdG9yeSAjJWx1OiAlcyAtIG9mZnNldD0lbHUsIGlub2RlPSVsdSwgcmVj
X2xlbj0lemQsIG5hbWVfbGVuPSVkIiwNCj4gKwkJICAgICJiYWQgZW50cnkgaW4gZGlyZWN0b3J5
ICMlIiBQUklpbm8gInU6ICVzIC0gb2Zmc2V0PSVsdSwgaW5vZGU9JWx1LCByZWNfbGVuPSV6ZCwg
bmFtZV9sZW49JWQiLA0KPiAgCQkgICAgZGlyLT5pX2lubywgZXJyb3IsIChmb2xpby0+aW5kZXgg
PDwgUEFHRV9TSElGVCkgKyBvZmZzLA0KPiAgCQkgICAgKHVuc2lnbmVkIGxvbmcpbGU2NF90b19j
cHUocC0+aW5vZGUpLA0KPiAgCQkgICAgcmVjX2xlbiwgcC0+bmFtZV9sZW4pOw0KPiBAQCAtMTc3
LDcgKzE3Nyw3IEBAIHN0YXRpYyBib29sIG5pbGZzX2NoZWNrX2ZvbGlvKHN0cnVjdCBmb2xpbyAq
Zm9saW8sIGNoYXIgKmthZGRyKQ0KPiAgRWVuZDoNCj4gIAlwID0gKHN0cnVjdCBuaWxmc19kaXJf
ZW50cnkgKikoa2FkZHIgKyBvZmZzKTsNCj4gIAluaWxmc19lcnJvcihzYiwNCj4gLQkJICAgICJl
bnRyeSBpbiBkaXJlY3RvcnkgIyVsdSBzcGFucyB0aGUgcGFnZSBib3VuZGFyeSBvZmZzZXQ9JWx1
LCBpbm9kZT0lbHUiLA0KPiArCQkgICAgImVudHJ5IGluIGRpcmVjdG9yeSAjJSIgUFJJaW5vICJ1
IHNwYW5zIHRoZSBwYWdlIGJvdW5kYXJ5IG9mZnNldD0lbHUsIGlub2RlPSVsdSIsDQo+ICAJCSAg
ICBkaXItPmlfaW5vLCAoZm9saW8tPmluZGV4IDw8IFBBR0VfU0hJRlQpICsgb2ZmcywNCj4gIAkJ
ICAgICh1bnNpZ25lZCBsb25nKWxlNjRfdG9fY3B1KHAtPmlub2RlKSk7DQo+ICBmYWlsOg0KPiBA
QCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfcmVhZGRpcihzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+ICANCj4gIAkJa2FkZHIgPSBuaWxmc19n
ZXRfZm9saW8oaW5vZGUsIG4sICZmb2xpbyk7DQo+ICAJCWlmIChJU19FUlIoa2FkZHIpKSB7DQo+
IC0JCQluaWxmc19lcnJvcihzYiwgImJhZCBwYWdlIGluICMlbHUiLCBpbm9kZS0+aV9pbm8pOw0K
PiArCQkJbmlsZnNfZXJyb3Ioc2IsICJiYWQgcGFnZSBpbiAjJSIgUFJJaW5vICJ1IiwgaW5vZGUt
PmlfaW5vKTsNCj4gIAkJCWN0eC0+cG9zICs9IFBBR0VfU0laRSAtIG9mZnNldDsNCj4gIAkJCXJl
dHVybiAtRUlPOw0KPiAgCQl9DQo+IEBAIC0zMzYsNyArMzM2LDcgQEAgc3RydWN0IG5pbGZzX2Rp
cl9lbnRyeSAqbmlsZnNfZmluZF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gIAkJLyogbmV4
dCBmb2xpbyBpcyBwYXN0IHRoZSBibG9ja3Mgd2UndmUgZ290ICovDQo+ICAJCWlmICh1bmxpa2Vs
eShuID4gKGRpci0+aV9ibG9ja3MgPj4gKFBBR0VfU0hJRlQgLSA5KSkpKSB7DQo+ICAJCQluaWxm
c19lcnJvcihkaXItPmlfc2IsDQo+IC0JCQkgICAgICAgImRpciAlbHUgc2l6ZSAlbGxkIGV4Y2Vl
ZHMgYmxvY2sgY291bnQgJWxsdSIsDQo+ICsJCQkgICAgICAgImRpciAlIiBQUklpbm8gInUgc2l6
ZSAlbGxkIGV4Y2VlZHMgYmxvY2sgY291bnQgJWxsdSIsDQo+ICAJCQkgICAgICAgZGlyLT5pX2lu
bywgZGlyLT5pX3NpemUsDQo+ICAJCQkgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZylkaXItPmlf
YmxvY2tzKTsNCj4gIAkJCWdvdG8gb3V0Ow0KPiBAQCAtMzgyLDcgKzM4Miw3IEBAIHN0cnVjdCBu
aWxmc19kaXJfZW50cnkgKm5pbGZzX2RvdGRvdChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGZv
bGlvICoqZm9saW9wKQ0KPiAgCXJldHVybiBuZXh0X2RlOw0KPiAgDQo+ICBmYWlsOg0KPiAtCW5p
bGZzX2Vycm9yKGRpci0+aV9zYiwgImRpcmVjdG9yeSAjJWx1ICVzIiwgZGlyLT5pX2lubywgbXNn
KTsNCj4gKwluaWxmc19lcnJvcihkaXItPmlfc2IsICJkaXJlY3RvcnkgIyUiIFBSSWlubyAidSAl
cyIsIGRpci0+aV9pbm8sIG1zZyk7DQo+ICAJZm9saW9fcmVsZWFzZV9rbWFwKGZvbGlvLCBkZSk7
DQo+ICAJcmV0dXJuIE5VTEw7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvZGlyZWN0
LmMgYi9mcy9uaWxmczIvZGlyZWN0LmMNCj4gaW5kZXggMmQ4ZGM2YjM1YjU0Nzc5NDdjYTEyYTcw
Mjg4ZDNhM2NjZTg1OGFhYi4uMTA4NGQ0ZDU4NmUwNzhhYjY4MjUxNjc5NzZkZDJhNzFkNTJiYzhh
YSAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2RpcmVjdC5jDQo+ICsrKyBiL2ZzL25pbGZzMi9k
aXJlY3QuYw0KPiBAQCAtMzM4LDcgKzMzOCw3IEBAIHN0YXRpYyBpbnQgbmlsZnNfZGlyZWN0X2Fz
c2lnbihzdHJ1Y3QgbmlsZnNfYm1hcCAqYm1hcCwNCj4gIAlrZXkgPSBuaWxmc19ibWFwX2RhdGFf
Z2V0X2tleShibWFwLCAqYmgpOw0KPiAgCWlmICh1bmxpa2VseShrZXkgPiBOSUxGU19ESVJFQ1Rf
S0VZX01BWCkpIHsNCj4gIAkJbmlsZnNfY3JpdChibWFwLT5iX2lub2RlLT5pX3NiLA0KPiAtCQkJ
ICAgIiVzIChpbm89JWx1KTogaW52YWxpZCBrZXk6ICVsbHUiLA0KPiArCQkJICAgIiVzIChpbm89
JSIgUFJJaW5vICJ1KTogaW52YWxpZCBrZXk6ICVsbHUiLA0KPiAgCQkJICAgX19mdW5jX18sDQo+
ICAJCQkgICBibWFwLT5iX2lub2RlLT5pX2lubywgKHVuc2lnbmVkIGxvbmcgbG9uZylrZXkpOw0K
PiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTM0Niw3ICszNDYsNyBAQCBzdGF0aWMgaW50IG5p
bGZzX2RpcmVjdF9hc3NpZ24oc3RydWN0IG5pbGZzX2JtYXAgKmJtYXAsDQo+ICAJcHRyID0gbmls
ZnNfZGlyZWN0X2dldF9wdHIoYm1hcCwga2V5KTsNCj4gIAlpZiAodW5saWtlbHkocHRyID09IE5J
TEZTX0JNQVBfSU5WQUxJRF9QVFIpKSB7DQo+ICAJCW5pbGZzX2NyaXQoYm1hcC0+Yl9pbm9kZS0+
aV9zYiwNCj4gLQkJCSAgICIlcyAoaW5vPSVsdSk6IGludmFsaWQgcG9pbnRlcjogJWxsdSIsDQo+
ICsJCQkgICAiJXMgKGlubz0lIiBQUklpbm8gInUpOiBpbnZhbGlkIHBvaW50ZXI6ICVsbHUiLA0K
PiAgCQkJICAgX19mdW5jX18sDQo+ICAJCQkgICBibWFwLT5iX2lub2RlLT5pX2lubywgKHVuc2ln
bmVkIGxvbmcgbG9uZylwdHIpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gZGlmZiAtLWdpdCBh
L2ZzL25pbGZzMi9nY2lub2RlLmMgYi9mcy9uaWxmczIvZ2Npbm9kZS5jDQo+IGluZGV4IDU2MWMy
MjA3OTljN2FlZTg3OWFkODY2ODY1ZTM3Nzc5OWM4ZWU2YmIuLjcxNDk2MmQwMTBkYTRhMjNlOWI1
ZjQwZGU4YWFhY2E4Yjk1YTc0ZGEgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9nY2lub2RlLmMN
Cj4gKysrIGIvZnMvbmlsZnMyL2djaW5vZGUuYw0KPiBAQCAtMTM3LDcgKzEzNyw3IEBAIGludCBu
aWxmc19nY2NhY2hlX3dhaXRfYW5kX21hcmtfZGlydHkoc3RydWN0IGJ1ZmZlcl9oZWFkICpiaCkN
Cj4gIAkJc3RydWN0IGlub2RlICppbm9kZSA9IGJoLT5iX2ZvbGlvLT5tYXBwaW5nLT5ob3N0Ow0K
PiAgDQo+ICAJCW5pbGZzX2Vycihpbm9kZS0+aV9zYiwNCj4gLQkJCSAgIkkvTyBlcnJvciByZWFk
aW5nICVzIGJsb2NrIGZvciBHQyAoaW5vPSVsdSwgdmJsb2NrbnI9JWxsdSkiLA0KPiArCQkJICAi
SS9PIGVycm9yIHJlYWRpbmcgJXMgYmxvY2sgZm9yIEdDIChpbm89JSIgUFJJaW5vICJ1LCB2Ymxv
Y2tucj0lbGx1KSIsDQo+ICAJCQkgIGJ1ZmZlcl9uaWxmc19ub2RlKGJoKSA/ICJub2RlIiA6ICJk
YXRhIiwNCj4gIAkJCSAgaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9uZyBsb25nKWJoLT5iX2Js
b2NrbnIpOw0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9pbm9k
ZS5jIGIvZnMvbmlsZnMyL2lub2RlLmMNCj4gaW5kZXggNTFiZGU0NWQ1ODY1MDlkZGEzZWYwY2I3
YzQ2ZmFjYjdmYjJjNjFkZC4uMGJjMWM1MTQxZWM1OTZiM2MzMWU3ZDE4ZTRiYTM1NDFiZjYxODQw
NiAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2lub2RlLmMNCj4gKysrIGIvZnMvbmlsZnMyL2lu
b2RlLmMNCj4gQEAgLTEwOCw3ICsxMDgsNyBAQCBpbnQgbmlsZnNfZ2V0X2Jsb2NrKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHNlY3Rvcl90IGJsa29mZiwNCj4gIAkJCQkgKiBiZSBsb2NrZWQgaW4gdGhp
cyBjYXNlLg0KPiAgCQkJCSAqLw0KPiAgCQkJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0J
CQkJCSAgICIlcyAoaW5vPSVsdSk6IGEgcmFjZSBjb25kaXRpb24gd2hpbGUgaW5zZXJ0aW5nIGEg
ZGF0YSBibG9jayBhdCBvZmZzZXQ9JWxsdSIsDQo+ICsJCQkJCSAgICIlcyAoaW5vPSUiIFBSSWlu
byAidSk6IGEgcmFjZSBjb25kaXRpb24gd2hpbGUgaW5zZXJ0aW5nIGEgZGF0YSBibG9jayBhdCBv
ZmZzZXQ9JWxsdSIsDQo+ICAJCQkJCSAgIF9fZnVuY19fLCBpbm9kZS0+aV9pbm8sDQo+ICAJCQkJ
CSAgICh1bnNpZ25lZCBsb25nIGxvbmcpYmxrb2ZmKTsNCj4gIAkJCQllcnIgPSAtRUFHQUlOOw0K
PiBAQCAtNzg5LDcgKzc4OSw3IEBAIHN0YXRpYyB2b2lkIG5pbGZzX3RydW5jYXRlX2JtYXAoc3Ry
dWN0IG5pbGZzX2lub2RlX2luZm8gKmlpLA0KPiAgCQlnb3RvIHJlcGVhdDsNCj4gIA0KPiAgZmFp
bGVkOg0KPiAtCW5pbGZzX3dhcm4oaWktPnZmc19pbm9kZS5pX3NiLCAiZXJyb3IgJWQgdHJ1bmNh
dGluZyBibWFwIChpbm89JWx1KSIsDQo+ICsJbmlsZnNfd2FybihpaS0+dmZzX2lub2RlLmlfc2Is
ICJlcnJvciAlZCB0cnVuY2F0aW5nIGJtYXAgKGlubz0lIiBQUklpbm8gInUpIiwNCj4gIAkJICAg
cmV0LCBpaS0+dmZzX2lub2RlLmlfaW5vKTsNCj4gIH0NCj4gIA0KPiBAQCAtMTAyNiw3ICsxMDI2
LDcgQEAgaW50IG5pbGZzX3NldF9maWxlX2RpcnR5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2ln
bmVkIGludCBucl9kaXJ0eSkNCj4gIAkJCSAqIHRoaXMgaW5vZGUuDQo+ICAJCQkgKi8NCj4gIAkJ
CW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkJICAgImNhbm5vdCBzZXQgZmlsZSBkaXJ0
eSAoaW5vPSVsdSk6IHRoZSBmaWxlIGlzIGJlaW5nIGZyZWVkIiwNCj4gKwkJCQkgICAiY2Fubm90
IHNldCBmaWxlIGRpcnR5IChpbm89JSIgUFJJaW5vICJ1KTogdGhlIGZpbGUgaXMgYmVpbmcgZnJl
ZWQiLA0KPiAgCQkJCSAgIGlub2RlLT5pX2lubyk7DQo+ICAJCQlzcGluX3VubG9jaygmbmlsZnMt
Pm5zX2lub2RlX2xvY2spOw0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7IC8qDQo+IEBAIC0xMDU3LDcg
KzEwNTcsNyBAQCBpbnQgX19uaWxmc19tYXJrX2lub2RlX2RpcnR5KHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIGludCBmbGFncykNCj4gIAllcnIgPSBuaWxmc19sb2FkX2lub2RlX2Jsb2NrKGlub2RlLCAm
aWJoKTsNCj4gIAlpZiAodW5saWtlbHkoZXJyKSkgew0KPiAgCQluaWxmc193YXJuKGlub2RlLT5p
X3NiLA0KPiAtCQkJICAgImNhbm5vdCBtYXJrIGlub2RlIGRpcnR5IChpbm89JWx1KTogZXJyb3Ig
JWQgbG9hZGluZyBpbm9kZSBibG9jayIsDQo+ICsJCQkgICAiY2Fubm90IG1hcmsgaW5vZGUgZGly
dHkgKGlubz0lIiBQUklpbm8gInUpOiBlcnJvciAlZCBsb2FkaW5nIGlub2RlIGJsb2NrIiwNCj4g
IAkJCSAgIGlub2RlLT5pX2lubywgZXJyKTsNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9DQo+IGRp
ZmYgLS1naXQgYS9mcy9uaWxmczIvbWR0LmMgYi9mcy9uaWxmczIvbWR0LmMNCj4gaW5kZXggOTQ2
YjBkMzUzNGE1ZjIyZjM0YWM0NGE5MWZiMTIxNTQxODgxYzU0OC4uODYyOWM3MmI2MmRiMzMyMTdk
NDc0NzEyNDg4NWI2ZjcyN2YxODJiZSAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL21kdC5jDQo+
ICsrKyBiL2ZzL25pbGZzMi9tZHQuYw0KPiBAQCAtMjAzLDcgKzIwMyw3IEBAIHN0YXRpYyBpbnQg
bmlsZnNfbWR0X3JlYWRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgbG9uZyBi
bG9jaywNCj4gIAllcnIgPSAtRUlPOw0KPiAgCWlmICghYnVmZmVyX3VwdG9kYXRlKGZpcnN0X2Jo
KSkgew0KPiAgCQluaWxmc19lcnIoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICJJL08gZXJyb3IgcmVh
ZGluZyBtZXRhLWRhdGEgZmlsZSAoaW5vPSVsdSwgYmxvY2stb2Zmc2V0PSVsdSkiLA0KPiArCQkJ
ICAiSS9PIGVycm9yIHJlYWRpbmcgbWV0YS1kYXRhIGZpbGUgKGlubz0lIiBQUklpbm8gInUsIGJs
b2NrLW9mZnNldD0lbHUpIiwNCj4gIAkJCSAgaW5vZGUtPmlfaW5vLCBibG9jayk7DQo+ICAJCWdv
dG8gZmFpbGVkX2JoOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9uYW1laS5jIGIv
ZnMvbmlsZnMyL25hbWVpLmMNCj4gaW5kZXggNDBmNGIxYTI4NzA1YjZlMGViOGYwOTc4Y2YzYWMx
OGI0M2FhMTMzMS4uMjllZGI4NGEwNjYzY2FhNGIyOWZhNDg4YzA0OTVmYzUzMzU4Y2EwMCAxMDA2
NDQNCj4gLS0tIGEvZnMvbmlsZnMyL25hbWVpLmMNCj4gKysrIGIvZnMvbmlsZnMyL25hbWVpLmMN
Cj4gQEAgLTI5Miw3ICsyOTIsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2RvX3VubGluayhzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPiAgDQo+ICAJaWYgKCFpbm9kZS0+
aV9ubGluaykgew0KPiAgCQluaWxmc193YXJuKGlub2RlLT5pX3NiLA0KPiAtCQkJICAgImRlbGV0
aW5nIG5vbmV4aXN0ZW50IGZpbGUgKGlubz0lbHUpLCAlZCIsDQo+ICsJCQkgICAiZGVsZXRpbmcg
bm9uZXhpc3RlbnQgZmlsZSAoaW5vPSUiIFBSSWlubyAidSksICVkIiwNCj4gIAkJCSAgIGlub2Rl
LT5pX2lubywgaW5vZGUtPmlfbmxpbmspOw0KPiAgCQlzZXRfbmxpbmsoaW5vZGUsIDEpOw0KPiAg
CX0NCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9zZWdtZW50LmMgYi9mcy9uaWxmczIvc2VnbWVu
dC5jDQo+IGluZGV4IDA5OGEzYmQxMDNlMDRjZDA5YjA2ODlmZTIwMTczODBkNzQ2NjQ0OTYuLjlh
OGJjM2ZhMzVjZTliNDQ3YWJiYzJmYjU2Y2JkMmIwY2M1Zjc2ZGUgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25pbGZzMi9zZWdtZW50LmMNCj4gKysrIGIvZnMvbmlsZnMyL3NlZ21lbnQuYw0KPiBAQCAtMjAy
NCw3ICsyMDI0LDcgQEAgc3RhdGljIGludCBuaWxmc19zZWdjdG9yX2NvbGxlY3RfZGlydHlfZmls
ZXMoc3RydWN0IG5pbGZzX3NjX2luZm8gKnNjaSwNCj4gIAkJCQlpZmlsZSwgaWktPnZmc19pbm9k
ZS5pX2lubywgJmliaCk7DQo+ICAJCQlpZiAodW5saWtlbHkoZXJyKSkgew0KPiAgCQkJCW5pbGZz
X3dhcm4oc2NpLT5zY19zdXBlciwNCj4gLQkJCQkJICAgImxvZyB3cml0ZXI6IGVycm9yICVkIGdl
dHRpbmcgaW5vZGUgYmxvY2sgKGlubz0lbHUpIiwNCj4gKwkJCQkJICAgImxvZyB3cml0ZXI6IGVy
cm9yICVkIGdldHRpbmcgaW5vZGUgYmxvY2sgKGlubz0lIiBQUklpbm8gInUpIiwNCj4gIAkJCQkJ
ICAgZXJyLCBpaS0+dmZzX2lub2RlLmlfaW5vKTsNCj4gIAkJCQlyZXR1cm4gZXJyOw0KPiAgCQkJ
fQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvbmlsZnMyLmggYi9pbmNsdWRl
L3RyYWNlL2V2ZW50cy9uaWxmczIuaA0KPiBpbmRleCA4ODgwYzExNzMzZGQzMDdjMjIzY2M2MmVl
MzRlYmVmZjY1MGVjYjEyLi44NmEwMDExYzllZWFmMDMxY2ZhMGI3OTg3NWIyYjEwNmVmOGI3Y2Zk
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9uaWxmczIuaA0KPiArKysgYi9p
bmNsdWRlL3RyYWNlL2V2ZW50cy9uaWxmczIuaA0KPiBAQCAtMTY1LDE0ICsxNjUsMTQgQEAgVFJB
Q0VfRVZFTlQobmlsZnMyX3NlZ21lbnRfdXNhZ2VfZnJlZWQsDQo+ICANCj4gIFRSQUNFX0VWRU5U
KG5pbGZzMl9tZHRfaW5zZXJ0X25ld19ibG9jaywNCj4gIAkgICAgVFBfUFJPVE8oc3RydWN0IGlu
b2RlICppbm9kZSwNCj4gLQkJICAgICB1bnNpZ25lZCBsb25nIGlubywNCj4gKwkJICAgICB1NjQg
aW5vLA0KPiAgCQkgICAgIHVuc2lnbmVkIGxvbmcgYmxvY2spLA0KPiAgDQo+ICAJICAgIFRQX0FS
R1MoaW5vZGUsIGlubywgYmxvY2spLA0KPiAgDQo+ICAJICAgIFRQX1NUUlVDVF9fZW50cnkoDQo+
ICAJCSAgICBfX2ZpZWxkKHN0cnVjdCBpbm9kZSAqLCBpbm9kZSkNCj4gLQkJICAgIF9fZmllbGQo
dW5zaWduZWQgbG9uZywgaW5vKQ0KPiArCQkgICAgX19maWVsZCh1NjQsIGlubykNCj4gIAkJICAg
IF9fZmllbGQodW5zaWduZWQgbG9uZywgYmxvY2spDQo+ICAJICAgICksDQo+ICANCj4gQEAgLTE4
Miw3ICsxODIsNyBAQCBUUkFDRV9FVkVOVChuaWxmczJfbWR0X2luc2VydF9uZXdfYmxvY2ssDQo+
ICAJCSAgICBfX2VudHJ5LT5ibG9jayA9IGJsb2NrOw0KPiAgCQkgICAgKSwNCj4gIA0KPiAtCSAg
ICBUUF9wcmludGsoImlub2RlID0gJXAgaW5vID0gJWx1IGJsb2NrID0gJWx1IiwNCj4gKwkgICAg
VFBfcHJpbnRrKCJpbm9kZSA9ICVwIGlubyA9ICVsbHUgYmxvY2sgPSAlbHUiLA0KPiAgCQkgICAg
ICBfX2VudHJ5LT5pbm9kZSwNCj4gIAkJICAgICAgX19lbnRyeS0+aW5vLA0KPiAgCQkgICAgICBf
X2VudHJ5LT5ibG9jaykNCj4gQEAgLTE5MCw3ICsxOTAsNyBAQCBUUkFDRV9FVkVOVChuaWxmczJf
bWR0X2luc2VydF9uZXdfYmxvY2ssDQo+ICANCj4gIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfc3Vi
bWl0X2Jsb2NrLA0KPiAgCSAgICBUUF9QUk9UTyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAtCQkg
ICAgIHVuc2lnbmVkIGxvbmcgaW5vLA0KPiArCQkgICAgIHU2NCBpbm8sDQo+ICAJCSAgICAgdW5z
aWduZWQgbG9uZyBibGtvZmYsDQo+ICAJCSAgICAgZW51bSByZXFfb3AgbW9kZSksDQo+ICANCj4g
QEAgLTE5OCw3ICsxOTgsNyBAQCBUUkFDRV9FVkVOVChuaWxmczJfbWR0X3N1Ym1pdF9ibG9jaywN
Cj4gIA0KPiAgCSAgICBUUF9TVFJVQ1RfX2VudHJ5KA0KPiAgCQkgICAgX19maWVsZChzdHJ1Y3Qg
aW5vZGUgKiwgaW5vZGUpDQo+IC0JCSAgICBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcsIGlubykNCj4g
KwkJICAgIF9fZmllbGQodTY0LCBpbm8pDQo+ICAJCSAgICBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcs
IGJsa29mZikNCj4gIAkJICAgIC8qDQo+ICAJCSAgICAgKiBVc2UgZmllbGRfc3RydWN0KCkgdG8g
YXZvaWQgaXNfc2lnbmVkX3R5cGUoKSBvbiB0aGUNCj4gQEAgLTIxNCw3ICsyMTQsNyBAQCBUUkFD
RV9FVkVOVChuaWxmczJfbWR0X3N1Ym1pdF9ibG9jaywNCj4gIAkJICAgIF9fZW50cnktPm1vZGUg
PSBtb2RlOw0KPiAgCQkgICAgKSwNCj4gIA0KPiAtCSAgICBUUF9wcmludGsoImlub2RlID0gJXAg
aW5vID0gJWx1IGJsa29mZiA9ICVsdSBtb2RlID0gJXgiLA0KPiArCSAgICBUUF9wcmludGsoImlu
b2RlID0gJXAgaW5vID0gJWxsdSBibGtvZmYgPSAlbHUgbW9kZSA9ICV4IiwNCj4gIAkJICAgICAg
X19lbnRyeS0+aW5vZGUsDQo+ICAJCSAgICAgIF9fZW50cnktPmlubywNCj4gIAkJICAgICAgX19l
bnRyeS0+Ymxrb2ZmLA0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBk
dWJleWtvLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

