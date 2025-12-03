Return-Path: <linux-fsdevel+bounces-70532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA6C9DBB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 05:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90965349DB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CCC272E72;
	Wed,  3 Dec 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPf6453h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzBPoSXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494526ED3F;
	Wed,  3 Dec 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735146; cv=fail; b=RTq+fsKT+V+dnByTSPfNrBAH0v0JRp9JOHTOgrD2jIleE1fc0akdlWXKDBWAUysnscZm4EHwp1q/wVHf8QM+3R3XYIghL4pKmchIMWPWu+I36ZwQzH0gkq20z6zB7wJXXPd8atbX221FqNp6xyft1vlz1sOvUlIVlIcnhLO+AUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735146; c=relaxed/simple;
	bh=HlwKnoT8IAE4hSvMY3rtRGNHPdvF3jpFyRRseAYER50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+rXlvOEpDaDBs5YRN+bu2lfy124MgXaBIhD/5CRtzFCNDuuqtQ9aTN1TZyTi7OkiDyW4rvs9Ny/vOp8vFk+4tTGMnHuAFarnQNQ/5TONrfa4ds1QrcNiQJ0QotvjqpqD86939TibvtZAL8eVOnVw8rVdvoc9bSoDV9GI14xhX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UPf6453h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzBPoSXe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B32uEHT1669493;
	Wed, 3 Dec 2025 04:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jhac1Ki5I74nf2U1ve5GvpylKKcG1XZHNXH7yRtkKR0=; b=
	UPf6453h2H7yzTxQVXZtlwZY7mmGN2IjD7dWsjMZuyqp6+0vhNuSBT/TPs9v3vFE
	lywto5zq9imVqTN0MBPhAJhlNIJS8DsuunqbMHQ+7VJ2CXEEg7QFT6BU8ZaBF2jn
	ZnIbttN2ntRAAzLuQpY+3+C+mgH7j4/qXb78uQ0hgN4YTzMyXOx7dyuqY5pGdYsj
	Jxy0G3YHc6sQwNT+5/xcCBPgNUVZUTK9TjmnRulWGMi2MVSKi3p0gjTaHrh2NL5z
	eSCCIGkQnpMq4kPzu0w205WkYQzhoE1i8sZksFvGPlxevoBi4LY9EadqaL+r6qo/
	SgN9dk4AjuOw+l/0qq8TQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as86ycdnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:11:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B33UN9n023398;
	Wed, 3 Dec 2025 04:11:43 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9dq75m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAlxeVz7QfBEy9w+ZSFsE999MUn5lYNcaDC5AfFUZrdNVsk4mydWkY//VqPznES1Vy1s9H9ut86HM38QwLPvNtv06zkWGyFrXKK46h2Bj0Afnf1lVjAr6roN51j2vEpklb/azqHq7KqOaDXtwOg3GQ7V1cZto9bzrNunIZ6QJNtXP3yGstkucCL4+HMGXdczsPGbR+XNFDH9dGutaVEX6HxwtdeeTnOsMSsjv2jKxxDmR3bG2vytzSnYIqJPwpvWqnHQXd2ogDimowwHApqdlv9CfkHeL21rlJhcsS/o9jeTSBV3D6bsQRmJ/9h1DHYBg10/IxoSWhnINbdet1EvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhac1Ki5I74nf2U1ve5GvpylKKcG1XZHNXH7yRtkKR0=;
 b=PtIjcuop9uMVnZNPzQuoL2rG/EgMeYUCm6cMSGHXH/lMw2vzKw8VYLG8yJJYwSaRNjhrAYQ7eImjuVpWIlnBKtzUts4rTA736Bn8FFhutOv4DbsH3NxVUF3gee3j1OU+GwdQdQ2MzT1ZxJlLpBdlURHUQRTQ/56GIz3yxGX+d82jmvDMSVivUQnU/5v9/+6XLyHHtcuXeGp3tCjDyZ0aYZxzIgNJOvDWKleuGmw/3F1qyPIsg7OzHohCzj0NXwlOvKrkuyhPag40b1y9zXm4lfQMTS16Ytdss4j3nmkQf44wgT+FiolaZk6afVfRc66cTCeuoS6MrGNThHoTdoNH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhac1Ki5I74nf2U1ve5GvpylKKcG1XZHNXH7yRtkKR0=;
 b=TzBPoSXehVmfridIxeOobbHQ5GtvEnSNxpxmmfcQHgPX8okhZf0lbKnasb23c2csw9nxj5ulZdHrTXFdiHiZJZ2H9PAEQQGImv1QeStLADxjeF+wguYhN99bR4bwLA5UVQCZ4jSmYyCjT0KF3X+TQ3tEQOkXtL9zsrhCan1Xv0Y=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 PH5PR10MB997710.namprd10.prod.outlook.com (2603:10b6:510:39d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 04:11:40 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:11:39 +0000
Message-ID: <7aac28a9-e2d3-454d-bb6a-2110565f0907@oracle.com>
Date: Tue, 2 Dec 2025 20:11:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
        linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
        akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com,
        duenwen@google.com, jthoughton@google.com, jgg@nvidia.com,
        ankita@nvidia.com, peterx@redhat.com, sidhartha.kumar@oracle.com,
        ziy@nvidia.com, david@redhat.com, dave.hansen@linux.intel.com,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251116013223.1557158-1-jiaqiyan@google.com>
 <20251116013223.1557158-2-jiaqiyan@google.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20251116013223.1557158-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::30) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|PH5PR10MB997710:EE_
