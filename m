Return-Path: <linux-fsdevel+bounces-76981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC1LEwQTjWl/ygAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:38:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF241128550
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E4163026933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C9356A16;
	Wed, 11 Feb 2026 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SberWy79";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQj54WdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EC26E702;
	Wed, 11 Feb 2026 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853116; cv=fail; b=tSmOHG6St3GxgW1q5lo8VjxbBy4S0mODczkB0iggWcWnX7VXGdspI7DRNnmZFx5T6UySd+prz47psOFNyZWo+EZo2JTzeLA3iCljVEGoASk/LJ02RmXaYoUn3vKNVDnUTXy6mwT+ckjwv6PaX7sWFbXaqoN0erXAS90bXHO7mBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853116; c=relaxed/simple;
	bh=dlw4jd0IpfGZvlyEYktDZCVzqfHgVZlcg40fjwgJXmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6dCo62FGgy2umzSz8HuKsccTt6vsXvE/FFVwwAMOhvXOjYxtJ7ImH/8ZzdqcQAAvv6KGpSmdkUp0/EAICupser4giMmtoODSOrtTS/Xr2LvMA92MknMgeJ02gqZ7JWcYWLT/QUWb7k9pceZgWkeNZFzyAMVNS7ur35o/mUjHnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SberWy79; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQj54WdQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BNDqxF2662848;
	Wed, 11 Feb 2026 23:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LQoRItVkDaGISy6DBJWweoAi/+UCXH5HljSEDbDYlfY=; b=
	SberWy79ZjIDzt+XiuoScx3MPgVoYPPmISICvHOdiXVp/DhALTw6Qbtf8xUPpsW7
	7IRcfA9j/EamVUXOh17V06ShlUCw3dcnGKcnRxExK/PnKdefR4E9IBoTjdazdsG1
	IsPQPMg+WsW+LpaZ2yWGqV1dVqsGk4gmN3+n8T4TzAeIfvXYUCq4mMeN4hQOn5vU
	pjW1IWQW4IcA8OGjdMf/wpEu+8d2sXK44tw6JCybyIvvdd7jlnz3+q8LLFXARjUZ
	6BCYNUMwm4dZtJdYN4DFOvbyzdqyrJphLYqSoTxJDk1nG+8FyysjD/Dmry4xAN/w
	4y9Lo+UNGJVUfPZFdqRAMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88fv2hqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:38:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61BLedCq008104;
	Wed, 11 Feb 2026 23:38:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8236f676-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBHCKqroS0Z8vHRDVkVZevsj1L99vaStgy7SR15SSe3uHw0f9pd68Zuax8rXeY+W0+YIE4lvYtXdBAMR3yAWgKLlmdJ/2DIPDqmOToyOlygv946dxVhB1XNZkaMiXSgDd+ykrLino98oyR+HnoFdOocdcCoKdMRYacjOCRLh3gBSNAkkfQCiNRifCldH+VoQ3zNcKAxs3FIufRKpqiJLkfzpFa36/W58BcIOON7FCvAS3vMslJBPFgmVdsE13U0CO47drAtDsPTNQwfTBdm4ezvA9h/2/HQ97LHHY9khnnCVpcrcfMmHscVeO2+5yNzA3MCjBYoKvzdFsoCW2sRGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQoRItVkDaGISy6DBJWweoAi/+UCXH5HljSEDbDYlfY=;
 b=JBMiCut5Atiwn58kCazAwzNY1efewmRqohhTORq7KbRUnW95Lbr6p09zx3+DVSu49NNQg22KIG4oi3iPxlOxCwgmAAb6D6MpIFbpg08PjX/W3VT9oJcxk8z3fVAucG6vQKVBcRL6yOGgY/RpEI9sy/4reYxTc1sHERuLrQgpmaPcWlYtDqA8NdDy7WgOlqU8abZXJ8LLF4IVwY1P++nVAKGqX2AwkRhJ7DoD/5Q4McMvF55GnAUZJ+8LjuXiBzB467zYWIR86mCu8/tre1HhQH4B4WRhcxFLh8F1kUVdOdhnXQfL0NDoNFIddXI/ScHFyKGn2m5DrquJbAmAmGJYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQoRItVkDaGISy6DBJWweoAi/+UCXH5HljSEDbDYlfY=;
 b=fQj54WdQso6ewQBjezPQYy8dMGiQudWRV3wYgiWjb0Kj1VmvhXWn6Pz6Q5uB01T2TbZbwx0tKCUmMcd1yhutoEkQ2iTLmyfdLzTAejhenEask3VBn/w5q/2Z3LcJPa6/EpFNuOzyXfhleB85RNk0utFVA156xKBmLGdBNIfPlBU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 23:38:01 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 23:38:01 +0000
