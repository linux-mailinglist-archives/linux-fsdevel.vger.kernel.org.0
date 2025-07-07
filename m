Return-Path: <linux-fsdevel+bounces-54137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0BDAFB6BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058117A5A34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14722242D9A;
	Mon,  7 Jul 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJlvCUjV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2EJP8m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC671A239A;
	Mon,  7 Jul 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900573; cv=fail; b=rwmpv335Hz9SmBLGdSVZOGueSCD9T6GlG7Yph6AlsQZw+eX9CK20sSPuxuH/YhUjQa5gib4/dmZRAaxHZObDDmbahPfqwjUJloIzwPXHFzSKK0AaCUte0uqpE531VQu6agR7fC1SYJWEJBSIBEMrXIg3rjVZkjRyWxlRAx7Kl+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900573; c=relaxed/simple;
	bh=jozERyMiOAJXcPfF+h2bF7qd+I9mDj24twxvF1XL1Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZJndSp3L3/xNazV6Rl0WE8qydUgEnsnj4qf/s3tiATCuX97sO9SiezLfQ7xc2Fbsm8zBHHrvi/x1tJCgZ845OmTDZzuLkcP6nfhz2xcYFuUHtgOdvfHomYNUAtbH3TxOvgzasIy5Md5oGl4GgMWzB5hEa22IrPezhmQn4WB6/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJlvCUjV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2EJP8m3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567ELwGq015116;
	Mon, 7 Jul 2025 15:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mWG0BxsYC1xmq0YmPI
	+O9Elij9NFQpVTYIux6olTb2E=; b=CJlvCUjVn2DDpLXiVd2lTnRNZAMkhLE6Ud
	4AkWqM6xkVgZiSIwwEF6CmGZJcWwVWRotqhlddFl5SIFQJh0OpF0uUUwFnENq2Ba
	5XlVgjoY0Sl0mtKKn9B1Qx7TX9DauZzbsAg5TIPiZ3t/0CwtspHozHaDjs4nR31d
	oLvb1omWIt9qe8lQir+nNd5xMd4jBAVMir46bRSH+D0XI00Tsc1qKMgyijaiyxWv
	iEGFFoYpLm8lhy2gXJBB03F+KtbkEORiFuJbJM9C/3lLnPX/nJYQplCoUhy1UZkr
	lSMVXTvgW3P/gm+gUtREnsdrSF5vUs6NXHMVOnld6KeoH80jJA/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rfxgr3bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:01:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567EuC74023666;
	Mon, 7 Jul 2025 15:01:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8mb27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMJBchMLt75wkSDo+hOblWlNhLFlgiwKwaNcnDtwjbGwjNdMjcq6WynLTlCK98FxhzcpqYnnHGm9L+V+lWXucRSpy3/xn/9fQI0/wbozFI6TIG6q7ZZflrNbPHAUF6V8XpVrBAPAg4CdYcaU8noqeLg8mm/LuT8PAqfaXyDbEaycd6I58nZ/WEO8tXzX97LHO4/bcGVDOYZI9diXJMe6eFWUHYn6nC4CmBII2THP10vdmiVD4nitDFzNp6Kict7pOo0PSF94Zaw6wUCutDEQzBZhGQzvjvT5106j0N9AUadRhou90yxZZqMfG2T1nx6iaJBA5dqFzgAY15gDxzEKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWG0BxsYC1xmq0YmPI+O9Elij9NFQpVTYIux6olTb2E=;
 b=XJLsyH98AcIlWm7jC/ziRAQWxhUtVOeEzpK+Lc02CYfte592HeVS0ZUS0xcOtPVXYAoD3AU/DE8X35POeqbkdOGOYpaF1sGv3Th62FnvtyZQmv+qy++Qbc2XzSZweKvPWc3SC448CNikWyMm1cdUvY5kqpscsxYKNhgQtA43MLKOcWgrkybTvyslnpuNeHaiJoYtu7lK1wgl5Hd7jCDvfUMfGVu5qZbBlng4NFvFF6IGwOtyN7GnX8Ck+/RVuHteT1Evg747YhUpH2lUqk7Oxjp4kbsN0XPKrL5z5rIj4lPhRjiG2b2R1nGVCkjm/xJJ+G8CEAc4KXSreQkof59KOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWG0BxsYC1xmq0YmPI+O9Elij9NFQpVTYIux6olTb2E=;
 b=q2EJP8m3av/9kaVKSmTWGMvewbZcN/j2jtXcz74hH1bArfxZzf4vpX3kRJfL7lXXnb2YSUQSvWkRafcUt19VTKcgZI9z/YVlbzBH+xvd30QfRxuxZCchxwxsoxSqCQggHMxExkWs4KCEFT9BZ38lA45Y73Tqjo9o4YYm7RGa5mw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 15:01:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 15:01:43 +0000
