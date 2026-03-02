Return-Path: <linux-fsdevel+bounces-79081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLppBRMQpmnlJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:32:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 201321E5943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6547730A1602
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1F31F9B4;
	Mon,  2 Mar 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fPi7yGIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310393909A6;
	Mon,  2 Mar 2026 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490413; cv=fail; b=YPcw3o7VuMz/9JF8dC6ELI61GRc0XOnnuF0fHUhbUCqqgibruBQzyxv03nFqJGXphYlga2/yswR3S4JPoDym0ETT3gLHUMpCcSm5rWP3OvBbFxglUh5Dw9ynUfKQCXBrN26aweTyZR+grONeAKKTu+3gbR4pZcStorUNvBADLOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490413; c=relaxed/simple;
	bh=uZ60Yqc7eq8EcLOY3OXxCeDzWF/RRQAsWvDRVSzsWDo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XyaluQuTsfMIzmaIJhTdba2VwWGm3DlwMXIgSbtR0VI/JElPuYBDra1rgLODxsMs01RjpQQ2RC+0nib4BS04UMXwdssRTlUFYtJRQjQw4HAUI3gkAP4FgcwvFxPTnK/p4NWP8PJUflJgaXD/YVzRUT3jx5GhkiA98mt6XE4qnUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fPi7yGIN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622C8YAW1479574;
	Mon, 2 Mar 2026 22:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uZ60Yqc7eq8EcLOY3OXxCeDzWF/RRQAsWvDRVSzsWDo=; b=fPi7yGIN
	tTQp00FXmhO6Cm8s0QVMHHnt1X01BKvYRnnCUIeo7JmcYkmK1kythJCVem26SIa7
	tCIaXxnNoAmgBE7AoPBLx+XymbLhT4CqcaZVzD8qmvXsrH1+9PYG3k+fduJZ44Uo
	BBRiM/66y6DXrZ7PjsY898mwyMVlofE/aV2MeCZs1K5PPf94S4fbFCgiJSKKF281
	Y/W95bAmLQeIuLVjLMhHBl2EPMS6aQMxag4S5CjS3xX96hvV0VpVQFF2gY+DQcFB
	NS/D3EXEAfS+3pgCfOR9X8XGrT0ttgfTyrw1vhQTnWLqxLgpRhMO9sqhSNqeOUwV
	SF4SSfMAomz/hw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3reyh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:26:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR+3JJiNj6/IHxwCuALIr82qg2QA1Vq5F++jcNOqXuO0VNsmKSnDSQxxfdj6Wt+H+ho+fYWkUNxdJWktqjPIBIdA+YWcKr2dJvaqqhthJHlPrjqPqq6bekFXwYH7DQ2fmCTFDGuLyZZkauNMjxz6C+llwcxQE4QflCiMUYgMJJuPgRh05JxFY3g3aAcwcMKaFvKb3irB4y3EComBVmFbJvbaGDNk3r45nXzBiNnSK+Mmy0ZfpAqojNd/WXJerjuBOFoGyet+sZQeVFxt/QCpKbW8bpHdl1EtBakaJ7mxaiHr6NRUNygePYTUNcqEhNzCwJsSkUfVHhrLdkA99fvQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ60Yqc7eq8EcLOY3OXxCeDzWF/RRQAsWvDRVSzsWDo=;
 b=E/E+i0CEfs6kGas+dfFpEnfKR2DW9tH53wBNoK9ThM+iwra6cgwPklLERLQk1uWDVlpp0MdzlKAOysY8OWqsBeisTIEaZGD74ZZS6PWBOkX4lMQIT/PpVOUOyACJNb3osf679rddccfuLFPo7iwzLz5e4mwqOkzv7GafzWEGmWSRzOO4j4W0K7cOoIU5pA9/anLbfZ+OqCwKWeU+/i7t9vYV1naPwk7vvTCPrvkIqNHBzqO2QMF/uJF+z/buOgE9qC8Pqy0gc3Cz1vmLgUHxiJM1QDzwnlS+klR90cfNBxd5uupNAo3SDfQP17nG5yeE4GJTj1eILmZnWnohwjgYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4423.namprd15.prod.outlook.com (2603:10b6:a03:374::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:26:04 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 22:26:03 +0000
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
Thread-Topic: [EXTERNAL] [PATCH v2 031/110] hfs: use PRIino format for i_ino
Thread-Index: AQHcqoYSNHb+mCxJykasKzZgGEGO8bWb0g2A
Date: Mon, 2 Mar 2026 22:26:03 +0000
Message-ID: <4696c89e78ab7b1683a8a8661d49edfcc1d06f69.camel@ibm.com>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	 <20260302-iino-u64-v2-31-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-31-e5388800dae0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4423:EE_
x-ms-office365-filtering-correlation-id: e26e3f9c-5036-4fad-e511-08de78aab05f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 pWh4nIjXhs2zCY21ob3XvzulbeZX2z1vMLO/ll/ru+f7LgCo5ol7YGP/gLwH69P1dh0amAmn7UOf8e0GkJpQhXC7qpFEZFbE6gnLqdqfiONae7ZgbdAg8N0UmV2uHoDlLB7byd/TP8B3ziF3oFm+IuVtDQc+SVGYrFpo3wO62Og+0pRGcMIMRW17OHd2iIMOko8j87eZEl1vJ3+dPnRFNqGBosQQGq7nSy9+cvhIsQCyvl4vA4YM7IXwQ95iW4P/acQ8O9FkE3iyaM7A8DDB9eAgNIrspnfZ9szVbr+r60npmW5kbq7C5ZdUa7zIki6w2EK8EzYnOZ/n+2SfSTJ6lCtcoS8C7S6164+wxPW0t8IXN6DUh9JyGtLQOPeBtH8tlQeju1XK3b9BTBPHHi4nlIJvZZoLa8S9cy1qLXkQgpXj8nc0V3CRQFZMxrehbxhCt1akhNGzTvyDadPGDl54XOLYCarlshXAWQPQ/RiR1p0lSmjsMsijimk+FYogs/asHPgnGU0EPe/1u2ZVWirGejfiZ6pixsdRDDVWFjmRZGkPms9PfyYa4juUdfgdHZcIMmbCXnHGi3YfF0oupMMcBeQXIWGuA+oUyWOANbBf4D0vYW2otELt0cXSLd5OvRo+rAdO7lg37u/ZCq9yE2cblPC2kR2fIZChzjvvrNkQbiiZTYfQ9AMjjsJj5DWnBy/qLnJPc4iMICocMA0M3hPUJsV6hV4nNZPNXXH/+ETqE15WgE04B5sM/VS5n4UoBdf4s8mDxNRlInnvfioHxhREWVN7iRbwZtDGmxYwSHxW2kzHpsZ2uXvuuK8BCQARVyXK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STluOTVJcVViUGxHRUhLWGh2TWRSbVhOU0pJbmpvSEJFK0lJZTFlZ0FuSmJF?=
 =?utf-8?B?alBVOVB6aXBCcUJBc0FnZEN3UDhDdCtsZjIrRkd6Nm1mekNiV1QrOGRJTGZZ?=
 =?utf-8?B?UnE2UjRvU2czZ2phK2cyQ1ZSak5WdVdidGVZWllYdkFRNkNwUm9HVUE2UDNi?=
 =?utf-8?B?VXZOL01nZ3g2bCtOY0JyYzZPeDNFVms4aEppM0hpMlpIc1l0QlhJcGxONW8x?=
 =?utf-8?B?T1B2TlEwMytvenlsQUV5QU1zTkljbDBIVGFrYVQrK25BMC9PYUt1YXZ1amd2?=
 =?utf-8?B?TlFMaGpBZ01mNDRZY01HOXpiRGllcDZkTFBXSEl3ZFZDM0xIK0RpdW9WUmJI?=
 =?utf-8?B?WGdnQjJ2Ris2MTMzNjQwOXIwbXFGMldVNHUwakQ5Y2pOUHFzYXBPSmZrZ2Nz?=
 =?utf-8?B?cnJVajJ4MEdMMjdsaEVNZVY4b05qOGlHZ1dnTWF0TEx2L1N5enFJaU90bEZV?=
 =?utf-8?B?NnpXN05JenFsZytRamVOWlNlZ0F0SkZ6NndEQXZPSDN3NUN3bzZJdnFiNXo3?=
 =?utf-8?B?SmhlbnU3Z015Tyt6cU9lZXlhR2R3dVNhaWNYVXkxTXBuL1puOEtIQ1BDVFpR?=
 =?utf-8?B?UytHUjk4MUtuYUN6OEV4TXVCazQ1YU8zc01MQW5ISFVIS3Z3RU5iM3RJbzE5?=
 =?utf-8?B?aS9NN0xpZmJ6d3c1alFGMEswTEhRdDdMVlBselBVenVkWGd0ZnVidXM3bThY?=
 =?utf-8?B?WmdaMyt4eUxvYmhTemhlakpscTAxK3JlYjRYSkpucm54TE9LNmlpYXg3ZW90?=
 =?utf-8?B?WDk4bzZhWDNaQnhJTDlHeHdWei9IOVJyMm1mOVQ0b2N5ZG5iK1lDZzd4dEdP?=
 =?utf-8?B?d2JKUWVTNGFGOWIrcVdqdk1najNDZEMvNC8xbk5Od3BQNVFlY2RKU0JpOHVZ?=
 =?utf-8?B?TURsRGh5QkRyUFRvbzVIQ0UxZ2NNaEMwWUkxbkdRR0Q1T1F3TWhrcGhkVmd0?=
 =?utf-8?B?M0x3blNkbGsxZkVQVDlCTFF0K0FSMk1xWms0aEE4ZVJJdzIweXVxVTdvazNm?=
 =?utf-8?B?UjZLVXJxU1VRNnZnTzUzcXE2MEpIbDdTTHpPMUUrN3RwVlFSZGJyRHFtK1dY?=
 =?utf-8?B?M21OMCsyMlFrQnlVYkhmOTcxTVlYbnZaZlBrRVdkUVRKcTNSWnpHa1RQdUpu?=
 =?utf-8?B?eXZwaVkxdnloLzk0N0NubURnQmNUeFlCZWgrSitPVmxMU3liL01DNDhsRjBY?=
 =?utf-8?B?dTNoSUdHalJvdlI1QURaUVErZUhseHFmcE5ESk9rRmdoY0N4dUwxSEd0cEtp?=
 =?utf-8?B?L0VuOWs5TUtPTUc2VHNCSmE0dHE2c2ZJd2pPbnl3dXR2MVUwbWFtMGYvQTZT?=
 =?utf-8?B?M3ZRRmZNYTBHR0dna0E0b1J3ejhNK3Y0V21OdVBFb1QzT0hGT2lUNkxEYXNU?=
 =?utf-8?B?UGw0WTFwQzhtNDUyS2U4UWNPY1NQT2sxK0VCd1lhL1l3aVlkblMyd2tvM1l4?=
 =?utf-8?B?ajR3M1A3bTVTVWlMRkUrdURmclVJNnF2RW9ZMnlzdXNpMmV3QjArNTQ4YW5y?=
 =?utf-8?B?MnBSbDFqUUZHeURURTlNRFBmUTdGSE51TnMrbHBqb1ptWmg0S2s3SFZrUlBy?=
 =?utf-8?B?cWlBaitoaDZFRlM3VDlJMDlUSGJOSld6R3U1V2V5UFJqVmYwbFRvUEpUY21W?=
 =?utf-8?B?dnoxT2NDZ0VvaStHUHQ5QVRqaHRudkJJNlBITnI2Ukp0dUVSZ0dOdUpJdzJn?=
 =?utf-8?B?ckVId3FTQkhINW1WN0lKcDhzUGY4UDYzc3NtK2VjTnpPWTB0QUQ3V0J1RFdC?=
 =?utf-8?B?WnBJRzV3cXVqem9XVnJoWStmeHFaT0x5VU9Ha1UyQTZVMUM2eTRmQ2dybGdL?=
 =?utf-8?B?dmZJT2pUcUlVR0FSV2trRnVrQmdlMW5YeW16QUtGK2pHdmRzRklKbXFKRU1N?=
 =?utf-8?B?bGE1TzlKK3F3Y3drR2tVOWRMcks4SWN0S1JIbnFIeWlsWVhTQTZqZ3pzc3lE?=
 =?utf-8?B?NUpXR3k3QXhna3BXd3NZT2RlMTVLTm1kdVVtS1lHVFNGNWloSWpFdzV3SHVo?=
 =?utf-8?B?VXQ5cE5UbGtRTVRIU2ZhL1pIWUlGSmsyZmZ0aHhLY0k1SWNCalN5WVZxQnJm?=
 =?utf-8?B?dnA3MjhMV0tZb2FkVXVoSTI1MlBMLytTaXFQZTJ3ckpoZzAzKy9pZ1FrVlRU?=
 =?utf-8?B?Y1FZSHhmZVpXZ3ErbEFad2pta2dLbVR5NjA1cjVGejdKQnN4VHVlYnZ5QTNS?=
 =?utf-8?B?VWpXZ0plVFVWTWpOQVovRUk5TUdSdmtaNVBiSUlKZjlpN21LZVBDRmNiUU9m?=
 =?utf-8?B?YnRWdUZEYUQzUkhGMk5ieDdscVhybno4cEhLYWRWdC9zM0hlUkU5M2syZDJv?=
 =?utf-8?B?bzZLL1dFTTJhV1hjOW1sVGYzcU1FWmllRm9xZ0ZrUDM5TFY0RXNweStPLy95?=
 =?utf-8?Q?n32DhOKc09d8EvrEabCFZOeJoyrNWsh4R7/60?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B224E435F15EE94DBAC391DD3038C61C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e3f9c-5036-4fad-e511-08de78aab05f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 22:26:03.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4wjfCLD+oU2GkL2qKq9WHmFU9oMNpkCYUTTEE4j2QBaLRHsKud/rKPSy+63Kz7HrsEneK44++631gh1R44+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4423
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: T-7ZEgm9piPV-Jvbi7NCb7ZTNpKp2UNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NCBTYWx0ZWRfXyQ/tuReNm6Fx
 deCPCWsDQCJVo+ixYQ6Xy1eTT/arKjv4MggriID9p0Q1CnbL05VC6z5/Nug88wAE7w21oMyYt2X
 2gCbJByMFkhpxpe0Eb3kuog8UJgN/IKsQUfHJWb+ApBYpkc4uQFpYQTvjY6QAue/ZKYi/KVKDpr
 Ypu/QnkOILSTP7Ps7WX3pYTQ5rGyBfj+gAiumibpt/OMIU4AtAoQ/M+I7nGN/7QVg9IsFZNXFqQ
 epjsXzu63ucczPWhR763UvcGi5fdjBNVc+nOaq8imOVzcjdNTRh7bRYKTl+h5wcJIlsW6jEtuIZ
 gEFI74P61FO8sDTbpXhpKpGBDirlj2ZBTvddt372YoAT+z3EcyDDijRO0KWlQvGXQ0AMpTPv8VS
 DfyHyhhGDXX+ZlvPydPq14nRsmG4q6/2JjNk/JUrqaHanipKaiZGraKoX+QpcADiRzkWO5qyR9t
 Bv3ttc2LaaMjNsutudA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a60e82 cx=c_pps
 a=WJg1qJ+8ll6SXBP1xA03Zg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=yg8HEki30JHSbY7BnakA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: FvSQ4Yl7iwFutauLjP0nTTtplDCe7DuM
Subject: Re:  [PATCH v2 031/110] hfs: use PRIino format for i_ino
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020164
X-Rspamd-Queue-Id: 201321E5943
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
	TAGGED_FROM(0.00)[bounces-79081-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hartkopp.net,gondor.apana.org.au,kernel.org,yaina.de,oracle.com,redhat.com,davemloft.net,paragon-software.com,szeredi.hu,canonical.com,gmail.com,fluxnic.net,intel.com,talpey.com,linux.alibaba.com,paul-moore.com,codewreck.org,linux.intel.com,fasheh.com,crudebyte.com,amd.com,zeniv.linux.org.uk,infradead.org,microsoft.com,holtmann.org,linaro.org,ffwll.ch,arm.com,suse.com,google.com,iogearbox.net,goodmis.org,vivo.com,dev.tdt.de,evilplan.org,mit.edu,cs.cmu.edu,omnibond.com,namei.org,dilger.ca,physik.fu-berlin.de,schaufler-ca.com,themaw.net,linux.dev,efficios.com,fomichev.me,huawei.com,artax.karlin.mff.cuni.cz,suse.de,samba.org,hallyn.com,alarsen.net,manguebit.org,dubeyko.com,ionkov.net,nod.at,auristor.com,brown.name,pengutronix.de,suse.cz,tyhicks.com,secunet.com,wdc.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE1OjI0IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
Q29udmVydCBoZnMgaV9pbm8gZm9ybWF0IHN0cmluZ3MgdG8gdXNlIHRoZSBQUklpbm8gZm9ybWF0
DQo+IG1hY3JvIGluIHByZXBhcmF0aW9uIGZvciB0aGUgd2lkZW5pbmcgb2YgaV9pbm8gdmlhIGtp
bm9fdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiAgZnMvaGZzL2NhdGFsb2cuYyB8IDIgKy0NCj4gIGZzL2hmcy9leHRlbnQu
YyAgfCA0ICsrLS0NCj4gIGZzL2hmcy9pbm9kZS5jICAgfCA0ICsrLS0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL2hmcy9jYXRhbG9nLmMgYi9mcy9oZnMvY2F0YWxvZy5jDQo+IGluZGV4IGI4MGJhNDBlMzg3
NzYxMjM3NTlkZjRiODVjN2Y2NWRhYTE5YzY0MzYuLmIwN2MwYTNmZmM2MTU4NDE2NWU4Y2M5ZjY0
NmRlNjA2NmE2YWQyYzkgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9jYXRhbG9nLmMNCj4gKysrIGIv
ZnMvaGZzL2NhdGFsb2cuYw0KPiBAQCAtNDE3LDcgKzQxNyw3IEBAIGludCBoZnNfY2F0X21vdmUo
dTMyIGNuaWQsIHN0cnVjdCBpbm9kZSAqc3JjX2RpciwgY29uc3Qgc3RydWN0IHFzdHIgKnNyY19u
YW1lLA0KPiAgCWludCBlbnRyeV9zaXplLCB0eXBlOw0KPiAgCWludCBlcnI7DQo+ICANCj4gLQlo
ZnNfZGJnKCJjbmlkICV1IC0gKGlubyAlbHUsIG5hbWUgJXMpIC0gKGlubyAlbHUsIG5hbWUgJXMp
XG4iLA0KPiArCWhmc19kYmcoImNuaWQgJXUgLSAoaW5vICUiIFBSSWlubyAidSwgbmFtZSAlcykg
LSAoaW5vICUiIFBSSWlubyAidSwgbmFtZSAlcylcbiIsDQo+ICAJCWNuaWQsIHNyY19kaXItPmlf
aW5vLCBzcmNfbmFtZS0+bmFtZSwNCj4gIAkJZHN0X2Rpci0+aV9pbm8sIGRzdF9uYW1lLT5uYW1l
KTsNCj4gIAlzYiA9IHNyY19kaXItPmlfc2I7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnMvZXh0ZW50
LmMgYi9mcy9oZnMvZXh0ZW50LmMNCj4gaW5kZXggYTA5NzkwOGIyNjlkMGFkMTU3NTg0N2RkMDFk
NmQ0YTQ1MzgyNjJiZi4uNjA4NzVjYzIzODgwYjc1OGJiYmI1ZTRiODI4MWQ5ZWUxZjJkYmNiYiAx
MDA2NDQNCj4gLS0tIGEvZnMvaGZzL2V4dGVudC5jDQo+ICsrKyBiL2ZzL2hmcy9leHRlbnQuYw0K
PiBAQCAtNDExLDcgKzQxMSw3IEBAIGludCBoZnNfZXh0ZW5kX2ZpbGUoc3RydWN0IGlub2RlICpp
bm9kZSkNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+IC0JaGZzX2RiZygiaW5vICVsdSwg
c3RhcnQgJXUsIGxlbiAldVxuIiwgaW5vZGUtPmlfaW5vLCBzdGFydCwgbGVuKTsNCj4gKwloZnNf
ZGJnKCJpbm8gJSIgUFJJaW5vICJ1LCBzdGFydCAldSwgbGVuICV1XG4iLCBpbm9kZS0+aV9pbm8s
IHN0YXJ0LCBsZW4pOw0KPiAgCWlmIChIRlNfSShpbm9kZSktPmFsbG9jX2Jsb2NrcyA9PSBIRlNf
SShpbm9kZSktPmZpcnN0X2Jsb2Nrcykgew0KPiAgCQlpZiAoIUhGU19JKGlub2RlKS0+Zmlyc3Rf
YmxvY2tzKSB7DQo+ICAJCQloZnNfZGJnKCJmaXJzdF9leHRlbnQ6IHN0YXJ0ICV1LCBsZW4gJXVc
biIsDQo+IEBAIC00ODIsNyArNDgyLDcgQEAgdm9pZCBoZnNfZmlsZV90cnVuY2F0ZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlKQ0KPiAgCXUzMiBzaXplOw0KPiAgCWludCByZXM7DQo+ICANCj4gLQloZnNf
ZGJnKCJpbm8gJWx1LCBwaHlzX3NpemUgJWxsdSAtPiBpX3NpemUgJWxsdVxuIiwNCj4gKwloZnNf
ZGJnKCJpbm8gJSIgUFJJaW5vICJ1LCBwaHlzX3NpemUgJWxsdSAtPiBpX3NpemUgJWxsdVxuIiwN
Cj4gIAkJaW5vZGUtPmlfaW5vLCAobG9uZyBsb25nKUhGU19JKGlub2RlKS0+cGh5c19zaXplLA0K
PiAgCQlpbm9kZS0+aV9zaXplKTsNCj4gIAlpZiAoaW5vZGUtPmlfc2l6ZSA+IEhGU19JKGlub2Rl
KS0+cGh5c19zaXplKSB7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnMvaW5vZGUuYyBiL2ZzL2hmcy9p
bm9kZS5jDQo+IGluZGV4IDg3ODUzNWRiNjRkNjc5OTk1Y2QxZjVjMjE1ZjU2YzUyNThjM2M3MjAu
LmIxOTg2NjUyNWMxZTljNDNkZWNmM2E5NDNjNzA5OTIyZWU4NjMwZjYgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2hmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2hmcy9pbm9kZS5jDQo+IEBAIC0yNzAsNyArMjcw
LDcgQEAgdm9pZCBoZnNfZGVsZXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICB7DQo+
ICAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOw0KPiAgDQo+IC0JaGZzX2Ri
ZygiaW5vICVsdVxuIiwgaW5vZGUtPmlfaW5vKTsNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJaW5v
ICJ1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiAgCWlmIChTX0lTRElSKGlub2RlLT5pX21vZGUpKSB7
DQo+ICAJCWF0b21pYzY0X2RlYygmSEZTX1NCKHNiKS0+Zm9sZGVyX2NvdW50KTsNCj4gIAkJaWYg
KEhGU19JKGlub2RlKS0+Y2F0X2tleS5QYXJJRCA9PSBjcHVfdG9fYmUzMihIRlNfUk9PVF9DTklE
KSkNCj4gQEAgLTQ1NSw3ICs0NTUsNyBAQCBpbnQgaGZzX3dyaXRlX2lub2RlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCB3cml0ZWJhY2tfY29udHJvbCAqd2JjKQ0KPiAgCWhmc19jYXRfcmVj
IHJlYzsNCj4gIAlpbnQgcmVzOw0KPiAgDQo+IC0JaGZzX2RiZygiaW5vICVsdVxuIiwgaW5vZGUt
PmlfaW5vKTsNCj4gKwloZnNfZGJnKCJpbm8gJSIgUFJJaW5vICJ1XG4iLCBpbm9kZS0+aV9pbm8p
Ow0KPiAgCXJlcyA9IGhmc19leHRfd3JpdGVfZXh0ZW50KGlub2RlKTsNCj4gIAlpZiAocmVzKQ0K
PiAgCQlyZXR1cm4gcmVzOw0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2
YUBkdWJleWtvLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

