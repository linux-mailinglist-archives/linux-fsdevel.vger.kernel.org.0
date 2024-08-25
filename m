Return-Path: <linux-fsdevel+bounces-27066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B695E42B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0621F21327
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F91156C62;
	Sun, 25 Aug 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dhtYlIN8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E5nOSdxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10227679E5;
	Sun, 25 Aug 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599995; cv=fail; b=RgciEbD1DugSQauqVBZKUc2oMWWOGH55M72gNxN4E0leUjo0bN4VLQNUUhZ5ha/CNcP5RRQagfngDdu6GVtHhxPBvX8SWauvUd4FwVXMLiDny1W16HR08FDtYL7W4OQEHvCzoWbi+QB2x00hnNIfKzsSOmY7jNQjBeinVI3U+DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599995; c=relaxed/simple;
	bh=kaOozi8+Rg3PX+1ELvN7rVCF1OKWAIxn4t1PSnEzCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PX1BuUnWI2ILSJGe3qKotWFZ2oUpypw+K/B0D6VrV/MCl464+wXiYWoh/puLAJ9hflif0Nl358fueo4BaF7qvz4C034N/NxLmQM4mf7H5UjKvewxhJLyCn2jvdyzAB7FjHWTL0THtaMEyml8JuKQvznRtNw/3a7bn/Ig1txcOuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dhtYlIN8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E5nOSdxI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P6o6bg025529;
	Sun, 25 Aug 2024 15:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=ls9+zWCL8B7jEPnFMEpfaYwQ93MA29JD2QmF1B1TehY=; b=
	dhtYlIN8iyJFKFHevufbvnwhufTKJsOrs9xRfUReaVCydkK/KympVBiysV41jw59
	BzR2jM9RPmKLCkMjWrzx6QlU34fN677qzneqck3W+O+ikSLyPDC5Xgw2XZVrnRPQ
	qLfu3KiFdXaMEmRvwBAZHj1T/v3o4rqz/lrh7xuWGFrl631czaUGUMeEj75OszeG
	WbJrvkctr4pCuAeK8d5y8MuT4ZBHUAsu0EktYhOBrOyFoGig0AVV0bg/tVhAS8jL
	bBdeLh23R1lF3N6ux1AMwxOqhXXENQn1YuETpdcO2spsWmRqd2i0lrjNS3pjpnBQ
	voxcZRcEx/liI3gquERYJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782ssjna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:33:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PFJPix021910;
	Sun, 25 Aug 2024 15:33:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41875705b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Slz+4qbW/qCIHYT26QcX34nfS362pqF6JR3aSw0WM5F6F0lf1/ruNVGy/ShmxAelRE73xmACS1UFQDrr2CnpevKssYYIiodPrk68soRQGYsLzy+V134iw7W/sX1I7eTCvHOG7wGQM0u3jYgZtPP9ED4jiW+NiU18q5DfTJCDjIMVaMjfbVjACtbx353Gyopf47a47/+o9H99af1Id90g4Uo/j39BUxqbXVEbRMQ0YZI6Vu2inbRIugmPFEmCMfDS5FhkjaTUcMg3UpfX+Ks0WDAyxEcXqnTWKPHNGn2qZMx9/IjF+ln+p1ar7EMBgrVwCdQwxWfFHy71bHw6oSQKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls9+zWCL8B7jEPnFMEpfaYwQ93MA29JD2QmF1B1TehY=;
 b=qO596hGX3iRRNGQHXE5NktzcEVasqLMgYThY3OMWQcRpBRyU++5GQme58TOHRITdbEByAdsmHO/0iRRbnAkvhR8bNsAoblZAWMt+WujotYyp4fund2X0KtcqWvPGZchz9PVCH8I+JD+ELkAs5RoXeeIklPFh3RLyoVPvokhsExcd55+f4ZjhKWfc0vqH9Zp2K+CalMT/hveZIBMThKjwyOV7YC8CofvvY2Qi3LUr9v5oHJeFcwvX0jyZ1SPwPwVcEcjjAnWlkNuuB7e53TYwn6KJI0iy400Z5atXhzQ7lwRD/KPEvlPj3qH0UP3Vrg3vQ5HCfAZQ+0uGIt6HiS3fUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls9+zWCL8B7jEPnFMEpfaYwQ93MA29JD2QmF1B1TehY=;
 b=E5nOSdxIPRfVsRIyzwVeJ4CZ0JDC9/pdod9uTiL6tWez3ssGax9xwCA0ksj9h4nsjFjNT+UNTs2qMTbrUHYl+EpSv1l0P31h6BdF6szSN/LcCAx1hKmpjbqxQPbk1cykgm9l9mX1XZvCswKgrFTUyZZ6tdkRgdKtZi3ctyk97dA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sun, 25 Aug
 2024 15:32:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:32:54 +0000
