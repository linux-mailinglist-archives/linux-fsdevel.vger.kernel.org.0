Return-Path: <linux-fsdevel+bounces-46893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405FA95F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF073B78E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820923909F;
	Tue, 22 Apr 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RpdIGVFX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OIQ0LEyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB310A3E;
	Tue, 22 Apr 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306523; cv=fail; b=QcKfdERIlzrFHwiPtHQlsd+PFuaNWy27iy8pRHwb2lDN4b2gKdYIVyAov5/N2zXCCV1mU1PP8rnacrRodu9u10m269vz7sS68H2/K+38uPTjntPTsmoc2bGpGyXyoYa+xUrKunCOu+tWqehy67YFUCtNAS5Ne/DLpssRiUznauY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306523; c=relaxed/simple;
	bh=/NafKxJ8aQzTohIanQNeJFDASij7ZdWI6dzXki0KpEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPce+4URTMCHBA35r/gB4e4Jsh4Amd8v2EX9JQbov9EtI9gJVMx6QqvtCuAVthnltCnOpzLFu+8Bw5M9Cg1zkblDc/vcdn0kOLRwh6EB2It7V1/C7iCKws6iccGM+nZGS1DYf27gnMyYIjOmU0kzg9s4L3NI3u1BhefpbLTVxK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RpdIGVFX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OIQ0LEyS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745306521; x=1776842521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/NafKxJ8aQzTohIanQNeJFDASij7ZdWI6dzXki0KpEo=;
  b=RpdIGVFX95hZ5cKh/OIRBvJMKxNZu968zyFXM0Bgrchc6GDOrvMEajFd
   8nkU4OOCZKR/3ZcyyIyezPUX2aBkOOsPvAqXoTWYSxvIoxx9d02ZQhq6s
   Q56ZSHQJo5RuqSXSkY1H4zKte+8H/bi2uYOgWghGecLADpll6g2vDW67k
   PQIKnaS/UKBY3H2IFVDfOYakWMoVMAYFf3GPWJ/MHq3uBYnKuHCUsSCvC
   8ZO4GOBn0UNFyat5/H94bicrvncvUMPXsgOlc7MGbB4HE72habpQAtTyQ
   KoDhQCkMd2Sz5WZOfG2ecGZps0HTHg3Qhh/pKbkr2KKggLRMlaAKCT/3p
   A==;
X-CSE-ConnectionGUID: gkzZ3ZkrRE+vruK13M9nYw==
X-CSE-MsgGUID: aAtaSU2bTAyy2P6XREIqBA==
X-IronPort-AV: E=Sophos;i="6.15,230,1739808000"; 
   d="scan'208";a="82009060"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2025 15:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeSlD9TbT4nC7Pt5wn7WB45KqtcMnxwCEXrroPJYBPuf73HlJhFFn2VDCi/mC8/FWJYQOPnQVdq2x5//q9pQOTBQgW+QD7c8m4yvbX+rDTbKQHIQZWYHf4AzC5mGYx2WzjQqz02GaNcdVl6nKdgW38EFfd8HuT/SR16PYpKK6DPdTFuFFHdqcM/UF3ggQCF3kNhVNUEaOkADIhnwFjIIy7KPg5qF6G36vrSGwfimiVLB7mPX6vDAMoI8Op7JkzJazW7P3GvUgq/rnnsCGkYFoIJGl91aQ/SQtPoWPk4cnXhmSocXkskxLuolZKB/GPy7hwe5A9XzkR9OqxV+CJVg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArtkBdnQP1SnJQVpdtRXp1V1Enqo/eSVr2lYZFJQvkE=;
 b=RvZdNzyFB3flHAwdWBwvzIUV+vpewoNca23/JOO3Ca1ZcC6UwbntahWAjsVsorIRm83I/hMAtsEL2ay9ZWoGRlLKkNgiihqa6bPrYLtM8sDLECDxXYEl7NIK1VgBDrk/25BjFjRKtXzN2eVMgdubECMmJb3FddjhY7COfFpt7bWyGgNy2tWrEsafkVIOxFslwTHgF0IpktHtV9OcjL8rTOJelAKFzw5fIcLhxy3PPZpwigE/PzT0QLXT4N4RmFMS2/dBsU17LshAa+FUonC4jFPehnSrR0dZvqeqE+ve03XK+3/JwbRygTSqknnGvAnPhLYM6dpT+X+tGr5xwfR7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArtkBdnQP1SnJQVpdtRXp1V1Enqo/eSVr2lYZFJQvkE=;
 b=OIQ0LEyShjvpFg75a00ru+J073nxOTjkjzmPEkTFRzQreT8M40fiWuKdlzD/SY0bu1q5ryPim6CfR7d4ejrXD30Jyl1oKUDcbetx0wPCBO8aPvgljHxJEhRFim/HOehPzut75KLllqgyfiR9miXEDihP5eB7iE4Na9vRjEZMKnM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6931.namprd04.prod.outlook.com (2603:10b6:a03:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.36; Tue, 22 Apr 2025 07:21:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:21:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "cem@kernel.org" <cem@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	hch <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "hch@infradead.org"
	<hch@infradead.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 1/3] block: fix race between set_blocksize and read paths
