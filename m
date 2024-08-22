Return-Path: <linux-fsdevel+bounces-26785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7714C95BA7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E12E288609
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237D1CDA26;
	Thu, 22 Aug 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ptt2VT+f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SMxVOOgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191129CE8;
	Thu, 22 Aug 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340611; cv=fail; b=EFiER9/Qq9kTEbM7mJiRrWIQEiiTZAY4EoP8wDFb/ZNIYAUgD5lSL0VJD3GmA5QEJLDOaN1nFn9AgvrAUBiGPSVHJk+lL334FJ06RjROmyR1PLv2UgHKw4Xz4gpkXsCnvGEADzE7intBpIg73G/D49/pOOroWGi1a3IaXe7c0Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340611; c=relaxed/simple;
	bh=C45ekd932JLLsI6PD22kk9k3qR20RTlBDxIkh/IY+iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6qlHjkgZtQywNPFazDvUeWXvrJgD0QQSmyHul5TdidX1nyytUU2T+KyfWaviOfkNZ1NVJs2gSDFj7iCArPvUjS6Syn2wbo263J9nNE/FLtjvAbeAZhilRTLR9O+c4SdBxnmaSDyPxzyuYheRSoGYHYSXfdHiRoQyEh/lq6nsLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ptt2VT+f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SMxVOOgZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQVUB028663;
	Thu, 22 Aug 2024 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=8TF4JZJgoeXP8bLvXl3ylyyRU2fXe1CDVAevPdNNJmw=; b=
	Ptt2VT+fJ+tdSJC3lCIihyj06RH+mwN0xhuqBrhJeYfNcXx0VOXWz3pfSI0cx3Ph
	BEy487cjN5ibg5sEgkNFj7sQLqOGzSIB+ChTRvOuOUmcGqTcgukK5xhLQmW2vSpZ
	czQXUEnUdprHj27WQOWokrD66csHjPrQiTtXgxjXbP11rJQgL2bTQJHuNi2HcAkU
	abkmzUx6XintEOQ+0PLClT+SAoqfeqGT+/7nkAyjDOcf8ziZvSkKZkwhtqqjXXjJ
	KSUWCID/KvD0Ie8OzxXdEgjg7SxLw7ISifO9lovX0RL2yRnTGZ6UnJHP10b8lSs2
	ssxEAVBzmNoXGFjPh1aIkA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2djcuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:29:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MFCRfS038541;
	Thu, 22 Aug 2024 15:29:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4167s68rfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZPoUkBHasgIRt6mRwZ0fhwPHhNMBpXaiRm5PZGoXGWCjbjx8B68YvdA50lOjHY7qz598y5JgrztVEYMU8N+AqS7EyJHAIG16b/WtYYH/17TYnkIRDuE8/MLA30E5MeHpIoYtT8lBzcUbs8ZgQOyPptBWgh0Q2KRRng6Rb5RKDWa94m0JgCjm3Erjx3locKG4XfMXaW/wGZPJ9eA3kUvtP/zGRNIuBOpLFm8xY2CBhju9ZSkl8MmMDavCbAceyP3uYsod+OpeTjgKrP47Ky8DjpilKwXNTWFaEEGuZ4VbpLQf4Ez2ik72qV6xDBWGPFm0wHhHzzJ8i0oPCOP5Xl0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TF4JZJgoeXP8bLvXl3ylyyRU2fXe1CDVAevPdNNJmw=;
 b=kUChKLvrjbsXIWPx/1UF7uJq1e8mE7hkAhO4XOvGMIu3USEL6+O+lEoCwKK5WYtCqRu86kxnwzaZ5bXGXs9MPCeBp63hnTKGiFyNGjnJcJHVnrvnJwiuqLoyjIIqAmOpFlFJZ0uxGJyNPAvvJ6VJMALR+/O2Ej/NXJZYTe2pkRqMjltigkVsV3Fr2eqgo4ZF3m6D1NczDJp+y0JW1RY+9b2dalbMawzmcGiDNV1t+ACB5yPlGPoHHCJPdu7dXKS/r2MqqeewEi1PnTybx63OkunLy/+XxxezFAl77B4hkUGRipWELa9RYcoD109Lr1lEduO8knvYX9U7f3vrVLYtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TF4JZJgoeXP8bLvXl3ylyyRU2fXe1CDVAevPdNNJmw=;
 b=SMxVOOgZYAfbVGZQfHM2Qeu12UhTzu2FF/qOsfDdnSRrTx3q/fvU/bqDTBNF+JhLW/CYY3XE7O9dCDmFw9SK1mIsDLDIIPCzy+Jq8uEzX3QpyqX1cPgQdwfXDLf+XN/BixdFRkhiEGsu0F4G3V1zZ3Tl4fMYU+Y1K+26pvB+59w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 15:29:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Thu, 22 Aug 2024
 15:29:38 +0000
