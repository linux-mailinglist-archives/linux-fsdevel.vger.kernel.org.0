Return-Path: <linux-fsdevel+bounces-77827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLiWGfbPmGmcMwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:19:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDAC16AF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DB06300B1A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3230E0CC;
	Fri, 20 Feb 2026 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3nffT8d6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE81946A;
	Fri, 20 Feb 2026 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622383; cv=fail; b=Kl//jGxury6zJhsO9wLDY8TMchwb5nDIlNkpeIQHnPxDg7I75jpqBUtOhlu99Fa+/Qv4KQBeFqQRMA4JMh8dnbRzV8HoVwIOSbcyIWjOP9caDsdcpttJpIpzB7vQPiSzws19xbqU4zm9xWp75HEbp2A+OGqNPpkXIMG5KEciHwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622383; c=relaxed/simple;
	bh=fDair2He7yBX4uKAx24enNDWTTM04Yafx5hFXHkN4Dk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHmmBZIDOO2ZGP1vC3vH+Jn9TdGLP2FdTEzNR7OwJoMOI3NT4LzIKpZNsoKkmfRdipzgcV+1MfBODG5tLrCj9Jqqcy99jqH4oMUdvG25VSU0CHBIOK3vutH52CYNdv85ftcRbCddoUjplEC1iIE5Egy7edsPCj47chhQUNBgPgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3nffT8d6; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcW6gB/kP9AMvEeaQSbRnnNJGZfPdmjpyyW6vLQCEKiGuZHLmYoZXFTRFB4TR8ZEnhDnh7XpeMa9t7NswsL87MnW5B8DrVrAtGXwalEByqM0Vhv+fd+U9E9m2xvh6JLGh1NL/C6hqB/FR4+5j6Ui568XwhukDcxNTJgj2NQvRVrrRf/yE1XVf1S8Bu3km4k6poAQqyAuqiIcqPKz1dp9kiAlFPD6It+m2jA+SZzhkGSgbrbzSezDBsA8rGa7frtYK9rGB23z223Zb8Wti2i2cI8pqdgN0PrME0Rkh0Fvto0g3gsBZFoMAMZj24JD9MJ8vVtH2Wd/lFTMaNIddjjTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7lVpws8etTIa3aKwNpO0q93unw16rOLPKj+5HjlSHE=;
 b=hkNr3NfjMoMXd/jfOVeQHW9RiF4LEEIBZVDw/kAnSwdkG4lT7O5ynQ4zT2skzed9J59rpdwpiZiPJMVNJ9KgpOhkp2wkne619zDWvy6s5Cv4mdbJ1KgKYR8cvRDw/H0fVD5cONKK1OPhn7/tTSnR9+Q6iV+6vsxZBo6Fmh5zitZ914tn9a+LQu1W2xMqIl9SHpU7+XNRf8/KG11ehhY3+/25a/wz+4XHqBw20Jm6mLRExg3foYLtOVNAcp5OD2Ov4xwO973NTvVYwgduamXLWEPqgwph/08luPR4+UN9/JyGv7uaajtovNQZVLK1CuzfM4xvXVfDIe/ijt12ukbBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7lVpws8etTIa3aKwNpO0q93unw16rOLPKj+5HjlSHE=;
 b=3nffT8d6P1TQRrO55hNx7j/bfqLFs4ylPSlV17X0yKQb702b7qKdfXC+erRmGjSj+Md0ja4Hui8UMAnxCP3Bglk8LpILOtqTqtg1C4rzMC5wR9ViaMRLo8qSRY1eYx5S6UdnnfJo4Ij8+B1al2coSH6lTX6TBedEB8gnyaRsVTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 21:19:36 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 21:19:36 +0000
Message-ID: <0b0eb8bb-44a5-422d-8d5b-070fb039ed68@amd.com>
Date: Fri, 20 Feb 2026 13:19:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
To: Tomasz Wolski <tomasz.wolski@fujitsu.com>,
 smita.koralahallichannabasappa@amd.com
