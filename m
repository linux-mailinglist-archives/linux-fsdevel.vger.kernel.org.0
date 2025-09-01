Return-Path: <linux-fsdevel+bounces-59774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD6B3E0A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CA017C5AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A183101B6;
	Mon,  1 Sep 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HbI+IUGO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rv8EPLZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EC211290;
	Mon,  1 Sep 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723934; cv=fail; b=LxgVNEC/Sr08u17apa+oHQBXCViDlgO+KWE/CSk6nj+GKmAglR6Mft08e5KT9LGGxSmSvjQS5Sjqr1VphMY6U146sGuWbwTcvTDHnY8u6sH3Fna7x54BYFGLTvTRKc/GzqaiSk2asz9tOnfmF2ZvT7sEHPCZceB07o0AmgDZevM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723934; c=relaxed/simple;
	bh=KdiASIkPGYvEX9GGNnKA4jt4Uo3u793SZUjfVl3UtVc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RNEXY1enmJfYgTEXcdZ5rOiQLRC9Q6adbh4L/ty7r8jQ3JPBRzCfQZbcyRZJLvpiFc0N3qWiJr6cFdkxDnT7JCP4k9FE2VIKj5CLlUvRKpXp0BH4lVGttLzzV4JCVX4Mg2eWguZO0gws7wF64tseJj1kka7FFrk+haYOxHl4a5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HbI+IUGO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rv8EPLZF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756723932; x=1788259932;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=KdiASIkPGYvEX9GGNnKA4jt4Uo3u793SZUjfVl3UtVc=;
  b=HbI+IUGOJYqu9EVSU/EjZOmdfZKEvJOip98tXtwL6NoFeLvBHwGVcOeC
   EYRoHoC6ZmihjZeK+cd0Xu4vUgL5Vx1zyCVbPfs5ku13IEJvLxh6mN6U1
   C2HoxLcxf8sioqD+yOaQbztB4TnR1V1PGx2p1KVQ5SgIvl3YvX822oCX0
   sxRQNLlDw2/PeHhJgoBeZOE/xphv8ndql3cTstB1LaMkfZQX1dKsOWKnM
   DvSavI00259tt714JdD0bJxwA3b0KaoFbNm3xbzkvA4Cbgon2A7m+6L2b
   a+BzdxKXAQ86NaDQWdAQlruyOsYtId5UQ1JdjItOxddN5bTdAhf45BBoZ
   g==;
X-CSE-ConnectionGUID: Fjt5TjUjQKCQJZU8NYbXuQ==
X-CSE-MsgGUID: R8WV0kxVSDiTsS1ZLQHUFA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106132129"
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.62])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 18:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZLucHLfYtZPPZzzHHldnf9XE+X6i2O8bH+pN8Xy7ZrLGIUPQePJrxZeliOErbfigI6GYohH/rI8MlcShMutOS5k9C4KtWsicT8OcnJ7ibl/5z93ny61CKKVrr6bwoIEg69g09tSPMk7rysiRIPDIHQqenf3LeBfsHJbcXZoDEiueMP74iSbLZu+N+bbeU+jQpkOT7y/eZ9/KrVCJQILvqJHGZEWa+UmFvqveD46Q9ZQauQDN3b3Z4nHapnwCX2tnjb252+Hfa1bVveXJ4SIaXzWv+i8afN+MFNDw1Xm3GpYqw27Y3An/Fd5yxOfJlHzHM/VHaXqcKMOuMudFPzgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9tsRJfj1aAlhOGibHUNGwHxaQzEhAPwDGZl6ErDigI=;
 b=gDcb/h8mFgQvualhbK1XFm/CDF4wxeTwte2hrTiuHIYK/kU3jUvLoEEu2vvRzHTbtuMojQJAeximIqiCPgTmFc8uJnssl/uD6gQLXZ4RNuRmdfbij6JL0XV8AHN2zBdS057w+0e5CE/o3Umh2HUaH1SyX6RRm09AF1D2OsPRAWsQphbttF9XvmzS0iPvfvMSG1oZjlUPfd301wGVcbh0rfv6fjeEYLi5g7JSylGCQyhiJUWBW52N0zLQ7cI5aNTLVMgO6/6gne0BBMvy+CbwbDMHoKfrjUrnWxTADUOqR4V6L+ggBRYNe2InCT6mkM21o3r4F25/fOnuCzTZZltnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9tsRJfj1aAlhOGibHUNGwHxaQzEhAPwDGZl6ErDigI=;
 b=rv8EPLZFFCdOlbjZd8UYvxwjgn+VVJwXQesoEoUJEZ7F+P7vKK9H3jzK91d1so1ZGClOu2UEvUKeAJS6OrahqT+82ECMoFfcM0fyEdi6nzV9qVtK600oyPBzl2vrOl5vVFJxb7C2H221QeFJLzTpMZ8WC3W7G+Gg4GS60zftgSk=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS1PR04MB9234.namprd04.prod.outlook.com (2603:10b6:8:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:52:04 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 10:52:03 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC: Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 0/3] xfs: hint based zone allocation improvements
