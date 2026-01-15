Return-Path: <linux-fsdevel+bounces-74023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC831D28F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 23:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B0430124DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143E32D7DE;
	Thu, 15 Jan 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjEv3RW9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yYrW66gA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD230BB87;
	Thu, 15 Jan 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515079; cv=fail; b=rT/0gZzM4qw8+t2GuLEHgCYM0ydKoRRKTouzV0Gs2Vx53g6h136l+Smvc8JLIBPptfxUzwrtW6O9xw9K46WLCOWR25H9aKcK4dQOCndzwkHAyLBqg6OmEQ80FcRO/0MVpMAW8XrNuGliy/N/xNrEfcUxxWePdrbkx+w5gAFO3QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515079; c=relaxed/simple;
	bh=AWRms7FmGzffe0TGfwZsRWN8Jz8yWPSfSsPJ51FyLis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xygdvi0nGbzIOExYTrl4EsC0IG4SOhUJ2+tt9JRIeSGpDW7hPgPRECujb+Ku+nnALTtmaMAiXtQ/nPA9+l0uRpxVJe+pHdXdKpGPKCpaH9WyjUC5EWldnmDXqV/SdPjNFJVTKUgSEea8yrzbbw3cm2gsihZ25ax2FS25292RinI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LjEv3RW9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yYrW66gA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FH0kXM1360897;
	Thu, 15 Jan 2026 22:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a/SQS35i8DWR4oJZCkn6VNuoevX7tFI8TNozwMVweXw=; b=
	LjEv3RW9Qi42tqS9GFVbSCW51xNdmDKJiNhkgmeaPYS/ewgnN0ivk/egB2t7pVIA
	gvQp1oCCyV/umEW/8h3PnjaKsLp+7nXbtFV/m5CIV2Px9TP5U1JLVMh//v8yBLUf
	jIw/2dgq2e3BUvxnLFgoKCixoTAmPI0W7+NlbKTAE84iobRUuwmiNNqCYDYpZD5d
	/gvUPYrKrfF0I539TN6FbenjT16/6xEFn3QeoQiLpMVontoXMJhj9tDioXBWmvtw
	VWe7hHQ8ZiWjaFS/H5M9uQDN+7t2RDs8uo7hc/mBOBpTLVauloo7REMbosQErDAY
	s1Fc/HtqQYJhaN9r9kGBXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp435h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 22:09:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FLi4N9029103;
	Thu, 15 Jan 2026 22:09:40 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7npcta-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 22:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VicqYsCUN962eZiidxtWj12RugFcf/PDLOgEx2UZtbIetBU2PKHsYL3bpayuatXq/I0x3dm6gZqJmNVBXieeWQHxKkI1BhX5v4NU0wR09dGNnHohKdiG8Y6PogIReZs4/Jqbmz3M3toyfVVQdPO0lEy8cn2+QnQlmVFELDvcALxTeCfrj+MroOhlWLsYd6SlF2cwKlUQ6bgn18AyeCA5+bFHMbITNntZZO5OyEs31rGQj5lM/n4L0LWeNjCJrW5OKVvE+vPSwCSt6dsW/W6mgXxJL1tXn6nq9SIDAfCKkU/IwYK7x3FT9TkGRAdYXgDEpeQoWPPESZP1cDe1orHSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/SQS35i8DWR4oJZCkn6VNuoevX7tFI8TNozwMVweXw=;
 b=hMeD+ipcG04f5vl2dCMVeAaKZ9GD6y5hebmwiXfTLDeQBc6M8I4W8Kc1q4d1QCVgZPrvQU3kZY6LFLR0lghepPrDmwOfYUyasPVXkmC+HN5O6vBJ+TxPceglg3jIPGpYQ3+ljYif9FWfTmSTP4g9VPU+5hbccSbSYMrnFW3pWl+qLnagogJOkBYQ+SWcORs5Vh6CLvUWRlm7CTeMXI0j3i4BAn3lERmTZLhBnYj//1ju50HlawoWbNof8oytybhEshOuawNKGcOfKdIDOAif92Y7mObjgaWmdw9p75GcO1ikn8/SirZNwdq8460axhwi4VBHnnk9FWrmDzK+vG28XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/SQS35i8DWR4oJZCkn6VNuoevX7tFI8TNozwMVweXw=;
 b=yYrW66gATJINpIX0ZJWVZO99NUvr3i3lPqdFeVYYESc9FRq66Ca5T9m5lQ4sOVVV66YD2V6aAX9xZw3X+4JTgn2qxirsLC9/ANueTuIOLMD5ic63irm1uJ4/wQg7+2FSFSxcLqWLrHUvej7Urn3c1yh2V8HtlMvpCcpjig9tuKQ=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 22:09:34 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%3]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 22:09:34 +0000
