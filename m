Return-Path: <linux-fsdevel+bounces-78629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJFEC+yjoGk9lQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:50:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF31AEAE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 143F13004C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422374657F2;
	Thu, 26 Feb 2026 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fGVM3f4I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oy682hd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D293ACA7B;
	Thu, 26 Feb 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135381; cv=fail; b=I5yfukeniy+K/nUvV4m/5AXV26C1dTpDgNLGs879w0PyEoN1IqfiyRJoJ7NAhvuctAEWTUV0FxYrGgfSh/2d0mntfOrIhmaHVt3dVve07jrhak1cFg1RqmZXU1DsRfCF0zpivUaHd0h8UtqwLGAnlzhw6w4A8vGwZmlHVOqvHwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135381; c=relaxed/simple;
	bh=BlVqbZ/JpIskQj47WwYl6PI3fPnTgncjhJtmiAU1ztc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uvct4I72SPwiMWPCRS2z5MbbRhExmsE6x9DhxhEQmNjeTr+6M6iHjGBrHCpugDmLvM8SoijbFFEuT6LpltuytNC5zLT1AAcTUI6gJ2Aw4Qx5D70sKOLxhUe0mfOQO5aD6+0ee/FrbQ111JFKOmnybpMtEICdb27Pl7ZYvXQZkW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fGVM3f4I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oy682hd5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNDZ3107289;
	Thu, 26 Feb 2026 19:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oBC2hHKkmFQcxzSwn4/aFZcgBel5pry1r3QHBWM313U=; b=
	fGVM3f4IEk2qkHPwkvtGxAJT2OZzed2MrVDpc4OeXf6ITiu/cUyha9YwESWHtnZP
	bZyR8War430V8h4VQB5Q72xs1DsxeftuHUWhAOdPJ1yu03eo8suvikn6i+zA2NKd
	ikxwPReDM823pj3lbVeQCQnKZmjBjQ1Lbj5K4ecaEkcrtu2D6XPAXca/pUz6guDP
	uaT6VVIFFSvrfkpn7HXs7NaYBnBy2CHwDn2taszM24r/XYCx642qxKCIrAgVaV11
	jX4+2EYLfNXzn7qM4ikYAu9HmpuLJoIAs5TqpH+QwkW6/4azSvSPOlH1RHg/X15l
	VZZqGWDGYHBDL3tvwPzZNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh019bnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:48:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIV95d027931;
	Thu, 26 Feb 2026 19:48:53 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35hxxtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8gBIDUxIkvWt4YcpMe5Hjt+9MNBenWmxLiaWSnIaN619PSVHId/TqtjKmBQyUamm8JfbxZTzL1cYZBAiRU1/y/egS+htyjBCeNfwnkssZ8k75MQL8DvC78ZRYXCI1lia5ACh27UZbEKYQUhOkpLrJDAzKa6e1Bzn+gYnK4RW0uI8F396KD3RKAqLaeNH+8kqXneG6Vg5JDZIofmSumfGzF4Bmv6kjMLgUF6f9boUVe8AlExdjvFs6YHepH8V9CjTqRtcOTU10JQpbstiqi0ZCsBfHDOOLuJIhaiWYuXihuGjDy/d4zKznmFhKPqNSk5YC0ZJQtbAOWVvjzBhUq1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBC2hHKkmFQcxzSwn4/aFZcgBel5pry1r3QHBWM313U=;
 b=eFdW/YXWaRraQwdnnY7gdIXypqjz7Vf2dZiS9m0GaXlsOBHodspz18k4X1wvLftvAddRiq+/kKhQZOCrj3jbpKPHAOG+8mK7TDqPL6zLpdYV2G6Wz2Nhr6VGcG1BRQjZp0jnZOIg0swFxSMLArqpkbw0iGoMxILNDHLPy3d6B/r70Pxa9NLjgYB7roF4/Eidvq2+RegfmCrAUDBjLeYTyYqKUVeK/JQIFD3f+7W53vXW5tUxBI6WVOPkEetsrCBTCWsOWZ4pHIR/I5jfH7nOhEdih75V1qoGgxzWwnkQSUJ5qw4td36jOW8xBSGzxT5+QqFL2VJRr/RuuaYqNj5UYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBC2hHKkmFQcxzSwn4/aFZcgBel5pry1r3QHBWM313U=;
 b=Oy682hd5bljcoALU3Y+SlOWa8lBZEeLU0mgjleu9LmnE0yxY7kHLDGTbop/N7/hPg1KHbeAAykfqXxrf9tfU5owTCOM+lqC4EGrD7Zru5HBFemzOqfc4fDhm9QepOaIHRlIgoPNVy9idg6ImbvcMUxrirM9+4yg3x2auHBq6GRA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF3D2127785.namprd10.prod.outlook.com (2603:10b6:f:fc00::c20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 26 Feb
 2026 19:48:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 19:48:38 +0000
Message-ID: <8b0bb056-9504-4835-8063-7ddeba328721@oracle.com>
Date: Thu, 26 Feb 2026 14:48:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/61] nfsd: update format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox
 <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Alexander Aring
 <alex.aring@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
 <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall
 <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore
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
        Sumit Semwal <sumit.semwal@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-x25@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-12-ccceff366db9@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260226-iino-u64-v1-12-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:610:cd::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF3D2127785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3789d7d1-f5f3-4f38-4055-08de7570092b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 Hg+j6gD3vB4WWeEonaK+n0iwIcKdTMWuTeka27JXzZXV4RfY3IF3M5wpcLvfxnx2rCN+2pQpfT1AOxeN3To05r+cqbKsnBm2uCXFAhVdO7mZ8vdNE1rr6QXhGR6gHFzpkpLESyCQpl8fp0OQ+16HLvUh+SbCvRzABSJbeIkfVwJk0l80LmQHjUhQ532Lqj5aO9l+0gN+0QsPs3MwZgGDPwjWMq2vGzeKnerBhqqQKVX3nRx7o4/mR7AXopE/0SM0HHkUm+xLqyziwVkl+Lz82gFf4Btpvar/5W8JG264cDDJS8WnCv4XS/I+2Icw19hIHGj7ivDftBbTH0wmFMTE3lz80EPHEG515bAIl8lE1bOzwyNEjG+Q3xK7az1MWBzAoSLDUSldonHbLb044TgnKsm1LRjah+zrOUmYYR7jBPuP9JAElUHUNUThpBVwPW4RV1RqhQMQTTNOJAwRpFPUtm4/pM8Sbw96J4sf4WZMTou3WNMcOPoYh01720n6BR/UUALT3e2FcDQ4Mqbg6WY/Jc+FJl80XhKZZ8Bn6dHCzkp0aPwl6E5BtFYJCX8/3dKf+rMg55dyKPIIq5naqs99SEkXOHPZ3HeuPm8KSEtzIHSJ/INs7dWIrzyOG85M32cXkCLPwsBizx46JqU+VHmEXwUz1NDAPo/OrStP5WKmR3Wy1WPq57C60KgOs00DMknN7xW7zmKrHPtLO10VKb9T0wDBOHzYOhRH5NeYMPxThRbgD0hY1X+PuzvW1FO38AswEd7uqHDJH6DrfZvsmwsF3Q==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZEJHaXk0K0RjVWFINDRxY1M4MFVCeVc1dnNScEhGZzVvV0tmYkswQkRwT1RE?=
 =?utf-8?B?alFxdW5XNzhaVFcxMmJRd1gwNWQzbXJXdFJWTkhtRWRrR0Vob3dOdC9kQnpu?=
 =?utf-8?B?b2dwUzFZck5wOGpsZjlBUVdNYStMaitOcDRYSVZPM0JOdU9yNTdPNSt6SHQ3?=
 =?utf-8?B?SVFZdlNxdHc1Rmk1YTVOYStyS0o1MGNhOFA1aGNraEVpTGZ5QTJqYzVoR0Z3?=
 =?utf-8?B?eW9KSEl6czFwMUU5RDY3R3ZEZjlBNVMxa0xMeXB0cnBMTXJjTVJhRk94UVNo?=
 =?utf-8?B?WStvaUNGS05Xd3ppSTVJcUhmZFBFdXB4MkxaZXZaL05scktFc21qTzBwWTBT?=
 =?utf-8?B?a05kWUprM0pRNVp0TWUxajNVa3dWL1F0QXYzVVQwSHVJemtjZk9IVUFndmND?=
 =?utf-8?B?UUJCSkgrMFpVZGRSUmRlaUV2SGNxM3dncGk4em1RdDRxWjlKL1pIRHFKZ0Q4?=
 =?utf-8?B?U0ZJeUREdE1zM0hhbC9LUDJ1MmN2T09ra0J1YUd2emlSSGlybS91cHJ4TUR1?=
 =?utf-8?B?SnAwV0VQVndVdkJKMmRFT2ZRbVMrcktmS0UwK2dod0tVbjF4MWNJQVNvYU42?=
 =?utf-8?B?VTdoYW5mdWE3d3JkaHJRT2JGQ3R3Q0w2SkVPRW5UN0RnamM1WGtXeGVZalJI?=
 =?utf-8?B?bDNUSTVSSHpyME4ySVh2VDFISzVDL1dudHFkQnY2MTZ0bGlUYVBkMTZHQ3Q5?=
 =?utf-8?B?cmRmMVEwT0lOcDVhL2VDYktwYnhKdHRNZ3p5RkRkNVh3eGFUd0FsUS9ScWZL?=
 =?utf-8?B?NldheXhJVTBLWVdRUFRaQ2JITUw0SlZmbXVQS2o3UTNxZjBvM0ZGTU1rMXFv?=
 =?utf-8?B?S0hsek45bUNvdVJFVUFYd3dEc3JtRGVFZ2Q3TXQ2TVpSa291OWtBNlRBbldS?=
 =?utf-8?B?NC9YUE04b21EZHV5UHp2WWVhSllTbDIwUHYzdWgrY2RYS1hrVEpndmtPYTNS?=
 =?utf-8?B?RjUrYXhzeXBidWd2WklLNXJ1MXJXdTgxZVYwbDd5ZDNQc3RERExRVlhHd2pC?=
 =?utf-8?B?WFR5VXV1YldLdGZUV3NwS2FpTy9wYXAzK3oxUHJqcThSS2lUTHl0N3J1RW1q?=
 =?utf-8?B?RW03SzNOaEZkYUFLRnUxdE1WTDRPRkFJVlpsTklpcWxJbGFZMmlzMENML1R3?=
 =?utf-8?B?N2VZcGdQaEtOaUJTVHRJNWRoUzdjd012WnNRQzY2SnJHQTZCSG54WDkwaEMy?=
 =?utf-8?B?V3EvOXFVdWFnYnU0czFjZnoyV0NzRTFKZmxHQ2Nlb0ViU1lJL2FOZXgwc3Zi?=
 =?utf-8?B?cDVNa3A3WWd1cGlVcXlFUE9NMGJNelhwbHZDWi9haEJIMEc1OU1pblpmSDdN?=
 =?utf-8?B?a2Qwc0F0ZkZSOFI1QUdvRFJucnVPVFpXU09KUnZtTHdXVlN2M0IwWnVjQjla?=
 =?utf-8?B?cDZWR0VJbkRCS29kaFhmMnNZcGdvK3pIRWpjK3didHlJNm5lMGZSTjJsZWFM?=
 =?utf-8?B?SEVvZVN4cHhlR21RUzVpTG03K2wwRVptUHQzdDR5Z3ZQdEhPRjRXNmppZ3Y5?=
 =?utf-8?B?OE95bEJMajRUSlJmNVBWdWc2dDJBZ0ZVOCtPM1p5YVN0RmU1OVR4aTQ4b3Mz?=
 =?utf-8?B?NjZOSjhXM1pvWUNEcE9LOW9SSlA3eEx0eE5GbTdSKzEwbEhWbW04VWorOFlF?=
 =?utf-8?B?UmxiOS9UMmFwMGJiTnh3RmtZWlJ3aHRrWWxYdkRodnN3emo5dXNHdVJFUFFT?=
 =?utf-8?B?NjFsVnRqZTRLc0x0RTZtSXhwSnY4QzF4SEhJbnVkQW5ScSsxZzJuT0wwbW9q?=
 =?utf-8?B?MjZudnV2dG9BSFhHMzJKeUhrTm1hZ2dHQ2Z4WUcwRExCOVVPWlNydnJ6N3A1?=
 =?utf-8?B?UmxENXA2N1BlL2RkbjlkRXQ2ZkxoTVNaZ3VUYVRrVWhIRDVqVTFkT0YyUyth?=
 =?utf-8?B?L0wzRkJqdk1wZ3lUeEFRRkI0dEF5VTZaSDFnbFJoa3MySEdsV1pSdno4RVJl?=
 =?utf-8?B?Y1NJUWhSNVh2OFNaQWpqdWdwT2xPQ1htTVJGNkQ3UWF2S0RUbUpmUCtzVEIw?=
 =?utf-8?B?NTRNbUlmc0FIWEJaUVJUWHlhY3dMMFE5bnlGWVNkOUp5YlJzcUYvMFV0ZVB4?=
 =?utf-8?B?SFBkVEZZUjRNYk51UGpNeHA4cmFaRnV6UWdCRSs2eUR1THBwMDFOZGozVXBr?=
 =?utf-8?B?OUZpS3NVLzh6V0tqWGRNdldSeGM5cVF6c2M2NFE2UjVDRVJVY0p3N09aYk5Q?=
 =?utf-8?B?M1dCYzlQSUszRVk1OG9GNC9VRWNEV2tKa3ZOMXhEdHlIWjdDcEdzNEVRS0JR?=
 =?utf-8?B?Q001SGREUVdXZXFnL0VvOGpUOVBPRlEzOHhMaVdQZjJkYUt6bTh0ZXpOdHY0?=
 =?utf-8?B?Szk3TVozZmVjYktnMzdUWUFPdHJyRTBBWDdJbE1MWGtmSmlqWWdaQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y48lDFGgfLNkYP38AweaPOcL3ElHRBGNwoUYpIHzLt9OK0R+6zBjM+u3AZv71eVcivr7jxyHGVMQ8ze7yNTCQfEZ4A0wcKOtD1z2aTRC8mLkSR3MPByaHAUwyo4AKOkCJGEzF7ImK6F+yWhPw37gCQIM48JqFQoJZ0l49fLGaQO59TUMz9D/VhKmyFxJ+43ISWLiQiuhBQ6sj5s1jo5IHN8OliRXblb8Rl1LEEcKzcNvTQ0P6icUcLtZQ7fguVC4fVtUdcb6A4itXZ8VTHYR9qLSnTijxlvTYm3hr6uiZuugKImfNbzO9ROrfkjODyk7CO/vpCm/hw3b0RZRB7zXVGaoskvNTP/zcaw/1iQ1tClXFSBhzc0jlwLvgZZLbSzVyynDPSBpEbgieCU7IH1NfGLRyB0yumxwmyK15qKaZ6Fzijd0n9Nz57PubAut1A1b5wR++AW0oHOpBodM+9qjBrp/Lix9b2fsu9wAOmo59gyt6q7oLXVleAp4I4eAYInW5lMhiuY2dF4KL9DqVHTRtKiYwXSoshWpaXdx41uJ1TXqU6vyrflouhQ6TOP3GVJKEdHCHNsSOSHyJQdworB3mmq8DITVAGOYmAa9e4Zgw1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789d7d1-f5f3-4f38-4055-08de7570092b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 19:48:38.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oM0RLA5RsX6GKN1udkOcWkSQnRKZZkmyOj3tRErr361HcicgtNAArJ2Bs4n2AjEynhldC5PnsGo8pfVQHaNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3D2127785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260181
