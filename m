Return-Path: <linux-fsdevel+bounces-72327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8575CEF154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12D630046C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15102ED870;
	Fri,  2 Jan 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PsTouNan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YuUSoFH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DB2C0F7D;
	Fri,  2 Jan 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375679; cv=fail; b=kKXjfGlVbu7RROTgb5ZQkYsp58HTE32L2n/4SklhWEBjTEfZ63wrYPYEDHuIhpfRwaxv/Iiu0qlrz8rPOMw+EHUFb8LyyjbvgqLiHQitaYI1JLrXSseDwEm0N0VPo5o/cA3ARIWH6vBBGZIwplJ/Ns/a4wj8OjrHk3eMCnlASwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375679; c=relaxed/simple;
	bh=AyQVmH8iPWMDxZoAOYoVbX+/z5xybsIsfO0CJgcd2os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5rrpJu1DhdA0MAeKgGaIiRx4lCZfyLwWw0YQAM5tFwJCiCOtGla/9YpeckW5Dse/tr198BNMo6qlVh1se2RELZzoTC/nrvbvu0IejLi80Kwibzu5KfFraG2VGkTAr2DZQg+ZtaKP04/weLsX3Skndu97YWZbVr8JX5goXO4NC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PsTouNan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YuUSoFH6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602BuqM62742087;
	Fri, 2 Jan 2026 17:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lPM+z4jJGOLF9Sofg3Rzx+7EBvxRkIY1zAK3tBOzRPk=; b=
	PsTouNanjfRYpIfL6eLA3t+3M7mhnN9xf0F0RS9RTmWK/hXnVRluZyCJkZVPono5
	AIIIQoHNS4xdwT5OF/Qm/TsbpWRtdubGnfc0A+QPG4vxUqeCT1TC0eZXhs49zlTm
	ddpOhQGhaomlXVphESYBd6xCwT8HLKldv1KIe9gzkdwScEUOq36rgFMLBsp+E2mQ
	BJR1XApPbkXtoG7f4O1n6KWiB+2gBW/p83GTsf0E2gssGASfWGWVUTHRPgUOJG7e
	ZXWk6QzAa6clT3GoqGSTBDEuk+rCydrROe6es2GlxWvZ/JzF2UJhh2NVUsS1wDmL
	uTA9Z5KuuBd+dMInV/jBRA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba80pw9j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 17:41:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602H0fAp022990;
	Fri, 2 Jan 2026 17:41:12 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa2fyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 17:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us2h7IsV9em8C74GAnyjSsFg3WKFF190NsdCz1MPZr+uWP9XEImzyHUtDRRSKx7wMAVCnTXGbKEtwOTsPBOkmKVwZKfHmb6tYH0N/AorBjsZbJOslU57yiuGrHYgPEJQyRfmSws27KFqdQkrEdNGSIoD08M7jq0GAfCaVCUhcXVfGpZS4amRY9o7BSVaGioE8tlppVOKJAxe4T3LLD5UUwXCEi06QB5oNwd1/AB0ZnaVqZb4Zv9krTmM2qHNmZOTSxT1WHKaTbyRUPUKqic55WqTfSzZTbsWn2a7X9GPT3dO/ZUthm3Wapsp2rH4FEFbQPheB164mhHne45meHFDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPM+z4jJGOLF9Sofg3Rzx+7EBvxRkIY1zAK3tBOzRPk=;
 b=E6eaw9j7u+wS/oDZKQGM1WGzMzxT9JfskwHeqISJH27Vj825rOzC3lSRAwuvbpzVQJs7eUZ/bckt6Fw90xMUQPeKnGPwAQKGmxXB53BRr077/8gimN7OShQZcf+1bH+A5wahc1vvTz6OlmS88saxuCDo3jkvux6oTzQ35+qjW2E6LiMRCEgAeiQRS/vYPXUQOQ08jPYTaat76+0SMb58NKUPY7CzXMs0anSkQQZZCPLheg9HNUaBrpHzL3/1y6SyABVIkyL9bWKAXN0YJ0PMVk3CwQUJ2Qawyh1glRq7VIexZ4+IVQHz23Okyv2rtV19m7qyj8x0ERowFns0G9VkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPM+z4jJGOLF9Sofg3Rzx+7EBvxRkIY1zAK3tBOzRPk=;
 b=YuUSoFH6cMKUfEqN3mrgEirvYlgoyIkSpwKEZf+IPG4zt7tYdCaiOi+8P8TsyIR8sgKbjQ6FDrTCoP/02P25g0dl07ss6yFZXUrRnjGTR1zjVwpCvAUP6ucf1hIPHB7kHIQ7sMWfD6StyjMB5Bip2NSVZzFZ7v9pHeTBHO0b/QE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH3PPF54E75B76D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 17:41:10 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 17:41:09 +0000
