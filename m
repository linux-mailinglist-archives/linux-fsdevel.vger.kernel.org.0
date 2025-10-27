Return-Path: <linux-fsdevel+bounces-65748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD141C0FB4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64B519C03CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7633191A8;
	Mon, 27 Oct 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUL73wSm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJwSAKXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2F317704;
	Mon, 27 Oct 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586812; cv=fail; b=IgsjTHGnXdAf3zLEEDsSKzVcoNLedHT+hE14iMdibKinbr/j4AMZMMQFiKfD+4ZZkXczclTupXllJRRCEnpDtt5bqld9x/9HpoczJGTznjgfTTdi1SQT/ZdR+FNiY7zScGHyNSuYFWfLSNU90zc2SGOzo5+AVMyQDdm8Vh1o1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586812; c=relaxed/simple;
	bh=7uJDczLhSJm2h/IZZiL9cQFDlwNO5Yfa9zt2DGsac1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hwdaog+GJrkHHvHtrvO6xa+8qhgOqERWGnJKjeXn41x5zFPUrl2LH3+9A6ZnnjGtayyZ3b6GA434qcngYt0fzhDUY1dwzdjNzInbZRJtk+G6TD2MtjSX/USQJcGFmA/pkPg9NUhEt9QaixB8pXe9GiFMwK3H8QDbqZAYjL8KDP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUL73wSm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJwSAKXF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYKKu018598;
	Mon, 27 Oct 2025 17:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+JjOrXKYQDhOJy5oE9
	cD20LCIwYwu19l9/zCSvCe31c=; b=ZUL73wSmsFWqiIQBr5YjMEf3sihR7scyXi
	atbrtfmG2dyO+ij9LaeEELynoV4UWrrLzxRDsGZwDz8pf/Qf+JvFP5jyViAvohHB
	Q+f7R5P7e34rEeIi/hjJJE1Ck/+mpYPLmhNfrroFUEdYIaX4I9uZmdELGaK+qVEo
	0yA++ygi4AJOe6lrZxbDout7CDdKitTOpKJvdYFy7FBaRwsvrclETXqTZnSCMX9A
	ZZDVjS7hGyVzc1nc6yNJ5xMx6vmqdWiMd375DZb+KcNI4bpyXMqdTcjKOIlHLBsP
	V5LpHBmAftSgBDBvvQrO8DZHZcGS67+wehB94u3iFB069Kr0SgLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ym543-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:34:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFok3a014964;
	Mon, 27 Oct 2025 17:34:10 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n073t66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGfw0ORayuBEZoL8HwlramDdfst0ZfMKLPjEQY8Wqltp4mqxUqcS+i3SAPxl6yu6nldDvXmfpIR6TJGAii3aFwxYnIuuonbz2WABFSJ5/YaYUy9qczX4+ZbBFrbv7lT6M/rZhi/qOHTKa2a6Spy3RQmtu+cwBWfhP5fmbqij69gYsYr5HLklaSMCECzB8yoYd2j3/WsKvtRDjVxDEV8+L6k5Oi5sJIBa41Vz6Oby238jY7BqGD4F7ou4V0Krf6LKPCh+DYtBNAGWOjloE/evSnr1S3OCptmgnauNwozEB2YSa0qBYEtLXM4oUMfZU8QPbRL3QQcYfX5i4B3M5HYQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JjOrXKYQDhOJy5oE9cD20LCIwYwu19l9/zCSvCe31c=;
 b=MnWLMeopB7Gc+WPz8hCtHBv+oew5/VQLYjfCC9wflBUIhChVMgPGPHxN9NBdEgDhnANpUK3gfRL2PlPGDt56yEvVLVTz6uL1LYO837AP70aunnQioZV1KDSJS1sER+8x5rR7/BeD03IW19joO30Qd2PQ42NxmeIBvVMKMCiPxk9v+E65joqe0VPmVhexXn4GanYIi6Vd9+s84NfaZh1MHDafjVB1wleSSj7cYOg7r+8SuBJJk6N0JRKVBwoi2/wvAELWH9wo8+StkIGS029sg6p8O3rl1K9bFVxK1WoG71ftPprIqv/q9rovEzoLQUTxsQKXMJW5IS9H0LCWAcd1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JjOrXKYQDhOJy5oE9cD20LCIwYwu19l9/zCSvCe31c=;
 b=kJwSAKXFxsp0NHToN/69YEV8Hn1nYb3w0v7RocknLcXcu4Q+tj2pEwVob3c9zamvCjiN/e+E9Jd3a5V8Kzc65buxUDEMQK3KGX6E8iRSUhcpjl1/7D0wo3SoqoL7vEIGxio92ILojCLUUIRFmB9pt6eIKKJQK8V1GBN/V3EcLAs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:34:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 17:34:00 +0000
