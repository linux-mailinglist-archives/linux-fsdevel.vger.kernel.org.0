Return-Path: <linux-fsdevel+bounces-28067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3996660B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAF1C22587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54E1B5EB7;
	Fri, 30 Aug 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RW/K9O5U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WlH7+S4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36331EEC3;
	Fri, 30 Aug 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032948; cv=fail; b=P7biGu7OsB2tpGnIWdo0+FoQw4dlP2MylKpe1jYFEOz5bbnerMENv+UIA2APra2T5kOX3FHBJ1id+owhd25ltrcNKJ+pHCzgVqv4TOeZpp0beIxHt4yLRDP3Ee4uwPKtH4S1Ko5vOt8Le5LtzF5GGKf10D2y4hY4EkixRjglgZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032948; c=relaxed/simple;
	bh=DnP7KkPne5NNTlx07AHZ0B7osqMHN+ZZziYMVjmjmhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+60c/rxvU1Z8AiqfLHX7h/1tJhzB4Yuvbj8ZxsSOkc7XPRcuN+lR9Acdh3LtgCMkG5NpJtSSdihocl7B8dy4ukB7Zd/rnIAfjttRTEPcvGS/IvJVcSKH5ByRM8kPT+9A0oK8h2cUcs/q6o3yqQc6H2w0JqWu+DqycdDyL0QBsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RW/K9O5U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WlH7+S4R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0UEb018868;
	Fri, 30 Aug 2024 15:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Yr7TQrMJjDCfZvd4N2mQA4e5qOhyiozII2KNOQQ8WDw=; b=
	RW/K9O5UNIwxMiamzwAHeBhX3Z8m6pEnHJKN/+Fbjf9VSfVBz1QMy1KdVuG1vZdl
	dCVLvOvfOlgD3g+dRE649UA/vnriiXDpkZdjSUnvu3FzDl2eyEGmrP1tHnHxun0z
	vzQBUU+Z8RxZ65i2Jqk0tfzHysAMzKrRNskPGMGqCdNsBZWQZHECQUFqmesLZ2vg
	4Lk5cfIAUyaP9ZbcZwnZfx5Aztt2XGKPWYOLLIBZ0BqraN7/nuuUyvh6j1z9QsOT
	Eql/Z99EjH+J3OnTpy5XbgXmPqDuiJuv3HA4WrxjfRF2mSzvch8yYDQo7ht/i0gz
	Y50ajb6ZuqPJ3QHu/RG2DQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugy306-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:48:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFG5HY036539;
	Fri, 30 Aug 2024 15:48:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jprbdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+1IkyxT3W4iWorITmqscLklfnnY/MIscVYrWvIkyGOgxSGO8A3g2HFxJKnvz/mYwachPqdgkNS3n7LA2p5bUWMKy2E548wWpOSIhLjZhmujVlNZ4xHmSrS0Styw3mGlkuzNlav3GjA/AfZoBkVHeV8uZM45NArEiRxs1cmnPBXOaqFiGf1tddK3Fs22SkCRAazSOdU4aeR4Gzjm1xJIkYzJNC7tvsSsJqg1VPQYS/8R/Otne3KFnjrihJzlLG2FcTPWS57rVFgolnOzYsFzlIy6l1q+No8Db4uB8zoCGu60tKCQ1LpDD0sWA9iE7rz6NrnLL0MH1W0ALlTWPGgkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr7TQrMJjDCfZvd4N2mQA4e5qOhyiozII2KNOQQ8WDw=;
 b=x4UxX9YyKYZcZ/SWo0weYrbr9G2rbWpIUyqsJuzM0g0IDfGQ6ZOD3T/7To7kEaddOmeRCGONuR73OSOeXqP5U02SdE5wS3g4XbDGg4XG5sB2N2R9i5uFWMwcuwEwnETd5QG3SQpQdZ+zeEF1FXsGrIN32/5klkkPvo0FDS8WfXEbEGoaUzJMOoupEmQ6sUCGpkdn3N6vuNUDPEjT2TdJN7Mbr6czOEjfbcdHNd5fe1Bav3Vh+ZL886Eyy72tQuW1dsbhh0ruTebPtwOXfvY3gLKvP7kwTPYgrrBv8uSk9RQ5JUKOwCZxEpm4AO//+GyoOk15dvZ+wmzqhac5URUpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr7TQrMJjDCfZvd4N2mQA4e5qOhyiozII2KNOQQ8WDw=;
 b=WlH7+S4RjoIz4fmPW9OepVaS1/bm/B2POtKNJsmOJhRUSiAXtcspd0rut/qgudnMNUeKJR4w5krYC0wkXpV5bsSfckJ94WFyvnhLuVJl47pIjWH5/RZJU/Rgl9IF3i5ZIX4Hx2b5hp628koc+/Z5fc0Y2umBPleb8ShjRnv9QE0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7003.namprd10.prod.outlook.com (2603:10b6:806:34d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:48:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Fri, 30 Aug 2024
 15:48:42 +0000
Message-ID: <112ec3a6-48b3-4596-9c20-e23288581ffd@oracle.com>
Date: Fri, 30 Aug 2024 16:48:36 +0100
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
 <a91557d2-95d4-4e73-9936-72fc1fbe100f@oracle.com>
 <20240822203058.GR865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240822203058.GR865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: d021350c-c859-43cc-0cd2-08dcc90b391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejdMb0tuTThZTVhqOUs2cW1DaDRJV042UjQxUjY2VXpuMGdldVluVS84ekVU?=
 =?utf-8?B?a1FmNTAxcXR6WGpEaHI1NURkdTZxbmJEUmlSUWNZOStHV2thWWVUQnE0bUE3?=
 =?utf-8?B?cmwvditSNmFXR1BMTTlsWnNTVE1RWForRjJQYnV0Q1BkM1Nqc3NLbFhSN1Bn?=
 =?utf-8?B?U0s3OWNNaFpQOUtkcTBUV21vU1FwNEJPM1UzaU81eGlvMXJoQi9vc1JJYmg3?=
 =?utf-8?B?dGRQb3lBejZ5QzVFcGJJVENXdVQwREhXRGdqSG5TclJPYkpNVEQrUW16M05Q?=
 =?utf-8?B?aDJzVmM0Z042eUdJVk9wbWdTU1ZEZFJjcmJkckltaFJ3WFpUTzB0YXN3Z3d6?=
 =?utf-8?B?TUVNVmRaMHNTTXRhdWlyQjlrM1NSNmZXOVdpYkE5bHJydkZEc09wZXZLMHp2?=
 =?utf-8?B?VWZkSHhwUHZXMVNQdVhxN3MxZGFOZEs0d3NTMTJ3Sit6SnVXcVN1VVJjUUd0?=
 =?utf-8?B?am82bHpMQ05ObEhHN0RFZUhhVlhQMThpYk44UmRra0hUL0RZZWNtMVloWEFM?=
 =?utf-8?B?UzJhY2J2WEp6cEdiUGhIU3JYb3B3WDFHWHh0VDR3NFB2T1g3OUU1aHY1YjBN?=
 =?utf-8?B?bkQwZnFxUitJdkhiL1NCUDVkSzBlR0dNcWpEcUcrT3oxcnQ2NkU4UHFOTzdO?=
 =?utf-8?B?dEhZWm13SGEyelp2b3V1MVRlK2h1MUcxd1NpcVBMMDdzUThuZzZxZVUrK1dw?=
 =?utf-8?B?SzZsSDB0N2JjS3VnbUx6VlNCSllMQmlzNUkvbzlBNTBMNWk0V0NpcU1wYXVE?=
 =?utf-8?B?NkhUTUZlQktvcnFTcGlKVTdIOE1kb21KMk8raFhEeW8rZmd1RGJSNVRNWWhS?=
 =?utf-8?B?cURNbDlRdTZnOXVFK2tEY2twTkIyYVk0bEVRei94VXhrQWw0TEEvK0szcjJK?=
 =?utf-8?B?Ky9GUDR1S0xMTkZURWd4RXZNWXQxQlM1cW42dVF1dmgwQlRNZVhmZWNudk1l?=
 =?utf-8?B?aDd1TzJhbDhxZE9ZNTBrNEE5WFhMWXlWT2RDb2U5OE0wcDFaSHZ1a0tjYTE5?=
 =?utf-8?B?ZUFSaHlmYWJraklHK3c5NUtxMzZnTnVJL1k2Yit2S0hNUjNMNFI4YkIxWVBQ?=
 =?utf-8?B?dFlGNHIyWDJmOHRPaitrbFZMTHJ3RkREVE9uNjFXd2NDQnVFUjdGb0VqUXJu?=
 =?utf-8?B?Y2lSNHVoeDY5ejB6WVE1aURjZzFLSXoyKytXeFVGbXkxL3hLRlphRDc5RkM0?=
 =?utf-8?B?WHNLRDYwRzZGZ0dRZlpweGVHQlo2bVEycktFK2cyUUpGbGNrYVFXVDdObnVP?=
 =?utf-8?B?b0R5cmJvTkQ3L0ZqY3BLOWJvTHNxcVA1VWJYcGcxUGJTQXhIVS8xeERjbVg1?=
 =?utf-8?B?QnpwcHNPQlpnYy9JUlpiVkhXYUE0dnhzd2hYL0xxT0NRTEd5ZG5pUmRyRjNr?=
 =?utf-8?B?aU5xWld5R2lyN0wxdlM3ejJ1TEt0d0N2U0VSa3dacU82N0dZRzVRTlRmQ1lh?=
 =?utf-8?B?Vk8xRmVBZ3B2ODVGc0lVZFRNNEMvbUpWbzBCcXdTYm1ESkZSRlBFWFpRUWgv?=
 =?utf-8?B?TVdZTzBGRmxWVDV2NGR5T09ISlZIZzFqYThvbXZJU1ovYzVJbGJvbUI2ZCtX?=
 =?utf-8?B?cVExdjljV3pIRW9Hcm94YUVRaTRITVRXM1FKUWJGUERqYjdtTWFhTzBPb2pI?=
 =?utf-8?B?d1pJN1ZzTlhWeTI1UTRaSlVkTVJxN2FGMjJoRU1NMUNtZVJLT0ozc1QvM2wv?=
 =?utf-8?B?bG16SmF6NkdIRDdaTVFYdWJybndHaFd6V2wyVm1PeWVkK3EvMzk0akRuZDdx?=
 =?utf-8?Q?N7MN/12XUawloIIkG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzd3WC9wbjVWVEIvUDFsVjdMTTh5ZFpwME5KdkVkRlNmamlYbG1CRFRxTlAw?=
 =?utf-8?B?amJGMjJZclcxWEVCcFNGRG1hUUx5Y0tHczlubzhTSE83dUY5bkRJV1VUaEdU?=
 =?utf-8?B?a01jS3BWWTh2Tjl0aUU0b0VnQUFpbURPV1FCVWt6d253WXBsSVhhV3dIQ01l?=
 =?utf-8?B?cHR5NTNGU29wR2FiTWlVVWRYSTVwbzJlNzNBZnpGa2VCNFpBNjRzUmhGOGk1?=
 =?utf-8?B?RnpRUWo4NVByUlc3Rm9wYWVJU0pRZW9neThVZjFwdndYaUxBbG5wQXJEVEh2?=
 =?utf-8?B?d2lyY08yNnNiaE5rT1hoN3VqTXo4WTV0blIxaFRBbkx3ZW5xeDVMenBYWEh1?=
 =?utf-8?B?aTRaR1NlVE1pbjl0dU44TEhxbkxoZmxNdEhOTGoxaDFyYUpuSWEwTTVBYyti?=
 =?utf-8?B?QzYzRDdhVjhnU2ZGZ0RRMTNabW90YmxPbTlJejRRa1U1OFZyVmdnSTdZaURl?=
 =?utf-8?B?TXNOZXRrWG5uYlJjU1JUbmU2a3ZUNVRXRFJQTW1nMmpIYXRoNkxvZjJHcGZ3?=
 =?utf-8?B?Z2RLd3JqcUZKUjFDOWpjNWlENXQrTTQ3TVlSOUxzWjZEOVBud09nZklsY0g4?=
 =?utf-8?B?cXp4OVJSbFFLM09tN0hGTWZaKzl1RWpleml5cmVDWHE4STVITWZ1aG10NVI1?=
 =?utf-8?B?NXhudnM1UnQ1M0ptQll0NldtNEd0M1UyemI4QStlUlZ4VVBRNW5wK2YyTHFl?=
 =?utf-8?B?Zm9MN1hxWWMweldYeXd6Y0dqbElPZXlVM3NpUjRFa2VJK3FXRzVzc204ODJY?=
 =?utf-8?B?THZMRUZYOU1rbXNtcWx3a1ZVK1QveVdST2xRa3diSVNON1pQTnVicnVlSWla?=
 =?utf-8?B?eHVjZDFSeFJFUmZwV3hOTURja2hDNVdLaG53eTJJbXZFcnE3dDVmVFQwcW9B?=
 =?utf-8?B?ampGZ0pqUFhmRk9xT3NmblM5UFVCTHBiMU15Q3QrNURKSE5sbzRnQUVWWlg0?=
 =?utf-8?B?dFdENVNtR3RudVZvZWNuaWJVK1N3MXBQN0NYaWJhSGlyT3NhV0QvdmlQejAx?=
 =?utf-8?B?WklSSktBMzRmQ1ZVV3dtUmRwL2JHTVljSjZZd09wZ2ZPMmFLeEZMcjQ5K0lP?=
 =?utf-8?B?RHIwMzUxZEhkYVFJZlNtUnVGOVBGY2RWYks5cXAxaTUyYzFZL29vN1Fyckc4?=
 =?utf-8?B?Mnh2bWFjREJ5MzN5ZFpPdDlLSEpzbjNNQnMzbXVGNWFrSGxMK3lsdWM5VUFu?=
 =?utf-8?B?LzE4Q2RjTzllWVNGS2g5U0d3MzBMTDlnS1NPRVVqZ3JqK3FmWVpWTzdPektU?=
 =?utf-8?B?T3oxNWJMQ2RaVlRFNDM2ZHBWQWFKN3U2MEtxRERvd2pta004eHRoMFpITHBW?=
 =?utf-8?B?RUd1ZThwWVlvblM1REI2eThWejc2dlNuZ0VaSk9GaXdETDB2d3FKTDd4bUh0?=
 =?utf-8?B?Z0g5YllYTThXMHBlRitVN2lreWlQejBnWWFDeVRyN2c0Z1R5RkdjV0FsbHUw?=
 =?utf-8?B?V3R1Qm5uYTlwdEJqWE1aVlE1V2pEZExicUFQV2JaZUdiVlFxa2tTNThSMDM1?=
 =?utf-8?B?N0tiS1VsajJhTE5IaUdRbFo2b1pzVzR1MnVRcU5odm9oOVpSQlF3RzRYb21O?=
 =?utf-8?B?VGkvQXpqVHJoSnJXdEYwTjhjczlUV2NIOEZ0cU9FbXFUMDFVMzhpTStEQXFC?=
 =?utf-8?B?RFl2MXY1M1FrRmx6VmJWVHNrN2xwK2NDVWNyai9hVlpvY29JdHp2QzhzUFds?=
 =?utf-8?B?aUdzVGpYb0k3RmlheEVsZDNtRU5qZit1WmVHekFXVWhoQlVraGxZQTlGdXFl?=
 =?utf-8?B?cjR3T3JNSTU3VUs4NDZ0Q0pDbU15ZW1ndXM0ZThGWUtWcjlkZGpQaElndS94?=
 =?utf-8?B?RHk5ajE1Snc1bWlENWwxRUFvT2p4b0srZmpKNDYyNHZnRWk0aHJuN3UwVVF1?=
 =?utf-8?B?cHg3bTZucVNyR3Z0UElOa1lEYzVwWUZDSnVDanVHWElSKzJZdVpVeVRpOWFq?=
 =?utf-8?B?SlJQcm5FWXNuZWZydjNYamx2UFFDTkU4ZHA3cGUrbGRwWnE1KzNUZzUvOXFO?=
 =?utf-8?B?USt6ZHFBT0RGL21seU5aMStBWVJNbVJPOHlLNjY2MG9oZ09IQ0hMWlNKWlRG?=
 =?utf-8?B?RDc1azZCYnh2RzRkUTNhaEFOUHplRmJhYkdmWnVMZkxrWG1lRjlOMHRiTloy?=
 =?utf-8?Q?OtDvDtenbFuS1hQRM+8v/KhSB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y+YQZBH0CVoHP9vUAyr7di5qLn4I4vw7vPlDiDHSCXERxtBlOS4lnxjbKLWw8OkAZLxx/w0NPHHFsv15WNUWS9uW+eYNb9x8VrmHjULsQcl3ppZF5jOGSQbT5hnSiZk3+jp4zU5eXHcA73uLeeGEE5cDgy5c6JQZ+xzQpI6bCDQCJay+sTaECALz1u4wTHxowNZ8omDdSi3iND/HYXuBjGuG+m/K+gHEKh28Bwsk8VfnFr1gExGT47bwB8tQsHATUcIH5YmoydKrPGBXsyt32EStpY557xd/rghG9nwd5FRnuwhWRm0FAswEwhcy670Qvir8hFi6+FXtaMCxa8LbK1/B0bDRuo9KIREIBFuzfbnmBIsLYa/pEKlkh5oOPBGr1ZA46/M6cvZB+WVaeVouI7JdK/yyKOdYxPHVD5Zef1eZFdfmovPjVsq7GDcEOxy9VabKlJh6C+hAW6ECYuHK9C34uRM3uRJaQVZyWnfv2dEhYurJ/96EdAG8mfAlamOnytaZ11ZjkMl7n8rOPdB3MDIF8Uq7DN6NmNqUfTk+iREDr40oa5tu081IPyb3ZVa4qb5+NUs1nWYrbB5KtqHmCXUVfYwz8iGMtTsuHKwMBsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d021350c-c859-43cc-0cd2-08dcc90b391c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:48:42.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ytBwukrcwj5YzZvyqbXV8VgeOM6y8rGug4bgrX2AE0H1ZkjMFfRrpNJQVyC4HxNVb1hpP69RmWt7E3BeYHptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300121
X-Proofpoint-GUID: XzOeYs0tU-A01ud9lM6xzfPkeTdJTEO_
X-Proofpoint-ORIG-GUID: XzOeYs0tU-A01ud9lM6xzfPkeTdJTEO_

On 22/08/2024 21:30, Darrick J. Wong wrote:
>> Then, the iomap->type/flag is either IOMAP_UNWRITTEN/IOMAP_F_DIRTY or
>> IOMAP_MAPPED/IOMAP_F_DIRTY per iter. So the type is not consistent. However
>> we will set IOMAP_DIO_UNWRITTEN in dio->flags, so call xfs_dio_write_endio()
>> -> xfs_iomap_write_unwritten() for the complete FSB range.
>>
>> Do you see a problem with this?

Sorry again for the slow response.

>>
>> Please see this also for some more background:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux- 
>> xfs/20240726171358.GA27612@lst.de/__;!!ACWV5N9M2RV99hQ! 
>> P5jeP96F8wAtRAblbm8NvRo8nlpil03vA26UMMX8qrYa4IzKecAAk7x1l1M45bBshC3Czxn1CkDXypNSAg$ 
> Yes -- if you have a mix of written and unwritten blocks for the same
> chunk of physical space:
> 
> 0      7
> WUWUWUWU
> 
> the directio ioend function will start four separate transactions to
> convert blocks 1, 3, 5, and 7 to written status.  If the system crashes
> midway through, they will see this afterwards:
> 
> WWWWW0W0
> 
> IOWs, although the*disk write* was completed successfully, the mapping
> updates were torn, and the user program sees a torn write.
 > > The most performant/painful way to fix this would be to make the whole
> ioend completion a logged operation so that we could commit to updating
> all the unwritten mappings and restart it after a crash.

could we make it logged for those special cases which we are interested 
in only?

> 
> The least performant of course is to write zeroes at allocation time,
> like we do for fsdax.

That idea was already proposed:
https://lore.kernel.org/linux-xfs/ZcGIPlNCkL6EDx3Z@dread.disaster.area/

> 
> A possible middle ground would be to detect IOMAP_ATOMIC in the
> ->iomap_begin method, notice that there are mixed mappings under the
> proposed untorn IO, and pre-convert the unwritten blocks by writing
> zeroes to disk and updating the mappings 

Won't that have the same issue as using XFS_BMAPI_ZERO, above i.e. 
zeroing during allocation?

> before handing the one single
> mapping back to iomap_dio_rw to stage the untorn writes bio.  At least
> you'd only be suffering that penalty for the (probable) corner case of
> someone creating mixed mappings.

BTW, one issue I have with the sub-extent(or -alloc unit) zeroing from 
v4 series is how the unwritten conversion has changed, like:

xfs_iomap_write_unwritten()
{
	unsigned int rounding;

	/* when converting anything unwritten, we must be spanning an alloc 
unit, so round up/down */
	if (rounding > 1) {
		offset_fsb = rounddown(rounding);
		count_fsb = roundup(rounding);
	}

	...
	do {
		xfs_bmapi_write();
		...
		xfs_trans_commit();
	} while ();
}

I'm not too happy with it and it seems a bit of a bodge, as I would 
rather we report the complete size written (user data and zeroes); then 
xfs_iomap_write_unwritten() would do proper individual block conversion. 
However, we do something similar for zeroing for sub-FSB writes. I am 
not sure if that is the same thing really, as we only round up to FSB 
size. Opinion?

Thanks,
John



