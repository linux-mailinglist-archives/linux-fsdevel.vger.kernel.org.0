Return-Path: <linux-fsdevel+bounces-29316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3694978140
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6528670A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2F1DB524;
	Fri, 13 Sep 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ek1EAflh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a0Ag2qcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9658AC4;
	Fri, 13 Sep 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234495; cv=fail; b=g93vrT338dtGMrzprA+ocq+LWhVVLeCGeSwUS3eQu3X2wIHqOkfLdUZ4Ln3oJuUygP7gmI/FMfn/eeaZsIrteRUZZhf9rjS+wMsDXHVVhGR+J8mL4ZKyuMlgbLlL105//R1gCxIkFjLptzZaMYgyKa2NUt45EpzxULljrWbfHGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234495; c=relaxed/simple;
	bh=iaue9rL/7+VvnLZvHKmw3sSIcEN7ABPNImwRi8htaug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gE1fApocwAXulERT4AGOUQOu/NDhDuQySm0rrbJ5W9nuvq429AOCaPuvrVjbomsL9zBzHPYxyk/EkLnSK7YUZw7wpnG3wSExFMZuUUtWRK9VO1kv4qSmrMTRBLQKYjtSucOY2wa6xC5yUwNfjugPq7PwaL+5NiV3SufYuUI07bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ek1EAflh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a0Ag2qcw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9Yl48012564;
	Fri, 13 Sep 2024 13:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6avfnotOsusUVWmOX3fLP8u/weelQdxcaxl2VwYs+D8=; b=
	Ek1EAflhKaFROrzngV6Sr3FQWJSdYRSYy5srf38Qnd9w3V/YIgqBlU+DqmffDr4T
	QAKQ05Y4SCrHFlIhMHGprPIyfjZWxPMEROKQYmR9s8XzgvK6dFh7y8663U9Wnr0J
	pkCc/156Y+qsDvht0YBuveLWOM816EcAxy+ZS2n0bfkm9iqBvBvlYWH6t73c3hor
	1YoNwRhmmJYOwtuMmSEiLWja84wkJAUDhNlbYgi6GIBk+dNcTRwNz9TSWOABK4so
	gw3kkcZ87QY8E9/HfZZhFf//tLzFwuAYVvFkGvw+sQRN5758q3CAnqYgYqn1bwzs
	hTDTW3VtBTntaGlD0SlNvw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctnmwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:34:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DBgOwk031602;
	Fri, 13 Sep 2024 13:34:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d4tn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr9+/aaVm3ygyAtOm5iq+seyG/+pnxt+jmuKcLjJ3fuoXOuiR5a7e2is0SeZbWM9BFVdIgp3U+9UCLBOtGo9yF2Rhe+kQ7JBrJOkYQS3ZAmFpUIACoQ6EqqPT6x/HZoXii/F5A6u8HcLT3Q8EHVcyEqbg5n7//DZdn57asPMEph7QaDoaqrdMq9SPPVHvSHi88YPnVoLwY/LYsRm+bcR9Ewismn4yttKRO9dLmUqboelXXc2u9jHST3zVRyhyGCGH2YfouOp2Z39mUr6oGuZlCyUt4jj9zjb7XWS/zsXtyrlqBwothit8Mx6bSmr3v3Wn/zAWTUjNRCwT/e+q0s4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6avfnotOsusUVWmOX3fLP8u/weelQdxcaxl2VwYs+D8=;
 b=TXThpe3fptdtJ3llsp9yScTo61yinHIj2DpQAJUShkqOIbmx5CCdY3vcBRd5a/zuZWv4nlB6XL2oLlyWRH6zry18ZfR8ii7zP5MfE7yXtk22/kHthkiWilQ4E1WzeMGO9UthiboRFwT57eiSyG3wBI/R3GIo4Ar0IJNoXKID+ZhdGggi/QnisYA4zM6BexqYTUP2OoubfkMuYV3QEQUHyGWdxjx9GBea0Nx7x9Zx8pmGr5BjeFK5mocXkjMi5jKNypZ24ugG4WENpQ+mzsjA2n3dc3HISTJbQK3OikpGpIRgJQEbojftEx2sjM5WTD5wiT0i4cEDrtKwdMQkLH+ndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6avfnotOsusUVWmOX3fLP8u/weelQdxcaxl2VwYs+D8=;
 b=a0Ag2qcwDcln+sVxxcaG1Gm2ABQeatLGXNuL4xp7M6trGZDx4i/YYYt/XtkPurtXVYtggecHffQHH2RS0rhxO5WVdy9C/xy90iMW2ND6okgfVkH+rSJmLC/4Vp7ZU3aT5qY3bLK4+XXnrrBCG1PzHgeiXrSfwESD0mQ/t9c2PYk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.9; Fri, 13 Sep
 2024 13:34:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 13:34:39 +0000
