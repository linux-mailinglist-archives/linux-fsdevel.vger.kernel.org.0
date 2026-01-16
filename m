Return-Path: <linux-fsdevel+bounces-74115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11107D30865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 12:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48E813019A45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13627378D6B;
	Fri, 16 Jan 2026 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kfh5mJoy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oXH10l4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CF37F72E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563570; cv=fail; b=lGpZDijrlIOy0GEsg3o7bb2Ge+WTG0ik14UlR7NVNKerEHOnpMox8XxijPWATg/rgSNJ07+rV1CPUKxop72quj5UJq9Lgx6LYlZj8JkcpHbB4uwfzzBhwGuPjrNMfPrkyIrj58Ma5zueFXRj7CZhRVC3QIjc4qd1FUeHfZImBNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563570; c=relaxed/simple;
	bh=z6FwMn5DiYgTTm0b8s9EcA9cEmEd4DPWrgBRVm3cCyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kcw69sST2wdLfpa+YgygkPNZpFvEEI96nyqz7GwA2IAPslZLyQv5CoH8nvx32a1oaNznewwTnZk8nMNPhq9tpb/MqwhFt//kDuK8PWyaFaMi+euLotO8Q+ciFYvSDe2T772dJWYVD5si0V5ds+qnWqQLWboKdt1+b/sv6R7HZ0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kfh5mJoy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oXH10l4G; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768563557; x=1800099557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z6FwMn5DiYgTTm0b8s9EcA9cEmEd4DPWrgBRVm3cCyo=;
  b=kfh5mJoyKpiFJ2bDIcutiTmQI6oaXxzaQz2ZiZ2Nd7oVDf53jKXTLy+d
   oiiA/0wlpuSYktPpSUAO3wrj8VLqwYvvjhXG3juT0vsXR3hUKgP2Xf0eU
   TQ1JmSy2D/M7pkHZ84qK+ZH+gqpEhRW4/ZvSjGPcFZEXQCCJs1YiIDDFl
   t6pFzcFDMgx4CIm2/umTGBrOzM3BC/1wO5f3m3zm0IOZkYLWKgOyyms8X
   aKJDHFnqd/ycgo9SEiosw3kLoZJvyt60GFgK+bZDP+P6GUVojPlTxS6O3
   3dyDRzg2empY9p/IaYu6Y/I+BcK0zr1pAtsJiZQM1np2L8lKCxtISmk+q
   Q==;