Date: Mon, 27 Oct 2025 17:33:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027160923.GF760669@ziepe.ca>
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bc57bf-14be-4b32-4a6e-08de157f0399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RkyG23+sc3qzeEOYsvI+heE8VqnSB3G1mjz3qC6+nJkO138dqUENmY3h4pC8?=
 =?us-ascii?Q?xKijE1xICBhJBJuBRp82FR8OmKM+DO3Hjxc3IpQD/qror8RWh8cnqSf1J49n?=
 =?us-ascii?Q?lbQ+qEe+moyRAHPhgOEhoaUbaFvT/Bjpmd4uTESYJFnIlhUjdu5DYSyA2/kL?=
 =?us-ascii?Q?46+bE//ES34LzTF6QoSQ17oOnohcvNcKpvf++iAJv/26kg4LzZGZYVbfQq4g?=
 =?us-ascii?Q?o8iUuGU6Or4l73IBJHZdcwt1CYhax0yIatquAe5ItWUWTm87tFp2gRS7VGIE?=
 =?us-ascii?Q?EcoGLrG5mDKNLvAdGI8rBiH2S5nbUCe6X5/KR4pPo3pLen9fGzsOaZ2cy1Wu?=
 =?us-ascii?Q?NyySYv+L+qCHIAw8hpFKj7axb2J+B8Agvqb/rZokN7E0DUBaDhHx1CNGPqN7?=
 =?us-ascii?Q?My9yLXt3oiNKRWo6rZ14Nz0kzWqn/FEAn+ftkTsrMg+Kjbkrt76RIfOtLT1I?=
 =?us-ascii?Q?oJzZqq2Appbuuz3KQyPMUIJlVEbHNnAfCKCRBmKSwuVRNIWX/VOAq1L72KBC?=
 =?us-ascii?Q?YxuhuQKw9p/hic5hBfDsMbx0wJkG6rpRsN3QQEYn3IAElz3AtQzecdvQ6vzN?=
 =?us-ascii?Q?/DLBxPKYSsJSHHHJjzsU80Up3HgxB3BeFGrPYuz0qUnjHQm0VYzUJBDqSmWD?=
 =?us-ascii?Q?aDcjOXSwkn8isYwDeY0XoAhXWygXUkdY/op7h9tYIVmrpwt3vndGkHR4XpXZ?=
 =?us-ascii?Q?pyxUsnwcbQ+EzL6+xqMns6wW6NaZ6cU2LCdqW89jZjV7uueMyFf1Q//f7AsN?=
 =?us-ascii?Q?i4VRo+ABSoSZrpdUTHsTt88SXuz9er4FF++lT/HEW9AboKtNn/OBB9GydLRs?=
 =?us-ascii?Q?4lxHwCshF5TB+rNOOVDbtSGbZ88MfNiAmVP/qvkwnElkQI+89Q3dLHV3ZQDR?=
 =?us-ascii?Q?fb7nmjVpFAe3VOsMBP9NBwIvqciof/CAjvk+1ND26186AQh35o4YUz8+/M/c?=
 =?us-ascii?Q?9J8jWG07nTVm8U7o8s+hSXdh2O1V7yHsmFW9yI7G7r9/fXaYY6UQ4+noYCJb?=
 =?us-ascii?Q?evvZ6Y/eC6h0kgh684B18aR5ickXSdkKdEZr3perQgbSWXt7OvXS4ic1Ff/Z?=
 =?us-ascii?Q?oKfo+I5QE5hxIAXx8AvOsb42GppxopjGCbN8JYlMspICWKRB0PHILKi1izWX?=
 =?us-ascii?Q?ePiqyNB+iEYdyAgj4q3gZljZUFsiOFOVXYeQUCASkcUHtbKhv2mWbznT6Ygv?=
 =?us-ascii?Q?dPnv+U1ePMA+VzSwczijASAetuww25HiW1KOjPkb26Ts6NiJo0WQIlIDyB48?=
 =?us-ascii?Q?jp89+JlnCvYlj1v4VXV2izcORGSp0UQu6XPnX/t5b+YN5Mtjz9rnaWb6kaeD?=
 =?us-ascii?Q?sRctJH5cf+0G0TWqdoy0j4jkLuzPkeCgruTGfLNR09RHCBoPQfWhvNhbPapW?=
 =?us-ascii?Q?IG/psl7TmbzMzK8bYhcs2KbD6P565gWphPjUbGLat5uzfPI6gJzpvYsY2O+3?=
 =?us-ascii?Q?hjglzre0Kkkv6Y5tOoEtkJigyEXyq8/r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9iVV0ZgxDxIWbCcEDYI5xrGLlevJwGdp5pRkWIyQIJ0g58hjsF9X7hH23+OP?=
 =?us-ascii?Q?oLRy6DMTAUUdqYhug6YzJW63IP5bA44E03d0/ZVNV8NCjAc9LT1m75l/qwsE?=
 =?us-ascii?Q?zgVaXPtJZ2gp1/9K2dNpaw0BRtZ+2umxkNE+JvPTdZQONEsiysaiDTQ2knY/?=
 =?us-ascii?Q?HZm4utFrB/jH4VVkuO0lLZmQ6TEbTzqUkkL+Zv8xyMVUILA0YPwR2b19aZJj?=
 =?us-ascii?Q?N352np8bWfnDZ/+69b8Jk6h6nWIiPx3plooI3f037qfT1BO78qxFpKmZgzx3?=
 =?us-ascii?Q?6M9i/irqUd85RjpRIxCHb40cBQJeyllCBWhL3CPnryZ0+GJaKbvi4M1HE/1t?=
 =?us-ascii?Q?4q/rl0R6AKCCUl+02EXJxwVSeKOGmpmsnnu5SAuQyatjnaBG99J8UnUuh/E5?=
 =?us-ascii?Q?PnyvqR/W/HexDjfNnfF3LnEI4l4kappxh8Nja5lDOrmExxrZO5QTUKw+vzz4?=
 =?us-ascii?Q?ecG2Sya29PGaPdv1317oYbi/RSnTEuTxEZ18g6ZVT0GdrmeZF4nXMBS7PYZp?=
 =?us-ascii?Q?WK1Aq6fp/S8tvBhODmx90ehjWnM7zJczW0Qo/ZjH058qOX8TI7n8SgsueaZK?=
 =?us-ascii?Q?wJW6M1z7g3hJnhTg+5QnhJtaQoLuYwQuUvU0pzN+z10ZwKzViGHf3aiITs6a?=
 =?us-ascii?Q?c+mkd2ACgzNr/DXZtDArz5tMRFPTciYQ5zrSh6u3xJzIITa9HgdavYf4hnx1?=
 =?us-ascii?Q?CJG3Xrv9xQPJHbAz1nEdQLEPloIaYyRJ4kWywt92qo9RhYfeWShg9XvlnK8f?=
 =?us-ascii?Q?NXefZ+g4rhQMP6fCoDPzWqpGEwc0DpdqAzvyynOl7qi5hfVwHgiGuSNo1G4q?=
 =?us-ascii?Q?RK8DdHBVoSBOycMG1YApEkWPXhw1eB/ogELn/VtS9atBS2pn4AK4Aaayh/OO?=
 =?us-ascii?Q?/9djV7OLur6XY63zGpXYBM8yiyeEC6zW+gCrjHR+ywGGfNzBOayLbKBUmOip?=
 =?us-ascii?Q?C1MfjqxdyIcriNsoTtLczcQtryfmDoAqbq6KEpEfLUlFDPNQTIGiIsh7oipL?=
 =?us-ascii?Q?05H+RNVTDthLTzjNHejrwhatCcBHai6hZvSS+6Rx+iqXqnDqYrS2KaRiSn7B?=
 =?us-ascii?Q?h3qBjzobtz3LPkPJP5Rm9lrU+fIt5Sge0P8ZdFKE3OvDMVr4HvRhMkWl6Q/k?=
 =?us-ascii?Q?C/h1lmWI7OwI+izPVJB+jPtuGtg72pfTaJdvq9Ac2KeDWxljTQU7QIiEpcdy?=
 =?us-ascii?Q?EJ00xS+QvZgGVOBI76rIBWSFmg5cjwoAmgUW5SLIpnU4InfncFmoDaU0MC3z?=
 =?us-ascii?Q?PjZGXFyjp3sqljhFhG4LaDkI4DXNe/f1gSVn+sK4C3OD1eiWMdSDj0ZoArBB?=
 =?us-ascii?Q?YwnCOTMo701PcAyEIEPaWRGSve+NgiZUBWW5Y9lYT3RwlbWkmR0YE8Bs077x?=
 =?us-ascii?Q?suFcjJDX/y/zm5nedlzPKOYRgv0OAufmCFpPiKUw2jrioAOT40JvIikrzfex?=
 =?us-ascii?Q?+mSseGt330iocGNO7PrZprGra6nv8ChsZv8grghAwrb/TucFa8KAxe39aMFw?=
 =?us-ascii?Q?OEdEOLFYKheKExZMqeT7ucHliGgyExfqa8c24tGC7K0FjpacsjMD6zrdIBNi?=
 =?us-ascii?Q?/+viwS3vU1Nx4atMnztGhzzJFWvJZug+5L7ahbAMMIsBv9XcvPOMXwHedKG1?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bOHRVRsUAreIBstbkExdoceijRG4t99Q7p+bCRv/WYPDmo+kfmrer/F/81kr0MutrkiLkbOqIMVb6S270CQAU2+xWwq/7FJM1Lzck7Icu8Ltqf5yIzHx3HMiWQrSqENbyuaHl8WOGR7ymjaXNeqWhuRqRw3t0Gkcbc23JFkqKwVkLWnzehZrpKPtlP4CjGZGzy2IMqQo2d2BQO2jlYiTmD7XvN6JKCSFpj/4GMhy4rNYfJCeHuzLE+jayuER6UA8VerypSE3aIdbCx6NDohAvRz6Q8+zcb8JKOABL9+TiAWaWJrMAe8puEB1M1XhFcmtirHuKqAetPQK3XdUe/v82EmotX/TlsaXWzbEhrrs/Fq91VbLg14WCekoNURoWcsf4V1BmRJk4PMsGExYreHEXTk/uexOTRzjfV6RU580RD0GM+mym+UM2p1DbVMynl7CGYH6qNrlzqL/dyOoTacwbVlnQztLfrhZnQv7wutUgpTI8qA76cGGkvrJLdLSziLg6MMBW6MHrXII0kLF/mJSjQxued8Vjsy+V3WVFM4yWNixnDXxT2l+/GfyT1PlZKIVx+qpPaIlN5DKKK1Fee/bFOytkXF271FVNxzch6dROsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bc57bf-14be-4b32-4a6e-08de157f0399
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:34:00.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlOE0s4ItsJBYToFiOoKBndvu5l4MsQ50WmvxvApeVFGgUf14G7cG3kusHR/qXS0Gy791L/WA35IIRYRs3s420PGYp9iTqTL/bXa3Zv+7U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX4pQyDtquFdQl
 vR3hIEFZHV5RBpgMrQ8tKB5ly+wGGkys/mpFgurBU2tixG1laHjALEuCY5pokZHVUWHQDdFig4Z
 NVtNh53VRjAI3qcZgM38v/F+WBnC+9C1Q8Z69XWYqj+5OTHDqBZD16BgdV56a9PShtg7J3ZpCuf
 aFY7TqU8MGypHSV6VwnAX708oWLZfLThfKlMph7Vs4D0d7hqTDEqvBpwJKIvHJ0fHs8HYdlivak
 gfB441dsMI2YXoNIQLFtNtjiGy2ba8NhlEapAZj0ASMMgm8z6xkAeA+ZYpBqyX3q2TZ9opYEN35
 2HnfSXYZ9clxGf8bLvsfpnogzwUP7dF+4KOZb72S4AFNYCt2tdfL2y9pnS6aQtKZr1remUxr6RN
 6S5sY9VxgwW1ltUZpAf7nKlWfSihKAa0UilZKm2Ppg6U5EQoFV4=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=68ffad14 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=amoN9cES9AURxzEaD4YA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: dMPDx2wtzLdFsREM65teeesrRajquTdP
