Return-Path: <linux-fsdevel+bounces-31617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F083998F71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00CE288436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FC1CF282;
	Thu, 10 Oct 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8QwXjMh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gv+awMzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFD1CCEC5;
	Thu, 10 Oct 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583724; cv=fail; b=oN3IH7VD/K+wfZqGV2CgKdkjjS7udaGbnFdp/bIImyZey5y5TrrbsPhbbawggZ3Wsaxmj0CsevAIlXPoXvqKSpEwoKoF/+NULieWAw7A+ZJL7GtEBYqVGe19mPCKB57ghr+Z+G6FJW/Rj4Qy/Bg/VW7oeikNvVEXI9NGb+bMy80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583724; c=relaxed/simple;
	bh=ez4aDYruU8HmJYNv/CmJvaESHUpGqaWJ3irUn+6ukRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dB7JIbFud2nWcJgb+JTJwemwKOZAQvRAjFw45ElR2vNbo0zMogXBf/IfsCZBbZBLJyDmk48F1g9yGXoL4UBnLV7Zg9dwm6rO/MeDndwdlM8VytzZi3YAqK0g7t/XdT97D5tSmhT87Wl9zODSBPCqMfVfKBmn3aoGkt5HBWGQyiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H8QwXjMh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gv+awMzU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtd5s008750;
	Thu, 10 Oct 2024 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uewwcW6cLjkIKzoWqNTKD3HGkmz0QnKa9U8kSaUEkhQ=; b=
	H8QwXjMhMmwjkNuegfVq+yvr56+Mw0ukfSRYFf65chzdGcMPrLMVdadXSNV2IMD5
	zOXKrco5p635vwjDTGwBEYYU3PqlpAgmmVMSSeTOE89e2anti64kCLOAghp43l0t
	3XQowAAkAGYgU7/nFpMwkbf1jBO5OlNwzb9x0+998mGp6N9LJjDCg8tv/fXYlmUz
	NMk+A4I0oOnCpCWg+rxL3N4GmboTWBoSCkXZ5GkNiQQL45XKtsmiZVqT7n7s1/BW
	ipzw/2oQ55ZGMCtLy2QS5cCzjtq+/Uc+PgAe4pOeDzSCgbuZVt7hWD3vOpm6vdNw
	AD+Tn6pEksDgdm163Vnnqg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ykd0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:08:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHHQeP005855;
	Thu, 10 Oct 2024 18:08:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgq91y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqL7WijC0m5xELjCZRwL7snUlbg1dyGS6iV3OVOTbtvjo0BKG9T6PRpRHDNq3KNb8X1050hs7CklE7TPTR67y5IRKBxiNPx45DRMvIKoLYwoQDYmN7bBE+NHMQ0mjhUiPBmSyXrWSKD6TKwqJVfzgcxteBDurh2nA7SWHLg/TL770keDZBvfYedpvGNxvVfXTrw1Lmv4/xJEvNLXVxRSwnUKvmOS9AEiLaA/Mc+t2LOKJE4H69lxV6NVuPvkHV+6agG5GAvgqFnE/Q/Of8NCv4zhpl0tp2L8GhEXOkQs9sUF0pYf625CtC0pPFhfH/5JYt1XHKOooXKwBsDBmePbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uewwcW6cLjkIKzoWqNTKD3HGkmz0QnKa9U8kSaUEkhQ=;
 b=KyEzKvejVQuxL1IKAVLGq9OK/+bQkxOaUl+Yze7895D5NjB9uRssbFloN61Uu96P20odD4y+kOdL5gnamRjRrPUNEM+9MOEGpvgAIZXj1/hc1Lq0T6fC3dawnMHIES2ws9D6gFwxwt7lzh8bVoO0PfzZsG/XTSwZKUnhzDxSjxzkduMq0wTRaQALPbyESnu2OxqiwP72/E9DvsCDSByHG2YpVjxyJ9ODqMUxOl5vPOVgFoKlSbMEvrJ38g3M55ayqzDHXTPKJd7IGI/1ORtN/IxVtBokykiGvZSr9gkx2n87P0Oc5QaifDjX59EpPgRhhD18SsAbRIFLABqetEeALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uewwcW6cLjkIKzoWqNTKD3HGkmz0QnKa9U8kSaUEkhQ=;
 b=Gv+awMzUet64LjmAykTqA0MI759JXI9tezird4RMcVyexQE461hOD+eX3JG84Q4aA5o/GQp2GMXOUHg4C8/6I8t5CkKHjtfxAVbv+G9pfvPFD7cnufl71v4VCxbw51BEJgzH12InIwZVrBpi66ZIuBvg1QL1klbyLwdnqm3KPc8=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by SA1PR10MB7831.namprd10.prod.outlook.com (2603:10b6:806:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:07:54 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 18:07:54 +0000
Message-ID: <afa2eabf-e13f-4742-b27c-588eadca2600@oracle.com>
Date: Thu, 10 Oct 2024 14:07:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20241010152649.849254-1-mic@digikod.net>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|SA1PR10MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: b7829b36-aa97-4315-3493-08dce95676a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTkyaWNwL0owNEJpVDRTUE1EZkpOWUVMb0hJdzAvYjNKWTBIUE5LaWc5L2NK?=
 =?utf-8?B?c1dBaGEvR0diQWtNSVBjZC9BQldSN1g3QUpNQmRrWjI2N1Nyak5HNnNFT0hp?=
 =?utf-8?B?ejFsZU94Nk5HaklUL0N3ZVI3U0FWZGNabndEN1NuRjdFUjJXdEkxaHh4dTlT?=
 =?utf-8?B?QTdDdVprOHdQczBXN2dZamp3M2RnRUU2clB0LzNyV2V1OGk1aFlOdlB5bURm?=
 =?utf-8?B?K0Zxc0tZSVgrUVRMRlFDNlFtZlpzK1dhejNtZFVWOXJCWjZWdHEwMTcxM2FC?=
 =?utf-8?B?c3k4N25tWDQzVDk3dTB6ZzI2RXNpSjhGTXhib0Qxa0JpeTFFRDBQUncvUEVa?=
 =?utf-8?B?ekd1cVg3OUhBS3BzdThXL2xadUhlTzVGSUVMYUhLbDZuWDErMVU4OGNqSFRU?=
 =?utf-8?B?UlFaMllJRzBPRmxnZi9DeXA0aCtwNS9GaUlmQ0laVFY4dEZjdzJtdTRJQ25w?=
 =?utf-8?B?NDBUK2F2ZEphd2pacFpWOXJQNEV3cmd6Z3lRaSs3OE5iUFltNEZ3K0JZVWRO?=
 =?utf-8?B?RGhyOHpNRzJJNkN0QUhyUGZpbEFvYmR1d3pycC9xVFpGcG5mcFhuM2pmZmVr?=
 =?utf-8?B?b3R3bzRTSW5ubGhFYmluRlRUQ0NSZjZWMkVmZmowMUROOGNtbjlUZTQrSUY3?=
 =?utf-8?B?dFVnbmVYcmFPVzQvbFBzMVVFQnpkVzVCK3NvVFZMK0Rqd1VMdmtMc2lmUTBM?=
 =?utf-8?B?WUUxL0QxV3RzNVlNL08wVjM1TngrekpCNWlFc1pjVW1DM05jWFV4UnBDdmFL?=
 =?utf-8?B?L2k0ZjE3SWIxSFhRbnJ0elNwdzNtV0FMZEx3UlFNUWxETXZraEZiNmF2N21y?=
 =?utf-8?B?eU16Q29nVFZlMmRTTE9uY1c1Uyt4OUErTjRiUVU3RGw2RUlyQnliYnVDbi96?=
 =?utf-8?B?S2tEUUZnRWxTamRUZlZvVkR0a2NPTHFvY252dEs1M2NEKzM2WUgvRlNDNzVK?=
 =?utf-8?B?SDQ5bmhUd2luMm9qNkdiQWZJNFZISkNNWEplOHdiY0NqcHczRkJNZ3d5SnEv?=
 =?utf-8?B?OTdBZjJuQnRZTXhBWHg3MUxJcFlhUXFhNloxcUFUZ3hNY0YxRWR6SHQ0bS9n?=
 =?utf-8?B?b3dWNTdwN1Y5NEJNczkyWmRFelV2WHprakN4TnZTanJjUGJZOHJJeWZCcjg2?=
 =?utf-8?B?VU8zc0J4NUd2SG1pUzJaVzFRaDVEeVQzV2k1ZHBaaGRTWm5MRi9XdE5ORnJq?=
 =?utf-8?B?OE9HQWt5ZWFmT2l5dWhsYkVRRUwvd1BZb2E5UzBvenJlb21aRldhcVF5OU8w?=
 =?utf-8?B?YllWZjRueTlOd2VHWXhzb01RTy9IVzQ0SlBrUytIa0ZQL1ptZWpPMXBoMUhU?=
 =?utf-8?B?K3plbmlyUWhRR09EZCtFMDAxSVpIcHFjOUlLakhGMGpqSGN1SUcvUU9tU2Zr?=
 =?utf-8?B?NzFRQ0xTT1BJcFN6eEtPUHVJZXF3RnpGK21jRE4zYkV3ZHNtVWhJUkRKL3pQ?=
 =?utf-8?B?Y2V2UENXdW1HdEdYQkpaUndKYXdNRFA0ZjdJVk9TY2pRZ0oxVDhCdmhtYUs3?=
 =?utf-8?B?d3J2dFdNdk4za0txSlVpK3Z5cmVoc25OMHk2TGRLRFlPdm1YN0NnUWdNMFlt?=
 =?utf-8?B?YlJXMFpncWgrbTFQMElVaXI3MHRlREsvajU0SUZkRmJHQmZxc0wyUWM3UUFa?=
 =?utf-8?B?R3oyMThWazBQODhNYlVQaWQzVHpMTjBuK1czMElCNXJoWFNQYzNoYU9jRjBW?=
 =?utf-8?B?elBMNkdmeHJoTHlYMmZQdlhrcDZTRzFqV1pXaXhtRGczMTNiSW9wNzRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ZUWmNYOStjYlJaVStpSllNNWprYUw1MWViNVMyeC9FUkR6cWlDZVlzUHVU?=
 =?utf-8?B?RFNEZ1VQdU1IdzlHN0RaM1cwVTNyc0hBMi93UTlIejlzY2p4aCs0ZmJ4cHRn?=
 =?utf-8?B?QWpIbVZZdGRvZVhNbnduYUFZN3FGRFRmdDFBOElELytwaXlqeW9jT2F6M1da?=
 =?utf-8?B?WjRqd3o5ZHIxZytTSW1OMnNpVlFVSHFEZmZieGZWZWpSMFh4Z21tVm4yU28v?=
 =?utf-8?B?Um5oR3Z3SjllbmdyWVFQQ3VpbU9aWHZOd0k0czJqTXJrRWVDSEdhQzVlK3Vq?=
 =?utf-8?B?cHVlK21RSTlUNlduM0dQTC9nU1BaUUw3NWVGOG9jbEJsRWNJOVNuM1c1MG1P?=
 =?utf-8?B?NTY3OHo3UEhCMHpLdVRleFFNZFBXL2s3MmREeXRHeUx3eHBsNmVJOWV5MGls?=
 =?utf-8?B?aXllNEF0bUxxakpTdmRldmpPNTRwYnYrWTR2SGQxSGxxNzk5UXpWMFFJVHJi?=
 =?utf-8?B?dWlEcDhQT2Q0Nm9UNUZoVnlrbEtSTzJ3Z0JQbGlWT3pTV05aQ2lqbXExRjlK?=
 =?utf-8?B?WUlPODZZRnV4TXBxUnpLLzF1c1F6TEs0b2hRSDFickxvNVd3RU1lV2ltaUdH?=
 =?utf-8?B?ZWhRbFdCeENOWDY3Q3FndVhrVVAzLzRyaDY2dlVSa1lldlhaS1pyRXRYbGFM?=
 =?utf-8?B?aWNRK3JRdURUOTNKdmxNcWRCVmRjMUhiTmk2d0pnbjhHaEc3RkYyU2pXbzlh?=
 =?utf-8?B?R29pcTJRTVhhaFJ1WHpLOG9qQ3N6dGdJUTdyZU9iWVF4K0RtMUkrdHdwN2pR?=
 =?utf-8?B?QUpCRjVmM1ZjdEhGSy9BNzhMa3g5R2pqUjdRSy9JOFlwYTBVR0NCN3djSGJy?=
 =?utf-8?B?TnlRcDcxbGpqQWk5Qitmc0dYVmZQMlFpZ0Z1T1N0ckhDU3l4Z2dENE9xaits?=
 =?utf-8?B?ZGNyR1hKYzU1UnZBMEFQT3FURjVLLzQ2R1FRVVk0WnB3dE1NY3E4eDNzS3pv?=
 =?utf-8?B?ZXNRc2ZXd1BjT2ZZaCtWYUdJUGIvM240NU9UNEVVeDNDcXIrdXBNRjJUQWZj?=
 =?utf-8?B?bDF1SHFRM3RhWGQxaU5TR1ZmUzNVR3RNZTBja2lRSlY4M25MUEJuMWF6WWds?=
 =?utf-8?B?Z1hNb2R5eXhtS21lc2xaYlhndXhPK3YwajUyRE5GU3lQek9vWWdnVTc3eHdm?=
 =?utf-8?B?elAxa3Jjak5OOFlmRDhseW5GOWZTOTMxcFIwcFRTY0pmQWRCZEdzZWM5OW9I?=
 =?utf-8?B?OHZXdUZBQ2s3YUtWQnd5L0tFWkxKeUJzS01MTXpCUmRsemdsa09vbVJqeVRs?=
 =?utf-8?B?OUlaKytRdVZRV1o0RzQ0NzlTN1RWMktyWEFYeDdtSVV0MDJ3N1BUVGlVak5X?=
 =?utf-8?B?amxmZkUrd3U2eHJ6dDNzNDE3RGhXYlVFWkIxWHJTdkdnNUZKZCtzenZzeDdO?=
 =?utf-8?B?aVhKYzJoN0hxc3BSZ1p6KzZya0M1cVVRSmpRd0UwcitnQlpaYlo1ZTMrSzJo?=
 =?utf-8?B?a2s3OUcrQkl4MEZLbHcrNlR2Q3krS1FYSDdPOFE4Z2hSQzB0VnA5bCtmR1cr?=
 =?utf-8?B?ZHVLR0s2b0JOZjdsVk1HNzQxTUNKNUdWRlIrNzFMM01odFI0aHhFM3JOQUNp?=
 =?utf-8?B?STY0SVpUdE9laHhUOVNxNC9qRDBiZ2tyYTBDRUdKa2RsSENlRzRVcjk1ZVRY?=
 =?utf-8?B?MDNEay96S1AvQmxNcWphZzN6cE05QXdqVzVnY1BiNHdPa2lNNDVzRlFHWHlL?=
 =?utf-8?B?S1U1MXZ6S0l3cDQzeENBK0xXQkJXZW5RTG9YbFljTXRXd0hqMUtURlNxMW9V?=
 =?utf-8?B?ejFTMGprVXY0RnpiSmE4NVRWbmE0NmhONVNYWDRFdmpPcHQ3eUluZGF2TUNK?=
 =?utf-8?B?VWRqOWVUVHhUeTVJbGxLL2pmQzZSZ25Yc2FJVTJDcFljREIyMkdjb0NvUFBS?=
 =?utf-8?B?alAyaHduTCthYjBhWjlxZ3dXbFB5dHhFNituNWd5Ly9qUGJYZEM0TFNlR05L?=
 =?utf-8?B?ekg4R00zMlhKbi9ZSGtTUzJvNlp2aERhamFXY0JlK3JOVDhCWGZDYjBLYWxP?=
 =?utf-8?B?bWRkNkVRTGxYWThjeitUT0ZFamVWbkJkZERxc05UMHdYVnhrNEk0RmxYeTZx?=
 =?utf-8?B?K1J0ZWdBTXU4N0ZQU0dmbXR6aE1BNTM2SUkwZHRJSytqV3pjSFBQR3VGUHZO?=
 =?utf-8?B?aUFkdHg0azhybnhTL2RCNmJOUTNsbHFvR20vbDRsZE9iV2grajdRc2NJbW9q?=
 =?utf-8?B?Ky9xZHJLTWx1dktaSzU1NjVyZVhLOUhQV21oRGpTcGYyRnozMlk3L3FPRElx?=
 =?utf-8?B?TkdBZUN5U2p0U3gwaW1YV1oycXBnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8LNBICgsjorQ5m66nDN6jjSW4/iT1dF9S5K2bXpDR7p5cPu0G6zkvb0BMejFs/gBayPUxHPv6es1mYcykS6Rw/4eSuq4i6oGmVd68W1YXTtkNAs5hIfhl2Ie8agN5uIn99oEvz4TrjDtroJlsbTCFWbIGtPf4/zhPpcgs3ZW5ZikeQdNOdC5RTsVlMIubcmpbzG8gQI3LRigLYEYEV4TtnhPHp6MxYEE10GExz41Mk5g25y3zO7HBLo4qh+X10x88GDe4nrh5zcs6UCKuGE6lmDIRPdL0fIYrdaez8zE9oLO39VwzLzmqua0tiXZ6ZMpWP0Uq1CZjE2X9lLC8L3cwpMeRf+LKSAa41LczPUmjWJnG8lzdxsJRnw2DhZChZwRHjAiqparAhaoIeI2/P68T7I8TrxkJLhZsu+x64nJR1VIVyugxUy9XSkLEp6eTujlisz7G98vlDLJMwd4Hcw0WraHU7HJ0cm4L/t3ykT3YJ1ppNC/aYXVacCkToNM6Jgr3p84Q4cbTm8z7ue8DXuJ3VJT63/BOszQtCv9TyFrJcd7zVsJ6pcLGCtbB8i7GnNIg01XiUJ4Jp8O4vnoPT/++mkmG88bw+PJFpQTS7L31pk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7829b36-aa97-4315-3493-08dce95676a9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:07:54.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q16WPdj7Q0gUVyEUzHXj1B2EYRABTumxsJBtwZuKE2GraNnhrrG9K68Y82jMIct/0Il2TcCgXx14tQVRfTK9B3IYRxa54dPC3CF5397q9L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: P9yTiuLZGWBv2vqgaT3MYdrxWCt9_ay0
X-Proofpoint-GUID: P9yTiuLZGWBv2vqgaT3MYdrxWCt9_ay0

Hi Mickaël,

On 10/10/24 11:26 AM, Mickaël Salaün wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid shown
> to user space with getattr(), other part of the kernel may still expose
> the private inode->ino through kernel logs and audit.
> 
> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64 bits.
> 
> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of an
> inode number.  inode_get_ino() is called by generic_fillattr().
> 
> Implement get_ino() for NFS.
> 
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> I'm not sure about nfs_namespace_getattr(), please review carefully.
> 
> I guess there are other filesystems exposing inode numbers different
> than inode->i_ino, and they should be patched too.
> ---
>  fs/nfs/inode.c     | 6 ++++--
>  fs/nfs/internal.h  | 1 +
>  fs/nfs/namespace.c | 2 ++
>  fs/stat.c          | 2 +-
>  include/linux/fs.h | 9 +++++++++
>  5 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 542c7d97b235..5dfc176b6d92 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
>  
>  /**
>   * nfs_compat_user_ino64 - returns the user-visible inode number
> - * @fileid: 64-bit fileid
> + * @inode: inode pointer
>   *
>   * This function returns a 32-bit inode number if the boot parameter
>   * nfs.enable_ino64 is zero.
>   */
> -u64 nfs_compat_user_ino64(u64 fileid)
> +u64 nfs_compat_user_ino64(const struct *inode)
                             ^^^^^^^^^^^^^^^^^^^
This should be "const struct inode *inode"

>  {
>  #ifdef CONFIG_COMPAT
>  	compat_ulong_t ino;
>  #else	
>  	unsigned long ino;
>  #endif
> +	u64 fileid = NFS_FILEID(inode);
>  
>  	if (enable_ino64)
>  		return fileid;
> @@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
>  		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
>  	return ino;
>  }
> +EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
>  
>  int nfs_drop_inode(struct inode *inode)
>  {
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 430733e3eff2..f5555a71a733 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode *inode);
>  extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
>  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
>  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
> +extern u64 nfs_compat_user_ino64(const struct *inode);

Why add this here when it's already in include/linux/nfs_fs.h? Can you update that declaration instead?

Also, there is a caller for nfs_compat_user_ino64() in fs/nfs/dir.c that needs to be updated. Can you double check that you have CONFIG_NFS_FS=m (or 'y') in your kernel .config? These are all issues my compiler caught when I applied your patch.

Thanks,
Anna

>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  /* localio.c */
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index e7494cdd957e..d9b1e0606833 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  const struct inode_operations nfs_mountpoint_inode_operations = {
>  	.getattr	= nfs_getattr,
>  	.setattr	= nfs_setattr,
> +	.get_ino	= nfs_compat_user_ino64,
>  };
>  
>  const struct inode_operations nfs_referral_inode_operations = {
>  	.getattr	= nfs_namespace_getattr,
>  	.setattr	= nfs_namespace_setattr,
> +	.get_ino	= nfs_compat_user_ino64,
>  };
>  
>  static void nfs_expire_automounts(struct work_struct *work)
> diff --git a/fs/stat.c b/fs/stat.c
> index 41e598376d7e..05636919f94b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
>  
>  	stat->dev = inode->i_sb->s_dev;
> -	stat->ino = inode->i_ino;
> +	stat->ino = inode_get_ino(inode);
>  	stat->mode = inode->i_mode;
>  	stat->nlink = inode->i_nlink;
>  	stat->uid = vfsuid_into_kuid(vfsuid);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e3c603d01337..0eba09a21cf7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2165,6 +2165,7 @@ struct inode_operations {
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> +	u64 (*get_ino)(const struct inode *inode);
>  } ____cacheline_aligned;
>  
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> @@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  	return file->f_op->mmap(file, vma);
>  }
>  
> +static inline u64 inode_get_ino(struct inode *inode)
> +{
> +	if (unlikely(inode->i_op->get_ino))
> +		return inode->i_op->get_ino(inode);
> +
> +	return inode->i_ino;
> +}
> +
>  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,


