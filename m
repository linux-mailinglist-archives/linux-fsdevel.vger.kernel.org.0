Return-Path: <linux-fsdevel+bounces-64223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50ABDDCD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FC35035F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2B31A7F3;
	Wed, 15 Oct 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ZZepedHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5931A57F
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520713; cv=fail; b=R+635J0foVdLkSH1Wde1EMqj2v70+xFzW7pXVQ8BqmMXR7Zb9d3k4ELQNqqWXd3l6DbMmuRz1tT9nNswMe0yY27fEVwqeN35qOYGigX05nuJSucqkFfgFVcsQ6/s/TDG1U/0PdtmGPgtlh06xHBQWUy4NLX4GwPF2RKWKLsZUo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520713; c=relaxed/simple;
	bh=NpVfiNfuoDfhDrBjxARtsc6jv2dla71sTF+2khiGFj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bymu9PgEBVxGxVJWVh31eTNEuSoEfLPtumfLCk2bNiJyntxLaTaF64xtiCaSQuwMr5LWToal4qS0FXgYIwQUS7u+4NPyCP6xh5RpejHiQyERq7Pm+i/XecMR0HM54trzA7SgTCQdQ540zVub8OAnfJos/d00ZPbVdep4dx7cjWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ZZepedHC; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023137.outbound.protection.outlook.com [40.93.201.137]) by mx-outbound11-36.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Oct 2025 09:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA/IgbBzwEtm24kpNVnW1ubVhRZj6vKeSpsVyEl/XVU5II38g2C2egeUv8I73SIL1LGPylAKE5yhNyP1uQckIHwVlKWJkepRJfE4zVyYCssCMdJgefz62yeXIhFbNHMdcUL0dDrRHqeoSMFUZQZVZmoYWxrhQaMEchASrDwCoP4TAjeEvH2bRHb1L0YLq6Sa0wfkmQLftazRsEBfN1/UHLDXaQfPOpTxhT8Jg6eGFr80yqpcBoqdukD0LFVAv+jXrnKxoawQS2UW4w1GghFRplqd/VHaJbQoYar6sBUh9ehd5MJN0BQHVpWQtcCF4uoKW+VrafPTfpVapV19r/K/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYg1JmRaLnpqs9Zhk/vQayr2K9hTUBe0TqIst9ltr64=;
 b=bsTIANK5wxoVxasaaMJrmHhmYpes423imki2VUR/fkmmt8H7Y8ULTQZHuXqglAKXzFWuDnvVRhAFhr3KkE0lrk7myjPHm51qVJqAb2cQZ7iJMc5QAWJOewn7oPAR3ykXpFPNYurLU3maSDRwrO6NktNu+cRFqJgSzUUnVIfIXuMT943IneKbzxdEbGhdfIE4kerv3bTzxzXaLifmke/moAk1z4CS0DDgjuKaB4ywYxSx1uc1L/eqwpYumzKIb4Yq54/fNqY3rEM4V/xbgn/GVOY6ehCxh5/fQO6ZhEQzHu/2SczQuWn71W3UIOxBKqFFeOobNmYDLleQPmtq5Hhy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYg1JmRaLnpqs9Zhk/vQayr2K9hTUBe0TqIst9ltr64=;
 b=ZZepedHCx47op7h0kOKePQmzYWLP/RRGWXmwfU72vUsYT2gIsAUYVnBVsPYpElonMQxmv2y8fIVv6SMWAkgwm7uI2rYYDOI/BM0V5/1f1fBYzpc2bn2x1Cn9M1m9lGmqawTgLQWpla3QhlhaK+0xbzk1wGs+ujwsvK4n0Rn6GA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH0PR19MB4774.namprd19.prod.outlook.com (2603:10b6:510:25::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 09:31:38 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:31:38 +0000
Message-ID: <deb8a813-0a15-4870-a8c7-e57f0109fdfe@ddn.com>
Date: Wed, 15 Oct 2025 11:31:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] fuse: {io-uring} Allow reduced number of ring
 queues
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong
 <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Gang He <dchg2000@gmail.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-5-6d87c8aa31ae@ddn.com>
 <87o6q88qje.fsf@igalia.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <87o6q88qje.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::15) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH0PR19MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 63007090-f30a-48e1-eff4-08de0bcda3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1AwTnZEV2c4WGl1TVRPYWIxbjNVVnRIa2NlUVV5OGxRVEZYeUVtdEZHazZn?=
 =?utf-8?B?L2EyUjZ1RzFFUHNMMGJsZDRyN3VsM25IN1hwWXhGT2kvLzF1RHRraE1nNE43?=
 =?utf-8?B?UE52dDM4Q1g4ZE42L2NjUktuZG5KejV0MGk1bGI0blRWUmpGeEZMRkw5RXIv?=
 =?utf-8?B?RjJUaHFkb0twMmdEOHNsRmttSWhkcHExYWNSRkNGOUgrV3J2cWdOQ1VscWlI?=
 =?utf-8?B?Q3ZaYXF5R3BlV1c0d2J6czkrQnVxSCtVY0VFNlBoTTBnbEJsVXR0Q2ZhUi9J?=
 =?utf-8?B?Um1CTUFBd0FtSnN5Ly82MlNOOGM5akhiMW1yZjNVNzdqNEZhVXhESjBtSXlU?=
 =?utf-8?B?R0VWV1BpOUZ3UTNIeFcxQUEzOUFWaFR2Tks3UHFsMGYrYXZTOGhZZ2hWV2ZO?=
 =?utf-8?B?ZzhCd3k3TEZ0Q0w1b3FkYlJ4MXI0VEdUUVZMV24zd2JJdG40dndqSGZmaGx0?=
 =?utf-8?B?UFdJcnZmdE1nVXN6bVhVbGZpcTBsckZCOTZVeEVJYVQ5bzRTVDdrMW9pUUJ4?=
 =?utf-8?B?MkM1UlFNVkhvKzV4cFp5eElpTm5RbEJzNGRmTVhXanhiMndoVVcrZGZ4bksy?=
 =?utf-8?B?NFNKcEdZTGE2MWRtQmh0OG92ZkhTVE41UXl1cmhhRjB1UWJyL2hXb2pNRlI1?=
 =?utf-8?B?TFUwV2JUS1pHRVQ3SVllWlpSUWRNcy9SMmNPcHlmeDUvZDhHRnNEbnRmT212?=
 =?utf-8?B?YS9uUVdJT01aYndUMjVLUjJPOUE2aGdSYnRpR01XbW1sdjJFdkxFMzFnY2No?=
 =?utf-8?B?Si9kZXRHSWdNTUtwRXRjdm53cnZnb3VXOHVjQVIzS2NUWHU0eDhSTDQxY3lI?=
 =?utf-8?B?UW1lT1FYMjFqb2ROdmNRbVF0ZTc5emxlRjV2YW9jMnZCa1pUOE4xd2FqTGJP?=
 =?utf-8?B?OGMweko4WlJCZ0plV2ZSSHFXVi9kVWtXNEltdmR3cXpSVmJ4eUhZWjBjTXYv?=
 =?utf-8?B?OHdXZkFFMlBHendhK0hzTzk5VGJTditvQ2MzVEw5eVFBQXk0dmNOdDcxeURt?=
 =?utf-8?B?ME54V3hRVXh5OTFZTVNNVkQ4VTd4Y0EwOUsvNE5zdllvU3NWWDk0L2NySzha?=
 =?utf-8?B?UVFtTmI0MkEvNTlWN014UU1uaDZZZ0hDbm45ZGpxMU52SWRtelk1UkRsTnhL?=
 =?utf-8?B?YUIzTTl1R255NDZnNkRISUhyQlBqRzlwL1dnTFkxY1JJMHF0Njc0S21Ha29W?=
 =?utf-8?B?UGFpa1c5TUVMU2xHV3gvd0VuZzcxY2lHVmZQYWtkMTlZZE9Nb0dObTEraE9U?=
 =?utf-8?B?YnZoTzFCd2hsMDJDUC8waWlwcGoyaXJXNGlRYmp0eHluK3piV091dHluNmN5?=
 =?utf-8?B?dHRZZzIzd2Znd0doZHN2VkdvR2dkcTdRR05uOWNsZVN1RzR1cmNQZkk5NnVs?=
 =?utf-8?B?L3VmU0xWRGV3cWxUVHBFOWRPY05RUmNWb0hoZmFRbVI1ay9DK01Fb1BDcC9B?=
 =?utf-8?B?dlU2WTFyZi9GOTRmMTEwTEpuNTJ3UXNmQlhEOTJuY2Q4U0ZSZVJHTjh2UFRt?=
 =?utf-8?B?WnorUXpRaUpTZjFaeThTWDkyWFNNNVc5bzZJMDRCeGpXdDFtZkdzYjhVOSt3?=
 =?utf-8?B?K1B4ZmRHK3B1ZkRxRUYrdHNlOXZuTG1JbnlESEpkK1N4VG52Vi8vRkQvRVNz?=
 =?utf-8?B?WC9BUlJGbVp4WENlY1BOcFJGaXhhVHBCMkY3czZHV0dmSkkxRjVnbDZIQmI0?=
 =?utf-8?B?N1NIeDBSSmZha3JUeDNGckZPUXEra21Ld3pDRisrbWVrQktnN241NXJnOGxR?=
 =?utf-8?B?dThXejNtMS9oRE5YNWl4TGhYNnpyempDd2NKaDBJRFZQZWRNaUVPQkNNcjY5?=
 =?utf-8?B?SHc4WUk3SE1pREszazNhdXNRbkhRV1JzYVlTK1BUbW1kRTl2bGExMCt1REh5?=
 =?utf-8?B?YTlQSHc0ei9jcFdVSnhWYVc3anNXLzhmSUhFS0ZuL0FObU1yMFQxb2NnTHRi?=
 =?utf-8?B?NHB3NVVCblBMSXgvNmF0c3ZJTFEzWFRDbEwxclpBRkVNcHQyYmUyVTQ2OTZ2?=
 =?utf-8?B?Z2xycDc0L3V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VDamg5UDlTWDVhNUZYdFJKUkZPbkI3Q0dXTXlaa1Jjb0l0TjBvbTRXck1w?=
 =?utf-8?B?MDdhay9aSkxWbG5iSmNIV1BsWHoyQWFTcUJJRWlUaDduMUh4T2piWDhqOGs2?=
 =?utf-8?B?ZEtsK3NvK2JGUUtNTGZ6aDRQRDdFNjNnaEx4NDZRRG5taDBnNjVmQzZDT2F1?=
 =?utf-8?B?K3pWTVVja3BwUjE2K3ZuOTBwWExUVFhpMCtZREtkNnNaWG9nSTIyVGlKQkdu?=
 =?utf-8?B?azJTaWhOYlNMRTNTSCsvMTNrcXJTUnRmQmxKS2hHYXJQdktlVDB4UTZYQ0Zs?=
 =?utf-8?B?SDdmSzFIWVhvSkVzcUJFYlgyaU9hdDA5c2JybTVpTG5BaGdBV0ovZUNQcFdS?=
 =?utf-8?B?ejk5bnhWbmhiMTF6ZGdsanVaMndvZTQ4MzI5OC9RU3Yrek1la3RLaGxGcmdP?=
 =?utf-8?B?UG44MFZLdWtkRmJuUUVvcEsxd1lhVlZKcmcwWnhFb3U1a3dOTGQrbVkzTWdN?=
 =?utf-8?B?eVVVcWN5VmxPMkl4WmNRdTNINlpPd29DV0ZuNVlJa25Tb09zd0FiaFA5NG8z?=
 =?utf-8?B?MGxMNTFBdThWM1A2bHU1VWxPVmtHWUxFb3JGckk3V3hReWp3cTN1cGowdGFW?=
 =?utf-8?B?bmpRcTBxcGEzVjhBbTBHOC83RnVIdVJQK2l6U2xoRStaVC9LUjFTVkFyYTg2?=
 =?utf-8?B?S0Jmb0QxeVJBbFVSNC9RMWs2QTg3a2l0Tm1SZ3B5ZnA3dGp4dWN0QmhuMmRH?=
 =?utf-8?B?UVUzV0YxTVpUcDgyYlg1Ti83UWRvTTRWNnZNYTloZU96T1lpUWIxcFlSMnhP?=
 =?utf-8?B?bngxS1ZLMldrc0p2ZHZaeXo5eWpIaEtpRC9IYlZVc1RzWGNUUWtiazQybm5m?=
 =?utf-8?B?MGJPQldGeTZuOVRUU21nRGozUXhrNlNhaFNwTlZiMUV2T2xqOTlpZE90L1Uw?=
 =?utf-8?B?dW5QaDNvQ1p0clpvbExrMGpkVWZSOVI1Tk1IaGFRQXRSSUNLOHl2Tlc5cGFG?=
 =?utf-8?B?V3BTN2IxcUptNlFyWHJvVGxra3Ara2tSN3lXZkYrL0VSWDZnUnYwU2ZOZ1Q5?=
 =?utf-8?B?WU9sMnB6ZFV4bytLaUJiVWU3dENJaEo2b1NKVWJsWlZFNTFHQzBPeFFDR0lh?=
 =?utf-8?B?dm42ZG1oaEtqU2Y2YkFSSCtFSFpTVzFmNkdUSE9yVDM5RjNrMXlGNUp5M1Vv?=
 =?utf-8?B?SGlJWUQvZDhJY25WanR3ckRKVkVoMGxBVFAxelkvQVNqZFNmTWY3bURaYjBG?=
 =?utf-8?B?V1pYSlN0RENQelNNRVk3ODUyZ1ZjMVBWUHBCYVRlNDBhYlh3WGI1M3kzMllu?=
 =?utf-8?B?dFI1RTVub2tWTmFuWk1QV1lxQTNRY0w4d3ZTTmtwTzFkekg2ZkNwWXhEZnFL?=
 =?utf-8?B?Rlh0bUVKdjNuNm9Td1NGMWthMnBQNk5jb1NXL0MyazBjM2xKOTluQ05xclZQ?=
 =?utf-8?B?ZUVrYTZJUCtiYUpWWktUNnBRVzJvZ3YzbkRRcnJzb2VNTitYNFRNNWdSNVcr?=
 =?utf-8?B?dkw4YVA1bXAvZTMxaUF0TFMxeXJKc2RMbXJ1UmZCVkFOeC8wUUVRSFlCZmF5?=
 =?utf-8?B?TEwxWXVVYUlqM3hJSFMvQTRpTFphVnI5YjlvMVRkc0JCQ3MwRkRseC9hdlJj?=
 =?utf-8?B?NFBJajd6VzNtRWI1Nkl3czBQTHpPUHlydHdhWVVtbysyd0J6YnYyMUFucG5y?=
 =?utf-8?B?UklvV0s2QWhwc2FYd2crVDJxTWhmb2RaSklGdG5JK2FaTTNQNFNqMkhEU2lT?=
 =?utf-8?B?aFA5Z0RDL3NnM1VWaVcyYXBoVXRPSGx5akdFWFRxYlB5TkEwbnRUY0NEbnJW?=
 =?utf-8?B?MXNXT0crdmUrOGp5SWtjT2NSMUZ6aHgvT2ZyMk03TFN6VmUwNm5uelJhbmM4?=
 =?utf-8?B?eGE4a3ZwZG9aWlZ0OWVDUkFsb0FwUkNQNUIraC9Fdy95ZFJJd1hKSGQ1UW9s?=
 =?utf-8?B?N254RFhQMkRhbnZnNktNZDVLWjROZloxYzdmRWswd3dWK0ZEY3Vqd1hISGh1?=
 =?utf-8?B?eWpoTXBLSmJ6TTF5UEN2OUI4Tm56YUVWWTdtV1kxWE53bFYvejhUcGp2TEpa?=
 =?utf-8?B?ajR0SHNIZkFub2ppbitqNjBjUkd1WUY3ZWE4U3RtcUVtWUJndi9CcTF5bG1Y?=
 =?utf-8?B?RC9za1B0Vjh4aXNlWTVtaEVuUE9VZU5OQS9xYlhvb0dlY3FDWmFZVWZtdjF6?=
 =?utf-8?B?YWhqUnhvQkdYMGZuSDBYZnNtaVBmcVZyTVF5ak5ZRGtETVV3V083OXMvTWNY?=
 =?utf-8?Q?H5844wVNN0LBeTMdLccBVt2OIMzDTQ8xK404BVkipNQD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WpmI/nldrs0gYNJbU2bc04vtSEZN90tomNHEW1amS25aFBp+cYYTz9rZQGChL6braDw3S2wiE+59U+8iinJmx8aLUyyqvhj7NkgORhJn+P6ySZih8DlC1PYJJ5f8IV5KxJtFJDTUNhI4ZHmEJbZ2xpNbyWDGoBuH/8KHIRTSHKuEqBoNKNybx/53HlYlKcTeurONTD3y3A7ghtj7UiP9H7lteg2gyCwYQZzIQ/y6GMEqeSsJ/hwkaZ4xlexozg7M1O9Ww4Z+0KDT5q29aXPOIG5XsXInHQXi89xvFwCRNhK4LSC3LmbrTrd0/8xbxmoWwMxVKw1RAfRvSibr0KNjrnaGP14/WmUaZdB2kbPx67gjO5zurccLE7zfWKxl2bx4ISWZGV1fUbwoSCnnBahtRaoaduXOUtODeSP10ScwCVZVzfB/Os+B97VG7EZYbxjH3op91az4xSxj1Guazct8EwCvh5/GEHUYOR/+ikROYS8KfNCcppwO7KPPhM8+YSkqoE+kWr3KxXAlfKqRHiqeoqWPuoi2i64LzHuIis5LUf4CB1ccxE14uK8tssfYixcIGwKbjfhVXV4sjBx0Sybqu1yV5Q1cHaFIn52IZONScXEKInGbHWu4BiDM12S2LFV7oKQ+2m8PpESqnaqplrEyTw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63007090-f30a-48e1-eff4-08de0bcda3b5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:31:38.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOZhZNIt5zYX3crOhSdgShxboU6UXOgS/4aW8pOCjlJa/zbks2xIZEMedJDqlZDzTcVtOUd8FXZfbFzn7rQRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4774
