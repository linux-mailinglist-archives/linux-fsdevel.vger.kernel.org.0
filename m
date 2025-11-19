Return-Path: <linux-fsdevel+bounces-69121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295EC701ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 17:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 154A32F125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0D364E89;
	Wed, 19 Nov 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jywQF13v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XqcJPfUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A180327BFD;
	Wed, 19 Nov 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569993; cv=fail; b=MIg/BzQQaIK9oJ63z1Cyc7gkPjS1YODOh4xkzzzKycZNbHgPt/l2hLbEFCaWbMw/ZCZGszy7IsWdKvtX9UcVZkf4AGj2EPGFc0cc+f60LX0GpU59DmwTtTe4k+L+3556a/6OSyOWhS+bEAFaFQar0vi3vFx3SAsemohHMKhApYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569993; c=relaxed/simple;
	bh=k0mMq7JIL40Zd0SPZb/PUsS8oSX6Uh/NRcl25LpZcpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwIQvJx8S6JhS0FhzCNhVRcBnjngfAwAu9tg8XJKAexPh7LVdDIwNmZr1hxPRlXUZGIiDLqbCazqFx3CAvPRNWILd0MuqFKUVUX0Id2JVxb/D7eMYLnXg+0c0bf1z6/Zi3azSpEVgMJ/p9CiG+HRw7QXPQMNoAUFOvkiOWjGv94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jywQF13v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XqcJPfUK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEft0l001646;
	Wed, 19 Nov 2025 16:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zPnzFBMzIpSqRGwFboKLbVUApI0LmU8Kv552PnF8/lM=; b=
	jywQF13vjOVJ/NjylQctrFZjgvmKWrTEOvk/O0qitHIi0m3aTmMzr96FzHQsDbjV
	JORUrB3FKtVDaktZV4UjLr2KSct4ts/hnZxonAXOeD18TVPZD7OYXsNy49oLSSW3
	/U6jqo1hfocNIrxFY/8UASd7phZS9DtfKmWOcqFyMXJNF3dAf549tg3iiE3cjoHD
	RIw3Bjj+ijpS8S0/6qLwLAztrYYFb2+rI4d5L/wwJrWIsG+uIfRkDZ3j8e1fZGcB
	NZtSHX/Qf0GmGC2X6ZKoLodSHE0s4MHqlesWmZQQKbaE5z6J4SbOeilrX/WRJ/29
	JFrxPYWz/2Ec83XyCJWjTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuq9b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:32:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFVHQl035995;
	Wed, 19 Nov 2025 16:32:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyn39e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw+h40kMTpMBpYwADtndbKCH4hLQgtIiE81Pa+NDgKFJGjfJbbXBzuANdxnf/2XbTouhNzQsVTPdmYltGFfp8TMD5mugBZ6n8SoG+K2xH+X50xgTNRlZzVpufxqNSt3o+vTk/uYit5yVzK3HL/GBHHKBGgSwYBT/oFBxK1g94zB6WgggrBd5Glk48ObUS0jUpUuiB6pv77lpu7jye9AW1hEpfuVLzCPhaSb8hqgrqGiKCl2tyn8T0uG1UiM5Sa4aPIqSRLDNK1mf7tmxfnLNuh8BQN+s5BM3T7GDmyvUcfTqaJbfC7XVdX8YMYT2fpY8Ix4sYxACaLExqAyoYLqjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPnzFBMzIpSqRGwFboKLbVUApI0LmU8Kv552PnF8/lM=;
 b=fMZX5lUG3if119knbgxIstKzSwTlCsm/oXJAYZybcCcUYedXz0Ziau8Lcuetl/fhRzpaVfItDbMDL19Sjc4iCjhJR84Z4HbhbIcRjBZHoDa0pPg1bX6Cww8pRqEnoyO4g0lWw22NZ1KDe3/nJVW5AvT6fM7va3p9E5RRPY+VV4j+vEV/rFWQtF+kL0JeLgxtZZEvVE4VvllyliUJU4yhvTlPX6/COHFTEL4OasglDX+JCwKc/irLhboNM4raAZJTvFxsnAtBD6nMB0ciTJWomUnFmzr6ycMi29EdpXaCSFD+NjePDielvfSiG1yUq6aENuc7oXRo5jhssVl1zjE+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPnzFBMzIpSqRGwFboKLbVUApI0LmU8Kv552PnF8/lM=;
 b=XqcJPfUKEJnZ7l01Mz0iCjDFK0aEsAEr7c3vTikLGsbP6lTlBJb/F/OQnYkfsx1Iv/tmm4JuIgZdE3Rviq8ukshyA7zUsWcMCnFvR6/7G+AYU/ASoqEmWtnzHTKTLX72RCEs5vveaQtX0ouJ0bz/NKtbqZeLbMLrKmgrea6W63Y=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Wed, 19 Nov
 2025 16:32:30 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:32:30 +0000