X-Proofpoint-ORIG-GUID: oD8tm_bjeRzgV8NAFwwGdmQGa1GgnlAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4MSBTYWx0ZWRfX5nPijMDVeKL0
 aWv4Pzj5DMN6/Qa4FTpjBp2rLK+4NTanOtr+Gg0HBef0YAdsZgrkUuh3XlwlcVWcEYNL8MiNr05
 kkO2FCWwvmOsCD0/6LU48+qezJiStyCu/EEyJPZyml9P7JYlWzBzXSkbWMDHClirnZh4Pgp0/JA
 +edt9h23UNxMjaUODzMRNbKxQ+NIDG8CVOVC0M0fTTsKG5lRONtLj6y7Mt6gMp+/yj+d6nyPD1a
 FGWMNXFhvzy2i+cxSt/npNoDDACHVfulReQwLxlWBje5P+x2BoOWzUOLJbR3k3WGi0iP6zKYLzw
 5YVjIFrXRgMkt45JjFAM41SmkPpT2eKFEcYVXNK/rQB4vy3GygndpTZvZVBab3hWa67vDb5vUUO
 TJWh2OM3nhMwz3AXiH6pjmpYrvSj/M3ukReSJstWKJeQqSaMVzeY+mlem12aeUIaK2Cu/Wtbtwk
 sG6fhD3cxqDt7ykXAwOZJufAyLH1XXkIp4WiIpSg=