Message-ID: <88bdf658-19c3-4203-8948-5aaa64718b47@oracle.com>
Date: Wed, 11 Feb 2026 15:37:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260210181632.1161855-1-dai.ngo@oracle.com>
 <eb1757d7f2409ffb792d800166daff8a8c63b09e.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <eb1757d7f2409ffb792d800166daff8a8c63b09e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::11) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ef3ed8-460f-4337-94a0-08de69c69803
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MVAzcHU3UE5CMWd6dTF6MSt3dkZvSWxFdDIxOTZicWFmQmhlQ3BXNW5QWWQv?=
 =?utf-8?B?TGFCWEFWZ0ZDaWZjNnFtaWZWT1VFciszRG1jWE05QzNhb296d1YxV09QUE11?=
 =?utf-8?B?NnpjUDg0cDVNaGRiS0g0OXpvWFBkSVN0MTdkNlhvOWpsNHd6SXdXcVpaQmZ6?=
 =?utf-8?B?dDNVYmdoVzc3QnYyc2Jyb1R0SHV3Znltcy9DY1lIOWFyK3Y5N3B6MW1FTkRZ?=
 =?utf-8?B?MFdyMm5BRWpXeGxxeGhER0tKTUFsVC9oN3lFMHhPeHBWQ1MzaU9yUGFxdTNJ?=
 =?utf-8?B?ZCthc2t2TEJYMUQvdEYxTys1a0FObDNZUVA0N2xKbHVHanNwOEN3RkplNDdG?=
 =?utf-8?B?Ykx3c3lJTzBDbzRTQkFYTjg2NWwvRjZYK282c2Q5V3AvNHE1dEQ1QXZsYS9B?=
 =?utf-8?B?NjZQSFd2djhRZzRMWUxrSXpHZGRHSUU1bTcyUVMxZkdsTUNVTUVpNXVTSGp1?=
 =?utf-8?B?Tzhiay80YUd4VyszUkhaTVM5V0VnMEhxb3hXUzZicmdadDcwT2FwQ1JrZkV1?=
 =?utf-8?B?UUxZeGduZWRSQUZoUlIrUmJScjNtTDQ5ZDA2QWNCU001a0F4b0d2Q1c3R2ta?=
 =?utf-8?B?QlVVbzYzUTR4YUo4MktueGNCSnY0WVFLR3Vvb1JLM2x5MytQUWxHQ3dTcWpY?=
 =?utf-8?B?S1k0d0JiR1Vxak04ZzNOVmlnSVNmS2d1akx6dEJGb3EybXJvK1RRbXhIc3cx?=
 =?utf-8?B?bDJVQzBhNHpqai9mYys2TEVEMkUwL1JBYUxwL2tQRnFmZE5HS3JJNFBnYmo4?=
 =?utf-8?B?b0g5Q2RJUGhFN1g0bWhQK2lBNkhVWHVMWGhrcXJ5QUFRWXZaRmpvVkl2Zkh1?=
 =?utf-8?B?amFrVHFDYVVHRGdlWnFQTUQvSVV3T1BxaEJjYUlkcFkxM29KT0t0RWNJcXo4?=
 =?utf-8?B?WGpzTzFKV1lIbmpOa3JZZG01NmNnS0RoWkltMzNFTmtNUGlWazB1WjBFVzhQ?=
 =?utf-8?B?YkthN2trTVA3WG9iNFB5WEhIbG4vWFdUZHBRSnZJbUNrZ3ZpVm01Q0tzZmZM?=
 =?utf-8?B?OUFSMnZVTnBGYm5QczVwNXg1Uk9POFM3cHJveU9pK1JpY3N3ZytEUkl5M2RB?=
 =?utf-8?B?a2lFMVdzM1ovSDVTcWk5dzlrYXNUa2srMkkzaURVNU9uVzJWaDhKK2VKVHh6?=
 =?utf-8?B?cDFEUVdGSDFiZFczK2ZLU3k2ZUlzSWpSNGdiV1A0UkhJRVpXL0IzbllEM2Zv?=
 =?utf-8?B?cXNkMjZmVDFOWklwNzRwd0Y2cis3N1NrUVJHVlorTVN3d1RRTnEvRnlPT1BQ?=
 =?utf-8?B?NzVwbjZSaGdDckxubG56UC9DQ1lTaExPLzJETmJYV1AxZ0tTWndrM2thZkhE?=
 =?utf-8?B?V2l4SjVEWlprcHYzZ1NmclJzZmtxTWpacSs1Wk1wN2VCbTdxMkIrL0pidFJq?=
 =?utf-8?B?MUV5Y2tUN0J6WGJOUVZBWmYvNmVHWGF1aUhrR2NhVXd2T3NhbnVCeVVNWitw?=
 =?utf-8?B?dTJ4c3BsSitxeEFxb3YrSlRmSGxyMm11S0dvaTVlb2t5RXI5YWd6blBQQWlI?=
 =?utf-8?B?VFJoMHg2MjFQMnBwcS9KcEp6cGJUM0JMS1pyVS95UW1ZQ1c4QmFqMUVLUk5Q?=
 =?utf-8?B?bEpiOGI3Ui9KQUtwL1NDei9HSWtMWnpqdGtBYkErcHFpZDFBSW1pRmFhMmVK?=
 =?utf-8?B?SDd4ZkxMZndlSVpqYXJIbStTRmxTUjl6SUt1ZWtYQjZNR3hBTFVjZzRFZTRv?=
 =?utf-8?B?aUNKZVYreC9VeXJrTEErZllKZ2ZCbFN0NFV4UW5KakdiSUNuNUc5RU5SWlFK?=
 =?utf-8?B?Z2o5MmtRTkJGYXloVzhJeU9LMFhBWlFrQjNPSzZRc2UzS3d1aXBSTWFIeTVO?=
 =?utf-8?B?WHpTMG53TUk2a0tJS0M3UEVCdVA1U3dOYU9ZamRCNUNqdGZjSmtGQXNxV0JN?=
 =?utf-8?B?REtEZWZ3ZllYQit5OTROb3k4d1Fic2VLL1ZGNGdFY1VoMHdSNUxtdGRWaHdH?=
 =?utf-8?B?bVpJdkQreTNvZGx6NTNDRFF5T0pNTnpDcUVBclRPV3BmSHhvaGYrdGVFaG1x?=
 =?utf-8?B?bjRBdVV1enRwVEpHcXhzUi9ENUUrRFVWcVIxalNiWDNWN1g2RlFrUFFySTRO?=
 =?utf-8?B?YzE4VlM2aTdzWm9XMjVsWnFDdGRKOFhZUG9rZkhTbHo1cWNmemxESkZaZU9v?=
 =?utf-8?B?OHZ5QlhvRzFSbEF6NWczcXJkaXd6L0dpSWxGRlc3Vk4yZGJkUHRJbkhrZFNa?=
 =?utf-8?B?Qmc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RlorZWNScHA1czdaY2lsakU0QUNRUmkxdHNNK01UdEttTGxqRzNTdXNYYjBv?=
 =?utf-8?B?VVJ4L3Y4aVk4Y2o5SG5NblNmdTJSY2dwUjNEdWtpRmdqbUNnZDRxU3p2NEtV?=
 =?utf-8?B?bDBrVCtpTGdzSWZ1STZwUFdydExka3NwS3h2bnBkMUk1WkhKbW1USno1S2dP?=
 =?utf-8?B?QWdtbms3cGVZOGE1ZXhxU0VHYmhBL2loakRoVkdzOG9mZnc4RWpubzVkeUs5?=
 =?utf-8?B?cnF4SWV3OUZLYlYwV1ZmVVJNRFdHaVVpSEs3UkFtZ1NIL1pFY2JSTVdvTW93?=
 =?utf-8?B?OXBVMHJKaHZoVHZJb0RETnVJYjZUWGdRVFNCZDhKdEgvdythbGFGMG1KcEdQ?=
 =?utf-8?B?eGVHVHQ5cmU3STlkL1d6NVMrckRUdkZWUGdkYkpwS2dnRy9xUmpUaW5BV0Jr?=
 =?utf-8?B?ZHpMMTVLNjdiSWk3TDJLVGNDbjdjYmtJK2VlcVd4dHRRTjVaRzFHaXNSWEZJ?=
 =?utf-8?B?QzdYOVdsWEpiQnRCOHBQS096eEpTWENxL09wL0FUeWJrZmNpNmludDRpL0lY?=
 =?utf-8?B?M0lWbmVLeXI5TElYTUxMV0xOVnJOdmhib09iOFgvd3pLYkR4clhuRURBUERP?=
 =?utf-8?B?TEpURVY5d016MlpvUExuYlF4M3h1VzMrVXByOXVxYkFya0UvZGh6d0xyS0xl?=
 =?utf-8?B?d1lHVGFJUTAzVVV4QlBpbENGSnJSb0JJQ1R1OFR3Z3Q5RHJWMXdsSnFJT1hj?=
 =?utf-8?B?anREUWdkbmZ1MG1FSExTY0htZWw0UVUzNDJlU3NPbUZlS1NoUlZGS1hZNzE0?=
 =?utf-8?B?Q3EwdWdWdXVrVlN2eGVoU2tJVG1EclNXZ0ZTVktRY1JQNnNxeUxObnQ4S04z?=
 =?utf-8?B?T3dOeTN5L0VKeXNPMmNRSDllWHRzMW0zQUtraEFvLzlsVjFyQjV6Y0Q1U2dL?=
 =?utf-8?B?UkY0c0NmVmFhNVY3NTQ0WmpKUnlBUzZEQm1VVTFuWi92aU9NRml6ZmZ2MXhI?=
 =?utf-8?B?NzVXTkZoNWQ3eFBXUG5kTEdpcE15aFNvK2d0bVBGdS93NUkxQ1BhSjQwOGFi?=
 =?utf-8?B?ODE1MnYrZkRoenY0WkpDYlhwdHJiKzAyRTRRclFHYXdpVkZQUkFoSFBjZXlh?=
 =?utf-8?B?bWJSejRrT0lLbzVNZ0l1TmtLdEEydEtyMHErQ1Q5V1FjWDZPWnZLa052NGtB?=
 =?utf-8?B?emtoNzVkckQ2ckU5L1NhSkdXd2FLRTY3MDc1RXdZL09reldYN3kyWmhaa3p3?=
 =?utf-8?B?bU5GLy94YmFxaDc0WDRKYmRWNk41VmMzMTkvYnY1cFBNaTZzK21mZ1kxTHBQ?=
 =?utf-8?B?NnVQMFVQMzJnQ1Yzc2djOURxMFpzMnRHL2VrblpvaW9VWC8vNUQ5UmJiNVcx?=
 =?utf-8?B?OVJLUmdReEpoclFHTFBRR1h6QzdIRmdxcWx3MGtkSHVMa3dvRVVKbFk1elNi?=
 =?utf-8?B?MWNCV3dMdWUwdHU4SGtXMm1YYWVzNXkyWHpoY2o3bUdiZWF0Y3NORnFSTlRJ?=
 =?utf-8?B?K2tGSzlQY0ZOYjV1WUJsamR2Mk52Qk9pelllQTFUSXFMNDNQOXpNTkgvNXd6?=
 =?utf-8?B?YndmdDZjSWZ3RVVDV0RZMktDcGIrRlpxdWF6ckpHeS83cUhiT0dLWnJwbC9K?=
 =?utf-8?B?NndHUERhU2JoajRzL3FGdHpibUNFTFRxQndNdnBIdXNOaTR2Y3FZc25Hai9x?=
 =?utf-8?B?cklFbWtZQ0huNGZrVGdrQjAxclh1YUhQZVhEYmJ3NWYzYTlxb3ViMDJvQzV1?=
 =?utf-8?B?TU5ub1hqbzNqWm9JUWZYRUpQRWs5YStkUER1UkZqT3VUY0tKMmZhMnpxZFl1?=
 =?utf-8?B?QzE0TVpYZnJwTmxQRGdmRHEvaVZ5UGQ2N1A1OGp2UnB4WlZqamVYUGV5ZVZC?=
 =?utf-8?B?WlJmQmtQUEFXTVhIdVZPSGNwcjV1eEhRMzNQZFFFTVMzTjlqdVIzWmdEZUN1?=
 =?utf-8?B?WmFTcHJOM1JjUENVVXc2NnFXNWlSZG9VRTBBUDFZOTdqN2krL3dPY3lFMTdy?=
 =?utf-8?B?WGc0cUtyeDEyeG5XNjdOMXdUSXcwZTVyMHRxRUJsYlNOSDMrUDc2MUdpREEx?=
 =?utf-8?B?c2dxekJPdVdQcUZ6YkRWb3RuaEJaMjZsVjRvVUVRSFhCdE1kL2dHeGk1Y011?=
 =?utf-8?B?WWc5eHpqNlRrUllHc3NybWViVlNxOUYyc1VjU0ZGMlg1ckhTTVVNRm9ZS1Vm?=
 =?utf-8?B?TFljcWdHYVJ1VW1PUDFadGEvd0lKQ29OcXhOODhHaWluQkd2dGxSOFhhR0N6?=
 =?utf-8?B?UVhTUDkrbmlTSk1FMWdhVmJFVjZhTmgyQ2VaTVRqZUpqUWRaYUtWT1BrYWdI?=
 =?utf-8?B?MGRKT3Z3Q0VIWkUwRlIvQjJqZG1vdUZ2dTdmaFNkekI5QXhtYnkzZ3VtZDBi?=
 =?utf-8?B?TmRWVEM3K0cxODEzTzE3K04waXhPNjllN3NsQ2ZwRTZGTkh3NHRhdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bLg1MRu3zZj85zzJNy5PCn4ANBVmUvyxJYmk+W592fQgRrvul6h2j+rp5bu5nBgjr+2vnaMk+ZljOIhBtN09bOJPOVeXCL0rJZB5cLzc40UfweTD/LBNFRlMepNtbnNrWMHao9bE5Bf9LVy8XPH75UBikk+F/QqpEp+ToERKgk3L+dJxxjph9QCXo6eY9Lolf5nNtGDMSOYS41W49cJcw4hKRuziYn4YEJZzhuU0am/l6Dg47mDeaX+Jjid2V8McxTuUtH/PwC1L1HiG9G8xEqGRQhM287PEyq8AM9ZIbolba+iulqC7rOyy9gxpx5uKz7QZ7KGlyaukx3mJtwX5kg1hhtMdkcoL/2vEDRtNCKQnV6+1M4qmM5LVXIxR46NncSsJLtj62uL9asih+Sm9z7UAoFmhS9t86fePqCs3/A/afVZ0PvDgQe2l/VPWF/nX9KF/EbOwrUYdJG4xUybqXGk3ap3crgvCLEGeO9xWr5tUmNogcMW7FDG3xDDk/Rlm8QMPQ5C6ZRM9ee7kWYACAJo753brB8dIZedfVrpuJzEMqafdvGiE12Tp9a/XBbA/lDx/f0WWut2La8dT1Oe+AYOb+AyloEVXtJeNHaAjI84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ef3ed8-460f-4337-94a0-08de69c69803
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:38:01.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PMAKpP6xZuzg7TJPneer3qiLM62dN6FSXEJYL6qJ7R0A5DqrUCmQhrk0ZeAOMhgwfUUMeO9pxCYCcpQyuVuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602110183
X-Proofpoint-ORIG-GUID: mDbyjLPP-75V53pxCfkDIJD9SY-4Slsp
X-Authority-Analysis: v=2.4 cv=Qchrf8bv c=1 sm=1 tr=0 ts=698d12ec cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=i2Z0s117XbD8L5yPLCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mDbyjLPP-75V53pxCfkDIJD9SY-4Slsp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4MyBTYWx0ZWRfX7uAeCc5WWaL9
 hIJaUAGMWzZuqo1R0Fzn8PWG4Aa9is6fmf0ttO9z0xGyauBoiFwZ5IlIV/n5ZGZQhpKgn8RP3WY
 EEMSs9yaq8HL+nCPMbza+zScSeDXX9y/+ejmEZSVMvYCQoOzcWQYsnQ7hJWQnNnbH+U3nK+dlva
 6wYx+6xxcUx71YeGPVSOoWA4biFJ5UZK+ELfg8Wy6uH1NOdoXN19rJj6OH69mGRwgshVqqNqZ9b
 RXY1da09h/XOWGwXjm2CX6x4PuNq6pc1YJ0kK5GmOoM7/XB5KMNnuEe/iYmu9irqr/EWRSrdQAC
 OODebziPlWzEfOW0pdkjSks5UevMcMtMj9XTVjnRMjmcaJUBtJfmPfwJQhCfpF2luSbXXP004Pq
 HEYh1BwvDlPv0C29xF3xmq6Z11LEXHpLeOPNqZX1dG9xJikMqhD7KUHL04hJc+Vp0z9qpRc1Qee
 kltVSS3pZZ7JPVorEIw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76981-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DF241128550
