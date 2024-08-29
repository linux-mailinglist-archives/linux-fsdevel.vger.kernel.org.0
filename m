Return-Path: <linux-fsdevel+bounces-27920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D3964CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8ED1C231FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DA1B655A;
	Thu, 29 Aug 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGDCI33G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I+5T6yr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E214884C;
	Thu, 29 Aug 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951936; cv=fail; b=sSaKKbJz64zSDq72GwTBGKF4LiSYQiTaZ/7FhHt9sFoQd+l0aXwlPZX3l+p69o3FOx24TDmk80BJ5qjs54b1zB6y2QX83j1rboGULjKKZ4alSKUqpqd582hFf/nkplkc7Fyg7RRyXbS0c4mUvv0c6jvaNShBD3MorHKQJB2NIKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951936; c=relaxed/simple;
	bh=FaNw7JkYTio1CXTkNzP/xtimiyK+Qa0rgNmcy5zjC+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nacqv0LmTZyMpMFlY+xpGPXHha3uU5vqUY+wnNHPlhZEaYqPAisZpKVGPb9rfiHUpdbENKiqRLntFtfEW3o7kk6HB/7hxMFC+AX16Qw2Q9RnysGg/rFe81vV6SUDoIkciUUsTnLsCZE1Vd8NQuzUvTfdoy4rCH3e+CfzeV3ltyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGDCI33G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I+5T6yr5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDsZqI018957;
	Thu, 29 Aug 2024 17:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v60ySvNo7hf0YVX
	sc9Kzv2bP8XLIvDc2wGth52qVqjQ=; b=hGDCI33GpTdGHpgX/MlPe0EQ6+39w3+
	8nxPHKG3GGPFA28T4Oxrmd9iAj1rpHD0nS86EBcM2fKTrQaDwQmVFWEZg3k1hvtf
	zYLoaMNqHiHGut+5htIHm5ExedVWS1wI69LBusW5uMLwsvUffGbb/O25phqkr8wQ
	lTIQgBaLKngXIz4LIbPSyDE0Y27nX0yt6uX14N1/XWipqM/SXw/BoOa/oS1BryJv
	c//v0+nlR7lWM38+CmCmADa6OGc2v38Rc9doomwrfza35s+ieUjm5zR3EGBgDVtZ
	2Q1tBUnpvBlHYb5prwpg2jSICcs4mCeDCrP0sPrxzG7gH4Z1ZORjmBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugvtd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:18:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGxSpH036621;
	Thu, 29 Aug 2024 17:18:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jnhdah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snEWP7D1mnac0LQvym8+THPSbsurtb4d4uGy7bXdBeQrDN8o8cidxjt2fafWsnAE2GdQTztsu2kSQyLm+lhG4DrmGbrqKEOuBEcdWdawaFLALYMiaxEJLoixemRbOBxnliVyDUhRT6PALUcZQ2X6Bxgb3F+ZTlop/4q0cFliBQkcZO27SL8MhX19RoFN99sVyEg8g8TKSsLjkTlQ/W3FI0+KQ5TYUZ5P9AonV1ymD+ogHiKUe5DPJjTORMJ+ec+jrBolv6IsVcZowey009CndjLA5s2ZrSRqwljh1IWZiw8g11OOb75kNreYhMDCXEtaaHNgukagK7ViOmk6RWLRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v60ySvNo7hf0YVXsc9Kzv2bP8XLIvDc2wGth52qVqjQ=;
 b=ONlGB7n/+xoX49mSuvyCWBx+I8evJ2QuXYYttBW/G6yZ/Qc1g7DPTW6BDgb/a2buRlCTn0f0FY7f9opIcyfaFvxEmhMU3O6YBVnHmiGfjvjeyhcTkMNf3ZAa+sHBPiQv434gsZAaTXwhezHZ23wRXol/kYPl4oHQ/6TaB/otMsLW7e/+97wpbKyqT1/koVH8gEzdAWHO9zVILM21g8j66IMfYhsjMVkuZanHSMCAvlhn9f6PFnADNeBVqhwkxjJG8UA7pp+6I8+HCxAVSY6rMsz5AU9WeHXWdJc0xBwBU71tnfqnWjuuoAB5EA1qNYVmvlksxASc+OJALiP5PsDpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v60ySvNo7hf0YVXsc9Kzv2bP8XLIvDc2wGth52qVqjQ=;
 b=I+5T6yr5zAbFpwVIi/8ywLfWqboShW4qFGpI2G/fTVOX5m5AXCXrtzbb5zaprrIMLC8XlbasnC1HhrX3gZM99oo+a4kEe04qHcPSAJtqPGSYFVZtT9KXORgeGW7AWunG5RwBXdBo/e8AMO1Gez1VGqr7EoO5N+zYG54RVGMLg3c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 17:18:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 17:18:26 +0000