X-MS-Office365-Filtering-Correlation-Id: d17def2f-4acc-4b90-6ca0-08de32220ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3BFUnVGQjllMWYwOURmS2xmVzAxY0VQb0p5ZmM1SG1QSXZqWU00U2QxVzdp?=
 =?utf-8?B?ekFodG9iTnVNNFhTcnlNN040MlRrWjIvREx4V1hEbERSem9EU1dNZTRLNWNa?=
 =?utf-8?B?b3ZIWVpVaXl1RzA1a0RRVzRsYjg0TnpHRTFRQytjeDhXZHBtSDBmbDg1KzFM?=
 =?utf-8?B?dS9ubmRzVTNBdEg1OU5qTnBnbWcvQTlaMkRhZndUdmlHQXlCL1JFY056b0U2?=
 =?utf-8?B?Q2ZZdURCYWxMRklGS0xDYXFWTVBRNmQ3Tmg4bkpkUUM1VlBEOWc2NVRyTlNU?=
 =?utf-8?B?QnduYXh2WWtTYitHYXRJZjhWcXptaVdYb21wajVldjQ0cEIzMVJ0L0xVRFpw?=
 =?utf-8?B?TnZoUHlaU2dtUUlBZ3NrYXRySkZ4Z01kWFh5c2JYMmZhbmhmM3d4UmFpbWpm?=
 =?utf-8?B?WDRqbmhGVnZmOG1FUGRuMHpHcFhHcEE1TnErVVhvb3RSZXRMU3VMN0cxNVF4?=
 =?utf-8?B?SkFseGp4d2xuZ1MvMG5BSGUwam9kU1g1Sm1jT29HK202RmdsQ1dobmV3amUx?=
 =?utf-8?B?Z2s0UGZ4U0RwVTd5U3FtT08rdENsT0drWXZVa2JqTFFWYzgyZkdkeXhRbENT?=
 =?utf-8?B?S1QvSzlzdWNoODU5NStWZzc1UFhneTRxUUtHZk5rQW9mY1RPb1JpMmNxK0Zs?=
 =?utf-8?B?cVdhVmNhbXR4Ni9PSkQ4WEw0dDVMSG5reHBNVlZ1Y21ienVMRnNPTmpFUmZm?=
 =?utf-8?B?a04xVy9HOWtGcTNBc1k0VHNySnE1Qlp5MlBwcjJQdnFYVnZsdENFMlhMV3F2?=
 =?utf-8?B?SXFjN2ticHRXcW9hbFFrV3VNWE1URDJWcUhWaTd5TVAwcW1GODkxdE5LMjN4?=
 =?utf-8?B?ODQ5b0ZQamczaVM3TjlqREc2aExBR3RueXc3N2tJSmljczlzZ2hFTzlwUXg5?=
 =?utf-8?B?YkduNXhsQS9qUVk3aVpTYXhYSnBnOGhBNmZQUjEwajRxdHFxa1ZXcjVtK3Na?=
 =?utf-8?B?cExobzRwRStXK1FhbDcrNHVyRkE5ZkFDSlBKdldYaHY2Z0U3SWlUdU5GZjlr?=
 =?utf-8?B?ZGZKaW02b3FCU05EeFBiYVUySkppbVVVOEsvQTREZElZZkt2c0VKZ1o0alE5?=
 =?utf-8?B?dHNnSVFhZWM2YzV2RUNDNWlaOFdHeVh6YXE1eUFvWm5WMGx0YVZIUlkxWUEz?=
 =?utf-8?B?NWpUdGM1eE9lMCtQQUhSVGxtQURiSHVMOW9ad1NkTVpMZXJGQk9ITFA4Rm0x?=
 =?utf-8?B?MlptR2RzN25rNFVJb1psTndhZDNtbE1tcGMzNnp4V2poN3JPU2tyaENGcFNO?=
 =?utf-8?B?UXV2a2NSZkVyeEpMT2JBSGxEbWZEUGxUVmJBNVVhUEp5UFR3VlRCNEc4ZE1q?=
 =?utf-8?B?VHFOUG93aG53SkpROE56ZlEyRnYyaGxCZEZ3R2ZSNEZ5YWRnOW5zY2p2NUNa?=
 =?utf-8?B?QlVuVDJwSm96MDM2K1NFWWdad0VvMENQcUhYSkJ4WS9tQnNONTh0Z0l0MVZN?=
 =?utf-8?B?NDVzeHl0eHI2SUFiUjhZRE5oQSsyQldCQmcyR3pSemFZRFoyQmcrZUIydUJ1?=
 =?utf-8?B?RFpvRnJaOXJiQVZ2WndndTAreDBRZ0tUZFJMeGYxUGxkeHgzR3pidzQwM0N0?=
 =?utf-8?B?ZFlvQlMzQnZOOTI3MmdsMVNOR2o2ZzFOdko2SDNZNERoSGpwSGlEanhCOXVv?=
 =?utf-8?B?REc2SEkrb3pLRVo1NkZTN1YreWVESnZqaE94WUZwTVhHRnBHUjRHNlA2QjQ3?=
 =?utf-8?B?Sm14KysyQWtVM0tRaHZEa1dNNkZxSWVzWjZDVTRCanV4QXdjSll4WHg2OTN0?=
 =?utf-8?B?K1UwbENvdkJqdFY1N0tUZ3RjNUlWZW1MT0xYN2YwNHdDellhYlpzSTZuOG45?=
 =?utf-8?B?OFpCQjVGb3FYM21hdmtIRUs5TThYYWIvR29zSDJnUDhkOWd6eXR6OXBRajJE?=
 =?utf-8?B?Ly9ieDdJNlhkNW1ORTdHcktIekNSYU1pUWFjYWdJd3ZLRUFXVUN0RTNEYkoy?=
 =?utf-8?Q?MPoCKkaqK/m2n++THWBq6uV2x17UuI2S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpEQ1ZjQllMUXZMcXZRR3k3VjJUZXprR1llSnJnWDk4YzNkOU5TQStoYk9U?=
 =?utf-8?B?T0FpTnkrQ0ppNHl1WmdUUDhjc3p0ZWdPMzAya3k4UW5WeWpDYTYvbzdaRWs2?=
 =?utf-8?B?Wm15V1M3RmFLV3A2WGl3UURUSjBOZnY1azM2OHB5K01odk0wWXNiNjludXU1?=
 =?utf-8?B?bHBBWkZPdURLbU5zY2cxalRBQ3hVcEZKQllWME9ML2ZFL3lDdDBGM0V0ZWhN?=
 =?utf-8?B?OHlBRFVYM09YQ08ySVFDUSttVXVMRUpqUVh3WTFVMFQ4cTRORXhqQXpRMEdv?=
 =?utf-8?B?dWREQlN1SUFYV0tVdjRzWTRmZFF5bURGNWhUWnk1b1pxdnhlOTZ5R1VMN2xE?=
 =?utf-8?B?R2E0alZ4Q21mTkdwcXNmZkMyUVdkL2J3QVZ6N21pazZ3VTBBTjFnOFozUUFz?=
 =?utf-8?B?b29xT294T29HTG9rK3ZUWXpXWDhjbitjOWZuOUhTdkdzYk5lUFFIcEhGS1JS?=
 =?utf-8?B?YnhNVUI1NjJzaTJjQ1dvK0laWUw3UFBZYUx2b3J1UWw3TEVuYTJQNEordmVs?=
 =?utf-8?B?MUtTbjhhYlpJSHlyWjNkdUFZWlNsN0dlVXF2aGFaYWJYaDVCM3Exb0FDOXFH?=
 =?utf-8?B?MmM3UTZKNmE1NUQ0bDdtK1NNVHBpK0J0Wno3YkxBMC9zVm56elBWWnFiT2hh?=
 =?utf-8?B?Y0czUW5kVEV3VWZuRVN6NFhicllYcmxpY0Vlb2NNNVpxdGVLTkNoalhCYnBi?=
 =?utf-8?B?M21NbmdQdXR2eUlsam5Sa285YlJ0enZDVWFjQk4zdUFLZmh2Tk5idGdxak9D?=
 =?utf-8?B?V29tV1VIVGpDUlJyUU02SVk3RFJzWnMwMGt4UUhORkhmblhqUmJzRU5RQlR6?=
 =?utf-8?B?bnZ6dTY1Zk9YWE1QaHpwZWxDM3Q1aWNKcWVCYXZpZE5HYlE5VGJHKzhSWnpw?=
 =?utf-8?B?UVAwV0ZDb2ZDS2tJU0M1TWxLa0IvajdSRlRTa3BDSXZkQ0hGTG16WlZiVktz?=
 =?utf-8?B?cDl1dFNYb29UQVVORzhQNUdUWURiTDJybWdYYXNiOGtWNTNzQjQyMlpOU1lr?=
 =?utf-8?B?cWx3bURGOHFYL20yQWJ5bjdHd2g2eEdOUGlpeEJQeElzTk1IY3V0clFmTEJD?=
 =?utf-8?B?N3FTdGMvSk5KZUhpQjB5b1VaQTZRR2I2RlViZzRUckRzbWowUkdmL0FLVzk4?=
 =?utf-8?B?V3YxbVJUZmd6NWc0UTNiTzZEeDhSVUNOdDJuRFBhWFJhYU9hV0lsNDc3Z0Y3?=
 =?utf-8?B?Y2VNcURNTzFyTkNpS1Q1SjBRTldqdEMzVE9rak1mcFFESE1yNEUrcGpOS282?=
 =?utf-8?B?WXpoSklpOTZnbWZXTXhBRjZSMmZxUVVOb1N5SnhsU3pNUXBIVHJsZDdxaFhY?=
 =?utf-8?B?WFBBYzJHRGFQdFN1SzdpRmRrVllnbk9OZW1qKy9jemg4MkNlWkNpRGRycm05?=
 =?utf-8?B?Zlp1Y0F6blE4OHUzUjZ4MHZ6RVEvNVo3bFVmYlVxbTY3RW9hNlROUW5TN2R6?=
 =?utf-8?B?WlZKeVJnZlFoR29nd3pKeUQwSkpDQ3I0MVFjdE5SdzZOSGgrVEZITm9ISVlH?=
 =?utf-8?B?VjNwTmxGampyS1B6M3NMOExlRy9jUlNKMW1vOG84NDNhTU1Cc2dRN0wvUGtX?=
 =?utf-8?B?dDRxS2NJaTFSejZyZE92UkZEVEZ4VFY5N2Nqb2dVYTJWZmJSNStTLzFITmY0?=
 =?utf-8?B?a3ptbHM2VlhtaWJXaVBhZU9PKzE5d1dCakRMRTdXbUlmKzZpa1I4aEJBSytL?=
 =?utf-8?B?ZThEbGt5dEdKOVd6dG4xN0RjU2U2ZkFYT205aFpyK3pJN0JlRENRREgwZlNK?=
 =?utf-8?B?RVl5andtVXRtcnBBMEdDUjJWd3BkcmFIU2piaXVNdC9aaHFoMDhSSHFnWXNu?=
 =?utf-8?B?R0I5Sk5DUkVjdnd5dHd0YVBjZXVIWGF3MkNuYjdkWXhoRUFOWWJZYytEL0R6?=
 =?utf-8?B?cjQrNkRJQnJ6eUNHME85NDJjSXZNYlpZa085Rm5lcGMwNVBTVWQzREhMUzBY?=
 =?utf-8?B?S3ZCcFJxMUdTaDRXSDg5Smo1Y1I4KzJISjY2L3hTaUhGcFFncXJTY2p5N3Qw?=
 =?utf-8?B?L1A0R1U4QkxBcW1WOE9IdndLY3haMytjUm9GTU9KZHVWdjBZQUhFMTFPN0Jz?=
 =?utf-8?B?Q2l4RmlpTnVyNEQ2UVFQVGVhQmkzbTBhQ1Q2dXRhbGJIVnhWc2pJOHJCMlp6?=
 =?utf-8?Q?i2eGiVO/Q9+M7DiRmm1pOW38K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/bDf6Rqmc2dvEF/Hdw2wL7ZIsX0z67SG2jN4E9QU8r24MOgEBstg7U4hhNrnKY7BgE9QrXIszXQuzC/nT/NoWZvROaMZbQ4LsleLtKmv5XUgwr4i/H5vGHUlpWmkEEWH3lz2w1fp3NpVWjOdC/TSclMv7DAn7dI/0ROCGjANQo7KDT00g23J6h2Cj/N0ZVMRzXzFzMcUBMyCanrMetwewiedtVtW8DLTENjb3ByCKpOHubynBVw2pjL1Pn7OVamceOLkFblzeiAhuPA+cugi0Wy72bsEUEc9A+ZmCssrfTUpgBF/pX21h6DU1OyDID4JP3GkhftYekAUzlMzhEV9e+ZkNzdyP+nvD07Mflo5Yd6soAIN9kXA4rh8r4SVvpN98DZh2u2PKY0adzhvghwPyTjVNeuB+1D/HAVjLjX5ubALH8rkUwMwaaF2rOePmuOPiHU9LufZ6ixXhjxLDdVHzrWOLjGgyVRdoL9gwDql5hiFVSbiDaVIP0vI/MT9ta2yIpjen7Ix7WAFD4GNRGno/hv5eCAnAjjcsXjcU+NNLWQC/oNm7Mi2Qjz73GZRpRO7ly5LBJ8TMrerE2OQYrp45lpYC2OR460WR1J6ot+xmq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17def2f-4acc-4b90-6ca0-08de32220ef0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:11:39.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlojvULAceClxEhoWkgtbkr6B4zW7ImKh+r5RtpR/xPXCg813hqFU7FPhg66q23rUHJsiN/7htgyngnWQtUZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030029
