Return-Path: <linux-fsdevel+bounces-51803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA053ADB9BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12157A345C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79A288C38;
	Mon, 16 Jun 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o3wz00KP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="djWHsynt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAED28A1DD;
	Mon, 16 Jun 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102511; cv=fail; b=J0wQsgBnqZa7u84CV/U7i5UjVigw8Ql0t7PjMbGHLazniwmjausbBJidAV4MRPV2K7f5VOCipbuPEff9Mrzdb+KE1/AChMdpWr3FIRhmcuTz76ZUkY4pMY1Y7bShDQ/oDjYsNJ8HWU5is5/BGBescyr8d3J5cPPyxn/OTZpOYlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102511; c=relaxed/simple;
	bh=xyvciqq7bBwqxMM8NLqgQkaWhZ9sTqLuc2pVA9yZaEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spY9bgTJfCNHOMDIlUbOd23/rudNBhSo17IQGCaPbkKWXjnVz6iXUYsdw1D9IhKatqh2PueAa3SV14KyiMKKhdZi7jMXUwf1cItfXaf5C3oUIzQ18fwyjena6hD1Pw8ZLTdWvLL35UnVRmG7Bse3Tj40kM5Jebs4x4nLte08D1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o3wz00KP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=djWHsynt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuWHU006662;
	Mon, 16 Jun 2025 19:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OkcVOJolnz5KIPxF3XETf1nbjZvW74UpRHbetRk6v34=; b=
	o3wz00KPuemHkOiLs/WxM9vDB5azgAW3hzLgEDtewfFJFYH25iYJfCjwPNWkHWN+
	DYXr2sDx+SNYyut1hhW5fKQ32VW5TtsQqWMkUwtVSG/nr+DLFstLhqY+ygehdjOf
	5xNo99CdwZfDi/AKskTCXcihNb0GQlGByTwlMxq2b7lELylnLFihF/kbJh8E92wC
	GR80J0k/q0C7lTnrtwGLEfDOl3gf9ntbrJgIG3aA/g5tqrY6PK3oHqsBR1IkGP/2
	Pbm/0i23nB0GR+9XPw8yDwL3V9lisi04oShpqenKQW4cjqYf1E9dhYCETAMX1pAa
	OHZMaM6Sp/Fv/9yY/QKvVw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900euq8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJAKnc001648;
	Mon, 16 Jun 2025 19:33:54 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8bqb0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCMOnqxgp4s0IZF0RH6W5WRRogkEzu8FoNGItzdQGeNH3K6/fD9Pvr/P60kSXzYbnUwGkYLbETVEpNyCmfGYL5tJ9rM/g2UAN4VBqlXnch6E2ytpEsZGER26brDGRPuBXI6iDIvtitiNgxjGiY+qSSOqRpB9tcXSk2/EE/zsT5zlrOlUv69uaAG6w6hnFZ1GVrGPqJtRLDntqZUr35ygii3rPV8EY3tLSGxzZR91lC7R+821380QQpQ+pGAn8k4uSWGZnp0Si80w3hrPRVyGN9yj5izMW5bJzb3HB6CzmO4p2Pf8xjWE9sNUa86RX/6+Fq0Nq5dGr6g0kDspyqt7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkcVOJolnz5KIPxF3XETf1nbjZvW74UpRHbetRk6v34=;
 b=OHCRkMtiAjUtNxWgTc1inJqDHm8VcZfInMg1zNLG/RruFn+QjwB7CHPKyPoZDKR5bU6RRXHApTLValAtQkeo16ScdUZn0VR2SsNJ5NEEwK35NuivG6P/w5vnGfrmV0E6oIjLVAEbWPLXRFwKM6aw4uPm53RF+/Hp668wP+Ohjh09gWe5HTzEcl+dFzuZXOJ1Li/L6wFCDA7llDbVgc7textToX8YTE970SGw59JNVu0AbdToXTEQTFGG9jAG9xCxXg76QeN06glJS7Hvycg9H8nKNZ1G5vU0/g6ViQl91QRZpcBfBFIKtB6B+alkcyZAW9vJfFYsEHgUzvQUPSG4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkcVOJolnz5KIPxF3XETf1nbjZvW74UpRHbetRk6v34=;
 b=djWHsyntllUA/R354wb1hkzRECPC0Z66PaMpFWwSlV1y0ZsvVNKgYX2iJcq22CqNHx5zfnB8veBffwOsSiiFNoN2hUy2drMBGgmRLzmIgPIj5B5O4m1LhvocFsUotuNV6Htj3USQJe+KSrtI/DdvBdGXRekH59gLTJF3/291tV0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 19:33:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:33:50 +0000
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
Subject: [PATCH 03/10] fs: consistently use file_has_valid_mmap_hooks() helper
Date: Mon, 16 Jun 2025 20:33:22 +0100
Message-ID: <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0571.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: f597330c-860f-42de-fcf8-08ddad0cb86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTaImiHE2zItLT5+WfnXoe2XQyDjdfT0/w281mG5w4VtzXJPPCnRsMn6zQ/k?=
 =?us-ascii?Q?DovwvHKRTTCiEkhksxrN8sJypZqS5NBTgAUM4XYSipZfE+9q0YZvjZlDXOqR?=
 =?us-ascii?Q?WqcIUPipsR5o/4DKPQN5q1tLhJF2sgxAKPnl6ld+XoBF20yUrjgkkmxO2xD1?=
 =?us-ascii?Q?h+k7UGL+Fn4pgVezGCvEGvG3TBnMJimNghCqk1rsXUBt4kHkmaQzrhKhDO30?=
 =?us-ascii?Q?qYsVD6y1QL2qIfuiwFoTxop8vMttVX6QzEZOvuvPKy+PeMX1Qcn0mo9FnJ9w?=
 =?us-ascii?Q?bQnQuHZZ1/996fpkGHxFnwWHVONVp/bdPRzLSNqV5lK4cBlkAvr51e7+oC8h?=
 =?us-ascii?Q?Ek1ky8EmqmE6ZfB5DKAJfHppO/8IDXfRYfBvLOY2A3NFsbJm1P56PZenVSqg?=
 =?us-ascii?Q?b5ZZVyukLc94eG1WqAZqdOqgzxQG7tiSS+KyanMlduOm4Xl/QIJPdkWHHub2?=
 =?us-ascii?Q?uCmTC++nDYBYnoDPOW6lO+5abJaStm7j3l5fiE41yRuUjIDkbdPcEsZ7WblH?=
 =?us-ascii?Q?uNS1R0j2bsgM65/nlreMpAfhhSVQhvnkMU0b1s25TwF37x+NUogMPaYfr/Me?=
 =?us-ascii?Q?Zq7dgepq8QmL2HiVZtE62StvtUFos1r0GaSjcFQMGJFDf1yZ/PWiispkPTMI?=
 =?us-ascii?Q?Dt7nP6WTmiyXLt03jIw29xvtQhwen+x7vOV8VjzNSJxjZ7GOZhAMPflx/T2c?=
 =?us-ascii?Q?nTKJMB81Vx5sYCweXySW+nRgRhk2VBqAi+fmhwH/MhAIsXydmhdyJ92/Eklb?=
 =?us-ascii?Q?nv1TeCKC4c4Kos+XWODRn5l/x6+J+ttFuNf4AH5My0no1hVkAQKK4aPo4pRf?=
 =?us-ascii?Q?WrtLNlZ2GUFVOsMeW1h3loFQSm9zokRsgq58SdA5NNvnmewNbFq2dpT6WGHB?=
 =?us-ascii?Q?yW5J8AycsJ4yZlPgYmkCaqI41VKNAR8VrT/PR/MdeJ9c2WsmwVyY3HpTTWD/?=
 =?us-ascii?Q?ss9LQiZsi1QVTf7Re3RxNJsQxkhJJZyulpEXrfmXm5iF+1xt7ejH6IjVlRI7?=
 =?us-ascii?Q?XEBamg77DvJMc08YynCrccRAGRT/2T4JNv5xrXeYgRH2Yuu++OYebi3QKyCl?=
 =?us-ascii?Q?sk7ezm8owU0LozJBZczzpXUrbKdWlzsnxaVKYVMeG40ke5bWFHXIauWic3Hi?=
 =?us-ascii?Q?5GguFZfrC4P9ji1qYYa/xEdiAjnxwZJctzRz7ADBKh59aogDcXuWMZNEopOZ?=
 =?us-ascii?Q?FYmg9XQNAwcPpc0BzDOcjumn+4OT76KIeSmedt4sSyCMLg/J5azSwHEfOuoZ?=
 =?us-ascii?Q?CG0mfKfzfnIhIQd4tIvnKqdZ6GGP82YPtp+zqxbwntre3oGyndys9OUDcEJP?=
 =?us-ascii?Q?QragMZJA1KR6lQy4NsGeDCh8czZRLnEpvFpZaNOt0cvf8M4TK7OnQB522bgh?=
 =?us-ascii?Q?ofUiBruO78utRTy1qOk3S+LTfHS1yVBcw6LFSA0MNCoyhTRRz4wzKpkVHHaE?=
 =?us-ascii?Q?bvWqoPkcAEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/2slln6RQ3COtSAcVNM9ZlQ4Wj/a8KFhj8wyhM+HTP76wpgjunQaSqQ3pZ1?=
 =?us-ascii?Q?NCelXpZlnVGU2VM0SyvnzhAufe+4Va387Icoj1nrwevoicH1feTRBpKUetxC?=
 =?us-ascii?Q?pYR4pgE+GdihUHSqEtT+o2WXSeE07U30iS7jXhToKwUs3naMxNZJTh+e/m6u?=
 =?us-ascii?Q?uIuPniSQM41Zop/6JF86U14btOahfAIr6IEUl2N8D40FWwQ4Xo0Y4Akci+N7?=
 =?us-ascii?Q?GBpOPpMReCRPVj++1y2ho8IsaSCBUOPY6upL92AwX+6C4Zto12k5dG1Ak48d?=
 =?us-ascii?Q?0NaQ8r7gHm98a7hOaHvgOMxdT5dKdjX7omqhBiQHfjLLxiToDw3sHIafTYsd?=
 =?us-ascii?Q?4CnZE9gE453VlKqNXCLzz3d04HE6ZsNbBpT487G7aCXniCSzrqIS+SVAB2q2?=
 =?us-ascii?Q?EwyN8yQxApy+NAhBwanA2MQ3fPcFgJeF7PdjsBx/1fZnu7z8FQGi+HtcB1fK?=
 =?us-ascii?Q?5q0spXWqzORKIlQPdgnMa7ZqdA4R8n91iIfNZBcvXBLgp20JhIF8Vn7jSWPu?=
 =?us-ascii?Q?gDhvk0zPUl2GkiCZr21DpdkK/sWY5UGPv/ycMlqvtHiptxQZ0dRyAji6f8X0?=
 =?us-ascii?Q?tmolhaU0z/F8tYH2jIZBD2W17ntSSZaam8qh3oWqfLj42CMYw1qhWQZUfmPM?=
 =?us-ascii?Q?iepGATqvDSg1O32MwkeagWHuESwNHITAgzfc1TzDGAn2CU0k2/VSvOjcpAD4?=
 =?us-ascii?Q?LJeIYgAHrjDCY7jVURgc+HZyISKecvrP0yY5O6+tE3AGrGmBrgjlU5ruWBkS?=
 =?us-ascii?Q?vjv9ws06eSb5EnkKgzEj8ndnpwx1OtQMhLIQ8sK6aNN0EApFhXqwgK3PKhEz?=
 =?us-ascii?Q?L8lGDivRoNSHPqwIRnbjYkTyMaMar96L9BXoWGlxrNxKjioYUp2Vc4fGRHuu?=
 =?us-ascii?Q?iuhPhpqYn8Zv/PnyqP/8Zs272IsfZ8qS1dW5p/O1U66+r+SCXLhl4WChQFMn?=
 =?us-ascii?Q?35uciok+GuTJpoPmqMa6Ua2f93vajC3H9nUm97b5tCDAK6jbZkkTFdGKA76p?=
 =?us-ascii?Q?JMtYaJ1+XDWAwc1CVgl/VgOdJP+QSA3VEfL4BRm5L2Eki5Hl1Fg1DTm1ipzs?=
 =?us-ascii?Q?VP+10AtNEkv9Ru5UV+4q81gD6Scp4QO6zo5QhvAWLbDFUlTNIq5VIRP3mYsd?=
 =?us-ascii?Q?VSOAaIQ6ifet5B5P674A4wd5h3OqChdSsX1ZGxfBU6y7gxGtDoaJ+GJAmXYN?=
 =?us-ascii?Q?zWMN6VvUtkAxkMNwa1a7sFAgv7O69w1aUQ4RfJMqvwy8DyYNu8h9sPzH7TRb?=
 =?us-ascii?Q?FrdWgU8UQDCDhR50/hPgxPpcpOhPRT0kV7OrdN39Mb+MEMzhy7JQ9uKx91LH?=
 =?us-ascii?Q?B/sWQQl7QwzwWkfxgmbVizgqwiwvqyoJI5nwFsk0q8k+KWHXPnl1s180R41F?=
 =?us-ascii?Q?S3mPvbADW5txHMx1Zb+yHOK/hnQNzcOjwaespqsdI2v7EOxl66+zbymHZRoz?=
 =?us-ascii?Q?ne5RPlRAQSVYwcVSjLvtQdS97N5c9H1ZdocK4LWKWv1giMyIJwXv+7AsJGFI?=
 =?us-ascii?Q?fcjoQCZc6GL8JZXtX1INCOoXbkpgCw2kiwEQ+Ad0I26Gx4Sfntiq65OML5FR?=
 =?us-ascii?Q?0g1ATQD1DWuZsMuusbI2yGAV/xsYjI59EK6eDBIKBfmuMMLQIrCDrzQBY2he?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rnjxcdnFRdPJG2fTGc1le/LGVjzK7+fvVQFuOCgcrqX2TXlcu/TbEw63K9/osoJHuVyhQoApu+oDZUB3HI3ycsh4iXV7kNAW/kGqaZ0Tn5OlQ8dtn0uTGO6gYLoVHH/Ywtv3yoVjiGzmjDfE5Ibn2BwmPYvKUGCndWyo42F6piyeQsEJwU+DnptC2MMAv1G3QxnJfHvzhxmenBYCj0gcokFb/D321jLCRDw0VjRNr4OxbHB0DqSW59QGUn7kHyJ/nohIJHrh0cn/b7bnUDDjB6jRwpFq3rR20uwiaZmKwJ6xF/twmBi2f20/x6orrPgugEaay373dXv8s3X4u+yR0oQBAnmpWcHjqGGZCCES8D+MmWvIwD3tTOBuDYcHxT18kRoClJAjVSjI9LZwBCxgzsEsD79yAis3oOolzon4LDKeCHOtEggjcHJSBmRbsKb+H/zb1jdrCyJVCD+PPBvijdjOYh1zio879sbvrTX3uOWu/w8x+V5h71R0NAyK4446sulk7YYD3zew6FwvmHn22rOMFP/IleBCf8dWviOKGbDQExafq9JKlG6ya7Pl8ZyP6CpKtOdHR09teL4T9AwcT/v1i/AZAiK91gG2lSmgvxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f597330c-860f-42de-fcf8-08ddad0cb86c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:33:50.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhcnPg0S+6pAIkECvW2/GpO8lBue/T+iuq8ZcnRHL+r0bi9OULxxZrpOJ5hrDDu71cbyjrsseYr1EpexYsE17l5A8BNyPqvSBK047uj7zWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX2Rgr0Z/5dYBf jNRGwMND6SQ+oy/mRJXlwZAOvu9Q5X953V+TNPA+2nsWn6oE5NHOhl/rX9E8TcxGMjqyBK0tjN0 MNttM6Nl3lQCVN8X33PwABCSKnGFoTMG0GeNo38hBoizXyoSUnzsh/Bbk0rVywS/N/ntuwFZuyn
 3ZxB/FEa4gRA4U38DfD+DFN2+0CZ/6QzQECeJg51yYZ5AcdzBWqGh/WszNJs9R583OJyME0QLM/ 43zYjtsb1CzC0/TZfryYsFJtkW9gPXA8Wh5acEWgWnM2Ig/wXkxN0UAsx0VstxMPHDc5WT6iLME 6Z0C2pMFGJkrpL28ShSnkMZg/ymBk0mxWwUJv6ZqOf0jb3630YbumbXd+p7INRpKZG7LXSBPL6Q
 yuH7WAw7xDflGNjHKuf+nCktqXBUvzfkoXh8WYknPN6zTrH5kQUirRushHMB9lAvKWha7Sw6
