Return-Path: <linux-fsdevel+bounces-40284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70144A21976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F511882051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACB1A8405;
	Wed, 29 Jan 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGoP59rs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YHO1QlZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF92D627;
	Wed, 29 Jan 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141179; cv=fail; b=NdwQIs3A8BlZnlhF5/tEdGpolHZXpZ6GuuKgoA16UYP6vQ6HwURZefvFcZH0bS8ndWptBQvbP7XuLKNqFT2vFWXuYiiN5qS1mQYGf0LfcqbrRp3yBLY87sxddCGJIfWdXPnuaMEgDU48JaYDp6BxfaDL8RxYLvnbmb+d++IEujw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141179; c=relaxed/simple;
	bh=QeMh63RhhQXUKDLDeesBhRR8jAjtWtYtX1/1URwI+Vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FG/rmMEoudwi8k+sCupcQ//XoeYV+XmG6qE2qYBSmoF8HJWj5uLbffjLpzGQJL7CVRmplAQQTRoMiDXghiF6vQgnKZlLbgyiOg/1DKAYomWm8iNcbGE+J+FwjGdDyFbBflG8btmXi9FMZhmkaoARMUOsV0wMNkDbwWd8l8UajNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iGoP59rs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YHO1QlZw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8toiI007636;
	Wed, 29 Jan 2025 08:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IHv/q/FCfo42E6VE7HW707DYddZDWQOsoD5OHSmRuxY=; b=
	iGoP59rsMhPLlEUeguzUZGtnnK1dsk7iYeK39Pk9RJPXnsBcy6l682OPXSojWSM5
	1oYhTLUaCYFZihmDoH5KipfeJtneOwKlj7UuyFHnd4a0xCUDvJIgeY2Q2sHCiLn4
	3tYA6Vj2bDgqqA6tkshDFYSztI2nPi7G+QRsPhaDqLJiTgATX8UOQ/sGw8aOVyoF
	Qrbqfcll/qN2EeZhleQlSXI4zp8+1EX78xYbiK9fFwSw3qaZ2Wp5NsYAztFfn05i
	biJynzPNZocSiA5FGAQueio9AbTjzwyALMnmjB2srh0WzTZzc71xwqkcGI2oN2an
	0q01RCR7B7LhVIY2i6txWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fg1tg5wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 08:59:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8iKhb015789;
	Wed, 29 Jan 2025 08:59:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd96p1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 08:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk0GBt6GSu4uxHzCH4hNwe7NgKm12HZfyUNM1BEoFeC90XQHnxYIMsXWYw2RmJzHLkXj1xQU3Okr13neOnp0XOse41KsDIakPq4aYcW2HS9lQNZc8U3SKyP2ao1tuMy/O5eHoCqKoOqz1UTw1ZMNkIzJhzWXvo7RbJWzhCT1ZRppodbCtKSp62O5McJRGm/gxG29NQ1bGyOzTU962Yls2vbFP3xoVt03yI5iFlCv0YJn82LVlZrNQxCX6NBk5ov410WjZFVBpJnz97SlQ+IxNL4nsH7gwky4OteLHb2RkT09TvmlYPi5RL841r6O/wQNn4D9vbINQgicSwT8oyxxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHv/q/FCfo42E6VE7HW707DYddZDWQOsoD5OHSmRuxY=;
 b=Cfjl0KbMQ0M+ZtY0tREkL+btyzBlFjlspQMiN8Q8yte/mRQrDEYFNA/VXmgqw2828yUpOGNGRQWVZ8PTV/5N4FYDZM3G2sad0bIDhidUZja13yRno9PAVp9GFkNULqaae0GLVuBDciWjIHiOsdL1O+W72yfLymHAbptppfYkDmuRy509G9Ma3Uft4g+2gPoSx0FickQ2jnPgI4m8W3L5W003qri554Ce/OF+7iTbYsTSDjmujrsKsjvw+3Aw0MeUKvmmFqfJx8uP7Umvt8IIrTpwf8RTThEyV+KybxdNZfXNvh5FnpwfHB0TKprWbhScJd+g0BPtOn6yUxh8hvSN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHv/q/FCfo42E6VE7HW707DYddZDWQOsoD5OHSmRuxY=;
 b=YHO1QlZw1Be6Q/pF02UQJzSymU+V3w0A3DQJEhiHLFcS+YLy47HcAd3WoU+xpXgg/go+ntyqQgpx5dKKPfxcR2wPSXwLdOurnn4BEJuQwFSa/z1G1cSgme2BNPfv9kuQM0FMmd4jQdde4V71iZtnZl206/EtChhHF82QP+2f+kI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6644.namprd10.prod.outlook.com (2603:10b6:806:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 08:59:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 08:59:19 +0000
Message-ID: <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
Date: Wed, 29 Jan 2025 08:59:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: bffcea87-972b-49d4-2580-08dd40433784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRySGxrcnN3T0FELy9IUDNaUWpzM25YRUxrQlhRbU1EMlBCdUF5VEN5eVk2?=
 =?utf-8?B?a3RVczVxQU54dWY4eGQwK1JPcGtKQy9nUjBBN3NWUVNZZW9KWXRweUJISUNs?=
 =?utf-8?B?MmZXdDBTUTlrN2hzbXJKRDNWd1RYbXNUSWtiWlJhYjZhQmY5cHBFWHB1QWtU?=
 =?utf-8?B?eXgwbTNJUGEyaEFYZDAwT3hwekFyRE1wRVphNXpxYlRpREgrNHplWWcvMDBC?=
 =?utf-8?B?S3E0bWc3ZlRtWHZQNXFsMFAwVXV4TEh5L2hMNjYwYVRqQmMwN1YxMFkwaFpl?=
 =?utf-8?B?OWJSODQ1VElqQmdvcWUySHJ4OUtvVGJyMUh5Mm94bWF3QTltdnc2OG5ncHA2?=
 =?utf-8?B?M2ZMYUp1azFIM2xxSjh5b3hud1luaG1adFg0SUFVL0lKVFZvUDRiTTZaWGY5?=
 =?utf-8?B?ODVveTM0cWZ1SE43dzV5NTg5NEpHOWJIbzNGeHc0b2RraTBGa3lOcFZ4QlZC?=
 =?utf-8?B?NmlReEdUYjRzTGZpVEJvN0ZhV2o2cExXc1Vid2FpR3BRNVlyMk1ESEpsdDBn?=
 =?utf-8?B?S3NBVjlsTnVVRjkzMzA1TjZIN0FTSWVDQmhJazJLN0lRZDhMelppaTRGakly?=
 =?utf-8?B?NUJWT0NHTm1JUUl2RzFoN0xhZUJ1MWZIQm1lUmNiTkxmemhiT3QrN3I1MGo5?=
 =?utf-8?B?ZGY2SHo4R0dSRVdTcS9tZTE4eTF6cEh4b1ViZ3FyaWpFMTVVeVI4OS9RZmNv?=
 =?utf-8?B?YXlBTTMxK3lvc0l4STh4ZXBKa3dNRlhhMnRTcFBOQy92c3g4N21WRVFKZHJN?=
 =?utf-8?B?NHh1enA0TXIvNk9jWUxGOXczWHpPRTErMmsvU20zRkVkM05iaGdoTzF5b3VS?=
 =?utf-8?B?UjJxS05rUnVPY1Q5dGVzcjhrcStNdUVNb1NvWVJoWVVsL0Q0SytCZUpnalhk?=
 =?utf-8?B?UkdtUytmK3VyY0pYM3JVY0hWN3NZTUhxYXFkSlRldTlWR0lWand1bHQ1K01v?=
 =?utf-8?B?bWlKYkVQeFppc2pYd04wVVY3U3pwL3VTL2tYYkk3R1orY0FqTFIwb2lWdTls?=
 =?utf-8?B?TXpHMkt3ellMNERpZ01IME9VejZEd1VGUFRzWG90ZG5NeGNuSGt5UkphL3Jo?=
 =?utf-8?B?TnQ3Y0c3V25PRmU0RHh1ZjdlSHZQaExMdjBUVXZiYjl5K2pvYWh6UjdkMXBB?=
 =?utf-8?B?S1BlaHlkTk1Oa2JxUm53L3k2YkkxUjRmbG1ST3JuK2I4eVFyYTJkM2dMTHBW?=
 =?utf-8?B?bzUzeDVjd29vT1k0RzBGWG1VMW12THc2Y2pvSitBVmUzc0gzdkxhcHlpaEky?=
 =?utf-8?B?TnBOSzE5VWhaODRIanE3a051ZVRLY2NiWTVZSER2akxnYW5XTUwxVHFlTDV5?=
 =?utf-8?B?Vjg5bXovZmIySWpPaE94RnNmREdjbXc5VU1xQVFaQ2xBN0wrcHJzdmkvYzB5?=
 =?utf-8?B?OUxESjZxTC8yS0IybjBnSXhramRDRXJ0YVA4d2N4aS8xKzVoemIxMkNTbFh4?=
 =?utf-8?B?ZTRqVEozVWFSWk00Q1VtWFBVVXhDVS9VcW5IdStFaDQ4RVEwbFlVNnRWTGVF?=
 =?utf-8?B?UkRiZzdIUWczY25jQ25MazlwS2VoU0tkY2xqb0ZXNU15VjJtbUF2eGFKSSsv?=
 =?utf-8?B?UEc5aUxJRlhjZUNuSEVoRnhxWlZsSnNvdXRvM1I1bDVQODMvb203d3VEWUYy?=
 =?utf-8?B?a20wMHppc0owQ1VIbkRuWEZzdFdvcU9IRmdPZU5ENXhvTlFaLzNON1VYZW9z?=
 =?utf-8?B?RU9kZXJtNDE5UjRyK2NtVDFHWnBnbWtXV1RqSU9CZXQxc09YbTZVRXdRdzlE?=
 =?utf-8?B?TUdaQ0xMd3NwSHJ0aGZ6SzdQL2JHTVhxaTRDKzJHRTBHVUNlN0Nkc25MTEdq?=
 =?utf-8?B?N1pOVmJ6aUFGWXd2NWc0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJzZkVGdk1MbVBNY0w5Ui96Vy9pT2J5dDNwdXA2eC9LcjBTQWo4UDNNOWRB?=
 =?utf-8?B?VVQrM3h0RW5TaDdKSG83UjE1UVBleUY0VWNYU2kwMmlPSCtUWVVxa3ZXVlIv?=
 =?utf-8?B?bTdLK0dEbFNhZm80dXo2ZTYzS2tKa1k2cDVUMkZoOTNaSG9ZTzlBdTZYNllB?=
 =?utf-8?B?MXo4Zk9aZE5DWFRkNVZrbmZJaEJ5VDRudWRpdXh0bUpxZlVhTkVzbnBIaXRF?=
 =?utf-8?B?OHRtZVlsNXhoQU5rekNYMXBTemFBdzhhbHNCbmR3bVFnaGpRL0V4NjUrdkRL?=
 =?utf-8?B?bjVjMGVGS2hBWHB4MVVhQWIzL0xCeGU5K1hmc2tpaGhVTjlYVVNES2NhSngw?=
 =?utf-8?B?OEtHMm5DUFNoOEVuZkthTVJMOG5vVVhCM2lvSUJFY0x3TmRYRmhaaG9vdDFm?=
 =?utf-8?B?SHJ6U0VLaktNaUhHdWZhMmZJVkt0TXRzNzcxOFBnUWpZVkFNN3JoK0FHTFpT?=
 =?utf-8?B?YU1lQkVUbVZXS0x6eWViT25URmp5Y3hkTDV6M2xPVXdNck04a29mdXU2cHM3?=
 =?utf-8?B?M2pRUXR4VHNNZDJtdHNwVlYrZzFCS0E3b2F5aEpiNFR2c1RVT3E1RzlvS2FH?=
 =?utf-8?B?cDdRNno2TnhWamdvWWc1QnNKbnptbUczd2NZUG9oNFZ1Yll2cXJLdkpIQ3Q5?=
 =?utf-8?B?ZzNPTFhUUytkK2FOd21OMElHekNqUzJvREpMTXYycmdqMnBXOFlWSFoxdWdF?=
 =?utf-8?B?M05hUGx3VmFCVTIyR3hYMk5Hc3NWN0Y2YVlKM2hpL1VJRGk0NVc2UHR0L3Bl?=
 =?utf-8?B?RVVTNElFOWlETHIvM09SQTc5VVVqT0d3Ukhya2h3U3cxeDExL2JLZmQrLzJy?=
 =?utf-8?B?NmhGampxWkI5d3JUb0E0YlVLTWs2STh6dXdHNTVvWVYzTUtmUGdGalRvSEFQ?=
 =?utf-8?B?Z0JtNFc3Q0lZYk83NXNNUzFqZkVieVBSanJuYjNGVmhyM0IzM2ZYaUJVamxY?=
 =?utf-8?B?ZHpWTXZFcWM4Q202cWlsSHNxM2lHeS9SeUttTjQ2QWlGYnpVajRDZ084emRV?=
 =?utf-8?B?NkVKaDMvY0orZzhsaDE1Ui92VExPRUxTeDkwdW9ENTlCc2J3Z1BPdkpXZGtH?=
 =?utf-8?B?TjB3SHdWUEFYMlNTYVRRbUZsQitMVEsxdTQzOWlKajdVNk1SK0ZhZUsxTkQ4?=
 =?utf-8?B?eTRVMUFRN0hZai9SckJjbEp2QmlkKzBLMkZqUGN6SW0vU3V1eDJMOXNHclF2?=
 =?utf-8?B?ZzI2cmhyRU9FdUxnVkkwMHZ1TWRlYnRMSy94bFBycWM3MVNDK25Uc1hUdklY?=
 =?utf-8?B?cFoydDgzeG5IbWZ1K2U3TG5FWXczNC8wTTFaN3M0K1p5QXpLVHhQRGo5ZTV4?=
 =?utf-8?B?UDIrOEJ1ZmpML0F0aVEvT1F6TEdtN09oT2VRWGdzOXBCMHF6SWprb2VIRFUy?=
 =?utf-8?B?cTN3aDI1S0tic2Z2UkhuZ29mUWxHZzdGVHNTMnBpZktJelE4SGVRaFNPQU44?=
 =?utf-8?B?a24zWFBBMnVnM1VhN1hobEh5SGZ6WXJzaldESUc1MEVNcUhSL1dVY21aa1Ja?=
 =?utf-8?B?YUVobXBNR1JKaGdraUtMOXJ2aTVUTHRBUTg2OG9EenY2eCsrWlNXN2VPYkVX?=
 =?utf-8?B?bWFCVHJhWkc0TVJ3TklxZXBweDZXU1R2S1A0M2d6RS9jdXZ6WUVaV2Fjb3Fj?=
 =?utf-8?B?MUw1OUlPQVlSSVRMYnc5cEwwWE5BbEFlRFo1djVXQmFnZkJLb1lERlBVVGZK?=
 =?utf-8?B?bFUzN1FlZ0lBNmVRSVFOS3I4cUVKWmJ2ZWVXV2pMdGtTTnE4ZWFVU3NXdU1j?=
 =?utf-8?B?SzZSejlmQnowUVdka0tQa3k3OVNyK2NHT2JNaTc2dGxua3pERXI5dzFqdllL?=
 =?utf-8?B?dXhDZDBHMFpicEFLcEMvcW5vWk9VTWJINVR4OFY4NnlOOFNVS0djbnEreVor?=
 =?utf-8?B?VVBuMXZOY3p2aUcwdnFOKzFjNWN2c0pReTdJQWM5NmFocmpPMjhxVWdSYlR6?=
 =?utf-8?B?dFAxWUFPNkxLa2VmR2NCZ1doZUZtbC9HRld5dTdTOUx4L1RKM0VCYW9USU5E?=
 =?utf-8?B?aWhDTEcvY0o4bHZpV2hWSjR4NnhXdEg0NmErcU5pcS9ZR2EvallJaTV6ODIv?=
 =?utf-8?B?YkVsaWlyUERxWFpkSXBUb1kwWVhSdlJFdmR3KzRUdVJVVFc2UG9zM2FYaWlC?=
 =?utf-8?B?VFJJSW96WnVOdzN2Rm1FcHgyU1RlWUlqM0pTQUZxa1pSVjNZOCtza0N4TzJW?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MM5g2+UZ8hZTmug0Arv/c/UBhG+h2XZjWumKfuBKzcWkIg+1at3twcTTYvIsS1ibN9FDyogcdnm+e18COc4HyWkV3mkfwLm6AGQK7a705IhH8W98iti1aRgjKJq+3I7jsSDtxZxdSZ20RBTt+6Z/gXkc23qE7gNjeCjcgATEhiYr1njJrvXdU9Hs6el8U4DuXhV19c8/PHK6wn1rq7iFQ4tEFXjCDwQIFKfDA2wrGNwnj0fkiOHwIGwvsh32AtRK11N7aqeT65/nX5jPg3OJa80rMygdI+tTiN4KNNQkgK3BHPPBe9WtxPFZ+P7tWNPUV1lirGchCeMEzeUQBzoqOr3L/sG/g/dDg+E10HrtYBw4yHsEo3i32U/r9vauXTWlbTQQlzZAE1ZGK96HHWVAY7Gl4UYsPyWG/RSgabbPDowQrtIFi+zMF5WkIGwnhj6jUy8HaqtjD9rfXeycze0KBwm25tlZHInRmSoQVYLkAS0+OJvl+d/AooKnLJFX52RJEZo0XqWgjtzlSF71xNRt3lgYSxKpeJtvKpkaALHHSf5Cc3rxVXwYhzk9TyVPwaJ+CoAPCiXAEQf4eS6oWRceir8BSX8pl58vv6Ki9XMjC+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffcea87-972b-49d4-2580-08dd40433784
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:59:19.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAMVIimXnDYFDqInJi1UHfD7ZACgUrRd356AP+rSFKgQ/aU7OgtieBAdrGm2F4ZfDjK50nXGz6yErrYbh8/2Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290072
X-Proofpoint-GUID: BsF8fkWL2GUDpEvcTd5ODZlMTScBsJRM
X-Proofpoint-ORIG-GUID: BsF8fkWL2GUDpEvcTd5ODZlMTScBsJRM

On 29/01/2025 07:06, Ojaswin Mujoo wrote:

Hi Ojaswin,

> 
> I would like to submit a proposal to discuss the design of extsize and
> forcealign and various open questions around it.
> 
>   ** Background **
> 
> Modern NVMe/SCSI disks with atomic write capabilities can allow writes to a
> multi-KB range on disk to go atomically. This feature has a wide variety of use
> cases especially for databases like mysql and postgres that can leverage atomic
> writes to gain significant performance. However, in order to enable atomic
> writes on Linux, the underlying disk may have some size and alignment
> constraints that the upper layers like filesystems should follow. extsize with
> forcealign is one of the ways filesystems can make sure the IO submitted to the
> disk adheres to the atomic writes constraints.
> 
> extsize is a hint to the FS to allocate extents at a certian logical alignment
> and size. forcealign builds on this by forcing the allocator to enforce the
> alignment guarantees for physical blocks as well, which is essential for atomic
> writes.
> 
>   ** Points of discussion **
> 
> Extsize hints feature is already supported by XFS [1] with forcealign still
> under development and discussion [2].

 From 
https://lore.kernel.org/linux-xfs/20241212013433.GC6678@frogsfrogsfrogs/ 
thread, the alternate solution to forcealign for XFS is to use a 
software-emulated fallback for unaligned atomic writes. I am looking at 
a PoC implementation now. Note that this does rely on CoW.

There has been push back on forcealign for XFS, so we need to 
prove/disprove that this software-emulated fallback can work, see 
https://lore.kernel.org/linux-xfs/20240924061719.GA11211@lst.de/

> After taking a look at ext4's multi-block
> allocator design, supporting extsize with forcealign can be done in ext4 as
> well. There is a RFC proposed which adds support for extsize hints feature in
> ext4 [3]. However there are some caveats and deviations from XFS design. With
> these in mind, I would like to propose LSFMM topic on:
> 
>   * exact semantics of extsize w/ forcealign which can bring a consistent
>     interface among ext4 and xfs and possibly any other FS that plans to
>     implement them in the future.
> 
>   * Documenting how forcealign with extsize should behave with various FS
>     operations like fallocate, truncate, punch hole, insert/collapse range etcÂ
> 
>   * Implementing extsize with delayed allocation and the challenges there.
> 
>   * Discussing tooling support of forcealign like how are we planning to maintain
>     block alignment gurantees during fsck, resize and other times where we might
>     need to move blocks around?
> 
>   * Documenting any areas where FSes might differ in their implementations of the
>     same. Example, ext4 doesn't plan to support non power of 2 extsizes whereas
>     XFS has support for that.
> 
> Hopefully this discussion will be relevant in defining consistent semantics for
> extsize hints and forcealign which might as well come useful for other FS
> developers too.
> 
> Thoughts and suggestions are welcome.
> 
> References:
> [1] https://urldefense.com/v3/__https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html__;!!ACWV5N9M2RV99hQ!NoUXCJI_ofztyeV6aq2HvNI4YHcyjSHvzxHkw0fSGB9_SKz6jkAqzBVy7WcUSNNHrJl0jM0qolbvuVK2oQKuYw$
> [2] https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240813163638.3751939-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!NoUXCJI_ofztyeV6aq2HvNI4YHcyjSHvzxHkw0fSGB9_SKz6jkAqzBVy7WcUSNNHrJl0jM0qolbvuVLgqkSeIg$
> [3] https://urldefense.com/v3/__https://lore.kernel.org/linux-ext4/cover.1733901374.git.ojaswin@linux.ibm.com/__;!!ACWV5N9M2RV99hQ!NoUXCJI_ofztyeV6aq2HvNI4YHcyjSHvzxHkw0fSGB9_SKz6jkAqzBVy7WcUSNNHrJl0jM0qolbvuVJ_GK50Cg$
> 
> Regards,
> ojaswin


