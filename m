Return-Path: <linux-fsdevel+bounces-51908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E656ADCFE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895C13B2E31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96522E3B14;
	Tue, 17 Jun 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxAv+SEt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WcWMH4q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74B2DE1F1;
	Tue, 17 Jun 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169912; cv=fail; b=OZcc65RBZYvSdMDABX99rR43LMEEEHi8LHtWx5VO0js1gYELTLDwAIKrGk8Y9Je+XcHL8d1vw+QY3ptxrfa4hlgW5oMgEsh4X7Ek0N9MrzubSfU4tPS/T8B4ysJI6A9y4dq028+TaEqyDXUIMeXsHpMkS5gMlIoredGvmdSsRM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169912; c=relaxed/simple;
	bh=0KKCAZEUFhbQCsca+avSGS1Y+uYtGTT1Abh5klWQq2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERfWDj06O1yJowO+KPWiSkyH4HLxy8lyCucglUVpO5c/gPMxGEXGYXO40AUoAzFW0cwMM2rOlz8RYC1URp+eaP2PpZ0xo2MEQgyYwjO9VhtQpuPWiXx9dwDws9xsDyB7dEwOZFrXeWoIZ9NVsdLwbK4J87/i1CddhhIhFt1wcSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxAv+SEt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WcWMH4q5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H8taZY025373;
	Tue, 17 Jun 2025 14:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0KKCAZEUFhbQCsca+a
	vSGS1Y+uYtGTT1Abh5klWQq2A=; b=SxAv+SEtqUOU0h701EBu4d9UWPJvyrkQYQ
	FQ8d+crsMTyDaO0YeEHtzMjfy/VQyrHjPNp7DpaNB1YZIqJBnkohtA8WIeYRt568
	653QGs/i/lNFyJNPfMwhtpdTDIhcUeOPPVO0Q45GIwa/T+05MM/lZ2lkOZiX8XIK
	Efs2uqOxYN6zTawaR7uEvafQfUO/C+Wj8DW/c7SEmqxCjbvrwIVkKqtgKfqX8leF
	VjX2n/r/OyCCgT5Ry+kb4VLirx0JiWwKqrcYQKKFt5qkUEuxJ8fO0+vJhwPYgxTp
	zCZNwEobqxSmHh645YXMNwxHwMJJGdWwul0hlV+ZaXSie0vXTzxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r4fkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 14:17:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCfvce031679;
	Tue, 17 Jun 2025 14:17:28 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh9205h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 14:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OANMc17JzxDskYEip3VAZr31cYXNnaFRcdViaMzntv6YdG70v32ah3YOjbV2vn47MaNkJKHF1i6Q9+WCtx2to0eIoB2MZqpnvkBrJIyZPt7cAxsNoitRpJoQZQ7XWqxPSr/NNQF9BlNyumpmSLygqPjTZgWypsQMgBy2WklM3+JNTbbBWDBSsHVB5WRwQd+DElCRPgqKxLO0Z5co9BlhmY0ptZHZJTrO/cwW1q/73STutKTSYQnv9UNowKDsmT4NPMYopQnTpPHCYSshJiGWEYJHDZlqDzNieuhUacIGHzlXkZY1nI6lb1/1aiSUKpEReOiuK+05yYs0UKGe1p8Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KKCAZEUFhbQCsca+avSGS1Y+uYtGTT1Abh5klWQq2A=;
 b=FluvaqAPeB2OsDxtC2023QeG7diBBOk11IQFzdmfBz0EbkV5FTNWEinZtHa+g+zvUalAzE9+ClEhAo5kqFfznTOkbar04ldiGmTluntjLsdYU+M3f3MPmQauOHzxGObVuZaHHB++d1KC7B6TxTHsxJXbRP+hzfmDGgP11IyahYlLgcQdWFoNNFzGzis57hY1y9KPJnqd/d6e6dbmpITZY8Ea9T5mpB6/uA2IQRxHSppEqm1aDZFBYlCUHgb1YzuQd17N3PkkSxlQXxqw1afRJvjv01uGTONdViEa/6JT4Gn/QtJs2xDsuJYKWfIHDMgW/izF6Ye1hwuC+SXpoJM5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KKCAZEUFhbQCsca+avSGS1Y+uYtGTT1Abh5klWQq2A=;
 b=WcWMH4q5SW1p4rbO3adGeCYWG3DQFJpHpcZsl20aUf5yehkCNMaDk9rXHPbvCMLqiOFiTIJly+Qi6jWtYbNipOUFBR41vRI2AWZRdjGIr+gteJ3ov9QTWB2V8dHjVfyeYESA78jejhuMC7+qcEKm6P3CZC1vFaopWSag8Dy9Tn4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 14:17:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 14:17:23 +0000
