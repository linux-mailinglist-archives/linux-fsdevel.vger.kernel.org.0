Return-Path: <linux-fsdevel+bounces-25291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4094A71E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1252822D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F11E4841;
	Wed,  7 Aug 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dl7VB/3X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tz3NN71D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054221741C9;
	Wed,  7 Aug 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030974; cv=fail; b=e127vNASivJ+woNPHHgdxnaOHllZayk+qEgrhDQLIJwNZN73tA/qTWMZkS4e4RSrWV8ieLMNldOPj7csIL5JGmUAefDpAgjDIxsdlqRzN2tMSFUIOnO3PZCuX5qA/2V3O24IONXgMPqFdDvINyxxBTpLv13kNdPwcpr1/ZcktSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030974; c=relaxed/simple;
	bh=iZ5CWEMpM+QOMaJIbnlAv0J6BSSGMZ+znj/EETAZFtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFJY8dSexFO1ei2UiuYlXsL3of9xR1yfaweQ3NsRGHB/S8aN2OwPm4TqJX4sniBQtDxkZLFe7FQShvIkd2VqJirhAw+Ddisl1olyduXIR7yfSdhNpDUx28S0eseyN+Fx6fQFl9N2EgoZxQQiStBNyspg6HoqvTRJbvuYOjN3XZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dl7VB/3X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tz3NN71D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASU2M009976;
	Wed, 7 Aug 2024 11:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=E/SlJWc2JLcisTNPMdLz39aDf+FiF89hgp3jUYTvTI8=; b=
	Dl7VB/3XRzsMbM6WcJoTAABs3xQoHabIucgIx8kQ9HZGVMgzJHx6xnDAYUY+Pg/R
	7tz0ksa70/BrctCkKT1OKdiycz3bKAagU27FAQvfYupcYyuKF9b0LRezRs9HDVGB
	nhIkPNzF+vpus8At6/eEKgf7RRFtqUSjMBDQt9X5gX2gh7fuERNl8caSJ0f9F4qy
	FvOyFjbT1hFOWdBRzQwoCa1XJkDOTpALbvvU/79moK5Mqn4fNIlET2CVunTAHv+X
	v/d9hrgdewtCQMknXpjPvCR7nt2Z5HQedrnW6Sl2/8wWvMu38iMwcnbNApKNaKK5
	jlpteThJ+sMYa2bv6Klz2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcfd0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 11:42:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477BG8Pb027465;
	Wed, 7 Aug 2024 11:42:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0g6gv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 11:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r19h5RIxk9turkkp4wEA1+mlYfnikDpLmMoh5gvA9H43FKeh/Meo4h2TJTz+U9xDqoGQZC/Cp5J/tmPnurvxKupDKkFXPhfgOgWGavua3q2RFGgE6PS/OjjrCoqRFzmdH8xuQG9jIRzlVLtSU41GoHlH7SYy0obPPm+Ae9L50v2AxUkg+T8/4FSBXxTSCXDrj8XXHkksgekvqseVsLT14MpMB4Awna+LGaq2v0E3TzVlLNB7cureEPF0/7HItdqNFOlAQGq3qYPzDHS1z5d+Mboelb3c9OmBx7jngZgRaRFWm0Apjiu6FSHt55yw+5XIHcwgC4g7XqUPCxSESo5I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/SlJWc2JLcisTNPMdLz39aDf+FiF89hgp3jUYTvTI8=;
 b=NBdWIRKTDEoNF1dNnBVKdCZmWM5wU8X8ejVET4zODY2SBhPfCyn9dpjp11QCW2/t56SvteS9xWC4qABxRgZ3DmbtQx7g3wPSwiQnKJWCjBdbfp3UBdBgMLfJI325WEb1JQU5G97poiMwI55HdVBQLeX1BEpP9z3/HA7xy0aMV7Oys4Pp9pxImDVumF+B4Bq+KnN4ecqeAj2E2osJKlEnARkRvmblu9u7TvxRdCLngFjsPQNXebt7gLO+HhEpR6yGXcMyU2DHY9smD404DnHkKyf7+6lr1F2jQFQCyaDFf7Yp5oOtEpW6wqtzO6oQSI6InsteqKbXCRvRA/VbfXbCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/SlJWc2JLcisTNPMdLz39aDf+FiF89hgp3jUYTvTI8=;
 b=Tz3NN71DeF7TkmbpKNa7HowyhH39u4YV9Z3f/0asfnxDMlYbdbCYfFaxlNfFDXT9EHJXiVFYOAfsT7x8WOxgkUsI2+wkpWb503PvZxfKNQH4SVqjzz3urWNPdVQ00Q1SrlH4ZfnrEye+WS5xz77BJR+BIpgcqy9p4R+QoXF6QAE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7985.namprd10.prod.outlook.com (2603:10b6:610:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 11:42:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 11:42:38 +0000
Message-ID: <5e5d1cfa-e003-4a9a-9bd3-516616e1edbf@oracle.com>
Date: Wed, 7 Aug 2024 12:42:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] xfs: Introduce FORCEALIGN inode flag
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-8-john.g.garry@oracle.com>
 <20240806190206.GJ623936@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806190206.GJ623936@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: dca50e50-c51b-4a8e-9bf0-08dcb6d609ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUpNYU1rbVdDU3VzcFBPODZXVXNXWmtlb3BRN2pOVjlDanJWNHRBUkc5WHNU?=
 =?utf-8?B?NmlnaUM2SFZubWZBKzdmS2I2cjZES0o4enhSWWtXYW1Ya29FY2tXNUxPcU4y?=
 =?utf-8?B?QytSN1E4VnJqK0x5YlNxNml1Wnhtazd2RzV1dlNFOFh6amo4WVovd2Yyc2dn?=
 =?utf-8?B?ZFlqQk4vWWFPcnpKaWNjTVE0OUtXdnFuT3hDaE80NVMrTlpmQVRwUjk3V2ts?=
 =?utf-8?B?WEVJc3pCTWtYdjJieDBmVXVnT0xpWURQQ0RYVnJTOGd3N0FEYmlTMWR4QVRJ?=
 =?utf-8?B?VXQwQXphRENYZUpXM0VXYmRORXpUTXVSYjRSZTlEVlEwL0V2UW1OZXkzeXdH?=
 =?utf-8?B?NUxySjN3TXlPMTA3RStrdUR3aGUrbU1wejljVzZQQzdYVk5ubStyU3N0OGhP?=
 =?utf-8?B?MkgyTXA5OEl0NWp5bStRQzBReTBYRHpsVHBzTEIvUVpFSmFBd0ZjZmtEeDd3?=
 =?utf-8?B?UXFrcnpEQXdLc2RxbW9HaVhKNVdHNnJOVldlZW05elhNdWxuSGZ1OGNEdnBV?=
 =?utf-8?B?UHE5blJEQjJEbWtYazZhb1FRbXg4SG0za2d2VmZuWHAzOWx4OU80bGMvSUV4?=
 =?utf-8?B?aFdSaFQ2ckFNdnQzTlc0cmhCR0V5azZMSE5RcDd0eGVmSHhQd1krVDBlUWg3?=
 =?utf-8?B?Vk9xR242ajNZSXZvenkrU2V0bWtMaERkbWIvNGs2cHV0cXpPeGtpRkRDcGUv?=
 =?utf-8?B?WmExTzBDa0JoKytEY09DenBITCs5c1VuV0J0YjdRU2tSUFg4WUtqbW5YblJU?=
 =?utf-8?B?YUFEU01uQTNaNlY5Zi9QdnMvWWc5dC9hM3VCdXA4UnpwclhQQzNkQ3VDNXht?=
 =?utf-8?B?ejkrcjlZSFNvK1hrdTNKa0VXNHh0R0F6ZVA5RWFlTWJoV3gwNlB4bklRaHhY?=
 =?utf-8?B?NWdWRzVUcXhwWG1lTzJsTjBHVS9MNUlvVS9KdFA2TUJmUDd0NVIrcW9CckY1?=
 =?utf-8?B?WU5NMzhjdEJZRStCemhBeGVST2pPNFZsYW1QNVF1TnVscTN0M3JBZ2N1SzdL?=
 =?utf-8?B?Q0xBRFlFeCtjcmZpdFozRVR3MTRXSStqbHVaRFo5UnRkZkdVd3cwbkVxNU5t?=
 =?utf-8?B?RnlpcnRYWmFGVSs5ZStVRG1EbGJmL2lyZVhQaUMwUkhlVW1sTFhrdW8xY2NH?=
 =?utf-8?B?Z0VKemQwY0JiZWp2RjBRb1ZFLzZybnJGaTN3NVRId2FZY1o0SHU0KzlwQ0xN?=
 =?utf-8?B?TkVqUkJiWWZ2QmpCYUEzMmxuRkhOYk5ZQ01uaHo0aU1iSkd0bU0vN3RlRGNs?=
 =?utf-8?B?bmhTUGVDVGR6eTBWT0FtWFZlbnV5TUNxOVhZeTlaRHFzSGRYS1ZVRjVHMHJV?=
 =?utf-8?B?d3BHUVJZZ0FnQ0tqVzNuaFZuZGdnN0xtaW45dzV4STJ2ZnltdmJ5bi9FN2R6?=
 =?utf-8?B?WDRpMS93dWtwT09oOUxheVdwLzFrTUdQU1g2cHRtbktaM3BnSkpTOFI5YllW?=
 =?utf-8?B?WUxlWjJ1blBtQnIzQ25EZmcxZHFSeHJhTUwyY2FQc3pRZFJDdXRvbDFhSDlZ?=
 =?utf-8?B?WTlHZ3BlcWthaTNCNnhSSUxNMmdrL2owREJ6c1E0cUU2bnV1ZlNSajJ5V3NI?=
 =?utf-8?B?cC9Sa3hUdmdoVjNYK1kvRlB0RTU3MGMrNXpqbWpLN21KSHlEWCt2azlRRmNF?=
 =?utf-8?B?eXh6MzduZjhmYWZyZGtka24zYmJ4N3F3a0xMRU56Q1A1MGU1eWtiSDdjRnh6?=
 =?utf-8?B?WmhDZmltcE1tMENhNWlseEdMSktTbnl6UUszOTErOGY1TzRnc0VoUnNjSGZi?=
 =?utf-8?B?d1B5bWNDVEFIaVZIV25qYWRmWStqSlJzdUdwZ242MFN6bUNMRTJoVnR3Wmpu?=
 =?utf-8?B?emVhWGVRZDg1Zmg0eGdCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENndUpFYUhoUEt4aXJ0c1FDc0J6VkRWT1lZeHBBaXUzM1JRUUkzZzE3UDNL?=
 =?utf-8?B?ek91eS9HRE5NQlF1WENZZGRsZ3IxT0pkWkhJQ3JOWmtaNkFyTjg3TVExRjdQ?=
 =?utf-8?B?MjJaVEtPTTV2dlNOZDkxQUtZdDJWaERGMllZYTNvbW1CYVBxTTQ1eEZGcktm?=
 =?utf-8?B?dU1QOU4ybzhuTTZmb3N2RS9NZUhMMk9Nd1VtWW5obm15SzFlbFdjNTVOT0xH?=
 =?utf-8?B?OFNBZzR5QzNSNk1WQ05wdXBxQ2hncFZNV1YydGZqZ2lLRGtoWnBTbGhVQlNC?=
 =?utf-8?B?K3BZOFlOZFRtc05jSWFOY3JZV1l4TzBNMjBWcnRIenJnR2xVVm9JTExVeGx2?=
 =?utf-8?B?K1F3NFNaaDlVWTlKSlREUTJtNzE3Z3hVQ0hCTDJ4TElNS0F5V1o5MjVpZXRl?=
 =?utf-8?B?WGkzdHNtV2V1NWExb1plYjdKMXNvbnN6Sk1oRTMwcjBNb1M1a2F6dXBTNXNt?=
 =?utf-8?B?VVczcVkvY20xOEZGNkxpREExZG9ITnpaZHZkYmlNTk1xdmRUL28vUjA5RmFN?=
 =?utf-8?B?Mzg2RTdGc0ZEZEkyUWlxaWQzNnVhUEw4R0F1bWluMzVKdm9WOGdXWTA5OHFG?=
 =?utf-8?B?N0o4b2RwdWpvRC9iNmM3UmhLV28xTTM0RzF6T0VwdnRLWmtBSlFJV2RnMVZw?=
 =?utf-8?B?Uzl3V0pWN1FmbmJUcDFhU3RLVWJVUEdpU1YxYmh5VjN6MmJaU2N0UmFKcklH?=
 =?utf-8?B?aVJ2akthRXBrRUZlVFl4Z1JSYThRY2VCVXpyaDMrMFNZM2txUlBFSjFOOTR0?=
 =?utf-8?B?S3pycXVMUWJjWEVTUkM2aVJnV0piWlNpaDRML1o4MTBvdXlRb00zSHdPZzl2?=
 =?utf-8?B?MXRyZmhPNFVpK0VFaWpuUHNnQ1hKMHhtQ1dWdzZXTkVYKy81ZXArVHI1M2g4?=
 =?utf-8?B?VU9KMDJnb2srVG5FcUZHbVVFcGdYVXh1U2lmV3YycG9NVlExdXlnUkx3NVVG?=
 =?utf-8?B?SU5JSEVMVXB3RFpvS2VGLyszbDVZcGU2YU9jNWJtUTkzT0hEdzNLVFRPcXBH?=
 =?utf-8?B?UldXRUxTQzkzUGo5SzBrSUhaYzc5WFQ4M2dETy9tQmVXc3lHVHExUmxhUmg1?=
 =?utf-8?B?QmRzd051aUNiNldsME1pRFNPVGRFaGlwbm9jUnBvRjRCYTcwOGszT0N2SkEx?=
 =?utf-8?B?R1JoaHhkbDI5ZGdtU202aEZzVWJpRVNWY29OSjVmR3Q4ZEt2S2VVVEFRZWR3?=
 =?utf-8?B?a0wzR2o0U2dMa3MrNTY0NklYQTRPUE5XRVI2ZDBQaElPd3ZnczM3VUlIY25j?=
 =?utf-8?B?cldPZGhyTXVtQ3BZeVpEaVk0OVk3YmJ3WkE5dHhlVnpNVE1va2VQR0VYdDkw?=
 =?utf-8?B?T3BZbEZoM2hjSlF5ZHRIQ1RjdlRhZjVPYlZGclJJU3I1c0YwblVrNkxERUI0?=
 =?utf-8?B?ZXV0dFFaQlIyYkd1dGlzMFdMa2ZScDBWL3BCL1ltZ2NqdHg3RnYzcHJmNjNR?=
 =?utf-8?B?N3FaaUZGdmg3UGc5Z1YrQVZwM1lEZGtVT0ZUdllacU9KUEJqME9QS0tkVFRP?=
 =?utf-8?B?a1h0bVh4VU1oaXY5R3BLTTRrQVlWNlMydStYMzRySkRLem1NcDhsei80dzFP?=
 =?utf-8?B?SHBRa1g4alRlQ2NseUlESG1ZWkFTYTNJQUFTYVJJSzBmZkN3SEIrT0RlMVQr?=
 =?utf-8?B?SmY4cDhxWHgwN3VNRmxJYkpVSTNqeWxYVDRGRVQ5K0VzcXJrT1dSMU1ONDZw?=
 =?utf-8?B?U0wzRnFnYVk3dnBDYU5mRlR0VzhrZ1N0NDhxUmY2aElyZnkyRm1vMHdlOCt6?=
 =?utf-8?B?V2xyNHQzeFA2STlWaDZBWEMzczduRS9zVDhTSWdQQ3owSkt1cVhzRHUrQVFC?=
 =?utf-8?B?TnlQRENvN2NobkpVZVllcWNxbGtwbHhIZlhkNURKeFFuOEZ0YlZyMHJXK2Zw?=
 =?utf-8?B?OVZycmdndU1SWSttNkczS01lV3g4Z0pNdDhKMStiVHFWSENPc083cXo5YnN3?=
 =?utf-8?B?c0lRVTgwZWNNTGJ5dkZZdFlzYVlwQ2UwZXdiZHVvNEJDMms5T0VCL3loQVdJ?=
 =?utf-8?B?allWMDlqUDhqb0pvQVFqazhnV0FsNEpJdzZyRDFPYTVHV2hhVG5XMmo0WVhO?=
 =?utf-8?B?WU90S1lmdWI4YmxNMitGQS90TFFGNlV6dnVuZVV4aDkzKzZISXc4MDJubjk3?=
 =?utf-8?Q?PoMWkiYe8FA/IiB6Mc9wZjEnf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xa0rFJMhDhP1q8guIBYCWifdGnuwn5E/HoudDeCBTwrA20nYYA2vWiXwG7sRqiOXp2ZxL7E+b+9+oO+0LJD8pdQK89RWu1DTY8rmrhY925ntvzVuJ14tFOryNcxe5sItg2AOBTSLVWIuK4orc7jdGljuQgbaG3aOz7eDFfflusHIj8Jeie+Q0YG5Qs9x8XNEh6t37pF6evOQdp/4DStbRmzXMbQAG2FS0iBUMMj9tBtlSicg1sGnWVPCtNJZ0VnCjIzpmgBOBxcHqnUfgA/bBAIS3op58QKNMLHw0VZMqRRUXAV0c9tSNjLEkTV2JflnNYzrayklSTsKmoAQoW5VrmcB3IKYVyR0UyM7QeqlUxu134iw/cI4CYbd88qThTmgBsvd84XqceJ/aiLwgUrMw2bZc0MCKgqTsZddmzyTmMfd+/ZaWMsGgsaHdS3xhX7bw6eGtDWpHQLlcTE012Ih4V5iFi1CJgOfYdariAm+MdDut3a/lKEhqZqrVs++0XSmPPFaEwrRdMLZwRyAlsuLivDDyWsbqSXUpTHRej6FUUzYob6A3IPnEQrTnpkj45UrEniZ4ykWfPD7S/FIj1TbIR3KM2d9YW4fH4n7HegUZWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca50e50-c51b-4a8e-9bf0-08dcb6d609ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 11:42:38.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+ZLff4ngO6eApY6CcUHzgkazyOgzVBzZ1nk3eCinDIOZbVSPb47G13bBeUX5REBP82c4iufhfoYciMgFJS84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_08,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070082