Date: Sun, 25 Aug 2024 11:32:50 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <ZstOonct0HiaRCBM@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-5-snitzer@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823181423.20458-5-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:610:38::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 0546026e-e6ad-4b55-21d2-08dcc51b3014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q215bzd1SWkyU2F4UTlIMTRYUWJOVHZKVHFJb1pPRlJxenIzTjRNbzJIamQw?=
 =?utf-8?B?bmZaN2EwZ3BlTC8ydkdqWWw5SElEVHF5K2toL1hLZ2grOWErQkQycVZUNS9t?=
 =?utf-8?B?VEpYSHk5bFN5b3BoR3ZHdWVqalZBSlRLN2F1TTgwOUJyd3VDaTRxaWY1YURJ?=
 =?utf-8?B?NE9xUlI0UjhWcXVqMm4zSXdhWW82ZFh2dXZlbUcxRVFnOWRaaCtRcWpBQWRs?=
 =?utf-8?B?c3VCT05MZ2YzUUVJZ1BnVHVZNTRzcSt3NTB6cjFOZjJvc0QwQnNYbGU4UUM0?=
 =?utf-8?B?Z0JUQnFlUGdvajJaRWVuZHVjRmxnVmJRMEphbzZPM2dnRjZaaVMvckUrcDZR?=
 =?utf-8?B?OFFsVXBteTRDNitzdVFGaWF4RnRWWkgrZkFYbjBlbTFVSWlhVUJlQzRBQk9L?=
 =?utf-8?B?NldWdGFCUlExakVzSVNLV2d6SGdwQ1VrRlNvRjVGcWczWm5GT0FrUGFSTDVX?=
 =?utf-8?B?aFJkR2pTQXlZY2haY0NJL2JWVFBjZ2NZS1hXSStWLys0aG1CaVdrN0dpbUtN?=
 =?utf-8?B?SU13QSttZGIwcDdSS2VaWDBNejNEb01LelFPNWpkWGJyOW1vSG1LaFE0VWwx?=
 =?utf-8?B?SXVmYjlRVVlkNnA4ZW9vZEJtRitJczRHQStwcVBMUFJkSy9JWTFkZmJOaU9p?=
 =?utf-8?B?ak45WnY1Q3Zvb2d0Um13ZnU2K20yN0JLNU9wQzdyNjc2c2JDRGZlQTVUYWZt?=
 =?utf-8?B?WHNrQ01OYVpKMTV1c1JrMmRpbHlvREVXZHA3L01aSXpMMkpYeTZxL01TTndP?=
 =?utf-8?B?MXA5cmV0Ulg0N0V2NFN6RkRudlhhTkpiTVcyNUFXQzJMOC9hM0pLazFmYjRl?=
 =?utf-8?B?VXA5SVFOWm9IWVB5RWFjaURBQ3dxRlEya29XOTFpdVVUYXhxbXpnbjVJNG9X?=
 =?utf-8?B?aG0rSHpKS2FxdUh5VWlJVFdhVzdia3hKNGVqam84V2tuM1p2azhscHVBU0Rk?=
 =?utf-8?B?Z1hsaHc1aldra1F0cmFHekV5V203aSttcTF2d2g2cStKZWU5NGdJcTYxRWtJ?=
 =?utf-8?B?Q1g2aHZJRUNlcUw1TE94WXRTckJrMlRDTUhUR2lVemQvVDZXaG5ja3U0aFpX?=
 =?utf-8?B?UHZCYmoyNVE2YklhV3VtKzFYN3phZkozN3gwNWxLWnJXc25oN3UxOHllS1FK?=
 =?utf-8?B?cVdIUy9SN0lTSUpIWTdudEY5MXFJTGxDVUwrblNQS0N6VUNUOVVueFRvbVh5?=
 =?utf-8?B?TnJTbXVVUFpBUTJ5MkRXeEQ4TkxHMmcwRGxpemJrdUY2Q3JIa29HT2xjUWpK?=
 =?utf-8?B?R1RRSlhDbHNIQ2lTc1lYZndLeVp2VVZLdm95MWFVWE5GamRIRURVQmNHT0lz?=
 =?utf-8?B?amFaZXdPanZWaHhjbk1FUU96VnlnK1BIK05RSFVycWFpQWJHZVJoVHZjMjVF?=
 =?utf-8?B?dnRQZnh6bnBKVVozZUNHUlJXTm5VZEZMUitNNmxUT1Bpdi83UWR6R3JvV2M2?=
 =?utf-8?B?NHZxdlFnMUE2azc1MXkwZ1A5OE1pVmRtN1RoNlZxK1cwR2NBNVRkK3oyL3VS?=
 =?utf-8?B?UTRDOHBKb3NnTWdRS1crQzlYSXA3QzAxVzArQytpQ0YxQXBuYUMyeFNiNDZn?=
 =?utf-8?B?WU5wRW5acjcvRXdQRXR6bmUvVDhFa0l0endFaUh0UXVVZDZDdHlvQ29pUzZF?=
 =?utf-8?B?bjVmWEt6Yy9TSzdXTmtGRjRwZEZjcXY0RlZFUE9VcmZaVEZLZUVMNmVmNTZV?=
 =?utf-8?B?QzVta3k4VlJnNTR2WVFMdktNT1dpZklpTTVCODcvR1pKSzBnZUtPZS94RFVL?=
 =?utf-8?B?SllJUzdyQXJqV1BJdXczSXBZQlRwbDI1eXRjcitsd1k4dEo2d0lWUmRKemx5?=
 =?utf-8?B?cWVvdlIvMGJGcCtsR2NMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FBVEcyRnN1dlZCbEl5Mi8wdEsrVk51T0tvSGxyWlQwTTUyaWdqR0hCM0pJ?=
 =?utf-8?B?d3ZWQmlwN2pLMmUvMjI0QVFET1ZSVVY5UlVUa0pnYjA3eG1OaFFFS1BDQ1FP?=
 =?utf-8?B?OGlMVUJnUUhmL1hSYm1IS2wzNjVyb21zblE4MkxyT3YxZnkweU5CTktSZTRp?=
 =?utf-8?B?ZFJqVnFOYVNyci9veEdKeW1GTnErYlNNeHQ4TWF6VHNRNWIrdXo2MXROWFQ3?=
 =?utf-8?B?ZDVtcjJSRmQwTjhIY1pKOTVlbHM3RSt4cTFpV3BFOWxvSkxjcHJYRWpEcnJD?=
 =?utf-8?B?dVF1cTB6Z2Q3N05kM3NFcWJObXNNSWVNZWdMM3JHSlB3Y2hEK1c5TjhRVW1r?=
 =?utf-8?B?Q0R6NzRNNGZ3OFBBU2UzZ3hrTGpuNzVFSFFiZjBhQ3ByM3plZE9WaDZLNmNu?=
 =?utf-8?B?SG0vTnZqczZoMGt6MDBKSEVRSTJ0WVZmTExLendwNXYwWW9nQ0c0aVJTVUFn?=
 =?utf-8?B?amwxcnBkN1hIWWxHbExkcGdVeUlQQ0RGbENPK0FhWDNUUVpGZGMzd3FMZ0Fi?=
 =?utf-8?B?ck1tdXBqdWQ0VU9XZmR3cmRTNWZDUEVxcTJMMFJQdG5mcy9kcGlyRlV3OWl4?=
 =?utf-8?B?dFF3S2RaSEJQa1NZSGxhbUM4TzBFYmZWYlM5WHNmcEU4NU50Zmw3ZExaZWND?=
 =?utf-8?B?NGR2RjlKM29aNS9TaGJ0aHAzTG53YU0rZjhiVE5kUmROQXlQZnhjK2c3T1N4?=
 =?utf-8?B?UGlhR0tMS0szaVdYK1JreUkxbzVESEVmQS8xYmtQUk12OUQyMW8yWUpudjFE?=
 =?utf-8?B?eEdkQ2lSUisrOThURWxoOCsyalNmRHo4RUpmTnFkd3dHcGZVOTBkQ3g5Z1ZT?=
 =?utf-8?B?R3FYVDJRK21jcjlhN0EvaHNMU0VzL1BqSTRWNGZwQllOSzlqaVZiVEpEMmo2?=
 =?utf-8?B?eXF0cjVhckFpY08rVkJZNnVJTk5iektBb0w4Y0V6TTdDSVVWSEsrUWZ5SkYx?=
 =?utf-8?B?bHFMQmZ4R1hKTVBLN3d3MWgxaE9PeXFOTnFmUDhMRlVNVk9HN216UktUK1ZU?=
 =?utf-8?B?T1BTZEdkR1ZkYXAybmNSd3l0YzFhTjVXQjdITHU1aHVBVTY4Q3lmejdUcHU2?=
 =?utf-8?B?UFMwVTRsSjZEOThHc3N6a1ZRYVpqYXRWdTQraWJOTXBuRzVwWVJXNTY5aFpx?=
 =?utf-8?B?eDA1RmRNZ3JLNnVMVTVjd1VpTDNHOUpFbDhFZW9UVjM4ZjhsZWZmVDliZk1u?=
 =?utf-8?B?RERtVXRoeFM2aHR2cW1TM1czVm1HdGdPRGV3MTNVeEFPRkJERlpFNm0zckVV?=
 =?utf-8?B?RFNOMWRFYkQrV3RDU1RMMFNrd2x1KzJId2gzNlNmT3l2V3JLRURieThCSEJh?=
 =?utf-8?B?VCtickhUM0pTTjAxT1l2cm9LQWxBWTlLVVloSmVyc1JBeHF3b3pRTFVUdE5a?=
 =?utf-8?B?UHlDQVdmaFRERzRpVEZ2c0laRk1mN0xHOGxhZVFnYTNxQkpDVFpwYkJpOW5i?=
 =?utf-8?B?L3B5TlEvRXhZNHNYaDRZRThRczJsNVJJUUYzSTRGTE9PQXo4eVF4Uzd4UHM2?=
 =?utf-8?B?dWo4NDNoZjk4c2poNGppWEJ6VURHcmMxRWYvbFE0dWZlZHl2NWx2bTNLcHNB?=
 =?utf-8?B?dE9LZmZtMzd0Vm45UEJxOGhjSENxRWJmY3l2ZFFZS2dSUHk5RmNRd3JGVU9X?=
 =?utf-8?B?dDZjZ01hTVRoTlc3eXhkRnR1aFZoUThRaVdCWjBxRnczUGlLQ0dmZTBOYURy?=
 =?utf-8?B?YzUyV3FRSFM0UHJSMjhacjMzTGVjZmdMU21mbUVnMmZaL0YvOXhaZTZ1WVNW?=
 =?utf-8?B?d0EvSzZaL1hFbFEzdVM5ZXM3NnlwWEJXUFVZbDRITzVqNlNvcjlwOEtSdGNU?=
 =?utf-8?B?Vi9sRzAyUy8yc0ZIclV3R2FwSmlLaHc3OVlDMFViWmEzajVlWmNqQ1JuZFF3?=
 =?utf-8?B?YzNJbGdxa2JMZ210MDg1OVh1VzVENE5oL2tUTFlUNlBnUmtGakFIQittYXN1?=
 =?utf-8?B?R1dCS0drU2F0Tmp4SE1BMTNKalZUUGloRGhpZjFrYU9EWWxUUC9FRTBqRlN0?=
 =?utf-8?B?QytjWFA4NlJncFE4bWNaV3ZjZytmbXJzUE1jQXpDZ1JXQ3hEWDNtdVVINjFx?=
 =?utf-8?B?M0hSWHR5N1ExNzNJRHJEeXBsUTMwU2V4YVFzZjRIa2h0WnYvSXFvVmkyRGtI?=
 =?utf-8?B?M0RFbVNXVTBhSkNhOVIxeFJmYkR0dUpUU3ZpZFU0QjhINkI4Znk1TFJ5L05s?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SkeV3w71BxxUyanonGtd4h4KUlqagBYcQbY2xnvNQUqteCayjc/Nuf1G21rqx4LlVS68Rl9ooFPeHc9DqyTpL6AeZBtkaIeoLPuhI9+kQqrf4qgdrR7U/dM8NkkPOxFPvPKE8JhWsKIykYRyvBMFx+gH6D2sjcR5V/t6Gv6u2reTfDBLAIo28GtFPtigDeb9/9OxES+TinjPuzk0SNoSqUmHivQ8pP0FqtFz1TyhBCQCgOZoslUd49D1h+nK3mPYs6nHOv+Ibh17BGoOzES1dEMtKCFGtO6Rza9pIqo706GvWHH32gGEXySv59KULEqnqdLJOmnc2DxqYaZwqoLk9OCbNLc4ghtl3Ah7u28enIdOElpuQs6C4N7ez8AAMJrgEK9TAt/UCoB419LXEXc0VX6o58lhoaUZk3a4QTKPQ3OvAUrjcStdNrDuMqAb9sG3BMBHXiT/GcBQWVjr9wYqnQ4XW1m/42ncu4A19JLTN9kM2y/6UwvBSzj/scT6fONIAQUphZDZMTAU8d4BfkxL7PwTVyEwVr6bPlbfi62pAvEPRFLr9aDM/iAk01CiN0SpoxEXB7JuAIv/CgRVJ14QvwcEW88pl6G1UUPfm5RtphY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0546026e-e6ad-4b55-21d2-08dcc51b3014
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:32:54.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9E+MezQXN8/ZWZs5EfRspLOmttTucDbengcc3ZQZaWaZUcwZ5/JeHqLJKtIvX5hBT0TOYb551fhUrSuuiT7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250124
X-Proofpoint-GUID: Tj1BFfV4X0Lf_TTbXbm6gVD5Qr4xtvyK
X-Proofpoint-ORIG-GUID: Tj1BFfV4X0Lf_TTbXbm6gVD5Qr4xtvyK

