Return-Path: <linux-fsdevel+bounces-51806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3494ADB9EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7807A54FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002128DB48;
	Mon, 16 Jun 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3Ef8kP5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mR3r4Wnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573728C036;
	Mon, 16 Jun 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102519; cv=fail; b=pU7NmMMnZPKAhduSOaiQms+RWIgSyYN0FKA354EQrKepw7TI24dvOLoVBLUgl2H/G0etTPZSXk623KvdCvGuo8LV4uzy6tN/uGGLmfXSugHbl3qDCD/vni/1gAXef403jkSv57+AtcgTShf89IOU/kI8SaFidE0ysbMdlbDADQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102519; c=relaxed/simple;
	bh=PjemnO0jfPbqP+dJmeq1k1BBYHKDq3pfzKAIyNIgTcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ioeavc5OJImnfAkfusvPlIxKP8DXGqEvrbg4Oy7JjtP1rh+0g/lsnkn151lno/Sid+5UWknPZcVnpZtGbgkL3TPvmubs8quAzft9OYt/uIJbI+rKiAZnH8dPkaxG4tOEvW9wSFUqUdbbPAQDwFJxad+aF6UIdodGkYNxZhj0FjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3Ef8kP5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mR3r4Wnm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuVqr006541;
	Mon, 16 Jun 2025 19:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PiNJNTJE1OfkQxlJqIVcx5Xp7Gs3tunUhFqn6/frVm8=; b=
	N3Ef8kP5ZSdN8sKZ4o8AiGuJArP37bsUE0/OT+bKXgm4UUgk0daDq9lri7Ej1fNa
	qm3DisJW1GAOjMxrkmo2XxKlPbLloPe+xKt/8o/8w3Bin12pUUZIby0wfeRxL+ii
	rcsumFJzaocuJrAdNRUmP20VtpuPJvrJ2ebZUeb5mEuNEeFoovQ03RiccOCq5pwg
	CAuhTyBBoF9bdpqZL+F4zje3Yj4Do63j1b7DRSVRCZznxpTTbXk4xf3xU1HTDrfo
	+mHz10dVitKy9Hgc3t4ageLl+9pD1Wk0YwKbYRQQswdHlIpQcarlkqVw8XkJQvzi
	itPAiDVt0QMp+mdl6pCvZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900euq8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJAKnW001648;
	Mon, 16 Jun 2025 19:33:49 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8bqb0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 19:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm6btSN8OgkaDq4AmyQ7HGNkv01oKBVPKlxxvnsNhOaBP3GSONKu7JvaOTp1zYHKC1Vec1akl4VK1UCbEiUXNDWKHB+LcDj5l7GPby7ioKhrJs9vvAJEdUUUvlk9HyP77rGS9glSiOkiJO1804GbTczKBWD6dik9VQjPXQBfZElJYVV+HR9yBye3K2T7Zscqci1ZEMTxAml6kckqtxQPVoR4BdxRdO5Fzpq/vvAvlkitlikZszwhNSLr4ZtTEiM5EQ1hBIrED2hndm2NyutfOJ3nHk0AKK8VKWK1cXdr1mOWUqKdutAiLgn6YUBnTibgvF3uhlZGtdY5oeboDJTyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiNJNTJE1OfkQxlJqIVcx5Xp7Gs3tunUhFqn6/frVm8=;
 b=E3TrM2CO/0NHymo8IJVqrV4zsbZ4nczeiJaClQxMIRmQN9CiywsXD8YhUV2ZA21FaJMT+8rCmiNdxeJN0ky+ILvOs+KFWRflIv7x8GR74vHhNrl0f+PDPzl7wrp8deH2JDCPzf7YdcotJn0y0wCD3l/bw0YIek310hRE8X8ou2JxS2uuJknWMuyPXLJMlyK8deunTVhMn2mzpkfsb4j4Jfj6avp9nmnhf9wWWq3zkSrGYcD0gk/8+an8XC/UwIU6fNGkuAJDyyNIBBUz31erdx/YjGqLlUncMPmSz1XRUTQOV/ZhbJaKhmRSEpS9xSK207UPbGRU0wD6PayAsjktYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiNJNTJE1OfkQxlJqIVcx5Xp7Gs3tunUhFqn6/frVm8=;
 b=mR3r4WnmYrb2TimxxnSgL8C4NC6vjV/466abvOG9p5qgWjwg+KBF1NuZ5vCNDJf4nwoOuvoD5iNJC4Ab0OnYyxm9bFJDU/OKwv7nDVbKWVaPcGsvjUcUTqXVSkgZxefpnQlWU2R76WAgon+W716u74DlMYDSZjvZZwtKOScD5zE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 19:33:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:33:44 +0000
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
Subject: [PATCH 01/10] mm: rename call_mmap/mmap_prepare to vfs_mmap/mmap_prepare
Date: Mon, 16 Jun 2025 20:33:20 +0100
Message-ID: <8d389f4994fa736aa8f9172bef8533c10a9e9011.1750099179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f0e8a0-96d2-4e0a-bfaf-08ddad0cb4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8gHb3vKsVg0+QRdKBoY37GyN2aMvWvebJtNZoqBMqQRXdVm4GhDuuRN0ao6?=
 =?us-ascii?Q?6ZffaqMO2HIZHXjl5a4JhzXNiIqUmolzzxoymJG3MrxgKGZCUFW2kMYXHTK7?=
 =?us-ascii?Q?o/5atQF4SUnhWrexbxgKZQN8sdGhlva/ub8PMaBWfbn6UkBCH+cJ811tdXX6?=
 =?us-ascii?Q?zwRtsEXtk5AGRcwqqlIo0MHCiegteCZicUCFz5GyDelouUZzxpYf8j8lK9ir?=
 =?us-ascii?Q?ZlMaEwCsiJmpE6NyNm4gNG173B4VFiV42J8vDIBenvLzwwc2gy9GbhDPanX1?=
 =?us-ascii?Q?8JqEqhyW5QJiOcm/YG4aomldpO1d21qKqHfSWtDxEjtkBWHoA85Koi5kBziC?=
 =?us-ascii?Q?b/cBsRYJystOFvWsAJkW/wR20r/wbGwJQruHklCBGXzTwTEe3mnQJq8Tv7Oc?=
 =?us-ascii?Q?kEpnWhRpGO/ECdut1dC102Sr412VnrSjg5T8icnUFU/cPE1BiQ6jHU5ADfRh?=
 =?us-ascii?Q?vqCO+e24TJOpTCJSZ8g4CbULI6t0CClWa9eVkWSBrwAUG5sxllBF5JfYM4Dj?=
 =?us-ascii?Q?EZRy3P5uQts40nXhPcz4o9hhQ65LSqRcCr7Ji/WBq54sVB+AGmhqTg+vVRcv?=
 =?us-ascii?Q?pWUMshZoh1U6mLABIWEMlYq3HEOJgaj1idwXGv1b+kUvCiMKOcithb7CA9kF?=
 =?us-ascii?Q?wG8LdjqHmPRZLv8N6C8Ag78x8AR4XDkkVrEoruBvnydBOIUw4bInyaAit82N?=
 =?us-ascii?Q?i000f2xcCJo7MDIdQyh5ZuQmiFF4mPLyNvBz18ZqknFsn9dyivFuXlC1lRgV?=
 =?us-ascii?Q?GvurKNyJ31XivEvz4x+qyi67Cfz3OqMfpwfZGjBVEieGdD/ipwTgk8z31ibt?=
 =?us-ascii?Q?I2tUXFrxcea54uD4LNBxg/0+Oe+hvaJhsg7rrFmL+PTwsziJe9nurk96TASe?=
 =?us-ascii?Q?pmFg5knjf29j6O8GH8LQxIYY2UwFKO6ZZM2nLbkR0IYID9RBBARXB88SLVTw?=
 =?us-ascii?Q?XXWBSlQnaxq9gk+MNaFF3Y1FVP+YF0HBcQqGiA/5369FFt9qJQI9a/A0KBi5?=
 =?us-ascii?Q?y6FWWdJLOjisyh0u0SQLMfL2uw0RKqieB9LkM4ywC6+o60oLdwam3ucBiUjQ?=
 =?us-ascii?Q?XIjieKRvdScQClXzn0bzhXBbsWzcLvZqj5ALVm2JhO6gr+4Xkf3MKrTThbAa?=
 =?us-ascii?Q?Ls0lu1pilGl2+sM3BEzHUQGm7jNJ5eHRt8GvgO8nr8tGnH3gIvkPqemSG9JE?=
 =?us-ascii?Q?L6O2uf7CvYo/3fc4QiZ/0o3pA0Ln5RKwbe5Gv8eGJVwcYRVSGJ6admxD81Pa?=
 =?us-ascii?Q?0eKpSdr5XFJ04JlD937v5V3cAzu0sU4+CqZp3TkNAdlEeHJpfyZOvqEDWayH?=
 =?us-ascii?Q?hQdzb8Lr8nNOxiMgioWQtIXwXDO4eWuGBDqbj6UVstQblaZNvRyXFOhd+FXb?=
 =?us-ascii?Q?SI0R9prZfRM0OpznXJBT0ZFnh9uImT+DAyU5lcrLkGmGtCjqRaWuHq5ojAqM?=
 =?us-ascii?Q?bwTUCItfEwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryGDXt5DuBnTqAm4BFzxc3GYez43rEGZFe3OftN6Lwt4eSrDrx39EtOFDxDG?=
 =?us-ascii?Q?i4FAvhJd76zT11iOaMZdONIZxWNhlcQTdvBUFxyweSUeRjtCSxLxVpCr3DMv?=
 =?us-ascii?Q?5nc1VB+R8z58R0v4Gp/KqedVNBpiyHoZyHdM3wNqKM11Qw0lvwjry/T/UNCT?=
 =?us-ascii?Q?ioT89v4tUgPKQMdKw5sEVgUJh29rAnNsgw7eooVA78GBqfRLMeiXM1LXOz/Y?=
 =?us-ascii?Q?k2HMGUdMGkT8HbWy1hysdkmsusXFR3IwwnVlE5MDoXfX61aEeqcpW+Aw6vxn?=
 =?us-ascii?Q?Quo3KIeCRTy7IslTyuCsWuo1yd81F4mqeUr7jaVl7B6yxpCkm76S00lJIKBX?=
 =?us-ascii?Q?ykw7RVNW7+FlYtUeCYoulUWYdPxiqWxdViF6H/7CKzwaLp7TjPKoDBI8WVnZ?=
 =?us-ascii?Q?26vsxVxouFoLCy0+4xowfwAPHWebteSi1E14Ys5Uxbl0eEW8AhpwMWaFujCG?=
 =?us-ascii?Q?b308ttC3zGA+iG50wS51Rb+DgxYMprVglVSNDE16EgWU+6sx2ZSigOTVN/Sh?=
 =?us-ascii?Q?fVlU6aZVQv9ihb2jmwLDHmxoYjpLG6YrzJZ/YCHp6YianSRGYaNffSMQ0CGt?=
 =?us-ascii?Q?d34BwZVb2Qt5IKupoLVd/WrvB9ryZvbEGwQ4RY18V72BAnaRtv0v9h9qefM4?=
 =?us-ascii?Q?sQJHheN8u406Y8dQcv7VHi7yFbh6s2Uv3R9eNtqjG8UtSL8WuUMc4OCDIO5c?=
 =?us-ascii?Q?ANbfjREkXHO9k26vgzqqwlWxWaTaIPiRjZuhfKmoZd9ergg0ycFAAmW15+Qo?=
 =?us-ascii?Q?SatDxrRquhSkSzt+3kvqtldWtWy5aevbeBoLennkSdfhNliEX4EVA5g2Z8VS?=
 =?us-ascii?Q?0abEU1JRFN/Ay944EMjnN5zaPBpcpbndpuMKZ1kxsGlcHJOE+rOFFep8sNoK?=
 =?us-ascii?Q?zGyV6zXBI4yu+YTzk+Z9mkRYXOgXql8pReBL7YNCooDHqdab07B9rIvRDQqA?=
 =?us-ascii?Q?h5qRMrtLDfUJr0Kslne5wqx8bcAIwMqvowSgxEo34nx5blUOIJ3JuOa2z8ja?=
 =?us-ascii?Q?nSFMoD+yVWh8Ek73jw/v29iEPpCJz/GQkylTXcnnKcTefukVMypG9eBjkDX6?=
 =?us-ascii?Q?OdAtUucUgcq5koXgsZ7wrHZqrRZP/8rmEWUZKEfu7n8CNtBuxMpUTrm/z+Lw?=
 =?us-ascii?Q?Tz5nIF8KZIyTY+R0fbywFu4j9biaY3ty1Gu9CJSn50xfbIQUB5pbc5K1Coa3?=
 =?us-ascii?Q?7z3dolzHg8C5mI0zBTm9rnnM337mNQTHCYuaR1zBSL4B2x7OkRrXGAoo8N8G?=
 =?us-ascii?Q?i2tLtgucusWJW9g1hW9i/gjbD9QTO0awAuaT+SakbJNQrXOs0maZp3y6wL9f?=
 =?us-ascii?Q?zdLiI53MX6kt4Gten9LxBhJJqxUo2jLoZaZjphT8XX3USItPQPMDGbOmGwvb?=
 =?us-ascii?Q?bjz3SURx+anCfktydtoH9jEl/Gp8uCFERXyk2VOjhlEN1xrhVnIpZOLBi1dY?=
 =?us-ascii?Q?AitUePjODCkqd86PBWYgKqX1l+O9+n1CKps01pU+A0uwE6wYLp35+IJWuOfu?=
 =?us-ascii?Q?UY99GWAGmPoMMxOn2K5zCu+fFLKsP/MBfAu+ogbaY647n4BOKr/KeqTqlkUd?=
 =?us-ascii?Q?NHxDAgZN9I4iKH2916zyZNxXX1r2uEQE56vn9s/+WQbFNeszu/2M8QIUtUzv?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AlDNR2s/TgpSujR5+7KM3uUCrh5/T8JRh6A/8ckoR4aCsZPbAETDTrS0CqvngRFT3aJbIqlIIOCLZ9jC6tDkU5Ze0C7mATUW2fClB0QsGRdB67Y/xpMdr6Esh4uaoZk3YHHZnG0j5hZe8b35J/RJRItAJA+FPfjuMVaO42HMm0R1wPomLOwAyNU7eynowLyoQp9cZChM/kS/+aZ0jzBh5N9iME7Ucf2r30+JYFHrdp/9FbOW1ak9gIBrl2fsJMhOBbOOzujZsiam0C2gg611Ofr+ZzlRCqb9Twn8Z4jvBYyMlVrsjje/OxHoafIjHbc9f5KjJUJOFOtgi2PNbKuvd2ylOIG8OJRENN1hps5QoUx2+7TCiKc2uU90JbMJv9QhyyBLb2jX8uMdoty7gjEK/Iro7A94qPgq8K9bvLctXI+r24tTk8SmUSq2YdSTAtoPBnQ3LR6PAG9zmWLtwKkfH0efpvy48LEZ0+YJfEokJ3jobnoNyO12nXPDAkW3Ufas8Eg3lgqt4F3d0tX44JD6vsjGd4i0BNzf0dsC+md6IQwaRA9tKbT0lELHSPp0RauCNv/dKeaC1FK5lgXSDS+rtSk8iUQIXg6OCqrNjrR4vGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f0e8a0-96d2-4e0a-bfaf-08ddad0cb4d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:33:44.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auoG50dk0nLRcup3i/u7hQSpwNmotlFXnF8mNyM4mbdmgcdnROVWVHgAfR77A4rYvLVpeIdi/JBGeAnFqfwWQdiTQQJkxZjODmk4dM5PIHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEzNCBTYWx0ZWRfX9/bshjiONogi 0J+/rM6rG8z5KFYsFTzNpgtvz9Q5C6OANLf0a4NNtRv/1iDsTSLQAt0m/csigTZy9E1uIL9ABLo ACFCHO8KvpGhy2f171ptXLM3Rpopz/beVqZCbD3KI1qPqynPrtW1Vx8DRgmrRZlrREfQL1Uz11Z
 QKBA5uomoplRhv8wIsQ0M3W42/siJe1jcB4ZCNeIvJneCIC9XxxD5GosyC9OiqieJBUMAVhZWkk sYWLAwTnubjpj7BkrUtA9iImstnEgZKLbGf5/OLenpvJ0aVCjk90W9q+WmcmdNfK6gg9M5TQLWr vnk0Fg/vLXPo95QWkdIvWJGYO3clOLIqziWFb/nBcTAaUnjarV41GpyxDFWaN8PvKWQi+Hdpw5H
 ikQy/obvpWbDB00oqz6fbRo+Kjg2j4IebJPdL639vVN0ldxvRG2tMi1ReTF7OsQJYa+Fkh6F
