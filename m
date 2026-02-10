Return-Path: <linux-fsdevel+bounces-76882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMHUMsCLi2nEVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:49:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9F11ECCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 197B630055D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790332E724;
	Tue, 10 Feb 2026 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LeR77AJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726017BB21;
	Tue, 10 Feb 2026 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752954; cv=fail; b=E2YP6uMM5c/O2GzGzLYxKnbfLPE3+/0g4zEakvXPOsxFdPWcMAOcfTKAepLoxBlWWXrpEp5LEmkjkohXCbDP0lfrA2EQ8tI6VdEahwPI+suKpK1kaEyH60rnCxKI+iVpP2nXxoo6mozWsAcOadST9UICavQ03BWISRUYRdApiG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752954; c=relaxed/simple;
	bh=AZoGJa8Pl5qjcFOIlD72c8TnJ4FKLc8NE2Xw1QswMm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hr1TrSb3ZywDZTbF/PYptRZ45OO5jq561oAI/NYwssMkjA3E4vXchBk/HY9ZB+xHiI7CJaGmzFkop1OipF85yCa+jGCVxrbX7yM3jLyptOlduXgAlAGY1z5nDW+CQi4OH/My2Zk7Ge3G73fE71FWU4RlMG7KRv5nV2emWoo4V7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LeR77AJk; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtdylmkd5VX8ujZNxAz/VzNb1sM8405XMg7QaQ2Bb/ArcJA6phuGV230ezYqjwjb1CSRPdG+VrUdOObsHyktulhKiMp9hWVKkR23r4MiL7EQxUGVK3gGBYqNYAPQ19NTNzseK8T22PVzsHu55lyJz58DQJX+TfJDkFor1nvkZIDs+4G2fnK4DBGfVwQJTZZlJdjztPwq75gwE/Cx77hanolgXN3G2FyVXkd0mewK/pi0iMwCkyvIscxhkHty99alO7RT7buHxSbTQNof5FDb46r5TB0Yh4S3VoZq5wHzaMSoBQ2z3Cj1BHDS7+kaGpiaHa8Wdatfxo+A8WkkG+FG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc4y2NCprTurkkY8r4B/5SLdFw0RZQqMTPTxsxiiYBo=;
 b=i0h1IplofiOnn1OMAT0jrz71jT+Fst5oQ8fiweufOSxgCQXZvW/IrV8Jf7yoXd4no3GgIJNeaMoOTheclxnbws5qNeH21O9YIUH7XqFtDSPkytD/TCw4UR/3mySlLgZrUNG/nlBmW6aywNxPfkC/Rm8BKHHFf5VWvmZVDdZ1EGVGzXZrZt04AJp7WNCBnDtMeeduZLVoXrhQ3JJFrmY0mXRYVYK7U/vgbhjUBTahdZswL216/kiL+F53UNr5idesUoQQy8ZdwpgeSXpfJWu4gZwpAT0f47zg38CQ9jl1JepKMq858lUSR6BJ3oiMh9v1ECm1Rs4qSP8AleBttpaYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc4y2NCprTurkkY8r4B/5SLdFw0RZQqMTPTxsxiiYBo=;
 b=LeR77AJkk+MFwyTtt1YFSNrG12gcLiN4NpObXhcI3mOAqFwy/IRuiGuBNg3S5ba7tIacugH20MUqXOjiQmS+O3p5evY/GVC97lJJuzmsoGU2U9w+4WdQhQsRrxnPoG4VaGyX+Bp2JNTwC2vccamopBP7lPFaJgw9Mshqoa/TL3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 19:49:09 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 19:49:09 +0000
