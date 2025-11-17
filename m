Return-Path: <linux-fsdevel+bounces-68780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C23C6605E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A171346EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575493148BC;
	Mon, 17 Nov 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aq7VmP9i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z6G9JJ2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B02FB602;
	Mon, 17 Nov 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409009; cv=fail; b=EUy0OCKPUXGiNqY/RYPgXm6P4m6UGCCqS5XEvPcJfiDVSCBs0fB3BFmvlL0We12nZhuEF2YTr5dJXCJ6SvSNPt8UFqGnQtpq3pNkxjjHiVJ4D6n+8EK0so+xi3hLfskEA6+PUFO59fY0rqxcFBdT1XUQ59J0CJNXdvv9WrAgxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409009; c=relaxed/simple;
	bh=tIkrhK6wGLwBN668NAZ1HnrLSVAWbiKTFWoy2YrWe2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r3heeUbj87qnoIC9FyH4xYqY2zWMHAniOUEJeKk/stxXzk4Ilcf6/5joMNlWZaMwWF54mQmDNubbQ4qsEp8jcTKp8QRr+dwnpekpYIcMkOO+OVTQtzhf7QBnMEUTKJAQVOrNzavX9hGLeOAoI2g7YPYy/UYuyzpXQLI4ZG2fnFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aq7VmP9i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z6G9JJ2G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8JBL024546;
	Mon, 17 Nov 2025 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rIImCmODrQyTqKg2rjrHNvpkSdXNn9lEbd64RGPsJj4=; b=
	aq7VmP9iBJMoHv9NuQfSQlvULvmsANVII3E0qF4KOr7mbkdlJdTVjuwVDcVDsved
	EKMAgjean8WXZysb+WNbY9Reh07fKs4DfqcLSwRHoaaFLUARWrKgMbNzOmX0K7Rz
	d/dNsXODzQRvG2YqcEwAJ016w1lYKn4rXQri4RXljSGJ5jMzG/S61MYxlui2+mvi
	d6xNqp+BbNA3CJkx30KOxlbV4FiKKWTCumB2f0WOwzF2zU+brIvFnkRhby0EYQnH
	rs9TPgQQHXOEy6cjvpQdtJoCZhQ5DB23xbRMTG7sAHj9PzPDeTz+9Z1x6KWPLAOq
	+bnyGSZ3l66qlXDqhxHR9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbbb06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:49:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHIZEJj009447;
	Mon, 17 Nov 2025 19:49:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc5va9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIxoJlB0oSVYGK/CvK2ronXA+0ICOKwPoXbhcbripOHRKkowVsZr72TqVUAad3lu/dYmcrC+68Q8sLrY76I9gW85mQrYjZ7lTD+moG93AW8mQMU97dACxMre3VcCkm4A9Zkgp9sjH/SaORIlsfF9QVGVSNf47uHRwqocOC1wxWnOLBDQWW42XU6hK1Wo0aDavvIC443Fwq6jGoplQd3CpTaqORqC5SxVqDbWQlKVkqHcTxFg6Te9tqQbgTAJkq0XEB+oA7TpqZoQgbTgUR4EeXjO6TKrUFxoO88y3Lp3P73Jb3p2KY1DN4YEZXcwHNm6xWo47WkZ6ZCV9GSULdiTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIImCmODrQyTqKg2rjrHNvpkSdXNn9lEbd64RGPsJj4=;
 b=tMlr8O5SNCkqKKVkyyXY5QiA1wDwrG5aEW80VpUScDzxaXFjan9mMjSfpEuQWn6L2POUBqit2JgMyhiYT1WnzYs6ncj5L6iS3uhseXGvJJ1mtaO99387EnRxBR12dNU3RVJnYm+VcMr7M3JDHeg2Vl3WwHzvO54+lomQNjyPhjzJRINyni8AMWqJrSmJcczxazVbCNerKf73zHhpNhDQYY8HQTtfm3WyHDYMi9H+WT5xIU/30+WoGd5SZEa5Rr0OQQx/h5H8FBXpQS09nY86fxbVXPmDVoSVgAruSAWFdCpiotq3vEWTs0wVy8IOwfQ3aWc3zO8ZE1OAbN0hq+2Kkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIImCmODrQyTqKg2rjrHNvpkSdXNn9lEbd64RGPsJj4=;
 b=z6G9JJ2G8sqG5EG/6oNfS6JPPQK7jurmqqqzqqtEVL+S+PnSnaEbzBfeKqn+ghIm/kcIEai3u2a2e4wc0CwM4CKTSntQK6vOrAqQWolhTGi5u6Ah5/V+2vkEslswAwlaoWXcYUL+1aRiUKmWgnxfHx8sy6uxOxAtf1mWj1hqzTI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 19:49:41 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:49:41 +0000
