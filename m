Return-Path: <linux-fsdevel+bounces-72462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459FCF7660
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 10:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FB25303D921
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4830C617;
	Tue,  6 Jan 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sgfI6tE5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i4QbydtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADE45BE3;
	Tue,  6 Jan 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690393; cv=fail; b=lHrC81pAxyECuX5+/iJnK3289xjZp2kvgYcr833UTyE3WUj9be5Sb9GvDgT92MSUtKyXeUA2+ZEbNFUvuVJL0uIvxuQaKiCC5sLpfK9kkSEIeySaSjNDJHbliM626zK0mHkmn5pY2yGHPUO6BBVOdo+MbvCCdSuMCxjdApOobqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690393; c=relaxed/simple;
	bh=jkUZQajaphYgcKP10J0etLPMX4jGS3kuLkmoI2m0RrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvfbXgkN7Y0yBj7LfURzAmCgyAguAXXMuuAhSLaMmtI5ovSU5UXgWJaygfG7BGphLVGe41ETZlfvjCkBHNKI0JdcltRK/WsNHx8yb0DsWYEkn03rF7POkodyNGHpOiRWVjR6Q+Fdq7hLbiwbn2xfG6mMUSQ8L1bFi69qzk6EJfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sgfI6tE5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i4QbydtG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6068pwNI3393852;
	Tue, 6 Jan 2026 09:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=no7rftcb2KySKs423niKKy2O31ryAVbqnlSuZOuf61o=; b=
	sgfI6tE5YhYoHyjZwy6xrokmgmZJ1LN1Sw/VYvIWNEAyRVku2bpMKm0sE4b5tBD+
	Lywd2U+L04pAW7V7Su/MqbPg0giUDRpC6+NsGKr1V3nE6idx0WqMMxzUthcHcAa0
	wjdC4+9pTTjY4POLDLqkimKNYWK4mIRgNVTugzI6G86ZvC++6u/X3IaK1gOKB7bP
	TH0Yu9ygmmBtouQU598SOOZ0osCDbB18AIzCsZZJsCwurDueMkwDw5kbMzJ/2UAB
	fws3ybNyJF4IoIATD+6dTTOiBbW7MMuag2TbOvOuIltDwHIJXpiknpWiqhUuvR5u
	I9AmspItXUqaYJkSb4a08g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgy8t00f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 09:06:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60680bUk026442;
	Tue, 6 Jan 2026 09:06:25 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj842h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 09:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR3ub4/CoeJScFREGDHyQnrJXucvGCXWfHCpPFIOnNRDgh56A+tL6aHkqF0T8o2C6GC7PbbyLEWWs/xR/AWKuktzcnJmlPv6N6HyyCTVfRFztzTijfka/UoNkkBxS1N9f5GITEBNYV7vJhhcp+z2iZHe5AjsFJFivuireCEA143Et28P6eh6VBDbTTs9AP1FtA4pNF2puoA4DjH/u5ALl4i4HIqXwgfh3z1uEIyaNMb6OHGWXBGa4E9gfVFibgbcb7qzo8JfgqsjqQ9eHdnXbxumscXCpemmeHHfK8RbEqmrP5YBKddszQEQn27iBF5bYwZG32DodS4K8Z8Xm56fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=no7rftcb2KySKs423niKKy2O31ryAVbqnlSuZOuf61o=;
 b=Y4gS7c8P1lin+mJtOjXmSOEc+Rte7tRp1Vxtd5fBKjygeWyiS4bknfI8QXSx4Pv28BpA2y8hnkDGEpy0LpqrWlpNYsn8cqyfZCiDqKbhEhfgBcGJYCTqjGBD5v1P4JVSf15vxYRFyXel7Ixui47B8QUCIeUjOrKKSCab/FXd3P/+TPckqm7T2S6p2Gsv+zZpVQjIefB6vOSELI3U2fK1CgS2E7eM9jQPjH503rTGBOOpJGgmTbgIuwenICo7ubWLKJnCGh63yCXckeY3FBCVXRVgg6Qn33ydy6GaxMhZrVz2hHdo8QxU+6ZCW9m/DuLrY2JlfS7Csgd3f0ZWcXsz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no7rftcb2KySKs423niKKy2O31ryAVbqnlSuZOuf61o=;
 b=i4QbydtGvpnkK4qqeATgxyCHLahENeGKCUXSowXGpsRnHmI+3AjbFC5KtKtFuZllW/rVwybo+4qO9xs4Edz0GshhDfqStCxLeNRRCBH/pGtN9rQD+W3hsoG7+ikevY/e3xgNYEPxnp3AUEOxAQVmJhqY15VZm1/f/Z4fdvuZYWc=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA4PR10MB8254.namprd10.prod.outlook.com
 (2603:10b6:208:568::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 09:06:23 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 09:06:23 +0000
Message-ID: <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
Date: Tue, 6 Jan 2026 09:06:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20251224115312.27036-1-vitalifster@gmail.com>
 <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
 <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0502.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::21) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 871ea8da-0e69-4708-8b12-08de4d02dcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWV5TUIzaGdUa3UzSmlkNDBtNEFBUHY1bWEzR1h1MUhGWE5lUk44dVZndFF3?=
 =?utf-8?B?Tzl0OENqVHZoTVJnVXFiNWowcHN6UkxuTzFQVkYwemRkVWlRY0xHcElFVmFF?=
 =?utf-8?B?TXp5emRtZmxQTWlpWnZ3dEtjVjZNY2p4dmFOeHVocTFjM0JmQ0FMNDd4QUxQ?=
 =?utf-8?B?dXRIWWFBVkVDdGx6bEF6dEx0Z2M2ZnBPeUZXeHBLR2JBQzhyTzk0dHBEQmZ1?=
 =?utf-8?B?YWZYaldFTGt4Z1lOaXRLWlRMQzJuaVdZME9iMUpyOFFHeWxGNHgrL3VBWUFX?=
 =?utf-8?B?YnVvUjk1NG5KYjR3eTdheTFINXpKeHhybzlvU0h1Nm9QYi9GOUNWV3hPR1VD?=
 =?utf-8?B?amRiaVlBQWZnY2VReHlZSHE3NEFCY1lCQkt5RVJmcThTQW50UUZISXB1L1hk?=
 =?utf-8?B?LytxYVhidWsxTXhaQTFtb0JXMzNZYWRvcXByM2JER0FOMER0NTFmN1F3a3Zi?=
 =?utf-8?B?UklLa1FoRWhFMzFBOGZtaFpSVFBhSnU5Y2JHL1lhdXZRa2d6UlN3WnZ2WStB?=
 =?utf-8?B?K1FUcXBtb09KSFA0Um5UK2dKclBnOUJ4V0FVbjl1MGtiNllNSzJtMVdMZDRL?=
 =?utf-8?B?SWRXalNiWWN6aGNEdEtwS2dXbUJ2NFduVHR4U2FUaG9FOXdTZEdvUm9xRlFT?=
 =?utf-8?B?YlNXc1FiUk90MzNJMUhNaGxVNTNjVWpDUCtDc3d2ZmhiMjZ2WWtKYkt6dDla?=
 =?utf-8?B?ekdGQVZMZ0VCaVFGYWk2R1NBQURvZFI2U3Z6a0tIdWpMTzZWRm95Q0lBc2l2?=
 =?utf-8?B?TWJ5WE1ta3o3YjRXMm1LQU1Vd0ZXYjhxdW91UzVyNENMenUzN3FHM2VsWGxU?=
 =?utf-8?B?R1Y4NkZXZVBuVHR6eTVwSFNnekxFbW1KQ1JCZkcwS3VlSG9EU1gyaG40QWZP?=
 =?utf-8?B?TEhpYkdkMDNBTlNDLzFYSGJqQ3dydmVyZ3VUUitEcksrMDFCanNLandXcXVZ?=
 =?utf-8?B?RU55NjNPUVU1NmRxKzhPc3R1aHhFcmo1YjRKVjQzQW53SW55b2VWMk9jRTNx?=
 =?utf-8?B?UU4zWmJuLzlyR0g0SGlTRjNHNHZuZ0FMdnZEakxsaWtTWlRZbDREQUQzQUxm?=
 =?utf-8?B?MEhVSGRWQTRJYUJDNFdMSGh2Y1orWTRQOU1uQlpTNVNpRlMrNUZQdE1uaGk5?=
 =?utf-8?B?RktTaFFQanpwNVFncHZ4Vm85L2JUelJLeFBUZ29VSW1GL2kxcS8wUUJ3aHJu?=
 =?utf-8?B?NnR4Z1cyNUZ3cEw5a3BZZ2lMNUE1NmtZVVpLd0J4aDdLTjYxVXphQ1FCdUJO?=
 =?utf-8?B?WGl2U1gzZkp1TUdZd2VGcjBvRTlJSFEvSGJLMDB5NDFjTFF3aFV1YzJHZkJU?=
 =?utf-8?B?V2Z4dFR2RWNUYkNnVHJPUUpzelBFeWVGa0YvRzQ3M2lnSVBoakNJTk1TMnhq?=
 =?utf-8?B?Y2JVYnR6SitsRVdpRWppY05iWWk5d2VWdmZBclIrUFoySGE3enhlWmMrYm0r?=
 =?utf-8?B?cDRmTGFTYTFnbHRtSmRyQnVjTm5OOXZ5ZnBPTzczWGpLRFBhQ2hRWlZEL0ky?=
 =?utf-8?B?a3NzcXhtZUVDemwxMWNIMll6M0I5ZmxSM245NWxqRnNOVGJTbytZblpVZ3RO?=
 =?utf-8?B?S1hKaTBoRldFN2hpMk56anJqQ3Y2eUZidTVCaHJpU1pqVCtpSDBBZEVINlQv?=
 =?utf-8?B?d0FzUzNkbEI3OVB6L2NJY1lpSG16T0hkN2dZOXNyNzBKSzZ0cEhzR1U4SHhO?=
 =?utf-8?B?ZUFQTm45WjI5aER4dHpxYXVJQ1ptd3lTQUtNdW1XdWREOHZscmV3RFV0cWlu?=
 =?utf-8?B?SU5IM01GeVZQVGMrRjUzMm1TaW9nNndUK1lVZmNjSERzZTUzZGliWkJ2Vklp?=
 =?utf-8?B?N0hrUjlaSW9rVHl4ZE9tTFpTYk9UTmwxaTVjTlNGdkFPamZZYW5IWnNRQmtQ?=
 =?utf-8?B?VHgvZkFuUDVhWHcvV0xQblI3Q3pic2ROOG5WWitvQ0lPVVFkZHp1ZnAwSXM3?=
 =?utf-8?Q?3lRVfnkoqnipEs2aqzcwhohRyj8exPbs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTNJbUYvQU10ZzFwQmxnOWlFTFZYM1RRYzZQRzArbUR6MWpvYk4yQjRVeklV?=
 =?utf-8?B?c25uWEV3emM3b1F4UTZGZ1RVaGhXcVBFL3cyUDdQVkpEN1N5SFd2KzVJdlhY?=
 =?utf-8?B?TTBjbDlaQnZUVHc2dUpmbWREZVFaNFhTZktCZktEOHpCQ1Y3SC95LzJ3dVMr?=
 =?utf-8?B?eHUzRFlhaEwrVDgybi9WVlRsM0hFOHVqR29nVkgzd1o3MWlZZ3lCMDNwenZK?=
 =?utf-8?B?MFlvcFJCQmNSeEhOT2o0Sm9SZUZ3OXQ5Nnp1OUNXbjBVam9YcnZwWWpLVXFC?=
 =?utf-8?B?TXNGbUQ4R1JJaWFOQWx2SHJSNFpka3BxaEhmQWoxQmVjQXRJTFZOSGpGbXJx?=
 =?utf-8?B?NFlKN3hpWjFOQm1aUlNEZ2tBQWc3Y1ZDbXFmMjBnQ2lTWHo3OUs5REdVS0ZR?=
 =?utf-8?B?dXZVMW0zanN3MlVMdVh4a0JSRXhKaDQxZi9CVFViMGRmelhrNURpbkFYbGwz?=
 =?utf-8?B?OThpR2dST1JBcXlLYzROajhpakxoWHdwbVUySFNabURwMEhvUHd5ZEdvZ0Fj?=
 =?utf-8?B?MGVmNTh4MWNrdGV4Y1EzampnK29DVTMrdzJhU1QrQzgyTEl1ZzVVMVYwK1RX?=
 =?utf-8?B?T1hvbXpQR3NVblRhTlZ2K0VObEcvcXVvRWxhTmZxNDhuUG9OUkdkK0ZmaHdy?=
 =?utf-8?B?bjlCVlhaODU0dm15WFJ6SmFoWXNjSUFPcjJaVmdkSW91Wmh1L1UxSTB1M0RM?=
 =?utf-8?B?cTVYTTJWa0JrbTVDQ3Q5eTR1dkFaaW5UazlYT3lua1owVTY2UVZvb1ZrUDVu?=
 =?utf-8?B?WnFjRlY3czVHOXhtNnp4b0ZGd0ZwOElaRnMyU2t4UTFJTEZ0N0hlMFN1YzFo?=
 =?utf-8?B?UmZOeWYwTDU0RVpWWnhGcTQxNVhQK2pjUGhhMXVoZEl6R3pVRjFNUElqalBo?=
 =?utf-8?B?T1FCOWFxS2V2bS94RnBJSk05czcyV0t4SDY1SVNGWG42WG5xSVhUTXR0Q1dE?=
 =?utf-8?B?N2lSM2F1SjNPZlQ0amE2UFNPWURpWkR2d0VUWVVxM0ZHMUh2cGdmZlk1dkcw?=
 =?utf-8?B?Z3RUQlFRcUhrQWUxY1UwaTlHYUJiOUZXTkNUeFBFVUtPQWc0czhWWFJQTXhp?=
 =?utf-8?B?Nm5DRmM4SVo2S0pZSE5DUGVZOWRkR1hObHJBUjBxWHFIZ3lBbE10MEtNRTN1?=
 =?utf-8?B?WHlyYkF3SUVac00zclI2RXhIQ2lJbHI2NE1iajZ4L2c0VjhFU25ZS2pSMzJw?=
 =?utf-8?B?TzhNaFk1c2cySEFiTXZtNjRpRGlOd1lDZTVaOVNhaFNseTFSVGhkQVFxeWxa?=
 =?utf-8?B?eWltMG1SVnVxSXg1UXBxNXZCNko3TWNKaXVkdnpMVmpBYmltbW9maXJIM3lw?=
 =?utf-8?B?VVFDWlVmR2Y5aW95c1FoWitxVTA5M2RtRFMwL3FHWjBzdG1aVzJLamJXd1BC?=
 =?utf-8?B?QU9qK3F0ZTFKbUJvNWxxVFExU1JNTnRIdkFUM3FuTTRRUGZQenBVcnhSbTYv?=
 =?utf-8?B?RDFxempKaTRFalRnYW1VUk82TTFBUWV0QlFuREZWbHJiR0s1aFkyVG5rczFq?=
 =?utf-8?B?QzBXT2tuQUFNSDQ1Nk1hdHRhRG42YTEvUG9JMXJhY285T1BmRnBxQm83b2ZE?=
 =?utf-8?B?amk1MlhMdXpDS3BUVjJmNFozM0dZd0gvMDRQb1EyVG1sdjNBQkx1SHQvL0Fh?=
 =?utf-8?B?eEFzamtmbWpIcTdQV3Z3b0VDTXArd09DREg2Tk9vN1BtUXR0SDM2RFh0Z2Nk?=
 =?utf-8?B?QzAwR3pRcDd0aDRra3pUTGUvK1VnZHJURU5mWlZVdzF6ZmJvdWQya2JSd3hx?=
 =?utf-8?B?ZDRmMEMyOGIwTC9jK2t6MmM2VHFrS2duUXg3eTh1RmkvUDJEUTJnVTBlYVpH?=
 =?utf-8?B?Q2JtRTRiTUFzM243QlNTaEoxckttZzRocVZUVndDZy9xRHVTWC96b0l3VlR1?=
 =?utf-8?B?OFVWemdCZjROTU5uSHhiWFo0SlhoT0E4L2phMGFmUktFM1djMUhnMDZSWW9t?=
 =?utf-8?B?eDBXdTl6Sjk0eHAzSzNMdVNRYVJzOEQ4anhxMnRVTlM4V3R2ZXdJcGNTS0ho?=
 =?utf-8?B?aHJVR21lYlR5NHhQT1NYaUtiMG5YamNqaFNDdy9SRGlDd016NmFLVGMyQUQ2?=
 =?utf-8?B?d3NqZHpiYU9jRkhSNWgrbGFXR1NYYk02cUFKcjlMb2l2SDZvVllNVXB6c2lB?=
 =?utf-8?B?K0NuQkFkc3pTSmNHR3h2dHNPaXhhWnk5RkVmYzdtUFd5WTRFQmhSNWYza2dp?=
 =?utf-8?B?bW8wT1ZrOFY4T1QwOXk4eXBBNkZtdjhhUkNDZHFEWUh1cnd6Q3V6ODZaMEVR?=
 =?utf-8?B?elV2SndNWThmYlBKQXdjcVgxb1V1R21YYmo5VE4yZEVEU2ZWTUhYK3pCSWJz?=
 =?utf-8?B?V05HT3RYMTNkWVpjVFpUV3NLQ0I0ck1UdDkrSmFjei8za0RxTk1aQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2cHOwkSCyz3p+ytOjJY9gAoheaZZw85ozHuKXkGJ/9kgjHKHjmPnpdxumlY9UeklCAhGvZLgRORkCRnuLSQZkQfdtTNpSJhrRWOYwzr41QzR8z3FBBU7LiOwIt9RJYE/b8pJ9C6k5QuKtpDIziMUZwcbN3hpDdAGyYVNfipD/7t/jfJuUdpb14O6IQV4TjnukY8CZ2Ufi4p2fjG29JNVuJGgXLu5NaRYW0+VErgqhzcerlfh4FNkPwio+GCg3zAOuU8R2NpKS9D6XFYNIysGO22cPIlEVGpdWb8roe3mNm1yCTtpzSHxS/9MTAFCC6i9GmHAQDa6Si/FCLM4DBJ+MFYX5q/dO+zbNNz3XLOWr89UwCFSPhEAdC2sovgssO2rgxWCePgo3QT+u8AEoB7yUA6W3kmoKdzRRzUmvvtdAmKn8CgO/fZare7FkiPnqDoCAz8Vgsv2CeSEzl5gRHPPThAA3acFMijMvu/zV+e91T3I11vZG2L6T2LAnDHDXrxRGo4ik6vB6mP6Q0rLpFOAnbqvvB/mntkZH6UgmZhsbyA6KXDDonxeIhAjPf93JJt3xEAKTzv2BH3ZPEHbyAYc0U8mFaGLvnM6zX3rqV1ze0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871ea8da-0e69-4708-8b12-08de4d02dcfe
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:06:22.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9fEGaEqJGTN1bTcJDd8HrIR1AvsaEZDM28KA5gfKs9XVzys4znwvxAn4RkuLQGKP9JVXTZ+741QdEAwU5uL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=887 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NiBTYWx0ZWRfX78lXfgCleRto
 Q7XFUHcC8iSkjm7FFck/QBwTGdOrgYYF/dF6XkVCqb2+WI+Y33gplJGDx3ZJD7EhTuunRtKNSGz
 HOeQkEbwgyKss2aoWc+bhD1vtPhgURVQZrNUT80zQZdx+fceIwRqbx/HRCurw16UgG67iX4V6J/
 om9uIhG0Y4ceEYlvJRRDEHqOgpvqduOt95u8fS3d8tqY8RUlUPAlSA6KSWEDSP2V2ttlcy6A0in
 JdFmDkGjSwgqIeC5MveF59BcoawAbZMhXZWsX1XzGoZtnqVtvIPLngIb6gxKAHsfx70ksRH70Qc
 aaysLXhGfsIZ4bWHMSNQ/G3ciV6Cb0y8waIfPVqwMRYXLzN900AX1sNZsQTici9rtUWpwKemtM+
 Ik9H011RAKgqipwh+G1/hUov5iSuustKQbwuO0FzE9syV2SttZ0ppMoUlIVvgmdZeNm0Uv4tNjs
 boQPnhoR7Pa2vas9UZw==
X-Proofpoint-GUID: S-11o7BRQ8qSJF8hyRcVSYV0m2Q2KzM_
X-Authority-Analysis: v=2.4 cv=JME2csKb c=1 sm=1 tr=0 ts=695cd092 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2sHx0uSwkbzlnI12IEcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S-11o7BRQ8qSJF8hyRcVSYV0m2Q2KzM_

On 05/01/2026 18:58, Vitaliy Filippov wrote:
> Now imagine that he sends a write but it spans multiple extents in the
> FS. And he gets EINVAL once again.
> 
> Is it any different from what I propose?

If a user follows the current rules, they will not get a write which 
spans multiple extents and hence no -EINVAL. That is how it works for 
ext4, anyway.

