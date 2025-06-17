Return-Path: <linux-fsdevel+bounces-51846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D6ADC1B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C8B7A361B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AB27E077;
	Tue, 17 Jun 2025 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlZsnJuj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jkmlhMf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D527E062;
	Tue, 17 Jun 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138268; cv=fail; b=kxQlL0+jNrOXfWRqJb4KPV0Mz2zU0gwdNtVMSYJZP9UQ4DzGPKOAXVMQaJfJXcWF09MmpUXWDTvfMjWR+JYXGkbctfMMbidWB14fGo1ncuL7n+UeuT5GfKrXCNrRPXNYnp7WMON3AItjI+w1IMR3GAGX7lZYeJjY4CYyyT/vEUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138268; c=relaxed/simple;
	bh=ROdNidelrgrpRvtHdRtJfh3Pgoc7JLVdnxJhjlsbT14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oP0FRfIMYT9hXF735xuwMEphiDU4jOnvDWLgkiGvM/xxZXinKvnETAkj0UjAtJJJr/kP/jIVaK9RFCZnt7arkfaGZS5V9pz0dd4PJpzMcU7ZKk8uiWRSmxGcAy4T3PbV0Jq0E1GME08Yy7QyKOO4lvfm3sYE2e28qYRpYotUa18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qlZsnJuj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jkmlhMf+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GLmtfS017890;
	Tue, 17 Jun 2025 05:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ROdNidelrgrpRvtHdR
	tJfh3Pgoc7JLVdnxJhjlsbT14=; b=qlZsnJujiUbKhuhGUFVb2xVkOENd1q2eim
	6T5NMWPvOI8icPvLF6mWjhDeeZ2sy2LZM73lLvOofMys5ga5t8aQEdAD34GU3p44
	Ddjywsw4OXVzsXgqa+jEuUlprlhVtpljY3SgabhrRgCe73Nwu78cJstoz5lzfMJh
	lkg/FgGGaTYHdwATDL13iadgm97HnzF4hSeExpszOYw+9+Et5C1Yd8g4uRAbP3ql
	L3gczGUanL8XWKyvgZ347lf6e3//YsorxUHeMHGhTEMR50NdVfy0ZOFwStv9BO5Z
	HzxfmpNH8XhRhS31TY7GXq2KknWmR24a3W/+iNfmLfReA91VY5tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn3x7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 05:29:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H2OL2G001502;
	Tue, 17 Jun 2025 05:29:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8sjn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 05:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtveZz32bFuSly1d9yXY6SfUc8F1Q1pcRQBdOtLSxXSva3GzQpvbts6Me0uXonC0GqNsqwqIuUxr/CIZMVOvXrudACOqQ/IW/ZBkPLpyjQr+II7xlRXdqFVS/dswI00xSrOCcIDh30rlnjunVQYSCZHmjLOEJi9Rk0S9iR681waI+HfJfIbI+0F0N596ZLTKYU6hR0382VV64aL3qVC/pPlY9hD5kP55lqCZQIH+2lmvFFD3Y0x8PDCKDKu0b59ESukhwwPOSV3jxfGyscdZoK8AItepdAsd1D8FpxF4wLGurKIW043dk/P2x790zBqq5Scx/AmBUBww76SSk8Wukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROdNidelrgrpRvtHdRtJfh3Pgoc7JLVdnxJhjlsbT14=;
 b=yhK3EGaCfBAJvgm08W4Pjre8f1BC/WiakC7tMuPPdwL5hhUHy5dwc/LM8wxNtfbctARmJRT2VHNEt1/UmFwxEVwrOu/dI/4aMpN4s8Q2bUL3Mpn9EV5OTwI0jn3L+JhUs1Oe3If7uJrNOgfIwGAnqcqqOq8jpNVgcoAP8HRvoXoOTPGPk2ZgbQ9RvF+cV+eFAsdkR9CzgjBNm6G4VXgCHaYC2nry18NLzpVBZr0vMC82KyHnIO/71k/gRMl0KJLYJOU1Aib50n70EM9YYSyzpSaZ8XVXoSnpG3in0QYKDihVmzZeiHO/onfLrXVPxC7Z4uqItqVmENorNv2gkQtS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROdNidelrgrpRvtHdRtJfh3Pgoc7JLVdnxJhjlsbT14=;
 b=jkmlhMf+FybnE04238lDIIO186NXnNBl2iD7XAi2whyHTR+iJ+9aZ4ICGEl8Fg5CpUcnPybKZnPqKQGClllAIhQcgoNB/vupZnSFEXF6HegKWZX56WA+i9ixeWeweb9M6Zb0sIrE8E6FhkPk46nJ5yKnbzp+CLNoXdag8StkGa8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 17 Jun
 2025 05:29:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 05:29:49 +0000
