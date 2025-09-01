Return-Path: <linux-fsdevel+bounces-59763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D714B3DEEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5421189CE16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650542FF65C;
	Mon,  1 Sep 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m2BzWhVj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vIT2jzyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439330505F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719834; cv=fail; b=Bu8bS/lNanaSEFU+iSdwhQGo5wyL67hFZHgL1QvHWpxoG/eU0jwVvBSfjBdMadPbTg/jSAYiS/VBwBiSdaYbhErfwsoSJdM79inUTxtYXWh/GtH/cvORC75Mr+P8zsg+2Dcyd0Zymj1qHRzrpwkIOT5gLv8+AJQyFsFCx1wa090=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719834; c=relaxed/simple;
	bh=50j2H5BA2gJhsQrtKsF5VvJ4VZmpaxFI1YHDH2UlUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCK+AwCcMQfavQBWmTZ618OgnJPrWG3h/RnuCJ/hZ9O6VwMVdrVUbZfrcpV0fK32vameGgf0H7xsseiShCErReo4dVufBHgYXF1PA1JO0zuCayyHxORCP4/zpRjzotOsRlDPhKgUoX4U4YQXcQu3xPnT3TGI562daki+dkOk29o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m2BzWhVj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vIT2jzyd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gN3L016488;
	Mon, 1 Sep 2025 09:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=50j2H5BA2gJhsQrtKs
	F5VvJ4VZmpaxFI1YHDH2UlUqE=; b=m2BzWhVjX79KwJRvG9aZmiqCqpo7bq4yKw
	yDI/zvjl/Lbd6y3NAsY+Zc3yPIfEixy8NKK7l6vN0ApwHpX94Ljr1mXMPaEsU9Jp
	iSAoS7TBLnjZRNvVV5Gyd1NkQCOuGfB7woj5G9BmPjiLpo/v5XZJyBXgMnCaCqVK
	i2/DJoOTjwg6Ry2bh6hJ88SuAW0/NgJINiIIjUd7JRtZolKKks9LuZ/oRYqe3AKA
	8SXn5mZvdQk+ufLBo+lmMYSPLQGjWGTUjKRg4tT3yg+FDJUd953h8D74UuabklPp
	jXPI5nAnIIVD9+jEa1oPlvhuZcaoKcJ1tF5INJRx2s/i0Lk/WeeQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvt4p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 09:43:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819fY5o011711;
	Mon, 1 Sep 2025 09:43:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdywgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 09:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO9zOIRYvcuuei/3Z43DBAcgN8lrIbh82/2kdNGqJ1ODn2dLnjsqBKy8W3iLZ2pWdmeCoi4Y6xl9PpbOVHLyD2CW6Uy64PzEQ5V2V2iN5f60O1+M9OdQHBuuryRRGcNiTdMgDsRXlaxdOFR4YldGh6MvoBq5oFAgVWijWRCQUQU7et+uaC/NlzUqATyJ7GszXIUWY6RkB1njt4kP6erDeeu7y/iYHS163ercsZluYFQNHcfqJlKA1IwiofZI777TwqqU0hLsudtDxmMC8EW7+synTa9mrucpnWHC5LcyQdV+s1tbi2WRNI87TDigTW8t/YvfnL3i8su86Iqd/zSbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50j2H5BA2gJhsQrtKsF5VvJ4VZmpaxFI1YHDH2UlUqE=;
 b=Rf9UoOtbAF5Lz1/7lpUYPCP65X63emGExPxpHY3FOiK5PfmiedUJ8urCFlcsD3aoomkFi2/F5i9BM+3BqEDUKAcDq2nq2FFaO0+B+GuV50PrflZwa3fy34jJiYMZIcc2olhMbeVsD+eVLKa4/VzxJWuuP+Do41xT7BV+uXlmxk0fsh+n7zyjm64/v86widztXfEWqfoPCmXZsCZghDasucQ9UU8GxoKHIf00NNrPp3wiYn1sv5Fmv0BBo2bGcmspfPioTYL2L1CfvQCgDfsifYU9ryABFjk3FeoPtan5LjhRiUjbPw/aS5fp24W9O7vOSgz6OcfqwlWj9ihihj8tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50j2H5BA2gJhsQrtKsF5VvJ4VZmpaxFI1YHDH2UlUqE=;
 b=vIT2jzydRc6/9iWpecqoonyADMc2U2rCmj8gE2tri7bgnUxavVE3mmJ+YYyq03FG+8q6bNzHB6z2EnSv+Q1ITg8SdTkGGzahofYSkpJyScpFzDhEVISjcxzxCkGgOgY0vyspsiKt08pQFfEP3N0YVdOPDtFc761hej+y1fe0Zyk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 09:43:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 09:43:45 +0000
