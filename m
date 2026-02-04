Return-Path: <linux-fsdevel+bounces-76341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL/RKsaIg2niowMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:58:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799EEB492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF063051282
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F13AEF52;
	Wed,  4 Feb 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XyNSpF3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OrHIqrPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B343491D6;
	Wed,  4 Feb 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227660; cv=fail; b=LOSBOc9G4CrCmDy2fcn1GNiq2NtoUzp3+zWefWWChXkXFd8ZcEo7ZEWwefuVMdEIZNkW/PCy4KwumyBLtGsJJc7MWbSC4gItJrnV0htZX6gvFVPOr3S4cWfKn6qNS/osJ3jKetgqHWFF/G5YgfDkCJJuAZNnaUCkowgGQ3/Wmxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227660; c=relaxed/simple;
	bh=qdO11vBxew7k7uj3ndaAiFTGm5mHuR5btXWvO9V1U/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCVEgkS4z+ZGMra7xzzn7oHw/dn/gyESWJgD/ilJlUzhhV26rM81sSK3MUHU0uaWEc1RHpXo4KRgal92uNyaSdGX0kLuM+0BptzK4WUslzG7Ool85kT8PiAhuqjeJtxIUt3eEmgugxaYcAKLwuROKGMtZguKN69vTrlQ11N1rFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XyNSpF3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OrHIqrPZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOCbS2399263;
	Wed, 4 Feb 2026 17:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j0k/QOH3BfNEVBCkMBZk03VVCgAZdUWeM0fY47sKLNA=; b=
	XyNSpF3ADrDL2sOHw70GSa5dGV+Y1NZahXbM2g9i4H/27IObGZhQ06hF8PvYmIOf
	VVb4jBtm8RivIGZ4s/R2HX839ZpAvoEFUV5dKfgK+reP2S0HtNN9D0RMorBQnPoJ
	QUibq65nWnEj/x4J1ScvMW9cl3ChTvxPW586mRisbr8j/ZJngxfn4Tl2Bj68uisq
	aSCkcqKFmYXOJq2ZZa+raQy9KWHT8JNkASh4dYcbjSepx/mfuLUuGpCWh+aPbTal
	7IPuVACQOc7oDojGDOPdLmr+meZKtbV9uekb7nHHS8zLHVrsdlSQQLHHPrqe/GzA
	iSJYNHAfq8ZJV/dsBWh6UA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g284q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:53:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614GQgI7034752;
	Wed, 4 Feb 2026 17:53:44 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186braa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRsTGYnIkKDjh5FLX1ZdDxKVdA0UVp/XgzkIV/G6wx7PCy+yIW8IknCIt/hfl45B1YX1rvGrAZEm7WNUY5NugNIONHRyVjvMjCzk0G1mwyvEC880o6/x1eY7AvGDN6KL4uQLsbJSfJ8QjPNoaofLDToa/jJnrNAZEXGTB6tHUvk5ROQKfbpAm9SOxOluOCTF4KHAirtEo8NJfHmnU6XOkWD77oQGIqnVdmjmPPhkRneFLpgK4GmuJaFmBrfB2JAlF91PbhHqg45ivjmQLsD7CYPl6b0DqUODK4COLx6ZvGDxTN8FLzLEpFx3JooWasnuAoDgtrt28BJBaasU+b2LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0k/QOH3BfNEVBCkMBZk03VVCgAZdUWeM0fY47sKLNA=;
 b=Ur3EJ+1e1o1PU57ySZMRxYqnMU8MjP0+8Z9wDvo0jJigYP9ZeRE6lOfGjuoSFCK+Y5aEyfLjzIwSwJJNDOAje+vAnb7zk+jt7t3kyH7/Y67EBDakAs9IM68HcoVXAN4GTR9orc3ecgRV8h62lnyZCwzj216OlHZ805TIWWRVsAkYgDQ7P7tGw9gZX8lx00qJC5QfxP2QPs6cKJHjpLvFgxI36vPBz/D2fyJ4PxNwIXYGjrRwOuhGMP9y2BOwocej1oZ1jvKIy3egqMAKsUhl64/f9+AR3MJft20DXflXWC1QaANBFSLtzJ6BPFYIPQVSxS+w2deSGlDyjKakHnLRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0k/QOH3BfNEVBCkMBZk03VVCgAZdUWeM0fY47sKLNA=;
 b=OrHIqrPZqy8crvHXXwiGCWPooMNf4DCgEQjRRetEitJZUiFfk/rtqJU8wXnuv8X3WJIqjEFeeSn6s4+KF/U14uCSHpXAFXSjff5Yz87pbxMB3TXujYwdeMjHmImLex9USM7nwGGaLJ/VYh/jOAPWR0l7hKXb/atVI/2mzQD39ig=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 17:53:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:53:39 +0000
