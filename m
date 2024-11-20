Return-Path: <linux-fsdevel+bounces-35329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB09D3EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843A6281649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F91C9EBC;
	Wed, 20 Nov 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXT3Cw/0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a7pJ+xI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA31BDAB5
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115189; cv=fail; b=Lh7QZU8n5y/W1thcO33uf64tDH9KJNKrr+//njJHUbwJU7kaUbtS44RJmsFJGv6EO2TwI5pniMjzfcz6006oI88xPqcj85qso1pqRhSuCYiAtk1s5Djtfwcx4+h5Qa/QgJIWTyMyc8zHrf/nL+OwTxtJHlHXtqlqLhaL42sKuI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115189; c=relaxed/simple;
	bh=xKg7L8jN0K6S+Tmsb5PdVzdErSm7uCYvEuu+24Ro3qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmGVUqP4sXDsGweejU2lx4xejcuwUZ8cu1tr4d/wD3we5YsoQs6NnW96px7fA3B79zISWYw8Tkc58Li28xMeVpQe35xZt0o6DxZWjsB2qvnVta4YlofpsFMOzOQVuYu1jkP15yg8aYADD6HjCe2jOqZtPdO+GmZH3YQ34T7x2lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXT3Cw/0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a7pJ+xI1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKBMZWk020281;
	Wed, 20 Nov 2024 15:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ZimoWu+GRs9fjR3GFw
	wLA4UrmsiOhftB+EcOBmBzoBE=; b=aXT3Cw/0kOf1RPZlkqejSel9tpNnGucSRj
	i+c8u3++xb9RmzCPQY/SHJmL7tz8WjtSPmbfRge9T7H4D/VM+Z+QZwRETgLTqjX9
	8o2aeFG3+EnR6KgW5wfijXHqJOa28S2LTG6UWJwpktLt3Jfp9ZUZCBfknJiFU/G9
	cE0rZzdRCtEfAkJwYmr++eoSlVHsoPc2vyK8Ymip/JBDJZLXlZJvVjL2ne/0mhNT
	leonQecmHn8GRsm63zH4IQdqqg/TR1kmVlrCNfNM8ga2XTQzpSzJuDg4cYb29meA
	SiksgDA+uX4NshAExFZ7mD2vchgBJlUFilIb6LNoF4+kgmOrGo1Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4t40m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:05:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKEsjPx037333;
	Wed, 20 Nov 2024 15:05:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuadtks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdk91zWUMkgC4nezEVGNiNebi0iDI9fxeEHfsvAHG5DiYqWo0u62IF7pPJbmStdmcf73ogwOTMYzu9cGmuD6e/AdrIghR9DIMPNLfNXgPeWtuVYxPArU7pkrInMoEPp5tdkZnTEXPdcSYjJ3J1d1vbDC3/ItEL9v2EZLNoXdAm9xaxOuLdVu2l9WapTvKIncMghDvirehos96UYE2laV1Zqaz6+DRLLQp7F2dNTIZzV0rJG/YDNS6Y+bICIRN1hTcr4JFKFrPOWEA/E/nV9CmhAWlrFVwVj+2Y+FIP9m08NiOGspLX8R6CIsIiJLjVbynfKpV0Ncsj9mjFNv583pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZimoWu+GRs9fjR3GFwwLA4UrmsiOhftB+EcOBmBzoBE=;
 b=Y7VJZ8e+Ko+NH6ML+tilRxygKFZA33BMozhfXkfU8U93fyJ0ksydejIGJYw7gEEBmsWCvPvwuALWFA3NtXoFbO5qt4FT2gv3pqEz5eMyiGTEs5FowVhYiItikqh45Y6FOGf7gC1Mx8dheBdQhwKXRb2YMPyeTzD+tyflg6mdOvvPB/FzSuNmEhH9774Dbx/Db+RA1rrtei29DaWtSRFt7g8az5bcwFynoTdaQrH2haeQIuZFa/2FwkNN3wRgTpav/kk6wo25Sxd1wJqAZD80ga0lO+fWXVsFBcAkk8C3k1QHPwEJnistz9zY7nM3XloMgyUkY769ZHxKxMZtzkN1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZimoWu+GRs9fjR3GFwwLA4UrmsiOhftB+EcOBmBzoBE=;
 b=a7pJ+xI1mwtwzj3gF2VgEQ0OEIEdTqECq7b7SMeb7qeT/IvhrNpS/K9y3FvITCNytM3ICaMqQ0/ayY9TqMu1q8ViiAT/XzZE2DaNuMNlHOJ+1yZnxV4Fbn8iUs4E4xyZurKyL4I5mvukkmfsweW6+qDDhVA1SOkzainsThDvW3s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 15:05:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 15:05:45 +0000
