Return-Path: <linux-fsdevel+bounces-38652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1BBA05A19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B8F1659D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955E1F8AC3;
	Wed,  8 Jan 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKVp6jvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZoVEaU/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179541632D9;
	Wed,  8 Jan 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336401; cv=fail; b=PtpSDZH7Bf1h6wDxIrxoLo7/zoaC/JfVORyV8RZ2hsHv6jnCy3P8TBRnRqVVrPM67+JFqs4dmc40ZQ897m1XfbNf4Yf6FmLYpubtHjePL17gEyyAmOZsV121mA8J0uNHPTTBoGGWsiuRwodr+cTjkFiHKhZ/n4At1NNrWadi5k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336401; c=relaxed/simple;
	bh=fAq35vy5Vg2HopWbxRqbaSDcdDzyvYs+Jm3ALduCzgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZv3Hu7S6/GHSlULNe1K+oGPQi8UuTi2/4iuloVKOYZSruDCn+hD8jmvqZOPIO+ldQ+Rm0zB26epcu7iws+9F4RSB/fXPF2+VEPj3WZOqaA2pDHvz6yKcxnYkJnyckWQYpLFeLcNaC9Qw/K8X/LXuS9rjOTWfzch2bq6yP0R3Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKVp6jvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZoVEaU/x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081uPWs007927;
	Wed, 8 Jan 2025 11:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1azEFTuUYtS9qR6vt123vKHQ8l232txZDtUW7aGTaFg=; b=
	IKVp6jvr5PtjXsTLtgXQKILbU+NVMF+ijQZAYUVoNid4PAqRPZ6pJDK49mY+Q38i
	H1kPBfnsQ4KXgvi9FPb04kEdp/0JRW0rOjYmEc6tlyPneC0RcXYNkgd7SQvyJG9q
	WDxF9vYg8BviT0ddVkZwcGoEf/7y3nZjSKdOTwkU1mJBOZonrofK6SuYjX6V02Pq
	EICsTyleI4oTuEyfxwBmba2IjcVfJ32lNAxiBPQolOw6WJDosHhb1qxBzaquuWb8
	qSH9i08MtJLBBUkcVd4MZURc48OXA1F90HYNaNVoznFVpPTNUU/beHSDRqkN31Y3
	YNs+YFxF8jyWXxDMX9DUaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus2epnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 11:39:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5089nIFM004801;
	Wed, 8 Jan 2025 11:39:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9p0au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 11:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5G0OMrH4+q+U2Kb2o8j2NnYVMVVxm0C8g5uEDTiwwgl567NmPSK/MLelcgq4mhaOp3BzFYAtjvUnSpfrr7TAf1MvxWLGGP0uz99daW5qAocip+OND+9I5qZy+atfLg4ermuMzOt6LTXFqS5HoDZEW4gUEJkohAvs64XAlF537C6NQM87lryS/cVi3KOxgDIuPIma92oOZ74rsNE0MkGbTRKKGRVkSFUsEdNjPrcvn808X5X09xhDxxTgTSIGGULh1D7USbtKE9eTqnabxbz1hDVKcZzbO5NTQkWPcoMSPuzegw4wX4/VYbZ/+QOVbRTBRHMTEAI3oFNqJmkryTYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1azEFTuUYtS9qR6vt123vKHQ8l232txZDtUW7aGTaFg=;
 b=GazhOABUljM2p9/0dRyk7qIdpipqmUtW8zD2D1r7qLaInfBRhc4AUZDOv8c/lRUXA6tDosjH+HPB5C7ZYhxtVVdEpD3ZSzSO98iRagomzc/PHYbCOgMZruBlp8TT8Ru6h83Z9jyzl8SgvKHc2S7OCdBHn/Oz0weikE+go2yONRTzKiJHUkOsJRNVlNeFm0DSADfYD16yYwWeRBFv91/uS6jMvXp/7zUF8GfBIFbAoBDep3Be6q3oq3qAoy7ar8IKpsD9V5KW/2JcDDShtnyoqiN1OGmDJ44S3ddF2S4/PNHc4s5yMCq1+ZyBxh/37SJUzZSUbab5ekjmsRId5aH3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1azEFTuUYtS9qR6vt123vKHQ8l232txZDtUW7aGTaFg=;
 b=ZoVEaU/xeoxQouqjj75Ojz6M4h76mN1YOdrizSNL62ZppWv5uYdbn3b863mlTeegQoT4XGjOd9o6earB+8anyB+osMuzrxfZSx80+Z3Y4Eh4Pu6nYr/KN9ZtIYHVZ8+KO89A+eQYHskMoMfE/ejqEe/c2kMrEJus6/okGQobe/o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 11:39:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 11:39:38 +0000
