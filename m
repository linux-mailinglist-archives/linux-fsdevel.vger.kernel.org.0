Return-Path: <linux-fsdevel+bounces-47935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7EAA7670
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BE01C02BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCF2586C9;
	Fri,  2 May 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOryCvJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XQOUu+jt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607622571DF;
	Fri,  2 May 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201022; cv=fail; b=WCitHEiF0Alg/5Tq063rwFrQ5euXO2wmVC3i51ty4Y1FHsKsZH7r9V3jTgGHYqvmAWuFdMrzpPJvlbktjEFJvLxkjpGTd2VoSVXpY3v1iA0aaL0x7Ej6aJEoxHDhqlW/AWhzzZK+MILvTVnTiV8WWqzaeQ4brrR1mXJUPXRPQSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201022; c=relaxed/simple;
	bh=VxtVCF0sgi2wci7dUkFYJ+syNTcz6Ttt4rljTs0hx3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHiQCCxQ0zZadj+jwGxCBiAHy7dxbT9ejnOsAwsRE1QFT3iGBVeD2sy6kgTUyGkFPALotVMhFrsbEV9BpTMQW1tFNZkEh5MWnMt/8wnEWPzgX5w5sfzPiiq9jKR3yJuFRJQ41n3pq+qGi9dYuJFmFefKjpDTxkEYs6WeMmXehZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOryCvJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XQOUu+jt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542FfqGk023606;
	Fri, 2 May 2025 15:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x97LDebb38DQtByQbdJH5G5IKL0bioPx/h8ZDtJSW+s=; b=
	QOryCvJzjNrxc7IbfJhgDbmQN1fF2+QMj2n98+EEEbD3RT2H12hRnu2GiwM51VNK
	UBp2BQp2jkYJe/iPvFRqIjCwHccko6/nCUKPQu0k4FVcF88BZAluHm/yE0YYR5N0
	pAtCgDVuaDVhgJM50cQVPTNRlhFAfEDFh1YC99B8qXbvOpie9Mzx3zaDFU8eStMQ
	yaE90FmbyXJTDIBuqfY15zA/kH+hfYyu+uNYAN5c4J/t6/M0LIRv/l3ZUlW99AUZ
	/wiv3NITs2ckHMuwiTBqVm2AYXkumtpiT3fyMfA4/TZxcPcaS7/J2qqwtZ6HA0Tg
	hxM2iomqDuI9Qlzfz+zRgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqnk26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 15:50:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 542EtJWe035554;
	Fri, 2 May 2025 15:50:01 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdpvjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 15:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6cuQzJN2/G4faMwOii0OiK/SYHS2lSVHGtRq1sSaDmaEYonPR0QGw6MLw3Tmaa7oEjzdXoahyv3rHQdpXNw2fdV98GjfFDXYPryDjQlSzIXjWuvVZCh3xdQXyqT9au7pGyxKKRhiTkaFwxPJQgx8haJyeCpBQb6MD7AuSz+HsptXHfL/ch0bNQr6DBRYzm8L6P/97yLZmaYCk7p0/nUmoFKBZ17/wOa2IJ5jqWoh+9Lb8CLNbddURACHDgtrWdOvTr1k2Bq4fTIW/lUqs91lmdynpMUOr3BQ2kjH7zfOfD601ZrYAb5Q3VWSOaiD0rp7eE/2adRg+mu0/bDj/m4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x97LDebb38DQtByQbdJH5G5IKL0bioPx/h8ZDtJSW+s=;
 b=hgiK37sBBh77l5FFopCV+pdza2Az8LWLYp56TLFgxnGZA409XB1LXjIpBUOCnWjXAaJkPhJoCBsUmxGM+aOcHL7woXXy9GUTJR7npbOpwT5+5s1YsCIW+RiOFwwXAmLnxS48cls2xfhtwUIZfZ9HJ86uzUr5oAa9C6WMHHmEdxXwqKKz0/J5S3FmziLxGbgMkbtC+81AX+Sc7BtKSi4YojRVYzer3pfO4dJAScgJJnYx67sj2LZgYCYo9M5D6UK4FM6kcUfCDmVKzaqPbgvMAlSWVtvzGpy+S7amrIWJAc756i+TE9jKbm4mexJlmmg8w007nCTvhDjMUSvrYMRA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x97LDebb38DQtByQbdJH5G5IKL0bioPx/h8ZDtJSW+s=;
 b=XQOUu+jtHB7+7I6vet8/UBWHTNnWYjH9eWH8M4hwfuUKhHE/ana2UnMNkxHWEgZO2+ik4+guhs5mUC3NbPb+GOdXPdS+S+ErJpUr4VcQhoc/7qu4bpN7MZWHPn406IV0c7vXSjaFsrS6eRnQkWMXGgML3O7tmNXTp3TINUFEBmA=
