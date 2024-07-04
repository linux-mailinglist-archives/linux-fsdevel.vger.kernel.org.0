Return-Path: <linux-fsdevel+bounces-23107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA533927466
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B631F26910
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A11ABCDA;
	Thu,  4 Jul 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c9SZ5m7K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UMR0oWUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D131A08DE;
	Thu,  4 Jul 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090324; cv=fail; b=kGMYsLrhqC4Yr5thYD3BOsOoEnX1G4i4UhlPmKP8Z1RoYyJ6quPZ5YvU3YIJjDrHg84wEMdxgviXriWJzcIWkqjBF9kEtiTJBWvZHQBLjP9ls+kfBL7rN9AS2XAveIaCqlhchDNq8SXgGA1Yhhj+StxzGEOA7t7UHkYXx9+AatU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090324; c=relaxed/simple;
	bh=zqRYGdvVK8Rd6hyVRi5kDoaUOWzmsaNi024yVdWIpFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbU9yJjkuvVKfK3GYFV9XtXSuvPTt2evNYZiXTwxIom2Ba7H0h2E0kjVUGIGvP/O1JnBMGkTeEv7oPFS4fBzaJOvgyIEmeHSX/OS8faGi0tswPDnp7cMSV38NmNNEjZCeGbdmxundJG+105iFWJ3TEsDYGlxBhfdAI9FQImguiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c9SZ5m7K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UMR0oWUX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4642MRvI012524;
	Thu, 4 Jul 2024 10:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pIzN5832tSj0NMF
	Uhb3PcFG6alHzUg3X1lMdLBtrx4I=; b=c9SZ5m7Kv5yqy35+bThu78J/7/6bbqz
	U2/yOcei55MKho53wzHDsCDYFupSaGY+c60si0OxYvYoPZgKPGVUvdnS75/6GuXn
	FFGrSKVBLWYrOvGUvpri5OnzA68+BIe+xXb1mxA1JrtA8nIQactTz4g1FnTeDV3/
	GLn1HWvaYBCCoRmZMI+69itYIbJMKC8tOQp+cfeBb1pibY3SJvXqGAohhESiNu5k
	vWdqeNKZJHIwz/3V9gnSUnKF0AWJdU59wWgyb26TpF1NciQxRmIrRs/GuR9z4JH1
	P/JwGdxYDzzjpNPDBCaqRRdtWe67bLJzYvD4e6wSA0PWJu4Zj5yJBbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40292322h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 10:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4648anUK023531;
	Thu, 4 Jul 2024 10:51:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n118eve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 10:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyUoP28TQchf8E06be3Dqr5jnBecwavMH8k8mQ1Cw7ZgqMFJtSDb1+EWhyZi/dVLMaPxH8aupayh7I3w/+qVve5tRzJ57Lv4my0r48tZv/WsC24xiuEaU3xVPfaH9WB2zp0l2eFQC73b5p51o82ks0Q4a8t3kIuEXd90tt8hVJZGs1zGlH3lClOOv3v61fK/j5ENgwHj1DR4MP+3kgZZn8s2gz4jP9DZSxAX3tw9ykjp7Urowg7JT9rtWB2URkSqKE8yeKtD4s/ZtHg+lIzfphwea+56rpPkqL1ogy3CELGann9W/F1JoUsX8KCm+6LGEGMEMIonWfGTuTcvuELc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzN5832tSj0NMFUhb3PcFG6alHzUg3X1lMdLBtrx4I=;
 b=WuFRNdGlR5XmjVTQqdTnRb/VN1NToTWjJxa1zcdHpk7NEgq5nu/Hn1s6871w8JQ6GE3rumoXi5OvVj0vvgPC5xekdh0h3B8f3PL38Ry9BqxS1fO22YTkrajKfgF5Lf3iuYfxYfZmuAAovO90JWVx8SVGi8E2iS9OkVXajKvHi5auqp0KVjLH/zfl8LT4UszTEv3zBgQPvBLr1ztONzH+Ee7x09CFZVAtuOe/21U16rBQsOAOQUJVLMNiXYYz8zNMkqKwGQErK2rng07usktIp0IIqABQmaEo44p6VojEu3d5Rer0oahiTaJqxZrxaF95MlLRmFWK7UOk8aRaHONiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIzN5832tSj0NMFUhb3PcFG6alHzUg3X1lMdLBtrx4I=;
 b=UMR0oWUXja7i9Jmvk5qVcHQG+unp6X4OLa6eC3t9wWm4BL5e3B7g+EXvpOjHvi6Z6h24IFcGl3kz4dsZWXotdr4MBQMx2yhIeUkGaQ5WVEdD0AcVj9z8CA0t+H43BY+ykwxnRzfaoLrT6QtzpmoJPJwj0Hp5Qde+JUKY2l17nec=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:51:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 10:51:40 +0000
