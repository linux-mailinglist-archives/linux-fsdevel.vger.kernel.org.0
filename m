Return-Path: <linux-fsdevel+bounces-73433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC6D194DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3609930261B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645B392C4F;
	Tue, 13 Jan 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLlMk1yk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BFCHmSPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFB392B83;
	Tue, 13 Jan 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313114; cv=fail; b=KtZmcpqqlFPnkile9XRUh/BMFvsRmTTMlxXcvNCVBnDA6wlUQPPo4pYPmdwPYgD5hU41DMc44n+4u2d0gPPqTM3L3XEWOjhNtuQ4E1ud3ramNADLVlkwyUNcKNNpLXWsFQ06j0X8tX2BdcY0tfXy3M+yQMHUmuQTVkuxwYOK7aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313114; c=relaxed/simple;
	bh=iAXCLkmciiL/4IK33Fw5KK12ItcWjmIrTWNBwCXFakE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TRQyGQD2TbAgnGlzJqzdXubzu+YwHUwghN8yAdniKFqVX/1IKMhqq/2dA+zIqXbW18sY8OLH/KlMiHAIoVOyy+94KtXaz6YQL+d6mGw0uVyELfrlve3BxuLiFpe+xdLh8BUgjoBVwYa48DgLMCOrgRJp6Z4GdrAsapT5hfZ7aGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLlMk1yk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BFCHmSPr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gZwC2395850;
	Tue, 13 Jan 2026 14:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mP/g8UY32ndvOM3LKDx1ed8Dxn892wEzbwhdmJE7hTk=; b=
	OLlMk1ykanSrmUsKXyQJSp59G8drU7fTrANqMRkfkfDQhfIkSmo7xLmNiaeRX9ZQ
	PffYEXuKKjd4p8O4LgUEGYPvfUOXEP88/M8N6OaosL0faYlyex6PeOzHOYcelTbs
	g9nARv5pgj0bRNEWpl++TnJpmBd0bAnXtH2D1K01XdML4Fq+Kmo15sdXjyQa7a3Q
	L/Mp1EVuHc8hvxa/B36YJzruI5RV8ur0CCB6jmd5k3bJiz4WXBjU8EQwDrMheClE
	5X2InQi9aeIlgisFYA9AekT9GJsty6LvGfwA8DFREGfSH8+aXdFm1+JeMilxOVS7
	BSGAFzPWU17uxLflHV47RQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq53f06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 14:03:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DDbCqo032777;
	Tue, 13 Jan 2026 14:03:46 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78s9mb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 14:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waTBL9YNQ3eyQ1nK6upU4TFGAXXHkpC9jwzimvKa6AALpouovAQ8Wi2/47JQ5Z3oc/cVEZJN77q6wdBvLY5XFN4j8RWKua59PnZhxccHyeRNXU8bfXCkKA3BV+Ovw603BP5zXo2NlCHt5viz4BmNVqD8kUCJq3NFiBHhB583fz5i0ZSae7zzYpidlwkJvWWbb4nPXFro0AOrOHRvYrrr/6aZWq2FQdGoIZo8V+11H7R2gd+/WiaiHpXoTSeILN54FMxbrg9xfGkIrnANhS8lIFMJickQbpZqImD2vc4W43z3tyyX6l0Zmqi88VnvDd3RlF7UgwBXmWo9kcxEOGMX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP/g8UY32ndvOM3LKDx1ed8Dxn892wEzbwhdmJE7hTk=;
 b=Hl4QjcFzGPURq4sEALrKTX8hDKNCA3lxQUfU4LTBE/cJrV1If/dM+UQiCci+EOsM/uKpqUXaGy2INtxca4kAo0oWa4XVAAmCyDG/Wv5AaRQ2Ibmvv6hKHv0pe7l23PfFrrPkJ7hk/jrVMdwLZBIpefVhgpA4iijQfo/8aziCs3pRbfWwRE5c8o7YBSvFzghtikIRJ5wusTfGlGVCEKS7P8yuc23OczN/Bomqxx4DqBXvzAd6k5zy5sgJLXXyvt5Cm/I+aqNAOi5Ws6KErlQH05MfYE7JBOcuThqgXV6ubev4/dAa8PbCJruDz3Vv4+apypER6M5w2l0oomP4RSnS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP/g8UY32ndvOM3LKDx1ed8Dxn892wEzbwhdmJE7hTk=;
 b=BFCHmSPrNHFT/TaKzFSDYxSRsAPzOvCCBQeZz915ecABFjMZfc4QPF9nKpwxYMFTZ+rCiVhWysGCIxbV90QNcZYB3Yro9OYEK7UyAVp+ZfT3S1AGS0HkIUn5cJzNuHmjxvgppljl21iO2iZoyuFx836xGTQ2pxTAHofb9HZLvBc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:03:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 14:03:39 +0000