Message-ID: <3e190d32-fa91-4d5f-a0ce-225bfff7a410@oracle.com>
Date: Thu, 15 Jan 2026 16:09:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/29] jfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM
 <bharathsm@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg
 <martin@omnibond.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
        ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
        linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
        linux-f2fs-devel@lists.sourceforge.net
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <20260115-exportfs-nfsd-v1-22-8e80160e3c0c@kernel.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20260115-exportfs-nfsd-v1-22-8e80160e3c0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::16) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|CH0PR10MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: a9559ecf-c49c-42c8-233a-08de5482c408
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?elZZY0sxYTk4dEFZSEhqek5ubTIxTzRNTWp4U1pEeGQ1Q2V1SVF4Q050UnNn?=
 =?utf-8?B?OUdqMVBxUUhIOThVNjFQZWpFeGxYeXFqNXFLT2VCNWhYM2xiZ1dHc0wvV0k3?=
 =?utf-8?B?VHNkVUhWdXhrMitRUC85bjNPNWtEUzVDMXBOcGhUWG0wcGRDeis0TDd6ZEk1?=
 =?utf-8?B?dk9UNFpkSmltd3M2KzkzUGg2Mm1ham9tUUpEd1B0Qm5idGxTckVmY1dHL09M?=
 =?utf-8?B?cXRFZWNHb0lRajFYVUJoMGtuRndCVWl5dXZxM2I5WVlHVFVyNmVueVhEVnpK?=
 =?utf-8?B?c2NVL1kwcUhnSk9CbTk1RFBqdXBubnYrZzNITjV6Qi9zeFFuaVJBdlE4SlEw?=
 =?utf-8?B?bWxKQlluRU1hdXFkNFREdWpXeW1Wb2hPODhqQTZENUtwU1c1c2FZUTRxcFl0?=
 =?utf-8?B?U0w2UENIOVZnZXNHSWJ3Vm9zS3pyeXY3dXlHc2c1eVpTb2RoVFJWV1J4cTM3?=
 =?utf-8?B?eEQ3b1o0eVJISkxwK2VYS1E0dDRlTWNpWXEzeXdDazZnY3FEbXlMN2w2c2Fl?=
 =?utf-8?B?UnQwY0JRM1VWTVNqWmgyeFFKc0FRRDNYV3lyWDZxMThBenpYZEwxbnhRNHRi?=
 =?utf-8?B?SmdvNG9xb2puYWxvK0x0NXFwYW4zbkVtc3YyMjd3S3B5VUlHVk96VHZzVEh6?=
 =?utf-8?B?SDByTG1JVjJtTVdzTC9YWXdUVnRKMWpFRXVzbmNoeE5ZRHM0NnVaZkJPMEFF?=
 =?utf-8?B?bFQybS9oUFlBaGNackUwaktOTUxvUUVMdWZReXQ1eTN3ZDh5UWgwOURwdWJl?=
 =?utf-8?B?UmsrcHg3ZUtzZTc3QnFWcHM2ZWxaQUNTb05sRWRlVjJCWHNyd3UxOGhxZ1pY?=
 =?utf-8?B?ZytmQzNyTHVmN3hYQ3RuVndqNWxpTDBIdzdmclJnSDZsYVhaSVhyN1ZqOW1L?=
 =?utf-8?B?MitkcGk3Z3NMYlpkU2tGcXBtaldPeFdPdm1kK3lxSHo3MmdaSnlSd1EyMXMy?=
 =?utf-8?B?bVZwUzYveFduaXBNeWpoT0poVTlGUG54L1RlMXRiT2graWt6N0gxNFJ3UDZX?=
 =?utf-8?B?STVzcGwvc0llcEEzMm1jVytyd0Z6enJIZW9lSWxnc1RJK0xLdDM1UUhNekd2?=
 =?utf-8?B?UG5wdDJzZThaeUV3dDZrb2ZFQzgwa3N5ZVR4cXVSUEdWT216WXZBb0RYdGh1?=
 =?utf-8?B?dEw1SVVSeTNsUTJUaEMzN0taeVlMOEkxVE8zSSt3NXJheEJJRHNNSWtmN3JL?=
 =?utf-8?B?cWI1YzduZWFRTVZQem9aeHRpWVkxT3JRMjdER0txd3BKSmJCcHNGcVFGd0hY?=
 =?utf-8?B?dzF3L1dDVkM4UTUwNmNBYXZSamZXaDBScjRWbXRRMitvWjlDYjNPNnAvVTUw?=
 =?utf-8?B?TW8wcjhiNU9IUGtKMzdhc1A4aS9XT2FleERYOWVzRk5hSDF2M0NKdFhqMW9z?=
 =?utf-8?B?UU1VZ3NJbWF1M1MreEtPbmNyZmNLbTRuc3lpMDF6K3c5dnBHQkpDZGpHa1l3?=
 =?utf-8?B?bEd3SEgxaEVRcUdkWkpYbVhiWHZYYzhBUC9TUFZvbTNrQ1VqN3hIU0ZTcVhE?=
 =?utf-8?B?ei8vUkh0bVczRVBBa25yQ1ZuNHBqZlBpcnZmbjMwQS8zbi9rQ3hXcGt1WkFn?=
 =?utf-8?B?OVBoR2s1dXkxWWxhQWhjVkZsaysvY1hOU0s1WStCMzRYNlRGL1pqZ1FTejd6?=
 =?utf-8?B?WGdhOGJDam0wclVTZit5bWhkdG16Mm03QXpCZVpEemg4cytJWEZ0OFVXdlF4?=
 =?utf-8?B?QmNuNUNvSXZESGg2bmE4ZjM3d3gzSjlEb2RhMWVBQjE4ak9obTc0Nmc0MFQ1?=
 =?utf-8?B?OGhWaVk3eGJTdGtLajBjaFN4dW9UbFRFd3FtUWloZ2p6RGlqMC9mVVVNaTgv?=
 =?utf-8?B?V2Nqc1FTVFg0WU1qSk5HZXRyV0U4RWZSdHRkbWFUb2Y4OEM3RXU1L2xvR25P?=
 =?utf-8?B?SjZiMW9kd2JvWm5ERzIzUVQ1V1hweGRUblFWRGFPOGZRa3g0aGRLTWdNTFBZ?=
 =?utf-8?B?Tk02ZVcrTFpnUWNtQjBXWGo2MFpUOGZva1dza2hpSmhyRk5WTmhYR1d4a3Iz?=
 =?utf-8?B?Mmd0NFlWa25Qb013RUpudG81VlI1TUp2Um05OWY3T3dBMEUvbW1TVEg0SENl?=
 =?utf-8?B?VXdkc2Q4UWc0dFhjTzhyNTc1WFZjNG5xbDRYeGh2TFFsbmgzU01iN1ppN3VR?=
 =?utf-8?B?VFp3Q1FmTVNrY0RpSjhjK2JWOUYydGduaFVkeWNiVW9vYTlxazdkd3hXVTJN?=
 =?utf-8?B?d1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TTZWNDNJVFRzb0lRaTk5ZGRzRUpVampYQnhBK2tTOWJzSDVCUnUxeVJvbmkv?=
 =?utf-8?B?UlJoVmR0aDNZSlB6TjIzeVUzKzhsdlRqSlFEYjhjVzdqMGZJcUlEVS96RVFD?=
 =?utf-8?B?L3c5VXZ2bXVVRjFXUkUrYklxaEpHWkoyeGFUOG5nMjcwS3hBODI4bzltdE9K?=
 =?utf-8?B?STFHTHFQVUlBdGVlbVl0bFhuamE4MXh2SGZWODN5ZjF3ZU9heldmb1ppQjJU?=
 =?utf-8?B?c1hpTXFhQ1JROFRVWm5WSktYSUpwSjU0cHZlZkdiRkc5amhxNHF1c3FvRHdU?=
 =?utf-8?B?b0d4bjlQMlk4Q2MrdDNkYVZGT1AzUTVadzk4aTJTcWg4dk12aVlEam1jSU5N?=
 =?utf-8?B?VThjMEtnWmNOSDZNdngzM01WREErdzFQUVZTY0tNYzZrNENEUGh5MHlvclBi?=
 =?utf-8?B?QkVKYW1UK1M0bTJGeDRTdThHanl2NjBySC81VnRyeVhxNXZPZGdiRnk2T01B?=
 =?utf-8?B?YllNWG8yWllyNlJaQWZZOVUybVI4a3FLLzBTcERmaXcwdkN6ajdoRis5Zndk?=
 =?utf-8?B?OUF2SEpKS250ekU5UVd5NUppMGZmZ09OR0FOMnNLR2g3WUhzanBxc0dURmVp?=
 =?utf-8?B?NzM2VHk3ZUwyL3hrakl4N3RNR3dZM1E3YkNKUXJ0dVArSHlpc0F2R28xampR?=
 =?utf-8?B?UCtFUytZMFNPZDFRVWFGeiswM1E4WFZVbVA5UWV3OFI5ZmhkcWg5c2VtRDNk?=
 =?utf-8?B?NWVObkV6STUweUw3cnJxYTVGNmw0cFM4N0lpZHU0bnFhd2VNbWVFR25zVWtO?=
 =?utf-8?B?dmFoeG41a3F4UUtzdjh0WTlqYnl4MS9oUTQ4TUs3NXFYWjB6QW9rbjhZVS9L?=
 =?utf-8?B?U1oyQnRWOUNmcmxoWmRTbFVkaVRrczZwQmE0enRwUXlhNDNFUVRZZ1lOZDdU?=
 =?utf-8?B?N2Q4Mk9qNGVhaXV0bUV2cnZ3NDNZRXJEU2VMbkVlK0c3aFhBalE2N2dta1pQ?=
 =?utf-8?B?M3RxOFVMOS9vNTR0RFZ6bVROOHdQMFFEaTJBcGVvbmlxU05NKzVwK2prOVQx?=
 =?utf-8?B?bWY2UWZwZnZMczNqZUhLcVp5SEErVlNpekZtREdBR1JqQk1qcmFGMDdxYVow?=
 =?utf-8?B?UzhzUG1WMDFEVWRITzJRb0x4aE85cEsyemhQcWJuWWY3UmpVclVoV0gyMmw2?=
 =?utf-8?B?aHZXZWNiR2dvc2hybmwvMUI2L003eEZpNnkyaWQzemRBeENSU1F0RzNOcGRW?=
 =?utf-8?B?VE90R0NsUWtSSXBDaUVVendIcHNhUGxnSnJkZ1k4VitIT0toWlozNG9ZQWJx?=
 =?utf-8?B?bUNFWGR0UTdyQkRsSkZzeVlTU1hVeEhxTjh3cDhGQXViWUZHY3VmM2dzbGpm?=
 =?utf-8?B?UmkxbVJlNzJqMzRVUXg3MXNtVlpWNERZcWFEWnZROWZNejViUGRzVktxUnBz?=
 =?utf-8?B?U1RXVzFqNElSbGlCZ0tNZ1RkMlRDbFpxcXVRNFpHQTBFeEVJVnRxZ00zdm1t?=
 =?utf-8?B?Z0hSMjBNOXIydzdpTXB1T3ZJajBrREZONTFRY3AzbG9jZkE2MG5UUERaVjRs?=
 =?utf-8?B?YVMvcGQ2QklVOXM2WVM3UFhzRzl1MFVWVlc3SVhGbGtzTUgzQkdPNzRmT2Vv?=
 =?utf-8?B?ZHU4RWtRa09DR1NpZjViMFRZNExMUjZtQTJiclB2RDdoNFM2VnJjanVmMEZh?=
 =?utf-8?B?SkJ6WXM1bnNLZWJ4SzJGTGFLdFFDSFdQVytuZEtuYXVnMTBlWE5KVGNHbi9s?=
 =?utf-8?B?amEyaEt2L3VJTlZCdWQyaExPS3JjZ3ROZ1UvY0VHWmpvaUJWVlBmNVlKZ2pC?=
 =?utf-8?B?RWxpdTNNSUNHWTN3N0JYS0Jia1VjQlRad29SOWtnbko1UGROd1gxVXZDMkd0?=
 =?utf-8?B?aXpGZVhEZ05vVzRvRjkzTTh4QnlSQjBKL3V4ZmplVXR6am5zYXNId1RFL3Vt?=
 =?utf-8?B?b0RITklZb29yeUlNOTl3ekFwTzRzK0VWYXZ2bGhqR1hxdEtLZGRyWXhnVTM2?=
 =?utf-8?B?RjEwVFNrT2xxQ3BBYlZpY1NGd29CeE56OVI2VU8weklpZ3pnQ0VTSjN6cWkx?=
 =?utf-8?B?YSt0YWtJN0hTNmlQNTUwNFVkaXdtYjVHemYrK2VENGxrNlhra2Yxb1hVTkFy?=
 =?utf-8?B?V1l2dVZXVWp0Q2JtdVRqWFk2VE1RTVhiV2lkUWUyMndhU2dJK2gyUlQ3a0wv?=
 =?utf-8?B?c3htdmNRejExMWEzYWdVb3prOGtkK2Q2eVI4d2ltQ0piNERjTTZ5RjV4bC9H?=
 =?utf-8?B?dlkydE1uOFlhR3hRV1dHa2lnUnFkeG9odHlwTkVXa3dsdGJ6NkZZV05SalRi?=
 =?utf-8?B?a0dxRFduSEdid1FXZTU4SUpxK2FqMTgvY0Nqc2JCaXRIN2xhc1Z4Nnp1QTJS?=
 =?utf-8?B?M1VNK2R4a0N5YVBJOENueUlCd01OUkV2TnVUNzRvVnJyT0J4VUJ2dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uh2I/3fX65AdErpDF2oeD/0sJxqN2tnXRQ71Yxxef2shjIz8ZxJQF8mSYD35dhVbD7zr965BEhLZQuvLbMGiBhNWJgErPnCnLbIz07TmJhgPV6OMss80kjNU8FfITblTi3rkm0r3o+xi8WloKJ6jPzd7zcU06csSpGfdlqHLgigSS/xKH7UTrYUX34OFGEv00ELxVRhYC6enssvYTsHmSYs8XGi7H0TdHIbh9xbK6FPqBTZ2Rl3b5NVrNLzVLu9nVjOWXoJfnsz3ZRpohVnz2USe/QXV4rr07N9rTOyzt/pKslVjX0TuiZaPKkhEd8rsRI9IqGiCzQYGV7QvH8EskglyZ9uOw/7yg40PJeKfvsewggfKqmAtpRu95xREQNnAOk1vRjEvRSecjwJRzCXp1ewmkwlFwyTRshkTzV47UVZGtfVRqTVv9ULsbZIT2onSx5tPUmyE+9RIurUKspkQUc4DaX8ljeI38a+mP0FsLGNUB9n+8UNPsuUM77zaPmpBadi46I6sXBOBO9EU84gboGOrYGr/mJDWJlHODEBHJvt95qeMZTSRmwQ0D1sNW/PgdSbzfpbzrDuuHgvePTIWJYZ+yhZTBnuWDF91tBY2JjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9559ecf-c49c-42c8-233a-08de5482c408
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 22:09:34.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc01HJkssjcjDCXMlMXxLZlYN0CYwut/19tGWj3QYsV8uCThVXmtg9kMu7KQSjCUkbaAX4WOddTPOc0BzL2xA+FxGfREkflpFPyDYQ2o3hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE3NCBTYWx0ZWRfX9Eqbs15krqgp
 0y2OWraze/Fz71jt8VF0f8XxtqGNXv0zxxuJXr306KYL6G5v4kp+PT5Fe19JZVWEIripOK90C4o
 1iynRkCOZdkn1GeFYlFE4n91TetAGll424oIT2/J/0pw6Q0Px5UhdrLMYNBZf4f/bSBrK3LH+wB
 PrTTJJyRi14RMpvJBoejoA2nqKE0guFG4czOfUPD9xhsNnQvQIygioF9uVYzrnykoLQMjXJZxoV
 jos3DEMLggIYt6l0Wmz3eP2HxgKsaeHv9hRuM91mJgafF79ougVpnkeF40p0ZkLIpCdMPkVa7hu
 gymj/VyiSwTZ9uMJvIElM+E0kxid9U0YdWkiRFUHOGqyA9IXszJF/7zEbJmzR5yjOkDynXo2Yt2
 au1WuD00Td2n7U27gCaUh3Zcu3PkN/hxl+9RDOYtl3kPcv4ywABc6BXjoHnzzEU0LbNaYe4McZl
 Xym5qOgBKNfe/Io4k41ky4Ni7vhvxan2m7LXxwtU=
X-Proofpoint-GUID: tOuDmx0mAmotyHHO9ytbUNoit5mmYKpt
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=696965a5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6nsF2ZGE96jZ9AZUSPEA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: tOuDmx0mAmotyHHO9ytbUNoit5mmYKpt

On 1/15/26 11:47AM, Jeff Layton wrote:
> Add the EXPORT_OP_STABLE_HANDLES flag to jfs export operations to indicate
> that this filesystem can be exported via NFS.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 3cfb86c5a36e8f0c46a2734a24fba6ffd36c7ad9..ac9b6d754f8c203baa7e91362aeb0dc9b3ce209f 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -864,6 +864,7 @@ static const struct export_operations jfs_export_operations = {
>   	.fh_to_dentry	= jfs_fh_to_dentry,
>   	.fh_to_parent	= jfs_fh_to_parent,
>   	.get_parent	= jfs_get_parent,
> +	.flags		= EXPORT_OP_STABLE_HANDLES,
>   };
>   
>   static void jfs_init_options(struct fs_context *fc, struct jfs_context *ctx)
> 