Message-ID: <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>
Date: Thu, 22 Aug 2024 16:29:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] fs: iomap: Atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-4-john.g.garry@oracle.com>
 <20240821165803.GI865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240821165803.GI865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9f42c3-cf80-444c-479e-08dcc2bf3bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNJWDF0UmVUOWhONWkyYStFMlZ5RHF5emk5eFF3cll5TWFXcWZFSzhoM1Bz?=
 =?utf-8?B?azRVOG93QUNHL0NIdWl2aDEwZlZMa0NCdDRmQzFGSnBlV2puWVZsYTU2RTU2?=
 =?utf-8?B?b2QyYkhobnh1T0F6cnJnVEZFY1Z2d0RDUDUxUFpaNHU1eEJmQ09udFJXQlNO?=
 =?utf-8?B?Uko1VUp3Rm1TMjV6RkIxaU9MdEs5T1lsVlFjU0xoRlk0dDlzMmIwM21vcHNp?=
 =?utf-8?B?Wjl5R3lFZDBNVmNVZG9qczNTdHBiZjVPUkFqdUVyTkVLOG54S2dBOHBUR3ps?=
 =?utf-8?B?U3BmczBQRFEycGxaK0I0VzdQUU1iZ09LVzREcHAyckc3eE8yRndWM1lhbE15?=
 =?utf-8?B?QjRHcWxMQk5GMmVsQjYvVUZpK0Z5U3g3OUwrU3pGbTdza2hjQ1B2R1R1emND?=
 =?utf-8?B?cnlGTlo0WXd2TisrL3VQQUtoTXNqSitibkdYMFBFYlROdll1QzhtaUtNNktQ?=
 =?utf-8?B?VXJ1UEFyZmhZMlBjTzVMUXUxWm45cExQQWQ2MHQ3VDhqQ3RINURJZWZkeURH?=
 =?utf-8?B?dXZIUjdYL1VMQTkxWEcwUmJRVXl3ZHYxMVA3YmFoTys2em9jcVZxQ245MVlU?=
 =?utf-8?B?czhKcmRmcndqRk1PcjVrYkM4QmV5V251SUdvSWd3NFdGLzFMMEY3UUNxaElK?=
 =?utf-8?B?Z0hjWXN3bHJqY2xYQk9lZktkZXpnUWtXVGxkVmx0TEZSZFovUkptWkgxTW5k?=
 =?utf-8?B?NDNTYXpzeU5wQW81OStVaHJaSjZ1RVlpcFo2M0tmQ1VSdlE4M0pCVFM3ZUNs?=
 =?utf-8?B?cnh0U1o4MWcvVFJwaGxUQWlkdm51eHo5R0t5UzVqcHhycUtYL3FraHprYy9D?=
 =?utf-8?B?bjdsT0dLcUl5YURobExkbGw3R3pGbXNXSWd3NXFWVTM5UHpKNXNyWXllTXZG?=
 =?utf-8?B?RHYyaFBxZFFhaGJlUXprSVl3OGZJVkpNZlFsS3VmT0doSzlqMUVzTUs2VFRk?=
 =?utf-8?B?VzVMazI4Tm9UMEp6bkp1VTc4V1BJMzdVanl5bG03WDVuOGl2ejArRHJDS000?=
 =?utf-8?B?TVFFcy9sb0ZGN0tsTzkxQ3A0bUdwR3JHSHRzc1hQMHZLN2VWb3oxUmg5MGJy?=
 =?utf-8?B?ak9VOEJXTjVGMzJ1enNiN2NkeS9HR3JpMU9FMDVBT3Yvb2xZS3V1Rk42a1Nk?=
 =?utf-8?B?UlIvRjh6Z1pMSDV1MEFtK3d0MXRVbk5KQWNEbEQ4NGtyM2Zsem8wU1R1dEg4?=
 =?utf-8?B?czFnVVozRmNaMXM5Q1FJcWlXZ1Rxb2RIYWJoZjNNS2p2ZWs1TnVCNlZzR29k?=
 =?utf-8?B?RTMrNGV1TEtkaHBlckp1SWEyaFFrZ04rM05vNDRSMDJiZFlGeHd4cEQ0dlJq?=
 =?utf-8?B?SEYyZFJXTmUyU2NWYkdwYk5qNHl2UHBoUGlSSTdUcll4U0syY3ZMdVN3QlBt?=
 =?utf-8?B?TTNUaTB0TmRxclNvSmVFanRKTWN6Vi9iaE9DdE9VR0x4M0JvZkkyY1FnakFr?=
 =?utf-8?B?dURCaHlCZHBmSTQ1eWY1cTJTSm0vT3l2TGcxeXJkdUZZVHg4UysyNDFFNWVi?=
 =?utf-8?B?cW5jVGUyT3VTbnNGcG1TZFNlcjZrR2FjWHgzM1M4aWRVQWU4NzZSOVE3dGY4?=
 =?utf-8?B?WE13dFJpcy9FUTJVQnVqQlgvZjV6R1hwdWJyK2o4N2RVNjNUU0xSbVdaekwr?=
 =?utf-8?B?S04vSGtCZkNsazJsbHRLVGVJeS9NZUd6UzQybFpRb0pDT1ZuQVBFdTFydllT?=
 =?utf-8?B?ejgvcDNLc2dEc0QrMmh5ODJMcGozNC9rejVlcVVnR0FwM0tCZU1KY0pGc0Fi?=
 =?utf-8?Q?IWAtecInBSQHhkIz9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FGOGpuSk5mOVRzYmZOY3VBeFBFMG5qb1BoUEN3dXEvc2tick9MS1M0a3Zz?=
 =?utf-8?B?QUd2bXM2L3E5RERxRWIvN084T01CUHVOTVZnK1ZjOHJjOHpyeVdqZi9kMUk1?=
 =?utf-8?B?bTFkVWRhMVA5cFg3eHZqOUJmMUc4RWdSVE1ldkl3R0JGTUdKUngwdU9PN2tI?=
 =?utf-8?B?bUtDQlpBRmpQQzdsMTA2dzRuT2FUbzVHdEYyUGsyMGI5VGUyaWUwbXZ5T2x0?=
 =?utf-8?B?SlFmVmQvakZRcVRxUHZPckFnVlZIMXNveGIwWlRYdm5vMlI3cS9SbmFyWFkv?=
 =?utf-8?B?Wk9OTzRyYmhTQkZJQm1wQUlnNEZwaGdnd1o3ak5yNGY4YUVvTEhEUGdvS2lN?=
 =?utf-8?B?K3BZWFBGVTNkVCtNZjhBVkVTV0l5VkFSVm9zTGpXUzNsUFdSUEN3WFVwblJv?=
 =?utf-8?B?WFlNWC9Bdy83L3M4Z2RyejFocmxkbm5PZGsrbUJPcnZvTEo0YkYxMjIxUUE5?=
 =?utf-8?B?aHlDbDdOSko4czNHSUZNQjBUbjVubkd0WDVQV1lqV0gyZDgzTHlDN1lUSUNu?=
 =?utf-8?B?QXVwWlFzb3ZWaGVwYjRraVVheXU4Y1lWUDFPWG5DNk1rc2g2dHZhMzJITGZG?=
 =?utf-8?B?eVpWM2pzenhzN0dTaVMzSEN1ZGRrVklJUG10TVR4SVhpb05iUDZ2THZGVTVY?=
 =?utf-8?B?RTMwWVg2MlY3VlNrZ2FYK3FlbkRGcUJ5WE5JZTlJYjNRZys0azJKbHU1R0lE?=
 =?utf-8?B?ZXY1RndMRitmc1hjLzBIWVJCdVQ1N0NXVy9ySFR5OTR2cnFwejg0N3JISUZX?=
 =?utf-8?B?bG1zeVlVK2dRSThNUWNSc1FDZi9ObzEvVkJWWFYwWUI4ZG1RQW9ZMkw3Y2VT?=
 =?utf-8?B?R25kM3BnWkNvOCs3YnFaQ2RNMWw2bTgvbUhVL0ZNNThRNTJQcGU5ZzlZMFpE?=
 =?utf-8?B?Y0NnaURSbUpvbkNIRW12VTdnRXZvY3c5dmVMcmd2cTlSL2YyOGhTZGEyZmF2?=
 =?utf-8?B?cGluejVscitOYWUzeWJsZHNmcEViMlp6bnFLQ0s2K2pmcjRRZmRuOUVtT0hh?=
 =?utf-8?B?cUZwTW52a3F1ODlldHZaaDZRMmxOclJ3SEM5UkhwTUxtY1JhNjh6bDcyMjVE?=
 =?utf-8?B?Y1JoNUI3eHI1Z24rN1JrbzM5OUg4TTRCNDlhMkJadGl1dmdNejM3bGlhd0Jy?=
 =?utf-8?B?UXRmaEMyNSs4SnFkSkttNlZkbm1PYU5TYmF0MEFua2xaK09JTUsvejVwdjYy?=
 =?utf-8?B?QVhJZ3E4Z2huSS90dDBiSWZ5b3dyRWFseVY5Snlsa3dNVkJVL2NWd3lramEr?=
 =?utf-8?B?UGZyZE9JZW5TYW5ENnBuMnBESk90Q0wvU2ZnR2QvYjZDdk5oL3BtTVY3c1RV?=
 =?utf-8?B?Q3VNMW5OWVdJMGR1aGRVWW9Ca1hWbDE2SE5jZFRkWFlwYUEvZ0lsRVJXSVAv?=
 =?utf-8?B?TEdGZE52TTY5M2FxZUdYQ0JCRnRKMkRGOFFQZzVWSm9zY3dMSVJubzNOdWVv?=
 =?utf-8?B?VjBkeDNzdjZBdFhkbm8xM1hoNHBaQnR3Y0NySG4rem5JS3VaUkxUY1lINk16?=
 =?utf-8?B?M1R5T2hQQStIMjhmM014SnJzRVZNbkZaN2ZITnZaekU1L0p6Qm96Ny9ZZFlP?=
 =?utf-8?B?ektwQzZTWEVZUUsvcVNoWCsvZzcrRWpMNHpFWW1GT2dsakkva2FhOE55TDRQ?=
 =?utf-8?B?OUI0eFgxSk8zMWtHd0FMM0ZpbElUU044ZGNPVk13MUtERmdiWVhVN2xWUVFv?=
 =?utf-8?B?RStpNGFtQWtpWFg3SUxZa1g5dy96cmZQdDNBTVAzSTlINnpVVlBZWWtFbG1N?=
 =?utf-8?B?bFhJTndKQzJqRGduZ2I3R1lXL2NkZUxTQzZVQnVXWVRVZ0F0QXNwSzVVQS9T?=
 =?utf-8?B?bWRtRW8vQld4OWs3dXg2TFJSZ3EzVHoxaHhTTWhuRmFJL0pKNTJ5bFlBQ3JT?=
 =?utf-8?B?SnMzUjhvSVI4ZzV4TU1ReFZvN0llTXVlbSt2bmNzVUlocFZtakNDTmEvdGJ0?=
 =?utf-8?B?OTVhOFJObHpYbFBXbmNacHRyVzZrOHZxZVZRakFWUy9uTjhwdlZOSTlZVGR0?=
 =?utf-8?B?cmZLa3hQc0FXM2tkRFJKcVcxcG41ZWlQN01CeEI1U2xramwyY3NnSTVTMHZC?=
 =?utf-8?B?QkNnZFQvYzJWWXIwdGpZbjdkeUJnblcxVzJQWEdsU3RybnZkL2FIbkVXSmJ2?=
 =?utf-8?Q?p5e0mWCFc3/QXtHJj0G3WA1o2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jAAYI33zi/eVABxh15XZZBUFcPPtr7L+dYJAk26EDlkb9trTRqBxZCLtNx6g44jn/O4sUvqqwZNb6DIQe8YaQ0OMbukgcpmgM8mbuE+lAHZcTpvc5SZJRNeuGkH+4j4xFC51fj/56H8kBGV/CHujIvzGC1xwWXplWcy5K+xeg04gcAp5ZoZtZzXDYTpEkAJuJCl17JOsQjLN2OwHmfbG48wrQJwxgEzLWLTKUESo2UTXdW3v2xCeVPuMrGfdx6iYVX7eUqLhBwp53e0hKP6dELguNwxblMrpwkOZZFGS8/Z+XIKDh+gn5BH1ap988UZTwS8Glhw4SxJSoCoq9GZ+J+ORNRykhRxFHctRIOz3THGww/gtv0gkDQT7OdEJgsOJ0CvOcKDlJu22K7eh+xFs42n2VIa6G+zMIHWTo+NBJb9nj7wECONgoxMTnJiInS/u2+k7leubM42K34RGQC5nXCnKg3mAuHvr4hUXhoQPO5UtWpcaKn9THtmRV5Nxhh8P7Ww+dsLVgPmS6j17pz4GPNubeI4Gi8G54ohHhX5HkP8uCpc5BAbI8KWfmYjMu7NgA34NQ5g1pT9PCg4NxxqvmKYFcSlslrhSX2sHsPKCdDc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f42c3-cf80-444c-479e-08dcc2bf3bf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:29:38.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8qfjToShE3tdnn7NlZTQdpuTEV9+3IJHyX9Yo8eehdWBZJD7YO/cdeVBH7Nf77aSu8o/kIER0JnK39t/I1dvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220117
