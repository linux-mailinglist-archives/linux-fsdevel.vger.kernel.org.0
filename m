Return-Path: <linux-fsdevel+bounces-44184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2DA646D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C211890567
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22D22069F;
	Mon, 17 Mar 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixHCemQ5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PAfa8ObL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33D130A7D;
	Mon, 17 Mar 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203051; cv=fail; b=FwRVMyVgAozRCpyxNe4Zf8juiml/8YEJLJyDL5qCP7RXlY9lH/e1QywB6pCJY7wh6Dn53JRZPKBwPKsu4z+xNttKINBi/1uI4+Uyl2TqAV5ejzi71j//vu5NtQ4xE9IwgSXlonJ5bi7/jKJKbSZupgMcypmzMVyhO4uldoh8wsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203051; c=relaxed/simple;
	bh=zunlW2TLTQ/24UPIeFF6TpgOgVqji6q/34MYQLRO2ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxdRPTTN7TWCPVQbKibht29Mcv2GYLTloXXhtNLrrhI1Amx3rqJwuv8iuv+L5Qm9ZR1atFNkAxYbBOiJ7QwgfltYwM71eUMBXtXBaoqJBFO8zUKAtESTBNv2/wst7fCqU8tgVwWvpkNv3XtwtxhbwUzrWdSKgSCL+bdBGPyDwP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixHCemQ5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PAfa8ObL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qqxi026574;
	Mon, 17 Mar 2025 09:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lzjKpejFnxWUidp/25hbuFLwu8z50jc6ARid+U1MQkE=; b=
	ixHCemQ5tak44OcRSmRBDT6k3sNi8QYQi6tfDPY/xlqyN7VhSsrlsbNIblmCJevg
	NeIIGcS99XU5z6m6cFarYc9YK4/7IQNF00GXVB39iTZ1Xk0uo4cQVxqiKwyZmELq
	CxjJuZCsZiWQ9PvtxUPoQmIwW4VhGeTgjLshPK2D1hsKv2DX614ENESI9brymeyl
	hyJpI2LywJdFFOHmY8FdIL7k2r9M9+Xm4SJoSrteAKessRd4OrqXb1bG2ixS+eAC
	ZeMm1UTBGqGTfRadNQTm0eZCXumoYkf55X0GlFZhrLV5zpunhq+OQFjVVfYUJb03
	UvUQdTV4yFRBzKiDctNwWw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m0t8tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:17:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7hrkO018653;
	Mon, 17 Mar 2025 09:17:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdhdxw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP1sJWuE8jT0mKYbpVKVaQ9qqrd2WxGmoWtP14to4pxCYDhbQiM6enedhLYfQVAX4jr1xHjnrkwQTWYlKJBQT65SUZtQyM2hma0AlmgdopbjAjd2pylh1mmaLt7cN9cvPQc4m0GfZcjAd+dBut4bO/F3SlVxFWKBYZzT52FUD3S2X3zE2yRcwmnR7IKUSwaWhrk9VmjgNd4X1aTGNnxNQaoH25G7CMEAZq7nbOiMKgPsfiPktJ5Zr3jbkVcamcdzKVuWfd5J9MhlXtK7UShGFQUpDLfUCd4XQxa8warzhpHhN6yMai2pWFLJwIXZTtE/MiuPlF+gYjzntncys+YEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzjKpejFnxWUidp/25hbuFLwu8z50jc6ARid+U1MQkE=;
 b=SRMdEkJhwHLH0mR08r4hWJS28Y9AW0X5Ojt0Agq8GpSN+9PK+YVf8qBLHIPM38Qz54Oe4xqKoQ5OF29i1b6hfL8N+dXbnHYt8td8cXBn6BFzYbDrFOleq3qnRrJLmxcevDwXe3GKH6DJhJHwfXHaX0H9537UrPUTIVycnUz7BBFewl7fLlsTjcfOj7N+kUHrXmJxsODVxWKGo0GHB4eRzaTEh9w42RNyw3wc2PCNpm71Td2HW7rA7nz4xdcv0Z3sn7PngnKe8VDCIUOVWqlULglNEz9284QhfWE/C/HhytFQRLlpnmjNz/PPaxjo8GWGhfzZouqElm82qWWcKX66ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzjKpejFnxWUidp/25hbuFLwu8z50jc6ARid+U1MQkE=;
 b=PAfa8ObLQQRmds3ZE305vs3RBGUKftstYHWNkF1BbqMH0copN0Vf6n+8C8JRUujjLuZcMBDcpVwytH63iNySCTW+hFaAfgde0LaufI7ckrp3saZMT2xMVvhyC+FvqxfvrnTkO8ZzQIXuRfWhJDv6ZqhJSfFJ6tPRz/OydVmqpkM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:17:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:17:13 +0000
