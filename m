Return-Path: <linux-fsdevel+bounces-68710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B701C63B11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAAB3AA91F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4032936A;
	Mon, 17 Nov 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="az/JutXt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pC/0eNAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C143594F;
	Mon, 17 Nov 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377308; cv=fail; b=q2RzsK69MzoXjfE4tR6gKXeJ1kGFz69QpdzwFmax1jfkBeUAYpm9TLd7df1Lkm6TqHRBFEXJMixK0SYSYI3K/jYRRkHKYdYCOeq7Nknf5Vb+WJnKTJvHovdTxZSqRBGhQjrC+sm8NSxqq3sbsTYktCtHJUsqTnGNeUv05qQB8fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377308; c=relaxed/simple;
	bh=XDW8ST47hWYZqvJrYX0tld3WefydFDotGax2OKEXcTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sr2/qjXKfvyitOA6uBE/vdu+k8aK3PG66OcMQcUOT0FAOZg/pv8uEWeOEZMYl/KsGR0MthXncuN4fgEIcfSP9O2cNd27pjKNwydgiNyPK4+g3jZqplD3gmURT17asHC0nhtSHYN5Nf0jPQnRnDUwrhYAajV4/w+uO5sxEogjVao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=az/JutXt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pC/0eNAJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH9uKUb002300;
	Mon, 17 Nov 2025 11:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W7Jz6HWGeXjNaAcASEiT72W4SqHpZJol2K18Tkhlsp0=; b=
	az/JutXtsHt7wnfw1vI697Z2RdbbuR4mUVFRzxsXUK/02tqMBxMqdsjXxg9P+CQo
	1WLu5bGAwxJ8iUFMoMdXNwzZ9RBd79nWF1X8g2ZdbHcIJcoA5Ln97uvSAgJEdGjH
	CU6fkQT0zFasg3La3l7cxQMKhUzlyNEUEVv4zVjg5YcHz2hNPkfP6cmIMrqHvyND
	SpyCwiQLflhWpGQnLONO26Fq2wuPSUB/6jeuDb1tFNpgC6OLamSMcKHJd+WLRq/I
	/ORtZE/KZjx6APER0G8xmQbuxmaHaeMxBNDh5lr1bFhbf5yRi9EPgvh4FPPkKvxE
	Br+BWvw0fc5+HHwAEl23KA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1a6ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:00:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHAeJWL039826;
	Mon, 17 Nov 2025 11:00:07 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyhtakp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwpzCwyrHDP6cmdMTqTGTEoq/z++HbTGT8hRvgzHl3uhHa8jY40WgUIFULIzjeDqtaVjNu9J4aUzKob5doSf0Fr4Tms80l/GTwxm5O0HZ/8u31llwT9RQ+vEwdfTQfvhrqqAxiSy7RF/tQTswkFWTqDAtfICGayxdX2No2oeFxUA0L1S1uCtOn4xBtzqSkbS0XXcPP/RxGaLf2X+l2tqb/GEJBVTTGHa5GW0LKl3QlQZZJQmfZO26BpHgUEHLyt0wR+C3gVI5rsjMA+4FQYfz+MtnbMdMOxuSztO9xNslQFqRD9CsagNGQ5iQkmuIGX5invkQBHm5UIOH8HyG9BtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Jz6HWGeXjNaAcASEiT72W4SqHpZJol2K18Tkhlsp0=;
 b=HNYhpHWtcLELP7qk05IQ2JMJD72MikmXzOycbRDnb6tgYGcHeDS/OwwxKqNLlMjikkwkSusJzpafRsW7yV2gtK3w8L0TY4RKpQ2D+uctn9aqLZZqFh88Fka0TdFP04KNMET3xSFoGnIi9EW7ECTHltESUYx7oqvYsczXXx1NuG2VlHHxPurtwim9y1p7VQIrietsu6M+WhJm0daGWG33Bsm+xKJb6s8FSLv1Zrw9T/nMPRjBryIfmXgtKK+Z/yalo0Eg+3LJI9NteGyaeb18ML3+8FuWLB3SEnur0E+p53xkMP4rmr3W5JFPDDQJ/h1RIyWsmxZdRYv67LZCurZukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Jz6HWGeXjNaAcASEiT72W4SqHpZJol2K18Tkhlsp0=;
 b=pC/0eNAJhCUN4+6rk3BV1mciyqPNMC4x8uVN41wy7H4HZlTrHNXb61nolL5eVvy/2tRvemPB9dPzXnLeVS9RDY+nkTQJ/Vu9uheW3KG84ro8C2t0WpP3PPcPzX6cthSwMHHVxEHmKKgHTPTJZTNTVnNrdOjfBIPwh2p/NpzVrUc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 11:00:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:00:01 +0000
