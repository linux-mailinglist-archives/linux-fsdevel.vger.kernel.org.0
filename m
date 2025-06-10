Return-Path: <linux-fsdevel+bounces-51183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB6AD4132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3F189ED16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C53246326;
	Tue, 10 Jun 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCbcH9BD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oop9fGpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263E24502D;
	Tue, 10 Jun 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577471; cv=fail; b=AMjJqzNQCNbC1/n5cS49hHIPcPf/l61eN11HBIAjjPNwDxkWYfCBG4tza6B0ZBGaiEDIr/QGRSeB/GkBdqQegJS6gKoZhVeXTglUsMurYVphCTBo/eFjxYIDjY44EtOedEoYpwUFI20kSu2akCuJTyrD2oSEn4zNRkO/IxzV+V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577471; c=relaxed/simple;
	bh=gImGSRENL6kvkedGishkokfAoDBwf1YFYyEyKcl1vOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pmdaLRgmhVsdF8QnWgFNX4jU/x/LjuwNsN06/eBIa//7r/1f/90cXqYoBfLDLUDl012J9jio2jRtaG/L3w1/9IYyBVKXr13M1bFtGuCdOj5KLeo5lOi6bAFY8xwN964jA07gGf8D4AwOifgFNFEh1LCSsh4p1baCuioF25rASg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCbcH9BD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oop9fGpJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMZkR010137;
	Tue, 10 Jun 2025 17:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=euhvtso0TEbfQXI4V26DSkVANWMntVRc8Zyf9vqpXvI=; b=
	XCbcH9BDDWuFi9iFns1CQg3Wi1pjfSrQpZnEuljh6B7hxLy2iolFs5x0avG8++of
	9LeEjuyxEr9dRagUQ+nq5hvkRI6xhsjr0qmPO2XcrI5WQtcxgxEV7DsmX3EGIHzn
	tl44VjAL+o9kqyk4Dmyo6suPiR1Xt4HVL0StRb5NARZ7g3lxvnwr29GQ4fr3lukn
	U6AMUbr41vgaiD1rNeKJUggU93PwxeUkVIaHHupMs3VjxnJvXKbhhRvcHIU9KCQv
	YB0vr/UM6q88hTkFXpHF0txocoWREi1OMFMJmnxgQywTK9Aizr6KR0lIe5PmJ01V
	ROB74KbLqabDfsNJmqF9lQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cr9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 17:43:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AH2bC5007378;
	Tue, 10 Jun 2025 17:43:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8st2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 17:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afJ7R+bI8i7dNERJ/LtQocL5CyFKhl2x4pPdooigw4E9fzd2CO8sPAehrTtGhpIml56xNy4TOuaHDMdwW7+V0xQIJCmhCLxs+juGiSAnpI4oFu3z2pD5M2XWnSwryhj/xJSHkvooh7Bhf/Es7V5MfNuu82kCcvn2vFBB0PABMpi51+aiqwZzJNPZTtjUyx+/hgUx/rgqfbVzM0W6PSmSzr13+D/8GYUaB13/OroQ27rcx/eqodjpGDb6bHL/nz/7slt5hdoRT6LMudIk9TgYrU2lJV2MxsPczM+8FlJn3W18BuVsSGH3wcIpu0vhLMYrw5eUbYOVH90gLS4yTTGlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euhvtso0TEbfQXI4V26DSkVANWMntVRc8Zyf9vqpXvI=;
 b=XGg1eVpmT3SWiOcC7hSfecvBgQgWBYt26X7lcWlflv8uUtLypJfa1tjYyxcCTJQ9vuN++fb4/PyOzPPzG7JYWDYlsXvAw6k8+baftn/p/MKrhxZQ1QlK9USGEYygsTRDbJBc7Skb4PUbpoDDYbhWC8U1HDvRYP9WgFpnPIiImHw33OFW2Y6begNLsnokgxiaa53Osh8ZBUpTvALz2j2gjIGhbtGT5MKMAQLMWPhx/ANL/0vP3mFZ7rKXCdzaAkfiYyDWL/y9VhPSrPlvTB4ZIsctYw8tVQvvWN67qwBolKYOfvHZ3j9LILdbtjaZiyw2K2N5eCnvDlOwPfr/X+3caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euhvtso0TEbfQXI4V26DSkVANWMntVRc8Zyf9vqpXvI=;
 b=oop9fGpJMPZLFUe9I4WBxCia3QmrSRrbPmZkS0BiazZ8yujU64xmMHPKNLPzXiJlkLKRkUEunCZV6nEiA5bKjZdVX+rogSWY53FBPQ4833Sfhim2157IIV42nENBgSpQZzTvgwF6+gDx8a05W3CcVJwg2SSgqpjkGii7sBDQSDg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 17:43:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 17:43:33 +0000
