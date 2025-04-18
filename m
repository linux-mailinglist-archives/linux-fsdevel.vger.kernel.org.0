Return-Path: <linux-fsdevel+bounces-46661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BBA933EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 09:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7824682C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 07:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A426AA85;
	Fri, 18 Apr 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hAKqYr1W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ksTyX8WI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E81FBE87;
	Fri, 18 Apr 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962730; cv=fail; b=j2nsoj1c8Z9RZ0+HehosqSukh2XRkoI+na1FmaJzHvmaTdhq8jeJTXm8+WpFbemcXzfvP74qndgeMU13ghm9//wFWnj6EjNQcNQcXZA6cM/vl44Zo6Lsw5U9cat071oTlK95Rg8qoJE9otcFrOdTpP+T3omuQsua2I42uJq4kJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962730; c=relaxed/simple;
	bh=YbGiB/0zRjk0d6mY4wTiL2kUsgHkysFiEAXQGuQrLRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gyymo9AD050ip4qFY1gYdKlXHhzuDC6QCsVmjhJ/8XqOr0S2q7aRuUewHxRgVmxyZtiY6NU2bsX9Y0ftSm0Tm3DQTXnPJ5puC24CBd1uKpz37F9Ea/FsFsM4IA8nHGd4d84pmm0B0Qu8SJqjxJ0Jx00SO2UqYZA/EowhSlClAnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hAKqYr1W; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ksTyX8WI; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744962729; x=1776498729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YbGiB/0zRjk0d6mY4wTiL2kUsgHkysFiEAXQGuQrLRw=;
  b=hAKqYr1WWsJkerP/mUic+QQ24O5aIoZpC2MB3RFZqWcrlAXr8lA4DA/m
   z2h8mU4LYM2o6U7hRgC7PtPk6CHXXOC+vPDBl92KH9IRX40Nep1DH3F74
   PDohMWW9xM5dLoy93L3AUh4PAzXEtpc/glDZrUnH2cadHfzOmJglgEiVv
   v3CrMBtvoKwMWg//Da3bJtWO6f/ULQk7TEsFvrHcoKJMHlaUaEqYUQq1r
   KzzmI3ACnHfxCxhb+F/6jRu8E9ZXEGdnxiI9VCtdQbCNsiZOIY60dYwGZ
   jcrHjhxp3EmoH49cfNsocLSfWkZmfOYh4JJuvYJOr5gUHSRpmZMgoH8x2
   w==;
