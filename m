Return-Path: <linux-fsdevel+bounces-52247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61839AE0AD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ABA3AE03D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83097239E93;
	Thu, 19 Jun 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nuwuF4NS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tmZ6cv2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA128B501;
	Thu, 19 Jun 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347916; cv=fail; b=ZMfbFi6N2yG67/9n6+7Z4+85W9vPkyJfFPKr22VJP5cn2W7wwpQRaq7r34BW8M5D2Fw77c/ODCdcQ9mGaOPGwBQXBeB+CZNYvxxaVfQU765dqtJXbVEw5ZBW8WvwcSDH3Tsjg+xsT0o2840ajcQltfYba6zilzhjEwZUeaTIqUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347916; c=relaxed/simple;
	bh=8cWnP9F3OMIGvIC02HxtOs1dF2fPLJf7sxayV8P+X7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l50S5QkQsOYs062z7wvb+1oOKfV27PRofBp/2qIHz12iZAWEDWmLOypd0TUsz9uA90CjJ/rz/WAaR5RoDP6Csc7wDK1bHK6tOxoofXENH7+tTvI+bUi5p/5lP2vL2w1vUsRr3nSHmTza0mOXIp/bDDdUtS252RTHN2+2zSxO8sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nuwuF4NS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tmZ6cv2d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEMZPH025805;
	Thu, 19 Jun 2025 15:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pIim100Oz83hxbABDUbbA0vVqkbB2CpkK2efxBy9U6k=; b=
	nuwuF4NSsrN5ERww26N3gmHuFQqU/t6KEabL+OTx5OInjPXhug82hTCSwJV4+mlG
	803lWxJUhcjZawwMQ3994ZfpJTgaLXU6+5AeZO63xkHJUdLiL0WvDsQzhbkLHCx7
	bPpA8Jggp1VJM/X6QRdo5Rx78puBs5ZK5hp5srJbHSJg9cvSsmSxK8e3s/3886fF
	ztBOU0VkwI7SJkY5ZafZ4YIpg45vgkMiQkuDPb8ul6WPqXm4Jqr6tqp67nXjbPqV
	3hN9OZ15uxKMM1Ki9uHmY4ejv6LwUwtcJT1ifljcJt8gtmOrjh1Um3yHAI2q/IvU
	V3PYxrrMNhVfi9gr+xJNMQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv5a35r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JFZsQ3021703;
	Thu, 19 Jun 2025 15:45:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhbsnh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjuss/dC/ctYAhMzoIMnTHAWs5Lx0ct4mYDsPj0czw7C97zGzNiqoi8JDj+V19Co/gZaoFb0b97YbiITiRP6OAw9IDUiEdbiaCHaUJiwlqAiAFqQC/pQ3it6RuFGNfMNxAD/xcLTXfRe878W/XffhQy6ahQIR70seqJlw9yYzd9IhiWum5UTcEv6KCTcpKaJEKHua9VbnkODP0KOj6bv67TYn6Mhdb8kRY/UBLaxrZZOxIsvGZlXSDV0hzjOCoboWZsFHf0b4RsirSVKd4NJjKxx8uzDQFBQ8ATHHjtKTFq2W96LNkNB0CICASwebW2UslK4WDgB1CDR7wAK+L33zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIim100Oz83hxbABDUbbA0vVqkbB2CpkK2efxBy9U6k=;
 b=AXbWxLcqQouEg/H0lnEdsis88OO+D+SPZ0DwVR8Kf4xBfIiW0VtGIMtXAZZD1YtovPK/Mke4fHzFVFDLezIZzSwon36afGpsxV45ZVcFn9J5fajgQjILv1rx2M8oM2kipco6fu5SdLiA/VBLf2TwtT6M62csKDYN0D4ZPgfMszcAn0lnJfjOdGIE2gGy18f9PbwGodd34/xOAmLdMF3KverrvNRbu/7/14zZC9VqSyeoBN5tG4F8oVDuQOn4/ry2oA/Ik1BZblDfNB9MbTakwJ9NnJkfrKL1Pw+WRpxMTcKCmdcsCvxjkXWNlwd5GgJUVp6uRG+Ba39Zuxjd6sDf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIim100Oz83hxbABDUbbA0vVqkbB2CpkK2efxBy9U6k=;
 b=tmZ6cv2dqxwp010XuETmCBw2fDSZJtsMCYyYsjgWeja4TcQzSSRkgkCZRt8X968VPywAHBPMr/y0ifHn6HTfTrPorXamCaIuKInsKSBK2FdRt+bopp2kyel+1Rk4xRuaYrIpZw1KcLbj78nDC9pllxbRonuXVSPIBLLN+u+UgHc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 15:45:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:45:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/2] statx.2: Add stx_atomic_write_unit_max_opt
