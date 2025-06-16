Return-Path: <linux-fsdevel+bounces-51810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B1ADBA35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7E1704A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4328A40E;
	Mon, 16 Jun 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmuPkxf7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGXZ9WEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF128A701;
	Mon, 16 Jun 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102550; cv=fail; b=ZWbl3i9NaLxu4GuehVI5hnqNGQeaJxiCbG0wwRug2jhpXtIYCL1itDNq1FRDRornHxe+0Ax91qJou0vBurkUH5FU/L7khIH35vtt3rXkflY/T7Ij7U2HirMHXR+xtv4BOo0TTcDdbNIhauNqkj/CS8tNbDh9W0FaagAF/B6fZCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102550; c=relaxed/simple;
	bh=mv9HlMdGmiIS0WaHUt5GoZrN7HOUGaU1LJJTbuTBln0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3ie4bxrER6INvwlrGQxGwMVHAQd0eRYcaA5NZY5ly+Y4jIqVnfxSZ8Rgk6mQXhd8x4KbBPDB0sMiS/JNOPGd2dhgoKA8qiMbx770Dwu8AS8943BERUh4+I+R9XK60ie3KtqsGOzFJxvDw7IJ+P3uFx9NXp8LUT6jA5sllBh0T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmuPkxf7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGXZ9WEr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuUIg027738;
	Mon, 16 Jun 2025 19:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IECQY2DGCTYVoaZ9Nff+4F98HwRdlz3tTEhISw1398c=; b=
	FmuPkxf7MRbhA+kSOmuphCx3gV3J8RalkLVsb/8HMC611lWEWiOaDBzILxHFU+w/
	BFLRZ/V3z79uKWwdr6xk0EDv/qRNAnMWU1brIvapf1xTXhpi4g6bt1s6UeoYMGDr
	585yQL66Ydf39o854Yyl5vAbb7fxA0YI4aUf9+GwXgiCMhXpiVkamqtNuSrwmJtw
	eyc1ZQWlgae9RZRh+iEnsMmKww5EZptaK6IWZuyUOOYiWnzRhvccdCuCykbWWv3o
	AoxN9HwNU/Ibe2p3LWIk9DMUpwAFGevN1Xw4vfn/EX8+fSgXr4JBkFHyNThb/gSp
	+5hZ0gABHxZqqfFQmIT1Qw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxkphv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJ6DKU025950;
	Mon, 16 Jun 2025 19:34:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhekuqt-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFNHz4hVc4hWK/LYsTkZmb44u0X3KGuBnANHM/nu9JXIfIHTyaJtBUlox9dFDvG9g8mrYgifmGX2Jx0R6nzQ9/foERG1FbmLnICc0PeIodNvt8MQwPIJPXNhSVA/B/w3jT/oCGO+qfm93K429kHNodcQL5Xe4uTcS194sQe0xQcpVFzAUWxbCp90WVeNlrw5KTAIrk6xm/lWcIPEzH5ns5lA/nOTSDSJfGR5vihABDcuqgm6tr5YjDLTGB15jyentVjktBOvfL1RMAuPf4tksmyLAkuENPlD4fXrHPJd+f0TUu019LEQlKarUCLgOirdNzVCfGbVbVTK4KzVVVfc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IECQY2DGCTYVoaZ9Nff+4F98HwRdlz3tTEhISw1398c=;
 b=fg9FqUVK8MVqIJcW7ew7Mx0c5YvUycMfXRoa10aPVzfw4QJ/Nh3+5M/5OQ/mdDXW0qw8czyQGHq2OQRnjLk3yJA58nh9/+2Rktaeni+w1dgj9hzsM8xcBWKEVDEu5Ivy0DOoKgE+DYVUx7E1NFrX6HR6RxNQGRZSEB5KLHsQOWPivorMu5RA062tY4WELMvft+EfisqlF6NeFoQnOaQsxJRd7WOUC4cmXEXn+PEDxvBH8dKBswJXzHaa+epOfA12i8zX+ZuabCWraztdNTxPEpd40+be/C2uph4NH92ANBGMMlg5GBDQWmp+F73XrlEjSf+4rTNjXW073nZnpZBWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IECQY2DGCTYVoaZ9Nff+4F98HwRdlz3tTEhISw1398c=;
 b=yGXZ9WEr4Ss9Ckc85O6KxBjk6KhKtgLE0iIXhjw+puAhXLNG+Ypzt8IGCJVpNqYKn/PhkTy2aVplE9krQWdFgzdvurvE15QsvaydCsKzIXrCfPkOhdNtF1uIeVRmsGuP8QNjFEz6gpKCbkeJ570BpD7CHkSIDKie/6gC/e5s0hQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:34:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:34:08 +0000
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
Subject: [PATCH 09/10] fs: convert most other generic_file_*mmap() users to .mmap_prepare()
Date: Mon, 16 Jun 2025 20:33:28 +0100
Message-ID: <08db85970d89b17a995d2cffae96fb4cc462377f.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dafbc6-9a06-418d-ac38-08ddad0cc31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NVYyHVtV7zplMQuhRFg5S8eLWn4oOxoUarQEe8INlpmtkO5iEWYy7qe3yux?=
 =?us-ascii?Q?mVwfPl/SWm/Z/4PwExpX+wjplyEAwjLGvDhyP1waighE/wT0jencpdtRdeAq?=
 =?us-ascii?Q?9CaV9i1YKe5R7kvYOuB6Y2sNJ1qs1ACv3uAmM8L/wPyfUAJN1xFro42mF3vf?=
 =?us-ascii?Q?94sGlOMq3MU17OPtx7A7UpkdshufOrhcJvtyyzlWO8RkkI03JJ5wWJJMwJzS?=
 =?us-ascii?Q?M/y2E6W5/Uc4okdsGM36iHEVUqC/4JAPwdaJKVqTlFGCiorxU/BGgO5Csh+a?=
 =?us-ascii?Q?zVRcfyLr6WzlvDPKmNDBFz+zZ3AkDHRzquijcwd+IjR7Yda52LQ1i9ckxn6F?=
 =?us-ascii?Q?Dscq2MU4JOCp60YyVEr7HlQtJQmRDllruMrhtvoP1Y1R9yoyE8jbAGkSCzvy?=
 =?us-ascii?Q?zTDi57JRGKYdwpmUBTm7ePkZbFdasDYLpnM06JVCbRnOgAuoPZa7V64w1okX?=
 =?us-ascii?Q?AmSnPlTRivCbXtqmHYBf8j8xESGaH4lAi3l8xFFU1RM3FQOdu4gFAPN9Iwwa?=
 =?us-ascii?Q?FzGhpQVmDtoptso+9nvhLNspJv14yFjqQ/THg6BE0ZC7o7pmBSb4BxFdrgk6?=
 =?us-ascii?Q?qI1/RERo6Xc2PKKzMAusP6LsfhuFJt4dbIkCgF75GXmx13dh+XBZODUpik2f?=
 =?us-ascii?Q?EMHhSYL2O53rJi84tKeM/gh7RVsktRmfch8nkK5CUPSxkUlQPEez1A48Vy2B?=
 =?us-ascii?Q?vE3a1jON9vd1MuhC6EjrvMiNQaeLudEGtzapi+TD2IJtyQP60OYqCWEYWKom?=
 =?us-ascii?Q?NQ0RgoTdVh7Q0Y8S03MeOgZc4b8+yBRqQreNQCW+2MWwbmTfdVUb9exorB2H?=
 =?us-ascii?Q?BAPeiV0pSijBRA1iLH9yE/9n81ABxqE8B2qyoJyzYRW4l5qQW8n7yElF4ST+?=
 =?us-ascii?Q?R3Ju/vtzRxHQsHtdHfIhfIAloZth2/xh72inYxIfq8RlS9dWtEsSU3NJtWjp?=
 =?us-ascii?Q?WXYX4RHxUiT37YxMkkLY9gy/7JBqaNUTphnw3KamkhnLWW0ElFRB4JTOrOmt?=
 =?us-ascii?Q?oSOIFbAHKYUlQFCzFX1EVBZIlM9Xgw7Vxa8lPsc23h7ED3IwJ6eweEaNIoGg?=
 =?us-ascii?Q?oSax547QQp00GL0tymX/Mob6X80VyUCSbBQ7eQ6Ls7IehQrbQcmDtbnxXEuF?=
 =?us-ascii?Q?pjVs3tMk7lX4OBkP3nyy+pTh+BhhMUM1zH/nf9kvGC421733HQFqb23VB7Pg?=
 =?us-ascii?Q?fbpM/megUpARo6C01U7EdBlLp5zELe0J4MEd6end013MhOnfCJbBk0iNsh+T?=
 =?us-ascii?Q?paTS21hgWCxs3GG/kiJzNoq2TBCqS0qoNul6pdfsyacfGWRDVDmheDI/hmaK?=
 =?us-ascii?Q?Yder5jg/U+zcWYFkREXdQVCzM8s0++AJbTmvaC13bNfYD7FsriXkfZVzfjlb?=
 =?us-ascii?Q?abDy4uWuLjzG0DAbJAYRotod86aoHb6i4T3EiC5jUgDwsakTHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mjq+u95rqadhOgov6GggnrIs71hRIu3SxShCnnVNI4R56Mm9CJVSTn7Ie4T+?=
 =?us-ascii?Q?Yo8CdH64MeYTDAplgwdWtmgPLZ/c8RjUvheErv1GpFOryp/5F8yaGxXmvaJW?=
 =?us-ascii?Q?6zaADoDaaYlZ8bRNxf2lrzavbbivHUZURAI/YRYTdVvsr+qRy1mwizcLFWl3?=
 =?us-ascii?Q?sQ0HPubD8Zva7nOJiJEUaOFDZSbgvxtxHIqYVKzFqE+pVhY3RQ7Zhx+XPaJs?=
 =?us-ascii?Q?Xk6fjVgt7Aj/CJSNkvTDHqPI7crkvdEDRoDfMneUMD9dsRMISEt7rPtZpOLX?=
 =?us-ascii?Q?e1WsfPXMuYAvvRT8bWqa88fBIfj/UUoEGBEzDj/OTuw22BEqnKd1L36QcpXc?=
 =?us-ascii?Q?hPn1gl3zVWVOfLdSYS37e5ffkgJK5laCKgpqFzvTM3ZtV4XNJN1LQeAFF6B9?=
 =?us-ascii?Q?a1G5EKOuodKBCly/6BkYWoxpbdZ1iKI6hH/YH7ZCqji9GtIyj1VXm0LIsd4y?=
 =?us-ascii?Q?A5NMzMee84wZnWNFu0e4ZnWuxfzDzwesDVTQM+PJqKBXIPbW+bp3H9CXvtSo?=
 =?us-ascii?Q?ArbbYCNcVuVfBDBIH9J9lsnTniLUQdrNydtlGkNqilceQ2pzXL2jjymGkZVr?=
 =?us-ascii?Q?wjWUmBh65A+R2rJ1I8hMNvdhri1zEI5VNh1ucQXzv7rZxaazp88ZJYef9Bz4?=
 =?us-ascii?Q?UZuA7wjbzwzAzUQaISvaN7kMcX4NPb8x3nA8xVqRsZqfHRm9wiadX5wasqa1?=
 =?us-ascii?Q?ke2oKwifn/UEgsivdMFW5HUPqXxyPVVSvT8V5c12/rs3no34Ua64t1hDlHYV?=
 =?us-ascii?Q?cF184IADJl1iaRioSo9aWsb4vaRfV7CDsRidqjwUgs1y8BNrQSmaySED/Ojy?=
 =?us-ascii?Q?odL/dgq7gnr+rWc/uc096PcHDXVxiI4b9bgZnY6JL2JbrF0ARr/d2VPW5b40?=
 =?us-ascii?Q?CiVQKmZYjVdbDTZAOIs8pcIa/BAfSuQ/gMjBUluhU9uSBZAaHUyQCipfCo7n?=
 =?us-ascii?Q?xG3B6zjrkTK+Un6yD98Blkvu/svaI1kwrC3UiPa3Fyxak2p4roEuUSthi1mI?=
 =?us-ascii?Q?iK2iNMrJha8LUqf8RDgfDWHRNGG31lhrd1S3UldnN7mTHCgpFxe2NJ0GDSnc?=
 =?us-ascii?Q?nHREmxHy+nH3CgJ7AQ7NF8pg2XrXpDLV1axJKnB7nYuwnLzq1WEc8gtrgxNC?=
 =?us-ascii?Q?KKxbJ1Jlt1d8JMY183bonxGbdqDGr0LoWZkBwLM5BOLXUVderKnz/37mhXaL?=
 =?us-ascii?Q?yDZbrjpvLf9FDpR+ol3EZnjGuQ2ClLOAAt1//wzGGTLRBS7WPjACEn/Sf7ad?=
 =?us-ascii?Q?6tDUozUZJHncNyaRvyWvt2K5EQD99A0fLtmLK5xmZbGj0udEXhI/lDF+f6Au?=
 =?us-ascii?Q?1+p5IRi8X+IYtRBJ5wNCapZsJkGDAXLjoyPRYD4CwhjvD7Cnxjpve2OWSf92?=
 =?us-ascii?Q?ctWn8CF5XOm+8RlcSTgvb41f/Yqt8uOy8dNgkxTfizGV3+Ct2aF+Q05P3JO/?=
 =?us-ascii?Q?QjagO8WNNF0J3cLU7hlpzyqlJ4326n5Dl6QoJ5upAtLm41AIwiAbl5F26ptQ?=
 =?us-ascii?Q?Oku+FtJkJnRo3CS7YNiRYGp/GLjiqI3CgsjI3Cps1Vh2+t/qKbxHXxWtRCzg?=
 =?us-ascii?Q?p5kgLUTDdER5WD2G5BA7qtk93uNLIuzqS8Np80GtE0CXXdb9fmpP7CR0A+1C?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	82mOfjkYTvy5HizBZmNFzEI4RuVpwM50UiiOm+nAr1f1UFDUxTdLAAOhMmB+EUpsI3oIJrRb3OqDPBdOKbZwB+Op2eYRH2+5t540O9YVQ1VZwunN6cUWHrtgGGKDZUVCDnxPw71xgTA6vRbW4tb4oF4ulI9j/xYVrif+tLPmyjS9ttKRGMTv8CdeC/PgeDCKDgKOyzIvCYYGJeAbB3c9CydFKCuG4Yfy8IBtHIqCVbYBSoQ7DKaP/zg282PIlpBvcwqjCuJpo1vfeXZpnfrE9wMGwv2abtMXsjFiGFeU0/SHz+w60QsGxwVR1xa53P639Ib93EE/5E5vA4pw4Q5x0Qj8vYSQe7QqdJpUU6sjyYQFeZ5IDOz7sct/xt0mEJvKsWxhv7xsKI6h55Iqy7NFJ9R1O0jY1yEjEv1Tqz36DZUYYfIW9sr3p2+MNAzj32Lt5mNmAx188HGEPzSNmsA6LBVyeZYktAxtn5UfFoXfMDo8r80HG4STP+JLJxSj29WS7EnIVe+ngcn0inJsTPNkLOHslBc0B19/0aiulwOJQ2eGITgutg/ljhvxHBU45JiYR6ndVSNCIc2rEH/oGIvuZs4eq4jbZIhBu9nYmrKs/wE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dafbc6-9a06-418d-ac38-08ddad0cc31d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:34:08.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQGRITd8FcWc10crX1cu8sa7JgaQWQhoCdLpjtXvmcOGQtJe2ZfoO1HaM93jtfTKfSwP8R+CcYb30akpLzgc00slGF43CsJcAQnogfG2IxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX3cTWZhKpICXx hL2ag2fl3V/g/qFaBYyNBGw5Dh8oh7am4mkh7YjzBpNjj+wVmi/E0JtBSFdzq3ILnglxiQgUVpc LwCoSrAy7puJbh05D8+C2XGipgZb7eYfh4CjHZJZ+/ptLLff8cg73NJJGxjYWPHZi7vcDFiG6Z9
 vSge0zB/eWM1L00e2igIINLVGmc++H9r5X9LMJw6K51zHyGPcXSeXnvkRkf7mIDHBYrJ/quSA9q 9vhEN6055BB/fowv1hTUwjqfVgqKLkaAy7ohxjfVkyG51BEOmz62xVz5/VuzL2N8tupyEzT/bn9 iDkPWDZs0OPz0V0nnwZahRoSoa0lXrzRI+vG8QjYTgHiDQbMU5UQy5eBczSMSA49cLg4QgXe+Xh
 mrMV5PlCW5tdidCWK7oL6Qv+fdJYPtpDrKGGBGFUtuiJZSt80TXoJsetgf2EHRCzp8ORRBp6
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=685071b6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=N9YiVZMDQbCJ4-uU5HYA:9 cc=ntf awl=host:13207
X-Proofpoint-GUID: EaLg0opReeHb2dMyNsucYR11HoLWfoWp
X-Proofpoint-ORIG-GUID: EaLg0opReeHb2dMyNsucYR11HoLWfoWp