Received: from DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) by
 SJ5PPF8DB18B996.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.32; Fri, 2 May
 2025 15:49:59 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%6]) with mapi id 15.20.8699.024; Fri, 2 May 2025
 15:49:58 +0000
Message-ID: <a3a6443f-2351-4e55-a12e-4d1f28ba7ca4@oracle.com>
Date: Fri, 2 May 2025 10:49:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] ocfs2: Fix potential ERR_PTR dereference in
 ocfs2_unlock_and_free_folios
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org
Cc: ocfs2-devel@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250502153742.598-1-zhiyuzhang999@gmail.com>
Content-Language: en-US
From: Mark Tinguely <mark.tinguely@oracle.com>
In-Reply-To: <20250502153742.598-1-zhiyuzhang999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:408:f7::33) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|SJ5PPF8DB18B996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a46cf05-89dd-4183-14fe-08dd8990fda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnliNWRBTmJHb0lMQk5QaTNPdmYrV1F2cHd0bmJQWmhHT04vS1plVE1PTVJr?=
 =?utf-8?B?ZXN3bUFhZU1CTDRtakIxcUdab3ZoZkhVTmQ0am9BdmxtNjdQZ0JCOCtkUnRU?=
 =?utf-8?B?NXBrQUxGdnE3bHVST2VxdFp6aEVDck5MSXhIV3dtZGpDM0hFN3cyNkhnWjBm?=
 =?utf-8?B?WEhsa09PYlV1M1o4QkttVE1Qc1dXK3Qwd0NQOEQ4ZTlndlpEYUs0ancwWWYv?=
 =?utf-8?B?UXFOQ3IvalpvWGZWUEJla2ZEemNSa0U4Q2YrQ00wekp4Qk9wOHRIbUdhQjND?=
 =?utf-8?B?b3h4ZzdTSlhRMFdFRkVvTmxLclBjRVRDcUJQRkVrUzdHK1VQa0plWFc5MklS?=
 =?utf-8?B?Q09vSzlwdzV1bSttUjlYU3BqcHozZEFNSVZ1alU0a1plYXdiQlQ2cEFGSHBj?=
 =?utf-8?B?SlBHNTV1KzdBaEdjcXdyQS9QSUdJWmtYSEwzalJRdGZJWGR4U1d1VFFxbjBm?=
 =?utf-8?B?M2ErK0d5d01qd0hrc1BLb2xXVkErazlkLzFYNDI0dzdPVFhoOGdseTN3V3VJ?=
 =?utf-8?B?dUJWcDgwYzNUeGI1S0dQN2FIY3kyc3YwbEs1dUVubXVEVjZqa1FTWExnWTJF?=
 =?utf-8?B?Nm8wamF2YlRUczVXaklVZDYvZk55YVVYZk9qbUQ5eS8yQkVPakVhVGE3TEJQ?=
 =?utf-8?B?c1YyckZlaVRlMDZtcFk1bzNHWEN4MDdIMGFqVDExMHVUNmIrRmVIMjdHNS9D?=
 =?utf-8?B?N2QvdUE1MWhMUzk0SUpzWlBTZFM4L2FzNFA5Y2xWcGFiT0F6dS9OR0UwTi9k?=
 =?utf-8?B?ZjZTcUdTdjdUdDhkeExXQVVqNUtkTXRqN2Z5WVhmMnU2aGtBYXNjMjZSMG1w?=
 =?utf-8?B?b2VIWm4zRUcyT1JEYy94K2MzWHNQZ3hDRENqUldTVDZqSXVaRTJrOUc2d3JW?=
 =?utf-8?B?MEl5RStZbXdkdDltWVM0K05LWFpYTlNMbUVzeFlrdHE0N3JUeFZkMS9ZbXJv?=
 =?utf-8?B?S2ZZczdERXFiTFh2WVZXSURDcytQL2FxbGdUY2I4TFV4Qll4UTB1VjZ0blNy?=
 =?utf-8?B?djl5eVJpUGxrVlc3R1BuWDZEMmplZ21OeDVWUkRQT1VpZFVNUnFhQmhBam5j?=
 =?utf-8?B?RkNHYy9qZFNrcTFoWFlYeVlkbUNDZUFjWVM3cm9SWlpuRVhvSlQ4c2JUQjJW?=
 =?utf-8?B?Y2V0ajdsRWQ5cDI5ZEZFd1lpbTdOcWFVakpZMjVtU1dNcUZmVFdtTXRVYW9U?=
 =?utf-8?B?dyt3eWdsVVNHdjBGaEU0RzFvR3A5bzRYbHk5RDViSTMrV2ZXM20zNEk3a1BN?=
 =?utf-8?B?M21OL0xlUllZOStvODRIYndGWGtPYjJ6NFVGMHdvOHhYcngzTGg1WW1kS2pH?=
 =?utf-8?B?V2E4WXdySVo5V0YzVzY2UmRrYXFTb3lMeEF3OHRRRXBiSzhvS3RreEZ3aHBp?=
 =?utf-8?B?Q1RjdjJ1VFp2NmYyU3Y2NU5JMFJoRHpwUWtKTVlGOUpSdjJyVTlFZUhTMXBk?=
 =?utf-8?B?bkJXY0JWWjJvWU11RDRFL0xFRkxwWGo0THkyOFM4RERlWFVWVXBraGloY1Ux?=
 =?utf-8?B?RXhxbFErS0h2WmtOOExBNzBzeVZ6TmZ1L2VIWnd2WjFQSnAzekdBZWRObHBw?=
 =?utf-8?B?d3dzNEFHQ0U4OWhqdnRzdC83NDRUbVFLOXVjWTlYazYvbHh6MTdvQ0QvWEJ2?=
 =?utf-8?B?WFR4TFBTdFpiNFllMjFhRklrYUpId0xsVm5ucEVOL3VTZnI1MS90MDNKSU5h?=
 =?utf-8?B?NXFpemxYWVhkejhGWWY0QTJTZGg0djZnMUlMR0oyd0tjVmZhWFQ3a21NZHcv?=
 =?utf-8?B?L2hBRTlTYVM1MDBaK2FWUzA4bnVOOU1TS3RjSzlsL0JKNi9KYlh3N2lZYzZx?=
 =?utf-8?B?N3BaVUhqRlRkRUJMQ3dudkd5eHJ4ZFhtTy9RcDJSeDZ5TytxN3daWnd4R3Bk?=
 =?utf-8?Q?aV6ToHeTDDhQi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVU2RE0vdFNZeE1xODUwVzl4L2RsQmttN3J1WjJCTkxhd003OUVSYWxIN3Rt?=
 =?utf-8?B?M2dhUzEwZU81azg1cnJsbkhjcjlYdXRpM1drcVNkWVdEWmhiLzVEMVhxK2l2?=
 =?utf-8?B?NlZMT1lwNUpDcjNZRkVzdFB4Z2huTjFCdnZqS0crZFZyUnBCdDVFYUp2V1Uv?=
 =?utf-8?B?RWR1YTRnTE0rcEdSTHR4VnZxSW9FTVhsS1E5V0h1Rm5BS3BwSERWSE5rQStp?=
 =?utf-8?B?Zi9yMVYwZnN6czFYc3RPbjkrMWNuWnZsdFNLY2h1ajdLWXRSSkVpRFBUbE1M?=
 =?utf-8?B?REoyQVN1YVR2ZG9TSndodnNGdzBIODN5MUVicVRVbmt6bWpDNXNGaHAwOGtj?=
 =?utf-8?B?ZFVZRW9pODJTVUd0MUxPUnVzUVc0Uzd3bWJPZ0NWUm9MTCtETmhFOVE5K1Yv?=
 =?utf-8?B?UDRaVW05WHhFQWk3OEpIWFhMakxqaWU3Ry8vMTZjdnpubWc5MXdwbitGWjV2?=
 =?utf-8?B?TEJ2Y2daQ0JRM2IwSS81b25lRzdQL1J5U3B4UVU1NXRuOURDWENhcHhzdkNp?=
 =?utf-8?B?YXJMNzY3cUI0SGp3d3BSUWRNSjU1bU5jaG44ajRoVHRqUlhVdENWaElNRzhl?=
 =?utf-8?B?R0t5WU41OTVjUXA0MG15N1QwUmRESDg0L3ZrMTFNN3oyaEJxUVJtdHJudFU4?=
 =?utf-8?B?R1dtdDAzd2IvZnErWU9KdzQ3WVZIb3RYWE1UQUhyMU1xTnZXdVAyVHVUVUVJ?=
 =?utf-8?B?K2VzSmFnVTRCRVlBOFNzM1VhUE14MVZOSGhjcGlqQWkrdFk0WlVFQ081bzY4?=
 =?utf-8?B?UEh6RkNxbUI5ZEp0Y0IxSDcwNkl6SXNRd1NjZFFEdmlCSUZIZ1IrT3hpZFE4?=
 =?utf-8?B?VUQzbXBMRmtyQ21Ic0tkVXBIVjRhL3R1eHlYMlYvOFZRM2NDaXVwU3RRS2Ry?=
 =?utf-8?B?dDR0RmJQMXpKNmlHSVFvVWROdzhYcjBTM2FSZTVIWU1uU0xDQVZNYlROZ2JZ?=
 =?utf-8?B?bE5NWkNCRWNCTzA5UWthUmQwYUdTdGU1aHRvczh2UlppUlNwdGpMZlpja0dK?=
 =?utf-8?B?RDRvakdVNWhaZ2hxbUxpK2M1T3M4Z1ZKNjF4dVc3MVVhOWdJM2xJVFgwUzRq?=
 =?utf-8?B?b0NFNVVJTFdjMFJsRDNxdStENE9CaW1hVFByZmYxUndBT0o4UXNZR05yT3Q3?=
 =?utf-8?B?T1Z0dnhFdUx1QW8zWkFKaUh0dDBiRnlJUXpabmptdzBrdGczS2JSVGRjem9J?=
 =?utf-8?B?VDJtM0NJV0QxTlJlYzNyWm02YzBWZE5HWndhTGN4TVhtR3NYN2hJVFZCVW01?=
 =?utf-8?B?eEJjK0dZVW5YcUt3bVFMMXdLa0gzdWRoNzN6RURBTnNTS291QldGYTViMFVE?=
 =?utf-8?B?eWh2OEd2cERoMXFVWDllbTNPTTUvVkZ3VXRaUGV2WDR1aysyc2g2elR3WmE0?=
 =?utf-8?B?RFY5U1ByM3l5b24vVEhTZ2xxOGhDcGp5RW1VY0Zta1JGcUZzR2xRNnJTQjAv?=
 =?utf-8?B?MTc0SVJtWWZWSWNwYU5qQXVwQjdISzlVVmdMTUhrdnlhbGVnbk1oMGxPaUwx?=
 =?utf-8?B?RHl5L3p2WEZTMTBHbXpDTDA0Q0RqKzdCbWp0TnFkRXpQc2JDZW0vZGlHRlFU?=
 =?utf-8?B?TGprNmVnZm9sbEl5Q3dkREJSUFRPNUdPYjE1cHpCQjZ0U0dwUm9NU2NVYjJy?=
 =?utf-8?B?bUs5YmhJK2Q2Y0VGOXRObkdWRXZzaG5jcW1lQVRuK2hpTzJKTFREbTd5bjdw?=
 =?utf-8?B?a0FOL1plOUU5aXpwek1Xd1pHSjhOaGxkL3htZGk1WlY0K2VCUDd1d0x6ZUg5?=
 =?utf-8?B?aTBWRVE0emEwSEFqNnYreGlGcUFDNDR2MjFOZUVXamJvYlhJaGE5Z1A0c2Ux?=
 =?utf-8?B?cG5pZDN0RVZ4ZkZENEtBVWNRWFRDdmNUSTNwT3dwL3EvaGVkbjc3enNEQ1ho?=
 =?utf-8?B?cnkzVUdrZzVrSEY1V2Rja01tK2o2NXptL1JxMmFna2x0Z00xdWl6NW5rMHZE?=
 =?utf-8?B?WXVFbzQvQlZCVDRvZ2NXdXpKMmlXWTFLSTRmaWZ6dWM0b2dBQXFOaUFUSHdj?=
 =?utf-8?B?STlCVHpnMml4NmFURG9qcUYyOTBzV1dvUGN1UVVWUzVodVRKZFB5ZWMrUkxF?=
 =?utf-8?B?aUZBZUJlazczWGI1RG5iZjE3UTdKKzRoOWZ3Yk1PUFhSWEFuZmtQUkZ5dTdB?=
 =?utf-8?B?a2U0bzlzTU1IL2llaFhEVkNZL2MzVE5XcGRBSURyK1dZa0ZXdWw2K1NGUU9K?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2T/F3GXTZ9+8Jq8kPlh8p9W370O03YvzzBG+k+UOCtuWfmlAJj8qFUrzBhSFDl+Yu3GIcvaSWv/M/FZUgqLxDYAExK2pHlooiYq1WMjYLa786KdhZijqB8Fij+IGcyNYgS7SvGe8HyLYY7TAT+Q7VUGpowoyan94jKFdqfP9mfU8XHnA5r9Z91scLU8IvgahyUd246pci89CC8Jyo0r1VqezYgMEzfuYrdbwHbWUfTMNu2dWP4kRhSU0pMg4ZI6W0+vNQE15fZaXM7XhFB1jXeo1RMxW98LAiUQbFsgKOzsE48QpUuntHta+Q+QFsV8lyi5JhjHiy5oNqswGn4299Zmze/UjdhSiwiUn2erxCsvcYgzTxreMjsIMP1pg/n1AnakqO8mT7oO99WqFDTqDkNISfoVmyJzr6Am8dkFbRuczbDZNjeRgMprYH9EK7rNffBpKUPngr7B+zdH/8jSsqyjKGO/VAWiVYskkfEyeBkrTokv58b51v1LyYyTO/BW60r/+/q3kBaJoXANVpjMc0WuXuSAIjAZGRw4n0myDAWSX63qKPbWdDo7Q8EVEpELe/mhqWakyo85z7isr4xjPMJc81weranuk+wIUvF60nvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a46cf05-89dd-4183-14fe-08dd8990fda8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:49:58.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr8UxhTAx3//L3mDqVmQc/YAnzUVNOeilQixHyoSjWHfgHAQQhCKJIKworYNAjN4LHp2ACsYoUDhmmE+N4u25WDf7SHo/28P21bc9DDuq2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8DB18B996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020126
