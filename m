Return-Path: <linux-fsdevel+bounces-76625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDmAH2gwhmmPKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:18:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF5101B23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06AD30247FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD130EF76;
	Fri,  6 Feb 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RMuCfJo8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bFy7Q0Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0E2ECD3A;
	Fri,  6 Feb 2026 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401883; cv=fail; b=KJnvFGAnoj+FNek27fle3Iyh7cFuyleuev1UDtStVlLiy8JB9KA7WnHtptpAX4fYvh7oSSz+ylQui2Q5ECevYIL9wP54Uau6Vcy3EDo7vKRQY6Ol+IGRjh1IsuQ5Prw37TeDxpBfEa2xxCYD6477Dg+BbshOJ7sXE/glrcQVr20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401883; c=relaxed/simple;
	bh=Dph5sfKFEk4TNOTtiqaMpwRl7kKC84USck+Qts61+Q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avX18urovxwMNwj1HZH+wM04NUpUHvPHHk0qrsErfvc46YcWyEZ8RMnHjwIoS50VKdYgdoWSgtc1dac5aKEyy/vSWO0KQv1Fs46uyh/YfXSzjEPDRsXaKELteDBeTpI/gjtW4SfSFYqw3JW94VfattiWap+vEUWAKXI7JJOWGVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RMuCfJo8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bFy7Q0Dy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616EvJwU3111500;
	Fri, 6 Feb 2026 18:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UB5heMC4CLEQSBrpueNMqYkPpV2fpKHboc9ld03TIa4=; b=
	RMuCfJo8H7nk3561UFFSC/pNYqjbZNRqCabDFzDEyFxhpDx7aJEQl+EcCxw1NOgP
	VTwg/YgrxWk626y4aPjCWclGKEiJjvMd7O2hgkHgvXresN/tE49BcqdL2rHCkCcn
	o1zepBzZU3DC9EUz/2/giTNzKOIktisVMO+k6h4jGSKgUrObwvF8OvJIBGGg/2Pl
	xJftYvDGvAuh4GSDPf/IVp2Y+9BfNDc9VHI2WgAezB7XbXbgV1+COBzc1pH0TlO0
	JBROwyu3Acwd8TCGb+mhCrP+5ixj3RVZHfM3xTrkPIKHzkjjpmz5xXlnz4q9LJ9h
	qakeiIccDRnxLorarCiPdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c50ddhn73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 18:17:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616HBNd5030550;
	Fri, 6 Feb 2026 18:17:41 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186ewcpa-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 18:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKDRwDsJoK2Bz76DjVLMUok5x/P+NvHUAuu0Ahg3F+BJhXhYNnl+LLC+XujaQ1Wt5Lrwg0a+bu0eUU3BJLwdw3fWFC9YfFszDgolTg0TvoiXExPTPV7PdmFdhfG+vRcuQbVzCcLc4W9XvTjgpQ+kBm6tJIiSlZ4S21IQXoAs5j0V2eOGthWGYUzxxc/J5ALFl/zh/MOSvIuirqwI1Xfb0HmIkcgIHSNmij4x4i+SQwEUkF8an6juwLT0xdt6XBoDSIsqiQprWxQthK/9KiXW/+dBjdOF/mIG6EuyDVrs8O+pst7jUz8+FZ/lfwA2DLyaHjzWlgRzF0TpVAaNpshWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB5heMC4CLEQSBrpueNMqYkPpV2fpKHboc9ld03TIa4=;
 b=Cd6r63yxnAcorV1jQyNsdsTPIQsLzQd4CivHtaoaSgrCCrzi47yzttHlYEoNMIaeJVqyvNgTQ7qulp6cOH6p2l7acNooTBX9FG7u2juc6zqK8dTndFVa64986HWchqSBSXHY++lO9J82mU5Iq76eCEt4ZIl3TiroId//HLPcIlXRYLSV2iXz/If5dIlDT5ztIB8p4VtaqKDa9cK6Hl3mIO167Ac/3dHmPv84zLZZAdbWMfXB090O7D+9DsDfGCywiYJnG3w2AmlxlVE672fVMq9lgbGjsbqxbRPGgOfntf8Ce0FkCAwI1JZQ45MfFhde24e3BhNahBOsniL9laQZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB5heMC4CLEQSBrpueNMqYkPpV2fpKHboc9ld03TIa4=;
 b=bFy7Q0DyLiMqEUNavRD8XIDnvZXr4Lpuug45XjG7QhaNjmdOyQhRBgCaAi3BhPWN+oISca6OooWG2Op9gkBsutmSF2Rj6OsrJF5RHaiO+0qdQduVgsvCGpi5eLLjT62ZlE52zGzPYBykELmcNRtbI0KDy3ewY1uNu5Nv3Plnyh8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB8029.namprd10.prod.outlook.com (2603:10b6:8:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 18:17:37 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 18:17:37 +0000
Message-ID: <6a28e81b-1e2e-4457-8bec-4312e6d3246f@oracle.com>
Date: Fri, 6 Feb 2026 10:17:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260205202929.879846-1-dai.ngo@oracle.com>
 <9194ce4db4391c0e6428f97b05fcee53706fb485.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <9194ce4db4391c0e6428f97b05fcee53706fb485.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:208:178::17) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1f9dee-f3f0-45c4-c1d3-08de65ac01ed
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ekN0bE5ZeGc2ZWczanJ4TENoWU1BdE1DZERiZlBTY2o3VzIrdFZ4T010V3d0?=
 =?utf-8?B?YjBTNUdEZ0dSZldyVDdKSVlkbjR1MWJuL3ZqUU54WDJsYTJOYVlsT1dOSndZ?=
 =?utf-8?B?cTNSTG9PTmt3YjFMeVBQZzUrb2tRVkEva0lMNEEvSEhFR1Vwd1ZFWGlOWEhh?=
 =?utf-8?B?UVc0Wk96QldiRVRXd2g0dFJNb0xjc2M0MnRpTkFkK20zck9POXRyQk5qNjBh?=
 =?utf-8?B?TVBwWVp6WjVHY3R2aDRhcHJvUFQ4ZHZtNEhUSW5aVjBPdWtzcXRNU3RyK3FV?=
 =?utf-8?B?SUkyTFp2ZWJra3lVMjJoU3ZYcm9ZVW1QRzYyOGNGNFdSSnhOcWloOVJkSFZU?=
 =?utf-8?B?Skh6N2xyYVI3bjVTNUtDdWorVjd1T3E4a2QwMGswMmRMRVRwYVRCc2p1dnoy?=
 =?utf-8?B?QVhoTFQ0YTkwSXhmQmlhK09YVm5LTHZRZTh2ZzlZbHp3cStSUmN3MkVRQ05K?=
 =?utf-8?B?cDltY242NVhUV0xueEJ4MGtUUE0xWkxZYTJ2S2o4Zm9tekpVQ3pHRDcwTmUr?=
 =?utf-8?B?Wk9aZW1kWXE3aGxzY095NkE0NkRDOWE0OXVrbEFLY2d0bTZ5cjd1YUlqbHFt?=
 =?utf-8?B?ZDd6ejRFQWlxZjN6UlBrSDlpN010Ukd5ajU4NVZPMDN3YTgrdWRKcGFzdzlK?=
 =?utf-8?B?SS9YSlpNUTBmVGNJenJIL2x6bVBGVkpwNStjcmtnYnJCeW5tbDhyVTdybHdK?=
 =?utf-8?B?R21VR1d5SlNqZnI5RlBEc21JamlQQi8xZ1hpZFZXNmlLNmJETDA2bU5HbnEr?=
 =?utf-8?B?bUpEWmk1bEJvUjVhNFpML1BDNGovc0ZuYWFCTDFlMUoyQ1pmanFVSkpEckxS?=
 =?utf-8?B?Rm5qL2QxeWVuV1hjaS93ckhtR3NsRDZubFQ5azdyMkhaZVFyeE1UdmlWTkJR?=
 =?utf-8?B?UlVFeHBBdlVxV0swNG5lbXF3aklETDhjdHE2VmFmaHRxb1R4eVhMOXNRNGRV?=
 =?utf-8?B?bzNueEY3VURTaVQvc0lScUlRVWxkWFF2aVZCSUZwMUpJLzhhQjMzMnNqNk8x?=
 =?utf-8?B?QjQrTlJGbXlpZDJ1VUxheG1CL2Fic25VL1FhNUNLTFBrSm5vTXB0SFJ5VFIw?=
 =?utf-8?B?L3pUNGRyT3RISStUcGxUSStBc2MraHF2WWRCRGEvMm1BKzlSUCtnUk9jblB5?=
 =?utf-8?B?ZUxrUytnc1kxZUhsQk1INTI3UklodFhzWENyaGFBd0gwNE40TGNRaUFId1dB?=
 =?utf-8?B?dEd1cHBWUnlWRE91SnVpSjJnTUNKOWNNYzFPdnF1eGU3K3BPZStOYXAzTytW?=
 =?utf-8?B?dFBLbmJvcmo0aFNyUFljVWk0K1JKYXJZaDNiVktiZytoZ2tKZUREWXUvWEx3?=
 =?utf-8?B?RlVxQXEvREhjbjVkRVJ1OWlNNE1pSHBVUWh4bDFqaUlIcEM5Z0tPZ215LzN4?=
 =?utf-8?B?Vld3aW44UHdrZUdQYlJFa1pKTVpwc0pTNTBaMDIrOHB6QWVNV1lPdzR2NTMy?=
 =?utf-8?B?OXI2SGRneUJ6QXJZbnVNUVJESG9zL0NQZERmdkFuaG00NjJ5SFdBbksyQ2FP?=
 =?utf-8?B?OFVUVVRjODNYclh3Ulhnd2NSTCt5SEltRVBib1RBMDFOR3lLV1BqcXA3ZTNB?=
 =?utf-8?B?ZUhlb2VLQmRpejZJYW9hNFZyWlNMcGdnNFNxdjlmcy91QWFJL1lGNWRBNkhI?=
 =?utf-8?B?T3NrNk1BTVdIaFM1U2Y0djhScVZSd1lvS0lxSzh6U3VnZDJ3U0U2K08wQU9j?=
 =?utf-8?B?S3V2UmpRMlpsRjIrUTVWcit2NnFzd3FpTGhDajNoWWk3cVNnQmhIWmlKUExq?=
 =?utf-8?B?TnF5MjNrZlhZSXNsYUxVbFhCK0szcWhGZHIwYUc0NEZJOE1pZzU1Q0YrYTNz?=
 =?utf-8?B?b0ExcE5vbUJVZTVRM21qbEtycWVSM095bnBlTm1Oanh3K0JRcmM2azlLc3l4?=
 =?utf-8?B?bEdpZkxNQnFocnFkNzdJa1hiWVRiVUlxNEp4Y2lUZjhMWlZudmRYcnRMdHVL?=
 =?utf-8?B?N3pkMVdJM29JV24zUk03R2NGU2FNYVMvdEZwTmxnOU53WDhwc2gwUnp3dmgr?=
 =?utf-8?B?TWxvYUZZRmJVbGtlTWE4RFBlVzRZVk9JNmlmaEl5Qm1RMno2ZDN3ZEgwSm9S?=
 =?utf-8?B?SENtQ3BacW5yUU9Zb0JXMlRTZEN4Q0Qwd0RPcEszK2VmamliVVNyZlpQUWlS?=
 =?utf-8?B?cTBaRGk4eWJPMGFzK3ZqS2hIQ2FoQ2RkQ1N5Nkp3b2F5ZHJNTDRPRzhKREEw?=
 =?utf-8?B?Q1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V0VpdG91MXJ3VXlobHRqakVNakdIUFh6WWduUWd2RTNzVTIxRG1Ic3Zaalps?=
 =?utf-8?B?NjhQOUhBM21rWVdzTWNHSnZoUTVqNEUrTVpTV3hNUEloSFRwdzdlU2x0a09S?=
 =?utf-8?B?WnBBbExhZXFYcVd6SGZnYmdySy9tQ3dWdXZZMHpnYWFodGRBcGJuejFoUFk0?=
 =?utf-8?B?NlMxekdlTk4rMlBCZUJUTEI4UmhiUEljUnpFWnVJYUVveEkwNThFZDZGY0ZX?=
 =?utf-8?B?ekkyUFdhTHJQMEhBbHRmUHlqTGpMM0hOUVhXeEZ1dElTaGxGRlVyYTgzUTZu?=
 =?utf-8?B?OTZVa3BENHFQMXF2S245U09sanVFMDJaL1VEeUllOFUva0dGcjVWWExaTEln?=
 =?utf-8?B?eEU5RDFUaDBTM0RvRWhJbTBKam8waC94VDFsaVJaQ0RXMktIODk4Q3NVYTVD?=
 =?utf-8?B?WlduY1FSNmZydHZCSFJJQVFKcEczaDRtLzRDTWR4Q2hpZnMvKzFiZk5DWjVS?=
 =?utf-8?B?Nk5oRWRSWjJXczhmTWpZTnlBaWNvckIwSC9WT2Rmc21jUXd5bWdqRjdiRjdx?=
 =?utf-8?B?VjYzYm1MTC95Ni8zMGRuZUJZMWlIK29Rd3FUeTM0TkxsNDZrUVVjS1hINld3?=
 =?utf-8?B?aUdQNFNkWEFkTTJGQzlRRHlJbHJpZmRZYWNpMktXdUVEaGx0UzlWYkFEdXFk?=
 =?utf-8?B?OUFLSnNtRTMxZzRjRkcrRld0RVdHWjg1OThyM0JTdnRGTkNlaGVudGhpWlRn?=
 =?utf-8?B?YUNneXFWblc3NHd0WUg0Q1dhU2lITTl4cEhOSjlYYnltRTR2YzhUcjFWUkFi?=
 =?utf-8?B?OUIzUzhyRmlVbjA4SnZ2bUtYSlhoSUJZS3FPQ1RiVmp0ekUvUFJmanFRdDND?=
 =?utf-8?B?N3h6UWI3aERPa2QyRHk0SGVTU2U4YURjUEJPTHEycjQ3ZEwyVFRSRnNBcHBs?=
 =?utf-8?B?TWtzZHc5bTBqYU1Ec0dhVFcvVEc2NGM0Tk5peS9QRytydGVBaUl3d2dudVFF?=
 =?utf-8?B?SjU4WjhqWTh0SGlDakFmQ0RZaDlmQWtTakt0VU1mTXpTVEtPNWxuQk92eGlF?=
 =?utf-8?B?UkJ6emd5emtzVjZxTUdQSi9RMWFIb3JQT2xuby9FRUxFUFZIeEVCWW1yWG9X?=
 =?utf-8?B?eXBXMUVNOFQ4ejBIWS81cjYxYXBEMUY5UEQwUTh0YytxNSswaEhVVkZyRWI2?=
 =?utf-8?B?WUVOaHR1K2R4ZjFQL0JtUEtTSjc3eDJvWndGbHZpdDRDOHBIc05GSUwwc21C?=
 =?utf-8?B?YXRxOGozQ3ZITFZaTnhHdWFBbmk2Rm1aekhnQk1MMG5nSWdKRTd3M0I4Smx1?=
 =?utf-8?B?bDU1QlRUdUc3QWhUZlNIcyt6UjNUSVRhN1I1N0FXc0loOUZ6Tk04VWJ5Vk5p?=
 =?utf-8?B?MnhHTGkza3F5Y2ZVTFNVQ3JFOGhKV1ozYjJBTVF5UU5jQWxsQzd5MkxvWUJR?=
 =?utf-8?B?UVFWM3BxRkdzeU9UWWg5UEoyZmpud2RiZDVXQlFwR0wvMHVhUzRpcE9Qa2x5?=
 =?utf-8?B?VjBaQmUyYkRuNHdPY2FrLzIxQ2pwLzV1MjRmaDFmWkkyMUV5bFVHQTFhUFhv?=
 =?utf-8?B?MUM4MUtNQmxRbTIyRUl0d054TWdxVE9mM0FXcWRvUVZocnZMTXlpQnBYY2gy?=
 =?utf-8?B?OGowUWdwb3RpU1duZ2RXUHdTSUNoWXdUa3hHclIzdUFxdDhjUnlOM3E4bnJZ?=
 =?utf-8?B?b1FtaVZvbFZ4WlZzU21mSDVPVG5EK0pTcktYZlpPdWZUVW9QUHVNcFc4U1Rw?=
 =?utf-8?B?b2xDRjJjQW5GZTJjcTBXY0pQQzJOditTK0wrbVlRRWlIK2pKZ1VnSjRBL0ZR?=
 =?utf-8?B?dUZDYzZmd3M0Mkw4ZldSMFBYTWtRaVowcTZkTW1KeHpmbWlsMnpBRkM3ZFNH?=
 =?utf-8?B?RWoyZmNGNW4xWno2Y0x0NWlOQjcxUVJhVG13SXU2ZURDai9QVkZhcWxHNzNJ?=
 =?utf-8?B?ZmEzZ01xWTRZbWlsV0lDMnE4UlFuMWd6L0JIWEZ5VHZLMjFxL0lhS0hrQko5?=
 =?utf-8?B?cWEwTFM2Um56NnZPdjVpandJS1FrQXZKZE14bTVSSWZIRzZHcGkxVE43TEM1?=
 =?utf-8?B?TWdEbktqbGhjM01jcGJVRFVQcGxYTmh4TG11N2ZLdEE2N3BoNWdTaXdlRGJj?=
 =?utf-8?B?MFZxc2l1bU1WT1pOLzVIRDRTLzduZm96UnhySTIyUmtDekxNVDNjUEtZY2kz?=
 =?utf-8?B?Ly94M21TTjJ3SFlMM0d4OExrWldjNHYvMHJaQ0sxVGdsNlhIdURLYnlJRzJG?=
 =?utf-8?B?ZUozYVRVZTM4MHc2OXNvUkVUc3ZIVStRWnJkWWdqKy96VW96RmY3VVFRKzgv?=
 =?utf-8?B?enJqTUJPeU5USE1UaDNHbEk3VFduVm5YREdadVVKVjduMGU3WUQzRUVqdkRh?=
 =?utf-8?B?dEhJWmIwNzZlRVlnWFkwNVhhbmJGTEg3WHVSVElUZjVONHowKzE1UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y5BXamL21iysSqcdkT5r6zmWOUhtryOgSYSx3JmUMSWEW0KCU2iKI1ZsjLruGmrYh6uE6gyvQrkmTAVnu+0QYBnhADcKsG3u7/GOneW+nCTuZdZC2lnBgjAd/2UTc4xf6YSdT69EC7KHOtwhzqL0hrJgJO/UCt0o23Ttl0Z9QcNt8WNEl6Id/j+iEqb0jT52xpMbLOt7zAVmVhA9WWw0kuEKcyz0pUEwD3Hm3Sx9AFqOtKZTApM9gMEVSPUg+4BDxh3jmhCTbPgHr/22/0jfk+2jlY65N45PBlIG+MFuchqdiBR9XT+wPstcjtTR6fEZwSf1GOFbsLRHWlnYf2sSM+E6nt6DBy3e3v/+cu91MhXkguVj4ITJBnT3WXRTl0b8BYkbIgRqWNNEnggmMHloBhvX1V//2vIzXWMM10dPfHtASq+TkfyrbxcvJFO8MERJqdrooF3F+AKggIp4Z5m2LNEzGUBL7c/c8/U8mzsNRpHsTtg8p/mmSvAoTXmO+7e1yCwdhtHkFIzWvpBJDJ2kwcBxbGd4JCKIOLdLEu909n1HLwH819g1nAlsmqbxRAlvRNJsIlzZXcedbUc1SdkxA9JYMPZwkLpq7GqQ0rZF0MQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1f9dee-f3f0-45c4-c1d3-08de65ac01ed
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:17:37.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DqEZ77VUv89P3bW81xRKyHsUEdEpH14H/V4emH6dnKny4gfQp4pELBBgXh3ZWU7fb5EIeChph7sTzxNOF+P9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602060134
X-Authority-Analysis: v=2.4 cv=TvvrRTXh c=1 sm=1 tr=0 ts=69863046 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=ywH7qlgsDWXX46lI1LUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4pgw0aBm4XoRCAeOsCOEJkZzu3BQRlT3
X-Proofpoint-ORIG-GUID: 4pgw0aBm4XoRCAeOsCOEJkZzu3BQRlT3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNCBTYWx0ZWRfX2YXYYhNIky0b
 x2jsfZ4WxJ2Np3NLQNieACS7wwcjKc5+0JAwM9PTxu4czc+vgA4z7Et/RH+bJx2dB1uMm4ka+i6
 vNHcNlVPv6LHbXOFDaVDfN9XimscJSHQimY+p9C9SVlrhpph+1A4OLLOklUzB8aoqBNpOt9mU/g
 MLu0282Fw9Ugu4A6aey8nLqCu3eigHoPTIxdlE0BdaHZx0Ai6lKwmlLgtw2S1jKqOu/4Lwdx//M
 w5CNA/v3Ib9m9MSOvALiDGGqHGBHWP/Q9gvV/9AHkct0clQGjlikEEvURzDBug4tG4C7fyBcL9C
 juEw+KSgaZEvQvIStmeXNTOrgaDAkDB4v4/+iRO6TMPbvGjQWhteG5+WrSUfOt5tkJcwUOY+Ur9
 zpgJMw0dkezVU3uo1Hij1Wk5FqtSm7yk3bn4TjnRmV9yqwoiJS4ED9ywOeketsyjMcRqMuIzrpo
 kDCb6GMlIJIgl5xAzUg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76625-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7EF5101B23
