Return-Path: <linux-fsdevel+bounces-78712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEcxJ8yGoWlOuAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:58:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39921B6DA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F38313BACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2C3EFD35;
	Fri, 27 Feb 2026 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fDIHokvL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GH8Eijfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DE355F37;
	Fri, 27 Feb 2026 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193369; cv=fail; b=IMwqaHiqKHYZS71qVU49Cr/kLcGEq/C3GVqKvchlvRGVodyPpqZIOcHmq67ntEWIS5XXrh36btwJ8bjJbZluRA2+iNLL7HExuEd2WYAZ8JKNKD00M8sNyDZgptw7iSOr5WkIim3CxY3D+SfViYyGzj+4s+yKjBwcnj9SyiLXD7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193369; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nj/O15Bsy/yOezMYFueRKefXEvgQq2me2wPWGUBjlQxgIu9ek2UqRLCGgp9vDl7MrygNtMGMMdoI42ij2YKliMicnmdxtKhRXHIRSjoHnuZL5YW0YIaaf5NMkNN3iz9CrFUVn02bQlKU/xgGkxFuCKmP3ZDr58jkA9X+bN7s1FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fDIHokvL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GH8Eijfu; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772193367; x=1803729367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=fDIHokvLlg6nRz9UiAsrAVdLMXaYzyUfOpj5CmGRwSuBRCfkUVmY0CFA
   TtNmFxO8d9XdOAwRUUcUD7t86UWAI+7z6QkH6lbC14eRUUvVeTaeOWYkc
   vQuzTIYSzxYOP3Qd+ej2ivcMGyy5Qfa6W7xxCV8KuuLWrQ/i7BFmwxk1X
   UKKSsThlFoo58Ppn9SkWZ6vatn6rEbLfNTKNkBsJZ3mSWz6QWj4jaFjDt
   6EmeTnmeKeS7AOS/hzc9VJvVq0ALH9EMiDtbCA1XA9Nh6UgvXH1eaHy6J
   OIScOa9Q7rIV747qKpRy27i82MO0tJiFyK+ljJjVvE4JHs84eLX0sER1v
   w==;