X-BESS-ID: 1760520700-102852-8482-9031-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.201.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGphZAVgZQ0MgkNcXC1NQ82T
	TVLNUyNdkozczC1MLQ0NzMINHE2CRNqTYWAHGHi1JBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268222 [from 
	cloudscan8-131.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 10/15/25 11:25, Luis Henriques wrote:
> On Mon, Oct 13 2025, Bernd Schubert wrote:
> 
>> Queues selection (fuse_uring_get_queue) can handle reduced number
>> queues - using io-uring is possible now even with a single
>> queue and entry.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev_uring.c       | 35 +++--------------------------------
>>  fs/fuse/inode.c           |  2 +-
>>  include/uapi/linux/fuse.h |  3 +++
>>  3 files changed, 7 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 92401adecf813b1c4570d925718be772c8f02975..aca71ce5632efd1d80e3ac0ad4e81ac1536dbc47 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -999,31 +999,6 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>>  	return 0;
>>  }
>>  
>> -static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
>> -{
>> -	int qid;
>> -	struct fuse_ring_queue *queue;
>> -	bool ready = true;
>> -
>> -	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
>> -		if (current_qid == qid)
>> -			continue;
>> -
>> -		queue = ring->queues[qid];
>> -		if (!queue) {
>> -			ready = false;
>> -			break;
>> -		}
>> -
>> -		spin_lock(&queue->lock);
>> -		if (list_empty(&queue->ent_avail_queue))
>> -			ready = false;
>> -		spin_unlock(&queue->lock);
>> -	}
>> -
>> -	return ready;
>> -}
>> -
>>  /*
>>   * fuse_uring_req_fetch command handling
>>   */
>> @@ -1051,13 +1026,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>>  	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
>>  
>>  	if (!ring->ready) {
>> -		bool ready = is_ring_ready(ring, queue->qid);
>> -
>> -		if (ready) {
>> -			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
>> -			WRITE_ONCE(ring->ready, true);
>> -			wake_up_all(&fc->blocked_waitq);
>> -		}
>> +		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
>> +		WRITE_ONCE(ring->ready, true);
>> +		wake_up_all(&fc->blocked_waitq);
>>  	}
>>  }
>>  
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index d1babf56f25470fcc08fe400467b3450e8b7464a..3f97cc307b4d77e12334180731589c579b2eb7a2 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1503,7 +1503,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
>>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>>  		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
>> -		FUSE_REQUEST_TIMEOUT;
>> +		FUSE_REQUEST_TIMEOUT | FUSE_URING_REDUCED_Q;
>>  #ifdef CONFIG_FUSE_DAX
>>  	if (fm->fc->dax)
>>  		flags |= FUSE_MAP_ALIGNMENT;
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index c13e1f9a2f12bd39f535188cb5466688eba42263..3da20d9bba1cb6336734511d21da9f64cea0e720 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -448,6 +448,8 @@ struct fuse_file_lock {
>>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>>   *			 init_out.request_timeout contains the timeout (in secs)
>> + * FUSE_URING_REDUCED_Q: Client (kernel) supports less queues - Server is free
>> + *			 to register between 1 and nr-core io-uring queues
>>   */
>>  #define FUSE_ASYNC_READ		(1 << 0)
>>  #define FUSE_POSIX_LOCKS	(1 << 1)
>> @@ -495,6 +497,7 @@ struct fuse_file_lock {
>>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
>> +#define FUSE_URING_REDUCED_Q (1ULL << 43)
> 
> This flag doesn't seem to be used anywhere.  Should it be removed, or will
> there be any usage for it?

Hi Luis,

thanks for your reviews! I had forgotten to update the commit message,
the introduction patch [0/6] has it

- Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
  about the possibility to reduced queues


except in the corresponding libfuse branch
(https://github.com/bsbernd/libfuse/tree/uring-reduce-nr-queues),
there won't be any user of it. That branch also needs to be updated.
Basically, fuse-server cannot unconditionally reduce the number of
queues - on a kernel that does not have the queue-reduction feature,
it would cause a blocking mount point, because fuse-client/kernel
would wait for every core to get a queue registration.


Thanks,
Bernd

