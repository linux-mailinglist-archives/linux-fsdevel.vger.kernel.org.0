Return-Path: <linux-fsdevel+bounces-43728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16EA5CDD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1179189507D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51241C72;
	Tue, 11 Mar 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a34XNF4d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aJ+VGnNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF5260A43
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717533; cv=fail; b=ptVLcc5heFu/13i4PWt56ikOzopepaqnK/x7TnVh/ZAjmTZIDcY5DQTY821k888HtOgxFUUWJ637KrVtoxrN5r8ZvpGEXAhVB1WIiuhXxfHez8dh1kwT1nv+adZpg3PDDXB4HII/MgdWJVMIv+mRA6grE0L34e4pCSxKES8mBng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717533; c=relaxed/simple;
	bh=bAD8beTlogeGXYn8f/2y6JE+yY2sLDpjp/TcMRgnNDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D5YYbFZSr9WGMAVqeGM6n193VfidzJP2tvDX/rD1n5r8r7cv3IHJW9SRlVsoKRgy/ZYISp3rsDwiXyWXRk9HROcON0ruIHolO7KIpGFJ5i8Ql+SMpVWcpVEvlMKxm86F+Lm1jhwn/BgCSw5+WwmdxTPV1ZXwbmertclg6fm7ueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a34XNF4d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aJ+VGnNM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGQnFR004079;
	Tue, 11 Mar 2025 18:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nRtOPMutXcjqvNiJ3AgcQT/zwI8fwf1v43HEEr4B1io=; b=
	a34XNF4d+sknvi6u7OC1qGTLZAoMbt7GuZe2Ks7QZA/Nl1960MQl64xixOAaa/BS
	JxZus5m2H6ha3NYRGZkon73Hkpuu6SUdoDX4h2KM54i5itQU/TwHwTATPUqnI/PF
	HkhrGiuRYvgxEq4ei7zGogdDSldeY72sdgDUAtZzXv8s1jE8vjxdH/HJWL/YCYQ2
	DDhSSYMxZoSZEoIfiPlBYjnPyNYl5uOZ/1sjL6OLFCrywVf+OO9f+bCs6yWMJQ19
	gN7i1h6l2cyGWDqz9pl15eScEARiBCzRultkSJOpfz7KvQDraJBkPsWyUYRdPxG6
	dFmUi4xvM7itEfy6AvCALg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt5gbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 18:25:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BI8kwB014977;
	Tue, 11 Mar 2025 18:25:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbfqhu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 18:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5v/cSyUq/ukFufwbJGWa56WLKs9lpBrEUMs7EaazIXJD5/e312kcflw/klQG629WAy8SQM185N1xJ3P2UluLRBuADdxpHapB1yTMNzrwSD/WB2yssibs2kb6HmjRwGqmEpNg2rbg9L57qfYSFNvktRz2YBLHz1qXgkqEmIfcwb3JIhDKsPURJkK9oPAugFWgAz/FXWGtvFbOlHURsJNCnqcdGY9PeYNnraT0j0BmpI23xs6h4Xl3r29A1Fl+pWgt3syCm9h+GZO16EbCY35z3+R6tkoe1K/HQTyNUVnZxdKXOOkS54w3X3iJ/CV6IbwXV4y+tWxm9C4Kn4puUaC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRtOPMutXcjqvNiJ3AgcQT/zwI8fwf1v43HEEr4B1io=;
 b=fVjAskjzZuPLQ2iw9UcilwDMfQNECoQFRODM/VZZnjvtc44OvIgbcIOVaSxMgU5WCMUYFdyOVLF74Y8CujbbfDmqkmsF5DxNQCX72UuFkxdrroaza5VPzRz5oHsm9und5nUaxQU52V2dvHY75iRpeF1JLWUHrD69KhV6OGTbH9a4f+YFCrBIagPBdomq8kVuzC/CtDE/XRfuG0onEOJsvq2khUsMkd3Hv3mSqrVJc5my7JSY1XO9VZx2SDvxO6ysOnAGvy4Mvy9mafv3jdwX2YW4FJygPcYaQ3iZul/x/c60fmHsjldOq27By+KkwAfSsnjmCyyzBUXDuEZk6YayNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRtOPMutXcjqvNiJ3AgcQT/zwI8fwf1v43HEEr4B1io=;
 b=aJ+VGnNMJvXI0FbYfTyoH9kotqhjurVQTJrLswk62rc4pVOkOjC6nJiBjis+xCOxU/XqkrxCRXBxChj7XImVyA1JVvl+5IExnllrT+EtzpeHpizcGFbH3K3uodZiGfLFY+Y0RL7qYK5W0YOz2NHQy2EroMclvnCQ7atjmzW8mpk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Tue, 11 Mar
 2025 18:25:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:25:16 +0000