Message-ID: <72f78079-986a-45ac-8f5c-489dd824615e@oracle.com>
Date: Fri, 13 Sep 2024 14:34:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
 <5831e24d-dd96-4bad-815f-b79da73f7634@oracle.com> <87h6aj4ydf.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87h6aj4ydf.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1602e763-d4a6-4452-80b8-08dcd3f8d0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djM2WHNpZmNTQWpWU1BubFc5Mk1Za0gxUVRKV3RGeFNKRWZoZnVVMzNpL1Bo?=
 =?utf-8?B?d1hyaTdGY0U0cm55RW1YdXBiT2RSUlNKa3lNWnczRDJvTjZTN2xMQWlyTTZR?=
 =?utf-8?B?eTJkci9xeExiR0NBS0ZvSWRFWWduZGVWeThIRlczajZHLzFjM3k2cVRKL0Vj?=
 =?utf-8?B?aHdkVkljRWV4NmJWaHdDVXVHWkJUVlhnYzd3Rm84MEpTUDRrMXJCK0hvbXZU?=
 =?utf-8?B?dWdPdTVteU93eFZrL2NkbkFnSE1FaXc5d3ZxeGMxK2tvWXI2M1BpTC9pQXNq?=
 =?utf-8?B?akhjekVMK3Q2WHJDbW8wWmNLblJFK2g2VGNpMm1OdDhoeU9DM0ZVKzg2WGpP?=
 =?utf-8?B?RVpKZ1RJcTArc2hTVXk3QklmdFEvRU95S3FVVDlERFFRWWxIV3poK1RHbFpD?=
 =?utf-8?B?MnMrMjdyQkYwQ1lZc0RGQ3BYc3ZDOUtRd0xrWmgweUlMRUJpQ2k3L2RNbjVn?=
 =?utf-8?B?WFZqZHBOQVRXVHh1TEkwVURod2hYYmxWdTl0dU1jSGdSbGxQenhTbmVKaTRj?=
 =?utf-8?B?WHV0UmdpTFRBNkdvNURSQ2dKckp5ZW9FR2VpNkpKMzFHK0J5dXdQb1Q2enF6?=
 =?utf-8?B?YjZTVFFnNHpWOUE2bjMwR3JyNkFyWHViVTdtbzFZZDlKMkZyYVUxVmJsdnNl?=
 =?utf-8?B?VUp2bDZPaDBZRnpzVTJ6NUxYUEN0YjkxNmxhVzk1U201VkhCU2ZzL1VVOTZR?=
 =?utf-8?B?b0trRGlhS2wxaDhlczREK2x2WnoxbllNQjlmeEs4VkQ2bkpLTU51clU5TDJx?=
 =?utf-8?B?RkJ5OVpnTHl2WERTTFhpWTliNnI2Mjhra2pKR2hSK3FHSUdhajhVdHk3ZXdV?=
 =?utf-8?B?a0M3UmVCalFFTXpzRFA5Y2htNmJFbjRrTXdYVjBmaUQ2V2gzRGtObU1pVnZK?=
 =?utf-8?B?S1NjdVY4NC9IRTl4dDVjbkd4OFhBWU1yRENlMXBjYnF2ZXljb3UycTJjWXI0?=
 =?utf-8?B?N0hFWUZ1NFVkYm1VbWlsMElZa2lNU3NEWC9lRkNQenA3aUpTQXRRaHoyekF2?=
 =?utf-8?B?TkFIeENMZXVGVERMTURyeGVFMkJsbmVWR0lKTm5aclRuTE50YnlVZGFaVlBo?=
 =?utf-8?B?SWRxa2dHNlp2VDcyamp6K2wwT3RLVlByekFUd2hzTlZ2NlVPUG9TVlBPcXdt?=
 =?utf-8?B?dWVUVmpSQWIybFhYWmh0NUY0dTMvdmpqWWZiWmxSR3U2TmY1cU1lNm5FYzhk?=
 =?utf-8?B?UGRrSFh3RDhaQmg0d21kMWI3RWF5SEZmQUcxRDdnN1lRRnJPSEJWbnhaemwr?=
 =?utf-8?B?ZlprTU9ZTzJaM3RKM1hCWjZLd0xLcU9HSURsT3QvcFhzT09COVg5aXozUlVr?=
 =?utf-8?B?VnZ6cm10NjdrdVNZdDRLR1VFWGR2eEVGMnRtSEFSUmtZY0t1ZGpJaVdqQ2JO?=
 =?utf-8?B?MGN4SzY4QUtNaUI3TG9VVkI5alA5aGVONjRTc3RDR0QxU1RiY3A2ZllLTzNU?=
 =?utf-8?B?QzhUSmFNL2pPckU2b0YrVUVPbXFIOVFBS21aZ3Z1YmxIakNjcHlJZmtodzkx?=
 =?utf-8?B?eUNlL3d0M0Z4MGhEWkdUQW53cWFEZXIyVXN5d1hyNnM2WTZLOVZvSU5iQ3Zx?=
 =?utf-8?B?QVRzbDJBZ0Rpc0pQWXVwanpsRjh4VmJiU2NoUitWOUhyY3ZvMkVYWE13c3gy?=
 =?utf-8?B?UWF4cnozcVBMdTloZlB0YzVDN3VKRHVrTXFrTzF6eDh4RUIyajFOWmY1R1Vv?=
 =?utf-8?B?MnI1dHNEaEk0WDllL3NaZm5QVHVRWHBhQk9ycUUxMjNQU0ZSL2I0S2lRSUpT?=
 =?utf-8?B?bkJ4RHRUaHJQQzl5Z29WVnQvc2RTaldXTi9MWTAxMU5sRW9ZU1J0WjVXZVJi?=
 =?utf-8?Q?ALK0abvxz0j2BiG3Dl/UM8JTh0WfFyhIeqb4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFtU2l2TzdKRHVWc3NvcXBiMDRhTk5lMXJLRUFoMXYxQm4wWHBhaGdHLy9s?=
 =?utf-8?B?dXNncS9vNnhsV05BQlNHMDFva2YzSjdRUk92TFlKaytuN3BkaWRRNXAwSUdS?=
 =?utf-8?B?N1ZTbkl5MTZZcnVsTU9JalpYMWVxVTl3S2RNMmtVdU91emg5LzgrS0xSclor?=
 =?utf-8?B?bVZZc1owRllkTmtrOWtLMUVxNWxoTDNDd0ozVVUyZHNwejhvUENTYy9jTlV2?=
 =?utf-8?B?aGM0MEdydUJIYkI5aGt1UGVLTGxKNDVldFFIaDk5K1kzbFAvL2NuVDI4YThm?=
 =?utf-8?B?RHpuNkRpVVVZQytiSUY4QVc2K3BRM3BKcUFwWXdsYUtpbTk0RE16SUtEaHlw?=
 =?utf-8?B?YWJQajVKQmtlU1dWRDY1L2pBQUt0VXFUenp1YmxoQmFpM1dRWEhyTnYxblRS?=
 =?utf-8?B?QUwzeFdkWEw3cTFoUTVkZkRSNFNJYnZKVFZNd0V6UVlaQVh1c1lYbFhnZTZS?=
 =?utf-8?B?V21kQjh1eU5HbXR5Z2Nrb09VTWtVQWd2dmZ3Unp5QnV3Z3crbzVUYm13VGlY?=
 =?utf-8?B?YnJ3YmlNRVlxeEpza0RXTTd4d2wvVzNkaVVzcHNINmRkekc2YkVCYmp0bU9l?=
 =?utf-8?B?blowSk5uRUVjL0hnb01aSEYrbnVubzdFV3lLQzQ2NWZNR2R6ZFR0d3VDODhZ?=
 =?utf-8?B?SW9oMTIvNlJYbE5vZWFhL09qYjdHSklwb2VaazVMUjJMRmxYeW1LNG5TWE5Y?=
 =?utf-8?B?T3pxdGZtTDFpZ2lDU3I3M0x3ZW9BMUVhQTJwVm52NHc3c3pjdkFCRUdHZEVq?=
 =?utf-8?B?ZUJHdXhCK0pxbGZRdThUenJWN2QyczVLaUhQOUNhMmtqbkppOXJOOXczQWQx?=
 =?utf-8?B?bXFtRzA5Y3BGTmZRRy82SXU2Y0xxRCtWMlN6L3d3RlBUNVl3b1RrMGg4TzRy?=
 =?utf-8?B?Y2x6alJtMXFNK3FXRFMyMjJtL0N2STlmRVdHYUUwWEJIc3ZRQVN5TENxTkFu?=
 =?utf-8?B?UHZJTDVDTW5EV0toZ2FrOFVmUXFIUDFoaTk4eWl2QktncjU2MjlCYlVsUnFL?=
 =?utf-8?B?M0o5aTRmRWhiRXFMWDFPMSsyaHVZQkgyQUVzVXUxZERQQm1ZV0JxaldHbVlY?=
 =?utf-8?B?L1ltQnhLdE5Bck9ZV1pqbjFZZ01MYStWWUw1UFd3K0tTV0dOeVdkYTMvYjhG?=
 =?utf-8?B?WXZSQVdjUE9uUDhjQVJ3ZndpSUtFR25RYWhVV1NhUW83NXE2SkpEUUt5K1I3?=
 =?utf-8?B?U245WXVUVnZ0TTlxZnI4U0liMENDa2loamtqa2tDUkk5MWNjb1VmZDFRek02?=
 =?utf-8?B?WFRVZ1BVZjhnaGZLSW5CRDBYc0ZhMHd3M0hOaXJBemVRaGVTeFAyOVRKSmxi?=
 =?utf-8?B?U1RyYTQ5SWlKWjd2eGNlWlg3Vk8vMFl5dWNQLzFSSmovZ01ZT1N5cmxaenp2?=
 =?utf-8?B?Y0ZJeE9PRjJnMnVYMHRRaHF3WkZ4S1VXT3o0anUwNCtaNDBwSVA0WHV6eThN?=
 =?utf-8?B?eDFSaHZ3TlBVSkhjMjNmeVhUSkZ6MmlOUFl3RjJHR3hhL3gwM0xFd1lCTGk2?=
 =?utf-8?B?Y0RBQnBLZ1Y4cnFncnFMUk5VdWpFQlZ4cStvbG10M1dGZVJoalZSSXY1WlRt?=
 =?utf-8?B?eVEvMjlCOFdBMkxLelZML1dMZDFvSW1pcDFycEEwSEhlZG1EZGlMODFGcHBH?=
 =?utf-8?B?VnBWUlRvRnJ3TjBtaVl0djVlanNkbHBrZG1aYXY2Y2pkOS9BdXNTNzV4R1V5?=
 =?utf-8?B?Q2NnZkxzd1RhcE80NW1WR2dvbWFhejVWTWFKK2htY1B2VjBUWHl6ZmJUWkxD?=
 =?utf-8?B?cmwrNHZZMUR0YzJtQjMrVWxhcHNFb1F6bW8zK0lhd0FYekVndjZJTWxlWUVM?=
 =?utf-8?B?YllGZSt1RzhiWTkyRkJJVjBweHlwRG5zUzNqVkh3aFI2Z1RjalJxU0dCaisx?=
 =?utf-8?B?d2VvK2xoY2FLaUZlREZBUVZQWTF3ZmJLMmJCQUpLV3pXWUR0YzNTaEs3VXE5?=
 =?utf-8?B?QXpRK2JtL1BHcC9kU21DYU9UQjFwTk5ydFNaM2ozVm91VjlKdTZlTU0yZ0Z4?=
 =?utf-8?B?cTJuOC9DWUJ6a2U0R0RadlY1c2xBbExRa1dqTzVKbFBBR09ER3hWMURmdDJU?=
 =?utf-8?B?SkZuQmMxODd2K1B6WjNYckQ0SnRFQjZKMmJMeXhqREdLVzV0WEZONThrT2Z6?=
 =?utf-8?B?RFcvQ0FoRm5iTDFtdnJscFhGUVM4K0VZcEhlQmxjb2ZZRTlFTFRrWXJGSzlu?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HzU3vQeqzi4lqBMviPW0OSv+DiQ3hdFb5+9+f+blETWiCHr19fg9/ZgLrAta1O/rzdteRWkJ3HtViQ8qnLMc0uxAlZDj1aeuljCrLF3rya1WYmMy9099NhYoXIY+53r3+YSlFH5gUWbmmG96VFRfIpkJB92bPKsceGzqXfeBscRVRXFJaNxjRhUKdmH2hLn1y309kTs7phDsk6i4MynzkHiP+WJBaGwIexO18Co3JjmChaFYfQcfMBikIPaGx8p4BzBC+TriCJ2vXeA89+6o7jKCtYp9ncIF054E6EkxzWcYIfcJrV/4XoXu5zCVTaQZeBabeNqDG9ST94qmZv2hK5HmmXoje3VhP5NMYYKoE+umRVTNAvCifxIX4uvB+/Y7rXZ9wQyDL2rVnJ60vBxZemmxiEfgbUM4We+CMyt+6MILjmEhSZnMh5jYKNKNfKmjgNwToZw6qyvbLvwSPgQ+D/bk+M+stt7TSN0Q73Wlf1LWqO0RAeVjOC6vWua/uHZObjeq74xZY2Ldd2A0oIct9p2VysrE35fElPM2dbqKG43Q9FkBdPHjhsSZq9liXy+OhzdDEfCsnCWiBMCCR0iW8GDtq1/Ss9kcRyTTXo753GM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1602e763-d4a6-4452-80b8-08dcd3f8d0d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:34:39.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE3WWeb4/hjiwx6VWwyIfONQDqr1+w99FidSSeiUSvz5Wrw9WAJ/D9CoWFL5fEw8RfhweEnLnjBnzLSJEfdBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130095
