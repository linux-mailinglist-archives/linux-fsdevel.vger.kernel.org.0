Return-Path: <linux-fsdevel+bounces-53612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EEBAF0FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179BF188EBED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F1246BD1;
	Wed,  2 Jul 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2c2sAba";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KcuFIoiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9E242D6A;
	Wed,  2 Jul 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448169; cv=fail; b=XNsp4S8cL4KB3s8blzbji6T56szHPSyoGtxyhaOlesIPulZiX2sFNRWkiHmfwK2ixk84UPdz5veTKkf2Wf9O/2SBBFhyR/42Dbac/rbJwzMzjZ2xpeitDOdDBJuurBguVIfrthRJVFE9lwyCZXieAUgQj5Y+DAsNgkvG//zPmp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448169; c=relaxed/simple;
	bh=HgIgK8aHXhTALXG4iBrkaCSqTtjCNFe1DvnJbqsFv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HG5ztA66mfdQLutaC7bIZwUhFy6lGX3Ff9YadflTFbh/+1CH39yHG2sM0/JLXlapZ8M57voZuB1F0+SAKK7mcioWt4nwYv/P4wfHIV2woK/iGErkf8Qr9eHO6W7cZo1EASJYqlbEJtChWlZLlbhBgA42uMyJWV4W3Zrjo1Xw9fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2c2sAba; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KcuFIoiC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627Maco026819;
	Wed, 2 Jul 2025 09:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Uk1wUhdYeThkDWkkEQ
	QP4pX8OiFesVHtQvrMx7c0QPc=; b=I2c2sAbaVnSn78bjXTermNn9WPABPL6MNe
	2NFBbbumlxDFcAWXJaVfjzxB4H7xQiajz26jfwmQlH0ro3zdNd1csgchDVa2XEq7
	OyArlzLi8m4hvuGo7w7Gjm5IKwBtAocXoI83f+dvLzYDkzgr3g5WUwO71SG1yoo5
	gSvwPqUewffOwZp0ntiz30Qj0j+OdSsI1u94TXknWNERW9jlOR02TqhY0X4wdy9s
	b56ouU591yy/UfDa33LlsHh9xQls4zLMNEkUWhLtuApIB3cgW75e1AZoTrYbgHAP
	HnqCcBvqkmfgOgO2ugJV4LbaSNncd1oWec4bdYCdRYuOn7JNkULg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfeg9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:21:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56287w14020142;
	Wed, 2 Jul 2025 09:21:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uaqeab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRyrd5BHW68QUw/QvoncYuWk6uPMv7L+WY0Yb5UxUi6VUCuXkEwABxJ2zt6Kodk/mAkwOWx/1TP2qUtSMw3ES7kiptTupTR+e2VxX+/FIWTgpilCSc34GS7sDoO2hTfpPhHXplPnK/plY4HjTCGlRYgfdClyFGX0P5rrLFetvEq22EPh5SuVHN86KRj1TBxLq6PCBcMXBl+SzDx8IS/4k2CyR6Ja9mADy79Tz3EnPXwLEnnaNDRBLDscIR+b3Gz9snLgyHkXKFeXNDu8b+hgOhkJSzq/vi1l44Eys+pYJKmsG+sog9zKftog8GgQjjpv+wQZqBT+VIwS+xwH/yamBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk1wUhdYeThkDWkkEQQP4pX8OiFesVHtQvrMx7c0QPc=;
 b=KGrVbMpgaWAsw0ta5cdSg8Ug6GiStJldWXB6XFlXPD9I5p2cWx6goR1LE+/N7PLeKRmjPNHqXXF4Poi0x7v2lHJ3Zzq6mmWYQ4e0d6i2mVe1FOCEV8QYTSPjfe/mNPcmZ259X5JLXRkwdPPaqYKTx93jHnkYB8VL6DtWD0rD8qG2GlWn76BcVJsTUxaXQPIc9UenQe4VTYOLEV7ett7CGF5GdoKk+HIaOIvqgHqz4hpRr6mv/D+dF0e4tGEQN5VPltkuTzSbiCFFxFqyHnfsMXRAwl/8Rx9t9u3GieDYqoIMXd7bt7LqnYjIfw/iU1zHncK/EL7SBDQo8CNT21/9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk1wUhdYeThkDWkkEQQP4pX8OiFesVHtQvrMx7c0QPc=;
 b=KcuFIoiC7D5GTaZxh4drPehOSgh2OpWNqAY8eFZc0Fdr1bWXgNsKFAlqRrtEaMxMyXf7L9UbeVwa1q1t4oFA9dJP6YgTzrel1d+gTwyK2iDg6BIWCymGE9aNaqsrO3LnD133ADXsyDdcdxl98o9JP3Nhavf2efn9Jh9X+twetBE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 09:21:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:21:08 +0000
