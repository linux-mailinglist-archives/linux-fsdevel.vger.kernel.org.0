Return-Path: <linux-fsdevel+bounces-77342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAsnL0YjlGnXAAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:13:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52E149C93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BECB33007512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793262D47EF;
	Tue, 17 Feb 2026 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HiC5deKF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CQ/EM8EN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282E15746E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316034; cv=fail; b=ouu6BafWyCHVnb7EWRIKyBuzALadG03baZyAYw4EGvvIJXTpzdwb83255TJV5UiiLuxLv5l0xE+ZUbXKJi2hVD5mUyr5/zFx8KqymMuK+JuL1LOAfQQWJPFBCwUJgz+ooU1RrDQLOJQyO4bDi5Q/XKXl5D/XOvM19JFJNKn8sAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316034; c=relaxed/simple;
	bh=J0T9mQes4ZISMWjc0WShKaOpPLE7ezF2JaGFFb2JhNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aenoXw6C+X/XfCkrEdGJa5Kbhmh48dn3WVKQv9U7/BXOTg0AkdERTrzINYU2Eqd55Td1o2oFz0PlizeYhSoM1dBxgiUhyP5iV6nC0TZmvm5Vb3SzlnITBLbxADLJ++qGysBxgb3CPqAes7zCv3JVmf71PX4fu8/NXPpcypvuD68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HiC5deKF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CQ/EM8EN; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771316032; x=1802852032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J0T9mQes4ZISMWjc0WShKaOpPLE7ezF2JaGFFb2JhNk=;
  b=HiC5deKFWqJ4rQlox/+6I6WeTvQ6Ut+7BoCBdNz/oNEgyGEM0VpdFC/R
   5D0dIkQEVRp7c5a20Qng8zVgvH5NzTb1gTpd5Naf8Y9HQWHT79CHNU/9o
   XQVxcsZBQfB5/T/cw1q5/sjJyzTQZB/WyXqZADfWFsP+7cuvecXA5bV4U
   d8pn2pa4wBa7Ym5+18e+uj2xp87Je+l5Fd0kRkifymbTR9MleZLV82Oi2
   gmYjfCBg3S0zsviT+TrdDFAMLOfy99R9xh+dchdXWRTIDRym+j7Smv0/O
   SepPCXK0zaNvAeE8DShGOTWS+ZeVdKml6usKmb8Nq3R6hl8bZIsRyb5Wu
   A==;
X-CSE-ConnectionGUID: SsLr7hIdT7CF82+ZKtVSdw==
X-CSE-MsgGUID: EepQK8nPTgik2QR1+OVBAw==
X-IronPort-AV: E=Sophos;i="6.21,295,1763395200"; 
   d="scan'208";a="137336957"
