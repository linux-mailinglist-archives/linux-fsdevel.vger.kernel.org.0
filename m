Return-Path: <linux-fsdevel+bounces-59777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF62B3E0AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBD1A81383
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E83043A6;
	Mon,  1 Sep 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xyfh2HPS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LlPUnfmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE16310640;
	Mon,  1 Sep 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723938; cv=fail; b=Lbay0h8lOfyGVBwK8rcocuW1yr6k2XXN6lfiGxZe1ITI2Rz6uT5/oEMzmX2mv6YUOtsxszepuj9GQlFlp0Z2GfRrQ8ASFCFSvhey4jDzHBMO5t7h+JSmUbBs02CSwRzG5LlxcOVyb8QstMN2vOsvfMx1/T3CkG/vB826v5hGcGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723938; c=relaxed/simple;
	bh=cPmwuUdgGFVCJW/I457b9OS3mh7DDnPmMWZWvHymkFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CT3RkY3ZIEEGmp3r9xrDivmGTWfthvE0oz9Zwp4om44a+XUGb3+HzO7WjII0HZsHuOo9BoH7XmtQKfyNUmEy4DFqro0Zgb5FPpfB2ASizn9ViqOPp/cXi11YdIYcDZ2pLvooapeyyHYEaCyz6YJccC74+Al4xhWtX/4EqE/TTJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xyfh2HPS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LlPUnfmU; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756723936; x=1788259936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cPmwuUdgGFVCJW/I457b9OS3mh7DDnPmMWZWvHymkFI=;
  b=Xyfh2HPSga+WJO5oeKGhtCp06muyI62koy+FpQH1bqIzsWGQQQFaDZJv
   6fLlR8MXmoGkknixCvqmttyuVYl6lLN9fIJMEJTSrT3nVrvnh0decvXXp
   FqcE+wRns6zYGavqsexTmbNSEZUodZ9kg/q3mjek0GInp5BtAAh9YzZP7
   78yyOSMyJ0OyrJcQB2FOWl8uBOUDBiJ47p2faMfeCvStYqRYvksKs8qJA
   gs/MvX3oro3gn3fgTS0SLoPg/irvGd8rTqX0ezw6ysdNmqPp0AP4gG2pQ
   s1yF+oK6o6s0y1yxK8Ehm+AQSI4+CVOETCOuv4fD/RnfsgiGSUlSN/A93
   w==;
X-CSE-ConnectionGUID: x5OXXJsqSFG6Yw3QHgOT2g==
X-CSE-MsgGUID: 82gr+ZhGR4mMbL/eBliMrw==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106132141"
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.62])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 18:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcQcznXtWHEvG3vwC4cdW4Y+mI+GT4D8/1mnbh6E7zIxE2JrYPeuJgN6MbMgBOHjitQdHZupqUHLsaso3IwwpTrFFbmuslM78Yf1m2SrIBfgXuMn1WYaDTT+1AhSQgMUPqA16nkksrtPT3NtM1XQyFsPPs6ZmJBMJtPmPPpUPH8ZeteBIlt9sh2vztaa7+LK32dFBMY9HzP5RBCZEaNTmE23IMJ5nzJ0OCJ1KCYYM+gp3zajxvMTVbc2oJXRrjXuThLHThsKutpllooQZHdt1WBR4awjAmpNh3RueIzwQROKLO1enwMMFw3Fkmf4cjLMN+1eCFfxgA0JA4cUryH/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHmzfDrDzhSahtxDEp13wnwu5TALeynHg38c3gcMK1c=;
 b=nTT+fvTdkDv5gOhYw/HPev8ABZlWmmQLkffxN8QXqWJEuY29sUXHHi2E5kbhYzcvh79sMPJkTv/xvkvFsbKkUuVu3n7OzgYUw7vf0nVSWx158z3tSs6sBzS9RlGFbCC2sOatGhV8fzDO9hIPkDrafB8NXc8ESaydLpmi1K7G5FkF1bUWJhFumei1UyY7xC9RkFZjGn85yvq36MNfhtLpQwNWzpKDb20iBISKGfVeoSKZUAZyTkd1H1RuyK0FkqwwR9W385r70L4mUVuMljtw57CirYeZji6fV9IFwE0eas99EV9nveeI9UPPIMT5wJQAS8hafWj2niXvpcDcBeah3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHmzfDrDzhSahtxDEp13wnwu5TALeynHg38c3gcMK1c=;
 b=LlPUnfmU0DWMs2sPXaCJhfh9ua6TZxdTOLl9kJqEkQvYgUpO/zDl7L8n13nwCKDGudjv0HGynbrJG5v0xujuSSvrytY3UkxGAd4WY9K0Amxu8VxC5ixzBeLdbObQfFJnCYzRoNk2JvKfvmaczRMHtPgw4aIfH/72kxrsurLLHKw=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS1PR04MB9234.namprd04.prod.outlook.com (2603:10b6:8:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:52:06 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 10:52:05 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC: Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 3/3] xfs: adjust the hint based zone allocation policy