X-Proofpoint-ORIG-GUID: dXRrLocZ_whzHQ8sO4qq6Ecw3PMommYO
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6850719f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QJg4o-Cu8ZDUSi6hA70A:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: dXRrLocZ_whzHQ8sO4qq6Ecw3PMommYO

The call_mmap() function violates the existing convention in
include/linux/fs.h whereby invocations of virtual file system hooks is
performed by functions prefixed with vfs_xxx().

Correct this by renaming call_mmap() to vfs_mmap(). This also avoids
confusion as to the fact that f_op->mmap_prepare may be invoked here.

Also rename __call_mmap_prepare() function to vfs_mmap_prepare() and adjust
to accept a file parameter, this is useful later for nested file systems.

Finally, fix up the VMA userland tests and ensure the mmap_prepare -> mmap
shim is implemented there.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |  2 +-
 fs/backing-file.c                          |  2 +-
 fs/coda/file.c                             |  4 +--
 include/linux/fs.h                         |  5 ++--
 ipc/shm.c                                  |  2 +-
 mm/internal.h                              |  2 +-
 mm/vma.c                                   |  2 +-
 tools/testing/vma/vma_internal.h           | 32 ++++++++++++++++++----
 8 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 05e440643aa2..f4f1c979d1b9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -105,7 +105,7 @@ static int i915_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *
 	if (!obj->base.filp)
 		return -ENODEV;
 