Date: Tue, 10 Jun 2025 18:43:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
Message-ID: <6364468a-ca45-4e21-8c4d-3d9c4e6396b8@lucifer.local>
References: <20250604231151.799834-1-surenb@google.com>
 <20250604231151.799834-7-surenb@google.com>
 <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local>
 <CAJuCfpGxTdnEgKj1Mgu2bGK_6rxnBd=Sk5HiKKdp38uMtEHu3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGxTdnEgKj1Mgu2bGK_6rxnBd=Sk5HiKKdp38uMtEHu3A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0634.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 963742bb-add7-4823-4a35-08dda84651fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGNNcENvOHNSb0ZsemJ1K2JGSlNpRUsrR2dkZTVodWdFQTdhemNPVmxLZWJN?=
 =?utf-8?B?R2RYYUZSL1JoVEJITkdCbEZHVFgzUXNtOW1IMmtsUU1pWHZOZU5oM0dUSmZP?=
 =?utf-8?B?YXRSVW54RWZrUVdSQ3M3a1R4d2ZPZ2ZVS202ZXZGWHZySGlwNE53ME5uK3ZC?=
 =?utf-8?B?eXBJSEc1OW9VQ29tdGVwY2xDNk1BVW9aTmFyd3VMUmc2alBhL0JaY3JrSWVy?=
 =?utf-8?B?SUpVanZyellLNDYwb0xvYjdlZDdGOC9ldkV1VC9qdEdzdnN2V0lWY2ZLbCtj?=
 =?utf-8?B?S3lLcVgzMmg1U0lXeXdHcDVwMTNhTG41UmEvK2R1MkFuSkYzcTdvOXVhTVBM?=
 =?utf-8?B?VVkyaFN5NENKOTNjSFlhcStTdGRZUXcwMkdRRDRaazBTQ3dJeVMybW5Tcmtj?=
 =?utf-8?B?SDZuOVVWMjErbUE4K2Vra1NIa1JqVVVud2M5ZnNLeTF0dzJyNE0xVDBuZjhp?=
 =?utf-8?B?dEtIc3NZZFBTTzRQM1BsTGg0TzBrU3RNZmxZeXoycGo1VU1IYVprWkdPVS9z?=
 =?utf-8?B?eVF5M1ZHTERLNkZiazBEWENiZzFRckU2VWwzRm5iUnQ1SjJZdU8yZ29Tem1L?=
 =?utf-8?B?dEhGbHkvdjhiVGowbWxaZHFRV1pFbFM2b1djV2pZZmVhS0JvQmgwb3JBTFph?=
 =?utf-8?B?NGVBY2g4TGJ1L2VhWFpBejNCdmRaRUpyMi82RmZ5cGRIK2RvTU9KSUhiQmNQ?=
 =?utf-8?B?Z2RGdlZrcFM5OGQvV3RnK3BYOG5RYTBOYTNKYy9VcDRycWkrNEtaWStib2xY?=
 =?utf-8?B?eUI3OGZzOHlRczVtSXhXY0RqQXRyd1FiYWpLbWdwOWRiVTZpbm96QktnbnFD?=
 =?utf-8?B?RWRtU2FYV1ZxK3Ayd2lhd2ljSXJVTWdSdVk4U0hlQ3dKVEhvUjBueVRRZWpF?=
 =?utf-8?B?NjhOYmRaaEtSVlMvbVMzemZXWk9sQ3pTMng3blRnUGlCN0UvZnRLdlFRMmZP?=
 =?utf-8?B?UW0zTnBQVkVVTlgxK3RCWDh5QndyOVdUMzdRL3g5SW9wSHZYV0hDdE4ra1Bl?=
 =?utf-8?B?QjdMS1dWcWdXbGdOMVNBRDZEcURSSmZUSzFqSW9Td1V4NnF1VU84REtHRXF3?=
 =?utf-8?B?NXg5T1dyVGx4N2N6c3pJVGxYYWJVV2NiTnpTc0N1MW14TFd4Z2RHcE9mY0pw?=
 =?utf-8?B?WlFHS0N3b3JiR1FxUGtjSm4yY21vSWdYUVBxUERUR0xia05YSkV2SHdyWFZY?=
 =?utf-8?B?WG9lOFdEUHA5aUV2enVPYytzZlFudTVkaEhTMEpJeitndGF4TXRTdzhrWE4v?=
 =?utf-8?B?NERhL3E4Um10MDBlbTV6ek1PWm8wM3lYSEFCMHUwRStab2Z5L0hkeFIxZGpq?=
 =?utf-8?B?RW16b1RUeEsyd2lLcXJ0QmlwUFBYVXgzSERWaWw4T1Q1RDIyWDlSbXo3UDZV?=
 =?utf-8?B?MlFjMmhZaTdGazFaSXN0eVFSWk04ZWpGbjBJcVlPMFdOSjVNcFNFWXI1emQr?=
 =?utf-8?B?c0ExVHkxMy9YQ21SSzZhRzAxOUd2Z0dENkNQRUMreEJ0aHpYUllWb2k2SWdt?=
 =?utf-8?B?cmZNSkY1dGF5RHBENTUxenB2am9jRitmTkc4Ty8wRk83TGJMckwvQUVhUGQv?=
 =?utf-8?B?OFoxaXd1WEFvOHNGYzZDaHBoZytQbmxCNUJtVjd6MXJGbG9uQmk5R0tLUGtH?=
 =?utf-8?B?d3k5cTNHSWJwcjVvWTJlOEwwdkJ3cXZvbmpWd2NtRUVoSFFsZUswb0ZqakRT?=
 =?utf-8?B?cWRGejN1SVhXVVAzMnFkQm5qcTBSOXBkcDVqc2dNandMcERuRTAxSFVXdVgr?=
 =?utf-8?B?WkNPcWo5dUxsNHRldm1NMGNUZXdIQkxhL0FNRk1zcGpqNGt5Mm90aWlvTG1u?=
 =?utf-8?B?Y2ErWVNtMWdQOVFzdDR6Y0ZUaFduTkZGREtpWG8rekZzMDBDNUlVVVRPNVY5?=
 =?utf-8?Q?Xrmg1jT1OAzjq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NBN1ZCTTFpVXlvaC90bnRXeEZnMTFDa3F5ZXhOS0o1TDFrb09IYTFXbFNK?=
 =?utf-8?B?WW4velFnZzVsczcwTnM2NlZiZVh0dDU1d3ZSVVBOMnV5UVduakhSWEc3L1ZW?=
 =?utf-8?B?TTd3K0JHK2xJY3F6YU5OY0FTdlJJbVA0NXEzYjNOTDZqelJ0eTJLMFFlUkhm?=
 =?utf-8?B?a01BZ0xIN0lXTkNQNEFIWFRzS1crNjhoOS9qUms1dkVwVWd4WU5GcjIra0tm?=
 =?utf-8?B?ZFFGOUFlOFhzc0ludHErSERWZ25kS0gyUzR1SlI4b0JreWhKRmVtRHdGeC9W?=
 =?utf-8?B?Nk9FSkdIR280dkNQOXp3cnVOYUgxUnNpa29hY3g1RW5jdGF1QkJWaTlMVXRl?=
 =?utf-8?B?NGE4ajZ1V1hwT3FCUWtFS1IrT3hYbjFwSGVFaUxpa1U2SHBlKzYvNW5LS0xE?=
 =?utf-8?B?Wk5JaUpERmRVMTZqa1BOdFphaDNjTDhDNTdrMDdHOEFUN2xMb20rL29ZdHZk?=
 =?utf-8?B?SldYb2JhUktpb29kaGVUYi9pcUdwUkFOc04zUkYzdDBhM21oTld1OGlaRjhY?=
 =?utf-8?B?N0piZ2V1ZTRSdDhhcFBrTmtLQTd2ZlcyNUhCeXpGdVVpdU4xTXBnNjR6eS91?=
 =?utf-8?B?dExYYWVWd0FZb2xLYmI3dVRJQkcrOXQ4bjQyZTZOaFAvekdtMGE4WTZGdGlZ?=
 =?utf-8?B?U0xBeFIrUzR3ZS94Y3F3WXdndVBKeEtkR0lENHpSUVFlVTZyOFFDS2V1WFFU?=
 =?utf-8?B?OWJtdDkwaDVOM3hLaE5JZXdGQ0ZiK3JTZTZaRStBcm5kb09YMzdDSHpFdFZO?=
 =?utf-8?B?d1NGdkx3elcwOXVzdGpiMDVpOFpGei9VNHIvRks3QWtZZitmWjIwZkpTdHJR?=
 =?utf-8?B?dnVBeGNDbXRQNG8xWm5HUTVsN1JJZEo0aUhQZ0l5b2dJdjR5ajA0a0NjU3Zx?=
 =?utf-8?B?OHd4OFZ4WndqbU53SWJ3SWtWM0VnQk8zSjhBYnQ0a1l3dUJpNXBEZTJJdXNU?=
 =?utf-8?B?YnRwSWJDZG1QOUQzU3R4MmVrdmVvWWw2a2I5aHdJSFBJNkU2aTR5eExobW5E?=
 =?utf-8?B?TUhqWTVzeUphSGxkaHEvMjZqQjZiam85YzdpbWttaDNLaFJZU2IvblNJYVF4?=
 =?utf-8?B?OWZ1MkVXMUhYRzQ2RUpVNTQ0OS9mSFJmWUZaZys4UHNMbUpKVnNYaWNxREhF?=
 =?utf-8?B?di85d1BGWUs5ZW1sd3B3UzRDWEN6R1JOQm1NNkpkSUVOZk5IRHAyNmo3ZWp2?=
 =?utf-8?B?cnBib2VFeXF1UCt3ODRUbkNiQVVWcEV3Ym52SGVzSE5XQUxoeTdRRVNiK0Y2?=
 =?utf-8?B?SExsYWV5MnZQdFBuK1ZaekV5YTVMdGVwQzJINmFsQjN1VHFjY1YxTy8vZkdK?=
 =?utf-8?B?VlFHaUUzUXZSM29NSjgreUsybUl3eFZMeVdSRkNFaGVDMmo4dnZLMUl5UWRF?=
 =?utf-8?B?eUdKYno5Y1V1TWt6SXRITWZvVFhVZjhSRmVEaVZSRGl3Tzhqa3JoN1luelZ4?=
 =?utf-8?B?MHJ6dUdBNnBYK0swZDhpK3FvY3Q2NmNBbGpIWXFrbi9tY3R0Nk9ScnRtczVM?=
 =?utf-8?B?dVMxMjRHc1dtNnhiOFZwRXU3TUMzalpOMGdtcmRqNDFjcllVWUtPaHJrZm5B?=
 =?utf-8?B?RjN0Qi9yRExlc2tUT1RJUkhsUTFTUXVBSkFaTENRdVcyL3N2TVh5VW0ydXFS?=
 =?utf-8?B?dzNzNVZ2SW5GSjFLZ3pCdEZ0TkhzMXRyL3pab05HVW03aWQ2bDdxRFc1MkJv?=
 =?utf-8?B?RFdZN0hSK2hVQmtRMDFVSUNjLzFpa01nNnNUMG9vUld2aGRZci9QTlprZG5j?=
 =?utf-8?B?NTZQWUJNSWl2cGtzZmR5VkQrU2JxdTBBY3gzK3FxaWtFS2NrOHlqdmJNbWxD?=
 =?utf-8?B?RG11U2VvSHN2Nk40d0RPaTRWZXRsck9TR3g4Q2EyQlpGUkl4OVQrWmxEbGZk?=
 =?utf-8?B?UXhxOEFIS0hmcENxVEM3SnU1MEpUUlNkWUdyUDR4KzVVcDB3NG5yYk1nZVE5?=
 =?utf-8?B?cVcrQU02M1lrZGphVXB4TFNkNGRCMGVuMnNIZmlvVDJMbVM5QUFJdHBwM3ZS?=
 =?utf-8?B?d1VqT045aDF6ZndCSVVEdlR0V2g5MmYzK2JLVXh3TGdFa0luSjVhenFleGFZ?=
 =?utf-8?B?OEJWVWJqVlhNZDJyWWE2UmliRXUvbC9xOHVwQ2pIS0E5QW95YmpMbGNqMGJp?=
 =?utf-8?B?dFlJVVllRk9nY0pETStzZ3IxbEp4REd2YS9DK3JkSmhpTmZjSHpaVDVnSzhx?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7+H3i98I/TZPNWRB1wtwRxku885ezHIpbAOA7g81HW5ejNuKy+O+x1zpC+9utIiHpqclaEgbQscqYCrHcQcDz1pFZ5CcKij6/88WeAYuiljiYRt7+S/1qJO/thGKZjzbQMdwcAdblto7ae0Un9g9gTtI41Ijd1cz86DvnlnCFRhzZ5E1iynQbm55K2W3+ZF4GaNOIcDets0300YJlHoCmXGfJ7IBtG3qHf5H1Z+I0eZLTHP4k5VwJKS5V0kDfsj5VEbBB4/OcVDExuNhWErcKgHRqsbWt7JMZ+k4T05s56wNWvYYiyqauqIlXw3wR4UkO3TaQ/nwv5TFUPn0PB1OpdpIR3WjN7XQaWUHA9ZvIo/faGOrenYBxq69oqaFJI8aw9X8pI33Pgbrax5Q3U5ZtMNqD3z3Af3afXgRDGAOM+gejnZbu587ZMnpcl9wsgRNy/FWiqNnq6U9yYN99kZvV+k5XCcrbSdJ1i/G4Xz5kbgMqAdMkongHEHNQob7Vq4STwrEy7YT6o8KDCPX0q3rKuJM9T+MrBV4XGklor4FEdpVoLSWlw6s2+2++ZuOMusCl9deZreKcgxl8a1hUffEqnRXZpn6ofLF756peDZQYW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963742bb-add7-4823-4a35-08dda84651fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 17:43:33.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYIjIvDa6Ounkwq9Vt2AgpCmobDVPeawYlAJ2SEIvS0wmhQmH7IcePCj/W3JCj0hTyh7+3vptwlCfGOXQLJjstSCpaMG4V/TYhObF4CsyD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100143