Message-ID: <0c8e2b9a-0db1-4a3d-a15f-7f5b0ed12d51@oracle.com>
Date: Mon, 17 Nov 2025 11:49:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] locks: Threads with layout conflict must wait
 until client was fenced.
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-3-dai.ngo@oracle.com>
 <5d19304ea493177c35d0ce13abe6dbf358240fa1.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5d19304ea493177c35d0ce13abe6dbf358240fa1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS7PR10MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: 761d32d5-3f2a-407c-cda3-08de26127309
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bWFiVGVkZnNLUU5kMys2WTlVWlJUeDdzTjZ4bXBPamRPWUwwM2tmSVNiRDlQ?=
 =?utf-8?B?MHh6VzE2VTIzckpVUXZpbHhub2ttWUpZV253SGgwUlcwMkxISVhrNks1S3Fi?=
 =?utf-8?B?NEdWK1F5akNjRlM1SnRFQWoxUk9qbEJCOVdDd2luMGFnWUFxVmZreHkwSm9m?=
 =?utf-8?B?aE1tTy9oYnNvYzhzTkhJa0o5aHZJbXRCenRFVXIyVFc4NS9IVWZLbmZSdlVv?=
 =?utf-8?B?QWMrN21jb0lhWFZETE5jeFNBZjRLQk1kbHVMUmxIVVpUZmdGd2pjdjZzeVEx?=
 =?utf-8?B?K1FiR281elFDSFFYMFU2MXdldTFTRGxlbkxhT2wzWW00S1NHUnFzbTBEcm54?=
 =?utf-8?B?Q2RCWU5SejE2Y3IxcGVoemRLNllva2IxY3BEUE8xUi9ldExVL0o4ZWg2bFNC?=
 =?utf-8?B?TzdsSmV2VzFnWm9iL3Q0SEFIbEFhV3d5VThBTlpZRi9GOVg0M0w3T2lJZGdk?=
 =?utf-8?B?OS9qSnpDTVZ6WFRrVWpBQ2pYbzdvbWxCUzF6a2JndFYxWTFBMVQxTnduZTJl?=
 =?utf-8?B?M05vbHpXZmxKTnY4TmVQV044UCswbE1KSTFMQ3FzNzFOMEo1cmx0cFBZeWtm?=
 =?utf-8?B?SEFlN2RuWG9DMlpBUFc2OXY0UVpLWXlDNzFZdld3YWhLbVk2WUlIOEN6SjdE?=
 =?utf-8?B?VHlndXJWVFdCSWlIKzV2S1ovcWlpbC81eUVoOFV2aE94aVArTG4yY3N1MFhr?=
 =?utf-8?B?SDRxZCttOXVVZDcxa1dmN1RKcDl1YmVYRW9lUVZpQzlna2xxSm1WdzJQOGg5?=
 =?utf-8?B?ZVRpMGh6amxJbG10U1lJQlVjRDJHUTV2QjU1YXg5NkpwaCtMZkVBUGtDMjNG?=
 =?utf-8?B?OElieDhNRkZxQUsxbjdpNExaQy8rQVBZQXM2S3NSZ3FMbDlTY2tCSmV2cXY1?=
 =?utf-8?B?bjVyN0FGelk1RmF0SmNHaklHNDdQdmlJZm5SajRmelVTWUVsM0FUTDdZY0lq?=
 =?utf-8?B?RStyQVVjZFQrQ0NEcCtqT1F3cm8xMFNaRGdldWpvUXFNYW4rZTIxRENNKzRT?=
 =?utf-8?B?Y2h4Z1JUSXAzaUVvaVdmQk5WaTZsbkdLdjMrWG04VXRFZnNGdjdER3B5RVJT?=
 =?utf-8?B?Yi9vT0pySEU4WGpFRUViOWNUSHNibng0ZlJmYWRRQnZ1SDdOUkp2WWpITWM1?=
 =?utf-8?B?Z1FwMmlKRG11OTd5R1c4TDA5K0UyWG9Wczl6anBSbCtUTFEyZWRkaVQyYVlM?=
 =?utf-8?B?c20yeElDYTVFL1lIcURjWGhFazNySHVkdWl5M1VLWXdnSklTRWlBOXp0RjNE?=
 =?utf-8?B?Mm1ocGkwM1VPWTI5WWtmSWZ0emJON0JxV2xhNlczWFdPbm4yZmhaazB1bDlv?=
 =?utf-8?B?aHB2bVlCQjdPVmVzc3pVcUpVbVZWYnZ1VEUzYzIzYkVoZ2dZck1ydklkTkhl?=
 =?utf-8?B?dUFVZnBQTHZqbmM3OXBwaDVQd2doU011SlJVZ3p4SjJNZXpmNzhpdVBpdFQ1?=
 =?utf-8?B?ZTh3OEFZUDB6WFpaNnBrQ3NOYlNJWk85K2pGUjdJbmZNbDVVekZ4SFpnTkc3?=
 =?utf-8?B?RGdqamJ6N3Vhci9QM1hWV0RDQm1VdU5iQzNtR0NJZHA3Z2RBUVo1b1NwUHJY?=
 =?utf-8?B?M3h5OWlwZGhVZDgwMnNLSGtMZ3R6NEVIMUp4SHQ3OE9jU3o2UmJFQUdYSXRY?=
 =?utf-8?B?end4ejVNUlc3Q0grcG1iUisxR3lmZTM1M3FPQ0twanJCaHRFZERrWkoreDdB?=
 =?utf-8?B?MmxLQ0U3NWx3YUM0b2NtZ3U3ZStTVkdVNVQxZHBZSkFvWGNTS3F5b3RCZkJN?=
 =?utf-8?B?RFpxaGdjVkptNS9yQjBWVnpGR1ZwdG92UEw3V0RzK3hPbU5Ic0ZYNHZPb3Rk?=
 =?utf-8?B?Ty9paDZqOFByQjZwQld6dnFNck82Um5zVTdqUGttQTBnVmpYb0h3czJpWm1n?=
 =?utf-8?B?NUFxcm9sN1JMcGlWejBvdEl6dGRzbnQ5bzZ3RGxtR2hPK04yWTlSNk1Ncjhw?=
 =?utf-8?B?cWxqbnhnT2ZwekdFUjlZSllWRTNBT0pRdEhuL3NSYzgyM2h1Rk54UmhNZUVN?=
 =?utf-8?Q?n6I+tneA3ffct8dDGH/Py6ktU96WFk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U29YVTM1aE1wOHptMFI3MXloR05aYXdwbVJtanVjSmpYNG4rekRLQ0xNcTk1?=
 =?utf-8?B?dU1nbE5FYUhKZGNiK2dHbVVSWkQrald2RFBQUjNSbXdUUkFBSFA0MXFSRlJq?=
 =?utf-8?B?eE1za0V5WVFiaURjdzJ3UmxObW5INTNOdkw1L0hQMEFCRk1DdXRmTUhpc1ZN?=
 =?utf-8?B?ZGhOd3JuU2V3b3ptMjJqSmtBa2RNQko0ZW5nQ3JleU5QUDdUWE9zanBUNWlD?=
 =?utf-8?B?WDFMR3FEQ2V5ZVYvVlNKZHc4bEhUYzhySitITyt3Uyt3dUFSUmNFQ3habUx4?=
 =?utf-8?B?L2xIZXUzbHZIVElxTkdOZ29TTlBWanNuUEVjamZGLzIxdzB5UWU4NnN0Y1BH?=
 =?utf-8?B?a25NQ05lV2RjWVhZMDNZZ1E3NjZITWlScmlHVXplKzlXc1k0eTVYQU5TbG1G?=
 =?utf-8?B?eCtlZmdXelJpZ0VIbjBFK3ZiV2tNeTN5Qy9YV1ozUWh4N0tLUVllSzMvSkpz?=
 =?utf-8?B?ajNLSW84WmlGNXNqcGpQb1NnWVFXbHlHdENQSExEWWxCVmtKNzMrR1oxdFZY?=
 =?utf-8?B?MDRTZ0MwSGU4aEpkbE1zVmNMS1Y5cWpEbVFiNXhLbm1RdUVYVVQyS3BMVzlw?=
 =?utf-8?B?TUI2bkZ2cjRRUVBCRTJCY1RQS3N3NlphZ1VQOFI5ekZwbVo1ZXhxb3BwNm4y?=
 =?utf-8?B?NmphQUhkeXRBVjBRam9Hb0NIakVOVzM3cXRzZVFORGZMaExDZTQyRmxOUHhB?=
 =?utf-8?B?Qi9aR0IwNkZYMlJlUUFFQ2hqQVJhMy8vY1crMXJxN3lvVU9ySmJ5SjBmYzVD?=
 =?utf-8?B?Q09kYlRnZnB5L2JrRVJoN0J3QWlLMGR1UmxEMmQzTHpGTVRtSUVhcjJaamgx?=
 =?utf-8?B?YWtISzcrU1JaZVE4M0VZcGtwTXNsdWlDUGhyUTB4cVdNZ3N5bEpPZ3JNNm5J?=
 =?utf-8?B?RHRrQWtMRnlZQWV5R3VWQzRZVEUybVhhOCsrNXUwajB3c3owM3pRejFnOUsx?=
 =?utf-8?B?ZXoyL1cxWWVxK2Y3cmp0cmtCQm1waHk1NE56SU1oMmNXdTdUMXRLaVZud1dp?=
 =?utf-8?B?UGsxblhDdEpRNUpBMU4rVHBTNm50VjE1dW44clZoTWVNSzYvaFBVUkw5Vnpq?=
 =?utf-8?B?NWljem5Ua1RoVkNPaG10Ny9YREpQY3EwUE9nSFVqQWNBQ2M4bzVHbUszT0s2?=
 =?utf-8?B?Y0tITWlxaVF1YXBKOWpDaEFQemJZOU1vQ3NGcXJLaXpWbGJvdVNHWFYxbVl1?=
 =?utf-8?B?U3FDaTdTdWZDOGphUHArVit0WDBPTlVDVmtGaEN5UmNpMldHb29TZSt3T1pV?=
 =?utf-8?B?eXhRUUVsNWdjWmpiREIwa3JYYWgwV1NLTWx2NHhWK0ZYcDNxK3NabG9jVjhk?=
 =?utf-8?B?cy9GdGhSbnhZS2RaVWJEWjEyaVBtUlZKSmszdXZGYnZ5UksvdzFJTGlIWXp2?=
 =?utf-8?B?dWR4WGlkeGlDcWxEMW5NbU0zK2RJQk0vK1NIaVZzRFJDTHByWEYrc1RRbVRl?=
 =?utf-8?B?bnh5QjFzamdicHB3S0dQaERobGtFeGN3YjJxT1RkdVBXSHNSeFZoN21qQld4?=
 =?utf-8?B?bDU3NEdmYnZCSjNVZFVzcy9TeUtwN0t6MVZBbko4ODFGaTFscjFubEJXU3hh?=
 =?utf-8?B?WnpTakZZbFNvUEM1NElMRld3NHZHeVhEdXVYa2ZWSU5rU3lTNlpYSGwrOHpu?=
 =?utf-8?B?NHY3eVVHTk5xbEhyeW5xdkVPQ0dHdWF5TWlaaWpGL0hmVEJJbC9CdnRUM3ll?=
 =?utf-8?B?LzB4ajZIZTExUkZUSmEzZS9hQXN4empRT2VSYVo0T0lMcTRiWVJKK1VPYVpy?=
 =?utf-8?B?MlB3Y053RDFZUTI2Ukp0ZjlrNmRiREkwN2I2emZ4UFNab1Q4d3dwUHdjNTE3?=
 =?utf-8?B?V01EVjBTRCttckUrbmdjckhZd25acWVsczFZUHdxb0ZaZ2g3NWppbnhmemE1?=
 =?utf-8?B?K0x6TldWUWdmQWpSL1VrRENyakM5Wjh3SUJmTnlXdG1PVlcyMXhPQk9zdHpX?=
 =?utf-8?B?bDgyMzY0QVFtRmhPLzc5a2FWbURrN1BQWkk5eWIveXFsTjlWWGxpcFJpbWFj?=
 =?utf-8?B?YVViem1JWmk3b1I0TmEya3dXQlZCQkNUZUJFVWFuSEZHRzlKVnc3REhJRERp?=
 =?utf-8?B?MnNWSmQycW5jVXpPems1aVVpMzVvZGgxOHVRZldLL1JIQmJYQjFvU3FpL3Jy?=
 =?utf-8?Q?sHV2FAIDIQ9+FWub7u/Hdx2wF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ncmd5f2QNtq78t3ESJUiGWx2bbdHeRt/Z5lTs2th6D4CeQqRdQZrxjM3b9Z6xVvyjHRJueyWBJM8bD2aM5EEGzWF7EvZWOK4a4qx4JbSmeL7vsy8ST5RH87TLxu7scuysNLoEmaOz1m/DPQjwsr71L0QJBHFcxYCXlRLBJHBLdl/yViK6Ko105RAzo+Q8hUAZ4gnUsw8Sssx6ZZQm1E8dLVWNesfvr8m2qimdqeF2q4yxJ5P4C/KdE5izIacbflc6/zll0kjS0HTFSz80MK7rIMCptK3dPHZpOmSbndT6+8dQwhHL/bDHjWjv5DEFhf2C9Pz8LdFjxX3I7WRDl8SQ+DNwk7ziWs6VlI1eZ2DxavHO5JLtOHfJx9LTr4BR2M/+bU5wQHV76RYcO0niP1/Xj4bXxV4+gcoVGV5yK2/cqbYjHSU7MygupTb/zXRI8hn++AadoXJKt7frOV4hjHc1tee4STZHQVX3bFna/XBPXanJ803/iurfjGXicTGJPJWocxyPkHWaJQuMPukBIACysN0fC0BNnqnY/rzOV/2zYMW7RmHMaosvn4AkA6z5Y3A+sN+8IWSRG2YjEUxJjYio3/X9bKdW5iPwvTrRE/JBmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761d32d5-3f2a-407c-cda3-08de26127309
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:49:41.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv7hlqhASkJgX91ZzTGdrtHFbNj4NCJ5a1OZWRz12jCNiG0W9uXKuKtjywCxHwx+rNor/FMAXdgv6eYO1Jt3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170168
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691b7c59 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=96fNDkeSNfEz-scKb9IA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643
X-Proofpoint-ORIG-GUID: T9Bilhnp-xgZ200IklxEU-7QmwM_EbEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0fhTzIXs4o9x
 dzJbH/Sv7ybCqX7p9e2pxOmjyoLRB9TMkoMkA1svkexzDmggBfACPkTrVFyYkwiuoL7e2FgTx/O
 d/W2RTgKClCOcwa33u1Aw/BJYdjz37XjZLnJh853ZcqMQebyqPtcf/8u0HLgqXoB+1rU1rT1E2M
 jbpKtdkIDamv3zevVpJSOKkpHRsJzzuL8+g9yYiy7iT5CduvnwHJO/SFSdqzTfVLf93ggT1R092
 QOj6GHuepFMTfu5Sd+7xDhDFkColbHLTGOlMMDytLTB6e2EonPreImaM6pAMeMPCyqyS+hNT/pI
 yzAkgZSvRt1MgYj8W2EhDIdvIz0Znb+LKO8P1If/lveaFWSw3j9XmcGM7HzAwgSHEK9Kt2pN8dQ
 yyLGLmtnovyKvdNjqMZdS4YevHCt4S8fhrKgwYRAws7AXe6j+Xw=
