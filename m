Return-Path: <linux-fsdevel+bounces-47501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE4A9EBA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A9717A86B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926C25EFB6;
	Mon, 28 Apr 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oM2GJ23p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BdOpP48i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8ED1B0F33;
	Mon, 28 Apr 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831866; cv=fail; b=mfO0lRMAOVdYAFvuAmFXIY03qNcCzUTD33y7jbbJbFYl5e15ltjiiHQerdvQ7S7HCXxqkEatNAtJvTdMIneMIoX8sJq2wNvFzQMWecAYnU07aSOKyBceXY5bKfcekkH3TeqzCJK7DsB+XhMAvS7Vuk6z2EpwiKXz0x/fOCtvVqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831866; c=relaxed/simple;
	bh=ddnNE936tPCAcfLsdHZlA/Df1vKQ28TAQA8Mjbwdo74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nquTpTFQDRW1k/vqQaaYekxjefBv5NDpbc9wPT4RbS/nmvOTOCIwYs5m2PzGgqKBFw0sXu6spk0AKla9pteZF91HsuFsU7vhEr+ePLJb1ertb+lNcIgQRmvt1pTBCjNTiF5CJhjDDLXIi5afTdZuk0eG/Gu893BX59aVuL+82eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oM2GJ23p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BdOpP48i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8l3uC015096;
	Mon, 28 Apr 2025 09:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qKleqFmjmTPAdI04Nl
	HVLaX8NSExI5KX6Qq14TBGPvM=; b=oM2GJ23p24D9Uu/LbvP5lz6Fw1X0c/w+RM
	SmgKb/h9pHfguC+rJ6Ic35DHdnXVOI0zNCYHOWg3Ijgjol1et86FBnRM9PM1Scrl
	pmk4HyBaLIIO5VjWlgx66X9D+muQodTXgxauKilKWiXqY69tZ9SCYxUbCphCy48v
	NVJrrnyYE8GTK601vEcqggvPxI6q/YDYuSVGCdNFeoH8Z3T3Wo0CsAO7s0I7xw/1
	BirkvLO9x0lvL8VcO12iZtjplPzDUk7qFtQHrWcPQExqkBf91SqGyzuxX4U81Wt6
	epDm///igWxYLZHnxxfWDeqEmPBCH1Le+lle1J3oIRUm/6NUZEqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a6fa04ss-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 09:17:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53S89WO9028650;
	Mon, 28 Apr 2025 08:53:22 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx84jvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 08:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVPFusbXketIY0ng8/4J3AUXf/0wQCdkvswtDz5OQPDYWJL8gG4JSS1oElCEO552F7h9CZIZ6HnaQlOqSOHrH1awFxhc76LjelUqXB26RlaJBMZAIw6YjhjvEkYamYmgU6ZwXew4vsCoiVzEbSXrroN7/xEgYrRMHJMGZtkVkNyj7mKx2Xr0XZIFZZuQTzrDCBGE4Wy9g/ZjXebipE1x2NIdBWOk7wQBr0xwKMJkKnRNKyDcqJDGu8MZmUpbrEqs7yNRa48BChpOvKfClXtTIVke/F3/+OOmCFIAvOVgaKX9q74EUZifvHo0sXE67PsveZUI7O3/NEtBehSLNVONDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKleqFmjmTPAdI04NlHVLaX8NSExI5KX6Qq14TBGPvM=;
 b=CyPegUW5tTg3nD5aW4AYpZ7NEizNCcFJxJNKwditIJ0RzmSdbsjyUC9t2UTgChe5FxJuK+9XN4qN3jj8m+LR2gXue4AwN0Ou8UNVzjb4+lIrkj5Es+vQ+N3hw+2FihhvQwGJqrmKeHuie65HTsE+cSK7HAwh8BaJxIGLr49lSmzGlt4FuJgaY91ZC1TS4+Ms+GmML8hoH4ohwi5zxuyyHnaNJzymESLiQ0ZGIF282xgGhTOBH6SOy+xMWx71Lygf/x27146pRBLicBOZnePTLUcEJtXG2avcAfYoMoVHUrUguKtBjtpjH6h+L3KYxpaLjn+q5r6GlAhxkDAnGseMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKleqFmjmTPAdI04NlHVLaX8NSExI5KX6Qq14TBGPvM=;
 b=BdOpP48iwRAXfMpis0uMHykK3N06h9bQTvkoFSVzpd/QIoD0s7edTzBFTyzf7G+YLcTQKu7PeAENfkVKDlrgs3rdgl9ThJ1M34Oy9c/y7ZnCjFlSaQB+4sRif4LLOZqZxbkh60OMhnG7nhMspEnVB46ImGzdmeZ4wfQ6E2IeS9c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 08:53:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:53:08 +0000
