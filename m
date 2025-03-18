Return-Path: <linux-fsdevel+bounces-44349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D69A67BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885F33B7CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E073C212D63;
	Tue, 18 Mar 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W8MB8ao8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wc7puSvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67341917FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322062; cv=fail; b=T7/C8DRB0gWLeYw/nEY1jy21+HvtdGXaFoFtjmomupDQCjpuRo9eybjaZCGvS48ST6zczlHXiYcd6gQ2RTpI9D54Sem/lhNic+9glZKuxXxQFKGYgNvlquCCqETrO2/Ert5XI4lSh3AOvFMfNY8L27aHAtVM85m3n86rSeXsRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322062; c=relaxed/simple;
	bh=kpLeNkBew31IQp8FDc5iLjqnJnviqpR11+UFU3koz00=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=BD4SpDrtCiFWqVGtGGhcbuxc+Rgn48zZPQZSn0n3rna1dbIN2GPnk0ewUg+5tFj02TS36oJ0LK0hQ25eOWqky6ElljUTJ+jVaPP1EJehGoetygsqDUi/L/jeeIsmgW2Hz9vNr0TF9CEi1TnTFeX7985l+eM6NZzY3ojZ4302Yfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W8MB8ao8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wc7puSvl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52II662V029209;
	Tue, 18 Mar 2025 18:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=TvP6SBnxar8M6wcn
	Yc0zqyDM6a0Hv7XNde6F5Exm9OM=; b=W8MB8ao8M6bJGcdn0SKrREOGdp8PsRoL
	83fQ7xlAjbHBIfoi0deN5mxqvGD7rU/kvLfSDvSxmMbyPl35I2nn6CawiRm8ExK5
	wJLWTM3meovbhbrkvujOxMx87NEEtBSZM/A5v0vjkMSIpalVjBJ7N0dvxV3QbqmU
	KkBlAVzzbC0oQVAgtFGGuCGK+LtG6GLosU6QmdeXEyXhK8KUbVD0M+MmRZlU+ky9
	U/7BQLK2RhsXJx8fQ6YkjHKvhruP2i/S34rq4UfJLeN6RoydKu+pcKr2JciIz+pf
	SdZBEAQaH1nkS9yQx9cRIpOPj4r54ITu04UhCGrb46gljuGO50jw2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb5wx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 18:20:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IHfjt8027925;
	Tue, 18 Mar 2025 18:20:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxddss0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 18:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4IDS/x51Hk6+OJBpfqoLiZiLzhUsroO3mNrbEHnjAsExSCEI5xo90f6pd/Lc3wpX3Uf2rf/j/CsjevmCe8uU8G+pUuK1a7ZLUcp0mP04iFpgTxMdK/2A0rFBB9zXZ90hwbRCXafb7+WK1U/h4ZLwt1wikK67/zzlPzq0YcL9qc6iDm/nDKTIr/68SB2FdKdA41EgPrbn8Hw7fsOTAxaJleXAuY2mGcPXcxipVOjIMbI4o6JS6h2uET4KjCX+ZXqLz0hYr45kk69hGVNiDHsrVfXk9zx8FZEa9V5eema7HFp12y1rXnMBiYrpp6ehWDqHOafGZvJJR0gEOakOCSMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvP6SBnxar8M6wcnYc0zqyDM6a0Hv7XNde6F5Exm9OM=;
 b=j1quvgjnVyRH5Ws5zpipDN1f/tiGO8X6y6eiqe4RisTmFCh1rLJ542+6JmMmKOw2zQMfqCNvc/WCbhIA/d7SUyeB+JrXt3Wrcz5zBUGPJkULm1HtvNl+ergmSzdGPHZx1JB0wlnarrDhCKgzKDN22QFeR7AJnuTpsuwxASFaIDl45RqDmiP5p5jcgJUxzj3VHd/Q4WxXG8Axv+kGECaH1Xum1GAzGsD4gQklzaA4qyvtgONopI/Cl+LGdNvXKT6yMOeJvqW0aaURqJIm9LaS46MhNvoDmQxbTrHCzXrfRNXMAcZOgC/VbAtiTj4+dXE3D+yRMeAe9CQnZlU14VHFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvP6SBnxar8M6wcnYc0zqyDM6a0Hv7XNde6F5Exm9OM=;
 b=wc7puSvlTsVts18/g6XooxmceTAQQUUeuGOG+Dxxxzdq1JC+7ZEKwczGRLMl9lZLIokBjoTFaox4TbY7AbEcEq3y9X3B7fH18JSBuYVgJo9ztlqnPyUmbNn9BJZFz+2QygFMCFGaeRwUbkwpRV9QAaNIeFO3p6qHSk+G3q51a6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 18:20:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 18:20:55 +0000
