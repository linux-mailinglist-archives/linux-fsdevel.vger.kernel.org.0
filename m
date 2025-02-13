Return-Path: <linux-fsdevel+bounces-41647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CCA340FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E622116AFF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009E2222CC;
	Thu, 13 Feb 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XWT40DUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="On40hb6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10B221703;
	Thu, 13 Feb 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455039; cv=fail; b=Y4vYR08tbOMJHaebN+L5E+sKOLlTwJOkRFbYqKtdOrSYOLsvAlOavS4iopBu2JZfKSL4TC+waCpFCM41w8TSTf6q2dhjfTwjBa4jcuEYzlyG0WA9KX+EyaabMKCmMOM1Riprll1nVfq+2NHvObPG9RT8lmvKYw58s3FecYDl7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455039; c=relaxed/simple;
	bh=1M+FM/Mca5rtuTFN2lTpAUcgvO96mCawZ48BpyIzo04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T517ipgWuDv7HTcSfH3peCiYGMTXoSGryGQcjjYvviBveAsRLKP7RTdG8/ZQGOnLV3UdYZZlYB7CzNCT1adM2itwn7rionMX4R31yuq3bK7L2IhhaUSu/cfaGTcs8Bf4lxQsUxwVWs3N/37iYjAATPh8eoTB6SZ69DjliWSrMRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XWT40DUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=On40hb6S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fgK6021984;
	Thu, 13 Feb 2025 13:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O/wbJUh1s7CEXlTu6VJpmcOOHv3vNeuSN2V1yfXEZbM=; b=
	XWT40DUCqMHwpSxWq2aqDYujApbzsPvCO8rD6mSoRpdtbY8Do87EWdkQglGh5U26
	CWPCLOk4Cl/Ob1xF3zVsFcpDqD92vTmzmqkJlUIDiOueOiDgtbn4n5a6U/th5otJ
	U+Sd3QZX5nyJOFxWPlSfeklfyeG3i2lp0/y3swe18rZjUaYLAIRpWIJWlcQeK7gJ
	/ed42PCS7p8qY5Vl4ChAlGIkyy/CHmvWNn8lldPKR2vbhUu9grWfp5Z8uThy0XUj
	qqOuErXiuWrz89aYVrUeHn5klt3tn3a4Fy6ffqJdSjcefKhtWAyVU3VonFoXevIm
	Yq+z1YroFr0Ta23ltun8PA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t49jh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCSMVb026996;
	Thu, 13 Feb 2025 13:57:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbpr75-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYqK3USD2DdH06MRpDIj721KagnG0Mvkq9JILfkQr4iNTw3KkWhvpUH81Dw6w5fUwW2hguPUN4z42/9ehEbW25y8kK0p0QXkMhD6F1KQC5AxAdN1UrCmtuGl25cWDxautNM1fH9kSK287Fe4Z5MUGbzP1cuBXBidf62dIIe5Bb9qyigjGueo+bHixLi3LStVUb5rJ6pFR6WdFfCpZb2Y02gG8y31H0FEaBcQtYU0bK2kwlE961ICxTZHGSSgE/0UwjjE40Pihss8iEPPXF+s/lxQYsgHDjpNwzYpWOMe7a9NXh6OglamDOm/R+03G9Vqh6nRTIA8/0uM/6SwHci4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/wbJUh1s7CEXlTu6VJpmcOOHv3vNeuSN2V1yfXEZbM=;
 b=b32XvhoI+ST9mM+ffvfqiBSJHatKj/U+LFj3ri10BOoONOSUsH5nmBSIlfqVteUwSrgKmgOX3CYfbqvXYUJJbWvZnkx1LgG1g2Wo2pPFXRIorsZIUiMFqk+9P9ndW7GIiK7tvNOcd9b7pVE/E7qgNI5WNEWIeb9IgvzaoDwIa36ImyrqKVpCTSHaoOY3VMDRQ8f+HKsXryxUUDuF9uj2QRksUIzBUIhyI6vrW/x53kHE6etST0uWfIIpk7ah7wiBTVtWOUNTDBiGJ/POARODkGab0DGyFX7By6xutVLV0+FiK643q5o6RdjuydHp9UdD5tN9LagqWu4HzAb4mXJh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/wbJUh1s7CEXlTu6VJpmcOOHv3vNeuSN2V1yfXEZbM=;
 b=On40hb6S3Yw54/n8nmzFQqfy26svia/DLV3c4qdmBv7BpCuo7HIWeaPqhTXPbAKK+B5Y/YNs4w56n70NL2B/IrFAk19o43B4RtszoGvYScEJqAHF7tZFe7EG3a+bzzVlMurx+8lB8yUTBZgUDbSFWl8QlRJP+8R8ricajkANEPg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/11] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Thu, 13 Feb 2025 13:56:10 +0000
