Return-Path: <linux-fsdevel+bounces-49448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F05ABC761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1010A3BFC47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E020C00C;
	Mon, 19 May 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJyLVTJ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nc8U+1JD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D041EFF8F;
	Mon, 19 May 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680746; cv=fail; b=eH1zlE4xjfuNSldVPT1Red+d9QzGSVlORFoy1t3qZZ987ZGoL9bsH7TmDzZ43Bm40qV3PIgIfZS34Y8INYzsyOlKRfLLMVsFNdXD22MbN8tsSi5fk/zRVDEbe+mcpFDBQmQLPpbS6212T2va2xd6U5L2s1VzSzRP6KO3jIDezHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680746; c=relaxed/simple;
	bh=vBsOQ1jxlOoVKH86TmmBqRxbjqiFXLJGVlIWNBgVEaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBscRYtT0y+0YC8XmGaJz3IEfMc/EceEa7PGSkyk8yq2Jb5yKlIXMPGJIe6nlvkJNfz3rIIE4AgoQqfdas39g4W/wdseeUVgs+cAix5BjEerjWJr6Im38eS2+hUXtmL2iwswU9qqNyYGJYRlnbYBpqG3cf/Qg2INDxvhWXgUb5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FJyLVTJ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nc8U+1JD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMuOs028893;
	Mon, 19 May 2025 18:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=U/O3WNGaZT+tXC6AcE
	lWc0OeEmJxC6ItnAm65goFZzE=; b=FJyLVTJ76EhcU5YSK8AUpm/DiQg3xtGVBs
	lGe+uUs0SkBBJI8mP8WKtBfhBP9/HZpgLORyqBbYFtAYzdZkQNrTsZmxHOUBUm+m
	wGPEt6F4LmtvxFEQwXQYqs9X2R8EPAu/+XiMyQuXjHtV/6Q6z9sxDLj2lz+98WyA
	8/31WgNvMrPOTtfoEkDvaxGn+6IbS8xh8dP2XxJtxf7B8Rc0vr/co+S0+GF5opuA
	qTFwdnIh0DVukIQYk0m6ioj3kdcnVo/3wCHV8Y+Hf/onqY/ErSdjsstjB3KVxrGz
	8DzHHiDbvRRbBWPG/IkDI4eVF6GKJEwMI4kM1s7ZN5D3HGDAn5WQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuphs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 18:52:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIU9sx037162;
	Mon, 19 May 2025 18:52:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7tkat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 18:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne9PNLtvhGBEzJ9YGt0UQAPdp28uWJEDfPTxzdJjyTuWnXcag5tCDzs0fErQlR2jpLk9IJpYBMRW5JdubnZbkby9ba7S/7wSHAoEecQTUmwO55MTS2iIJ2gGYA88eyfxtrPtoLfPmoJhCsHAzbXKOHvmSm4x5+ProlpTsX6sO5ksCnmA222E1pB5UIl7qRtws5xZHSOz/wO8P/+3foC0EcLBUqy2eATN8JA+/Qu+Ib5zvDNsZtemakSLIc/MqvJ+jXkLtKIJXV9RNCc/qOHNATXTrY4t51KsfQ7dW6/JJgpxKM3uDH8qrsKTb1Qvb5GjTczlIjnHJeEXlVzEeybTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/O3WNGaZT+tXC6AcElWc0OeEmJxC6ItnAm65goFZzE=;
 b=wTmS3hOAIuIctoZH7fuMgUMQOh7bs/6F6CQlD3e/Pu/IsiNjgQaYcjiI8/cINS80ddOUMNr33Y0o2LJ/MgqEaxeiYZQdShXitm8YxZsVYxxnAg3FPaApSk28ACM2nza5FyqHXMHuUnc/9k2CyEkhhu3pIg8DD1q5B4hdhmHaoJyX7YJq5YrfqH+8LKYb/+E0+1fwg9nSHRYqW+OFunCnOxwa1bAtc7hb+QK2Mdr+WdRZUd7PIokkL1G0z+Ug7/drvxX1L4EMsXRjyQITNEjDoC+/q/sY4i+WWF2zUXkROyVZSbqXSnWhYWX1df93qvyTPNKg3UW22IZg7K67Obytnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/O3WNGaZT+tXC6AcElWc0OeEmJxC6ItnAm65goFZzE=;
 b=nc8U+1JDeFR9yUo4FyVtvoU/koJugsyHwOMgeNikpoqveSzVF586UQSVTZ6yKPths+xwGVcBWfRooN+pJHxFhgnnPJWLGDCdwsFRKXytyOmjKUNAl0GjTZXNyxoEqFjzquJLd3cDwjLJ1azyAcgEhKXqIrGLEed6yhWgrb7L2ds=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:52:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 18:52:02 +0000