Message-ID: <5c4927af-120e-4c6b-9473-95490f4fcc90@oracle.com>
Date: Wed, 4 Feb 2026 18:53:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] selftests/mm: test userspace MFR for HugeTLB
 hugepage
To: Jiaqi Yan <jiaqiyan@google.com>, linmiaohe@huawei.com,
        harry.yoo@oracle.com, jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de,
        rientjes@google.com, duenwen@google.com, jthoughton@google.com,
        jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com,
        sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com,
        dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260203192352.2674184-1-jiaqiyan@google.com>
 <20260203192352.2674184-3-jiaqiyan@google.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20260203192352.2674184-3-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 3872af7e-c8dc-40d3-b6b6-08de6416540b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFZVNlhyaHU5KzROZ2Y0dGlockFhdy9yT3ZLekJVZ1RYVWc5WFdORkFVaWsz?=
 =?utf-8?B?MUhjM3VxUm5JYXN3OW0xMldrOHpCeDVLMW94YllKMm1CN1Z4YmNDS2dvTXlB?=
 =?utf-8?B?T3ZqS1NQQ085Z29GMWhHUHhZU1Y0TFM4V1RuMklNQXViZDdCN2RXekdwTHJX?=
 =?utf-8?B?UUJhL1YxWk1PRGpjNE9HV1psT2p4S1JzSVZlNHp2RDJpOHpNcGVBMnZhZVZS?=
 =?utf-8?B?dFpJSnI2aDBTenRJa0ZoMWdZTHZBSWg0a094QWd6YU1ZWmtOVk5iYkw3YmxE?=
 =?utf-8?B?RWhRUmhoM0gzVzhUMllmZHZIb2FSOEEzeTVUUXNGNW93eU0yTTU3MTRHVzZl?=
 =?utf-8?B?NHFpZnpvWG9nL2xuSGxERHpVd0Y2SW1aUkh5MFRRQS9uTy9tU2VkOFJYOE9n?=
 =?utf-8?B?dkdxdGRBMHQ5aGpDV1Z5R2J2bmdHN3lJUkN4ekJHUnAxWFQ1bCtYaEtHd0wv?=
 =?utf-8?B?VklmK29nMGpid3hla2Z2dS90R21qTkFsY0d3RzJnbjFIRzRPVHlTMUdJZCtI?=
 =?utf-8?B?eFNhVEpKQUZFTUo3VG1qUG8rU2N6SjZFa3lWNlBhbEQwWVlSbjZRVnBpdEND?=
 =?utf-8?B?RVFKSlEzNHFQOWhCRC9uZ3J2T1c2aExmNW1PcnV6eWRma0pYZ0gzeXhtYWVE?=
 =?utf-8?B?UXZLTDlOOG95a2M4c2RMWEtXT0k5bmxPZ2dxdXFmVlVaanZLSnJldVBEdjFy?=
 =?utf-8?B?cVZuWlhlaHgrQkdKZCtYQ05rNmxaU0JJcVFOWUw5KzZJbjNVcTNoYVZOR2pr?=
 =?utf-8?B?bEtMR2x3aTh3S2lkaFlXZklQdllCY25pSm5iOWpBakw0SHhIWm01WHpxazVm?=
 =?utf-8?B?dGZkQWdBV1lzZUJyUXVDN3dMZWYvc0sxQ3RCR1FwdlZFSzd2VlJsUzJDN1U3?=
 =?utf-8?B?YWZRWE11MXVZeW9VOFBMakRmdjVPM2xCb3R2N2RCRko0MENsNWYzTTJCbHlC?=
 =?utf-8?B?Y0ZNajRJVDdCMXoyaUVqclJhOTJFNlZER0lFRHNreXZqOUxQb1NESnVXL001?=
 =?utf-8?B?ZVNsYUR6RWRnb1BFZk5VUFhRSDFwdTFubE9zVWhHWVhvR1BTRlIvaExocG9z?=
 =?utf-8?B?S1BxZk9xb1NhZHQrY0NKci9ld25FZTB4QURwUmJnUk01ZFgzRlVEUW5RTzRT?=
 =?utf-8?B?bk1BNXZpZzZ2ei83QWxZVEc4YjBlN2w3bzZpUUM0RXFXN0xXdVNZcGM3Rk55?=
 =?utf-8?B?OGVzd3NhclJQLzUrS090QUFVTXMwMVkwN09Fb3B0UGlSYVJCNkRBelI0L0xJ?=
 =?utf-8?B?eG9vNzEvZEg4MHhkbkdCZzErWkx4MVlXd3kwNlJsZytJRnhZYUR5Mk5tNjJI?=
 =?utf-8?B?R3FLdEpIajJpZHFnNG4rdnJTYWhoMkF2YzRjL3pUeUVrTjZ0Si96VnZnam5P?=
 =?utf-8?B?dWd3OUxENWtSbC9xY2xORTcyYzZzU3ZqUng1YUpHNVYrcno4OHFIeTRRWUQ0?=
 =?utf-8?B?dk5oOFNyaDJVOEdZRFFua1Q0ZnA5NzNmaHFXN091RktkcFZkS29ESFc4Rmpx?=
 =?utf-8?B?QnRnYzR6OFVCbE9VaWtzL2ZhVlJFR0NUaWM0YlBlMzdDanRTcGQyZHhmRWpq?=
 =?utf-8?B?cnhrSzZaVksyZ2pFQ09qMjdYU3FTRmwzNXlJSVRsYkZNMVZ4V0ZiYUZaZE5w?=
 =?utf-8?B?R1NIbU80YzFtZ3JNbkF3amk4aEk3bjlKN1JUV3grcmp1RGUwcHc3N1hxY1du?=
 =?utf-8?B?dnltNWtkSlRHY0hSOFo4UHo1VEFnUitFeXl5ZS9qbkRqT2p3N0R6UGNhM21y?=
 =?utf-8?B?MzltY1RIRHI4S0VXZFhSQkJCYU50Tk9ITkpZSURVcmJrQjYvbFJScVVZUndl?=
 =?utf-8?B?d3BGME1WOFAzSkRQcFF4RGdSZHdSOC92N3oyc1RXNjF1NUpWdzJ2R1FVYnJs?=
 =?utf-8?B?b0xiNEozamE3YXJTU2haNlNvcXJLL1ZmbDIydzZLcS95YUI1Rmk3VXBjZUVT?=
 =?utf-8?B?Ui9rYjBocjlDR2dvNUJRdlJEVGVmVkZYTGJSRnFyZytMSE55SEthcUJPR3lJ?=
 =?utf-8?B?ZzY3VTMvYzZFbHZjWS9oSGZxMFVnUWJaTkxRK1NNRVZaM3NpRWxDMklTNFZK?=
 =?utf-8?B?WDdrRGE2TUNGcklScG13Z0VFRkVhQmJocWZPZDhHT0hrUUp4U2FwbzlLcHk3?=
 =?utf-8?Q?xY6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnVTNFlGR1FhZjhZejFBNWcvVWQ0MmxqdGxxeFg0blNSUWpEazV1ckFyYmdl?=
 =?utf-8?B?THFSRDZhV2FuQmcweHFhTE14c05rRncreXVFWkhrQXZBVjYxTmlpcGNRM3pU?=
 =?utf-8?B?Ri9TaXF1TFhXV2Erb0tOZk4rN3NJUDVhcHJwdS9nQkl4Q1NuYlB3YnZOWG9B?=
 =?utf-8?B?MXk5aDJSUnhWRlJoL3Uxa05SbDRjaGdOdUVOaUc5bHlwcXF3QzRkc20wT3B6?=
 =?utf-8?B?UW5NdjlpK2l2R1Q3dlJLcjkxcUNtT1hQMlBGZlVMU1V4SDBXTFNYSFlPMnMw?=
 =?utf-8?B?a2luUmpkTzN0bkh0bk0wbUYyQUdQdFVoZWNGNDAwVFBnZnFyd0F2WG5CYW0y?=
 =?utf-8?B?Q1NBbkVVQ0FvODdtUXN6dnJEL0ZLT0Z6eG1ESmlybStKSlh2TUxLRTl4emdI?=
 =?utf-8?B?SGtrNHI5WERmUG1uSVZBVVNZcTgzdUNNY09ucHBpRjlXSWFBYldtK0JjdGlh?=
 =?utf-8?B?eDRWVUZQa3ZlbWtxd1VBK0xMZGZaMWJrNjlyVjVCR2wwSmY4UE5EeENwMTIz?=
 =?utf-8?B?SDRXaTR0ZmJkZHJXY0xpN3packdZenRtRmJOT0syRVFtODJ3dU52cDZPbGcr?=
 =?utf-8?B?MkZSNThEOVl2SHBNejhEZDNud1VSMnRjWk9zTGxrYTc5cFFkakZGK3JwZmNz?=
 =?utf-8?B?K3QvUDYyUGtqVTZvbW9UdHNrWGpFZEI3L0o2bzZ1TFE0aHYxb1BvRlVyTXF2?=
 =?utf-8?B?bVFGdnJlMFJVWWVDVnFwRHRkbWRUbEVsZ2VpQjNSYmg2a09wUUJaSnRIOUM1?=
 =?utf-8?B?Ri9JZjJEaEkyRE8zMUk0VnhEeFhZOXl5d0R2TzNHWE9jT2pEejZkZndrSjZm?=
 =?utf-8?B?T1d6dkgvSi9VWnorR0dES2xidHFEc1hOZVBsVGpDblJqUlZMVjNHU01Jc3Q0?=
 =?utf-8?B?N3RDSS9pa3Z5ekdlTmN1V2VaSnlpUW05YkkrQmMwZEUzQUJqVmxhQjAwemFp?=
 =?utf-8?B?cjZOQ1QrdWtLaWRITUtmSENNNUlFUHRSdVdBRFMwaEZzNW1tQ3FEUDlrRDFD?=
 =?utf-8?B?WmpsZ084enQ2bkJlSkZpeTM1Mmw2VGhWS2w0KytqdU9hZXJPL2E0Wkp2OXZz?=
 =?utf-8?B?ZllYTFNmOWdtVm1QdllPdEY1Ym1LTUJyR0RvSTVTSWJENWowbzgwcXVnYXMx?=
 =?utf-8?B?Yk13Wk9zSU1TbkVIRDRHbG4vYWl6ZGF4QTJsYk5QZlFsTGp4VkFDeGpFNDZU?=
 =?utf-8?B?MVVwMnNYRkprdnprV3F3eEdpRlJ4VEpGZSs0aWQ4ODl6N1hvc3VTRUNzZlRo?=
 =?utf-8?B?TysyVzhHd0pYUW9DUTdDSHNYUitlSEY0WlRkU2pxcGd6UmRWUWYrL21Rd2Q5?=
 =?utf-8?B?dHlscGtFK240RDJldlVScjJLMGdWckg5d0NQY2JFc2tVdjFMNHpnMGt5MjJ0?=
 =?utf-8?B?Q1o4Uk16SlhWdExOaTlhdVdmSWpLc1hnMFE4dXY1eEs1NDJ5WHZROWcvTWlQ?=
 =?utf-8?B?V0kxSHZmUEZHNVp4S3RiZGx3R0JSTW9hVXBzYXdMZUFvYmxiUEV1blBDbllJ?=
 =?utf-8?B?Y2tiZXlmTXB2cllqVjFiQ2FyUzlNdExRMjc2dnFzV3FsUDNVcEhQT3FNL1BV?=
 =?utf-8?B?a25kK2hhUzVIaWp5ZVRFSjkzSGYzbHBZbFVYVzNLSVZSejBIanYyZTVmbUNi?=
 =?utf-8?B?U2w4N3RpV1o0QWlwc3RiaCtsNmxUK1d3N2E2N2dDeUlaaENPZGZSQ1FXY0tZ?=
 =?utf-8?B?Rm1lTU5VVHNUckRNWlpQSkZ5QTZzZFpaL0o5bGp2NGQxRHFyckFZeUVNVTMz?=
 =?utf-8?B?enU4ano2NWR0Snk5VmZqTzdHMVB5djl0K1VWZER6OEJyeXJVMzVSM1g5ZTRE?=
 =?utf-8?B?RUs3dTRPTDBlR2V5TmVwdldOVlA4SGNUK0trT3VSeFlNVGxPM2tQQVJva0pY?=
 =?utf-8?B?RStnUHZZSEY0RTVlQ29WeDJWSTRzMGpkendUdllseHczLzV2NmtCYnpSS0Zj?=
 =?utf-8?B?NmdmWmZRaTlnZjh6bUVIdlRUYk5CelJad3NVVkpMbXVneDJGSUpmTDBVN2dZ?=
 =?utf-8?B?MEQ5bEZiMUF4WTBlazFMYlJYallaeUlhWHhZK1JCYWJqZHk5VkttQjN0bnB1?=
 =?utf-8?B?cW5aOXNySzNKdGkxNzlyRHlTcnZpaWM4SHlHaEtVK0o1T0svaVp4VWZiS2kw?=
 =?utf-8?B?SlBJOStGRHFrR3k3a1h2L1VRSUpBL0o4My9FZmYyeTJhY2tINTBvNmlkM0gw?=
 =?utf-8?B?aUFidXR5YnFadWp5c3RiQnVqcmFJNENyQXNFN1hLYmZIZmhVT3BGREl4YTVk?=
 =?utf-8?B?YllCYnlZNVk0SVJBVTRHbDdQaEs3Zkx4Z2pEU0x0UTFOUmtrOVN4dzlBcFlN?=
 =?utf-8?B?ZkJ2VnNLSG50OXV3Mm00dkY3ZlRQYlZiNElRTWFsSVhQWGNSSkJTVWFzWndU?=
 =?utf-8?Q?ubYkWPkXuzB13J30=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RW9Vb0WNZG0ZaqiR9WmVVK0LWymOUq0ANoCSGNp2leJmmYjUaZveNG30ijbTCLSy4JCKNqZ9bn10zCHusr28qKQFbM/1fe/SYxth0X0Ksp6BWMYpOM8pReyO+1wxlVL7fPVBCcROmyA8dyKhyoiccBwx/v/853UWNmLbTbmQQvbmdmkptYMuJJypWzkyb4U3UN8iIiiPL6WTmhhqqX6R21SJbHXnJrPWT5Gnwg7ZMCTno/0dDjZTA6yc7/1xggHTvH5QZnTVHSFJF54zv+waPHUyn7BQW7d9OAT3QT+zZc/w2A09Iw0CNItP1HoTNOr5IA3pF926o0BASHpiSVoN5Tp2JHNUdgNSPQfRSQtY66GTAnbgxKWNSMBLaN2kQLaWg1K6At1l22if7IBoAc9QwoJLmSvK1zKCNYmx2Cj9CN8Gb5rYixx8PGoYmqMC8kaQwrFTgYGotWoxHuVnc+pyRO2EyHd+hCLOt8liGBeEXQZyrk3jeKMB5arNLOv0/EzLUKagDotzMyXgs8hu9KL7LjS+rOg1fk8M/tzY0pjkMsoI+FLrYgC/Tm84Qz+Fpf0pWBjsZKPQVXEqMxt7Hgpy+wMrxBpPQnfjaoT4ZEkgFTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3872af7e-c8dc-40d3-b6b6-08de6416540b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:53:39.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTK/7aSKg5HoXwaX1I3pyMsOQOud/O9EauVUdTxv2HDF/67EoH5GPV3yCabaiRqP18qWzOm7L76LJS9xHhGN7FCZZmXVHqfxxlyksmMO0WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040137
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=698387a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RPCY27dO5dzBdz2Q0pQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r17K9KHQJIhcDGzsAKxgXohNCHDwiB3G
X-Proofpoint-GUID: r17K9KHQJIhcDGzsAKxgXohNCHDwiB3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzNiBTYWx0ZWRfX/bazXmjqzP0S
 s0LfWm/aeqW7OUH4oKd4ikDBEHTRZ9U8oJMQGLfr2XP5wmGSBo9GCaLL5JZDjZBU/K6pUqyRDD7
 7cn/b6OqiwMt4CCqGHM8f9w7blkm6Jg0PqmGL4JFjb9cVN1z/6onv2Tz0zVLmR63vme2HO4hOIt
 piQUpd7jDiV9/gRBVLmmZx6jQ8wnrUmcF/ps2L4S4f5dt8kRzUGBYZKbpY6p0Mt+9yqv7RjJ9oS
 PLC5dsYQnAV9XNQCtU+veA5d9s0hp4lQhaI63IzOc6B0ohqYebXqOeVIf6cNBcvwju68hyR3Yxa
 9g8Bu8zZ07TrhLnDc6uZ9rlhy/L6dDrw+aLBv3/QNpzKTnug4yJC2ae+lCLav9QYSH2sznl6rV7
 l9nCeiymP2JMYLye8ldhpd/CZzIU8lzlNW2+O7QPr61a3+4fN93fHOZv1JN6T+UZLabLYZFDrKn
 z1z7GhhvJgkJMawJB0A==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76341-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0799EEB492
X-Rspamd-Action: no action


On 2/3/26 20:23, Jiaqi Yan wrote:
> Test the userspace memory failure recovery (MFR) policy for HugeTLB:
> 
> 1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
> 
> 2. Allocate and map 4 hugepages to the process.
> 
> 3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugepage.
> 
> 4. Check if the process gets correct SIGBUS for each poisoned raw page.
> 
> 5. Check if all memory are still accessible and content valid.
> 
> 6. Check if the poisoned hugepage is dealt with after memfd released.
> 
> Two configurables in the test:
> 
> - hugepage_size: size of the hugepage, 1G or 2M.
> 
> - nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISON.
In this version, you are introducing this new test argument
"nr_hwp_pages" to indicate how many of the pre-defined offsets we want
to poison inside the hugepage (between 1 and 8).
But is there any advantage to give the choice to the user instead of
testing them all ?

As a suggestion, should we have this test program setting or verifying
the minimal number of hugepages of the right type, instead of relying on
the user to set them manually ?
And at the end, should we try to unpoison the impacted pages ? So that
the lab machine where the tests run can continue to use all its memory ?

Thanks for your feedback,
William.