X-Proofpoint-GUID: dMPDx2wtzLdFsREM65teeesrRajquTdP

(Note I never intended this to be an RFC, it was only because of
series-likely-to-be-dropped causing nasty conflicts this isn't an 'out
there' series rather a practical submission).

To preface, as I said elsewhere, I intend to do more on this, renaming
swp_entry_t to probably leaf_entry_t (thanks Gregory!)

The issue is no matter how I do this people will theorise different
approaches, I'm trying to practically find a way forward that works
iteratively.

There are 502 lines referencing swp_entry_t in the kernel.

Leaving _that_ to another series seems sensible to me.

On Mon, Oct 27, 2025 at 01:09:23PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 24, 2025 at 08:41:16AM +0100, Lorenzo Stoakes wrote:
> > There's an established convention in the kernel that we treat leaf page
> > tables (so far at the PTE, PMD level) as containing 'swap entries' should
> > they be neither empty (i.e. p**_none() evaluating true) nor present
> > (i.e. p**_present() evaluating true).
>
> I have to say I've never liked the none-vs-present naming either.

OK.

I think that's not something we can reasonably get away from practically at
this point.

I don't love 'none' as a thing. Empty would be better but you know
naming... hard.

>
> > This is deeply confusing, so this series goes further and eliminates the
> > non_swap_entry() predicate, replacing it with is_non_present_entry() - with
> > an eye to a new convention of referring to these non-swap 'swap entries' as
> > non-present.
>
> I'm not keen on is_non_present_entry(), it seems confusing again.

What is confusing about it?

The idea is we don't mention swap. If something is non-present and not swap
then it's... a non-present entry.

The logic generally does need to differentiate between the two.

Otherwise we're back to referencing swap again...

>
> It looks like we are stuck with swp_entry_t as the being the handle
> for a non-present pte. Oh well, not a great name, but fine..

We're not stuck with it, I'm just doing things a step at a time. I fully
intend to rename it.

Perfect is the enemy of the good, and this series improves things a lot.

>
> So we think of that swp_entry_t having multiple types: swap, migration,
> device private, etc, etc

I mean do we use fields in the swap entry significantly differently in each
of these types?

I think any change like that would need to be a follow-up series because
that'd involve rewriting a lot of code...

If there's _good reason_ to and we can sensibly stick a like struct entry
in the union we can rename swp_type to leaf_type or something that could be
nice actually.

But maybe make opaque...

But only if there's enough variation in the 'shape' of the data in the swap
entry between different types.

I would need to go check... because if not, then there's no point really.

>
> Then I'd think the general pattern should be to get a swp_entry_t:
>
>     if (pte_present(pte))
>         return;
>     swpent = pte_to_swp_entry(pte);
>
> And then evaluate the type:
>
>     if (swpent_is_swap()) {
>     }

That just embeds the confusion re: swap entry in the function name, no
that's horrible?

We may as well keep non_swap_entry() if we do that right?

Again, I intend to rename swap_entry_t. I'm not doing everything at once
because it's simply not practical.

>
>
> If you keep the naming as "swp_entry" indicates the multi-type value,

Nope don't intend to keep.

> then "swap" can mean a swp_entry which is used by the swap subsystem.
>
> That suggests functions like this:
>
> swpent_is_swap()
> swpent_is_migration()
> ..

The _whole point_ of this series is to separate out the idea that you're
dealing with swap entries so I don't like swpent as a name obviously.

Once we do the rename, we can do something like leafent_is_swap() etc.

And agreed that's neater and more consistent. We'd want to rename all swap
predicates similarly.

We could also just pre-empt and prefix functions with leafent_is_swap() if
you prefer.

We could even do:

/* TODO: Rename swap_entry_t to leaf_entry_t */
typedef swap_entry_t leaf_entry_t;

And use the new type right away.

What do you think?

>
> and your higher level helpers like:
>
> /* True if the pte is a swpent_is_swap() */
> static inline bool swpent_get_swap_pte(pte_t pte, swp_entry_t *entryp)
> {
>    if (pte_present(pte))
>         return false;
>    *swpent = pte_to_swp_entry(pte);
>    return swpent_is_swap(*swpent);
> }

I already implement in the series a pte_to_swp_entry_or_zero() function
that goes one further - checks pte_present() for you, if pte_none() you
just get an empty swap entry, so this can be:

static inline bool get_pte_swap_entry(pte_t, swp_entry_t *entryp)
{
	*entryp = pte_to_swp_entry_or_zero(pte);
	return is_swap_entry(*entryp);
}

Which is a valid refactoring suggestion but the building blocks are
_already in the series_.

I mean that's valid feedback, that's much nicer, will refactor thanks.

>
> I also think it will be more readable to keep all these things under a
> swpent namespace instead of using unstructured english names.

Nope. Again, the whole point of the series is to avoid referencing
swap. swpent_xxx() is just eliminating the purpose of the series right?

Yes it sucks that the type name is what it is, but this is an iterative
process.

But as above, we could pre-empt future changes and prefix with a
leafent_*() prefix if that works for you?

>
> > * pte_to_swp_entry_or_zero() - allows for convenient conversion from a PTE
> >   to a swap entry if present, or an empty swap entry if none. This is
> >   useful as many swap entry conversions are simply checking for flags for
> >   which this suffices.
>
> I'd expect a safe function should be more like
>
>    *swpent = pte_to_swp_entry_safe(pte);
>    return swpent_is_swap(*swpent);
>
> Where "safe" means that if the PTE is None or Present then
> swpent_is_XX() == false. Ie it returns a 0 swpent and 0 swpent is
> always nothing.

Not sure it's really 'safe', the name is unfortunate, but you could read
this as 'always get a valid swap entry to operate on'...

I like to encode the fact we are treating pte_none() this way.

pte_to_leaf_entry() is possible?

Or

leaf_entry_t leafent_from_pte()...?

>
> > * get_pte_swap_entry() - Retrieves a PTE swap entry if it truly is a swap
> >   entry (i.e. not a non-present entry), returning true if so, otherwise
> >   returns false. This simplifies a lot of logic that previously open-coded
> >   this.
>
> Like this is still a tortured function:

This is moot (also not the final version ofc as I get rid of
non_swap_entry()), I agree the approach you suggest is better as per above
so we'll go with that (though without the horrid embeded assignment bit).

>
> +static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
> +{
> +       if (pte_present(pte))
> +               return false;
> +       if (pte_none(pte))
> +               return false;
> +
> +       *entryp = pte_to_swp_entry(pte);
> +       if (non_swap_entry(*entryp))
> +               return false;
> +
> +       return true;
> +}
> +
>
> static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
> {
>    return swpent_is_swap(*swpent = pte_to_swp_entry_safe(pte));
> }

I absolutely hate that embedded assignment, but this is equivalent to what
I suggested above, so agreed this is a good suggestion broadly.

>
> Maybe it doesn't even need an inline at that point?

Don't understand what you mean by that. It's in a header file?

>
> > * is_huge_pmd() - Determines if a PMD contains either a present transparent
> >   huge page entry or a huge non-present entry. This again simplifies a lot
> >   of logic that simply open-coded this.
>
> is_huge_or_swpent_pmd() would be nicer, IMHO. I think it is surprising
> when any of these APIs accept swap entries without being explicit

Again, I'm not going to reference swap in a series intended to eliminate
this, it defeats the purpose.

And the non-present (or whatever you want to call it) entry _is_ huge. So
it's just adding more confusion that way IMO.

>
> Jason

Thanks, Lorenzo