X-Rspamd-Action: no action


On 2/10/26 11:22 AM, Jeff Layton wrote:
> On Tue, 2026-02-10 at 10:16 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |   2 +
>>   fs/locks.c                            |  16 +++-
>>   fs/nfsd/blocklayout.c                 |  41 +++++++--
>>   fs/nfsd/nfs4layouts.c                 | 126 +++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c                   |   1 +
>>   fs/nfsd/pnfs.h                        |   2 +-
>>   fs/nfsd/state.h                       |   7 ++
>>   include/linux/filelock.h              |   1 +
>>   8 files changed, 182 insertions(+), 14 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>> v5:
>>      . take reference count on layout stateid before starting
>>        fence worker.
>>      . restore comments in nfsd4_scsi_fence_client and the
>>        code that check for specific errors.
>>      . cancel fence worker before freeing layout stateid.
>>      . increase fence retry from 5 to 20.
>>
>> NOTE:
>>      I experimented with having the fence worker handle lease
>>      disposal after fencing the client. However, this requires
>>      the lease code to export the lease_dispose_list function,
>>      and for the fence worker to acquire the flc_lock in order
>>      to perform the disposal. This approach adds unnecessary
>>      complexity and reduces code clarity, as it exposes internal
>>      lease code details to the nfsd worker, which should not
>>      be the case.
>>
>>      Instead, the lm_breaker_timedout operation should simply
>>      notify the lease code about how to handle a lease that
>>      times out during a lease break, rather than directly
>>      manipulating the lease list.
>> v6:
>>     . unlock the lease as soon as the fencing is done, so that
>>       tasks waiting on it can proceed.
>>
>> v7:
>>     . Change to retry fencing on error forever by default.
>>     . add module parameter option to allow the admim to specify
>>       the maximun number of retries before giving up.
>>
>> v8:
>>     . reinitialize 'remove' inside the loop.
>>     . remove knob to stop fence worker from retrying forever.
>>     . use exponential back off when retrying fence operation.
>>     . Fix nits.
>>
>> v9:
>>     . limit fence worker max delay to 3 minutes.
>>     . fix fence worker's delay argument from seconds to jiffies.
>>     . move INIT_DELAYED_WORK to nfsd4_alloc_layout_stateid().
>>     . remove ls_fence_inprogress, use delayed_work_pending() instead.
>>
>> v10:
>>     . fix initial delay of fence worker from 1 jiffies to 1 second.
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..79bee9ae8bc3 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        bool (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..9ec36c008edd 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove;
>>   
>>   	lockdep_assert_held(&ctx->flc_lock);
>>   
>> @@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		remove = true;
>> +		if (past_time(fl->fl_break_time)) {
>> +			/*
>> +			 * Consult the lease manager when a lease break times
>> +			 * out to determine whether the lease should be disposed
>> +			 * of.
>> +			 */
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..b7030c91964c 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>   
>> -static void
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + *
>> + * The cl_fence_mutex ensures that the fence operation has been fully
>> + * completed, rather than just in progress, when returning from this
>> + * function.
>> + *
>> + * Return true if client was fenced otherwise return false.
>> + */
>> +static bool
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	bool ret;
>>   
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> -		return;
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		return true;
>> +	}
>>   
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>   	 * retry loop.
>>   	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	switch (status) {
>> +	case 0:
>> +	case PR_STS_IOERR:
>> +	case PR_STS_RESERVATION_CONFLICT:
>> +		ret = true;
>> +		break;
>> +	default:
>> +		/* retry-able and other errors */
>> +		ret = false;
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +		break;
>> +	}
>> +	mutex_unlock(&clp->cl_fence_mutex);
>>   
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>> +	return ret;
>>   }
>>   
>>   const struct nfsd4_layout_ops scsi_layout_ops = {
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..07904f404f89 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -27,6 +27,8 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>>   static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops;
>>   
>> +static void nfsd4_layout_fence_worker(struct work_struct *work);
>> +
>>   const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
>>   #ifdef CONFIG_NFSD_FLEXFILELAYOUT
>>   	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
>> @@ -177,6 +179,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>>   
>>   	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
>>   
>> +	spin_lock(&ls->ls_lock);
>> +	if (delayed_work_pending(&ls->ls_fence_work)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		cancel_delayed_work_sync(&ls->ls_fence_work);
>> +	} else
>> +		spin_unlock(&ls->ls_lock);
>> +
>>   	spin_lock(&clp->cl_lock);
>>   	list_del_init(&ls->ls_perclnt);
>>   	spin_unlock(&clp->cl_lock);
>> @@ -271,6 +280,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>   
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_delay = 0;
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -747,11 +760,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +793,117 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>   
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	struct nfsd_file *nf;
>> +	struct block_device *bdev;
>> +	LIST_HEAD(dispose);
>> +
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +dispose:
>> +		/* unlock the lease so that tasks waiting on it can proceed */
>> +		nfsd4_close_layout(ls);
>> +
>> +		ls->ls_fenced = true;
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		goto dispose;
>> +
>> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
>> +		/* fenced ok */
>> +		nfsd_file_put(nf);
>> +		goto dispose;
>> +	}
>> +	/* fence failed */
>> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	nfsd_file_put(nf);
>> +
>> +	pr_warn("%s: FENCE failed client[%pISpc] device[0x%x]\n",
>> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr,
>> +		bdev->bd_dev);
> This is probably going to fire too often if it occurs. It'd be better
> to do it just once. This may mean tracking a per-client flag of some
> sort.

