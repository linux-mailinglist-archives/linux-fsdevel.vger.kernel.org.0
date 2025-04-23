Return-Path: <linux-fsdevel+bounces-47013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D5A97C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 03:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473B1189DC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCD261573;
	Wed, 23 Apr 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bdqfcRVM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gZXTIMg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1224A29;
	Wed, 23 Apr 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371926; cv=fail; b=MxHM0rL2+W9+eBoUBF7VbaFTUnV6Y4FF43q4TiRf8fznOzmICjzSR4xysS9WXND68YTgoHjQXP+kZdji19lvtNDphzCj9N/Fcksx7yI54xMg6I6LfUQa9R2Pem47pCq5qDjZFsDDMSdxMd/E5C8iOem0n2ixDQTHASfElq6Mm94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371926; c=relaxed/simple;
	bh=jYDKKlynymucCVI3gNEqzbAyEV5VDZL9Us0A/uDDkAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DUMlaz7SVqTTrI0PIpaFgka5NCpZqCCWGvNte90PhqK5+FO5Ny0zVY0uWza6UI9+QAiNoTUpukzLpkE1kRyXrPbc8Ww90aZP74cuLJG29UnBXetOhYUPCD717FiuTAU8WUIxHU3bKoQpZDmI2eWdOxBph0TCISng3FCOx6KSvMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bdqfcRVM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gZXTIMg0; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745371925; x=1776907925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jYDKKlynymucCVI3gNEqzbAyEV5VDZL9Us0A/uDDkAU=;
  b=bdqfcRVMiPfHViMUm3qEIZchLmI62rZqG5EuNedsj12av1Dd119I/Btx
   awU7RgO2lTxnNW/KZfFlkZTxVACRGaMtFeeYPbaiz76WPlb6bdsBd4BRe
   hsegFzOxt2hCWTBdPqUo1ZOSsAw2QfP+2dz2rnk/dhtKmR2neTQXAKjqB
   UyANBunaps3xGvx0QU3mM07ImrUHuEe/EsabI5yLJl8LtubwkGh3mbqWz
   KlzZmzQel0HaYwT3jOiok+FjQrcuegYjR8pcIY4NpJKpljRNely17skjz
   KmZ1Y8uVzVQEUlgQ9eqQFuZw+tAVBqq/wztVjqoikw3ffsYdbry1p7ptu
   A==;
