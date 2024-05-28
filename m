Return-Path: <linux-fsdevel+bounces-20323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277558D1732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980731F24029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CA14D70C;
	Tue, 28 May 2024 09:21:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741814B098;
	Tue, 28 May 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888109; cv=fail; b=TRa5wgZBAUWsLx0uStIqoA2Ilma9QNQUz6FR5M6B1rMaMx9hpa0VznDWS4UDBfXISloShe0cMfe2eGI3I+MgnEBl7xo6PRy64kllp0OujfcKO8dmCSIdTO5N1daiOAMoC0Y5yp14kt7r/ZMjgduIH2pyv2azCGKB9//+N9UPSlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888109; c=relaxed/simple;
	bh=Mj+8R94gASvsKlf/KYXn+ULC5YxyH1MDTP24XvL2exU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upKYJ+q4jsalSk4tKTLd0oeH2X1g0rmXcWVXN9KfUWAK0TC92l9aBl0s/GUevoxUoVdyVRAPjGpMijxITp3mGBT0mIGOGqCTK6NQdh8XQCXuE22Uro/3Nu0v2Ul0ZmDmdZiZNY+ClFuyNwG5jBnQeN2FZgUTfkG03ouDpp02qX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7xc8m003748;
	Tue, 28 May 2024 09:21:24 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Ddn2G8651URwWB7UtBIn6Dnd8fcsyZ8VOUtfNtBWxnic=3D;_b?=
 =?UTF-8?Q?=3DW27MD84qRzSz1lGpnBIHuGbJBW42jtJvALJauoM9pvF4Grpstk8O0B/eEXeP?=
 =?UTF-8?Q?lSpEAT/w_2KQIMCe2Oyvp7uw+lZhSijmyP1w3t/edXAsszGyBPvPj7pZwn08cI2?=
 =?UTF-8?Q?Qm/BfsROVN87BP_2ul+u4+OZysnhGblHXO9FGjnCCo5RLG9mDvd8UC5OJNMPHe1?=
 =?UTF-8?Q?sozxK2vb5Vcg94TzNuxq_+dYDvwFC5AIvWM46omon69d5hekYn9ILUO20LJm/O7?=
 =?UTF-8?Q?W83dgRIKB4CqqOvlouzkPDUJ1k_eigX+ODI7tq1bR/l/o6AgI6+Jz7nVw8kAI07?=
 =?UTF-8?Q?8ESOwCHH0NAB0eqxskz3AmtEm/o8RmS9_xg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu3x2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 09:21:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44S75IVK036830;
	Tue, 28 May 2024 09:21:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50wm8ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 09:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBqP9+uSJd7y+cjgo1MQbHjIXwUiHQ/sdq+OTgXOrN/cj6jyFAhvYfAGufsW3YAIzS94f3rRXe8abLFvQ0xW4a1aNoSk7BG5BrsIaCDZxlE3tR/u3ruLYVg8tz2snTVcWAmDExcM1aPCuB2mXOxEVoKoD5X0kQi4+hYj+Z/VdjvV277+mA7pANNIixTMtJi/faftk13WxRkyHlJlQ4VOsq/3eTlPUFdagBa5KJUayFa6PbR3QNu0Gh4E1mblCcsw+HY+tDuYN2j1WHHtMZ906MID5I5SYBL4YJ582o2YyjSOREJy82dpi2BF/JAP1xgPtXu8mmkmxOi1i5uDBudbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn2G8651URwWB7UtBIn6Dnd8fcsyZ8VOUtfNtBWxnic=;
 b=YibKOsODVUHU5ixNWcqeUg8tG09EIfUYGwkRJigHniN2rGXZoT+To8FnNr8yhcFIsIIed+x6rcRyyr3GGzyQhWnAEauxK/Ys3YbfapV9Cpeof84WA43O8HjjLzA3ohqI9N827HrC1XRufPacOFudaFcvtn6NTyk8ri4lRDfTWi3oQbJRyn44Hmc1TQ4Vst2qcopyPPaxeM+jut5cDRXzMZ1qfta9uzyKwkghApGtJODKCmSkq2juFiBG04r0WvjnQ7YU19/ML7juncZINDM/XtZgbs/k0gOtBHiv0at9w52r+LfInIvaI0U2RNNNy6cIf6owjiCk8PEbK+qcgRr4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn2G8651URwWB7UtBIn6Dnd8fcsyZ8VOUtfNtBWxnic=;
 b=fM2hpPN2K1uSC8OvnzmX78ANq6LvLfJcmOy2mE4P8Ruds2unAv49VEjyBNQiOd4yPb8XbzujIiSHFeEzmhYr5dofruaVaFbvSa6kmj2lvNVmAnDysYUFzeVnsNF+Bx9ikHC1JCNxhtWg4NjvOMydWBBGCu/Fi328bfTEYkUSNo0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:21:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:21:19 +0000
