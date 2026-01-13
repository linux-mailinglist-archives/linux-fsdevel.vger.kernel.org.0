Return-Path: <linux-fsdevel+bounces-73442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35333D19828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41319305F337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EC2C0F6D;
	Tue, 13 Jan 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImF7ktHy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnb+pJ43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE842772D;
	Tue, 13 Jan 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314784; cv=fail; b=ACOMUXrkO4A9EF3IM5wOKqEkWiPkIv8dAyXZtOiYC6sW0Gj77Kgz4l+fVR8FDfBKJesMHoCnwGlWekVm2Vw3JG7bsoeOP5GKv9PVr2UnxPiifR6I7QxcqdSvCg7W6TtscRUs5YZvEwElqhgfBaVAbCGYUPzpi2RblCISevkNW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314784; c=relaxed/simple;
	bh=2tpsIlzFRQ80YZsnxJbRNyE8eNZHJFkI18ha9RN6d1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frglJhuf0PCbmumeCRjt+FqX3MvFLa2ZBqysLM+lv3AHLrolI6f2T2WrT0JnNYXcEDlf4Q67BtxdHcIXRJ/Ysnf/RXYeJbciGfBpj7KCiOwR3j8epn7mSHlm+mocxmG3u8QUpLfnPYq6xjiXhV27g1b80rcsfZUfsDjYMHrVQUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImF7ktHy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnb+pJ43; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gh0v2419471;
	Tue, 13 Jan 2026 14:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i2rI8MDoYJrAAd0fLGuxa+lo7Iv4HeZULdwvtF30uVo=; b=
	ImF7ktHy435mD9bvPAtknaSPcYVRmHdhtNXVFM/03JfIw/uBXSuwO5fLMXnsuUsG
	YBveauZljNtqJStPXqRISu+XEENqK220btJvCda9nkfJERhEQaaNY9Ee3JpGshrH
	7D67Iz8xSp9HoAsOVi6dBnMGfH0FG72VIWlbp/EOEamwLw7kpkgxeOK4sSQ3YyQO
	YR5GGuSZDhSzLsgxI0gUCzp3KAnLOTzhnAmTBqAMpS48Wzteit1WujcxND/lr7/c
	TbhfmzIvCcE2fZRwoMXtyHRrmwIIHtcUaUBVzKlgewh1Q9XKul50HIgWBTqD1fPA
	YCsJ56dOZ7iBo6AB+PDUKQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3ugwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 14:31:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DDpSLM029121;
	Tue, 13 Jan 2026 14:31:35 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7jjc0g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 14:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKZ+HEYuQ6WXM68FkIyKe4idYcb3TLxcPiSLFrrMChi042JMHGGe+maB2TraCFk7WdM5TheyYzjuIxFQ5dgdhybKXlLX1AjnamjhGn55AwET4NEZJAnQR5Q26v6OQdoAi+qT/+G2KulNM2Vfq1jFS2mSUFwfNoM8VQyJ7U3XBoqw3Pq4s14dg1DGQCVZGB/291eF9hpSbL1IHvoME0W5o60qJZfM/1DjoSgP2djLA/QFutlZoNDQVfuhr8GDUHLGEXfCtrWdHoYBRzvJ0hSxWkTncJUVHWeTiFjE2NHNwmR5L51vx2dkrB9o7lzEwh16vaTV4NP1WW6FkzwUp5LOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2rI8MDoYJrAAd0fLGuxa+lo7Iv4HeZULdwvtF30uVo=;
 b=p/8KAvVa+9gMnDqjns2oN/FaiCIREWvhSLL2glBD1gEL/LW4NI3KIbBIOr4jHplsWOpcp1HxBM/I0QU9ffxtPMGT0TLm9sHjDue/qYDaA+9ol5lHRCc1zkb/uhDtMFZgpQJEoQ/mC0bwVyun8R/URbX1X7eJ60rjI2IbC0PqdDroFcFXo/bqXp63HqZ4tLzTNpeudishkrl7kEmgVur9drDyZPFmyEahePWs/JVygpnZGogZS+ljy62kWnNnwmpdK7BjQFwTDbHZohtyVCer6INE4IGznE5ryK9abS70jmkOfpJC79moL1Rvb6EmZtdw3d0ovjbaknvwq6lBJuL40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2rI8MDoYJrAAd0fLGuxa+lo7Iv4HeZULdwvtF30uVo=;
 b=mnb+pJ43SRsOGdoHpkDXakg3fGsnRyo0YwXJ0ctn+vqLzyhQsDe3D1ocUa/JUU+ulL+rwtVzlDP1wVCNQhijQADog4ybTOd9154LOcTFZE4siWp64IypvfXjXyEnsm2F13SN867sLPnQUNwzrk6aXA9VfLWwJ9JFzmYne2io4l0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7458.namprd10.prod.outlook.com (2603:10b6:610:15a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:31:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 14:31:26 +0000
Message-ID: <78a5971a-822b-4eb4-9c3d-9c1011c5b479@oracle.com>
Date: Tue, 13 Jan 2026 09:31:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Christoph Hellwig <hch@infradead.org>, Anders Larsen <al@alarsen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall
 <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Phillip Lougher
 <phillip@squashfs.org.uk>,
        Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
 <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
        v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <4a38de737a64e9b32092ea1f8a25a61b33705034.camel@kernel.org>
 <5809690c-bc87-4e66-9604-3f3ee58e2902@oracle.com>
 <594043c04e431992f6585d7430b39cff2b770655.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <594043c04e431992f6585d7430b39cff2b770655.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: a81c1f90-1115-45f4-3e8e-08de52b06e96
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|3122999018;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a1NSdmZsMGVFTG5IcDBGblRWQ1p5blVRZmd4QWhRcFNxUEIvMHdWRXQyVWI0?=
 =?utf-8?B?WmczMm10UnVnamxYZDRGTU4xa1R4dWFhdlFsOUxwSTk5b2dZcG93YnZYSGZR?=
 =?utf-8?B?NjIxUVRJblIyQWg1NlkzQWdRNUdDalJqWGkyb0ZVZHZnbi94bzB3Q2d0eUlF?=
 =?utf-8?B?OFdKYTVrT0tGNXdsRjZwT0haRnd2UjdOeFl0V1BVZ2xZV0tJNzdXZTZsZXFk?=
 =?utf-8?B?VDJLTHV6TEh0Z0I5K0g2TGx6L1krUnVXdXJSTlh3WllTYmgwVXptbFlIVGhS?=
 =?utf-8?B?RFlZWmdsYTRpZjEvNUx4S3NiaFNKVWdFSG1HZkdaOVFURWtuZnlVK1BaeXhi?=
 =?utf-8?B?NkZySFpaWk9jVkY3cndJVFpqL21kNUZTemNTaDZyZmczcjhJdm5IdlptL2pY?=
 =?utf-8?B?dkNTTmNSSWNLOHJFaUM2Nlp6Y3hibXQ3NENJTHN6WjlwbjBpZ2Z5dWxwQ2tO?=
 =?utf-8?B?bFoxOHpzM20reGM4Zzh3NHNxNUJ2aXJ4bWczaFhJaFI3d0lkLzNCdHptMi80?=
 =?utf-8?B?UnNYSE12MjY0RUtiVzFwNlFXdnJQREx1QW5YOVQ3MUZXeDRjeStyS01WRnZX?=
 =?utf-8?B?Rjd0RG05UTFLMmZwMndWWDV2M2VmRXpPYkxLbWZ3bWxSZ3gybG15bFYzSnNM?=
 =?utf-8?B?RHNZZTBKOWloN2tHTXhNemh6aGVyYVllNzRqQ3JCYW9qd0lweHQ5ZU9tblNk?=
 =?utf-8?B?YVEzazdWYU9kczJTUm5sY3ErbUFjenlWYnpxMEE2NGJUblBTUUtmTlhGRmdC?=
 =?utf-8?B?QkxDQngvYlV5SjVrSHZ4YjkrTTEzWG5oSlJLRXhuTFA3c1VycGpieGVvZHpR?=
 =?utf-8?B?RitOS2o5dlVPWUNkSHhiZThEMS8wd0xEREtaTEpUKytJL2YzSEFndHkyZEdU?=
 =?utf-8?B?KzhEK0cwWXBnMXhYSFJMS3ZBUGk0OW1yWU43NmtRQzBYMnVVSEszR1BBb3dQ?=
 =?utf-8?B?ejhTd2pUNENrZko5SnROMUtnRTBPcG4rWGpYaC9sL0JERWFZVGRoYzhUQzRz?=
 =?utf-8?B?S2tHNjc3UnVleEdZWXdvSWFZYjlRUXdoOGFpSUYxTTdwcTBicDBJK0pPdGFJ?=
 =?utf-8?B?NE4yS0FJcVBzdWpWandud1hvcjUxMjM4dkNnNWNtMHE2TVFYdEtubE1CSld0?=
 =?utf-8?B?WWFmVHlMLzlKTXRlb2RGcGdyOFZiWDNad0lnbk9Ib1ZmbVBwcHdTSUVkZk92?=
 =?utf-8?B?VEdySnJwTGV5d2tvdzVpTXhMSEZkWlN6UUo3TlRESEMrdGY2cllHNWUzMlpx?=
 =?utf-8?B?OWNEUllsSnE4a05UMDhRTUlMNU9veWl2Y0Nsc1lPWTdVWkRSL0RCZmdGTUxh?=
 =?utf-8?B?REJCdEF4ZkpyalJJU3l5QUNoOEdHMzZOOXVOYWJPemdNUVJyRDdXc0VHR2hq?=
 =?utf-8?B?RTZ5eDYxUnVRbmwvTENTaFhZTmI1NSt1NXFzajVMK2ZDNnpSR3VIWXJiWGp5?=
 =?utf-8?B?M1VFeWhQMmhTNG9IcDJIVXB6SlNld1RoSkpGR2dnVklRbnViajBGRUVWQ1Ja?=
 =?utf-8?B?a1I1bit3ZHNkVnM0c0wyOXZPVEhpTm9PRmk5YnMxMGZDZmJnQWVWNDFJQkVz?=
 =?utf-8?B?SForK2VYdTM3VWlVanVxdVNubHJSc2JXcHNUWnB3UWlwcXpWdXZmb09xMjhn?=
 =?utf-8?B?NHRRbE5XamE5a1hDc1lwTzhWZkIrdGZVa1JSY2tXNVlrSFhMZmZ1K3g3dElo?=
 =?utf-8?B?QTRQbm1Wanlqd29Eb0t6WEg5VVlWNitaRER5eTJyNnF0bVdwclhNR0ZyYzY5?=
 =?utf-8?B?bmdOUm9Jdk9MOW5TNzAzTkwwbE1ZQXE1aWsyYXpCZTdEV3VqL0lIaGgzV09N?=
 =?utf-8?B?SVlkNnZZNi9iTWlkeXRFN040V3BoNHJXeHczVlNYQm1ZbVd5TVdqRmw1ZzQ2?=
 =?utf-8?B?cEozOCtkZEJndVM4TGlPTG9JWHZMKzNmYjFCc1hGRnVLY2YxbUdSQ2dGSld0?=
 =?utf-8?Q?Urq0Wg+YWXmiDbo6BwEkIjoOgfKZT2k9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(3122999018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THZEQnpKL0d0Rk1tenlsbTV5MGRVdXE1ZElWNW8xYVlsek1abmVWaytiYTY2?=
 =?utf-8?B?QlJtMFFTY2czc0dpeXkzUkFaZmE0Q0xvK1hJNUtMb2JFUXg5RDI2NytnUE1U?=
 =?utf-8?B?WlZMZXR2ZjJxYnRIcXA0ejNpc1dtdnlQV0pGWVVQMGJkb0F1elhNa0NGT1d0?=
 =?utf-8?B?TkZ0U2hUWE5QT3czNHNGWjd1VUprTThVbFpPY0t6bDl2UWJNTHM3a2h0NjFy?=
 =?utf-8?B?b3d0ZldFVTFEUE1JWi8xMTN5QjYvcmY1dXNvcUwzTk10MXBRK3VvU0Z4MVVx?=
 =?utf-8?B?eUJiRkh2Smx5TmkrRVRHdm51MnVrbWx0dWh2a3B2UEllZm9iNmdOY2xIZS9h?=
 =?utf-8?B?TFNBbnFUNG5HZXQ4d21NdzRQbVZIZHpGZWNOY0tpV3QwYW9URFhDaU9CSUhj?=
 =?utf-8?B?dVhHcVZSOUVGSlZJZkN6ck52YlQ5RlBIalE1TEdtZ3pZaWNPclJOaWpqbUZN?=
 =?utf-8?B?TDJpWlFia1BtcmdFSGpOT0ZmTExPTG5GbXJMeDZnaFlKN3dMYkRRMlpYS1JE?=
 =?utf-8?B?U3h5eHV5WEJTSWNMaTJtYkIxK1ExczlpMnlSdjVIZHhidGxxeWQ4TzYwTS9K?=
 =?utf-8?B?NXlCZTVBNVZrUXhEQ0wvaU1ybU92WFdvRkFTaTdHcHRRVlU4c3NlNHNPRis1?=
 =?utf-8?B?a0VWNTlXNjBaTzdRbWgrNHIvNGJnb2JxQ2tiZnVYSFZMOFkyWkJqUE1SVyt4?=
 =?utf-8?B?UnJqSThkMEU0cUhJWHVuSXU0VG1hT1c3V0pzbkRZSkhtWTJDUVgvQjFqSTNJ?=
 =?utf-8?B?Y0p5bTNNalkvRVR4U1RSa1RNTmNFQVJmcXpETzFjcGptUTFpaHdNVkRNZytL?=
 =?utf-8?B?YXNOZlI5OXY0dGh1ZGZ6bS80Sm5wZG1uVGNhaG1mcjA1UDBqd051NURSTldC?=
 =?utf-8?B?K2hFNVJyaklJT3VkZWcvcjYySUZQYk9ZcFNNL09OdCs4WjdMcWVtaERxM0dn?=
 =?utf-8?B?OWQvL3BqZEdhQmJzK0RVcXRxZnJ4d01ObmkwWUp6MUFKaUNwZ2k4Z0ZiWU5Z?=
 =?utf-8?B?UHVlSm5GOGJ1UTgwQ2JFdGxCajdlTHJ0M1lvUWh1QXUzNXFXU256OFZKOG1K?=
 =?utf-8?B?TWs5N2Q1Sml6Z2NwVDBlZ0tnejRZY0Y2U1p3ZlBOUEFWcWE0bGk2TGdYUk9v?=
 =?utf-8?B?SnM2RWl4VnFsdG4zdlBGbWM4ZUNERXNsdHNSYVMraGlIL1RDZE5WaS83aStq?=
 =?utf-8?B?YkJ4QjY0aGhkQ2s1MHU5d1Y5OEFKOGw0eDR3TkpoZm9IdzZjeGlIMk5GdHBQ?=
 =?utf-8?B?R241N1ZMZEM0RVJaWDhNbXc5L3JUNU5UWmlwa2FXVng3aVFMNVlRaHNLTXQw?=
 =?utf-8?B?NG1lRmJ5T2pCNkRrVjl3ZjlDc2x6akFZSi8vVHZEM05hOEFoYXpJMlhkZGRn?=
 =?utf-8?B?c2lnUXpuMkxOR0ExRThWQnhMc0xzL2RMM1BNNUxncUR3MlkzSkwrZTFqZ1Nr?=
 =?utf-8?B?Q0kvRFlYeGZmbFd4eDJUWlhaakZmdGMyZFRvTlNPV051TWJ6QXYrWGRPVlIr?=
 =?utf-8?B?U2xPT2oxdXpKOG45b084ZkdFNEJnYmxhOGNzUloyTmo3blhNKzBZdE5PRTdQ?=
 =?utf-8?B?eW1RaFpldndveTM0cHhWb2piWE1zNWxhZmc0dnhOb2p1NC9Cdld4S0NjcGxY?=
 =?utf-8?B?SnhJZ2xiV2hDWlpORUpjNFVLbjVNOEZSWDV6MVBNNXVEWjFOa3F6WXF0Q0JZ?=
 =?utf-8?B?elIwazZyY3FTTUQrdjh3ekFqRmt0YWZUYkFiS2ZuRkE3QWpNZCsxYzRIQ1Jw?=
 =?utf-8?B?M1Z6cEdCSXd5cG9VNjZIWXdlT2kvRDVSWERxMXkwRVJuR0g2elJBOHA2NDVp?=
 =?utf-8?B?VytLekFwTno1aUNoZzhpaHgvZmZ2ejFIdktrOFZ4Mm90NGtGNmlFdmdYY1Zx?=
 =?utf-8?B?TWxxMndjZE9oMU5peUZEeG5zcittS0ovcjVvVWJCeENCK1lsYzQ3V0JqU2tP?=
 =?utf-8?B?cXlOcTFFZXo3SEVjTDFrcEhJMU95Q1dmWGNJaXJhUittQnMveURUZ2pINGxs?=
 =?utf-8?B?TzZ6eUltUFB2WEVORThWVCtZUE4rNGd3UEl4UGwvMTRjMzgrZDc5OWRndDJy?=
 =?utf-8?B?Mzk5MENyVVlHRms1MnhHK3dlbVpiOC94S1lkeGNudDlxcEozZFFqZng4ZEJ2?=
 =?utf-8?B?RENGWmR3RmM4NVJCQit6VU1IZFRKSGVCbkhsdys1VUEzbk1FNFE4ZEgxRnVk?=
 =?utf-8?B?TDRCM01pY2dIc3czZ2p4RWx4WVZJNTJlbXc2NndMUWZ4eU5CMXV6STlyaDVr?=
 =?utf-8?B?V0Z1d1p5MnphMGJUNnZGekdLT1A5NXI2bFRuKzJDZ1pvbkdWdXo5dDNBZ2hI?=
 =?utf-8?B?eFljcCtGWlR5UllyZFRSTUo5dStRdDlrVXBXTytIOHZLbkdiWGF1QT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eiIJWlHttY/qJx3ytiMOa+3fdK60MF15YMgv3Uwl/ktAYecOnuG56GKeoGtwGFqHricfZ99HDZdlSvPJlmD0lMPkE3IaQm75Cl/HkgoL4U3a9A8cIYudBm1LsrwiU5af0/kl31L+dpPZLdhDkECePPYTxEqsqhAZO4mPPyfVaGL5kDRwlXcRORvNGVdwSqCbMOcTG6Vx0chG4/POvI823h4nGqCpHvIX9pOBN0sYaBIeHjBXm+r9ZH5LfhPWdc0AjTNJsz3CQ4B3h0SWJsRJIMCBiF8em+GDhHAUCnXthVkmKxqS/97HBMzk6cDnAgosmhEBBfoKb3afqc0M4+c6hFbKcTcEpR/+SYeZjdZtZaaRjHItcwEYNOXXnmPwflAKAWzrA8GsMhzcy+zK5d06LOwu+LjoNd6I2lV126D1slLsYpkXdzf/+GsImLcE39dYCXbxOkF4xC54wkHYZyoNj47D7NI84ghHcmqeY3SfGpYUYcVAdgnP20rxLKTpGe0PCHXWxAFF/j1wyqjYi29zykgxIZl/ivY8C6lp+xyCB8GbLZNOWMUOU/w2KuHa6TgQmfA6wihc9r1FVuwsWvLNEmg0iTm302bWyXieJSEv5As=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81c1f90-1115-45f4-3e8e-08de52b06e96
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:31:26.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2obvMBvmshOkKBvJcurei0QbEuHojQ1DJCOb4sg0C4/Vfj3VNSx7bMaz5rH67xxL5zZC9JRsqENW0dCHtxM9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130122
X-Proofpoint-ORIG-GUID: CaVfWaufF1GohPUJrRW4uw2fy828ldqS
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=69665749 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Y791ZhcX_UeUQF-99ecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyMiBTYWx0ZWRfX9JTrv96ST5Xm
 iLHpa1T+1WDCRlx+N6AEDBgDIPWO4Np00xVIN8hUNCkEwmXtzbPlpru22iUjoTZcI9mbSzjp+Yj
 VXLdrvcHoThZAonpqSkLJPTzVtvjI1CgdR6i29RrT+SiBUtO9jyfAwrJi2I9DrC1oQJrCUKsjpX
 Sp6+xdCPPzVRSW5IjAeFDPCv+NawBfXnYW5IH4vuanrdKzo98mJ7Z5hA9hVVdPO1DnjVd3PnXeJ
 Osq2kApmIfWjUX8yK0wA11Sj8esrg97YyH+L7pC6CU9PQFYfkJDjMjcfaNnHhX3w2SYbJfls+MW
 BcFeBdzYn7H1UZDYKAxnfE6WRrBuW7V7i9RrovfM9CJbnhCwEcsjIqaYWhW1dubFJ9quXbCjyxM
 yE6rbZcfkcQL8sP4DYcscGwDv9lSLlq418xHrzxZtVZonikSj8/0MbmkQFYQn7eukYs6SpNSIuS
 vC4l8RKfY4rMTLZbTyOil0oynMMpLnRasYyL7Tao=
X-Proofpoint-GUID: CaVfWaufF1GohPUJrRW4uw2fy828ldqS

On 1/13/26 9:27 AM, Jeff Layton wrote:
> On Tue, 2026-01-13 at 09:03 -0500, Chuck Lever wrote:
>> On 1/13/26 6:45 AM, Jeff Layton wrote:
>>> On Tue, 2026-01-13 at 09:54 +0100, Christian Brauner wrote:
>>>> On Mon, Jan 12, 2026 at 09:50:20AM -0500, Jeff Layton wrote:
>>>>> On Mon, 2026-01-12 at 09:31 -0500, Chuck Lever wrote:
>>>>>> On 1/12/26 8:34 AM, Jeff Layton wrote:
>>>>>>> On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
>>>>>>>> On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
>>>>>>>>>> On Thu 08-01-26 12:12:55, Jeff Layton wrote:
>>>>>>>>>>> Yesterday, I sent patches to fix how directory delegation support is
>>>>>>>>>>> handled on filesystems where the should be disabled [1]. That set is
>>>>>>>>>>> appropriate for v6.19. For v7.0, I want to make lease support be more
>>>>>>>>>>> opt-in, rather than opt-out:
>>>>>>>>>>>
>>>>>>>>>>> For historical reasons, when ->setlease() file_operation is set to NULL,
>>>>>>>>>>> the default is to use the kernel-internal lease implementation. This
>>>>>>>>>>> means that if you want to disable them, you need to explicitly set the
>>>>>>>>>>> ->setlease() file_operation to simple_nosetlease() or the equivalent.
>>>>>>>>>>>
>>>>>>>>>>> This has caused a number of problems over the years as some filesystems
>>>>>>>>>>> have inadvertantly allowed leases to be acquired simply by having left
>>>>>>>>>>> it set to NULL. It would be better if filesystems had to opt-in to lease
>>>>>>>>>>> support, particularly with the advent of directory delegations.
>>>>>>>>>>>
>>>>>>>>>>> This series has sets the ->setlease() operation in a pile of existing
>>>>>>>>>>> local filesystems to generic_setlease() and then changes
>>>>>>>>>>> kernel_setlease() to return -EINVAL when the setlease() operation is not
>>>>>>>>>>> set.
>>>>>>>>>>>
>>>>>>>>>>> With this change, new filesystems will need to explicitly set the
>>>>>>>>>>> ->setlease() operations in order to provide lease and delegation
>>>>>>>>>>> support.
>>>>>>>>>>>
>>>>>>>>>>> I mainly focused on filesystems that are NFS exportable, since NFS and
>>>>>>>>>>> SMB are the main users of file leases, and they tend to end up exporting
>>>>>>>>>>> the same filesystem types. Let me know if I've missed any.
>>>>>>>>>>
>>>>>>>>>> So, what about kernfs and fuse? They seem to be exportable and don't have
>>>>>>>>>> .setlease set...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yes, FUSE needs this too. I'll add a patch for that.
>>>>>>>>>
>>>>>>>>> As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
>>>>>>>>> are built on. Do we really expect people to set leases there?
>>>>>>>>>
>>>>>>>>> I guess it's technically a regression since you could set them on those
>>>>>>>>> sorts of files earlier, but people don't usually export kernfs based
>>>>>>>>> filesystems via NFS or SMB, and that seems like something that could be
>>>>>>>>> used to make mischief.
>>>>>>>>>
>>>>>>>>> AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
>>>>>>>>> commit aa8188253474 ("kernfs: add exportfs operations").
>>>>>>>>>
>>>>>>>>> One idea: we could add a wrapper around generic_setlease() for
>>>>>>>>> filesystems like this that will do a WARN_ONCE() and then call
>>>>>>>>> generic_setlease(). That would keep leases working on them but we might
>>>>>>>>> get some reports that would tell us who's setting leases on these files
>>>>>>>>> and why.
>>>>>>>>
>>>>>>>> IMO, you are being too cautious, but whatever.
>>>>>>>>
>>>>>>>> It is not accurate that kernfs filesystems are NFS exportable in general.
>>>>>>>> Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
>>>>>>>>
>>>>>>>> If any application is using leases on cgroup files, it must be some
>>>>>>>> very advanced runtime (i.e. systemd), so we should know about the
>>>>>>>> regression sooner rather than later.
>>>>>>>>
>>>>>>>
>>>>>>> I think so too. For now, I think I'll not bother with the WARN_ONCE().
>>>>>>> Let's just leave kernfs out of the set until someone presents a real
>>>>>>> use-case.
>>>>>>>
>>>>>>>> There are also the recently added nsfs and pidfs export_operations.
>>>>>>>>
>>>>>>>> I have a recollection about wanting to be explicit about not allowing
>>>>>>>> those to be exportable to NFS (nsfs specifically), but I can't see where
>>>>>>>> and if that restriction was done.
>>>>>>>>
>>>>>>>> Christian? Do you remember?
>>>>>>>>
>>>>>>>
>>>>>>> (cc'ing Chuck)
>>>>>>>
>>>>>>> FWIW, you can currently export and mount /sys/fs/cgroup via NFS. The
>>>>>>> directory doesn't show up when you try to get to it via NFSv4, but you
>>>>>>> can mount it using v3 and READDIR works. The files are all empty when
>>>>>>> you try to read them. I didn't try to do any writes.
>>>>>>>
>>>>>>> Should we add a mechanism to prevent exporting these sorts of
>>>>>>> filesystems?
>>>>>>>
>>>>>>> Even better would be to make nfsd exporting explicitly opt-in. What if
>>>>>>> we were to add a EXPORT_OP_NFSD flag that explicitly allows filesystems
>>>>>>> to opt-in to NFS exporting, and check for that in __fh_verify()? We'd
>>>>>>> have to add it to a bunch of existing filesystems, but that's fairly
>>>>>>> simple to do with an LLM.
>>>>>>
>>>>>> What's the active harm in exporting /sys/fs/cgroup ? It has to be done
>>>>>> explicitly via /etc/exports, so this is under the NFS server admin's
>>>>>> control. Is it an attack surface?
>>>>>>
>>>>>
>>>>> Potentially?
>>>>>
>>>>> I don't see any active harm with exporting cgroupfs. It doesn't work
>>>>> right via nfsd, but it's not crashing the box or anything.
>>>>>
>>>>> At one time, those were only defined by filesystems that wanted to
>>>>> allow NFS export. Now we've grown them on filesystems that just want to
>>>>> provide filehandles for open_by_handle_at() and the like. nfsd doesn't
>>>>> care though: if the fs has export operations, it'll happily use them.
>>>>>
>>>>> Having an explicit "I want to allow nfsd" flag see ms like it might
>>>>> save us some headaches in the future when other filesystems add export
>>>>> ops for this sort of filehandle use.
>>>>
>>>> So we are re-hashing a discussion we had a few months ago (Amir was
>>>> involved at least).
>>>>
>>>
>>> Yep, I was lurking on it, but didn't have a lot of input at the time.
>>>
>>>> I don't think we want to expose cgroupfs via NFS that's super weird.
>>>> It's like remote partial resource management and it would be very
>>>> strange if a remote process suddenly would be able to move things around
>>>> in the cgroup tree. So I would prefer to not do this.
>>>>
>>>> So my preference would be to really sever file handles from the export
>>>> mechanism so that we can allow stuff like pidfs and nsfs and cgroupfs to
>>>> use file handles via name_to_handle_at() and open_by_handle_at() without
>>>> making them exportable.
>>>
>>> Agreed. I think we want to make NFS export be a deliberate opt-in
>>> decision that filesystem developers make.
>>
>> No objection, what about ksmbd, AFS, or Ceph?
>>
> 
> ksmbd doesn't have anything akin to an export_operations. I think it
> really has to rely on admins getting the share paths right when
> exporting. This is a bit simpler there though since SMB2 doesn't deal
> with filehandles.
> 
> AFS and Ceph in the kernel are clients. AFS isn't reexportable via NFS,
> but Ceph is. We'll need to preserve that ability.

Well I think my point is that "is this file system type exportable"
might be orthogonal to whether the FS offers a filehandle capability. If
it doesn't make sense to export cgroupfs via NFS, it probably also does
not make sense for ksmbd. Lather, rinse, repeat for other in-kernel file
servers.

Perhaps the "is_exportable" predicate is better placed separately from
export_ops.


-- 
Chuck Lever