Date: Thu, 4 Jul 2024 11:51:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 7/7] tools: add skeleton code for userland testing of VMA
 logic
Message-ID: <d46e8356-da6d-4629-8473-a8fc6172e596@lucifer.local>
References: <3303ff9b038710401f079f6eb3ee910876657082.1720006125.git.lorenzo.stoakes@oracle.com>
 <20240704055956.96925-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704055956.96925-1-sj@kernel.org>
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee64065-cd9b-42aa-6829-08dc9c17489c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DZacfTVQtKx52CKEYWpRU+0Cd15v7WwZDk5K3lbojKcd4iS1kbIFno7o0oq7?=
 =?us-ascii?Q?ULYNwuSY+v5FlZ19j8TCp5hwFYwNZvSbvckm7G2Dm4nB/OCYwtQS25AC4e1p?=
 =?us-ascii?Q?SSvtJ+l6XI/7g1vwQXvkiu9Nok/avq+yQNnscDr7vF2Swi5BrM5CNbJHR3LW?=
 =?us-ascii?Q?+ERnLwzzd+xF8Xw5v6LMOP+70sxqv5uhrM7TZWg/KNjPqAKg4ZBvbljqqD+5?=
 =?us-ascii?Q?WbSmlJyEwH/d/X6iv0dAbhSKInRiFr1PJaE4Du5N9WoaFzH5K5d+Q9hskJsw?=
 =?us-ascii?Q?9/LjoQ9O/CWi09RfXPe0C2dENkvp6YCOlYmeuD+NCPpcYd+O6gIq+7o8ukhm?=
 =?us-ascii?Q?B+bnDfXMW7ZMmDcWAp35jWXShwqmJVYOpc0LXDW+5mY8vd7tte8t4QfxZccU?=
 =?us-ascii?Q?4Lj8uh+RfVKXv8GYUHkcHaNyPErWqs82+KZtwHBWpy3LiuCkdNnIXUPLqAN7?=
 =?us-ascii?Q?KE76WZczKgbLRF1/Vu9obSL3xohvfwMmHsT3GQuAtmHf61pt4UPXcwseVhLO?=
 =?us-ascii?Q?0YLaY8aCGfnj3HIkboL8msI8k+yjlfc1cpR+z9bcxnKTJ+pEoFNa+HENenvZ?=
 =?us-ascii?Q?1LKHIOufakj+3uyfjN3PWS60lEo4YkxJJBtbPPKYm8v1Rb5iHkpLUIp2OmoS?=
 =?us-ascii?Q?xnwRebQE9PStElrf3138zTKhSiV5SXGKrElo0WcgwzS1DIHgZ2/p1qZxb+Am?=
 =?us-ascii?Q?oFKxjiubSAwfk0zyEungdeyT/sRYE1mNBAcnn9b8vKJP89mKB8ZTxdeJBWHi?=
 =?us-ascii?Q?lnHZ+2SNJqFz7Yme6RpeQqGiFodBiLXzflXX4lZGQzBbUn3lZeZ2IZlEfCep?=
 =?us-ascii?Q?L0Id1DrNQRdSwvDW0K78QTWwlLY+OmoibP1J6/452yDPnCriAVj45QBjNOna?=
 =?us-ascii?Q?UMy1QsNxyBddnBF3F1PeFZLLxDTym4b0cjK5lE2SQFpEfBAesiDdwds+wEAV?=
 =?us-ascii?Q?hw+EWr1LUbioua5nZjoqg8htAriFSu5NgcbH/FEpyYuWlzR7jJqc2HjL0oav?=
 =?us-ascii?Q?eZymrtDDY3VLaibr1Fu8TgBUUJzQG37SrKma2xGi/ur8CwV7hIkFBYpeqb7R?=
 =?us-ascii?Q?xc2mTzuSVDfYTYB+ZDCr9VKsCMSQgvzHipongfiEL5XHVAI3yyfa7LqZzobI?=
 =?us-ascii?Q?OOpwB9bLpc4MSKvtv1DKaER6LJ4TvlqmMcC44CLOTRiOlxpkB+iU6qxT/h4/?=
 =?us-ascii?Q?1eHlWxAE2sXRTBZb5f5myoAa2a811ug1F/yRypL2ES++WLl3oidxTDvS4oTn?=
 =?us-ascii?Q?eYaJCXjcAUeptWxYy4hH8l3kq2i8FfSKHId2Tm2W+kktA0aZABWIYrj2zTGc?=
 =?us-ascii?Q?a7tAQR1rDJCDX9LKPIicZqynTJhGxP10EzvBKJxWXKzJWA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8DX9qj18+O7KTsJ1yHFI17N2fPTa2/z14mpQxPnqXT8KVd29Dp54OyuZQALu?=
 =?us-ascii?Q?p8G2lm6yx1p/VhKhSYNqnoeyoFe40hn46FO0ZmXexYLUAyej1UdMkjwejmWE?=
 =?us-ascii?Q?se0WnQYbFZRXXZyXdsLBkZK4kto2iNGweA9Tm3y2d42hA7awan3xrJtCQD/q?=
 =?us-ascii?Q?72QZErnHnrsKUAd4n1TiCCnhvKNz3cBMXqjZ+HByMxyuitFTK3Dmvbx1RR8a?=
 =?us-ascii?Q?CNWfEor0tUrMtY2FFKz+cQg3cvB3SLeIC+GqdhsR4I3IQXwoVQcWZVp1UhNY?=
 =?us-ascii?Q?MMqWVoy2lmRBjAezEmyVoY8j70J+cDUfd3eC3jti2SeLcdsefIV84yiYQOeo?=
 =?us-ascii?Q?pmwQtvxySO8+4YLf867PHhw3c02gT1KZP+cfufC3vYFeBRZOqe4T0+RHsuO0?=
 =?us-ascii?Q?SiuNqXIUnxO4kD+WQPMfJ7FPsjn7ZWGqIVnCCVgP/htwNbo3vWtPNkKbxlWj?=
 =?us-ascii?Q?U65XziuDWoxYLGrpJuJZPUZpDDKwtsAR5zWKt/vrdSWImbKhqAmk9pkmOtdP?=
 =?us-ascii?Q?gQqtmMqAGS442ON6HibkxDyYjkEHw5JfZ+fG4fAecC+Q8gAJ67ODOj7IHu4K?=
 =?us-ascii?Q?UZQKAVMXO28hBSBq53sKX3T+05YD5DzU71D9Lft52AtAVoE2hpYr82s0e5RB?=
 =?us-ascii?Q?NIHkNSHDbJrzGaxUQU3vpKG1n/oQSZ0hcV1YB+Nkl69b6RKMQ6YeK5yNR4C5?=
 =?us-ascii?Q?U64YoGO4MHhneLIeD7irGYPtHYm+vDeTF8U6yTda3/O6lYlUSE2zpyfJ2sYb?=
 =?us-ascii?Q?OMmj65uJrVzc255SmrOlcAWtJjEdr586rn5nWoCJnk7IS4AYoz7xoRmpRx2Y?=
 =?us-ascii?Q?Et5A5LwA1Bgilq8sE9SVFFtqPhVnO1Fk68cPZ0yMXI/Iqi0MKVMgXNY1Z35A?=
 =?us-ascii?Q?Zgz1U+84XRPuP0PFxp4+Ug1Ob8UppOpK2KoCWYPRC+9AWd8i6Fy3dG975RrX?=
 =?us-ascii?Q?d5rUkH9o5zMXQqoqeziSwiQev3T+qHJUuLOA7w4LVWq4U7rTpAXKuZ/bejKj?=
 =?us-ascii?Q?XnmR3K9717wfSWS7a33d2mWOg1fOWOlRHjveObg9GbjnC2efbTzQGSnGfugY?=
 =?us-ascii?Q?2NsogSaiTYjv0eB0tbrBDUE60TzOCDxKh1WNAqsBQ21W2hTl/omWi+8vBt3U?=
 =?us-ascii?Q?D/Fcad00qemrazHY431jh2f98EEyicaCpLkoY7/BcYeR58vv754ZWHniYP6f?=
 =?us-ascii?Q?aTgK9flC1c8PggI5jkZzGhKskO4BthV5IlN7ESpKHR8e89vNIrWlqZBI2gGH?=
 =?us-ascii?Q?wZyyxPEFNuOZwMVDrM0H/xo/iITNy7EfU0Xohat4RRnNNfktmumNOYmJLn27?=
 =?us-ascii?Q?fpmwNfZwFwSLG3NhcgKLHYWUoXHC8gZVvVYjwzYdIK0HtHmbOPmrFtvyeqOs?=
 =?us-ascii?Q?itR/P1YaCuPEsyCDccRdKldVoYysiHCsjPpjbkTuUpDWPfLwnNIcR7tfMaP/?=
 =?us-ascii?Q?LyxjT4F6o3ffMC4lCfrJ/xFhHK6V/ac5AQz05T6YoSdqMFiqu8SnGvJ3Z+QF?=
 =?us-ascii?Q?lhhHDe12Pg/PWcGmihLoDrB2hb+9yi6wN3JxRQ8+QRc0ieuRavJMnkqSevaM?=
 =?us-ascii?Q?wD1n+8pNCL3l/QmrtAkRwlh1lqn848Z2Tojwk7icmYbNAhRqcuTus5YS9jjX?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0AwRHRrR/Wjl7XssgLx2TKNZQijOFDeJxyPkcIJxAxtm08LLYX5ms1ELvqv/q/UQHuDhkpYBePhhnQ4FrUToADjqyaHHY3FVNCytJ75dGAgNe7kP1FasAHXgjUvcLyqZTZMB5c29yq68HawYQhqJvyMBBqxsGM3FzRgWOGavZpve89fsrAGAlbn0c7VyZYdk0sYUAYlcWO3RWNn8m+EKaJaAq2yT5dNs6DTCvk1AUDtrBq8D/JnjfoFs4sTEnQXTTo8pv9hv1meNEyW2/kJO6C6fXzZtvOHsJ6V3E5NgI4iR3iVefIFvzL6S9ZVmLiQNTv+UWQIxM3gVE8XVCouinxc7w6VIXzG+ij7rXgL+KI1daqcJKB5OYxacMCD4jVeaEqbcuDK8KiB5gESh/WSUzB4eIe8EVl59ids87RLDOOdzFuC7ttG5yRfQa2OSFtI3uiXFIM08EUC0VIfX2OyGtZ6BuziNTMlf2e1K/yczN9VAL0V+BqRyzim3rQDLmkyhdaq6gFwtFk9HFzTag/OgyPLIx9uLnLrhd9jzQMRvY5sVtJqVLlcd5SVSmyO9zbm0TdRMsFgGdZ2Mrbat7/j+s7DJBKn4TkHuD+F7KPcySac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee64065-cd9b-42aa-6829-08dc9c17489c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:51:39.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7CixIuupvEVEzmAmFhtHFtdtEGLM5APBtlTFqpQwVFIq8/1ZTGIbdAP7z9+QqhvaTO1IeLO/Q+XX6cKnt0GqyPFQNAhOvIJJ5cjXa5Z7wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040076