X-Proofpoint-GUID: 6Wt6yuAk7Z2StgAW7hcgYwqCcM37sm7J
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68486eca cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8 a=heaZf6LiO3w-9wMDrXwA:9 a=D2essNJzpjdt80e2:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE0MyBTYWx0ZWRfX6hTyCw8ddjou mjVVbBxMv8yq2lS6DUQP7DpTq4VZHNjL5lwGYamvz/floqs8cz/dOmbjkchFGPhzMrjPud8P6TA EdzaO5SBkDwFXIBMqZcn66O76KUszAey0BHPcCURngMkcLdmQSIYtfBjGAZ9khttBl0I2BXapuU
 ATb1sQ+3FSlt6gDVw3a0DVdzftHVG2qpB/T1JtTdY5gSIgS7U34jOjShpgJMvdjlLaUU+Vt5XwD LrGVFBCkmGeTvK2HI0fb4gfS9ZqbdOppPXYmy99sY+4c2Ck6jQedyV/39L3xvXIRUZLDyNcCvn+ UQBjsAaHPDUBtm67vV+ZHau2em2R+08/W7DQ3S6VsANkwlIl4znML6MN5BsJjHFmVRK0cCvtwIh
 HZ7HeATxVdKi9IdpIlTREiKaJZpNilxwS/lhmYH8Jn7Jfy0QVtedxL5T4VBISXkW8MQ+MDJx