Message-ID: <4c68c88d-496c-4294-95a8-d2384d380fd3@oracle.com>
Date: Tue, 28 May 2024 10:21:15 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk89vBVAeny6v13q@infradead.org>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zk89vBVAeny6v13q@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0016.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: a5db7ca1-ee11-45ba-50e6-08dc7ef788b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MkN3L0JKSUVTdVJrRUplUzN4Vlc5Tk9GcHl4M3dlc3k0Z1hjNlZBcSsyQ2ZV?=
 =?utf-8?B?bkhtUXdYZy9CQ2EzQSszclFXQ0tELzBGc0xIdGZvbUlOU0tUaWFoNHVUYVdF?=
 =?utf-8?B?VElxME1wVmdINytvRXhELzdOekMycFhlZDY5WGVBZmF6NVl1cVVWbzNwODhm?=
 =?utf-8?B?UXhELy8zUVlvdUlyVjJBT2FQTm9KRUpnUktJUitrNy9TZURKMEFPMW9wZG1M?=
 =?utf-8?B?cmJtQ0N6NDNRTWt1dGVaOEtiU3pTVDg3NEp5cHhOcXNFbkRiazN4dnJUMGdO?=
 =?utf-8?B?QklSWVlDWWRMNjVpL1FFSG54amdoWGpSazFGUm1wUWdnV1ZiZHBOUlo3bXhI?=
 =?utf-8?B?K0g0MmNLNVFWUnQ1UnlGNVc4ZHhjT2M4cWV1M1FDUzFmWFZhV0VSL1BLVEVm?=
 =?utf-8?B?aUtUWTFueHVOYVNsODhoQ0t3NmpBR0pGNFVOU1dESTg3THFyMWhyb0xWTEVW?=
 =?utf-8?B?ZVVaL1ZhUVN2SVFVVW1jdE93eVIzNzhVdEoyWjlJTDVKdkVjSThudHM5cTl0?=
 =?utf-8?B?YjBLdVN3TUROVVU2MWtOeTBxNDB4U0FBTTYvL0ZjQkZzak8xSkRUYlAzV1R6?=
 =?utf-8?B?WUwyeDk4SHpJWHhiK2NyTjFWMXpGbUgrZkJRVTRFclQxdTBGcUEra3RhbXFD?=
 =?utf-8?B?d1R6VWVVVkJadUFQSnpKUjRvRVk0MjU2VG10SG5ZWnZ0NFdLS3A2K1JoaFJO?=
 =?utf-8?B?N2tsMng0OUtZekZFNkdtSHQyaHk1WS9KaURudVdiK2ptdGlPLzNLR1VvTFFi?=
 =?utf-8?B?ZmFrWlpqRUFYcUhtbFZGYzBobzVLSzdEdlhVK0lESU5MU3QzeFV5aHpZTlhK?=
 =?utf-8?B?NFVRdEN1UnFvZGluZ3pSNGViWG0wdTA3Q1A3U0JlbWpkUHFFRzMvUk5xRGNH?=
 =?utf-8?B?TlNob0FPZWh2enV2aWhuQUFwSnFWN2NsUy9uZzZ4ZENabTI5YnBPeWNVcnBU?=
 =?utf-8?B?UFM4UDQ2QWlCUWgyVXQrczhWTkNJcGlqaFU5SW10K3V0a1FaZ1pEbHN3ZW9T?=
 =?utf-8?B?YTAwcW5NaVBaSG5hZWNQWWsvQmQxZjFWZ1Y5U1FJY2R1MGhMVnJXUE5TTW0r?=
 =?utf-8?B?aENYTitqZ3cwcktsNm5jM3h0OTI0TUNCYnlTRGpaUVdvRHovOFRNckdscmk4?=
 =?utf-8?B?cDczZE9kb2IzYjVCNTl6c2dmVWdRSGpaUzJDMHJWOURVVXhsZGpRWjhkb0ls?=
 =?utf-8?B?Uk5JTjZkMHBtOEV0Ny9CUU1tZStSR0JDOW03NnBvbElSc1ZjeGFPc2RscDdt?=
 =?utf-8?B?ZkdKeUs2VlVXTjhqeVlyK0o0NTJuMCtpT093L1NJRjFocVE2Y0dyc3FiaVBG?=
 =?utf-8?B?S2VrQWFUUkRsWWZMUHY5eVdLbUx2dU1vZjJOUCt1dnY4MGJsMldSMjE0eGZx?=
 =?utf-8?B?ZFdFMGxYRmZtNWxoRUtZd2ZPaVRMYjkwSTNyR1hyMVRtMzVjckR0QmtNbHhS?=
 =?utf-8?B?YlJHNjRGM0s1QU1XTHZWSGprYUtMYUZDS2xaV0hndndNck9UcDNwdkJwSk1Q?=
 =?utf-8?B?WmJ0MG5Qb3VSemRoOEZ4bHlKSUlxY25RR3RnUVlrYUt2S2ZPYXIwUWFTUEQ3?=
 =?utf-8?B?NGQwUk96OElBZ2k4UlpYb2FqREFQdEI0WW03TGxBS0t2MHlMdGJ5b0xIY0Ji?=
 =?utf-8?Q?zN5VXKEGFEwjiesNswNIBhRo6gYd6dh2ZLqaMjii+Jow=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1kwUnF3elRCQmJzUXNyTU9xRlE5N1MxNnR3L08xbGxMUVh6WElsdG1XeXY1?=
 =?utf-8?B?SjdtT2FRK1QxSnp1YjZmYzNQN01zV1loUXVIaEVnaVNtTnc4OEpzZlYrRWJ4?=
 =?utf-8?B?NVJBa3RyTjZLbVZQUWk1Qk1oS2JlUDlBQXNMV2FsSTdOaWlWR1dSZzZKUXBL?=
 =?utf-8?B?RWdSNkpXOWhkK3YwSGVmZXVmbUllNFQzUUdrRklPMnRNQkdPZ09tais0UEdQ?=
 =?utf-8?B?NGhhOThVWXFPSlZZNi9TSzl0RFhzV2F3SFZ6ME0wMjhpR2tqdThEOHYyYW10?=
 =?utf-8?B?MjJwWGhieWdVRERuQnpoTDdUUE9TaTdBbHc2U1NIYVRJNzFLZElHV2NZMi9M?=
 =?utf-8?B?Q1k2VVdrazF3SWdjdjB1V0srRy83OTcwb1dQZzJyZ0VzZXdlMVdudmJxWE5I?=
 =?utf-8?B?Ny93TnFrWGdmbHhZQzVGaldrYjZTOEZUNEowbGU5WTV3dXpIZ3NLWGhIOGtB?=
 =?utf-8?B?M0RycWZlWHpxQXl0cjJkdXB3UUlqL255MjNDSmt3T2NUK2N6VFYzWnV3VHZK?=
 =?utf-8?B?KzlXaGVhc0lYWm5zbGxCQ05tWE1GMHVFbDZnMWpDQWhkWUpzcjdvVmRtT1Rp?=
 =?utf-8?B?M2ZHa2ZHbkc5VForYUloYlNlMENQZ1NWbU1rNUVHWkNjQ3grajY1ZHdTNXRY?=
 =?utf-8?B?YXBHRkFveElLWWJhTUs0Z3lEdGZYZVVwUG5LUXBnV0RrK0p1MGN2dC9Kc0t4?=
 =?utf-8?B?bUlybEhvQkJFa2ZGbEFmRDFOa293cDdyY3VYOUk5U3paOGppYVNIa2U0UlRU?=
 =?utf-8?B?UU54NnVVSWNmQW9uUUNHTHpTSWtWcVdSYlpiV2NDQ0pHQTZXanpuZ2JaMXU2?=
 =?utf-8?B?NFRzU2F6TVRpekNtSXdiUWVKSUpTYkFQYmFFWEJkamlWUmRjcXRmVEVURDRK?=
 =?utf-8?B?K1g0RGNQNmQyQndzS3RvN1FYSjUyVktwVUxYbE9VYjhBV0FqeWVQbjhaRnFk?=
 =?utf-8?B?S0NVUE0wTE9GR0dQRjM2bkRsTjBPUGdPbmREaFFURU1xb1hwUFNQWEpmNWVa?=
 =?utf-8?B?Sm1zVVBibG80ZVpiMit4Qnk0MHk4RmttK1NVNk00R0ZBY3pPQ0Q4TE1tUE9I?=
 =?utf-8?B?SStuVnN0VkZzaUE5NFRUVGgweUtOb2wrdTltc0s5TmNqYXZYbXBoK3BpbzBG?=
 =?utf-8?B?alNaaS9sNENQVjgyU0w2ZlErTzg4Y2owTjdXNDY2L1RscHBjYW1YS0U4Rzly?=
 =?utf-8?B?QzZscThhMStPWEtFNTZQRTZCM3N6VlRPMVdEcWExNmh0eGpMSGRDUmZjUFJP?=
 =?utf-8?B?R2tleG9qcTFYeVB5TlB3T1lFdllxdTNTMGZzalN3cU4ycWJja04xS1NVWUtu?=
 =?utf-8?B?TFVyRDZnOTRVTndDSjA4WkRFdDJaKy9UdkdRa3BMczVOWnAwdlJicUxpZ09h?=
 =?utf-8?B?dktiRlFINjlHWEZ1K2FMUlZsbFZtdTJCZW9KdDVweng2NUlGa2JXcmxUMGFk?=
 =?utf-8?B?bWFXRXVSS21KK0Z2RlF4RjdHZk53MTEyR0xNbG0waUdIK2FQamtRMldtZ2JT?=
 =?utf-8?B?N0VGTnQ0bFdsQ01EOHNocDZrUlNHcXdCWk1USHk5dUFnWUpZOEdacUdPb1ZS?=
 =?utf-8?B?UXBkalQzVFZUT2pDRURnZ21Ta3pjckhGNytsUXFDdUdQcFI2WEN3dENPS1Vj?=
 =?utf-8?B?YXhnZlpRdEJXLzhRdnlKMFEwM1pTOEZneVpPR1haSTl0c0JHY2NqQ2FISUpL?=
 =?utf-8?B?bDVEYUZha2JkRnBIbmtJT2k1Z0EvczBYYngyV1Rhb1FWa29rdHNndCtXYTBT?=
 =?utf-8?B?bmxNVDh0bWMydjJPWHJWa3FjdXNEcmY5RDE2ZG1CVFRYWml6cldoWG1CRnc4?=
 =?utf-8?B?T2x3OUppTy9ZbnIwcklOTVF3SGgzdDQ1bFEwYnFUbWJDRUFPOVllUVM4eWhI?=
 =?utf-8?B?WVRiU0k2aDBzR2UyN2ppaUtUcG9KYXhMekNsbzhEN3FXeGhBQlVKZkVIMzMr?=
 =?utf-8?B?SEJwVlRsbUlUeDk5bjZUWVM0cWF1b28weTR2aGJrVlNPNWxFckE1R0V0UEl3?=
 =?utf-8?B?Q0RWVDdTaWdac2NCVUIwNlBHWUhFYk5YdUhNdWhKa0ZnZEpMVm9jUk05Rmx2?=
 =?utf-8?B?b0kxUVBPUXZlWG9NTjYvamRZaUJBTStzNUFBVGFXUTcrbDhUVURVeHl5ZkF2?=
 =?utf-8?Q?dYf+Ps5mfoOYChm+GFIQE5mg3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fJtQpWYTLWhn9KmCiP996eQAkUOvatLY8dq5e0uesx33F3xL5yNDa/K5+dxbkli7fTvoDSM8dOhp5OlH9J6K/PzIBDO1BC6JNadwhHYBd7F7H/tWQeM2mZCJBCHep6OjwcPeUXk/g5OLN+AJE5xeLXDOb1aGO9XGiv/Y1CgDembc+YpCXJpVYGOekns8tj3IZQ8ZETvDj2PbN/DcKr7syKdq/p2v+b/ItZnMTpLkDMnCDsgLL3QRr9/LVczQ54FqH+IpBffwCGC8LyrhwZvynuAzYo0fSwyJF6eOs6zd1V9xD11kIZGkt9zft8CzjYl3wpYo1g0MCdsgMMxC3HKtSbCeLQsPkOJTkiwCVKdtfLv9S9EdkQci/iiUWVVlXjEcZ7oWftKTasCkJHgr8+j6o0mLFdEEuEw8K2INMu0DVjwvJ0Vx6LkbK2gDH6gcnELJeZaOASR/EYXnTLSL544z0ZqnwYBcK7G9Ee5TOKCuVUz4YNoIQaoQrQSV6SP50qmctjW8elEtmI4l2bxZyRrA3Ai5GT1odFYiXscjXF+L5p9tnCRCPr3PNnz9116A2lbhKHBkk/paP/WACTTfYdkDs9pZUFZaw/aV/NYk9XJvjUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5db7ca1-ee11-45ba-50e6-08dc7ef788b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:21:19.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6ExEWnNiWchx7amEsV/M9DVG3rhJVAlIqALYq9BklUXwFvBTXYwdKGrcnYLA52X+6borJ8ChV4CDVEPDhjhlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280069