Message-ID: <332f29ce-4962-496e-ab37-f972c1d4aa12@oracle.com>
Date: Wed, 8 Jan 2025 11:39:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, cem@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs> <20241213144740.GA17593@lst.de>
 <20241214005638.GJ6678@frogsfrogsfrogs> <20241217070845.GA19358@lst.de>
 <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>
 <20250108012636.GE1306365@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108012636.GE1306365@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0022.eurprd03.prod.outlook.com
 (2603:10a6:205:2::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0f3ef1-0fac-4904-88b5-08dd2fd9220a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlFBYmxNOUErNFlJVjh2T3ZGOVpqdDUxMU5XUE1HQ1ViN3NVMStDbmd4SElt?=
 =?utf-8?B?dzltSHl5R3NPYkpWQUxzOHVtNDJhNlJOOTQ1cFNwN1h1RlNnZjVsTFk5dHVn?=
 =?utf-8?B?QnFzSnltdzNIV0I4bnArYkRvUSs5TmtGc0MveGVmUVlEVGg2V2hhR3FKZmVm?=
 =?utf-8?B?WWVWTVFxQ3hneTg0YzNmVDJ4bG14akZuQ0JRSXpyajBPTWRPUnhGajV2b3A5?=
 =?utf-8?B?UDlheEFrajdSK3JZbFFQQ01TS04rbEtkR1JsU3cyRHR0SkxxSHNqRGREWU5l?=
 =?utf-8?B?Ymo3cHlvUU54VlV2MjlIMU5YOEhMY2ErNUVFMTM5ekovLzhFWWNWZ0lWbU5o?=
 =?utf-8?B?WlF0S280NDUyL2ZpbWtXS2toejIycDVvSEpvU3UzbWNVWVRuT0g5aHpLT1Ja?=
 =?utf-8?B?VTZ2NURKenZaOUhIRkVXNUNwbUlIQTRYYXo5V2JZRDd6bmp5MFU0eE5jazRM?=
 =?utf-8?B?UnYyOTFCQ1E4M2ZBZTgzdFoyTnpCeC9uZnZJRHN5b2s4TEt4UmR2eDFBQ2sr?=
 =?utf-8?B?bE5sNHZkVDBFZFB0S1dGdEpUVXoxbEFXNUFKazQ4a0V0elpPZnlOdnFMbGNK?=
 =?utf-8?B?K0IwYUg4cXlycXZXMEZiNUh4cVlWZU5HTkVpTVNEdkUzNFJkdithZGVwNGx2?=
 =?utf-8?B?dEpQZ2xWVm5HMkJIZEpDSCs1VGN2NVB4V0I5UkRGTWdYQ2t6VXg4eWJZRzIv?=
 =?utf-8?B?UXNKRm9DYnlQZysxdDBNb1orZWZjOXlsZC94QUo0N0lMRE40RWQrWjEwRytp?=
 =?utf-8?B?Slg0dlhTZ2JVaGwrVVo2Qjl1K3F0OTJxa2VlQ2pJUWZXV09zUWxpcjNqYktF?=
 =?utf-8?B?bERkRmlWbHhmblBtaklleEh6ZnRrbUFXT01YbktzUXBtbXBEUWxrRS9FNHN5?=
 =?utf-8?B?OTI2K2pSTzNqMEtZbE5wVnF5SGlrbm1BTDlmQklkLzllaVdGL0tpbkcxdUZ4?=
 =?utf-8?B?TFVwTUxieFVQT2gyWWVUZHZvRDFMTFYzSTVGbXRKTjRIc3FVRGxTMm5HMDFW?=
 =?utf-8?B?Tm14MEowUFdYVmMrT0dpM0FrdzlleFlTV21UUysxUW4wQXJUdTBaZzhVUHNs?=
 =?utf-8?B?VE1BamFRQkhmYXFSN1grQW8zeEk5aWIvYlFBaTVzeEczMzl1T0FqVGNVRURn?=
 =?utf-8?B?Qk9oaWNDdDg4T0ZLaHNIMm9id1pvaENHTnJ2azJXdDJjS1IveUp5cW14MWtJ?=
 =?utf-8?B?d21YZWxJSjhYWlpVUy8rRU9mOXUvS09jc3hZUVU0STcvczFDQkhsaGxibDdY?=
 =?utf-8?B?b1F4Y3FVbnRyTEF1TklDbEJ5TnVGY2FDK1ZJYzQrbENsellpclZmdWZOcm9h?=
 =?utf-8?B?cDcwczNZV3lheG5MWXZ1QzROM1M1MVdUTUJBZkEvdEtZSURFaVdENkVMZkxH?=
 =?utf-8?B?UFpnNEZaS01VWFNPUnhQZ2lZc3lad0RXc2dtaUk5RmpyRlZxMGFWUHRvSGlJ?=
 =?utf-8?B?eU9Wc1lxcTNLZnQxV0NQMUVuZnFzenlKM1Fia3U5aGd1YkM2TlVKWW5ORFky?=
 =?utf-8?B?SjJkQjlaNngwQVJsN2RIVE9QSlBVMzJCR0lxTHFLbkY4eEhRMFlvdnB2U3pl?=
 =?utf-8?B?WkFFMnBzR015RGg3VVY3YWlvK1FjclFXVUIwTjdmOVhQcHp4OFVjMnJGdWVy?=
 =?utf-8?B?NmU2cEgvOWJGcTYvQmE1ZU8xTHJvL0YyR2dXNzhSa0hRMFpNTjgxcE03RzQ5?=
 =?utf-8?B?VDkzN2tvY21idWNMWEMzajVJQzR5NnZsM2gyb2RORUpDZ0RHMXpsQ0RSVWRk?=
 =?utf-8?B?c1JKM2JPWXlWR2JBNWFHSUd0T1NCQ1JTZnpOaUFSS2I3TUZhYy9GTFAxV2Q4?=
 =?utf-8?B?NWJzWjUrVEVmYXJtcTdCNUFUdXlLZWRqNWI3OFY3RklRVnJqYm52L055ckFL?=
 =?utf-8?Q?W+dsveijkYguA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1ZOaUVtdGU0WERkbktYWU8rZFJUckdzNjJNSHo0OTFtdkN5L3NwOGwrNDFH?=
 =?utf-8?B?WGYvc0pJSFh2T1NrV2dDd2pIZHFmTWxRVzJRUk1od2pBK1Y1ZlVPRE0wR0Na?=
 =?utf-8?B?d25hV0ZXWmhsL3hvZTJONHM5dngySjQyQ2c5RCt0RkEyeVR0eTQxd1lKYnRi?=
 =?utf-8?B?UnAwMUdkWG80WDdxV2xaQlJ6OWpseGxnVzZJTVpUQUpiakg5OGc2R2E5SzBX?=
 =?utf-8?B?Sk5kQ1RJcjNqWXUwTDZiajVIWWdLaDNVc0txbmZ5UmpGd05CWjJadC9NZ2Ru?=
 =?utf-8?B?ZkR2TjJOVi9kdXpYVnVLL1B1eW1BdVVCS3JMekhCNm50dEZsZGx3U0lDUTFR?=
 =?utf-8?B?YXVlL2dYT3ZJemZoOWN3b21jMmtGNmlScjBZYUxqN1N6aHNkaE5INXB2and3?=
 =?utf-8?B?NDgxcHhRQUVsd0plQVBYdWRSbWV6YWFHMFZRMkplZFRnUTFMTXhZUlRtOWky?=
 =?utf-8?B?YW05MVNvU1FocFNQT0JXRHhvTFQ5MHdiKzVXNUJ1Y0hoa0xSVnJIQzUyV0p6?=
 =?utf-8?B?bkFnSzRGM2ozZmlFKysyZHVqL2FZSFppZjlMRFNtdWp3RmZtNUlJNUhsQmlw?=
 =?utf-8?B?SzhJQXppb2tsQVd0N2Z1UnZqQ1FYT1l2c3RaY3R6b25JbnhFRzFkcFBFZ3Jn?=
 =?utf-8?B?WGlzQnM3VzNGZWM4elhXZEc5d3hPWkFRb0VjNlFEejAwWm0xTnpUS3Zid3F4?=
 =?utf-8?B?aUk3eERlc1RUeHNrbVJoKzhjRkpvT2hacUg1VkN1RTJGRk5nL3RpMWd1Zjdy?=
 =?utf-8?B?YWJTZGxXT1JqSVkvS2RsZXVPWE5mL1RzdzI5dnliT2tjYnVTWWM4TlVwWTBV?=
 =?utf-8?B?dWt5K21idG12VE1zZ255TXdVS0d0V3VCM3RWSGVwN204aVY3MnZ0dmgveG01?=
 =?utf-8?B?cWc4aCtHL2l6M1BvS3FMOEhuT29HNS8wZkhTcDFlajRMc2FLZzRzV1BWY240?=
 =?utf-8?B?ZElVKzBnUTAyN3NLSFMzbGFoODVTZVFldXhaamRXUXd4Tlg4RTNaU2xXL09H?=
 =?utf-8?B?bVMzVzRoMDhyK3UrOHRGS0RWclRmbXVRbXIzY3ZTVzMreEV2bWlwVkFQWWRy?=
 =?utf-8?B?UWJKZm9wTElvWXZ4REtIOU1EZkNSZk1vdFRxNFVhSkkwb29sbVdCcngrKzhw?=
 =?utf-8?B?b1gwSUZUTHdVdU5qSjNJR3BrZjAzMjI2SjByTzZIZXlBTEhIcFV2S29sYUty?=
 =?utf-8?B?Y0ZNYU5oQnYxSUxSaG5vY2tpMDVlU2F2YkRhQzdWRUYvZlVleUNEVklWbENl?=
 =?utf-8?B?aCsrUVFlQ0V3SVBhRHZzWjV2NWdDVTJsdVM0ajRhcm81OUdrYndkYXZDY080?=
 =?utf-8?B?eWt2M05kMitqRU1pd0NFK0VuSEtzUXNqb2pRVW90bmU0TkdWTlJsU2hkSnlG?=
 =?utf-8?B?a0VQeWFVRStwU2FkVG8wU0drRVJQdENrbCsxcG1IQVBXV1NqWmcwc1VKUXdQ?=
 =?utf-8?B?dmJIcTN5VytOcit6Q1c0Tmlxc3dxY2t1UFFCeXVmSkIzWm1iZzhueklZTEF1?=
 =?utf-8?B?dGx0dGJpU2QyZzMwbnFaQjN6cm04Sjc2ZUNRU2VtWGZaYWJpTitqdDdTdXIr?=
 =?utf-8?B?TGJ6THVWY3d4VWpKZXRxZmkrbzRZRHBYamhJMS84TVpualU0ZzNLalpvVi9L?=
 =?utf-8?B?Q2JPN2VvdzJIS3BhZnZkc1g4QWxVTTRRT1d2clQydENuRXR5SGRqS3dBY2VQ?=
 =?utf-8?B?UjNIV1h0bGJBeXliejRLNVdGcVZHTGNGUjVaejNXKzBVL1R4aUhJQU1Ud2dM?=
 =?utf-8?B?VkVWMXh4aXhRYmJKeDQ1bzlQMStucjVXWFNJSW1lRnJ0Z1VQTTN4SFdLdDRM?=
 =?utf-8?B?QXlhZnNZK1l6dHFLNk1Kb3lVV2cxYWR2WDJyNi9XQTEzaWhiaU5Uak0rRFFY?=
 =?utf-8?B?OWVIQXZHY0o5WW5DVlRjaUo1MzZTL0hrRTZWbFNlSUdHSWJWcFNqajNCWUlQ?=
 =?utf-8?B?S01sZXNZb01md2t5a1lDVFBLQWptUmRBV2hteXo4MWR4S2JLaUtzeXo2b3FZ?=
 =?utf-8?B?Z0Q0UnE3aXlJYzZIbXlidUswNWszY0NpNHZudmx0YkY0RzR6cUFPV3FaYldC?=
 =?utf-8?B?YkVNTENEVVNKei9pNmxOWW1BT1F1Ym5mM1lLT05rR2t0bWF2TmJTVEFuSjZG?=
 =?utf-8?B?dlNoSnFSOUhPb0hYM1hKcmNpaVVGbmRDK1A0MldXNzViTWUwVmJzRllrOVZI?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	akNlo1J8hQYT+5WdWVw1LbDvhvLFYW7KI7RPNjtLg1pvl9anFPScrJews1lpwKWf+Wn67mXGrhrz61UX2RssgdHDuUQrBncuLjsiFMCUKQnF6vQuatEmfAQqVf7XFaWNd8SlAY31Fm5meQ6oEi/1cC9SmjAgnjc8Ev3WKQXW3aUghgNJd9yUSO+afjDFAMmytOTBhhUGVIS93dkINE8q1dXRZn34qQmZuSTDgnnYGksYyRTE6AjjXhj4CzfFHu2uhn1GY2ACtIEEETjnJqmP8D00YApybbiYwLVb2nYPRF6ysOlrx5yATInJ5UaYyx3uxu5WWpncjFAMqLXMkWiJ9ccU417cKOg3mqdQ+s6yv41w+FUcBx0TnFTg6r5k8K4sd+98WaPQ+XZHaISkBskoUq96S2FAubyoyJ4ICahwnpfeoiXU1zp9AdaIgg7dGK+hSGIRHIEVAd1ccGFH5CSypuXQAM9asIlanPoeHvXD7JorTyApdzW4cyth01KOucXPzxGl+OnTskQ9+gRYITeJqOBTM+/V8WLIHsSlQ5r1mCCUVwLKMe4jnKbneWFciBvq0eWNQnqjJWIjO2Dnxnez4ROXQE/ePtWBdlhozymYGKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0f3ef1-0fac-4904-88b5-08dd2fd9220a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:39:38.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFmh2i7mCavP0BiQnwGDYMIj2j+KmfAOqPzE7x2avk3cbRPO1pIYeH7crAFbYobI/kyp3AIr5cc9tsu6KVUkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080095
X-Proofpoint-ORIG-GUID: TEvougj4DJXK9vr2tdd_f_ZAl_lJIZvS
X-Proofpoint-GUID: TEvougj4DJXK9vr2tdd_f_ZAl_lJIZvS

On 08/01/2025 01:26, Darrick J. Wong wrote:
>>> I (vaguely) agree ith that.
>>>
>>>> And only if the file mapping is in the correct state, and the
>>>> program is willing to*maintain* them in the correct state to get the
>>>> better performance.
>>> I kinda agree with that, but the maintain is a bit hard as general
>>> rule of thumb as file mappings can change behind the applications
>>> back.  So building interfaces around the concept that there are
>>> entirely stable mappings seems like a bad idea.
>> I tend to agree.
> As long as it's a general rule that file mappings can change even after
> whatever prep work an application tries to do, we're never going to have
> an easy time enabling any of these fancy direct-to-storage tricks like
> cpu loads and stores to pmem, or this block-untorn writes stuff.
> 
>>>> I don't want xfs to grow code to write zeroes to
>>>> mapped blocks just so it can then write-untorn to the same blocks.
>>> Agreed.

Any other ideas on how to achieve this then?

There was the proposal to create a single bio covering mixed mappings, 
but then we had the issue that all the mappings cannot be atomically 
converted. I am not sure if this is really such an issue. I know that 
RWF_ATOMIC means all or nothing, but partially converted extents (from 
an atomic write) is a sort of grey area, as the original unmapped 
extents had nothing in the first place.

>>>
>> So if we want to allow large writes over mixed extents, how to handle?
>>
>> Note that some time ago we also discussed that we don't want to have a
>> single bio covering mixed extents as we cannot atomically convert all
>> unwritten extents to mapped.
> Fromhttps://lore.kernel.org/linux-xfs/Z3wbqlfoZjisbe1x@infradead.org/ :
> 
> "I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
> document very vigorously that it exists to facilitate pure overwrites
> (specifically that it returns EOPNOTSUPP for always-cow files), and not
> add more ioctls."
> 
> If we added this new fallocate mode to set up written mappings, would it
> be enough to write in the programming manuals that applications should
> use it to prepare a file for block-untorn writes? 

Sure, that API extension could be useful in the case that we conclude 
that we don't permit atomic writes over mixed mappings.

> Perhaps we should
> change the errno code to EMEDIUMTYPE for the mixed mappings case.
> 
> Alternately, maybe we/should/ let programs open a lease-fd on a file
> range, do their untorn writes through the lease fd, and if another
> thread does something to break the lease, then the lease fd returns EIO
> until you close it.

So do means applications own specific ranges in files for exclusive 
atomic writes? Wouldn't that break what we already support today?

Cheers,
John