X-Proofpoint-ORIG-GUID: 6Wt6yuAk7Z2StgAW7hcgYwqCcM37sm7J

On Sat, Jun 07, 2025 at 06:41:35PM -0700, Suren Baghdasaryan wrote:
> On Sat, Jun 7, 2025 at 10:43 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Hi Suren,
> >
> > Forgive me but I am going to ask a lot of questions here :p just want to
> > make sure I'm getting everything right here.
>
> No worries and thank you for reviewing!

No problem!

>
> >
> > On Wed, Jun 04, 2025 at 04:11:50PM -0700, Suren Baghdasaryan wrote:
> > > With maple_tree supporting vma tree traversal under RCU and per-vma
> > > locks, /proc/pid/maps can be read while holding individual vma locks
> > > instead of locking the entire address space.
> >
> > Nice :)
> >
> > > Completely lockless approach would be quite complex with the main issue
> > > being get_vma_name() using callbacks which might not work correctly with
> > > a stable vma copy, requiring original (unstable) vma.
> >
> > Hmmm can you expand on what a 'completely lockless' design might comprise of?
>
> In my previous implementation
> (https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/)
> I was doing this under RCU while checking mmap_lock seq counter to
> detect address space changes. That's what I meant by a completely
> lockless approach here.

Oh did that approach not even use VMA locks _at all_?

>
> >
> > It's super un-greppable and I've not got clangd set up with an allmod kernel to
> > triple-check but I'm seeing at least 2 (are there more?):
> >
> > gate_vma_name() which is:
> >
> >         return "[vsyscall]";
> >
> > special_mapping_name() which is:
> >
> >          return ((struct vm_special_mapping *)vma->vm_private_data)->name;
> >
> > Which I'm guessing is the issue because it's a double pointer deref...
>
> Correct but in more general terms, depending on implementation of the
> vm_ops.name callback, vma->vm_ops->name(vma) might not work correctly
> with a vma copy. special_mapping_name() is an example of that.

Yeah, this is a horrible situation to be in for such a trivial thing. But I
guess unavoidable for now.

>
> >
> > Seems such a silly issue to get stuck on, I wonder if we can't just change
> > this to function correctly?
>
> I was thinking about different ways to overcome that but once I
> realized per-vma locks result in even less contention and the
> implementation is simpler and more robust, I decided that per-vma
> locks direction is better.

Ack well in that case :)

But still it'd be nice to somehow restrict the impact of this callback.

>
> >
> > > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > > lock the vma, release the mmap_lock and continue. This guarantees the
> > > reader to make forward progress even during lock contention. This will
> >
> > Ah that fabled constant forward progress ;)
> >
> > > interfere with the writer but for a very short time while we are
> > > acquiring the per-vma lock and only when there was contention on the
> > > vma reader is interested in.
> > > One case requiring special handling is when vma changes between the
> > > time it was found and the time it got locked. A problematic case would
> > > be if vma got shrunk so that it's start moved higher in the address
> > > space and a new vma was installed at the beginning:
> > >
> > > reader found:               |--------VMA A--------|
> > > VMA is modified:            |-VMA B-|----VMA A----|
> > > reader locks modified VMA A
> > > reader reports VMA A:       |  gap  |----VMA A----|
> > >
> > > This would result in reporting a gap in the address space that does not
> > > exist. To prevent this we retry the lookup after locking the vma, however
> > > we do that only when we identify a gap and detect that the address space
> > > was changed after we found the vma.
> >
> > OK so in this case we have
> >
> > 1. Find VMA A - nothing is locked yet, but presumably we are under RCU so
> >    are... safe? From unmaps? Or are we? I guess actually the detach
> >    mechanism sorts this out for us perhaps?
>
> Yes, VMAs are RCU-safe and we do detect if it got detached after we
> found it but before we locked it.

Ack I thought so.

>
> >
> > 2. We got unlucky and did this immediately prior to VMA A having its
> >    vma->vm_start, vm_end updated to reflect the split.
>
> Yes, the split happened after we found it and before we locked it.
>
> >
> > 3. We lock VMA A, now position with an apparent gap after the prior VMA
> > which, in practice does not exist.
>
> Correct.

Ack

>
> >
> > So I am guessing that by observing sequence numbers you are able to detect
> > that a change has occurred and thus retry the operation in this situation?
>
> Yes, we detect the gap and we detect that address space has changed,
> so to endure we did not miss a split we fall back to mmap_read_lock,
> lock the VMA while holding mmap_read_lock, drop mmap_read_lock and
> retry.
>
> >
> > I know we previously discussed the possibility of this retry mechanism
> > going on forever, I guess I will see the resolution to this in the code :)
>
> Retry in this case won't go forever because we take mmap_read_lock
> during the retry. In the worst case we will be constantly falling back
> to mmap_read_lock but that's a very unlikely case (the writer should
> be constantly splitting the vma right before the reader locks it).

It might be worth adding that to commit message to underline that this has
been considered and this is the resolution.

Something like:

	we guarantee forward progress by always resolving contention via a
	fallback to an mmap-read lock.

	We shouldn't see a repeated fallback to mmap read locks in
	practice, as this require a vanishingly unlikely series of lock
	contentions (for instance due to repeated VMA split
	operations). However even if this did somehow happen, we would
	still progress.

>
> >
> > > This change is designed to reduce mmap_lock contention and prevent a
> > > process reading /proc/pid/maps files (often a low priority task, such
> > > as monitoring/data collection services) from blocking address space
> > > updates. Note that this change has a userspace visible disadvantage:
> > > it allows for sub-page data tearing as opposed to the previous mechanism
> > > where data tearing could happen only between pages of generated output
> > > data. Since current userspace considers data tearing between pages to be
> > > acceptable, we assume is will be able to handle sub-page data tearing
> > > as well.
> >
> > By tearing do you mean for instance seeing a VMA more than once due to
> > e.g. a VMA expanding in a racey way?
>
> Yes.
>
> >
> > Pedantic I know, but it might be worth goiing through all the merge case,
> > split and remap scenarios and explaining what might happen in each one (or
> > perhaps do that as some form of documentation?)
> >
> > I can try to put together a list of all of the possibilities if that would
> > be helpful.
>
> Hmm. That might be an interesting exercise. I called out this
> particular case because my tests caught it. I spent some time thinking
> about other possible scenarios where we would report a gap in a place
> where there are no gaps but could not think of anything else.

todo++; :)

>
> >
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/proc/internal.h |   6 ++
> > >  fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
> > >  2 files changed, 175 insertions(+), 8 deletions(-)
> >
> > I really hate having all this logic in the proc/task_mmu.c file.
> >
> > This is really delicate stuff and I'd really like it to live in mm if
> > possible.
> >
> > I reallise this might be a total pain, but I'm quite worried about us
> > putting super-delicate, carefully written VMA handling code in different
> > places.
> >
> > Also having stuff in mm/vma.c opens the door to userland testing which,
> > when I finally have time to really expand that, would allow for some really
> > nice stress testing here.
>
> That would require some sizable refactoring. I assume code for smaps
> reading and PROCMAP_QUERY would have to be moved as well?