Update nearly all generic_file_mmap() and generic_file_readonly_mmap()
callers to use generic_file_mmap_prepare() and
generic_file_readonly_mmap_prepare() respectively.

We update blkdev, 9p, afs, erofs, ext2, nfs, ntfs3, smb, ubifs and vboxsf
file systems this way.

Remaining users we cannot yet update are ecryptfs, fuse and cramfs. The
former two are nested file systems that must support any underlying file
ssytem, and cramfs inserts a mixed mapping which currently requires a VMA.

Once all file systems have been converted to mmap_prepare(), we can then
update nested file systems.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 block/fops.c           |  9 +++++----
 fs/9p/vfs_file.c       | 11 ++++++-----
 fs/afs/file.c          | 11 ++++++-----
 fs/erofs/data.c        | 16 +++++++++-------
 fs/ext2/file.c         | 12 +++++++-----
 fs/nfs/file.c          | 13 +++++++------
 fs/nfs/internal.h      |  2 +-
 fs/nfs/nfs4file.c      |  2 +-
 fs/ntfs3/file.c        | 15 ++++++++-------
 fs/smb/client/cifsfs.c | 12 ++++++------
 fs/smb/client/cifsfs.h |  4 ++--
 fs/smb/client/file.c   | 14 ++++++++------
 fs/ubifs/file.c        |  8 ++++----
 fs/vboxsf/file.c       |  8 ++++----
 14 files changed, 74 insertions(+), 63 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..5a0ebc81e489 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -911,14 +911,15 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	return error;
 }
 
