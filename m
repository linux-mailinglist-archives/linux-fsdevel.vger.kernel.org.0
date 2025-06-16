Return-Path: <linux-fsdevel+bounces-51700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F90ADA63F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D87F188E5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 02:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FF263C69;
	Mon, 16 Jun 2025 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="uylmDTBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96602BE65;
	Mon, 16 Jun 2025 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750040228; cv=fail; b=NLpxWqEz1kJfWdpo0zFOyX4Bx7d46Kpfwde0nXDqpTDZUuGsHYVvXMD4zQ6GFyEy2+i2L9rThwyaKubtmS45T+/N9SGmAx8d9mOiaOR2PA4s7uVP3TE9u9gVOBg6wRaUSToFXhya86LKKJbsCgjNjj+LdN2Yqys4NooKSjyjuQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750040228; c=relaxed/simple;
	bh=jIgclQwQCfKSqOjZJ7LVexQGmTgzYIZdisfCpfP6lGk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4a9RShpyOKta7QLxl0p6epf64nrllSX7K5ZdOWfYKeyC09f+eF6r98iGgwr+HahEKLzaaWnRUAu17/5d4TGBrx5DWutr+aIHTh+pfWPTum9pzt9cyBpMdZ1cH8rrK8G9uWTm7OIrJ5U/cNvA8Rc3h3YQH05elIEvu6wJ1pDkfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=uylmDTBG; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316040.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G0RQ15019162;
	Sun, 15 Jun 2025 21:16:58 -0500
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 479ux4jum3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 21:16:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgV5tIpecQFOFXpnoj6zP5fXtJHA/36OZ3VNEVDe/oHx1ioub7yywdAOto0afCmT0kU5Z2lWU3ymI+YhRiQQW2WOYlH6mJHTRF2IACA/VdfE5GwzVMM2pYiJEWghFwK8oOPuQk2DlFgiAuBJgx55unXBMuL/uvdHfyOJEnvMQGMOgt0/lEvfeOW8aSLyKt29CeYte2AC5CUThWtJlaRIkdJJ2X5o/AzJeZkFdbVYidnMwpT0n95g4a+cHbsTnCud9j40SbCz1NLVIJ9YllSj41LgSyNQb4+EZhDV6Lgy2X9N8fuYa+OTHVtM/MsC3lAvkoJQiRHqqcORwiAMeEmoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuhCw9oHZrGS+Qk8C/0XxMZmdid9IfWFZmTjJ4x/l2M=;
 b=AgDcYZ5YuUn22JSWhBSOR9uGM6A2PKgNT3q2W8T/HHiI01QBd6LbvIAHbjCpabvJc+TxYAobuuqKLk9TO880IIlQZgOYZtfDcQPrLGUQzreU9RWdKfFXiZcBRgWKqrVpnVhfB3nd+u++j75Cw7AQLQ708PT0KRKBwQEP4pBiKlCXun6sCQ35zuqNtZUjnd8C1tMwkQti0MnVj0ppKBsFF5rz+oXrRFgQiIccyJigRSNOzOV0DBmPxHhS3QmMhFFkszZuoVABfg9lrvTem416mSPtYUYTy6k4lWCoUsMMd8DY9TRi5tdGguXtyOhHs6D0Gixurw50hxpWOaiKG+yYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuhCw9oHZrGS+Qk8C/0XxMZmdid9IfWFZmTjJ4x/l2M=;
 b=uylmDTBGRMZUJUxMCFaatE7+/q83AiaU6ktYPw0Wm4fwiGHN5sLNpdE11F2pFinV7O+6ooYxlTsCAIwkzdIrHDxliSBQyQmssHdq4FkUuiziErpLvRProvRdTs+YLmSCm4s+34G0FzCatOUONorYRY8RrcC4FM7YU1y0GUgXaXQWI8V/xOJhm8xt3Wlg9JuTAfR2vDl/2P2gU1aSbDbzneUYIbNTtRczDgM/BloeVTJOga4E5oKH+4nBzhJfnU3kgguhDhbZiL8Il6EUdCRfNBzX3+zp/2v16YREpgX+5TDe9Cg+GV4AeDKW6Z5aCoXttBRZ+B47A9baGcnfyNfLjA==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by PH0PR06MB7952.namprd06.prod.outlook.com (2603:10b6:510:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 02:16:55 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 02:16:55 +0000
Message-ID: <fd087bc3-879f-4444-b4ad-601a3632d138@cs.wisc.edu>
Date: Sun, 15 Jun 2025 21:16:53 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/1] docs/vfs: update references to i_mutex to i_rwsem
From: Junxuan Liao <ljx@cs.wisc.edu>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
Content-Language: en-US
Autocrypt: addr=ljx@cs.wisc.edu; keydata=
 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
 1LHI6us+ZjzkMldzphVeBsBvT0hcR7u3cA==
