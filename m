Return-Path: <linux-fsdevel+bounces-30361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066A98A461
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530121C20825
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42712190045;
	Mon, 30 Sep 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqe4ji4f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KrKezREL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6018E77D;
	Mon, 30 Sep 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701872; cv=fail; b=lLIgqNn16RLbFfWjkfnBFMDHrpqvD32UdjlRMQpPcHH0Vy+QP2Kh++cx4PRwIeZ5TGdFQC86x7R6gjSc8DzDRz5omsdXzhsQrY7RUppCDK0lmuGD0puXJ2s9uSZcLMM+O7l89FG/omBB3jBxCy+xZQWlF8+NtHvHf538DgYcHO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701872; c=relaxed/simple;
	bh=os00Tf5EH/xtiQpP7Hof8WOlFURPOMnZxHWy1SI0vWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iH3WbQqUqV/Ku5fBsv/iHPag4nZM5yMJ7Ex1CRDpJ492c0tzpjggo3Gj8jWTH7gCDQzxIyCTZb7MwTSqp4fNk7mSB4+tdHFZtsuoD4g3Q2QtqaxRTwnJ1hzafZqvlq0rY3A3aXV1Jf7PkgjECsYWc2jhxHsidjZFCkeb8vrhn/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqe4ji4f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KrKezREL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UChmDE011205;
	Mon, 30 Sep 2024 13:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4QsBlYdsXkKFvKt
	DzrfwkiallVw3P09Q2zUvNrfhG3c=; b=eqe4ji4f75CTMO4kAWmA3PPDnJauOgf
	qi9xCIkSJJIXZWed7nss1TtoFoC9u/D8drVQBSBTF0t54TrQVvMc0MxGCwzfqSbs
	7ayb93k8e7I6v4f1lcltrYiSDKYAMVSkzI2NWkaIHCm2Fw0NtaSFaIbT7oL7zTMb
	dTtg07+frOMIsk9Swekm7uAkgbTtWLvfbsnHE1ALaVGrpWH7Xl2sUBq1C5JoxX40
	rCvyIDctiMHrLKaf0Ca5qwKYoB5lwry0u06GOYNP76tsXDya5x3QMlkfD5gcIJLC
	SkKx+GAZOfz2j73F3LC5zRrcV9TWp85OpBDqensJA1/4OBomddw2jhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3397q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:10:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC3bVX017368;
	Mon, 30 Sep 2024 13:10:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8860xdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDSrH2pbcQQyPGJPJoMUFkkSBQ+UUy1TrlXxJJB8qbAo6VKolWHxUcFgSsRzm+Tip2uzAWaYTLxY0XvuGyRNhU5xnlXASi2+74Q+rKC1EjaJbte1Ya2RLV9LjUAotT5IRVu+vRVmY7gj6N28OdG73aPwCMVx2zvnAsBAEla7LqJqwbLbHU5FgekY3l94Wwh/72ciMFhejQNeM8Y8UY/p4GMQAjPFapphUfTVJvGx9i6YdnR2R5H6bjx7OxwkIWCZlEXKfRpyo9l77Q7fNbmA384phQ9nOAA6rPEnOcxtt0wm1wABePqwjGuu/zgEfzYshSLQLS08i4w5LNXZdokEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QsBlYdsXkKFvKtDzrfwkiallVw3P09Q2zUvNrfhG3c=;
 b=g1HK8b05Ib/TdUXpD0JXxj/3stR5Ye0dicDqK1PdnZ9+EhtTirbaCjo3qNCIKM6HbpeujSwBV1iorrDA+khr1GDwZ3439n5iTtq6FcucffIjPH4qf5EzuvZbteS0u9DZL3CKQIpSHkrzP/hn5AjXQm+Uyuq3VwB+e51QI8Oz9UqAUGuLfdktNJU7ACK8F36pyFM0yvgjQZJV6vstyLbXqj8UB5Y55Iv89rcjEXEBRVFxuD/3C48PmdH3SNZMuPPw51ivftEpql9ULsyfh2Oy15+moKXXuOWjA4i8uB2i8IbXW+/+CH3JvLEpeHRlNN7c4jow0OQ3T4f0xowaG5SWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QsBlYdsXkKFvKtDzrfwkiallVw3P09Q2zUvNrfhG3c=;
 b=KrKezRELy3IzXxiCfmkGWdN5MJsOuscXRBEmWJoaRbcIkjjAWMlCTNNws5S+ynzbYL0MElDCsYOgu2/UliwfdD2x4ocgMK6esws8vJnImqWLs4lbUWE1oTEH1vRM2tVRhmyk7iKy1Fx8ONPtDHcE8p4NX5LPubaUGiPhz8Znskk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 13:10:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 13:10:53 +0000
