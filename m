Return-Path: <linux-fsdevel+bounces-53505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02305AEF9C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07353BA914
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E7274661;
	Tue,  1 Jul 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SknvAKOT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZFLW3cUE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83314A60C;
	Tue,  1 Jul 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375261; cv=fail; b=DKG/OqxN45rBC/3jWzf4yffgzuTHqO4lpaht7PTJydosF9o6YREk05SAaxexGemz4NMLk2Kq0mri6CkLdoO1sWPcJ+P1AQtVQVuArKn1Ss2NZXvSs81DFz4g59Te3mqQQdJxDzLymg9kyijPL5PzoMPzYdbg8zg9aQLJ9Oqj2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375261; c=relaxed/simple;
	bh=uiZBaHPEcMGhp/3Sl7ynIBoXRXcyXSZPFJ+67/OtG0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyKQKlr8+v4yLWicBnxCgT8lC5tzr1Ye6HzQg7ilsAA2r8yFcOPhDbKRxKbIe8+jEeqeH46E4UuUy4apFVrQJ15H/A3XrJTeM3zJwiY6r14yoh++Q0RyxicZ2Z2r5blyhrDPzpsEGTff2O+upzy7vhNZ9Q9X/ZeWIhD8IhKa2k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SknvAKOT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZFLW3cUE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561COdGv023930;
	Tue, 1 Jul 2025 13:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+WsnB8lx0cYw1xoAWz
	eJ1RtB0ZabPp4rbT+ZlF4FyN8=; b=SknvAKOT5M7hcjhrgk9JusK2eTSl89Gp2G
	DUXGxv4ZB407hmS7zLKD32J6HaeeSFaYswviofrMeQj8iyBIhs3pnfi/vAHKotKq
	69tQF+hr8dJ5UIelLWK+I3YPYxO01sSs5a17Ioal1zyBNg5Ds/gv83U0D8SItY0v
	OT3txr4UJx/C5FV+ORIviIFszgFaRI1HFB/XAQu1Q3nzAhNQpn/MS6Q4m+zVWi0m
	dhBBBHZj6zI47niEk5H5tag+g0BQEVgJBvW1rvIfwZ9QmpqfjZRVEIk40HOq+9OM
	D8yOol068i6uhhOjnwZMMjuSWMeRIYOsNWWPFwLh2LKjGPEMxTaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4qx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:04:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561Cpoq0011494;
	Tue, 1 Jul 2025 13:04:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9g3h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGz7kZocgmkc+nNjxPiTLAUtIEVl3RkfPrnx+/b62Mb9rNQgGUizkZYLF38vDNfP7ywlzMAmLC9tqF74fKGq+CyKQNlc4Uzne3NtBPIDPJ3+jfiz2HumLsvs8j/jy7dfpMGax+LpS9HS1OeStO2d7MvnYZm+/I1/v/g1jkQOYWDCW75GqVxK+0yo4+uQHeeckVi/3X2CT3QZwa1FjU8PZOyARXNzWQieSYixZH3ckK64f870E2tAKk/FwObfcTRRnBIY0prbKR5XQ6XeE73BszvYj0N5vPzxpqSnQ0zemCqONm5C5c87noucGwvqqGPVljw1mgByQacFY8wbhztLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WsnB8lx0cYw1xoAWzeJ1RtB0ZabPp4rbT+ZlF4FyN8=;
 b=OXsA5c0/+HpAH7i+NVkloaR2Ktyw9qlVMcKM4Q2ZU1ilSWmAYl+W2LIlOh6tjqgwCPby7Txp8fhSewmT6gy+C0t2OPePqEDkcsF/YDm6gyWqh8hZvNhoc30ufzmYAEkoMzhQ9vILjdmjXZczBuyFcrSD32TA9S50jUzNcZwHBSXuSHYsG5ZvuuElzzs77Schc1ZOydI++kR3KyUqtsRZuQw9BWgVRpSx1QZ4NEqmBNjIfFoU37sDOYRXecW8KcvCmbl6/Ux0LwKIlEFF4BtkPGeec6QYKa6re7sSPDpbyTMLOOTon6tO+DbME3KZh6o3ae59TPcSxJrN/DiA1d/98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WsnB8lx0cYw1xoAWzeJ1RtB0ZabPp4rbT+ZlF4FyN8=;
 b=ZFLW3cUE/fJ3rC4JR8tlovkxulqEg6/ECKaqCZuMnoOqYqwMGwwPVAYzmu+gwaUG6gJMoSM6OHc34xNy+LDF+gGGOJCrHXUk19ItFUkIEdbjy6k4dWCa84nelGaEiCvnvC+UUdh48ltHq727kwGBiO/iCiHI3WDapIejAmvXe1o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 1 Jul
 2025 13:03:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:03:32 +0000