X-Proofpoint-GUID: T6sJv7sZqiRcUBcT5aKUqMvOZPHYXUSP
X-Proofpoint-ORIG-GUID: T6sJv7sZqiRcUBcT5aKUqMvOZPHYXUSP

On Wed, Jul 03, 2024 at 10:59:56PM GMT, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Wed,  3 Jul 2024 12:57:38 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Establish a new userland VMA unit testing implementation under
> > tools/testing which utilises existing logic providing maple tree support in
> > userland utilising the now-shared code previously exclusive to radix tree
> > testing.
> >
> > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > while stubbing out superfluous functionality.
> >
> > This exists as a proof-of-concept, with the test implementation functional
> > and sufficient to allow userland compilation of vma.c, but containing only
> > cursory tests to demonstrate basic functionality.
>
> Overall, looks good to me.  Appreciate this work.  Nonetheless, I have some
> trivial questions and comments below.

Thanks, appreciate the review!

>
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  MAINTAINERS                            |   1 +
> >  include/linux/atomic.h                 |   2 +-
> >  include/linux/mmzone.h                 |   3 +-
>
> I doubt if changes to above two files are intentional.  Please read below
> comments.
>
> >  tools/testing/vma/.gitignore           |   6 +
> >  tools/testing/vma/Makefile             |  16 +
> >  tools/testing/vma/errors.txt           |   0
> >  tools/testing/vma/generated/autoconf.h |   2 +
>
> I'm also unsure if above two files are intentionally added.  Please read below
> comments.
>
> >  tools/testing/vma/linux/atomic.h       |  12 +
> >  tools/testing/vma/linux/mmzone.h       |  38 ++
> >  tools/testing/vma/vma.c                | 207 ++++++
> >  tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
> >  11 files changed, 1167 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/vma/.gitignore
> >  create mode 100644 tools/testing/vma/Makefile
> >  create mode 100644 tools/testing/vma/errors.txt
> >  create mode 100644 tools/testing/vma/generated/autoconf.h
> >  create mode 100644 tools/testing/vma/linux/atomic.h
> >  create mode 100644 tools/testing/vma/linux/mmzone.h
> >  create mode 100644 tools/testing/vma/vma.c
> >  create mode 100644 tools/testing/vma/vma_internal.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ff3e113ed081..c21099d0a123 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >  F:	mm/vma.c
> >  F:	mm/vma.h
> >  F:	mm/vma_internal.h
> > +F:	tools/testing/vma/
>
> Thank you for addressing my comment on the previous version :)
>
> Btw, what do you think about moving the previous MAINTAINERS touching patch to
> the end of this patch series and making this change together at once?