-static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
+static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *bd_inode = bdev_file_inode(file);
 
 	if (bdev_read_only(I_BDEV(bd_inode)))
-		return generic_file_readonly_mmap(file, vma);
+		return generic_file_readonly_mmap_prepare(desc);
 
-	return generic_file_mmap(file, vma);
+	return generic_file_mmap_prepare(desc);
 }
 
 const struct file_operations def_blk_fops = {
@@ -928,7 +929,7 @@ const struct file_operations def_blk_fops = {
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
 	.iopoll		= iocb_bio_iopoll,
-	.mmap		= blkdev_mmap,
+	.mmap_prepare	= blkdev_mmap_prepare,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 2ff3e0ac7266..eb0b083da269 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -454,9 +454,10 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
 }
 
 static int
-v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
+v9fs_file_mmap_prepare(struct vm_area_desc *desc)
 {
 	int retval;
+	struct file *filp = desc->file;
 	struct inode *inode = file_inode(filp);
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
@@ -464,12 +465,12 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
-		return generic_file_readonly_mmap(filp, vma);
+		return generic_file_readonly_mmap_prepare(desc);
 	}
 
-	retval = generic_file_mmap(filp, vma);
+	retval = generic_file_mmap_prepare(desc);
 	if (!retval)
-		vma->vm_ops = &v9fs_mmap_file_vm_ops;
+		desc->vm_ops = &v9fs_mmap_file_vm_ops;
 
 	return retval;
 }
