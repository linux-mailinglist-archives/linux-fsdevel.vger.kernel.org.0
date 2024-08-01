Return-Path: <linux-fsdevel+bounces-24808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4AE9450A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2321C22985
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FE1B4C41;
	Thu,  1 Aug 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fmLJjKR9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l9jtzMJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D51EB4BF;
	Thu,  1 Aug 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529919; cv=fail; b=R7tpIzgLbs+vCaVVCPKh/5rZ3cuAAGGrU0B2XJzH+h+RoOKFPPtV4i2ZJedjyOfz7Ej6fLYRsV32EMwUbSLmRd2NO8fDxAqbSseW4M1OyeDHQh5oPfB5DqxYhPkhVR9xi74MGrW5I8abaq83mIrecFA6PELeWSF1bqMWJHRQI3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529919; c=relaxed/simple;
	bh=zWRDLuo/ILWanQJGpQZkcZulk/YZxcolQW3I7gFzbp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1DfBDhTdDVWgpVypKhsSkM5BJ3l4bhP00TWLA2bhNFVbHkASROJWNeONGugtmte1FUsJECLStsFCyxNDZMiN3e/jhJGT0l6d/tN8uhT7PU4zFwaWFpaCoczYhJCkjXV2B2qPjzUSeskXovkjRt11aNMFHPERiTNiSP9cMr9Dao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fmLJjKR9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l9jtzMJA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtX5b024065;
	Thu, 1 Aug 2024 16:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=; b=
	fmLJjKR9M8nuO4jGmMmE/FqC7rkEBr6UgvqOZqaToD4Ujx85cu1GdZjuJ6xPaM6B
	Cqkm989m8QU5DMSgmbDlGPzisuZ9W+O7ATkrz7ElQ6BG0eXADdvaXmRHiF/JGjsS
	yImKbw/NYh6xY30QcGU2248Vc0i6no9SLpTl8cXeHboMtU+hEZpmxtMXhFN8phmH
	IIr03H42abF2r5HZXhHyBBd3uy2n5ez5KCm3pfPktveZA2jIBcLsHWpzZwEaTQLe
	mgoqbGLqsnfHGUXVWlS5Y6sy6tMetWzaRcNe5iX9eDl7//wl+QuIWLNyLfgX1dQX
	N8fy7NKb3ygxNmlnPi+n1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgsa65w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471GO58k040207;
	Thu, 1 Aug 2024 16:31:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm866rh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8RHY5fxllzdghXyQw7Kn+UY5FyGXR/K4K6NnSi+jRd9G1XljiSSlCEWlyg2oa+XrhZi0htaDhSlQW/8YXDKU97+hz9c2UMuPOUB2pGQSJpI2dWaijo3MCZBlHi7EaWcbeFWylBTcXXZTx3EknMluacBI27fV+1Gkk6wgj7BMER7U079Hsi4NMey1WHwtfV/33AjSI4u0djIOiG7ywFA/dAxguZIgK34qU3D97Sd834xx3KC/PSj9AWbp31TcgQngcMIK7XDeSitk4z4DlrgjUx3YN07fYpx91l2QWNbxdWV+dD89OvWxEc3KYanHU3OPkciN4QOjwI/cubReDMmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=;
 b=QxUeSYzHvokoeR5/74zzY04Guvs+JZ1blEBoEKzyDe92/R/0NB6Kz5e1hNhT4N35k2JNGQa/BEZj9GG6ajcJYlq+I/9RzIXJ17tapKZywdnB9+o31Rzxmr0Ipo+KHqVhu7UHGUdy9Kt+WCbzenWLE2qj/JaE4DFbY9w0ZNyLV0wDhftdurH8aB1VucMwGfCbJYgc++xvMOVC9p9ArwQ5zfhDoPa4BcJzq0D2FKi8HpKBrNUzThcv6hMj+FNHgEfVe3rHjBUDYqxzZzEawAnATTvNd+JfbJRl/IYjoMOSDhO7Ppe9Rza2PHLC1r4qvJf5dHtxaqShRfNF8Jrfa2pibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vGPOSgKv4rwY21roIrT4v81Jkb2+AWEDbk7Fux44jA=;
 b=l9jtzMJAiIz8M2KArdnXLaYKL/9BJawDJkEbfGBzpQLev3B+vvdLM5vUN+gq4DdjM9QdJJAS3gPQbEHMgH02ka54gv7rwVZZmGCDeYly69/a3Z/FmdZikm94EyYy1nz93EU6XK4O+OnJEliQ8emzRt9jWfjcDCro+mMdGWA5ChA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 02/14] xfs: always tail align maxlen allocations