Message-ID: <61e45688-07e9-4888-855c-b165407b3817@oracle.com>
Date: Tue, 18 Mar 2025 14:20:53 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc@lists.linux-foundation.org
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [LSF/MMBPF BoF] Request for a kdevops BOF session
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:610:11a::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a30881-0ed5-4a56-bca2-08dd66499f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z05JUmNoRVEwUUpoWGF2Z29EVDdjLy9lT0tJbjlMTnhPUVRwL3E0RFhpSUhh?=
 =?utf-8?B?b2d1QWcyYlpuVXd3M2lUYVVIRmtaUXFBMFBIUWV4WGlHcjAyazZvYXFMS1Q0?=
 =?utf-8?B?V2krSkpRTVpDUVZKYi94bXRxU3VTK3RpNHNzQ2dBbWl5dDNFQVEvYzdIV0FX?=
 =?utf-8?B?NkVUWFZrZVFYemYyNkJEb0FwdEEyNWhUUDdKYm9HZ29FazBCSFgvVDNIR2hv?=
 =?utf-8?B?RzJsb0VaQUFXSUh4ZDZjRDBrcmx1dGo4VUZmQ05GTU5pc1B2VU5BOWxIZ2Vl?=
 =?utf-8?B?OGxrKzBrK0pFclFVSExXZzlqZEpUalpoT05iTDFHeVVxZXoyYk8vQk9lQmhl?=
 =?utf-8?B?bWx2MDlwODRWejRVUTZuM0xWem9LVDJyZmxaUUdLU0EvME50QU4xbkZra0lv?=
 =?utf-8?B?MW00Z0lwZktlQVQ4ckphRGJOQk1DN3NHWk9XMm9EWkExUHo3MFRVNzc4bUhL?=
 =?utf-8?B?K29nRUttVHJjOVNqdmNNeStLeWY4VjV3TGUxVVc4U0R3eXVuYnB4d2g4UVlN?=
 =?utf-8?B?TDZUUXM4WVRzZDZGTGdReWdIeU9VVGVDTTVNaGVnNHJESlBaVUVWbXg1TVNC?=
 =?utf-8?B?STJmZS8xQ3N3TnpGUzJ0QitmNEJCT2xWVGVoRFB6NkY3RUFXcStSNFlQTTA3?=
 =?utf-8?B?TDN1aU5DZ2ozdldETDRrU1pWMkhVUWMzNnNYODZ5Q1hQakFzZUgxa2ZIRE9X?=
 =?utf-8?B?R09OSTJrTVI3dnB0L3VQMWlSQmg3TkpLZlpUTFdRaDdpTGRZQm1oaXY5Mitu?=
 =?utf-8?B?bXpiem1WNmxUdDZwQ3REQlRaNVU3T0MwTEdpMXZKd3lzVlIzUnlUdEc4cGRD?=
 =?utf-8?B?b0tXMDYzcjRxOFNZR3hGRWNTS1M3Q3BOYlg3VUhPTTgzY2R4K0J1Y2NaZzdX?=
 =?utf-8?B?VUxlMXN2aGpiV09vZW9PWnBqc1lhd2xNTlRCZDB3RmdKSWtRd1Z0dHVOZ0JN?=
 =?utf-8?B?K2t4VFB1YTFWMVNTZ1VUOWVXakFsRll1ZC91RGQvMU9YaG1BcTlKb3dUNCtC?=
 =?utf-8?B?bFZIeUtuZGxWRWsrdk0xbFgyWi82MTJ3YmNmWEU0NUlYbjUrWWNjZkEyZEJr?=
 =?utf-8?B?bTJRbGk4QmpYOFdtOTJETjBNNG1CdEVxYXBFVWdBOGtsYnlkbXErTEZvRjZH?=
 =?utf-8?B?QW1ORzAwdEx2Z1pBb09EVnltbktYVEw4ZytQcUdZOEFXU1pWWENBejl1RWVW?=
 =?utf-8?B?dVZ1dHczTVJIZHo5SlRGbE1vaysrYXhoeXdXaDRsdEtMWGNJR29uVHI4bTlk?=
 =?utf-8?B?K0oxMlhKd05WVWpSWSs3NFpEdXZzdFQxOTZWakVrV0xJbCtCdzZsNWt4K1pY?=
 =?utf-8?B?MU9GVnNaMHBOYys2ZEhYb2g3RUZiWmExeHN1UU9vcVVJMjJKNHMxeUMzVG9Y?=
 =?utf-8?B?WVFpRCtHTUNDTEc5RU9raU8yaFR6WVY2UThzQ2ZsYlZkU3cwWFVJbzhkcFYw?=
 =?utf-8?B?b1MrbzVHSzhNOFNKY0JCZnRXNDZxL0dMUG42MTRsdm9qY0lQTTlvVFBrTW96?=
 =?utf-8?B?RWlLYWdqNmJ0YVVBMnFJWEVhYWJHWUNsYVA2YWhEaWF6anh6STBOWmtOVzY3?=
 =?utf-8?B?Znd3M2YyZTZtSkxySFROeWpzam4vaTllcHhJdmlBSXlVM3QwNTRBaC9Ra0dH?=
 =?utf-8?B?eG9FU0Z4SnJySnFMTVZMeUFsZktVOUJYSnBzWXFhN1I2bWhKRnJHaXZlY1N1?=
 =?utf-8?B?K1l3djR1QWtjQ2c3SXoxaU95VGtvZ0s5dFVKY01aU2diWUcrc1FaWkdGUFNC?=
 =?utf-8?B?VXVrejVSSGR0Wnd2UjRKUlcvNGRoZzBJeFArWFpBdVBiaHlCR2N3RlpTQkQr?=
 =?utf-8?B?M25iWmVGaU15YjNSMnE1bTY1NURyMGM3OXFWMXJTL081T041ZUVUNFJoRFdI?=
 =?utf-8?Q?4kSu26y61LHzx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGgzcG4vWmdEdjh1eGZqc1BEeHdLajBMNWRaREYycnlHYWRidzhoa0I4MU5U?=
 =?utf-8?B?VFoxbTNWZmNuZ1JjcWMxdlBic1AzMzlwUlhkNTZ2aHZtdTc5aFI2cm9ZWWpz?=
 =?utf-8?B?WUxCdXpPOUllbXlqMmN3V1p4aVVlZWUxaTZ4ZVFoOUZVWFVOaXpIeklXdEZh?=
 =?utf-8?B?aHhrWlFxOGxxdnlaakZab2thVzIzamVFWWowVk5TUURGWmVmUkwvcEZCSVQ3?=
 =?utf-8?B?YVhKaUQxbml5dG9lYzVZcG5wN3k4VWxJL01RdWYvbkhBcUNWeXduM0JrSjZr?=
 =?utf-8?B?OVNPL05Ncmt5bXJLcTZhU28rb2V0c1dyS3BSbnBIZlJCc1RDSnQ3UTdLdE9I?=
 =?utf-8?B?VVZsaGJ3TW9HVmpQOSt2SnNiMEhJeFc4djhNVmNiRW4zRGgrK2tOVUwybm1v?=
 =?utf-8?B?V1htanB4L0dCSXdVeE9tZUNNSzBTRGVZc1dYbXgxSTNqbjh1L2VHRU9jS3I5?=
 =?utf-8?B?T1pRR1F3b255NEdBQ0hmZjJpb3Jld216MGVtd0JZRFFBREpEU29JcU82U005?=
 =?utf-8?B?YmJnYlpXVFNaTjhMOTQxVG8wd016VU5zOTBzOUhQek40cmJ1WkZKVUUxa1oy?=
 =?utf-8?B?Q05FSmVNODVRRjBNeTJCalRCYVpyTGllNGtJcEZwa09sRmJ6cFBtSUFVbjc4?=
 =?utf-8?B?dEtOVktNbTRSSWMxdXhoaml4dWM3UEtGVXhRLyttZ0k0cDE2Z2NSQzRCOU90?=
 =?utf-8?B?d0dTKzhOSW5uMFdOV09aSHFPajJhd3h1VnN3Z1JGT2hYVjg3RHgyMWZLQ1c3?=
 =?utf-8?B?VDNVbkVPTUMwM3BqWWwvc2hJOGhTcUgxNFk2L0xpS0IzS2taWGtmZzZtc3Vn?=
 =?utf-8?B?KzA0UFFvTXltZUhUc0JMK3g3WDI3Y1lKU1ErK2lFanFoY2hhUmlvU0VzSXhj?=
 =?utf-8?B?dnBrenlXZXRSNng5MTU3SVJuaGhLYXNxZlc3ZDU5T09QcWt0WXBMYjFUa3pj?=
 =?utf-8?B?ZGhaWUwyZFJCbm5JL3E4Z0E2WEJqOFRSMXluZmJRUlh6enFKaVdzNDNGcVc5?=
 =?utf-8?B?WU04OTJIZWlMRWJpWG5zRkdBU3dJbnBEd0ZZTlRLM2dtN1VBUEszWXlMTHZa?=
 =?utf-8?B?SUpyT2pEN1pRdkVxcWFSdis5OGlVbkxCNWZqODhKZXFWeGxnZTVvdjBxTm1a?=
 =?utf-8?B?SEh5Y3BQRFZ0ZS9tTDVVRVpkNVg0YzN2anJKRXc1N0pMeGkvMnVxQkFLeVls?=
 =?utf-8?B?czlRWnBwcFBqbjJkYjltKy80Z3NxSmNkLzFBN3FCSGsvU1MvQlJoUEYxelF5?=
 =?utf-8?B?MnZ3ZlZHVnVUWk05WVRhc3gxNnZkbGhiVEl5Wndwck4yWGlZUzJUZHBwNmV6?=
 =?utf-8?B?U2d6Tkd5VG9sdFJTYS9zZTBOZ1JFYWRQT1JBQVhPOWVYOU1KVm4yRXdCWmo3?=
 =?utf-8?B?ZzEzdG5mc1paaGZFMklISjFucWkwb3grZlRHMG5IQ29xNTRpR2ZraURUQ0Fn?=
 =?utf-8?B?ZlI2Rjc5QnhVMitKQXkveFdmREI5U0VmQk8vdlRTdDV0dHZJUjdBOGtMcXZH?=
 =?utf-8?B?Uk0vQUtINjZHbkdoaUIwRUlTQUxqdnQrUFdJUXJybEZVakk5UGZqR2ErNUZl?=
 =?utf-8?B?N2VVRnJmQ1pkVDZmRkxSZTdsSVRNbTJseURWRVVpZlk5d0dEVHA3eWpQRGly?=
 =?utf-8?B?Qkxxcm0ySW9MNmFxY1g4a1l5cVJXV2JSYm5PRVc3cm9YUnNjbUNuV3JoTWhB?=
 =?utf-8?B?ZncySTJWSFRUTjRhelFrV3hjdkZPUjZ2UWNaUWtaaGpSOWtic2NyRjh4ZkRV?=
 =?utf-8?B?blAyOVpOVFREeEZqUForZ2MwYVZtNlUxTUhWTVBrSlZVMzFJQ1I3bk9ON2tl?=
 =?utf-8?B?cFBLYWQ5UHFocTg2Uzczc2VucUZCS2tPayt1Y3hoR3hRWnNLN3BSZWQvVGFq?=
 =?utf-8?B?cFBoTFhwVVBoWWJvUzBlYW9VSFBmcGtNNzFnYnEyTWtHSzFPWEgyTXhwckRY?=
 =?utf-8?B?L2FmMFZnOHhuaFVkdUpWRWVrSmoyRFdUZTVJM2pWUFpOM0xpbW9qcjZ0eThX?=
 =?utf-8?B?clFwbS9TQ0FWclJUY2dDZHpmbDkxdE9DVHVqcWV1aVJveXZXYlJKcFplOVJz?=
 =?utf-8?B?eElDOEtqYXBpdzh1MXQ1UTYxaDBXT3dDaUM2dnp6MSs1N3lsbVoveEZ4TXIz?=
 =?utf-8?Q?zUalNmBP+vN7t0Eo1R8jYff6K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MgJGauKckNH2FoTJf6PnGcPprtoKD/tBUyvtChCz0t5ZNfVlZRmxjt4703QnSYIInn/+4Bw5ACxNPPsN/qqUtcXN0XpSPfXjlFGZavUsLTUnq0cDr8AccA5+7+8pxO/7o9QStvqXB2iJhJolIStEyISpAafZToPOcqUwRHXsxpYUCnavPLkYI9Ag3xPQcHa8JXgiyWkHdriIB/IJziwxvJhvxk5ZSR6KXMeUoFaBm95kGWzlHcbIxp/N3rU9BkiEJfUrRHKODmLKIhRI1ZewSOLoJB/hFeloKDJMLoI3havaDV2mLozK5YyI3Hm/h7qlmACBVo1O2ZUL2zIGQWf+ykYWlmReLXxMw/xTcN1Kgcz0ykCVSRqFQDAEpOTfKB2m86VR+O00+kFEm3df2CyT9zEQth+Y0qRFqPmh41XeWLcfu3GT5KIWXko8fbi1F+riVVm1HvQQBbq7PTAcPtO2gFkin2FMYpVrnnlmN1UAptKJNTRPdPaCx/N61q/+40gHDg7XDzTNSsKPbAG5GbEIUBn2ZSicACFcVmdWRgB160Vblp+Oei9StiPfHOZIVk68aZ2KYtLWvw0un1NQqB4f/0Nzza7kvrvKWJLdsCu35XE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a30881-0ed5-4a56-bca2-08dd66499f5d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 18:20:55.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgUYJPdtKGMxlpd3YkQSlokoRHi/+ofzxwwooJ20k5IKHSyV1YkBB9DXF7Ai9MFZexfRL8oiqnDHsWzXoab+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=819
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180133
X-Proofpoint-GUID: KRosEgXAq35OVCf-KB5sgO2rufRxBy_4
X-Proofpoint-ORIG-GUID: KRosEgXAq35OVCf-KB5sgO2rufRxBy_4

Hi-

I wish to reserve a BOF session to discuss kdevops.

I've been working on a proof of concept for running kdevops workflows in
the cloud, and I'd like to give a 10-15 minute WIP talk on that.

I know Luis has been talking with LF and kernelci folks about how to get
community funding for testing efforts. Maybe he'd like to share a little
about that or hear some crazy ideas from the audience.

Other related topics?


-- 
Chuck Lever


