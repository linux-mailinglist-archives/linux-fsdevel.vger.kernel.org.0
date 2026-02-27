Return-Path: <linux-fsdevel+bounces-78764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNcvEb/qoWnbxAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:04:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B836A1BC5AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06AEE31519CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B43ACEED;
	Fri, 27 Feb 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RE5ahWBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021110.outbound.protection.outlook.com [40.107.192.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D863126B2;
	Fri, 27 Feb 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218904; cv=fail; b=oFK1Pe6iUlXbff75Uwg5IXjwMg56gKSxpA6rHa15XbUHgoMJieHWyK6zsNpavyX20xoAlIxfpmoITgRj7zmubW0UliE8pNtmkVKZs1DfzjN7e0IF0C1ij8grrBFRpSPw/3EMu655iCMQbazSrhCeG5Vw3MXduEmbuZoXVO2Epqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218904; c=relaxed/simple;
	bh=/OXFOBa4PFNYA4GIPEC7OULulL8MkO2V973X9Fo+xsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IA7rNqHBIIezu8MndIKtCqhm4z2XREmtFDUdc6H6jLJJwXkp9Iqof6ogNXB2WAL8MbVoNXJN6ShLDS2CzmQoqcHvi8gZI/tU+vS+bOgmUwFliLTPTikBskhQl2J9wCbpuM3jmzRPr7RcF3b/qe884PvEtJRjtrjP1fIyOzfy0KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RE5ahWBW; arc=fail smtp.client-ip=40.107.192.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyWwHYXaVOptQRjpaDCuF4hX/enC3EN1ccyldunU2wcevIBwMn9BnOGxGD2tx6mNv2iDEfk53Wkb+mXDN6Wy1RRTfBXh05wOgeNkmYt3e+eOWyUhal8NMrjmlic+zvb9MjpNgRN6zV2ix8G3mGzzkKp9UIE3S8+g5ZOTeIUlnwdhSnjTZh0OpOo+HF45xYcoJ08qgzDL8K8x07DVajgNSAUGcGl83azMyTH2jMTbtcPaeWpW9LFyU/rFSzWixvxi0sdePJRrTFKDEPGkrJybWd9BQEUJdMXTYcQupc6NcTNKlhsb8aFscFJ4g7suzdjyHzXvi1epNRTS46558UCwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk29SJfpJGFgRzCY4PLuyyiHP3wfz8v8GzH3ejR7jAg=;
 b=T/5vtpzi65/kGBQeFBOb1FizZ5xT99Epgu0mbyUUbqjynBQknAe1BiYJ1tIT0APElGf/6Qz2Tlu05gkDD3WHqUBMFfW7OmX1V4rMzQKSvykSY9dlQ2Nw23aR8bDSpLJje0huzK4J4iMVlvk7P6Jdoi1SiUFCCIkOThQwG1FVGs21u9DCLttv7j5sXbuklzS+wsIGTD4ZcEVIWbnj9bJ3DfMoAvP6+E3o5uVfIJS4OTPVUDbVdMn8zu2k9zQwBIMf1rDn4/rVRVCej+upBRGxFTuruchoLY5AU2+RKBKGnseXTaqMhhD8d4WK9OHld9/TFl3BcRLeqsQaKMEgdaxIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk29SJfpJGFgRzCY4PLuyyiHP3wfz8v8GzH3ejR7jAg=;
 b=RE5ahWBWyrGgAr1sG7157mWsSYBEmmBEnr7QZWJmeZoxo07+7Wmsur2peObaGSX2ionx0Os9kpbDaookJJtmUDDy2fzm+/kNnTT+f/sqpNrUWdNEZXJJL9Jsymke28jJ4T9AFgOo6v0bW94a5FL3D8qALq2+Fcpk3s/nsUZ1ndql+tEcOrOGxuMwjm2bjbybwp3NiS18loGQQr1D0Ntikr/JBB20P1mLVqoNIMR5dT+ABqPDsYrLSmVDcvhuazN9ruHa078fP/fMaK368bO3o+4pGmy6eQ9x0nmNOEiqdjoJieszjoSJbQmXQRuZ8tzAAurF5kCVbC+/0AjVZ7gpbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQ1PR01MB11446.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 19:01:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 19:01:36 +0000
Message-ID: <b808e186-3eeb-46ed-9826-b0ae6cdcdb8b@efficios.com>
Date: Fri, 27 Feb 2026 14:01:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/61] vfs: change inode->i_ino from unsigned long to u64
To: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM
 <bharathsm@microsoft.com>, Alexander Aring <alex.aring@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>,
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>,
 Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall
 <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Martin Schiller <ms@dev.tdt.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <aaB5lgKd8FOIizPg@casper.infradead.org>
 <4a462d40899698586c110add96ce3fab6ddac30b.camel@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <4a462d40899698586c110add96ce3fab6ddac30b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQ1PR01MB11446:EE_
X-MS-Office365-Filtering-Correlation-Id: d47bfdf5-e3c5-40d3-8017-08de7632a081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	EY5Md8YGJJIuzUva9Rf1G3srlPfJ5z4HLDU6C28LTRbhf3S6k+BFTAgq/Uj3DeAKWxjHXSRUJ3gWvR9+H8pmPkJM+6uucug3fgz6+OSzVebBsXgFLIEdolRXYlAJa/tfXD0GDY6CPY00XUEby3BNWa3oEYAvKV6x1O+HT39G3mfrOeFNbIsisjN6kW1FDRI37V9NxrGtMS6ym/l5L0OuMDlQdeofrJksRx2JGYHieHYV6tstWrSpduIm4wJU55wk8eG4Y5gLGYkTeVVTXI7fxkW/Qm4+BO/o+eSAdyo5f6HXZtAUxCYqHFwWqcH83Ds7ek0iedsiYntL1PyL/q7ogdDfnHRANarXn8RwmRXSub0BC7XfsSN4xJWSa98OHzdiLHIJJucQFYYm2dM2KoPVPf+02lUhjUllo9S0nu+tKlgr1cykR3yatmYz4Tc6+N5SsWXdY+4ZKhIDmaGzvL+lJ4o8l3T7sPuHxKexmgIIDCDUr4ncdJSKp4T7v386CeuGWnbZRN9Ni9Razm7gj1TN9n7YulxgaC9Y70JJNwFaP+NxaPz9NezUrvwST3ExKfGEshqKR3Gk0WoJQncvCrdNFJrc7bTXhFCxkM043XpimNHjrcJwuHBVOhHY6vH3pbNFYF//dn6hsV3mxzb47wcvsDRk4++7MFAj7Fi7EO7E8SEnWmxVEgxU/J1UgxKQtJQr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNML0R3RmJSb2FhSmRmUlF1aC9FelFaU2ppWFBTN3ZUOTQrRFpoLytyM05q?=
 =?utf-8?B?T242Vlg5MUpZMnZpYVVjMGFsU0Z1SVhrWStxKzJwRVFyWlpYT3VEYzk2RGN4?=
 =?utf-8?B?eUMrSDlaeHJNRUNLb1pBbzFxbitUNVUwOHIvc3UyQzFpWk5KYlBveDdSTFBU?=
 =?utf-8?B?Y21YMnc0eHl2Wi8xZXNZYnR1VDc5UG9WU0I5YnBYd295ZHBBM3BzQTk4M202?=
 =?utf-8?B?cnk2QjRCM2oyWmpmK24wMjFIWUp1TTNCeW9EbmFuL3U4bUNQbTVEZ0tVYlk4?=
 =?utf-8?B?Q0hEZUNmK3dGMEsvamdQTmdXekpnN2xyMGw0azNIcDI2ditWQml5dkJzZDhl?=
 =?utf-8?B?emQ3cW1jY3ZFS1dQNThwdTJ6bExURk1pd0FjQ1FrSzdIdjhTeG85K2JkdWhK?=
 =?utf-8?B?bFFDUXFNVVdibG1PY0hCNVZQVVZDaVBRUSszZ210TzhEdWg2b0NLOUZObGZs?=
 =?utf-8?B?aEo1d0p4NG1aaDB0YTRVSG03VFpXL05UZ0VQWWU4NUpSblNNQUw4OXdsZUhZ?=
 =?utf-8?B?Szl5elZnZDBTdWxtUnFmQW9GUkFyTnNsS0xUR3o5cGw3ekwyZU5NSFVUN2pE?=
 =?utf-8?B?aGdLaEVaclcxQUpVam1TaC9BRXRBOElzRDJvK3hhTithSTByeWVvNSs2SVk0?=
 =?utf-8?B?UVdkcTJ4Uzdrb1dtSFFZMHV6aUVBb25wRnVYMTRiNHQzQzZVVS91Y0MvcnZH?=
 =?utf-8?B?Um05L2tTZlBaUXdTVkZJUW52UmtaV3ZweGZyZ3lwTGNuZmF4d2U5cEp1aHBT?=
 =?utf-8?B?QzY0OU5nazBSN3JNdGpiMEtYU3MyYmZ6TEg3R0c5WHdCMXhGVkdyYkFGMlUz?=
 =?utf-8?B?OGVCRXNwN1R4ZTJyRjVwZ1JxR1V1clJSeVNtdFhIM295d2tUaGVLZTdIc05o?=
 =?utf-8?B?aVd1TTVPR1FnTWtuS1EwbkI5Q0RmTHgxZDJzU1NwdFVHcTY2TG1OamM5a09D?=
 =?utf-8?B?RWJtSDlPbEpXVm1wRmxTUVFRT0lFMk1FNm1acjBxajFrQjRXVVFuTUh3dHZu?=
 =?utf-8?B?d1N3NDBKOFBWYUtkbHdSbWEvTjQ4TFVtV1VjWitQa2xWelU2VmZtMkluVngx?=
 =?utf-8?B?R0tZRGoxQzJ4SjljMHE3UTBQY1JCM2ZaSWNlRHB2TEo1OHFBRWg4ajdVdFJ0?=
 =?utf-8?B?UUJudzZEMHJXM1RaWFJsTnpXdis0YU50MWhMdDFXQ2JWbmQzMC9sY3JmSnVT?=
 =?utf-8?B?MUwrRDRLcU93NEpXMFBESUE5T2ttMzB4QjhTTHF1UFVWa01IWEJaSDV2UWRH?=
 =?utf-8?B?MGtFaEloTlpZRkY1di9Jb1Z1Y2cxWHhEbnRyNGtMdURrVkFBQ2FDV01sS1lY?=
 =?utf-8?B?TEF2YUsrTXJ1eVNPVlBBYmczc3VrK3o2ZDJ0aFpqSlZMOHJMck9Hb2hsMWVE?=
 =?utf-8?B?RGxBWnNUQ1M0SlQxZWJqNVBLRTFVeXJYYmw4QlR5RzNqRGxHTFB2a21xU2Fj?=
 =?utf-8?B?RzQrakhPTXlGcVVUSGZSL0U5Nm1DUDlUVTQ0dDRIcStxaU9kbnVRcUxUb2Fp?=
 =?utf-8?B?S0dDRHI5K1BrU3FoOGRkQUJ5ZG1uNEhiandXbjlsNzVDSlQ1TVk3WVo3YnBW?=
 =?utf-8?B?UzJ0bStQV1NsQnVjSXJscURubG95M1VGYmVlRDB5V2dXVVh6Y0ZUZUVrd0hz?=
 =?utf-8?B?QUN4cGwxdTUwdjl5R3lDRUNSaHlibzdCVzlQMXp3MEQzVE5jbjJmSmNONkRm?=
 =?utf-8?B?cjJ4QmZxSHhrWUxBRThYYjIyNWpwejl2SUN5QVp2dGIxTzZ5dW1TZzBBOXhj?=
 =?utf-8?B?NW5PMGtqZ24weUs0QTJjdFNrLzJrd1VETFNlUHlGY2ZwQ0ZzZW5wVWhaVFkw?=
 =?utf-8?B?d2p1S3Y2dnNKYlF0SXNab2tOTy91OUNaYnlIZWVUVjBvME9iU1FIc3ZuYmJT?=
 =?utf-8?B?NDF2Z2EyZkpnUVd2T09OYld1cjAzQmNjTHFIaHl4MkIwL1FhMGx1b1liUm5F?=
 =?utf-8?B?VStJcFVQbVB6ais2UjlCZ2tnSVZsd3RKWjhlUU8va1RDcGF4cDA3Wjd5a25U?=
 =?utf-8?B?c3hhcUpvY0t0bXZBbVdvQm51ckRpTVcyUk14T3NBdnRUNHowVzNPNHlhdmJO?=
 =?utf-8?B?SEZYL3NTM1ZyZGlzYVUzR1BkNmtOVkhoNzNQTU1VbDd4MGZVWlFwTGtOK1pw?=
 =?utf-8?B?NWtrL3NNcVVnUGVCQldkcGl1Sm1mSTFLMTdkWFdkRkZBS3g3QTAyK0Qydit3?=
 =?utf-8?B?MVpTWWFLSHRXRDZoUXBqNC9aK1hZTm5JMk4rbEVNR0ljZ3N0cm50TmNyb1NU?=
 =?utf-8?B?N3g5SCswVUUvcnhobzdVYllrQlhqR2JvUjJBTzRTQzN6NlExSkp3cjM4RjNC?=
 =?utf-8?B?Zk9zQWY5anI1ZkVqR1M2b1F0dE9POEpLay9jakFKR3UwZlVCVlh2UHNiKzZR?=
 =?utf-8?Q?lCpXuAN1+w3tLwc4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47bfdf5-e3c5-40d3-8017-08de7632a081
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:01:35.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N2/gZXBOwu3d4VpitFMRZidRWQIRoSaCdC/f2/Xt4bR8UjH6GueZon/NbacX7XPHqlUxfYPoxzUF4l4veiYQEGXWzrhYaUYiwshNafmDIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78764-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: B836A1BC5AB
X-Rspamd-Action: no action

