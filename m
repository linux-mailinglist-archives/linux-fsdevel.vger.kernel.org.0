Return-Path: <linux-fsdevel+bounces-45603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB76A79D40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC11719E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C9242918;
	Thu,  3 Apr 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PqSyWQF4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WA1bGZ8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021B24166F;
	Thu,  3 Apr 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666232; cv=fail; b=uMK/AFCUN5H+9gpwsDeUVl6jGJGJ5iPBzjAlWrihesovircdBbkjAf0Kgj11M2AYNshaNY5UXB72cmuDnT8DSKTZSNuNbOSMmjx0fONWp9qrhM4/rqV2nKC8CFAIx5XfFuW9GzArWFhzZxRjpcIi8rjQLG6Dm74NDNCvKszE4KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666232; c=relaxed/simple;
	bh=5QyQBOy66njs3KTBwYFAyVpi4YB/Vb6JZpsAp8E2S0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YU8+PmILEQnI9rPE48bhmZ3JMFXPO1i6zoEOhTNim5ZH3jfYrggq5XxQJahPckQ17upbYFmyVLBSIybQZWqexntr5r9gxqHAxKtNicy74KBf7oJ2UMglRaVxBI7SbO7lsIhpqbVuefWpFgcmR5DtDErZZ0MKPis//c6gyf7xoco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PqSyWQF4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WA1bGZ8j; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743666230; x=1775202230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5QyQBOy66njs3KTBwYFAyVpi4YB/Vb6JZpsAp8E2S0o=;
  b=PqSyWQF4pl962m34+QSbrTCik4U2lS0wddf8dvUxWto2Foilw81qMxjb
   ircvUYXJP41mLCAy/mExvAi0E11KTz9ofd6t0LgnhUGP+iiarW5CsPfyw
   n5i3LUxDopz5ryuSQfCV7mwySFPU1x1JJJwurPXCUHu1C6+1h7OnofZiq
   TAsRYekEFLK8KmaoLsrP29mw74VamLTJ6lkMq+srfW+ANIflJk5OvXSWH
   oVv5XoYqggPsnc2NpO+YpMLzgepD3PvnuIqaX2hE/sMudu5xeRx3e/h1b
   Ql9XLAZU05rSeAnXCo8izG3eFZGB0fq1uos1x8z7qCAYUe2pZK/Cg7ZV0
   Q==;
X-CSE-ConnectionGUID: FYHOc2xyTky+jCx+hbxcAg==
X-CSE-MsgGUID: CcZ20FxXQ76117Nw4iileQ==
X-IronPort-AV: E=Sophos;i="6.15,184,1739808000"; 
   d="scan'208";a="68581921"
