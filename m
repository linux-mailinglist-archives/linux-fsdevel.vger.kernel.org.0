Return-Path: <linux-fsdevel+bounces-75036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EalJyQvcmmadwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:07:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54267B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 095B8980055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0682E1F06;
	Thu, 22 Jan 2026 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NV8+ugOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022088.outbound.protection.outlook.com [52.101.48.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B228727D;
	Thu, 22 Jan 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088531; cv=fail; b=Pao3zfyRrmijhbx7fYK3nUTNDvblFztXKCTKVczXLE92toMbGdyh+8fFNq7Ze5NbIgIxqoSryv4k3Kp0bPWApV98D70llsZg8a0L75SKjrNAYU/UU2Y/Ny4xvBl1HHDfLMJE6FZO09lgSQX6LkxXdZWQD6NdAQPpJj+jVSaf0C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088531; c=relaxed/simple;
	bh=JBilhtx+moRv1O6j0N1gCbBYeR1+wY3VZadf73DObvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOyQ4bmeqIxZxX1B848yofTWbU1E77Zh03XN30gobSJyFSq1dOdxmNGx8hRSwntsQIVmgnxIGKblOmegrK0ysC6A/zBmPvFvbP3LuSpnneqtoik46+jRg4G05kBLvjR6F84GT3ErrmAej00NVYEmmFRVNw64EGytg0/0CAYBx0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NV8+ugOC; arc=fail smtp.client-ip=52.101.48.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLZ3zIl3zNNWd145i2JDvW1BlCvPi/EhtoOKtOj9nYQHnQTcwVEgIZd/ZOO/lpqhJ670SXrJxTRCFgWn8pZqrd5ScRCosRyVZ62ceu1WTxRId1Cp7rMJiZlIVr7yl1xhu2L/OWYa2eXehSj7cwjXcP2esdaG+7RoOoQjbVVLLGANsGw8zhNU+07+RoQY4A/xO5zDbCgaQfRglZs2qb5ayHF1MUEGDj7xPOTKsYsyGH/Nbgk7oz/8YfPXjraAYg2Wcw5zkx/w+tDQIoYBncn98UHcg8YWPILS0RGZLzWbY/GWfIfb7RuY4shTasfkvzx0sPSdIZ5s/2ZWjh8ysTzgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQdDRNxvW7iHjgTkAnLeKEmSpJmUv0ejmnA27uKQCqA=;
 b=e7YiXNESXrgVUsB9h6vtoMjOCH+3EdbXuXjR82fBxBzyg/nT7TVX/jhjiSiqmY6Y+j2tYiyhSqbNbdDSQgOVw/pOs74OTyzWZVV3+5Lt5kK4e1ulb1pdbsDEYR1/xenWQYzITazyXxyJ/bBs34XeVWHCw+QFEwESwD3KN/+t9ZBwKClxmUGNTyUDmRGaTEcugvIgOWPHLKycw/nAmC96k2VQizXRaFBDornbIM0we3P2ghYgFZCtjPRq69GvF2cuL9QYn6D3KxVcRnu9ckPXzl0w8/NkHQrQHooKBYpmXLBPidf286yQJYUIttGvt5dabX4kIOecDpvSHYkcjEMa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQdDRNxvW7iHjgTkAnLeKEmSpJmUv0ejmnA27uKQCqA=;
 b=NV8+ugOCI0HaK2u/5vhpKI1wWpSD4AkilTgBXfIzWjNEw6/Q/TmJH1PLR6AiCgEUk+JSulSKX129cUamJBSj/R49hJYuk6iLKNXcx1L3/sloQgUJegNUCCWfwYNNfnHbTxc69xXTQc/33JvncgBbYWaWhstFjK8gFYhleUN4gXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB5283.namprd13.prod.outlook.com (2603:10b6:510:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 13:28:44 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 13:28:43 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Thu, 22 Jan 2026 08:28:39 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <989656C1-F190-4F58-AB82-974F63551C26@hammerspace.com>
In-Reply-To: <d43cd682b0c51b187ba124f0c3c11ccc9d8698c8.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
 <d43cd682b0c51b187ba124f0c3c11ccc9d8698c8.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:510:325::21) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e106b0-04c5-4fd7-2974-08de59ba29b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gECqmwKKwhYVyVrLYzDMM7yraFCuB0LNdmDfuQqLC0a+0d0M0wneb8fi+Xav?=
 =?us-ascii?Q?GHE6zONFww8phvvaitqwyYtRwQC6A1npWPWvLDDxIfgmYay8ws2BVcE/KNtg?=
 =?us-ascii?Q?1jhaWryTY/Pf/KmqN94JsBJR9O9/tyMYy9gWdP7rm9+eHfhSnNsPcKpgrUYf?=
 =?us-ascii?Q?fR2N/cJLV3rfZz6NOaZfTVec7k7g/CKhCA6sMpDCfPuBbYRvdDeDY7FEhIx3?=
 =?us-ascii?Q?PvDbxUEBY2GW6AWWjnZCC309mKRpAByjf7r89nepGFOBrULEyrw3hju/Zky1?=
 =?us-ascii?Q?mimN/w1UyTsmwsU3e5t6mTEakrhv+mm2apFGLJ54izQWaR4UjqMVkrqL7CVs?=
 =?us-ascii?Q?xoXwDl3aVNik5XtMycSeQ9ZQD1pliLWUjSKIG8rARJYQeT4UgraWtKYs6KTS?=
 =?us-ascii?Q?0yyfk6/XmofqIxrNrhSS/vIqbAdys6mC+RQupbl7azElG1RYvE+zlTBoktE+?=
 =?us-ascii?Q?5MN28lw9lxXeH6Gkvd7DjJ13pmIq8Ekd4CyoA5/xGOvMcnwsta7Wvih4b/+F?=
 =?us-ascii?Q?oVXDat/g3DSKofeQG8JgLfKH+q1wywLzYXQVjHlnE3B0qT7O3dU84WdR9Gc6?=
 =?us-ascii?Q?td+3OWnjFVsLBhTzYe6IkPaIVbKQOK+Rcf3aw0Xya1Efofpe7bvZZeySFJNu?=
 =?us-ascii?Q?vpxQTfcW9bRdngP6dTFYSiZVLNMPTYIPTB1OImhUkmXfA0PsKqwXJX5lScBB?=
 =?us-ascii?Q?rjFRDNi+8NK2PwkyT4TRPQEpa5Gh2ysmGn0Mi6tBJniL0Q3THHrSnTLh6iOR?=
 =?us-ascii?Q?loCIQAQ2jJ/KAf7UvkcFlmyg5BE79vWe0lYVvnxakbejJ5Je167t44PM9LQ2?=
 =?us-ascii?Q?EzGDtaLqYqVohPOO/mFTxV4NPaK4Q3uIDJxTRmogcnJ2XkmrlzzLB94Hkq+1?=
 =?us-ascii?Q?XVuQGUp7V6BgNqobjeCEB+ObdfK2ywknLILKjpd065DHcjcwX1aLTnXoj3RP?=
 =?us-ascii?Q?UdYse3wFHfLryDGATVGIhXqK+f5tk/xd9QpI47t7WCvsi6f+2+vAzwrOgAqW?=
 =?us-ascii?Q?N9oGRbwAS0C1dMAIr8IIM8GN1mrDlKTK1Ae6xOS+IvW3Unfzp/PFy/SwUtLY?=
 =?us-ascii?Q?KnbvTvwrxOaAO1wwrhQpHLxaorl/vqiXxIG94oVCbFzB6DqreIVmm8XR4iYg?=
 =?us-ascii?Q?1ilMdRAnkCh/21BIi77Xgz2OAb+NGNqHd/5fqgvyk2flX0nh63gIwDdHpbxG?=
 =?us-ascii?Q?i6zLeZs0KIHKTbscL+C7LOT0Wkti0+w3qmX4feFwN3fJvzPIGZPy/462U34u?=
 =?us-ascii?Q?iZNCGjQUNOERzJjXOJjEsP8JF/J+myyhDUfvqKzMI30nAuMS4c5dt57PIk7Z?=
 =?us-ascii?Q?KAlAXgkySbazCbnCY3NQx17E1GH8kGDwEYS0Lz7IZ1P4jtc7kX0Jy4iUtv6k?=
 =?us-ascii?Q?AwdPPovDO+q4y1aRbRlfIGmYaYFdBqSGSzssuIt48uR/e24TW3HGWi/zquUP?=
 =?us-ascii?Q?/2ZjcbzMwd1YOW7vOUxsizf3hjP2B6s9C+XE67838At0mL4TupL+6OQwDZTG?=
 =?us-ascii?Q?zOSPciqnihTNkIXaQt6rLNoMwESRv9m0NGmYineecY1gpy+m5ISB5ExcnoZG?=
 =?us-ascii?Q?FD/C5Mr71vgvpT/M02c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?62hMVUnfJypgFu9JJYl3CTAYE1iYX24LBqj/An0Gp4UXsLO1+rNoevudv5M+?=
 =?us-ascii?Q?aBaxWL/Jvj+/li43CG014zIVrCM1UkFF0cNPs+UrooIuAodoELY/xg700T3e?=
 =?us-ascii?Q?Dpgg4owICs6SYyesS16pYXe7KnTvKeK0ebTpCjhnjdMw0amZ5BmZlRYkkHG9?=
 =?us-ascii?Q?6YV/9fzk0iaaGXggFWaH3Ck/OoftmFt+MgmRsNKQVucKqILRDBIGsF6NmXRT?=
 =?us-ascii?Q?bsjZ9ZbcDGlOk6ONbW7laXCReIbitqjj7Cx+5A8edGgTEEYhjDMnZiV7HT3w?=
 =?us-ascii?Q?f8jks7YaoC/XM/U6rdusxoM2fEvuHjHq8osnAwkjXu33hy6PucfM22dSPCfS?=
 =?us-ascii?Q?+anj2epNmBLiV+Z6Ox4RxQV33+A89joBztBjI8pFq7UFA/fjgNgauaOpxygI?=
 =?us-ascii?Q?cvJmXTLCskeMnFf7xSwzmwujwKgtcDRcSPAV3+SNWsSIeUjMo3lviI9VeYRT?=
 =?us-ascii?Q?U5TurzDrl43NVgcMeWjqPm9LadbBCuk1aDyMQBX/6x2UnFaVpURG4NnyELZE?=
 =?us-ascii?Q?zrrt3G0o3cRdiQZaz8+BbSRFQv9wppSpKeh01hRlrcTRyx5Q/McN/i0w3TLS?=
 =?us-ascii?Q?ROJ1CMRVcDxSHqux+SqXtIYTXJV89GVtCfH4orLEyzqbQ17Jyb7Ryg/I0bqw?=
 =?us-ascii?Q?j84Pf4Fjv30q60YElpslQPN5JSNM7xmJY67Vm8GQiwkj6xetquFvVn2W8Vft?=
 =?us-ascii?Q?h+sciE8ZRbv8ELnC5mJTNUxFoQkfDBwkl81YQ4ahUFIiaA62gF+1zN9vJI4r?=
 =?us-ascii?Q?xCE+FsTCKblASdBb1imMO3PCDOmm5yzD3FFa5OWcgdPV8C5Cz0ruSFbm+t+a?=
 =?us-ascii?Q?9W4ULZpEeAfaWcZV1W4KnJAzGbTe5M0xJ34FQBoXau+qI9mUuvZ0MIh7zbFa?=
 =?us-ascii?Q?6o1B/duD5vWP+tfsa/es33q+zI0GybVgwTdM+9NZioxVn45Eo12w4bFsJrQQ?=
 =?us-ascii?Q?kINGSiLp7nvKhIYmCNxE40+oCf3h4jcZNS0uPRtZZcnV+8K4SlGsbuwEvJPF?=
 =?us-ascii?Q?IKzZdFBYPEo10KqlI0ze1loinitfN9ULD5raH6Tu6vVO3G3B1Y7b9s8aw7mp?=
 =?us-ascii?Q?Hpiheu4tFPT9GDQLuquPsW+HMJLG4hQhdWQvmgB/p2UvpV5AA/pFYbvQyb4U?=
 =?us-ascii?Q?Jt3ynZlhSHIuwa+zo8qYgQnXFiDDgLhcEUoYGugLXSfpg9TX0wimJSVEHb/T?=
 =?us-ascii?Q?prBFo4V6g5x+JjhPC4+KjTIf92lB6koPDAhyt+fBIXixYAMK+4tCTSLf+Nct?=
 =?us-ascii?Q?om4B+ykpCceu7z9GRNDFVuTEMhLdPtIIV2Vn5kto8xfpO/MpcnjZegQa6jU1?=
 =?us-ascii?Q?kBZpqRsYKhHu2oWVNpohxq8Hndw4C30wVG1jfvEmKNwbkytybAoeZthccL2/?=
 =?us-ascii?Q?Rn6EBBWIKeuwtcfzDEk0jWtQL62sV87M7xgRvHcF/30nZd19aeqIYO/IHhf4?=
 =?us-ascii?Q?EyPgKekjqGL92AH/+uQizP6ZHF9/unTSITf9sCNkGYgU7iubNuc+kRkgM9a6?=
 =?us-ascii?Q?kileBSDeGBH9HovD4c7TL1sL3FA4q1zhN32rkMYJ7Fg/Tal4B+VuvEbSL/nj?=
 =?us-ascii?Q?PYZ+JjPLIOpvH7x5McFsOPCZUFDnZmfHd6vaPbpWlZQXIhbv4fwj4k/A9a/J?=
 =?us-ascii?Q?KNKOf6IpAVEmLEWdv68T7NwPZ5xEqhx2gyiWBuy+it/9rFWVca8jW9Hy/7nO?=
 =?us-ascii?Q?ZWum/TbXNDiDb7yIm7fhZYITsk7XOBSmPcgmeBkWiEgDa0bplytjgWfrbw31?=
 =?us-ascii?Q?04C7NXNR5WjKG27N8VS7UEq8j6l9aiA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e106b0-04c5-4fd7-2974-08de59ba29b1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:28:43.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aScCflrnqFP96cXUnAhx5sxJAmqPfMwqGO/3BgQUqcS+c2fO4zTFqC0lAuCgcqcE9iOZF/5oZ35jYYb2XAlklqb3TJIOjNx1+GsLtde2wtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75036-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,brown.name,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE54267B22
X-Rspamd-Action: no action

On 22 Jan 2026, at 7:30, Jeff Layton wrote:

> On Wed, 2026-01-21 at 20:22 -0500, Benjamin Coddington wrote:
>> On 21 Jan 2026, at 18:55, Chuck Lever wrote:
>>
>>> On 1/21/26 5:56 PM, Benjamin Coddington wrote:
>>>> On 21 Jan 2026, at 17:17, Chuck Lever wrote:
>>>>
>>>>> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>>>>>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>>>>>
>>>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>>>>>> A future patch will enable NFSD to sign filehandles by appending a=
 Message
>>>>>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-=
bit key
>>>>>>>> that can persist across reboots.  A persisted key allows the serve=
r to
>>>>>>>> accept filehandles after a restart.  Enable NFSD to be configured =
with this
>>>>>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>>>>>
>>>>>>>> Since key changes will break existing filehandles, the key can onl=
y be set
>>>>>>>> once.  After it has been set any attempts to set it will return -E=
EXIST.
>>>>>>>>
>>>>>>>> Link:
>>>>>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@ha=
mmerspace.com
>>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>>>>>> ---
>>>>>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>>>>>  fs/nfsd/netns.h                       |  2 +
>>>>>>>>  fs/nfsd/nfsctl.c                      | 94 ++++++++++++++++++++++=
+++++
>>>>>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> index badb2fe57c98..d348648033d9 100644
>>>>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>>>>>        -
>>>>>>>>          name: min-threads
>>>>>>>>          type: u32
>>>>>>>> +      -
>>>>>>>> +        name: fh-key
>>>>>>>> +        type: binary
>>>>>>>> +        checks:
>>>>>>>> +            exact-len: 16
>>>>>>>>    -
>>>>>>>>      name: version
>>>>>>>>      attributes:
>>>>>>>> @@ -163,6 +168,7 @@ operations:
>>>>>>>>              - leasetime
>>>>>>>>              - scope
>>>>>>>>              - min-threads
>>>>>>>> +            - fh-key
>>>>>>>>      -
>>>>>>>>        name: threads-get
>>>>>>>>        doc: get the number of running threads
>>>>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>>>>> index 887525964451..81c943345d13 100644
>>>>>>>> --- a/fs/nfsd/netlink.c
>>>>>>>> +++ b/fs/nfsd/netlink.c
>>>>>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>>>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>>>>>> -static const struct nla_policy
>>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
>>>>>>>> +static const struct nla_policy
>>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D {
>>>>>>>>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>>>>>>>>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
>>>>>>>> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>>>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[]=
 =3D {
>>>>>>>>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>>>>>>>>  		.doit		=3D nfsd_nl_threads_set_doit,
>>>>>>>>  		.policy		=3D nfsd_threads_set_nl_policy,
>>>>>>>> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
>>>>>>>> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
>>>>>>>>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>>>>>  	},
>>>>>>>>  	{
>>>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>>>> index 9fa600602658..c8ed733240a0 100644
>>>>>>>> --- a/fs/nfsd/netns.h
>>>>>>>> +++ b/fs/nfsd/netns.h
>>>>>>>> @@ -16,6 +16,7 @@
>>>>>>>>  #include <linux/percpu-refcount.h>
>>>>>>>>  #include <linux/siphash.h>
>>>>>>>>  #include <linux/sunrpc/stats.h>
>>>>>>>> +#include <linux/siphash.h>
>>>>>>>>
>>>>>>>>  /* Hash tables for nfs4_clientid state */
>>>>>>>>  #define CLIENT_HASH_BITS                 4
>>>>>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>>>>>  	spinlock_t              local_clients_lock;
>>>>>>>>  	struct list_head	local_clients;
>>>>>>>>  #endif
>>>>>>>> +	siphash_key_t		*fh_key;
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* Simple check to find out if a given net was properly initializ=
ed */
>>>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>>>> index 30caefb2522f..e59639efcf5c 100644
>>>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>>>> @@ -49,6 +49,7 @@ enum {
>>>>>>>>  	NFSD_Ports,
>>>>>>>>  	NFSD_MaxBlkSize,
>>>>>>>>  	NFSD_MinThreads,
>>>>>>>> +	NFSD_Fh_Key,
>>>>>>>>  	NFSD_Filecache,
>>>>>>>>  	NFSD_Leasetime,
>>>>>>>>  	NFSD_Gracetime,
>>>>>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file,=
 char
>>>>>>>> *buf, size_t size);
>>>>>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t s=
ize);
>>>>>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, siz=
e_t
>>>>>>>> size);
>>>>>>>>  static ssize_t write_minthreads(struct file *file, char *buf, siz=
e_t
>>>>>>>> size);
>>>>>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t =
size);
>>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>>  static ssize_t write_leasetime(struct file *file, char *buf, size=
_t
>>>>>>>> size);
>>>>>>>>  static ssize_t write_gracetime(struct file *file, char *buf, size=
_t
>>>>>>>> size);
>>>>>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *=
,
>>>>>>>> char *, size_t) =3D {
>>>>>>>>  	[NFSD_Ports] =3D write_ports,
>>>>>>>>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>>>>>>>>  	[NFSD_MinThreads] =3D write_minthreads,
>>>>>>>> +	[NFSD_Fh_Key] =3D write_fh_key,
>>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>>  	[NFSD_Leasetime] =3D write_leasetime,
>>>>>>>>  	[NFSD_Gracetime] =3D write_gracetime,
>>>>>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *=
file,
>>>>>>>> char *buf, size_t size)
>>>>>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthrea=
ds);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * write_fh_key - Set or report the current NFS filehandle key, t=
he key
>>>>>>>> + * 		can only be set once, else -EEXIST because changing the key
>>>>>>>> + * 		will break existing filehandles.
>>>>>>>
>>>>>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>>>>>> think one or the other would be sufficient, unless you have
>>>>>>> something else in mind (in which case, please elaborate in the
>>>>>>> patch description).
>>>>>>
>>>>>> Yes, some distros use one or the other.  Some try to use both!  Unti=
l you
>>>>>> guys deprecate one of the interfaces I think we're stuck expanding t=
hem
>>>>>> both.
>>>>>
>>>>> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, and
>>>>> we have publicly stated we will add only to netlink unless it's
>>>>> unavoidable. I prefer not growing the legacy API.
>>>>
>>>> Having both is more complete, and doesn't introduce any conflicts or
>>>> problems.
>>>
>>> That doesn't tell me why you need it. It just says you want things to
>>> be "tidy".
>>>
>>>
>>>>> We generally don't backport new features like this one to stable
>>>>> kernels, so IMO tucking this into only netlink is defensible.
>>>>
>>>> Why only netlink for this one besides your preference?
>>>
>>> You might be channeling one of your kids there.
>>
>> That's unnecessary.
>>
>>> As I stated before: we have said we don't want to continue adding
>>> new APIs to procfs. It's not just NFSD that prefers this, it's a long
>>> term project across the kernel. If you have a clear technical reason
>>> that a new procfs API is needed, let's hear it.
>>
>> You've just added one to your nfsd-testing branch two weeks ago that you
>> asked me to rebase onto.
>>
>
> Mea culpa. I probably should have dropped the min-threads procfile from
> those patches, but it was convenient when I was doing the development
> work. Chuck, if you like I can send a patch to remove it before the
> merge window.
>
> I can't see why we need both interfaces. The old /proc interface is
> really for the case where you have old nfs-utils and/or an old kernel.
> In order to use this, you need both new nfs-utils and new kernel. If
> you have those, then both should support the netlink interface.