Date: Mon, 19 May 2025 19:52:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
X-ClientProxiedBy: LO2P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0505ac8b-8571-4bc6-da68-08dd97063e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rLAFyJx0vYAFteXlT2Bw1omCkJKjeWQXQtpxbJNoLirfji5b0T2UiHALd/W?=
 =?us-ascii?Q?ZZ6P00jjuHekmh3rutlpbM0i4WOooblEDZA1syYRNqkkgslb5a/kIuFy2bx2?=
 =?us-ascii?Q?h4VOcbIyonUba1dLO7ZFMLLAvrtdhc1O5yXsoJ+l9RwinKTRxkwKvKldrloA?=
 =?us-ascii?Q?+K1gwKAcdakJXvR+ZTrpv8tFIHqYBGtZGr/F1jEp21Q9cAG/br/qtXhMm/M/?=
 =?us-ascii?Q?untQLLApBItIlOcXQgwF47YgcF8/wcobivrKDF8SrPXbiGRmaPdrl26N4jiM?=
 =?us-ascii?Q?gOPX7T2oSa9oYLaYVUfxsHsUM/YkycnFwgsbATtSizZxGf/QPLwePM9jp6Xy?=
 =?us-ascii?Q?xRJqgFx/PPqrKxRaUr86FRC/2YHkwx1V54ovl4Vt7G9m+sAr0HTSqP+c5w+f?=
 =?us-ascii?Q?mM01pSWPrNcaj3nSBoZig6k5Vwu2TL11XKtzuCSj61Z1rfFuMTSviE6gPADo?=
 =?us-ascii?Q?zB0C+haU7DLKD3+XXhC/cXKJlfJC+LLQVe2GaW57/JVPpDRRr3Z8AH15+mBN?=
 =?us-ascii?Q?+MlRZJxNlxGYqa02+XgV0K+x8IJpeyoVopPS7v10uHKjo25oyQ3SdOidydSn?=
 =?us-ascii?Q?ERwvhVwG1Y9AujWNQnzJ5ZSbuyHJAvWRGNznI9WUIYa7CX2r7HNoBIZlGBex?=
 =?us-ascii?Q?85eyLUWf79VhjqLfNSI9XEO5vqWUG82AZoPFEui+DU+Pmp6m/pgoh3msPKdT?=
 =?us-ascii?Q?9W3xeyffTKSc+U9YQEzt3ED1xqrW/Qxn+2Hcwhv/5B9kaQzq2B9DKeLOp6df?=
 =?us-ascii?Q?7eSD6Lp2z44R6KXkp16nGlTXS3ZZuGrfpZJReqyzgN/Ivw0cUEwtSFToxXk4?=
 =?us-ascii?Q?Spb4Nijv9qYJZnkpc5vo1cVYs8AQTBsKwkyTYeOk6xfDMwe68z823xvGthpg?=
 =?us-ascii?Q?UOoUFwWPWfG4pbZKbhyuXP+7FqksW4MF4H26Kcla37eirgerg1YeF+Bcpfj7?=
 =?us-ascii?Q?Px7EtCdkvP1WqkbRzi3Djjo2cXawv1IBpN499GhftznU7RXG47APDyHQIQog?=
 =?us-ascii?Q?LulbMCgSaqpta03CTkySsWDkeNdXqw2qHwzVn2VwD4kpFH4W0xxNHdGJCziO?=
 =?us-ascii?Q?JDFelldlwo27S+/NxUHzHs5uJUuWxtdsd4qMBVjSTGAmkyU+WWRFSZCM15lS?=
 =?us-ascii?Q?NWZ6/XZBnLJ6nZ191SLQLWOihY9TfI15zdDdeoO2+HoQ5aZvJd9OinH6l+kN?=
 =?us-ascii?Q?fR8R7qurvfgoIYREM/lO72pajvBFb7H05hX6dKbfIdHRBG/VbVydMqQ3w4Yl?=
 =?us-ascii?Q?TAr0b5JfX/mFZhsuGKbEQWnz3ZXIw/xGaoxEKLMKrMn84YB3q9RoQAVPTVff?=
 =?us-ascii?Q?oVRyA8JuHCVJyQueE9akFjZ4jzHCr89uYT5fyGJ79FRpIFcbuLVtf46nknVB?=
 =?us-ascii?Q?dj04VeXlh6yPVx8agKZVmMAPcX9a17B44w4L1c45XopB0U7Nh3OgPzMj1+Oq?=
 =?us-ascii?Q?Ny3ygLoq57E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/avXrunVE5Bup9q1PQTRznWlPlC1TXf84ItZuAyo8l+04Cw5O62M3PCnZEv?=
 =?us-ascii?Q?vPifJl7Un4FneQIQi1vPGMuGW0LPLuyDJ4qLbxZS4X8BK9h7JIyksjufK7gK?=
 =?us-ascii?Q?xRxLnGLEoOGDmKYmCyfMVP8YdF3zRF3z8cmnebf5jYyXrYD99HIdne+JnEvB?=
 =?us-ascii?Q?6pYeAlR/7GZjO8srg093ctz0JCGjR6UCoQdHwEMXAnUrbSgwWb8SoxuO4fhh?=
 =?us-ascii?Q?7P/kviGG2yYFtHQ2+fzMv2HJztY28QTB52s0F9KoSX2IBs3D2bwWmqdRXWvg?=
 =?us-ascii?Q?5oTUMKQxnkzXPZ+Ix9t0qP73Gb7T1xq5XH+BFRRa4Nmu//wYf06/LIFmZLQT?=
 =?us-ascii?Q?xsdnHyF9ciy1IO10gJlawN27ygP6j8IbuNIxQZ2jT/pEUa2/cWCV00cHh14b?=
 =?us-ascii?Q?BGtFSx/qMH4aD8EnCuOWpdBy+bWrnj+YIn4/48Tx1vrpkgAGoQH64ZLX+7Bh?=
 =?us-ascii?Q?syMxelOTiz7YHhSKSenlEYj3a9jPJfNrhHED7CU7GOk7KWIapp4TSAxKcvDC?=
 =?us-ascii?Q?ztZeWb46KgiialbK7w4REPvx6zUrQ7aCeg821bpcg+K7v+3XEhjs7Np0/YF/?=
 =?us-ascii?Q?mOsci2mNj6+L9IggFSv97etrHid4H7CW03ae1l28RJjs5Id3s8G3EI1GGjGf?=
 =?us-ascii?Q?j7J0ORdmhD8Bif5RrNiib/XxmkjACqhS0i3qn6VnHEfHjtqG/viO20ByKkqA?=
 =?us-ascii?Q?ewAyMqF11Z0RIjAWOaoTMX1hTby2xak3CPBN80b9hLyvHUv3yGtBZzsY70M/?=
 =?us-ascii?Q?YEJqlvGjepHLACV0HQMyYtr0lmLNv4/7fT2U0K7Q+J4xEL4/BpGesruYOc4/?=
 =?us-ascii?Q?iFxb4m7Z2JlFzWs1UvALU3iiL64gulB4lJsd1fqnXMeIyLdiEo9EKoetUKi2?=
 =?us-ascii?Q?nTqXlzEpTTeAqBvn7jgSZ4ghbKRuikSA8h+eSPy2BCES6WXX47+I1whfMZxa?=
 =?us-ascii?Q?bN97nOKm8M0ShcNmbRvBPlmv5QwwdElSPQLVkaAlEZid1XX8znl7esccojIw?=
 =?us-ascii?Q?hbGQCn2WQ+qRw64Oolc0VL9BQrHPIFTwGhPEnestl8e5L345z/eim4SWAYFF?=
 =?us-ascii?Q?BSXOuImN5EZ18I5h4SgAs5pRahLGP8GjVlwSJTXpvna2XHlEtJ/rf5CT/o9g?=
 =?us-ascii?Q?NFWF5eGeAYI+ObclvxNCBtgri4Syvj3a8PrIE5NQ7LD+IgjkMsier4o3QbXn?=
 =?us-ascii?Q?J8g1bQkn/p2gqgM+FvQR2pcyTQuja6kXtQ2EqIRmLl9Cy2lUTGBTJj0c1pyo?=
 =?us-ascii?Q?IANb/RG2jQ94kUDX087/vjLKcvtzNyxfn/utsyRq2gWn0bQuoE6Y6/z7ovMy?=
 =?us-ascii?Q?D9gd4blcAblNWJsgffc2DZyCs7CWddKKEkK5UutigG8FT528RnStugGE9hCg?=
 =?us-ascii?Q?kp7K38rEZR+SCNJY+56STabl2hicqmR8xssmgyAjPhOJA0KN0WrMYseRzX40?=
 =?us-ascii?Q?lD3vwEjI141OO4oEPfjfcbxGqFWkWX5EiBRK1s6lJ2Bo1O1bHDeLq+CPXEHs?=
 =?us-ascii?Q?01X+PCoLDQQm3rST7uXnk8Mr2iT+tB42YnIOEIp8vWHWxrjEhgLy07ygRE/m?=
 =?us-ascii?Q?uVvuVOdonAPYa1EPydr4GcJsGtLVRRNn6RKTLaxw7dGR/kRNV3t2fNg2GpPG?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ER116bAt4qJk/2kBu5yjx4/+c+6WEaEKzgj7HHGYJ163J2R9tJIcnFmL5jqEEg5LpdJS7W6JRWqXsKE5XN8qjkzmc/VoOgZ1OaW1ek7ZrQwChZ1gHnfeZzQeWXJhDdk/cx/u4XcjUsoqHXCi7ylTCPW2pkb4UZLKPm03iQ93cjTma2Cj5pEe2YaK3+dnBYdIo1ZFiPKofN+pygHAeDmIR4BAENyYBZPOsncn9mVAecikhX5FLSX4+xztiUkkopCB1lXwgrSWy405pzPQ8vKu47FH2Y3TI2XAbwSl+QCf2+e0dlC7ZddVO7bUCvBjNTzO6dk8MbrlzNFUZ5SJT195+HpIJE2nsDIqzwIxqsq62tUK2ESVqTHYzFOY5M1CXuYVM84HpjXANiFyyiXwYW4I3ZrbFt+Jf9Jt+qT6lhtmcM/FSQzFu8CiQzHwN26Dn8YCsxuf0sbwSqbm4+6BC5AWVIVJz617ViFLKrphi7GaJ1BIHrfhN2D6/rdLZ23qTrAJDNlK0rRKZn36KjXyIkhYvf7cNGc61JVHbXhIPEDnlIMzy/P3eqveXCO0GB/UYLzAvtecVueTXYOjc7hXpRlcGnzYf/bWvzs814m5zUOEzU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0505ac8b-8571-4bc6-da68-08dd97063e1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:52:02.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWmWByXrePzlWqx7w2EQpGA4C6gg8yIJ/yVUtFO1YtNrz5DZ8hQsAqOft4xwVjvGqLu9StCaUCJ1XDfImaSIIFyVy7rY7093FZbExQdcw1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190175
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b7dd6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=EdfpRc32WRINEomMGnYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: 3xVT0_nwaLW-Frbp0oAlWNw-Uadgsw38
X-Proofpoint-ORIG-GUID: 3xVT0_nwaLW-Frbp0oAlWNw-Uadgsw38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3NiBTYWx0ZWRfXx2aknhnl3+yw dLzlkNzxJwzxkPV8n0KdbmwftzkaOoEcON09JCpxEtsuc8QW99ku+lbRRsZVzvWPgGHHVNMWcr2 fW044pZi8rFRz1KCb/Tp7YB1DthqxNfGCTih6fXbUMsIlty7OA8NIAwaofjf9B8R/FdNAqcZueb
 Dos6+8OcqhBUcXlHTfDQ1SvPeXiTa5nbEUCfTxVN5MgTshU1T/FRFDf+0G/f/CFRXmKFBFYtC1U POMW7hbVO725LdAOqqUf/jGr/LYT/Rul8+ms/cqkf155z3DV30inFCZdjHrZuJDjcmzeG6gLfk0 mN6+SieELYfB4G73CV8ePcM9f/NT+gPv2zG5v9vAUJcwUSL06svtkLTCphAWNUnDgOFiCv0dIoF
 1XaSyqc5s0hihWMBJhckt21lcMnzikrTL1i1Lre3WnapRkYhyhnah1ehZ7Ye2f9fg+JmxlU2