Message-ID: <d06fb76f-3fb3-4422-a8b1-51ea0c5e48f5@amd.com>
Date: Tue, 10 Feb 2026 11:49:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
To: Alison Schofield <alison.schofield@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
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
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <aYuEIRabA954iSfR@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:930:a3::24) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 832a96c0-abd4-40ea-2271-08de68dd7516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUp0K0ZmS3pvS0xYWDZDY1VkUU1lc0xRelF6UXBLK01KL29YZE5pQ3ZDNDlv?=
 =?utf-8?B?OEFyVlJzK1VEOGtwQnJxUGZ0RUY4eTBTTFVFNnhvcDQzUThEbWY0d1hacHZG?=
 =?utf-8?B?TnUxaVdqSEkvM01BcFR6aUpBZlJVMjRaTTFJT1ZwTFFiRjR3S3M4SGFQejFG?=
 =?utf-8?B?dm4yVWNpRm43cyswcEtVOUpyRnExdXdaS1g5QWZCSVduZW0xMkw3VEtSUS9m?=
 =?utf-8?B?R0RMR3hDZldEZjlhaEtjWjU4eW5zc3QzOUNaUmNBSVNlZjhxOTB1RjBLSTBD?=
 =?utf-8?B?Y0JiVUliU1lneHBEazd4OHRoRzBIaHBlV3BWNVVDc2cxQTN2NVBxb1B1elJK?=
 =?utf-8?B?N2J3VExGdTFNV1I5L2VISTZJbzZ5MmVrYVFtZy9HVm8zaDVRbXlBTnkvdkYz?=
 =?utf-8?B?cXhUTE43YkZjUWo3b1pqZGRTYzRzb2w5MCt2dFY5a0lKanRQYWVDSFZ4dDRs?=
 =?utf-8?B?ZjRvMzczQ1FLdXZzbFcrZ20weWZaMHQzZ1UyTVZUS2VvZHpFb2tzRlJLR1dV?=
 =?utf-8?B?NVduOERoTEFlUGVjZDNoUXAyV0x0cjd6Nm5tTVBkSW9QS2RLUTVZUkhzY3ZP?=
 =?utf-8?B?UXg4ZFJVWGFubFgrYlBubWpmMllmNjZuTzlDamc3Z1BmWjdHOVdVcnduTmRE?=
 =?utf-8?B?RFo3S2I4a1ExTFF3d3lERXpEYkd2UVJ5a1d2YndyZ1JpbmQyV2NOQ1VxSXhZ?=
 =?utf-8?B?NklwL1pudUhYZWpQOEFNQis4bzVCNVQya1JnVE9xMjZsSVNQeFhoSTFTRzly?=
 =?utf-8?B?WEhHNjQ3SHpUMThyRTJlRnVNRnpsYTBxQ1JGRUpncUt2c3RJRDllUHZlOUpu?=
 =?utf-8?B?U0pIY3JFcjVNRmd3VVN2d3p5SGZwcXJDa1FYOW11OFljcGx4ajM3a2VPT3Ax?=
 =?utf-8?B?NXhVT01qK3BKTTFFNUNIYW1mQ0lyU0djMlRLSmdybGU5WVVpaWJLWEFlQlhr?=
 =?utf-8?B?MzhrbkFBWjdxbkZIWWsyZGE5K0hrNStZcmZXdml5RktSdmkvYVFCSjVxMlF2?=
 =?utf-8?B?UDlWSDNNNkZ5b05aRENLUTI0MzRMVlJJTjdFWXJHQ0l2Z3c5dEVSb2JUeVk1?=
 =?utf-8?B?cG9iN1R3bmtkemp0Y3F3TTlyWXRkaUp5bU9DalVPaWF3ZGJTeTFKaStUakI0?=
 =?utf-8?B?Yjh4cldFcnpEV0dDdlpvYTFUVFI0V1hMYk1xbmppRzFaSjIwSkhLUzZKWXJZ?=
 =?utf-8?B?RDRUcmpKR2ozd2VYOEVLMFFkMnNLdFNHRHljdEVXbm5BZ0tTT25lNkJqaG5w?=
 =?utf-8?B?WGdmU1BXZ2VaSkxjU1praDZLVlBiSm0wNUVIbFExb2RkemxxOVl1VktvcURB?=
 =?utf-8?B?Q3MwTDUrejlvb1kvNHBJYWxrNEpBdDk4czhwbURQV1FBTXhMbXJ5ckNlNmpQ?=
 =?utf-8?B?THNjT3JxMVhOU3hoMFNEbHlqQUtwcGVmMitTS2lFMXJvS29LSFIzbXJHaDQy?=
 =?utf-8?B?ZWVHellxV3VicnFTNDFBeFFFZzlpaW55L0lCQS9NeFVVMW1RQm05QmpOZGtC?=
 =?utf-8?B?V0d6R3FRQStxUDQ1TzhuanNTMSt0Nks2UWR6emlLeXcxTmNQTU12SWlVd2Ny?=
 =?utf-8?B?NFpEZnU0UElBdit4Zml2UkFvaWFjTm1pWDc0NnBGbmgzaEdIU0U3emRTNDhD?=
 =?utf-8?B?dnNKTkhHdXRseG04MlRmNDlZVzJGV08yMWtSc3A5WG1wTThETlp5TWU2Q3o2?=
 =?utf-8?B?UEYyNUtCQmp2UTNQU2lhSmN2NXQ2aXRHR2labzdzTWh4SjBBcFpXT0tzRWt0?=
 =?utf-8?B?T0NQQXZwL3hqOFMzV0dmRWtpWDBIUW9NbHN3cTJJV1FDcG85WUZLSkhsUEdY?=
 =?utf-8?B?Qzc4QUNUb2NvejlEaFNRSmdiVkd3TmxDSGdTRm9aa0JSYkRHSFpWMmJubXVy?=
 =?utf-8?B?d3M0M3BLV2tOa2wwYStEbUsyOVkrTE9ReGt0dzVxUXVDcG5EVnh2SEdjVnhJ?=
 =?utf-8?B?NHpETVBYVUhYb3pML3VCNllVOS9rNGcwdXRzK3lLSndJSUFUbHNJb25DUXQw?=
 =?utf-8?B?a0gwNThyL2g5Qk52aEIrbCtYbk1xTDNkejBaUmh1OTFVWjdTWDNEOUxRMFNW?=
 =?utf-8?B?NVAwczdlZEVBS0szWEQ4dGVrT1I4RldrdDB6bkM1aG9RbUhZNm1zMVB3b2kv?=
 =?utf-8?Q?egJSY0YRkWkkjTriIUqVctWo0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGR3YlA0WFl5bGhKci9DVjZ5UWVuaGtaSVlIVzdXU1lJR1JkQWQwK2J6R2ZG?=
 =?utf-8?B?cW9vUm82RDdJZFd2SzMvMG10ek56ak1nQ1FiYThacGQxSHh4ZlNHeEtLNXFE?=
 =?utf-8?B?bjRWcUp1MnJqYlhjRjJnbStQSDdyT2JFcWxFWTdrdFRoMTJFbHpLalA0VjFM?=
 =?utf-8?B?UEhXZFdTZzBROTJKYmZYaisvZHZLbnlFeERoenpxM1RBWUx5YWhOUzk5eThy?=
 =?utf-8?B?MjJzeWtMSzljZnhjSGtmSWhtZVU1cUVXRW40Nmh5YUNQRzZjWGp1WXlJNmtm?=
 =?utf-8?B?eUVyL092ZXdCTzdFNGJtUGFtbFVDRkpUY2xkOTg5d2srdEh1eGxCZGZicnpa?=
 =?utf-8?B?Nm9zdGMvZ05YTG9mdjJIeWw5MmpOTVRyZkFuTFFLYjUrVmdVUVhNcit4Q0hF?=
 =?utf-8?B?UDVBUjM2MWIzVHprcXo1UUlsTnd2N2QxaHdMaGRWQ20wQlpHSExFMitETTMv?=
 =?utf-8?B?SERtRlAxdDREeVFtRVRmVjErdTYzOThqVlpTbmFoUTRLaGd4NHJIWlAyYUFX?=
 =?utf-8?B?dTRqdW4zS0tSK2hoRi9qcDYzdGR6VWdPb0t6U1BZMWRmL0R3T01ScCtwcE9D?=
 =?utf-8?B?QlNPMU44QmsyVHI3QlE1N2dzU1M5VXp0OC92eUg1OXZJNmdiMDdENkkwOGlJ?=
 =?utf-8?B?S2lmS2MzaVdxYmFhdGR4a3llSHR3N2Vlang2WlBqMFlXTnFqWUJOREVzTGc1?=
 =?utf-8?B?dG1iNzNreGE2am9tanpKUVJSMkx0SnI1cHNIbnU0QTM0ZG45N2lXMDN6cEU3?=
 =?utf-8?B?bnkzSmRHOStqRmdIaTNWdFVsWDkwVERxNk0zTTJNNGdnYVVtWnplNVU5cUhF?=
 =?utf-8?B?bVZONmY5em5TeXlSMCtObjBpeUJmU1BrbCtpYjJKWmlpUUJTcjJJdWhVOGQw?=
 =?utf-8?B?b1UzbEtLMUhDaEJaRXArNXFUbm1qZ2ZMQWJUbjZsS0NoajFPUXB4b2JiUWxJ?=
 =?utf-8?B?MVh4U0s3Q0l6QTFla01Jemw5YU8vT2ZTczRxV2htRnJNWE5FeStiK2lqZDVU?=
 =?utf-8?B?Skd2MmZ6ZWlsTVVDNHFmeDFESEZtQlUwalJsS3lLVkVxRGc2Nnc0S1RwR1Rh?=
 =?utf-8?B?UUZMczZrN0tKR054dEFHeW8zKzFENXlPRXU4alpLRGwrM1l2V20zcjdZYTc4?=
 =?utf-8?B?L1B0RVdCR3VSSkticWZrQlhjVUQxcmdQYUxqNlZVRTAvbkgvamNKT2R5VWNa?=
 =?utf-8?B?cW1PZzl3NUxNN2E3UGVHTk8xU1BCcnBFblVjTzRpeUFpelgwTEdUSWI2bi9k?=
 =?utf-8?B?aHo5R2lTN2h0Y1ViY0MxbDZrM2JjcEhNbFkzN3RQRlh5emZSd1c2VUJSejQz?=
 =?utf-8?B?MmZucDZoM3ZmOW05THJ6K0ZBU2ZpQ2hGOG54V05JUy9nSTVKeFpkOGFrTy96?=
 =?utf-8?B?QTJKWVVrMmxOeHZ2TktrU0IwTThQcyt4c1dMZEk0L3IrQ1o2UkNkYk9TVWV3?=
 =?utf-8?B?c3REUmtKeFc2M3JvOHBNbG9sUWo5WXVGWEY3b1k3eXY0Y2wvU2dWWnJVVU9i?=
 =?utf-8?B?YVliL1luaDdad0hTWndpTmttL3RHRTUwMTJaMlk5UTNJdlVWckNvSGVCMjJ6?=
 =?utf-8?B?amJDRkJVSTBEaDh3SlNKZFZick1wQXRXMkJrSklSN2Zqcmp4TndDak5ES1Y0?=
 =?utf-8?B?dlhHRjAvYWRxeXN2U2FaaHVjT1lmYkp1cUNBdnhoZ09YMm5jM0NCSUhwTUcy?=
 =?utf-8?B?WllkSkZuUG1iTDl6QTVrTHBUcll1azFHRGthUFUrVU9FRFNwY2dmY2swejlH?=
 =?utf-8?B?NUJteHFNUExCeVE3STdkQW5QNC9DangxTk8rdFVPTzk0bnpYVWVOQzY2MXU5?=
 =?utf-8?B?U2hXcHFLaElqQVR0YUdlZ3hWWXNvVmdZVHg5QXhEOGNrckp4VmhPN1dBQkl1?=
 =?utf-8?B?RFR6TCtGNm04YVZCZjhlMU90dEtDOHR2bVFvaHNrNWJWTHg2VkQ3eEgyUU9R?=
 =?utf-8?B?QVdDQjNGOHNKTE1vK25WbGRlWDhZa2liVytYMXR6STQ3S3RVT3VUaGM5ZjZn?=
 =?utf-8?B?cFNaK0toSXFoQS9uUWVOVzNzNmpuZ1NwbnVPMFViZmduYnNSejFIUWkwZjRv?=
 =?utf-8?B?WDdqVE0vU2NEOXpmQzlJWXNzTVB2Q3pFQnhya2lxRGkxMXlrVlRPTVA4Sm9Q?=
 =?utf-8?B?S3lGckg5ZllTL2xpYWtVZThDZnJUU1UrYlA1TlNjcU1oQzJiajFXYm5iMzBn?=
 =?utf-8?B?N1NjdnRubXlRS0RqRXcvc1k5YzBtakJ2cjNERkNQenRTYnNyNTdobmJ0RnlP?=
 =?utf-8?B?VzFXNHZyTTVwSkRjNWpsWnRJNGw3SVpRVUY3VmVDVHBsS1ZvQXJSQktOelA1?=
 =?utf-8?B?Tk53SXZ5L2ZINGtadW9VK3ZIVWFUdjRPeHlYV3dMK3J1OHV0VHlSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832a96c0-abd4-40ea-2271-08de68dd7516
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 19:49:09.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/l+1ddfoeWoB0jIhRKhKaZumUaG+LtPGJyuzPzrfYc1fvgFyolPIPQlKZoTZ/j9Jp6JpuFfP+2MIvq0KCGTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76882-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: D7B9F11ECCB
X-Rspamd-Action: no action