On Fri, Aug 23, 2024 at 02:14:02PM -0400, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
> 
> __fh_verify() offers an interface like fh_verify() but doesn't require
> a struct svc_rqst *, instead it also takes the specific parts as
> explicit required arguments.  So it is safe to call __fh_verify() with
> a NULL rqstp, but the net, cred, and client args must not be NULL.
> 
> __fh_verify() does not use SVC_NET(), nor does the functions it calls.
> 
> Rather then depending on rqstp->rq_vers to determine nfs version, pass
> it in explicitly.  This removes another dependency on rqstp and ensures
> the correct version is checked.  The rqstp can be for an NLM request and
> while some code tests that, other code does not.
> 
> Rather than using rqstp->rq_client pass the client and gssclient
> explicitly to __fh_verify and then to nfsd_set_fh_dentry().
> 
> The final places where __fh_verify unconditionally dereferences rqstp
> involve checking if the connection is suitably secure.  They look at
> rqstp->rq_xprt which is not meaningful in the target use case of
> "localio" NFS in which the client talks directly to the local server.
> So have these always succeed when rqstp is NULL.
> 
> Lastly, 4 associated tracepoints are only used if rqstp is not NULL
> (this is a stop-gap that should be properly fixed so localio also
> benefits from the utility these tracepoints provide when debugging
> fh_verify issues).
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

