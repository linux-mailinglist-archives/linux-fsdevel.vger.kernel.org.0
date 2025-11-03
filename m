Return-Path: <linux-fsdevel+bounces-66767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B71C2BB85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431851882764
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A230C624;
	Mon,  3 Nov 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bIpBkFD4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hk2Y8DAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5E31281F;
	Mon,  3 Nov 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173281; cv=fail; b=DjYsLdbu5m8hkTppbT1BXeOtilmQG4m8r2CWEXOhLL2Ymxdi1jgz6qQLmQNSf/T6XCtMQoYbBabRbyrmHJAcdkjhJGt/bgQ7bTnYOoYotvWMFMcHU4HBGoxMtqv3PVRnDfaaoix/6CbqahzS1BW7zNh2zrsRkAU0B2ChqXNK/50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173281; c=relaxed/simple;
	bh=+rf3YXeuzjjthqg07CHrFcauklWS1z/O6DICvbKmiVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uL0fNswryUlyPRJPQ2sMo0RqKdvDFcYU4EV+e2E54IJI4WesiB1OfsoqKJ2LIgBmRwxAbUrdxoaRaxcBW25XhduIMAi6X4nlcafN5GX0/PHEMjDgHDrG6hfXBVBbUULdnsiZDXlpBE6L6uDytdSEJ7UmIWDMoqTSOYgR7n82f5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bIpBkFD4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hk2Y8DAl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTgRx019251;
	Mon, 3 Nov 2025 12:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NvH+jJP+Gz965mvpFs/APDOgcaEOo3H79MwRURF5cS8=; b=
	bIpBkFD430qhiSDUyyfyHogVBDYabgYMaPN1U/ep3H9YpLOUZSOHswM5YMTTo5NQ
	d1ipIWC4HMVed1ojN/xZcVhgSj5vIIy3u+6s8I2sCI7WvnwNjiq8YrOMAhbiIziv
	HuaYMmYC1sJUaAaZNSSZA8MivtTTOgkrG3iDz+gpibub+MO1KboS3OaWR7T091gb
	yZU2fEaqRzF0kcvRwituvK1O8VTo8gXWe5eA71fTodMVAcP7S0eTquGqJnqdMIxO
	tHfPLWxEEgE+N+J8jVFJRGkK2B+wum2KRAZGC2VOgHkwrtGNZehYjNjYLLVWgzRR
	sUJngnrRJoaFAzrU7+1Apg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6ven809b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BY5jO020996;
	Mon, 3 Nov 2025 12:32:47 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n83esg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p005eSyhGeVUx5/uffNbRBnY8eH7zctKF/H/x5vw2Avt6brPneO8n1IJY5CDa5lK5vJM8iS8pQouk/O6ZJ1dexgY5yfybxmm7RyOIPfU0ShUpZYMZsHHLKF/FXzGUmCJwq4QwufDRvU5W2R6MsvcCvP7Tf6tddmnMkveOg9hzq3/hzdMR2MWMhYRUno7x/sHh6pnQpi1u4gUS9xXT/ILxTNSCfVQo3mfExa9Du2sEdPb9FfcGXiYz1T8ZsC8/pEqXGFBcHYF5MV0wtVe53eHBiEqNQFzwAyiUM5+XUmUbtSGHgJwrob2lpbguVcHhdIJ/m/nldFcrykuPOpi2P0w0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvH+jJP+Gz965mvpFs/APDOgcaEOo3H79MwRURF5cS8=;
 b=khcs4y6HqyvEvoWf86IL0C+wUo7y682Tyn4rALYDRiu1w+hNur9cNXmAY2u3U6OkTDdJ6GCS0j7xVf7jZT6S0s/qfShw/Nig+C0nDubfxq0ULXRcEb9yrvQURNrl7Y+hs40oR0ZqfVhLkksRErzAXFw1es9ooNsgmnbYI/P/tyyzcG3fACHe9R+4kR+vkNRJV/cj1QO1b8A1MLGWqR3la1nnuU86EJCrPbrVm102LZfdFtaecMoUJnQTHsLcQg8/ne3G1h3XZhvNpXS//2W2vs0n+S82FqRCI5ZPQFFrUnaRWk++HS9o8TUKATQ1ZJG3OjTRLvzffgoar8EjLNIoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvH+jJP+Gz965mvpFs/APDOgcaEOo3H79MwRURF5cS8=;
 b=Hk2Y8DAlnXqCwr4W3eRho3pEENaqV59ELRSr8qlGIMMkVgL79hOIUaW+YsXjspPbaBT7AaVq4v4OIuC7BnRB1xVD/8te0eBi7oxM4blzWMi9gW3hpymcqviHW30RTjQxwxRQ5j5+zpIuP19lpSlaM8EiooTBXBKmfS5jZoa6ClA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH 12/16] mm: remove remaining is_swap_pmd() users and is_swap_pmd()
