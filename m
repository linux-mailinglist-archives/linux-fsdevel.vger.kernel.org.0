Return-Path: <linux-fsdevel+bounces-77113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O/lKV3rjmkCGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:14:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE0134537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 129B0302F41C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93B33E36B;
	Fri, 13 Feb 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F7WXkq73";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y1gQ/fD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3633DED9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974042; cv=fail; b=oNkIcfv/rNBE2fRSgE6jo6WxW4jJ1762TQCNl358l3Z+kgp4ygBbW18/suKSIBI4epFGagkc4dHmnLA4qw+lNvQteyXXRtehxOe4CWvClnRuHvV4UeSYS8bQi9pbxdSRM5J5uGhspeMW52fDEj7QtckG6nlXVgmWENPPE8cCXEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974042; c=relaxed/simple;
	bh=fsTzMUXbJr0/HbLbKf/qd/oSAdSqFOVoKlenDUmEc6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMZ1JYbMstY3TnPuooEKFyXnsvZTOWuDLst1ssTZdV4yDBOPLGwJGZNxVKS+hLf3SCeP2mSGGyx7y9JVB0R8x/1rclPlr8FweAoxZIZIdPf1ezGCdafvfuxjl/Pn+KgcTMjV6wW3aoyQvAv/uWQg1KFDS+wow0GQvuhP9DadkQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F7WXkq73; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Y1gQ/fD1; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770974040; x=1802510040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fsTzMUXbJr0/HbLbKf/qd/oSAdSqFOVoKlenDUmEc6Q=;
  b=F7WXkq73zE+It/GvLF9Ev/6bNHDu/i0zokxMugjILFHUyjrlvi7DDi6E
   TJeWWVuhMhw3UU3SoOGsSJbVAUhc19YvNy1lEgTzU8LbVBI/as5hWSUpw
   uzsJ2JnYVdfoFdZx9KYL3EsGl4EB50RPZ4CWOLEIEfqY/cmrW7Wzm+T+c
   8S6KYCJpIJivYLsAjNqFvLuP4OWrCNe9ETh70Z/48D7e7bZvfpPbCw98b
   6CKZ7w06lSp6JqvTkm+PUZccHufD0EfH0cEPsazdAQyRtT+P7dE+QOkm4
   JSmGMhY7W0nwEsE5qeAzhmm3MKOdUtUy9sXKu+RtVEo2wdvgx2NS3d7M/
   A==;