Message-ID: <7c9b72fa-652a-44d5-9d51-85b609676901@oracle.com>
Date: Mon, 17 Mar 2025 09:17:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] xfs: pass flags to xfs_reflink_allocate_cow()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-5-john.g.garry@oracle.com>
 <20250317061523.GD27019@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317061523.GD27019@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0385.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: aa777a1c-9767-4923-07fd-08dd653480e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVLSEppd0lQWUdPYVBaOFlEOXpQZERFc2UveFBObmI4YU9lZzFRcVdYbWlG?=
 =?utf-8?B?aDczZW1qRThsWDVKcnFpZzc4bERkdW1qYzlLR2hxZEl6Z3FNblJmZjU3Zyt4?=
 =?utf-8?B?MHU2VjdFc1A3R2tESU5kZ0x5SlZXWklLNGpLZGZodWs5cDVYaW0vRFJZN1Zl?=
 =?utf-8?B?SmlCWFRCRnZqMTczcTE4NUY4NG9Ia3BBTWpqZUhQeXN6dy9ZY0NPcFJLc29m?=
 =?utf-8?B?OXlTWjVGVjFpWFc2MWFsN2p6dmVBT2JxUFJ2Q3I0ejN5VEFDRTR2UFBIeVpw?=
 =?utf-8?B?NWp6SUdyRVBKNnpMZzBadEJieWJYU05JSVdYcWxrNEM4QURBN1pxbTlCWVBF?=
 =?utf-8?B?bkVmdTlmU0FmbzV1U2tFeTBYZSt3ME9zekV3TCtwVEV5YnFVTW1pMmZnQ2RL?=
 =?utf-8?B?SStVWGQ3VXFReEpabDZyYUZMYStQNDhjalJDVGtyS1hRdk1ObmhveFNldnBK?=
 =?utf-8?B?SHFobDI4bDdxb3ZOZ0hFVVJ1MHZMUGpyVmNLOHl6Y3pwTmhkYnZtbEpNMkM1?=
 =?utf-8?B?QmxSMU1oVGRZT1hVOGxlbmV4Vks5ZXBaZHAzcFovblZDais3b0ZneUtWVm5E?=
 =?utf-8?B?akxJMUdYQnRTcExoUFVTTXhkVVJSOWRpbWJRS1FxaUlFMU1IQ2lKL1drRmEz?=
 =?utf-8?B?b3VCWTlyZERGaTFISnF5Z041VWZKV1FKSVNHOVlGL2t1Z3gvTWtjZnBhMHN5?=
 =?utf-8?B?Ujd6OTBiQUFPajcrTW1SdlhUeEdkUU9meTR5a3g1Mm9xOEVEV29OMkhiQ2la?=
 =?utf-8?B?SDcwMms5bFM4OWlraDkvTzZRQ0JvRUhpM01XQ0ZneTZ0YXo2VEh3Qjl0bENo?=
 =?utf-8?B?VWFuck44Y3dGRHpQekZZZHZ0K3liS1hXNjU4RkFkMzJ0VnB4eFJrNVdnSDRt?=
 =?utf-8?B?K29Fa2Nwd0piK3o2TkVseXRmVzdxczVkdFQ5T2YxR2NCbGh0SGExWXl5aUll?=
 =?utf-8?B?RW1zQkhyNHVDL1V1NlBCNE9OTzRncTd4eUNNWEFuTExUdTBhdzJnaVdPSStu?=
 =?utf-8?B?ZHhJaVFZcGdQZ0t5bFhLN2hCWVJvNklnYVR5aFdPaXAvQWoyNTVGNW1kME5u?=
 =?utf-8?B?QU1jNUt1QzBNMjN2dnN1RVYxelpLN1RwMWl3dk9QMmFhbnZqT3Q3N2VmaDdD?=
 =?utf-8?B?Vk42NjFIOUpYQzNYck1pUUd1OE5ObnJtdSt0cWlwTFNOSDNBQjdwWUQ1TVBG?=
 =?utf-8?B?VnBwTURVM0R1ekhJNldSWDl2Z3F6MHMxcmRmZ3BWdVE2L3NmZlZsSzRRMVNS?=
 =?utf-8?B?VHU4OHl4U0JCWktaMEdZRVBEcjJtY3BQd2pGM2o2YjZ4c0gwdWRKMzFYWCtU?=
 =?utf-8?B?aVFOSTRVbGdQejhWMzNNWmlRWDN2TnY0eVQ0MERZckIzMnN6Q2NQMjRBektP?=
 =?utf-8?B?MTNHbkNxVzNGKzQzUzJ4ODNTQ2w5NmhLQ28xWXEvcVB6SFNrL1NXeVN4cDVL?=
 =?utf-8?B?b2l2SkRHNkZtVTl3cC8rcW9ROFc5dWlYTmRwclp5SDFmYlFrdFhVbEFsakdF?=
 =?utf-8?B?cEh3V1drYytJZlFrcFhZQVpTQ3dPZFFNQjArTHY4N1BaREV0MmZRVk0rWEtF?=
 =?utf-8?B?cVRpSmJvYzBnZ2NBWnJRQ0pFMTY5d01WTFJVYk9OMGwwN1gvL0pnUXBrVjgv?=
 =?utf-8?B?UjZpQjQvaGhvSjMxVUJHYU04bzJjT1YwRmsvc0FrWDF1UWV3bGVxZTR2Q3Ni?=
 =?utf-8?B?a0wzQnJ3bTJ3c0txWFQ5d2hISTAza1hHTHlLU0ZHN0ZId051S3FjWnhSaGt4?=
 =?utf-8?B?c0hGbS9qTlB2REdnZ2VhamdRMFEwTnVra3VrV29EL2FKMWRnNFg5cFpyZitP?=
 =?utf-8?B?U0p6c2F4WlE5dVhsSm1OQmV4Z01qa3RaTWdqaFgyajRoTUI2MkFYWUFWT21I?=
 =?utf-8?Q?UuNik01CRrUvt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhFcWtwajl3VlQ1alJlZGxWQmtteTVxbWk3NkM5UXhSNUZaMklmeC8xWCtV?=
 =?utf-8?B?MXhGL0twVG13dmJmS1JIWUxid2VXbEdSRWV5QlU0SnA4M3YweXlMenlFRFBP?=
 =?utf-8?B?Nm8vN1NWdzFLMnUvdHFaTks3bGhydEZKWjBmWmE3Q2hBZXJ5aGpEckxiUzIv?=
 =?utf-8?B?N1QxSE9kcVJBK0hnazhicGdaU2J5VFovTHF2WmFEYmNaSlpDT20wNzV2dFVZ?=
 =?utf-8?B?NExZRnhGTUhmUW15b05oeFZyTXBxTFVZSnBjZ054WjNWeFVTY0ltKzhUbDA4?=
 =?utf-8?B?eUV3Zk5ERDFvWWJ0NWFFU25oQmNCSnlRQ1VDZmVQdGRZemNZMy9XOWNTWkww?=
 =?utf-8?B?R3Z2am1wa1FxYjlTU09EbThaeVQ5YkFXcFpPM1lUK0l3VEVvRVFlNUliQ2ln?=
 =?utf-8?B?OFM4V1FxbGM5Rmx2RlMwakxMTkR6MUdJVUNOZllxVXhhVHFWRTNjcDZHV3JV?=
 =?utf-8?B?UndDWmNBYmMxdms5TEFLZGxYcU82SXMveUxZL2EvY2ZoSWllYXRTSG9pY3Ny?=
 =?utf-8?B?MGdPN203N3N6UkFNZXBBU0c0aTdrSjJJNjA3dVZjUXhvVmxidFdkdzNvWnM1?=
 =?utf-8?B?THRDWW5HVHpoYjN5QjJzQkZreSsyVXdBblBDZ3UwUy9vSnl5VTdCRFE1am9w?=
 =?utf-8?B?NnJwVmpqcWwxcmFBVm83bUx4RWpKb2VTbFlIeUEvakIyMERkREU1aFNiYlRY?=
 =?utf-8?B?Y3BNZEw5S0VPMmVTOXhEWkRQR0F1TVhhYU5mcHBIUTZudHRZYm9rN2pVNzh6?=
 =?utf-8?B?VitUVlE5eFZnU2V1UmtxQ3lWZE0wcFlVcitucHRTMU1hdFR1OXlCc1lrb3R2?=
 =?utf-8?B?ZUc5RkRuRUkxWWN2YkhMNHg1NCtleElpRlhDYUNudUkvRXdkcnd6cUdsVERp?=
 =?utf-8?B?RUg1S1N1d1dtTGU0MUdRRnNHN3hkNm9vVnVIcldVcFhmMDl3WE9odE9GOEhB?=
 =?utf-8?B?RVdQQXdPeVhvb1BUNGlDL0xhS1liRmNDRzlwZkpocXdtVXI2dytSektPcE9S?=
 =?utf-8?B?L0dHTm5JcXVBRVRqUk9BSWxJYUxwVDY4dzg5Q2NsVjRRM3E1WlZKZlFVL0tu?=
 =?utf-8?B?eUNVcmlwaGRYbHNFbFZxS242NEdBTUJHMS85d0owTWF6WHFVSWJWQVozVTBr?=
 =?utf-8?B?NkVGS01TdklsbUZPQy8rczM0cVBGbmRqOXEwMGZsTndxMkU3aEJwQ2FLbEtH?=
 =?utf-8?B?S2diS25ZZGNwdmZhRWlIbEs0QlVxNFR6TGZmZ1l0Mk1Qak9YM1RHR2NwcHV5?=
 =?utf-8?B?ajlmQnRzRVl6OEU3ZUF6SHd5U2pNZnBMenhLQUEwZ2c4OGJHak1XQVNkOUpB?=
 =?utf-8?B?LzNhQ1ZyYm9FcDJKVmZwNTFRekdmQU8xQkdBN2JEczArMkcvcE9HdVh3bklr?=
 =?utf-8?B?TGM2S3kwdE40dVd3b0lMbk1TUTVuOWh3dXdoZ0pROENFcUd4TjlSS2dtSmM5?=
 =?utf-8?B?REtTdE44M2pmaVBjUllKaGJ1UzlORjFMZUtVbVhKR0RydjhMVlA3dndyTFlJ?=
 =?utf-8?B?RzlIWlN5RFRQdTZ1V1NpOGN6Sk9yZ3BlOEo0QlZJdFpsZHpta3lBZ1dRTWZs?=
 =?utf-8?B?U3N0R3ZoZExnaE8wTk0yZW9TeE1GTVJqckt6STFDTGN5WGphMWxldGRDTzhp?=
 =?utf-8?B?bWtVRHpORm50YlBtUDZMaHZWZXhZNEZ3czFTK29ULzJaRllCQlpJWGsrdTFD?=
 =?utf-8?B?UWRUeDZoM0NpNER5NnZhL25wWTBRUGdZTE0rNTY4VnR2UURhOU1kaXFxVzdS?=
 =?utf-8?B?VWZZTkl3WHY4bkRTUU96UVBkWWNhc1g4OXQrM0lPL0h1QWxjektuQ0l2WmpD?=
 =?utf-8?B?SzNybDNyMVh5Z1FBWGlPL2ZyaW85UzdJSHl3bXp5RmJWRVEwK2J2NzMreGYz?=
 =?utf-8?B?MVFoa1BvT2wxbzlhckI0cEtPOEdqdm5kN3h2cGJpYzhqMGZ0aHAwZWV3WEpu?=
 =?utf-8?B?UDRqM0JvMHlwRUhPQkRtNUVWcUhzSkQvOGxWNWl2RGF5SUI1ZmtyOEtUZXJG?=
 =?utf-8?B?LzRkams2UVNFcHk3ZjloV0RCd0RpRk9nTWFOaUU5M2FWY0F1WTdxUjltUEZs?=
 =?utf-8?B?Q2pYREtBNXk5ZG1EbnM4elhhaEFxa1J0ZFNmeUlHUTdBY0wyUkE5OTlrdjgr?=
 =?utf-8?B?WTRVYW9OWXlSUjROZzJ3em9VV20rWFY5OU5qNzZiMUNUVUJIR0ZFZnB1djhV?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fDHHjgKseMHJKDL9cTC/Z4Tv8RaxBS2IebhODiX9ZYIBw/PrkrdmCKL4IXfWhI/A8sh96/h+llVkz4LDumdfaBHXYFKR3O1yiYyHEEPL3M6ruZqdIPGQsCY0K33+NWP/n/cvGMwF76lGBgUXnT/+cUBre8pejqbcNqNJeN8euZbbG+LjlL5oVEgT212ak4HbBDXKKJtL8zGDDFJf6s4HZ3EDKhwFHzKodGOnI6UnxzfW8eStT+nNYKMKBviezd+OsB7ZHGzFVO6Zfjh1R9T8QiDNpUiAYgOPwrUvdQtICm8F6ltl4oQmY/Up9KDOWPt52S6SJjdFbl8GBAdGuV0Ewao0R4Q/nYe4d2op1ALRlcZTFjSgysa2mv23Ji39yAW5JFo+t6xCa6faAnqSFvISK0Ty8zql8Wzw6T46O0QCWF3ZxlCRTdG2tqNJtHE7QWgsCwkLo8/ZzixxXxOzk4fVNc3T9Tw+MwV5wktyAjaTBxfrLvNSh7QQ7IzreK0blHIGE0Y8cHM6z0STWP5Wa1RwfRzwoewTZW2OBwrzCdsc9+A4VhOc3ettA+2GTN8w24YRJ7CKQAehcI7H30O7uI1oHQCdYGup0IAiLRjC9NgX7As=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa777a1c-9767-4923-07fd-08dd653480e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:17:13.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8SA8lnprM2PHyRx1jO/m40AsHp9m+Jc8lkBAfkJwcjVrgNGRs9D2yBFkLXC5qwbnYkjk6XA2rO919isYC7BWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503170067