Message-Id: <20250213135619.1148432-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:408:141::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afdcecc-80c9-438a-2e32-08dd4c364aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vjc7QPytchiS+i66NQOY8jy9Qmz7oUHMZyuNxf4hbnRqMxwyQFOQXRnVDcfH?=
 =?us-ascii?Q?pu2OCxZADyO43sssbwCTRLxs2gf+ngrORDO/7nxdsvQdZG25SVxR8Rax3+ys?=
 =?us-ascii?Q?jw6+oT+SQ5QE15XY2yKnAJDdwyeSMBdvSVoXd+l0IRKxDjvV46YMx+eGVQxg?=
 =?us-ascii?Q?fxJ58iPTk1Lpe5c3RgVG1esTFtcW+lBiiPBCYp8IwTnbOS+oyhqB8vy0UN2t?=
 =?us-ascii?Q?QBN86FT8F8Nokjwc5HNd8FTNMUCBAeHDhrWdEmQDRjWeixEfI4cLa1s3lVVp?=
 =?us-ascii?Q?pJ5lDLaRXj2Ona8pocdR4UzkuySugNmP7TZGUHd58/ligaKwnS1jDaB5CESr?=
 =?us-ascii?Q?m3r6lRPSxzsyo1CqqsCS4WOM/ocomvHOAnFF/xVcZnqJ7VL71KwEwbJRGVe9?=
 =?us-ascii?Q?2ADLB540wXzyCuFY9GEmIc3LkbBwk2qh6IfpHFEBvQfmvcBw7p6TtM3FhsNA?=
 =?us-ascii?Q?GebjAePB1ZFy07gskcyGnzAog5s5aeG6tXtLpJ/KLugR/hg04obMxa0efC2p?=
 =?us-ascii?Q?TKbrTKiO/awX6TygtkaZv/IOcU3zx8Z6k/sb2DoJ0qkEy/FsWwNkBqFOGnQ/?=
 =?us-ascii?Q?HZZQ5PFqoKjmvN94BqxaorXqktleYM2FEVwUrrD3tp9u5YJLhThRvUiLybPj?=
 =?us-ascii?Q?4XqPBGU41EvjfYcBgoB60aV3nDzVpv+4c4xSLfsSkbTf2YHDnKCPb0LHXKd+?=
 =?us-ascii?Q?buQdk5qlQfP96NgjHGTdbJ0vkfGhakS/rOa2P2vUfkJDZ7xyPmr/lgKF7t3o?=
 =?us-ascii?Q?GyWkadltku7EusgT416Kf/bBz6hF6cOYl79o/YqcowcnY4swO078w/ndzqU5?=
 =?us-ascii?Q?TYBY1ukLu1IpN2Lkjn8/GTsPahn3Aeonw07qfzae+BQaSDFIOnJQMrmxnL5L?=
 =?us-ascii?Q?9aOgIqKphxZu9pyuG/K2rGuVSoNUzS8EwgEIsJHAlNbkYJUqysK/HiO8+AAK?=
 =?us-ascii?Q?/oKXXNxD46w96NiNsTKEwHMP8wUbsroAQtPAkw2eR0zZhaYCOUEIKfdlCU+p?=
 =?us-ascii?Q?3eNYuXg4rAV0PSPeMhMY0KxCL7hzhAxzsORQmVCA3f3ULWD9Iohdd2JQ7Zor?=
 =?us-ascii?Q?KtYRP7nGvx0hDvuz3wdNG8oNbK1NkmMYVXHwOY0IBXX7FpM2png3dazcPQCz?=
 =?us-ascii?Q?JtrZdXqM4Dqsx4DhXtZeDRAymqmNhAmdxlUTio5N+McjbvXcRlXtgNpTsoF0?=
 =?us-ascii?Q?7G5KfYph4aVTk1c9LqIi1q3e8qxCgnhC3ntn1D0jhV9o+OKwKdON0lGqju93?=
 =?us-ascii?Q?UStWPBaA9j5FOtsBAwR7eb7IKBoAjMJ8FQ3T03OLpSIX1DdmDfnl6Oac2kJV?=
 =?us-ascii?Q?jfbN3oOwg9JOPOi8QJgZZQMzfYcMVYxrfK7IMloq6+fXuJI2IgZ2ymkPS9oA?=
 =?us-ascii?Q?Cdcs0F8hsYIh205RVClLnShalzfd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYWb+SNTHiqDfOezcU4PvPUVD0i3mBWWi06DSZcsqsbMnY2VRHYB9YVUsTXy?=
 =?us-ascii?Q?i80ZxUw9iO5ra4QOBYCpgx/KppTINopmRR8s7HAVniroGEXra4JhfFiB7zI9?=
 =?us-ascii?Q?hPW1cMjGEYPRhz2GZifMAjfEotMpIzSviikClU9msYAAxXhjsNIu7QieVIiU?=
 =?us-ascii?Q?Eg89RjYa9fG/pAOLIddkzH5WxAYFStPM93YS8xgdBwjDjXNr6hSpADFNTQEr?=
 =?us-ascii?Q?zZHJr/I+9cVtX7fnSBp7Vj2f+KrsmPHZZoR6GUGSKAtDgjGJQt82BE0QxN+z?=
 =?us-ascii?Q?s48HGGV0SfXzml2TgJrzWFYpqod/mKN0rytgBm02+oVFvQoxYPo0ntPH/fw2?=
 =?us-ascii?Q?wmRpzIYCwdqD64+Z1sxNKiRNwsrRiK4aYSSLPPWdhTrsdOByoF9nbegZjqEr?=
 =?us-ascii?Q?F1+A9zk2nu1MHuPMFiRIspz6BwlvZTzKl+q9wdrMLgFNFa+0aEXmRoTVpU9T?=
 =?us-ascii?Q?19jD1sKylyHPONduBgb0TPwO1SB6SxQL3NEx4UEFP0CORQRgI78U9zR7nOxJ?=
 =?us-ascii?Q?Ls5BQxlfbbp7kJq4ZIax+Q8D6mTCZaJH4B2oVwtUPjoU0SdOjUvqrZYYVuRO?=
 =?us-ascii?Q?MJMHNfe+egRn/9e3svuYo+BNKuy3BXqHL7EFbHqi6nId94+Om7saK9AioiCg?=
 =?us-ascii?Q?4zbCWSceQ6l+0/LuqbjiOUDbEpi7CgwK2Lu5heL6dC4BakJzcaDH63RteA9Q?=
 =?us-ascii?Q?95wx2RArV9EoPbNn2OKLGh4nDKod/keNMKY9Vk1tKngqMI8s0o5uhjFeMMXz?=
 =?us-ascii?Q?lIZpFZDcSa/9Vf6xvCQBNM9f0/HQYMTbe0lQPUvbnL56rIOjDCNx17foW8Zj?=
 =?us-ascii?Q?KnnAOlY2HvKZuIcEqZDyJrG7kbizJgFaxsRIlozQxBgYsXuXVwPqY6/cA+Vs?=
 =?us-ascii?Q?+mi9juu9Yi9dTPeY+KaHvXpOcoTYzJnUTEtnuzVYsneo8IzcuLmsDrQRkz8Y?=
 =?us-ascii?Q?CqblskpAzU9MH0716rioiNmlr3DWfRa2SaKMkSjg/BSC3xLsdMOy/7MYvXHw?=
 =?us-ascii?Q?HhelwSOHUpaodGKDuiUPV+c6PA1nhesSeSA6xlf2TKVQE/LFMkgpqSyZCe1H?=
 =?us-ascii?Q?ByQKgoOKuauFK4r85fQ8HBVjYCJKgsN/MjI2a7s41NZkbKenDDSEjEwzvFF2?=
 =?us-ascii?Q?CZ6fPBVFAQD6XOpoVfi5D45HS7ZAGeC6WoYL1Ygy+d5FZcc5zH1MbR/KjGQD?=
 =?us-ascii?Q?F8UbH4r+gfxrchTFUk4S6B9vbJW+OSMXlixyypFjX3JRxp8gfOdK2F//31dF?=
 =?us-ascii?Q?AkH9R70fvZcsHPmO4IhaBhOQr23oJW7hJVOGPYcVya8Jx4d+Eruc/8sN2w/s?=
 =?us-ascii?Q?UT8P+5P09V2iVV/wdoFQeCxSalIpuYfzBJfap1vWZa/+NaBnuVB3GoH7jel7?=
 =?us-ascii?Q?dPT6lrEC9C3EgRe2/T1kD3sekTHC6moiLmjkncViZPN1tCdTbpsJDZftyARt?=
 =?us-ascii?Q?DhzBLVVB9FCNtmxCaZeRyQ3spEgmjuleiCWMH1gY5DdamuLpOJmj3jTzMzTu?=
 =?us-ascii?Q?NYWQfVefaFraBkojKRsWitvjvj3qR1nPW2s7k7ZrtxZf7+pbN/dCV0ZhTzGb?=
 =?us-ascii?Q?DFdCX3U8ugDLOHjr9vjbWsYFdczy9I4tYOx0vWHmaJkfbYV14dPUYQ2hYMWS?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ybqufgHNztkv0RCHyEVyv3iLRO8tHgBoOq11VNOFU840m7dPcGKd1d+WyaOdEyb41vS9iZ8A0lGlT4VFZu/UkRKCrUshb1ftMlLgM/iPoKEtzZb/3icBgoSAYSB1KwIsBJm6jXSL1SgikiDblOMcOvQAHKW45glsycLE2eMoNf7aAcB745kzETMC+w/bvqIMbYVjZgN567IObDCw7zNbo5svUUIv8XddxtmMS+JRnu5yDZnEaz94qPP3/M1fOxgxYHKwHKabCbyMik8KF/BOM2+n/aFFWzDfGbbvljqGjRm9hOhHRJ37ywMqoyHM4hlZFB6LrMz9RZZfGyNKPCmglbCwxdwQ4lOtx2rM5f267NPGyrve0X5muNkuAgJvc2pyXYRi0ATJtajWou0vk1hiD3EIa+PxrX8LlYbVCN1FImo/rCNaDoTPpqGf1KXFjA1AoWE8gKuOJK+2lKnPHo30vspJXztS2NT9PVH7h2RwxIrycDPB0byQ3afOP0+6VWRM4Erh0/RUGHGHF37qRdqfLC04SD22c8jWPUmQ33bAGmklFcUcUoPrZwbUvV6V2QqZZY+9Ox+dFTnrvCDWM2rVsgXBLSrYenAhQYzNVk4pAVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afdcecc-80c9-438a-2e32-08dd4c364aff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:02.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMnlh7cNeudYJo6VZ/UEYtqiOVMD2cJarjD4wyapjlPAC9jo3eNrYWKfjU98tGXkKhO/CHioncbzs+WhYw/WOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-ORIG-GUID: dgzsU46Il0Cit7QFCh-70hTTFfhx-ML1
X-Proofpoint-GUID: dgzsU46Il0Cit7QFCh-70hTTFfhx-ML1

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, refactor xfs_get_atomic_write_attr()
to into a helper - xfs_report_atomic_write() - and use that helper to
find the per-inode atomic write limits and check according to that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7a7d89c345e..258c82cbce12 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -853,14 +853,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int	unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 40289fe6f5b2..ea79fb246e33 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -600,15 +600,29 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
+	unsigned int		unit_min, unit_max;
+
+	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..ce7bdeb9a79c 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min, unsigned int *unit_max);
+
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


