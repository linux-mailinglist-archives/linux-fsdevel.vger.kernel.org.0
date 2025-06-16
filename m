Return-Path: <linux-fsdevel+bounces-51805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663AADB9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74831749DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5428A1C8;
	Mon, 16 Jun 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGmsKDvZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ddLFupNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D228B7E0;
	Mon, 16 Jun 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102518; cv=fail; b=MADm3PfGJneXg1iUW1M4c+/zjH1BjVVGO5pSIGvYSK6mX30IBxTN9R4RC5xlL3sLRjUy09Ts8BQ7sQXwGOJwQhi2lyNY6U4UHrSqOjJq0/5OgiNnYWtQABdYQBXAIqe/6FTIOyIK6wANu/AwB+qfnE34Tsmleq5BmorvomMtTPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102518; c=relaxed/simple;
	bh=b10t3txl1cVOgMDpZ/F8r8b8TdZuk5fXEIxJ/7zuHec=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y76CjC+flCRab3Vq1/BAIoCNCYaxrAYFxN+BCf6gT1zo6uGHZIR8TesP6GMmlB8DO2Uc8YG8e8p278zVp7rrNPd7nDaLZXdOqp4zY6JRjPEb129k0/s5ZY79LHj5XflTCsPUz1zTrI72LzCeTDXhwZc6+mrBvdgzcJyn6svZwYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGmsKDvZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ddLFupNW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuTaW030535;
	Mon, 16 Jun 2025 19:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=XEG2SkBKEOX1HBmA
	k4ZLq2DCpXTIWzGk0B7pQ7f1axQ=; b=DGmsKDvZ/iMVxMZwzBXARl7IiD6xsmHx
	esNps7pJOXSsuAKNOYGDali04IoIU7CUnlfaCv2J724oaKu0tuY9Ey0OWasE+fr+
	o1Fb1GTC2NKWOsBBXBAzr8k5yuHYF58te6uRGIj0fiq2E+pzStm3sxiWKvNNtY5N
	22Uvwp3dhm0WANRJ/xcOzMALUTMJJ39NXBDrz4ygsSffqqTAFIIl0egzdVszcPW2
	bo+Uu6fPccSAUgZrJJM1WneCbN6lWnVz7G2XamyNBtJ/pre/d8ft73+cYH+3Xnut
	a53CMGeccCb4oTlI6rL0v2tCNdPRZ6JHWDglhe8ZcWEWW6zKB28vpA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r2s5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJAKnT001648;
	Mon, 16 Jun 2025 19:33:47 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8bqb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma0VjrbYLfajL6YRtaNQZZrwyCSi9QATL906f58ErzpPo9t22QGZJrV9UThb+dzygD4NquVF0duSOk13wsb1L2cd7E343xU9sLsoEryd07Zz9xd7Uq/OLLa0vZW0Wf9YD3ynZaS06MVYNvMqYG/6P2WN6JjTI3RJU2tAG0Dl6x0bXRhOH1kXd5Q7PcQuqMXycVoZGyy+f6h/vcCDUwRy9jZU5k26iv2Gjju7BRKCfOqPUlEtMzg7Bh2aqCXkTovcbsaU4yHcnQRCj5MV9RkwhrMpGR4JCI9TzyLaQA6+knar6YkoW5xLjfnYXjDBbPIPNynEma18F8/ovmfMHj9T1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEG2SkBKEOX1HBmAk4ZLq2DCpXTIWzGk0B7pQ7f1axQ=;
 b=XKHr4MV2mHF5K0HisH3b1zO5gcCPal4BWbFkGNbZAGLKbbDzXUr0O678oIZBHAaCIfeOp2xei6h/VYWvPkW1itUhL6xXuJ4rXBNWGBXFo42qMdx6Q4yKELLiQEsKuQl+NPKs0Hd3g3YCMd7AjMppRbsFVBWLlYbeqzg/tmAOIZO4RZYyJHJtrPWHy02HPQ9tIbr2LKA5+bEgHlJRWqnSr+ib+JvYNcSSlomGGChnSW9SiqMdD/spNeP1Y4PPnMTALfzkXP6l/GcrWv4HRwf0OO/Vk4Yye5plMIRXkP0zlJQZPjE4Chc0NZ/8FJF69maBuZZ6rxIhGFu2YAtachx+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEG2SkBKEOX1HBmAk4ZLq2DCpXTIWzGk0B7pQ7f1axQ=;
 b=ddLFupNW1R2FHghft0yO2iAS+pXvwoUU/A5nRu0pAWa5Ro/kz56oN5QCnfWYy9MJRcnL9/Mx714FdeNFcbg+kK6mmGIUCB09gmylzte93/Y7TEyBJPgaduYy/bnVx1BDo+oIaCGf0rb4qbNVkBdaaugewL8l4SJuHM5zgF7Xgxg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 19:33:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:33:40 +0000
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
Subject: [PATCH 00/10] convert the majority of file systems to mmap_prepare
Date: Mon, 16 Jun 2025 20:33:19 +0100
Message-ID: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO2P289CA0012.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:6::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c93f15-6041-4a47-0306-08ddad0cb293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8p7urz/ZBpTpt6gbvYpDaVO2vIEsL6X/YDdz57ufpivaIoKF/TuXID8gPC/?=
 =?us-ascii?Q?n+qd7pr3NXLGY5G3uUz6VQzBATHzN7BhOwrRJMF2T2vka1uku83/2clxxrVy?=
 =?us-ascii?Q?bROovRnbk7XSRl22Fyv+Kr+L4vrWZvxiLd/9/vaN3Nh073GBmQ4/QyaVsFa9?=
 =?us-ascii?Q?MruW0vfdLIQT+8FyHgrTk0l4uu95LMCzmrlqU3+7ILY9VFVRLPBK8kXkAt52?=
 =?us-ascii?Q?Viz+cK9SRriXWvIJPrBMShfr13FwVRLt/DKoz5eyeAL4PGh6YkbaxC2u2aQV?=
 =?us-ascii?Q?U7qfEL7YE3p4pRXIXTywKYiF9WnFTDR0RnA/EayUH1heU8YI5uYZMQfz3NzB?=
 =?us-ascii?Q?GQ/7UZNnxqUAxOePJ7JsUcCGChSruKR7NnU5dOtz9rceYpPgDvyl3HM6yor5?=
 =?us-ascii?Q?RNdkqmRQYwPBcc5j+JksBGtFgBTVU5vzFuPZGr1GiMx4kaQm+/znH3MVfAgr?=
 =?us-ascii?Q?zUJ31mo3Y6xvW+YzS/XkvECTQIZDFC/g5FntZ6AUIkkhcJDYmtWWp/3UcYXE?=
 =?us-ascii?Q?FPK2JdGRZP0/ACd+LSxYp0wvt2ppsf/awvfrQJ5FI4TCxni5WwS6TvyfKOGC?=
 =?us-ascii?Q?LCVh2LUWuG//4vQ1z9qPZwr7a7Xpp3PnSDydBG29feYZHiM7W9ffTUetdzVM?=
 =?us-ascii?Q?WijDW92Z1I2vpjR4OO86dKONnOLR35U9vVH4DLNuuCL2tjBl+YAJ3siRswXO?=
 =?us-ascii?Q?NMlh/FMBbD44luUFyd/ONTBSVadltfZHu8yZTudfhTyfZQrdSFnISU68AGog?=
 =?us-ascii?Q?Ty9/tZ1xFEpbgUFgVgPmByHE/UU7MK7a4fCJ1mujQBMLMk+kBsS0kOl08JNy?=
 =?us-ascii?Q?g611PZZeqG7gpTfdvluK+CBWSlleek10f+RYYuiFUOq3aAGqyyZkue0vtcfU?=
 =?us-ascii?Q?M259pBsc+hZT19RRR+f4HNndS0bpQnm+AOTAXs2xyhwLpr8LqQ6fUzDyJi0Z?=
 =?us-ascii?Q?oG86FWQrvIzTasYWC4hJ8Ptl3vOmwTkjkCkM6oSIeZriiWb+uygsJEFGRUH6?=
 =?us-ascii?Q?xC9WuhbP8Q9FhCFW6Z+1MTrYx1Qo4VXA8W+PJmVkdvIGUfKEabvC79l1JVlz?=
 =?us-ascii?Q?5g3xe4rgJSlTIr5wpuxszosCW8q10c0FLq5LZulv8YKnAQorCe9FJxFaglHA?=
 =?us-ascii?Q?Jy3XmF31zEfiD9unrv+1K3V2JqU8fE1dbPbUkXLsNcFWbY6nRCcDbGmNvYxE?=
 =?us-ascii?Q?lRQW4oP5G7bUCG736yRrkTA1Zez0WJ8aQnNBoCvQqD5jrcuxM0H1G94PnUXd?=
 =?us-ascii?Q?z8CYNXEwGcqgX3J+cKm6y0HuZQPjDWMvtiNCWtGqAFCdwdZY5d2eqCDgtJLg?=
 =?us-ascii?Q?i0Nb5xD2CCSQ38RyxFpOHrLzq0PGe1zAGb3XM9igcnrTxEye0UFw+zzEZH7a?=
 =?us-ascii?Q?JYV4ugmuV7qZaDhqh8K55qWFaJi9Lg3s6oXP0CMTWMVxUKpPuCshrM3D7yXZ?=
 =?us-ascii?Q?emq2+O/FSoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XmV+nIFap7kAWlW2CsduKHT7tMmAgGqqxesBMLPREU4fZcQPC9IEvtS9PctR?=
 =?us-ascii?Q?6L0Hh25XihZ+qcX3nAFejpIrda34C5XkoVW0sdYfK4GUN4oQiIgVVoYZL6AA?=
 =?us-ascii?Q?JHBfEcNacHurl4mdrAyXbrGi0U7PRW5FZNhniQjmCLvv/p7FJkc3QXqAZJyQ?=
 =?us-ascii?Q?UrWh7AQcgayVs+1UDMGAw5A7SYxc8uf4Vu0gRlZ5tB5BZJQOAINj14TUri12?=
 =?us-ascii?Q?rZr0JplF9WzCtKrT7tRrLiHwFRBnLLYpflJsnVyyd5o3WMbWaIZdJa+KcTmb?=
 =?us-ascii?Q?HPSS4K4BaK18+44SfWNJ7UEVczj2z+Ayvfs+8ZiO83Zap0W4lEYmFOmIZLNb?=
 =?us-ascii?Q?LUt/FINe7wMckBMeel/4NzvN5P++2cIZ4DKfc/8qDshbDLnL4o+dDF2UM6gg?=
 =?us-ascii?Q?qVWu0+4DFapRd2m7Fa1O8qJQAtEk5sXAvfgG5pSBWUkeQUe6sU/Ntr7s5J+1?=
 =?us-ascii?Q?tB1ch8IOu8Y25c/gBjzhxTEMeWxj2iXz1W1PVCNsIPhK1woUVykGf67jA6yX?=
 =?us-ascii?Q?GYTsp9DRVHsausXBc/R1a4l1ZbKlw2YtfbgqBZqc2y7WbWNpdUIPQ80kNTc9?=
 =?us-ascii?Q?qFY9ubbGLYZNOKKHLAsW0RPOaYz3qpQ73hiBIX4H3pHrE3AwMM1oT1epvPUh?=
 =?us-ascii?Q?+gkg/4Zyq16SblhZEhHX9Mn9576o7Th29g6i/DiNVR8pris990n/BFcYApZS?=
 =?us-ascii?Q?4j6O1MdiX8W1o+J7fTti1PlllODzOlMO1G7WqozkeGUsNJOgAyjtkJmForQn?=
 =?us-ascii?Q?Wnl0rwdNsBOjS8dElbADnROF8eHMVdfUraaAt70dbwvzNki+mqYFJe/GgAz6?=
 =?us-ascii?Q?UjQ6IAAk8l2HVvDlhgJbniUYrd49Rv1DlL+Si/hqzySTG9msJh/76la9oCkI?=
 =?us-ascii?Q?47u2rn9WkriwS5qoIoHhwUO2gQn108EysYyhRXo7Jn6ELTzmEs6cHxMKBkW5?=
 =?us-ascii?Q?qCmDMs1Iyps4Zm3yPnqBpRrxkzjdKJYu9ZKK+lwuucL/OmvYFeHCGgtlfMdZ?=
 =?us-ascii?Q?C3im8yWOQZKnVf08Oqis5CWpcB9JPMie8iusJWD+km8v+tf6sgBFH2j9UpNr?=
 =?us-ascii?Q?GtA6FAclwSJrKDksQo/5s+iNFWnD3TNfxERlc/e+lRYcGo12JsV+TJqDVQjr?=
 =?us-ascii?Q?KLlHG0knbValjWNJ6TValH+1XyTTh2vFFsf7vz9pUoJwj8kubrtvTo74za0K?=
 =?us-ascii?Q?bwfAZ+qDLV7SpNRVgt6vF62Se5sONCVWjPgpw8H1K2bb09sGnlk0c9Of6VF+?=
 =?us-ascii?Q?HvQc6DdxYJ+OKvW56tdbbEts2bn9SuGEoYNJvh7ERe7O3+bzm7AJdJXaHtIi?=
 =?us-ascii?Q?xImyHIpD90JtaYiJyDtKuz5AgUnIHKLQ54bbGSJV6MX0pvL2LT7YaCVLFmSH?=
 =?us-ascii?Q?ndqLPVnCPALCpVKfJkmuQGe6ZmeQKxwdj+7RGRMYcB7gWjJT9qqzs4Twc2YW?=
 =?us-ascii?Q?Nl76bvgUSi+CxAroqmtmIV5B87/IX8sk/993EBUoaUnr0N1gGU0XoNrJ4h6l?=
 =?us-ascii?Q?PMVRjCrCz2dXc0HHEyQ3iCBz3Z5OtVotQxZmZOjqsJBkdF951zeZwuihT2L4?=
 =?us-ascii?Q?vOkqOXSKJyhI4c4+FzJ+aXzx0SUYHPVUj69W9+kTmsqkGzORxW5EbODvGg8y?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igOjeGcYeq8Mj1+3TQ4oVdep8Qgj7iMBK4ABugBEdunQwWxyIJBb7RnxQ7BiiVZwgAxmZIX+nxu7E/LOA6I+u9MtAngJZFAdB1qick4hrFJJSqI/uTKroppys20BAOafr99zwmw53q5r/v1jHcaNDGrj9f2UWNQ5SNsoAaUwdZ24B513NIfqnd3cNH8U8RKq8eOcNnIKJsc/8gTho+woycgQK5/L0/Nch2pGrVbO7ATaPc42SIH7FO0QKUBs7Tffqq546IwZ01TxTngULR0/Ynmcc81x0RpyF2x641RaywnGVZMpbtxBS437n3YxVxlo3l+dud47zid8YDrZPKTzoWiyJS7Ii/dYitfaL00Df6hKd7nyugycdwN0ctWsVZXeBSqlIxN9OjPzLmr8CWQdk57bMRCumP/PR/AHvBOB2R79h7KpjOA/GqsFl376d1V/Pkto3jrq3eoJ0mSDMCQfgnYw+siMIHDMxdx9nRAR3cDL2sXplry+ks4lbDaPZXjW0QPqjVeSjMEVcT2+CJcCexIKW5eCHUhrgPCfVQ+1ahXru5AZb45juAwZVHEeIjnYMVlyTFs4XhlgwvMyZqwmSsKDS9rPiLVorpwQBab5lTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c93f15-6041-4a47-0306-08ddad0cb293
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:33:40.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcFUayvDOLdFoRGV4EPxG1hGzR7lf5Wi2lcY4CsKYA1M7dwrL3SY2GrcrFqLbZeusc6dN8wIrKLHbHOBbhM47BesEMEWrHbHqmWiDVyOxE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX3wCQHozVaC8T UVr8m0UN6iBvOZBKdy/UHlCo/psnzb2lHA8EpUUqdI/I9a2s3px/rXMsz+5dqyf/RjQ9yvtaq9X /FV3qU/nQRfkySgKPNKTdrnJFhc4163qbYkPB+/s9PQRcwg6suh/FVxsNs14lTd18ilSNyNxzMz
 Skgi/K1pCYeXQNdUAbwBdRGkypiGZQhiT+czK9LhRc24G7LQuIgM8td7wfZV9mQXnJMJB1iMBAf Go9L5W1lirk11gLXr4FshlvyosakjS3vxMfCnRm1m7P3Pgk5OB8SfiD6Hkz1ohjCw+EUxX+uhFp RdLjjH0r4NL+3wlLcitmzp1KM3d2epx0i1YcGAeWc/KzmJYemBC5emwmu1BtXQNQLpbpCegCYvm
 +lfI8LEQn3mfQrWFDpZAvaBydDofsn8p2a9+OTasWkmnlagNICe13KQ/EdTbTpm1ch0JabHl
