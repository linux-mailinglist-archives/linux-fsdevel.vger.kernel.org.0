Return-Path: <linux-fsdevel+bounces-24821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7B9450CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CD51F28C95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435961BE852;
	Thu,  1 Aug 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eiZlTWRD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="blpxOJrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A431B9B5D;
	Thu,  1 Aug 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529989; cv=fail; b=fY8dhh+pDo6l2bG3uIg99qBfolcVHKIaTsJ00CoflH3Qa0CCTUOJXharO3StDat8CPg3Gawb3ZI12x/CRB4dJrTBcAiY1M+30gqQf5aX2fPoPneOcmRcuTED/cHD2L+VTaYnrbiNeoItCdIw1sMPSeeZNFbjD+Ef7PkWX4biq/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529989; c=relaxed/simple;
	bh=kKixtbCsgmYyWkkvplpexW1J1znwLLkmBFdC94PMiS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/Lzzztku8Vghow6AtVveJF59YOA90ds6uNBeqGnXoHLrsC8y4V4E4S8NjJMR8cSBj7ce5xHX+hI/zatesczQPbWARsBQbejVlIZYE8A8wGObL4o494DaYnaZ3H2wHnA69H0RgL2Bwc2JY6UESVoCZ9LyeagPcAIOu3GU3sywGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eiZlTWRD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=blpxOJrt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtUOl002511;
	Thu, 1 Aug 2024 16:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zGlHm0yX8TuYFKRUvbqZ8nfy0EEKrPkjhdyhgfCxWr0=; b=
	eiZlTWRDyIu7XUElQXctxV0iJP5o6b/TRAIkDt+47JGhtJ1Ueyo6LM36pGeorgbc
	Z5b78/FzECLdSD4Z+fJUA81L/8iwf1sjeoJPohZUGFlbxV2Ezdvn6s4iwp8xXrGn
	21MqMh2EK78wq5dp7VHshXFCFW+KIC0MZ6xdAN/h8NeXvFNYJa6QV1ACDxceWdm7
	8hooJNOFo/tnpTQuNbNTSpyNdVg9PCmx3x4YTqjeC15bt49QglFaLgRy5s340rcI
	X2N107yF2azELW/Tk5f34aq2JvVSTAeFnWSCHvW3Lvn3CO3Vs2Ol7XAxkAaYAsJy
	baQgcY2xswfUn3lCl3pthQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msest6t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471FNu3A030932;
	Thu, 1 Aug 2024 16:31:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehw38jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6q8PteDra70te55zpYpAy2Z89otPSn4J1U2jqGC60v5MVID6hyXwjjVgSOUHy7YYPDGbTtkRvQ+y+JE6iCnqNSKx6//JBX/f1dTBpZbrGR3rEn23OlMAs6dKINVkPfpC5FfS8kLWjirRaEyta3gPyUtr+wdj5O8FEp+ukNzxqKAsXdNWRe9sI0cT3UMb1FF3VISFyCSSj95mCtDOGev9se+CmzJM9V9rcHV3+azdnMUWdHXxTOOn3ZZlybBrvW0FbQAak8jHQUEbtM5WE3A7ti7GXawP1M30kRjwI+Fe0G6IqB0F9xZmg+P6FQuu3Bc7CKfjqgLLk2LTLKBuBXmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGlHm0yX8TuYFKRUvbqZ8nfy0EEKrPkjhdyhgfCxWr0=;
 b=ZApu/Jhx0UlslmDLUvUP/qquKHq+ijTUiw2dazL4lfp6V3FkF4QFNcR8ZcxiFaYtZgSw0nXwHhtVBK5jUU4RYGg8EIHK6igOyBRzoQJDOBQj7Y90HUwmxwRvlpkmWQLvjIKfUNuEeM3SZkrakon3HxYGMFpRj/oNZPJt7Si+u09SzZQgCXfEUgVIVNCu1YCr3SLWQkCf1O9L9BvdH/0g4H489stI1EbR7H5Rg5VpN/smw2Y1rWM2eokWHXAX1O3HiUWqr8ARfAb7YKRgxYZRK5+WezChmJRAqOuMA4/ZDBEeYFfj7RKPNM3WrWIfUGZ9ecgvVzcEADUvH/9b8LWPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGlHm0yX8TuYFKRUvbqZ8nfy0EEKrPkjhdyhgfCxWr0=;
 b=blpxOJrts1yAfCg0nQBlfA7NrEqzsBVPurkzaZU1Tv/ZMMnfDqyAPgfgaFd+BNBdHL+5Isjx6PuocyqkIU98dCVyrJP3yaBvk8zealIxb1S2Td9wDpnRH75GSmKsyswtX4799SKKZ6DUEWJp4jFK7dWRLOnG4Mx94kldEs0FRA8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 12/14] xfs: Unmap blocks according to forcealign