In-Reply-To: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:610:33::32) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|PH0PR06MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: ae501699-3d78-4480-eefb-08ddac7bdd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|41320700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lGZi9HMWFYSVhzRkJVQUNhNGQzVFNIanIvWEpYZzVrS0hValppWnZuYWl4?=
 =?utf-8?B?cG5adGY0MjBvamxBNzl2bXh1V2lFNFBicURucnJKZjhVREZjVlFyWlBzbEI5?=
 =?utf-8?B?cWZNa2w1cW5YdG96UkVLMGc5cmU0UGNvb3FiZXU5NDVnbnQvb2xoa3Y2LzRt?=
 =?utf-8?B?RGVmL09VYkhHQjlxRTBjWFdHOGZqd1p3NUJZZHJoNDR2cHdsbFBIL2d5VWk1?=
 =?utf-8?B?ZGZkcVphb2orbzc5ZlV5Y1lCeDlidXRjYWhUMC9GdkJwcmNNZVphd29qZ0Zx?=
 =?utf-8?B?bVAvcTRBQW10QWdPdytwa1pnbXZGTnI3WU9qS3JyaHlxbmgvNGRhV0NoeHZt?=
 =?utf-8?B?eE9VUmZ0TGt4OUJwYXRUUDJKaTJzU3hLRFQ2VXB5aEwrZFRCalUxSFBRcUtL?=
 =?utf-8?B?WEpNZFRjckpWcTVlaTVjd1lERGVhQlhqSDVjWGtVWFZaSzNjbnIrRi85ZXBp?=
 =?utf-8?B?ZnQ3S2pNdWU1S2QraEM1ZDdKNk54VXlSQmlZN3F0RDluMjN3WlFqOEdDbXpy?=
 =?utf-8?B?Zm5pNnE1UW5vNGl5QzdYdEFNTndLdFl1WkZqWWVURkl2TFN1ajZHTTBQRnhn?=
 =?utf-8?B?aFN1U0Z1VlR0MXM3eTd5WEJEU045ZzZ2bkhTdmQyNGtaSTBrUzRPWk9yVXoz?=
 =?utf-8?B?c0x0ZkFlQ00rT1ZodFpKTmREWTdzQ1hRTFZOditxOWZEQkZEZWY2Qk4wUDlG?=
 =?utf-8?B?d0ltMThlU3N0N0RBVmJqNEhCM1E5ejRhQk9YYUtXTU4wNk1tem1wQmljcjdB?=
 =?utf-8?B?bVBwRVcwMk5VYVhMajU1OThMQjB1YXp0ZmNBczY3ZEFCMDRDUFJ5OHUzcXF0?=
 =?utf-8?B?L3F4bi9IL2w0dTlxOWVvRjV6YmRjK0dmWmExSVgwek81SWs4Q2VzSmtjY0Vi?=
 =?utf-8?B?UFVwQ3lhZGdFblBicXlhZWZ4S1dVVW0xZjQ0cWlaaEpzaUdWdzVCaDZSa1FQ?=
 =?utf-8?B?T2hFME1zQm9sbkVSRG0zNTNuTkxWTXRTd2s2dTVzNWpCSmtsQWRLbjRFdDVI?=
 =?utf-8?B?U1F4a05icmJYdzNoVmN3OEwyRkgrUDQxUjlyNzE1R0FnRHIyZHo1UVFudFpw?=
 =?utf-8?B?eG1DckFqdGhpaXpTWkJnUUpsVWJCWkZGWVQ2SFIzVVMyVmhuSDEwM05NbTBl?=
 =?utf-8?B?ODVGS0hjekVBVkZRSFNIaC9SQndNdUQ1M2MyY0JjOFh5dWQxQjZzMzZ6MWdl?=
 =?utf-8?B?NlZpOWI4cGJEVjV4eThxR2lWTUtxWG5ZY1lYU3ZtNzZ0M2V2REo4NFp5ekxG?=
 =?utf-8?B?NHUxY1dJeGNlTXhTN0ViMjhKcHkzMG0xYjBRL0YxWkkvZGVweEZObDVRSVY1?=
 =?utf-8?B?M3NpalNyMmtWLzhucVFEL0xFL3BkVC9wbUUzYzQ0UlhrU1l4SEFKNTJVVXF6?=
 =?utf-8?B?QW1hQ3pTdzBlUXBtLzRnQnc0Yyt0SzhtREtFS2F1SWJlR0VhK0pLS20vZE5l?=
 =?utf-8?B?N2VVd1grUVBYUXBYd2ZRZnRyZklpK1hhZkI5WGVqZm43WFVGZXVLVHdBRDFo?=
 =?utf-8?B?Yml6enlPQUwweXpwV3FDSG5TTTJDS0RVa0E2eUV5cXRJUGU2T3BYNDN4WXAr?=
 =?utf-8?B?ZlpjTytqZk42cXRNQlR2RTJYaEp6RWZyNWxBSGtOSVJSSkt3dTZyQUJMbkdH?=
 =?utf-8?B?L09OUElRNFFUOUhkbGRldjRISWhIWnNNdndXM2VTeHd1UWMydjdBeUpVQjl1?=
 =?utf-8?B?VkN6SlhwVjdma2x1cHVQZXY4MGVkRUJodHZ2UzNlNk1VVmZKS3JabTdxWms1?=
 =?utf-8?B?dmdhRjN4R2wrY2R1VUEzLzJCVnFQYStZZHY5aEt2RklHSzN3OTd3cUJ4dDJY?=
 =?utf-8?B?bzZoV25PYTgvVUg4N1R2SXRVUWhzTjhRVTA3RGlyajFHQUFITVFSSjNhc1pq?=
 =?utf-8?B?RTFDdkp3STdwclRrY1B6VytCL2xmR0ZDYm1aVHlnSmI0MzVnSjdCaHgvNlA3?=
 =?utf-8?Q?yZt9HshQ66U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(41320700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3EzQnY3N0VVNG91TGtWWG1KSGp5SlZzU0V2WWpxcTNrV1h5bkU1cmZuQUUv?=
 =?utf-8?B?SGpEeWE2RmlNVGlJOGh2TC82czc2RTVlZXR6ZXo2aDY5dHJBcGxYRm1peVp6?=
 =?utf-8?B?OHluUzFUM1BjaXExOGpBa0xCL0l3RnRTMnZaMmNaQkRUTGJ3NTBBSE5HQzhV?=
 =?utf-8?B?QXNra1ZjdGtJL3pQeWx0V25CdmIzaDZrT0lQZlA0a3drUGVTSk9UMWl0SjF0?=
 =?utf-8?B?c2FFUjRhV2ZSQmZtblZqOXI0M2tXYVdRVDlkdklrOVlISHNXbjFxaVJrNVZN?=
 =?utf-8?B?MjEvZ0xQV2RGbHljdXV4dWg2amZmWFpudUZFWnloeXVVZGhKYWJXSDVuc2o3?=
 =?utf-8?B?bzN4eHNUc1FtZTBaYlVlU3o4eWRrK1QxRld2OUNicStneDhmQnh2eE4xSEdB?=
 =?utf-8?B?TEYrdzN5TEh4aEdtTHF2UTdzOVMzZlFScTFCSE1uQll2YlMzTFVZL3hTWGVJ?=
 =?utf-8?B?UXo3aC9lTFM3UEgzczBoOExlVys4eXA4cXljV2lVZUk4MVBJdTd6Y1pkNXZy?=
 =?utf-8?B?N1h3aWtrSEFvOFd2K25Tc081R3pWSUZreDdUdzlrbzVtWXVIYmgvN3dxNG9F?=
 =?utf-8?B?SGRSeFpoZjZTNmRhK1J4NzU0ZnRWYlZQdmZjQVhIQ0RPMUU2bndVZ0hOdDJU?=
 =?utf-8?B?Y25XZThVcUFYTmN5VlkvRHh6UndyOHVqdHNGR1N2SEtNZ1dLWFgrOVovK2Y2?=
 =?utf-8?B?cmZYR0JpZVV2ZHNJWFRUSlpMeUI1YXZ6QjlSZFE2cDRMVjlyNGtSa3NjYmhP?=
 =?utf-8?B?WXdKZlF3ckxmZ3RUZW5ENUljVjZXOVVPanNBSFNueXBkRmlVc1A3V2xmSk5W?=
 =?utf-8?B?ZVRKTk1iK1FqbTRBQjVsWlJDQlNDR0dyemdNTWgvYldNMGl1bFpDTjZXZVF5?=
 =?utf-8?B?dVhYQzRyV0FHTGVyeklZL3RiQzV6Z3Z0c1BPRERQOUdsK3d0U3VkRXJKYVBM?=
 =?utf-8?B?emxnN1VQT0FMOE9zSW9iV1RjMWdrckc2UnkvYjg5U3ljc2xrbVpuVzhRUzJR?=
 =?utf-8?B?U2U0a1dkY1ZSNzRzYjlmbUpFaTA1bnBVbHpvUC9Pajd4allQc2pNS0l4RStR?=
 =?utf-8?B?UUpmTUNkNkhIVk56b3JFVU1PeTVTTUZHL3IvMjAwaURhejlJK1FNMTRWakVM?=
 =?utf-8?B?eUdUd0JrUzZEczZTQTFpeHB4WUpFMCt2cjMrNGFVeGlmdCtDK3NNZHVmd2E1?=
 =?utf-8?B?SWpnNHdidkhjb2srQjVYbTFydUxQVnd4VkMrdFJNZVJId0sxUkUwZHcySytB?=
 =?utf-8?B?UEprMlAwakJrNXhMQlpvemh5dVNDamhtTzEwcG1lbExRdGx4U3owUStSWEZ5?=
 =?utf-8?B?KzB0d2ppeVp3WnJscDNhT3Jkd1FCdmt5ejhLaHhBbXR2Z3JCOWF1N2VSbU4y?=
 =?utf-8?B?TDlxUTlJSTRPQkdmVldubFlkcWZjQzNSdmxyRVhrVzM4dzUrT2hFWVN4QjZU?=
 =?utf-8?B?am1KUWh3S3duK3R6TGhBSFlJOVpIdkxvVnEvM2ZnSU9pWmRrb2xwcTRKQkxO?=
 =?utf-8?B?UFpqYUI3K3FsQk1OVjJGSlJFT0UzY0NkYTRJcytrWEcrd1RoK0tMeitGVXVw?=
 =?utf-8?B?L2xlWkQ5VHJOalVnQ1plZG5DL2RhZWpYakllS09yYmJiL1FKenp6ZUlvZnho?=
 =?utf-8?B?Z05yUURrNitTd3JIbWdWK0JzWXJPRWZMeVRxQmhBemI2QVJOVis1NGtrc2Z4?=
 =?utf-8?B?ZStXMnIzc0E5V2tXajZ6UGdNWi83R0ZPemRrYjZCSEtRWml2SHRHYnMweU0x?=
 =?utf-8?B?c2J4a2dRemVMNlZFdHV4V0l2SU1KdFR2NWcrclhmbmFCTVViUjJKNlJTZDRU?=
 =?utf-8?B?TDgwN0hLK1JpTnhiOXlzaGRKOWVEL1RYSEhEZmV5Tk1NNmJINXZET0o3ZjA3?=
 =?utf-8?B?TTNlQnlYam5QNGtSZU1hUTJETExFSnlFVjZsSlN0dEhZODZqWENPSTgyaGs5?=
 =?utf-8?B?L3pXZWZQdy9kYkpENXJ5S0l5eE03eUpNaldzZFlJc0xUeXFUdUJVbXIybzBU?=
 =?utf-8?B?UWpSSEY3TWZTZlBiS1pabTdReGtMaU9uL0lhb1BPRnM2QkdobGg4WkcxODNU?=
 =?utf-8?B?dGlpMTNseUtDVXVLQ0JvdzVFakZHNTZ3L1RKcFNSR1haVUFmdThnSyswREQw?=
 =?utf-8?B?YkFTRzVEUGZFRXVCQXJOd1BRa1JoWWlUL25Eby82Sk1YeVFsN2NNaDlUUk9D?=
 =?utf-8?Q?Ni+5wAJzETY9q5RVcg24W9GZuCv0n5Bb+ne0l6kwap83?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae501699-3d78-4480-eefb-08ddac7bdd6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 02:16:55.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxhZhK6GUfaNPq7JYe+d/wlfMwWSXygbT3AsvnJqU4DUxZrkR2MRMGTB97JWhuKYWXJpR9jk4sQthfVskMUzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7952
X-Proofpoint-GUID: 6bijrX3-3InZzGqaB8-z333iX0A6Ik4S
X-Proofpoint-ORIG-GUID: 6bijrX3-3InZzGqaB8-z333iX0A6Ik4S
X-Authority-Analysis: v=2.4 cv=L44dQ/T8 c=1 sm=1 tr=0 ts=684f7e99 cx=c_pps a=kza0H2G5rmQD+2VTu+diIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=XVr8AifxcDK4vI3q51AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAxNCBTYWx0ZWRfXy2KDZwyfL8IN vH+1r/yljo6U0Zff7IM78rjJSaP1AqzPx0zjB0dnClmyfDMqCfAj1NKoOV/qqlYWQkhgyi2heVP +nCzcxJ/+u6xN9f8w+BIz9lgWZ3IZLdSbqY4ezpxpGdR0Yl1T/qEcNyZfTKQQJtx+ISzAQfyaNt
 lNQugXKxDqsV/wNo41gE3EjiRlZk8i2kYV/4/rkqOxKdfNRI/y4rNDyR/K8NcmvzL96VF4PqjEP 3UmADtO4D6G0IisD+cE4cnPETIXsSMfqCYsdgCEEKaSyeQPUDVuTPcGUuHBfbvY3CO3K7yaPZ2w qesOpv3ddxZ1Ye0nVLqnP0xoH1BtLyclGY65lRnATSLmej5DKrtQLvD3PXAdj40sWjaDGsrhYOj
 0T7/O86HoT3aRcE4KG5woBtk1DdVFdtP9Ti9I8cPXvdj+y2CbxXpS411ekTSXHVmbvdfU1uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160014

VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
lookups actual switch to rwsem), but the VFS documentation and comments
still has references to i_mutex.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
---
 Documentation/filesystems/vfs.rst |  2 +-
 fs/attr.c                         | 10 +++++-----
 fs/buffer.c                       |  2 +-
 fs/dcache.c                       |  4 ++--
 fs/direct-io.c                    |  8 ++++----
 fs/inode.c                        |  9 ++++-----
 fs/libfs.c                        |  5 +++--
 fs/locks.c                        |  2 +-
 fs/namei.c                        | 22 +++++++++++-----------
 fs/namespace.c                    |  2 +-
 fs/stack.c                        |  4 ++--
 fs/xattr.c                        |  2 +-
 include/linux/exportfs.h          |  4 ++--
 include/linux/fs.h                |  6 +++---
 include/linux/fs_stack.h          |  2 +-
 include/linux/quotaops.h          |  2 +-
 16 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fd32a9a17bfb..a09c4aab9b5b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -759,7 +759,7 @@ dirty_folio to write data into the address_space, and
 writepages to writeback data to storage.
 
 Adding and removing pages to/from an address_space is protected by the