X-Proofpoint-GUID: GdDQS75YK-w6IspoZ599hcY_1OihTCfw
X-Authority-Analysis: v=2.4 cv=AaW83nXG c=1 sm=1 tr=0 ts=692fb87f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=iY6tx07lXI3uiyFFzSgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAzMCBTYWx0ZWRfX8sS3apCp9eyR
 GPmC0xs3PPPOebgfsgLeVYGlybS00uLH6gCp7U46Ocm+7uheOdRyZ/96RDF3DgJHsb6ycBM281R
 k9kLuUCR6PnOpzhSynP20L6NpZFHNvDPsCoigFPsRGBf2OQoZ2iS5M/++jH8e0FDZCWcKzFhNli
 WFA6fBTnUK1bHit2w4NqkiK31bW8kHdqjR7wiIzuRqCdRKvx3xejag3ZBIhvuFgeB9mpIQqa8uH
 Sgsg0r8rT/imsGeAKX/P7TCJaQnUebKo8tFa1xFIRCk5e7UtnSSNgjt1cT1oEc7dByjlGaZKtpz
 5jnzPRhE/tsrOxDiDXXDUb6N2sE8JG9VSMX6JTMpNoOuowuLAPIqp8M7Nb3MWbvaf2HkYkxVO3E
 7guWzl/O1A+Oqy+bW6Y/OBx9JlSZOV7O1IckMBYmM8etmoeIG5Q=