Date: Thu,  1 Aug 2024 16:30:55 +0000
Message-Id: <20240801163057.3981192-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:208:a8::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb0e3d2-ccfb-41b4-d42c-08dcb24773c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwrQbCcAzoh0zZgPph23ubWavg1OGDWacKiqo03/k0xKdiThN5swALgDRKuu?=
 =?us-ascii?Q?LxI8sJIApX2GkP0R0RiGMUN0nWIMHeNAVSTmZPcOvUk3c5P6YfocgiO7uGOJ?=
 =?us-ascii?Q?WU1q1bXY/lneJR/34lNzMkmgS71+3N/bQZvSOHkTZlEN48qRYZo+YTVEfUk4?=
 =?us-ascii?Q?xQaIWQTpo7eR35gVpWiMdbGEnfrCuiqVErIBV9EuBIc0Jc00Jam1wegh5Vdi?=
 =?us-ascii?Q?p+KjhKwYdkSyyR9lU9waBIfE5H+VV6O3tw7XeqlSUMlPFJsyW2JP91qzciPh?=
 =?us-ascii?Q?gxEyPwaoMZ5EWmjvvlGsg93RyVU0tSdMSwaKnN9XCAazTa1BF7f+m5plKaCY?=
 =?us-ascii?Q?jq9Jj1TRlPofI/2ugAiMEqkbDXQ8v6N/NALQS7nYky0hjtoME5cZOWE9PsO1?=
 =?us-ascii?Q?CSFly4P1pBY4GFfqbSph2bDuIJuTZEzGtnolI64b3mEKT9YX2DaJXus7Arw5?=
 =?us-ascii?Q?aXkdrVW2UdUPvwFxEu8iA3x188+b87TD7EgQC/NyX3OMLcbY/W0BoUceOELv?=
 =?us-ascii?Q?0U58twV30+8tKqLIkLH8RbMMRqp9vb1EvBhsGwnYSywN8YCADJu8O29wDAZr?=
 =?us-ascii?Q?aPocroG0N66Ngj11jdpde7ITkcg6cUeqFwh281VWNInxNko+rk7Y2u1O0i6B?=
 =?us-ascii?Q?wOSMgWMEESkjWKj5vgdyKWh3D/xtJK3lReMMMyHdbVCFApiItRAjAFBZJDfk?=
 =?us-ascii?Q?LXycbNDGFMYQF4zVUhglTdHQG68278x6L7mctxROda6L4sbZfuBe4OjD0Kv0?=
 =?us-ascii?Q?omvrugQ8R3AR/Libjl9uyH2W1VJICvHCata+dvewrQ8KxSJdy+hKhOCCb7WL?=
 =?us-ascii?Q?yifVTzv0PTcHMNMY2ZVZ2/TZm4IQ2BPW1vcMcWm0OxOg5IVRCGKqeag2CiAE?=
 =?us-ascii?Q?gAzfkcibt1QEOA081bAZIWclkLvxgozJhHuGL3J5XrT1hnmwsDj/LnrR6ztS?=
 =?us-ascii?Q?36eCVYHE86bCwzffT0qjAiRYd669VWMndRr8vrT49uOQ24khcozsMIClG6cU?=
 =?us-ascii?Q?CUoFTg9n56XbB4zRZq7+HMZaXXjAKJrtTRTNOGbfYQ7CUHSTKq4aCJ6KGaU+?=
 =?us-ascii?Q?nUaMuYtIu03OY+ednbK7qMOKGGE/QF1+bwMxudMfbaALoTbKTMXy0sbqIpJw?=
 =?us-ascii?Q?Ml2erpym/+QZ+vLzPWWGnKEKMG0AUOMRjwwJcIJy+o23Gg+VPRsdhHoeXSrD?=
 =?us-ascii?Q?JK2B1U0GtO6LVf2+wP+DcblAKNs92AH+wovA8Yuy4emu4dCFsKE5AzsqwnUO?=
 =?us-ascii?Q?b8ZoquZZfHp6ZLNEEWouK8cn3/erdwv7DysgFoQZn1lGpDn5NtsjcAQwl9Sy?=
 =?us-ascii?Q?B613YprRqkm91IOil77hoBaYbJexm2Kvf9RwaRtlwD8AsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjqoQv5y8Upw2EYNIDIbe8IR8BwWg5PWLdZZh+3nE/o4+cIkhhGR/fKIrMWt?=
 =?us-ascii?Q?wwQV7wI2bYUzgxoqENGXu17hE692lxPCt89Eewvp3e/8v6AWZ2bFG3oTGnh0?=
 =?us-ascii?Q?u5Kmz3S4D+GpZog095q02ixLK5LFXVU7eQig9tCUe3R1wwog9785lfLu4Aqm?=
 =?us-ascii?Q?VwEPDhpsl97G/HakX6K4Teb7MEXLkNTd/4O0SuOqUWbvgndc0h5wxaVsdo/I?=
 =?us-ascii?Q?OsgOKbVck902dZWIIiaOY+uxeWMbgpHgdlVzHXsvBUcIeRC2lbHsVhLaPhwi?=
 =?us-ascii?Q?gngzq3Ap5+yhPOWHfptiIt0rNLBBMFbrfq2+HJJb/hui+iACMycMFD+MDOL8?=
 =?us-ascii?Q?omBphA58iPYzT8NLVhSM08cuwezjwF23hjAPfR1nRjUrEfXxbfuuiClfDjwa?=
 =?us-ascii?Q?s3yMh3foa34P0tl1EQ5BiItPgX8n6SC1NxW+R7L17Pmd2e2EDCHW8KwEdFos?=
 =?us-ascii?Q?4bf7DQl2Ly6QYN9Az4qT9gR9U+lVrLONs7P91hdARqGbpKQOJH3J9dwuilJv?=
 =?us-ascii?Q?ugKf6QLVXacOT2xPb3qE4tekRNra+DU6N9H5Pc1zHbztqtZdlBUkcEDXkwGR?=
 =?us-ascii?Q?P2kMNZbMaof49ndV2l58db+XA/j0qe3XCrj3nu3rdm0lHLofsYeQcJa/j9J8?=
 =?us-ascii?Q?Wd6KUamYOsiKIu7eV5VVAncJfMHXvlbigBoDpd4SB0XNScYa2byb+LZMQJfF?=
 =?us-ascii?Q?L6YOhk4eZBuLMYvfG4XcrW4kFYacZMONtxMBUYY6opnW3H066Mwi235R+uKY?=
 =?us-ascii?Q?Q90RCjk3PhXsN8fq+z+gb4pN4u/v7qdYNXmcQBVs6XZkhAQ2g7iPGHM6bCey?=
 =?us-ascii?Q?uhCq6M35uPIdRsy7fj9J16VRhJKRCSYC/YatMBUb+pjwCoScpOV3r+ByLWrv?=
 =?us-ascii?Q?UP5CdK/BbiTrP9zJhd2JwGSRbsfiLoqLQA69yuC8tK2O1vWV6ky4jxGeh0JQ?=
 =?us-ascii?Q?sU4O/NiOAOdDmOU62BUBJ459QHa/XbxsAItzGczj/F4LcYeX2WbusIb3X7QO?=
 =?us-ascii?Q?N0nU9RtfPkzjxto9TTz1Mbx3P1LdYUF8kSPEWZwL6XBCBAsF4YZOrojySL6Z?=
 =?us-ascii?Q?Rw41jK8ezg7EkcdUvxSJ/1fxj6gVsOGzaXOJZPACR6dsQ0rHmk7L1Gu2YV0E?=
 =?us-ascii?Q?0z/cYxHtmjK89ppjz4qMDzcncVJEKmQaj5c8X9dQL/tsZ+yXxH4YHEF0h2uf?=
 =?us-ascii?Q?AfI5iYoEKi+hkDwnBiGvmKlAiye65+RjKoqqYCTtrUUwQxqZmY1LcHoZKVnQ?=
 =?us-ascii?Q?OIkoXCvw2OEj7Rwp+EbgBu+7y+PQfQHEai1Z9tVXeJXzy73P2BDVem3hqdfy?=
 =?us-ascii?Q?dT+JvOjokPbzwuWN3VaIdQKXbC+1MlUMvXVTSJ2MXS1srJFhNcManOEkL0j/?=
 =?us-ascii?Q?vhM760KBsfS4c15SulGSw41vOWly48Lny1X7KHKA44JiwBO2CIZFN4fxv7Zu?=
 =?us-ascii?Q?tQdZnWNN1ZaJTO9+Q/3TfCHDxrGmKTdJVJWloKrFoY0vNMjPeVBNDBm7gaCt?=
 =?us-ascii?Q?+up69Un4kee9A6dlOy5EcTOlMm1z3HPobJR+aIBXl86TUf4PB38fYYpXynww?=
 =?us-ascii?Q?lYKqZJmKQzk1vyoUKuSE88Bj6+D/JyNfH8FIc2EqLIPcCO4K7ykGjueJRnY6?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KM93j73Wtj0SCXRA3ZavxvMdy8P5enmqg3o6XDD4iCd8cOqcdbZHA5ZcxmvLTxLg6rqydcz3N41Rkgc1Jk8gr26fz5OInLI6jyqObmhP7KlTlkuIF/P6YbFPQpNljvvzHfzn5eZME6N+Bd5LO3FkXxdPk0SdCPx6UzqFmN2SByNDi/id4Uk0Ei1aOtOW73B+EdKB8lbGR27Ijk/ZYr+dr9EKtTHIvPIrh1FhlLth63yLDosva+m5AzwAVO0TcsaFCxtaRimwGZNcA//Ohip9GeQCaQJ6F91H0k/HuOGPgWFZwdcNrZ20HDJq1TBaZL6yhukasUaI3d/w0MU/xE0HCE4eOitrwZzwtXO6VJdywpBdOLOmQbALVN1iXeUVfB3E6DOhikg+ENw5568CR/+HnmdU/ftIOjKza+BhL3Jgrv3u+wq5qKYmDHIo6BWnFALxSJzVzkpc3g0t57xVuo3oa6rPDBlRwQN7W775B2wPsFCHSlTkUdI/Y3LrO1L6lEgmwN1CRpusgEb0bBUzAI4IB9EYBy7+aSVcrTlREFbfiFtju8Amsq+F+JwzyxbFLs1LyauewP8lFzoxiY76MsOx0Qig/UWc4mgZ91r5ne2t3g4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb0e3d2-ccfb-41b4-d42c-08dcb24773c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:53.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDbgY60TVYfVKlOixOH6cStitSHBZl/A52uXgsm/S2ppR7a6qS8iK5PjUL+RIU2xBtpK/49A2L9ozlZcUHZtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-ORIG-GUID: ouyBfu0dReZsUXnGp2M8onDS5tHCfSKc