@@ -531,7 +532,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
-	.mmap = v9fs_file_mmap,
+	.mmap_prepare = v9fs_file_mmap_prepare,
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
diff --git a/fs/afs/file.c b/fs/afs/file.c
index fc15497608c6..aa899292979b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,7 +19,7 @@
 #include <trace/events/netfs.h>
 #include "internal.h"
 
-static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
+static int afs_file_mmap_prepare(struct vm_area_desc *desc);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
@@ -35,7 +35,7 @@ const struct file_operations afs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= afs_file_read_iter,
 	.write_iter	= netfs_file_write_iter,
-	.mmap		= afs_file_mmap,
+	.mmap_prepare	= afs_file_mmap_prepare,
 	.splice_read	= afs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fsync		= afs_fsync,
@@ -492,16 +492,17 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
 /*
  * Handle setting up a memory mapping on an AFS file.
  */
-static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int afs_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
 	afs_add_open_mmap(vnode);
 
-	ret = generic_file_mmap(file, vma);
+	ret = generic_file_mmap_prepare(desc);
 	if (ret == 0)
-		vma->vm_ops = &afs_vm_ops;
+		desc->vm_ops = &afs_vm_ops;
 	else
 		afs_drop_open_mmap(vnode);
 	return ret;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..52dfd1a44c43 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -409,20 +409,22 @@ static const struct vm_operations_struct erofs_dax_vm_ops = {
 	.huge_fault	= erofs_dax_huge_fault,
 };
 