Received: from mail-southcentralusazon11013028.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.28])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Feb 2026 16:13:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXp8KFCkDM42aN6/u1HMw2xLiWC8suW9MgsgQ18pqYtI6B/PpsL597OgV69ABO1/ScxvodXWdwdx3jwf8AipNoghTyfyu5gBrcd4BvtiaiDvrgZoSHRZ7EQz9CWmn/PTWcDMiid8di1PTkE8rhyvmpoI27N96Qk3NMNBaYdRDe5v3Spy39WqzKpAq5P70VE16NvzNpOF1NrfZhaqpp7I2q+ydJAkhX8JK3IFEmJ/aZA7Ev9eFept6WanzbCCkUrQ50eh/gjPNri52ZVMAuH/dQORNMlxsssq9deo7ykprUodY8/OfH0ucDU1+f8mIb3sQXadCMYOLRpwhjRbZod9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0T9mQes4ZISMWjc0WShKaOpPLE7ezF2JaGFFb2JhNk=;
 b=RcWh42TcGP7RSSvs7ComMrfICeAIvECiOZE32HA6LFLVX4xrbsOaEK2ZmjKmp2H/s42X0H1gQ7fmruRFsILxA/9Gohel5IhB588DfDOrFbTqdN7o/CNYwKSQ5aSG66YDR5IXpxqFs0Gi+UpAMJDJmP8cjmmobG8X/jBWe7YcHq2JjyXmE9qRnfWsionZat/RLyGDfYmzE4ouA/lw8j/6you+K+T5mh9qWTHaDy3abJRD2X5hP9wkbFppv1zlhTizBklBuYmfD9+lS/353U9e0AmtAVgzz/nwAVU23UBqzjTaA7qjPQ6pdMAPjrFtBD2dqkUmUzvqEo3t2XLmhisVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0T9mQes4ZISMWjc0WShKaOpPLE7ezF2JaGFFb2JhNk=;
 b=CQ/EM8ENRX8LHsY62ZoxUEct/UJpR3ouUzbCVZYey8+2LU9Mvr2wJvxH0A4TlclYh0PhCrXUcqCLLbkj2cOYgPO8THaH541aih2iucSEFBCItBh0lV9ys1KoKaEG60oB5dxBeq9ryBAdZm1Libmh6bLUYJu6sZ9p0Sgd/dnxEBg=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by MN2PR04MB6847.namprd04.prod.outlook.com (2603:10b6:208:1ef::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 08:13:49 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 08:13:48 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch
	<hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, "jack@suse.com"
	<jack@suse.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Index: AQHcnCVy+M/y38WvJkeD9gq7IpAat7V/ROOAgAAN6oCAAAFkAIAFzFUAgAFx3gA=
Date: Tue, 17 Feb 2026 08:13:48 +0000
Message-ID: <8ce807d6-01c0-4778-bc78-860d2bfee966@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
 <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
 <5lk2kolr3ntrbma3dw4qtq7lmxlu2ghdf2mavt5fu4cuuo3f2h@fztn6lesv6qb>
In-Reply-To: <5lk2kolr3ntrbma3dw4qtq7lmxlu2ghdf2mavt5fu4cuuo3f2h@fztn6lesv6qb>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|MN2PR04MB6847:EE_
x-ms-office365-filtering-correlation-id: 7a2ec0db-4da6-46e8-0d8c-08de6dfc7a81
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?THlGWDNMSHRGTlRnL2hqeGs2dzQ1WmxxUWg2YStZNXlxMEVycHdURjk4N3Nl?=
 =?utf-8?B?VUpqeHpPdWJnS1JqVEN1ODl6NVBEeXNQN2k0MU4rSm5DYnJRcUU2dzlSS1VE?=
 =?utf-8?B?cGNaRjJYYVNpTXFoWWdnbHBNeVVRSWhiRnhrbUx1UFJpWEUxdDhwaEkraklB?=
 =?utf-8?B?MHhUMXJ4RzdIU0gvOUVMaTBJTlpLTzVpMUNPa1k5Y1pibkFLS28rdnB4T2pC?=
 =?utf-8?B?NVcvRDUvL0hXZnhVMHFkQWNUbklqRDVWN1VjQTdlTWJhMmIyT0lkZFZ3VmRa?=
 =?utf-8?B?bHJvL1dhR1B5ay9rRGJ6TGZ5d0hOR28wU1ozT2ViNnR1UW5IaERVM2t5TitL?=
 =?utf-8?B?cThRNTZNcWFTbGxzMUE5dUhTanRZdTVMY2tKaXprNDhtTkIwS01MQVZzWFUx?=
 =?utf-8?B?NHEzR1BtaHQ3YVlPOFhaZkFtWWdtRnBXcEVFbU1uRGV1b3RkeEdFVi9HaDlD?=
 =?utf-8?B?NXBnVTJNNDZjbGdGZ1JnZE01Q3JreEdaOElXMGdxRVg1QmlVQjRzUFlHWlVO?=
 =?utf-8?B?bVNOU2NMWXJ1MzJmY0Q0RjhJd3FZdmJtenptbnQzUmZaUy9RSk9yREtRMVNC?=
 =?utf-8?B?R3REMUl6NVJVNU4vVUUxSDhwSGJGNzh5VXM0VStqWkZwblZnbTFZV1RNTks2?=
 =?utf-8?B?UndMR3hZREtJbkV1NDZ5TEpIRkwrTkszZkN4c1BrTHFqUmJ5RFcvb3c3amNT?=
 =?utf-8?B?RDZlRHdETHp1bkdWZWpucGFUSHozUGN2THdkR3czSGl3UmNOdkZMUktmRXZj?=
 =?utf-8?B?MWJZMVlZOFMvRzF4OWpqSEYxN0NsM201Sk5ZaGhyOVhESStXdW9BRVdod1lW?=
 =?utf-8?B?Nzlka0pvN2twWDh6cStzTjU0UWt6eWtzWDZTS2NKdVUzclNvc09rSjRFSm9y?=
 =?utf-8?B?VDhYN1RsdmRkVlk0QTduNGswUWFwZ2pMY2E5d2gxc0M3eHFJSld0Ymh4Yi9p?=
 =?utf-8?B?NFhiL29HNmdvbi9NM0xQRkowNXVLaXJVQWlHR3lrUDBzVDY2NGE2Z0QySEpH?=
 =?utf-8?B?R3BTVXUvcFNZTytlTEhlZTVKNy9XSjBOWGp3Y3Z5RlFpQTZKOVgrZkZpOHov?=
 =?utf-8?B?UlVFQ2VxRHhiYVRrN1lBcmRRVTA5Ny9YY0ZvRGllcUZTZ1RwbmNwM1cxangr?=
 =?utf-8?B?WXhiNTQyRkxCNnQ4VFZsa2lVQ29OU1N0RitQSE1HQ0VmS3J1eDdWbXRXV05I?=
 =?utf-8?B?YWg0R0dGcWs5UHhWbkl4SnV5RW00S3J4V2lFTURncjJvTm85QjZGZTBkMUlZ?=
 =?utf-8?B?bW1rZ3hpNVhzN0N2eDB1RVZuSG00RjJGakU4aCtjZDhpSUIrOGFzck1vWGlr?=
 =?utf-8?B?dDhjNjVpZ1EwcnVEVVdNKzEycURxdTg5dHRDcnJyZ2Rwd1lWdzc0WU5peGFH?=
 =?utf-8?B?c3VwQU0rQk9aOVZCMytLYWZ3OWlmMWFaTjN0OGE4ZU41TmtDWHRzL1RydWZm?=
 =?utf-8?B?ck9rREVoeUJzSFViV3ZEaUswOFpnSzJNOGpCVG1tZFJ5ZVdTY3FhbzFKRGdE?=
 =?utf-8?B?NHhlSGsxTWhERDlGeTloTXBobmV2ZThtSUU1azh5dnFMYStQWGNWR3h0Mis5?=
 =?utf-8?B?VThLYm9nclZSTzBZT1pudmFUY1FYRDBRSWNqS01TQ3F2NENPMFZKUTdYSjU1?=
 =?utf-8?B?OUZ6N1J0ekZ2V2hiMldUbW1tREpsbXh4Sjg2ZlQ5WmlIN0UvYnBweTRYby9O?=
 =?utf-8?B?b3BKQ1pWRUJZVUwxNWFhZXQ5YnYwMHFBekZONkJZVWp4VHF1cGExZ0lMRHgz?=
 =?utf-8?B?U0c4UXE1S05sRWRFOXlEUE5aYUpLL1dQaTdYZEtHSXBZUGgrVzlLaGV2QVFR?=
 =?utf-8?B?VXUrS21tK2VaTGVHK0M4ZytzaEpiT1NLT2t0NFltbHIxbWY3WTMveUtKS0x1?=
 =?utf-8?B?emVMZVh5NTBxeVgxV2ZtL2Q2NVpkWmliZlNvTGhoS2xlK0lBSkxJbFptS09v?=
 =?utf-8?B?M0RIMm5lbUdadmNjcTRVZUdtYzJ2UmkyajUxUmtZMllWVk1RN2E4QzJEdXo3?=
 =?utf-8?B?aytPakorc1Z5c0Q5ZjQ1ak1mNjB1VU9BS1hYNXl6eVhLWlI0b1R4TGtscGNj?=
 =?utf-8?B?cDN2T0tHeGpNK2kzdWxuOHhRcWZJbHY0dFRKOFQ0NXVod1B6dW8xSHk1MnhY?=
 =?utf-8?B?QzBMWW9jOG5uV2xmZmVORGhtajVocVlRU0JMQ3c2Zm5uNmR1cTBGMWJCbXc3?=
 =?utf-8?Q?DHkXGO8pgBj5UzX3vcQP838=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnRhZWZiVCtOdG1jT3RjUU9aVmh1MDBncTFpUUhZbUtHdUt0SWNBSHhSN3l4?=
 =?utf-8?B?N29pV1ZTVGI1aWlIdjhuMW5yTUorazdOKytVOUpmMFgvOGFjWVlEaXJLOXZZ?=
 =?utf-8?B?L2k1d3JLdktnTXFOR2t3ZWZPTk15dnR5ZmpVUkFrdHl3MWFHQTZNU2RRWURT?=
 =?utf-8?B?cVZyRUdBMytMTWdCeGpGR20wbUhLRkhPQTlrSEcwTmJ2YWw3UG9rWmZsMEFw?=
 =?utf-8?B?Tjlwekp4a1RoelJBNndnSk5Sc1lSanNic1ZaL3h4R3RWUXgzZkNMNmNwUStq?=
 =?utf-8?B?ekNQMXlGSEh0YUhtdHl0VVA3cDBXYmxZOFhGdDArYUJKdnF0cGtYYU9vUjBZ?=
 =?utf-8?B?Tjc1NXNETFMyRU85MTJsTEw4ZjBVOEtWN1puRnUyb09FR1RMdnZNNkVVeGRB?=
 =?utf-8?B?TlBLQ1dRdFdrckNHSjYxelhoMlE1eGNxaytvbjRISW9rV0RXYm1ZL2UydC9O?=
 =?utf-8?B?bkZyZTMrNFBoQm8yWTlnTUN1cG43MU1KZkp6ZVNQQXJsTHhtL0RCTnczUGVE?=
 =?utf-8?B?MXNSUGVBRnQzaFpUblAxY01jTzdDODRZU0JTQUc5L2d4amhzTUlyblNWYXBy?=
 =?utf-8?B?VklodjNGd2ZuUGVwZCtVSUpmZ252bWpwdTZFRnhaclhpenozRUlCZHpQRUNK?=
 =?utf-8?B?MmlGdWd3Rzd1QVI3d0IvV1FMdjhueWtGM05kcWdHQ2F0alFCdVUxNHV3Wkpy?=
 =?utf-8?B?MGg1WHJUU3lxVXYwbUlGWHZ2MVRJOGJVQXFjUC9YS1hsT1B5QmpJZTJzVUZO?=
 =?utf-8?B?bTRzNTY3alBwd0JDelFLb2xjV0N0U2I1Z0JIUVIrb09CeDFHQXYrWCtOVE1N?=
 =?utf-8?B?M25BWDFQU3ZnZVJsTEFYWnN6RlFPZ1N0OWxBOVZEeHBMQ2dzSUhBczRWNnJV?=
 =?utf-8?B?QWJWL1p0UVB2dmRhbTFjYldLM21ac0R2ZVVOcVNzVFNBR0hMUkd4RGNRQW1C?=
 =?utf-8?B?V05vaGgzSm9qazFvb051emthWWFuZ1N6bys0cENnNGp1clc4ZzJLdWdkT2Rr?=
 =?utf-8?B?NW00SGVzcnFSQlJaeUxLK1k4NkpwNWhJcHNDazN0K2QxZDBxWHlJNjdaSDVr?=
 =?utf-8?B?WHc5c3NPbDVRcUtTTVFBMHk0c0xYQ0Rsay9pazdramdGN2pzNXQ4YzI0WkhC?=
 =?utf-8?B?dEdZVlk2Q0JCeGVPNTFGS0R3aXM4STU4KytEcGxqZ3pzOHR0Nk04YXU4SGx4?=
 =?utf-8?B?MmZ6bW91NzlZMzQvbW8xTSsxOFdBdjlIM2h3bFA5YnFlbnNLY1hNOW9TUzNt?=
 =?utf-8?B?ZjQ1blVJaE1STjU0ZW5UU1JqbVVDYWhCVDFjWUJkQzh3SzhvdGk3RlFTcWVp?=
 =?utf-8?B?NmhDOEJISHFERk96SGs2c0k5UlJpRXoyQTh1Kysram5ROEdnTWZYWFlxcmw2?=
 =?utf-8?B?UkZYeHl4ZTVjQVdZRU5xQzN0aW1CU2dSSWIyZUowOVBEZnRrUC9sQ28xb1FB?=
 =?utf-8?B?V3VVVDNZVmdUWjNFUjcyZE9TNmE4aG5jZGcrWmUxd2VHSHJCMXdabGZPVjlK?=
 =?utf-8?B?TTBzbGw1TlFLMzVHbjZkRkpWT1NkS0pCWUIycDhaUWNZTElNeU53SG5ZK1Fi?=
 =?utf-8?B?NG9RdE1oaEtKdUcwbnUwaGZhdXBseVpQcExYekpFazFHOVlTeXpaVnJQUjRy?=
 =?utf-8?B?Q2M1WmoxekNiMGo4M2NRNTZrcHdvWHVHZVBjNU16VmlDaGJyMWlnN3R0NUJl?=
 =?utf-8?B?WTNKdDVsNGpYQmVkcUIwcE01N0cyTzlLSitTaVFkbGJrUFRNdkxVRTNMM2dr?=
 =?utf-8?B?NkdrLzdEbDFFeXZ3cGoyaDVjeXE4eEhabHAranNINVRTR2NJb1lFTnl2NVVl?=
 =?utf-8?B?N1NMek1YVCtqbm9rNHk2QlAxRFhzUThFR3VnSGgyUmg2eVFCbThzN1hjRTlY?=
 =?utf-8?B?S2t3cDhyVVFveXNqUktuSWswdjFZZnNmU0FBSkhpdk5KbGpCUHFCeGczZnJm?=
 =?utf-8?B?SlJ3ck9BYVUrY2RKYWtMcThERWx3R29xZlRqbGVUeGdYUVVZOFNIMm51QWtY?=
 =?utf-8?B?cmduYlllU1hwYlVsd25nMitnN3RtNU9FOWp4L3dBM1lQdHEwaDBjWS9xSnZP?=
 =?utf-8?B?QXoxeXlsaEE1dmN6WlJwMEo0VzBqbm5vREZDckxNNHJWaFlVNEZwQk9WL0RR?=
 =?utf-8?B?MDVJQ29FYzNMS3IydzBzKytBWGV5dzZsd0FNcFlOM2t6Um1uZUF4eTk2QmNw?=
 =?utf-8?B?K21nNko2SmVDQldYazVBZUFVVEtLYWt0dmZmR0ZyYlVrM3Q1cVpxREZBclVT?=
 =?utf-8?B?bVo2dEFDQUl5dzFqemtjeEVJNXpiSXN4Q0c0WFJ2NTJHeXFrdHlOdjRzNEJl?=
 =?utf-8?B?UEhLaWFZdlJMbUJrZ252dytFamRlSjVsdjZnYk91NmIraExsSkFzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C387B35E61FA4F916E0793817EEF97@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HeyUxcRVKcM8EQF3rvhY32q0DGErwokPPUU0l797xMu1/irZyURBbbLnE+WKr0R8dpq0AtCTJ7v7NrH4tz0dMsGx/Ypc3SgLZBiyT9wyufIa7eIVtohW+YG6zduEWUTJ2T7N8B9T9OjsjjALOiovNLYYjADvKK4oan5+3DyQv37GdTwfm28J79v8tD+FO3bJn6DXUudKBNolbu4NDPqD4co/GbC3J3UP4ccxk/LPfhdu6lvNnAG4bkVgaMw9+tM9iGkNeFXrf/dYE68cnagoRTuf8yIg+tUlhjgoZAcMSGH5Hbk6LsULzYuP30p775XHgfyRIm4YYQjWHpFTeopFtTCAfoxdSZdJZ6Kw0+PGqr9jGPzuJbgvBryPEhlWmEqVvfF031dYP/Tb/3gyAwx+dshNbtcz7LFIO3CMOxCM6c3mKeDrT0XFALRX/6yAXu3Zw+wJi7Gjr8ThAl315vPDfsplD+LXj6HsL75l7Qp+O/KolDUN0iYIM8e3FwFRQ7+dL8y06bVP95QYWYf8lYHA/VOu+WvOJT+S+i+fqhqAJ607jG0P4WJFIi6VFqeHjiXBkO1y7RAA4+S8V7UYG/K59lrn1a52JbcRgRgIs2/OLNL+jCQeJfpmDVZBTYqkii/D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2ec0db-4da6-46e8-0d8c-08de6dfc7a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 08:13:48.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2r+xr9bSyNnvm/DgYxvCfhP+26Es59KNndLzuZsUKoSH65X+/VKvPQ6ALMvNxgawtHoVoio6x7WvvgrgZARig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77342-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[suse.cz,gmail.com,wdc.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Hans.Holmberg@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 5D52E149C93
X-Rspamd-Action: no action

T24gMTYvMDIvMjAyNiAxMToxMCwgSmFuIEthcmEgd3JvdGU6DQo+IE9uIFRodSAxMi0wMi0yNiAx
ODozNzoyMiwgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+PiBPbiBUaHUsIEZlYiAxMiwgMjAyNiBh
dCA3OjMy4oCvUE0gSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPiB3cm90ZToNCj4+
PiBPbiBUaHUsIEZlYiAxMiwgMjAyNiBhdCAxMTo0MuKAr0FNIEpvaGFubmVzIFRodW1zaGlybg0K
Pj4+IDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDIv
MTIvMjYgMjo0MiBQTSwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4+Pj4+IEhpIGFsbCwNCj4+Pj4+
DQo+Pj4+PiBJJ2QgbGlrZSB0byBwcm9wb3NlIGEgdG9waWMgb24gZmlsZSBzeXN0ZW0gYmVuY2ht
YXJraW5nOg0KPj4+Pj4NCj4+Pj4+IENhbiB3ZSBlc3RhYmxpc2ggYSBjb21tb24gcHJvamVjdChs
aWtlIHhmc3Rlc3RzLCBibGt0ZXN0cykgZm9yDQo+Pj4+PiBtZWFzdXJpbmcgZmlsZSBzeXN0ZW0g
cGVyZm9ybWFuY2U/IFRoZSBpZGVhIGlzIHRvIHNoYXJlIGEgY29tbW9uIGJhc2UNCj4+Pj4+IGNv
bnRhaW5pbmcgcGVlci1yZXZpZXdlZCB3b3JrbG9hZHMgYW5kIHNjcmlwdHMgdG8gcnVuIHRoZXNl
LCBjb2xsZWN0IGFuZA0KPj4+Pj4gc3RvcmUgcmVzdWx0cy4NCj4+Pj4+DQo+Pj4+PiBCZW5jaG1h
cmtpbmcgaXMgaGFyZCBoYXJkIGhhcmQsIGxldCdzIHNoYXJlIHRoZSBidXJkZW4hDQo+Pj4+DQo+
Pj4+IERlZmluaXRlbHkgSSdtIGFsbCBpbiENCj4+Pj4NCj4+Pj4+IEEgc2hhcmVkIHByb2plY3Qg
d291bGQgcmVtb3ZlIHRoZSBuZWVkIGZvciBldmVyeW9uZSB0byBjb29rIHVwIHRoZWlyDQo+Pj4+
PiBvd24gZnJhbWV3b3JrcyBhbmQgaGVscCBkZWZpbmUgYSBzZXQgb2Ygd29ya2xvYWRzIHRoYXQg
dGhlIGNvbW11bml0eQ0KPj4+Pj4gY2FyZXMgYWJvdXQuDQo+Pj4+Pg0KPj4+Pj4gTXlzZWxmLCBJ
IHdhbnQgdG8gZW5zdXJlIHRoYXQgYW55IG9wdGltaXphdGlvbnMgSSB3b3JrIG9uOg0KPj4+Pj4N
Cj4+Pj4+IDEpIERvIG5vdCBpbnRyb2R1Y2UgcmVncmVzc2lvbnMgaW4gcGVyZm9ybWFuY2UgZWxz
ZXdoZXJlIGJlZm9yZSBJDQo+Pj4+PiAgICAgc3VibWl0IHBhdGNoZXMNCj4+Pj4+IDIpIENhbiBi
ZSByZWxpYWJseSByZXByb2R1Y2VkLCB2ZXJpZmllZCwgYW5kIHJlZ3Jlc3Npb27igJF0ZXN0ZWQg
YnkgdGhlDQo+Pj4+PiAgICAgY29tbXVuaXR5DQo+Pj4+Pg0KPj4+Pj4gVGhlIGZvY3VzLCBJIHRo
aW5rLCB3b3VsZCBmaXJzdCBiZSBvbiBzeW50aGV0aWMgd29ya2xvYWRzIChlLmcuIGZpbykNCj4+
Pj4+IGJ1dCBpdCBjb3VsZCBleHBhbmRlZCB0byBydW5uaW5nIGFwcGxpY2F0aW9uIGFuZCBkYXRh
YmFzZSB3b3JrbG9hZHMNCj4+Pj4+IChlLmcuIFJvY2tzREIpLg0KPj4+Pj4NCj4+Pj4+IFRoZSBm
c3BlcmZbMV0gcHJvamVjdCBpcyBhIHB5dGhvbi1iYXNlZCBpbXBsZW1lbnRhdGlvbiBmb3IgZmls
ZSBzeXN0ZW0NCj4+Pj4+IGJlbmNobWFya2luZyB0aGF0IHdlIGNhbiB1c2UgYXMgYSBiYXNlIGZv
ciB0aGUgZGlzY3Vzc2lvbi4NCj4+Pj4+IFRoZXJlIGFyZSBwcm9iYWJseSBvdGhlcnMgb3V0IHRo
ZXJlIGFzIHdlbGwuDQo+Pj4+Pg0KPj4+Pj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9qb3NlZmJh
Y2lrL2ZzcGVyZg0KPj4+Pg0KPj4+PiBJIHdhcyBhYm91dCB0byBtZW50aW9uIEpvc2VmJ3MgZnNw
ZXJmIHByb2plY3QuIFdlIGFsc28gdXNlZCB0byBoYXZlIHNvbWUNCj4+Pj4gc29ydCBvZiBhIGRh
c2hib2FyZCBmb3IgZnNwZXJmIHJlc3VsdHMgZm9yIEJUUkZTLCBidXQgdGhhdCB2YW5pc2hlZA0K
Pj4+PiB0b2dldGhlciB3aXRoIEpvc2VmLg0KPj4+Pg0KPj4+PiBBIGNvbW1vbiBkYXNoYm9hcmQg
d2l0aCBwZXIgd29ya2xvYWQgc3RhdGlzdGljcyBmb3IgZGlmZmVyZW50DQo+Pj4+IGZpbGVzeXN0
ZW1zIHdvdWxkIGJlIGEgZ3JlYXQgdGhpbmcgdG8gaGF2ZSwgYnV0IGZvciB0aGF0IHRvIHdvcmss
IHdlJ2QNCj4+Pj4gbmVlZCBkaWZmZXJlbnQgaGFyZHdhcmUgYW5kIHByb2JhYmx5IHRoZSB2ZW5k
b3JzIG9mIHNhaWQgaGFyZHdhcmUgdG8gYnV5DQo+Pj4+IGluIGludG8gaXQuDQo+Pj4+DQo+Pj4+
IEZvciBkZXZlbG9wZXJzIGl0IHdvdWxkIGJlIGEgYmVuZWZpdCB0byBzZWUgZXZlbnR1YWwgcmVn
cmVzc2lvbnMgYW5kDQo+Pj4+IG92ZXJhbGwgd2VhayBwb2ludHMsIGZvciB1c2VycyBpdCB3b3Vs
ZCBiZSBhIG5pY2UgdG9vbCB0byBzZWUgd2hhdCBGUyB0bw0KPj4+PiBwaWNrIGZvciB3aGF0IHdv
cmtsb2FkLg0KPj4+Pg0KPj4+PiBCVVQgc29tZW9uZSBoYXMgdG8gZG8gdGhlIGpvYiBzZXR0aW5n
IGV2ZXJ5dGhpbmcgdXAgYW5kIG1haW50YWluaW5nIGl0Lg0KPj4+Pg0KPj4+DQo+Pj4gSSdtIHN0
aWxsIGhlcmUsIHRoZSBkYXNoYm9hcmQgZGlzYXBwZWFyZWQgYmVjYXVzZSB0aGUgZHJpdmVzIGRp
ZWQsIGFuZA0KPj4+IGFsdGhvdWdoIHRoZSBoaXN0b3J5IGlzIGludGVyZXN0aW5nIGl0IGRpZG4n
dCBzZWVtIGxpa2Ugd2Ugd2VyZSB1c2luZw0KPj4+IGl0IG11Y2guIFRoZSBBL0IgdGVzdGluZyBw
YXJ0IG9mIGZzcGVyZiBzdGlsbCBpcyBiZWluZyB1c2VkIHJlZ3VsYXJseQ0KPj4+IGFzIGZhciBh
cyBJIGNhbiB0ZWxsLg0KPj4+DQo+Pj4gQnV0IHllYWggbWFpbnRhaW5pbmcgYSBkYXNoYm9hcmQg
aXMgYWx3YXlzIHRoZSBoYXJkZXN0IHBhcnQsIGJlY2F1c2UNCj4+PiBpdCBtZWFucyBzZXR0aW5n
IHVwIGEgd2Vic2l0ZSBzb21ld2hlcmUgYW5kIGEgd2F5IHRvIHN5bmMgdGhlIHBhZ2VzLg0KPj4+
IFdoYXQgSSBoYWQgZm9yIGZzcGVyZiB3YXMgcXVpdGUgamFua3ksIGJhc2ljYWxseSBJJ2QgcnVu
IGl0IGV2ZXJ5DQo+Pj4gbmlnaHQsIGdlbmVyYXRlIHRoZSBuZXcgcmVwb3J0IHBhZ2VzLCBhbmQg
c2NwIHRoZW0gdG8gdGhlIFZQUyBJIGhhZC4NCj4+PiBXaXRoIENsYXVkZSB3ZSBjb3VsZCBwcm9i
YWJseSBjb21lIHVwIHdpdGggYSBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMNCj4+PiBxdWlja2x5LCBz
aW5jZSBJJ20gY2xlYXJseSBub3QgYSB3ZWIgZGV2ZWxvcGVyLiBUaGF0IGJlaW5nIHNhaWQgd2UN
Cj4+PiBzdGlsbCBoYXZlIHRvIGhhdmUgc29tZXBsYWNlIHRvIHB1dCBpdCwgYW5kIGhhdmUgc29t
ZSBzb3J0IG9mIGhhcmR3YXJlDQo+Pj4gdGhhdCBydW5zIHN0dWZmIGNvbnNpc3RlbnRseS4NCj4+
Pg0KPj4NCj4+IFRoYXQncyB0aGUgbWFpbiBwb2ludCBJTU8uDQo+Pg0KPj4gUGVyZiByZWdyZXNz
aW9uIHRlc3RzIG11c3QgcmVseSBvbiBjb25zaXN0ZW50IGhhcmR3YXJlIHNldHVwcy4NCj4+IElm
IHdlIGRvIG5vdCBoYXZlIG9yZ2FuaXphdGlvbnMgdG8gZnVuZC9kb25hdGUgdGhpcyBoYXJkd2Fy
ZSBhbmQgcHV0IGluDQo+PiB0aGUgZW5naW5lZXJpbmcgZWZmb3J0IHRvIGRyaXZlIGl0LCB0YWxr
aW5nIGFib3V0IFdIQVQgdG8gcnVuIGluIExTRk1NDQo+PiBpcyB1c2VsZXNzIElNTy4NCj4gDQo+
IE15IGRheWpvYiBpcyB3YXRjaGluZyBrZXJuZWwgcGVyZm9ybWFuY2UgZm9yIG91ciBkaXN0cm8g
c28gSSBmZWVsIGEgYml0DQo+IG9ibGlnZWQgdG8gc2hhcmUgbXkgdmlldyA6KSBJIGFncmVlIHRo
ZSBwcm9ibGVtIGhlcmUgaXNuJ3QgdGhlIGxhY2sgb2YNCj4gdG9vbHMuIFdlIHVzZSBtbXRlc3Rz
IGFzIGEgc3VpdGUgZm9yIGJlbmNobWFya2luZyAtIHNpbmNlIHRoYXQgaXMgcmF0aGVyDQo+IGdl
bmVyaWMgc3VpdGUgZm9yIHJ1bm5pbmcgYmVuY2htYXJrcyB3aXRoIHF1aXRlIHNvbWUgYmVuY2ht
YXJrIGludGVncmF0ZWQNCj4gdGhlIGxlYXJuaW5nIGN1cnZlIGlzIHJlbGF0aXZlbHkgc3RlZXAg
YnV0IG9uY2UgeW91IGdldCBhIGh1bmNoIG9mIGl0IGl0DQo+IGlzbid0IGRpZmZpY3VsdCB0byB1
c2UuIEZzcGVyZiBpcyBJTU8gYWxzbyBmaW5lIHRvIHVzZSBpZiB5b3UgYXJlIGZpbmUgd2l0aA0K
PiB0aGUgbGltaXRlZCBiZW5jaG1hcmtpbmcgaXQgY2FuIGRvLiBUaGlzIGlzbid0IHRoZSBoYXJk
IHBhcnQgLSBhbnlvbmUgY2FuDQo+IGRvd25sb2FkIHRoZXNlIHN1aXRlcyBhbmQgcnVuIHRoZW0u
DQoNClllYWgsIHRoZXJlIHNlZW1zIHRvIGJlIG5vIGxhY2sgb2YgcHJvamVjdHMgdGhhdCBpbXBs
ZW1lbnRzIGJlbmNobWFya2luZw0KZnJhbWV3b3JrcyAtICBJJ2QganVzdCB3aXNoIHRoYXQgd2Ug
d291bGQgaGF2ZSBzb21ldGhpbmcgYXMgd2lkZWx5IHVzZWQgYXMNCmJsa3Rlc3RzL2ZzdGVzdHMg
Zm9yIGZpbGUgc3lzdGVtIGJlbmNobWFya2luZyBwdXJwb3Nlcy4NCg0KbW10ZXN0cyBzZWVtcyB0
byBiZSBhIGdyZWF0IG9wdGlvbiBmb3IgcmVncmVzc2lvbiB0ZXN0aW5nLCBzbyBpJ2xsICBoYXZl
DQphIGdvIGF0IHJ1bm5pbmcgYW5kIGFkZGluZyB0ZXN0cyB0byB0aGF0Lg0KDQo+IA0KPiBUaGUg
aGFyZCBwYXJ0IG9uIGJlbmNobWFya2luZyBpcyBoYXZpbmcgc2Vuc2libGUgaGFyZHdhcmUgdG8g
cnVuIHRoZSB0ZXN0DQo+IG9uLCBzZWxlY3RpbmcgYSBiZW5jaG1hcmsgYW5kIHNldHVwIHRoYXQn
cyBhY3R1YWxseSBleGVyY2lzaW5nIHRoZSBjb2RlDQo+IHlvdSdyZSBpbnRlcmVzdGVkIGluLCBh
bmQgZ2V0dGluZyBzdGF0aXN0aWNhbGx5IHNpZ25pZmljYW50IHJlc3VsdHMgKGkuZS4sDQo+IGRp
c2Nlcm5pbmcgcmFuZG9tIG5vaXNlIGZyb20gcmVhbCBkaWZmZXJlbmNlcykuIEFuZCB0aGVzZSBh
cmUgdGhpbmdzIHRoYXQNCj4gYXJlIGRpZmZpY3VsdCB0byBzaGFyZSBvciBzb2x2ZSBieSBkaXNj
dXNzaW9uLg0KDQpJIHRoaW5rIGRlc2lnbmluZyBnb29kIGJlbmNobWFya3MgaXMgYSByZWFsbHkg
dHJpY2t5IHBhcnQgYXMgd2VsbCwgYnV0IG1heWJlDQp0aGF0J3MganVzdCBtZSA6KQ0KDQo+IA0K
PiBBcyBvdGhlcnMgd3JvdGUgb25lIHNvbHV0aW9uIHRvIHRoaXMgaXMgaWYgc29tZW9uZSBkZWRp
Y2F0ZXMgdGhlIGhhcmR3YXJlDQo+IGFuZCBlbmdpbmVlcnMgd2l0aCBrbm93LWhvdyBmb3IgdGhp
cy4gQnV0IHJlYWxpc3RpY2FsbHkgSSBkb24ndCBzZWUgdGhhdA0KPiBoYXBwZW5pbmcgaW4gdGhl
IG5lYXJ0ZXJtLiBUaGVyZSBtaWdodCBiZSBvdGhlciBzb2x1dGlvbnMgaG93IHRvIHNoYXJlIG1v
cmUNCj4gLSBsaWtlIHNoYXJpbmcgYSBWTSB3aXRoIHByZWNvbmZpZ3VyZWQgc2V0IG9mIGJlbmNo
bWFya3MgY292ZXJpbmcgdGhlDQo+IGJhc2ljcyAoc2ltaWxhcmx5IHRvIHNvbWUgcGVvcGxlIHNo
YXJpbmcgVk0gaW1hZ2VzIHdpdGggcHJlY29uZmlndXJlZA0KPiBmc3Rlc3RzIHJ1bnMpLiBCdXQg
SSBkb24ndCBoYXZlIGEgY2xlYXIgcGljdHVyZSBob3cgbXVjaCBzdWNoIHRoaW5nIHdvdWxkDQo+
IGhlbHAuDQo+IA0KPiAJCQkJCQkJCUhvbnphDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIGV2
ZXJ5b25lIQ0KDQoNCg==

