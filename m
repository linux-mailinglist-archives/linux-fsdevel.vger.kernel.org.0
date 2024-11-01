Return-Path: <linux-fsdevel+bounces-33481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182849B94D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF5F282FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C31CB32E;
	Fri,  1 Nov 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tai4BCjT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bnx5WbhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0761C9B75;
	Fri,  1 Nov 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476866; cv=fail; b=OLDOLKWSq/U6u7prRQEHlgVUsLsyca846YCdsvmJ57TU0Yg1/orKX6q1np7bT9JLfezrt4Ky3bxYe0tcnm14N2lzSBMcblqQd+qWAcWbDw0uXX2iOuQX+8noUObn6DXv2aSNm3PHuMEeuoI4p8cY4WgC2abiLuXtGjAL5Uk/Oww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476866; c=relaxed/simple;
	bh=Fz6v2/4+PfKNlDvDuS71+Trz2TR9Q64KAIZfBPSVvyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WVqKI3rA/scJFx9TmCJLNdR1Ouggec2RcVZZ1pLfSA5rSDWViHt7FqU20+J1DTI4DDKt0tA1DsM2yj+a2dC+0ccPOWoLdyeqEvwDtCVwoCW/0N4XVmgOerOLgHXm/mcM2VefHazrnPpBS/sBn7joxt+XqH5Cq8iRi70P+9dfJk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tai4BCjT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bnx5WbhD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Etbev023111;
	Fri, 1 Nov 2024 16:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QVb/CE2sJSMwK58zQAhTK5daCra6IvZniAqRcVT9sUY=; b=
	Tai4BCjTo0WNA4EJjkknoT4GJpo0gZQBT8BT/gXR5j1k0ACr2FTO61SnDQE12DGg
	OQDdf6RCzYeuK3cntCI88edFbLrUIDBmxtxB4g9R/VyUsJN3venexfTR4JDcvFUW
	214MEy2cpBNeCvWAruKBJbP+mDbJWBW/M2zU0icKNzA63sSRu0H8UBcMu91wmmO0
	+eTnz5q3zPKgYUPQkEQSSeXphUb/EctCqFlZ0oPUt2qfkoy5/Ky1lybd+qiT568Q
	bnXqEDHJ/tAnQtKKyXKAhVPt+amso9VUehf4AXHtJcXnnGuP/JAAZsuS228MhiZ0
	plRSBTgbZLJR0S3G4SB2tg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqmepd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:00:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1FEn53040216;
	Fri, 1 Nov 2024 16:00:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnat378v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGCS7bT6vj5pgmQEH7+BPalY+XGPjRpCahk4Uja2QQY6q1TvO2CIJkv3L5+9XzRhzzkBTNwnZZzHCO2iIUmAXzvsT+kgsznkwkjaWZw2sUjDibKbc6xXdQHG9oWJVb7w4nQ20PxiboIT6nVEoL4F18daj0oB7yVTomj/gVh9eHWPOS5r66xsuul3Bx1kry6aGVOBWUva7fu5+pd/cS2ZVct7qTPpo6pHL/n4kFNSMjTEMqKtsQyvCH5KYLo+nuwLrdkpumQJfNUsRZGA9ESY2ju6uPDR1P+WWkN2NJLvyIr9JDA9+TEtY5QfaP/aEUcRQgZfrwpj3XPadkZXBtLJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVb/CE2sJSMwK58zQAhTK5daCra6IvZniAqRcVT9sUY=;
 b=cBxZFUlhTXY+XCDcZVjcTQrmHv/NPNe0/yflfRCEbQuVSEw2y6w800wRF058G8zz5Tt7vWsy+L9pPWg2a/Ni4OZ/WKzbd/f5un5iVL9HNsWJhsx3co8OzZw1O4NimgkXQbiepmOOHmhO37NwkGNNBp91nlO0jzDN4qVDmuIK7MzIHlLNL1xEEKe4TYHOvlI+3F8FEZXJ4PONJSUlfIRgn6RZxx75GzF/qggbsh59dfFatSiB36hFPbKvC4SHX0AhtNfbm+j9w8nqJtOij99oDwCfbtBMZUQIGGWMV6pMgkGiBp5bIvYLYi1fyDpdOyRv+iP0Jy6NECogZPGxTIEFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVb/CE2sJSMwK58zQAhTK5daCra6IvZniAqRcVT9sUY=;
 b=bnx5WbhDnskwWBgsQsRXvwwTtMqhlpcDjenrZ9BD9VNKXzJqzJs17o2ltcBc6f0FcfkX7IoK5lGaRHO11sY5AiqgyGUYh1WbZa2tLMVPUFLj7dYj5b8xfK1wx5PMGNEGHlw1Cu/p9+vRT1RVRsI+LRm2vHfjh92Q9407vbpphCU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB6964.namprd10.prod.outlook.com (2603:10b6:a03:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 16:00:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 16:00:40 +0000
Message-ID: <4198772d-54c8-44b9-8e85-0ec089032514@oracle.com>
Date: Fri, 1 Nov 2024 16:00:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] ext4: Add statx support for atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: dca2382f-bf74-418d-7a22-08dcfa8e556b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFNUUG9wQmlRbEx1MytUOVVIYW5LajFCMXJtdlBJRjB0TzM2UHBEZmJyUEhP?=
 =?utf-8?B?WHZObmJjZnpYVFFmOHowQ0VwQ3lRUGwwRlV2bG1sa1pGTkVZaWJFb2RMUjBF?=
 =?utf-8?B?SzdEZTlHTmVoTlFQcWYwT3A3TnE1NmxyK1AwTGpUOHlCQno5N0cvdDJCNlVL?=
 =?utf-8?B?UnM3YnM2Vm1vWnN2bFN1TnJRNjRGVE90N3ZZa1ZnbmZ3VUJRVEFwbzFVQUdX?=
 =?utf-8?B?ZzROQUFMY285dmVicUhwY1BKWGUrb3dzZDhFTE9QRFZodHlVbmltRE04ak5J?=
 =?utf-8?B?RlVYWkhYcEVOT2lGY3cxWVBvWWYrWmMrZ1h0RlpxMlY1ckZhY3VpR1dndUlk?=
 =?utf-8?B?emV5bmpleTJuVExZUWVqQkpGek1QVWVEck9qL1VtdkhEemljQkVnMGRlTlJj?=
 =?utf-8?B?VnNZdkNxTWNOeTB2aGd3b1dDdEkzbGtUVUVlb3lUaUlDZ1JzSUtaejk0SFJT?=
 =?utf-8?B?K3ZTSUVyT1lZbWs5MS93WTdZTmtyN29jZjN6eENMV1gxTXk1dGRXUEpib1M0?=
 =?utf-8?B?clBmYjNpL0xlaTFRRFFTUlFSZ21vbDcrM0o0N0NIWi9LemNqQ250RlBDRXBY?=
 =?utf-8?B?TS9lVjM0WGdRdUVBVkZTOWlRcHNOQlpKc1pYRHNKMjNOUHdiS2hYK2RzRk90?=
 =?utf-8?B?TGV3NHhlUmlhVnloSzN2dVRqYldwK1VtSUVOTE1ZbkNkNHdLRXcyT3IwYjla?=
 =?utf-8?B?eTlMZnVRL2RuVmI1eXV3SUVBSXF1ZVhNblN6Wk5oMlpjTXRhMWVBekI1Nzh5?=
 =?utf-8?B?T3FtZDFSTkhKVVJaTXlkMU1jUU1XZWhJK2YxNEpEaW9FM1VBdHJiNDhVVzNj?=
 =?utf-8?B?N0FNNTlHYnp0a3FZL2dRNGVhcnFDbWExMlZjZUlPMExwTlpkbW9hZ0pnWE1P?=
 =?utf-8?B?RjdVdWZOSEZSckd4c2R6Q01mb3BCZWNoRUwyRzR1TkRQWW0yeVA2VHBaV3FW?=
 =?utf-8?B?OWQ3dmdVUjFFcDRzTjlxaWl4WGtVczNaTTVlWk4rMEMyR0tXdGYyazVmK0Fh?=
 =?utf-8?B?STZrd3NNcG81V1l1Z29rQ2Q4UXk1TTdsTTZqbGFaZFRWdTk3bjgrZGlXRHJx?=
 =?utf-8?B?T3dpeHFRT1o4bVREWTNhN3pRcXE0em9peHc0eUttdjFBQnFtWDdLTjRaUHNG?=
 =?utf-8?B?QUM3TTV5ZytlVUcwdGY0NXgrdlRxK2htZDN5N2dXTmwzVEFueGlqMmRSTVkz?=
 =?utf-8?B?VFpNNmt0bG1yL1ArLzFhbGJpbzBzODJCckZjekJBbXJQZmdnM1g2TW5NNUx4?=
 =?utf-8?B?YkRRaWVSZ0puaU1yMG0wUHY5WXJRVGR4WmM3NEhGM1BkZ3NFODczYXZZUXRX?=
 =?utf-8?B?NzlzZlZpaHdsamxTUDZDblZvaTBJQndEcU5pdHo2OEd3aExzQTJLRW11ajFY?=
 =?utf-8?B?d3FMMDF1d3psb0ZsRzYyaXFHaERlcjV6QnZ2dllVM1JvVDAza2dJYkNoK1Rz?=
 =?utf-8?B?THhQaTErWThWK2pIbFE5TUVJY0k0SUxQYTFoODdMT3g4NGJ0UDVnNFNaYjY0?=
 =?utf-8?B?NVJWaXlYQlpPZThNcCtTZkovc2swdXVLVnUzVk9XSFhRK1NRWXllZ29OR1NK?=
 =?utf-8?B?QStBWUZCQ0VDcmxObDZYMWs2SGtCQjNoVWFvR2RiTE9aOUYzRm9qRzgvTzh3?=
 =?utf-8?B?MXVQcVR0R2Rmd0tkVjJhMGFrV012eFRWMVUrdnNtcnNJa1liWk9ZWm9DaFEx?=
 =?utf-8?B?b2FWdXpVUHgrMjRqRnI2eUc1R0UyN2hpeWIzVGYyZkdMeU0xSW5BeEpsTWNF?=
 =?utf-8?Q?hzjlvTjItJ2uDpMvCM1Qp6d54WMC0Sq00QNszm3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFlUNm1SQ3QvcFpGTUZpSG0zdGxzQVc3QXQ0cHBzOXZPeHlHcWNSQ0gzU3NR?=
 =?utf-8?B?eW1OeHEzdEQ3VzVsdXI0L0NDdVlUZCtEZ0FQSlNxNzdZOXZhazVIOUZoalRl?=
 =?utf-8?B?M1N5akxiT1IxV0RpU1M3VlVrK25FV0pzd094dkFCZGdIeDNOWUJ4WERPVW45?=
 =?utf-8?B?cFJEMHVhQjBuaXdFQUxrbWlGQnk3SWtwTlpZcWVyNlg3M1lnaFdvSVNnbDVi?=
 =?utf-8?B?RTJFRW5YRDF4bmhPQkQwOXgzZm9FRjhWNCtJa200MkJZdnZBRnMxMTR0Smsr?=
 =?utf-8?B?UUNsMG0wR09xUmRPZW5VWEkwQlgxT1NQS3loQXEvdnRVbUNHVEtEdzQrM3p5?=
 =?utf-8?B?VjNEOEROZFFHUllNc1VwY3F5WnZyV0ZLdXlJYlUvOVRySWE5QWwvVDVSTlBN?=
 =?utf-8?B?UzY0Lzl2WGUvNnBZU28yRnllQlFyeU9rZnNWVDV4MlQrc0RBaUZ3ODdMVW1u?=
 =?utf-8?B?Vm9nbEh3K0dnZTErZEVGdVZwUHk4WEwwMUJBUFBocXpJSWhVcnJUYjRiMHlP?=
 =?utf-8?B?S2RFTHVIUDRCeERtNzZtRGF1VnRrNHFnVkdZc2ZsNzliZVNCL2FYZHhlVXEx?=
 =?utf-8?B?NlhJMEFYODZpWnQ3OVlaamJ1dThDRXN0eTBINC80ZFJQaTB2emlxNHZuRTJx?=
 =?utf-8?B?UmI2Q1pjZnI3RWx3eEV3ZytJL1V6V1hnMVBzZWtRY2dwSVA2c0ZyOEI2TGIw?=
 =?utf-8?B?OUZ4aDV1V1cwc1JwSnZBZERBaDFvRk9ZS0FHTE9ITFhYTmFXbkYzWUI4M21i?=
 =?utf-8?B?RkFvaVNKeUFwSjJSVVF0a0tOTEJVTG9BNVFLcVJpdUlDRkt4RTdGdGxvZkx0?=
 =?utf-8?B?TFY5SUpMTW5CMTVkVGJNR042N1padzZWa0RqTWV2OUdudUlKTC9sekFra1pZ?=
 =?utf-8?B?ZE1mcG1jNUEycXRvWFpkZEZRQmhKSytGVkhOQ1l1TFFhb2FuY21HOGJSV0E3?=
 =?utf-8?B?VnNzYnc4K041Rnp3dlBUUUVmY0dHS1p5YWMzNjVDQ0xpQ2pWRUFEa2JrUE1Z?=
 =?utf-8?B?MGEwcUZhT0RRZmxLNWdIYU9JaFVHRUlYdFlPd2RFZ2x3bWtzRk9WQ2pnQkdx?=
 =?utf-8?B?ZzdCMlFzMG90Zlh2ZXpHNHZvRVRIQlJzQjAvUkxMdUVYNjdFWlZhVm9KZ0Y0?=
 =?utf-8?B?YVVjOXlvbVRzaitCVE1mU00wdFNFRWhLOStxUDRWY20wQi9qTHBJM29MWUI0?=
 =?utf-8?B?aFRCYzBRRWN1RlU5bUhsYVRaQ3RWMkVxbjAyUXFjd0p5KzdKbkVmZUw1OG5M?=
 =?utf-8?B?MEUxbUljaEZCeCtzZmhLdjczL3NBZDZZSTB5NHQzcWxCZVVsV09sNzRQd3pP?=
 =?utf-8?B?VWRhWkZjNm9icWdNZUE2NWlVNGRJSm9McWFWUnBmWEFqVGhKZm50aXprc3Ry?=
 =?utf-8?B?Vmg2N3EreVpCSHZpOHpjOWZ1a3lXMHFhZXhYaHYzSXJjQ3FZQ2lCRjFFUXNI?=
 =?utf-8?B?TVRDZUVsT0VlaVRzZFBQeWlDNVFia1E1MmxPV3ByUDQ1M0hPM2M0WmxpbWIx?=
 =?utf-8?B?azJmWktqNlczNWRwZHBnT3M0MUZNVkc5ZWZaRnhUWkM5aml3WkNzNW95MmFW?=
 =?utf-8?B?djVHSjB1MjN2SS9iV3FsTWxyRWJ0RzJiM2w2WnZYZ2c5MFNYK3o3b294ZWVV?=
 =?utf-8?B?UEQ0MXhqQjd3clJHNkQwWVc5bW1TM1cvYUFuekJZb3d6bDVhdS9TNzF6ZHdG?=
 =?utf-8?B?Q3NhNkJXL0UrTGZaU2J5eG1nOFhFMlR3UGh5eGZuYXlhMmxncVltd3VqVk5I?=
 =?utf-8?B?NXFWSmtFdXBlZTFsNmxlS0MxaTJVQ05rNnhXQVl0UjJlN2prTXB6S2tKOHBy?=
 =?utf-8?B?S24zNVpPQ3dIK3FkYlZjZTlWeEYwazJlWXhHRnRQMGJnK2tiNXcrcksrTGhN?=
 =?utf-8?B?bHJoUVR3bWplMDQvdjE3VG12UEJwaFFSaGtvUlFnbzRsSzVMbHF1MU4yZ3k4?=
 =?utf-8?B?MUhaaDlnYWF0emZWOG00R0M2YUg3QnJ3U2pQdm0rSnZMWThFRnhlSmxzd2xE?=
 =?utf-8?B?ZHJ1VnQ1MUlPRWlsYjdpOEo0TUxrQWlJV1RLWlhHQ29vb05tWE16YnBKY0VZ?=
 =?utf-8?B?TkZDcnpyTFh5eEVRSzZOc05Yc0owb0RTTU5scHVqOGtySGt6aVhiVVBpTU5O?=
 =?utf-8?B?cDhMN3UxN2NrWmxIcHhIWmdkMk1MbGRWbGFYa2NWemVmMnFGZkVBV0p3dGhi?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SptDrcRV0Ti8KKbgQC13LKf4v9Wa7C8TjG0tml5cA3stbVXUmS6E+/3SzEwCwiFpSkMkAuCVZ+heQqu19FDdtZ+Goy9FaYIESAaeZvfuqL2O82+SxdwarXqZE8I1lPcI9RuQm6l3oO+Vi77yC+NYUF9m7oLgfEL1/Ybd613v9MVhj03FYLdninT6EzSzZkoyX4V1CMCWzFAa0PTnG8+hKO5ncpVydK/JupVjfhJ4cR58e+DNcQ4kbX9u7l/UGtrLNPoOPqJQKn8X6ZaCyEv8qa8hgS82+hHAaOy8/Ft9WS3bED6QAzCgexbglrYRTZmZhP551C5x02MNEYrdkNyX4m22vwS0XU8SWcz7vVy3o6iSPwyxIhgSeRqtvC5IHp+OFLtskf982SUmx6wlJ2lebHerVAHHb3h32Xj77wNLirAweeqLsFZrXxo2SEMK9EvFyK/osFFSZBKkvyJHQNe2qWccNDspAaq6SwJ2UkG6UytH0/EXcgPpUFNH/tX8kgC2i0mbcUAwUy0FLKbAroJqkYZuS+0tc20ePhi3LnxO17rN/sKP6obHpfTLawLQQ3AX0bdq+gGgGYkwlSVwyFWdO1k/ElIGODi6jkpKniSDSLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca2382f-bf74-418d-7a22-08dcfa8e556b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:00:40.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDagpRiHLtVr1IdkGNaWFzd8WJTAy1dLiN5gBfSbP7b7nAVuveK3fqmRKVvByTKWlzKntJYcCdzoBUXHaHPRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_10,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010116