Date: Mon, 28 Apr 2025 09:53:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: abstract initial stack setup to mm subsystem
Message-ID: <8fc4249b-9155-438a-8ef8-c678a12ea30d@lucifer.local>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
 <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com>
 <202504250925.58434D763@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504250925.58434D763@keescook>
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: a1daf641-3525-429d-aa92-08dd863218f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/mb9tU+6YkZhio77+V5HSse0HL+DcRYsPAQmzRH7bx6YejchfVJFHtuWZ5r?=
 =?us-ascii?Q?q417ZECwYDK60J/edtcRdQ4c4NA69ePtcRCN+qJrtyTElutphg8/syLxB/ni?=
 =?us-ascii?Q?IDmDMvQpQYEdZQiqyGsBfhlyafwQQUaSOMzyzL5dnEfc6DDweDCEHa4tUDmm?=
 =?us-ascii?Q?yX6z7f8fD+nh1ioE4qugUWlOJQzF9X17+dwMnF8Dd5pccWmXRcG9bder8Ua5?=
 =?us-ascii?Q?+b/15YHR+1roHtp2cpDR1Tpy42at6uHlo6wGEFUYhpr1mQltsKGhufrfdG3l?=
 =?us-ascii?Q?ofdSxx3WrryM2McBWe0BWPnMqaxK0o+re14VTiPVBslI7tJWFSp5TmESW37g?=
 =?us-ascii?Q?+O3sjfpCNvAEo/1smkwjQUbimaQYPQ5y7j+qtBzqjeBF7Q734IjdnxTRynmM?=
 =?us-ascii?Q?ztTuPwaHhZnMzROi2BisLr1Koxmi2G3nm7djhA9T/WIe7WOZK0xyfg2cS1nu?=
 =?us-ascii?Q?DaDxsDGcEQ7j+vCS7KsfQSYlCM7ZwLFX+/+bpEhKXQzaepFZL+lbby+gEO1C?=
 =?us-ascii?Q?2519PJCYEluWeTV1cLh3Ovre4uvdJcdu1mMrl4hxAM9H9CR8zj1IeXHSNrMr?=
 =?us-ascii?Q?AS+AWvfxemHMclKAYh8byFPb0WbqwEKPnarl6VJauAkO6ldvvvgBYjft6o+q?=
 =?us-ascii?Q?01XINRga92bTlKahSN64ilxMjkTGjOqEf4uci9a/6TBrnD8day+cRI1c7Yw6?=
 =?us-ascii?Q?ZwyC6Nw6bCqYUY+NYwRayYaLmEoKS5oqAQaJQIFQK7bR7Z7+ECwH+WMWkf4m?=
 =?us-ascii?Q?K1DcMf9ZOgjKo0YVP5tcwrW7tv2mJev4lNcaT9CoHeINSud4YuYrHWIOx5Hd?=
 =?us-ascii?Q?a7WQ90lgHtgBYFQx0qsmXH8B5HSr8ta/LHOmHlXI/urso2Y4iUtta1T9nxaU?=
 =?us-ascii?Q?wEtthS0XNeF0CGjw0qjUXNrwg6roypMp8ro/BMB8tpt60Q9NfO+9kDdCpsNq?=
 =?us-ascii?Q?CsbhtIFt1+suAro6bYkGrld0z3LeK26UuYO19ezxFnThVJYxLKrd0Ow53CxA?=
 =?us-ascii?Q?H+Ho0K+h16AAmqw5NCrw/wMGqI6uyPuAx8aFUJ+lEa0Ap+LXclJJs2FDQ72q?=
 =?us-ascii?Q?CERBi18jthSn95XY8457qEuARtQFjOkcE6SS5nbUklMUq+CNYZY+TLV4eKYU?=
 =?us-ascii?Q?4gRbyRENppNVv4Yj8E+yRvK3S2kVPe39AuVsVdUpa8iTdVLU703UUY3l4a1d?=
 =?us-ascii?Q?DX/Vh93rQnekvruF3ukB1xhz/xCVNYgX4yiKBBgMJaLFtoHc6SvrVczBqM8j?=
 =?us-ascii?Q?Hk8A6Iach6m3Y8vl05xQtiUJPXispW5KkfB7DyFj6Ts3BFbGdHHVge0tKgvM?=
 =?us-ascii?Q?g2cPJQAZMugRaxH3QYmX0lgpt0utBtEW5kWT6JhoOEAKCT5Ul+CShq61edvJ?=
 =?us-ascii?Q?3kZMT2QKg/fvW66KoBO2sz7bl04zo1b/qQJz5DwCuVx6RBqfRZx7RHSvtYas?=
 =?us-ascii?Q?3maU1gXRbSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i770EMe0Ps++IdAj+jPk4fJrRPcu8SdGH2oUaXECBC245RiMbhzdkUUNkf1Y?=
 =?us-ascii?Q?6PlN+7X5bByA8Q5bk/B5OjDHTHZb+F25qV5kkIHiJeLyjjJcHCxff9S72l0e?=
 =?us-ascii?Q?tdkbTiamXLUZkhXLqoZVKdgDUowzZ9Yl8RJJS7HdFW8LYrycjCqMbQZIdgCW?=
 =?us-ascii?Q?wuzecoA3uzxnmpZuwkqvNRwY/FB/GX943tNz/kh7Th+AD5Udwg4zjgpGco++?=
 =?us-ascii?Q?OJRI5LomrX/lI62lvMq1w3yYqaXO4yYS76msZInAaYSrGmabufSPo/oMSlM1?=
 =?us-ascii?Q?jFC/UVIFbU+18gLDWAi+MHi4jW0UO5Byyvw+s4zxWadh6hRBe+2eB3BRMUfn?=
 =?us-ascii?Q?mfePmTDqy8rdrBfIQf8+l6nvfGo5ZmDIgeQwefblNkE6Q/+2ruNg+jR0/n6h?=
 =?us-ascii?Q?bblM38Z6FcS1MjEjWwWubat0cyyW+174/bmU/ekjHj0MvfQHy0oc6w5BoS+I?=
 =?us-ascii?Q?VKUEr5lytXP8A7pg5jh/+YifBKQikQhFAZZdM+NKrVnyL/frYRZPmJYsRFnm?=
 =?us-ascii?Q?LeMlDJUNUjlNS7RwXBBiv347Vvk+cHUqdQKkyeP5ROPlvakht5G/2vls5yrY?=
 =?us-ascii?Q?CTdNEixhpp+KbIcCB0bxpxb0Nx7gxhwOfRDv5Ay/yf3doL5/N8rJda+SvBcl?=
 =?us-ascii?Q?WIzuhewyy7Pp50YL1J3H8+gsoyOyVPOL+8EaK50ahb8icccIvoIvERFmJTvH?=
 =?us-ascii?Q?22FxdFiGOp+MpygbgoWWdSqaXLLeNWALsN5CzdAqYvigyLO8sbM5i1B0h3Qv?=
 =?us-ascii?Q?7OD/IYJnN8+aDQuMTghRgtaeVSxKRNX0eLGrXHr/btfr9d+etEaROj1V2fSP?=
 =?us-ascii?Q?50P9IVRCWXSnxu39N5ynQmlfc5+DcbCyTux2g13I94ug9cD1M9E9bm3RS0ft?=
 =?us-ascii?Q?Z5vExliafjWWRI2DiMxnopU9muuEwCh/PGyjvToELQ2VfckkkZr61qQJgnc/?=
 =?us-ascii?Q?Y6ZdjL2WKTnr9Sdpj795QyqV5OU/mOu6YA5K1AVp5cT/rT7Rh3P5eB7JDahp?=
 =?us-ascii?Q?UbTPulAWGEsIVFTjntdtHqtQfCHsZD3nEZdyQr4olRdP+HDOzCg304Gv2gHi?=
 =?us-ascii?Q?f+xvAwL/SyodmcOkqvTXUPN2+ugnxxmV5LbK/4jtc+jD2RSUSdGYfLh7PgV/?=
 =?us-ascii?Q?wnj98F8TnPmglOkmEdQi4WDllJ+a0hUEXY5/rKWXAYo66RvFMikBE8lq6Lo9?=
 =?us-ascii?Q?RRLC/9kePO89f5XyXQFvUpKiP9L1mQBxLUhmgwl4gbKPWxf2JgoXwlo6pw2O?=
 =?us-ascii?Q?RpM+dVge7qn9901SEZxLmfh+4r2liywGLzBNbY/ErK1m/dwn3FUFThI0xGTo?=
 =?us-ascii?Q?r+yzu2tXVfai0BaRKhALPC78XcTccmQ5aYswBSwo2vOBfwmw14VsB55ASCjy?=
 =?us-ascii?Q?vhTf77v4IruwDyBXgOVmrteLbGFT7HXwowN49BDxpVWTwXX7LpKXvWz5c2h9?=
 =?us-ascii?Q?NrWgwpkeeYjXAkwpEZi3ZAoMCakEMvYR4PMgxSWP7j5+XHkRGcS9r/hYPbHK?=
 =?us-ascii?Q?69YqhtKGnppLAuPfyFIo6dZOZYFTOR42398iSyzYmQQB96cSYsAViz8ejP3p?=
 =?us-ascii?Q?n4XGNoHpcnunz4nodIQ4pH/n/iPmAN2pkoZe0ig5ogDoi74rwDSQOWIzio0c?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ayW3HNKC2OuIjzExuFtQUjCSj64WlId8N70MXuaw0Rs5+KANKbgJXq8UHFDwUyfo32hNJPzFbBsRB5CzGSHQrjMFCxl21eNImKfaXRdvqTOgzXmgaKqhG6ctm76aHlJdZsJRvCUG2L46s4cdvJ4iwdKDpRNaO2bRZbU7dro99egrItTxTT2im9nJpQtYF4C4wmrkBppKsT6qSus+0apD/t6e785NtXCRHIqTKUVtCStgCSRSoZ3suPGktmDCn9opJtlQ+N0Tklcsdz8P85BDPQOzI5JffYpT1GLX2F27GVMm+Fc+1B3sQdkFvv9aiF080D4v2rQYXXdkjx73gtXw2APcKJudDqvtLaPfT/kWfvJT51UKMmNo7I2xWp0spkrKwEftGCoeAxtbOllqTudi/KRdkDWbjFouWf9PpX1CNnN6UkUmVLDFjI6zGUHcQ+h58+s37TdOf9YsYt5rPwrkrdUFIQGAOhsMfEdq7NlHHvUIrUghUcKjHwOv1Q3gTvUhrLzT8T44mdZmho8XRGIxuRnr4KbohYUMGsWl8bfJhqF5CYERZ7Emp+UMSfN1PuLmIbgH58zpMjBvwwNHB2Dw80ljTzd/fk8JT4iimV9GpNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1daf641-3525-429d-aa92-08dd863218f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 08:53:08.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2PAbg+ens7fXaRmh7U7log7kky1HNJvH2P8cFN5XCX7aH2tSYTF+6eGKXREsLmLM2eAkPFXKI9Fas/KSzEKEf6WezVOttSmeC8CejF2kIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280073