X-Proofpoint-GUID: qs24TSecl24LHNSuMYmeuccAF4ONgT4T
X-Proofpoint-ORIG-GUID: qs24TSecl24LHNSuMYmeuccAF4ONgT4T
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=6850719c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=CJ9Vzb_pIGcOg4OUlcsA:9 cc=ntf awl=host:13206

REVIEWER'S NOTES
================

I am basing this on the mm-new branch in Andrew's tree, so let me know if I
should rebase anything here. Given the mm bits touched I did think perhaps
we should take it through the mm tree, however it may be more sensible to
take it through an fs tree - let me know!

Apologies for the noise/churn, but there are some prerequisite steps here
that inform an ordering - "fs: consistently use file_has_valid_mmap_hooks()
helper" being especially critical, and so I put the bulk of the work in the
same series.

Let me know if there's anything I can do to make life easier here.

Thanks!

===============

In commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), a new hook for mmap was introduced - f_op->mmap_prepare().

This is preferred to the existing f_op->mmap() hook as it does require a
VMA to be established yet, thus allowing the mmap logic to invoke this hook
far, far earlier, prior to inserting a VMA into the virtual address space,
or performing any other heavy handed operations.

This allows for much simpler unwinding on error, and for there to be a
single attempt at merging a VMA rather than having to possibly reattempt a
merge based on potentially altered VMA state.