I'm not trying to win an argument about how I want it, but I want to just
point out one more thing: its possible to have products built out of the
server where the tooling so far hasn't been taught to use nfsdctl yet.
We're in that situation - we will backport the kernel bits here, and use th=
e
/proc interface because the tooling hasn't been converted to nfsdctl yet.

>>>> There's a very good reason for both interfaces - there's been no work =
to
>>>> deprecate the old interface or co-ordination with distros to ensure th=
ey
>>>> have fully adopted the netlink interface.  Up until now new features h=
ave
>>>> been added to both interfaces.
>>>
>>> I'm not seeing how this is a strong and specific argument for including
>>> a procfs version of this specific interface. It's still saying "tidy" t=
o
>>> me and not explaining why we must have the extra clutter.
>>>
>>> An example of a strong technical reason would be "We have legacy user
>>> space applications that expect to find this API in procfs."
>>
>> The systemd startup for the nfs-server in RHEL falls back to rpc.nfsd on
>> nfsdctl failure.  Without the additional interface you can have systems =
that
>> start the nfs-server via rpc.nfsd without setting the key - exactly the
>> situation you're so adamant should never happen in your below argument..
>>
>
> The main reason it would fail is because the kernel doesn't support the
> netlink interface (or e.g. nfsdctl isn't present at all). If it fails
> with the netlink interface for some other reason, it's quite likely to
> have the same failure with procfs.

You're right, but it also could fail for any number of other reasons -
admittedly unlikely ones.

> To be clear, the procfs interface is categorically inferior due to its
> piecemeal nature. There's little guidance as to how to the changes in
> nfsdfs should be ordered. We mostly make it work, but the cracks were
> showing in those interfaces long before. We really don't want to be
> expanding it.

I understand.  I'll remove the procfs interface here on the next posting,
and thanks for chiming in here.

One thing that is confusing with nfsdctl is that when it reports a failure
its not easy to figure out what's going wrong.  It ends up having its own
ordering stuff - for example:

(fresh boot)
root@bcodding:~# nfsdctl threads 4
nfsdctl: nfsdctl started
nfsdctl: failed to resolve nfsd generic netlink family
nfsdctl: nfsdctl exiting
root@bcodding:~# modprobe nfsd
root@bcodding:~# nfsdctl threads 4
nfsdctl: nfsdctl started
nfsdctl: Error: Input/output error
nfsdctl: nfsdctl exiting

^^ that's an actual situation I encountered, then tried to diagnose with
strace (no good), then had to turn on the function tracer in the kernel to
find that the error was coming from somewhere in nfs4_state_start().  I
think something not getting set (listener?), finally I looked in the log an=
d
found:

[   47.428237] NFSD: Failed to start, no listeners configured.

ah - so then I knew that I had to use "autostart" before being able to use
the "threads".  Compared with rpc.nfsd in the same situation:

root@bcodding:~# rpc.nfsd 4
rpc.nfsd: knfsd is currently down
rpc.nfsd: Writing version string to kernel: -2 +3
rpc.nfsd: Created AF_INET TCP socket.
rpc.nfsd: Created AF_INET6 TCP socket.
rpc.nfsd: unable to interpret port name n

.. and I know I need to configure the ports.  It also loads the module for
me.

Would it make sense to have nfsctld load the nfsd module if the netlink
interface doesn't exist, then on error it could also suggest checking the
system log?

Please don't take this as me whining or complaining - just some
observations.  Most users will never encounter these problems because the
tooling to start the server ensures its done the right way..  So, sorry lon=
g
read -- maybe we can eventually improve nfsdctl to have better stderr on
failure, or maybe the problem was mine because I didn't immediately look in
the log.  :P

Thanks again,
Ben