X-Proofpoint-GUID: ouyBfu0dReZsUXnGp2M8onDS5tHCfSKc

For when forcealign is enabled, blocks in an inode need to be unmapped
according to extent alignment, like what is already done for rtvol.

Change variable isrt in __xfs_bunmapi() to a bool, as that is really what
it is.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 48 +++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_inode.c       | 16 ++++++++++++++
 fs/xfs/xfs_inode.h       |  2 ++
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0c3df8c71c6d..d6ae344a17fc 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
 	return 0;
 }
 
+static xfs_extlen_t
+xfs_bunmapi_align(
+	struct xfs_inode	*ip,
+	xfs_fsblock_t		fsbno,
+	xfs_extlen_t *off)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return xfs_inode_alloc_fsbsize_align(ip, fsbno, off);
+	/*
+	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
+	 * is not necessarily aligned (to extsize), so use agbno to determine
+	 * mod+offset to the alloc unit boundary.
+	 */
+	return xfs_inode_alloc_fsbsize_align(ip, XFS_FSB_TO_AGBNO(mp, fsbno),
+					off);
+}
+
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
@@ -5430,7 +5449,8 @@ __xfs_bunmapi(
 	xfs_extnum_t		extno;		/* extent number in list */
 	struct xfs_bmbt_irec	got;		/* current extent record */
 	struct xfs_ifork	*ifp;		/* inode fork pointer */
-	int			isrt;		/* freeing in rt area */
+	bool			isrt;		/* freeing in rt area */
+	bool			isforcealign;	/* forcealign inode */
 	int			logflags;	/* transaction logging flags */
 	xfs_extlen_t		mod;		/* rt extent offset */
 	struct xfs_mount	*mp = ip->i_mount;
@@ -5468,6 +5488,8 @@ __xfs_bunmapi(
 	}
 	XFS_STATS_INC(mp, xs_blk_unmap);
 	isrt = xfs_ifork_is_realtime(ip, whichfork);
+	isforcealign = (whichfork != XFS_ATTR_FORK) &&
+			xfs_inode_has_forcealign(ip);
 	end = start + len;
 
 	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
@@ -5486,6 +5508,8 @@ __xfs_bunmapi(
 	extno = 0;
 	while (end != (xfs_fileoff_t)-1 && end >= start &&
 	       (nexts == 0 || extno < nexts)) {
+		xfs_extlen_t off;
+
 		/*
 		 * Is the found extent after a hole in which end lives?
 		 * Just back up to the previous extent, if so.
@@ -5519,18 +5543,18 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
-		if (!isrt || (flags & XFS_BMAPI_REMAP))
+		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
-		mod = xfs_rtb_to_rtxoff(mp,
-				del.br_startblock + del.br_blockcount);
+		mod = xfs_bunmapi_align(ip,
+				del.br_startblock + del.br_blockcount, &off);
 		if (mod) {
 			/*
-			 * Realtime extent not lined up at the end.
+			 * Not aligned to allocation unit on the end.
 			 * The extent could have been split into written
 			 * and unwritten pieces, or we could just be
 			 * unmapping part of it.  But we can't really
-			 * get rid of part of a realtime extent.
+			 * get rid of part of an extent.
 			 */
 			if (del.br_state == XFS_EXT_UNWRITTEN) {
 				/*
@@ -5554,7 +5578,7 @@ __xfs_bunmapi(
 			ASSERT(del.br_state == XFS_EXT_NORM);
 			ASSERT(tp->t_blk_res > 0);
 			/*
-			 * If this spans a realtime extent boundary,
+			 * If this spans an extent boundary,
 			 * chop it back to the start of the one we end at.
 			 */
 			if (del.br_blockcount > mod) {
@@ -5571,14 +5595,12 @@ __xfs_bunmapi(
 			goto nodelete;
 		}
 
-		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
+		mod = xfs_bunmapi_align(ip, del.br_startblock, &off);
 		if (mod) {
-			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
-
 			/*
-			 * Realtime extent is lined up at the end but not
-			 * at the front.  We'll get rid of full extents if
-			 * we can.
+			 * Extent is lined up to the allocation unit at the
+			 * end but not at the front.  We'll get rid of full
+			 * extents if we can.
 			 */
 			if (del.br_blockcount > off) {
 				del.br_blockcount -= off;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e7fa155fcbde..bb8abf990186 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3164,3 +3164,19 @@ xfs_is_always_cow_inode(
 {
 	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
 }
+
+/* Return mod+offset for a blkno to an extent boundary */
+xfs_extlen_t
+xfs_inode_alloc_fsbsize_align(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		blkno,
+	xfs_extlen_t		*off)
+{
+	xfs_fileoff_t		blkno_start = blkno;
+	xfs_fileoff_t		blkno_end = blkno;
+
+	xfs_roundout_to_alloc_fsbsize(ip, &blkno_start, &blkno_end);
+
+	*off = blkno_end - blkno;
+	return blkno - blkno_start;
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 6dd8055c98b3..7b77797c3943 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -647,6 +647,8 @@ void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
 		xfs_fileoff_t *start, xfs_fileoff_t *end);
 void xfs_roundin_to_alloc_fsbsize(struct xfs_inode *ip,
 		xfs_fileoff_t *start, xfs_fileoff_t *end);
+xfs_extlen_t xfs_inode_alloc_fsbsize_align(struct xfs_inode *ip,
+		xfs_fileoff_t blkno, xfs_extlen_t *off);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
-- 
2.31.1