Date: Mon,  3 Nov 2025 12:31:53 +0000
Message-ID: <9685b7d28388da080af21919b8adeff0c4211e79.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0372.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: c5aa7754-22ef-4648-a9ec-08de1ad51660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IW1GR1ywC2wEJfvfVPthF5S/nmt51Zax/ThrIWfaTBXgeitE58Oer6PN2n//?=
 =?us-ascii?Q?6y44ukBGYjVYX7v5mE5GmMb+5DlQ0RaDBc0Z2B4tmGGcCbjLjg+9SiegV4Tl?=
 =?us-ascii?Q?mK8YmA6HS4Xvgz6/91pGFIj9s8Smi5GXGg02YIc8wyaQWrflsTV5GXBohTU+?=
 =?us-ascii?Q?4DDb/nSaYc0rREFDb3EpQ4HbKEcRdgQf0z8LdfyUke/TDtQHp3atu5KBPO9Q?=
 =?us-ascii?Q?eMWkRAbUs51E/EK/OSAxPKX2Y+8bPn35EbvxelJKqI7jQkqv9Jc1aA4nQ5sP?=
 =?us-ascii?Q?SeZzecUS21B+LNOWiPZfBrI5/bcNh3hoFISK6bDl9ul6eiO6v18Opsl5cyVZ?=
 =?us-ascii?Q?QH5xILSQyvCKMsOk7coOAXpjl0tVi7Xl/nz3w9Wht9BVS8ycLSYPrLMQhZfv?=
 =?us-ascii?Q?iwYx4mxiZiffKXN69zKYIl3wQqEwBct1l0iS5aYtx0lgWHZfVasd3KlI06OY?=
 =?us-ascii?Q?8QHpMqbj4bwLMETapOLdee0GTVNgBkn1VUlaWItiy4THlU6MyhYgDFXBSrV2?=
 =?us-ascii?Q?sr4q03t7/2Rl9Mei7VYNBqemlXO4DIkq6oSH7YghzmRYbLJUWCvZjuYlqMaC?=
 =?us-ascii?Q?iB+IWwj3Ewwp74N+GzagFD+WdSqgx9kBXbTlheuF+4Xw4a214TrozBdDbfJc?=
 =?us-ascii?Q?gDDQu/uAz1F9v9+cV1z63PUrUICwzAoRtYDjN6ggtW4s59scu2Jjk4CiKfgz?=
 =?us-ascii?Q?EGjv12HOKP8D2GrCSXVUJZMRr9FWjP/Vj+rue+QhnOJEN9F1nUlzYAwXzqka?=
 =?us-ascii?Q?vwzQDjuXqz5L+XgX+zs1qpCA35wcOfZqTHiI/3YitcHvvrcDwM0kQJWNnTJO?=
 =?us-ascii?Q?BlugEt/d2tTySImyJ6hGca2aYnGzsojGDWjL4zpwgHoZNgY5v49PhVnrmRjl?=
 =?us-ascii?Q?LfgTrRZzjaHsom+RZZtZCHAjCOdG1Yf4U4PrqzNq99hnzwjMdf2xsQr5blov?=
 =?us-ascii?Q?dSXBpn+9ispRO4WKa8yehr0jGsNc3fRx5xBRoP2uhqOo+KvSjmlSRJmOrlaF?=
 =?us-ascii?Q?BjMestFaUchxows2gYVcxefpNDZmy/GiR9p+WQlRFJIF/zPTQaK3dNG22VlA?=
 =?us-ascii?Q?VIOyOZ2HcquWviONCyNl5khrtYUGvnORPGTG6Qt0yMezyYmW+0UImR2zpng+?=
 =?us-ascii?Q?Ah7vYcC5nenxjWT3w7hHMeXpGq0MRZDa7nC3PDp6/5m3mvdxnyToHjoZahsq?=
 =?us-ascii?Q?dlYmzpPxS21ottANw0FcKFgfBDodxpZ0zr3qKhgVEfXHhBkA81UHN3xtdSEm?=
 =?us-ascii?Q?I/v6PonF4/US9FXfeEqPmvYnrq2YDGIrWdpZ2u7dRbtMCaTYqy8Zkfu1sGRZ?=
 =?us-ascii?Q?0W1aaYFz1My3SYKpTuh0yF/Nj+moarIAhMSjEWr9IRby+YLP3xFhLtOc43Zc?=
 =?us-ascii?Q?TQISl344ZaDGRxlNaoiezxERMAHyHrOm6TMEaSsHi5ludMJ2V5ujWMB7FrM+?=
 =?us-ascii?Q?xDdqNki/GsTbIy6WhGdfOvFJCRBEwbx/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6XvABi+8mwVtWF6s+dJ/pxbTNARo7m0Za4uWgccKvJjGLLi/T219ey80G3l?=
 =?us-ascii?Q?vCNuMg7FpioC2n3hjduDF8A4n51LE8lBu4wdrsoK8ykyokqw0v/R7tjBGP3R?=
 =?us-ascii?Q?yngpyHzGZs6bL1fLVMBmsR4j5E5r8H/Q4LLm5L75YUCH7PsBBKhc6gIIhoOj?=
 =?us-ascii?Q?VKigPIFIgH3bkBd28QgALThqOFN4f78eUjshlvvdtO5MqyNQXzhfKPlcuHU8?=
 =?us-ascii?Q?wg82VfRWcJWu2i0Wqd5m8ALkvu6wd+4SWQeDWNk65SB3Meuy5KThk+nFyBKa?=
 =?us-ascii?Q?fJr4z1xSaK7LmtPn0Y6TWKseiHeIw60omLfTkPvkkeT6e6WTqxamrmI/eeZ4?=
 =?us-ascii?Q?Uar8uMq0ELaFaQi06uXFHnjvCNha7m06qfIXQ88e55UNhfIC7avmRqvr7e4d?=
 =?us-ascii?Q?5rEyUzN5G6DVzdpiLFJa7UE9wrSqWPjBdXTJhhUNe6X+i1wczmYnGnoZ8HiV?=
 =?us-ascii?Q?TUwOxC3btXFn9GbrAlljl9nX8MnqfBJ3oEYXWIcr6xaAipgR+GdSora0yMLY?=
 =?us-ascii?Q?ig8fyUzNP3M3X7xAXh9TqOkkROtOg0z4Y0ka4H/gxJZg82rDWLSQKZowfjrM?=
 =?us-ascii?Q?2xYgRYF9VxKdGHHeSM89iftVmQDLbCxlG0/YKeqvzLCgWKY5l4+yKcTSjw6b?=
 =?us-ascii?Q?ImFn/3hDTcEgx94bzwKBv4xR9CCA0SBNX8c4PukFQJLiQwHXiBpzFsvMib2q?=
 =?us-ascii?Q?svi0LmgpbMPo7ADu/xlzj7brsNSFoNaMZ8J3myxGf0QDBwlBZF95AxFqmDRg?=
 =?us-ascii?Q?/rqb5Xz5oLuTJJqY/J+4ej6Kam3/dQh9OSK4750fS4VxKWEvoOyiQptQNaSM?=
 =?us-ascii?Q?1Zzo+qrZPFL19fI2Wf1ZewhZnjy8tRMvRSqjP7rkS00YIDUXtFMah/Kce5o4?=
 =?us-ascii?Q?OttjTXa/WdfdDr2bAeJk/qxhYVqNEbvReskRAETHubjtHLNZ7i1iJvyp+7Hl?=
 =?us-ascii?Q?gPY9fUs6Y940caXZbNnAnZZEHDu+pD05I8KDLdYZSFsVeA0fa5VNhTdBnyGK?=
 =?us-ascii?Q?ZTOj1NWuOyycRgv77HiG6xyrEjKn9aB0oEVLgeDyqv0qC3Fp9UkTthKg3O0g?=
 =?us-ascii?Q?9T8ogFOOLXHJS6xjAyf1u8maKw0INYc573iV62ajIiVU9ztZq7mXtwtCTKyU?=
 =?us-ascii?Q?erby6a/TbvWE0F8dvKt8norPL6YJYg3YrBOjWhiYxat/DFEhmKz2Z9ayZuKp?=
 =?us-ascii?Q?a5AtdOQRhdDBICCmZK2TytzR+adDoLGzfQpWf1BCbEZrXuJz1q5hFN1J+FUn?=
 =?us-ascii?Q?68ySSQ9Ml2IDPTikwHVLzMX8xFNfKlsIqAo15RBleDzKUmWGjpvEUx4L2f/h?=
 =?us-ascii?Q?qSxuSIYKZUzX+0IsR/MwlMLhNG+RNsh7OjUF5LHupVOfr7jeRNDadk/wKpYS?=
 =?us-ascii?Q?Sij2qWKAPbK+Haq/29oejKM4VYbF5DSTqT+S/XWGzjrFzPAC75LikweprKnu?=
 =?us-ascii?Q?gQhIjZ6rJRTl7NEYF+KAqkQE7WI2dMDjzMCuRVK/5RX3djgN8FuDL39B5Dvi?=
 =?us-ascii?Q?ygr+T1K9ZoHwaDA0vPNtt4Abo5/BHvm8VU+Bc/GS/MzJGANCddWJ2KowsBCT?=
 =?us-ascii?Q?sHGtE9XlL6zs6EmUI6xpkHfVQtsedb5981TlI59ji5dYOSdfYq3jqSeXE8q+?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I3icXLNLtKcvw2OrZNos1hO9ZziFmW/jslARwPz8shjXZTqY7RJvpRMljVVUs34ygsL8TWhH2B2IR30BBJxmo3ztR934akLFgGgeZZwn4i9wlGSadiFzvJKsrkCo46EDuNbUjNGa1kBG7FKiX4s9V7/2gFdIhUy71Sq7u/P4+fxTtIPo87ghiP86NUsxGsFQk/7t+gmui2rAIgKXqYYdG2ghW+LMaGMs/MZIMZf6vxplZ/pjd+etoJeOqqiKrKojU+NyuWT5g9CDMw8wGnjIOUyQFBYXF6zHLXow0XfmQPmWyegtU5oQu8mDwv3Q10l2vgOMoUdoo9MPZNrJL2+Z3+YmaS4gqEHWpUDbJHkI7Z7SxSGbR5TlqZSfnISSWgAxRURTqQR2P94ISovMZHmGztAvCqeg2R4LGm3bTkfeTuv89bowUNGkdWg8OIKBQghK5d8XS5+HjWhUa863Opoifo6agXVKp924xnCyAinZwhJNioN+75qQcXQhDC4hNE19BeLOYSsfpZqs1j5FznpZrRhnWJYExy0kaRgtUx0OVef/QmETb1aA1shiCF3eyEMhnE4TKA1XQ8nFwGMTGH8zrcHOxVZv7hJIEYTyMEpe7Z0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aa7754-22ef-4648-a9ec-08de1ad51660
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:43.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3/VWuHOIXZTQqScDPQOCSXKlr5zbC9zx/8eAJtF8MuHpYFkKEHaMwWmgTCDOIu6+oNVFWAPimWmN5d78Pttj99S7nCZQhfhckf9wxzyuoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-GUID: ns6AufHmCaktHUPsBZr5ZLOiK4PJZU_h
X-Proofpoint-ORIG-GUID: ns6AufHmCaktHUPsBZr5ZLOiK4PJZU_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfX71ifN4ftTSR7
 N6bgOOQNwCyFiBc4t9FqiTI8r71L3kT6Axfz3ASMM6wrBZx0C3gW8VcysBMfdNMJoHw5Eay1brZ
 s078o7gMj2uS2MlNbYqCzAE8FjOg3aEcl/Z57+NRc69HbDyEiB+c0vWEyqtm7pT4dI3FUzWsWwT
 uENePEzTNtiRjMpT//ocUxl7O/Qsg8jp225+o8FShJEcoC/H8AGhP+IUX/ouGOSxKK/PQ+f3z/L
 1OxkIMXhgRE/bI6V65xpHWvzeiQAamMZPjdmwqmCmN+KKMvi1+oKv+YaUWhClQ8r0Hn+cf/MfkE
 91uQPiLm05Um93Uy+l7GgwG0g1peL8fziqrfE7uLnTraXbFGPMpWNEJ1Ui8vlZChLwAAFQXkyhw
 o1gqNAsp+ohtXN0P/2kQH/MqsU7+1g==
