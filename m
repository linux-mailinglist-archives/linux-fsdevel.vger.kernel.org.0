Return-Path: <linux-fsdevel+bounces-74920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFWDJRlDcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:20:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD65DF48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A50A66AB492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD83E9F88;
	Wed, 21 Jan 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="xPBy9J7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C4363C5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026946; cv=fail; b=mXqWZEz8GswuOaV0+ELBGHbGiHUrqiKDr9+wJBCScrtnd8hgQMEUbZnRhdaO3PtxmL17RvbFp6kvK396Sis2iw8mezUiYwm7SKUPo2F6uVwIUCl2nTRbxQf6fsUMjUUo8KIchfBTzHxjRJHHI26xt2JHvy8neOMj1Vo1qNhNgNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026946; c=relaxed/simple;
	bh=n2k1OICHVt5+XGzRwrvSEfpFGje6vREE6CuB72kpa8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QfFjyQbiOBYisilQYBa2GEIV879bMUUinMqDxY7oHntclL3YDN0ULOG9hFIiZ6dnoylHll0fnx6Ws2HMcsx/LhikVAnXGRZMtwwFmWYOdmTTBOZ8naTnPNUXYZk6EBUwzMreAyYM8jzgsX/NKNhAhtmUQuedhazYVUMVF2FTSxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=xPBy9J7o; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020086.outbound.protection.outlook.com [40.93.198.86]) by mx-outbound11-94.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 21 Jan 2026 20:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MquFJAmmM8o46Uc0wI9Pgm3Gm/guRVGeHgAi3JlEf2nQI9HCp1nZ2NmPzTslIOcFN3DXWFPS12zRwFF7RSRr4P7glPH3IonD4gl1XFPFkfEV1TsF7NJdd+xvzBvDTAalm9mGauwvZzXb8jPR3PbuB+oTHKRtahdCNt/ysHgaTEyNRgzQte+OKCdhbbske169h4vkRewneJZPT0ecFz9xy/T6SkGM7xjibO/hCV3nMQ+0jLjfbKPg38Cld7NZ06uc4U5TdFGqL5suQ3u4xMpgHtQVj9+Swh8z8fIlqihAAm6YG91CAwms/v55OJR2oxgciQo77ItnwU89JXaSPo55eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKX3edv9wvmCbj5WCdJI3NbbXDaKmyxw29+0fG5a+sY=;
 b=zBHW4ppElFpISoKaSjQoxwFNUJb4JUrlUGh6SQcMLUlppQlCwuJbmoAlJCmMicYaiNehXaTzob22npcnLdfm9tqil6bFeespf/B7m9SXBv0JXLmTgi//wSnK0+90iIQy9Kn/oMSZbEFOCboXmRNcXQ7sMHHn2iOXiOaIhYL+RLZMudVE9NfE0OFLd+cpksPZc+zDtTHmUH81gDEaFC9X2VkjQt5qZeCwgqKAt1wE+7lxBi6Oo3Qx7Wsqkk34937Q8EUfAj9KuNZ7wY0ASKbfZSE2JCVnJA1yoBIjOMSaBUEIdqeToYanyveutVXYKQYt4Pd0Jq8YAYsG/0zXnHb40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKX3edv9wvmCbj5WCdJI3NbbXDaKmyxw29+0fG5a+sY=;
 b=xPBy9J7oNaDJWuOjJ6ahOXrGBlsa3Uomoy7Glw7GwcjF3a4i23FQYGO8zd9OQ55lpD0GJf7/YYsfd4BRDZguu0orqBtPN/5cq4DDaGZjEEg8jhGarfWFdAQxvWmBju+gomxVVVBNX/s5lNEoVHRzd+Wg+/hbyMg3Uz1/Sz0cLN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BY3PR19MB5025.namprd19.prod.outlook.com (2603:10b6:a03:36e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 18:49:31 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 18:49:30 +0000
Message-ID: <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
Date: Wed, 21 Jan 2026 19:49:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, Amir Goldstein <amir73il@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com> <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp> <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com> <aXEbnMNbE4k6WI7j@fedora>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aXEbnMNbE4k6WI7j@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::22) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|BY3PR19MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4776ac-1edb-4856-827f-08de591dcf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?elNFYjg3QnZtZGpVWmtCOUJCRDRHb0E1bVgzakl4ZndkaU1OSkNUN3F4ZnI4?=
 =?utf-8?B?eUpJWjhpeVBPUlAwRVJ5QWoxMXRzVTVlcFFJYm13Q1lNZW1CMDNmS2JFT1d1?=
 =?utf-8?B?MWhCMGZnOG1hd2FacGl0enJpYklIcElWRldhWHBHQUdMZnl6SGlEZ3VGaW90?=
 =?utf-8?B?S0RsUjMxU0FWazVnZ01lU3o5dk5QeDRLU25UQWM4amtqUldvRkJqcFRpQXhY?=
 =?utf-8?B?QzJYUzc1R2cxSGFNQUlHZ3p1S0NjYnh3NjI4SmhyQ3AyWFpnTnJoSEVLYk9h?=
 =?utf-8?B?RUQ1QjJ2ZnpaZzgrRDJsWnB0U2kzOXpiZlV4UUpJTFZaNExFMTZkRWprZ3p2?=
 =?utf-8?B?N1N1a2lFRTZRVHh1WktvdnoxS01FVVpFeEtMbWdSb3FGQlYvVDFJUDhLNEdw?=
 =?utf-8?B?bkZHajJ1RzVPK29JUWhTaWJPajl5ZTZneGF5dm4xSkZHeWY2dVZwQ0RuY3l3?=
 =?utf-8?B?cDYvazYvSWxoVTNWZkxQeGEwdC9VUUVjR0lLcEdGSEZwd08wTGM0WjRlV0c4?=
 =?utf-8?B?eElpLzlyUjMyMXYvWGZtRXpwMDJoYzVFdXk0NkFWZkgxZXA3L2dnMkw3UDJG?=
 =?utf-8?B?VGZBSWY0eWVYM1g0b0FWalFRRDJ4L2FjV0hEQXk5TmdNNUtMcUxzbzFXRm9S?=
 =?utf-8?B?enpTK211dkNDSVQ2cmN3QktuM04rQzFQaVZMc24yeXhXUWUvbE5FSVNwVk9Y?=
 =?utf-8?B?cGpsUHVpbDVTeXdVTUpGSmRndldRSEVtYjlnTXoxWm9Sa2dLclZZQnUxK3l6?=
 =?utf-8?B?RmlQVnFkSElkT0hSZVEvbG5IeHVuMm11Vm4yU3pwWTFuaDNPZG4yVlQybmdl?=
 =?utf-8?B?cG92TXlMRXJjM2VNekdYNGZnTmZzNjhTVHJNdTF4Z0Rtdk5QUC9maGZHVlhx?=
 =?utf-8?B?ZCtaR0FudzdTQ243Yk1Wb3h1VHRnRFFLcGtyRVE4NkZBTUhtdDcyRjF1NCtl?=
 =?utf-8?B?Mk9JQTlBSys1WWR1NFI4WWpTOEhVN1hqUEFQK1B1dTlDc3RTQU1oVGRGNy9h?=
 =?utf-8?B?YkNQdEt6U2FuNU1KYmloVENBNC91TkZIbWx2eGxyY0VST1NhK2dmc1dBTldO?=
 =?utf-8?B?VElZaTFJamlXY1ZWUEJqMW1KelZZTDJteldGbW9jWThqRkdGUzR0NGNJQk5C?=
 =?utf-8?B?b3lBdGY1MHl3QlRLbXF4QU02VWlFRGd3UXJhTmFBeDV5eEtNcUNSSTh3cjI3?=
 =?utf-8?B?N2s5alBtZzE3NUFvNUZwdXJZZVN2UlNQNFlITHBnVTV5MzBURzZzMkdQZGdm?=
 =?utf-8?B?UHl5aU50QUZSWjBpZ1ZiLzVHNFRwMTJNcVZNajN3VUNBaksySHg3NlMreHQ4?=
 =?utf-8?B?cDdLSWliMm54SXBiUUZoUU1LbDBZQWJxUEYxckhwTTZSWHJqc2xlalArS2JW?=
 =?utf-8?B?N1JKYW5FOGRSTFVrOUhaNmVrUjVBTFZpRXUrUGdLWDZQbmtkcW1Od1hzNjJt?=
 =?utf-8?B?blo2SERhOGdtL0F1a1Z2WXpoYzBnOFlmeDdCRE44NTUrRjF0ZFdSTXdNSjRn?=
 =?utf-8?B?UWFaQVZpMGduVVU4ZkhZU3NhZmhSSTB2K3hVS3lOSXdQWmdhZlZaT090QkV2?=
 =?utf-8?B?ODVsMWI1QThBUUlOV1UyNWpLNWtQZjlkWUg5T001dHVIbktXaG5FT1l5MUY1?=
 =?utf-8?B?Z01pM0JMUlFSVHc3RkpMNkFnMjQwZ3haNDE3dC8zZ1UrSElzWWkxN3J2NHYw?=
 =?utf-8?B?Wk5EOGVrV0d3RFI3LytFL291bFZFMWZPeXdKQnNLU2dUeWJ0S1FDd3FlN1l6?=
 =?utf-8?B?N3VNaFpEYmIycVdRR0NIV3AvVUhlVEg5ZDZlZWg2RnhIR1dZSjU0K2ZTRGUr?=
 =?utf-8?B?N2IxVllPWWZRUWxQV2dpb3ltWklwdHMvVTg4bG9aK2hXY2RrUWJzVCs1cFg0?=
 =?utf-8?B?R2FXWTJDMkJSTHBEVkVOK3o1NnJ6M2JwSlI3U2l4cjd2RndFRE41Y244V3dU?=
 =?utf-8?B?SFkyKzI3TWoxaW1VQ3BHeUs4d1VDem8ybTNpQm5pcmd5OUUvTDNoNUZhcEV5?=
 =?utf-8?B?MkJWeUd0UHl4SG5YcVhiVGF5bXVaQU03a2ZBMXlOZm9ld2NiZGozT2tSYisr?=
 =?utf-8?B?NmVFclNGL3BiM01rNy9ZSUxVbG8rWEJLdUVaSEJnQVJlVkN0SlVubm91dGkx?=
 =?utf-8?Q?lKKk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a0oreFg1SEd5MTlteE5nS1RQK0s4VDZVOHBPeDIwbURRdHdTUnpyaFhpV3V4?=
 =?utf-8?B?WUtObzdXblpDM25NY0ZVRzZHMnhwZU9nRkorRmdJTWk3WkNCQTBhRFdQc3Yy?=
 =?utf-8?B?NGwyb3BiTCtFT0JTbDExL1cxQWNuQ1M3WXdsdEFaYW9VQ2pWTlQvaHJDN2lm?=
 =?utf-8?B?Nld1OEZjMmN0YWMzTTdrbWpQaU1WeHZjQnBpRFdXOXZiN25UWGcxVk53OWtC?=
 =?utf-8?B?azhiOFJNOTVNYjhlQjZPcWlaWktzRzlaWnFtR3ord0RkNndBNkpBYWVPNFhJ?=
 =?utf-8?B?OG1abCsyOW4zMm4ycEt5M2lnRGNWMUhKTlZhTFdJcFBZRjloR3doSG9KVjFy?=
 =?utf-8?B?TzBMcUNaL0JibHc5RVNGSGN4Sm03UVE1TGgwbDdUT1BjMjI5YWMyV1VINHhn?=
 =?utf-8?B?cFhuRVIyY3VYNENxTUl5S3lNVXJBSWdXUHExTlkraW4xd2poZmszc3hGdDFF?=
 =?utf-8?B?K2JvTWVYMGJOdEFBUEZwN3ZTdlZaL3VmNzN1aUdLZ1ZxekpEa1haYnMvZENP?=
 =?utf-8?B?eVEyN2hhWERIdVIyZE5hUTg5S2wzMEhZRnkwTzZjYTRRTmJIRU9vbzg2ZzBV?=
 =?utf-8?B?dlFEYnUwZmFTUVU4bXh2aTNQcWxsLzN3WlpTRFplTXBjNVVhQk1MUk52VER4?=
 =?utf-8?B?bityQVdLcXd0dytITE43SVVveG9lMlpMTnJON0UzSkpxZnFmMFdvaCszRTZM?=
 =?utf-8?B?c2I0NWt4K0FxMDlyKzNVNUUwTVZWMGMrTVR2N2JtakppQk91R0QzUHk4azBK?=
 =?utf-8?B?dUlBemp1YVN0Q1RVVHNvK21RK3NWS3hqaFBLOUNPTndJK1lNYm0xMGRHejUy?=
 =?utf-8?B?dFJoaDA1UVB3ZDlBMi9jQ0xoYkpjV3I5d2llZHFGSVdTRm1uY1M3dXVaYUpk?=
 =?utf-8?B?VTF6V1VGcGh6SGs3OFZBUmErcnhQS25UdjhFaHFjK1ZUSlJOM2ZEWjV1NWVp?=
 =?utf-8?B?bVJVZnBGSERyeXVMWlk2TzdTLzl0aUVyMzBMNHVlTVYreitkV1VCRTBMRk9F?=
 =?utf-8?B?eHd2dTQ4MWJ4cmJrNzlEb29qL29hTm5IbGgwS3lobE1jTi9YaFAyTldPcU5h?=
 =?utf-8?B?N1BTOEcwR1NjWS9Vb1VQWHpNZzR3TkUwOHhZYUZZQmNjNEVlVXF5UmZYa2tu?=
 =?utf-8?B?TFMzRVUyNC9zc3FWOEFZTEFPU0R1azFNS0dVZ0I4RVlBYi82OUVtL3kvWm9B?=
 =?utf-8?B?OGtDQll5Q29ZYWlKT3pXd3N5WldtbmVCb2cwaldFclFUYndKcGNvM205UU43?=
 =?utf-8?B?SmJaSU9rK0NVYVRTTXR2dTV0NnNpTnB6cTRNOEg0OFlhdzJPTDlxUG5WOEF0?=
 =?utf-8?B?QWpINm9XL2lJRW16SlVGemczbDQ3WHFHbVZIQm9iYVk3czBhU01GSSt3ODQw?=
 =?utf-8?B?dkJ6N20vS0NMa2hHMnpVRmpjOVBtYWlpSjhLN0o3R0U2WWwwY3ZHR2VpVmRw?=
 =?utf-8?B?WmtjMXdKbThRN2hxOGxuVFhYdkxFSHNRQTNRUWpLZGx0RmJGRlhtYVp1dkw4?=
 =?utf-8?B?ZWdzSWRLWmtYdnVOR2NEdjYxdGhCcHFwNVhiaG11bjZvUm1IMXdhMVRQUDNh?=
 =?utf-8?B?WllyUEg5dDNwaG96WnpNYlV4N0U2aVllVkFhNGpRU2ZmSlMrNmNtL1pRT05Y?=
 =?utf-8?B?VWxxTS9TWkFvTm5jWVVvQ2N6b1haVVM1cy81NlVEOEpCN1BnV3VpQkhBNmo3?=
 =?utf-8?B?MGFtVno2YUlHakQ1dU9ZcGVzWHlONHZDSFFPRHkxWWlRemxZbUZqZUN0bEVs?=
 =?utf-8?B?czNmbWJXeUFDZWU2Q2RNcWZSM2N6T1FaMysvQ1VXNCtJckVqdFFQZEVQTUgr?=
 =?utf-8?B?VEtsT2RBTkZSSG5tcGFiTVhoVStnNjJVOUtNVndFNG1XbTZkaTU0UFNGQXBn?=
 =?utf-8?B?UVlaSTlQNEZnRUhQSTI5ejVuWENmaHBNYWRzUEVhSkVCM0FhTWhxb20yTENG?=
 =?utf-8?B?ZXczREtxeTdUM0VuTUhBRm53RVRXQnJEeVZIcUMzSkViMnZtb0NBNWZmSjFB?=
 =?utf-8?B?STZ2bGtWbGdOTGFwaDFIMGs4Yzd0QmVBemY1SnNFbEFqK24vVXl5T3ZheE1y?=
 =?utf-8?B?WnRVSXhVak5iUmp2NHdMWmwyeXl0MEp4c1pJdlBMN2NjTE5hZkc1bXhXb3Ju?=
 =?utf-8?B?cUlGNGR3ZmZQd3ZKUm82M3VWTFBTcHNTUmdKNGFmdVJWRE1Eb3JKeGRFWS8r?=
 =?utf-8?B?TlQ2NFJvS25VZHEzUWxaS2UwWHkxNkJnUFZkd3RJQjdLMk44bUl0dnI5Q0o4?=
 =?utf-8?B?Vnd6a2RROUdUV1h4Tm1JMTJHdGxWMlFYWWQ5bnMwSzJIdzhaeVFUQkpyUnFl?=
 =?utf-8?B?WW5ZRDI3YXA0QjlUdXBCOG1uT1dJUWY0MVh6NUpITU9WZGdzaHhGbEt4UFJV?=
 =?utf-8?Q?u6C1Mc3cW3vJObs3IKNzudytHftsT8TjfHSPFmRzzfJgP?=
