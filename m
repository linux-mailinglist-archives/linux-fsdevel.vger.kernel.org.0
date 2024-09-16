Return-Path: <linux-fsdevel+bounces-29451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B5979F37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CDB1C22CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A91527A7;
	Mon, 16 Sep 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bwlm/ug7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eO0r2UNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BFA935;
	Mon, 16 Sep 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482317; cv=fail; b=TQKqUOeTwgAV2MyQT+vJ7GDE3ACZ4wUiSSshqlh+6Tqg5DVeazKHzt8A7poVnnX8qyJ77GPjZSdUG4FoK3Dj5Sw5QRC8sRWmiT4yCVnzrPgtheVPuNWWHrX83yN5iTZttm04nohK6eQaMsR4SMCsLtVNafowODa0qR2FjK0dItk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482317; c=relaxed/simple;
	bh=Z4AvYTrlszP55oLOD2zb/fVisvmshCN4tB9shZRW588=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNihp8Fec3BYNIyXWNjT7mG6k+fSl3tmuUPmfXyqXSwLeCGk8jr5O1DiHB9Zfv+pcDLkMHfV8x9I5MAXgRf+CUdA8Yls+2/wqNvH3TAqVbriqxxQKKFHLGt41oJk2otOxpdw56C+PPhWVBXoyFQuyOb3mefyoM9SbEKuqUsvoP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bwlm/ug7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eO0r2UNO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G7tYeX001760;
	Mon, 16 Sep 2024 10:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=oR7hpQvciHK0tV8khvK2hDNYPik+N7lYqQV84caY6hE=; b=
	Bwlm/ug79+EuJOd/PP4hF6SOcZyOp6obJa5DUDkXNICbjzwuJSn79yVnvkOl51w1
	KipeSDA8p5ha67DenvG0zoCX9t1euqq0Iw1InTdajpV8EbYuMy0tE/Pl7eidH2qU
	RYFYlz/ZDcJ4dH6rzmptJZUmspod76YmN3tKjzYyq8b4CCWjHPCcNqcgg2hGAvTT
	O080w0KEmoE3eHao60NXydPE6BDR9IajGs8SzYjN1yjeHLM09isrgy6KQUuneWxV
	1VgWujfqjb9klG0URMQw+ex9c5CdLtq2uOUac3bM8M9F2MPWBFBea8zgOFeM9NTU
	33oe+ThDEswxKhpRw6pFzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfjxea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 10:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48G9MMHc017909;
	Mon, 16 Sep 2024 10:25:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycv60jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 10:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LflAGFZyNxP48JIVmCBVAoiHLcOoMGGiiXTGcVP0S8+HXyJ2BSBC8n4SPb9SOFidtHOQsRY/sGBJ5uG2/RmSseRJOyrCmMShiXkdCKTTIUlp+v+SbGliCqw/2LoMKygSyWV6xk1JrvNoZzbY26hmn2arU3uBlo6Z+bpkvjRWmIHEXx5KtuvRaU/QXgXUq/FV1SmONi3tuO1NpRsLHNB7UMSW2g3g+L7UIJmND/cnhZCNdSM6nhA/vHmprEA48LspaV/o54FYdKb9Tn4mS9Il4fr/7egkB8r8KS6gpQJjsCplFQBeA2CIaP5FfOB/9j9nZCPZRUIJCnVhWTVqZf8QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR7hpQvciHK0tV8khvK2hDNYPik+N7lYqQV84caY6hE=;
 b=o4o6FUtVoxn/1tUyZuc8suKUaTg24K3kS9l+4G2jPEUE56bA/4+Ehhu2b6vv9IWB4pW5kMwHWA9JW/VVbR7B2aSz+a4OA5RpDcU8qCmYiFGaVQ/QPridzkvdwVgGJAfG2pYqH4zYEfKX1G0rMsISqqKFvkkli5SvSW8O3Wk95PbwohvicRW/cbvRmpZXZAsls6Y/KONKOgdGlt3Mg4fxAq0BorpujNP12BkJqAne+S7q6c4gLCSVrklvR+lozGEyvN2u8doufls86Wt4Q5C9Tp+7+/EYaTyEIdH/dnIVvHJeybgiLWUh4fgbCjDTbzDonnJIHlhRiW/RADT6VdJS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR7hpQvciHK0tV8khvK2hDNYPik+N7lYqQV84caY6hE=;
 b=eO0r2UNOopO/AHHdEX4bG0Jr3ZxEuhsKBiRrqUuUofL7UsbgPsFaBzETFqsoI8f21eTP+WlrugCCMp5eS6aho9zGke5tWM7E/4HWwOQMomioj3G2C4zOqfCAotOp//P8alwoFR3jUSM3QqrU0eD/lVUoVqjko0fZfyO92D6IPeg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 10:25:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.011; Mon, 16 Sep 2024
 10:25:00 +0000
