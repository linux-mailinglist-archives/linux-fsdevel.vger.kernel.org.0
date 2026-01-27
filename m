Return-Path: <linux-fsdevel+bounces-75653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMlMH3syeWmNvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:47:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F599AD03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84AA73005308
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6DB32E120;
	Tue, 27 Jan 2026 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fu5IN6oi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CF32C925;
	Tue, 27 Jan 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550453; cv=fail; b=TezzGPpOVRkyE/LSpmCIlK03+QU4FYnuXYNPYdCyJ/f63DuFxmOajgJEI4HgcfOnYg9RY3fxfqyrJtdNvKE4KiWjFXaxdFEPnZ3TldfapOIN3lzBBDiByqSiAF1fiamILc4h8N8gY+1bdmNKDJYITFT/xOUZVRHd+wfqNIXTKMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550453; c=relaxed/simple;
	bh=qcmNFhf7aszqRH52UyA2ne+oQek4BK5Zx00+zu14jW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SnoDh0AsRYCAHCgQ/ROKe2xc/SxhDSMiJ3vLxN2JBItQlkqCHgcch8BsHfNXxYr7/dMaXioIp2zRsfaBD0ih8lyQw3dFBj6sblLxDPrDw58rDcqG8aDAd2bWuafMTpt7OfbTzByA9ujjng65DLJJ3lP5HgzlHG6JDVA6CJDPnyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fu5IN6oi; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD/UbRxtr1Kj8FH8Je1ywAlDg+fJ+ZTxdiaYIZskYIYK7WwfYZR1Avdp6RAqkIjiMt3/k/J1SGTFhfGrfPmBHUJcxpgzoFFbCKrda0ok4VFnBENiTPuA/k1hATcu4zBQ25JwzaqTZzvLYpaA5M8lcjCSq4q+rDNiG6+yqwu4QoQOubw2THprfNujqDTa9EMTXYU70mdIX9JTdgIBFI0tKFJVSdH7JrF9h99aYRvGQOEwwCobhRf1GFb6MFVwtJOurkdObB9NOlvMWIXIOxvBYx20/Ntr7ziGETnyiiZxPKyhnOD4AduZ/La/8dDxVzrtPnAsJg8Jlke5XB7e0jWX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxSowun3FZOysDYhDsMcVjcrxJ+1v8FBYnW9AWmJKIk=;
 b=W3mamg/iNGJDimD5UP5wSQsO3KfXJrjH5oqzgn/GyhnTPW3jsmxOSXNdYZK19dIXwG1AT4hfQCnqTzoJi6Veap78bM5c5naLjBqtX4Hp+v4f3UdHLTVNZ5hH4H7Q5cVKtgr2vLZ0XrXQjzxOuxJ62rTV9h6VbpCBIj9SjTRjZ8JRcVB46Kx/zmeUMgUdY5/tQ7cr4sIzYA7ODiY6jxFPgDih/1eSUOm3ccahSyaxmO5zVW1QgqqE6uXcKkqfwxfyrgnh0zs2520asT1jdRAIaSG+BU0JE9AR/b32ddaqCP2V2A3UzdnPml7cBR2qfjtfJLe+XnHQsNU3tAmMlVxgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxSowun3FZOysDYhDsMcVjcrxJ+1v8FBYnW9AWmJKIk=;
 b=fu5IN6oicCKGGUJoAehlDjLA52xFaVmQuwmW3A4m73gHdQOqHU/WPn/cnTKQbqn0fhXNJhhxudyRx9zJfRcWW2sFP4JJ7HowivdlNJxZVHNx9YJ6sVS1B0Ttc6zA55GQ6aRIHcFasX5GcUhju8fA5QuZTR+m5in06u53N22mpSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 21:47:27 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 21:47:27 +0000