On Mon, May 19, 2025 at 08:00:29PM +0200, David Hildenbrand wrote:
> On 19.05.25 10:51, Lorenzo Stoakes wrote:
> > If a user wishes to enable KSM mergeability for an entire process and all
> > fork/exec'd processes that come after it, they use the prctl()
> > PR_SET_MEMORY_MERGE operation.
> >
> > This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> > (in order to indicate they are KSM mergeable), as well as setting this flag
> > for all existing VMAs.
> >
> > However it also entirely and completely breaks VMA merging for the process
> > and all forked (and fork/exec'd) processes.
> >
> > This is because when a new mapping is proposed, the flags specified will
> > never have VM_MERGEABLE set. However all adjacent VMAs will already have
> > VM_MERGEABLE set, rendering VMAs unmergeable by default.
> >
> > To work around this, we try to set the VM_MERGEABLE flag prior to
> > attempting a merge. In the case of brk() this can always be done.
> >
> > However on mmap() things are more complicated - while KSM is not supported
> > for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> > mappings.
> >
> > And these mappings may have deprecated .mmap() callbacks specified which
> > could, in theory, adjust flags and thus KSM merge eligiblity.
> >
> > So we check to determine whether this at all possible. If not, we set
> > VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> > previous behaviour.
> >
> > When .mmap_prepare() is more widely used, we can remove this precaution.
> >
> > While this doesn't quite cover all cases, it covers a great many (all
> > anonymous memory, for instance), meaning we should already see a
> > significant improvement in VMA mergeability.
>
> We should add a Fixes: tag.
>
> CCing stable is likely not a good idea at this point (and might be rather
> hairy).

