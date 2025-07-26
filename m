Return-Path: <linux-fsdevel+bounces-56091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662FB12C21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518223B2C81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800421767D;
	Sat, 26 Jul 2025 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yfy39WUy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sBhlykgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC061C5D55;
	Sat, 26 Jul 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753559909; cv=fail; b=SWjmgOo1SwM/x/2uotAkoWkKcK0eIkqRF6bil+ERaiaskJKtiTR5ZymImF0siF9fSLaRuYW0pG80YKAFa57dtCgHS3yz0g5DXhnYSINc3XSAsI6138PRxTaz8Gfjn7luXqSnYByekRWWukcE5zZDIs0kJ1SRo7qLzjFRU3BwD9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753559909; c=relaxed/simple;
	bh=ibUjmVSsYQ/QxfkXa0mA2+E3XYucOgPnwi/NOB8r+dE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpQe3YWPBFLcQexg/SrQvtUt3PboAJcsPwoJqtnvpaXDdqX2slyX7fmePDwnxi/fS34n3HrJVdLmDQv7fhb0MD4ZvEztvgTZh9mE3EJmuGxvkcvabgYmMbigU1x061p3gmXox5IyOQHRkSE7TJ6LxAx4KwXvrFqmGHJZHde2KaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yfy39WUy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sBhlykgt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QEYTkN022277;
	Sat, 26 Jul 2025 19:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xN2tcVy4NBPdgBmNV8ib8eCD4Fpvt3/AGzqwExwjG0Q=; b=
	Yfy39WUytroTH9Gn8JRalPLxS/BD5Vo/J+ECZDqUKkdpTwS6kb2CiOLoD1JzIP3J
	Tgsrx3LMkVJFER3lVfXjX+R85/KTyTmTVtvN7+hn77d+HjMzWKmQzOCUCvUpgdrD
	PXN4zSgJxMDeTTa38F3WaveyhNER0Udk7/sDJmsIGGrl0o6CxyMltnYaZIN9hT1u
	WPv16FJO5hk/qrpRAJ7qiFBk/oA98GNDnldaKkEQxiB4dfW/ovHIFeDdkCBqn0Wd
	cBoBdjXUUrSR+EXc1xPDBXgXumSujtHa1SMOutRRZ1opRj2zE/iKvWgamaMRd5jz
	xzYCfqpkvZaN3N2QtQXN+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4y8vnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 19:58:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56QEmck6038464;
	Sat, 26 Jul 2025 19:58:04 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf6xwj9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 19:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG1sC8/rUe9tFGvYxh4di5NT7FGeBVZXd8VKaY0MG57Hsx9U7ffsll8yF6MDpBLZ5rQWuGssgId5QfRtfTYyrUze33o/Pi9qHojAFqQCh1sdd8VklK5s+y3QJiSsivzn+5nz4fhh2jBxunll+ooTeymxRaJ1tQwG1R9AVuduU9vEJ2GceOMpD/zN7qntIY7lx9INvu/1GaKprta+tC0bWtgfX25kPBdx2JajhW0yns04h+TUkrsQaeRE6bsfO/Dca0QEoQb0AFvD7IbjA0mKru78cm16TjiZZKrL/f75YP37ZNa1+cUNH/rVbs9aToKcajd97Ce6woXmNPNA4HadTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN2tcVy4NBPdgBmNV8ib8eCD4Fpvt3/AGzqwExwjG0Q=;
 b=AWN/Bo8F4CZRK1sH/EV3Ol+sX3kagVMzDUTtByh5UA56YWYtFJmwr1BartjjJ46MARYTniHpHVg2nbMfp1ZOTTAhKazF93BcnKg74azrwiigATEPrjPOav3A4JPlKq/42xFVOaU1vBMp8BbCHlp+lx/i21FGl/L7dc+HvI7/4BWD7Rb/NRTpNAclNXggLtKSBhl9Us6S4Fa/iFy7nvmi1bxvR73d3Ck9oZnKZlIXnGLcknmqYLejQT20kF306X6ywZDUfnh13KwFy/4jpqbDUwFpFBgZnx3KYPI6hK3ZRJbwMvLawg4sSt23NaZPvQkHhBYDIX3BlLIWaojhUKoAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN2tcVy4NBPdgBmNV8ib8eCD4Fpvt3/AGzqwExwjG0Q=;
 b=sBhlykgtI0AyYcvCqdxmps4M4te0rkuQ/BWDwQyuILyycIRsdK+xc2NvxBqI0AFWO3Vnc5tqc2cNGAtVVuJJMtUcFwpDTjLy98vw44UheImcLpCUVnRJ7DwPEGpntIxVArX32+P2kEyD+bgWHmaAtlpXlQs6hx4BI8T8J4tDwmY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5851.namprd10.prod.outlook.com (2603:10b6:303:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Sat, 26 Jul
 2025 19:58:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.024; Sat, 26 Jul 2025
 19:58:01 +0000
Message-ID: <67d99140-0513-4797-92f8-1375a06f689a@oracle.com>
Date: Sat, 26 Jul 2025 15:57:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
 <20250726-nfsd-testing-v2-3-f45923db2fbb@kernel.org>
 <5f877de4-347c-484c-814f-33c08f1a5189@oracle.com>
 <8ec5b19dc1d0ce26f1cd86d7db2ba5a2d260c073.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8ec5b19dc1d0ce26f1cd86d7db2ba5a2d260c073.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:610:e6::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a556509-d49c-4a83-c6f3-08ddcc7eb9d3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NndzMmJqcDl0UUp2RjhDZ1dvTlhaZW5CbEVNRkxtY2xlQWNzU0M5RHZyTVdR?=
 =?utf-8?B?YVMzUElSdU1FSUFKVlZDL1NSZUdxbVRzNDNJbWlTdWJ0NmhWY2lWTHA3em1U?=
 =?utf-8?B?aTduQitFRmdPQnRvdWJQenNUWE45VjVMTFZRYit2QlBvK2RRS3BQenVZczdJ?=
 =?utf-8?B?M3JCV0FUUXArS3lnQ2lYMGVORmxxYXNOYUhrZUtaTVRDM0U2dXNFSGVZRzRH?=
 =?utf-8?B?aWhadmo3SXNBaXJXNmNJVUFVUlVXNEVodng5V09QR0tJTFN6Nm5iRmRPT3lH?=
 =?utf-8?B?VzV2NC9FZTBQdkZmUWpQNVBNZVp0TFJpd0xmTVgyVGNKc29uK0NGRXVySnhj?=
 =?utf-8?B?aU9ONmRuZjNNdVdIcG44RGRWdTM3WFdXUzU1ZHVEZU9KWWdvNnBoZGo1VS9C?=
 =?utf-8?B?NFpmRlRFaWNtZUs2L1dJQWFMN1RoR3p2eUlaY3MyV3EvL0dnVGZWZjlxMHdT?=
 =?utf-8?B?MHhhVmdweGlON2RlNGtNNlJxcy9OODRNODF3VVB0MkhKTnBkaXA4SVpvOVZN?=
 =?utf-8?B?b0s0MnJDaHdXQ3BhNTNNVzRyRjFFRGNzRlpSdGc4WXhrV0ZaajZOcDJXTXVq?=
 =?utf-8?B?OVphNnRwSkpFTmREdzZYeTdGMHlaRjVJVFFCaERDcjY5bG8ya29oSGVXanBH?=
 =?utf-8?B?NG8wY2E2a0dYMktRbjJQTjd1TGxQTFBFeSs1TmZySWpUajZQNmFzTEVnUEhi?=
 =?utf-8?B?SThLaVQvYzI5a2FFQ2lJUStBejFvSjF3bFErcjE2ayt0Q0NiODZFVWNZTlBw?=
 =?utf-8?B?ZWtPV3hhNlVqR2xXZU5ZZ1NnOGtSLzZWWHJwNTVyQVJCdmU0TGVva3dDNWho?=
 =?utf-8?B?OGdWZGdqclFoQk9BZ2RkcmwwR3dKRE1pelluU3RiOUtvWTFVN09vd1lzVm04?=
 =?utf-8?B?MGdSL3BXbEZFRDduVElSNklJUmV0TmI1M205K3ZvOEVhb2ZzUkxHOUQwTUFh?=
 =?utf-8?B?Um5ESTNYUHN2TUh3eXBXeUNJc0hGYlQyUlVjdXREQXpkd1djeFVGZFlLMW9D?=
 =?utf-8?B?cVNEZE0zTlhLWjdOU1hsa0ZtTUNSbVJ2N2JrMHF0S0JsaDlPVmhZSTBiaGtz?=
 =?utf-8?B?cng0VDBsWjlqZzcvbDc3QVBxVHMyZ09kVktSK1dpNndleFVkZDZ3UThHejgy?=
 =?utf-8?B?QzZHR1RzN3VMak1RbkFPZlpteGRjMmo0UXFodm1EU3FUcnRqY0JiaXY5NzZF?=
 =?utf-8?B?TmlzaGhpZnhqWVd0L2tiRFNFUE16TUZLem1CVmJSVncvSVV0VTlTUVp2UVlj?=
 =?utf-8?B?Y1JEQnhaR2FoanhjbnZGTjlXRktQZzR6RFR6dHltbXNBQ1NhMmpmWG1laXA1?=
 =?utf-8?B?ZVdjdGNqUFYrQzJtOHpmSW11RmF5ZkpwVEFLWFloUjFsMlRNM3hSY1gyRmd1?=
 =?utf-8?B?c2w0cldxUi9iNk9iOHl1NjFoZFk4TGJuNzloR2tXc3RVekZpUS9MY2xuZ0dy?=
 =?utf-8?B?SjhoSFV1YlZLeTNFSzY2SjJud2l3OHlObkMzc1krVjhrOHFUN1hkcGVKcFZj?=
 =?utf-8?B?VGF5UVBtQ0tKUjlxTDkwNEh4eEpUNG9ZM1c0UGxBQTFldXpTQ1JKWTVQY3lN?=
 =?utf-8?B?UjU1WjZVZEhhdDBtMnh4UXVPaFBGWUh3Slpzc0JlMnFhOFc4UlRQbm5PaVJE?=
 =?utf-8?B?MnZkdDdHMjI4Vkx2Umwzd3VJa3RZVmwrUW5DZG4xbkRwdnFmQUdLa3FPWmlu?=
 =?utf-8?B?bUw0SUxMWDBNSnNWbTlvVXp1aUU2aFpzSFE2Uk1FYWxzaXZmNmJVUTd0N1Y0?=
 =?utf-8?B?eE8xOXBzZWVxWVF2cmJIMTA0T2tJZzV2SXNDcjhpdE1FREt1ZkdOUHVodTJQ?=
 =?utf-8?B?NGd6ckdubnhoTkFFaUcrU0R0bUVSbk50MUxDb1ZqUGVGbVlDUExMVk9oTkpS?=
 =?utf-8?B?WU95QlQ5eGFEN0IwcnRWdWdaa2QweTl4VndjdXRSRlZUOWZGSXZHSjhuMDlo?=
 =?utf-8?B?LzdzcHg2WXNWdnduY2lUdXJ6dTNKSStnTVlDdmYvazRLcGdHakpuTTZyYUVM?=
 =?utf-8?B?eEZaS2hWdzlBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZERFcXZETXpWVmNZYjFWY0dXemF1VXMrMEdndWZjd2VNYlNEalRLSVk0UTkz?=
 =?utf-8?B?alJsQWk3Tm9iWSs2YUg4UnEzWG5pU3M4dGpIbStnOEhoN3YraTdZcGVtR3BY?=
 =?utf-8?B?VkcxQnEyeFk4dklEKzFCRnAxKzZHZjloaEhueVd4Y011S0pHSjlURWNZZWdp?=
 =?utf-8?B?WnlBTUhMNDVPZGJZeVBRU0VBOFl0TldseXhrV1JmV2d3dThFN3NjL0RvUlcz?=
 =?utf-8?B?cWcwc3dyTWdnWTNpRllPM1NKcGRGbjYyc0ZVSXBFdkc1Vnh5ZVlhakZJZmdp?=
 =?utf-8?B?Y0VvR1lYaW56WFBtZVk2MFMwSzNacVNlLzFZQXVxMDViY2UwNDFqN3JuUWZt?=
 =?utf-8?B?Z09RbjAvRGtuREdyb1F4K3JRYy9nV3B2R05zdFJvZWtwSjVXT2lVdEsvdmxz?=
 =?utf-8?B?WW1BNURHeWJSVlVRVlFJVGVaeFdVS21ENUdzNGdVbnBjZGwwelE0TVJ6N2Mx?=
 =?utf-8?B?Mm9FZDh0VzdtWjZEVGwyM3Q4cEllTmpudnY0anFOVVc4MGs4czRCWm8wQnhn?=
 =?utf-8?B?Njg4Q0dQK3ppVWhiODZBQWkwUDduWG8xZ2VRMHgzOXpRSWVSUmdwZW00Ukc5?=
 =?utf-8?B?aTRyUDJ1UEJwbHQrNStIMTBwS25pVyswNUxzVldhUE45b3BEYU1uN00wZFJk?=
 =?utf-8?B?bm0vZE5PV0lvVjJxbEkxOFhkYlIxaUJzUkFoOXdVNHp1MU4vSHRFamdJeGJK?=
 =?utf-8?B?TVRGZGpvNUNlYjNkcS84OSt2cTlXZGNDeTJXWm9ZbGNNSm43Y2dBR3F2R2Zy?=
 =?utf-8?B?SXNuam8vZ0FaN0JQWENIcmtFOHpqTmJMb3NUM1B1VFVaSW95bC9NNmVtSnYr?=
 =?utf-8?B?WDZya2F2djc3L0NEb3RvSjZyRTdldHpGWWFabWxCU1pPcWw1VGplbGQ3ekg4?=
 =?utf-8?B?UzBWNDYvUUI5dVMrTkU2c1Y3OGRDTmtvWVU4VDNtN2FuYzkvb0U5Z1hZNnY0?=
 =?utf-8?B?aXgrMXozOE9kRytQZ3dKcmVGT3huNlBpOWtQU09Db1hmeVBOc05nbXB2VDRB?=
 =?utf-8?B?dmduM3d6ZlY2MjJ3UzZPMitHN2tUMW5kTmFEZVdobXRueWpiSExoTUVvZlBz?=
 =?utf-8?B?YlFnN2c0d3k3R1cxVUhvWWQwRjUzeE1FQTN0KzJSektaMTVuMEs2b2YrbHpW?=
 =?utf-8?B?Y0VsaDJhWThpdlA4TGpteWR2UkFnLzNrU0s5K0QyYnk0RTcyK2doNjczSU5z?=
 =?utf-8?B?bURHN2k4V0E3WGpkQ3kzV1JOYU1OSlJxZEV5bldqMDFaaGJwSkVjeXdob2V1?=
 =?utf-8?B?M2lYOGxib1JLS0N2MHZERWNsUU42WmpIWFhUR2pTTGtvOUQ2amFsdlZkNEcy?=
 =?utf-8?B?N2dRUFdJUXFLYVYxdG9kQ1o3cDJ5cUR0b29LN2JJSERNeFU0MlZWdFhCVU5v?=
 =?utf-8?B?ZXA3NGhLSXMzeFZlTjVVTktxbmFBeFFuKzNEOVM3d0Nsc3l6TUdIdnZtcXBy?=
 =?utf-8?B?bndSVDBqMlBIaTg1YnpZMHI1T3Vqa3paSXdQV2NHTlZBK2E2T0VDL2VwbVpv?=
 =?utf-8?B?K3g2c1Y0TkVMOVl6UTAxWHlwMGMyM1RaanZpaktIQ2RXbmFjdXBXNitzRUZn?=
 =?utf-8?B?ZDlIc1Z2WnkzaGRER0I5S05rcFhiR2ZIZllYbVFsOXByU1FockhlWVJzRmJv?=
 =?utf-8?B?NGlkdjRWdmRSVzBIc3A5d3NJcEVwSUVDVGd2UmhHOS9LQ3FwRDhoN1BURFcw?=
 =?utf-8?B?M2dtelJrTkxoYkpWclBlR2k1Qmw4NlEwNTdQRjR3WFBQZlFxYWJQWmxKdllF?=
 =?utf-8?B?RzREU3JCUnlGVjZXK2JkV1B1SGtKZlZEdUFNZDZJcnlscGswTXMwLzlsZFd1?=
 =?utf-8?B?U21qVnpxbThUR2laa3FLcFBkSHUrTmxNaG03QzBNK3l0RkVVOTF5WDJRck1r?=
 =?utf-8?B?MHM5NjFYWDhrS3F1WHVFRUl1RVhtcEFwdDJUSXJkN1N3cFRzclIvNngwL1NQ?=
 =?utf-8?B?RytFUkNNckZVNHRqbFhYTVRjSmR4dFhZYjh0a2M2UmVyTldNbXlLSUR0c1J1?=
 =?utf-8?B?eFdHM21PMzF0cmd0ZmxiekdJaldHOXNWMzA3M3orZmZEa3RMTmNLdHVyNEJB?=
 =?utf-8?B?NGJQWDVqMDNFdU1WNmdUUHJSTndIR3pCdDVvdGR3TEFEajc1ZU5jRkxjNVdM?=
 =?utf-8?Q?KAskCsCEZ66QehpoEOgoCXug0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+8mbU7KcmUhlBnlnNn7NlSOcpxBBigJdahGu+WpFriDNzG2QThcHlBLWlVv6IOs9CM9wpeZfOwqCvKQ/uZIhKzN4DZPmCg1x4pGMejAXL6OnTln88pukMSjsBgsbk362p19doEcnqNnmeN0ePlOGSQyfde+JPqaylUbtk2bLfZiaKBdvUGkH5NvzKREw9+bHlWFHnw9WoORIMAknEs5Ydk1QX8rixeMXsEOuN4OJbpPZBFLyRndzIemZWAibYmtOKY/z1qxhDHJue4zY8ald97eecL/168fj8oWvHQ12yopEOObZA/iLNebirN0GwCAaVhrO1AU7w92RJVBfh7XrBjcsLDIDj9EcCGtrpMpYqNqmhGsgazA0QaTUjGhEbuMVwdZHXe+6vV3+RiAy+nuZ4UCTphq3Qc+nvx/emldIUBOqQEZQWZ5TT8/edXIr6NeRs/Ywq42HBfZNIPBK+JfnSLs3okyqguySH4pc1AeannwBF5n23P54QFAzixz9t7gk9ukUd0CIG8fWAhPXpDLtHNyE3RR20lx0zXcDu1R2eG6ZdchYw5+BlxQlddBBeq1ABz9uJbaD0Fi3/OsvHjtUfR89nTrtqyEnK4BzBtSwYMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a556509-d49c-4a83-c6f3-08ddcc7eb9d3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 19:58:01.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9nUdtPMfivm9UToc0HixtvnMPU6mbsRKO5XMd3RkWpmODyNjnnYWCwThxoavqXUeKcEebDO54NXNlrZof9cVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507260176
X-Proofpoint-GUID: KWFq8jlVPd7tXdd-8DED0c8dulWNYiqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE3NiBTYWx0ZWRfXwMHJ72AeueVj
 CD/uoU2XD1c9k7gIuFIhq6tF7iusrBJkEt9kiK6nTqfOQsjamIuRsodyF1l++Zd8jb5oPn1As1l
 90GotyyC9HwAPJFm8HySBJlCjv8G+I4hwu0xW6cJ/1pEl962ykmV5AnH/Mq+UmqrpRDWT6XH/rA
 k9NdlLmjfv9haK+JXqpWHvNe25o39AAhSEaJUzdOAy1+XJlqRa6qQDhOKIKyE0HG/a9Mm+3JEco
 KCjavACxdh57BUYn8YBCIBD0o3/fgwe/r+1nmvtD4UMhbCxM4aZkmZa3n9zrw2cqc6UQUgUckoF
 3ihspmVqeWdlXqpTlPlMkDXniyYNxcD9fJiOMFUXDK5aRGTMYqi7WSYtSP40mF0xlygQ5MIBAw2
 z1y3hxdzdBMMAS+8oONR+fwISQN3dI2cQCr5DTRvMPgz22e9YpHPgwwg7QPJOqJVl2ZqRoTq
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=6885334e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=cl-9nMPyz6iBtLdRwtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KWFq8jlVPd7tXdd-8DED0c8dulWNYiqb

On 7/26/25 3:03 PM, Jeff Layton wrote:
> On Sat, 2025-07-26 at 14:48 -0400, Chuck Lever wrote:
>> Hi Jeff -
>>
>> Thanks again for your focus on getting this straightened out!
>>
>>
>> On 7/26/25 10:31 AM, Jeff Layton wrote:
>>> Ensure that notify_change() doesn't clobber a delegated ctime update
>>> with current_time() by setting ATTR_CTIME_SET for those updates.
>>>
>>> Also, set the tv_nsec field the nfsd4_decode_fattr4 to the correct
>>> value.
>>
>> I don't yet see the connection of the above tv_nsec fix to the other
>> changes in this patch. Wouldn't this be an independent fix?
>>
> 
> I felt like they were related. Yes, the ia_ctime field is currently
> being set wrong, but it's also being clobbered by notify_change(), so
> it doesn't matter much. I can break this into a separate patch (with a
> Fixes: tag) if you prefer though.

