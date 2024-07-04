Return-Path: <linux-fsdevel+bounces-23120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977A927564
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C78B21A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0781AC450;
	Thu,  4 Jul 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTZsvsZK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UyReOFX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CD19B3FF;
	Thu,  4 Jul 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093485; cv=fail; b=G0cILjZhbvjShV2igRI+ECwBNvxds0xl6X+zPHtwusi6nnYMjxu4rYOwazDip+T0R8q7legtQbPDQtle7XRzpmoQGvOmEqpnbYcqWucaS2Lz3afb7rfIaJ0BfR6UqU+vEXiriF6PQTIKZ+7D4z/B3rcRsMX6ktXr4obq8V5onHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093485; c=relaxed/simple;
	bh=dI4qjdX5QyWsUyqj9/uCei9NS7VhwSWmI+doLOEOEiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=biDjEOsMKDvqw5zTi4LKAyQDpan+AfrqDPIq+zI961qlTN5qF4LzUgY7UQZTsG0nagsSJFLh79HQ1hjtet+oZA7/3DadflKpyCuKm+DkKBIiB0Pe4HeATyIC1FGISExvq7yxnT07zdVLajaYb5OKAoIoBsc8ZumQq6zrrOcc9V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTZsvsZK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UyReOFX1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4642MUeM031196;
	Thu, 4 Jul 2024 11:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=IN37Pr2nsH55qqs
	RczA35wTwpm1V5zB/0ycuDWTYhjE=; b=NTZsvsZKywyBucZxwZoeQ1Rh3Lq8qOe
	i2K2z8MILK1vgixg//giKgkDIvpbfF6ZuZkynv2brHzWJYNkHOALByF3jbXvnrWh
	HPlAinVG7odEXoy0kCL+p0LLuBrlvdRiHpIboS1ta+v0sX68NuVC+Iu+X08f6OA0
	W51H9cfp5eoNllzK9ZzPp4HaLFCO71vHLsyoJj6Bclp63RBNT4cb88rqFi4hCuGs
	NjPnwmkisc35dUCKS7y4hG4nfpkA8SI2ESXCKlZDMk0qe06dJhdfcq81EvnbB+7B
	eegF87BUYkatUWmcaOVaFO66VL6pCw2uh2toA8trhZc2cTXvpd/SQuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vst28q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 11:44:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464Ae7EU010189;
	Thu, 4 Jul 2024 11:44:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgq4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 11:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKXaP6YtWKh+s0k61GLVfkMCwVpTfcgCkyAjHJX7TJ93o9nD8qyioY2oF+xX2TiRw1Sbt+ql2WMgFtJFv0rivqfA0MnN14PVhDYABLL6IUarorHI0R73OEh2AxrD9grE0rzbBDARAxNK5VG/Z+/Li9Mx/99qFFAxK/GCm8tSyy3AJEigpa5W3K5qr7fqySGrziXM3PBcjMwsyzPrjG9SFxutzrChK/W35m82X5ZX10Bfdl/631m+1tW9Hb9AZQ7X633V9/70X4Lmio5CuDn2xuXtNkZB9+4tTxxK3rV1FhRQ8hr6KW0chToXZNkJ3kHtf7FgraVysRepIR+Oh4m1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN37Pr2nsH55qqsRczA35wTwpm1V5zB/0ycuDWTYhjE=;
 b=io81B14/KYtF/Mtg3krh/nMeAqSPOISiXS75Z0DTXE/3/U7+X08a2PsCAl6/MkQKWMZGAU6bXyXzAGgrZCWFAJUA3oCbCYiQzPvwEzTmTA/bilHAi+RnxuNa/CWhNgwSRkT9C1dUdrdMKht40EYUpBmlROv4ToCDupx0wbiAmXJfjDUOmAUBtbgzIJMe1TVPQ+n1iVNduzQsf9Ugj87nd0v/sG5EPJ4cvKCsF9Ne8uomB2LePe2PqKMxReUnq+GkIBnfAOPTP7jMMdqYPTa6N7Oe2ITbKZkVol4WhaTRI3kNqIb+nNt/SzHRheU91IECIk6Glg99u3f8Svd8yTmY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN37Pr2nsH55qqsRczA35wTwpm1V5zB/0ycuDWTYhjE=;
 b=UyReOFX1A84tUD0ITYiqVYUJWUcXXUmOnpqmMnX2Vd1eJM6oEyGMVdb7i7Rs6mReOKnKWo9T1MvcgPyNOQCl8NEKGdXUuw3PqbgTacNhp6+ajeaSX3Q/o5gAoYWR+6uWRnsXOBLfgQSYvNW2zLiN5Fd+lOdPVnzDRHgNYFw4HYc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 11:44:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 11:44:23 +0000
