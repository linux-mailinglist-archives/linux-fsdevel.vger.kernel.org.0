Return-Path: <linux-fsdevel+bounces-41418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485FA2F470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861731886378
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0522257B;
	Mon, 10 Feb 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kjkjWPPH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sIhLTnyz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E4256C8C;
	Mon, 10 Feb 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206795; cv=fail; b=gfDpKu42x73ZMGesjOitf0wUGeCe4qhu8cDY1l7XML6+Bz6aq+BMuEIK+UU6f1EfcxXzpt9OHM5uOd/h1sR1mn+gupenPWRByNyewYOp3oIkZAZUsHAy0sJ6nfo70KoitWQUO0v2ef7qaQ5g15f8JKBSN6ZEGmlvtH69eHpvmRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206795; c=relaxed/simple;
	bh=z+aImkhk1XKlj6n98XnyooiwCT72eVKn0dKB7iwyYis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/54CmnZw1Ns7uxCspJ35lblX3zqE0EBCfrvjDoUv7W2/ZaTjDzyIiNjzgjcQR0MNQyjrgwPXRDfkTgWjKGx8iadIfZZ1JQ/qD7uGQfoHCLiBkg1bs0GG7dGg0TqjWwwzgWzNljNKy/M53bRmM7vQwPUw8WkMakQh+looWspz+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kjkjWPPH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sIhLTnyz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AGgG1w005640;
	Mon, 10 Feb 2025 16:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rCrm3IdZbO6e12jTOXcLqpZwm2UrZpVYa7jdtObeIXY=; b=
	kjkjWPPHjPoxqiZIVNoAUsuH0BixBdbX+Do8uYklOd21+5ae6YOj3GWfiq9x7p3F
	dcoHTI++BibrMlwxbk3vruHQui/2yFQqMu10SiDfCZAclvObU0gPkulkh+vbC2kc
	ICVag0B4cns2Cjy7+paA2oBj4AR10Ms6nIE7VUSdDC3TiFIiwQNwb5dnUQMM9BJM
	Yj/Fy4LTYG6s6lkC90iOugqwJNZVPR4fxcKOadovO2ARtPSrFUBvi1CPaKRZYA+l
	VB+k9Q9hFcz4TT/jrcLDqXDKfsWfZRb8O+GQ7f4HKcxRYeDLDNZF3ogVkE+7F4Rm
	do5hDpRnAJf0xdWb2KiUmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq3gac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:59:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AGu3M7002581;
	Mon, 10 Feb 2025 16:59:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7nrny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 16:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bolwYpXs1dJ+Dr6g5dbzjZUzY/4TN7x7wt+9bFaOAEYNfUIWhSR1arJTNypRCTN7NELnGCxt4TgihPLq3sFnXWVrf14ZYcqckD9jdkmmw4iSv0MbcfSIBGA0wEyySOSUOzXayFYgUpQRmK4U7t/JYKyntBsOfe84yJESHiz5aqAV32BvOmWQK5SayH3tqzQqZ1DW5JpOtle7Ls9T20tH5yQPuExuaCpKZok0JxStl7uBQIX3CLkE7IOzjkse3hkO2FhbhQo279E3m2x1YPv67MgMIxqmUezXQYyrpsxi3s5ApSjUtYrin8eGnxWqQsupnofjNmNs2nXlFiXJmss1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCrm3IdZbO6e12jTOXcLqpZwm2UrZpVYa7jdtObeIXY=;
 b=A5azWKd6VpqxViMwWz1M5Mau05s10NmIo/1zOlYG6z1ljeXF0QsjNbsA/fS2/I8V5vHGxAvyruXG8Dx3NEJT6hbkIRkwnIunI+gEUpzcztbA6KjkZ4jhf7BIaUmwXXLOQWR/grLg4LbKKseOl+13mrp4sB1HbD30hzCy5rTSw0F5pdBUXOqkh7OhyZgZ9eRqlRuVswyq6Zh/4gHTouwvaBELVTkDWlO26mzAvq6LvC7ttW6rPKkBowNfTeij2P+ZXVr/4n6MGOTIWH+YD9v/8nOXtYZiH5GqHln+7nQGwjfLKNXEPef+6pUEhqfYt0DstTlmSU7XuyjQUlo0q4T3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCrm3IdZbO6e12jTOXcLqpZwm2UrZpVYa7jdtObeIXY=;
 b=sIhLTnyzfPpB5qVUpF8Imc6yGdZWvc47y69Njuyq6F0xNGTVXOlN9RiAinDuYMPO5wbF1POfZt55+1tNXeEBPkV0W+jTO39tG2X4x+nGoshSsLT7f43mnxJYxTe+nQQP7TSDsCc35LSPYx2uKx2w2UaBc89AceP83BrOOoxZy8Y=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:59:37 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:59:36 +0000