Date: Mon, 1 Sep 2025 10:43:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: f2657ee2-0bb0-413a-84fb-08dde93c0b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LnP9DHnhQaOc5zCb9cbkzXjt/K/9NRvmPxJL1colgl9w3xyXbmBFiAoogCU4?=
 =?us-ascii?Q?EaaynnxE0i8eW8iiPdVDylc91lAg6ZpHc3BgwRkRoB9zcdGRF2L7gq1k/S4Z?=
 =?us-ascii?Q?JuPlcLJu1+SjRrEnUKcRTvtKxq5uQ9MHjcEUTjZDyjgXCvv34lcm7yw4ohzl?=
 =?us-ascii?Q?KWlwCtwikpTqUluUbN+hhl9IkcjpSlBAT/m68jIIeFaDYDzVe6s5E6fk1t5Y?=
 =?us-ascii?Q?K5MuozvUGqTd4dibe20oGHKrh80UFl1ie2H07ukospv28PbsVlDpwGXRR6BQ?=
 =?us-ascii?Q?X6rRzIQZdb7TmNIIGwfqiv2Wr3InpiRDGknI2ExjjUwCEYN4BjMQDSzuq4hh?=
 =?us-ascii?Q?9uOGD3YhidcErAJMWIu+mr7nC+zUAitEpfbjPvziWAnCHKIi0fSbC+tzM0DU?=
 =?us-ascii?Q?o32q205mLmeamBbzxiiHwv+i2TRjt5Iv1IKwbEOnyMTuEKdgZVu0VxO2iXAA?=
 =?us-ascii?Q?YrsDf+CMgUrfRCkK62+d7RnLfflAg9EAKx7fUMXfNAkrCEfAOHwQuo6YjRJX?=
 =?us-ascii?Q?nd3xztiJ9CXSj4+zht3HwDQeajpIHemfxd6ERl6xMr8buezkkz64xWAA6VC2?=
 =?us-ascii?Q?E+Vm38Vw+g124hmaQ464tUNyVJno2IEkd5yACLQ+ket9HTxUVXeEYCkjpy9s?=
 =?us-ascii?Q?evwzbWRkDHBEVTzDqri1HtWWVwHLffnKdCqRQveL3FezZhStNhGvvzt6dUzS?=
 =?us-ascii?Q?vqbCekdJA+zf6dVfVBRatpncfgJM2oahMUm+8b67E5adlKbPapETar95ub8f?=
 =?us-ascii?Q?S0nKwINV/zHKApemekvsEdf2KF7YX4PlRtNaB+qbA0GfWRfR6o7QwFCPpd9F?=
 =?us-ascii?Q?AGQBporGtlstR4/QS6PNvP7bOTaudEGSrjyfrKuZpzkzfpoBwg/FSwy4DNBo?=
 =?us-ascii?Q?7+Dho8Cj5Iy+dFvQYAs9j7fItnw89BFfbdplUWXvNB1Z5iVwXXSRmrbTqswW?=
 =?us-ascii?Q?mJs7PTqshDNOrGjLC0A8oEWK6n+6KhEqs1X3TYkec3hhBf0/iqeXm8/L9E3l?=
 =?us-ascii?Q?jh0HtxV/saWF3uUc2CFwM45W+3Fk0qJFR48mTZZYTU26a2oQb+K270YXkVdB?=
 =?us-ascii?Q?n8hMohyUP0DH42VcB64vAeWQobxyS9FKPORf4CuIOmIIHIJd5EyearH4h0ds?=
 =?us-ascii?Q?n6dmlf2Ka9fImVEyVjXDiYcVwjehDaRdqFuL8pJMGa37a5b0W7fhl9v/Rqez?=
 =?us-ascii?Q?MtyY8rizW2MssfMUjhA0ra6advWRaPM1PAGQrl7YREz2liIhgHhF/lhRxhNk?=
 =?us-ascii?Q?/IMW5MGYrSWEME5istszC9KnGZFfdI2Q2fqx491zP6QlcHgqv2gUl2PAfj2V?=
 =?us-ascii?Q?lmGghtXIxzvAYUrB2cJEFsfXJItP+0h05ApaxEYy4Y4I9KB1mMXwEovIhqrc?=
 =?us-ascii?Q?vNVASsBZZXtegSw9oYomqutnOPyHRDdkp/eRIpWe6J9P8skYZGB/QYrFEQKM?=
 =?us-ascii?Q?ujiLcgDVz6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?peDbxxJakh8hHGQ+Dhv4GFm8TWAsAoRcaynmyMfjuxMOxFX46guAm3lPBhYH?=
 =?us-ascii?Q?shOcry5tEyG6xSHClRydTe96hJoTSAwQpXTj1ATR44idOWC+xQArnoYnURSh?=
 =?us-ascii?Q?rxPPP09Gn+0xgCfVUfJ2MMBZqK2ogD3ve7THjGWkJ7CqjR7mKxXRYyYzjneX?=
 =?us-ascii?Q?7BGImSoLGeOkdBpJ8V8LLDydjnmfry9nB28teMt23DwoK0tk/bzKhTEHpAJg?=
 =?us-ascii?Q?QexY3vjVf6X1fbcerct/crK4SjlqhaQjQSQdAQi80N91Uz4pW3/ZdvfrbW3y?=
 =?us-ascii?Q?6ANoOTExwI6KBb7cIWLdZs5jxbhhOcVlqdMLKDZUDizFkh9brTgtengHQ1vx?=
 =?us-ascii?Q?qosEnpVETtcHN75VJq9gbzqMf+FmSCG2Wkt3POsomRWecRM9NJaPjr9U+1nl?=
 =?us-ascii?Q?GAl86x7tTM8ciMLzOWKTPDXhoDAtJMOT85dqw8fVxCr/tCbBn1cBIw7ahjQQ?=
 =?us-ascii?Q?Rr9B+LwZpagpTcRwyRaGseT7lIAjJAdVt0IdQwYCTDMFlrvuhPMJxujzSkvz?=
 =?us-ascii?Q?G4ZQfvc1uoaWlxvKUVR2xkbRBa8103B4Gjyy3ZQiEuTeUvwM0hBAAw6DMT8C?=
 =?us-ascii?Q?pK3Q+pNfkhYhq9NjuKT0nn9JJ7UKfkWM1N4QAQpJeP5cI1fU86adoyktTS3V?=
 =?us-ascii?Q?qScnvB+OsHkN76Buj7HlvCQ0yOWFqYtkQzTptnc1q7BLH0Jwq5IQxC+WYL0D?=
 =?us-ascii?Q?ycKS/uvI/gFiWozU7NPDBtw9r+1Tp3MhV2loe3KcWl9sjN/nckP3ZgrtNrlM?=
 =?us-ascii?Q?Sc5oee1x4TRLEEhYmmmOGrZFCoiTdu4aPZuyTDTDsgTKLd+MYDVFz555fzIu?=
 =?us-ascii?Q?sKebSkH8+OKbKlALjEJ33c+A1FN4RHW+n1z0TtFxVelCOUAcVJcBj/PxJM7H?=
 =?us-ascii?Q?2qZ5YT8EuST5qS7yDUzUN8KWJ8cJPM94nkVsviGN+csAZ4Ti/umNS8/wZ6R1?=
 =?us-ascii?Q?BFWui/RyL36sZJOzuD8dXugAOq0R0aK2Tgbr7FA+Oj/Xn8jno7M62RBxXVpa?=
 =?us-ascii?Q?xQPONi9DTR7Ga6M4f+vp2lTcBSpmT8ApDfpIT7SUseycGERQMoadIg4nnGeh?=
 =?us-ascii?Q?3hDlLIZ1SRoCgqfnoS5bGVEx1y7SutzuS80puTLD/tNKF28JYDodPw6PmjG4?=
 =?us-ascii?Q?6WugBIVrfIbySyrdy1T/5cGc/32o9z11P2eEt3NGelXhz+KFhStGdEkf9Z9t?=
 =?us-ascii?Q?IqpN0+plfbyHst0a4mkkzxQuWhR324I36/wVlrPBO6hLHfP717L6xKDgwWd8?=
 =?us-ascii?Q?eo+bYCgaUJOY1ZwibyaSieozYelvGjgP63Dnx6r4VHpwnaNVLg50uxjhEBXk?=
 =?us-ascii?Q?zuzk9pltGZva2lYKFB7Vp7JEsZ78w0cR29w52Op2xoSb912KnaukJscBx6PL?=
 =?us-ascii?Q?2kZk2VwLIsWtXz5Egvdk87oMmtSxC2iA1Shd6yu1CoZtrhQKLe8bhf7QO5b2?=
 =?us-ascii?Q?62ReAn8JeT3AxKAp5+8IYYbwXlB3uggLofE3MqKQxFaWoMUW/+rb7zjLZiuO?=
 =?us-ascii?Q?3xrjCaT+WhRw1My7nBhtvCPlNGvOjUqN5xQ7+5/IegqkLSSuSVqquEPCtNDk?=
 =?us-ascii?Q?p0kGbgaEepJsyaM5LYvGRvCZc9NSBMuR7Gaenka3sBfzFgqhkG6t5/rdcS4o?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nj6/4FPSI7fnM/GUaALoJFzVzJfABv9eikAfO/pq0EpI+qRLVOCVbPvPgl/trxm4scx1kol13kYU7cqvZuj7HFqfwcrUmzs8mqdPltQSrogb6V+SmqAp3DjE4fa3UMSWpbqxKsovn8p2mpGgZ9kaYUH3FI8LDqhh2jFNFthogDXw3244uQoxnXNF7nVlHej022Qqs7ULhBU1Sju2eFqJ1qG0LOayORZgEOAVKS+LiOHaQRq678bzEKFHCJTZSPwjHtvLZjJW2IZJmnGxXTd9DrNxwUmyu8KHYLKF9ckXxGHxaZXn0NtnraEN94HoJk+slgLAYDyzTufrfRsAQlmYedINV2kw4z6rFuVW9a413G9viv5zTWVkbLb/8/ufvX+RqL0YvEj2zz0M4As3UUjEKEtiTpwnMZGZ0vAAAXNlGji2XBfP3QANyn3PndoVvFfVFVA5FHF2iGOn+27aCNDNK8b8QMe3u7Xf2sCXHZicsIO2HZoRdZ0Xc0NnVDvYWBQJmUeDYt7dJ6mZBz620xB69HWypD8U1yWK99LfTaNG67VqWz15Rh2CPvnxcCnzZY+6syPbbcZDdRYGGw4oK7Dl/82EJz5CXRa3ypm8Sz0h2C8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2657ee2-0bb0-413a-84fb-08dde93c0b58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:43:45.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9E2m46Tpywdv+zN6G8IW8kIdQALv03kveprG6pbytQd+VEiNkTMY3EtJ0JUEaRAkmOGv1Yi0WvNDjfVin6Yk0/vL/qZ0eLOVWHVVcFW+Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5vjX+Qftmy0U
 KQaBVIRlXBBcLJhl6lt+xC4bKvrakmrLG/Qdqwv3geOKdIIUXETF47ElcHObvStyMqZf0sJLjtW
 BhTt6j4xkl2G580cKzEGHVw4eOs46oC8EC6ZNj4os95HLvnpkLMWR+1XSIqQy6ZDc/vgAb4/usR
 cPXgPvE1YHZM6kP6O5/rJNqmRhjVRPkUbCX8wvCBwFXiq0lj94bxREXuCWXMfiWeo33+ntQMJin
 0TYjQBCtjBu6vK1Du6rbEMMtltF+3xhEx/hJPxD4YLo3AQJCH8ae+w86FaazAIrOJfXCgVfw5Bv
 SMtxNGIxqx9x5nwhsC+VjW3PFdHPbDsBsJxmsC/MP4/T8nmAnAOXMWbib7rgpXkC4d4G28GVn9Z
 GdUD/Wl3l2KKJi5zLeUpkDWIYngYTg==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b56ad5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-x51ip2udtcMYWxysDwA:9 a=CjuIK1q_8ugA:10 a=VeoKaM6TBCQA:10 cc=ntf
 awl=host:12068
X-Proofpoint-ORIG-GUID: qnjqX-Jkkqoxd1a_X0aNTUW5hfpcLHib
X-Proofpoint-GUID: qnjqX-Jkkqoxd1a_X0aNTUW5hfpcLHib

NAK.

For whole series:

Nacked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

You are purposefully engaging in malicious compliance here, this isn't how
things work.

Read again the review you've got and comply with it, writing in your own
words.

Also review https://docs.kernel.org/process/code-of-conduct.html please.

Lorenzo