We should probably underline to Andrew not to add one :>) but sure can add.

A backport would be a total pain yes.

>
> [...]
>
> >   /**
> > - * ksm_add_vma - Mark vma as mergeable if compatible
> > + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
> >    *
> > - * @vma:  Pointer to vma
> > + * @mm:       Proposed VMA's mm_struct
> > + * @file:     Proposed VMA's file-backed mapping, if any.
> > + * @vm_flags: Proposed VMA"s flags.
> > + *
> > + * Returns: @vm_flags possibly updated to mark mergeable.
> >    */
> > -void ksm_add_vma(struct vm_area_struct *vma)
> > +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> > +			 vm_flags_t vm_flags)
> >   {
> > -	struct mm_struct *mm = vma->vm_mm;
> > +	vm_flags_t ret = vm_flags;
> > -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> > -		__ksm_add_vma(vma);
> > +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> > +	    __ksm_should_add_vma(file, vm_flags))
> > +		ret |= VM_MERGEABLE;
> > +
> > +	return ret;
> >   }
>
>
> No need for ret without harming readability.
>
> if ()
> 	vm_flags |= VM_MERGEABLE
> return vm_flags;

Ack this was just me following the 'don't mutate arguments' rule-of-thumb
that obviously we violate constantly int he kernel anyway and probably
never really matters... :>)