Message-ID: <ec0f990d-616d-4284-944f-68929fc671a1@oracle.com>
Date: Wed, 19 Nov 2025 08:32:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to
 lease_manager_operations
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-2-dai.ngo@oracle.com>
 <86aa02b2214a6a775bc2d3fde0d180c2a55cb374.camel@kernel.org>
 <cd1e4e2b-a8fb-44f5-b421-f40577b5e795@oracle.com>
 <dffee3dcbea10e88666bd145bf5f66bb921231dd.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <dffee3dcbea10e88666bd145bf5f66bb921231dd.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF0001330C.namprd07.prod.outlook.com
 (2603:10b6:518:1::1b) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: a0459bb6-a324-404f-4992-08de27893bbb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eFQ3OW05Z1gwVkQ5K2Q1cHVvdGNmUWV2dHB4SjVkUk9xRXIrMkI3eXJVTHoy?=
 =?utf-8?B?VWwyeWxiWE9MWWVDYlZFbnFnR0Nad0UrOTI2VVlKOWVDb2txRTFHbkswZU9Q?=
 =?utf-8?B?UEZtcWo0aEpUTFVJQ2pFRWdJaFlxUkN3NzM2NXc1QUdOMkpYQ0FFS0NTeS9q?=
 =?utf-8?B?ZWNkaDI1VXE2Y3dBUWlkUGZKMXF5U3hRckdBNS9weXJmR0VVNGZPYjR4UzZn?=
 =?utf-8?B?Nkc0Uy9ZdDdETzkwazFLM3p4S0ErTDNnMnpZYkh6QnpiMnpPaTRWZTB5R0tw?=
 =?utf-8?B?WlhvR0tMSUc1ejJmWjVxZkdNMFgwU2MvY2lwdmx6RnozQStpMHd5Y1M0K3cx?=
 =?utf-8?B?aWorWXdUQ3RKdnFCbWJFYUZIdHd4UU0zKzdHRkNHVUJ6M3JYWGhkRDBCdmdx?=
 =?utf-8?B?RVVmejNyeFU5c1gxTkJOVDc3Y3Z3M0JVTmJNb1Y0Ym5XR1VHNWZJeXlTNkVX?=
 =?utf-8?B?OVhzSGtrWmJldHROd2FwbGcxY0EwNHJhYW9HK1p2aysrMktmRU9URjh3MHpo?=
 =?utf-8?B?TlBTSlRIQmdtcmQwWG9CNkFZRzVyelptNjdqTktPWmJFVTRNc2txNkdYN05v?=
 =?utf-8?B?a1JNVkd6aGJkamlFbWhWU245UnBMTE9OYllUblJsVEVHUVRUNFVFM0tDRGNm?=
 =?utf-8?B?YUpoWmtpbmtocGozc094RHBvYmJXQ05CeDRvYVlCU0dpMEhmYS9pSHRTdXZp?=
 =?utf-8?B?djkrRzdLWWJjN3FkMkdwU1JtZEY5aHhZZ1VPNGRFT2FicWFNQVk5dkM5RWJ2?=
 =?utf-8?B?U0Ezb0c2TmpySkdKS0JaY1d6cmErdnA5R2RMNzhYdVFQWTBrZndEdk5JK0FO?=
 =?utf-8?B?UmFzYVlzV1AzRzVqNFB4dFJWY3R6TjJqdGFJVFk3SkMvd1FFMGlTbHNUMUZ5?=
 =?utf-8?B?K00zUFNVSWF5aFNLd2dLN09XZHh1NjhzaCtIL0R3bEVIK1NGeTdKNCtScEU5?=
 =?utf-8?B?RzdCNWpaelNmUWNIQXMxMjRSZTVzQzlIblhYUkxzbmRpWHBWNjEwUE5XVDRp?=
 =?utf-8?B?YXhsUmo0RVJjNkRhZmZZWXkwY1JsUUJyY3Zhcm9PUmR1MHJtRVhITnhQbDF5?=
 =?utf-8?B?eUpnS2JmVzMrWXNKdHdFU1ZZWHNGU1F6VllsK2lKckJqWkpPNVFIa0wwTlJp?=
 =?utf-8?B?V09yK1AzMm8xWVRtci9TQkNVV0dCVG9Qd01Td1dlWTNhamxBbzg2SUk5NThi?=
 =?utf-8?B?bkZZa2JjVFY1Z3JBdjFoVmRmMzRPNXhiaHhtY0tVUk9kUUtXKzJMODY2R0tQ?=
 =?utf-8?B?TitiYjN3S0xiVDBnRlY1b3B4S2pJS05qcytoaFFycngwNU1qNmlFbmlWV3hX?=
 =?utf-8?B?aTUyMyszWWdPVXpBNUtrVkdGVG1YS3ZYMkk0YVY2d1F3dUNUS0V0aUsyT2M5?=
 =?utf-8?B?TEdncFJ0d2hXZk9GbndaMlJnak9lOHZCTWIwNStkUVBSei9LejVVL2hmNkll?=
 =?utf-8?B?QlF0bnV3cjlkUXdicGhTRmZwVUhIOEFCRTNBamh2Wm1GR3hVRVRGV2VXdTdT?=
 =?utf-8?B?MG5ob0Znd0Z1SW4zRldpMFVOTmRXNGJQNE5BeWlTdU5BbkRXUldZVUt0LzhE?=
 =?utf-8?B?Y2YxMUFZYlZ3TjVZUWVGS2h4Q2FrMGdNVHNYY0hUSXBRaFpvL0hwNXVlMEFw?=
 =?utf-8?B?L20yTlVjN1FCQjRYNVBlcFBLNHJLeTNZajVxUVJEbG9wSzBtVTNKWitWVE5M?=
 =?utf-8?B?ZWpoUnVvbnZ2bXdoY21RTGY0aGJSWE1vVzN0QmJXQVdJaElCVEViNlhJRUp4?=
 =?utf-8?B?cCtaUWZRYk9DWHNkQ2h5YmRlU3ZERjdnS3ZVdkRaVXVMc3UrbnBVaHR1SHZh?=
 =?utf-8?B?SDlNbHpzcklzbFJJdlZoc3JDZzVtajB4T09FcjdlYVM4VzVGbUViU0ZsWjQr?=
 =?utf-8?B?UGQvMjI0MWJXNXI3blVnRnJHcklpZnMrY2hDTGZtVkZabkgyZlVDeWhpSmp6?=
 =?utf-8?B?UkRiMkpYcDh3dWNnMjJSWWc1N3ZTL3ByOGt3UXVRUEdmY0RTWE9TTUQveDdF?=
 =?utf-8?B?RmZZSUhYWWdxdHhYdG0vcGhRUk82MmVPdXNkaWRLMmJEYTlpUG4rdm1qTjFY?=
 =?utf-8?Q?/vdXqC?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YUdmT1VRZEZaOTlueUFvVFdsbVBaV2xMVmY1UFJyekhKOGdWa3ZJSzBURElS?=
 =?utf-8?B?VUFpTkgrSTdpNEVHL3g3Nzg3Q2lGcG8ydHQ1bDdLZlcyOWFLUWtLNmoxU0dS?=
 =?utf-8?B?bWJvaEpxRWd4NWpYblR5RFMvRHlva2F1ZS85c3QyendsNGNSMTROcXFsVjBr?=
 =?utf-8?B?V0ZCbmJjdzRMbnJnODdKMVZ2eEc4cHdZaG5Rb0JTWkNkU2ttSUUxV2NxeGlY?=
 =?utf-8?B?WkJadGt0ajVwMG9aY003UUFWUUR2cXExVTMxdjVBbTM4K0Q1NHNla3BGWENJ?=
 =?utf-8?B?UndnRlhNNzdPQldnaVQ2VFF1RjBkNlAwZlg1L0h5S0dTRmhyeGZUb29OV2Vs?=
 =?utf-8?B?ank3TGV6Q0NJa0xLL3M1SUQ0VVp5cGxORUJkb1B5YTA4TkhwU3Z0S1Jmbnli?=
 =?utf-8?B?cHBGNDFYd21zTEtkR2RkMzMwQ1NQR3FMUjNTS0lZakxSbHB5azRXMFp4VENJ?=
 =?utf-8?B?UUdsclFuOUw0M1ByYkNKZ3o4QkhzYVZIV24yUHJNOVBWaWN1N2NDOXY0Ty92?=
 =?utf-8?B?T1l0QWhpZmJPSVV6WDNJNHB0Rkt3QUtWbW1IS2R0NjlZOC9xS1A3OEV6UWor?=
 =?utf-8?B?eHpBeTlvSGZLY3RNL2NwOW5NZFQ2RmdiQjBmNWxlc2hKOHlUNGl0U2E4cVRG?=
 =?utf-8?B?cXpxYUdjWU1QaUJVYXFRREpicktXMTB2eTlpZWNrb3ZWYmFkNGFoQ2ZQR1BL?=
 =?utf-8?B?Q2Y0akZwcFFOVzJNYUhHc0hIK1czck1WclFBMjhvc2ZYYXRnT3lhUTBYL29M?=
 =?utf-8?B?ZDhGbE5GUll6T3ZtMjFwbmJUaTVJRCszeDY5RDRyNHRJT25oWDVteVB4Y1F2?=
 =?utf-8?B?bzFDMzR6SStFWTBGZXJnWVRGVUd4SEtqWHh2aUhTS1NUUjl5ZEprQ3VHeGNr?=
 =?utf-8?B?SkUxSWp4L09VU3dFUFZmT1g1ZUU0QmZLY2lLYUJXaTErS21zYWt6ZGx1REkz?=
 =?utf-8?B?MmhkdHpDTnQvY0t0OG1rMEFBbXRrNU1oa0pMeW1kSGRrZkxQS0JxQ29ubWZL?=
 =?utf-8?B?Z3V5WDh0dGtqRG02QjNpUERRTGtyTU8wdzBlOGNGelNZbkVSV2dUdTJycDc5?=
 =?utf-8?B?TThsTjY2WjBjaXcxV3FPNEpjNFR5RHVnSTRuRzcwRHhKWmE5ZEVxN215T2ly?=
 =?utf-8?B?SWpJZExoQTZXYjYyakFsMVZYWWxZSGhsc0NVZDV3Y2taQ0M4NkU3cTF6WURa?=
 =?utf-8?B?dlliODc1aS9ZY292NWtDRXRJbXkvbURyeXoyQlVrZDJOUjVKNFEvWndtUWdM?=
 =?utf-8?B?dkRpT0t0YTJUZXhQTklSVWNQN0l0U2hwTitMaW1WZVRxbjZ6Y21OdDNaTUx6?=
 =?utf-8?B?eE5PUmdmL3M2REcwMnRyeFVRN2hVekVibDFCNmpCRHdEUkVWTzQ4VDE3TnI4?=
 =?utf-8?B?WXBKb2dtQlY3UDFoRU1PdnlhNGt4U05jQ1RicXozT3JKd1ZEZ2x1cHdUdENr?=
 =?utf-8?B?MjFmaG15TzBRWjBxZEhzUkpwY1JKbjg3cHpMR0VOT1IyS0M4RzduVm8zM3Nu?=
 =?utf-8?B?NUorS0w0cERjT1U2Ym1EYnBpaWMreHl6RSsrZ2hvaW1xRWpSV1VpOWFVcW1B?=
 =?utf-8?B?WmtSOTNOMFQyUEJOZXMrU2tLVlh2dTZsQmR5a0dVMjJiVWYxTjVLbGNpQUZo?=
 =?utf-8?B?UkFoZ05ReE5KSTdTZ1htUnpzRGQzbVZLWWk5L2dOWnk0MXZxbG5sYzh1SVBX?=
 =?utf-8?B?ZHNJT2t2dVR5bVFKb3NZRUF4WVZWRDF6T3NMQVB3eEVNc2drMFF3VG50WkFr?=
 =?utf-8?B?Zjh2ckZzaTNSTG5LaTc1N1ZZRTh6aDdJOTV5QTlFMjZSRk1xanBOZlVQbEkz?=
 =?utf-8?B?YVBxVCtCOW5qMmJoaFpGVDA2ejVsQ21kQ3p6S3hidDFQUFVaVC9uMDVCV2Jw?=
 =?utf-8?B?WFJSNEZ0WFZYQVI3Z3ppQjVuZ2FxM1BIV0ZWNlNQZEtxSWFXaC9QZVJtUnha?=
 =?utf-8?B?OVAyT2k3aFhsNmFyZUFBeDZQZ2RqU2MyNkl3cVF4RG04cFg5NzB1QU85N2xu?=
 =?utf-8?B?eXVPaCs5Y2hvN0NsK2lnaS9reTVCN2NPSTFQeUtYYWFhQ2xmRDgvYS9jTldu?=
 =?utf-8?B?L2xhY2lMUEg0eWRIaXl5My9PSnUrVlpLeVVTU3I3UlRKTnhlbGx0NmE0eThn?=
 =?utf-8?Q?+3VUQ9tqusm2a3G3rc6aBDo9x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uPcpUac3dcnlrz0EBwM/v6dHsusgu7qoCn8vtBtz+j7V06kN0h2L0N7rbqq+qLezd2hvuYItjOu5Mt82tzv57lAbxuVgi/WXQd6YQQF8i7HXoOIgQD8tPeGLyRjnJwC8FYgB11BVs39QyXqfOr/h/24CxkTifu1Go1PbdMXf1ryGTi91Dhx5ybXMfc9JNtb3K77+zVk2yba2/q8pEuMbwGoLo2NQqm2paDc1dhiXUWsYC9rC0nVuF4NUXctdOSfY2XE0MUGzetHt9y3SvinlP4excai89Z1GtNxwfR3VE0rmqPciV0gsNQCt4nHM9UvFqJ5eLmqcFZCjsyCH8NY7O+tcC1quPL83DDLLXnY1NtkJNNbaXGUHYMh9q1O6P8N72chtZHhVbJANdJg0Rr6WAw9sruGeFix2VRgtAQJW+cILLaEBf19Y1RgQi4I2rNiDDT69lDAMrH5Har5jHAHh+iYToMzX+MkbK57h4R2nsLde1qB5ystBcjEFzaKmpbOHHSgu1h03sO+g+Unn04ps8WHWGK5tl9/C6LKWPnuzn7dLuKlCzV6yvdB7APyhlJQmvLYYm1Asd6wmnAwEuwYU16p3HVQbD++GWjdKXsGZtCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0459bb6-a324-404f-4992-08de27893bbb
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:32:30.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+7KktxR/E+969dB9eXSFI5h67VAthFLhy57PVfEWoinj4eYc3ivT8z91pnkgYPvbx8O56nC+LlOSNPsJxuMJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX9lm0FFjMayOh
 ogL9AlB7kCQlN6iJ51aOL2xK0cPCgRmweu0T/dG1F6RjtdBwiiJxvBkMWsCdgMq203GyvcpKvKU
 DRhkKrDLHoQ8RzxLQdPdW2pP7HtbC+yQR9Rq4vYP8LOgFpB3CXMbfmfycQJ8Mg5TQvCz1m4NElH
 EphmJSAiDbZEsM5DVjwl5vK6tHN70n5YjvQGjsFJV/IcYxq8bbTIOyi6DBQfl51kXE7LVAfPUgz
 /aOtlkaGGtVy2cmATcTOReY73vj7HKO52xLG0tfQ04RCdw3WoDx7L3SGMK+Yr5o27CV9+zsXnSB
 A4Bhn2u36WvjWLZPoisOaOrkMqaC/OZTzkhNnuXm5weZcpYi3VqsmsX7aVfrKYh3eaz5zQB3Ij8
 WA2tTm675EnvaQwE2A1RYe3ObcdJ4bkDEvZuOO1G/toPaDoRG/M=