Cc: alison.schofield@intel.com, ardb@kernel.org, benjamin.cheatham@amd.com,
 bp@alien8.de, dan.j.williams@intel.com, dave.jiang@intel.com,
 dave@stgolabs.net, gregkh@linuxfoundation.org, huang.ying.caritas@gmail.com,
 ira.weiny@intel.com, jack@suse.cz, jeff.johnson@oss.qualcomm.com,
 jonathan.cameron@huawei.com, len.brown@intel.com, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, lizhijian@fujitsu.com, ming.li@zohomail.com,
 nathan.fontenot@amd.com, nvdimm@lists.linux.dev, pavel@kernel.org,
 peterz@infradead.org, rafael@kernel.org, rrichter@amd.com,
 terry.bowman@amd.com, vishal.l.verma@intel.com, willy@infradead.org,
 yaoxt.fnst@fujitsu.com, yazen.ghannam@amd.com
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260220094510.17955-1-tomasz.wolski@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260220094510.17955-1-tomasz.wolski@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a0fe4e-ab9f-4763-22af-08de70c5bfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0t3dVFrWXYrMkEzWlEyMTFBSmRsUXNvWnRROTVMSHVYdXpQRjF2Z2pNL243?=
 =?utf-8?B?WFlSei82OXhyVFhuYWhLZURzek14cnEvcXNvRmhnMTljeEJwMEl3VGlMM09t?=
 =?utf-8?B?YjFVQ2NIMGtmQStOQ09jd2hFakxPQitwMG9xSFBNdHVKQmxlSUZVL1NBZXlp?=
 =?utf-8?B?UDlaWms5Sml1UnBHSFRPclIvVFAvWnpoZk5zS3FYbDRFNXNCUlpqT3hLdjVZ?=
 =?utf-8?B?ZXlwaFdvYXc2d0ZVeGZFQ0tmWjVlZkllUmo2M1kxWit3RE1ndUV4SWF4YmJa?=
 =?utf-8?B?a0ZmQlN5MkdjV0R3RER3M2R3NkNzZWdEbHpNSzg1WkJRSkt3N1BZTnRTS05h?=
 =?utf-8?B?QnVjOWI4MnVTNlBGd0tObkdSQXJsS0FCU0VMZ2hUK1h0L3habGRmMVNyWDlp?=
 =?utf-8?B?bnZYd0k5Z0JKZWRCa2puUGFzT1ZVN3NrVVRhU3F4aE9PU2F5Zm14L1ZnSXVh?=
 =?utf-8?B?M3JVdUw4aGhXOEhjYUVKNUhodFpSR2poKzJzd3JIdlZ0eWRnakovQmtmdlBH?=
 =?utf-8?B?MXIwcVVpUHZ4czVocXhPN0F5R3JuR1ZpbEM5WUJiSXJUbHBnSGl3WGM1TnlZ?=
 =?utf-8?B?Y0pXQmhaOEY3V3FCUFdhWEp5VnhIeXFoWXc3aE11UEY0YXdhVjloblJjekUy?=
 =?utf-8?B?SzVGcjVUMjFzU3RjRGxXbDdDOExnS3VOL0lTVXU2YVJ5YWdlcy9IQmd2Sm9z?=
 =?utf-8?B?WUJIaG5BV2RpZUlOKzVWZEZyREY5SHhaamFzSkpmQ2drc0sxbTZiZVo1UzVU?=
 =?utf-8?B?bEMwTkpIRXF6MzR4MDY5cjZZdUsrbEFYdktDK0l4Z3RseFZ1NVc4QlczSStG?=
 =?utf-8?B?Ym1LZk9neFViWnlPS0JsS0FxZitCL1VmTDFuQVJCVER4SDVDOEpwS3FtbkRn?=
 =?utf-8?B?VFR2dTFTZk5XenNLVzE2N3duZnkyLzd2Qm81TEpva1IvL0dvYjB5YjlQNUhD?=
 =?utf-8?B?bUVFakhjZ05NeGxyckp1TGRQVzB0azE0YzNieElBSTZCSXkzT1ljWWZnV253?=
 =?utf-8?B?cGFRQ2ZteXhNY3kyeHRXaGpmVmRrWHNCemxaZVRIYkQ4Sy9MTTRDbytEMmhv?=
 =?utf-8?B?SSs1b3RyZHRqdjdNM09Gc1RYeW92Zlk4bWg2SkVOVGtHc2VTL2prWW5wc1Zo?=
 =?utf-8?B?V0pMUk9qU3BxbFhMZnpDUTh5Wnh4RDlzMlJ6MFFnR0xzenFnU0FZcFFMckFN?=
 =?utf-8?B?KzE2S0QxNEtXQURhZWNRbFRDcUZqcjl1N29aSmk1dlNqM3hzU0o3ZTlnVFpz?=
 =?utf-8?B?S1hPT0svQWlnbGVGdlB4ZmhUQWZHRldza2NPd1Y5YU9hSFhyUE80aVB4b3NS?=
 =?utf-8?B?SHpWait0L0ZLelA5bWYvZlUrT3ovQk5KMS9GbU9DWkFZb3FIY3ZWcTk3Mk1v?=
 =?utf-8?B?eG9keVNqVTl1RTRtQ2ZVRzRXcU05TmQ5S09zMzJtY0JuVXp5d1FSaXVVZUxx?=
 =?utf-8?B?ZWNOTWVlMGhiazZvYzYvRjlaL2pnLzBCMmxyUEdKRVZBVEUrR2Y4VDcwUE55?=
 =?utf-8?B?dmZFdFdWSHM5KzBGeFNER2JEUWJEMkxDNUNtOHNUZzQ1WkFPUnlpWHpaZlFw?=
 =?utf-8?B?M2F3dFJvd1V1VytJdTl4Unl4K1dFOUI1dDUwd0JPOHNsNVhXOWY4cml0ZXFu?=
 =?utf-8?B?QmdXMC9pWUcyL1MyT2ovUHJ2UXJOdFVvNVYwbXJNanhmMWY5NnIzSDN5V05a?=
 =?utf-8?B?L0tUSW5aSmEweDl3RTMvMWR3R3FvR3FBdU41Y1kvZ1ZPTklkNVdtTE9VMkVG?=
 =?utf-8?B?YStHZVBTRVMyczl4MGdGZy9WdmY0UnRjMGMxbUNZUTFpOE9RdlFxNW5iUnV4?=
 =?utf-8?B?Y1FwM0prbFBka3pNMnN2RlRDTEhwZzZFd25kUkptUGlPY1dvYU5iL084Ky9Y?=
 =?utf-8?B?L2gwcW9qdHY1dlp1VmYvcmZUMGhVWVd4b3AvVWQyNS93ODJ2NjM5SDRWMkg3?=
 =?utf-8?B?ZnNHUkVoS2EzNzRJY0thWFZBSmlBZDRkTVVnK21JaGtEbEtlNzBSbExBN040?=
 =?utf-8?B?Y0hSUjlpVjBrSjRqTUFyaThNMFZDN3FXQXpTMk9EV2xadGRKQjhRNXZJVHF4?=
 =?utf-8?B?T1kyTjZUVEpIeFFEYnE5RnlPUEVheHRQa2FxUUFzcnNBV1F3RVdLWXNScWpu?=
 =?utf-8?Q?UuiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjcrdU5RQkhyejB1QnhBbDJlZXJ2dzhhckFSYjJoK0hXWnB5UG1KUnNyVWd3?=
 =?utf-8?B?OUtxekhJZ3JvNTdidDgyUzV3eXlVcE8wN0d6SXo5OUNOOGp3N25vSExRRUZ4?=
 =?utf-8?B?TGdFSkFkRUFWQXViS0FFZXNyckppbWw4WlZiaDJqaHVOMGQ3bHJIeXRMNW93?=
 =?utf-8?B?SWREUDQydUdNZ0dGd05UQ1RGWGNPUHhQb0hDaWpOcGh2UzMzM3pPdzNDcHZN?=
 =?utf-8?B?SWdTYm8xMUI0bHJYUllqNks2cTc1VU9EMGx5K3V4ZVFwMXk5amZpOHJHalVQ?=
 =?utf-8?B?N1BxK1ZXRGZiWnRXci9Vc09DL2tINFZwbjNpRm9aNEJPSUVFOThpNXF4T05z?=
 =?utf-8?B?U2FBZGpSUzl1eUNhQ1BzaHZYQlVScWcxbGdLeWdKT0FGVjZYaUZiL2tvandH?=
 =?utf-8?B?aHZwN2crL1VpREVESkhkTlQzcWx3UStTbVM3VUREUm85M2JZNFB3S3pIaE9r?=
 =?utf-8?B?eHNVNkZycEJobmtzSURTajV0L3FSRDhXclBCVjlGL3d2M01paU83TTFiRCtE?=
 =?utf-8?B?WXNiQ0phUytPb1dKOEsrNVJhZ1ZKb1laRXgxYmVzeVFzellPL3k5TGFrQlNW?=
 =?utf-8?B?SzE1RGZRSU52T1U5Kzh5YU9pcW54T0kwYmJKTlJlV2xPclM0QTlNcWhrSU9j?=
 =?utf-8?B?cHVsbE5NM1FQcFQ4VzhTSE5WTGZ5WEFMUFJGZzlEbzlTR0ZUVEFGbERvRFcy?=
 =?utf-8?B?Ti9CbTdOY2cwZjlnSFRnMjU4cG1HT0VqbzI5Q0VsUXpyWlJIeDF1QlVSWUhq?=
 =?utf-8?B?ektZWEovZE5ubkpUS1ErdS9qeHR5cmZ3eUVUZGszY3pyb3RvL1Z4a2RPbE9x?=
 =?utf-8?B?WXBsc1dDRnR4Ri8yZGVIM0s4KzZCeHdJd1hpVFpwd3hoYktOV2FNUXArZmZm?=
 =?utf-8?B?TmFDOUp2cTYvQ3Z2R0h6ank4VmdCK1g0b3YwT2RBTmlxL3lPcFNyYUdJRVNn?=
 =?utf-8?B?cFJGZ2g4bytwRmdQTCthUnVtaGFXQ2NRV3lrbHlNOUZsZ3UyQm96RTc5SkRY?=
 =?utf-8?B?SVQwY21CLzQ5RXVxTWZjQ3lWZFgwKy9nZS96S1Q4cVBJZXRqUiswcXJrbmlD?=
 =?utf-8?B?Rm9sbmFNQnBXS2VselVUUENobWJmckdoem9oSEVuOEVTSXIycUFSV1hNMVJa?=
 =?utf-8?B?cEJIVVNoZXY1MmNJcUhoWUhrVjNMS3NqMVAzUjRqWFRFOFBLd2lzeFBOUmRF?=
 =?utf-8?B?dXhSTldBdWx4Y2VSd0N5QjlYbDVoYTBweW1kZE1SRWN4d2RZbnk0YWpzaVcx?=
 =?utf-8?B?TjlaRjdiVjZPMmw2dE1rMDVFcFFYbTRhNkg5ZFBkdTJsL3BpbjROV3YvbDFt?=
 =?utf-8?B?VHZOS2hOOVlGd0MvenViMGk2d2RMenJBOEZVd0lUSnRJank3Kzk0aEhubTNj?=
 =?utf-8?B?VEdnaUh1cWIzVi95OUJlNWU1MFRDV0M3N3N6NWpHdWlmZVFOWC9xZGowNWJ1?=
 =?utf-8?B?OUJLREFhcm94U29uZGRja0lOK2NZU3VuNWhaM1BGeE9EUlZVMjJzZWpMem84?=
 =?utf-8?B?WlhYTDVRUjlKZ0tmUXBtbUp5Wk5XU0J1YlBOTGlIOGNGS3lPSlUzT05sQXQv?=
 =?utf-8?B?Y2dIWUFpUER4UHc4ck1Ja1FYT0cyTENYeDl6aHQyWWlZeE55ZE9nS29oM1Jk?=
 =?utf-8?B?OG8wRGxmM1lMZVJUQnA0LzJMSG1wai9JbitJaWxwaXRFU2RzYk1tZkRPOEZY?=
 =?utf-8?B?MkszSDYxendzMStDeWhkc1VxK2JyS1VJaWxjamtrdjBmSk1naTZMWjRSQ1Rv?=
 =?utf-8?B?TmFkQzZlUWhxM202WVdaUnJwLy9RSFVJVUtTOHFGcTJCbW9URis5RDZQaHlP?=
 =?utf-8?B?aDdTTmpBU2QxTUFJT3dyVVV6NktFRDJndXJTRVJ4Um5IQTFCVm5BNnY5b3pa?=
 =?utf-8?B?V05TQmJSRFVScHlKWFZNa1MrVkZJVzFxUkhpcktKOGJKclFEOURXcHl5OXZy?=
 =?utf-8?B?UFZteXNKbGtTYnRtUFk3YzVPbDBUcWgyeWZraVJXZTJRMWEwM1lJMk9mbDdV?=
 =?utf-8?B?L2JOMTZqaDY3QnZMTG5jOUlGQmRoc2VxVVZXRnJyVnlzQnBONExXckI1R2Vn?=
 =?utf-8?B?V28vS3NobzJlSkRYdk5KcWN3dnZvVkNoMzF6MEtKTUdvK1RpalhtYmlISEFl?=
 =?utf-8?B?VllUSWxFU2JjTnVTWVhlRmFzOVdMdHh4dXU1ODdiWGJMNzRtNU5ENk9yK295?=
 =?utf-8?B?Q3RMRzlOYlc1Q2Q2NXp3NllCN2p4L1p5Y1F3U0R1aWF4ZDc1dmZUd0Q1V1Bw?=
 =?utf-8?B?bkNKTTFNS2JiaFl6RDBIem5WRlkrRkJmOStoeW9mdW5PeUs2dmd5cnhJRlVu?=
 =?utf-8?B?bzhhZ1pBOEtVNXpnNWRBMGV3Rm9kQUhEWFd4Vmp2VUdHVXVkM1ZWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a0fe4e-ab9f-4763-22af-08de70c5bfcf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 21:19:36.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzCzCED3C9zRl+FX5hOr4cHhBaX+qFOcOGiPP6v/I1/Z3h8mH9+hK4IaE+WzGv+APP6SXpMJu9vEyce+CBS0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77827-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,amd.com,alien8.de,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,fujitsu.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BDAC16AF4D
