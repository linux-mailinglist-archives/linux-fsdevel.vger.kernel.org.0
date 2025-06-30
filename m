Return-Path: <linux-fsdevel+bounces-53368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0EAEE177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B897AA808
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909A28BABC;
	Mon, 30 Jun 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W529JHUh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zo5ZiQjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDE25F975;
	Mon, 30 Jun 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295060; cv=fail; b=d0tcJ3sU6QLqtk5QJ69BL/e6DefTfyzBDL13z8WmeduPNFJ+mJ3uVrxZG4kEVKYJsL027Tydvfqo1BuAhjnKaPgMEugpvVTyZF+jtZlad/7U+fSSWS6o4TDztiMaOaQ5mqW5AF5httFoEvstEQEawb4KS5RoPo+sCOnkxeIEn7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295060; c=relaxed/simple;
	bh=SGyZP/B1AYip8fGs9U2VunFaZBobx+1/ZhO1z7mxt10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTZdzcFJM+sScrTBjUly+ww1SPJ1yoLmlkkgbR/UyDyx1G+YRg7/XOW9aqSkCgBUTyVixdp7RnowEDc71hBC1tzd6sN49Bx7xOxxdNXn4U2oxwPZTPKkIvZhpFs24NOdS3qa4AwCpHrhRhSGXuMnRW117KS9TGdbZsNWSisLjzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W529JHUh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zo5ZiQjO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UElBvq020140;
	Mon, 30 Jun 2025 14:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xJe+XunjM88JfBxJI8ntRVd2zfTHIzFTA2fi/MiAZ48=; b=
	W529JHUht/XMg8xNKjgLdDMBIkq416z8qD3wGe9fpe4ao1K2JZMkgtTE2u68x57c
	mgfNZQNC9zrLhEtHbPHMhGcVHT/vt17Y64K2zNLlk/Szgo2SXRCNPSilSQ8XhgSD
	9DllMxyJvv9NDirBpcDiSfkp8Nr10wRbtTRV3vG4AWyuZvqjPALjy/6PnWf50f8M
	Rj7kotf96sBBcxjqaLwnBXsjXz0QkFSQAmeTgF/Gdl/36tOC5C8VI9TFG5DZaDrc
	VVAn8vWZ+Km+0QU1VHE1MjyW37vjswROJR2EZ3HzxIexJcYKDTmsN0ch0U54eT9p
	3YDKmgPzW1vS4C35jjj8yw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7t0u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 14:50:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE3WIu025759;
	Mon, 30 Jun 2025 14:50:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8ebng-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 14:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzwFbxZErC57iDezH0OSoOIwLq5RZvXIn9erPaeQnM8b35mRBQS8LuzncUIY8NdaH7jvekNxDV9wlRmnNWUaQlkIKkwJy0Z0QL1kSN04XioV3gJab2g7hsu/JG4FiT96AG2dIiKI4TBLuogG3OE8CKAfKi1V88iRQHhHECT/NP65sPheL9DNr3RNfOArbY6rmtdG1c0pgWp53kf5ofBA6ZMaNq6hX4TP23lsgt97vvesLf5HgbtDKN1ld6Nx3PU/g7RhGZhNig2sZMho1xjxg2xi9M2z6ZubTT7cuRp0D1l4h4ZYDw6Ss8QN2yzdjDf5GHRs8cj7vGOL4msPeJOwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJe+XunjM88JfBxJI8ntRVd2zfTHIzFTA2fi/MiAZ48=;
 b=I42nJt93Kztah27idbKMVtFdB0N3ep5n23sVJ280sJGlvGA+3QMmksE0nJOtuUjB2KiOiz4wfmYPvOFcPQWWDVJwNv3aMHfZ5oAG5/N8OARSaHgYjA8IRtL3xrXA3DwEHOlHo55332ZMh6wbXybEXYgZGRf+gdcUWzdQI/GK7QGIoQz1iwOsAEIfODTSYkka/tnUH6mqowGjJDh9m42gk8HxjHvZ/2IVjoaf/ccndyNy6BI4qODGLCCCAHikh/pEnjyy3lQzbzV+tffR5n+6lKROEV0ppp1jlJ4eV4NiEGBscCXkv+/vqpNvSB8CP7RLxaYsn70Su+e0fOmyCXtHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJe+XunjM88JfBxJI8ntRVd2zfTHIzFTA2fi/MiAZ48=;
 b=zo5ZiQjOGvhOclHp0dAoAn4pGNrprmnQbATLbtKDzeuaxe14OHdiufq8j4HLUCCqy/obuM17ikOFaRFeSYifwlYuUYgzebM0E19Kfs9F1vVKc6BdcVH5s44C7xmzNoBzjDRk5ydDR/GDeBpOiTE4egrq5pXX93XUMkE/t5xu0Gg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4964.namprd10.prod.outlook.com (2603:10b6:208:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 14:50:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 14:50:44 +0000
Message-ID: <3f91b4eb-6a6b-4a81-bf4e-ba5f4d6b407f@oracle.com>
Date: Mon, 30 Jun 2025 10:50:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        keith.mannthey@hammerspace.com
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org> <aFGkV1ILAlmtpGVJ@kernel.org>
 <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>
 <aFRwvhM-wdQpTDin@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aFRwvhM-wdQpTDin@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:610:38::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 846c56a6-e564-4930-d2f3-08ddb7e57db6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bVAvcEpEZWhFeWttWUk1SkNRREVFVDJ3WmhHdkVNOTI0c2JBc2VNYk9PNTdD?=
 =?utf-8?B?QUZnMlhzSTM2VWtISi92UytOd3ZibHN6NDVqelJaY0lNamJNTldJZFRUWS8x?=
 =?utf-8?B?S1U1VGhPRFY0VzluZFBrV1BQL2MxWU5PbklmMnNzdGJzV2RmdGhzMmh3VUlG?=
 =?utf-8?B?QkZWemJEZkU0eGVRN2UxT2ZtbXlGUEJ2akVTTzhtRm5GaERKMU9pdTVuVUpj?=
 =?utf-8?B?VXNPWCtsU054MHZQN0xwTk13UllWSU83SGFzUVlYWG9HbFA3YTlJWVlqNWdD?=
 =?utf-8?B?bnFJOHJkL2ZQcU5EZDkyQzkrZytGUFJWcUlrVkNMc25TWUJRQ25aK1VySktE?=
 =?utf-8?B?cGxZc0RSZ0pTVkJ3bE82SkFSV3pDaU54RjNYUFBlckhIY2pLWW5RbEtUcm8v?=
 =?utf-8?B?TTI4c3JVVlFCb3NrRXdGSlZ2N2EvUmYrYytIWlZobmNyZjRRbFBHTTJ5NDUr?=
 =?utf-8?B?QnltalhIbTdQRjdlbDk1UTdlU3VPUFhwOGxQaDg4N2JkcndJVko1ZW01R0F4?=
 =?utf-8?B?OGVVVHkzcXhFMkphZzN4WjNHWWlSTWFQNm54aThSeXI0NUt3Rmp0Y0Y5QXdI?=
 =?utf-8?B?L3FQeVJFZGUveityS1JuMUhMbkNTZy9VRjFYaEpIRytta0l6amNiR2dHZGMz?=
 =?utf-8?B?aGE0VVRLUHplUW1vQzU0R21ZL21kRWVvdlUvVW85MmxQdmVkd2NGSWNva2d3?=
 =?utf-8?B?SFl6S0c3MENSN2NZWmpvcytjZXRBeXUwdi9ZVktDSWR5VnJhRnJEYlJEMnY5?=
 =?utf-8?B?MVRoMDNZbG9Hb05oTXNiZUczTysyTCtId2x4VEV5Tld2MFVndm1aMFRmVUJl?=
 =?utf-8?B?QmxBYk5ieGxwL1c4NlJNa3d0cFk0OVViUHJOcTUzN216b2NXRHVhZWNpbjhF?=
 =?utf-8?B?VkxneEljdVlXZkhHanFNV2gwdlVXR241M3VncEphQnc4YUxURVdFanhEMHk0?=
 =?utf-8?B?SnlYZkp4YTA0QVkzRXhwZjVvdytIUVVDVEJ3Sm51UnVEU24wSVJNdjIxSlRu?=
 =?utf-8?B?ZGNMd0paSFI5Q2xvOEozU09USFpEU3FKd0hmMVRBN3ZTV2YxbE0zem9FZHJ3?=
 =?utf-8?B?bVdoeU40ZDR1SFYyd3BnVmpHSVlscHFOK0VBMlJ1RlJsc2ZWYnpQV3QzZ0xh?=
 =?utf-8?B?VXVrbHpWZlVRSG0rVGw2elNiWmxIcS9yWUIvSFNaOEpzaG5jVFVQa2c3b2VT?=
 =?utf-8?B?VW02aS9IbVJXbG1tK3VyTllFK0JJNE9xSXRERUFpNmE0SUpzOEJROGVDSFpx?=
 =?utf-8?B?cEJrVEdDZjBFTnVSVW0xTS9kZnNPZXRPR3dCTURZMk4wOHNxbk1nSFMxcFJY?=
 =?utf-8?B?cDJXUTdKRlBRRjM0L1E4VnJVK2llTXRuNlNtQTMwR2UvZm1vTEtUdDBlQjdw?=
 =?utf-8?B?dlVGNjFxbDhkVzAvbVlub2M3dUtsNTZkN2YrMjM2RWF1cDNkSmYveG8rNzlY?=
 =?utf-8?B?bWs4T3BIWlYzNWNFZVVvZmhYSzlOWUFBQ2NtZ21JeDB5ajZONTVJbk5WVi9G?=
 =?utf-8?B?V0ozNlBFaTBuVTQzSUNEOGFFM2dVN2JjMmJwaGJqTUtQb1FDK2ZPQUdyeGNM?=
 =?utf-8?B?bW9HWGg4WnRxZ1VmbjZPTFIxd3hLRDRqdFNzZmROa2puL0RKT2JCWDdRcTNq?=
 =?utf-8?B?OGh4cmVzVG5Ed3QwWEZqUW5PZFEvaE92c1V3REszNEFHWTRPc01INWIrUGpC?=
 =?utf-8?B?T1RZb2ZSSVEyRVBiV0Q2SjR4Qm05c1hmaTgrZU9uQjh1RndWUVhuYXcwcUNG?=
 =?utf-8?B?eGtEREdLbHJDNXN5QlY5TGFwamNycHEvOGRUTW1sb2dvUFVzMmFWVk1qYms1?=
 =?utf-8?B?aXp1QXpyMWhneU5PVG5tdmRNWnFaMkc4SlRzNmVlbTR0NWVDV2cwaklDaGo2?=
 =?utf-8?Q?JGMxen8auH3gf?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dWV0ejlDREgzK1RRaGFBU3YwQlhQMjhleUZHL0VMZWk5UjNnQStrUmd4dU5y?=
 =?utf-8?B?cU82Ni9QTElxSnNTYlc3bkFlUnZiUUFPU1MreVFjWjFLV2Z4eTQ4NmVNOUZF?=
 =?utf-8?B?K0hiY1dTaVFpdzN3amlVU0laaFM2TkNZMEh5OHJIbnFDTXA5c2NoQTlMRlNn?=
 =?utf-8?B?MEFEejZkTGx6Ky9UbWdVc3I3TGhXOXVPMzhRSUQ5RjgycklTTkNNdkZXSE5i?=
 =?utf-8?B?MlQ2NStUK1M0bjNlWHVvN0o4TWp3VmNSTWxsZm1hUzkrL25iZWhDd01IMkZu?=
 =?utf-8?B?OFkzSjZoMVlOYjYySHd5U01FWDhJcjJvS0dwMVlJVmVxOC85NEVJSmFjbGd5?=
 =?utf-8?B?OTlPd3pyd0NSTFJkOGFJb1N1clc3NVI5ZW1MMjk0UTcyMzhHNGdrY0hheTdV?=
 =?utf-8?B?dW5ja1FlRFp5Y0x5MFcwUzhpazdFaXVybTNEMWRnVHB4OWpOYWgyRnZYSUZq?=
 =?utf-8?B?aWIrMmdsOTByek1PWHhWOGVKc3R6MzJkT2FMbGVNem4wUElySDBtcHhVajg4?=
 =?utf-8?B?blpyM2xMLy9zWjZmL1BlYWtrd2k2SWlNL2tTM0w4V293aEZGSlIzbTI3ekZQ?=
 =?utf-8?B?Qzk5VW1xTmhtTWVMU3BaWXNMMzRPaWR6czArTzAvMURRVERpY1lBWjN6NUVw?=
 =?utf-8?B?dzdhL0NnWnVNaURCSUUrdnoreEs5c0FhVG1ZZmcxT3EzQXlkN3JQNEtIWmxh?=
 =?utf-8?B?QU1RcDVURER6azlQRFNZM2xXTmZ3a2ZtVTRhMkVHUkdZUmF0Wm5sdVByYm53?=
 =?utf-8?B?V2hSaXNvSGhTYXo4NHg0WWxtdVVhWWdyRVAvU3JuSWpZOVNDdkVLT25EeXpZ?=
 =?utf-8?B?cGREdjNQSk14ZjZpOElaL3duRVJtMWZzVVhDUXNrc203R0hmNFBDWVJwUXZB?=
 =?utf-8?B?N0RDUVhlbW9XUTFrMTEwWHV0eDZBeWd2V3pwVWRMb2ZuY1JnT3F1TlpxOTV5?=
 =?utf-8?B?bjBLZ0dyMUtkNDNSNjAwR0NqcC94SnZ2NDRkY21WbUpsaE1sd3NzVUtyRXJV?=
 =?utf-8?B?MzZMdEtmdWRBYVFCUE1HQjQ3T2xURGJHUWtqVHV4QUE1eFFCeHBNL3E1QWtV?=
 =?utf-8?B?d1hvaWhmUEloaHJULzFFYzlKMTRObWNpOHdpeFlsZWxNZzhab1gzR0huOFFQ?=
 =?utf-8?B?YjVxQUpHdHZSMjVUZ0ZQdWZZQ1V0S1M0UHpIcDBBWDB6MWlzMDdIaW9UK21C?=
 =?utf-8?B?S1dLenVoRTBWbFNpSUZyUGRnNDhKWXFTRlpQUmhsL1NMMk5IdUVadXM2Vi9C?=
 =?utf-8?B?a2hva0ZxSmI1UHIrTktIeXJhekpmUnl3RmM3cm5UWTBybTBRMEpDUmZIZEs0?=
 =?utf-8?B?Y2ZLOFJnb1VVcG45cnM4Y095K3A4Um1hOFZ2M3pBcFJSdk5wWkt0ZWFsR1lN?=
 =?utf-8?B?UGpLQ2pYSWdFUFNtZVVPUk5Ib0dwMkIyNmxtMUNTaDk5aUMyazBPQmdFRVBJ?=
 =?utf-8?B?dGhCSXVkWUNCU3ZkcjhhcVlocEZ2QkhzclBmTkV4dWdiZDN3aFYrak5OMnBH?=
 =?utf-8?B?V1JWNU1aR244djRnVVRHVE5seEZaMTdjYWwvNUEwV1FNU3FNU2NPUm1lc3FH?=
 =?utf-8?B?ZUp4Rmo5WjJabjc1emFqWDZ2U1REQlpPTWFQTVpuWUY2TStyYU9wOWRkSzdH?=
 =?utf-8?B?VUU3MUdNUitXVEtUMlFBQnRIS2MzVFBIdFM5SUFlakJ4M0NjNmFpSU9Cajlq?=
 =?utf-8?B?Tlk1aS9wR1dLSG1JYnhBMll4bjlWWXJiamhkR09WQXJsMHY2TFkvR3I1V1VJ?=
 =?utf-8?B?Mm1vSmYrWG1EdmNiVWNRQUlQZXd1QXFzSjdjZWdjNFNsMktvTURpd2VvN2Z5?=
 =?utf-8?B?dFVBUzkwMnFzaC82eEFSTi9FbGwyOCtjRlRYVTVwL2FOYkRzVjVhaUo3QUk2?=
 =?utf-8?B?N25aMmVOZ3lYYzBBRElRWXY1VVVqZHl1ZTc2OU50RlNKbTRiaStrZGZibm84?=
 =?utf-8?B?KzVJSXJTU0V3WmZPbERHdUNYQytMcWN0cUkzV2ZoVkp1bmxrNUIzZlBGYVRm?=
 =?utf-8?B?OW9Kbm5CNWlvR1hxdm9CVzlIRUdacEZtU3hKU2dMR2R0dHVhL2VtbnQ4Z3RZ?=
 =?utf-8?B?QmZFM0NkNU1JaGJwVWpOK1ZDeXRrUnFXK0VYMytXckFjT2R5eXhHRElrejlw?=
 =?utf-8?B?TklCTEozUmtsR1hjdUI1aGg1ZWU2VzU4Sm9SY0dySjV2RDhEL0Y0WWtiQzBZ?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VpOf9y0rcSzl1lhZHMFp59xGDYi2h4nf6eDwWHzeAmG10rVnhemlIrLy0+VzKNPNmwdh7rOXrrGjKUNjt/DiM/wf8tDSmuSRkVu2Q+T28+mNnm2rnytibLHoIlig+gR6toPt5/H1niAyOBfCfvB1Gb1O4mzVboh7DwGuUoyd/wVKAmIqdLN0zjJBZNvqppFkc3S80Gyw0foDs7qDKEc2+jVdu37T8mUKhFpSry5vz5JD6rnDTpJTyCzLrov/wiyJcLHVX/7HvmHGPqe3jNDS5P/k6FgaocYHHdmCdRDnTExXvfzLjYkYOxass57vU9gci/mofcyvuUap+rg1Kgcfbsal8EUmXlMyhkyWlYdXcTk79/addue0wo8k3GGeNHJVkPeR2c9/Am+ex5Bdr6fIk69gVN/n3Ul7Iyg7sVNh34B3KfBRQPRcuXZ/rNJec48BCUyTIthJgQNkivHaxRCMcsDephmAmJav+GjrE2jm8EwigTNYx6/KbQ4lxHuqwU3vcAmdAwY/vyFh6tMOksx1fdP5VVef7bJ059nZwSnmEm4SSaQOrj/vydJj+kpwJLWeCqsfi8iEdqyB9ggc5wFbf/UZNHu36JN8tILq0c5T1nU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c56a6-e564-4930-d2f3-08ddb7e57db6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:50:44.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pqw48MT61R2fOh2ODjqfinXGjfsg1q+H2m2lvH/XNTjFkXmpK/tidum04RvLlEJPMsN54tBZPl2Yqha7Mu3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyMiBTYWx0ZWRfXy5uaXktLot/i +xij/VLafZ7dF/y5u6YZCfATeWC/DvPhW0+l2IuZuktX5Y0mJGV7ELm9t0Lt6ACX/fg3gkSNQsu QIfxFF75IW+3+JfSfRPjd75aWOzt1LUcwLo/K9qzmBeAxeAUhcX+P3az0II9T5f/0W97F2/kqjy
 +kvCR1s7emJs4Zx+f3C50TSsGa/YzYAryxw8W/3iNN62aeyRQkSjElBxV3A3dsvI6Qn8M5aDdJ6 8gUsZ0+XY4EQKjXNvhd7hzrHPhjTD6SYtfdrLuRnJ4s/b79ETwp7qgyLQGjr1IqpKVxCo+YZGX+ JThXebfYo9wfj30BxyJqUbGW37ldqhBjxYoWOLFCwtqbwgDOWIXi1JEbHTx/r04na6z9/LFff1v
 Oe53S72qGGUiByc0oZ3QBRFc5fQ3AE/lRBz1j9iSN2eWRGwzj2NC3B+sCxim7PV2PacSpueX
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862a44d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=WLGaNtMBAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=knZ8c7BkzbxX0UKG83QA:9 a=QEXdDO2ut3YA:10 a=gcKz3hfdHlw52KqWNJGX:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: dGT-3zQPBIfnVXxmO-72MKDpoolf_EcO
X-Proofpoint-GUID: dGT-3zQPBIfnVXxmO-72MKDpoolf_EcO

On 6/19/25 4:19 PM, Mike Snitzer wrote:
> On Tue, Jun 17, 2025 at 01:31:23PM -0400, Chuck Lever wrote:
>> On 6/17/25 1:22 PM, Mike Snitzer wrote:
>>> On Mon, Jun 16, 2025 at 12:10:38PM -0400, Mike Snitzer wrote:
>>>> On Mon, Jun 16, 2025 at 09:32:16AM -0400, Chuck Lever wrote:
>>>>> On 6/12/25 12:00 PM, Mike Snitzer wrote:
>>>>>> On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
>>>>>>> On 6/11/25 3:18 PM, Mike Snitzer wrote:
>>>>>>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>>>>>>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>>>>>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>>>>>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>>>>>>>>> or will be removed from the page cache upon completion (DONTCACHE).
>>>>>>>>>
>>>>>>>>> I thought we were going to do two switches: One for reads and one for
>>>>>>>>> writes? I could be misremembering.
>>>>>>>>
>>>>>>>> We did discuss the possibility of doing that.  Still can-do if that's
>>>>>>>> what you'd prefer.
>>>>>>>
>>>>>>> For our experimental interface, I think having read and write enablement
>>>>>>> as separate settings is wise, so please do that.
>>>>>>>
>>>>>>> One quibble, though: The name "enable_dontcache" might be directly
>>>>>>> meaningful to you, but I think others might find "enable_dont" to be
>>>>>>> oxymoronic. And, it ties the setting to a specific kernel technology:
>>>>>>> RWF_DONTCACHE.
>>>>>>>
>>>>>>> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
>>>>>>>
>>>>>>> They could each carry multiple settings:
>>>>>>>
>>>>>>> 0: Use page cache
>>>>>>> 1: Use RWF_DONTCACHE
>>>>>>> 2: Use O_DIRECT
>>>>>>>
>>>>>>> You can choose to implement any or all of the above three mechanisms.
>>>>>>
>>>>>> I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.
>>>>>
>>>>> For io_cache_read, either settings 1 and 2 need to set
>>>>> disable_splice_read, or the io_cache_read setting has to be considered
>>>>> by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
>>>>> splice read.
>>>>
>>>> Yes, I understand.
>>>>  
>>>>> However, it would be slightly nicer if we could decide whether splice
>>>>> read can be removed /before/ this series is merged. Can you get NFSD
>>>>> tested with IOR with disable_splice_read both enabled and disabled (no
>>>>> direct I/O)? Then we can compare the results to ensure that there is no
>>>>> negative performance impact for removing the splice read code.
>>>>
>>>> I can ask if we have a small window of opportunity to get this tested,
>>>> will let you know if so.
>>>>
>>>
>>> I was able to enlist the help of Keith (cc'd) to get some runs in to
>>> compare splice_read vs vectored read.  A picture is worth 1000 words:
>>> https://original.art/NFSD_splice_vs_buffered_read_IOR_EASY.jpg
>>>
>>> Left side is with splice_read running IOR_EASY with 48, 64, 96 PPN
>>> (Processes Per Node on each client) respectively.  Then the same
>>> IOR_EASY workload progression for buffered IO on the right side.
>>>
>>> 6x servers with 1TB memory and 48 cpus, each configured with 32 NFSD
>>> threads, with CPU pinning and 4M Read Ahead. 6x clients running IOR_EASY. 
>>>
>>> This was Keith's take on splice_read's benefits:
>>> - Is overall faster than buffered at any PPN.
>>> - Is able to scale higher with PPN (whereas buffered is flat).
>>> - Safe to say splice_read allows NFSD to do more IO then standard
>>>   buffered.
>>
>> I thank you and Keith for the data!
> 
> You're welcome.
>  
>>> (These results came _after_ I did the patch to remove all the
>>> splice_read related code from NFSD and SUNRPC.. while cathartic, alas
>>> it seems it isn't meant to be at this point.  I'll let you do the
>>> honors in the future if/when you deem splice_read worthy of removal.)
>>
>> If we were to make all NFS READ operations use O_DIRECT, then of course
>> NFSD's splice read should be removed at that point.
> 
> Yes, that makes sense.  I still need to try Christoph's idea (hope to
> do so over next 24hrs):
> https://lore.kernel.org/linux-nfs/aEu3o9imaQQF9vyg@infradead.org/
> 
> But for now, here is my latest NFSD O_DIRECT/DONTCACHE work, think of
> the top 6 commits as a preview of what'll be v2 of this series:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing

I was waiting for a series repost, but in the meantime...

The one thing that caught my eye was the relocation of fh_getattr().

- If fh_getattr() is to be moved to fs/nfsd/vfs.c, then it should be
  renamed nfsd_getattr() (or similar) to match the API naming
  convention in that file.

- If fh_getattr() is to keep its current name, then it should be
  moved to where the other fh_yada() functions reside, in
  fs/nfsd/nfsfh.c

In a private tree, I constructed a patch to do the latter. I can
post that for comment.


-- 
Chuck Lever