Date: Tue, 1 Jul 2025 14:03:30 +0100
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
Subject: Re: [PATCH v1 24/29] mm/page-flags: remove folio_mapping_flags()
Message-ID: <b830f284-bdb4-4ec5-a93b-6911cb53823a@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-25-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-25-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5f310a-21d0-4c3d-b744-08ddb89fae89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qk/yfpbnR+zrIJyxDoxyoGRytd+VfQm2haL2LOaGkkzHzH55leFsYJe9zSIM?=
 =?us-ascii?Q?036q4vTGc+nodxvzcyTAlppxJl5F+076ZEdpMQPBpPPMYF90tnOZzedLEXt1?=
 =?us-ascii?Q?IGVGbLmVOmjtsaArxlaWW+NINNIcf1sxmkvU2q6P16wu8dddotPrC1j6qsB9?=
 =?us-ascii?Q?g+JWe+SjwhRSv6T8ZNXzgckJHKIAv2KJGKW5jxmkuZZj8kB4RPByKDUeqASy?=
 =?us-ascii?Q?vyhuNazzn3kd4oH9pSzvNPZD7U1bq/MCEmxYGNf+YlXH+MqQJvRjrcLkXY1H?=
 =?us-ascii?Q?BRzDYuD0XeSRxRtd2Oa1A5w1H9CK71IJ5uI+gcWd+Q4ZUTW6zRbymVcyOW6r?=
 =?us-ascii?Q?SYnUYn/GkSHVWshwbf2kLF9nYhbaIY8AFSyWi93EA2ChhPq5wOomsND1X3nm?=
 =?us-ascii?Q?GsyGI0pYT/0j7TKfWHLHyKuRTIjeAk1YuFiT8AJEwzrc3bxKBa3aq4LSu0Kn?=
 =?us-ascii?Q?tdjsKW+zsYa8FW7o3NAqJozHtosJSFNbbDSms0hFnNTtt2BaUUN+zfMpshP5?=
 =?us-ascii?Q?W/DX11/n8t/VV/W7D3rOTDJCHbqnAWevg6je40M2MWa4zcywTHjs3M/OFZuI?=
 =?us-ascii?Q?gnd9LuTpr7+DAGpJ+X58daPqDcMuGlV0yCgF+uWCrWTauVDlHhYSR9yUEXa2?=
 =?us-ascii?Q?3jw/EjtljDdxvnln7FdN6iEtTBhYApjIMeFkAUjLiKr4RyrUxRTMCnyU0DE1?=
 =?us-ascii?Q?o8T1Bp57j7D2w0MJUuHHWsO3wpUXeXJ5XlHAscd9SkME64f9dcTCCNwmblha?=
 =?us-ascii?Q?vCcSkgRzpxjU6ybEmQSNDDBC7ZoBnX2KAMUDNCSC4D7tuShRvgiDYprBf0GZ?=
 =?us-ascii?Q?uMH/quuaKfvOxlBY3d+qR+wGxcQGvtZWEIk1rKz+CCCaERpIXXa4bFk1jk0t?=
 =?us-ascii?Q?SNKXphXauANQNhXKR5FBaXBH9+hSCWyaRBASymbRikYKTSD48mb6IkvZsqsY?=
 =?us-ascii?Q?djl2O8FG/pkYUpSARELpMqppv/R2V8vaMlSWHR+bLBLCq0j0Uh6CtzKzd9MP?=
 =?us-ascii?Q?WlDhEO+tBji1XnNzeSYDdDWlNE3NeJTTkvhFWYTnSegRs6iS/7BcEOpfvPQf?=
 =?us-ascii?Q?TssOMzDMuuaw0J908NOzhbWnA6a1ZfEKNgfZDqjpcl50RePoi+h+PDj2ygNp?=
 =?us-ascii?Q?Ux3jpVrp/kjDm6yZpCN0gcbZ3m5FyeY5qdGd2f8Qsj5Esnh1iE/er6n3zvHT?=
 =?us-ascii?Q?VO5ZhcwDGFnftevocPa1UxSCkiLVhm/QSmUGOrcvQBHlhFflhVmAAEGR5++Q?=
 =?us-ascii?Q?zAMOSXGlDjva3v+N95spj8zd1nIwiwnzRnGEa+ept/97J2m7CWtgdtpB/W5U?=
 =?us-ascii?Q?Wm9OuJoLrV5X+Pa2axjfokAEiO847HOkhK6wrmOY3exJ4fT8o6fLmfuW4HRl?=
 =?us-ascii?Q?WcREetMghZ3HTtOlyodb8KNP3Lw9myLCLzMpiHmrWit6gey8ug1rSzUVnxY4?=
 =?us-ascii?Q?hIKCywfqAy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ceiovX6fygwP6D8OPYbvTtCuRsxnIHUnfb5s7lYegSfxPnP3Ue4hcrVEfXt1?=
 =?us-ascii?Q?7HhVFWwcborHwxz52emjf4fJcsnFQuNh3fRfGggYhytYbKeqry/0C7CjEsIf?=
 =?us-ascii?Q?0a+n1Ra6mOFlCUC817TsDaxVoCrbYDo97sVEj0h8kLbd2yCWQ5Lnw2aAoXxZ?=
 =?us-ascii?Q?QkM90hhSHOebbROI76psgUG3NP6CzbJomRInFtlvHGK0zDgsAV2bn+XBf1Vr?=
 =?us-ascii?Q?gnZjJJ0TqvMNIHrlDa4rVmCq5VLSW3pVaY31/zaEo2tRuqCSLAyqkozuPnD6?=
 =?us-ascii?Q?JHvwX0S7aig8i8YSe+x+WIjgwvKDm0PdsDfci5nQF0px+pKHoGzErpvxJQ+t?=
 =?us-ascii?Q?BvGJO7KNDyIJpO0wdR+35u736SCJZQ63mrpckcBvs5UikCknaqkAnVBtFqYA?=
 =?us-ascii?Q?odrjC1A92tqTtEoIFbq22oZRg6qNJX3u+nQpCBQj61zrsKDVie4o04f+0yp3?=
 =?us-ascii?Q?1NbCUHYUDHZie7M1NgBR4N0WuABXvzeFA8QKvrDw9MfqarLMmJKDEszm3v8W?=
 =?us-ascii?Q?UaAj5x9wxbVwte2HPpgIUfvFvBS0Ajazq0qlN2OD9joK6vzSHrXAF0SXl59d?=
 =?us-ascii?Q?KjdD8b1XOOlhlvH83rxeQxB3uEbH9DMKVInSjZ28Or2nCAZlDQ0JGssHdHTm?=
 =?us-ascii?Q?McVfTYVsgxzskAnLA6NnA9zzsRwUb3yfdUkd4RdxSSnnnH3cvDt4Y8VhZLOn?=
 =?us-ascii?Q?/0t6dDOD9pnn13GjjzY4p9OFckLtTHW4xwX4j/+zY5ttG9nZV6ez53UHUIKa?=
 =?us-ascii?Q?jMWLpba1pfbU7kcQjueLyG2atv9F1awqMwye+rvqKDglrWPqub/Zd7diKEXo?=
 =?us-ascii?Q?RkmQJl46kz3lbatKONxW0rTztG24f8F0a8WQIskvr6BgTIJ4UHEe+parM4IZ?=
 =?us-ascii?Q?wn8FKnZqNW9zxS9EdX5+qKGdySOqEi+uEhpaSEsHRFqFrBMwZ7ad5uQqZJsf?=
 =?us-ascii?Q?dRlBx82uLwoz+/r9lIEChTNkSs/08zI3aNIom4iyUkls2yKiHmMoEQWsxXzG?=
 =?us-ascii?Q?xrv6h4T9YU+oGfKvrIhNjq33jYTaMy+fHZ+PZZsMSUBOo3cOskKJQACOxo7Y?=
 =?us-ascii?Q?Wr84IspPHzeLjkYYaBQgK8NO18aUdiNl+Pl92RhqqH3ndBzENv56zBAe/UlS?=
 =?us-ascii?Q?dBVJXQ3vOe0NdjT5YMQFrxtAb/uKDct6fQKjMg8g+GtG86o/zKmUsPUeh2a6?=
 =?us-ascii?Q?xguXkR3T8sTIf+/ksdW68RHvnf5fRhCs3uHexaQ3BXQm533zHbZ5/VAv8Lzw?=
 =?us-ascii?Q?A4/C7jNinITL55NrxteAJfgI8lxjZYiR+SU1XJq5VdDAcsLIaShP95+zugYw?=
 =?us-ascii?Q?rWGgrnweQ9TjsRlFOKCbICRrMUWVwPCqAc+SD3QtoUZFAEw0pHRWDDrcAReF?=
 =?us-ascii?Q?9qXrBU/CvM2Pv+kzqZ6IQX1AU3CJ8ChiO3T3ILItPIZfFkfMo1itCvdFHOaU?=
 =?us-ascii?Q?xHJuR1NrVn9DeSWF8+L+8V8iJdiyS8sMeqyVCL4KE73Yz1x5ABtS5diM6dKQ?=
 =?us-ascii?Q?JEgNdCEqx/12UeLKs6niJC8/py7qBuzl7XfdbbzfLrpImh8bNa9kzBZvXM4l?=
 =?us-ascii?Q?xcDjuHaxY2Kwih/w+99vaORQLnrzUFmlTnFPCYiJ1caos8ccQtScPw524ptm?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Dvm3ob4BUwbvuSUDKAg5xdprw3u6sBOJ5cT67Vt1uZqEfgy/6NGlnftVHO8G3m4bXW18BvpBjQDSTTT4McjP5lucf7V+409IEMj9RmfKEE5MqYC9+v33FdApWsJhHofIWPhhtQvjut4Kx015JX80wgUYm0pwptVMKuLM377C9cjHE/4QdYhkVrMcaVgO9nnf5P1vD0Pl9dDuSTv1uKf64yA17gQNykXHlsD3PT57HqyVwZAM6sKTSkWihlLN3PMrdWK79ayfjVi4mx2ASr63mfnX2btFdnqIV5/CVsf3wYP52+Y8lZZEESLXL6l+cFzHZGAtZnK9kYmMYzIyyYNLPQgFScRB3J1LyKOOJoEMAfsNJhNHquwsRSKuV50e1OEUgL8bIvp2Nqtymx2/Etkasbdj+Woj3I1rx1Hk1kSqwui2E80gfzTmlyU2KNfT2RpmiQkwNOrY5dMi+umXANNEptgYaj76O8tdCmbIf6z8SU10wvCtUht4UMw2d0lnewFgZ9qzceH3FLjJTTPv+NeMHe5dBGuvgeZ6nWdzAT4pKlghmaI2GRPG2QIPaysjOtA8Zty8WwwG3DibYkWoEZOfoupQUiVDYISGax9OSsylSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f310a-21d0-4c3d-b744-08ddb89fae89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:03:32.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6qpOh31IRc3jRzSIKRXIoCdmNUaA1kaeDzabDCLJ9ePoT2TFwPVBX3PpdC5jOnJkqzyigIl8cBpyzjxSzuspghMVfybnwZqyT56sAghCi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010083
