Return-Path: <linux-fsdevel+bounces-31825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0599BBEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 23:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3B6281E74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3491547CD;
	Sun, 13 Oct 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7CW/IDc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WeNkJqQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56164136345;
	Sun, 13 Oct 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853588; cv=fail; b=l4sSdjqvhHmr+QjSBoE6uIX2d0VfcH7rspI16+HK3Winr/k2+H42E3rLq8QNA5Dk4iZZeZvTPWif96CPIv6bPg8bi9mJX+vFAtZHpuVUGLdqk+Ez3xFKrLKMla6AIIQyUglBLEj+D1zaTCnnumMl+JgOQmhYrmGzpHcnFnAsN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853588; c=relaxed/simple;
	bh=rlis5QRqgVfsBklQ8bfvSjgTsoej+U+7JpjjaLPvsAo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVgxiEjWBe19MRUDgiW58DaeCgR8dbKNcelSEdTKiluE3ZjhCg1/KjCcFe8qULVC/UBckWoSK50b9fAJvszedL7CJlWQ3zx/5shyz3LUTGLfqD8K1ccmmb6HnSCsegTDndaWFrqaS8x52CzwcLcnq4fXDhGjMEePk3h52EiSw9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g7CW/IDc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WeNkJqQM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DKv3Jk005387;
	Sun, 13 Oct 2024 21:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/uuZdEcA7NOTw+DF6W+/Aw2HMtjwlv3yN0Xp2iR0/+M=; b=
	g7CW/IDcQl0X8ybCHcmI+dX9v+2KObADhwXMiPAXkRQVt3ZFBNlusX6LrDtCfgCK
	y6ANEMuYgZNT+hsyPTDtN1tow1uJGUyBZs+YPiaHnprWqwhMeElK4NZWBhE1eFC0
	n+feyst24XYrkNaGjLWeJkdd6gzTLShpGQf5l7FLPdyoexYREnT323XJRYJjQlvY
	STF6sPkQ/LUimGUPiyc1crBzEfqK711dnggFg0nU0oiDw1DJDzBzj0AF/dPy/1lZ
	ln8aOFlSn2/loDI+5K+tP6XQKiywIx04pbJdJKkfSMydQKRw/xwpdW1Nb4HzQrQL
	giCwhCamviVrleCk8CjdZg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cb7n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 21:06:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49DJgQsj011131;
	Sun, 13 Oct 2024 21:06:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbkyrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 21:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkP97/hn+nQ0oaR2nnVq1ORg5bMTM+VjbKw2y30v3++1kTTj9BRzlChCtnrrEB9lbdKB2D7YAUKc5ASn5tKmfRV8MOxVUr+kNS+C5oIXNA5aaIluHUEzRdMCHjHq1m6g190L5yQu8qdV847iiqhLY7BYwmyMSkPLTLZHqTIRWUlryxFRqWjtzAy5MT59ltoEPswGsYyU8A4qIp7IF5FWdRAFf2YPjR4UNpXKjPJ7P87TmEzpo+ho9of8LmWlS8cyVdsNj2PpMuRNy0ABNVhzRL87Sly8vYfQ5Of/29aNyGDq4ylyqe14BBBQce9RLRtioEjNQOXHTu8Ur0yCDE3Qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uuZdEcA7NOTw+DF6W+/Aw2HMtjwlv3yN0Xp2iR0/+M=;
 b=zWu6fyXWDMc3SsASeOIWMZJYdTZocQJ3KoHYuNUqbE6YVrOKdu1lhuBWHEkztPziGehycrrJ/CpKru20GOnrm3EpDNAWtyxl6VIuyPYLX2vfOmLwY3VT4TrhqW6Ndf4LjaFtvdAjSIC1k0BW/vIR9+1c+BERggSH6lMrGbxG+5iiH0ITCNEMapsJK+B76XCzDyvaIh2x8ynkmZ00kVe8F1ZPubQ8s68WhkSHQxDRI1FecMK9K4WzhSssMLXO1C1fMRPbAzYUOuDkXjHuxrZ9+wvG3z4iqNhcY2Dc/35EsGLrSCqopLDIbicXFwB1w1guYCp0/vVv/kD0hZt/FJJgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uuZdEcA7NOTw+DF6W+/Aw2HMtjwlv3yN0Xp2iR0/+M=;
 b=WeNkJqQMyGsuDHTGjL2wLA3wtYaoBbec8a6xs2pP53lkOeYS2lIZKVciYnxIMr1feOvM4FfIPhzi0oTJut3/c8SlC62l5RaUQ64DX+HsKgvs7YKYYrzJ20YosmBhh9niB+Eq38iW67CzsYoo0zEzN2NkN1+9hEAl78sv/+HkJIE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 21:06:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 21:06:08 +0000
