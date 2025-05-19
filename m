Return-Path: <linux-fsdevel+bounces-49456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62800ABC7D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEC188A464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320E211715;
	Mon, 19 May 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kfEkTTQa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="akNuAPnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F320C469;
	Mon, 19 May 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682934; cv=fail; b=K3c3Pm9vrippBpEWM9gMvzj1hx5Tjv+xl6dWF8VM9kOd+uOT2VvXLzBn0PXVMkXd8DRQBoNhdJHq0i1bqDVYXB8RqPlR/Yy4zBP3cTwHi3ck4sSJNiSRYtRdvCTol4iJnj0vX/5MrFIUL2+ydKzv273wsoDl0jebZ2CjBZ0/gQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682934; c=relaxed/simple;
	bh=oUE6/b6OkOmJuUaVmz1RzIs2DwvtSB7mzdvx9CfmoXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QD4/EaDOOaO4x1f19bmqELAVGILmLuHx+TQfo0WLYiQjnAI8cevi+PWZFrdir3HxHvzJKCMCYYiyyjpN1JCr7AtSfq7oUZqhzju2PbunALaA/kIgZBLpPwpHpIeySONiKmUcrNmv+7kRuwmUIUnjSj1z0PsfmPs9JHNWK0VMneM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kfEkTTQa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=akNuAPnu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMoHL024580;
	Mon, 19 May 2025 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZcOrJ4pGdR0Q2rqQlHcHRZMmglzteutn1CRbgDlvIg8=; b=
	kfEkTTQa0eOC2y94IfD+jRsHUdK2Zlb2w0qOUnJ3aUzHtaaz8xkCbhGJNz3Gk7Hq
	IoBlCpUJbIyNS+5bGue6crd5WQcAi6B/9zvbsmju/z5fgvytQlHj+IRDx1KvPXyI
	5ZrSqaKvdxOG7twGuoOwnHsAa8Y3YLj53s5gOewW10+FiQGD6W8dKAz5/1pGWHVA
	C/JysYhCPunODhVrPIC5rHE5sXb+o3obyk3YvOqzB/RKoKVEv11rWryKFRUSXug9
	TzYEiEP9YQrCnTZdaVOym50efw/CG50tCi6T4HKCbF72/zuNW6CYLx7BBFa/yGHi
	ZePshLnbHl1jsSlSbpVqhw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvektdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:28:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIt9CU037297;
	Mon, 19 May 2025 19:28:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7us61-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brJ1J1q91jgJFG5Ym6lWAxU48P9zkYe3Q05UVuCRunU+LCsjDdTnnuXX6CHKG4Pp860scpgWJfDj7CI7o+WVG4pnyXfbpH6enT30ko2VBGRubBQrolhLyZ/hZAt6BAjHY0khK5Vg9GJtBjjlsS/uDy8IIIYp6ceiwCoFYB5Y83RRZC7RumqFPstaLuT15NOZpvunZclwIiLco7lTRgHDaaBzkm/HOGTnr462mK0n6q70/sbIf8/l5FH8epsy5f3LGlsnHQj+/8z5Zgo0uwv8SAZgbzbHLS57273G+k1eCGj9dDfiMAryVJ+YOlcCtUfUzu9jX2G+aoNFpgOM+oEEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcOrJ4pGdR0Q2rqQlHcHRZMmglzteutn1CRbgDlvIg8=;
 b=IYadI/TNpCMVMHgLoD1N5CS4u8/ZNcxCCLNyfuDVEfh6xlvO5/dD3IOjUayQostASsjoM6Tz9GhzA35IyRrs141R3NpeMaj5dd70zCAiIF+cmMl1v0bfC3Jz+k7y3G7D4IoGtoGe8Who1PKkUHkpcXDwM2sRj8NTfaMmztDZA0zA+Vat3fBrK9dbodQYwsEg3TXq+UwbTAE83RHduDT8EUYE7/VbZLO/2Gv9N8PmeFvZQ33b3UWIVFGWu5Vg5RNhSLP/60BAA5at7EnqD9iJCc5arZYRltniA4jXSJ/6nA/X/05y5L8y201uQ7jfw1diB3jEOdChw/7glhbhB5yRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcOrJ4pGdR0Q2rqQlHcHRZMmglzteutn1CRbgDlvIg8=;
 b=akNuAPnuLrAfgtAVxNvfpiz3xynEuR9/6wHXu1tzcS0YE2AQuM1PS+D0LVLGa7qowioO03dYc1iz8zHXnFvLc++VYy0dvPgPA0CeFY0Uwlmj+4X4TocTFEpM42baojVUKe8YXWGvhb2AOJyt5LQ03l8YKPhdYfESMJPcLLQOFS4=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MW6PR10MB7615.namprd10.prod.outlook.com (2603:10b6:303:23f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 19:28:13 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:28:13 +0000
Message-ID: <79f16d6e-5160-4c6b-bd82-44bc8cc3a8bc@oracle.com>
Date: Mon, 19 May 2025 15:28:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nfs: Use a folio in nfs_get_link()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20250514171316.3002934-1-willy@infradead.org>
 <20250514171316.3002934-3-willy@infradead.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250514171316.3002934-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:610:b3::6) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MW6PR10MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b81228c-bea9-495c-808b-08dd970b4bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGJOSVdRZkpxL0JxVm5lQzBhN0JDRlBmTmZyTVR1bTFaa1ExaVNvam1DckN1?=
 =?utf-8?B?c1hoQ3JXdzBPUjNrOWJpMnVndERsSGJFSzZSZXVOSXdBT1FsUkt6Z2RBallM?=
 =?utf-8?B?YjFxSzRCbXE3cnZkRjY2ZVl1MzVpZVlDWWNPN0ZrRlZrc0cwMzlPd0U5SzhJ?=
 =?utf-8?B?WGNzbXdDM0dTVmh0OHdiRk1uOWkrcnlJM1RROEFmaEFrMG1uMWNoTHd6SHBq?=
 =?utf-8?B?QkxXM0hnWU9Tc2Zrcy94a3VnRVI4aTU1VHRscHBNVnFyTFJFRngzQ0F0Qnlj?=
 =?utf-8?B?M1JwRXp1ZkROSEprV2U4c3BWdkdkeGlPcHV4K1RvQm13N0dkZExmMUt4RGFZ?=
 =?utf-8?B?THExVm8waWhURTBUY0Jxa0xoOGtiZTI4ZktPUk5OREVUbDZycGRhOHI5RDd3?=
 =?utf-8?B?T3RQSlFyYlBVcy8xMlhHUzNCbmNUaWZVY0x6YWR0OThTdVhSUStLUnRKUGVo?=
 =?utf-8?B?M1RyVk8xYU1kVVNEOTVxTk9XRm40bjdxT3pvZTQ0MXBiNHViQkxRenJnbUpz?=
 =?utf-8?B?M3Z3a3JiM3oxQ2QzWWdhb1dzeFhYdmJ3c0pNdnFXRVlEUWtFWVRLQ3BxK3Rm?=
 =?utf-8?B?b3hRZHpOLzU1T3EzdUxtZUNGNjNWMnFGbURhQnZYSnF6YXVDNis3dWpNYk85?=
 =?utf-8?B?QXBLNDJBZHE0TUtiNm1BOTdzZzgxYjZaallSS2VLdWlpRGxodnhENVQ2UWR6?=
 =?utf-8?B?ckNFbXpkVmx2OHZ0ZmFhWldXN1VuMnZhcHljUStUMVV0U3NrRFlNOGc3dVk2?=
 =?utf-8?B?eTdkNjNoYW9mS2VObU4zcEdOeTdZUGNhTGVTcmEyOTdGYllZbjd0OXVxRVFi?=
 =?utf-8?B?YVZJNnI5S2p2QVliV1FSQmVWek53UUU4NS9ya01ZcWEzSENxNGpjQWRXWktv?=
 =?utf-8?B?QmczQytpMm5kTTZVN3c4NXRFbmVDM1NVRk9oWm8vNE5uVXE3aHlSSDhLTS9N?=
 =?utf-8?B?VEl3Q3FNbGtyWENoNWdGT3N4SVJKZ0tMNytPZkNaREJESms0aUlnS1FvZ0F6?=
 =?utf-8?B?QU9ySkRVcSswNWFnMzlXV21xSG53RnRvNUdZYXBKOUdYeVE3bXJ5ZVVvb1N3?=
 =?utf-8?B?dDEzQlpwZzBtOXlHT0FPM2N1NmJ6R2QxUXpxMWJTUkRZZ1VYbG5ieXBzN1Uz?=
 =?utf-8?B?UDcyVHZSR0hzWklDOHlDbm5TcDU2VXJ2TjQyM1h5R3VuQk9NSG5CQkkwUDhY?=
 =?utf-8?B?V1ZWWWJveUlKRklRbEY4MjhWdnhkSXB3UE9rMUxjZmdjWUk1YkxOamhXQTkz?=
 =?utf-8?B?ZEEvRWFJbTZuRzJPcHJpZmsyOGtDNS9TSUJWVEtkbHlrUnMzeTRSN0dhQlpX?=
 =?utf-8?B?aEJJL052SFBrTUE5L2QxV2JMZTYxNk9lMWh3REdpV1JGalozVk9DY1FpcW5U?=
 =?utf-8?B?RmR3Z0FSQmdYWkFpQW9KZGRlZ0xrM1A1TWsyVGtlVnV3Tng0T2t2M3lWOXgx?=
 =?utf-8?B?YklBY3ViT2x6QjZ5TTFGaXBwZWVjWjdCRm8xSXdKVlZpeHdFVDg5Uk5TZHps?=
 =?utf-8?B?RW1IK2N0SVc2MDgrSTdMQzhYR0swMGtyWjI4YmwrYmVIWDAvelByWGdIdExt?=
 =?utf-8?B?SjhpRG55RGxaOUNscmVBQlEwSkY5TXpBN1l1UURlbFlvNzBLMkMxK1doWkVi?=
 =?utf-8?B?TDBXeStVOWVCeE90RDNtbHYyUUErU2hJY1lhaEcyN1lIMTJtcWdhQ0tSUStG?=
 =?utf-8?B?cGlnY3hEbk56UHBqZGdVVFlGYjk5SXZDTEZwTG1QY0VmOVR1dTduck1hTHg4?=
 =?utf-8?B?Ti85d3FtTkltcWlnU0puZHhVR1pmZjlrcW94dXZrMjgvMmJRbGlHVWlCV1pP?=
 =?utf-8?B?WHJ1U1gvVkhONTg4QXlwK3ozMWF5eXpoL2swblQwazh3OWQ3MDZLa2UrMHV0?=
 =?utf-8?B?VEI2M3JpcXRKb0lRS0o4cGQ1QWVmU2ZsSE04dGM2TkRCWkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWpmeTZHbTVTL092d2YxTXMzcjRuSVpuZFF2eVRTOVgxa01aMllYeWF2Q2dW?=
 =?utf-8?B?WW1LQzhycUxpYXhHK2h6QnFuWE8yUStHcDdPbU9jbnFTelAzSVdxTjh4RThj?=
 =?utf-8?B?azdHaHMya2pDMTFXbzBDVzE2ZDBFREp1ZnlrZEZPeENyVERNdGVyM2c5WTR4?=
 =?utf-8?B?UnFKbkcvWjhyQmdpQlcyanlsZ2ZxRFc1Y0VqWWhmWGE1SDN6cGFaZlhoK0Nq?=
 =?utf-8?B?MlhXc2FlRXhRUGdVKzJxY0crSG0zdHV3N0NrZ0FiOWVObnp4bVUrVDhsbFdy?=
 =?utf-8?B?bDB4NVRwTnRpeXd5RXV0eit5bnVKNWVUZjZlbW1SM0ZrYUV3bWtuSVBWSjFC?=
 =?utf-8?B?b1JLVU5sMXdvK2duYjFNZGh3emdXZnNHSDRJR2RxOVU1dzNNZXF1S2JqYjNJ?=
 =?utf-8?B?Qlc0Y0R2OFNGVUthZFlLY3BnSmNHVTYwa1EzY0NFT0JsditkUWFHOXh5Nyt5?=
 =?utf-8?B?eGhld2RmaFNkbUJzMWZOTUVLMDliZ0kzd2l2ekhyOXFoVVIrcVVaZ2NTd3p0?=
 =?utf-8?B?MW13OGU1YWtHS2dwNnpLd01nQWxJZ3QwMXhwVWdoK29VNDVXWUJtNy9SSWxS?=
 =?utf-8?B?ZmRkMzA2VE9EaUxtckFBVFdrUzN3d01LVWp2MmNBWmxFNE15SWdjaitKUzZs?=
 =?utf-8?B?UkcyRFFuOS9WaWl5dmNGVmM0RVc3cFJxTS9pb09yeFJ5NWh3UkxFVHJodEFI?=
 =?utf-8?B?bWpBbTdPSWp3SXR4QlJFaWZVREs5N2M0M2JrdXc1Z0Z0UWZwYmQyUlVzTGlN?=
 =?utf-8?B?M3A0M3lvS2lZQU12MnJOcjVxS0Q5Y2t0Wm4zYjZoanY2bGZ2WklkVE9LSzZ3?=
 =?utf-8?B?VXpRL20vTmZMdGxndnlPSXpPbGI0aW4yQm04cy9hOEQ0OHJUUzJwNTZqVTUr?=
 =?utf-8?B?cjNFMEhXOWxrRit4Q2YvTnQ3QXk4eFNiRXpuVTlDRVRSYVA3OWZEVWx5b1N1?=
 =?utf-8?B?bUtYMm93YjBnMVdnc1FiSlArU085L0lEWlE5MFVMWSt4eVZ3YUlxSlljYXl2?=
 =?utf-8?B?N2xJL1JSeEZBMEJGb0tWR2hodWhna09kbTdkaklVOUZOZDdHMG5vcUFjSmFD?=
 =?utf-8?B?RS82Ymt0OFUwSEpuakIwMGUzTXo1aGdSeVVmNkFkejFuaW1IZnpqNDZ5bkZI?=
 =?utf-8?B?cnFFRGVYUk9oZitkanAydmx0NGJYQ21ONW5jaHlaNUFiZEFnN29BWWM4ci9s?=
 =?utf-8?B?R05GOENPOU5EOHp1MlNrcGIwS05veHdjckhKWTVxSkxZZFN6b1RXd3ZZZEV3?=
 =?utf-8?B?ZGNtSTl0T2xXTTI3Q0gyTnRpWGVQN3J4b3ZncWh5cjRpbTVFaVVIRjRieGJQ?=
 =?utf-8?B?REhoVCtBMjJadW0rdmRYSHRMM2RVOGdMZzhFaGlXYjl3NTBwdWJtNjFlWlhm?=
 =?utf-8?B?ZDQ3ZDhTZ2IveFIyeW9VNStZQ2s2V25JT1ZKQjdOQVEyR1B0dXd4U1dQWGlE?=
 =?utf-8?B?MmZTQnpVcFQwV09Ib0x1b0ZHdTYxV3hXL0MxS2hnVzdrdFlIaU84MzFJNktn?=
 =?utf-8?B?eG1mYXNKNWhKbjNwM0FSOXFKY0puZ2Z5c0Z2djlCUVkzeCt0cEpTVzNHMXZG?=
 =?utf-8?B?OEIydlU2TVhaZk0reWYrc0NQM25vM2Joemt5WDlKcW5DSnJ2SDQvMWRUenZD?=
 =?utf-8?B?WktwRWlaNFpoMmlCekcyYnEwTytqY2hjSG1WekVPL2kvb0Z4eGx6bHRBSVZ6?=
 =?utf-8?B?MUM3aDFvRy9HenhrQy9yL2l5YVlSV3dhMlBzbFkvR1NjdjVDU1NTTkZYSVE0?=
 =?utf-8?B?MDROK0dFT2hjZU90STFucERzdnlrYlkwdEhCMzJxNXBqVmdQTmg5NWxUWFZP?=
 =?utf-8?B?akdvcnlHNlVFWUJ5bkFGVXdtZzhCMFRNS1RwS3dWNVNldUdlNXU1bVdLekdW?=
 =?utf-8?B?OGlZcHNCeXlZWEpkMk4wQW1iK2hMUlRZZHR2UVlpckRuOTFSV05jbGVza1hx?=
 =?utf-8?B?dmtPLzZPeXREV2Nlby9xc211RkthZEJ5bVIvaTBTcUlLMlg3dER4SWNyME1w?=
 =?utf-8?B?MGw1d0E0SjlWd3F2ejUxNlZCMUlGcENUU3JyemR2MWkyNmk4bTVnbDBDTk1k?=
 =?utf-8?B?WXQzbUg3L0FrR3VUYUl0QUoxL2JFeWpGdkpibCtLa2kzMUNMVUl0TC9CYWdy?=
 =?utf-8?B?WEZ1Uy9XQ21RdUlwd3RsNVNoVzdxem9QZXJYSERZZS96amJ1ZmhDRmJBaVlw?=
 =?utf-8?B?cWtVM2tYU2hDM3lLcTgrekswOWxBc3pXcXE1aC92ZXR5ZTRmbTIxOE9BTXdm?=
 =?utf-8?B?N09WSXp4VVdOM1JNQVZvcTFmNE93PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bocfE7CKgVdyZbYZzHpLIKT6wzWvzYzMRssKPY24nxymcHF4WJyFxoVcxGUZtMbL6eQnIFId0GAmD74MrQDNd2Fj+rULALd6dEOWk7ub+C5CkahvC9M6KKYTnzR9F0110CkB3VP1sF2g9Msf/1HMMPeCW5XN8c9rVtHk39x9qlmgyR+ht0CJ8VWoWTYu7sNcPJGqRAd7KFofcpzavnACq97Vrqhscb6GuNRvLyZeQ+5XQ+UqgVzpZakVmWzuIT5tsh9KLgo4vATfISEcumUBekViyyRFuPg7ZCWiekF79GoaexXH/PZptUVqlAjIlzC9e+fUnb9+0idCppsadaVH94Vngxg+AG+9xTdCVCjnRZJiG44lvtwVH2Codqm37mDwQWbiHAmWCzWbYwGp30WKGBtjKzPTSya1Mhdp9jx0tNvm4ofSW2eqT4WEXI3iW6m29KT3Xpffnul2aZIPPZBKQBRcgaoTTNbrFQJqxld2mniHTXV4QHwfZ2ed5wbdOPPuWUZ1MlvCKz6mrhmbiybALJr74OTsgSigXrxaTJ3Gcxj6leAzR/MZfHZ8HNuJKPDp31G3FG8faAMBZWtAESrxn3YZfmdYqEC0wzotAxVZaJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b81228c-bea9-495c-808b-08dd970b4bf6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:28:13.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5T8JfxPWl0TIEM83ZJGugrqI60zr2x9P8LQmjCQ/1hyRPSJWTWLLkeDUrHluWyedjxSSKRngP3MrI76K+VwIiiA36lYVNWznQd/keQL260=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190181
