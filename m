Return-Path: <linux-fsdevel+bounces-51804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260FADB9CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7623B7267
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3C728B51E;
	Mon, 16 Jun 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VReEyvIy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApBMHSeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5A289E2D;
	Mon, 16 Jun 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102514; cv=fail; b=dPbifnJ7/nSHNY+GgQ+Ms4vxToeUUYQ1Ha1C1bZvr+c24mLvlWUsKLnKYJySYWYsdphnrGomdnUogZ9s1zA1xYQqay/NIunifOkIZlgM/CmemrsiO2FXoNZxUapUxo/5LPImcYIa3Br2bebL/BbSnqbIJzb4F8iYUn/H9xjss3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102514; c=relaxed/simple;
	bh=1fkdlkI5B07Dtz3V2UVu5qjJLHCfFG2wlXrObLLlTOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNOmEPXToCkjin8ukf9/6VLN7CFmlZJ99tMnsgfSOxeMrwonxwjAD2jQvrTjX4G0xyq6bA3+N4gv07Kn+E38XAGINEqOEOGz6eC7sLdH5s/U12rfl2NmYYp7HEGegoJ42wV+iVqmVWrpWDku2lJMJW+R3pscNm/gxs8XFbhCxYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VReEyvIy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApBMHSeW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuW2N025006;
	Mon, 16 Jun 2025 19:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xQ6It7ceP4ge2wwkA2QHQTaGh4eZZLUU0skN0ZdcGT0=; b=
	VReEyvIy5ymV+EIkjiovaZO7zbuNJwNV25YZHuNpcCUdVP/AzOn+RWkVymg/WvHW
	IVFLb3rPCS6XfV4ibCLou72GogG2RMYAasQLLAev25+oJXBZQUvX9S7wVsNTTTZv
	Q9HUWN4Ha7Pik+1/ySEtt/ysTu8NSyzCSc3IAyx7VGqLCMNqdnCmSy9otHO1Rm59
	Pe9aFnRUMugJrAz4W9EJ+1a3WOhSwb42ONUAE/Kg2Xr4ft9Fg1SD8BMhGaPh3v0w
	ms2qkATp3tbfHhl4T72p2FBEqHJ0vQAbO+0VQBi4Kurnh5jidtvLqogfckfhr3y3
	33gvLFF47Iiywna4fNd2kQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd3nua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJ6DKK025950;
	Mon, 16 Jun 2025 19:34:05 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhekuqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFnWLpGaK+1gwCNKfi4TjcF5WPYJw15ZV4W8mdPy+75ej4/Xqdu22dyLKoM4Pelz6uF5EXhYBHjK2P0+eCXnHQZA3YIrn5fXnutL1Q2BqYKKkQhHjqbnMOr9FyjjwPasdprMVV3M3YWKN1gMEZz2sd1ynkHxNQdpTmZxCyo1pvp5YJvP97bkB4mTBo96Td8GwBOTjWQ3wCxrfjgByvAhS36yU3ZEqdRvnK15GZ/mOSFsqeo9gsXGk1UDs6obwZi08FPf5u9D2wHci4trbTNJFIVTsEzahWd7bQFhk7/5IFjdTehjtVgCHpx2zgOsqRElzpO3j2Tr7ABy1sRMMvvRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ6It7ceP4ge2wwkA2QHQTaGh4eZZLUU0skN0ZdcGT0=;
 b=OKoZgmxKsOmmpkGwDOsiQAGkEDI8+op+Ovalf/QNnvsjztRrDoz80ZabLmYx/snCxhtlWAG+iyOPIRTHHPFcZuVtgZ9NdCTf7QKT0lb1Mjgpl2aY2QpyHcvODQSK/el5VA9Qd0T0sR+OF12e3AVHcfPSD8IQEF+MaMNipa9Akm5OocoiwPpm6FCoCzlF7LAfSPxoDuq/PYpRmldYDaXESW4gt0NmtNEcJgAMas8mri2ZwldlTq2OrQ2KSZq75B54AZy8faslZKp/p5kDRurC0N0UKIrzmBiugQcieTK1OzU8k51LeHev7QMFVfxuqtoiF+qmkgzFSXAt9RlW2W2Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ6It7ceP4ge2wwkA2QHQTaGh4eZZLUU0skN0ZdcGT0=;
 b=ApBMHSeW5M0MmmcTdM3vkGNoKeo14Vf/4P5MYmMz55EQMxFQyqYK+Yfv9EWR5dryQ5uUUTkhZKAusvgJZpNAUmpPq8MDgEz0Q6HPN6zFMk93e7MJY63HVbLYFaEAlQhn6BQxReEDnQ9HAKWU589Xma5UQJxmxK7hsLiBkSjKqUo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:34:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:34:00 +0000
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
Subject: [PATCH 06/10] fs/xfs: transition from deprecated .mmap hook to .mmap_prepare
Date: Mon, 16 Jun 2025 20:33:25 +0100
Message-ID: <cba8b29ba5f225df8f63f50182d5f6e0fcf94456.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: b2edee95-c9c6-4fb7-a12a-08ddad0cbe44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hguLymOY/EvWdgzmp6Ef1R06tviDnnqqhBOt/nW9dzkkZyOGyUH7+5n4RJ0?=
 =?us-ascii?Q?fIeKkVZkBidiQHCQQDV7jlZW2wqs+hKBowycdmwXmv5JGN+tj4BMQdICZjUh?=
 =?us-ascii?Q?i4SrvAGu/0IO2d98M+ytiTx1JrBTsArDr1KfS0CxTE/ww9KaCCxpM5dT5iA4?=
 =?us-ascii?Q?NLDvi36ejZ/KefL1OhQpeNm2zm3b+V23qTIeGcSrI0ki2aoj2lQI31y0MqvX?=
 =?us-ascii?Q?e8g/NLtHD/SFHzFHzWXndUw2u8Hw0FQ+AzfjEKY0BXRT1NlAvv18AtZEXkrl?=
 =?us-ascii?Q?2id92yD91NfcAP2a+a5//kJciWNB6/LUaPIagi2lJmeBddG5P+e258Pidcip?=
 =?us-ascii?Q?kZmQpnInv9KkNBrDG03d7lUoe7XkPtGVdwVf5zcsbktR9JTiugfQXcuy2GYB?=
 =?us-ascii?Q?8WdjjdUJqSyJ0BDtcMDSDf5pQ3VPNBvHy5fYxtgvxQOM/vfqQBtJfNw2m91u?=
 =?us-ascii?Q?l0s5BIVr+0ML6M1QWdbj7hhfkA9yImzU6yxmaOJ6ySVriYyCgHFtvvcwsqq/?=
 =?us-ascii?Q?EOe9abMJVynnBaM0bgHhLQXl2a645gvlXz1MjY9o8DPBheERV63y+8xHA5q6?=
 =?us-ascii?Q?vVSdz5FzblwRH8ax7xq2Y/LaCYrNzrhhI8hU6IdIy7VBQTYMDlYRP3nRSJpT?=
 =?us-ascii?Q?Rhf+qajbqvo0pOOUZLIK8dXzxR5iy4+AsGogE3lAhrOPXwfyWo5lJ6R/BTOQ?=
 =?us-ascii?Q?g4P/oMwuidkvaZkHzmSbn3zxqG6WE7TJrLjTqRqKcpReo8I3l5SaYj+jlEhQ?=
 =?us-ascii?Q?VZOFjeu9r4ZJRXRDucmolZIMMXKdxo3iC+js0eoHh7phPS5HTQOJQESu1TeF?=
 =?us-ascii?Q?oosw/0AuiubZ8FNX/krYqF4gxxLPCmoeirtBCHl/3wM4ydIAGUIdmAHQWMpI?=
 =?us-ascii?Q?qiF3+IlVE7QVdXDwaTXpKRceF9aHid2+5U02yYwLt8Xp9NfrT62CWdI6/BPt?=
 =?us-ascii?Q?vCbMx6HvE3T87P1yoWm1rYzd3Fe0YGObxcxz8FM01JWcjMV7sxoIv2V0qdHB?=
 =?us-ascii?Q?DOUSECl6OBdeWoF7PsE5/WcV49ijRyEBhR0Gb0fKhi4xySWRvGNPD4WSTcxH?=
 =?us-ascii?Q?kqAJC2te8afQEApsM8D0DUUD8KMa24m34aBo5n4CBRQaWATJAFEre7ROF/bw?=
 =?us-ascii?Q?HJN0F1od56IJR2LMlZXdgstNCuNBza8TgaMtVrOyV8z2p7lZ5OrX/1cSio1k?=
 =?us-ascii?Q?CymO8Q9pL3D+pUv9KAUW5ccZZgRwquhR6moRXqqzEO37uGlDAmIRSlnokqsc?=
 =?us-ascii?Q?8ZZnKUkAow1CBr4Se4sit1+pveAEPijHlTIPWhSmOyPQ2CNoztInL3Ezdwdo?=
 =?us-ascii?Q?fKMmTOn0UI2/ZnS6xUL5brWroYdgn930TDGNwEPgNKs+jjfzqAyOwbqtt27T?=
 =?us-ascii?Q?GWmGcwbDdo56780EJbKGPAY9bggA/fkmGIkKrmYJoFKVmDi32v7IFHw9yci1?=
 =?us-ascii?Q?pVDyf5Tv+tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d6/hj6clz674Miyb/qtgjiAlPXVtQX6PTv1eKcrp6Hye8t5ebzWWDdzjE/CG?=
 =?us-ascii?Q?eWFmAMTZcT1B0FD0nR/52bJ3A0+N9R3bbI5Znnl+DmTDLeTpYFuZgeI9DiSS?=
 =?us-ascii?Q?8rNlR/GQm2WQJW3MJDFRZP42SyuVkda9Vq3TmnZGjg0nGQ0ahzXK48JmgUos?=
 =?us-ascii?Q?lil17CR9TzxMQ2uaCU1mCe6okyV8xxyf4ofG6U3bWfbjrC6dax4YAe3N4P1A?=
 =?us-ascii?Q?8Dhk9ckn0HVILyoqpXUqmmIqUIDNcgGI6WETDQ6KUs51Tqn+6nRul/Ipu+E0?=
 =?us-ascii?Q?q7MvFQ7Piz1xUJRGRHiTTHPJEPoya8T6xc8Tob32c0DWcaOfbrp/4RZ5mCbO?=
 =?us-ascii?Q?QMe4dWYMwze+z30+Asw5fng2fqylSmsz/sFjHErCQZ/hGY7aZzva5jydihkL?=
 =?us-ascii?Q?wauvSt2dQOvKhTVVLoyV2wOOwoSD46PIZDWbJaT25m3beTnce2izbq2dhDsB?=
 =?us-ascii?Q?NyGF1jiCk4XiL0thM58xowepcqVOHGO+07NwTDHmJAh0Wg9taqfs/rjU/s7h?=
 =?us-ascii?Q?kvzLEXNP6y1lcydCfSeVySTgav1SZTtxacKjovP1uld5a9dNdu4AH02VNhXx?=
 =?us-ascii?Q?02I+s/BUSYrkG2/7wmF0hAUy5FxOHtU3r4+TJ434I0K1uqtBYuqmM9J41Y9e?=
 =?us-ascii?Q?dRGTR7wU5d80YuCHH47BrHgKwA44XC6dTnjcHFYdmLgdHwEOu5h+ACWRgoMy?=
 =?us-ascii?Q?iQZvubVhnMuzghsmhsLiBDhBffPK1vQuy4MHYMrpilpgZuljH9vCzMWzaJxb?=
 =?us-ascii?Q?QPOzXtj+MgJCCmWrXlUw86xxA2pVQzc1tYbfc0aTTHYkoKzanP5gGDZwspT7?=
 =?us-ascii?Q?xYizOcjBs3O0WRiH3bJRAIUDrYqo5oErcFpDu/fiSvS9o57hvI9Pp3rNJZ26?=
 =?us-ascii?Q?wQ/1psEk3Hly92xWd3SRFtlUvJ3yNHQo39SicDzJRDUJ1G2/dZwTXzUE/2zR?=
 =?us-ascii?Q?GpkVAtsR5bDSo1SKJG2F9Z0ydSxMZIk4spu4+bQ6wEWmZ1ai/hbnJiXWczvX?=
 =?us-ascii?Q?XD0olt6YBhEDU3QGsyY+2OwlE9QxaNoy4+GVFb2DyjajJcWFjyp68FWN9fKH?=
 =?us-ascii?Q?WqXIrZPXxsrz1Cfa3zn+xrBVF+l1UHPYtjTK+BODUOuV4hcxskhRvY7NdJPl?=
 =?us-ascii?Q?acAYEmBLNK8+juZM2t61v6ifUINeiXKnygk/U36sZn67vOdJTol1oS3XTOP1?=
 =?us-ascii?Q?/7ZTFmuYlBcsqs4BJ8ZxoLkXiea7oq11TbE8NMuKTRNFpb2gb3/gQbUu6UZF?=
 =?us-ascii?Q?KnhKsA1kK2Hu5gIr2zOAMM4/bWBXz0WAIC7g2h1QfDz4NfVObhvXuF3hAj/S?=
 =?us-ascii?Q?iPWexGxLm+qje7LVFJw9srFoA6uK5ZKdR0dije8SuqNoK3jq/HU+cZsYJz8X?=
 =?us-ascii?Q?ttPgEwW3wuMrDlJjcPn7ScSeJtrc8c0gSe5gpGQSy3LoXVBC7K3Ts1zfXTwo?=
 =?us-ascii?Q?F/bHRSR05qie0f7NZMq426ajB0QOnLie+iXVmfEy2V6HtkAUbac9/Eb0L1Mq?=
 =?us-ascii?Q?iuZCs5pK5yIt4mw9mIvwkWbu+l+7MxpGSI6Y4gP5HP0/PD3J5RUg2Kk2X1Yf?=
 =?us-ascii?Q?yti3rbeoINL6QwV/GnmwWtt3SFM4hLCynw8kH9NZeqAqqHRFwGXiEgoGSLtk?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ybPTQK679yBBkUjoVIxbPZ++XcQIekyBwcBZqvSteAtyjz0dCyYsDQc4mxzXYoTmFru90ncppXGq5tMk9etjQRadWccOtIDuV4Yu7uRY18IgzjSoVVsM4HKTGu3+in2Qy4IHLZ8JZT/kR9fru22f+PnnwY5OTS1xuuhaF1JyVWsEts9QALxYfEHj21wEME9v4GzWXIi200F7Byr6804ZWBNK0r/XytuBYr5CoyH8yrcuwwuB8H4blTSnGlg2YfbjT/mt0ichK+tyacpaYCdkdcpf/98QqykhEMbo7clKywBLoTMcMqia82NamvW+je7v4Zp+0VxZlr7+zCMGV4NkVgi4WUikMjzWV8GR4c4s7S0dzMkBDgRjShm/uODWvUeqc1GIgRNAWt9n17fYMcEDjIype2aIp5vslM3MjMaSWYh21p8cKvGokHj/M0XuJbkU9T8USh7fnETlSdKLqMik22K1A4D4JAc0nRLoD/HvTFT5m7HpUgb1WCcZ05O8PAaM4YThAM5Unu7kdqwqaOnBAPvcwu4aUfybRmdRYNzuVqopbnTcU86UIXf4YFf9PrdvH8GgcE/itP7dFKrkOLjDDw8DhJNNdkfmSLIKwhF9n8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2edee95-c9c6-4fb7-a12a-08ddad0cbe44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:34:00.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ck7ZvcvJ3VZmBI0c3TIQXbs58RUEZeYrpW6SPMLYdEzu+ceW5HOiT6aksoRLZ9TIKW+1MdoD96tt1JMqJDgJTZifT0/xbKBNhDqNyS6pqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160134
