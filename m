Return-Path: <linux-fsdevel+bounces-75803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO0wI556emka7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:07:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6334A8F16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C85302F39F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032737755C;
	Wed, 28 Jan 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOq75HXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594562D0615;
	Wed, 28 Jan 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634444; cv=fail; b=JFEYcUQovCjcPhVKF35GmGGYJbsECf/P7hwETnev8P94JVduC2w6yYz1AXgXpJuhtl1Xf9yr1FhqeSxWQ/L0w6xJtOZCFJQ5UMhtgD078PNUMLTxwsmYnXbLstfEkVPciB0UcnA0nsxd9shAoEfFWXtrvzo4MRCO6LYneXIfK2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634444; c=relaxed/simple;
	bh=gu1iLgaW2QQYi2P8Pf87r2yoNdoJQAKnVB6pMnVfLaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIMWgHCDMWzOO3yMz26iP1CL94xqVjf3Mc/Fa8jns412lVCKkc4URnOkUMMzgHXqYQsYBYGitzo2y3kTYQzrZGIKKxgLSEfXm6YbqspMLMvgMG3+svvLZI4LQEQKpjaNT0GPcbhCehJZ+0QadrBX7Zcf7vcL1cOGZubukOREooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KOq75HXJ; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzaEtNmyZNovkOXv7oQirkBwrrz+y26s7p/KI6dgF+jSqk/9xPrqA4zvg9qsJ3cTHdzhw9ND0fpDEtnMYB072WD3SNgKsgMyf2pvn5twwOrl5zhHw+XW9+mf3Vcd2VdUEFeI1oX/SribsirCMDECWihEwO+IE7d+cDF1OqtKn69lAj3CZCLA/6BypryWKNeFbIA/fRHQDowTThwufdRNRfhmBSH9wxmpCs6LufRp7LHZt4QJhJw85gA9M/eOWiUNtxXhqftZ8FzZQFb76LTUH36l0B3NZA92fACyT5+yx+CJihYYsT1fPFTsO3oUfhKDu+8x1mlp/dDOsgS5F0z4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q64avj/pEaCEQY+GHBObMm5Pw7QDViDGtwXNPglFzL4=;
 b=wDyx5Cwf2lIQV3KJqsEhr9ITaGHS35J9wRgDWshio/44u0aT1LYWWF9pYSaXcGtLl9DE4lq5mutCdjBvn37ikWLvvluieRx/LK4lPP2DciH4cdO6d8xTEZyPBxkn1oupQSliCoYWvTzRtgzF5H6KIeBbVpyXXiw+10X7skH8QrC9GrSO2HnBHJQBjdTcGXLuKCaexrsv3eeDemZib6yzRzyKRbDAcby6gVMSpgDLkS6hnMRezcVS52+JMWwe5DZloNxE/EF1fChD9/Lp2X2woGF3t7Dg/fpg8kxSTdCfxEYKYfGfnW+8DAWBeN794ROC/QIKrc6L680m/oMZS+T7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q64avj/pEaCEQY+GHBObMm5Pw7QDViDGtwXNPglFzL4=;
 b=KOq75HXJoWLROqGmQ4b54Up2ZS8VjGn15p7m1q+zODmSc/9lRl0qJg1NNmMUIRezhYHT7DhwOeUbeGpRSCgQX6gSsdTbm7Gwy6kHP9XYxCg8TkqsQyb7/NUyVkNVkLoo3jJvr3UMdYh2mCgjHJoQP+2vjN3pDLaTxJbAecgCFss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 21:07:18 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:07:17 +0000
Message-ID: <cd63a6b8-94f1-436e-bb5b-fd8de1074def@amd.com>
Date: Wed, 28 Jan 2026 13:07:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved
 containment by CXL regions