X-Proofpoint-GUID: 3WK-2R2dgsluh8xWxon5tc-gWDKvCPxj
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b8650 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=2Z4RfGbR5vvUJh6ozQMA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: 3WK-2R2dgsluh8xWxon5tc-gWDKvCPxj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE4MiBTYWx0ZWRfX/Ske0T06F3k5 Z+M5f6JF96TJy6d6x0d/RPDENDN4tVtJ3Ea6OzhVe6kSrqUETtpJyyWbyVEGCI8HZNpm7FHabrK aYLErGF2OaFJw1mJ5BLrJsCTeA4q/4clky765hm/GOWnJNRy/2pbcTB90gVaQ/sjZfrNp90J2k2
 WQQ1EH4DnJu89KNbmV9gicg2n5XG4gQVHBFkKNZO16dOy4DkmTueIlFvAgpvHuErQQa0uXNi+jR CTvVBIRx9T1ZbsSTCiDq0b2QO8at7E9V2O9WsahF2YmVrlfX8zWU6w8i3wqtMyhRDe65Yeml7+0 E32NAA0h+6pQfQEWu5b/DiKWDywLmxbYPfSdLrDyt4mYIbKDpGGMbrgodYCDtFcM9ghZ25toumb
 bkYRhL39wmYihsU69PXy5Gh0/UN6NQRfsy8vNsx7joQISgha0SccuZrjio9KheiQRBnspdf7