-static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
+
 	if (!IS_DAX(file_inode(file)))
-		return generic_file_readonly_mmap(file, vma);
+		return generic_file_readonly_mmap_prepare(desc);
 
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
 		return -EINVAL;
 
-	vma->vm_ops = &erofs_dax_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE);
+	desc->vm_ops = &erofs_dax_vm_ops;
+	desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 #else
-#define erofs_file_mmap	generic_file_readonly_mmap
+#define erofs_file_mmap_prepare	generic_file_readonly_mmap_prepare
 #endif
 
 static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
@@ -452,7 +454,7 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
 const struct file_operations erofs_file_fops = {
 	.llseek		= erofs_file_llseek,
 	.read_iter	= erofs_file_read_iter,
-	.mmap		= erofs_file_mmap,
+	.mmap_prepare	= erofs_file_mmap_prepare,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 10b061ac5bc0..76bddce462fc 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -122,17 +122,19 @@ static const struct vm_operations_struct ext2_dax_vm_ops = {
 	.pfn_mkwrite	= ext2_dax_fault,
 };
 
-static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ext2_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
+
 	if (!IS_DAX(file_inode(file)))
-		return generic_file_mmap(file, vma);
+		return generic_file_mmap_prepare(desc);
 
 	file_accessed(file);
-	vma->vm_ops = &ext2_dax_vm_ops;
+	desc->vm_ops = &ext2_dax_vm_ops;
 	return 0;
 }
 #else