X-Rspamd-Action: no action


On 2/6/26 6:28 AM, Jeff Layton wrote:
> On Thu, 2026-02-05 at 12:29 -0800, Dai Ngo wrote:
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
> Fair point. However...
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |   2 +
>>   fs/locks.c                            |  15 +++-
>>   fs/nfsd/blocklayout.c                 |  41 ++++++++--
>>   fs/nfsd/nfs4layouts.c                 | 113 +++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c                   |   1 +
>>   fs/nfsd/pnfs.h                        |   2 +-
>>   fs/nfsd/state.h                       |   8 ++
>>   include/linux/filelock.h              |   1 +
>>   8 files changed, 169 insertions(+), 14 deletions(-)
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
>>
> Ok, fair point.
>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
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
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove = true;
>>   
>>   	lockdep_assert_held(&ctx->flc_lock);
>>   
>> @@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
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
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
> When remove is false, and lease_modify() doesn't happen (i.e., the
> common case where we queue the wq job), when do you actually remove the
> lease?

The lease is removed when the fence worker completes the fencing operation
and set ls_fenced to true. When __break_lease/time_out_leases calls
lm_breaker_timedout again, nfsd4_layout_lm_breaker_timedout returns true
since ls_fenced is now set.

>
> Are you just assuming that after the client is fenced, that the layout
> stateid's refcount will go to zero? I'm curious what drives that
> process, if so.

No, after completing the fence operation, the fenced worker drops the
reference count on the layout stateid by calling nfs4_put_stid(). If
the reference drops to 0 then the layout stateid is freed at this
point, otherwise it will be freed when the CB_RECALL callback times
out.

-Dai

>
>
>

