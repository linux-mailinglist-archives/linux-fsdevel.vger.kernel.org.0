Return-Path: <linux-fsdevel+bounces-44572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD82A6A6F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D6E7B184D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E131DF247;
	Thu, 20 Mar 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JGnrDsl1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p/eQK9y7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201046B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476639; cv=fail; b=unZqQTk5nbharIyvGGLL3IehpsoMnZ9ANu/733rXBtXRvelw9SHuBRZMflXiDG2vSz8kkcZo5ucXCJ+xTqBz2v83XZH+Y6+4JOy9JpLZWrVli9LmNy7OnSqRueItF0NBtzpDOeBvE5IinFij6rgVAL6UvWlTy8WV1bza7PsbEFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476639; c=relaxed/simple;
	bh=eSP0CAe9ZVCvO43U8T+affwXbTLPdg0t7DwFXt3k1DA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HfaM/JZvO2Ld+aE25Bin+urMlLaw+lfvGwM0UZDNIwvEda3ej09xJb9RJt9GhR/VfHO2pnc7LhFblqGloixpJHSCQAITEQi8mDBodCiRfARSctxTecVL2AR5sJkSbpumrkhC1xLncW5FHrJWaUuFXkgqCXGAyedeBY2+IHtw2DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JGnrDsl1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p/eQK9y7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KC3fIV023106;
	Thu, 20 Mar 2025 13:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rWmwrt69yazNg9/60zssZN9xaNuCKi/7qXaxBq2IBts=; b=
	JGnrDsl1c3P4ws0uT5ByZ/7YAfSAOk88VqX2w/tE6FBRtvIFfcqlfLY0cCiqFAgd
	KcUlEk0+m7k3AOV0VtNPbO4TJao9QXedF18XIUTESDnNS1LWJTrRkMeb/oxzWPHP
	iz6wBTT2x/lw0keqJozWefBeNHwo+ABTvs3eFaUrllogXkw0AGZq/CsIWRA3wDjc
	1+T3apekOtIEjEiLBPPlqSM9Vi3iNURZWq715EVRff4YEjSS81SYxNx5gi5fCyFW
	yv0e+EEa1dR2xsfI3eCQgZRxJk0S4n3ZE7/Bojxcnex5rFP76H6JGsCf0RzebPCv
	S8iO5ZjwvpoPOiidO6NRLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m161sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:17:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCj2k2024498;
	Thu, 20 Mar 2025 13:17:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbmd0fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWxXgI9jHdEW7BH1IVERkvPMovKU8+ZW3IjZutbPjZIIQ3DF6XIE1je2hHSc6LQH8tGLBk79fVhLrRJd/212IZ3h9VRiB9FI8+FYIP7br9BO0lCGEo7pzUH4PsL8Jcdvl8s278pX9vXve9C9vDEi3XvppPyp3LGI3OUl4hPS3yk+j1SkVVad+7tCa7FRY3abVFrq57xPNYVSGQcH/btqMugeX7i6lGcMhZ0bdxXRbHkK5nmJ0xDZzelHjEq4rZjlh+VVRQrVahvxORVZzSnAOyqOFZSGpQUGGHbnOGUeQovlzUPq/rzV0LsU3qtNecLFMLhzdJWEuN14UCgEjf0GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWmwrt69yazNg9/60zssZN9xaNuCKi/7qXaxBq2IBts=;
 b=ejZ5KnEpL70RAmQHABjuWYS/4OGqblgK1aEbRYLZFWYedCEqsoAq1kRNuJ1GTfPHk4DwlGBPPUmloKOURPcW+tbPoXq6LwZqMmz9/JFdLfqz+2S42Jj4RDczgtrCi/l907YIUJNrlv3Lf2nSyxZbwIvg9/VwLfsM1i/xyjmsZBunoFowd6+/ezVtgRKLPIDKdFR527qBl+AQweMRS3poVk7PMHJzLwYr/ua0gNcv6ZN+o7C5Vi63n6U45Qc1SrlKDAF4YojtcdUxnkAm+iocuA9SVYFy0AJ1o+pK4QDfu5E+9O8UJ+BUVc/Qzw20sBo4M9BLVZq/tVTibbKmCg9mKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWmwrt69yazNg9/60zssZN9xaNuCKi/7qXaxBq2IBts=;
 b=p/eQK9y7QswAJJJhOD8nQC7Za+3NCxLiMGUkbq0UORDAM5r127EVhbLorAPJ0U2povYomy212WeDTVzIzMoqQow+p87tRXIoMqAZxG22RRaZH9Db5ekWP2mzcjVZhhuqJbsOo3xVeH3ITikwf7meRfknk6p3JDK5z6MLnycPP4Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 13:17:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 13:17:11 +0000
