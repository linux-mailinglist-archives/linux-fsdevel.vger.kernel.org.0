Return-Path: <linux-fsdevel+bounces-56049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23033B12301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C51CC02CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D92EFDA1;
	Fri, 25 Jul 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gr0Fv5QL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cc2F0HDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF12EF9DE;
	Fri, 25 Jul 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464555; cv=fail; b=P0JR5Mo8rrwjfkRD8HuBZ2ap+xvSWRTFz+xBJBM21AMjsvjqsuU4+2/ZAGXLuBua0JVn8yWsTYNXFNps1Io2gpNaQfFJ3fwu/xDhFoQtnfuU4SR/9cxu3qcn3qczQOonJSNL5QOu7B9kwA8Pu1o5XL78v7ilvlkaN6GUDcIaJBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464555; c=relaxed/simple;
	bh=J5Diljqog6M0o5iFGRxqDdCHRXUJvVN3pB+QrDNiays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d+kK/gyjOR+dE3PTZBhS66iKFYEmzDu50QzrSuk1xKaEAFGiye2GLg9eikFI2OYU8V1A4KrtcqDPWokKhqURw/MSaNKKkShonhkZuomvZBTrpjoxjEJzKwv1zojrt8k/0KejHW5FZfGiuhgxnK6TmseeL7hC1Mf2u9QVvDWFxxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gr0Fv5QL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cc2F0HDd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGCEFJ000828;
	Fri, 25 Jul 2025 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J5Diljqog6M0o5iFGRxqDdCHRXUJvVN3pB+QrDNiays=; b=
	gr0Fv5QLNY3nKONcx8FovbuInTM6q4Y+L0lHAeXYiwjzqN0cVWMsgi2pFfmVNclv
	/28cUzFYWvZjRPJhS3wraJHEP23tMryfLZ93b5CcBdkMGW2OB86m7kAfTcc1jQ/N
	Dsi9by02WKhSSdfFLlcEw4fIoQTXJT0NdesMGpWPep8BQvY18cvvgxOksvOLViW2
	EevPkPKI1WzWUi82hjgep/S+QotQXNcgXJcCPBLa8z6Qfc3BNconwF4DJzx7+wOG
	/y5qnswPDtWKp/xjpUZD4OGUONFLJ0sp1eXkU0RNzbEd6nmp/5hiFv+2Rtk1e2og
	7ecPvYoc4f/i1V3CBOW/8Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n1fq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:28:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PFv81L005816;
	Fri, 25 Jul 2025 17:28:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdap3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG2kFowcuCpeo0Mrb82NRzp1i9fkp3LnAwEvjLYeCXQeB1NuS04wGY32UgwXWmij+RTIxlovBGl0Se43CsQS23hZAhF9N1bABF+DcTSBBaxMEk31Ldqi3OTi0LEK5uwKeCaq5nm2PJPZMv3we/ynBf8lQbFZmpdVG7SINj9fnpLKDmSZsU9PqBB77KJdBisW7xK4EGR626Vou6EXz69WDNwNnvhvXQli5sNWt8l2XlRx7OWG0/VEYqe7ciDMJTZP1UUv+vbW6srqdUNHZ42vmrUxzn8HhUhQx0kzqpTbsQ/dyVcjwjtfwmvbV9auvMO8GIjUQfW/ejxqqCUOUh/PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5Diljqog6M0o5iFGRxqDdCHRXUJvVN3pB+QrDNiays=;
 b=nlYdZ2ArUNQmSqACa1Qvn3Sl/c4YBHhucjMCfSh26SiWaNP23ScnOP8FM9daO8AmB/vP6EdBocvciXwpra0Nd/v2Vg3paQCuylPBENJr6IAm6kwRa5ioqtnPiCciE7OrYTfU/wU9L9vGk/X7OAHFdKfSee/bubtal6bQahzWQu4fMxuoqalf4k4vX9jYXSnRF1T7ddzTkSGi1CBEdfxVmKLzpBil4j8OU64S+7YPvt8Vbgs5Ss1RvHefiFlfh0vV22JvnKHfyhococv7/u527j2gGS6nuFMP4Aiv3g2OLtdQ068f9gDefvG6c2kJd6aG6Ylu/d8NWEvy+XWdjbhakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Diljqog6M0o5iFGRxqDdCHRXUJvVN3pB+QrDNiays=;
 b=cc2F0HDd+fdWiBS/BQ52AncjXqtGs0DXXBiyy1kPm6SLy5FUVDgV0nwkFWLQsluKpYqQrTEMhzkV905MFsb0JzgmGO0R1besktxw9i/Shh4xV6ToVs7GtoBytukm95LFdAgqaHgcdZKmlfvbbUezfrQWk+P9aGbLY1xGkXY1vxU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8181.namprd10.prod.outlook.com (2603:10b6:806:43b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 17:28:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 17:28:01 +0000
Date: Fri, 25 Jul 2025 18:27:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf58765-595f-4462-fc08-08ddcba09adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWlzdnFSMCtLSlpHczl5VFF2R3RJeFBtUnh6UG4rYWk0cEdoT2hhRFd6THpM?=
 =?utf-8?B?N2laeC9zUVBtckRrcGNIbFMvS0NHVWJydE8vRUZSZEV3NitobFl2SUlkWGxQ?=
 =?utf-8?B?aWdxWDhsSGVIWlhhTXN0ZzIzUkswSHhQN1VhTThxUWhpQzNCaDRsWTZpbklQ?=
 =?utf-8?B?U0pYWWtzcndNVlZ2Z09ySlFSdlZTaVEycEo0RnYwREE2R0dMSmM3Wk1LNksz?=
 =?utf-8?B?OE1IeUpNWTB0OFBScDJEa1dKK2FwQUhJYnBiTnhlbnROWFFRcjFaczR3TjZi?=
 =?utf-8?B?cStLaXNsTHZDRmJGWmY0ak5HS3VpRjZuVDllQllLbTBvVC9jQUk1RnYrUUVK?=
 =?utf-8?B?RnlsVjBTQWJvT2pkTjFHRzZ3bWx6SHZvSEMrTnV5V2ZJUWMrOVd2WVpTQkJX?=
 =?utf-8?B?OVBDNHZIeHJVaERMSE9TK21GSXNrK0N5RE5DUFI1V1QrVENqSGl0Y1VKek5K?=
 =?utf-8?B?VnVHREI1WVIzMkpBckVvOVhwcHRsc3lVTUh2bGZadEtJdWtBcU9FNEpTSGV6?=
 =?utf-8?B?Ukl3b0lyd3dFR2VPOWVEQjFZUmVmYndjZXY3MzZ0b1ZKY20vNTdtbDVTY2I1?=
 =?utf-8?B?TmVNOUFaUW9LZVJUYjdMWUJPTGZOSVBaVENNOTREbzNvYVVVZHFvZkZRdllJ?=
 =?utf-8?B?T3U5RjFocGM1VjBnUGRNencwdU1sT0kwUDY4Mjd0d09WN1ZOb3hyeHJZZWZE?=
 =?utf-8?B?bTkvRHdVRVB4OFZFTkczUkJiYkZoeFR2YnU2NUpMQ0RxVXhKL3pxbU5sKzFr?=
 =?utf-8?B?aUF0UE8zM3lkVmFlT0dJU09kV1lGMnRObVQ1Y0pwTDdUejNXbnNPU2ZCelhB?=
 =?utf-8?B?eSt1ZkVmbFg0Vzc4UDBhU0xpcHlqZGtqL2kyL3BORGpkRXo5MHFHMUxKYVZQ?=
 =?utf-8?B?cWg1ckN0R1Fza3JiM2Rvd0hILzZic1N1TTVvTFBqZEZMV3dmcEZpL1VqbVY3?=
 =?utf-8?B?SS9uYjRDVUtvcW0vTVhkaDJaZTJ4K3ZzT3lRMThFSXV3Qjg1YmovMFZXekZj?=
 =?utf-8?B?UWszeW1EL0w4dUY4QTBpRDQ1cUxNUVh2REp3clNpYUlPZE5hN2E5STVjM1NO?=
 =?utf-8?B?OU9qY1VjMTYwYkk2Vm1jRmJoUEg0STBLdXU1TnAvbm1Bd29haWZZc1lhSW5J?=
 =?utf-8?B?d3lmMnEzcVhUcDZvWCtaa2NSMGZNVnR4cFpPT2Q5NjMzTm5jR2dyQ0xCVFpo?=
 =?utf-8?B?bEVwUWRiblg0aGZUT3pZT2NpY2FlbFhTWElmWFEwdG9tYjAyMTZBTjd2Qm9W?=
 =?utf-8?B?amk4VDRNRi9CaWtzbmZ2UkxZT3pERXlkRmM4YVgyQUhaYXJmUnNHOGtNaTQy?=
 =?utf-8?B?MWNmYW9MM2l1angzTC9BZm9KbUlucTU3dHhmNStyZHhiVlhYRE1sQTloVUZK?=
 =?utf-8?B?Q2ZSTWhOc3N2OXRtNWZUUWEwckV4ZXFWTFJQdStiYkJ5WXh1RXNqUnZINFhF?=
 =?utf-8?B?VFd0d0hUWGtFbzZ2M0oyMEtKWUJMZ3Q2OWI3b0ErYXEyUW1qbXpoSlRNbEl2?=
 =?utf-8?B?TXV2NjV5eUlyV3JvaWRmbXVCRXVveXNoeHI1WFBrcHNCeUExK3NNYm9oTFpk?=
 =?utf-8?B?dzdoV0xKSXZLazhJQkUwRG4ydENTd0R1Um5oRVQxT1VhZFhtTG0wSWg2anNJ?=
 =?utf-8?B?c05UZjN1TWNEUnl5OGk4MS9BZnRiK2p0YjRmZVdJeDc2TVlva2ppU1dhcDR6?=
 =?utf-8?B?Y0lhajVSRWRSK0paUlBPdDYwamlZNHJ5a2poQlA0SFBBZnJKOE1DVmtVWEFY?=
 =?utf-8?B?VzZtMlVSSkEvbE9XUjQ0cTRZL0hoMGJtZjN5QkRPV3U1RHZYVW5yVGtXaitx?=
 =?utf-8?B?bjQrMVVRQ0RhVE1pTEpIdlM4VUdrU3dMM1AyT09KcjlsOVVIdEZCb3lMSytB?=
 =?utf-8?B?bjJ2QWRScE53T3g3bGc4d1BhbXI5NFJmMisvU2dnekNERDJtZlFiMi9yT3A2?=
 =?utf-8?Q?KHEWtX5iv5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE9NS3h4MUx5QWk1ZElneUZjWDlrYkgxTEs1RTFBR3lPbUN6eWpYZm9qL3N5?=
 =?utf-8?B?cWdnRnpiOXlwOEQrYStaWUJXcDJxY3NrREo5cFI3SVBZVUhqZHhUb3M3TVlh?=
 =?utf-8?B?MXp4d2VEVkZlNWlFZDJGWWxqVjRxS1o5TUEybVNoK1RTaGJBU3BEZUptbHZk?=
 =?utf-8?B?b3FMbjdWeHQyK2lSd2JUTldTZFA2ZlVsWTFsQUl1Q0tLQVBGSmhCT3hxLzVP?=
 =?utf-8?B?M1lNRkwxWm1SVzF1RncvVFpWNGhFNTkxaHlCVGVZQ2N6Y2NIUGtXQTdTUWtP?=
 =?utf-8?B?TzZNV2JlOVRVNTJ4NjhsZFgyWndHZi9mZnFXcW1ueFBqUkFwTTFiMXpha3NG?=
 =?utf-8?B?ZG1hNVhyRCs1OFNZZjVPV0JkTkxyaVhVeHV2azJsV2VDTXdlMld3ZTZNeGpH?=
 =?utf-8?B?RG9PZld5bStlNnRoQk5mMHlOTnJTZzdjampTRjk3dlpZZTdyS2FDbjBiWnND?=
 =?utf-8?B?MmkzTEp3clIxY1FQSWhjcjVCWTBKc21ZNFpLamYrZGJrYURDOUpiSmduRllp?=
 =?utf-8?B?NXNpNTFvSThwRVhYV29BRkFhVjhvOHRtbWwxNFpNNVJSNjdJWVRab08zN1NG?=
 =?utf-8?B?VUF0NzRWUmFyTTRBdEhSSUs1aGxwRzBmYWlDam1ucklhcXRTTjhMZkJmREhV?=
 =?utf-8?B?Z044V0hnUXhLRThPcUdJNlNPaVpFVWY2NWtlUDlVajdzQXN6ZmZWcFRWMGhQ?=
 =?utf-8?B?Vll4TUtJUEowSUF4bG1xNVVwZWx0c09nT29yUTc1Nk9KdElnNzRMMGpvNkJt?=
 =?utf-8?B?eHJ1SGduVmpxNkMxN2dZOVFsODRseXh2Q0YzRTJoUjNMcTcweUxnWkhlZFRV?=
 =?utf-8?B?V2JwbkN2YkdCQm51RVpVeFJSUFRpanIxZnhMeVd4akU0NG9BY0NidU1IM3E1?=
 =?utf-8?B?NndEZ2l4THREVks3a1pKRDhvdGp4UmwzNG0wcGFaYW9zdm9zaUJTOWtzNFg0?=
 =?utf-8?B?bVM1emVpK2ZoQ2VpeUF6bWVGNkluelE4WUVRdEhKSDgyRGw4WVBTOHV1OXZa?=
 =?utf-8?B?U2VYZ1Y3VCtZL0N0VmdZa1FRd2hFM3hLVElrYytOVEg0R0IvNG85N1ZnZzJ6?=
 =?utf-8?B?RFVVWnhpd3RuMkkyQ3ZUWHErMjZEZUdjWlY5UnhxSWN3cFlGdC9IVmdtOGJo?=
 =?utf-8?B?SmZnNVhjNEE4ekJTR1J0SVpoK041LzRqN0lIVUdIQVA3MDVVaUNOOEphb1FG?=
 =?utf-8?B?REZ3SzNNWWtISTFNZTVmY3ZvVEF6NmV5T3o5SlJhWnF4eEhjOERpU0IrbEhv?=
 =?utf-8?B?eWFPZkdRNlUyNlFmMFZmc0FnQXJlSUV1WDJTbzArM2taN0hLd280R0JKdnVC?=
 =?utf-8?B?Q3M2akZ6TkRydnlUc2lnMlkzQUJHVzB3TFFlZVZ2ZTNpYjFmSnR6VWFDczVj?=
 =?utf-8?B?bTZCanpqdW9RYlI1ZEJreVFjNmREZFJnZERjazQxNlNwZGFlV0FZd3lCZnNB?=
 =?utf-8?B?RERFUloyWGtRYlVrYk9wZUxrUGRkYnpYZmxEaCtCbkh3SnFEbGVzOEVsN2t6?=
 =?utf-8?B?bmtOUVNWUk9RamlHUmtXWWZrdjRnejVwTXpjUThlN1FDTS94K2JIVFFCT2ZQ?=
 =?utf-8?B?OVNGTHVybFRkUkFncVZ0MUhWUm45RDFia3hjbmQwU002cnk0cVNaR2padmsy?=
 =?utf-8?B?TitEVFgzd2M5UVVOU2tBOUEyVWc4aXBFbkJ3eTVzYWJrRU9odmxEU2RlZk0v?=
 =?utf-8?B?WkZNY2xIZGNYQ2I4VlNWVzE2a3lEc0FVa0h6cXJqNnVQY1RWSXpRN3dLUGk3?=
 =?utf-8?B?MUcxSStCZjM3YnFjMzNFSVo3L1Z1bFB1VDNSMDJ5ekh1ZFg1d0tpVzhmMjk1?=
 =?utf-8?B?Yk5rT2JiaWhlcFJ4NGdBV0p6eks1RXlsWVo0YUJNKzVJKzZLZm9wN3hBeVY0?=
 =?utf-8?B?RjhDbFFwWWhUVnpyYklXVTVZQzVFRVkrS0lGSUU5cFZQbHF3SFpzS2orV0Zr?=
 =?utf-8?B?L0RZZ0lrVFo0N2o5cXgyMDhVR0F6eENrM0ZGMVkwWEJ0eHI0SFM3VlZjajBi?=
 =?utf-8?B?MEg2K1FFc29saWVsellmSFcrOUZmQThTUWh0eWgxcTYvRXBmWFN2VzBRajB0?=
 =?utf-8?B?elpGTGJFLzBPbUJsRW9jUXJ6YmpWTml5L0hNM0tXbW1oY2VSZU9sYk53bzZM?=
 =?utf-8?B?a1JCalNCKzlCQXFJRCtOa1RhNmd0bHNlbzVGVG1VUlBhaFZlVWpWWTZiOVVB?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8iAC4OaNM/p/QdH5cCmoWGI5QeIcN1h+939gepAVQyLWmln0tLbIO2kAnG9UUkV0lsA8h+Jo9nwki0I38uFT29OJLrqFy8n5lx236n4//gpTqckzhBKAz8hNTch81tYtSIwmLbuMOYEOfVFVo5o0p/A7zNXCCbjpnYV7WeGvitnyyqeXlZYpB5hmee4yjBB+8L2o8+VjrqA+lDOstodUn1sSXrxD8sE0VyYRWEYMrFuKQUrZupRBsfm/F92FJTaStHe0Ryatwgmz+RiFm5BfsFy56UgymciAcPr2/K4dk9ZyjRdgb8+yHAFxiwt6AXQKY2IxqSFfhsvUOhSri4RpWZKjfqv6zSHE+W2yPYRWnTwuQ6irL1SNIK+TkG9fFfko3SfUsBL8tN0Tdy57e23AJCVKQg1MPqhx06P7TSAO24h25PurdUWGzn+dtUBD8M02oddIg4ZJ3toV93Cad6GznV9KF+hY7w3k3HxQp/xObsVVPaABqghpgyNCj7tE+Sav7/woHKOPOwextvRf4uaEr/pWfhHQqwNJd83wB4hEHXbmUSUS+UPW5lNt6f2YbVBulnuzm/7cPMu7ieJdngdHpLpYXOIAYwg6kKZpefx4nd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf58765-595f-4462-fc08-08ddcba09adb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 17:28:01.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT/DTpzCikbdClxy+RZ1I7QYC0UTVcKuvwln1mJHhWcMaaCLCBZ8aRquUulzPFsIUtBbnljsuj155PlKa4NN/bMbsnhrDxkZiuzrTCpiCK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250150
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=6883bec1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=cR9L8hly8qf-kSrFWCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WCSSViBa_uSjskv_LadMpdVjF3uJ0Ly1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE0OSBTYWx0ZWRfX5tOqnG2O+3Nw
 zIMNMf1UQUXYqbuhfLvCk6MbiatkqD+I65OmHNX7OaQWxCX8RCmegw5E9JhEyZL40sCQYUsGH5M
 UYdrPqVYb3YTMKwMK4s+pb8iCe5K80zqKJnDya4i4SFIZ7rtQcEpnG9hi3PMz/H9wqLRPChi4CH
 qD7r8ZF+5VsOLLAMf5Ryy9uOCXam0PPF5Uo1Ymp0ikKS4OTQTsiNAYSIkEdSZhbgBkiBugL3BTo
 HqKhjMKNTCsngKUBJIM4Nb3cxQnv3Kc2E51LsPdVxKbX3sTdTW0VWywjQlzyZaa4LYTAo9IO7Ky
 6Q1PWak4zUJuS/ZE0LmyI3s5Fu6cgYsnuS8YgLPmS0n0LMUowNk8Mfg8/t2gSotwIhwUpilgujJ
 l9Z3nF/1m8ieVv4AC8v1QegfDg8e44ie48NUdXO1YtTlfdDY9kz4rC42Tx3mwDiPUI+532Ey
X-Proofpoint-ORIG-GUID: WCSSViBa_uSjskv_LadMpdVjF3uJ0Ly1

On Fri, Jul 25, 2025 at 07:11:49PM +0200, Jann Horn wrote:
> On Fri, Jul 11, 2025 at 1:38 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Note that any failures encountered will result in a partial move. Since an
> > mremap() can fail at any time, this might result in only some of the VMAs
> > being moved.
> >
> > Note that failures are very rare and typically require an out of a memory
> > condition or a mapping limit condition to be hit, assuming the VMAs being
> > moved are valid.
>
> Hrm. So if userspace tries to move a series of VMAs with mremap(), and
> the operation fails, and userspace assumes the old syscall semantics,
> userspace could assume that its memory is still at the old address,
> when that's actually not true; and if userspace tries to access it
> there, userspace UAF happens?

At 6pm on the last day of the cycle? :) dude :) this long week gets ever
longer...