Message-ID: <2fd09a27-dc67-4622-9327-a81e541f4935@oracle.com>
Date: Tue, 11 Mar 2025 14:25:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sun Yongjian <sunyongjian1@huawei.com>, linux-fsdevel@vger.kernel.org,
        yangerkun@huawei.com
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <20250311181139.GC2803730@frogsfrogsfrogs>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250311181139.GC2803730@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:610:51::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: ca068088-c521-4460-ba44-08dd60ca125f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpJYWx5RmVtV2xmTUVoVWtIei9sQ1hPa01BeEY5WUd1OUR2cVhnTlpaR29s?=
 =?utf-8?B?U0dFMXV3M25Bc2dyRm9PVXM3V0lwYlpCWG50ZkxNOG9PYWtqT1JNZ2RrbU1o?=
 =?utf-8?B?Z053czdzSldBZXQvZlErWmdLQWFQQ1BZcXFmNEtQVjBHNjN0aXZEaHhXWVM1?=
 =?utf-8?B?YVY0NkQ4TTVWOWx5ODZGL3pBb1NRazZTcmd0OWxKd3ZJMzRMck5qa295aUlm?=
 =?utf-8?B?YXM3V3ZzSEtrTjZzRnAxTGJqY2xyUzJQa2JWSUFhamdUZGV3ZkVsYlpyS3cx?=
 =?utf-8?B?aE5OQzNMcG9YR0lMaTZjVWlJSlRmL0QvNXcxQ2JlZWZjTXBaWUFpTnpKcTBE?=
 =?utf-8?B?aVdZQ0Jsb1NtU05OQ2wycmpVRWEyOXFRNklVd3hrcDYzL3daSW1lVEhORUMz?=
 =?utf-8?B?MHJIY1ZkOUhiRFNlSU92TkZ1ZFp5NFlHMjRwTi9tWXN5WFNVdnZkemx6VDJa?=
 =?utf-8?B?OStTVWFCQ2dTYjVONklBYkphVGt3MEZnVE9wLzRkKytwT1k3N2pQaDdaeExF?=
 =?utf-8?B?dTgyd0xINnhUaWtNd044eUI2S253YS9sNEVDQ3FJY0E3K3B3N3VEVXR6MUlU?=
 =?utf-8?B?a0Z6TGtSZkNycW5aYWFWNyttWG1IYjVXVCtMa1ZuK0FhYmtTeEptUUorYUFV?=
 =?utf-8?B?cHdVMXJlRXdjMWhTc1hmWlVpQXNSUmJ1UFl0a0RYQTB1TGNGTzBUenY3VUgx?=
 =?utf-8?B?WlVBQ21wZnBlelBLbTJ1UFRQdmtseFJnZzZHSVI3SzFHUUlucFdBVnkzS3NL?=
 =?utf-8?B?WDNmMTl6STU5V0xlVm1uN2dDM1ppYnRqMysrSlRHQ3FyODFFRUNJM3k0UGo5?=
 =?utf-8?B?MEM1VDFyMUJKWWF6K2tLVHNSYkl5R2pYbDhmM0NYWE1pYThTRVFRNjVheGVI?=
 =?utf-8?B?UXdoMTZaM2hLVHp3MEIrV0VYWHMrZFpDMjJkNHIzdkVJMjZXTFB4RENSYjJy?=
 =?utf-8?B?RlNvOVg5d1M5Z3lIdGJsMkJWdWQvYS9hZ05ZUE9yb0ZSMEJZMTFYQW5VcDJ1?=
 =?utf-8?B?MkdOV1JEbG9VV3NPRmNTTlNBNjVDdnFHWGRMSXRNWWJjQmV4TVlZOTg0VW1K?=
 =?utf-8?B?OFRkTWlhVGM0SVF0Uzg4cnJ6czlodzZoeGVMSW5veDExVHNpTWJoQnZKeDZo?=
 =?utf-8?B?QTdUWGx4Unh5bGxyemR3b3VnTmRTaU12OHAvTWcvMytBT2o4ZVZVMjVBMFYv?=
 =?utf-8?B?UGxGSzZmMjdoVUlKU3A2QVR2bHdOT09BaVhlcnBnVTZhRGhSVU81cER3bUVR?=
 =?utf-8?B?SDFPTktGWDZDQk11OHoxeDU1RlZYRXE4WmpwK3E2L1JMbVhZVzhQeTZiYVd1?=
 =?utf-8?B?dm5aUUlBN2JCaHk4ODJoTVpUUzVWREhHaUNjQVI4UndWL28xK3FpekNBakRn?=
 =?utf-8?B?V0NxTEVXdThiWmxuSjRkQ3E0eU1taXd2cXJHbmk2K1pjMDMxd1pYdGZVTm9m?=
 =?utf-8?B?cEdEbDYyYTg3QjlLVmJlbVNzek5rMktTN3hpRzFVYVc5Wmpud2R2Z0orc2N1?=
 =?utf-8?B?bXhRVHMzcFdzWlM5VithNFU2TFp6YnFkNDVzK2NhbVd4b0tsYm9keGQwblE3?=
 =?utf-8?B?czlZUFFDYk5CREl4RU1mNjF6SEUxUmZxUUZoYTEyNWVqOW5IcGt4cDdPTnE4?=
 =?utf-8?B?U2owbjNMSWRjeWFmZEtDMm9aVEs5NlZwbDRmcFNYWmxLTnNQR0ZJQ1diN3RR?=
 =?utf-8?B?UFR0dFAzYzdRMzZyQ2lvb2lIb283RHMzWHFhSzhJTkNvVWl3cm9HWEtYekNs?=
 =?utf-8?B?V0FtNHdCZ3kzSThWQlVpZXZrQi81L21pcUJEVUs5dGhlZG0vRitxY3dZWmhI?=
 =?utf-8?B?VVN6bUVway9QTktCTFkrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NZamw2eVdNdkFBLzFqSXRTdnh5eWVDdUhtQW02QXdMNmdtZ0VlV1pHaDh1?=
 =?utf-8?B?V2t4WEd4V3JlWGRLUUFUWEFVN2V0WGc4aDBiVzNHNURqYllmQ1dKSkZONlor?=
 =?utf-8?B?WWpFeVNSWGlJTjBoTGIyZnFrR2N0UmdzRlVLcEZiZ0c5aElFcEx1MUd0My95?=
 =?utf-8?B?SlAvQ2dUTXEwT0xvSGxTb0ZpYndMWlBKUXM5NFJMSGxXcmRmY0cwU21lc1hk?=
 =?utf-8?B?dUI2SXNpQkVwdUllbXM4VWxJaVRXTXRIdi9xT3FTVmlvT2d4YkwwTG12NEtz?=
 =?utf-8?B?K2gzTFliRTRuaS96bkxTOVhIQ3VnR0JjeFV0cnJSdWwzZTBMQXhhaE9UckR5?=
 =?utf-8?B?NmM4OEE3dEw4RHlVOE1tVldDMG1wL0hJR3pNaUx4bWNhWFI5UkhCUmdBdjdn?=
 =?utf-8?B?RldQSkpPaHF2a3hnWmEzR2ZsQ0ZtbXVmNjJEbWNaZnRleTMzMWtjMDl6KzFp?=
 =?utf-8?B?cVlDdEZJOWFWTDRHNm5Da0V3QUVYSkZXa0lCSWt5VVo1c0JiTHFLMTN5MTEw?=
 =?utf-8?B?WlB3bkRrNSthbUcya1dHWXppQWJJdlNta1lkK3dQajlRUjdQMDlpQ0hTTklT?=
 =?utf-8?B?Qit6SDlIR1paQjJBYnNmaG9YS1Z0VEJZalY2eVMzOXFTVXhNZUwrYWhHNzBv?=
 =?utf-8?B?V1BRT3VlZXhzSlFwZlpYUlVmR25NWm8vbEd5NmN3aUJHY1RSQjZOZmI2UGNC?=
 =?utf-8?B?dmR0OG5FR1hObVpHVlE1b0lNVk16TVp3TC9UQzRmeHJGQjR1ZnVpZjY1SFVL?=
 =?utf-8?B?OUdEZm84OGdmYUpuY2wwR0JIZy9iMDhtK1BqemJMcm1kQnM5TDB1YmtXRjdK?=
 =?utf-8?B?b3M1a0hIRXUrYUI3Tjk1dmJWMnEvTDlkY29BQVh4MnZzYi8waEpMY25ZbDZ2?=
 =?utf-8?B?WlBJSnRTci9wZlJwdk1PdmF3OFhaZzBCWWJRV0JLWWo3czJBUkZINUU1OHRa?=
 =?utf-8?B?VXRKM091TWV2TG94QVVycGRROFg1MnhXdGk0enFqLzBQa2JHSkdCQlA3ZHgr?=
 =?utf-8?B?TURTRVZCbURwNGNwUHV1ZGtZZDdDVE5KL21TUWdKVXlBdmovTnVYOW5CV2pR?=
 =?utf-8?B?c0hTNTRwOURSYWJoSkF0NmtVeWZRVDhyWXBLUW1FV2orbzZvanBRTkFCeHpG?=
 =?utf-8?B?Q0NXRzZsb2FMLzAycGlYc0RqVGtOVFBVVWJ2cmM4eXluREo2bjlzSUhUMTl6?=
 =?utf-8?B?Y1ZNK0Qzek0xMmJRelFkVWorT1psbGtBU1dhRm5vampVUExkLzBpUlFHeXhM?=
 =?utf-8?B?ZmFJSEFKZkx3T1h4WXBGSU9McjFHY0c1MEVMeUFnT0E0ZVRQM2NtbDRuUWd0?=
 =?utf-8?B?SUh0VmdkMjkwL2ZKNWExajRPbUZBdDAwZEF1OUpHOWRlb3BtK21xSkxHMTJr?=
 =?utf-8?B?bzUyeC92ZUEzTGJFMFRpalJsVVBCQlZuRWc4bjVIcDBoN2ppdUNuMzhyL254?=
 =?utf-8?B?S3pKaWRVUE1JMDZnTDNtM1RwNWlxR2ZpcTRDN0lDekpPQWlGY1psV1ZHSURa?=
 =?utf-8?B?VmxBSnhBZG9LbVJCYnZrek9nVktrK05GYk1TTXNOTDdGTVIrazk1VlI4OUdJ?=
 =?utf-8?B?V2xibTFsTEtvRFZMdE9pM3pKQWlwY2duUVJMSjF5dExnVG1hS1hxMVB3Y0Ni?=
 =?utf-8?B?cjNRcHFScnIwdzhvTDZBK3VHaXBraUM0Ri94WTRmaWZRVFBtNVZRWHA2MU5Y?=
 =?utf-8?B?N1d0eFllZkMvNTFFcjA0dzM0Vi9xRFdHbWFmT2ZnMmpKVXg5bHVia1dKNndn?=
 =?utf-8?B?QUVWRGxLazVvanVUOGZGSDZVclUyR000TTNRVWhMcWFjd2daOFN3UEtQKzNn?=
 =?utf-8?B?eFJzM09SQVJkYVJFVWpkb0o4Zkc2RmZabWN2NUhWb0lzc3Z2NnFraGQyT1dC?=
 =?utf-8?B?NjBOOE5RZDdocmZ3bHYrVmNFNlNRc1lvcFd4VldvamczMTJUa29LQzhjbml6?=
 =?utf-8?B?TnpVSHQ0V1Y5QXhCT2lTMHFGUVEwQ0wwaHBFL0lTcnhKd0huR09DMEFFdkpw?=
 =?utf-8?B?Vi9ZK2ZVZnhUL2YwMzVoRFJFRllTVUJwYnBFcUtoSG5TZExycE1hU0M0ZmlM?=
 =?utf-8?B?R0liMVBoZHZZNXlQK2R0WGczY2s4UjRuMXEvK3NRM0JqTmxvR0pJclpSNnlF?=
 =?utf-8?B?N2hvMDBuZE5jYm9KcHptT0c4aFhoUjBPM05MVnIyYys2OERKbDJnblJkRFVX?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g2+i/bVT3FPhTD1d2w9hyExDOvuEfnL4NEP2SyTPzT7dPSrAeXYK7J9nF0hXA8MEUq4Yz5gnbx7iRRf8Im9Lr4Xr5FtWP1SufoF4cWR12aE5xmRDt6TBqUJ0nSNHtZMaQkz496gJV7X0H7mCXwu3VnITafOnh2upgJWD2B2R9iDz24g2ffdE4M9CBhTye69fpyPCvlN9Eo31wbEMRBm6asYft0y4JbgTpX/BiRwmQyXw+1hQB+lifrkHSKOyNv2ArmnmGPrX2hTcMNW08/1Cry5x/jXpdAtW8rFr+qs0YMZssoKDC2La4oDPSf64lroIez5dZyxkc079k+FOYSP07mZkjldlxjV6JIhW8CgsOlpCNtvHTy7VKOKFb7lRRUSdT0Wx3TH2jc1fbWlzpP7JP0oW7KcyhuQiDTxvaHUl2+35LLvqrBpLbYWodKBW4Cu35d700VIVF8lEYZmcbf8fRAwq31FKQB0lZIlnMdWIINaSHH7CDiIq1Z34gRlrbQolJg8wsh01wBMMCaUGNITx0Id8eJiDMzN5Umi0oYZeCm4eJgtDaRN/VZz08oWvXF42yCUUfbWiNQXUnM4JHSCbPLQKSWiEBM3LgXbouy83AHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca068088-c521-4460-ba44-08dd60ca125f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 18:25:16.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/gQfmMbnHy+lwQBhwjUduQ34quaSfEwavlPO9SfdiH32wHbR1Ofcim9hqzmmAJqPqIpYFy0zSbkarJDCbMbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110118