X-Proofpoint-GUID: qfO_VAChdX5WilM6omHJPtfb0buCXqko
X-Proofpoint-ORIG-GUID: qfO_VAChdX5WilM6omHJPtfb0buCXqko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA3NiBTYWx0ZWRfX4F7SfaUjj6OJ so78YzNgJ8tc/i6r4XlJJHCnlV3Z/MVsi+ULcXtWfi5lHgPFc/LbVCTzUeta13smC/aio6liNbJ jwNECu/5wRHmtQwLB/1K0Sq/QLMhgomLsv+ezaNm/k+vgUN/cEmo4MKfwvw9CZltmy5vAyUFu7A
 U1/dRY9lvEWaNsiZYxZrWF/hcDqW7lKbHwN8zWYmIQCv/CYot3BMegMi10O9PZaTNGswOF1UoOP YQSWSgcAH7Cf15U2G5XcpdBsJnB4lV2S+mFQn67TnzH0udwSDovlcukWQwvEgLS3MJGmVwnxqJ1 9NZrVj8sI9V2jkAdxHXRqOK0DIrfor7K8s0mt8gq213XEgozk6kHRvhII3ufuCctwuI7H2e5KLP xBAk52Jl

On Fri, Apr 25, 2025 at 10:09:34AM -0700, Kees Cook wrote:
> On Fri, Apr 25, 2025 at 03:54:34PM +0100, Lorenzo Stoakes wrote:
> > There are peculiarities within the kernel where what is very clearly mm
> > code is performed elsewhere arbitrarily.
> >
> > This violates separation of concerns and makes it harder to refactor code
> > to make changes to how fundamental initialisation and operation of mm logic
> > is performed.
> >
> > One such case is the creation of the VMA containing the initial stack upon
> > execve()'ing a new process. This is currently performed in __bprm_mm_init()
> > in fs/exec.c.
> >
> > Abstract this operation to create_init_stack_vma(). This allows us to limit
> > use of vma allocation and free code to fork and mm only.
> >
> > We previously did the same for the step at which we relocate the initial
> > stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> > establishment too.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/exec.c          | 51 +---------------------------------
>
> I'm kind of on the fence about this. On the one hand, yes, it's all vma
> goo, and should live with the rest of vma code, as you suggest. On the
> other had, exec is the only consumer of this behavior, and moving it
> out of fs/exec.c means that changes to the code that specifically only
> impacts exec are now in a separate file, and will no longer get exec
> maintainer/reviewer CCs (based on MAINTAINERS file matching). Exec is
> notoriously fragile, so I'm kind of generally paranoid about changes to
> its behaviors going unnoticed.
>
> In defense of moving it, yes, this routine has gotten updates over the
> many years, but it's relatively stable. But at least one thing has gone in
> without exec maintainer review recently (I would have Acked it, but the
> point is review): 9e567ca45f ("mm/ksm: fix ksm exec support for prctl")
> Everything else was before I took on the role officially (Nov 2022).
>
> So I guess I'm asking, how do we make sure stuff pulled out of exec
> still gets exec maintainer review?