X-CSE-ConnectionGUID: ntHvtkMcRiOaH3kEX3GvrA==
X-CSE-MsgGUID: 2YDW7FXYT0KPDQC6lShkKw==
X-IronPort-AV: E=Sophos;i="6.15,221,1739808000"; 
   d="scan'208";a="78576244"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 15:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnhzBIDQsA6LX1JjMCDhYFTrcf9bpTWOBTqm/IvYSrkJCGwd6lZ10IzzH3rfr0pEdlFibEhqy2MaSSw8eRIt7MoJVQaqvbmnhBp1J6I5DWt5osBpawcVAl5BbtJjA4jNdkEtX3IichhSD3y6b+3+UpsMqnTytGm7WtWDQ3yt+3p3jt2qFSAKhkpbrgVxHbhW8oogAG4Qegkcy3F4giPg7zizuVLfVdMabcA4oZqjsu+fta/KaVVW8fT96NQPICK15eBf7I6nrXs3CQrwVGCjq/grZIJHixCRZ/dD6cYvna6nsa28nsJctZaAS07gnIjHirMe+ArKyk4hcPkgzJDWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTsAsVZI+XEv3FXbnhCFrW8rYuKP/7JY6nLP5P124CQ=;
 b=ryegpzAH+LBUnF1yZWqziWq00kc+vnJTFnvUX302mNO7oYAsyLOok4tiFFiRS9PRFOyUJ8Dr+4VLDeRB6qp+nk3q8ReK5PgzKwVwRTYaZTjHR89X9bfJ+zznqnvE3wH8vXNVxcGPtrWro5l19Z5A86RbxytOkzW1VUFI/IZuCHpqqWT/+2+ZG1Uc7eJIInAGFp/ZXXzDDIpUzylyk5qoR47yDGC3cqN8yjww/kwRYVi7UVTScEmjpgviO23FLF+1RDNPv6EBifoJ+Ak6dcX1AMRxw4ODnPUeHl1FHr9mYfH94DDQ2Mrq/0xZdXUUOvx+t5RKgBscVPl/F4tOqbzd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTsAsVZI+XEv3FXbnhCFrW8rYuKP/7JY6nLP5P124CQ=;
 b=ksTyX8WI0b0kZ8gv1lq/VisunTwELc1LIZ6KsacuFPPBKpfFWBwTnyCVVgdejvC04ca/qH7ccbXC49vA6uADg6FWCXmfbD8SgPMaWxUAcsp0FtwCqWkmGbxHQ36ffI/VNZO0XJDDgGcKHyN5BCaf+1QYP9WK0lSG9whaPFzhLwQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7474.namprd04.prod.outlook.com (2603:10b6:303:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 07:51:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 07:51:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox
	<willy@infradead.org>, linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, xfs
	<linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Thread-Topic: [RFC[RAP] 1/2] block: fix race between set_blocksize and read
 paths
Thread-Index: AQHbsDbCtWI6eTqyUECKBYrRAHN1sA==
Date: Fri, 18 Apr 2025 07:51:58 +0000
Message-ID: <xaqx4eiipvlytkx2vxxf3a25zxvn2vcj7kepcsjd34x6p3iy6w@fbvjbphgekb4>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <Z_80_EXzPUiAow2I@infradead.org> <20250416050144.GZ25675@frogsfrogsfrogs>
 <Z_88swOZp_SlQYgC@infradead.org>
In-Reply-To: <Z_88swOZp_SlQYgC@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7474:EE_
x-ms-office365-filtering-correlation-id: c51a9046-8524-4d42-4a06-08dd7e4de5a1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aFWIOT9MDLY8ulhmDcbbZxff+0aH8gh6zhfUiBeauP9wm+ETpy5aQo43fwI/?=
 =?us-ascii?Q?4s3jEKkfxNQM9gy0GnBhAUBn4TPTxBB69UEyTXi5bqyCeXlIDoZ2FfTbmblk?=
 =?us-ascii?Q?zNBZmwPZpUbxR0P5S/vVVQR/KaEzsf0TAQPMWnDAY2AST4KR62Q15W2irj81?=
 =?us-ascii?Q?Do6ApCp9k5z5Xowuv2N7AfuQhwCeFw/nRtjg4jYpWmjJOm3hxxe9WocbVEel?=
 =?us-ascii?Q?6cLqnOc4D9I1U7SfKwURE3CXHXL0JVU5JDjbGI2ouf/hAMVVVvo8eHXYiYa/?=
 =?us-ascii?Q?ndjcdve/pg2982gfZQ/taOEuaI0Jyu5mNbReq9LGUfUjxkdhzeDvQ79JWaDl?=
 =?us-ascii?Q?7VVYVoIcXp2fnbMGAghO3DdHY6vvothnubqXoi26IETO93fMohm9aooEfEDv?=
 =?us-ascii?Q?i2a32GRmOUIFYA6H6yTc0hXOHzarviZfDjqNPpo3N6+nTtgCVXCGDwUFuYSd?=
 =?us-ascii?Q?reGMBSlPjLt3uU5r+9F09P06TV1LajF/0A2AnaVRghU0xmbjzjKh7g3km2hY?=
 =?us-ascii?Q?yGGmxoAHCVVwxSHoNPtY05c47It3yIwJ3PBJp/X9uGM74omkNYA1H3I2Nhgj?=
 =?us-ascii?Q?rO9HVGaxPQ8XvS+eO8kQC+rt4n/r+sDDh+VUvbnLZ5kO6X+Y0UkDIBalx/LC?=
 =?us-ascii?Q?3hXkpvsA68uH0JigLHUT2GpS8xKWOSGywTu0fTh7LhfhWWUTJyboHY95UK9d?=
 =?us-ascii?Q?meoU/L/bQho8DtzYwOKY0OQw6NkoCGTQt9dwZmabRNvDbscQnbMg6wst4pKb?=
 =?us-ascii?Q?ZhM6LKJttcly5+GYiy2109o/alskWk/HacHKm61RlFJc55gRyi8vLC35ltFj?=
 =?us-ascii?Q?8plw0aXqAORzdR1V5xy2/Icx9BOP/y+6c1RTpXKQ1IF0K/7c1cI9I8oFrzB+?=
 =?us-ascii?Q?KSr81viSEY8M6uASOqCUY7kB/3LbFphPNyJlmCtBFMSHbOByHQItotEM5Sut?=
 =?us-ascii?Q?4k9WbbnWbcN8kYRz0JH2DDZdEVhZQQ6RVmFAbqjlgDn3f0yaqduR75TtUeRt?=
 =?us-ascii?Q?GLOZ1CbLMwnuaRu77sch8fafVZtPmbkMLlbDzP6FGkPiWyvXYF9BC1vZBGjh?=
 =?us-ascii?Q?WQpoygeb7aYA4hCgZLaWAlzxUKJGSlHMh+II71iIR1O5JXfAYh8EqD9oGlLL?=
 =?us-ascii?Q?JpqkT9PMKUlRJq/O4mbRCdtP5WR7HE7pKiSLZ8eU+FAW4GRmdvaO0E469hSZ?=
 =?us-ascii?Q?ddqLMWhZaPqZ3FTJQ218F/CxrtTkhM86cjCOsdhikif1CStPqL2sVDJ3qzpX?=
 =?us-ascii?Q?jyxmMGpKmbOEz7SBKdXW7MpC0nm88c8XtT3JbbwUf+5ZWEXs7OKS99cxoAHs?=
 =?us-ascii?Q?XTX8BXbifmFWBzFghD0l1CWZfdq6tp0ubijOMv+bmcXxRq5UKzqyiGTtGc39?=
 =?us-ascii?Q?8AFFR96maF4EzCfAEMKHzl+GJS0vgVV0Fl98/eGg9YKYvKXZ8Dqs4vRG/ObU?=
 =?us-ascii?Q?mHR/dH/hvtT73Yaea/M7ndDApJFtQ/d3NQRWdC3o05FbhcJCpRrOjmUfbF8z?=
 =?us-ascii?Q?F5PvqoTMhtjU6p4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LDH4bZnwtK2lPLiS1h5oDdvq9+/yXly3LGWg2j7IDVP5w9UHdKvRowgh3TBr?=
 =?us-ascii?Q?KFskMGQYXotlkD26vO0EBTxzB9WExp9vILR2GoqZrus3ES+ALqfB5Rg5SrIr?=
 =?us-ascii?Q?4Z1VaqkoSDp9ozq3iJO9u+n35FanK1HfpIz+LG27dQbKb4G6mBYyMknj+Uv4?=
 =?us-ascii?Q?JzkTtVFZBK/RS0gVeIqmr+1BfOmo5m6huOvA8e30AnlG2kaJlQPmdS7JZg8A?=
 =?us-ascii?Q?oeyyYuYgkwa0DHoChAorr86aW0KsSkIOjExZ2sH3L6z+Ru06tPgxEEvRHclU?=
 =?us-ascii?Q?KISWIufDbRx2YxG8fvgv/X5r1Q5557xl829F2h6cLuGGl0kxRgrGU5IYOS/K?=
 =?us-ascii?Q?igiQIoPVk8QinmopV10gLbmIQQ1vZx3EcacL6IICPx2WZYgdIuZNZExZUIF5?=
 =?us-ascii?Q?nvdXI9BHLq/xBfQu/pP6JNa1OPocBGxyBUoasLLY84dMEyNhwjlMi0lRfc7r?=
 =?us-ascii?Q?8Q0t11x55pPZWgRbBO3z/1MU9BBQFJ0ggF4vanQUrDOjfiJFaFm8UBR27gsw?=
 =?us-ascii?Q?EKIg75NdUFa5n4BWIF/nbDEne3p4sBvuNoelFUvZcuWD9A1NWAP7vGed2myl?=
 =?us-ascii?Q?6AxiHEYjgfy2f4B86Fit0p/TJMP5QfdYcnWxv38HVC+7KxLn427N5biXIqpx?=
 =?us-ascii?Q?yujsxN3NUwm8CsPDK414OqpDHGaWYOYAdFXlmrA+2qm/J++wFBCKiuhbpSFI?=
 =?us-ascii?Q?vqiM1LXi2O/qJhQItOyaJUP1iCNg9P+xZYNTzsSFP6Qm0Rah/FPnLq5mJPvN?=
 =?us-ascii?Q?qxVEL9l2J0UIJXyQZorkSGtnYawwiPazGK9nJ1MzEZXRk3L1E9szm1CKeyL6?=
 =?us-ascii?Q?AeH7kKZfrGI1HIkec11chylZbLTW1K3k1VMMnqgci/BwvLa1MDHybBfyIx/T?=
 =?us-ascii?Q?bQujgoBg4ODyQJGLFpQfPZCKUMhBlNGPtTv1pFrcf7uEtZLjZxFQ9qdN2I19?=
 =?us-ascii?Q?R0JhCY7xEnvrW6wSQDL1rj73H6MaUZI2CsZBbABCWGPNitF/B+DpcSeRD9Ok?=
 =?us-ascii?Q?psjgoVfpb3GQwvoZw4WkjSEaDY4eMBO7MishYk3b548uHpD+d6NcAAc7YCUt?=
 =?us-ascii?Q?vB7Y4ZWy4UHwhW/UKx1FCFHDdYOS5jQCe2LKO1UXDcwpWVrfD1jWyS8B2T0Y?=
 =?us-ascii?Q?Rze9NuqtuJAOgmfdvtjb8KZOTbVxbyo3V0Rk3+X6L8DDVpPhPDDMuUzVhe0C?=
 =?us-ascii?Q?DaTcjz44LaazwcehLfUfxWW7oOO7QWIvuanupDthF9J05Kbb6+2UAQ1Y+LOz?=
 =?us-ascii?Q?2XRiKGsBQ0fk9+qAa/eY7pIR3T/QfsnQesulV1SxDpiOmAuZnRcoZkI+tPhi?=
 =?us-ascii?Q?ek6BS5mibLTC4PMw6cRWuYkivpY1biHugov/V73aiHieo1tF2wXKYfjGitIH?=
 =?us-ascii?Q?YpqurXCvkJiWtUpEyytgjOhUI+GW8ZWkYSgjoDXwA02ZF9Ec7HMg3RBLStst?=
 =?us-ascii?Q?AO+YwawxLuLuIhwm8XgAgjSzn30vFEnKBlrSpPe+ao3UQdc39n1padmlfA4K?=
 =?us-ascii?Q?xNjFmdfpkzPkmzJZ0/Vd6KOCgVgFljrRtKScag8Cr+CQ1cjo9aGYchK33PCj?=
 =?us-ascii?Q?6Lg2/CffxoNBgRGWf5RDdRSAmI2Zw/KinevFXD+IKKwEBDqMEbNplp/nwAFV?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3E08241F19BD940A8309CB1DF316BC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	upP9a/YjWrQqqatF9DrQu62p2rtY8uPFfjhBzyKpDpk5Djxj9gPUnAoGfB4vag2CI0/eglkxTNefTtoEUu6wO6XsUzew0o+hT4lJ96pgTdY/3dCgAiIm65LNRCLmmrvlZ1Ea9kPHYAMD0oFeYuHvfWjwze0n6eiOAe2baXJ4/07UVNXW8COm3NFe72NUVlyLaCkfFMXLa/TXbpKEiporUKRlZHU3/bGqVaYVtkCaJSSW4MNTD1W1vhlcJXGWGDrECv1Pm9CkrjvL7hSM5GKVbK9LMjBj7PRg7TB5SqmCPZXEobnVZDN2S9tODcT0x0BV4XtPsXRoQpnTJXtw33k2Q9LYvrO8pQ7GwIIR5C1l5J60fw6F6B8VUWMRFtQeoJ/y6rSG3Bslub/W5kED+Ip0NCcECp3lHdFV50PY0WRDjucFkRVl0aAtr90fis7NcJxCay6yZMT5OLIe2+1iYO2Fc+mUHMdfBO3mq9t1cR1hPCl0zycY6j3MLQ0X1dzhTLO+L8V1wvqGZqsBKTjKvEVoD936cEmMMN18QaAdJZj9f6S9EX9ddeUeB3vr3lBilsh9SqQmAKtJSosqNqFIVgNlGDKx3p9hF9+u/W4t4/26brcjt7Xs6fjjzEo+QeILUfhY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a9046-8524-4d42-4a06-08dd7e4de5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 07:51:58.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+loRo6UBF6NhHprR1gXeVAxl/anDlGxd8zKyjTZqggtTutt4y0P44PHuC5cOIFJD+7VQza86lN1755ksTyt0w1jDaJdL2JkmgV4zRwDlh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7474

On Apr 15, 2025 / 22:14, Christoph Hellwig wrote:
> On Tue, Apr 15, 2025 at 10:01:44PM -0700, Darrick J. Wong wrote:
> > It's the same patch as:
> > https://lore.kernel.org/linux-fsdevel/20250408175125.GL6266@frogsfrogsf=
rogs/
> >=20
> > which is to say, xfs/032 with while true; do blkid; done running in the
> > background to increase the chances of a collision.
>=20
> I think the xfs-zoned CI actually hit this with 032 without any extra
> action the.

I observed xfs/032 hanged using the kernel on linux-xfs/for-next branch wit=
h git
hash 71700ac47ad8. Before the hang, kernel reported the messages below:

  Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  CPU: 21 UID: 0 PID: 3187783 Comm: (udev-worker) Not tainted 6.15.0-rc1-kt=
s-xfs-g71700ac47ad+ #1 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41=
 04/01/2014
  RIP: 0010:guard_bio_eod+0x52/0x5b0

The failure was recreated in stable manner. I applied this patch series, an=
d
confirmed the failure disappears. Good. (I needed to resolve conflicts, tho=
ugh)

This patch fixes block layer. So, IMO, it's the better to have a test case =
in
blktests to confirm the fix. I created a blktests test case which recreates=
 the
failure using blockdev and fio commands. Will post it soon.=