Date: Thu,  1 Aug 2024 16:30:45 +0000
Message-Id: <20240801163057.3981192-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fe2b78-b872-40b9-4d64-08dcb2476ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8eHZyMzFo/T1iCPY2WyckmvtdhvvjhBw+w4cNUe2fTSgorMHfHJ6iKRP6NAJ?=
 =?us-ascii?Q?KnKnMbWknaRS2g0FCG77wdSXBldRUo1nLXmzgRy0h1lKDL0U8eDDz2Ay1KfI?=
 =?us-ascii?Q?hp9cusMd2iS/3pn/pNboPDhSRQETxnwkDBR6L4T3Xb8JOdGPIM72s67SkrPw?=
 =?us-ascii?Q?QK6tcAUPf6MNx5/aJ4U6FNsW42pi5PNGSoqUhrTgDz/x0c+vJIBxcGRUjqPD?=
 =?us-ascii?Q?UO9liYbwydi8Fq938P2N8p0M1zKVaULG31ryL8QlZJdQNXt4IsLRqONwYNgm?=
 =?us-ascii?Q?VWjzocDpcZk/jBamm8tRHcfevqHyVE30aI18LAR/10VbTae82bnEXOad3H4U?=
 =?us-ascii?Q?Ai6YAGBuvbikmpLvcUZ6pJmX7hRcRdwDiNZODi1tF8DQjrikScIerh60TdsY?=
 =?us-ascii?Q?7PLNrgQeTmrqW0CC6Men2ctQ51dBHEbyRh/ywFJc9RZ5dXVN9qe6Zg/EoKAa?=
 =?us-ascii?Q?Nu4m3moaasRtCE7SP0MjnzzWsoG/LLMfw0DnuN5DosahH0Ux5hPvI8bz9uE6?=
 =?us-ascii?Q?djWsmaQSZcHHWyeYxMmOom4PANpHMSTxX5o5zTYwx1OtkRnn5SCs3DFoN99c?=
 =?us-ascii?Q?KmC6Mq6yv/aUHl44SX7kyzZIKElOnaTJN4ovyaulKzXxbvOd/Xaa+R4/mcUc?=
 =?us-ascii?Q?bE1nvRUssT122H3EHknHmLtl0iK24OmEDy+HBdgyRwtIoXbFcMZJtpdm+FXx?=
 =?us-ascii?Q?yCgBCDfm6TVWT8fqEOD6S1bA4O8ylScHowEeppbXJ1Bnx5eJl7Ufa8zbRQt5?=
 =?us-ascii?Q?upceHO7Uc8tn0eG+l3Y/dsf6DzRONwa28KTpgIQpD+hRsg0e3kTPeLe+mWMG?=
 =?us-ascii?Q?s2VweOubHmTMcRZCo9tNEKVXlr4a8BWdplF6t7taezlw9LVCIIy0+1cPoGfj?=
 =?us-ascii?Q?JbKp+/aTiatrV53n9Bs3a1hFCwzimPEbzNUVA0hpoob7Zr5MZ1R6wvysXVCT?=
 =?us-ascii?Q?ea7p04pEYrfwVETQd6YFsA8sMQ5MYDIW0ks8UCuQPsUcGiVsipQGKqpzXh/c?=
 =?us-ascii?Q?btZcFwy2x5pWqblJVzAUcyeYd2dKkJl0hzJP39sUd6TAolA0VGx6OYkcWsdY?=
 =?us-ascii?Q?330fabtX91jMOvwytVPpUR2ZIFrXlxAr3Pb0uFgI6li3SxFU5upkWX7r5XGm?=
 =?us-ascii?Q?AkYgisUdqpcDzUnhJ2V9pxNAXnERodeTDQs/U9rxa8wD9q0XyEnLP9fSjFXj?=
 =?us-ascii?Q?A/mTnv4PEo97YBlMZeQ+CpJs6evuAKYwnoWqauvjA7/EOBNSECxXKs4xUsP5?=
 =?us-ascii?Q?zazKHJ5TD9aGPffVBv4pxpv5KCT+ojAa3sNikjYS7hXXqvXzto5n3NRkJuof?=
 =?us-ascii?Q?9Z4kxRY0ro6y9hS//oUK0vxUGFWWEKf1jxu7bQD6SkgrQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGwn0qw55vnx7Eng0OQxgtlNfEoMkyQlAbRD0Wfuu0K6OIFdjlwbKI5wM+tw?=
 =?us-ascii?Q?mI8V5MR8xIzHEgsdiqQ/J7ITtVjBj/buADiTnkh/vjM0bJZ8ugzP5TXSkY5Q?=
 =?us-ascii?Q?aQOiSYXfpynGjOoekcg23nm/1I3EWpYAbAz0amxHDIoHOgv/cDuZ55ecvaYh?=
 =?us-ascii?Q?b39KMNPKWywLMubYfsecBH6ryk5G2/W0tES+jSnp34i/sFl51Heq3VWXPIX7?=
 =?us-ascii?Q?u6eW56ArNHBcVKfEar+5tPLoDfnAFkoffe35sC9xf/Uqx158uCLjvBUGdiUg?=
 =?us-ascii?Q?5mqNiaZTZaNLwXG2JnL+6lzg2dkPKZJSrKWtR9wR4cNlJZCTCrfbjTUwc4bL?=
 =?us-ascii?Q?UFQAuoPIBY168r2noy8EWRzNY1SYx6c53x1I0vo+lk9dJiDgFT7JZGJ7nSYJ?=
 =?us-ascii?Q?Jc8UoDyNQQdvv9KBIBeqHKmX+ivG6iYyDUDEwz8LEYuk4+okYcvj80CBUTy8?=
 =?us-ascii?Q?VKHQ0tKM6HAOwtSgHR3aB/eG3sSFQ0hRcg4FELknp28KrVoJRK5nrfUpMxPi?=
 =?us-ascii?Q?RHwdZUkOCxJIc/KJ+VpoKp989lBF01In9qpIjmSbV8Yt+BKqnN9v/juOQbR0?=
 =?us-ascii?Q?wR13/jQjY2pAKllm5kNYJlBXFsRmY3shWm9tRAhgWYf8onvPkuwJ5bub15kx?=
 =?us-ascii?Q?n7rimCsw6Oq//z71Dk/xc+ta3wjFB6N+khJQuAQ7BcJjgJS55+E6GibduKeM?=
 =?us-ascii?Q?y8HYgSUxKJLkFKCv/gmm4ZVuloysrArH1j3FSme3WS+abh2rX/CtIoEPyuau?=
 =?us-ascii?Q?nUpvsrWHG4D2FUoUvXp+biz0zkFeTcBkE50Us6Urd9WOG9WhPV7G9ay6RCYZ?=
 =?us-ascii?Q?VZbqUbNlWDK2qqJiTaum1u33Lmftm0vVNG3UR1RP41lxIm964lbr0XG2jGCx?=
 =?us-ascii?Q?nS4RkqyVs5AIGyHquYmRaIQXm//6KReDXwjfZdVO34QeaBLRjebHdNw/LCJq?=
 =?us-ascii?Q?5VBuGeevU71FG0z7ilwcDWMBvxaK6VDnZqdJ3jx5pgg66ghW1WTkqCurdd+Q?=
 =?us-ascii?Q?RhtPn6qstB1AkJUkciSWmlS0FDIK29IxjJFQa8baio/ZR4bsW02OWi3Wuvp1?=
 =?us-ascii?Q?Gvey5Ic7zu8qRek3+CuktGSxGOI/Em0ygB19dj5H5dsn+k3pJWrS34FihTbr?=
 =?us-ascii?Q?T7Md6EcTIXA6HlIsDT3j4CQj/Mm2h0r8eF/1wselC6NUV39zh/pvXVe7vhI6?=
 =?us-ascii?Q?sSemjpMab0gt3mTstEp8wcQ5MMAma8X4mSgCEAZrtzR4AzQWbowyoJz4GsFe?=
 =?us-ascii?Q?IAw7Po7pk5hMsrHbCiDh0n9cFHdotTbLiyN+1Ir7phUwIqVeCBEOLeYlTSP9?=
 =?us-ascii?Q?nrTAL6Zf73tXoD3SQ3ofOau+zHDl2froued4dy5iOPPDqRCSKTE11XjEe7ka?=
 =?us-ascii?Q?EtgQ1K+hw8AitxVSkHmP6vgA5qxAzA60b9KhT/nFCbbbxlbymcE9N8+jl+/W?=
 =?us-ascii?Q?4G5zYHFJbuW+9qi+b/DHxdiMlely3CrqjQcknaqkIKUaLanCM9PQJxsiMNzH?=
 =?us-ascii?Q?kiiPXKPfgy0TqTOygSg6Bjd3Pf+E5wv/jXh2+ZnqoemGBfzDpdwlg3gWWi1b?=
 =?us-ascii?Q?0PfE2LPZuGbi0oIr3X+7ZCcn5yRUXimbS4chnWSRtfLGSwpJNc8OzCvEKYyr?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PM8Gqw78kenARbMRbo8iAUQs7rSY3VX1/R6Zn9FRi/DMkQHfPZHJgE0xb2LCFN9t0WXJ5tMoFkJSJaDBRfcxI8QlZGKht14tZx6OMxGcAbCgGZOT5EoiFE9tCbL+WGmO5iAfHhqWjJ95oO0Kk7D+G80vEEhjiyouiqHF4cgV2H8DpIDAuPvlKVPv3Jl5561iDFf6LISTpFk521ocYY0k/tgGBOWI6rnakZD9tVhRl11cfS6Z7+8VhygKG1f93xBvl/SwU9Nx3AuIVf+2Ap9dHjWhtAqWxqupdbsj0VVOUbfc1LUmF7elHex5dHd1oTWTow5rCDTpRy92/7BtkyjTTC1Y6AD/VMp0kJ294OSIgLtebg6TgTalrG3Kesww+5o6Qo3Q9UEbzhA4xaSW2Re5ZWtVEvtC8ociXjhg6D5xYmgX22BTkEJU+v7dVKMI3eR8g4i7wRLLalajlXJO3tRMFevB2p+SLaMPq2mpYTbEhW/sviqtNJYDiO5jDBT7OlkKV08HEq4k+DrLIs5zKZQyluT8hlzR3yOgEwuLRCWEUY4Yrclr0zi2PyXQTYOTeWFeYDTaG/ZLGzsa3mfwQPcHOFcN19KsXK1Qp5me4kISNCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fe2b78-b872-40b9-4d64-08dcb2476ace
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:38.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9RMLUJzUD6nA2wKru8yyv/ZS7fO0WJUeuqc0rTWNdICuiD1TsCrc87PwolC5jYIOxwirMLj28X7J6arH9LScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-GUID: LmTDpyI55qGTdGxH4FM03f5lr4QfTV-U
X-Proofpoint-ORIG-GUID: LmTDpyI55qGTdGxH4FM03f5lr4QfTV-U

