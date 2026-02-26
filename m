Return-Path: <linux-fsdevel+bounces-78628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIQeM9GkoGlulQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:53:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9391AEBBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE13830097C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62F4657C8;
	Thu, 26 Feb 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnVe2h66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB7374173;
	Thu, 26 Feb 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135264; cv=fail; b=fwoTYQQP2b7+lWMFHkH79NL60Zamxd2vtgx3LblWZoLTw9LGM7bcfJCzCp0hr5Zg8XJilSDgsbglOevGfHwQgOhRL59MOYjJRHuihLgcuTuaaZHTrDyUsXOtf9bV3cXSCZJsZgJ9OVzjOGTKVDUGjHOl07330cslQM5FFYaRaQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135264; c=relaxed/simple;
	bh=BwZnsWLXjqxHVojbCUwCraTX9fFdw+qOsuTst5rUlG0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IqlJeVseUg/SRmZjg/keEgZugPXNpncqi5EZte2/nj35M7pVLaLmvxfeX+1tpYtbG/IEzo/ncsCbSPsVMLwLlKB6s1BD/+K955g/mt4rc4j7MrZSwn0+UCSMa6lNfn9jRMViXdaph+Q5NW7TpTizT+Jx1vsg2BWLWuHj7O7cKug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qnVe2h66; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDRu4H2347359;
	Thu, 26 Feb 2026 19:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=BwZnsWLXjqxHVojbCUwCraTX9fFdw+qOsuTst5rUlG0=; b=qnVe2h66
	1SoSN3GL47KeJ/fnH5UAl67+3UoXaJ5pzIX0btXNyPjbhom/nyilUmIS3uNX3ydD
	ZCR3rsnGljAkQhRxNnMnNhBVZSCeoVQnvB2H6CivNuXFOvu8vK08CXGeBzRaOLmi
	lqhl9T95SgBv73WVAtKtd0/tfkavkQyh39qYhZMeFzy10Kp/607ViYL56lCJX/AZ
	wIQyJRUFOKjaxGOA4QPEonp8uciULaNqyOAI1pVFPJl1Jpsqg/NCQIfkPCZ32SY0
	l15mjqDKVzUDgp0JzqQ4hVnxHJbPi4sI/Slu2xNePCTi/+dG9QHeIlGXZv1d0/T7
	dudfWz6/H9AkNQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858x463-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:46:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJCVkfj+DicZ/pU9iXDGWzYIX8GYrcmyoH0MO4Gf/onM7WpMnyDaJ19UhZv3mc23npoZ4GZONmDhh4BUkVC9MgeLiHmUN09ek9e3F4cjdlPwpIAV6Lqv6NjlaUVki/H0fGNJ9/6yWxIAecN5/6WNTAFai0iwKCNETdWqbf8WAdg8TieQV0I9R+aZ/a8LW/WQpn5lL8TT1zMYrdAFbT2SzyP9d6qpOYVocJKsCOJ6+MAzRkZAg8kSi+4Vw4OvL3P4cnpaFdekxhJlggJfzWqKFJA2FKK3qxrpPFXiqF/bOc4dOQO6jNuEIROFuPXCSI12nA0zKsC90nNybAUkO47w7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwZnsWLXjqxHVojbCUwCraTX9fFdw+qOsuTst5rUlG0=;
 b=fdAS7fmpMJyh+i3s34H3GBM5QDHicjMR+ZKBAyimc5MYiHRdLPwdBuQbGQ5ljxAF6DL2qqTmnXtPJA5lotE9QV5zSlTJvIFAowmTx1M/td9P/kda3IG+S58p3xckdXKQLz3Cz6sNb5Z6h5GDMD7YM0218bJllS550YeA0uOlm40FeD2gJh0/se+MUJLFTOLMspYiC8Z59FMqWc+4Axk/4soPi/o4qObq6VdlbYzMkAWfBWsK37DbUrDd8DBQNAc9TUXFGf+Fhbwg3kv7um31u/NZq7cMXX84PcHlrdvwI1vxwaWu1Rc8ELAbiEyMS8eZ7JXy0TaH3JDe927lO8OFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4324.namprd15.prod.outlook.com (2603:10b6:806:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 19:46:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 19:46:35 +0000
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
Thread-Topic: [EXTERNAL] [PATCH 17/61] nilfs2: update for u64 i_ino
Thread-Index: AQHcpzyJpv8m+lQSEUyzpMLWkFran7WVYsAA
Date: Thu, 26 Feb 2026 19:46:35 +0000
Message-ID: <34b1d1f43043ca1b71a3ca9ea5ebce597a4c02aa.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
	 <20260226-iino-u64-v1-17-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-17-ccceff366db9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4324:EE_
x-ms-office365-filtering-correlation-id: 57079c5d-1f9f-40b1-4347-08de756fbfec
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 vWcsAQgF6Gf2npYfhM1y1HUYmbVQzhwv/PXFwXYfBkWDvv0hDDqz5QRwPLRucX5MSmqufdxGRp9Mhyd8y67kGs1DUc8kgWzdHvYP5rJ2095PdNWqABnPW0aKcqqjKVpoY0a5oC7UXS9EbeiJ4zMgWC0mIJpzp0IcDa8ed2FG73X2dNrpXYAw/oF+1bk6Ftq1zv+i7bLJp1vSNi1vNp8Ks1q3WX1RfMIiZNtiK1HMo/VJiYz17UozHlQprW+9ZdyRdshJpWw54HMFXPsV71cRxMNyG7dEZgv7OfT2pv6BImgI2O5WA4cP3mGgg0AytaMnnkEY0SppaHNYqjxgTfYydpEhnaTMMFEPB7mTUOaLbJjbuYwSr29PLkfPfnsrRWScodxgbPuyCXwTm+YnZkgGzlj9IZwm4fNGRzeMlMF6faUCO06gWnacoHqg6+GJEHls2vFwSmBwGPWQd+Ohwiuan4UVnnYXYv7HEnFZtegcuk3WgZcOmDbVtSu7DQzvZpATuIC+nW9DlhRAAnzWrpI4oVMAR8uxj6hueHt1g7z/NGrMgCUfKoIkg7Dfyb1Selpwj/RjtT4MeyIfwh0cO0qJfJYVoFrIkRqkPKcgJQrizI4hbIndc/TMDeNnOGey7KQ8QbvNwHMejgPfj3b/hy4lswvFEvspDhq4EjfowRstn1K7k6EtpJWfwfBJQsmfrLn42054kB/RaxLEhzsqyK4tGqat/203B2xB4xWXNI6JjCg3neHDJhGJ4I+fSIdBlPaVWHr6WmRVzIIRNv0oJSwqr0vj4IMZXG16ubI0/It1S90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmF6ZldKRjVGOU12dGVQejIzamJ5THd2TFYzT1BtLzVSYzI3ajR5aEF4RDBR?=
 =?utf-8?B?TGNVRmhtZm5KTTNkMWQvVE1EQ0d5M3pLbW9kbDlvU2VRWnovTjRESWNjb3Fj?=
 =?utf-8?B?UVcraVZtZG1NbXowcnJMbVY0VmN4SEV2NllBdW00N0VjMVdvMW5EckdlNUxY?=
 =?utf-8?B?WG1sOWF4N25Pa0w4RWhTQ0pQUUtrbFoyc1c0NjAzYXhQQi9SQkVMcDVYOVkv?=
 =?utf-8?B?ZGN3UkMvVnhZdlhJTGFEWmdmay80bFdMcjVXS0Q3Ymphc1hlOTRZNmRrcWNi?=
 =?utf-8?B?ZE9PbjM0OEtXUmRjOERvMHZWaEZFeUlYdWlvOHFkRGM0NTVpSWN4R3czR1o3?=
 =?utf-8?B?czVCZVV4NDZBbDg0dGtkVTljVk56a2IwUzdYbzVKVVJkOElpaUhGMlBwV3cw?=
 =?utf-8?B?Y3pxVTdRbUUyRXJ3MFVSS0VNVS9XcUd5K3M4SkFUVy9iN0RhRnhlWXFyZVRV?=
 =?utf-8?B?TWRmVFRPQU1tZzVQT0ZnK1hkRngzUGVhSDJYS3JTYmhmWDFEbHZ0K2hlL1pX?=
 =?utf-8?B?ZmREdVBPYXJiSEU4OTNoSGlXVWw4RFp6MlpMUUEvRE9TQ0tWeitYUnpvNW56?=
 =?utf-8?B?L3E5bkx2eHhQOEgzdC8zbGNJckRZUjY0WUt5aExaRzVrNEZ0aXcvVDlqTTM1?=
 =?utf-8?B?cjVmaHdoU0IwTWhxUW10cnRwY1JJbzdTWGFzM0wxZStUNUh6TXNqUDYzRWxh?=
 =?utf-8?B?TVlNamltRSt3M2FEVEN3QVR2cEEzUy9IbWNicDNUT3FwbHoxdHYyYTkyQlBn?=
 =?utf-8?B?SmhyU2VtMjV3N3dLSjIzdkJKOUpBOEFDcDNQaW8wQkdzUUF5L3hyTm5wQ3du?=
 =?utf-8?B?ZmpDWmw0a1hXZGU0NUhpVGJpdnRrVjdOYm45SGZ2QzNWTUZCQkM2czc5bDFk?=
 =?utf-8?B?TFVqcmh3bDBzV0N5dmRhMzd1blE4UXQ4UlZleE96UFZpN3d5OXlqS3dCSGRN?=
 =?utf-8?B?Z3RyaGU0ejNrV2RsODIzbDNWRW9wSjNvd0FrVWNySDRtWjdQcTd6UmJ3ZG05?=
 =?utf-8?B?a0VER2VYamVXVEtna3VJOThUY1hvNmtTOC9BM1ByT1RWSTBNMWhaYy9idlky?=
 =?utf-8?B?VWU0dlh5VlErUThaNFdaUVozUTY5cWVVbEF3dm4vdDF5SVBmbFhiSzkrZ2Fj?=
 =?utf-8?B?a0lhSW9PNXFMcE04LzBRdDFmSkljSmp6REhPa244ZlliMkdKaHRhVzB6YjVI?=
 =?utf-8?B?eUpJR0dXdnAwczk2eFZCYXJGa0ppRGlvMmEwNlRWOTgwdWtUSFlZZmRYWmpo?=
 =?utf-8?B?dXMrMVYrOUNYZW1rYzJRMmJCUGFhSStha3dSU2hsQmI3cTQxRkZQRm4ySU5z?=
 =?utf-8?B?NEN3aHVvdlFLNVJoRjZUSjBZeENISjcvWnZzdkF5TlY4NkxRcWV5SnhrNXRT?=
 =?utf-8?B?RG9MajFtclFmbkYrNzNJZmV0ZUQzdmNoTmJxb21Db0JESzVPKzl3dW55KzZ5?=
 =?utf-8?B?RStxb01RbWs2aFYrUDBCSExLOEY3U1Q1Zk9vcXhHZHNIcXdGNW5NOXpEVkdO?=
 =?utf-8?B?NkU5UlJ5M3IwQUhMbXFIL28vUzFRZk9rSDdsU3ZJRFRCN085cUJvbmhsSnBm?=
 =?utf-8?B?eFhQRlk2TXRRMUkya2cySnIySVEvdW9rK25aU0VQNmtjd0Z6bEhmTTBmUUsx?=
 =?utf-8?B?RWRCdFczdCtrdU8reTZSeXJYSWt5MC92cEkzb0RHbFN3MUs0S3VFVnJMSmZx?=
 =?utf-8?B?RTNnQ2dvaXI5U2pscFFkVENXeDhzQW53WDN3OWZuU0taUXZmY2ppMDJ1S3Vk?=
 =?utf-8?B?RC9sTkQxNVpmN3FTL1ZTNTlaVEZBOVZBMXdXcUdRR2VCODZpRCtwbFdFVzFq?=
 =?utf-8?B?UzNzVzdOcGw2QVJ4NnJTd3BLQVA3VHpRaEpLbWc0UFU3Y1NoQ3N0RHVDeHBl?=
 =?utf-8?B?Y3czNHVGN3Nqdy81c3BFTStDenRMcEtMRUpRQzZJNU85WTIwUmIvcmFnMVhR?=
 =?utf-8?B?eXdiNTFMbThzd2pjSUR6dmc1dUdjMVQvcnFSNHlXSlcyME1wOTgwTmJGM1NS?=
 =?utf-8?B?SGl1WklWeGI1QlpWZ1dUNUtqemFqQ0FKNktaTXZCalViS3hQZit0QTVyb2Er?=
 =?utf-8?B?NXdLZm5ZU1ZrcnkxNUpiLzdqd0x1TmxZTzlpTVYyNE1OQjgyNGZEUTIvdjlD?=
 =?utf-8?B?cWZvMTBpUUpERnZTQ3lvcVhPNlBVamRVeHhYZlprWXoxcy9IY2Uva1ZrVzA5?=
 =?utf-8?B?YjFXbnZlMHNWR3h3a0lLeVptS1FMWnF3U3dqaDQzc0VGMnJUMVR1RHREVDV6?=
 =?utf-8?B?dngzc1FOb0hYbFBsNzRkdmQrVVlsbm4zdmVqcVZLclBNSXJsQlNyOXBrSDJG?=
 =?utf-8?B?WXN0dEVNTkRIOC9ZYzJnMC8yQ0xMY29LTExzVEV5RnZydzlHZ3QzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <992A0C5895A0CE40A43F816213D7A117@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57079c5d-1f9f-40b1-4347-08de756fbfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:46:35.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUTFUR6auZkxIi8FW4j9d6CDz6OJUC0X+L6zQ2OFYQHJhG04J8mvC52XaUcWhmD+am/BP1iiwoTLItv5LdGiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4324
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4MCBTYWx0ZWRfX36YVZ8KvaP4z
 X2B4N6yKXu6gHTB5BEzemc0n0M1Ry6LG0quUC3JwzwlICJ8pnE9EigXDXVfZsnJDaChEn0/OCmD
 0Ad/BqcTlYrFOJL/tgyBCXItU1UVjOi6QNNtbqT+vkXRseI12QLr1KUBhCrtRY437jZiucj1h8h
 Fogzu+Paz4lSa0b+E+IpZIdiCTMlmFCczDXZFKxVdANcfPUKJGyiQCucvi+2lZLBLySb7mhW4hu
 tA5MRlZ9GmqdXa9U2bjfgHDsEB+H5rwzBDQlFCVmZ8ki8itqCjzrZxpLacxpuaCPNg6EupVM9TB
 +xDBzsoQPTYGaMbnJ8FAfxNETG/gGbYeTvjkRWPYYHtMgg5DWdsUp3EjwxR26+BZp2qS0JXYH/w
 3ysSnv5zHXtboM5/YTQsmMR8L/X7vbgXo9S+DewdDvt3pKt0ZfrCuRrpcXaxeGvbdly8/qhBeap
 2TEEQ21Vx7I2kvQ4/7Q==
X-Proofpoint-GUID: Y5-Dc8-wCGltGQuzWYSpvYuM8UatHXCc
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a0a321 cx=c_pps
 a=ButkoIHTjR5vDxq5MUTXqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=1z-WkPR4Vt9w7pVVlBgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KSCiWijPrfwkaaWR8Cj1GWbK2vPb9cnq
Subject: Re:  [PATCH 17/61] nilfs2: update for u64 i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260180
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
	TAGGED_FROM(0.00)[bounces-78628-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F9391AEBBE
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDEwOjU1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
VXBkYXRlIG5pbGZzMiB0cmFjZSBldmVudHMgYW5kIGZpbGVzeXN0ZW0gY29kZSBmb3IgdTY0IGlf
aW5vOg0KPiANCj4gLSBDaGFuZ2UgX19maWVsZChpbm9fdCwgLi4uKSB0byBfX2ZpZWxkKHU2NCwg
Li4uKSBpbiB0cmFjZSBldmVudHMNCj4gLSBVcGRhdGUgZm9ybWF0IHN0cmluZ3MgZnJvbSAlbHUg
dG8gJWxsdQ0KPiAtIENhc3QgdG8gKHVuc2lnbmVkIGxvbmcgbG9uZykgaW4gVFBfcHJpbnRrDQo+
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
ZjlhNDA4MGEzOWYxN2Q0MTIzZTU4ZWQ3ZGY2YjJmNGIuLjdiMWNkMmJhZWZjZjIxZTU0ZjkyNjA4
NDViMDJjN2M5NWMxNDhjNjQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9hbGxvYy5jDQo+ICsr
KyBiL2ZzL25pbGZzMi9hbGxvYy5jDQo+IEBAIC03MDcsNyArNzA3LDcgQEAgdm9pZCBuaWxmc19w
YWxsb2NfY29tbWl0X2ZyZWVfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwNCj4gIA0KPiAgCWlm
ICghbmlsZnNfY2xlYXJfYml0X2F0b21pYyhsb2NrLCBncm91cF9vZmZzZXQsIGJpdG1hcCkpDQo+
ICAJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiJXMgKGlubz0lbHUpOiBlbnRy
eSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gKwkJCSAgICIlcyAoaW5vPSVsbHUpOiBl
bnRyeSBudW1iZXIgJWxsdSBhbHJlYWR5IGZyZWVkIiwNCj4gIAkJCSAgIF9fZnVuY19fLCBpbm9k
ZS0+aV9pbm8sDQo+ICAJCQkgICAodW5zaWduZWQgbG9uZyBsb25nKXJlcS0+cHJfZW50cnlfbnIp
Ow0KPiAgCWVsc2UNCj4gQEAgLTc0OCw3ICs3NDgsNyBAQCB2b2lkIG5pbGZzX3BhbGxvY19hYm9y
dF9hbGxvY19lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgDQo+ICAJaWYgKCFuaWxmc19j
bGVhcl9iaXRfYXRvbWljKGxvY2ssIGdyb3VwX29mZnNldCwgYml0bWFwKSkNCj4gIAkJbmlsZnNf
d2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCSAgICIlcyAoaW5vPSVsdSk6IGVudHJ5IG51bWJlciAl
bGx1IGFscmVhZHkgZnJlZWQiLA0KPiArCQkJICAgIiVzIChpbm89JWxsdSk6IGVudHJ5IG51bWJl
ciAlbGx1IGFscmVhZHkgZnJlZWQiLA0KPiAgCQkJICAgX19mdW5jX18sIGlub2RlLT5pX2lubywN
Cj4gIAkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpcmVxLT5wcl9lbnRyeV9ucik7DQo+ICAJZWxz
ZQ0KPiBAQCAtODYxLDcgKzg2MSw3IEBAIGludCBuaWxmc19wYWxsb2NfZnJlZXYoc3RydWN0IGlu
b2RlICppbm9kZSwgX191NjQgKmVudHJ5X25ycywgc2l6ZV90IG5pdGVtcykNCj4gIAkJCWlmICgh
bmlsZnNfY2xlYXJfYml0X2F0b21pYyhsb2NrLCBncm91cF9vZmZzZXQsDQo+ICAJCQkJCQkgICAg
Yml0bWFwKSkgew0KPiAgCQkJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkJCSAgICIl
cyAoaW5vPSVsdSk6IGVudHJ5IG51bWJlciAlbGx1IGFscmVhZHkgZnJlZWQiLA0KPiArCQkJCQkg
ICAiJXMgKGlubz0lbGx1KTogZW50cnkgbnVtYmVyICVsbHUgYWxyZWFkeSBmcmVlZCIsDQo+ICAJ
CQkJCSAgIF9fZnVuY19fLCBpbm9kZS0+aV9pbm8sDQo+ICAJCQkJCSAgICh1bnNpZ25lZCBsb25n
IGxvbmcpZW50cnlfbnJzW2pdKTsNCj4gIAkJCX0gZWxzZSB7DQo+IEBAIC05MDYsNyArOTA2LDcg
QEAgaW50IG5pbGZzX3BhbGxvY19mcmVldihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBfX3U2NCAqZW50
cnlfbnJzLCBzaXplX3Qgbml0ZW1zKQ0KPiAgCQkJCQkJCSAgICAgIGxhc3RfbnJzW2tdKTsNCj4g
IAkJCWlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpDQo+ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+
aV9zYiwNCj4gLQkJCQkJICAgImVycm9yICVkIGRlbGV0aW5nIGJsb2NrIHRoYXQgb2JqZWN0IChl
bnRyeT0lbGx1LCBpbm89JWx1KSBiZWxvbmdzIHRvIiwNCj4gKwkJCQkJICAgImVycm9yICVkIGRl
bGV0aW5nIGJsb2NrIHRoYXQgb2JqZWN0IChlbnRyeT0lbGx1LCBpbm89JWxsdSkgYmVsb25ncyB0
byIsDQo+ICAJCQkJCSAgIHJldCwgKHVuc2lnbmVkIGxvbmcgbG9uZylsYXN0X25yc1trXSwNCj4g
IAkJCQkJICAgaW5vZGUtPmlfaW5vKTsNCj4gIAkJfQ0KPiBAQCAtOTIzLDcgKzkyMyw3IEBAIGlu
dCBuaWxmc19wYWxsb2NfZnJlZXYoc3RydWN0IGlub2RlICppbm9kZSwgX191NjQgKmVudHJ5X25y
cywgc2l6ZV90IG5pdGVtcykNCj4gIAkJCXJldCA9IG5pbGZzX3BhbGxvY19kZWxldGVfYml0bWFw
X2Jsb2NrKGlub2RlLCBncm91cCk7DQo+ICAJCQlpZiAocmV0ICYmIHJldCAhPSAtRU5PRU5UKQ0K
PiAgCQkJCW5pbGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkJCSAgICJlcnJvciAlZCBkZWxl
dGluZyBiaXRtYXAgYmxvY2sgb2YgZ3JvdXA9JWx1LCBpbm89JWx1IiwNCj4gKwkJCQkJICAgImVy
cm9yICVkIGRlbGV0aW5nIGJpdG1hcCBibG9jayBvZiBncm91cD0lbHUsIGlubz0lbGx1IiwNCj4g
IAkJCQkJICAgcmV0LCBncm91cCwgaW5vZGUtPmlfaW5vKTsNCj4gIAkJfQ0KPiAgCX0NCj4gZGlm
ZiAtLWdpdCBhL2ZzL25pbGZzMi9ibWFwLmMgYi9mcy9uaWxmczIvYm1hcC5jDQo+IGluZGV4IGNj
YzFhN2FhNTJkMjA2NGQ1NmI4MjYwNTg1NTQyNjRjNDk4ZDU5MmYuLjgyNGYyYmQ5MWMxNjc5NjVl
YzNhNjYwMjAyYjZlNmM1ZjFmZTAwN2UgMTAwNjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9ibWFwLmMN
Cj4gKysrIGIvZnMvbmlsZnMyL2JtYXAuYw0KPiBAQCAtMzMsNyArMzMsNyBAQCBzdGF0aWMgaW50
IG5pbGZzX2JtYXBfY29udmVydF9lcnJvcihzdHJ1Y3QgbmlsZnNfYm1hcCAqYm1hcCwNCj4gIA0K
PiAgCWlmIChlcnIgPT0gLUVJTlZBTCkgew0KPiAgCQlfX25pbGZzX2Vycm9yKGlub2RlLT5pX3Ni
LCBmbmFtZSwNCj4gLQkJCSAgICAgICJicm9rZW4gYm1hcCAoaW5vZGUgbnVtYmVyPSVsdSkiLCBp
bm9kZS0+aV9pbm8pOw0KPiArCQkJICAgICAgImJyb2tlbiBibWFwIChpbm9kZSBudW1iZXI9JWxs
dSkiLCBpbm9kZS0+aV9pbm8pOw0KPiAgCQllcnIgPSAtRUlPOw0KPiAgCX0NCj4gIAlyZXR1cm4g
ZXJyOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2J0bm9kZS5jIGIvZnMvbmlsZnMyL2J0bm9k
ZS5jDQo+IGluZGV4IDU2ODM2NzEyOTA5MjAxNzc1OTA3NDgzODg3ZThhMDAyMjg1MWJiZWMuLjJl
NTUzZDY5OGQwZjM5ODBkZTk4ZmNlZDQxNWRmZDgxOWRkYmNhMGEgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25pbGZzMi9idG5vZGUuYw0KPiArKysgYi9mcy9uaWxmczIvYnRub2RlLmMNCj4gQEAgLTY0LDcg
KzY0LDcgQEAgbmlsZnNfYnRub2RlX2NyZWF0ZV9ibG9jayhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAq
YnRuYywgX191NjQgYmxvY2tucikNCj4gIAkJICogY2xlYXJpbmcgb2YgYW4gYWJhbmRvbmVkIGIt
dHJlZSBub2RlIGlzIG1pc3Npbmcgc29tZXdoZXJlKS4NCj4gIAkJICovDQo+ICAJCW5pbGZzX2Vy
cm9yKGlub2RlLT5pX3NiLA0KPiAtCQkJICAgICJzdGF0ZSBpbmNvbnNpc3RlbmN5IHByb2JhYmx5
IGR1ZSB0byBkdXBsaWNhdGUgdXNlIG9mIGItdHJlZSBub2RlIGJsb2NrIGFkZHJlc3MgJWxsdSAo
aW5vPSVsdSkiLA0KPiArCQkJICAgICJzdGF0ZSBpbmNvbnNpc3RlbmN5IHByb2JhYmx5IGR1ZSB0
byBkdXBsaWNhdGUgdXNlIG9mIGItdHJlZSBub2RlIGJsb2NrIGFkZHJlc3MgJWxsdSAoaW5vPSVs
bHUpIiwNCj4gIAkJCSAgICAodW5zaWduZWQgbG9uZyBsb25nKWJsb2NrbnIsIGlub2RlLT5pX2lu
byk7DQo+ICAJCWdvdG8gZmFpbGVkOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZzMi9i
dHJlZS5jIGIvZnMvbmlsZnMyL2J0cmVlLmMNCj4gaW5kZXggZGQwYzhlNTYwZWY2YTJjOTY1MTUw
MjUzMjE5MTRlMGQ3M2Y0MTE0NC4uM2MwM2Y1YTc0MWQxNDRkMjJkMWZmYjVhY2Y0M2EwMzVlODhj
MDBkYyAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2J0cmVlLmMNCj4gKysrIGIvZnMvbmlsZnMy
L2J0cmVlLmMNCj4gQEAgLTM1Myw3ICszNTMsNyBAQCBzdGF0aWMgaW50IG5pbGZzX2J0cmVlX25v
ZGVfYnJva2VuKGNvbnN0IHN0cnVjdCBuaWxmc19idHJlZV9ub2RlICpub2RlLA0KPiAgCQkgICAg
IG5jaGlsZHJlbiA8PSAwIHx8DQo+ICAJCSAgICAgbmNoaWxkcmVuID4gTklMRlNfQlRSRUVfTk9E
RV9OQ0hJTERSRU5fTUFYKHNpemUpKSkgew0KPiAgCQluaWxmc19jcml0KGlub2RlLT5pX3NiLA0K
PiAtCQkJICAgImJhZCBidHJlZSBub2RlIChpbm89JWx1LCBibG9ja25yPSVsbHUpOiBsZXZlbCA9
ICVkLCBmbGFncyA9IDB4JXgsIG5jaGlsZHJlbiA9ICVkIiwNCj4gKwkJCSAgICJiYWQgYnRyZWUg
bm9kZSAoaW5vPSVsbHUsIGJsb2NrbnI9JWxsdSk6IGxldmVsID0gJWQsIGZsYWdzID0gMHgleCwg
bmNoaWxkcmVuID0gJWQiLA0KPiAgCQkJICAgaW5vZGUtPmlfaW5vLCAodW5zaWduZWQgbG9uZyBs
b25nKWJsb2NrbnIsIGxldmVsLA0KPiAgCQkJICAgZmxhZ3MsIG5jaGlsZHJlbik7DQo+ICAJCXJl
dCA9IDE7DQo+IEBAIC0zODQsNyArMzg0LDcgQEAgc3RhdGljIGludCBuaWxmc19idHJlZV9yb290
X2Jyb2tlbihjb25zdCBzdHJ1Y3QgbmlsZnNfYnRyZWVfbm9kZSAqbm9kZSwNCj4gIAkJICAgICBu
Y2hpbGRyZW4gPiBOSUxGU19CVFJFRV9ST09UX05DSElMRFJFTl9NQVggfHwNCj4gIAkJICAgICAo
bmNoaWxkcmVuID09IDAgJiYgbGV2ZWwgPiBOSUxGU19CVFJFRV9MRVZFTF9OT0RFX01JTikpKSB7
DQo+ICAJCW5pbGZzX2NyaXQoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiYmFkIGJ0cmVlIHJvb3Qg
KGlubz0lbHUpOiBsZXZlbCA9ICVkLCBmbGFncyA9IDB4JXgsIG5jaGlsZHJlbiA9ICVkIiwNCj4g
KwkJCSAgICJiYWQgYnRyZWUgcm9vdCAoaW5vPSVsbHUpOiBsZXZlbCA9ICVkLCBmbGFncyA9IDB4
JXgsIG5jaGlsZHJlbiA9ICVkIiwNCj4gIAkJCSAgIGlub2RlLT5pX2lubywgbGV2ZWwsIGZsYWdz
LCBuY2hpbGRyZW4pOw0KPiAgCQlyZXQgPSAxOw0KPiAgCX0NCj4gQEAgLTQ1Myw3ICs0NTMsNyBA
QCBzdGF0aWMgaW50IG5pbGZzX2J0cmVlX2JhZF9ub2RlKGNvbnN0IHN0cnVjdCBuaWxmc19ibWFw
ICpidHJlZSwNCj4gIAlpZiAodW5saWtlbHkobmlsZnNfYnRyZWVfbm9kZV9nZXRfbGV2ZWwobm9k
ZSkgIT0gbGV2ZWwpKSB7DQo+ICAJCWR1bXBfc3RhY2soKTsNCj4gIAkJbmlsZnNfY3JpdChidHJl
ZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCSAgICJidHJlZSBsZXZlbCBtaXNtYXRjaCAoaW5vPSVs
dSk6ICVkICE9ICVkIiwNCj4gKwkJCSAgICJidHJlZSBsZXZlbCBtaXNtYXRjaCAoaW5vPSVsbHUp
OiAlZCAhPSAlZCIsDQo+ICAJCQkgICBidHJlZS0+Yl9pbm9kZS0+aV9pbm8sDQo+ICAJCQkgICBu
aWxmc19idHJlZV9ub2RlX2dldF9sZXZlbChub2RlKSwgbGV2ZWwpOw0KPiAgCQlyZXR1cm4gMTsN
Cj4gQEAgLTUyMSw3ICs1MjEsNyBAQCBzdGF0aWMgaW50IF9fbmlsZnNfYnRyZWVfZ2V0X2Jsb2Nr
KGNvbnN0IHN0cnVjdCBuaWxmc19ibWFwICpidHJlZSwgX191NjQgcHRyLA0KPiAgIG91dF9ub193
YWl0Og0KPiAgCWlmICghYnVmZmVyX3VwdG9kYXRlKGJoKSkgew0KPiAgCQluaWxmc19lcnIoYnRy
ZWUtPmJfaW5vZGUtPmlfc2IsDQo+IC0JCQkgICJJL08gZXJyb3IgcmVhZGluZyBiLXRyZWUgbm9k
ZSBibG9jayAoaW5vPSVsdSwgYmxvY2tucj0lbGx1KSIsDQo+ICsJCQkgICJJL08gZXJyb3IgcmVh
ZGluZyBiLXRyZWUgbm9kZSBibG9jayAoaW5vPSVsbHUsIGJsb2NrbnI9JWxsdSkiLA0KPiAgCQkJ
ICBidHJlZS0+Yl9pbm9kZS0+aV9pbm8sICh1bnNpZ25lZCBsb25nIGxvbmcpcHRyKTsNCj4gIAkJ
YnJlbHNlKGJoKTsNCj4gIAkJcmV0dXJuIC1FSU87DQo+IEBAIC0yMTA0LDcgKzIxMDQsNyBAQCBz
dGF0aWMgaW50IG5pbGZzX2J0cmVlX3Byb3BhZ2F0ZShzdHJ1Y3QgbmlsZnNfYm1hcCAqYnRyZWUs
DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJaWYgKHVubGlrZWx5KHJldCA9PSAtRU5PRU5UKSkg
ew0KPiAgCQkJbmlsZnNfY3JpdChidHJlZS0+Yl9pbm9kZS0+aV9zYiwNCj4gLQkJCQkgICAid3Jp
dGluZyBub2RlL2xlYWYgYmxvY2sgZG9lcyBub3QgYXBwZWFyIGluIGItdHJlZSAoaW5vPSVsdSkg
YXQga2V5PSVsbHUsIGxldmVsPSVkIiwNCj4gKwkJCQkgICAid3JpdGluZyBub2RlL2xlYWYgYmxv
Y2sgZG9lcyBub3QgYXBwZWFyIGluIGItdHJlZSAoaW5vPSVsbHUpIGF0IGtleT0lbGx1LCBsZXZl
bD0lZCIsDQo+ICAJCQkJICAgYnRyZWUtPmJfaW5vZGUtPmlfaW5vLA0KPiAgCQkJCSAgICh1bnNp
Z25lZCBsb25nIGxvbmcpa2V5LCBsZXZlbCk7DQo+ICAJCQlyZXQgPSAtRUlOVkFMOw0KPiBAQCAt
MjE0Niw3ICsyMTQ2LDcgQEAgc3RhdGljIHZvaWQgbmlsZnNfYnRyZWVfYWRkX2RpcnR5X2J1ZmZl
cihzdHJ1Y3QgbmlsZnNfYm1hcCAqYnRyZWUsDQo+ICAJICAgIGxldmVsID49IE5JTEZTX0JUUkVF
X0xFVkVMX01BWCkgew0KPiAgCQlkdW1wX3N0YWNrKCk7DQo+ICAJCW5pbGZzX3dhcm4oYnRyZWUt
PmJfaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiaW52YWxpZCBidHJlZSBsZXZlbDogJWQgKGtleT0l
bGx1LCBpbm89JWx1LCBibG9ja25yPSVsbHUpIiwNCj4gKwkJCSAgICJpbnZhbGlkIGJ0cmVlIGxl
dmVsOiAlZCAoa2V5PSVsbHUsIGlubz0lbGx1LCBibG9ja25yPSVsbHUpIiwNCj4gIAkJCSAgIGxl
dmVsLCAodW5zaWduZWQgbG9uZyBsb25nKWtleSwNCj4gIAkJCSAgIGJ0cmVlLT5iX2lub2RlLT5p
X2lubywNCj4gIAkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcpYmgtPmJfYmxvY2tucik7DQo+IGRp
ZmYgLS1naXQgYS9mcy9uaWxmczIvZGlyLmMgYi9mcy9uaWxmczIvZGlyLmMNCj4gaW5kZXggYjI0
MzE5OTAzNmRmYTFhYjIyOTllZmFhYTViZGY1ZGEyZDE1OWZmMi4uMzY1M2RiNWNkYjY1MTM3ZDFl
NjYwYmI1MDljMTRlYzRjYmM4ODQwYiAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2Rpci5jDQo+
ICsrKyBiL2ZzL25pbGZzMi9kaXIuYw0KPiBAQCAtMTUwLDcgKzE1MCw3IEBAIHN0YXRpYyBib29s
IG5pbGZzX2NoZWNrX2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8sIGNoYXIgKmthZGRyKQ0KPiAg
DQo+ICBFYmFkc2l6ZToNCj4gIAluaWxmc19lcnJvcihzYiwNCj4gLQkJICAgICJzaXplIG9mIGRp
cmVjdG9yeSAjJWx1IGlzIG5vdCBhIG11bHRpcGxlIG9mIGNodW5rIHNpemUiLA0KPiArCQkgICAg
InNpemUgb2YgZGlyZWN0b3J5ICMlbGx1IGlzIG5vdCBhIG11bHRpcGxlIG9mIGNodW5rIHNpemUi
LA0KPiAgCQkgICAgZGlyLT5pX2lubyk7DQo+ICAJZ290byBmYWlsOw0KPiAgRXNob3J0Og0KPiBA
QCAtMTY5LDcgKzE2OSw3IEBAIHN0YXRpYyBib29sIG5pbGZzX2NoZWNrX2ZvbGlvKHN0cnVjdCBm
b2xpbyAqZm9saW8sIGNoYXIgKmthZGRyKQ0KPiAgCWVycm9yID0gImRpc2FsbG93ZWQgaW5vZGUg
bnVtYmVyIjsNCj4gIGJhZF9lbnRyeToNCj4gIAluaWxmc19lcnJvcihzYiwNCj4gLQkJICAgICJi
YWQgZW50cnkgaW4gZGlyZWN0b3J5ICMlbHU6ICVzIC0gb2Zmc2V0PSVsdSwgaW5vZGU9JWx1LCBy
ZWNfbGVuPSV6ZCwgbmFtZV9sZW49JWQiLA0KPiArCQkgICAgImJhZCBlbnRyeSBpbiBkaXJlY3Rv
cnkgIyVsbHU6ICVzIC0gb2Zmc2V0PSVsdSwgaW5vZGU9JWx1LCByZWNfbGVuPSV6ZCwgbmFtZV9s
ZW49JWQiLA0KDQpJIHRoaW5rIHlvdSBtaXNzZWQgJ2lub2RlPSVsdScgaGVyZS4gDQoNCj4gIAkJ
ICAgIGRpci0+aV9pbm8sIGVycm9yLCAoZm9saW8tPmluZGV4IDw8IFBBR0VfU0hJRlQpICsgb2Zm
cywNCj4gIAkJICAgICh1bnNpZ25lZCBsb25nKWxlNjRfdG9fY3B1KHAtPmlub2RlKSwNCj4gIAkJ
ICAgIHJlY19sZW4sIHAtPm5hbWVfbGVuKTsNCj4gQEAgLTE3Nyw3ICsxNzcsNyBAQCBzdGF0aWMg
Ym9vbCBuaWxmc19jaGVja19mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlvLCBjaGFyICprYWRkcikN
Cj4gIEVlbmQ6DQo+ICAJcCA9IChzdHJ1Y3QgbmlsZnNfZGlyX2VudHJ5ICopKGthZGRyICsgb2Zm
cyk7DQo+ICAJbmlsZnNfZXJyb3Ioc2IsDQo+IC0JCSAgICAiZW50cnkgaW4gZGlyZWN0b3J5ICMl
bHUgc3BhbnMgdGhlIHBhZ2UgYm91bmRhcnkgb2Zmc2V0PSVsdSwgaW5vZGU9JWx1IiwNCj4gKwkJ
ICAgICJlbnRyeSBpbiBkaXJlY3RvcnkgIyVsbHUgc3BhbnMgdGhlIHBhZ2UgYm91bmRhcnkgb2Zm
c2V0PSVsdSwgaW5vZGU9JWx1IiwNCg0KRGl0dG8uIFlvdSBtaXNzZWQgJ2lub2RlPSVsdScgaGVy
ZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIAkJICAgIGRpci0+aV9pbm8sIChmb2xpby0+aW5k
ZXggPDwgUEFHRV9TSElGVCkgKyBvZmZzLA0KPiAgCQkgICAgKHVuc2lnbmVkIGxvbmcpbGU2NF90
b19jcHUocC0+aW5vZGUpKTsNCj4gIGZhaWw6DQo+IEBAIC0yNTEsNyArMjUxLDcgQEAgc3RhdGlj
IGludCBuaWxmc19yZWFkZGlyKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgZGlyX2NvbnRleHQg
KmN0eCkNCj4gIA0KPiAgCQlrYWRkciA9IG5pbGZzX2dldF9mb2xpbyhpbm9kZSwgbiwgJmZvbGlv
KTsNCj4gIAkJaWYgKElTX0VSUihrYWRkcikpIHsNCj4gLQkJCW5pbGZzX2Vycm9yKHNiLCAiYmFk
IHBhZ2UgaW4gIyVsdSIsIGlub2RlLT5pX2lubyk7DQo+ICsJCQluaWxmc19lcnJvcihzYiwgImJh
ZCBwYWdlIGluICMlbGx1IiwgaW5vZGUtPmlfaW5vKTsNCj4gIAkJCWN0eC0+cG9zICs9IFBBR0Vf
U0laRSAtIG9mZnNldDsNCj4gIAkJCXJldHVybiAtRUlPOw0KPiAgCQl9DQo+IEBAIC0zMzYsNyAr
MzM2LDcgQEAgc3RydWN0IG5pbGZzX2Rpcl9lbnRyeSAqbmlsZnNfZmluZF9lbnRyeShzdHJ1Y3Qg
aW5vZGUgKmRpciwNCj4gIAkJLyogbmV4dCBmb2xpbyBpcyBwYXN0IHRoZSBibG9ja3Mgd2UndmUg
Z290ICovDQo+ICAJCWlmICh1bmxpa2VseShuID4gKGRpci0+aV9ibG9ja3MgPj4gKFBBR0VfU0hJ
RlQgLSA5KSkpKSB7DQo+ICAJCQluaWxmc19lcnJvcihkaXItPmlfc2IsDQo+IC0JCQkgICAgICAg
ImRpciAlbHUgc2l6ZSAlbGxkIGV4Y2VlZHMgYmxvY2sgY291bnQgJWxsdSIsDQo+ICsJCQkgICAg
ICAgImRpciAlbGx1IHNpemUgJWxsZCBleGNlZWRzIGJsb2NrIGNvdW50ICVsbHUiLA0KPiAgCQkJ
ICAgICAgIGRpci0+aV9pbm8sIGRpci0+aV9zaXplLA0KPiAgCQkJICAgICAgICh1bnNpZ25lZCBs
b25nIGxvbmcpZGlyLT5pX2Jsb2Nrcyk7DQo+ICAJCQlnb3RvIG91dDsNCj4gQEAgLTM4Miw3ICsz
ODIsNyBAQCBzdHJ1Y3QgbmlsZnNfZGlyX2VudHJ5ICpuaWxmc19kb3Rkb3Qoc3RydWN0IGlub2Rl
ICpkaXIsIHN0cnVjdCBmb2xpbyAqKmZvbGlvcCkNCj4gIAlyZXR1cm4gbmV4dF9kZTsNCj4gIA0K
PiAgZmFpbDoNCj4gLQluaWxmc19lcnJvcihkaXItPmlfc2IsICJkaXJlY3RvcnkgIyVsdSAlcyIs
IGRpci0+aV9pbm8sIG1zZyk7DQo+ICsJbmlsZnNfZXJyb3IoZGlyLT5pX3NiLCAiZGlyZWN0b3J5
ICMlbGx1ICVzIiwgZGlyLT5pX2lubywgbXNnKTsNCj4gIAlmb2xpb19yZWxlYXNlX2ttYXAoZm9s
aW8sIGRlKTsNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2ZzL25pbGZz
Mi9kaXJlY3QuYyBiL2ZzL25pbGZzMi9kaXJlY3QuYw0KPiBpbmRleCAyZDhkYzZiMzViNTQ3Nzk0
N2NhMTJhNzAyODhkM2EzY2NlODU4YWFiLi44YmQwYjEzNzRlMjVmOGZmNTEwZjNiMzZkYmRlMmFj
YzAxYWFmYzFlIDEwMDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvZGlyZWN0LmMNCj4gKysrIGIvZnMv
bmlsZnMyL2RpcmVjdC5jDQo+IEBAIC0zMzgsNyArMzM4LDcgQEAgc3RhdGljIGludCBuaWxmc19k
aXJlY3RfYXNzaWduKHN0cnVjdCBuaWxmc19ibWFwICpibWFwLA0KPiAgCWtleSA9IG5pbGZzX2Jt
YXBfZGF0YV9nZXRfa2V5KGJtYXAsICpiaCk7DQo+ICAJaWYgKHVubGlrZWx5KGtleSA+IE5JTEZT
X0RJUkVDVF9LRVlfTUFYKSkgew0KPiAgCQluaWxmc19jcml0KGJtYXAtPmJfaW5vZGUtPmlfc2Is
DQo+IC0JCQkgICAiJXMgKGlubz0lbHUpOiBpbnZhbGlkIGtleTogJWxsdSIsDQo+ICsJCQkgICAi
JXMgKGlubz0lbGx1KTogaW52YWxpZCBrZXk6ICVsbHUiLA0KPiAgCQkJICAgX19mdW5jX18sDQo+
ICAJCQkgICBibWFwLT5iX2lub2RlLT5pX2lubywgKHVuc2lnbmVkIGxvbmcgbG9uZylrZXkpOw0K
PiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTM0Niw3ICszNDYsNyBAQCBzdGF0aWMgaW50IG5p
bGZzX2RpcmVjdF9hc3NpZ24oc3RydWN0IG5pbGZzX2JtYXAgKmJtYXAsDQo+ICAJcHRyID0gbmls
ZnNfZGlyZWN0X2dldF9wdHIoYm1hcCwga2V5KTsNCj4gIAlpZiAodW5saWtlbHkocHRyID09IE5J
TEZTX0JNQVBfSU5WQUxJRF9QVFIpKSB7DQo+ICAJCW5pbGZzX2NyaXQoYm1hcC0+Yl9pbm9kZS0+
aV9zYiwNCj4gLQkJCSAgICIlcyAoaW5vPSVsdSk6IGludmFsaWQgcG9pbnRlcjogJWxsdSIsDQo+
ICsJCQkgICAiJXMgKGlubz0lbGx1KTogaW52YWxpZCBwb2ludGVyOiAlbGx1IiwNCj4gIAkJCSAg
IF9fZnVuY19fLA0KPiAgCQkJICAgYm1hcC0+Yl9pbm9kZS0+aV9pbm8sICh1bnNpZ25lZCBsb25n
IGxvbmcpcHRyKTsNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxm
czIvZ2Npbm9kZS5jIGIvZnMvbmlsZnMyL2djaW5vZGUuYw0KPiBpbmRleCA1NjFjMjIwNzk5Yzdh
ZWU4NzlhZDg2Njg2NWUzNzc3OTljOGVlNmJiLi42MmQ0YzFiNzg3ZTk1Yzk2MWEzNjBhNDIxNGQ2
MjFkNTY0YWQ4YjRjIDEwMDY0NA0KPiAtLS0gYS9mcy9uaWxmczIvZ2Npbm9kZS5jDQo+ICsrKyBi
L2ZzL25pbGZzMi9nY2lub2RlLmMNCj4gQEAgLTEzNyw3ICsxMzcsNyBAQCBpbnQgbmlsZnNfZ2Nj
YWNoZV93YWl0X2FuZF9tYXJrX2RpcnR5KHN0cnVjdCBidWZmZXJfaGVhZCAqYmgpDQo+ICAJCXN0
cnVjdCBpbm9kZSAqaW5vZGUgPSBiaC0+Yl9mb2xpby0+bWFwcGluZy0+aG9zdDsNCj4gIA0KPiAg
CQluaWxmc19lcnIoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICJJL08gZXJyb3IgcmVhZGluZyAlcyBi
bG9jayBmb3IgR0MgKGlubz0lbHUsIHZibG9ja25yPSVsbHUpIiwNCj4gKwkJCSAgIkkvTyBlcnJv
ciByZWFkaW5nICVzIGJsb2NrIGZvciBHQyAoaW5vPSVsbHUsIHZibG9ja25yPSVsbHUpIiwNCj4g
IAkJCSAgYnVmZmVyX25pbGZzX25vZGUoYmgpID8gIm5vZGUiIDogImRhdGEiLA0KPiAgCQkJICBp
bm9kZS0+aV9pbm8sICh1bnNpZ25lZCBsb25nIGxvbmcpYmgtPmJfYmxvY2tucik7DQo+ICAJCXJl
dHVybiAtRUlPOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2lub2RlLmMgYi9mcy9uaWxmczIv
aW5vZGUuYw0KPiBpbmRleCA1MWJkZTQ1ZDU4NjUwOWRkYTNlZjBjYjdjNDZmYWNiN2ZiMmM2MWRk
Li41MWY3ZTEyNWEzMTFiODY4ODYwZTNlMTExNzAwZDQ5ZDRjYjk4ZmE2IDEwMDY0NA0KPiAtLS0g
YS9mcy9uaWxmczIvaW5vZGUuYw0KPiArKysgYi9mcy9uaWxmczIvaW5vZGUuYw0KPiBAQCAtMTA4
LDcgKzEwOCw3IEBAIGludCBuaWxmc19nZXRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgc2Vj
dG9yX3QgYmxrb2ZmLA0KPiAgCQkJCSAqIGJlIGxvY2tlZCBpbiB0aGlzIGNhc2UuDQo+ICAJCQkJ
ICovDQo+ICAJCQkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCQkJICAgIiVzIChpbm89
JWx1KTogYSByYWNlIGNvbmRpdGlvbiB3aGlsZSBpbnNlcnRpbmcgYSBkYXRhIGJsb2NrIGF0IG9m
ZnNldD0lbGx1IiwNCj4gKwkJCQkJICAgIiVzIChpbm89JWxsdSk6IGEgcmFjZSBjb25kaXRpb24g
d2hpbGUgaW5zZXJ0aW5nIGEgZGF0YSBibG9jayBhdCBvZmZzZXQ9JWxsdSIsDQo+ICAJCQkJCSAg
IF9fZnVuY19fLCBpbm9kZS0+aV9pbm8sDQo+ICAJCQkJCSAgICh1bnNpZ25lZCBsb25nIGxvbmcp
Ymxrb2ZmKTsNCj4gIAkJCQllcnIgPSAtRUFHQUlOOw0KPiBAQCAtNzg5LDcgKzc4OSw3IEBAIHN0
YXRpYyB2b2lkIG5pbGZzX3RydW5jYXRlX2JtYXAoc3RydWN0IG5pbGZzX2lub2RlX2luZm8gKmlp
LA0KPiAgCQlnb3RvIHJlcGVhdDsNCj4gIA0KPiAgZmFpbGVkOg0KPiAtCW5pbGZzX3dhcm4oaWkt
PnZmc19pbm9kZS5pX3NiLCAiZXJyb3IgJWQgdHJ1bmNhdGluZyBibWFwIChpbm89JWx1KSIsDQo+
ICsJbmlsZnNfd2FybihpaS0+dmZzX2lub2RlLmlfc2IsICJlcnJvciAlZCB0cnVuY2F0aW5nIGJt
YXAgKGlubz0lbGx1KSIsDQo+ICAJCSAgIHJldCwgaWktPnZmc19pbm9kZS5pX2lubyk7DQo+ICB9
DQo+ICANCj4gQEAgLTEwMjYsNyArMTAyNiw3IEBAIGludCBuaWxmc19zZXRfZmlsZV9kaXJ0eShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnJfZGlydHkpDQo+ICAJCQkgKiB0aGlz
IGlub2RlLg0KPiAgCQkJICovDQo+ICAJCQluaWxmc193YXJuKGlub2RlLT5pX3NiLA0KPiAtCQkJ
CSAgICJjYW5ub3Qgc2V0IGZpbGUgZGlydHkgKGlubz0lbHUpOiB0aGUgZmlsZSBpcyBiZWluZyBm
cmVlZCIsDQo+ICsJCQkJICAgImNhbm5vdCBzZXQgZmlsZSBkaXJ0eSAoaW5vPSVsbHUpOiB0aGUg
ZmlsZSBpcyBiZWluZyBmcmVlZCIsDQo+ICAJCQkJICAgaW5vZGUtPmlfaW5vKTsNCj4gIAkJCXNw
aW5fdW5sb2NrKCZuaWxmcy0+bnNfaW5vZGVfbG9jayk7DQo+ICAJCQlyZXR1cm4gLUVJTlZBTDsg
LyoNCj4gQEAgLTEwNTcsNyArMTA1Nyw3IEBAIGludCBfX25pbGZzX21hcmtfaW5vZGVfZGlydHko
c3RydWN0IGlub2RlICppbm9kZSwgaW50IGZsYWdzKQ0KPiAgCWVyciA9IG5pbGZzX2xvYWRfaW5v
ZGVfYmxvY2soaW5vZGUsICZpYmgpOw0KPiAgCWlmICh1bmxpa2VseShlcnIpKSB7DQo+ICAJCW5p
bGZzX3dhcm4oaW5vZGUtPmlfc2IsDQo+IC0JCQkgICAiY2Fubm90IG1hcmsgaW5vZGUgZGlydHkg
KGlubz0lbHUpOiBlcnJvciAlZCBsb2FkaW5nIGlub2RlIGJsb2NrIiwNCj4gKwkJCSAgICJjYW5u
b3QgbWFyayBpbm9kZSBkaXJ0eSAoaW5vPSVsbHUpOiBlcnJvciAlZCBsb2FkaW5nIGlub2RlIGJs
b2NrIiwNCj4gIAkJCSAgIGlub2RlLT5pX2lubywgZXJyKTsNCj4gIAkJcmV0dXJuIGVycjsNCj4g
IAl9DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvbWR0LmMgYi9mcy9uaWxmczIvbWR0LmMNCj4g
aW5kZXggOTQ2YjBkMzUzNGE1ZjIyZjM0YWM0NGE5MWZiMTIxNTQxODgxYzU0OC4uMDlhZGI0MGM2
NWU1MDVkOTIwMTJhM2QyZjVmZThhNTY5NmUxMDA1NiAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMy
L21kdC5jDQo+ICsrKyBiL2ZzL25pbGZzMi9tZHQuYw0KPiBAQCAtMjAzLDcgKzIwMyw3IEBAIHN0
YXRpYyBpbnQgbmlsZnNfbWR0X3JlYWRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWdu
ZWQgbG9uZyBibG9jaywNCj4gIAllcnIgPSAtRUlPOw0KPiAgCWlmICghYnVmZmVyX3VwdG9kYXRl
KGZpcnN0X2JoKSkgew0KPiAgCQluaWxmc19lcnIoaW5vZGUtPmlfc2IsDQo+IC0JCQkgICJJL08g
ZXJyb3IgcmVhZGluZyBtZXRhLWRhdGEgZmlsZSAoaW5vPSVsdSwgYmxvY2stb2Zmc2V0PSVsdSki
LA0KPiArCQkJICAiSS9PIGVycm9yIHJlYWRpbmcgbWV0YS1kYXRhIGZpbGUgKGlubz0lbGx1LCBi
bG9jay1vZmZzZXQ9JWx1KSIsDQo+ICAJCQkgIGlub2RlLT5pX2lubywgYmxvY2spOw0KPiAgCQln
b3RvIGZhaWxlZF9iaDsNCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9mcy9uaWxmczIvbmFtZWkuYyBi
L2ZzL25pbGZzMi9uYW1laS5jDQo+IGluZGV4IDQwZjRiMWEyODcwNWI2ZTBlYjhmMDk3OGNmM2Fj
MThiNDNhYTEzMzEuLjQwYWM2NzllYzU2ZTQwMGIxZGY5OGU5YmU2ZmU5Y2EzMzhhOWJhNTEgMTAw
NjQ0DQo+IC0tLSBhL2ZzL25pbGZzMi9uYW1laS5jDQo+ICsrKyBiL2ZzL25pbGZzMi9uYW1laS5j
DQo+IEBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGljIGludCBuaWxmc19kb191bmxpbmsoc3RydWN0
IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gIA0KPiAgCWlmICghaW5vZGUt
PmlfbmxpbmspIHsNCj4gIAkJbmlsZnNfd2Fybihpbm9kZS0+aV9zYiwNCj4gLQkJCSAgICJkZWxl
dGluZyBub25leGlzdGVudCBmaWxlIChpbm89JWx1KSwgJWQiLA0KPiArCQkJICAgImRlbGV0aW5n
IG5vbmV4aXN0ZW50IGZpbGUgKGlubz0lbGx1KSwgJWQiLA0KPiAgCQkJICAgaW5vZGUtPmlfaW5v
LCBpbm9kZS0+aV9ubGluayk7DQo+ICAJCXNldF9ubGluayhpbm9kZSwgMSk7DQo+ICAJfQ0KPiBk
aWZmIC0tZ2l0IGEvZnMvbmlsZnMyL3NlZ21lbnQuYyBiL2ZzL25pbGZzMi9zZWdtZW50LmMNCj4g
aW5kZXggMDk4YTNiZDEwM2UwNGNkMDliMDY4OWZlMjAxNzM4MGQ3NDY2NDQ5Ni4uNGIxYmY1NTlm
MzUyNGIxY2MzOTY1ZGFlOWZkM2U1NzQ1NzE4NTY5ZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMy
L3NlZ21lbnQuYw0KPiArKysgYi9mcy9uaWxmczIvc2VnbWVudC5jDQo+IEBAIC0yMDI0LDcgKzIw
MjQsNyBAQCBzdGF0aWMgaW50IG5pbGZzX3NlZ2N0b3JfY29sbGVjdF9kaXJ0eV9maWxlcyhzdHJ1
Y3QgbmlsZnNfc2NfaW5mbyAqc2NpLA0KPiAgCQkJCWlmaWxlLCBpaS0+dmZzX2lub2RlLmlfaW5v
LCAmaWJoKTsNCj4gIAkJCWlmICh1bmxpa2VseShlcnIpKSB7DQo+ICAJCQkJbmlsZnNfd2Fybihz
Y2ktPnNjX3N1cGVyLA0KPiAtCQkJCQkgICAibG9nIHdyaXRlcjogZXJyb3IgJWQgZ2V0dGluZyBp
bm9kZSBibG9jayAoaW5vPSVsdSkiLA0KPiArCQkJCQkgICAibG9nIHdyaXRlcjogZXJyb3IgJWQg
Z2V0dGluZyBpbm9kZSBibG9jayAoaW5vPSVsbHUpIiwNCj4gIAkJCQkJICAgZXJyLCBpaS0+dmZz
X2lub2RlLmlfaW5vKTsNCj4gIAkJCQlyZXR1cm4gZXJyOw0KPiAgCQkJfQ0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvbmlsZnMyLmggYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9u
aWxmczIuaA0KPiBpbmRleCA4ODgwYzExNzMzZGQzMDdjMjIzY2M2MmVlMzRlYmVmZjY1MGVjYjEy
Li44NmEwMDExYzllZWFmMDMxY2ZhMGI3OTg3NWIyYjEwNmVmOGI3Y2ZkIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9uaWxmczIuaA0KPiArKysgYi9pbmNsdWRlL3RyYWNlL2V2
ZW50cy9uaWxmczIuaA0KPiBAQCAtMTY1LDE0ICsxNjUsMTQgQEAgVFJBQ0VfRVZFTlQobmlsZnMy
X3NlZ21lbnRfdXNhZ2VfZnJlZWQsDQo+ICANCj4gIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfaW5z
ZXJ0X25ld19ibG9jaywNCj4gIAkgICAgVFBfUFJPVE8oc3RydWN0IGlub2RlICppbm9kZSwNCj4g
LQkJICAgICB1bnNpZ25lZCBsb25nIGlubywNCj4gKwkJICAgICB1NjQgaW5vLA0KPiAgCQkgICAg
IHVuc2lnbmVkIGxvbmcgYmxvY2spLA0KPiAgDQo+ICAJICAgIFRQX0FSR1MoaW5vZGUsIGlubywg
YmxvY2spLA0KPiAgDQo+ICAJICAgIFRQX1NUUlVDVF9fZW50cnkoDQo+ICAJCSAgICBfX2ZpZWxk
KHN0cnVjdCBpbm9kZSAqLCBpbm9kZSkNCj4gLQkJICAgIF9fZmllbGQodW5zaWduZWQgbG9uZywg
aW5vKQ0KPiArCQkgICAgX19maWVsZCh1NjQsIGlubykNCj4gIAkJICAgIF9fZmllbGQodW5zaWdu
ZWQgbG9uZywgYmxvY2spDQo+ICAJICAgICksDQo+ICANCj4gQEAgLTE4Miw3ICsxODIsNyBAQCBU
UkFDRV9FVkVOVChuaWxmczJfbWR0X2luc2VydF9uZXdfYmxvY2ssDQo+ICAJCSAgICBfX2VudHJ5
LT5ibG9jayA9IGJsb2NrOw0KPiAgCQkgICAgKSwNCj4gIA0KPiAtCSAgICBUUF9wcmludGsoImlu
b2RlID0gJXAgaW5vID0gJWx1IGJsb2NrID0gJWx1IiwNCj4gKwkgICAgVFBfcHJpbnRrKCJpbm9k
ZSA9ICVwIGlubyA9ICVsbHUgYmxvY2sgPSAlbHUiLA0KPiAgCQkgICAgICBfX2VudHJ5LT5pbm9k
ZSwNCj4gIAkJICAgICAgX19lbnRyeS0+aW5vLA0KPiAgCQkgICAgICBfX2VudHJ5LT5ibG9jaykN
Cj4gQEAgLTE5MCw3ICsxOTAsNyBAQCBUUkFDRV9FVkVOVChuaWxmczJfbWR0X2luc2VydF9uZXdf
YmxvY2ssDQo+ICANCj4gIFRSQUNFX0VWRU5UKG5pbGZzMl9tZHRfc3VibWl0X2Jsb2NrLA0KPiAg
CSAgICBUUF9QUk9UTyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAtCQkgICAgIHVuc2lnbmVkIGxv
bmcgaW5vLA0KPiArCQkgICAgIHU2NCBpbm8sDQo+ICAJCSAgICAgdW5zaWduZWQgbG9uZyBibGtv
ZmYsDQo+ICAJCSAgICAgZW51bSByZXFfb3AgbW9kZSksDQo+ICANCj4gQEAgLTE5OCw3ICsxOTgs
NyBAQCBUUkFDRV9FVkVOVChuaWxmczJfbWR0X3N1Ym1pdF9ibG9jaywNCj4gIA0KPiAgCSAgICBU
UF9TVFJVQ1RfX2VudHJ5KA0KPiAgCQkgICAgX19maWVsZChzdHJ1Y3QgaW5vZGUgKiwgaW5vZGUp
DQo+IC0JCSAgICBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcsIGlubykNCj4gKwkJICAgIF9fZmllbGQo
dTY0LCBpbm8pDQo+ICAJCSAgICBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcsIGJsa29mZikNCj4gIAkJ
ICAgIC8qDQo+ICAJCSAgICAgKiBVc2UgZmllbGRfc3RydWN0KCkgdG8gYXZvaWQgaXNfc2lnbmVk
X3R5cGUoKSBvbiB0aGUNCj4gQEAgLTIxNCw3ICsyMTQsNyBAQCBUUkFDRV9FVkVOVChuaWxmczJf
bWR0X3N1Ym1pdF9ibG9jaywNCj4gIAkJICAgIF9fZW50cnktPm1vZGUgPSBtb2RlOw0KPiAgCQkg
ICAgKSwNCj4gIA0KPiAtCSAgICBUUF9wcmludGsoImlub2RlID0gJXAgaW5vID0gJWx1IGJsa29m
ZiA9ICVsdSBtb2RlID0gJXgiLA0KPiArCSAgICBUUF9wcmludGsoImlub2RlID0gJXAgaW5vID0g
JWxsdSBibGtvZmYgPSAlbHUgbW9kZSA9ICV4IiwNCj4gIAkJICAgICAgX19lbnRyeS0+aW5vZGUs
DQo+ICAJCSAgICAgIF9fZW50cnktPmlubywNCj4gIAkJICAgICAgX19lbnRyeS0+Ymxrb2ZmLA0K

