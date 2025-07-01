Return-Path: <linux-fsdevel+bounces-53472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0247AEF600
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1671700AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30113270EB2;
	Tue,  1 Jul 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyG+yavz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FMQfQiqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCA27057D;
	Tue,  1 Jul 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367731; cv=fail; b=c3hVp+B29rZoM2UL+kHByffY6IJxLETcVMZhtMV0aTXvWy42jWuTeJEDYW7sO6F5Q0QPZ11iIfx8LgCDNoeMIVopXgxt04KhPAbddaN7b5LmxPsEaJ9C3i/232WQXXJFekP4NVlUKugMdPg3HiDEJj7fDJpM658UIOjXVdI4UGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367731; c=relaxed/simple;
	bh=bRdKk8aBcN2fS6cHRvXh5MEoKeZs1070+FUOC3KWyB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=siAIw5qQf1zFmCMgMfDXx6XyaBLE8+ckHl0quV60HtUKMM6HC90Cr6JjIkPi79Vlng/zIEhOhVR6pc+1ojSxl9k0NL0eCy/WCCR8wmDp/bO3XLgR9e9nhpINkHvcfKTChSn9+mN3ZZTHDo+iKCjBnrCMZDmchMtbcIFoGJd1cmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TyG+yavz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FMQfQiqg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MseH012615;
	Tue, 1 Jul 2025 10:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TLM1To5zbrb2sv2Cem
	W5GYeQl0aP4XLVOsfmkJCQgoQ=; b=TyG+yavzczchG9lLx9Kf3EcMflslbLT26Q
	RnSzAvNKBgY6aPJNV/abNM0I+gOjTI0UQX9fIQ590+WPhjNO/kzviV8UqoJy8e15
	ejw5m76/SZkbXpaAnoDl7G1/4oVyBr9VPbkc3DBm123LVS+brOhFzIYxqAzXqwfz
	qZ9yuj3MiIh68VHVUBx3P5MhJM0d8wstWfJ+g8voHo97MbjZX8yHi5PGvan5Hbae
	Y2vfPzZ84rHKmdynARtYmY+/L/FyoomfWDZoBY9f7tdTddxtKR1d9G0x9DsTQ/yF
	PPJWASYYX5tFok1ueyKGwOz+w6IBNHsLQcTUBeWBNgAmW7Azu6qQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfcgp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:59:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561AiwVD017497;
	Tue, 1 Jul 2025 10:59:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1ebmtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx5dD8GH4hCjifanzKy1GTi7yBixr81pJuGWaYerdPYIk/vzNPD4Ve6qTAzYbtz9S1yr5tVtL8RFOCBIbNhpKGgEbZqXVAMR1iu4b8btQo2MUTwToMq+enVzkEFiUqVDdkVNEpaxE+AJC9G5Tx8fz2Yebcp4Xn1nzTPteeJXoRJm2tiOpztDZoFabNlY69h5yfEBHpdWmTOHwjTJeHCMmjs84+lC2PvLoeOhUtLWHZ6ib5LfJC9Hw3YqQzZUN555SD7q1lnMg0WMIniOk6C8fBE/7n5YKQvX8Mn+vE9p90iMcprzPxicjXYRQsC1iCzq0oM9thi4aHiPMiwDap2LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLM1To5zbrb2sv2CemW5GYeQl0aP4XLVOsfmkJCQgoQ=;
 b=KlGPjADSYLSocKREaM0gEhq7AGPLm8NUYq5qSMj1U0hxnbIYtYOEcfuS6JkjkvQsR4nLo3mcJrQsN0n4WcIVMXkcNEHjilZNrQJ6qA4kTKp3l3/ofAwRz2LHmrDzWrb8iN/8Ea91HpoqWW4nQvh5/Th6lFvgtrpZ/XoJj0bJcFz5zZeR6eFwX4rzFrrMLbF7Fw0g1G1RxwushdbKFNc53Zf9tQTm8q+GQHkh1n0Lo/ku9NR1D9Q1qntUh5Qrxz6fCdfqX5lbRVErHLKgowrOC81Us3Dqm1t8OF+2qUP2SO4gvMJmkgidXjKNolwfSDA5qQGTdeWofohpq/oVL03PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLM1To5zbrb2sv2CemW5GYeQl0aP4XLVOsfmkJCQgoQ=;
 b=FMQfQiqgXRhva81/7ojDz7GqIUoUMIIPIXDyQaYZek61+VNz8f+GAiBzfPHGWqCChYp20h1uaAFqXdo9wnoj0WuIwbT33r8+zKa7vc0hHIiDVmMr1FTgfxketV/lSY/EgtMJZfI7tGkUkpRc8OOtuxHo4rloOQFNInFG2OcdYLY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 10:59:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:59:31 +0000
