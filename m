Return-Path: <linux-fsdevel+bounces-42573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D582AA43D4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0193AD3EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D12676F7;
	Tue, 25 Feb 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IO9AGRgZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WjH9jqbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE381C8627;
	Tue, 25 Feb 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482036; cv=fail; b=B1Gw0f5eWuSb1u75x4c6S0fw+aeWeKtVRbYDqNl3lAOarpqjKKefBuwArPNwGSvBNu6ODRsyMSL54DPyOxpvOCw+XZVtRb6QjL0GMZ5Y1Q63VJ1Ht+FhBfS5BFEmPONUzm/gFstf5zAPO/jP2pwRcNnJIHDQt8XpVPoFfs2gEow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482036; c=relaxed/simple;
	bh=ZhcSoWqZL8o5Yg4EDmJDV51Jf4p3zcKn4R/Xw2zXkIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CISqueQ96HNwqxZ5XLcROOCBG+OX9PgRBLDQ+JPMBBrgRwuS0hM+5p39YREoFMsHcP2w/jgBkHiT7xEy+JvKhP14xEnda5bjALGr7rTBhHw6JGVNdlyZ0TQo6Ow3RMrmnl9Fxb8Ruvw5cIo2nqXGIEv6w2ZmftweSYHh2S7nNLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IO9AGRgZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WjH9jqbQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABmrJ016988;
	Tue, 25 Feb 2025 11:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LaoIlptqxxEtX5VTdFcrBnpLrxW5JjcT0r8nYo+DG7g=; b=
	IO9AGRgZYosFgPU0eSKrK5NbsIHkhqSSjbQt2W0mGRJiQP7166enrFWX2WyHOVa5
	mbFkK5RYi2vjG9mCpS6PWAnUXIYZ5q75KfuoB+uCF4UIh8g2Vj/vN4jDOOjlmqzv
	s/ky063rZLBQ9hs7kHNcTpuXXx/mIZAX1Hyfe99qz1xy6LovL9AkCjv+03PfwLap
	bmTnFcdAi4sTyNdDl8XkE/nHceWDu6mwjQdk3h9mY1ZMqibvbDC7LGJI9Wgoa4PE
	WRJLgmppymqHdiK0S8dBI19Oqefn8GnSgEoLTU4297oloNRorv208EBE3LNMGEm+
	8iFj8j5U4bv3wkYZiZxz4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9csyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:13:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAC2v7002887;
	Tue, 25 Feb 2025 11:13:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51980nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9RYrm9ht+Xh4oM9Y7vTtGAS7ONW6f+aph7kaWVHNESNLC/07as/UPPZVeWO/7lfrFQdr3MRU8A+rS2TaHNyMIsDUHqLl2vt+imw382mQ4A8uXTqY/XCfGyRXGdu7/lwrPHwCA0je0xlL3wXQuCnLFuDQWxRxxB+uh7dTTXtbnCJgvKyOzHLyNRkLuSkQmSaEW5PDnOaJvfGCaHYY5i9zgr+GYdHJqEbkNFVhDrNk8YlzQFX8qSYY4ba57bsrqYEGICBscrEzY78be5pk9Z0ItolVDfopDobzf6+ZhIMuyyvDsiIkxFQBaJwFLxVzdawi96aeprQ4yMSQsHkDyXO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaoIlptqxxEtX5VTdFcrBnpLrxW5JjcT0r8nYo+DG7g=;
 b=af1sHaeeyKtUJWAkzJxCbz+xaSWAeAe3RCQXxjYsJ5uuejQ8NnzkVRAKA+nQkFI2l7lC0wlfTlTjsaNclwjtkfL1FDIoK56puCZ/sEt/5QqSELFra7cEsChXqRIYv6biUY0ffHED87/aEaJhw8BlXsAqU0YOhFYF3m7zVVJi/t1dj6gpPCW1tZ2vtSbP5Y7um7st72acpvWV8Y8Svg7wvZnzKr943wlfDKneJsa/VQaT+A52Fk0YLqQuTm4nYzVS+UpeIT94oNEbRU9VEtsYFPpKOWmEtAZvKYpNoN4fWSqWc6fRkwWw16+lPTILDPXCeXYCq7xAxptyXy2uQEThlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaoIlptqxxEtX5VTdFcrBnpLrxW5JjcT0r8nYo+DG7g=;
 b=WjH9jqbQcjX+hUodPMlYG5tdEoyypqyHOaBKBDHlQDAcV8IEIlNYwdc2yajg0kl0UHzVyhFIGg+OIyLLvRUjxTU+NoipuRHRVyRei+tvxh+eimtBvoLsGDPA5GMHNDwN2NRVWVYO80BSA84IsBOHnm+61jfTj79DCV967GZiN5g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6321.namprd10.prod.outlook.com (2603:10b6:303:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 11:13:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:13:38 +0000
Message-ID: <17c44ceb-bef7-4a5b-bb9a-d852df8ef8e1@oracle.com>
Date: Tue, 25 Feb 2025 11:13:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] xfs: Update atomic write max size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-11-john.g.garry@oracle.com>
 <20250224203439.GK21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224203439.GK21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ad9836-8e4c-40f4-bc1f-08dd558d73cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1UyRzM5cjZnQXhES2h1T21PSjBZc2ZQdXFsNGxHUUZpc3hMMUk1d0JISkRZ?=
 =?utf-8?B?R0ZURDQza1N0MW5zYU9KZDRYU2JHRE5KeGRiYVdHSml0eEF2bWx3SXlPVG80?=
 =?utf-8?B?U0xDZUVCbkJMam5nRXBOeXI0MXo1Z1lEU1pxVXZCdmZBNktZdHRTUWp5UzVX?=
 =?utf-8?B?aCtuUkE5dklwRVBUSHdFN1JYaysrd0FxNHZLWjkvUmYrTXhXTE9CWkgzUG1s?=
 =?utf-8?B?bUg0KzZxNTRVWklPU0RiMzgwQlk4SW9BS05tdG9jZHBZbHp0amtaNUZudllV?=
 =?utf-8?B?N3UrNVRCSFltM1FtcjNiQ2ZJcHA4MDRPUU1xNmNtczNkWjlvcDk3VkdWMFJ2?=
 =?utf-8?B?MVpTWFN6RklLNjhJZG1LejgveW45SGFsdmpPZUZJWjFCaFFzZE5ENDRMZmNM?=
 =?utf-8?B?clFzb2FrVFMwQmpoS1VndmF0Wk1IWTVMQzhRNFVpVldwMFBWSkxpOVJaakNK?=
 =?utf-8?B?NXlaaWxsOC9reGRsUkdxbVlVRUxEeGY2S2tRWllVREZMMG5LRTZMOEhUWkZx?=
 =?utf-8?B?K1B1NVpla1VrQWVndXVCd0pvRlZyOFNZRDVzSHpxSERWRmdRaGlWMEozaDJQ?=
 =?utf-8?B?Zm9BL3M3dTllN0tpK1daM1M0TFg5T3Q4Ykg4V09BYmJLdGZoK3g0NkhoWmlx?=
 =?utf-8?B?djdSY1BZZDdZWHRoYmY1NTY4YUxucnFIYjlDNGVJaEdoeGUxNm1rWmU1ajZr?=
 =?utf-8?B?YmF1QkNWUmZybTRMOHlISm55c1JocXY1VTZPVVhqUGoyZHJhbTQ4UGR5aWNV?=
 =?utf-8?B?WkJsR2NuWVEwOWI2UHhRWVUxVVgwaE1OcFNzS3Z0UFNhanZ4dzFOVWM4dXFM?=
 =?utf-8?B?RzREaGpiR055aEl0MUxEbEw4ZmdpRGMzeTdVZ0tTY2lPOXNwTEwxOHo0Qiti?=
 =?utf-8?B?aEVRdm53ZzB6VDZTQjhQSFo3ZS9CMjF5MVZwRTFNZ3RsVnBpWlJEL0xGRHBi?=
 =?utf-8?B?ZWVWNE9nVEd3MC9ScWFETTR0QnU4NDJIR25rNjdmZXVQdzEralExeVBJMjVQ?=
 =?utf-8?B?M0tDV1VuNEUvRmlUVml2Uk1xaUdkdys4VHltUGN3RGhzdTVNd1dNK2JXRmpK?=
 =?utf-8?B?Z3lsbGZIT1o3Smp2OFArVDdCSzVRY2xIR1V1Yk1nTGEyWThIOVIrYnFGaFJZ?=
 =?utf-8?B?SEJoSTlDOVVwd3gzc0FQbEgrVUZvMWpPQ05paWRxa2Q1R0dZeExHU3lqUGVU?=
 =?utf-8?B?UmVGWEN4YS9nMlliWW9zNnYrRWJWRTRmS1JiYnArNTBtZ2JUMnZ1ZlNpUG1S?=
 =?utf-8?B?MUgzN2tJVDUyUFFzaTZKK3NFVyt6TkhiK3J3VXN2dURZWVU1VlpWdE9teEY5?=
 =?utf-8?B?dzhReHdPZU96T1YyU1JhczJqcEJwL0hXRXIrcFZaQjRMcXZyOEZCa2NkTkJr?=
 =?utf-8?B?ZEgrak41VEtXTjMwb2M5eFBMOVZ0VWhTRWpScjFrYm1Jb3lHT3BWUjRraGlN?=
 =?utf-8?B?ZnN4eG8vV05nQXUvblFQemVHek90T2syaVlqS09JSTNkd0hGY3h6RXF2S1g5?=
 =?utf-8?B?OHhHdnBaUTlWdXgxaGU0RE54U0dMYy9iK05rTnNNQmhmYWR3ZGcvTkZUSDds?=
 =?utf-8?B?RFI2UVkvVDdMQjVqTDZiWmVvWmVRQXlNdWtLd1FhVE8xWWVsWnVZT3I3cHgv?=
 =?utf-8?B?SGFNQ29LMW5yWWlabG1Cc05iVkpVT0hCZGtHSVBMajliemVHRzlQTXlJMzRP?=
 =?utf-8?B?dEx4ZVNQa281SXlpSEtVSHp5VTlqNERYN1hPcHhZcFV0SGVzYmlmZmExeG55?=
 =?utf-8?B?NC9pa0x6eGd4cENEUjF2TjUrS2wrMHFHaTJyK1BDN042Y1pSdEltN0RkOEhI?=
 =?utf-8?B?MGd6OHBwRENoY0l1UGZpa283aTNpNDQvVzNRdFFxazhEK1ZlRjR1SFE4blBo?=
 =?utf-8?Q?PVH7tbX4ypy1u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtTaWxHVWxVeUppQmxBY1FOTWEzMHlhSm5tL051UmxUTzJ3eWF4UmEzTmI1?=
 =?utf-8?B?cUNVcUpzSXNzVHB3eWkvNzF5c0JaTUM3aWZLdFpCYzhZK3IvUUVnLzF5ZXdD?=
 =?utf-8?B?ZWZrN0d4REZhUXJQMEZldGFNTDhwa1NzYnV4b2tYUjJOMTJBTHB0enlHT2xF?=
 =?utf-8?B?M21pZUR5SG9DYmpQQk5WWUlmSXVTdTE4Y2tZMzNFdnYxZlBPK3FZbldrUDNo?=
 =?utf-8?B?T1ZweG9TYVlYQTBnaEhDM09JQVdsRE9yQXdjWGZTMEZHQlNQdmxyVjZLMFVN?=
 =?utf-8?B?Z1Rjc0NUbldJUCtvVW43eHF0bW5uOVhQd21ZRVR1RU90VENWYUoraDl0TXV3?=
 =?utf-8?B?eVhDK2wwYjdWYkN6ZVVsYnFPL0ZIeWprclZoRGV1OHdxWGRHaW0vR2tvZFgz?=
 =?utf-8?B?R2crYmtqRUN5UUl5OHRhdVRrQ0FWb1pZakFBL2RwaTkvekxPU2NvR0ljNTl6?=
 =?utf-8?B?VEVtaklHZURkZnRPdldyNDBFbzBHMjF5cXYxVS9mTXYvV2dROE82aXV5cjUz?=
 =?utf-8?B?a3pQbFN4YjVyNjBlNEFlUFNXNFdIczZPOU9vYlJMU2FvYjdYcUFhWE1tRytt?=
 =?utf-8?B?RVFuYUwzVE03NVFLMHAxVi9HNXlrUW8ybnExRW9qU05ieDBGRHNzVlBsUmhX?=
 =?utf-8?B?ODUvSG5vTGQ3ZUp3Q3BNZWJnK0VzRmQvbWRHZ2ZiQmtVRVNHZnBMUjFIcHlw?=
 =?utf-8?B?aU0wVGtHRUM0amo3RFBhRFRnOWRHLzc2VVRzeVgyelF2K1k1R0JzaG54MHhO?=
 =?utf-8?B?Vld1YWIvMnlVVjhiN0phNCtTeEEwc1BZdTZubjJKc01TcWZXWU8vb2pFS21T?=
 =?utf-8?B?ekx6TlJ4NDhzTjJWMFF2ekozd1l4QmQ4NEp3L2VzeEVBREVZMzRoYklDTngz?=
 =?utf-8?B?QTUrS2JyclIzejI2WThlZjRSY1BlU2FQQUNsV0J5UGd2eERSTE1PKytuY2hz?=
 =?utf-8?B?eDBuUERSSkc3Mm45ZlFsa1AxOXdpK1kyNDM0REw5SHd3QmVpOUk2VXRwdHFz?=
 =?utf-8?B?TUN1eGlUMGN3aWhEZmlEK3ZHa05aS2ZmcWJzZWZWclA2OFpQVk4vQVNBVFo4?=
 =?utf-8?B?MTVaZWhWMEw2Z0JXL2ljNkRLSW1ZSUM0VWxnY0N4elU0VlQ3eGZab09abVJ2?=
 =?utf-8?B?VnhJMmpKc09VenAyanRIc0Z1T1RhbGk1WFFzRDMxbjdXSXo5Rm9yRWoxeWJv?=
 =?utf-8?B?RW5rdS9xZm5LS1NEY29HL0hLMjZpUUw3eUtHbTBOR2czdE5WVUR1ZWgrVEw3?=
 =?utf-8?B?Y3pRNFJVNUxTUFNmTkU2K1JiaCtjMVpJTWtsaVpMSkZRNWVwNE9zWnUvck9G?=
 =?utf-8?B?RFdubWVqb1pmQWswWXNlMFppZ0lXNGFDZDlmdEg4NWlmejJLcytZUlFzSUlx?=
 =?utf-8?B?VXQ1TWJ5NUJkRXc5Z3lBZXVvSU5mR0RhdTVZcytpRmp0VGZlbkpycDZYSXN4?=
 =?utf-8?B?czJvNmYwOWxVbEQycE1hOW44VW1hUno4RkFwVWVmbFUvQmQrYStUQTFqWHdT?=
 =?utf-8?B?TjBLTlVBNGtGN05aT1UySVNFdzlvRmIzRm1JZzFhaUE5NVV0d25zVVl2aWlV?=
 =?utf-8?B?MHc5amtlWi9BQ2RQbGFrWXJ2ZzBMWFRldmVnNUpmZDV6OXhlMGxiZEE1WHdO?=
 =?utf-8?B?cnZ6MEhteUh5aTJycXNFTGJxdURQbzlHY0NWZGpwNThhN28veHFNby95aHdR?=
 =?utf-8?B?eXFXQVZFZm1Oa2lZNlpKRFFtNlVTVU9LeUdZN0NCbUVSRHhjTUN2blE2NW9D?=
 =?utf-8?B?Mi81TnZsZEpkbktpMC85T2hQcWM0ZjlLOG1DdnQ0TVFEV3BOZUo5R0IxSC9v?=
 =?utf-8?B?ZEpEeUordVBVZDZwSHZhYkNjL21oNWpVNHdtK0Rja3A5K2lMRWdTeloxbVZH?=
 =?utf-8?B?cWRJYmlZK3l1UlRkTGV3N0RjVy80clFGa200S0l1bWMrdzJybElTdUU4anN6?=
 =?utf-8?B?cWlJYTJCQ21IWUVKU3pZZzk3VGZvQjEwSExnSVhRdnI2b3dqcjZSeDJVNVN6?=
 =?utf-8?B?VWtHbWJMUG82dFNJNXhIcHV2TzJFUHZvdzQvNVJvQWNaTDAvZUFiZ1FPTmxY?=
 =?utf-8?B?UXNLakNyZlBveUFpWlgwRWIyNmdxNTh6Y2FaWWdrdk5NNFB4RnRGYlVYU1Bs?=
 =?utf-8?B?L3MyZFpRa01SUjZwSFgyeElJZW0xOGhzSzluc2dmL3JURTJLcTU5Z3ZxdGFz?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgukNVDBbklNz5DH838iQy1x5/I+DS7DYL83E5okidI7aCtEd40xywiGCYpheQ8AiPl3W8q9McUyiOHMIY5VM+i7KaHRPo05BBkmqB5Ir0wcM+XXbAp2Pi0PcAUt8nyf/2Xl1RDNoEIcbHYec/wjxzqkxOiSBbAyDl0mF0/zVXgWj7eCMNm69vjgN3gYbZXJl0dwKPlWVDlovc87TXIhLZn81PCV4Vn/SBvlKCxbXZWu6qhQ6UuIhHZuhT5RjOTgvUOafH7lgpEJ1glHI67eVHDjvCo4AhgCbnsoI2E4LYLh0dj1PLlYx13bGzMEE296OFvNpJpiy5xzjE8BUfVOT87GnE0d+d1Jb0l1L7f5tg+hlaUPnmpUrEIxbWPgW+dmUdOKtd0HvBSL1FQSnbL/vhxxk63n/SuwCRHd7KA37OucsygrBMxwwMQ23iv9SuBaWeMiOgZxhrBDu4YMF7u5d7F+kND/qXb5q74SZdT4vFPdaM2uvbgS87WdkRXRoZVJy1i5mathFYlrcGtTWGlpVUzTd4vk1qE8aYWtAu7IIEl9lYe70GC6sNnfFke3Ku9yiJbfwSWZjfZSTUdfv1cGQFFZOR2jAnyMbzXqAxJ5rxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad9836-8e4c-40f4-bc1f-08dd558d73cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:13:38.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7htf1DlssPS5H/1s5axCyyoF11eTi9yeXvVHkwfELoMY5KQIj9lrFbBMYbPcjv/jV0PQUfagW2FHR8Cd74z1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250079
