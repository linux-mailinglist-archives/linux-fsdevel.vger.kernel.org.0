Return-Path: <linux-fsdevel+bounces-48108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55AAA9786
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765A67A1D73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359B25DAF7;
	Mon,  5 May 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FR80vsvI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6GBdmpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB224A069;
	Mon,  5 May 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458908; cv=fail; b=BYVBULLTYencb0E1ez1SsQ9BKmTAq6icbdBIViCior7o9/cTsoYTeVjmeFpK48PTfqkJEZIA7TCbOidSH6h9bGSc/2wbOvWVSzTS9Kjg83gZVJxS6kTlLq2zghmFcBQ096VR4cXTvQWTE/rLBqYMYa1iK2D+NJgseDI7pd5J5io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458908; c=relaxed/simple;
	bh=OEqlahyodQMWdHyDx9uYQsaol1jO1C/ZN0sjZZ4Lplk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DZQWr/6r9TrcBCN7VNdeLCxEuUrGkl8eKOlqMyTp2Of9Vu9bmYCHEhauCaUsUzvyjhoBjAsSC0i47St2xjtt2TkSp5+65cjiK/ubY2vVoB4wcgzOUo9RDgGwa+/b2RuFvxKavFg4X/JUcBmLW+LODSqsn4BDJd1kTCKUeeXcNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FR80vsvI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6GBdmpM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545FMwlZ031785;
	Mon, 5 May 2025 15:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0bolS9ZYfqqj8YCwbYBadg4mNWZRNk2gpsM32jKKl2o=; b=
	FR80vsvIV8KNEIb/5/xRB/Z6ovTfKweIWja/tksuR8s2CIaDJsCj/HtWlD+6N14L
	3MwdnOT7KjE+VXzxeEfYaPI2idC9+8iTT7R+q/3+Vi/+D7xEEdXk7MmjqavR/Jdg
	qzxaxKy3HkEAIR9mMBWcxynagqISBrQmae0dysoHTcQWmSPHDbGSQKiA8GqMcsHN
	JZ/iJ1Nk9iJgvsXGdOLVOGBpf6rIjkZItSIL/0n42baCSbgn+erbvoC2Skzl8WUr
	E6s4lECgEuRAhQa3EFOOnt51WVU4ml1nSW/z/RLB4Thh7dU8UcgzgJqDSxAmNr5X
	3/vyRWGwDie/Wh3ooUqzfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46eypa825x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 15:28:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545FDvIw035355;
	Mon, 5 May 2025 15:28:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ke2nev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 15:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cya3od2U2Rkr+wFzbQzROnlYoZSbFeOefOPytMufzf5mtAjW1jq241iaTDCFa1R1FzhDYujop5MIiwuZ019OhnbYQIT+BNrCH0Qkm3E/8tyWhqBE0diXqDkj2MAJYmpX7pxC/OhXEB9g0QHjH9yYCq7YfNdRYlg5Dvnj9jsvdaZDIYUwGB0RuLl6B3BzaLFMHVeUKXABpWJzIjixVQDjIEJfyLPBPLjgvdsyOyw36phst7ustpV+Jx7egRdDSz1mr/xb+antwY7yJRoA1WjpHAFuL1LB0CXkeaku2IGmw3N/mMg8FggJpF2OlTpZpKnlgk+7H6NrhlPIxsN3c7UrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bolS9ZYfqqj8YCwbYBadg4mNWZRNk2gpsM32jKKl2o=;
 b=li2wEi6qqdGz44TTl1RHFlA+rpV+0h6QQn1vtj93z3v7lW5tdWxWC7hvbUCFvRlZVYGM0zODEcopYjvPBdII2oLRZmq9zwG3i5xT+YraGqn2TJOa2wT63Vnt3WuklM8+zscSGCygUl2xshQauxVXDFz29rYckgThkGE+Mjyhkf9v7i9hnq3sjy1eGBMCPjfNC6uFzFLrkJDZXBS8A0OzymtA5o0HLWaVwdjaaZ4TDX1ULlNPXHMOVLHrqRzimybHbImi7XuPDlj2MK+SMR4sOqMQW/D3OHKJsmwhssJY3Q6oQcHqLYq6chKi/cD2smpBFo1V083l132/9WrxrDoQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bolS9ZYfqqj8YCwbYBadg4mNWZRNk2gpsM32jKKl2o=;
 b=U6GBdmpMhA6MCPrjapAvOEC0lU2aXZTqRDy8nwfR5Gn1e2T8VQ+Ds4YiRh0FtUF2VNN3XOoLb49O9tG/whaE8y172hwtTIQXnVe5cA+DiBiE7uubOGC+Vz+OwLC19qSYSzumGTZ2h+ZuPOoGmJ63XYS6jVNC89mWiEnQmUwYia0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4297.namprd10.prod.outlook.com (2603:10b6:5:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:28:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 15:28:00 +0000
Message-ID: <200d855d-550d-4207-9118-6a0c10d14f8a@oracle.com>
Date: Mon, 5 May 2025 16:27:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
From: John Garry <john.g.garry@oracle.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
 <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
 <20250505104901.GA10128@lst.de>
 <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>
 <20250505142234.GG1035866@frogsfrogsfrogs>
 <40def355-38db-4424-b9f0-b82bba62462b@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <40def355-38db-4424-b9f0-b82bba62462b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fc80bb-f6a5-41e6-dbac-08dd8be96b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlcwQ21HdkxLNjJSaExDRTJZTGNhVEtDY2lKVWNCbU5JMzZ4aW16MS9VK2xk?=
 =?utf-8?B?Wm10Sk5SK24rVlYwcFFoc3NOa1ZXQ2RpdzVzRzlXVGh6NzAvL3Q4OVorcU1F?=
 =?utf-8?B?SVhlZXNHazNwUmdyOXhSc2pFZnk2Y3ROWm1UeUZQNGQzMEVWVHh2NGpkaXA2?=
 =?utf-8?B?U0RTR1pOb0haS1BDdWhOUm1TangyRHpuZ1FucFk0elczT2ZmY05qNG9LUWE2?=
 =?utf-8?B?dVVKM1RoNGVjcmhianQ3S2FLMmI4dEk5ZTZIQko2VlQ4MnpyWVRDejloVmYr?=
 =?utf-8?B?YTZueWlSQ0VZT3F1TUQrY2JqWHlSdktMdjZLSjFYTEI4SDd3Rjg5Nkx2QVNU?=
 =?utf-8?B?a1ptbHo3bE1IL1FjTGRPUzZIWEUvVm5Od2pTUUFKeFd3QUkvUEprMmZjZFFZ?=
 =?utf-8?B?UkFqWmtwVDhLMVBQc0N5OVg3YXVXVFFuWmZaTmtHTXVIZnkwUmQ3NnRNTWFa?=
 =?utf-8?B?M3h4YlhvVXFKcDJUR0JKdWFMc2RvaGNmcTJUeWxqbHpHQll0RGVoTm56S09U?=
 =?utf-8?B?bDFxV2RmVGtTUThVRVBTay9jNVNVblFuVHBYRSt3cHlOMlBJWkg4c3RhZUdp?=
 =?utf-8?B?OGQvbXhueDV0TDVxU2F4dHUvNlpEUEdMY25SNDNmWERYeEU5ZU9DZ3drOStQ?=
 =?utf-8?B?a1hmaTNaNDdsK3VYZ05Ud3hTRUZGYjNFdXZrc1EzdEplOVczSUlGUlZ0VzVq?=
 =?utf-8?B?MDRIQXZQdXJ2Q1JkN3Jqd1pIOGc0VTQ4allYWVJPejByS2YzSFRHM21kUjA3?=
 =?utf-8?B?MmpYemFQWGhjekVRVnJXdDRSUFpoTk9hTFBrU2tEWU1xMi9SRk8yVGMydFhS?=
 =?utf-8?B?YXdsbVBvVVN1QTdmOWNnY2svUFh2NmduRlR3eEJ6N20xUUpSak92QzkrVHFC?=
 =?utf-8?B?VEtNSUlWY3lmWmVBcmpjM3pPbC90TURXOENWNUlwZmJvdGpEakVwaFNiUktv?=
 =?utf-8?B?ZDJna0FxZ0QxQm04Y3RrTGt5Z1BsV0hiSk9YWnBZMUVTNXNTV2JZS0trRW5X?=
 =?utf-8?B?TkM4NjZyU0R2VmtpanUrNktjWHFyMVFLSUZuUlJtdkRQQVZJZUpkNTVPMDMy?=
 =?utf-8?B?cnZYRnNnOGQ4REttUlJHQ3lHMk9jb0J6VDBaNHZ3TmlBV3o4eHlzdnRWQUNF?=
 =?utf-8?B?WWlRRllWTUlXWURtMTRnOXFPTjlwY05CRmx3a3ExQ1Z2c2t0aEkzL2I1REVV?=
 =?utf-8?B?STVuMlI5eXhjM2JLczVuZkpSRi9nc283dHlzM2VDR0dmK1ZDZk5CQ1kyRjEx?=
 =?utf-8?B?MVJ5RndRMk8rZDBZVVpVUkh5VG9mT01lazBhT20xMFY0Slp2VjdFTGUxUkdl?=
 =?utf-8?B?K21VeDQwVHk3VCtoTVc3aUZqaUhtYXl2ZDRBK2J2a3JDaTc0ZFl5L0drQmo1?=
 =?utf-8?B?MVV1WC96UE5yRGh2eGR2YUFTYm54MmxWTmlJQ1p0RUt0T3VoN2xQQU1JOEwz?=
 =?utf-8?B?SzZKS0VxMytQQzYxdU5sYkpaWTFmSW9uam95V3hhRERvdE5zYkhZL1hyNktx?=
 =?utf-8?B?eVUyQTI1VC9rNW9rTDIvR3JoRzZ4NzFPZit3c2d3ZmxnRVVXTjE3czJtcVV4?=
 =?utf-8?B?QklYUzlraE50dm5pSXlaUzRjeS9vSGI5bXBvYWVQWUxpVlF4NVl3RlkyYUEv?=
 =?utf-8?B?S25WRTV4V3lRSGlhSVRZdWVNbTF2VFNlUkFCdzArWFVqTzhQRkdhR2MyNnJr?=
 =?utf-8?B?OUpGNm4wTjQzVU1uR0FWWmlqbExVU3MyeENobnVra2xCcmVlOXRXQXZENEJ4?=
 =?utf-8?B?R0I2OHdieEw1L2hQeUp1YytRMU1GSEt3bVRYSEFsa2krcWlBTE1zRUlCdmZt?=
 =?utf-8?B?Z2EveUkzOHVYOEtGaGFLcEZZNzZ6a2lNUVlOajRmcWlycHhNVElTRnNtK3Qy?=
 =?utf-8?B?VXRyK3BPSXRmeU9DcTRHNWw0ejNJRmhQZi85cGZsOVc0aFRYOFJZK0x3dUtq?=
 =?utf-8?Q?F9MhSwP6cC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bS82L0oyaTlyanNXb3kwamxwYWhPVVM4dWo1UGtaNDVlT09hQVdiSnZ1bnZ6?=
 =?utf-8?B?ZzhXL2hROGMxanNpbWRBRm1Qb3BSQllDTW9UKzFIM0FSRkFPQjhHREpQY09L?=
 =?utf-8?B?Vlg0MkFtUzl2T3AxbWRuRTZrRG9XeW1RQUJHcGVSR2k2TEdDZjdiYkJsbHox?=
 =?utf-8?B?a2VXY2F6cWtGdjZXOWY0VVRYZ1RWK2ovT1c0OUlrT1FXdnFiNFNuM1QrK0Uv?=
 =?utf-8?B?NnRmdW1lSEdRV0NiU3Y3dzdmUGJScFExSnZPb1hhYlJhcDR3MngxakkzQm9N?=
 =?utf-8?B?QUhVMGs1QytpdXZ2RXR1Y3gxNWhBczdkQTZya0dxbFg1YXVNQU5XaUNmcmJv?=
 =?utf-8?B?VlJ6SkVQQVNTTXhWSFJuMjN3YkFOMDBMTTliYUk3TnR5K2wyOGJGOUg2amhR?=
 =?utf-8?B?dTZKbnA0UDNIUUxSOEh0TGkyMUZGb1BCMjJJUXNuVzUzV1k2UmhMd2tNQTU3?=
 =?utf-8?B?WllOYTBBeVFod00yZHdqKzBjNzNaYXowNDliakR4YmppVGVnZFRGcVZaZjdw?=
 =?utf-8?B?QlZVRnhyMWgvRldUMGtlbWVPUEpJWWpGN0NHNEJxY2wxQjROZDU4SnRvZW41?=
 =?utf-8?B?VGc5ODIyV1paOGNPQTMzVi8wZHNtVkhtaW5vZjE4M24rMEovQWZXVFdqR0Vv?=
 =?utf-8?B?NC9MdDdoVHFia2FVY2pPYUx6UFRRKzR6TTFmbXNyemg1Tmo1SDEzVFdPVzBQ?=
 =?utf-8?B?enFxQ0tTRHZwRFVRMlkyZWFvM1BOajlrSmJUUXRjNzB5Zi8yOHhzakhRQXUv?=
 =?utf-8?B?eElsbWlBRThKOE16ZjVLd2VsTkV0SDM1UDhiMEhwSU03cjFvUnQvbWl5WDhk?=
 =?utf-8?B?SklJTjJxK0xmVjdvYVErd2VPd0hSdURwMEVSWERDRC82bU9RWnFkS0xYQlpD?=
 =?utf-8?B?aW5CUnppOXpZWHVLVkJpMDNoamlodXhINGc4SmU1RTd3NFh5clB5VldxelVL?=
 =?utf-8?B?Sys0SDlwaHBPMG45WVhWaHFqUGpkb28vUTBKUUhHWXZhWkxmS210eFBTZ3FL?=
 =?utf-8?B?QlBnZ2VnNkdmVzhmYzVPL1FJNlZjZnpZdmJoQ201OHFteWVYZnBDV081R2hI?=
 =?utf-8?B?eTk5SkIwYnlFUlFicUJuOG5FMDkrcUQySnpNQ3lEWk9ISHliZVFsdGtMNDJr?=
 =?utf-8?B?MmRDOEUzbDYzT1o0ODlkQnA2N2Nzdi9BbFpJY0R0RkxwcmtQWU1SbzYwY3hK?=
 =?utf-8?B?TVFtRklHUmZnRXhwd3gvTkdmbWJNTmpja2dkNHQ1dW05OUNlSitaYzVQMDRi?=
 =?utf-8?B?OXJicXZJVEt4dGtzSGtyTUpQYjJ1Z0l3ck0yUTFBOFNYUmdkYkM1WFc5ajNO?=
 =?utf-8?B?NnhuR3VSdm5SVjBWdDQ3dVpXZ0NDVkluSG41cHpJZ1FYbS9qcVc0a0UzYkdM?=
 =?utf-8?B?ay92SVFjbitFYUZWaWMwaTVSZmhoQXl5VFNlblVBL2M0Zjg3UXlOWDJXcnhl?=
 =?utf-8?B?c25xUk9YcE5JVmFsZFdBazJWOG9rc0loMWZENGF5YngrS21rdTFFa3ZPTVg4?=
 =?utf-8?B?dVExVWZMQ0FTUHFHbEh2MUJYNVFLVk52bzBydnlySWlFUERDaXJVblpUbUgw?=
 =?utf-8?B?cFk5SUFBZnV1OWFvMElFd3NHaVB1QVNrKzhJaGhvM0ZkZEpIbkZXQ3k0UzNo?=
 =?utf-8?B?RGxBV1puV0ZoNW84cUVTY3pPdVpYTmY4c2htbXNmcTJmSTBBR0U2Z255Tkdy?=
 =?utf-8?B?V3Nqa1ZRWlZtbUdKMXB1YUlUUlVERytMbnFmRnFuK0YwcjRGYW5PeThVTm51?=
 =?utf-8?B?M2FGaFZvQUlNS0dvTHk0eksxUzd1bDY1NlJoTlBPc2ZYdjdXdmgxY2syRW4w?=
 =?utf-8?B?d1JkLzkrUmJKd2svTUlhdTdneVpyNTI1UVN3YTdyTllSbEc5VUdlQ1pNQWVK?=
 =?utf-8?B?TnVCcWIxSndoVjI2UFZ2WTJ3V0xHd010QjQ2SGYyYmxxd2JUVDNYS0dxTFRC?=
 =?utf-8?B?c0w3dGdBanJIdzdkajFZaGYrREFYSDNXczFYV25xbkVabzRZTDdERHdjUmVt?=
 =?utf-8?B?ajRFcXBmenVZNG11TitWeVN0OUk2d294YlBTRlZOYnZadHNEWjc0OHB1cGY3?=
 =?utf-8?B?S1pKOGxveGNrUm51cGNDcCsrSVNkNmRoN1ZtK3EyeDhrbWkyRkF3YkhWZlc3?=
 =?utf-8?B?b3EzMjhVL1pDeG94TDArcGRNYmRVMEpaZDl1N01rbTRURHdIaG84Rm91YjVh?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P9a+V5SzfJ3NY6zShx3728r4O+UVxkDCEJUiG+uVd2urYLBd/I/fwKX0dCQV5bBpWl8OOrkBah3/ZLqDZ3CrMwqS3jjgoiRHv75RaWh9IuO7YunJB0NwLy1zWc1xS8uconXa1RdhIw6Om/mE8dnkv5v7Y3gBVHs4F1ZyQ3QRHpAslY18EptJdgvdRtX7PJTXF23B8/G4lVh/RmTmpzm1sFyxoEeEfcFxq3J0Zx5S0dXK5JjLUvjqpN81Wi/OuG7m7vGKhlGIYYf05fJsoNXrDeihSyRz+SAOZ8U6naL4Fe+VaxL4a3jNQRWs/xm0NjM7PjyaZ/WPAVlhz1dgGbkl6sN8KdtDtRxBPeFuD5TWnbOnhcvvZrxQeKKwo4KEv7r5axkHl4khkU0ww7mZ6xmqzl/EopBE4AQMdCvloLJPahONiKx/3FbX0e9de4P3dJm6d7dY83gTIRhbpd9A0eYJpGxMjsg2fIuUh6Qb8uHhhP9quCGKWSOUYKCuB+N8zwBsn0Nqdm+qrZEc7yTiO5FwQvFEczYJ/n4TNcE/wzOctNQ1VQeEA+yq6BmsMI4fUqgnWD3iWF7sBil/ZjLPLyZj5d5HD71V8UGVYr9mBx5nmkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fc80bb-f6a5-41e6-dbac-08dd8be96b8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:28:00.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+ccwz/mt6HVa2srVOJPG6lUcBwQo7nakUeTAIKEEdOnyIwUP3fW/FpsLVO+9yBYHv98ORzam/XyPVz2Gp9sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050148
X-Proofpoint-GUID: Btm69HymZrw8uBEvJMqpA-PWoEs46bGW
X-Proofpoint-ORIG-GUID: Btm69HymZrw8uBEvJMqpA-PWoEs46bGW
X-Authority-Analysis: v=2.4 cv=eYM9f6EH c=1 sm=1 tr=0 ts=6818d90b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=BwGnMpIltINHKhJnEOQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0OCBTYWx0ZWRfX5fGARXX8il6p d/BVY3oMVte2IlBDrHDbNDyWmOD3e5a2B4IqiuT7pIg73OtwkeYwBCbJvZ63stcZbg1RfgCwQeU XHjY9lYiSAaOhiMzPQ91pW9DK0ZePrwC1S1e6CZAGAXBa/pWSuf2MLuZrHHc6svEvfludpOcU72
 PNPIQy0200vFJKlaM4exEa8dwkQxXIBrgzkiFehDfTRHy69NJwq2M1IR/ZdT82XiJlwZqy3ijpW Ptobdp0kleR/OVASQAgO9HIUGfiKHPDw2VYhsVWM1ngLLmha+lGC6rH/XIglrrrpXvDUnBL9skn 1wMXNRM8Ajm54aOMdg0PuPk7ov2ns29sR0U/0ITVwhI6JXaxvwZvSdcE8L8KzATyraIiOQpcGfB
 5kxBhjcV9flD+sICLn0XpceVbCYcq1Pm/+kcjBBA9uNf884MhxcXcVoBRG4AzSxnXxlUgxCR

On 05/05/2025 15:48, John Garry wrote:
>>> @Darrick, please comment on whether happy with changes discussed.
>> I put the sync_blockdev calls in a separate function so that the
>> EIO/ENOSPC/whatever errors that come from the block device sync don't
>> get morphed into ENOMEM by xfs_alloc_buftarg before being passed up.  I
>> suppose we could make that function return an ERR_PTR, but I was trying
>> to avoid making even more changes at the last minute, again.
> 
> It seems simpler to just have the individual sync_blockdev() calls from 
> xfs_alloc_buftarg(), rather than adding ERR_PTR() et al handling in both 
> xfs_alloc_buftarg() and xfs_open_devices().

Which of the following is better:

------8<-----
int
@@ -1810,10 +1806,10 @@ xfs_alloc_buftarg(
  	 * When allocating the buftargs we have not yet read the super block and
  	 * thus don't know the file system sector size yet.
  	 */
-	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
-		goto error_free;
-	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+	btp->bt_meta_sectorsize = bdev_logical_block_size(btp->bt_bdev);
+	btp->bt_meta_sectormask = btp->bt_meta_sectorsize - 1;
+
+	if (xfs_init_buftarg(btp, btp->bt_meta_sectorsize, mp->m_super->s_id))
  		goto error_free;

  	return btp;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5e456a6073ca..48d5b630fe46 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -481,21 +481,38 @@ xfs_open_devices(

  	/*
  	 * Setup xfs_mount buffer target pointers
+	 *
+	 * Flush and invalidate all devices' pagecaches before reading any
+	 * metadata because XFS doesn't use the bdev pagecache.
  	 */
-	error = -ENOMEM;
  	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
-	if (!mp->m_ddev_targp)
+	if (!mp->m_ddev_targp) {
+		error = -ENOMEM;
+		goto out_close_rtdev;
+	}
+	error = sync_blockdev(mp->m_ddev_targp->bt_bdev);
+	if (error)
  		goto out_close_rtdev;

  	if (rtdev_file) {
  		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
-		if (!mp->m_rtdev_targp)
+		if (!mp->m_rtdev_targp) {
+			error = -ENOMEM;
+			goto out_free_ddev_targ;
+		}
+		error = sync_blockdev(mp->m_rtdev_targp->bt_bdev);
+		if (error)
  			goto out_free_ddev_targ;
  	}

  	if (logdev_file && file_bdev(logdev_file) != ddev) {
  		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
-		if (!mp->m_logdev_targp)
+		if (!mp->m_logdev_targp) {
+			error = -ENOMEM;
+			goto out_free_rtdev_targ;
+		}
+		error = sync_blockdev(mp->m_logdev_targp->bt_bdev);
+		if (error)
  			goto out_free_rtdev_targ;


----->8------

int
@@ -1786,6 +1782,8 @@ xfs_alloc_buftarg(
  {
  	struct xfs_buftarg	*btp;
  	const struct dax_holder_operations *ops = NULL;
+	int			error;
+

  #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
  	ops = &xfs_dax_holder_operations;
@@ -1806,21 +1804,31 @@ xfs_alloc_buftarg(
  						btp->bt_bdev);
  	}

+	/*
+	 * Flush and invalidate all devices' pagecaches before reading any
+	 * metadata because XFS doesn't use the bdev pagecache.
+	 */
+	error = sync_blockdev(mp->m_ddev_targp->bt_bdev);
+	if (error)
+		goto error_free;
+
  	/*
  	 * When allocating the buftargs we have not yet read the super block and
  	 * thus don't know the file system sector size yet.
  	 */
-	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
-		goto error_free;
-	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+	btp->bt_meta_sectorsize = bdev_logical_block_size(btp->bt_bdev);
+	btp->bt_meta_sectormask = btp->bt_meta_sectorsize - 1;
+
+	if (xfs_init_buftarg(btp, btp->bt_meta_sectorsize, mp->m_super->s_id)) {
+		error = -ENOMEM;
  		goto error_free;
+	}

  	return btp;

  error_free:
  	kfree(btp);
-	return NULL;
+	return ERR_PTR(error);
  }

  static inline void
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5e456a6073ca..4daf0cc480af 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -482,21 +482,26 @@ xfs_open_devices(
  	/*
  	 * Setup xfs_mount buffer target pointers
  	 */
-	error = -ENOMEM;
  	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
-	if (!mp->m_ddev_targp)
+	if (IS_ERR(mp->m_ddev_targp)) {
+		error = PTR_ERR(mp->m_ddev_targp);
  		goto out_close_rtdev;
+	}

  	if (rtdev_file) {
  		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
-		if (!mp->m_rtdev_targp)
+		if (IS_ERR(mp->m_rtdev_targp)) {
+			error = PTR_ERR(mp->m_rtdev_targp);
  			goto out_free_ddev_targ;
+		}
  	}

  	if (logdev_file && file_bdev(logdev_file) != ddev) {
  		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
-		if (!mp->m_logdev_targp)
+		if (IS_ERR(mp->m_logdev_targp)) {
+			error = PTR_ERR(mp->m_logdev_targp);
  			goto out_free_rtdev_targ;
+		}


----8<-----



