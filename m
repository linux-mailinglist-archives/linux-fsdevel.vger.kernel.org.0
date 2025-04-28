Return-Path: <linux-fsdevel+bounces-47522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C05A9F485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2303BF684
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EF27A101;
	Mon, 28 Apr 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i7zEjj97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eH4Qhrus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D532798FF;
	Mon, 28 Apr 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854396; cv=fail; b=C23dQetzFdasoBfTEO59HK2becJjKcYC3OMH3wD2Oy/l/eXz6Wz1xpelHA02VsRlPuaZZVKCc359vw7xcyYNYFYDRNiOH3EqLTKaCiLHxyZVjVU+yESM1pF5rTfWZKpwNb57vwqjZ9UzZ26N1Mlmz98mHk+WQoXNYMkv0CYA3L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854396; c=relaxed/simple;
	bh=5zZ93pf67IRWha3wW7g0O2ncLLGlf1ldLcmKYcxMCaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bd/I0GDxLQ35JF2EFzuYNqoNxZ90j2REzK+87C/omvADtt9sY8vdkPz8e7r2laT9Wzk48sk8ohPfqUjaLmM0NAv3gKjWLzlcUhy/C8ONV1dqcSjXhgTmG2Y8qWw48cGLK1MixwtJ3s0JYpAoo59Rn1Nzum9/3w39NpIQWCkWUas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i7zEjj97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eH4Qhrus; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFMw0Y006704;
	Mon, 28 Apr 2025 15:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vjeiE0w4Ti2Jhwx9gvvWOmUUYlHZR/2vkND0yU76cms=; b=
	i7zEjj97MJXhW6u+7n/ZvdUVuCd451GBCLlL/kggnyDh4mDCS/be0RP7If0nzzee
	FS9lb+yu3OXV1Xe/DgK7Bs+wG6rT9gtKCxY1Nb3t9R0E3lcUrIu99ccu5SXSdYA7
	ASs1wh84LzeMDHcMJDohOZjg8CTwBjf+ZqhS+dijTLGrg667ZYwe2TJclAs6mVtD
	DozBeLl18wJU84FolNO1tjnHQxaOcnVVfZyfzA294mB1gpNWy2hY9MPKTFs53xf+
	fdZRKaO/iyD2dfB1iNKGMg4H4SE1Utij3bluCf4wWHwptFEjhRFD2yK28D61XaAE
	qTZNNKXs62tD2XHtyG0KPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46abtf8332-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:32:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SE2Ij2007618;
	Mon, 28 Apr 2025 15:28:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8b3bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruTHO5HtdEKvAhFklkBvyp++sVi3Azeb74523C/2vnvqIi+/Ltlvrt0fvCyJqh8y6CLyGI6XnvlRjZjheCuaO29N/PxBlhyCYD7Tic+4GWra60s9/+0fhMQcY9bhGbZ9xQZ00pCR56w5+kENmBQBkUk0kuq5hhqL2QQNaVs2CSwtalmI0OQ6+ooyEHRDjCldQI0D75Dh22MOx9xI5BMypVd9qONi0dsOY9wDkCo2FrDn8D6Wp9QtR7FxuKbYQZZBrhXja9j32vR3cAjOEQaQ6Y48lDZQRTPgmsLLD5VSYL5KJdu07oqJSUlJf1bbkveQo4z1XyRh569qw3LdfykHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjeiE0w4Ti2Jhwx9gvvWOmUUYlHZR/2vkND0yU76cms=;
 b=eSaiVDY/I0qOiJ+5gRmQahujGNItziQ734mokQ497u0PdeoRp4xQup/ZTi+ipUGBYArz6aqlx4zVIVgO/yTeBjRDA0K3Cl3rmGVccUmqozL9YHJIFwvlrZbXvTFHbnqFNgj2nIA31GJSDu48M/vZN7YzxkhzL8Y7WOJFvQIn8eQSNmlR04TVYndaOTE3eA448wpgJxt1X35N+6joG9W1tk1WCuDBKt1Nkr3/1ltY+PNn8CAXaN29dNctBrskRUHEPf12yoZ4fe8/bZmBVZRfNoDDfDhLFYNP68ye9IvidkaDC7o6k3tk+Zlaefb95ZPbWKZ90KzKnWaIfcPoFbH3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjeiE0w4Ti2Jhwx9gvvWOmUUYlHZR/2vkND0yU76cms=;
 b=eH4QhrusW+YZXkS6wTr2ZVv6CMqiHr9R/M1S/7eVezGtUA1K243rNlfH+fGtSrCzlaxWnOWUXUfKKZh7c5AmJqKD3cdckJpf9jyTrSbLBlJs3NEeePf+VCuRuXjFDeculSoPaDP7QgpYTJs48SdGbk0omp2IVJG6NrfNZaAlLrk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 15:28:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:28:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] mm: abstract initial stack setup to mm subsystem