X-Proofpoint-GUID: _EyxzuXr8fMLkmV0C0DpuwVn_zaSWwTY
X-Proofpoint-ORIG-GUID: _EyxzuXr8fMLkmV0C0DpuwVn_zaSWwTY

On 13/09/2024 11:54, Ritesh Harjani (IBM) wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
>> On 11/09/2024 10:01, Ojaswin Mujoo wrote:
>>> This patchset implements extsize hint feature for ext4. Posting this RFC to get
>>> some early review comments on the design and implementation bits. This feature
>>> is similar to what we have in XFS too with some differences.
>>>
>>> extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
>>> handling layer to do aligned allocations. We use allocation criteria 0
>>> (CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
>>> we try to align the logical start (m_lblk) and length(m_len) of the allocation
>>> to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
>>> sure that we get the aligned physical start (m_pblk) as well. So in this way
>>> extsize can make sure that lblk, len and pblk all are aligned for the allocated
>>> extent w.r.t extsize.
>>>
>>> Note that extsize feature is just a hinting mechanism to ext4 multi-block
>>> allocator. That means that if we are unable to get an aligned allocation for
>>> some reason, than we drop this flag and continue with unaligned allocation to
>>> serve the request. However when we will add atomic/untorn writes support, then
>>> we will enforce the aligned allocation and can return -ENOSPC if aligned
>>> allocation was not successful.
>>
>> A few questions/confirmations:
>> - You have no intention of adding an equivalent of forcealign, right?
> 
> extsize is just a hinting mechanism that too only for __allocation__
> path. But for atomic writes we do require some form of forcealign (like
> how we have in XFS). So we could either call this directly as atomic
> write feature or can may as well call this forcealign feature and make
> atomic writes depend upon it, like how XFS is doing it.
> 
> I still haven't understood if there is/will be a user specifically for
> forcealign other than atomic writes.
 > > Since you asked, I am more curious to know if there is some more 
context
> to your question?

As Darrick mentioned at the following, forcealign could be used for DAX:
https://lore.kernel.org/linux-xfs/170404855884.1770028.10371509002317647981.stgit@frogsfrogsfrogs/

> 
>>
>> - Would you also plan on using FS_IOC_FS(GET/SET)XATTR interface for
>> enabling atomic writes on a per-inode basis?
> 
> Yes, that interface should indeed be kept same for EXT4 too.
> 
>>
>> - Can extsize be set at mkfs time?
> 
> Good point. For now in this series, extsize can only be set using the
> same ioctl on a per inode basis.
> 
> IIUC, XFS supports doing both right. We can do this on a per-inode basis
> during ioctl or it also supports setting this during mkfs.xfs time.

Right

> (maybe xfsprogs only allows setting this at mkfs time for rtvolumes for now)

extsize hint can already be set at mkfs time for both rtvol and !rtvol 
today.

> 
> So if this is set during mkfs.xfs time and then by default all inodes will
> have this extsize attribute value set right?

Right

But there is still the option to set this later with xfs_io -c "extsize" 
per-inode.

> 
> BTW, this brings me to another question that I had asked here too [1].
> 1. For XFS, atomic writes can only be enabled with a fresh mkfs.xfs -d
> atomic-writes=1 right?

Correct

Setting atomic-writes=1 enables the feature in the SB

> 2. For atomic writes to be enabled, we need all 3 features to be
> enabled during mkfs.xfs time itself right?

Right, that is how it is currently done.  But you could easily set 
extsize=4K at mkfs time so that not all inodes have a 16KB extsize, as 
in the example below. In this case, certain atomic write inodes could 
have their extsize increased to 16KB.

> i.e.
> "mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1"
> 
> [1]: https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!J0dwKULbs9neFPRiUN1VR63Ea-Qgjk77y6SFN4GPBN2zqIGP46CDH0vG6fpvEMDFCq-O05CMePOn70hy9FA3zlw$
> 
>>
>> - Is there any userspace support for this series available?
> 
> Make sense to maybe provide a userspace support link too.
> For now, a quick hack would be to just allow setting extsize hint for
> other fileystems as well in xfs_io.
> 
> diff --git a/io/open.c b/io/open.c
> index 15850b55..6407b7e8 100644
> --- a/io/open.c
> +++ b/io/open.c
> @@ -980,7 +980,7 @@ open_init(void)
>          extsize_cmd.args = _("[-D | -R] [extsize]");
>          extsize_cmd.argmin = 0;
>          extsize_cmd.argmax = -1;
> -       extsize_cmd.flags = CMD_NOMAP_OK;
> +       extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>          extsize_cmd.oneline =
>                  _("get/set preferred extent size (in bytes) for the open file");
>          extsize_cmd.help = extsize_help;
> 
> <e.g>
> /dev/loop6 on /mnt1/test type ext4 (rw,relatime)
> 
> root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -fc "extsize" /mnt1/test/f1
> [0] /mnt1/test/f1
> root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -c "extsize 16384" /mnt1/test/f1
> root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -c "extsize" /mnt1/test/f1
> [16384] /mnt1/test/f1

ok

> 
> 
>>
>> - how would/could extsize interact with bigalloc?
>>
> 
> As of now it is kept disabled with bigalloc.
> 
> +	if (sbi->s_cluster_ratio > 1) {
> +		msg = "Can't use extsize hint with bigalloc";
> +		err = -EINVAL;
> +		goto error;
> +	}
> 
> 
>>>
>>> Comparison with XFS extsize feature -
>>> =====================================
>>> 1. extsize in XFS is a hint for aligning only the logical start and the lengh
>>>      of the allocation v/s extsize on ext4 make sure the physical start of the
>>>      extent gets aligned as well.
>>
>> note that forcealign with extsize aligns AG block also
> 
> Can you expand that on a bit. You mean during mkfs.xfs time we ensure
> agblock boundaries are extsize aligned?

Yes, see align_ag_geometry() at 
https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/

> 
>>
>> only for atomic writes do we enforce the AG block is aligned to physical
>> block
>>
> 
> If you could expand that a bit please? You meant during mkfs.xfs
> time for atomic writes we ensure ag block start bounaries are extsize aligned?

We do this for forcealign with the extsize value supplied at mkfs time.

There are 2x things to consider about this:
- mkfs-specified extsize need not necessarily be a power-of-2
- even if this mkfs-specified extsize is a power-of-2, attempting to 
increase extsize for an inode enabled for atomic writes may be 
restricted, as the new extsize may not align with the AG count.

For example, extsize was 64KB and AG count = 16400 FSB (1025 * 64KB), 
then we cannot enable an inode for atomic writes with extsize = 128KB, 
as the disk block would not be aligned with the AG block.

> 
> 
>>>
>>> 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
>>>      hint. That means on XFS for eof allocations (with extsize hint) only logical
>>>      start gets aligned. However extsize hint in ext4 for eof allocation is not
>>>      supported in this version of the series.
>>>
>>> 3. XFS allows extsize to be set on file with no extents but delayed data.
>>>      However, ext4 don't allow that for simplicity. The user is expected to set
>>>      it on a file before changing it's i_size.
>>>
>>> 4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
>>>      primarily would like to support atomic writes with extsize.
>>>
>>> 5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
>>>      inode field as it was simple and most flexible, since there might be more
>>>      features like atomic/untorn writes coming in future.
>>>
>>> 6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
>>>      The same has been kept for EXT4 as well.
>>>
>>> Some TODOs:
>>> ===========
>>> 1. EOF allocations support can be added and can be kept similar to XFS
>>
>> Note that EOF alignment for forcealign may change - it needs to be
>> discussed further.
> 
> Sure, thanks for pointing that out.
> I guess you are referring to mainly the truncate related EOF alignment change
> required with forcealign for XFS.
> 

Thanks,
John

