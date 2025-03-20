Return-Path: <linux-fsdevel+bounces-44570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DAA6A6E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A2A3AC964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575917996;
	Thu, 20 Mar 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AabEugfG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HVkswHR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83833CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476349; cv=fail; b=QfbLssJ/6pVEZJtb52r1N1HMWmM7bS5OPGNR0bgxy5xmaPKukQPXkSwJsKoogS/A8Ln6E5q1nYyBUeAcWNGRCkLVkskJ47MvzLin2RKcQFzh4iGxa1PJDq5mWT+YnTXaKJDvTJ5TpSrHvhrckLKPsT4uxhsLl/hGSjL/Ks8GoVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476349; c=relaxed/simple;
	bh=fVIYbokuAUr1/ge6X/XjUJSmHHcrogYrkQ/Ue4s/tr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cHffu0AAeR3347vQFRYtBExejQm9/mHhEB7vMnWPs8DX5xVpUZrwSMxwpXBCJi3qGQfnO20Gx/5+eWL8fF5Y/ImbOc/TXeACKwnuTXDeJD7UpVc0+fAU/iaDBwgR0BVMqbGuSwTqpJfjHxvCn0WnrINmegDfikt4DUK6TyT5fDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AabEugfG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HVkswHR4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KC3cpC005282;
	Thu, 20 Mar 2025 13:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LN3vyHHji5KOVdQjHF1YcS73M4hZ0Ze1kLxKMS+bitY=; b=
	AabEugfGgqqsHJft7whs953caNOpbECpQwd42BEGWCqlnpkGHj9JA1m+pFfKcmup
	qzvMPGPWTMHIzqJKQZRZcoylamSusF2S8MFEOf4eQnk+DP8OUo0AU6VriCw1uhfV
	x5oBdt9uZLzU5VZg+ca1eteWZHpoEJeEdtJjQPFLg+PGM86h5wPO5TF4r4Wyr+7E
	UXDB+bTUgy0eN5TIFcVHZckQHFeCJcZTHmudqQxA0u2CFBpR5SM0ZdHVwYiLTfxd
	bYscC9yHczrhsVTVqu+5UEQG8XsDmv+Zpb5UxYFv/7axm/muxzgZTTDvfmy0G4b6
	kSW6+aWaLNvukUTxVYLdNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbe4rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:12:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCkLJe008914;
	Thu, 20 Mar 2025 13:12:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm2n7m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAdCv4VzMJMM3oEb+hRVCjZxtn8tKhZJ3ggGrWDpGVpyyC9D91hiIGu+7dkLmikA5syuPnWQTzyQJelbdKLBm9IYeQXw/wH13ZQ8P6i0rwZUIkDF/hho+MHMfWhNw/cCCOBqyGxLJgSxGC4OKhYWH84vAB1R4FR7c4GPnqqrZwsZH6fGH7bw1skblLTAbdkC/fMJm67lrVgSE9zGwp4UR27kCB9YVtlSjRgWmYFSHrnKxvTeLGO5kBiC2LnhDwvWZur3CEZqfGhkMcToxryXgEJ33iDePHVqlFqeazIH72L17CvvbN/VxJKrEUjw6LWrlQeQ9OC7Wv1j/2oQ/McvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN3vyHHji5KOVdQjHF1YcS73M4hZ0Ze1kLxKMS+bitY=;
 b=g5r2Ja8NWCXYhw8mcCt0+Zvyzt3Fe/9hSlYz9fGn+V5lB/fdUdSsAt6PosFTB4AMh1+s+EyCnqp1Y8itFpT2+DVVAyHKcuJxp6fteGKwiZthiKseOsOplJfjvVs4lQ/sTNjqeXG/IpQP05Bcbasw4Q5qRKu5v9xMNIPmzzgK9YUKwNsjJGcjeS/svBvf242HXnyMxjG2iXYzS5HRlQ+/oC93BtXn7zP01RyZ7ir+3rkYmEFslytjN5U3dWXI4nUzSdMUmqLg0f85T5s0DEYMW7IX5u41BkcyhCXEZRzUT32rGUht+pKBvraMXysonwxNiAsGOavlj1LqDcDFbiS34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN3vyHHji5KOVdQjHF1YcS73M4hZ0Ze1kLxKMS+bitY=;
 b=HVkswHR4mjV37oqdd1s9hWTLIX03t5KiWi5KrYrWNQQYQrSvSgvxfhynREvBhNfLmNtaQ7T2Zk4Lcd2M9uDl98hWkPcfeL0DS03JjOLxYJfxgCSlzZRC5Jmt3XvwcfVhus86zj3sbo7THlxEBRV9whSqes87B6DxF8mXwVtfAAQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 13:12:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 13:12:03 +0000
