Return-Path: <linux-fsdevel+bounces-47582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA9AA0979
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460BD843158
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA92C17B2;
	Tue, 29 Apr 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VR98qKxl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MPviAoUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9F2BF3F7;
	Tue, 29 Apr 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925911; cv=fail; b=ZA2Mnp1PBBLTMtH+ibNQY6NyF50k7BWURdyImVZcSUo3eAYGpPGtc5icUmUZp4RdtttNgPD8jndE8gV+iXJfgIZpAh61JJr8AP0POHju6/R8GtH/5LQKuInh1eoAcVysXzOxBcNn698By4FF8U2YVn3N5k+1UkZuhjhCQ37T7GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925911; c=relaxed/simple;
	bh=GJhHBiayHPUHFw8eYzw5q14gJEq4E9pL8klmUZRVKG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWiJm70A1yyhuLQTK2PhOmosw5gxrUVlCP9eXe0DTaYYxPnqUUj+q+cdvVw4WhKcTzNlq2pG/IbM77qJJtP+wfefKLdlVRR/oiwuLiz1jZsDYoCXXR7MACrGx26oJe//kem+3jzUymd4FNnP80KeIWzQiuJiodSaU4OWXScL1Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VR98qKxl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MPviAoUh; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745925909; x=1777461909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GJhHBiayHPUHFw8eYzw5q14gJEq4E9pL8klmUZRVKG0=;
  b=VR98qKxllUUvR4SXbYe2yo6nC2JYEzYaogWaUkvYtCJXfVlXLLZFsFis
   sxlTzOs55kQkRSLoDwJ0sjkYqHGqs4zsUAhei5z7i2WCdrix6+8R/XRaj
   OOROyAoLX99UneSsmR1yOW2MVUqLHglZitkXSXTnE1IGms94U9PzghhA+
   h74qXwMxg9/WQlM1u3yD3MBWy+7pF3Y9J+CIP4HOJnkHE8whxjTfAKZ2D
   NT/Jg3K+0m3dBoZjrTLHMOMrXUE5EjegEys2EAlDWi0rbRje8dUBL5UiA
   5bZYSokkx5otiC+IxFn+JX+WVipP+hDiy7M6mwFQnb1cned8L/IZpybIs
   Q==;
X-CSE-ConnectionGUID: LnvANG6TR5ihmp5hvMLQ5A==
X-CSE-MsgGUID: VUVJfnclSomOgSavgbPjxQ==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="79722367"
Received: from mail-centralusazlp17011029.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.29])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:24:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGzKssEBAKG9MbAvVtDg50bc+eXQ/INadcaZF22fHKbog0GQo33i/HPEK81TyTF8y9KWXvnvl206WYCLDq89yYsXLvXzoAvccmZUbhSwKgL4HMhBjpEu5/Z9hAJXz2VamWaaT0b+H4s16nkc/Rtp+1733Tpn7QCjxEzUmBEf1mVkjXTP6eVEz0NU9XheBEqvYwRYbj8oCl+FlqDvD9a11so7JyAtrb1KxdQQJ5OWehcM4fiA/oeqSG8KosxSF/Q3K1C6wi+DnsUqW+VGPYH8p+LoAYJ3ykWAH8Zrwg/5Pvkbu3IHOcq71r5GkJAwmQl2TwKHTLUPrSsMCKY4puvxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJhHBiayHPUHFw8eYzw5q14gJEq4E9pL8klmUZRVKG0=;
 b=lC+bzUFAaNasXbC8ear1a3p6KlZuhNPBJmKRJLOIa14SxZErXW6oTgnx91teerk+XtG0q46975UXRktWxipCko1LcPeNm/ZG5rq8kthEGw+OHBMZWmYLGzplAl+CjOKSHn1m4OFqdjIJRI7WvwcDBlNP3bAx76W7dLlJ8QK8fznJVEUtSBg/AJbY+zvSeByFwVZxXijrLZCw5xO2+4C0wvXRyKrJIu4wiRnuuGrqs9STxJl853K3mbjFwmhWq7RFAk8ZJYze2P7PRwXwpbcZNBRZWRBY/zf8wvGfQRryDQiiGK6nlbuybEms3F7/Cxn43Y6xGUfHFY/5voHcPU14zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJhHBiayHPUHFw8eYzw5q14gJEq4E9pL8klmUZRVKG0=;
 b=MPviAoUh5r5no1tZ+nF0nb0RYKe/yXLyIBw/7voUka9Di7P3ieDQ0wUSg0nTmZclvP6Lk/XeGq80ymiK0ZJuGAQeU03H81CmfLsjjDFK8225RVmKLUO0QWqzTi8ngHzZL/1nJ7SbdTdSAvKhUyDXyvTQUwZWwJn4UH70byEnmEg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7743.namprd04.prod.outlook.com (2603:10b6:a03:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 11:24:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:24:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/17] block: remove the q argument from blk_rq_map_kern
