Return-Path: <linux-fsdevel+bounces-40564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57825A25383
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61353A4C27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C7C1FAC4D;
	Mon,  3 Feb 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r4+aCl29";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LI3WUMVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C53594E;
	Mon,  3 Feb 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569888; cv=fail; b=CMqh+8UV3AkWQM2cAxoxVgmRQuZLFHrz+s2eLGT/GfnzHMreA+TL4nsl1jGG/XbjhbuhzdPQcRPVqcvqpbKRdPUDzihX//bGgC2yj30j/Vr/Q8/E0YyjqV2cU8NrtmaXOFWxHNUY2vhadvbOGH02C4SYXoRquPRBuPC7Hb+jBDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569888; c=relaxed/simple;
	bh=OK3qVlbKQGUMJ5vPadoKH1cXZPgxVZyAsfU5gTepFqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozE390fxwXqtrQmYv0diHSMP5KBYDvXVsFMKpIPhoYlx/hr6oj2PISJ1FhHskLzNwCCa6mIcTH2/ly/6JYlbc7oqOIZ7ik9Dbk5ApY4+wL0QLH8K1piU6t1fdYoF0rML3PfOwfospBVuvHskrW3SfnufuWZj6aqzGsfHmur6H0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r4+aCl29; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LI3WUMVW; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738569886; x=1770105886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OK3qVlbKQGUMJ5vPadoKH1cXZPgxVZyAsfU5gTepFqc=;
  b=r4+aCl2987owpiZowTcgOUvF7mokK9kfXU15imIRdnS+PDAhQrOcyIiN
   TwWLoNM9nuCuTg3CXcPfzNeTUFMV6+7i1ssrpYTUASwZZRLA1pxDUYB6l
   YxblzRFDU9w82fWIG/7RZOtMBH3LMaWN4K8fAXl4P9MTeWUgOA48CG+o4
   /Iy3WGm2hC5T3Qc3yn3boklWeLCoL98gCLqO0CcAvR87lN+6mFnxPIQ1Y
   ppj3APq2461t1innCsbPa7RivZbsfpt9u6eUc2j+P/MWfIrg/FxRp6hjh
   u0jg1+4IoxtA/OW8hgp9aD6N/7zZPKmok/EOQY2WleKDnRo9l9sUQ9yjY
   A==;
X-CSE-ConnectionGUID: GoARU6DwRIqHPLvUHjq5yg==
X-CSE-MsgGUID: XTUqYyHmRpaz/J9sb6XUxQ==
X-IronPort-AV: E=Sophos;i="6.13,255,1732550400"; 
   d="scan'208";a="37418500"
