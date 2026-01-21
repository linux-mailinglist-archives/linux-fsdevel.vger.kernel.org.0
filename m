Return-Path: <linux-fsdevel+bounces-74902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBl1N+RAcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:11:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8503B5DD70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC6205845FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DE3A7830;
	Wed, 21 Jan 2026 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="C4YxsWiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE63A89BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023171; cv=fail; b=s0Q1+BkMoqThvfZD48ZHkA1ltsilLwt6MwoopU4lkv/eb0ADrJTqpc+bUo1G2/LyXFMGp+MvTR0Nuo4r9L4BQxWO8DvHmb+s85xurTl6r3bXzRFRdMB9pGoIvShnUyXrsu5DSD+Oy9PmlxBp8Ez1aSrSCGz1p5XUJ2ZyW+fnbAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023171; c=relaxed/simple;
	bh=kOu4HG2irrRpkAQrfz17B9/67x1IPZYMAv0pfGNzoSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrvtXtL87tQABEmp+7oo7zUVMrhfeUlac6sNyKYxJLFw+EbVgp2VkCGJ3SROndITJh/TiXap9DnEpagkR4ZYyqxVSVTNTkpusyWbcLuZXExdbh2B9OqWP1A8cBet4z6858MlGA8ZaWSLLSX7aHzHB3/QenGV0tiy5iPrePPVrik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=C4YxsWiQ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020128.outbound.protection.outlook.com [52.101.56.128]) by mx-outbound40-118.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 21 Jan 2026 19:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG26OOXVSi65DAi3ocvQgSgpAsgL8y5mSh7LFPE268YL61Iu0y8XOdd/eaBunO3xwVAy/frUynQLzlWE/fULJGJaK0bopMb8rK36lGT0AgRe0eYUdriIb+mgZVu/yFl52tFQAU5zrhsNNFvEj8Sz2oZNV6c8B63vefF3PAm7zVZ2kAjtG1SP7hEG8JmXyEGUdcwH4VNYHlGPf5TPMRPDamI7hY/avlgrqLlwg+MC7onVuObpIo7RN40z30yyasLj+o4VHnW08O4IENSCAta2sz8F01wT0uAdFxHEATmZWp7+CtU61WraQcIq9gOiDRYzF7M35f2UqLdEiIVlrcoGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOu4HG2irrRpkAQrfz17B9/67x1IPZYMAv0pfGNzoSU=;
 b=IgTUzCYbdDqIu6DKo1RuHaG0foKhtcYd+pEAKS8PsYKN0avLvGPMi45GhGP6HLNYAJ14SW5dvDE5+KWE4+lFH7IOHjjqNDJ5iDmZtF9YGY6IjPG8FHdqOk34iBVMhSxrqahpFwEc1hAK9AN5i4maWkmOc//b9Y9SeLl6IIlNwIIXDcbzYrEQRQ+6TSFWc3EqFscwLEIjzBNtMXLayL6RKsVoKzDsoiACdujU5TQX1By5hh2IfYu6laqoJ7kd9xv3hZA0VjDFOOeAfV497KL0XSIZEoe/DmG/pQJSehdJYk/HaOC1nadapSlLJyJ8KNo4OFk+4CyLlXqztHVUikK/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOu4HG2irrRpkAQrfz17B9/67x1IPZYMAv0pfGNzoSU=;
 b=C4YxsWiQfdv45oZsK/AK7l0GUHZse0UXGkdw370n4ROEHNPY8t3gQSoL/8OkPLxz2Hm353LaqtkHgJTA3SuDiezrlLab/mzvvg/Bhz8HL8l0ke6xYNAfI3e/RFMoRAvRLxH2o8IPyfj4Pj5CgF7aKpXStvxfzOK60rxr1PbNE6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by LV5PR19MB9131.namprd19.prod.outlook.com (2603:10b6:408:2fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:03:37 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 19:03:37 +0000
Message-ID: <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
Date: Wed, 21 Jan 2026 20:03:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
 Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com> <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp> <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com> <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com> <aXEhTi2-8DRZKb_I@fedora>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aXEhTi2-8DRZKb_I@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::17) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|LV5PR19MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fc62f9-6c86-4795-bbf2-08de591fc848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azE2SnZ3czROZVppSDVtOHBOamRCRGl6OWJMR0djRVprRFh5N2kweFVFOWU1?=
 =?utf-8?B?NTErVmd6aTRYTjhMY3lDWGdBNkdKdzkzVUUzL1RPcjNPdGhxcWpybng1d2RU?=
 =?utf-8?B?TWVFeUU4NGxJRW94NmZFVzNtUkVCTmYwZllWN0IzR0trVVd4K0JQdlVML0Vl?=
 =?utf-8?B?MHpyQWdwNTVtK2RSVjdEbUkwM0tsdW9ZVGkxdXJqOUNkRDVEQUFVcnZ6cFpL?=
 =?utf-8?B?WUVpd0JGdytkbVc3UUZmelJiblNiMHhxUlVBZVlDUkVBRStCNy9aaTNKRjdm?=
 =?utf-8?B?Uk44TklVZVN3Z3Z4ZUplQ1hMRjR5Y1JMVlBjUWlHWFVtMzN5VGlhQlZ6ZWFK?=
 =?utf-8?B?b3pVTEZFY1RITGFhQ0RURTMwUm5HcVV0SU5oVW16OURFUDA3c1UrYlNFR0NB?=
 =?utf-8?B?NkYrMGVRVlJ3OVhsUlYzbDV0MlBqbmw3UVhoMGp6aGNTdXVTS1dReXFvbjdo?=
 =?utf-8?B?dmZ3WVFtbGMweHdBbzVhWndIdXdrTitUNndMUkNuWURXaUU5L1VaWDZxM1VR?=
 =?utf-8?B?MEQvK0NKWmVqbWRnL3lUbithMGhmZ3d0NndYZ1QrOWFXY0FvMFJGZVBNTTBh?=
 =?utf-8?B?c3dvZlBsOENCTlNpcWZuaHZ3bG1mOVp2aFh0bjZzakJiUFRHZCtkV2ZDcEZ5?=
 =?utf-8?B?SFFuejB6WkliaFd4YjN6MnBxY2tUSlJGdFhGTGxKd2ZNT21lYzZZYUE4WENJ?=
 =?utf-8?B?ZlpCODlEUHNiNEw4MndhSHpxemFhMU5MK25YWHU4S3h0Y1pqWVRocGE5aGRh?=
 =?utf-8?B?VWRSR01XamtmanYyNjZFUFl1YmtZTDVkeEcrZzBpb2VSOGd1ZnBBb3YyVUR3?=
 =?utf-8?B?OGRQOXNFR1pjNkdDL3pIbkkvVUx4cVBZbThpQmJuTlNHcnBuR3lIbElETmh2?=
 =?utf-8?B?QndYY1ZXeVllYTB2NUtkbSt6UHhHVmF5VDlKamtNMXZ4V1ZNZWx3TktLRnBs?=
 =?utf-8?B?VjFrN1NhRUw5YVlybkw4MHJWM2IzNE1IVGRrKzkxTzQ3WXJ3bEt6cW5vd3Fz?=
 =?utf-8?B?a3M0OXI0aklnSGxGRzgvbW4ycjg4TW43STNOTVZhUGxRWVZGMzlkL3MzMUlh?=
 =?utf-8?B?dE5xL0UvNm9iMnJUSlRMZVFFQVZvM2dYSTJLd1VNOVYzU0JKMmRmZEZHbnRn?=
 =?utf-8?B?TldkMUcwMEZLUW5uOS9qTndXUS80VDVxNUd0dVM4OTZVTmk1UVVObjRTQU13?=
 =?utf-8?B?Y0hDN1htNnRPMm5BckdNOE1ONDB4OXJuYUFRa3lhQ2xLNElyZjE2ZlhlSEVj?=
 =?utf-8?B?dHdNMzBaWkRpVXhGT2MvV0d0Q0R6U0JQYzBnQnZVNmQyM1o3UGZCWXZoVzRy?=
 =?utf-8?B?MnhVelNYR1pSbzFGeDQxeDk1ZUZsSm9wUU1qVFpYUEZXcHNST0JjaE1EOVcz?=
 =?utf-8?B?SjlEZzlDUVVleFFUclkrc25mSHNycGZPK2FIcFVzR0NrOEVoTFRrQWlydFRU?=
 =?utf-8?B?bnBPemQyYzJVd3VoU1EyT1VoUVFZa1lQb2ZBdFNrVXJ2cW96SE9abjFRMDM0?=
 =?utf-8?B?NytoN3RWWk9xc0RqWTJKVnovK3Y4d2hTME1CaDhhbTNvZmI2VnhiRE5VV3Z5?=
 =?utf-8?B?QWRGbkk5KzZaWE1qV0pDRHNJOEdISHFQb2ttS0Jodm1NaVB6b0JOY3RuNHdY?=
 =?utf-8?B?Z1Q3eWZhcE8rZVFISHRYdFA4dlREQytxNHlQMitBSGpHZUE0YVZYWTl1MlhE?=
 =?utf-8?B?NGs2RlBoS2pYT1RhWXVUcFMzZ2FXcmxubnRBd1IrL1pqQmhrM2V3NnRCN1FQ?=
 =?utf-8?B?K3Q2VEtURitMT2Z5ZDI0MWtyZStaWkxHaVhaOHg3TXpiMGI5VnJ6aHZpQW1o?=
 =?utf-8?B?RzB6bDNYeUFpSXpsQXZRa1lhWmFGUWY0YTF0bkVTVFZSc280YmJOMnNCaXJU?=
 =?utf-8?B?UG5ZRythMlpmL0p4d0xkVTVxNVMrMXJFZHgwdnB5aS9aaEYwdWFnYWxZeVNC?=
 =?utf-8?B?UEdEV3cvRDY0bGFITnpnbDZwSFFpVUtJTHFLTGNWbjVLVlNwWXNMZnBaM1E2?=
 =?utf-8?B?bUx2WlpzNjhrQVpySGhnRWpMVURma3pBU05NYlVxWTBvdThVemt0bnUvUlk0?=
 =?utf-8?B?OERKbXlTU3Nvci9GVW9BODJnT0dxYkUwQ0ZEemtxWE5CbjNVYnFTWGJtNXFT?=
 =?utf-8?Q?2XPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2lTQVQwVTI5QkZCTldGT3pha0hiYUFOeVN6dlk5WmVKRThKN1BSZXNjbmZZ?=
 =?utf-8?B?ZEdrcGVoajRxUjVub2owLzJzcUVSajltY0ozd2ozZitGUW4vUnpENkV4MWlU?=
 =?utf-8?B?QVFLL3VJRkNGNDZnT0dlUjVVZVJuT01sOWNKNFB2ekNxYUM0ZUcwendlLzF5?=
 =?utf-8?B?R2tHb3BrUW5PSmpROG9zd1Rra3pBWGc2SENJYXFWK0xDWGw4TTZiUVdnWjgy?=
 =?utf-8?B?cEcydm9BdWFBRDBQM1RzL2RINW9ZelNNWGZGWGdBUkpHdktoTTlablZ6TzIz?=
 =?utf-8?B?cU5QSThyUXpBeXNYUVY0K3dMRndUaUVMTXJxaFNJWmtHSi9tcDdnVmVLQjFD?=
 =?utf-8?B?RTdCMHlwaEVoQkFFUW8vMEZiSkJjektYWUpYTHZQc1VNSld2OWtaOE1pbEdy?=
 =?utf-8?B?My9YR0FKT2ZyQ3dQbnAxbk04a3l3NGVVZ0kySytzWXVTcmNCRXphVVArSXgx?=
 =?utf-8?B?NGdVYjVzZXNMQnErL1puMk05SDJRdUpBTnJKdmJrOWpaZmJtNEZCVGRCY25T?=
 =?utf-8?B?U3Y1UjhWNGVURjVka3pjMEt2V2JBRkhxSTlzcXdCL3Q2VDhVUTR2UUlzVURC?=
 =?utf-8?B?Zjc3NmJ2NTIweXlZVFZNWHpqYVVOVU0zZU1LRFBRVmtWeTJKRmJEL1lwMzRq?=
 =?utf-8?B?dTFaUHJ0bHZpc2tHVkdQV2JVQnpSa21kb0twbEErSy8rMDY1OVhXVWljdnJF?=
 =?utf-8?B?bG1lVzZCTkE0dE9SeXZFaFc5QjB4SEtQOENDUjc2QVNlcFVEMVhDaDVxemhY?=
 =?utf-8?B?cE1pckZLM0g4Rkl4TVJpaW5PWnNPMGRsUEVRQzRoZG1mSm1XOXRIcW5CbDBT?=
 =?utf-8?B?QTZ0bi91b2pXRXpoQ3BVWlhDQXpSNU5hQkd5Z1FDa0N4QzQzZHJOdEUvYVhz?=
 =?utf-8?B?YXhOMHExRHhoUEdMc01MOC9BVjY4MWdsSzJ5TGlrVCtvNW9Wa2lNYW0wS1dv?=
 =?utf-8?B?ekZtdWdrTHcyTmVmOTVDbU5OODNaN0xiakFrVjRBeC9ORmVMczJzNzMrbGEw?=
 =?utf-8?B?L0k5Z2l3T3R2c0NwUkVjRytReGtTckxCVDc5cWVXSHlVOThkUXVoREFMdWlp?=
 =?utf-8?B?QVAyYmxBQ0g1YnE0dm9ieXRiNG1aRVdOZHFTWE1jZU9pc2JJdDBqc3hyaXJw?=
 =?utf-8?B?K0xQVFcxYWg1N2NweC80VTAyZ3ROWk9ycmZJdUtmOEZOeVVqR2FQWnBIWXF2?=
 =?utf-8?B?NXRHbFo0WXpJdzZHV0pWQVdLU3lCazRhS0czSG1heU0xM2JWd3NBSXB4aElR?=
 =?utf-8?B?RHVMcWxCVnJtc2FQSHd4dElHb2RHV1NHaU0xMDkzLzZyeUVZMFZHZ25wbmZU?=
 =?utf-8?B?WDVnY3cwNHkxZlpCelBwdzJWcm12L3NNeCtNQ0tJN081MHNqamhHYzNaS1J5?=
 =?utf-8?B?RjQyR2I5VHRSeUZ4aCsrSXp2ZGNicXFXQ2hSS2xZWTBrZGQxUUR3dUNUd3pG?=
 =?utf-8?B?ZHRCLzNnM3Nmb1c0Q0ZwRGN3aDgrdlBST3ptcVpEcHBXNTA2OWlLME1WdU50?=
 =?utf-8?B?ZjhDcGg0bEJmYnNnWEdpUi9vRURCWkx5MEJqSEd5TlMvYURyejlJNnZuZWs2?=
 =?utf-8?B?N1dyaG1OdzVpL0hWN1Axb1RueVplK2kxMkpwdUtLdEgyU1o2M2RQb2R4cWNy?=
 =?utf-8?B?YWpvQ1Axb05sTC9XZ2hrRlE2dFRyRWU4UFBhd2JDM080L3RBcEN1Y1BiRkl4?=
 =?utf-8?B?TmxuWndpRVBHRmRZcFdNczJMaVdBbzhsNUFucDNOK3UwN0RBeVExRGQrN29v?=
 =?utf-8?B?YU5kZmR2QnRuaWZsVFZJSHFxOHk3UHdrcmkvSmFEdUREQ21vSWl6c2FDYmg3?=
 =?utf-8?B?RU5LUitJdC83MEFxcnFGRFJPZ2tlWTJjSzhveGROemJvVXFEN2JXcWVCMjZH?=
 =?utf-8?B?V3VMVldSWDN6a2ZWcWkyRWJ6aHFLSnUwTFQ1ZHR3cmlyVm84RTBhQ3VTVWhh?=
 =?utf-8?B?cGZ5RTJnbXg1S2M2eXR6Z05qUTZxUXJWYi9kY29SZk9jSmNEWVlmSWlJNWQr?=
 =?utf-8?B?ZTNiZ2JSWWRLckx3OEpGWU5qWVlLYTJQWFBhcHdMZFJ4bWJmOXJ5STdzRVha?=
 =?utf-8?B?K2ZaMG1ybG4xOFVrVnNEZnpodGxXOEFZcUlibG9STU1qKzFoMG9hbXI2UStI?=
 =?utf-8?B?M0ZzNVloalBTT0lDU3IwSXdTMjZPZXVxSHV6emFIK3hxeG9LcnlYRkx5YUVa?=
 =?utf-8?B?VXgvMzZ3VWUyeFVnU1BvYUU0VmRUbGRaaTlkQ2JXdGZRZUVlZS9rbzhmMFJW?=
 =?utf-8?B?UG1Db05DeHhBRjRJU3FNKzZXMXpBcDFMaE81ZTlWSjdCd1VKeWRJMXd6L3oy?=
 =?utf-8?B?czdnVjNiZ3R2dmczWGl5N0UrWEFybHhyTFNOSks2TDE1Zm1mNWhtWVlIVmJP?=
 =?utf-8?Q?Unj6SlpMjvxOHUb0xY/Vc1871cLGe/JFZacL9qOWgnAJ1?=