-inode's i_mutex.
+inode's i_rwsem.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
 typically remains set until writepages asks for it to be written.  This
diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03..3a3881d3147f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -230,7 +230,7 @@ EXPORT_SYMBOL(setattr_prepare);
  * @inode:	the inode to be truncated
  * @offset:	the new size to assign to the inode
  *
- * inode_newsize_ok must be called with i_mutex held.
+ * inode_newsize_ok must be called with i_rwsem held.
  *
  * inode_newsize_ok will check filesystem limits and ulimits to check that the
  * new inode size is within limits. inode_newsize_ok will also send SIGXFSZ
@@ -318,7 +318,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
- * setattr_copy must be called with i_mutex held.
+ * setattr_copy must be called with i_rwsem held exclusively.
  *
  * setattr_copy updates the inode's metadata with that specified
  * in attr on idmapped mounts. Necessary permission checks to determine
@@ -403,13 +403,13 @@ EXPORT_SYMBOL(may_setattr);
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
  *
- * The caller must hold the i_mutex on the affected object.
+ * The caller must hold the i_rwsem exclusively on the affected object.
  *
  * If notify_change discovers a delegation in need of breaking,
  * it will return -EWOULDBLOCK and return a reference to the inode in
  * delegated_inode.  The caller should then break the delegation and
  * retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -456,7 +456,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (S_ISLNK(inode->i_mode))
 			return -EOPNOTSUPP;
 
