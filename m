Return-Path: <linux-fsdevel+bounces-39656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E20A16838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E841888E02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABD194C8B;
	Mon, 20 Jan 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AKMx46lJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOgmsu71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25A192D98;
	Mon, 20 Jan 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361812; cv=fail; b=WYkugUOxvDQCAAKQLS/EHOOOWSnu+OdybNk3U74BtyCpY0JmP8Ks9M200/4mlyWzSglFtF4NLTszpkxvVK7UO5qDPvdhCI+XSjL55fKPgMzujmpaC4sGpypOHZCkKMVaK3JaKjl8nNpG4sG/wdlgK/esmwaWpVnRtdEUQJj85Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361812; c=relaxed/simple;
	bh=DDTzxlQ1+tmL4HVfrSX3oV6Auf3V6e5N17DrRutomuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7VyW2oXn4S0JKBVwJQMcwecIZ9WjVeoBCCIU/uSfmiVR2JpZSkVjLI10qT5lHqS6bz/WIfCatOfTpjgTiygb1hwETgTZTrRelkM0v4l/yMH24iNnRCZm8EYHx4JpRN+TENEepQ/aKS2VyMOqOv8CiMEm8k9KQz5zXGzwWVkaDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AKMx46lJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOgmsu71; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7fxHo014291;
	Mon, 20 Jan 2025 08:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QTk1JjNE28Fh0gokTw2dTOfpSgwoPiwYOeR+a2ozmG0=; b=
	AKMx46lJT/BLbtzrrS5bFX9XJDbUQFy41PERrw36CkP3BwgI+lPxyW869DTVbePe
	9T1F/JBoN9IBjeFGcf3zS2k9D8Daig5WAFo9GIE0wnyMNNjALn8i8CMl+IVlPYao
	g+Dgps37dycT7tRIpjsyszim7pfR+6FuwlxS1bi9TFUB5HnOGON+9YUbhVkRa5J5
	C73GlB6EgY12T4sPp+sblcwiM4K4l9HdM310MdcysBo7YR04W/JwlvDu5ZgGv0rr
	lO8dvqpCbzIGMBKmAqIBTCsPLOP7qEtUkSdwTR9mVHXdxvrIq21kWW4rrpOsSWRy
	Qm1U6kxaO/7f2UsdAQyOlw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rdb6rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 08:30:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7GQbc038119;
	Mon, 20 Jan 2025 08:29:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44919xkpyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 08:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akVy1CSjDB2vmHvFuf21yNJPBL05N9CezRekjgKORnCPrwa1Wqkt3ue1iOnKWGcMYATBQlk16/DlzrdN2dpIwbOerNLIVVqI9rNNH04pqy0tOUFP7768JG8JuFuMJodEkefzJ1slKYOwT3KWuQlzYo8iymBmHx2jztPB3rt0vHwr6rUNuPIbaT6LG+7ZQ9Q/CF6121rskFdAxQBVda8HoLKrPTmMp9B1Zv4ZaYcf/npIbTeTyhOXu6QY1xyP0jatdGceis6EGWsGXrvVGekZ+AGJWtWqWe5AfTnpDldwhCXdCfFLnvcFrdfpY17RjQVlgi0MVRKOZLwEy+t4eaYseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTk1JjNE28Fh0gokTw2dTOfpSgwoPiwYOeR+a2ozmG0=;
 b=tlmUtTOLc1kdOMAdRD1wX6QuG7bVnVZ+pW6JFoGje5LJvkKY61HUlKQ/Dm6ETcTPDgmcJ77Q32IMEfaXt4KNjD9bQAqSg8Swfwgb4R2M9+wQNPqZTJLdYtwGN7zUINZRCE0IKObzbnDlgvcSRJmVbqlrWkwlsybAcRQAXV5aOwa4TpYR4XXvCTRJ0BfeNIkx2W4UNV9mFCA4cWY/wkUIyFPxvcMpK8MERAGigjq4OQC7/3HNCPb6yKikSqUy+823XwK8KgsDHljy32KGn/7WX9NryimsAb0tHhdvWaxIAO84ULnnWIumR2vlq4T67pH1QqQM5BPlTFwRJnn1GRncPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTk1JjNE28Fh0gokTw2dTOfpSgwoPiwYOeR+a2ozmG0=;
 b=tOgmsu71FD5Z4wUR1G/cSZjqUWN0shOyOroUXb8P4KxyycM+JD8u3rCWGDRjDSPHYB6gTZe9EhWOWel3mMkDpsF5acCte3f2UUyiolMUaE0hXRcWWE4i2Ku0uuZSlIF1/goh5E30EN2maFUbO4S05jNs38kEyCLjdMsMATH07z4=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS0PR10MB7405.namprd10.prod.outlook.com (2603:10b6:8:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 08:29:57 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 08:29:56 +0000
Message-ID: <cc3824af-0eb7-4bfc-ad81-3c5cebd1c5c3@oracle.com>
Date: Mon, 20 Jan 2025 08:29:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, cem@kernel.org,
        dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
 <01e781da-0798-4de6-ad03-6099f15f308e@oracle.com>
 <20250117182945.GH1611770@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250117182945.GH1611770@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS0PR10MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd0cc1d-2319-48ea-7e2d-08dd392c9f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1pBVUNPT09OOWxZMTlWMHhjTzFSK3IrMXBTK2tOcGNhbEtvS3ZMVm5oTUVU?=
 =?utf-8?B?ZEN5dVlLaHd4dWh2VGZOdVA4NG5POG1TSnNqSE0rWlB0U0ptOFZWYVVpQit3?=
 =?utf-8?B?SE94ZE5wNlgyVVNtcjVoc054dm9qUitxbzY3THhNb3FMMFNRZjcrWHJ5R3hN?=
 =?utf-8?B?bVBXWjNuWnJya21HL3ZHNlNENUR2THRQbmNWMk1XSTB4bE1yZmY4VHo2NFBB?=
 =?utf-8?B?ZWVnMTdSZTJqeXhvU2lZOUtIcEFlbmx3cmRCdy9Hb0JzVjBFblJoaEJtUkly?=
 =?utf-8?B?OC95Tkg3bkg5Rit1M3NnTzNkNTFNV1NHNWRiVzVldWtGb25LZUQzeDVFYUhP?=
 =?utf-8?B?ZkNoZVIwZDZLOWtZT1Fqa0wwTjFLbVorcUNGMHR5bDdBTHlCYU9uS1FwcFE3?=
 =?utf-8?B?QmRoN0xYcDRPdTJYMWVoSFNwNS9BanpSS1MwUUJDRGZZNnJpaEt4M3d3L0k5?=
 =?utf-8?B?YjNIWGJSMlhacU9CZmUraTVGQXlpOWFIMUNBYjlIb2NKQkNXWllzOHBUWGsv?=
 =?utf-8?B?SUhKTXJTRS84ZXk5ZkovMGhRb0YyUUZ1Q2RsUUhmcVVCQ3YwUDBkQ1Q4Ym1w?=
 =?utf-8?B?V3R3c08wMDNRWjhiWjlaK2hQY3VnMHR5QmZ5a2RyVlk0OWN4WHBoaTNwYXE0?=
 =?utf-8?B?cnd5YnFYYXdRY3NTb0xueGU3N3JDaEJpL3ZiUXk1b1VScEpORVJ2d2pxV2lq?=
 =?utf-8?B?RG1CWDRLSFJYaWhpUXdCMUNVSTJldGdmSDE2cTVMWnlGeEh3Q0xBc1VUekN5?=
 =?utf-8?B?VXltdkpmd0cwM2cwazhOL2xZMUVza1RSSTRVelh1OVdUcW1hTi9sejhKMVk5?=
 =?utf-8?B?aVI5enlHd1h0Qm51ckpPYnJlTlZXWWFkVllnWGxXT3hPSiszVjZndC8xU0gx?=
 =?utf-8?B?UEl1N293TmJUNnpIcm9NZGlEUFlUWVZqLzhGU1BEUllWL3ZyZ0lCam9vQXox?=
 =?utf-8?B?UWRkQWdBNGk3QnlNR0x3c2FYQ1A1ZWU4bTl0LzRkZE5Xbk9FNGtadWVWQ2Rt?=
 =?utf-8?B?QXFLMGE0ai9nb2dKU3NhQmJHWUhJOXhmZTF1ejhBaWFQK3puakJrNWR5cUQ5?=
 =?utf-8?B?T213cFBxVzlKK1BjdWYzL1lYOHZ2UUtEd1JiM0RtblhkWGJjSk4wdTJTNWhP?=
 =?utf-8?B?WHhCeU5GMitNeHhFRU4rNi9GVS8yK1pTREJUWTJvdy9FN0hDOEtOTk5TU09T?=
 =?utf-8?B?cHFEOFZuNlIzQUZGM3hhUERCU3BuM050ejl1S3VUUUEyUjRzYnZCQmtvYitZ?=
 =?utf-8?B?Zi9UMFZxS3RWWkVVYlRTSjdWN21IYnM0cUlyWTEvZTVBVFdaSUhNdFJRL0FH?=
 =?utf-8?B?ZDdoeGV2SmhtcEVOQ3cxVmtBdUJxa0NzWWZLNlpBTkZhM3Zzci9XUWUrT2dP?=
 =?utf-8?B?UzhTS1hvZjRDMWFxa0JBV05mNTloMDQxOEpka0EzNFNTdHQwc1Y5VGZxaWNT?=
 =?utf-8?B?d3hVa0V0TFJ0MWdhbFVBQlRjdW1hTzlCTWFidkRMeVRSNm8razBzejJwZHRG?=
 =?utf-8?B?Y04wdHNDR2tvbjlzcU0yb0pKYXNWMkxVTFV0ZERRTUtuWjVVVEpzU05qWEd5?=
 =?utf-8?B?QTZuNEV3bnovTUlTczlKRW5FbzRpaXNwb3NyYVp0KytDZVhGSlJkdzFuN2hO?=
 =?utf-8?B?ajRhUnZGMVF6M2cxTXRzRVpMeEtFZmkxTEcwL1QzZDlqdkplQzFlbmRZWU1I?=
 =?utf-8?B?dWN0UURUcVh4RmI2a0pCSUdYcmFHTnlYejRqUUpPeE44aDZKMEs0Y3IyY3pN?=
 =?utf-8?B?MmtBYU8rUHV3WmlyWkVwa3RXUFlEY0pQb2J2VDVqQUxmRmNoM0gxNGhVWkFs?=
 =?utf-8?B?amg1eWNMNGc5Rm44UzZzRXBJUkRZR001OTU0aktpNU1jUFkxUWYzQ1k0Mk9a?=
 =?utf-8?Q?hQdV3MJxJQPQH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9SSlcydEo4a25IR1V2VTRWUjBzeFJla1B5SXBYNUt6R25HS0VPYTV5RUFw?=
 =?utf-8?B?RFJHNVArSm52MDhETk0rbEhLMmxSdEQzaklvR3l1N3NDZUtiVEVvZDhDL25N?=
 =?utf-8?B?ZG1KNFc2UHQ2VjFSdGlFZWRRWEZhLzFldUNJVUpYd2FXMGNzMThMcVE3OVZH?=
 =?utf-8?B?YUEvYmVhaFFWUUNuTE43ZnZ2V0pYMHFKZGRudDVGZS80WlBxUWN4SWRrdTdh?=
 =?utf-8?B?eEFmUDZ0ckRJeGxJTnkxanVpWk8vTUNUVkRrRGtISXBzR0lLQ3VHcUxIRVg5?=
 =?utf-8?B?V3pDS0ZBT1piTGxlMFJwU2RQRjNFQVlwU1pMcENMVlNMd1NhTVpsUTZsQlFF?=
 =?utf-8?B?ckRLQzJCOHNDRXN5ZFY5QldMSTdLa00rZlIyeGF5ajNFdzFQSmxtK3IzaHB3?=
 =?utf-8?B?Uzg5cytpanA0SXhmUzI4OGJwTlBtMThFZVg5cnNHR2I2d2xIV1pEN1ptb0N4?=
 =?utf-8?B?a1VKRVVDdFY5MkUxSTNCSDA2T2o4TVRXK3MvQjZyM0s4Um1yazZydEMyZlVD?=
 =?utf-8?B?dHNiWm00Qzc3M2JmM1l0c0pKUGsveitwcDlncVQ5OC83L0k0STRxTkpkVlRL?=
 =?utf-8?B?dk9WWVhleElPdnhCZ1RIUStrVlR0dWM2SFd5K1p5QUtoWmhna0wrL1Z1OWp1?=
 =?utf-8?B?eXRuWnlLTXVQR2hVbXVkaFFuZ2U2TW03SHhwN2NMOHRVVFlLeGZTUlRZWnZw?=
 =?utf-8?B?cGFJKzJCOWthNHNLbXBWc29Ba0ExSmRmWUdWZndLZkRZNGlDMzh6RVFIbTVI?=
 =?utf-8?B?K3pXeFNZbmpvYkNiekhodGY4M3FFTDVkSitZQURWS1cwTzYxb0RGTXBFdlVT?=
 =?utf-8?B?cHFDb2d1OER2eUIwZzdRTlVUT3IvNXUvb3BUM3czMlE0UmVDcU9hT1psR2JB?=
 =?utf-8?B?RWFCeG9JbTBXS3ozQmhsT2RMY0czbE1KMzdRanBkamRJdFIxMDRRaDhaWWYw?=
 =?utf-8?B?Y1RNRWd3c0ZaT0IwTjUyeFd3Vk9FQWJRN2pab1llbGxmQjE2N2l3bXlleWF6?=
 =?utf-8?B?YVA2VTBnaWtkZ1JOWHlwbjRIM0UxNW9kV3VmOHcwdEtpczNrbE5oZVNseTVZ?=
 =?utf-8?B?UTZwendFc0IybXJtMXZmRGs1cXFtSkg5VitWZm1naVBBc0VGd2M0RWJUWk1S?=
 =?utf-8?B?cXlkMjhtSHhXU3B4K0U0ckRqem9ybjQ0S2gwdVo4U3R1eHRaUDRKaWZoRXEw?=
 =?utf-8?B?UlRXTm8zZW8xRjFJcVMvMkdIcUQ2QzdvZlBTdnNod2pKZU1OMThHb2lHWUVN?=
 =?utf-8?B?TEZUcVJZSzhyeWp3Zm9tU0d5Q3lsY1Fod2N0UlQ2OFFKRUVrY2R1NGx1ZzJI?=
 =?utf-8?B?c1FxZDg0R1Nidk1TL0hJM21UL1l3SnU1Y3o4V2JCdG5ncnFLZG5kTE5sMkNL?=
 =?utf-8?B?K0g4RkNyK2RsMlFza0JzR0ZEbjFROGkzYm12OGxZYTJtT1o3YTUvNk5XNGhX?=
 =?utf-8?B?b1poSzZFR2w3b05ZUmZyYlNna2FmOHZvVno2dldxQ2xhUjZrOVBScWZkUkl0?=
 =?utf-8?B?TGZocnA1bzh5MFdIcHIzOVZKSHZEb29VL1RYME40MkhRQXpDQ3lodDBLTU9j?=
 =?utf-8?B?ci9OazV6MHdDdDFPVkJtZzFmZWorVWZpVG50eW9MMVdzcTluVWZJY1JiQjF5?=
 =?utf-8?B?amdDL2IyZ2o2a01mZHBrdm9BVUlqbUtTVVEwYVV5c0N0NG44czRBVE02TTBW?=
 =?utf-8?B?cjhmdjMvQldMcVhRcXBEQ05Rb2pGYjJXZE9reHhHNUNNY3JHazlrSytRTkJr?=
 =?utf-8?B?OVRJbmwwRVNRSXd2bkpheWpIcE8weW1zem9qTSt2Ykx2UjF1QjZqd2xaTW0v?=
 =?utf-8?B?ZXh5bjF5WW5OeCt5RmJZMjRESlIzWXc2ajNZVjB4N3Nod1piTzdUcmI2VE5S?=
 =?utf-8?B?SGtjb29vQWhuQlB0Z04rejk4cTE4MHN3bDNBSmc1V2NycnNvY09tcUVNRlNZ?=
 =?utf-8?B?dFowV1hzcjlvSDRNd1lsaDgrWnFSQTNQU1MveUZSNjlmc3ZvWGQxdUlNNE9C?=
 =?utf-8?B?TTExMWh0WGZFN0NKdmJxaE5BSzRHN3NOYkZrcSt4MnYyVTB3WVFoK0x0TU5v?=
 =?utf-8?B?c2s2NDZJNzI3T3dMdldSa1ZxeXhoTlVITko0anhDRWYyQmJhUkcrcUl3bkRK?=
 =?utf-8?B?Ym51WWp3KzNrZGxhcVJHazBtb1ZLVW1vbGVFd0xXeEY1NUdaQTBGNTJPdVln?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SDgoaJFofP+5gW1Jh0/9RzAzKLJOhvSsoYYNIJxYyFRhddE0/rY11HBOxhUM6ErwF/J4Yu57U/4ZkGiT5A5/pHUgd1dXm02Z4n9Zbj2eD0C3gKwfcXixxFdDD3M2j4raLfICPy4JgwypfKokdUXBcAs2RoryB+oidJKdNBM4FneSixCR6/+hfhSKqP+K+pxoV1EZ3Ha//jgeaUintXBhdUQO1CZM4VwW52mvKq0MQxh8aoVLFRZlWu/qSjArwjfOGDvymrWnD5K9uprrOiUS8gJus7rFE9uU5sRQ82gLvPpvJbO4Gere2BiDMEB3Yp0GGHZzwD/ApqyUYmkFCc8bwsLY6hPBKGN9c33oTzKqHJf6a0LhzK3fYnVXgJ/ICSywsu1JybMfCdlrhr6O0T6ysuKRUp5u2gfgAjgM3Y4BGUCkazBJzT5++A9Ek/t8WyD+ulAjrNgm0zbUHZk0jbnhuj71U370e9gjlekEpbIZW9U/tRNMQ40OKJZgzU/a68IziZvWSkQ5ubaQ1C7aK5gjRq1GGugNRACGwOQSsCCXVZI1r/WlLeZl9xtnJ66oE1zUmn/Nll4h6TQ8Sx5g+okVO5k5V0G2qf2/91XuMwDbStk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd0cc1d-2319-48ea-7e2d-08dd392c9f09
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 08:29:56.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikFfshH2iz7X58I9j3yBn7I2OKOx4vAoNjPynMJyZHv+fGPbyW8LzrgLr7MrIQWUlEyyyxj4OE3ZT22T3d6c4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=770
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501200070
X-Proofpoint-ORIG-GUID: qgV4JXdikae7dy82rbbgb70PsLoxoet2
X-Proofpoint-GUID: qgV4JXdikae7dy82rbbgb70PsLoxoet2

On 17/01/2025 18:29, Darrick J. Wong wrote:
>>> Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
>>> write that's correctly aligned and targets a single mapping in the
>>> correct state, we can build the untorn bio and submit it.  For
>>> everything else, prealloc some post EOF blocks, write them there, and
>>> exchange-range them.
>> I have some doubt about this, but I may be misunderstanding the concept:
>>
>> So is there any guarantee that what we write into is aligned (after the
>> exchange-range routine)? If not, surely every subsequent write with
>> RWF_ATOMIC to that logical range will require this exchange-range routine
>> until we get something aligned (and correct granularity) - correct?
> Correct, you'd still need forcealign to make sure that the new
> allocations for exchange-range are aligned to awumin.

Sure, but I think that if we align sb_agblocks to the bdev atomic write 
limits at mkfs time and also set extszhint appropriately, then 
probability of desired alignment and granularity is appreciably higher.

Thanks,
John

