Return-Path: <linux-fsdevel+bounces-51801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC3ADB9B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178C01890D7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4137228A1DC;
	Mon, 16 Jun 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJiIgcxP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WLgkcKQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF91E5710;
	Mon, 16 Jun 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102506; cv=fail; b=q6FO7T/zmHR62gUUSlQe99uF/0CXsatN/N//R4VeZDTWzN0aTE6RhJguQTwQK1Os79n4R0G/8kK0PYi8cCGENzFEjv9ytN3fxY3jkKfCDbEl5uiMmBLoV+h0YnpF4gLZsaxJkwRtODrE9u4bzzhVTVt8E9SwOTivwOpgEgJcz5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102506; c=relaxed/simple;
	bh=/mwCp/4udnbGqk80i9dyqnRhCS+CABeA4knMW7yyEDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8/cmzNkek4jh1mDOSozU+m2qINJ8sD8F0eTWCJ5rCsKtTie6ef21a4KuPsfznyTJ6nJYCSINzquP6N+NJa1BfvPBv3S0+LEAlGXtfgqDrpUXPTsrN0shKDo98Vhedo66smambzXSu4db9kRGzlRRLzNNZpWqVh9KKIhErwABaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJiIgcxP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WLgkcKQF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuUKt030561;
	Mon, 16 Jun 2025 19:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LW2VP8yfofGIRzehsz2ZWLW9EIqsqvISQKJ61JouG/I=; b=
	eJiIgcxPFKx5G8KWyEh8Cmr886kDtfCuT32DyykyBQGsuNzdmUURHN/xsTtzYExY
	3njJxgURjdtz/ifK0juFyUA93L+vfVKkxUIgzvFDyVGeoiZOSyAoBflFdJxCWOoF
	oLIXXhVwVm0lfF8TbShOIMU5kxUZUrru+A7k+09jmMxRFqb2M7+WphXDWlWsSfZm
	MEI6IiXz2bHT7vq3dfVeRo5GtuFBScToFn9xt3+O3gWDcFWUOrlAo3AZxmc8l8q/
	T2lgDbk1Hg6Fk3+nXC/f0btCC5HPwvz0Fbrvbt1UDnBpjSV1tvIzX8Sp8lig13F8
	Y6X8rHqkCZ170vE2cvBVnQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r2s5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJN1IZ036378;
	Mon, 16 Jun 2025 19:33:59 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yheuf4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvkuzszHzfNN0+mBpgY0AxpUphOZuv41O/lGxnXNkNHEoYW7qo5YVlnAJmPRrC31tgkbTfte5kGB0BtAcbdKHxirZANBgKsUYgyrQ6CEfyBFzzQJ2zwYMFNBSISzgmosZnb9zBqML1A800GC/AiMTjnua59iyxR28wLj5eTowG9yIzqqgxN68+KYM6ZUrlCHD9KCYNfhAXQ+aD+xkW+uQNM1iXn4FN3IaETtmL0GZeVnz52aYl1sM1+XT8aL8eJIlrdihxMInd/clA8ihItfi0OR/6qMaMDyDSQYgGSucRkvJbxPLs2oVTL7zOr0tqXr4x3cbD0cmBR4/OfKW4npcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW2VP8yfofGIRzehsz2ZWLW9EIqsqvISQKJ61JouG/I=;
 b=UCjqbnY+iLK+Tznm3c3eNsxaanKKbLvhKYY7LRvPo4+yqdk/RsLm+gD7A7yCJsKnAmgduFbVgMpBYFquEdgq25GK/gvVFDOL7w6UXWagwMmK/EqTHtD0iRnh/c+sG22ny4SaXJT2Tl9I5MYfDBsAxg2gYvJru7mwITdMyhZMdOUM2rhPXPrZBovZluh2MS0KjkEpsp9yK/0QJckHx/Tcgq0fhBvTAAt5PdNvB1xP2fk0Fa49ViHiHzdsNYaWcdw1KF9SZbhKfv6KuOW6ik2oFWLBkrUxFY1Im4bGX0DZ4vdbc49w/DTKjRJXFKd4/KxA4kHjIbLP+VWTwt2+bMHkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW2VP8yfofGIRzehsz2ZWLW9EIqsqvISQKJ61JouG/I=;
 b=WLgkcKQFX76ox4GJIfCPdGg+2dySOsb/JP54UhLhZygEX/E2zPagrdQJL5npQxjALzjl2Hi4L+aWX/szaG2U//vk1gnw+qpzTu71Vl9OOVI8ymK0Jxgnh7+++4kHhvEBVxg6Ff0CB1h1ITgu6KwDP++R0xwe6UlzV1FslBetWkM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:33:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:33:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
        Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-aio@kvack.org,
        linux-unionfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: [PATCH 04/10] fs/dax: make it possible to check dev dax support without a VMA
