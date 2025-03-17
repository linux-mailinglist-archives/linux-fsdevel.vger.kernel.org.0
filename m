Return-Path: <linux-fsdevel+bounces-44182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C221A64690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D7F171449
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567F221F04;
	Mon, 17 Mar 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2eihW/Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KeMTmzI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7132E3373;
	Mon, 17 Mar 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202366; cv=fail; b=Qu4t1GscomP9YbwowK2aGPXXcQqIvMI2YyHd9ypFQ3EpSkltcVJUgFf0NqziudUkpxaHUFuCbFJhUk0tirJOfY/rTZOTmI2c+eGq5RLK9IZBq4ynbku8odrth4Yf76BBdjA3z/BUb/ZcRCGYzTL+oKhbK6HXqPLuRXCR6Dc2jOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202366; c=relaxed/simple;
	bh=WB786cbn2i+oz5n8IC3c5M8QPpJhktyuOvpDKnq898U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTSRfrRdJpo+X+Hrw0MMWaK+7wuH1GGDrfwOZMck9Ls3rhX07upN4fu2Qqo9QsOjRoKKZrCmTPwIVmb2vtGycuf5tneHJ7ELNE/cZ+WZvdOYctftnILDGbkgJjQxLl2fEhIocBTkEPFLmcZBLxRh6262QJvE83p23BJKZqSXvsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2eihW/Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KeMTmzI6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qs71032211;
	Mon, 17 Mar 2025 09:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KipBYglR/1MIW5/Ki9b8KmymvmRRuPP6zGslttl4cvU=; b=
	H2eihW/QrKa7Wxnq86srqnrzbJc83ttrNFTRo/cN22iPUb6g/E/Wj9fF8QnH1Hdn
	v3zQ9hszRS2Ko4u3qxTeYAcaRA5Vz2JuW89FmqI8jruSuqE/GKY++gMgRTpJZGl5
	jFvpWXwiXTdwuSd7pq+fa4eQ6ru63NHQeR7hHtI1MEcZvwW6wQ8wobdOdvMsZoNF
	8ItbyZCZBcX32DpwIncgif4/mSyRpdWME73cbFAgF8c49zdZuoNnEsseYE78xDGx
	XwQcVsGWpLTN7d20YYYH7LZpNU33/CBI0qe9SHzpyJ/HX8C3l5CqE5uY92mNI1MB
	XcB8kMC+TXDxvJL+7tUgpg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8j9hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:05:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7NiSc022339;
	Mon, 17 Mar 2025 09:05:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc3wq0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDOeurHYonA8W9F7si02sOd0conDdWL6FEFwpNY4YQUBWEvrEgdD6UdUmq1rVWs+ynRUWie8nU+ZzdxsdNMtApCg/SBK7n8GvOg8gE6jjEKGQKCm3WUWn1it+9MLMwdZbTAzewCW2F8/F/pFJaIl0FJ/S19lNL8OL6XxBz7IB1o11wUo0upaDR8t3j8cubybp6wl7/KXi6AW33hTItwgHq3UF5X1t/PcLoxNCjJCazaifFpJde831BeV/NrH/rUuYCL9/n0Hs0YJ50d9UrLSe7VNKdEA+HDOeGtuJujjrWpHlLxCWBShxdc+8tKnDplQm1D6cD6mEWZyAiChZX+mWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KipBYglR/1MIW5/Ki9b8KmymvmRRuPP6zGslttl4cvU=;
 b=NiX1oFY2s4Uf2vNcbp0W/wwIxQaba9JokX/ZS033CBnXe0sxgGe1f+ErLxFpxDGn+d+2uMaPLaUKmu7LpM70UxsO7s0F9KVUbnfbglRPzqfLK03U0MgrHXGTcqx/XHbfLeMTx2uDLasQ1zSVdVCoyC2HQvKxHSskcdr9QW7nfWyJByB6t7wGF2Gw1ok2wGz9GYTOISwzhMgjvUZz4tKxgjGf2YZiBd1sRHkeyIMOWV9kTuCCVhGp6f3kSFve0WlyS4TMuvRDvtq3aAYCgRppRUiikydzX3czePaGTbMn3QHYJxwOUuuwCsMv+u8DGv+0P3XugOKAo/TkMA2mZetf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KipBYglR/1MIW5/Ki9b8KmymvmRRuPP6zGslttl4cvU=;
 b=KeMTmzI6cXl+pLM5qEs5vuYfkI/DoSf/bfKo9UKEO70LzN69btjspjAMRxXSYBu7njweUr9r1zD4igGDKcvKXP1W3vAUYdeLgebz/l0YI3mzJ720juLFKLePxbG4UOrxbVZIq+j2m9T++5/fh5glHWvWEiKcyb9LpKBh2sAaAGI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:05:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:05:43 +0000