X-Proofpoint-GUID: m3KMAEfy57lNC1LkfBo8T29LDUhrAgUn
X-Proofpoint-ORIG-GUID: m3KMAEfy57lNC1LkfBo8T29LDUhrAgUn
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691df125 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=efyEg92AL7HukhCygsIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098


On 11/19/25 5:52 AM, Jeff Layton wrote:
> On Mon, 2025-11-17 at 11:41 -0800, Dai Ngo wrote:
>> On 11/17/25 10:02 AM, Jeff Layton wrote:
>>> On Sat, 2025-11-15 at 11:16 -0800, Dai Ngo wrote:
>>>> Some consumers of the lease_manager_operations structure need
>>>> to perform additional actions when a lease break, triggered by
>>>> a conflict, times out.
>>>>
>>>> The NFS server is the first consumer of this operation.
>>>>
>>>> When a pNFS layout conflict occurs and the lease break times
>>>> out — resulting in the layout being revoked and its file lease
>>>> removed from the flc_lease list — the NFS server must issue a
>>>> fence operation. This operation ensures that the client is
>>>> prevented from accessing the data server after the layout
>>>> revocation.
>>>>
>>>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |  2 ++
>>>>    fs/locks.c                            | 14 +++++++++++---
>>>>    include/linux/filelock.h              |  2 ++
>>>>    3 files changed, 15 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 77704fde9845..cd600db6c4b9 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,7 @@ prototypes::
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>>    
>>>>    locking rules:
>>>>    
>>>> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>>>>    lm_breaker_owns_lease:	yes     	no			no
>>>>    lm_lock_expirable	yes		no			no
>>>>    lm_expire_lock		no		no			yes
>>>> +lm_breaker_timedout     no              no                      yes
>>>>    ======================	=============	=================	=========
>>>>    
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 04a3f0e20724..1f254e0cd398 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>>>>    	while (!list_empty(dispose)) {
>>>>    		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>>>    		list_del_init(&flc->flc_list);
>>>> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
>>>> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
>>>> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>>>> +				struct file_lease *fl = file_lease(flc);
>>>> +
>>>> +				if (fl->fl_lmops->lm_breaker_timedout)
>>>> +					fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +			}
>>> locks_dispose_list() is a common function for locks and leases, and
>>> this is only going to be relevant from __break_lease().
>>>
>>> Can you move this handling into a separate function that is called
>>> before the relevant locks_dispose_list() call in __break_lease()?
>> will fix in v5.
>>
>> -Dai
>>
> That may not work actually, since we may end up with a timed out lease
> on a dispose list in a different codepath.
>
> I just sent this patch:
>
>       https://lore.kernel.org/linux-nfs/20251119-dir-deleg-ro-v8-2-81b6cf5485c6@kernel.org/T/#u
>
> Assuming that goes in, then I think calling ->lm_breaker_timedout()
> from lease_dispose_list() should be OK.

