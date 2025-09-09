Return-Path: <linux-fsdevel+bounces-60643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79680B4A854
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5F13AFDED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B82C17A3;
	Tue,  9 Sep 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSref80P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k6PbJETG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54782773CC;
	Tue,  9 Sep 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410694; cv=fail; b=se9ZP0UOHan7eHumaP4bkQnKDze5xoexK2509+ZUmFxfFONdFPH0exdIa0yC2sgqcyvGcbHec9eXtuvtq254l0H/0rDUP67lWEOdC5gIMrO8aI6gPwWESg9j2r8yo50XBEoJer+LUsta6cd0Bwhan9spR1TSQjaeA4QHmuK8RPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410694; c=relaxed/simple;
	bh=7tOoUgKwK6v0giqnPbVnV3MYueBuGy2CuCIbIPeoB2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPcxdAfW1YEqPvDDG4eJN04AmAyTPO/jUgUePcF5bqTUkJVapMMN2DMa47au+uiuQCaoyA2kgB/6ePxT6dLMYZvogNQilDZ0Fv+MsyYNyqDzsmTx1vYpd1Xbmk4R24FRgl3/wnb3A11H3+XUd61Em8esQRqNaC5dxOCQ8A+iZ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSref80P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k6PbJETG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897fpTe027366;
	Tue, 9 Sep 2025 09:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TIzTmZGc0uMPRmE9S6
	Iy2XV722yxu69GQPrD+2ps1Ss=; b=TSref80PEM6gQQDGquDN2ieF5MmfOpNfnK
	qMYLfhjwVEwVExeiAYLtaaWV0OF6qEqRL5IsNjDAyJJtLwtYxWYc41FV0czG2xyo
	5k+LvynRGEK1iSvaVO9RhQ6DpBV0hxBov36xN6gRqIx0MWLihewdAVWP0gUaNAT7
	pGchP/6JKC+QjMxFOSH5tbo3/I4kMAfq1Im30zeL9+v0MV1fkSCPP5qvUbVT7njA
	d3YD4BDpdGfmSUkPE8GCd6yPPWeGYumiM5mdTAZbnwxKkRWG0ezJNeNoU16Necbj
	FEP42udw/D1Zm1jV3dffIvkXt+oUwcXDIMKMWbR6bougMIWF6rEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226ssgkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:37:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5898vCXB002755;
	Tue, 9 Sep 2025 09:37:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdfvn8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAlSnKdYTr2R6qghruOZydtCGFB2mWF9Q47Vo/SUTXE1ln/1Kx9X2TMxKOr4WsYR1td1GLOyxWLagDZTUOteXW+U9bKE7iTaBbWQB5LK3cxSSkXAy0nwT3JtzK/RhBHxepuvyhLR4xnpdX5UaWt3FwHmBZS6vkDuoSLxOMRtZFTrupIf/Y796Haz/NfUkxpO1XuP7vtJb2sa5/1QCACWBGnb8S34s4nXR29B4++7NsN9rD0aN277J57PtxaOnPKV6FJrSvwcF3vNPfEJgmvaE6Dar4o4KnZbFSUz30qLY3XCYt/UvYw1QCRw/dM54DUcGl3QT6c7cH0k+ypA1Zz27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIzTmZGc0uMPRmE9S6Iy2XV722yxu69GQPrD+2ps1Ss=;
 b=aHdKBkO8yQTKxAIh6xpes/ktRV0mBqMTrprC4jGU700VtF7sbn2yJ4XK5wbCLb85Wb+zPrSq0QPRDnzb8LfHpsNrrTLwxP+Vy6v+31ldJuc+WkjmY/MvEfom3SvSV6LCK9qZtyhotxxGUSbSJzqVOOmKSmy5EJLPBiGcMWterVvUDr2DHuZ0w3qqhUWtveZ3IifSOVnQnjaADQqxxj9HOA+OIdRN1nTcslRlhGyXMd6L8HHm22VGGT1WdOoB35uCilVtPGiBC9mpIBjcvuvMO3pBhGq8zbuQqdRxsVWeeoGgauFKYq4/b0HGDJwq6VYGJ3kVQnGUJqAKXgD/NTV6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIzTmZGc0uMPRmE9S6Iy2XV722yxu69GQPrD+2ps1Ss=;
 b=k6PbJETGTNADmP8jcsk/LUokg9dATGKL+FBJnGxqiMwtnsrGQSUJYXqEw/woq0MbcOy8Lgia0A66Ch/U15vmG/9EDc+g3MJta7T69fwoJM6MN//iFSUJ7dibfZ3rmGVOC7MWobbZLIkrT6xnFAtNLVpeOSTlYJm0XEYcAP3/vQ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6775.namprd10.prod.outlook.com (2603:10b6:8:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:37:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:37:26 +0000