Yeah I was thinking about separating that out actually, not hugely critical I
don't think, but if I end up respinning I can do that.

>
> >
> >  VMALLOC
> >  M:	Andrew Morton <akpm@linux-foundation.org>
> > diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> > index 8dd57c3a99e9..badfba2fd10f 100644
> > --- a/include/linux/atomic.h
> > +++ b/include/linux/atomic.h
> > @@ -81,4 +81,4 @@
> >  #include <linux/atomic/atomic-long.h>
> >  #include <linux/atomic/atomic-instrumented.h>
> >
> > -#endif /* _LINUX_ATOMIC_H */
> > +#endif	/* _LINUX_ATOMIC_H */
>
> Maybe unintended change?

Ugh, sorry my bad. Again, I don't think this is so big as to need a respin
in itself, but if larger stuff comes up I will fix if you don't think this
is too big a deal?

>
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 41458892bc8a..30a22e57fa50 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1,4 +1,5 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> >  #ifndef _LINUX_MMZONE_H
> >  #define _LINUX_MMZONE_H
> >
>
> To my understanding, the test adds tools/testing/vma/linux/mmzone.h and uses it
> instead of this file.  If I'm not missing something here, above license change
> may not really needed?
>
> > diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
> > new file mode 100644
> > index 000000000000..d915f7d7fb1a
> > --- /dev/null
> > +++ b/tools/testing/vma/.gitignore
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +generated/bit-length.h
> > +generated/map-shift.h
>
> I guess we should also have 'generated/autoconf.h' here?  Please read below
> comment for the file, too.
>
> > +idr.c
> > +radix-tree.c
> > +vma
> > diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> > new file mode 100644
> > index 000000000000..70e728f2eee3
> > --- /dev/null
> > +++ b/tools/testing/vma/Makefile
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +.PHONY: default
> > +
> > +default: vma
> > +
> > +include ../shared/shared.mk
> > +
> > +OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> > +TARGETS = vma
> > +
> > +vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> > +	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> > +
> > +clean:
> > +	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
>
> If my assumption about generated/autoconf.h file is not wrong, I think we
> should also remove the file here, too.  'git' wouldn't care, but I think
> removing generated/ directory with files under it would be clearer for
> working space management.
>
> > diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
>
> I'm not seeing who is really using this empty file.  Is this file intentionally
> added?

