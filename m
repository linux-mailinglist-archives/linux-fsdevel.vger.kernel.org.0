Return-Path: <linux-fsdevel+bounces-37653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208999F54D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627EA18938E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B01F8EF0;
	Tue, 17 Dec 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LTuvMQ/1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vsjgAVab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD61527B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457298; cv=fail; b=bgqBV3HHK9cRD+18963BbrVTWuOAbtiWF0zirxdZ4MerOTOrIspSuHBKN2KTZ980lkigRMAJpGPOo+hSA/Zc5sTYwhWW4WLjodTTpLKNOaJbrMUPSGTWFzAGoMf93WnRPf1IArwgj6QDrnb63tvt/hKyCAUPafEAebIRzWmMYgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457298; c=relaxed/simple;
	bh=xx/CoEBSDB9C63Hw0E/Mq/Y4rSFsKdM+5vcKOVumH/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FAXnROrtXIB1EynUkiNilez1tutzaq5VROFZJdjtncJ+2EE5S3q55lxXL3lUe+qktoIyrD/jJyyBNE7fQtjk1E4YmQdYWf/+xvIN9RApXL0ir3/POKnz4QAu2US3/+EGOzzVI/SV+xMomecl+opglgyELv0WzOfxFYgC1l24whM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LTuvMQ/1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vsjgAVab; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHCuQka012368;
	Tue, 17 Dec 2024 17:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v4e07Y177KzHEivLVe
	nagJafOGqUyn4/qSaKpy8yBjA=; b=LTuvMQ/1bJOScG9tvh9PTg2nvAjMDHsHQS
	OpmShqnC28mY4kzSYcw5nnKam3i7VQNItrcZiFzEFzd9b/r7Xd0oUJ3OAzarwC/h
	4SdtDLDUtbdGtR94uWUq0fnvdTK6bxYtDauQFSPLI6/nvvBDvrZ5RyAvaNvDg7Jj
	P7KJqa/wH4rtHBY6rMdz0vwJjacRrdPSK2q9tPUKp9i6ttjYddLkkYpZ2GAbGSUo
	8O8dfvF0+h/RJoPF8W8gCC5TAqVpRbFoHS98tkF3WftW/FvvtfcwXT7ieJB4DTNt
	OWmtknQ1lb5uXPNqJp+5nFnxJJBMP3p9mZT9bTeQ4W7FqLlKujrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec6md5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 17:41:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGWo50000814;
	Tue, 17 Dec 2024 17:41:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8xnnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 17:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPnDBkDZ7d3SySr3HrmszjtAxt1EqTDPMDxZ9mcZ5h+WR5RVxP+KoPgzyGov7VxiB+QK4KmUaKy3vvHJ/eTE+sU9t1Gid1ZBLjxm/HJrmTZmjU9L8lSfbYADfnf9+43g1ZwMD9gFaqL5djUzw485ymkf04hCx11qK8CnaNAv11rjqEPPsxRkM3K+AbzVJVPPwjJtkFFibnOaXPm6P1v0quTHROAvnTOXZMlEnOdNihuSBv5jyq2mTPU86kCihgHTK+jyqPRQnc4Xaoh63SDl/fphJDk7LUkIqhXVrVUMwaryxr4vDgkig3q8ZLjzCeQ287ImeH5jMZkpGHXMlZxKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4e07Y177KzHEivLVenagJafOGqUyn4/qSaKpy8yBjA=;
 b=nc34hEsab77FjmL0ZrcRUnZ5k9kP81Ly06gPC6xdTWrH/rp9s4myeHyFmFDTfrOO2T0iiahOfi3ha1lpwATqF7FF18s+1Z6ApOx/Znu8kLxafTbAB6UmyM/cpYUMg1ChgJ+UcMyQxPPmPiMus5QuHI54Nn3p2rn3TpRU2t20GPm2cEfn2psRXpQUg4eiPqBIFs68y9I8Ml5FfZsx2YVEdWWZvAPFlfctWidY3deDHzCyMhInK5jxW2QWjy4LgVikWod0kd9FfxaRko0J10DZk7j0CKZCRqaVuYZSS/cao5FGNqOD03Eze6Oox7Yz1Q2xefQ1dFaTSKOeSVbvQUtYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4e07Y177KzHEivLVenagJafOGqUyn4/qSaKpy8yBjA=;
 b=vsjgAVabNbkWkSrUgHmyos1aTBrnU4boo1Fodo1s43FlR97TQi16CLGPmED7VFAXwAqsb/JJNMSL6huvJ/I1LGoGgeezUMqfxIAvIu1b0sKHfTrCrA0HYig4FC5bMUaksK8s+ukU35MTD+oK7ye0dOZL8IlXsMQ+5ug07sXo7DY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 17:41:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 17:41:04 +0000
