Return-Path: <linux-fsdevel+bounces-38065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAA9FB3C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 18:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE2166018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58A1B87E3;
	Mon, 23 Dec 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bLSsD3b9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jjtdi0e0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8C7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976695; cv=fail; b=o501Jja9ExTV4ePti6XLzFjDXUJqtjYHH5kQFNzXtAM3eB91Ri89T+IqUzMs5pFtHadV6cgnpdLWRE8ZQuHKj3Yi6KTvx1TJBxXjjPO2DqO6XkJm43MUgKHvittrsC+eRnzmImcchGsHd/R8c9NHUUwpj3aUE9tmscKRi9Abvsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976695; c=relaxed/simple;
	bh=blrioWAK+aA7nH2XAFEnqp8P3x2W+maiEHxeWy9A0oA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PfUHyoidbnpBDccAUslSBA72wfSFts5l9BZP5JsIYJp1Aswrw2ItRaXrb6/NoSspvQ1kkl+ZNYL7rv4tcuX4pbJaQXmW1ppXq/hG0VLM7ZqMmYdapl89keKs3hRWCeooT/CWkNVC6GTVCnOODlL3fMSDao7uE2P4lHi8eu2P+SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bLSsD3b9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jjtdi0e0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGupfH001757;
	Mon, 23 Dec 2024 17:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PBnvEN2y6zH6fHkuz46xKv34Rw2QQQRdOXRsClO5Xxk=; b=
	bLSsD3b9Yxrrl42hWSZDwJdQ61XR3q1RzzDEqXp1QSnBvtG3gHGF9RLhLsYcw4Wn
	DKoAvSHPtn6MvrCxYEDxhe2z94eiQiSZHCAwtc5jhIfgdPuA116y/e4VjkHeJeqJ
	u8jp4lzVGltaiaKm5YhfyrcRJOqhpx5Y1PJ7dGKSS9GMkAKoQs1aqyJa83Vadm5e
	6WYOSXqsqZbB1oi/NnjjItg/UbqXqR83S+jUbqaABZjXQ0q7j1qY7dNEZ5SSBmdg
	K32TP6N8dyiQ9HK+0BW62hQCL7cwZNvvap+9cO576PSgLBq7y5IS/mxglVO54tnb
	IXr8b0bHJvYsUDsoCA3S2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9yayv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:57:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNHA94J015927;
	Mon, 23 Dec 2024 17:57:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4df98d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdtYe0K73Iv+69uPeEHUOVJNiQzW/rgzKNFR3ZFYaBsWVCw+yrUV54z5SXqKxvAzZfFJ4x7ZPUKzU2NJ89EBoZBshii5QDOYUAOwKITZInKJP3m2bEnV/TTHhAAvs1SXQFO+BoocD6h3wzWcg347xJB7fSs/Ec4/emD5pwPgHwNdNcLmoFR6YXatBe4QyVD0b+0slfzeiRxkXAkVylUT8z32YNbSAOPmvcnkn5qoDaRpt4wzgBz6isEt2PwAJ3j6A/3N5rQdkoIXZZnxRktR2sTwOOeIDfMHHZgWvukhyh3Bhb7FquP+nsL7KdL+JSbneUf5CPP2cpEB0sg5ocqrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBnvEN2y6zH6fHkuz46xKv34Rw2QQQRdOXRsClO5Xxk=;
 b=QgEo6+xjiP26Wmm9vdRCoBjCzRAp6APWcm4s1UyyrAecOZ/MEb9iecOhU84OwigBZww/j3juAtQO6obZxU8ShALnzheY6b5WaQfITX1Pste6JOx4wj06gvxnZtLzVkviHa26PIv+RirtvsMKQ2QrYqzzbh4O+df2r2+ziAifJfuXXWkNzJ+Owo9IF+A1G9l1sXWbTusFZA69dcZzKR5BQuZk3jEkV1lQqAPvDzvNbwX3khpA2uYGnhwtwrd0suB35dTlBihgo1eRe9oPXtVq9FgG7ksNRpvF6If8c7sobC9M2LpPkq4RfbB5Beiq20IU5GvjW6cj6R+Crj92TTGhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBnvEN2y6zH6fHkuz46xKv34Rw2QQQRdOXRsClO5Xxk=;
 b=jjtdi0e0sKIIIAmwAKkBLymyCjnlZJHGCvMbKK04WX7BvVxV6FXqovfNS2aVgHlaQxuMJMOw0qg29dJ9BGuY/1Tx4o9d0nhVTUcVh7W1QaAz7bNE/MeZ0zJhDBcr0fWDiDlis9kmkIMPojDgtSH57Bi0kI7vRIi537EUZWsIoPQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8041.namprd10.prod.outlook.com (2603:10b6:208:514::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 17:57:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:57:44 +0000
Message-ID: <514a1e9b-b8d0-47c6-a10b-69ecf3c51d21@oracle.com>
Date: Mon, 23 Dec 2024 12:57:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] libfs: Replace simple_offset end-of-directory
 detection
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, cel@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-5-cel@kernel.org>
 <pguxas3azhbjaf5peijhzzaul45h26lmh44or2vsulpxbnvv7m@apmmkc3mewq5>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <pguxas3azhbjaf5peijhzzaul45h26lmh44or2vsulpxbnvv7m@apmmkc3mewq5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:610:e7::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: c97acacd-832a-4196-a41c-08dd237b4daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU9McS9rV0xNaytPNC8yOEZzb2lHOEhEQ050d2FibTdyS0ZZeXR2UGVndjEv?=
 =?utf-8?B?WXBxc2FMb0xMb2xESXYvd2FJZGJja0lGL0lSemc4OGhzRU8zbWZVd29raWdX?=
 =?utf-8?B?U1FoWFlONEkzbWhxMVM1bHZoWWtmTnBHOGFQc3FoTHkxWk9rNGl5bkZmZDV4?=
 =?utf-8?B?bW51WlZNZmxTcDJDTFlxeXh2M3Q4WXpvTGRvQWJyTi9Fc0h0alFQQ2pDekcv?=
 =?utf-8?B?MFB5UGc1bWloRWd3SE1jSEFSdXhBMWZlUUdGYmZsMWROZUwwRmpQV1k1L3JC?=
 =?utf-8?B?TFR0SzBYL0tRaHZ0cDhVNUtlcVArOVNNWkNsN3NUYU1BSnZid0JBdkdWSkVu?=
 =?utf-8?B?K05GYUc1STk3ZHhtTGsxTmpLZm1XLzJXYXJHemNyYWFad2srUVNnakFVcERi?=
 =?utf-8?B?dDhmYU1NNGF0VTY5SzZ1ZjVxWUJ1eWlGMGQ2a0VBNXE5NE5hMEJid2RUakFx?=
 =?utf-8?B?MThRcXpqNlgyZERzNXRCalRDMnNOdWhJdW1XY3U0T0dNUWFPNzdWWTE0Tjk5?=
 =?utf-8?B?bEY0Qm1UVHFGQXRqVkRBdmVxQVBpMWFRYXlDOU1OeEh2VVhZa2NjTU9HdlBR?=
 =?utf-8?B?WmZvdlZ3bHBldzFvaks0QVpZcVpFWmFiSEtQbmViQ3JWa2tZTDZmTVcwOHVB?=
 =?utf-8?B?K2VSSVpzSHpmYlFaQlM0YU1HczliaE9CQ3prMm9tdTRoR2lDMURSeXZXckVK?=
 =?utf-8?B?Nmd4WUdHUHBtaEswRXFMcEdhMURRMTlmcDAwdk51Q2RqWERCWWZhTHdlRy9E?=
 =?utf-8?B?dEpTaVd2OEVHYU9uUEI4QnVpK2trZy91ZVBYNGRydWZjWCtzT1BDMTdaSTd0?=
 =?utf-8?B?TlNZQVhHUnVwcUZVaWVRYXNMQXpiQWVoTEwzZmpWUDlFbndDNTBjU1lhOHpw?=
 =?utf-8?B?b2RFTmNHM2lPTFlGc3JnaG1YZGNteEdjY1JuOTdEOUlHakV6NHE5Z2FkOGFX?=
 =?utf-8?B?aGRLTWZlZzR4bHcrR0UvOEhSeDcyOGNyUFVTREY1TiszeVd4NDNJZllGalFQ?=
 =?utf-8?B?dlpxVXBSS2pvYVE4bWl6akpDR1lzUFJVRC9md0t4Y0JEUUJvaC9mNktjUTdj?=
 =?utf-8?B?ZGEzYldlbGdaczZWdE5oRzZJQS9BZkVOY2V3RjRLWUtxZ3RLa0RMMFhIRm0z?=
 =?utf-8?B?NWh3cGRHanFiM01HTzlBNTNwTXpCZmRNc1oyYTh1bjFTREI3WWZWakRQNERM?=
 =?utf-8?B?aC9jWGhwWDFuSzdQNC8wa3VOTnhIOTk4cXlDb2FnQ0xYZGI2a0ptczB4QmFY?=
 =?utf-8?B?MHk5K25lTGUxYzVlRjFoWUNnZ0daSWpRWEtSd2tNaGhGdVpJc2Nsci9FRWln?=
 =?utf-8?B?OFlTSkx5bU1VNmNaMDN2cjNZRFhpS3E1L25RM2w0aDFjQTJ2dk9uWG9IaThF?=
 =?utf-8?B?Y0lPRHBNcVhiL2NrUVRBZ2pDa1J5WkQ5UTduOFZVWUsyS1hFdkdnY1FObEFs?=
 =?utf-8?B?dXJqT0JFOGlWaFlLb0lyVWFQSVp0dExXR1N1ZGdRVm1PK2t2RmloN2w4QlZj?=
 =?utf-8?B?cE1abjN0MGw0cmlvcyt5NkV3dldPWHJsZGh0QUhwam1uMTM5Z1F5V0FvbzBi?=
 =?utf-8?B?UVZJWC9wNlVDMFFnSEVqRGovT3JoSzE1TjRMTTJuRTdrd0l6alZhNDlQV2Fv?=
 =?utf-8?B?Z2ROcmdxd1pZVXRkMi92YjlHcDZyU2picnFEenZwK25aVDBJSHZxT1NYdTV0?=
 =?utf-8?B?Mk1DLytkVGZWNmZPN0dIZUZ5ZFdWSC9zVU56T2J3K3pJOS9KOWt1S1hQaUFX?=
 =?utf-8?B?MCtBbzdGMndNZ1pPSnd1Y1ZFL2VwVlpXa0QvSmRzcHRpL081TlFRdTBLQ08w?=
 =?utf-8?B?Z0V3Qzc5Y09QV0VWN3JzRjB1dmo1QUFsRmsydWsxSUFwcTFSYzRXZ3NhTkg5?=
 =?utf-8?Q?61Uf+rf1Lgj/d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHJpUWZFSUZ0dmI1b1NiY0FoYUdyNkJvZUZPWENIL1pnYVROa05pbDVuY2VH?=
 =?utf-8?B?ZFo3cEFXcEhOd1JxbWRBQTRnUWhVNjlKRHc3bk1NK2RuZDk1MVlQV2d6OHYv?=
 =?utf-8?B?aFBvaTBEbGVxK1FqOU9MRmZ2NWdPTkUzVm9sZS9rQXJYSWJLcnlUN0xiRzNM?=
 =?utf-8?B?TlNCbXc5Qnpuekw1MlNOU1ZUNWVVc0hRd2JSamF4NDdQRWZIcjdvWlFKTnJD?=
 =?utf-8?B?Qy9xL05xcjRoR09nTytkYnNtV0RJUUVIVnA4NjBSQXl3Y3kvdGFpYzdtWHNY?=
 =?utf-8?B?a05FMWp3UnF4emd3S2pHek9nUjNZOUp1VjVsWmd2Z0JNb1YwNW5UUjd5M2ww?=
 =?utf-8?B?UU9uQUNGU01ScFdFQWYxTlFMMkJBOWtxNVF2TzBSM3psMW9URVMvOUJ6Vlhj?=
 =?utf-8?B?bUdUa2cyU2VXR05QczYyc3l0VlkxZkZOUDFaV1h4eSt3SHhPQ0JrU1craGNs?=
 =?utf-8?B?ZWxZcDZKTWxBM2tIazNCcEUzdEV6OFRLTlZrRnpoL0FIZ3VvZE5NdmM4R0E4?=
 =?utf-8?B?U1h0M294UGVOYnJUaTFVTXRGRHhUUEZOM3ozTy9XUktuSEMwSmp1QVIxSEN5?=
 =?utf-8?B?cFpwOHRhNEsxbHUxb3JBTjZMdmNHZTU5bGxqNUQwdGVDc2RCY2Q0T3QzbU55?=
 =?utf-8?B?U2EvU1VFVmFjTjFReFBNYTFiQVFMUi9pOVVFYUVMRWZ2Y3k1WHJLL0JtMTUx?=
 =?utf-8?B?VnlTMUVkYSttdnhuaUNpS2JWdVVyZVJ4K1pmMXJKcGR6bEp5Yk1EUmVHdGs1?=
 =?utf-8?B?STdSNFNtRVMwMjVQa0hXdVlZTXhQN2x5RHEyQW9rYXNoWTdPSXNuUUFIVVZI?=
 =?utf-8?B?VDdOd3l1ZnhBYVBjK3E3ZFRIc1JqWk5JQlBWb2RXSXhrWnhTakdxakQ4YXZa?=
 =?utf-8?B?dGRVaFY3ZWtta25RZXNZT3NJbVZKbUJuOTBEZDNOUTA4alZIMUlxM0dvVFVW?=
 =?utf-8?B?NEt1cjlNSjNnTFUzUEZlYzB5VEFBMzNwbGdTNVdJQ05yY2ZJT3VoV0gzYjNF?=
 =?utf-8?B?c2ZSbzROY1Fna1VwbWdIaWFSd09RZHpwSVF0eFFxeG1MSFRIeVBVTGRXM0VI?=
 =?utf-8?B?R3RVT2tpWnFKcjF1SS9GbEd0MEZ4REJ2K2EwaGZuRmlKOUIwVmlDVUloUEZL?=
 =?utf-8?B?YmRuWnhwM25SaTlPUjZpcitsNWxESS9DL0J2dDdyT0svTnJ1SFlRMFZBYVZG?=
 =?utf-8?B?c2tkbHhPZHA0Mmwyd3I0amxidnQ0VitBb0VXSEVPcXZXZ1RSVzJkb0MzMll0?=
 =?utf-8?B?Qk4rL0lwM2VBWGdoaExDTTIwRGdnN1NJQXRkME10dmI3cXMzSXMrUW13cUE4?=
 =?utf-8?B?SUpOUjhJVDd6b2VTaWlFa1pHMzA2QXphWFl3NEVkRWdqRHpwYWh1OUt2M3h0?=
 =?utf-8?B?bHhtTmx6bG83WVZTWE96RkJCcFNCbHl5RlNrUDhNbHNCeHdOYzE0QTNrSkdZ?=
 =?utf-8?B?ZDZFZUlPN3E1UHl6M0M2UkF5eC91ekxoUGswd0t5QkNLSkhUTVhKaFgrSWtX?=
 =?utf-8?B?Q28yUkhMQXczV0VXWDFSYUd4RzQzc2lzd2lKNW4rZjN3b1B2Q0txVXNWKzRt?=
 =?utf-8?B?Q0QvWW5IY3Q1OXZDWGxBT0VCT0pnRUVhRlovRXJ0VWt5WmlZK1l3dnBHbFNL?=
 =?utf-8?B?dEEyU256c25tK1d1OVJwL1lzRFA2aDdraU1Yci9wYytzZUI4dXAwRjVRd0kv?=
 =?utf-8?B?VGNKR1dmUTNxazNWQ2dwdldwNSs4aVprcWM5RGpESzRoQkhnVnVNeHhBK3Uz?=
 =?utf-8?B?c2hjTGxRdmh0Q3cyWmF0bDN2MDJCQ0NNTWg2eGFReURiYzEwZ2MrRlpDNTcz?=
 =?utf-8?B?MkxYWGYva2k5RCthdEp2TFpYYk96cHdvNVQ0RXl5QlFQeTlLSFAreEFOOHdB?=
 =?utf-8?B?d01WK0RzRzFUWHlsSkc3THgvTlNDSndnMGZWSHhUM0F6OWs5MVdqcUk0NFZ0?=
 =?utf-8?B?STJWSGZZNUU0Q3RZekd3NkFCVGl5ZEpnTW1BT0N1dmIzRFBBMUJtSGtSaXA5?=
 =?utf-8?B?dnZyVmNaaWpuNGV5cXJyNE03SXpYVjFrWUQ3bmduRHFiOWpnMW5WTTk1ZTdq?=
 =?utf-8?B?ZHVLRDJkMkhTOTArL0tyTjhxUnFRWUIrK0xKTm5LU2VkWW1vZWRHTmNuZ2lF?=
 =?utf-8?B?ZmNDV2hIalhDLzZBWWw3bENRakUwV05aTFViYW5CU293WlJvNVBmWG1adGdO?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dxhM5aI8OpGx0vwc95VsztQM3BiwX4rSrytyrvfSpPqLRjzb8mgZKfWpnRr5l/yTGEBhP8PWfSow9M/VbA4kJmA40AR0LyzVMVXL6aUU5hzPiCMIspwLXxglS6BKXnC51v/UjA2v4Yzoie6+xJ92ujDztBK8LXxaAFeKWCUgHdUt81hv1vaXYOrPla3Pwi6UhhEs1HV6KRqjHiZ0Mfxgx/Cwx12Ld3tULTe0kcbE8BQgF9WlVky/A2ks+2oYndHTfzf2uBqA7JY5i6N9O34EjLZvfPlXEmAPtMLytGNmAoG70aYi/S3Z/r0BtHPGB+1V+t9UkiE8pYMb82ASOHu9ypKrLeA3ytX1ZaQ2C4hC20gGDvewOd6O4gXX1gvk+gQ2f5M7dzuUazhgjcWTTbcAasd8WQuDOgVOpZPoxFXb+VEut+JAmNCDpF7xzheQr3VCuV7HcjMvyW/6hKV28eMKqgnr3zxJLkSji7mOYsOhOaMhc1ggZLZniapyDYbVmkDbFSW250dWMH9j3JCnHucOIuglOZZeq6VZGAvM0FSn/nXtGIu1VrLr0kd7blK6sFWcxFss8g2w2OixD/y5k+HKMLfyq846MSGFXaiyoz1QtXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97acacd-832a-4196-a41c-08dd237b4daa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:57:44.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoWIGeTRdUBBC0RydS8+npviQYEFp8TEzFHeTT++Quu3QURkvPexkrKM5Qd6zQPtvHRGXS6Toa55Fe21ezBzNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230159