X-Proofpoint-GUID: Cbz_EhXn6LKje6H0CY9_BpiaeLKSY0JQ
X-Proofpoint-ORIG-GUID: Cbz_EhXn6LKje6H0CY9_BpiaeLKSY0JQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX0jwXq4HV2RDn kee/EpnNqdWwKesYoYTAUV8ZqA6tjhPUTQZ6MlujF6vyo+gjYQX+ofws7drV9UA5uYTiZFOeWld rv26lrppm8CeoqkfElsnuMvfnAJjKw/sBIbjVs8aw530gqm9o6RDdWeqfRIImu9RVyd++ObPn4A
 naHZdsMmIZfCC8reEQBrOTxf64+tqfEBcDD0YksGSO8IbHx2B6kddvU1/6cNHiNhSp8jHEUakGc J4jZjLgdTIgNd+SdJjSFwcGGHr0vMS+8WB8E/9N3mkNID/PS0lyYMavwgulhQtxkymgjj6H5slq pDFCscNfnkIyC6GTvIRX1T7fJyCw+KoZpiCTKlmGogGJmVPlRopQluYoGOjAFLRVtyKxtTPFljX
 d0DBFjuz/Eu9Ii6S4ZWv4BQvGo2qPi8gl6WOLaKZhFsXBfIaHVpvsYzhlN57IapDvA5HeLQO
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=685071ae b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wP1-y75VcYHVbZsH9DcA:9 cc=ntf awl=host:13207

Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), the f_op->mmap() hook has been deprecated in favour of
f_op->mmap_prepare().

