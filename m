Return-Path: <linux-fsdevel+bounces-12751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6C866A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 07:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B91F22ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 06:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D717BBB;
	Mon, 26 Feb 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UD6AOQqx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rCRH4mbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C91EEDA;
	Mon, 26 Feb 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929344; cv=fail; b=XolZisbpn5PNgs+6EZxBaFTfNdh0i7Kdv3klexKy5KouXfdqNxZlf04A5eLFUoF9VHkv4tz4iT/Rddnle2CAzbzOqLlMfhN291J3FMmzakzb2ANiku4LR5Ya0ncSaDTWUGDNeF6o/eCRfof9HI9SePLaGumt4Pyysk3aqMJQ9Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929344; c=relaxed/simple;
	bh=okNPEuUMscsh6Dck33clVur0jp1JBrBA+0DPyLXCk5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoQiiIlZr0bbJ5otixPAQQ7X9jZ3+BLa5Wq3vw5JNJ7KxYb8943sj+87FTT+DS7LEjMqwav73KuJ/rfDgNEwx7iNODgdefS89yDQb/qoqvJNFkYJAnmHUGKAvFpbhJPDIVp9wLDVNsXNG9sQ7/fZSqC/cyk/3wKBWFuzbeysA2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UD6AOQqx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rCRH4mbO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41PJm420010401;
	Mon, 26 Feb 2024 06:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CMwY6pMkT+pp7+pXtQ9YWl9cTYyfWIkEA19z6lAGVK4=;
 b=UD6AOQqx5ZrjeiIuiHp8HPNMtm5+FGZaJ+653fLV3L5FXBMQiR4cMWVc4NWxN9abfeiI
 14ZYTNrl+rR2syo7eRIq2Sst/VF9+alqnMBEC63ZGtJQkYurGXWpjpufpTFMX7pfUWjv
 jjhrQx5vz8kQAo3cmKwwuQFVFPgLWeAV9jIYSPU71gvm6j2MvvtanpgPY/wBSsgyqdcu
 VOL6B53m6EM/GTg6HUkLiBRUu8auO9v0o2k/A+kymMkZFlrR2+g2EYAJooVfb+qRm12m
 H801/4uTnG/4DVWuBZRZItsrtTNLXAY3+wHsQmrm3N+qx/c8Z5dI0V2Qnx7vWg9gt2bA /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdbu6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:35:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q69h0E037201;
	Mon, 26 Feb 2024 06:35:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5bf5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elo5k4qvgweCoJ21jFSJ2MvCO0Gqn50o6fesYPK/tkl/J8W4E/Pd2ET6j0IrwgzMSV5fN7FrmLm1AAmVz4eaYw0OXAc2bVkgVbEFKbr0GaxlXA8xN0X0wBldrYyRsgyd0i1vVlIbpWduwrPGGQMYVWYq33PGEaDI5aegc5wQG3oGGOBSKk5DAgXow05Z7FGVaVC0CMLk9QT9mMal1zsDZ7VGy71AFCVQZz9ghXpdtlK9ZaJumc4bpaIHlOO+PX4BVN5Jn6WGVl9UvLUQd/wCd3SmbxyPsjjKz8k8UiiQeeQut2fV1xFAVLfjJBQ3eQxXUDLg6SW8MBu+tpQ0LzTE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMwY6pMkT+pp7+pXtQ9YWl9cTYyfWIkEA19z6lAGVK4=;
 b=mDzEi9/dmGQ2gSMMeMGlxXb0rXClDaCTB8IGB7tveHldWmVMsW9X1Xn60gONX+wdZ1Ck1Ta6nXSdzsDGuu4+CSI7qlMiW+bRbqMnMSCOW0gwisn1NoLBHZvU+pbOdqJcsusxlzTIMYvlwM8JSLzchC7dWXb2mJuRb5vZCsS0L288t6t1qOzrkI/glxkdaoLmabh/YlkdyBrbtbD8U+bOyeCTg3YJh/yCbHkpTHU+O5qIPxerbWKzum4MPjkzVtnQ4J5/qYLQ69XVKm/PLCYCMzw7tvo9NRgU77uZXrWg+Y3llr6sVW7Gtu296uhvwfcm8eMlCx3/eFiBnQLwvJFmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMwY6pMkT+pp7+pXtQ9YWl9cTYyfWIkEA19z6lAGVK4=;
 b=rCRH4mbO7jQZxbGUtTUOpeBJ7l/f2LVAGcjoxZldgWe1aCI8O4m52p8DxDZAh6Pjht/4rXB4ZjXNht4JHxQs+Mz0cbnSBdXyxrMsUvy0cLhfrEXNP6hiN1PdjeHvwbGd7oMMNmrVRinLf/oTc17S9OQAXewfu4l57FdhS5/IGC4=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 06:35:22 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 06:35:22 +0000