Thread-Topic: [PATCH 1/3] block: fix race between set_blocksize and read paths
Thread-Index: AQHbsyR7N8DJbHg0wk2S0B6jXqzidrOvSCIA
Date: Tue, 22 Apr 2025 07:21:49 +0000
Message-ID: <3mfxyyzkmrgkq56nrka3spdkwa5xujbr5qvplm22cvlnnbjxga@byhmaru4bbx2>
References: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
 <174528466921.2551621.8887101746798593171.stgit@frogsfrogsfrogs>
In-Reply-To: <174528466921.2551621.8887101746798593171.stgit@frogsfrogsfrogs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6931:EE_
x-ms-office365-filtering-correlation-id: ab8d601e-92be-468f-e50d-08dd816e58b5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8jIGTYmY16CjDKRM9iZfEG//pLd8jUOo2ts0HqtN4dGCTVnizX6RvK2NGr0x?=
 =?us-ascii?Q?JY4ko5XvpXNi4qBMCODv19o3qDDcpCRxBu+GH9Xl/chW8fIBlW3bt7jgywT+?=
 =?us-ascii?Q?KYv+XgyIgIbtfhHMBxj42HOgsM7njBh+K+Uputh2/GBUyY7hSq9ey6O8cY7n?=
 =?us-ascii?Q?0sm//XaFXki+YQ6tyXIvNVJ5RsoI/ftajaNj6TdotLATBhrRxhS3eh9fJlg8?=
 =?us-ascii?Q?bOPf2rebUX+tsY2q6w+eFqExILlL6YtkRJpZz2vMhO/sTTubK3F7gTddlfyH?=
 =?us-ascii?Q?+gfHjQ/3pBTVrrbBkn8eheP9pboYmfNjidu3DO7BFlKMDYlI86pMLEEFjHmP?=
 =?us-ascii?Q?EuDoEsMaDq2LZR2AC1guPTysbe1bCunV4RCZkbJZMSnMBeF9gqtUFGhGRa4o?=
 =?us-ascii?Q?hqbNh8LGKTYNNS6yR+bZUmCC8h+G3A8CmSJ8rk1pzj0BpcL95VI4vEBCkUbZ?=
 =?us-ascii?Q?H+WYKOv0OjA7ij2R+xEkhqatzIQy4MwqYZO7kiikWVIQQqEX+FctWSU0oHY7?=
 =?us-ascii?Q?0Irww0nSiw7hZNurRF9DbL1yvPWYUWQc07McW0JRMeZBFhFuuiwo6YIyzGU8?=
 =?us-ascii?Q?z929qiz1ZEw/f/dNGpz+AyjHGIuwq72IALVCkZH8rWdTvbPJviWGwKYWBb+f?=
 =?us-ascii?Q?/K4cBIOFmrXzWP1QfJLdqGRr4xfMTOq+FW+yAf2vdvx/BSyQRGFboLDzjOF9?=
 =?us-ascii?Q?QDEr8irOv1XoLeX+rsxBlENfyUgjhAvdrO4JmjSer39DuWx4lTtj1XCqvj2y?=
 =?us-ascii?Q?ndw4keWw2omQ2vPE9iYhyz/4STjUuYpzOI/OloBKFzLcAYh50/2FgCHTUIDL?=
 =?us-ascii?Q?2OYO5GMzLW8k20fG4vnYdORn6dZFUxPHYQjibfyk8Yr9v+jZY7vqmvzL0cwU?=
 =?us-ascii?Q?p7Vjj6CiYg6UlRH5VGi0M2y4QWwn2ExnNVRqcrw/FAFDiJvy/vml/V4+LKcx?=
 =?us-ascii?Q?Ve8y0rsBcWF7MhOU0fwqDMGTeSY8oDr3Ptcq0yOG1V4fR/ED9TtOX+5zlgVa?=
 =?us-ascii?Q?3XGVtDGD+e2G/VCEnDoPi2BDHkkeb5bR06GLUj+kBgZFKtoAqaLq6/lHkjCX?=
 =?us-ascii?Q?qpFBv0q24bhorSJWA7KMQJN8wGyvqYWak+i9zLSBlOtqsmkxgl0fsLf38cl5?=
 =?us-ascii?Q?exLCdaMgHSu463tkRUCFymC/6YvhgkGbUS9dega5tOmLbGuPwnv/YrN39iCY?=
 =?us-ascii?Q?umW6b3zoMeEKn3GkFhZt1BHIlTkaTwOQVn/JNuToaIo7NsBOtKiHb5IyTn6n?=
 =?us-ascii?Q?90JG1DYAf5TTAV5FjiSuyF/io2flEJ3nXPmfGQe1QUYQUTxf+wwMwFbWUuAq?=
 =?us-ascii?Q?MhQcIpLj3Q+sK3kOLuCjF2h7Gwqh9B1XKyYfmbc8lxaES/MWYacaWUAC1BpF?=
 =?us-ascii?Q?yDX46mLj4rcfri1Cn9/TlB9kiaoUgnxvfDOeiiuOmCAm9OV+7yLkHoenLN8q?=
 =?us-ascii?Q?AY2HOsBB78z/xN+ab6H2vVmgpdOAMxN1pHTEove7VlyN+otw61YC3qdXt/GY?=
 =?us-ascii?Q?VxJu6b4zIYG5nFc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m1J61nsz9nxeTCJcYatqQsTJZ0KX2/kWoTUsvt7bCDb8am7GxwkSYq5PgnUi?=
 =?us-ascii?Q?idtcSSbdmRdji985+Xc7vWd657u2Jjhvd+4SdI1s60LBsydnljbAAiz3DSyc?=
 =?us-ascii?Q?oOL3F/K7/ouwQ0VLyinPmDWSpvouJmWpq8oiz3WTl2tiot9pr9iq2YKZqAGe?=
 =?us-ascii?Q?UuDcGWFwyt6HVq4KecY4IQXdNIM3OryDyMq2mXGMJd1iXLwRQXrZ4VnoeoLx?=
 =?us-ascii?Q?sERUPgzMsFTibGtCGDqdRU04NEgY8sG3a5aSsDeivvr/K5KQNlF3W1GGugI6?=
 =?us-ascii?Q?XxBmZ/XBUhbTuQt/vCCRW/DoEM0cbRI317a5fZGCShH6I2Ek5oi+ljUoRsw4?=
 =?us-ascii?Q?RrUSjDEpD/8Vb2i0rwwwHDynJTERsUL9fxnuPPAtPAlTLE3VLZoP62DxvNgg?=
 =?us-ascii?Q?iibUeFGjbHyvQnl/cX23JXKJY0CD5jEGH3392lq+RK+7h0VB2gDDphD352tu?=
 =?us-ascii?Q?Hbj0a19IRWrLaZz8WRbxdKZIuUmGlQGT07SrOnL1oUfmRuNpeMlGdAg7pBnO?=
 =?us-ascii?Q?rLmV7+TVgYwg7si/MOTzsD24/RTMONHsPV0OW66kqUdoBiveONOfmw2d5u3r?=
 =?us-ascii?Q?KWc5tlDH3HKkfVuQ4cc4lYG28e+BA//pg3L69ta9XT0JUS/CPT2NMTos69s8?=
 =?us-ascii?Q?IfJFIHvew6cexC9EyRpSdMMcOvcAnu9czm6VEqq+Fme7OPirDky5bIWK+nnG?=
 =?us-ascii?Q?Z8ZYIZtmyHl+3VEnpvrmrXUeS0HVSZpExRI1Oq+m5/xw8Zz0fcNmWC+t7gex?=
 =?us-ascii?Q?x8NFCe5uppQm0PYLWBI+FxwQSMTkR3JuVSPjF2Ko17+xfF8K1bQUJRSK1zhU?=
 =?us-ascii?Q?8PESJnGzm5+442iwF3A23LQWqENauna+tplwfe6YHXXwOVy/aQ9u0waZbhDb?=
 =?us-ascii?Q?Vn34+UQZT04L4LTVPMEgDAkfLtK9C3TsITzZd7XVFypXnkjE3UDOynJWoY6H?=
 =?us-ascii?Q?u/uyArBX+BJXcxl0FPIlVbb8AVDA34Vaqzb3FzILSixnHvIvB9jb3WVcQ/Hz?=
 =?us-ascii?Q?e4tr9e9MIJwlzenY+s6iChF+0tPMoiHI6IM9AkPyoAJ9QDbz1OBatX29GpjX?=
 =?us-ascii?Q?bnFdB/6xlP/QUpa1euF9eba3VL87XEbLc5u6NvoeFEx+3Km36XiTkv3FPaZC?=
 =?us-ascii?Q?zLamzrIYn2LeRPmDysPyHs50fw87m6nTR+UM1nKZ8lUIYs5xM0Q68sE7Fyoh?=
 =?us-ascii?Q?LQkvrr90XVPy8d1yi3Si9teRYAhahvCLDtau2ZFse6llb71MSBzJeJIuv7T+?=
 =?us-ascii?Q?+0e/Onlut8D0+Xkgqj7KQN8Snk2oZPlwF0PwK3Edok0/Z/jdO0dQ2RT0YdYU?=
 =?us-ascii?Q?ANsYL6T91Q7tYmqkb9PJeziZIwflMqSgs4cnTZPiKihZPgXg2MfYUiy7z4Fu?=
 =?us-ascii?Q?HwQR9bU1PqcWY0p0xp07uLhN7XdCuhH/LNOHbBQTR2kPEHuRzd59BADdRmAn?=
 =?us-ascii?Q?+1CYHRvH+zcY7sLkQu7aVrfWiCigR6yiLuhOUMDnOWxztWesu5wD+3+b9TIN?=
 =?us-ascii?Q?CMRFOq2446xNL88sbAOW6Rjv/0vMHpToK5/UijchLc+33i1htxWzgBrM+GwN?=
 =?us-ascii?Q?UL6m3yrhLdsvmGyNfWQIXllj84qn8gN7G1bDPpMh8qSvrIFJGI2U33s68tbM?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F1EF0F5C3FC7F4780F7AE01235DD2AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Esifmbc/BhZOzt2kE1Oejyn6dyVAfgvYWutR51Mpaibom1rHRNt/wS8yzP00M7WmlKDogEjPQOnvSyDkCjXDupBcPWa+7vk5SIi6w/DrtDgedQOi+RrZZKMQTOA/yImqsvisi50JjSSxrAawxX8Uame5Ocy6NRfRTvgH4aSfNU3YJ2jUvTn5JsZn7mijkehl/dG+fI/EO7IBbTZ131n5Z2Z7LWqHpKWWaFCH8rnch0h9NbWvnYRsuKFLsiMZaGfEQ+q+wa27KrDm1TB4WT1FiTG+F+RZ0wmCPZVFQqFL4W/QqF5q0bgEU7FQsUSvjU2LaGiJvHP7/hFAZu6Hj1+7ApDp1npfiUWJ0ux3WZUqV2mnK3W1pwKgB1rYzX6MvIubxTX5NULbjyJEVuQ3kKEAe1bRGfKbHHmF9tLz342164LN76l7Keb9agfnkTvFraM/mXjshF0vtU9EtGHOpU0lwEYc3zNdWSwUXUnyr5x17BjDZBCU+pmomUFs7JzSIX4QxdY51BowvoGu8ucMbq07MzSqmn3nqjg/ZMb3kF1vTPMUBhpwvNoDNVm7eVa7qakdnIapccp3jHsWV3Lr8esa9ZTPb9qdQwIasNQVzylDtYywMPHv6ekr2Syj+oNX3pF6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d601e-92be-468f-e50d-08dd816e58b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:21:49.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Om0unDwzURF+c+SylRcDxyT3kHprzFxAQd53pJi/YoaMBs8/8nq4DR/eCVZwc3i4Fc6xNG0XUSBCh1sXNbREb/aNUXdG8BPWgkFtGD3ABU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6931