Ughhhh no, this was a pure accident! I guess we can ask Andrew to drop this
part of the patch if no further respin is needed? May do a fix-patch actually.

Obviously will remove on next respin otherwise.

Thanks for that, great spot!

>
> > diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
> > new file mode 100644
> > index 000000000000..92dc474c349b
> > --- /dev/null
> > +++ b/tools/testing/vma/generated/autoconf.h
> > @@ -0,0 +1,2 @@
> > +#include "bit-length.h"
> > +#define CONFIG_XARRAY_MULTI 1
>
> Seems this file is automatically generated by ../shared/shared.mk.  If I'm not
> wrong, I think removing this and adding changes I suggested to .gitignore and
> Makefile would be needed?

Can do the same with this :) good spot.

>
> Since share.mk just copies the file while setting -I flag so that
> tools/testing/vma/vma.c can include files from share/ directory, maybe another
> option is simply including the file from the share/ directory without copying
> it here.
>
> Also, the previous patch (tools: separate out shared radix-tree components)
> that adds this file at tools/testing/shared/ would need to add SPDX License
> identifier?

This file already existed in the radix tree code, I just moved it.

>
> > diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
> > new file mode 100644
> > index 000000000000..e01f66f98982
> > --- /dev/null
> > +++ b/tools/testing/vma/linux/atomic.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#ifndef _LINUX_ATOMIC_H
> > +#define _LINUX_ATOMIC_H
> > +
> > +#define atomic_t int32_t
> > +#define atomic_inc(x) uatomic_inc(x)
> > +#define atomic_read(x) uatomic_read(x)
> > +#define atomic_set(x, y) do {} while (0)
> > +#define U8_MAX UCHAR_MAX
> > +
> > +#endif	/* _LINUX_ATOMIC_H */
> > diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
> > new file mode 100644
> > index 000000000000..e6a96c686610
> > --- /dev/null
> > +++ b/tools/testing/vma/linux/mmzone.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> I'm not very familiar with the license stuffs, but based on the changes to
> other files including that to include/linux/mmazone.h above, I was thinking
> this file would also need to update the license to GP-2.0-or-later.  Should
> this be updated so?