X-CSE-ConnectionGUID: bvg1Ho+OSjyAF+q55fukYA==
X-CSE-MsgGUID: NnoyPCWVTzuOODMkE2SUzA==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="140337255"
Received: from mail-westcentralusazon11013023.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 17:13:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNBgDKRcEwIsl+jCpPcdYXTLpfltM0MVcaLDCWzh4fylBozk7lwwLgK0Kv1HmEabJmw3bL4hiNKD0xcghAXxCCjBRLZkyFyoqxjGQTMBAwZnrSHqqY7xuE3/uaicZZERQYkJYv1MCP65dhaA+MlEAp935vaoMUIDUSnN86UC/ePTEx1YgzNTwK7TOvpzT7DtZyihJVKIYXtbiKv4T2Ds2I50HRIw1dWI4pycUk3JHSjUpuZpnSzQTdf7+p1lfKA/UszZdRGux8CQ1Gfnw3yFQ2QHc7PFS2+lHj/uyxoY3rgLy24qHJptdkmW/Bwwmdltf8VCvxeabExroPMtVNzzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsTzMUXbJr0/HbLbKf/qd/oSAdSqFOVoKlenDUmEc6Q=;
 b=hGbdbT1VRFwvDxBaPxe3lejs4MtmIXFf9Jgp/KG3hK1veu9IcNoOqtj1HlY0fXawJrKpNiVsccQg+TexVIQ0GzmeciEVCCWuS8j9/0+ut6UQ2Tboq6WcQQ5f6LZPuxzVu2ehtDzGYFhLbTV0gnk6JVx5JCaXrrlyt19H19jJIqTWXEiadCd/+2SsF1CTmJkE1OWmBgGxkH9bJzUL78Y8fuKuYkpa0QzCrknnZY8KzVn6fFn4CG5uEQ+tRCrG6YqLZZdbc6sYtAKj9Rpwhj7D7QcxhKjS97Bo7Mno8ZfgCy4iGCsKOPtY4RTFsSmuALn9qjRANdPxC9wGqE8Rv363dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsTzMUXbJr0/HbLbKf/qd/oSAdSqFOVoKlenDUmEc6Q=;
 b=Y1gQ/fD1T434gF9bM+pRLvfLtY3Dehsr59dkH6BtD5Y6c1VBuDYlvFaWdWnWHzR/GgvRZG+QuLv6qtX1V2Xlau436yp8kkysK7aw1Q2b570BYUEDyduq+dRNWVrmkCB/HKqif8ZC+g3GIJJj7CZBEbku9J60pTn+Gi/xMHv0KCA=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by PH0PR04MB7511.namprd04.prod.outlook.com (2603:10b6:510:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:13:57 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:13:56 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "jack@suse.com" <jack@suse.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Thread-Index: AQHcnCVy+M/y38WvJkeD9gq7IpAat7V/ROOAgAAN6oCAAAFkAIAAF+6AgADtvwA=
Date: Fri, 13 Feb 2026 09:13:56 +0000
Message-ID: <cf036899-33ce-40cf-902d-bd1d649b55d4@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
 <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
 <CAEzrpqdOmT_U=+7wrD+x-ZS9JH9TM-j=ASW=xP2zvmVu0+wnHg@mail.gmail.com>
In-Reply-To:
 <CAEzrpqdOmT_U=+7wrD+x-ZS9JH9TM-j=ASW=xP2zvmVu0+wnHg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|PH0PR04MB7511:EE_
x-ms-office365-filtering-correlation-id: 1b9fc7d8-aac9-487a-6a91-08de6ae0376d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0NOSFNnT2JSYWZpbWs3WmNrYnphZXBiakg4cTY2NzdwMXRxbzY5SkNUMDBN?=
 =?utf-8?B?VWxvLzNkYTh1dHl5YTVVY2tqQ1lFTVZwWW5ZMi82a09xeG9SeTRpdmlYdito?=
 =?utf-8?B?elo5YUJzRXBTaDZkSzlsR1NqN0JJRUtMci9vVlJSa1JGK0hiMVBLTXVPaUtQ?=
 =?utf-8?B?d3BNVk5wenZsai9rQi9oaHpWRFJOM2YvOG1jVEV2U0YxclMzUzJvUTdCM1Ry?=
 =?utf-8?B?OEFrb2Z3MkNXNW9LakNkR3pKaThiYUh4MFA1dWV0T042YnlrMk5GSUVyd05y?=
 =?utf-8?B?WGI5bklsL3FERHdUU3dyZzlaOHpEbTBtdEFKdHF1QklBMEtaYUtqWjYwSTBY?=
 =?utf-8?B?NGxEeklacnJYeDhDNmFzVlRDQTNqZDJaVFdMakhtdjBpYmlpOGpaRWtzakYy?=
 =?utf-8?B?QldQMTZnNTBqckhkSVo1UkRIWUZvNy9hd3hBWWI0QnJBSS9maGNtSmlvWGE2?=
 =?utf-8?B?bGo4aHA0amRYVUNFdnZBc3ZDUXlFYzZnK2VZa29RT21HVGdwbHZiaGhPWGp1?=
 =?utf-8?B?RS9EMGR2OXhxQ3NMQzRoelVyNERqeXM1RE5VdUVpV1BBbkp0N25DQ3E1SVhK?=
 =?utf-8?B?SExBVytOMjNSNndFdkh2Y25hWmdSa2J3YW5LcldQVmhRaGhzYW9qeHlKUHBy?=
 =?utf-8?B?V0M0UXR6YTh3aTFyNzhteHVkb0pKMWtiVlIrQ0hDdlhzYTVGUWxNM05hZFQw?=
 =?utf-8?B?dmVMMW8yVys4cHpHSmYxOVVCNWFpc05KMU8vb3VWZmRaNzZuQVJ0dUxWMW9m?=
 =?utf-8?B?VEJXUnhzeE5HbGJnZ2NFOS9LUXE1Wnd0cnFJUGlGVDJqOEx5dm9VbmlWbVVy?=
 =?utf-8?B?VlJjM2RLZkY2SjJBL0dXUnNmMXpqemZDbURVZDJMcjF5UWttRlA4RWVUUlRi?=
 =?utf-8?B?ZVpERXpvcGtpcEttaEQybmNRdnhRRFBteVF4SFc1R1BhT1N4NWFkVWkvblhs?=
 =?utf-8?B?Y3FncGNQZzZRbnZ3NzlwakdsZE5ZMldqNTcwUHovUnl4TGJhYUxNczV0WDJr?=
 =?utf-8?B?eVNsREtUdWs4S05KUTRRU3lHTEsvV0dvN25vN1Q4QXhXM0hRRmV4UXNKc01s?=
 =?utf-8?B?aWdxR1JoSGNab0ZYb2tIeTJqVy9XUzlKMVJMUFYxU2RxNWFvVzFLUWQrUjNz?=
 =?utf-8?B?elZIK3VqTlhreXlPdHo4Qkd6T0xrdXhtQ0lCN3BCaC96V2cwdXM3QUUvU0Z0?=
 =?utf-8?B?eS9lMkFQd095YWozTWxlOS8xMHhGb0g2YlRORUtyMmRqaUY4b1ltUHo2K3Rx?=
 =?utf-8?B?blFKWTBKOEgxMm92aHFkV09JRHNtMXF1eE10MThqL2JWQTJoZjRoMVdRVDdr?=
 =?utf-8?B?T2tJYngrNVFqa00zQ2wwNFZtcW1rNjlzNTVXTVNuYTRLNU9Ka2sxWHZ4bTVP?=
 =?utf-8?B?WW16WEdob2pGamVPRlh4NDF1VXFFbUxwWUdNenpTQytDRnJHQ1J3QjkwbC84?=
 =?utf-8?B?eGRLTy9VUHo1ZEViZHhETU5tWTY4UUg5WHM0alRoSE9BMHhjczlON09rd01l?=
 =?utf-8?B?aHdCQzdGaE9wWHRPckhGcEp1UUhJc0Naa1dRZkR6ekV1enBzdjh3VW5vb1hO?=
 =?utf-8?B?SENMYTdiSXVPaHgyQ1JPWjNnbkxXdzVBNjc4cmpmU21RMnBjemRHNEEwYlFB?=
 =?utf-8?B?ckVjWXg5b3dVM25vQUFkRkdIYWxadGNOM2ZqWXFEOXdxdVFFdWJrb3VZV0h2?=
 =?utf-8?B?RnN5eHFKOG9iWndzVzBEeUs0Q3FxaUZoYzE1ai9hYTlpY3dsd3BvOXhNc2Zx?=
 =?utf-8?B?VmdKMlFoa0FtKzI5dS9TbUNrTDYwd3dyaEpzV1ZJWnJOdXd1aWo1WlFpZndY?=
 =?utf-8?B?cHFKb0lsOStlVzdUdit1c2xvam9HbTBVVWFFYm5heURCN0NlcE9yVkh2MUY4?=
 =?utf-8?B?Mk9oMkxnNmxqUEFZVmgxbUJVT0J0eUw1TFpKVFRrWVJnTHhtcmFDelQweGZx?=
 =?utf-8?B?R2Y0YmMvWkVxTGVjMHhzblhORzBQc1czcG1RdFJRb1RhTVoyNzR6SGNib0lH?=
 =?utf-8?B?elhJWjhNTE15NjRSMnhJdE81UC9tMU9UUFdMV3hHeklzbTFMOVVXTFVoelA1?=
 =?utf-8?B?cTZjRnZkZVFjZVJOUGp2ZmZ4R0ZaNkRpbnRUeUFUSlJhWHlISnZoYm1iWUZX?=
 =?utf-8?B?ZnBsZTl1UlhpVDNxMEdHTUZnZlYyajllMFBueUdqVDBkb2ZidVpWM3VOVTFl?=
 =?utf-8?Q?sNBk1bUjxednMFlPg3dsdrA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnE0bmhMNXhCbUs4R005VjV5NDdUZkpoRTMyZ1NGRlBCc0NpVWlxbXRwMWtt?=
 =?utf-8?B?a1VNN0lTSjdrNTl4dFg5SlVidXBpYjNmMHJPQkdER1FzcndNRThjaVNKd1kx?=
 =?utf-8?B?dTZLeEJqL3pVS1AycCs3NGo0Vi9rVi80ZmlZK3lBcHdqWjB5QkgwcVFkWXJz?=
 =?utf-8?B?SWJuVGErSTFMdEtabVBzMlR6eUxzSzZwWWJCMHVXMVRVTXJwZkJSbGJ5bFFJ?=
 =?utf-8?B?amYrMUxlMjZXdXo2Y1R2Zlh1a1IvWGJhSXpZdDkrL25TTzh1ZUdNd2V3QVBl?=
 =?utf-8?B?S3RyaWh5aUVYRE9VYStNMlFCOEpySndTRmVTdEg1NDJRelJxU0twbDVoKy8r?=
 =?utf-8?B?UFc3WGh1T040T2h3OTNHT21pV2VVNVhwZUtQZHo2WGZ4YXFPS0FLM2tEZG1j?=
 =?utf-8?B?UUtmU1VYNlRtTmRnVXZXczBVRGVnN25wQXBCMWxXWlVsRlgrZXJiV0MzSkRN?=
 =?utf-8?B?ZVluSUVReGQySmVnMWZoKzhoQXZ1b25DUWFudnVta05XVE96dXZ5dG9MWGdV?=
 =?utf-8?B?VW44czBxSzExSDhMbmRSUFVFQjJ6RnpYK05OSUdlRDk2OEFBRURnWVhkVlVV?=
 =?utf-8?B?UmN4MEN1bFd2a1BibHNWZFF6ZHBiMmpQUGNqdzdES3UreEVldEZ6TEJBd0dF?=
 =?utf-8?B?TTlmUE9CekhjcXFlSGc1M3c5eVIyVWtYVEdwK1hZV3BrZGNuSnF4NlRheXl0?=
 =?utf-8?B?WlJwOW9qZ0I3TnZIMSsyYjFBcmpjeVJJYXJ1a1ZxbjY4OHc0SG8yWXR2Vmhj?=
 =?utf-8?B?Ync5UWJyZkVvcjVZT1pmSU5sbTdDZmJ1Smg2YkJWeDc5TStHRDVhbTN6dGhT?=
 =?utf-8?B?WW9jWlpxeWpDcmEvaE1YMG5vbjRpMFBrcUxWK0JZWlRBQVcyTmlZbVp2ZGVG?=
 =?utf-8?B?SS85ZjF2MUNTbkx0Z1U2ckx5QjNyNXhSY0JUbC80eTRzVnNhZ2dBOEd1RWow?=
 =?utf-8?B?V29CampWMndncjAyM3JCV0lMWE13VTNYQmlyby9yeGdMZHpPTERRWllzOTJx?=
 =?utf-8?B?dmRWbmN5c2FyMFZxU3h3U3g2ZitFZ0ZMS1pDYmZPRTlIRzA3K0NxTlR5TlRW?=
 =?utf-8?B?VWl6cGMzNDdDYzBHVDVyenQzTlJjRURrcncrOTlxS3RwSkphNGlUKzUrOHNt?=
 =?utf-8?B?MUNFRDhuaTVTMVpZQXpPbTNtdUlUQ20rSURMZlYvcnN5aWhmSFBhQ3FXZU9a?=
 =?utf-8?B?SStNVHZSZm9RTnNtdVFhS3RPU3NtSmVkY25DKy83V3lwME1sTE9IeDBNV0N0?=
 =?utf-8?B?aUwxZnVFdVpSNDNXQjJoN3RueWx6VEljV3lxOHV0S1d6QW9wK1RmWmFmQWUy?=
 =?utf-8?B?NEpkZTNYYmFCblJhNENLZXI3U3EybCt2Zm9rd3lsTEt3cGFlMWZYNlVNc3Rl?=
 =?utf-8?B?VEZEN3VzN3lwSWQyVWZPTnc4WnlVSURBUitYSXhGTUJvWm5yVjNrYkd5Umh3?=
 =?utf-8?B?aFU1NnhkamswVUVldTIydWxjZm5xTG1FNE40NjkxS1NRTisvWERnek1wOFdk?=
 =?utf-8?B?VmhBSCs0R1lsUjIreTBKWktpNlZqMXNXbWE4VTZ1SFFBTmV3WHp5Y0dXSlpH?=
 =?utf-8?B?c2dNUVFyWFA0dUMxNVJkeEZTUXplZUxwV2FrQnlmQ0J2V0d6RUgyNFFTcncr?=
 =?utf-8?B?M1BieWg1cnV5bncvSU5vcTlKbUh4RzJaUnNaamcvTVJiT3hWVXFuZlVOY1Ez?=
 =?utf-8?B?SFA4R0I5WVlEanVzcDRlWTBDMkljVmJNaFFHZ2laQUhoSU9nR05xMm9UTHFX?=
 =?utf-8?B?T0IzNjFCR2dlcXl5YjlLNWpaQVNTS1QvN1JkUGFRNEhNSkMxVFd2ajVRVUtF?=
 =?utf-8?B?K2xCMWM4VkhXQ2tqRUNBcVlqRHBjOGlDMGV2cWI1UGMzQWxYM2ZMRXRBZFhR?=
 =?utf-8?B?Q1dtTUNSSDA3aGYwRXdtc2lvdDRmWGNQd0Uvc2lWdVRGN2hmWXpqVjBqdlZo?=
 =?utf-8?B?TkxlcmxSZEJDeVZXc2d6ckkya0Y1UllYekNwNE1hRDV3NUNoTVAwcC8yWC9D?=
 =?utf-8?B?Zy9OMmozeVNGT0VTdHA4SE5ISEQwL0wwYmZiVmw0VjA5cm52dlVYempCZXdj?=
 =?utf-8?B?c256VUg2d2FGSjVoTm9TT3dzNDFlSEoxQU13WUhkamt3QXZIMzFZWXE4a3A1?=
 =?utf-8?B?VmkrU2xBTjZua1pPWEgrbnl6d3JoTzA1QnRFTWU0NTRvU0k0aVRERWNtZ0Fr?=
 =?utf-8?B?L0lzcGNIaExoSFB1WG1DbHRIbXRIREZMcGhsaHgxWEVTRllGekNVQlZycXR5?=
 =?utf-8?B?blR2ZHFnZDFZbDA4ZDVEdHc2TlRMcnd1UjJxS3Q3Mk9lR2hNWG53NnVEMXNl?=
 =?utf-8?B?S25TdkhFK2lDdm5SR1JQVU5UcmdWYzFVeE1IQ242YWNNU1dacXgyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA2BCFCE286B1C40A21194367AA45DF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rSsxaeDvDVkJSSCHnlSDQrZdvz+WMojiZENTUV97FaKJpMm9VNVGY+M9NBAh9lvLcofWnAsOxuTSQUxVs7oeBXQZmY3Ae7VXpvD/mHMIWmT/m1rJU1KJMr8KfKVpDq++2s+Xdu9WfAN7Dl/SRWGHautxDG/z24H5M0j4uywc8cttT+gzWaSeVKJwhQa8HoDgkhomw6+qRoZk/cCnFAfUajlVUi6WKyJv4Q+SnZcDA+BCfuLgnGZSjulbMqC8JsaHHbNBL5KgUbwXctTv1uP6MNt68SdmLBkaD1OXmTP0v3yvSqjrXiV2fC/SSUvrofGI2lF1+6kYG/4fi1xjI9E2CuqpBw6CED2w3mi2zX8XbmQH9sUxqhlNE7Gzd4bmGDdZ8BYqN6skhRfII9DFcHD5E4EJyhNJlLuiAtuta24Z1pDbi4mqvCS/d72mRlkhKDufHubP0LJWNQGIK/iafrIyJAttuIjbGOnbvrUY2iHq+Vmy2EvoCOT++KfKuduIIXbbG9ykrw+KFKAzd30bVDZfDmBRZSOp7g1s+BbeX/5Q37TObDYQS657CxxRJKnV4zz5ScIq0dou81nziKcKnK1FoKBVgSz+72o8LFgIr0YlD8zgkxmUmyJm4biGkdtmBQxp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9fc7d8-aac9-487a-6a91-08de6ae0376d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 09:13:56.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOiDQCBbDJgap0MhFXDr175f87xsLChibZ9JPvkDNgxKq0I6qvrkQytj2o0L8NVkW0a9ooDDFDYxgQjOHuy0GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7511
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77113-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[toxicpanda.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Hans.Holmberg@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 25FE0134537
X-Rspamd-Action: no action

T24gMTIvMDIvMjAyNiAyMDowMywgSm9zZWYgQmFjaWsgd3JvdGU6DQo+IE9uIFRodSwgRmViIDEy
LCAyMDI2IGF0IDEyOjM34oCvUE0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4g
d3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBGZWIgMTIsIDIwMjYgYXQgNzozMuKAr1BNIEpvc2VmIEJh
Y2lrIDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBPbiBUaHUsIEZlYiAx
MiwgMjAyNiBhdCAxMTo0MuKAr0FNIEpvaGFubmVzIFRodW1zaGlybg0KPj4+IDxKb2hhbm5lcy5U
aHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IE9uIDIvMTIvMjYgMjo0MiBQTSwg
SGFucyBIb2xtYmVyZyB3cm90ZToNCj4+Pj4+IEhpIGFsbCwNCj4+Pj4+DQo+Pj4+PiBJJ2QgbGlr
ZSB0byBwcm9wb3NlIGEgdG9waWMgb24gZmlsZSBzeXN0ZW0gYmVuY2htYXJraW5nOg0KPj4+Pj4N
Cj4+Pj4+IENhbiB3ZSBlc3RhYmxpc2ggYSBjb21tb24gcHJvamVjdChsaWtlIHhmc3Rlc3RzLCBi
bGt0ZXN0cykgZm9yDQo+Pj4+PiBtZWFzdXJpbmcgZmlsZSBzeXN0ZW0gcGVyZm9ybWFuY2U/IFRo
ZSBpZGVhIGlzIHRvIHNoYXJlIGEgY29tbW9uIGJhc2UNCj4+Pj4+IGNvbnRhaW5pbmcgcGVlci1y
ZXZpZXdlZCB3b3JrbG9hZHMgYW5kIHNjcmlwdHMgdG8gcnVuIHRoZXNlLCBjb2xsZWN0IGFuZA0K
Pj4+Pj4gc3RvcmUgcmVzdWx0cy4NCj4+Pj4+DQo+Pj4+PiBCZW5jaG1hcmtpbmcgaXMgaGFyZCBo
YXJkIGhhcmQsIGxldCdzIHNoYXJlIHRoZSBidXJkZW4hDQo+Pj4+DQo+Pj4+IERlZmluaXRlbHkg
SSdtIGFsbCBpbiENCj4+Pj4NCj4+Pj4+IEEgc2hhcmVkIHByb2plY3Qgd291bGQgcmVtb3ZlIHRo
ZSBuZWVkIGZvciBldmVyeW9uZSB0byBjb29rIHVwIHRoZWlyDQo+Pj4+PiBvd24gZnJhbWV3b3Jr
cyBhbmQgaGVscCBkZWZpbmUgYSBzZXQgb2Ygd29ya2xvYWRzIHRoYXQgdGhlIGNvbW11bml0eQ0K
Pj4+Pj4gY2FyZXMgYWJvdXQuDQo+Pj4+Pg0KPj4+Pj4gTXlzZWxmLCBJIHdhbnQgdG8gZW5zdXJl
IHRoYXQgYW55IG9wdGltaXphdGlvbnMgSSB3b3JrIG9uOg0KPj4+Pj4NCj4+Pj4+IDEpIERvIG5v
dCBpbnRyb2R1Y2UgcmVncmVzc2lvbnMgaW4gcGVyZm9ybWFuY2UgZWxzZXdoZXJlIGJlZm9yZSBJ
DQo+Pj4+PiAgICAgc3VibWl0IHBhdGNoZXMNCj4+Pj4+IDIpIENhbiBiZSByZWxpYWJseSByZXBy
b2R1Y2VkLCB2ZXJpZmllZCwgYW5kIHJlZ3Jlc3Npb27igJF0ZXN0ZWQgYnkgdGhlDQo+Pj4+PiAg
ICAgY29tbXVuaXR5DQo+Pj4+Pg0KPj4+Pj4gVGhlIGZvY3VzLCBJIHRoaW5rLCB3b3VsZCBmaXJz
dCBiZSBvbiBzeW50aGV0aWMgd29ya2xvYWRzIChlLmcuIGZpbykNCj4+Pj4+IGJ1dCBpdCBjb3Vs
ZCBleHBhbmRlZCB0byBydW5uaW5nIGFwcGxpY2F0aW9uIGFuZCBkYXRhYmFzZSB3b3JrbG9hZHMN
Cj4+Pj4+IChlLmcuIFJvY2tzREIpLg0KPj4+Pj4NCj4+Pj4+IFRoZSBmc3BlcmZbMV0gcHJvamVj
dCBpcyBhIHB5dGhvbi1iYXNlZCBpbXBsZW1lbnRhdGlvbiBmb3IgZmlsZSBzeXN0ZW0NCj4+Pj4+
IGJlbmNobWFya2luZyB0aGF0IHdlIGNhbiB1c2UgYXMgYSBiYXNlIGZvciB0aGUgZGlzY3Vzc2lv
bi4NCj4+Pj4+IFRoZXJlIGFyZSBwcm9iYWJseSBvdGhlcnMgb3V0IHRoZXJlIGFzIHdlbGwuDQo+
Pj4+Pg0KPj4+Pj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9qb3NlZmJhY2lrL2ZzcGVyZg0KPj4+
Pg0KPj4+PiBJIHdhcyBhYm91dCB0byBtZW50aW9uIEpvc2VmJ3MgZnNwZXJmIHByb2plY3QuIFdl
IGFsc28gdXNlZCB0byBoYXZlIHNvbWUNCj4+Pj4gc29ydCBvZiBhIGRhc2hib2FyZCBmb3IgZnNw
ZXJmIHJlc3VsdHMgZm9yIEJUUkZTLCBidXQgdGhhdCB2YW5pc2hlZA0KPj4+PiB0b2dldGhlciB3
aXRoIEpvc2VmLg0KPj4+Pg0KPj4+PiBBIGNvbW1vbiBkYXNoYm9hcmQgd2l0aCBwZXIgd29ya2xv
YWQgc3RhdGlzdGljcyBmb3IgZGlmZmVyZW50DQo+Pj4+IGZpbGVzeXN0ZW1zIHdvdWxkIGJlIGEg
Z3JlYXQgdGhpbmcgdG8gaGF2ZSwgYnV0IGZvciB0aGF0IHRvIHdvcmssIHdlJ2QNCj4+Pj4gbmVl
ZCBkaWZmZXJlbnQgaGFyZHdhcmUgYW5kIHByb2JhYmx5IHRoZSB2ZW5kb3JzIG9mIHNhaWQgaGFy
ZHdhcmUgdG8gYnV5DQo+Pj4+IGluIGludG8gaXQuDQo+Pj4+DQo+Pj4+IEZvciBkZXZlbG9wZXJz
IGl0IHdvdWxkIGJlIGEgYmVuZWZpdCB0byBzZWUgZXZlbnR1YWwgcmVncmVzc2lvbnMgYW5kDQo+
Pj4+IG92ZXJhbGwgd2VhayBwb2ludHMsIGZvciB1c2VycyBpdCB3b3VsZCBiZSBhIG5pY2UgdG9v
bCB0byBzZWUgd2hhdCBGUyB0bw0KPj4+PiBwaWNrIGZvciB3aGF0IHdvcmtsb2FkLg0KPj4+Pg0K
Pj4+PiBCVVQgc29tZW9uZSBoYXMgdG8gZG8gdGhlIGpvYiBzZXR0aW5nIGV2ZXJ5dGhpbmcgdXAg
YW5kIG1haW50YWluaW5nIGl0Lg0KPj4+Pg0KPj4+DQo+Pj4gSSdtIHN0aWxsIGhlcmUsIHRoZSBk
YXNoYm9hcmQgZGlzYXBwZWFyZWQgYmVjYXVzZSB0aGUgZHJpdmVzIGRpZWQsIGFuZA0KPj4+IGFs
dGhvdWdoIHRoZSBoaXN0b3J5IGlzIGludGVyZXN0aW5nIGl0IGRpZG4ndCBzZWVtIGxpa2Ugd2Ug
d2VyZSB1c2luZw0KPj4+IGl0IG11Y2guIFRoZSBBL0IgdGVzdGluZyBwYXJ0IG9mIGZzcGVyZiBz
dGlsbCBpcyBiZWluZyB1c2VkIHJlZ3VsYXJseQ0KPj4+IGFzIGZhciBhcyBJIGNhbiB0ZWxsLg0K
Pj4+DQo+Pj4gQnV0IHllYWggbWFpbnRhaW5pbmcgYSBkYXNoYm9hcmQgaXMgYWx3YXlzIHRoZSBo
YXJkZXN0IHBhcnQsIGJlY2F1c2UNCj4+PiBpdCBtZWFucyBzZXR0aW5nIHVwIGEgd2Vic2l0ZSBz
b21ld2hlcmUgYW5kIGEgd2F5IHRvIHN5bmMgdGhlIHBhZ2VzLg0KPj4+IFdoYXQgSSBoYWQgZm9y
IGZzcGVyZiB3YXMgcXVpdGUgamFua3ksIGJhc2ljYWxseSBJJ2QgcnVuIGl0IGV2ZXJ5DQo+Pj4g
bmlnaHQsIGdlbmVyYXRlIHRoZSBuZXcgcmVwb3J0IHBhZ2VzLCBhbmQgc2NwIHRoZW0gdG8gdGhl
IFZQUyBJIGhhZC4NCj4+PiBXaXRoIENsYXVkZSB3ZSBjb3VsZCBwcm9iYWJseSBjb21lIHVwIHdp
dGggYSBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMNCj4+PiBxdWlja2x5LCBzaW5jZSBJJ20gY2xlYXJs
eSBub3QgYSB3ZWIgZGV2ZWxvcGVyLiBUaGF0IGJlaW5nIHNhaWQgd2UNCj4+PiBzdGlsbCBoYXZl
IHRvIGhhdmUgc29tZXBsYWNlIHRvIHB1dCBpdCwgYW5kIGhhdmUgc29tZSBzb3J0IG9mIGhhcmR3
YXJlDQo+Pj4gdGhhdCBydW5zIHN0dWZmIGNvbnNpc3RlbnRseS4NCj4+Pg0KPj4NCj4+IFRoYXQn
cyB0aGUgbWFpbiBwb2ludCBJTU8uDQo+Pg0KPj4gUGVyZiByZWdyZXNzaW9uIHRlc3RzIG11c3Qg
cmVseSBvbiBjb25zaXN0ZW50IGhhcmR3YXJlIHNldHVwcy4NCj4+IElmIHdlIGRvIG5vdCBoYXZl
IG9yZ2FuaXphdGlvbnMgdG8gZnVuZC9kb25hdGUgdGhpcyBoYXJkd2FyZSBhbmQgcHV0IGluDQo+
PiB0aGUgZW5naW5lZXJpbmcgZWZmb3J0IHRvIGRyaXZlIGl0LCB0YWxraW5nIGFib3V0IFdIQVQg
dG8gcnVuIGluIExTRk1NDQo+PiBpcyB1c2VsZXNzIElNTy4NCj4+DQo+PiBUaGUgZmFjdCB0aGF0
IHRoZXJlIGlzIHN0aWxsIGEgc2luZ2xlIHRlc3QgaW4gZnN0ZXN0cy90ZXN0cy9wZXJmIHNpbmNl
IDIwMTcNCj4+IHNheXMgaXQgYWxsIC0gaXQncyBub3QgYWJvdXQgbGFjayBvZiB0ZXN0cyB0byBy
dW4sIGl0IGlzIGFib3V0IGxhY2sgb2YgcmVzb3VyY2VzDQo+PiBhbmQgdGhpcyBpcyBub3QgdGhl
IHNvcnQgb2YgdGhpbmcgdGhhdCBnZXRzIHJlc29sdmVkIGluIExTRk1NIGRpc2N1c3Npb24gSU1P
Lg0KDQpBbWlyLCBub3Qgc3VyZSB0aGF0IGkgZm9sbG93IHlvdSBoZXJlLCB0aGF0IHNpbmdsZSB0
ZXN0IGlzIGNlcnRhaW5seSBub3QNCmVub3VnaCB0byBtb3RpdmF0ZSBpbnZlc3RtZW50cyBpbiBy
ZXNvdXJjZXMgdG8gcnVuIGl0IDopDQoNCkJ1dCBtYXliZSB5b3UgcmVmZXIgdG8gYXZhaWxhYmxl
IGZzIGJlbmNobWFya2luZyBlbHNld2hlcmU/DQpXaGVyZSB3b3VsZCB5b3UgcG9pbnQgcGVvcGxl
IHRvIGZvciBhZGRpbmcgbmV3IGJlbmNobWFya3M/IG1tdGVzdHM/DQoNCj4+DQo+IA0KPiBXZWxs
IHRoYXQncyBiZWNhdXNlIGdldHRpbmcgY29kZSBpbnRvIGZzdGVzdHMgaXMgbWlzZXJhYmxlLCBz
byB3ZSBqdXN0DQo+IHdvcmtlZCBvbiBmc3BlcmYgb3V0c2lkZSBvZiBmc3Rlc3RzLiBXZSd2ZSBh
ZGRlZCBhIGZhaXIgbnVtYmVyIG9mDQo+IHRlc3RzLCBhIGdvb2QgYml0IG9mIGluZnJhc3RydWN0
dXJlIHRvIGRvIGRpZmZlcmVudCB0aGluZ3MgYW5kIGNvbGxlY3QNCj4gZGlmZmVyZW50IG1ldHJp
Y3MsIGV2ZW4gcnVuIGJwZiBzY3JpcHRzIHRvIGdldCBhZGRpdGlvbmFsIG1ldHJpY3MuDQoNCkpv
c2VmLCBkaWQgeW91IGNvbnNpZGVyIGV4dGVuZGluZyBtbXRlc3RzIGluIHN0ZWFkIG9mIGNyZWF0
aW5nIGZzcGVyZj8NCg0KPiANCj4gSGFyZHdhcmUgaXMgYWx3YXlzIGEgcHJvYmxlbSwgdGhhdCdz
IHdoeSBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGp1c3QNCj4gdXNlIHRoaXMgc3R1ZmYgYXMgQS9C
IHRlc3RpbmcuIE1ha2luZyBpdCBlYXN5IHRvIHJ1biBtZWFucyB3ZSBjYW4gaGF2ZQ0KPiBhIGNv
bnNpc3RlbnQgdG9vbCB0byBydW4gb24gZGlmZmVyZW50IG1hY2hpbmVzIHRoYXQgbWF5IGhhdmUg
ZGlmZmVyZW50DQo+IGNoYXJhY3RlcmlzdGljcy4gSSBjYW4gdmFsaWRhdGUgbXkgZml4IHdvcmtz
IGdvb2Qgb24gbXkgTlZNRSBkcml2ZSwNCj4gYnV0IHRoZW4gSm9oYW5uZXMgY2FuIHJ1biBvbiB0
aGVpciBaTlMgZHJpdmVzIGFuZCBzZWUgaXQgcmVncmVzc2VzLA0KPiBhbmQgdGhlbiB3ZSBoYXZl
IGEgY29uc2lzdGVudCB0ZXN0IHRvIGdvIGJhY2sgYW5kIGZvcnRoIGFuZCB3b3JrIHdpdGgNCj4g
dG8gZ2V0IHRvIGEgZml4LiAgVGhhbmtzLA0KPiANCg0KWWVhaCwgSSB0b28gZmluZCBmc3BlcmYg
cmVhbGx5IHVzZWZ1bCBmb3IgQS9CIHRlc3RpbmcuIEl0IGlzIGFsc28gcmVsYXRpdmVseQ0KZWFz
eSB0byBleHRlbmQgYW5kIGZvY3VzZWQgc29sZWx5IG9uIGZpbGUgc3lzdGVtIHBlcmZvcm1hbmNl
Lg0KDQo=