X-Proofpoint-GUID: aDSjkdmRi9uiTyZ6mdo6p28_Cz2EAou4
X-Proofpoint-ORIG-GUID: aDSjkdmRi9uiTyZ6mdo6p28_Cz2EAou4


>> +
>>   static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio, struct bio *bio, loff_t pos)
>>   {
>> @@ -256,7 +275,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>>    * clearing the WRITE_THROUGH flag in the dio request.
>>    */
>>   static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>> -		const struct iomap *iomap, bool use_fua)
>> +		const struct iomap *iomap, bool use_fua, bool atomic)
>>   {
>>   	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>>   
>> @@ -268,6 +287,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   		opflags |= REQ_FUA;
>>   	else
>>   		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
>> +	if (atomic)
>> +		opflags |= REQ_ATOMIC;
>>   
>>   	return opflags;
>>   }
>> @@ -275,21 +296,23 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio)
>>   {
>> +	bool atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>> +	struct iov_iter *i = dio->submit.iter;
> 
> If you're going to pull this out into a convenience variable, please do
> that as a separate patch so that the actual untorn write additions don't
> get mixed in.

Yeah, I was thinking of doing that, so ok.

> 
>>   	loff_t length = iomap_length(iter);
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>>   	struct bio *bio;
>>   	bool need_zeroout = false;
>>   	bool use_fua = false;
>> -	int nr_pages, ret = 0;
>> +	int nr_pages, orig_nr_pages, ret = 0;
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>>   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>> -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>> +	    !bdev_iter_is_aligned(iomap->bdev, i))
>>   		return -EINVAL;
>>   
>>   	if (iomap->type == IOMAP_UNWRITTEN) {
>> @@ -322,15 +345,35 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
>>   	}
>>   
>> +	if (dio->atomic_bio) {
>> +		/*
>> +		 * These should not fail, but check just in case.
>> +		 * Caller takes care of freeing the bio.
>> +		 */
>> +		if (iter->iomap.bdev != dio->atomic_bio->bi_bdev) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (dio->atomic_bio->bi_iter.bi_sector +
>> +		    (dio->atomic_bio->bi_iter.bi_size >> SECTOR_SHIFT) !=
> 
> Hmm, so I guess you stash an untorn write bio in the iomap_dio so that
> multiple iomap_dio_bio_iter can try to combine a mixed mapping into a
> single contiguous untorn write that can be completed all at once?

Right, we are writing to a contiguous LBA address range with a single 
bio that happens to cover many different extents.

> I suppose that works as long as the iomap->type is the same across all
> the _iter calls, but I think that needs explicit checking here.

As an sample, if we try to atomically write over the data in the 
following file:

# xfs_bmap -vvp mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..127]:        hole                                   128
   1: [128..135]:      256..263          0 (256..263)           8 010000
   2: [136..143]:      264..271          0 (264..271)           8 000000
   3: [144..255]:      272..383          0 (272..383)         112 010000
FLAG Values:
    0100000 Shared extent
    0010000 Unwritten preallocated extent
    0001000 Doesn't begin on stripe unit
    0000100 Doesn't end   on stripe unit
    0000010 Doesn't begin on stripe width
    0000001 Doesn't end   on stripe width
#


Then, the iomap->type/flag is either IOMAP_UNWRITTEN/IOMAP_F_DIRTY or 
IOMAP_MAPPED/IOMAP_F_DIRTY per iter. So the type is not consistent. 
However we will set IOMAP_DIO_UNWRITTEN in dio->flags, so call 
xfs_dio_write_endio() -> xfs_iomap_write_unwritten() for the complete 
FSB range.

Do you see a problem with this?

Please see this also for some more background:
https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/


> 
>> +			iomap_sector(iomap, pos)) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +	} else if (atomic) {
>> +		orig_nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
>> +	}
>> +
>>   	/*
>>   	 * Save the original count and trim the iter to just the extent we
>>   	 * are operating on right now.  The iter will be re-expanded once
>>   	 * we are done.
>>   	 */
>> -	orig_count = iov_iter_count(dio->submit.iter);
>> -	iov_iter_truncate(dio->submit.iter, length);
>> +	orig_count = iov_iter_count(i);
>> +	iov_iter_truncate(i, length);
>>   
>> -	if (!iov_iter_count(dio->submit.iter))
>> +	if (!iov_iter_count(i))
>>   		goto out;
>>   
>>   	/*
>> @@ -365,27 +408,46 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	 * can set up the page vector appropriately for a ZONE_APPEND
>>   	 * operation.
>>   	 */
>> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
>> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
>> +
>> +	if (atomic) {
>> +		size_t orig_atomic_size;
>> +
>> +		if (!dio->atomic_bio) {
>> +			dio->atomic_bio = iomap_dio_alloc_bio_data(iter,
>> +					dio, orig_nr_pages, bio_opf, pos);
>> +		}
>> +		orig_atomic_size = dio->atomic_bio->bi_iter.bi_size;
>> +
>> +		/*
>> +		 * In case of error, caller takes care of freeing the bio. The
>> +		 * smallest size of atomic write is i_node size, so no need for
> 
> What is "i_node size"?  Are you referring to i_blocksize?

Yes, I meant i_blocksize()

> 
>> +		 * tail zeroing out.
>> +		 */
>> +		ret = bio_iov_iter_get_pages(dio->atomic_bio, i);
>> +		if (!ret) {
>> +			copied = dio->atomic_bio->bi_iter.bi_size -
>> +				orig_atomic_size;
>> +		}
>>   
>> -	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>> +		dio->size += copied;
>> +		goto out;
>> +	}
>> +
>> +	nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
>>   	do {
>>   		size_t n;
>>   		if (dio->error) {
>> -			iov_iter_revert(dio->submit.iter, copied);
>> +			iov_iter_revert(i, copied);
>>   			copied = ret = 0;
>>   			goto out;
>>   		}
>>   
>> -		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
>> +		bio = iomap_dio_alloc_bio_data(iter, dio, nr_pages, bio_opf, pos);
>>   		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>>   					  GFP_KERNEL);
>> -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>> -		bio->bi_write_hint = inode->i_write_hint;
>> -		bio->bi_ioprio = dio->iocb->ki_ioprio;
>> -		bio->bi_private = dio;
>> -		bio->bi_end_io = iomap_dio_bio_end_io;
> 
> I see two places (here and iomap_dio_zero) that allocate a bio and
> perform some initialization of it.  Can you move the common pieces to
> iomap_dio_alloc_bio instead of adding a iomap_dio_alloc_bio_data
> variant, and move all that to a separate cleanup patch?