X-Proofpoint-ORIG-GUID: UeDExh4DSpT2Dds5o5BV7fQrLUocXVWe
X-Proofpoint-GUID: UeDExh4DSpT2Dds5o5BV7fQrLUocXVWe

On 23/05/2024 13:59, Christoph Hellwig wrote:
> On Wed, May 15, 2024 at 01:54:39PM -0600, John Garry wrote:
>> On 27/02/2024 23:12, Theodore Ts'o wrote:
>>> Last year, I talked about an interest to provide database such as
>>> MySQL with the ability to issue writes that would not be torn as they
>>> write 16k database pages[1].
>>>
>>> [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
>>>
>>
>> After discussing this topic earlier this week, I would like to know if there
>> are still objections or concerns with the untorn-writes userspace API
>> proposed in https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/
>>
>> I feel that the series for supporting direct-IO only, above, is stuck
>> because of this topic of buffered IO.
> 
> Just my 2 cents, but I think supporting untorn I/O for buffered I/O
> is an amazingly bad idea that opens up a whole can of worms in terms
> of potential failure paths while not actually having a convincing use
> case.
> 
> For buffered I/O something like the atomic msync proposal makes a lot
> more sense, because it actually provides a useful API for non-trivial
> transactions.

Is this what you are talking about:

https://web.eecs.umich.edu/~tpkelly/papers/Failure_atomic_msync_EuroSys_2013.pdf

If so, I am not sure if a mmap interface would work for DB usecase, like 
PostgreSQL. I can ask.