X-Proofpoint-ORIG-GUID: GdDQS75YK-w6IspoZ599hcY_1OihTCfw

Hi, Jiaqi,

Thanks for the work, my comments inline.

On 11/15/2025 5:32 PM, Jiaqi Yan wrote:
> Sometimes immediately hard offlining a large chunk of contigous memory
> having uncorrected memory errors (UE) may not be the best option.
> Cloud providers usually serve capacity- and performance-critical guest
> memory with 1G HugeTLB hugepages, as this significantly reduces the
> overhead associated with managing page tables and TLB misses. However,
> for today's HugeTLB system, once a byte of memory in a hugepage is
> hardware corrupted, the kernel discards the whole hugepage, including
> the healthy portion. Customer workload running in the VM can hardly
> recover from such a great loss of memory.
> 
> Therefore keeping or discarding a large chunk of contiguous memory
> owned by userspace (particularly to serve guest memory) due to
> recoverable UE may better be controlled by userspace process
> that owns the memory, e.g. VMM in Cloud environment.
> 
> Introduce a memfd-based userspace memory failure (MFR) policy,
> MFD_MF_KEEP_UE_MAPPED. It is intended to be supported for other memfd,
> but the current implementation only covers HugeTLB.
> 
> For any hugepage associated with the MFD_MF_KEEP_UE_MAPPED enabled memfd,
> whenever it runs into a UE, MFR doesn't hard offline the HWPoison-ed
> huge folio. IOW the HWPoison-ed memory remains accessible via the memory
> mapping created with that memfd. MFR still sends SIGBUS to the process
> as required. MFR also still maintains HWPoison metadata for the hugepage
> having the UE.
> 
> A HWPoison-ed hugepage will be immediately isolated and prevented from
> future allocation once userspace truncates it via the memfd, or the
> owning memfd is closed.
> 
> By default MFD_MF_KEEP_UE_MAPPED is not set, and MFR hard offlines
> hugepages having UEs.
> 
> Tested with selftest in the follow-up commit.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> Tested-by: William Roche <william.roche@oracle.com>
> ---
>   fs/hugetlbfs/inode.c       |  25 +++++++-
>   include/linux/hugetlb.h    |   7 +++
>   include/linux/pagemap.h    |  24 +++++++
>   include/uapi/linux/memfd.h |   6 ++
>   mm/hugetlb.c               |  20 +++++-
>   mm/memfd.c                 |  15 ++++-
>   mm/memory-failure.c        | 124 +++++++++++++++++++++++++++++++++----
>   7 files changed, 202 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f42548ee9083c..f8a5aa091d51d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -532,6 +532,18 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
>   	}
>   
>   	folio_unlock(folio);
> +
> +	/*
> +	 * There may be pending HWPoison-ed folios when a memfd is being
> +	 * removed or part of it is being truncated.
> +	 *
> +	 * HugeTLBFS' error_remove_folio keeps the HWPoison-ed folios in
> +	 * page cache until mm wants to drop the folio at the end of the
> +	 * of the filemap. At this point, if memory failure was delayed
> +	 * by MFD_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
> +	 */
> +	filemap_offline_hwpoison_folio(mapping, folio);
> +
>   	return ret;
>   }

