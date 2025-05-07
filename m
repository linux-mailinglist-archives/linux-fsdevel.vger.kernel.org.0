Return-Path: <linux-fsdevel+bounces-48329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C92AAD60D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D7173B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545720C00E;
	Wed,  7 May 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LQJv886w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D9eitDaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0B1CEEBE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599311; cv=fail; b=UWlrbTuTt0ngIG8WmwkkN4ATAqU8V14W8V1AXqSaxft2Cg4lNWszBmfrkTVU91xW6CPa2nJar2fHjXJhT+JF/5ReRJZlwaMH8SaTByrYhZ4CJb/nnDt/+k1Jz8jsl5hcRPvJawiqfIDx2lEqzodhOQ7yu1pQAvu5CltMsFntqDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599311; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVmx1KED/rqFNAk6NN/uA49oP//5wkaADFZOe0wFsNkhG+szLE17RcJ5z3vx1Mcls+RBn0ATq14BzmWfxTu3jwgDzj2yeKbHaiApHQcIztOBm7cC31dV0E7W5Y2Q9Q9RitDqxMvwynVpJjV4TWYYZNpiXKOffUWf5YBL/aRrNKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LQJv886w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=D9eitDaK; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746599309; x=1778135309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LQJv886wWvcP1JfQOhMvYtFVKLSjzbeHufASeBLXjMUN5cMdn+1Std7J
   lmNtYnJTPV5tvfrsXhx7f9wHFjpmTSKzpq702LZMC8AtUJLH3jABCEdNI
   NIAMPB82E1x+XBce0ODBh/N4aoMx0qqBWSrw5EMuok8lLCdg/AZxP8vtx
   gt/TrAtN9c0mtle0uVPtQ7Mks+BuxdibMRW4fVsxsY2AEQ6sulOzmrAEU
   VwzmVyyiFH/WwO5snBUkeVkwbhLsN0RYntS9V5egvC5speVjnEn2FKurv
   jNVF1SW9tGRkIt/ndUsZIdgoe6oF09PEt9F3b8xTnrqTTSDCWfa9yCAiK
   A==;
X-CSE-ConnectionGUID: rGLpO3JvRaqL77um6PepIw==
X-CSE-MsgGUID: deUFyM44TSSFwzdrnQ8HZg==
X-IronPort-AV: E=Sophos;i="6.15,268,1739808000"; 
   d="scan'208";a="79644888"
