Return-Path: <linux-fsdevel+bounces-77076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGAGGNbLjmm/EwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:59:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0851335A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1432530091DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FD27BF7D;
	Fri, 13 Feb 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YIOZ60/f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vo/jwhBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDB2517A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965968; cv=fail; b=FhmxVszPhTHiI0HCFTMjJ8LMIZLQMnxEEWq849YcO1+HfltgfZl8QAznSAIYQd383aUMxTv1/VjrtPqcUdovGZiE88SwPvx4aNsKc4E2LzFm/6npz4+TpbLktCmnSCSUV/qEa8Mc4gpHW7dZEBbH0zDa7Tcb89flWzaXAzZnTBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965968; c=relaxed/simple;
	bh=LSYQJkaXrvIOJpA12ju9UZmUDbBZ3L503aZFHkCWdqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUZlFgHsFFNtFWaLkslrMBdMqYUXPg/Z63yNc1VMlJQ6pmSSPTe7CbYeRixLy9SiqocHTYbMBttl1Wi9X/bD/eIsK9/TdmVIeYx76ikJz70SduFjp02Ad50Q4fy7jW7bGd3cMIcQG1sLiuUvf8cHkPb9Yy38onI1O2TuDK/Gy3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YIOZ60/f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Vo/jwhBL; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770965965; x=1802501965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LSYQJkaXrvIOJpA12ju9UZmUDbBZ3L503aZFHkCWdqA=;
  b=YIOZ60/fY3PQRph1Sfwdb4OH12ejzT9a+jgrnqrw1oLGpRuhsMyq/VNe
   Ffje3+lghom+x647so1tjUMwNEbKzfJlwtixmt4qhFSLPbTKDB9tR8sNO
   AfvCPT7gGvDija58Gcx39ceESM/xgP7EOLrqVNDe8x/u/Dn/D6tJZSAyL
   Wmw93P6sT5fYGltqoZDS7WCo0Drd/JEBtw+biIw4BhX/RltyM74FsOLoR
   54aNknb9BAXvFoEw+uZmNGPm1OBLuQQJ1W6YITT9tYbe6n7/bSQ3gZoCL
   bKqUn73wz0TXFWEjKUEQjEp4bl395Wvrhmyl1p25dZkOpUemSkib/Afus
   A==;