Hi Alison,

On 2/10/2026 11:16 AM, Alison Schofield wrote:
> On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
>> This series aims to address long-standing conflicts between HMEM and
>> CXL when handling Soft Reserved memory ranges.
>>
>> Reworked from Dan's patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>>
>> Previous work:
>> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
>>
>> Link to v5:
>> https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com
>>
>> The series is based on branch "for-7.0/cxl-init" and base-commit is
>> base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1
>>
>> [1] After offlining the memory I can tear down the regions and recreate
>> them back. dax_cxl creates dax devices and onlines memory.
>> 850000000-284fffffff : CXL Window 0
>>    850000000-284fffffff : region0
>>      850000000-284fffffff : dax0.0
>>        850000000-284fffffff : System RAM (kmem)
>>
>> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
>> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
>> and dax devices are created from HMEM.
>> 850000000-284fffffff : CXL Window 0
>>    850000000-284fffffff : Soft Reserved
>>      850000000-284fffffff : dax0.0
>>        850000000-284fffffff : System RAM (kmem)
>>
>> [3] Region assembly failure works same as [2].
>>
>> [4] REGISTER path:
>> When CXL_BUS = y (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = y),
>> the dax_cxl driver is probed and completes initialization before dax_hmem
>> probes. This scenario was tested with CXL = y, DAX_CXL = m and
>> DAX_HMEM = m. To validate the REGISTER path, I forced REGISTER even in
>> cases where SR completely overlaps the CXL region as I did not have access
>> to a system where the CXL region range is smaller than the SR range.
>>
>> 850000000-284fffffff : Soft Reserved
>>    850000000-284fffffff : CXL Window 0
>>      850000000-280fffffff : region0
>>        850000000-284fffffff : dax0.0
>>          850000000-284fffffff : System RAM (kmem)
>>
>> "path":"\/platform\/ACPI0017:00\/root0\/decoder0.0\/region0\/dax_region0",
>> "id":0,
>> "size":"128.00 GiB (137.44 GB)",
>> "align":2097152
>>
>> [   35.961707] cxl-dax: cxl_dax_region_init()
>> [   35.961713] cxl-dax: registering driver.
>> [   35.961715] cxl-dax: dax_hmem work flushed.
>> [   35.961754] alloc_dev_dax_range:  dax0.0: alloc range[0]:
>> 0x000000850000000:0x000000284fffffff
>> [   35.976622] hmem: hmem_platform probe started.
>> [   35.980821] cxl_bus_probe: cxl_dax_region dax_region0: probe: 0
>> [   36.819566] hmem_platform hmem_platform.0: Soft Reserved not fully
>> contained in CXL; using HMEM
>> [   36.819569] hmem_register_device: hmem_platform hmem_platform.0:
>> registering CXL range: [mem 0x850000000-0x284fffffff flags 0x80000200]
>> [   36.934156] alloc_dax_region: hmem hmem.6: dax_region resource conflict
>> for [mem 0x850000000-0x284fffffff]
>> [   36.989310] hmem hmem.6: probe with driver hmem failed with error -12
>>
>> [5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
>> DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the
>> REGISTER path, I forced REGISTER even in cases where SR completely
>> overlaps the CXL region as I did not have access to a system where the
>> CXL region range is smaller than the SR range.
>>
>> 850000000-284fffffff : Soft Reserved
>>    850000000-284fffffff : CXL Window 0
>>      850000000-280fffffff : region0
>>        850000000-284fffffff : dax6.0
>>          850000000-284fffffff : System RAM (kmem)
>>
>> "path":"\/platform\/hmem.6",
>> "id":6,
>> "size":"128.00 GiB (137.44 GB)",
>> "align":2097152
>>
>> [   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
>> register dax_region0
>> [   30.921015] hmem: hmem_platform probe started.
>> [   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
>> contained in CXL; using HMEM
>> [   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
>> 0x0000000850000000:0x000000284fffffff
>> [   34.781516] cxl-dax: cxl_dax_region_init()
>> [   34.781522] cxl-dax: registering driver.
>> [   34.781523] cxl-dax: dax_hmem work flushed.
>> [   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
>> resource conflict for [mem 0x850000000-0x284fffffff]
>> [   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
>> [   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
>> failed with error -12
>>
>> v6 updates:
>> - Patch 1-3 no changes.
>> - New Patches 4-5.
>> - (void *)res -> res.
>> - cxl_region_contains_soft_reserve -> region_contains_soft_reserve.
>> - New file include/cxl/cxl.h
>> - Introduced singleton workqueue.
>> - hmem to queue the work and cxl to flush.
>> - cxl_contains_soft_reserve() -> soft_reserve_has_cxl_match().
>> - Included descriptions for dax_cxl_mode.
>> - kzalloc -> kmalloc in add_soft_reserve_into_iomem()
>> - dax_cxl_mode is exported to CXL.
>> - Introduced hmem_register_cxl_device() for walking only CXL
>> intersected SR ranges the second time.
> 
> During v5 review of this patch:
> 
> [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
> 
> there was discussion around handling region teardown. It's not mentioned
> in the changelog, and the teardown is completely removed from the patch.
> 
> The discussion seemed to be leaning towards not tearing down 'all', but
> it's not clear to me that we decided not to tear down anything - which
> this update now does.
> 
> And, as you may be guessing, I'm seeing disabled regions with DAX children
> and figuring out what can be done with them.
> 
> Can you explain the new approach so I can test against that intention?
> 
> FYI - I am able to confirm the dax regions are back for no-soft-reserved
> case, and my basic hotplug flow works with v6.
> 
> -- Alison

Hi Alison,

Thanks for the test and confirming the no-soft-reserved and hotplug 
cases work.

You're right that cxl_region_teardown_all() was removed in v6. I should 
have called this out more clearly in the changelog. Here's what I learnt 
from v5 review. Correct me if I misunderstood.

During v5 review, regarding dropping teardown (comments from Dan):

"If we go with the alloc_dax_region() observation in my other mail it 
means that the HPA space will already be claimed and 
cxl_dax_region_probe() will fail. If we can get to that point of "all 
HMEM registered, and all CXL regions failing to attach their
cxl_dax_region devices" that is a good stopping point. Then can decide 
if a follow-on patch is needed to cleanup that state 
(cxl_region_teardown_all()) , or if it can just idle that way in the 
messy state and wait for userspace to cleanup if it wants."

https://lore.kernel.org/all/697aad9546542_30951007c@dwillia2-mobl4.notmuch/

Also:

"In other words, I thought total teardown would be simpler, but as the 
feedback keeps coming in, I think that brings a different set of 
complexity. So just inject failures for dax_cxl to trip over and then we 
can go further later to effect total teardown if that proves to not be 
enough."

https://lore.kernel.org/all/697a9d46b147e_309510027@dwillia2-mobl4.notmuch/

The v6 approach replaces teardown with the alloc_dax_region() resource 
exclusion in patch 5. When HMEM wins the ownership decision (REGISTER 
path), it successfully claims the dax_region resource range first. When 
dax_cxl later tries to probe, its alloc_dax_region() call hits a 
resource conflict and fails, leaving the cxl_dax_region device in a 
disabled state.

(There is a separate ordering issue when CXL is built-in and HMEM is a 
module, where dax_cxl may claim the dax_region first as observed in 
experiments [4] and [5], but that is an independent topic and might not 
be relevant here.)

So the disabled regions with DAX children you are seeing on the CXL side 
are likely expected as Dan mentioned - they show that CXL tried to claim 
the range but HMEM got there first. Though the cxl region remains 
committed, no dax_region gets created for it because the HPA space is 
already taken.

Thanks
Smita