X-Proofpoint-GUID: b_E6vMYyD5oze8VWCwirqbCrVEfcvcku
X-Proofpoint-ORIG-GUID: b_E6vMYyD5oze8VWCwirqbCrVEfcvcku

On 12/23/24 11:30 AM, Liam R. Howlett wrote:
> * cel@kernel.org <cel@kernel.org> [241220 10:33]:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> According to getdents(3), the d_off field in each returned directory
>> entry points to the next entry in the directory. The d_off field in
>> the last returned entry in the readdir buffer must contain a valid
>> offset value, but if it points to an actual directory entry, then
>> readdir/getdents can loop.
>>
>> This patch introduces a specific fixed offset value that is placed
>> in the d_off field of the last entry in a directory. Some user space
>> applications assume that the EOD offset value is larger than the
>> offsets of real directory entries, so the largest possible offset
>> value is reserved for this purpose. This new value is never
>> allocated by simple_offset_add().
>>
>> When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
>> value into the d_off field of the last valid entry in the readdir
>> buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
>> offset value so the last entry is updated to point to the EOD marker.
>>
>> When trying to read the entry at the EOD offset, offset_readdir()
>> terminates immediately.
>>
>> It is worth noting that using a Maple tree for directory offset
>> value allocation does not guarantee a 63-bit range of values --
>> on platforms where "long" is a 32-bit type, the directory offset
>> value range is still 0..(2^31 - 1).
> 
> I have a standing request to have 32-bit archs return 64-bit values.  Is
> this another 'nice to have' 64 bit values on 32 bit archs?