Date: Mon, 28 Apr 2025 16:28:15 +0100
Message-ID: <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 03096584-038f-43fb-3d7c-08dd866952d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBsqHAkNFRgv+2UakT6RmAGZtbL+EVb2WfWnvYncJTzbScj7z/vjt1zAh46O?=
 =?us-ascii?Q?U5oKv2j8CXOq52pJqKgQ87Fy25NkuOw5QJViq1CBWdMKkcPYmgtqCTa1UF6N?=
 =?us-ascii?Q?CqrxjOxdGvC2I2cU5p7VIfMaHTi8z83wNGvvW1zNI9kC1g3FeFhA7YvF9UyY?=
 =?us-ascii?Q?xqUDZZAdGMpSgCGVzfSRKeWp/vy5IxRJxou1WsLJcfERlvhIVkRwk0vZgt2V?=
 =?us-ascii?Q?Pt4z+KH54yj5h9AF9PogPkbPiwXOU8szGgTawAeR1hymL7efNKaLq5uRiN0V?=
 =?us-ascii?Q?vwmsct+Wpl/paKWYSKBYiT/o7olXloGdSY0oNY/d36OvFMhuvyCR2piToC4j?=
 =?us-ascii?Q?qKWlVLpkAbrXmWyFZj4rp1edo8GcQ2NTheJtjkmJKYLk9n+CI4mPQdYYeeY+?=
 =?us-ascii?Q?LxIXLpGlZIOqNgsj3C8ucURWJEA3iLNIhFT+xycF5VAgRreWomoVFi3vEGJG?=
 =?us-ascii?Q?F6/QM3811unY7aP+8m0W+C/Cgw6xnQ7wHupTMSu0jX8DXG9xhZjfKRwJORbU?=
 =?us-ascii?Q?qvyahF7fuEY2Y6wSIQ7sayo38wFFRO+rmqABXTRqFL4+y+iarb9LdToJB4E8?=
 =?us-ascii?Q?90KKygWSIpwJ5f2QkxOOmrbXeeQM4dlCrcc6mLNVdLurr6OqKYrCD9nb0efu?=
 =?us-ascii?Q?8RtnPmCMo4qAeMCmTs2QiFe6kBekdANDst8wHgRsxeUhev/q+MLwTk8meamm?=
 =?us-ascii?Q?8YULVE8fB4Q+GnW1YRq4qAt+9KpTKnzxJibyW97sDnQ82ky89qAt+2NgHZf8?=
 =?us-ascii?Q?+gW+y+FjLFZz2wIDrx/GK9P7zChdRRPolWLdlZP36+MWoR5+Kl4Lscp5Gxfd?=
 =?us-ascii?Q?WVOkIEuBmSwp0Au0ZnnFeEqCiXGf6lZ9id2v8i/EHrogFhoGWzHQPKDGfelt?=
 =?us-ascii?Q?6ezmTKUJm7L2LcukiW+wtgwNM5M9MmCR8ZIaI3fmVhDT09ewNxIM1Eez7v9n?=
 =?us-ascii?Q?zz46lVjJFiMrPFFgRgOAsFSY+RclaAyeErmYq/32QxmTRrh4/ewWcDtvxnBC?=
 =?us-ascii?Q?K0gCiedmnlfJeyusO3zhzIHyrf/WJCgC40VVn6/Zk27G1HXoYCZffifJ42pj?=
 =?us-ascii?Q?DNbkQyHANMmCAHUuqXAuNfIulnUj4+CT9N2zjvFI3zNMICpETHRll0nkid9/?=
 =?us-ascii?Q?LsnoanyycyQCTCruDbt5HkkNi1eT237qbv/aEIT3WFJHTHQnnB0fa/m6JH9N?=
 =?us-ascii?Q?IODYFeLyzymIFkIwmHiBVb6XHMLgCx1pvOeF9pyfaB6R/KieQA8zrDgNOtRW?=
 =?us-ascii?Q?VZ/0rS+rz8Vvgi4PcIlxlH2OZX915CdByJC6l4NSg7p9va1DNJX/zlSed+fo?=
 =?us-ascii?Q?Nw/AikW5hGaLLW0Rfq1k9fXClkduMpeC4QhZqp2HIu4bcbxAgzGv+IXatxvg?=
 =?us-ascii?Q?7CVR5TXrMYAinrKVDiX3rOJIj2vsd4u0DqahNRyCIc0JNvy/DQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32nUhMWnw5aTGG+02ifNI4AkSsTxEKisVZSMkZgZIA+2i6P+S0gnVI4zay2i?=
 =?us-ascii?Q?/xlMZJw8h4fCuepSzvtRxsmkXpdxT/tenXaFsScOcKvA096R4ETPH34sILJc?=
 =?us-ascii?Q?w1jbVRvCVCHRvtvqtLZcQkTneGJK/8PlNPU/1v18YD3Kg5Roh7bpvi/P9UL8?=
 =?us-ascii?Q?QTumCycaNcsJ4S8jCDoP6C+w/RSDnekdqbSfIlyOsF8GM3/KWzPRvcQTsro1?=
 =?us-ascii?Q?XU1yntNL6/tiUDKs9EEPcsSNgtLItr81DQbrpTkO5bmfRpCj6Oe6kU/Srhzl?=
 =?us-ascii?Q?7oFCvC1tRJN21vZd7GTlyDWOahFU5y+qVP7TWMVBPVYNPjv0HJpn+Gw+VY72?=
 =?us-ascii?Q?yQmmZNXD4hs7yEOdxx+j1wFym2G/j1sbvedeVCWwQ+qV6yBE7aFGpam0PUmH?=
 =?us-ascii?Q?I8RNZwWJypTZx8+mI/9RzrO0yz6huNpElnZKIOJbbst4O4PcYSHdyzQZhbqM?=
 =?us-ascii?Q?0rAxAe/TRXOWjP1BzO6Xe3Q5xsk4ol3Ybe0z/HXWPv4Vk6Lp9lEXMII3xPra?=
 =?us-ascii?Q?59o/Jxi5ccL0U2KzdeIUDYMEx2tLieUpYCcfxEZiAK10DP58Q0pFFZw2ADnL?=
 =?us-ascii?Q?zjVfOMl4MbNYimeC06pf45V3KCBN20JwRmxYN2Wcny1bJ+qRpUhBsk06Rv5O?=
 =?us-ascii?Q?AHqfPXIjKOwyQOnmSLQsfKzRKHvSUFmU5bIbSiGnY6komkIxfwIji483sfMU?=
 =?us-ascii?Q?Bj3UWg8XqF3+VaAg+4pze3otoslfmj7XcEIAcNQol1ompvnz4vGUJrA/nA81?=
 =?us-ascii?Q?mFe/OjbQlicK5DhFd/kkE+kGKMfkC+pwb/D/dlqyv6YXAdEPx3G4FIfVkm/h?=
 =?us-ascii?Q?YHt6Rqs+rHaebM4dhAulCYyZL7MVsyK7fQP6EmBS2LxWAu8PX2w+bLXSYhhI?=
 =?us-ascii?Q?e3AVTNCCAtzz0LUS2CxaePeVSq1966m60Ertpb0qNI6QFGxYhTQxJ+iRBof0?=
 =?us-ascii?Q?nzCeP9vWru/Xzsn+yDiikJ4+VMRHz4Ok6VacYnuJCjS8WeiH2JcTiUo1qpLr?=
 =?us-ascii?Q?DNmgHTZzIZWJg1sfd3sYSC32DKdYLVg6du4FcFdBPMEsJF8/6Nb3cglstNe0?=
 =?us-ascii?Q?Y1eDp3Qv8/lnmmx5g6N3cOSkX4/40UWDFIlkVsoRtDROljW9/xYnsJ2m0oBv?=
 =?us-ascii?Q?/s68YI3bU9rq9NOO184WCtx8jqCUCRyQQzIEb6vljD9v5KIjqHbFTK5uu3bE?=
 =?us-ascii?Q?RfpDbkvHz6YZdgtBSXR9FsL0b8gG9Fs50PvQVWiU85TyTS66/cBPB92rP49n?=
 =?us-ascii?Q?g50V5e9FhR/6D0KMsTvy83O3CjOws2dN2jjCOM8TVRcazndyd/sma+BFx3pf?=
 =?us-ascii?Q?KufIImRegvjFcepDxFW/Wy/RyJ749xUo+HcHa44SzaRdKnTIvrqnNeZJmAEi?=
 =?us-ascii?Q?44GK02K9dZGJxkcYz/Z30TRcI7d0iOPRhDuyfgKZC6Az2a2BoZ4Tly6SO9nu?=
 =?us-ascii?Q?pKzQSseG6/FUymAihhMUTu4nYiPSEUe9AUqGFKYbFItJUVVUmgtya5TmAJ61?=
 =?us-ascii?Q?tCrEwTSxR7atnt+d1krLchg0pnR86L3gUkr6J0H9UhrBp2N46CE7yqsTH2Ty?=
 =?us-ascii?Q?eIPR7SEcAK4/V/+sboEdmejGIZxLvD1JZI04PDchKyViBIS+uF6t9lYOS9i1?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lb1+mjaiA1uGleO6p2mT3YMgKxUMrwX5I81oaQylzkdTQV6p9FYgd0UgytZwNHSSpHavpEez2TfgX0J5tH8/0RKKBiwYH5u7XBiwhEqIH9IyoNneDgKfop6aV0Vm/lE5mlbRrfRTL4MY+TASMy++q1aMPK/vTC/7Qb/p7RD/TwPugBJ5zRcODA7qrhLrWN4chW7guFsJenLWM+RYWZgVuyI+rbG8wHg9kJyh2scoKDfn+beHLfUj+ibnUC7HAfh5o/gc945OVOrqn9UmbkFGijThjYsQo20uAhS3WNIaJ2pWFVN3oHNF2uYfE6hdBdyD6HmTrk9/atbFm6d4x5s89mdGbQj4ZnuGSssY4cWKAHu4btsi7bykYt89s/40D/kRbr239Oyktff/f2Dzjv9auMxQCNZdYuQtXcd+rxc36vy0mkBh3MD+6Zk4Lxdqd4a2uW+OAIeSgSyIxC7KlXU/RBVjNv1c9XJehuezNhW07acXt2WTtFDiNsewQkHhORwVt13lX5La7/ObaVTOhzBjTUeLB9amsmN+7TXyldDdFLKsVnTzHJ2OOXVqJzpAXe9Q/WZAY9dnS/4L1DFB2Bg0FiO0K00lU2M7KVt0xxhVvPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03096584-038f-43fb-3d7c-08dd866952d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:28:27.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TaZnu4x72GbLtA++5TRyk4MRVjwEHHMWxueciOkRZRGlElbTjt+P3jpYpCzAkSxt4asryvjV6qxWpkgLga46iATa69dSUzNj+3IXd4kjQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280127