Yeah, I know, and apologies for that, but I really oppose us having this
super delicate VMA logic in an fs/proc file, one we don't maintain for that
matter.

I know it's a total pain, but this just isn't the right place to be doing
such a careful dance.

I'm not saying relocate code that belongs here, but find a way to abstract
the operations.

Perhaps could be a walker or something that does all the state transition
stuff that you can then just call from the walker functions here?

You could then figure out something similar for the PROCMAP_QUERY logic.

We're not doing this VMA locking stuff for smaps are we? As that is walking
page tables anyway right? So nothing would change for that.

>
> >
> > >
> > > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > > index 96122e91c645..3728c9012687 100644
> > > --- a/fs/proc/internal.h
> > > +++ b/fs/proc/internal.h
> > > @@ -379,6 +379,12 @@ struct proc_maps_private {
> > >       struct task_struct *task;
> > >       struct mm_struct *mm;
> > >       struct vma_iterator iter;
> > > +     loff_t last_pos;
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +     bool mmap_locked;
> > > +     unsigned int mm_wr_seq;
> >
> > Is this the _last_ sequence number observed in the mm_struct? or rather,
> > previous? Nitty but maybe worth renaming accordingly.
>
> It's a copy of the mm->mm_wr_seq. I can add a comment if needed.

Right, of course. But I think the problem is the 'when' it refers to. It's
the sequence number associatied with the mm here sure, but when was it
snapshotted? How do we use it?

Something like 'last_seen_seqnum' or 'mm_wr_seq_start' or something plus a
comment would be helpful.

This is nitty I know... but this stuff is very confusing and I think every
little bit we do to help explain things is helpful here.

>
> >
> > > +     struct vm_area_struct *locked_vma;
> > > +#endif
> > >  #ifdef CONFIG_NUMA
> > >       struct mempolicy *task_mempolicy;
> > >  #endif
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 27972c0749e7..36d883c4f394 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -127,13 +127,172 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
> > >  }
> > >  #endif
> > >
> > > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> > > -                                             loff_t *ppos)
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +
> > > +static struct vm_area_struct *trylock_vma(struct proc_maps_private *priv,
> > > +                                       struct vm_area_struct *vma,
> > > +                                       unsigned long last_pos,
> > > +                                       bool mm_unstable)
> >
> > This whole function is a bit weird tbh, you handle both the
> > mm_unstable=true and mm_unstable=false cases, in the latter we don't try to
> > lock at all...
>
> Why do you think so? vma_start_read() is always called but in case
> mm_unstable=true we double check for the gaps to take care of the case
> I mentioned in the changelog.

Well the read lock will always succeed if mmap read lock is held right?
Actually... no :)

I see your point below about vma_start_read_locked() :>)

I see below you suggest splitting into two functions, that seems to be a
good way forward.

I _think_ we won't even need the checks re: mm and last_pos in that case
right? As holding the mmap lock we should be able to guarantee? Or at least
the mm check?

>
> >
> > Nitty (sorry I know this is mildly irritating review) but maybe needs to be
> > renamed, or split up somehow?
> >
> > This is only trylocking in the mm_unstable case...
>
> Nope, I think you misunderstood the intention, as I mentioned above.
>
> >
> > > +{
> > > +     vma = vma_start_read(priv->mm, vma);
> >
> > Do we want to do this with mm_unstable == false?
>
> Yes, always. mm_unstable=true only indicates that we are already
> holding mmap_read_lock, so we don't need to double-check for gaps.
> Perhaps I should add some comments to clarify what purpose this
> parameter serves...
>
> >
> > I know (from my own documentation :)) taking a VMA read lock while holding
> > an mmap read lock is fine (the reverse isn't) but maybe it's suboptimal?
>
> Ah, right. I should use vma_start_read_locked() instead when we are
> holding mmap_read_lock. That's why that function was introduced. Will
> change.

Yeah, I'll pretend this is what I meant to sound smart :P but this is a
really good point!

>
> >
> > > +     if (IS_ERR_OR_NULL(vma))
> > > +             return NULL;
> >
> > Hmm IS_ERR_OR_NULL() is generally a code smell (I learned this some years
> > ago from people moaning at me on code review :)
> >
> > Sorry I know that's annoying but perhaps its indicative of an issue in the
> > interface? That's possibly out of scope here however.
>
> lock_vma_under_rcu() returns NULL or EAGAIN to signal
> lock_vma_under_rcu() that it should retry the VMA lookup. In here in
> either case we retry under mmap_read_lock, that's why EAGAIN is
> ignored.

Yeah indeed you're right. I guess I'm just echoing previous review traumas
here :P

>
> >
> > Why are we ignoring errors here though? I guess because we don't care if
> > the VMA got detached from under us, we don't bother retrying like we do in
> > lock_vma_under_rcu()?
>
> No, we take mmap_read_lock and retry in either case. Perhaps I should
> split trylock_vma() into two separate functions - one for the case
> when we are holding mmap_read_lock and another one when we don't? I
> think that would have prevented many of your questions. I'll try that
> and see how it looks.

Yeah that'd be helpful. I think this should also simplify things?

>
> >
> > Should we just abstract that part of lock_vma_under_rcu() and use it?
>
> trylock_vma() is not that similar to lock_vma_under_rcu() for that
> IMO. Also lock_vma_under_rcu() is in the pagefault path which is very
> hot, so I would not want to add conditions there to make it work for
> trylock_vma().

Right sure.

But I'm just wondering why we don't do the retry stuff, e.g.:

		/* Check if the VMA got isolated after we found it */
		if (PTR_ERR(vma) == -EAGAIN) {
			count_vm_vma_lock_event(VMA_LOCK_MISS);
			/* The area was replaced with another one */
			goto retry;
		}

I mean do we need to retry under mmap lock in that case? Can we just retry
the lookup? Or is this not a worthwhile optimisation here?

>
> >
> > > +
> > > +     /* Check if the vma we locked is the right one. */
> >
> > Well it might not be the right one :) but might still belong to the right
> > mm, so maybe better to refer to the right virtual address space.
>
> Ack. Will change to "Check if the vma belongs to the right address space. "

Thanks!

>
> >
> > > +     if (unlikely(vma->vm_mm != priv->mm))
> > > +             goto err;
> > > +
> > > +     /* vma should not be ahead of the last search position. */
> >
> > You mean behind the last search position? Surely a VMA being _ahead_ of it
> > is fine?
>
> Yes, you are correct. "should not" should have been "should".

Thanks!