Received: from mail-dm6nam10lp2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2025 15:43:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux6ap/OKiFmeZKJzE7pfhx1u1jZFdqrPef1MW0CRLcCoikAGECWopBDI/xJAlQXG5VICHyZ5N6hgsC/EptKHADJpwGVCurTvAhlftih5Oa6SR/Lhv7TLOaNXXr8pTqupAOqiGkbfDr0QIUvdaTvhLdr4dT01VoGwu0+CiLgptUseaHFD3gXTf7HRCrenuIQXUnfgqIGNBSkBFTj63j38IxFBI/nPsS3pfT6UwJcPV9pDHqGFmPuc4oTECHBMJB0w/24FzEGkYYlKtQ67hUYoGYcI5TRy2ZweNImkCpoguREzCYfrPwvL0d0LW60ZXGF4anXSAJgnbUdqwB0T8U32GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL08P3GGfwwyy8Y6Mnpn1ramQNvZnALnci4Vl3LzB/g=;
 b=xUEADoXJULp87k3+3TgudEk6g/7LJF8wQwQn/z7fTEK/UBEEbrHbo6h7hRS/F82pGovflrDZ4Asgmt1OfFGfZ5kGDxJxBON/vC1FFyCMfaqZiGvAmtCDpKR+aRE+ZxIJeIJe5yL4NSZmklhCf1jHgZPQKocupkg2iYtKjVCLuhXAlq42AAqAZj51lzD/rXdgLJ1bQB3U+Rfk7CBQ4DJODMDNHWzPTLn05tJAzjbPxCZwb2BF8R5PRgJDlfzU+C0nmP2vNCNk201eJrpzoeYg7perfQrCoZod8g7A4ZeixnrxTAGEDooFIZPSP/bo3uZBp85w+/WhpVJe/wdVO9nLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL08P3GGfwwyy8Y6Mnpn1ramQNvZnALnci4Vl3LzB/g=;
 b=WA1bGZ8jCkg8sZ2o7cTJkgPlnTbOPehmPkAEzucOVBbQ2nceLbbNwICkHg+sRa/FVWlbsRVxqainWGzp/cM+yJqY5PRp+tgQFp5AqcWKcdX+3iQk7NZ5BjfN+Pigw2QLofgur8QPHE8+cgdBwRy+YwqksoQz3R8JLb6p0wwYJOE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7246.namprd04.prod.outlook.com (2603:10b6:a03:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 07:43:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 07:43:42 +0000
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
Thread-Index: AQHbl9iSuzW1B+y3X0qB2g4C3g3UvLORqIwA
Date: Thu, 3 Apr 2025 07:43:42 +0000
Message-ID: <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
In-Reply-To: <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7246:EE_
x-ms-office365-filtering-correlation-id: 95ca5d2a-858a-433c-73db-08dd728341e8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o5UexfKiS6lB5IujKSL7eGzGYVH/NipNFwzim3vUZJtmgH3denEFWA3o8VeG?=
 =?us-ascii?Q?gjAFRN0Vq+eLR2+Gp52UfOLdyuRU1QkgMgB2TMvW+uWJ50lZ9MgbbB3lNPZz?=
 =?us-ascii?Q?98/hdwKzRSyUOI2b20yNeOaG2aVx4lT5l4eic+sQ3/ZjTnhSCW5yH2lAlW2C?=
 =?us-ascii?Q?rrBkPERdHpXiyTf1L6El0yLa+168eE3+Q3g01b86mylFtVK3h54eX9wHY8HB?=
 =?us-ascii?Q?+4KzGI4ff39vPLG4C2YJP/9wzm5uh67AQrC6pUVd0UwTKtyZoOCCgjc80xhJ?=
 =?us-ascii?Q?wjLHW36RWqLkO6/wEhRdh3KMAi2GeyhrmnUqWGTBvF3lkPYLmtyAOd0WJx1E?=
 =?us-ascii?Q?B2Ace6tHvB9Yvz0tF4lLVqZ+09wV4DtENrDVjvw8/QiYRfULLroiCso4gOBO?=
 =?us-ascii?Q?K0FdP/Pb1+WNlDXoadyf6Fc5xUk6e0RxuPOoB2Fh4/ol42ya3THChO+GGV4X?=
 =?us-ascii?Q?lcKrWzE+a152LmOlfTsdxyamIVR/NFPAzPfm7XHSWV24hMRjBkmsZyiVhSmp?=
 =?us-ascii?Q?KfR33jSWTonU70gAu5iemyGX8GTpmLlRLHnNTd9djGLwj5+xNa4Nd8wCzUPh?=
 =?us-ascii?Q?mg89PMUHi1nixn7dWgFykkr8WEUJkS5gnL0oPCNC+Vt5ByrHcFbTXWtoZUQa?=
 =?us-ascii?Q?Z9bb+78CuHbDuAu8Sywy3T066fJTERqNDs/M24N7kyiq1pbjSGYSxK5bUsP8?=
 =?us-ascii?Q?OD7GGwEuNsM41/ENMnP/UferSHb8P5oSbNwulPnCg5kRT7er4GlFCwCiLTQ6?=
 =?us-ascii?Q?Wdc4DICzSj3DSdj+uieNIQZAGPAIhvieYZRAsViI4Kd9PK2J7UyN5zX35hdT?=
 =?us-ascii?Q?lC3wEfoPKAbFuvpwiCap588MDm2L5K+d5MlK1Uqyu3OJqvbK+6i4GxBHHKd9?=
 =?us-ascii?Q?m0cK+kF5BzN6NOdl8IoOKIifB6NJ2dEbIxT2HesYDMhdx8QOhoWgZaYqkYiT?=
 =?us-ascii?Q?gselChn9yiIiHJKL3QkmGMmk3FkcA3ESKUTVQ8sgBnoJA+NX4L75s7tBnKun?=
 =?us-ascii?Q?9UYD1/gIHbzJ4RT8hhQ8Fk+dIKJ4H2Aei/RRZl7AkKMKLPuYAhgATrZ8S355?=
 =?us-ascii?Q?eRJBkkM4Q3ghhANA+WlKkeWi1FzJHd/CUXw4VA0DiUieSU25PXyN2N71QDzW?=
 =?us-ascii?Q?UJ96tBW/aGD6DJrvwtzQ21JY6zWdKZcV9MXf/U/rPMQ9txPxZ5MgH0MsEvNL?=
 =?us-ascii?Q?QnLIK6DS3nE1TlxwJB7W52CGz7k2hWMC7Mtu2Q4CeUeIlDK0n0rDqRR8slUC?=
 =?us-ascii?Q?zNDUmyLtS34ZUAto6PayU61drkP5SJLMP0KjXPFRSRWkHiekiBWjTggbIwus?=
 =?us-ascii?Q?YRRFKh2mb8KhB28aPwhnUG9GY40K7PVaGumy6Xs5Bd+hglygfcs1dzXg6doW?=
 =?us-ascii?Q?TAXsg064cfsSI65utnh5rUS2PF/FJcPGTdXphRCK1F0soD3x5jQ41ENZlB89?=
 =?us-ascii?Q?f/zsIRc52xc7WzmFIUueOuQb8UT0FB5M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AE4lfuM9YlwDSpHykt2z5ek6u406BTLTSxYSPNOQ2thQqk8eowGc5WagjsHI?=
 =?us-ascii?Q?6x8JLBwFPw+ASZXpAz2lRbQP+f7Jq09Wzn2sV7iLSBHVV3VS1dURkbM0gGXf?=
 =?us-ascii?Q?QU/Lob5TDlV8xf1L47yGU/cLTitZhGs2z8Eu1x/DU+wzo9tBLOJUGWH+q4vG?=
 =?us-ascii?Q?PTiW2so3LFuTAuyRiHQyAGeh+BgYwdIUrrkoWyyIuDa8IrnZYMAh2c0kRhPB?=
 =?us-ascii?Q?iaGYW/Lj+7H75LGD52YiGmpnLmFLqGnJ7l0gHOySZ6v4HpR90QCewFvUyRJN?=
 =?us-ascii?Q?d9bq6EnKGd9XuCW1tYXjbGI90w4/7M4KYP91VrKCCAjSqt8dWWiHdbRxxjFr?=
 =?us-ascii?Q?/bS4idN1BIgcOIN2HeOpNWd7IrPUBeFQrfz1ETzJMKCiqIecbwxLjH6ZVm7x?=
 =?us-ascii?Q?5/kvY3r42AhdvrabbZAsJVWRX7LNkcynAs3QUa1KIoQkkBviIBinxFhD00i0?=
 =?us-ascii?Q?S9ewRUhKtZLpEas+hi8HTeWsfZCCCNQlJTRF2DMJTnM1j4A2LJHAFLYTxoNT?=
 =?us-ascii?Q?IcdJUKH2hDUbqRRp03n/biXPbk0vbSF5oUAwg55aHvN3brUlwhRb9SC4MPYr?=
 =?us-ascii?Q?ajEHngBAtvA/Qokts505gm+JS+/3uZcvJnC08VYmiH0b81SEeTUfd38Rna1G?=
 =?us-ascii?Q?3IwIfmKX1D9JIbLQoAeuGGdLwv0GdlMiRZHBtWxudfy+Ki2Uy2i8x1Z+CcIx?=
 =?us-ascii?Q?/z0Vc/lEH3s18C4prxeO2I6R0G+AeBnW25TT8cX/IYZhVUKokSNk5ArabbtF?=
 =?us-ascii?Q?i46KRhjXz+q7B+bi3YrwmzFagS4CB8R9twmxqZNYjZOTrITY4K8s6eEuwkn8?=
 =?us-ascii?Q?2uq6KO/mcB+v78x9XzaiHuUVpPIBJYPsvMN3/vDc9oh8dECCH5oWbkbTLeVJ?=
 =?us-ascii?Q?HtSZMJPxwlr5kZQm+5+pfc8hi5EyE/+FSTzK9aOVx8aInjr+em+wYDqN5S+n?=
 =?us-ascii?Q?xXIK9uzKvL3qgb5if9b878Ws5RYpBuUOKcuPZ+7mW/YY5sFIpjmpeaVP6VtT?=
 =?us-ascii?Q?II5utYx8f2wZKZvk0yRkKIVqyV65kXCEsOHSfCD2O5TFwGKboSLSNcih61qX?=
 =?us-ascii?Q?hCrUqfH/U+GzIfp0iq7Rl+pBSWnFm9jTkI4V1qNURA3X5K23NycsrK3BVrmU?=
 =?us-ascii?Q?PB66AG7P9Q0vpYn16BApobjnJt/YbxtpsOtTIWFccxCk4lXIG4C0w334WGHC?=
 =?us-ascii?Q?X7WN2cdx/yZS9gFKtXUoOlrOLXDJrS0RLRVwAQkSfuGINLIgjg858NDvA0bF?=
 =?us-ascii?Q?ly1/YV5hZSPW0OLHjZxgp9cw3tNYtJRPSXBC45GgORRdTrNJtN1Xq0HqoA+z?=
 =?us-ascii?Q?V0+n+LKr0hExsKyr3t98X2hIGYbur3bBp6b/Qi2U+35aF8OsgbESKiFuFS/A?=
 =?us-ascii?Q?omDSS2LQb80HmBMC3jMMrmrcCpRRYXIA3uSi3Ilu68p+ovzw3gaHQ/E4ki7m?=
 =?us-ascii?Q?hwgVjzZOyluoPduJpAaL4qlERoOgxfIE3Pi9+ELAjbTbpx1xkqsWNF3svl+5?=
 =?us-ascii?Q?GSgjso93u1+JNLD9YExz00J0014tmYC7yPsNNrwDMNXDKQS4Ghop1MeAPg4C?=
 =?us-ascii?Q?gYrlj5Uuci1uKGGAjDY1O1X/pA13B93N/QeC4xdaR2r73Cr5XQNIThGGmnPz?=
 =?us-ascii?Q?gEnUf5X0XpRRHDWmD4zaGYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB77D11181ED5B4C8951D6ADF9EE3E9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x+zIoIGavdyzpXFY7Ckr+FOAHy88TeAXwIDKxp0Mv4i/daagE9foPPzRPOaGY5KXyJZmY4I+GPphVP6ZpdoP6qOImgj3Yra11d3tHjfp0lZJZGxrffrKqix+rEIZ8pW1+vlq6KfKUC/OS2eJjXbSw00k04Xg2zJdwrWABMFaVGut3Fi4HswfwTO8FQOVPF77A9B4RnISlza+sdo2bo89a+VCAJhDOWPHcUWKALYQgkk09rR78ZOyOS9L+GZ6sS/7LAFIYsmtb6xLr8grnh6UXRPoUqKJRd9Quv5RxljD9sQT8ZqDGIF1VDL895rlRDapM+ytM6X9GcfdaCIagFKzUIbXAMI6TVxPHY+skTKOwCj7jZY1z/bWDQL8fhpKJ/+sazI4PlkeAhp8s6Ml4kaZI5JwJy0LX10UYM0voWYc0eVbp442U8aPkSIf0kiJhyx9Os0IJgKJGfg1qaS3HahSKY5GH9aYayxxcz6Q7qx42a8YsFeDTU6qTeKX6ffl3w9wlkziLULPjR2qZWbaI6iJjtwK3OLQAxFH4FTOuewv/XqAVozKIjUuP49kEE75fKxOln5Mv7exfkYK+A4sziES9Ntx3wXF7zHxMjXfYTo4xz4FE+6YA+Dy5uG/hAtCE/ds
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ca5d2a-858a-433c-73db-08dd728341e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:43:42.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FN21lxnVhRyWHoJ//X+R4HQz6coYbSmYkYAEEO1KnNxjgFkcl5I91T4/EmI+CV8lQtN0XDGtCir3XJI1bYXDLc+bgNNwFn80obZ0gi2/DP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7246

On Mar 18, 2025 / 15:28, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>=20
> Test block device unmap write zeroes sysfs interface with device-mapper
> stacked devices. The /sys/block/<disk>/queue/write_zeroes_unmap
> interface should return 1 if the underlying devices support the unmap
> write zeroes command, and it should return 0 otherwise.
>=20
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  common/rc        | 16 ++++++++++++++
>  tests/dm/003     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/dm/003.out |  2 ++
>  3 files changed, 75 insertions(+)
>  create mode 100755 tests/dm/003
>  create mode 100644 tests/dm/003.out
>=20
> diff --git a/common/rc b/common/rc
> index bc6c2e4..60c21f2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -615,3 +615,19 @@ _io_uring_restore()
>  		echo "$IO_URING_DISABLED" > /proc/sys/kernel/io_uring_disabled
>  	fi
>  }
> +
> +# get real device path name by following link
> +_real_dev()
> +{
> +	local dev=3D$1
> +	if [ -b "$dev" ] && [ -L "$dev" ]; then
> +		dev=3D`readlink -f "$dev"`
> +	fi
> +	echo $dev
> +}