But yeah ret is kind of gross here, will change.

>
> [...]
>
> > +/*
> > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > + *
> > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > + *
> > + * If this is not the case, then we set the flag after considering mergeability,
> > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > + * preventing any merge.
>
> Hmmm, so an ordinary MAP_PRIVATE of any file (executable etc.) will get
> VM_MERGEABLE set but not be able to merge?
>
> Probably these are not often expected to be merged ...
>
> Preventing merging should really only happen because of VMA flags that are
> getting set: VM_PFNMAP, VM_MIXEDMAP, VM_DONTEXPAND, VM_IO.
>
>
> I am not 100% sure why we bail out on special mappings: all we have to do is
> reliably identify anon pages, and we should be able to do that.

But they map e.g. kernel memory (at least for VM_PFNMAP, purely and by
implication really VM_IO), it wouldn't make sense for KSM to be asked to
try to merge these right?

And of course no underlying struct page to pin, no reference counting
either, so I think you'd end up in trouble potentially here wouldn't you?
And how would the CoW work?

>
> GUP does currently refuses any VM_PFNMAP | VM_IO, and KSM uses GUP, which
> might need a tweak then (maybe the solution could be to ... not use GUP but
> a folio_walk).

How could GUP work when there's no struct page to grab?

>
> So, assuming we could remove the VM_PFNMAP | VM_IO | VM_DONTEXPAND |
> VM_MIXEDMAP constraint from vma_ksm_compatible(), could we simplify?

Well I question removing this constraint for above reasons.

At any rate, even if we _could_ this feels like a bigger change that we
should come later.

But hmm this has made me think :)

So if something is backed by struct file *filp, and the driver says 'make
this PFN mapped' then of course it won't erroneously merge anyway.

If adjacent VMAs are not file-backed, then the merge will fail anyway.

So actually we're probably perfectly safe from a _merging_ point of view.

Buuut we are not safe from a setting VM_MERGEABLE point of view :)

So I think things have to stay the way they are, sensibly.

Fact that .mmap_prepare() will fix this in future makes it more reasonable
I think.

>
> That is: the other ones must not really be updated during mmap(), right?
> (in particular: VM_SHARED  | VM_MAYSHARE | VM_HUGETLB | VM_DROPPABLE)
>
> Have to double-check VM_SAO and VM_SPARC_ADI.

_Probably_ :)

It really is mostly VM_SPECIAL.

>
> > + */
> > +static bool can_set_ksm_flags_early(struct mmap_state *map)
> > +{
> > +	struct file *file = map->file;
> > +
> > +	/* Anonymous mappings have no driver which can change them. */
> > +	if (!file)
> > +		return true;
> > +
> > +	/* shmem is safe. */
> > +	if (shmem_file(file))
> > +		return true;
> > +
> > +	/*
> > +	 * If .mmap_prepare() is specified, then the driver will have already
> > +	 * manipulated state prior to updating KSM flags.
> > +	 */
> > +	if (file->f_op->mmap_prepare)
> > +		return true;
> > +
> > +	return false;
> > +}
>
> So, long-term (mmap_prepare) this function will essentially go away?

Yes, .mmap_prepare() solves this totally. Again it's super useful to have
the ability to get the driver to tell us 'we want flags X, Y, Z' ahead of
time. .mmap() must die :)

>
> Nothing jumped at me, this definitely improves the situation.

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

