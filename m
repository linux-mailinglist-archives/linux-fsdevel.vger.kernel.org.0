Return-Path: <linux-fsdevel+bounces-46906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF3A965FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8491D3A3898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCF1DB125;
	Tue, 22 Apr 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VHi+rhSq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZOlQbiw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6D14286;
	Tue, 22 Apr 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317915; cv=fail; b=U11E5qAXZRsU0HBqp7gQJGtenAmh8CFPsmX35jFL5gSdbOK79WYJDEnQS1NPJxRNR3JPSmTm/ov+f77gJK9Z+SsIra3w1mJqitNPtu+tQDazDLTIu0RZ/KjGkYy8tGNj8z+UQ14y2Ymf/hyDudjGlnGfdAkMg6R03d9vJ5Lndkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317915; c=relaxed/simple;
	bh=VvgZzqAkdHMLpQsnzCQe2UAS4YFOlpfFCZ5dugNziAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmb0WGNX6mWDSRKcnO8xaWIc1uPLgCt6p849JdcOoVLD4hIHq8OyrG4PbB7Q1LboJRalmhhPDv6T8yF3zMF6N0EhSKvoGf7TslrGrqJha9UoE36adI9qzoaFPzJDu/TZ7yoGp4timCHojSorDOTwe/A8VaptDtN1rJMuYcGeICk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VHi+rhSq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZOlQbiw+; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745317911; x=1776853911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VvgZzqAkdHMLpQsnzCQe2UAS4YFOlpfFCZ5dugNziAY=;
  b=VHi+rhSqIsNYRlfmrusWCrEMHnMdafyyprttMtQDOpvF7eGrKHlcYNZP
   b5+3OtAUFHOoMMIrJPVB3vMYXrUQYzd/Dyom2sNqv6pZ4e7rQTyfEyMpB
   qh6UbUi+EFP9KVFX3XTY7fU6Lpz8uNYgwPEC1iQ/WB9RPO36VWy9LA/qV
   NSm3t2jhnHncxv2umJqRkSjCCvtJPvl28fw0WeoxkkWWnUs3GwQ4HxuHL
   h8wmCnol0x84Nyhvn0WL8MpXqPAW1byICIRJyTY/8zIlfIgIkKP2jstMv
   MAt3arnJBPAlkiqLqYnv6x7mYu229zXxUyvbX8rc204e2IjtDyOoTFwAZ
   w==;