X-Proofpoint-ORIG-GUID: z8IIowE4aRgHHDF15wJaEFIEgvz8Sc1m
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=6814e9ab b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=H7y6HpH4zkAZvsdpZxgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638
X-Proofpoint-GUID: z8IIowE4aRgHHDF15wJaEFIEgvz8Sc1m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEyNiBTYWx0ZWRfX/bAl27+5HfBp bNweBerGERr0JycT0h7A58T2HavZyL148TrTfOL/S4+FimgtfOVGE74oQThdz7J0gXO6wB/YH9N 2N7DFDtZcQaKoO0XTv+m0T9XDFcvpEH3TXXBw/n+ZN9OuuHCHF7TYdayHepsznFMMXfd9Kjawiw
 21pHb90Agzco6M1KcHh8SNTMtfMncJqfpF/vk5fq/whIjFzKYsrwuP0YjFwP67sJhXKcBBx7hdb 2B1248j/6pAgTN7r9bxwoX2O2UIMuMK2EGyk8O/RnehxHFe3rpAYiQdMFZP9QuJNJjCxLraKiLa Vu4mbtOg6AECYglGqmRRX1/JqTKu/FsSRRCHTER2Ui5aemMCXLEBYrhhe6BS/owvID8g934Nlbh
 nzGjgYVFyipICjHQhTrHab4G2yEtuW2t0eHcMAfeDJQXgFvJo26T6I3HKPdnTRC/zUDDsEH2