Date: Wed, 20 Nov 2024 10:05:42 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, cel@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickens <hughd@google.com>,
        yukuai3@huawei.com, yangerkun@huaweicloud.com
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Message-ID: <Zz36xlmSLal7cxx4@tissot.1015granger.net>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-abzocken-senfglas-8047a54f1aba@brauner>
X-ClientProxiedBy: CH0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:610:e4::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: eed53bf2-5459-4dd9-5e69-08dd0974cf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xfoR/z3E9fW2cM/G7WAwzwYp0AMvxS0s1r/M0tM7zisnf8yAVtoDtlzmIU9?=
 =?us-ascii?Q?Ah/rIQ94rSnF2QHDhEK2BohNKDdk5btupfut7G+xhGv4wRHPql6JA7D0t2iY?=
 =?us-ascii?Q?KFMXzAlkOamlR/c+Ke4+yI2d9AY9vHkQZAfKAO9gtF8eKe1Df4PC+fO5JpsN?=
 =?us-ascii?Q?HYt4YTOV+UDbWg7sHIBwNU/Nt500wEPrnpKJ5Z/oB373jvZVj4jheC7K/w9Y?=
 =?us-ascii?Q?GF1vnJ/qs8gievYiSXt2WiJT/G0q/J0nme9fgEPrTNBGUVYlBl+ZjgpCOcn8?=
 =?us-ascii?Q?3vb72ITHfpJXpk7M2Hs1/M8dj/8pq62LuWHJbuADQ/3kkslUDjKj3NqGEKWo?=
 =?us-ascii?Q?VOx4EGlUbCGOuTkDOboyjHS6sH0Lvzl3qacP93GusLKnihYMt9IbLVFWxc5E?=
 =?us-ascii?Q?kO2DwuDswaWopgUR603qXvKm87kOVHmZlvJMkUgc4/aLzmMS7s9dfCoeO8ce?=
 =?us-ascii?Q?jiM3IE1rLtG5oB9P1X1n2Mg0QwR4FmNtmleHt7gACwyP6N0sTQKhO4NzbjtX?=
 =?us-ascii?Q?l6n0UcvAJrPPA4XGLPOjZPj4V6y8IzdW4wmA73ZXts9eSeXbFHhCLowq5I/Q?=
 =?us-ascii?Q?ra795+KQuK/GTHEhXhrnzPchrG1P5ku5L6WCoKv1+LUaxhaFTXMpEBbw/mwR?=
 =?us-ascii?Q?ihRrkOzcp1nTzxVnKBMyKh+vvb2sxoEvdxTIsYKHgKDowrYfc06/k/HQnpVv?=
 =?us-ascii?Q?2+uvJYoCRbvA8tX5mKjojgkd9YMm7qXqlhhpuMOdgdIwLw4FT7U+nUhhrH9n?=
 =?us-ascii?Q?Y7hDvrrjFRLCQiUTIemSikr8uKSyrV6Pr3leIPqUTx2OtYc5CnTaggP68AGz?=
 =?us-ascii?Q?jryKIZQF8k+u25yqsjcaGXDttTXNkgnI3p6VARDWJphivAwhKE5h3p8m6Aq6?=
 =?us-ascii?Q?qGJN/n6t8ligfCegCym/rquPsleNViLG9PeIeX5CFSRAk/Ej+PU8SCXKEE8O?=
 =?us-ascii?Q?pRLyIiLMXXLjOyhQebRZaANHNSZR2ehCdQ6rcqo2eIFCEaBUGqDo6CZ4ReiZ?=
 =?us-ascii?Q?kfGC/AGnYvISWsDEs/Pszy0AeyVpJWmvJ//yFAjr7mQTYtFMcVoP7niOrXH1?=
 =?us-ascii?Q?mRGd87XXGW6t671vEV/evU05wdelQD/TLcMYIkdftqoE+jpx0FshFlWPyyXm?=
 =?us-ascii?Q?IhB41iaUt5+PlOkaUzZjQOHisuHIAxBWyygGyzbW25EAlr2fkEgLj3sjTfBH?=
 =?us-ascii?Q?6xxbJJsEOoiYFUAOntsfVKuYcKlH52+hAZ04a9DlWnSR9OfopQo35mXJwz/8?=
 =?us-ascii?Q?Krn2ereiEOAeHBLVRWXYD+NCVg7bD1waXHaE1dVIvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/30gPoS+MzSbnwlv0KS1i18rxqA3g7+tzwfM67+IUPouGnf0E5k2MpCF6KJR?=
 =?us-ascii?Q?GKYqMh/wdLvfgSRN1vEZcZUE+rE5SKRI7Il275C2LXzJskEP6e02sWU8Y6LM?=
 =?us-ascii?Q?ZdruScy0tW/VwLI0wPeN3klCVe5rQkRiuq6OfDL7zrJWcG6GTSvvKY8zLnPy?=
 =?us-ascii?Q?/GYl1J8ckBuCpdJBdJABESM/4BARD09vxIo8kwyPFYNnkkPgRKF47Cj+DD4U?=
 =?us-ascii?Q?2zTryesIO0J2FjxOtot9ePSOUUdGOV6SD7QbnsAzqmhUWyCRpNroXCExnXG0?=
 =?us-ascii?Q?hemCtfTEPdraFp+l53QZ9r45+kiWOvxqkIERbkeyDClyMV/yL9bNZ5eZiyLw?=
 =?us-ascii?Q?S+O6e59Cqya9aX5B/sypr3GX5xtKIJFVqQm5uIJ1LSbu1KLGQHpPm3w/BFr1?=
 =?us-ascii?Q?kyF8aZsjiFkm65pAuZWvqgmb73j/tB6O68bPgb7MD+1k/TQ7fhstf9LAKfsI?=
 =?us-ascii?Q?J47fLjWcRUeni/ZOH9B+ENxtozKUNj8baKD34/l5EocsyyX+yAGUpmX6FiFM?=
 =?us-ascii?Q?3B96Q5AXf7Qar4iOalaiz2XA/Vcoy2yvwdVF3hizlzFGg1C9sGu7g/jFCCvW?=
 =?us-ascii?Q?spG6SqZhe21kMpNzkViBaIVMdie3HFxWA/SiMZVTP17rYw+1eugVufrBk4Ff?=
 =?us-ascii?Q?CdSnh328tLpU1uyuMmoA20wV4WHB7tCzTWMi4Io67lI520/dp3QazSmb47m9?=
 =?us-ascii?Q?0htTrf1YvJL7fpX7ehKOD0ptg1WpzucJCR7IYDzUVPblqpPIxXxdRps3BUwo?=
 =?us-ascii?Q?ntlKZ2BOxpqYbV7qEyDOa6bOQ4sbbvm8P5MivW4ArHxgy9qkHfmM1BKjBe7f?=
 =?us-ascii?Q?8X4z2CcaVH23xTD14upXgey7Tt3ud8hypnRjlsDnREVgwzYGhDaXJIBfE0Re?=
 =?us-ascii?Q?qsFDxJHZDmYZn3xzx5QUYpHBJYYXuQnK/J6vgwc2LECJyoWSCgSbn2Oi53P2?=
 =?us-ascii?Q?3D0YjVkDKW9eSq54aIXoAf+VT4sM/C/Df3segj2v10yJ3BQ72nzyXu9sPNRj?=
 =?us-ascii?Q?L0WfzEaR/og6qa1Qe7HeQhJZvqD+QyS55386sud1v4Px5H/VX2z1mLHXWi35?=
 =?us-ascii?Q?kfUT3QLMjZUTIrxjw7WWzJEJ3nQ1lJZXgefnCen++k1kpV+YDI95m789zi2L?=
 =?us-ascii?Q?78JNDz1lnO6o78W3mJwiONVRiuMAi8BuhjRYG+Wvb5jQad9pgN2fh5Iu9dn3?=
 =?us-ascii?Q?C8bE35W4Afe4mZFd3I+DVItaxoP6gHerOYO2QdtRYN7jbh/dN0cs+OfnkPY9?=
 =?us-ascii?Q?RWhH21/PcK3rg6pa6kQ32wMSFCBny5JYdr4nEQdAMn1ceQFT3n4XW1RFtnrz?=
 =?us-ascii?Q?sZQ0vtprVzjsZeJZOpvpSGsfpzg+Y8mxVZ/1zVPHEMKtkUEqSS7PggSVk/fl?=
 =?us-ascii?Q?KA9u+PmO2YiKmunDI6lZkGHZBovzI05UH7i5yrJlVuOPPZPxpBkvkNB3qQ04?=
 =?us-ascii?Q?4mKEnADoKUILtiGew3ilqeaTuU/ZhP0y0GMqztJWw8Fr8SWf35t3kp0EDG/Z?=
 =?us-ascii?Q?RhrtdjRL+/6gngsB5Ja4jHsbDUBxx5W/X5/t+TAtqCHlUwmClxjFriN2+GCo?=
 =?us-ascii?Q?6DdrhdhsunCg4+oYLlPwiz40+NXN3iR04+sripMa9HkfQTInGy+WDg4tzFw1?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JTtzo1tmT9S9xfNCh6LJ3q/yEzLhv8JSgPSOHLXXvLRSzc2yZ2rBIjGWw5328wGzwlxL95RsfckI5kL8eROfie824UrnfhwimnXMoIUhvXYAfMpn4GUt1cPsFuD/tL2fU9ZfgUBhSpjWeY0E3lF4Ukan0DLTwbGY380IJ3Ow3hTtbJ1RnfDT87ZGkAx6aCwJH2IROTBiVJm9guko20k9xkYYeD30l8AFK77FwjloUl7UP4bfUkxfXZjbcOZwmtlQZ2B/A3KWzVa/EJV7IWgbv1UBbqvH+1f8WUd+xN+gfjCEJu56Jo22hNOhnH9yb9xNHxrKGAnXb+Mqf0TiBRFs0legcnJmTqjhWdE+Ftjkjd6GOpnTzlXX6DlSv7li//LNI//+Pcy+5kwgbeV8hwTxZIcWsMKjS+xl8LnxRZWp+CSxg/YlCKebnlzR3Rt0srvfAa5/zi4/BhJjbmJ6mXYipDsUNVyL8UyzJ6AmEyYcCMhw0w8yFdjEHSjAGlo5G8kXu5C/bhLEJvKPpvVjaE7Viz8jMRUu1H/H/HzS1lU7TJ29vYyVZjL8aRl5w5F3OZoGW+ehJBCZufCyGuaxJaXs5JhYCtnDzl4ca2GymWiAL6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed53bf2-5459-4dd9-5e69-08dd0974cf30
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:05:45.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrdV8qlJ8hfOPV2yqppdJstl0b7SWfExJ4BMZZ4IQ1s9BBRQL5kZ47aKPANIpc2WIrAd3q7X6+Ok25s1qi6p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_12,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200101
X-Proofpoint-GUID: UQUM9kxylb230nX8rKpEMX3RDpIr3tfh
X-Proofpoint-ORIG-GUID: UQUM9kxylb230nX8rKpEMX3RDpIr3tfh