X-Proofpoint-ORIG-GUID: HBnNABvEonuZCrnv0zNqJ9ht9kEdOGXU
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=685071a4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vxWm5UkIwlaNHXKCl8kA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: HBnNABvEonuZCrnv0zNqJ9ht9kEdOGXU

Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), the f_op->mmap() hook has been deprecated in favour of
f_op->mmap_prepare().

Additionally, commit bb666b7c2707 ("mm: add mmap_prepare() compatibility
layer for nested file systems") permits the use of the .mmap_prepare() hook
even in nested filesystems like overlayfs.

There are a number of places where we check only for f_op->mmap - this is
incorrect now mmap_prepare exists, so update all of these to use the
general helper file_has_valid_mmap_hooks().

Most notably, this updates the elf logic to allow for the ability to
execute binaries on filesystems which have the .mmap_prepare hook, but
additionally we update nested filesystems.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/backing-file.c     | 2 +-
 fs/binfmt_elf.c       | 4 ++--
 fs/binfmt_elf_fdpic.c | 2 +-
 fs/coda/file.c        | 2 +-
 fs/ecryptfs/file.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 04018679bf69..5761db9a52a9 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -333,7 +333,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	if (!file->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(file))
 		return -ENODEV;
 
 	vma_set_file(vma, file);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43363d593e5..a6750bd9392a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -646,7 +646,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	if (!elf_check_arch(interp_elf_ex) ||
 	    elf_check_fdpic(interp_elf_ex))
 		goto out;
-	if (!interpreter->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(interpreter))
 		goto out;
 
 	total_size = total_mapping_size(interp_elf_phdata,
@@ -848,7 +848,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 	if (elf_check_fdpic(elf_ex))
 		goto out;
-	if (!bprm->file->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(bprm->file))
 		goto out;
 
 	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 9133f3827f90..699bb9a65c27 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -109,7 +109,7 @@ static int is_elf(struct elfhdr *hdr, struct file *file)
 		return 0;
 	if (!elf_check_arch(hdr))
 		return 0;
-	if (!file->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(file))
 		return 0;
 	return 1;
 }
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 2e6ea9319b35..eed45a80e9bc 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -160,7 +160,7 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 	size_t count;
 	int ret;
 
-	if (!host_file->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(host_file))
 		return -ENODEV;
 
 	if (WARN_ON(coda_file != vma->vm_file))
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index ce0a3c5ed0ca..2bd50d1de5ef 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -193,7 +193,7 @@ static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma)
 	 * natively.  If FILESYSTEM_MAX_STACK_DEPTH > 2 or ecryptfs
 	 * allows recursive mounting, this will need to be extended.
 	 */
-	if (!lower_file->f_op->mmap)
+	if (!file_has_valid_mmap_hooks(lower_file))
 		return -ENODEV;
 	return generic_file_mmap(file, vma);
 }
-- 
2.49.0