X-Authority-Analysis: v=2.4 cv=MvBfKmae c=1 sm=1 tr=0 ts=6908a0f0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=EdvhSjy_mcwGFXzFEA0A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

Update copy_huge_pmd() and change_huge_pmd() to use pmd_is_valid_leafent()
- as this checks for the only valid non-present huge PMD states.

Also update mm/debug_vm_pgtable.c to explicitly test for a valid
leaf PMD entry (which it was not before, which was incorrect), and
have it test against pmd_is_huge() and pmd_is_valid_leafent() rather than
is_swap_pmd().

With these changes done there are no further users of is_swap_pmd(), so
remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h |  9 ---------
 mm/debug_vm_pgtable.c   | 25 +++++++++++++++----------
 mm/huge_memory.c        |  5 +++--
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a09b6d39f450..f381339842fa 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -486,11 +486,6 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma);
 
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return !pmd_none(pmd) && !pmd_present(pmd);
-}
-
 /* mmap_lock must be held on entry */
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
@@ -693,10 +688,6 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 struct vm_area_struct *next)
 {
 }
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return 0;
-}
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index f0f5fbc13784..8f247fcf1865 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -74,6 +74,7 @@ struct pgtable_debug_args {
 	unsigned long		fixed_pte_pfn;
 
 	swp_entry_t		swp_entry;
+	swp_entry_t		leaf_entry;
 };
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
@@ -745,7 +746,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
+static void __init pmd_leaf_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -757,15 +758,16 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd));
+	pmd = swp_entry_to_pmd(args->leaf_entry);
+	WARN_ON(!pmd_is_huge(pmd));
+	WARN_ON(!pmd_is_valid_leafent(pmd));
 
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_leaf_soft_dirty_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
@@ -818,7 +820,7 @@ static void __init pte_swap_tests(struct pgtable_debug_args *args)
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-static void __init pmd_swap_tests(struct pgtable_debug_args *args)
+static void __init pmd_leafent_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
 	pmd_t pmd1, pmd2;