This callback is invoked in the mmap() logic far earlier, so error handling
can be performed more safely without complicated and bug-prone state
unwinding required should an error arise.

This hook also avoids passing a pointer to a not-yet-correctly-established
VMA avoiding any issues with referencing this data structure.

It rather provides a pointer to the new struct vm_area_desc descriptor type
which contains all required state and allows easy setting of required
parameters without any consideration needing to be paid to locking or
reference counts.

Note that nested filesystems like overlayfs are compatible with an
.mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare()
compatibility layer for nested file systems").

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/xfs/xfs_file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ab97ce1f9087..f7b76647d675 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1913,10 +1913,10 @@ static const struct vm_operations_struct xfs_file_vm_ops = {
 };
 
 STATIC int
-xfs_file_mmap(
-	struct file		*file,
-	struct vm_area_struct	*vma)
+xfs_file_mmap_prepare(
+	struct vm_area_desc *desc)
 {
+	struct file		*file = desc->file;
 	struct inode		*inode = file_inode(file);
 	struct xfs_buftarg	*target = xfs_inode_buftarg(XFS_I(inode));
 
@@ -1924,14 +1924,14 @@ xfs_file_mmap(
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(vma->vm_flags, vma->vm_file,
+	if (!daxdev_mapping_supported(desc->vm_flags, file,
 				      target->bt_daxdev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
-	vma->vm_ops = &xfs_file_vm_ops;
+	desc->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(inode))
-		vm_flags_set(vma, VM_HUGEPAGE);
+		desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 
@@ -1946,7 +1946,7 @@ const struct file_operations xfs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
 #endif
-	.mmap		= xfs_file_mmap,
+	.mmap_prepare	= xfs_file_mmap_prepare,
 	.open		= xfs_file_open,
 	.release	= xfs_file_release,
 	.fsync		= xfs_file_fsync,
-- 
2.49.0


