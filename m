Return-Path: <linux-fsdevel+bounces-67459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FBC40F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4174E4BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598F3346BE;
	Fri,  7 Nov 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msPcWoEV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lUJYsEHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDF1E51D;
	Fri,  7 Nov 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534727; cv=fail; b=V7HX2jmGYNyyHE/pCKLf/ss3IoRG7J4VgwLOseb+B6caMZGvjRzVy8cOBKQBIaF2RPVa8TncJb9JHcv8Tal+uiP12Ojyz0PuFsR6VDtTyFFWs1OhmL6zN9inK4TjUbLd4GfCI3ogiUnuo+EF8q16Wlz4pME9f+wBdeBdnIkhcjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534727; c=relaxed/simple;
	bh=NAR6pQndhR/KTGhDJjHMkNJakycgrZnT0jfWTtAvxuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zspkt8xxcw1jzUhBgEgvGln0o0RtHAnwLthBucss2JotEO5nXpRwDrj4YD0jC92c49zoEbxjsuKTYrwgzOVZ0tXe2w946L5jlK1ONdERGl+MOm5GNBsfdeep9IUUpVck2+SW4jH4K5nUjBLpYlPRhhYhH5aRpEMHITWfujC30p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msPcWoEV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lUJYsEHD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7GEYaT012197;
	Fri, 7 Nov 2025 16:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FKBHpsmMGwKsgvq8izyI2FEfLrLyymT8i69JvY9OHVs=; b=
	msPcWoEVADVUGRZq/V1beEXvP9TPCGyp98KgIqjKTax01W06QXGgZoSHUV80HWhk
	7mDCrKUKV1d/0qBJrsiZ02HGGUN0ycA81Iz+4XXTgd22azx5qLdghmZm8cwvn2ph
	Y1pVktjWjR+QgJ+JKwUtYcTit/MMhZ6oN63OXZI1+oEY2+00k/8WRy5Ep+2C37rp
	eVyNIZn0F7Div1d/UzotAggGs+4iqhKob/Zv4qXz6X6AW+VHeoiABMVZacAByKa/
	2LCh0zcHc/4yw1pXg9kceFSTqn20PqNCan3PSuqj0YuOe27k9wceWwUqAmFqAMl9
	gSRT2JHAospwo2jPJr9TFA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9m44r3nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:58:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FITlU002646;
	Fri, 7 Nov 2025 16:58:29 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhkymf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj4rfH4RcrsGc4RtTjykprw6/j/K9CCeP1vMMwT23r0pLxVfhWluN/MP6axOeBY73a13Zy6RmoVjWew26S6MlD9muOpo40+W80pemCWoqhNdd3x7X6CdAb85s7LGT4CvdhvxytsiP3yLQajl9TwiyQGF9L1HrDKXEUdAYGj52IKU9gK9GnIcbMnM8GGv/Xt1Qj9fqNAKBou1U0SLI74KVsVemCEyxAZ2zi3M/3sIb/LuppH2VdRfB7D3MEJ8wlRpGVLKN8t+i4b7JTSClXILQtQVpWZrOIt8bJmDDFJxPy53CxzL7zKwRV+ZBFRrgeIAClR60BzkkOE5fYdF14xnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKBHpsmMGwKsgvq8izyI2FEfLrLyymT8i69JvY9OHVs=;
 b=Bj+oiiE1lt5r5gCTRZRsMi455jdoh6q3vqLmGBF9VzviSRE1vGEUA90ijubAFQbHWlRa/OQhzTUbOSXSxw7+gqy2YXp+/oA6psvq4ve7cAQNm0DRV8htA800DEl9BxDp60HiJJM3pXWyyLhmLAt0rXLwP07zVDtmrg8TNxTtaH/GJbfBXROd2zTLBR1y2XUQb8yPMJhq02mvfivwSeICGEg50y0zq4Nohc5zObJkfUQOasLicyDEZdARA1xp5xPNi0cf6MJKABUlNMRZ6vmbO6K/d4AydW3EHCfIf323FnW5fLzYJVQn2tJGsxy6tTCkYh6KZMeDQzxPBhkf+PGe8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKBHpsmMGwKsgvq8izyI2FEfLrLyymT8i69JvY9OHVs=;
 b=lUJYsEHDD+nq6mVk7PBrIAo/nz4FJNa8ichQObaSEs5PU4ba4C+xb8p5+UmNMPokrVOALBOJxbz5t1PLj2W24rjQLp08l1Am/w9wjgnWpRwdY/cS/c+2vIWYAzy8VlcWPXFcjUTe2Y8TkuUHrkNtikNS2TQGvMwGn5+iaOM5tXI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8321.namprd10.prod.outlook.com (2603:10b6:208:575::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:58:16 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:58:15 +0000
Message-ID: <ae2f49ca-db9b-464d-b337-60302e800628@oracle.com>
Date: Fri, 7 Nov 2025 08:58:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to
 lease_manager_operations
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <20251106170729.310683-2-dai.ngo@oracle.com> <20251107132620.GA4796@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251107132620.GA4796@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::30) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 49138929-15c7-46ba-ebbe-08de1e1ed806
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cElWakpZUnV2cytiNmJTM0ZmNVBpM1F1OWNmYTAzbEJ6anlxMm9hdzhSeGhi?=
 =?utf-8?B?Q2dySXBwL003VTBaSVQ1cVpxUml1Ri9HSFJodXBadStJTEd2bDlmdkFZVkRx?=
 =?utf-8?B?UUhPdXhCNWFpY05mNjJRdVZHYThQYy82UWMvSlJ2M0I2QXI1ekxnTXZ1WDNz?=
 =?utf-8?B?cEpacDQvMHFlRjVaa1l0UlpOMlJWaE1DWEJOSUI3RUNwOWhnOWFiaDJSZUM2?=
 =?utf-8?B?VWJSN2F0WjlZOWdvVWE0VG5NOU0wLzNpUXFmdXhkenJ0UHZnVjdVVndEN3Br?=
 =?utf-8?B?VW9jeXgvejdZOFFZT0hiS3FMZEpkZ0VRcFNJSzcwMy83ck9PbnorNGUrbDcw?=
 =?utf-8?B?UXJsQmJ0cEtsYjBycWRhOWJOQVdkdHprNE9VZnBSVUZPRkFjUklPbnV5cWFp?=
 =?utf-8?B?UjRCbzBqK25nTUJqUUoxRFJKc0RlZUJYNWZFMGNiWTJCUWRjZldmTjlNK0JI?=
 =?utf-8?B?V2dnL2FwL3lpTnM3amltb0FwcTJzKzdkdlRqUmFkbXFVSmNzeXRYVlpPVWlt?=
 =?utf-8?B?QmlaWVF3eVNFamh1eUJmS045TFhoN2xjRERqSlhCR1dIWXdoZytpazVSalJI?=
 =?utf-8?B?UHpacnB6dHBHSG9XMEdpQ2dzcGtiVmM1WGxxNitLaW03cy9xZC9MS3llNTdr?=
 =?utf-8?B?eFRtMS9YeWQ3cys3UWx1NE1LRTNVUlBDTW1JZGpIcFdxTE1qZFpKNFBuajZL?=
 =?utf-8?B?S1hUbnlROTZRa3REVkNnTTlvMGVaWVhQSmZONExFUTdVWnM4VXdCeWhQWXVl?=
 =?utf-8?B?QlhRTGJ4SjZkcU01eWsrVHRxSnVJZlRhdTN3cTgrb0ZtNXU5NHBJZnVlb0U1?=
 =?utf-8?B?M2JXT003R1Y2UHlNUU90Z0h6YTgvVElqV2lpNjB4c0RwR2N1TzN3YUpQWlRU?=
 =?utf-8?B?SG5sVWdIeXZyRHlubUZadStOaFY4alNFRzd3QWVEaFh1VHdXLzlrUUc2NVRj?=
 =?utf-8?B?VXIxMjhLV0o2SU1VdklsdDh6VjFLYVRMR0dPWVZWbkJsY0d2WVFwYlNGWlNY?=
 =?utf-8?B?L0l2L3lONFVxNzVOaTI3d1d1OFkwRHFvWWJYa3FsNUtMSXplK1pQQVFhNGJj?=
 =?utf-8?B?TjhzL002eENUZWtTQ1NqOVMxcGxsaER2RFRRKy9ZbzJTUy9zM1J1aytaR2tZ?=
 =?utf-8?B?a0ZDeUtsS01mcU05aU9QZGwvWlF4cWthckZ4Rzl3WktGMSt4TTUyWXIwWGFv?=
 =?utf-8?B?Sm5zaDJtcFQ3RUh4cWRnS3BTQS9tblV4U0xvYkpTSW9qOUVweHRqTThiZjln?=
 =?utf-8?B?K1pka3c3dnVCVnVPWHdLa24rT2Y2b2JJa1ZmWWVUemE5amMyL3lEOXRXVzF5?=
 =?utf-8?B?RG5sc3A5eS9halVtdk9wb1VJZnNzbFRsMG9mWVlzTTVtVVhKTWZUOEc2NS9y?=
 =?utf-8?B?VlVWZEJCNjVuM0pzMEc3MURsUHFjRExhTFBOSlEwb2hiZXhDK2NUOW5kZG9R?=
 =?utf-8?B?UlRzdjNGK29vYWN3WGpZNEtrWlY5TW5SVi8rSnBFc2FvMmdTeVhScHlyOUtZ?=
 =?utf-8?B?Tk1qZElQVHhRRGcxWjdvemErUStrS3FlMGlDS2RLams0MS8xS2tuRUNxOVI1?=
 =?utf-8?B?ZDNjN2k3RE9USnNORG9mU2U1T21NL3cyWGcrS0p5ZUNYMFYrUlNjUHF6TWQw?=
 =?utf-8?B?QmtqMEw5MTZLajRUeXZhek1KU0NPeHVqbEVoWFNrTTZpd1J0WlBITlQ4YTB6?=
 =?utf-8?B?OENLaDJpa1A2dlJPU3lwdmZreTVaakpCUGpNRUFldXBsczdTNmF5ZXVjVHRj?=
 =?utf-8?B?cjA4YzNqcThzQytTR0g3T3JweXRocGZSN0xhdVdXcWE2UkRDMG5pcmJHRjU5?=
 =?utf-8?B?T2pLRmwzcHRrbHhyaUVjc2JIQmd3cGpiRUEyN3BnODBNR0tzV1hXQ0FDS1hz?=
 =?utf-8?B?aWtpQklhZ0ZDV2FGaWY1QllYdGZQbGFYRmNVd1ZKZ1lNY293OUZSZTdYRmRV?=
 =?utf-8?Q?jwP1APl45JfnxDd2xtYqMlBxeF1z0AAI?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QU0yTjhrMGFkMGhMcnNqRXIwZi91OTdoSWNEamluRzJSVXNqNVYvQ1hXNHNR?=
 =?utf-8?B?MGtUb1Bsa3NBUTlFRGVCMUJOSktzNWF0K2FMR3NubHFncjNZWEhBalV4WE9J?=
 =?utf-8?B?blN3a3VHMHdlQXljZUhpN2YwZ2VzUHlNYXpYOS9YQUhoVlVkV0RZZ0kzdFF5?=
 =?utf-8?B?MDRuUHQvNUM0REFMajFqUTdvTG5zS0xGWENDaXhxN2pEbU83Skc1d3NFblBu?=
 =?utf-8?B?Q2VpclVkdE1odDNKWDEzUEsxWEN1ci95cjVzclhYUnRoTkVWQXFCMFExZFA5?=
 =?utf-8?B?WjVML1Q1TXRmQlp0bWxmR1BNK3NYS043UkI5SHJCQ3lxV0ZRTGlWUFRoM0F5?=
 =?utf-8?B?UE9nTFNHZjBuSklNMVhVdHhaVnJUTlRTa1Q1NXVwZDluMDJxVCtzbnMvVzcz?=
 =?utf-8?B?NC9GQ3p5OTcwNDhJRW81c3BlNkFObWFCMlJ3MHNZK2ZKUlZ0T1EwZThFNHA0?=
 =?utf-8?B?UTFEclRjeUpRemZEVm5FaURvUzVRVE1VU0M4UjN4eWt1Y3VXMjRFMVRrY29o?=
 =?utf-8?B?UFAvbzdkbVVIeGVtWEJPSlh0U0RPOG9iL1JqYWs4RzNlcWx1RDdvNmxBbk94?=
 =?utf-8?B?UGxpWDR3cjZqSTFxWmNzSFlLZGpzMFpFUGFDemxXNmhFTGZabDVWbG44WGFq?=
 =?utf-8?B?d3FTbUtwY2VRRGNhVjVDTDEzNlZBUUswcC9qWW93SG5UeWljQVAzTHRnZ1Rp?=
 =?utf-8?B?aHluOXFuTkVaaENxQWs5VTM4ZXhLUzFCTXBQekdtaytrQklIUG5kNmRIODg2?=
 =?utf-8?B?L2Jac2N0dnFCT1hwOWlSbmN6OFdlenNscTRyL0dvdVFHWDl2eDFzZjM4SXp1?=
 =?utf-8?B?Myt4M1ZONHlRYVRoN25CNk5pVVgyd0hSSVlJSTlOanBnWnRmYW9aRUlMNWVa?=
 =?utf-8?B?OUZNSFg3TVVQd3hiMm5pRDBYNlhYUjFhWHlZK204bmM3V3dpRSt6eXd6bXFv?=
 =?utf-8?B?QzMzMXlwK1BOYzZRTEl3S3puTkVOVUNrMDJvdndtZkxUdENtWHJQbHdKUTRx?=
 =?utf-8?B?SzFoeG8wcU14M0dkZmZIS25sQk5KWmlIMW8rd050VWJEdDVsVUt2M2FqQ3pL?=
 =?utf-8?B?bmJ0dFhFYkFDWjhPRWs2MFYwb1I5REdGaFl3dDNMdENiYWJ5SUNXSjV6T1hH?=
 =?utf-8?B?eEttYUpwd1MzODkzUlZEUVRPL2t0QmRDdjNQNjhzbmNGb0RXRWt1OUNhd3VC?=
 =?utf-8?B?WnFDS3dkc0V0ZTBjb0pTVGg4dWZuODdJTnE2aHpDV1NTdlN0SSttYkRXdkwz?=
 =?utf-8?B?VTM4Z2ovR1Z0UmxUQjhLMFhLa3MzRW03MWtvdzBYaCtHc2FreU9jSitndzV3?=
 =?utf-8?B?RVNBMU5IMGNrTDJmNS91cFh6VkMzdklvOS9SMTl2cVV3eXBGZnV5NzJjNCtI?=
 =?utf-8?B?a24zVGNiTlJlaW1wTmtvR3pDMEFBN1Q0NU0rOUdsQ2xNT1JvUzhhRGhVdVdD?=
 =?utf-8?B?SHV5am5yUjFhQVc4a3lsc1NkTXlBZmQvSGRjR2JKaW1BUnUzMTRITUNxdS83?=
 =?utf-8?B?R05ud0RBUHlTbUhVdHppUGJRdVVXbEVPVWRveUlEL244TXdScnJrRElCOUZI?=
 =?utf-8?B?Ty8ra1VMRTIrVnVEbldKV3R2WlcvY3dPUDZ4dWpxV3FCUC9qVGExalZqZ1Ir?=
 =?utf-8?B?WEI4bzArZy9LNHRVUXJyMWpFL1E4NVFsR2J4R2o0T3gvcXJHOVFUZXlEeVVS?=
 =?utf-8?B?eUxaMkh5NVh3ampicXZCYXlzRS85YUlHZXZTTUNWYmVlNlR2aERJWGRDb2Ri?=
 =?utf-8?B?Y2NxdU9XM1NMUTE3VmVGYzNSTll1eFp2YTJvaUxqRlVrbFdRTHVJZk9SZFVl?=
 =?utf-8?B?dG5CTG84a0FQVS93TW9KUFYvcVYzRUlDc1RFSFMxbUZSSFJxUlh6TndOdGF0?=
 =?utf-8?B?NVFIWjFkbWhGdGgxQmRiWGs5Y1hxSkhDdUdEZHpiZ2VyL1ptZ0Z3amxSVUp0?=
 =?utf-8?B?WDY5dHlyWXFxT1BGS25mU040SDlzSVhYTHozUWRtTklUV1haL0dDNEduVXNl?=
 =?utf-8?B?RGloZlljYWg5bjRlaFhLd29GRS9jNWg3WFJUelZXS1ZKZ0dyUjY5NW8wU3VH?=
 =?utf-8?B?aG9Xby8vVzQwck1qSlVNVnIyZjgrUTdDZG10MWhSTUVqVmNHRHFoSVNKbmVa?=
 =?utf-8?Q?4sHlcaC5wBVxga0nPD4RltTUM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OShwftrcOn2jUz+TPo3Dz5pnemVWAagFZ9C0wDTvJC9QtgXv6xM9B2hvj5kSMOeciWR7gfRYmLVgGYjKBIw3uq2YZlbAf8yunmv1c5Sfxd4Z0dLT+E7VS/dbTYZOzLioQL1roMMKkyIdCiWHeHb3cApONXP8B1t73Tvp3/TzwckqWsVlNmcYuuNF9oeU+20yWNea1h/nHKYfBohxK77JyQXXV3HNbzhxsDQ6KbcbDDyPIWzpaCHwpiRcJ9xUWzDZE6gc9WVGfUwdGyjAN6QZiDeT1TMeVttjIHRg1Q/7DEVtNifsyprKKqUIx8U6g/iiChUml8ByW8Gr1etBkoJaqmB7Vukb+nb1mDuAF6EUuOJmcZrf6dgM15Y4H0bDKJOsbqjpQ5jZGCMshyTCZO/leuGeufivgFCI6fjThKGnRVn3WfY/YyxTO+5iCtTYLO5jZ+aeiqCAm5fhiYvhW0aW3+UQUse4opJCEHm0nGaSS+YbPbnwq5kLH5f7WPUCWtioB2BFSnYRhms/NiKTU11hW8+BMOhKPwdxS3zzEzUUU/U1OMjj4btNGd7yYhz5EWPGAplvD3lPkJOjGWa11AtpclLeRZTkf/bUUTAA94/QZfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49138929-15c7-46ba-ebbe-08de1e1ed806
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:58:15.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n594/4igU70l2WIRSs6v1pVLlpDk8Nh+eq0Ym1YLIt29v1mdhp8mfueihkBcj1lg5+vXpkK+gFIkswj4bz+tYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=917 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070141
X-Authority-Analysis: v=2.4 cv=A+5h/qWG c=1 sm=1 tr=0 ts=690e2536 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6BzpRD2GBV4KnPuzW8oA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: QvnVidegH0oEmgbogO1z_w6DUeAq2AIi
X-Proofpoint-ORIG-GUID: QvnVidegH0oEmgbogO1z_w6DUeAq2AIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEzNCBTYWx0ZWRfX6aJU3V6Ol0OP
 cRAWoJ1Qpc0boMm30HY6HXr5/Iw4X1NozKAmrfjmfCZmM3Z3I2CyTF+StGykBjgUlOclTrZC7wU
 thnNJi4lWCZ9D0a/9A6MTd56/yF95VhVSRdpjHq1cfbSSTHelOHNPf87rgNKIxq8pyZcn8JW+ST
 Vg/U4TqDj+R+pYlGDUdQqbCGDI0HxL1r6bhIDptmSSvnuLjYnQhQE90zqS8kA/ya8Htwrishgd+
 nsm/G7KCP8cek5Ke+ztrWvorydwgbKsoT8/qrrOufmGJjNZbwQu/WPI8zET4YiNO5kOwlFfr9mx
 MQPiNSEKBfQTnie7zdgwmMsZrw7xStfU1uNu9CgTHo6fPOBmCDW1D8msPwZj5O6TQluyhs00r3X
 8IERDrCfIwcjKW5EIbfo6FT5ATUsqqjCTRqh9FFzHudlsRD5hy4=


On 11/7/25 5:26 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 09:05:25AM -0800, Dai Ngo wrote:
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> I don't think adding an operation can fix nfsd code.  This is just
> infrastructure you need for the fix that sits in the nfsd code.

The reason I added this tag is because patch 2/2 needs patch 1/2.
Since patch 2/2 has the fixes tag, could someone accidentally apply
it without patch 1/2?

-Dai