Date: Thu, 4 Jul 2024 12:44:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 7/7] tools: add skeleton code for userland testing of VMA
 logic
Message-ID: <419d72c9-1808-4b80-bb44-c99f58a262c3@lucifer.local>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
 <3303ff9b038710401f079f6eb3ee910876657082.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3303ff9b038710401f079f6eb3ee910876657082.1720006125.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: a05c538d-0ba2-4bde-3b8d-08dc9c1ea62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wLGUkhRjqmq4UmV6sA9MR1FHU3fjlLIO2WTRaVWdTH42NlwJITh61wX5WrAS?=
 =?us-ascii?Q?V+A0fomuCByWaXiPtIJyCXPQkEXSFWKzB8cTx48D55o/HQMX95p7+fgxLb4t?=
 =?us-ascii?Q?uYn8Q7JgmgQS50DRxAlP7tJHIh10M89Jj5MPQ8ZQrUXwW2ONZmQU7unExfSP?=
 =?us-ascii?Q?mfJCkJmfsRRzdBcZPNsPEZvYSutVrBw2KREkKWVEQhXILEPDFujbqnvzKIi8?=
 =?us-ascii?Q?FKq7GV7P52LgY3OeHt9fvNIQIA+ipEfo181EM0GREifrBzwaEC6IrET8aAwr?=
 =?us-ascii?Q?3fuCW3xmvZR7b0s/0I+BXd2PAxpF3OUQdCwK1JiBALi/0fZZPfnDRsXImdNj?=
 =?us-ascii?Q?kiXHkWgEw6nkLawsHYUeCleBpycrwxIm1uaDYKX9xwhu1QRFCEbdgFbthv1l?=
 =?us-ascii?Q?rRjxj2Jy0XxZ7kHAIUgUYEORuGZSMEmquMhEAMcV7P6v94oQ5wG5XdxU9CnY?=
 =?us-ascii?Q?rm/PWG8WBo7L6tvbzNB5aC+3OCxxUG4YaHrWVRVhXvoeZbfMoHxErgaDVze/?=
 =?us-ascii?Q?4Y98Be4NZrqNIbksgObS34HkiLbKuUKlQbUWKbMvH0E/JO/Gq263vKQTU/9m?=
 =?us-ascii?Q?zSxa+v49iA6LsN91YYv1/DjXwShEoZqPMfsMbpwL/khJ85YV5fm/+zaA9CS5?=
 =?us-ascii?Q?xhqF07eggiClTC4HC0KywQlvyLtf6/HOg772Qd+Fl0K7D7JeGKAuayr+2zYp?=
 =?us-ascii?Q?CMfpouCWwdCXoarzVfbOBnkXnZw0wdYwL3l/asn5oRdy7pTQVdQgT7xLNbht?=
 =?us-ascii?Q?GTiYahnnQv9EdumKwf0/ZR8UqUm6A6xsHkQGH5feD3GNqj7CwBTqBfltV6oi?=
 =?us-ascii?Q?wqFLDs7D+a0QGVvSKnOqI9iFrSmJgYzIOFeWT37ATDl5h7t1VoCKHZjkf0Tu?=
 =?us-ascii?Q?p1p7r9rQ9LNckCHEGl/U1f0YO9Etc9rTjYQZQXq/WxYAIVin1TP7ACvH0v0h?=
 =?us-ascii?Q?3kqKZzENoBsxhvB63qKoTcayD1zTzxevyW9SpLmrWCglhOnrxW/A0pPFcAj9?=
 =?us-ascii?Q?qTapyf2AYNGLOWy1xA662iBY8mpLq/Rx3+LwHQ6VI6GdxS9ark9rKEapz/BU?=
 =?us-ascii?Q?03hunSNp/mYZmnOT2666FgR4uGS6tImeZJDxbH0hsbqHFOGL5Kt5OXn90RSj?=
 =?us-ascii?Q?AjjPRjaON1nrQuDsxuWZju3AdHKhamobT0h51pQ+IInqTLDLfgkH1DEha/xL?=
 =?us-ascii?Q?jl2La5lhdbHOkW7OnFLdLReaO9scU3uzLPwl11QITtSmtN845JSf/JUeCzk4?=
 =?us-ascii?Q?6m0vBv62Ecl9REiYTN+3X3Ks9k1OFq5cWHMOi1SfPykuAjt8MT4bH/441zrF?=
 =?us-ascii?Q?Mc1lGADgiIBR8G7aRWe+a8vaRpcEbEg7POvHB3aKsIiy7w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pdEyZmx7f+tCdGWXjeul0akloUFhZT4TlA6PwqadI2UbGGZNzRxGRXnG/+5D?=
 =?us-ascii?Q?P795mzMJsIYEFlI+4Z/qkO/U4kl8h59H5NZlrgehE4mYNYMENzaYwsTjfyZz?=
 =?us-ascii?Q?jvxaknbsWBr3bXSuDIEuXcqwoen82dzMx+s93+sowq9XVMcqz0LmGVjHSuW0?=
 =?us-ascii?Q?Fykoyip9Tyz/mSz4d9WhZtJU2MIvmSyhwhKmQqnZopByiuz0TvjqVObCcxK0?=
 =?us-ascii?Q?SD5b2ghaiqr4vcrAhrasjeZx/USSZobCZW0x6NZS+XumMyEBE90nF0uZoA41?=
 =?us-ascii?Q?o5PN9yPVTeAPm8ot5OkT3UwwWxZGe/E00u+CFMTSbEVQ7iid2B2kxMb2MmGS?=
 =?us-ascii?Q?yvV9SL9Au6jEdalSP9VLf+zO6WQcKYNEnOb4hzLCcwivT3/m3Xz4HmHpV8T8?=
 =?us-ascii?Q?dV93zZfH/6hn23/SrbMBVmXqzjht5dbqubRst2cG3PEN3PPr151rNjHAK78y?=
 =?us-ascii?Q?3UCdcpztOJ7zKIzp4hSxjdmFIHfYrMRb88l+v4tf3+yN3CefwPB8pLsHhtI4?=
 =?us-ascii?Q?QghZNcfYW+tEQMOxoADeJit3Iou6Ha/hOnst198x1evIBdund+nTlB81zJpy?=
 =?us-ascii?Q?5rLTWfGbcKfFYnx3ULEq/AZwgYjyZ9stddML0fYDNO45LVk8D5za6Y7uN3+O?=
 =?us-ascii?Q?oLRSF3iC3i8TyZfGvT6NvOCJVn6Q3opV9Jp0cJIuOdROmxPRy2brHA3+my7U?=
 =?us-ascii?Q?JaGyjzpxwEJacAxTDwJmfOXDm+tNKoCn0efERwt1AD3TP827eXyV3/Gxgg5I?=
 =?us-ascii?Q?eHqFuFyYDZss3f1kn1fmseIpmRw67GXoCxbrSSWAvsLVXGe3wEE6KaoGlNrv?=
 =?us-ascii?Q?gYEdFySCJ30DpTSR96IJWNsxe8ZghM9801Ga7125KiACeiY1OIdI+i6IvmWo?=
 =?us-ascii?Q?LmpO0DAwK/rHw4lriLwzDDN4YU41FiYV9ZGNHqq40x5/2xkag8k+v+3FOSFW?=
 =?us-ascii?Q?Dd8QmCH1hdYsBr05WEHl2q6UOHeC5GFvuzObYIJ1Jyrlh6IleoZO6olVKA0V?=
 =?us-ascii?Q?dKhAKJS6hFYUpM8piFyA0v+zxO2s3EeH0UFnkGvCD7CxdhdvtCeA0tyK7qAR?=
 =?us-ascii?Q?ndrc1XMZBprR3z8W06yCgF9/FqTN1dnYG8nPuH22lxeGY2eLghHjmWwxA/nJ?=
 =?us-ascii?Q?wq5FNaccdPC/L9Ks27oI4kt7zKK+s90KVl722rqVtBtzU3DsM45EtEKZi77a?=
 =?us-ascii?Q?Wx6iFO83Cu75Ovvntd5zZC2kWQzqo1VVhWZjklJDImB+5y2XzGY+cCrNySJc?=
 =?us-ascii?Q?rNALznQYBza+J7hYNND/Fz+kqd88Upl1gnW2q7Om7vO+dtCLVBy/wzEHhcWr?=
 =?us-ascii?Q?DNvUzoc1luuFO4TRXCGHCjnsxdJuIvPklWBwBsVEqOjsw07ORKioyJxVoyKe?=
 =?us-ascii?Q?iAVbIPLI6vBN3bRYtG0g5t3LXm0pIfubtWSU7/+nXZfcEQd1hZoahr2EppjF?=
 =?us-ascii?Q?ZJgLkm7WIvWnSHa1obmof3xXokEyOsSIvxcO5p2FL5dXREecn4gwMnEjqEh6?=
 =?us-ascii?Q?+qmzPhdYzAOfaArT2mxpsGJsRZRB38siiVHT7QQLv19oj9/OW+fIxdrYJmfj?=
 =?us-ascii?Q?JwwjYBFDtpQg1U6utFmZ1am2xvS8E/OGOs/QtrSgHgTtuRwMDx43gqOoGsQv?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1RIpFTrHJp3HgvbTw9F29tZFkoBSxHfYk4BQ0p/gPLmpssV0YdFP/oZvp/HZ+b+ru11U4ovHbfj16khjj9zwqP4xNzX2xn1CD9jSa8YVjq+57JvhKF6+ZLQ+cIMypHliIL/DTZn3nwHO0hKi22pkzSAjljqyLFkvaHS6bdktVjz/eahysVrAH8nItSPApshixiHLLxC+8l3b/vxJ2vbaPlZBIWsB++vWZKakQ4xhe9V/W/H64a9lFUWA6ZRKhzbR/3aKGLlOsijOS2oay7VlOjdmq564VoGoiVnc8B8gH6hD9CZIF7t2Rs/344eoAybAIFym7c1qt/36MSmAoBPA2qWraFhfo8ZL99owUjweIlxayJ90W+657II4bvqofNZRbR1qPR0nCm6X5M1eNUlZsip0Ye9jDn1VsRdZ5U9XGaVKzNK/mmUDZAbD7iZxPZMRch7TT7v0f3ylGH2xnHo+d/e25+cNjNLqEciuXu97n8gzpAZz5KoFXdzs4DZTO48rmXNEFRRTf4YcxbquOcRauW9fyejQy91TzY6qI5qRAa9BBkAH3xTIuUClwfHV/gsm/cz6gXfLxYC6hSJizLVYfOIA+yBhFt9mO7E+mL0WrEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05c538d-0ba2-4bde-3b8d-08dc9c1ea62f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:44:23.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc6PjgVnf7NZXFnovBJQqQIn5n3pQjC/dNs6lqUq2ECfabbZq6rMlgV3clN1M5RTzsj1qhtooGTMkSV1ZnmzBcR9N1zBWsFg0F3AwL3Kz8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_08,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040082