>
> >
> > > +     if (unlikely(last_pos >= vma->vm_end))
> >
> > Should that be >=? Wouldn't an == just be an adjacent VMA? Why is that
> > problematic? Or is last_pos inclusive?
>
> last_pos is inclusive and vma->vm_end is not inclusive, so if last_pos
> == vma->vm_end that would mean the vma is behind the last_pos. Since
> we are searching forward from the last_pos, we should not be finding a
> vma before last_pos unless it mutated.

Ahhh that explains it. Thanks.

>
> >
> > > +             goto err;
> >
> > Am I correct in thinking thi is what is being checked?
> >
> >           last_pos
> >              |
> >              v
> > |---------|
> > |         |
> > |---------|
> >         vm_end
> >    <--- vma 'next'??? How did we go backwards?
>
> Exactly.
>
> >
> > When last_pos gets updated, is it possible for a shrink to race to cause
> > this somehow?
>
> No, we update last_pos only after we locked the vma and confirmed it's
> the right one.

Ack.

>
> >
> > Do we treat this as an entirely unexpected error condition? In which case
> > is a WARN_ON_ONCE() warranted?
>
> No, the VMA might have mutated from under us before we locked it. For
> example it might have been remapped to a higher address.
>
> >
> > > +
> > > +     /*
> > > +      * vma ahead of last search position is possible but we need to
> > > +      * verify that it was not shrunk after we found it, and another
> > > +      * vma has not been installed ahead of it. Otherwise we might
> > > +      * observe a gap that should not be there.
> > > +      */
> >
> > OK so this is the juicy bit.
>
> Yep, that's the case singled out in the changelog.

And rightly so!

>
> >
> >
> > > +     if (mm_unstable && last_pos < vma->vm_start) {
> > > +             /* Verify only if the address space changed since vma lookup. */
> > > +             if ((priv->mm_wr_seq & 1) ||
> >
> > Can we wrap this into a helper? This is a 'you just have to know that odd
> > seq number means a write operation is in effect'. I know you have a comment
> > here, but I think something like:
> >
> >         if (has_mm_been_modified(priv) ||
> >
> > Would be a lot clearer.
>
> Yeah, I was thinking about that. I think an even cleaner way would be
> to remember the return value of mmap_lock_speculate_try_begin() and
> pass it around. I was hoping to avoid that extra parameter but sounds
> like for the sake of clarity that would be preferable?

You know, it's me so I might have to mention a helper struct here :P it's
the two most Lorenzo things - helper sructs and churn...

>
> >
> > Again this speaks to the usefulness of abstracting all this logic from the
> > proc code, we are putting super delicate VMA stuff here and it's just not
> > the right place.
> >
> > As an aside, I don't see coverage in the process_addrs documentation on
> > sequence number odd/even or speculation?
> >
> > I think we probably need to cover this to maintain an up-to-date
> > description of how the VMA locking mechanism works and is used?
>
> I think that's a very low level technical detail which I should not
> have exposed here. As I mentioned, I should simply store the return
> value of mmap_lock_speculate_try_begin() instead of doing these tricky
> mm_wr_seq checks.

Right yeah I'm all for simplifying if we can! Sounds sensible.

>
> >
> > > +                 mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq)) {
> >
> > Nit, again unrelated to this series, but would be useful to add a comment
> > to mmap_lock_speculate_retry() to indicate that a true return value
> > indicates a retry is needed, or renaming it.
>
> This is how seqcount API works in general. Note that
> mmap_lock_speculate_retry() is just a wrapper around
> read_seqcount_retry().

Yeah, I guess I can moan to PeterZ about that :P

It's not a big deal honestly, but it was just something I found confusing.

I think adjusting the comment above to something like:

		/*
		 * Verify if the address space changed since vma lookup, or if
		 * the speculative lock needs to be retried.
		 */

Or perhaps somethig more in line with the description you give below?

>
> >
> > Maybe mmap_lock_speculate_needs_retry()? Also I think that function needs a
> > comment.
>
> See https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/seqlock.h#L395

Yeah I saw that, but going 2 levels deep to read a comment isn't great.

But again this isn't the end of the world.

>
> >
> > Naming is hard :P
> >
> > Anyway the totality of this expression is 'something changed' or 'read
> > section retry required'.
>
> Not quite. The expression is "something is changed from under us or
> something was changing even before we started VMA lookup". Or in more
> technical terms, mmap_write_lock was acquired while we were locking
> the VMA or mmap_write_lock was already held even before we started the
> VMA search.

OK so read section retry required = the seq num changes from under us
(checked carefully with memory barriers and carefully considered and
thought out such logic), and the priv->mm_wr_seq check before it is the
'was this changed even before we began?'

I wonder btw if we could put both into a single helper function to check
whether that'd be clearer.

>
> >
> > Under what circumstances would this happen?
>
> See my previous comment and I hope that clarifies it.

Thanks!

>
> >
> > OK so we're into the 'retry' logic here:
> >
> > > +                     vma_iter_init(&priv->iter, priv->mm, last_pos);
> >
> > I'd definitely want Liam to confirm this is all above board and correct, as
> > these operations are pretty sensitive.
> >
> > But assuming this is safe, we reset the iterator to the last position...
> >
> > > +                     if (vma != vma_next(&priv->iter))
> >
> > Then assert the following VMA is the one we seek.
> >
> > > +                             goto err;
> >
> > Might this ever be the case in the course of ordinary operation? Is this
> > really an error?
>
> This simply means that the VMA we found before is not at the place we
> found it anymore. The locking fails and we should retry.

I know it's pedantic but feels like 'err' is not a great name for this.

Maybe 'nolock' or something? Or 'lock_failed'?

>
> >
> > > +             }
> > > +     }
> > > +
> > > +     priv->locked_vma = vma;
> > > +
> > > +     return vma;
> > > +err:
> >
> > As queried above, is this really an error path or something we might expect
> > to happen that could simply result in an expected fallback to mmap lock?
>
> It's a failure to lock the VMA, which is handled by retrying under
> mmap_read_lock. So, trylock_vma() failure does not mean a fault in the
> logic. It's expected to happen occasionally.

Ack yes understood thanks!

>
> >
> > > +     vma_end_read(vma);
> > > +     return NULL;
> > > +}
> > > +
> > > +
> > > +static void unlock_vma(struct proc_maps_private *priv)
> > > +{
> > > +     if (priv->locked_vma) {
> > > +             vma_end_read(priv->locked_vma);
> > > +             priv->locked_vma = NULL;
> > > +     }
> > > +}
> > > +
> > > +static const struct seq_operations proc_pid_maps_op;
> > > +
> > > +static inline bool lock_content(struct seq_file *m,
> > > +                             struct proc_maps_private *priv)
> >
> > Pedantic I know but isn't 'lock_content' a bit generic?
> >
> > He says, not being able to think of a great alternative...
> >
> > OK maybe fine... :)
>
> Yeah, I struggled with this myself. Help in naming is appreciated.