Date: Thu, 19 Jun 2025 15:44:55 +0000
Message-Id: <20250619154455.321848-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250619154455.321848-1-john.g.garry@oracle.com>
References: <20250619154455.321848-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7735fa6f-bb04-4eb0-8f42-08ddaf48422d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1wvZ4uBpVPN9IhA8VALlvXmg4Tco2jsmvlWDJ8F4ldhot6GBOWXyhIoFunV?=
 =?us-ascii?Q?TyQWP1qG7umlJkgDc3huuykCR/jHf/WqMdSDWl7lex1PlKNdPqFv4faYGbsv?=
 =?us-ascii?Q?pMkd7lf5h7cHsBxoCdEGHNvPzeYplhhmrypdnrkamH9pSl86IXJFxN+Sllg/?=
 =?us-ascii?Q?lpiiV7tG4IGtBvjtpSeWfzKbWh+y1Uv+uWZWUqPlI4H/Ua2r0RTWENmukqH1?=
 =?us-ascii?Q?Oa06uJ+fpR22kcUWy2t1LAndr0K3BIsU7+1fS8/UHmf/JJjnqSrHkww+RE3u?=
 =?us-ascii?Q?seB0AbQT5gmVM7yOBDehJt1X/jL7JdGE7leT90Db78yEn9+uM2G71BWAgFAs?=
 =?us-ascii?Q?vmOdoP01zB8ycZBUjxGUIZLhhkfMNOR/VYs0SRKhJt2KD4kF2sW0/eYttKVo?=
 =?us-ascii?Q?KxPU1qRxjfv54QXBVLVlKJvxwdJK7O71wq30LZAghKzM+TGRNJaqTjomH+H4?=
 =?us-ascii?Q?4vzfUApr4e9io/3DM7WwtNN1wNDpTyo9syDr5Z0HjSnx2B5wUxrnBvNA8cFq?=
 =?us-ascii?Q?nkUcigHd4H2aBLKOtwkK4fY44xZZz4Nq1h2uodb3hmaLbGBAJ8ljsH9/iniG?=
 =?us-ascii?Q?Nc4dnFwMSnLn1tyM12nwv6l9dO0QKlBKjl9N7ORXaCwqC5NqdhbNqTmJM3CM?=
 =?us-ascii?Q?NfZHOWLOBRoz85a0l8IW0Wcy0aA1vmXNRHkW6MpXcmUGPKPB6OPV93M84xyW?=
 =?us-ascii?Q?sMp3r+quVV/GWcmJ2KZMxpQf6uq+mJLYp5jvERnl1tCdI6MVa/ILQUT37lf3?=
 =?us-ascii?Q?vx87bQcg8HCjLmV5U5qEalhLt0kwZYOfLxGXxlzYDIj7qoyg33fRHjWLvSrX?=
 =?us-ascii?Q?KzTtVkZUQOeUjn+TZhfBdmgmKJYWzFoNUfBVNi1AOqiZroAsyHmPO+trgFbD?=
 =?us-ascii?Q?N5bvJjTgiChMpJJbv9agFrFf6LIuTfBzRn1IoKoBE2PLwCH/JOI557GkZiZF?=
 =?us-ascii?Q?CEeogb+LL+y0LUy1G4ZC6Hoh7DH9ZwU7nmHylmrtrkcuX5sTagY+Ofog6KmX?=
 =?us-ascii?Q?erftxFEVx8X2zNQt4gSvknqpf8IcxWpayah+rzzYl5VFgrBG5nMf7Y1DE6Cp?=
 =?us-ascii?Q?LujA9p0f98lzM9ztWSVm8+l+1uYClG0Ec+yyX6P/qBaJc4GQWu0YWkxI4MLw?=
 =?us-ascii?Q?xJElSBwrVdDVQDB7VPNr0dii1hRK+ROKeTyXGxa3+oT1t6VxUI/uTJjUp7Wv?=
 =?us-ascii?Q?Pm1oajsyMwnRWVYaiw2yCbrTQ3YoBUXiF/p7Zlf8RA+uQjClXWDRUFp3cJK6?=
 =?us-ascii?Q?Tbyisl/qyRxKrV+B+mi9G/JXOeNEOfyZ9AboWrWDN9eFZ25kbtzYWGoY9T1H?=
 =?us-ascii?Q?xg3KdChO/4q6bryu2ArEi6+z5q1FIxmJh3fCJr4mNfUGP/QMGY03GUIEZT2V?=
 =?us-ascii?Q?pnGzaOIBmksVw+UvBZrcR2HgCpVgDKCrToEC/j8Y49Tv/fqpYa+DIL2XYURH?=
 =?us-ascii?Q?N2NvCH7ighU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSZ0W9mVlG4+mGZGElFgmZoXHUICyFYN93S7BJbrUdnyWzoShxp1N/329A9k?=
 =?us-ascii?Q?7eUgk+05vNkm8TTV1gTLRsyetPlEi1hMW+pdOb5x8PcI0HPZIkaIscohLxIM?=
 =?us-ascii?Q?8yFQkIkCMnXq4hiKQl4qV2LPb7C95MgkngqRycTvgBYh3DZco7ZhwYvV5aI1?=
 =?us-ascii?Q?nt2mKNvhrfdLPMUbof/RT6tiTtsXwYrTYKtqk5czdK+Hpz4L84q5yCU4Hc3U?=
 =?us-ascii?Q?DfZzC1OKq0LvBxRoyF4+kUCHt8DRbfkjRoJjP71OaNudJJiHbduN60u7qerT?=
 =?us-ascii?Q?MMtOHRqTgnu606kTjzZuaL2Hx+DOWx0Ze+pLn/v+P57KHcThiVYjYfSvev/0?=
 =?us-ascii?Q?fZDgb4lmQGE9Y8zjn6BxKogB1nvPoF5Ydg5ar2/R681IPjCPp73BRUlRC6LQ?=
 =?us-ascii?Q?DeTFTevBhohf3VZzzU2XIPl6GoOxqyFdNi/EuFzXC6Oqr3r72kn2EJiB490M?=
 =?us-ascii?Q?FTX8NonKgdKXgteuDPMTKE7W8IGsyhzLtnJ9upIMvh7Be0kSwhT7Wtdjtp+2?=
 =?us-ascii?Q?b85AzXDGUSWTOOEzCDCvH6ux0wFwrrlpQjjtsvny1VA1noBUkOG1L2vHVLKg?=
 =?us-ascii?Q?CpzHIe2eVA8WBEv0Jht1aChFv+++J/bbYQcyjeXT9Y1x2QhH8w+UgUp4RRYy?=
 =?us-ascii?Q?h44K/KOHDhqdd39bdhSOtcw5KEiKoKpzIKc0Nd/+cksG/2vHayBnK1L8/Mnb?=
 =?us-ascii?Q?/CEvxWNJ+9k367zwCPy/9Jqq+PIlVMKlkpD6xgF0ARVfG7iz+mMVgboWyIEL?=
 =?us-ascii?Q?dZImXmYStydE5AXkcwXmapuJ6g44uhL1qUyVOQIVGd/qFIW47Zhc/Gq7WeMO?=
 =?us-ascii?Q?gRFmkc9P5BeHY6eT0W0KtEsIjrUZRLUN5nv+s0yTHpiqvYyAdwXWDNk9LuIB?=
 =?us-ascii?Q?Ct+RVEJxzvCm9pijREBMdqtz1dnp33own/nCmMCjWrRO2gmVXYcWXYTdUkNs?=
 =?us-ascii?Q?/uhk0a0M/IcpwMjd/KHhAiTXQTHOabZR8fnqLEZkasm1KJj26jmf1TMK7FEK?=
 =?us-ascii?Q?TrUFtbfqlTgiyakOom1tiitZR7aXkXoKXId1PrEiHH02+H1TSP+kFvcYn4m5?=
 =?us-ascii?Q?7SFh1H+AzFhOkuaTAkuoP7IO7sIBCiiWjh+Z82hb7gnujq9weNZozIj1eVuf?=
 =?us-ascii?Q?V22CKaWDWUZ5t+4gSSusNcsdESi0s+l7zfkuXwIgKk3D2DswgVphcitTXwu6?=
 =?us-ascii?Q?yILgHq/DGCBVxmXFVoUBEXszq/2a3e5/h6yIZZP/xN2cydu94E7hTb6883lm?=
 =?us-ascii?Q?v3dPJYN0NBx/Cg8L/BkV3DHFQydKj3HhotscodJc6ICzHi15pmmFh6ZxpQkL?=
 =?us-ascii?Q?v6BjSrU6ZcFFE+J3iBRztE1nKmR7XfjXAHybEo64hqW6YHGpi+89pUFmA3D7?=
 =?us-ascii?Q?toY0+niO04jdesDM6rkPtCNRxl4jhdSk94u1UoCeAnZeXbprBa/YAWbb2Aq3?=
 =?us-ascii?Q?rBbLUzbBkkp+pdWFNw7KB9R230sp2S75CmGYfsDKB9wWugSSlyoiK00+4YOW?=
 =?us-ascii?Q?HNcV5kjoeTruHAPddxnKjjX8E74JjqdoAOetvrum0J8UOwm6Jc1cSuSB8mWk?=
 =?us-ascii?Q?ubZWaE6lmZ4FlwJZQjWgT4DbNSEG00V/WcgCm13URXuv+KWDFmiQvfBS3xwb?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CW87PI2njyJhDiLjYjdHcw+Zqtc1zryxB0BKwc7c4As9Jqe0uSpHPuPAkd4i0FNfzYRYPqq/KB5GIx77erQDZrfhrkPpxw2pOv2QQO1MKS2zZxp2BKiyDoiwt8MiluaKArWacF51DIj93AGQOf6ancHbCWWuacLrA/jIOVXccWcyJkWslPcz5Z0r4FLVdJnm6sgJo4ndsvE/lJrh/IFOc1buSrixP394ci7DGENO0AYJamwNhrRJV9vdGUwuge7iEkJpLw6V06Gl5opNkmX8MMZ3IMOlIkPmj6j20oHRkB8TJWDHtNP1PGa2Ze6k0ixmtUorBdjKNq6GX2kFzQ3qaq1xCBUJWglZZY8aJjm+M0WyxnUZUAtFtZ+/ezDzPfiLiqTlUPu4FaJQsy9BzXKKer2T3pzbjkSLNQjL9o4vgdTyu0HC7A0vVmTA6HefSt1DFjQUwTgPmHeuBB5ZPngV++sinxuXED8haL+lZjPmj/jpiFf60j2/WQ+m/y6JBPEl/ICL05KNci7r24w8GR4PhZRaD1I9rF7UWy1b9bjwuuGMZfCdqHTxuMN7nog/TFTjC7RCNJTXgs27eQcwRr5GIyMruca3KFG890MHZUay7wE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7735fa6f-bb04-4eb0-8f42-08ddaf48422d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:45:04.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/r7Q9LGJlMbk2Wq9xJQYw2iT0YvOU9eosrvnXxScZ0pZqUAMrQsh8Guz5QTRoqlbLtghFNU2b62oaeZ6wsALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEzMCBTYWx0ZWRfX8uWaVdSfRWeo xqqm4Kw9pBP7B93sBshrBYYuYt2FeQ6/RU+5sWnOFsPO4Ir0IHVb1Yeu9wQi53GA9r6geRCMOaC Ne+NbHvxXtNGynAdO7oV/DXnEdNsDUqnJMSPYjzOnQG1PEfr5mWlLM3I4+QjHt4LgJv3nzZtY5s
 19GM93PYOiOobF0mA9I9ozTCbRTOcad2dS3NM2zNL/O/aAZYYVJEgd9imvLPRQAqy23Z8SygZe/ 69mPe9RSOAZhGMron8gEqgAA/2cCzGXoEZMdtEFMn12cdFb1wl/YyMD2ZYCcGWgHyekhYV0Kn6p E2WBpxlBfovwqWWDvspCpQlYvcTXUQzsOf+RIHyeyO+7TiYF/05AzdWvDoRWdH2mRieZ3z1jgpX
 2fC0M2TOt3NFuwugXfsF3mepk1ZDmgLNxun3xJVVSdjPhCub+jvkUhFhJ0ptuE6ypADAJm/D