I doubt any logic like this really exists, since mremap() is actually quite hard
to fail, and it'll likely be a mapping limit or oom issue (the latter being 'too
small to fail' so would mean your system is about to die anyway).

So it'd be very strange to then rely on that.

And the _usual_ sensible reasons why this might fail, would likely fail for
the first mapping (mapping limit, you'd probably hit it only on that one,
etc.)

The _unusual_ errors are typically user errors - you try to use with uffd
mappings, etc. well then that's not a functional program and we don't need
to worry.

And I sent a manpage change which very explicitly describes this behaviour.

In any case there is simply _no way_ to not do this.

If the failure's because of oom, we're screwed anyway and user segfault is
inevitable, we'll get into a pickle trying to move back.

Otherwise for mapping limit we likely hit it right away. I moved all the
checks up front for standard VMA/param errors.

The other kinds of errors would require you to try to move normal VMAs
right next to driver VMAs or a mix of uffd and not uffd VMAs or something
that'll be your fault.

So basically it'll nearly never happen, and it doesn't make much sense for
code to rely on this failing.

>
> If we were explicitly killing the userspace process on this error
> path, that'd be fine; but since we're just returning an error, we're
> kind of making userspace believe that the move hasn't happened? (You
> might notice that I'm generally in favor of killing userspace
> processes when userspace does sufficiently weird things.)

Well if we get them to segfault... :P

I think it's userspace's fault if they try to 'recover' based on shakey
assumptions.

>
> I guess it's not going to happen particularly often since mremap()
> with MREMAP_FIXED is a weirdly specific operation in the first place;
> normal users of mremap() (like libc's realloc()) wouldn't have a
> reason to use it...

Yes, and you would have to be using it such a way that things would have
broken before for very specific reasons.

I think the only truly viable 'if this fails assume still in place' might
very well be if the VMAs happened to be fragmented, which obviously this
now changes :)

So I don't think there's an issue here. Additionally it's very much 'the
kernel way' that partially failed aggregate operations don't unwind.

The key thing about mremap is that each individual move will be unwound
such that page tables remain valid...

