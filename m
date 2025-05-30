Return-Path: <linux-fsdevel+bounces-50157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DCEAC8A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623C217CC04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AB21B9CE;
	Fri, 30 May 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBIc9dNc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmUaVODS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6551465B4;
	Fri, 30 May 2025 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594929; cv=fail; b=u1z1s7NCiE1zyOUsdOowl97Zlw4Kq2Xr2Qn9YTtXtv40wQmVRV+iMCTgQho8Z6QurOcWZOUvuQoRB5QIJqlJ8nNicJTvG9eu4jlnUkkmsMzPBRj5lKYUb8R11gKBLL9fsNt59bq1yhIYxQ7dwpbkT7IBxBx+0phmnlxcgyoos00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594929; c=relaxed/simple;
	bh=CcTHdJzngZudm+8G+EcSor134pCxSA0b5jqeQ6VcOuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IW9s55aiEi3y+AUhjLXIURX8rR1wNJ0v5cRk+k5O0sUN5DWJcVdWZZzxALWj9gB42nrU2woMFim7s1Ho4c7QWpiKZHqFsG4rzBABAt2/kpTW7E0LYHjGFuSeoMqOhhWnetuEpoZk9DvF/WkcxlYsUdF1YXm+jnPtq01WCgyf46A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBIc9dNc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmUaVODS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6twgY012746;
	Fri, 30 May 2025 08:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wzX3rAejxWdXAJt/Gt
	lgwESc10+BkW7X9/wJm7J11gc=; b=dBIc9dNcvoI1ylIc1yezzx1Vv5CzFcITaw
	a+g3tR5K9XeZB1XmjD0vP5z6/o/iQ5oWOCIhwWSkLeuN6v1Qb+leA9MImCUlgwv3
	aeAH2e8Cb0xvZscyoZLXSHhpHQ05svhD9IPTO69mpMWoxYyGzpinPreSJus2IDBc
	dyir0aTpfqGH0fjaQVVW/VvYLGtcJRrTEdeuzwtT40SnaLnhzq19jKuA4l5WZxtR
	axSCBR39HqO8apaPX/B/kTti/N6LqMQdLofBEZjjh6rU4TIkQbWCKO/xNEbZvk4j
	SxsawuE+Ld1pMiqh718vH2Ib3fYrybCkZSKxKodJdk5cTkvj3/Fw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd9kwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 08:48:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U7t532019300;
	Fri, 30 May 2025 08:48:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd1gxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 08:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJJrD1ycHrSXzIYangXUMu8PYU8aswK4yUfmg9NOuPSmwdBBNlUbmbtVdnMXbClAdy72dpp+YtRyStf7gCyGoGRjtgNbdpD+r3i0lgiI3hwlkMKvLBC7AxyUAzLVVmaMbsUYeVImWdcABa+OoDwwhapfHlKLFaGSfuKfx89Mj3x7hL7UFSim3LphO7rKV5wrBEK0d1CPW1zken70Qnynq2Zs77ECWRPF7b+OZ3Y3JuGGoOrixx1TcT1kUFbmA4371ydkaQKAy3MsJf0tgvNaJmqJAM+jQ9lwAElA4K6LaYqKf493/REsKrTjf4ASN4LjoyTBUsQ7nJljn+sGSO4PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzX3rAejxWdXAJt/GtlgwESc10+BkW7X9/wJm7J11gc=;
 b=VTR4rZuDh6FZteCFo6AKgVVL07n/oqtcszg7JH0J9o2kTncp1zEQ2aFEB8vrVljUJgmWMRx55ZaimwqItcodiHu7+p0oFuu0xP6q/Du54kzgx6dJqM64oiaPk6cwra5GkxoXTDZwnDghyZU5HtrEsnrJ3e69vyVjPaENIfISu/cjv8ES2Cc8OzQy/wlVY4ciApsm/1viftZQExTsslvOcmhZP56ZMXCNFIXeagp94VDasq+pdEIMEKBvvMnNyseXiJ2Y6P1qjYHciVqMy6XGqvTDNa6SpI0X0WRPiIKTRRSgjkSV8qqH6GSmGgmbi7tqtO6O/qRmY9Pf/5A4Aua4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzX3rAejxWdXAJt/GtlgwESc10+BkW7X9/wJm7J11gc=;
 b=kmUaVODSlprVMYd/xKGtXM3tLv7qHh0SYXEmbRhnnSHTrIGNZ94UqB8yqOu+T/FQLkCAlY5Cuap7nopKRdvU/dMNSJuUytF5nSxHDOIIrQhsp1qvVm0tks5NLS6pcxmWfYSiOy+2XsZlucCLytpp/5FKjxX8Sj+lq3w/KFU9uAE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8155.namprd10.prod.outlook.com (2603:10b6:408:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 30 May
 2025 08:48:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 08:48:01 +0000
Date: Fri, 30 May 2025 09:47:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
        hughd@google.com, Liam.Howlett@oracle.com, npache@redhat.com,
        dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Message-ID: <ade3bdb7-7103-4ecd-bce2-7768a0d729ef@lucifer.local>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
X-ClientProxiedBy: LO2P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: a15a77ae-bc3c-4ef3-9db9-08dd9f56af1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqQpWQACXFwLXAbxGumElFmwmrcanZ2v3SmXo4xhdpHYCnUqv1REsnxCptgy?=
 =?us-ascii?Q?2DUadV41eV+rrdJWu5sFYUs2VfQpsgN1Q6WNn8vtLUt/P4ftAVyk4YSt41gU?=
 =?us-ascii?Q?mfNhiFDZqx5h1TKffkCjZ4Z7uz6SNB1gTN6u4xwCOJbpr0f17b5RdI3SOt8I?=
 =?us-ascii?Q?A8cMkBNm+fZbpGJaWUciJM6NQJs0ZstajRz4q8GdK3YbCy8FxQYRrJXgUjfI?=
 =?us-ascii?Q?JBiZcmXKygO6BGv42GG3GAmgZqaVlzG7U1MgcWK06gKoZbIbYlAw6OMk879h?=
 =?us-ascii?Q?eVjz6aw0CtfMDH7bv07rDv7DUKcXmwgJ/F+pfcnBcxilwQHzKqv5siNdJqoN?=
 =?us-ascii?Q?VdaIVWcrVj6pMTrG2fIISCGjA4OeU96n7bSHbKeAqY1ulcalPuxe/PRR0SMZ?=
 =?us-ascii?Q?lQtoTqA8OhStKsWa0nAg+XVUuzPVQbjt0wdcXQREcLUChCRU8tWsONrYLF/P?=
 =?us-ascii?Q?pA8HaVZG/Ww8ot6g4jIRt55Pnvh5HNi11GmsNnGFwGYkNPUqiR+zww3Y7/QS?=
 =?us-ascii?Q?o//KGNiKcBiFsKPef0b/8aSQhZqQtFm2XORjV755mW4aCKp01H5MpC1YuhCn?=
 =?us-ascii?Q?YumIyszNO/krf3R0bhLJz8mMOsv+6v+zbw2XKusqdjZ13QI75Od5XnyJlYsP?=
 =?us-ascii?Q?Al8akU2R7G1AR+iO2o9EAUAT8i4oRLOP68wtTR/t4smManryAD053nvszvw0?=
 =?us-ascii?Q?FSSlV9t52kHGRrYsF9ksc08w3zKQO73+7KXHLhWwAa8DgPwzttwE6bgn4yoz?=
 =?us-ascii?Q?1hWdlHTiINpf3TKGS/SFQXVahXaOLiu/iZCViL2/l+5tOh1/HcWoiZPoj1C2?=
 =?us-ascii?Q?eTbU91StQ+laYwaaX8ZCk8zW3HRlmZ5rNk/Zc2t4KndCSfDCzhon4FCKhZHj?=
 =?us-ascii?Q?dl8qHcsGh8+SD10xraqYgfERi1j3DbWPlCgES+b6Kfi1XulbwhjlUye4T3nn?=
 =?us-ascii?Q?aQWS2qGD/RdUD8m+z7JbMnu+eOF5CLFU89YXPmYDmqOCNgJUU+XBTIf+JhvB?=
 =?us-ascii?Q?Uqg78iRQxmvMnD0mVhODg+fdFtPsBwBlhmbDcWOEeZEyxnxXM7qD75/BGDG3?=
 =?us-ascii?Q?JelWh7FLS0b0Ha+ITeCaXdcxN5c0O1PJvoGaBYdUQWjWT8ad2YhSspgkExF+?=
 =?us-ascii?Q?Lnf/RbMFlS+sClGXNrRC8pPq8qGhu95eSPSQS/h9wGO2gNRoduiDl2A9l/4x?=
 =?us-ascii?Q?dmfJ0WA09mG2cx+cda5MEydfUpRQwEqbYaDnAN3W5JS9NN9bX75Q684n3tql?=
 =?us-ascii?Q?1RhySFBKreEhcIhu08jADPA0m9A98+UDR/dGwiCDvFU666GQ/GT+KhZdjxrj?=
 =?us-ascii?Q?3LRHPjMGi2TDhKIi3vpWGGLTJE4Znq9/T/+EsLzjQhcdyfD59hB7vWhNveTr?=
 =?us-ascii?Q?LmKON+Gc4npMEtb0S3Oj0kV1DjdBxfD0cS6WEgH7dyRPFu9FKZgmQp202/Yx?=
 =?us-ascii?Q?nqLr9YvLKv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VMEULcTzJ2T1z3oUAM9/OGuPELAvPHFANBIGk3nPJb1hpc5ilwIlD4Yv7ILY?=
 =?us-ascii?Q?5IBQBEIEiwlKaN/ElI6/48DfztIA7+fluL3H9zynJ+ENGCezDi5XPdoTmp53?=
 =?us-ascii?Q?4SiER3mtoPVT2fEQ4+T1MnG4ielgymqraQ103byxfHu4QjrVMfVa7N9VoNlI?=
 =?us-ascii?Q?ktEAomg5Qjapivb2cjGzq3j/v+il1jSJrnlhv7jnWJh+MlIElKxUjer5pZ/Y?=
 =?us-ascii?Q?T8JovBhBrcJIckTEFszpmxqXJjNF3/9LviY+QRDRJNg2jiDFsumUXcWoLpvD?=
 =?us-ascii?Q?zpq/ZVufWFC9ItG09e9ooGka3lGTzKdKJ5mk/qrVyzZT6jE5/XihLr16VJJy?=
 =?us-ascii?Q?VmUY1vJ6r3jq1vqoYMQLPAMKdifaIBE9b9+raKWGprtBw2m/sC68gsDEylzA?=
 =?us-ascii?Q?ZL+YrW1ZehraEkwzb1Du4/nz8y4Lswm/le8iNZmdoS6bDXJXd67lwNCFOFfS?=
 =?us-ascii?Q?sbtA03BFNAUA518a10qjQv6b9/E6xetWdL5uc10bfAOlBONi8meGicOwPKVI?=
 =?us-ascii?Q?NlFk9xG3ntyTpuI9VQHA3/fFFf5TRGPe8Iy1wOjAlEyUr210/LpQIVTPPk5R?=
 =?us-ascii?Q?7pOiqLcvSLsue1W7i6NErFrrNiNWg1Cd+uyONYVtkI3EN9NuJ4zzCWQVcVGg?=
 =?us-ascii?Q?VVs5lDgcGzcX9BdrhYUEDGuT2IP5DEc+lquuCSQcPVX1g+kdJtbloOO14Pu7?=
 =?us-ascii?Q?tjl0So/uXGU9Pbj5nBeN+loORzBz92SMiiLBS9ltS773FOxR7qoEPDWGvtTe?=
 =?us-ascii?Q?AaN8erPLxVLvilUl5fZ4NKrhps2Xpw9F1GDb+tWIlHP/p+0Nj3/Hj/OOdDTJ?=
 =?us-ascii?Q?h7btH5R1xUAiEj49OW3RUcuOA7u2B5jFSjSi8Qy2684z1J9iDUY/4a7iFgkA?=
 =?us-ascii?Q?ldvuyI/i+j8FlILx/3MYBEO+gqxJjNwSsSXHwB4hMGpbK20NMCBoGfDjvKbL?=
 =?us-ascii?Q?cqqnaZGs5diW5xVQ5pSBzmrBrWPOPQWPYNmGVIOtMU10yJ4poxAdlpzcFen0?=
 =?us-ascii?Q?lKlIt72+8jRyix1siu8vfNQhqY/qvBtc8PoxtVwLKtS0RHUluyoowC+eCfCo?=
 =?us-ascii?Q?T0sCZN1U9kJGXwrf4oRmL/UIr0/9/0tmdtwHmEzcm0adfdCf2e9YGiQq++VJ?=
 =?us-ascii?Q?hnMpylra4AlmBtGR5VZ0Y/Q+pn2ZHMsCd/S5LQ45Co99gZGICqpHDKktYv9S?=
 =?us-ascii?Q?TX0+HhAaWtT8i8Kg0uCkXsapc2k3nJ+hBnJ/jAbZzo1PUv58SGAXJat2fHmH?=
 =?us-ascii?Q?CadnBwasXwLGuhucA/JWC9UrucVw5IrwpQn+GJq3OOxpaOk4icaJGXVHunpY?=
 =?us-ascii?Q?wMAP2Wn6p8nf3en4ZiM1Z1NNv0x05XyIhpH3r9Cg7PWHWFeZyn5TU3u4h1Fc?=
 =?us-ascii?Q?2Aax7hs3CsqmizrEyNiiC5rUdM6k74N8azAa8PohPnsDUQ7zOqrdrDg6PP4N?=
 =?us-ascii?Q?90UYvLAhW9ZgiE0CCV+79k/8dq7zL63Fwe6SeWszlfZ+6c3D0O4FTFopjgCC?=
 =?us-ascii?Q?tuYmvFjhH/x8e5mfBE/QHVqQYanEIz8ZUsDG/O1TeLsc1/Cw4BA13/tFwMhh?=
 =?us-ascii?Q?eujPQVtVpXnf5vc1VtMxRcCRYax5qID9LSMyuQVkrYO6/YQywAlyBkb+dReo?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q0tYpU3IMKRhr0/Cf+TvOdc5YmBp/QxnMi13YCzTPepcsp2RIaBtN61PzNXZa5VbLWNEhY+PdPStNRwn2hF18Pv15tunabBIzTY4DstQBSR2t4x9HHtvlD1u/jCX6RLrr/jiaC4QAQPHO4FCvk6x4zFQDQ70+YlVlc/rEuogBwv/CY9ZtoKAhVgHEvP8irBhaTExyhCxNWmMClXmZDHN21+JkreqwbHsY/pXETa8+KeeM8X7pCtQ3Eu2pBBKgqOkFldFVmH4K2VdyBGIFuAUj+kcyckzIKQrxw0f03hpy2uYoVNMzi1iaviTehSMlI2LviCtsBbocuVlZPgYrlqTrTPXLlp+YBgREa7NrKhc1DJJFiL9rhDFtI+a6yQa04i9O+Zu7K/Dt4wB7/+q6KMQhCj4IFF7yPIHjdVZgzRN5yHGcIZGrFSorTH69xV1oUO29tFW17vLxjsWKu8Mim3YjGXvx83bbbIJwOLE3ScUfVJUCQgepqj7Pq+ZlgyUE0eDLbcyoMF1Ez+YCOfQSQ1lPA//Lxryr+vB+7o35X4ng0Zh5MlawvsZC1c+GDFUE3ij1PbRN33OqPNH6BlMc9UrXEEvPb0Gq3SxPxwyU1ItUBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15a77ae-bc3c-4ef3-9db9-08dd9f56af1f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 08:48:01.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFJSZQEik3xvcjwBHikipqiZD+Tbi/dBmGanHQgdu/YzZQ9eNNDyJmDPtKoh4437rnTqwbgExjUgXQIy1bcLgh7242WbhglL2HFvb5jhdcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_03,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300074
X-Proofpoint-ORIG-GUID: B6tmW15nf-H9HYPOYQQugNxxAc3B93xC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA3NCBTYWx0ZWRfX6Ssq+DhRwHvx SjgkVr6NE1pFunCmbWkUfwUOrbzJPa6B0C5mvUzUgX6fysowl/xW5ikMrnSOseehnBb9mAPKZkY qcSzVFzZPRyYkAA+mMl5RYy9HWMAn4XrSKtTa6dJi/EE2I9vwFx7cSR6AhpQvbk91SO6Gya4in2
 2Ogjtg/gZcWyFzocpHMHaAhhNaChabQSM87MMdGwcLriRIm4SHocKOCaxmSfzULFHS1Ep1DnDsi XxvtCEf87Dp+e5IL40m9sHB3P+SL+FE9wkN05vgxGridNTdqqIeTsSMUWOHbi9u4uZV8sYh1rkD 5xFjJSn4BtUZAYVbyu0M/YHyDJphr83P+PnWSZ3a5wABoGzVE2T5u23tNPs0rEqMW5bfUhTarOf
 Mb/qqWDYxKH6wLQzrhAZXFX8LY9F6LwQFoXHTekI8SghtpJ7WtcmYRzKGuy0JZcND7N9PVAU
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=683970df b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=CFYDfzxikTNwhxn6LM8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: B6tmW15nf-H9HYPOYQQugNxxAc3B93xC

On Fri, May 30, 2025 at 10:44:36AM +0200, David Hildenbrand wrote:
> On 30.05.25 10:04, Ryan Roberts wrote:
> > On 29/05/2025 09:23, Baolin Wang wrote:
> > > As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
> > > the system-wide anon/shmem THP sysfs settings, which means that even though
> > > we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
> > > attempt to collapse into a anon/shmem THP. This violates the rule we have
> > > agreed upon: never means never. This patch set will address this issue.
> >
> > This is a drive-by comment from me without having the previous context, but...
> >
> > Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a deliberate
> > user-initiated, synchonous request to use huge pages for a range of memory.
> > There is nothing *transparent* about it, it just happens to be implemented using
> > the same logic that THP uses.
> >
> > I always thought this was a deliberate design decision.
>
> If the admin said "never", then why should a user be able to overwrite that?
>
> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll ignore
> that. Because that was set by the app itself (MADV_NOHUEPAGE).
>

I'm with David on this one.

I think it's principal of least surprise - to me 'never' is pretty
emphatic, and keep in mind the other choices are 'always' and...  'madvise'
:) which explicitly is 'hey only do this if madvise tells you to'.

I'd be rather surprised if I hadn't set madvise and a user uses madvise to
in some fashion override the never.

I mean I think we all agree this interface is to use a technical term -
crap - and we need something a lot more fine-grained and smart, but I think
given the situation we're in we should make it at least as least surprising
as possible.

> --
> Cheers,
>
> David / dhildenb
>