X-Proofpoint-GUID: 3j4MDBfXaTZvfbtVHF7tiu3AaJUxsqwF
X-Proofpoint-ORIG-GUID: 3j4MDBfXaTZvfbtVHF7tiu3AaJUxsqwF

On 01/11/2024 06:50, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Regardless of nitpicks:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   fs/ext4/ext4.h  | 10 ++++++++++
>   fs/ext4/inode.c | 12 ++++++++++++
>   fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..494d443e9fc9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>   	 */
>   	struct work_struct s_sb_upd_work;
>   
> +	/* Atomic write unit values in bytes */
> +	unsigned int s_awu_min;
> +	unsigned int s_awu_max;
> +
>   	/* Ext4 fast commit sub transaction ID */
>   	atomic_t s_fc_subtid;
>   
> @@ -3855,6 +3859,12 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>   	return buffer_uptodate(bh);
>   }
>   
> +static inline bool ext4_inode_can_atomic_write(struct inode *inode)
> +{
> +

nit: superfluous blank line

> +	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;

I am not sure if the S_ISREG() check is required. Other callers also do 
the check (like ext4_getattr() for when calling 
ext4_inode_can_atomic_write()) or don't need it (ext4_file_open()). I 
say ext4_file_open() doesn't need it as ext4_file_open() is only ever 
called for regular files, right?

> +}
> +
>   extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>   				  loff_t pos, unsigned len,
>   				  get_block_t *get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..3e827cfa762e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5578,6 +5578,18 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		}
>   	}
>   
> +	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {

nit: maybe you could have factored out the S_ISREG() check with 
STATX_DIOALIGN

> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		unsigned int awu_min = 0, awu_max = 0;
> +
> +		if (ext4_inode_can_atomic_write(inode)) {
> +			awu_min = sbi->s_awu_min;
> +			awu_max = sbi->s_awu_max;
> +		}
> +
> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> +	}
> +
>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>   	if (flags & EXT4_APPEND_FL)
>   		stat->attributes |= STATX_ATTR_APPEND;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..ebe1660bd840 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>   	return 0;
>   }
>   
> +/*
> + * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
> + * @sb: super block
> + * TODO: Later add support for bigalloc
> + */
> +static void ext4_atomic_write_init(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct block_device *bdev = sb->s_bdev;
> +
> +	if (!bdev_can_atomic_write(bdev))
> +		return;
> +
> +	if (!ext4_has_feature_extents(sb))
> +		return;
> +
> +	sbi->s_awu_min = max(sb->s_blocksize,
> +			      bdev_atomic_write_unit_min_bytes(bdev));
> +	sbi->s_awu_max = min(sb->s_blocksize,
> +			      bdev_atomic_write_unit_max_bytes(bdev));
> +	if (sbi->s_awu_min && sbi->s_awu_max &&
> +	    sbi->s_awu_min <= sbi->s_awu_max) {
> +		ext4_msg(sb, KERN_NOTICE, "Supports (experimental) DIO atomic writes awu_min: %u, awu_max: %u",
> +			 sbi->s_awu_min, sbi->s_awu_max);
> +	} else {
> +		sbi->s_awu_min = 0;
> +		sbi->s_awu_max = 0;
> +	}
> +}
> +
>   static void ext4_fast_commit_init(struct super_block *sb)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   
>   	spin_lock_init(&sbi->s_bdev_wb_lock);
>   
> +	ext4_atomic_write_init(sb);
>   	ext4_fast_commit_init(sb);
>   
>   	sb->s_root = NULL;


