Return-Path: <linux-fsdevel+bounces-26548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867595A58E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9A5B21960
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1E16F0F0;
	Wed, 21 Aug 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rdh2zTc/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m0PU8vpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F861137745;
	Wed, 21 Aug 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270221; cv=fail; b=PGsvs+pixmpGUHLJsYT+iFeYfoj2U7wJvfh2l/DCrL02Ef8wFOWbz8zDZmdzdNFtQYtP1WPGeCrek/EuOfKsZkBi9vzyfdwxe9L9da1YQSnndKQwpHzdDj19nuMuUqH54OU7HdjSxffyXjVgzD4VE8gjTEOW6KzMZPr7ACINlFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270221; c=relaxed/simple;
	bh=GGcWXqOCEkgw6tWtCTNkHgXoDaqnnrqpA0UOPWE5slo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUQ1Uj7SInrqZ0BaTlJgIhvnARIpc7JKg995e1j0hj37T5JEoIiUdniAoCTnFdD3MyGC7HDXxos1NoRvU+uVsfv33Py6bDX55MfjWS3yZd4FtEdIU8CcSsgUYAA+3QyXKSEHHyXcpUMQEBDxwFY55qi7Nu36UQvkkD3SSvPxlEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rdh2zTc/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m0PU8vpw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LJcpHj018099;
	Wed, 21 Aug 2024 19:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=QToJyjbdngcsqtz
	PVuWgs/6TtLhcCjbBg8jk5f5HbHs=; b=Rdh2zTc/2pKvLADJOuOk9V0uNRMtWBw
	Mc5zT2RL/19i1F9JFlIvOEoO/v2Q/LTdP6Y8BZUysge1zgKHv9Hgbgt8z3AxwEiY
	AnomP3JWjsmvv+5RzOAvQPBHNPRhZH2WzoWS17pAJ/Vx1Yp6F+yHn/8Q+Nj0tg+/
	xZW7YJMwf6F/RhhS97jepot5SDrthN0BbWOD/eO4zSvdVosprIDdPOXukn5L7dFu
	i8KjotM5o3ds65xw6P7rTC9d4BomhodelLI+3M2piOX50tQIEyx7Qv96mCparAvR
	3JM3y7dhvyLuKuGpOXvY/EESfeBsueKJfWyZADHB7RMbS5qoIZEREzw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67gc1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:56:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LJIjbw032263;
	Wed, 21 Aug 2024 19:56:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415p9m1d47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKos2arm74bpGM7AJNTWiefeQMX6Avj089bUvQHmur98xtDVTP/hrjTv+yGLQLPPbklL6i7K+9kAyG5ZauTrrW87inYVZQ08Wb5Pdq1pS/1bz9+cX1kPVO5J7SNs9pjrK3ww5G6fZfAy+tLPDA0+yqIW8GaZ60k5fFGNWn+D6sDOU3DLrdBVjDQt297QoWomqJaFn/E1Rjj+yCyzMMuaRwcMhzvao4B4QkBKuot1lEYcsP4zOxQgC2HdIkpdX6t8V+8m7S6C82QBRKLvE8Hr869eKoWNqanKCbrDDSKTSG7kyQzQGZ9F8/sOL/TRdtyNWrNtQsKfCgupknT60SAVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QToJyjbdngcsqtzPVuWgs/6TtLhcCjbBg8jk5f5HbHs=;
 b=v0oxeI9o9y03JKiNA35zXMITyO2ktzB7Pk7QxLY/O+amGI9KqWn+UNFC1MGlr0ap8YJCR/N1uA6320B0rQYx5+jwvch3hexr1WWk4b+3ZETy8r1UXMWW8Mli4RasxbNLWAc2bOlVH174roDIo5q4MDr7JLhHH79VyHw0+LA1UTJ1Oy1I0s+tSHNUlyH0dwHNeg5eW/JUK/3o38R1+4yP5gawUlHQnMYPGKoGnTsBV1W+vKOmIFpVfin0V58XQMv4GjNc1LjQdcz0mAgaqbeOnPtSVOwGNXSUSSRBOLs/1+ztmiz+iLmsmsf0A64ZcXngNJdgxcDwiGsSouHX/l+aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QToJyjbdngcsqtzPVuWgs/6TtLhcCjbBg8jk5f5HbHs=;
 b=m0PU8vpwvC/23RIphA9R9U+4Qf/gsHTS7wtJdZu9F6Y5r8c+82gKMUjR+b0XOWTVcpQauXRhkJ15WhWwfpgfKjnQTBZToETnpcsk3KMGWeHyZJjRsa8IEgCUTTIaJEJwBoiDFToRHTznkepqv2PxkPyMHvGyO2128+Is1QN0Nb4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 19:56:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 19:56:48 +0000
