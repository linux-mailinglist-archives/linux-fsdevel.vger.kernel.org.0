Return-Path: <linux-fsdevel+bounces-55279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3101B09279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA747ADFFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C230205F;
	Thu, 17 Jul 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bn8xgir9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tCUXdlwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B030204D;
	Thu, 17 Jul 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771475; cv=fail; b=akCJKgYx8ycPpsTFQ0Zn7vA3bHEtHrAVBOfUWbKj+HRaueYiZVt+x2do4d9jdjnvHwtB8fl3i4rvqk7M+I5r2pyG58LomRkgmQa7eV0d9532hLytpCy6gTI1eXDzSXpn61H4QQygmzkUlnr33qz0tpJP8DpD4a269dEFBkKJHfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771475; c=relaxed/simple;
	bh=WwQKkDOAh/qiwRDOudxjSAdugdCyr7OGH3kvTjfZLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7jUarwOqm5Qp665OiH4eJkBHTFaLFEOUtT8DxF6kxCOrEjHdEo/etVtjWh3eif5/38adAgWGuj3wq/6kJSeYvu9MBQ5cZSN/h5DGeT0Ge0SUsNpYf2PvPvHbYWglf6tOYLo5YCOzgMY2jZsgGHH0sbjvSVQl+rbzK02e1Puaww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bn8xgir9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tCUXdlwU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGC0EO019331;
	Thu, 17 Jul 2025 16:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=y9CKE4//OpFLczTvRiBmDNmzribfOEiuz2KDIgWSwrs=; b=
	Bn8xgir9xMatwpIx1F6U/6xKtJr73OR2+Y19wcVN1dHXKcaVvZiTogzF5ZLxBdX7
	LV0/Qa4nCu1RoavovoTpHLj+QjCYtuhJpKr/l0lTsHR+ARe54A6R+lSOaaYZetHF
	lvE6O7J447WRUTbMsoyUEdZ7mBjZ9FvBFOi4aXwl08QEjxEbCgtOyYQsqVn36vnI
	snzUFz9CCkCt0eD9tm3fkX7Fis1jTI5co0CnZDBqC/zXUqkUt9KtiUUTzetK47pr
	KvkREPuT6eB9UGvemOC2AQggUGZDlibgeggGevsH2vi59M/Cafno1Z33X5KTWzoT
	3iSRw52M/stmr/lyWEAJaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3kaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGeF3k029705;
	Thu, 17 Jul 2025 16:56:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpr55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDLvZv3bsaSqMXyegIiIJKqrAHtONXh59V0CI0n4goC0GNFNHxk4szyBh6fn5HXogzkhCAbbAx69XNxomvU+kIJax7y16lQkZNNB+yea1nFWTGzgvsewkt7zB3NL8sQ7TiH4mJvcSNk7VALbNjfMwHtH4D7WowS68ov25eqBkP4XFlGkPuiEqjoF92HTl+aV69HA7fvUuIdC0pcKZRB5mTTbmizcoONhD6sds+OoQ0HRj4FgJNLuoEMnnbk8UGCeXYQQw88UcwAUj0akuETU6cjf7rP7AS4s3vF8jwwd4MdgdJ9DlSubM6KWuwnvwgrJyItalchiRkEN/PNSDbw0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9CKE4//OpFLczTvRiBmDNmzribfOEiuz2KDIgWSwrs=;
 b=k4rbtlKnYXii4+AdLhtye7QfFHZok5OHQOduF2RR+aae2aqWlxva3r1vpRSgavDlr/8LjpwsJP0bNCqMa2egpohN8SoqeFJpj9p20SC8837nVXzIuswKOEGbbGQ4GWJ2FZFJW34+FGyRREno4GiOCz1QWJMG1ny7Nx3zilfOPizWgoXq+bZEAMHfnNfaNKyxoPazgNb8FPQXaKgZrU/jf/nBHXjRtyj3e6tzEhYx5F4/M8kgeD4bpZ8qy2xM/Qs2SMhQGKSEqgEEV9f2rSBckkOjAmIe0fVlsiqZ96SZFJwFUGzlHlhbsY2KFugoJxMAL2hOe6XxUGV5cMsPTxj90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9CKE4//OpFLczTvRiBmDNmzribfOEiuz2KDIgWSwrs=;
 b=tCUXdlwUd/ZrGIh4neHWDoQxBYwW/DJCYKjAu8EIdwPollou/58iAqkmLluSbod+1ni3JikRBXC8d90t4lF66XIRkjSZQIKSpNCw/N6Kxj6VgsLl1NzAD0o4OZOAFXkp5bTTxm04f2U3VvScZwVGBM6rpHpqAPQQkEH+llBMqCU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 17 Jul
 2025 16:56:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 01/10] mm/mremap: perform some simple cleanups
