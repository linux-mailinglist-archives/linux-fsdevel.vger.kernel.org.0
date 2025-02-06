Return-Path: <linux-fsdevel+bounces-41054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDFA2A5E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC731668B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016822756A;
	Thu,  6 Feb 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/SzeouW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uXragZLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902A22540E;
	Thu,  6 Feb 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838145; cv=fail; b=JZct9gUsjJOF7ewbH4MZINhwqFu4n4BbHIk3Io9HBtlLm8n8uMMyU5wvLzol2eMewjnMbehheFnk29mKwoaNjqALjP2HOkQPThlZ5bxZeSD1UJ8Qxpen1kPtvz4v0hzS/1wWdbJaN/IXsXujj1CrPiton4Hd1tysFuQcxRqH8rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838145; c=relaxed/simple;
	bh=vF6Qd2lAklU2z0OqGsNgtdrasz6JIUWFQDYF5C3Hat0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbefVD29vo4bI21lEtIZ99saTFA5/9AJ9Ctdyj1UMdELujgidJuo8QkszFUSIulT/CCCTan65gNSlh3CC3yRM9uc+2qTBva4ignJhqwtAH0i09pGPxtsvaQJdZ7qlEO+UHRrW3rM73+Le5T1lqRdYg4ehr9rY5TJqozxoW2jsQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/SzeouW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uXragZLi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161fsjf018457;
	Thu, 6 Feb 2025 10:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p27Y0EgGAu1l7zftmm704nMrClcIYRAVHYijbEsOMdM=; b=
	T/SzeouWKnqbxiH6cw4SYpR4xv1ZLFVAK6wLZoqQtcF0NaIgOnE+vJ1oYGxuRNWt
	6KxpxYstXqaf76UFC1g5j9katAK3G3dL9UqYExcuC37Uh3SZO17fGoF8WFLC7m4Q
	Y9e8vjs/SkOZbivbZrPfYRs4MEq5MxnwTBq1kWaZXIPyWfgFL9kQX8YV0w6BoabI
	vMGM4jHD+q+02LjIG3sf7WsKhLit5QU/ERLa4kpVpN7SuUByjzBrIUKddgYUXsXF
	yIUCroSJAMg4Z8/oMLpvO+U0LD6vm2Lnl4sSti9zzeojFpbnccVFbwLVY+7dU2OV
	1pBbfSGUs4CGWbk3eaSLKQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy88vvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:35:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516AHgXj027941;
	Thu, 6 Feb 2025 10:35:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dpwtu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0AFIiIZETg7wkHQwMtCUM4v3jbO72EtBpb3yV31EkFizh1lr3tHTYB92Tty1ErVDsLOJHTPYrXxm7k7yMYh8kzYxjOvrvXX6Dgf/rk0goNpsSFeL3ov24RhEVwj7KBrK1OdACYT9r4sW2emtQ3OHSYw4wqyTwwc2nMYVx2MRGOgOU1NvOxoCXenRHhqCSjqiNmzlVr3oaFHs5EPlgVrPL8d/rXFhydWmnhwJmty/KKxWUZMZB+sV4/jMnBWMg3HmG7qD4F3YSVXp9t1oRMTlvpXVO7gCHjcu5KbpXXj0Fo0qfGK7K0UmLcQW3dFVtjaYhgGUdqAMcKEA6WvAEKXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p27Y0EgGAu1l7zftmm704nMrClcIYRAVHYijbEsOMdM=;
 b=SD2z7Ls1DhlrIJV1mjbVF9KHXq+FDbdkhdfBYDZVf6fNKb+6Ppb4JCcIK3BIT6SQcQ2Pcs0YNOFSZoFJ8by3wcO86848ZFlrkcBqj90HfWGunfZ1pEA8yGhETbG73hptoV6njtSYSCGoHqzIColmqhPojAjjPUk0+BlqiPt0gumT4gMpda0M15IA+ZmYRfPWPVWwgCMyFqMNqhcJYUeI9jqE20TKBuKUYBLBJSu8S/97l/s/teEniiHVwVRoVhdbORqaoQGJr94WwCw7noO+MSXLbrE3K3R/IQdNtiOAKslhOnuCLmQBMPx9glZX6eABw/lE/h9newkXsidnzB5XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p27Y0EgGAu1l7zftmm704nMrClcIYRAVHYijbEsOMdM=;
 b=uXragZLi+kEm8XFtNrffnByS65VFdUsJSVRwnotGzBZphWVGMcPmHEHGAjdp+WufgsuE3c0sB2s4c9ossjKPppcgdS8I3v2BUQxoy7LtljQPUaleo7aX84a3S05WtBbEkybwGXVenLcJ9/GfnuZLx0PmuVawJ68EeNpys4fiwpY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Thu, 6 Feb
 2025 10:35:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 10:35:31 +0000