X-CSE-ConnectionGUID: KU4Nxe/kTAu0NVAk9c55oA==
X-CSE-MsgGUID: h2e3fYU4Sxe65db75W+F9Q==
X-IronPort-AV: E=Sophos;i="6.15,230,1739808000"; 
   d="scan'208";a="78945394"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2025 18:31:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynS7hUtfta3kp9NtOz875irbeTLPDDYl33arb4aR4tP2yp2DuyyAhAmYBIg9P3tvPxwK3o2VFeg4sC+gL84cfwTrda2X0cESwwvB34+JtVVPVCoIhG87pwZZVrgZ8oIlf1XcsYiQCWiXt1V264YtcErOEmJbtAS+clRGjg7clAVgc7h+e7wC0ewIg6a6zD3CngCYe0yhXnhAwC61hU+MQEq6Q0VzF5oAhW5Isu2H/ri62cRuefZd9YcvCBX/VD0ZFxhtoKLHbjJWBlQJ+wD7YStnapqLblaK7vZcwjwHcaRqVXKZ2jvWN3Tj0P5t4f6UMEtljK8cyyIb02SoRLboNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiqGGcae35C+mLcqQzdiRjUm6pyET1+tE4hGO1T3jeU=;
 b=KdmrOAlhwbl15gvX0qer4+PFXMRVh4a3ajSHm953TR1zbQRW6KaNjv9aNGpJkyBnLnhezgIgNfAy/6DeK9ZJ74qJVvRBjg2+t4No0tfb+ifQ/xF1NtSd1yg8XcrY/azBGPnBDnZ1Ofg5p7d2YH8Cob5YpmTTDMUDbaOg/0mHkPqYH1L275z+yfRYeiDkQ3TVyYpSyFdW2XUZyvNwWceo8TOy047mA18vQl6kC94I7AIlRifGnNpxjuANJEtV/FdfxzNXm4zwVrFPkBjedf/psN3bGhOrzylkuXjLmjcqX0XK3yFKXKbdlJuHLxqOW+ABvaVKQnIhir94J9KN4JKJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiqGGcae35C+mLcqQzdiRjUm6pyET1+tE4hGO1T3jeU=;
 b=ZOlQbiw+H86uKruSx+vZ8yOR27PbkkCPno2aoDKLgqLRGFipVV+HwyKYCIJiL3i6rDgdQTbUyC4ccFUIWCvGztdfubJw5cLs5wjYodoUKKe+GocXAy27xWysOJgB+da5yB3VliJBoScbKmh2C1xVgmUtzCjBhwfzqq9axtMiJqc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9449.namprd04.prod.outlook.com (2603:10b6:208:50b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 10:31:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 10:31:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: "brauner@kernel.org" <brauner@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com"
	<ebiggers@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Thread-Topic: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Thread-Index: AQHbs0PcHgN8MfumQUyoh4YWdFd3xbOvLr+AgABOMAA=
Date: Tue, 22 Apr 2025 10:31:40 +0000
Message-ID: <bnjoctedmq2xjsvwfcgk2rnzd2jolhidttziotcbnm6vgcmwkg@d42m245kil4o>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
In-Reply-To: <20250422055149.GB29356@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9449:EE_
x-ms-office365-filtering-correlation-id: beb9aaa4-62cd-4013-3d67-08dd8188dea4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lWUx+akjbCzDQgdutYD3sXmdPC/wLHSEsfmb0EqCzTTRjJNBaMAl9oLSpf7y?=
 =?us-ascii?Q?308Rs0sHLWRHm7ZJnfBom9QTK3i5wIqSRL2Y6WgLQ2S2splBJMGdSgKP3Xjr?=
 =?us-ascii?Q?Lqp38NNI37zI00/5PrQa/YzCF1bSYU4tnLpLwBjCIwUjVedJ+HPwCkg/8lcf?=
 =?us-ascii?Q?0e/sonAqUIWBGGtc7Nr00Y6jpsUqUAFGjBU6QWFLWpqfCybH4G3h9FVrWWic?=
 =?us-ascii?Q?e9m7hDfwJXMaZf9yUzvAa46DbVu5GfRhjGjbCEcoiUKJibKFDaSx7oN5u3Lu?=
 =?us-ascii?Q?adtMk7GAwdC0CoiXKdODV44oyP/Dy4UhpRBWuXX/9siT6rE6Iy5PNQnYWIRr?=
 =?us-ascii?Q?W/caSBZB63PKME+NtVTXXa83JulzdJWurlxxCJPDmM3AqAo5/sEoupL5g1e8?=
 =?us-ascii?Q?QkL70nCW10J8LUU7BVP3nyfajvDUuX/znOQDECqOKN4Qcj2dveWMsG7T10RX?=
 =?us-ascii?Q?0RaVUD1MaXtNzIYsVoSVY/DL+xMltwnTYT6ccJKnyVyuHVUpvyhcWnlzA/qn?=
 =?us-ascii?Q?1JvbVDaRklc5ze9kFbtWEgIZcA7RCJzPYeNbbs6Zj9dSAHtaL7AldSfMY05R?=
 =?us-ascii?Q?cQ3FRZ6ug9fAPOMAQNjKh28cXKLE9zdLQO4GLK1KXjqtx9BJWLXgJwrGwxGz?=
 =?us-ascii?Q?B7CUJiwpLEOQURCu0oRM6QCv59tePf0neSWUXTlXR4widLTKRUejTlfuQIKq?=
 =?us-ascii?Q?f2O+Us9wL7dahHYA+X7gtzFAJHeue5fGCe8oe1x3vkbVBncCb5DvgyYrGWRp?=
 =?us-ascii?Q?Iw28CVo7Kx8qZM+wV0inA3EiC/6r53Vbgdb5hqzRkJ3hRiu3ejTAy5SJO/DW?=
 =?us-ascii?Q?s7VFz5/eZ8uxSJAna4Un0sYEE18NVICc3V2gtE0t2MsOT/J5MBuFMWEwEBwb?=
 =?us-ascii?Q?ThL7rFN82COgmdpLmHull1HqjCoCdSRbk2PFSFl4NlhLhnqIw8fLOQD9t14f?=
 =?us-ascii?Q?HGw6b2RuwkLu3M19S4+V97J9gf/euGbBuvLBDevJZlmqPIDhCamPrU6Ar+Ds?=
 =?us-ascii?Q?Y6L28Ejp1Ai7PLV8sQi84IBLbkZt30AQHUK/cqfH2GqJvCb6uZN1J6Lj6qMr?=
 =?us-ascii?Q?tYy0LcRRu+IFMmHVPY++T6i3v2udr8r13+Kiav8NdTRjEVpHNk4oqZ9SVV68?=
 =?us-ascii?Q?YzAG+qPUwWuC0Mx0Cpt0VqXa41CkvVxS4c2Mmxy6nnWJu8XZcE9YpWlmsaXx?=
 =?us-ascii?Q?XtbLa/pWMWKPykhn50OI/kB6M+l72GfV1vsxDWtivAO2HhDY73HCYJZH6mW1?=
 =?us-ascii?Q?z9QPkWIslU7Z3/SXC4gHmSMwfo92ngysNSE79vtQbPGv+gM4YfPbQrzkxcTb?=
 =?us-ascii?Q?Ntgzk7rKQgs08eC1uFr40aeSYCsno5CIuTeI8hPLEb4Om0vnZ5Tpo/KDLMgK?=
 =?us-ascii?Q?3xFKHp+SKaiT3jFwCdFD4oW3hLurSh/ggc9sFN0NPj1dj/KC9IHX834DR7vk?=
 =?us-ascii?Q?8HCxPoyRKbEryyYl7Hv4+mvF2VwoMNFE4gWHrP8gBht4XN91xOeMzmvSQA7P?=
 =?us-ascii?Q?uG+ERLm3oF/k2Y8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?raZWMEJDKu7J2s114HAvJ+dvTlvhzuAig6UQmch5X1o0ntDMMEHQckGY8E4D?=
 =?us-ascii?Q?qCeSPNwcCilk7zjjq9WGBsBxnKw1YUwP0tChg5KKPZEc8VxOephO4ahVyhin?=
 =?us-ascii?Q?Y1tfum5r3Vfv82k9dYRoPZEeV5janeoLtSWJxz+yCYdLfR9vy6JzoxDQI75R?=
 =?us-ascii?Q?0lqJOqMZ7NlLNFwgK1RBwY67gz6Hen0WijVKuS3uR+bB4l7BYtA5mIJ9+IuN?=
 =?us-ascii?Q?AMIzlDzYNxTTFUYOeAlk8nNVRb5v5M/ZY/eV5l/Ee8f0u7iTtEgcrgMcUDrr?=
 =?us-ascii?Q?EUEVX9fVjEjjghdyxb9n1eAJiahs8MQGHNBFI6ihs/PUFWUKIVf/INixVOMG?=
 =?us-ascii?Q?SGScSUQVQUVpAbw7faVxUvr80RsBR0FYq99uSc/7BgjYox3/4RlEdfrF0y1g?=
 =?us-ascii?Q?7Zi4Z9C1ZOnK4pavYHoxc4/mT44RX1mYzPYRrlM3yqyUvhFVfp2VIXivnkac?=
 =?us-ascii?Q?A1/k4YFkurrUIhc5U0a/CnNsV7r4gEJE+DIOIXGUyORox913by2gBNcf2WDP?=
 =?us-ascii?Q?s/yPm1FCnIFtSWQK9UR+9Yy96Lgd59Dy110vws6Cyok3k4nPgBEtGiG6WskQ?=
 =?us-ascii?Q?KdpzBwBsXfJjyY00WsUHQVeqnIJzzBneDPILHEAExzca+em+ev+fZYs0WI9P?=
 =?us-ascii?Q?cnC/DoE0B1qjMe1PdFA/QZmV83XGt0WG3OFOQx84/kOtpoNEuLSu79bcbzT9?=
 =?us-ascii?Q?5z0PDhKi1ak6xAR8AOyBxjXp2iqzPEQiv6OhdJrkWOIURfIsqL6SWpYNBxHB?=
 =?us-ascii?Q?pIAWKchGc1MnDzZQhB7AShbi1VLTn8trH33ek4l5YUTF9UsPTp4oOO/2ptDU?=
 =?us-ascii?Q?StLSbvBTaZsrvi3eD8a68yiLeR9fCkY7nZza1hX8rN3PIAj0aB5S1KMTxlbM?=
 =?us-ascii?Q?tvQU2+L9VvkC4gMqN+WH/Pn5aTbpTYEZHFl3Wjzw9NisA7z8etwKXFh/pqxx?=
 =?us-ascii?Q?sKU+unUadAf/K9LXYEm9g+sMm+BazTSFbqTfhKY1IDxVufuKC+GiL2vvSaAt?=
 =?us-ascii?Q?9v+SKun05SuzNEjMUOYRuMqh9LMs05UHbPuZl4oHRbJ7aMW2dJ6j0DOZZ7k+?=
 =?us-ascii?Q?wCwR8lr1RH1qMw7zIiYdZnSGUzggihFfnKO+PVGYa/ryonB+NwPw5wJMBJgA?=
 =?us-ascii?Q?8mvGsOrt/F6R8gUcUWft46SE11iM4y7A5cEctoPS+Ahz/BjiXb46B+nxwqT8?=
 =?us-ascii?Q?zGEYRS+WvkXqTevZMTewFeP9aaRsGvoE9YDb9HxOMAf9v6ncIE5MWe/32El+?=
 =?us-ascii?Q?ePa/TA+jp5bBHfPj0QOrpMRIZRDCuLNrwpj1ihYD9xRmGQ9z8kQiRC2kygsr?=
 =?us-ascii?Q?rrTOHQnVRk7CNTCKhXHvxwAj8bNguo08L3chr50EFWbxyNMtBP+uKmFMNNyu?=
 =?us-ascii?Q?YGH12Q++2t9Coj3gZcVcRnlDTPfX8f7F8Z36BYSbYRh48ncQTR31hbwSTmb6?=
 =?us-ascii?Q?7WwE1wgXKetznaQWgZ5/TovSM2PzIsbPjp5Isu09EKrsZCDz28y0Yfmk5yYr?=
 =?us-ascii?Q?leEZxuL9IrqryCXR51GwphVdaUK0uxKoVqilQl7hDSMda+Pk36KspKTvvDnP?=
 =?us-ascii?Q?040Yznw5BH9bwY/U5M3fWWnmTN8/52L3OG3ZxkEoZ66Qf+tL7+otm3cqqFmV?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEA81BC064663F4EAB8A164E7946F1CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JiMa3Bil59Xi5uTj3Ij+D7xx+Ahv6OgjiPpYzjBjqiALszmhEWxWyylBTCyRY6aquO0EHNTDOIrQfIC172iMeiITHn6e3QsKfpF4GgRcB64ftxQRFVhUqkSFs3WC3pkxDqTay2Jc9SB9ncZofcgcbNRovLAq1/uFRLcTwrgunOItqmRYGVRCJrWRQxmECmW91fBRplE05q9Td9LfIA/8jguXPTIJG+oIU90QgHNE3rAFprKwcMYWP9gBpzH3CuQgFDB7U7JCSRyBRZCHxC90bEJTQ0jgTpja+KO8NrE/8nmK1JwHE1ibzZgvhv2l+GRtWxuJtx1flUioU5q+R7mNaFrU78gOF/KZ3im2bcRSpbIUp9iSJMyHkIN6fXJz6V5VvcmLt/8bMoykrKtLVnVbU0BkT4ymFIqJVRkaw5ZN3EkOlcfHunoJ6rJG3NFMpZ0SpsXfIh+NiVG9dT3JAm5+MBxyjqzWnZkwWrGSgTByhuPBNsp995pt6FU4RD5TCxyZxeGQ++q6XyT92LKSTo6uGOOn5q67tZMmqwQAMQWBXzCle8gAE4OkbuvcTzHKOu3t+8Sqm72oX7xqKf15n7QWKru8VPNfPqlPrp9bxjkGgAtyvQOUR1kgWuluL5B6S1Gh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb9aaa4-62cd-4013-3d67-08dd8188dea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 10:31:40.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Riag85gubghl/qkY42zo24EHP2UG/pu5/pwgQzI3YTq29lV36o1Pzu7TbODvmkdk6iNixkeqcemYTj7qUh/uq77LMojdJAR+UQ8ltN9jDJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9449

On Apr 22, 2025 / 07:51, hch wrote:
> On Tue, Apr 22, 2025 at 05:03:19AM +0000, Shinichiro Kawasaki wrote:
> > I ran blktests with the kernel v6.15-rc3, and found the test case md/00=
1 hangs.
> > The hang is recreated in stable manner. I bisected and found this patch=
 as the
> > commit 777d0961ff95 is the trigger. When I revert the commit from v6.15=
-rc3
> > kernel, the hang disappeared.
> >=20
> > Actions for fix will be appreciated.
> >=20
> > FYI, the kernel INFO messages recorded functions relevant to the trigge=
r commit,
> > such as bdev_statx or vfs_getattr_nosec [1].
>=20
> This should fix it:
>=20
> diff --git a/block/bdev.c b/block/bdev.c
> index 6a34179192c9..97d4c0ab1670 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1274,18 +1274,23 @@ void sync_bdevs(bool wait)
>   */
>  void bdev_statx(const struct path *path, struct kstat *stat, u32 request=
_mask)
>  {
> -	struct inode *backing_inode;
>  	struct block_device *bdev;
> =20
> -	backing_inode =3D d_backing_inode(path->dentry);
> -
>  	/*
> -	 * Note that backing_inode is the inode of a block device node file,
> -	 * not the block device's internal inode.  Therefore it is *not* valid
> -	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
> -	 * instead.
> +	 * Note that d_backing_inode() returnsthe inode of a block device node
> +	 * file, not the block device's internal inode.
> +	 *
> +	 * Therefore it is *not* valid to use I_BDEV() here; the block device
> +	 * has to be looked up by i_rdev instead.
> +	 *
> +	 * Only do this lookup if actually needed to avoid the performance
> +	 * overhead of the lookup, and to avoid injecting bdev lifetime issues
> +	 * into devtmpfs.
>  	 */
> -	bdev =3D blkdev_get_no_open(backing_inode->i_rdev);
> +	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
> +		return;
> +
> +	bdev =3D blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
>  	if (!bdev)
>  		return;
> =20

Thank you for the quick action. I applied this patch on top of the kernel
v6.15-rc3 and confirmed the hang disappears. Good. I also ran whole blktest=
s
and observed no other regression. When you post the fix as a formal patch,
feel free to add,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