Date: Tue, 17 Dec 2024 12:41:02 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <dinu7cc4d4weqxqitax7ag4s4nbum57d6rujojbpkei5d2swqc@kqsp5niycw7i>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
 <7tzjnz4fhpegb6y4fzjt2mgjlbrvuibkvkh3e4qd32l43zeh2q@43eedsimunw3>
 <20241214-galaxie-angetan-2d31098b66f7@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214-galaxie-angetan-2d31098b66f7@brauner>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: fa933782-9d0d-4f44-3bdc-08dd1ec1fb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?79eRmySEYwR8YM0OWX74v8wXEG3Nse3isqs+hVPyxtZdb2TgLE2+6jVaaD2l?=
 =?us-ascii?Q?VgOoZSrxhXTxhVcDVYFBWz69AixDZNqf1xoc2BW0cioyWvYIb1k7v+l7rp1Y?=
 =?us-ascii?Q?dLFV72EpLjKrWRfiz+bKGT6pX1uw0HyRVuZiSsykAHftD39T8lGotHHKV6+P?=
 =?us-ascii?Q?6711aHB8mj8Y/KFmLr1umQ57SSTow4NhFvJQhrPf8XPdiVySGHV12myaxjuO?=
 =?us-ascii?Q?dVQzBPdAqLU85N1YIJhUtinmIe/Mah5GhjNL8DFSG4tYc24sO+TYXuduuTzi?=
 =?us-ascii?Q?80ROrByBdM1DMwsw6kZhZkB8p1sra3G7omc/dZVhDmutV+izGJbEAV2yOPF6?=
 =?us-ascii?Q?N5AhUwpYvVJ+vsV+iAqKf1RssGw3OOJwwdt1N5KKy6eUhoc51+vBrJdJCyt/?=
 =?us-ascii?Q?ltFv+ZUIgnvD5iwImX1J8jn1+Khp7ZTNg8XG2LIQHG55eTqolE7OVtijPHCd?=
 =?us-ascii?Q?b2eaT9K0tc89Rb2be+isv6GdAoWUlUzSt97CkVV1e9oOPU9eBSre4WGV0cRS?=
 =?us-ascii?Q?IzY+MBwz37zvV7bzFcx+x2KVBlhK/LQWD+yGc9bUuWgZBTF/N25J6tMKTy0X?=
 =?us-ascii?Q?9wBtBO5OAhBLRO5yy/yuwU16qy7wIDUE31pe9Sqb1MnIyKr7Ckq4RQUuiX+v?=
 =?us-ascii?Q?1yup0/wFq+PwKnRtXVQWI3HLxx3LQ2BMOkXKqnYZsAJtF+UjAYqDz2kVrYGR?=
 =?us-ascii?Q?wcLzZsne+OOJ+7GnPC0coWhZBNfYacJwM9umXTAGkCJT/LTxmp2IDhSS/6aA?=
 =?us-ascii?Q?bciXJuCuZIz7evyCGCaBpG632MYp4AwcwIKxPLTwciKToDOEjRKp8/utmcvj?=
 =?us-ascii?Q?E2H+LJBmgsYkZq9OfbIJN1nnRZiwoDb6CHf3eOvBgIHAmkhlu22YibrQ1xjN?=
 =?us-ascii?Q?miBNrdp1xwpdslVf3xaiYnm8R7o3v5ok4XRVK3ULV5jkKSSigx545EOm5RpP?=
 =?us-ascii?Q?/nysaYwvIQUYCyQY7KVhF/zEKjljzuS9AEETU3Q6fsVDQIVOnWBk+tgGhe7G?=
 =?us-ascii?Q?Wm+bs57C23+fPt1QkLJGwoGiUYHXB4siSU4reQT5LZvz4Tro8EAbh5INV8Jr?=
 =?us-ascii?Q?Ws46NzkanHorA1btYtC9ZgxooM7Y/kLRkwkvEQ3qKQIGgfEZCI4il2jo0Tq4?=
 =?us-ascii?Q?W5R+cqkcWUr42rxFmmu8LKZUA7EZLOjIPmMpOJ3zgYz+LQ4sCDqwr6EUQMBJ?=
 =?us-ascii?Q?fOLEUkEyUsqeL6eqCWXuP9r2MZvy1Ez/LwP6MMIVCYvOqXIN9GDPB4AHoBs/?=
 =?us-ascii?Q?mGCIVA6SWZU1MXsJ9wO4JrRPO+e4JBEbKDkYbjoxeatU7YF01DEFqwiCscmp?=
 =?us-ascii?Q?H0ennOyuu51Ly3ZhOgiEWUd3KAHwfMGzwJWzdIMBQJpLyZg0PNBI6n+akjog?=
 =?us-ascii?Q?mkBejRo6dHrIfTxvNuGZyB4HGZ0O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7E/DKr2h3hPztcA5FDJ31fVm1hl+1UuL7+7zsin+QyrqRX1H8yyOoXTJCq4?=
 =?us-ascii?Q?pasGqY7D+LdkNlRriAslAAUZi3HYRxuQFwcq3DD0CPy2NQ+vr81nqT4EyNg2?=
 =?us-ascii?Q?Mv51uqgcliLcaaC6AAOARU69LHNnNnVh+tvtBY1Xpq2mu2k+Jr/xZTUsp0eI?=
 =?us-ascii?Q?/odoqV+LuPGvRHPV3yggMmv2lnB89i1cgks+JfEq/Px/uu0h8DKSwKymy1l0?=
 =?us-ascii?Q?x3NbXHW2GmapmjxNiTY/i8zr/um+nqv/vyFzFII71dxsC4AcnrMXcq+d6/CN?=
 =?us-ascii?Q?N9a/T6rjeta0i64dpUoW+/MhFP0LwOrG47kRiXd9VdVMVnj+AKc3oxHYGvyG?=
 =?us-ascii?Q?sMf+VY17k13Xoz3+yQwbXa48B56vsHZBmf5fOBcp+oypBIXs3JZm1A6aqRAC?=
 =?us-ascii?Q?48lVXGo1oH3VBWkzXbwzokVsX2MXRCVqF+JsPohBQhebHtc2x4tYy8+YV9hl?=
 =?us-ascii?Q?GVv4X2R3CGlSFQHMuG+FenIW2nPP4hBSuzqKl4RXygtdyf6Lw+xCSZPM2yAI?=
 =?us-ascii?Q?EtVjHhgkiWP32NJLx/ab+0YMwZClnP8GxOFFzcO3PzVYeNnVNO84g3AfQQaU?=
 =?us-ascii?Q?Yt24JKvVe/cVD6zpcrA/Gs2IdrZoFrdnEsdM/WXAsJzrO+WTnmZKCsYlnqBD?=
 =?us-ascii?Q?fvZiu3zKyIgdINxa21oVhCn6e4woV6ABDzHCi8VueIeCUbUZoY4bp/SCXO19?=
 =?us-ascii?Q?0D2yUEtrLfXlFfI6Du07GVqSKeLT99qnXp2GRILLt2xAtw+tME4TYx0oHSSc?=
 =?us-ascii?Q?cITYUDcUCOPpmlmB1A2Cg5i9ANX8hvLNYoSamsOTOEHjSgwn421EAJFR3KG7?=
 =?us-ascii?Q?FBlh29Xxs14Wye15nPWorreJs15dHFfbkP55/dBa2v4ppec5k8NiNtgg5Ujl?=
 =?us-ascii?Q?5u3WuJDFYI+gu8zrf7qOLKtURbFWx5aKFiUDb0QaHCowczWp6XEtImWgst9j?=
 =?us-ascii?Q?KWPyn3wfL+Lo1fxXRkRM55U9u8/VPVkKrLN+XW2oAOq9nfCtyZNWMtVIzeRG?=
 =?us-ascii?Q?pYxuiOA9LtCgJeHKcLll8T/w/HqWK5QZVQFeu1NXKmiP3wwpelVGI/NV6S+o?=
 =?us-ascii?Q?yTcJrwzMygNmAypMVo0rNZRXx0YtoSt1pQ0evcNl3G3gIZQPJDyXnd4YACi4?=
 =?us-ascii?Q?Hz6OhZcSBEICeo5cAy5BOanwV56lgAQPZIsuth08kGXvWTJFJdiYl+5wtUkB?=
 =?us-ascii?Q?AUkP/CsHsw2G976OnNmHYreuWzf3FxdTsLWmvO2OFf4pY8UQ4B2Ho0T3LssH?=
 =?us-ascii?Q?Y7Mn6uGNlPcuApZlrHAzuLPvPTj4GHXzcCPOThhRocINsaog0LBJqNEktFoy?=
 =?us-ascii?Q?MP95KshLSBxkkq6F1rOQKtsz4dhZQsx+R3WUFdottDKDZt5ABUKcxRHVs4Mx?=
 =?us-ascii?Q?Lm3OSdqKBrbrd6hZbAq7/ZuHXRc22WGPy87En9E1vWT27ILcvoV4tOkdGJh6?=
 =?us-ascii?Q?NlrOYvvfKPeeQ2cb6MQrqGO7FfnLGK6SB/TmT9lntaQ4mD3gAFRdeGQZoP0Y?=
 =?us-ascii?Q?5DrynfK1TqiE2Dm8whsAU4K0k1n0aBzb52uucQpcE3iTbZgeRdlw7/E6b+r5?=
 =?us-ascii?Q?kjEOnOCr7cgHq2tuUNThu7Ise7V47mkIqqHDbrUV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nnYiJKXCX5GadisaKXAj6VEFkZoTXJYBi9HB2jnqz33rXg3gPcWlRyVKuY3nph5F2SlnuLFc8d/6gVlytrS6wSiFP3mNUushFnGh1k1awd+7u3D44Toquj+AEpNzTglIRROUz2LkeKrBAJMikfvf391NN/Io5OAGI0eGUNwMOcDjx1k386nyeclDCXMkZFR0F2tgLF+736be3PqAbQEqsN5pQzcYPtte4griv2IEicmo/W05Ju0zHnCUasu8V0Mvi1tWQvH9/yt4ou6Ibb7JNJfhVGyfDODSIBQr6BKU02GiS5E9CZkBjyJYqzfxZpB6T8T1sycKZd0zQT42b6y6Do2WlyTarHgCjX5o7JlabpvUzi8LYSxcVFJUXt1id03e4OcXfA2riVW31RPYY4rbh4DzElA/D8sBn+238DU9Zj4YUsKeAHbeAG8yatL4fGqfsUiAzc0kmXkxiFrxx5W8pLfxXuZ3iz37QvXvECL2ederkVm4XeMaof42pnB+JS418NqRZhW9xAzEbIjTspnbiwSvXqi8xoVPrREmRlQVryrH3mJeRQ/k2hVwcefIB1FipgH7rKoYmZq2APeMd7ZZmaMEFqjYI3bDfTnSWW58rG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa933782-9d0d-4f44-3bdc-08dd1ec1fb11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 17:41:04.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/FxoA33AzTEx2XFVsC9tshlEiqdFdrT17K3Y+HE9FNYZa8eFvEfyykLjw6jFLuW+7QYRJ9DQ6UG/cTa341rRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_10,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170136