X-CSE-ConnectionGUID: FQVa86R+S4yBIF29kO0vqQ==
X-CSE-MsgGUID: GgQUhI9iSsamDwd1IgNklw==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="139794748"
Received: from mail-westcentralusazon11010047.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 14:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxih6StY+7xQn9NqLUlKVgVcZzZ4GK0AOJrlmSj5bsGoQsiuUQNx/4d77ZUfD+JQmQcUahNYe/I5nMfO4kftJscvnbKs8XttITvMvcN5gRuz5FbQU0pUR8N7md6utx4pvGXkhZcO39JU/sPGEme8CwVmjJdNxjR0wsTZqW9vbDfG65LoF2udb8I67oCheFqc+ow2kFpXMtsacrRgpaRZngtZDJKCQHBQnxnRDDiKgggmkkcnIumqRgHnbUnP0M0jIlIk7H+N83CTu6pUY/dpJ0lFcv8CdHTpF5BXiZGgR8jlnVqODH6qYeI0gj1SXOHhPla7nj6jhc2S+BYDKHkyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSYQJkaXrvIOJpA12ju9UZmUDbBZ3L503aZFHkCWdqA=;
 b=rE/6qPUu5SMxrk6jIM3Lm28wkEGybT1rbW9ebZtSCAWDrwC3xaIWnOcjijkjo9b9Q6p2tFQRXzJJcCc/PrBUw1SkQ2lRUFE0sWNyehQFZAN/baYa4eScB+fwe07xMHx7LGJ3Rai+qON6kNIT9mKGW4hGf/XDzzul281afS3PClyns9OvN80YzmrZebumtCzjKf9qF2cGbyiF5Iy9Cb9UoZIc+a8aEJe/1YUdqw04J2MQnqUDpP05kty4fo78cErZTSLCCh19Fwcf8rQkGy1mKJ6Pj+Q3SMbfGgCWZ83AOVnt6auq+tlwjqMctr9uEqQOQy4CXtFXjY32LuncPGFxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSYQJkaXrvIOJpA12ju9UZmUDbBZ3L503aZFHkCWdqA=;
 b=Vo/jwhBLA05pFJjv+HG0xE8RvePj+jjd6AOHtk2ULj0LK7QmPNmfMKBalE6pfAxjhaC2aFmw23OOXLXyVCL0s2zE1arzFR5C858IThRAiA7Wu5nfp/nCtp8YO3U/PAHtgsseDmHip/K5JZvTQHtHjkO7Oj9w0sK7XdCbPmoMhXI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CO6PR04MB7476.namprd04.prod.outlook.com (2603:10b6:303:ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 06:59:22 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Fri, 13 Feb 2026
 06:59:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>
CC: Hans Holmberg <Hans.Holmberg@wdc.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch
	<hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, "jack@suse.com"
	<jack@suse.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Index: AQHcnCVy0zbMvpaPJEe12Y5TD3XDD7V/ROOAgAAN6oCAAAFkAIAA4BKA
Date: Fri, 13 Feb 2026 06:59:22 +0000
Message-ID: <62ccce85-2f2e-479e-a1e2-b6821ef6b1f6@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
 <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CO6PR04MB7476:EE_
x-ms-office365-filtering-correlation-id: 9657b717-86da-49dc-59c5-08de6acd6a88
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDcvRGplajFmdDdKcm9Sbm1kWXZIb3lyNXRCeHN0bjh5U1ZhYWNhK3czZkVJ?=
 =?utf-8?B?ZndXdWpwSVFpcXBMa1NsRFo2T0E1cUxtS3U0TUxidllSbnRyV0JjYnAySEtN?=
 =?utf-8?B?eEN4dk16SEZFaGpTS0M5WnVQSlN5aGxoazdZUVZ5L0RiOHlIL1htdVMzVGRO?=
 =?utf-8?B?UkdJNU9jclQvUHBZVk9MYmR3UDNYeUVFRkxYV2ROQUVLbzR2UVFvRThIeThF?=
 =?utf-8?B?bDVra3JMRnFSZzlmQmlvSjh2TXcyU3Q4cWVSb1orb2dNMUgzQ014N0o5SXNw?=
 =?utf-8?B?eDd0elRyVnZGbGgzenRhMjlHVjVpMFRUV2hINUUzTkVzcE1vVHRHWlVNSGxt?=
 =?utf-8?B?NEVUVXBaYzlCQmdjK3JDOUo1ZHIwMmtkZTN2TlFUQndqOU9zOTI0c01zUUFm?=
 =?utf-8?B?bkNuclV1VVJEMHRvZlYyb1dVM3FaZmc3cjcyeE1KSkE3TzBnK09WV2IwL2Zh?=
 =?utf-8?B?ek1tTHFkS0JDb0FFdjcydFpNK1lNQ0o4dWg5L2tpOUJiclFnWnlxUEh6OVY0?=
 =?utf-8?B?MjI1Tk15a2JRSEFJelp1dWdyNnVNTHpGTGM3Sll4dWY0dHpFbzlmRDU2VlBv?=
 =?utf-8?B?ajFNV1lvR2dYZWphQ3NDKzEzbzdvREE0NUNYTll4TmNISHQ5TldQWDBuTXlq?=
 =?utf-8?B?WWREL2pHWTRhbU04THdQVVVHT29BQ1NUNVExcHhvRzAzNG9yMkN2N0lHYWo1?=
 =?utf-8?B?ZldhR1dPVDVuYkZwMGlXenRoMjFabDdZRjNmZHRJdDdCcUVqSWc0Q25mZlZ3?=
 =?utf-8?B?KzVXanl0dnc5Y01jUTQvcUFOMElxbDYrMk9xV1dPajFBdC9CNVZJTSt6c3hS?=
 =?utf-8?B?TWljOTl5QjQxQnBqbjFIRC9XazBLdUdaWGtDVFFBMUtCajVrd0t6MUxBWGts?=
 =?utf-8?B?OEJuRWw5Y2ZKNnF0UXhJMmhsM2NhVjA2d2JRTkk0b2J6cUZ3RnQ5TnZZRmdF?=
 =?utf-8?B?OCtqRk9aUmIxdUhSSzNlQWRINE5vVUV5c2g3TnpXZS9iQXlZeHpoM1lpeGdN?=
 =?utf-8?B?RFp1T1preUZ2bHkwbFovNkM0M0tnb21RMllvSUY1NGhUUjFxYVJlbUM2WVFY?=
 =?utf-8?B?TnRsSzBWelJnSlhmRXRxVE9sbm5Bamw5dFFPZmdpZHFZY0NtZlZzOUYrQ1lN?=
 =?utf-8?B?YWVWVzgycER3Y0tCOEo3YllXODhmNEU1THlrb2xNNWFPaXd1b1N5NmxSUUhk?=
 =?utf-8?B?V2g2RjJZMk84NUphY3lKL1k2Zi9VdWRPckxqb3R3UC9OamlWeGJON1Q2TDVv?=
 =?utf-8?B?bzNmclNJaU5CazhRRWhtTnAzaFNmVlB4N3RadTNmc1NIWEN0VENnYVp1Y1Fk?=
 =?utf-8?B?b0lNZmJod05QckdHZGhzcFVGam42ZEhEVDdOY0M5c3FpN0FtTFM0YzFCYldi?=
 =?utf-8?B?LzVzMklkaVpDV1FnOGgyd3FtazE5TzlXRFRoTGJyeFphU3ZUNTY1OUZjTzBv?=
 =?utf-8?B?eEE3VVh3dzBudVJWeDNuYVVVL0NvNHZESjczZjh5V2cvV3V6ZlNmSXArSi93?=
 =?utf-8?B?RWpBVWQzY0p4Y3hMVFV5OEtUOUhmYmVVaFdiUlBzR3dDdHd4UXpTWDR6U3pR?=
 =?utf-8?B?SDBoeGJVQXkrakNnclRwNkN5UnZsWFNsVm90eEY4OTZLZDQyQktBN3JNdjJm?=
 =?utf-8?B?bFR1QU5CYy9MRzhxclpSMHZZc1RCQUYwM3BTY0puekowTUF5eVljd3luZ2ZC?=
 =?utf-8?B?Rmcza09qcjRmdlBEU3creVhybGtCVWZ5akJ2bHFyU2hwNS9jV3piMmJXTG4y?=
 =?utf-8?B?SmxrWmpxM3NPT0JSZmZqVXZPYm9DazdHaFZNOFdHR2RlTnFLamhudGZGV2x2?=
 =?utf-8?B?QTBCTUs5Zzc2QWl2aWdDN2R2WnhmbXpTOUYzdEhZZFJZMlpCQ3VQR2RRazdK?=
 =?utf-8?B?bmhkK0JaYlhxWEgvR3B5UldmSWJ5N3VFVndhTjhDUkpvLzczZzZiblIxZTlz?=
 =?utf-8?B?cWhyd2d2VVJ0TWNmZEdhUUNkeU1KSWNIYW00SUFHWjExTmhKMFVRQjlHK2Mv?=
 =?utf-8?B?ZzVrbW5PbUNVdU5oT3YyOHZLS1NFWVVkL1h6Ky9ySjNvWHRlcVhYbzdaWVdO?=
 =?utf-8?B?U3Z0OFpQN09oRzhvWncrLzFLZnpSazlUNDB5Tkgrdk5oSTdkL2FweEZiaGE3?=
 =?utf-8?B?dm5qT2dtY0VONEE2aXk1ZVpzQTBsQ21HcVdMT1RhMkJqNk5DWVBiRzJzalli?=
 =?utf-8?Q?7Jr4iu/GVAodufD2A9n5UmY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2l2NFBkUnhBUXJEcUsyR0Y2N291cE5wVExLMDhvaFBxK1JEdjYrbFhtTEVP?=
 =?utf-8?B?MjZHYUNEMmhxdkxaYVo4MlZ6S0E5c0k1bUZ5UVhyTVhwY1BPQi81SVp1bkU1?=
 =?utf-8?B?SFFhcnkzcjFyNHNNOThOR0c0c0RKZ3FQTk5CMnpybEpXbGh4aXVZN2pjWEJj?=
 =?utf-8?B?R3ZLaWJ3MHhBbUttWS9FR2s3SUtPNnZiV05ZRkFMaUF1UkkwMFdmNFFBRGU1?=
 =?utf-8?B?K0trVHFFMDljQVV0Nk8vVFRlSGlDTms0K3NSdDhOK3RnOTZKcWplbm42R3ky?=
 =?utf-8?B?cTZCclN4TkdsUE4rT2dweUpMQUV5elliNnh0Wnk5bm1CbDVNdldkWFUwNGZB?=
 =?utf-8?B?V2JrUTZUN01vWUZNblF3bW5OSEU5OWc1MVREbU9zYTJVaGQzVnlPR1p2MVlF?=
 =?utf-8?B?T3ZMRmpTNmZtWXZZcFlkd0gvdGdOL0tkN0RMbVZkQzNTQ3NJRVlISkRONWNM?=
 =?utf-8?B?T1NXQzhRaXkyeFNwZ0xKSVpTU3BNTHY5alJzTXFVeWtqemNvYlZCOC9FMWF1?=
 =?utf-8?B?UmFXQUp4T3czV1BXSWp2cVFrTXQxUFMxY2lUTDRWYVhNVEFabkMwd0dkajBa?=
 =?utf-8?B?TURTaTE3ZWxGL1lSZ0xIL2F3MDBQMVpndk9SSmIvZ1crT0U0eTFxNXE1dzBI?=
 =?utf-8?B?bHA2UFhHbURvZnRBZVhLamFEd3RCaFo1L01GNFk1Z0lzWGFBYzV1aGk4b0w0?=
 =?utf-8?B?YTR3aDJ6YXdralZsWFlGUjArQzdBM1ZOckFzbUNSOHlBVFVQMURaZ2hWR0Fa?=
 =?utf-8?B?U0huMlY1aU9naCsrZVRxVGUxUjVQWDVoZ2kzRjZpMG12cm1zL3hiNC9hMXF4?=
 =?utf-8?B?Z3F4eWo1T2NYbkl2YWtHcGM4Z0hIcWV2OCs4T3BPVGdlVXhxTytjZ1B1RHdC?=
 =?utf-8?B?UUFxMEEyOVVXTjhRMjJkOU1aWjNnOUV3NjI0VTl2dGlKclR0NEZmNlh3N3k3?=
 =?utf-8?B?a0FhYnVOMHJaQTRDWlUrbUU0T1VVRmlzOEJCK29IVVNMdXRHUTY5ZEl6NDJZ?=
 =?utf-8?B?ajlNWE1HUlRDcTNzNG9MZzVuKzJDNmxYVmdiMktSbjY0YmJqbVJVekl4dUlS?=
 =?utf-8?B?RzgvdzlYWnFwQld1NFZmMXozSG1JdmN5UGhGcDlmNFVMWXhTcXcya3FjNmN5?=
 =?utf-8?B?dms1Z0cwUFVHY1UveTRKNWhub2kyZHE1b2VjQzhXZk8vcFNzVm5OclJjV3pz?=
 =?utf-8?B?VHNJejkvdGkxNVdDbUl0MzNuRGJJRGhQNkZielVRczRCRTRtenRlaWdvRTly?=
 =?utf-8?B?bFFPNGlGRCtCVCtkdEQ2WGxUNU1OeXNRMWVWQkU5U1psMTdWUTNiMjg0TWcv?=
 =?utf-8?B?YVQ5Q0svaXB5VHNWUHVkaTRqR21nYWVvQTVUV3FLbm1McGIrZnN4ZlowNHY2?=
 =?utf-8?B?Ym44WVd5QXhIVzE5ekRuS3VwV1NrMldlbHZCVUNNakRXcFlDcjBKejllbHp1?=
 =?utf-8?B?dWlIZzhzVzRZVEU2SHpnT042bWVZR0ZZa2lWSnZKUFNYbXpRQ0JWaHZhTjdS?=
 =?utf-8?B?aGloL1FvUzlhNm5UcjF4MHlrM1BOUFRGT3dmbEJ3bkhCazE0Tm81Rm9NdnVo?=
 =?utf-8?B?SlVpdG5kTmNVcEV1RFpZZmR6cGpraVNaK0ppdXVIQ0p2akl1WE9ZeEcvUkw2?=
 =?utf-8?B?TFZnU2VETWhFbjFrY1lHUzl2YkhTUlA3cGkwck1JaTMwT3NFWTFQM2toS0wv?=
 =?utf-8?B?QzFUQys4V3VOd2Y3ZVVqSkMwM0FobTFkekhsNEJLWmI2b29aRkZVVFFtTW13?=
 =?utf-8?B?MHdqVkRzSFZkVitDRFlTeFRxanpnODg4OWlKaDhZMFdxVGxZcjUyUUFUcUVK?=
 =?utf-8?B?QXpla2FDeThZSVZRN2V4dzA2cTlrdGkyMFhxbFRrTHNmRHZjU1JTdDVJK2to?=
 =?utf-8?B?SG93WWhXSnlTbFdwK1dFTG84K005T1FuYWhOUFd1a0FoZnFTMnRMUFYzZFlp?=
 =?utf-8?B?WjN5YnJwa2d0MFJHeXA4ZGp0Z1VLUVhOdWpSSllvTnVWTXJJczZ3dlF2UE9x?=
 =?utf-8?B?ZVpHdmpzUWZ1QTZRNy93aW95dmlOc001Y0E0VGMzcVJvQmpYakphczl3cGtj?=
 =?utf-8?B?ZXlScko2Z1VsZVdKemFiSzhSeGtkenlCN0xMQmFrL0ZYaUY5VXRZdU56TWhC?=
 =?utf-8?B?RVhNaldhVUx4SGd5d0x3TS9NNFNQbk9qRkg4ZWNoZW12bjI1RGh1d3RwMlEy?=
 =?utf-8?B?ZnhkQXhaR2V4UEs3YnB0c0NCM1BTd3ovdjNTNmdXbXdQOWhpcDd5Z0l3SFRw?=
 =?utf-8?B?TnB2cFZpaGUxMVRBT0R6aTNzcHB2T1kycmw5bXdIN1gyYWxua29oTU9zamF2?=
 =?utf-8?B?QXRwd29YVnlJbHcyVkJxdVNvNDVTNHFvaDMzMkpUcitlYjRFY1BJY2VXMmxC?=
 =?utf-8?Q?fzCrniqauAl6KouhFzb7I4WEn8kw+uHjoN7jnedhfo+NR?=
x-ms-exchange-antispam-messagedata-1: Qi2YoRRf3DqBMMSp2OB1KDQitIGKKDRYGqI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D55886D69E8FAA42BD56E55E9230EFEB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nRSX6EYXxWXCNchYKR+yUTofkbaxqYRYEEivvEbxBbe/YUYUVE5O9X1QAdaBh0IT0W4YfNp2V5fNEyjKhhWoztK/Y1JU7mc2tPS3VSfqvoXW0LB4ZHmEmlqFQVf3m1ThqccgVXLWUcuahX9ItL+jFPPkYt04NqwuQyw6SLACizmWmh0rWAM5qhWRcBESLN+A1ixJK5Oycsc/J6CB5fgXgMiZdDUB/Zr4hjnPLVihdv6qXG6yXTrOveooQls4B86OhUZqkxJ38vgl2SYIFiHioHeAfhlcsg5cSGJAxA1r4uf1Nh480Tsp9HdXUFQQNC21Vllkf8cck3xONBtc8F1FljwZQ6I+EM6nlQJKXWt/t7/JPUicoPWLkqKoWY3NyrMfA7bQTYrCnUYn62eBHqVKI/mVPZv71UJYFOP3u3dDGdOD0PL+31vK086bXvPTCxBDmRo/feSNzHLZnr1UjI7JBT8IeN1UY3DckEUmwBlv6ynZMRnzBPEsJO/naDJhbz5jmy1aM9PtluWsTKjorcQ2rlSCf6yVTiQHHpAHyebXf98Dzc1skdt6R5zgCamTWL/F+0MxS6x+JIKaexkxNhsPynIjs/qpM/axmZJ64vEhj5MxE6t9Q5VVuW4Jy+uyTni5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9657b717-86da-49dc-59c5-08de6acd6a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:59:22.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxnZdRHb1P+Gl1mQYK9kwodWp7poURoWFhb8FnobWPb8wENLUUIjoZsecRG1gHSJlKIIi91RVtDhafIdjt+J2rB0HKZFXoc6clf2hwbi+rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7476
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77076-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,toxicpanda.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C0851335A5
X-Rspamd-Action: no action

T24gMi8xMi8yNiA2OjM3IFBNLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gVGhlIGZhY3QgdGhh
dCB0aGVyZSBpcyBzdGlsbCBhIHNpbmdsZSB0ZXN0IGluIGZzdGVzdHMvdGVzdHMvcGVyZiBzaW5j
ZSAyMDE3DQo+IHNheXMgaXQgYWxsIC0gaXQncyBub3QgYWJvdXQgbGFjayBvZiB0ZXN0cyB0byBy
dW4sIGl0IGlzIGFib3V0IGxhY2sgb2YgcmVzb3VyY2VzDQo+IGFuZCB0aGlzIGlzIG5vdCB0aGUg
c29ydCBvZiB0aGluZyB0aGF0IGdldHMgcmVzb2x2ZWQgaW4gTFNGTU0gZGlzY3Vzc2lvbiBJTU8u
DQoNCkFzIHNhZCBhcyBpdCBtaWdodCBiZSwgSSdtIGFmcmFpZCB5b3UncmUgMTAwJSBjb3JyZWN0
IG9uIHRoaXMuDQoNCg==