Date: Mon, 7 Jul 2025 16:01:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 6/8] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
Message-ID: <92481011-08b2-468f-888c-f409b9c8e1e5@lucifer.local>
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-7-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-7-surenb@google.com>
X-ClientProxiedBy: LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 421bd575-1385-49f7-5d76-08ddbd672f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RtoCwdhJw+PdLgxqz2D5dCmsTDf0gx9NF0A2M1OwgwpAiq/AtnoVsod8Mdjo?=
 =?us-ascii?Q?yydIsYXsqnJiXaFAB/db4RAcgI7SvRAwf2og9zkAVoo7bGQK5IJduY6MUt68?=
 =?us-ascii?Q?y1cYVUf4hrB8zQ9xa1RZdmaLC8t8jqROCjkz65HrR/e2SPI0s/QVH5D4U4x/?=
 =?us-ascii?Q?bJ1GhO2GuiTdnlz/eB/r1+q61iHTsghahCteNy1BFV6VWGBVGOpEo+zc0dii?=
 =?us-ascii?Q?Q64n7nY3Vt+1FdjCYYigB1zDDU1KQR24Cyu4e5svYyhT/iKxP1Patkfv3gFy?=
 =?us-ascii?Q?Dtqc+fEbfUGgj/6TNsPqIrvXBMUlzJB2lCiat/HsKjus/zfaI8ktjh8lU5ms?=
 =?us-ascii?Q?htwoAVnac0RhPj6lZ7O4hCgNfKa4Eyk7cWaVWTw67teAzBZDI9wxhisrO8tJ?=
 =?us-ascii?Q?zazh/RreiccFLz0xRts1pRw5a5Ig6VS7+08OAgT6J7l4hFo+cGaDpdRftqKq?=
 =?us-ascii?Q?hnxDQ4bOyU2RBwNdH1cw6R07569L97Zo745DGQJvb68fvRn5Bai7siwm8NI0?=
 =?us-ascii?Q?OAF0UsliRa5dFQcrH3uo9WyHyiTXDlHX323X+9H769Cx79LcN8mj9CfXWTAu?=
 =?us-ascii?Q?9incVtJKIr6b1VUUJQa3CVsr6ardN7BctLot2AfpOwmo0lXxpt64k4hEKC6t?=
 =?us-ascii?Q?blODW0tW+uM0mG/zURvno/DdXvLEB+aS3dKmh0TipCUi6r/RQaHrWFELJabU?=
 =?us-ascii?Q?HME7UTO6OJ4cwDTAgY7nWokYcmWP7GkKDkUV4a3Q2G5jUb00j18981KMYWwm?=
 =?us-ascii?Q?Dyn41kXuA2kkMhktP8P9+8p/M28HLOLGNywwsyde/OFIqQdRj73GD7t/Pvl9?=
 =?us-ascii?Q?F02RFWWcfcszme+LksU1Szb8NrnT/qN8Y+eBp2lY1ezsqyjSxh52aaOJiunV?=
 =?us-ascii?Q?kaWlAOFlYftu1bydvM1aGUUQqLtWv5/r8Lns4ua6C7Z/mXQrhYFIpImGxt/q?=
 =?us-ascii?Q?ezhW4agriPwjAzrcu00sfJ0tzMq5gIxBWsmJSokIGauntYP3y4/kwbEJX24y?=
 =?us-ascii?Q?w/gk87uZu5f5iV/CnIKzlerjHFHuzZh+VyL+KbiO031MaMLvGybT3cnPqdi0?=
 =?us-ascii?Q?PIcJObKAyxGhDJJb7FHrA4HyxAMul/QLaLu/e5mJcK59cVtG4MSdccDt+KUL?=
 =?us-ascii?Q?Ppi8BQXpZsgM0C8toXSVGVHIyoOhl2hRk/8q0j9DzaTonBF1rvaR1dVqzMxo?=
 =?us-ascii?Q?0Nk8ilnXgY5DgT1xelx2A+iHTqm+cvr+DaudqdnA7QgpM+fua2j3T2q1yz26?=
 =?us-ascii?Q?KHeoeeCMiA0PIKBoipDzLNmBCpz4qLLXm8atdFuS/yl34s/qnjkzfC2mzfMp?=
 =?us-ascii?Q?UTr1K0/E1u91g3P9sNCXs6PIzbpNwH2o4vtoccQp/eitxCcqzgPCaEZahGEQ?=
 =?us-ascii?Q?ZF7EeQhwdqaitLYJX/GK3PBrg5dACKP1ww/79d28LPzIHVAxGQmyX6BXAYM4?=
 =?us-ascii?Q?iQPODxPylUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rByBFhSsaJlJJw05sayx0UoHTg328IPedATQ0VUSaWs9v10aLJEsftbPyqqy?=
 =?us-ascii?Q?G3/Cyr5w3ctTPO49lA0IvLSVb/L9a6GAhtooZvVIHJLtUUKJBZL51vIuIRqe?=
 =?us-ascii?Q?wxo28eXHDWN4Iaj0lQOnuVSOkv1qAuBkYFN0Bhcb7BOrQmd4sm3k8Wg8NUy6?=
 =?us-ascii?Q?tuQr0262Zw6ZQNbs3NEMsa8pOsBvLlfBR9UuSyQIEtsqWE4yi8nTIym1cmC4?=
 =?us-ascii?Q?vKV1L/jfJ/gslwTBvYeNgF8C13C/O7rRYSTVhGyQMEXOcwe0CtXtt+wy9p/r?=
 =?us-ascii?Q?6jiCBiNpjUJJIAf+t0ulT3yo2Aky2AN15kmXT0dm3mhuXtLRRqICToIUC2X9?=
 =?us-ascii?Q?KU1/zmPLzh/x1H170knCSIGSkhNF8jKPsyhTd3p/b8YXkwgoYiTiRRLWXFZb?=
 =?us-ascii?Q?b/+oeyX5AYqv9qOK2qY2Hj+TKN27gLbxp+2LH7X+xrZikt3+7KFrVcLpnwiI?=
 =?us-ascii?Q?8oswQBcUrtIu0xgTZn0PBuFed/Oc2qAbO1lxD2iB+A2rZm6xJg4wrMfLFn05?=
 =?us-ascii?Q?xqk4kLmC+DEr2AdYswJMhc1EtlDa4nBlOmjMrHIg8ayMCdAs25j1xXACJWBd?=
 =?us-ascii?Q?8OUb9+VtdggytAw1lZEs80P1FhtkwP7VUnjlK/g4B/DvrKniDCPPlRVUYogc?=
 =?us-ascii?Q?dnBNBlg1JavFc5gqgyPwnShQoftxpJY585fu6FNFNaRsrapacjt1sYf7vn18?=
 =?us-ascii?Q?Tpmd2WKOoPxyX3ou4BzKvmENyN+msNQzkNkS/B3BaSxK+c357ytjsHpN+azq?=
 =?us-ascii?Q?firjMHPzi3YMNB60fPiYp0/HQxSS/d68MW/R9cl2VuHQWWDhd0PaEBqJkkgJ?=
 =?us-ascii?Q?bWVziYVV1k8puWVyh41YwidOSb4T761y2KugYIQ59GcpEdZoSluEw3z5oJZ+?=
 =?us-ascii?Q?uX0Ek4b+/swFAI/ujWWbxslxOBiACKoFjegOIokjHS7AZ8VWqjyx81+yJbsF?=
 =?us-ascii?Q?yVFTaVEqr9T6XP/sBd9+nL/AP/VsfkSWwCT2uFkHNHQgNjQEqNpGL7AbUXbP?=
 =?us-ascii?Q?4wHWJ1eQBzxJwcywGBxFWIZaMzomWM6+YIw6TtoZ6KbKawQWTU13ums6EEvi?=
 =?us-ascii?Q?xFjjhi5NHfiFs08dJVwTEzVyeYu1ZDx9Rm2zHJNBk3mxWmlBtl9rczJ/pIxg?=
 =?us-ascii?Q?RIKgsC4DSFwQbF+t36Sh/baapi/1vKHBV4yrrlsPHVIzGgbtQr85kCgq4T4k?=
 =?us-ascii?Q?8K2xLBMp5CbZyefV+UjVISjTWqg83Or2rgEZeU0SC5Zv1OQmMqQu9Z6y5ci9?=
 =?us-ascii?Q?nFFDYKGS0UQFl8Xn3/qlTKDSzJkKuGEnzw1DxogDwwPRKcJzdVlY0aB+QA28?=
 =?us-ascii?Q?tVtf34K9S8xWH3Lw+O437IKa0pEkUpIfhXZMpZSicoYuUvWPogdt818ziEZX?=
 =?us-ascii?Q?qG7J5H3BNWuVUcdy30nxMVMVp74obeXDQiFYVRgdzvOz6f0zxRPWC0L+Kzp6?=
 =?us-ascii?Q?cFSE6oqws2TImc16hlaQOlukNp/0u4me/v6dMNt5rx7lGvyWgmLomWFNq8E1?=
 =?us-ascii?Q?fiWAoiTobTAPxCXlKTrLxRKrRphf4ygEF/BHLsEOsJwJP7TpMaqgC8ft452l?=
 =?us-ascii?Q?byaYT63DTTZfhbLajJkLbzA2fmzWEtNgY2FjOLmmDBAhva9ChM8hJObUQ2QV?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z2P1MztNd7e7HEFNXLYaKOGcR58TjeXNV29fa+1vMvqC/ZjZcP1RKwXpsLKJFAZYssi687iDMEe0d4Z1n4DxN3NlIbN1o3gptIxx7E1cUlad7tqFirwMVg/C5796W0Mq5XQYFXZ8MV/vchd5tnnxw8JorM/iY8hFGWgiM5VEsJlnIRcJC4ETyN5Dui382I6CS8mNNX9dxh18o8bJHIsCSgOOnjgBSX/re8a7aNmMeCuoTYdM0qZovX0FeJRujFZGpeBNu/tJf65/OWVIDFRq9UN+AUORiN46W58aR2Xe3XQ33u41tqR1+wVwDXRB+gxTUaRgQZydQ45athocafiwuF5L5jFlsJfadxezL0mZG7p2TpsQjUdfBvJTUs7J73OuRVRLRfit1kIPeIv/MLwCTcUY7cekVoa8rSdAPrqTbkLbDXmocd2jqa06SXxu00GZwcGRVlRu3hM5a88ZGuH/so2JQ3oCRjaRmWhcu7xIJGxSUjMi9otN97xLkwNhQXsYQTgDjAvMCjdsmtPs7spsMeIk6owkXKUgwPxI7uwrU4KRimUuvnNXv207zfabx9928avYSpqkE4GSFlTLSKlbf74M9kittoD4WIl/cKQkxZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421bd575-1385-49f7-5d76-08ddbd672f86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:01:43.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O98HAMhYfV1EETzcvUyx8fB/NEPh3vCP94jvrVYBbfx2A9u18NMweQ74B+7Vevw72XFqgyACq+/xQailYUp0RZTEoeKxfTQmCjagKMi8QC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070088
