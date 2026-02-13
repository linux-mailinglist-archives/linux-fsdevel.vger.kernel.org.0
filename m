Return-Path: <linux-fsdevel+bounces-77134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP4bLB4Kj2ngHQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:25:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC80135B83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6947630ED2F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DA352F93;
	Fri, 13 Feb 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PDfM5u+U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jw8oQPPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5A313554;
	Fri, 13 Feb 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981844; cv=fail; b=uwaLBkFhMrIJjIyPXC4WqF+ef5ayOBM/WkO9vwvNt2+oar8MUjOtf3UkGzBL5jrgj4JkbA+9Mee3c/8YqjiscMr1OSTK76lSxd1/KvSt2JMhQF/lI71Qzncvf3ovXJNZIhr6/uTNwUXSKRVDf88f5DxuQ8TYIUfmDoJzbOt0BlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981844; c=relaxed/simple;
	bh=2L37C/C4et87riNeGxH2M6wlMxKrL6CCFFpyUDodoz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilIHgvQNgnJCgAtqWoA2/oUS4+vCoxaEpdx/b/QflBIoMS8jm33VCO9GvGkoUt3Q9kG/8Lh0FcCMRh6uszet5oq9N5oGNFcMxmUOo/8SyU2M/9CC3HOHqlAdKliXJRY2Bey1ksR4nqBQHlsUut7BG3uhUvuwdacVn9Go+ZJzhQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PDfM5u+U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Jw8oQPPU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770981840; x=1802517840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2L37C/C4et87riNeGxH2M6wlMxKrL6CCFFpyUDodoz0=;
  b=PDfM5u+UWrW8yV9fh79gd+2j2t5tjtCNKBFqlEHvx+TC0PGeK6Zs52Y6
   zTMJzW+60ZKQVXB1DC4+UANpa5pXt33vqy0DrgvfWwZ46e1fJRbeBGOqe
   G6v+oi55jKmJ7UOJ8PqezCRyAV6slxd401ON5p5lKg2+JDwruc3HDG0XL
   aG/FA0YA4zGw3VYFfg6hKFupfVsKTy25wjk+/+KQ7sq8T+D0soSJUXywQ
   QjQwztoSN/Q76Clw0zq7/GOLBEJHRy0mtVCgBECkKN7G2RvSSRBuu+jkq
   QMpbqSfSBeTSLOqwv8laqGI+Hk2Vc9cNWJUdbyA5xoVeWdh83YN4pDV/C
   Q==;