It would be nice if the range of values that the mtree API handles were
the same on 32-bit and 64-bit platforms. I think that could reduce the
defect rate in mtree consumers.

But 32-bit is going away over time. I wonder how much such an effort
would pay off in the long run.


>> Fixes: 796432efab1e ("libfs: getdents() should return 0 after reaching EOD")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/libfs.c | 38 ++++++++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 8c9364a0174c..5c56783c03a5 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -245,9 +245,16 @@ const struct inode_operations simple_dir_inode_operations = {
>>   };
>>   EXPORT_SYMBOL(simple_dir_inode_operations);
>>   
>> -/* 0 is '.', 1 is '..', so always start with offset 2 or more */
>> +/* simple_offset_add() allocation range */
>>   enum {
>> -	DIR_OFFSET_MIN	= 2,
>> +	DIR_OFFSET_MIN		= 2,
>> +	DIR_OFFSET_MAX		= LONG_MAX - 1,
>> +};
>> +
>> +/* simple_offset_add() never assigns these to a dentry */
>> +enum {
>> +	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
>> +
>>   };
>>   
>>   static void offset_set(struct dentry *dentry, long offset)
>> @@ -291,7 +298,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>>   		return -EBUSY;
>>   
>>   	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>> -				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
>> +				 DIR_OFFSET_MAX, &octx->next_offset,
>> +				 GFP_KERNEL);
>>   	if (unlikely(ret < 0))
>>   		return ret == -EBUSY ? -ENOSPC : ret;
>>   
>> @@ -447,8 +455,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>>   		return -EINVAL;
>>   	}
>>   
>> -	/* In this case, ->private_data is protected by f_pos_lock */
>> -	file->private_data = NULL;
>>   	return vfs_setpos(file, offset, LONG_MAX);
>>   }
>>   
>> @@ -458,7 +464,7 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>>   	struct dentry *child, *found = NULL;
>>   
>>   	rcu_read_lock();
>> -	child = mas_find(&mas, LONG_MAX);
>> +	child = mas_find(&mas, DIR_OFFSET_MAX);
>>   	if (!child)
>>   		goto out;
>>   	spin_lock(&child->d_lock);
>> @@ -479,7 +485,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>   }
>>   
>> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>   {
>>   	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>   	struct dentry *dentry;
>> @@ -487,7 +493,7 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>   	while (true) {
>>   		dentry = offset_find_next(octx, ctx->pos);
>>   		if (!dentry)
>> -			return ERR_PTR(-ENOENT);
>> +			goto out_eod;
>>   
>>   		if (!offset_dir_emit(ctx, dentry)) {
>>   			dput(dentry);
>> @@ -497,7 +503,10 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>   		ctx->pos = dentry2offset(dentry) + 1;
>>   		dput(dentry);
>>   	}
>> -	return NULL;
>> +	return;
>> +
>> +out_eod:
>> +	ctx->pos = DIR_OFFSET_EOD;
>>   }
>>   
>>   /**
>> @@ -517,6 +526,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>>    *
>>    * On return, @ctx->pos contains an offset that will read the next entry
>>    * in this directory when offset_readdir() is called again with @ctx.
>> + * Caller places this value in the d_off field of the last entry in the
>> + * user's buffer.
>>    *
>>    * Return values:
>>    *   %0 - Complete
>> @@ -529,13 +540,8 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>>   
>>   	if (!dir_emit_dots(file, ctx))
>>   		return 0;
>> -
>> -	/* In this case, ->private_data is protected by f_pos_lock */
>> -	if (ctx->pos == DIR_OFFSET_MIN)
>> -		file->private_data = NULL;
>> -	else if (file->private_data == ERR_PTR(-ENOENT))
>> -		return 0;
>> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>> +	if (ctx->pos != DIR_OFFSET_EOD)
>> +		offset_iterate_dir(d_inode(dir), ctx);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.47.0
>>
>>


-- 
Chuck Lever