This was copied from tools/testing/memblock/linux/mmzone.h directly
as-is. I didn't think it was worth reworking memblock testing to share this
(again, this is meant to be a skeleton rather than a complete rework of how
testing is done :) but we needed the header.

Whenever you bounce code around there's always a risk of somebody noticing
something previously broken which would not really make sense for you to
address as part of your change, I think this is one of those circumstances.

If considered critical for licensing of course I can change, but that does
make me wonder whether that'd be better as a whole-repo change for all such
instances?

>
> [...]
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > new file mode 100644
> > index 000000000000..1f32bc4d60c2
> > --- /dev/null
> > +++ b/tools/testing/vma/vma.c
> > @@ -0,0 +1,207 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include "maple-shared.h"
> > +#include "vma_internal.h"
> > +
> > +/*
> > + * Directly import the VMA implementation here. Our vma_internal.h wrapper
> > + * provides userland-equivalent functionality for everything vma.c uses.
> > + */
> > +#include "../../../mm/vma.c"
> > +
> > +const struct vm_operations_struct vma_dummy_vm_ops;
> > +
> > +#define ASSERT_TRUE(_expr)						\
> > +	do {								\
> > +		if (!(_expr)) {						\
> > +			fprintf(stderr,					\
> > +				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> > +				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> > +			return false;					\
> > +		}							\
> > +	} while (0)
> > +#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> > +#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> > +#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> > +
> > +static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> > +					unsigned long start,
> > +					unsigned long end,
> > +					pgoff_t pgoff,
> > +					vm_flags_t flags)
> > +{
> > +	struct vm_area_struct *ret = vm_area_alloc(mm);
> > +
> > +	if (ret == NULL)
> > +		return NULL;
> > +
> > +	ret->vm_start = start;
> > +	ret->vm_end = end;
> > +	ret->vm_pgoff = pgoff;
> > +	ret->__vm_flags = flags;
> > +
> > +	return ret;
> > +}
> > +
> > +static bool test_simple_merge(void)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +	struct mm_struct mm = {};
> > +	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
> > +	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
> > +	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
> > +	VMA_ITERATOR(vmi, &mm, 0x1000);
> > +
> > +	ASSERT_FALSE(vma_link(&mm, vma_left));
> > +	ASSERT_FALSE(vma_link(&mm, vma_middle));
> > +	ASSERT_FALSE(vma_link(&mm, vma_right));
>
> So, vma_link() returns the error if failed, or zero, and therefore above
> assertions check if the function calls success as expected?  It maybe too
> straighforward to people who familiar with the code, but I think adding some
> comment explaining the intent of the test would be nice for new comers.
>
> IMHO, 'ASSERT_EQ(vma_link(...), 0)' may be easier to read.

