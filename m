Return-Path: <linux-fsdevel+bounces-21397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832490384D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EEA286F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A2178367;
	Tue, 11 Jun 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hX7Q3KAr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x/GLDBxC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321CF156E4;
	Tue, 11 Jun 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100122; cv=fail; b=k1sfaL3qQo5+sY7Cdv/xuVyISclTy8fKge2EPbyUy9UO9sH+e7tOBadKzOPRamFkGYPXZ6wGoLglORImxCnuItqhxgFZTXaOBxf1/P6zJO+wJAfHLEEduqXvuPRzGIOY5Bu3CDqbYYvjgqbmfZpg0JU1Z9cXxBPwb8ltC0ni9Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100122; c=relaxed/simple;
	bh=VjHgBBzk2ukjyFZwNXAR7/yERJvzsgzzDN0ZF31sAu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKOv2nH1fsmRehPFI1lf/JoLUrYzzZkUaM2Ce3+aZDkrGtS/ms7L9KIqVxcu+coQNdadjOzJkEC63J5cck+YoidsccKUW5nkNvuk2EzlQ1VDIf3ekXIeGbQgzamhXZkukqMoH1TQOVEMkAnDUHfS3pN9+H/e86conGR6DkzboLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hX7Q3KAr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x/GLDBxC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fjMT006260;
	Tue, 11 Jun 2024 10:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WZxJK0KitjFsNbI46ijt4PwHXcRqbytXHT9xXCM8QRM=; b=
	hX7Q3KArfpFdszkEf3ex5Gmmo88RVY5yC34P9QZ3s4aQWb0sCxF6EjhTTKUowKKA
	/m5cJi0fdjTCXXGld1xpKqQTzp1cA+g/9fXbM5J1khkd9l5TPiv9uFDbuImH+Yas
	19QlSRIbSh/62QmWz5AhKuY30jaHO3xuOXpFAvqTKNFd8BjA6JhZOhCFrGYThdaI
	PSImvSub7w1k/ax5IGv4Z1iZWCoT81q7e2wiFTo+sJK3l8uJFujbjzgjvotPV4JG
	VQtgbSzKuOtG3DteteAj7PVLwpvYirasDMX9+PVt/hCmfqhK+MPdS4HeugxM1Jxx
	qIgHCioJM5Kd8HR8SwkTPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p4f8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:01:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B8UhlV014235;
	Tue, 11 Jun 2024 10:01:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncetqcn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7lKb5WZadP07RzOjTflJg39o4n7FYz+758Q8hsf2ZTVBI2vp6yIHMC8U47jXHmDTkFVdxU6/pdWjhDb79LmpBlVhOCzEmsW9lwhalKZ18wFbhzR8OXTaKfaKqvMeKv9lGZ5rN7AJemUlTNIkuXmpcWuW0bHHLIEoaUs1razU5L7sCygnVjAh1edXbDTLXVAFQQTjwJTD7thgEhtdCzsVFReTNSHYkhF2lVbFa7Dkbbtduk9xBPqX/kv6TlaQcwK7qLpeJherzukUJeJEKnMzvCiOfJHEvFcNxOHVPkx8p8hUyAa5TzAp2UpAF0q/H9GNkJDAV3u7ZxGAH5t9Rq59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZxJK0KitjFsNbI46ijt4PwHXcRqbytXHT9xXCM8QRM=;
 b=llJ0fP7CF5Ako6FdtJI3IrApsalt7u3uk4mqZxhUBiMhxvps2ZVXNbn40BhhTLEixU6PwBTSnhirTFw1YDYG2JyXv8t7wlt3pt6TBtyAp06UiI8n78R1JA3X2i95kGYleYO1+FEHd0xw5tLC647orM2Cwya0h+WLJGfzaZbBlrt71IuoXID/UWvIGPIHLxygcdTDi/noGzFbOcPi8SS+8nMViQFMnkVd2TAVFOihe9paVGi+PwDyl5iRULN/nHiibwYNbEvtlmJcK3uZBbR4TlQFNO98YHnYKtSHtTNI28m5Fst4iHtjtveqLs+fjfLL70t9pkkWub66ZkkQjpmYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZxJK0KitjFsNbI46ijt4PwHXcRqbytXHT9xXCM8QRM=;
 b=x/GLDBxCn2VVRksfqc+yGz5zH+TR6HEZLV1sGDfxFsbv1bH2NBCq3ALd2pPmv2mNi7BGfdx+GjC5F6B3BqE5LHqJkvXJQPJnRqCLC7VopbZZXETfVKRSBS34tdZFq99MRGHLb8DRUN5OgXZC5kaqyxdUg6fucbhRWAjpWNnFiEw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 10:00:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 10:00:49 +0000