X-Proofpoint-GUID: mxNZlVCyNXrsHRlqm45DFivlOB63chw_
X-Proofpoint-ORIG-GUID: mxNZlVCyNXrsHRlqm45DFivlOB63chw_
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68543085 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Rdy2XWu609cXCubfEXoA:9

XFS supports atomic writes - or untorn writes - based on two different
methods:
- HW offload in the disk
- FS method based on out-of-place writes

The value reported in stx_atomic_write_unit_max will be the max size of the
FS-based method.

The max atomic write unit size of the FS-based atomic writes will
typically be much larger than what is capable from the HW offload. However,
FS-based atomic writes will also be typically much slower.

Advertise this HW offload size limit to the user in a new statx member,
stx_atomic_write_unit_max_opt.

We want STATX_WRITE_ATOMIC to get this new member in addition to the
already-existing members, so mention that a value of 0 in
stx_atomic_write_unit_max_opt means that stx_atomic_write_unit_max holds
this optimised limit.

Linux will zero unused statx members, so stx_atomic_write_unit_max_opt
will always hold 0 for older kernel versions which do not support
this FS-based atomic write method (for XFS).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/statx.2 | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 273d80711..07ac60b3c 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -74,6 +74,9 @@ struct statx {
 \&
     /* File offset alignment for direct I/O reads */
     __u32 stx_dio_read_offset_align;
+\&
+    /* Direct I/O atomic write max opt limit */
+    __u32 stx_atomic_write_unit_max_opt;
 };
 .EE
 .in
@@ -266,7 +269,8 @@ STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
 STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
 	stx_atomic_write_unit_max,
-	and stx_atomic_write_segments_max.
+	stx_atomic_write_segments_max,
+	and stx_atomic_write_unit_max_opt.
 	(since Linux 6.11; support varies by filesystem)
 STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
 	(since Linux 6.14; support varies by filesystem)
@@ -514,6 +518,21 @@ is supported on block devices since Linux 6.11.
 The support on regular files varies by filesystem;
 it is supported by xfs and ext4 since Linux 6.13.
 .TP
+.I stx_atomic_write_unit_max_opt
+The maximum size (in bytes) which is
+optimised for writes issued with torn-write protection.
+If non-zero,
+this value will not exceed the value in
+.I stx_atomic_write_unit_max
+and will not be less than the value in
+.IR stx_atomic_write_unit_min .
+A value of zero indicates that
+.I stx_atomic_write_unit_max
+is the optimised limit.
+Slower writes may be experienced when the size of the write exceeds
+.I stx_atomic_write_unit_max_opt
+(when non-zero).
+.TP
 .I stx_atomic_write_segments_max
 The maximum number of elements in an array of vectors
 for a write with torn-write protection enabled.
-- 
2.31.1