-#define ext2_file_mmap	generic_file_mmap
+#define ext2_file_mmap_prepare	generic_file_mmap_prepare
 #endif
 
 /*
@@ -316,7 +318,7 @@ const struct file_operations ext2_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ext2_compat_ioctl,
 #endif
-	.mmap		= ext2_file_mmap,
+	.mmap_prepare	= ext2_file_mmap_prepare,
 	.open		= ext2_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_fsync,
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 033feeab8c34..b51b75cf981d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -207,24 +207,25 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe
 EXPORT_SYMBOL_GPL(nfs_file_splice_read);
 
 int
-nfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+nfs_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	int	status;
 
 	dprintk("NFS: mmap(%pD2)\n", file);
 
-	/* Note: generic_file_mmap() returns ENOSYS on nommu systems
+	/* Note: generic_file_mmap_prepare() returns ENOSYS on nommu systems
 	 *       so we call that before revalidating the mapping
 	 */
-	status = generic_file_mmap(file, vma);
+	status = generic_file_mmap_prepare(desc);
 	if (!status) {
-		vma->vm_ops = &nfs_file_vm_ops;
+		desc->vm_ops = &nfs_file_vm_ops;
 		status = nfs_revalidate_mapping(inode, file->f_mapping);
 	}
 	return status;
 }