Message-ID: <f922b3e8-eecb-42c9-8dba-f17f9bdd31b0@oracle.com>
Date: Tue, 11 Jun 2024 11:00:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
        brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
        mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
        linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
        Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
        p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        gost.dev@samsung.com, cl@os.amperecomputing.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-8-kernel@pankajraghav.com>
 <4c6e092d-5580-42c8-9932-b42995e914be@oracle.com>
 <20240611094137.vxuhldj4b3qslsdj@quentin>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240611094137.vxuhldj4b3qslsdj@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: dffcef7b-d3c2-4f66-d5ef-08dc89fd5f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cThEVGlwQjZtV1hIdWMvMEQwUHA5bzJhc0RWWUsxMHArZTJJVDlJUThlSnh3?=
 =?utf-8?B?anR2Z0w4dDU0UW8raytSRUkxdjFTZ3VVNTB6NWhTTTNndHl3dHFwUG8va1p6?=
 =?utf-8?B?MytIajZJK3JtTmxJMUtOZGVGdGlTWkZHWnpPbHEyUlJNZmdwck9KWjAydHZs?=
 =?utf-8?B?MS9tWVV6YWZDMUNMdTVIQnJzSWVCbmhZMmdYN0FTd2VnYk12a3dsYnVEbjk1?=
 =?utf-8?B?eFUxdnNITlNvVWhKeXkwcnFiQWJZeGwyYmtNQTIyYXpmMmNOa3NmOFpsRWJG?=
 =?utf-8?B?WHZucUxPajRVVnRWVUtSSFVoTER1YWVnL2s5a2gxMVhNaGk4cWp2OTRqZDN3?=
 =?utf-8?B?enRMMStGdFcyQllwRHloalpsNU9YQ1dTZ2FSQUY5QUJJQzNOMHJLdVluK2dw?=
 =?utf-8?B?c1FaMVVLVUhRMW9QSllHZFlUdUFvSTkyWkgwRWNoOGlwTmNmQUUvZmN3K1VR?=
 =?utf-8?B?Qk9NYmIxeDNTbFJUY2QvUE1zaFJlZzVKNE5ueVloMEUvNTV4WW4rMjFManNl?=
 =?utf-8?B?cGw0TFRrb1IrZmpjb01kWTVsOEtvU3huSTlLazdLOHVXTkxwSmloNWNXVldF?=
 =?utf-8?B?U09XaWhiSC9LWVRaa1FEL2tlekNYeVVwMmVGUjkvcll6cmkvejZiQ0tHOGpB?=
 =?utf-8?B?SWkvY1RKaS93elV2RERiUWt5L3NTWWMxZ0V5TDVpbEVxMzlGUkR4Ykg2bHpm?=
 =?utf-8?B?S2pCSDBsaUdxS0huZStGajFELzA4UWVpY0M1YU5tc3VZY29idnJQRmFvS0xl?=
 =?utf-8?B?MWJDYkJUcndPS1BkaGJlZzk4M3J2b0RxQXR5c0hGTGFoVTRrKzE0USszakJK?=
 =?utf-8?B?cXZDY1Fob3R6c3JzekQvTW12SlhVK1NjaHp6Z2tVQUhMeWNPMDV5RGoxWFh4?=
 =?utf-8?B?M3creUtXemVWNzJua3Z2YndHcmtlYUNOQkxPamxHdVc5cVl2K0QxNVlZVUJl?=
 =?utf-8?B?cVpydVNNM0tmT0l0VzJDc2tLdVVWMVVhTmNSUE9sRkNOK1ZCRWJuL295OStN?=
 =?utf-8?B?OHZlYy8xclg1djgvWVkrNjJNYXNZaEdtSk04d1o3TjRrNDlMSjFWNXVkWFRQ?=
 =?utf-8?B?cGZYVkRueFBwZjJYMHFDSVRGSjl0d2tsaDVUci81c2VrdGxYL0hIZlNBbmRM?=
 =?utf-8?B?WWtYK2RRcEhWaklDcHcxK0g5dzE3Q1c1b3JKL0dyVmVLRGJqTjd3c2xuS1dT?=
 =?utf-8?B?T3BsRk5PbDNURVNaTzljL3RIdkd3QllFZm1SZnJ4dFF4Nm5iZWM4dmlTakEw?=
 =?utf-8?B?cWh6cmdrdm5WdEJZeDg4Tm5WZzJwM25ETXVNUExwWFZHVzJTZTV0SFVyeDNk?=
 =?utf-8?B?alFGeXoySnR2NTZkMW8vcUZzTEdCZWpBaVcwcE95L0t0UlY3bFVINC84Nmx4?=
 =?utf-8?B?MUxLdENVUGRsU0M2QVAvZXVRdEZKenQxaEwvazd5ZXJaakxRRjFrKzFHVmJW?=
 =?utf-8?B?ZSt1RDJIekt3T0NJVlV2N3hDMkU3MktqKzQwVFNJNGlGVHU4L2NGS1lHQWhr?=
 =?utf-8?B?eSt2d25zUmplSUozMTh5M0E1ZmdtYUplL1NqckNHaElZMEFCT2VHUG11SVgv?=
 =?utf-8?B?a0RSWnkxbEZXQWJlR2xZUUpwZXhDYm50Mmo4Y0tEeE05NXZCdzZTQXdwMDJD?=
 =?utf-8?B?Ti8wQ2Vzc3pqdGpXR012T3lZOXhBT0g0YTZVVEhuODNsTVZubU14V282d05l?=
 =?utf-8?B?TjJYblpoZDJzSldWdyt3VGd2T1AzTXlJZjJKTFI0L05uRjJrbVFzL3hBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFU5eTlSeUpaOGc5TG12bHdqbUwrS1hHZzhrNnFlb3VjWTFvZGVaa010dVUy?=
 =?utf-8?B?RlBMczhYbnVLL2thYmNidFpsYkkyN05xcDYrNTAweFV4d2pkRmRNOVA1TTJU?=
 =?utf-8?B?bkJQZUlET0RJS0FHaGxXak04ck1MN3JwcWhVRVV6Z3FHRzZTT0hPem5MMXhy?=
 =?utf-8?B?djg3R01Xd0FIUG53NDRSLzh0bmFUdTMxbGtnbjNLN2NxQlJ0SC9Peko4OUcz?=
 =?utf-8?B?T2Q0RnFqTXFNeE95c0FwSVRPVnpjTi9pUHlnOS9MdENraEZxZ0ErQVl4ejI4?=
 =?utf-8?B?VXdnb1Jjd0JTUncwcVROOFBVS2ljNFA2TmQvWFdiWUphaTh2Zjhrb0FaMW9J?=
 =?utf-8?B?dzQ4L2lJTmYrUHgvS25xUTNvZU1oTWgwajdtcHVZcXBJZWtLK1YvWkQ2RXc4?=
 =?utf-8?B?RkxjaGhEcUZMTGtWRXZxa1VaSmQ2ZHFKVStpYUJoek5lUWF2cXNEUElBOXNk?=
 =?utf-8?B?bHpSZWVoSWJac2JpVVd4SktTdlYyUEtMWDByOUQxaE02YlBHcy9FTGMzaXdw?=
 =?utf-8?B?cHl2K0cyWDZQWVJSSW9oNnJ0Q0hETjh3VkMvQzV5Q0djYy9CNVVSdDE1L2JQ?=
 =?utf-8?B?WUx2NG1semozL3lKcWtrVTl3aFhKSC9WYitxbU1VVFl1SlFEd2FtMzhkTytz?=
 =?utf-8?B?Rk94ZDZWSlNlVUs1Y2J0Y3cwRDVHYitDNGJUb2ZuaXZqMkhpeGMrSkFXbFIz?=
 =?utf-8?B?V1M4cXg3WlpSUDhuNEM3N3AzVXNBSU5VVG8vRVVSdHk0eW1ZdDFTN05tNjFS?=
 =?utf-8?B?QjlDVkx2bjVINGNKR0ExaTNxWjM5OWs3QjdtTWNFZjFlbURqSUhFYURCK2k0?=
 =?utf-8?B?QWFHcFFjMkg0TE5EL2tQS2E0cmJ1RENCc3dzWGtGV0NRRVRnVFp4U2FXRzRD?=
 =?utf-8?B?NUxYUHhQTE1zQ21kOFdPSEJaVjAybUE2eFQyVWdrSU5jQlViNE80MUhsaTlX?=
 =?utf-8?B?L3NtSlNDR0FGNDFmWDhLMUw2L2MyVWk5VFNrY0VFcVJTZkRVMklrdlVIektl?=
 =?utf-8?B?UzIrR0VSaFUySFhDYWJnOVVrOEtyMGVBS1JSZDdzVWZ5K0dUR2xhR3Q5K3pW?=
 =?utf-8?B?Z2J2SWkxakROdytDY1ZBNi9TdjNIR01jeGJrcks1d2R1aDBSNGRtK2hqaEd0?=
 =?utf-8?B?NlArWmFhOVFRQzZiSnFSZW9BTVZlM0RDNUFIM0p6YzZMOS91YUlaNjUwSW1k?=
 =?utf-8?B?ayszWlVVUnIxQmlqREJyeDMyd0dReDVFNGNndktiVWQ0cmp1ZGYxSXVQdTBp?=
 =?utf-8?B?TWg4MWd5TEVJMXJBM01uWkRBakdqTitySVI0UVk1WE5RbXVMdXhCRzI1ak9j?=
 =?utf-8?B?MGZkUFQ4MUtpY01VRW1NN1dXdnU3SWRYczNDSys2MTVkanFCYzNlSGwrdnNV?=
 =?utf-8?B?UGdPWkNIRHdaMitzN1FrT2IxTFlOdm54TllCNWVMcHFnbmV2SEZDbGpLYlJU?=
 =?utf-8?B?b0l5K0EzMTUwTmhTMmJaRjd6QldwQ3VzV3JieXNJbWRmc0pKdExKTXRHNmxB?=
 =?utf-8?B?c0Nld3BPZ1p0VTY5SkQ2bTRlQi9lUUJZUExtbXB0SVFVU2NQZ0ljblVWMVdV?=
 =?utf-8?B?V2FhbTJHa29OeXgrVnFlY2M0ZTFGakhteWRUbjFyUzlVUHoyZVY3ZThWVkRR?=
 =?utf-8?B?ZE8zTDlvTWl0cVdiNTdUemluZUZ3YXA1N3RORGtTMmhQWmZnWkxQSGVHenUx?=
 =?utf-8?B?bGQ1SUgxTU5VdVBTVVNkZms2Sm5rYlhSMUdKYXUvYjNLdEJocURveHY5YUFo?=
 =?utf-8?B?bUhqT01jRmVDZWZsR25YYWNCc1hSTXlncnkreW04ekNuYjUzbE1ySjM2VWRK?=
 =?utf-8?B?bXpoR3l6MlQ2RmxmQjJVd0xGaC8yYTdRSXdCY0wzTVZ1dXB3Q055K1kvMWN3?=
 =?utf-8?B?YVpwWEJPWVhOdElBb25EWGpZTVRsb1cxbjdrZ0tuaWtPdDFxa3grcnJmQVNO?=
 =?utf-8?B?MDZWYVBWY0Q2cDloLzZjZ1dsalY3TlRKNGZwUmgxVFZ0QXRNOWZEMHhicnlH?=
 =?utf-8?B?aExrc0NuaFlqdXRySkRtdkV2UE40ZnF1NDY0ZnpBM3J1VVg2M2ZwUHRkSmkx?=
 =?utf-8?B?R0xPUkJ3WUxBQmZTYndybmMxdjBBZWpXZVFqUS9sVm9NN0N2dnFLR1NMbitS?=
 =?utf-8?B?NkErUGlnaXpsYzZFdE56K05JemFzbUVpalhCME54VzExSzFIN0NINnFNdHhp?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S8HPbD0mwgwdaqoWzRyAocClSMjnNWH50awCbiA/fYqUYkssW0UudCdhREB4X87pduggHpC8VN4FWJ9PE2hsR1Pm6L8uG5GuGRBllDrnYYHwFBFvZYGjab7SYRaRQBey/FUmNFHVAIJintRd8RUeoD4feNQw3DOG9RzcipkMrfMuoPnyQPSsder2NNlFQfSYtgg7w7Cqug0HqCjaOFijnesBl7wuIpUTtnyqT/Gee86H+X5Vd02SvAl2S7F7udAby/lULEY06P2fXVzvqHL0yxsyZ1l37ssBkXni4n5xhZT6msOEEbR/7d9XoKa5WjDRvyD9OD3A5BhzvcZt73crY2ds0GKrkPh1WvJXpy3qEcfURUWxvNnHU+C1FS0y04WeAjvzvReHRwC0VygefMwkh7ikvpRDwxGKRKnxDzX2Wl9dp/CI5T2rmW+TKTwaSsm140F/29Pijwhdn63xgETajsGKLTaYlz9o2ZFPCm4adWcufEUp0K2XtG3RqxOn87O5DfaxUgyl5pgErUD/EkHLDAi6tSla6SgLGDtJNBoWMPNC5lI+9oUs6UulCfuAaStWZOieX5BMoM6Pagii/zks4G9qQMdaJl5LVdFRMZ+NoV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffcef7b-d3c2-4f66-d5ef-08dc89fd5f21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 10:00:49.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua9b0fy2vOfBb+nNIDDSL1cY28whTBy8eulO/TJA5TdvGxF23f6o6OBOvZKbH5BQ2ohazB1R8bJu1BUPDmTgkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_05,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110075