To: dan.j.williams@intel.com,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
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
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
 <697935261679_1d33100de@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <697935261679_1d33100de@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 83edc7b9-cb7c-4cc9-d537-08de5eb137f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGxNaklzSm9mWkZDM3MyQng4aytQUTRCMHdXVWRPUWVaNU9Kclg0WHVRS2Zr?=
 =?utf-8?B?QjNMbUVzM2s0Um5xdExrUjhPUmxnRVRaSktSeGNMdWpXSnhDemlrV1NYc0dk?=
 =?utf-8?B?ejlmR2RwcytMdVM4bWJTMWowQTNndTRYMkhvN1luL2luejlGTUxqVXM4bGMx?=
 =?utf-8?B?cEUzUlNUa1EyZTk2bGVGN0s4NDFWaGhOOSt1ZHkxR2ZxZDJER1dKUXp4QTZR?=
 =?utf-8?B?azJuN003ZVF1dyt1d2hvbExuMjZteDVUdVNLZWE5enhpL1laUDBsTk5ZUjc5?=
 =?utf-8?B?TG9ZNUo5MGhZOTNoRmF3ZVpRY1pqeitRN1ZUcEt5WXpiaVArTThyaFlyd3R2?=
 =?utf-8?B?U3pRbDZwUGlWV2ZMSWNHMy9PaTVsbTlDU1p1WmE3dzJ3WDF5ZGtsMmxldXFv?=
 =?utf-8?B?QVE2ZE44Y3dRMVp4K01RQTkrMXllcFMrSzhDdWF4Um5mRGN4dTVGQ0Q0QmpM?=
 =?utf-8?B?RWs0eXlXTkNwMmRmb0J5b2wyUDZuUTJ1bTZHcEJwdGoyZU01UEJsTGppMHh4?=
 =?utf-8?B?RHVjNituc0llWlhXL05Qam1aSHNiRFphOXZTd2hsT0g4RkRDdldrNUtCc0pn?=
 =?utf-8?B?MzF1VXIzVTQyNk5PVzZtc2h2U3NIdW15bzVyM0xhZVBiT09ZakZoeXp0SE5C?=
 =?utf-8?B?UkYyb3NEdEdFUzNIRUNYWURPckF6WG5TVThmOVNmeGxnazlENGsrTitVRDNr?=
 =?utf-8?B?L3RMdkJsays4TkUrZ2JTMEtsdVlMeFovTGluajBaUytlQ0prOFZOK3d5RDc4?=
 =?utf-8?B?M3BHMEttMkNYUk9yZEZUSTJMVUxrVFdCSGxmWklDTU5XeDFSY0JCVll0NTQx?=
 =?utf-8?B?UHFNN1NFVTRBVnA2N3daNmt1TmJYUzQzZ3VmaXdDcWtSRXB4N25aZU5SZE9t?=
 =?utf-8?B?M0p1VjdRN0xlNWJMYkZFK3lQUnZtNE9RcWRSbUswdmlsMjBKcTBDOGZEQ3BD?=
 =?utf-8?B?Q1EyWmwrVENzT1ArOUxFYXV1TWFQaWhveXVqMWprWmRIY1BsOGZac2ZMd1J1?=
 =?utf-8?B?UnlvcWkxMnJUZ2xNWktOemhrdUo0cFkxZ1VIL3RqSXBzTHhVR0FvcC9hTWtr?=
 =?utf-8?B?UDNYS0JwTFBuNW8yK3EvM2UvQXBnckh5cE9NT3JodW9SeWg2eUZGdXRYdDV3?=
 =?utf-8?B?NWdDTDZkZ0lTVy81SVN4RWJiY2tKaFh2VlVTQmk2RmVGeFhqcWpnazZwcnNC?=
 =?utf-8?B?MEF5Uld5TWFYSGNaam5McDluMXJkeXdLNU5vdzZLQmtrQkZGUFlzbVpzZkYw?=
 =?utf-8?B?TXlwYU5EeUxQNVdSV3VSWWNJblUzMUpFc1lHN0F2bVg0WjhtVzRpKzJ1OWhR?=
 =?utf-8?B?RjdDV3FGUEIzMWw3MWlJT1lPeVB4ZFIrazRKOU5aSldSVHZ5N0JyWEhqOG9J?=
 =?utf-8?B?UXJUUGF5emcvSVhVNnorMW1kZWtxdUZIZDJ1THhud3RVbHNNUG54ZUtOUnVn?=
 =?utf-8?B?dVhrSWN3Vk1BS3VrYW0zZXhJaXBweVgycUFheWZsUmYzdDNaeEtCVzBYTGJS?=
 =?utf-8?B?Q2Z2Y1IwYXU1VnhZbmJ4OXgrdm9qZnhBQWNHcXZ2Z1VhTWtqMDlIM1ZlNURH?=
 =?utf-8?B?RWh6b0U5WHlnMmUyNzI3dVVNcnQwbWdndTJqWnBoTE9VU0RKOC9FMklnRnor?=
 =?utf-8?B?T05oL0F4MXdyeG5XWDZkaE96WE9BWjZXUlE0T3Q3RUp6bzRBbzBMbFl5R3cw?=
 =?utf-8?B?cU5URDZqSTFocXpGcGxNcmxreFZ0ME9ueWNvTUNZY0NuR3RuSnNNTEwyV1Bq?=
 =?utf-8?B?N1F5SnhLU3FldW9uU0swUHJhV2FqQno0YUhsQUZyQ2txNzdtYUt3NFZ1b0du?=
 =?utf-8?B?MFRGenVMZ2FFTmw4WUtNU3g3U1FUMUU0NE5ZdjVCdzV3NXVJV2tNbjdIUnhK?=
 =?utf-8?B?LzlEVWcxMkpIWHVqcUR6eGRNTmoyNGRuZzBzdGI0UGZENllEWEhyNEZXVG9r?=
 =?utf-8?B?UVJJY0VnM1VZNkE4ZDJzK2E2T0tGV3pTUklEY1cxYTk3eHJPMFVEUmh3OEpy?=
 =?utf-8?B?LzRQL1NnZko4SXdWcGdlL1JZTk5ORmdtSDBXQkNKc1Q0QWdsMFdaYkxUV1VU?=
 =?utf-8?B?NEpUVFNmYTlZdmttSUxIRk1VSmxJbG1IODNWZk1FOUUrY3NLQVpkSnBRN3dV?=
 =?utf-8?Q?ENJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHRlaExLVWhuSzVjbTA4U1h4a1VhZE5ZWDlQVVVrVnVaK0oxRmRZeXd1dGR1?=
 =?utf-8?B?d3lCRUk1OEFIcGtZREh2RUhUMUlXWmhLaCtRcCsrc3ltcUNJa29OVHFOVTlp?=
 =?utf-8?B?QWVwMVhFMnpzM05pZERST1lrbklkclpqUnVrYWZnZ3FCVVozMG9NZGd4Zm5J?=
 =?utf-8?B?OVd0MHlDUmMzVWxzcmQ2d1NoZmZMMTVkZ2hqVnlqOVkvaFUzQ3N6SkF6Wm1X?=
 =?utf-8?B?ZzBreVg3NCtaTmZYZHhhUW15ekRVQ0VRb2RIdjA5cDlZSEEzaVp3UWxlMEZH?=
 =?utf-8?B?bmZPZWRtbjRORWZrNm1kd2ZaUFBHbmxJamVoaWRBQkNjL1VnZG1RdjdjQXh0?=
 =?utf-8?B?Skl3dXNhOWtjdG1LM0FBbHF0L1d0Szd6NEJEeDA4UTNBbWdrVUpUa0xhcll5?=
 =?utf-8?B?dnk5dkp4OWgwcGFZcW81SGNOdnhVK3FiVXJJOUtsSjVEMGVYdHQ5TFB5Lzgv?=
 =?utf-8?B?MWZNZGdBUzZCbXY5VFdPSkgyN2EvclIxME5hcFJ6R3R1RHdzWHFHTnJ1N2tq?=
 =?utf-8?B?bktTRWl1YmdMSTMva0ZXcnBKdGlWWjFoVzViM1RqL2VNRWtGem9pNWpyZmNu?=
 =?utf-8?B?TUJFTUtxK1hxdk1JSnBYTng2Q1hJQytrZGYyMnlEem1zbHJtd3RYdkdLc3RI?=
 =?utf-8?B?Z2JCY0JtVTdFc3ZJZi9sMGg3TDNKMjdjT1UybmxNVEYySDlkYXlscEwrb3d0?=
 =?utf-8?B?Z1hTVmlFUmt4a3Q4MEN0TjVuZmpwNjdOY0RDZ05nZ01SSmNnZkw0NUFWb0Ns?=
 =?utf-8?B?NjlDeTJJckRHbkdRa3VncHhwcUlkNW9zZlA4ZkFhMUo4QVRQM3ZNalBCNndY?=
 =?utf-8?B?bzE1RVVFTCsvTkZKdEMzeGs0eVU3Ym1OdEZ4Q21Ob3NlaEFTdHd0VDBsVmFv?=
 =?utf-8?B?c3pmK3YyYVRaMnQwRGR2OWpzWitoZUdxYzFxbEorWjR5LzFQaVdOUlJwdjN1?=
 =?utf-8?B?cC9jd0tycW4rN2NIak91Zk9NUnE4NGs4V3JpWUh1dks5blJVcjJ4U2g4YktK?=
 =?utf-8?B?TUxzZEtIQVNobExacldHMzE5aTlzUk5xV0drdzQ0bzVhVmtyOVgvWnZjYTNm?=
 =?utf-8?B?UTFGVmNzSUQ4V2N4Zm5GOU1jM1drSzdnekRYMDlWVXBxOWhqSC9DNjNlYzZu?=
 =?utf-8?B?WW1ma0JtMWVKNEVRaVU4Q3VzdnZLWGV2K3lHeUdlVWF2ZjNGN1dzbXZxUzht?=
 =?utf-8?B?a1hPcjZ5YkNCRG9VZXMvdWZ5cm5VWjNmdnIyZUh6WU11L3ZvWnQ3UldrT0h0?=
 =?utf-8?B?OHdIOGF4dlZ3RWhRdnY0aVQxaFMwVjB2czkyekhhZUhaSjArOHN6L1Zndk9S?=
 =?utf-8?B?aFNjckNNMXhLVUxyY25DVjQ2UGxVSTh0OW9wbXROOWs5aGFOT3d0UmQvSnNM?=
 =?utf-8?B?Qm5QdGY4RXBweTBBUnpZeDg0M0JKVjl2NXgyMnNyY1I5eGZTczZDa01DR2pp?=
 =?utf-8?B?VWdDTjlacVpCY3Z5OXBjN25ybjJSWG9pejdaV05RQ2Y2VkZiVlNoUWFwQmVq?=
 =?utf-8?B?a0gzQnQ0ckRhS3pnazk4Z0FIcFR3Z01CU2lrWGFDbEdKdElRNFA2c3QrUWRZ?=
 =?utf-8?B?RnVyL05yKzNqSDc1aEcyUGthbXVlUzBTY0tKWElrMWsrcytFVjhrYW45ZWxi?=
 =?utf-8?B?UHNYUTNjdEtRNEhnRkc3MkREYlZBZlVOWFRkajZQUm9FcDVrcUpMR2NwdVQ3?=
 =?utf-8?B?UEhDcjRxaU8rQWhNVEh1dXJvN3NHQ3A3YUJwTFJWMG1HNHN4VEhFRWRTRjF6?=
 =?utf-8?B?K3VGSmVMMVBXWTZ4RzRJQSsxK0IxK2ppdzQyOVcrd1hzcXhsalNRTWlTTHhm?=
 =?utf-8?B?cHVKb3RYUmdtSlg4NVhQMTNvWDk2cEMwWlM0b0lsaUtsWXZtQWVVVHMyOHFW?=
 =?utf-8?B?bmpSY2kreGw5cHQ3VVZFY202amR6NHUzWmQ4ME03TmZhYzhSZTRCeDFOMEM2?=
 =?utf-8?B?MWdnQ1RPd21PejBVUTlmNnhLKzNCcUZsWkt1Qlc3ZWxPWS9VeVdaNGE0QmE0?=
 =?utf-8?B?VXl5UVhaVjhBT056YTBIQnZ6QlI3NTY4NG1XT3A1WStLSG5NbDR5YW5tcjJp?=
 =?utf-8?B?WWx4L0lROHRGcm0wWFVGcS9zVlNiSk9qbUFUdDRGZDlDdmNZUHNXRnpEdW00?=
 =?utf-8?B?MVlZRGJWQ0VBbTJvVEVSVzNFQ01KYitjTGsyS0Izb3B5Nll3L1FPb2ZEUEtZ?=
 =?utf-8?B?bGFQS0xQU0dyY2ZnYmZwbW1pSHNwdTIvMjdUaHR0Q1FMOWxXVktxdk92RHA3?=
 =?utf-8?B?NnFSeGQ3YmpvR3pVSFBpdmtSeURkT2NoVk5kUjRZZVBFRFE4cXo0elZ4T01t?=
 =?utf-8?B?bjkzeEN4Qm43UUVvc2t4c2J3b3V0RE1Fa0QzcU1MVGpRTldORzRrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83edc7b9-cb7c-4cc9-d537-08de5eb137f7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:07:17.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIjwHNyIpetNRurqjOS/nYc6vI/vJJmd8J58XRD9qxeviJQLZMaShM9Qhzz8YW0a8H18KGMXogwBiYfyoRJieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75803-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6334A8F16