X-Proofpoint-GUID: iPZ7s_iwJhzNKLJ8Pi3vIIUdC5LPTtCU
X-Proofpoint-ORIG-GUID: iPZ7s_iwJhzNKLJ8Pi3vIIUdC5LPTtCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MyBTYWx0ZWRfX+R94Z7lQyOnG G3M8P/F4VjzVDqm4kczThHT0aW7BWN1r2ILxXGeZgEc+MPy9X0hzc4AJ65b0XIxomZuHIYxcpL/ YN7XMy4hhrPDAB/kFk+QO/XW7fIHyBTJNcwnwtsdLNRl5teKjDg4uCXURrxT7Uwttma2lMFPozF
 okY/AaTYpLV6B4cXWMRE4vzLiLoYnLLgho9OzYceMjDSJW5yjNki2K35+ImdMayOf41XYxmZxZr giKwtsu29dlW4gVCuh/jsdR6Ae9Q1pFhOcXN9OqScao3MUkiECCY398N2lBEUVHiiMEnS+qVYMF HCa5OQMunydSGV2Cqc1v1BjFd4gwAh+Pa+lenfIjg8SRp587RmoUoMh+68bT2uvvDMS+JDT4AZV
 nnGx0tv2OzTIgkq+laLS8AFZw2iSqo1iVLo8DbGMAblGVw4/3gPL+Z0HZbLDNVcjJYxS9bGS
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863dcc3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=T-kjlwPEtwaRbaykrs8A:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 03:00:05PM +0200, David Hildenbrand wrote:
> It's unused and the page counterpart is gone, so let's remove it.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/page-flags.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f539bd5e14200..b42986a578b71 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -718,11 +718,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>  #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
>  #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
>
> -static __always_inline bool folio_mapping_flags(const struct folio *folio)
> -{
> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
> -}
> -
>  static __always_inline bool folio_test_anon(const struct folio *folio)
>  {
>  	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
> --
> 2.49.0
>