X-Proofpoint-GUID: T9Bilhnp-xgZ200IklxEU-7QmwM_EbEF


On 11/17/25 10:21 AM, Jeff Layton wrote:
> On Sat, 2025-11-15 at 11:16 -0800, Dai Ngo wrote:
>> If multiple threads are waiting for a layout conflict on the same
>> file in __break_lease, these threads must wait until one of the
>> waiting threads completes the fencing operation before proceeding.
>> This ensures that I/O operations from these threads can only occurs
>> after the client was fenced.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/locks.c               | 24 ++++++++++++++++++++++++
>>   include/linux/filelock.h |  5 +++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 1f254e0cd398..b6fd6aa2498c 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
>>   	INIT_LIST_HEAD(&ctx->flc_flock);
>>   	INIT_LIST_HEAD(&ctx->flc_posix);
>>   	INIT_LIST_HEAD(&ctx->flc_lease);
>> +	init_waitqueue_head(&ctx->flc_dispose_wait);
>>   
>>   	/*
>>   	 * Assign the pointer if it's not already assigned. If it is, then
>> @@ -1609,6 +1610,10 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>>   		error = -EWOULDBLOCK;
>>   		goto out;
>>   	}
>> +	if (type == FL_LAYOUT && !ctx->flc_conflict) {
>> +		ctx->flc_conflict = true;
>> +		ctx->flc_wait_for_dispose = false;
>> +	}
> I don't like special casing this for FL_LAYOUT leases. It seems like we
> ought to be able to set up a lm_breaker_timedout operation on any sort
> of lease.

I just try to minimize the effect of the change to FL_LAYOUT, but if
you think that is not necessary then I will remove the case in v5.

>
>>   
>>   restart:
>>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>> @@ -1640,12 +1645,31 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>>   			time_out_leases(inode, &dispose);
>>   		if (any_leases_conflict(inode, new_fl))
>>   			goto restart;
>> +		if (type == FL_LAYOUT && ctx->flc_wait_for_dispose) {
>> +			/*
>> +			 * wait for flc_wait_for_dispose to ensure
>> +			 * the offending client has been fenced.
>> +			 */
>> +			spin_unlock(&ctx->flc_lock);
>> +			wait_event_interruptible(ctx->flc_dispose_wait,
>> +				ctx->flc_wait_for_dispose == false);
>> +			spin_lock(&ctx->flc_lock);
>> +		}
>>   		error = 0;
>> +		if (type == FL_LAYOUT)
>> +			ctx->flc_wait_for_dispose = true;
>>   	}
>>   out:
>>   	spin_unlock(&ctx->flc_lock);
>>   	percpu_up_read(&file_rwsem);
>>   	locks_dispose_list(&dispose);
>> +	if (type == FL_LAYOUT) {
>> +		spin_lock(&ctx->flc_lock);
>> +		ctx->flc_wait_for_dispose = false;
>> +		ctx->flc_conflict = false;
>> +		wake_up(&ctx->flc_dispose_wait);
>> +		spin_unlock(&ctx->flc_lock);
>> +	}
>>   free_lock:
>>   	locks_free_lease(new_fl);
>>   	return error;
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 06ccd6b66012..5c5353aabbc8 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -146,6 +146,11 @@ struct file_lock_context {
>>   	struct list_head	flc_flock;
>>   	struct list_head	flc_posix;
>>   	struct list_head	flc_lease;
>> +
>> +	/* for FL_LAYOUT */
>> +	bool			flc_conflict;
>> +	bool			flc_wait_for_dispose;
> I'm also not a fan of this particular bool. Waiting for any
> lm_breaker_timeout operations to complete seems like something we ought
> to just always do. In the trivial case where we have no special fencing
> to do, that should just return quickly anyway.

I have to think more about this. Without the flc_wait_for_dispose flag,
I don't have a way to allow one thread to proceed to do the fencing
while the rest have to wait until the fencing is done. Do you have any
suggestion?

-Dai

>
>> +	wait_queue_head_t	flc_dispose_wait;
>>   };
>>   
>>   #ifdef CONFIG_FILE_LOCKING