Date: Wed, 21 Aug 2024 15:56:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Message-ID: <ZsZGfNj0QOhIFtiV@tissot.1015granger.net>
References: <20240819181750.70570-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
X-ClientProxiedBy: CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f52f18-9ec3-4975-e1b2-08dcc21b6434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSrMefFeHRGb5Pi5guObiD+Lv2zeDum/w2sQeZSCwh96QLiLuIxtXCuHqV1P?=
 =?us-ascii?Q?05NdifqFVg7GGjZBIRN7t45fIPyDqrJpYZ5YKuCKw37n/cc7cuEvpv71LmSO?=
 =?us-ascii?Q?JFMTJOaUxxvGp4W4WYHd/Mr+VORW8Zs/VHxFY6yRi5EbZRls9AzYzmHV1h70?=
 =?us-ascii?Q?SLAxHlEUlWO21CY4i4ZHHaAzkyQAoA8KX0q/e3TKfFw8m/0UX44y1+MQgygA?=
 =?us-ascii?Q?69d/buwkjybj3dNkJ9yA6iTDGhRzZpH9cmkDJfj3VbahxhqGkCLnT4wdlL//?=
 =?us-ascii?Q?qOKoU/LhWDUL7/sphJYxAPK1FrRAQvsRMKViDpsyMWvIkxhoh4G1+fmGSYEF?=
 =?us-ascii?Q?7TDWHbzM3YmNVQ182oPGWOBFUi1Cv752DwVDtabgGGjIFtHNv75nIzb6GD6z?=
 =?us-ascii?Q?x8/0ry9GNvXiEtV38pOYeqlR+ztOw0xWHLoN3evrrFPSsaLvTeWXiSFtr2Wz?=
 =?us-ascii?Q?jjbDwd4kgCRWcGxBttwcJENiLVMHjhPFTd5+hOsqK/JDfYDEtW/twoN93mCB?=
 =?us-ascii?Q?j+KBiS1UhuwE9yU1bFpD/adQDiBCK70KraWp0IL00Rd5JivRMBqhNVyVduej?=
 =?us-ascii?Q?TONPBkKOoLL/zU6F8Zwrrwm6UOtoYPb8qCBFLTnFoDZp5yBqpKFpE4EYwaEX?=
 =?us-ascii?Q?X/a75r8a1hE863k+GMp9ZW5R9UBYbpe3/H8Z6R2ISGGupAzbLeHq1CYavt8M?=
 =?us-ascii?Q?2sGGYnk5h50dONGxniZD28Mll0E3y/Zw5KP+lJxtb4d88U2YHNCfjRHuJ9xg?=
 =?us-ascii?Q?v6AwKQt49GDcrKSBhoDXnOpTBfIiCgpYsKnJbskyhJEF0B4941zLeqO1N19a?=
 =?us-ascii?Q?w4BtYUZa2mt3S2qYvRZvFLeRcwAZh2iBFvG+n7YvqvbTg7RqsTa9xWqUEA6L?=
 =?us-ascii?Q?w5gGs/DCe0CNtwP4h9x15o3MKmoN5NmAtuBRpSQamWB2kjSFxzY/UDwyHo6Z?=
 =?us-ascii?Q?ZDsIWyt/JJb0J1y5ACiKdR0HQOUHARfleYBeZprxWxLN+GqATEkntNPGoBFB?=
 =?us-ascii?Q?/8cGREHSdflxp3HvKHTd58owh1ZVvdzHf5VQjlnkvMTzL+6ZXKGKuxY5JcjP?=
 =?us-ascii?Q?+3yjsJpY4jYHxDhP2/Oa5EBqrs34QHOosVcBwOcSQ1bCzUSKl/HdRYaSgUqR?=
 =?us-ascii?Q?elUm1kX9tJEcATOmmdrpjESqb5vdbUGCQU5+2L2s3X1R1ZzBc7VFnJ34l6eF?=
 =?us-ascii?Q?Eh/iX2woVhA8fEYCdN9rxnlefGcHGSCDY8QPsf+qy9vvdtks/rFQ1dLOn0UV?=
 =?us-ascii?Q?c5v21EB7tdbx+FsEvvRaGvvoemRSWa9LaMdJighxpnb6j6kA4LiBZV+tqJz2?=
 =?us-ascii?Q?2Rg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DCtrgbKi40LbIqVyZwlbAb94g+UC6WvCDhhOCZcZJYqeQUv5yK/IvoTxLY4?=
 =?us-ascii?Q?IokA4wdrdPo6hBTS8kj3iUPTxNRAxcjWL1mGH3PX/PCm6OAMLVCxcXKpFO22?=
 =?us-ascii?Q?tuBAomM8XYzjnLhL56tSDqtBfYIbH7UKKInoI3fM8Abwx0xhtqekgC4PwgSS?=
 =?us-ascii?Q?3Vj5vU+/eMTu5YCBgjjFvSdD9MhcJAOepNsxEx/Dd7Icss1/lH21/ZV3RVY/?=
 =?us-ascii?Q?SEUhH7CllVydXtOyrXb9jXVtnfUqU1we2CBzkIlQ3phnH8Nj0Mxfuq7Viu1K?=
 =?us-ascii?Q?tWR6oXu/gs9+KjJk2+TFvJN9cLx346uAGhg35nggKAxBm2urz22Hyoi3D8YL?=
 =?us-ascii?Q?CE/j7GjI0I0ZM+EyofLdrnLukzjuKj592Dreoxtcx87IhfSKAjYFLXUP5fCf?=
 =?us-ascii?Q?eR2uoy/ktwgj8dDc0yTakqiKZD54H8nZAjWKBpQJJAuytbJAbIDiEQLc9/zD?=
 =?us-ascii?Q?IrnaoqbLaAze3hpYBG4skQW/h2vssD8DRYprz30wrJLCmefe109MpPeKJrDh?=
 =?us-ascii?Q?NbOIOG3EoEybFHs7qQ4b/624rvX0r6722uudYnqoE7iUu8ycsQRzVwhhdmgo?=
 =?us-ascii?Q?N9RgPdlJzkj8ui5T95mz8z2iKuAO1RoVBVaGRF2XVt0xiKkWjEeIiZC1W3ft?=
 =?us-ascii?Q?WbNEU2y9BJlT9wW9NcsYStCmcLQUg+k9SGUNarLchWAJpAoz2hSLbL+VaIV+?=
 =?us-ascii?Q?1uzq5V7wPaiWbikmGUxazX3EFSxg/84pUKpuLxdrX9sxeXMDZ6V/wV2nqL3O?=
 =?us-ascii?Q?JLfwH23PIFcB75aE+Bbsg7CmyUnQWbbiTBZbp5m59IB/VZzqaYKy2noHc9+Q?=
 =?us-ascii?Q?WontiGkbVTy/dQNSYvynlgOit8WN1FgvPzq7dB7MICJ+EqKuDjftcyZpzQJR?=
 =?us-ascii?Q?oCXsxSEhKj4TazqlRjfphr7sbH9QKQc3cPZRIdMICgWjZwJEEynsWTPpk4uR?=
 =?us-ascii?Q?7ti7Bm/HLSEH1KUy7zEu7rCM+JK4b1wXli3pmMa1h6EZh22x3uGVUKcavm55?=
 =?us-ascii?Q?iX1dU+Xd7ShGML1127q4sEcds/KnOMumJCE44JzqrHb0fCRI7IKL563MY6hy?=
 =?us-ascii?Q?hx+P7Tx/+ne2Dz3P3xaYorltzabxzb7bHPInptpjwatziU/Qghv1DczuqAki?=
 =?us-ascii?Q?qeJESPvWUpBRsaeUSZyyMZZObinR0vE8vTFDY4F1qOUplS9KqJmW8EqcVYG+?=
 =?us-ascii?Q?tHdKtJ/HTcG7eWf5wqBjmrXycvxO1YHTo9/8q82ult8q9A1ABeg968SUN0Dl?=
 =?us-ascii?Q?yo4wy6O0gOgWswcxHHQK0DZRn8Z1273QZ78Bsf/eGcvP3DivzqQS0L7IouJv?=
 =?us-ascii?Q?pXlFZQb2RJM6GqL/9/wtspS4uUhM3FpvReeGmSQtnaDfSEyBppX/vZe3tUSI?=
 =?us-ascii?Q?4I/jp+JqrpQBz9CbufUW5gFT7Ud4H6Btrj6ZYD5XJXAOUAnyAZBuLmtDZ8RG?=
 =?us-ascii?Q?klcbrtd0lBfCbwg9l5LkNFfyivTlMHN3wi+mIoMJX33aPrSodl4GSCKfT4ht?=
 =?us-ascii?Q?CLZLpQ1R1l9YuZmqeykInaJzs64VLnlBuABa+/MfONoe2ej4EyOXC8TxqVDX?=
 =?us-ascii?Q?JlDn0iacg/VtXnxJ5N2xKZvoNOjDb2szIcgwMpNBEjb5A1NqoOPWbON2+G52?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gHwIr7W64Dl8D43GE7uuMM/eKwmRSm9Z8gIvwU4tdnX8akFWM7XQC1RcgkRsrJsxNeT/2O1vIMr00uhA0x6EKabYsk66PwpvWWJQ/hdR5jKz2ser1gjYwZXhtv34iU8C0rgeIywQgw0oH1qidOqlZMDw0m9CS4rVPEJobkMGZhrEZ1kSsOt8tPmotXq6+fc6dbfj2VIUjoXhd6J0wnhAW8lyIo8pM/g8m2/g8owN2Cp1yXSleSDErV+M6QvfyghODGM7c0w6sERe1zSNxDvFxNtvoEqLvxBc+2yti/cjlzd3Abt/mRmSpJ3orbId+dS50rQAiCFKptl4f41jDwGrZeMMLz69OodOgSSs9uU0FNRT0F5V8GvfgBQvZvjPL1vXjXYgcp3a3TCkA966LSfOE9j+mlsU4KM5YDa5FgwKJMYUn+edAv9+LYTh3ho2yOjvnNZNPFmKp8uvXjqVfsXU2vfg/PfU9rR/5Ra6IclpEx/lkG9EJJk0Gu+cjrg9Cte+ISSBwhDKkHi6OhoT4JYkfSsusMBEwhVEvKzRnQerGShaMAf9Z1waRZ6hlZIvmjLf/15t+vpD3g/egH2Vfmj+5nkmO8m+KZiw6YfQ6uqaWPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f52f18-9ec3-4975-e1b2-08dcc21b6434
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:56:48.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1GaDSBgh5Qbh+3iRaltbulqrEjIqDzTlygJG7QfHN1x6R0ckHdXVuPqKXkpZtKg0oRRZ471KB3HsjZeMrYObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210146
X-Proofpoint-ORIG-GUID: t8kh4iP6jGylQBf48fjqh_6itWNwihW-
X-Proofpoint-GUID: t8kh4iP6jGylQBf48fjqh_6itWNwihW-