This is where it gets difficult haha so easy to point out but not so easy
to fix...

lock_vma_range()?

>
> >
> > > +{
> > > +     /*
> > > +      * smaps and numa_maps perform page table walk, therefore require
> > > +      * mmap_lock but maps can be read with locked vma only.
> > > +      */
> > > +     if (m->op != &proc_pid_maps_op) {
> >
> > Nit but is there a neater way of checking this? Actually I imagine not...
> >
> > But maybe worth, instead of forward-declaring proc_pid_maps_op, forward declare e.g.
> >
> > static inline bool is_maps_op(struct seq_file *m);
> >
> > And check e.g.
> >
> > if (is_maps_op(m)) { ... in the above.
> >
> > Yeah this is nitty not a massive del :)
>
> I'll try that and see how it looks. Thanks!

Thanks!

>
> >
> > > +             if (mmap_read_lock_killable(priv->mm))
> > > +                     return false;
> > > +
> > > +             priv->mmap_locked = true;
> > > +     } else {
> > > +             rcu_read_lock();
> > > +             priv->locked_vma = NULL;
> > > +             priv->mmap_locked = false;
> > > +     }
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +static inline void unlock_content(struct proc_maps_private *priv)
> > > +{
> > > +     if (priv->mmap_locked) {
> > > +             mmap_read_unlock(priv->mm);
> > > +     } else {
> > > +             unlock_vma(priv);
> > > +             rcu_read_unlock();
> >
> > Does this always get called even in error cases?
>
> What error cases do you have in mind? Error to lock a VMA is handled
> by retrying and we should be happily proceeding. Please clarify.

Well it was more of a question really - can the traversal through
/proc/$pid/maps result in some kind of error that doesn't reach this
function, thereby leaving things locked mistakenly?

If not then happy days :)

I'm guessing there isn't.

>
> >
> > > +     }
> > > +}
> > > +
> > > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> > > +                                        loff_t last_pos)
> >
> > We really need a generalised RCU multi-VMA locking mechanism (we're looking
> > into madvise VMA locking atm with a conservative single VMA lock at the
> > moment, but in future we probably want to be able to span multiple for
> > instance) and this really really feels like it doesn't belong in this proc
> > code.
>
> Ok, I guess you are building a case to move more code into vma.c? I
> see what you are doing :)

Haha damn it, my evil plans revealed :P

>
> >
> > >  {
> > > -     struct vm_area_struct *vma = vma_next(&priv->iter);
> > > +     struct vm_area_struct *vma;
> > > +     int ret;
> > > +
> > > +     if (priv->mmap_locked)
> > > +             return vma_next(&priv->iter);
> > > +
> > > +     unlock_vma(priv);
> > > +     /*
> > > +      * Record sequence number ahead of vma lookup.
> > > +      * Odd seqcount means address space modification is in progress.
> > > +      */
> > > +     mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
> >
> > Hmm we're discarding the return value I guess we don't really care about
> > that at this stage? Or do we? Do we want to assert the read critical
> > section state here?
>
> Yeah, as I mentioned, instead of relying on priv->mm_wr_seq being odd
> I should record the return value of mmap_lock_speculate_try_begin().
> In the functional sense these two are interchangeable.

Ack, thanks!

>
> >
> > I guess since we have the mm_rq_seq which we use later it's the same thing
> > and doesn't matter.
>
> Yep.

Ack

>
> >
> > ~~(off topic a bit)~~
> >
> > OK so off-topic again afaict we're doing something pretty horribly gross here.
> >
> > We pass &priv->mm_rw_seq as 'unsigned int *seq' field to
> > mmap_lock_speculate_try_begin(), which in turn calls:
> >
> >         return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
> >
> > And this is defined as a macro of:
> >
> > #define raw_seqcount_try_begin(s, start)                                \
> > ({                                                                      \
> >         start = raw_read_seqcount(s);                                   \
> >         !(start & 1);                                                   \
> > })
> >
> > So surely this expands to:
> >
> >         *seq = raw_read_seqcount(&mm->mm_lock_seq);
> >         !(*seq & 1) // return true if even, false if odd
> >
> > So we're basically ostensibly passing an unsigned int, but because we're
> > calling a macro it's actually just 'text' and we're instead able to then
> > reassign the underlying unsigned int * ptr and... ugh.
> >
> > ~~(/off topic a bit)~~
>
> Aaaand we are back...

:)) yeah this isn't your fault, just a related 'wtf' moan :P we can pretend
like it never happened *ahem*

>
> >
> > > +     vma = vma_next(&priv->iter);
> >
> >
> >
> > > +     if (!vma)
> > > +             return NULL;
> > > +
> > > +     vma = trylock_vma(priv, vma, last_pos, true);
> > > +     if (vma)
> > > +             return vma;
> > > +
> >
> > Really feels like this should be a boolean... I guess neat to reset vma if
> > not locked though.
>
> I guess I can change trylock_vma() to return boolean. We always return
> the same vma or NULL I think.

Ack, I mean I guess you're looking at reworking it in general so can take
this into account.

>
> >
> > > +     /* Address space got modified, vma might be stale. Re-lock and retry */
> >
> > > +     rcu_read_unlock();
> >
> > Might we see a VMA possibly actually legit unmapped in a race here? Do we
> > need to update last_pos/ppos to account for this? Otherwise we might just
> > fail on the last_pos >= vma->vm_end check in trylock_vma() no?
>
> Yes, it can happen and trylock_vma() will fail to lock the modified
> VMA. That's by design. In such cases we retry the lookup from the same
> last_pos.

OK and then we're fine with it because the gap we report will be an actual
gap.

>
> >
> > > +     ret = mmap_read_lock_killable(priv->mm);
> >
> > Shouldn't we set priv->mmap_locked here?
>
> No, we will drop the mmap_read_lock shortly. priv->mmap_locked
> indicates the overall mode we operate in. When priv->mmap_locked=false
> we can still temporarily take the mmap_read_lock when retrying and
> then drop it after we found the VMA.

Right yeah, makes sense.

>
> >
> > I guess not as we are simply holding the mmap lock to definitely get the
> > next VMA.
>
> Correct.

Ack

>
> >
> > > +     rcu_read_lock();
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > > +
> > > +     /* Lookup the vma at the last position again under mmap_read_lock */
> > > +     vma_iter_init(&priv->iter, priv->mm, last_pos);
> > > +     vma = vma_next(&priv->iter);
> > > +     if (vma) {
> > > +             vma = trylock_vma(priv, vma, last_pos, false);
> >
> > Be good to use Liam's convention of /* mm_unstable = */ false to make this
> > clear.
>
> Yeah, I'm thinking of splitting trylock_vma() into two separate
> functions for mm_unstable=true and mm_unstable=false cases.

Yes :) thanks!