Ah, got it, this patch exposes a latent bug. The usual thing to do is to
fix the latent bug in a preceding/pre-requisite patch, so that's my
preference.


>>> Don't bother setting the timestamps in cb_getattr_update_times() in the
>>> non-delegated case. notify_change() will do that itself.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>
>> General comments:
>>
>> I don't feel that any of the patches in this series need to be tagged
>> for stable, since there is already a Kconfig setting that defaults to
>> leaving timestamp delegation disabled. But I would like to see Fixes:
>> tags, where that makes sense?
>>
> 
> I don't think any of these need to go to stable since this is still
> under a non-default Kconfig option, and the main effect of the bug is
> wonky timestamps. I should be able to add some Fixes: tags though.
> 
>> Is this set on top of the set you posted a day or two ago with the new
>> trace point? Or does this set replace that one?
>>
> 
> This set should replace those.

I was confused because the trace point patch is missing, and dropping it
wasn't mentioned in the cover letter's Change log. NBD, thanks for
clarifying.

Since the bulk of these are NFSD changes, I volunteer to take v3 once
we have Acks from the VFS maintainers, as needed.


>>> ---
>>>  fs/nfsd/nfs4state.c | 6 +++---
>>>  fs/nfsd/nfs4xdr.c   | 5 +++--
>>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 88c347957da5b8f352be63f84f207d2225f81cb9..77eea2ad93cc07939f045fc4b983b1ac00d068b8 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -9167,7 +9167,6 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
>>>  static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
>>>  {
>>>  	struct inode *inode = d_inode(dentry);
>>> -	struct timespec64 now = current_time(inode);
>>>  	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
>>>  	struct iattr attrs = { };
>>>  	int ret;
>>> @@ -9175,6 +9174,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
>>>  	if (deleg_attrs_deleg(dp->dl_type)) {
>>>  		struct timespec64 atime = inode_get_atime(inode);
>>>  		struct timespec64 mtime = inode_get_mtime(inode);
>>> +		struct timespec64 now = current_time(inode);
>>>  
>>>  		attrs.ia_atime = ncf->ncf_cb_atime;
>>>  		attrs.ia_mtime = ncf->ncf_cb_mtime;
>>> @@ -9183,12 +9183,12 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
>>>  			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
>>>  
>>>  		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
>>> -			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
>>> +			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
>>> +					  ATTR_MTIME | ATTR_MTIME_SET;
>>>  			attrs.ia_ctime = attrs.ia_mtime;
>>>  		}
>>>  	} else {
>>>  		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
>>> -		attrs.ia_mtime = attrs.ia_ctime = now;
>>>  	}
>>>  
>>>  	if (!attrs.ia_valid)
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..c0a3c6a7c8bb70d62940115c3101e9f897401456 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -538,8 +538,9 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>>>  		iattr->ia_mtime.tv_sec = modify.seconds;
>>>  		iattr->ia_mtime.tv_nsec = modify.nseconds;
>>>  		iattr->ia_ctime.tv_sec = modify.seconds;
>>> -		iattr->ia_ctime.tv_nsec = modify.seconds;
>>> -		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>>> +		iattr->ia_ctime.tv_nsec = modify.nseconds;
>>> +		iattr->ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
>>> +				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>>>  	}
>>>  
>>>  	/* request sanity: did attrlist4 contain the expected number of words? */
>>>
>>
>>
> 


-- 
Chuck Lever