On Apr 21, 2025 / 18:18, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> With the new large sector size support, it's now the case that
> set_blocksize can change i_blksize and the folio order in a manner that
> conflicts with a concurrent reader and causes a kernel crash.
>=20
> Specifically, let's say that udev-worker calls libblkid to detect the
> labels on a block device.  The read call can create an order-0 folio to
> read the first 4096 bytes from the disk.  But then udev is preempted.
>=20
> Next, someone tries to mount an 8k-sectorsize filesystem from the same
> block device.  The filesystem calls set_blksize, which sets i_blksize to
> 8192 and the minimum folio order to 1.
>=20
> Now udev resumes, still holding the order-0 folio it allocated.  It then
> tries to schedule a read bio and do_mpage_readahead tries to create
> bufferheads for the folio.  Unfortunately, blocks_per_folio =3D=3D 0 beca=
use
> the page size is 4096 but the blocksize is 8192 so no bufferheads are
> attached and the bh walk never sets bdev.  We then submit the bio with a
> NULL block device and crash.
>=20
> Therefore, truncate the page cache after flushing but before updating
> i_blksize.  However, that's not enough -- we also need to lock out file
> IO and page faults during the update.  Take both the i_rwsem and the
> invalidate_lock in exclusive mode for invalidations, and in shared mode
> for read/write operations.
>=20
> I don't know if this is the correct fix, but xfs/259 found it.
>=20
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks. I confirmed that this patch avoids the hang recreated by the new
blktests test case [1]. I also ran whole blktests and observed no regressio=
n.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[1] https://lore.kernel.org/linux-block/20250418075431.1851353-1-shinichiro=
.kawasaki@wdc.com/=