Message-ID: <d049cabb-9535-4a1d-ab01-61512c041af8@oracle.com>
Date: Thu, 6 Feb 2025 10:35:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/10] xfs: Refactor xfs_reflink_end_cow_extent()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-3-john.g.garry@oracle.com>
 <20250205195050.GX21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205195050.GX21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0606.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: d33d3a44-18ab-4540-4b71-08dd4699fb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERIUldEc1hPaE9mNCtZbHNlTW1GZlVaUGJFeStRYUJ4OHRwR1JHQlhqUDJK?=
 =?utf-8?B?RXpGUHFuay9BQ1ZQdmdncWJhOC85dXo4YnYvUzFPcGI3R3ZsWXg1Y1RuK1RH?=
 =?utf-8?B?czFpVy9QNUVTWGVYOFk1STJDRE9laXVHNFdwejR6cEJUSW8xNkROeUNPZGxI?=
 =?utf-8?B?a3VGM091YXJUNFlkRGVzem1ZdG9kd3ZndFcrN1JDYUdhWWF5bXk2ZWxKajVX?=
 =?utf-8?B?MFBiMW5Yd3hneHVwZFdkeEwwM09ERlo2MWVnZG1nbWxyK1o1NTA2UzdPTjIr?=
 =?utf-8?B?TDZEdStiRXpBWnNGQTNDLy9aaGdEWExwYk0zQXplbk0vME5UZVZUNk0xL1p0?=
 =?utf-8?B?SlhOTVlHWEtGSHBpWWRzMmM0YmQwaTJEZXpmQmVrTXQ1akhSdE9HNWxkdWh4?=
 =?utf-8?B?WFc1bGtXRTI4R2VpcTdMbmNnRytPSWpiQ3BXSVp0SjZZSzR1TEJlZWdNODhH?=
 =?utf-8?B?K243QnFmN1dzZUpQZkIwVDJkYXlzOXFtQzlUN295cXF5cDhGb0F1OGZHZlFT?=
 =?utf-8?B?c1Y5UXNES2FXRDM4Wms2Nm0wekw0MEE2YzZKOXdDTHVPSkxZNEVibzFRNDVN?=
 =?utf-8?B?SU94Tk5VR0NxZis2NVFSclJFNnVkZDZ1dGkyR1BNSXJPcmlSS2FtNUY3WHhB?=
 =?utf-8?B?Mm0yV3NUaElSUlkwMm0wNzlWaFJCamt4b1pMMkdlQUdDU1k0WXJDbkZoenZM?=
 =?utf-8?B?N2J5d3dZTCtWVFFlNzFPTXNoSS9UTmxET3VvRUltT1ljVGw3OTlMemw0N2VD?=
 =?utf-8?B?bDVEd0ZXSG9ZQUNhTVR2M1N4Zmw2amQ5NTNxRUxacWZJK2x3YjdHbU1MQjNk?=
 =?utf-8?B?N2twaUpCa1NCTjh0NjJacWlHWWcwM2pNbWtoREkvUUV2TjFXOGxzTHN5NHlO?=
 =?utf-8?B?OXZoUk1KbUhGRHV0NDdSVERua01Pb2Y4QmoxMG1jWnpuYVNqWW5ta3E5bnVq?=
 =?utf-8?B?ZWhaSVdiZlhoTWxFRWc0aWpibnB6bXRDSCtPeStDbG43dzMrRTFVbEg3aHBl?=
 =?utf-8?B?blY3YTUvWjV0ZGhpbmROWUtxWGYxb0x6dXpuOFlEbVZzNVpUcHFXbUZwZklW?=
 =?utf-8?B?V1VIQWdmR3NWOXEyQzUrTk1ET1lnSk8yZEIxam5pejRZaUVKRGtBU0U1NC85?=
 =?utf-8?B?SmNQWElPVTZIeDJhRWpYZlpSenpZTlRoYW9KRmpGMUFtejljS0dzN1E0NUpF?=
 =?utf-8?B?VG91eG03T1FpRDRJLytpeTJkcmRycXhmcE9WeGtid3lFZjJhRVY2QTFyblIw?=
 =?utf-8?B?dzRyYVZqcmZLaDd3MVVmSy9rc2lSV214bzFkY01SNk5ZMG5tbERnME5XNFhh?=
 =?utf-8?B?VVMxVFlUclM4cW9DQjd0dSttQTNCcVRiVnlWSndQRGVBRG94RW92QlB1cmsv?=
 =?utf-8?B?MzFXYkhlNmhaUC9XOGxLbENZbDQrbnE2eExTQlZIVE9COGxJZnVGWWpwa3Rl?=
 =?utf-8?B?czVLVlJXby9mSXZMWEcxcnF0UzM0ck1oMkxLTkswN0lmU0lQN1hoWTVNN1NU?=
 =?utf-8?B?Zkl6czdMWUxFeUdYbWZGM3ZlVGZPSjdZK1d4VHN5K0k4MldBYkt0UGQxNW1O?=
 =?utf-8?B?cUFuUmVCMCtzTUtxMk9WNFZ1emxwZWlIZkgxWWJGSzI0TUdXbi9ocFRzYVdt?=
 =?utf-8?B?VnZSRmUzekZTYzRUaXJoMWdnODEza2lVNEt0dmRsbG1jUE5xTEYvL3YvL2Vk?=
 =?utf-8?B?NjgzeXV2YVk3aTA5c052MWpWL1UzRm9uT2FqSitZTGJtaHQ3WWdXYzZxV0ph?=
 =?utf-8?B?Qzd6MCtYUExkMHAwZzgxQzhhWG5NV21RY0hURVRXTTdtYklCY2JmbjFqeGlD?=
 =?utf-8?B?VU1jVFpGNjA5RUFaeFY3aXhQeWQyUzN5WjVRYkQrWjRtMlU4LzlHTUVSQWp1?=
 =?utf-8?Q?2O72PZ9Mk7r5n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFFDRVJ1MzhCMGswdEFnYnR5Ym5qK2dFNnJRRThDNDNaU2Z3TERLV3FBK1hH?=
 =?utf-8?B?cklML3U5VWp2VUFpejNJbHJ5aWhSM2JxUmlBemF4QkQ3VnVNdy84cE1XVnFj?=
 =?utf-8?B?M0pGanVUSW12NlBQM1FhVE52M3NOcytoOVYxdmdwd2YwZEJ3aHR0UmNXSHVZ?=
 =?utf-8?B?V1gvNkF2TlY1U1AzRXkzcXhXNkFlM0YyR1h4T2RHZ2ZnSjV2QTR3NmVFZDR1?=
 =?utf-8?B?aTJRN2ZRVHJOMmVHczlySitCNFpoaGY2Q1FhM09tTXFWaUE5UFBjOGtqSmtu?=
 =?utf-8?B?djgvWlhVWjVpS0U1KzhVb1JVWVRIY0dDdW85bmIrNURUYjdrRE42eGNzYmkx?=
 =?utf-8?B?YTFTNXh2SjhXZEVjamxtZSs1dkVBck9uU1pONnVqalJGUUMxTHhPR3Ewcmkv?=
 =?utf-8?B?QVB6YXIxdWNRVm5DUUpTazlsa0V5c1poZDFWeEV1REk1cWVGY0tpcGFRT1M2?=
 =?utf-8?B?N3pUV2hYNlJTZ1BqdHNEVzNnaG0vZFV2ckNjRU9IamJmdTZPUXZXQ3dLaUpH?=
 =?utf-8?B?TDFocTlFVlQzbXZrZ3BFSkpVTFRSS21HcUxFQUdSampEUmk4dk9qejIvYXY5?=
 =?utf-8?B?S0ZNc0h2ajJYNGo0azR1Rk4yQWV5L2picjhqc1E5Qm1LWlhEeEVvdWRtMXFx?=
 =?utf-8?B?KzJqejdtNUpVUVJWUXBJOWFEOFZ3RWdrYllYVzlNaENETWo4aDhTRDhvRG8x?=
 =?utf-8?B?RjU4cVJyUnhSNEUweE9YTUtZYnk5SkZWNXJlVTBvZW5keVBkVm5vSUN2bG9U?=
 =?utf-8?B?UHZEUDdLVWFuZXdWNUlBSzNPblIxSzBMaDVGTVkvMkxoRUNBODJ5VUhBRkFp?=
 =?utf-8?B?Skx4dGlubnd4aytUVzFyYVhkSWV6U0Qxdko2VDcxME9kMjcxMzN4dWlPSFBG?=
 =?utf-8?B?L0NUeG5zaFRRVyswbzlGejFMTkJvVi9mM2UxSjdBQkdaSU5VQkRiTmdqRTY0?=
 =?utf-8?B?UnIyUGUvSGFYMEY2NFI0RHVjT1lEVXdncnQ5b0szVHI2bnRBOVZuOThmczBv?=
 =?utf-8?B?NXVwNGo5Qm94OU5GNm8wU2NINDRlN2NwSEd4dGN5dktoRFJidGsvRUpIbThB?=
 =?utf-8?B?WGVLYnk0a0lUaTB3anZOT2NpVmtNTXNnUTEyZFdLNm50SyszRmw2c0dBOXFt?=
 =?utf-8?B?YXlLbVEwS25YVnBTVmFRSFhXb0NZWUxTdHhEejdYdC9xR3AwN2ZoOEYvTFNP?=
 =?utf-8?B?QVRoZi9jR29zMEhraWlheTIwM296UFFBY2VBc3lmWWl0cUlHbENzMmFQbTFi?=
 =?utf-8?B?eDEyZjdDUWwxbUxhMzJjTmV3NjVIT2hHUVFLeElodWd6R3E2L3JtYVZpZ0FX?=
 =?utf-8?B?WVBndUdsbWFHS0xZMjVTWFBrQjJvb3lHUXAzZWpuLzdTdjRqS3lyN2IyTklO?=
 =?utf-8?B?NkFJVzljOGhTZTREeHAwM2VybVU5VTdnUzZFcUlBKzlaTmZIWjd2ZC9NT0ZH?=
 =?utf-8?B?ZFZ3WmlhZUdsYndqRWJZTmtlNWZvTnlOR29UMmZ2aUpSTVNFVnlNRmFDQTNY?=
 =?utf-8?B?WnNwdWZwOVBRLzBGb1NEdld6OG5SV3dqeUZXN0QrQ1lxQ2lsNC9jN1cvSkky?=
 =?utf-8?B?SG9XbEcwdmNJZ0Ftb1p0Q09idjJoTEprbGJjRUZLRUtsQUpyTE04dGhYY1ZF?=
 =?utf-8?B?Nkl2aU1FNHNURWRMa3RqTHlQUzlVdzdIRFY2UkNMRnRpM2xBcS84MlpPZ1JG?=
 =?utf-8?B?enJNWlFIV2lPY1V6dW92R0NzOE1SS0lTOUU3T2QvcVY2eS9RY3JaVnMrYlZE?=
 =?utf-8?B?TjU2TFpEdkc5U1Q0S2FFeHJYKzB0cTZGYXMrWHlrZkdoVFYvNUJEVTVCS3BT?=
 =?utf-8?B?Zlhwenh4VlJ1VEJabk1CNDdFL3RaR0pieWhMYjZST2pIOVVWanNIYmdJaUlK?=
 =?utf-8?B?TG9OZVRibzllZHdLSnlCQnBiTzY1dnBWdlFzYlF1cXc3WHI4NXZNQ0FDUmh1?=
 =?utf-8?B?YXhmSmhmWGFLeVdBV3I0Z2JmUFhtZm5pR1EwQmxvcWdaT0lYTGlCcGJEYW4v?=
 =?utf-8?B?Z2xtQ0d5ZjVLWFRPcDFtMk5IVWFPdVJrK251MEpWK3E2UmN2ZnNBQjJWRG1M?=
 =?utf-8?B?OE90ZmVrVE9lUUlLMjU1NFFKUnlGTk4vd2Q5V1o4RW0yYVMvZ3k4REVKb3JR?=
 =?utf-8?B?dlZ6dEZxY2pHc3YxK2QwVEhjQU5sNWY3ZXdGcG9wYzhMWGQ3b1Rla0wrZ1I4?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pg2zh9lh7PGoG0WiBVPjiR8gzOKrVGGT5ezlWY7cn4Z/IZ1/gPySrPHK/qV+0MbAz0jCwPFgQakVVgvKwznR7kN7cukiqzBUo3eX3wZtopGAZiXun/S56X/JQWANEZE9uUb4feZnzzManA8OjCkX0u9lDy1o07ekpsp+g3F0G5z67B5KNvmnQlgsp0KWdIbbPaJXQxfvwv0YTKLSPHOog/r+rkP9J05DZ1B4UCrjbNfGhya5FAeED8paFf68uaS0kB9ZrdXAuMZOUwZ44dKUwbC/0cHLjxqAKhyCuF8QfbPemNF/DUtwNni2bfm4XxjKDj8j7aWlqE9Y/pntk95+A+BmK/Q2mNoTnVZE8jZWN4du4At27fwi60PaG2YmlPN5KgVeLaLguXMoNZTrjZ9/g4U1MIJuHkqAEE09HfWl5s8soNiYGlIEmVmgG4bzdkrJR7T78V9ps1ISOgbc3BXg/e1zoGACE47OeAPVzqQyplnNj4ZY5ep9Kx2AWIGao6G0kjt1VIkn+1wkAAcuYzVxTHWEokSdIzcx3dq7I03uZtdegODVMHaGs3LK/VsmbBfA06f9bP5N8XH/VoAj3oZD0LSmxd5Q4vlr7jHaY65TM7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33d3a44-18ab-4540-4b71-08dd4699fb47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:35:31.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHqen8Uu5N1WYk13SbVJpgFQZ4+xncr9ukJa4LalLu8OjgZuJLmX0oD3sNj7bVHp9Y9NEBcp8Xcvs9mROyL/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060087