Date: Thu, 17 Jul 2025 17:55:51 +0100
Message-ID: <d35ad8ce6b2c33b2f2f4ef7ec415f04a35cba34f.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f75e6ad-4073-42eb-04c1-08ddc552d36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+tXzERPQoTuX15t+tkcCaqQLThPB9FDIBvXQcP+7J13VuMoTustN8IK6wB05?=
 =?us-ascii?Q?RC38qn/suDxqtTuoVfNmOaHvqxXIpiY3l5QqKbyjXaiQk+M1X7GQz0QefTj5?=
 =?us-ascii?Q?oLq2aH8WorkCMUrPadMqRm/IqffhHja9m5mdFNjiH4PUNx99bw8hK6lbpjww?=
 =?us-ascii?Q?RGt1BF1fxJzWqXGPd5aiHgUkA+iXkcimMGox29TH2O9A866RASg2SMkU1THA?=
 =?us-ascii?Q?hcsSwzg4JCrjlE5za6jcRvrHE5ed4QShgMf8XiANoVvOJZUHWIAKJ6SYKqJC?=
 =?us-ascii?Q?JXJEF6nufAKlq7Ss6n17g/VMT5grY3U9XFcvrTkGeP02/jq68aR4OjctsVuq?=
 =?us-ascii?Q?HBFp7P98+Ub1uK6oTjInjDsXvb9Ifq/nff7jaTgvOMjZ1VzhI/i6NqTy6uXs?=
 =?us-ascii?Q?/ofEqbJ/s2kFy6Mb/r0j2RhBG4jNMHf4IxcSOKyAZXk1GLNpddChnHPAkNUJ?=
 =?us-ascii?Q?fi4fHCxvqkWU72D1RNOGiozKBWx+dHBZWvzJpPdGNIBnWXi7bJ3UpKFt0oAq?=
 =?us-ascii?Q?Enns+1XiyVSlHXe/XIdxO/Tz8QYJg2shv37e3w00cVfwumxOQBP45dl0QbON?=
 =?us-ascii?Q?4K9dCW4vyR2haHwEkxw0sM7pA4CeMM5wiTejYXhKMpl1IQdFtamUdKGevDO+?=
 =?us-ascii?Q?K1TzL201b8oaai5HKday+jDwey7syys9pm/Wb6bhBGvueDya+D9g2Qx+scs9?=
 =?us-ascii?Q?k3P4+ZQxJf07gSqKvnaaX48ejstfNbFGl3P+G1xawCLBRhhkeh4Gqz6RYegk?=
 =?us-ascii?Q?pf2PvOUQpDZ6hKJvKdkV1ZTeqOb5ir583mljzQMM8eAUZT1JvaO+htjHekFG?=
 =?us-ascii?Q?1Gal96vjsbQ7Clk88rTPHD52hoHSgRXvds209SSBobyPtLXBtGY9daIyOeqZ?=
 =?us-ascii?Q?5wkFghVKLTgOrYx0nHaBJ90z6e5BtSNnYzM3SryZtR1Rvh36bx8lTxXUEZ12?=
 =?us-ascii?Q?LlN0c4IGsj8WwkDC8VAJ0A9c36f5MAE6f/fP6kTuAVq96KQ6lLVw/Ldj7kEA?=
 =?us-ascii?Q?xrSzCNbHZ1xVtFzPF9GAMq3jhZh2PfhuGV1TSaer8diT4LZs/9BztKMXz0zH?=
 =?us-ascii?Q?M9zPtMqdg2Koun6iXBml+7/TqWqO2HhJQEqVRur8aSzv6EbnNFr2RQ4VjY3N?=
 =?us-ascii?Q?zBZR38+EQ2s0/sOLNvHNtMoM2Q0W0H6KlJnYL8wzcMgFxKre/6ABtHbajmbP?=
 =?us-ascii?Q?4OJHzzSx2FlQm78zqb1Ac7PzM583G/RA1dx0uuouQuS51Y7HJEWphSxVDtkB?=
 =?us-ascii?Q?C9dWYqhn/qIMWd2OLxiS6Sr7CgXFgKhPAxwYBsYn5Q5c/B+KBFX7+nEithU/?=
 =?us-ascii?Q?h8xkCsfdLM6mW1vzN0ulerH8BLWFiGrYSz8o3Pa1KHISMbqHcyG5h7ADOfYl?=
 =?us-ascii?Q?SxOhhHMxHzdpgOFw4RdtgtCbKQ/dTCgIEcyRks3S6TZdvrenlUdLNmSOpKQQ?=
 =?us-ascii?Q?6cdcXVS9Eew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueioz6WJGHCIF9+D/oHDm7J3RaUc54O98j153c/M7SLq5fsT6D/T7FVxRiX9?=
 =?us-ascii?Q?DpwUAyngY2VZIzcHQ7n7QcKJtHlAEhm1KiKsgymcKLgoqhOI8l94mQ2buqrc?=
 =?us-ascii?Q?i20zNm8BsmyVyRETZ50SyLjXcg9KUcn3HI3ba+wm0ymnSGxt27U/uXbLmSs8?=
 =?us-ascii?Q?51pJfAdj3kFTXR/pmczxO9kiUsBF0v+50V2/GC2sslBUsS9Rr88TMnR/oUPO?=
 =?us-ascii?Q?dibfVzXkzLARnO5dN/cOAe4u2icoPfLaLOC066DodhTF38i3jKsgB5h2IgWU?=
 =?us-ascii?Q?4yG8IQJnnSTcDZN9XZ5d7sOhe/donf6oH7enWHal57ahauyEzMGRROm7g5L4?=
 =?us-ascii?Q?g4khXAQXA/QEOJ+xrxEtaG9rO6QYa/gok3xsklwmhl/RwfHwkgPAqFK11DHo?=
 =?us-ascii?Q?Clp7hNhC5SPWU01UsnDjVay4P8A9Ih0u/yzG6SiElZx73A8S0LNv6xIiTs8J?=
 =?us-ascii?Q?txbAPyQGg0KSPAeWDL5VNzcRCic5gmzvtPK6JhIhl50KWdChjbmE7wL8n/mN?=
 =?us-ascii?Q?aSrEBbXlUYo3RMuleJ+1233xQFHqXKfYEdpvU7O/zwRU+3gNFzKIkbL8cvL+?=
 =?us-ascii?Q?z0cCFXIVnmB+VeidlD1RajGfXo7ur+LaRihcxErOzowZ2okFPdns9F6a9H19?=
 =?us-ascii?Q?BZCXcp/W20piz5Z0bfjGNSh59RUyrESX8+GkAQmRwUdFLYkrNcKqQlaKSHhD?=
 =?us-ascii?Q?PpF16UU7O/vEBUpWSdL9KOpRDT80PdlPVBS1XSsOfuS6r6l7AQxKv37zfLsO?=
 =?us-ascii?Q?OPEqi/zM5yapMEvyTD9++/ZgFxQZEUUjbe+uNABB55HIBeg93sCs0sdplFaP?=
 =?us-ascii?Q?lUpJWcx+VEabQQ79yyBQbYw/wQdV5BuKwgn7iDVgvOYz450TZMfj572dnu2L?=
 =?us-ascii?Q?qI7VZskmA2d0yXVLzaRCYQqrA57Kqm85JL+DZZtuy7L2RY/viHub5b9bcWcs?=
 =?us-ascii?Q?DdKaYyRScz0tTKy2KCXWZpmDPIkegI2j7soNtpIKaGuxrN/XP0RCufa1c/n7?=
 =?us-ascii?Q?pr8InsGqnBaGLwwoWIzXrM+K77+mSPVK4kcmWyGxGOfW7kZkpxI/NX67DrIN?=
 =?us-ascii?Q?CBadE7p4UHJghTmEi/yYnmY11h/BbnCsWX4h/t85g4YR45Edr3tM9srJ/m1I?=
 =?us-ascii?Q?KwFihuuk4SjGcol1FE+zFn3pUhRzrreKXxd80fve4qDfpNsvuU7vPD0T7oqN?=
 =?us-ascii?Q?RnepJmTmr74rhd4wNEeVcntYOr3+3KqtQZpfxyEyvNm8n6sV1yfZ7nMkjpR4?=
 =?us-ascii?Q?G8+DaVguE/mx5Rya5FOZL2zUPhv+MMDCeMp8/gGxmyZmmghHuUIhD8BiQv+m?=
 =?us-ascii?Q?z1Qxb9shgIUh8KPiQ+ZzV+MUCpiiwepUDbf5KumKFWoPRzgvCm7MjpWiLcLv?=
 =?us-ascii?Q?SFOYzcvx9Wa2ZZroj6vuK6jJwaWHWGITVe/10zwZTpyxfx4GWHLfU3y5nIRS?=
 =?us-ascii?Q?Blb6CAvWtMFoDhYvLc6QsoOZ+m8EQgK4lsngBiNxPbFkjwY8sbA4AgkpiZ12?=
 =?us-ascii?Q?7qLbXzKlGMtla7oDSAhLWpW3fS/gDU2m5XjD/LZoywrEsGcJuRGeFOTKE/Td?=
 =?us-ascii?Q?jlX5g/eEaM2cL172w0puvMPNy6FnAxCu9rxT9hW6U4x2duBjjdtqBzybDdx1?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fSrMFDFRIF+DgvUYAstiva4GJK6Usrp5MIulsg8vsmaupntZhp+vPVTnh/jKXQYsPMYGluM1qyUDmnyvdH2fK8dHH2M/C/zGyM0AnkKUUC9RwVfyFQqkdCCZ/51ZtkOUe/h1xDeHjkUWHbVIr5yehpe6EqDdZGMfSSsQid5MwHJizWEhKz7q0QNUH0L0qmoJNl8Y1mTe3hJkWIpBZWM2IhBNIlOuUGhepa3h/Jr7uCpLWAmLdP5ptZCZhTrX4UWMjbfU7cQn3L8Rz6BunMwB8hvWjQ34Y9ZmyPb+KhjnmeUb6TATFLyBunvPkW5ZPWn+8KODWA8fV75Ri1sUt74bD3Bqi8d6E8diy4weeNcB2jcMuUbEAy3p6A6CPkU2njAed0Q+TO4b1mh2xRAIdUjPZc4mk6l5Hu8az5b3WdmA6cStvNyavGS7Nw40of/xlsb/8LBlvpHOYoDutZTD4nqh6a6bQtcI7QeFn6H3Z0ITWaj7RvRA2HP4FrCR5DIsiUNJovFn0bp74yuaicMzILwtpOuOttPrUORQHqmK87VEF4Q+rAKDzEyxkgjlLbISh1kcy6HF4eZiq/gIHKERWS3ulWTS7QihbPu7/HGksi9srz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f75e6ad-4073-42eb-04c1-08ddc552d36f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:08.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOH4jY26NQxsz8i3FR0+hwDI0XSiavZNi7MKmu/8wRt0iKzgxrjK7ABonWSG5ghevAwUoo20dylL/sacmwA8zYEhCshglgGFMrgJbk1NXA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfXymDXwxdFD7dD gOEmCOM4t1fgflXtyBTXsrR5GZz9WKIS/HXetglz0uEdy1/ibLJUOek4ykYZ9okUwhxf2sP4M/T vLIf4i6oywXnbhmsfh740FXuysRQYfHXdarRw5AkdBX+NEBtEIccjQBhTCsVteY9gGTm5Pi9a/l
 gA//XwAyyXBaadkuzg6sWqhcS0tBfgNIQ+TRMcaW6Ia1fb3NV6BIn6j4zpcQxSHO1uO4VhObbxz y/ub3ALKUz3iMVQ1u9oyWeTjmEqvgW+n/mPYuH0xb1zoCPI7PbiWxazRHjuB+HBRsaN7Sfo9aaE DsGZHlBFrcQmrSKYPR5JqZ8mFXpTcs2EB2pf1eqCKliyxlIvTmrYghZ0LnoBMaBju72VI9/vq50
 aNCD1ZwxRn3w/VlQpLyD6LRvKt+cVJ2LOOFWko2LYjxgBlt+IWzV1qpBjKi8GT3242aKYmx8