X-Rspamd-Action: no action

On 1/27/2026 1:59 PM, dan.j.williams@intel.com wrote:
> Smita Koralahalli wrote:
>> Add a helper to determine whether a given Soft Reserved memory range is
>> fully contained within the committed CXL region.
>>
>> This helper provides a primitive for policy decisions in subsequent
>> patches such as co-ordination with dax_hmem to determine whether CXL has
>> fully claimed ownership of Soft Reserved memory ranges.
>>
>> No functional changes are introduced by this patch.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 29 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |  5 +++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 45ee598daf95..9827a6dd3187 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3875,6 +3875,35 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>   			 cxl_region_debugfs_poison_clear, "%llx\n");
>>   
>> +static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>> +{
>> +	struct resource *res = data;
>> +	struct cxl_region *cxlr;
>> +	struct cxl_region_params *p;
>> +
>> +	if (!is_cxl_region(dev))
>> +		return 0;
>> +
>> +	cxlr = to_cxl_region(dev);
>> +	p = &cxlr->params;
>> +
>> +	if (p->state != CXL_CONFIG_COMMIT)
>> +		return 0;
>> +
>> +	if (!p->res)
>> +		return 0;
>> +
>> +	return resource_contains(p->res, res) ? 1 : 0;
> 
> I suspect this is too precise and this should instead be
> resource_overlaps(). Because, in the case where the platform is taking
> liberties with the specification, there is a high likelihood that
> driver's view of the region does not neatly contain the range published
> in the memory map.
> 
> There is also the problem with the fact that firmware does not
> necessarily need to split memory map entries on region boundaries. That
> gets slightly better if this @res argument is the range boundary that
> has been adjusted by HMAT, but still not a guarantee per the spec.

Hmm, My reading of your earlier guidance was that this logic is meant to 
be coarse, and is acceptable to fall back to HMEM if firmware 
descriptions don’t line up cleanly.

If firmware takes liberties and publishes ranges that don’t neatly 
contain inside a committed region resource, my assumption was that 
failing the containment check and falling back is acceptable.

However, given that the SR ranges HMEM walks are already filtered by 
ACPI HMAT, and that there is a relatively low likelihood that a single 
HMAT range spans multiple committed CXL regions, it would be sufficient 
to treat any overlap with a committed region as acceptable?

If so, the description in patch 6 should also be updated accordingly, 
the wording around fully contained would need to be relaxed to reflect 
overlap rather than strict containment.

> 
>> +}
>> +
>> +bool cxl_region_contains_soft_reserve(const struct resource *res)
>> +{
>> +	guard(rwsem_read)(&cxl_rwsem.region);
>> +	return bus_for_each_dev(&cxl_bus_type, NULL, (void *)res,
> 
> No, need to cast pointers to 'void *'.

Okay.

Thanks
Smita


