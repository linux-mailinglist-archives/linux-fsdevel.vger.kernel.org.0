Return-Path: <linux-fsdevel+bounces-30443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F398B6ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3388CB20E0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73119AD5C;
	Tue,  1 Oct 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNmXc/A7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="btV2lvWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6781E4AF;
	Tue,  1 Oct 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771400; cv=fail; b=VzllFozNnMtAqPHoOA2y1p/Q3bGyELf66ihbFaZs/nIu3YQsSyFLjr5F3IajAJoduCr4dkt8CnyTw2Z33MByn9dQM2OlWTyUjTtxs3oRfOlzQIare1ei6yso+GO3/ynFBaDkd7FEgP8nifGIYmpFghgEP5u4wMbD5zq5RLyGq7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771400; c=relaxed/simple;
	bh=jrZuNl0j5MiVcu63j4Y7Dra0zkhfPT3mpG3pvUYg8BE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yr76qB6mGGmcNwceNd81U7a1h3C5izoJ48QKb76q+xO9OgOb3damIXGgITiQqXl8qe7J4wy7C+VbAhF7tX81ofgZXdrROH1sTTggG2hxe/t19PeTEMLtklwYrIoJ0l6Q63nA6RoFn383bR9TUkma8NXoVPoc0IuczgFcV4W0g+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNmXc/A7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=btV2lvWq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911vQoB031515;
	Tue, 1 Oct 2024 08:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=s+mos2AisWx16cdFZIooPQN9BrcsNPiuJApPilhbyBs=; b=
	WNmXc/A7vbcuPGm4hHvjgIAc5UwuPqadakYuFmvxL0D6MepMYM/cVUYHjt8KbtHy
	8Uhuwch/b2i3Cno7oTiDNgBGe1qesZulMmP3NhPkh95k3j4BeD4yW4WDd0zyN2jc
	uN2zyn/V/+KVbd9cBRt+Cx7BObcOZ8NGhcaAxdc6RrUv6XbNgX4BoTscLIx//P4d
	2t0EAMG+ExxLe0g9ocBPXqu/6qlrHeNr/wdeByu5uwz74gruwk2Lz/kgzuc+pqqK
	3TmhKu/lQvg+5VPUZDri+xJN9z/GVFD8lBKjJ7X/gC4nCWcvsqmA5rG76WRnIJ2Q
	4zv8BYq3OkS3qQx42b1vHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k35pyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:29:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4917jBVP017254;
	Tue, 1 Oct 2024 08:29:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8876xvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqT48twqiW6x0pqO5KbQGFiopRzENh+k0om4QFKq5CjAux+lyZd246w/Aw2dXxz/NgvCaAx94ZLkqW592b449/ZwSb5SE7LtmLJYoj9TOsh8SC09uWJxxGv1RQ7BnsTm7yrL6ymnhBc462yfTT0guYhlF+vQuATOl3sP1zyfBdPDpVoWFu6ONQMIeG5AO5bQmsWJGX9SBWXEQVCjv7yuhMgpzyEjMvT6iYrO163SjfRTeXXhSJ350Y53iAm3TQmpyjUF+tITzuS7OHfbWeu6Eb8XubUWf1qUs4Vpo986+mqgUOEllJSpvSxnjavTPC989SytpzlxS5hH/YOdIQnLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+mos2AisWx16cdFZIooPQN9BrcsNPiuJApPilhbyBs=;
 b=avxhAK8OVvF2ngXEt/GZ1tKjHJ7La3kZdlw0C7fXwKqM1XL44RVJ119XslFfuwJEF5LB0q1jQ10PE7bb9LzSj3SiMmvZk19rZIyWSujQlFfhX8Lq8gRSMjhFs3HVBRhCvzgXtzQ2ImsqqqXqZdPK3E70UjXHg8hoiwhe2zUlh4H4FF73UBViT1S+m+SjprQTQ/TRG658IAmxJxaGRT2vOi11Ufxs7Uz9eJJhzCh+MOweJtJBZX4kPtTQwBoYhed5gO0gf6wgb0kk4u0fZ6aPPEngilMuAZWhtEKfbyzUPYK14XTvNf9YFigl/ivddyFXpZARh955aK2wA8pOqvq9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+mos2AisWx16cdFZIooPQN9BrcsNPiuJApPilhbyBs=;
 b=btV2lvWqaDv7BSWmPmiLlewCj3L3uy58o3+Ruu9nPkwM2Fyglen5/vqvE8JHAV1ZkAIASyfBvlWqqESc7A7X/4+mdB/RUmF6oP1osjjvulHh3V0QS4S9o53yofp1rs7mf9AYchxS6EG0/CZA59VYQzb5HpeZxm8e9aJvhZfmKyI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:29:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 08:29:39 +0000