On Mon, Aug 19, 2024 at 02:17:05PM -0400, Mike Snitzer wrote:
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> 
> Significant progress was made on the entire series, I implemented all
> 3 changes NeilBrown suggested here:
> https://marc.info/?l=linux-nfs&m=172004547710968&w=2
> 
> And Neil kindly provided review of a preliminary v12 that I then used
> to refine this final v12 further.  Neil found the series much cleaner
> and approachable.
> 
> This v12 also switches the NFS client's localio code over to driving
> IO in terms of nfsd's nfsd_file (rather than a simple file pointer).
> I checked with Jeff Layton and he likes the switch to using nfsd_file
> (Jeff did suggest I make sure to keep struct nfsd_file completely
> opaque to the client).  Proper use of nfsd_file provides a solid
> performance improvement (as detailed in the last patch's commit
> header) thanks especially to the nfsd filecache's GC feature (which
> localio now makes use of).
> 
> Testing:
> - Chuck's kdevops NFS testing has been operating against the
>   nfs-localio-for-next branch for a while now (not sure if LOCALIO is
>   enabled or if Chuck is just verifying the branch works with LOCALIO
>   disabled).
> - Verified all of Hammerspace's various sanity tests pass (this
>   includes numerous pNFS and flexfiles tests).
> 
> Please review, I'm hopeful I've addressed any outstanding issues and
> that these changes worthy of being merged for v6.12.  If you see
> something, say something ;)
> 
> Changes since v11:
> - The required localio specific changes in fs/nfsd/ are much simpler
>   (thanks to the prelim patches that update common code to support the
>    the localio case, fs/nfsd/localio.c in particular is now very lean)
> - Improved the localio protocol to address NeilBrown's issue #1.
>   Replaced GETUUID with UUID_IS_LOCAL RPC, which inverts protocol such
>   that client generates a nonce (shortlived single-use UUID) and
>   proceeds to verify the server sees it in nfs_common.
>   - this eliminated the need to add 'struct nfsd_uuid' to nfsd_net
> - Finished the RFC series NeilBrown started to introduce
>   nfsd_file_acquire_local(), enables the use of a "fake" svc_rqst to
>   be eliminated: https://marc.info/?l=linux-nfs&m=171980269529965&w=2 
>   (uses auth_domain as suggested, addresses NeilBrown's issue #2)
> - rpcauth_map_clnt_to_svc_cred_local now uses userns of client and
>   from_{kuid,kgid}_munged (hopefully addresses NeilBrown's issue #3)
> - Updated nfs_local_call_write() to override_creds() with the cred
>   used by the client to open the localio file.
> - To avoid localio hitting writeback deadlock (same as is done for
>   existing loopback NFSD support in nfsd_vfs_write() function): set
>   PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO in nfs_local_call_write() and
>   restore current->flags before return.
> - Factored nfs_stat_to_errno and nfs4_stat_to_errno out to nfs_common
>   to eliminate localio code creating yet another copy of them.
>   (eliminates existing duplication between fs/nfs/nfs[23]xdr.c)
> - Simplified Kconfig so that NFS_LOCALIO depends on NFS_FS and
>   NFSD_LOCALIO depends on NFSD.
> - Only support localio if UNIX Authentication (AUTH_UNIX) is used.
> - Improved workqueue patch to not use wait_for_completion().
> - Dropped 2 prelim fs/nfs/ patches that weren't actually needed.
> - Updated localio.rst to reflect the various changes listed above,
>   also added a new "FAQ" section from Trond (which was informed by an
>   in-person discussion about localio that Trond had with Christoph).
> - Fixed "nfsd: add nfsd_file_acquire_local()" commit to work with
>   NFSv3 (had been testing with NFSv4.2 and the fact that NFSv3
>   regressed due to 'nfs_ver' not being properly initialized for
>   non-LOCALIO callers was missed.
> - Fixed issue Neil reported where "When using localio, if I open,
>   read, don't close, then try to stop the server and umount the
>   exported filesystem I get EBUSY for the umount."
>   - fix by removing refcount on localio file (no longer cache open
>     localio file in the client).
> - Fixed nfsd tracepoints that were impacted by the possibility they'd
>   be passed a NULL rqstp when using localio.
> - Rebased on cel/nfsd-next (based on v6.11-rc4) to layer upon Neil's
>   various changes that were originally motivated by LOCALIO, reduces
>   footprint of this patchset.
> - Exported nfsd_file interfaces needed to switch the nfs client's
>   localio code over to using it.
> - Switched the the nfs client's localio code over to using nfsd_file.
> 
> Thanks,
> Mike
> 
> Mike Snitzer (13):
>   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
>   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
>   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
>   nfsd: fix nfsfh tracepoints to properly handle NULL rqstp
>   SUNRPC: remove call_allocate() BUG_ONs
>   nfs_common: add NFS LOCALIO auxiliary protocol enablement
>   nfsd: implement server support for NFS_LOCALIO_PROGRAM
>   nfs: implement client support for NFS_LOCALIO_PROGRAM
>   nfs: add Documentation/filesystems/nfs/localio.rst
>   nfsd: use GC for nfsd_file returned by nfsd_file_acquire_local
>   nfs_common: expose localio's required nfsd symbols to nfs client
>   nfs: push localio nfsd_file_put call out to client
>   nfs: switch client to use nfsd_file for localio
> 
> NeilBrown (3):
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
>   SUNRPC: replace program list with program array
> 
> Trond Myklebust (4):
>   nfs: enable localio for non-pNFS IO
>   pnfs/flexfiles: enable localio support
>   nfs/localio: use dedicated workqueues for filesystem read and write
>   nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
> 
> Weston Andros Adamson (4):
>   SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
>   nfsd: add localio support
>   nfs: pass struct file to nfs_init_pgio and nfs_init_commit
>   nfs: add localio support
> 
>  Documentation/filesystems/nfs/localio.rst | 255 +++++++
>  fs/Kconfig                                |   3 +
>  fs/nfs/Kconfig                            |  15 +
>  fs/nfs/Makefile                           |   1 +
>  fs/nfs/client.c                           |  15 +-
>  fs/nfs/filelayout/filelayout.c            |   6 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 142 +++-
>  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  fs/nfs/inode.c                            |  57 +-
>  fs/nfs/internal.h                         |  61 +-
>  fs/nfs/localio.c                          | 784 ++++++++++++++++++++++
>  fs/nfs/nfs2xdr.c                          |  70 +-
>  fs/nfs/nfs3xdr.c                          | 108 +--
>  fs/nfs/nfs4xdr.c                          |  84 +--
>  fs/nfs/nfstrace.h                         |  61 ++
>  fs/nfs/pagelist.c                         |  16 +-
>  fs/nfs/pnfs_nfs.c                         |   2 +-
>  fs/nfs/write.c                            |  12 +-
>  fs/nfs_common/Makefile                    |   5 +
>  fs/nfs_common/common.c                    | 134 ++++
>  fs/nfs_common/nfslocalio.c                | 194 ++++++
>  fs/nfsd/Kconfig                           |  15 +
>  fs/nfsd/Makefile                          |   1 +
>  fs/nfsd/export.c                          |   8 +-
>  fs/nfsd/filecache.c                       |  90 ++-
>  fs/nfsd/filecache.h                       |   5 +
>  fs/nfsd/localio.c                         | 183 +++++
>  fs/nfsd/netns.h                           |   8 +-
>  fs/nfsd/nfsctl.c                          |   2 +-
>  fs/nfsd/nfsd.h                            |   6 +-
>  fs/nfsd/nfsfh.c                           | 114 ++--
>  fs/nfsd/nfsfh.h                           |   5 +
>  fs/nfsd/nfssvc.c                          | 100 ++-
>  fs/nfsd/trace.h                           |  39 +-
>  fs/nfsd/vfs.h                             |  10 +
>  include/linux/nfs.h                       |   9 +
>  include/linux/nfs_common.h                |  17 +
>  include/linux/nfs_fs_sb.h                 |  10 +
>  include/linux/nfs_xdr.h                   |  20 +-
>  include/linux/nfslocalio.h                |  56 ++
>  include/linux/sunrpc/auth.h               |   4 +
>  include/linux/sunrpc/svc.h                |   7 +-
>  net/sunrpc/auth.c                         |  22 +
>  net/sunrpc/clnt.c                         |   6 -
>  net/sunrpc/svc.c                          |  68 +-
>  net/sunrpc/svc_xprt.c                     |   2 +-
>  net/sunrpc/svcauth_unix.c                 |   3 +-
>  48 files changed, 2428 insertions(+), 415 deletions(-)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfs_common/common.c
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 fs/nfsd/localio.c
>  create mode 100644 include/linux/nfs_common.h
>  create mode 100644 include/linux/nfslocalio.h
> 
> -- 
> 2.44.0
> 
> 

Hi Mike-

I've started familiarizing myself with v12. I'm happy to see that
the fake svc_rqst code is gone, and I thank you, Neil, and Trond
for your effort replacing that code.

I think I understand why we have to use an ephemeral garbage-
collected nfsd_file rather than having the client hold one open
while it has an open file descriptor for that file.

Next I want to start auditing the client's open path for security
issues. I will hold any specific comments until I've done that.

It's great that Jeff has reviewed these already! I concur that a
little patch re-organization will be helpful.


-- 
Chuck Lever