Received: from mail-eastusazlp17010006.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.6])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 14:28:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDcv4NnaquvmRQzlkaO/nflfugf4ZMEszDWgl9BgxRx3kK91jVcratl8QaCXPLBJL0rLUvMJigiHisOZz+PHDGnArKMl+CH8JPsB3ijZeu6MjUldsG24GDJ/e73JzrfDHFA9+xQROsqtvSIxdNrCG4s2q/KjunsZFbGxlncCcwCkaQjmHgGJcZhW+DezZvLhuT11Z4e26no48Yyxf8aAdBi3LbF3enaVQDE/4fJt7cxIEYtljkOX1+LWsyX1i0WNZy3j77fUVz/iidFfKRZyQ2TdWujXwBAkeug0Jv2T0D9dXTDDOnF8bhvrSeEQzLJotSC/y02jCPikdkg9rag3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DAg2b68Dx8GifQZogLHp2uMxnuoop3mSoHyM/zMwLipE+dHonzcWcjzKscfk1WxwgsXC9Pzh7+m1kiAnoo6B0WB7DXd8jClKVRShJD86RHlZj0yf2wuvGWFl2fhhXE7iN/0hfk4cGMZNSrHwIsvvZ8CmnUPv6qTAgM3l05eB25E8pBx3nQJhHg4XlQfvMsubQvjeXZA0tytEiJULiBvcefs+aspbxJcjTBlUhKGfSMNUhlY+3DVyy6RiSUJIjEnTMZCd0WmbIsrzf+KP9SisJmYKjswUXQ6RLYW5mPmj1fH9vahEaBy1U1WINWDBhBLSdRevamCu4gyD717BmwxYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=D9eitDaKewBGkE+5+lFNvLW7w7WLfYsHLROhCtXbclHmmPnTmaJTFFAFBydKNeEJyLVirhhf3se8cUNKeU+KfnIQ4IVchckzECH+TEpSJG5/4EWOhBjISOlbZ5mZQeDmTiVkpPs4jSUmGquu0RkzZNSvCJtuiLvHU1Z2PcmdCDs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6626.namprd04.prod.outlook.com (2603:10b6:a03:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 06:28:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Wed, 7 May 2025
 06:28:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>
CC: "jack@suse.cz" <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: use writeback_iter directly in mpage_writepages
Thread-Topic: [PATCH] fs: use writeback_iter directly in mpage_writepages
Thread-Index: AQHbvxhMYn8l5wPHH0mGJVdVUpcp1bPGtEGA
Date: Wed, 7 May 2025 06:28:20 +0000
Message-ID: <35956858-37d5-44c5-a648-f2eefa620b1e@wdc.com>
References: <20250507062124.3933305-1-hch@lst.de>
In-Reply-To: <20250507062124.3933305-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6626:EE_
x-ms-office365-filtering-correlation-id: 533e95ab-1edc-46b6-c9e9-08dd8d305c54
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmRFc1lpQkZXdksyYlIxK2ZyWGZwb1NJRlRHaVFzWGVDc2hYWGtBZE8yLzJ6?=
 =?utf-8?B?RzhGbTM4cTV5Wkh0SXNDWHNsOWd2VVRQelFQNVFRVFlZTlRaVmljQklxSVhp?=
 =?utf-8?B?cnBYNjd4bWY5QWtYa2ZacHpqdm82WWY1VVg3RUhpYm5oUDZKNFNySEFJcWM2?=
 =?utf-8?B?cEQvN3FaTVlnU2cvQUNsTFNEeFd2bnozeXpMS2NCRXpUUmV4QTh6Q25uVHQr?=
 =?utf-8?B?ZE5MTmRBSW5EbGRGZVVZZ1c1Wjd1alhaR3B5RTF4ZzNqZUFseG56dkFXV2lz?=
 =?utf-8?B?VGpUYUNBN0dQU1JraXJZbXJLZUhzY2t0eEduVTRLalIyZi9reXZmemVCNVlz?=
 =?utf-8?B?eVE5RiswYlFyRGZKUFVZbTFjNUZOS042ZktGeUtiM256dVJxZm5rNW1Cblly?=
 =?utf-8?B?bWJzVmVQa2hKaWMyUGZQbng2aC9Wd0FlL2ZuUExrVTVMRFFpZ2xDVnVHM2xD?=
 =?utf-8?B?K0paZHQwSjRhcEo3dkxHSGhIbXUzblRwRDZkMk5OUXZ2VlBwM1VyRlV5bjgv?=
 =?utf-8?B?Y0R4RFN1TDZDL1lzdy9uUndDYlhxaEJvVjVvc1FTSkhDdVROWE1hdHdiMTNl?=
 =?utf-8?B?azBRMjlRYXlReTZvTXY0ZkFnRFRicS9CZ1gyZEtmQ0o2UHZCeDFrRUZsQzBz?=
 =?utf-8?B?c0dRaU9nZVNXWWc3Q08vaGd6VlhZUGJhdWlxSVVYTzhDMit4M1pDYTBGVXRO?=
 =?utf-8?B?ZDY3em5kY1ZxVkR0YWZ2emE5U1gydjFXVFFtWlhIVnB5QWJzMVk2M21vVlNr?=
 =?utf-8?B?ZGgzSzFMUDJtTFRMZXJCYnRWMHlOSVF0a1RlbWt5anp5OWRrK0FaMjQzelVL?=
 =?utf-8?B?dHR1TCtxNC9oZERYaEszanVtUjdUcHRva0VCMjNkQlEzUVB6THpUZUx3RjBz?=
 =?utf-8?B?Qkt4aDZmRm1nL2ZxQmZmQkZzTlI3cUlGcFVNYVJzKy8wTEpxeDl6c29ScTVu?=
 =?utf-8?B?U3pSZlhiaHUwdnF3eEVIMXdmTkx4Y2VVb1NmT04xSHNhN1ZSMS9PVDdQdTNt?=
 =?utf-8?B?N3dGTE5FYkdrL2h3VlFhb1YwUEVkSFZDK0dXaEFjUGtHZVR2Tmovd0JVclI0?=
 =?utf-8?B?MThheDJVMzgvNzR4T1liRlM3d0p6eFVKSmt1Qko4ajkvUzQ0bXZjOUpMNXJ4?=
 =?utf-8?B?TGpZenhwTm9Ia2dRbGNCOGZZTUY4NHpjeDhSRUkxMzBlbWVUT1VUb3h3KzVD?=
 =?utf-8?B?RFIvL0F3cjRvaGxMZWNEZ1ZERFpnTURpWDIxZ3V6UXV3R1FjbkYvbUg5d3lK?=
 =?utf-8?B?bDRBcEl0SGs2RzBkc2NvMDVBa1ZkY3ppT0piamxHOVB2YXp3eFhEc29xSDJx?=
 =?utf-8?B?aURmaWJydnIzSXhVMnMrTVlqcWl3OVR4V091ZTVTdVZaQWNDbXZ0eUtoeHJJ?=
 =?utf-8?B?dDlHcXQ0aTBWYWhrZGliVm5RQ0U2ZVdsUnFjeHcvbEh5VFY2ekNmdVNNSnhk?=
 =?utf-8?B?aXA0dnpqN2djS1laWkV4NkpLMjVRMWpvaFN0Rkx5MHBHVHlGMHUweHRYamxO?=
 =?utf-8?B?RWI4Z2JPWG5vNHFBQTRVMEFSMG9jbThoME5hSWltdGZRRzhLTmowMmYzOWxG?=
 =?utf-8?B?dlhXc21sbzlnY1p6NzI0NVRJc253OWhacTZEa2VuRHc5UFZiMVp1N0p4SG5r?=
 =?utf-8?B?bExpK0xiSWxXbEVGdTN3eXQxcHRER25aRy9UQUJZeTRkK1lDUXl5L2JWRzRY?=
 =?utf-8?B?bXhYcVRCcGkyK2w5NUhCVnFyRFlOMThCMU5VS2R0UUFrenpUcDU4eW81Qk5U?=
 =?utf-8?B?RjJTVkxXWU9aaGNxbUlKUHRLUG9QWWRZTW9rbTUwZkx5MnFaaVIxTkdTL2pS?=
 =?utf-8?B?WHNaZXdVWVhUdlRSQlVKcFB2VUFSL2dDclgyL3BkdXBPRWFTMi9UZ1luOVYz?=
 =?utf-8?B?RXF0cTYxcWZHdGd3bTNROVdxSTRwUlFPaDBzd0U1R05ObkdkamxVckVVZlJH?=
 =?utf-8?B?R0kzYU9wbFlaSVUraW1GT3lXS2NEeUlHZVBjeHA0NmNvU2tOc2RHalhtZGR4?=
 =?utf-8?Q?ibb9r5afNchLv6ojyjpC4h3to7FRO4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFU1NVdsVmd1TUpHNnFCZngyMlRVenQ5emEvd2ZjNWhua09iakcrcmR2aHMy?=
 =?utf-8?B?NVdHMktqcGwwVkRETXhRbjVhYW5IUnlrSHlRN0MvMHdxaTRXbEw5UURqd3Ny?=
 =?utf-8?B?MWlOK2UwTldWNEEwYnBlQi83Q1JlSmdFNWFnekFSK1ZhUWo0SVp2byt3QThH?=
 =?utf-8?B?eHZRcys4UmFobk50NzdtUHlKenpIckZNWHhxV0F6MURiekdPOFdZamVPN0p0?=
 =?utf-8?B?QnVNWUhZN293bGZFRDd6MExDSmdrRkJWbXIrMXc3UC9kTVZuaXlzQitoRDhT?=
 =?utf-8?B?SnNIUjBMY0VCN2IrdG50MU5FV05hcGdGTFJGejZmT0p0ZFZrWFRueEZxczNL?=
 =?utf-8?B?MFRnUUxDeUVXcE15R2I4OGIrbklmRHY4dmZoM3h3NkVzOXBnODlwbnhSeTZB?=
 =?utf-8?B?ZnhINXhhQW5GVUtta0FUbE15cDRCMTgwRDhRVXRFSDF1R2U4TWFmWDY2QVBa?=
 =?utf-8?B?Q0drQ0xsRk5lWFhjV3hsRzhqd3E5QTZHYktJM0t3V0Rqb3c0Q05NMm50NWtq?=
 =?utf-8?B?a2xpMGxFdjF6dk0veWNLZU53TUg5T000d2hFQUlJM05vVUhTVWVqNThUd2xK?=
 =?utf-8?B?Vng1ekhNdFRXeENEcHVQbW5WV05rbS9MUGZqa2gvbWtNUzVFREQwNG50SllG?=
 =?utf-8?B?ZGE5YkNvL1pJM2JPSkJKZG9MNjl6YTkrMnlSc2VodFl4Tk5MRmo3eGZFY0Z4?=
 =?utf-8?B?UnVma2xWU256OFdyMlhPZ2NsSVhLcXlqUW1ZdWhNTUtabkZ5MnMzSkMwazFM?=
 =?utf-8?B?a3dZQlJUNkRvN3VoNHIxQncrNVpmYi9vd0hiQUt2VkhVemg3a3ZuUHZETk9t?=
 =?utf-8?B?ZXJpWnJMSHVmdFA3NUNoMzQwZzZHeFJMM1NIbkFQZWM3UnpQOEZKNmMvU3pE?=
 =?utf-8?B?SHFhTDBIamVMT0laR2ZDKytRUGZaRGJDZ3dWWGE5MUQvVFNuQjEydmIzVWRW?=
 =?utf-8?B?K0xjaTdFWFJsTG5uM2hhU2xtQ09jMyt5RUc5ekNWRDVlYUZva09rZjhkb2Fu?=
 =?utf-8?B?amlkM01pMHJMQ0lmb0kyV25idldoN1RCY2JyU3dSVmVXcFV2RmdyZFFYZnZ2?=
 =?utf-8?B?NklvTFk1WlBCOEg4YWduY0FSazA3ZHd2d0NpZTFoNytHM3M4Tnh4b0NnNEJq?=
 =?utf-8?B?Wk5CS3dXc3NaWllubjRHdFpNOUZxeDZyNWdGa1ZBbjlCU3dmS1FING8wL3BL?=
 =?utf-8?B?QWdodzVhTytXZlY3MHp0aDZ1d3kzUjgwcW1jNXZtMmQ0cmQ1dklGUUZqQ0hx?=
 =?utf-8?B?RE1RQm9MOHRuWHowS2xoR3Y1UDY2YWhEYWV0OG9ja1MvK0ZmanE5ek1FRDRz?=
 =?utf-8?B?TEp2NFpOdWkyaW5iN0hUQW53dWJkRFg2YVFMQ1BkaW05bmExcEkweVduZWVy?=
 =?utf-8?B?TnNsbnRibGNJRWQ0QTVkdW1ML1pGb0o3NytzTE05WlZJK0VYV1EzOXlpeFZk?=
 =?utf-8?B?dTBzYTV6bEdvamhkVjVVRXhHcDdWM05jUjY2ejVvVEVCSUJlbmUvS3ZnVzFH?=
 =?utf-8?B?a2E1UHQ4Y2xMRmZhUytPeEg2T2p4bmtUSTFwaWtGL3FYZXlkUTZzWEl1MFpx?=
 =?utf-8?B?WFlFck9ld0xIZXdGa2M5SkdzMnpHTFlueDFleklIaW9ueWdUSEIwY0VpVEYr?=
 =?utf-8?B?Ly9iQzZ6WDRJenA0ckNENW1IQTA5bXVDV2poRjlUVVlXeVd1bTgrbmowbmxD?=
 =?utf-8?B?T054a2d5NEQyczFYQWxOMEJUQjIzQWtTUWhCNGtvcXRVREk5K1UwQXUrQ0ph?=
 =?utf-8?B?dTZNYU1uRzhFSTczWE9Gb3BXS3JnZENleVRDdFVXNENKVkZwQWlqekoxRGRK?=
 =?utf-8?B?YzJVRitoMjhySGQzb2JBVDdHZm5NL3ZZVFdISkM5VnlLK1JvRVRsVUxsWlo3?=
 =?utf-8?B?OFljZmNPU2MySXFPNHdJbHN5bnVaeFc1S0tWQU95WkI5OGRFY1NnTStjM2dk?=
 =?utf-8?B?Z0ZXRjk5VDRSUXJUK0RWQ2VQaWRBZC9sRlJMc3kzNjdKZ3RQTW8vcVN2Z2J5?=
 =?utf-8?B?Y0J2YjBaTFFQWFoxZHY1ajRDL1EyVWlURlVQUW5pdzF1S0d6N1JXWWo1K0pE?=
 =?utf-8?B?S0F6YWViT3BqMG5yTmFTZHRJU3c3RFNmaFFDY3haclAvSStmZlhFU3pHUG9a?=
 =?utf-8?B?L3hEWDdPdFBaWDJlQkZIbE5xTkZoUDdRTDR6M2NVSkNwamk4R0srQ0pMUGY3?=
 =?utf-8?B?eGJlRFhaU3VxdTJrOG5qaXZUU3pYaFhBT2loNlVLdlA4bGZ3MUZPTndvc3Jw?=
 =?utf-8?B?V0puMUUyQStpY0Q3OGw5Z0U4Nm9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3087469BDC3EE545A1015740CD37417E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ns2wotGx+JP4h7KNNYbzkmOLhhQdJw7ddPleCvDHbQQsJ19UUuo98esPIJssWiKjpRI5bjNLakiO0/iILbU0Tne3sJgW5xPdvIvw/CYUIHSlWEkSDDcEyhTMovVokOq24FSRBRcLREqvGTCMjoHLp0IQdWB0IB3PDu011cyMRnSYpmHQVAm4WkUoQfk5bgL+OjJcaMGLCN9V35uzVv+2nxm2y2fKIb9M7UCc0AolQ8PlxetgkmodqynnqCVJG5Lz/b4mLuaApq+7VgDWP+lrsYGGqinMWnBkIz6iULqUi7FRpVQuLarrFCYER+kVfglfs+p5ZuqBR+HsIh3m+R5p16wesxNnn66Lv5bBmkSgI/7dom7vOQ/jf4lWOCv6kc8QHyvPRfWY7BMfLeIlERbABVvSXZAb4mBYEZPEgGu8o8iTeZDrtkYEa1NMvhaZknmfsgO3mG9UQk6i0TsJ9ySFz/FMzDSvSnC7aQuXLYfXvigh9mulAwUXlbS2hBKvnwvV1al7fbR/Qgq411k0vI+uVfDHfrvOgbP1hmWAhxBVniQmcjHAVhFFFmxlUexHLci1w6QGY0QGvN83nk6EY05Z7FcguxjIqKjQU4AP1hjXyWZHK+jVkGWgwn142UUC0O1P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533e95ab-1edc-46b6-c9e9-08dd8d305c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:28:20.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlWTCeIUsO0DC53LAVBp4x8MmNhV+4HLBvjmaQsFMP89hw5z8NUfqyILftCujI5xJL3YWHmCO0fEjGqzWQ6OKIh4ih26ZdoiUeB7LYOpEwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6626

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

