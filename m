Return-Path: <linux-fsdevel+bounces-36858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3230D9E9E51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A7C18873CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE11175D3A;
	Mon,  9 Dec 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWNhRoRT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nUFYidLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB113B59A;
	Mon,  9 Dec 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770242; cv=fail; b=ZMagLelR+XVfKjDOlwVukqE9sonP9FJ7RNMCjTV6AvESZpbb/BTxTx12UOrEIxBxF1iaiHBL+SpM8ieOSynB0AgxukUij9biliu+h7+sD88kE6hPkW33hQjdqS9J3FDyjJSOyOPu4zmgi8zQe/LSsmqBf8WpMK56QT6vzF3+Xos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770242; c=relaxed/simple;
	bh=wm2bj9vttIW9/yHs2y1n5lPsTbczhbC+Wuhkb2402os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0d9Rg9JpXvsAcdw6sQiZw24TWlbvGD+w3NI0foh7vYkBtuEAcPnEoNoyB7l/dD/QTnmTe5UwrJ6bSd8qJyMn/6CCc4uryk7AV18eii27QIynkwg9VUBPYcUB7MP/YW7SPbz/rbH8OvFN4zH6ryyls1S4hiGyN2kai9M8OBl5jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWNhRoRT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nUFYidLL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IBiFN007599;
	Mon, 9 Dec 2024 18:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iPblXsCcH37flW1AzHpFMj/pHsRFWKwfxU23hYEhik8=; b=
	SWNhRoRT0DQ4ArOgYHxqDIbGl2iGqPuAIWcaVyWx62/ZfmH5hohZ69TpCJp6EivA
	ggRZXi1xQWBgJUn7W30qcOyKqvIndPv6I4kwaSm8pUxXnyRi2LjuyxHYFq0N9wB0
	CYoNBSszIEh+WdK87CpERE4YgxH3BEJPmZ2kM9bDJ9gfrMuHU3pKf+WdINt/NiR7
	2zxbSzzPKDh3IqG22rYIMTdUURRw7v/hEzFoQkBlzCOreMihlAVLPHT/0vVRjpua
	3BI/m8H+7Cgt5fmcGRqkNUrdv8uVg35G9q5czO2u/Nw+nh8tc9aSB9vjbN5Imx0Y
	3NSO7RaEDC4hJsdbpWGLzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc3yd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 18:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HGHIN019357;
	Mon, 9 Dec 2024 18:50:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7mumr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 18:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujuqAVC1zssEWCRboaqoKEHvjMm4gfXXcSazVxmZQ++5+3vwVmrRaVK5EiG6gMBa1t9lS1J0dMzBXpQZfjlyzofs++yiTIt5ZzFKaBZHJPy2ZNDNWcEQOeSS1E04ERp5nNM6CyI6LgzxlgBonIcc3QZI5BEt8PPoBvi7AVT+mIZWNl+HS6oHI8xadFlmt9zKcFqKKNDDRTYEltknzVHWFC+4ZAFe0/9xQzgnpjm8l98VM66qSrBZfcYD5pBtZD7xgB9ihO4QzqBSmgMsGF4UlPh8Ma83nU4L50cSu2uwxrMpZ2GMzYZiCJFsseMiiV5YVIAomGumnKdBzl362HXA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPblXsCcH37flW1AzHpFMj/pHsRFWKwfxU23hYEhik8=;
 b=ZoUIOxQ254yCZDeY+geGBBTrCcr0NAvM8PZZfy0prtqCl6rNob1z2u7d8Wq1jF19yq4aoqK6CQRiCqtpDljo1dXBh9DHOVomWbnR+GLOgjYThHtgg9usphvhAy4rrPqF5YSBJjZLjsYOGQu9IGUJbU7vVY4tB02Z8vS4JJ68P8yO0pQie6k4EC5LZidCFWkOYZzhiRpSfAgnZKwhQbNvXCAoRFrjSXSGZ/AOfHXwFJwTwy+T3vnmm9dNBefnU+CTtTEXMZ6j43wMgBZPTcwYKLAcWbltRlsMuGGYOtq8Wfo7JJmAB49vILNMo2+hj4g8iOd3+wcFbV3dTViMeLtwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPblXsCcH37flW1AzHpFMj/pHsRFWKwfxU23hYEhik8=;
 b=nUFYidLLSt6U/U13A32pLULHf5XqiOqij8vOg3XYjc/lfNr9CSDqU1G71w4ovvBAbOMA+9QxFRDRmqtBun8lpl1B0iT+zIh9oQJnmPKHnwPmqQSuonSN4EwZ/2iaJaQWJZxixboa3+sn7zDnqR6JeXeaCmg+2fb1d1WHa7KP0UM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 9 Dec
 2024 18:50:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 18:50:30 +0000