X-Proofpoint-GUID: fGus6e9G_uGtfIBNUnj3qdlcnljAdbLl
X-Proofpoint-ORIG-GUID: fGus6e9G_uGtfIBNUnj3qdlcnljAdbLl
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68792b3b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-y-8OK93jEFqfRmHsx8A:9

We const-ify the vrm flags parameter to indicate this will never change.

We rename resize_is_valid() to remap_is_valid(), as this function does not
only apply to cases where we resize, so it's simply confusing to refer to
that here.

We remove the BUG() from mremap_at(), as we should not BUG() unless we are
certain it'll result in system instability.

We rename vrm_charge() to vrm_calc_charge() to make it clear this simply
calculates the charged number of pages rather than actually adjusting any
state.

We update the comment for vrm_implies_new_addr() to explain that
MREMAP_DONTUNMAP does not require a set address, but will always be moved.

Additionally consistently use 'res' rather than 'ret' for result values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 55 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 1f5bebbb9c0c..65c7f29b6116 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -52,7 +52,7 @@ struct vma_remap_struct {
 	unsigned long addr;	/* User-specified address from which we remap. */
 	unsigned long old_len;	/* Length of range being remapped. */
 	unsigned long new_len;	/* Desired new length of mapping. */
-	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	const unsigned long flags; /* user-specified MREMAP_* flags. */
 	unsigned long new_addr;	/* Optionally, desired new address. */
 
 	/* uffd state. */
@@ -909,7 +909,11 @@ static bool vrm_overlaps(struct vma_remap_struct *vrm)
 	return false;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
+/*
+ * Will a new address definitely be assigned? This either if the user specifies
+ * it via MREMAP_FIXED, or if MREMAP_DONTUNMAP is used, indicating we will
+ * always detemrine a target address.
+ */
 static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
 {
 	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
@@ -955,7 +959,7 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
  *
  * Returns true on success, false if insufficient memory to charge.
  */
-static bool vrm_charge(struct vma_remap_struct *vrm)
+static bool vrm_calc_charge(struct vma_remap_struct *vrm)
 {
 	unsigned long charged;
 
@@ -1260,8 +1264,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
+	/*
+	 * If accounted, determine the number of bytes the operation will
+	 * charge.
+	 */
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/* We don't want racing faults. */
@@ -1300,12 +1307,12 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 }
 
 /*
- * resize_is_valid() - Ensure the vma can be resized to the new length at the give
- * address.
+ * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
+ * at the given address.
  *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vma_remap_struct *vrm)
+static int remap_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = vrm->vma;
@@ -1444,7 +1451,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1569,7 +1576,7 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 
-	if (!vrm_charge(vrm))
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/*
@@ -1630,7 +1637,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	unsigned long err;
 	unsigned long addr = vrm->addr;
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1703,18 +1710,20 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 		return expand_vma(vrm);
 	}
 
-	BUG();
+	/* Should not be possible. */
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret;
+	unsigned long res;
 
-	ret = check_mremap_params(vrm);
-	if (ret)
-		return ret;
+	res = check_mremap_params(vrm);
+	if (res)
+		return res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1726,41 +1735,41 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 
 	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
-		ret = -EFAULT;
+		res = -EFAULT;
 		goto out;
 	}
 
 	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
-		ret = -EPERM;
+		res = -EPERM;
 		goto out;
 	}
 
 	/* Align to hugetlb page size, if required. */
 	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		ret = -EINVAL;
+		res = -EINVAL;
 		goto out;
 	}
 
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
 	if (vrm->mmap_locked) {
 		mmap_write_unlock(mm);
 		vrm->mmap_locked = false;
 
-		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
 			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-	return ret;
+	return res;
 }
 
 /*
-- 
2.50.1


