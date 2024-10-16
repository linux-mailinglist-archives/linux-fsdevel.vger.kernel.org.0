Return-Path: <linux-fsdevel+bounces-32075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB99A041C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BEA1F220CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320641D14F8;
	Wed, 16 Oct 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AjHhyCgP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bzbwzIA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8792187850;
	Wed, 16 Oct 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066956; cv=fail; b=sJmyV4Wp0BNpp/5Q08yu7TotAEZ7Dw/PIoVlC6Udldy3J9E1pE4GwriPKwiCfl3db938/39788QshdNT0j9pXHRFXrS7Poxb8VSPlseBUjVrXesHESNDKG8GP1XEAAya0lDkz9bwA6M7jKHIHoEANQ4JEgu8aRcSgb1TIERENqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066956; c=relaxed/simple;
	bh=nr6kHqzeH+9rdxzwAJibzTRrlyrU4OsP3rIuMkNpm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eoYDjFMclYQ0h+HArC+RI0N3ZFSOlcy1fOJQ1L5f/xPLzrW3+F2n/U+hFqXshZk5/lIbjq6oDtcXL2Twnl/Fp1/XyeNjVUlOBSWU+PgAZ6ajUtq6q0YVleAgMPAl6OCKKKFtqQOB1jSYez22CZDnq7Q3QMFGZTzmNkHpvTf4kao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AjHhyCgP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bzbwzIA9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G7feHV008120;
	Wed, 16 Oct 2024 08:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VttJ3TO+/k6zUHiYUjeXbpHrCrM/qixQerKioasD5hk=; b=
	AjHhyCgPcFjaeoZVOaiY1fnq03aM+5IBrfTUNbYldx7k3ckMjzCmR7hR/Q/OIiBR
	6vqbaec4HPV8FaPdNNX2a+nsHJkrQIdpZ8IXvtOzsSKk6Hxkekd1K0c2JU5eQim8
	iXDTDzDmCeRnd7c3aZgtTck5uRaQgW2yiT9RmASMAQmXRYE767GPDCO8g58KjYyS
	flxNTkpe45NjQpWOjstt3NwzapkKycYzgOtj12ASID55ntc81FlhvruyjUb8kiSk
	Adio3Ip9T6ghKo0yXRtA3ayGofr9G8L/WICjn91hLGFQ9X4KV+NsGq2kYGRAXLTt
	cbRvvO/hgQhgn5VWoWHMfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt3572-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 08:22:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G80MhV019899;
	Wed, 16 Oct 2024 08:22:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8hkwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 08:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfWLLryBOIkEI5AD1v4HK3yrjFUB0NuucbcPDiK9osErGmTmXtSG4aRYi47tgNa9/dbpLndF2R9148ugynsGAAjRKaelvsR2WAb2sCsT0RExVuM0IiUrmRtNFAtXIhiXmSLsLRs4f2Ah+fvX1W8gFTu2K6Cm9oNdT7XGS+zRGMFTdFL8k+U2dR50J4zbew93kn0QaOtnRJoi8ot1YeWAbQKZdKevQav/ZvKAkdMsxWZFGxToKy3T+tnhXKpWlu4gba3c0TOZG9DJugGJ2waanxa3zEnAnofyIGBvN1z0HlAfUqwtIlMNtyAxI1+0jPmKzwfkYHKx2jx06HwQCLxMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VttJ3TO+/k6zUHiYUjeXbpHrCrM/qixQerKioasD5hk=;
 b=OEucopCXjArhPQOMZzX3xBVoMl4RllFaUHsOsog8X/HLvPWlQnhlX+rUIjHlM31iktgSZgXNnTji3useZCWTL4AmMeRFiAWTHrips7k4aMrO/raZfgcjX9VWB6VZu0xolcaugl3AKZhXwAHYX0GX+raOpJJmKps6OKCP9E4+eA7O94mtF0+ncOch4cv6U4Lxl4v7/qpAnr1vtlf0yj/8ip5+lleUPa5/mXbd0sSCCuM85YTd1DBP+HVNFkGYs7xdloOq/b9WdwgamEyMtF+Yk+EXAwmpCW0nnGOKnAlmfUCClKnBa6dqrOMcMbKAIYNfotIcTO9iThnZZLMxR/VCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VttJ3TO+/k6zUHiYUjeXbpHrCrM/qixQerKioasD5hk=;
 b=bzbwzIA9/lItKSStB8cVv/Tl30q3GbuFlA1x8WMKC0ug9RAyHhLSdZyYhxAqzC31KYjbG26/XzdtUaaXp03Rlm9Idi3a5lyY2kt2OaGpSZKYeJ580XyZkanxTddUxV2jprAkOq+Gg6jTP7uZNa2UW5Zj6HAK6+3zKPc/rznZVps=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB7500.namprd10.prod.outlook.com (2603:10b6:610:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 08:22:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 08:22:19 +0000
Date: Wed, 16 Oct 2024 09:22:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <2c783f7d-78d4-4d91-9999-12d7772b6272@lucifer.local>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com>
 <8c75620d-8920-4c19-8ebc-0f2b056d49fa@lucifer.local>
 <CAJuCfpFXCKAH+fc6=fg-nVC5tjpGG--Pvk4D2NOn-zdA1LXS=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFXCKAH+fc6=fg-nVC5tjpGG--Pvk4D2NOn-zdA1LXS=Q@mail.gmail.com>
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 0904c9da-2bd3-4120-5e2c-08dcedbba6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnZOMk1GSzBTRkozWEtRMUJlZVZleTNMWS90SVN3R2NXbGwzZFRPYzFMK3E0?=
 =?utf-8?B?RmhZSnZ0d0NvTUM0bGR4dHlBUDVFTURuMTFWTjd4VFZPNnNUeE9RVGgrUkkw?=
 =?utf-8?B?MUh4SkpzanZRN1UydmMxcXExaWVvWTN2VWVFR0RXbTl6V2hlNjRMc2FQc0lk?=
 =?utf-8?B?NmhXeldLVjl0ZDJOdjJEdzNRZFJDU0hRQlBnanFEcmx1K0g4eVowbzBVd2E4?=
 =?utf-8?B?N1U5Y2w1amJpSVVLaC9XNFNQa2lsS1RCZThCQ3RiU3pQdnJodmZRdWZSRDRh?=
 =?utf-8?B?ekNsOTd0bHNHengrcVRLRG1sMWFKMXkvRkIzd3FDTkpHaHJkLzlqYkJWMThJ?=
 =?utf-8?B?ZjJpOE9TT3JhUktYNG5Nb0U1bXR3VGJiSkMyYjdkOC9EbXh2bXlsb1ZZczN0?=
 =?utf-8?B?WUx6Q1BoNVJ1Y1pSN2p6alRUN1AwMDcxV2RtZEgxc0gwU0llSXRhUnc1M3lS?=
 =?utf-8?B?YklkVHFsYTRsdXdlYjJIYTZiVzlxMVZQVXc4ZVVYRm5pajBCY3A3OVFjNStS?=
 =?utf-8?B?b1lIREZMdUpkODg2Um9ONWlOSHdaMHVMOHV3UkRVRGs5RWVjTzVJVVF0QUpo?=
 =?utf-8?B?Y3RYVklYZS9Edk9KSGNGMWFBNXZMelNzZUQ3NHBmTzJaQlF0VExQL25sRmpq?=
 =?utf-8?B?VTVCbDUyMWgxMHFFUmRZTUlQdG1QcFVHa3ZlaXRJcFNMMThiaThsY3hobmR0?=
 =?utf-8?B?VnNObDVBK0pSemVtMlJpUzJ3cHRDQzBJejNlakoycERMUkhyZVJ4SUhjSGk0?=
 =?utf-8?B?dnlVdFdiQko4RDJlYlZrMzdGWmlRcTh1Tjc2aU1YNHc3VVVEZElOTkNFbDJW?=
 =?utf-8?B?cXVOMUJTT3M2N1A2dktDZEd5UURVVVFhc3J5bkNBOUVTd0hyR2lDejhJYXhF?=
 =?utf-8?B?dUhJYzMyNjVHQVZjT05SS2lMVG9IY2p0Z3JLN0orY2lPNlYycys2VlpmdnBq?=
 =?utf-8?B?dUpMYks5UXVwZndHdjFacjJ1WDI3VC9xN205VG1sRUZHN2NpV3JJK2JFRDFh?=
 =?utf-8?B?QitNbGgzZW1OUHJGampseW5PQ3JsbkV2TUdlWGJoZExNQkdReTg3d0FxbjdZ?=
 =?utf-8?B?OFZ4RW8rVEE2T3JxQWNNR1hMODNLNmxMTVNnVm9KRncvd2JpRE5qRFBkc0M0?=
 =?utf-8?B?ZFozMUtKMDBvYnhtQTgxTFVJaHEyZHpKdDRDNTJDemRtc3N0QzNTYkpLU2Nw?=
 =?utf-8?B?aUNRbTRwOStuTU5XRXBSZ0U3WCswSE5paldPclB0L2JWeThESnpMTk9ES2xw?=
 =?utf-8?B?UEY4T3dBTGJMRS9QcWloTlVTa3NpUEsvK1RodkdEMFl6bFZVOEQrYU4rT3lu?=
 =?utf-8?B?Nzlrdjh4OVVFeHJGa1B0bjRqY1VlU05uaHZGUk1xb2VWbTZBelh0YlBJQXNx?=
 =?utf-8?B?QVVLZHVVeDJsbVN6R3ZxMXg5b2Z4VHZkcXRiS3MwM052Wm9vRnRjM3o4UUhr?=
 =?utf-8?B?SVlidkFKbll4bytRb2EzS0RuVjc0b0ZaMVJmdmgxMnNWVmh2SlU1bHBlNEpw?=
 =?utf-8?B?SHl2TnA2elIrZlpsc3dzOW5KUG50blo0bU0zZ3U0ckVZR2FXemxiZ2s5WVpV?=
 =?utf-8?B?bzJQdlRYZnU3S0FzbHNHUTlzOUprbDNldXgveXp5Nms0bDIzV2hPUjlERWs3?=
 =?utf-8?B?ajBhMWkralc5cmxuQlRUN0J2VzFTVno0WkNRbHlSZis4dWtNTWJLWXpCZmRJ?=
 =?utf-8?B?Rm5oWXlwM0ZZQjNCdUsvNHN3TmlNc3p2UlZkNWZob0xjaW1ITmI5RzNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmdBc0tFd0YxdFhQNFUyMnZsSGFtMGlZMzk3RklPU3NvYTJqRU5TQWw5SmNI?=
 =?utf-8?B?eld0amdLMC8yQStEUmJZaVlIQkgwY0tSdzJwam5EZS9vWExKZ3pOYyszWTBS?=
 =?utf-8?B?WFNIWW80bkc1MFhoemxWYVVXcDlqMkJaNURQM1NjYUpVQ2NVODNKZ05vbzlU?=
 =?utf-8?B?TXcwWU9vTWZGcTVYVHhIa3l0WTRTUHhUYzJEVGZscWNBb2F0dEFuWktjZ0kx?=
 =?utf-8?B?MmdCNUNBVS96RmM1MGl1am5QdFpJdEZnZnlWSlNzMWJMa0lnTHNPWjBBUHJm?=
 =?utf-8?B?Qy80NGhGeVA2dDk5UVZUMk1IM3ZkZEZuK01yd0c5YzlpK0ZrZmFndzhEaURo?=
 =?utf-8?B?eldvZmJ1TjlLY092KzhzOFFNazdSLytoOFZvZWdOcmJSRjBsWXgxMlM0V0h2?=
 =?utf-8?B?bnp5Z1E4L3RsRDZnQU04Y2xJdjY4bW5GVHZHbG9kWkt2VG95MDg1SEprcHVK?=
 =?utf-8?B?UGdDY2xGRDBnMW9oV01mUElsNmRReUlsd0pUcVNONmVlNGttMnRVbklyMk1k?=
 =?utf-8?B?MGl2Vy9XMFhxY3JCdjRMUk1TUU9ESy9GQkdNeFNWd1VwMk9SbmNVNzdIUUhY?=
 =?utf-8?B?TFFrTU0wa3B1K25KbEs5ZGkxTXhZQVNUWnFnaXNVVGo3VTAzc0RLU2dZUU43?=
 =?utf-8?B?RzQzb2J3SzlJaCswSzlCYUpQOU1JV1RqbGd6dUg2UDlHbXFkU29MNXhYUkNP?=
 =?utf-8?B?M080elNDb09BN0sySW8wNE4xbDdQS0RnazVraGhpelBxR0JQRUN0WElLMVRH?=
 =?utf-8?B?ZWdsYmtPckdUazk0RFEvZ3ZiSDE4c0xLTHZERU1qeHk5bTMwS3Q2LzZpYmQr?=
 =?utf-8?B?YU1vb0plRXlGTTluZ1R2RlRNQ3UzY05DbHppMVpoNlRiWkVYQVdNRWlRQmtJ?=
 =?utf-8?B?d2RBMkVmbVpOclV1RG9VeEJXNGpFUTgzZHk5QWRRWTJEbk4zNUllU1FDalN4?=
 =?utf-8?B?cHVSVWg0RVVQcXlqQXNVekxNRnQ0aXQwM21yMVNZM0xJTGpORExjZnh6OW1a?=
 =?utf-8?B?a0gzdUl0VmZzRldIcitOYjFjOUlscFdWYkJ5Q2VVcW9kamlmODd1d0JjZGIr?=
 =?utf-8?B?T1hVUHlmQit1cWNNdlp5cTZ1dEdtSUdIb3Qwcy9vMXE1TmhJV3BicEY3eUU2?=
 =?utf-8?B?TkE1S0lNampaQi91RDVpMUxVNUVybTJqUTFIeWRzekNWcHk4Qkt1Q050SVBC?=
 =?utf-8?B?MGw4NTlpTlVDVzJ5NFN0NUViVzJESVh3NExaSU8zU3BFYmhUck9Hbnp0OStk?=
 =?utf-8?B?Z2RhMEZQOTZYUGI1RTRUYzF2eTNHU2I0WFhQUWxxbUpzaXFtU3R0NW4yN2pQ?=
 =?utf-8?B?WXAzYmc2aXREakJKQW1kTTJMTkVnMGgvQVR6UHBINVFYTlpFL2szRjBObkNq?=
 =?utf-8?B?UG1zVVpOd01YSGE2ZVdWdFpJYVBiNGI3OVExOEs5RGVqNWYvTHhRcFVFNXIz?=
 =?utf-8?B?UjlCVUZYTHBsQzFSa3llUlVjSGJhV0hpNnZUZWxqdFlqazQ0SDNNNzNHRjJG?=
 =?utf-8?B?NTg2d3diVDNYMmlGaWtKc0pZdGx6MFJvQ3ZhVk1zSEM3SmFIakl5VVdTWkox?=
 =?utf-8?B?Ym42MmNFVDhsNkJFMDBYbmhZcHd5UzF1L3JHUHdyWTdTVVNGUFVZMWJ5Z2pK?=
 =?utf-8?B?SU5tclRrbkdYeVBZS3lFa3VlRmUyZG1XbFFLbTY5c0taT3dBUWJmUDEwRHMx?=
 =?utf-8?B?bEIzdnVwZjdvYlRvZmxsb1RkbCtMZGFPTU9ocjIvSTJkOHZjU1UvT3JmQjVr?=
 =?utf-8?B?cklxUmY5dWNIcGJrQ2pDWjcydkhoSm1OUUtoeENOVXQ2TVNDdWUwVUlHd3dp?=
 =?utf-8?B?ckxJc25QTko4S0dHM296em5zYnJBbXZPZWZKL2sxMG8zUkU2TXplS3VkQWpp?=
 =?utf-8?B?aXdnQk0xVU5WZ2U4NExXd0I3NXVVU0lwNDhwbDRmQ3U1cjYwVU5RbE80bHVS?=
 =?utf-8?B?NFY4bVNZcm9HZDZvM0NLaWhzVHpzcFFITEVZMjh5Ui96Ym5sUnpIM2NRQUJ0?=
 =?utf-8?B?d3YrQndLNGJ2ZFl6N2Jhcm1LcC96cmhUWXdoVE1JMjJPUmEwTzI1YWNoM21o?=
 =?utf-8?B?TUE4YTNCTk9XWFk2a1krcG1RWFBnbjZveHMzS2xCZUpXRUNSZ0ZETktJWHpu?=
 =?utf-8?B?TUNNS0I5ZnE2U2JpSVdza2k0WTBQN25oZmp3YnVFYkRWeVNOZ1lnTGNoQTFs?=
 =?utf-8?B?aEx3QmRsTU5aM21ybU5iZGJ4ckZLajdTN1ZCeUVReWw3UExvS2t0TXFlTXN5?=
 =?utf-8?B?dXg5djU0SlJPRkc0aXNMS1lGZFRBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R6Oo8VfhhRFC/HpbetPl10EO7yAklUYOibc4idGRnvAyDZw6IsgKQf5FH4OBbei/7U19datRCrwSmEwQ6tqwHVmGF+4TpembLEquontof2LLipXihvHhfhVVcx9ciEcrSvOhV69SiACfmziZdoSKXP2/xEN/MpOzfLsQ7B3LGaaU6AqepJcLNj1YXsFyK+Z9wmgqSNGcIyv6yL3tmC74k5BzlBnTAgUfr+RFDw0ZGR7u30O8cz8c+yKsCHTj/HyG0FXPhC8CYLCYpQHcokgl0N+Eb753nzhxmiFH3VIp8Rm5ioK0N9iA36H1q9NgaBvKAcsalEgSSgntPogyxfIZPiWR0Z7d5yCaR+14h3ZRTIG+83856/BDEUSd8XFJ6oD8LcugMf7CR82gopx6FvpuLdVHDaC8KM3RdrFgfp3sljARvYFpCRSKgeM2iYIfY8FR36t0Ga52jKRFeeEzEdypbnGnTquA/q6Gf5xIMV3eDNkRTLUMb+GO28x3Pf2j2vJZ+XJicnc/tMiXKASvnOfxMOx9ZzAK57WcA2uuLT8lBrdcc056U04r/hDcoiVmw71sjBsJsKOXOCpCO7vfcci0+NT9VogtW2zLPAtHvZo+NSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0904c9da-2bd3-4120-5e2c-08dcedbba6d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 08:22:19.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C93c8logFnvHiWkoJca1FSPVwIXr2VubZXmUOF2RAM4CB4f1yE7h2MmtCZ+ftq+V9dLia+cork53BD9QNwLRax6XrQUCRJZbMW6Preq6EvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_06,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160054
X-Proofpoint-GUID: SJ0tM6UY6FJl2n7pR2n6qh6tIpTA5ubt
X-Proofpoint-ORIG-GUID: SJ0tM6UY6FJl2n7pR2n6qh6tIpTA5ubt

On Wed, Oct 16, 2024 at 01:16:15AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 15, 2024 at 11:05 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 12:40:41PM -0700, Suren Baghdasaryan wrote:
> > [snip]
> > > > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > > > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > > > +                           bool allow_proc, unsigned int *flags,
> > > > +                           struct fd *fd)
> > > >  {
> > > > -       struct fd f;
> > > > +       struct file *file;
> > > >         struct pid *pid;
> > > > +       struct fd f = fdget(pidfd);
> > > >
> > > > -       f = fdget(fd);
> > > > -       if (!fd_file(f))
> > > > +       file = fd_file(f);
> > > > +       if (!file)
> > > >                 return ERR_PTR(-EBADF);
> > > >
> > > > -       pid = pidfd_pid(fd_file(f));
> > > > -       if (!IS_ERR(pid)) {
> > > > -               get_pid(pid);
> > > > -               *flags = fd_file(f)->f_flags;
> > > > +       pid = pidfd_pid(file);
> > > > +       /* If we allow opening a pidfd via /proc/<pid>, do so. */
> > > > +       if (IS_ERR(pid) && allow_proc)
> > > > +               pid = tgid_pidfd_to_pid(file);
> > > > +
> > > > +       if (IS_ERR(pid)) {
> > > > +               fdput(f);
> > > > +               return pid;
> > > >         }
> > > >
> > > > -       fdput(f);
> > > > +       if (pin_pid)
> > > > +               get_pid(pid);
> > > > +       else
> > > > +               WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
> > > > +
> > > > +       if (flags)
> > > > +               *flags = file->f_flags;
> > > > +
> > > > +       /*
> > > > +        * If the user provides an fd output then it will handle decrementing
> > > > +        * its reference counter.
> > > > +        */
> > > > +       if (fd)
> > > > +               *fd = f;
> > > > +       else
> > > > +               /* Otherwise we release it. */
> > > > +               fdput(f);
> > > > +
> > > >         return pid;
> > > >  }
> > >
> > > There is an EXPORT_SYMBOL_GPL(pidfd_get_pid) right after this line. It
> > > should also be changed to EXPORT_SYMBOL_GPL(__pidfd_get_pid),
> > > otherwise __pidfd_get_pid() will not be exported. A module calling
> > > pidfd_get_pid() now inlined in the header file will try to call
> > > __pidfd_get_pid() and will have trouble resolving this symbol.
> >
> > Hmm hang on not there isn't? I don't see that anywhere?
>
> Doh! Sorry, I didn't realize the export was an out-of-tree Android
> change. Never mind...

No probs :P just glad I didn't miss something in this series!

Hey maybe a motivation to upstream some of this? ;)

>
> >
> > [snip]