Thread-Topic: [PATCH 0/3] xfs: hint based zone allocation improvements
Thread-Index: AQHcGy5zbtdCODC6QEuaq+L7m+/qvQ==
Date: Mon, 1 Sep 2025 10:52:03 +0000
Message-ID: <20250901105128.14987-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.51.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS1PR04MB9234:EE_
x-ms-office365-filtering-correlation-id: c48041c9-f986-4898-b23e-08dde945960b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bK0guKGrGLePREVjZryLkgTcQNkmp92DwQAozxGH1BRx6QbFg3Tb/PpOJR?=
 =?iso-8859-1?Q?zw9f6DS4sQwWgjYD5LpL7kDxxT2sCX7QYko9jQwQQhWxLk/fXby8yfFJCe?=
 =?iso-8859-1?Q?fwH49YlyDpje3psM9fF56+PGugOxum8XRbxCHGPEtz600Luklj8Hn+WQgp?=
 =?iso-8859-1?Q?c5W4tNEwTQehgZfCoDj+uMYVG37dPlNDxiGd42obOtz0rUQe+TP9UTt65x?=
 =?iso-8859-1?Q?KkXi//MSmiu3SXxMHEwk/vsPrg5ui65YbOneHYeWPpk2uLOyduAxtV433+?=
 =?iso-8859-1?Q?KPSE+GJebkYx/2hvvZC3lSsN6iqs1Fl7CFKcKe0s9sKmsGNtukkjbI3EQO?=
 =?iso-8859-1?Q?zz1xwsziNlF0cC22ibzjjrObbfVB9We8XEr6gogz8DLo8WCgAzVW8rqbfV?=
 =?iso-8859-1?Q?L3SQuTrxCuKPwErpOXOrCtHep+CkLkR0Lc428I8LNNYBvxaaPBI4WgDRaz?=
 =?iso-8859-1?Q?BiRLnRtDDFAokv7FkcNKNdXdbyqudVTKA/MDZQJTaOYA1tDaTypzOYZm6q?=
 =?iso-8859-1?Q?xmCaCwRhF3aoaQ+o2Qmocyb89mjYJmAorAOomy9iESlZ/U6i3RraibCPf0?=
 =?iso-8859-1?Q?Crob+NY2/jJZmcjqdgNPfCnrCpvGS0P7T3It3rZqNbb3ed8W4NkKm4SXjI?=
 =?iso-8859-1?Q?dT+jpHFrRko55IG0Zjoa4hDmoobqzOhw2tQjwVEpNlKrdpppz+nUjixUX6?=
 =?iso-8859-1?Q?zKOuM49KrwkB0OvmFoCmU699zZupqtF6GKlZYXHcjL0Epp5DbbUZJrbNnY?=
 =?iso-8859-1?Q?N2AEUAA6Uio9KAHegNdvP0EC93jfxZfpiARSOroLTuOJW1wUg8xhz3pVQG?=
 =?iso-8859-1?Q?iduaNWOS42S6+Nz4JEbdyayRDccxC1o5dOSDd2E6xJ3hrQuxr514hGEyqJ?=
 =?iso-8859-1?Q?3VLziPYgh1AkAdpmomJYtP/OJOqfEWexQshA1GHurgO4RKld7S//IeONcB?=
 =?iso-8859-1?Q?SeSxv2HucEDfiO37jqquBCsuGGSn2lh1bT8b4GLEjR/NXAlrCZiK9Rg+RY?=
 =?iso-8859-1?Q?SjrhFpSUcpFj+kJhOidz1H6iiBGLK7VeYY0+ZXhGyqSB/JiQF+w6NryVkR?=
 =?iso-8859-1?Q?Sz4WFE3+EimIUNpEr9O8b7PsCGPZTFhErvV1KcuCiIi38ay0R1Rb91fboA?=
 =?iso-8859-1?Q?hLb6xk3+/WwA4SH1JiZFHRI9LxHsGVn7pepeDHX1lb5dCwtLt8Kbzl/2Vj?=
 =?iso-8859-1?Q?nLIEz/dN2tQs+v9tPOF9mXhAj+pohtqfgXjoGVTckx+sl/KXPojojy+y19?=
 =?iso-8859-1?Q?02ejcJSOGJntbcScgj5cB6JlBT6Ck4E9s/FX4e2TUzvrcvq24D0y4x4HfE?=
 =?iso-8859-1?Q?0Gop7znP1nEd4KmqEbX8xsMf3kDOfxN57hrCL536pnz+nASQNcgzpt+7r1?=
 =?iso-8859-1?Q?ElAIKs5VCSDtuUIC/OuX+xJ1KxFwrQwbo1BatBk0tvm/C7q9YxRcUjr5N9?=
 =?iso-8859-1?Q?Vbugmqvhg1vqB0uP+7TCCnJX8cpQIjkRQ6p3rLkreWhz059mAoBQ980z8H?=
 =?iso-8859-1?Q?m7Z99JUBpmVFZQrC3JMqQvvJ83I/IwyIDyI93RPT1kAQnJ78OTshwgaMMJ?=
 =?iso-8859-1?Q?aj1Lymg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OvzflhW7va4GjC7QfgSXuxGkjyIyHXe1XTxQaTqB54EOWbXe7DXzT5ZueG?=
 =?iso-8859-1?Q?8Pi5xEBlqnCqYTPi4PLhor1nCgO8ilwW5+a/blFdZDD10k/7F4oSMtpvpt?=
 =?iso-8859-1?Q?hgOs8/hjqCTyVdTe//maGen8OnwGnHtIQGHWCWjlCPvzU5urxy5So/QplN?=
 =?iso-8859-1?Q?nGABCxv1Tz8mllaJ83hU8ux1k3xF9QMrRPBt9gA52rh1FqRN07WHPKNRco?=
 =?iso-8859-1?Q?+0f4omGt7MhM8tYNunwL3rgtRmHync6b8QHRxUOetGLfIySBuroCogdLEO?=
 =?iso-8859-1?Q?jzKfJB95ztCBRKIy+c4N8tjr1ai28dnFCradsVKVf7Y3H/xZU8uN4BAKJk?=
 =?iso-8859-1?Q?0LDMxNAJjeLw7oW4hfvQc8orGarMHJfQoGSPOUWfvIANiKDIQU/e0s+xAq?=
 =?iso-8859-1?Q?nqvJod/f5QZT711XVhV14/ucjGRyDhBQHpugy47jRghhT33EKx9gyxR2kx?=
 =?iso-8859-1?Q?Yx7h3UCbiVWk6KXPDzvvXWYMGelels/wKvBVfkrSVZsDQ6Sn0vA1r63GXd?=
 =?iso-8859-1?Q?DzYFXWW4ixlWU4vI/KE5juh7grZQ3cBwstBeAKsFyLZNLl+m8o5MmQVNAO?=
 =?iso-8859-1?Q?aQ5Dze1ovGf8uXZapVhNiD71x0QUcGLh4rXwKscTVmpzWNxWapcLEfItPx?=
 =?iso-8859-1?Q?zQcvdO6TDXdzUlhmvMjuTukagv9d1lGYhNtYXOzuL6cv9F1C787YKSnN+l?=
 =?iso-8859-1?Q?CtZLT2vUX0Ee0ibmHYw9gQzNa9wEMRK6X1/oeN+4daq0S+4MyviaO2Jd3j?=
 =?iso-8859-1?Q?2kVvGzuNUTYAB7vKjjOFvr6A4sPB2MNbVoKbmh2HbTrG9Kzs+Ez8Ane338?=
 =?iso-8859-1?Q?h+JCo75uCsfpJzfaImfaneL4fUzg3eUUg2Xye0/s7SAwhpUhDPGxe2Dwcx?=
 =?iso-8859-1?Q?AWLPMRyNg+ilKEdmjP1JbQwD2pMbyd1LUn4XTf4bybcob3GpgMw1n99tpu?=
 =?iso-8859-1?Q?M9+duv+B3VpUw1lrGaj+CYbG7/MtJtd3ygwKzvS2r4SGOlpdddpntD5wEA?=
 =?iso-8859-1?Q?mIPw9sFRmvHB0Fsew6BPcHnXr5p/U2385sQRdd29oDZYaWzR2rSXCRgfG6?=
 =?iso-8859-1?Q?TiGbKFfVio7cd/fbgiacqWMljqtkVv4SKSbkEn/h2EOVOM8wEdxJcKP6ME?=
 =?iso-8859-1?Q?OtjxCfS8jtglmp2XYPDZnyXRN2hUnLaV1TSeKho7NsVlHo6BXr0n1mXN6H?=
 =?iso-8859-1?Q?pgBVknO9Yu/exrL009AW2xa+/LKZXpMPokMRa0Box/E9VmxsFiosafBKqG?=
 =?iso-8859-1?Q?RehFySgve4l/QNRgq56s2IsKTqcJrwSV4W22G04L9sQHKVdLtx0SjmrcnJ?=
 =?iso-8859-1?Q?hRoLZOnIAKKDbH56KKbk2rQMUWWzFKtD4ec91beKkmkomEtiYppxHofZGe?=
 =?iso-8859-1?Q?m1KVpckttY40djZEdkj4ioCmewtucnLqQicdZEAGXN+400Yb9x6lYZRtIl?=
 =?iso-8859-1?Q?6rkFJj+mrshJadRchhfCos2y8kId1tQqSZLj2Or8fnYeSeSytkLOx3tLUD?=
 =?iso-8859-1?Q?y/ixg2vfK2NbrCEwWn+ja7gmM2LXiNJeHVUgP5yKWh2mpMcEgThzKQUvM3?=
 =?iso-8859-1?Q?sxelfvryg+nGWNsIzyPX1vMj1wEpeZFMz8jQmyrbtbrwGYtL231X41NsNI?=
 =?iso-8859-1?Q?r0gbsrJPsQDavEkZgetmzSG8NiY6WyfbGfTKx8/S+3SCrHD5pA9cZIzQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zVzrQnYB35XiWUhmdLplSasVSyuwumzSp+GirQYupxSLtfPyVacZXry6WxgONGrDL2wfdWIUR+DMYH6+Nzm4tSbxY8RCxWdxY5w/7xWSpBAbzHporwYMvs7TO886EtChhLCmUJlKvkoM8v6cgb3cWUY7DJa5OdnVS4g6MFpEFqTwr12INCCp/BFg3xGb7djUax4RuTLrn+fzGVO21bm74FFWN3TL3YkRW4vkmz7TsFD6e4OoP/3kNn/f0C0txxc4fCBc1dwQgety3wr4RZViS+STT42Ap5DhwKxtmQCTkYY9Hw98XHBI8mogPFn7dwz8bKa1Nw+FXEQ1ENIXMBesbXt+3QnWE3/ISILV5BYqbt9YvjE6w6twcT8pwi41bfvaPh3sr3AXroz1gjl3HvJU0tMqe8M+kcoxAtYehekCuIViRneqmnt3PswQi0rwVqvmEwjJH7tpy94lew4nzlVxA2ku9+pJI3+rBLzNuVXHgYgmJvShxG4wxlooNBg4op+Us7z/kJ8iFed1+O4UUNkte/Uyw8olpDX4SDFYrSiazUdfWN/BkOfdFfrnRFIUEqUJz6Iz3ce3RBxyphbK/nSegRcH3Jud9qFA/fs1s3Trg9izgCVhCPqaPM12OsnpIBlB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48041c9-f986-4898-b23e-08dde945960b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:52:03.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HblK14/MoejvQYwP0mSlqoRphzjArhiZ4w5KFuNEa9XXogS9ERoG2Cd2+NjXqoWYojnMk0LQn5LRxYrBKubNvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9234

This series makes the zone allocation policy a bit easier to
understand and adjusts the policy for unset and "none" rw hints,
avoiding mixing these with files with file data with set values.

The first patch adds an enum for the number of hints available,
the second introduces allocation matrix without changing the policy,
and rhe third adjusts the allocation policy.

Hans Holmberg (3):
  fs: add an enum for number of life time hints
  xfs: refactor hint based zone allocation
  xfs: adjust the hint based zone allocation policy

 fs/xfs/xfs_zone_alloc.c | 116 +++++++++++++++++++---------------------
 include/linux/rw_hint.h |   1 +
 2 files changed, 57 insertions(+), 60 deletions(-)

--=20
2.34.1