Message-ID: <d1185217-0b7e-4c36-992c-70e620e7ce7a@oracle.com>
Date: Mon, 9 Dec 2024 13:50:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
To: Zorro Lang <zlang@redhat.com>, cel@kernel.org, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <20241208180718.930987-1-cel@kernel.org>
 <20241209184557.i7nck5myrw3qtzkd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209184557.i7nck5myrw3qtzkd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:610:4c::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 9864c698-d8e1-425a-845f-08dd18825acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alJxOTdRZEFuSVRTSkprMW5jTVJ2d0ZCei9IVnZudmxkaXkwSWVGTERVaVI3?=
 =?utf-8?B?anVpTnMyM0RwMmlUSUN0dmszQW9VclRrbnpwMHF3eVgxWGdIMzJrQm9VZ2E0?=
 =?utf-8?B?UENsY1c5TVc4TUcycVNuQ09yTUNBOURCbFlHditqaS9QZnB6NkI0ZFhlTGtr?=
 =?utf-8?B?QmhvWEZLaWttc241c2pRd2Z3UDZpVVd6bENvNHhZWVNyYVg4SzVDdGNkVDVy?=
 =?utf-8?B?V0VRQ01DcC9ZdTVOemtOWHBNVTg4UitEbnQ1OU1SUEpvVXRMbnpKSGY0c3ZC?=
 =?utf-8?B?cWt6RUlkdzd0d1R6RlRibmpCVSthMHpjMThIZjB3akxDSGJZZlE2cmVsL2Mx?=
 =?utf-8?B?c2NGKzlmVE9WcGlWNjJoVk9MWDZ0cTFMa05VRThINFFCR0xQenYvMHpPTmpI?=
 =?utf-8?B?Ny9JOW9ZZW55MjRjeEsvbGhUOHczWVhrK1JEOHIxTXV5MG44Z05nT1lycmtr?=
 =?utf-8?B?aStEU2tWWHdzdDkwOVNvVVl3S2pRRVNmOEY2SjNveU4vMy9kMENmL1Z3c20v?=
 =?utf-8?B?Sy9vSFV1c3ZiRlJuOFhLWmtyc29jWWxQaWE4Q3hZUC9OWkZEdzNHMU42Rmtq?=
 =?utf-8?B?T2ZaUzlQK21LNFc3cGJSWGQvRUM5MzBoVGZMdDdhcExPNDB5L2QySjFGeC9a?=
 =?utf-8?B?a1Q4a3VNOUFlK2V2UmVDTnBFaURpQmhUQll4blJ3QnU2ZlZST3dNNW9IOWs1?=
 =?utf-8?B?VDVFT0JHcDJoaGxWbW5PcE9hR2VDZjR1YnZvSkE0YlB4d3F5Uk90bEpSOFJy?=
 =?utf-8?B?b2YzZmxkcVlvZmd2SXh1YStQNXhLTm5SMVZUaVZMZG9tZ2RvTXBWYi9ROTZk?=
 =?utf-8?B?cW5UbDVDMFc4UGRRVkNtUmJwMklLbzZvRUR5ZmFGWXc3dE1wUERiL011MHdR?=
 =?utf-8?B?Nzk4R0g5NTdIUUczbVBmZ3ZlZWNtTmRNZmt2NnFyVllGdFl3bDA1eGpPaVB0?=
 =?utf-8?B?Y1N0ZmJuRGhzNU9LdC9nRVZIbzBGSC9MbU9QaEFqbzRqTThRbHRUU05KUzUy?=
 =?utf-8?B?U3hKMnhMdTREZi9mVmlTb3k4QWovV2dJRXNBWWpnb1hBKzE4RmtqcER0QTNI?=
 =?utf-8?B?TGhnNHJUcDNVcElFT0VlaGhELzdOR0N1dEVIVU4vOGRwaHBiZS9VaENOVDdK?=
 =?utf-8?B?S0ppRmFGc0pIeGZ5eGlQYzBjRm42ekJXRGhjNHN2Qm0wL01ucERweDJVc29Z?=
 =?utf-8?B?Q3NudXBmaWRJTVJ6OTdXVUtCTEk2SitaeFFMUHpEVHcxUjBLSE5WMUxXeEhE?=
 =?utf-8?B?dGM4ME5uajZ0bXd1cGgzME9ETjFwaDlrWTBoK1h2S3pabzJtWi82MEdmSEFQ?=
 =?utf-8?B?MlNqYlN4bWpzUDUzRXNvRTZGWnphY0wrSGs5VWZ1aUlCUWloU1l6aHBTdStU?=
 =?utf-8?B?SkxVQmtQb0pzeGFXdU5keC85OTZ0NFQ1aGFrL0tzWGZ3bzF5eCtWZHdPUU5G?=
 =?utf-8?B?M3VOWnZkSkpqeWhVSXJjRkEwcDdGMzFsVTNoSUo4RG9vajJHRXQ5Z0ZCZHRv?=
 =?utf-8?B?RjFRWUxKdFlsbXZVTm9xT0hCTzVSTGVzTE1vR2k0VFpjV0k5OGpVL3U1eVhS?=
 =?utf-8?B?MUJBVExub3hydGtUNGRDUktyU2VrSjQ3b09ZMVlnYkRab3VRcGZ5alFab1V2?=
 =?utf-8?B?TTlybUpwS2R2SGlETGo1NDdrREV0UVRYQWlZanROei8wVDM3Rk4wcG5xSldI?=
 =?utf-8?B?ZFQrbk1zcmRJT01CSDh5enRiUWxrYWtZTDJWNEpTeDBHWStrU3FNWGI0YTh6?=
 =?utf-8?B?WVAwK24xaThzSnBTWmw2b01VYzVBK1Q4cWNxYkJ4ZitVRVBMZzFreTRzQVVO?=
 =?utf-8?B?R1UxeGZ5M3oxcm9jd0xlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkI1TUpIRVpJaGFlYU9VUi9zL0puUFhHckpJWDRhN3pwdnY4RTEyMUphMURs?=
 =?utf-8?B?NW5kU3NiQzgxalNyYWgxTW1Pd001NXVkRE5Zc3duZm1vdVFvNDRoQm9TZXMx?=
 =?utf-8?B?LzZRUkgvRlo3c0RtZ3RSN1ZCMzZOVWlmd2Z5RU1pVE1HaEcxTlU4OVJTNXFJ?=
 =?utf-8?B?S1FPeXFmUUgrNTdDWVJsVWxnUlJKaTlRSVB6ODBpMkhxUnNrbkJURUxxcHBG?=
 =?utf-8?B?UHVqRWlmR2lkZEV6aXNtS212azZRdS95M3NyVXlpRW1iWUdzeElEU2swSnFk?=
 =?utf-8?B?TFEvRldSdEVQSTJtZmJSU1BqL0ZPb3R5WnBITmI2WG10VllGdkdJTzMvT1Fs?=
 =?utf-8?B?ZThFZFIvTnFJb0lOVmRDYjBBQ1RCRktTeGlRK25rcFN6QmEwRVJ5SWI0V3Nr?=
 =?utf-8?B?QitTMFE0Slg5aEdrTU1zQW5RZm9jcjVFbjdabzE4TGlxODlkU0pmQjBValRy?=
 =?utf-8?B?bmtNQlRNZEhCMElnQ3NvdzYxTk8rRWFldFk4VldxdENoaDYvNG8xb2tHLzFm?=
 =?utf-8?B?UTY4bXp2R255bXhUZEYrNEwvaEVQMWcxNVpWbHp3a0NZRktyeG9ZS2NhQ0lU?=
 =?utf-8?B?Z3JTaGcyVnZYYjFuWER6VTlWRk85aHZQRHJEVGE0VjBmbVdUeVRiN0xnVTNn?=
 =?utf-8?B?TFZYN2FXM2xHUnErUEJmZnpNZ2hIUDh3d1JUWEFFelJqTkZ4N1ZrNlRRd2xM?=
 =?utf-8?B?RFAvRDEyaGVPUDRWNXZicHBweGREZTFvYVlCNUE1b0c1alBjd2h0b2I4a0JP?=
 =?utf-8?B?aTQ2TW12TTdQbWhLVEROK2h2UnZQcmwyOWJwakFtY2IrSzI0azJ6bnlHNUl6?=
 =?utf-8?B?TkVkTEc2NUg1bnNCVkpHY1d1b3BVUWh6RElNYVVPcTdxVTVTK2JKN1dMZ0dH?=
 =?utf-8?B?WkQwUk5hT3lrUXBVSWI4a0w3M3ViOWtrTHhXZ3Jub1prVzZXb3N2Z0FsQmhM?=
 =?utf-8?B?cEh3VGVRMlNnVlZadUJQMmljdzFCZ3VtSnBQUjFKUTJCZjZJOGdXTENvbDFT?=
 =?utf-8?B?OFlpOEJmTnVVTkRvcjdNdDArYWJPY3I0aUhqM25NaXc0MldMODc4d2FkaHU2?=
 =?utf-8?B?dlNnVE9OUHdTbEF4VnI1RTVIQWgyTGFvbVdEMEROdnZSTDVEYzlIVHZZSTVy?=
 =?utf-8?B?WTVIZXc1dFVoZ0h2c0NSbW9EMitHM1VlMHl5VGpOY3dnU3Bha1hkUEZuNFJ0?=
 =?utf-8?B?SzFIMWFMYTlMNFVmY3dZbEI1MERWWTVHdGRValVjenpJdG1hcVNXNUxSbUhX?=
 =?utf-8?B?Z09WMXV1YzRGT2l3V2pDQXlwYkQwNWJUZGcwQVNTOFlrMktKRllsQkNCMWhS?=
 =?utf-8?B?TzFGWVhFc3FRTEhlSnZtQndhSjVReFFpZmNNY3BDMzNrWXdXaVdSNnVZMFdI?=
 =?utf-8?B?NWNZU1NjUDlPZHM0VVZoMk0rK2xpTUlHL2hGRUlaY2hFU25OZTYvSGJQUTRW?=
 =?utf-8?B?MDZvSC84SHFYVEpaTmFSYUhkb28rMWN3N1pkc045a3NxRHhnMjlnSHJ1RHRa?=
 =?utf-8?B?ZUU4T2ZIN0dLZ1NjNGp2Zldiam5zMVFvVlNsZ2NUYjB2VmZCanl0VitmdXE1?=
 =?utf-8?B?OHNWeVZNZXlyZTNLT2g3Umo4VWd0N2ZPSmg2c1NrdGtrTHB0elQ1WVpVZ2JO?=
 =?utf-8?B?ak1Pa2VLWGE4QUxjekNIVkl2NlQwN1ovMmVSRm1Ra0RhVmwvaGdKd0VDaEg1?=
 =?utf-8?B?ZHZmenlyemI3dEQ1RFlyOThBMjBzTS9nd1lpTVZWdGRKRDl6aE9wdE1KSGhY?=
 =?utf-8?B?S1Fpc0ZjeDdBV2gralFrb1MyK0lBVlhPUUdHN0xOWmRZRFBoZmFZckp1eEJq?=
 =?utf-8?B?VnFqVVUxWnFsaUkzNkVBN2IzN2RFanJhUnR3UjVMeDR6Nnh2YkhXMEJFcW13?=
 =?utf-8?B?MGhSVXFtZWlXSjVUbU11YTdmSE9Kdm05VXU1Ty82by8wcDBmMnJ3VERFcGtu?=
 =?utf-8?B?VUdkMnB2a0lLaXZZUllNKzN1QnhQVjVJMzJQNGhoRVJmOGZEV3NXUEQyeHpt?=
 =?utf-8?B?RDN5R0phR01nMm9sTE5YQXcxUWJHNC9kODh4MDB5Z2tpVnkvNkZBNkRjTmxD?=
 =?utf-8?B?azJZSUYzZXlhTVJvNU1DUWloNGRUZVBZWCsyTUw4Zy9wL3RmeDM0WjVkYUF1?=
 =?utf-8?B?cHhRckEyOXpGRlVvcmlVaUR3Zmd1d1VPVEJCMmJNMnAyTDYwUnJXbXU0ZHRs?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k5dltnrVH7lDXe4gEWLi4FTH2nA5I9F1Vs7jvLPkMsduadYsQAIPCfbnN5nklM6bfyEJ2PmftOItnGLpT0KTXjM1C3zsEIxLyk+hoqS6JpB6FS028OgRfRGyz5Gggj5Zm8trqFd66N0sx3W31rAiEVYS/yW3ok2uEYLfumV7tFtOAyK7aJxnj9/Rkkp9lrdHkUDOPTDSUSbevDcGfgXMol+8lEhmOmLrp/s9GAdoauTgcld4H1xzsiBkVziHgHsiN2gx2Z5lWvRsd7s2VhOaXQXg9wCTv6qc4XvA7tx3rMw17igNMIA8rYuOpHWmhJu6C3zkiCZdyir0TBH0vNzjJLMDOOFay5JTPL+8YoScTU0J315szeP12XSqEitvBRZH0eOeb4QoPbL9q3bTIovERQZHfCkIW47psVVwKWrkIxjeGb7+YoOv4EtSauZU4src8S3guCWR2f27Y5HVBMJKEPRtQ0yGWDhDfiPG5eXZvWfNDR7bTVKGAiymc1xubgVt3w2V56nTRbE1sSHwpK6eM91rIKGNyzobaPRbZ4tg8uYUsDhVxDcyQbYLDzBtIjnNq2jW4Z0gSsHrJuu2LBlWcV38tmGnm87k3QcqxO4JE7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9864c698-d8e1-425a-845f-08dd18825acb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:50:30.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BUQMpc6YaRCrhnl+8Z0DYOETMsiIS/MUS+cBa5oSxoV/wGLg69NPV/3+cpBLsBnYFkWpbqQxC9qBUwgQzR/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090146