Message-ID: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
Date: Fri, 2 Jan 2026 17:41:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20251224115312.27036-1-vitalifster@gmail.com>
 <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH3PPF54E75B76D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b104347-9f38-4f44-5887-08de4a261d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2JJZkNwTmQxaWNOWEU4dUpIRlp1bHJ4RGRhT21zOUtHR2tVWmhvUkV0Slhv?=
 =?utf-8?B?QVY4dTM0YXBHbm44d2phbGE5MklWb3JBUnVDd2JRMGlRdFJ5N1hCVVNZQ1dT?=
 =?utf-8?B?YU9GQ3o0VEJRa00waHRReW5TRGtVbjg0bzB2LzhuU3lMMnJwQXRFUERDOThn?=
 =?utf-8?B?eDJEaUZZRVVzcVZZTWMzNXI5T3ZDNW5sS0pZYi9SVUF3Z2toZVVlNmIySDNS?=
 =?utf-8?B?MGVmeFc4SHY5b09mSDFFcGZmWWxUNWFscEd4eTNlSG5GYUlZVHVwRFc1c3c1?=
 =?utf-8?B?d3dTK3FFeWlZdVQ0Y1hnWjF3SHdIaXVFcTNRUWZTVnFMaWZBSUR2Zm5IdjRK?=
 =?utf-8?B?NXYzemY5MEJkbldER2kxOTlEQVJJdDVjc3ZLenNKeGdSZXRHYkZJdCtLN3JF?=
 =?utf-8?B?TFkxeGJGdk5rUHhlNG1XUDhpT0pUaDA1ZGxlWFRZQXNXOWJwUWFmSWlrQjZL?=
 =?utf-8?B?bXY5eW9Oai9nc0gvKzhtVE5jYzVNYTIwSlhFc3JQNDlKQlB6RUYzaFkydFE1?=
 =?utf-8?B?UGQ2WUdHWTRzaU9UQ2ZnSk9RdktNSmpBYkh1T2hqNTdTaVhNZ29uMW1venY2?=
 =?utf-8?B?RFJOeXZZMXZiTlQ2UWY5anVtQkNJTzhjZm1Ga2hCR1N6bWpPWXlHZmR1dnl2?=
 =?utf-8?B?YXZyTUhqNlZOcm1VTFJDczVsdGRiS1hDUmRXWTk0OGx5ZFBsTXB4Q1FNVDEr?=
 =?utf-8?B?Q1FYTXZOUHZzckk1bnhnT2tQWDFkd0YyUkluVHMrWTJadFlQeXdPWTJJZysw?=
 =?utf-8?B?OEN0QjNjTkszMkZjV2thZ0QrbFMxSWYyZEFJMURUYjIrdW40UjRSS2JMSTd6?=
 =?utf-8?B?cHZQdTVXaU4yL1NHN3dzZUh2NGJQYkhJTGpOc0J4cnkvVkE4Zncwcmg4QS9p?=
 =?utf-8?B?Z2hHRXdOYlBDSS9XTXZWWTdjM2duclBsTHJ6UktLRFlMQkdTRG5ZcWNtc1Z6?=
 =?utf-8?B?cXNxNlluYVhMbVRzN2hQVG5CVys1WmlRc1JiQkhWejVvM1RWUmdXblErNTZj?=
 =?utf-8?B?VzBMTmFEQlNpL3BvbHU3SjlWMGhhYnltMnp0dnpTUXBaM2Q2VkwwSUowTlBw?=
 =?utf-8?B?TUxQZnZqWThOQy8vK2p3cEhvWGN4UEZ6ZFNVUU1mdS9ncHpzNDVWYVlhakR0?=
 =?utf-8?B?S3plRzJqQUQwcHcyWFVSeEhxTzgxMCtZb01YUFhGV25zTkNHWVdsWUNoSXRI?=
 =?utf-8?B?RkduL3FtSlFtMzZXY1hRZU5OZlFxdzIySU9yQVNCUXo2Q0c5cUd3UkgzRGls?=
 =?utf-8?B?c0ptYTdGYkhGQ1RpSzlMd205bVVodkdBUTIvazJ6R3hVcXVTeUdPVVE2OTB5?=
 =?utf-8?B?UExLV3JqK0FoZ1pxbXVVWk90RTBPa25zLzVoVW1VVlA3TUtxR0l1WUhIQzMy?=
 =?utf-8?B?RHhRUmM5WXhoZCtLcTIvMUNlRUxqNGtuYW5vZmdKTVFwQjZiNDNBSDROMnlV?=
 =?utf-8?B?OElDR0hBY0tOQVA2RFp2RWtVTll6N3diZGtpb2g4K0Rnb3ZYd0lmV2JoZHBi?=
 =?utf-8?B?SVFhTm9mZFFUQnp0ZW5ocjR5MGozUGNpNFFqdmRLaU1abUhTem1VREtETzZr?=
 =?utf-8?B?V0EvV0FCb21sbVY5OVppM1laL0FyREN5SE52UGpMKzFnNDB0TzhsbisyZjRh?=
 =?utf-8?B?YjVXQmRQQlFlWjdBSEFycVJWdjBOK0hPclN4clZyUm9IcTBnUG1rZHR1dEwv?=
 =?utf-8?B?b1kwcGVxQ1VqdHBkSEJPZnB2THhHdjZCV3ZGMEVORm9HaUs1MXdqUU5STG9m?=
 =?utf-8?B?WmFEc3ltTndJWHNyZUdEU1pBeEJpbDFOVmV5Vk5oM3hiUTkvQXlCRjdqNFZP?=
 =?utf-8?B?VmlsMmRNZkVobUU0NEJ2VEZoaE9acTVTT1ZCQnVWOEdxa0hGUVdZWTlZNXZL?=
 =?utf-8?B?Zys1WWZhUFY5U3gwaEZib2pmWG5TMW9aeXR0b0pmaUNRYTgrcnpIR3hGN1ZR?=
 =?utf-8?Q?ohtvmdf3i3mW21IbvxeZujtjOoBhMhNg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC91M210cTNpWS9aL0lzWXFDNUxnSTNNaEc5MU9EU0R1L3NBZFY2YjNOWDI1?=
 =?utf-8?B?bFNDQ3Y0MEdoSUZ0Um1yZlZEd1FLbCs5ZDU3dzF1WW1MMVBnRjJPdjBhanNK?=
 =?utf-8?B?ZStwa0kxeXpUWFNlMzNoMVhBWitGMDVZMHdNdy9hOU1GWmRpenZvZk9McVgz?=
 =?utf-8?B?bUh6Wlh3TzluWjBSOUVwNWZDaXVncTJ4UVN3Zm1hMktraFU3VFF5dEZxdFdR?=
 =?utf-8?B?U3ZoTWdnUEx1MG13aUd1T3N3Y3JVZU42WXROcXowbUUwVWFrM1lEbzMzRXdx?=
 =?utf-8?B?M2ZOYzBIUmZwSnFUQ2hnYTRhOVJpVFo4UXFQNjJsWi9NU1FNUW0xdUd5d2Jr?=
 =?utf-8?B?QTBuL2hJaWJvU0hsOE9MWWNYb1cwcjFpVXFIVmlRTUFzY2J3czRFeTkzYStk?=
 =?utf-8?B?bHNjenBFUDB6SDUrSmdadTFYZVh1TGRTSlFPbWhvNThNVjJkQkdjMEE1alZo?=
 =?utf-8?B?NnV0N2c4eEhaMEFzMXBiRTlVbzVZQ2dhOTZxZ2sxTW5TWXVuYkZKSTdMNm9n?=
 =?utf-8?B?aFMzVmJvcEo2V3YvZnNiWUZGKzlxSkQrTTFWMXNvQTh0TlZvV041K2RQalVM?=
 =?utf-8?B?NFU2T2tJa24rSGRjNjB5SlBsUm9jL0lLSHE5Q3hUSzRjb09BOWxLL09zUEhJ?=
 =?utf-8?B?djJkeFhqNTNjMHJ4NktTRDNuSUdWSG5VQlRKc3pabzFHT0hTcGRPcHFudHR2?=
 =?utf-8?B?eXdBSjdjTWZocUxvK0FLenRkcVR3cnZLMzNSNGZiS21VaGh3UE8yL3JIU2dJ?=
 =?utf-8?B?QTVRc3dDeklSNXdUZlA4blUwU0lhUGRGN1ptckRSbXBJaUJqS3d5SlVnMXcy?=
 =?utf-8?B?cDZsRnZGTmxQUmRhQTRKeDlOdDY3QjZaNDAyQVhGWjRUU1V0aVkxazNVTjhP?=
 =?utf-8?B?YTkrczJpWFgyd2I1TUR3bWprbXhyUVpPODRrRXVjMG1CRE9IbVg3SUpJTEsy?=
 =?utf-8?B?b1lEVWV0UHVzNXdDb3BKVXgrblM3blh6bzgzQ3lWRlB2Y2tjWDhQZ2RJdU50?=
 =?utf-8?B?SkVWVktDdFVDMmYzVjhSVWhvU255YTBCRktiVDZmYXhOQk00STVoRy94WnVx?=
 =?utf-8?B?YXVwWEF1YmJqbW1XeTdLYjB5UnpJbnYwUVhOYkFXb1NlY2dmb1IxaFNRSWNj?=
 =?utf-8?B?OWdCbEw3cEp0UnozczdEUnhQaERLam45U3dwcG5mcDRkZG9Sa0pxQ2J5SGt3?=
 =?utf-8?B?eTNxUVRzd3dXMktLd1crUGhMbm9sYVNuK3ZwUFdpdlRxRVNGSmpRRzVCb2w0?=
 =?utf-8?B?MXdCamNHeFdKbjRySEQ4a3FBellZTmpEeml5L1pLVlRSMWFrMVNlVEFXTTkw?=
 =?utf-8?B?RjlEdnV6dWJrMnZBVHNUOHBYTWtWMTZ3NEh4OGRvSVpoaGp1QXFwdldmejUz?=
 =?utf-8?B?TDkvQm5NYU9tSUFySkVwM2VORkJqTFZ6aTdEdHZQSWxFTGEzNDF2RW1aMm5G?=
 =?utf-8?B?bW92ZUlncFN1Vnk4cGdDczdEN1RJZlI2MTJEZlFnUyt4ZG9mbkNoQ1VrUlcy?=
 =?utf-8?B?WVVCVTU3TVYvdTFNU0VNamFJcEd1elhaZC93Q3YzMDZtMEZvWHZHQkVrNmJH?=
 =?utf-8?B?YVV4am80QjYra1BrQS9kbVhyNUt6Z1hWK0ltVENqNDdHVU9QK0tpZVBNQU81?=
 =?utf-8?B?SGdHWkVXRHBOWjgrNlBocjBodjlENzVPbGo2bW9xb0JST1ZJY1pmNFdEbmJY?=
 =?utf-8?B?MU9vYzI0QkZWWkpPZmdvYjh1Vkw2am5ZZ081Z0hhVHlBVGkrVTU4V0JlcmJM?=
 =?utf-8?B?Z1p3RWJUaEZvMDMvT0xhbmFkSjZOK2lnbTRoM2tPVHVDUzlWbE5RNHMvVHVJ?=
 =?utf-8?B?dlFtbjN6TEFWTEF0U1drOUd3MW82aDNxU0JESlVYd09ZeDhJbTZJMElUVzZR?=
 =?utf-8?B?L1ZHSnBjSmJBclpIU1VaVHZSelpQbkozWVBNRzI3K0F4b1N6a3ZNZDhpMXVY?=
 =?utf-8?B?YkNwanlxQndzcExTVjZiNjFFcUZQY05DZjZyR2JQTDRLcDBlbXpWZFlKdU5Y?=
 =?utf-8?B?dEV5ejhZa3JMTEVnMXVVdFZuYkR3Y3FEU0VtMG8yUVV4UUdkcWlWT2FoTk1Y?=
 =?utf-8?B?cTNKcUZvQ0J4RTNtWGdHV3pnQXRKb1Z6dnYwWmxTMkk0SHY0b1FkaDl1K2g4?=
 =?utf-8?B?blF0WlNZRWhGbzgzZWh3RWpUQWpabHk3WXRjM2lSU2dtZklvcUZEbkQ4eUtU?=
 =?utf-8?B?MkxqOWFETzI4RDVsdXRVRldsQTNSdTVjTmYzb0xEcGMvOFE5SWtGVFprQVYx?=
 =?utf-8?B?a0F2QUxGZE9OQzVTN1VHRzZobk1wRFA5a0JwUkRRT2tjYU03Vm8wSENxNkE5?=
 =?utf-8?B?ZVhUOFNWVitWZGlUZ0drUkZLS0pYVkp3c2NZUUI1cnNwek13alVTeDZJak1M?=
 =?utf-8?Q?uHYPMQyaEL1AneMw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+IjjBAw7S/LqRZIjvh0lDmGAyZ+0elUg9yo3qry/ItSk3mxJbY75JHzclKO+OOAvf/o71X1fmayohS6GJFpUl4erPbdjk1a8LZ4WRvgcw1WS9HrNiR8MqjB9RnA3/PyedTC/4pmkV4Y6SMrB93w44CxOuoy55mOZsG373pe0lBYyH6mL7S975tfYVCX1gq3O6RxNi8FZpXe2vRa6R2HI0tINQtUt5t/NvBlTrs8Mhazd0ygpyg//Cn9HvPtv/Yb5bJsc1G1Jqepr7a420IVLieWplPLoF5bbApq5QT9bAmdpFcVAUCQ92ZZau2yFwo+Uz8KQ2/cv9XJ3a5nqCIbewGxmnbcqbk4drS4E884h0UlvAZ2CMtMmzyMzCEARzIXmxf+1Ir+jJxJ7xwbTrxy2Vk0os9WDZ2nH+AL1d1hYeBHl130ThY9h04LMUz6KaGmtrpjV7JOuQHKFk+Vm/cGwPRmlrwjx/Po/p3ielhUc8ZyHeCUNxdEPaq0slpHws3CwQq+mtYG65uJDA643dIpBGexwT1NWNt7CFzwJEX+WzebZVtPu+x5olo8BVARFDZzc22OyVbiqXkDDqHw8cSW6iYT8OWeykenGsdBUsvHRME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b104347-9f38-4f44-5887-08de4a261d07
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 17:41:09.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jECk1YWiiZBtoOjImtDLq5CFvhkFFHf7JUediBwTwabgVAQ/loMrn5tLu2r5SniH6DczQU/cGjnurE4hCHHJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF54E75B76D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020158
X-Proofpoint-ORIG-GUID: 0JFfqbKKEuxMpVHK9lq9ErsqyMtHa8AM
X-Proofpoint-GUID: 0JFfqbKKEuxMpVHK9lq9ErsqyMtHa8AM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE1OCBTYWx0ZWRfX7zRR5Ri8GTaB
 Ra43zV8GXXn8FDhPLoBNBkluFgaiOpmidwHoRGnOpz8X1fa2MHrMvPdegWH4hNSfFJNGkA6Xvc/
 ycnt7AFNAEnuvkID/eb0bMYxg/p1Ek/2qEP/l2i9lGMBguxFmQsy96w//87eB8k85nMHAv08xnk
 U3ei61S+nsR2/90UUJ7Wcc0Uhf+HvvuHRXPb+iT9K/XFgICpTeQl82WYz3LfSOpbMKQ7asEzpTF
 xhyXulszsDflnSyYxtBQHkOpu2XeUV0g1JOVk1nr6e4W+rrwiLvpLNbvP7ahFp6Lz81Ey0nOP5+
 2xDtLBsruZwRfiKPpJ2FDtQFIh634R/IeWooDYVl0PBr7n/nT3rbSZ9AMJPIZuHaxfogDgE9c9l
 AdHLRhZYTSQloYWkcdwn6CtlvsZMfQDwBCAIFcjMMPMocw86aIXdE3o5Z2TT7PpeyUvKx8+wa6L
 +1+/TZHYwFBQg35kHzw==