X-Authority-Analysis: v=2.4 cv=YMyfyQGx c=1 sm=1 tr=0 ts=686be163 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=Y7akAFDJYfq_Ejx0gcgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bO5QsmChNfKfl3jvQsfdeOjZY4ydrZly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4OSBTYWx0ZWRfXy3gb924oAXX3 oKw7wGFtkIvpw56Rvb2Bgf5MqQwOy/KS0jDkc4qgf3iItEJ+i1NhGtaDxfIXbogSj4sSbsOzUcm ksPTrJY88WIMd9d3DfCdqQFI04oXSDElXBpqfLB1J3qy7z24xpvhTe2a1cdkZr3YPO7aB28VPC0
 ooqeVn1tO7+iw/E5rRNX6dzlCWMAInlTr6s2kB57jVBj/mwYl0H8CECQCbBORERqrmYOhM8HHvj KX9WpVZ+c2CEzc6Ukcm/mtRtq4OdC5HvIySc9lfFCLq94TtXKfLG2IJsiTE5N6sBh0ZEIpyDdlQ YLczQpCPul42vIO+EHyVH8VwaTz30dQ3bpFM0oUrDOiRmptGl+XHfGUi9syk3Sf+vhclflGLjpL
 MK59baVr35rwf1Pr0C0/L9gtZZOcPi9bJl5XwlvQDIrie4tEJ/kRTWBQBHiFBfTlMf8Dpz/q
