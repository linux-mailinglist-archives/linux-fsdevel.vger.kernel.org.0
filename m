Return-Path: <linux-fsdevel+bounces-30782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455B98E42F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E3F2858CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF30216A36;
	Wed,  2 Oct 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvGKnMnW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rzg15tgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E341D278D;
	Wed,  2 Oct 2024 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901149; cv=fail; b=L24IpNSaapJJ3tbRBEajmi89vhExdIiDS2rDyf5rEHLRz9NMeqDm6IkRYur4OK7RILmP/x6KIPStG2RS1Jd90jree1JTchFd/tYv8NgeR70jl1L8Ns1KGcVudIxxrO1bYXBLcrJV/yCX4C+/xxb7R48HtOgUOJ9v+U7EX8Zl26s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901149; c=relaxed/simple;
	bh=2EGteeC3AydgBVHFxIzzkghy2yhLT8MJQeOyX0aLh98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vqb5ITIC38bxssACZYMlvUkyz2od4/ixEyJTf8gxb5O/6B0m0c5/sUQrx/tQA9m+wi9ihW/CS1PuMF4dzJI29tg5DIASFT+gEwZEsusZsMsr2mKeUpDe9jCKfS80jcRb71E+rgfOzVoglU6atQ88Rs0kfsxsS8Y+O1y5X3iLzro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvGKnMnW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rzg15tgr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492J0bbl021084;
	Wed, 2 Oct 2024 20:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2EGteeC3AydgBVH
	FxIzzkghy2yhLT8MJQeOyX0aLh98=; b=KvGKnMnWSyUjHATdtb24c1C72KDLWwo
	VwFCwcNAniIspnnqESA/5JneBcTOnqlyeFTNlsFU48mkWmuGUizgpeUoOvzCyoWu
	P4zUjPMBd1Hu+1jrsXR4HZNtGl8s7AqKNCpgHvObuCfJDGP7hx+4E3KmfShsIf5T
	fMNY83xN/+ZPV18mp0zTLF1a80jktdXRdSIftfsPn/aSQ4FOwjh2B+b2Gq8w7OX0
	oBzexF2xiGMatSJxnFFqYPpEVgyWRvHtEnkU5pKqzwbtnhdi6wuzJWddFDlEp5EH
	LivRGSRp5DcCYdkMIXvJwsLB3UXjFeiVQ91IoRdSEhJBLBRN2zasd1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1jka5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:32:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492JLYsh012621;
	Wed, 2 Oct 2024 20:32:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8894epb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LygZdmMGypK+RZHvw1Y8V+AccVzOhWOrLxm3b73wF/RGquaxyZwBT8ZgXuBIgcAHSOUfZtQjXSKz6qb5/3RFdB0w7rchVtker0fvoo1wb4a3kzAL7X2fACPp5qBU4mdjgIRhsGePYwvHELNubyzpyCcr6lRpPOIGXViamCUDxa4qA3WFgX6EwCzSyEJC8IT1NgFXm0kJkDwfI/ObYRkkmc240cnHBSXW4tpESGLnNgUNhAEX07lenBQf6ZTVh+jrwjELSkGVYocYuSiHaJ71McZm7M4Y3+Gal4m6zDQLbIDpqfhNitCs4r2SPdEmDjV/4ga3rHfJPTmRRsm9l6Oa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EGteeC3AydgBVHFxIzzkghy2yhLT8MJQeOyX0aLh98=;
 b=dB6w1DcKw0dRpOMcTeI0zAoBSID5+PUnM9gMDVHVPyXUPhXEXRCPxeHJaD8hhSCDCb55u7CVimHaLlNp5nILqZFy57j2W9lqC814Hzp5WXM5u827kX2u1M6k+do5y34/6HX7rEN3YMIF1kKAsaA22QrXlaGDFQ8sOprgvtn1i1grDyg/oV6S66/0NEX+X+wY4zyyLuoPYO0PPDk6wdv3F5E/N7iSAWA1tVQ1aJP2fiZ4+2qTagh1t+qAz+H9AZSWLjDimCF7twhR0AoYwd80CZiqt8+JxpE2KeJRBDzz7qIzvRUcm0QuX0Kacv5DAxOPbaI1ibMFH2LLvxp1tmcXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EGteeC3AydgBVHFxIzzkghy2yhLT8MJQeOyX0aLh98=;
 b=Rzg15tgrhQlVvDz8UuYEfLDGBuNo8jbFUOEZw0XKas5Fia1EaQE4vn6Q3ZazmN2QVWNft06RZy3nbymlI0WWXlMQ7CLAFHcRZPw1JWIyWxQKd4kyQUK8M/hWxNXc/irwKEfmw7IeJFpSU84OwAaMPQkA6X5sOOH4QLMtdOkltr4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:32:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:32:17 +0000