Looks okay.

>   
> @@ -563,13 +575,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>   	const pgoff_t end = lend >> PAGE_SHIFT;
>   	struct folio_batch fbatch;
>   	pgoff_t next, index;
> -	int i, freed = 0;
> +	int i, j, freed = 0;
>   	bool truncate_op = (lend == LLONG_MAX);
>   
>   	folio_batch_init(&fbatch);
>   	next = lstart >> PAGE_SHIFT;
>   	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> -		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +		for (i = 0, j = 0; i < folio_batch_count(&fbatch); ++i) {
>   			struct folio *folio = fbatch.folios[i];
>   			u32 hash = 0;
>   
> @@ -584,8 +596,17 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>   							index, truncate_op))
>   				freed++;
>   
> +			/*
> +			 * Skip HWPoison-ed hugepages, which should no
> +			 * longer be hugetlb if successfully dissolved.
> +			 */
> +			if (folio_test_hugetlb(folio))
> +				fbatch.folios[j++] = folio;
> +
>   			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>   		}
> +		fbatch.nr = j;
> +
>   		folio_batch_release(&fbatch);
>   		cond_resched();
>   	}

Looks okay.

But this reminds me that for now remove_inode_single_folio() has no path 
to return 'false' anyway, and if it does, remove_inode_hugepages() will 
be broken since it has no logic to account for failed to be
removed folios.  Do you mind to make remove_inode_single_folio() a void 
function in order to avoid the confusion?


> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 8e63e46b8e1f0..b7733ef5ee917 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -871,10 +871,17 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn,
>   
>   #ifdef CONFIG_MEMORY_FAILURE
>   extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> +extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> +						struct address_space *mapping);
>   #else
>   static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
>   {
>   }
> +static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio
> +						       struct address_space *mapping)
> +{
> +	return false;
> +}
>   #endif

It appears that hugetlb_should_keep_hwpoison_mapped() is only called 
within mm/memory-failure.c.  How about moving it there ?

>   
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 09b581c1d878d..9ad511aacde7c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -213,6 +213,8 @@ enum mapping_flags {
>   	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>   	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>   				   account usage to user cgroups */
> +	/* For MFD_MF_KEEP_UE_MAPPED. */
> +	AS_MF_KEEP_UE_MAPPED = 11,
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS = 5,
>   	AS_FOLIO_ORDER_MIN = 16,
> @@ -348,6 +350,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>   	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>   }
>   
Okay.

> +static inline bool mapping_mf_keep_ue_mapped(const struct address_space *mapping)
> +{
> +	return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
> +static inline void mapping_set_mf_keep_ue_mapped(struct address_space *mapping)
> +{
> +	set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>   {
>   	return mapping->gfp_mask;
> @@ -1274,6 +1286,18 @@ void replace_page_cache_folio(struct folio *old, struct folio *new);
>   void delete_from_page_cache_batch(struct address_space *mapping,
>   				  struct folio_batch *fbatch);
>   bool filemap_release_folio(struct folio *folio, gfp_t gfp);
> +#ifdef CONFIG_MEMORY_FAILURE
> +/*
> + * Provided by memory failure to offline HWPoison-ed folio managed by memfd.
> + */
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio);
> +#else
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio)
> +{
> +}
> +#endif

Okay.

>   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
>   		int whence);
>   
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 273a4e15dfcff..d9875da551b7f 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -12,6 +12,12 @@
>   #define MFD_NOEXEC_SEAL		0x0008U
>   /* executable */
>   #define MFD_EXEC		0x0010U
> +/*
> + * Keep owned folios mapped when uncorrectable memory errors (UE) causes
> + * memory failure (MF) within the folio. Only at the end of the mapping
> + * will its HWPoison-ed folios be dealt with.
> + */
> +#define MFD_MF_KEEP_UE_MAPPED	0x0020U
>   
>   /*
>    * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0455119716ec0..dd3bc0b75e059 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6415,6 +6415,18 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned
>   	return same;
>   }
>   
> +bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> +					 struct address_space *mapping)
> +{
> +	if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
> +		return false;
> +
> +	if (!mapping)
> +		return false;
> +
> +	return mapping_mf_keep_ue_mapped(mapping);
> +}
> +

Okay.

>   static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>   			struct vm_fault *vmf)
>   {
> @@ -6537,9 +6549,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>   		 * So we need to block hugepage fault by PG_hwpoison bit check.
>   		 */
>   		if (unlikely(folio_test_hwpoison(folio))) {
> -			ret = VM_FAULT_HWPOISON_LARGE |
> -				VM_FAULT_SET_HINDEX(hstate_index(h));
> -			goto backout_unlocked;
> +			if (!mapping_mf_keep_ue_mapped(mapping)) {
> +				ret = VM_FAULT_HWPOISON_LARGE |
> +				      VM_FAULT_SET_HINDEX(hstate_index(h));
> +				goto backout_unlocked;
> +			}
>   		}
>   