On 5/2/25 10:37 AM, Zhiyu Zhang wrote:
> When allocation of a folio fails (e.g., -ENOMEM), ocfs2_write_begin_nolock()
> stores an ERR_PTR in wc->w_folios[i]. ocfs2_unlock_and_free_folios() later
> walks this array but only skips NULL entries, thus passing the error pointer
> to folio_unlock(), which eventually dereferences it in const_folio_flags and
> panics with BUG: unable to handle kernel paging request in const_folio_flags.
> 
> This patch fixes this issue by adding IS_ERR_OR_NULL() to filter both NULL
> and error entries before any folio operations.
> 
> Fixes: 7e119cff9d0a ("ocfs2: convert w_pages to w_folios")
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT*YOXcwfNNt1ydOY=0Yg@mail.gmail.com/T/*u__;KyM!!ACWV5N9M2RV99hQ!O2QZFrLv_PvhBiQH1Ak3ZDOIFOQG2RgkiOSogyy_3n0ZsLL_GXVwf0aiu7ti71LagUjWpF54NlvjjQP7IfPUT2vS0yY$
> Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> ---
>   fs/ocfs2/aops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 40b6bce12951..9e500c5fee38 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -760,7 +760,7 @@ void ocfs2_unlock_and_free_folios(struct folio **folios, int num_folios)
>   	int i;
> 
>   	for(i = 0; i < num_folios; i++) {
> -		if (!folios[i])
> +		if (IS_ERR_OR_NULL(folios[i]))
>   			continue;
>   		folio_unlock(folios[i]);
>   		folio_mark_accessed(folios[i]);
> --
> 2.34.1
> 
> 


yes, this was my bug in the folio port.
I submitted the patch with subject "ocfs2: fix panic in failed foilio 
allocation" as a solution.
In the old page allocation code, a NULL was the failed allocation. Folio 
returns an error code. the patch put the NULL back into the folio araay 
location:

  https://lore.kernel.org/ocfs2-devel/7de24670-89cc-4502-adbe-308bd5786f1d@linux.alibaba.com/T/#t