-EXPORT_SYMBOL_GPL(nfs_file_mmap);
+EXPORT_SYMBOL_GPL(nfs_file_mmap_prepare);
 
 /*
  * Flush any dirty pages for this process, and check for write errors.
@@ -899,7 +900,7 @@ const struct file_operations nfs_file_operations = {
 	.llseek		= nfs_file_llseek,
 	.read_iter	= nfs_file_read,
 	.write_iter	= nfs_file_write,
-	.mmap		= nfs_file_mmap,
+	.mmap_prepare	= nfs_file_mmap_prepare,
 	.open		= nfs_file_open,
 	.flush		= nfs_file_flush,
 	.release	= nfs_file_release,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..26551ff09a52 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -432,7 +432,7 @@ loff_t nfs_file_llseek(struct file *, loff_t, int);
 ssize_t nfs_file_read(struct kiocb *, struct iov_iter *);
 ssize_t nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
 			     size_t len, unsigned int flags);
-int nfs_file_mmap(struct file *, struct vm_area_struct *);
+int nfs_file_mmap_prepare(struct vm_area_desc *);
 ssize_t nfs_file_write(struct kiocb *, struct iov_iter *);
 int nfs_file_release(struct inode *, struct file *);
 int nfs_lock(struct file *, int, struct file_lock *);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 5e9d66f3466c..5c749b6117bb 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -456,7 +456,7 @@ static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 const struct file_operations nfs4_file_operations = {
 	.read_iter	= nfs_file_read,
 	.write_iter	= nfs_file_write,
-	.mmap		= nfs_file_mmap,
+	.mmap_prepare	= nfs_file_mmap_prepare,
 	.open		= nfs4_file_open,
 	.flush		= nfs4_file_flush,
 	.release	= nfs_file_release,
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1e99a35691cd..7f2ec1c7106c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -261,14 +261,15 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 }
 
 /*
- * ntfs_file_mmap - file_operations::mmap
+ * ntfs_file_mmap_prepare - file_operations::mmap_prepare
  */
-static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
-	u64 from = ((u64)vma->vm_pgoff << PAGE_SHIFT);
-	bool rw = vma->vm_flags & VM_WRITE;
+	u64 from = ((u64)desc->pgoff << PAGE_SHIFT);
+	bool rw = desc->vm_flags & VM_WRITE;
 	int err;
 
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
@@ -291,7 +292,7 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (rw) {
 		u64 to = min_t(loff_t, i_size_read(inode),
-			       from + vma->vm_end - vma->vm_start);
+			       from + desc->end - desc->start);
 
 		if (is_sparsed(ni)) {
 			/* Allocate clusters for rw map. */
@@ -319,7 +320,7 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 	}
 
-	err = generic_file_mmap(file, vma);
+	err = generic_file_mmap_prepare(desc);
 out:
 	return err;
 }