Thanks Jeff, I will wait for your patch to go in then rework on this patch.

-Dai

>
>>>>    			locks_free_lease(file_lease(flc));
>>>> -		else
>>>> +		} else
>>>>    			locks_free_lock(file_lock(flc));
>>>>    	}
>>>>    }
>>>> @@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    		trace_time_out_leases(inode, fl);
>>>>    		if (past_time(fl->fl_downgrade_time))
>>>>    			lease_modify(fl, F_RDLCK, dispose);
>>>> -		if (past_time(fl->fl_break_time))
>>>> +		if (past_time(fl->fl_break_time)) {
>>>>    			lease_modify(fl, F_UNLCK, dispose);
>>>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>>>> +		}
>>>>    	}
>>>>    }
>>>>    
>>>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>>>> index c2ce8ba05d06..06ccd6b66012 100644
>>>> --- a/include/linux/filelock.h
>>>> +++ b/include/linux/filelock.h
>>>> @@ -17,6 +17,7 @@
>>>>    #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>>>    #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>>>    #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>>>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>>>    
>>>>    #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>>>    
>>>> @@ -49,6 +50,7 @@ struct lease_manager_operations {
>>>>    	int (*lm_change)(struct file_lease *, int, struct list_head *);
>>>>    	void (*lm_setup)(struct file_lease *, void **);
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>>>>    };
>>>>    
>>>>    struct lock_manager {

