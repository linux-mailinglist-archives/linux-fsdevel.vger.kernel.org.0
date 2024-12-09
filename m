Return-Path: <linux-fsdevel+bounces-36798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC59E9766
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899BD163C94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB0233159;
	Mon,  9 Dec 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9p/oaRN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U8MVWcrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5035967;
	Mon,  9 Dec 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751792; cv=fail; b=mcJIuGbLCDt9E2sbNSKI/im8kXckK2fAXwS1QlEGjfW1Shuz2OykA6G1/w3Bz/riR0NN7yGlH9KzDGgcXhXPBiQx2OLdJWfin/oLBb6kLlsstTFDWbi0pPo4ovK0UJ5u4v4aSjXCr79gTzKAZDRhEN4Yw+imSrRdyaU+UbNxGBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751792; c=relaxed/simple;
	bh=Bixfsphukru1M7Ue+Ya6HzAQhn2TcT7rvWVNuyHF+4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mgWH15Fn1gPVo+rcZ8cim24CYaCdoJ+McAnwQTANJoqBWJ+iQP4thxU/Ajn2NvKF74d2amWgSY9LhtO3WiKApi4CF8p0C14fRTchhbv/CKyNSeiAWTO+6rQhJj1wdawgMNmCpdZlQGiaGxLBzwUNbz9lvxpnZZzsalpvkHFUyTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9p/oaRN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U8MVWcrn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98g0rk027274;
	Mon, 9 Dec 2024 13:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=A0KZjka69q5JA3SLGJ
	LCFuvSiigIcIJnaQ/20nFfsak=; b=a9p/oaRNVYrQoaTiIDft3E8dpAORrbRD5m
	n7FK436oHNcbaJ20qLXLP9TT23j8fkGSxs68a+u0LZ7GNAY5N7VyB8LzmtvLZdvd
	KzQamA2ty/OvNCW+eIEhIZfb7/rkBsddTC9WSZDyj91WGsNuuW4XZaV8s/nBfRev
	IvsKpa0TMvYSNPqYOQ7OXBxPqF5zrtf5OJ/LvyEbht7dlLel4H8J1AmjLDdZTKZA
	m3APq4jb0hsfuYDa3+SurIBnHXRaE9yBY61VPDkDe6TQfOUTxOG2fHXsDevynH+W
	EtMQ7eFG0BeZOS7v/E7PSRHyMxFUFufEXyeF0jn7AcjsXvWN1h0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce893600-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:42:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CDfcM020564;
	Mon, 9 Dec 2024 13:42:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6w95c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0VvIaYM3T/bmJzoYq+IlMHr9lPGDpG7zRr6PvSCm0NpLH8tdww+6Os0vv6ur4p9KKnKNmxx26OOe4qTbEzeo8bjtw8RuUZ4jV4PC1aafO/9a3GYXc6ynVP4CZs/Zeew2mIwfBFWU2fD/5u8QOz/TWgfvreE8LtfP+9JlWPxgB3H5Kk3e8S0ugp9CtbzUPsl4ppOPQDXzBp4RwY5lXAnCFCJivUerAIPCyYYzWUSqkiVTkYRJJcWA8ss1AuC6OEMn/HavMjaBhhMvpggrH9BW/2mwo7lmyWVWOBSwCMy9EnKq/th68OsoWVt2HVddm2XnCdfiBj5OJm1JwmR4weD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0KZjka69q5JA3SLGJLCFuvSiigIcIJnaQ/20nFfsak=;
 b=mpIq3IXbgSANHKnzXNZh0aAdSg4ua8ttokdFsN3yiXxshFthQetcjR1e0hiQSBUlGTIB1y/4edE5uH9GerQBMe4X8SH3gAi+sevLlSi8za/KcFIPOcbOUI5jBDl/nVywkcA11xIJML1n2xQXFqGYHLGhclOSRI55jpC7PtnhJGTCfHrQmiqMkdZDqiUeAvsVQx217fOMrowVhnhUofcxRAFkjwl55f2w9IykxTOxchZ79iNENZt1D0tKs8sn3LJKA68q7o6Wfj8TLN69OBbQtnbxZWoEmsE9GJlcZbtmVgMsb+6OPspsRCHXfWbLT4G2pv5qJ7FHu67t4gcvEtpj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0KZjka69q5JA3SLGJLCFuvSiigIcIJnaQ/20nFfsak=;
 b=U8MVWcrnaUDcOQ1XK8y+lYrdolvCJpnfFBaUy1Wje+a+MPHYAIpbRTqPR8QMX+BVIgk8wEeP94xqkeAKPZcIoug/REy5LjuDDwplkv1b3JR4Y3E1L+nQk3kF/Q18xk59ruIi882gqs7qS7pOmGTIvhZ1NnJYh1QT+nwlM+17HAY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:42:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:42:44 +0000