X-MS-Exchange-AntiSpam-MessageData-1: iF3yeZ9I7h2TgQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 SSpzPxAzfP6P/TZomiBenm1KCkZp+annYV3SjmPuRmeePHmf4RKv9soy1zzmyRcN0VQQ0CPtNwgsCRYV5MXUXi46Ko7kiSLdTwfOuNViVc3VWTJEk55in8JuAArR2KpO2Ob6VANcjYxQT0caErHHTC4dW5i6oQvFqp877FlHJY4ukYjjk5FZUWoUjVY2t8Sa1kziamTkYhwNnAJ1UUTOWNxl25yGgvWTTf+7Atg7wXyAvnd010aRV7blxYIploGFB67j79MIuizJX//Ue7EgyViIDIirx6sbLDSyRDmMOikdCoz5ES13SUXCMLZKKjcIsePto4nftIviig6boNRtlKpVU6PP36Obw8d4xZKaEMoMX0UDckFAcT9/7PqcbVEz43uTcC837CzW/AyJmr/KNF4ke8dils671r/fcUrhPepHwuAJmI5WkQGoFtNjjPUeAMt7HKqohgJZDeqYlRIMTmptDB+pRodFKLnjyuNnmNHOdZ6VxtUY17Fem55qttq8Yhgjsq+RAcfWhi+48OxyL1y2avmScCsA2HyuApYupgfllMm570B+ZcYksPur3FxbsjhTxBSqG2zSHEmCh1zU8hXWms/yVI5iVMEaorEVusbQrirSjYURAQqbI2v+7xvJq0pfucbcL0pAWT3jg6VVew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4776ac-1edb-4856-827f-08de591dcf17
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:49:29.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pldOQP6+18DhzMkGOJ5dQR+4HVEHh7FvllStdH0bH8AFK19HK2BaiwUEc89VnU2DibN13d6Tk7m+0hDZbcydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5025
X-OriginatorOrg: ddn.com
X-BESS-ID: 1769026941-102910-7692-21756-1
X-BESS-VER: 2019.1_20260115.1705
X-BESS-Apparent-Source-IP: 40.93.198.86
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamlhZAVgZQMMXE3CLN2CTVIi
	Ux2cLY0twwxdAgNcXYNDUxxdgi2SRZqTYWAL5nQFhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270567 [from 
	cloudscan11-106.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ddn.com,reject];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[igalia.com,gmail.com,szeredi.hu,kernel.org,ddn.com,vger.kernel.org,jumptrading.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74920-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ddn.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ddn.com:email,ddn.com:dkim,ddn.com:mid]