Date: Thu, 29 Aug 2024 13:18:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 16/25] nfsd: add localio support
Message-ID: <ZtCtXhUmxsWaCC9u@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-17-snitzer@kernel.org>
 <30842ebcf33e97f2f9af8eb57b2eeaec05e7dea6.camel@kernel.org>
 <ZtCo6NrSQ6KR-MZf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCo6NrSQ6KR-MZf@kernel.org>
X-ClientProxiedBy: CH2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:610:53::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cfe610-b02b-4d64-71ae-08dcc84e97d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ld104f4OwhNUrS4hH3Ypkt+sL/b830Uqz5/Pn+x0zJz+f9qyQ+4aZbsdMrWn?=
 =?us-ascii?Q?aCD3TqQFGSvKKA/rBpnyrmHDwSGooqM//jQNI+pWlD/SDqttgzHeKLMQ76ab?=
 =?us-ascii?Q?khRhFXf2p3t7+lajOstEN/hTfImBeAeUlhpJrDzsT0GJp3zYFC2rZCslv+j5?=
 =?us-ascii?Q?FB0S5XlNpTymns0bsZer4WiD+8XIXw1ArEC24siqTzRIhqrRXTPl+PTslT97?=
 =?us-ascii?Q?6S1V1B32MKlUlZnep9L9bFPmVwMEEVm88QRpHF4OGbgcemN87B23iTDKXu8e?=
 =?us-ascii?Q?sPuiTBtF43yJu48F2TYeyzPdhNcmUvK7J6VfuyPxQ2joKk8hr0xlhEISAzhB?=
 =?us-ascii?Q?kpxiTfkBxKuwSkW6zWKHvLPz1oBzx1ZKpZCBZR4rshQr7Md8OkGaZyCz+/XK?=
 =?us-ascii?Q?boS2vp2r1CWvauA8PlO46UVH3T7ybfP8zygCaP8IDG1kYCKzsn2YJtqRwX0J?=
 =?us-ascii?Q?FnB+uL4fDIhO+dADK5QwRdzAZTxrZebddN4gR43Bsg7urwJ05ArCH8SgHAXv?=
 =?us-ascii?Q?HF5wMV3acrB4jZ0ny9IaA/YE4m5p1Pq36NrYiY7HWOdIzWOWz+v+S4m+dl/5?=
 =?us-ascii?Q?7daLusB+XL0zYApKB2u4lxu1QkkdTCHK7aYV6kCo7YaXOZgWxkYARxedDWas?=
 =?us-ascii?Q?FkCHYbf6QmsSUZDkOI9ceXpV+E1INkEtwSnqfu/9AOrS4q62At4j29QJb0H+?=
 =?us-ascii?Q?jHv1RZJfo8HUpW66y60fVoz7IMtIGDxaopSuOT2YO55wXXqOXaFR3lnTxyo2?=
 =?us-ascii?Q?zdHlvD44xbTSKLeh2nMQVypL51FtTCBIt129/GmscL3VlnZkKJ9rcdIRWfc+?=
 =?us-ascii?Q?tTKXNbueMtMQO75JX87qefJxfTEwhGWIQhlzszUBaDrfJVTEYQZiAzgF8zJ/?=
 =?us-ascii?Q?djXhLj91nsJgadql4mTRSXOrj+BQ3EoMWhCGsKCmNjrJpfQBCCS4+IWNFn63?=
 =?us-ascii?Q?HazcfH+snhyj6EXkfFOZR0Jp+rGRren30E0fOKiGjJkFfJyugt45ZdW1tJRO?=
 =?us-ascii?Q?0jO/iS0TOWlzMFBGxkhbGPe+28k/EN7DhNT9vKdLxKu/kXkPr4Ia4htRPEv8?=
 =?us-ascii?Q?70u+AZGt93VzLmNXcVl5iZqLW9mXN4QpaqZtrZJfz9QZIdBcz9nOXAMtP+G5?=
 =?us-ascii?Q?/tcndezzip5NCRlQd36nm+e9uO/no7qigarKucTpjclNVVFDcIGxs1o9xWsx?=
 =?us-ascii?Q?xzUG41OSfYqUC9qkIrWxdeVAzBla7C28qMDdONwc3LqcOOImA2md7qBLbAts?=
 =?us-ascii?Q?p1MoJ2h1AYvIMFyFZiVJkYGt5DyfBI6SdE6Y/cOxsD3D+iivmp0qd+7HX3C7?=
 =?us-ascii?Q?ZUWwyLaCrvELw0ZgVbqwVH5xq0Luoe1cpix571m1OTAgDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qQxlHC0KPdC6eGj7bX93KmuvvCoyPxQ5d8EzM2ANe+9PBsh5DrUzImYMz+M?=
 =?us-ascii?Q?YW6lLoJPemp7TpgcWiohOAhbaxYzRFXJOAk1nLbP/8ZDQC1m+XVMjnApvY1d?=
 =?us-ascii?Q?Xb8SkeTUiIVUiU5xeMa1+JxCH1UBOfYQCSa/bBV23nXTCL2AXSjaCUXgI/Iv?=
 =?us-ascii?Q?/jbwCNkxETRsLoBQVPmkzy/m2N1xSY8CBhI+2OKQVu93HqRX52Kcw7FapCNu?=
 =?us-ascii?Q?H+c5FgfdVkZ05R1wGXJrssBvUeVPSKsBgFQxh8Eyvb6XhdDvtt+8sBxCjRlk?=
 =?us-ascii?Q?E8fFJPkY00xeHlzSucfSH7eoKlsytGLWdW6ExK1I4FJuW0/16mEWAdcQD0eb?=
 =?us-ascii?Q?usTzaRE68NTkQaKSFEwtOI98OQ5OtQlvor4/Dgo9P3zYNPyC1SaMro/xcVDF?=
 =?us-ascii?Q?wAsQ75BISruj5kMUVBzXfpg4Uy8Qkwc5ClS/tl6+Lje3UceYHLqe1kwG/HAO?=
 =?us-ascii?Q?MtQeBKW3phpNInoTL7aIN/ui6OCMkm7ZVpBvrZzhG6BZseDY2nIkGSgewTpF?=
 =?us-ascii?Q?X2OOwXWUKmXMAFjwiF0YXXwYIjVRgX2b2k5CK0fQe9RoZfpDAinCj1zmiZri?=
 =?us-ascii?Q?qazIP659d45bqPJ3uHPeQ8PDCMEMu3XcoJkG/Y3bC0P9NRLM6Jd2+h0vVrqc?=
 =?us-ascii?Q?WOJJ6a8AeEBO3lWeu10sKFXIs6i8aGYJ2C7IKlileyxlUDH7cJlITbAWzKkl?=
 =?us-ascii?Q?qRjJGHNV5KrGUvoWeZOVf6jnUlG4h2IIk34EJYg+ta90CIxHCVDdaKxPrdMy?=
 =?us-ascii?Q?M9bkgms5JxkAwjnlIANsbQ2AIN0mbYDiZfuHISnHg6TtUTSU6gpecgdak8Mc?=
 =?us-ascii?Q?OiwJDfZwmPDGn4goGSOokjnRDCyUbwaijKk/NhIUWCZ6WPoVjSi/S5K1hRXV?=
 =?us-ascii?Q?yKw5hY+guTAJUt4fp0VjrrChgCvYaSVMrto+61TYejvvPUKPRedl/vbBETXK?=
 =?us-ascii?Q?5g1jqouYe9XDXTd8I4DqZ+YOQ+DOeCHbgfXmG53jY8WH1XXO/fI/VUC5gO3Z?=
 =?us-ascii?Q?riFZmUNDtM0VivXV0foqF+CsJU246WUlmlz8E2SaC7Nf+RtnIvGIVmuf7EdS?=
 =?us-ascii?Q?Sf4qgZU2zF8/LvIzEEjrc+XxDmX0PkiBUOWvAk27ksmQM633pg98X3kzRm7a?=
 =?us-ascii?Q?E9TbMHanpJ3zLDq5q324PB6xCDwMwOjFLAyY8VZ/aIxWzsT1oHidN8ZXpBOV?=
 =?us-ascii?Q?hqNcrBnRNMCxx4bydmbBTajZ5cYjH8e45AkxgYsFjrMinv71EgnRjOl0dFSy?=
 =?us-ascii?Q?vZ5kYGQncN2JrNzlf2Pg6tuGjNiARCiybH3apykl84slXBv83avgih6k6n6i?=
 =?us-ascii?Q?nZU+PrsI1Bnep3R6jEVAwgxlDHCjyd+a2H74puIOHaIgP2OfYgVMgnrM2YrS?=
 =?us-ascii?Q?DBt96sH7Ux33E5Qttk+mIgTcTy9PsWIuZKhgEgg3VjCxSfQIG/NoLKFBXmCa?=
 =?us-ascii?Q?A/mnbs53CG5Ipchp3CWUHfKv8+9Qq1aVyj2UkvxmTHcQQ2XK+IRPDZxsPQyJ?=
 =?us-ascii?Q?B+lI7S3m/meFHoUZiLDvRXTxdu5HEQ5MtIr7+2R6nsxJqzoQMoBeGbKEj45L?=
 =?us-ascii?Q?MtXT6+5tDXwWd9OpBeiqsRSJMpVTMZj2e6q6fPzgDHGIvlUq3JodPI0amJ8n?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PV4R5CSRNtJgCia5fi52fL4X3YkE5z+mB/Nkyn8lkekBn2SzxTaG+jko8Xighy5IwpdoUbo+JJLpnxBstVunOyt5qwRB6ay0QVFAsjT5PZdQQ5CMb5Bcsy/hm0VybusKyrcgr9UOul1J6LBOBRxSFO9wfKrELDC8WH5jRMIwpof5YHb1+nc/KATgVtYAKKI49qzEcqnbJGadH/+zrjG6XSxHMzVkTTunZr+qv9FPQOjRsCrllDTKbYdV4RgbX7bABc+bGFtCRfMrJGG4UR2lIQRN6xsHhjrxJb1+VmSj8TFdZUo1LOrqG//FfInFdfgD2h+do5dZBc6JGdqfYsv4Nyc6nK7k6on3pIY3C0t+EpvTQ9M8vR5pac9/HshrdgNwjH+UVQA5JnUfsUr3Xxb0aE8KZWvOfMUooFLQZK3N1S8gTLqRRRDuohP6mxnJDMa6LEIrtdl1UxICblEHe+byiuHFnO2K0PMNiHbOPs6g48EGsH10Jo25xQ8Fz/dWG8EMN16IOFseLbGRfmID2nNfzRlCDb6q3CAapi0RmDO0NTvOlzog2lMf5M0x4sGRTzTawhVyUKoeONbk40k0SqTcJUYemoQu6Ymf/KDcRhPlQdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cfe610-b02b-4d64-71ae-08dcc84e97d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 17:18:26.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajW4YsBqnM1BmkjIsSuB3CNcIugqN8+F/ceBjdwA6SrRhCkYZvrjgwhruEQnp2Doc++ecbDv+r4Dox9i7dqlYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290123