Thread-Topic: [PATCH 04/17] block: remove the q argument from blk_rq_map_kern
Thread-Index: AQHbs5LcHYAyy0zn5Eut9locDmnW6rOwxawAgAnF1wA=
Date: Tue, 29 Apr 2025 11:24:55 +0000
Message-ID: <df1fa243-a824-4607-8393-90dedecbe772@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-5-hch@lst.de>
 <76ba8f63-b5d3-4e43-beb4-97dae085c5f2@suse.de>
In-Reply-To: <76ba8f63-b5d3-4e43-beb4-97dae085c5f2@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7743:EE_
x-ms-office365-filtering-correlation-id: f55c7fd3-08a2-4f01-5193-08dd871077e6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjF0S1lyczNKQm9JRzZWYXh4UW5OUFU1RFgyVmdIS0Z6dVQxZmd5MWZETE5X?=
 =?utf-8?B?UnNiUGRuVXFXeFMvMlF3OC9hY2p0L1BzRzhoZVF5Q250RTN3WVR3ZkVZYzJj?=
 =?utf-8?B?WkdhUXorcGZCQmNMd0xneCtCZ0tYcDFqR1NWbENVbGkzaEM0NWV6WXdKQkY2?=
 =?utf-8?B?ZHdBcERpUEdLMWF2TFNZQ0I0d3VBK2RuWDlNYjhpc3Y1WjF5Ylo3ZU1hTE5H?=
 =?utf-8?B?cTU0b0lnZ1hIUWxTdmVCRGlNWWJoUjMzK3NZOGdQRHI1UVZCNlFQeTdaR0xm?=
 =?utf-8?B?Sm5XZFE5UVY1VjhNTlNPQnZWc2wwL1RjR3J5MVlqcGdMM3VLcm5GRWNESkdQ?=
 =?utf-8?B?NXNXaTNUck1FMEpyZXdFaVZuQXkzenNSSFVlUiszYTk0MkEwOSs4T2t4aDNG?=
 =?utf-8?B?dVJ0M0xDMlNmcGxtamJ0U2pzeElsN2RockgrRFhPb2JaUDV2MFcvYzlZeDZT?=
 =?utf-8?B?b0tWancxMmNSOENxQW53MWtwNWFmSEhSWDYrT3lVRWVlSkpKdlBhWnZoSjJt?=
 =?utf-8?B?cHcyWjFINmxLSnVoNnZxSEw2YU9LV0dFQWNwY3lSWm1PdjQ3TjY0OHhkQkha?=
 =?utf-8?B?WW1GaXVUeSt1ZmlzRCtqOWtpb2ptaGZLbVZZTlpoa3hMaWtkdHZySE0xRWlG?=
 =?utf-8?B?WEQrVjFkQXBrbWJRdGljSFZtR0xoMlE1dGVHY0lxN25meVNnNHdxWXRrWWIy?=
 =?utf-8?B?R2M2V1pBS1l1cG1IQVhMYlNMQWFUbnBRMmw1Sjg1OUpxKzJYSDdCN0F6Wk5I?=
 =?utf-8?B?a1p6cC9NTVFoZThMZmdnU2xndUdyaU5mcVg0SEpNT1FQUTNFS2xnUVQydWFJ?=
 =?utf-8?B?THhUTU1pREVaclROT014VER5bW9kS01IRjdCZ3o4bjNHSjlsb2V2d2JCbDJ3?=
 =?utf-8?B?czlpVkhIczNjNnVIcFI3b05sd3lqWjBIZXJZOXNYUVV5OEduRlJFc1docllB?=
 =?utf-8?B?djg2YlMrNUk5RlQvRHVkd0NhamRLckUxN2NQSGxxRTlHTk50VXVjOWJ6aEs5?=
 =?utf-8?B?K3pBZkJBc2xkcU4wL2RuRkhhUEZ1ekNqUVBUNWVNQjBvMmFjMDE1clBFSGox?=
 =?utf-8?B?bGtyNXhvNEFsVEVRWTFQcFhzeFdxbkg0STR4blUxdEJNR05xUkNGZXlxUktx?=
 =?utf-8?B?ZHRaOFNDQ2xLbllIZTB3ckgxSFVjVEVSUWxzQ0pZd21sajBrc3dENE10WmIr?=
 =?utf-8?B?bWVNUGlGcThsYnNQM1FUd1VtNmMwNmNWMFRFbzBJVm90bHQ0cTk5TS81cDgr?=
 =?utf-8?B?S3A3VTFpenI0R3o3WWxZQ3h3TWU5TkF1RVVaQkIrakhEMi9YY1BkWkliU3Jx?=
 =?utf-8?B?NTRFMjhiY0FaZTFQZllzOVlFOStjeHRRQk1uNjIwTWR6NmYwL3c4WTRmY0pM?=
 =?utf-8?B?N3lzNVVwQi9xSUI2dnd5VWIvTDBJZ2VmMHBETW1UZGlqditJcDk5bTAxNkdM?=
 =?utf-8?B?QUZRN1A5RlVZOGU3ZmtlVkNNZ1ZjMzdUZUJBQVBGTng4SnBJcHdkYUVQODh1?=
 =?utf-8?B?THM5VERJRHVyODlUdC9qQ015NWJSanN0bjhadFY2d0VVN1RBay9iTDBWYllm?=
 =?utf-8?B?QzJ3N1RNQXdMOG0wSy9RdFlZcmliTGQwV242QzVpbEJCb2dmUmxXNDVqc2VT?=
 =?utf-8?B?SmNFOUVFZzhBcEthOFZvazZaaXFLRU1lZGpEWkd1RW5ZaEVhWFZzdG1uRmlD?=
 =?utf-8?B?bFdjbDVNK0c1eHdHcXpZeUJvOGhBWnRMVGg4VG5zZFNHUVlsTkxLK2ZWWWgy?=
 =?utf-8?B?WGJGUlBNNjFPUDlBSzBVWFJSYi9BQ0krTnpoOWdiQjNBOWpUbSswUEQxQ0Jt?=
 =?utf-8?B?ay9kTEdBUzlMU2s5VTU3eVNFTVJtQ0xmK1ZQWmMxNWkyVldsM2ovLzdoY1J5?=
 =?utf-8?B?QTVhMXFuM1Y5d0xydytVNGJuT0N3R0FaNUdwWDBDZmZXL3BUbFRYR2EzdFda?=
 =?utf-8?B?WnNNREVKbWdYU0hqVmxvZHJpbVJZRmNadTA2U2lUeXIyV0FGV29MZHZ6dk5r?=
 =?utf-8?B?M09TWXEyTDJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjlWdkI3ZHhGaUZ6SWNZMndlblFkNlpxVXF2eFZQV01MRFNwMHZYQm9LVzFi?=
 =?utf-8?B?eERkTFhUUnAxT1piYmlEZGJpeWdPY3NTdHNyR1liTndTK3R5QkNLU3k1azhG?=
 =?utf-8?B?V2orYWxGQmVYQnpoU2RKeHNTWFphSm9CWDN2SmZvT1EzMFhsQk8wYlZXeHkr?=
 =?utf-8?B?OHFJVkZLWVUwOC9qdFY4eThWQk9UWlZZNzMybEt0czE4VU1uVFZudzR4UFda?=
 =?utf-8?B?ZWd1TEtjRlZjTjR6M1BDeVZIT0RXUzZ1L1BLbUNSR2RDQlVES1R5UFJLc05O?=
 =?utf-8?B?VW1iMGd5enUvMkZHMTdXMGNlS3h6TWNjOFIvUHpxcjVNL0RjSTFVSS95cmtX?=
 =?utf-8?B?TEJERkxCRnEvRjM2Mzh5a0YyUkk5R2JrbUhOQVJwK2FYRG42WEc1NU1va09G?=
 =?utf-8?B?NDRiMHQ1RTg1MU5HSVk2RCtHNzZCbW91NkFLSCtVVDZXM2hITlhTRGJUbzdv?=
 =?utf-8?B?VmZCbFlqczlYSXlKSVlsaEZOb25aWk1FSHpybkhLV1MvL1JOS1RjOHJOSkRj?=
 =?utf-8?B?RDBrcFJHQnpnQUpuMkg3QmErWWJiaWtMdUs1RXBleURVT2RjSDdvYnlQWERo?=
 =?utf-8?B?ZzZXaER1bllPd2NXRGp0amNnVXc5WTFRT1ZmVlIxMWZpWlFsYTJPWnp1OStt?=
 =?utf-8?B?aVRpRCtENXFVWEpldWZSdXBhNlUxWlZHZ1Y3Skh3N0tjdk8vWTJmb3QrcFNL?=
 =?utf-8?B?ellYNnZCUDd4NkxaaFh5MHoyTisyYXJKVlRYVkZCbWJxSVdRL3FwQzdLMHJX?=
 =?utf-8?B?ZDNuSlgvZjlHSktycms5S3ZZeWtmWjJRZVVOMEplTHJUQTd2NlZ4RVp4VllQ?=
 =?utf-8?B?NWJVdmxlM2pDRTNwZnVJd0wwYUxsTUQvdDcyMzExOXgrVXl5b2dCTnc0M29T?=
 =?utf-8?B?aUxlRkR2R3U0cnl1Q0NmVkhkcTlCa01BVjB2YVhUOXd2YzgwOXJBZnJSZFMr?=
 =?utf-8?B?WWdIaGduYzY4VVhTeUdqS2JDNkh3Ung4TDRIV0tjMFQ0ZUJsRDlvK2NoTGZI?=
 =?utf-8?B?OU8yL0R1dm00R2VGc0twK1pGdi9uSkdBa253OXZCUjBNNm9aRzBxYnZ6SXZL?=
 =?utf-8?B?UzNManIzWUd1eXprN3dwSUhuMnNxN1J3N3l0ZUozYjZWMG9FNUJUSXNXMjFH?=
 =?utf-8?B?TFNnMGFBSjFlODR4MXMzck92Qm9BZWxCcTBxYndHbWJSbk0yeG42WE1EZFB2?=
 =?utf-8?B?eHpteVJaUGpLT0cyd2wzanVTNlgxYjZxTWhQRlkvMDRHSGIzK3AvMENjYXZI?=
 =?utf-8?B?NTkvVEVEcFVWK1N3UFd5dTJKRzFpblFVQzFsOTc3Kyt4bkdrUjRGNnpqME5i?=
 =?utf-8?B?UjczYTNnbk9XZXE3RElmUW5melBKK25qaHNUZnhHY0h1cktkdStwQlZmUEth?=
 =?utf-8?B?WlU5QUdsb2d6RXVuSWwrcXZDd1RnV3I2K3YrWjQrK0NKYS9WUkZqMHpCZWVh?=
 =?utf-8?B?NlVkVjM0dld4b0laWkUrbzYvd0toUFpIdlo2c2pUa215a1RZcTBTaXlSRXpM?=
 =?utf-8?B?cVZDT0FjRWltalREeHhsblZLYVUzUE9mOXdtdjd0RTUxQjJQZHJnYnV3SlZP?=
 =?utf-8?B?NkNobVpaQmVtZTJ5QlY4aTRKb1NTS252NXRVNHJmVVowSituT0xGT1FJVGVX?=
 =?utf-8?B?bjYxcklaRFJrS3Yycm93OHljSjMrN0haOUhQczJWb1U4UW1JNGVFR0RZSnRF?=
 =?utf-8?B?RGlPZlEyNzR2QkJuVE5vc2c4b0ZkdStPTnF4REZVQURRTUNTUGo5bHJmbHFY?=
 =?utf-8?B?WVRIS1dnay9ycnRteWdaQnkvSzVGM3dHVDNJeW5pR3VJUHdlVlRxR1dLSzhT?=
 =?utf-8?B?SllFTGN5T1VFYXM3WDJCZEhIcmFGRzJDMHRPZE9ob2dUbU4xU002emRuZjFZ?=
 =?utf-8?B?S2tCQUpqWWtVMjJ5S1B1blFISUFNMlZDS0xwUSttaVJ3TGNDaVc5eDZReWhn?=
 =?utf-8?B?Y3N3bUt3MVQ4NFBLTEZTUTkyRGMrWVU2bUd2cjZ5eGJPNXM2dkduQkZLa2tt?=
 =?utf-8?B?bE5JNnJvT2k1ais3MkZ1Q0VHK3Z3ZnBsdWhUd1pvdGFhZ0ZERXdRdHE0eXZK?=
 =?utf-8?B?dEZYKzdQMHFqWC9yNFRrMXMzTkNrL1RsU0x3Sk9ZQ3I5NGUvaW1VUUJMSzF0?=
 =?utf-8?B?UUtrQ3RjN1RkOThCZHI0YUtvNExqTG8xYWlZMzZBMGFWd3Z4S0tIS0VrY01X?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD817D88FE76B244855C2A78F869B06B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C5s9i84bGgNOuqZCthjOyEPtPirKlW+TEawuCsEy9nQunHm74vNMu2OmWz8Wf+oHAeDNNRjppmuZw9uWOWs756E8aCKvNFA5rakeR+CUkpbhPLqUJ5kWSG1qxM4dbSe6sBiLadbzT8/iHBYcAMuNd7R2lbfXu55NF/YGP7sU5vBzoisv2zvRRKzkAmc+F4R7jBgr+n4ziuJV3O5ph/Hs/b1hY8xbpI9qGu/c+8jfMbkK8R67B9+d+3c+a/jmda9QcDz9JecF4Ftj5RQumdo6laB2LAQNTJbvn0Zt5JLF3aUEFz71e/WkPUEYsD6vaVSmMIoSAr8qnbTd7jQ7iSNPJF7CULsyY2eqIlE8jAPc3UjL240fhWCTpdYTFhfAwgEvgDlLnePwhk+XCZlXEFol/OsrdpfO6MZ9ztAB2Mkjr+DQy1xBidxYlto33SHZSjOXej0gLM0lSUBhSs5DKcEkCFuHafZNF1t/6f0pDYTNevg0678ouCmX/dgSyPtpJ7jzUBE9nlZqg0K+a4DST6hcNBH1A9Lg1YgqF+ffPaZtK96Qpg2J/3AJKP1HGk5DqOCaDJKr0/pZy81LMJKEUJq2gDIChRQ/A3UXj2/H9OBFqUHKAhY87fnCUAgEQOdggCZ4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55c7fd3-08a2-4f01-5193-08dd871077e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:24:55.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Yyl1S7xGk47S3IJavUt+KGuD6e3PBckUfsDZ3+G0xzZ+ErWPzS+RQSLIoNOmaXtOmTckupQdrYBNh961109mvKb38QRTOTHw/pj+nEgNfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7743