IMO this patch needs to be split up. There are several changes that
need separate explanation and rationale, and the changes here need
to be individually bisectable.

If you prefer, I can provide a patch series that replaces this one
patch, or Neil could provide it if he wants.

A few more specific comments below.


> ---
>  fs/nfsd/export.c |   8 ++-
>  fs/nfsd/nfsfh.c  | 124 ++++++++++++++++++++++++++++-------------------
>  2 files changed, 82 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7bb4f2075ac5..fe36f441d1d9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1077,7 +1077,13 @@ static struct svc_export *exp_find(struct cache_detail *cd,
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
>  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> -	struct svc_xprt *xprt = rqstp->rq_xprt;
> +	struct svc_xprt *xprt;
> +
> +	if (!rqstp)
> +		/* Always allow LOCALIO */
> +		return 0;
> +
> +	xprt = rqstp->rq_xprt;

check_nfsd_access() is a public API, so it needs a kdoc comment.

These changes should be split into a separate patch with a clear
rationale of why “Always allow LOCALIO” is secure and appropriate
to do.


>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 50d23d56f403..19e173187ab9 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -87,23 +87,24 @@ nfsd_mode_check(struct dentry *dentry, umode_t requested)
>  	return nfserr_wrong_type;
>  }
>  
> -static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
> +static bool nfsd_originating_port_ok(struct svc_rqst *rqstp,
> +				     struct svc_cred *cred,
> +				     struct svc_export *exp)
>  {
> -	if (flags & NFSEXP_INSECURE_PORT)
> +	if (nfsexp_flags(cred, exp) & NFSEXP_INSECURE_PORT)
>  		return true;
>  	/* We don't require gss requests to use low ports: */
> -	if (rqstp->rq_cred.cr_flavor >= RPC_AUTH_GSS)
> +	if (cred->cr_flavor >= RPC_AUTH_GSS)
>  		return true;
>  	return test_bit(RQ_SECURE, &rqstp->rq_flags);
>  }
>  
>  static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
> +					  struct svc_cred *cred,
>  					  struct svc_export *exp)
>  {
> -	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
> -
>  	/* Check if the request originated from a secure port. */
> -	if (!nfsd_originating_port_ok(rqstp, flags)) {
> +	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
>  		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
>  		dprintk("nfsd: request from insecure port %s!\n",
>  		        svc_print_addr(rqstp, buf, sizeof(buf)));
> @@ -111,7 +112,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
>  	}
>  
>  	/* Set user creds for this exportpoint */
> -	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
> +	return nfserrno(nfsd_setuser(cred, exp));
>  }

