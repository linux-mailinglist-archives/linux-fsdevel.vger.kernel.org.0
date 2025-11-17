Return-Path: <linux-fsdevel+bounces-68775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C5CC65F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429A34EC373
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C232E36F8;
	Mon, 17 Nov 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8j2jJ74";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OWUPC3SZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA733164B4;
	Mon, 17 Nov 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407341; cv=fail; b=ipPYW77TbHecPEwT/4ELaTqCwWBQ85+aF9dQcR32AWMpfBA35dNNSnQjizlkFuWYzaGyE6LC7HrhTrmhEnXU5aD9i4kCmtwGnrxAkvN0hBfv+Qyl3EoH4PMMbB3IlQZFmJt0WGWmxAlnzNy1JDmTmHfXjvm2E+wEFxF2f/O3MzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407341; c=relaxed/simple;
	bh=4T1hTG9XpU1UNfb2/AYfZCFTehrJfp+xYHqZbcgEvfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EMEgONgdtrNcCC4G8sQc3HF0A1tTWJv34JBq+mmyjKJd/wwj52IGuG7SmYJLAmiSdCaoyej/LsYGaXneO96ljROLT/bLuUHjkv1gLhiqkQrQXpmUQSBfwsRJD/5V7IL8DIqHw7EIUF+dxsZPfbTToLqQMu0XIojHp4lRV+c2FH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r8j2jJ74; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OWUPC3SZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8ExB005481;
	Mon, 17 Nov 2025 19:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GDKloeOSArZvJ5mep4ckD1PCl459AzjyCqX2os2DYmo=; b=
	r8j2jJ74F4AKDQvdFSYB3VQ90FZ56rR3a4bvGFy4Y55RG2hzZ12gSi3ZhncPUS3t
	3/jX9hTSULOzOGlXaLcdENDEGrUV6yDNKxGFgJXm79AaCxzvxDlP8xUU+W66QArb
	mjCCq674qnewMolSNlYKfgBI4W3HGG4RzDZ0DaWumQ4HiOIygrcb6CdQOzScJhnP
	v7iYxwdXHIMJkW+8deufWQBvS+oUjJgWhZTkxt5R25YvAlAw2P3qOgjG+bp9SCiD
	W/zLfVz+ijUMXOm3AVpEvQ806sjh4Vbm6zLkmlkD8VzNSxmASa0cZIIyejsOAzDS
	Xct97kv8Rzam1u7hWLIMDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbu6th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:21:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHIqBrm009572;
	Mon, 17 Nov 2025 19:21:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc4vyy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8JqCErr7dZQzZddLQwOlrXQQTq9vSy+EXVWMaWHaBwJsNEMY4fLNOecANaz77tjciM9ifjGjfLiAWUYzN93tisedijUN9GnCbsOK3FymTwXHKPgxp4CVcVEwf07kLHX5nbdKN1vmhGS993hF7LRA5F/OaQGSOxMcXIfjwlZkFByuGh1cgfiuC97qkDxP5IHqhKUmwcRP9C7YuYYTp8GF+QgjbvAvQX5WQ/a0cvenHB4kFm1f/th0r5isvaGRxB8RsvdGuCGZNfLzUaAd3ECRG9/YsnPhRNDYndu7VxzXxi4vZAdQDV3dH/gQU1j2HGe43XUWf4zNVeL6WgrGcTdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDKloeOSArZvJ5mep4ckD1PCl459AzjyCqX2os2DYmo=;
 b=kDLsXC5WM9JyHOjzGjOq1cPTl/Qw4O+emABVa2dltnzPT5LfZ5CHyNir5kHyDyo7mc99uRK/UXt67B8t4+VuLHKpMFnGp/LrZEbaPyB+Qu+gFlKF6nZDKi63EeDjcZs4ywNwpUc85jyo+oBK9fs7UfmdnjFT8cVZ63IPeKDUVlc/QH3GY5v5HztdnXf7AaX5O6zBa+RAkGOssuY9sfWiR/G3pWwPmCbDSFwGNkJuMpXzvlfXMqYnHTNknuz9oiNPMZL+l5umv1xoMeFqNDjOLgtDED2K6dMJoUFw11cD8nGnlPAnMmIsIM2Eru0uR/J5NVDHpu6Uwlnr7Vg253zlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDKloeOSArZvJ5mep4ckD1PCl459AzjyCqX2os2DYmo=;
 b=OWUPC3SZ/e/ezpWrbhUg0xOD6BDUMAt9rBM01UmTn4MXO/eURLVLj58KSCy4tsTEpAf4Ukk1zY02H0SSDX92yX+5lu0uk6fI/1TBpoXUM55dFbwsvYTJkLxbmOkNoiow8KM/bdwF01Kkbjg/ib79aAW8Y0FyIgLANWEbGc6rpTk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 19:21:51 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:21:50 +0000