X-CSE-ConnectionGUID: tbA7b9HfS4WSnKTs0Eezfg==
X-CSE-MsgGUID: SCHwFnfAQkyLa4cojnyEFw==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="141832040"
Received: from mail-centralusazon11011030.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.30])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 19:23:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svTL+/0yZCykSOqCv+ekjKkoPeLzS3HmI3T9LokaFrCm9Ce5cZP31RJeZhCxPkUGOwl+CwDhCQtXZzs1QYfmL8l0vHqPMn++xnfNlMj17jqd1B5CDhzeDdTZH4YwpttTezN8mOpOsm+V15bonpzcmpMu3a/n023NowMK9sz/1gb0STa++kU0y5/vj2x2FC7H3lJPWJJJ7AOJhYEuxaWFEXpT2NQZS9G/dmg9lP/flwqU2v+nTCvGlf3tzlbsbRE6rJ2OVZ4HWFDmwjxnUDLa/L4jvFfNEzvCUk9plpdARmchGphxsCEtqzcQB6BjiV+QAxLdOx07QNqKAGreMuG43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM+xBFSs8FX2O4WgnTaDbyw5QyvdJNNWGbyA+zP9veI=;
 b=cfgWQ2nZ4c0nYRkv+XSh7NL6tGnfZIEghWKOZCNkICBAO8i9Zoq/1xyygPahkD//wWR0bfTilot2PvitOF8alARLOjjxn+LgSwqit7lnTB3LBCdql25AjmlVoSg+IGtfe+fZNUVIQcVia1JoGEZCmjzqssKlysRhvWPK0C0U+JnS0fOQKbmLFfYuNYH+33sqhTlXtIxZFEK/4Wb3CBanr9OGymDFVSoQnickh5085TDqXrCtAfHtpo7XUjYJVdOn1F/otmaA9XhW6wfTjajegQq4ohYB7SECo1jGz2YHP5mTSZ0PgwRGGyGqMxwLCKzN3YN0YzW0r3OP4uqDUaps5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM+xBFSs8FX2O4WgnTaDbyw5QyvdJNNWGbyA+zP9veI=;
 b=Jw8oQPPUodhayZIq8fP+PlEim73x3pcvRgawSuabwmKNLbpZtcOPHZg5QlN8onY39eP7k6w1B4IOwVTb4hk9EKCjvi6VWy30regxywIFUvqCtoztkrSCYzgBcnNlArFHnqZUWM+IbSeF05GObryDn47Fl1XVndEhacoq8FzjazQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV3PR04MB9252.namprd04.prod.outlook.com (2603:10b6:408:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 11:23:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 11:23:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu"
	<tytso@mit.edu>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian
 Brauner <brauner@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
	<javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X2GyQlbhzV6UGhlrLvCD3GoLV+sd+AgAHNZ4A=
Date: Fri, 13 Feb 2026 11:23:50 +0000
Message-ID: <aY77ogf5nATlJUg_@shinmob>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
In-Reply-To: <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV3PR04MB9252:EE_
x-ms-office365-filtering-correlation-id: ff874725-6c19-4096-a149-08de6af25d28
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vDthQW8p3DFuTdqeqn0P0jkIb+p8cNh7TbcWwFHxxH8EloNDYenpD8lMFL?=
 =?iso-8859-1?Q?NM2z7R1P4qMmACJqZZxbGTw7KwlFYrKuFlOcl6DBd7owqViJEiJrMzsJr0?=
 =?iso-8859-1?Q?v6Yl58mvatRyHFeW6U4ZMK8/CbGRzOoLaCChQkFsyT0+eWR8OziFK7+n6k?=
 =?iso-8859-1?Q?M8ckz0z+6Gh8mOd8dn6y65A0ybB2mPojekzoAmAH85tNINHywWrI8kt2ra?=
 =?iso-8859-1?Q?T4Xa17afrjehgy7TcNUekO0KT9W4xuLMGCI2xNBrcgUhv8Ja+zqyRm0UYb?=
 =?iso-8859-1?Q?9BDqLwYgWvsmQmxHEGgqvtuJRo/Gc7oDi/gCgOtcsH0ul5OoEnhh2uyEGH?=
 =?iso-8859-1?Q?vCFz9zSAynUHdgGz9pmSgT/eY4Hu/BsOPcPFwxBHYv9j2Np0Seaab+k6G6?=
 =?iso-8859-1?Q?Gyq1cZyrhhf11Hkt4jUy2rfYGzyMbE8divDGsCXuHdKGqDwFoercU55zDr?=
 =?iso-8859-1?Q?lqlrRmcblBUPitdPICrdm4yGS6kPAk6hKeZ+0blcX0QWm18Upig1aTgBhk?=
 =?iso-8859-1?Q?mT9H17//E6AFl1dyi/dFA2WCPUh8PlyPFm63XMbnntDODQP3fTdcA/925Z?=
 =?iso-8859-1?Q?ija2srSrRPnNvH84ElpB3YcgIqR5wHG70aZm0CFITNgwdEI1YfFLrfaPCt?=
 =?iso-8859-1?Q?huKTPpoW90q8oJzPWKFaeu31TQ2ISErpeYXkHxRcBOt7wu3g7dHtPT/UJo?=
 =?iso-8859-1?Q?1/fLY+Ld8xjT+Jw7w9ks1jayHChoYdEo+ODszecwWoXzdob2GcmozTm80J?=
 =?iso-8859-1?Q?5hqoOTTVGpJAs4OXNutRfsUCB9/GMg4+esd91sZMk3ikE26+ut8wo52W/L?=
 =?iso-8859-1?Q?p/BeR8uH2E1FN9mtGSsFooZzU+lpjmmbr56NrpR166S20ZjoiT8J/WKsai?=
 =?iso-8859-1?Q?gzD04XZMZ/Wlf0X41YEhmQkwRMceEQv8IrNQV0rQH5q9t/PneIzR8Y8jts?=
 =?iso-8859-1?Q?JWliM0phdAatCRkXkhFcrIEtdYoyguG4qlByvZNuDUcw+GK2HG4qg+9UFL?=
 =?iso-8859-1?Q?SdVamAJBj2InxfU+I6gSyY69t06pXrVmYr0+uTSxpMRhjvEJ6djUHxm0k6?=
 =?iso-8859-1?Q?rxhWEyf9xzwe3+ob6/HFk4L5m19keLV+1zxRKGN78yO8xYm0/rLovDKuyC?=
 =?iso-8859-1?Q?XCAIOqCDw1+rly56YQl/CxGz4tCxrVu7UxkSNLhBn3nK+NROdwEl2DdDYg?=
 =?iso-8859-1?Q?SfmdUusMfOVmeDhdKT6SK3NhPsed4iLbzgje1LqhwctB99FicDtjockHG7?=
 =?iso-8859-1?Q?rkO0rTiiSM0GrbD8B2UcRtI7hyuq6879b8MHJVsO7dvrR5TWDyeq+LsVdy?=
 =?iso-8859-1?Q?VDMccJ60nHGGpW9mIOEADltgazakD0DyZaXAXBgdCl9e5Qee09UN7N+8qf?=
 =?iso-8859-1?Q?PjhTD8Coymxk5O6XW02kfdFpz6RFNzCDtjq7ILK6NQad0/D4tuuGJqOZ+7?=
 =?iso-8859-1?Q?Uo2o3AwhNio5QAIF9emgWNytVV3s2LNufmcG8KuIoGrZ0zkLUGyyQaoA46?=
 =?iso-8859-1?Q?7Z2WxB5G8Qs0Heh5bmoF0KBR3r4dU/UWAq4gYUD7v9ay6JzUvLWm6Phf67?=
 =?iso-8859-1?Q?RynSNeeIXpwkGtqMMR3HXVmkdcSn0RfK3cHpLocyVLdYdvScLqr3ou3rF/?=
 =?iso-8859-1?Q?a3L995fgvnfyjc6Sx5t5d/nmgl56NQQztlfSG3CSjwfq9jKsRES222gnzY?=
 =?iso-8859-1?Q?y+A0WwwmVUU9vUfPyYc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LFRllyfIeX8M6f7Of/H5+aR+FYXtoZjhlD48A8G+kx97ZP3+PJSu9mz9vu?=
 =?iso-8859-1?Q?Hjh0J8IxaFO61304Db4G7sPTHRDMbwW+QyP0UYkkxAckFaI9CRBAd9q5nc?=
 =?iso-8859-1?Q?FuMYpYCSymDgGw4jw8uOPm8B+c1MNY7BypeiSNHzmAsaUvjoiURv/I5ls3?=
 =?iso-8859-1?Q?t7NKRZGrXEe8wWDY4kCiZqhaRnzcS1oy94a4lkP7ICndHAs2EwM5kfhA/1?=
 =?iso-8859-1?Q?tMl7Txc4V7bs7xSpRcWDa5XRJznZu3Bq7tU9oNvpL7gzc4JwbYIncHLjMb?=
 =?iso-8859-1?Q?zXaE6ZS0+IBsXKZFstfO6kfFi+1oKqZMBJJ+KRjVkE8fryJcJHy3ubQKm/?=
 =?iso-8859-1?Q?WUWxjwBRDue9AiweDaOp2sN5sdBdgODPa8qAiAKiet5Ye/qYC+S2i18DB7?=
 =?iso-8859-1?Q?2iFV2NeCQR09UXYfOANoSY2NH23tJpNlBLPZF9jT3BfbdbW35ATJKKJarN?=
 =?iso-8859-1?Q?JMfGvlF5lyUkijTaioVAM+Gz2u8UAhJXmkE/8Pdj4pad2mjmQXBlM/UVMy?=
 =?iso-8859-1?Q?Vln0CLVtrJuWof439sWV/tQbuDuuRDWBx1vcon2d+Thp2THviDVxDgN6XK?=
 =?iso-8859-1?Q?8STSrG3pi0M712XxLuAIbAN4v6KMfb4eRVLX1WyyAyZi6tpv5YMRgtzkM3?=
 =?iso-8859-1?Q?5lYuAlb+AhGwVSDNAfNvXqnMERVW4+b2rVQ5WU3GiTnAMLAPO+kTqlmvdY?=
 =?iso-8859-1?Q?HiN6+fKE0IaC+PoJ11CQ0D8l/EdQVJG63QqKqqr7qL1trGsH2pOsC/jwhV?=
 =?iso-8859-1?Q?VbUjEKb2h6IBRvnPu6DlsLtYIEd+oH2qZH3PlGfuPnGBuLZ3vLxIIUivHf?=
 =?iso-8859-1?Q?NMJDcluQ8p7eDBSiRedQZAwBg5V9EmDjazqW29SyYM+x70EV6hMweHkkBf?=
 =?iso-8859-1?Q?yPuEP7jgs+mu7uxOuKc+J3S4HdXcMvq6k60gutJFnzb5zkjj+4Tztf4+jB?=
 =?iso-8859-1?Q?vMQr5aVaf1nf/WKX4yq34Ffxn0iyDhNx23MFRwMFvMwJFbpAYeX8SwnbxB?=
 =?iso-8859-1?Q?xxB0xHsBT4N0XKhUkRAm2gVOLWaO3l6vD+X9Botwz9Qr/SxdsHwzsnmLEq?=
 =?iso-8859-1?Q?+CYRJsXMkm5Q0lnXw4pDJbBuCAs8l2tj+xYv+mIKEOCRjk4SDmN9I+eYBQ?=
 =?iso-8859-1?Q?pDPia5fHbDkXkz7U316haazMHc2+d1+Gyq58kR+3R4832SmXYz0am0wTPV?=
 =?iso-8859-1?Q?RLje9Bz+o/pbcOkp7oxg7Z3IYr3rBAGx1MpBX+6+HweqBNw/OgvNUBCl8a?=
 =?iso-8859-1?Q?vBuwQJS9DfOMzLS/GB++/2znvlx/1Qa1w9N0nhxlA3cHj5X3n0wsI7QebY?=
 =?iso-8859-1?Q?tRqAlnasQ9ZCmUvl5L2j6fHeWNTBb6wVymZBLTQMk30DHiBcVkDGeMdeBP?=
 =?iso-8859-1?Q?7FWQ1REgRFmiZ4Ye8FBask8VZkyxpKsaoEvQ883Xz08g+ODV857Qvc+ppG?=
 =?iso-8859-1?Q?wq3e3Nf7yz9tpzLCwXM37cG8VEmjdBBM4k5S9YYAzlv32obPr+9A4xkOS8?=
 =?iso-8859-1?Q?0208ftjXpZmx91a4B1NXf5fhmIWoDwXxZjpI+YnTGZGqHYLXHOEgXd5XUy?=
 =?iso-8859-1?Q?mKjQRj0zrbJjtEMXDIa4yOGEvGjDSYvazkcOsun1YcbJE/ngFg8sLKtBR/?=
 =?iso-8859-1?Q?fmcuRvOtBwHIJPn7hBdNo89cxikDXEQxjDPVFkeDjO8CKqWfUk/fepnB36?=
 =?iso-8859-1?Q?r7skzbRFVEfksmapz9JYBsGi1tpNNvDVpnr5NgtJZXHIG6PP6TTXZOR4GV?=
 =?iso-8859-1?Q?CQmdgz6lBN/DmqXLStzMe+imMCtSgxnDSn2VTrcTyHtd8WZHF7mqO7QVdA?=
 =?iso-8859-1?Q?i58VpXyGSU5pjSqzwDS+ffNicFrf9lM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B3CD1A87B4F7504F8514FAFC82C82247@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gcqWD9TzpzGNxB1UEW7ZBFpLFzzDiShv4BSxhMVoeNv58PTLkQUBeBW2AqDul7l29wl2LJKcDDAEOzi0uHn56HUjzqPvO6M2wBf850W5v7ynBsZgN9+ZuHlH+2nTfbsFdoFjRne+81OamSZBMT9mRiMp9VNVmOjVd4TfIkhui/xjgBLMYJgAcOkjE5YfBjnOxCg71uB71Y1ixDegFwkFb8MJK/9Yk6MyVnqO4tGGgLPCypadLxKNC/VI5lfJ/hT6T2T3I5WFl+kM7+KiCjEBR3ituHFSDy8Ryc0qD/Lb7uqqNzcPnjcKMRweOudklCKKaE48FHjTeLgy0KV9zo+YLueutCJJcdHW54l8+N8lLhlsqVQl2EaUnd/wwKzxy8M8ZGx4G/a2p87IA9A97QOfZoSj1iEOTSVvOmvHXJEweYc8/rdgsF7o4WShKUBin9+zZn/NJb7AJOXL0tVQwwkwuRAa65b55AndxIMn7Q6mra9oiJ6BVNMa8LGm/tprZaI9BdyZCvsY9FCb2KZ5CF7unPiFoNJnDRFxIYCByjLSSHrJ9q9UkFM2VNEEDxwpxtKWCixVkLPiSEriEAhbg+p8R8+84KsoUYA+r0QhF2U5JGXqu3k7XJVvs3kAvJZrd/A/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff874725-6c19-4096-a149-08de6af25d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 11:23:51.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDN21gYeHl+vZAhJgRaASlPLqsVH1RNqSzxgq+f7KUr+cid6hIAOKs9nG2crJmR1OK6Xk37jxMwHKCVUXjgY2JPa4E1wnTnqQ3dKt7hFZJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77134-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,suse.de,lst.de,kernel.dk,grimberg.me,mit.edu,wdc.com,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:dkim]