Looks okay, but am curious at Miaohe and others' take.

To allow a known poisoned hugetlb page to be faulted in is for the sake 
of capacity, so this, versus a SIGBUS from the MF handler indicating a 
disruption and loss of both data and capacity.
No strong opinion here, just wondering if there is any merit to limit 
the scope to the MF handler only.

>   		/* Check for page in userfault range. */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf211..bfdde4cf90500 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -313,7 +313,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>   
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +		       MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED)
>   
>   static int check_sysctl_memfd_noexec(unsigned int *flags)
>   {
> @@ -387,6 +388,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
>   	if (!(flags & MFD_HUGETLB)) {
>   		if (flags & ~MFD_ALL_FLAGS)
>   			return -EINVAL;
> +		if (flags & MFD_MF_KEEP_UE_MAPPED)
> +			return -EINVAL;
>   	} else {
>   		/* Allow huge page size encoding in flags. */
>   		if (flags & ~(MFD_ALL_FLAGS |
> @@ -447,6 +450,16 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>   	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>   	file->f_flags |= O_LARGEFILE;
>   
> +	/*
> +	 * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create; no API
> +	 * to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED is not
> +	 * seal-able.
> +	 *
> +	 * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> +	 */
> +	if (flags & (MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED))
> +		mapping_set_mf_keep_ue_mapped(file->f_mapping);
> +
>   	if (flags & MFD_NOEXEC_SEAL) {
>   		struct inode *inode = file_inode(file);
>   

Okay.

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3edebb0cda30b..c5e3e28872797 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -373,11 +373,13 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>    * Schedule a process for later kill.
>    * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
>    */
> -static void __add_to_kill(struct task_struct *tsk, const struct page *p,
> +static void __add_to_kill(struct task_struct *tsk, struct page *p,
>   			  struct vm_area_struct *vma, struct list_head *to_kill,
>   			  unsigned long addr)
>   {
>   	struct to_kill *tk;
> +	struct folio *folio;
> +	struct address_space *mapping;
>   
>   	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
>   	if (!tk) {
> @@ -388,8 +390,19 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   	tk->addr = addr;
>   	if (is_zone_device_page(p))
>   		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
> -	else
> -		tk->size_shift = folio_shift(page_folio(p));
> +	else {
> +		folio = page_folio(p);
> +		mapping = folio_mapping(folio);
> +		if (mapping && mapping_mf_keep_ue_mapped(mapping))
> +			/*
> +			 * Let userspace know the radius of HWPoison is
> +			 * the size of raw page; accessing other pages
> +			 * inside the folio is still ok.
> +			 */
> +			tk->size_shift = PAGE_SHIFT;
> +		else
> +			tk->size_shift = folio_shift(folio);
> +	}
>   
>   	/*
>   	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
> @@ -414,7 +427,7 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   	list_add_tail(&tk->nd, to_kill);
>   }
>   
> -static void add_to_kill_anon_file(struct task_struct *tsk, const struct page *p,
> +static void add_to_kill_anon_file(struct task_struct *tsk, struct page *p,
>   		struct vm_area_struct *vma, struct list_head *to_kill,
>   		unsigned long addr)
>   {
> @@ -535,7 +548,7 @@ struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
>    * Collect processes when the error hit an anonymous page.
>    */
>   static void collect_procs_anon(const struct folio *folio,
> -		const struct page *page, struct list_head *to_kill,
> +		struct page *page, struct list_head *to_kill,
>   		int force_early)
>   {
>   	struct task_struct *tsk;
> @@ -573,7 +586,7 @@ static void collect_procs_anon(const struct folio *folio,
>    * Collect processes when the error hit a file mapped page.
>    */
>   static void collect_procs_file(const struct folio *folio,
> -		const struct page *page, struct list_head *to_kill,
> +		struct page *page, struct list_head *to_kill,
>   		int force_early)
>   {
>   	struct vm_area_struct *vma;
> @@ -655,7 +668,7 @@ static void collect_procs_fsdax(const struct page *page,
>   /*
>    * Collect the processes who have the corrupted page mapped to kill.
>    */
> -static void collect_procs(const struct folio *folio, const struct page *page,
> +static void collect_procs(const struct folio *folio, struct page *page,
>   		struct list_head *tokill, int force_early)
>   {
>   	if (!folio->mapping)
> @@ -1173,6 +1186,13 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>   		}
>   	}
>   
> +	/*
> +	 * MF still needs to holds a refcount for the deferred actions in
> +	 * filemap_offline_hwpoison_folio.
> +	 */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		return res;
> +

Okay.

>   	if (has_extra_refcount(ps, p, extra_pins))
>   		res = MF_FAILED;
>   
> @@ -1569,6 +1589,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   {
>   	LIST_HEAD(tokill);
>   	bool unmap_success;
> +	bool keep_mapped;
>   	int forcekill;
>   	bool mlocked = folio_test_mlocked(folio);
>   
> @@ -1596,8 +1617,12 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   	 */
>   	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>   
> -	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> -	if (!unmap_success)
> +	keep_mapped = hugetlb_should_keep_hwpoison_mapped(folio, folio->mapping);
> +	if (!keep_mapped)
> +		unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> +
> +	unmap_success = !folio_mapped(folio);
> +	if (!keep_mapped && !unmap_success)
>   		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
>   		       pfn, folio_mapcount(folio));
>   
> @@ -1622,7 +1647,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   		    !unmap_success;
>   	kill_procs(&tokill, forcekill, pfn, flags);
>   
> -	return unmap_success;
> +	return unmap_success || keep_mapped;
>   }

Okay.

>   
>   static int identify_page_state(unsigned long pfn, struct page *p,
> @@ -1862,6 +1887,13 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>   	unsigned long count = 0;
>   
>   	head = llist_del_all(raw_hwp_list_head(folio));
> +	/*
> +	 * If filemap_offline_hwpoison_folio_hugetlb is handling this folio,
> +	 * it has already taken off the head of the llist.
> +	 */
> +	if (head == NULL)
> +		return 0;
> +
>   	llist_for_each_entry_safe(p, next, head, node) {
>   		if (move_flag)
>   			SetPageHWPoison(p->page);
> @@ -1878,7 +1910,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	struct llist_head *head;
>   	struct raw_hwp_page *raw_hwp;
>   	struct raw_hwp_page *p;
> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> +	struct address_space *mapping = folio->mapping;
> +	bool has_hwpoison = folio_test_set_hwpoison(folio);
>   
>   	/*
>   	 * Once the hwpoison hugepage has lost reliable raw error info,
> @@ -1897,8 +1930,15 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	if (raw_hwp) {
>   		raw_hwp->page = page;
>   		llist_add(&raw_hwp->node, head);
> +		if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +			/*
> +			 * A new raw HWPoison page. Don't return HWPOISON.
> +			 * Error event will be counted in action_result().
> +			 */
> +			return 0;
> +
>   		/* the first error event will be counted in action_result(). */
> -		if (ret)
> +		if (has_hwpoison)
>   			num_poisoned_pages_inc(page_to_pfn(page));
>   	} else {
>   		/*
> @@ -1913,7 +1953,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   		 */
>   		__folio_free_raw_hwp(folio, false);
>   	}
> -	return ret;
> +
> +	return has_hwpoison ? -EHWPOISON : 0;
>   }

Okay.

>   
>   static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
> @@ -2002,6 +2043,63 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   	return ret;
>   }
>   
> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
> +{
> +	int ret;
> +	struct llist_node *head;
> +	struct raw_hwp_page *curr, *next;
> +	struct page *page;
> +	unsigned long pfn;
> +
> +	/*
> +	 * Since folio is still in the folio_batch, drop the refcount
> +	 * elevated by filemap_get_folios.
> +	 */
> +	folio_put_refs(folio, 1);
> +	head = llist_del_all(raw_hwp_list_head(folio));
> +
> +	/*
> +	 * Release refcounts held by try_memory_failure_hugetlb, one per
> +	 * HWPoison-ed page in the raw hwp list.
> +	 */
> +	llist_for_each_entry(curr, head, node) {
> +		SetPageHWPoison(curr->page);
> +		folio_put(folio);
> +	}
> +
> +	/* Refcount now should be zero and ready to dissolve folio. */
> +	ret = dissolve_free_hugetlb_folio(folio);
> +	if (ret) {
> +		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> +		return;
> +	}
> +
> +	llist_for_each_entry_safe(curr, next, head, node) {
> +		page = curr->page;
> +		pfn = page_to_pfn(page);
> +		drain_all_pages(page_zone(page));
> +		if (!take_page_off_buddy(page))
> +			pr_err("%#lx: unable to take off buddy allocator\n", pfn);
> +
> +		page_ref_inc(page);
> +		kfree(curr);
> +		pr_info("%#lx: pending hard offline completed\n", pfn);
> +	}
> +}
> +
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio)
> +{
> +	WARN_ON_ONCE(!mapping);
> +
> +	if (!folio_test_hwpoison(folio))
> +		return;
> +
> +	/* Pending MFR currently only exist for hugetlb. */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		filemap_offline_hwpoison_folio_hugetlb(folio);
> +}
> +
>   /*
>    * Taking refcount of hugetlb pages needs extra care about race conditions
>    * with basic operations like hugepage allocation/free/demotion.


Looks good.

thanks,
-jane