Fix in v11.

>
> Also, given that the admin needs the clientid ro deal with things if
> fencing fails (as documented below), this would be a good place to
> display it in the form they'd need.

Fix in v11.

>
> It might also be a good idea to log something when fencing succeeds
> too. These are exceptional events, so I think some log spam is
> warranted.

Fix in v11.

>
>> +	/*
>> +	 * The fence worker retries the fencing operation indefinitely to
>> +	 * prevent data corruption. The admin needs to take the following
>> +	 * actions to restore access to the file for other clients:
>> +	 *
>> +	 *  . shutdown or power off the client being fenced.
>> +	 *  . manually expire the client to release all its state on the server;
>> +	 *    echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
>> +	 */
> The above probably ought to be documented in:
>
>      Documentation/admin-guide/nfs/pnfs-scsi-server.rst

Fix in v11.

>
> ...and maybe in the block one too?

Fix in v11.

>
> It would also be good to think about how to hunt down info about
> clients that aren't responding to fencing without relying on dmesg
> access, since that can be restricted in containerized environments.

If admin has access to /proc then they can find the unique client
identifier by doing 'cat /proc/fs/nfsd/clients/*/info |grep address'
then expires the client manually.

I'm sure what else to do in this case.

-Dai

>
> (...and this reminds me that I still need to update nfsd-admin-
> interfaces.rst with info about the new netlink interfaces).
>
>> +	ls->ls_fence_delay <<= 1;
>> +	if (!ls->ls_fence_delay)
>> +		ls->ls_fence_delay = (1 *HZ);
>> +	else if (ls->ls_fence_delay > MAX_FENCE_DELAY)
>> +		ls->ls_fence_delay = MAX_FENCE_DELAY;
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * @fl: file to check
>> + *
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * This function runs under the protection of the spin_lock flc_lock.
>> + * At this time, the file_lease associated with the layout stateid is
>> + * on the flc_list. A reference count is incremented on the layout
>> + * stateid to prevent it from being freed while the fence worker is
>> + * executing. Once the fence worker finishes its operation, it releases
>> + * this reference.
>> + *
>> + * The fence worker continues to run until either the client has been
>> + * fenced or the layout becomes invalid. The layout can become invalid
>> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
>> + * has completed.
>> + *
>> + * Return true if the file_lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +
>> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
>> +			ls->ls_fenced)
>> +		return true;
>> +	if (delayed_work_pending(&ls->ls_fence_work))
>> +		return false;
>> +	/*
>> +	 * Make sure layout has not been returned yet before
>> +	 * taking a reference count on the layout stateid.
>> +	 */
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		return true;
>> +	}
>> +	refcount_inc(&ls->ls_stid.sc_count);
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>   
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 98da72fc6067..bad91d1bfef3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
>> index db9af780438b..3a2f9e240e85 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>>   			struct svc_rqst *rqstp,
>>   			struct nfsd4_layoutcommit *lcp);
>>   
>> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
>> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>>   			     struct nfsd_file *file);
>>   };
>>   
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..7ffb077f6fbf 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>   
>> @@ -738,8 +739,14 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +
>> +	struct delayed_work		ls_fence_work;
>> +	unsigned int			ls_fence_delay;
>> +	bool				ls_fenced;
>>   };
>>   
>> +#define	MAX_FENCE_DELAY		(180 * HZ)
>> +
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>   {
>>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {
> This all looks good to me otherwise.
>
> Cheers,

