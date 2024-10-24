Return-Path: <linux-fsdevel+bounces-32719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42E9AE116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320871F246C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105611D9A6B;
	Thu, 24 Oct 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbpwwoEX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xIfelkVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F41D9A53;
	Thu, 24 Oct 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762543; cv=fail; b=O6aGNMZhj7MXR2CXr+skB6/DcpgiSg5zWPEcUOEeZzdsLk29kLbKxE4xNFHxgCjql6KVR3vHg8Jz6bRsM3qtsRrvaOKNeMtWygLaCF9WZAlw+VcC8qD7OSx/HlQhKPr8/KLlgwiKywRpLiV2sN0WYLU4wDjBlQLWlwwaWqpMfxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762543; c=relaxed/simple;
	bh=TqxrCk4gFfhG/o41DSgeRHTRng0P3vkMIWdD+y+YkVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SBYWsq0lAcjashhuMgw0i5rZped+t50NBavemFXVvTjb1gHoSwsEMikJ++INy743FSsGGZHP+/63aAXJn0QRIqTMgyIAxmzRgwbFL+Ya7knPes+EdQmCFRzg13BvhLbVl8gfRJWKFwr8OE+TQBDkLfVtq+b/aslyXfhniwSjC7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IbpwwoEX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xIfelkVB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2fvCX008771;
	Thu, 24 Oct 2024 09:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uQyi2ekTh5alWvxIJllr87WpwqIZdLRYp3dgItmVMNw=; b=
	IbpwwoEXSojGwKrr09xi9yug2g4GvwW/e3PJt0aKiJdMF6Wd5Imhpe2TWR8Z0qUD
	Mk21WqtlpzfHv8CoIu4t87NJK/VxOja1uXm2kOoyyJ9LFpNusuh8LC7e2dQ7uNwI
	FfE7n01iXKHxCZiOncWZwNS0qBNL9wtyQBbD4zOOWr3OVan8EOjU8TdMI1cqrPny
	+eONZj+OpYe/Y+V5DmNM/WPMcuGDd7GwXLzidl36QYzGIsPAWGosSyUw7RajMft5
	fzSBNjeT3liiRTehG0V0S4dAqeleVHO47F6FH4sX+vpWWtIIRfra2P/pCES+kBGT
	ixMzc5cTAxjByR6BbFgo/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v24mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 09:35:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49O8WNtc036141;
	Thu, 24 Oct 2024 09:35:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3p3fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 09:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQqhhekm8Z+CVC0X+h6ZYZNfy+d8+GLoNagMbdMsorpvgaE5zxu2LSZNoW0btEQkUkqROtyiEUd55wJh1VAsJYXA+IPfh34z9bRW1e1UDxWv4qYN3engUpYF9P4uFzAWlrcm3tY62100xpHL0VnN6UQpohiNODVGfQ0tbFCgcLYRlDDIN9Vt7yr0eKaRrslrhkbbvwLdXfWqW4GAtuUDackLPgA9LgH27/0EdeRDcRmjX/iW+x6ljrREiSDXkB6AQ3SGS6eBcA6IanQ20VBRU3WEKUC/6UYs8B1DGmgJYmPb6xD0JhQGBaOFrjuyKSdYwv55uaZuYWHaAUQHE+Z9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQyi2ekTh5alWvxIJllr87WpwqIZdLRYp3dgItmVMNw=;
 b=dMvbZPzPoIpDFaVCxx9V3CeB0+IY/ZmPUZZTF2VO19TYbEFgFm0jdNbCYCBIc9CUbofz9d42pzdOAUJNpkxIRs6FvZTQdOqBQYE9a2p0+w6XxaP14pjIgBhEWPA40FN70LtdDfFy5P9Uj1X3DmVt/UqMqQypGM8mGZ0kpSzRJ7sN+GlGlko4MRDIx7W2VCD+zpQk6x/o5uizItjTwxL70uUKu6Fraf9/LxviaMBS0G10htAdPvP/JCW3M1ucz0K8MQ99w8zEEnxxl/2DI6T39pAvWzsrrQO3hmvE193aF1PdbxiuND4RToCp79Hy2SPPE1/UrCpWh+MjlGJzzl/yOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQyi2ekTh5alWvxIJllr87WpwqIZdLRYp3dgItmVMNw=;
 b=xIfelkVBrd55cVupDLlY31YlGEDTBEWhruYVxxZzuFqHthXaC/QwQZkitEBqx7tkPWwhKGBPYAYtPkxG/1IrmG23hkAb3knF1DDtFBPNVzeC031VQs1Rtighx3htTFoeKJIimDh50kycBbsJtImsRVcFwRrXwPgv+W0VfdJS7TU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6976.namprd10.prod.outlook.com (2603:10b6:8:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 09:35:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 09:35:32 +0000
Message-ID: <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>
Date: Thu, 24 Oct 2024 10:35:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v6.12-rc workqueue lockups
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023203951.unvxg2claww4s2x5@quack3>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241023203951.unvxg2claww4s2x5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0047.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce2e27d-2ada-403c-1499-08dcf40f3463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5KWm1IUVVUd2xiSmhEYnFxbEkyVEdESjRhemlLUy9QNHkzZGk3SjUvbEYr?=
 =?utf-8?B?ejgrVHFGVmFuN3M1NnQ4WTkwT2pmMlNkYjNpUktuZlBvUC9raFhIcmFMeEpZ?=
 =?utf-8?B?Q2cxdWNxTUVOUUsxMFhKbUtZUVVFUTl2K3RYTjFCMkd1a2xtYWRCRUtxNk96?=
 =?utf-8?B?Um1jcTVXUndYMEtDU3VJdHdDMm5ma1BIaTd3bFpjSVdRR3ljcVJ4UFhvdHEz?=
 =?utf-8?B?OUUyWUJ6alh0dlN0WDJpeUNiK2t0bk12bGg2OHpGUU9RVVdIYkd5Kys3MFIx?=
 =?utf-8?B?dXU5WCtJZ3Y1cTEzRy92SmNmSXpmNjFib1RBZmtkN0laVW1iK3VDbGlwTVg3?=
 =?utf-8?B?aE5BeklDNDBnd0V1U09lSjk3cjY2SnpVZXBmSXNDQ3lnbHhWc0VtVkZBK1lk?=
 =?utf-8?B?S05ZeFR6ekNmQ0sySTk0cWtDRWpDR3JJMTEzekhHbTU0Sk1uT1ZoVFhmclpt?=
 =?utf-8?B?L0t3UmlPOWx4MC9ZWmFvSkJsdnZhOElxc0Z3bUNkN2Q2b0pvdVR1ZThaSjVk?=
 =?utf-8?B?SFVEaGVqZXYwZ2xVVitOWlRyTzhmS0pEbXZtSkZhcTJGYTR6MHFMeXlISWZW?=
 =?utf-8?B?QzBjb2w2OWVGYXpxMXJiNEpudmVHN1haeHlxTVBLYjlBYTlmOHhOOW8ra2tN?=
 =?utf-8?B?Q2VzZG9lcXM2V3JhanFSL2ZXOXg3T1hjL3NUc3FWOXhaMlNVRDR3dXNvUXJi?=
 =?utf-8?B?NWZoV1JSV3IyenplRUM2T3czNFI0dFp0bU5zdThvVE5kK2ZjNFc2bG9CeXI1?=
 =?utf-8?B?bnMzdFVlWFhPcWc2RUFtbmt3QVUrNm9MQTJQMkh6WUZRYUxTOWZOMFhFRjJw?=
 =?utf-8?B?VGVCSHFNL29Xc3VteDZiYkVENTVmcEd2MEh4RWRNRTB2WnF4K0NzT2FtTUwv?=
 =?utf-8?B?OGtubkNFUUI3aWNFR3NPWFRVNWttT0VuN3VFaEhUd0xDclhNOTJ6UGVIVnRa?=
 =?utf-8?B?bnM4STJaSWxiZlBDVnFQeStKR0c4WElBRTZ3YUZ4dnYzMEs3V1hhTDRSQ1FV?=
 =?utf-8?B?RzVsYU4ybDg0dXU4Rk1HekR1emZ2WEZ2RVFXS1pQaS8wYnhmVkRRQnFzWlFn?=
 =?utf-8?B?RHpSTXk0aUVOSGFqY054c1NScS9zUGNLRjRFRjg0WEFrQ3ZLV2xvekRSMDZX?=
 =?utf-8?B?SjdndVVhcWhiNklVYmJhYnU4dktXL3h6VVNvdmxNSit4UHFYNnNOck1WTkFZ?=
 =?utf-8?B?eWtPM3RlU0IvajMvOTJycHRzKzd6dkdiTzdXcC9PN3pHNjdZbEpkRDdZSDZT?=
 =?utf-8?B?VFZZQjREQ1ZrcVVCSk9XdG5weFUweGZkcWNvdE5VallSNHRCYXV6RllHNFFE?=
 =?utf-8?B?TW9ZY3RwbG5wT0dDdVB2Z3VLTXhOaWhOTG1SMXJSOTBFMlA5WHhHRXRrYjMr?=
 =?utf-8?B?a0JtSk80VHhOczUwVkZiWXBtMXlta3pFRlAxNkk5dzBoanlvVHlvTU95dnBa?=
 =?utf-8?B?YW04QWduZEtIb2lyQ0dJRHdLdEdsMmxmMnRQdGhjcy81OUdYd2ZUK3I4b2dz?=
 =?utf-8?B?eDlXQjhTK2NxUXlOYmYzNHJvcUlveXFPYkNUV1c3M1VGT3E2TVoxa1J4eFY1?=
 =?utf-8?B?TkRDRjNCNTROYzhZeVB4QlZZSVNTQmdtOTYzZ0xPNDNxQ1h3UkIxcDdLaFBQ?=
 =?utf-8?B?aGpIaktHTG4rVElMOVB3VEVuaVpKNTFSLzQ4SkpNdjdzaEU5bE8yMEo2QVZp?=
 =?utf-8?B?STl6TnJqellZaWVQRzR1aVd3S29PcW4wVTUzc3YvWlR6NlpsWXVVVlQ4OU94?=
 =?utf-8?Q?vs8ctx/Dn4tU0PFOUGuAf5j+xl0yobKGgSXzd03?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlU4ck5nRmsySXRYdDkwclNjdVFqZnRtdmFOL0dxVGhJTTIvZEJmaHZYcVpW?=
 =?utf-8?B?VTZkK0pCTU8vbWNKOFRIS3ZPd1plMHdQcG1rbE1PdHRPTkFISEF2TjY1UDhZ?=
 =?utf-8?B?UHZXZy9jRVdBQjIwdURsMXFhWm9yWGwxellyTFZpQWVLdnpKS2JsMWFLTk9w?=
 =?utf-8?B?aUY1VmxDcC9JdDcyS0F2RnZUdlN3Vjg5WUlTdXVDR3hYb0tINThFZjAvaDBL?=
 =?utf-8?B?clRVaDB0YVdCcDJlSDZQekdoZVNYUi85djZLdHkvVWxueWpPaGNTOHZwQnhn?=
 =?utf-8?B?R29jOHpoQVhZYnFtUm01Q09CQ3hFVzB6d3JyWnBsSE9tS1hkRWNNRElSUnQ1?=
 =?utf-8?B?TE1jYWJGenMwb1NjRFFoSDJxcENvWFRwL1JjQnVGcDE4TGVtSFVlZjBtLzRO?=
 =?utf-8?B?MmU0aGxWeGJZN0RwU0RqYlduVFQ0M2tlTmlLMzk0aEkwUXY2b3ZOQ0sxNzNj?=
 =?utf-8?B?dkVKYXl3NGxReWd2T0ZHQ1kybFp0eitldDh5RnVFSmpDSTMvMHNpcTdxZnRK?=
 =?utf-8?B?ejdKSHpiWDY5TnVjQnhlWlJrTFFQN0xRZzFtM3BRai84dFhsUlRuMWZDRXF0?=
 =?utf-8?B?Z1FVbVNJVnlIejg1VmtLazZFTHQwYlk1alZkdHIxeHpkZy82M3RiK2VZSWl0?=
 =?utf-8?B?TXdiSng3K3dmOHVzc3VJREwzVjdJUHB2cWNDczd6UWFVRjQ4bFp1L1dMMXNZ?=
 =?utf-8?B?NkoxaGlNQ1VhUy9UbHFia3ZBbTMzSmhlZFliaTJWZTQwQ0dJbDRWMHkrK0FU?=
 =?utf-8?B?ckIwWVlIMUd3WURwOFM2MmlxVzFOWnRMbDhKaG0zNi80U3V1QUROMDgwVlpM?=
 =?utf-8?B?S3FXNzdkSldxL3JhVm83eFVzejQyekpXZVJsRzRoVUliblduZUwzZHZKM1VP?=
 =?utf-8?B?TlVFS3dwTHhhWTBWWldZNXN4aFpLV3lmTjdSZFl5MDF3enkwd1FEL0ZtQXlW?=
 =?utf-8?B?RlZBcUtISE15aldpTUdtRXh0VUdSZzZMbk9UZU5JMTFaaHlFcGJtOXNBY2ZX?=
 =?utf-8?B?R1laQksxZlpzRXJjZURwUjg3Z1ZOR1NOVFFuVE9heFN0ZEZtR25xQXV0MWJD?=
 =?utf-8?B?aTRCV3lGeXRQbWhpY3RZOGpJL1FlZ1cxNzIwdkZtUy93REQ2eHpBbmQ4K3NI?=
 =?utf-8?B?QjcrOUV2UzZRYXVORG5UTFRiY3B4cU43TEZOR3JGY3dDQXRCdnBGK0RGbnhv?=
 =?utf-8?B?MlJhUUx0R2JuMUJKa3NtRVVRbGRRZjkvR1MyR21GYXYwKzk2YmNyRHF3amdz?=
 =?utf-8?B?NHRPSnNKVi9CRWdGUkdvRjZOb3dIajdpeWFVb0NOeHBVSmVXTEdTVW5qWEZx?=
 =?utf-8?B?SWdRYnYza25lN2tqRnNnWkpqQlpXZG1QMmlPaXBqdEhGbE83N0xtSTdtdGFy?=
 =?utf-8?B?Q1JMRGx1bE9qNm9zT0lFeTMycHl0RHo5SzlqUnFQeWUxemRxK01EdmtOOUxj?=
 =?utf-8?B?NTBUaWhJMXp0MTZDWjlpZUxjNFVhZUtINmxBNElydHNOd1VkdTRXMzRHc0xZ?=
 =?utf-8?B?SWozbHpPWDZ3d2poVGNheGNvZFBrM0dEaDQ5dGh0M1laYkY5QmxLWWF2eXVQ?=
 =?utf-8?B?RWpTQVIwcUpWQlA4MlhPbnBIMTNvbWRtQTF2K0lOUEpUSWRMd0x3dE1paDRP?=
 =?utf-8?B?blBIVk5peFcxMXd6V29kWUNHNHNmL1ZrVXNUbmlYMzZiejZBenJlRDREYWVn?=
 =?utf-8?B?UDg1eUdpMG5yNEFrK1laYks5cDkwZFdScmpFUjh3ZHVkQ0hmbE1BTmw2T21C?=
 =?utf-8?B?UmticWg0N3NWTXRIajNzdXBmeDdIYWl4OGNlVlliOGJ6K3M5MVNpcnZDbm5l?=
 =?utf-8?B?NlZpMU1jK2FVNFBkVWRmcGR4TUFQZC8wc1Y3NWp6ZGN3by93WWJ5VHA5d05h?=
 =?utf-8?B?d0NwZ3VlQWxpaXN0cU9OWDkxRkhtTFh3M1N2aEU3YTJ4cEFQYzFrNkNsODZE?=
 =?utf-8?B?b05XVkU2MzJGOG9DaWxSeXBDb0dNUkhqQVFJNENOZHJ5akkxNWJTakN0SnpZ?=
 =?utf-8?B?L2N1QTZVZ1VMQzcwSlVJSS9McWx3WDRwT1B6dGlId0RmTGQ2UUhYVTNHSCtJ?=
 =?utf-8?B?TDBQUWpyK3Z3U0k5NG1hY2xNQXRrTCs0cjdVWWE3c1czWm9wUHVTem1CeS9i?=
 =?utf-8?B?NUFmb2MrRi9EdmF1Qy9FZGhpcmNmMXBFRnUyMmFFOEtuZHkxeVdBQ2VndHEv?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9h0x9JLB9pnF1AZpVPmAyClKWmT/BpaM69WD61qRT6nN8DRFtLFQP5NIfzdKY+A8tCsZL7lfq5SqKcTGbSCcxS9iJfWVOCR0tR+lKCQZ0a/kK/ZDnsPEeST3tW8MkYAPXQvUkQ7MCher8Ti9pZXlq/wA13GPsHFi6USBHTLh+0Pa8HCOmLkCqRyCh5l5Sw4Vgca/KYA/TYzrZCexGrTe5Mf7oAhys8ulJP3S9rg292Ok/mPqZ9BVJR9fibWoG2spH3r+1QhAB+Bb0L46VMUMtWqCZNQB9i9YKLEMlBEzy8Tszl83yI1v96b/6B8CF03Q/gjV0+Il9PviqAWXcoMuVPnIfnC2YjmZEhLAxa/psDg9px7ZaPXvX27NL1mifD3be0GdqaJXfFvVaLAbTX0COlj6ZIEFYDpdYo9LYSks3yo+uSWgZg2Nx75ZgJgSExnxEjue+MwELrM/BTa8xglQZZkyE7lMXMR80Yil80Sftri6hoSK0I+vlmCkQYKC1qXv/H+/x1+OtvEoJUDMrkh6mO35+rr77XNvk+jqe7iynDScSu3bH0nxV+m/7we7/3qO7DfBCwn6/x/2uZOKhCokEBJPj0rgCMEzOyKogkcCq1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce2e27d-2ada-403c-1499-08dcf40f3463
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 09:35:32.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZt1f4Feqvzhmv0Rw3d7+RGwFI3Uct0PJrEDWu/3dtqwdnmFNwNE86Avv3QlbgFs7uyxjfTtPd/+/xAcr29M+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_09,2024-10-24_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240075
X-Proofpoint-GUID: tVfV5rdAOXZyG-CJq1pCbQhLL8rcXTbF
X-Proofpoint-ORIG-GUID: tVfV5rdAOXZyG-CJq1pCbQhLL8rcXTbF

On 23/10/2024 21:39, Jan Kara wrote:
> On Wed 23-10-24 11:19:24, John Garry wrote:
>> Hi All,
>>
>> I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
>> master branch:
>>
>> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
>> Oct 22 09:07:15 ...
>>   kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]
> 
> BTW, can you please share logs which would contain full stacktraces that
> this softlockup reports produce? The attached dmesg is just from fresh
> boot...  Thanks!
> 

thanks for getting back to me.

So I think that enabling /proc/sys/kernel/softlockup_all_cpu_backtrace 
is required there. Unfortunately my VM often just locks up without any 
sign of life.

But I'll continue to try. And I'll also try reverting that commit you 
mentioned.

Cheers,
John