Message-ID: <753babd8-de34-422f-9958-a2a06b503ca6@oracle.com>
Date: Tue, 1 Oct 2024 09:29:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] xfs: Support atomic write for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-6-john.g.garry@oracle.com>
 <20240930163716.GO21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240930163716.GO21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f5a85-3f25-41d5-4fbc-08dce1f330db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3Q0Y3IvOVJrUXQ4L0NWKzVWbHBNQlFSUk1Ld0NPR0tWeGFDc0hWYmNNZkNX?=
 =?utf-8?B?STJubEtNZGtUZFhTcG9lS05DdEM3Qm9Jd2txS0ExZHIzVXhXK2dyZUdxQ3lY?=
 =?utf-8?B?djVhQW83UzI5THc2OWM2TThHRWtiTGQrOU44K1lRTHVQQ3REWnJTS29sSlI4?=
 =?utf-8?B?OEYyN1pRUitacCtmMmJZNDAvaW1zanJRNW5yMHBLbSsxMVJmaU14bjhMZ3Zt?=
 =?utf-8?B?SWxjUTc2SVhjQVlNa2RZSys2K1ZDZWpoTXc5aEp3V1BMZlFCUDJJNjh1MGFW?=
 =?utf-8?B?WXpMYXg2OXBkcWkvTGR2bFlvTjdyOUM2OEVOcENFVmluOGF5MEJ1ZmUrLy8y?=
 =?utf-8?B?RUN6b3Jld2RnRk0zWURxVXkyOHlCbVlNcFJqQXlBdUhPMll0SjNnU1lxL09S?=
 =?utf-8?B?TVVMK1BQdiszRmxJMCtpaTZ6b3NqNHJjTU5BbTBIaVc0UWpKWVhxejlRV1Rs?=
 =?utf-8?B?d1QybzZ5N1MyZUtwZndNTEVCTldtOVNLZWRjNWwyWGFucGNGV2Z2b2x5YU9y?=
 =?utf-8?B?eklQcGNaVktGc3pqY2VoM1d0Slcvb3lKMjd0OXhQcC9OSk1lT3RZODUzeTdM?=
 =?utf-8?B?QTJEdzFEa2Q1RDdYQk95V2c5cmVhbUFGWlBBaExHSlcyOUIwN3NSWkQ0OU55?=
 =?utf-8?B?Ym8yT1NKRnVzZ28za2tiVUUyV3dvK002TWpIaFdyZGE0bTAxcGtZV0IwTkdW?=
 =?utf-8?B?dG9KNktWWUI2cmN2TmRTbE5HM1BZQ1hsOUdmM2dVdlN3Q1FWbE5QWnorZG9i?=
 =?utf-8?B?bjNYdzJzdnBVYXg0dWtYdVVVSDNxVWRhN1dBUklkOVRhdFk0WnJTUmdLZXVx?=
 =?utf-8?B?eTZKRGR3ZXMrSzNKdEN6QzE2cFZaL3JoSFRzaG9iZi96TU1KcDNvQ1h3bDRw?=
 =?utf-8?B?aE44KzdpNCtZNHQ5cFFxNnhObzI4Yi9UcDZuSHQ3OUFscE9ueUFmdGdHT01C?=
 =?utf-8?B?TUg1UFNwNFB5UDJHb0g0UXdEM2Z6N3BjRUU1bFZoK0t5SEx3U3pzbURLd1Bj?=
 =?utf-8?B?d2grcWttMGxtSlhmSWMzQzNMWmd4ZXNTcFhydzZrUXJHYnVRVkMycDQxU1NV?=
 =?utf-8?B?QW9JUUZraVVVeWdScHBpNmZCck5tbzF4ZWVkR0orbWRNQ0Y5NmowZ0MySWtX?=
 =?utf-8?B?YjR5M3hoRHZWdkszZndQbFR5RFM1amR2bjBTU0E4ZXJVMlVxM1lpMWwvVklX?=
 =?utf-8?B?RWtyVlhLZzQyclNudFZIcmI5L2l2eGJiaFNUQ052RUd2NjlWdkIvSk5heDE0?=
 =?utf-8?B?QWxPeVdneXA0dFlKZDFtYy9QQi84eUNCWWhPRTY2Mks1QVN0THUxRGcxS3M5?=
 =?utf-8?B?QU9hNm1QT05iYmlWR2lPb0RlNkI0OUxjL1phQ2ZZRTFsY1VUWHN2QzVxaFBO?=
 =?utf-8?B?a1FRTnhaSkNwSDdMQzBtc1R5bDZHV3BWNVl6NlAxbFgxUVJEaEtibzVmZmdh?=
 =?utf-8?B?aWc1U0NPQTJVdGw1bWxSdUFoNDJ3QUJWeTYzRHEyZnF2TkV6bU9iQ0VzNU8y?=
 =?utf-8?B?Q085ZFArWVdWQWxHTFplUWw2aUl5ZnpySVJwTEI3aS90ckQxWjZlUUZwckdy?=
 =?utf-8?B?RWJlL09qTVo4aGt2eFZkSjUzVUVLQ3VGbFA3bzU3TW9qWEF2MXlhbUFWaTFn?=
 =?utf-8?B?TEVNcS9INVNydW5rejNQWE9WWnFHa2k0amlKelVrUXF0bVRORnk2TlFlajNM?=
 =?utf-8?B?MTZrV0F6cGNxZGtQcllXRCt4UHoyYzgyNHI2ZUhKVmpFckV2NWJKcTFQdTYw?=
 =?utf-8?B?OHlJTnhvZVFiTDRVVmNmajVzR1VuUTFZUFU1c0lsODVzYktqZXZzTUc3V0J0?=
 =?utf-8?B?QUkyZTdHU3UwWXA0MDhoZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlJjMDVZWEYyR3RiZHA3ekVoOGFCTTB3ZlRVbkRpNG5TKzluV1BwYWpyNVdq?=
 =?utf-8?B?UXJkajA3N3ZwNkFNUGZWWkNVdnlnUHBLcElKT1g3cWUyc0xuZ01EbFVsb3M4?=
 =?utf-8?B?V3BQK3F3ZnJWdGcxZWcrWXo2R3oxVzRtK3RDa04rQXFrb3l5WnI4SjFzZ1FR?=
 =?utf-8?B?ZHJJK0U3OUhrSDBEYzRrV1FmLzU4QkVMZzVwMUl6ZjdkVkdUL1pHYk5UNnBh?=
 =?utf-8?B?UVhBTlFVQkJEdmxWWlhWN1hCcEs0V2J2UjA2SXRqMGM3Z0dWaWVkNXZCK3ZH?=
 =?utf-8?B?YXhaR214cXl4UFAwTm9iMkhPczRQUEN3MkUvS2tqM2VQU2haYTdBcU53RzA3?=
 =?utf-8?B?MEQwY1RSTjJMN3J0ak1qc1FLZkFUM3R4My9jMWdoczBtdkhuaGlEeUNpS0lM?=
 =?utf-8?B?UW85c1lBK3RwNWV4TWtBeDhWNzJoMUQyRGRpbmNqUGxJWS9VLzI0K09hZ3NF?=
 =?utf-8?B?WUtxTW0zWXJLNEw2VWVUVHJhZ05xWnlVdWxCYTdzVDFOWVVlOUtycVpHSFR6?=
 =?utf-8?B?RUJ4U1NjMkV3R2hvVGhSeWNweUtMenZJQ0kvTUxDbFJwM09mZHlqV3RKMEo2?=
 =?utf-8?B?aEx0MkFDMG42QXIyRFo1eVRpOEUzOEx6Vy93RUZndXhwK2twKzhqZVhUbm83?=
 =?utf-8?B?MHFMV0ovL2xPQ1F3UFJEWUFSUzdPYVpVRUtWSTdmM3lKb0pnamNXUklNOTdJ?=
 =?utf-8?B?QWs0aVU3OEI1MllGZlZMT054N284UW5XSGw3c1FrNlBXSnRjN1k4S3l2T01v?=
 =?utf-8?B?NVN2a0Z0enB6TkNqbVJZNFJZSUpEUFRlUWRMRVpNSzJ0b0Y0VmQ3eU9oVjdW?=
 =?utf-8?B?NDVodkt1Mi9LMkx2T2hZelRZdHVaNG53NENNUmtFUWJDcmE2MnlUY0RjSUZo?=
 =?utf-8?B?RkJJemJYekZ0UVc2SmR1UDI4YnNVRXhDa0c2YVg3VkVqdE9kM3pHb253anFB?=
 =?utf-8?B?OVEreHlncnJjQ0dZbENnRU5RTWlGY1UyK2ZpWFNKNzJ4Ykp5eGNzWFFHZzQz?=
 =?utf-8?B?NVUwQU5tbXEvSHR3d0twUXhTM1MyVmFTamJBSm8yNzV2d0xsMEJtcTVzWHhp?=
 =?utf-8?B?cmo0UGg4NzA5bkpYUVFQUG1ja3VaSHBnSnNSa2RQVUc4b0FKTVZ1b3FCVm10?=
 =?utf-8?B?TWJYSlIrVDRvZ2hhMHBVN2ExSXUvWldKS2NJbktnbHV0YkNVVUs0ZE8zSXpI?=
 =?utf-8?B?ZXRBc2lmTlQyZ2tkcVMrSkNKR2o3cUUrUUF2Z2NMUGNaR0FSV0lXR3RYbTI4?=
 =?utf-8?B?WGRKQzR6N2wrMlpMakkvWWZkQ0tyeFBhSnJ5dExKR3ZPUjZuUWNMZ2tsQWhZ?=
 =?utf-8?B?ZUU2dXhXakw5RkUzdHdkZnNTNGRhMW1tQlRPcDhGb0JiR1R4N3ZiNHAwTzRP?=
 =?utf-8?B?aHZ6OXg1ODI4d0pUV0VJNXVGZGxpTnRMTXJzTitXaE9qM0pHTnlMVk9LUzlu?=
 =?utf-8?B?VStoWDVJNVJNS2FQYkc0WGkweXJTdU9TZTBnUHVlYVl6MUdsYzFDa0JSMXNR?=
 =?utf-8?B?V3JzVSs5WE1nNXJwSitoRDVaZEdjOTM3TG81R1lzTHNNbFNDR2NudlBpVUpY?=
 =?utf-8?B?d0xGMDJiVmx3a2MxYVJQNGNyZDVKalU2T2lUeDBSRVozZHoxUE9kRkplek1K?=
 =?utf-8?B?MTgrcGhvTXV2VjZzQlQrcDZvZTg1cjRTVUwxZ3hLUFlod0dDbnpTdjYyZm5p?=
 =?utf-8?B?Z25aL0E4WkhDaVV4S0luRjNBZmNFd3p2L3JTYU5tRFF4VWd1dG1HTHNlUGUx?=
 =?utf-8?B?dE5nTjNjYlVOdUZ0RlJWRVQxL1NQdS9rbmZ5dFhZVHVsMzFHcGVWMWVvNDBP?=
 =?utf-8?B?S2pWNVB2U2l6WmpuZjNiQS8xM24zRndXeGd1RTZhSE13Q0s3SGJ3KzBvNGFH?=
 =?utf-8?B?WWVaZjRyZlUwa0tyMktXZGRZWFdRVmU2UUphZ1VwTVozRG5zRjQ0WUpadkVs?=
 =?utf-8?B?dE9LSFRxcFhxWGVyZnhmdmNhcUJxMUZuQmxBWWN1dzJ3SDZuVmI2cnpCUUNh?=
 =?utf-8?B?STBXdkdRREVXUmJhSVE5ZmdaUEFyd3VxTkl4SDl4T3I1Z1h0ZkI1a3kxaXFP?=
 =?utf-8?B?dUJqSDVrSi9rNCtCMWpVWWpscjdKY3BQVUM2bUNZekdnM0VhbTNWcWpnOERu?=
 =?utf-8?B?akxRMHdxNUIwUjd4SmFYU1BtVzV6VGxzZ0RDL0thaWxWdzJ6cXNGRWEvTzJ6?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wkBzEJvji3Pt6alQ8r/Eu22/ojjOPfLEeWj9Jm+rO8UM41UFjO/lwvMgsoozfguCMpODgPCfzEeWIRhjJ9BgY7VMUIP+0b5Crn3KT58/6g8E/4vg1+RcH6W7dY6iqnxzjkBdNw4KE4suGWbUkcTzEje1QFzHrvI/keho0j1PWZkwvYM/oFEmwurkDOsDqXBl20cPlsrjP8Hc486wEYfbHLiY4Fms7hsPU/DRoFjFlyekjJUsRyjyzTA4GeIc862r4GKpqvU8L850acOytOwkeEHAYr84vlXl4RnRNWrl5darFgzwqc7vL+978U7gWCcVeJmTmvOZHHVt9Rs6TsfM2Y+cXUDEGO08CAAbBUzOUW9lebYyW0Ke8ApdoLs6khWIdE5DU/2bx3m1QyvIeRlk5v1w2jyO+jPVBO2V1IceBbmjAaAolVl5VJHlkv3xSkYrKpE3OX0EXhV4oiPgB/UV6b2KcxFQP8/uEAwqdkaJvmbniE8bmQwfabX8ns4KQBVgk7GpcEP6J/WKsdX0WNaeaYoYBwnhcHet1NqX88kpCwhdSbpoA2CkW2AXoBKEQbybGi6XFnSVaxluRXyl2ARV4xUVCwPN027kDVj5In6MKZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f5a85-3f25-41d5-4fbc-08dce1f330db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:29:39.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkJVEhxjG/sTHlxjJ0ek2n3wqU7hZsELRiIGOWdLPn8cVwtMNhE058U8tqmmcUMMK7NRIRjHqV2pnqQp00b+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_05,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010055