X-Proofpoint-ORIG-GUID: JGgYy6PeiD3Zz67VGo4ZGkFXPO64ZS1r
X-Proofpoint-GUID: JGgYy6PeiD3Zz67VGo4ZGkFXPO64ZS1r

On 12/9/24 1:45 PM, Zorro Lang wrote:
> On Sun, Dec 08, 2024 at 01:07:18PM -0500, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On NFS mounts, at least, generic/559, 560, and 561 run for a very
>> long time, and usually fail.
>>
>> The above tests already gate on whether duperemove is installed on
>> the test system, but when fstests is installed as part of an
>> automated workflow designed to handle many filesystem types,
>> duperemove is installed by default.
>>
>> duperemove(8) states:
>>
>>    Deduplication is currently only supported by the btrfs and xfs
>>    filesystem.
> 
> If so, I'm good to limit this test on btrfs and xfs. It might be better to
> add this comment to "_supported_fs btrfs xfs". Anyway,
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> (This's a fstests patch, send to fstests@vger.kernel.org.)

Noted.

Christoph requested additional root cause analysis to see why the
existing feature check utilities are not blocking these tests on NFS.
I plan to look into that and repost if needed.


> Thanks,
> Zorro
> 
>>
>> Ensure that the generic dedupe tests are run on only filesystems
>> where duperemove is known to work.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   tests/generic/559 | 1 +
>>   tests/generic/560 | 1 +
>>   tests/generic/561 | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/tests/generic/559 b/tests/generic/559
>> index 28cf2e1a32c2..cf80be92142d 100755
>> --- a/tests/generic/559
>> +++ b/tests/generic/559
>> @@ -13,6 +13,7 @@ _begin_fstest auto stress dedupe
>>   . ./common/filter
>>   . ./common/reflink
>>   
>> +_supported_fs btrfs xfs
>>   _require_scratch_duperemove
>>   
>>   fssize=$((2 * 1024 * 1024 * 1024))
>> diff --git a/tests/generic/560 b/tests/generic/560
>> index 067d3ec0049e..a94b512efda1 100755
>> --- a/tests/generic/560
>> +++ b/tests/generic/560
>> @@ -15,6 +15,7 @@ _begin_fstest auto stress dedupe
>>   . ./common/filter
>>   . ./common/reflink
>>   
>> +_supported_fs btrfs xfs
>>   _require_scratch_duperemove
>>   
>>   _scratch_mkfs > $seqres.full 2>&1
>> diff --git a/tests/generic/561 b/tests/generic/561
>> index afe727ac56cb..da5f111c5b23 100755
>> --- a/tests/generic/561
>> +++ b/tests/generic/561
>> @@ -28,6 +28,7 @@ _cleanup()
>>   . ./common/filter
>>   . ./common/reflink
>>   
>> +_supported_fs btrfs xfs
>>   _require_scratch_duperemove
>>   
>>   _scratch_mkfs > $seqres.full 2>&1
>> -- 
>> 2.47.0
>>
>>
> 


-- 
Chuck Lever