X-CSE-ConnectionGUID: pcdA70ghRMyonQyLh/zHHQ==
X-CSE-MsgGUID: 1iS+ggYUTGejNLB6O1fJ6Q==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138197823"
Received: from mail-centralusazon11011062.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 19:39:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhgSKBODe3vTJ6XcqWHQ8WeYcjFlg6QnVatPuhGbHqsVe51sgU8KMcTExYgD6AGYGwsJQkjfPLzGvGLpx+49rWpfoFM4L0nKN8cNAcxqD3a2tgEUYLOV3YchOF0kJeKVBpG7JMCKGuvFRLoH1ot18zpMsJ5ZQ0xBZVlW/mVCz3bHVi6wW0tLPVd1jmYxfH4HoN52RcYY2qknnCaP2GCbOTXkQ9wBOqC99JIz4vgIYWt8a4E1QUfypK4GKlgz0nrjqhVbTg54eaShtHRWQfm5hmBrak+NJCCwuqNlO+cKLxhiHWyxB4Tp3XTG+nKEThDf+5RH63YAZmVGS0FOMsXYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6FwMn5DiYgTTm0b8s9EcA9cEmEd4DPWrgBRVm3cCyo=;
 b=RuzJllSIqVtffHavTFRV9dBNzs0ow6qDsGc0DK9nLWut9Nhrxu9wnjB/CV8Df/aq4M08M9coqxT+POm+qTVtDHM6PnKnhn5fNa0uqfpC1Z9/hRTvq30whOHnK4VO5NSTF5bT1T7br5bUJ8XcWr6MBzYD1BIn8ULC2aC3+HMYfK1l/XzPIFryFODk/ShDRioVmSXaeeClQ4efGRSusMJfK21xE65bQCjsZhemcKSr2xDFsUH+S+qC8wsQzSrie2urSsXa1tAeogfI4RSetRfp84I7Qii/i1pXeR1IFN4fbXoh3wJtANt4ygyHCUjqymLlEqaoJ8hc0O5Xmb2I97JcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6FwMn5DiYgTTm0b8s9EcA9cEmEd4DPWrgBRVm3cCyo=;
 b=oXH10l4G+rNrddk0Myv5w3Z8EES+NALpQL6JHHuEkz/GhbP6lwg1kfNlife1+CHHYMn4j8QEbKFyrfxy/+RHeQviD/TXglv6zgavHj8DpV9n50mL+c0UydL4z1DjyreBbUMJ3YFTbTeoY85KzRwfdic/sVg4QRMCI+jbQwwu89E=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9472.namprd04.prod.outlook.com (2603:10b6:806:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 11:39:15 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 11:39:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Miklos Szeredi <mszeredi@redhat.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Thread-Topic: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Thread-Index: AQHchhoBb/vuKYekO0aOXOWBlhrFzrVUrUYA
Date: Fri, 16 Jan 2026 11:39:15 +0000
Message-ID: <2556152a-6292-404c-9d48-a0ff866d42dd@wdc.com>
References: <20260115122341.556026-1-mszeredi@redhat.com>
In-Reply-To: <20260115122341.556026-1-mszeredi@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9472:EE_
x-ms-office365-filtering-correlation-id: a2da9106-749f-4946-20cc-08de54f3e088
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkVUYVJnVjkrQWRzWkQ4djYyMXJld3JOdm1oYnN3YlpuTW9iQXUrYytrT0ps?=
 =?utf-8?B?Q3U5ajduU0dOU0ozMXVMQWdLd1I0aEtscnlabFdvalcyeDl4aWRqQytqUlpH?=
 =?utf-8?B?bFN5SnhNNkZ0UTRDMDlKd0ZlajUyQ3FLQmNZdCs2ZXpJbXk0bjFUNFJNb0dF?=
 =?utf-8?B?NkJuK2RTU3dWZktQMXBnZUZrWWtuUmNDeVo5T01iYldwdTY2cjFsU0dFc1pZ?=
 =?utf-8?B?Y21Qenl2ZmVkVUNxS1hxd1JUT0dLN0pwWmRlTHRvcmYvMEgvOGZibkRLTnND?=
 =?utf-8?B?ckRkUWRiSzVYa1FuSFJ1T0NhRXJTNm1hSTI1STNHS2JBdmtqS3dxWW1ibElP?=
 =?utf-8?B?NzBRZ2pwTjVLMGZKTlRIa05kTXNHdXM4S1d2Z1FiWmhLL3lTM3JPd1RCVTQw?=
 =?utf-8?B?cWRRMERCaWZzSmhqZ1RFRnIrUXdvNGJFNDlHNEJXWGdYZWJFQ0JyZGM1TlE4?=
 =?utf-8?B?ME4vZjJuRjZJc1gvOGd5YlRYQkM2SU10eWNkQTNDeEZldks2ZXJwdE80VkpN?=
 =?utf-8?B?ZkI2QTR1am8vUFdYNWNpL0dnVDdoUzR2Z3ZWZTFiNFNOckduUjhLRVl5THRJ?=
 =?utf-8?B?QlI4M2xhNCtGMFd5a2xiUnRlWkV5SUV4M2s1dStVQWFNbkFVNkFmWFdXWHpL?=
 =?utf-8?B?TFZPK0s1ZmR5dDJ5UTY1bW9qcGJGV3praEk1RVFrdXd4T08yaUVuekJvZGhn?=
 =?utf-8?B?VlltK3p2eSt1S1I3SURGU1RvZm1NRHRFL1pyWW93TUtxbGVtVlhkSkdpL2hs?=
 =?utf-8?B?VFc2L1l1aG9UWUs4azZadG8ybUdyeW9yUGVVOGNQVXFWNlZod1VHVGx3UHh3?=
 =?utf-8?B?VFo4YTVkTzlnc2RxeWJjdytyYUVRMVRRYVZFWmtva3ZKdndHNXJiRllmcnBK?=
 =?utf-8?B?S0llN2JzL3dvajh6NUVqYkY1bUZWWnp5V2Z1cDFVd0dzRUx2UFFrRUpXNUlm?=
 =?utf-8?B?NGl3SHcvenJYZjFXVFZxRDZ0SGluTkNvSTBMRm9LY1h3R2hXTDBjN2c5Q1Yz?=
 =?utf-8?B?TzlYS1hlRVFPQ3QwdGVUNnAzVGFPaTlld0tXejNnU0hacE5jVFliU3Fkc0NY?=
 =?utf-8?B?M3doM1B0STdzNlczNVdCKytGeTlLWDRBNUZrUFlvRDRBMzZWWjlvYmRVU0hp?=
 =?utf-8?B?NGhnbFV4Q2lQaXJ3aFczaUFPa2ZBUHpqSWZMZ3YzNGRkNHpZbmlDN0QrK1FP?=
 =?utf-8?B?MWxsTXpadWdJUTg1MnRRcTY4alZFREVTQTdCUUpWQ3pNWWhhMlowcEk2V2xE?=
 =?utf-8?B?QkF5VjMrbGEydllaNEVBVnNhL0VJM3VMbmN1eUVpN2NidlBWRmFjdVFhVFFk?=
 =?utf-8?B?WEVaQzZkYUJwNnBzT3RRYjFqV2lwMGRTTzhjQWNOa08xTWd0bzZzN0FxYXk2?=
 =?utf-8?B?S24zakU1TDd2R3JaWCt5djBpTXB6Y3Z1bWxuc1NIU3ladXFPaFozM3JlUVBy?=
 =?utf-8?B?WnJnZUNzZzZJUzhBNXRlNkZycW0xZ0IwZE5YQXEzMDB5eUZjUUw4NkJiUzZO?=
 =?utf-8?B?ZjY4OHNaU1BGQ1pVaTdvaktSVW8vYXFsdFBUUzRSWlU5akxlckNtOEZOc3ZC?=
 =?utf-8?B?MW1ZMEtQR1FpQWNDdDJvMzFIMHRGN1Q3NTVkOE1NcXdHaDBSUmpqSktZdmtH?=
 =?utf-8?B?RHoxUWlLWGFBR051cVYzWEdTWnhWc2FBVWN0NmZKSWFEOUdVRGFZdmdHUHM5?=
 =?utf-8?B?RTZkU2sxc0dueWVrdSsrVHFWcTJhY1FULzVPMTVwTFBaRkxDK0hqaHJHR2d4?=
 =?utf-8?B?TWRTb1FSbnlDZUZqVXNDeHZmaG9IZ0FCU1k4bytmK0VRbVBCSE4yN1RPREJK?=
 =?utf-8?B?aGlvOUpaZG4rMnJ4NWt3T1hkb21PcTFzUDVmclhnZURMM1N6K2tYWTBtWjZw?=
 =?utf-8?B?T0pKSUxWQ0tNSVJzaXhteVJZYk93VUE1TlBna3prak15ajFHRFZKSnZ6bEw3?=
 =?utf-8?B?WEZ5aDI1S2tzMHpaWUFueFpOa2V0ano3blZjdm94eEdBeHhWRG9kNzNtWnJI?=
 =?utf-8?B?eEFYQ0lTaWxpNG1EY2o0SEFCaURldGVibDNranFYMnczcUtPSDJNdmhDakI2?=
 =?utf-8?B?SXBnVEo0UmVSaXV1eFExbXZqNE1iMHZZaDBCMHZQeEx1SFdjSkhJNFBxNlhz?=
 =?utf-8?B?MXhiV1VtT0d5Z3FDQVFsWU1uV2VyWlhlWTA0bzJ6dnVKQ3k5YnlGM2NyNTlK?=
 =?utf-8?Q?qNNJzg3ZT59N+FHG0o+MFwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0p5UmJJRzZyTDZRbHNUNERuUmdvaitGK3doSmFwV2krTVhqRGpkQXU5REQy?=
 =?utf-8?B?Uy8ya2ZmL1pwL0VvVmtVdVJWZXRPSlI4Vjl2NkxpRFhQNG11Y3Y2OVYzRjlu?=
 =?utf-8?B?anhreitNcHhsMjhOc2tBV2FobnEzWmhEbHZDNWtVOGxReE1hQnpyRkhxb2Ja?=
 =?utf-8?B?ZjZ0RW1jSllHa2VTTzk5TDE3dlI5RU5ZQmJVd3V0amcwUnNSWFBwNVJyQU9P?=
 =?utf-8?B?djk3YkJhSGF4dTAwT2xCbU11MTJBUmdSUktzWm1OV1ZHMDJ2c0JVQlFCNjdp?=
 =?utf-8?B?WHJmb3V2VTM4aW5RVlRINmFzTnphdk03aTcycUp3Rm1ORzAyUWpNUkR6bjlt?=
 =?utf-8?B?UGY4b01ITGVRaWhWbDlmTHJ0cWVrZFdvSVZsRUN3ZEVvMXRodXBVNm11dFoz?=
 =?utf-8?B?M0pHVW44R3l3Wm9KWDJvTUx1eXZFRU5pZTlVeFltY0ppakVVRVRnTmc2NmZp?=
 =?utf-8?B?VFZhVEUxUXNXZSt6L2NIYUEveU9rTHkydnFBZVJhcGRBOW9YcXY5UUx2bXpN?=
 =?utf-8?B?RmhjNjdOMnAvT290bFp1UjJHTE1jYUVEbkRJR2F0L3hCMUNqcjN0dnRPekVH?=
 =?utf-8?B?MHlmeG9hZEJYSVkvZkhTN3pPMnppM3Q1emFLZlg0a1BNdUpZYzJvek5hVGpw?=
 =?utf-8?B?Z2M3ZnczSDJacExWNk9tQUNYVUxSaGNta0tKa05Kc0dHQlppMjY2bUVTdXg3?=
 =?utf-8?B?N3FBMzR4MUtib0FQTEtDZEZLMk1TYml2RkpqcWV4VGl1UE9OQk9KUjJUdjJO?=
 =?utf-8?B?Wm1qRUI5Z2M5QkdsSUR1c3BNdldxWUt1SU8yc0dGTnptcHRDdkZoemtZcktS?=
 =?utf-8?B?V292YWxOVllRZmFRSDVzWDF6dkxvMHNURkhNQUFyc2lzTkZGYVVVNDI3cjZO?=
 =?utf-8?B?MW00NGhKRkZYSnAwd3R4MHd5LzZFc29iY21SVnJlb2IzOXA5UnRTYlZLZXVW?=
 =?utf-8?B?aWJkNHRlTzRZVVdSTE9HN2gxaTlnQVByWTFPRXp0RnpZemxzNDU2eXd0eUxk?=
 =?utf-8?B?cmhJWDF1OXV3SHEwQ1Uwd0NOczloc2sxUFAydjE3UldGWGszc3I4dGlXdDAw?=
 =?utf-8?B?YVNQLyt5Nmp5MXZEK21zWS9Od09uM0F6UjhDclBJRTJqSE1STVdINnRDaEg5?=
 =?utf-8?B?d0N6ZlAzRDFrV0hQVVN1SmtvOE5DMG1ZUUNNa3dBblRTZ2FHVmpuaGNQay9M?=
 =?utf-8?B?UGJpeXB3cks4UkIrTXRWWGRYcVJNcy9vdnZhVHduWVZ6RE1XSlVmN04wSTV4?=
 =?utf-8?B?R242SDY0TmZUU2orWkpYTXV5citSSXNVK2x4OStValp2UHB6bmxaUW1rZnVk?=
 =?utf-8?B?dnViYU5oYnlZMjViYWx1L2JzdUJPRWtHUy9hMGxERk1aaTErVTRIaWhiOERS?=
 =?utf-8?B?dXhzeFBFdU5CYTgxeklBY1BKSUNLYmxJS2k4ai93S3lUaERZVVdZa3V4N3d6?=
 =?utf-8?B?UUpkV014b2J0WXJaQjdsR1J6U3AwSVVNcHMwd2pMdncvMFd4Kyt2U1Y5Z3RX?=
 =?utf-8?B?UU9UWmdMdktacWY4cFpzQWVCZld3M0VUbE1ESWxseW1ZSnVkemJwUFVNVUVw?=
 =?utf-8?B?NG45SWxkeGtFNEVJbUxuZm9vMVl4K1BqNFdUdnZ2RVhaaFJHd2FZS3FaeE8r?=
 =?utf-8?B?aUt5dGZ1ekg2aWtxWjcxT3hXSmZmL09zUU52RGNVcDZPZ3l6QWR6dW9reVpE?=
 =?utf-8?B?c0orRlB3a1FqMFExbmsxZTlyT0RoRUV3SGZUMEtlWmVHaFU3VDJlSGlsNXNZ?=
 =?utf-8?B?elBrSzRyTFJqcmdYZGVYZWxIOEx6YXlLTmtPQkhpeEp0a0F5SUYyckEvUkd5?=
 =?utf-8?B?ZFhnamRSMlBlN1RGQ2lDQlZ2Z2t5cVhndWUwTHZiMnJVbUNOemVwcFpGaDBn?=
 =?utf-8?B?TDNjRFF2NUI3ejV5Tlc1L0dXY3VvU3NjMG1MdUh2cFNDcmxMTVZTK053RDkz?=
 =?utf-8?B?d1RBMmpYSEIxV2xlanlIckhabWt5eFd5ditOMGxNVEpYK1Z2NFcyS3d4b0gz?=
 =?utf-8?B?MDd2eHdYQWpmN2NQS1Bla1dzdEhmRGg4SXdmRU9rd0tmclFXaDFzUzVzUGRK?=
 =?utf-8?B?dTlNREpsZ3o5ODVFd1dRdDNXQ3ZUeVRIS0Y1V1ZwU0NvMjRhS1JCUWJ5ekRo?=
 =?utf-8?B?U01ZbGM1V3ZJc3RoeERPb2ZPODVBQ0ZlekxXT0ltTWhKZUpObHlnakVLYlRQ?=
 =?utf-8?B?cUN6OFRRVndPcFJSeEtNb2M3aktNUWRIalZBU1cyaUxMaWhmNmhENm5odld4?=
 =?utf-8?B?N2ZPTDkrVnU3RnFIR1A2SEM1VlJPbXdINnBSQjNsSXVRSU5DdVJxWnAzY3hK?=
 =?utf-8?B?YTk0Ym9uYjFRS3pleGdlT1B4S3JJMmdxSUlGb2l0YUpHbEIyOFZYazZsYTZQ?=
 =?utf-8?Q?QdTtuJ9mPdPmdh6M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A962C77C3BB70844898C89B16CD21A90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hi7Cx6hWridZOKP6UN0CYFLMYjzNOIOJh6JyJEBfIHeoPFt6OP+1y59oEQupyQKlNtEusHUG8bPSEF7pLucCs8dM1O76lacl7gY7gGvUbyExCyuCU9YZ+hcGd3skwulDbjoLLGKrm93El+uKlSpaJMC7Iuhfz+B4VxYlw0y6emtqVQo8oSxMftoIic0Hx9bZGIK/5RkmzZ3w3JFj3aeKf4B0uekBjNVyfZD9XEB/adFWdackbP7ffg4CLfOXhNtrKL+B+aiXkr1FG4JaS76/yju5SoiloTFkuRxI2A4VIr9B7B81ACxZj9irk3bgQSnYvGXs6KWwQnCz3oQ4DVJ1iCTcrEidO6YQvRpyz+eWQ7jOk3PX/JfF6uGMaLYSvhDglTPA/KraPDswe+QmkhKIEae6JRrl2sszkip7VpLvdeza2pZfeBsAOj8HrG+wNzuCPawXkIbLH82Xc6rqhwjMUi1dMVbDry5PTJJ+plJyXVJqG+PPs/N5pUEPcZHwTy7/5SGD5wN74tFR4e6WMdvp6M54Ihu8ijh4kYEFLNFyQg1iE3m0h/+h7Tja31MmbW+81X3Gk5cbUTh6s4jKijWPUXJxOT58wCAzvHNwpAGp+xXTmW/T3tcqn89mgAafGzX9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2da9106-749f-4946-20cc-08de54f3e088
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 11:39:15.3429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3FxnEswQwkFFf1NGZ6BfAtyf+t5BIAHyuPgeEdiy8Lzi+BDcff9KNHY16xNqQtITpYd9m4IkRzJbh+bRpdbrKGU9QGWqIXi7TL2QZ6hONQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9472

T24gMS8xNS8yNiAxOjI1IFBNLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2ZzL2J0cmZzL2FjbC5jIGIvZnMvYnRyZnMvYWNsLmMNCj4gaW5kZXggYzMzNmUyYWI3ZjhhLi5l
NTViNjg2ZmUxYWIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2FjbC5jDQo+ICsrKyBiL2ZzL2J0
cmZzL2FjbC5jDQo+IEBAIC01Nyw3ICs1Nyw4IEBAIHN0cnVjdCBwb3NpeF9hY2wgKmJ0cmZzX2dl
dF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgaW50IHR5cGUsIGJvb2wgcmN1KQ0KPiAgIGludCBf
X2J0cmZzX3NldF9hY2woc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsIHN0cnVjdCBp
bm9kZSAqaW5vZGUsDQo+ICAgCQkgICAgc3RydWN0IHBvc2l4X2FjbCAqYWNsLCBpbnQgdHlwZSkN
Cj4gICB7DQo+IC0JaW50IHJldCwgc2l6ZSA9IDA7DQo+ICsJaW50IHJldDsNCj4gKwlzaXplX3Qg
c2l6ZSA9IDA7DQo+ICAgCWNvbnN0IGNoYXIgKm5hbWU7DQo+ICAgCWNoYXIgQVVUT19LRlJFRSh2
YWx1ZSk7DQo+ICAgDQo+IEBAIC03NywyMCArNzgsMTUgQEAgaW50IF9fYnRyZnNfc2V0X2FjbChz
dHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywgc3RydWN0IGlub2RlICppbm9kZSwNCj4g
ICAJaWYgKGFjbCkgew0KPiAgIAkJdW5zaWduZWQgaW50IG5vZnNfZmxhZzsNCj4gICANCj4gLQkJ
c2l6ZSA9IHBvc2l4X2FjbF94YXR0cl9zaXplKGFjbC0+YV9jb3VudCk7DQo+ICAgCQkvKg0KPiAg
IAkJICogV2UncmUgaG9sZGluZyBhIHRyYW5zYWN0aW9uIGhhbmRsZSwgc28gdXNlIGEgTk9GUyBt
ZW1vcnkNCj4gICAJCSAqIGFsbG9jYXRpb24gY29udGV4dCB0byBhdm9pZCBkZWFkbG9jayBpZiBy
ZWNsYWltIGhhcHBlbnMuDQo+ICAgCQkgKi8NCj4gICAJCW5vZnNfZmxhZyA9IG1lbWFsbG9jX25v
ZnNfc2F2ZSgpOw0KPiAtCQl2YWx1ZSA9IGttYWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICsJ
CXZhbHVlID0gcG9zaXhfYWNsX3RvX3hhdHRyKCZpbml0X3VzZXJfbnMsIGFjbCwgJnNpemUsIEdG
UF9LRVJORUwpOw0KPiAgIAkJbWVtYWxsb2Nfbm9mc19yZXN0b3JlKG5vZnNfZmxhZyk7DQo+ICAg
CQlpZiAoIXZhbHVlKQ0KPiAgIAkJCXJldHVybiAtRU5PTUVNOw0KPiAtDQo+IC0JCXJldCA9IHBv
c2l4X2FjbF90b194YXR0cigmaW5pdF91c2VyX25zLCBhY2wsIHZhbHVlLCBzaXplKTsNCj4gLQkJ
aWYgKHJldCA8IDApDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAgIAl9DQo+ICAgDQoNClN0dXBpZCBx
dWVzdGlvbiwgZG9lcyB0aGlzIHdvcmsgd2l0aCB0aGUgQVVUT19LRlJFRSgpIGRlY2FscmF0aW9u
IG9mIA0KInZhbHVlIiBoZXJlPyBJIGtub3cgdGhhdCB0aGUgZnJlZSBpcyBjYWxsZWQgb25jZSB2
YWx1ZSBnZXRzIG91dCBvZiANCnNjb3BlLCBidXQgYmVmb3JlIHRoaXMgcGF0Y2ggdGhlIGFsbG9j
YXRpb24gZm9yIHZhbHVlIHdhcyBkb25lIGluIA0KX19idHJmc19zZXRfYWNsKCkgYXMgd2VsbC4N
Cg0KQW5kIEkgdGhpbmsgcG9zaXhfYWNsX3RvX3hhdHRyKCkgc2hvdWxkIGRvY3VtZW50IHRoZSBu
ZWVkIHRvIGZyZWUgdGhlIA0KYnVmZmVyLCBmb3IgYW55IHBvdGVudGlhbCBuZXcgdXNlcnMgdG8g
Y29tZS4NCg0KVGhhbmtzLA0KDQogwqAgwqAgSm9oYW5uZXMNCg0K