-	ret = call_mmap(obj->base.filp, vma);
+	ret = vfs_mmap(obj->base.filp, vma);
 	if (ret)
 		return ret;
 
diff --git a/fs/backing-file.c b/fs/backing-file.c
index 763fbe9b72b2..04018679bf69 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -339,7 +339,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	vma_set_file(vma, file);
 
 	old_cred = override_creds(ctx->cred);
-	ret = call_mmap(vma->vm_file, vma);
+	ret = vfs_mmap(vma->vm_file, vma);
 	revert_creds(old_cred);
 
 	if (ctx->accessed)
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 148856a582a9..2e6ea9319b35 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -199,10 +199,10 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 	spin_unlock(&cii->c_lock);
 
 	vma->vm_file = get_file(host_file);
-	ret = call_mmap(vma->vm_file, vma);
+	ret = vfs_mmap(vma->vm_file, vma);
 
 	if (ret) {
-		/* if call_mmap fails, our caller will put host_file so we
+		/* if vfs_mmap fails, our caller will put host_file so we
 		 * should drop the reference to the coda_file that we got.
 		 */
 		fput(coda_file);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 93ee0d2d6f1a..7120f80255b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2278,7 +2278,7 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
 
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
 
-static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
+static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
 		return compat_vma_mmap_prepare(file, vma);
@@ -2286,8 +2286,7 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
-static inline int __call_mmap_prepare(struct file *file,
-		struct vm_area_desc *desc)
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index 492fcc699985..a9310b6dbbc3 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -602,7 +602,7 @@ static int shm_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	ret = call_mmap(sfd->file, vma);
+	ret = vfs_mmap(sfd->file, vma);
 	if (ret) {
 		__shm_close(sfd);
 		return ret;
diff --git a/mm/internal.h b/mm/internal.h
index 3823fb356d3b..a55c88afff6d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -165,7 +165,7 @@ static inline void *folio_raw_mapping(const struct folio *folio)
  */
 static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
-	int err = call_mmap(file, vma);
+	int err = vfs_mmap(file, vma);
 
 	if (likely(!err))
 		return 0;
diff --git a/mm/vma.c b/mm/vma.c
index 5d35adadf2b5..f548bede3bbe 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2582,7 +2582,7 @@ static int call_mmap_prepare(struct mmap_state *map)
 	};
 
 	/* Invoke the hook. */
-	err = __call_mmap_prepare(map->file, &desc);
+	err = vfs_mmap_prepare(map->file, &desc);
 	if (err)
 		return err;
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index d7fea56e3bb3..51dd122b8d50 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1458,6 +1458,27 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+/* Declared in vma.h. */
+static inline void set_vma_from_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc);
+
+static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc);
+
+static int compat_vma_mmap_prepare(struct file *file,
+		struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc;
+	int err;
+
+	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	if (err)
+		return err;
+	set_vma_from_desc(vma, &desc);
+
+	return 0;
+}
+
 /* Did the driver provide valid mmap hook configuration? */
 static inline bool file_has_valid_mmap_hooks(struct file *file)
 {
@@ -1467,22 +1488,21 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
 	/* Hooks are mutually exclusive. */
 	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
 		return false;
-	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
+	if (!has_mmap && !has_mmap_prepare)
 		return false;
 
 	return true;
 }
 
-static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
+static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
-		return -EINVAL;
+	if (file->f_op->mmap_prepare)
+		return compat_vma_mmap_prepare(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
 
-static inline int __call_mmap_prepare(struct file *file,
-		struct vm_area_desc *desc)
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);
 }
-- 
2.49.0