X-Proofpoint-GUID: XSuVEqrVD7a2DUBw4AQbRZDZYApySeFU
X-Proofpoint-ORIG-GUID: XSuVEqrVD7a2DUBw4AQbRZDZYApySeFU

On 30/09/2024 17:37, Darrick J. Wong wrote:
> On Mon, Sep 30, 2024 at 12:54:36PM +0000, John Garry wrote:
>> Support providing info on atomic write unit min and max for an inode.
>>
>> For simplicity, currently we limit the min at the FS block size. As for
>> max, we limit also at FS block size, as there is no current method to
>> guarantee extent alignment or granularity for regular files.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_inode.h | 17 +++++++++++++++++
>>   fs/xfs/xfs_iops.c  | 24 ++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 1c62ee294a5a..1ea73402d592 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -332,6 +332,23 @@ static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
>>   	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
>>   }
>>   
>> +static inline bool
>> +xfs_inode_can_atomicwrite(
>> +	struct xfs_inode	*ip)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +
>> +	if (!xfs_inode_has_atomicwrites(ip))
>> +		return false;
>> +	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
>> +		return false;
>> +	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   /*
>>    * In-core inode flags.
>>    */
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index ee79cf161312..915d057db9bb 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -570,6 +570,23 @@ xfs_stat_blksize(
>>   	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
>>   }
>>   
>> +static void
>> +xfs_get_atomic_write_attr(
>> +	struct xfs_inode	*ip,
>> +	unsigned int		*unit_min,
>> +	unsigned int		*unit_max)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_sb		*sbp = &mp->m_sb;
>> +
>> +	if (!xfs_inode_can_atomicwrite(ip)) {
>> +		*unit_min = *unit_max = 0;
>> +		return;
>> +	}
>> +
>> +	*unit_min = *unit_max = sbp->sb_blocksize;
> 
> Ok, so we're only supporting untorn writes if they're exactly the fs
> blocksize, and 1 fsblock is between awu_min/max.  That simplifies a lot
> of things. :)
> 
> Not supporting sub-fsblock atomic writes means that we'll never hit the
> directio COW fallback code, which uses the pagecache.