Date: Tue, 17 Jun 2025 06:29:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH 01/10] mm: rename call_mmap/mmap_prepare to
 vfs_mmap/mmap_prepare
Message-ID: <de93f95f-c90e-4bae-a1e3-150fb91c0c07@lucifer.local>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <8d389f4994fa736aa8f9172bef8533c10a9e9011.1750099179.git.lorenzo.stoakes@oracle.com>
 <aFD4xtpot22xvTEq@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFD4xtpot22xvTEq@infradead.org>
X-ClientProxiedBy: LO4P123CA0260.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 427bfea2-f44a-49de-8c2a-08ddad5ffad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t297ZeE+Qt0oPxY5uERLDtBA9evkzi6J3a1NvKaVmpnOYuWiZ94JKDNZoT5+?=
 =?us-ascii?Q?3hEnWslTkZgI1V52T7ckhkcMDiioC3I0ZzaU7XDg8EWLU2QA9EMinW4/VDbd?=
 =?us-ascii?Q?f1zzbZRofu7RvKOicotXbKfxtO4NKmtfuR3DV5OrLOoEQ5OWrUYA7qxjhIt5?=
 =?us-ascii?Q?e94TV9+zYhmm7fKXs103jO4tOHI5vpnZCtdPoDnFuE0bSthVbDP5qeh7VcAH?=
 =?us-ascii?Q?FCD8XYJ6gLuOp8D7na4BHIuzDDZFHZyynLlFXXQR/yjQzaN1OTzBO6MzmvFk?=
 =?us-ascii?Q?oI/IIu05t7ycnB5bBku0piNIGCqnyjWeHskMJlKl5DABbhuf9XuKDB70iql5?=
 =?us-ascii?Q?8QUV0hSMbiCxOz2RG89Ga4Xl1IP55nJ1sMMZluGDkQ84LQP4Oe4Tuiac64my?=
 =?us-ascii?Q?+oP58VMwHgLUBbhYLJGTEi4SlicVuSHvBsskkAAQvuzEs2Jnt+oMB0y7svqc?=
 =?us-ascii?Q?/5+H/vIK99xIFETAnJZjmDHhteHZ2sEI5vmaKJPfyqjljWFuwZFMLk8Ew3p7?=
 =?us-ascii?Q?ol3SkW7X7oXZk1OGMRW1AO6FGluJJOjvNeqzEZ6L3pIRq0OAyzddXZ1YtcPs?=
 =?us-ascii?Q?AG0A1p1+Htd0g9PHIuZHk/xTXhzq5h2IIjHxb+O6L1zTqtHs7Fcz0ZzrHS+x?=
 =?us-ascii?Q?zR3MJ97fQCwtbovwwoBChE/0mOFylK/3/BBEU5p5ktLqaSP5FzdTLQbPK6mq?=
 =?us-ascii?Q?uzhYbQSLPN7gngN80h7Y4GRMBbQMFEUWJIYDbN0lnlnR3+FK5H4HnvDKLVQp?=
 =?us-ascii?Q?YfI0FlQhpMDS2fU9U4fl6iawllmDeQOeQ93K6OYJDXlkP61Z0TXKcAfjX+XL?=
 =?us-ascii?Q?askDIZ3/jsbWJPypx2SwU2fcJ6LYY+kbnbh8NeGUShALA8wyG8TzJYhdPW1G?=
 =?us-ascii?Q?6ZSVMHkkCL4W0dOvZNXwgG8by4N6hdRpWK8QOwfD0mJhE58WBImgyZY5ucN9?=
 =?us-ascii?Q?d4TL1/uBjWjg3IaI5cIXJECkOlxF7q+WpZosjWnwh0obwfeMeQ7FGdFYje7D?=
 =?us-ascii?Q?uSl5+2GWnqwiQx6w3eqdcU0vAjSYX0XM2D7h6HNi980qUW2mQTy9OGa+2NmL?=
 =?us-ascii?Q?TE1uT50okpJkR+y6+PPHuvjqi9d1LA//3Ffb00ghaSrFP472w/rhzFxO8Jkb?=
 =?us-ascii?Q?GCAFnVwhyKR8KyG2iNjhzBHYRjLlLvwT8sjygvYjLMp3YulptTca0KeF8Qqd?=
 =?us-ascii?Q?RhpYdIqwjN8a3DVneghahhiX/w1fdpEthmpr8yx6K6AmY+f+MRmEefd0emA0?=
 =?us-ascii?Q?qHUd4FliV0ONvALafP4btnv4Pw6xAlE1JjPWdqksDyDdM/Iiq0XCrfL0tlx6?=
 =?us-ascii?Q?GX0mnn6cHdg7srEEMOqB45UgPvFtMujpS96bugJ+BI38HtLEFf317am1Jjms?=
 =?us-ascii?Q?nTp/eGWREhWBluM4FJUEPA+bMxoB3Nw2yQSLtFj8PQqATnIvOXoNvzDsNypm?=
 =?us-ascii?Q?Fs8U9H8M0mQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhoO+3UrU7CIEq/OAPy+x/H5GIBVC/otiH5AqoPa+dy3MhswWxcQwdyDmZ2p?=
 =?us-ascii?Q?l9w/Kyf2mxLhW3w0X2EmOKq2w37QBA59HvSJ6c8CCwDFqH5u53hX8WyrKXNf?=
 =?us-ascii?Q?uTHrv0NvQAZFeE7DvKKnikIuLugfX1sCvPHnoQJzgRRx7iJvNcAA/caKUIns?=
 =?us-ascii?Q?opKSHcnOa8gL2Ec7sp2cWwznuVOJbg9p+dG5hpNjK6P1Bf8Q5NmKBjof7MgT?=
 =?us-ascii?Q?d135sAWj+11WqbbJ14D4a20aD61KfA+ONWe2ZsNv1NtGzj1QOeWzT7Xh0QZE?=
 =?us-ascii?Q?oF+rh0c2Ufya4cvTZ5QD/lMHhrGctVdb4alKkmwDaj/7dwQP/NFn0GdrkoJ9?=
 =?us-ascii?Q?4p71PMBrzoqrjh81TXYq8K3tcj1Mx2sEzGbEQVoLyrRP5M7BguSXVTeP83Jo?=
 =?us-ascii?Q?RYINiiYm3OcX+X/s7PCubQYn24FLti64IfI5fi+m0njzJ95HggYcGLTY6so/?=
 =?us-ascii?Q?GOyXOGGWX3PwN44ddg8l3L+EcVgmrwQHugM39V84p1Lle1tWTKAozRmRcsMQ?=
 =?us-ascii?Q?PfI33a827T187X82Ev2lmb92XoVv6ywcQPNF9RFz9cduM2ysFZVtY2zcJRKK?=
 =?us-ascii?Q?u1uLFSjM43Ojxmhfc/9ze4FZn1qv7vpC/12LtD/yVbMECIzQiuiyp8kEQhF+?=
 =?us-ascii?Q?YfOcM4N36EoEHRTj9O1PmZuPvmXokfplqUHqCGo4louiJNflAi82dr+FKA6A?=
 =?us-ascii?Q?XRgda3dSFOmAbhx6j/5ZpWlp3IsK6lf3ew4mh4v22ARaEyHb+ncCF5GUBz1M?=
 =?us-ascii?Q?oCqxMSW8OSZ2PDkTjatvf2CeYW6NU5iSaX3pnjmvIDt4q9ea+jYI8t90bqg4?=
 =?us-ascii?Q?zaGx4FVdIunyeeCdts0I6LlKME4BMlbdma9o/OOG9WoujQuB75LBcUYc6rkA?=
 =?us-ascii?Q?sp3aWgHet72zE1Ol23flotfWIOm6SoQF2aH90nKSpBezK6B8hNca4j0Nxxqe?=
 =?us-ascii?Q?pg90m0H0NQummZP4H2XxIIONwsXuPvbqehcCmQXzJVDZmUbGVS22poDAEabR?=
 =?us-ascii?Q?T4ADg0+fFXsKYoG0w63G7c8JmBSwY2QZC6sd6IOYQ0FXIx6pS47YuhRjOhLE?=
 =?us-ascii?Q?hm/DSHn9sFDKQxGd2KByyjMEeP6l+1xNQoVloT1uRyWSl3/57f8pBkbfvLwO?=
 =?us-ascii?Q?haHCHi2M/vxOCRFPK2lf4PGYqLYPcnoCZTfu1Q1+eRXwv1fpHpWMeTPgjfFf?=
 =?us-ascii?Q?ilxyP28XxkRpTrLS4qGVVNIzNgtdpK+Txky9FdqvNsF6Ri89y24aXYbu+x3T?=
 =?us-ascii?Q?aBdkvnQjaILt3BT7hA2SYWhLT8HATL16LNxJIaLJepPnvXKjc9hB3iny6USH?=
 =?us-ascii?Q?wzuuZ/+JfwymiroWQZkpUC96bWjoLzPGGRtPVp2WM4/nXwvdD0rE0JdDhqrc?=
 =?us-ascii?Q?k6Rf6pAAiRd0ptBGy2NNewCoTP/qPt0hzYbH3R6jQnpMRsuKJIbEUeLkYRAh?=
 =?us-ascii?Q?FeAnZO+hyajBRrA46mt85qRTxiJWj/It2wwJ+kkcZ4JQ63F4cAJX21sNvGZE?=
 =?us-ascii?Q?Qd4j7LB4bFfXket0vtXTzm4vET0SDY/X39ERfqRZ+5JZiUKHQsrmgdTTKqeR?=
 =?us-ascii?Q?E8uWgADf+ur4B/maKIFUWHVFuKGHE7kMYPYM+LXqYuqlrCJeiFMnjkTEkVVJ?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PmvzkoCDcq4B2dj4qIGgDe+ZGukn8XOEap9n6vPA8EP9COYZ2DVAcJgp0uQH/GxmMVUvpkEFf+073+MxiDY+8Uuv/7Kh+iPICp0KNEFENl2PvmM7BoR/HEubygpqPej8yDEs5UyZxhLguapoojx2FP6B0W11pQLiOXP09xzO7YCl0f84MObfqrTMogC7L9xP0jfcmZ0Qrqdsx1kJk+U6gn2keQBaKWLYXbnBxMDMN7/gMpoZAN1HE79zsTArzcCMH6k/lzfBg+oOABENDL9vEdhdyHHS2qYgBTQyk7uFrDwjXnhVunhiepXDQEcFnnYJHYBrDNkSOnwp69EB45NNLSIVfVrRQOXSrBOSMF6x7wtN5EqmDXjO6FAkz0aVHgVhadVkQ1jDpt+VvEuG+y5tzNP8A7XOa1eS182/kY3u/liKkh4dm9yf3jtashlBiZBtRCJj7ckcm6U0fzSEVcTS1SXAdPe0jpj5s/170qjJKfP3ssy74v4gVv+Lf1/YHgnkNlJpHaB9Ui5TtTqmuGjf2koTiOP233yJiPLnjmZalikdVhKDcKbtAzR5ggukOMOuafL+K3v1oCdZ7qFYdR1AiezMpoR6VGfuejl/OnM0BL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427bfea2-f44a-49de-8c2a-08ddad5ffad1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 05:29:49.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUDBM99dexTVhNRyq6BCSdwGRV7f+gw25HH5FpCsFFa47M35UedAOzes2QtmnOa1I0kEOsP0MvOcoTVMtvYkH0CH9xN6WfpGtBreiOcajF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170043
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6850fd52 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=ga9ms1K9sbQnPafhHRgA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: 3QvVpi8zCBjW_kpV-PRY441S05BsPRKF
X-Proofpoint-GUID: 3QvVpi8zCBjW_kpV-PRY441S05BsPRKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA0MyBTYWx0ZWRfX60HJQX3JqUo6 NoGZhjfd1u+pIt+oEVLulmFyCS0C+Y/mEk0+QpolWFAaZnQSjhuzxMAD53gKnlNdNsFCmrPP0q6 egVl2JhqIpWpPBCDgAQnYGeQWMA5r7h5wLihkESLWOMmPd2shhSUXPcYGX6fCKyzapoJynqPEIV
 xkWA1nuwKFgoTCgPXOFYF9hWCdlEC07vOZSdiehJmYeEIAIct9siNmDqgBHLXYeUYGbh6J+cHeq a/a5I3BkBPrrUnBs7RATiSvS8Mg81R61srjOJUJeaioAoYxxck4kUyL28UfMtiafNdhOqhI3zJO ZKOTP3Jeu511zl4rOQgUNWeR5yrEiVCJtUvN8bRMB1dpi1mSkHyVIshCLkc5jHlVTrpsvwV4XP0
 v3mwSsqGBRg3lKvVNHlToYqNa8nWIT4VT1E4vNeFt2aGM2reTnqM4emq8H3+9BEOY35sitGR

On Mon, Jun 16, 2025 at 10:10:30PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 08:33:20PM +0100, Lorenzo Stoakes wrote:
> > The call_mmap() function violates the existing convention in
> > include/linux/fs.h whereby invocations of virtual file system hooks is
> > performed by functions prefixed with vfs_xxx().
> >
> > Correct this by renaming call_mmap() to vfs_mmap(). This also avoids
> > confusion as to the fact that f_op->mmap_prepare may be invoked here.
> >
> > Also rename __call_mmap_prepare() function to vfs_mmap_prepare() and adjust
> > to accept a file parameter, this is useful later for nested file systems.
> >
> > Finally, fix up the VMA userland tests and ensure the mmap_prepare -> mmap
> > shim is implemented there.
>
> Can we please just kill these silly call_* helpers instead?

The vfs_mmap() function now has some actual meaningful logic added in
commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for nested
file systems").

>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