X-Proofpoint-GUID: ntS48cbn-ouqc5gaS09vIqC25Ly8BKq3
X-Proofpoint-ORIG-GUID: ntS48cbn-ouqc5gaS09vIqC25Ly8BKq3

On 11/06/2024 10:41, Pankaj Raghav (Samsung) wrote:
>>> 8419fcc7..9f791db473e4 100644
>>> --- a/fs/iomap/buffered-io.c
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -1990,6 +1990,12 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
>>>    static int __init iomap_init(void)
>>>    {
>>> +	int ret;
>>> +
>>> +	ret = iomap_dio_init();
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>>    			   offsetof(struct iomap_ioend, io_bio),
>>>    			   BIOSET_NEED_BVECS);
>> I suppose that it does not matter that zero_fs_block is leaked if this fails
>> (or is it even leaked?), as I don't think that failing that bioset_init()
>> call is handled at all.
> If bioset_init fails, then we have even more problems than just a leaked
> 64k memory? 😉
> 

Right

 > Do you have something like this in mind?

I wouldn't propose anything myself. AFAICS, we don't gracefully handle 
bioset_init() failing and iomap_ioend_bioset not being initialized properly.

>   static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>                  struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
>   {
> 
>>> +
>>>    static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>>>    		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
>>>    {
>>> @@ -236,17 +253,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>>>    		loff_t pos, unsigned len)
>>>    {
>>>    	struct inode *inode = file_inode(dio->iocb->ki_filp);
>>> -	struct page *page = ZERO_PAGE(0);
>>>    	struct bio *bio;
>>> +	/*
>>> +	 * Max block size supported is 64k
>>> +	 */
>>> +	WARN_ON_ONCE(len > ZERO_FSB_SIZE);
>> JFYI, As mentioned inhttps://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/*m5354e2b2531a5552a8b8acd4a95342ed4d7500f2__;Iw!!ACWV5N9M2RV99hQ!MTwVaC6oueHR_vgmDfOvgBX8bPdeTSRPcRcw5-CqtHnFEH-Ya1sUeZwaF-xrBF5XZ_8lJw5l-riq4t8IkfBhf2Q$  ,
>> we would like to support an arbitrary size. Maybe I will need to loop for
>> zeroing sizes > 64K.
> The initial patches were looping with a ZERO_PAGE(0), but the initial
> feedback was to use a huge zero page. But when I discussed that at LSF,
> the people thought we will be using a lot of memory for sub-block
> memory, especially on architectures with 64k base page size.
> 
> So for now a good tradeoff between memory usage and efficiency was to
> use a 64k buffer as that is the maximum FSB we support.[1]
> 
> IIUC, you will be using this function also to zero out the extent and
> not just a FSB?

Right. Or more specifically, the FS can ask for the zeroing size. 
Typically it will be inode i_blocksize, but the FS can ask for a larger 
size to zero out to extent alignment boundaries.

> 
> I think we could resort to looping until we have a way to request
> arbitrary zero folios without having to allocate at it in
> iomap_dio_alloc_bio() for every IO.
> 

ok

> [1]https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240529134509.120826-8-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!MTwVaC6oueHR_vgmDfOvgBX8bPdeTSRPcRcw5-CqtHnFEH-Ya1sUeZwaF-xrBF5XZ_8lJw5l-riq4t8Ij2hl9yU$  

Thanks,
John