Date: Mon, 30 Sep 2024 14:10:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
 <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
X-ClientProxiedBy: LO4P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c15bec8-f821-4372-3ffa-08dce1514ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tg0X9BXIQ/rZP9c40Re59vV706uAmaC+/0NQ8gAhAO3VQrFeZBJ1JZ3frWA6?=
 =?us-ascii?Q?Qfv+jTsoEYMqUyE0AUsXRZqlWxKnILTKBTjzKiyC5QIOrciJyGRQksDRrpkF?=
 =?us-ascii?Q?Wgv+LI1p1uzv761FIE9g9Pu3He9C8xe78dOfCveQ59uy4s1kyQRv9zTb+WV/?=
 =?us-ascii?Q?FGX7OfZ/YwEM7DF2FtCMeGb5FWMqNEi+kuv+t3SR6zjJ5WSrnhzIR7mjP2dT?=
 =?us-ascii?Q?FKRLE6sRVjTFIpkR26g3gfHiwLXmNhy0vuee0AfgDD9x6otSEq+nnSA34uYe?=
 =?us-ascii?Q?AyU3I2HU+ajcMAwiT72OeR9OrHtMClCTSmhjFBEe5udAXaihKta37v8CE1Ry?=
 =?us-ascii?Q?o+a+Ym8kX2OYUI36OHRt5bGp/s0Xdv+xW4sexi3Pdkkc7u0oiICL6/1wCAdC?=
 =?us-ascii?Q?61D8VKrvgvCVElcOE9bOxTrbkuZZjGzreDsshvdYzzJLj8cdy6N5y1dVldSv?=
 =?us-ascii?Q?Zu1Sqr2QFsQ5TGg8saRCRlXjOTfpsnuBxx8pSKVcTCRtBMM9u6lWL3fB9aUA?=
 =?us-ascii?Q?jZn3sKHr6dqpVlcXMQ/HD8KZ/gA6+FnpHeqYtlECPmaWJijXuFkivsQBt8F7?=
 =?us-ascii?Q?6R7u+d0DGhIHrsEqRy4Rz35+ZWeNcho4TjCGmb4kZxjFxlVdvjlk753oyk2a?=
 =?us-ascii?Q?rHGvw80jYZ9mN8mULI+ANkH6NT2+tpzd892FlQV3JvbDKdsO3VQuh8bO/s69?=
 =?us-ascii?Q?vQYPAI1hawypRGsLKFpWH96fCEDhjnLWHDyWm8xtn1PuyK84y++xAiPl5HAJ?=
 =?us-ascii?Q?uZ2QxZ9foAG+II8OtPX34mR8nrkcaTPA3+npHP05TCnEYp6816OVei9wxMHp?=
 =?us-ascii?Q?zcu084o1OGx6p2bqtX8OTWMJfL15KFPDgbYCBaWDpozgVImlE7qYxa5BHup3?=
 =?us-ascii?Q?eb+Zyc5rDZwjIpieK+UUTEX78AGzu2TtSE2IzrjF3TkcsXo6HxDcTQb7xHob?=
 =?us-ascii?Q?qAA9tisP+Qhi9A1zZGGvXIOQhsy0IYsJUXjvvRFXPY3vp7gOHzB7C2HDKXdE?=
 =?us-ascii?Q?A6A8B7wqxUzHzGNOG/p1CkWn4JWba5CbzGW3T0hZkHW9QVdVXadLIHuUZk4Q?=
 =?us-ascii?Q?ewpoAc7JanZask7TpqFmC4rEtUdWgJjsyKcgReU7K8iFlJQH/2Ud6wCIENKE?=
 =?us-ascii?Q?Zllyf1SAwWsYAvxSMZCjO+vQoZsM25L4oyTOXkTlrFJVzTjTVRTXHyQ4hf+C?=
 =?us-ascii?Q?djWoNguZrF7667l0gYFhctRPVLC0KOXnfJZABKxUCLCeuJONZxVDDwdytZPd?=
 =?us-ascii?Q?Z3E5fEpcNe2gkX2ozZo0ZRmlBAablNOdFLUgsDgfTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7rDDyzVvYajNhWzwiIOD/7sqC3E92fimPRoZwsbsu/gmLagt2i1508LvdPE?=
 =?us-ascii?Q?tlsLgEHyoxwkTIst14fYYEX+JCMXEGbwnjl2d2lEHsk23mLpg2PbrVvp/KHm?=
 =?us-ascii?Q?/HEZ72AxqnMTHIBD5QDyVbOWumQeXA8yTdrv+V7yFZ3eyVkR1Ax36tS4OwZf?=
 =?us-ascii?Q?Yp1O6AF4iRI3z6KV9TTn0pwg7vDJVg+lO0JiXuAfnTl8yYnmaTstJJRi+sUu?=
 =?us-ascii?Q?4p4rqU36shTa7xokImuC9w2aTOF0fB4OIqexW1gUuAWaHls9d3B/baORASBH?=
 =?us-ascii?Q?s8yMmbJF/yL2zWWoppUVzMHJ7uTMrPZtDZAhryMdm0LSuMON4kBFOXMGtv0N?=
 =?us-ascii?Q?PVwKltEIWnaCLheRNd88BXMzzVk7BxEBIF7cof/dvmdlUedXDd1M5PwCeigF?=
 =?us-ascii?Q?lKK3pb4k0+4LnjloLY+eFrqYS5qXd94YF1bni5Y0yO9I2uM+SJsgi/+Aqb0t?=
 =?us-ascii?Q?+ztYfNlcIZ0/DKGB4yp2CtyRxFsWP6UHiij8dPrx2PZq+AVab0b7RGgmz56p?=
 =?us-ascii?Q?nbksRtLzdTt8lvzesnYC+oqKaPFYdvi8DCdhKN76HfldPN7ra9UCcz830RxQ?=
 =?us-ascii?Q?91FBsfau9ecuACWEjdEUsCBxaVUdauIxU5B3vwsHM4InA/yNgUyNkj3rXj/i?=
 =?us-ascii?Q?ec/R3ghC0mgyyPMC4osdyIyMNnjFGBupcHJW6NI7QK+yJJiTwN2ot0fW6pfP?=
 =?us-ascii?Q?YkOWAVCDhviN0legkAEhKR/FfL8EpJ1KSZqJ8oezyn6cynjjAZ616egSY8MX?=
 =?us-ascii?Q?l+mY319lEOT+E9ei7YUBwjN3aIhfD6sZXHIdOjHV52z625wR+zTLmHi2xqn8?=
 =?us-ascii?Q?yZ86b1CbRy9/BMuR+O01SdEU3q1t/URuOM198y1P1CHjGPeV68Q8q4WArDun?=
 =?us-ascii?Q?Y2BZYBE8MqlgiYqRlz6OKER62rnTnKhg6KC0RhuIM5dr2XmtsGoVSsuwLLwz?=
 =?us-ascii?Q?cmCeA8jE6DiHiMBHSN8o5ktwpiCbGUrTo5D7oXAxWlA5dchzEk25IJnitmEp?=
 =?us-ascii?Q?DUyJboa4H5RIkggYiPIvT/XnqpfVOh9vcfkXYRVwBDIWAniS5Kt9GDqMpdEk?=
 =?us-ascii?Q?JhDbpkKLm4B1SX6icZvdMRSxNb4hpK9lD0Um/jXBr8jnzS3hhpna6K72umTc?=
 =?us-ascii?Q?aIVyXb6G0rxl9e9vURpUA5NvVEaeLwLoGctrdljG4paraVb+/+u7G+OoaqdW?=
 =?us-ascii?Q?fTfPpxy7bB8Vt8d1enQfT2EadgoRcTiFie2gRzeMJaBcG7dfjA/Q6Uei1n8Y?=
 =?us-ascii?Q?mmFU1LhoEpVqBoMBT/WgtX5qXBcS/lFzoKpvmCGE5+3qSU/cVcQ25xyQ67Ir?=
 =?us-ascii?Q?I8z8JboM8bXTmgwpZuUxoH7daShuG2OueCtZsGoctDUCdPWUwPYMlw/DM3eE?=
 =?us-ascii?Q?pZgs9QABWqKlc4LIxJy3Vl0wITWDf3Q3FFRTroyIjX84WI7p4VCKl8r4YA/v?=
 =?us-ascii?Q?XUSKEbOC08dDZsaYPGmhwtIdnJ67dn0ZNsBVphWoosv5+9pFQMyBjI+Hpsyi?=
 =?us-ascii?Q?qJJBom/+cWDIfSapVJiQuzALkQuw2U0t0gR2eB17dRdX2CF4PLmGXtc4jGls?=
 =?us-ascii?Q?RZwUY4NjD2fGPqol7o0JzhujOmVuFXbfe2onCJDWNFXJZcZDP1rtWl6PsqqM?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iup8l0AupyzehP56u/TYwW3Utd0hbcRA70ZbyingWN4WsZp/hVU3zWq7V8k0fi2VgjBlCh5Ztbah+T94tqJNQ8snRh2G2yCjN6xgxJPxz87ZpTeXqFo1AwtCXevzs0mRxTpqYB83DHMKihB8Objf/rlHwomfK9jbUwdR5zyxQU0clgPtCDi6un/w36CsxcjX2DHlk+a2eYhSnCzDYflzJ0HkHs1/vutQZbE/CQPYXEMjS6Nppn+wBMTBJ2L680yVZWVI4F/FOKUZ4Tc8/n9X5fG1AxE87Qikgb2N3L7uvWWfqfw5rp4II4dhYKh3WMnK3KHubn6O3lUZaVKp9YMGDejnUBigZbWUQhOM+dMjaxOY8hLcaZThlU4AioE16l9gX06wCxZx/V/QQnraSrbkvelax2z1zZzcE/Pv4x8wgbiL+DGI5SAQrJEnhUE/y/GTRmLdRpcim/sljVfizM3Qa9ISq6LbdDn6C9Hv0T2WcMz/s0HEQrfE9lH6N8Amc9Q6ip0tFSEyJp1sBDxRrJGmKt3jNsOk7k7Qd7nJ49UprUS+tnT1EpK7vmpX5MgGAPAIPCbIyD66OkYcAxKHuB0Wle/imtl4vkn+ZG8RrMA8Imo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c15bec8-f821-4372-3ffa-08dce1514ff8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:10:53.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3cB2Bw5giYkIe7OiOY1w1Y0u+J1LAzVWo8my+84/RzyhkUYrHQCkM1toAUAtKamAkjy/7/vziBnjM7EnyK7GK0f7voJIFD6EjYzVzsKK/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300095
