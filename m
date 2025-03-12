Return-Path: <linux-fsdevel+bounces-43782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF3A5D7F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAC33B41B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19E23236A;
	Wed, 12 Mar 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i4puZ/iV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FZDYi/J3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83120230BF4;
	Wed, 12 Mar 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767260; cv=fail; b=Y4A6nsWs4Q74tkx0DGnA9K0nnxDZprwJkVypbFPXoO9XUJwRxK87z3j228sv46BcZRo7TWFrFubq9V5hf1Sk3bucvpzZJbLUvRqh5w2OF8hjhyT7ULxHZfG/VGAG+1+ZrskVfJkGxY1cNEEETyYfh+29vnhdiGHEiVkIxjnRaKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767260; c=relaxed/simple;
	bh=aqz1L/GTtzlDWQ2uFcgUOXck+AjILcgaAuFNeLTPR7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXonsCPykisC5TJE5ZGLN2rZ2Bz/xe9cqy5fxkcbovp82BuadlZIdzsmDkHKKvEugc2CiLc/88rFJu4H8t1CxO7LGQtK+ChyT08JNaYIrnc2rQtjB9ecRn3WgG2sCqLiCma9T54h0UNtbFOP46Ehxms5eVy3UAjkB88radDEmOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i4puZ/iV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FZDYi/J3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1g14s000706;
	Wed, 12 Mar 2025 08:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aqz1L/GTtzlDWQ2uFcgUOXck+AjILcgaAuFNeLTPR7o=; b=
	i4puZ/iVPdb3JZkY2xAhqqSsy529lWjafleeVigp1TicVpoceemIKVLf5b0xcNGp
	ZH82+xd0PlX1iGuEjMK+VuNUbxKx3kwxYWP27GopIQC6ZAZ5KLMhXiGCY11Fg/eY
	R0eQtNbYO8pkxAjr+rGpbLe8DS3oYsUBT88kyxULt2luAtPAQaHPVrD3MDVVaVcS
	wAMvW2TU0zrRaPGJUBFvRZ7VdjR1DdKHNkkf8tS1P0AXzbQC5+l8+GbUVhU+7Wbz
	1hx0OYy8Qzy24YHegQep3js1a83EhH9pDYluRJ7bJsqfjkzxfdXm3l+QH/zyYZ5q
	DYfT97essKl0YWhnDXXl8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vh3ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:14:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6lIG6002320;
	Wed, 12 Mar 2025 08:14:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn6y52c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:14:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMmeklDh+VClHddEx0drJ6lKrsmuE9PRN0zHe/icSvvx0ACxS/DrqYR5gAXp8tbqQyiAJUGcUFC3InCaS2YcXCHFCxfbxQDeTzHL7EPWa89fFohDi4q9QVKMjdnm4ULdDNC+X6SnTcxDH9Ws+d4mJpO+stV7Hjy3z4jq8db7tHEFu9EemTwdIfDSPuVOX7kbjBmmMZy4ZQ6a35zvYe59sCavFCNCDcWd6tQZiV7qYXdrZezqjCUm3HbTejj23AZzZ5+dZtK4kIkqrPhug6OUcFl5tpzTk0bl1+1m0kafG9RKkWo7Wmc3RxjERBpWfuX+Yn3AuBcpvIoxoBGaVPh66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqz1L/GTtzlDWQ2uFcgUOXck+AjILcgaAuFNeLTPR7o=;
 b=pxZQLeYCJXZ3S53ZSutAIxCONuFTlZqknw21/+iXLjaOtvmACrK73Je9iMuaOD1rQT01dqkNQ6yNygX1n+uYiM2UCcGUieBTj3ZBYuuXwIAWjpJV4GlPcI2vGYH1jxznfunw8R5Bs7JjD15ybgyhyMJ3JcOcPMrcgyHFToKhbdbjg644uC41BcYVAA5WuVdMVr+Efg0+pLmFKPf+ZLK1XSC71eMiauapNo2+LAiE7ogOWkXRfTDuPm/oSJGEFXDXuy0Ad4dSyYU/nBFhaqYIsnrVkMxX+/yD6+u8+s3Sd8vWKoqzgaYWHIiurEFlH3fRGS6ZTbaqa/5i/+Z4/ydc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqz1L/GTtzlDWQ2uFcgUOXck+AjILcgaAuFNeLTPR7o=;
 b=FZDYi/J32jVTZC4mkbXlmmbuKj6xLIx9yN2oLE4/mBZ11pN/GkknQsuWPqYvxc2ruqfvwsk1K8vQs26886uqK2u6YIRIuUAsO1tnSwQA+hOWuIYoa5+T+olTE7Vibn0/Rmhd3iPLwbJBZOojAMWXbiob23JVTCBXFSqeC/FL8Ck=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6726.namprd10.prod.outlook.com (2603:10b6:8:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:14:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:14:06 +0000
Message-ID: <346315d4-dd8c-4ccd-b42b-081bebf2a7c9@oracle.com>
Date: Wed, 12 Mar 2025 08:14:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] xfs: Update atomic write max size
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-9-john.g.garry@oracle.com>
 <Z9E6oMABchnZIBfm@infradead.org>
 <fb6f286d-19b5-4f30-ac0d-799311980521@oracle.com>
 <Z9FCMwZTzpmwsw1W@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9FCMwZTzpmwsw1W@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: aed406d9-5358-4a2a-9197-08dd613ddbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ykk5ZjJZdDFHS0I2dm9mUXVSZUZUeS8wc0ltWnJUZGJib25rSXdpRjJ2RnQw?=
 =?utf-8?B?QXBvcmZidDBEQUFGR3hWaUE1NmoyaHhZc2ZxNGphYXRvUTRCbWhRZFJ0eWxk?=
 =?utf-8?B?SVduRm5zU1d2U3h2S3lrQ3lMdU5majk1UENRZEY0czFsVXh0M2hydTBPQzND?=
 =?utf-8?B?L0VFVGVRcVoyVHZ4aDNLaFFxRFNKUXRNZElTb2I4cmc5MDFmZkpoU0Y1Tldu?=
 =?utf-8?B?K2xxeEFFZHVsNi9GcWR1eFg5UzRhTFBCT2lRKzJmT2RSQTRRMGJoSWFOZ2l3?=
 =?utf-8?B?cU95YkczYzRON211SGdyM3QwbmM1MnlGWXNGZE1HYnhWSzU2c0VTM0RFZ3hw?=
 =?utf-8?B?d25WemhLSGx4UTR3amRGSkJERUN2YW90NUk5L3pwOWtEYXZpSmt2T2t3R2VP?=
 =?utf-8?B?MHNqTHMreGtVRVhkVG5QR1R4Smp3bll4K01TOEhJdGgvcmlyNkNmT2lqWUpo?=
 =?utf-8?B?QUdRcjJxRXVObldHVEszN2tkbmQwODBPWjBCb0JWUHFESjd1ZlNyR01WRGZh?=
 =?utf-8?B?N2d0NDlvNzN2Q1Q2TWluZE92bGRyMW1mYzBQV0puanNjYnRUL2hzN3JvSFlC?=
 =?utf-8?B?Zlphd3F6Tm5YeWNsaHBQNllLVUFvbWRnelZHN3FkakhGWUFycEUxT1ZCeTl4?=
 =?utf-8?B?bGczSHRwSUs3MTVCQjJzVlZMMUdadTcyR0RENER6UURDWVFlOGdNcHh6WnI5?=
 =?utf-8?B?T0lxcFRSSzAzWDFHc2MvdFc1RmFPbHRkWXhDZ1NRdEZ1TzNhOGord3dDQ2hq?=
 =?utf-8?B?eHRXSjRNbVE3TjNjRVdWa29JTjdxdkhMajFBaDJUZmxscUdTb00vemg5RklR?=
 =?utf-8?B?R1JyZEVOQkdoQ3VwUWdVSkpaZ2xDVE1mQ1QxWUxGdjRuWEh1Qzd2OE5QRFJk?=
 =?utf-8?B?NzMyWmk2SEl0RVpQbnRRSkpFU1R4bjhBdll0MWJBREtMdWRaY2l5Z1dVbUov?=
 =?utf-8?B?aE9rWVcya011Rzh0YmZQNWh2djdlOVljcEc3RWtnSVBNaTgzUHI0UmtDR2lz?=
 =?utf-8?B?aTg0aXRMSFpmOWMzUnlqY2E2am1PZC9OWG9IZ0Y0cHQ1akExc0JrejZoR3Bq?=
 =?utf-8?B?V2U4R0VIWkhJeEptOWFKWDVFMzY0MXFNeEJOMks0SDl0czgxZTlacGw3d2hQ?=
 =?utf-8?B?Q3JhU0tLem42bHRtWDdPbzM4SGd0Q0tMU29PZUFnemdKdFkrWXdPZUVuV1NC?=
 =?utf-8?B?dEZxZUgxa3cvTVlVS3oyZzBwN1EwSDVteUF1aUxRRzBtRjZQOG5KbkJUQ2Jk?=
 =?utf-8?B?dFhWc3lDU2dHZllXZUZ4ZmJ2R2laTnQzNXlKcVBOSXdhejlGam5NZm8razVQ?=
 =?utf-8?B?NFRTZW9mRmppMFFNVjZVT1ZKSFJDVHM2UXFCRitvaW1lUE9oU01raG1ibkd6?=
 =?utf-8?B?TzNjaHFHVXhzeWlqRDUvMGRjK3VzZXpIU1hNUndDbURaUWlYdlRsM0ZHU2ZI?=
 =?utf-8?B?SS8zc2MxM3o1T1l2cWV2cURNT3NSY1RlTEVPbmtOZWFqYmpNWjFJZUZxK1lo?=
 =?utf-8?B?L0RyMG1wTVAwbFdyU2lWNDcrd1VreEFyTEQzR21TZkRXRW5SbllCQmFiMUJl?=
 =?utf-8?B?blp5YWdJQU9UelNvQ1FONlhQdXVSTGJ6Y0w5bEI3NFVVRjRaUFNlSGc4VjNM?=
 =?utf-8?B?Ny9PaFhwTk1WZWFQVnN2aVRLbGEvT3c5dGsyRmdQUlRKV2xrdHh5R2pkYVB6?=
 =?utf-8?B?NzF5SjRzTUplcmlKZm9kUmxPNUZ2N1VzbXFJUkVNQWg0bU1NWDNpSDhnc2Zy?=
 =?utf-8?B?cjkwWElPZElFMUVOS0dNQ2t4R0taZ0pxd3ZIM3hLK0J2eTdTSkZqWStpZUYx?=
 =?utf-8?Q?oXyIz1WG0sz9S33biW4ry8fRhRBp7hssfzAjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJwTnV5NWI4NDBsMGxydUdzOVF5YnRpVnNqRHc0bTk5ZFMxWW9SZ01CSjdl?=
 =?utf-8?B?ZW43WGxPWFgxNjZiZTZHbkp4QnhjeUtreHpPcXlsdXpZSE9PRjdRekxTbVc2?=
 =?utf-8?B?VWZPdjRPYWIySXp6Mnp5c3RVR3ZUeVBjamFxTSthSDNpaDd6MEVEVklkdE5L?=
 =?utf-8?B?ZmxDRG5mNENqVWpMeUliMUdNaXh6ZXZtTlB4TEpOY01aaGFTbm1EZmtGM3ZL?=
 =?utf-8?B?Nnd3VkxsSTRiRXJjVmxsZWtTZ1hEa3BkeTJUaFBQMytpSUFJN0UyZVpNM1pv?=
 =?utf-8?B?RHlUZE5xd04wbEVZTTk4UnY1WmdMZHRmRlR1TXlCbS9tdG5LUDFKNk1jdGNk?=
 =?utf-8?B?dXNzN2hxWnNwUXVDM2NkalhSNXBySDBjeFFGWEIxSkxtNlc1WXFkaHRlTlZj?=
 =?utf-8?B?MzRNcFFKazZqVFE0Z1UrY3lJTFUxb1ZKcEZ1WmVPdEFBZXJDTzJvb0pxYWl0?=
 =?utf-8?B?YzhlZFErbUhZY0ZHTnJKbDF6Rmt1cGMzZ3hTUS9YQ2h4RW1QczRST1ZRRjQz?=
 =?utf-8?B?NXdYWUs5MzlsS2dFQklJdFNhdmZrVytLZ1FDVWx0VmF1UHpVaFVWZlhzb1Js?=
 =?utf-8?B?NjAvcEV1MlRMRzd2S045TGtWcGpheFFQOHhYQ0xkUHdHbzRqNlJzZ0dUUTFn?=
 =?utf-8?B?TEpRaEVEMkVkUS8rNUtRcjVodXRTWG9PdnE2c3UyY1drbllNSWhENU9nUDVP?=
 =?utf-8?B?bHc3K3BXS1Zna3JSdjNKM1F3bkNLaFcvbVZxNWxBSTIvUjhMb0xHTlVMRm5H?=
 =?utf-8?B?RTZMOWZ2K09rWVN4K0txY3B4bTdFdm1qN0trRkdNTk52dU1KMjNGVHVPbHBr?=
 =?utf-8?B?Vzl1cWFlR1FMNm5PanQxaHNXc2hvalpMSHM3eHNyeHBmSkpOOS9oVUdnb0ht?=
 =?utf-8?B?YTJTdDJSKzlRUys5RWZkelIwMTRqMkNnYkdTSVl0MFR6bDhiUDAwM295RFBy?=
 =?utf-8?B?czdvU3pqdWtCcStHRVVXeEltVUhtejRUT1lQN1ZJQ0NWMk5BZXIraDBJUmx5?=
 =?utf-8?B?dDkzbDNzd1p0R2xpa3ZRVEZrNFAzbEhTU2drSnR6MFZqZGRvZVQveGFvRmRp?=
 =?utf-8?B?em1UVGZ4Umt0RVVqN3IzeE9CeXI3Mm5jTFYwME93azJuWE1nU3FBblFuT0lH?=
 =?utf-8?B?WnYyT2czbUQ2TjNUS1RyK0tob2pMbHV6MDUvVHozNFhUZ2JzT2Y2LytjWnF5?=
 =?utf-8?B?RFZ2cWV3T1BrTG5uZWJTTnlUcXhtTEJkWU1lYUwrbUUxMGhuZVNTTGRjN3hC?=
 =?utf-8?B?UGZ1RmExeVkwNjJCN2RNYUhZREN1bmFiSDNBQmtyK2ljcHdpMzFyRSt4bzY1?=
 =?utf-8?B?WmlzMXRyVjhGbFFrazZnSjdQd3Eyb2pyaUtSTGI3UHNtd05aa2NiUVlIQXhr?=
 =?utf-8?B?Wk9JK3RSaUJXK2xiL1hZTTRhbmJUeEtDSjMwZ0NsVWVqblZqOGhHNGJZbzV2?=
 =?utf-8?B?NTJRVERWR014MDNCQk4zeS9XVXNEN0JpRENOUmQ3elhJN3d0WVJIR0svNFc1?=
 =?utf-8?B?NzlreWhVdW5mUFFUeHU0Zy9sWmdyVXBkdnVwa0VMK3VnUG5qUkR6QlU4NlND?=
 =?utf-8?B?TEVkd2ExT3M5Wm1Wekk2WDgzcXMxVGRzQ2llQ0xhbm1aMjNHbG5ZczU3WWpP?=
 =?utf-8?B?WEsxVm9HYUVWNktsb3ZMakRDU29ScGdOUG5oNU93WC9yMlhScDR2WDhQMkNw?=
 =?utf-8?B?MU9oT01yYkNmdEtSNUlRdWk2WWpXN0N4MkhMY1MyTldXajhWOE9UZERzT3h5?=
 =?utf-8?B?NFZhdHlmay9FQWIzVDdkQ3ZtTDhaMlhFTm5PeUdDcER0YUFWREM5UEkvWXI2?=
 =?utf-8?B?ZWdrNmNRZEd1SlNvYzY5ZnN2L2c0NFB1YkhQaHgvRXAvOGplNWtCUk53WDFm?=
 =?utf-8?B?T3NFdVFOQ1RJV0UrSENuOVRRQ3Bic2tWYW96bXJzVXVzRDlNL25jckNWR0xn?=
 =?utf-8?B?aFFNUHM0czRsS281QXNmaFF2U0d1dFV0c3pSWTZPNkhpeEp0SEsrMHovWDZq?=
 =?utf-8?B?cmRGclB2UDMvUDVhSVlDeEpTbUJ3YUs0N2hoNEcxZVZTMEo0ajVBN3BKRTVQ?=
 =?utf-8?B?YVR4eW1Ea003SlBUcmY0Vkh5R3QxOFZGNFBZR0FwcWpyYXRydUJ6TFk2Yk5D?=
 =?utf-8?B?YWJIVGNTN3dnSjhDZ0VJYUR4VWlqbEwySU9EeTI2aUQwcVo0aENWbTNucUZW?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GVBCmwsSGgt+6b2p+EuOPrmeYviSZSYjTIDFwEqXTP9UaSRpp9PV1IP8BfF+wh1EAg6V+SJA1lp5x0uImukdQM28QJtT/kAtolrjaoC7oScKaBSVWV05R4LPOIbDEheA4NiaJL1sbwYRuGwKVrwoTikj2HgajEfqXUeNn3efQh7bJmEYFJnSlPsKCTQqXy933KMyL+fbIOJAhPSytJAFgbOfBPOzCRo65XnrdivzKIdOvhdiFwasP5V5OhwdGl58cnLFXBInJcDVWmNd91cjZ/NPXQgCLuLNbSlo5Jg9ZX7vhsCzuDmVpKoyl7bN8BbWIxp9R5kE0wC1Y9+WscZ3WLT+kFwMEtQ/tQwqQYRwC7OFK0oKTi6+bcN6NISdJDt2nDvsUNvCtEh/CFaP8V7k0aXtFTAERAgcFiCLuQZSFid76sxhGny0qXtudUmO5UPy26O5iDUimQsIwXoQDzR2D0e6udV3RsVHBfmmfHHOwv0louql3vXgPygzbkHjp7bSqYjYHcmP0wCpWnQNVRfp0JG0AwFITJFiuTqFkoRAdTKrThUN/sxNOZYIgMSLNjL0TsrzkC2Om57T8J9UZApf8OPwyxMyfh13/JNSi3J/wiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed406d9-5358-4a2a-9197-08dd613ddbb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:14:06.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZGzinWrytMpYlAx1NNG7JiV6RkHvx0/kxrUYuySlL0gtHw8kJIpxrnVXOjjdkRyDXRefCXdXr+inH0vC4Z8GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120054
X-Proofpoint-GUID: vqaOgPiQJL6vEiuw4P1yN5DN3D_6Xgke
X-Proofpoint-ORIG-GUID: vqaOgPiQJL6vEiuw4P1yN5DN3D_6Xgke

On 12/03/2025 08:13, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 08:09:47AM +0000, John Garry wrote:
>> On 12/03/2025 07:41, Christoph Hellwig wrote:
>>> On Mon, Mar 10, 2025 at 06:39:44PM +0000, John Garry wrote:
>>>> For RT inode, just limit to 1x block, even though larger can be supported
>>>> in future.
>>> Why?
>> Adding RT support adds even more complexity upfront, and RT is uncommonly
>> used.
>>
>> In addition, it will be limited to using power-of-2 rtextsize, so a slightly
>> restricted feature.
> Please spell that out in the commit message.

ok, fine.