Message-ID: <5fb2420a-b740-4d2c-b002-2950e810f7e8@oracle.com>
Date: Thu, 20 Mar 2025 09:12:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libfs: Fix duplicate directory entry in offset_dir_lookup
To: Yongjian Sun <sunyongjian@huaweicloud.com>
Cc: yangerkun@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-mm@vger.kernel.org
References: <20250320034417.555810-1-sunyongjian@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250320034417.555810-1-sunyongjian@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f61f6c-6339-4b11-c071-08dd67b0ceba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVsbmF0eEd4ZDlmMXFzUy9lQTlaczdPZjh2cXlhTlN1OEFoelNVNm1Jb0cw?=
 =?utf-8?B?MXRBMWxkZTV3c1p0ZmVTQ21ONHV5SGIzMGFqNDkxeGQrRGk3NFFZVGwrbWxB?=
 =?utf-8?B?d2ZIdVZuL3BCS0h5R0lqcHRxRVZPR1d3RjVvYkt1aDBna1hTYUhSd0x0RmVK?=
 =?utf-8?B?YVh4RE1IaHlweDc2MkI3b2F4SEh6cU5KSlU0V0RlbGZBYUpMRzE0c1JUSmZF?=
 =?utf-8?B?T0EwUG5sMVU1SldJOGJXUVhIeTlaN3RFK3oxR0djVjBxcEV3a3dmaGVUWDhC?=
 =?utf-8?B?UStYMm1TUUhRQzM3Nk13d0lsbUJUMURyMWNYLzZsWkE4N05BSjhwakNLemFj?=
 =?utf-8?B?NmhlRGlCb1dqS0wyTFUzUVVDYXNNenZkMDE2cFI1RVVEeUljYktRaTRXaGJz?=
 =?utf-8?B?ZVpTenpRVGF0ZWFROUpyYjl5VlZseUVySDdKVjdMOTZJVWZ4cnhWLzBrTkhV?=
 =?utf-8?B?Y1BnZkRwTEVqZEpqUjFHYWF6QXJRdTJNMm52WCtTQzFUbU5PT2JKS0VEbVhn?=
 =?utf-8?B?VkJDUkVYQ3BpVUhQUGE1U0M4QnJjQU9wSU1wNG1EQlMxS0Jyak15K2xJRTdj?=
 =?utf-8?B?OXJlVU5KRDVxSHVzdFB4Tlc3WHovYWhXVVdPUFp4WnR4czc0MDRhSGJCTFd4?=
 =?utf-8?B?eXFJLzdHdUgxcElVemQxWHB6cGU3b1hJcFdWaSs0eXdpRkdHVFE4SmhYeUw5?=
 =?utf-8?B?YkZRaDVLdEFXcDMrNnFyaTluK1FnM25nZFMrS015OFFqNGl4dVpLWHBTaSsz?=
 =?utf-8?B?WWRVNnJ3L1ViMEF3d0t4bHNOUGpmNDNGOW5kY1hoUXRHQUlRTDZRd09wajZq?=
 =?utf-8?B?WUhRTWpDWEVvZnd1UCtVUGZxblBVY0ROelU1R29YdG5nTmZ1Vy9aYzdjTE9B?=
 =?utf-8?B?MnZaeGVkQSs5bzcySDdHU21WTC9mZ0V4UmIzRWNaS2dKcHZHa2o5MDZwa1Mr?=
 =?utf-8?B?RjJGTi80VlBha2RQRStxT2kzaFFpTG9tTXZDbERLazRkYXN0bnpLNStRT2Vp?=
 =?utf-8?B?Z3dJazNpelVGUlFKS2g1VndBQTlOWEZyQnFJM25OWmgvOTMzZndTeVFYYU91?=
 =?utf-8?B?NElKblhLZ0Y0ZTBhdWMrT05IckM4NHE5M0Ixak9qYzFaenlJYTU5ZjZIWjRW?=
 =?utf-8?B?SnhRd2RMWVpTaEVjQWRpT242WHpNa2ZUSm5OdUk3by9rWVArazhMZDhoMlYv?=
 =?utf-8?B?NHRBOWRBNzVyZEFrUTB2eVJXaWFzQTZ4OVAyd0Y1ZGYrQXNnNHErbGFUUHJz?=
 =?utf-8?B?SWxhQWVuUWtnQkRKVjFMSTRyS2R3eEtqdVJ6cThKSEwyM01nbi9TVDhXV1Yr?=
 =?utf-8?B?YTNOcVg4amRVd3VzUkVyam5KUlVMZlg2WW11MktONXZSMkE3QWVOS1p4czRF?=
 =?utf-8?B?NEI0VGtQTzVvbTR3MlVUeHphQTdvL1VKVTRXQk9iSzIvN2g5NUFwVHJFYzMy?=
 =?utf-8?B?Y3hIaU5Fa213VmY4RnFXVGVRSlNPZlUzdmJUWGh6UFM1Um12MS9MVzMxaENq?=
 =?utf-8?B?b3hsSi8ramh5RTZvSk5ESHFTQXZreWZvRjA4RTdKSE5PbHRGbXZET09rNGI1?=
 =?utf-8?B?NkJ4eDJxeE83d0wrOSthdCs0dXk4MUc5UVloQXgwMmIwS3FIZEFRdUdwZ1Ir?=
 =?utf-8?B?Y0ZCZUhnLzRiZDdjVXdhcEd4RWVRWUpXRnE4V1BrMS9ScUZaRGtkZ3JvZXF6?=
 =?utf-8?B?K2dwUEJidFF6SGNHWVlVZ2NQUm5WY29JWTlTTkFWY2lhSnBMTTRaRkpEUG1Y?=
 =?utf-8?B?RllyNTlsS0J2MVVHVkhEenUxWGZqWlBwZFplN2xtcUZYSFIrdEpubXFtRTIr?=
 =?utf-8?B?QWhQYmNVbVdxdFkyWCtzT0I4MStuOEZNVDZEWmVJOCtrYWhCYWkwUTY0RVh6?=
 =?utf-8?Q?0ILjHynSEOv/t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHdoazBPM0lzNlh5cVg3cnVvdk14ZElXbWJocTZlc3hSZjF1WnpwbGxVaHov?=
 =?utf-8?B?RThXTUFnakdJV3hrbTRDQVhSYTltR1IrTWtnRDcxQnZ0R29sYTlneFNpc3RC?=
 =?utf-8?B?SmlpcUhKR3pUMVVkczlMR2lYTU16c0ZZOXI0SlUvNHlBRGZUM3F4bnYydnBB?=
 =?utf-8?B?Z3poREgyMHJURy9PeVJjUjZrMEhSdmJTc0xCVkVmRCtxS0NUZkVWelU1eVJF?=
 =?utf-8?B?NEl1UjZzbnE3N2FaQzgxdHZVNm5IaU5JTWZXQWZJeHAza21sSU1lOTZoeXNk?=
 =?utf-8?B?L0dHVFBhNXRnSVJPSXVMd3ZZMUpFZHB4dHJEVmtOY2pwOTlSREdMSVg5bzlN?=
 =?utf-8?B?NXJOeGhWcSt6YnFEaWpCNFlnQ3l1NmVJOUYwYmlScU9qZ0dIOEw1SWtHN3cw?=
 =?utf-8?B?aXRIWnpJMEtaK3JTMzRadUdhcVEwRDRNa0xuZC9XMkUzNjNmRFRNQlFrVWo2?=
 =?utf-8?B?V1IxTmNlS0NvNlhzMHRlMVlHT1FKRnZUaVhSQ0dXN0hGQXFLckRUMWQ4MXFS?=
 =?utf-8?B?K1J2QUVMTHJWVkU2TDFvbG9wYzJjWnR0R1ZpaDFEZDQ0M0J6bVYzcEVoWm9K?=
 =?utf-8?B?L001MkhLcGxweHpKT1dWMDlad1hVVGtTR2pMcHNkTE96Y01NSEpFN3pjWG56?=
 =?utf-8?B?MUljMEVVdEJuMG1kcW1lQldCOG9UK1VyTGJTSXIyMFhhcWY0WW95WDB1NXBO?=
 =?utf-8?B?MEdmY1Y4QUZRSGJ1VTg3STlCSEdyWFhxaC9LNzB0eDNuaHU3Q0FQcFFHbkxI?=
 =?utf-8?B?VGxsTFNncGlEUUlDTVAwa0FmTUgyOVJkOC9hYWR2VjNoSG9zRGxscjBjZGVh?=
 =?utf-8?B?RjF1VUZ0d1A1UUZQZlo0SHV3OUlZUWNLVUtHTlllRmNjdXdtR2h3eEJ2cjRZ?=
 =?utf-8?B?eU45dW1MQ3AyRC90dnVZK1dNTWJibEgyS3VaMURIUnlKSFlkR0JwSkFMd2Ev?=
 =?utf-8?B?ZmVIeERRYXhMNXZuQndPUGtZTGRmQ2kvU2xmbEFVWDd6RVdjZWhZMXFVdUxr?=
 =?utf-8?B?Z3grVnorVmlta0VCbUFZbHdXSldDMFhYVWVmRUFUZHZEYmJ1YzZUb1I1WDFU?=
 =?utf-8?B?aW9OZ0h6RXNtd21WUVF4S0JiY25XaEQ5Tk5VSlFXZ1ZjSWJyODZBNTk2K0tN?=
 =?utf-8?B?a01ITWsvbEZtQ2M5ZnBqS2FsVTNqQ20yTG83U3FhOCtuZnpwSFEyNEI0K2VC?=
 =?utf-8?B?cmROZkw3c0FDVWd1d1BiYWt3cDdqUGJLZUlWNE8rVjVybzBqbGs0VTZDN2Iv?=
 =?utf-8?B?ZVhWTWx6N0JpSzJXSFhQb2huZVFnNWFLMkhyR29NVUE2YmlCZlRJR0xxR1U2?=
 =?utf-8?B?dlE4ZDIwOXV1bUVVcjdvb3B1cXNGUy8vN2RxcUhXWGtNN0RRRnFCOGsvZ3ZB?=
 =?utf-8?B?MXlOZFlFT3QyQlhqSTNEbUR1NXlNenh5aWFvUFkzYVJuMGZGaWVJTVNvNGNM?=
 =?utf-8?B?VTQ1S20xV1hqcTBSQkVTa3k4OHl0YlV1c2w1ZHYzQmZ1WFU1TlJWVGtKTVpF?=
 =?utf-8?B?QURXVXRreTRlZGV0ME0xamdQQkJ6K0JPalVEdjF3bVdrZXpZSEJLMDI3bC9j?=
 =?utf-8?B?bnVyUnNxUlFjTWNMODlMOCsrSFEyRFNVcnUzSVBRS3Y1Q3oyVGpHMXE3OWZQ?=
 =?utf-8?B?Tk1rbmNoTFVtb3FzYlFFeXdRM1RCdUFIdTdNZ2lIWjlvWmpYWnVVcTlCL2Jl?=
 =?utf-8?B?ZFJKbE5VOGlTWkZEYlBVT0xRQ29VKzlTeXZqR09EanhsS0k4amtWZVorT1JY?=
 =?utf-8?B?RElnRDI2akEvRWpOdVRvUkw0cjBHUEJrOGsya2dvN01Da1ljQ1RRTGdiRmFF?=
 =?utf-8?B?VzJhMUcrM3lMUHdGeE1wa0JOMFBzUTFVM0dkVDhKSlFvTlNHSE96WkhpRjFh?=
 =?utf-8?B?OU5LclM3V3JGUC90R3h2dUxVNnRUcXlwVkM0TXZ6QTZjeDhERU9SeVNPNEZR?=
 =?utf-8?B?RDZXSW1ZQjYvRHFIQzBPR3VKeW9EOENPdWlCUmtMSy9BWW5Ya2tVRUZSeDV4?=
 =?utf-8?B?MFJUTGVYRmVQdTg1bjRWRUh0bFJPMmVCUmVmSU1FN0EwWUZDZit1SjlOa3Rr?=
 =?utf-8?B?Q1ZWalF6RTMvdFFhQWZ2VlJucEQvSDg3TEpRellBY1dVTnFaTW1oZElJTVlY?=
 =?utf-8?Q?7tiMUUrQp0lXf2NU1Nnvfp8fg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NQgK1mZ+Tn3zmQkqNSW7tIijt1vigR6AUuBSGGwhGFpyusZWyGitCsr5tlJlKIUJYFtRB9R8Pe9uIK3psoDvBVoNwqM1C9N1dAuMSkOskC5P1AZSTLEdtiDNeUjL3zW8NsMCbxzeiRvQ3uJ10XWBculPn9i7gcPIcfTuB6/FetZQS5lH6Ruj1DA6B0L+4LUyLX0xGg4b63VwyazrxmOR22vAVXCcTRf3hY4FLDFqFxtoyRhG/m321bkyHghHbfmFVw937dkE1CfUV5YkeaHKerAXMLcLGby0ixdasTqxWD6bX1ds9nxEnVjPXmsWKxD5OJrQS9mMMBVexXRUE/s7vBJO6b1TEw7CmyxHl4r3UAIvgEc2whl9zcLoIO1RK3xb2aOUlldbMav0MtuRCzBrd0YhfyymbQi2pi5nGQ8VOx1ffTfWN+i1SvgpRgCv1y9Qk057eYY4YszKXfJytKqPji4e6xPqqij+jwu6OH1dNl87o2BeSn8Om2lGbsy/iPS6BmvpiU5y7xZ1FM92TI5g/2IYchNHPngGDsgsL32DPwK54BiulHWO7ZJDnTfq55PCf25hsUs6E54FAG5RcFIDsPL3m/tuy/XoQUnjRSHwN6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f61f6c-6339-4b11-c071-08dd67b0ceba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:12:03.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNotRRt6jTcyXEIB4WT5SAcNlRVEtnRg3XgbA7VjCctSL3pW6tuNGKfoazJVpUPI3w78K0BK0JaiUxT4ZL3Dgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200081