Thread-Topic: [PATCH 3/3] xfs: adjust the hint based zone allocation policy
Thread-Index: AQHcGy50V674h8hUJUil2jxW6ZCJAg==
Date: Mon, 1 Sep 2025 10:52:05 +0000
Message-ID: <20250901105128.14987-4-hans.holmberg@wdc.com>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
In-Reply-To: <20250901105128.14987-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.51.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS1PR04MB9234:EE_
x-ms-office365-filtering-correlation-id: 8ed8dff7-2749-47d7-c6b9-08dde9459775
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zRhn59Ssfq+dhLuEVU4eUVrsVXXZ88YQdWpVUZMKn6cO4euy9fNT9NH4Mv?=
 =?iso-8859-1?Q?2QgiFBsVOmG/SW9hYtXEsceFlp0wgvMYQwbCwMM7DaXOFgAbZCjzuMXkLV?=
 =?iso-8859-1?Q?bRKVvAuy9FgpN6xCdrItyq9qiIkZ0wtv9XPMo/HZfzo/uL5tnS7tRBRnhA?=
 =?iso-8859-1?Q?63guRFMugNWtnC/NZIkrYzPHXWfHz5aIhUFxYnSGLwoBq/CKosjOa8mtHV?=
 =?iso-8859-1?Q?WONkwX0PL+0yMzDNwCBRVq+wr+AtmdNRoFpCxEe69OMfWY+NQg4TVdYtAQ?=
 =?iso-8859-1?Q?KvwUMbfBCAvJbrsHCQ6YP8x8J4+1i0Fqy5orcAneZhlePUvKi3Nw7VHDPq?=
 =?iso-8859-1?Q?BbQKIn+d34/9cO5VlS+HxHV3NoDvUbJ+8v2HFKSaZpMrKOqeqwn30KRPQO?=
 =?iso-8859-1?Q?Dqfq5svEOqhm3bQAPzsIaAvRaffRkq+yO3m85m6ZGrB76XGJ/ubnQE8vkO?=
 =?iso-8859-1?Q?Wvl8cjWPy7bOcBjUC0MfmSqgNcJut/SYH/paikAEqhn5WEO5fyAPsezy0B?=
 =?iso-8859-1?Q?dQhQZG2O8vrxs+gauSxRpCfvIDmpQcRCqakN0mjvSeB1Xz9VrVx0SrX644?=
 =?iso-8859-1?Q?1m3kqEIrHSOo+9XwhlTnGQ9+PrxDMLBh2hQc4z4KTXilb6O5TUDOUNzyVp?=
 =?iso-8859-1?Q?wieIQYyiSS42id4rgcbu74BztOjgjYGXexTWMySThLi10BjjOEud4eyhNX?=
 =?iso-8859-1?Q?BjWCv+I+fSIrynSRZU5nZVZHEp5Q8zKoj/BkDpzIzegyxrWad5npOmgVOa?=
 =?iso-8859-1?Q?w4Pt9mFnGk2He4l/Tgg0R8mO76CLVY8EfD1OgrLbLaKSFWEu46Ivw4xX4y?=
 =?iso-8859-1?Q?3NhRqSQJ2kSr16jOqdXq87+JJmB/WrVuSMF+3iPuN5LIxIyy6s11V/CaBG?=
 =?iso-8859-1?Q?MByfooIBbmEczvWxiK7FtqhtWqud5F1FdOEkX9ig2mDWF3xA6bzJpJlpDQ?=
 =?iso-8859-1?Q?UDOKx0xGoRQuyU4jo6i1XiX6NdVPulqcR/n9LC6PsPDx9bZFm4AQTZfEUL?=
 =?iso-8859-1?Q?j6Z4D7TXADaiJcN8y8fz452BZNt2IpuR6Z9kuIDFhwzwQbQf1h5fUhhx5i?=
 =?iso-8859-1?Q?/0FbV2SCOnPnACWH3YKCgXk744ld/16Krc9+2Bhp5je2u8gSuK/7hGOo/G?=
 =?iso-8859-1?Q?3r2p+GaVOr9CWeMLXLmD08r6TMYquAX87tAu15YBMaUULv5Aj0kZzX9IUp?=
 =?iso-8859-1?Q?KN5wyZ0BwT5UUDeJudQxDzB7kJhW4SYfNDDVkMPncsOFCdJd4QNhVySu56?=
 =?iso-8859-1?Q?pxG7MzYuN+BUa9u04KVaWaoviM7+oYAiXhBUTXgrNwjF3Eyo5i3sal9DJ1?=
 =?iso-8859-1?Q?wU2HdWkPNtlhAOvBPh41Ns17a6GZzKhkYiWng4Bg1XFqXRnRvUwEBnImXm?=
 =?iso-8859-1?Q?NlAEmNPtkaiMACc8kEIYhXGCItdaskiGKrWCgYyPwblOJGvQw+Qx8+zxLp?=
 =?iso-8859-1?Q?FOsjPBny2g0voz2i/hZjOEttVNVCj1thNpG/bcAx/MvdS7kHYDzWgp5K4O?=
 =?iso-8859-1?Q?ynfkNBoTepjaAeRpMyKNeK/q+N3Uwx4OM3qmIpRwVyCg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qNQkx0C2152+hnv2JwuzBVALrhR5kVBnAUknbUAjP9i+XpQs7FDaanjj5v?=
 =?iso-8859-1?Q?QwFHTxn046KR3/7Qi9iipZ54cFvjdCixI7MeEJ7opyC3u33JhxPNLng6jP?=
 =?iso-8859-1?Q?SkmVS882tMyw1EkHGdYSThX7UB8NaU91pgnOlHD0u48ELbFQ1XT0Dj8Z+s?=
 =?iso-8859-1?Q?j83Jh+LEcBOnSooc7zm3wAwVaLTLBf9uRHLIUrCfm4kOZxFQ6S+U4H0ayU?=
 =?iso-8859-1?Q?WqPgQBaxr8sq78DFpBHtXwCsX5eRdoRJNOVm+oZ/dCEV13Sfnhaj9M3kXv?=
 =?iso-8859-1?Q?s3J0Rea13HjhD1UunOX0wSGUVhySK2zVmfI7NIzKszdkn93YgUbQTgwnrf?=
 =?iso-8859-1?Q?QSl4OrS4hb4LWHf2AFeic4yWR5IHp3/8A05wghf2cPU8HGpb3bcMH++Ynl?=
 =?iso-8859-1?Q?oP7EzuwxYE9Uk2QpElv6lIvYatRx0Lo/5NthO+CfDPS5i6pdcrCp+fDNcR?=
 =?iso-8859-1?Q?Ro9vlsvDGwAWu0MjC6jzHiuQBbaPMDZaen7Zw2yUnsr4RVtZYIuqxmUvAx?=
 =?iso-8859-1?Q?UIq2ONPk7if4dJiWE5jFEkO/mzesHDb7pabFztb/YYtbC9qVmQNmb38pCM?=
 =?iso-8859-1?Q?21LeeunEOMAxqXD3b2HhyKs1Pvr35Sm+/1GdejqRLPDeovlDaH6b8mthKC?=
 =?iso-8859-1?Q?Wl/KaHA4zgrV10Nj93ZuQPdAD2OD60Vqc48EMh+SLuIzhMW2YOxyyeJx+2?=
 =?iso-8859-1?Q?gvCvMHpCsZhoG8qWWo89rGHV3z6v9VT+Tf/cD5Eru55W+0Wwlo6j+CMWuN?=
 =?iso-8859-1?Q?sq+Gsjr8gwH2Mut5u4mTQyaUbX6nY7u+XinktLbdZz8mbKkQZxFlD6GSqs?=
 =?iso-8859-1?Q?nQjBRtBqUYvnz7hetNubVV726IgoA1/oF3ZgSNwBXft3Ml+S5kkTfKleSH?=
 =?iso-8859-1?Q?UPmd7QbTzhex1np0FneocYwM1PnKWEZFQWJrrY2uB0ImWY0EruEdHivgUK?=
 =?iso-8859-1?Q?DjfI7GxOhvOdBePchKQ9gftJHgQSxNWOScDA+xWeddK+gfncCXO3nFFf9P?=
 =?iso-8859-1?Q?F2djlsyF/pployMAZz37AcwtOGwcpm/99OG6m45oV5SxHtKFiNsrqTW3Z8?=
 =?iso-8859-1?Q?AXVSwV/LXqKt68pqckPaudE8E/Bj6r6Ip5grPUa4OQvTWpZ9YXaqxUWHJi?=
 =?iso-8859-1?Q?7elazUJFTqSFAAIDUqdAvevsZQI1O5XIneedmFfGUUcTSMZMaXHqFwZJWu?=
 =?iso-8859-1?Q?D+ez78jCkYT6PHXSuJ3oYKc07slgRuq+/DLN8wny+kksNCQncW/oiA7VQM?=
 =?iso-8859-1?Q?4MMGqXOzSN+4Z0o/IYDX5kfYTHwb3xtjwpLBnsCXXhw1qFzFjFFU7xICTL?=
 =?iso-8859-1?Q?+JrbtqAVk/zI5UDRO9Ua1P660OaRkd9FrASfcr8ppAHjrSdVRW/zcK7ro9?=
 =?iso-8859-1?Q?kNoZoa090TTUrc0MnR+7yvn8zpifT8t+t2urv/8vSVUeG0yD2RAZiyweNM?=
 =?iso-8859-1?Q?jzQL99pmpDlwRh7qSW/VtXG6oXYSoPgdtZCDvFilL8zPbrE20q36sYOZq0?=
 =?iso-8859-1?Q?FYCO9YJMszPj2rHV9LUMOxmBdHWsAT/LSmlnL1fGxzleq3klBQ98bEQd9g?=
 =?iso-8859-1?Q?SQZu5cN9iFaSCMa5kA2YMTRCa84zSJVKPT0pP1q5ECPewlvfeL9+BNujKA?=
 =?iso-8859-1?Q?eQL7/Qe9qMUsI/MAXdYu8fRXP1cHOQhCrfYEQUiP1zVcorMrQAp7/xHw?=
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
	kAs/T0si67ee5ARCy0dQpLXaKDbSK3A/l4EpyIA6sDd/6HtfVoVrU0TCRbRN8IEjWK8/ZKuC+i1FhQ6YsyqicUcyIPYPOWnxpZslnRY7MnOpe8tOkQLAyNWw9sOpXXiPyxTfMNDvlEXf5ahx0gTPfFek4bTE4DhYNjZZy3BCQ8D2AEvO+vnNvQ9ZM/Os32zv1Hog9A02n5qSHvO2r4MYNoWSF/iaYjKXp75Q+eNjbecczIhnVs11hKowvtp4r7Vtdn3fOHroL72BLXr3DTIN5NQ09dLfkfPvf3oNwqcdfzQapER5KofE3ngvpaIJm3cUzzEa3oYe0IdKCryNKYXwQYNmbZ9GYAIwwsFAVvop6KM4BWQtKbtCdFB98UaisKiAHXgtplbN3cQVL/tn0bVPtobUZ4/QwPiHY1/KFAiLx5ruiygg0sDi7jWZpWve4XacoYCoBsmwNPTxOzLCyjhpKOf23rZcEOAICuPZIND4mzml6T3kyR08axS6dy9jzCmC8vrImeNhZznQiHDcOULX8lfM9ToSHxF9h6GSeNAK4FuGs3dL1C1pYpJOhbirYjgDI54gzU6CshPSROW7waufnl0bNcOpjQaPx/OjzjZB0WoPa1qiXTrjCIeyi5U5QVmw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed8dff7-2749-47d7-c6b9-08dde9459775
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:52:05.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XP76wQcQIA1C2ajvxsX8/SpLE9cl0iXvx+o2UQDHRAsol8dFtDJ3WORLb8ZCcyX2FD/IM43gVLMdbWX/Qj451A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9234

As we really can't make any general assumptions about files that don't
have any life time hint set or are set to "NONE", adjust the allocation
policy to avoid co-locating data from those files with files with a set
life time.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 fs/xfs/xfs_zone_alloc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index ff24769b8870..23a027387933 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -512,17 +512,11 @@ static const unsigned int
 xfs_zoned_hint_score[WRITE_LIFE_HINT_NR][WRITE_LIFE_HINT_NR] =3D {
 	[WRITE_LIFE_NOT_SET]	=3D {
 		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_OK,
-		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_OK,
-		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_OK,
 	},
 	[WRITE_LIFE_NONE]	=3D {
-		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_OK,
-		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_GOOD,
-		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_GOOD,
+		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_OK,
 	},
 	[WRITE_LIFE_SHORT]	=3D {
-		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_GOOD,
-		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_GOOD,
 		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_GOOD,
 	},
 	[WRITE_LIFE_MEDIUM]	=3D {
--=20
2.34.1

