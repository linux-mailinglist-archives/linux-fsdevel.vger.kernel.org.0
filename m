Return-Path: <linux-fsdevel+bounces-47493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E5A9EA6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EC7189BE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1125DD1D;
	Mon, 28 Apr 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QWZNYZMe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ybkry2pF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E019CC02;
	Mon, 28 Apr 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828034; cv=fail; b=Vfdi0zgTC1t/HgUV3PDvfw4g7G3T9IbtVElA76DjQ2iKjnnn4tApsk3ttAqEQk5rL0ui/CPW5mjp0tUzuesD0EqwxZwdo2Ps2eiXj436myGlfb10wtk31Jus2wH11Up1HUuTlhE+VUwmeDuxdALpcKFe1jWnvFlgKkzx1jBHp9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828034; c=relaxed/simple;
	bh=BX8KUK57GRpDpO4aBs/S6kTt7injAiBM0zkGMQDlTKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaR46QGbUbxSu+PGdKVsXznyndNGPifkmsXtMez8tdAq6lZ04lojDK/yNTzduylz1mEbDJqLuML4doS6ElP+1hNvI71qqyWW8ktKkoL3S96NJsZqNt5QC8sWEpPX7MzFZkgtkB7PDZjsgth551iiv0Qys5LsVZcD3y8T+VDvoAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QWZNYZMe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ybkry2pF; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745828032; x=1777364032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BX8KUK57GRpDpO4aBs/S6kTt7injAiBM0zkGMQDlTKE=;
  b=QWZNYZMepV5/KFVY0pOZbhG3kV/bAMGNH15aCw5YgIoDmDH0Mb7sVpcj
   oryT6QaTKPhOo43rsL5e2WvGiEhFuwN4GUPTR+gpxZC9Tc70th0HLmd2Y
   IwDh/Pr8mY6XM48Fd4Qzgdszu4YhvNzjqFuGCdfkJdJsH+hVIfWMkJsmK
   oEP6O1OKeGzxEcecUnHBej7VPf7oBkFrApD6e7MDXTmHAUmlsYwmHereo
   3KqXfZQUJeTXx8YON20cnruPtKNo2QdH0vVOwsoDwvuyBo0PnStytIsMR
   Fm04M5ZHAZNfAalCe8kqQentuovoQHr4zBRiqe0xGwxsTyaPA7xl3v+PK
   w==;