X-Proofpoint-GUID: jVqEklU6Aa-VDVWRynomi0cgqB2qUd57
X-Proofpoint-ORIG-GUID: jVqEklU6Aa-VDVWRynomi0cgqB2qUd57

On 17/03/2025 06:15, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 05:13:01PM +0000, John Garry wrote:
>> @@ -823,6 +824,9 @@ xfs_direct_write_iomap_begin(
>>   	if (xfs_is_shutdown(mp))
>>   		return -EIO;
>>   
>> +	if (flags & IOMAP_DIRECT || IS_DAX(inode))
>> +		reflink_flags |= XFS_REFLINK_CONVERT_UNWRITTEN;
> 
> Given that this is where the policy is implemented now, this comment:
> 
> 	/*
> 	 * COW fork extents are supposed to remain unwritten until we're ready
>           * to initiate a disk write.  For direct I/O we are going to write the
> 	 * data and need the conversion, but for buffered writes we're done.
>           */
> 
> from xfs_reflink_convert_unwritten should probably move here now.

ok, fine, I can relocate this comment to xfs_direct_write_iomap_begin(), 
but please let me know if you prefer an rewording.

> 
>> -	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
>> +	return xfs_reflink_convert_unwritten(ip, imap, cmap,
>> +			flags & XFS_REFLINK_CONVERT_UNWRITTEN);
> 
> I'd probably thread the flags argument all the way through
> xfs_reflink_convert_unwritten as that documents the intent better.

ok


> 
>> +/*
>> + * Flags for xfs_reflink_allocate_cow() and callees
>> + */
> 
> And the full sentence with a .?
> 
ok

