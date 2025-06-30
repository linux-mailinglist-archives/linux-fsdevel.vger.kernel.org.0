Return-Path: <linux-fsdevel+bounces-53306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E519AED545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD690175544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149D214813;
	Mon, 30 Jun 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NJ2jgvJ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bLikkfzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37A1514E4;
	Mon, 30 Jun 2025 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267435; cv=fail; b=lk0DUxHMATxq47L54hhD7AuTOw6t6UI8zSdgnmsQUblQ7BV6i0m8/52hOT7MPSndmpW5jI9nUqnJlcSUOGjJG8RmWBM7ZI+J/9qVOn54IYC6Euo6pyoaKkWyeEZTuzy5QJTQEQjF6kGW4veQnP3pPi6GpdrsW8KI6fxHsf4PKs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267435; c=relaxed/simple;
	bh=RnONHYIQ7OLX6uppRF6J236rIHKu+880LrLkwaq8ptc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rba/qPs0dwnGoh6CbVYK5ge60wjKWwhUomNmW1gUFo9RXb/L54EY/+DYOcrhlQflgv5OhcC9rJnATUESWMBn1D0fwMbBnKiq0F4SE6fk71kN3HceN/kHBgYi1oVg1Ae49ISl0nzSCfg2jk19Nd8DnuKLFCzskLnSWhEIoC+OCU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NJ2jgvJ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bLikkfzz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U0vfAQ019859;
	Mon, 30 Jun 2025 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Rmh3WDLfi8nJ7SlLDd
	TGXtKhZ6AXrxX1RN/2heRDw+g=; b=NJ2jgvJ8Gpgk2NCIzGc2ShFrWWZ/12DgRT
	NSwFSMFjCh4A4miUa8vEW0NYhUqhWmbtBCB/u7v7zh8ZVZH6w5tKCjHtS+qyx/kT
	MKxcT48eoSjBN7dW5CTdmDSrwk0Smz6+9PFAE2uTJD5Oz2JWxrE4bBznfQQG4mfd
	4g3r8Q7EUE/jDxoBBrpLzvhWU8kOxZ9o3zy4f4fbgx0DILhza6IGU3eSPeioyXyz
	bWHbFspNhLa79nJByrx/IGK4uLEnqRBMAOgAngRANrNFhSxBE+hNDbJcIoGCkn80
	7Tv9PEd/SD2WzXHb50mKUeZPy0A88gQoT4kPsZ0s+m1xV1H79wPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7049vm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 07:09:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U70KGD017110;
	Mon, 30 Jun 2025 07:09:04 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013034.outbound.protection.outlook.com [52.101.44.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7qwnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 07:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spedsfPTKofk6PnSNv2ax3vOhITWU5ZBMR2IYo7v/4Xe5mv+Xh+bRPUGQJKe2SZANHWpHnhyQwvLtgkETYDp2BBGWY8rbtvn3OM+mAuE4QazLjaguGHBSMvEgz0eBU411gkNx8YyUnywHatP5L8R5C3HekvrQpCEIb0JlY9xyGjBWnxIKvR5JXp4sEcbClGob0GKjV5f+Z5ALXNZH3/mxGqcFLr9q2sc4ujvEYsEwkGntUsJ7fNDsfIrHQN+ii0Wemgnztiff9u4WSn/xma1y8Eml7dEk+bkn3BBl4EPAsuQsJSJ+CVunRsiauVOFf8iLobc/UY9g10qkgRgbqJAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmh3WDLfi8nJ7SlLDdTGXtKhZ6AXrxX1RN/2heRDw+g=;
 b=SSyj0HzUpLI+tXudpuX+5d3k2yQnAC4auv6Th78ChVd1o/QczJLAXwO83ofYQrP8xTaMmatWgnrWRYpZAE9pd6yiZiWUsz0ErMdw1lLygA2xX0AvZVdkV0gjmDOYiFH30nUz8T/phztZIF7i0SyGKMjaIWs2lVBi2UbOtMwXpxPGX7o6uelagHpQTek9yqhh7c3uSlQlpcZfaOOLAOiAlCKUR7f92wLTXUeUumuSpjDXOpkyUUJHkvxBbBMtNI5+sfWcyHIxcpPmkcSdMPFnPxn6KTm+CoPeJdGZ+YB2VRd1KL6oSD42VCTXD/G1bZr7AGUCXCvinG+SaB5MD6yfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmh3WDLfi8nJ7SlLDdTGXtKhZ6AXrxX1RN/2heRDw+g=;
 b=bLikkfzz8pkJCUa2WYSG/CBcQC5EHV8918dft5Kq9BhIKopBjGO4f7wkQvLhhXzQ2ZfkETn7DqZZ2FNS7sKTJX2QFCel+EruJsxJMTzVg4Q5KOZ0lvj5MTldn8j89jufcuO3ErJfrVLrzuqYCA/iLWeIlemhWOF+eH+0X9G/Dhg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 07:09:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 07:09:01 +0000
Date: Mon, 30 Jun 2025 16:08:48 +0900
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
Subject: Re: [PATCH RFC 06/29] mm/zsmalloc: make PageZsmalloc() sticky
Message-ID: <aGI4AB8D72nOPQZr@hyeyoo>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-7-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-7-david@redhat.com>
X-ClientProxiedBy: SEWP216CA0020.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a9def1-fc8e-4bf9-153e-08ddb7a4fd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/j6vR2FDjcnBFIIolndJZhYrInNsZoLnV5c4LXw52GvrAY7dM2sLShTmwcnf?=
 =?us-ascii?Q?NaszaazbEapb2EDngDrg2WyzK1RKs/3rxLPkOwb9NsmuwHYEVZDpYmw9d7Mw?=
 =?us-ascii?Q?CMn+4L16dGOu8j3JZQ7bdv/kcCCb4F4hSi/mq18VvX664yYT7MdLaRvrrt1K?=
 =?us-ascii?Q?sf4LlKPaPQLvZx54YDzkXXDlrg/P5JH8sj7VNqJGDzOouFknRkt6Z6d21ulA?=
 =?us-ascii?Q?dx2x9xFQY7gliAWWXFk9TyNeuaC4/MBqNd0Y3SHnx1kP/CShReHtRCWoDVPw?=
 =?us-ascii?Q?Gq4gbkJPw5Bn0xdbqoLBmKraCjbQEHuR11iG2Dv+Cg3JZjBqznLm5zuXd6Mp?=
 =?us-ascii?Q?ykq3FdfxajVHkfM/gAYyQOmX3MSZBIHJuFFVMoJiek7YNcDYllaNQzNsUiiB?=
 =?us-ascii?Q?HR9xbmXQmMeOXflpNr8uRzN6XflmYHSoeWVsjE3q/Nw5xjiz48BwVI6L99xz?=
 =?us-ascii?Q?PG9faAxvkomv259J8OpuK8eXgDSOzuD3DIwv/xFdftOrrw7/XRxn2+86ehzt?=
 =?us-ascii?Q?EnXno7MmR2gFQ5Tt98SA/1rCyEgCberD/8G126tS79Qg+c20/NlmR0+fFQ/O?=
 =?us-ascii?Q?ewQ3IFJVSrWZYcnKJ/tjMsVSGjKQ7dPi+O2QeP3d48oEatF5WActJ+ILk9mF?=
 =?us-ascii?Q?e4BzSAzAZIvznxJvnbuk2p+HMWI/WlY+pGnjKiFwzBGmfDwGJFTp+Xl2Oe4V?=
 =?us-ascii?Q?7nUG/aMZpbE1bOrkz4oCuvzpC9//p/l5Ch0I2k/SgwOSGyOWwxcOO+u1BXDo?=
 =?us-ascii?Q?6AoJBFuXyMmuYjrLdIaX9YMdcTqjchvY7jT989zG99TK6TFR3ItOayX2kLau?=
 =?us-ascii?Q?sEX8M5VoVguV3ODO6SyvVVrQz+PQHYma5ARGFcGMqiE+eMLHXXC8dDajTwJl?=
 =?us-ascii?Q?whM+IKpaU9ld5yUcW9mFgBnMFP68DJy19ZRdr6G0pO5FBD7xUAp2Fdph7Kz5?=
 =?us-ascii?Q?CZzHg4pu6SmF5/bKQKm/BmZEEsaNvW1q/shDG1ZyErleKFVzt1R0QZzos+C1?=
 =?us-ascii?Q?XPtLK8pqsK7i80k7t35kekI73DZ1NJOeRsUrEPnvEdUIe/QM35MDDbzdgynO?=
 =?us-ascii?Q?V0pjXqlsrG9osXjtFM5Y1z33/I4r9nbvnrSAA6ZUtiCE6GGT7aI8PfDvoBQw?=
 =?us-ascii?Q?15AxYXKiTEuAUuy6J1hQnIbAUi9gyt6y0RzUevEQhSa7QjMQ+bZ0W8xvJlYY?=
 =?us-ascii?Q?JnDeXy/4td4iiQiyeWedS2RPZ1KSbLGlztPZDlDaf26VfPaMQrnTEHGO1zaQ?=
 =?us-ascii?Q?sNt3vHJFArwtlIeZEyEzB8GCbgAq/WquXCriu9UnPmpZhsN1EunEqLtyn8lD?=
 =?us-ascii?Q?1PWVeY6MvQJjVO54Dlpts6mBhdplLjdkDhHNvo195BFDkjSoSKJC4jc0UNqB?=
 =?us-ascii?Q?btJv3pkAu4Pgb5bmf98WqKiSSSfP2W/mn4flQvK82iEZ3nYZzSzZckkFleCD?=
 =?us-ascii?Q?6z1wnpRAgLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uesCjmofWoVSh0aTp9IQnVxg7SYP7G8NNIdK9HqCnL1B48COLh1fvndzAfl2?=
 =?us-ascii?Q?I+bVNjxjt8tSNWcPyudmp8S0OTDTfhyD04s7lt62PaVMrrx02FjgZNOLvkEl?=
 =?us-ascii?Q?sTxXsk/jZV8Pk0eWV1azIkxGAEDIEgfCoi15eFlkjTpHDhUkOzPy9N7IGjTH?=
 =?us-ascii?Q?2RsMgqVIowcbOvGEwhNDRRYWaltPwgonO99Nlgys7eRRKpItz/Y6FgZZwyDR?=
 =?us-ascii?Q?mbbxKD8qZpr6Btf3vvaix8ztPbuPTwNC6dX/n9oxXyVn99gVp1Askq4s0Opu?=
 =?us-ascii?Q?D8+0MM5tV2o419ONM23DOuOglUkCkNUcSDu0NWp0QxmAAoBGuvi8EirwrMYf?=
 =?us-ascii?Q?gXWfqzcv9zd05QVs0VkWvrjUypgXR7rsxRjWLD01AqIVqg+BTH+YbFKwo2C7?=
 =?us-ascii?Q?hotG18/Xv3JK52WJc88CkaGt0dtcVhY057I662N4myZYKtruTIm+a++8WKu3?=
 =?us-ascii?Q?VdleQ++ZkxGQrf4RwAa3W+1Glmk8rB7XGKHxyer9b47GnPw9lJvw5dWwEa4k?=
 =?us-ascii?Q?C2Me19YL1Lt3jLjyLnMAqpS4xUZ3+dNkAd4zDdkuA3tLVVVqU8hVq+G3lBQp?=
 =?us-ascii?Q?+hSAeqtxFMG+UHQtm3CBHgyJ4LlQoOvwCKfhqiMAPnQNHlo69NAJWbpbYLZ0?=
 =?us-ascii?Q?C0tvEhHg0xT263M/KvwALAtTwKdAcawF4xgzYsgEWZv4btFaCFFdY8u3q6l9?=
 =?us-ascii?Q?PP67vsEcZAq8v4ZrOTDyu1VKbg5hO+c4joA5a+MaiFiwgDHwIzSiPruNv9xn?=
 =?us-ascii?Q?YE+zdxv1Vq3ShEbpOVrkpF2Abmu89YyhCv6+TbMRDiaLfs0NUC6Cf1OJpHGF?=
 =?us-ascii?Q?oOvNmcD96jCqc79BEAf2eYFfvSKA1UkSFzJiONz/mBd3W5/KegYhOOOZ5pgZ?=
 =?us-ascii?Q?+U0BElFGWt1vTcviQG+0JoRTMYDhjV974Rvh0ssLudNuLyRHwGk+kyrXcdcz?=
 =?us-ascii?Q?VJcH71w16Vn/XrDHKZQmFwHjJg2SlKTuk4xyE9VFiShqUGSPtZhVCumerfqw?=
 =?us-ascii?Q?GiLL0tlz+qbYSoH1LrS9Ys2mKo8QSuyVAqwD8cMSB9yn6flHah8dRMObBE/m?=
 =?us-ascii?Q?bXxeHtLg7e71Ao6gax3R5Wm2qRoLUp8aLNY/xHdo7IwXXjrI1EwydwT4bVnt?=
 =?us-ascii?Q?sDfGzsUlvbZoKY95f80E6E4JyY48WdYl91Q29oyFasT/2/MT4uLl/WEu4uPP?=
 =?us-ascii?Q?dr0Mi+VJpQ3CG6mEhWee8C0UJxCIO2aIj+l1Z0QAmat2CTBv8JM5RWzfi5el?=
 =?us-ascii?Q?/CqieXeDvE0P8j05dOgmC/nDtVwlNAu2kOf+Yn3+8NcfLnVv0tm8L0fqmkfR?=
 =?us-ascii?Q?Ws8ctNl5kagRmrRHNbWMGTOBxhcxl8IaCgu9BCrA2lf55l+0iTWVys9DSabk?=
 =?us-ascii?Q?J0MRNnf8NvB8z3JjOP05WiK0Daqg8WtqgfYTiC7ZzRKElTHUhJft1UKbTKjU?=
 =?us-ascii?Q?jNXMnBcUamSXesCefGWltPpHWWeALVu96NgZviH+i6vGVae/vApiPdJciZK/?=
 =?us-ascii?Q?duXZkbb20w0wu+UzwNfulbZE/lXOAmc8tSf+zSJ/GAdA/LX1I0hgbYLuy+Dt?=
 =?us-ascii?Q?VZ40j3tl5L6gBicTOkAEdZDr7971xoQxPcZ2zitz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y+HRe4Zsd/50De18XcNM1y/CgYJQHkvR7eM5Qv+hwl9PgWb5A6PXoX9QDpaWU1hIuqy8Y/p/w9nAXbDAqCZ0qkX5CKt4eRQJRzs8tXXZZUiouyunOwLBIfRgO9edUT0FH8yVi7WHZyKbNbARmgQNpLB9gCriNX0+3wjNycVG6TXDJKERdKWkqWj6ob5KR7WksQjoPE6+BnNY75gZjlSJZ5VsLa5X2mQT2+Oml/LBuMOL56TBr96NlhS+SLb0Aw3snPBDqPgPImg7ghoqUZe5BnfD5ky0citatYjUB8RzPUvaV/CzJTuC5NFClX1vg4YKQlmuJxAmU6vDKiCPcyJ0LTQMGRjqxKxlJSH+q2e+hk8VWz5ZHthp/ycyLiiTdZ3JjKBQft3BunxnrYswX0flr41QC8J8WSglvJDWL4FqGxthkN06+f1QjEew1848g6Faw37j9k9Qxk3Iryk0vZXuKv1ylJIMsS0rO5neav1WJAa/fl3da4BEptLltcampW6m293/rx0Xy85k6vwyqUVuGAxOhnyQCOb5gWGVE0CTpUWY1OuDVId2MXW58ke3IcL4EWIhYJVvbQ2kQsjxG1ShON5J2/VCQrw6QnNfmXsI5Fs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a9def1-fc8e-4bf9-153e-08ddb7a4fd43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 07:09:01.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEWPPT8OUqrNtVxugwavUSyku1lkHtan33KTGClnEWxf7gljit3LajwElSHpjhoYNy3NnQjWo6vo1q+uLrsoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX0pcdtTN7EGEa G9+LLO1luyt0XK4M20B9rL/op5oHNKlQfFao1tnxc/djzMc6xvOf+OPodM7/JdBdMzAXx65TWSP qd740wl7RtMN8MPLvceIpjO7Yqict4Vm8nvlWY5b2cwApc00DdWuckTJffIrecJC1EJyZL8x+Wj
 TAfhcESblA1ogLwEVJKJsx9qy5hHwmwYVyyBcnZFHn8Fs2Te+9g2QyTH/tKFDOcjWkQER08k8Ga 1EqvC0FGwMJ7EtkicD2gZNqugCH5yWY6LkP5Xa2Ko4JnH8FEVDUQutHJAj6hsdHG0I5tAIHANZG t62wV3LvQWhAr1PY6hrvqadcJrFCfG+ajTus7MU7B2QZQjX/8/eBCKBmcTs+Yo/4ZaGIKOgfOQV
 5yjIKYdTKFb0SYgfSvdnE8VDfFKGzZRgAKvfdwhI1yFuClFG5LpvP/keTdLXfAyuu13IZgdR
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68623811 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=zrQOo6S87bd0gpr5fnMA:9 a=CjuIK1q_8ugA:10 a=fZM5Z8gBAeIA:10
X-Proofpoint-GUID: ExAOZhgVkUjbLHCsOsaztGNof1j5X59X
X-Proofpoint-ORIG-GUID: ExAOZhgVkUjbLHCsOsaztGNof1j5X59X

On Wed, Jun 18, 2025 at 07:39:49PM +0200, David Hildenbrand wrote:
> Let the buddy handle clearing the type.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

with the updated commit message,
Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