Received: from mail-eastusazlp17010005.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.5])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2025 16:04:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzhhMCRXWkhEMo5jeMtHm3oN5cgFKzvjP9vOEtdvliCQJ8PkBcqflF5kaPEJZ0TuJiyDhYiTxlVt1y0e4JDB+Z+RD4jjH2Iwc1rhBOHwKWZPo0WfHKdT0iKFTa4m7sXWB3J9MwmAE+4XkRXhiPzoJILyrJxBp3D/XgypQXxttlYZMQfuuGWTwk3FsoVn7JlVVKAoJGLzyIC9fsvc/vuR/H+YrMwyLzkv1q4+wO3/3L0vYG1mQK8PgwdJyh0UTBzNTpq6ZGlqgcQTpkDP89OTcGEbeomwFGUKiGvnQftRwyoPk17q751r8GHOUkYk3909PXB3fWDr76B4DMyfhntNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK3qVlbKQGUMJ5vPadoKH1cXZPgxVZyAsfU5gTepFqc=;
 b=BAen6RCGrllxCvRQkV8lVre8WfaS9oZ8isLrELSl40QjHd3DDsQvXvExQG8f2PbQaM0AoIlmtoCtpLvvYtThz+XJ+IGY/P2vlA3Cr7GTXLSHCVOyv57xVHAKCSIVqfPOSrbkr1llaKfhXD+pVF5Mkw3Az14MphEoB5olxk+SR8jmI/XG+Z+rgh44R3K95N0Z+Rl8SvOnpEJTIykPUj4cQ/RKlQ520YMUhl2GzC+37F6nd+ecSDr5EolPtL8vIrNcSIRCxjdc+KvhjhHbPQ6C83lp1GshXB3PFv/Dp15VPqE5zjE+P+j7BclAz+tm1ljrZFXfRrbhY/ik7Hf2F4tzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK3qVlbKQGUMJ5vPadoKH1cXZPgxVZyAsfU5gTepFqc=;
 b=LI3WUMVWvQJGppKK4Bg60xNAiWAxoYHesU5Czge8KhYeY4VPxK2FDRLhxxvAb9kPH9EWa4nXombktoXKgf5f6h2+F9PEq6dvKGi+2qd7WfQUWUvQZAzt8Y1Fe2byO6KK90WHbYsVJ3ul8JryZh2Qc5PQ28RcQrsiL1EZH2qlzOI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6638.namprd04.prod.outlook.com (2603:10b6:208:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 08:04:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 08:04:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Thread-Topic: [LSF/MM/BPF TOPIC] File system checksum offload
Thread-Index: AQHbcvi+bSfLLTFN0kKx3C8kxByMxbMvYKaAgAF8mwCABFyoAIAAAlsAgAACWQA=
Date: Mon, 3 Feb 2025 08:04:42 +0000
Message-ID: <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
References:
 <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
In-Reply-To: <Z6B2oq_aAaeL9rBE@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6638:EE_
x-ms-office365-filtering-correlation-id: 5e75829e-6968-4177-8d3a-08dd44296a9e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RU1aS3dJSnJwVkFCTmthT0pTZ0VDTVBQaUFwM080ckUyb0sxS01BbUJtQmU3?=
 =?utf-8?B?L1VrU2NHcXJZK2JqaHdmbVFhOHR2Wnh3MGlURGhDZExOd3ErWGNldXNvdy9M?=
 =?utf-8?B?K2htNnUzMDRWdkxnWFF4TC93d2hpTG5uaGszenZmbXlRMHFLdVNLVUR2MFN1?=
 =?utf-8?B?dmFhdCtWcTBxZFBpS1oyNFdSVk5QNU5Gb1Fmam5ldlZaNmowdkkxZWFKT0Va?=
 =?utf-8?B?RFF5b3lCUHRvUjJURTBsalQ2SEhYMGd3V0Yxc2J0V2FZRkVQL1hvRjA5cFFh?=
 =?utf-8?B?d0F5bU1uRWFyS1E1YWMxaE9iSmF3WnZYc0M0NXN2OFdGYU9BaEl3dWNxMTVj?=
 =?utf-8?B?Tk12WGNwMnNPL3BhN1h6endIczRHSlZBUDZUREJQVERXWFYzOEs4bDRCVzBB?=
 =?utf-8?B?R1VyZjhPRE9UTWZQTG9hbXl1ckl0ZEhoSjhRMCsxVjFER2VLZnlOS2UzcG9K?=
 =?utf-8?B?YXhReWw5V3FFTHdmZEQ1eWpuRjVFc28rZG4rTllkbzR6akpVSko5VWMzalRi?=
 =?utf-8?B?bzlGT21VbndSSUgrYXJHaXpPQ045M1A1b1lGUjc5NjhpTW5jYllZS3VKRW1v?=
 =?utf-8?B?MUgwNG9ZNDVLUUp2YUk3bjBYM1E5Y0FaRjVtb0ZrUmVjTklVd05EamliWTdC?=
 =?utf-8?B?cHI3ZkZCb2RHdzVlR3JOTTZGQzFXeVYxZFdydklPeGYxdWoxeFJTUlF2Z1k0?=
 =?utf-8?B?SmVMM2NGWGpYV0Jwak5LdGVCdis2dTUyM3hlUVBBaUJjU1I4WUpzbTVuVnl5?=
 =?utf-8?B?MTc2SFdpdTc4YWtCOHozQkdPTktYNlEwMWQyY0g2QU1OSzVjTjJ1MTRTNmVU?=
 =?utf-8?B?cDlFVTJiRSs1ZzloQThNNnk5T0Uwc0d6Q3RiSmNOeUtFck42a2dNUSs0emgv?=
 =?utf-8?B?VG9iMHh0ZGJha0J4azM5TmJRSlh3QzFDZjF4NTZYYVhnR29rL2NFT2NpODNZ?=
 =?utf-8?B?UVpQMCt1WnpiZXIyUk5oTG1VeFhNZm93VUlBaFFrZ2lRN0w0Z1pWbXVZMHNu?=
 =?utf-8?B?K1FBcHZHN3NFNENSWTJQWjNmcXFHR1RtbG5VeDRqdURwcnVQY3NQcjBZcnJq?=
 =?utf-8?B?K1R6UE1LSUR4UGU0eVZIekpBOTZHN09JTG9sTzBRenZyWVB2TVBCcElodDdq?=
 =?utf-8?B?dGVaOWl0ME02cEVUWVE0OGdTVmwxVnlFTlF6WmsySXllSEMvbHpPdHloeHpS?=
 =?utf-8?B?TEtsdWZuNkg4bWhNUFFXcExiUHFkbXhaTDV3MUVNem5Xd3ZtbE9mR2xmNmRQ?=
 =?utf-8?B?eFJRTnBYSzBFSitnL2QwVjAxNVI4NGlXVXpEUUY1ejlWQld5V2hzeERtVUEv?=
 =?utf-8?B?NGlsTHFRUXBDN3Uvc2NnSFpyR0tSNzJQZVJQc0tLS2VkcHFBUEl4REVHRlFx?=
 =?utf-8?B?S2xTOG8vQkIyYU1iM1NaNGdPQXV4bmdCVkJyb01tNXhNZ05GSXFkamIwcVpy?=
 =?utf-8?B?S0N1UWsvcm40Q2hCK0E4UGhzTUZ1dHpwQVlpZ3c0TnFIMVVJR3JwdmtiRTNu?=
 =?utf-8?B?SnVtTnUxMGl6RWZaS3ZMaStmRlEzbllHY0daVHVLdHV2MWVvanhsRVg1OVhE?=
 =?utf-8?B?bnlFQ0c1MGw5RVhHd0FUVkNkTnExTHpGRzlPei9pendPMCtmTyt6ZytRdC9J?=
 =?utf-8?B?L0g3aUY3UmRyczE1Mk5aR1JMT1Fva1IxMVFWaVVhN3VsMG9IQ1ZOVkhINEQy?=
 =?utf-8?B?V1E1OVJUdnVuSzdLQjJJYUtUQ0htaXptTVg1ZnFqVXVlazIvY2Z1MHdtMGtv?=
 =?utf-8?B?QktyaFgvUkVaWnZhV2lhWnh3SUpxaWFzMGVQTFYrZkZpRlI1dm9jWDNVY0gy?=
 =?utf-8?B?RFhJdksyTXlTWDBHMGcxaW5McGhCQ0h1QXpSVm5Uek5zajREcVhxZFFzd2U2?=
 =?utf-8?B?MTJRR3pqbUw2M3JpY3l6STFTSFAvT25rdzhXcU5abjZHTEVyTzRINjJMUlJE?=
 =?utf-8?Q?1/V5Z2fjKsLIv2bRgURuuvUnBscIJwcB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0hnNlo5TWhmK25TTzJzMnlHT200dFl3SzN3dXJlVXp4S2I2RXgxNVFZTzVv?=
 =?utf-8?B?cURyRlVHWEhJR2k2cmV6YWpSQ2doUk5yM3kxSXNrUHQwM290RzNkVVd3WVdK?=
 =?utf-8?B?OWliNkVZdGtUdXlIQ2MyejJSQTg1RlhrU3M2Ym0xdmRoUTBzK3NiTlhYWllZ?=
 =?utf-8?B?b1cvZ0kwamJFMDVaUE1vNU5nbE5XOUVCK1JEYTQ4SHVBcGxZL0Zid2V1N2pP?=
 =?utf-8?B?UWljTmhFM3ZHS0c0V1ZRbkpMZnIwc3BaU0ZKMndrQm4wK2Zwb2U4WGNaN0RM?=
 =?utf-8?B?UDRlbTF5dHFWNXg5cTNSMEFLVUczQ3JibWV4T2VYOG5vTjBxcEJxY3Y0Z2t4?=
 =?utf-8?B?bysrTmpjaTE0QlpYclpydUlvT1JZVm1TdzZROWFDQ1RSKzFMSHZETzE4SFdD?=
 =?utf-8?B?MTE5TnRpZ01Nei9uRzVFRWh3bUQ0V05adnlYVVRNbU5PT0R2OGllV3RWWVR4?=
 =?utf-8?B?WFQ5TjdPdXdmdGFUNk1LaVhvZEhidytuYmhKTFdiWWVNK2p5cGkvRytyZzVB?=
 =?utf-8?B?NlZ0cXR2S0twOHIxTGNsZW9UU0c2ZDF5L0VXalVqQzZPbTZVWDhMakdqNW42?=
 =?utf-8?B?UUlmUE5iQ3BVcG1qb1NUQURCazhWV2VPekZJTmx1bzZkM3A0RkdwR0ZnMFRs?=
 =?utf-8?B?aFNvTk9GWVVvZUdMQlcxZTg5M1Q1VUVxL3ZPNEVpemJjdSs5Q0lyYTRXUi92?=
 =?utf-8?B?SWh1dUdYOFRBbVlnUkdNWThsK2pHQmdSSkV0ZHhKUzNqWWVyUWc2SFNZbTRv?=
 =?utf-8?B?Z1VsRHRKMlZ1ZU9jd2hMa1lJMnNodEVlZHNhTENEa3hsenl6TnNONnQ3bUlj?=
 =?utf-8?B?K0huRmR1UmVmbThKY1l2cUhHOVQ4NHRwTENGR2swZFVtWFU4dWthUGJLSTNt?=
 =?utf-8?B?cW1hYXN3SzFLTmsxc1ZZVlFxYlFJeDFQa00rYkRFSW9ybHNaVktxdDI2eUpn?=
 =?utf-8?B?ZzNKSWwveXZKbDR2dkhTNUtSTTVZbTZRR3AyQmF6VzUvS0k3MFQ2UUVVcmN4?=
 =?utf-8?B?ZFUwUnR2TFFKTUlNZnR2dmpkSzhDNHRGYWF1M1FvdVJpNHllSmZyRGQyNXFr?=
 =?utf-8?B?VUwxN0JHU2U5eUFiZUk0akdwZDhlMHJPZG9BeWtOL2dzY2orVko0bGV6MG8v?=
 =?utf-8?B?UkRacGVpNHhibGd2cHhSRzFEY2ZyT09aWEVpQVZidklQOXhGZldmUnBLdnh5?=
 =?utf-8?B?eTJGNVdFV09kclI3SWFmODZ3aVBBdFlpL2Jxd0VOeVVZc1IyaEVST1pMZU5Y?=
 =?utf-8?B?ZEN1dzZDRjBLZk1EUk1lQ1BwRlROZlFjOUszd2hsSkl0cjg2a01RSzZpS25i?=
 =?utf-8?B?N3FaSEJtWE40ak1vTlpEckZkWHZPVDhqdHhwNlRLbGNaM0xaL05YMHBCcW5Z?=
 =?utf-8?B?ZUEvaUpiZSsrM1grWS9CVEtzcWd2aVNTMEZpYnlwaVROTGM4Q3dQLzQ5VjhM?=
 =?utf-8?B?UDNHWWZGdEJxRW9PbjlpUGg2S2pVRUZlVDZIV0pSVUYzVGpJUWgzNzY0YzU4?=
 =?utf-8?B?anJ3WElYZU1LUFp2bFk4cm5rRW5tY01kU2xpRGUvTFdVd1NhUGpyTGpzemVH?=
 =?utf-8?B?UlVzLy9TTVc3V1BtZzcwZmpoSU9vYjlvUHBnZ2s4bTFNMVhLSHZTNXNYV0Jr?=
 =?utf-8?B?LzJSNmk5dmFvQzY2bHZOc3hKSzhGRnl3UHZmZUF6S3gzNCsrUUZDb1Zsb3ky?=
 =?utf-8?B?THdlQlNTdFBoMnUzN1hRVDhaZGdyWVJJV2ZhclFhZ3hkQ216aDU1OXhzSFdI?=
 =?utf-8?B?d2FqWXYxdlZTcUlFREhWNVpjdUxuOG9Pc095YUUrYkZLYUxTS1l2Z1hVMkU1?=
 =?utf-8?B?VVM0Z1UrbVBJTU42aDZ1SWNqbG9XVnZHanVBQmpaTWs1OFZmS29MYlh5ZWdi?=
 =?utf-8?B?aS80T2FueURISXByTXRHVnhia1kzaEZralYrUUJVN29LeGVpSkxtbjVua05P?=
 =?utf-8?B?TDk4KzFwSStMemh6T0NVOEJrMVdVYmhQNHJuQ0FrSklUaHlJekRtVlI2SkJG?=
 =?utf-8?B?UVd0Qld0MmdBU2wrK0ZJcTRQOVFESDM2b1c3WUNJekl1M2ROdndjQkRqQmRj?=
 =?utf-8?B?Z25CS3Z6ZHg2dUg0WGJjL1lEejBtK2EydHhBSUJHdkk3ZlVXMXJTZTdwOTA3?=
 =?utf-8?B?SDRJcWtDU1o4S1ZyWGMwNGYrR3crRHdwQW1JVWVzaDVOQ1pZTHdoMmZ0QUVR?=
 =?utf-8?B?VnVVRzZhenBadE82VElaNTcyREF0RjNsZzBrV0UwWENQN3A5QmtYVjRyeUMr?=
 =?utf-8?B?YU9SNEk5SkZqWXErTWE0anhWYldBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA98F956F4A97A4EBAC5B16BC6873E04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5O9nmQZGdHiTQTjMivKHH1Yu4jtTNB8kmiPkMrU1WJgqQk2UI5KnpKJi3eM46cDpk+2brc8Qq6dLr8/ToOquaOQMagWWHT0d9eRDXwoXrYX8pK182LcSyK8QjEBhUqFtBOO40k895T7SvL4qiSY+i9h7WLsIWgTKD0ibCaezCRew99DcKIaB7/DJcTxoqLNtprYq2wSL72JhD5QumtsrwclQuwbSpRGcXmGoqKf0PdTFpxH8TJJwvbW793hDzL9n5S/VJ6mHpCxZZLZkIzqHbfjJZUdRMYyomqAEPJTLiodnQfY2JQ9GVc6+bmZnAoOGtg9Je5hYqcmwMEnmIMUdex9vJdeNFQUVJGd1b2mguQvxoD+GiF2wWi4z/WXKxU+II9Rh/X3moa8aqPs3pPpNtkve4QzpTvcGKQJ5x7hF+JUc8kRJ8L8mlHCz6ZCwDz5tkqsMqASLjwBEf5P6UqXeoe6PxQPXyaeQsjMfiHX0k8W8v0qoavymTK86JTwFbfTlxFnRrxI7whqlMS7QCvg1pezpnlfvEJr0YkQoqGgvoGPqGrZ5D9EOhhJptRanyCEaFDwpUv4GnPlXQqQimc2r3oaGj/p2vn1XaQpVztBAqD7sQA2c+ScX9Rs1xXC6c48q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e75829e-6968-4177-8d3a-08dd44296a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 08:04:42.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw/k04vEXAl/SwdiQgyX/EhkRYQThRglKaphXxiVWugxvuaf439kMKnbKYAjAk0a5bEk/5TX9kRjsTbZgzEnXWFzgRxEOS00ak3o544oSo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6638

T24gMDMuMDIuMjUgMDg6NTYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBNb24sIEZl
YiAwMywgMjAyNSBhdCAwNzo0Nzo1M0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBUaGUgdGhpbmcgSSBkb24ndCBsaWtlIHdpdGggdGhlIGN1cnJlbnQgUkZDIHBhdGNoc2V0
IGlzLCBpdCBicmVha3MNCj4+IHNjcnViLCByZXBhaXIgYW5kIGRldmljZSBlcnJvciBzdGF0aXN0
aWNzLiBJdCBub3RoaW5nIHRoYXQgY2FuJ3QgYmUNCj4+IHNvbHZlZCB0aG91Z2guIEJ1dCBhcyBv
ZiBub3cgaXQganVzdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNlIGF0IGFsbCB0bw0KPj4gbWUuIFdl
IGF0IGxlYXN0IG5lZWQgdGhlIEZTIHRvIGxvb2sgYXQgdGhlIEJMS19TVFNfUFJPVEVDVElPTiBy
ZXR1cm4gYW5kDQo+PiBoYW5kbGUgYWNjb3JkaW5nbHkgaW4gc2NydWIsIHJlYWQgcmVwYWlyIGFu
ZCBzdGF0aXN0aWNzLg0KPj4NCj4+IEFuZCB0aGF0J3Mgb25seSBmb3IgZmVhdHVyZSBwYXJpdHku
IEknZCBhbHNvIGxpa2UgdG8gc2VlIHNvbWUNCj4+IHBlcmZvcm1hbmNlIG51bWJlcnMgYW5kIG51
bWJlcnMgb2YgcmVkdWNlZCBXQUYsIGlmIHRoaXMgaXMgcmVhbGx5IHdvcnRoDQo+PiB0aGUgaGFz
c2xlLg0KPiANCj4gSWYgd2UgY2FuIHN0b3JlIGNoZWNrc3VtcyBpbiBtZXRhZGF0YSAvIGV4dGVu
ZGVkIExCQSB0aGF0IHdpbGwgaGVscA0KPiBXQUYgYSBsb3QsIGFuZCBhbHNvIHBlcmZvcm1hbmNl
IGJlY2F1ZSB5b3Ugb25seSBuZWVkIG9uZSB3cml0ZQ0KPiBpbnN0ZWFkIG9mIHR3byBkZXBlbmRl
bnQgd3JpdGVzLCBhbmQgYWxzbyBqdXN0IG9uZSByZWFkLg0KDQpXZWxsIGZvciB0aGUgV0FGIHBh
cnQsIGl0J2xsIHNhdmUgdXMgMzIgQnl0ZXMgcGVyIEZTIHNlY3RvciAodHlwaWNhbGx5IA0KNGsp
IGluIHRoZSBidHJmcyBjYXNlLCB0aGF0J3MgfjAuOCUgb2YgdGhlIHNwYWNlLg0KDQo+IFRoZSBj
aGVja3N1bXMgaW4gdGhlIGN1cnJlbnQgUEkgZm9ybWF0cyAobWludXMgdGhlIG5ldyBvbmVzIGlu
IE5WTWUpDQo+IGFyZW4ndCB0aGF0IGdvb2QgYXMgTWFydGluIHBvaW50ZWQgb3V0LCBidXQgdGhl
IGJpZ2dlc3QgaXNzdWUgcmVhbGx5DQo+IGlzIHRoYXQgeW91IG5lZWQgaGFyZHdhcmUgdGhhdCBk
b2VzIHN1cHBvcnQgbWV0YWRhdGEgb3IgUEkuICBTQVRBDQo+IGRvZXNuJ3Qgc3VwcG9ydCBpdCBh
dCBhbGwuICBGb3IgTlZNZSBQSSBzdXBwb3J0IGlzIGdlbmVyYWxseSBhIGZlYXR1cmUNCj4gdGhh
dCBpcyBzdXBwb3J0ZWQgYnkgZ29sZCBwbGF0ZWQgZnVsbHkgZmVhdHVyZWQgZW50ZXJwcmlzZSBk
ZXZpY2VzDQo+IGJ1dCBub3QgdGhlIGNoZWFwZXIgdGllcnMuICBJJ3ZlIGhlYXJkIHNvbWUgdGFs
a3Mgb2YgY3VzdG9tZXJzIGFza2luZw0KPiBmb3IgcGxhaW4gbm9uLVBJIG1ldGFkYXRhIGluIGNl
cnRhaW4gY2hlYXBlciB0aWVycywgYnV0IG5vdCBtdWNoIG9mDQo+IHRoYXQgaGFzIGFjdHVhbGx5
IG1hdGVyaWFsaXplZCB5ZXQuICBJZiB3ZSBldmVyIGdldCBhdCBsZWFzdCBub24tUEkNCj4gbWV0
YWRhdGEgc3VwcG9ydCBvbiBjaGVhcCBOVk1lIGRyaXZlcyB0aGUgaWRlYSBvZiBzdG9yaW5nIGNo
ZWNrc3Vtcw0KPiB0aGVyZSB3b3VsZCBiZWNvbWUgdmVyeSwgdmVyeSB1c2VmdWwuDQo+IA0KPiBG
WUksIEknbGwgcG9zdCBteSBoYWNreSBYRlMgZGF0YSBjaGVja3N1bW1pbmcgY29kZSB0byBzaG93
IGhvdyByZWxhdGl2ZWx5DQo+IHNpbXBsZSB1c2luZyB0aGUgb3V0IG9mIGJhbmQgbWV0YWRhdGEg
aXMgZm9yIGZpbGUgc3lzdGVtIGJhc2VkDQo+IGNoZWNrc3VtbWluZy4NCj4gDQoNCg==