Message-ID: <5809690c-bc87-4e66-9604-3f3ee58e2902@oracle.com>
Date: Tue, 13 Jan 2026 09:03:27 -0500
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
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <4a38de737a64e9b32092ea1f8a25a61b33705034.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec1a10f-0ee9-4e4d-92fe-08de52ac8d81
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3122999018|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dUpMV2doUnZNU1BJdVpLTm5aRVAvUUVEUCszdTVXNEYzYTRMYy9ISHF3L1Ix?=
 =?utf-8?B?bDloaU4yai9aR0txMlVVOUxpSlRIOXd1TWt1Y1dPUFJTS295Tm1WR1UzbGFM?=
 =?utf-8?B?c3RzSTY5bTE1dmNzMXRrenQvYytFVllkOWhKalM3TS9HZ0tCNUNtVDdyTFNh?=
 =?utf-8?B?b0Fjb3d2R2VPbEVmUWdoMSsveTYvcDMzelFqbDlYSnFIM1NRTHQwOEdaeUdu?=
 =?utf-8?B?MlhDRUlMRUtBM0tXa2lxcHZ1OGYvMXdMTHpNZGhCdk1QOWMzaitkSDUvcnE2?=
 =?utf-8?B?Qkp6eVlZemd0aVhtTmZ5czFNN1Yyb2xKL2R4TjlvSVhVblhRa3hXaXB2b0h5?=
 =?utf-8?B?Z3NpZXBrWjFVNy9tRXZVbVVscHVKdjBDaWxJVW1MSkErcS9TVXd6ZHh1aXVT?=
 =?utf-8?B?dEg0Ni9IL1MrcG1MVStGbExwTW1EYksrcW1vQUtFQWd4RmFtaTliK3RscFpw?=
 =?utf-8?B?dGNJcHJrSnlGUDhGRmU3cTVEZWF4S3NFVFpaSmkyVlFWSHRPa3V2OEF4VmtR?=
 =?utf-8?B?SDZKVlg1bk5aZ3BOemYzWGwzODVlb1NNVkptM1NYd085TVNqNWNnVGFKQ3hH?=
 =?utf-8?B?ejZhQmp0OE52TVFDblYxNVV3WVNOM1hVTnVMcjZzRHhGM2JhcThzY2NPNmpu?=
 =?utf-8?B?byt5VnRPWk1PNVZ0elh0Qzd3aitQYkRPNkg4YjBsT0ZYZER3ZjY0UGkwVW1R?=
 =?utf-8?B?NmdMSFFWVFpEdHlIOHNzTjhtcFlJL2ZDby91dlJ1dU1sWmZjV3BtT2JkMVhi?=
 =?utf-8?B?cnlidG5VRWpFWTlGN0dLSmduRkY1KzNYeUFSdUVCK0N3OXpYcGthL1BmaDdp?=
 =?utf-8?B?QkplcTcwdEhRQlAydkhIaFNidFBFR1UxNVE4dEREYkRGeFRDOHNBM0grWGIy?=
 =?utf-8?B?bjZPOVk3RDhveTRoMzlYRHBobURQVVVGdHhYT3J4K0pLUEtVeGxmY21jeVFR?=
 =?utf-8?B?Q0xpajRUbFZtaFdTZnVwME9OTU5QNVZFUkh3eHU1d3VwZlV6YjUzOHRGYVhh?=
 =?utf-8?B?blZCdUhXN3Q5U1lnVUxUWmpRZFhQaFZsSXJlVXhwTVJDOW9yaDUrSEUxY0Iv?=
 =?utf-8?B?Z256Um1lS2ZWdWZlWGRLcU0rNEFPaXVIMXh0QWlDczBjdjNObnFDcDFjZmFM?=
 =?utf-8?B?clM2b0thNTgzT2N1UmxhU3lDUXlzN2FkTHVUWVFRdkFBcUV1TjNlWGU1Wktr?=
 =?utf-8?B?RnJGS3hHOGMxVmpYaWJhWTF1QTNkeVVMMFdvZ2E5aUJSZVFxV3lXWHFlS0Nz?=
 =?utf-8?B?emVZZE41ZER6bVBZdUE4di91dmoyVmpxajQrU3ZPQkN2ZmcyRmh4UnVpUmlC?=
 =?utf-8?B?anliZnFzQ1RGREpzZjFGL1RJQ29sOGc4T0FXY3F4dlBaUi8rZTdQckprUTJ5?=
 =?utf-8?B?ZUIvK3lDZGh5dVNxYlpSejgwZXlqSEs3WVU5QTY0bjlkQjdvZ0o3Z25ZaDN2?=
 =?utf-8?B?SjdMSTl4ZHZ0WHdCN1Fja1dVZXU1SDVrTndrYUF4VFNHWUNXWnduL3c5ai9N?=
 =?utf-8?B?MTJzUkJ5cWZUSWkyUDRnUWZ2cVgvWWl3Rm0vaFVkMW1wVlZGbjREaW03WU9O?=
 =?utf-8?B?Qk1ibUhnMVRIQ3JROWZiRVhxekxIZG9FQktoOWFmRm5pUFZGUGVId21ZYWNO?=
 =?utf-8?B?TGpmNlowK002UksxRnNsb2xtb2F3UGZ1V3JWeUp5c0J0a01ITC9JRzRPbnIr?=
 =?utf-8?B?bkVsTzJteWhOM3ZOVC9HNEowajVXaGxTcGI1N0FoYWRWOTBVMEttR1hldHI0?=
 =?utf-8?B?NjFaMXJPTytsZFp0ME8xUlZaRmNvWG1Wa0p1WFVES3VoYmk5U0JPVXJXREha?=
 =?utf-8?B?MllId0Q2UkVCL3FENWk5UXFUNVlZdXQ2Y1piQmlJNDB3WXJsakZCZUtQOXdB?=
 =?utf-8?B?MmRLeWVvSHI2eVpGZzNYTm53enNhdzYyaHlhZ01LS0NKNndZKzlsRCtwbG91?=
 =?utf-8?Q?DzC7P+c324FkCWCbqJ0EqFBj3M/1Lt+H?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3122999018)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VU5LWGVwYUgzckRwZG9yeHZxVEd3WFFvZmp6WDd1T0NxNEhzSGhjd25MckZP?=
 =?utf-8?B?M1FqMEQrVXNMaXQyQ05aK0lXY0xEbUtLN1dKeTdZMVdrYVI1M3VicWdudGI3?=
 =?utf-8?B?MG0vV2R0VEpSM0ZINDBRTHZOVGk2NHNLd01GQ3QrejJYcWd5S25kaDN4L3dx?=
 =?utf-8?B?UC8ra1hJV216aVdpTjl3T1Qya0xoRFRreXJwVDU4Nnc2dTR5a0M4SmRFSHRN?=
 =?utf-8?B?WHlhbnJJMU9mRGlyNHBKNzhhaGYxR1E3SFh0MlU5SlhZSmRLWFFhV3djMTNj?=
 =?utf-8?B?SHRPZWpOUWtzNUk1OUNXMGx5cElKazdRZzExZ2NLUWIybklxVk1Yd2Jibzh5?=
 =?utf-8?B?NCs5SkVESGNWWTVxUm9sNmQ1dVdBaGsxRkdIcERwdDRoTUJvMWhIalVwUWUx?=
 =?utf-8?B?ZjJVOXpKeWJidVlPbUxJNU8yMUFhN0d0a1ZFSWt2dk9WYXlyMWowN2k3aDQw?=
 =?utf-8?B?N3pKN3ZZOWV1SlhCYlFPanQ4bzdyb1NqL0RkRWNTSkdrTzFYOFAyaUN2WXdi?=
 =?utf-8?B?TWRGTGw3KzBGNlg1OHFoUVkwbXpJV2d1VlNDVmdQVjM4dFNoSmRTcnFRcEpB?=
 =?utf-8?B?VmU1bklKd0NxRklxWUd3ZHJ2TzhrSWxIdit6WTZUNWVxQjIrVG0vN2Rkbmxv?=
 =?utf-8?B?dEM3N3dtN0EvNU9IU3dUWHNoUnVwYmE2U2hieWZaVzJMV1ZGZ0FNekJhRDFl?=
 =?utf-8?B?UFV4TjVVUmFjMWthTEhZdUkxai9reGhxWmhWRDczSnFsc2pPbEhVVVVoMURG?=
 =?utf-8?B?dVBhb05wbmpaS2hndStVZkJlWHNhRStlV0JVOUUxN0xleE9ZQVNMOHlpVzly?=
 =?utf-8?B?Q1k2Y1ptL0pYaG11WXFpaDZiWWlLdGZPT2tQeHRIVEJwUHFndE9LT2gvWDVw?=
 =?utf-8?B?M1NmMUhMQlcrb1VVVDZmcVdScEJhMm5YUmZLRGh1elg4a21kcmlJeUx1SGhv?=
 =?utf-8?B?U1E2aDVBZTM5VUo1dndMNHUwOFVJOVF5b0k2empDT3d1YjkyZ09ScXpydk9j?=
 =?utf-8?B?ZEVrbndYbjBkNkx0SGc3Z013RGpqR3BUbThmL2h0UmNnZDZDMVlxVnBtRUFu?=
 =?utf-8?B?TGxNbHkvNTRqTnJvS3IzRm14aEdDNmNIMUxYeUdValh0eTJySUF6eWl2bmhH?=
 =?utf-8?B?Q3ZMQ1duUTBqZGhSUnpsejZ5bk53NkNaYnlZUi81VUtmV3VCTkFBSTJ6SVFW?=
 =?utf-8?B?Wll4WjBWWEdFWEJDMHFNSHRBNHAwY0MvNkwzdnlOa29OUG5pY3lyeDV0UCty?=
 =?utf-8?B?MUl4WDFqc0NqdE1Gd2FjSW13QUUwMXNvaTN3NmY0SnhiYkcwd3E1UythaWdU?=
 =?utf-8?B?dnQwWFFseEd6OWhsRHdMRmQ3T2Qyek1JT3hSUGxOMHo0QWZTK2tnVjJZYTk4?=
 =?utf-8?B?NUkrQU1iSkRuYWprRnNOR0REOWdrNm9RaGk3OWdzT0o3L1ZDejdIZ1BBbnFD?=
 =?utf-8?B?NEMwN1dsVnVKcWxyREt2LzlWU045Z0JvR3lZbUVpMXVtZkpjem5nSHVON2hZ?=
 =?utf-8?B?VmE4T2lORzZXaUg4OVN3Z0VFMEQ0MURGMU14bzFPSnNUTFNxeDE1amNBb0pW?=
 =?utf-8?B?Z1pwdWZNbjFGWVdQTHVPbXdUYUw3Qm9WVHhVNDg0Z1JFMmtmeXE5SThIYzhs?=
 =?utf-8?B?dUFtMGFGV0JtemlBUmFENjRvN3pFWjNhQWNOcGlSa3p1a2N4anVBRlpiUmJH?=
 =?utf-8?B?VnFscjk0OCtjZUx2elRlaXFNa3BHdUNQT0thczBkWGExTmJCdXFQaU1YMnJP?=
 =?utf-8?B?WTQrNzVJNGpESVBDQ1FkTHRxY1B6dW9JdG5oek5FSzYzQ3ptYVlCT2p5ejBi?=
 =?utf-8?B?dW1hcnM2V3p5OW9CMW9LeC9PbitXWEwyd24wdVkwR05ZeUZKcm8yeWJjQ0Nv?=
 =?utf-8?B?cFdQOUdpb0Y0bDlsTHBXMG1nbVI4ek1BQXZJKzl5RmUwazdCWUVpTS9CajZL?=
 =?utf-8?B?V3hLZFBIUkc1bTJadUNZVytUa0o5QVU3bnBWNzRrVnVnNDAxQ0t0anF6UEda?=
 =?utf-8?B?Mjg5ODBSRnFFR3V0TFYveGlLYzZEa1ZYVXFFeDdsK3Z5c1MvbHFqdlh2RmFH?=
 =?utf-8?B?bTZPc0JmLy83aGl2TG8rM2lIdnlySkl1ZXV2dzdFN2RTWXd6VFZlTGRMVEtW?=
 =?utf-8?B?NDdtenBKY3MwUHhqK292WTdVaTNia1VGais5NTQxay8wZENCWlJNQnkwUHNz?=
 =?utf-8?B?eG8zQjNXWEIyMVRpS01DMmdYTUJBTFljdXhRRHY4aFVYeXhkQjNuQUFqVnQ3?=
 =?utf-8?B?VnVNYWlac0RXdlFQdzFjWC81dXF1YzlucTFzYkNPSHI1V2IrRTJqZTNrOFNm?=
 =?utf-8?B?MjRvOWc4eTRTdVFiKzd2MU9PSjBZNkRJZGU0UVl1VTVUM1dnNHNidz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gjuzn59QpT9i3tuLtakgzssJ5JFrkVRjDPf//fE/pVrRMB9QQ3mS6vE6GUe2iheyeZDXA055Xwqvy2j4Aa5NpbeBM+t4JtTQR65LeWgTHlSol3up+l5LYL2HE1TISoxDq07kEShFGJtTR5N1adRid6HZ3JCTAz9uf1UqnTOGgSa9WY/SK1KKEhkiCtThdCVTg+SGkhmV13QiW4W11ix7A4YMIsLsnw9uxXzGa8MYmARvOLtJnvnCx+4BknTFytbYlcCu8idIch1uq9y0+O4GvouqR8IAFmmQ0jYJtlOyHDnHW9Ffgj1AmwwGSW0yz3mQz4DaEt9rEMKFIiH/3pTIPGZVgX5BDgbmObuXHaBa4ySb9iQw/OL7stuf4qlK04hESFGkCsx2ek5GuYssEH2a81FWWPEyHNnmhBfk0xK5OlcCrO5SOBVzktnNQM/Si/bC7mkp5FN0FpXQtqGKOCI/np5PToTkYPD/Jww7GqU6uxgyEVxICap0xJyMCDkM5jz9xxBfjVHvLbZR/kfpIOG5OoWMjBjIz4TBASzf4uEAItdUW3GEiHXzuiP+vzhJpOYdTwFJiYWHDjl1L/9drC/2tjCXOKJVioOtdoyLND7YKO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec1a10f-0ee9-4e4d-92fe-08de52ac8d81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:03:39.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGk2SXNN0FjDKmDnetA74beY9FS4bgv486Upczd4bUxd2faLluaNpjzaaTsnfE0+2g+Wax5DOjfhNiPF7L+bpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130118