X-Proofpoint-GUID: bO5QsmChNfKfl3jvQsfdeOjZY4ydrZly

On Thu, Jul 03, 2025 at 11:07:24PM -0700, Suren Baghdasaryan wrote:
> Back in 2.6 era, last_addr used to be stored in seq_file->version
> variable, which was unsigned long. As a result, sentinels to represent
> gate vma and end of all vmas used unsigned values. In more recent
> kernels we don't used seq_file->version anymore and therefore conversion
> from loff_t into unsigned type is not needed. Similarly, sentinel values
> don't need to be unsigned. Remove type conversion for set_file position
> and change sentinel values to signed.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Nice spot!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/task_mmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 751479eb128f..b8bc06d05a72 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
>  	if (vma) {
>  		*ppos = vma->vm_start;
>  	} else {
> -		*ppos = -2UL;
> +		*ppos = -2;
>  		vma = get_gate_vma(priv->mm);
>  	}
>
> @@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
>  static void *m_start(struct seq_file *m, loff_t *ppos)
>  {
>  	struct proc_maps_private *priv = m->private;
> -	unsigned long last_addr = *ppos;
> +	loff_t last_addr = *ppos;
>  	struct mm_struct *mm;
>
>  	/* See m_next(). Zero at the start or after lseek. */
> -	if (last_addr == -1UL)
> +	if (last_addr == -1)
>  		return NULL;
>
>  	priv->task = get_proc_task(priv->inode);
> @@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return ERR_PTR(-EINTR);
>  	}
>
> -	vma_iter_init(&priv->iter, mm, last_addr);
> +	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
>  	hold_task_mempolicy(priv);
> -	if (last_addr == -2UL)
> +	if (last_addr == -2)
>  		return get_gate_vma(mm);
>
>  	return proc_get_vma(priv, ppos);
> @@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  {
> -	if (*ppos == -2UL) {
> -		*ppos = -1UL;
> +	if (*ppos == -2) {
> +		*ppos = -1;
>  		return NULL;
>  	}
>  	return proc_get_vma(m->private, ppos);
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