This helper function looks useful, and it looks reasonable to add it.

> +
> +# basename of a device
> +_short_dev()
> +{
> +	echo `basename $(_real_dev $1)`
> +}

But I'm not sure about this one. The name "_short_dev" is not super
clear for me.

> diff --git a/tests/dm/003 b/tests/dm/003
> new file mode 100755
> index 0000000..1013eb5
> --- /dev/null
> +++ b/tests/dm/003
> @@ -0,0 +1,57 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Huawei.
> +#
> +# Test block device unmap write zeroes sysfs interface with device-mappe=
r
> +# stacked devices.
> +
> +. tests/dm/rc
> +. common/scsi_debug
> +
> +DESCRIPTION=3D"test unmap write zeroes sysfs interface with dm devices"
> +QUICK=3D1
> +
> +requires() {
> +	_have_scsi_debug
> +}
> +
> +device_requries() {
> +	_require_test_dev_sysfs queue/write_zeroes_unmap
> +}

Same comment as the 1st patch: device_requries() does not work here.

> +
> +setup_test_device() {
> +	if ! _configure_scsi_debug "$@"; then
> +		return 1
> +	fi

In same manner as the 1st patch, I suggest to check /queue/write_zeroes_unm=
ap
here.

	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]=
; then
		_exit_scsi_debug
		SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs interf=
ace")
		return 1
	fi

The caller will need to check setup_test_device() return value.

> +
> +	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
> +	local blk_sz=3D"$(blockdev --getsz "$dev")"
> +	dmsetup create test --table "0 $blk_sz linear $dev 0"

I suggest to call _real_dev() here, and echo back the device name.

	dpath=3D$(_real_dev /dev/mapper/test)
	echo ${dpath##*/}

The bash parameter expansion ${xxx##*/} works in same manner as the basenam=
e
command. The caller can receive the device name in a local variable. This w=
ill
avoid a bit of code duplication, and allow to avoid _short_dev().

> +}
> +
> +cleanup_test_device() {
> +	dmsetup remove test
> +	_exit_scsi_debug
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# disable WRITE SAME with unmap
> +	setup_test_device lbprz=3D0
> +	umap=3D"$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_ze=
roes_unmap")"

I suggest to modify the two lines above as follows, to match with the other
suggested changes:

	local dname umap
	if ! dname=3D$(setup_test_device lbprz=3D0); then
		return 1
	fi
	umap=3D"$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"

(Please note that the suggested changes are untested)=