X-Proofpoint-ORIG-GUID: 2YNEE3Tr-BYkU9W3QqbyBTutfIfueKeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExOCBTYWx0ZWRfX3JSZYS9RlbVF
 idO5zgTdYUc7eGw2FuOzKzZL7T+NIHez4Y1TabBnRpp2YVb/fDbkNIGLFJ45GRip2J0k0vRT9m7
 s1CJzn/Ry0vIjQMoHEc6I9/vWHCMJgokJzMNaTOi4NRXvVR/h4LaRbXf7UwgWEArR7PaYx+GoO/
 +jkuYrruMZWUnXxnyHmXlKcR3xIlzs4QERX8FvGIitIY3F4OUPV2EA3JfX6+CpEocEPXmYVclTk
 Rs1TEsf27OQglg2T7gHMu5mqfGYEs1vmXjZe5u2xaDERL2j96y5h0cCI3dMLDGXo69P/dp3NTkl
 V2SwuR5oQfClJp/3V52e89tcjJV1cw+4JLE2zhFwHGBlRdUyF6U/daKbKOFFb/A91PY7FckOeXE
 tlK4w5Xpn+o21oRyrHkWYSzSpn/vCully62OLr8Oyp3x44P1Ba4lYZuzVsICjiUtivZpUGNm8rQ
 SwlHWOMmOT1LpJMtHKQ==
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=696650c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Y791ZhcX_UeUQF-99ecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2YNEE3Tr-BYkU9W3QqbyBTutfIfueKeK

