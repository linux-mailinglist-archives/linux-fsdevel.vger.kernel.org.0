Return-Path: <linux-fsdevel+bounces-43863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C3A5EBB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CF17AADE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108F1FBC8A;
	Thu, 13 Mar 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xa6Hm7+4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GC8qKsNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48B645;
	Thu, 13 Mar 2025 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847299; cv=fail; b=QCtXvDfMbNbWYEJQyRrkZFq6+FW+2Sq5ZSISPrAkQmPEke+ymn3HFn5c3fUk7dZB3WXNA3P+EWZDyOQX8UwATfcLCWtCZK9K4fHzwF7I6O061S3HSsTvpBpNvL08qwmcJ2TekIWJRWeoEevazRs/57Su9mCTjqAaDY3Cs0dpC3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847299; c=relaxed/simple;
	bh=8NI1jCvb+3f1zcfi628Bii87GrNyMHBPtvhlkAM8/xE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pAkVFqFxye5jXIys/gs6hL+BvuMhOckvffPyMvbowYpO8+HC84p2DY+9FO9qbPvtPqukCpD+zsNECHO3ZSfXtq/zOqoiGsD2ETfI3yKetW8vKptYBD2io4xXUL2/n2lqF91UrqCdLIbleWH7UrWqLnNKDOKVjaWR7LhLy/JrsC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xa6Hm7+4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GC8qKsNC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3tmaq012816;
	Thu, 13 Mar 2025 06:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=spliFINQdmTCLemSU+wlao6gY1ptow3PxRS+UHQnojk=; b=
	Xa6Hm7+4zTFiBkbaZFHKDn2IibD6Xn/pNLeRNjwTE0FpviUEUdG5x89nvjTrQsXW
	veLXL/yqOIe3192CtUbb0D+2godyr8LOVgHpv3SmMyjqfzewA7iQcXbjUo1bBsmO
	UB/qSDeXWsHp4JJKr/4SkP9fqZMpaj9Bew6Eh+9M51FyzGeFFD0utHxDrTha3MFw
	0xiWipmLlDYkqH5syoSxHLZnlplr1SvQISKF3qTsBeEALX8jU1kkeSHjW2aGeFxJ
	LMk0mdTRTYVOv16wFPgbWPOr85tZXWovXNs55nOU/R5gU68qBDk82u88Y5+1PtGB
	tD+s3xL5R/bS84+Sr1EV0w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dugt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 06:28:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3rYEK008647;
	Thu, 13 Mar 2025 06:28:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn49987-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 06:28:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO7a2pBDovs47JjFfax5uw7PnxtX+5RnE9IFmuGGt5oVzvg/fZC25X+P/k+VZki/XPjS3XpMauTSC3UplDTptcjUaY63Z+HpnnW7KY9JkXe1c+w1rkodXjOzw44nHPsffBuW1Z+q+989ueaZyOs/N5LfD/E8ndIzcxXHRskh2W+bnVLjKMv34chjrrvpWbC9cB5jaT+Uk6IeIlJuqWBawfqWtsTWTVnMmzaplweaKAMeeUHx2PcZ4MlBmo4ZaupuHc6YncU72czlirq+jfx8MFvJwNukC6KLN7FY3Moxeigh4AFMDG2/tOKSTAi4KjS5tEC0LB1fwwZju6zNY/OcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spliFINQdmTCLemSU+wlao6gY1ptow3PxRS+UHQnojk=;
 b=v7oQeH4js6PTBuk399ngR6PCmCn/7xBp/Mze1D4VH10y4sSuxySvzWwsbQL9gmJGiy3sv+3pYfFHhxsfmS2N/u0rj5ITJCaRBWJQVoU8q/L/dz2X2O31azK8Vz8dKamIYVSnSKKvUnEjamw7ssN35Jl7r47Qk4LKtja0/KIuCOG6yfmuzmsQfPUxK68U8pAN0uCSiQ21QkLFEAaYuO/Uyv03KrS61cupSUw3bIVE8iAm/aStYdlm3xmdEuiu93wzgzYYME0mGQOKFphCRp2sGePgcQun3gSsV5K8meQw+J+4ij4gMGqFTOYkyCViLr0FTAG3Gum5p4WjeiiNngvjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spliFINQdmTCLemSU+wlao6gY1ptow3PxRS+UHQnojk=;
 b=GC8qKsNCa6Gf7rRaRLbM662m0op1c3sT4CIHTzcZU/WXzjY45dkPT4jdtjXA5yKK0ZDR+QYwKmGufeXkevOCZo/mX2WgoDLlojDnHgDi6G0wYQFPWAEsJ1XVzrbFnAUbOb0PLJcdnuGch2Eo9p2lqLolngZ1PWEItBQ7vtR8DNE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7647.namprd10.prod.outlook.com (2603:10b6:610:169::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 06:28:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:28:05 +0000
Message-ID: <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
Date: Thu, 13 Mar 2025 06:28:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
To: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org> <Z9If-X3Iach3o_l3@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9If-X3Iach3o_l3@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0364.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: a82c472a-4066-4be0-9567-08dd61f836d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThBR0c2M1hMajRBM24zRCtINzk2M3RYUTRQbks3VDYxMy8vcURvb3o1OElT?=
 =?utf-8?B?aFVvQVlIOE83Y1hyVTNneDVQNlpvOHpNeDhDd1ZqRnpZUHZ6WWNKTUMrMitz?=
 =?utf-8?B?dTdMV3dEVlB2VTdCVEFjRll2UWtibW1LeDFJSER6NjBiMUJQY01tRW1KTGFh?=
 =?utf-8?B?eUxPaS9GaXJKTlhYemlxZWV5OGdOSWptLzJNV2FkL1dBY1ZONE9tTEFPSWVJ?=
 =?utf-8?B?NkxPK0paeEQ2Z2lOcFYwd1hKMC9ZZXZIalN1L2NEelptMFNjT3ozVEtQYnpB?=
 =?utf-8?B?c1NGbXUyZlZQZnNmcm0yQzNRajVod3NGUzY2UG5ySjh6SzB1SkZKam5VQm5s?=
 =?utf-8?B?YnF0aXAwZ3ZIV3NwNXNWdUs0Syt5a0U5Y01UMFZDME11SDIrTXF2YW9kVUFT?=
 =?utf-8?B?YWczSVo1NitXaTJqK2x5V2E3ZjBvRFFOODJFWE5vTWx2M3pLU3A4Y1FaN0Za?=
 =?utf-8?B?cWRmNEdULzlHU1lKZy81a052bTl3WExQT1J3OXAydFFGV1R5R21FZVV1eWhP?=
 =?utf-8?B?OGM3eEMxa3c5MGFLV0xZYlNEMGlFSmJ2V1lxMlRWbkl0WU5rWW4yVUNFdFkr?=
 =?utf-8?B?OTVQNHBSdytxUTkzNFU1VHRYc3JHRXJLdlVwTk56SHYvazNLZW9RZjhVWUQ4?=
 =?utf-8?B?VzNPQTNMekV6M0VFMk8xMW9meTNhaVBUYjRjTTA1YVIrMWxLbU01U1JVUytE?=
 =?utf-8?B?OXZMcUcwSGxQd2VFaTJ1cUU5ZkEzSUEyaTdYTVo4QXdBTElFRkorS0lrTEVI?=
 =?utf-8?B?dlJ5cTY2dDA0b1JMcXhuS0VDY01kTkpZTHBrdm1jOFhpOGQxdUQ3QVhTWXhB?=
 =?utf-8?B?MFN3enBzOU15U2orUFYzUnJHSnVMUmtWMjkzRG1aRmFkTjFOR0xRbjZXbXB5?=
 =?utf-8?B?eC9DRGd4Tlg2bmlzdnFiQ2hNQldPdFM2Zi9YVThmT2NJbjErTkdxV25OOER4?=
 =?utf-8?B?eEFyZVphdW4veEhoeVdGaFFyOHQ0UFhqbnhvTTVVQ01xbnZ0UVRzZ2hDaHZ3?=
 =?utf-8?B?SUN1bHVnbEwzU2REN1VTclFzR285ZEJrNWhpZTg4alc4akJ0R3RkaURsTWRi?=
 =?utf-8?B?NnA1czA2cS9Cb1ZUbWl1cEdyNW1KSEFYQW4zdHpoQno5dW5uN2RvSlNWQ2hI?=
 =?utf-8?B?czh6UWU1anV0Vlo1TmhHRGRuRG5WYWxaYTJjQXVmd2xBVitnWnd2WS9GYkpK?=
 =?utf-8?B?ckRiRjZUczdPM0ZCcVIwSzJIWHFlVDFzOEpNSHhhcXRNVk5Hb2k2RFpuNDZH?=
 =?utf-8?B?K0UrQ3FmdlRzclZVWDliWHh0UnpBZys4UXNIT1N5UlpndStTOTBVRnlySGI4?=
 =?utf-8?B?N3JCZmEzVHRZQkVJOUxNekJjMEE5RUg2VVBxMU83RThrQm9xbjNqa2FoZExT?=
 =?utf-8?B?ZjdRZHY2eFV0TU80ZEN5aFZNaWkyaTVIZnpHVjFUNGR2djhieVF2WE5CUVo2?=
 =?utf-8?B?UHp4SEVxcjBRaDBiZ2lIWTlhUDNjb3FLVkJhcDhEVUpjTGpBWHpsOU1Zd0Nx?=
 =?utf-8?B?d0RVenNYamorMHoyWHh5cTE4eUdaOWlKVVQ1eXAyVE91cTdoOVREY0dPMDAr?=
 =?utf-8?B?c2czclBBSzVhN2JCbyt3MkhXTHFUVFhzUFlWRktjcmlaM3hGWmQ3ZFhTYVla?=
 =?utf-8?B?SlNnSnI5NFhheEhpVndYUGpaV1ViY1F1M1JqYkRKUmRKTnlRcnhreTJDVGhX?=
 =?utf-8?B?SExsRmh6NGNCUVlaNTJxT0N4OE1TaTA4N2o4cVd1d2tZNEY0d1hlcncrVm9s?=
 =?utf-8?B?NEJOTUE4YW1PcXdUckI3R2FyTnpDWWVpSVBGcERiRUs5a1FjeVlkci9BQVAw?=
 =?utf-8?B?YWNFTzVaOFZ6M1lhM0pZNkZWWHFCbnVvcVVhQU5Oanh3UWZnYmtrWHBiK0l6?=
 =?utf-8?Q?tYGoTWQH4XOe8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCsxYUovcFY4Z3JkMWc3T0FONWVSRHVhT2xHM3FEaUpHakx3bTB4L2ljeFhD?=
 =?utf-8?B?RlV4Sml4K2QrdXRLcWhkcHVzRjFhNXhGdzdXdlBVanlrdXFTclVqdEtPa1Yr?=
 =?utf-8?B?b21GeG9JVS9HMG9iMFJwYlovanlDU3FJNGd6dkJOeVdaaTcvTllUdU1oMGVu?=
 =?utf-8?B?NVJSVkxMQXNsQUtySVIrbVlyVXlkeDFyUVduMFFzSTM2SEwzVW9IaUlLb1hE?=
 =?utf-8?B?VjNiNjZlUDFBemVCUjE2RWdibVp1c1ZqNmRibklWVTdRcm8zZ3BlY0hkcGIy?=
 =?utf-8?B?dmRRNFN0cURrMzMrQXNreFlrUVZUVzFnSnUvcXU2SXUydDJOV0QzZ2hnaVdy?=
 =?utf-8?B?Y0ZNaEUrdWVEVUw4M1ZBM0pEaU9YQ2FDR0JCUDFVa1RnNjRocVpkUjZXVmNp?=
 =?utf-8?B?TnBpUlVMM055K0JkUTg5Z3BBNUZLLzk5U3VsRm5vRlZwNmx0Vk9rTDZ2VVIr?=
 =?utf-8?B?SmlsREI4WGtIVWN0SnRUbUJ1blZ5cVo3WE1sRm1MU3JUckZIK1BFbVRZVnds?=
 =?utf-8?B?bXZlL2loSGhzdWNpaDRlT1BnQ2ZUTU8zSnh0b1MxdTlrNGdCR3Z3TlZwdHB4?=
 =?utf-8?B?NTZNTXNYTm9ZaGZibHFNMFlPY2ZTYzhIV2d2MUVoV0lyOXhhV0lKVGFLR1A0?=
 =?utf-8?B?UGl4dUoxVWZ0c3l6UHF6cWJkUmQrRXJtRDBreWhTeDlnRmYrTUJZL09saGk5?=
 =?utf-8?B?UjVrTWkvc292b2FKYy9lbFgrSFB2YVpSNmRoTHlDZFhkY1REam1hVGlWaFMv?=
 =?utf-8?B?QXV1UHI1UEIrN3ZWYjZJMnJCYWhxb0RRNEkxWXNHWTVjWGhzdWpZdUsveEF5?=
 =?utf-8?B?K1EvUHpkdVFCa3Q4RjRQTWFTSkZaT0JDSk12T3l2N3B2TDd5b2I2RWtQRHcr?=
 =?utf-8?B?bkdnVC9zZ3ByRzhua2lDUmZINXVVSDhxL1BSd1Q0eEsvK010cWdFMHQxYTZJ?=
 =?utf-8?B?M1piTzJ6VG1NNDRobjhWaE9UZGQ4bUNhTVhrMVlqUEdBcllMa002T1ArQ0M3?=
 =?utf-8?B?dWx1aDc1YTYzNHdHeXY0U1RROFB1MnJlTWFFZ1VmWVdYQnpaNjRqNXRGVWdN?=
 =?utf-8?B?dENZOVQzQXV5dWQ3dFI5dmhaRUNzVkxYN09maFlLRTlwd2YwU1Q3N0cwaVlE?=
 =?utf-8?B?REErT3lFbkZqYkFoVGdZQk1UbmsraGhwYTJyWDkvMUVOVi9CWHlnUWtOckR1?=
 =?utf-8?B?Y2VXaHUxK0daNStDdGNCRytNL042SG9rZmlOUU9rdXZOYkl4UldTK1B3R2Jm?=
 =?utf-8?B?WHV6OVhLekozNUhCUTNCTERzQytoTVVNTWkyZ2hBQ0RvZE5RaCtrT25TMVJB?=
 =?utf-8?B?YzJYUXloay9mWGdmbnNWZnVsd2FRMnlFbVc4bDdQQlR6YzBxOW9HUnk2U0Q4?=
 =?utf-8?B?Zkl3dUxCc2dFdW0wOUlmbVZxMGxnV3pmVHgwbUZEWnFQeFphaGJJTEJOOThZ?=
 =?utf-8?B?dHdiTE5hU0dEcExxYWNFNkNrcEpQRXhWVW5IOG9DK2cxelZJYVFzdzBVV1Iy?=
 =?utf-8?B?Y3FPUnZYRlZ4Y0drcGd6V21VbVZLUDkxSVVFdFliaFFhT2F1V2JtNHpGbTdm?=
 =?utf-8?B?YXorTVNkSWlhR1lyWllyTTBrSmxuVjgxbWpyRVgra2RPK0xVWHI5OGJVc3Bk?=
 =?utf-8?B?RVdzYVdCU1UzYmNJN245VXlPdmNXOEhoSGEya2xTa2NJd0xubW9JMFZDTFB6?=
 =?utf-8?B?cmNUOUQvMzh3YTJPWVdleCtUcUViSTNZVUt1L3FTTlphMmdRUngzQ3RKU3d5?=
 =?utf-8?B?SURIb2tzelZNbTMxeFdGS2VmZXVBNG9BNnJTSmVKZmFWRkQ5VVJTZUoyYldK?=
 =?utf-8?B?LzFEMG1FUUdVVTZ4eFp3em54ZmNHQ08wcHo5VjJJQVdzL1NZb1pzUGxVWlkr?=
 =?utf-8?B?TkJMUUF2S2llallXZVNTc0FwNFVMV2QrNFFESE43eklIOGtnM2hMNmhvVUFN?=
 =?utf-8?B?R0lkOUp5WlBLM3oyNEFSRitqa0g0WmFta1ZwZkgydllETkJJWGZDeUs2YU1W?=
 =?utf-8?B?TlovMzhEVCtrR2V2ZHFsL2xGQk9rVTlFdldpK1JPN0VPdms3cW55MVUxZDBI?=
 =?utf-8?B?clRjL2hCR084YWJsN2FsL3FNTU9uVEErY1oyT0JZbWdRQ2tuM1A4TVJFa3Jh?=
 =?utf-8?B?VTBwdGNIdTdXSnFRMnQrVGlxQURxbDg3aWFWU3NYMmcyNDROd1N0OVkyNm5m?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bsu9a+p+1p7qbdNgaeijnBHGwGmxcLcgm/0jIy5hIZ5z/D2di+zWY9gflpBmE5BKsCopQLmo9zDD3GGKuMDczCPbPI7h1mUXgg9XpcOyhqor3hMKPUrOv1J9MEfsOIcxY652IXGlThr5cMAsFey+jTdx/3EyJs6oW5A6NK/CtLfJgoGi8YEjz+MY7NhNRYBGVifb8Z1U0pcvghzH8rISKtRuTmGnZfHZGnLpSJ79M2fbjXlTulFfaIKr/JpY9Oh2HEhqtH5ZkIiZMcnIXcK75U3zV5hNZE5Alt9CiLkOvOkzIANviwNMI3Q8zynMSiMmB2gHa77kr5YVLd75TVf3cfyYZYUw/Xqfl7A1uS6MDur8638H7ztiPLjio/62bqxIzLlD/WwtS6dxlj1rC+O1wSffSUHWHvpyGbYnTuZhyg8bhWu9v9AYoPew5q12eT6Ocb+SPpira2OysTDvcGEnfORQRO4JCqXpikhCDL7Jb9ZhF2JdMqPFWGF54B74DaAs0J/mdlrV1IRUpVjFiBh9QnB644IkQX3KGWLwNnHs7KFVZMAKjnWuMfztqUsrzGro1Qe5p+ggVz7HLRyJ3PM1HH6lSunTp9K4w5pGZSS5VTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c472a-4066-4be0-9567-08dd61f836d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 06:28:05.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0HpibMtW2NdleaBJ548mVwlgwXIuSlesv2e1wkcInZvEFTppelHpRqd2tAxd8DR+ZStGLbAUWNVv9ImlHB5tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130049
X-Proofpoint-GUID: lfRQ79ZuVwEUuLZOZjThZ5HuHQm_7lPw
X-Proofpoint-ORIG-GUID: lfRQ79ZuVwEUuLZOZjThZ5HuHQm_7lPw

iomap_dio_bio_iter()
On 12/03/2025 23:59, Dave Chinner wrote:
>>>    */
>>>   static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>> -		const struct iomap *iomap, bool use_fua, bool atomic_hw)
>>> +		const struct iomap *iomap, bool use_fua, bool bio_atomic)
>> Not new here, but these two bools are pretty ugly.
>>
>> I'd rather have a
>>
>>      blk_opf_t extra_flags;
>>
>> in the caller that gets REQ_FUA and REQ_ATOMIC assigned as needed,
>> and then just clear
> Yep, that is cleaner..

This suggestion is not clear to me.

Is it that iomap_dio_bio_iter() [the only caller of 
iomap_dio_bio_opflags()] sets REQ_FUA and REQ_ATOMIC in extra_flags, and 
then we extra_flags | bio_opf?

Note that iomap_dio_bio_opflags() does still use use_fua for clearing 
IOMAP_DIO_WRITE_THROUGH.

And to me it seems nicer to set all the REQ_ flags in one place.