I think we have two options here:

1. Separate out this code into mm/vma_exec.c and treat it like
   mm/vma_init.c, then add you as a reviewer, so you have visibility on
   everything that happens there.
2. Add you as a reviewer to memory mapping in general.

I think 1 is preferable actually, as it'll reduce noise for you and then
you'll _always_ get notified about change in this code.

Note that we have done this previously for similar reasons with
relocate_vma_down() we could move this function into that file.

For the sake of saving time given time zone differences, let me explore
option 1in a v3, and obviously if that doesn't work for you let me know! :)

We'll have to then have fs/exec.c include ../mm/vma_exec.h, so it is _only_
exec that gets access to this.

>
> > [...]
> >  static int __bprm_mm_init(struct linux_binprm *bprm)
> >  {
> > -	int err;
> > [...]
> > -	return err;
> > +	return create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
> >  }
>
> I'd prefer __bprm_mm_init() go away if it's just a 1:1 wrapper now.
> However, it doesn't really look like it makes too much sense for the NOMMU
> logic get moved as well, since it explicitly depends on exec-specific
> values (MAX_ARG_PAGES), so perhaps something like this:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 8e4ea5f1e64c..313dc70e0012 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -382,9 +382,13 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
>  	task_unlock(current->group_leader);
>
> -	err = __bprm_mm_init(bprm);
> +#ifndef CONFIG_MMU
> +	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
> +#else
> +	err = create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
>  	if (err)
>  		goto err;
> +#endif
>
>  	return 0;