Message-ID: <f0febabf-25ee-4fbe-9dfe-77a240cc29db@oracle.com>
Date: Sun, 13 Oct 2024 22:06:04 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
 <20241004092254.3759210-6-john.g.garry@oracle.com>
 <20241004123520.GB19295@lst.de>
 <f4d2180a-8baa-4636-a0a1-36e474fcd157@oracle.com>
 <20241007054229.GA307@lst.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20241007054229.GA307@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: fa11f751-fa4f-49b2-e603-08dcebcadb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJKUmhXclp1RFJVOXd1NkhRNHE4UVU5MHgzQWh5N01HNG1na3cxWGMvdU5G?=
 =?utf-8?B?RU5yT0NoV1BJK09vY2NkSFEzT1BVWHhkQlk4aFVGK2JsVEk3MGNQb1N0U1pZ?=
 =?utf-8?B?OEcxa3JMV2IxUURVTUZHc1orUWNMWUgvZC9sckE2a2dEOUF2OWcxQUpiaXRw?=
 =?utf-8?B?UTQ5a2VPU09TQUVZaEM0RVBUKysrWlZyZnJNc0xuWndNdFdwMzkzTGpmbVFu?=
 =?utf-8?B?aFN3OGV3REUvWENYSFBUaGdQYldjcXovZUFsbDUyVmltU1V4NllucUszalVm?=
 =?utf-8?B?OVVCMVpTQVlPdlZtSXc5ZW9aVFdxc1BSZTBNU0I4OFFFYi9jZ3pMSzZUaDc5?=
 =?utf-8?B?SmJJQUpqMlhMZlJMWWhJV0p6V21XWU0xbStDMTliU29hT0pwZGhZU0FyT2h1?=
 =?utf-8?B?QmpmdzBkSHNwVjdRWm1lYzYySnM1SUhOUjZGTE84YSt6UjVHUG1jUUdpeW5o?=
 =?utf-8?B?eXZvbkc4VFBmejhNWVVnVnVjZ2VnandPd243NEhyU2QvTFk5MjhyZXNXOVQv?=
 =?utf-8?B?Q2JvcEVMbzl5K2s3ZEROYnRvZHB1eXdDdVBHYjczWXhGVTB0Z24vTWRUOXhW?=
 =?utf-8?B?QUJmclpha2lUdU15RlZpKzBIcXVHTUpObkJ5RjIrOXBGTzBKZEluNGdjRlhn?=
 =?utf-8?B?ajBmVE1tRzc2dC9iKzVOU1g5M2JEQkNBTzNZVUNqWDNpU0dBRmRNQkJvT2ZS?=
 =?utf-8?B?Zm42MmYyOTNnTVR5aHRGKzdvVVpOVitsVWZ5RDVPMnJJQTRBSXJiQTZxSmE0?=
 =?utf-8?B?WTB4QTM4ZU11ZEIyWWtvVkYra005UXlnVzhGVVJ6TmVJV2FSQy9IQVdPa3M0?=
 =?utf-8?B?MjhjTlVCeXN1MUlCdWpHenZJTER5bkNaUWhCTm42Y3ZyNkJIUkp4bEg1Y1hq?=
 =?utf-8?B?aVdYbW5EakdOTmV1Q3BZaWp5S0xIY0k1QXYyd1kxdnUzcElsMUt4eW5YT2FB?=
 =?utf-8?B?OFlJMTdPelpPanByWTJHZmNFSnBmSXdMdHFBa1l0MGxjZGw2M1AyU3R5eWkz?=
 =?utf-8?B?OVN0UzEzVXdsSGowUjM1cmpoZ1FEbTU0bVRmU3ZSLzN5VnFTMDZxcGNzYWRJ?=
 =?utf-8?B?M1RxQ0VTODNOZksvOVNhbisxNERwUXpKMGpMU2ZhelhmRVErWXNHdXlWOGNR?=
 =?utf-8?B?SHhsMi85WFpldlhZTjd4RnlsbGVMdjhYQlB5SXBDVFFGNXJpenVyOHJSNTBB?=
 =?utf-8?B?eHBNVGdxRzgxbWIraUN0OXNhWkpLb29OVjVzQWQ4NmtMM2VwNHlaNUtRZGJU?=
 =?utf-8?B?NDBGZkZmdnNsaTZ6ZHJRSC9ucitwRE9GbmRVekp2bDlBeHhUNFBNaS96WGFP?=
 =?utf-8?B?aVArV01nUW94MlcvMEE3WmZjY2pSY2dmbkdzQzRZS2FpMnF5cFhwVzBkYmxK?=
 =?utf-8?B?cHVNcHk1bXdOK0VjUktmSlNUTVJYdHpiZFdORWhIMUlyNjNGRUR0ejZ3OVJI?=
 =?utf-8?B?Y082cHZ4UXRiTHREaDl5bXk4eTI4dG9FUkE4RERnUUl2MFdjZGRDRTVKL0xC?=
 =?utf-8?B?SHh3RGlUU3FyZ3RvZW8wMlNyQ2pLWHo0azNPQkNLTE1sY0g3OE53NHBZQmZO?=
 =?utf-8?B?Nm52TDZCZCtxc1N5QnBUQWVZRG90MFNsSlZwdzlsdHdvRzNrZ0FiVTY0R0RH?=
 =?utf-8?B?c0djV0FPWWU4dkowUEhuMEh5N2xUckw3dnA1c1FMdTdZd3JIUzlqdFptOUxR?=
 =?utf-8?B?akhIMDA5UG81KzE4WElqMXFtVzRlQk5UK3N5QWlrcTNqTm8vY2MrcVRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lPVlRrMXZITS9QUE1yUGk0S1NJNWk3YnFVNDF2cFdZSzByZFd4WkRmYlgv?=
 =?utf-8?B?R1FoVHFRQ2E5cmVKRFVBbUUxbTVockEvbHN1T2JkdTlRR2lBTExpOEVUMUxr?=
 =?utf-8?B?czljUTF1dEdFb3J0R2hZb0VXUktkRzVicEFJTDFWWEJ4ZVpSQUQ0MzRDL0s1?=
 =?utf-8?B?VEZzTjJTeVExVkMxM012c0kxWGVMWUNxbjNtSmwyZWRyQ0t4WU5mcXlpZUNW?=
 =?utf-8?B?U1Y3SllBZGJBcys2TndVakkvY2dPRjVTMFlOSHd3VWZrRmFyVXFYMThGTXBq?=
 =?utf-8?B?K2FpMm9pc1N1ZW9XUzVEcWpTNlBIeWY1M3dudGc2anJEVVBlWlNQeHZJYXBt?=
 =?utf-8?B?YitycHgwUDM4bmhLNmlhRTQrM0lMWlptUnlOVnNaak1oK3MveXVTT0Z3L2M4?=
 =?utf-8?B?TzdlSmpYVTEyRWxxVW5jTDJlVk4xTlNNQzNrR2tDcHB6L2hDSVZBRkhGb2tj?=
 =?utf-8?B?TEgvS3hUZWpFckg5ckI1MVdrMVF6SWphMHdOeGFFVFU2ZWFnT2pDSDRuL1FL?=
 =?utf-8?B?YnVzL3k5cjNGQ2J3TEhWTHZXVmNjQ1BGcjFKT3FpRkdmQ3JMNldqMjZQWmtU?=
 =?utf-8?B?U0dKQkRlS04yMCt1NUpFVlhwWk9FcnVrUVB3dnNUaEU1bU95clV6V0NNemh2?=
 =?utf-8?B?WXdSZVJmakxUaWZZaTRTejlsK3ZzT0F1NVc2YlNUNk96U00xSFNmZCtFK3ln?=
 =?utf-8?B?U204M2J3VXZycnFEMndQVlYxZS8rMVRjaDdGL2hkNVNzd0tNN2NzNE1ONlkv?=
 =?utf-8?B?enpVVGsxZzdSVTd5M0JvalRCQjU0Y05kYlJwNWRySXo0TWhnMlJFblZLamxa?=
 =?utf-8?B?aDNPbURHSkE4MFFoUnVvQkp3b2JRWGZLaUxOd3VlSy9SaE9mRkkyRmkzb09T?=
 =?utf-8?B?MG1RVFhod2V4RktqZUJQUGloYzRZcFdONXRpVG5LUnRCMHJnN0owdjBvNU0r?=
 =?utf-8?B?TTBYdkZoemI4dElRa2ZmeHNtYk1yY2xneXYyUFFndEs2ODUrVVZLcWh0YTY4?=
 =?utf-8?B?cnRnR1h4bDQzNDhlTnRJeXptWmloS0NnZlNsYTR6RUhLMkVXMVI3MzNFTzNt?=
 =?utf-8?B?Y21MU0ZKNVRYMVloN0tpdXA5Y2FxZkt4V0F1anZrQ1hsb1ErRDluNmF4Y21j?=
 =?utf-8?B?SVd5ODZBS1VnQnpDTnpld3F3bURWc3lldTNqdEQ4UTNqeURPYnpCdnJaZ3pZ?=
 =?utf-8?B?V3pvQXg0WFAxamdJelN1eDJHN3lEVTNXVXJkeS9mMUJ5VGFOaFNiSksxS1JU?=
 =?utf-8?B?UnlvUlhncmhKckJ4NDBud2srZzB2YTFmV1dyRXg1WEcvSUN1cHl3NUpJMmVV?=
 =?utf-8?B?am8yU1YxSThIaE5qcmsrOEZoVnBiMzhKc0VoZ0MyaktUSmgydXdFKzEvVjRq?=
 =?utf-8?B?Uk0wdDdKQXJHdThGSXFqWUs1eG9EOENGZjd1eWU5bmo2QXdXbVJ0U3NEbkFl?=
 =?utf-8?B?WTF6L3N5bnRBY0NwcndYaUY3VDFPUXNFTCtQTlNwZFRVWVFFalBYQ2k3b0ti?=
 =?utf-8?B?MDRPYjBtS0hTelZUTlpIc2c3UFpERDNJQnhEaDMxQWxrdlF4emFacEx3S0F0?=
 =?utf-8?B?Tnd2a2pURmJadkdoRnl4RFBoMlZJNXk0YlVIN1lPK3RMMVNKcG1KbHRXenUw?=
 =?utf-8?B?dVlTSDh3eGJ1enlOWDhHVWg1N1BLS1F3QktWSTA5RzdVYkxPL1dZbWdpQ1V2?=
 =?utf-8?B?NnVETzUxZjFyMHBLQkFjSkxxSXczQThtNWZ4eWptcG9GSmltMmZkOWdEdlJi?=
 =?utf-8?B?OUNVeVRXbCtyK01WeW9mRDJ6NGsvRzBZaStzamFId2g4bjUrcCs3U1VhYS9Z?=
 =?utf-8?B?ZDNqZEYwNkprWUkzS3Q5bkdRTExrdDYxZ3lOYnRlcmdPUy9lVVRpL0RGLzhX?=
 =?utf-8?B?Wkh0L3hhLzZ5TVNlNGFRMFJoMGQ1YWVHUGRXUDFGYnJzWTRndllkS3RlZCsx?=
 =?utf-8?B?eHY3VTVybm4xTHhGbi9Tc3ZNbXJ1TmdIRjE4Q3BhMjZEei94UTZKM0k0Y3Ns?=
 =?utf-8?B?b2dqRXNVdWxZUWY4SWlFRmttSFVqb3dwOU16OFhMQ0ZtaE4zWDJvWjJnUmVx?=
 =?utf-8?B?dE9SbDFwMVc0MmR4MUR0TUwza0JTQ0kvUlg4SUJSeXZ3ZFQrYjIzM3pwakdT?=
 =?utf-8?Q?ybm4hYSq1jLhtkl+7FVPbNgBG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DVMhbhMaubqJn12sVZUmMbgc4UjNC+lNsN/46IsWq/RStNwKy9wGVjj7lZon+qBIOZCtm2aV0RDs3iyPDLpf0MgO0hBL8OJWqHeBh79R9kihztqdh08WFc2EmG6zb3+Zs6QUIZmGHDoqNxIQkDwdHPBYoQa+0W1TqStEqFgMahTgVPbrAyZHFRhckVeUrNGumFps7Mb9ZdAgUIiUU8l3sUktQnD8vN4+Xk6QNwPeSYYW4RIDex7kfE1y+GSSdhVnE7qxqmO0O8tbpnY+WV2IzcI1nyJi7A3iA65I0X/aM0/S3IcpV1IY6omn/CkzJpzvk3nhAvdNc+UHd0UgCWcv/kUp4r4XoinCxU8yFyQz91+pSGEVzpVtTOVH+qLy/GejtTH0bxoIzBgH8gV3/o5Q3WhJU254Lkg/8HxHleacfLPyKc3kVzY1zL5QTek+hEoRI4ASfQTasNDBcATAVBbWbVXCx3JbqU9WwIIKT7BYdgPURnSWebuWoLp13eAphjJwtoeXkFZUjmc4W62LC3ZkpWK3oRzuSV8nmBCrZcsPJB34wRd/dCQ18SYeB6UQ21d6onfe1hjOZ1nn73v7nIP+1EktQ0bA/GtbtJlPlUvLGKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa11f751-fa4f-49b2-e603-08dcebcadb6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 21:06:07.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU+MNSAwXcXns4VqKYTGFDJW5Y4zEtih0rN45ZO/p/7zKeriHh0feXrHDwvv9QhQoXQ8wAW2tCmZn1VI2/j0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410130157