On Wed, Nov 20, 2024 at 09:59:54AM +0100, Christian Brauner wrote:
> On Mon, Nov 18, 2024 at 03:58:09PM -0500, Chuck Lever wrote:
> > On Mon, Nov 18, 2024 at 03:00:56PM -0500, Jeff Layton wrote:
> > > On Sun, 2024-11-17 at 16:32 -0500, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > The fix in commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> > > > for offset dir") introduced a fence in offset_iterate_dir() to stop
> > > > the loop from returning child entries created after the directory
> > > > was opened. This comparison relies on the strong ordering of
> > > > DIR_OFFSET_MIN <= largest child offset <= next_offset to terminate
> > > > the directory iteration.
> > > > 
> > > > However, because simple_offset_add() uses mtree_alloc_cyclic() to
> > > > select each next new directory offset, ctx->next_offset is not
> > > > always the highest unused offset. Once mtree_alloc_cyclic() allows
> > > > a new offset value to wrap, ctx->next_offset will be set to a value
> > > > less than the actual largest child offset.
> > > > 
> > > > The result is that readdir(3) no longer shows any entries in the
> > > > directory because their offsets are above ctx->next_offset, which is
> > > > now a small value. This situation is persistent, and the directory
> > > > cannot be removed unless all current children are already known and
> > > > can be explicitly removed by name first.
> > > > 
> > > > In the current Maple tree implementation, there is no practical way
> > > > that 63-bit offset values can ever wrap, so this issue is cleverly
> > > > avoided. But the ordering dependency is not documented via comments
> > > > or code, making the mechanism somewhat brittle. And it makes the
> > > > continued use of mtree_alloc_cyclic() somewhat confusing.
> > > > 
> > > > Further, if commit 64a7ce76fb90 ("libfs: fix infinite directory
> > > > reads for offset dir") were to be backported to a kernel that still
> > > > uses xarray to manage simple directory offsets, the directory offset
> > > > value range is limited to 32-bits, which is small enough to allow a
> > > > wrap after a few weeks of constant creation of entries in one
> > > > directory.
> > > > 
> > > > Therefore, replace the use of ctx->next_offset for fencing new
> > > > children from appearing in readdir results.
> > > > 
> > > > A jiffies timestamp marks the end of each opendir epoch. Entries
> > > > created after this timestamp will not be visible to the file
> > > > descriptor. I chose jiffies so that the dentry->d_time field can be
> > > > re-used for storing the entry creation time.
> > > > 
> > > > The new mechanism has its own corner cases. For instance, I think
> > > > if jiffies wraps twice while a directory is open, some children
> > > > might become invisible. On 32-bit systems, the jiffies value wraps
> > > > every 49 days. Double-wrapping is not a risk on systems with 64-bit
> > > > jiffies. Unlike with the next_offset-based mechanism, re-opening the
> > > > directory will make invisible children re-appear.
> > > > 
> > > > Reported-by: Yu Kuai <yukuai3@huawei.com>
> > > > Closes: https://lore.kernel.org/stable/20241111005242.34654-1-cel@kernel.org/T/#m1c448e5bd4aae3632a09468affcfe1d1594c6a59
> > > > Fixes: 64a7ce76fb90 ("libfs: fix infinite directory reads for offset dir")
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/libfs.c | 36 +++++++++++++++++-------------------
> > > >  1 file changed, 17 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/fs/libfs.c b/fs/libfs.c
> > > > index bf67954b525b..862a603fd454 100644
> > > > --- a/fs/libfs.c
> > > > +++ b/fs/libfs.c
> > > > @@ -294,6 +294,7 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
> > > >  		return ret;
> > > >  
> > > >  	offset_set(dentry, offset);
> > > > +	WRITE_ONCE(dentry->d_time, jiffies);
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -454,9 +455,7 @@ void simple_offset_destroy(struct offset_ctx *octx)
> > > >  
> > > >  static int offset_dir_open(struct inode *inode, struct file *file)
> > > >  {
> > > > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > > > -
> > > > -	file->private_data = (void *)ctx->next_offset;
> > > > +	file->private_data = (void *)jiffies;
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -473,9 +472,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
> > > >   */
> > > >  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > > >  {
> > > > -	struct inode *inode = file->f_inode;
> > > > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > > > -
> > > >  	switch (whence) {
> > > >  	case SEEK_CUR:
> > > >  		offset += file->f_pos;
> > > > @@ -490,7 +486,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > > >  
> > > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > > >  	if (!offset)
> > > > -		file->private_data = (void *)ctx->next_offset;
> > > > +		/* Make newer child entries visible */
> > > > +		file->private_data = (void *)jiffies;
> > > >  	return vfs_setpos(file, offset, LONG_MAX);
> > > >  }
> > > >  
> > > > @@ -521,7 +518,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
> > > >  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> > > >  }
> > > >  
> > > > -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
> > > > +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx,
> > > > +			       unsigned long fence)
> > > >  {
> > > >  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> > > >  	struct dentry *dentry;
> > > > @@ -531,14 +529,15 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> > > >  		if (!dentry)
> > > >  			return;
> > > >  
> > > > -		if (dentry2offset(dentry) >= last_index) {
> > > > -			dput(dentry);
> > > > -			return;
> > > > -		}
> > > > -
> > > > -		if (!offset_dir_emit(ctx, dentry)) {
> > > > -			dput(dentry);
> > > > -			return;
> > > > +		/*
> > > > +		 * Output only child entries created during or before
> > > > +		 * the current opendir epoch.
> > > > +		 */
> > > > +		if (time_before_eq(dentry->d_time, fence)) {
> > > > +			if (!offset_dir_emit(ctx, dentry)) {
> > > > +				dput(dentry);
> > > > +				return;
> > > > +			}
> > > >  		}
> > > >  
> > > >  		ctx->pos = dentry2offset(dentry) + 1;
> > > > @@ -569,15 +568,14 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> > > >   */
> > > >  static int offset_readdir(struct file *file, struct dir_context *ctx)
> > > >  {
> > > > +	unsigned long fence = (unsigned long)file->private_data;
> > > >  	struct dentry *dir = file->f_path.dentry;
> > > > -	long last_index = (long)file->private_data;
> > > >  
> > > >  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> > > >  
> > > >  	if (!dir_emit_dots(file, ctx))
> > > >  		return 0;
> > > > -
> > > > -	offset_iterate_dir(d_inode(dir), ctx, last_index);
> > > > +	offset_iterate_dir(d_inode(dir), ctx, fence);
> > > >  	return 0;
> > > >  }
> > > >  
> > > 
> > > Using timestamps instead of directory ordering does seem less brittle,
> > > and the choice to use jiffies makes sense given that d_time is also an
> > > unsigned long.
> > > 
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Precisely. The goal was to re-use as much code as possible to avoid
> > perturbing the current size of "struct dentry".
> > 
> > That said, I'm not overjoyed with using jiffies, given it has
> > similar wrapping issues as ctx->next_offset on 32-bit systems. The
> > consequences of an offset value wrap are less severe, though, since
> > that can no longer make children entries disappear permanently.
> > 
> > I've been trying to imagine a solution that does not depend on the
> > range of an integer value and has solidly deterministic behavior in
> > the face of multiple child entry creations during one timer tick.
> > 
> > We could partially re-use the legacy cursor/list mechanism.
> > 
> > * When a child entry is created, it is added at the end of the
> >   parent's d_children list.
> > * When a child entry is unlinked, it is removed from the parent's
> >   d_children list.
> > 
> > This includes creation and removal of entries due to a rename.
> > 
> > 
> > * When a directory is opened, mark the current end of the d_children
> >   list with a cursor dentry. New entries would then be added to this
> >   directory following this cursor dentry in the directory's
> >   d_children list.
> > * When a directory is closed, its cursor dentry is removed from the
> >   d_children list and freed.
> > 
> > Each cursor dentry would need to refer to an opendir instance
> > (using, say, a pointer to the "struct file" for that open) so that
> > multiple cursors in the same directory can reside in its d_chilren
> > list and won't interfere with each other. Re-use the cursor dentry's
> > d_fsdata field for that.
> > 
> > 
> > * offset_readdir gets its starting entry using the mtree/xarray to
> >   map ctx->pos to a dentry.
> > * offset_readdir continues iterating by following the .next pointer
> >   in the current dentry's d_child field.
> > * offset_readdir returns EOD when it hits the cursor dentry matching
> >   this opendir instance.
> > 
> > 
> > I think all of these operations could be O(1), but it might require
> > some additional locking.
> 
> This would be a bigger refactor of the whole stable offset logic. So
> even if we end up doing that I think we should use the jiffies solution
> for now.

How should I mark patches so they can be posted for discussion and
never applied? This series is marked RFC.

I am actually half-way through implementing the approach described
here. It is not as big a re-write as you might think, and addresses
some fundamental misunderstandings in the offset_iterate_dir() code.


-- 
Chuck Lever