X-Proofpoint-GUID: VpPSkpsTQNxPfaGVLOtA6EpRVA5tC2xd
X-Proofpoint-ORIG-GUID: VpPSkpsTQNxPfaGVLOtA6EpRVA5tC2xd


>> @@ -22,5 +22,4 @@ extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
>>   void xfs_get_atomic_write_attr(struct xfs_inode *ip,
>>   		unsigned int *unit_min, unsigned int *unit_max);
>>   
>> -
> 
> No need to remove a blank line.


ok
> 
>>   #endif /* __XFS_IOPS_H__ */
>> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
>> index 477c5262cf91..af3ed135be4d 100644
>> --- a/fs/xfs/xfs_mount.c
>> +++ b/fs/xfs/xfs_mount.c
>> @@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
>>   	levels = max(levels, mp->m_rmap_maxlevels);
>>   	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>>   }
>> +static inline void
>> +xfs_compute_awu_max(
>> +	struct xfs_mount	*mp)
>> +{
>> +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
>> +	xfs_agblock_t		awu_max;
>> +
>> +	if (!xfs_has_reflink(mp)) {
>> +		mp->awu_max = 1;
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Find highest power-of-2 evenly divisible into agsize and which
>> +	 * also fits into an unsigned int field.
>> +	 */
>> +	awu_max = 1;
>> +	while (1) {
>> +		if (agsize % (awu_max * 2))
>> +			break;
>> +		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
>> +			break;
>> +		awu_max *= 2;
>> +	}
>> +	mp->awu_max = awu_max;
>> +}
>>   
>>   /* Compute maximum possible height for realtime btree types for this fs. */
>>   static inline void
>> @@ -736,6 +762,8 @@ xfs_mountfs(
>>   	xfs_agbtree_compute_maxlevels(mp);
>>   	xfs_rtbtree_compute_maxlevels(mp);
>>   
>> +	xfs_compute_awu_max(mp);
>> +
>>   	/*
>>   	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
>>   	 * is NOT aligned turn off m_dalign since allocator alignment is within
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index fbed172d6770..34286c87ac4a 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>>   	bool			m_fail_unmount;
>>   	bool			m_finobt_nores; /* no per-AG finobt resv. */
>>   	bool			m_update_sb;	/* sb needs update in mount */
>> +	xfs_extlen_t		awu_max;	/* max atomic write */
> 
> Might want to clarify that this is for the *data* device.

sure

> 
> 	/* max atomic write to datadev */
> 
> With those two things fixed,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

cheers