X-Rspamd-Queue-Id: 1AC80135B83
X-Rspamd-Action: no action

On Feb 12, 2026 / 08:52, Daniel Wagner wrote:
> On Wed, Feb 11, 2026 at 08:35:30PM +0000, Chaitanya Kulkarni wrote:
> >  =A0 For the storage track at LSFMMBPF2026, I propose a session dedicat=
ed to
> >  =A0 blktests to discuss expansion plan and CI integration progress.
>=20
> Thanks for proposing this topic.

Chaitanya, my thank also goes to you.

> Just a few random topics which come to mind we could discuss:
>=20
> - blktests has gain a bit of traction and some folks run on regular
>   basis these tests. Can we gather feedback from them, what is working
>   good, what is not? Are there feature wishes?

Good topic, I also would like to hear about it.

FYI, from the past LSFMM sessions and hallway talks, major feedbacks I had
received are these two:

 1. blktests CI infra looks missing (other than CKI by Redhat)
    -> Some activities are ongoing to start blktests CI service.
       I hope the status are shared at the session.

 2. blktests are rather difficult to start using for some new users
    -> I think config example is demanded, so that new users can
       just copy it to start the first run, and understand the
       config options easily.

> - Do we need some sort of configuration tool which allows to setup a
>   config? I'd still have a TODO to provide a config example with all
>   knobs which influence blktests, but I wonder if we should go a step
>   further here, e.g. something like kdevops has?