Date: Tue, 9 Sep 2025 10:37:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort
 hooks
Message-ID: <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <ad69e837-b5c7-4e2d-a268-c63c9b4095cf@redhat.com>
 <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
 <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com>
X-ClientProxiedBy: AM0PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:208:be::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8e8beb-cebb-42b8-b82c-08ddef847c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLhWhmq1X38UP42muIa/QdKydjyyU81HlLX8GtmyAGFINp6mt/ijHjKAFaAV?=
 =?us-ascii?Q?gFxgzrMfi+2mLTHZviSbwPXAhKD52MSEk+zSu0qNvvmxC7gADOdBaApQPP0V?=
 =?us-ascii?Q?KiKBi97kQldcJryjt4DzM0C7FFEKD+52WjJqy90Fa8aGU2sCgPkG7TSI4A0c?=
 =?us-ascii?Q?e23GF++i4TyaSMX1TffAscBHCRNm697fvY5rokbZ0HE40j63PZBtEU29fyr4?=
 =?us-ascii?Q?RjN4aoELHcqWKoKqJEBTiXF8PzFJQyI5F8R3pHPvGXW85um8XwnLlmADiMJ8?=
 =?us-ascii?Q?UZ/xNlSy2RieoxGB88mpRAepcdKeMAPT8zh15/QChDJVMNgVuLJMO1I9Ulzy?=
 =?us-ascii?Q?og7y1VUZL1B3fvgVhXZgKOZ3igOYX4YMaxglQSmORqAueozjiTJizg9D1k6U?=
 =?us-ascii?Q?hAoyDM1KPyucvcnP4bG8vjQAKcX2vtHocNwMcXFUi747R6tfzuObjyJLFx92?=
 =?us-ascii?Q?WlQg8ywzrJ22r3zWnP0bjMzONlr3PVHpQmbEgAF1RujtkrUNV3D+I4sUKZJ9?=
 =?us-ascii?Q?aMrZkIN/dFYGVAjc/X7Gqzj5r+uSWbTEl7Zg9GAf8uQVvqveyBT9DW7fv22O?=
 =?us-ascii?Q?hcg3ugBA3J3OxaQ3LtkxktHGv9lBI0g5FuubSf+xv/1+fE/Up2wGfkOcccnP?=
 =?us-ascii?Q?CEVXylnay2W0byIqoYRXht76oYvdQSwKiHBAJHP6DnVXNYHPRaivueoOcxsf?=
 =?us-ascii?Q?Lv1W3999eWDmw42JSCuTMVZrKevR6AFEur5vDIE2ULB7CNQtS6fppBmMHoPk?=
 =?us-ascii?Q?naTXaufiMfjfouP5rUzDEJHpE+82cjMvStu6eHjjQgZEGnQsA+7Bqeke75aQ?=
 =?us-ascii?Q?x4BZi1/UAM3+OhkUP1qupOc59UFF9BfHbR6HcF19FFT9WPeKxuOusJ1epcbJ?=
 =?us-ascii?Q?oFXViU7dMg/mdV5tBEtwUGD5IqRXGa+DoLDC4bgFVaXlC/DEEt1B+cpWoN+B?=
 =?us-ascii?Q?pvq0sKlXp33OVGoVNnheBBGoTjl827pM5d1T6RmSB9JO0jAVlc1e//85Jexm?=
 =?us-ascii?Q?F32tx2779QTqqi0MhvEuWVdPwNY27h5Z64+JQdyJOSU3vgK77tLAxAmVGO3Z?=
 =?us-ascii?Q?FJTeLq9gGcDfl9pgFzdmkg5w+KRaLKat8gAON1Pl290/PPkQYZL0TFG1Q75Z?=
 =?us-ascii?Q?V0mUpAHiOJksdvbjVS6DoKVeJtHEavZIKnaKmDmGRWVAP5bSgDALFdUUL4Je?=
 =?us-ascii?Q?d8pa7edVDW2GWOmvEXFxWcE0MEHTiJSSvrrMKqDGBw0zZXas+IAOMe0XQGfu?=
 =?us-ascii?Q?pr5+4327BQJg4r1RJgi9YxCZMRXyGd4BpCvv4wKKR+7MrGmmlaVfquVovQ4f?=
 =?us-ascii?Q?YvM8j0XZCFfix9hdnouSRYpiMK6Ag/s13d6xBQp71oclTRqsoMWsIz42z8+z?=
 =?us-ascii?Q?6UbnAYcU4xiJABqd0n/Hi3L9J9QiN470PidjLyCZ9GAh+QY7wpkyxpyK+CtL?=
 =?us-ascii?Q?AUoJF5xrxPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NoAVNoceKTqK9B/1sNef19QSHWhVUGwy52VmyAshl9gsTJROLmxJb8DUxyHZ?=
 =?us-ascii?Q?IBaV/XMZpKv2FcJ4XiD5vjgDtzGsiDolxyjcyyi0DfAC0IPnYbVRACtAoYN1?=
 =?us-ascii?Q?M4F8oDAyDX7de8SEaBxNo9bI2YkAmIxB2dEHqg5WdsWHndyEEcOhIgWymRSI?=
 =?us-ascii?Q?G5ZNDf3tmz0cDoHKCMIZ40u3LKeWXecjqH7gFabzz6GC3Tb7MLWArP7HtNhJ?=
 =?us-ascii?Q?CcTB+rW6xmOVn+kgVHduZKQuyuGLmiJVL1nkgKh1GA/bD/GYuAff8vUGbyOf?=
 =?us-ascii?Q?yOQtb2LyElTxPI/YBwdILB+84vAV2tCWXYjXj8asQP/aWrOSuiJTJ0o0uoDg?=
 =?us-ascii?Q?JF/5rLONA7CexP/cZw1Cv/WDNC2JMixxirQSmLURZCZfVCfjN2GC1m5jqCPD?=
 =?us-ascii?Q?QtCd3nsQNm1slctFo8UBuJGK/v0RCUTm0/CUN2vt9e6Gk7S6CNIiiiXwZQzi?=
 =?us-ascii?Q?cCZFekONX3wbrB4mOsoRGpLhuLNIKZYn/Ughw0Trj+aQL+s/YY19Iw1e0YX+?=
 =?us-ascii?Q?PCKpPEaH9SbrkZwd92gplY0D5ZW4aCSZhRYFRg3d8EQgSlrQqzSvVLLp7n0I?=
 =?us-ascii?Q?RfzsVMOH0Yc3GZ00l4j+Tp9hS0KzHcI7X2LZ/PN6pSy3urSIoMUv9VWRsN/b?=
 =?us-ascii?Q?1J2XoXKQLYpIo7lBcIi6nUXyJxKqY07p7NwyXdI3ifUDjB/q8t0ICbW9XJQg?=
 =?us-ascii?Q?pJhFUn/j4JAC+cQIWERhiDxxhxXo8cy06usgttcIKGmUltyUFRvQLR4YVyQa?=
 =?us-ascii?Q?8yf6dRjTiB+95Q5zogSoOTXW5qIuUxo3vh/2MFm5+mj0gzNc7XxSfMaaL02E?=
 =?us-ascii?Q?1S4M/fKE6ATGynjSBuMJRPVCgZi6T/AEzoh8LqbMYfJ6atVH8aFIA+DqXAB7?=
 =?us-ascii?Q?hMAU1bNrcdII6zZDQhSh2wOkKC+4hUCjgfOk0Id3r5qn79QtYZMNZ0e/0+YW?=
 =?us-ascii?Q?iDo3fizOpw9hRXWFVHzrDtkrWCcHn5aXsIxLCA/Ur+HisQJhYRD8hTG5WcGF?=
 =?us-ascii?Q?DijFVVfioTLpABJxqTLrVk0QLvpVP/GpkAkA+l2E55Nrjbp9V6I0cE7zpZ7Y?=
 =?us-ascii?Q?C1DJbVnxuYu/6FUwx9jnoD0Py//xX9ilqNCazwk9B54ZU1kwl+TQqiFm6Wv7?=
 =?us-ascii?Q?Wmgu+TvkjMCSgEyJbB6h85eUBsPCV4W6GgTH0sflPwDWlXQJWGYRSOxSIppr?=
 =?us-ascii?Q?YvuKslucNCbEFumq+UWpAk9ToTPRQ8JU1A/5AvmCiv3cypJ3Ptg0cDKx8jWL?=
 =?us-ascii?Q?ekC+yILaH/7EhgCF4jU6fftquT2BdNy1oPKeiIJ7wltVf3gSyRrPthY+4gNo?=
 =?us-ascii?Q?PEvINhx1aupxNuUUCBAkQFtJeIf4AuHjy+HTWpXkI1tWvhFgWH+1fHtrdINl?=
 =?us-ascii?Q?Mh7dy6KCPjPg7SIcSD9Q4ORrltgW1PQ3frRWH5Wm3tkbBu925VAV4a8XiSFW?=
 =?us-ascii?Q?wItcBcm1M1QfmHMFvs/LaaawMDkBj5odLWtzEIPPQPVn88N+V6BTdUKSKvss?=
 =?us-ascii?Q?AJIylvo3+8AHLb+8IS/V99UjNXINrP4ELZrLIugWZ3XkkdK2bnZgCofR/oZo?=
 =?us-ascii?Q?KhKDOlJM/4M8EbizqrG79gZIcmqtEGnHuD3ssv5p985CYUxj2UE6Aul3hZuq?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/H6redPxiUdjGAuDgvO+w7LRBlicllo0jAZ1QGtuashQzNqooEoKIaPrx+m7g015IMeOKfb8sHDzWeUVmu5ccLXV9foN6t3b2hrzhr0GNmEVD3LpOY+01O/A6nHU9ox0FLxIUtz0D1XfvoWNpIgrem6n392F+NUI2ijzbKHf8UHlYRHr3z4Q+rukuLS5YqXo1w3O94GEQqo80Q0HCx1aByOfvwhz09Yq+LLcaCDFDAAunQDyybZWq6HrLhuqTV5nSl7AFzDGN6oNOeOz8JvM7N0p+uv+FWtfCvi1kxSGhikubSBavwK0s+w0mMS/JeGoIsK1kdomH55ZFUw8qeLNXxkHbbQqDVPx6T5QrSBYB7lZCk4LCOzfpYVyHrVsuTh/csKVBJ8lrz3GnEaX+WZBoM3gJ6HYF11pOu39p9COzzcqZ80uYdMUJSIZaUi+MDc6RUfkeLNOSgXRMCB+Mptfky27o8kVb1nnYB4MgOTKijEGQHxD/dsYpcjHi7y0X/WRL8wlE/cZ0z/QhLQDB+hyNtBGXdKJYOictQezGvvhsvOoLMKdGBSvHavK5OYUrLZin5tbrPZMNP8XiC3H5JEdAn9Jw2ZMhzkPrkakenWI7q8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e8beb-cebb-42b8-b82c-08ddef847c90
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:37:26.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHLIp2gX6nDTGkKojO0vF9ts3RjtUKTL6dAM+FJpypXyXA9xUeToXsgtWc2cTuaXTVGU3Bsw2nZl/Cl12BtvUe9rDv9tYzBfaCGZY4EXKhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=903 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090094
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68bff559 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VadzeYaZer0EV3dStXgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: Z6qQJXlrKKGR_nX47Wc-Jeca5dPnQQSt
X-Proofpoint-GUID: Z6qQJXlrKKGR_nX47Wc-Jeca5dPnQQSt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX46Dr+R+CqQHH
 WLTSlVgHMZxoaUpeES03Uz4qrcQL8AtcUvS4Y2NtF3JsrZqAvPCYjNqG6sEvbNILucAO3FDvGAF
 gKeSddC5m0Aw7fj6dTIRNfIY5OjpVphOypRSHUL1PPXnCiUyOrho0fceF54ktFs8cyQnywqtPXp
 tN9R1Sf5q45Y9VoDlghYblC3EX90lIcTUCYosdTtYY77d8SdrH12owWu0cCkr6puLKHIcEf2L+F
 8ikYPwuTkCSYO15sD9jRx1UXHLFSQYhGOKzGz18m0RcJncaemEZJAZufD4PqneE5B/jqjO8nZ4E
 hMbKaUSliS13xrNIUcJFjjbaV2v8O4C9LHtV3ZYHRfVdgS9BVQfMnjYGbh+xjD2RNd/VyV9r156
 tPtP3E6yLHc4h34dtvZk6y45MvO6Ug==