X-Rspamd-Action: no action

Hi Tomasz,

On 2/20/2026 1:45 AM, Tomasz Wolski wrote:
> Tested on QEMU and physical setups.
> 
> I have one question about "Soft Reserve" parent entries in iomem.
> On QEMU I see parent "Soft Reserved":
> 
> a90000000-b4fffffff : Soft Reserved
>    a90000000-b4fffffff : CXL Window 0
>      a90000000-b4fffffff : dax1.0
>        a90000000-b4fffffff : System RAM (kmem)
> 
> While on my physical setup this is missing - not sure if this is okay?
> 
> BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft reserved
> 
> 2070000000-606fffffff : CXL Window 0
>    2070000000-606fffffff : region0
>      2070000000-606fffffff : dax0.0
>        2070000000-606fffffff : System RAM (kmem)
> 6070000000-a06fffffff : CXL Window 1
>    6070000000-a06fffffff : region1
>      6070000000-a06fffffff : dax1.0
>        6070000000-a06fffffff : System RAM (kmem)

Thanks for testing on both setups!

On QEMU: there is no region, so HMEM took ownership of the Soft Reserved 
range (REGISTER path). Patch 9 then reintroduced the Soft Reserved entry 
back into the iomem tree to reflect HMEM ownership.

On physical setup: CXL fully claimed both ranges, region0 and region1 
assembled successfully (DROP path). Since CXL owns the memory, there's 
no Soft Reserved parent to reintroduce.

Soft Reserved appears in /proc/iomem only when CXL does not fully claim 
the range and HMEM takes over. Your physical setup is showing it 
correctly. Maybe CXL_REGION config is false or region assembly failed on 
and has cleaned up on QEMU so there aren't any regions?

Thanks,
Smita

> 
> Tested-by: Tomasz Wolski <tomasz.wolski@fujitsu.com>




