Return-Path: <linux-fsdevel+bounces-20349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03A8D1B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB41C21FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497B16D4F8;
	Tue, 28 May 2024 12:46:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EC383BD;
	Tue, 28 May 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900416; cv=fail; b=rMqCTNpF0PRQJuknHP7F5W+kHXPbM7zxmq3DsORgDEpyQs2ERxwE/qc/wjRasOS04xT+qtpdI3S3KZr65EF8znOyroqlExZ6DG/XUQG3vB5UDDeXr862CdcmD8DIOOEx09OYccbw1GoL7jQSesaOUsClHR+CESfzpUCGYZSsxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900416; c=relaxed/simple;
	bh=iVyl51sPDMLiJIPaJ1YGkew301f4GP/uAZno+JZUQA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l7ogk1dJO6aps3ZRreEioATGsNhsk7x3NFwqB1K34xf0rIGKjOhdl5dyXcaiv2cM+EG0Lg/Ezhm5D9lCKKfv/vh3SRUNs+xa0U6ZkE2bFR330e00LOHD08b4+DwPvQarK3E3ghmFV/ACk3fSsnsNNmuWybNxTeas6gYwg6ShyxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBmvP2009039;
	Tue, 28 May 2024 12:46:48 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D+obBH6BWQOdQ5vkfLdvi9FAVzqUcQU9BQnCqdOyNkvA=3D;_b?=
 =?UTF-8?Q?=3DDMh6UIaSOdhDHBabY2yI70Fb0riSzIFgsDkeNeYAOqtONaMN2U8T6gMMMR0B?=
 =?UTF-8?Q?gv/oS0Kk_mhN3SYdgnig0zexkkZexFPMmf2fQzYY/O6xiUPS/KFrvIcPZ7Ewg/+?=
 =?UTF-8?Q?Evm+u233WcHe3h_6ohoLPOdydC5qcFUT5tW8SMgjcLeTQM5Ixsz0jZGb4dKezqo?=
 =?UTF-8?Q?+oRRngEAGHAY91Cv9CDB_+UdnecMhQrU4pkTA+5kk+gsPR+hxfOf8vTPM+q4wEd?=
 =?UTF-8?Q?O9q1/8kbT2hDw9qSXqvMS314OX_JWzyCz/Hel+J15ETHZKbV5a6W/YBT9FaGC3z?=
 =?UTF-8?Q?JZetWfDm4t+lIPtBbs3Kwv97thLRSMrl_sQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb46w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:46:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBmMMa037657;
	Tue, 28 May 2024 12:46:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc505t05e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYiuBGWKfvkx5w/BxLKWkoqNTzbBxRUxpit5gIkHCsxGRl0IXzVOJjZi+y2QN5DT9ireDpfIer4dtcIZnbFGtYolKtyCJyI1S80Dz+INQOVfALg92x4Zo3PqRbC0h9jVn/gfpv5UISWPnqjppDeGR4cxwBnJrB9N3UIQAiSlTohJTx1N9h8MbWJUdGB3UTP+lW8wEO/38bf2EY8cuu3r5xUemCPzXtCgFONFiWuf/vhLl+tShNy8nDSifLmPRRh1bHWLM6UuDHh0cjeVZitFTht/Ap9VFTOf8Gn0eq2ssMFmU3ajcw2iPeZ90XthBUnVBXGNmRA0KETf9t+qRWmtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+obBH6BWQOdQ5vkfLdvi9FAVzqUcQU9BQnCqdOyNkvA=;
 b=Y24X8gN+/f+KLT2RXXqCGvpDn1X/K7fvz1MulNPSxWVwqC3RZdf/IgvZfTVdZcJza4m7NHgxuZEpk0ovPn2N7qbGrT6RopqxpVAlS38TUMXY0Ho0whzBUOxD9L2ityepfTbpKIql/vp7erlJzZtOa7mUpQmED11ScEkK5shHhIFCjm5TwSzrcrvENduS9Tmki/BVJmxpd87xq42iLMOyfVW5UK4jEFgNPLZaFCFF2ER67IW9Li07I2Nk+wFI5lFH3AERiU01t2aMidTH2+21nV8SQnXiSU+XnfzoyBoa2KQ5SfWGqAuH8Xk53tJECBvXvAPytTIX8IqCzwTZvlNMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+obBH6BWQOdQ5vkfLdvi9FAVzqUcQU9BQnCqdOyNkvA=;
 b=TnwFv/Q9q3N0At5NmR4nvxYIlEGUbYLFHXq9i214Qq72SpyV5+C/5wB0+u3c7dZKFdvMKPOmXeZQo2Y+EKYPWZaB1mV9+hmFAs0Oj06Fw8/LNq6MzTroi8Se0ORQ4QxaR4rXuhkSFWU/s4FOicurXNJBJKG71XzYl3eGDL2BQ04=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6227.namprd10.prod.outlook.com (2603:10b6:510:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 12:46:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 12:46:44 +0000
Message-ID: <b3b02658-ffc4-4bd9-b77a-af65ae359474@oracle.com>
Date: Tue, 28 May 2024 13:46:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] statx: stx_subvol
To: Eric Biggers <ebiggers@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <20240312021308.GA1182@sol.localdomain>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240312021308.GA1182@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0178.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1ba7cd-6a92-41f7-f315-08dc7f143acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmZiNzdUUDNKT1ZueFRsOU1yRVNZK2JLeWIyTjlWeUNwNXJpTHBxeHhUbWpH?=
 =?utf-8?B?M1grQlhqem1JRzFZZFVNY2d5cXJEbXptdjRtNHJUMHNnUHltdVBXeVZ3K2hw?=
 =?utf-8?B?aytlMkZINFlTRkdUbnNsakpTbXRGRGJ0d2h6bmQ0NzcvSm5wdFRvNlV5NjYy?=
 =?utf-8?B?dmN5M3FUcTI1VThoMWR1L2tQa3pBcGZBcXF5cUZBeUh1YXJrVU5QTklLZjNh?=
 =?utf-8?B?RHAwT2s0NlVwRDVpKzFCTDZkNGw4YkFvdEsvUUR5VG1xeXoxSnBlZHBIVVNL?=
 =?utf-8?B?RGhIblBUUE5hUnJqcTBtS1FLd0RMTnhlTVVSOW5rcEFSYmtsREEzSlNuZStk?=
 =?utf-8?B?Q2xOU3g3OEJkVjE3dmhEelFhMjJtcjQxYWR1TUhVMDNaYnVVcjBCR0ptZFll?=
 =?utf-8?B?L1l2a0xXN1lFb3MzMlM0akNXa0lrc1B5QmxSUC85dGxQQ2VtRjlXU2U3aVgw?=
 =?utf-8?B?RTc1STd4MUNVelVHQjRPandjcXVwejlibmxCdC9YMXRCR3I4ZEd0ZjFDeGtz?=
 =?utf-8?B?aXEyaVpBRjYwUTJQaGdpRTV1SjJaNGpyYzFsSnZ4SC9jZHdFRjYyeWxqclJD?=
 =?utf-8?B?RFBlbFVTYWsvVTBaRUptRk9MbjIvaDgrakROVVYvVjIrTUZQeEZTL1ZKWFEx?=
 =?utf-8?B?bHoraEltTHAveWlKSjVvVHFRaG5NRFh5cmtua3lJVGhLazY3SkNJbWlkOW9M?=
 =?utf-8?B?a00xb052Y2dXS3FVNjY4Vys0Q3RTVFBjRUE1RFprd2N3YUNkb21BSXp6RWpL?=
 =?utf-8?B?empEaFg5QVl3VHMvMlhlMWtWUXFmamVkOURpamNvcHFSd1lwVlErdzNFeVVn?=
 =?utf-8?B?QlUvVkY1TFkrVTYrdHgrNmRRbGltdXlRT3pQOTJPc0JkNVZHdHdETnJSMkgw?=
 =?utf-8?B?bUI4Um0rVXExMHd0NTFobWE2S2o4dmMxdUt6RldYZzdUUU9hR0ZpajRUTmIv?=
 =?utf-8?B?RDZEdWtTdlZpazhwS2RrdTVoWDlxMFNIbDI5NFg5Wm83aVhJa0UzQ2NHZXpy?=
 =?utf-8?B?ZFdVcDJibVRFUzZJQzROanB4eGVrSVNOSTFyUmlldklFbEt4RUpPVnZEQkYx?=
 =?utf-8?B?QkM3b1FMdGZRRktjUHI0bmd0dmQ1ajVDWmtFeGxLbE94Qm16RGwvTE1ydTdl?=
 =?utf-8?B?RnZMeDFMbjk1N3p1ZkFnRlo3cTZHM0hxdmVtWWl5d29ZRXhrdGk2WFBpd0RE?=
 =?utf-8?B?ejhGeUs1UmZJV2dLNzFaR1hwS1ZVUHQ0UEF5UXlLUWs0L3A3aU5zT0RJRXdn?=
 =?utf-8?B?TkJ1MnM0R1hIOHZ5RmZCamRuZUlIM29DTTJRTFNFbE0xSWVoLzhUQXZPYnll?=
 =?utf-8?B?ZVZGQWY5d0ZxdGpWODhyNDZIdWVqd2xkS2huNXdIcjBmdDRheWwzZVh2Y2tl?=
 =?utf-8?B?Z1NBOHRPNzdIaWV3MzVRU1YxYzBlcXZzVXBZdW1mMWdsNzVna1MyM3ZQNE1k?=
 =?utf-8?B?NUprZWlpbTZWajJFd1hjbjl5cENORldLWHd0S2NyOVYvV0szRjdxQ1ZnUHhp?=
 =?utf-8?B?bzJmNkZ2MDFaVWZTTFF5VWxMS3NOK25nak03MktGZkluQjFYaWlkUDhsVGZi?=
 =?utf-8?B?VG5TYm9hRDJEWGZRZFBiM1gzbG1TRy9OR3hPcFdyMTd1cWc0bVI1aXNZNkow?=
 =?utf-8?B?cHRWd2RaZDVRK1lvU2x0elJEQ0hpeEZkN1FoSFpHa1M1dE8rVjJyYXNhV05k?=
 =?utf-8?B?NERWQk4xSGtrRWJSSmFQRXo3bExLSFl3QXo4azhPL2RMY09YeEdVdTdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2xHc0J6RmtaYkxKaTFlaDNac2RNS1p3RU04SU9MMnljZzRIeE1UZTJTSXE4?=
 =?utf-8?B?eXl5SzkvWG40OFR3VHVaMWRzTjJUQzJkcjRaZUNxcTNUOHdwNkFMLzBsUWJs?=
 =?utf-8?B?Rk1Ed0RjSmkwMElqWEUxTnIxNlA5MU1GNUVhcExMZlJiUENabzBScmFCcWx6?=
 =?utf-8?B?NVljNTQ3dHpJMnlCc0hxUUtPaU8vbUNWQzVWUW9LVlpxQkdGaFFEd3FNMXZE?=
 =?utf-8?B?UGFYbkhraFFLSndzQm54OXNqNlNBdHBlVE5sVTNPQ3hxbFpFMWRUVmN1dUdB?=
 =?utf-8?B?YjhDd1h4WGJCckJ4RlIyNFlCV3J5VVh0enViNUYrVVNTMyt6WEdraHAvLzd4?=
 =?utf-8?B?UVZ6b1NUemYyNlNTckwwMzU4RDdsWm4rUzcxQnl6Wlk0eS83dEljem1hMzdE?=
 =?utf-8?B?VGZPSzVkeEhFTXRTZ3BjUkwraUN3WnFqWkxtNjJuTjMyMDBxWWJSbGZjdlVz?=
 =?utf-8?B?SzN0c0pDYUd0b2o3R21oV0FPVGR0cjlUdWlDT2psUnB5QUp1U0pmZmluejls?=
 =?utf-8?B?b3h1ZzFHZ3daeUdsTzVmNGdGOUtsWFJITm9BTTIrQ3JLY1Z6S1dUM01LaEFY?=
 =?utf-8?B?VVlGcEkzQm5RcHJWVk41cXN3ZlppWmdEMnNTNncxc2l4WFhXaGFJc01iam1o?=
 =?utf-8?B?TmVGK1pVUzZkdHdpVXpXbWtlL29DdFZxcHRhZHdKanc1RThaaTZ3Y0R0MTRN?=
 =?utf-8?B?U0IwS0xXYVJnL05TaGNLbEFnVC90aElhTTJxYnVPYlUyVHFMUlNJdkt0eklH?=
 =?utf-8?B?a1oxT0doQmZ5R3VEMGtoNk42d0NiWDVLcW85OVIxdlBiVkVWVU9kTjBaaE9k?=
 =?utf-8?B?S2FXNWhOUCtXNTZyVGt4UU54YmZudXpZeEMyaENiaWpySHpHcVZ5WDFlVXNL?=
 =?utf-8?B?ckR1Z01MdWFGaDJRVElVa1E1M3QwTXhsN21ORUs4bnhPOU1MVVdkMnJFeHhD?=
 =?utf-8?B?ZDl6c2xkVUxobEpuK1FZdWlhdmFlTHoxcUhIcUxZUlptTHJnVmtxVGhVUzlD?=
 =?utf-8?B?TmdnU08xZ1B6ODhQTllITm44V25NZXZZZHd1TTd2QmR5OUJYVzB1Q0tycVQ4?=
 =?utf-8?B?NUtLcVFKVmh1SXJHY21XczIyUDJISTl0YXBmWjQvbmNiMVBLTytXNGpBWlB1?=
 =?utf-8?B?eUFmSEJnSGJyYmM5USttbzgrc2ZxcU9YWjlKQzl0bUhrY1NjemtWY3VubkN5?=
 =?utf-8?B?b2tXZXYva3Z5c05HdXEwMncwUDFIZjJJcHkwK1JXdkxDdmU3ZjB0SGRZWUQ1?=
 =?utf-8?B?NlFjK2ZuRG1ZUmF0UGpMQzN6WU9PWDJQalZxb3NVdThsVENTYTh0S1NEQWJs?=
 =?utf-8?B?OTlQdGRiL3hFWFh5WFAyTk5OTG9YVjFvQStjR2JKZUxtVTR4YWxneWl1d04r?=
 =?utf-8?B?UUJYU2xVZzVvYnc5WTZUT1N6Tyt1Q3BOVTdWYlB6b2IzM0dYQk9USm5laThx?=
 =?utf-8?B?VnVUSFIwY1ZwZnFkQzRzWTVKR1FpamxuTXJjbkNDY0FTMDdOL3lxMmdSa245?=
 =?utf-8?B?aGpoZ3ZscVFnb3dyYW1SdHhWcFJLbDdZNGNWbkRJSVhyek1aendoYWhobUJi?=
 =?utf-8?B?cXczc0o0TUZSaFRNNlhOQmk4T0tpYnJrY3phOGd1cjM1YStWazQ1Z2s5em1k?=
 =?utf-8?B?Vmh4KzdlMVMxYzhTY1Mva3Y2ZTUrL1lmWHNaQ1J4WDVFL1Y1SzNhZlpTdjZj?=
 =?utf-8?B?SCttb1FOMXYvVmpvbWZPL1ozRDJ0aVZncFQ5TlhhM1FqU1ozZXhycVIvbEZx?=
 =?utf-8?B?NndQQ1ZCdUZxT0NCb2g3ZkVReTBZNWEwck52a3Z6SjVPcXJWWmN4M3BtY0ds?=
 =?utf-8?B?dUNJajd3MFNHNFh5Y2M1b0E0S1pMcjdjbnlYYzA4NXVoT1Z5R2VubjRzcjZn?=
 =?utf-8?B?WE5ueWMxc3gvY3JlN3hZRWRibVh1YVZ3cWVCKytrNzRoL29SOWVKUGZiY0Jr?=
 =?utf-8?B?TTl4aEEzY05tdlBBRzBETTNOQ3pIMjBPQjZFS0V1dlZyeEN0c1Z4ZFBQQnNz?=
 =?utf-8?B?MXV0WE92MUoxUzh1eUV3QlZ2OFdkRTZoQStUNTArMTVUSURuMjlLM0xBVHBI?=
 =?utf-8?B?ek4rMUpvMFFYSm5zblQzNUhicTU1K2lQZTRRYTBxQVhiMWJNS2pHRXdYNzU1?=
 =?utf-8?B?Nk55dU9NeFo1cE0xMVJYYnlGcEJ1VU04NWxWQWVBVUtnY1kxYmNrYmYwa2g0?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F+qlB3f2Qc40vryhN+1LRIKYlyK8E2D6BqGPskriXl4rZY06f/G6Fecv0M2RuBCs3WmqWj6uB/VHvTirBhih2pIHMJgikMf4Rajd2qHho+NCk5bd0zxDOv7bx8CtWTlsRswQq+lma1FWxpie4C2KwmknsrKryMzhScuOyVS4zYquknQopjrJMVz+c8q3wKGYA1buDtW0CQbEvT1JAF0uyFibUQQ3csa8MeqiyDs5Eq2Ogg83msefAEITYBp+6nEKMg9gXa+z8oiy59XeI2SoYIGvFxgssfMXQeyi4seWcsUCmnKdsP4N9PQQLVuWciDC8nBP72H5MxH+5Swy9mukZIvLPO6JRYPyn2BcjHqR3kDCTw11BSn6HBb12kgxn6RJZD4d7plqyRgef+Ntbmzo5f+2y5qAWd/8X5hDaFXN2vkh7VjioDY0mTOeCzzrwlQVGli00bW5vKLuEdgN0i/pfhitCz8E9Wl3F7QoOLonHQgpbMtGpvMGrVYSmcPHo48UCT0C+RrGm5b1XYhLhQUK+PKuRn2W1qWPmw73XYU0f91KUFwLlKywU80cM0h2uHwZuJKg1a6mL+0UFJPD7cuJLReEoyWom0PeYdw9HhQtsEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1ba7cd-6a92-41f7-f315-08dc7f143acb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 12:46:44.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRArRr9d2Ege0RLHT+eu8gxmBY3nXaDeXdkg8cqF1/4TXnVzOCwm4lFnY6o828f+IoFnuMYLtbZufdc7JmndBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_09,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=935 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280096
X-Proofpoint-GUID: Q_HEixrhLHhO4GYWv0C7ABV4Yy7bsPZD
X-Proofpoint-ORIG-GUID: Q_HEixrhLHhO4GYWv0C7ABV4Yy7bsPZD

On 12/03/2024 02:13, Eric Biggers wrote:
> On Thu, Mar 07, 2024 at 09:29:12PM -0500, Kent Overstreet wrote:
>>   	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>>   	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>> +	__u64	stx_subvol;	/* Subvolume identifier */
>>   	/* 0xa0 */
>> -	__u64	__spare3[12];	/* Spare space for future expansion */
>> +	__u64	__spare3[11];	/* Spare space for future expansion */
>>   	/* 0x100 */
> The /* 0xa0 */ comment needs to be updated (or deleted).

I would tend to agree. Was this intentionally not updated (or deleted)?