Date: Tue, 1 Jul 2025 11:59:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
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
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 16/29] mm: rename __PageMovable() to
 page_has_movable_ops()
Message-ID: <9a6b403e-ac92-4e4a-8d72-86dade5b9653@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-17-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-17-david@redhat.com>
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: b1496582-f002-4b64-3ed0-08ddb88e5b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qvrz23FNcZx6I14ZWicx6ke9S6vL3NORNxInUDuiCWTlATp72IBkXUWl8IMa?=
 =?us-ascii?Q?Hti935jFUdnFNRL3UpGwlSEUto2zqPCweAGo7KhDvqUNxz/AfFUqmxOSC8+s?=
 =?us-ascii?Q?V13SxmwuP8ada6GXuVUD73Mf/4D/DqR5L1BKbtfHf252B1HkCynOHe8BQ8ib?=
 =?us-ascii?Q?jlCViuJewxavT45FOxdwANApJY5v1bhlmU9pDlOPWyHynh0SJkyoQ5WZJkuz?=
 =?us-ascii?Q?5sHFNVBrCncn6MROStMjJ9Lkp+pJQRBMZpumxZn4Z2wUNk3ktpy8h5OoFNKZ?=
 =?us-ascii?Q?dNInoG2euVNWsNMQObo9VJ2mF1S2JyP88+mDcCJG6seOHSEydUbtLJIqURm5?=
 =?us-ascii?Q?QJytMspn/Q756gFnSdwtgBZhk77FdLarO5cWdb+DdkEzNZayDn8qXhkpNlpo?=
 =?us-ascii?Q?C5Usi9nRLwq+UiiLfEa91cs7evxumNFylriLho35ubVDniaxe+asEHxg6Q/f?=
 =?us-ascii?Q?Zoqm9Yd53CJpPVMujrJO5umg82GWHpUjuLHmwfegX7qOdX0dE19yTGqES1X4?=
 =?us-ascii?Q?XIikjM6xSYnxpC6kpQyENcS7WC+oz5oU369aT5y0Ge0HUDGu5snBQFUxnfNO?=
 =?us-ascii?Q?hXsdYH7oIuWvfynReCxyZso8D2FfL+sPF8USSljLlgg8znMf36c+x+6WU+I/?=
 =?us-ascii?Q?5r49NQXtMLsTOQ6jhHcGwh4oLoS5WpyfmOMGs7oTNfF+PHMGYFxCgAesygzT?=
 =?us-ascii?Q?FhTiQYNX/yQ4u5qzNqeKEKG9FDTsHMpP3h2SsKEw5TP31PZjJA3RQ3MEvx46?=
 =?us-ascii?Q?+D9aUvaboPzRirUZ/d8aMpsvk4rnDcs6RvZGrwti6IzLJ3+Lo0mGouqNjwvs?=
 =?us-ascii?Q?3LnbR3fwid/stoLBvoa9IcBUecnWrtVEyuUwmX3p42kFvs8tzsNRfVjw4u0G?=
 =?us-ascii?Q?qHQJ6SboKIu4/bRS/mYiDSb3M8lD9jfFxU4fGVYAcFLlk3xPwOt3aex9EyWd?=
 =?us-ascii?Q?BUhVj239LYm4ipW08kWrUzLw3gKWHg8ZoqctHvitM6M6vU8+ZnoWypCdBzli?=
 =?us-ascii?Q?/BSoMNYg7XaFmr2ShqdI8fR0uycjZQOSD7dEfKp8Z4OWE5DQGPOofIs5XNdO?=
 =?us-ascii?Q?jGyz6uKEH7xAvVwce0tkkuQmletALmuiSQFys/UrM1o5OawY5dIJ4hvCQcj1?=
 =?us-ascii?Q?4zZmSxfJKO/fWvCPkqqoFFdHH9FedyG9HIwEWsZntRGeFtvIZnHoLmloF5k5?=
 =?us-ascii?Q?dxaeTsqLzGqJpgwIIrImM+/zL0AysIJiZSNIpqUoHgmO1MeHviHp950AyujE?=
 =?us-ascii?Q?/rV27XNhCBEgnQxSPni0a7r7TzRbnNIQr1866A+BjQcVNPvhidFXC6y9t/cd?=
 =?us-ascii?Q?jdMBjxOrLxInKehxIfDWG1H6ULcL/uV/B9Zp8+wztRGs5WAO6DoGEq5yXRem?=
 =?us-ascii?Q?b9n/7hW1LPzvGYGiMYyKrdu/3Zd8AvJDXGDeuMDwZyBs++sPw2ycFaIa9Asr?=
 =?us-ascii?Q?O7CcbkdcNqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4uTZoyw288oHrBvU86HtBoFcXfJcdz1KvOotAeDNzDNUDq3DT6Sf+NzGmA+d?=
 =?us-ascii?Q?n1ig3ZdJGF+xqQNxcHjQmNkB+5iAVec7QVRdrg7WDcQ3Eqc1Gx5LQzxwRWZR?=
 =?us-ascii?Q?JmoRde8zJjZeiGDOO49uS2pYRO6PY6tEoCrCXYgz3IHXboV72NhpI/pIxbA/?=
 =?us-ascii?Q?xYxKFkjSCzJ6rQlsdhfE0hEmpH2O4oDFyZ+eFLhW77eF9pHCE2HIPhBVuOw4?=
 =?us-ascii?Q?GhpyjR857MQvd2hIpFGVjWyIt4sVPOCd4zKKsLl1V8N+5Avcc/ZytZ/0LiVa?=
 =?us-ascii?Q?g8NstNKiWMYbgjPYQMl/MEHSyBsGHh6e3C09HMyrLDWCNz3BiHkssr7RcEsn?=
 =?us-ascii?Q?BS0ZWyQOsop2ouWuNlriGVCTPzK36y/2MXNiGm0yh3v1EYm3KVA4j5d89li0?=
 =?us-ascii?Q?cZuDjFXyPMC3Ui9QFpbG03TpnBNPNWiD8hZ/tEmgnk9e2anPYSacDSKqD/jP?=
 =?us-ascii?Q?HkCP8+EpuH2atiPItPfSgSE8oIzs3FI+kjewHrC8zh34khtyWaeDyPgA2CN9?=
 =?us-ascii?Q?7OwgZksGqPKXb3b8PmXiEmcJQ6c1GqGGYT6ze4NxIlA9lzT+xzM/mtjGw8bi?=
 =?us-ascii?Q?E5guWpl0+090cWHE8/lRyGGukC9ADci22QBZGiWCbYC73jeSchAbiqTGqoPk?=
 =?us-ascii?Q?yPOqVWx1XBApHjO3N9LEIRbsEQlFzFZCpgc26oW7/4VvzKmPY36X5XsxZ2yP?=
 =?us-ascii?Q?1CdGqquqR/xX15HFdxNyfchlJjs6LabDSvqp+44mlCL0y/HzVfM54eb6BDiL?=
 =?us-ascii?Q?MaOW0pDlnIy+GJq9pNBWd57lymXxIHzS40uOC8uNUajTivCM0TYXbs7PMhzT?=
 =?us-ascii?Q?7IZxJVoTKXK1TBBJxc4jIteQWg5yxnV2O9pqGzRJrw3dEmy6pGEPxq2QdoVI?=
 =?us-ascii?Q?xiiAyT5snYrGtKdo60kTVJVCywK7OYdTSw1bLd8ec2+v2BwbgN3EnxzD2ag5?=
 =?us-ascii?Q?BFfPSEkjgcz+SGqdSPtqVLg8xlW/PYYX2alsryGvsupctOYnJVr8LwfETLyD?=
 =?us-ascii?Q?3TcQs3W52dzCHevPrgNW/JzRHXdR7Dm17C2/+eDsbM827p180edxLnxD/AE8?=
 =?us-ascii?Q?kCxshcJPkhfo4CRY66uFR82VR8BaDOs1xKjEuM0dxSyDngLXvVpuMAstLJAs?=
 =?us-ascii?Q?2ikdVznYmdU99VJZ/oDVKk/UdqfWmDTel/Cecx9Ut/CiCiJkq1dcKXFBedMd?=
 =?us-ascii?Q?HHWeMWmYe34BSbaQR8KWT8PG9huVw+jiafJdzvBYLwSNp0A73mLTqCogNxj4?=
 =?us-ascii?Q?wQbfytJ81uC0Ii67zhFEc5g64h36Cj+Xb8NscBdvGdBjWyLZiJlt14DR6f8/?=
 =?us-ascii?Q?PKxYE+x5MclrvzhCf0dZo/ykvqTq1I4gkgEtzirzdm0tACgxxjIu958LmrtY?=
 =?us-ascii?Q?pPK14u00JawupB/lXyUe6cB4p8HDOeFGy2JF8oFqnqkIs64gH6yYbnY1McjY?=
 =?us-ascii?Q?AIR0RzUtgaDf5lmmyZkzwDzd0jDvavedjKx6LR8aw6YERZ5FLd+y9cJN4nvs?=
 =?us-ascii?Q?6bPfhOArxnHi8anP12Vg5a4OJ3WWTp7UmJEFekCHPIoM/561CapOYJA0gChQ?=
 =?us-ascii?Q?MdQqUDHxQB8bMCNsOVUjBakomaMIXyS90pSKWFux/f0LTB/oHGIwFXAtWU/e?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9/SbEn3EjIM+C08grN58uYvivm99pT/ZcBl+vsPZgSj9WTDViVjlc1o9EoO97AZ8tdya3Y02mbU+quchgCLwGQlFX76JBLd5pzJZndsfRG0AI6dwQ3Kup1ZJlsppreuLg2cS4XEJ6vVwNwam465EeK0w477bFADVM1COJBWW1cLkkd6IvyAEWVal3dqwUoBRIqBPCC/1AiRyH9nquQDnQeH4YvuB+x9eJ+oYcYtdEguYFvcyuORMP655/VnBjWWqeFL1k3zenruUPttMaqOCtXzFTusk/Kop6a4nJMN2YXj3KH7570+VrHbDRUGKl6SgLH2Kuh4HoYh6SYt01ngnHlKejCYb0K+3bwRQr3WI/qbyE7KIdRVg/OST0FBlsGizLn/MvImFdgxJ6wNbwp0pwDOc1Bo+yv7ojesAiI86LetjKNCVcNOfKanYXRdRfMBxHSweILSN8+GDbQGntJqtNa5zxPCqT03ijEjR5DEIOKZ2BemPtIl/YOjC2w4r476LbPHFUuusNrWJy0X25esAru4e2FnJcNbY0GJQFAoVzBEMB6DY+fvg00ZGD3JHwmpBe2J2zNRkSpA3FCULgOcxqyDiIFfHnq7uagGLv5e+6CU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1496582-f002-4b64-3ed0-08ddb88e5b57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:59:31.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bKkwTBxXcllTv6EMpn+PV1ItP+tWSeZWoawhAH2uKwFHaFeBImQzehvN0X/qDaFRzco8MVdTriu5scklctJ7guuLK1MZIVvM9JEgNINgDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010067
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6863bf9e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=NJBbdSwX4AhB4g6Zey0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-GUID: Hl87dvufaifrRanHG5sQGHzxV78R9Zp0
X-Proofpoint-ORIG-GUID: Hl87dvufaifrRanHG5sQGHzxV78R9Zp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2NiBTYWx0ZWRfXwhCdsE715+LX MthYXxYfKD5fxVepKEdaQx9Ilcl5opzM4PuCEAktRr9wOoGMZGjsa4hohYQ+E/Q7GS9caX8urKC K1R/KdBCpqv5sGRhq5gsl+oWFHzA+FokO7Op3fsj2+7zCFx4cG+pG1Qi3WBaQHXnPA3DTxIxgqY
 LQMn0yjsANR9WwoAN1XqsYah61Ucfk4pqlJTv0wD2WbWwjXyPIQHAgNz+76z5oUfHUN1eJRGWmZ u5n/n8OwukaI9aCPUgphgwqd5e4+q5d5+5UpMLYT6EnLsmkofSLBmwb/hTad0aS/JikknrhrjrB RL555tT7GlcudO+3s97FZgstMr1t90ssHRIkthTdo7NiweisCgVHeOqbQT84k/CSb0HPPUyg2Rx
 iy/IeEDREE7pd25UlPnEa+0kkCtvX1b5UCTrH3ayvavrI4dXpMTkzsBSdFjKL9HUjJzrssb9