Far more importantly, it prevents inappropriate manipulation of
incompletely initialised VMA state, which is something that has been the
cause of bugs and complexity in the past.

The intent is to gradually deprecate f_op->mmap, and in that vein this
series coverts the majority of file systems to using f_op->mmap_prepare.

Prerequisite steps are taken - firstly ensuring all checks for mmap
capabilities use the file_has_valid_mmap_hooks() helper rather than
directly checking for f_op->mmap (which is now not a valid check) and
secondly updating daxdev_mapping_supported() to not require a VMA parameter
to allow ext4 and xfs to be converted.

Commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for nested
file systems") handles the nasty edge-case of nested file systems like
overlayfs, which introduces a compatibility shim to allow
f_op->mmap_prepare() to be invoked from an f_op->mmap() callback.

This allows for nested filesystems to continue to function correctly with
all file systems regardless of which callback is used. Once we finally
convert all file systems, this shim can be removed.

As a result, ecryptfs, fuse, and overlayfs remain unaltered so they can
nest all other file systems.

We additionally do not update resctl - as this requires an update to
remap_pfn_range() (or an alternative to it) which we defer to a later
series, equally we do not update cramfs which needs a mixed mapping
insertion with the same issue, nor do we update procfs, hugetlbfs, syfs or
kernfs all of which require VMAs for internal state and hooks. We shall
return to all of these later.