Message-ID: <5879f44e-1c28-4be1-a684-9bf4fbf6966b@oracle.com>
Date: Mon, 26 Feb 2024 07:35:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] documentation on filesystem exposure to RCU pathwalk from
 fs maintainers' POV
To: Al Viro <viro@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <Zdu58Jevui1ySBqa@duke.home>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <Zdu58Jevui1ySBqa@duke.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0050.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::25) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8699d943-5860-482f-cd77-08dc36951b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6ECiGYb4OzARDNGa5Ewa+BFZ5o2TGt4Gaw/koWVhcSnQzTNb+9sFvoqPEtm241va1zEKzLVDrEuaMy7T1cs+fqdYCwNDatlU7+8CKHWidxXZaGnKNYw+XUwAeZqSOVb5kiPwuYsSwLcxqwYsbZN95438PZmwrtdRpu1qFbIxMUyyMbwK6aDtoFLGE4jrsxnd82w+AqwZQMigpvsW/7C1aHn90/mflu1iTSITy1AhTt0dWSOhL3X53xZLzSfMJKjQScwZZSlWgoip6nCj7VFjasfSVjrjELefp99VuU+6fEPHtD4enoJM8GP+nuexwy2UdsZhBXuzVfBbVML8UrQOvkKgHLRRQK3Gy+e70GiHNy/Rn6dYA1Tm5RbA9oNfGNNF0MmEqBGPMOfOh78oX+lzgVZbLD87HdfPPgwOR2UKaafcvdaI5VtYBF4olYCdVL659EBFVFuLcvITXSdOJXHuPiXh0xmsxPx69jc1v2nt9/TCr75PAPAc0ccSvvct/6uAjnUYRiD9Cfm8wCh5t6jsrU0c9d6SePrYKU19Rwlhk9Z1x/hOja+N6UpLYKGh2jiK6PdlSPnTi3xPSnjxSNsLmUJbh2jpuZFOgV84w0vajOHMCaEE6ftIRpMmTRO466/63yLuHymeHpTxOp0gDz2E4Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDArOGVqWkxESzdub2dQVkYxckZQN0dudjFPSzg1TDNZQ3RSY3M1Z2FaRE93?=
 =?utf-8?B?L1FTaVFlOTExa0VIZmRzN2FkOTh5K0xMUDlUNitNS1NFeVhjYVVkV0dPVnJK?=
 =?utf-8?B?L1FTazd4Q05SMkZPNm9iQU1TWUFhUExRMUdDK1lQOGprSmRzaHZWVXdxdW9j?=
 =?utf-8?B?b0JrRElJZyszK0hBT3ZWcmJIZSt6K0RJODlYT3A5aWRYeWc2T28xSG9kM2N4?=
 =?utf-8?B?eW9uSGN4UlpLNld3V29sWm9ONFpBeGVCcVM2L2I5b0lrUEM1eFJtSzlkZ3lo?=
 =?utf-8?B?ZXI2NWFwOFovaW1kcSsrUzhPMTdYZXNIanRybjRxWUw5YWtWam9pMklHNnRS?=
 =?utf-8?B?ZmRuQ09Yd0tCSGlSVXdUT3dPRjVBYkVFL1h2Tjh5cmN0SnFyNUxNbzlQeitm?=
 =?utf-8?B?YWx1QnBSQVRhNDNIaDlSNjB0YjIxVTA1b2lOQU5CVXhCblA4TG5IMkx4ZHV1?=
 =?utf-8?B?dXNabkNjbUxUVElIOHBpbEMxQklRUncwWkZjeFRna0NsZnQxaVNENy92SDZO?=
 =?utf-8?B?Yk8yampIRjJ6YVhOeFM3SkN0L0RmQUNIemxFS3FOMWw4RVdCUHM2cm1DVWpp?=
 =?utf-8?B?cWJaeVFZeE9qbnh1T2tWc3JIdjFtbG5KRVpLZGtaSGhLR3RMcHl1QTMwYm1y?=
 =?utf-8?B?SzYvaWVKWGZVUGdlTm5nOVB0R1JTVG82NFBzMDlDYnZpcWU2cWFaRVhrWWFU?=
 =?utf-8?B?dEtYaFZWaUxWa3ZEMURJUEVqNmpiQ3hENTVLS2pIZ0FIckxDbUVQbW9Ba3c2?=
 =?utf-8?B?L2JOdStOaDVUa0NnMktXTFF2cExNUGpnRGJ5RktMaWMvQzg3anZWL3pkNktV?=
 =?utf-8?B?SUdTL0ZWWUZPSEE1b3hmNjFpL0xzdDF2dG9zLzRuY2RZNVpMdm0yOEprb1Vj?=
 =?utf-8?B?NFJPMkwxcVh5SkMybnJ2RDU2UXE0TXFSa2tvU0x1OUhXdndUcXV3QkRtTU5N?=
 =?utf-8?B?Mjk2VjJrdVV2d1Q3ZldmRnpxYTNwdEE3RlFEQ2FYNHlkaXpoTmE0ZXFEczFL?=
 =?utf-8?B?MlNnS0FSMWE3clZNL3JEM0NEL0toV3FOZWticjlFaUhieVZFa0JuUzgwOUFZ?=
 =?utf-8?B?aFJDL3dONzdkcnk1VkJJNE1VM0l4ckc2N0ZYY0I3YjlHNzZZSTNxQmhNTk5v?=
 =?utf-8?B?YVd4ckNLSWVuNmRQSThBQmN1Nk1CL25FbEdoQitIR3VxY0t4MnBVQkZBSU0r?=
 =?utf-8?B?MmgxMkVRclhkQkpUQ2hra1JPTTA5RlBhWUJEc0VvQ3oya0FNeWVJQWVjNzA1?=
 =?utf-8?B?NU5vTU80VzBHZnM1akloR3ovbm1DYjVveEhOenl4dk1iekNKcmRPRmRXOUlk?=
 =?utf-8?B?ekgzT2krMDU2NU9wS2p3L0d3T01aK3puN2xRSUZzTWFPQXdESW1RUHB0WXQ4?=
 =?utf-8?B?U0RreXdzSjdYYXN2NHg4blljZmozQ3gxSkkzSVlLZEo2MXdaSTV1S0MyRTc5?=
 =?utf-8?B?Z09ZbVMyWGI0Y1lqTXkyenhMS2psUkRhby9lcG1PMk9rclNUcW4xakhabzQv?=
 =?utf-8?B?bjlIUVNrV0VpTGNwa0NaM2Ewd2c4R3pyZ3ZRbFZFd0NqZ3BPWHRqM2NLM0ZM?=
 =?utf-8?B?NmpOTlFja3lTdVdvMUREYmFLUnRlbGZFRUszaDVLcjdKNGRNeGhFSkI4RGN2?=
 =?utf-8?B?OEFYZFB0M3hjNzVZUW9FaFdwdU1XSDg2V3ZVWWgzS05QN1Q1WEF0N296UWlS?=
 =?utf-8?B?WlhuazgrR2ZzYVpNbDQ0WnZDcUhWWlJBWWFMV29lMUdjbkZ0ZEV2aHZpVUVQ?=
 =?utf-8?B?cGRoZlVtVHZsTmI3Uk03RC9YRDhjcEk0c3JCMWxieVVDekh0T2JUeGM0Zi9C?=
 =?utf-8?B?TGt0SnY3emhDQnB5QTdodmVrY3ZJZWhLemlUL3JDMHN0RDJEdTNuUlFzWjlG?=
 =?utf-8?B?a1lQOGJudEpvRGtaRkI0dFhvOEFwL1pjbUhXQ3RnQTVodmFVYnl5R1NSYjJI?=
 =?utf-8?B?bHIwSmtKMko0K0RMTHo0MnNDTUtnMzZLV3hBNkVodTZRb2hERkNweXFicE5t?=
 =?utf-8?B?QVR0NXVNeFFIZGlPbGFQejQrYjRZMkRhWG9TWGlnT01OTi9ZSHZBK25JVG94?=
 =?utf-8?B?eWxjV3E4dEZ3UlRyc3VnR1kwMHN4cnU0Y1hJaEJMeHloWHhsRXloMEVwWEQw?=
 =?utf-8?B?cWlsS2NNSmRmMEpoKzhBMm0reDZmWXIxT2puMndCKzloMUhrY2VIakVHbDBp?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VXG141MEypKM4+xJO+WP3mUt1k5ib2ItN3S0KGrZjLcgyCh+PdW1Rzse/xxcPPlpJdIRZdxEoC0Kwbe2tEJazrDFmgiN8dXmTDEXphb1ma0o4zT9EGkhOeEDdyfe3Q0pWUOpvKNQVv9+UCK0Pt/UrPpVe/2nKA0Bhsj0DCKabmEMoEDN1kYueifzNe1sRc7T3RAljRGT/oR9HcK9WyQxe6VFuB9mOrvenniRA4hQnMulsc6Cttdt3rm7bSGKHemciC+SEldehJNi/g9EMJ0xgb+G9zTBBOZOQ6Q1kxkZ2cVLx1Ah7rFNyllPpoZzivwUL/X1S+9XbGWrNkZ0qDL0IDkFVMTNqHuDpNehQv8WC6sfC4WEPHriOXfKw3Pi0pTi719BgB3E9PcZDvr0BKx91v1rrc4i7xAlZEJgS2Yzpea7ULBB/2NkNfPObmAuleQ8XTKizyuvd/hc+RonA8FRHknd6aXO5xuHVubMpjmjhUd/Xoyc5jpiA5y2ijWTx4NBjy0mCFRzSAPxghDoFnwYuk3SS4QLn56fRU6HxvyOVxF7SZzoVJN8awF1II1AkWMoVqB6gNMCWHLDxpQr4DULCWVbNpe7Ai+m33OLHELNAfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8699d943-5860-482f-cd77-08dc36951b7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:35:22.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvyaXVFJ1DYNa1fpPN9o1mvEAJpasgUrSiHYNbjV8M8GrcAo2l3hDJ/T+6Icza3N0B7beNLUlyGBS4satYEAPs5fR6qzyGIdSJKz0bYF14Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=958 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260048