On 1/13/26 6:45 AM, Jeff Layton wrote:
> On Tue, 2026-01-13 at 09:54 +0100, Christian Brauner wrote:
>> On Mon, Jan 12, 2026 at 09:50:20AM -0500, Jeff Layton wrote:
>>> On Mon, 2026-01-12 at 09:31 -0500, Chuck Lever wrote:
>>>> On 1/12/26 8:34 AM, Jeff Layton wrote:
>>>>> On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
>>>>>> On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
>>>>>>>> On Thu 08-01-26 12:12:55, Jeff Layton wrote:
>>>>>>>>> Yesterday, I sent patches to fix how directory delegation support is
>>>>>>>>> handled on filesystems where the should be disabled [1]. That set is
>>>>>>>>> appropriate for v6.19. For v7.0, I want to make lease support be more
>>>>>>>>> opt-in, rather than opt-out:
>>>>>>>>>
>>>>>>>>> For historical reasons, when ->setlease() file_operation is set to NULL,
>>>>>>>>> the default is to use the kernel-internal lease implementation. This
>>>>>>>>> means that if you want to disable them, you need to explicitly set the
>>>>>>>>> ->setlease() file_operation to simple_nosetlease() or the equivalent.
>>>>>>>>>
>>>>>>>>> This has caused a number of problems over the years as some filesystems
>>>>>>>>> have inadvertantly allowed leases to be acquired simply by having left
>>>>>>>>> it set to NULL. It would be better if filesystems had to opt-in to lease
>>>>>>>>> support, particularly with the advent of directory delegations.
>>>>>>>>>
>>>>>>>>> This series has sets the ->setlease() operation in a pile of existing
>>>>>>>>> local filesystems to generic_setlease() and then changes
>>>>>>>>> kernel_setlease() to return -EINVAL when the setlease() operation is not
>>>>>>>>> set.
>>>>>>>>>
>>>>>>>>> With this change, new filesystems will need to explicitly set the
>>>>>>>>> ->setlease() operations in order to provide lease and delegation
>>>>>>>>> support.
>>>>>>>>>
>>>>>>>>> I mainly focused on filesystems that are NFS exportable, since NFS and
>>>>>>>>> SMB are the main users of file leases, and they tend to end up exporting
>>>>>>>>> the same filesystem types. Let me know if I've missed any.
>>>>>>>>
>>>>>>>> So, what about kernfs and fuse? They seem to be exportable and don't have
>>>>>>>> .setlease set...
>>>>>>>>
>>>>>>>
>>>>>>> Yes, FUSE needs this too. I'll add a patch for that.
>>>>>>>
>>>>>>> As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
>>>>>>> are built on. Do we really expect people to set leases there?
>>>>>>>
>>>>>>> I guess it's technically a regression since you could set them on those
>>>>>>> sorts of files earlier, but people don't usually export kernfs based
>>>>>>> filesystems via NFS or SMB, and that seems like something that could be
>>>>>>> used to make mischief.
>>>>>>>
>>>>>>> AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
>>>>>>> commit aa8188253474 ("kernfs: add exportfs operations").
>>>>>>>
>>>>>>> One idea: we could add a wrapper around generic_setlease() for
>>>>>>> filesystems like this that will do a WARN_ONCE() and then call
>>>>>>> generic_setlease(). That would keep leases working on them but we might
>>>>>>> get some reports that would tell us who's setting leases on these files
>>>>>>> and why.
>>>>>>
>>>>>> IMO, you are being too cautious, but whatever.
>>>>>>
>>>>>> It is not accurate that kernfs filesystems are NFS exportable in general.
>>>>>> Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
>>>>>>
>>>>>> If any application is using leases on cgroup files, it must be some
>>>>>> very advanced runtime (i.e. systemd), so we should know about the
>>>>>> regression sooner rather than later.
>>>>>>
>>>>>
>>>>> I think so too. For now, I think I'll not bother with the WARN_ONCE().
>>>>> Let's just leave kernfs out of the set until someone presents a real
>>>>> use-case.
>>>>>
>>>>>> There are also the recently added nsfs and pidfs export_operations.
>>>>>>
>>>>>> I have a recollection about wanting to be explicit about not allowing
>>>>>> those to be exportable to NFS (nsfs specifically), but I can't see where
>>>>>> and if that restriction was done.
>>>>>>
>>>>>> Christian? Do you remember?
>>>>>>
>>>>>
>>>>> (cc'ing Chuck)
>>>>>
>>>>> FWIW, you can currently export and mount /sys/fs/cgroup via NFS. The
>>>>> directory doesn't show up when you try to get to it via NFSv4, but you
>>>>> can mount it using v3 and READDIR works. The files are all empty when
>>>>> you try to read them. I didn't try to do any writes.
>>>>>
>>>>> Should we add a mechanism to prevent exporting these sorts of
>>>>> filesystems?
>>>>>
>>>>> Even better would be to make nfsd exporting explicitly opt-in. What if
>>>>> we were to add a EXPORT_OP_NFSD flag that explicitly allows filesystems
>>>>> to opt-in to NFS exporting, and check for that in __fh_verify()? We'd
>>>>> have to add it to a bunch of existing filesystems, but that's fairly
>>>>> simple to do with an LLM.
>>>>
>>>> What's the active harm in exporting /sys/fs/cgroup ? It has to be done
>>>> explicitly via /etc/exports, so this is under the NFS server admin's
>>>> control. Is it an attack surface?
>>>>
>>>
>>> Potentially?
>>>
>>> I don't see any active harm with exporting cgroupfs. It doesn't work
>>> right via nfsd, but it's not crashing the box or anything.
>>>
>>> At one time, those were only defined by filesystems that wanted to
>>> allow NFS export. Now we've grown them on filesystems that just want to
>>> provide filehandles for open_by_handle_at() and the like. nfsd doesn't
>>> care though: if the fs has export operations, it'll happily use them.
>>>
>>> Having an explicit "I want to allow nfsd" flag see ms like it might
>>> save us some headaches in the future when other filesystems add export
>>> ops for this sort of filehandle use.
>>
>> So we are re-hashing a discussion we had a few months ago (Amir was
>> involved at least).
>>
> 
> Yep, I was lurking on it, but didn't have a lot of input at the time.
> 
>> I don't think we want to expose cgroupfs via NFS that's super weird.
>> It's like remote partial resource management and it would be very
>> strange if a remote process suddenly would be able to move things around
>> in the cgroup tree. So I would prefer to not do this.
>>
>> So my preference would be to really sever file handles from the export
>> mechanism so that we can allow stuff like pidfs and nsfs and cgroupfs to
>> use file handles via name_to_handle_at() and open_by_handle_at() without
>> making them exportable.
> 
> Agreed. I think we want to make NFS export be a deliberate opt-in
> decision that filesystem developers make.

No objection, what about ksmbd, AFS, or Ceph?


> How we do that is up for
> debate, of course.
> 
> An export ops flag would be fairly simple to implement, but it sounds
> like you're thinking that we should split some export_operations into
> struct file_handle_operations and then add a pointer for that to
> super_block (and maybe to export_operations too)?
> 
> This would be a good LSF/MM topic, but I'm hoping we can come to a
> consensus before then.
> 


-- 
Chuck Lever