X-CSE-ConnectionGUID: CeynFEfXQyy4D20d5rO42g==
X-CSE-MsgGUID: UVWj+PIHTVqx+QVX6Yq93Q==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="141588070"
Received: from mail-centralusazon11010033.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 19:55:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSujrcv8UkoMPULsgkLclhILgfgtZeCeGnKR4YUAVoELXAVzOJRFmlaHoPHMtl2ZO13TgtPoD8b+nctlcoRdnlJcSd3X14iCg6kHv4Gfpc+Zc1OBWcEmnPblM01fbUi41RM+l8x+SGpOH4a3FI4wRS2yVrm0ChfadD7wOXJrYAqXooP0a+FPSzw3a5gQeXrM09bAIHdgH44gG2aDcNIFN4QtiqSpKckv0SMOqGe724USaHhnO6rcxi8BPe1NtQYpMsBuLQQfSB5qxZrppk/GsjMehVOSb7AtoRH5mkjdILrjgQhefd75ycJ38lSzmvNXH1Mo7b4RhB2BUtO+vgTn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=UVhlP7ijOFESc3naNQGA7p6AIIdwmf8nghKPCw0YhWayetZRn9mj6KAMJuiORqfNQFQTtVVqNldlUByLe/n0MdPHbdZuPymXs2AMvwKFu5wz4n3D0bDbhxt0wEObZ67M6oRV5/ZXX8HJ4dA6EHOmygzQkA8r089GfC8urm+v5W5gkPNyDNMZc9/jmNFqZp+wqty0GQq8GTxgMvh54un4C5b+o5QsxMuNVpIevVIIZ9wkEJXtSqZm2PAdSsxcvCkO8Q09sFD9xNHVuvdgiHRgsJsVnrFutZSvkfHz6KJHCFwRBqsaYGyi6gkyCv+74xH3M+Ed12u98/JooFNWtZMviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=GH8Eijfut9oGfft/4NWXnLxibLbDR+kvMfvuA9HBQvaFxeV0Ul8+u+ERvWAL/nIOi3e3SMUTE98PdQFVPIYtqGSqoIzycJ1zxZHl0MnJVkNVQvPhIu1kqwpwpP1Xy1WGIV35jYhM+oTC8HYT/ZvmQV4dt0wfpnmr5ab4vdhOWoI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB7088.namprd04.prod.outlook.com (2603:10b6:208:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 11:55:52 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 11:55:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o"
	<tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@kernel.org>, David Howells
	<dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Steve French <sfrench@samba.org>, Ronnie Sahlberg
	<ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Bharath
 SM <bharathsm@microsoft.com>, Alexander Aring <alex.aring@gmail.com>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
	<linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, Marc Dionne
	<marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de Bethencourt
	<luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, "Tigran A.
 Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	"coda@cs.cmu.edu" <coda@cs.cmu.edu>, Nicolas Pitre <nico@fluxnic.net>, Tyler
 Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Mikulas
 Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse
	<dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp
	<shaggy@kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
	<martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen
	<al@alarsen.net>, Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal
	<dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn
	<jth@kernel.org>, John Johansen <john.johansen@canonical.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric
 Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet
	<edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, Martin
 Schiller <ms@dev.tdt.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "fsverity@lists.linux.dev"
	<fsverity@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "linux-nilfs@vger.kernel.org"
	<linux-nilfs@vger.kernel.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"autofs@vger.kernel.org" <autofs@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
	"ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>, "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>, "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-hams@vger.kernel.org"
	<linux-hams@vger.kernel.org>, "linux-x25@vger.kernel.org"
	<linux-x25@vger.kernel.org>
Subject: Re: [PATCH 50/61] zonefs: update format strings for u64 i_ino
Thread-Topic: [PATCH 50/61] zonefs: update format strings for u64 i_ino
Thread-Index: AQHcp0MLQHR0nz4ahkS+p8n0/a9587WWcYOA
Date: Fri, 27 Feb 2026 11:55:52 +0000
Message-ID: <0ee5930b-40ef-4bbe-8c3f-e2712742d22a@wdc.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-50-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-50-ccceff366db9@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB7088:EE_
x-ms-office365-filtering-correlation-id: 394e6759-8bb7-4159-879e-08de75f7283b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700021|921020;
x-microsoft-antispam-message-info:
 fIWwFZPCWTqHHaGFWzL8H0uzGhvcIlRHz17hOKjf+/ESwyAsmb8tJwJWUJy/9QRDOjaVm+VQo9CRHjf85ItJqFIUOp6AgWyE8bITCC1GxsLC0CK0cSOwU+NWWN2RbjpjpxD8o+F/o5W/PLygeOyIIngMa/mA0NDs10YGwI84r2fyLTTY4ZZ/uCMcBpIo6qVyYcHq07pj5EcHQiy7JvGQFpvNgebQ+b2EMzZrtWHAodR0WjZSlyLePAitL26mrJuEP6/CxH7N3SVte687HudYqCLpfxRUuiHPp3RBNcRGAfYWmt5fepb2oCmGpXdE82DTNbuUtgmmjXurRdCqWSZqS1yPCyNrdFvX5IGjXxLzuiV22OUrUlLiaSkn6ytwIKwNmApJCACa72uqehsnHhjZq65Pfb+o0g8Nq551dBy7nc1e4jNpsn0SC3cFQkHj6+MsYQq8nmtsERvR6cu9wvyVqc2xEVTvDIlr/u3Qn6pCCIRXOaO51LvPNI+/xxRyLUfsO5ZDAiet6qmxDf82gKPg0RwZcUfRJHWVS8nBjj43Ej85zGr1LZ9DsL1k0/cy9Pp65YXHQkLbRTxh2AQ/dhpJJqCu6beAkdMDu054fgUfRj30cQ/TPOTB86dHkPoPR6g5A+8Or6A3YZoUxY2ER0L1B44iVHJu9X5krKakaBfL9OsCo5+WF+7OtZbivRtsMuRE4h7IHe/wJOpvfiq1/HbEXOIki3t0AhXSznyY+1YOCgwxzrg56Ui2cou1A2fBJNSu60jXtbBF63vvqMMqT95J37OyI25tpC5rh3bjRXVSiwoLXAr2XLqvhZtepIH/mrKZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlgweENhb0VoZUVpbEpTc0ZwMWNHRHZlNW5LVzZ0bW9EMkJ1Q2ZEK0QzVnpI?=
 =?utf-8?B?UG5pUkxoN2JjWndnZFg3UWlaTWppVVhWVTVSZjFnZDI3S05ENkYvSG1iSFdT?=
 =?utf-8?B?ekJUZmErd05oODBsUkI2VmI5N1h6RkQrTldBbVc1Tm1jcFpmcEZoSWRsNnJt?=
 =?utf-8?B?RGpZNlZ3NUlpdWQ3SC9XemxTYlVubjJzRkZUdFlaVzJIbkFzajduZTJkdGJJ?=
 =?utf-8?B?cjZQYm1qQW9jd0VsVloyWXJZVDhWY3lHZWJlVDkveUFxaG9MS2FNdjZzWllR?=
 =?utf-8?B?QXFDMmFuQ2QwODNNWmlRdnRKWDhtd2dMU1JVK3JIeTQ3aFFDYUU3Y1NoQ0k5?=
 =?utf-8?B?Y0loeExtc2JhRkpjZjVHMm9VTWNhdGJRb1ZkY0lHZjVMQXY4OURYSGdhV3hZ?=
 =?utf-8?B?MDMyM3BDZUJNbmMvblRMRU5XMmF3dlNBNytXT2JoVzRVWGFPVUcwMk1XbjBX?=
 =?utf-8?B?RXM2MW85aXIxNnNpaGdKaEFLcTZvRXFBVFgxL2ltZVNHUWpzM0ptSkNIdlBX?=
 =?utf-8?B?T1ljTklCQVlOd25NcVdQVktxQXR3RDVBWThUK2NXcnlvQzN1MFlxRGRXOCtD?=
 =?utf-8?B?MGNUbitVQytEL3hMN052bDNQSjFKRDhEeVFHSXdhT1VMRUFpNlhKSmVDa2p2?=
 =?utf-8?B?Q0haSThqMVBtaEVuWDVHRFY3b2l6NlNyNzhSRWRENndYd0JXdTJCWFlBclhl?=
 =?utf-8?B?S2UzTHN1b2Z1OExYZnp2RHRBcFZEbklpTTNlcTRlMGRpbEdYN2EvNjM0VnRp?=
 =?utf-8?B?d0dwMStxaHBieVN0Y2R4dkRUS2FZbkhaNWh6WmZyQUhEUHhMMW5rc0YvRmVT?=
 =?utf-8?B?Ky9ra1p1N0hVT3JMcmtIUzFGUUYwbmNobGJKVkdUbjlERjQ2REtNN2ZvVU81?=
 =?utf-8?B?dk5UdFkvREwyQVc5aHhRWGxkUEFpb081a2IxTUFqWU5qbk5Da1h1UjhhV1lZ?=
 =?utf-8?B?OTRZVThrVjlEMTRBTmxBTGhLVVZVSU9TYUh3MEdlWEVtbnc1L3M5MmxLYjZa?=
 =?utf-8?B?Zml3ai96WjVEOWgycUlpWnJOMnFmcFdCazFXaVVZOGxtNmRUbFM2UjluWkhi?=
 =?utf-8?B?Zkx6N2VuR0NUbUxJSjdIWEtycTdqcktieG12akFwY0cvRFZyekwwemhLYlRO?=
 =?utf-8?B?bEFOMytsSFlSM2l0VGxEbitrM0grekF3MHZ2U043YmZTeU1DR1hhMTRzS0lR?=
 =?utf-8?B?TEdiL2g0MWZZb0xUbmpCVVZzTVVHSVN4MDhxWUNjVFZMZFV5RmNWTjIyY1ZM?=
 =?utf-8?B?NnNBeXhMaFNCMVRqbGtvVzRjNTJLVElCODYrZ0NHSXUxdlQzUkgwMUdMekYx?=
 =?utf-8?B?N3FVaHh4S3pUMUd3N3JuSks2YjhyV01RUU1mTmIyenN6SGpOeC9weHNKRWhj?=
 =?utf-8?B?czhXY3dmZlUvRnpzRjN4T0hmRzNLa2pXbElUaUpyaWJvaHNsZ0dQMVpTdjJM?=
 =?utf-8?B?M0plUndWU2pZNnN4MDVQVGRqWmhvWndydUFzb1V2NjkveFM0T3diSGUyZzFo?=
 =?utf-8?B?cmtpVHlGc3hRa0J6N251NE1ZYThJT05kTEluR0laZnZsemM0c3JjbFd3TWFG?=
 =?utf-8?B?bk9tazI0YnVGREFHdVJYRkZGWjlKSGY4R1UvbVIzSEVnSldCOVQxMy9LOFRt?=
 =?utf-8?B?R0J2ZHZ2UkxadHhMcUdDRlZ3N1hETnNFKzJTRklncUE5MkFVenpQN1JhZW9C?=
 =?utf-8?B?TlNORjNYM0ZPZG1WUkN5R0pYVUpBdFFmSFg4bE51Zms5Q1JJcG56ODN0NWtq?=
 =?utf-8?B?VFZDUTlPRXNYR3BnZHZ3c0FzZzBDc1ZVK0p4L25hS2l3eVFPYWJHZzdRS1VY?=
 =?utf-8?B?aUhaMXE4VzhQeUpjK0sxTGtRaXBXbis0VWlGWmRhOWNrYXM3c0ZFUXF5d09P?=
 =?utf-8?B?RVpCR2ExSysrT2pHemxQNHc1cFh2QTNCWVF4ejZWL1R3SlAxUEkzdGlJTEdV?=
 =?utf-8?B?WmVwNEFOWTE2cVB4cTZFWmR3NUJldHUyb1JpUHQzS0lWUWUwVFdwNlBxQm5l?=
 =?utf-8?B?SllKWXhoL3NsSjdnQzRlNkhSTUpTS3JsbXFwOWt1dlZpWHlQSTBHckF1NjFO?=
 =?utf-8?B?Rm93TWRPZjFDQmR1OTVtcHRqMUNLOC9DeXZGSllDRFJ3aE1zNHFGZzdRV1pU?=
 =?utf-8?B?c2ZHa1dKalk2dEFyT0F2UmFMZlNPUDV5YlJiMjJRUjRERE96NnppbUJBeEs2?=
 =?utf-8?B?djR1bFA5bFBLdVFpRHpLdWVsdFhja2FRMEp1QlJRT1lPV2VHTzdaZ2RMYmY3?=
 =?utf-8?B?Z051MUJGZGF4bTBTVEJ5NHRMdVFnR1Z2SFo5bzJZanJXV3Q4bkNXNHRDUWc3?=
 =?utf-8?B?ZGFxbFZ2ZGxDZUEyaFZPb1ZCRVRMOUNCUXN1UnJhT2xWNStkTDRSVUxjNjdM?=
 =?utf-8?Q?CdDb+/b7Y2SGqaik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB85C4B88629F04386FB2CF892A90C2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrrOEe27GGw/szGLs/fX4JfTy+2165qf0QWSidXW2fdqK6XD4BF3XoDvNcJrGuK1AX/hCaGARyFkNuMUCScHMb/NZuRTJ+xbZEnw/wm7F4DgSXia72bL1hxuG8iFbkeFAwmYdvwl71od9xJaipKYoKgjcqfXyNmBAXNyC/2oObTe+Ehg4KcazPwbMOqF88bzAFAKaJ1qk0FDcSfSlbukwetIfjzP+V30NoAlet5fuzhs3OxgSEBYFg3YFGsCdz0gkh9dZW4i9/LOzs+HFxsdUsFafEX+uCHnd15nSK7cGZXfY379c7uNZZtbEqIqgt7F7AV9zzBhr3rwPPuvn3E56E7yqUSP8dOAgDvCf23BTVqyhbSxEjJsxvg9O67AlfkJhBY+VBff4PR8QiNxapklA4NIp8U+5/oKj4U8RF/WD+QWF/gkN7FE6nKqOrjVK/q0daJeb/Ro5WbsP2DOa2OCTSKdn3KO9YtByZHvTnT5W220JQ7+z47QkaP1m2XNErbPKJIt1yCXRvY5tLbld8UBWy7mPV+k/6mqZua+HIVXZETkoTHXC9s0w0mr0C2uHMxHgrdLjgZ8sh3aEhCwhYywTG1uAcu77sinHXF2V3T6SDh7w5jzDuDPLDXV62Fq+Ual
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394e6759-8bb7-4159-879e-08de75f7283b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 11:55:52.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYQlQ0PF9XtiYohUxrmDxATY+NWUukb7FUUKvorL7lfe1ItIj5xwQSppqHZNV7I0KMqEwDaV1HKH9qcxAiGVOCH5Hfrh5Z4ZFdBx0E30Tm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78712-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: E39921B6DA3
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