Do you mean the "make menuconfig" style? Most of the blktests users are
familiar with menuconfig, so that would be an idea. If users really want
it, we can think of it. IMO, blktests still do not have so many options,
then config.example would be simpler and more appropriate, probably.

> - Which area do we lack tests? Should we just add an initial simple
>   tests for the missing areas, so the basic infra is there and thus
>   lowering the bar for adding new tests?

To identify the uncovered area, I think code coverage will be useful. A few
years ago, I measured it and shared in LSFMM, but that measurement was done=
 for
each source tree directory. The coverage ratio by source file will be more
helpful to identify the missing area. I don't have time slot to measure it,
so if anyone can do it and share the result, it will be appreciated. Once w=
e
know the missing areas, it sounds a good idea to add initial samples for ea=
ch
of the areas.

> - The recent addition of kmemleak shows it's a great idea to enable more
>   of the kernel test infrastructure when running the tests.

Completely agreed.

>   Are there more such things we could/should enable?

I'm also interested in this question :)

> - I would like to hear from Shin'ichiro if he is happy how things
>   are going? :)

More importantly, I would like to listen to voices from storage sub-system
developers to see if they are happy or not, especially the maintainers.

From my view, blktests keep on finding kernel bugs. I think it demonstrates=
 the
value of this community effort, and I'm happy about it. Said that, I find w=
hat
blktests can improve more, of course. Here I share the list of improvement
opportunities from my view point (I already mentioned the first three items=
).

 1. We can have more CI infra to make the most of blktests
 2. We can add config examples to help new users
 3. We can measure code coverage to identify missing test areas
 4. Long standing failures make test result reports dirty
    - I feel lockdep WARNs are tend to be left unfixed rather long period.
      How can we gather effort to fix them?
 5. We can refactor and clean up blktests framework for ease of maintainanc=
e
      (e.g. trap handling)
 6. Some users run blktests with built-in kernel modules, which makes a num=
ber
    of test cases skipped. We can add more built-in kernel modules support =
to
    expand test coverage for such use case.=