Lorenzo Stoakes (10):
  mm: rename call_mmap/mmap_prepare to vfs_mmap/mmap_prepare
  mm/nommu: use file_has_valid_mmap_hooks() helper
  fs: consistently use file_has_valid_mmap_hooks() helper
  fs/dax: make it possible to check dev dax support without a VMA
  fs/ext4: transition from deprecated .mmap hook to .mmap_prepare
  fs/xfs: transition from deprecated .mmap hook to .mmap_prepare
  mm/filemap: introduce generic_file_*_mmap_prepare() helpers
  fs: convert simple use of generic_file_*_mmap() to .mmap_prepare()
  fs: convert most other generic_file_*mmap() users to .mmap_prepare()
  fs: replace mmap hook with .mmap_prepare for simple mappings

 block/fops.c                               |  9 +++---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |  2 +-
 fs/9p/vfs_file.c                           | 13 +++++----
 fs/adfs/file.c                             |  2 +-
 fs/affs/file.c                             |  2 +-
 fs/afs/file.c                              | 11 ++++----
 fs/aio.c                                   |  8 +++---
 fs/backing-file.c                          |  4 +--
 fs/bcachefs/fs.c                           |  8 +++---
 fs/bfs/file.c                              |  2 +-
 fs/binfmt_elf.c                            |  4 +--
 fs/binfmt_elf_fdpic.c                      |  2 +-
 fs/btrfs/file.c                            |  7 +++--
 fs/ceph/addr.c                             |  5 ++--
 fs/ceph/file.c                             |  2 +-
 fs/ceph/super.h                            |  2 +-
 fs/coda/file.c                             |  6 ++--
 fs/ecryptfs/file.c                         |  2 +-
 fs/erofs/data.c                            | 16 ++++++-----
 fs/exfat/file.c                            |  7 +++--
 fs/ext2/file.c                             | 12 ++++----
 fs/ext4/file.c                             | 13 +++++----
 fs/f2fs/file.c                             |  7 +++--
 fs/fat/file.c                              |  2 +-
 fs/hfs/inode.c                             |  2 +-
 fs/hfsplus/inode.c                         |  2 +-
 fs/hostfs/hostfs_kern.c                    |  2 +-
 fs/hpfs/file.c                             |  2 +-
 fs/jffs2/file.c                            |  2 +-
 fs/jfs/file.c                              |  2 +-
 fs/minix/file.c                            |  2 +-
 fs/nfs/file.c                              | 13 +++++----
 fs/nfs/internal.h                          |  2 +-
 fs/nfs/nfs4file.c                          |  2 +-
 fs/nilfs2/file.c                           |  8 +++---
 fs/ntfs3/file.c                            | 15 +++++-----
 fs/ocfs2/file.c                            |  4 +--
 fs/ocfs2/mmap.c                            |  5 ++--
 fs/ocfs2/mmap.h                            |  2 +-
 fs/omfs/file.c                             |  2 +-
 fs/orangefs/file.c                         | 10 ++++---
 fs/ramfs/file-mmu.c                        |  2 +-
 fs/ramfs/file-nommu.c                      | 12 ++++----
 fs/read_write.c                            |  2 +-
 fs/romfs/mmap-nommu.c                      |  6 ++--
 fs/smb/client/cifsfs.c                     | 12 ++++----
 fs/smb/client/cifsfs.h                     |  4 +--
 fs/smb/client/file.c                       | 14 ++++++----
 fs/ubifs/file.c                            |  8 +++---
 fs/ufs/file.c                              |  2 +-
 fs/vboxsf/file.c                           |  8 +++---
 fs/xfs/xfs_file.c                          | 15 +++++-----
 fs/zonefs/file.c                           | 10 ++++---
 include/linux/dax.h                        | 16 ++++++-----
 include/linux/fs.h                         | 11 ++++----
 ipc/shm.c                                  |  2 +-
 mm/filemap.c                               | 29 ++++++++++++++++++++
 mm/internal.h                              |  2 +-
 mm/nommu.c                                 |  2 +-
 mm/vma.c                                   |  2 +-
 tools/testing/vma/vma_internal.h           | 32 ++++++++++++++++++----
 61 files changed, 245 insertions(+), 171 deletions(-)

--
2.49.0