X-CSE-ConnectionGUID: F/Wz7dILQSmSPJIw7XM63Q==
X-CSE-MsgGUID: kVWkSSwXS4SHSi4WVIEwBw==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="77505585"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 09:32:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6FKLfQ1PHvQwYtUPzniDZDFHUbxiY+2uLvvc2JKXu3PyrErxhFotQNmNTx+qIl3r/1tESVwFlyJ4Yat0t7TGnQv/z7TsVDooLDShvU1UkYMJYxDWn517nHZjDa6GQjH7ko4WTqE27NvipOyRUpOo6Lr/t1X1wAZT3zS+jWfSKoRoF0m251JDU8E8hDNRDz+JTbVdNaDYikBUYQLuyOltkYDHo+5TnZOijy3CYJs0T+n6odMQcqfY1R1t32lFzDuDNQfC5+iVyq5LhIbQnpQYW9uJO34w7BCRw3f1+4x1Azb1aglTO+thMlTURKR7CHy2MMo/b/5OeIgONjteGCSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcirv48MYSE3Zk11gaNahA1dAXpQljzOeqKRBUyF4I=;
 b=Pbm2sLcWJfm8NGDwJlYHKES6j6QlobPWvQQR+W77a+FogEpnWd6i+bl+PGaZbsev4A5aqkpdOCWZRYVgql7hoExfr4mj3I9zXNFLf2MVRSXbpEVD12C8jS75IW15FAWvRmT4nI+0aAbf+vSRwkisTX0MrTdvQPy8IhH7wg3lbr9Jh5X7Qbg2XkRlo5VvVEOKSSt5D905xbVGyt3fOTov4lghYSSdfz55bPIx4V22xiap2mkDkLS6C5F1V2SdXqNzAz5IXRfud4NMbWE6X7zRlUob17WqC65CL2DL2SzahjiKY5KcT/qVIyLnNRHly7NSzLOcUF2gD0/1e47ru8/rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcirv48MYSE3Zk11gaNahA1dAXpQljzOeqKRBUyF4I=;
 b=gZXTIMg0PIa5rjZe68N478l3xzbgHPppPArAy02s1XuciNnzZv9nK0Cp2jUzerDaLijGn1iH0AIy70/tmmnkDYII+sOFWwhcIjsOCWg20QsnU8D5outxG0RbEQw/ea9WjaNZDM5hYe89tpaU3602v+shmUoUWHEx7L/8XexsP6M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7661.namprd04.prod.outlook.com (2603:10b6:a03:31a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.32; Wed, 23 Apr 2025 01:31:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 01:31:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: Christian Brauner <brauner@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com"
	<ebiggers@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Xiao Ni <xni@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Thread-Topic: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Thread-Index: AQHbs0PcHgN8MfumQUyoh4YWdFd3xbOvLr+AgAAoOgCAAACBAIAAY+GAgAC9FoA=
Date: Wed, 23 Apr 2025 01:31:57 +0000
Message-ID: <rbt2gxfqflw45ujxixlzuwfrhbu7umanwcala7nazmglcahdhv@o74cjtt4eret>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
 <20250422-angepackt-reisen-bc24fbec2702@brauner>
 <20250422081736.GA674@lst.de> <20250422141505.GA25426@lst.de>
In-Reply-To: <20250422141505.GA25426@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7661:EE_
x-ms-office365-filtering-correlation-id: 6ab0b924-172b-4e56-2488-08dd8206a372
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f0XgReyCZtwprwi8ThFBObQFSdU34QjGlU00I9Y19tHyXQ7Bkuvmu2tiTAsB?=
 =?us-ascii?Q?GJaUSnXYwdJeh9P9/zAsMBwWnJolDr6P74Eyl/Ws06bGc2/xxNBHoYDi2No/?=
 =?us-ascii?Q?/T5QijPvrwUMiWLc1zOCK2ac/mR9XpRZOX/lxOwyWG4VCYDnVi1yuFkMYloq?=
 =?us-ascii?Q?dYyS55gTQiA30Jzz7OwpT1pC3qjXdfOnCSzxx0Ih404Ih0fV7UzhEMF/aW9X?=
 =?us-ascii?Q?HJTb1OepZ/RuQSSMJ5DF5L/5cDT3zjeBWN/pPCk0TkRyvXaqU507f+CyJeE6?=
 =?us-ascii?Q?V6Sg4Rl+JUw6GY8ZqTdpcLvK7vhRBFLjeC7nSvDk6PAbEpTNOhLpowdWSZEr?=
 =?us-ascii?Q?VATXS1dJ/YD2wMklNxn1lwYiTjQ+Jbatefdk8EdwX1u4aZaNElGvJ52pTTA4?=
 =?us-ascii?Q?koEBsSeyZgXI1nf+uMJCsmBGqGYRihXlBBDL554KMgWRLzsEkc8SCw30LVoS?=
 =?us-ascii?Q?7Bq95BLr5NGV8AB5ZQ1JMYZjy0nyXSOGffJR4cx4WSpldWwcFw4ZN1h2kkwH?=
 =?us-ascii?Q?p5WC/wmfd3FQ8GKP+BcX3LKz1jhcp47Wnx8+vffnj+rk0kXRNqxUJSNQ0b5S?=
 =?us-ascii?Q?mL4L0j2n0iuTOHKZ0DY6MnbtYYNLNX7biFP1tNQUEpme5GGCsSoSWBbqi2wN?=
 =?us-ascii?Q?u9rb/eU0kRy/NOa3sBynx7JSxdFQLyI0lH6zfeZkHbPqjSGW7c2oLhK/6GPO?=
 =?us-ascii?Q?bYFR56VAq3vSp8cC9QubM0iSvwGD0G8TOqCiKjf7b7hZzJAK7o0Gk6XAP8xv?=
 =?us-ascii?Q?Mv8Y8ZVYxzK9QDDOdgVaLTRD6LgLiVKoXQWLdJaa8gcOh2XPlMVeKDVddW1c?=
 =?us-ascii?Q?UcdyAa6vUrRGpp+5DbVu0OpdskLckn415Pm9oGuBLkPZN17dVIvvRSSTqYhJ?=
 =?us-ascii?Q?0pB7eir/kzXbG05ZWxylEzwcoG5dZY7QD60uc5ApnMvMd539vscLZUhqaaYT?=
 =?us-ascii?Q?ft0U6zozj3At0Vh+txQtUA7TkbXMuq6ygyUgTmsQ664d1jzWUs39VWWU5uZb?=
 =?us-ascii?Q?jJD5bfXIdzyCOauZxNmeVQzOwz3NRx5N2EWBuIiRBL8XGd3GovJNE+RSWONP?=
 =?us-ascii?Q?jHBbYuw5JkLrzl4n4lVQva7yW0pEFle3g6Y31abkfamnIkNriEIhqQi6vVmq?=
 =?us-ascii?Q?HrDkRcmWXISzWZYuhWJI1HgrLLTmKxxT+T2AACHFhaxS6SJGAB/QJzTfra9X?=
 =?us-ascii?Q?SG+xFpycfqOuHzAOXUSRQC6PjmTuAiwVq4p1GpPsgzMmAs8vDIWJlD/vOyKJ?=
 =?us-ascii?Q?YDsfz16d+zP6xanFsEz+ZFIKFhh4wQuPHWfeHiHoEdTBYpPUkxxbXVjbg8Vn?=
 =?us-ascii?Q?sOaO0WFieyW38mUf8e9MliNjMYUla5Xg5kb1OTL3lwloofN6xmEsceUM/8CF?=
 =?us-ascii?Q?izbA07SoATbI5PHRmqm28NyrsTatrA5HWf+cBrMDDTmiMtZYJMP1ru9Njjnu?=
 =?us-ascii?Q?Vl/bBQ3B3xrBglP8ICw1JbkiL0hyGzH579zEAAQcwHR1GSUZZE8G1UvRpPOR?=
 =?us-ascii?Q?KvvQwz9zZPHCeY8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?och+IAoCV4jOCa5tPbvbi3iwiFJep/A7NXJ8yo6EbTDJoEl6dzWjlVx0XmTS?=
 =?us-ascii?Q?OA2lHJFJTUEz7xki4o8XhliGUm0uQ5E7kawhivg6fm7SQkUC+KwNOysVvtl0?=
 =?us-ascii?Q?0rykMneXD9zzWkuOSFJOhrMInxxytyTh1szwwtaWn92YbBcD5qJfCxqshCXu?=
 =?us-ascii?Q?TF1bOjThTAOUehoyESSlGaFdnaryz7Yicx1f2WVhQJo0FOt1CBRr0tjk7JtA?=
 =?us-ascii?Q?EP+GgasJNKhyJyDVhJ/2DHDaGct3/+H4frc19foPs2v6fG+YddblqlMRvF58?=
 =?us-ascii?Q?GChK3n16glEuyXxJDA9IxqSPuQvej01r4VUME6JMogEvqCiJFH7bgRthde4B?=
 =?us-ascii?Q?x+xJFrLfmGQOwCNL/Mg+BzdviJ5Bn/wY3XVvZUUw1fNMcv+H1ORmwU7xy5oo?=
 =?us-ascii?Q?XX0iX7PQpScmHAGuDY4VVcdazFVmcM2RBJ7gdDO5k0rPnE/jm43y2GlWlldi?=
 =?us-ascii?Q?Pho+UlAy48lWaCJiBpv5dRx8VzQsC3Ye0NlyYM1RTs2IAtV/uZG2EldPmP6M?=
 =?us-ascii?Q?Osc93pfE2E2Yv7I0q3PjDGf/FwS72MS7Gc6nBw1rN2lTMf91Fpm4zrcFtnWk?=
 =?us-ascii?Q?I7OLMN2qNFVRq/yIvIs+JSE4ggJzu8Wii97CjvSgzu8rUPXG5NLR8IOYJb2/?=
 =?us-ascii?Q?mAlk0dDfPuYZKDsdTIhQksBvcLod77sbs9c9K3HAHRfFcuioNNXuebuiwIbn?=
 =?us-ascii?Q?dpBr48EdQEgBTTLKni7UT9UWwVPI0FIQjNlSatUNZDMWO3X6fAgXBiojFkuQ?=
 =?us-ascii?Q?d0efYcGrBV5NtbuNEeeiPbPZZ1xsvRPv/sT+2o9NjJeb0unghGrgQ6CChpQT?=
 =?us-ascii?Q?wGsArmbeNK1mnmzzssZ97GXYL1cGvjRFQfkMBz/bmPSLC6JAkZd0iHHamUYq?=
 =?us-ascii?Q?3lxzaF69CMH0tqQYlQpVG0BXdqgWxiWn5s28B2GT/cEfxvHeacY31tbLD7YE?=
 =?us-ascii?Q?/BjJCpM5erud06hM+DggHaCn4iMuL/1grVKL5L5YdAQb4gtksIpLSlLJOP9/?=
 =?us-ascii?Q?R5TE3TZLF5M1PCeg//PVj9H7on9vcZSCSjtJmSzfwCLPYf59rWrN+eHPX3RJ?=
 =?us-ascii?Q?5qqheLEF1HYKMr8gN2Zw040KuRRNVtiL1kxqBoZLk5vPk9qWdLd4GboO1owC?=
 =?us-ascii?Q?LeLnAaI5xLqldqS/6KzboIm+8KpSoR92wIs04Ts7rRAsilh8yReb2b2nrY7L?=
 =?us-ascii?Q?JGD2S7vrsGutZWAwC7pytZ/whNTEXgsesWHrk4xQUPz65GqwSiCv2UetwOsr?=
 =?us-ascii?Q?P5hpctMCvY6pKk+9jem6JL+CpVJVbb+JgOo5GlQS+sQhb2yJz2L/37njxxO8?=
 =?us-ascii?Q?WwD89XYGwLzp5zUfjcb6rE71907SBvxeXAvWBfaMC2NinuF+IypIEX47E9mV?=
 =?us-ascii?Q?8LcDE0Dr3NwCfNvvBBwXfPG90GkI0pLSuZypxfdZBEL5X3Tf73I+WQnOAgUs?=
 =?us-ascii?Q?Tt6M6k+q0XvMbl49e+DJ35pmFviUpV/qGukkDzSu52tlLMzeCNz0Eg7xgctu?=
 =?us-ascii?Q?fO6cw02sMfWLLaV90WW2t07+N7BuPm6sihtn7/+z1hEiMwKsrGv1/Ivg4qBS?=
 =?us-ascii?Q?dx85ryS5cjt6GwkEMNU7NbRZAr2uqh9ileiLgoaVugLfB0/6wAOmq2boPzW8?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D20FB1CB321B0E4690B6BA4E71B3F97C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DvMvMV2mIKHjzec6BGgEZBwUH+bHnCh+C/x18H+2KGj+101gt7/7qnGMzozfBVGuyfIOVANx2aB4tKrbA0z5C1wvqwBZAYKR7S/po128UGhicEL609UIVZN+5NXXzyc2KanJ/dInx06Vkm7MEhNX/s0E6aJlckevpYBG07dYr4ThbDydx2ndNSg86UDJp3/m1EpR9UbV0o9zk/fNpUH9T3z2Nz/GZnHiJ2MUo1JGyPt10xZ+uyb4LbHMhGxxHbO8E9mxv6+hjmkf9gKyYO8z86bYFZwFmq6HUGfrIZJR4nM0UcCMZIY4oWIjsk0PGZXI7Hoagt3q/mUH5Zsj5FyYKWAIvfpYD5E+3OeBQkr7pOJbGh3g5Srr+IfYh34TtCGyqIcF0sR5xrWpQWfJsEuat1o4dwCx0ykXsRNn7+8qGMJQl+cKt6I5/9Bly+wlevXoSOZw6vWpUfAqbQtYCS2qGwW5/BmqiU8cpL3vbItyx63TYJaqN1WxoX00rp6HsEUmHaTrFL5YxdekjEjd7mmlqX0kibz0BFgtH5Q2nHsCirm+DSyOyjzBqdT9vPI2SiZKtceFhg1vthFzI2kbQnTKVX4g2MsU0Azi98BaJB975fvTxkp5fGtFPONypxl9ZC+d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab0b924-172b-4e56-2488-08dd8206a372
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 01:31:57.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSlncC4PhdreSPNbrMMMlrh+j8C1YEpZ+8OcNvit5S0IJnRvXFOfnBvbiY8ZVYWyOAIjcNoLtYfW3FHxD1vzSzk4VOcvPVl6XE3b9cL7+b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7661

On Apr 22, 2025 / 16:15, hch wrote:
> Turns out this doesn't work.  We used to have the request_mask, but it
> got removed in 25fbcd62d2e1 ("bdev: use bdev_io_min() for statx block
> size") so that stat can expose the block device min I/O size in
> st_blkdev, and as the blksize doesn't have it's own request_mask flag
> is hard to special case.
>=20
> So maybe the better question is why devtmpfs even calls into
> vfs_getattr?  As far as I can tell handle_remove is only ever called on
> the actual devtmpfs file system, so we don't need to go through the
> VFS to query i_mode.  i.e. the patch should also fix the issue.  The
> modify_change is probably not needed either, but for now I'm aiming
> for the minimal fix.
>=20
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 6dd1a8860f1c..53fb0829eb7b 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -296,7 +296,7 @@ static int delete_path(const char *nodepath)
>  	return err;
>  }
> =20
> -static int dev_mynode(struct device *dev, struct inode *inode, struct ks=
tat *stat)
> +static int dev_mynode(struct device *dev, struct inode *inode)
>  {
>  	/* did we create it */
>  	if (inode->i_private !=3D &thread)
> @@ -304,13 +304,13 @@ static int dev_mynode(struct device *dev, struct in=
ode *inode, struct kstat *sta
> =20
>  	/* does the dev_t match */
>  	if (is_blockdev(dev)) {
> -		if (!S_ISBLK(stat->mode))
> +		if (!S_ISBLK(inode->i_mode))
>  			return 0;
>  	} else {
> -		if (!S_ISCHR(stat->mode))
> +		if (!S_ISCHR(inode->i_mode))
>  			return 0;
>  	}
> -	if (stat->rdev !=3D dev->devt)
> +	if (inode->i_rdev !=3D dev->devt)
>  		return 0;
> =20
>  	/* ours */
> @@ -321,8 +321,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> -	struct kstat stat;
> -	struct path p;
> +	struct inode *inode;
>  	int deleted =3D 0;
>  	int err;
> =20
> @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struc=
t device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> =20
> -	p.mnt =3D parent.mnt;
> -	p.dentry =3D dentry;
> -	err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -			  AT_STATX_SYNC_AS_STAT);
> -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +	inode =3D d_inode(dentry);
> +	if (dev_mynode(dev, inode)) {
>  		struct iattr newattrs;
>  		/*
>  		 * before unlinking this node, reset permissions
> @@ -342,7 +338,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>  		 */
>  		newattrs.ia_uid =3D GLOBAL_ROOT_UID;
>  		newattrs.ia_gid =3D GLOBAL_ROOT_GID;
> -		newattrs.ia_mode =3D stat.mode & ~0777;
> +		newattrs.ia_mode =3D inode->i_mode & ~0777;
>  		newattrs.ia_valid =3D
>  			ATTR_UID|ATTR_GID|ATTR_MODE;
>  		inode_lock(d_inode(dentry));

I evaluated this new fix also, and confirmed it avoids the hang. Good.
I also ran whole blktests and observed no other regression. Thanks.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