T24gMjMuMDQuMjUgMDg6MTAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gT24gNC8yMi8yNSAx
NjoyNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBSZW1vdmUgdGhlIHEgYXJndW1lbnQg
ZnJvbSBibGtfcnFfbWFwX2tlcm4gYW5kIHRoZSBpbnRlcm5hbCBoZWxwZXJzDQo+PiBjYWxsZWQg
YnkgaXQgYXMgdGhlIHF1ZXVlIGNhbiB0cml2aWFsbHkgYmUgZGVyaXZlZCBmcm9tIHRoZSByZXF1
ZXN0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
Pg0KPj4gLS0tDQo+PiAgICBibG9jay9ibGstbWFwLmMgICAgICAgICAgICB8IDI0ICsrKysrKysr
KystLS0tLS0tLS0tLS0tLQ0KPj4gICAgZHJpdmVycy9ibG9jay9wa3RjZHZkLmMgICAgfCAgMiAr
LQ0KPj4gICAgZHJpdmVycy9ibG9jay91YmxrX2Rydi5jICAgfCAgMyArLS0NCj4+ICAgIGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jIHwgIDQgKystLQ0KPj4gICAgZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jICAgfCAgMiArLQ0KPj4gICAgZHJpdmVycy9zY3NpL3Njc2lfaW9jdGwuYyAgfCAgMiAr
LQ0KPj4gICAgZHJpdmVycy9zY3NpL3Njc2lfbGliLmMgICAgfCAgMyArLS0NCj4+ICAgIGluY2x1
ZGUvbGludXgvYmxrLW1xLmggICAgIHwgIDQgKystLQ0KPj4gICAgOCBmaWxlcyBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkNCj4+DQo+IEdvb2QgY2xlYW51cC4gSSBh
bHdheXMgd29uZGVyZWQgd2h5IHdlIG5lZWQgdG8gaGF2ZSBpdC4NCg0KQmVjYXVzZSB3ZSB1c2Vk
IHRvIGNhbGwgJ2Jpb19hZGRfcGNfcGFnZSgpJyBpbiBlLmcuIGJpb19tYXBfa2VybigpJyANCndo
aWNoIHRvb2sgYSByZXF1ZXN0X3F1ZXVlLiBCdXQgdGhhdCBnb3QgY2hhbmdlZCBpbiA2YWViNGY4
MzY0ODA2IA0KKCJibG9jazogcmVtb3ZlIGJpb19hZGRfcGNfcGFnZSIpIHRvIGEgc2ltcGxlICdi
aW9fYWRkX3BhZ2UoKScuDQoNClNvIG11Y2ggZm9yIHRoZSBhcmNoZW9sb2d5LA0KUmV2aWV3ZWQt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