X-Authority-Analysis: v=2.4 cv=RY2dyltv c=1 sm=1 tr=0 ts=69580339 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zaj_tT04WGOIV9spLFIA:9 a=QEXdDO2ut3YA:10

On 30/12/2025 09:01, Vitaliy Filippov wrote:
> I think that even with the 2^N requirement the user still has to look
> for boundaries.
> 1) NVMe disks may have NABO != 0 (atomic boundary offset). In this
> case 2^N aligned writes won't work at all.

We don't support NABO != 0

> 2) NABSPF is expressed in blocks in the NVMe spec and it's not
> restricted to 2^N, it can be for example 3 (3*4096 = 12 KB). The spec
> allows it. 2^N breaks this case too.

We could support NABSPF which is not a power-of-2, but we don't today.

If you can find some real HW which has NABSPF which is not a power-of-2, 
then it can be considered.

> And the user also has to look for the maximum atomic write size
> anyway, he can't just assume all writes are atomic out of the box,
> regardless of the 2^N requirement.
> So my idea is that the kernel's task is just to guarantee correctness
> of atomic writes. It anyway can't provide the user with atomic writes
> in all cases.

What good is that to a user?

Consider the user wants to atomic write a range of a file which is 
backed by disk blocks which straddle a boundary - in this case, the 
write would fail. What is the user supposed to do then? That API could 
have arbitrary failures, which effectively makes it a useless API.

As I said before, just don't use RWF_ATOMIC if you don't want to deal 
with these restrictions.