X-Proofpoint-ORIG-GUID: _5bBctlRFFab5aGO5jIDqK5nUyz8ytJP
X-Proofpoint-GUID: _5bBctlRFFab5aGO5jIDqK5nUyz8ytJP


Hi,

A couple of clarity-related suggestions:

On 25/02/2024 23:06, Al Viro wrote:
> ===================================================================
> The ways in which RCU pathwalk can ruin filesystem maintainer's day
> ===================================================================
> 
> The problem: exposure of filesystem code to lockless environment
> ================================================================
> 
> Filesystem methods can usually count upon VFS-provided warranties
> regarding the stability of objects they are called to act upon; at the
> very least, they can expect the dentries/inodes/superblocks involved to
> remain live throughout the operation.
> 
> Life would be much more painful without that; however, such warranties
> do not come for free.  The problem is that access patterns are heavily
> biased; every system call getting an absolute pathname will have to
> start at root directory, etc.  Having each of them in effect write
> "I'd been here" on the same memory objects would cost quite a bit.
> As the result, we try to keep the fast path stores-free, bumping
> no refcounts and taking no locks.  Details are described elsewhere,
> but the bottom line for filesystems is that some methods may be called
> with much looser warranties than usual.  Of course, from the filesystem

There is a slight apparent contradiction here between "at the very
least, they can expect [...] to remain live throughout the operation" in
the first paragraph (which sounds like they _do_ have these guarantees)
and most of the second paragraph (which says they _don't_ have these
guarantees).