X-Proofpoint-GUID: q0kmonRd19vuMA3cIuwtxPQifgYG8LY-
X-Proofpoint-ORIG-GUID: q0kmonRd19vuMA3cIuwtxPQifgYG8LY-

On 06/08/2024 20:02, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:50PM +0000, John Garry wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> Add a new inode flag to require that all file data extent mappings must
>> be aligned (both the file offset range and the allocated space itself)
>> to the extent size hint.  Having a separate COW extent size hint is no
>> longer allowed.
>>
>> The goal here is to enable sysadmins and users to mandate that all space
>> mappings in a file must have a startoff/blockcount that are aligned to
>> (say) a 2MB alignment and that the startblock/blockcount will follow the
>> same alignment.
>>
>> Allocated space will be aligned to start of the AG, and not necessarily
>> aligned with disk blocks. The upcoming atomic writes feature will rely and
>> forcealign and will also require allocated space will also be aligned to
>> disk blocks.
>>
>> reflink will not be supported for forcealign yet, so disallow a mount under
>> this condition. This is because we have the limitation of pageache
>> writeback not knowing how to writeback an entire allocation unut, so
>> reject a mount with relink.
>>
>> RT vol will not be supported for forcealign yet, so disallow a mount under
>> this condition. It will be possible to support RT vol and forcealign in
>> future. For this, the inode extsize must be a multiple of rtextsize - this
>> is enforced already in xfs_ioctl_setattr_check_extsize() and
>> xfs_inode_validate_extsize().
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> Co-developed-by: John Garry <john.g.garry@oracle.com>
>> [jpg: many changes from orig, including forcealign inode verification
>>   rework, ioctl setattr rework disallow reflink a forcealign inode,
>>   disallow mount for forcealign + reflink or rt]
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> This patch looks ready to me but as I'm the original author I cannot add
> a RVB tag.  Someone else needs to add that -- frankly, John is the best
> candidate because he grabbed my patch into his tree and actually
> modified it to do what he wants, which means he's the most familiar with
> it.

I thought my review would be implied since I noted how I appended it, above.

Anyway,

Reviewed-by: John Garry <john.g.garry@oracle.com>

I am hoping that Dave and Christoph will give some formal ack/review 
when they get a chance.

BTW, at what stage do we give XFS_SB_FEAT_RO_COMPAT_FORCEALIGN a more 
proper value? So far it has the experimental dev value of 1 << 30, below.

Thanks!


>>
>> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
>> index e1bfee0c3b1a..95f5259c4255 100644
>> --- a/fs/xfs/libxfs/xfs_format.h
>> +++ b/fs/xfs/libxfs/xfs_format.h
>> @@ -352,6 +352,7 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \

