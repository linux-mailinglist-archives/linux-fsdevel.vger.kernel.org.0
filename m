Return-Path: <linux-fsdevel+bounces-41653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB0A34124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43BE3ABC9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BF271274;
	Thu, 13 Feb 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4lijmu/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LHkiMbJb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB226EFE5;
	Thu, 13 Feb 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455049; cv=fail; b=u5Q9SEw63R/wlpnnKy90dKfPSzMtfbw9A9rKp/ZMWOnTEbyBai1hBIzOIpRk1OjTnQjJ5SB4BirmILd0ekTZGzyO9sjGbZcBGOuD/tKQAh2siLDhEvtBfvlkD7bjK1IBHa2bPRnLxT7HjrhYGRQw0KPeDVgadHnRZR8itI180IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455049; c=relaxed/simple;
	bh=Fa4IDMr7Nec4FlDIhSO4NAT/HCQ1g07b3qKvIA6WNF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjiGyRXsIsoy9QAG5bhvsRIYQQYKT7kz71PSW2nOwGgywPLwam486H4pShG59iao+c1/51M7kUxK7xMGt2fJ/Q/lbrxQUx7/77n+iMT24MhaQNYoBB1cs2wq5cWILlZzhZXsgYsDUYkIZ8zkfJmOxZBUCfBj8n3eipK2rSwsOB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4lijmu/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LHkiMbJb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fm8l015190;
	Thu, 13 Feb 2025 13:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LMKRJTj/3PHWnmcxCVILbZh1p/+4xTMeQ6Vim3Iq9Cw=; b=
	l4lijmu/flN3/KVEYa8khFJa35eaMSyaPLzzjnfczliZWUHU2sGarqfFIm8gNvNP
	oYT8p0oFn2gyNA3cywPkn1DINyqZuPgrPBoUvNMK6v7vaPGOCJFbDcvkELxPadLE
	Z1t26bGQrl8DTXW0Zn0TbAWO1YGXvV7D55fyDqaj1/EJAPccfwNDZj3s8jC7baHd
	saogPgl1BAFg0diF2p1ICEz7jVpoioRrLT4xJbibC+n7oTCNjRmVdDY3fDYeur3b
	JooHSUFingDPKyfLJqD7cg3+BCMqwnxdXI2XuZjkyA/2R8M289FF+VN+n33GS1nZ
	Geg4599FlNPwPlPi51rMUA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hnp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCwq5o026955;
	Thu, 13 Feb 2025 13:57:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbprcm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubdhxe5v8zljzcHznJnrC4H63u3tEPM3RsC2fJpiKRSqEFndmOXQM46bea/75Fky8VxLV2GLwFZHrw4xNDxdMv1aa68m3AzYusgieTNANsy8RXXQci8L7doU+d8uHpLt3T9XuaELplSj3Y47ZEM8gSoh5PHU1exxGersv1YFiSroS1/hvSCgS04Xq+9ok0IrsyERz5u8cPqe1ouRkq2uD8uTjvWyVdZGOdaL+A5Ae7io5FAwF4Z1ukFM0flbStdwmlMVHscKGvo6DtVWKhU0T77NjrjxA/YV9Jjr9UuCtmrQPhAdL3NMcNVrYN0OzqWUYqM3l+AmR3x8r2+EqoR/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMKRJTj/3PHWnmcxCVILbZh1p/+4xTMeQ6Vim3Iq9Cw=;
 b=Y5xuEDV6Oq7mxks+7zaY0vVksA12FVsg9hszvGsuDHssd0Z36O3oxsS/jmwISOflC2TxCZSItN6IGQKt8Ymmt5eMSoSkffZdtAgxR+7sTZRxAdnGw2mPAr2ahYTkQ8jSdfoRRr6NcX19ul6Rqrnupl36yLOKMFBTRi/+iGLlr21hT2qa84Mk1H7OllSTPRcZ7V6n7M2jg6JHA6TQO7R3GpTXjK9ol9jHG/tNe7+zEo007rnDcndMw44u03aiTtn8xR1x/e94L5DqxylVCyyWXkFQkLRInX8nrhsdO836VK+JVcwhWbAlOu4dEnvCekPh3t6r3Ffyso9j2rZtmekQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMKRJTj/3PHWnmcxCVILbZh1p/+4xTMeQ6Vim3Iq9Cw=;
 b=LHkiMbJbvy5ygiZc8uEkppr9bWL9anQfNpHkIA+kAkEZBJDa5cW/ao7e7AhXSo3QEz7bE9QjrDMMFpMFUtDDmImeCLXbqNxueSyRlFAJhl2IFp3BJixIjnu9SHVuHOXbvdSVjW50ZyZCIBDKqlrbZ2LbYjEJ+efNP2tz4BHEM9w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/11] xfs: Add xfs_file_dio_write_atomic()