X-Proofpoint-GUID: trKiqhVn-E6pbsmj3q3_rBc0JMplGNM9
X-Proofpoint-ORIG-GUID: trKiqhVn-E6pbsmj3q3_rBc0JMplGNM9

On 3/19/25 11:44 PM, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> There is an issue in the kernel:
> 
> In tmpfs, when using the "ls" command to list the contents
> of a directory with a large number of files, glibc performs
> the getdents call in multiple rounds. If a concurrent unlink
> occurs between these getdents calls, it may lead to duplicate
> directory entries in the ls output. One possible reproduction
> scenario is as follows:
> 
> Create 1026 files and execute ls and rm concurrently:
> 
> for i in {1..1026}; do
>     echo "This is file $i" > /tmp/dir/file$i
> done
> 
> ls /tmp/dir				rm /tmp/dir/file4
> 	->getdents(file1026-file5)
> 						->unlink(file4)
> 
> 	->getdents(file5,file3,file2,file1)
> 
> It is expected that the second getdents call to return file3
> through file1, but instead it returns an extra file5.
> 
> The root cause of this problem is in the offset_dir_lookup
> function. It uses mas_find to determine the starting position
> for the current getdents call. Since mas_find locates the first
> position that is greater than or equal to mas->index, when file4
> is deleted, it ends up returning file5.
> 
> It can be fixed by replacing mas_find with mas_find_rev, which
> finds the first position that is less than or equal to mas->index.
> 
> Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> ---
>  fs/libfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..dc042a975a56 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -496,7 +496,7 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
>  		found = find_positive_dentry(parent, NULL, false);
>  	else {
>  		rcu_read_lock();
> -		child = mas_find(&mas, DIR_OFFSET_MAX);
> +		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
>  		found = find_positive_dentry(parent, child, false);
>  		rcu_read_unlock();
>  	}

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Not an objection, but only an observation: This does not help the
(hopefully exceptionally rare) case when the next entry has an offset
value /larger/ than the current entry because the offset values have
wrapped. I don't have any good ideas about how to deal with that.

-- 
Chuck Lever