X-Proofpoint-GUID: ToOzvr9Z6ACNfZcmPSojq3zZQucPPc8I
X-Proofpoint-ORIG-GUID: ToOzvr9Z6ACNfZcmPSojq3zZQucPPc8I

On 05/02/2025 19:50, Darrick J. Wong wrote:
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 59f7fc16eb80..580469668334 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -786,35 +786,20 @@ xfs_reflink_update_quota(
>>    * requirements as low as possible.
>>    */
>>   STATIC int
>> -xfs_reflink_end_cow_extent(
>> +xfs_reflink_end_cow_extent_locked(
>>   	struct xfs_inode	*ip,
>>   	xfs_fileoff_t		*offset_fsb,
>> -	xfs_fileoff_t		end_fsb)
>> +	xfs_fileoff_t		end_fsb,
>> +	struct xfs_trans	*tp,
>> +	bool			*commit)
> Transactions usually come before the inode in the parameter list.

ok

> 
> You don't need to pass out a @commit flag -- if the function returns
> nonzero then the caller has to cancel the transaction; otherwise it will
> return zero and the caller should commit it.>  There's no penalty for
> committing a non-dirty transaction.

If there is no penalty, then fine. But I don't feel totally comfortable 
with this and would prefer to keep the same behavior.

Thanks,
John