-		/* Flag setting protected by i_mutex */
+		/* Flag setting protected by i_rwsem */
 		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..137a5d05238f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2610,7 +2610,7 @@ EXPORT_SYMBOL(cont_write_begin);
  * holes and correct delalloc and unwritten extent mapping on filesystems that
  * support these features.
  *
- * We are not allowed to take the i_mutex here so we have to play games to
+ * We are not allowed to take the i_rwsem here so we have to play games to
  * protect against truncate races as the page could now be beyond EOF.  Because
  * truncate writes the inode size before removing pages, once we have the
  * page lock we can determine safely if the page is beyond EOF. If it is not
diff --git a/fs/dcache.c b/fs/dcache.c
index 03d58b2d4fa3..0b67b4eb2983 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2776,7 +2776,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
  *
  * Update the dcache to reflect the move of a file name. Negative
  * dcache entries should not be moved in this way. Caller must hold
- * rename_lock, the i_mutex of the source and target directories,
+ * rename_lock, the i_rwsem of the source and target directories,
  * and the sb->s_vfs_rename_mutex if they differ. See lock_rename().
  */
 static void __d_move(struct dentry *dentry, struct dentry *target,
@@ -2923,7 +2923,7 @@ struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
  * This helper attempts to cope with remotely renamed directories
  *
  * It assumes that the caller is already holding
- * dentry->d_parent->d_inode->i_mutex, and rename_lock
+ * dentry->d_parent->d_inode->i_rwsem, and rename_lock
  *
  * Note: If ever the locking in lock_rename() changes, then please
  * remember to update this too...
diff --git a/fs/direct-io.c b/fs/direct-io.c
index bbd05f1a2145..1694ee9a9382 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1083,8 +1083,8 @@ static inline int drop_refcount(struct dio *dio)
  * The locking rules are governed by the flags parameter:
  *  - if the flags value contains DIO_LOCKING we use a fancy locking
  *    scheme for dumb filesystems.
- *    For writes this function is called under i_mutex and returns with
- *    i_mutex held, for reads, i_mutex is not held on entry, but it is
+ *    For writes this function is called under i_rwsem and returns with
+ *    i_rwsem held, for reads, i_rwsem is not held on entry, but it is
  *    taken and dropped again before returning.
  *  - if the flags value does NOT contain DIO_LOCKING we don't use any
  *    internal locking but rather rely on the filesystem to synchronize
@@ -1094,7 +1094,7 @@ static inline int drop_refcount(struct dio *dio)
  * counter before starting direct I/O, and decrement it once we are done.
  * Truncate can wait for it to reach zero to provide exclusion.  It is
  * expected that filesystem provide exclusion between new direct I/O
- * and truncates.  For DIO_LOCKING filesystems this is done by i_mutex,
+ * and truncates.  For DIO_LOCKING filesystems this is done by i_rwsem,
  * but other filesystems need to take care of this on their own.
  *
  * NOTE: if you pass "sdio" to anything by pointer make sure that function
@@ -1279,7 +1279,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	/*
 	 * All block lookups have been performed. For READ requests
-	 * we can let i_mutex go now that its achieved its purpose
+	 * we can let i_rwsem go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
 	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..a0150e2ef22a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1158,9 +1158,8 @@ void lockdep_annotate_inode_mutex_key(struct inode *inode)
 		/* Set new key only if filesystem hasn't already changed it */
 		if (lockdep_match_class(&inode->i_rwsem, &type->i_mutex_key)) {
 			/*
-			 * ensure nobody is actually holding i_mutex
+			 * ensure nobody is actually holding i_rwsem
 			 */
-			// mutex_destroy(&inode->i_mutex);
 			init_rwsem(&inode->i_rwsem);
 			lockdep_set_class(&inode->i_rwsem,
 					  &type->i_mutex_dir_key);
@@ -2615,7 +2614,7 @@ EXPORT_SYMBOL(inode_dio_finished);
  * proceed with a truncate or equivalent operation.
  *
  * Must be called under a lock that serializes taking new references
- * to i_dio_count, usually by inode->i_mutex.
+ * to i_dio_count, usually by inode->i_rwsem.
  */
 void inode_dio_wait(struct inode *inode)
 {
@@ -2633,7 +2632,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
 /*
  * inode_set_flags - atomically set some inode flags
  *
- * Note: the caller should be holding i_mutex, or else be sure that
+ * Note: the caller should be holding i_rwsem exclusively, or else be sure that
  * they have exclusive access to the inode structure (i.e., while the
  * inode is being instantiated).  The reason for the cmpxchg() loop
  * --- which wouldn't be necessary if all code paths which modify
@@ -2641,7 +2640,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
  * code path which doesn't today so we use cmpxchg() out of an abundance
  * of caution.
  *
- * In the long run, i_mutex is overkill, and we should probably look
+ * In the long run, i_rwsem is overkill, and we should probably look
  * at using the i_lock spinlock to protect i_flags, and then make sure
  * it is so documented in include/linux/fs.h and that all code follows
  * the locking convention!!
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..4d1862f589e8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -946,7 +946,8 @@ EXPORT_SYMBOL(simple_write_begin);
  * simple_write_end does the minimum needed for updating a folio after
  * writing is done. It has the same API signature as the .write_end of
  * address_space_operations vector. So it can just be set onto .write_end for
- * FSes that don't need any other processing. i_mutex is assumed to be held.
+ * FSes that don't need any other processing. i_rwsem is assumed to be held
+ * exclusively.
  * Block based filesystems should use generic_write_end().
  * NOTE: Even though i_size might get updated by this function, mark_inode_dirty
  * is not called, so a filesystem that actually does store data in .write_inode
@@ -973,7 +974,7 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
 	}
 	/*
 	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
+	 * cannot change under us because we hold the i_rwsem.
 	 */
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
diff --git a/fs/locks.c b/fs/locks.c
index f96024feab17..559f02aa4172 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1794,7 +1794,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 
 	/*
 	 * In the delegation case we need mutual exclusion with
-	 * a number of operations that take the i_mutex.  We trylock
+	 * a number of operations that take the i_rwsem.  We trylock
 	 * because delegations are an optional optimization, and if
 	 * there's some chance of a conflict--we'd rather not
 	 * bother, maybe that's a sign this just isn't a good file to
diff --git a/fs/namei.c b/fs/namei.c
index 019073162b8a..827f53b8f8cb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1469,7 +1469,7 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 	int ret = 0;
 
 	while (flags & DCACHE_MANAGED_DENTRY) {
-		/* Allow the filesystem to manage the transit without i_mutex
+		/* Allow the filesystem to manage the transit without i_rwsem
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
 			ret = path->dentry->d_op->d_manage(path, false);
@@ -2937,7 +2937,7 @@ EXPORT_SYMBOL(try_lookup_noperm);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.  It does no permission checking.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_noperm(struct qstr *name, struct dentry *base)
 {
@@ -2963,7 +2963,7 @@ EXPORT_SYMBOL(lookup_noperm);
  *
  * This can be used for in-kernel filesystem clients such as file servers.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *name,
 			  struct dentry *base)
@@ -4542,13 +4542,13 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
  *
- * The caller must hold dir->i_mutex.
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
  * return a reference to the inode in delegated_inode.  The caller
  * should then break the delegation on that inode and retry.  Because
  * breaking a delegation may take a long time, the caller should drop
- * dir->i_mutex before doing so.
+ * dir->i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4607,7 +4607,7 @@ EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
- * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * directory's i_rwsem.  Truncate can take a long time if there is a lot of
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
@@ -4785,13 +4785,13 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
  *
- * The caller must hold dir->i_mutex
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_link discovers a delegation on the to-be-linked file in need
  * of breaking, it will return -EWOULDBLOCK and return a reference to the
  * inode in delegated_inode.  The caller should then break the delegation
  * and retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4987,7 +4987,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
  *	   and source (if it's a non-directory or a subdirectory that moves to
  *	   different parent).
- *	   And that - after we got ->i_mutex on parents (until then we don't know
+ *	   And that - after we got ->i_rwsem on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
  *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
@@ -4999,9 +4999,9 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
  *	   we'd better make sure that there's no link(2) for them.
  *	d) conversion from fhandle to dentry may come in the wrong moment - when
- *	   we are removing the target. Solution: we will have to grab ->i_mutex
+ *	   we are removing the target. Solution: we will have to grab ->i_rwsem
  *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
- *	   ->i_mutex on parents, which works but leads to some truly excessive
+ *	   ->i_rwsem on parents, which works but leads to some truly excessive
  *	   locking].
  */
 int vfs_rename(struct renamedata *rd)
diff --git a/fs/namespace.c b/fs/namespace.c
index e13d9ab4f564..8a1bfdf862f8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2053,7 +2053,7 @@ static int do_umount(struct mount *mnt, int flags)
  * detach_mounts allows lazily unmounting those mounts instead of
  * leaking them.
  *
- * The caller may hold dentry->d_inode->i_mutex.
+ * The caller may hold dentry->d_inode->i_rwsem.
  */
 void __detach_mounts(struct dentry *dentry)
 {
diff --git a/fs/stack.c b/fs/stack.c
index f18920119944..d8c782e064e3 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -3,7 +3,7 @@
 #include <linux/fs.h>
 #include <linux/fs_stack.h>
 
-/* does _NOT_ require i_mutex to be held.
+/* does _NOT_ require i_rwsem to be held.
  *
  * This function cannot be inlined since i_size_{read,write} is rather
  * heavy-weight on 32-bit systems
@@ -41,7 +41,7 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 	 * If CONFIG_SMP or CONFIG_PREEMPTION on 32-bit, it's vital for
 	 * fsstack_copy_inode_size() to hold some lock around
 	 * i_size_write(), otherwise i_size_read() may spin forever (see
-	 * include/linux/fs.h).  We don't necessarily hold i_mutex when this
+	 * include/linux/fs.h).  We don't necessarily hold i_rwsem when this
 	 * is called, so take i_lock for that case.
 	 *
 	 * And if on 32-bit, continue our effort to keep the two halves of
diff --git a/fs/xattr.c b/fs/xattr.c
index 600ae97969cf..8851a5ef34f5 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *
  *  returns the result of the internal setxattr or setsecurity operations.
  *
- *  This function requires the caller to lock the inode's i_mutex before it
+ *  This function requires the caller to lock the inode's i_rwsem before it
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 25c4a5afbd44..cfb0dd1ea49c 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -230,7 +230,7 @@ struct handle_to_path_ctx {
  *    directory.  The name should be stored in the @name (with the
  *    understanding that it is already pointing to a %NAME_MAX+1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
- *    or error.  @get_name will be called without @parent->i_mutex held.
+ *    or error.  @get_name will be called without @parent->i_rwsem held.
  *
  * get_parent:
  *    @get_parent should find the parent directory for the given @child which
@@ -247,7 +247,7 @@ struct handle_to_path_ctx {
  *    @commit_metadata should commit metadata changes to stable storage.
  *
  * Locking rules:
- *    get_parent is called with child->d_inode->i_mutex down
+ *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)
  */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16f40a6f8264..84475c75c9e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -839,7 +839,7 @@ static inline void inode_fake_hash(struct inode *inode)
 }
 
 /*
- * inode->i_mutex nesting subclasses for the lock validator:
+ * inode->i_rwsem nesting subclasses for the lock validator:
  *
  * 0: the object of the current VFS operation
  * 1: parent
@@ -991,7 +991,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 
 /*
  * NOTE: unlike i_size_read(), i_size_write() does need locking around it
- * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
+ * (normally i_rwsem), otherwise on 32bit/SMP an update of i_size_seqcount
  * can be lost, resulting in subsequent i_size_read() calls spinning forever.
  */
 static inline void i_size_write(struct inode *inode, loff_t i_size)
@@ -1923,7 +1923,7 @@ static inline void sb_end_intwrite(struct super_block *sb)
  * freeze protection should be the outermost lock. In particular, we have:
  *
  * sb_start_write
- *   -> i_mutex			(write path, truncate, directory ops, ...)
+ *   -> i_rwsem			(write path, truncate, directory ops, ...)
  *   -> s_umount		(freeze_super, thaw_super)
  */
 static inline void sb_start_write(struct super_block *sb)
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 2b1f74b24070..0cc2fa283305 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -3,7 +3,7 @@
 #define _LINUX_FS_STACK_H
 
 /* This file defines generic functions used primarily by stackable
- * filesystems; none of these functions require i_mutex to be held.
+ * filesystems; none of these functions require i_rwsem to be held.
  */
 
 #include <linux/fs.h>
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 06cc8888199e..c334f82ed385 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -19,7 +19,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 	return &sb->s_dquot;
 }
 
-/* i_mutex must being held */
+/* i_rwsem must being held */
 static inline bool is_quota_modification(struct mnt_idmap *idmap,
 					 struct inode *inode, struct iattr *ia)
 {
-- 
2.49.0