On 5/14/25 1:13 PM, Matthew Wilcox (Oracle) wrote:
> Mirror the changes to __page_get_link() by retrieving a folio from
> the page cache instead of a page.  Removes two hidden calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

> ---
>  fs/nfs/symlink.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
> index 1c62a5a9f51d..004a8f6c568e 100644
> --- a/fs/nfs/symlink.c
> +++ b/fs/nfs/symlink.c
> @@ -40,31 +40,31 @@ static const char *nfs_get_link(struct dentry *dentry,
>  				struct inode *inode,
>  				struct delayed_call *done)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	void *err;
>  
>  	if (!dentry) {
>  		err = ERR_PTR(nfs_revalidate_mapping_rcu(inode));
>  		if (err)
>  			return err;
> -		page = find_get_page(inode->i_mapping, 0);
> -		if (!page)
> +		folio = filemap_get_folio(inode->i_mapping, 0);
> +		if (IS_ERR(folio))
>  			return ERR_PTR(-ECHILD);
> -		if (!PageUptodate(page)) {
> -			put_page(page);
> +		if (!folio_test_uptodate(folio)) {
> +			folio_put(folio);
>  			return ERR_PTR(-ECHILD);
>  		}
>  	} else {
>  		err = ERR_PTR(nfs_revalidate_mapping(inode, inode->i_mapping));
>  		if (err)
>  			return err;
> -		page = read_cache_page(&inode->i_data, 0, nfs_symlink_filler,
> +		folio = read_cache_folio(&inode->i_data, 0, nfs_symlink_filler,
>  				NULL);
> -		if (IS_ERR(page))
> -			return ERR_CAST(page);
> +		if (IS_ERR(folio))
> +			return ERR_CAST(folio);
>  	}
> -	set_delayed_call(done, page_put_link, page);
> -	return page_address(page);
> +	set_delayed_call(done, page_put_link, &folio->page);
> +	return folio_address(folio);
>  }
>  
>  /*