Date: Tue, 17 Jun 2025 15:17:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
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
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-ID: <45cf6357-2614-4aef-8674-f7bc77be2dcf@lucifer.local>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <644216.1750169159@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644216.1750169159@warthog.procyon.org.uk>
X-ClientProxiedBy: LO4P123CA0424.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8921db-b5af-45ec-8b3a-08ddada9adbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AaN3sI5uxeiW90s/+6kc8DyyTfZjyoHTiFtYoeOiuatlWRZmQNpkSwgmuU6i?=
 =?us-ascii?Q?9pRVe99iWFoecHLVwU+wsyybt7xDiWKAh6giH9R86WOG1I02Apc0BgT3HMGO?=
 =?us-ascii?Q?P8KTAftNsSPsxdwkieWzPOannzuNwsrEQIMCU4Jd/cKWg3UonDtfMDLl9yaA?=
 =?us-ascii?Q?nEcv0111gfjKdCnTFlij2dWHiRx68z4U0sSoG5tfVGPNuFKzjON1/SVsaBgl?=
 =?us-ascii?Q?EXIjL8RmiXZVLnfWZ7QwQbbWGpgXGxYyBveMohtxjOh9T1iuo2cUUzFQx1Og?=
 =?us-ascii?Q?jb9d56RswZb4YWiMKlFAhNlfKaUXsdSvY7XQlnz3GVpiqki7bbEyjLJSnNj8?=
 =?us-ascii?Q?9wH4NhgCPH9Xxph3e5vEvRxyXPFwazKOGGqeg6ylo+hSxNIw9tmMSEhfCQCj?=
 =?us-ascii?Q?uibSQfEemw93/69CU7C4fhSB/TigMqt0IdxIVOm/B0LHQMsHuWkhHWutpV9U?=
 =?us-ascii?Q?+nLwW28tPyXVnb+wZKyCXLRtRAtcUTkPCUzC4zsXL143xqcoel/du/Isq/nC?=
 =?us-ascii?Q?rIyNOaIJRFe2Y260zwUQ/nMyve6HJF5bbiYzjengUco9R4dTLeGRCV/2m34l?=
 =?us-ascii?Q?QQXbBMNwJYkSg90g6xXCmb1x6+so1wyrQ43J1km22UtM+GwgQyYViaT/Tgei?=
 =?us-ascii?Q?hwq+ZC7H9j132iZaXBSkGSvXmWz6VPBL01/L653ePmpMlfYnKAWHsqJuC97M?=
 =?us-ascii?Q?XKtzxfGSdW68h+bsjFa9+T6wi4N9yM83aUdO8kgxMyIdxNdAkjokQcxrBn8v?=
 =?us-ascii?Q?ctnhC2sg2pBUqic1B6ALGiQTB7RHKq0qUiISU1KGlQS6u3S2ccYuDGUHq1MF?=
 =?us-ascii?Q?eQCOk31xsFT8CoxZOHT5eaERC9BsN5vIE3Wm3oHjO4Omi4N6TAgePFRWAB3k?=
 =?us-ascii?Q?u+CUGUJvbKHjfjnknsTGeI3vFENB918Vp7QvONylH054BlQ/0r2H65ylZF4u?=
 =?us-ascii?Q?wqROFm0zU0WZhMpLhCEieK+iSYgfvAAo4bVwmWs9Cd7toIqelMWvqOJYpMYZ?=
 =?us-ascii?Q?JMV3G7Ct02jzmRGtAGCOC5QoiQ3x7EG22UNcw7/MFn9R8XTlPoPzdzoGwq16?=
 =?us-ascii?Q?NhQ8UzXSd3Bsz3xhDoVT5WCSF7HlqCKrWhgPm4oQAtO9PSQC+G1RDvkQnwXv?=
 =?us-ascii?Q?1MQyBSrD7TuyYoCJIL+60cWgwPmECLjf1UD5eITFsN6S455vy3aRjlNo+X5o?=
 =?us-ascii?Q?gZ6hpg27KTQXuAad20TAh/LrhDBoi+5NExH2JukLLgBgkFLH67eCO4Hv0hJy?=
 =?us-ascii?Q?UZ0N4VdeGw0TPvbpLG7/rRhtTUam+42H6BZBNJJYiqxtm5Ab8SyOg8uZGsBE?=
 =?us-ascii?Q?pyRB0qoI6Yo75lZ7J7yuzWu3LI+hOKksOx4lgA46ijG3NEBAl1ELDsMHsNQT?=
 =?us-ascii?Q?kHDBQvtibnV83Qzoro1p1e13sab4Yee6irPWIsP04dZaK2RXZJcFjQX8XcZc?=
 =?us-ascii?Q?E+mtFlnCSxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpUIN0eiEHR1IqDPdI0DKV6HVg1NpfHhaBLy/kZtIXMLcCRXv15nBWdu+Gwp?=
 =?us-ascii?Q?cRtSh7k/iCS9I9SdjFeSVKFEURHatRR0VKn3ZVXpyDjcBIh/EXc8KMbHAlb0?=
 =?us-ascii?Q?V0sS3D4Ueum9YZNRNGRj2/Io2OfyPJ7r4aSDIfo4nPG7HvKYaXCd3vw6VQyk?=
 =?us-ascii?Q?6pCvioe63lOYcS3PxIOyfiTkmwxVYk5sK6kbGQS5V2OPPUjYgH6cDl7bvJ7y?=
 =?us-ascii?Q?JkRv6L/o9+h3PP813iyKofG21CBAaYExjg9LDzsPitSJSuyXlhmuIL3XwVly?=
 =?us-ascii?Q?3ctEdXxAYqzLOPzUWsHxwhd/QV/QE9tf2VTRRflvRs21yQK99H19szrDlaxa?=
 =?us-ascii?Q?I76GgOvcCuce3wW2A9sJ3Ot10anl0+ND6o4f+ljakNJjsg3Uy/HTjF+U7x2y?=
 =?us-ascii?Q?IkWLfFh+qjiym4qauv8kGiXMfQtsWpngz134Ih1ZiYoWFG03Aq4R+rSVVXUK?=
 =?us-ascii?Q?FgnTOkmdsbFBmNscDXHuzRC1CXmN2D7wJetxnhV0IoyNpJaG4k0V3GG4dB2W?=
 =?us-ascii?Q?UGzsI+ZuUsBhlbxBrVWN4cNpAFz7JUUpIKaKxuRr1USmKYMb4YudDOAImoxe?=
 =?us-ascii?Q?VigBhobbGzxlj3hG20rSYWWQ/LtbJndGVPOI3OadobC4OZXSU2Zdq02ZmABl?=
 =?us-ascii?Q?zplUw81HCgN4rHEYjc+dNAVpaMWR0knmoTlD0Dwv/iH/3sFGlAa2jG4Yvy1S?=
 =?us-ascii?Q?//Pxijkp5cj35mxOIJf+JqvClrJVtea50Ake55fGeae8ZFdFRFoBqEWtK4X8?=
 =?us-ascii?Q?zApE39VdhCb7aMJgWukN1RtDiBxG35WUWpS1KR57MgPhvDtvjciGej/kVeCo?=
 =?us-ascii?Q?ZSzFtLvBNH8aw/Eavc3BrsRb+1nzrHamDSA44ELYAn4UCkgeOchEV8PkIMaA?=
 =?us-ascii?Q?U+/8y2Yybhma5yRUiEGTI5855TJNq4WwdBr5Xmntq7gQ6/VEt4tcAu8bqZhb?=
 =?us-ascii?Q?6SDOIm++wvP9jDLtv/39TsiYKSFMw8AjMLlkshGGorign+ThnUS4ASa6SXJ3?=
 =?us-ascii?Q?8weTWlo+AK7uW6YNYKyUeP97QPZRqEMD2bdw8EN8sRsoG7YIz/PTHTVWMLkK?=
 =?us-ascii?Q?hjs3EcvUPPrj1buzqRvLXAQsyDkLL8lm+6KXNfPfrrtBe0CuzoFSVlPBb6mt?=
 =?us-ascii?Q?+xEfP3IhHmtVonhrrB/s62DrjWMEhg33Y996Kb5997Za5ZC4gYyCgMkb7nRm?=
 =?us-ascii?Q?L2lIubJ2YHw0xSRlI/6G+rr/RuDvh1PExk00sOLOjQEh2JEvP7QYy9WoLnlJ?=
 =?us-ascii?Q?XoY4DgfJlgPXqiQDQ2lJp6dAs7b4OstEtyAlxGuPQYWZh/oG9LwY38FGA+MQ?=
 =?us-ascii?Q?19c+XsZ7/H1UH1mJM44PAAFjQvrymNMJ6BQwUH5ikrw3PBwOwMWcrpDWFFB6?=
 =?us-ascii?Q?NtgxcsZun6fOqfI04a5CvyKWSs4jTrnC6+P9PdIOtn8W9SRStqv1+g1sqYHa?=
 =?us-ascii?Q?DgLRYsuP24D2nCVEAFEEfCt5EI8HVMQQWp+9yhAiQJ+FD6vd7yEuDSOhCKD7?=
 =?us-ascii?Q?+eF+Y50ljARaIFx0np7JPZBBZgt59BQmlf1BeXe8Pn/UHMqhod3ALmVSy/tI?=
 =?us-ascii?Q?cCsfA/aSUf25iqwT+EhuRTLXWb9vI2ws0jGUWGf+YZNjMHSCdnslJaqS+5JV?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QBDRQjWETd6/m3CejgBVpyVWCnusB/UWF9U+oqpTK0a6F4KCFxkoct90AXRodhXohG8bOQj/+jyKphhEC2VZCnEfH3oK4kIAxzkn6Bm594gW+lz1QZZLec2STuNplAHrM1TUINHIO7ytmyJXPSIEt+AyCp9sH0E6aUuOfSU6H76MP4yxqqVaGJI7ehw/WIkkedq2rHwwCYWSJmY+a6iaaDQqP+Op9Dg1jQ7/cgx4DbVStmtWQuvxi+9vqeM50OBoU1k/jRIdV41snwJjmJy7NrXsiMwvGnqkVCoYYEs1W34c6QZQzDOqPLEW9Twi03TpmC3oE1DuzYJCnaLQ+PyF06fIa190pwDf0uKq2W29Sg1OYZWb91Rx7ihtJHL7Gllt0Hlx26DA/KIzrTudyGtP0bNFs+CcB2jqy5IZw/prKssX7+c9rxD0+lJShbpjUXBZq0UItW5tSbynBdmrLDiUqhDALt/DdgW7XBxd1+eUMlopyLgV5/IXayvJgMstq1vJXd/zEHXfKhBK6goy9UsIFDprmbmnuV2iY6HJGUQGVlsAtdDfyY875GjU+ChgQayNDmkN7LQBzV8Cqhpk2iiaRw7A32VGpq47GoL97BMC1bs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8921db-b5af-45ec-8b3a-08ddada9adbd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:17:23.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ghwvxifeqDis2+M9YYGHbNIbWg1bDN1rNvEWD28HL19Otdrs1AkUIn56FThJtEcwstA4sMaqLPy1dbTWtiaCPBMKXivB6TKwcp+87esXSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExMSBTYWx0ZWRfX5MuK0tenVUsc MtSHJ5WsAf1r0eZvWS8aXqNKtxc1FIO4MKaiyN2XKQKdV9haUgGWUcpYAjlznCtMtUGOAFfZ+mB 9Wv2h6ZlXC1ePkxBStQx0GL8yl8MS5xiEnJ1L+rbvyJrbNddP2pPmIkZ5I5uS/saV7F+DPSC3GP
 dYflCZN+Rf6x5fNLUaUsIi1m1TErKSjSyCnPRoYt7tu9O7UezsjG3QBwDLITXHZ6FPb+e6XCLtL wfC7chvi8eePiSPbE1q5qdSBFU7zIoivBUiV+L7EvJEK9hNF69QUGU/Novkx9KQpKEDM+cL4WAv PSOxftNb3S0KHLlPOfloCr9R14B8CHJ+Wbep5uMJRoyAEnn7316neqieKD6nvPayFuObPcp18k9
 IoXCxSbYVIMmTjeXEdG5PtHm+mMv0TyY/UAs5OaQpG//aoVbJQ3y2MGUt3oIjJWoFbUZM1Za
X-Proofpoint-GUID: LV7oRBZjOf5ZAC-ElGvc7cGu-NnLUCvX
X-Proofpoint-ORIG-GUID: LV7oRBZjOf5ZAC-ElGvc7cGu-NnLUCvX
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=685178f9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MA-42675piwLz8QlgOoA:9 a=CjuIK1q_8ugA:10 a=Qzt0FRFQUfIA:10

On Tue, Jun 17, 2025 at 03:05:59PM +0100, David Howells wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > This is preferred to the existing f_op->mmap() hook as it does require a
> > VMA to be established yet,
>
> Did you mean ".. doesn't require a VMA to be established yet, ..."
>
> David
>

Yeah apologies, indeed I did :)