X-Rspamd-Queue-Id: 25BD65DF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/26 19:36, Horst Birthelmer wrote:
> On Wed, Jan 21, 2026 at 07:28:43PM +0100, Bernd Schubert wrote:
>> On 1/21/26 19:16, Horst Birthelmer wrote:
>>> Hi Luis,
>>>
>>> On Wed, Jan 21, 2026 at 05:56:12PM +0000, Luis Henriques wrote:
>>>> Hi Horst!
>>>>
>>>> On Fri, Jan 09 2026, Horst Birthelmer wrote:
>>>>
>>>>> On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
>>>>>> On 1/9/26 19:29, Amir Goldstein wrote:
>>>>>>> On Fri, Jan 9, 2026 at 4:56 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/9/26 16:37, Miklos Szeredi wrote:
>>>>>>>>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>>> What about FUSE_CREATE? FUSE_TMPFILE?
>>>>>>>>>
>>>>>>>>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
>>>>>>>>>
>>>>>>>>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
>>>>>>>>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
>>>>>>>>>
>>>>>>>
>>>>>>> I thought that the idea of FUSE_CREATE is that it is atomic_open()
>>>>>>> is it not?
>>>>>>> If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
>>>>>>> it won't be atomic on the server, would it?
>>>>>>
>>>>>> Horst just posted the libfuse PR for compounds
>>>>>> https://github.com/libfuse/libfuse/pull/1418
>>>>>>
>>>>>> You can make it atomic on the libfuse side with the compound
>>>>>> implementation. I.e. you have the option leave it to libfuse to handle
>>>>>> compound by compound as individual requests, or you handle the compound
>>>>>> yourself as one request.
>>>>>>
>>>>>> I think we need to create an example with self handling of the compound,
>>>>>> even if it is just to ensure that we didn't miss anything in design.
>>>>>
>>>>> I actually do have an example that would be suitable.
>>>>> I could implement the LOOKUP+CREATE as a pseudo atomic operation in passthrough_hp.
>>>>
>>>> So, I've been working on getting an implementation of LOOKUP_HANDLE+STATX.
>>>> And I would like to hear your opinion on a problem I found:
>>>>
>>>> If the kernel is doing a LOOKUP, you'll send the parent directory nodeid
>>>> in the request args.  On the other hand, the nodeid for a STATX will be
>>>> the nodeid will be for the actual inode being statx'ed.
>>>>
>>>> The problem is that when merging both requests into a compound request,
>>>> you don't have the nodeid for the STATX.  I've "fixed" this by passing in
>>>> FUSE_ROOT_ID and hacking user-space to work around it: if the lookup
>>>> succeeds, we have the correct nodeid for the STATX.  That seems to work
>>>> fine for my case, where the server handles the compound request itself.
>>>> But from what I understand libfuse can also handle it as individual
>>>> requests, and in this case the server wouldn't know the right nodeid for
>>>> the STATX.
>>>>
>>>> Obviously, the same problem will need to be solved for other operations
>>>> (for example for FUSE_CREATE where we'll need to do a FUSE_MKOBJ_H +
>>>> FUSE_STATX + FUSE_OPEN).
>>>>
>>>> I guess this can eventually be fixed in libfuse, by updating the nodeid in
>>>> this case.  Another solution is to not allow these sort of operations to
>>>> be handled individually.  But maybe I'm just being dense and there's a
>>>> better solution for this.
>>>>
>>>
>>> You have come across a problem, that I have come across, too, during my experiments. 
>>> I think that makes it a rather common problem when creating compounds.
>>>
>>> This can only be solved by convention and it is the reason why I have disabled the default
>>> handling of compounds in libfuse. Bernd actually wanted to do that automatically, but I think
>>> that is too risky for exactly the reason you have found.
>>>
>>> The fuse server has to decide if it wants to handle the compound as such or as a
>>> bunch of single requests.
>>
>> Idea was actually to pass compounds to the daemon if it has a compound
>> handler, if not to handle it automatically. Now for open+getattr
>> fuse-server actually not want the additional getattr - cannot be handle
>> automatically. But for lookup+stat and others like this, if fuse server
>> server does not know how to handle the entire compound, libfuse could
>> still do it correctly, i.e. have its own handler for known compounds?
> 
> We could definitely provide a library of compounds that we 'know' in libfuse,
> of course. No argument there.
> 
> The problem Luis had was that he cannot construct the second request in the compound correctly
> since he does not have all the in parameters to write complete request.

What I mean is, the auto-handler of libfuse could complete requests of
the 2nd compound request with those of the 1st request?

> 
> BTW, I forgot in my last mail to say that we have another problem, where we need 
> some sort of convention where we will bang our heads sooner or later.
> If the fuse server does not support the given compound it should 
> return EOPNOTSUP in my opinion.
> IIRC this is not implemented correctly so far.
> 
>>
>>>
>>> At the moment I think it is best to just not use the libfuse single request handling 
>>> of the compound where it is not possible. 
>>> As my passthrough_hp shows, you can handle certain compounds as a compound where you know all the information
>>> (like some lookup, you just did in the fuse server) and leave the 'trivial' ones to the lib.
>>>
>>> We could actually pass 'one' id in the 'in header' of the compound as some sort of global parent 
>>> but that would be another convention that the fuse server has to know and keep.
>>>
>>
>>
>> Thanks,
>> Bernd
> 
> Horst