Yeah I did weigh this up, but the standard kernel pattern for this would be:

if (vma_link(...)) {
	/* ... error handing ... */
}

So to me this is consistent. I do take your point though, it's debatable,
but I think it's ok as-is unless you feel strongly about it?

>
> Also, in case of assertion failures, the assertion prints the error and return
> false, to indicate the failure of the test, right?  Then, would the memory
> allocated before, e.g., that for vma_{left,middle,right} above be leaked?  I
> know this is just a test program in the user-space, but...  If this is
> intentional, I think clarifying it somewhere would be nice.

Unwinding memory would make this code really horrible to implement, I don't
think it's a big deal to leak userland memory in failed tests (the point of
which is to, of course, to not encounter thousands and thousands of assert
fails :).

I'm not sure it's really important to point this out too, it's obvious, and
it's distracting to do so. And again, it's really just a wrapper
implementation. As discussed elsewhere moving forward it'd make sense to
implement some 'userland kunit' style shared libraries that take care of
all of this for us.

>
> > +
> > +	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
> > +				0x2000, 1);
> > +	ASSERT_NE(vma, NULL);
> > +
> > +	ASSERT_EQ(vma->vm_start, 0);
> > +	ASSERT_EQ(vma->vm_end, 0x3000);
> > +	ASSERT_EQ(vma->vm_pgoff, 0);
> > +	ASSERT_EQ(vma->vm_flags, flags);
> > +
> > +	vm_area_free(vma);
> > +	mtree_destroy(&mm.mm_mt);
> > +
> > +	return true;
> > +}
> > +
> > +static bool test_simple_modify(void)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +	struct mm_struct mm = {};
> > +	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
> > +	VMA_ITERATOR(vmi, &mm, 0x1000);
> > +
> > +	ASSERT_FALSE(vma_link(&mm, init_vma));
> > +
> > +	/*
> > +	 * The flags will not be changed, the vma_modify_flags() function
> > +	 * performs the merge/split only.
> > +	 */
> > +	vma = vma_modify_flags(&vmi, init_vma, init_vma,
> > +			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
> > +	ASSERT_NE(vma, NULL);
> > +	/* We modify the provided VMA, and on split allocate new VMAs. */
> > +	ASSERT_EQ(vma, init_vma);
> > +
> > +	ASSERT_EQ(vma->vm_start, 0x1000);
> > +	ASSERT_EQ(vma->vm_end, 0x2000);
> > +	ASSERT_EQ(vma->vm_pgoff, 1);
> > +
> > +	/*
> > +	 * Now walk through the three split VMAs and make sure they are as
> > +	 * expected.
> > +	 */
>
> I like these kind comments :)