@@ -827,15 +829,16 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd1 = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd1));
+	pmd1 = swp_entry_to_pmd(args->leaf_entry);
+	WARN_ON(!pmd_is_huge(pmd1));
+	WARN_ON(!pmd_is_valid_leafent(pmd1));
 
 	arch_entry = __pmd_to_swp_entry(pmd1);
 	pmd2 = __swp_entry_to_pmd(arch_entry);
 	WARN_ON(memcmp(&pmd1, &pmd2, sizeof(pmd1)));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_leafent_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
@@ -1229,6 +1232,8 @@ static int __init init_args(struct pgtable_debug_args *args)
 	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
 	/* Create a swp entry with all possible bits set while still being swap. */
 	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
+	/* Create a non-present migration entry. */
+	args->leaf_entry = make_writable_migration_entry(~0UL);
 
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
@@ -1318,12 +1323,12 @@ static int __init debug_vm_pgtable(void)
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
-	pmd_swap_soft_dirty_tests(&args);
+	pmd_leaf_soft_dirty_tests(&args);
 
 	pte_swap_exclusive_tests(&args);
 
 	pte_swap_tests(&args);
-	pmd_swap_tests(&args);
+	pmd_leafent_tests(&args);
 
 	swap_migration_tests(&args);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fa4cad7d512f..cdb410e8e13b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1875,7 +1875,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+	if (unlikely(thp_migration_supported() &&
+		     pmd_is_valid_leafent(pmd))) {
 		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
 					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
@@ -2562,7 +2563,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+	if (thp_migration_supported() && pmd_is_valid_leafent(*pmd)) {
 		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
 					    uffd_wp_resolve);
 		goto unlock;
-- 
2.51.0