Date: Mon, 9 Dec 2024 13:42:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lokeshgidra@google.com, rppt@kernel.org, aarcange@redhat.com,
        Jason@zx2c4.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: handle few NULL check inline
Message-ID: <f7f1b152-3f25-4df3-9589-2fceb6d18613@lucifer.local>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209132549.2878604-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: e26ee3e2-4796-4b7d-969f-08dd18575c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TAFkPGEOTeMo3BdWRlcT/tAhGljcxcUZ9fR7rY9kDjM0wIX3XU4FXRm538m?=
 =?us-ascii?Q?SZHB5k2T8NFIbZUy2XqUzqgOzTbejLF3CbNxZcEgKD12bg0SVzHvkDi3xyUY?=
 =?us-ascii?Q?nTL+JasHZy05YCC4YG8fmJGgKxA23iaTNrn4tMPX4YqcHikwOCca58dP6g80?=
 =?us-ascii?Q?ke46pyXNUwu82eqaSQLM7oyTpheS6iH/3h5pfN4i5KT7euxbUlnvkGUYbhy7?=
 =?us-ascii?Q?ekFiVGvDAHlh+lFIXU+OTnGN9l2lMdTBel4tqDAucOVkksVTj7NPZVTn6JIP?=
 =?us-ascii?Q?+DnQlR1dbCn/E4FvvbdDQ6iqI9by41Cak/Xemg3IzN/K47p4MGyXiKpQVanT?=
 =?us-ascii?Q?InPoaEzAD5rH2eIeMXhmdU1hvSXSUWF6n/X22I1SVoPVZoP4zUDOsMXw0D0a?=
 =?us-ascii?Q?43swK899aYnPLppeRKWLpjc25xwczHad9Tk5v2OyqnBa1Qqa/HJLRGoSWM7w?=
 =?us-ascii?Q?qJgcz4WzwycJdN3WZt4ptRQRrzC4j/E2PYHKHAeazGJr51i5+IGepAuZuPUG?=
 =?us-ascii?Q?t7aBiZFi6ydml71aZbwrYULdewUXDgMg1ZT7cPO83k41qjAdkdeGl5U9Src6?=
 =?us-ascii?Q?Mey6RtPHEJtR9nPyOnRTO3mlpuL5rP4BdBN5zasSDweKUDFx/hPycZWUqtSy?=
 =?us-ascii?Q?n0Tt1V5NHFA5Txi4hxOrzgVjkUdT4GcR5IrRipOzExRw0rxKJrYjmEFN4Hdg?=
 =?us-ascii?Q?D/SWCbPxPboju1pOzOlK+FC26B75DgLxDZYzNO6mnJ3nUvbsgsTvVWe/wK8k?=
 =?us-ascii?Q?Tc5/Nh33uNfllPWgrtFpF7RdnjpErd7X+zG+oq8CdDEt7viIADcd7BtXJow6?=
 =?us-ascii?Q?4EHyDVPMZhXUZBag828bYeeFvOeVHTzYMZt3PSvVAuHWdCkdVvz8nTTOHCWs?=
 =?us-ascii?Q?T6szH8ofg56MToheVlKgVcr0C/btEvOrFm73qoZZi/yeyvlmFL1ZpHeGcal2?=
 =?us-ascii?Q?R+wO37gmA1GBvJci9GG3uIERKBEjXAZAo+zVPlax54sbZXIUB8GXb6sDqzHO?=
 =?us-ascii?Q?zNYPUX7L4ilG9j3/ttplGTLkHs3DCo2xK1A74Dk2WgPQmqLrnLKtPVcjOitV?=
 =?us-ascii?Q?qSIt7MZdWUzsGE921BJnCNPdqEW9lo2Dy/1CJ6BW1T7K6EmfaLfK8BbwY6Jo?=
 =?us-ascii?Q?5+qnixp7W7rioEKBAFQPoqjYB6d2kjXppa62YlX7lDXLtm/wZS/muWLI2n/n?=
 =?us-ascii?Q?vH9YoVEMH5BS9lB7ToHEow/Ho4k5Lh/nPYOkry+vz79xQE5SBlkF1/VIMJXk?=
 =?us-ascii?Q?re+gMaEcNgzV9yvR7WsOVT1SP+vzZsZA6SbQTTOA8WMEGfF9az1or7MBLMJs?=
 =?us-ascii?Q?+jOmhmWY2FHOWMU/iSq+UpfDlAS3wDKF2Y/pzO7qLJgbYApnPPniEMWjXjIA?=
 =?us-ascii?Q?asDsLm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvHox4rZeyssY30JuHVCS0YUCBOOBGVCIcXSBGhzEfNiaxq+rjjtQ/dpLnGx?=
 =?us-ascii?Q?s7PLdTc5rF9WHiRdAArt4K9r9ocG3JKquiLuA6b8plud8qt/2pO8cG8UvESG?=
 =?us-ascii?Q?JoGB+HLMoz1ZjJDs7jRI9Unrsrm99lwh+clR5B+mvflcf8zdPbJxOmBlkr+m?=
 =?us-ascii?Q?3P5oqZ+L3Bf5yI0zpvKu8k/hnrbNivRpsj12X4+3JvDzkJflHML4F25ZXA7X?=
 =?us-ascii?Q?/IZfMAlkTihYaFa3LJmSsPgi1JjS3hcVUyDzp/wUOShNz9FJ4IFtkbqJA9ZN?=
 =?us-ascii?Q?zuqcwzjR9nWwp7dY27rv6JnDll0HFkcEji/3tSHa0SGjl9ZhmMY5cTfZ4HOF?=
 =?us-ascii?Q?Mygxelk+0CW2Cp/GbcdsS9nxADN/9h5QdEE4URWE1eDZ+K0JzOqv5Mmw4j3m?=
 =?us-ascii?Q?yn0z3sE9JZCu6OSBQBtMQhb/vor8FZTNHcoeAqFQNcDX/9yzEnOKD+tUyDOm?=
 =?us-ascii?Q?GhrZV6j6Jak+je18so01umfBdDIqrb4DOtrQ2OErOjz47tbo8XJrNOHfecV4?=
 =?us-ascii?Q?Q9RQWGFodrvZUUPHzV28mTQthYghmMjSuRokDbTQCx5jCS2L3ju/TKPmztRo?=
 =?us-ascii?Q?OmpsDvsfzUTx38xyfQJd/RV+hbg+LuM3tqHyjUHNNkyCC9nMDJMG5EPmFmtB?=
 =?us-ascii?Q?HsmWzNipa5WnePKoEpVdGMmR1jkRpwWefy/e/KVJy+ABI/GrHBVAjJ5RXZud?=
 =?us-ascii?Q?fTXxgzDYcPZklXVO8d/lMgMTPnxO0AyV5ozgPhTm5SJCulwkk6aGIHy5RfTS?=
 =?us-ascii?Q?976VOsOW58nSCZrd5ZGdreE4BSCdiFrpDJYb1TZnHgBcPyFokL0ruRxwTkY9?=
 =?us-ascii?Q?GnYif62yC6mQIIhSz8zbuyUm7OlBkHsHwvAaPMlBXJMMViz9ZSjM7OZRVM1l?=
 =?us-ascii?Q?g0c4/Ngpq4kHmF3cfwgopV+BwwUfqgcJYF/o8nzJ7iLwspvD7VGzgm2Oy7Iv?=
 =?us-ascii?Q?qWPYvMYFYbwGNRPOZHgM65EyoG2OTz+AjIP9cktxVVti85HMyO7fxauqb0Jj?=
 =?us-ascii?Q?1DAmag5DxHTMn1OjmyqycVARKWuHHxF8SrAURO/7tJz7nUAs63hs8CxSCLDy?=
 =?us-ascii?Q?G7g7LwRCq9CC0ob4LRFJ+SWPC5uk71h5fGYfirPqVYMlHaz5lxTCoiosTUMt?=
 =?us-ascii?Q?debnyiRIE+E7Mf+OmqLYyJ+tOYmPhzIlX1XUeBVjmw4IuXrhN8d5P7o13SW9?=
 =?us-ascii?Q?JJuLkR/NaSWzOk4FuygnFFZrL7eQnQOdXRNReTcK9CymVTdqAjLBRQjfCo5t?=
 =?us-ascii?Q?ixeCrRSfD24OdUh95rw8MJgu8vOxXpATgl4i3jk8Y954gXHDZ5qxt9yklQMH?=
 =?us-ascii?Q?AXrlyvB9PeEHY6yO+O/IwI3aWDwY9fjqJQO0TZ0BjFKSQMYgqbJnRXGnh0tX?=
 =?us-ascii?Q?5fwSVorm93WXgwlAV83uPnG3AC73nJOWknekeMVMuu2XXPDDXmqmkaXR+cbs?=
 =?us-ascii?Q?0XJhosymyCAXMiAsQ8ky5m//yx15asifCbwLQxe9e4aHjzlboEqKHDmP5KxZ?=
 =?us-ascii?Q?CmSFECibaiKb4dA1eZD6uIXp8EcIYenU2C07QP+D0D0fXYpT7wEGf+lgovPo?=
 =?us-ascii?Q?JYvrPjkjES+EZPigh5fd77oaE4QpwW7tEYTFaykbp84rToaR/LS2xyG8CAAB?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2vR1CWwgF7g4spVBax2zRQE0ERLpF/ErCevCVPliICkLG3vfIDAk8dDMDwPnkvEX29OFh/CtkkWnbIjAlzdI4lqx6uNt/KR1AwL5K4SmX/I+KWs20ZiSWYmDQjHuF9B0VY8ovmsj+WvgSt2BaawVLCxFbw47t05I0wX0OlICc8tg6wzL9u4HLC6kgw+TE9vWwvPeBNpCSR5AUN6r6l/bM8Gn/bOwF95i4V74zCwXvUMl/NDiVxqfOKOsdLrUlu45s9mR3ccc77vtJBqbOcIVZdcaI+eLOhxuEcb4yI7hIkl4WMfZvvR5fmMyWeXAGuvhjH84+U5SolBMabJebs0u6auPNLoBcC2z60KLzvMqZTa0/XCjX7Kt8IQzEjFFIypOsvIHx1MOvi6IjS4gX6odnksmOK0ZBoA/luMjZ9HWF6PyL65E28g/RFWg/423So88yqEd2PiaJ4nYXBF7koKxnKsmHCTNz6AyQgquRICBposjHn7kAhjC/E+lbbMYYFEHsEqrZqfZmM5WYeiqYN6KfPgpQsj7IVqoT85EPzNkm3Ny502jn15WBsRU2AUiBr4RFuYnQUhmV/rwtJoKNeKaVoLeiQToy6bEZzgsev0hCOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26ee3e2-4796-4b7d-969f-08dd18575c16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:42:44.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evbYqL3OU0k5juixaX/K8x/xg4bMvxa1Pb+YdAdV7y5Vyfh0sUN8djOZ/douN4h+3yMVyRrrbv9EnngJZ8gkGhtBFUOJ3FNBFvKjgm6uuHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090107