X-MS-Exchange-AntiSpam-MessageData-1: ysqe0aOlc1XSVQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ESbOE+wQx/H0Ue4CF92kJWMO+JaIYfEWud4GYbPcC1MzL7EYTuCMLDq97jLsrxa1ScbLyKCKa1lMK39CIlJEmNh3kNHyo+obbipouwZPk9B4deXWdOoDSXVqwGdCpybYeVeolx5tczveonlaQAeN8sk4vdQNSA/Wo5ersb/jAhgLcWKDhVw3DAkNo5+FpzcvghvW+fH7wlv2m+le8SLN3OTONNzIcWN8bWSnhVsy1MV5xWTWhCqE+iTom7XoaiEWvEzCe8f6k84ztqJBf5fwm9OtcSrBF6XLylHM/7G4V5InRGBBAnrm+ERjwF47nQEXsE9RwYVAYYmdZVL3Z6ocRjMi+P+dA2NsHopqY9e6e47BPDusXm4mR9Cj9voEYJBd0wIqLLdWWdZoyM5pea2vBdc+fH7Z8vtwkhZd68FHF7rPlBn1xgdhWF4TedUZy0RgiDSGCtY3M1/pNDtoZchivSw3Dh9g3GAWw0m1GB7zUWQ4RV2YxcVmgRF6QKEnUbKzo1D6Vr/6pQ12ZSU8CmEhL+Nm9IrV4I5md/odSXGU7rBoxI9auzWrSpz90O1rMQh9BIsIRv6SGbCfuAIKMgCyQ6t7KTRkn6uG2yT0a4U4ZrYf1m2K5kEFfBegh6ztOZnGnu5HA8dE9Y2yl431eX45A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc62f9-6c86-4795-bbf2-08de591fc848
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:03:37.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dYyVXUZcNkbIwx2VAqXxrKECZ21/kWG9Pg3y1dMrlS4MWmeRFv4xcKT+PMy02zJ3ojTtUEzjgC1ncEAI22QFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR19MB9131
X-OriginatorOrg: ddn.com
X-BESS-ID: 1769023166-110358-27501-12996-1
X-BESS-VER: 2019.1_20260115.1705
X-BESS-Apparent-Source-IP: 52.101.56.128
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhbGhkBGBlDMJMUiOSnRMsnSIt
	E4LcncxCzFNMnUyMI42SwpMSXZwkipNhYAMlCTrEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270566 [from 
	cloudscan23-198.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ddn.com,reject];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[bsbernd.com,igalia.com,gmail.com,szeredi.hu,kernel.org,ddn.com,vger.kernel.org,jumptrading.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74902-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ddn.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ddn.com:mid,ddn.com:dkim]
X-Rspamd-Queue-Id: 8503B5DD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 20:00, Horst Birthelmer wrote:
> On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
>>
>>
> ...
>>> The problem Luis had was that he cannot construct the second request in the compound correctly
>>> since he does not have all the in parameters to write complete request.
>>
>> What I mean is, the auto-handler of libfuse could complete requests of
>> the 2nd compound request with those of the 1st request?
>>
> With a crazy bunch of flags, we could probably do it, yes.
> It is way easier that the fuse server treats certain compounds
> (combination of operations) as a single request and handles
> those accordingly.

Hmm, isn't the problem that each fuse server then needs to know those
common compound combinations? And that makes me wonder, what is the
difference to an op code then?


Thanks,
Bernd

