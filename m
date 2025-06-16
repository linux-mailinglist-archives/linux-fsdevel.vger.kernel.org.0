Return-Path: <linux-fsdevel+bounces-51800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46647ADB9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1796170F13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012D28A1D7;
	Mon, 16 Jun 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MlGjWMl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oDwMJ3Pp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2711E2602;
	Mon, 16 Jun 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102506; cv=fail; b=ZRDwxDsQVblg54e7hTfTEWEm0jXUCQd+yzzzJTzeKTBog2xruMnrr95mXFt9gjQjZNgnKKSodGGGMs5Gd+GeNbdAdlRxobu3tTM0yWJUcw2Jwdt7d3GPPmnEbgiBH4qxfyAHlUQ1W7gX7C34uduhBPGErE3s+MmYS+MsQsDRT2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102506; c=relaxed/simple;
	bh=VPvLXJLIde+xeHs2FVJpyqF6ciKmCXPjMev0ZB7ECsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQ8L1Byrz8QnJ1hP52oba8B3AEeUXzZwylISlCPdSDPNsSnBC87CCGLSLLMBQXo7VpaVp81p0/b2K286gMSCb37HJ8u3PMzkvK638/XosD6PItDeIwptRYz+s2azLfbrFbS7TTZyTk0gKeeIWRx4xXsY6Cs2BtAJTCo8MBEFdLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MlGjWMl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oDwMJ3Pp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuTaY030535;
	Mon, 16 Jun 2025 19:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n0Y1Vqk78cqPEGZx5uk/nzDNc2etT5n21kmOCNhQxrU=; b=
	MlGjWMl+c/xN7ErrkFpwQXjsbu1lYmZ+eTMb3OrACYfz5+MNL83KJRT4K6ajk5H2
	MyFRXHx8pkOk+54GUyrtvXtrBpi1tAqNMRATEq9O7TS48q9oOAtKAhejH3MiGcy2
	xAT86rIAYNQo8lvTaWDUTkw4QIoS/0tsvOcZlpQ858wlI2DFERNludqSB96Ri4ef
	EoBW9/CaC+O3fXFmSnQSS1p/rMz/+s2HnEreFXC1f+fUafGrVKPcJA3gumDuEg0Y
	IFRYmlsboAmrJIv2+hsz9vhw9RAMhAVrvtGjnY58MUftvfaves2J4GqqN+YN4zor
	U4Gdgt7MHdNiNNF/N94TNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r2s5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJREO6036434;
	Mon, 16 Jun 2025 19:34:03 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011031.outbound.protection.outlook.com [40.93.199.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yheuf7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxSFpDW0/T92qZGppPDKVSTWnxz7ScSmTXrIp9avaZTdFXnIsGhASY++S/rxVC54ovftftHrXuImc/i4RjGt5R5ZkGA3vnkZRbwhh7p//+/MLeEVFMswbBppb5FPMi5+zhQpSNLBwfeXrjsXpyXyKiGAnBucNL5hEHP+taDJWkFFW7PSdLa5adI/3WPcJtw91mpELDQianDdUXbZif3bt7E9VYkXlf35htDEbmXIiD0Qh30er1M+RFUnM2okrqU4xkrmvuWye9nVMehpWmSGv4cO6dOzK6P4QX7oArOVOGpMptMGK7n6CR5yjtcKcLHCPJqM5mqFP+GOT0IrxCrWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Y1Vqk78cqPEGZx5uk/nzDNc2etT5n21kmOCNhQxrU=;
 b=KEF5eUzHvEkraZnYy7VKr+h5fJFQYELna63tLpjbgcZ79ou7g6rq+B7LGMG3c7pKi+g3X0kSsqsmwf9KQwQz4vBqtCdFl6oFio0w1qtIAQbc9XlAnapMJznuvcMvvcHzZsNyEEuJ6GTsvyKX+AG5ZwxcGGtmK6SfjoD6kThnOyi/VUfs8rA7ueSK+kipQ3DFiyzW3R1EmIqV2H+WC9Izg4JHrsrfB1QUDO73FFc6Pp31T5v1Bd2aQlY6ulLXXqQsUs4fTcQ3BncNorkqttVwaLLpYmeTYFaPFhNuuTyyiqlPIPAPjkTVn5DbKcuxVrT3MruQCsUWUx6lI+OMKAahXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Y1Vqk78cqPEGZx5uk/nzDNc2etT5n21kmOCNhQxrU=;
 b=oDwMJ3PppVObui3rd3dyEYtYcbmYY5ANK9I1hVHa71XUonoQ6WpKMTJN4qm4rOp/PSbkqemaMf39VHudHY+deAIbXgFy/HDNcI3rFDlpPBDtzpaH6Ld6KS/id6NIfuhTGSRYMbUNcrjaquVvR9Vy+EXfpKzDnPLXfuCEaTgp4uc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4470.namprd10.prod.outlook.com (2603:10b6:510:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:33:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:33:57 +0000
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
Subject: [PATCH 05/10] fs/ext4: transition from deprecated .mmap hook to .mmap_prepare
Date: Mon, 16 Jun 2025 20:33:24 +0100
Message-ID: <5abfe526032a6698fd1bcd074a74165cda7ea57c.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a6743d-22c0-4ca5-0eeb-08ddad0cbcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2Hm6n/g1F7+J5SeMZAMt3bXZmc+0Oq6nEuuIw7aVGwWOgi2tVyA2gctP76q?=
 =?us-ascii?Q?Pba41RAXkArQG05F5sB1tQcZrTf4lxdRGRg5syZ7/q6T6nwP4Pib5/AuL6nf?=
 =?us-ascii?Q?UW/doceDpP60l0grBoO+WwDrV42HN1IMg/v+MMi8uUcbUBr07+yso+VYG6pJ?=
 =?us-ascii?Q?/DHO0JRCGOD0zVuz9hE64mXjkQs1YO4PEPK0Mcgl39J6gMvURyfm1gxJ6aH5?=
 =?us-ascii?Q?eDqN/5/SjCuQKcU3wXHgj1djdD8CLWRTG05Gw0XaVUovRubaU6+j2HyRpEaC?=
 =?us-ascii?Q?VVu2H9KRJ7+77O77q8LJlhU6YXDp6mbVNB0+K/fmJ3pO2/69Vx6wzZ6HwTDV?=
 =?us-ascii?Q?z46i7ly1tBdnXXlq6j8bfoSWRrB/GSQ0T7H/PR3ThIh1ExvIhZnAaTdJsku1?=
 =?us-ascii?Q?BGO2eC5gjyf+ZaYVRnazQWPdf2ixPbeFnOzPLg4BeiGF8dM9JtmDho/+i6dD?=
 =?us-ascii?Q?RdqOK2NtVSJHotPLhqK+FuXZK3Oce+80RmZUaGFl1VlWELli/Eiv8LO4GPhQ?=
 =?us-ascii?Q?jlRXlW7LJs9FEvZgqFYZZdPFTXa7YHmuLt07xRue9kptDpF3R6NUVtgjG5YF?=
 =?us-ascii?Q?1lh9+VYuEmyfM7x1kBGLVXD5IP7mmhkmb21KosoRBGNEEo/SKLEuiagzI4wz?=
 =?us-ascii?Q?dGtTBIMZwtCEzXX5dvwA2AaPPpokcGvF7F+3CezTB/IL8sDuZSXq+d3Bg/ja?=
 =?us-ascii?Q?mlS2hsTmuXbxDitTRO4oHzoUNwWLfpmwp4ufIVdi1kKcmcCxH6e3RkKqqtCb?=
 =?us-ascii?Q?mFBw0YGtwEinUAbJIafxZFZHhm2askb9i1mrU072YgHfi9oKSfY0ZKMVp+aQ?=
 =?us-ascii?Q?+AAMGDHGdhDIEVXySHumBr79MlzWhqDeLCxkUpHnxYj95e7jrKH0CTVhhMXP?=
 =?us-ascii?Q?R1Nj9bZ4hHXWd0kDpGeERtlTs7EoGkax6s3z26apMfEEVYnE+Qc05MWv0kn/?=
 =?us-ascii?Q?3Tg8pIM6TJTC40LgI00kOqmijxcmd2nUDuLwq7sUGN5wq6Gpp3/rcwfTABAf?=
 =?us-ascii?Q?6kOPsygAt2gzR8noBjC5yeHJx2ev+T0TXOBtgkGek7MVALWruP2z4ovJdkwg?=
 =?us-ascii?Q?1qnYCyWBLv0AP/iMFT/A3r5aL5aH44fSh1WdfE+1djIjXM1F8fqtvSd/snIm?=
 =?us-ascii?Q?bf4pzr/ICAyrVRp8g0dXYK9niHLpvs2h7lgFlViTB/OA5EWle/MDER9GsZ7l?=
 =?us-ascii?Q?hSCtyxfL06ZAEwsL+y3AJT9rCrvDcpPLEjcAnLMVkypCuVFK9uSlEQAasM4A?=
 =?us-ascii?Q?xXH+i/hUU3QJTL4RpWm2QIT+8kZEtyYA1DeXViVnQWxwYBWaBhtl6diZeIqt?=
 =?us-ascii?Q?Z9np+zqCqeSI1vFf8fkFHEegptF/t+pTZHN2/rRLxbjNI34kBZffDXv4UYI1?=
 =?us-ascii?Q?eB4Jo9DKxiM/9eM+qeJ0ipz+ZW4ciOonFDBjSxO4ZviBLbpAgUuXBn29Xu3E?=
 =?us-ascii?Q?M1Kthu3G9co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUYT98Zc41mIfF4cZ4HsdCiT/km9EMJmvnwfWh7RQxXcLDDm/2QYwX8yi99b?=
 =?us-ascii?Q?sGtnGtCm0BhnC12PncgKNmISwSpZa6HOD/k9c28NeEUda1n78ZjjoRi4OGf4?=
 =?us-ascii?Q?ZC67kOSWqGKvxJunozT6VLIpNp00rnHe3PlGPA0m8ph6fTWdI7bs54NWMxjs?=
 =?us-ascii?Q?T8Solt8haAMMk2FC5gz7hUuXaPqTtd37OqeSW/mtaVRJc/s/Mtex6XOnr8+w?=
 =?us-ascii?Q?Ka8UZ3CttdWNHZWSvrc4YLbuc23nvvDEdRFnN0lKgl9ML90TRBMP4ddtZg8C?=
 =?us-ascii?Q?B3T/h7h0Y0tvWmHinaVbn8PzdCmOd/C2/pG97xqWqd4koe48EY2RQt6qwzUo?=
 =?us-ascii?Q?gonhCbGp2ZXLK0F7UYF1/o2zolNWQuWgqoyw6PTVpFqHW3pexk5qUk1Z9QBr?=
 =?us-ascii?Q?TFWMHgeATkLv3APfQ/50W1dwu/WhZPVZC1R1U5O23oCUnnoEgdZdhYHgCUgG?=
 =?us-ascii?Q?8356lEiwBgARBoiWOeYFmd+bY77CpoazZVH02SpHiG64Z/dtEokyceMNcFyL?=
 =?us-ascii?Q?TVNcStM5tQg3QggTfp7HUzjP6G2o/2HwBdbH09qdQM5h8IOEnH3920Zq5MnW?=
 =?us-ascii?Q?2dKqogjuOzyHltf2iAIioJxmynIrRf8EDpSKDRScrq3xstVoHxfD2HbY11At?=
 =?us-ascii?Q?4Jvw25BvDvxNaKV2UNkPCaY/HLsAWeLscm32nk3AOyXNzAkrlmiOrnTKtzxa?=
 =?us-ascii?Q?mc3fvqv6A40pBMQOeX1EGSD9USRbYEMXpEvZZj1e6TCX9CzG8tXWkr6KHfeM?=
 =?us-ascii?Q?Ojbu6vcfZ5fvOgympzPGSMZCqwBVFfeyhoyRfKiURJoAIofmpGscwYgHPGCb?=
 =?us-ascii?Q?Y91bYsesSoUbRb2BCn1qfvp8bfNPKdy3NjAhxvexNmRPyKbYsRNFMim0oNIT?=
 =?us-ascii?Q?8daax5YZ1UPy2AV/uDqNEtDHtxijO0aBGTqocScGJg7gJG/GK7taIpESd7td?=
 =?us-ascii?Q?nodQqXF2IeOuGDsbtR64CqlfrrBLOT7mOVfI8tJUFTiUP5Cwr9jvNxhbrSf2?=
 =?us-ascii?Q?0U7rRvuT9D49bgRNLXeDFISZ5yalvmldQPmoeH8ysROOgVtYH3YHJaXgW1lq?=
 =?us-ascii?Q?7ilyzmYfP2WQBX968LgoebJn96D6ocIG/rmLCXBh0q4Is9g0+uONcPSXyww8?=
 =?us-ascii?Q?tRgN8psIQaaMO9Ya5bvmczn3RM9r1AH6gFkuRgvZ2X5xJQt0EbBfZ1cFyw9p?=
 =?us-ascii?Q?n+c+yk9QtaY4E3o8KLsQIZSMyt+x0jB2rECNGH4tAGXjOXcXSNNjLAqfTH37?=
 =?us-ascii?Q?AiweZlSgHSs+gOqtJMTyvtxDT9OZIEevuIg2M09/TR70Hlp8aA88qYrlUfeH?=
 =?us-ascii?Q?5kZKGuZ2EBKqIn/eYsIP3ZdbYE6HCjRgmOkPuK+k6VB1DCKo1hDp57kyxwjQ?=
 =?us-ascii?Q?+piviT+jsZtnaOhOSs2ADT+FHhL8UvjbgpB0cwwEDmcd4eI5JDcrViJ49xVY?=
 =?us-ascii?Q?WUtN9jhGjHeOhDsZgezNc2VGXPJ5xfrIGKWk6N8W9N1lgNpkNigQGg7wOmwS?=
 =?us-ascii?Q?6hmjoXUERU2TIIfp0q1VO9wT0e/xgA+TjPZHMvtrSDFIqoWYyrWTVwr06NuE?=
 =?us-ascii?Q?0zH9YQYHyni9pGcGZZe3bH4FeNmdLOhTsvGbluvOtEkL+lNotFYEeqWCcBVS?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Mg3kxEwzlnCr2E3s85LcjmNTqX5au2ZolasVsuDV4aUJwDuk7nR+o5gB8StbsFSXFNAQqZwHRLY1jNA4ffxtuJ87ljo4VkZMWeF7akKkenh3GWrybhaErU8a4NE9oG7XfehJaEluhHysNoIiPkqGyHdINaayQfUV1ORj3vNCzUWt35ut+ljo8+SMxIrzP6Z5WDgxa8fEyRxLMffteS2KX/GUy8HfIXbR6UudDgDwOMybiGnO44KjMq8O7zUy75V4x41DuUQ9KV5xIGkEN1O2bSmGBFCyhZb2UY9DvjFq+Fi6fnxL5w1d0ozkOYf6yWo8e+GF4dFircRWiT+Z3zrDl3S+DpoAAYJumpT2tbX8l2os77f43/O/K1n0UOmJKeLxbB/Kx+nDPJNIAbdMHYYEcsxa/WicWhedFHemvhNZIpa4MILoaXzMSN0j3RnDEbqG+T/2UwaSn1dnd4vAkJLPbhEgFSPl5k3MJxkLrJFxsIk3J8DpqTdSZG8QtdaHBd0Je31Y4q+XjAXqUMiS8lOsYJ3SUA1VxIgI4uvlFEw52NRvZ6miQ5fZL0nW9dKd1uYX66JXHXiAt5FTDy7cs0R5VmnlVtcgWYU/+GH/Zcyzn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a6743d-22c0-4ca5-0eeb-08ddad0cbcd6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:33:57.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qyj4rfrZBDsenjru2DwluVTy3CXCXxGfI1bqxbQnQBECZQAKFGSKNkiX3c7zLwRSiBlpqLW0zj4lVB+3nJT+296Je8TVs4yGevzVEpZ3+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX0cp+aJr9RJ83 lR5Dh59Sm97Tam1aA9T6dpTzRWRmS8RbtIVH+bvlLa9JJQevWWOKp9apNlX5U1gZsvCTYvYNIRX qRXPBAyuMtscS69GR/8N0d7MCMriq4cmgJmIM7+QPybrHtIccE26tQGJp3woBkhYAecPPN8rQRm
 67guKUfww/m5XN93ehft2OkOaB24fFRhCYLbK2Hoi+tTvITcDeeRFD5EGt7JvkNhsZPgkqFnKh3 p2bxaGORwwLnZC4HSM0h3AxoWMpFtXXfZj7rs4yFL4jfNIblxSc8VgT2tEp6b8AvFNoA5+F0rX2 7jMUPYbogLuO2Y9Wg6UU7xURK33rRsJZSlgvPfYIdruPfOYHXEGq+gNejBWYoz0zcoUrc2pUmN+
 UQZN61qk78TATp15mvB75g0hnR5UYaE+nXQqFS1N41nKyVT0Sq1G2pbC4vHJNaQd64K0Yyyx
X-Proofpoint-GUID: NEQ7-rgpIZJeSJ9SJQER_sIHVUNzlXOx
X-Proofpoint-ORIG-GUID: NEQ7-rgpIZJeSJ9SJQER_sIHVUNzlXOx
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=685071ac b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wP1-y75VcYHVbZsH9DcA:9 cc=ntf awl=host:14714

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
 fs/ext4/file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 08a814fcd956..38180e527dbe 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -804,9 +804,10 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 	.page_mkwrite   = ext4_page_mkwrite,
 };
 
-static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
 {
 	int ret;
+	struct file *file = desc->file;
 	struct inode *inode = file->f_mapping->host;
 	struct dax_device *dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 
@@ -821,15 +822,15 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(vma->vm_flags, vma->vm_file, dax_dev))
+	if (!daxdev_mapping_supported(desc->vm_flags, file, dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
-		vma->vm_ops = &ext4_dax_vm_ops;
-		vm_flags_set(vma, VM_HUGEPAGE);
+		desc->vm_ops = &ext4_dax_vm_ops;
+		desc->vm_flags |= VM_HUGEPAGE;
 	} else {
-		vma->vm_ops = &ext4_file_vm_ops;
+		desc->vm_ops = &ext4_file_vm_ops;
 	}
 	return 0;
 }
@@ -968,7 +969,7 @@ const struct file_operations ext4_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ext4_compat_ioctl,
 #endif
-	.mmap		= ext4_file_mmap,
+	.mmap_prepare	= ext4_file_mmap_prepare,
 	.open		= ext4_file_open,
 	.release	= ext4_release_file,
 	.fsync		= ext4_sync_file,
-- 
2.49.0