Message-ID: <8d645cb5-7589-4544-a547-19729610d44d@oracle.com>
Date: Mon, 17 Nov 2025 10:59:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
To: Dave Chinner <david@fromorbit.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        tytso@mit.edu, willy@infradead.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area> <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com> <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aRmHRk7FGD4nCT0s@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aRmHRk7FGD4nCT0s@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: d296245c-2080-4964-f587-08de25c87373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ry9kSWVzS1o2M2wvZ1JPVVFYNnJmdzhWWVd5TkErUUwxWnUxdVhKN0k5b0xY?=
 =?utf-8?B?NkE3aWhJT290M1hkS2liN0RYQmszSkZKSDhQYjNRUjJER0VkbHI0QXZIK3pn?=
 =?utf-8?B?bC8xbFpsWTZlNWFFZE1JRVZKTk4rbWpmT1k0cEJNTXh6ZldXREpiRDJaSGxB?=
 =?utf-8?B?Ti9wVmdxYmZVR2JOL3NmYTlVU2lqVThmTE9SbHRnSGN1UTUwNjQyY3J4YTZo?=
 =?utf-8?B?bDFLOWdObWl6a01qVE1nK3FPeXVXZkFsSitFNHNwVUN2Q2FSaFJXRGhkZjI2?=
 =?utf-8?B?V1daaFozckZiNEl2TkVoaEdIZ0dWNDRLZHdta2dRVW1FY2hxTmQrRmVVVklh?=
 =?utf-8?B?R1lWUTUzRFpRZUdPWGQ2YlNQRlpjeFFjak9kamZLQzBmbmRzTGtNczM5aE0z?=
 =?utf-8?B?ZlMvdmpRYjAxR0x2bzNZS0RCdzlsTlU0Q05teW1meGUxeDA4WFN3U0t6cTRt?=
 =?utf-8?B?SVBxalgxTE9rOFQ3eG1lcUI3OE1lakhCdEZJek5QTWRlcW5aVE56U1JLRmRa?=
 =?utf-8?B?Z3NQREw1by9ndDc4Vk44ZkJTdWlqdnZsZG9nZ3ZGejZ6UG8wYkd4czgvYjBy?=
 =?utf-8?B?RzBDTzhycDdMM01CcnlFY3ZKVmRKdzdwRXFjY3pCNTgzZW1qK0NFMDRRVnFP?=
 =?utf-8?B?RDREZDJFU3liTk9vZjFTVUNwMm4zb3phdE1OYlFmNEYwZHpBblV3dFFDc2Z2?=
 =?utf-8?B?eENVWlBpTlpaUlJkWGd6Nkc4cGswZXpsdmVlZE1Rd3lnWUFubDAwcDdyejBa?=
 =?utf-8?B?NzVBOThTWXo2c3ljL3IzSnAzdldnRHdWOTU0ck9uZmxnbWRyc09LQ3V3NFZL?=
 =?utf-8?B?ZXhJdnRXazFGdTQwL2xVeEdITVRNVnQyckVSMVpQTXkvZjhXQ0tKRWhFNTZz?=
 =?utf-8?B?QzdFZUZvL2tXakE0QTNxckZvSHRDMHhlYzF4cXNXWU8wRkUzczdxLzlVYStB?=
 =?utf-8?B?VVNtRkxBTWpzWHNBeGhQVmZpYWlCT0hvbCtERVVlRFlxdEtRWjFoNzgralVK?=
 =?utf-8?B?c2ZVdU9DQ2xSSk5jMHoza0RaTjY3OUxqdUpCbDBZZ3FoYW0wVnkyVXYxeE5r?=
 =?utf-8?B?dyt6aFlzYXEyNnNBUlVGLzl2NUJKL1JYYUhlVmJEWkRyaFZSWXRtRXp6bzVM?=
 =?utf-8?B?bFFKM3BvOENtNTdpQUZSSmx3UnU5QnJzVlQrZS9TRlFEQllNWnBxZ3hPRWVP?=
 =?utf-8?B?RUtuSkhNTDhmUEkybTBkOTFqbnBOSjJDeUpVZVROOFJpQ2dvZGN1ZUZLZ0V4?=
 =?utf-8?B?OUFJRFl3azhUWWZkb0xHQ0tjT05WWmNwNVlnWDBGeDVGNjhxOXh0ZXh4b1Ev?=
 =?utf-8?B?TDJXU053SExSMFBrZHVsSlkvTlJXOHBzWllZRWIyWEkzU1lTc1BNaURyL3Fj?=
 =?utf-8?B?NGp2dmRPUDJzQmNFcUFsM0lkalpiQXBDR0toaENjZVhMalpvNVNYbmU3UTE4?=
 =?utf-8?B?MEpEUXl2bk9wTDR4Uy9GcEEyL0NXMzRWSndBVXFaZitCQmpmQkN3TXFMQmZy?=
 =?utf-8?B?eGQ4NFFsL1FHa1p2WDg2S1VYNDBheDRQNjdMc3YxRndoWTFyTnpHVWMzdjha?=
 =?utf-8?B?dEE4cE1LaFYzZEVmR3VYWDZCbjBQdVpzalhSa2NXUitwR3JoWmRSTHJleVU2?=
 =?utf-8?B?aWlzVE51QWRDVElnRFpYK2tBYjZVeEtESVZ4WU92eU1jK2x1Y2xvWFpEL3hl?=
 =?utf-8?B?VWd5T0ErbXAxME1PT01rQ3lpeDFFQkQ3cDhnYnBOUldMMnZzTHBYb3l0bEtx?=
 =?utf-8?B?QUVMUXRVTjREYTBCUnUyMzE3cmZhalRNaVdDcmIzekxDRXlUM1JKdlBWQU5p?=
 =?utf-8?B?TDNiT01zR1dXRTZ5QloxeDBQdTFUK1RGUnNsQjBycHc4Yy9HUU8zMjVYZmxF?=
 =?utf-8?B?MzhtVk92VUVLeUNUWGlzMEd2Z2ovc1lQL3B1c2xWTFVJakJJOTI2RWV1VFkv?=
 =?utf-8?Q?/5AQdreCluJvWUk6Nv8RwWVgvrt5YPy0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVdRMmh6YnNBbkZORW1KcFRHeE5tdWhxcDl2cVpFMmJ5cEdpS2M4MkVtSktu?=
 =?utf-8?B?K04xUStSUjhuK2FFeGE4dUpwZjMrenIva2FmS1ZvQUhCVjk2Yyt2dlZRK3A4?=
 =?utf-8?B?YXhMakFhTTc0bnFKTFovbDRTTmRJazVMVENZaUZkenhxTzZpcjd6cUJzQlJn?=
 =?utf-8?B?bVdWS0lxV3RHbTJlUThQczJ0S1VWWUg4T3p2R05QSjZHblZsOTNQN0drNjM0?=
 =?utf-8?B?cDJLUjFxdFR6RFlNOGxHRUpqQjM1aDRyWXF5dWlyZFh6RjdYei8zdDFvYysx?=
 =?utf-8?B?cGgrYWhUc0hoT1Ntd3ZOaUZiOFl1YllkbDRhdXFhY1FVSmR4T1JPK1RRZ1R4?=
 =?utf-8?B?M3ZZQzFIb1BzSytKWVZ0eE9VRm5oQXJiaEw3NFpHeEVmVUNvKzR0NlAyaTE2?=
 =?utf-8?B?Qnp3a1YxbnMrQTNySTh4bnN0NjF2REI3Uk4vajF5NisyeW80VVB4a1FxWTV0?=
 =?utf-8?B?R003aHptaWlhTTh2V21nRkNFSVIvYnFsdTc3aS80TmpXSWRoU1cvRWx5V013?=
 =?utf-8?B?b1RPZGpxZ3B5WFZtVlcyRS9IcFpRRk1oUnY1d3M4WERLTFRLanFEU0NVRHZl?=
 =?utf-8?B?SGRYVkJCVDBFQW81YzA3SGlsWjBxNDI5UEhPekFuaUdkQVVoTkxKZ05kNXEz?=
 =?utf-8?B?ajdLNndMb2s3Vm9TSVJwM3djM1NNVDBWcHp6a3JRZVIxN0NDbk40UVMzTk9i?=
 =?utf-8?B?M3RnbW9BMFhnaEVlOUZVTy9XVkl6TnRBYmhJVGRsOHY1dXp3MUd0ZGZoSzlY?=
 =?utf-8?B?blVGNWxVekZlaExHMkJEOEpGOVRXc3hyOUdDV2VkOHJsVnNvRW50Y05ZcCtu?=
 =?utf-8?B?VitKNTZYc3F5QW1BWWxLWkQ1aVRya2svVlphYnBWbld2eHNSQkdNZG12cjZY?=
 =?utf-8?B?RkZrZlo3NWNSa1MvZ004OUYyM0Z5SHJBRmw4Zms3aGczbTk2dkRnSERKRGZI?=
 =?utf-8?B?dlBoeUdjT2RZZU5jWjJoL3hXc25GMFRONGlmd3hnbENkNmxZK1pGc3JjWFg4?=
 =?utf-8?B?bEtJWkdLUEFwZzZGNGRuYnlZSVRWN3FlR012ckZ0aFR3MkI4UmlCMWtHTEVP?=
 =?utf-8?B?by9EckJRbi9jNXJzSURpdFFuU1Z1M1E0dm9XOVRwZkZoSVJ6MFNDSkFLTUps?=
 =?utf-8?B?MmV1QUZFbE9PcXBZWDlNNkhPNmZvOGRYRkJRQjZrZmZmUUVXMFdsN1hQek9I?=
 =?utf-8?B?bkVndk84WlcweTkwZ2k2eFl1cDRvNjdnZWlCS1J3d2lrR2laam52YUdUYVp6?=
 =?utf-8?B?K2Yyc3hkeXFGaTM1U3lJYlZxZ3pCWEcxS3RiQ2FLOHlqRTBmN3dqbDRxVDhp?=
 =?utf-8?B?Z290cGJFb1N2NXdJT0M0UFo3UWRCZ1ptMXJlVWRKaGdvYTU0QXNGRDZSUlMr?=
 =?utf-8?B?cE5TcHI2WEYycGJrNEl2Zk9XN05xb0NWRFJNKzBIU0pHaGdLeHFpVXM4N1VW?=
 =?utf-8?B?RDhpekFub3RiK2s0V1lVdVdIWFFEYkhndHczNU1nNVhiNUFhSFRDUDU3cVBZ?=
 =?utf-8?B?QzJRbHM4WFpRVUNCVDNKelFZWnpRVHFObXJhemVYRzYxS2NObGpPUi8rbU94?=
 =?utf-8?B?OFU0Z0N1TXVNRTBQTTNuby8vak9RRUozVHRVNThua3JxWkZLcXRPVXpaZVdE?=
 =?utf-8?B?QlU1d1ZPeHp1ZS9oOS9wNjk2MEZPMWlPbDdCMkNndUIzVnRRZVlDRDJOWVUy?=
 =?utf-8?B?R3AxOTV3MXZzRW1XNEx2WDJtMlRVeHBDQjZhSjVQUktKa1FsU01rN1ptYzVy?=
 =?utf-8?B?R2pXbmIxSVpOMWxrK0RPbVFLeTgwR1dIa21GWTBVVmFwaFQyT2xqQlY5TjlV?=
 =?utf-8?B?SFFhdk10dnZtMExiSVdFd2xSK2U5aExnS1dNL2w5eHZZYzg1RW1sNFcvYjRy?=
 =?utf-8?B?M3lGY05jN3VBdHJtam14T2xOQUVjUU93UVljMHYrRjhsMEVxbWFXenBYd1NW?=
 =?utf-8?B?YkdZRC84TWxxTGU1dFFFZVdERnIzN2lQelM4ZHFRbE9xdDBQc2dXR3crNzh2?=
 =?utf-8?B?RTlZbm1MQVZWQUlUY1Vkc0hGSk81L0pRMFBvcnVvYzVaaXJEM3B4djh0RUl2?=
 =?utf-8?B?Skx0TjBvN3Q1dldnN1hEK0dNeVI0LzNEekJCNHVFMjZzQ1Vudko5ZWIyVlRr?=
 =?utf-8?B?eEczck52eHRBbkZGazlvUFJ1UEF6dDJWYzgvcTQzWklXcmkxMmxwam9xMHJD?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5yYnHfE0T8p1Ojbs6a8U6xIMDR1PTbfMnet72jC8noEGB85W0U2TjkVd2F49C7zY7bQ19P0T+4394XH8kjaHKfhdLTs2IhJ5evq7xBS4XLZprQ0kAj/EePqdbL6DEsNT68S3JFVloEmQ4eDxJR7imLiB2dNi4x6mSRnJPbHnIHYHT8J8Fq2sH4x9qDBKuzkXsM4ZaO6LKt+dik0ASWK8EmDCa3UqS5qh6zvsDhpsEpbQuin3Qz2ZLc2YJ+jPuTpI9ECEd8Suf0TCjZFceUlANsgAqRyqU9TOAQ1lmtZWdlsuEgwEkVTu+1SBtVPZhKzIwpC2QLizexhdMPZx+gOMlvBbWDYD3Cih5Zq0RYJrRredzK4HyFSVW2KMGlGl/lGWaJb7K2tn9RaUN47V1r5HxgpT8sewdWaj7Fm16RZD8uv30ek1VmocPD/UIdFI9gZm0UQ3R4oysf/tSt+xGqjcA3m2kd4uTGhH3DALXk5tlWO8uhVwlSDa0D6QeUeEvCkLDcUebl5V73UR1G9vGm3+0LPr7r5xvguoG/LxOX9C+LU/OQAPo7Yl2CEdnH1mDPlt3QRpLfV1xw1LVpV7R7AxEtu8PvMeaLZ0s+T7o5tWLyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d296245c-2080-4964-f587-08de25c87373
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:00:01.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQjHs1SlGfRz7ucjcQGK6WUcitLmaCu5YON12LrlOHlCj0g02jf95t5NzIk5AKMQAEpcUoVShM4rMF7lb8nvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170092
X-Proofpoint-GUID: yjbCRhJNwOG4T_tPvCUamgu1o51uJUe4
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691b0039 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xCK65bVGRiGG1fCMjIsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX80POAZy3Wc94
 UGKR8q/FP/ksgbwViUJeqPcO7ONnaugPRSBA5p5y33EIB+qTfit+4c8BMbBiLaBVsWq4cce3vEH
 me4KepBQRkCuicbI7x1E5zU59K/wCa5J9nhAR1imEXYQMIzgA9+tkVhVlc2j9mODk2XnsjN0Ost
 A61rv0Tx+QFzPW/oju2bhJF7iI2BRwC+n6i8P/nea41+gPWhgsCAi17zeyzo7+uDDjM6lrfniir
 ZGxJPy0M8wiv7mS4UlIEw5UssyvJrLJ+Bh+yJl3zzKPcFllrrqYJpmgH1UOo3qKBw+Q+gFzfouu
 3Vk8eks/aLVGwAzP8m6m2IqgVFW5oDqI8FRFklNpQ2Y536JuvzEZ6Zxjy8uIHuW0FF0YluCQ5Uk
 0WuTB+PaYFrLvSePGyFEcqsTrD1ohf6q0sp/Nj9t7o4wLDeDb3A=
X-Proofpoint-ORIG-GUID: yjbCRhJNwOG4T_tPvCUamgu1o51uJUe4

On 16/11/2025 08:11, Dave Chinner wrote:
>> This patch set focuses on HW accelerated single block atomic writes with
>> buffered IO, to get some early reviews on the core design.
> What hardware acceleration? Hardware atomic writes are do not make
> IO faster; they only change IO failure semantics in certain corner
> cases.

I think that he references using REQ_ATOMIC-based bio vs xfs 
software-based atomic writes (which reuse the CoW infrastructure). And 
the former is considerably faster from my testing (for DIO, obvs). But 
the latter has not been optimized.