X-Proofpoint-GUID: GWLjrFXopHLWGBvjjaWIExm1qPegM8WE
X-Proofpoint-ORIG-GUID: GWLjrFXopHLWGBvjjaWIExm1qPegM8WE

On Thu, Aug 29, 2024 at 12:59:20PM -0400, Mike Snitzer wrote:
> On Thu, Aug 29, 2024 at 12:49:23PM -0400, Jeff Layton wrote:
> > On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > > From: Weston Andros Adamson <dros@primarydata.com>
> > > 
> > > Add server support for bypassing NFS for localhost reads, writes, and
> > > commits. This is only useful when both the client and server are
> > > running on the same host.
> > > 
> > > If nfsd_open_local_fh() fails then the NFS client will both retry and
> > > fallback to normal network-based read, write and commit operations if
> > > localio is no longer supported.
> > > 
> > > Care is taken to ensure the same NFS security mechanisms are used
> > > (authentication, etc) regardless of whether localio or regular NFS
> > > access is used.  The auth_domain established as part of the traditional
> > > NFS client access to the NFS server is also used for localio.  Store
> > > auth_domain for localio in nfsd_uuid_t and transfer it to the client
> > > if it is local to the server.
> > > 
> > > Relative to containers, localio gives the client access to the network
> > > namespace the server has.  This is required to allow the client to
> > > access the server's per-namespace nfsd_net struct.
> > > 
> > > CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> > > A later commit will add CONFIG_NFS_LOCALIO to allow the client
> > > enablement.
> > 
> > Do we need separate CONFIG options? Surely if you have one, you'll
> > always want the other.
> 
> We used to have 4 (2 for each)... yeah I hear you.  Its fiddley but I
> can look at making it a single one with more feeling.  Same as the
> nfs_to opes work I just commited to: worst case we keep what we have
> with the 2 CONFIG options, but 1 option _should_ be doable.

I also had Jeff's question but it didn't boil up out of my
subconsciousness into my typing fingers. Seems like having a single
Kconfig option would make this slightly easier for downstream
consumers (ie, Linux distros).


-- 
Chuck Lever