My original idea (with forcealign) was to support 1FSB and larger.

I suppose that with a larger FS block size we might want to support 
sub-fsblock atomic writes. However, for the moment, I don't see a need 
to support this.

> 
> Not supporting multi-fsblock atomic writes means that you don't have to
> figure out how to ensure that we always do cow on forcealign
> granularity.  Though as I pointed out elsewhere in this thread, that's a
> forcealign problem.

Sure

> 
> Yay! ;)
> 
>> +}
>> +
>>   STATIC int
>>   xfs_vn_getattr(
>>   	struct mnt_idmap	*idmap,
>> @@ -643,6 +660,13 @@ xfs_vn_getattr(
>>   			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>>   			stat->dio_offset_align = bdev_logical_block_size(bdev);
>>   		}
>> +		if (request_mask & STATX_WRITE_ATOMIC) {
>> +			unsigned int unit_min, unit_max;
>> +
>> +			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
>> +			generic_fill_statx_atomic_writes(stat,
>> +				unit_min, unit_max);
> 
> Consistent indenting and wrapping, please:

ok

> 
> 			xfs_get_atomic_write_attr(ip, &unit_min,
> 					&unit_max);
> 			generic_fill_statx_atomic_writes(stat,
> 					unit_min, unit_max);
> 
> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

ok, thanks!