X-CSE-ConnectionGUID: GyG5ROxYSdyV2AtQ9w4KhQ==
X-CSE-MsgGUID: 1rEiUhG9ROONVzQeArvtvQ==
X-IronPort-AV: E=Sophos;i="6.15,245,1739808000"; 
   d="scan'208";a="82625075"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 16:13:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EflGW405nEaxAG57lj2Xl+C9mR6SB4jwILK6cB1CbnCHSfg21OKVO+QPc4EtTKJgXRHXc/0Q53aEyEgsnv3fy5L0dAEWXgRGzsd0RhaG8CC7kPwG9bEwa6PQB4/TNi5kPRDZEG6TAPnL8XeRcsb4xJI9wsCd548WvGBKds61J58e2ocZIPbO/PvXnYGHrTBvqRae5Hz44Etzl18gaXvBYCaDrB2Wrij0tTpwLasbVFeVBh/nAv9NkNRseVxMmOerfNE+YtgvAPskxz543e2TuAByPhuYPs2NJ0OleNQT1k8c3tLk5KTdtuswiTBmuMw8bTpPZlQ2ax/SRLShOlsaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfKu2fVtxQy14EZpTl34Ep/v5Qxtki06llhlpg/25eY=;
 b=N1z0yrreyAuBMCTdBO2it35DCNuz/BfZOThoCy2lMRkTcRmEqKEEcPByzt+PtQU4Ae+o8P1bgIuU9VWD8G8yUZ5MikR53y3k7I18TBMBXINE6s+aAygrwgT1os4+xfGRYAq8MkqBu9Qsip2yLQaKQsew1KwrKBl14DFxTD0RKx2rwcxnX7a/vg5ItD4Qu04Js8LfxuRx4w4vAgtl1FRXaMI+Sdf5XU75/X6TPljm8Q3A61EJL/vL0R+SOu0i/uv9z2Bq60Ye5rvSsUZuCeZzpcFkYW974YM8ewEwFXZVztK+IWBXhVErmWCBmqOhma2c8qwb3muBbx9M6FnB4awtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfKu2fVtxQy14EZpTl34Ep/v5Qxtki06llhlpg/25eY=;
 b=ybkry2pFqjX/jeaigTDHv4x1ihswrcshLldUvvbXahOA899TLI7AoTnXOyk5WX9RmbVtPA0T3wDb3cxUCFWD+nDPsW2s31ubZn2pkCbVhUyhqsZ2Jcn811m9Ke9nB3fNScszGbOMxHWW4pehHDcNz9I/8iKM5arDEA1sCtQAKME=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB8031.namprd04.prod.outlook.com (2603:10b6:408:15a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 08:13:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:13:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, hch
	<hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"bmarzins@redhat.com" <bmarzins@redhat.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
Thread-Topic: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
Thread-Index: AQHbl9iSuzW1B+y3X0qB2g4C3g3UvLORqIwAgCcUv4CAAD3pAA==
Date: Mon, 28 Apr 2025 08:13:41 +0000
Message-ID: <6p2dh577oiqe7lfaexv4fzct4aqhc56lxrz2ecwwctvbuxrjx3@oual7hmxfiqc>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
 <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
 <7b0319ac-cad4-4285-800c-b1e18ee4d92b@huaweicloud.com>
In-Reply-To: <7b0319ac-cad4-4285-800c-b1e18ee4d92b@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB8031:EE_
x-ms-office365-filtering-correlation-id: fd50e60c-09d5-4c05-cdab-08dd862c968b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aVZPOCq0+YOfBGQp8Xped2HSyjz6L0/2YiCJR77A895YkhNBFL09ueci6viR?=
 =?us-ascii?Q?tMT3XJYP13l3QlZlAFphynBuPDuAzA0nGdAT3ig7Yzkf+TFSwz7PD4tXrOO4?=
 =?us-ascii?Q?8dA3a8z+pGZMeM8IYnGOltfZp1oYZOXdQi7Wz/BWKGL7Tus7VqJWPzuQSm4P?=
 =?us-ascii?Q?LThBMrfW+1jNjAX75B5uZ9rhyCcKCRW1SRohxti+Atelhuol3ubZTZldUltB?=
 =?us-ascii?Q?8g1lY6gj4XhuCCwKojFXggqCNX0TkRZMn6XOBNYG1dtBUJ6vtI5hEEatuzMs?=
 =?us-ascii?Q?tHcvKXCD8XrhAH6d19EbMXXmnusVywqx3O6E+6x9xlaxsaSVyGdhw6p5822f?=
 =?us-ascii?Q?MQAOB40y6N6h+jZFSvxQgkg/rsi2G8GgqSRbiKbBjatf6QZvZ6Eo205tXf+A?=
 =?us-ascii?Q?/fPM6aMMcLFDF2olRk+ZKG47c7gafY7UHZXDHMIOPEJIjpq8auKPFY+zvI6e?=
 =?us-ascii?Q?tDbpqEO4Kcnzl5RUSU6g6N09GfYIm0rpaiDTXgOpTbMAHm8TNjakq2PuBpjp?=
 =?us-ascii?Q?IrkrAym8p+K7TiXqQWvpak4sinDXlUEORSNLeQXh8unLfp4eDQ4WdJHMot4d?=
 =?us-ascii?Q?IXnj83I1aB73m9LWrV0szcVSuo/tuGkuUbkoLBMhtmDamuhDA6exDZLp58Eh?=
 =?us-ascii?Q?u9z5O206pKWyH1U8lgvJfTgdj6m6iEwW/uQHGkJV8HcO6rKP9z825QNiFwf0?=
 =?us-ascii?Q?TJGNdXznAP86eTOiy9VrtUvxQCJdHAmBjoS22pFuW8G8/ahUdcK+Csq5ZYMf?=
 =?us-ascii?Q?5MppR7Eld+MG2ikqdQCOJkQMNQOmfekqh+3Frn2DUL7Avk3+rlLCixVUZu66?=
 =?us-ascii?Q?XI6YCHIKlWsiLrwFAXlEehLiFNj5j/c2mRtsNrL698vTsfuhQCKQ8T4l+hns?=
 =?us-ascii?Q?WrNb8RamV39E3l1BvwyOqTvrUD9KjH2ZXz5gDMqrn07d7VOYxQ+lcYj54VD2?=
 =?us-ascii?Q?hZtcKLqhtQw+ggFZmuwHUll/s4WbOk0MBVqvXcLnforagBAY40DRq3S1fwZo?=
 =?us-ascii?Q?ywqw2lTVIoL5fUr6YOEYINPLKtbpkm0esQr+A9M3wxyCGLxPodUpftxzWZ0x?=
 =?us-ascii?Q?XcQiEWJHZsOALfi4hWekKUV4K3gSup/Jiw4/+8pwHw3PR8OE4W1q6rfJVBwI?=
 =?us-ascii?Q?x1pAu9zeI6/swY/Kkx6ya3qQs1xV3+0kFin/eJlYQi40gCbA9ZLJmsvOadgk?=
 =?us-ascii?Q?qSNnE49AMNpvI3ulIC2piId4ZFCk23JMU9DXvvSgp5F2GcAy72cP/tSY3JQ1?=
 =?us-ascii?Q?owLsh+ZLiO+YOykEJ/+WPyYIXAXUGLYnBeSyuVv/TXhyls5Zzwz81bV5m1ln?=
 =?us-ascii?Q?vkoqUk9MKrPl97VVetqF8ITD9Ot9GwJZoYLTr5xNwcEs1BFnTWGOv7pEnldG?=
 =?us-ascii?Q?DUQ/dDMOufvluPLGfD14wpvfRXgfyCjIpkcVs+ajhK8utdpbTWm9imQWJall?=
 =?us-ascii?Q?KjJtm+eh2rRoYZ2XfMvhPS7HxuDGECGus5IWxHDz0RDIdLtrETM16Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?boIfkJEDjOY1mJ1ZHkeHQS358D7gFe/FaKRn/LtgGmRy9b3ulvIf2wkfbjZ8?=
 =?us-ascii?Q?o7bNRIkuUtKZBm/C3YXYVt8RHzW1WJzBdKwvedlOOumpvJC5AA/o2VJewHox?=
 =?us-ascii?Q?PAPoSqTwKQ0nl9XTFHnbnXFPOivI5L2h9MANBdQGZEklyce3+uvkNHfrZZSH?=
 =?us-ascii?Q?W1fnNw3yxsXd41hCdU9XWJlDU/wQcK614F0kJ0QR4a9+nUH0P3Zz+7ws+lBk?=
 =?us-ascii?Q?JM6F4VyzYB7cNspSIpFYeSVtYpzmjJec61GbcTE3Pgrb7S18BCZVJQtSI/hT?=
 =?us-ascii?Q?gOr1lT/HNNO7TdDP/ktp25us6ASwlxgBB8PYv/GK5hZ3dw4WabB6RAoRm+N0?=
 =?us-ascii?Q?L2vS3GiEnzZ/+w+z1yv2u/hegzmipLBi4AIKJLmImk35kABTuemCmKinjKPl?=
 =?us-ascii?Q?d6+NVK4xGuP4GbwMJcvlScx2EKnq7LHmYNick3+HNxb6aSSkvdoyoys4CBoO?=
 =?us-ascii?Q?FSHJ2Ncq16GyEC0N8kdRsmjhe1w4Sgi+K84BELXiGtSkpdDUIxzzhUwSo7j9?=
 =?us-ascii?Q?irrZVDuWSjLmGHE/wDcfgslpceVSftaA3CrqXlnhLFsSp3x3yGtST2A5jfo8?=
 =?us-ascii?Q?AhmZK2D7NaWc75JP5xOu1i/zKNtLYRnAJAGCphDXpTqIaYes4c4OMVyzTRWA?=
 =?us-ascii?Q?CkFUTCxIu/fSDy3tvUIxf22bOW2J3oN+OFhDS7ypsuvv3vuwOJ+bQ2R7OTzt?=
 =?us-ascii?Q?HwxFhMiMPEyH07SrPbKyec4GoFxDJ5oEQ/1w2JuSpjUKJLwXkYa1YyRqbynS?=
 =?us-ascii?Q?8Zeovmi2RtCildnx/v7BrHYuKdf2KvtsFgWbl1iiOTAu/HejF3Aj4RLn6F6n?=
 =?us-ascii?Q?47O21BXA5Vp6aqKr3pctq5WJKV+hTQBB25mP7yYsr+hf4nRDIkO9iT06hBn1?=
 =?us-ascii?Q?Lt0HyHwJBSPcM1CBfIcgmK5wLt0AAw1PffMA3K2TUUF2CPIif6SAx4Lu67Lz?=
 =?us-ascii?Q?54hiFLyas1wQAu1Q443GQ8fTaS0K/b7LWzup75+CamUX0VXFF7iAnkoySV7r?=
 =?us-ascii?Q?vHXVdxBc+ATnnpI5qitnVQGsGopKZurGOOYv5Us8Kuqt9GeMC0Uhh9xTUdzn?=
 =?us-ascii?Q?LBaRdmWQhADzmWAQT2cAWlw1GlZuZWw7Ov6fGiMuANMnE1XQ2cgk2LOvPRd/?=
 =?us-ascii?Q?UR1qCrM5xTfG50CcMFesDK5K0yo6xoYLl2VLboRpXxyO899javFMeJezEbc+?=
 =?us-ascii?Q?M9kF2KFS2F+je/GU0O5D8XjJtF6SSZFeFMacpYEYusDS4Ne/F43RiEVgDNf9?=
 =?us-ascii?Q?PBNwNHI/E+IjbULB2iCvcbZmsGFaZCUcd9FhZqof9TuusHlx7DPzDc9z3tSF?=
 =?us-ascii?Q?BcoOpS/xuzrZBdNrLXCE0sGhOyjqpkHVLPpe+p703ThrIgmAH0roGYHGeyd/?=
 =?us-ascii?Q?JzUn9cnypVM984bCp2SH+QbXVgFSDf/2C7+8EX/yjOJRcHtHShk6pWfsEP8g?=
 =?us-ascii?Q?TCyotrRo+aWerApIJUSLpnIpQxOE4RzftxNdTNrzP7v2Uzp6p3zXFnyE2xPP?=
 =?us-ascii?Q?ffK9vwhzRdhCwj1Sp7Vn5sF9T7tmHj6wxnK7PUuOj4WWoZSwfsapI238XRIJ?=
 =?us-ascii?Q?wYQ4opu7lqKEGhInoV5BXEyLjKB0O/CnK16E62JaghVq7eycuH/TrcJVsYla?=
 =?us-ascii?Q?rdGLCKXdbeN6HnhtD6X5x2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76954AC95BF2414FA1FB4ADF099E6AA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zpGiZAfrpHcPamDeyhXHXuV0EGcHJSdIEYIurnXR0140soWuV9DM9Fuct0LIyJptGooNKJPNI2yJy3c/nNPipCARrZrCxsdBaamO+Hfx/Tm1XkxdFySpwpLp0aAzTBrc4D741vok1SG7wJ6thm33Rr5w5uWroSJmlm+QufILAJfrxnlTtzLLbEFsNDvlSKZK2bnwy3WXfTg83OGbDNbUg0GORBNzgV4B8mnMMc1+F6KuWoVAQOazibAZvaHpxt+E6kZutSUBp0de13clYPt5mEIkDVMckyepPoHIwin1fKC4+Jsld7AXC6c770jHLTCydEu2uA5cUfJuY1PKohMzTVFICRk1kTVnbYqPzRt+XkiaqRmq/o3ujeEt1uWdxlPjagkjU0aQX8RbbiGkbnaIG0q8U4h3dbY7Ws+O9sbBnAO0wXWDEMEq/MtzJHvsRyvB1I6jkiBVFZtS/Yo82pPax3fwpqbBBaJBoDn1MrQ1XHp1Y16sZ06zdLXXIgTcjsXecVE4ah6Meq3sUVTEbz01+m4v+Lu4wO4MfMmklPlXR3QUzfdb+eHqWe0dF7UJKiP17qpgFs5rLWK3MHcAI5NQR72y2mYVlOXSNClGRL3nt6FQTEqc6rk1RnO6E1tH/YXl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd50e60c-09d5-4c05-cdab-08dd862c968b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:13:41.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jqmo9httSuQSLL64tGfJjzIKcT0JKNOmnc5+NM2FOsalpRKlgP3L4Ux9B9mCzm9GN/sYfudXP+bdbtVjFmn4mutZEQHvIRE7WjuAD4Jzch4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8031

On Apr 28, 2025 / 12:32, Zhang Yi wrote:
> On 2025/4/3 15:43, Shinichiro Kawasaki wrote:
[...]
> >> +
> >> +setup_test_device() {
> >> +	if ! _configure_scsi_debug "$@"; then
> >> +		return 1
> >> +	fi
> >=20
> > In same manner as the 1st patch, I suggest to check /queue/write_zeroes=
_unmap
> > here.
> >=20
> > 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unma=
p ]]; then
> > 		_exit_scsi_debug
> > 		SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs in=
terface")
> > 		return 1
> > 	fi
> >=20
> > The caller will need to check setup_test_device() return value.
>=20
> Sure.
>=20
> >=20
> >> +
> >> +	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
> >> +	local blk_sz=3D"$(blockdev --getsz "$dev")"
> >> +	dmsetup create test --table "0 $blk_sz linear $dev 0"
> >=20
> > I suggest to call _real_dev() here, and echo back the device name.
> >=20
> > 	dpath=3D$(_real_dev /dev/mapper/test)
> > 	echo ${dpath##*/}
> >=20
> > The bash parameter expansion ${xxx##*/} works in same manner as the bas=
ename
> > command. The caller can receive the device name in a local variable. Th=
is will
> > avoid a bit of code duplication, and allow to avoid _short_dev().
> >=20
>=20
> I'm afraid this approach will not work since we may set the
> SKIP_REASONS parameter. We cannot pass the device name in this
> manner as it will overlook the SKIP_REASONS setting when the caller
> invokes $(setup_test_device xxx), this function runs in a subshell.

Ah, that's right. SKIP_REASONS modification in subshell won't work.

>=20
> If you don't like _short_dev(), I think we can pass dname through a
> global variable, something like below:
>=20
> setup_test_device() {
> 	...
> 	dpath=3D$(_real_dev /dev/mapper/test)
> 	dname=3D${dpath##*/}
> }
>=20
> if ! setup_test_device lbprz=3D0; then
> 	return 1
> fi
> umap=3D"$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"
>=20
> What do you think?

I think global variable is a bit dirty. So my suggestion is to still echo b=
ack
the short device name from the helper, and set the SKIP_REASONS after calli=
ng
the helper, as follows:

diff --git a/tests/dm/003 b/tests/dm/003
index 1013eb5..e00fa99 100755
--- a/tests/dm/003
+++ b/tests/dm/003
@@ -20,13 +20,23 @@ device_requries() {
 }
=20
 setup_test_device() {
+	local dev blk_sz dpath
+
 	if ! _configure_scsi_debug "$@"; then
 		return 1
 	fi
=20
-	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
-	local blk_sz=3D"$(blockdev --getsz "$dev")"
+        if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_=
unmap ]]; then
+		_exit_scsi_debug
+                return 1
+        fi
+
+	dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
+	blk_sz=3D"$(blockdev --getsz "$dev")"
 	dmsetup create test --table "0 $blk_sz linear $dev 0"
+
+	dpath=3D$(_real_dev /dev/mapper/test)
+	echo ${dpath##*/}
 }
=20
 cleanup_test_device() {
@@ -38,17 +48,21 @@ test() {
 	echo "Running ${TEST_NAME}"
=20
 	# disable WRITE SAME with unmap
-	setup_test_device lbprz=3D0
-	umap=3D"$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zero=
es_unmap")"
+	local dname
+	if ! dname=3D$(setup_test_device lbprz=3D0); then
+		SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs inter=
face")
+		return 1
+	fi
+	umap=3D"$(cat "/sys/block/${dname}/queue/zoned")"
 	if [[ $umap -ne 0 ]]; then
 		echo "Test disable WRITE SAME with unmap failed."
 	fi
 	cleanup_test_device

