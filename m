Return-Path: <linux-fsdevel+bounces-76744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLAdC6Q0iml5IQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:25:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D3114107
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0A51302A195
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307F41C2E8;
	Mon,  9 Feb 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFQLxnf3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCjc28Zf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895A3A7F59;
	Mon,  9 Feb 2026 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665097; cv=fail; b=ijtYf/DikYVfW/uXNzQcZsn474HH1XbdUz1+UE8+8JwKC61ZyKDuuwhkbulOy/+vzjC8kOYmR2XMdhlaUdoQiUaejhbNEQ0Of0JEvpTVY9BytBW2QMY+lMehVXNN6SAsAWXRJGwaCqrkUb99p4v91GPbxcHmhso5PTAiCI5KfRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665097; c=relaxed/simple;
	bh=66+DIFIKsE+HWmBKI9lLpGgqrv7Zjxx+ICDV3I6EzD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOv92cwMNsvWDaMSJuylAPc6hfv7UkWnuTgYpPOadQPySdHFGbnhyH7ZOD8T81PgjTT0uGewykoJT0201rgucy18G4Yeo9j1CxD5AF/LOTxgS3pN6pWZDsk63IQQtRuuJi8R0VrZoEzA+LWlIVnby2pyBOmxKT2Ki+jmUidSD10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fFQLxnf3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCjc28Zf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECVdF2924595;
	Mon, 9 Feb 2026 19:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kiEeEGAmLp8WlvJFucGKfhn2uW9O1UJtITfntv8U/Ag=; b=
	fFQLxnf36gFA5YY0O3gc0QLHY2LVPYJndM+D2feMdrDTsXxHLccKYePnyLGyR0xg
	zoa/to/KikloitgurmnJSZ/w62yjOhnv07Rj/OQgEhpKGv9FZ0LQ4htfM/WABrC5
	OMbAMu9LildlmbDpo2HhOq+5e34o+jV5De00J+gxHj4372ylg+PV0IkT4zJ+sMa3
	ovBzu5kAbUlV9GQm6Sq2EoZFwNF55LX7BwDptFtNqeBFy45NPiCoxGubBTFH2ZdT
	LRs0SZTughAZmvhbZgHD1oUhthdwC2iql05njKn5wxHTPNx5uTNK90MmwKCtg03O
	k+3UCNuDiN79D5c4aeRq1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xf3tm6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:24:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619IwYCA000423;
	Mon, 9 Feb 2026 19:24:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uudecay-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khR63a9hv7Yd0W/n+640u9bBFVaHvZeXnRNq+l9gO/qEXreZTYr+s0a1kBg4hAfz0fohzpvFmCYzrqqD1IsDaSyZoFTfsTIkMb1GOWVcA/mTtcUT0TK5EZdvAczHi3X7xKThklmkvft5fDns+Kn1Ulr8oQSnQUgovZL36QQxVvA1Fltmv808EvH7erbxRtjipUli/VAoi9PBbbg9AwPUWZOw8n5AD8pfrp5P0ilaJAHKzhQ/TmVDWcKcD+SR9PK6Qjn6xhJdwoEeZJdCfOsTt3oRvi37tUEwUxbR0AUNmSSXxyLJjExZPjBpKPninPGSrjl5GrD5tbI2mSkkIXbFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiEeEGAmLp8WlvJFucGKfhn2uW9O1UJtITfntv8U/Ag=;
 b=XGGnLi02i5N60exfegy+mVPqiKLnw9XFz0Pnx9cmxKTPp8J36fN/d7ZnrxWtgX79NDSYqOyhRME6SnjXvnBOhK68daRfiTjutOgTfTsFS/2484eLGpvQOG0d2N8YaRHaj8O8ko/ReBzhLP1dH08dfGHXqb3PhmdLhR+8XTXyW1nkxRzRJLMB2aQjG+T0ojkZQMHoKEs/3+uxPJZRC/vRWhOkB2G/wIvXL7V32iRLhumv73Zak9Z8tvKZ0YFkzgUzhHNO2Mj1URgpuw5s4BFM+ZoycYw0c4+QufLqVnKsh3uLufDQ702LAjMneGSKfxwRzd9KoX8p0BRUZVha6qlZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiEeEGAmLp8WlvJFucGKfhn2uW9O1UJtITfntv8U/Ag=;
 b=lCjc28ZfBTt7FzH3Xf1wnYtnWzGN1mG+qMLL0msFJti1D29uToGeE30gnkaBihiGQlsIhr23Mz4F5te5TisOt279e55HCVuFmPn4W/Xw/df24t36O32AbHjLm/m+kxqikOpwU3EEtC+7r1RMda8rxvGKHrpUFsbx3bjlJTNRPQ8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA0PR10MB6748.namprd10.prod.outlook.com (2603:10b6:208:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:24:40 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:24:40 +0000
Message-ID: <e66142e7-ae6e-4d4a-b2fd-2507d2948f77@oracle.com>
Date: Mon, 9 Feb 2026 11:24:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260207060940.2234728-1-dai.ngo@oracle.com>
 <ebcb1893-bf03-4637-bf0c-918eb42705bd@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ebcb1893-bf03-4637-bf0c-918eb42705bd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA0PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6388072a-5c6a-4daf-621b-08de6810deed
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YkJ2V1FNSWhVYW9QMGF2YzVLQWl5OHRjRVlWRFJyakNoZnA3UXUySmlaMWx1?=
 =?utf-8?B?ckpTb01BbUpQT1JiblEyRzh1ZDBoSms2TVpESFhkMDNUQTd0V1c1ZVNUQVM2?=
 =?utf-8?B?UjQxVzlYY2xMODlZckNaUVhFdjhBR1E3aml6by9ycXg3dXgyWXJ0U0lSeUtI?=
 =?utf-8?B?L3UyTzRzUGlrNlkyWVdORER2SEw3RUh6SHVRYW92RVJPZkpDeUVPWmZ4Ry9P?=
 =?utf-8?B?bUZlSGR4bSswM3E0bnhPVHd4bllsNWw2NlNwTk0remloaDhEQnBtRDh4V1V2?=
 =?utf-8?B?YW5uMkZhRVc3a29YaTZpeFJjWC81cG13OWtEZXZQNHluL2hGQTZaNzZRbWtx?=
 =?utf-8?B?bklTdnJ6bGc5QzZlSjVyc3piNTJ2MFlIazNpL0x1am5uTS94M3NIcE93MlBu?=
 =?utf-8?B?UTlqN2VqbXVmbzdJb0N6WVNTYi9mSkFhT2I2WnNjeXdEV3huU1AvSXJQUnd0?=
 =?utf-8?B?WjNHbGEyY3pSUG1rVnJIa0JNZzhaYmpvdHNLNHJDSDlJL3I5VU5wS1JlbU0x?=
 =?utf-8?B?ZWphRG5SZGhlQ3RoT3B2ekxxQXNRbEtGL3VFMDJtcDFNYUhKZWo0WWFiVEFS?=
 =?utf-8?B?dXlLWWowU2YzenFLekovYmtENEpMUzVXK050ajRFYUhDSkprU0F6MTk3UkJS?=
 =?utf-8?B?WlFNU0hyVTF6cFgwdzJlUmxBMnBaK3pISnJRNjJteVJjQVdHT3Bzd0pkUm03?=
 =?utf-8?B?QzRWVzNyY0NhbmY5YXp3ay83VTMyaFhhRi8rcDlpemdwN1phNFQ2WnlGYTVN?=
 =?utf-8?B?OW5GcitiSzNZR1hNcWtsOWpVKzM1UWxSN0NXbU54ZWI3MHR4eldHT1VWNjhn?=
 =?utf-8?B?WG1qZ0gxTlkrNFRWTE9Pb2swdTh3NWRGS1gvUjYzNEZDZUhHYy9yWTQ4alo1?=
 =?utf-8?B?TW5idG9BMzY1dTQrVXRtUUpWa3A1cFErdVdJcXA4ZUlQUVhzVTgvVXk3SXdL?=
 =?utf-8?B?b0xUeXRCa3JGSlkwVWNta25kcFIxTlk1QTh3T21aSlRaenBCVkhrTnh6R1lp?=
 =?utf-8?B?V0RaRk5xQlRlMTR2MG5hM3hFenFhU0g3SERXWXlyZlgxYUhMYk5wM05KSmRa?=
 =?utf-8?B?YkhmNkJzNmhYelVVdDBWalFHcGx3bHdOVkx1dDRFWHhLRDZWUDQrcCtnQU1r?=
 =?utf-8?B?Y2xHV1plNy9obWNMOFNPSTdSU3ZDWUJsN3V5d0oyYTFMb1YzUUxGY3pwMnlO?=
 =?utf-8?B?OEdWTU5vNm02eEFXMDhhTElEdEtVS1pGclFlQzgvT21ZOWpJbmJwUHdsbkNN?=
 =?utf-8?B?Y2paUkdTQ1FMNnNQMi8zL1hSekJHTTRQV2hNRjVtaDVPQVZIY1JZdVQwa0NN?=
 =?utf-8?B?eTQzQUZVNkNwR2xCWVNYd21FU2t2b1NoNGhmMkdPT3IrWUV0QWl1SHdJTmFD?=
 =?utf-8?B?WVlnL2hhZi8zUUI2NEgrN1VySzJVanlUUUhrVHI5YnJqWHFQZXkxNUc3Yk94?=
 =?utf-8?B?bEF3S2l5UHJqMXZnSlk5Y3J3OG1ITEkzbit3RTluL2diWnJZWjU2V1hvL0x2?=
 =?utf-8?B?UmJubEVUenNORURudFJEQjYxZ0pwMzRLU0tKR0RBZnRwVmZ6bjF2SHBncUVp?=
 =?utf-8?B?am1ndHZwNHRrU0U4cWs4UFZDVVBhZEcvdkVaRzhWMEEwYld1aGt4bEZnbk5R?=
 =?utf-8?B?a2Z2QkNPYVgwd2pWb0RZV3I1SlVYZjlXNmM0NkNOMTEvbEoxaFRmRXoyaDc1?=
 =?utf-8?B?aVNMZEUraHN0N2Y1bm1sMGlrZnd6RHpWVE9JSy85eGdxKzRkekozaUpUWVM4?=
 =?utf-8?B?MTBBQlpuZDJrT0JXOStlMmJ6eGoreS9QaGowTkcxSmZ0c0FleU9xb1NzeUpl?=
 =?utf-8?B?Y014V2FPRm9OMEZmV2tmYXJ3Q0ZCNzdxNHpjdTBhbVBWczdUM3hTL3ZBYlB3?=
 =?utf-8?B?Zy85UUVZcGc1M2JZZllJVTBzVDcreENtK09ZZXg4S2t1c3hWRDVySTB6WWJt?=
 =?utf-8?B?VmtRQXQ4SjQzdTBVVjJHenZTeDBIYXF0bkNvUG04MWJzR1NXRGNtcUNYUXY0?=
 =?utf-8?B?c0gyK2RPd3FSa3dvTENkcEZSNTRYUUJCeWRBdWwzSDRYYnJrN0Z5RTczMUkw?=
 =?utf-8?B?RStLNTlpOTRXY2IzNnVqZlFEN1hLNVUwSjY2bXc2Vk5IdDdzVlNTQUpodG83?=
 =?utf-8?B?a09wL0dKT0dSSlZRcFNzTFZld0ovN3NVd21MTjRtWUljdU8zZG90RDN6SU54?=
 =?utf-8?B?N2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dGJsOFhhekNPTVVvRUZyMU13d3dISnJtbzRncURBcVdhcm51TXpjWFFqQlVT?=
 =?utf-8?B?dld6RSt0Z053UGI4V3Z1YUlIWW9Wa1JqdFdnRHV0MUxjb2xqNThYdlVXbXBo?=
 =?utf-8?B?VEVKLzlocFZiUmw5a2FOOEpXSGVXMzExUHdwNFpCRFlJbEhWeW9MVk0zOXpS?=
 =?utf-8?B?dUZHTXJyR2UrN2M0Vmxmd0NnMFlMK051dGZNc2MzQlF2U3dzaUVhR2IvZDA4?=
 =?utf-8?B?K1N1TGdLem5OM0FqOHBjMmhvUnhmZVlsV2ZEdG9tYzlkN05wUW1kMWNTTnJs?=
 =?utf-8?B?TVN4T2FUZzh1OEo3RlJhQ2NEbk4rcWdHVElOQTBzczlzVmRtMmdJeHZORkht?=
 =?utf-8?B?V2RPQmJZUE56VE4yd0xYcUoxVDNjZkdDcjNKbklZQ1E2RmIxMzlLaHVKWEs5?=
 =?utf-8?B?dHlmQms1Q0V3U09wN2JTMCtVcXQvcXZseTRKSGd2UGN2NUVON3RwZjRtVWdp?=
 =?utf-8?B?UXY0aUxSMXlwaTdyNVBEODl2YVJxRmZIajVzZnNPZGV2UVB5NFNkeTVlNnJr?=
 =?utf-8?B?SFdCUFBEVkJTRnh5bW4wbWRTb0l6NzB3SGJiMDVrN2tpbGxHM1pERjZNSVJP?=
 =?utf-8?B?TTZwYnFZd0dTMHMreFlFTml2M1g4dUFZWHNTeEMreUZBR2FFUkprMkphKzNS?=
 =?utf-8?B?MnVYSFlkZEF2NmZ0K01YbU5PdkZLdUxnTzB5VFYybWFDSDdMMnY4NTl3M2ti?=
 =?utf-8?B?cFhaSXo3bGdQeUJQN1YrOWFMT1U0aDJlUjkzL3V0SUZ4aFpUV2hLTkVNZHRH?=
 =?utf-8?B?c28yR3RXSUdNOVNJVmNPK2djcUpKWmczdVFRMloxUWtLSGNoUGZFbXg1NHdD?=
 =?utf-8?B?dGVoZERCVTF5MHVLdTZaOXMxQW1sVDRmZ2tMdks0bk9QVHJSREZoc2FiSmFH?=
 =?utf-8?B?NUFWQlNndVc1VERTdWFFQ1VNWDVxd3A0clVCNnIySVZ4eitseC9WbSt0WkM5?=
 =?utf-8?B?L2FlZWZXL1pRaW1pSE41MGw4RllvOXVsaVpld0duSjRmSFJXazJ5Rm13bE40?=
 =?utf-8?B?bXM4UEY3NWJrN01hcndFSFVvZG5TNjBNSnRYbHdEZTBOYkNQODFlcHNvak9p?=
 =?utf-8?B?K2piMU9YeStveUV4d2NFaE9oOHVrV1BFdldDMFdFOUFiSERzSko2amRaOFla?=
 =?utf-8?B?TklLVEhvMkRESHJVeG5kaTgzR2lWYVovbDZ4UFZmejVJbjRzSUZTTEtQaUEy?=
 =?utf-8?B?V2F5SEw4M3M0ZnhmZWM4ZGUwRVdwNmt4L3BKaG5yUFNFMGwyY3NNMkhCdWEx?=
 =?utf-8?B?cy8vU1loQy84ODY0VHY5aS9vV3p2cGdWS25uT2JmcktENDdGMHJvekEyOGZn?=
 =?utf-8?B?ME51eWN2WWFaSHRKUFlicUhDNUMxWTl4bWoyWE9BWTI0dHFoLzNqaXNPV1E5?=
 =?utf-8?B?b3N2ODA3QlI2aE1kWUM3a3ZhenVoUThEbFl0U3NNcXdCU3JXK1lvNnAwUS9S?=
 =?utf-8?B?M1ZYMWxaZEpmd0RXN1RiS1BnVzRaTDlxWVpFdFcrSVpMa2FTdlBZT2dLZ09J?=
 =?utf-8?B?YU1VY3pob2dRcFcwazNPVjgrY3JMZHJnTW9kS3ZvaWNnY29vV3RobE5Vb3Vz?=
 =?utf-8?B?eU4wZkxaZHRQQW9YamRPVUpRUFZDR09ON0VMamx2MGFLd1h6MllMNmdDUVNE?=
 =?utf-8?B?OGdFZTRBK1hlaGE5L0V0MzJXZTYrbUZmQ3VFZzNXVkRKbWRFSjhQbWZPcHZn?=
 =?utf-8?B?bFlxYXhWRkNWZmxkZkc4Z2UwbSt6M01iMkY5cEg4T2E4Q3QvbmtQSis1bURV?=
 =?utf-8?B?elBmb0gwQXNWUE43UHhxV3JpRWE5WmhLSmc4SmFzQ2tnRDFWYjlTeWF1WWVw?=
 =?utf-8?B?TmlRZy9pOTJrTVpEUHZsQ1Q1dFAzK20zbGh5dE9sbklDVTI5Qkc4ZE5nU1Qx?=
 =?utf-8?B?TVArL1dENTBlT0hIUWpadnZ3Y3R3YWloR2hTa2pUT2JkdzJRTytGVWsrbFdm?=
 =?utf-8?B?ZmZxcmk0TE5DSGRDWUsyRGwyd3RHK1lZaVhUcGRnTStrclFnK2V4UCs0QTRT?=
 =?utf-8?B?bHdHcXpid1VzQ3ZKaGN1ME9IenpjMU9PZDBoN1FxNHBUQWhwcmhBYnNITkRz?=
 =?utf-8?B?REVZU08xZ2t1WjIrSjVadTE4R3lsdXZjU1Nkc1dXakUwRWZQR1ExRmZMWElL?=
 =?utf-8?B?MUJwKy9yKzZzdUdKM0U3WUx4N1V1ZzlrZ3k5aDVEVmxlTXg4ajJiT0JEczFR?=
 =?utf-8?B?S2hLTzVOeWZzN21CSVVMbk9VMDJTMmVIOW1UcjZVVDJlMVoyM2NsbEZqNUNQ?=
 =?utf-8?B?bk1Nc01Gb0xQR3U3SmNiWW5wN1RralBOemdlU2w4Ry9HenB1S0hpU2NUVFl5?=
 =?utf-8?B?aWk0Yk53d2VYS1R0d1JMYWZQcGFzUmRkdkU2Lzd2Tkp2Q2xESnRsZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQLBbsSP3pW7yXjKHnzIFmJCJVhd6lYLRvkQqWu/C/5XMXVCSjls91OyDPSDUmJY7/sMnduJOp9qnbo1QTUXQG+Uiph3DjQkIM36OKL9rQIqpPacPG7vwTgLQwMwYJeLBiCn1CC2uLtVyOGUKTePZc8Bi7PooYG9Bl94Vb7fn5CsMRvBp6daUIZ9WST6uvMhkFW4/PiH3cprD3GgoJFqPDJVY8TDPuPChqFaIk/+YKNgeUMZJLPkT9aeGfIgzx6q3SHm6uh4WcLLEz3hNz2D6zc3HbtdYLSkBlEUtGpjWnO5+x0q10sXxg/yiW0E6IkO+9QE0xj2gt9m1OBEcj3Zm6qqB3SBIm0M7qIWR2VpEB9z5L1vT2ffj5L/mfcivzBloAo+HIin6JmjbqUYOWSGcziYAtmQCTNhZy5Dc6yNEQmNbmzQZXX2dzBCxs1U99324GUhQScHjKasdK27/yhIQA7jM8PJSyLH3zrdseZFS93BuQT0QTLqfy1hb2Qhxw9tv2jK7/VpU/2zjJnFfnyAEzwIOG1DSfimuYjY5XdLmcPz2YpDxYWvu2CiA8iXn44rE4dig/KO4ZRRS/ZFt1X597edvX2sq0gBB0XNGavpPS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6388072a-5c6a-4daf-621b-08de6810deed
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:24:40.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+8CjoclRhpAanOcLqN7f8Kqn2pntLdaaHudrgqtzZoR0SKh6YqXILfroj0msSKAV1AGwT1LXWV0aR5G3E12/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NCBTYWx0ZWRfX4wc2/ih8rMpF
 34LVMDWrClLmCPIhixhe+15Xq70W3x2OZRP02PMgYzOeGrhwA/K/SjThblQGMQfEwfrC7eqvrQP
 kIf5ivqf9538j+FPOWOOPzdfgNvxpJ9JkaywgtDDVFNCajHcz/Nv68VvpQ3kDnFmanRVVaN1m3p
 hjuZdgchTLrQE15fCe89ArZ/eGDiFbDqDrZi5nO/PolD9Nw916P+5FHCwmT8mwvjnaGLfkpYyFM
 Bz5/+5+bjMPCq/620di7d2RHY3MP/KzWYKNLARfNgd7HiqoiGxhenMy6QzZ54pmfoY4UpPWaoAX
 2ijZgtC1Vrq4f4s7T38ouufK3Y6Kvk8N4FgyNfEfAHfXwrkpFDWvZUjo8yb9+paz98gYrBIN8Lp
 tFQIV36ml6XX183OssJBze5Rrh2OEFAi9X8nLupaEasyyU9fzkLyjJq3RDgV2l6GVclujQ5s4Vm
 iAIV59jn0SwjCvTAUoIbTIt52T7kmhcYW0RoDz7U=
X-Proofpoint-GUID: Ize4xjVqyF9bVHlHvJQlZWB7EF0FE35W
X-Proofpoint-ORIG-GUID: Ize4xjVqyF9bVHlHvJQlZWB7EF0FE35W
X-Authority-Analysis: v=2.4 cv=KLNXzVFo c=1 sm=1 tr=0 ts=698a347d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=rdcvCkuLAcx9wSbAoSYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76744-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CF6D3114107
X-Rspamd-Action: no action


On 2/7/26 10:00 AM, Chuck Lever wrote:
>
> On Sat, Feb 7, 2026, at 1:09 AM, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |   2 +
>>   fs/locks.c                            |  15 ++-
>>   fs/nfsd/blocklayout.c                 |  41 ++++++--
>>   fs/nfsd/nfs4layouts.c                 | 137 +++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c                   |   1 +
>>   fs/nfsd/pnfs.h                        |   2 +-
>>   fs/nfsd/state.h                       |   6 ++
>>   include/linux/filelock.h              |   1 +
>>   8 files changed, 191 insertions(+), 14 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>> v5:
>>      . take reference count on layout stateid before starting
>>        fence worker.
>>      . restore comments in nfsd4_scsi_fence_client and the
>>        code that check for specific errors.
>>      . cancel fence worker before freeing layout stateid.
>>      . increase fence retry from 5 to 20.
>>
>> NOTE:
>>      I experimented with having the fence worker handle lease
>>      disposal after fencing the client. However, this requires
>>      the lease code to export the lease_dispose_list function,
>>      and for the fence worker to acquire the flc_lock in order
>>      to perform the disposal. This approach adds unnecessary
>>      complexity and reduces code clarity, as it exposes internal
>>      lease code details to the nfsd worker, which should not
>>      be the case.
>>
>>      Instead, the lm_breaker_timedout operation should simply
>>      notify the lease code about how to handle a lease that
>>      times out during a lease break, rather than directly
>>      manipulating the lease list.
>> v6:
>>     . unlock the lease as soon as the fencing is done, so that
>>       tasks waiting on it can proceed.
>>
>> v7:
>>     . Change to retry fencing on error forever by default.
>>     . add module parameter option to allow the admim to specify
>>       the maximun number of retries before giving up.
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..79bee9ae8bc3 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        bool (*lm_breaker_timedout)(struct file_lease *);
>>
>>   locking rules:
>>
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..0e77423cf000 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove = true;
> The "remove" variable is initialized before the loop but is never
> reset to true at the start of each iteration. If a lease's
> lm_breaker_timedout callback returns false, "remove" stays false
> for all subsequent leases in the list.
>
> A later lease that has timed out but has no lm_breaker_timedout
> callback (or a NULL fl_lmops) would skip the conditional assignment
> and inherit the stale false value, preventing lease_modify() from
> disposing of it.
>
> Should "remove" be reset to true inside the loop body before the
> fl_break_time check?

Yes, it should be initialized inside the loop. Fix in v8.

>
>
>>   	lockdep_assert_held(&ctx->flc_lock);
>>
>> @@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			/*
>> +			 * Consult the lease manager when a lease break times
>> +			 * out to determine whether the lease should be disposed
>> +			 * of.
>> +			 */
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
> I'm still not enthusiastic about holding flc_lock while calling
> another module. Especially since holding that lock does not
> appear to be documented in an API contract...

It's documented in Documentation/filesystems/locking.rst

>
>
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..b7030c91964c 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>> struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>
>> -static void
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + *
>> + * The cl_fence_mutex ensures that the fence operation has been fully
>> + * completed, rather than just in progress, when returning from this
>> + * function.
>> + *
>> + * Return true if client was fenced otherwise return false.
>> + */
>> +static bool
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	bool ret;
>>
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> -		return;
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		return true;
>> +	}
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>> NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>   	 * retry loop.
>>   	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	switch (status) {
>> +	case 0:
>> +	case PR_STS_IOERR:
>> +	case PR_STS_RESERVATION_CONFLICT:
>> +		ret = true;
>> +		break;
>> +	default:
>> +		/* retry-able and other errors */
>> +		ret = false;
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +		break;
>> +	}
>> +	mutex_unlock(&clp->cl_fence_mutex);
>>
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>> +	return ret;
>>   }
>>
>>   const struct nfsd4_layout_ops scsi_layout_ops = {
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..c02b3219ebeb 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -27,6 +27,25 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>>   static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops;
>>
>> +/*
>> + * By default, if the server fails to fence a client, it retries the fencing
>> + * operation indefinitely to prevent data corruption. The admin needs to take
>> + * the following actions to restore access to the file for other clients:
>> + *
>> + *    . shutdown or power off the client being fenced.
>> + *    . manually expire the client to release all its state on the server;
>> + *      echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
> Has there been any testing that shows expiring that client actually
> breaks the fence retry loop below?

nfsd4_revoke_states calls nfsd4_close_layout to remove all file leases.
I manually tested it.

>
>
>> + *
>> + * The admim can control this behavior by setting nfsd4_fence_max_retries
>> + * to specify the maximum number of retries. If the maximum is reached, the
>> + * server gives up and removes the conflicting lease, allowing other clients
>> + * to access the file.
>> + */
>> +static int nfsd4_fence_max_retries = 0;		/* default is retry forever */
>> +module_param(nfsd4_fence_max_retries, int, 0644);
>> +MODULE_PARM_DESC(nfsd4_fence_max_retries,
>> +	"Maximum retries for fencing operation, 0 is for retry forever.");
>> +
> max_retries is a signed integer. What would a negative max retries value
> mean?
>
> I haven't seen a clear use case stated for an admin needing to set this
> value. The documenting comment just says "The admin /can/ control this
> behavior" (emphasis mine) but does not state /why/ she might need to do
> that. The documenting comment does not underscore that limiting the
> number of retries -- setting this value -- is a data corruption risk.
>
> I'd rather not add this setting unless there is an actual real world
> purpose in front of us.

Ok, I'll remove this knob in v8.

>
>
>>   const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
>>   #ifdef CONFIG_NFSD_FLEXFILELAYOUT
>>   	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
>> @@ -177,6 +196,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>>
>>   	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
>>
>> +	spin_lock(&ls->ls_lock);
>> +	if (ls->ls_fence_in_progress) {
>> +		spin_unlock(&ls->ls_lock);
>> +		cancel_delayed_work_sync(&ls->ls_fence_work);
>> +	} else
>> +		spin_unlock(&ls->ls_lock);
>> +
>>   	spin_lock(&clp->cl_lock);
>>   	list_del_init(&ls->ls_perclnt);
>>   	spin_unlock(&clp->cl_lock);
>> @@ -271,6 +297,9 @@ nfsd4_alloc_layout_stateid(struct
>> nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>
>> +	ls->ls_fence_in_progress = false;
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_retries = 0;
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -747,11 +776,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +809,112 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	struct nfsd_file *nf;
>> +	struct block_device *bdev;
>> +	LIST_HEAD(dispose);
>> +
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +dispose:
>> +		/* unlock the lease so that tasks waiting on it can proceed */
>> +		nfsd4_close_layout(ls);
> nfsd4_close_layout() acquires fi_lock and calls kernel_setlease().
> If lease code acquires locks that the fence worker holds, can a
> deadlock occur in workqueue context?

nfsd4_close_layout() releases the fi_lock before calling kernel_setlease().

>
>
>> +
>> +		ls->ls_fenced = true;
>> +		ls->ls_fence_in_progress = false;
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		goto dispose;
>> +
>> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
>> +		/* fenced ok */
>> +		nfsd_file_put(nf);
>> +		goto dispose;
>> +	}
>> +	/* fence failed */
>> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	nfsd_file_put(nf);
>> +
>> +	pr_warn("%s: FENCE failed client[%pISpc] device[0x%x]\n",
>> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client,
>> +		bdev->bd_dev);
> The %pISpc format expects a struct sockaddr pointer.
> ls->ls_stid.sc_client is a struct nfs4_client pointer, so
> &ls->ls_stid.sc_client yields the address of the pointer field
> itself (a struct nfs4_client **), not a socket address.
>
> Compare with client_info_show() in nfs4state.c which uses the
> correct form:
>
>      (struct sockaddr *)&clp->cl_addr
>
> Should this be (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr?

Yes, fix in v8.

>
>
>> +	if (nfsd4_fence_max_retries &&
>> +			ls->ls_fence_retries++ >= nfsd4_fence_max_retries)
>> +		goto dispose;
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 1);
> "1" -- is that 1 jiffy? Could this use an exponential back-off
> instead?

Fix in v8.

>
>
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + *
> Nit: Remove the blank comment line here, please.

Fix in v8.

>
>
>> + * @fl: file to check
>> + *
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * This function runs under the protection of the spin_lock flc_lock.
>> + * At this time, the file_lease associated with the layout stateid is
>> + * on the flc_list. A reference count is incremented on the layout
>> + * stateid to prevent it from being freed while the fence orker is
> Nit: ^ orker^ worker

Fix in v8.

Thanks,
-Dai

>
>
>> + * executing. Once the fence worker finishes its operation, it releases
>> + * this reference.
>> + *
>> + * The fence worker continues to run until either the client has been
>> + * fenced or the layout becomes invalid. The layout can become invalid
>> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
>> + * has completed.
>> + *
>> + * Return true if the file_lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +
>> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
>> +			ls->ls_fenced)
>> +		return true;
>> +	if (ls->ls_fence_in_progress)
>> +		return false;
>> +
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +
>> +	/*
>> +	 * Make sure layout has not been returned yet before
>> +	 * taking a reference count on the layout stateid.
>> +	 */
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		return true;
>> +	}
>> +	refcount_inc(&ls->ls_stid.sc_count);
>> +	ls->ls_fence_in_progress = true;
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 98da72fc6067..bad91d1bfef3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
>> index db9af780438b..3a2f9e240e85 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>>   			struct svc_rqst *rqstp,
>>   			struct nfsd4_layoutcommit *lcp);
>>
>> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
>> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>>   			     struct nfsd_file *file);
>>   };
>>
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..be85c9fd6a68 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>
>> @@ -738,6 +739,11 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +
>> +	struct delayed_work		ls_fence_work;
>> +	int				ls_fence_retries;
>> +	bool				ls_fence_in_progress;
>> +	bool				ls_fenced;
>>   };
>>
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>
>>   struct lock_manager {
>> -- 
>> 2.47.3