Message-ID: <a180f1ba-3344-495b-b720-a4fb7058092e@oracle.com>
Date: Mon, 17 Nov 2025 11:21:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] locks: Threads with layout conflict must wait
 until client was fenced.
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-3-dai.ngo@oracle.com>
 <9cb3fc1f-af86-4a55-8345-09dc294bcd07@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <9cb3fc1f-af86-4a55-8345-09dc294bcd07@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::21) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cd23d3-5e88-4c7d-53cf-08de260e8f3e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bFlHdURNOUlWQzBCTXhzTE0vUTEzNzQvSHM2a1J2Uk5TUzVCTWhETW9XNDN0?=
 =?utf-8?B?bWhlZERJOGtIUDY2bmMxSzlDbHVFbnZhNGdORkxwT2ZyRlhNUWo1UnRDS3V2?=
 =?utf-8?B?bGhVNlVnZG4vMGgxZytBNnZGdDN1SS96QWY3Y25kNmMzRmo4YnpzWDZPTzA5?=
 =?utf-8?B?aFY0Yk5HQWNLWVRvVjg5Wit6bnhiVnM1RVV6WHRMRU9wSWx3Qi9HTWlaZ1BS?=
 =?utf-8?B?a1lRMkREbDdVWi9mQjVOS1Q4YjZiL3BrSTVIS3U0ZDFqUzlqL25UNEx3L3VL?=
 =?utf-8?B?WStCZS9uTnhMRDFzUmV2ZW1qc2dVVEVYUm5aWUpQQW9wUjE4Wk5Na3ROdGc5?=
 =?utf-8?B?RERmRGJ0Q3BWOGphVmc5aFJkV1N3MDk2elIyWmdodTJnOGY0a2hNdnd0RU05?=
 =?utf-8?B?UEtJbFdrQ2IyZ3JEcmIzdzRtenl1akN4b2VIemo1a0p1VnZrMUEwRDBnY1Rm?=
 =?utf-8?B?ckV0TUJCaWlFSjQxUE4rSVowTGk1YjZISjRWVjVoNVA1NWJoUlUvbVM1Z08z?=
 =?utf-8?B?SU55eVhMWVpCTXowSmgvZDNlVnNFcktHUnNQZ0dPREp4djgxMVd1NjR2cncx?=
 =?utf-8?B?bnd3elBNT3REQlNPRzBXNUZvNW1sL2NwYU5sVTBkZ3c5a1JtVWw4VFNIR0Vx?=
 =?utf-8?B?dGd2UmpVSGpDUU9MeHZ0cnp1TzBKNkFaSUN1SU12M0k2OExiWnludW8yYXlp?=
 =?utf-8?B?bisvK1VCRDNnQzI2dWpEcVRiTDhFQ2QwSm05Y3ZhUm1SUGl3MWtxc2x0bGs0?=
 =?utf-8?B?alpVdWpFZU5laERuOXFCVFVYRFloSnMxNUJSditXQWZJZFhJbkwwdTFIczlm?=
 =?utf-8?B?aGxiZjdBMHNQcVd2bjRtNWRVYmRZejVubHROdWpDdWpNMm5NSG1wd1lHbzFy?=
 =?utf-8?B?bUFKZzBYRVlKN21KSVFkVTQxMkdFOVArR2FKL3dHaTJIMHNQVGVicW55Vm8z?=
 =?utf-8?B?b1lHTUNReTZFRzFlZmtjVUM5SVhhd2VqYnRHY0xLVTRYMUxhRnNtZVIyQ0h2?=
 =?utf-8?B?cExHZ3d6WDdYTHRjMTFvek1RbkpJSzQ4RmVvM3BSTHhJS253R2xENG03NU43?=
 =?utf-8?B?KzQvUS8xNGhkTlBkaklQYUY3blpHaGpUZHNYZDBWd0JXWndXMi95VUIwNWpY?=
 =?utf-8?B?TzN1MkZ6cVpjUE5CR3Nab0ZicEtGUVpXMmUzRmc1S0VsVUFmdUVwcnRtSmVK?=
 =?utf-8?B?WFBuNEY4RGVFRGhvRld2blp0SDBsY0NRb2pkMHU4eEVnckpxQ0NLVTJLQ1Ri?=
 =?utf-8?B?VlhzS3piQzQ2ODczelN1M1IyWjQvdEVQWnZOTkxzSTQ4dTI4SzRwRWdwY3dT?=
 =?utf-8?B?b1d2OUhLcENIWmx2YlpGOUIvb1l0RWRJTUVmNFFVWGNlaThkUmxuRHN3TTN6?=
 =?utf-8?B?dTJ0empsVzlIWkF0bkNjY3U0SU1UdVcrZjdpajZ5eG5pbDcvWTk5d1B5Mldr?=
 =?utf-8?B?QnI1NERVOTJVYVJGRlRCRTR3WVFzaU8zM3ZKQ0VHRm1abTNPU2xFYTBPWHFL?=
 =?utf-8?B?L0ZlZ0xBV1dGS253Tkc4YWFVSmVGSDUra3NmNFZiRzJFcXBwZHpRSUxOVzZP?=
 =?utf-8?B?V2cyY05oSHgvak1sUXhFbWp2STRIR0lZLzczRWZScjd6dTg3M3IxR25RSURi?=
 =?utf-8?B?eDVuVWR5TVpHMmRqMlFyUVdUdjNoeEk5MzFpenJTUVVsd2tPa2lzUW90eWNM?=
 =?utf-8?B?dE1qTTF6M2txYWxhQlVCYmtONG44ZDUyRkNIYm5TeFhWZTluTDBYb0MzYng2?=
 =?utf-8?B?cVNUUmxnQzJ4VGNtSXByb0RsbGQ1dlBHUXExNXovdmYwbDU0UUlpUnRrSmh5?=
 =?utf-8?B?bjFMQmx3Yll0MUJFTkh4TEVyUGNJeStWY3hKN0tiUjVqY012dmdGRWJuRUV6?=
 =?utf-8?B?dm0vclNMNDQwdVVNMTBvY0wvSGpoMkcyWXI4M2djdjlzWklPV1JBaTZyQk9x?=
 =?utf-8?B?d2VveTRuU3VjZ2NwbFVLSDV2R2pYZGU2eUNnVU91ZytBdDU1UFk5d0c5eFoy?=
 =?utf-8?Q?TJaup+K+Y0tI8y26CvzU4h+7bYg9Z4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?STkrZjVtRllHcVRSd2VqMHdIdklMOXU2MDRnUjBhb1NsRmNteWxPRG8rRjNN?=
 =?utf-8?B?cW03QkQ0dm5CU2JQQUIwVXphcnJjbDJHWFJ3aGVkWDlvd1FIS1lqT1E0Nzc2?=
 =?utf-8?B?WXpNKzhkc2lqVENNek8zRUwweStFNjVRMFlEUENtYlYzd2lsYXE2UnV0VU1H?=
 =?utf-8?B?RlEwMnFjNk11anhPZGU2aktCNUtQdytoV0Z6K1NiTzQ1RG4yMjF1MFIwUi8w?=
 =?utf-8?B?YlAvdXRZQTgzbEVxdTY2SjlPUDlMdE5YZ2I3T2p2OStrN2pkYzBEcHlpYkRo?=
 =?utf-8?B?MWU2dmljYW9XeHF2ZXF5WFl0RjVySXJtZXZhVlRvMXdOUUcrVkhmcE56WkV3?=
 =?utf-8?B?dEVUUVJ3V3U0WW9lTUNxb1Q0aUtXdnBGYzA3L0xablpiNUU5a0x3b2NuR0hI?=
 =?utf-8?B?VjRnVEtINzl0NlVuZkVhcVhPNSt4OWt6R1IxaVhLcXRHK3l5NGp4aCs0dThY?=
 =?utf-8?B?MUNEZUh4UHpua2NCcmwrOGpmSEhFSFF1aVRUT1BvNjhSazlNY0RkM2x6cnJB?=
 =?utf-8?B?bFlJdVBtak1pMGV3eEdTTXU2T3U3THpKanpoMmQxcmI2K2UwVkZpSUtyc2Zw?=
 =?utf-8?B?Mi8vSUFoMDFyUlNRVGc2N1NjM29ydHN3OEdVaGxRckY1TU55QkdobXEvRkhs?=
 =?utf-8?B?RmovZUNFdE12WjJmUm1LUm0yUURESUlUOHIvajJpcTVyUGhKaVhHNmtiVzlh?=
 =?utf-8?B?UmpBZkszNWdsZHZlL0VDVWhHZm1Dbk45T2FFU205R2l2N1ZRQ3lyZWFwdEdW?=
 =?utf-8?B?ZXMrTTU1WEN3WlQzdllUdHlTOGNTSU84SEN6UFltbnRxU0tsUXdTZHAveXBo?=
 =?utf-8?B?akpld2c5RTlLK0ZubTF4M3ZseHp1SUVlV25ROVYyU0ZvaVk5Q0RsVGRQakUv?=
 =?utf-8?B?YUhyL3VOK01hbFBEMGtPZEx2M0h6Y3ZsSGFzUE9kb2g5ZDM2WUxZUm5PMWdW?=
 =?utf-8?B?Ti81aVJ4ZXVNakRWaWFiZWl0OXVVSERKNkJXWVB4clVOMW9FMGZWVTlLcFZ5?=
 =?utf-8?B?MlhhU0I4VldMMWUrMVNaaldIVWl6eTdMcUFYMlRmVGVSaldDMEIwc0VDTlp4?=
 =?utf-8?B?dXNaNUJ2RUYwS1Z1WFhRMk5RQXhDM1Z5c2lpQzVCRncrcTNiTzU2Q3c0NjRp?=
 =?utf-8?B?djdwR0dDL1pCcFFEWTJJbEVIN3dpWWxWRkI4Um1LMmUxQVRJbTNEeEZPVDl6?=
 =?utf-8?B?M01GKzB4NExwNmsxQVNOdkRNcGNQeTNYVWFhRmlYQ2hhUkJ2RGF0MlBiUlA4?=
 =?utf-8?B?cmZaTjFUb3h5YitmN1hveENuSVlSeTNOTnIxajZydU04YjVZcE5JNVhmTGNv?=
 =?utf-8?B?SXV3MjJrMXdEdzJrL1VZVXFDRXJWYW9lVHUwSDRuRUVGTGhQRFp5bTNiMG1J?=
 =?utf-8?B?S0JwTUk4MFQwQk9nSzJqMzBKOWJDYXgzM01DMm41b0NKSkJHMC8rSGgrdmwz?=
 =?utf-8?B?Q3pTUVlGUG1TTVl6QjNZYUtOVHVqWUwrdVI2a0tpOWVzM3ZDdFJxRTFTaFFu?=
 =?utf-8?B?aWg2RmdZYi8wK3FrVldpSXBMVGZZSFQ0Ym1USTVzL1pqNjFsOHdGeloyMnhq?=
 =?utf-8?B?QmJ4NW94Vmd5dUNGd3IzT1lLVU1iTVlRR1lZTXg5UUVFbWhBcHF0RG83djl2?=
 =?utf-8?B?MUNiVHNGejdJK3ZLVjZuUWNvNGxSdlcvOUR1RW13d2RsVEpnbWFNSHlyMzVW?=
 =?utf-8?B?NG5pS1lzRWFQZEx4WjVXSG5qLzZDZ1FjYUVYbEdKbjdvV2k3YjNKQzZzWUlI?=
 =?utf-8?B?MlpCVXlvK294bkVSSW9obkRBOEtPd2luMzBrSTRydTNPZzBaVHhlbU5qNDVa?=
 =?utf-8?B?Si9hbXFrVW1oc1FlN3J2T0hjV0FVbjg1WmpNTEpzVkNSZFN4S0xld2F1My9Y?=
 =?utf-8?B?ZmNCTmNSYVU0V1VjenRmQnBmLzBjclFmcExZTnBDTUc1bjAzbGxhb3N4MXhB?=
 =?utf-8?B?ak1kRVdrZm1EbmF4RGpwZUUwTXV0ZFZTNCs3YnJlOER3RmNnNG82Wm5wNmVU?=
 =?utf-8?B?U056ckduaFNwSE5Bcm1MdThyNVoySEpQTWt0aEozeVRacG5pVzhENG5iUDZ1?=
 =?utf-8?B?OW9JWWgvaHVwNCtKNk02cEhVNDhKbTAvemtRWkNiekZ0bUwxK2VRa2orakRp?=
 =?utf-8?Q?girPuMefdZY6roWdLh1hWVf/D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hCe8+pF2By6aD4t99Y5VPRlw1LGZhaeAdmlMBZtY2q0wJ9ATlIfjip1qSNiflMgYit006sUu/6LjrGtgNHYuTisus6rFtoHO9QepOk1f7Ed7csTzyJ7XzJreZEmhKLmZG+GP5VvT8aBlr/Nw0UT2KObR8k5HTu7JrjtETd6CqIWc1JYvD/rdBa+p4Yxsr7LtR0W+zp6SyztzUIYsOylEt6BI7nxr0Vp0xZQPsUNGQOJHyRjMReOq++4v68Y9HSIERAU9YM0dtnvAOTMnnQgela93Eb2wqgtO4nOuacFSPrC0wLF9H5As/FscW0tXLcbwZaQZ6HOXerpS46mYhRI4MUvAom4EAxmCnotBneqBP9bMRzlgVBMtuzkLlEODJcJl2j5Uhaxq/d3TVXjZ2a1tlAgSXpzasSWmoiI5JAlmC9No9b4Or9L2W5dJiz7wUgwDsYdkBLfWuTNqS0Na9WMcnzLT9TdNveFsvfNi7dZHM/IwEe9TA6WySrijDjiTJ85cRmOPrVJvKRpA3ZV0Qlrlo+zIzqM4LXPC5MkWTT7Bb9AgrTK4ct3Sdl8sUg3YfZDUyo2wEUMcTnAF3VCcuPz13koAFV40AZ6XaqDDQxSEPxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cd23d3-5e88-4c7d-53cf-08de260e8f3e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:21:50.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja6ko5oFMQ6yuULEtoAYrStWGjRqsCtcqMLUjLiWn4aa+qjYT71tfwULp8q7KKiU/XDqk40FxKaZY3Ye2uWoUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170164