Sure

So can it cause harm if we set bio->bi_write_hint and ->bi_ioprio with 
the same values as iomap_dio_alloc_bio() for iomap_dio_zero()? If no, 
this would help make all the bio alloc code common

> 
>> -		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>> +		ret = bio_iov_iter_get_pages(bio, i);
>>   		if (unlikely(ret)) {
>>   			/*
>>   			 * We have to stop part way through an IO. We must fall
>> @@ -408,8 +470,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		dio->size += n;
>>   		copied += n;
>>   
>> -		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
>> -						 BIO_MAX_VECS);
>> +		nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
>>   		/*
>>   		 * We can only poll for single bio I/Os.
>>   		 */
>> @@ -435,7 +496,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	}
>>   out:
>>   	/* Undo iter limitation to current extent */
>> -	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>> +	iov_iter_reexpand(i, orig_count - copied);
>>   	if (copied)
>>   		return copied;
>>   	return ret;
>> @@ -555,6 +616,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	struct blk_plug plug;
>>   	struct iomap_dio *dio;
>>   	loff_t ret = 0;
>> +	size_t orig_count = iov_iter_count(iter);
>>   
>>   	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>>   
>> @@ -580,6 +642,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	if (iocb->ki_flags & IOCB_NOWAIT)
>>   		iomi.flags |= IOMAP_NOWAIT;
>>   
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		if (bio_iov_vecs_to_alloc(iter, INT_MAX) > BIO_MAX_VECS)
>> +			return ERR_PTR(-EINVAL);
>> +		iomi.flags |= IOMAP_ATOMIC;
>> +	}
>> +	dio->atomic_bio = NULL;
>> +
>>   	if (iov_iter_rw(iter) == READ) {
>>   		/* reads can always complete inline */
>>   		dio->flags |= IOMAP_DIO_INLINE_COMP;
>> @@ -665,6 +734,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   		iocb->ki_flags &= ~IOCB_HIPRI;
>>   	}
>>   
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		if (ret >= 0) {
>> +			if (dio->size == orig_count) {
>> +				iomap_dio_submit_bio(&iomi, dio,
>> +					dio->atomic_bio, iocb->ki_pos);
> 
> Does this need to do task_io_account_write like regular direct writes
> do?

yes, I missed that, will fix

> 
>> +			} else {
>> +				if (dio->atomic_bio)
>> +					bio_put(dio->atomic_bio);
>> +				ret = -EINVAL;
>> +			}
>> +		} else if (dio->atomic_bio) {
>> +			bio_put(dio->atomic_bio);
> 
> This ought to null out dio->atomic_bio to prevent accidental UAF.

ok, fine

Thanks,
John

