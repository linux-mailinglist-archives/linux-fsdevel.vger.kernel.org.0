Return-Path: <linux-fsdevel+bounces-51486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E2AD7226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FF73B967E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88623E235;
	Thu, 12 Jun 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hyrilXyy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OlJCsg12"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE725CC6E;
	Thu, 12 Jun 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734927; cv=fail; b=mg9K2c/VdY+6UKFZdaKiuzoZw5y5sv2ru8oPa5IHErUnMPyPsH2eF+arzPT8zmF2hOy5KNAxkUy30OFoI/jTM4uYU6+pzMaU70C+FmCwH8rJIIutbThXUz2YFzIaMsffHaoQly+eDEIjE3Tjko3oxiFoHar7Lhzflcd3DUtq8aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734927; c=relaxed/simple;
	bh=ka0kKkvoTyw4S0TajvAFQno+FplJWPPOkE71UH7CzYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dea2uWf0YQ67ESkfVpRhmDgfbST+M7zq/VgxzWbujxhxzvsx3YHcVspzfgB1t6JhxtKQxyb0qU27M3A7jcxQlu55Fko/kKSL1LGfkqYhbNqGW81WyO8WD/tGM2uD+DgwIqR4pVIDbr7awjh/TZ97K30UWPZHHemlzyEOQLyl34c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hyrilXyy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OlJCsg12; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fXfg031282;
	Thu, 12 Jun 2025 13:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DyD6EXvARedeDs5YrV87yJoDkPHt1TrYrDNmddPhgzg=; b=
	hyrilXyyAz+O349wVRjePgW8FouTE+keQ9MA/XhyfXcnPbHxNhryzFWPlcydXSeh
	d2qHJUSak6463yBRLg+qmqizgos0ordL4lha12/QdF5tm6kJENMswoi11fdpTuaG
	D2mBekI9qUrvtzhyV8Azbcrn3OGRkgEZxxlaT6iPkOruJlGgQ+ilIo5uGBUpaCtv
	GNEmaKYr4b5b/R2I2HHLsc+Cw0OjwQ3/i9HkJHNLaqjevgwOfSjErlp0fF5KBHxt
	nZWyGym8GqFUFic8QCdNSjxeSGbezfwsawoHPbXCXX9GgRxh1RIfxRGWOPpYHJhT
	pr+HXaexh8Qfay6c0JnTVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk1507-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:28:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCGLl3016716;
	Thu, 12 Jun 2025 13:28:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbkqk4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7lxiw5sfjpWHRn4aNRGDBV5hiQOnhX/r/JIsOmTbsM/SqDhhGHOeqFt/0sn1cKG9Jy7ibyy03/2QYopHFKP85WjUp3wwh17gfhDlDlmDPopOAtZU5J/lVEbPJVBRXfxbZDdPlukk9S46TtJzCSBrpXHYi5Lzb2LkG064Yd4Rip/oi6PZ3eF/nVRMT+NqPlAQxqbBHejHEwijVa1cTgIaIl27fyjFeLjSuz0zljcxKTPGzgjg+cfff0QxuEL/l6vGxghVLXAQoY+gDsP/do1DBwjZQebm4wPC1wiSnPiesfIeuSu5DTqNO3LgrgnVG2lxfJrdQvbqoBOUbxNJy10Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyD6EXvARedeDs5YrV87yJoDkPHt1TrYrDNmddPhgzg=;
 b=OHQgyhBUA2sluTw/6+kC8KIFCpDraGmloy1IV+xSoFz4nlkoqlxsT6CcpFv7GrQykh2kJW8LPh1e+gKLR84ZUMxFzwxotMKCavxBP0/V+kKKGiTi4wecU0/meB4EJy0TdO4A41DiBdMLLMEmz+wQV9OgVobAaf1IMd7ksqgSbmyxAfXz/tAYNwUQBbrRXz65eI5mT/5YOrHS6SAOLb8oP2vzOEd2uuZXPaNgizSVJdjxzcfhHgAwf79XNR02yMO6XqG4PLWmtXzenZ5O9wJH1XL4hkHIDzeLQtFazJyXOGUQXTkfRjfW4Pn78gWi5HIhlX4ubc5quwF1/oB44zAU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyD6EXvARedeDs5YrV87yJoDkPHt1TrYrDNmddPhgzg=;
 b=OlJCsg12/DXz/lkw4w/NULK6LPx/6F/Dwxcm1meX4iXvWzuzEm63alvWQXFvS3APRfbTlrSe6Ybo4rtbLOyebA3dVzBCJYEWDm0bXIg2VDjkVzXEBSE8RoZno8CwGwYDDZTIUbxmzEeHNxdKpA/iLBXRCoNfyHFNIsxB6F5sNm0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8066.namprd10.prod.outlook.com (2603:10b6:208:50b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Thu, 12 Jun
 2025 13:28:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:28:37 +0000
Message-ID: <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
Date: Thu, 12 Jun 2025 09:28:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d05af50-3600-4aa5-30c1-08dda9b509bc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cEg5WW5kMjN4eHBDWjI2czVuSms5RzVETGlVZnBiNXczZU13bDBnVlZad1o0?=
 =?utf-8?B?TGlxaGozZEVyak4yY3MrbzFDbkR2U1NKTDY5TXR5b3FZWkgyU1U0V3RSc1JT?=
 =?utf-8?B?UklEaTB6cnRXRXNmUFVwaGszVGtrTGVkNnlSNmhueUFRUk1MSHlEVWxVQm84?=
 =?utf-8?B?cjBFR2RCdVhkRSswQWNzUWY5YTU5UElrYzhCMEZuZ2xaL1ptY2hSUEc3TGp0?=
 =?utf-8?B?ZGh0Y0hIYmd6K29LUnN0ck1zcmhTYk1obmZhYS9Ya2c1dS9mVVgzUWF4M1lq?=
 =?utf-8?B?NUZVYVV1N2RNYjMwZU5Xb29SdHdlWnFlL2s5Wmd2ZWh3MmY0L2lPYnJzZFQz?=
 =?utf-8?B?VzhOOGdUWG1uYVl1WDhuRDUzZVJmZG5QdndyY1VtaW9FR0lDL0RWU3VzR2Y5?=
 =?utf-8?B?d3lvYnd1RElzK3U5NEJ1bHRWanlydUNsMFNWZitGa1BkODM5cVFOOFo5dm9v?=
 =?utf-8?B?MkxWZU5VeDdTNGs2YlduY2ttblNzajFtVi82UEpzK3dIUFhyVWpjTmVqbUhv?=
 =?utf-8?B?dXlTa3FDTkdGSDFHclN0bitOTWNPYlhIUnVHM1VPeWV0WCtOdUt0OXNnK01M?=
 =?utf-8?B?d3psUEo1OW5vYmd6TVpjWFdBUGJqOGE0VklzdVJzaUVEMzZnZE1iSm5PSnYv?=
 =?utf-8?B?dk93ZzBiWHNyZSttQ1IxaWVIME5tc1J5ZTl6Q2ZJaHNWRnh2R3VPR0pFSWZi?=
 =?utf-8?B?UVBMcDFpRlFhNFRvWEw4T09YZGhVb251T3ZGd2dtZnF1OWhueW96emM5Tkt0?=
 =?utf-8?B?ZE1rYTVhRU02QnhXajhuVGJKT05VdHh6TERSMXI5RzA3UG5jR0toN1VHaFpL?=
 =?utf-8?B?MHNlbXlpUWovbndZYlY2d2wzNWpkbG03VXIzZ0dFcDgvc0RpOHFNdUZaaXBT?=
 =?utf-8?B?OWZqdFFySUR2SEd1WnVFeDN3clRqK01YblFaN3RickhYNTU1eUNRczQ3cVRu?=
 =?utf-8?B?TFd3amJNYzVWYUtIdFRobFlNM054bkIwcnBvS3NEenBlR1gxZGxVcHZpeWhh?=
 =?utf-8?B?NS9OU0xJdTc3QjZKdURSRkZJRVA4U0RYSjRPd1hwYkxMT3NZcHU2ODRQdHNt?=
 =?utf-8?B?bnl5b0xhOG1ueldSYVF5ekIyNkhZd0h2dTJMQkNET3p1UzgxRE1WTUpQZXlM?=
 =?utf-8?B?WHZYNzlTOHRzOXlkclVtMXpDdEZJbWJWTVZoWFlJOVlhM0I4T0Y1YVZnYWlr?=
 =?utf-8?B?ZlVlbjdUQmtkamNrOFA1K2g0MlFoajFGL1luSVFFK25DOVVMSzNLUVBtU1gy?=
 =?utf-8?B?emRQaUVhVDFMNUo1cVFzNWRualpINDFwcGdBMUl3bHJvUkI1cnFLRkhKNzh4?=
 =?utf-8?B?OG5PNTAyaUVZTWc0VXRJSXlJTFFGVG9ic3U5OFVjTXlqVk9GRWdtNGJmQlBr?=
 =?utf-8?B?ZlowMC83VTFUVnJkV0k1RWNKRzFUeUU5YURtSzJDWURseHN0RVI1KzFqeFBB?=
 =?utf-8?B?bzZxdzNpUGc4Y3IxbDZzc0dlZ1NUcVlQNFlGbUxPMmhpcWtaWlF2TXNrVGdq?=
 =?utf-8?B?T2FOWi9LKzNoZjIxTG5kNVBSSmlpTWNmUFVmTlZIQWhqME1WR2ZHMHVvL1ha?=
 =?utf-8?B?VWJEWitLbDJGTVJBRVRkT0RQUEF3SnhWR3ZjbllsT3JKQVdVZWZuV0hpdUNo?=
 =?utf-8?B?S01ZOU1xeWUxR1hpRWZWKzd3anpVQm9QY016dFh1aXJYekZkMEFwZUhSbWJ1?=
 =?utf-8?B?VVZsMHVOd2pkYkpjWEMvajlDUjVDdVFjd3JGemtiSmhLc05DTFMyOVArbFg4?=
 =?utf-8?B?eE9ZM3FMdnFtZjlPRXkvV0c0SzVJMEZSQ0NIZzlRRmVkVnZEc1JjOTBIaXRM?=
 =?utf-8?B?TzFqNkZPM1VUak5WSFpVQ29Edk8rVXRPaU93UVI4cjNLNkRzcnU1WUR4enlB?=
 =?utf-8?B?cjgxSGt0ZXdSSlU0Q2VVL2w2VHdQcm9NK0pvUGVJQVZ5VjQ1NUxSQncyRERF?=
 =?utf-8?Q?Akmq9u7QWSg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d1IwaDhvRUZVamxCV1laOHFFSUJ2azhsak5WeGJhM1NLWnJlQ1FNUm1nQk51?=
 =?utf-8?B?YnphclhXWHBzYTBqQXBOWk41ajhSdmJ6QmdQekpTdjZYOXZqeVNrZVVaMHRj?=
 =?utf-8?B?UGhKa2VxT2VLcWU5Z3Y4d096UmR0WXY3YlV0UWZTSm9XSVhNQUxMMDF6SE9i?=
 =?utf-8?B?aXNsQVhieXBtTmgxN0ZVVWFwSXpzUlhxTC9aVWNzellKbmxGNGRjU08yQS9n?=
 =?utf-8?B?dnFxMnJSN3lUcW4zUkdnVVNjaFZRMGo1K1Y0Sm93bVFEQllZaTF3RmUwK2ZD?=
 =?utf-8?B?ZmVDRW85WUhaY3ZPVm1qdlEwQTg5Q01TWnM2YWhXSForL01RTGJvemRwQUNp?=
 =?utf-8?B?UENSajhWd3hHaGU1VGJRMCtLTytUWWhxc29TRmtPSFV6VmJ0SHFDSlNWRzE0?=
 =?utf-8?B?M1E5SXFOMnFEcW02VVhIODVwOXAwYWF0U2YwVExzNnF0NE9ZaHhMdnNXcHl6?=
 =?utf-8?B?S0lwV1ZhT0Y2QUtZdkVlbWxBYVRFTEZsOU8zVEFJT1NwdXBLYmx6ZFVkVkVM?=
 =?utf-8?B?VUgzVVBuMGo2UTFvTGdUZktFVlYybGJEU0UxYjZmck9weER5U1lxcG95RW41?=
 =?utf-8?B?QlFJY2JUM01qeTVMc0ZRZUdlSVVMSEdMWVBTcDZqNVNXbW5hckJkNkVCZm5w?=
 =?utf-8?B?ODYraTVUMTVFMGYwMTZEZDNMa28xWXlLSm1sam95S1AwQlJaTE84a0NXSGhX?=
 =?utf-8?B?OEVsd2hvZm5FUWpkU2laUWxxZDlkOTQvQW9Oc0N4RnVaQzJPcXlhSUhNdlA2?=
 =?utf-8?B?MDJLMkN2YU5TcG5Id3haV2M4ZHV6TkJieStNMWthTksreDhuUG9xYzNJZExB?=
 =?utf-8?B?ZUtvTmxlaUVBUCtWQ2wwUkQyVTg5d2RHSE5tMTAzUVhyNkR6YjJDbHZVeXBq?=
 =?utf-8?B?OUE4c0NpYkhFNDVHUDFYYm5BSjhHYzdha3FmdlpnRWlXcW80YUNMVW9PQXd4?=
 =?utf-8?B?N0FLZzVPRHViNkM0NlFsSEtsK25La05NY0xpMEY2VXY3MnQxajIyR3VEL3Rq?=
 =?utf-8?B?ZkdKL0l6cVlZMFVrZmF0c0tXQVpqS3k0Y1J3OUhDQlZjNmVnSVpVdGZ2NEFv?=
 =?utf-8?B?NUpzbm9XYkdDWGpLczlncXNKeG5YNHpxd1llQkorOE05MmxpUUtnZ2QrRUJ6?=
 =?utf-8?B?SFowNjZna1RJamdrbDlHTFd3MFcwYnZCcmRRdGdWaVhCT2tkbExaelgyeUNa?=
 =?utf-8?B?VERWajVja2l6ZlZ0RTB4aThwQXBxTi9BS1l3NVNQSEJRVkFXNWlybGpQdUlW?=
 =?utf-8?B?czVkRC9iV2Rtc3MwSjEzdXVrVjljTTMvNVVtL0kxODN6WDkrd08rSVhuYW1v?=
 =?utf-8?B?NWczTm1jTDB2UUhKblJlWVhuUWdFVjFocHFWZ1lyZnVlZ2dwVlF5aWlSczBX?=
 =?utf-8?B?djd6Yi9LMEdaYjYrbEtaa1IwYWFaampnMTBLNm9nR1FxSVNYTlMveU4vVllz?=
 =?utf-8?B?cUg1eDRpWUVoUEp4TGhQcE5KREJ6a3NXbUtsZVhsUmw3UDNVdFAyQzh1eXNO?=
 =?utf-8?B?UElDVXM1WVZkamRKVjJ2TFhBdkNOc0NDT2tGWS9XU3AwMGQwcWtBRWdlQVR4?=
 =?utf-8?B?RU5sRjBwQ1dPRTlCUUZOYlJwRE1GNklCRnNXYVhjY1FHL0xFZGc5eUhkR0Zi?=
 =?utf-8?B?Vk5MUnpwM2FkYXJFWG5hWGk4K05qeHUzYzJjVG5FYm5rTy9mMGNnWVpmSGtn?=
 =?utf-8?B?SDNJY3pJS0twT1JFREtEV2lzZDVYMFFrL0l5cG9GeXVidllQSkw1ZHVJRWtl?=
 =?utf-8?B?NTVvZ1FuS0xYTURKWnZvVFlYY0pOZlRzZktWU3JycW9PTDdBZFdxU28zeWh5?=
 =?utf-8?B?aitlWDlUWU85czdHd0tyRHYrL0htdDc5czhUQ2FVM1IrNmxRQXozeWlaTjVh?=
 =?utf-8?B?cFNjYmNBZ2hjM1Bobmp2M0FzbDJsVFZZbjRaaW1tbThIMkVDUGlXekJTb2Qv?=
 =?utf-8?B?R0VmUElCUFFWMTJWYXhHeGt5R09keWFoR0d2aFZ3N1UyNDl6NzUrZk9MWCsz?=
 =?utf-8?B?VEduN2RYWXhlNWhabkgwOTc1YlcrUEVya0ljYjNyM1N1bjFwcWtmcVdjaTQ4?=
 =?utf-8?B?a1pSMTFVOCtLdDZtZzZnNGh0YXFNUlo3bUNqSGRwSVU2K05EcTRXUCtWK2ll?=
 =?utf-8?B?UEc3VENFdzdqUWYyTGVma1lXemtySUdYejMxTE5sekhuRGNJdEZ1R2Z2YkRy?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ol9wa15lX4dMpb3kWVnrvZj/46z4y1Q9CuShJPMNfFSUf25mCz+LSQte6TRKxS5lPk/h2q3X92kJUX6kjbX42JllHeefLPzYwUZ9joNR+b/VBkPIENAmeuKGuplZSYLgBWrTQMhSan9AwE+s0FG0BLkfEcB6EfmnQGmJtcLx9vz9NjEFTEet509XjLtmgUkz3Bz4D4WGEWzAFul9tYom/SU6nrve0eboLY5HMqQrdFrZp4dgi0rKNQuXoTMOwE4Ap5ymoYyudLieaFL3ih/xk0DRSzVuBuDWYwo/QKUSIp389S0ikwU4DBqTnTk4cRG28DKZHHWujNs9xaKcyUavo7Wp3d0o68yoDlZbzQJBKBED2npN4FsxacCOQAvvmeQn3hitH2MroySwjzvkqbiBcPfFaQtN5CLUmKYMzD81GLhWwCK/uP+jq7eYJXQEEeLRiCYggc8e1yoe1oxzleA7X87lFEkq5Ttoi09OBBX4WlS/XixHrrYhGUW8KLpJvqMi8Kj+fx5TXn3jZAfmxws6aEVkTT2CUFKY9QGbF+s8rH7XpfIJVxaI4zaoFzcjwz8Is6cBd70DJIOjxHK3MMej4IA3S55ELGbldBDmjd5M50s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d05af50-3600-4aa5-30c1-08dda9b509bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:28:37.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1uxkDUwn50N55Oa5RP4Tnai6yl6kyNVWSursN6VQqJVi0AXMeCF2keNo32g98z6TUTn+d5o2wY5nCqAYy1HLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120103
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684ad609 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=HqPsqNtGgo7iutim:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=43QhLNX9PU9y0T9zbOMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNCBTYWx0ZWRfXwcs6s+MIPE2/ ejskZ201I49UMsBEravj40XXQvN510uz/WzPtkkKZ8xaasRR/BfSV7Zir7UtRCbCNPRZru1WOfK Q94c4Y+yPhhWEZ1eXNVWY3AvVLTkD/fvZM2FsuCnEIqfp9+fP0SUf19ZBjgZPZEaL4ab5CdsOb2
 KmlXO4PsALpXsaBb+4hb7jaWMbx08KMmfZMkMCegT/MD7W0fcKExA0nvnNfWQQzNuyiqGFsYkGC t4lzpjRk9l1lon20SfQfEd86SI61mIbYxYDwny5qWySvw6tJ5ABJu/SYsIJbwYxSH+h+tqtFQ7Y AjqoLGsczgpqE0h9+5ClE8o5E8qj6kN3l4BmDBZNSdQTDLyWcJgSPPeWFfk9OAGCRmNPr9leTtJ
 9KsuHsCOQYP6VNZsfOwnC/7xu0OgBf0a0S0dHMxlxqaS6+cWE7f0Q2Om8dQJhTcWy1/Nhxuc
X-Proofpoint-ORIG-GUID: EC5RqaXkhCN8THsgSyvcYOBTzhGiGP05
X-Proofpoint-GUID: EC5RqaXkhCN8THsgSyvcYOBTzhGiGP05

On 6/12/25 6:28 AM, Jeff Layton wrote:
> On Wed, 2025-06-11 at 17:36 -0400, Mike Snitzer wrote:
>> On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
>>> On Wed, 2025-06-11 at 15:18 -0400, Mike Snitzer wrote:
>>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>>>>> or will be removed from the page cache upon completion (DONTCACHE).
>>>>>
>>>>> I thought we were going to do two switches: One for reads and one for
>>>>> writes? I could be misremembering.
>>>>
>>>> We did discuss the possibility of doing that.  Still can-do if that's
>>>> what you'd prefer.
>>>>  
>>>
>>> Having them as separate controls in debugfs is fine for
>>> experimentation's sake, but I imagine we'll need to be all-in one way
>>> or the other with a real interface.
>>>
>>> I think if we can crack the problem of receiving WRITE payloads into an
>>> already-aligned buffer, then that becomes much more feasible. I think
>>> that's a solveable problem.
>>
>> You'd immediately be my hero!  Let's get into it:
>>
>> In a previously reply to this thread you aptly detailed what I found
>> out the hard way (with too much xdr_buf code review and tracing):
>>
>> On Wed, Jun 11, 2025 at 08:55:20AM -0400, Jeff Layton wrote:
>>>>
>>>> NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
>>>> DIO alignment (both page and disk alignment).  This works quite well
>>>> for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
>>>> maps the WRITE payload into aligned pages. But more work is needed to
>>>> be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
>>>> used. I spent quite a bit of time analyzing the existing xdr_buf code
>>>> and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
>>>> misaligned pages such that O_DIRECT isn't possible without a copy
>>>> (completely defeating the point).  I'll reply to this cover letter to
>>>> start a subthread to discuss how best to deal with misaligned write
>>>> IO (by association with Hammerspace, I'm most interested in NFS v3).
>>>>
>>>
>>> Tricky problem. svc_tcp_recvfrom() just slurps the whole RPC into the
>>> rq_pages array. To get alignment right, you'd probably have to do the
>>> receive in a much more piecemeal way.
>>>
>>> Basically, you'd need to decode as you receive chunks of the message,
>>> and look out for WRITEs, and then set it up so that their payloads are
>>> received with proper alignment.
>>
>> 1)
>> Yes, and while I arrived at the same exact conclusion I was left with
>> dread about the potential for "breaking too many eggs to make that
>> tasty omelette".
>>
>> If you (or others) see a way forward to have SUNRPC TCP's XDR receive
>> "inline" decode (rather than have the 2 stage process you covered
>> above) that'd be fantastic.  Seems like really old tech-debt in SUNRPC
>> from a time when such care about alignment of WRITE payload pages was
>> completely off engineers' collective radar (owed to NFSD only using
>> buffered IO I assume?).
>>
>> 2)
>> One hack that I verified to work for READ and WRITE IO on my
>> particular TCP testbed was to front-pad the first "head" page of the
>> xdr_buf such that the WRITE payload started at the 2nd page of
>> rq_pages.  So that looked like this hack for my usage:
>>
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 8fc5b2b2d806..cf082a265261 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -676,7 +676,9 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>>
>>         /* Make arg->head point to first page and arg->pages point to rest */
>>         arg->head[0].iov_base = page_address(rqstp->rq_pages[0]);
>> -       arg->head[0].iov_len = PAGE_SIZE;
>> +       // FIXME: front-pad optimized to align TCP's WRITE payload
>> +       // but may not be enough for other operations?
>> +       arg->head[0].iov_len = 148;
>>         arg->pages = rqstp->rq_pages + 1;
>>         arg->page_base = 0;
>>         /* save at least one page for response */
>>
>> That gut "but may not be enough for other operations?" comment proved
>> to be prophetic.
>>
>> Sadly it went on to fail spectacularly for other ops (specifically
>> READDIR and READDIRPLUS, probably others would too) because
>> xdr_inline_decode() _really_ doesn't like going beyond the end of the
>> xdr_buf's inline "head" page.  It could be that even if
>> xdr_inline_decode() et al was "fixed" (which isn't for the faint of
>> heart given xdr_buf's more complex nature) there will likely be other
>> mole(s) that pop up.  And in addition, we'd be wasting space in the
>> xdr_buf's head page (PAGE_SIZE-frontpad).  So I moved on from trying
>> to see this frontpad hack through to completion.
>>
>> 3)
>> Lastly, for completeness, I also mentioned briefly in a previous
>> recent reply:
>>
>> On Wed, Jun 11, 2025 at 04:51:03PM -0400, Mike Snitzer wrote:
>>> On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
>>>
>>>> In any case, for now at least, unless you're using RDMA, it's going to
>>>> end up falling back to buffered writes everywhere. The data is almost
>>>> never going to be properly aligned coming in off the wire. That might
>>>> be fixable though.
>>>
>>> Ben Coddington mentioned to me that soft-iwarp would allow use of RDMA
>>> over TCP to workaround SUNRPC TCP's XDR handling always storing the
>>> write payload in misaligned IO.  But that's purely a stop-gap
>>> workaround, which needs testing (to see if soft-iwap negates the win
>>> of using O_DIRECT, etc).
>>
>> (Ab)using soft-iwarp as the basis for easily getting page aligned TCP
>> WRITE payloads seems pretty gross given we are chasing utmost
>> performance, etc.
>>
>> All said, I welcome your sage advice and help on this effort to
>> DIO-align SUNRPC TCP's WRITE payload pages.
>>
>> Thanks,
>> Mike
> 
> (Sent this to Mike only by accident yesterday -- resending to the full
> list now)
> 
> I've been looking over the code today. Basically, I think we need to
> have svc_tcp_recvfrom() receive in phases. At a high level:
> 
> 1/ receive the record marker (just like it does today)
> 
> 2/ receive enough for the RPC header and then decode it.
> 
> 3/ Use the rpc program and version from the decoded header to look up
> the svc_program. Add an optional pg_tcp_recvfrom callback to that
> structure that will receive the rest of the data into the buffer. If
> pg_tcp_recvfrom isn't set, then just call svc_tcp_read_msg() like we do
> today.