@@ -1331,7 +1332,7 @@ const struct file_operations ntfs_file_operations = {
 #endif
 	.splice_read	= ntfs_file_splice_read,
 	.splice_write	= ntfs_file_splice_write,
-	.mmap		= ntfs_file_mmap,
+	.mmap_prepare	= ntfs_file_mmap_prepare,
 	.open		= ntfs_file_open,
 	.fsync		= generic_file_fsync,
 	.fallocate	= ntfs_fallocate,
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0a5266ecfd15..d1e6b5cf7d99 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1525,7 +1525,7 @@ const struct file_operations cifs_file_ops = {
 	.flock = cifs_flock,
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
-	.mmap  = cifs_file_mmap,
+	.mmap_prepare = cifs_file_mmap_prepare,
 	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
@@ -1545,7 +1545,7 @@ const struct file_operations cifs_file_strict_ops = {
 	.flock = cifs_flock,
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
-	.mmap = cifs_file_strict_mmap,
+	.mmap_prepare = cifs_file_strict_mmap_prepare,
 	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
@@ -1565,7 +1565,7 @@ const struct file_operations cifs_file_direct_ops = {
 	.flock = cifs_flock,
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
-	.mmap = cifs_file_mmap,
+	.mmap_prepare = cifs_file_mmap_prepare,
 	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
@@ -1583,7 +1583,7 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.release = cifs_close,
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
-	.mmap  = cifs_file_mmap,
+	.mmap_prepare = cifs_file_mmap_prepare,
 	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
@@ -1601,7 +1601,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.release = cifs_close,
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
-	.mmap = cifs_file_strict_mmap,
+	.mmap_prepare = cifs_file_strict_mmap_prepare,
 	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
@@ -1619,7 +1619,7 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 	.release = cifs_close,
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
-	.mmap = cifs_file_mmap,
+	.mmap_prepare = cifs_file_mmap_prepare,
 	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index b9ec9fe16a98..487f39cff77e 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -103,8 +103,8 @@ extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
 extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
 extern int cifs_flush(struct file *, fl_owner_t id);
-extern int cifs_file_mmap(struct file *file, struct vm_area_struct *vma);
-extern int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma);
+int cifs_file_mmap_prepare(struct vm_area_desc *desc);
+int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9835672267d2..2ed5173cfa73 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2995,8 +2995,9 @@ static const struct vm_operations_struct cifs_file_vm_ops = {
 	.page_mkwrite = cifs_page_mkwrite,
 };
 
-int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
+int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	int xid, rc = 0;
 	struct inode *inode = file_inode(file);
 
@@ -3005,16 +3006,17 @@ int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!CIFS_CACHE_READ(CIFS_I(inode)))
 		rc = cifs_zap_mapping(inode);
 	if (!rc)
-		rc = generic_file_mmap(file, vma);
+		rc = generic_file_mmap_prepare(desc);
 	if (!rc)
-		vma->vm_ops = &cifs_file_vm_ops;
+		desc->vm_ops = &cifs_file_vm_ops;
 
 	free_xid(xid);
 	return rc;
 }
 
-int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
+int cifs_file_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	int rc, xid;
 
 	xid = get_xid();
@@ -3024,9 +3026,9 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		cifs_dbg(FYI, "Validation prior to mmap failed, error=%d\n",
 			 rc);
 	if (!rc)
-		rc = generic_file_mmap(file, vma);
+		rc = generic_file_mmap_prepare(desc);
 	if (!rc)
-		vma->vm_ops = &cifs_file_vm_ops;
+		desc->vm_ops = &cifs_file_vm_ops;
 
 	free_xid(xid);
 	return rc;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index bf311c38d9a8..9dcb69fbf5c2 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1579,17 +1579,17 @@ static const struct vm_operations_struct ubifs_file_vm_ops = {
 	.page_mkwrite = ubifs_vm_page_mkwrite,
 };
 
-static int ubifs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ubifs_file_mmap_prepare(struct vm_area_desc *desc)
 {
 	int err;
 
-	err = generic_file_mmap(file, vma);
+	err = generic_file_mmap_prepare(desc);
 	if (err)
 		return err;
 	vma->vm_ops = &ubifs_file_vm_ops;
 
 	if (IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
-		file_accessed(file);
+		file_accessed(desc->file);
 
 	return 0;
 }
@@ -1652,7 +1652,7 @@ const struct file_operations ubifs_file_operations = {
 	.llseek         = generic_file_llseek,
 	.read_iter      = generic_file_read_iter,
 	.write_iter     = ubifs_write_iter,
-	.mmap           = ubifs_file_mmap,
+	.mmap_prepare   = ubifs_file_mmap_prepare,
 	.fsync          = ubifs_fsync,
 	.unlocked_ioctl = ubifs_ioctl,
 	.splice_read	= filemap_splice_read,
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index b492794f8e9a..82afb9430033 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -165,13 +165,13 @@ static const struct vm_operations_struct vboxsf_file_vm_ops = {
 	.map_pages	= filemap_map_pages,
 };
 
-static int vboxsf_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int vboxsf_file_mmap_prepare(struct vm_area_desc *desc)
 {
 	int err;
 
-	err = generic_file_mmap(file, vma);
+	err = generic_file_mmap_prepare(desc);
 	if (!err)
-		vma->vm_ops = &vboxsf_file_vm_ops;
+		desc->vm_ops = &vboxsf_file_vm_ops;
 
 	return err;
 }
@@ -213,7 +213,7 @@ const struct file_operations vboxsf_reg_fops = {
 	.llseek = generic_file_llseek,
 	.read_iter = generic_file_read_iter,
 	.write_iter = generic_file_write_iter,
-	.mmap = vboxsf_file_mmap,
+	.mmap_prepare = vboxsf_file_mmap_prepare,
 	.open = vboxsf_file_open,
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
-- 
2.49.0