X-Proofpoint-ORIG-GUID: -KcRq23K_VW6E_HRZkZmjEcuTfEZVJIE
X-Proofpoint-GUID: -KcRq23K_VW6E_HRZkZmjEcuTfEZVJIE

On 07/10/2024 06:42, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 02:07:05PM +0100, John Garry wrote:
>> Sure, that is true (about being able to atomically write 1x FS block if the
>> bdev support it).
>>
>> But if we are going to add forcealign or similar later, then it would make
>> sense (to me) to have FS_XFLAG_ATOMICWRITES (and its other flags) from the
>> beginning. I mean, for example, if FS_XFLAG_FORCEALIGN were enabled and we
>> want atomic writes, setting FS_XFLAG_ATOMICWRITES would be rejected if AG
>> count is not aligned with extsize, or extsize is not a power-of-2, or
>> extsize exceeds bdev limits. So FS_XFLAG_ATOMICWRITES could have some value
>> there.
>>
>> As such, it makes sense to have a consistent user experience and require
>> FS_XFLAG_ATOMICWRITES from the beginning.
> 
> Well, even with forcealign we're not going to lose support for atomic
> writes <= block size, are we?
> 

forcealign would not be required for atomic writes <= FS block size.

How about this modified approach:

a. Drop FS_XFLAG_ATOMICWRITES support from this series, and so we can 
always atomic write 1x FS block (if the bdev supports it)

b. If we agree to support forcealign afterwards, then we can introduce 
2x new flags:
	- FS_XFLAG_FORCEALIGN - as before
	- FS_XFLAG_BIG_ATOMICWRITES - this depends on  FS_XFLAG_FORCEALIGN 
being enabled per inode, and allows us to atomically write > 1 FS block

c. Later support writing < 1 FS block
	- this would not depend on forcealign
	- would require a real user, and I don't know one yet

better?