On 2026-02-27 12:19, Jeff Layton wrote:
> On Thu, 2026-02-26 at 16:49 +0000, Matthew Wilcox wrote:
>> On Thu, Feb 26, 2026 at 10:55:02AM -0500, Jeff Layton wrote:
>>> The bulk of the changes are to format strings and tracepoints, since the
>>> kernel itself doesn't care that much about the i_ino field. The first
>>> patch changes some vfs function arguments, so check that one out
>>> carefully.
>>
>> Why are the format strings all done as separate patches?  Don't we get
>> bisection hazards by splitting it apart this way?
> 
> Circling back to this...
> 
> I have a v2 series (~107 patches) that I'm testing now that does this
> more bisectably with the typedef and macro scaffolding that Mathieu
> suggested. I'll probably send it early next week.
> 
> I had done it this way originally since I figured it was best to break
> this up by subsystem. Should I continue with this series as a set of
> patches broken up this way, or is it preferable to combine the pile of
> format changes into fewer patches?

Here is the approach I would recommend to maximize signal over noise
for the follow up email thread discussions:

Now that your series is bisectable, you could post a [RFC PATCH v2]
series with the following:

- Patch 00 introduces the series, points to your git branch implementing
   the whole series,
- The first few patches introduce the new type (kino_t) and macro to
   do the format string transition. Initially kino_t would typedef to
   unsigned long (no changes).
- Followed by patches implementing the type + format string changes for
   a few key subsystems.
- The final patch would change kino_t and the format string macro to
   64-bit integers.

Once everyone agree on those core changes, you could proceed to post
patches that change additional subsystems in a subsequent round.

One more comment: have you tried using Coccinelle to do this kind of
semantic code change ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

