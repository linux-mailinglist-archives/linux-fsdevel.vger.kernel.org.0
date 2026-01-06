Return-Path: <linux-fsdevel+bounces-72477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD528CF80D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 12:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEAB331313EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AA326958;
	Tue,  6 Jan 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATpAUlzS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jmtr+rRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624824400;
	Tue,  6 Jan 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698830; cv=fail; b=GcWsI1g/auDmdTbGwo6ElcPlDVSMzI0ylbZzCr0mVQz5iLaXY5EVSMvDdEMpb9CFvuVEgdMTrVi4BMVcriNISinKFEfcXrselZaRe/Q0GMFmix/3tD+lqGR+nqa+ngTg+6H544R0ZCoM4cH8a3yN54c5jQJM9fokyK1fTEW4rmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698830; c=relaxed/simple;
	bh=R7qFlBJEuaq7ISM0wD1hCO2DwwPTt9aM5scMTgQKT7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ij0Yd6BaQZl0FnTfU8aQ/jpxzo6NR9KXHEojA7w296tZ43dwlTIvcKfRJS7M9SHV86NXXgKzxLcvwuxm6xtPt+CetqV9MdN8MdObgUWvj7wLeP57QQZb/T6lVccJlc8EFFR6jh8tmBFupRvx+nsmHb8Yx2xdCOPWCsyrBi2mQQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATpAUlzS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jmtr+rRo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6069PXE23543210;
	Tue, 6 Jan 2026 11:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TETVsNu4/y4wYh1lci4gWmFm85u7dMKQJSDi3ZSg2FI=; b=
	ATpAUlzS25cxEDPIBq6fMGZ6ySDaJuM19FA53CpSM2mCUlFpx+P+lvjUMbxa6hZB
	WOcxRX1ySY1Dcn4EQkWsnL8QI+2Uvf7Ll9f0WwTLFqKE6U4+1Q+nCSU357quKtJx
	BDpM7PLgEhM2Du+8o8XPf1dqbZJ0d3wfO9Hkv4pOwiL0rnuE+zW6YBpRgdxdUUuU
	ge6iLtJjZA/E3ci74a1xCunA0JC1m32MuAywXX3AetyAHsMCYeXX9oBBTY/8YmZi
	DhFzIFmhFXKUj5vOnq1qjIVaK6bovL11mIkhGgufAQutJ4ABEe3432g8y94ZcxYz
	M/tvnlxaYB6N0l80vuKRaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgyrdr3sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:27:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606A2RdL027538;
	Tue, 6 Jan 2026 11:27:01 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj87gr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGXgVPZdm0vp1FJwZcjRvmRICfbPsSVArtXYNwlLR7OgbZgJ9AhLPBQVVbcY4XA9Gq+uVHibws9JgQ36U0ElurYGu7M36ztTLTcGGUuDiSIe+hfyMtsRScC+vXus2K5XDkhR4pa+TkokxmqufWYjdUirK05q954vS8Q13I598P/GNirYX8Xi+h0FB20GM5ARqUQYGvZ5d/iGOAMD4JngZXkDXwTBhY/vukBDG83rGa/monEiJ1xhLeGPUAggQEAQwdNHSCPnhIbOV8uc9xA81uBxpwIceQRLzPjOkouN7QdwMMcqL9EPu8n0i7CQRvX6MjKDjjvHq5ctNlVegzuJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TETVsNu4/y4wYh1lci4gWmFm85u7dMKQJSDi3ZSg2FI=;
 b=Idid/9LDOWLH9pfGy9tk1uXZwyVhfZZLilfft277YwqpLoj5itPOM2IMuroFkhsMsFw6gHsDLXAqBGKcGvbN/Wq0wMdEgVX2qOCzfmTHuboFNnePiEEc5GLQTndXZDxnKegd1Yafyp+psb4KXCZ7MCMZGb8CpFQy6ERM8sqHCvvW7BT4ksC/aNtoHQiqTTErNcXKdbms/lyAxDndxEEOXD8mND4/wn3917HggkHX0ojRIXUebuO8O1LiX8GcyQdlaFsgDKDQYce9yHWuYYQ6tewmFcJfEIfd+gemsFtTUYgtwJTAskhY1Zj+whednjXIdTo1zQiD1wSb8AleFTWcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TETVsNu4/y4wYh1lci4gWmFm85u7dMKQJSDi3ZSg2FI=;
 b=Jmtr+rRodPX0epFuRWF+vk6fa03Yc7mhukYnWZ4vURa28F90U7wxrw4FWvrXdErue+7NjQ8hbY+V4tBp1EAX/n5whHJnpNxe+flVnznUjm2caXI/crUslDzfmpYB6XBA2D7fB5rCuVWYBPkpWT/0FI/dhvqBrct/EaSA91QX4j0=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BY5PR10MB4163.namprd10.prod.outlook.com
 (2603:10b6:a03:20f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:26:54 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 11:26:53 +0000
Message-ID: <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
Date: Tue, 6 Jan 2026 11:26:51 +0000
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
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
 <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0228.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6dfbf4-2128-4947-558d-08de4d167e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUdNcnp5QjJHNzBwK3pSY2IrWGF4Q1B0VXU0WGJBc0V2OHJKZzlCeUMyRVhs?=
 =?utf-8?B?NWlTWFFYbnRKT3dTaTdxZkErK2F2ZjFCRmdhRGI4MERRTEdXTlcyTmxrZWNS?=
 =?utf-8?B?RDJLWmN3eEtZMzlzRnZUUFlZd3NNZk9iZkhqTmlhK3N0b2hzazRBV05wZndr?=
 =?utf-8?B?K1dLbHJNVWd3RkJOSjhkQUdlZFBXL2NjSGpZRWNnVzFsek91c1c5Z2VXRnJW?=
 =?utf-8?B?Y1lQOEw4MndZUElzRVVEMXJtM0xjczZzSnROUHVyUjQwYUtHNjQ4R3hyOHRy?=
 =?utf-8?B?cWZuS0h3My94bGU5Wk1jbi8yTVpvd2NjNnBYYU56eW5icExYeXlpU3FvUytG?=
 =?utf-8?B?S28veTBMVXRqSENiZkxnWTE1c01FeDNPYnMxWkFoMjh2TmFueXQ5NHh0b2Nt?=
 =?utf-8?B?cWlwVFlzamFjYXlWS0kzL2QrTWU4OXBKNkxyU1dTblFVdjV6TTliMnluUFc2?=
 =?utf-8?B?YUdUemQ1RkU0cUdHOHp3eDAwaVNPSWdsQkxGQklSWWxtVGlmSzNMWkJNWEt1?=
 =?utf-8?B?c2Jpd1JqSktDZFBRQ1FTb1BrR1lRcU83amlYN0tPMGFOcVNiZkdWTzJPSmxz?=
 =?utf-8?B?MEQ0Q05VMDZxNy9ra3A0ZCsvQVNDWEdHWVIyalo4b0JMNUphekJic1czbTBO?=
 =?utf-8?B?L2l1WEVvVmJHZ3R2YVViVDBLdi91bnlTRzZIaVJ4YU5nQjh3cUV3RVdRaWl6?=
 =?utf-8?B?Wk4yT2RaSW54MmhueE00ZjRMamYzVTRzQmRXVzdiUjRqWDhidEFHS0tQMWFQ?=
 =?utf-8?B?OU9TKy9Rc2ZWdWwxYkdTakk3UXJPMFAvOERGWWdOdjRvT0ZGSEFLdXE4R3F0?=
 =?utf-8?B?RE1takF0L3AxeVZIZ3VBT0JEdHpxejBuUFZhcWhCVFFvZXJZYTNUcGhha3Fm?=
 =?utf-8?B?VGZ4a1c5MDQveHA5Q2JvRnpOalZpWXhBNkF3dWR5cnF0cy9VQTQvZ1JnNjJY?=
 =?utf-8?B?MzZqbHJWaFpNYmhaUXhBeTR2WjFURURqbHNISWJ5elJuZ0NZci9tUnBqWGl1?=
 =?utf-8?B?UDgyM3lqd3N0N1orOGdlT3Y5N21NK3JzSThoMXBBQ0tFbnVDNUlsS1FqTDNx?=
 =?utf-8?B?WjdqMk1QWkQwMlg4VFQvdWd4QXZkNnRQMHNrUFcwVkdZZ2NIZVM3cFN3ZUdP?=
 =?utf-8?B?UG5PWkFaQ1hHNTJFZDdrOFJ6MkxKNVNwVm54MUptTHJlTmRBRUpSTm5jV3U4?=
 =?utf-8?B?Q0taTnhIN0NadkJsUkZkQnBPNldYaWdHTmhkNjVUNFFqQjU5OU1zcklkL3di?=
 =?utf-8?B?a2hIUmwxZjJpbzBYVmM1VzdkRzArZWZMZnNiYW5kd0RDWC9OZmJDSk1qVFRE?=
 =?utf-8?B?YlBZUHhWdG5GWVZVUW4vYnlVVHI4UVJ1dWNTOW0vUWt0UzZQaWhrUUtVTkxR?=
 =?utf-8?B?Nk9Kd2xmUnBBL0JPZzNIZFI5YXJFUHpGa1Rjckd4RFA3cDNsTGIwUUE4R0pZ?=
 =?utf-8?B?RlV6bDZVNWJZeE5XZlV4R2tPQXo3R3NJUzRYSm00UFFkWENqVU9lTWZqdWUv?=
 =?utf-8?B?ZXowL1JiOGRxeUltdTFIOUZnVnhuSzV2cVNjRWptTURSMEpJSVFLdnQ0REI3?=
 =?utf-8?B?Zm95M01oaGt6V1F2dkNmaXcwSzF1TEY1VmRzUTlLQnFFdjlEa0VXMmd4a1J1?=
 =?utf-8?B?M0VsWUN5ZWdybFNzdHg0cEp0ZmRJQzhhOCtBVkNXd3BYbTJKVjBaM0tyWXJT?=
 =?utf-8?B?VkNDbXNnbEtLT013aUtTZkJRM08wV3grOUF6U1BuMXdEZWRzc3gxOEdXcXZ3?=
 =?utf-8?B?aloyaFJ0TGQvcEhCeWJTa2RxZVZYMldVME50djdScXFGQTNtWW52VEpRemUv?=
 =?utf-8?B?MDZITWw5Wm1tdkJnN0kvRHNoeVdBRE5kK2pocndrczgvd3JDeGl1Z1VzdkJr?=
 =?utf-8?B?Z3Y0SlBoYU15bDlrZnJScHNIbm5taUh1dnUwN3RaUFdwMzlIQlpqTE5DY0Vk?=
 =?utf-8?Q?xaHeBdH50SFgStZJC+NdWoPhLvJr1Be2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0ljMnRDTWxiNFUvaHd2NHFQbzRWRCt6Y2lmcFB3Znk3elZaQlhFZ0x2ejJa?=
 =?utf-8?B?Z1htcTN3ZnJmQWJnTnR1bVh3U0kzanA0c3F5ZjZUUGxidC9aUGY1YS9aVDhl?=
 =?utf-8?B?ZlNMUFJDdFNMMVFxRndlNEtWYWdZSytKZFJvd2lkYXI2Tk9yNkhxQk9Ia2pH?=
 =?utf-8?B?QmhKZGJzM1VOSXkzZTNFT0ZMQ2ZkTjRSaXRaRGpSWnFFTUhHb1I5bmg1TEtR?=
 =?utf-8?B?OFBXY0lUWkZ1a0FqV1FpRWJwaFg4djhLMG5wSlk4VmZlMytYVytUcWV1YlFi?=
 =?utf-8?B?WFdReU53Y0Q4K0g0dWt0QnIveU5EOGZiMnVwZlRTV1BIQk1UbEd1dHRXMlhL?=
 =?utf-8?B?VENnN1BHNmYxMEkrUnRhZzgzelVHcFF2TmwwY2JDSFFMQ280RGF4S0p6OTJz?=
 =?utf-8?B?ck9WWnlOSm9yR04zaUtEQXZRRUUzSjdLSjgyRlIwTk1ocFhpVXJPQTRWZTZl?=
 =?utf-8?B?cWlIZ3Ura3piVHA1YUQrLzFyNTVIbHUyajJOVkhxaE9sSjZFVDJvWEZMZU8r?=
 =?utf-8?B?enJuUlhCZksrSGVSazdzQlFWcmpoUEZiRDFqSnU3Ty9oejZqRkh3Ky9ocGQz?=
 =?utf-8?B?SklLVmZjSzQ2WUkxeWlxZUpwRHpPYXh1dG9xRVZJZnRYcEVzMXUva041dXpJ?=
 =?utf-8?B?U2VFNi9qN040M1ZiTVVFMGRIcExjUUo3bFYvNzg1WVk3Rjl0Y3pwQWExOGFC?=
 =?utf-8?B?ZlpEcG5rcGNSd1NDSlhET1NUMk0vdUtvVVNqRXVjUG1CVDZHQ2xGMTV1QmZa?=
 =?utf-8?B?OU03QzlLeFFzVHdVL2hTNDY1QWNEa0d4dENlUDdyOTlkN2QyR3NrS2lCczho?=
 =?utf-8?B?V2dWUzJrNE1RU1ZmQjNKczZ0bWIwYmVWbFFzSFk4RWlKcFcrWTZPakxSRnZX?=
 =?utf-8?B?bkQwSkhMMUFIRXVzYm5ldkc0endNNjd2ZW5MMVo3TWgzOXR6SlpVV0ZBVWx0?=
 =?utf-8?B?c3dyMVFlRUpWY1RPS3NUbEZhR09qQlRwTDNOdjBBa3BaYkNpTW1WN0RENUZy?=
 =?utf-8?B?dlVnZHF0MHdGNENKQWdaWk1RUHcvanVPck82UmZFMW4ra3pqaGl6RDU2aEVl?=
 =?utf-8?B?cWdlaDVxSExTRjErQlgxVXBwRGplRkxudUx2TzV4dnNvMkx3cXVPRFMwZUJ6?=
 =?utf-8?B?MWJzc2lPeFh5Lzg4dmhJZlBXbWV2S3FLbnlQUEU4ak1CVTFVMmtkVG00WE1F?=
 =?utf-8?B?NVl4b1B0Si93ZkZ3L2lncm5ZYksvcVlId0ozZkF2aXhZK0c1alZVYVBwcWV6?=
 =?utf-8?B?S3dWVFc5dVVLTEt3cHZKVmpNeFU5K1NpQXgvZWcxOFVsMS9yYnoxOU0rNW1Y?=
 =?utf-8?B?b2hIcFlUUi94WjliMzFnR1U4TG5FSEljdVhWWXRWaE1qYUphWEozaUpOaTly?=
 =?utf-8?B?bFNkdHVVbDc0SldRY0UvV3B5MFB4Vk16NGYwOHFlOTBXVE1EaWo1WXFuRjMx?=
 =?utf-8?B?UlVFelVXZ29pd0lIK1VEMzd0RmVpaU5jY1MzeGlONm9talk3eXU1ZzlUS20x?=
 =?utf-8?B?S1ZweXhhdkN5bGhWUUlqRFVQb1ZpWHJISlFJWjZ1aDZaM24rYnBxMFk0d1Yw?=
 =?utf-8?B?TVVmblBTWTZjdmVwRTN5OWE5ZEpNTHRWSlBXbUFTV0FneURtVTlpMWpNM2Ft?=
 =?utf-8?B?QzNyeHBQUFRPRWtuNHR0amVQQWY2bDU3dmo1ejBJWHR4a25CTEFiZjNGRWx6?=
 =?utf-8?B?OVdKcE1mN2tDdDVoemtyN2lwVlF1WWVnakMzc0YyeWlJZDVUcWpqVnQvQ1Fo?=
 =?utf-8?B?UVExeWtMbFhMcHBYUS8rMzdzVzFmb0Vpb1ZOcW9wTnhTVnVrWGFrcHdRci9I?=
 =?utf-8?B?V2dxcEVoL2xyQVVsT2t3anhDRHpVK2ZoL1ZoOWpZaVY1a2hHenFKT0RNTHAv?=
 =?utf-8?B?NGllc0VrYThWNTMwQ0pVdUc3YVA0Umo4cVZrc1RvWUpFQlozWUNUREN1ck43?=
 =?utf-8?B?VzYwZkJNYzRKNnZSZVFWYzRNQTRtZ3ZBRUZGUkRrVG4rM1NORE4yNFE2VEgy?=
 =?utf-8?B?TzB0ajF4WXJobjA1MmxsOCtydGtKTlNOME5pazFhS1FKdCt4NTBpd093cGw4?=
 =?utf-8?B?RFVLZW93TW5IQjllb2dZTHUzb2h4T1pnVVNQZlE4R3dtSmJPY0ZyL2hia0pj?=
 =?utf-8?B?cVhKVjZPbnRFb1k0SXU5eC8ySHN6QnV5UmN1WFAwUU1ObWJOMTkwRm1ycEww?=
 =?utf-8?B?UE81NjdiZjIzeXZDa0N2QjQwNUtmMTFJeG1XdDZia2NRcFRVODVGdXgvVDZn?=
 =?utf-8?B?Y21yMHNldDNxWTltbFREMXFDeXdQbTFhK2JJQWJWMDlxamNzTGR2SkVGZ3JB?=
 =?utf-8?B?bHNYd0I0VXI1aVRCekxnbVRlZk12N1llcW5nVmx0OHd3Nytscm83Rk4wZndu?=
 =?utf-8?Q?eNBAzaN5TiaGW38s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TXL04cDlvgKszFpa+wBknDaT3GaZOtK3OvvE8Uhlc8ynzZAiXHf9vDiIzHylipzBTW0zs3cDMGtLp0NTOwdo+Zcb/nf7tUrJ9kVxkmr5s/g4TsLC3l0k5W3wiHdysj4HUBclsayI0W+f1qVvKU/ZCH7tuO7tNw6AkS9rI2ecUS77/7eewQfxOXDknbNMVOgztW6f2cdO8PKDQS2FADtVXxHPFaBiRWn7kYIZevenCYRVuMh8w05X1H8nY9QoyGKQcdh98m8zq4beatANXHyGN89brEejyXpZW6MsbUQ1lVwXITbeOWLjo0e9SASdNuWwtA713h4OF/a64HksNpWT+vtJem03lyfpY8B34jtLGChcHwPL1pgxvxpnE6jEjFKsPo6KkHXZ2W5Zrek8jwEeo1b6i0unXCMluEBOYnPTkpeB+yx3ah08pyOL3iihjlgj70AwT+HhC7qowTKr23a5ikpsUpBOlUr4FxIbWv4TL5mmqOpyRtp9uHlfxw0GeRCt/6NLhwBpF2ZMIxToBad23ZkacsgKYacJqTMyZaQ6E3iushnAmNimL5CCDs6MvMK4X6TOEGFaW+XlBMzTPVUxwiAEyIx3tDeJB1NQF3azA34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6dfbf4-2128-4947-558d-08de4d167e55
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:26:53.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/axcCxGF6nbwWhw0CIywsF4gHU/qdnnUBKPqq2qsUwiESu4aL6rbmvbqpvPb3pnzvKRLZ+UpFdVSwZ8TpDepA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060098
X-Proofpoint-ORIG-GUID: -qCTfph8u1erz3i49U7RkyKDfaemSbbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA5OCBTYWx0ZWRfXzkJgoU17Vr02
 WD0xCGGLNNnxRUPmkMTFc93m87sJO4sbIfVghJ/4mWffiiJaM8YWJT4acU8Lxqu7D5GEX6q/S6X
 Jc+mW5G+IZCXueOpxdqlnuQFD3KpSrLyiiv+VvHtRBmAeT4I/tQtynhgbu7uctnJ+ofXf8BWCvG
 /u1WaD2mUUQM1/S/IzprvsuXBqp1itxZ3h8gNT4H0205eLSR9qLDHGZuiBai3wFAkVhOpaPiSuk
 Dr+kFEVNBE6lJYR8rombEpPv52bSg32Lb2mW6tyImNPrs4lvOaJmYgbTmc3ba2iuNCb6N/jfinN
 V2pK+CLrUmMEmgq28ER5lqJYmVmgQD6NJHxOOJD74UIrTJP5WQs2aDIV+gArIVRChDLrqx+b5kk
 zbqzwB9f+Sg/DEWFJLHRMJzyD4leeeaT9XDDsynzy8WWtgnH4kn2xk2yU3iqOBypk2Od+yS5aQy
 LfNTbia8oVLifr7ulcg==
X-Authority-Analysis: v=2.4 cv=E9XAZKdl c=1 sm=1 tr=0 ts=695cf186 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lhyzHd8ud8RGLmNTnBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -qCTfph8u1erz3i49U7RkyKDfaemSbbl

On 06/01/2026 10:50, Vitaliy Filippov wrote:
>> If a user follows the current rules, they will not get a write which
>> spans multiple extents and hence no -EINVAL. That is how it works for
>> ext4, anyway.
> 
> What if he makes a sparse file by writing at random 64 kb aligned
> offsets and then trying to overwrite 128 KB atomically? He'll still
> get EINVAL as I understand.

For ext4, the maximum atomic write size is limited to the bigalloc 
cluster size. Disk blocks are allocated to this cluster size granularity 
and alignment. As such, a properly aligned atomic write <= cluster size 
can never span discontiguous disk blocks.

