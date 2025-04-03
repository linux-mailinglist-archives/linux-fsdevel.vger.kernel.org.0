Return-Path: <linux-fsdevel+bounces-45605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6EA79D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7740173A39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E88A241691;
	Thu,  3 Apr 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mhiBo9yC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xiQFRiNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5571A23B9;
	Thu,  3 Apr 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666952; cv=fail; b=lY6yMY+DMBiJ5oKSlR4Hf8QHGcSeWGfyma2ZpKmQvis2LFwEzpPbG4vhjNWQ+vJXolmPxjMZhm9MRsBhrD8plfPjG9qOja7AzDSSLOAOQHLEjVwSLXWPu2rB+G4YcIHhwxAPxMMXsfbQjkr+hwxoxRZERNR1AfALNRNoz4QLetI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666952; c=relaxed/simple;
	bh=O2aQrae7UfXEFRPlDcS8ATKq2K54C6VT7mhHLBXoGqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MHcaxxyP0WSZKGvNzuEDJzGAk7JeK2cPlTPP5hUuHPOdsoIcnUcUvTDh3EaPjaBgN5RqT6NcsjDMNpHCnGaDGBCe9p3T9+KKAEHUEkk9lu/9Pd1ySBOST/MICGMU8OBV6juVtddU2A+r2ZVZjVIZJ+xwuU/t1yyZgW547zp0Row=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mhiBo9yC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xiQFRiNE; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743666951; x=1775202951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O2aQrae7UfXEFRPlDcS8ATKq2K54C6VT7mhHLBXoGqk=;
  b=mhiBo9yCuuECRYf9r0hLI0CSUqtoQzjr0rzkxW3UK+7qI1g6MoPjk0bZ
   ocI3zQIxwAHEuCeOonELLvP6E+FFlGZH10Kb7VBvkXGxHmpglmGtw9wlU
   daMLXBtZLHZUok59vqOb0QW65Z5kfClc2zmMg3XWOxIgMjYHW+pjKZn/m
   +HzrDjYp68RfPDvrrNO1oJel35UOdkHeMHz8cUdkkud3lNxXY1FJ1q70B
   Xa2ua2SE7IyeXRCvScJSSQ9EXvWoNsuGEvRJ91Lr1EFSFSkgFSTi3yEyj
   DbgS5vJCXFylFCbVQRX10XmNQ8NC8gMVP0+BAZwJDoB01SCRnrRPuSnQK
   g==;
