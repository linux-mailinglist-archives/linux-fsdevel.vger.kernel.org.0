Return-Path: <linux-fsdevel+bounces-79087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLmAEhsSpmnmJwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:41:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9C1E5D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 435E5301BAAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30215347524;
	Mon,  2 Mar 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P2KmIsRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C53909B1;
	Mon,  2 Mar 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491254; cv=fail; b=Ywbopmh0pUAha67N3eRSgItW4FEtuird6qxOwxtshDc9AAuzIUK/B1eGfAby49Po27kXW1+/KYZp+uVseUevGZQYnYXdcVoRgEJiNBrjNbHLHVFDfZPFFfGq7dQNxxMrYgmNBJ7QMzA1x0sWCqwtDk2Y3fJZZEUiaYlco3V7gQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491254; c=relaxed/simple;
	bh=wvyiFVxybg47Mcu1UPTRmCPhKXcTjGJmrLjQRBCXRDM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=arhKLJvf7vCKNiXn5SD5BFGr1rrP4bOKCNpfXy2QUad05fcWR+Wu1oaBm5fs72YZzMI7Cn3ID9JG2YWbWuRLMwb3K+IK3H6oZ6wWkSltG8iJ40JwtrUxD2gWzD9NxcQJBRniAbLDPR12hmNN/E4uwXKa/bRTxhSYXmgnpYOnZI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P2KmIsRc; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Dn8AH2231878;
	Mon, 2 Mar 2026 22:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wvyiFVxybg47Mcu1UPTRmCPhKXcTjGJmrLjQRBCXRDM=; b=P2KmIsRc
	mQbjYia/l74V9B1j1fVnsCzvJnlfapgz+ehnGsRjbTQg84JFGSorNmfZhkf9Yaqr
	fOLb0FUYPYXgNt7eWeITt5RJkB8pebVR4S+1FfLs6YjMWSOZAavC/2nx/FlU+vxR
	oFgUkiq6GylhtsGNY9QCkKpBV4HvdvMGb4V/8zj6dx6oS67gqNDj7lXs81gelpIB
	+Fjqziu6wxS3B5r99iNTsYSVMDgvTlkqruAGk+NF4v06v3r2l1dbgjN7pdbHC2H1
	cPBuMI5h+Pm21TZxP//YvC7mkl2dLyKJMWXOqXGLvEQQ2FlyNQfVIumJTpO42ULB
	pL4hviPHzkh4eA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj0qha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:40:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIqpK9VS6BeUKongMAFnox/Jsg8c8I/wbJ8XqZoV6kUPMlYwX09B2ZYl8x3g8rBY/F1GZmlhplEnlerv3Bglo2Wi+O3Db06ujGQg11iDtJwkdw8C4BJx7NxcmXIyMR2Ow00u3esxQ9umKckFDgjVgNeD/uZ/qhMmGRAwYZLxIqiiOWcwJkRbF8YVokB2GaX/3CM1EgS4AkCXuAcj8nR4JGdhJqF6j+yoGC59ZlnrMzsWc+ulgoB4YojnSLqa8GBL6gwcUcZzoEN2Cfyc6WpS/NioZMbsAOZmvA/SLtjYBA9Tv+Gt2G2fzfb6XRwaD14gTNrNnEBo9NPsJaiNvtPC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvyiFVxybg47Mcu1UPTRmCPhKXcTjGJmrLjQRBCXRDM=;
 b=k2AeJHwUPXDF8O48KT/Yu0JIyxG56lswnNNRBPY9/UOsVNopaDmDGnm9/KEZzLjIVSBXi45BK0AvA0kG/qq9jIDrhDMjKyOXGgNl+wsFxmXh54GRZef3VrHo3jlRVXqqwD9KoZkI9x0fT8CqaMiLNTk4ypswKWqzF6DptxAhnD+qiEYEdf6ta4/tsQOgAGRhCirT+cXS5jZDhmD2lAL6CMSCzpYUtazQoq9i2n96vnUcl0N5xTp2pyw/EVFDgxVBbs0MzBcKGaF5pgEd6PnvbfoYR48AAO+uj+5BkKujyIVx5NmlPvJ7OOz4ZKXSsHVu38iuG3CSB6u1/kubO8rcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPFE061D9768.namprd15.prod.outlook.com (2603:10b6:518:1::4cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:40:05 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:40:05 +0000
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
Thread-Topic: [EXTERNAL] [PATCH v2 084/110] hfs: replace PRIino with %llu/%llx
 format strings
Thread-Index: AQHcqpMx+NxLh9ejn0CNwAL8fSccTrWb1d8A
Date: Mon, 2 Mar 2026 22:40:05 +0000
Message-ID: <03db867ab541fd2304b9a5d88a2ecadbd2d6e5c1.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-84-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-84-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPFE061D9768:EE_
x-ms-office365-filtering-correlation-id: 8d30e6d6-0fd5-4af1-8dfb-08de78aca656
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 ooZGz2Yu/dGE66ycztvj0hhDMBRTo+7aRjJbOMG1f6XYqSktKVCnOf3BDDs9ZcPqdXUKAPWevKDS86ofxJLkauAKHTAOeBJ3IW+DWMJg2WtAv0fQRtgTOie7Xs1SZKKvUEBBapHoZd6Ee7r53KwLxneCaA4xuIKMREtITESshhf/EMixAkwcDGLThWER81xYsR0z/81hjVFXeZciuvjnMBg0eomnPVyw/vWSCh+WYZPviIsoUbmdCryBlFibc8bylg61ye67aeAK9OkT1qrqqJOQ6WsbTzT/lnFCMfMQi8tcl8lNnLZcbuaJ2nOINM9cPoTsQEZz/70D6W45m6rGqB3ufdebxm7bsK601F5dewKGRuH2llUthfDABlDs7WcJ4Mejfjg4gcEYpstFnn8GfcXJxy6qzWHk+R8jkNJyr2o7A+elVmn07lLAPsrOLoOoA9mHjxgwOqm+AvkXHBawF9vQ0k624jI1zOGRApSHNfwtIz4PzCt9DJLUIxkTklheksPIdURz0L3V5b2+HD89qtyl74dnArC+i6GtFcM5Nc0hb7FV0/Pl7uJtaUDk4P5ulwcJhk3+WEK6ILtGPT5hfis23lmbx4F3spyiQZOiGv64uofosDle5EhqyOcXAYQARQywpff1s/6dZ2f/PQgnrDFBkh4uObVLxbzsCsnCRSl+zh/q2DzBD+5lvO/3W/ZOtbNvx12CytJnAtpBDYgJ3eNefkV2HRhY0K1M6HzFJihPCi0+2tbVWpawfs5vScVxBXZL0XaVRervdWw0T99dDO4wsCf0tK4f/bqjxDf8QKQIJ9mOSJILJzV8xsH2xY4I
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3BVeUQ2TkRyQmlFYXkwb1BsdVQwV3NaTFArMUNTUjhvRW40bXp4aVNTVkh5?=
 =?utf-8?B?ZiswbXRzOGk2VWJEOWdobzhKdTgzbXVtWld6TWhxVWlUTGJadkdWejMvbmRH?=
 =?utf-8?B?UFZPOFlCOGE0c25jTlg3N2RNYStJM1BBTFlWSHF0UXhTTjdJL3lHMzh0R2VG?=
 =?utf-8?B?S3NlTVVmTGVVWkVYTUllazI0SFZKS0M2akQrclY5bHhkelJJVUQ3elpvSy9L?=
 =?utf-8?B?Z2tzTlNiVW91VXZ5MHVTalJYMTNuT3ZESVBHYzNOblkvWjVpZkpkTys5a3Z2?=
 =?utf-8?B?c3BuWWpzQ3NtakVMVTBQRFJCYno2amJKSjJSWTFLVndOQ2kvRmxZU2V2aXRB?=
 =?utf-8?B?Wi9neXF1N25FNEdmNjVlTGpZNTlpbDV2WDhHZVIreDl1aGxaM0Y5ZWZoMkpi?=
 =?utf-8?B?QURIK1BDZ01tbzkrMDg2YTR1aTE1RmduQ0g5WXdQcm0wcllpdFh1TnIxclBB?=
 =?utf-8?B?MFZDZGpjTThwRURnMjJuTkttYmEwQWFERzZtVllCTEYvVExReGJhRmxQZWhp?=
 =?utf-8?B?N2JodUlDWWRrdzVPWnJGdWk5UlhDWmQyRngvNnNzdXZBTUVIaEJTMGlleXFk?=
 =?utf-8?B?TlFJaDZIOGFScGtobnNDZW5XMERaalBNNDVQT3lSZFA0ODllUTIrOGcxcFVX?=
 =?utf-8?B?SWR4a2dKWFMzY3hxMkNlNk1NL0MzMXJ6NGlSMldaMmxWY3ZMZnd1TUV3QzV4?=
 =?utf-8?B?Nms3akswUm1XZE9mVmplTXVlc3hqZmxLT25xSHFVTzE0V3Zmc2c5ODFCNFpL?=
 =?utf-8?B?Ym84Mjl4ZmZ5Z3ppVXh6bVRId2ZYdnFNOG9KQlp1RmdKbGFBU1NmK0lkWUpk?=
 =?utf-8?B?R3RCY1J4T1o3V1B0a2lJSWEyd3VBZmVtZXZUdGNqN0dwcUlyandpUm0vREtz?=
 =?utf-8?B?bmRoa0pBL2llM3JHT3dlYm92ZWNzWGxHYlJBc1hNb21WT3B4Z3N4L0Z6UlAw?=
 =?utf-8?B?WEZ0eVdBUjV4amg4OFIzQldtK0hjZGhRempzMXpzVWdWNVAxRC9nYk1pVXFP?=
 =?utf-8?B?MXRTMHJkRGhZTExqa1Bmd2RCb0RYMHRUU1BQbkIzOHFDM3FtZ1NCbTNhMWc2?=
 =?utf-8?B?K2VMaCtpN0FGL1RmTlppTXRwVFZzSEh3WlJWTFpYZVdYRGhrN202Z2J4cjNv?=
 =?utf-8?B?SUZZejVCZEgyUzlORUhkZVRBZ0h0cWZNV3Bzbmc2UFpKS1pzamFKSktiSndF?=
 =?utf-8?B?T3E5dkNETGRjOVVsa0JpUWc1U1RwRWYxdFY2RjRzS09VNk94aWhEOGZ1WnlW?=
 =?utf-8?B?MzRGdTA1aEZzb01GR0RlSEN0UytjdlJyRDV5K28xTVdBdXJCRGtYcXNmQVVp?=
 =?utf-8?B?ZnFWbDVodXZKR2laMlBLZkgzMHBRYkwyQmtTZHE4Q05RMGtkRXRrMUlGSVl4?=
 =?utf-8?B?UWJjMXQzL2tPNXdZdC90U2owRFpWMjFzbS9nV3JyeXV5MG5ycTBSL1BHZ1ZD?=
 =?utf-8?B?cFlIRVhBOXN4QzRoSVhJSUZXbzgwUytQSlhlVjhuWWQ4U2FNUDRkamJWK3Ri?=
 =?utf-8?B?NWFteXkyOG05S04rbENDOXl2ank3RlRsYjJQK09YWWlKY2ZPMmhvTDFkSmh6?=
 =?utf-8?B?ZmxqSWN2MmVVSWxXY05reE02MFU0UmgrcHpCczRBaGcwZDU2ekxqLzdPL3RT?=
 =?utf-8?B?QU4veTF5QlVHaUxxNzh2TjVBSjJvMmhXRXRnb1libXVUSDZIemFwcDluM3kw?=
 =?utf-8?B?MVkzTTFuQmdUcnZ6WGNwZStmNHJOY3NqQWxKQWI2OERUMUN4NHlDb2orUVZW?=
 =?utf-8?B?T0VqV0pvam9iWmVCMFdGS3hzODlNU0MwTnhmMnR1NnJpcnZUQlN6QWtoa3M4?=
 =?utf-8?B?YXZVVGlJc0owZ2dMSFlLS1dubXlhUUsrdm1rbE85VVg2OFNTLzJVZkJpRmg4?=
 =?utf-8?B?Zi9hTnFxbitBKzZVOWdlcUZOc0pnVjMvcFNkZG5CU295QThWcWVWRFRIL2Q3?=
 =?utf-8?B?cUFXZGQwNlgreU9pK1F2UGFGK0kvS3Vmc0pmc01vbjFqc2pRYis1RG9KalBM?=
 =?utf-8?B?V0NvcVcxYm4wMzd2QytnSVZRbnlCbGhPU25HMkxXV3J4SVpDNjZHRDIyd1BI?=
 =?utf-8?B?V0xnWFB2cVlid21Jd2kxNUpEQUtyMzU1Q3crMkRsaGdpUkd6cUJpeEQrUVd1?=
 =?utf-8?B?QzBsdHBlbTVBVDM3aTR5eDM1QWxTdEhjTGhQWHpUN0grZkpETFdmZi9SU1l3?=
 =?utf-8?B?KzFEVW9Pa1N2YzdmeFN6aEFpeVJNMXVPalREYVVLbWFTNXFmNkQ0WXZ3MFhO?=
 =?utf-8?B?UDFWODJWekp6NjZvTU9GRVkvTmRKeHhHNGwrUFZKVThjNjZJTzl0RUp2SWZJ?=
 =?utf-8?B?OXNmSGE0TEExaFNZNW1Qc01oVFFRVitIS0RSUWNoWW5YOXJHN0N0NDFZTGpO?=
 =?utf-8?Q?UXM+spwWtnbbC8TBgsCzcXLLYJ/qnAWLcVQPA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE70ABD87053446B519F6717D20B910@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30e6d6-0fd5-4af1-8dfb-08de78aca656
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:40:05.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlzlxQegRMRT0GzdIH1F7vVPhQpkKeKm/W5FxOmpZiLcSAoPKgB3aeA+4uTd+TWJ+VLWTEGQKabqr26HMv0Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE061D9768
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a611ce cx=c_pps
 a=M+4CHf8fKMkYOwSYEMZyZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=yg8HEki30JHSbY7BnakA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NyBTYWx0ZWRfX0IodLcGkW/B+
 YTCOob3gqMCs58OeqFMr/e+a6PzSmuunuBqfVvIik8CkW6v976N5y5v7UwU37sQ1ZI4rBCqfb/q
 esANCJC+cnHtPHkNVWa2MUFavkYQQSe4km5bZQw+Eo9vbP9GwCmNx3z1t84t+GOkHYUWI555rLX
 7yNHC4K+557PyUqeNkv3iurOk06L5Tsbm9x8A8jbV6I7qHX03cC79/oaWCmgLv2YvTe7D4yYqD5
 E1WEGHarzJgiJ69zc72r9lPTs9jEseTi6UV25nw9AiiTnh1KCGB1xFnSLNwUH6U4V7OlHcEd9ua
 y/zGYWcl4F4OF4tAeWwpkW0hbunI8QJBfNDlAoMCHrbmDvuzrsn4mMnAlXjn04x3Yikoj7VcdIz
 mc/xrEO8x9rFd34gf+M0jJnSQJHhlgf5/hiG6+q2FdUDe0mZdqysFGzDrsKMqYN5CYeTtECYx6q
 +fD6J2zf1ucgrupKsMA==
X-Proofpoint-GUID: ccL02fxDQi3_v42g1W7RMUI5KNjfU2As
X-Proofpoint-ORIG-GUID: h292VF2q0kmRUjKtfU-LM7iyE38jGXvw
Subject: Re:  [PATCH v2 084/110] hfs: replace PRIino with %llu/%llx format
 strings
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020167
X-Rspamd-Queue-Id: E2F9C1E5D5B
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
	TAGGED_FROM(0.00)[bounces-79087-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjI1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Tm93IHRoYXQgaV9pbm8gaXMgdTY0IGFuZCB0aGUgUFJJaW5vIGZvcm1hdCBtYWNybyBoYXMgYmVl
biByZW1vdmVkLA0KPiByZXBsYWNlIGFsbCB1c2VzIGluIGhmcyB3aXRoIHRoZSBjb25jcmV0ZSBm
b3JtYXQgc3RyaW5ncy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZnMvaGZzL2NhdGFsb2cuYyB8IDIgKy0NCj4gIGZzL2hm
cy9leHRlbnQuYyAgfCA0ICsrLS0NCj4gIGZzL2hmcy9pbm9kZS5jICAgfCA0ICsrLS0NCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL2hmcy9jYXRhbG9nLmMgYi9mcy9oZnMvY2F0YWxvZy5jDQo+IGluZGV4IGIw
N2MwYTNmZmM2MTU4NDE2NWU4Y2M5ZjY0NmRlNjA2NmE2YWQyYzkuLjdmNTMzOWVlNTdjMTVhYWUy
ZDVkMDA0NzQxMzNhOTg1YmUzYWY2Y2EgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9jYXRhbG9nLmMN
Cj4gKysrIGIvZnMvaGZzL2NhdGFsb2cuYw0KPiBAQCAtNDE3LDcgKzQxNyw3IEBAIGludCBoZnNf
Y2F0X21vdmUodTMyIGNuaWQsIHN0cnVjdCBpbm9kZSAqc3JjX2RpciwgY29uc3Qgc3RydWN0IHFz
dHIgKnNyY19uYW1lLA0KPiAgCWludCBlbnRyeV9zaXplLCB0eXBlOw0KPiAgCWludCBlcnI7DQo+
ICANCj4gLQloZnNfZGJnKCJjbmlkICV1IC0gKGlubyAlIiBQUklpbm8gInUsIG5hbWUgJXMpIC0g
KGlubyAlIiBQUklpbm8gInUsIG5hbWUgJXMpXG4iLA0KPiArCWhmc19kYmcoImNuaWQgJXUgLSAo
aW5vICVsbHUsIG5hbWUgJXMpIC0gKGlubyAlbGx1LCBuYW1lICVzKVxuIiwNCj4gIAkJY25pZCwg
c3JjX2Rpci0+aV9pbm8sIHNyY19uYW1lLT5uYW1lLA0KPiAgCQlkc3RfZGlyLT5pX2lubywgZHN0
X25hbWUtPm5hbWUpOw0KPiAgCXNiID0gc3JjX2Rpci0+aV9zYjsNCj4gZGlmZiAtLWdpdCBhL2Zz
L2hmcy9leHRlbnQuYyBiL2ZzL2hmcy9leHRlbnQuYw0KPiBpbmRleCA2MDg3NWNjMjM4ODBiNzU4
YmJiYjVlNGI4MjgxZDllZTFmMmRiY2JiLi5mMDY2YTk5YTg2M2JjNzM5OTQ4YWFjOTIxYmM5MDY4
NzRjNjAwOWIyIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvZXh0ZW50LmMNCj4gKysrIGIvZnMvaGZz
L2V4dGVudC5jDQo+IEBAIC00MTEsNyArNDExLDcgQEAgaW50IGhmc19leHRlbmRfZmlsZShzdHJ1
Y3QgaW5vZGUgKmlub2RlKQ0KPiAgCQlnb3RvIG91dDsNCj4gIAl9DQo+ICANCj4gLQloZnNfZGJn
KCJpbm8gJSIgUFJJaW5vICJ1LCBzdGFydCAldSwgbGVuICV1XG4iLCBpbm9kZS0+aV9pbm8sIHN0
YXJ0LCBsZW4pOw0KPiArCWhmc19kYmcoImlubyAlbGx1LCBzdGFydCAldSwgbGVuICV1XG4iLCBp
bm9kZS0+aV9pbm8sIHN0YXJ0LCBsZW4pOw0KPiAgCWlmIChIRlNfSShpbm9kZSktPmFsbG9jX2Js
b2NrcyA9PSBIRlNfSShpbm9kZSktPmZpcnN0X2Jsb2Nrcykgew0KPiAgCQlpZiAoIUhGU19JKGlu
b2RlKS0+Zmlyc3RfYmxvY2tzKSB7DQo+ICAJCQloZnNfZGJnKCJmaXJzdF9leHRlbnQ6IHN0YXJ0
ICV1LCBsZW4gJXVcbiIsDQo+IEBAIC00ODIsNyArNDgyLDcgQEAgdm9pZCBoZnNfZmlsZV90cnVu
Y2F0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAgCXUzMiBzaXplOw0KPiAgCWludCByZXM7DQo+
ICANCj4gLQloZnNfZGJnKCJpbm8gJSIgUFJJaW5vICJ1LCBwaHlzX3NpemUgJWxsdSAtPiBpX3Np
emUgJWxsdVxuIiwNCj4gKwloZnNfZGJnKCJpbm8gJWxsdSwgcGh5c19zaXplICVsbHUgLT4gaV9z
aXplICVsbHVcbiIsDQo+ICAJCWlub2RlLT5pX2lubywgKGxvbmcgbG9uZylIRlNfSShpbm9kZSkt
PnBoeXNfc2l6ZSwNCj4gIAkJaW5vZGUtPmlfc2l6ZSk7DQo+ICAJaWYgKGlub2RlLT5pX3NpemUg
PiBIRlNfSShpbm9kZSktPnBoeXNfc2l6ZSkgew0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2lub2Rl
LmMgYi9mcy9oZnMvaW5vZGUuYw0KPiBpbmRleCBiMTk4NjY1MjVjMWU5YzQzZGVjZjNhOTQzYzcw
OTkyMmVlODYzMGY2Li45NWYwMzMzYTYwOGIwZmI1NzIzOWNmNWVlYzdkOTQ4OWEyNWVmYjNhIDEw
MDY0NA0KPiAtLS0gYS9mcy9oZnMvaW5vZGUuYw0KPiArKysgYi9mcy9oZnMvaW5vZGUuYw0KPiBA
QCAtMjcwLDcgKzI3MCw3IEBAIHZvaWQgaGZzX2RlbGV0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlKQ0KPiAgew0KPiAgCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCj4g
IA0KPiAtCWhmc19kYmcoImlubyAlIiBQUklpbm8gInVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICsJ
aGZzX2RiZygiaW5vICVsbHVcbiIsIGlub2RlLT5pX2lubyk7DQo+ICAJaWYgKFNfSVNESVIoaW5v
ZGUtPmlfbW9kZSkpIHsNCj4gIAkJYXRvbWljNjRfZGVjKCZIRlNfU0Ioc2IpLT5mb2xkZXJfY291
bnQpOw0KPiAgCQlpZiAoSEZTX0koaW5vZGUpLT5jYXRfa2V5LlBhcklEID09IGNwdV90b19iZTMy
KEhGU19ST09UX0NOSUQpKQ0KPiBAQCAtNDU1LDcgKzQ1NSw3IEBAIGludCBoZnNfd3JpdGVfaW5v
ZGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpDQo+
ICAJaGZzX2NhdF9yZWMgcmVjOw0KPiAgCWludCByZXM7DQo+ICANCj4gLQloZnNfZGJnKCJpbm8g
JSIgUFJJaW5vICJ1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiArCWhmc19kYmcoImlubyAlbGx1XG4i
LCBpbm9kZS0+aV9pbm8pOw0KPiAgCXJlcyA9IGhmc19leHRfd3JpdGVfZXh0ZW50KGlub2RlKTsN
Cj4gIAlpZiAocmVzKQ0KPiAgCQlyZXR1cm4gcmVzOw0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xh
diBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