Message-ID: <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
Date: Mon, 16 Sep 2024 11:24:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>, Ritesh Harjani <ritesh.list@gmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZufYRolfyUqEOS1c@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8204a4-87b5-4af6-87e3-08dcd639d1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmRWc3RPTGdUM014Mlg2WmhlYWdaL0tZMkc0NDRpaWZ1S2NYU0l0S3R2UCtU?=
 =?utf-8?B?Q3BQYzlUaDQ4SDZRc1c5QzU0VVRpQy9QTDdmN2Q0Y2hWK1lucTdvdXc4aXFo?=
 =?utf-8?B?TTFTdER0MG8rNE9QaDgxMm8ySnZqaHVsUlRFTWVIVmpxZ2NsenZCR08rWC9h?=
 =?utf-8?B?YUkwbm0xdWtWdGRHU1lKejdteVkranJCc2MvUWVGVkpUclRacTJEcTkwYlFN?=
 =?utf-8?B?WnRsaVZsOUpmd2R4QnVaNHc5R1drdUl1QmpoYk9iZVhsd0hCVEthS0RBSkpo?=
 =?utf-8?B?OWIrcGJUOXlTeUM4NklhUkxiVzNXRnk3ME5udWthaHM2QVhKZkRsZmtoeE5z?=
 =?utf-8?B?S3YzSkdIRUtHN1YrWnNla01XVWVHc3EyZXF6TEFUOEhmSUNDdUYyR0lRb2dN?=
 =?utf-8?B?blYwRVpVbkl6djU0T2VhcW1mUmxWcUVZQW1TLzhocmh4UTQ5WGowcERVZWda?=
 =?utf-8?B?ODZjNXpLRXBZVHc4Q004NGJOVjBQSjNmWElnME5iY3hkWUc4U1FuckhZOUxj?=
 =?utf-8?B?N1QxL2o3TkRFcFcram1qRUZQZEk4dnlhc0JTUWtLNlBSOTY5VzNHU2ZDcWM4?=
 =?utf-8?B?V21qZUFWbEpVek9NbW1RTk9qbzlIblRJcTJWQnNMUTZDYnk5bTJacWx1N09V?=
 =?utf-8?B?TjBQZzJEcUZuZWxlTkorbG1tZE5oNnhmTm5LaHE0dXN3bXB5OU82VzFSSG5u?=
 =?utf-8?B?VW9QRXhBc2JsM1k3MkZXeklJQXF5R2tqTFJpR05YdzVzVllmeVJZcDVNb3J5?=
 =?utf-8?B?ZTJEcDNQR092elUzZFYzRUxiOFFlWjBwZFdpeE14bDZwK0lNeTk4dDJuOXdJ?=
 =?utf-8?B?Z2RaMHRnd2JINE03b29MczhaWHBKQ01tOG90UTNOQkwwWnRHV2RDbGZja2U4?=
 =?utf-8?B?aGlSZGhVT1hwUHBPTjRyMGlqLzNCdW1LUEQvbFNmSE5NVFFjalNvSGQ2RTI1?=
 =?utf-8?B?N2pFeXRWalNwM3hwQk9MSGhnUUM2dDJuUjVvNmpVN3JJSlZveUdDMmlWbTFm?=
 =?utf-8?B?Uld1cmFEOFF3OUR2TnhIa096cnU3TkJJNXZKYVB0d2t6SElmNmJMK3hDVFZw?=
 =?utf-8?B?U1B3L1VWTVk2NzBwei9FSDJURVpJdUpCTHFjTnZtTEFjZVdGN003MHJIQVNt?=
 =?utf-8?B?ZWdGbHpJcTNsS1RaeG8vYUVOQjg1NER0WUJVbldCaWF2NTdPSlFLWkpocEsr?=
 =?utf-8?B?LzAxL0xuT0F0bHlsdU83Zmh1OEpSVzg0SklnSURFanNaa2tkZDQrLzdqZjJZ?=
 =?utf-8?B?K2V3UjdGMTNOaC9Ta3dPNTV2Y05sZ0dnanU3R2hnRExyb25yRG8rbjZNS2tI?=
 =?utf-8?B?Ym1OM2lIdGhodkdwN1Vud2kxYjFaMG9tdmhhUVRPa05ZeTdER1h0dVYrR2Jr?=
 =?utf-8?B?dGZDeDdNOGhuQkpDME1UalZ2eFMxcDQ5Y05raVhQZDhzM0RYTXpOell4d0Qy?=
 =?utf-8?B?QnNoVjAwN3UxNXZKSHhaWk9HaE1oUTdpbWZyMzdzaWx1dlVMQ2JrM1lKOUpI?=
 =?utf-8?B?Ylg5cWg1WTBGSlVQYi9tdGt1M3Ywd3g4UHVVZFRoZXQ5TC9STWNVeVJrVWpJ?=
 =?utf-8?B?LzRpTTZhR0E4Qk9uWHNVTzhTM245K0h4NTVXVHpxMC9HcC8rTTZVcGNEODlO?=
 =?utf-8?B?a0tnaGlDNXU1T2RoQWZkTjcvZWVyTnRUai9WOWNGN2lzK1N1aFBRWStWOVZW?=
 =?utf-8?B?TGVvZTJhQUdLOHNZYnpMTzErd1hHaG1ZWUMweXFQZ0habGlaR1BHeld3VDcr?=
 =?utf-8?B?elE5bDZ5eTI3U0hjS0V6UkZSNDdLL3dpcVVnWlQ4elhNaXFFVVBvUVg0S29I?=
 =?utf-8?B?Skg4M0RiSzZwQ3NJSURxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFNoY0tURFN0d1ZUTVBJYy9senhTL01LZzVtS2R4cUs3UGlMOXZEVUg2MjRx?=
 =?utf-8?B?OHRTTlJSR05iOE01V3R0MDd3NWxGWExiblZNWlBZeS8zRU9sTEJoNXh0cEFR?=
 =?utf-8?B?YlJ6ZnpUUWQ5QTE3V0hnRlY0d3M5d2JMZVZISmN3Vko4OVl1Z1hvSUpQMUJN?=
 =?utf-8?B?WjRTYmVWMGt2dWlKdzM0aktvSitQY2dLRWdLRWdqWldYMFBhK29LSmp0bVJE?=
 =?utf-8?B?dk1sUktISWplanp5UlAzRDhWWUpKRXpsUGc1dENGUytwYytwbHp3TmRpVTJG?=
 =?utf-8?B?cFZ5YzFGWnJGUDdtd2lzeVhZS0h6NmFlLzZDMUxxVGtDSXhqcTlUc2hDbkw2?=
 =?utf-8?B?ejkwejRrM2FYdnFqZ1c0djZKSHZ0Yk5PQ1dPSXByWDJrRmNUYWFxUnlmcHFu?=
 =?utf-8?B?dXREcDlQUWtEU29kVTVvYnNLc2kvcTU0WnI5SjdBR0g2WTVWYmwzMElyNmZa?=
 =?utf-8?B?UU9ueTJiVTBnb0V1QW0xOGkyajZCQVkrckQvczA1Y2dZOVVvTXBxMEdzSnR4?=
 =?utf-8?B?MlRzMk41TXpMc2tyN0RFTkIwRnRLbmZSWUtqa2taMFUwSDBETnFMTzBhdUJQ?=
 =?utf-8?B?dWtWTUcvdlpmeVhWdkV4UCtpUHJKM1BNN21QWTR0WWNJeDRyaXJHU1cwL2tX?=
 =?utf-8?B?RlBma3JTNnpsSkpyaXEvaUJzcWlxeGg1RDlCa3NvYi92VTBwaU1JelNDaE9F?=
 =?utf-8?B?YkVqVDVCNDZuOGh5QjhleGU4VjBKZnA2c2t4N1Y4UzBzQ0I5RmV5WHovMjNP?=
 =?utf-8?B?WWJiYkYrZU5SUmRhOHNTODZ3V252M3V4QTkrS3l4ekJmc2xORFJuVEhwWUEz?=
 =?utf-8?B?VzVkV3NYK2JQR2YvRlAzTFRJVGpyQVlEb1JPWXhiTFMydVpXRTY3dUxNMms0?=
 =?utf-8?B?VHhJSnRMTll5MGw2amQ2Z0ovZG5YOTRQbDYvUUhoRWxaNllDTzJKSlAxc0hZ?=
 =?utf-8?B?M2hKaVdaQzhTQTloUml1eWNPamd6MWVEVHhPcXhva1pseDJ0N3B4NDQrOHRn?=
 =?utf-8?B?UzZlMCtHdmhvNkFIMm8yekVrSFp2SFpCZEJTUitid2o4WVBRNUdjci94NnhS?=
 =?utf-8?B?NS9aY1daalZOVEpHSDhWeWc0Zit5WGw2SWJmN1hUbDFuN1hqQnpOdjViU1pJ?=
 =?utf-8?B?NzlkWG1MT2VJL0RGMlo0WUlnT1RIZGJrY3RCbXJ3ejlVK09YdFRGcWN1TDB2?=
 =?utf-8?B?UDNjY0dPTFBpWXdxQTNCMkd3NUdmNzJES1NMSHhHWWF2QWZxUndMVXRINlds?=
 =?utf-8?B?U21ycnpDREVDcGFwdmtCdmFMb2NVdlBiTmN1WFJ6dHM3SDd3aVEyNGF3b3Ax?=
 =?utf-8?B?M1ZxNUROMk1PbHJTYmRBN2htdzZYS09Xams4YTJobS8wR2hxYmpvcmpDTlpq?=
 =?utf-8?B?WS95VVd1eXFMVHg2c1RoVTBLblI5UHZsUEgzR2dmYzFJNDBMYTBWNTliOW9J?=
 =?utf-8?B?NTBtSWV3NjVHSUpYT3N4Tk04M3I4WW10eTlRWmxoblpSQTRSZkxuQTgrVjht?=
 =?utf-8?B?d2ZpYVlHa01wZUJzWjdSemZuUDhoRVpOWitqZjM4T25kTUFDcXpwSE5TQlJt?=
 =?utf-8?B?azBkb2hScFhIa01Md2IwOUpPUTE4WmJPbDk2R3BpbTZxZ2FxMHh6cjZvT1Qz?=
 =?utf-8?B?Rzkrd2w0VHA1alp0TVNWaktNbnNvczlNZ1J0TE9NY2h0S3ZlemN1U1Ryd1U4?=
 =?utf-8?B?MXlMWEhGSjcwUFM0L1RNRkJVUjUzRXpvdGdhZ2dhZUxJaG9ld1JscEpuVzVU?=
 =?utf-8?B?SGp2aU1FOXF0V2xqZURjMkw2VnA0YTdVK0VlaCs5OThCaWRpNjhxdnIxT3Bv?=
 =?utf-8?B?bGRFY09kemFCSmhZTG12R0FKcndiYkJDRHFRNDZnOGlNTkRENE9PSnBuamFx?=
 =?utf-8?B?eHpxamE5NU1nbDZuNHZ2b3lPNzVLb2xQenBsVnVwS294OHhOS1FaTW95VWoz?=
 =?utf-8?B?RlExeDQvVGk0VVZpSlRNbU0wazZuTVR2UFdVZmc4RWJ5UHo1bFNnL0J0TG1L?=
 =?utf-8?B?bkpMYlBGRjM4RTh3MUd1cmRKWDQvTXY1ZGU1b21NNXRGL0pqWWpXaFZPcFRH?=
 =?utf-8?B?ZUgvcjNMaGtQMWFONlAvN3hiZndCMm5sandjWURBemdyNzJUY3pNSFpxbll4?=
 =?utf-8?Q?hfqozSJZoK6eNQstDRzBh+mDU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Skcm+ajxu4NjoR9dGVv4VHLdrfxwmvttVrURvtZELCVbkaBUkaxk+UZQtSOx7hwmEtbU1NKBcTExt3ZvmHqKnrDvzpm3Z5j2323Wuz5uuPURS5F+7lezhELotuSCyC3iCHwuRlj68X6rV1EO/qcw0sgtNLhcvYbZdIh+lyCxWNUD77ZUV4M3v2dVoByiasVMhB4+usdANWpLn18RTMpgiVs6nxDEzBZZkDrEajUnUC5tyF2kocwBZszBVllco5J06YflQ3yR2wu2jJIsARnoOzNHBIA0FRz0V1h0O0kmJ+3M263UjtwEpaC9jVzq8hL79r4IPQl7q0j9cy4YinkP3ZwiIOlODShUy5SnRdYsIXj/ohbVU70+Xjb10Td8HUC2T38o9EByOu5mb+apSfMFLh4uMFTZeetBzMIfBdcQlg67IPGMZ/dn5V0JDwsUsuSwiQsqGn0IfeImxG8u7U+XGG6e+M2Jij+anPql5LN0ZFnqpicMBhj6NZmhcr0ZoD18dgCxqJG+15bJjZBAOfEPmCy3TpnWUmckgJ5jLotQZRld0asksioZJfXOBU7qcU/zi5AXv9zfrG0Xdl8g0wqVmstOMG4ako7Gfmo/oKwDPhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8204a4-87b5-4af6-87e3-08dcd639d1b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:25:00.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jekdoFdikWol4ldfbHUOxJAnFrw3hfx0Kuc2AR4S2Im1zOocvM8oL+WWKD38MRp6baQCQgvfggyDw6VRvuA8CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160065
X-Proofpoint-GUID: HLSrfTke85wihUalS33dFsVtVweRd-SM
X-Proofpoint-ORIG-GUID: HLSrfTke85wihUalS33dFsVtVweRd-SM

On 16/09/2024 08:03, Dave Chinner wrote:
> OTOH, we can't do this with atomic writes. Atomic writes require
> some mkfs help because they require explicit physical alignment of
> the filesystem to the underlying storage. 

If we are enabling atomic writes at mkfs time, then we can ensure agsize 
% extsize == 0. That provides the physical alignment guarantee. It also 
makes sense to ensure extsize is a power-of-2.

However, extsize is re-configurble per inode. So, for an inode enabled 
for atomic writes, we must still ensure agsize % new extsize == 0 (and 
also new extsize is a power-of-2)

> Hence we'll eventually end
> up with atomic writes needing to be enabled at mkfs time, but force
> align will be an upgradeable feature flag.

Could atomic writes also be an upgradeable feature? We just need to 
ensure that agsize % extsize == 0 for an inode enabled for atomic 
writes. Valid extsize values may be quite limited, though, depending on 
the value of agsize.

Thanks,
John