Message-ID: <87cf27a2-6bbb-4073-b150-c4d07e382032@oracle.com>
Date: Mon, 17 Mar 2025 09:05:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-4-john.g.garry@oracle.com>
 <20250317061116.GC27019@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317061116.GC27019@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a767d4-0bcf-4f38-668d-08dd6532e57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzB5TENrOENRTWlQaGcxcnBFbnNHN0pkRno3VXhxTGdFcVNPam93UWF1dWZQ?=
 =?utf-8?B?TzJoaTJUck9YSDFQdThKVjNJUUQ4ZjBGQjg0cXR6YnIrYzZBckUxRHJkNkk0?=
 =?utf-8?B?VnA3Q3dpTTlBMnVCdVREMjY5dlc0UVNWYlBZRDZ3ajA1ZDE3YVpLamZGMGZI?=
 =?utf-8?B?dE1EQWtKTUYzcmJJMG9QMGo2eHkyR0xGVllNcFNvZ3dSSDZsUC94amFiM1di?=
 =?utf-8?B?YlROeHF4RWd5dnZGcG5YL2ZkVXBUcDV3UjRXTjNqUElIZjJuQ01hZ3QyT0Yz?=
 =?utf-8?B?TmVJbU9EWS9LaVZaSWhjRjNpV1JGLzcyeGxCVzRLZjJPS1lvSmtUQ0dURVNE?=
 =?utf-8?B?N0pEUzA1QjlzUlBjRXd1ZXlrbmJvTy9VMnhFcU9nYVVXL0JKVUtOWlJ6a0gv?=
 =?utf-8?B?UENWTVBiajZhNlNvWTRWakdmeHRGeGNSR083NWdRcWFvc3ZKamg2b21NZnNY?=
 =?utf-8?B?TCtiRXZ2Qks0Y2ZJWVZIa2ljSVMyZ3h0YmducUpvUmVKYzZTQy9aVFI4WXA4?=
 =?utf-8?B?Wi9qUGNReTRIeVdDbTRIUmlHN0RubjVmdFBJeDZzYUNYakRlaWlia0t1V2J0?=
 =?utf-8?B?ZE9aUUovOFpDbndJaGJkUjJtQVVVUzlveW5YUDVQVFpDcE5naXRodTBVYmZq?=
 =?utf-8?B?ZW01YllBbVRJRXVLS0NYNUxYRUVYWVdFa2lzSGY4c05MTEZmZkJyZkE2OGlU?=
 =?utf-8?B?WFRGV3BDTjZ5ck5WSy8yckJyTEFXWHIxaFhqZGk4REdlS3N0WkJkOUdtVnV6?=
 =?utf-8?B?eWhnQ0VXSFJtNXlCREhVM1B5Tk1uYU5KeENITjJHOTQyTUNjVDBHZDAxL1U2?=
 =?utf-8?B?VWFtd2ZVMjhLRlVuWklQOGRPSTJmUDgrVHhlcU5PNFFWWFBUUDZhamR5K1pn?=
 =?utf-8?B?d2p3T20yeXdITHVleGFmYU5COHJkaUZJb2M3RTNhU3l4UGl3VlRDOHU4VGxP?=
 =?utf-8?B?SS8vVktTMGF2cjEwSjNpTUxZV1MwdkpSWmVMcGlzWGhtcHM1bWhjSDFBWUdy?=
 =?utf-8?B?TWNDemVqTU5zbTROTmNzVkhOd0pxZ3ROc0twcEtqQ21yN3RwRUdkOGNoWG9U?=
 =?utf-8?B?QjRqU2M2Rm55RlB1YWRCSklqd2d2MStrSGtoRzNkcHgwemVJdWFCQ3dZN09w?=
 =?utf-8?B?RjFOVG1BZWxwWnRDTjBvVE5sMEtLSmJwMXJGRnlOODJGb3pjblRhYzVXU2Vv?=
 =?utf-8?B?YXkrOWlrL0huM3NYbzVUbFRiRFE0MG1JekNMQ2Q3NllCdFBINkFMdW9YbCti?=
 =?utf-8?B?M3VWd21zMWVKUWdlVG93STNRay9IeXM4SUJMekNpL2JTWVZpME5DVGlGUnJF?=
 =?utf-8?B?NkRvbnMrMERpc25GT1lieFBPM3Q3QnQ3NE1heE9mTktET3hqNThOVlRtTnd0?=
 =?utf-8?B?YVBrZFNXeHBmZ3pacWxDcHliYWF4SnMydjlPVCtFYlE0UGd5Rjk4YnN1WEVS?=
 =?utf-8?B?L0IxQi9FM0tQN3Q2aWVFL0F3Vjk1YXA4MHVIUXpHSUFERmRNc01IYzRHSmxG?=
 =?utf-8?B?ZnorR2tkYkNJeFRkMFVJZTFYZFlrQXBmOXN2a1hhMS83QXBsRnc3c3hYNVFu?=
 =?utf-8?B?ZjZTdlZHbHdTMC83eHNvbmFTd1I0RzQwZEMrajY3aHh0S2VPMEtLaHhzWEhT?=
 =?utf-8?B?NzZDNmNxZkdwMXBZZlVQcEFzakxkZ212L3Q5MkROVm1uTElaNDV2M3RQM1hI?=
 =?utf-8?B?WEhoYzhxK0UvdHMyeXVDQ1lWTW5EbXNleW9DK3gyOWZjQzJ0dURwaDRlMHNF?=
 =?utf-8?B?Tkk4c1ZhOG83Q0hTWVQvc3ZtUDV2bkhyZFZ5aDU3SGhIVTFaNUxlK1oyc2RF?=
 =?utf-8?B?aHQ2cEl1M2tENmNFZjhnV2EvMlczZXM5YnhjVEdwU3dqcUlxak9pR3NxdU5r?=
 =?utf-8?Q?835DmTdFYp4li?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBsZ0MzRHFkbDY3R0JvMXR6cGpLMHpsZGlXMGRhUXMxRTF5YTRQS1J3d3U5?=
 =?utf-8?B?WW9EbytJU2Z1b0dHa0JLYVREWmxWaXVtWWZmRmczZXRHaTNYdS9CcEc2US9E?=
 =?utf-8?B?ZnMxZElkdG1sSzdSSkpraWhvMnhQdDYwS0tTeXVZOWd1NDN2TjA3WmRPWVpy?=
 =?utf-8?B?OE9LOWZwajUwYzA2SjJzRjRkYnVSclVzOVhzNEFlbTY1SkZiaGgzVnF1ZHRa?=
 =?utf-8?B?Qm9CQTZPV2RrVEFhMWR0cVhqYkd0bDdaT1BReTB3OEtPSE42SzZrMHJ3cHlo?=
 =?utf-8?B?VlcxbVNVTHkzWk04NnErUngvL1dIVHVPM3ROU3hwMUxWM2xjWE14Y2RQOFFR?=
 =?utf-8?B?Uy8ycmZxdHNsc0ZiMDNCT0hlS2JaeDlwVGl6MFNJbGhYSFlOdE8veGQ5MUYv?=
 =?utf-8?B?TGMxWlR6YXk2SW1CSmpNQndjT2dXSi8wMDd2dlU5UEFwMEhQL2YxdkRiWFNx?=
 =?utf-8?B?RFZKTld2aFhhYks5K2dWKzlnWi9IOFJCeit6TkdqTzFKV1VCODV2SjdoS2hI?=
 =?utf-8?B?a280U0YwVnk1anpBQzI3MDZUcHZ4WE5DSi80SHlGOTUveEYrL0ZnWEQ1NEtQ?=
 =?utf-8?B?QVFiRVk0b2RRZFVkK1FTdzJHQktQakxFK3IvOTZkcktMWWYrOEFtaGpzeGFI?=
 =?utf-8?B?TmhHRWlTdGJQbzZwV2w5aUI3Y28xRHI4eituZ3VnS1kwMWp6a2I2eUNZZHZv?=
 =?utf-8?B?RmZVZmtRdExzbVQ4NmcyN0RJc3FkcEFCY2RpYlZZNGN4dVJaRWZpT2pKV1RG?=
 =?utf-8?B?RlkvaVFOc1hKYk5LTEpaSEJ2aDlrNVN0ZlNFYkx2bzh2bW9xRG5mOXF4aUZC?=
 =?utf-8?B?dk1rK1BWODVmaWRrTjBSRkFwNkhVUHhXaEl4R2U2dDhpMmYyczQ5YjE2ZGEz?=
 =?utf-8?B?SGhndHVoL2QxbnN4UkQ1dHg1VnZUUjdhb1FlblI0TFEwQ2FJdmg3TDRxTW9M?=
 =?utf-8?B?TG9SUEViTk1TbDR1ODRzQmVoT0tXSE8rWkNzUXhmTy93ZGF5bEZnZFBIMDN6?=
 =?utf-8?B?NGVZQzlmZDVhS3pNZk5jN2MxYW1UaEpVc0tVKzRrclZIVkpKQjdKbi9SNFNi?=
 =?utf-8?B?VFZGZExoTjFKUXZvVEhaNStZbjc0a2FvbkV3UHBwQTduYlVnTkkxbXRmR3BC?=
 =?utf-8?B?MWduamdhVG9RM3dFenhXeEduTzAwdk5RMXFwMUlDd09XUG1IcWNMb0VOSjVT?=
 =?utf-8?B?T3VIYzBvYUxubUZPek5Bb2E2Yjk2R3BxRWlCNjl5SUphc3dzbER4ZGljaGhl?=
 =?utf-8?B?aFVoVUtPQjNNV3huR2sxeWdRU3plMS9uRkRVV0ExTFh4MHRvbVN1MkxWSFBU?=
 =?utf-8?B?UkpnWVI3T2xBd1h5ZHE1bGFLTTIvNW83RG9HZUhpYThtVEhuQmRWYUV1WUkx?=
 =?utf-8?B?N1BiVDB6UEFXTk5YcmNUa1QzRXJwQnlOTWRSUkJpVGlSenhlWk5laWcyZEUx?=
 =?utf-8?B?cjhKRDBPUjF4UzU1KzJnWkhPTlNyRk10WTJyQlUzeFNja1pIc2RxUUVjeXA2?=
 =?utf-8?B?RGlZOWRqUlJxZ0VjUzJXUzc2NUExYmNPemRtMlUvVklDbitybHdmaXJLcUNh?=
 =?utf-8?B?TzJGNEwwa1dJdU1Yb0ZlajJ4TU5Ta1hBWUMwc2tsbjRRNzZPdzI0WHc3N0hS?=
 =?utf-8?B?MURYL0RaOElTNHlrUDd2TzdPTWNTbmFocGFhbHo1eFRQSlNvQ0hmZkxpMXFQ?=
 =?utf-8?B?QTNWT1NmblN4dHlQM0VKckZEekRVamFhYkdUV2JaczV5NDYvUkFpU0pDRHNC?=
 =?utf-8?B?UFhBYjFUMmRUQjZhM3JYdS9DczUvMC8xQmVUMnhteWNnM3F0aS8zRFpOVExW?=
 =?utf-8?B?ZmVvYUdyblNxVXRvcTVRTC92bE5wM1lvOElZS3JJUnhGclFzSE9LbFdjTTBZ?=
 =?utf-8?B?VVQ5VE90OFMwcFFYckdWTU5JM21wT1Y3MlVjdHV3VEwxRmV0dkRoQ0JuQktK?=
 =?utf-8?B?cEJDT1d6WU5ITkZpK0U1eXZOTHFNY1dVNXgrbEQ1K3VqMVArbllUcFQ5L3Vt?=
 =?utf-8?B?Kzh4bkdCRE1mWEhVcUlZN2pralYvMy9rVWovekxmc3QydnRadEdrYTdOdklk?=
 =?utf-8?B?cVJkSVZXcU9vQnJCa2kxcXYxMGlCNGNZVEErTnMyMkZ1NExnYVRxRmNNTjJi?=
 =?utf-8?B?WTRWR3EyY2hUMGRGK1dTRnRWRHhkczk2ZGRrTyt4ZjdmeXJacUUvVGlFNmNl?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sYQ5n7ozQkOBtcO9pM3cNpWpclSYT5WGQSA8YoXxAyxIYFJbGV8FV/0EmOp3L30UHeFRFDFaKHXQlk5a0x00tcwmin/ya/ve0mQtjRJjLSNS5VI9RuO/XFa12jMM8I6ThNThEuzDv+5uswrCNnWZpzya4MjMeXn2vV7OB8YrAzhAsu8IcFCk5KY0BaGe4V7DRIiNUC8fw9OR0IG2F79/+ZT2jULeYRz44LKBE7+LS3ZasNpomAgKyYDp36RxXetm7DdQFOOIZupYZEq7Zk0+JIMCXwQEXxldlE1iVmO17w7cBfjGhrAJtX5i5j4nBHlobmjjbjAt1tSSvIAkIEKmIyWLJx4lVViZkBjXOOmLlGj1vhLIm7n1s7alw/qElB1cAoer97c9TtPxPsswiJ1WulEGzPowuo7YHtq25SEcBiAA5DnnsDIjT02TzVPRw9J2B8HngUffKKw4WoyPG8U5G4wiU8itc4e7o3v3KbHLbyxyTTAbzSKCzztDgUnmRvbmJ+coiYZ8b2vonEq5VtTa5xDCLcuE8wnbM3Ee0Mg3XXcYRA8XCbXmH00VPFofPS2t+7SXwNBgE15LqZ/6Powa5Olwd0z0fu6iPmyrbvJnWAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a767d4-0bcf-4f38-668d-08dd6532e57d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:05:43.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCmzLauHranqWg+olwAXFjw9WRKZwGv2rbQH8ArPNXRor7nvNWlGUpv3HHrpU5SORnxeB2n1SmfAxvmSZUuAlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=938
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170066
X-Proofpoint-ORIG-GUID: LsITjuxdPjU8Q1whuCoi65dE1y3zcR2j
X-Proofpoint-GUID: LsITjuxdPjU8Q1whuCoi65dE1y3zcR2j

On 17/03/2025 06:11, Christoph Hellwig wrote:
>>   		iomap->flags |= IOMAP_F_NEW;
>>   
>> +	if (flags & IOMAP_ATOMIC)
>> +		iomap->flags |= IOMAP_F_ATOMIC_BIO;
>> +
> 
> Add a comment here that ext4 is always using hardware atomics?
> 
>> +	if (flags & IOMAP_ATOMIC)
>> +		iomap_flags |= IOMAP_F_ATOMIC_BIO;
> 
> Same here (at least for now until it is changed later).

Please note that Christian plans on sending the earlier iomap changes 
related to this work for 6.15. Those changes are also in the xfs queue. 
We are kinda reverting those changes here, so I think that it would 
still make sense for the iomap changes in this series to make 6.15

The xfs changes in this series are unlikely to make 6.15

As such, if we say that ext4 always uses hardware atomics, then we 
should mention that xfs does also (until it doesn't).

So, in the end, I'd rather not add those comments at all - ok?

> 
>> + * IOMAP_F_ATOMIC_BIO indicates that (write) I/O needs to be issued as an
>> + * atomic bio, i.e. set REQ_ATOMIC.
> 
> s/needs to/will be/ ?
> 
ok