X-Proofpoint-GUID: pDsc9nLXjlzawmlu3Fx3nGhX2RsSMeCy
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691b75d2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=_-g13tMmQ7bz6-FHJXAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643
X-Proofpoint-ORIG-GUID: pDsc9nLXjlzawmlu3Fx3nGhX2RsSMeCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXz5vOQwtRIs0y
 07RHq6vDcVBQ7XmJfa0a19UdIx7QA8LfvwfrMR79YXysCfZqB7kDUusgSfnqE3BA1f5tmCyst+w
 PM5Kg3E2vmQRodp7PnlmgDDjywc8i2GkQARcZAvuT1KF1h4INIiyI5oT6nzDnVM63Da12s7E8zO
 /DEDvshaRnFedLvhgH9wnq2rPWfFmKhiiWjn4aX8pMlbLIvihDS2f7pwXDszuCElLkl2InhgSEJ
 xjkXERkJPRycs6uARqtGs5Q7Rg7CNw2D9a9JYStn6BGtJAuLoPJC54VLRXBsGLooqre+nZyTehM
 FXEWQbDcmCgtO7QyWCyn1x9ovGvV2PK2cTV2HcDAJzrJ+Y99/2xSdDTzH4PD+8CNsGurWqSf6af
 3hSVGxBbdTlPdXP9hdrLNl7VwBKBPCPtMYbh1utXgYvuuC5PgrM=


On 11/17/25 7:47 AM, Chuck Lever wrote:
> On 11/15/25 2:16 PM, Dai Ngo wrote:
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
> The file_lock_context structure is allocated via kmem_cache_alloc() from
> flctx_cache, and it has a NULL constructor. This means newly allocated
> structures contain garbage/stale data.
>
> How are you certain that ctx->flc_conflict has been initialized (ie,
> does not contain a garbage/unknown value) ?

will fix in v5.

>
>
>> +		ctx->flc_conflict = true;
>> +		ctx->flc_wait_for_dispose = false;
>> +	}
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
> Nit: scripts/checkpatch.pl might prefer "!ctx->flc_wait_for_dispose"
> instead. Also, it wants the continuation line to align with the open
> parenthesis. Ie:
>
> 	wait_event_interruptible(ctx->flc_dispose_wait,
> 				 !ctx->flc_wait_for_dispose);

will fix in v5.

>
> Notice that if ctx->flc_conflict has a garbage true value above, that
> leaves flc_wait_for_dispose unintialized as well, and this wait could
> become indefinite.

will fix in v5.

-Dai

>
>
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
>> +	wait_queue_head_t	flc_dispose_wait;
>>   };
>>   
>>   #ifdef CONFIG_FILE_LOCKING
>