X-Proofpoint-GUID: QRqr9_m53D2zn_FfwE-0ZEXjQiBcLsLH
X-Proofpoint-ORIG-GUID: QRqr9_m53D2zn_FfwE-0ZEXjQiBcLsLH

* Christian Brauner <brauner@kernel.org> [241214 06:48]:
> On Fri, Dec 13, 2024 at 04:04:40PM -0500, Liam R. Howlett wrote:
> > * Christian Brauner <brauner@kernel.org> [241213 15:11]:
> > > On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > > > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > > > I've replaced the macro with always inline functions that select the
> > > > > > > lock based on the flag:
> > > > > > > 
> > > > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > > > {
> > > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > > > >         else
> > > > > > >                 spin_lock(&mt->ma_lock);
> > > > > > > }
> > > > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > > > {
> > > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > > > >         else
> > > > > > >                 spin_unlock(&mt->ma_lock);
> > > > > > > }
> > > > > > > 
> > > > > > > Does that work for you?
> > > > > > 
> > > > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > > > close as possible.
> > > > > > 
> > > > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > > > as appropriate.
> > > > > 
> > > > > Say I need:
> > > > > 
> > > > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > > > mas_erase(...);
> > > > > -> mas_nomem()
> > > > >    -> mtree_unlock() // uses spin_unlock();
> > > > >       // allocate
> > > > >    -> mtree_lock() // uses spin_lock();
> > > > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > > > 
> > > > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > > > retake locks and they need to match the locks of the outer context.
> > > > > 
> > > > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > > > take, no? Any idea how you would like me to do this in case I'm not
> > > > > wrong?
> > > > 
> > > > My first inclination has been to do it via MA_STATE() and the mas_flag
> > > > value but I'm open to any other ideas.
> > > 
> > > Braino on my part as free_pid() can be called with write_lock_irq() held.
> > 
> > Instead of checking the flag inside mas_lock()/mas_unlock(), the flag is
> > checked in mas_nomem(), and the correct mas_lock_irq() pair would be
> > called there.  External callers would use the mas_lock_irq() pair
> > directly instead of checking the flag.
> 
> I'm probably being dense but say I have two different locations with two
> different locking requirements - as is the case with alloc_pid() and
> free_pid(). alloc_pid() just uses spin_lock_irq() and spin_unlock_irq()
> but free_pid() requires spin_lock_irqsave() and
> spin_unlock_irqrestore(). If the whole mtree is marked with a flag that
> tells the mtree_lock() to use spin_lock_irq() then it will use that also
> in free_pid() where it should use spin_lock_irqsave().
> 
> So if I'm not completely off-track then we'd need a way to tell the
> mtree to use different locks for different callsites. Or at least
> override the locking requirements for specific calls by e.g., allowing a
> flag to be specified in the MA_STATE() struct that's checke by e.g.,
> mas_nomem().

The xarray seems to not support different lock types like this.

It seems to support IRQ, BH, and just the spinlock.

xa_lock_irqsave() exists and is used.  I think it enables/disables
without restoring then restores at the end.  Either that, or there
aren't writes during the irqsave/irqrestore locking sections that needs
to allocate..

You could preallocate for the free_pid() side and handle it there?

ie:

retry:
mas_set(mas, pid);
mas_lock_irqsave(mas, saved);
if (mas_preallocate(mas, NULL, gfp)) {
    mas_unlock_irqrestore(mas, saved);
    /* something about reclaim */
    goto retry;
}
mas_erase(mas); /* preallocated, nomem won't happen */
mas_unlock_irqrestores(mas, saved);



> 
> > To keep the API as close as possible, we'd keep the mas_lock() the same
> > and add the mas_lock_irq() as well as mas_lock_type(mas, lock_type).
> > __xas_nomem() uses the (static) xas_lock_type() to lock/unlock for
> > internal translations.
> > 
> > Thanks,
> > Liam