X-Proofpoint-ORIG-GUID: tl38xZGTRQiQ8IvH5KqbvMCAhEbahX-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNyBTYWx0ZWRfX5FqujDFBNqH6 tF0OkNt9p212xring1WFvIt8CMuPy+H91q0b1THdN+/teXfcaLAABqFzATgFiLaHDePcMAMhMOR lRX9QZthAmUsJNBePfMm1LRmKdeZURhOeFEodjrDxNcEUNImix5z2kZvCm95ZxJchSjtPlk/UHJ
 q0IhxRPaGDMa6KICxU2zSkvEZxistoAU5kpd1EMAjV0nNmw3tYNtVdaqjfABdvmiH9iKZ4RO1Tl Pitu5nXxnbSLUWN4hFTt2tI73mvDRKzIxxI6jkwKViWKy0WO2kSouDs86AKTt9MsRJq3Gl1ZHfO YSa1zy8tpbM8RQWPxbwqB/1HE8g3acaQd2UXh8YEqFtmeNpcS1DqSrp06w0JGldVsztDv8ZURQP mex1I2ik
X-Proofpoint-GUID: tl38xZGTRQiQ8IvH5KqbvMCAhEbahX-J

There are peculiarities within the kernel where what is very clearly mm
code is performed elsewhere arbitrarily.