Date: Wed, 2 Jul 2025 18:20:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 15/29] mm/migration: remove PageMovable()
Message-ID: <aGT59rSpYmlEM9yI@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-16-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-16-david@redhat.com>
X-ClientProxiedBy: SL2PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:100:55::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e3ee0b-5511-410c-8b37-08ddb949c6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGjVJLtCYFvifneaVxlCaHh7zZOFvPCugUNL30GbGhfMj6eQSGEtkL2Paw4T?=
 =?us-ascii?Q?DDpiuqObqzAxxfpTDfM4cNyc1KLPEkJIvMqpMkjfn/LBMGYJYSSnWtTPstj8?=
 =?us-ascii?Q?q+H0noWXr6PUBbQNEDNURJ9LWkH5WcvpmSMm0LG4nwMEUT4LHd3uYQQfv2Xh?=
 =?us-ascii?Q?3NjIuClopm1JLiInbD/z/vVjSW7Z0EkfCbDNUsAWFUInvWmIcDLh0NpmB695?=
 =?us-ascii?Q?+2XFeRuXXrnvZ7PxsRWbRfKkBxNKAY6osW0cBztulHVDcewlWtEt2ObIdXXN?=
 =?us-ascii?Q?JTV1uNmf++FWnxMaMpnjiz/BEZ8Led9rKO7FmqRuSUrl+OPIjWwTZEZoTOHr?=
 =?us-ascii?Q?IQbf2S948d89H+bLrtu+IxTu+TbR73bsooR4Pf14BbZ7MWVSdCkDvBnCgInG?=
 =?us-ascii?Q?x23kGpydAJmoy9yxgcvKF6Y9d6hnf7XYcgruW7AXr/nPeP4pWXHXWMyKgCSY?=
 =?us-ascii?Q?bh24oW70XvnkPtNaypDN8fom3ey8yXjhjxOk1H+ocrabtqqwfD5+oguPx9Ew?=
 =?us-ascii?Q?9YmRNuMLWL7zdQvqn0nHOkzEhUp22Sa26It502NhfgPYsikKQILk2xOLLmiE?=
 =?us-ascii?Q?jm+vnfy+KlAU7FljpU01mImgeeg2riAwMr8a5kcGJLGDC1nrCGwVqgPZNl44?=
 =?us-ascii?Q?q22IWq78i7h8fHc9wjIpPwiqzd4gJ1ctVMmH7f/J4Ucusu7yhSGUcs39AZME?=
 =?us-ascii?Q?uSAV+WKS1oMLSLeiqOkQ6Al3tDtzntGxStQKX/FTyy8kPSpZFgCFuGNbPDG9?=
 =?us-ascii?Q?8Ds0IdSvTgS7lPVrAAFfIA71WHjb6fO83g028gfYkXXxXaqeXv8xm3I2UPQZ?=
 =?us-ascii?Q?XYkYbpa0NHKgip+DcvXXhCIG72r91wNzLNqx2X0bsaHAZXdXcu03ePHUyWBW?=
 =?us-ascii?Q?eaq93p7fow3Ymae5Rnh+QhFxm6dSB+UWC0mWg4IF+IyizYJcfqgcIflBGzms?=
 =?us-ascii?Q?flGXJbYC8fMFjgm6Z4V7TslkH28GjIDIaseowbD6OavaRsBkZ2UNdjiXWz+x?=
 =?us-ascii?Q?V+odY8mIkpDD8VVgeQ2eFUhRBHRWoyQthJ66akQTvUOtXv9owJADlXRofwOA?=
 =?us-ascii?Q?lvwfKM+MmUbeifs8vkMfPKgIsrHfMpJmdsjmnZacKFlaBSKBmrV/Y17gwq2t?=
 =?us-ascii?Q?j1Uc/CufnVg6x00d/qwW5R9iZy84U3ajdGmFaVGeqIACRecT+Z8fNuYvkUVx?=
 =?us-ascii?Q?2Ncb/PIJsrtKQj/OF37Jb70fgDPbdb0FcxRCcXEf2C3bLXL21/sdvmSbXPqz?=
 =?us-ascii?Q?B0irTLDLF7pj60iqjaD4Al+3dA+EB78day217W8eWc8QRfVEnnElYDo5P2Vx?=
 =?us-ascii?Q?LO6wWmGqD6wD8WqdHfWJCQGcX7m+njBsTPTIXDeJ+8Tqc+RMQrNqzjoTYE7W?=
 =?us-ascii?Q?a+vLA7jFx+Ox0Jxu2Fxskw8c5PNqfN0XiOn0vPEqLDG2srurw415lWJZvl+S?=
 =?us-ascii?Q?6zP+3OaGVkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cRk6PwsNAL22s9EkKA0SdZaJrONunLw7k2jvJs5OUqhSGlXU9nZGUQKbLOz0?=
 =?us-ascii?Q?T72aYixffhV7Q7gyK+A7W/UzDqmu8tNOLDArSzLAG75WEJi/DQqvcz4sBBlF?=
 =?us-ascii?Q?qVEJaJvyBd9riTy4qDAk6StxWW4M1kgFx7NFblwP6aK6+JJvyxZWgBIFYOOY?=
 =?us-ascii?Q?esN4+v/4hb/rPxRqj6G3L3WfSX+UV8USabPOKozfueHXOZ7UyLq/DW9+vci2?=
 =?us-ascii?Q?p6OkvgRDlR4nEQ4AAyhPrzSy7E/n/5pveDAgypvwiXkY+uRRHRN8bZ1XzTNc?=
 =?us-ascii?Q?rEphPE7nYdAvdWdNvUf6qQaXeBVhqgWdJgqtUsorF4cBUtpSORHifAnkCLAi?=
 =?us-ascii?Q?oeEzWYyzqhN6vsU9xAREMnL/8aCcBjGmbx73Hhk1Zxk6sfOOlrNBKw8vvbfk?=
 =?us-ascii?Q?q702GMJroHFk03vCm2xpzRfs0+3XiLG3Zvnt+541AEMiNHezVDM+WJtfufCX?=
 =?us-ascii?Q?xBZR5+FLTX/ckGFmITYw+bvEyRos/efOpu6ydd8bSGP7tddnsdH1jv4yG7Va?=
 =?us-ascii?Q?/ypdu88j7VPqWmMTFd2imvm75CoMy08en0nfLuX4OcUAjvJEgXBbRp65p3G+?=
 =?us-ascii?Q?D5/gHd+sMqqEyx+sy7V4xj2kU0lNrYJbx3EvXUfzzVad/emmK9WP+8qz0Ckc?=
 =?us-ascii?Q?aZ5doGmsPp9UgRWXBqkzV6xdbq9eK5g2NM2UaVCxjrhMBSAh0envBQcorNgx?=
 =?us-ascii?Q?G71hYjIFypn+BD7hJBea4wVz9oSJA6LObP1VxkNxi96v5a/whwu+s5anXy29?=
 =?us-ascii?Q?Rf2N77K+n1hRi6GDF7vrqmxQMwguACjHABRHWjQL8XABsBTGp48Xo7EP2/l3?=
 =?us-ascii?Q?JzQNAivOWmBQVqoaiR2kmJ8SsHuuInN6Ik0dBg7qFQcajJM/S5/HMMeeI+DO?=
 =?us-ascii?Q?a5bmJsXD8Km3YQ6bxfPXoBdIyoQlX1fqSXyqOOmKwAIE6X0j6TCtfjD6dx2F?=
 =?us-ascii?Q?2n97rYh5m90l5o0bNHTJUnggsL28roRl1o4ANjFdh9vSNOODYc0yWwHYmVw/?=
 =?us-ascii?Q?t7ogaOcUKMwopUJvEhqvC+UbQVU815FMqM12ZEm89VG2XX4l1ulWn1KmkJaM?=
 =?us-ascii?Q?1SQ1I2cm1Pq+EIQnlnVHpqJDBpcujXS0mG3g9TIJmxs50zwaMWYhwsSKSO7C?=
 =?us-ascii?Q?wn664h3xiSOvpDC38Knc/Xgkkm/O/tQapbLN5aRWkU0Iib8MLoH82TIY0EqV?=
 =?us-ascii?Q?MhDlkXvUMQuediIIy6D1GNcZtn/Z+C3QN6OjlgfnYuERJmpJCSQGsbUVttE6?=
 =?us-ascii?Q?YBmCewB+cZ2zWELT3vS36EW8pFLGrwlk636NktGfCSMceJaxv5+xEry++Dl2?=
 =?us-ascii?Q?Cy780yB/wINBxaPSH47hxsIIauhKxS1CZ1jAy2PiZ+jdQYcArSORqdyYsBNh?=
 =?us-ascii?Q?jS/LRcEWZm38qAAt3yUiL+Cnqyduqpt0/d+z7QN0MU//4ZYvHmWbzNI+eiL0?=
 =?us-ascii?Q?UzrU7uMjvtaoynLQJsKA/GUzudSZ9XhGYDUrddPHaAnFPrCmczYsBtanS8yJ?=
 =?us-ascii?Q?7FRqePNyRou5+FV8UT0nqPwsTmxDpW1qfVGxQjC5MaG/dm9opkMtkq+W96QC?=
 =?us-ascii?Q?IRDYKlvMSHw4uRBi0WrfsZUhQaQOHPCMqbo6xiAj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SYk9b1J8tu5zDLu+md05pHgArmxOs9w3jBQHXSI4bctrIkwmoWddRmhn362KIleDDHPn739W84kzZM0PxbRY65+x3oN5xpui+/+MKySHbqvgiiM2kYRqRhRyi/1RxEViGm7HZKj4yZj20uNXBDv+Vq7gPw4mf2sauvdKUgQFTCCm+yPPVDTcLnhdD1v15Pp+vWKfIvpcG5h7K3e92LyEIakHnJfgXmPiz/x/wt9275Y2jy1MxKG+0FiA/99m62rdsE04TzYhQWV3tUo/2x1de4+PqFo0RD+WUyRSI8d5EHrUYmV+trRj6RrRABDdBkMdsHFW4Jmd1rZGaVj7VTN1EDgS8f2gBjc1deftpHho42hsooHU0viqvzArBJ18afTNA89rtBMZsMA41Mp3/ujW+G7in+eCWErMk7hF2eWucQTHjkriKPp/VHeDfF0OjxTikwfQ6PccLR7VMzym8tLb4ZpR0H0yHBVbhsFwnZn9BCCofzaMBBG0dEc9XZWZ/Q/Q/PdqT0kyw2Mp4JgA/yKUbcRv4jmbsgE1r3MSPwxhva7o8BuJmDu3USM05rafSAZYxkCpJlxi11uMhozIb6S/V1d6rFKYqHgTgfAp5pEjMpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e3ee0b-5511-410c-8b37-08ddb949c6da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:21:07.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keQ4qAF2m5hweLgjU8ZirczJ/aB8UlKqw9e2OicCpIkHhxs4lGSxJETgEuvJ8VzpQi73pGu+aVO6M72XCR+y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020075
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6864fa08 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=9T322LQyPR_6tVNZJNYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: XkQlpkeuqkDYho1QwArhDWlcZV7e0xMe
X-Proofpoint-ORIG-GUID: XkQlpkeuqkDYho1QwArhDWlcZV7e0xMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NSBTYWx0ZWRfXxFDDYMlTjB6Y ipToYpY+uuyJQ7vxm1icx/W9nPhIiXt1EgcMyPJbNAydUfP7S24r/4F4Mn/J2tVEP5Me7iEgeDM 4hg4dcBZ4Zy0nqkwyL3pf3srPdtsqMpPRw51e2vRJMoIebriG8Vlt3OBYtzbT58eXyJeLEHm212
 KLvHxHyc0ERh7XLueoRl+OSlxxKzUzFvFFmBZOM19OSrnbhv3uSrLH3NDn6XxxaqoXoHer9BeLj wYDX/0+XFoet4QhcHUJrokarGWYBFGD585wLX5x4LOf7Kvz9QkYMF3Kwv+4s+KBWlMhM559E7H+ WovllBfAzgmSjqUA4wITuk25cvBnK792iJkK2LQ7eEuVAmHvYSaLp/gq8MdvNIhYwaTqPn+JCeU
 gynZf3+fh56x0ugFmLAQ0wMzkEG3GymDfOfxyL1NYEwHIMBbppblpoq6dlJpxH/UaRY08dS4

On Mon, Jun 30, 2025 at 02:59:56PM +0200, David Hildenbrand wrote:
> As __ClearPageMovable() is gone that would have only made
> PageMovable()==false but still __PageMovable()==true, now
> PageMovable() == __PageMovable().
> 
> So we can replace PageMovable() checks by __PageMovable(). In fact,
> __PageMovable() cannot change until a page is freed, so we can turn
> some PageMovable() into sanity checks for __PageMovable().
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

(and Lorenzo's rephrasing looks good)

-- 
Cheers,
Harry / Hyeonggon