Date: Thu, 13 Feb 2025 13:56:16 +0000
Message-Id: <20250213135619.1148432-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:408:e8::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaed0c6-634f-465b-027b-08dd4c365062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VOUhfHDNKnTElcz9k1/5O7hmudZQA0/cDENjws1zXjbtUffl4jNhNOhUKBkK?=
 =?us-ascii?Q?phOgNARYDmA399iMPRYy44S+nrpEfqkQDJKOD16pO0IvHb1jTX2HjVLb3Szs?=
 =?us-ascii?Q?b10aCrDujPjCSjdWvAHyYdlEAghbhjNXLxJZUBNcSHPBH2fAVpgZ4teXVTjw?=
 =?us-ascii?Q?IBuA7vaLzR75idiUteK1jttc3VTtvdp2qazbBqxRo55mtvnQwWAGbpVl0lrq?=
 =?us-ascii?Q?jbpJFWzgXObBhj/LC4lGiceQwRfpsSeBdYkaFb8hHGgh2z4SjoIl9cMWJ6Z8?=
 =?us-ascii?Q?LHGQdhL8h+dP7Y5shEcLAidomtS34ApMcqxPHAzrWZ4fCGWXlD06e23CE+gN?=
 =?us-ascii?Q?W9BJIT1KhUVkjIdHBQ28h1BA5SH/an3WY0RX7nAgjzxOZ6/P/X+6++rMapo6?=
 =?us-ascii?Q?4Xc9H+d9CY0uqvQoMDDgz49f+QNQ99Yeelf3aQufdJE6TB6IlE/tqyEl7dyY?=
 =?us-ascii?Q?7zm1+3T3HXAVDhKHuMZGU45BlIz2gm83A/hwmhrgpRoL6q4A+xPpNNpKwOnn?=
 =?us-ascii?Q?cN1kK3sy7KfRQHojlZIAx3NCmiWDfwAe/CtDUWU6Za/NZC99VVQ/HnL8WbWa?=
 =?us-ascii?Q?oyCFEkwqx1d6ezL01pFSNzcarLx9kKNXsXEgJp2ME7hGOOUHH/n5jLhLdKm8?=
 =?us-ascii?Q?c5vq62MvCdSh3Ne6FpmzBl8/IJqx4D+KLmEO/SCFLuJJUMuKpH8agTre27GL?=
 =?us-ascii?Q?C9Lc1uSZa7ENxOokcPwX64MlqMTPJwhusJ1Hl4aB4XXZvEGKUmA/Oz+Q2U46?=
 =?us-ascii?Q?Lltz3O5bWMGqSY7kyQlGg4dEB7ehWRxtR+K4j/cTMKLE/4jjjcSgsjceXSry?=
 =?us-ascii?Q?E55/4DCu1Rep34xMEvQW7mYdZ8knQF1Y7aGRiD9Jrg8Qbf3u96EuBlve0ppm?=
 =?us-ascii?Q?KSn3pJOudC/wByBJZ42zsANC3DsYAF8scNtVuq52DBM9J+Lw/S6O4y5hAalW?=
 =?us-ascii?Q?AfUj0/7PLC08hP1eDn8gcTePW4dVoMu23yEQ2acKwrB8BDatx76woI00uu2H?=
 =?us-ascii?Q?I++CGzOPsX0zliPJykMHiDNq1V45ZybCtOmNOyoBOSOeUi7uNuEDOqBn8ajh?=
 =?us-ascii?Q?T43Q45TOrU9Pn73Zkr8m35JTM1iWJzsfplV4Ws8CbeZnOZOJdwdUxeLgQXiV?=
 =?us-ascii?Q?rrDYzV6aCBzN/bB2u2gbQKBR+vUrGqsRWR7Xc02cVdmofK9ULA1AziyxsW3k?=
 =?us-ascii?Q?P/jtnKMTMtigADILGURCPe8Th1+5wuCOB5HOHIij/N2OTVg5Yiw9cumlgNI2?=
 =?us-ascii?Q?EzK6hIwkgvwRYNfukHIC71pVXFdwzA3ghvdY2ZttcHyl33AFSGwSgVYUXYCv?=
 =?us-ascii?Q?T7pyC3AE87AuyP4kLeOZWAYyKDIlki5Yk9L4CvPm3jEJe7sJ82pUF04CP5G2?=
 =?us-ascii?Q?u6r5eXW3lfDcEjKAKBiv4FHWWpBG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xInkpV5ytYveJMGMzQ/UNASVG9cejA9nWvMyL4LOHw4F6pexaqP69RmiRoW+?=
 =?us-ascii?Q?NFjMl6Q6/w7vjxAcNXrMSMejd1m8TWvwvff1fvsJTMsuSk+9h5ipSnNsm7UD?=
 =?us-ascii?Q?NNpBE0YDjAgG91YqYbuW1E0duVRe2zPzsfyEqScFk9eolS+rrpFy2mBNN8ga?=
 =?us-ascii?Q?LgDWmc5vyFKprG8uDTN0EU4eTq2lDdVqWzmaKw8WWMf7zsN0vaYcuG54nk1D?=
 =?us-ascii?Q?IHdVAoPqT+ZGAnmo7lSVWpaFuttog+/IkIt2RQgnvCxJV3Gm0PicD/+Nw5jI?=
 =?us-ascii?Q?n5Y9VAfa56P3B7N4l7cSZjvCE2hNQW0IlmbTZjZ/B7SybrEYFhoj3TbfsS7n?=
 =?us-ascii?Q?BCzHhMStUQvA24Vzra3ADq3Jvp6HJjZmX7HU8J5ND/rNTc56/9Yuk9+MZ6Kn?=
 =?us-ascii?Q?tt7npWK54QsRXZioSry6/sCxaRf26XMAMfPU1vOoB1HwuCvJep7R1ANQbUKt?=
 =?us-ascii?Q?nfnKe9Gcpihg4sIRBuOlxhg987R3ppVCSwBcwV4WKOPpZ9/fJIzj/XJ08poS?=
 =?us-ascii?Q?n+z1unVrunUtSX8XGj0w+Gg8C+xtRVTdLWhviEKOmet0mTjxT4qfNUiQS0av?=
 =?us-ascii?Q?PzeobDczdX/8FnMKhyv4sBPTP+MxBHLxXv4AFMC9PVcQJnGVlPCsupN+jgvf?=
 =?us-ascii?Q?Hjj9ETUMPh4X+GyRct1hpUSWW/Hzy0eaEW6iBGbm7SY/nfS2ON/n1MZHFDkZ?=
 =?us-ascii?Q?vFtXsXW653l5OuO5hf8/PEwiy5P4GwaFg5eeb+5kjSWCcXIQQSNKPU/lbdc6?=
 =?us-ascii?Q?B1LEE8XGByekfuKLOY3mkqzYQEnD13FWg6wcT7rjMaCjkvDfOFEZjWGNj41v?=
 =?us-ascii?Q?jrHc/N80xb41sa27mgGa5ajfsY7DZ92xSEb16lcA5kCGK9B9GDA3L7XBcYvE?=
 =?us-ascii?Q?6UagsdWh2cDtxeiEoXLP0lza4m0dZW6EbxDX3Yi9tedOjf13tuTdCfwsf19k?=
 =?us-ascii?Q?bmke1yVEz5SHXijHh5RsI1k6hA4SYc3UEtf9121/OL5L+vqWXWJPE1jarIU4?=
 =?us-ascii?Q?2aCsXHGj8RsPz5mgMx6qSbmzUWsQiqBaL7KCUHB0GQFmPmQcLdaTjhKsDKZi?=
 =?us-ascii?Q?xUrEGD4wXV9lMlMzmyrpEol9oVH5GLPfaPV8h9HwsrTEXHocEb5fmdnOkaSd?=
 =?us-ascii?Q?2Kafl/t8Vp0Or5lJWBnPD3B2FBIVJukeJkN3Tj00Y18dPxdxKFdGuQ/mrELN?=
 =?us-ascii?Q?bcA5Oqdh4ElCHNkyp9UFrHvJjRYavBUVu4wR2BeWrdIoTZSmPMZ08kHou2ha?=
 =?us-ascii?Q?FQ/LnM5h/pmbr1f3GCgtlWLpRBsVASg/FPNIAZ4JPPB0E/Oi9eY3L+m4cUtB?=
 =?us-ascii?Q?+Rn1jPc74sRvyzAb4xABpwmKmIEyLM0PSGZ9RhdQw8gk+Nph2E/URWrYbpy+?=
 =?us-ascii?Q?6Gp1c2BSO/7kMB3y3D/J2hmfdIW6qCzgKwKHYdUhdXUlF/qcYSHUB5oZM4eA?=
 =?us-ascii?Q?IG7PJNrHXxbmAlOSdaaB3t3e+SeuyleKw8wbVgWLg/EKlJlzG7InC2+3CfGc?=
 =?us-ascii?Q?1V+UdCTJJI01IU9EpRaN22G4G+MD2avioGtW12yjJU60cLG1WKjvfphOIBib?=
 =?us-ascii?Q?2zORJkbHBE6FhEXbCSyeFw2f9SzuBHVQmrPg6MGz6ANC+8WgOeL28qTlNwy+?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5yoMoWiuzlxIGEjYDYaJzEN2h8K+V0TXpJVQIyrRxpI9NQt0DADrGErkFA09/vG/aONJTSOxgzjj6YbS0E7eBMLfUWMPpwUJfBUqbE+rl7lX6Hiwmw+t7mTEnV5aPCoFX/N2Nwg3wtsXqSxmeIWH23NGQxIVl6wM3deKz9jVEG35YzEQYZ31kn4ivUEQA565ng9qZaP43rHiNF7LQkhxhRuIdoYmsQSppnX3oAT4iq+eIS/nPmj4V2IOT0G0nbEZAI4mn6+xE5zLvrubPcE4HJtLeNcPqHawlhbUwEjI+l52Tqa1FnPMptRI/THya7Tr45NMD8lyQ4UEqUkCSLGlxC1s9vaxL55SnhgRXxcUcVa/gwAjOEtkOlhjUsqnc73j0BTSd4iRT+XEsWoLK/7yR9KItzpMFo8iDFyt+s45k6vUYHNiTJx0rzd2US2S7vfNip96UIdt6sNX+Sdt+0C/Ri+EThG/AjToic0RlMRRHbpy5fAMRlH+PG1FvURe0GJLGoMccCk/K6slQMsL1YEXwsxE96OP7FQ3IOpx9Uq2yUTejxxaqjDw/ySaXeHvvskSdJdJy0j41GIOrvMrIhuLlz7NnTqtV4lwZ6WzAEKzvdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaed0c6-634f-465b-027b-08dd4c365062
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:11.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7s+/TULKJlMNSI2oRwFmeI+KRtlEADRo9AnNea4XMhQCe1ky88f+XMzsebRdi9sQi82F5dOlho3k66yvfcKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: kzg6AXxd8-TYo8CyGFTrZ7SLrC2tgcoQ
X-Proofpoint-ORIG-GUID: kzg6AXxd8-TYo8CyGFTrZ7SLrC2tgcoQ

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

For CoW-based mode, ensure that we have no outstanding IOs which we
may trample on.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 258c82cbce12..9762fa503a41 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
+	    !(dio_flags & IOMAP_DIO_ATOMIC_COW)) {
+		xfs_iunlock(ip, iolock);
+		dio_flags = IOMAP_DIO_ATOMIC_COW | IOMAP_DIO_FORCE_WAIT;
+		iolock = XFS_IOLOCK_EXCL;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -723,6 +763,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