Message-ID: <48acbfac-4f76-4959-b0eb-c205ebf69629@oracle.com>
Date: Mon, 10 Feb 2025 16:59:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/10] xfs: Add xfs_file_dio_write_atomic()
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-8-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250204120127.2396727-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::9) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|BN0PR10MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 72494504-c942-42c4-2671-08dd49f44cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzRVdnNUM2grRFVKSVRzNjZ5RmNPMkdaOEEvT1hKYmtyczUxczdPWDdIbHhS?=
 =?utf-8?B?L2pYNUp0S1g0bTFzOTNmOTdsbUlwRDlzemJkTHNoZzNlMVh4WU13R2o4Y1pS?=
 =?utf-8?B?MUNlQjFXSllZR0swOWpvak5HbitUU2hBUTV5T3RrSXd1K0c0UTlOUHFLMDF2?=
 =?utf-8?B?eis1MmZBVERFMEYyNDlmVjZuOCt0WTdPTlJsck00VUdaMzEwOU4xNHFkNVNy?=
 =?utf-8?B?NFNXeXlrcGJieG1OcUU1VUZHR2thRDBZNmR6ZW44WlUvdU0zM3FSbHZlTHpo?=
 =?utf-8?B?Q3lMOXZORmpOM2M2MEJIbVQ3MS9DblhlUEllQ1RCdnpIdkE4Z1lLSHBuRUdk?=
 =?utf-8?B?d3ZFSFQ3dWxaRGdOKytnT0xPM01nVncyNnpJMWVzTjhNY1FWdnNTdVZpSDJs?=
 =?utf-8?B?ZDl5N21vOUtCQ2R5N0NRNXZPN09CMi9MSFF5d3pZUWt5Z2RhR0cvMHhFRVNz?=
 =?utf-8?B?U2ZTV05oblpQR2RSb0RoRzE0M0hLVUdySldpN2pEeEtFSzVwRlp1WktqNmlp?=
 =?utf-8?B?dmFqU2V3MEhTVjhWbWVHb1YxMmFBVWFVRnlJL2JLeUpUaGlYb2xVbzBmcnEr?=
 =?utf-8?B?VHBCbEdHUTZUM2Q2d051K05WbGZLY1BXZTNWOENsV2tTMk81VnRtNVIvbHJU?=
 =?utf-8?B?ZEM2TzBMdXArUnU5SG9QU1dXWXlUNmJyQkw5NENJcEIyT0E2VjN5SExLVGpV?=
 =?utf-8?B?dXNCRHRPNFVpVTFHYUlYWm85RWNyME8zOFpGTy9KczBXVitIR05MdHVVMnQ2?=
 =?utf-8?B?UW9Fd1V4SkJqeEZ4aFIxRU5IeG0rbkxhL3FBdkVtdHNJQ0hkQnU5Mng1UnE2?=
 =?utf-8?B?ZEZCN1N5NkIrVUVabWhFcDdBSG51anA3MDlXUWoxbnpVTlJSc3ZHZ2Jjd05v?=
 =?utf-8?B?SnZGRy9OWGt0U041eDFEM29xbDNhQTZCWmZrUkJGc0FVQUdRejA5aFNIdjNq?=
 =?utf-8?B?M0Z2V3FYZldod1pGbCttdG1jdWlFMWxUUlV1SWsrTTR1S24yVlhGSHlhMFFj?=
 =?utf-8?B?YnZicFpsMDZxNTRNTkltNFlPbXZUS1pySmpCTUNWck1PQ0VtYXJZYWZ3Yk1Y?=
 =?utf-8?B?alZsTjZVeE1RVU9EMU5wRGMyY3R2dEFDT3R4ejV1N0xLcWQ4ZGk0MXhRdUlr?=
 =?utf-8?B?RUdhQzNqbHNYYjgwZDFCbkZLYnpYVXJYNFhxYkxjN0tPczJ2dm91VlE0VHFT?=
 =?utf-8?B?LzdqTnpFbUpGbXVLNWRnWUYzUllvRFNYV2JYYnJra1EzZWREWDFva2tVZE9Z?=
 =?utf-8?B?K3hEdDRsM2xlQ1AwVHBObXljZDA3T0NtNkpvN0RMS0lKOWFQYjVleGliaGho?=
 =?utf-8?B?emE2UmJ4MGJSMGVmWGo0MytqS3RsRFcwRktBdW5VYXl3RkovY1NZbUhUWHlk?=
 =?utf-8?B?eldUK0ZwMWVqM25ZaUJ5SFlwRzltVk50cS9kam5nQVBNNG9rOU9td0dPMU1N?=
 =?utf-8?B?VUNveGNtT3lSL3NtOWhBU25ueHV3MWxxZkRubjV2SnhLTUxyVlZWbW9jNnhF?=
 =?utf-8?B?b1ZPbGEybmFYVkNKU21XZXRQTHV6VGpIakphQUduVWQ3Mi9OZ1hhSm1kZExF?=
 =?utf-8?B?N0M2NlA1aHhZdmV1TGZUNlMwVUsvWEUrSi9CK3RkTTJKV1htSUNaYVBtc2pB?=
 =?utf-8?B?dFVBbFNISzAyQXlqazFBVmp0ZEVVL3VkLzZxWTFKaStGVFFldGZUSUhMOUtT?=
 =?utf-8?B?S3lPc0lrQzhyK2hIcU45bXNiU3VLM0JZbDRrNDRBeGtSWld4S2l2YzhUU2dF?=
 =?utf-8?B?ZXZNM0ZzbzIrRWMzVFlzUUdOLzJKNTBiZzQwSTRVNEpndGdLbU5GNHZiRTdv?=
 =?utf-8?B?b2JaR1hIM0ltQzRZcEhVaXgvYlNqZTBuNXpQUkhDajM4WGdwclFjaE41cm1j?=
 =?utf-8?Q?KJPzmzJTG7fhH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NJUDRlS2pOS0d1V0Z2TXUxc2ZhZmRsNWY1ZjBPZ1RPUithUjMzd2FoR2Js?=
 =?utf-8?B?dXFXT296cUkza0NaeUhXSVd2OVRTaU9uQm95ODNjT2x4aW1GODhsV051MytT?=
 =?utf-8?B?amY5aVZaTVQ2TWpZVjF3MGFkdHF2YjNOTXY3cHZuUlFoVDZWUTNkcmZFUFdR?=
 =?utf-8?B?VEEzM3VONXRJRTU0empDb0lBd1Z0SVJuRCtsaEpOMzE4R3pIWlNSalFOck9D?=
 =?utf-8?B?c3FZR2FuMDhsNHB2d1FRVk9VT29Tb29CYVdLdksya0tyOXZXdzNLM2lJYkRF?=
 =?utf-8?B?RUpieHcwNHJyNTdRcDROMzY1WnhoZWtMelBrK2lCLy9LYjFSNE4wclhONTRz?=
 =?utf-8?B?Tk11cEJmaVp0MnZEMlk5NXJ1MllQZmxteXg3WDF2VDFLRjZzSXRaZU5DTThY?=
 =?utf-8?B?NmljalFGYjN1RHQxMm92bUZsbDkzZUdtS21ML2ZvLzJWUXJqNERLWVdvZTVa?=
 =?utf-8?B?RFlML1grRkhySStOWEF5Y1JOMG9yQ3hiMGJKYVprZjRXdloyQUhnaE9PWHpE?=
 =?utf-8?B?cnRyeno5YUNkMkF6OW13bFlJa3hNWUl3Rllzc3NXRElEUnFpMjhzcHlXYlJi?=
 =?utf-8?B?OGYreHZiRnRtbG1TV2RXQ0J4VUIyeitwLzJUbXBZakpVbmV4cHRodnc1UTAy?=
 =?utf-8?B?azRhWkJsdmpMaENhOXZxSjVnTzUzTVBTVm1kUW1OSFhERWpsTzlMdCtJLzY5?=
 =?utf-8?B?QlY5aWgrWXh0VGNadzhMTGU1T2x6MDN2ZFVBOGJzUzk2R3hpSGhCRU9palha?=
 =?utf-8?B?NDZFajZMUlRHWEF0d094RjdyRTNnRzFvUCtJanBrWjRWaGZzYlRBOUtUdzg0?=
 =?utf-8?B?M3U4ZDVZL3ZVM0p6Y2NVNXlQeHJ0UC9vMmo4M3ZWeE91RFhJK0l1ZjF6blJW?=
 =?utf-8?B?NWpVVVNCbE4yT2RLdzRXb25IMDdpT1BWVHlUMk4yeGs3emNCc20rdHgzOXFh?=
 =?utf-8?B?SzdiSnpmazRUa0czMHgzdEZCVC9HTnJiS2U0TTBvbThacXBoUUFVWkdiVHJm?=
 =?utf-8?B?a2k1WURzTXBxQUxsV2VvUklMWk83bFJhczVFWlFQN1pEMlZQSEV5UUU4dTg0?=
 =?utf-8?B?RW0rSnR5ZkhoY2VXdm5zb0Vyeldta1llLzdnT0dINFpKSkhQVU5sRVhMdDhJ?=
 =?utf-8?B?UUZXSi8yTXJNSllnVVVkKzM2Z3o2cElDY0lHRGtZYUFibjUzOERNdmIzZXdp?=
 =?utf-8?B?VVdpS1VzbUs3MEhEYXhHdCtiUUdlZE44WUlEQXBIeEJHaXJlM3J3NFFNanor?=
 =?utf-8?B?SXM5WDdEbVRXT3IvcTBTeFFtcEN6RVhPVUY3UjJWMi9XaGtWLzgxdkU4VFAr?=
 =?utf-8?B?RnZlbkROaFVudW5VUkVGS25ZMXVZNUFTMGUzeGFTNFAzNFBEeTYzUHluaUM0?=
 =?utf-8?B?UFBoTU1XRlAyOWkrVHFiemR3Rnh4WkxxMW1rNFhoRE5pekZIYTcyWll1RFFk?=
 =?utf-8?B?UXd1VVBwYjMxQkxpc1BQbGE2d05DWFcwOUVKSmkwMkJQdjEvNEwwNy9NcGJj?=
 =?utf-8?B?SEpjVmVnSHlBZ0VOa3ZMZnEzdUp1MjBYZjdGdms1YStPc2lvbHBlU0xtS2M5?=
 =?utf-8?B?bFRJL2RWdmRUNjlWWFJVemc2YnN4VjhmdzFJUVZ2MVZGZW5RQjk5UFVwSFZm?=
 =?utf-8?B?amI3SmRpMFk4Q0Q4My9pMzdERjVPV2x0bXlZQi8yMGwvU0QrWFB3RzNzVTBQ?=
 =?utf-8?B?NnhDOEZBSGl6dFZtcDlhdm9iMjhpZnVDd2ZnZFhIdm9aY3lWUlJqdU9iMWQ2?=
 =?utf-8?B?b3NXem0zeTFKL3B5aXJiSXlCY2piK01ZM3JFOW5LVW01bVkvYjZISzhpbnRQ?=
 =?utf-8?B?dnowZnpYL0s4SHlFM01HdmdQMFhEN0h6MkQvcXhqMExzUzE4T2Iyb3FrUWda?=
 =?utf-8?B?ZzZrQzF3NVVtQ0NjOG1ZK2FCSDIyRmRqNDM5eEovcS8yZGJ1VDgxV09yWjhh?=
 =?utf-8?B?ODVUL2MrTkVldlY2RTdjOUVRQ092Uko5WmgvQjd6QVBWalF2ZGpxd0t4bHFx?=
 =?utf-8?B?cTYzN25DYk9QMmpxdWwwdnBIQWpRV3A2Vzc0RjZCcjRBVDI2bUVYbmpoNTBE?=
 =?utf-8?B?a3RpOFBmYWJQRmQrM2FTcSsyaUkrbzMwR25vdDRRemMzUkxZRWt5NHMvWlFD?=
 =?utf-8?Q?RbsTtyPu8swGrDFctX7JUzNkz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qWQSgc4cjU9u4DCjwexzcXhxtZwQMiXvIS2VCLhutb8mXdz63NacKcgkucVnP08qNU+vNaEmc3jVqnLlgv3993yAjdilVFW5uVzIIWNVLfXbkdDkPqVkGnFuvkATWVUCjkj/aj/V7PgZ4r7VLKj55pLsDJvj1N44Azar+Mk3mzMNCTWLjETrx5x+t1QXCT24yaru4itcFQLwA3FFD3EbFiA+v7EPJoYd5KvDE3L+07tZnTR/WS0o/MntqU4MNImxNT9xKNIut2A7Bld9IYoTzG7F7KQgAcUaILe03yUEsKlpFVLzuCIX6N1ZlptSTKqjEUcmvfyJB6CKTSiwZeQ4rEa+keQTM/yPQ60YEcrk7kTqRf7jxpOklu6/iukM0ysWs1PWxTJ89cH6OSQSjT+WVccah3vUF+tIOqnmGJdU9Di1zGCu7JioNgHW96hVuthaUNdI+GdvHvQRY1MZMLLMpKA99RSkPzcY7vmnRWzHcQq83LEEIKk3F1/qoH3ccDt7whvSlw3vkSVd3HNde/wVC3P6KPIb5hKPE4/QEfPAo6JgN7l1ocfL/ellmKABZqNSOdqKVQmDkmicjyp6NLjwXBefUuyIy6SUeudC1PiY3w4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72494504-c942-42c4-2671-08dd49f44cc3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:59:36.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUdvabawu49vWMw1DzwsXeaxd+YRLq4q81H+maCXdWalf9d4ixyp62TIVSxoOsDqiBZzBb6WpslAv7UEkLfW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=918
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502100139
X-Proofpoint-ORIG-GUID: IITtSeoVemumicr6aLB_jc-spNd8RIc7
X-Proofpoint-GUID: IITtSeoVemumicr6aLB_jc-spNd8RIc7

On 04/02/2025 12:01, John Garry wrote:
> +static noinline ssize_t
> +xfs_file_dio_write_atomic(
> +	struct xfs_inode	*ip,
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from)
> +{
> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	bool			use_cow = false;
> +	unsigned int		dio_flags;
> +	ssize_t			ret;
> +
> +retry:
> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> +	if (ret)
> +		return ret;
> +
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (use_cow) {
> +		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
> +			iov_iter_count(from));
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	if (use_cow)
> +		dio_flags = IOMAP_DIO_ATOMIC_COW;

note to self:

We should also set IOMAP_DIO_FORCE_WAIT and call inode_dio_wait() here, 
similar to xfs_file_dio_write_unaligned()

> +	else
> +		dio_flags = 0;
> +
> +	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> +
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) && !use_cow) {
> +		xfs_iunlock(ip, iolock);
> +		iolock = XFS_IOLOCK_EXCL;
> +		use_cow = true;
> +		goto retry;
> +	}
> +
> +out_unlock:
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
> +	return ret;
> +}
> +