Thanks :) I try to maintain a nice balance between not adding _too many_
explanatory comments but not having globs of code that are hard to follow
without giving an idea what's going on.

>
> > +
> > +	vma_iter_set(&vmi, 0);
> > +	vma = vma_iter_load(&vmi);
> > +
> > +	ASSERT_EQ(vma->vm_start, 0);
> > +	ASSERT_EQ(vma->vm_end, 0x1000);
> > +	ASSERT_EQ(vma->vm_pgoff, 0);
> > +
> > +	vm_area_free(vma);
> > +	vma_iter_clear(&vmi);
> > +
> > +	vma = vma_next(&vmi);
> > +
> > +	ASSERT_EQ(vma->vm_start, 0x1000);
> > +	ASSERT_EQ(vma->vm_end, 0x2000);
> > +	ASSERT_EQ(vma->vm_pgoff, 1);
> > +
> > +	vm_area_free(vma);
> > +	vma_iter_clear(&vmi);
> > +
> > +	vma = vma_next(&vmi);
> > +
> > +	ASSERT_EQ(vma->vm_start, 0x2000);
> > +	ASSERT_EQ(vma->vm_end, 0x3000);
> > +	ASSERT_EQ(vma->vm_pgoff, 2);
> > +
> > +	vm_area_free(vma);
> > +	mtree_destroy(&mm.mm_mt);
> > +
> > +	return true;
> > +}
> > +
> > +static bool test_simple_expand(void)
> > +{
> > +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +	struct mm_struct mm = {};
> > +	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
> > +	VMA_ITERATOR(vmi, &mm, 0);
> > +
> > +	ASSERT_FALSE(vma_link(&mm, vma));
> > +
> > +	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
> > +
> > +	ASSERT_EQ(vma->vm_start, 0);
> > +	ASSERT_EQ(vma->vm_end, 0x3000);
> > +	ASSERT_EQ(vma->vm_pgoff, 0);
> > +
> > +	vm_area_free(vma);
> > +	mtree_destroy(&mm.mm_mt);
> > +
> > +	return true;
> > +}
> > +
> > +static bool test_simple_shrink(void)
> > +{
> > +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> > +	struct mm_struct mm = {};
> > +	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
> > +	VMA_ITERATOR(vmi, &mm, 0);
> > +
> > +	ASSERT_FALSE(vma_link(&mm, vma));
> > +
> > +	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
> > +
> > +	ASSERT_EQ(vma->vm_start, 0);
> > +	ASSERT_EQ(vma->vm_end, 0x1000);
> > +	ASSERT_EQ(vma->vm_pgoff, 0);
> > +
> > +	vm_area_free(vma);
> > +	mtree_destroy(&mm.mm_mt);
> > +
> > +	return true;
> > +}
> > +
> > +int main(void)
> > +{
> > +	int num_tests = 0, num_fail = 0;
> > +
> > +	maple_tree_init();
> > +
> > +#define TEST(name)							\
> > +	do {								\
> > +		num_tests++;						\
> > +		if (!test_##name()) {					\
> > +			num_fail++;					\
> > +			fprintf(stderr, "Test " #name " FAILED\n");	\
> > +		}							\
> > +	} while (0)
> > +
> > +	TEST(simple_merge);
> > +	TEST(simple_modify);
> > +	TEST(simple_expand);
> > +	TEST(simple_shrink);
> > +
> > +#undef TEST
> > +
> > +	printf("%d tests run, %d passed, %d failed.\n",
> > +	       num_tests, num_tests - num_fail, num_fail);
> > +
> > +	return EXIT_SUCCESS;
>
> What do you think about making the return value indicates if the overall test
> has pass or failed, for easy integration with other test frameworks or scripts
> in future?

Yeah this is a good idea, will change on next respin.

>
> [...]
>
> I didn't read all of this patch series in detail yet (I'm not sure if I'll have
> time to do that, so please don't wait for me), but looks nice work overall to
> me.  Thank you for your efforts on this.

Thanks!

>
>
> Thanks,
> SJ