X-Proofpoint-GUID: FyNudN-0pUmCm1u4Si76CEHaealdJ7SS
X-Proofpoint-ORIG-GUID: FyNudN-0pUmCm1u4Si76CEHaealdJ7SS

On 3/11/25 2:11 PM, Darrick J. Wong wrote:
> On Tue, Mar 11, 2025 at 11:23:04AM -0400, Chuck Lever wrote:
>> On 3/11/25 9:55 AM, Sun Yongjian wrote:
>>>
>>>
>>> 在 2025/3/11 1:30, Chuck Lever 写道:
>>>> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>>>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>>>>
>>>>>>>>>>> There are reports of this commit breaking Chrome's rendering
>>>>>>>>>>> mode.  As
>>>>>>>>>>> no one seems to want to do a root-cause, let's just revert it
>>>>>>>>>>> for now as
>>>>>>>>>>> it is affecting people using the latest release as well as the
>>>>>>>>>>> stable
>>>>>>>>>>> kernels that it has been backported to.
>>>>>>>>>>
>>>>>>>>>> NACK. This re-introduces a CVE.
>>>>>>>>>
>>>>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
>>>>>>>>> reverted,
>>>>>>>>> then the CVE gets revoked.  But I don't see this commit being
>>>>>>>>> assigned
>>>>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>>>>
>>>>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>>>
>>>>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
>>>>>>> reads
>>>>>>> for offset dir"), which showed up in 6.11 (and only backported to
>>>>>>> 6.10.7
>>>>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>>>>
>>>>>>> I don't understand the interaction here, sorry.
>>>>>>
>>>>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>>>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>>>>> directory offsets to use a Maple Tree"), even though those kernels also
>>>>>> suffer from the looping symptoms described in the CVE.
>>>>>>
>>>>>> There was significant controversy (which you responded to) when Yu Kuai
>>>>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>>>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>>>>> That backport was roundly rejected by Liam and Lorenzo.
>>>>>>
>>>>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
>>>>>> problem
>>>>>> that does not depend on having a working Maple tree implementation.
>>>>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>>>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>>>>> certain adjustments) to kernels before 0e4a862174f2.
>>>>>>
>>>>>> Note that as part of the series where b9b588f22a0c was applied,
>>>>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>>>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>>>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>>>>
>>>>>>
>>>>>>>> The guideline that "regressions are more important than CVEs" is
>>>>>>>> interesting. I hadn't heard that before.
>>>>>>>
>>>>>>> CVEs should not be relevant for development given that we create 10-11
>>>>>>> of them a day.  Treat them like any other public bug list please.
>>>>>>>
>>>>>>> But again, I don't understand how reverting this commit relates to the
>>>>>>> CVE id you pointed at, what am I missing?
>>>>>>>
>>>>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>>>>> premature to me.
>>>>>>>
>>>>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>>>>> first to fix the regression and then taking the time to find the real
>>>>>>> change going forward to make our user's lives easier.  Especially as I
>>>>>>> don't know who is working on that "simple fix" :)
>>>>>>
>>>>>> The issue is that we need the Chrome team to tell us what new system
>>>>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>>>>> examine as complex an application as Chrome to nail the one small
>>>>>> change
>>>>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>>>>
>>>>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>>>>> I will start active triage.
>>>>>
>>>>> What ever happened with all of this?
>>>>
>>>> https://issuetracker.google.com/issues/396434686?pli=1
>>>>
>>>> The Chrome engineer chased this into the Mesa library, but since then
>>>> progress has slowed. We still don't know why GPU acceleration is not
>>>> being detected on certain devices.
>>>>
>>>>
>>> Hello,
>>>
>>>
>>> I recently conducted an experiment after applying the patch "libfs: Use
>>> d_children
>>>
>>> list to iterate simple_offset directories."  In a directory under tmpfs,
>>> I created 1026
>>>
>>> files using the following commands:
>>> for i in {1..1026}; do
>>>     echo "This is file $i" > /tmp/dir/file$i
>>> done
>>>
>>> When I use the ls to read the contents of the dir, I find that glibc
>>> performs two
>>>
>>> rounds of readdir calls due to the large number of files. The first
>>> readdir populates
>>>
>>> dirent with file1026 through file5, and the second readdir populates it
>>> with file4
>>>
>>> through file1, which are then returned to user space.
>>>
>>> If an unlink file4 operation is inserted between these two readdir
>>> calls, the second
>>>
>>> readdir will return file5, file3, file2, and file1, causing ls to
>>> display two instances of
>>>
>>> file5. However, if we replace mas_find with mas_find_rev in the
>>> offset_dir_lookup
>>>
>>> function, the results become normal.
>>>
>>> I'm not sure whether this experiment could shed light on a potential
>>> fix.
>>
>> Thanks for the report. Directory contents cached in glibc make this
>> stack more brittle than it needs to be, certainly. Your issue does
>> look like a bug that is related to the commit.
>>
>> We believe the GPU acceleration bug is related to directory order,
>> but I don't think libdrm is removing an entry from /dev/dri, so I
>> am a little skeptical this is the cause of the GPU acceleration issue
>> (could be wrong though).
>>
>> What I recommend you do is:
>>
>>  a. Create a full patch (with S-o-b) that replaces mas_find() with
>>     mas_find_rev() in offset_dir_lookup()
>>
>>  b. Construct a new fstests test that looks for this problem (and
>>     it would be good to investigate fstests to see if it already
>>     looks for this issue, but I bet it does not)
>>
>>  c. Run the full fstests suite against a kernel before and after you
>>     apply a. and confirm that the problem goes away and does not
>>     introduce new test failures when a. is applied
>>
>>  d. If all goes to plan, post a. to linux-fsdevel and linux-mm.
> 
> Just to muddy the waters even more... I decided to look at /dev/block
> (my VMs don't have GPUs).  An old 6.13 kernel behaves like this:
> 
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
> getdents64(3, [{d_ino=162, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=3, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=394, d_off=5, d_reclen=24, d_type=DT_LNK, d_name="7:0"},
> {d_ino=398, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
> {d_ino=388, d_off=9, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
> {d_ino=391, d_off=11, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
> {d_ino=400, d_off=13, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
> {d_ino=402, d_off=15, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
> {d_ino=396, d_off=17, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
> {d_ino=392, d_off=19, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
> {d_ino=419, d_off=21, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> {d_ino=415, d_off=23, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> {d_ino=407, d_off=25, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384
> 
> The loop driver loads before scsi, so it looks like the directory
> offsets are recorded in the order that block devices are created.
> Next, I create a file, and do this again:
> 
> $ sudo touch /dev/block/fubar
> $ strace -s99 ...
> <snip>
> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=458, d_off=44, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=945, d_off=45, d_reclen=32, d_type=DT_REG, d_name="fubar"}], 32768) = 416
> 
> Note that the offset of "8:16" has changed from 30 to 44 even though we
> didn't touch it.  The new "fubar" entry gets offset 45.  That's not
> good, directory offsets are supposed to be stable as long as the entry
> isn't modified.  If someone called getdents with offset 31 at the same
> time, we'll return "8:16" a second time even though (AFAICT) nothing
> changed.
> 
> Now I delete "fubar":
> 
> $ sudo rm -f /dev/block/fubar
> $ strace -s99 ...
> <snip>
> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384
> 
> ...and curiously "8:16" has gone back to offset 30 even though I didn't
> touch that directory entry.
> 
> Now let's go look at 6.14-rc6:
> 
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=28, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> {d_ino=420, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=416, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> {d_ino=412, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=408, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
> {d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
> {d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
> {d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
> {d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
> {d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
> {d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
> {d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
> {d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 384
> 
> It's a little weird that the names are returned in reverse order of
> their creation, or so I gather from the names, module probe order, and
> inode numbers.  I /think/ this is a result of using d_first_child to find the
> first dirent, and then walking the sibling list, because new dentries
> are hlist_add_head'd to parent->d_children.
> 
> But look at the offsets -- they wander all over the place.  You would
> think that they would be in decreasing order given that we're actually
> walking the dentries in reverse creation order.  But instead they wander
> around a lot: 2^31 -> 6 -> 10 -> 18 -> 7?
> 
> It's also weird that ".." gets offset 28.  Usually the dot entries come
> first both as returned records and in d_off order.
> 
> However -- the readdir cursor is set to d_off and copied to userspace so
> that the next readdir call can read it and restart iteration at that
> offset.  If, say, the getdents buffer was only large enough to get as
> far as "8:0", then the cursor position will be set to 30, and the next
> getdents call will restart at 30.  The other entries "8:32" to "7:1"
> will be skipped because their offsets are less than 30.  Curiously, the
> 6.13 code sets ctx->pos to dentry2offset() + 1, whereas 6.14 doesn't do
> the "+ 1".  I think this means "8:0" can be returned twice.
> 
> Most C libraries pass in a large(ish) 32K buffer to getdents and the
> directories aren't typically that large so few people will notice this
> potential for skips.
> 
> Now we add a file:
> 
> $ sudo touch /dev/block/fubar
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80  fubar
> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=47, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=948, d_off=28, d_reclen=32, d_type=DT_REG, d_name="fubar"},
> {d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> <snip>
> 
> The dotdot entry has a different d_off now, which is strange because I
> /know/ I didn't move /dev/block around.
> 
> So I can see two problems here: entries need to be returned in
> increasing d_off order which is key to correct iteration of a directory;

I would agree, if POSIX made a statement like that. I haven't seen one
though (but that doesn't mean one doesn't exist).


> and it might be the case that userspace is overly reliant on devtmpfs
> returning filenames order of increasing age.  Between 6.13 and 6.14 the
> mtree_alloc_cyclic in simple_offset_add doesn't look too much different
> other than range_hi being decreased to S32_MAX, but offset_iterate_dir
> clearly used to do by-offset lookups to return names in increasing d_off
> order.
> 
> There's also still the weird problem of the dotdot offset changing, I
> can't tell if there's a defect in the maple tree or if someone actually
> /is/ moving things around behind my back -- udevadm monitor shows no
> activity when I touch and unlink 'fubar'.  In theory dir_emit_dots
> should have emitted a '..' entry with d_off==2 so I don't understand why
> the number changes at all.

tmpfs itself should have completely stable directory offsets, since 6.6.
Once a directory entry is created, it's offset will not change -- it's
recorded in each dentry.

If that isn't what you are observing, then /dev/block is probably using
something other than tmpfs... those offsets can certainly change when
the directory cursor is freed (ie, on closedir()). That might be the
case for devtmpfs, for example.

-- 
Chuck Lever