X-Proofpoint-GUID: rlt0CQ71S9OBiDoMXFFLe2jg54P7lfJA
X-Proofpoint-ORIG-GUID: rlt0CQ71S9OBiDoMXFFLe2jg54P7lfJA

On second thoughts, I think it's best we fix the various small issues
SeongJae discovered, Andrew - could you apply the following fix-patch when
things seem ok to move into mm-unstable please?

I will pull into any respin going forward also, if they are required.

----8<----
From 0f7b9e6ed72773f22c0e344030337faca657ed6b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 4 Jul 2024 12:36:00 +0100
Subject: [PATCH] [PATCH] tools: review feedback on tools/testing/vma/

Appy various small fixups to tools/testing/vma/ as per SeongJae's review.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/atomic.h                 | 2 +-
 include/linux/mmzone.h                 | 3 +--
 tools/testing/vma/.gitignore           | 1 +
 tools/testing/vma/Makefile             | 2 +-
 tools/testing/vma/errors.txt           | 0
 tools/testing/vma/generated/autoconf.h | 2 --
 tools/testing/vma/linux/mmzone.h       | 2 +-
 tools/testing/vma/vma.c                | 2 +-
 8 files changed, 6 insertions(+), 8 deletions(-)
 delete mode 100644 tools/testing/vma/errors.txt
 delete mode 100644 tools/testing/vma/generated/autoconf.h

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index badfba2fd10f..8dd57c3a99e9 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -81,4 +81,4 @@
 #include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>

-#endif	/* _LINUX_ATOMIC_H */
+#endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 30a22e57fa50..41458892bc8a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1,5 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H

diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
index d915f7d7fb1a..b003258eba79 100644
--- a/tools/testing/vma/.gitignore
+++ b/tools/testing/vma/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 generated/bit-length.h
 generated/map-shift.h
+generated/autoconf.h
 idr.c
 radix-tree.c
 vma
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 70e728f2eee3..bfc905d222cf 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -13,4 +13,4 @@ vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)

 clean:
-	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
+	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h generated/autoconf.h
diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
deleted file mode 100644
index 92dc474c349b..000000000000
--- a/tools/testing/vma/generated/autoconf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#include "bit-length.h"
-#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
index e6a96c686610..33cd1517f7a3 100644
--- a/tools/testing/vma/linux/mmzone.h
+++ b/tools/testing/vma/linux/mmzone.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */

 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 1f32bc4d60c2..48e033c60d87 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -203,5 +203,5 @@ int main(void)
 	printf("%d tests run, %d passed, %d failed.\n",
 	       num_tests, num_tests - num_fail, num_fail);

-	return EXIT_SUCCESS;
+	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
--
2.45.2