X-Proofpoint-GUID: cHJQ-XzXq85wG8l9nYDfY5tPnGMmjRlS
X-Proofpoint-ORIG-GUID: cHJQ-XzXq85wG8l9nYDfY5tPnGMmjRlS

On Mon, Sep 30, 2024 at 02:34:33PM GMT, Christian Brauner wrote:
> On Mon, Sep 30, 2024 at 11:39:49AM GMT, Lorenzo Stoakes wrote:
> > On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> > > * Lorenzo Stoakes:
> > >
> > > > If you wish to utilise a pidfd interface to refer to the current process
> > > > (from the point of view of userland - from the kernel point of view - the
> > > > thread group leader), it is rather cumbersome, requiring something like:
> > > >
> > > > 	int pidfd = pidfd_open(getpid(), 0);
> > > >
> > > > 	...
> > > >
> > > > 	close(pidfd);
> > > >
> > > > Or the equivalent call opening /proc/self. It is more convenient to use a
> > > > sentinel value to indicate to an interface that accepts a pidfd that we
> > > > simply wish to refer to the current process.
> > >
> > > The descriptor will refer to the current thread, not process, right?
> >
> > No it refers to the current process (i.e. thread group leader from kernel
> > perspective). Unless you specify PIDFD_THREAD, this is the same if you did the above.
> >
> > >
> > > The distinction matters for pidfd_getfd if a process contains multiple
> > > threads with different file descriptor tables, and probably for
> > > pidfd_send_signal as well.
> >
> > You mean if you did a strange set of flags to clone()? Otherwise these are
> > shared right?
> >
> > Again, we are explicitly looking at process not thread from userland
> > perspective. A PIDFD_SELF_THREAD might be possible, but this series doesn't try
> > to implement that.
>
> Florian raises a good point. Currently we have:
>
> (1) int pidfd_tgid = pidfd_open(getpid(), 0);
> (2) int pidfd_thread = pidfd_open(getpid(), PIDFD_THREAD);
>
> and this instructs:
>
> pidfd_send_signal()
> pidfd_getfd()
>
> to do different things. For pidfd_send_signal() it's whether the
> operation has thread-group scope or thread-scope for pidfd_send_signal()
> and for pidfd_getfd() it determines the fdtable to use.
>
> The thing is that if you pass:
>
> pidfd_getfd(PDIFD_SELF)
>
> and you have:
>
> TGID
>
> T1 {
>     clone(CLONE_THREAD)
>     unshare(CLONE_FILES)
> }
>
> T2 {
>     clone(CLONE_THREAD)
>     unshare(CLONE_FILES)
> }
>
> You have 3 threads in the same thread-group that all have distinct file
> descriptor tables from each other.
>
> So if T1 did:
>
> pidfd_getfd(PIDFD_SELF, ...)
>
> and we mirror the PIDTYPE_TGID behavior then T1 will very likely expect
> to get the fd from its file descriptor table. IOW, its reasonable to
> expect that T1 is interested in their very own resource, not someone
> else's even if it is the thread-group leader.
>
> But what T1 will get in reality is an fd from TGID's file descriptor
> table (and similar for T2).
>
> Iirc, yes that confusion exists already with /proc/self. But the
> question is whether we should add the same confusion to the pidfd api or
> whether we make PIDFD_SELF actually mean PIDTYPE_PID aka the actual
> calling thread.
>
> My thinking is that if you have the reasonable suspicion that you're
> multi-threaded and that you're interested in the thread-group resource
> then you should be using:
>
> int pidfd = pidfd_open(getpid(), 0)
>
> and hand that thread-group leader pidfd around since you're interested
> in another thread. But if you're really just interested in your own
> resource then pidfd_open(getpid(), 0) makes no sense and you would want
> PIDFD_SELF.
>
> Thoughts?

I mean from my perspective, my aim is to get current->mm for
process_madvise() so both work for me :) however you both raise a very good
point here (sorry Florian, perhaps I was a little too dismissive as to your
point, you're absolutely right).

My intent was for PIDFD_SELF to simply mirror the pidfd_open(getpid(), 0)
behaviour, but you and Florian make a strong case that you'd _probably_
find this very confusing had you unshared in this fashion.

I mean in general this confusion already exists, and is for what
PIDFD_THREAD was created, but I suspect ideally if you could go back you
might actually do this by default Christian + let the TGL behaviour be the
optional thing?

For most users this will not be an issue, but for those they'd get the same
result whichever they used, but yes actually I think you're both right -
PIDFD_SELF should in effect imply PIDFD_THREAD.

We can adjust the pidfd_send_signal() call to infer the correct scope
(actually nicely we can do that without any change there, by having
__pidfd_get_pid() set f_flags accordingly).

So TL;DR: I agree, I will respin with PIDFD_SELF referring to the thread.

My question in return here then is - should we introduce PIDFD_SELF_PROCESS
also (do advise if you feel this naming isn't quite right) - to provide
thread group leader behaviour?

Thanks!