X-Proofpoint-GUID: OWh1mw0pao80xRfKTFPtFLbDB7gKXjMK
X-Proofpoint-ORIG-GUID: OWh1mw0pao80xRfKTFPtFLbDB7gKXjMK

On Mon, Dec 09, 2024 at 09:25:47PM +0800, Jinjie Ruan wrote:
> Handle dup_userfaultfd() and anon_vma_fork() NULL check inline to
> save some function call overhead. The Unixbench single core process
> create has 1% improve with these patches.
>
> Jinjie Ruan (2):
>   userfaultfd: handle dup_userfaultfd() NULL check inline
>   mm, rmap: handle anon_vma_fork() NULL check inline
>
>  fs/userfaultfd.c              |  5 +----
>  include/linux/rmap.h          | 12 +++++++++++-
>  include/linux/userfaultfd_k.h | 11 ++++++++++-
>  mm/rmap.c                     |  6 +-----
>  4 files changed, 23 insertions(+), 11 deletions(-)
>
> --
> 2.34.1
>

Coincidentally I've just diagosed a rather nasty bug in this code [0], so
could we hold off on this change for just a little bit until we can get a
fix out for this please?

I'd rather not complicate anything until we're sure we won't need to change
this.

Thanks!


[0]:https://lore.kernel.org/linux-mm/aa2c1930-becc-4bc5-adfb-96e88290acc7@lucifer.local/

