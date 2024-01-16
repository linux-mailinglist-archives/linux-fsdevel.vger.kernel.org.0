Return-Path: <linux-fsdevel+bounces-8116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CC82FC5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66C11F29551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F22560F;
	Tue, 16 Jan 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/2S9IVO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ePIln5EY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648C2510D;
	Tue, 16 Jan 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438323; cv=fail; b=izeAx3t7XgJ69FpUl2T7tcip5jLzXO33oOAWXykEakIHDU/e0GcJ9PQX6FsU2i6JSFnZGvykJT+6ydHO5FA1vUOhSR0ZGkONklm2xGF9WGFJbBIAGT3L8d8axyeXO5XDOkatlEaGl/8CCt4Dce/8nNnV9+UEL8WwYsspRqkPPyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438323; c=relaxed/simple;
	bh=epOu98D3FZSSysGDjMLqFYiYace7mfd+EXoKlCOOoiU=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=QF1CC7tP/uQp2YU5pKMVUJYw3npUkRCUW1lpDuhtPtdDcA0SFJu/MIefmnxLDhqjCa3JIAjIS2Q/NWNX0SUzrFSefueZelIVXKywLh2+bsRNt+fwO6FM5H8PbA74yh8sDArjafV81URkP6RsTCo9qhAhyHoR4J+HheGJLmA1Yc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/2S9IVO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ePIln5EY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GKE2xD016610;
	Tue, 16 Jan 2024 20:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aWhjeCfkKX5MCCX5sQLACrrZoV966rZs19qwhnUM0es=;
 b=F/2S9IVOsG0FXrxSGGSbwk+Ewp3PI4mv3lMJT6K1PtzKAR+VBjmi/mwwr1kFuKLLDomX
 YBEq+FhZyleNxTu4ZttSgu7+RsH/SfD9Zq1hp2uPtKvfLvzDu3kRg7l0TDwbq4ekGnms
 PCjQAlYHJA4CbIs+CJ20mg8k384gWJMMAcqLL1M4Hy0ptTTtER+rxB8lMIS5V2gZY7YC
 VXpMSD+NkSoPaeBLCW9C8y/E0V6H70sVjon6njMI2cxKkhbt259MySIR7q9gtLzE2kfr
 dtuoiqnNyOajBq4j4ZuaZZcrJv1/y3IdAJ9k6FMIaQJOPx89Dcbyme9UsCsXSXTGFOKV SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hnvqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 20:51:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GJFVuj019936;
	Tue, 16 Jan 2024 20:51:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy8tbcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 20:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygq3mZdSXNgxDcWXE5ujmCpk9orKHu67HnC05fSJA+yqrfbbuWYuiy4H2ITBUThtPXD/buG0Dn1/icpQt28w20iftqYZUzuWWgam3CDdL+q4O0rTanE5tU+18kgzDlhO95hBt2PrcRa/PyltF77lR9t2KGszjaCoyG42AXo9ufjjj5ja3Qk8f1DhJG9Bh4vz8bbzS6geyuZNIcj0/8TTFZiv/EPYl4fU65OH7+fc56cyEWXn/Dk70rb8HoLqLAjkBNVlSGcWafs1D7OX4KqyHTIlO9cxa0+bjqZFydUyO5lm/cfZfvA+pK9LGLTkOWsYwWWgQTgU94uwTyWF9wUTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWhjeCfkKX5MCCX5sQLACrrZoV966rZs19qwhnUM0es=;
 b=I6XJKeICYsAUpTCNWwnqQPp0Xksot1jcMnbDoKIW7A0dbggeG1qv69pIdrns5j0V92qp5vAfaEoUfLtW1Y1nHdBZBsnVTdv2qYSjk8IIio9dqJ8tlk2yWoLBu5pB7Wm3uZv7GH9aptKqATfWvJCSUfhyGAARMMvDLcIhGKt5dQDXJ9rhWpchf4t/6nWpCVGmm/zQxVN+rnlU8BPSqxiap59WTGNtbc0BHc9gpBIQ4/KR0Tudgs5mXw6t0w5NBWc1ZtW6vdRVhMruTY2zn24e5KRMFeVPHG/+UlG0QVbUhp4eYOmc1D3dezEMgWQlJeZtcTH+CmbiC2NQKGFfVkyHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWhjeCfkKX5MCCX5sQLACrrZoV966rZs19qwhnUM0es=;
 b=ePIln5EYMn8/XyhgQrwpIGt/j85Dlw8NlpzFvJ4+xSQt8+ns6mTfoD0g5XPJ1Ev1iqCi+xGBbiAk+qT6q2YgpFk+xXzQjx5tIRXczbzbg9H4vbJWD6XCmCeATulHgzyaPKj6scfIURfHehPQQkaMomJ7xXIrvvUiOJVIAum6CRc=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 20:51:39 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:51:39 +0000