X-Proofpoint-GUID: oD8tm_bjeRzgV8NAFwwGdmQGa1GgnlAJ
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a0a3a6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=ffxj3DESZ4ORkukIaKkA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78629-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,brown.name,oracle.com,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D0DF31AEAE0
X-Rspamd-Action: no action

On 2/26/26 10:55 AM, Jeff Layton wrote:
> Update format strings from %ld/%lu to %lld/%llu for i_ino, which is
> now a u64.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/export.c    | 2 +-
>  fs/nfsd/nfs4state.c | 4 ++--
>  fs/nfsd/nfsfh.c     | 4 ++--
>  fs/nfsd/vfs.c       | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 8fdbba7cad96443d92cc7fdeea6158c4cc681be1..334b63eb966e71e6af6adde61aa1123f01b4390b 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1039,7 +1039,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  	}
>  	inode = d_inode(path.dentry);
>  
> -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> +	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%lld)\n",
>  		 name, path.dentry, clp->name,
>  		 inode->i_sb->s_id, inode->i_ino);
>  	exp = exp_parent(cd, clp, &path);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6b9c399b89dfb71a52b9c97f0efe9a1dea0558a6..a569d89ac9123d66bb47e7d74c7c98610de21da2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1253,7 +1253,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
>  	if (ret) {
>  		struct inode *inode = file_inode(f);
>  
> -		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
> +		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%llu: %d\n",
>  					MAJOR(inode->i_sb->s_dev),
>  					MINOR(inode->i_sb->s_dev),
>  					inode->i_ino, ret);
> @@ -2888,7 +2888,7 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
>  {
>  	struct inode *inode = file_inode(f->nf_file);
>  
> -	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
> +	seq_printf(s, "superblock: \"%02x:%02x:%llu\"",
>  					MAJOR(inode->i_sb->s_dev),
>  					 MINOR(inode->i_sb->s_dev),
>  					 inode->i_ino);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..cfd143b41eb1fb53868f378d668905c1c7d5f868 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -601,9 +601,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
>  	struct inode * inode = d_inode(dentry);
>  	dev_t ex_dev = exp_sb(exp)->s_dev;
>  
> -	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
> +	dprintk("nfsd: fh_compose(exp %02x:%02x/%lld %pd2, ino=%lld)\n",
>  		MAJOR(ex_dev), MINOR(ex_dev),
> -		(long) d_inode(exp->ex_path.dentry)->i_ino,
> +		(long long) d_inode(exp->ex_path.dentry)->i_ino,
>  		dentry,
>  		(inode ? inode->i_ino : 0));
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c884c3f34afb044ee5cacc962a04a97de2f7fd88..dde09f3734c2844a3fe0b6d18d596276a19aa2d1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1163,7 +1163,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	} else if (unlikely(host_err == -EINVAL)) {
>  		struct inode *inode = d_inode(fhp->fh_dentry);
>  
> -		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> +		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%lld\n",
>  				    inode->i_sb->s_id, inode->i_ino);
>  		host_err = -ESERVERFAULT;
>  	}
> 

Suggestion: Let's use the %llu format specifier consistently for
inode->i_ino, which is unsigned.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