I *think* what you are saying is that dentries/inodes/sbs involved will
indeed stay live (i.e. allocated), but that there are OTHER warranties
you might usually expect that are not there, such as objects not being
locked and potentially changing underneath your filesystem's VFS
callback or being in a partial state or other indirectly pointed-to
objects not being safe to access.

The source of the confusion for me is that you say "such warranties do
not come for free" and it sounds like it refers to the liveness warranty
that you just mentioned, whereas it actually refers to all the other
warranties that you did NOT mention yet at this point in the document.

How about changing it like this:

"""
Filesystem methods can usually count upon a number of VFS-provided
warranties regarding the stability of the dentries/inodes/superblocks
they are called to act upon. For example, they always can expect these
objects to remain live throughout the operation; life would be much more
painful without that.

However, such warranties do not come for free and other warranties may
not always be provided. [...]
"""

(As a side note, you may also want to actually link the docs we have for
RCU lookup where you say "details are described elsewhere".)

> What methods are affected?
> ==========================
> 
> 	The list of the methods that could run into that fun:
> 
> ========================	==================================	=================
> 	method			indication that the call is unsafe	unstable objects
> ========================	==================================	=================

I'd wish for explicit definitions of "unsafe" (which is a terminology
you do use more or less consistently in this doc) and "unstable". The
definitions don't need mathematical precision, but there should be a
quick one-line explanation of each.

I think "the call is unsafe" means that it doesn't have all the usual
safety warranties (as detailed above).

I think "unstable" means "not locked, can change underneath the
function" (but not that it can be freed), but it would be good to have
it spelled out.

> ->d_hash(d, ...) 		none - any call might be		d
> ->d_compare(d, ...)		none - any call might be		d
> ->d_revalidate(d, f)		f & LOOKUP_RCU				d
> ->d_manage(d, f)		f					d
> ->permission(i, m)		m & MAY_NOT_BLOCK			i
> ->get_link(d, i, ...)		d == NULL				i
> ->get_inode_acl(i, t, f)	f == LOOKUP_RCU				i
> ========================	==================================	=================

FWIW, thanks for writing this document, it's a really useful addition.


Vegard