On Tue, Sep 09, 2025 at 11:26:21AM +0200, David Hildenbrand wrote:
> > >
> > > In particular, the mmap_complete() looks like another candidate for letting
> > > a driver just go crazy on the vma? :)
> >
> > Well there's only so much we can do. In an ideal world we'd treat VMAs as
> > entirely internal data structures and pass some sort of opaque thing around, but
> > we have to keep things real here :)
>
> Right, we'd pass something around that cannot be easily abused (like
> modifying random vma flags in mmap_complete).
>
> So I was wondering if most operations that driver would perform during the
> mmap_complete() could be be abstracted, and only those then be called with
> whatever opaque thing we return here.

Well there's 2 issues at play:

1. I might end up having to rewrite _large parts_ of kernel functionality all of
   which relies on there being a vma parameter (or might find that to be
   intractable).

2. There's always the 'odd ones out' :) so there'll be some drivers that
   absolutely do need to have access to this.

But as I was writing this I thought of an idea - why don't we have something
opaque like this, perhaps with accessor functions, but then _give the ability to
get the VMA if you REALLY have to_.

That way we can handle both problems without too much trouble.

Also Jason suggested generic functions that can just be assigned to
.mmap_complete for instance, which would obviously eliminate the crazy
factor a lot too.

I'm going to refactor to try to put ONLY prepopulate logic in
.mmap_complete where possible which fits with all of this.

>
> But I have no feeling about what crazy things a driver might do. Just
> calling remap_pfn_range() would be easy, for example, and we could abstract
> that.

Yeah, I've obviously already added some wrappers for these.

BTW I really really hate that STUPID ->vm_pgoff hack, if not for that, life
would be much simpler.

But instead now we need to specify PFN in the damn remap prepare wrapper in
case of CoW. God.

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