Just for cleanliness, the above hunks could be in their own patch,
labeled as a refactoring change.


>  
>  static inline __be32 check_pseudo_root(struct dentry *dentry,
> @@ -141,7 +142,11 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
>   * dentry.  On success, the results are used to set fh_export and
>   * fh_dentry.
>   */
> -static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
> +static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
> +				 struct svc_cred *cred, int nfs_vers,
> +				 struct auth_domain *client,
> +				 struct auth_domain *gssclient,
> +				 struct svc_fh *fhp)
>  {
>  	struct knfsd_fh	*fh = &fhp->fh_handle;
>  	struct fid *fid = NULL;
> @@ -183,14 +188,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	data_left -= len;
>  	if (data_left < 0)
>  		return error;
> -	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
> -			    rqstp->rq_client, rqstp->rq_gssclient,
> +	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
> +			    net, client, gssclient,
>  			    fh->fh_fsid_type, fh->fh_fsid);

Question: Would rqst_exp_find() be the function that would prevent
a LOCALIO open to a file handle where the client's IP address is not
listed on the export?

I don't really see how IP address-related export access control is
being enforced, but it's possible I'm missing something.


>  	fid = (struct fid *)(fh->fh_fsid + len);
>  
>  	error = nfserr_stale;
>  	if (IS_ERR(exp)) {
> -		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
> +		if (rqstp)
> +			trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
>  
>  		if (PTR_ERR(exp) == -ENOENT)
>  			return error;
> @@ -219,7 +225,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  		put_cred(override_creds(new));
>  		put_cred(new);
>  	} else {
> -		error = nfsd_setuser_and_check_port(rqstp, exp);
> +		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
>  		if (error)
>  			goto out;
>  	}
> @@ -238,7 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
>  		if (IS_ERR_OR_NULL(dentry)) {
> -			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> +			if (rqstp)
> +				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
>  					dentry ?  PTR_ERR(dentry) : -ESTALE);
>  			switch (PTR_ERR(dentry)) {
>  			case -ENOMEM:
> @@ -266,7 +273,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	fhp->fh_dentry = dentry;
>  	fhp->fh_export = exp;
>  
> -	switch (rqstp->rq_vers) {
> +	switch (nfs_vers) {
>  	case 4:
>  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
>  			fhp->fh_no_atomic_attr = true;

@nfs_vers is actually the new FH’s NFS version; that needs to be
better documented because this is NFS version-specific code and I
guess it needs to stay in here since it parametrizes the form of the
new file handle.

Perhaps these cases need to be wrapped with ifdefs.

IMO all callers should supply this value, rather than manufacturing
it in fh_verify(). Ie, "I want an NFSv3 file handle, please."

That should be a separate patch, it will be somewhat less than a
surgical change.


> @@ -293,50 +300,29 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	return error;
>  }
>  
> -/**
> - * fh_verify - filehandle lookup and access checking
> - * @rqstp: pointer to current rpc request
> - * @fhp: filehandle to be verified
> - * @type: expected type of object pointed to by filehandle
> - * @access: type of access needed to object
> - *
> - * Look up a dentry from the on-the-wire filehandle, check the client's
> - * access to the export, and set the current task's credentials.
> - *
> - * Regardless of success or failure of fh_verify(), fh_put() should be
> - * called on @fhp when the caller is finished with the filehandle.
> - *
> - * fh_verify() may be called multiple times on a given filehandle, for
> - * example, when processing an NFSv4 compound.  The first call will look
> - * up a dentry using the on-the-wire filehandle.  Subsequent calls will
> - * skip the lookup and just perform the other checks and possibly change
> - * the current task's credentials.
> - *
> - * @type specifies the type of object expected using one of the S_IF*
> - * constants defined in include/linux/stat.h.  The caller may use zero
> - * to indicate that it doesn't care, or a negative integer to indicate
> - * that it expects something not of the given type.
> - *
> - * @access is formed from the NFSD_MAY_* constants defined in
> - * fs/nfsd/vfs.h.
> - */

See comment on 5/N: since that patch makes this a public API again,
consider not removing this kdoc comment but rather updating it.


> -__be32
> -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> +static __be32
> +__fh_verify(struct svc_rqst *rqstp,
> +	    struct net *net, struct svc_cred *cred,
> +	    int nfs_vers, struct auth_domain *client,
> +	    struct auth_domain *gssclient,
> +	    struct svc_fh *fhp, umode_t type, int access)
>  {
> -	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_export *exp = NULL;
>  	struct dentry	*dentry;
>  	__be32		error;
>  
>  	if (!fhp->fh_dentry) {
> -		error = nfsd_set_fh_dentry(rqstp, fhp);
> +		error = nfsd_set_fh_dentry(rqstp, net, cred, nfs_vers,
> +					   client, gssclient, fhp);
>  		if (error)
>  			goto out;
>  	}
>  	dentry = fhp->fh_dentry;
>  	exp = fhp->fh_export;
>  
> -	trace_nfsd_fh_verify(rqstp, fhp, type, access);
> +	if (rqstp)
> +		trace_nfsd_fh_verify(rqstp, fhp, type, access);
>  
>  	/*
>  	 * We still have to do all these permission checks, even when
> @@ -358,7 +344,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	if (error)
>  		goto out;
>  
> -	error = nfsd_setuser_and_check_port(rqstp, exp);
> +	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
>  	if (error)
>  		goto out;
>  
> @@ -388,14 +374,54 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  
>  skip_pseudoflavor_check:
>  	/* Finally, check access permissions. */
> -	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
> +	error = nfsd_permission(cred, exp, dentry, access);
>  out:
> -	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
> +	if (rqstp)
> +		trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
>  	if (error == nfserr_stale)
>  		nfsd_stats_fh_stale_inc(nn, exp);
>  	return error;
>  }
>  
> +/**
> + * fh_verify - filehandle lookup and access checking
> + * @rqstp: pointer to current rpc request
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * Look up a dentry from the on-the-wire filehandle, check the client's
> + * access to the export, and set the current task's credentials.
> + *
> + * Regardless of success or failure of fh_verify(), fh_put() should be
> + * called on @fhp when the caller is finished with the filehandle.
> + *
> + * fh_verify() may be called multiple times on a given filehandle, for
> + * example, when processing an NFSv4 compound.  The first call will look
> + * up a dentry using the on-the-wire filehandle.  Subsequent calls will
> + * skip the lookup and just perform the other checks and possibly change
> + * the current task's credentials.
> + *
> + * @type specifies the type of object expected using one of the S_IF*
> + * constants defined in include/linux/stat.h.  The caller may use zero
> + * to indicate that it doesn't care, or a negative integer to indicate
> + * that it expects something not of the given type.
> + *
> + * @access is formed from the NFSD_MAY_* constants defined in
> + * fs/nfsd/vfs.h.
> + */
> +__be32
> +fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> +{
> +	int nfs_vers;
> +	if (rqstp->rq_prog == NFS_PROGRAM)
> +		nfs_vers = rqstp->rq_vers;
> +	else /* must be NLM */
> +		nfs_vers = rqstp->rq_vers == 4 ? 3 : 2;
> +	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred, nfs_vers,
> +			   rqstp->rq_client, rqstp->rq_gssclient,
> +			   fhp, type, access);
> +}
>  
>  /*
>   * Compose a file handle for an NFS reply.
> -- 
> 2.44.0
> 

-- 
Chuck Lever