Message-ID: <c9e2707d-88a6-4740-8b10-157a45ec7fc3@amd.com>
Date: Tue, 27 Jan 2026 13:47:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved
 containment by CXL regions
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
 <20260122162556.0000184d@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260122162556.0000184d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc43f02-372f-4656-f4c7-08de5deda9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enlFTExKSDRwT1JlTUpQWjIxcUtlbmg1MVY1Y20ySjZHL2ZhUFBxbHc2aXZU?=
 =?utf-8?B?K2tQT0ovWkc3eXJYakhBNE1CekdQc0hpUGhHQUlrUHdGeXByUHdyTlpUWE9M?=
 =?utf-8?B?NGhHNktvR3FNQWNHZ1hYOWNEU0srL3U3dmxST1BMNzdMZ3ZoNUhNMjE1UjJ1?=
 =?utf-8?B?dzFqamtGZ0xTb1l3aE1hbHdSTTBQQW5DaUZtdlY1THpxQTd2UFlZVFJ4MWNl?=
 =?utf-8?B?VDBheDIvaHVXSGNON3gyQWIrYk1CN2lqV2k2MDFDZVNqc3J6cVRNM2YrQVd1?=
 =?utf-8?B?WFdWelEzWTU4ZkRUTHoyQllCT0kzY0IzcDA5SUZ3amlIcjhhMDBTRnRxRWVo?=
 =?utf-8?B?YXM2SXp6SEszR3hpUzdYejQxV2g4MVNmRzd5aXh0dUcxMWo3NWxBMjFGK2p6?=
 =?utf-8?B?VGQyTHErREJqcHF5NCttcTUrcmVFNlpLM0llbWNlTkpENDRSNUdzTTNSejQ4?=
 =?utf-8?B?T0ZqOFNxUE56T0RuWC9TZ0c5WkVRcndhM3BKSnErQ2dqZGtwRjFpVHMwRkw3?=
 =?utf-8?B?M2NOaHFiK3gySE9ONEtINTRhTHlXczFSeEtUb0JtUWJzNFl3TVZNeDJBOXVM?=
 =?utf-8?B?MUpCeG9lSlpBbDZaVHVnbE9abUhTM2c4c2hjMExjUDhGSnY0Mkd0UUxkUjNw?=
 =?utf-8?B?WXV0dWpBWTYvQ2EwY1ZMeUFsejFjRzhxbXJnOHJ6SDdyZ3EwVDhxa3ZQOGFx?=
 =?utf-8?B?bDZVQWxISDBxakM5ZnFHeUJoN2hRdEpnelA5MnpZZTkzSVhRdUphbU1Jb2xT?=
 =?utf-8?B?cldOWm1DQTExRi9SZktDSExxeE1uME8zT2M1dkpBNXV5TFhaN2psbHBTcVdl?=
 =?utf-8?B?aUVjZDk5cVc0WUg4Nm5kL2c4RG5UR0NDN1ZFa3JMbHhCVWVYZmM4SWRBYnU0?=
 =?utf-8?B?eVRydmNkL2xpaDd4S0doNjZydFJrcGtKcjUzNkNTRElmVmxjeS9HR21KVWlI?=
 =?utf-8?B?QktZcjZHbHRFTGhqYmtsdlVId28zN2RkTklYUkpTWTJjbXozOFRJQXFHdHVP?=
 =?utf-8?B?Z1BzalRqTjJJV01iWjFzSEM1cHJCbEVCSmk3QkF6YVpQTHQ2M0R1WlI1UDB3?=
 =?utf-8?B?TTJVY1VUK2NYZm4vUk9McmtSbDZKRWg3WG0relZ4TUVGUDBRU3B2cHZETkds?=
 =?utf-8?B?NWVUY0YveFN6UWZHeFdscGR5TzBobEs0dVY0WUkvbFdBdTVqUElVMmtFdEo0?=
 =?utf-8?B?dmg4OGY1RXMyckN2SlNTL0IwZ3R0ZW9sQ1NiMzhVc2lIUFVydHFYaUZlNlAw?=
 =?utf-8?B?SVNFU0ZMU2Z2bEh5UmZROXp5elNFVTFkYjJXQVU5SDlHMnJBRmIwNFlRZ0xX?=
 =?utf-8?B?TUdaanFVMzRsYUV5WTNtb2tCd3M4UWVuc0hPV2tIS0VaeENIVWJrUFl4RGJB?=
 =?utf-8?B?ckY3eXJKMEZOZE94bzI2S0tWMG1EUnN6bllNYUNDRDlhUXdhVVk4TFZVVFky?=
 =?utf-8?B?Slg4cUtabHFsUEZEN0FrUlRjOVlvSmFVU3NlQ3NYdzBvQWVjNFpLSEtLdm1W?=
 =?utf-8?B?Ti9Xc3NTU2JQZXZqYjRXTU1TV3R6SzR5dllFblJjZWJUeC85SVVHdmNGLzhx?=
 =?utf-8?B?V2hNTk1WdXBjVmVUR3RIU2lOY0lWSVN2VWV3ZG9pNlQ5QUZhYkQvQlJ5RXd0?=
 =?utf-8?B?RVNSckU5YzlRYU5ZNGtTYmNlVWtmUjBTbHozNGo5WjFmdG84KzM3RnpTNUFY?=
 =?utf-8?B?RTVkSDlQaFNyV1VaUzZvUkxNVlRadmRSd081anNHVHAvNFF1RUE2VFduSy9k?=
 =?utf-8?B?UHQ5d0Yzd1oraS9hR1V6T05sb2llVFRUTFpNRUtjSVlzb0xKajF1U1lXY2Qx?=
 =?utf-8?B?QitmWVNnOXJMZUdqTEo5RjdJUlpONUE3Zm5HV3NRRUcweEF5Yk83Z2VGNlRN?=
 =?utf-8?B?bUNOYStkUEs4eFU4SlFjems1MzBSOW12SlZxNi8rOEU0VGdRVzRGcy9vaWFp?=
 =?utf-8?B?b0ZScGN4bllGS2pJZkdHM0NFRVF4TUtpSDN2cDdRckdDREhkOGZnMUk3R1Jx?=
 =?utf-8?B?WVZXNGNIQWpGZUpZNUk0aXRTUnV4RXFtL2VVVjUrVkhMUjZiQkRwZDR6dExt?=
 =?utf-8?B?SDQ5dlMvZWdNNWNaYVpZTXc5MFJKc2FFV2MwMnY4OFFXZThRamszeXJtZnVV?=
 =?utf-8?Q?WCtI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0RWcWdJSXlkKzQ1WnRUTW5PbG10UnE2UHhsNTM5YmlreUtSdkhFWTZIeDZ1?=
 =?utf-8?B?YVZqVmRpTW1EYXBvamFld1hvRXVJMjFibVBJUitqVG1lNnF6YVBKY2pCcVFl?=
 =?utf-8?B?VkkvclpRMitoZkIwZlBLL0FoUWdoK0t1d2ZEdDBIQmIyRjhDelRwcEFsWFl2?=
 =?utf-8?B?ZGhIeHhUQkgyT3RFT2VWWkRZSUlhNnF3TkpOdkZxRElSNnFhc2ljaGhNdldW?=
 =?utf-8?B?cFk5eWJSb1FUZ25qbkNCUkpuUGxBWDJNcHlGUVBNdmxqdWVUM1FlZkVabEJa?=
 =?utf-8?B?Q25UV1NJVlpXMjhjZnRFeEpNV2pwWWtEMytMWnRvaW5LQ2J5aE83MklNVklw?=
 =?utf-8?B?aEFqWkRiWWhvT25kQytBVHhLU3NOT1NVaGpEbmtMYm1LdER1eUM0akE5NExC?=
 =?utf-8?B?WkxYVVNrZkNXS0ZISlRWU3IyR1JVUExCaHE5OW5vZmpRNHl3a0JEQnVtUmc1?=
 =?utf-8?B?cWcxSXp4NkJEVSt4THNHbFlObzQ4eCtmYjNRZ1l4cEdlOEdKb3pVdGF1TlIz?=
 =?utf-8?B?N2ZiOFUwbFBFelYwWW95Z21WbW16SXhIbmVtN2hzeFI1WFBOQjF3OGxpbHpF?=
 =?utf-8?B?L3FBV2JGc1dwcm1mdUZ3bXU0ZzBJUkY0MXpVdlVmWEs1eHZNc3VoSVlBc09n?=
 =?utf-8?B?d3lXTmtXQkNQZXFsbFZZQldhelFBdWswR1RaRlBBbWZQRTdyZCtXR2FBcTA4?=
 =?utf-8?B?RnlQUGdXZ3o5NmNlclBLSnJUczZFeFVuckhQNThXSGpsYUxJTVF2NFplaEZO?=
 =?utf-8?B?aEZ2V2tEOUduTzVjbERWZHhoTTZPT2hkS3Y5OUpBNGFyNGdId2NVeTdQakVS?=
 =?utf-8?B?RnRCM0tCdFN5WUxWNlFYbjIvdzNwTEgwL2gwcUhuNkdvcGZxTURQZzZ6OUV2?=
 =?utf-8?B?azBjczFzQkZzWW9iTjR0Q1hhYWFZU2lHbUtiZCt0c2FNLzRlUW85MmNXcCtU?=
 =?utf-8?B?V1JDM0E2eUZKcTZIOUIzRm5sbTRzRDFhYnh1SlduY1d2VlZDSnB5YVR4Z2NF?=
 =?utf-8?B?VkJwTFVSNXZpd0YwT1dxVzYwN1NMcEU0WGN3emlueWphY3hFeVEyaXZhQUI0?=
 =?utf-8?B?bXdaalA1TFU1ODlaN3IwcmUxN2lkYzlod0h0WXhZem5XQWhoRTVtYm1GYk5v?=
 =?utf-8?B?NFpuc0ppS0xNWVRrNm9lZVE0WXU3N2Vjb3J6ZmlpZXJwRlNFTlVmRytuOUYv?=
 =?utf-8?B?b29BSmIzRFk2K1lPVVlJa2VuMUV2MEp2ZGdtUFRGR2ZTQTdJV1RRL3FSazRX?=
 =?utf-8?B?Qlo5V3o0cXhtZ3owS1dIckRwSUJQaWZBOHo3eWI5b0VFR0hXYUZZenJ3R3A4?=
 =?utf-8?B?eCtER29sNFlhVWtPbWhPL3F0OEdYMVdnelBEcjJ1ZmlHTXRnTWgwaFI2MnJK?=
 =?utf-8?B?UVRvQWJPTXgwbmY5akprL25yUGJUWWRNTWtBRWFOeWE4QlNSK21id3FKMWM1?=
 =?utf-8?B?ZGlVRFR3aXlVc2VYK3FNZVY2RVpIRi9oR0RUenA4bko4bkZGdWxkT0VxMDBk?=
 =?utf-8?B?MnEyL2V2ZFQvNHlIQnhxNlRmRmJUK1BacXRoT3NjeDhaTTFzTXl5MTJBMUM2?=
 =?utf-8?B?c2VOQng5ZlFia0Y2TVFjVDlzQUxLVFQzZjRtQ2RUb2x4aHpLWWt2SERlTy9X?=
 =?utf-8?B?c2N0QlVnRVo4aVc5SEltcitwWndhajRHeDhlbDU2Zy9URVlKQnl3YkRUVi9s?=
 =?utf-8?B?TTNZZzQrMkhQMGpGVDhPTWlCZ3h1SDlHTHNFMnF3ZGNMNytISi81L1hBVkJ5?=
 =?utf-8?B?ejRCN3phVzhZRWdXL3JpOHpudnpOTnVKR0ZzajZ2RlZIdVRYcjh5OTRXL0pG?=
 =?utf-8?B?QzRJZitVQWtLd0xmOG5QREVxNTNnSGdZRzhUOTVnUnFaNTVabEx4aDJTa1Q3?=
 =?utf-8?B?ejFteFNacmQvRWZpRnlOZEt6dDBHamNLRmc0amd5ZTdSTnhlV21QdjRMTHEr?=
 =?utf-8?B?ekRMZTJ5ZU45Q2pqTENMaitmMTd4OG1CRWN0QXAxcGhLSDJxc2FuM21xZjJL?=
 =?utf-8?B?VytMNFpYRDFZRUFueFIrWnF5VVVqWDBZbHpnV3REclRubng4YkNPZEdrNFVr?=
 =?utf-8?B?N3NadXVCT1lxN2VhTS8zZkhCbkxoMjljNEFqZkFzakptbWd0SUxTWGxsNmxw?=
 =?utf-8?B?ak93RXBRdzJaL2lKTjRqVVRtUlk2U01ibHBrbFI3MXpNcDRtc0lxZUE4akVk?=
 =?utf-8?B?UnFsWlNsbUtjTHYxdkVTRHFGTlEyeSt5SVU4ZjByRXRCWkFaai9nV211WU9H?=
 =?utf-8?B?NUkzdWxwZGx4OXVaNTlNN1lUV09Eamh4OFNUR3dLUDhWZytzSWNoZlV2UTkr?=
 =?utf-8?B?SHNnT3RoUER5YjgrUlhaVm9VYjQvMlFoenRUR0lqTEdtdXFGeVlRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc43f02-372f-4656-f4c7-08de5deda9ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:47:27.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIYy/w39U3GX++5cMUPQskOwfrXIrcjkgk87HYU4wliLZ+h0169A9ZmSvFrEEg54glosi25fIpdwO0DMcnDV6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75653-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4F599AD03
X-Rspamd-Action: no action

On 1/22/2026 8:25 AM, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 04:55:40 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Add a helper to determine whether a given Soft Reserved memory range is
>> fully contained within the committed CXL region.
>>
>> This helper provides a primitive for policy decisions in subsequent
>> patches such as co-ordination with dax_hmem to determine whether CXL has
>> fully claimed ownership of Soft Reserved memory ranges.
>>
>> No functional changes are introduced by this patch.
> 
> Given it's not used yet, I'd not have this line of description.
> We tend to say things like that on refactor patches.

Sure, let me fix this

Thanks
Smita

> 
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 