On Mon, Jun 30, 2025 at 02:59:57PM +0200, David Hildenbrand wrote:
> Let's make it clearer that we are talking about movable_ops pages.
>
> While at it, convert a VM_BUG_ON to a VM_WARN_ON_ONCE_PAGE.

<3

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Great, love it.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I noticed that the Simplified Chinese documentation has references for this, but
again we have to defer to somebody fluent in this of course!

but also in mm/memory_hotplug.c in scan_movable_pages():

		/*
		 * PageOffline() pages that are not marked __PageMovable() and

Trivial one but might be worth fixing that up also?

> ---
>  include/linux/migrate.h    |  2 +-
>  include/linux/page-flags.h |  2 +-
>  mm/compaction.c            |  7 ++-----
>  mm/memory-failure.c        |  4 ++--
>  mm/memory_hotplug.c        |  8 +++-----
>  mm/migrate.c               |  8 ++++----
>  mm/page_alloc.c            |  2 +-
>  mm/page_isolation.c        | 10 +++++-----
>  8 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 25659a685e2aa..e04035f70e36f 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -115,7 +115,7 @@ static inline void __SetPageMovable(struct page *page,
>  static inline
>  const struct movable_operations *page_movable_ops(struct page *page)
>  {
> -	VM_BUG_ON(!__PageMovable(page));
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
>
>  	return (const struct movable_operations *)
>  		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b2..c67163b73c5ec 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -750,7 +750,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
>  			PAGE_MAPPING_MOVABLE;
>  }
>
> -static __always_inline bool __PageMovable(const struct page *page)
> +static __always_inline bool page_has_movable_ops(const struct page *page)
>  {
>  	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
>  				PAGE_MAPPING_MOVABLE;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5c37373017014..41fd6a1fe9a33 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1056,11 +1056,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		 * Skip any other type of page
>  		 */
>  		if (!PageLRU(page)) {
> -			/*
> -			 * __PageMovable can return false positive so we need
> -			 * to verify it under page_lock.
> -			 */
> -			if (unlikely(__PageMovable(page)) &&
> +			/* Isolation code will deal with any races. */
> +			if (unlikely(page_has_movable_ops(page)) &&
>  					!PageIsolated(page)) {
>  				if (locked) {
>  					unlock_page_lruvec_irqrestore(locked, flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b91a33fb6c694..9e2cff1999347 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1388,8 +1388,8 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  	if (PageSlab(page))
>  		return false;
>
> -	/* Soft offline could migrate non-LRU movable pages */
> -	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> +	/* Soft offline could migrate movable_ops pages */
> +	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
>  		return true;
>
>  	return PageLRU(page) || is_free_buddy_page(page);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 62d45752f9f44..5fad126949d08 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1739,8 +1739,8 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
>
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  /*
> - * Scan pfn range [start,end) to find movable/migratable pages (LRU pages,
> - * non-lru movable pages and hugepages). Will skip over most unmovable
> + * Scan pfn range [start,end) to find movable/migratable pages (LRU and
> + * hugetlb folio, movable_ops pages). Will skip over most unmovable
>   * pages (esp., pages that can be skipped when offlining), but bail out on
>   * definitely unmovable pages.
>   *
> @@ -1759,9 +1759,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  		struct folio *folio;
>
>  		page = pfn_to_page(pfn);
> -		if (PageLRU(page))
> -			goto found;
> -		if (__PageMovable(page))
> +		if (PageLRU(page) || page_has_movable_ops(page))
>  			goto found;
>
>  		/*
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 040484230aebc..587af35b7390d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -94,7 +94,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  	 * Note that once a page has movable_ops, it will stay that way
>  	 * until the page was freed.
>  	 */
> -	if (unlikely(!__PageMovable(page)))
> +	if (unlikely(!page_has_movable_ops(page)))
>  		goto out_putfolio;
>
>  	/*
> @@ -111,7 +111,7 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>  	if (unlikely(!folio_trylock(folio)))
>  		goto out_putfolio;
>
> -	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
>  	if (PageIsolated(page))
>  		goto out_no_isolated;
>
> @@ -153,7 +153,7 @@ static void putback_movable_ops_page(struct page *page)
>  	 */
>  	struct folio *folio = page_folio(page);
>
> -	VM_WARN_ON_ONCE_PAGE(!__PageMovable(page), page);
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
>  	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
>  	folio_lock(folio);
>  	page_movable_ops(page)->putback_page(page);
> @@ -192,7 +192,7 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
>  {
>  	int rc = MIGRATEPAGE_SUCCESS;
>
> -	VM_WARN_ON_ONCE_PAGE(!__PageMovable(src), src);
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
>  	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
>  	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
>  	if (rc == MIGRATEPAGE_SUCCESS)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 44e56d31cfeb1..a134b9fa9520e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2005,7 +2005,7 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
>  			 * migration are movable. But we don't actually try
>  			 * isolating, as that would be expensive.
>  			 */
> -			if (PageLRU(page) || __PageMovable(page))
> +			if (PageLRU(page) || page_has_movable_ops(page))
>  				(*num_movable)++;
>  			pfn++;
>  		}
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index ece3bfc56bcd5..b97b965b3ed01 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -21,9 +21,9 @@
>   * consequently belong to a single zone.
>   *
>   * PageLRU check without isolation or lru_lock could race so that
> - * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> - * check without lock_page also may miss some movable non-lru pages at
> - * race condition. So you can't expect this function should be exact.
> + * MIGRATE_MOVABLE block might include unmovable pages. Similarly, pages
> + * with movable_ops can only be identified some time after they were
> + * allocated. So you can't expect this function should be exact.
>   *
>   * Returns a page without holding a reference. If the caller wants to
>   * dereference that page (e.g., dumping), it has to make sure that it
> @@ -133,7 +133,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>  		if ((mode == PB_ISOLATE_MODE_MEM_OFFLINE) && PageOffline(page))
>  			continue;
>
> -		if (__PageMovable(page) || PageLRU(page))
> +		if (PageLRU(page) || page_has_movable_ops(page))
>  			continue;
>
>  		/*
> @@ -421,7 +421,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn,
>  			 * proper free and split handling for them.
>  			 */
>  			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
> -			VM_WARN_ON_ONCE_PAGE(__PageMovable(page), page);
> +			VM_WARN_ON_ONCE_PAGE(page_has_movable_ops(page), page);
>
>  			goto failed;
>  		}
> --
> 2.49.0
>