>
> >
> > Find it kinda weird again we're 'trylocking' something we already have
> > locked via the mmap lock but I already mentioend this... :)
> >
> > > +             WARN_ON(!vma); /* mm is stable, has to succeed */
> >
> > I wonder if this is really useful, at any rate seems like there'd be a
> > flood here so WARN_ON_ONCE()? Perhaps VM_WARN_ON_ONCE() given this really
> > really ought not happen?
>
> Well, I can't use BUG_ON(), so WARN_ON() is the next tool I have :) In
> reality this should never happen, so
> WARN_ON/WARN_ON_ONCE/WARN_ON_RATELIMITED/or whatever does not matter
> much.

I think if you refactor into two separate functions this becomes even more
unnecessary because then you are using a vma lock function that can never
fail etc.

I mean maybe just stick a VM_ in front if it's not going to happen but for
debug/dev/early stabilisation purposes we want to keep an eye on it.

>
> >
> > > +     }
> > > +     mmap_read_unlock(priv->mm);
> > > +
> > > +     return vma;
> > > +}
> > > +
> > > +#else /* CONFIG_PER_VMA_LOCK */
> > >
> > > +static inline bool lock_content(struct seq_file *m,
> > > +                             struct proc_maps_private *priv)
> > > +{
> > > +     return mmap_read_lock_killable(priv->mm) == 0;
> > > +}
> > > +
> > > +static inline void unlock_content(struct proc_maps_private *priv)
> > > +{
> > > +     mmap_read_unlock(priv->mm);
> > > +}
> > > +
> > > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> > > +                                        loff_t last_pos)
> > > +{
> > > +     return vma_next(&priv->iter);
> > > +}
> > > +
> > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > +
> > > +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
> > > +{
> > > +     struct proc_maps_private *priv = m->private;
> > > +     struct vm_area_struct *vma;
> > > +
> > > +     vma = get_next_vma(priv, *ppos);
> > > +     if (IS_ERR(vma))
> > > +             return vma;
> > > +
> > > +     /* Store previous position to be able to restart if needed */
> > > +     priv->last_pos = *ppos;
> > >       if (vma) {
> > > -             *ppos = vma->vm_start;
> > > +             /*
> > > +              * Track the end of the reported vma to ensure position changes
> > > +              * even if previous vma was merged with the next vma and we
> > > +              * found the extended vma with the same vm_start.
> > > +              */
> >
> > Right, so observing repetitions is acceptable in such circumstances? I mean
> > I agree.
>
> Yep, the VMA will be reported twice in such a case.

Ack.

>
> >
> > > +             *ppos = vma->vm_end;
> >
> > If we store the end, does the last_pos logic which resets the VMA iterator
> > later work correctly in all cases?
>
> I think so. By resetting to vma->vm_end we will start the next search
> from the address right next to the last reported VMA, no?

Yeah, I was just wondering whether there were any odd corner case that
might be problematic.

But since we treat last_pos as inclusive as you said in a response above,
and of course vma->vm_end is exclusive, then this makes sense.

>
> >
> > >       } else {
> > >               *ppos = -2UL;
> > >               vma = get_gate_vma(priv->mm);
> >
> > Is it always the case that !vma here implies a gate VMA (yuck yuck)? I see
> > this was the original logic, but maybe put a comment about this as it's
> > weird and confusing? (and not your fault obviously :P)
>
> What comment would you like to see here?

It's so gross this. I guess something about the inner workings of gate VMAs
and the use of -2UL as a weird sentinel etc.

But this is out of scope here.

>
> >
> > Also, are all locks and state corectly handled in this case? Seems like one
> > of this nasty edge case situations that could have jagged edges...
>
> I think we are fine. get_next_vma() returned NULL, so we did not lock
> any VMA and priv->locked_vma should be NULL.
>
> >
> > > @@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
> > >               return NULL;
> > >       }
> > >
> > > -     if (mmap_read_lock_killable(mm)) {
> > > +     if (!lock_content(m, priv)) {
> >
> > Nice that this just slots in like this! :)
> >
> > >               mmput(mm);
> > >               put_task_struct(priv->task);
> > >               priv->task = NULL;
> > >               return ERR_PTR(-EINTR);
> > >       }
> > >
> > > +     if (last_addr > 0)
> >
> > last_addr is an unsigned long, this will always be true.
>
> Not unless last_addr==0. That's what I'm really checking here: is this
> the first invocation of m_start(), in which case we are starting from
> the beginning and not restarting from priv->last_pos. Should I add a
> comment?

Yeah sorry I was being an idiot, I misread this as >= 0 obviously.

I had assumed you were checking for the -2 and -1 cases (though -1 early
exits above).

So in that case, are you handling the gate VMA correctly here? Surely we
should exclude that? Wouldn't setting ppos = last_addr = priv->last_pos be
incorrect if this were a gate vma?

Even if we then call get_gate_vma() we've changed these values? Or is that
fine?

And yeah a comment would be good thanks!

>
> >
> > You probably want to put an explicit check for -1UL, -2UL here or?
> >
> > God I hate this mechanism for indicating gate VMA... yuck yuck (again, this
> > bit not your fault :P)
>
> No, I don't care here about -1UL, -2UL, just that last_addr==0 or not.

OK, so maybe above concerns not a thing.

>
> >
> > > +             *ppos = last_addr = priv->last_pos;
> > >       vma_iter_init(&priv->iter, mm, last_addr);
> > >       hold_task_mempolicy(priv);
> > >       if (last_addr == -2UL)
> > >               return get_gate_vma(mm);
> > >
> > > -     return proc_get_vma(priv, ppos);
> > > +     return proc_get_vma(m, ppos);
> > >  }
> > >
> > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > @@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > >               *ppos = -1UL;
> > >               return NULL;
> > >       }
> > > -     return proc_get_vma(m->private, ppos);
> > > +     return proc_get_vma(m, ppos);
> > >  }
> > >
> > >  static void m_stop(struct seq_file *m, void *v)
> > > @@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void *v)
> > >               return;
> > >
> > >       release_task_mempolicy(priv);
> > > -     mmap_read_unlock(mm);
> > > +     unlock_content(priv);
> > >       mmput(mm);
> > >       put_task_struct(priv->task);
> > >       priv->task = NULL;
> > > --
> > > 2.49.0.1266.g31b7d2e469-goog
> > >
> >
> > Sorry to add to workload by digging into so many details here, but we
> > really need to make sure all the i's are dotted and t's are crossed given
> > how fiddly and fragile this stuff is :)
> >
> > Very much appreciate the work, this is a significant improvement and will
> > have a great deal of real world impact!
>
> Thanks for meticulously going over the code! This is really helpful.
> Suren.

No problem!

>
> >
> > Cheers, Lorenzo