This violates separation of concerns and makes it harder to refactor code
to make changes to how fundamental initialisation and operation of mm logic
is performed.

One such case is the creation of the VMA containing the initial stack upon
execve()'ing a new process. This is currently performed in __bprm_mm_init()
in fs/exec.c.

Abstract this operation to create_init_stack_vma(). This allows us to limit
use of vma allocation and free code to fork and mm only.

We previously did the same for the step at which we relocate the initial
stack VMA downwards via relocate_vma_down(), now we move the initial VMA
establishment too.

Take the opportunity to also move insert_vm_struct() to mm/vma.c as it's no
longer needed anywhere outside of mm.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/exec.c                        | 66 +++---------------------------
 mm/mmap.c                        | 42 -------------------
 mm/vma.c                         | 43 ++++++++++++++++++++
 mm/vma.h                         |  4 ++
 mm/vma_exec.c                    | 69 ++++++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h | 32 +++++++++++++++
 6 files changed, 153 insertions(+), 103 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 477bc3f2e966..f9bbcf0016a4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -245,60 +245,6 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	flush_cache_page(bprm->vma, pos, page_to_pfn(page));
 }
 
-static int __bprm_mm_init(struct linux_binprm *bprm)
-{
-	int err;
-	struct vm_area_struct *vma = NULL;
-	struct mm_struct *mm = bprm->mm;
-
-	bprm->vma = vma = vm_area_alloc(mm);
-	if (!vma)
-		return -ENOMEM;
-	vma_set_anonymous(vma);
-
-	if (mmap_write_lock_killable(mm)) {
-		err = -EINTR;
-		goto err_free;
-	}
-
-	/*
-	 * Need to be called with mmap write lock
-	 * held, to avoid race with ksmd.
-	 */
-	err = ksm_execve(mm);
-	if (err)
-		goto err_ksm;
-
-	/*
-	 * Place the stack at the largest stack address the architecture
-	 * supports. Later, we'll move this to an appropriate place. We don't
-	 * use STACK_TOP because that can depend on attributes which aren't
-	 * configured yet.
-	 */
-	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_end = STACK_TOP_MAX;
-	vma->vm_start = vma->vm_end - PAGE_SIZE;
-	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-
-	err = insert_vm_struct(mm, vma);
-	if (err)
-		goto err;
-
-	mm->stack_vm = mm->total_vm = 1;
-	mmap_write_unlock(mm);
-	bprm->p = vma->vm_end - sizeof(void *);
-	return 0;
-err:
-	ksm_exit(mm);
-err_ksm:
-	mmap_write_unlock(mm);
-err_free:
-	bprm->vma = NULL;
-	vm_area_free(vma);
-	return err;
-}
-
 static bool valid_arg_len(struct linux_binprm *bprm, long len)
 {
 	return len <= MAX_ARG_STRLEN;
@@ -351,12 +297,6 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 {
 }
 
-static int __bprm_mm_init(struct linux_binprm *bprm)
-{
-	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
-	return 0;
-}
-
 static bool valid_arg_len(struct linux_binprm *bprm, long len)
 {
 	return len <= bprm->p;
@@ -385,9 +325,13 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
 	task_unlock(current->group_leader);
 
-	err = __bprm_mm_init(bprm);
+#ifndef CONFIG_MMU
+	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
+#else
+	err = create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
 	if (err)
 		goto err;
+#endif
 
 	return 0;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1794bf6f4dc0..9e09eac0021c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1321,48 +1321,6 @@ void exit_mmap(struct mm_struct *mm)
 	vm_unacct_memory(nr_accounted);
 }
 
-/* Insert vm structure into process list sorted by address
- * and into the inode's i_mmap tree.  If vm_file is non-NULL
- * then i_mmap_rwsem is taken here.
- */
-int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	unsigned long charged = vma_pages(vma);
-
-
-	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
-		return -ENOMEM;
-
-	if ((vma->vm_flags & VM_ACCOUNT) &&
-	     security_vm_enough_memory_mm(mm, charged))
-		return -ENOMEM;
-
-	/*
-	 * The vm_pgoff of a purely anonymous vma should be irrelevant
-	 * until its first write fault, when page's anon_vma and index
-	 * are set.  But now set the vm_pgoff it will almost certainly
-	 * end up with (unless mremap moves it elsewhere before that
-	 * first wfault), so /proc/pid/maps tells a consistent story.
-	 *
-	 * By setting it to reflect the virtual start address of the
-	 * vma, merges and splits can happen in a seamless way, just
-	 * using the existing file pgoff checks and manipulations.
-	 * Similarly in do_mmap and in do_brk_flags.
-	 */
-	if (vma_is_anonymous(vma)) {
-		BUG_ON(vma->anon_vma);
-		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
-	}
-
-	if (vma_link(mm, vma)) {
-		if (vma->vm_flags & VM_ACCOUNT)
-			vm_unacct_memory(charged);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 /*
  * Return true if the calling process may expand its vm space by the passed
  * number of pages
diff --git a/mm/vma.c b/mm/vma.c
index 8a6c5e835759..1f2634b29568 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3052,3 +3052,46 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
 }
+
+
+/* Insert vm structure into process list sorted by address
+ * and into the inode's i_mmap tree.  If vm_file is non-NULL
+ * then i_mmap_rwsem is taken here.
+ */
+int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	unsigned long charged = vma_pages(vma);
+
+
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
+		return -ENOMEM;
+
+	if ((vma->vm_flags & VM_ACCOUNT) &&
+	     security_vm_enough_memory_mm(mm, charged))
+		return -ENOMEM;
+
+	/*
+	 * The vm_pgoff of a purely anonymous vma should be irrelevant
+	 * until its first write fault, when page's anon_vma and index
+	 * are set.  But now set the vm_pgoff it will almost certainly
+	 * end up with (unless mremap moves it elsewhere before that
+	 * first wfault), so /proc/pid/maps tells a consistent story.
+	 *
+	 * By setting it to reflect the virtual start address of the
+	 * vma, merges and splits can happen in a seamless way, just
+	 * using the existing file pgoff checks and manipulations.
+	 * Similarly in do_mmap and in do_brk_flags.
+	 */
+	if (vma_is_anonymous(vma)) {
+		BUG_ON(vma->anon_vma);
+		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
+	}
+
+	if (vma_link(mm, vma)) {
+		if (vma->vm_flags & VM_ACCOUNT)
+			vm_unacct_memory(charged);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/mm/vma.h b/mm/vma.h
index 1ce3e18f01b7..94307a2e4ab6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -548,8 +548,12 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
+int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
+
 /* vma_exec.h */
 #ifdef CONFIG_MMU
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p);
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif
 
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 6736ae37f748..2dffb02ed6a2 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -90,3 +90,72 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	/* Shrink the vma to just the new range */
 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
+
+/*
+ * Establish the stack VMA in an execve'd process, located temporarily at the
+ * maximum stack address provided by the architecture.
+ *
+ * We later relocate this downwards in relocate_vma_down().
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable initialisation.
+ *
+ * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
+ * maximum addressable location in the stack (that is capable of storing a
+ * system word of data).
+ */
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p)
+{
+	int err;
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (!vma)
+		return -ENOMEM;
+
+	vma_set_anonymous(vma);
+
+	if (mmap_write_lock_killable(mm)) {
+		err = -EINTR;
+		goto err_free;
+	}
+
+	/*
+	 * Need to be called with mmap write lock
+	 * held, to avoid race with ksmd.
+	 */
+	err = ksm_execve(mm);
+	if (err)
+		goto err_ksm;
+
+	/*
+	 * Place the stack at the largest stack address the architecture
+	 * supports. Later, we'll move this to an appropriate place. We don't
+	 * use STACK_TOP because that can depend on attributes which aren't
+	 * configured yet.
+	 */
+	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_end = STACK_TOP_MAX;
+	vma->vm_start = vma->vm_end - PAGE_SIZE;
+	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	err = insert_vm_struct(mm, vma);
+	if (err)
+		goto err;
+
+	mm->stack_vm = mm->total_vm = 1;
+	mmap_write_unlock(mm);
+	*vmap = vma;
+	*top_mem_p = vma->vm_end - sizeof(void *);
+	return 0;
+
+err:
+	ksm_exit(mm);
+err_ksm:
+	mmap_write_unlock(mm);
+err_free:
+	*vmap = NULL;
+	vm_area_free(vma);
+	return err;
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 0df19ca0000a..32e990313158 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -56,6 +56,8 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_PFNMAP	0x00000400
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
+#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
+#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
 #define VM_DONTEXPAND	0x00040000
 #define VM_LOCKONFAULT	0x00080000
 #define VM_ACCOUNT	0x00100000
@@ -70,6 +72,20 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+#ifdef CONFIG_STACK_GROWSUP
+#define VM_STACK	VM_GROWSUP
+#define VM_STACK_EARLY	VM_GROWSDOWN
+#else
+#define VM_STACK	VM_GROWSDOWN
+#define VM_STACK_EARLY	0
+#endif
+
+#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
+#define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
+#define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
+#define STACK_TOP		TASK_SIZE_LOW
+#define STACK_TOP_MAX		TASK_SIZE_MAX
+
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
@@ -82,6 +98,10 @@ extern unsigned long dac_mmap_min_addr;
 
 #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
 
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
+
 #define RLIMIT_STACK		3	/* max stack size */
 #define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
 
@@ -1280,4 +1300,16 @@ static inline void free_pgd_range(struct mmu_gather *tlb,
 	(void)ceiling;
 }
 
+static inline int ksm_execve(struct mm_struct *mm)
+{
+	(void)mm;
+
+	return 0;
+}
+
+static inline void ksm_exit(struct mm_struct *mm)
+{
+	(void)mm;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