Message-ID: <3623c810-32a0-4f13-83a7-ad0ca4b41205@oracle.com>
Date: Tue, 16 Jan 2024 12:51:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfstest_posix failed with 6.7 kernel (resend)
Content-Language: en-US
To: Jorge Mora <Jorge.Mora@netapp.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>
 <20240116-hauch-unpraktisch-8bb7760c04ef@brauner>
From: dai.ngo@oracle.com
In-Reply-To: <20240116-hauch-unpraktisch-8bb7760c04ef@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: d4744574-9503-427b-4dc3-08dc16d4ef9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Qtk/wcO45IQEIGedtvXZNoyOOh4AysjKlAU/wsTc7mahAKS3ILtWJrwgoWBqkuAbi3iwXVQA9W1w+g+8tc2Dt8ckhfZYk3jXIGmCSUYGv6a/DhDWaLphVJ2GIfv7l3OR/3HF8/bNjYfCG8dC/eXfg5NgO+V6vFSyimBGzxcLc6HQQPzVWBlU3ODf+Bu2y/axBzOG6Av3AzkkpA69kU7BLNqxoCCiVM6kLLbXTbubLIRs0JzRLuP57UkkIE2uJ2CgcN0W9VavkaCdd8v3dYB8FBgEw8mgtuAuiDAjHmrupF6GXMr6LQRcaEMyGfCvrR2ZaXjJPS8fAQIYy68QMY+M+armcw5mqeZ5HNPBAsVINrWuxXX8wjkiG80YWxcRxgvT3rRob2FwaOxe/uplNBquL1wBXjCExJhnkkDFbwgt3ZSO/QiFGg8ZheqsH51q3dG84UwDMJx473Zc7ZhHKtLfrqTZEf/PSTUzSeIxrkfGPa55a8SyH+qyu+j5jOKAKqfB49TEOcxaEEBDjdoQSqShGbRu1/8bBGcVYL5na3UTG008HgHKVoZZTxDX4UTyki7qZ0yo/aBgZkebImrG9AO1k1k2gaTOWqRAMvF86i5B+NfF+LanM6W4Ic26n0nDMiAa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(84040400005)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(53546011)(26005)(2616005)(38100700002)(86362001)(36756003)(31696002)(2906002)(8676002)(66556008)(5660300002)(478600001)(6666004)(9686003)(6512007)(6506007)(8936002)(41300700001)(316002)(66946007)(6916009)(4326008)(54906003)(6486002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YllkdmxmMU5CUTErQTdsKzJTRWJSQkVwdElJd1RJSXZXNG9IYnd0d3lVUFFv?=
 =?utf-8?B?dDZkeEswRFkvZFZtcUg0NWg1dEQ0TCs1V2Uyc1MyK1JIZk1xNVBYYkR4bjMx?=
 =?utf-8?B?MzEzUzhkQk53Y29NQW9mTnJjU28rZERmTUZpajNUSmVTNllsY0VCWFJ0azBo?=
 =?utf-8?B?cVBOYmt1RlZaT01DcGVVRngzSWZNeWVtallqQWttVXR6eGg3dGZIalovaE9q?=
 =?utf-8?B?K1VPLzNWbCtOeXFLSGRoRmtnSFd1MWNmUTJMN2VoTVpRc1FNQklqQm43Yy92?=
 =?utf-8?B?VXlBdWpPaE85MHQ4dUQza2dSaWpHZWg5eDJzL00vNzVucEpGSVd6cXF0NG9h?=
 =?utf-8?B?a1liUGIrVVlWYzIxbS9BYWpGU0QzOC9XS2pZbXduZVY4a1R5WlpWRGxjbENU?=
 =?utf-8?B?dWl1QjBzWTFrZmZzQkFWSElqOW5NYllWNlpDdEZkZFo1S1R5VHJLMEVWOXgy?=
 =?utf-8?B?WVFuNjBmUzNLSlduNHkya2MrMzNIN2FQMUU3dWYrQkFvNWh1L3VoNCtkb0c0?=
 =?utf-8?B?TTZ3ODI2c3hlN1NLSVA1OWYveGNvUERHLzkrYzdQZDFjZUw1ZUl4Y0ptZ01n?=
 =?utf-8?B?NXRQaWVxWllwNEdYcUZEOElHK29KdjVRdWVzREltQ0szajVZK0NwTEdqMnQ3?=
 =?utf-8?B?NnQweEc3V0RUOGxETzVUc2MzV0pEZG1zZnp4VGlxL2xkWE1pbWZ0bXh2Umhz?=
 =?utf-8?B?QVozMHplVllrU2JsZDFqbHdoZlFpekVSUGhGd0w4b1lQRFBmbGsxY21yeVRj?=
 =?utf-8?B?a3FXNFAwZlREWlFZdW42ZzZJeS9sQ2g5cE44VlYwZm1XNnRCcStDWjloWHph?=
 =?utf-8?B?SmYvdjduaGdESW1jc1BYZGlndTZYTkFUOWRQcTQrUUQrcURzRHpSVkVFSnBy?=
 =?utf-8?B?QnRGMHRZOHIyeGRyUDgvL09Fdi9jYTNjUFJNTzV2WnRRdS9tbjlsZFhxcUoz?=
 =?utf-8?B?YklTcVhCdUxXKzJJYVIyNTMwYVVjM1pQUW0waWxmZzB3WGhJZVp2YVllZHVC?=
 =?utf-8?B?dVhuMENSTXpQVm9qZXJ2ak5seGdmMmFYT0lOcCtJWkRJMms3ZStyOHhnT05O?=
 =?utf-8?B?Q1RuSm92bGM1VUZkWDVPd3MxU1U0U216VGw1VkVyU2ZrV09zTHpjYlEwT2E3?=
 =?utf-8?B?YWcybHkwS21ZaGxtc2hsWEp5aVBMU3VTVjVvam14L1NyNThWa3k3ckNUVUQr?=
 =?utf-8?B?N0loczhaUmV5WlRhMlNPUEswNEltVjlCOU5ENDNPcHNWRnhyVERrM25FcGNV?=
 =?utf-8?B?YU42NmdKc0FVQi9GOHZ4NHdvT003K0YwWUtXd2IrSjVhMDNKQ2M2SWJndHd6?=
 =?utf-8?B?bVdxUlN5MG5vZXVDQ1BnTnRZdG50bExPMW1XeENxOTEyQlpQOXJFT2xkTFJp?=
 =?utf-8?B?c3pscjY5cWNMcnlmUnlhR1pvUytrdWQ1VEZNcVp4ZG01WEp0Q1cyMEdPYS9E?=
 =?utf-8?B?TjU4ZkpCS2dCU2J5WUJkYndhZnNKZ3N5TmhVbHNucmtZV2diSlVndk9lRS9s?=
 =?utf-8?B?OFozaCtNN0ZWZGtuNUdmNWxPRW54My9CL053c051ajVEOE1GeUJybGJPc2xp?=
 =?utf-8?B?RVVzalY3NHRvVnNzaWhTcjBRYUk5Y3BxbmRvTVRrRGY2dVh1YjNMUjlpajBr?=
 =?utf-8?B?SWEzM0RnOHRnUXJEQWYwclJ3WnZLZStIckFSaVdSQXRMTHhJK1IycEx4T0pD?=
 =?utf-8?B?SU9DOFp0c21MUFlzU09rNDRhOGFRdGJYbzgzVkRvVHdPcHlaRWIzVzZWTWhq?=
 =?utf-8?B?MXQvT3Bqc3Z0Wjg3RTNtQzkwbUhaYVhJN0FqdDVjVmdLQk9IWTV3bzltZ0JG?=
 =?utf-8?B?NEtvQzZOMUFiVWlTVFJOZVh4MVR0RFBPVSsyMGhOeFp6TGdBWlp3TStBZXNz?=
 =?utf-8?B?SWR6RVg5TjdRWEdpYWEyQmdsUkozVDJrOVF3ZlZycWpSUGNpQm5YMWM5Sk8w?=
 =?utf-8?B?UFdmWWVUb3ZhVWFNTVB6MlVPcDBkWlJDRmZrTi9rNW51czBUN3JXeEhTZUF0?=
 =?utf-8?B?ckE2d1YySUdUeHJ3bUJxaHRLR3MrbVRzZ0NUYm9FaThSdThLQ0pjeFM1NW5K?=
 =?utf-8?B?ZGpyV0k3MndlYmozY3Jud1dteFZOdzNKRWlid1N2QU8zUmc3SW9YTzBLeENZ?=
 =?utf-8?Q?BkoAiMH7WoO7BT1I7F93XOBtA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KuXAdmowA/T+0ICypFnRteRU/KpnhFzwOJZ3KJsFBnMEIE5D31Ej07esgOVSjpElD5jdBejAB+7jNFFW+mKN1XXWyXeWcqEaZyxVf+hgaKOkdECRaPaKRDpXV702JhYbhD0/3ftACcs9fZ/tSQ89YnNB+zfaHJOO1thP5a+s7XwF31RLkmiwTBdwcqYMBsqNg1n0ka9dZ0xxR4Zn89BCeLS3ykT/JkaNeE0jcsdJFrrWcNgnCfyrWUW6yrSCYHEUeE6DBLy+N4ZbZAesuKiTltqK4psVaFGrPSV/urmT9lUc3eeAKXoRB51bKZh7VYFpws3gx6MMGiIho9N8q41UrgdYI1/kxjgxE5C6XUpLUk8U4zcfrDkdrmu+rvgx5iIOm8aExrzPTU+eRMZIlkVMohmJhW9gW4k49CqnKq7SqVGB9zWW/KhfGAV7pfMgjxee0h08NQJipmFw/pTbAbVF6gisKrqiB1tg7DpuyaDnwxP3VR2ynRMlmBZc3VbfH9TCDH31bglViTKGhg/BW+fhlEybBrEc/O9M1dEouFkLh5wJG/UkLUaM6HdREkxOI1TdFKQuuAsI/aCTJgkfwIJXf1ZdXCbv+G7drBxSdI9bn24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4744574-9503-427b-4dc3-08dc16d4ef9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:51:39.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HQewpXzCyx22K0OEnauU3n7rCy1Abu7El7NztwDJYHLh7Oi12fLAB8NqdEodsWbtnpB/gEhCAYdCacZ518D3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160164
X-Proofpoint-GUID: DlBlDIQrLP3luH31W2nCL1y_lLtu7Xsp
X-Proofpoint-ORIG-GUID: DlBlDIQrLP3luH31W2nCL1y_lLtu7Xsp


On 1/16/24 1:25 AM, Christian Brauner wrote:
> On Mon, Jan 15, 2024 at 01:05:37PM -0800, dai.ngo@oracle.com wrote:
>> (resend with correct Jorge Mora address)
>>
>> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
>>
>>      FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>>      FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>>
>> The problem can be reproduced with both client and server running
>> 6.7 kernel.
>>
>> Bisecting points to commit 43b450632676:
>> 43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT
>>
>> This commit was introduced in 6.4-rc1 and back ported to LTS kernels.
>> I'm not sure if the fix for this should be in the fs or in nfstest_posix.
>> The commit 43b450632676 makes sense to me. No one should expect open(2)
>> to create the directory so the error returned should be EINVAL instead of
>> EEXIST as nfstest_posix expects.
> Please change the test. The EINVAL fix for open is a really important
> fix to the general vfs api.

Jorge, can you help fixing the nfstest_posix to work with commit 43b450632676?

Thanks,
-Dai

>
> Christian