From: Dave Chinner <dchinner@redhat.com>

When we do a large allocation, the core free space allocation code
assumes that args->maxlen is aligned to args->prod/args->mod. hence
if we get a maximum sized extent allocated, it does not do tail
alignment of the extent.

However, this assumes that nothing modifies args->maxlen between the
original allocation context setup and trimming the selected free
space extent to size. This assumption has recently been found to be
invalid - xfs_alloc_space_available() modifies args->maxlen in low
space situations - and there may be more situations we haven't yet
found like this.

Force aligned allocation introduces the requirement that extents are
correctly tail aligned, resulting in this occasional latent
alignment failure to be reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index d559d992c6ef..bf08b9e9d9ac 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
  * Fix up the length, based on mod and prod.
  * len should be k * prod + mod for some k.
  * If len is too small it is returned unchanged.
- * If len hits maxlen it is left alone.
  */
-STATIC void
+static void
 xfs_alloc_fix_len(
-	xfs_alloc_arg_t	*args)		/* allocation argument structure */
+	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t	k;
-	xfs_extlen_t	rlen;
+	xfs_extlen_t		k;
+	xfs_extlen_t		rlen = args->len;
 
 	ASSERT(args->mod < args->prod);
-	rlen = args->len;
 	ASSERT(rlen >= args->minlen);
 	ASSERT(rlen <= args->maxlen);
-	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
+	if (args->prod <= 1 || rlen < args->mod ||
 	    (args->mod == 0 && rlen < args->prod))
 		return;
 	k = rlen % args->prod;
-- 
2.31.1