Sure I can respin with this.

>
>
>
> On a related note, I'd like to point out that my claim that exec is
> the only consumer here, is slightly a lie. Technically this is correct,
> but only because this is specifically setting up the _stack_.
>
> The rest of the VMA setup actually surrounds this code (another
> reason I remain unhappy about moving it). Specifically the mm_alloc()
> before __bprm_mm_init (which is reached through alloc_brpm()). And
> then, following alloc_bprm() in do_execveat_common(), is the call to
> setup_new_exec(), which does the rest of the VMA setup, specifically
> arch_pick_mmap_layout() and related fiddling.

No other callers try to allocate/free vmas, which is the issue here.

>
> The "create userspace VMA" logic, mostly through mm_alloc(), is
> used in a few places (e.g. text poking), but the "bring up a _usable_
> userspace VMA" logic (i.e. one also with functional mmap) is repeated in
> lib/kunit/alloc_user.c for allowing testing of code that touches userspace
> (see kunit_attach_mm() and the kunit_vm_mmap() users). (But these tests
> don't actually run userspace code, so no stack is set up.)

Hm but this seems something different? This is using the mm_alloc()
interface?

>
> I guess what I'm trying to say is that I think we need a more clearly
> defined "create usable userspace VMA" API, as we've got at least 3
> scattered approaches right now: exec ("everything"), non-mmap-non-stack
> users (text poking, et al), and mmap-but-not-stack users (kunit tests).

But only exec is actually allocating and essentially 'forcing in' a stack
vma like this?

I mean I'm all for having some nicely abstracted interface rather than
scattering open-coded stuff around, but the one and only objective _here_
is to disallow the use of very clearly mm-specific internal APIs elsewhere.

exec is of course 'special' in this stack behaviour, but I feel we can
express this 'specialness' better by having this kind of well-defined,
well-described functions exposed by mm, rather than handing over absolutely
fundamental API calls to any part of the kernel that wants them.

>
> And the One True User of a full userspace VMA, exec, has the full setup
> scattered into several phases, mostly due to needing to separate those
> phases because it needs to progressively gather the information needed
> to correctly configure each piece:
> - set up userspace VMA at all (mm_alloc)
> - set up a stack because exec args need to go somewhere (__bprm_mm_init)
> - move stack to the right place (depends on executable binary and task bits)
> - set up mmap (arch_pick_mmap_layout) to actually load executable binary
>   (depends on arch, binary, and task bits)
>
> Hopefully this all explains why I'm uncomfortable to see __bprm_mm_init
> get relocated. It'll _probably_ be fine, but I get antsy about changes
> to code that only exec uses...

Right, I understand and appreciate that, for sure. This is fiddly core
code, you worry about things breaking - I mean I feel you (don't ask me
about brk(), please please don't ask me about brk() :P)

So hopefully the proposed solution with vma_exec.c should cover this off
nicely?


>
> --
> Kees Cook

Cheers, Lorenzo