Date: Wed, 2 Oct 2024 21:32:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at
 fs/proc/task_mmu.c:187
Message-ID: <302fd5b8-e4a4-4748-9a91-413575a54a9a@lucifer.local>
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
 <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
 <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local>
X-ClientProxiedBy: LO4P123CA0366.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3bd2a8-4473-418e-cb76-08dce3214ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOZaWsQhYm948XeDG7nRQR3lfUMUnV+AvKK+cSeYFuDCdOgA8tXt9Fix4yAw?=
 =?us-ascii?Q?42JMQnorys2l/2mQeNVQVrtfwoT4t9ufbaK45FFAdU+DGrV6UIcy2DBdUaKY?=
 =?us-ascii?Q?nWKYjIWQbWZjsFynljpKVy79Pd6L+ITButDvFSFdMfOaYGS/HTRaHu8/Lar3?=
 =?us-ascii?Q?LoJoD3akzG7FFZxbQGlZ72NjlLpF6aeMhkNQ952Kpb1TdUoioRDBu7h4g2Vo?=
 =?us-ascii?Q?PAmNw9FP3Q4hr8V4+r1Hh8RQji7hNSCm48F+mJHPzSwTeap7bxPK9pufLR05?=
 =?us-ascii?Q?yAnfezBwVqbEaNLv8Jl2rftgjAyJKvSbo1vgLplcyxUS0j1F4CbfDvViGxBM?=
 =?us-ascii?Q?qVQ1ZqTM+yURAVlvc0geyzGYohzDFbtnf9qRmlGjN/MzPt4Cy41VQzif5Vlj?=
 =?us-ascii?Q?fTzPpU6oDIm5DaQmfUgPKXxQmSSQ2JOuYMIg9C+OMBj7sygWbqIhh7rXy7kA?=
 =?us-ascii?Q?mvmXMVtjMfnnqplHrCYgxCNKk3DOX42Ou4KA4XfWC3u1USNknwksy3/j7/4/?=
 =?us-ascii?Q?O/Dxl2CTtye1+xJing5vDk9glyQuCY995C8dmhPb1ucbqQGStpACtdpF73Ek?=
 =?us-ascii?Q?727N+VRf1atzJX1XtJIZdufR9Nab9qXA23eIhWBhROh861H8kP8ymnJUj9io?=
 =?us-ascii?Q?fWvgDQ7O9VPM0BaQh0WB+XngJUOZkWcDutHDMuV7VLaC0cWBgSAt9XRVt45F?=
 =?us-ascii?Q?hhWFJR7tvfYMjdnKhCoaCHuT+XHWOV9mt18YLSUWDEYnXxB+Ox4z+EZXEHAI?=
 =?us-ascii?Q?3UwrHmgYdzYOTc7KuzSs8z3iycQEc2u7M4x5i+9TzHnta4Jr00F6A/dCTZs5?=
 =?us-ascii?Q?nm8n8qhHRBJThIplKIhHabebWnj+Qq9U0WdmBZl2t8+jNQ6T2ACHAtvMQSQH?=
 =?us-ascii?Q?u+5tvSTtnoweYxYHZ1YnNG5XKUnQ9I5cv6tOCjBr1i7jQrxntS7tBzjwlaAI?=
 =?us-ascii?Q?J4g7n/nR0wBIYF6jqr/spL/MSDcabN4eTKr2FKEjQhOyZUxvkmQeTdT1fLvj?=
 =?us-ascii?Q?3bdU5eMq85GgaZtDrJmq0lvYFeEq/9gAM0D65J011zUZQma1TPb02rKdrVnL?=
 =?us-ascii?Q?OOHT5d8V5yK4PYkkW+7d5i0ycKVD6kpPE6uCCfu4Ox1MGmWr7m9KoXlMyl5Z?=
 =?us-ascii?Q?vq+T4eXtnGFZwhxJ9ps34ODrpmZ9yEmU2cJwCitaq9hQ4Ja5dqu6c9mUquva?=
 =?us-ascii?Q?yZudmVpQHMvZOZSxb082mURsXNvl1KZ9p4l37JbYDMpRUCdV24KpDZTSo4Qz?=
 =?us-ascii?Q?4JmgdZXlyBe51k0DM4ML0MokwwmSigeHzOg//CsqHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4t7QwiXAgnFtN05n5PB1eAwyd8saU4M3f0qDBEc0S5PGic1RrnPZdX9Wp2/x?=
 =?us-ascii?Q?BB6lknPBVgoP2GpyJckp2ZYXHEYxR6iYU9MX2gUFgcmlfihcWyQYbs4+MLUO?=
 =?us-ascii?Q?gW2pRhgBZcSU5k/8Nq6PEPAeNmM03u7P3TA2P5jk9UHwWMXJoN38TCy3c+J9?=
 =?us-ascii?Q?Qn/CYumBTURWnyygMqAQjz/9CJononpvFErRQQA+NF1HytNVTE3eEJqNsx1m?=
 =?us-ascii?Q?t6TtB5/f62Y4HdAuHkFrpfhnY1F3Y+3fVL+x9dQvuNKMyoWiCFO19tk64ZZ5?=
 =?us-ascii?Q?tPldyI6eYUrXfnQ68Vkluiel7SLnCpVpAErGOTG/Cju9zs3K2o/2Ee2glq32?=
 =?us-ascii?Q?C0Yz8aGz5svs/EOixcMxxSd/wwQkmAD7FG5pWDZTGo2V6p0P8FS8oM6kl/MG?=
 =?us-ascii?Q?DBkbyPjyfw85n2pSlph3GMw/aS6Xvp+VMpViiI7p4MsQ56MqrsTbWntW/WN6?=
 =?us-ascii?Q?DzFkThXIVgFu3F3gtzx8BnHriH1s/X36r2rQggd50LYg0HzBEa0KQuH9J5Rf?=
 =?us-ascii?Q?WbKPPNVMldyWFlNd1+cNanFTwVolnQmj9LTBhGA7zo8yBH/x47qycxZhKn5D?=
 =?us-ascii?Q?vNT6oLYhix6BI07mzm/v9O/+ZPbH09PwCzreVW/c+YpOAl6XEAHdRrdhXBx2?=
 =?us-ascii?Q?sWxuSzgxbKU7+ZsL8MjPX7IYFMevx1i2a6PCEZbHWnQABXpzGc5lPYkQ9l0v?=
 =?us-ascii?Q?MrOEcxOD321uc9hwdzW3Mc5Unob8NEWZmGGbNZvGJ0a5/Kmv3Fdwer2LJmVu?=
 =?us-ascii?Q?ZWd9GzrvnYFtWDUv0N0EX+HMxzS/W1uktkEZXAtkzR3U6m3wHHBNXWtsCK8L?=
 =?us-ascii?Q?kAO4icKK1JSPDk0dQcRJ7KawzExwhSvU+OMG2A49QS+e3SZYJj8jW+zgektS?=
 =?us-ascii?Q?3pb9imTd7Np/kTwPhjUKuSecdmFU9R7rBOhomMyTD2QsgngrBNxL0H37nyDZ?=
 =?us-ascii?Q?fEQ1xzylaeEWnnj3SYd7b0e4m8CjvWgIkROlhpn0CN+rFbKPQIY+3vjhfeDy?=
 =?us-ascii?Q?EFHH4jScom/eIghOnpNf0yq/0rua+24Q4bz94ODiO3o5Pbb7Y4bMR8pVUk6n?=
 =?us-ascii?Q?4ZYxLchjScBxhZ2kogYS9RizkI0/HKHjwsFbNaGVIgO9saO4rPuT502O6rFC?=
 =?us-ascii?Q?m0ECzp/Nu4zNeJZn2UHdKCga5gEIFES0GUnLKNnDS7ahQKwVXV7KLwlqIDPU?=
 =?us-ascii?Q?otitE8Xg3ixXdMmoeDZzX/WMdzc7hMbxY7JRXA/SQn1nqDaNruYQTpjWKYYf?=
 =?us-ascii?Q?c/BaX8WykAPeWn3rVsLggFhzbcQ024O/+pqJcePGJnQI3Y+zjFEbt54wkZHH?=
 =?us-ascii?Q?Hf1JWEIN3kPqw47Awnn9cLj0ogqMfSBxluOVDuaQ3neTbOU0i02KWmSIp0QU?=
 =?us-ascii?Q?/+csCFTZnQaX/kbgLXsmCiK0gwjKwrwx41Sl1bAQSJr+dwItp7WvFw7gO8GW?=
 =?us-ascii?Q?AAnxDffpm6NnP3DL43g+0ffDLAC2ktVJXb9HX6KaOyG/ekz+8XYhF6Orgy5u?=
 =?us-ascii?Q?Bkb/Yh7Wh1gLCqUxN750e7N6u2xbHqSwz4V25IslA9uDsM2vxdsx7Cz88l65?=
 =?us-ascii?Q?ivdz9H7D8IWa+lS0JV3cnAbpIA61wk3iOe2fh+NUGe5t9CM10YOSVOchYuWn?=
 =?us-ascii?Q?/l/Cn80OrJqrVbvbc2pKVnnNNOeQi5+m9J7HEkHzXwMBQK3vi9WD+F4Ili0q?=
 =?us-ascii?Q?6abZqQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wS/sk9Hf0IFdlCb/OCKt4YOX4iCvrpPK0cKh10iLz4jjY87tomY/g8ANGZk7dNltKyk5vqtwTj5iwIdHaD3jrogQynz3TGH8e20Xj2eVTz/ef9Kyd1xG308RAO3VMoa0TxNCEg7TdytldGZQRd9RnNRe/gqx2XFuGTUORJQkDlB5qYCXOMc8H9eQoHSMzcQG/zTTa/9a59+fOWHE086Ts3dsPzgkR57qsK5q5HZxmJ3SHgOBkLe0SCWgToEZ6H14BKuIfNGpS1ZQjWdr4/RTWI/uE0Vyn2k/XglKC8GylJ8RV/+g8GmgTo8IwgvYXroMHzqUB8qa9o6FE0IKPAOwex9v2irDG7Qf/UGHv1Q6eyA6Du5NWjA1mVHtaN9O54nHMaGDx20Jo3mXrmlVs+J2zX1Vzg0y/oddOjLhSTnO3dlTgm5y/5KPtEen8Mq2/2sglruZlSIHRpreJg3hUBmdiXjXv7XvhGjKQeWx8C0DJB6m5B7TvLVNMxMjyNthsajD+teRtO1n0BZRny2Kjq+eCDaH2sXpnvIlExcrouGRuPO3SNdFubButrWD46arIVe4AB5mWlN/jWTDGHP6XY5tHh1Wrrsf3WOPxmFiDoLwbO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3bd2a8-4473-418e-cb76-08dce3214ed2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:32:17.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkbXJYDNRL83vFT07LjX0G4zyGEoda3D75O3TUcyvxeJhaZwRiMK/ZDtrgp7GVuPu74T7Q+peZ3qbsRpzTO3iL1tf1FBAQfi13unGnL54fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_20,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=724 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020147
X-Proofpoint-ORIG-GUID: XXoa2oR8jgPRhyNM9IikiTcz4mrGXJGh
X-Proofpoint-GUID: XXoa2oR8jgPRhyNM9IikiTcz4mrGXJGh

On Wed, Oct 02, 2024 at 06:55:59PM GMT, Lorenzo Stoakes wrote:
> Thanks for your report!

Out of curiosity, what GPU are you using? :)

[snip]