X-CSE-ConnectionGUID: RFKJqVDERj2y7tJOiUTz0g==
X-CSE-MsgGUID: MNYY1zxKSTSShEqyt8PZiA==
X-IronPort-AV: E=Sophos;i="6.15,184,1739808000"; 
   d="scan'208";a="68590192"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2025 15:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/RfZy/sDj1nWoHJVUeh8FeUfjsooGH+Hu2sb8gPbdp/KM6PuPHFwu3kkOio8lDBpAI8nd7Ki2PRE6t2qIVLRI/7FoVZ1AF6oxO+EDHV7HOxWBH+x1V2g4QbGDOw+hOxqM/SOM2lD1G9d7Dl/qCXTmKeEfWknw87vdFeEMpgFMR3imOriD6tYeT91f/BuJdZXJamOpZELXp4WEk0M0+o2/dUs/Htn96IVFsBhN4uCYI1DSJ4EPLtStFZb+uqozZPHzZ9HZIHXgCZXfgGjYZkeTvU6HXZGJey+OENfsmQoxJsX9SUTVKWOi/t5nTG2IlhjKH5PY/+Q53Y5xoQZHTAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caRTlp1o4JHgqCLljZA7+88oCb3FTB6HBjCmXAC8wQQ=;
 b=asSmatcYzoBy3A2IXGAZ3vsEF7xzfaPdjAc2Y5tasWsByQ9mJ8PDK0npEK4GGTnxz6bCfUb2jVPOn0qjXckyA0gXUT5xqjKSyQBMt6OrAKvQ/sPnF1pt/ezoiHMXkzXk2n2zgYuTIkZaY1SvO7V3ZSsEqYBx0Lv3wGVojlgOHFW24I6t9iTiekKP8Y2PA5a4jGDYrLh0cAEXURrvJ/jfK+OmGrZX0IKgtacRiX9LC/1DmHhnx1HwkvWm1lDFqeVcH+y0FPMuKeGnpa6VimlZn66VbkyU+eqtmlcs/tFltmjxLhiGJ+pf9lccKL1D4LJJoqmNaLA3YQhR7tr0smMUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caRTlp1o4JHgqCLljZA7+88oCb3FTB6HBjCmXAC8wQQ=;
 b=xiQFRiNE85DUlM2HqcJ2ktxc+xC/jAMQUk+mK/lPRnhkD0Aiwk9sRLGersFrQa2ej97DcufbCK4n4Kg90lGpg7BVSQEW5rsDoK1+nG14xTQeaAMGpCvohDY6RQka0smMaZEqd9SfspYPMtWKg5C/h5MaowqySVRIwdnBBeF9nqE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7204.namprd04.prod.outlook.com (2603:10b6:303:72::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 3 Apr 2025 07:55:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 07:55:46 +0000
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
Subject: Re: [PATCH blktests 0/3] blktest: add unmap write zeroes tests
Thread-Topic: [PATCH blktests 0/3] blktest: add unmap write zeroes tests
Thread-Index: AQHbl9iRyAuHzKjGSUal8SrQu0Ile7ORq+qA
Date: Thu, 3 Apr 2025 07:55:46 +0000
Message-ID: <yxfbr3na7iyci7rs3rk4m7zmjrfw3zdccrnur2nkk2lddlowmx@wy32rpgrlzoh>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7204:EE_
x-ms-office365-filtering-correlation-id: f6b1ed7f-f6d2-41d8-e5aa-08dd7284f124
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1emacznYX4xaXIgWpcPdTkVylmD500BoIPQsvWdLeUzDqs+JDqUK2ec752P7?=
 =?us-ascii?Q?EWH5U5Rt2UDFckDF6DfwwMNE90nKf5XAvjZIcQABU5Jhl/i0ylONeLnvHS5W?=
 =?us-ascii?Q?mYR63xdS6TumazaEZ61xxrAaB8C1pjNxl8yVe8c8/p+Ic6i+GaIGhwy7smq7?=
 =?us-ascii?Q?DJtSuGobbnpkJat7iWGeSjxnTKwLAufHdKUbKuMJm2JGSuN/hyscS0IgDpcs?=
 =?us-ascii?Q?dEdC8ic+RB6FYBBhHXYRCLU88upS5+sHVWOOYOuEGO4qh45K/A/ZyrBlvRf8?=
 =?us-ascii?Q?+AAOmYvEvJmk16Q+wYcZGtP+1YopH9dymHog+sY2vmFlAoX9d701AOwq81K0?=
 =?us-ascii?Q?/3Oh+8ZozdtfPNr/KArhPN3QcqtDK5ICzTPgFwFm1rvv6Mf4AUB5oIXbFlVT?=
 =?us-ascii?Q?y4UZ0GsBN/VIIsIiMydIhMYG5yZEqAaYQEcsPrSLQ/meJarUGKsHdk/FAfdg?=
 =?us-ascii?Q?sVlKb8WA9bxTYPJ+SsYutmUHE+i1OjuW5Y+Ev1iCdpP/3I0brtRyjalUH4EK?=
 =?us-ascii?Q?sQO/BrvSA7z8HOp2+Ug+fV3EndtaTiRpS04C81c4EDD4YtzVplUSTeCi1U8n?=
 =?us-ascii?Q?NarjBtpAqUw2HFmxG47nPWzP/uQePSuqUGI/uF4GjMXGaFOW1TeWDxqglK9E?=
 =?us-ascii?Q?eAcvc1ey4GB6g8NNnB4f3T5/hrVlv+xjII2ceCbDIjG1XradyuYUVYZPgTaP?=
 =?us-ascii?Q?LXQmyQ7cK/nGyx0j5r+mM1MvYCugdIO8zs6AddStdhCYMGERgT/YHXPh++wx?=
 =?us-ascii?Q?jF39zcD4cLnub6sPgpqrGmoiqbH73hzVFj8AAorFLDxRTu2MUPv2hwa2byaf?=
 =?us-ascii?Q?/jJGFqdOSxDbUeIfRbj3hOx5qgkPCBNjj3cbiz8Lxg6lfeT6jjmLzL9ugtU3?=
 =?us-ascii?Q?mVJ5KNKU0zOidXNr1jyr0HSucI7iLDedMoMg3AeMqYuXqX3GRle1iypJnIS1?=
 =?us-ascii?Q?O1ZhZLL1NTOV57rsFBF3TeTIoxz3fK5hvLH1KFm+4USoe/dT8iAwo8UaJl70?=
 =?us-ascii?Q?dxBFLIrt7WHA0Fd4FQizC4wPPu97Z71n/x14bslxW1l63CRxkW2pd4VNVHNQ?=
 =?us-ascii?Q?WAYsB4luzlhpFzM75TNafavPudp2+mQhAykSq06ONGTynkB1Bxkk3IbYOCE/?=
 =?us-ascii?Q?oCBDm3P7yiuuGZpEDLQzaWZz+OqMdEBgiNGJ7+OI5esdZOnPcBparOlUBG74?=
 =?us-ascii?Q?I8BeVT6Cxq/TrpBv94pkrD3BvAY4gjzCS/9p3Gr95oPVoxA4CAlf1mkiOtlb?=
 =?us-ascii?Q?ibii4X+v4kCW6uMd7g/oeP3t/d/riftnJzFUuKX1bg7k9yrVKDIn7WZSnIsg?=
 =?us-ascii?Q?timLEVHeu+u+3f5ci5JWQ3S+gcCO+51gAN52PNUrBdzPOKWy9mKuKOjk1WXh?=
 =?us-ascii?Q?8jdkvesQt99tLWk2/kS2Lrdv57sLi/NVz2+4VFA03IT8uVNmy4s8/RZchQtU?=
 =?us-ascii?Q?WHCgFXpvi54bSZ39re5j60xrHXjW0w+n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VIE7/dLe1fSgF/9Z5uYRDAIC+cluhvGXAwihrldCSa6hWSf56kcAkJomESGh?=
 =?us-ascii?Q?66q8Dsb6JsP3lFEUpwwacEtxZHzQRLF1LVfL17JOtuymBbAISk7I86p+NTdG?=
 =?us-ascii?Q?WRWF53w0jCyGv3TSghX+EJQYCbvdB6WCdM1kzXdWTXVIOUXaIhW3hemwPF1y?=
 =?us-ascii?Q?XLbn0Bt0H0iwcaVUK2c222ZykL3+xiu8dLnODdXdrwYhzJWdzl+FfXorrSNP?=
 =?us-ascii?Q?pjpVZz0PgQ1M6/PiEo6bGknjGLE9kEkRC5Wc6S8FuJr0fyG2jhwi0E4FhYAx?=
 =?us-ascii?Q?ju05mrRx2Ghfg5emQ0Lz6mL0TYFW2x59lcTdz8K+BYN7i4WPySA0wlPAjqpj?=
 =?us-ascii?Q?cVPX+E82W23kLz/ljTI94Tn1b8UPo4VwFSYTHROwHhtNzsaWHCnMncfYCs8v?=
 =?us-ascii?Q?Lq4ZEgkJ82aCRCKorsu0ltCH8rzR5WIdqE9a01iZJzPrqSoB9jYrIYzEDeCV?=
 =?us-ascii?Q?4H/SxeIlAMAXp6+U+qhjSXt0U6YFc5LfGbPCnmjvkLs9nFbzQNeKg5Jmbh4L?=
 =?us-ascii?Q?iYeBsLmDrYA7eJyhM9s+bsmYUOzrcVssRZ4U9mZxXpvOfn/qdUgP308Bdsbp?=
 =?us-ascii?Q?AXf3BZMZoExOo81jOc/6PB5KN13rTGLrpSg+/Su4O+TWrmCQtVzcMQhdr8Hy?=
 =?us-ascii?Q?pu+AMHs4LoEn9fv2hxmlWBm7yqjAQrfjE2XPwpRUUyFNWbqtTSeI6xSjO5pQ?=
 =?us-ascii?Q?KhAN8GPBQXutSPt+acO7Jh/3KdlFszMLqOFaUH5LsKW3xakns3XYjX2CTMkI?=
 =?us-ascii?Q?O87EsrKKmg4LEl/2PEsH9VOilSlgRoYuXWzS1ljFdChXkwvywJA0AH3J/5q1?=
 =?us-ascii?Q?O5oBRbCTkEuncimYEqtVVhiPqV2bUzPBP5jq/L6i9jUki0hHeSCQ1UomfVWv?=
 =?us-ascii?Q?x4T3XfbmLUC1UONDC4uRI/LplgcG3oirtlKgUTuGhY2tCaJDDkeGjFrY6oMU?=
 =?us-ascii?Q?YeTwNwLaXeonvpNb1Z9L7GaM6ttJP6Ia8WZG9UV4FEVwMloE9hiNyoe4Yl7x?=
 =?us-ascii?Q?oUM0YMii85R5MWrNhiJefHvE5+GPMAtzS1an3nhgYAuVCUWD8wq6CiiBqFVd?=
 =?us-ascii?Q?GI6awXRklssTPfveWHX3gxDK5xtP3u17RE47SJm8yisrO1ndprBZZyLjGwYx?=
 =?us-ascii?Q?19PhcenAja3OUE9DMduHiEq+AKtOBa2qiaXyrbQ/esXJRJInMXtQXNREJFLv?=
 =?us-ascii?Q?O22ui5ZzDZgS3DlINMFbFZ/UEoEVyvHg7U4HX3WyYMYpB3bxHd044MnccSPT?=
 =?us-ascii?Q?acGN/fFan9i/MPOaGgLk/Gtt6CcCW/rNhAV1xeKgmcvUfCNCoaRPSC9u/j3G?=
 =?us-ascii?Q?doU/Kmkz6V6muxId0hEXIZ986UGjovrF3bu1pw8tcBv5/ssw42VMStbDA942?=
 =?us-ascii?Q?1J2RARdc1kALT3qnYqFIa7Cz+FM8kAsnxSbUisMtfEoI/pWWpbZj73WLJ6kG?=
 =?us-ascii?Q?mZtvV+V8Ry9ps7/u9SozCxoh59ELRcSEPVX+oNHOiiqFLkeZlfTP2ENPU4Du?=
 =?us-ascii?Q?rs+JCtQ9yMOhJD2bdkI1nxt6KzlzbAMknYYCFKTh7srKhRREbMPnEd3osg4n?=
 =?us-ascii?Q?c3K2A6E5s2mTUe4OXyvcJTZ7ruBDWiAMuodcHFmVypGinz0gdd7MgkIFxVfT?=
 =?us-ascii?Q?65931lkIyq1sZph9ODMI7KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <254B22F1236C6A4F98145CF15DCA5192@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H1g4U+fuC4w2bzEHAUpJJr2A/zUwycPzOQYQQKcK8le4Da4rphK8FxDpNJlQTcHc0fJUwXiMumxrM6GJeWn8bHPo/W5nGaq7B9ZfrrT3gm9zmr7F+PCDzyvdCLO3DfruFEruFLfjeoPbOZx9YJxQjPblZDFxKaIv2A10Soo5MpDLgvHUQ/VhOnaaTK08CgVDiIgTmph4z5l2drWlVCPyIEXKBCgoeWodbE+1gGfaihXIxMmawHLsHsDd+8d9gWDI+42FHAy/yoiqT3sEPKgUn1FVth1c0XIQAEx/m90A9qd3LOd9KysporffxTTDWuBcj9PmDSO/EYUTf28QW7qh784bR5j4whF4o4HCZn1xqhPipPgdR+JyH20lBrqwDgnDC+SBR+yrWWUqtnU85kPknaCplOeEKxx1pM53kQwdwl62tvjsMKY+7gs5t3bqBCfpl1rC/1L8CNCyI9q79stsJWtjm5gMbYfwNw7abLtT7sSMfQf+rmG3fw4Qp5s4ayt8aGywtoe8XVUOQhQgDRnYxOBhun/UE2ZkEpRSsuGfLI1pRGWS/Utw5bufA33zzSUm+Je/k5pElmCP+l4tepHWL0I8TDVb14gTA8bgOWcF1d+IPQnyYk5Tf096sqIqwScN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b1ed7f-f6d2-41d8-e5aa-08dd7284f124
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:55:46.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqu69RMY3n0J8LeunUmPc0ZnxTVC2tnCV2c1MqMiqlZcGt4j2FE3JdRo1LNe7uyWPjPKKgQ1hsMDvc+5P8Ey56HvW/T5z1hh3A4a4Wf/E5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7204

On Mar 18, 2025 / 15:28, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>=20
> The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
> fallocate(2). Add tests for the newly added BLK_FEAT_WRITE_ZEROES_UNMAP
> feature flag on the block device queue limit. These tests test block
> device unmap write zeroes sysfs interface
>=20
>         /sys/block/<disk>/queue/write_zeroes_unmap
>=20
> with various SCSI/NVMe/device-mapper devices.
>=20
> The /sys/block/<disk>/queue/write_zeroes_unmap interface should return
> 1 if the block device supports unmap write zeroes command, and it should
> return 0 otherwise.
>=20
>  - scsi/010 test SCSI devices.
>  - dm/003 test device mapper stacked devices.
>  - nvme/060 test NVMe devices.

Zhang, thank you again for the patches. The test contents look meaningful
for me :)  When the kernel side changes get ready, I will run the test case=
s
and do further review.

One thing I noticed is that the patches trigger shellcheck warnings. When y=
ou
respin the patches, please run "make check" and address the warnings.

$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
common/rc:624:7: note: Use $(...) notation instead of legacy backticks `...=
`. [SC2006]
common/rc:626:7: note: Double quote to prevent globbing and word splitting.=
 [SC2086]
common/rc:632:7: warning: Quote this to prevent word splitting. [SC2046]
common/rc:632:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cm=
d'. [SC2005]
common/rc:632:7: note: Use $(...) notation instead of legacy backticks `...=
`. [SC2006]
common/rc:632:17: warning: Quote this to prevent word splitting. [SC2046]
common/rc:632:29: note: Double quote to prevent globbing and word splitting=
. [SC2086]
tests/dm/003:28:8: warning: Declare and assign separately to avoid masking =
return values. [SC2155]
tests/nvme/060:32:8: warning: Declare and assign separately to avoid maskin=
g return values. [SC2155]
make: *** [Makefile:21: check] Error 1=