Date: Mon, 16 Jun 2025 20:33:23 +0100
Message-ID: <b09de1e8544384074165d92d048e80058d971286.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0263.eurprd05.prod.outlook.com
 (2603:10a6:20b:493::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e62733-a901-425e-77c3-08ddad0cba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yql6hMCo4wYJ8IKUwX4yABlrxBbtuGvQuHVvF5zHUXSFId6GcspKuYP4Vv2O?=
 =?us-ascii?Q?9u7m2rEdEEWMqaAffqUzPcPvYYfWmY1KnOjvjWhACOhDRthkIL6KU3Dvul3m?=
 =?us-ascii?Q?wTKxFhvZKYEMAiFK0uHVGCYOu/ZA4x882uK147DSa+4bwzGupssZYkThsu9t?=
 =?us-ascii?Q?4Kn2Ikpg/ZQcZgoez1rahGYTc33TiUa3vr3ljaEgbV84uc6e9/Nt0Z4QmN5l?=
 =?us-ascii?Q?u09v+ND5N3gUz1hHXJYFo0RqJRRzpfUE/Permrun726c96hRL7dopC1jXF2n?=
 =?us-ascii?Q?qeliiYbV/Y2tyYierV3bqSKd6Ys2Tq8b0B1bYXo2QjK3IqSVjI6LWc4hLqF/?=
 =?us-ascii?Q?R+1miLC6FPog4cypVlre+hf83x42ZoTZS2d/HRwfbVBjf++wAT8r+CSiRv+s?=
 =?us-ascii?Q?jJp0Mtwb5KDQdgZy3a9Z1lLFt9s+uH0SUazUeFxAxV0PveiZ8eo8obKG/5Fm?=
 =?us-ascii?Q?xG7vudOklNsOgwtJoo58EQzALMVk99zOQ+Sw4yu5lXfIrtdR78ulZhIpiH+m?=
 =?us-ascii?Q?nwjPRPHkZfjzYuSaQodm/M5IQ10UUi202Zm7To7j/Q9Pc4yIJmmVElFMbU7F?=
 =?us-ascii?Q?tj4LjK0u/cvTAPZhRhtROCAyku/ba7LYXaYym3i1WifE7vAzDfBlmGTAxQYJ?=
 =?us-ascii?Q?vo7uZdYqvGqSe/uMjohxs+cAi4D3JlOaD4dorG+qt8tbp4am7EOri4h3RdBY?=
 =?us-ascii?Q?LT8JEVrZzYqQKsJos5Cp1lhM2gb1im/lHU9O0/dXSBEaylivsR38dd/wEq9i?=
 =?us-ascii?Q?yRUMTCEVyYkAzoFiNNtokj1UOKeVKVOiXHXmuDCGVeNSnaW1JpSXZBTkxOKi?=
 =?us-ascii?Q?8LBUbY2PhMcjPaps9LkvsgBF4uB2KlTdfJEYBoehoVa+Fikz60eJBb6WPXBN?=
 =?us-ascii?Q?2FyDx4Uf6rU3/nhjp7ujSdXOLePjBfKsKNPmNnKFQonzAqFM/ck+sIdvX9nm?=
 =?us-ascii?Q?PeZruZuGw2ElUcBTFqKBT5TMhbgdp3Tx6nhiKx9Zpo0jC/6elZO1y/Z7FRU1?=
 =?us-ascii?Q?FuHO5OdS+ZDpufrxYIJvyaFNRI43am5a64Im3PLTN8EYMrfcg+QPYWdlcCQY?=
 =?us-ascii?Q?aVVnEfeoYzu4asK37gSKp0T6qKO4zyWCc1fTsLxE9yWT8126fVZvCBKGuXtx?=
 =?us-ascii?Q?1d+PQRjYysmdtD7lY1Kmv8ixf3lJrtYJuKUNWhCnTLN9NecRmavmBbtv4PNP?=
 =?us-ascii?Q?EiJ7c3pSCp1+c+m51PhcgEOPYARlT/XhJFaUVl4C/R952KKP/qhI9HRM/Lli?=
 =?us-ascii?Q?S/WdYtNF4n1ZJi6xJE77VN57el1ZfCOTmHtJeceHgAqw+DE242zSgDiuB4Zs?=
 =?us-ascii?Q?zBj95Bm8KtXsftb4BRkBI2Ao24Hiq5D8vhuvQU9kUaPhZWwnDQnSE1V6aIGT?=
 =?us-ascii?Q?B4FpEqBJ/yVclwfBDn8l2ON/IoJ4dE08JN/dy8PfNbVDZ4XdbOumkWL2hEtR?=
 =?us-ascii?Q?yPrUTba3X5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGQXiwQgFbQTe2vw/b1zCAgD73mZ9q2VUy7s4MuX+tvwBtZd9pkaFGsrJkAn?=
 =?us-ascii?Q?ovDMx63XdP61U1PfC0BGUGB9hjA4HSnTr1NNZgXU2yi92MMN9IskQrQ4yipr?=
 =?us-ascii?Q?6fDvuj4pECTuAyIfnA7UwfDzjdjHJOcjfnE6XGcrBYRcCMPJBsYx+nAJay0o?=
 =?us-ascii?Q?z7ci8w62rwEIJR5OSi0r5TM3MyMbUsAIx7R7YSaE3Z9/rX7TR4yG0xM1B8j8?=
 =?us-ascii?Q?d5MrToDJtCHAG5vUVYcL2tr3rYH6Kw8d/5AolipnvLv0yfnvGOTkGCa5bVWD?=
 =?us-ascii?Q?tFIFHLqCRCyWfINoyrZY7K3ZziSiT9LPF+iZNZ6cZDf37rKamAqaNLwZgtsW?=
 =?us-ascii?Q?R/hq12cOPxK8nG3exeq2asRwikkZ73hRFP5Wq9a1kLyi7plWuCiA7Yu6wmcU?=
 =?us-ascii?Q?0R+iHwcGDWxeikRt/UugbsHqBqgCXbuhNEEN0mDP5zwPG2IcT0rGb3OmEWC/?=
 =?us-ascii?Q?qsMTW4PJnSNptCJd91lfjCFa76gtddtY4HrMT52G4djq8men4an4rh5fyx9W?=
 =?us-ascii?Q?OwT7KEu7FkELR3rsT3ZJ8JYYsmoth8SiwGw3ka4YBmC2OeEBpw02ZAOSh/0H?=
 =?us-ascii?Q?K03gBLRhj+iNJzV9tFyoAUC0K4buP2qny0+YmU7Xu4hFY53+rhKQbtq2UgR1?=
 =?us-ascii?Q?TPnwTjvfpd3FVetTj9xk3+dFBfrO7H354igAlROmAt86IXJ4ygklUC83EExZ?=
 =?us-ascii?Q?JxXOi0QvNkeeshoupZrV2CQVTDH/xD8ekaZudLm/WFBxbKueOoklpMuQ8M5I?=
 =?us-ascii?Q?UE8wDpAqk5SinT00LbMvVlj0jbkTcrOoKiP9FvVuTVvomO956GmFt4Xe9h9j?=
 =?us-ascii?Q?ZD+Nm+ozF6deFmkBWPmcRzLlqi/cBc/2ioJ1TNvrrL7S7TKbthDeu217txkx?=
 =?us-ascii?Q?3uJ2mA79Fb+YoohMkzf+6sDL8J2NX5fP67rZNuV0BHhZZEPebs1kgsa5jVGl?=
 =?us-ascii?Q?3XjPfqmmr2BOu2g61Nkck3/rNNFKzAcmu8Ldta19vDI2giO0+tDZ8lV/MzfY?=
 =?us-ascii?Q?d6mt3y6oqIdmcvdM43z9LF+yDArj0vUxXALKDET09UfxqiHoIA2lLxcUipyh?=
 =?us-ascii?Q?9oCJYmLNfyTXlkBBKeGScLbNjtk4Dt9zQKdyICLpJicPLVnRwqVyZFya38YU?=
 =?us-ascii?Q?pbzshytjnACOpR9wrH6WZL9pmCyJUrpw20Ud+DCbex9v4Us3yH4MoWIGAFO7?=
 =?us-ascii?Q?63n8dAripeZ5CUKzja2v+BQxCHSddWrUaD5VT+Qnx3f6LD1dQGas3uVewndy?=
 =?us-ascii?Q?sUo342sqNnj7IbLT46e1NJpPna0hQyWPuzR8SuFA7KLXtf65PELl4hnWGdpb?=
 =?us-ascii?Q?ETZ8ksXB73NyRQM23yHsfVrpWw9e9RruBmKAWqFveTmet+Ee1wismWyBc/Gs?=
 =?us-ascii?Q?peoEWfBuZ+LnT69mvrxIYfDEAtjQw8nkJj/dBXCTwMOTPxg+lZB44PGMfXyE?=
 =?us-ascii?Q?PtPA7655Lc/tXvV+jid7spid2nWASP3p6R+pU6k5hKsFR1Hi4YuK3/eZTnii?=
 =?us-ascii?Q?10kEr6bvGEVffUE2sQ2wRTSkLoDb4AGACnRf/0cvj+lq8dvigbkftHKQcrRB?=
 =?us-ascii?Q?kolhLaEIMaLXtbbhhhUxdL+os38dUNd9B6J3kL8+BOZDqxYDVQL9F3S9mXCR?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pjOmgsOGHvsW4mWwScbxkAcBTaS+ncz5w8wxirnlxLfcpb9qBs4Dui4A+GYx76uaXFGAw3NPgxY9Up8jNWChLjr9HBN7e+vOnnrdF5tyjujdDkQWQnYWa7Nly6RuFFKKAYH5TRQwc9bVE2FfSO9EkxU43A4EapvZvqcXboA0BP5DOkYJ9DEvPaYivQ1a5PyTJo7N+vUA2OlKlFIJR59NoDOZkxdkwTIJGb+ELPx9aLRlQUptUok9WgoDrSliFkkqUNu5MPP6Olsj+xEciG+3vHsCYDgT2WKbglMVswDuLEitV+wbxd5vLHrahVo9dy9Sa/zjtwViD2CE0ImH/04ON0vEa8Gsv9Kxod/t0yg5W46bc6yzO488wXX9p2TNNq37V1RygHTMScu9uJH2kz9RZNpkGUgXL7SoIhUHZVvnwWReb4vOTLX+7AkFsph0X2BYDQk1kZf8ShFz/RHs+HYK0WMIzMBSUfvLJScHlPYxeUUc1hGyBfFmnVv8U6SZHxsrUOdnU4m1D0tY2Vt9ZcRsmOXDsZFrs+L4DqmcGsNQdRL1obskaSQMCN7HZS4IlMG74o+P0p+4ScXj/tI0tbRZtVF/lI+ApzPvvZY8a1LawKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e62733-a901-425e-77c3-08ddad0cba86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:33:53.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKLM/DJaZO32StAp525/syyOoY/t7EmGavfpqWRJVGsgHKIZdmc9GohbxZUTqjNV8axl2PofqS+q/JbSztnr5gWYR1zlxwfEyDEhqsn9sno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX8TVAxedYE8MJ zz2YW6a5i1jo+Fp8ivlxDJ7GwU5bObneaCeh4DnRnDdHZVewcxpb+EKazbt3SBhG7aM6Idwi0rr qHc4RtwH7tWGymrvpkIV+E5FXIpJyp23fXC4kJu4KdNxis7+Bd/5+/8P4GSyVPBioWdEgmfMDN5
 VpvVNzKGYuQV4K1jCafR8sK81Rtt3nyuMdHoSyqWCKgvjeV7+6jZ+0ZqIld1RKKGZsU1M1SVAsB /WgtjznwkoqkGo5HpazP9BmyOdLuhyCmAsbhj06PIk793CAq9w7XdMXcwS5MRdCeT5K+7ztpcj0 hppRwqDaEhe4MdO5FuoClwFzAfxoAThXUlGyuKIOx4xjrpuAUU1saCFoa8ph/V+D14OmzHhNtZz
 K/I1DoW2j1bfItG5v6TgrGBoEJYUvAsOXqn3hfYwPyFDnESWOGWQDv5jL5ETSWNKdH8AEc5o
X-Proofpoint-GUID: 5FMWxCSXqRYlr7BLe7fOS4qxhBwZ9j2L
X-Proofpoint-ORIG-GUID: 5FMWxCSXqRYlr7BLe7fOS4qxhBwZ9j2L
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=685071a8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=1PUvNFCg9JWibKYo:21 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vdSroFb1ziFuJU9_f_AA:9 cc=ntf awl=host:14714

This is a prerequisite for adapting those filesystems to use the
.mmap_prepare() hook for mmap()'ing which invoke this check as this hook
does not have access to a VMA pointer.

To effect this, change the signature of daxdev_mapping_supported() and
update its callers (ext4 and xfs mmap()'ing hook code).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/ext4/file.c      |  2 +-
 fs/xfs/xfs_file.c   |  3 ++-
 include/linux/dax.h | 16 +++++++++-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 21df81347147..08a814fcd956 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -821,7 +821,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(vma, dax_dev))
+	if (!daxdev_mapping_supported(vma->vm_flags, vma->vm_file, dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 48254a72071b..ab97ce1f9087 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1924,7 +1924,8 @@ xfs_file_mmap(
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(vma, target->bt_daxdev))
+	if (!daxdev_mapping_supported(vma->vm_flags, vma->vm_file,
+				      target->bt_daxdev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dcc9fcdf14e4..d0092cefb963 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -65,12 +65,13 @@ size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
-static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
-					     struct dax_device *dax_dev)
+static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+					    struct file *file,
+					    struct dax_device *dax_dev)
 {
-	if (!(vma->vm_flags & VM_SYNC))
+	if (!(vm_flags & VM_SYNC))
 		return true;
-	if (!IS_DAX(file_inode(vma->vm_file)))
+	if (!IS_DAX(file_inode(file)))
 		return false;
 	return dax_synchronous(dax_dev);
 }
@@ -110,10 +111,11 @@ static inline void set_dax_nomc(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
-static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
-				struct dax_device *dax_dev)
+static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+					    struct file *file,
+					    struct dax_device *dax_dev)
 {
-	return !(vma->vm_flags & VM_SYNC);
+	return !(vm_flags & VM_SYNC);
 }
 static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
-- 
2.49.0