The layering violations here are mind-blowing.


> For NFSv3, pc_tcp_recvfrom can just look at the procedure. If it's
> anything but a WRITE we'll just do what we do today
> (svc_tcp_read_msg()).
> 
> For a WRITE, we'll receive the first part of the WRITE3args (everything
> but the data) into rq_pages, and decode it. We can then use that info
> to figure out the alignment. Advance to the next page in rq_pages, and
> then to the point where the data is properly aligned. Do the receive
> into that spot.
> 
> Then we just add a RQ_ALIGNED_DATA to rqstp->rq_flags, and teach
> nfsd3_proc_write how to find the data and do a DIO write when it's set.
> 
> Unaligned writes are still a problem though. If two WRITE RPCs come in
> for different parts of the same block at the same time, then you could
> end up losing the result of the first write. I don't see a way to make
> that non-racy.
> 
> NFSv4 will also be a bit of a challenge. We'll need to receive the
> whole compound one operation at a time. If we hit a WRITE, then we can
> just do the same thing that we do for v3 to align the data.
> 
> I'd probably aim to start with an implementation for v3, and then add
> v4 support in a second phase.
> 
> I'm interested in working on this. It'll be a fair bit of work though.
> I'll need to think about how to break this up into manageable pieces.

Bruce has been thinking about payload alignment schemes for at least
ten years. My opinion has always been:

- We have this already via RDMA, even over TCP
- Any scheme like this will still not perform as well as RDMA
- NFS/TCP is kind of a "works everywhere" technology that I prefer to
  not screw around with
- The corner cases will be troubling us for many years
- Only a handful of users will truly benefit from it
- There are plenty of higher priority items on our to-do list.


-- 
Chuck Lever