Message-ID: <9293be50-d586-42e8-9482-62b65685335f@oracle.com>
Date: Thu, 20 Mar 2025 09:17:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MMBPF BoF] Request for a kdevops BOF session
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <61e45688-07e9-4888-855c-b165407b3817@oracle.com>
 <CAOQ4uxhcknKd3bA0FYqGyftweUOaEoR=oYzqHu_mvxn3p0AsYA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxhcknKd3bA0FYqGyftweUOaEoR=oYzqHu_mvxn3p0AsYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:610:10e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cb1cb0-26ee-4ddf-0896-08dd67b18665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGx3Z0lrT1NOSGV5MDVxUHdFbVc5aHBDTWhsczhKNko3czhIamh6bWIwSHFz?=
 =?utf-8?B?REo2anZzUmNMNGxnL1FyT09LSnJMWUJqR0tjSnVHRGR0VkFLNURsaVBXOGZJ?=
 =?utf-8?B?cUdMVHA1MG5Uby9XWTNmYklub29TQ1ViOEptR3c0dUpnOUE1VlNFS1Z2S3VV?=
 =?utf-8?B?aEI5czhBL1NEYjk3S0FLMjBKZDFhbXVnTlhvbTQxY1JRMFdqSVZBN3dYcEVC?=
 =?utf-8?B?eXVEWjFyZ3AwL29rcW9zVXZic0hnRlV1ZGpUemh2NkxtZzRrMTBpUjRUWGZN?=
 =?utf-8?B?UTU0b1d5N3oyQngzRFNTTTBMMzdNWThwODhlZ2psR3JsaTZzUnBCR251OEM3?=
 =?utf-8?B?WGMvR3NUY2pidlRScFdoaGY0RWdqSGlZaENlT1cycUl0ZTBCaHJReU1UL2lu?=
 =?utf-8?B?MUhhYzlGbWlYNmd1c0VVcVFSaGw5MEEvRnVRMTcxcXZ2MWZ4TkxCL1ZLblRB?=
 =?utf-8?B?YVhXcjduMG1DZDd6MEU5c2x6VU1Qbmx6YXM0RVpQN1hXNzBaZFc0ams1eHhx?=
 =?utf-8?B?V05LK1FBZ1Rac3JqcEd0TEU4ZG1qV3ROek9pUitxRDhDdUlnZ0VoekF3dElB?=
 =?utf-8?B?NWNGbGE4TFByUDJYZkhxeE5FOVJCNWt2cDh5STFLMHhVcU9oTmNLVjNrVi9U?=
 =?utf-8?B?L3c4NmFub2swSlRtRUhVYk54UWtEU2wxdXJvZzNnNzRDdDNWZlJHWExhb0xT?=
 =?utf-8?B?N2N6cTlBRWFhekJ1ZU43VUxrTEJ2VzFvN0lWYjlQZG5qUjVLa3JWeWZFb3VY?=
 =?utf-8?B?S2VzWHVsV2pDMW5vcFBQc1MrTmVPb0dqdE96NVpvdDF1OTlxbWEybmFqSU5T?=
 =?utf-8?B?b2l4K3hJUDBkaUdIL3RCNWkwWlkrWkxpYlVXSjlZaGJkMThCN2lZM0s1ZzU1?=
 =?utf-8?B?T2V6d09GcU9odUl5N0kzdTgrMlJOOUthb29iUnNqSUVxZndTS0xDK2JBaitX?=
 =?utf-8?B?ZmtndUo1aE5rU2JTM2FvM0NETm5jUWZrT1VUeERxRkdEYXZweWpTdXNvbHht?=
 =?utf-8?B?SUxsNVpKY1lwK01SdnhwU25xTHRZOUFQck52c2lBVzZtekRXajVKOWh6dHVO?=
 =?utf-8?B?WFJVZXZmN0NFNnRVd2ZGeGtMMkF5TE5sSjdsZ0JwN3B6RkJxd1BFbnQ1cmZF?=
 =?utf-8?B?eEFwbG9Jalp2cUhRWnA2OHQrUm5yZHQ0SHBlYlltTjhmQ2JFNmZXQVBHdWx1?=
 =?utf-8?B?bHZGZUcwUnVoSjM0TEJMWW02KytYOVhzTVRXVmxZQlZRWjdZdzJmd3lFWkt6?=
 =?utf-8?B?N1FwcTd6a0hoNG9JL3dPa3JlcUhnZDRFampjbHFaa3NEbmhMazBKbHBKNERa?=
 =?utf-8?B?eDBPNmE5eWJ5bnlnSGtsQXM4R3pwaFdJRXZLUVJ3UW9NOStiaitNeU9tUWps?=
 =?utf-8?B?SjM5N3dRcjFLeU1nSlBEUTBISUlqczU3SFNVNmdnTGFKTkg5cWQvMzU1YkVu?=
 =?utf-8?B?TzlubktFYnA5WkhqYkhpVEZpeFM0T2pQVnp3ZU14V3hDVTUzT1l2RWE0cUZm?=
 =?utf-8?B?alJwRTBqblNLZmlqYVowVWQvdm9ybWdpM0Y4OHdka05SV25pWjhjQWVWeTVj?=
 =?utf-8?B?dXRNZVlvRlhKR0x6THZiWnJFVkNpTXdzdnkzc0NGc1hzL3E0WEJtMVQyeXhK?=
 =?utf-8?B?bmU3NlVSQTNjWU5PcXYyaUN0QXZwRXhVekZ0eU9aWi9JL0tSalhFYTFwM2dr?=
 =?utf-8?B?Nm9Ib0ZJbUZTd1dSYlJwNC9HNXpTNlFNM3Brcm14cDNiZ0M0ZStLMTZEMERu?=
 =?utf-8?B?NVYrODlObGZPa0taOXZSRjhXZTh1SE5IYkhhbUtyWk5OcnFhbnpGdko5cjJJ?=
 =?utf-8?B?ZXhIRElJRVZGTGRLWk1WK2YwbGQ0VlBxSkY1ZitqMTlwNHJqQ281cDVlUmor?=
 =?utf-8?Q?sVkw/Cxx96pJg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjYxUkIwWmgzb25MRm9YUzQ0MnR5Q25TOUM0N3c2UlVrQWR5b0hvaXlIc0h3?=
 =?utf-8?B?c3ljbWptakI4M08vUENOenYzdlN3anZoZ2JaT2dPUHYycDdHaTl4RmJlRE9k?=
 =?utf-8?B?bHZwbnBxc2d3QnBVZHZOTk4vd3piSENPdUhNZ3dBNU1wU1ZISzZ4R01Rdlpt?=
 =?utf-8?B?OXlSUVhka1lNR0hsbG82RXVaRE1oUk8vSDZRNGpaNWxvbmtmdzA2QXZPc09n?=
 =?utf-8?B?UHp5Y0tZbW4yZlpYeXdBbW1aQjJ2NmMxWjNNd1psQm44dnFQbDFNZmFDZDFQ?=
 =?utf-8?B?NGIyY2xjNXpZRk9HSm5COWRRNU11cWJCTmVyV210cFJPZXlYUjVJMldudDJV?=
 =?utf-8?B?b21STGF6Tnl2NHJmQVpJcVIyMkRleWluNGNXOEFUeFFWTFB3cXBKUjFhbGM5?=
 =?utf-8?B?bmFqYW1lekFsU1lqcjhNWWJLNWdiWlNrYzFac3hCUE4rblBqbnZYdGR2R01S?=
 =?utf-8?B?Z1FoSnR4RlNnS0EyS3pMOXZ4MjQ5U3U4eHdNNm9VdUlZTE54Q3cwQU1BWnRv?=
 =?utf-8?B?bWxWZ0g3eDFCcUJVTTB4QkUvemcwZHBvN1RNSTF1ZWhsRFZmMzZDczZtWE9a?=
 =?utf-8?B?NVYyMnZLeVNCdllqcEJsVGw2SU0raXJtR05LeUNmOXB6K0p6K1lKTGoxUVpm?=
 =?utf-8?B?V3ZGcjlLV2xmSU95cm5xZVZxcnlqYWsxWXYydCtwWmpvcldlaEpEcng2TmQw?=
 =?utf-8?B?SC9iZUV2cVBpZnVSOXJJVUNlRGFaTEd1Vi80NkRNdHlaWkR2bmpKNXlOL2lV?=
 =?utf-8?B?dGEvSkJiVlFqSUZMMmNUL3lYL1didEk4Nit2Syt5Y2lWRUZBY0I2RnZXUlpi?=
 =?utf-8?B?VVlFS2phSmd3amZHZEczOVBxMGUyVTljdmJKRUtWcGU4U1M4NVUyeE5mak9i?=
 =?utf-8?B?b1VkSlM5Zk9sV29BNHlLTGg3WGh1NjZUOTZ1K29aSzhGK1FQWEdHT2dvdlNU?=
 =?utf-8?B?aC9jVWpncTBCVTlGejVnbHRtUW5xM3FwV2k3clUxTWN3Qy95VDV0NFVMWGto?=
 =?utf-8?B?T3AyMFpkMjNuSGlWcjhtUWFFM01JTTFpQitCY3BrbmxyRDRJaGhlWU9CMFdl?=
 =?utf-8?B?cjF5TVl1NUkzVkswRTJtZTUrb0NiMkVXL1V5NzlYVngzb2E3b1UwR3d6ZFRZ?=
 =?utf-8?B?ejdSNEJOM0tqQ2JsbmJMZjJrODZ4SW9qeEFBVHNLc1hYdEQwQytLNGJnb3M2?=
 =?utf-8?B?SklXOGJWTU5HUTBtMEhyU2NUeGYyYmV5d1lCMWduQm5OU3RiR0NoU1o1VkhM?=
 =?utf-8?B?eVFTQWtEQXRsa0VFN3pRbU84eEV0bEJnZDE3d09zZjRJbkNwdDEzakhLbUJw?=
 =?utf-8?B?YTZYSjlkMjBoU29zeGFvSjBpZCtlOFgxQ3FsdkQ2anJURlM0R2RrQXBMVFF1?=
 =?utf-8?B?UUphMEoxZkdvUGVPQnordURzZUo5cDRWYkFmV2ZJd1BuTlJFZmNuREtmQ0Rt?=
 =?utf-8?B?Q3dZL1NRYXVYUnNhaW1QaUhodnJBQjVBZGV4Q2gwelMrWHV2TkJXSWNJN0s2?=
 =?utf-8?B?c2ZjMkFndnpLT1Y5d1pobnBRQjBUMEtZem9tdmQ5R0xWdzIydS9Cdk5HSWdM?=
 =?utf-8?B?dTkrdzhzNFVWTEpKUy81SHAybHV0c2NCcTRHcHdiTmxwSkkyUjA0dDRRRldq?=
 =?utf-8?B?K3c4azdhY2ZMYzBhb3ZDWlpESzVPNmhGNm1rSFdDeWlPSzdzVWdDTlpQWlRa?=
 =?utf-8?B?aWlOZXJkbit6WjM2NURMS3AzSEx1aGtpQXBPYnQvSXE5eU1tSjV4QjJnbmwv?=
 =?utf-8?B?cjM5cUd6Y0syeHlveTdHeDZKVnRVNEYzb2hrZEFCRkk0V3RHdXNlU1o3c2Q1?=
 =?utf-8?B?ZFRvVDk3SDVLSlZweUlOb0d5WVhDRjJpRWRCdmZ5S0NSTGZJVndQWDE5dmdC?=
 =?utf-8?B?L3JwelF3ekNkUmpyYVpPckUzUXdMQnFranl6TUVjVGJMdldsVktpRkQ3bmZl?=
 =?utf-8?B?VmFBSzFWSFFhSEVoS2JuS2d1bDVHa05GKzMwWXN2eHRLZ0FHMHowQ0pFWFpN?=
 =?utf-8?B?ejZHT3ZVRTBMRjl5aktVQUQ3VitDMDZEQ2MvZVRwNjFLRHYxN2R6WFlJOGpE?=
 =?utf-8?B?NEFuY1NTR2NxNjlkREJBd3RKd3FqRkkvbmg4K1ZvT0IvTlZuTXg3QUg2MGta?=
 =?utf-8?B?L2o2NU84eDg1blF5ZUxZV3Z6bjVqYjhwdDA3bThCQXlHa2Z6TCt6TjVpM28r?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	57IcCqflxklVHeYOk5OLhXN+8GpsoH1VUihIoqwe1VU1bI1aP9u9HpC42RSY/ZXsPmOwg7txc10eN8e3u618WqgpmoR31qGXRfR6SjF2+u9VHNRzssUWQ6e3FLIv6OsdyhS0pomZaHFytDc7Hv164o2ehy+uW/aXzh+duRx4b129yraSZ06nbWm11UV/xn68mDZGmQVVkKepVJO9cTWZuz3usPdhh7Ou7YtVaPVhdARPoCgkb+33nwsUzM90HUtG+LXhB7FrJNLaLB2BE1XBNV4Mmvz8B+ht4SnY54fFASwfOHImXMxNUAA3SbTQTfa5S/YqXU+hD9tQ7SOTaD6SP4eqc0q3omeo+hhG4pQqfe69Wdy5nMbxZoeMz4F4n2jCHb5aGlMz6uXhT2gsT8Il2e0CBLUibxWTGGzXbgfWbIFaSvfK0YcaTnddBEyZzyZ0/TlbpmffoCqyVrqGu0poElZVNEtjhlq38ZufEkt28AdzS6G4YydFtd2Q3MtiOody++oHR2Yv2qXQg9FZZfPnX6k7MStyKTBpsYUDSj9onScmPUS+nvEtnZSki7MPPtQElI0ENOxodJok4SYZEoTVSW5sFQ6vu5eRjZHK9vFP5K0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cb1cb0-26ee-4ddf-0896-08dd67b18665
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:17:11.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDmZ2TuaS0QBSfmIUgsAIMS73LIm61Njcp9dh9N8h4MPhQ3f7NNSmIIrSSiDR8M9eIEkpzyJiOLEY1qZhYh73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=973 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200081
X-Proofpoint-GUID: SOLZEo2IuwStCLAm1o8d25W1vHu-YFED
X-Proofpoint-ORIG-GUID: SOLZEo2IuwStCLAm1o8d25W1vHu-YFED

On 3/19/25 4:39 AM, Amir Goldstein wrote:
> On Tue, Mar 18, 2025 at 7:21 PM Chuck Lever via Lsf-pc
> <lsf-pc@lists.linux-foundation.org> wrote:
>>
>> Hi-
>>
>> I wish to reserve a BOF session to discuss kdevops.
>>
>> I've been working on a proof of concept for running kdevops workflows in
>> the cloud, and I'd like to give a 10-15 minute WIP talk on that.
>>
>> I know Luis has been talking with LF and kernelci folks about how to get
>> community funding for testing efforts. Maybe he'd like to share a little
>> about that or hear some crazy ideas from the audience.
>>
>> Other related topics?
> 
> I scheduled your BoF Tuesday afternoon near other testing related sessions

Thanks!


-- 
Chuck Lever

