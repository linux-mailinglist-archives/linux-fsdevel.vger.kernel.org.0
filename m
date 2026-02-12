Return-Path: <linux-fsdevel+bounces-76994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKtFNHpkjWn01wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:26:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91C12A68B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754023163483
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0640284674;
	Thu, 12 Feb 2026 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="K20fUoMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022107.outbound.protection.outlook.com [40.107.209.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181265464D;
	Thu, 12 Feb 2026 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873929; cv=fail; b=YTQwn7UkMoD1cLxJ0BBWImdABUTwznyZRFrdFcG1bo4y3Lw7Cs5Tq3e1MysPbdI0kfhhOLPRmA0KDzmUeJWL1gKbq5sRr4wYMmoHbuw9BBdTcqc37lPywcBtOnjBv1RQrBRLYkhAWPAXhBPvR/NBbY8D5CdHMjMX+m2fMl2hCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873929; c=relaxed/simple;
	bh=IBoi+vMj5+ZGPtz1OJgmGb7SmIgBxrK3TvWyXgqWggw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dK4fKH1lo67NPXUKTumNoxJ7re70aaSMGWU4xSkb5OoAbiEQXFJ18bVKBiwO7u6G1N6BQhRajdbBAZEDzjB9YrGO0naG4ro/E92/VAWyaSD78jnmsXqxDMD4Jw4wPL2O/8RuWCou0ZshZvHnw7joHybeydgRw6I4DVbfnjKyLcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=K20fUoMe; arc=fail smtp.client-ip=40.107.209.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z94doJFB6Q2iktQhwPM2cXVC7nzp+6nw6V48SNntkyKirlfcjUHuMGnOKZWrV3vVR8SNgXcsnNvt08C4pCw9qMwMeRmR8dSK+YPtppiuKVjGMOwJlH5SDeZ3WWOyqsLJohCP3PJ7XsfhjOPGHUqGcMd/hJGxjLYrBl71ZQhXzmyzUOd92dsbYW3WjeuwLzju1b8L5rrMzZr80tXNhSxy06ZYw9OI3IopsVw7N+SVQJ5Qv18nMh1ylhauA/JG2A5vBlNl8qyKMqXhhcXjgxV1MjbBOoF4LXJ0byRICn5XlPrKmaehnAupqEW0UjgUX/zWL7I3j2nRn9FzyFDN9Gv50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhKNKiXaqlaWr8BJEf8/1Hc/a81odR55FFXEwebrcJA=;
 b=V0BkW7jiyZrKp49oLXrhQwJ8Gw+XRJ2S/+JbzUBt+b6tz+V3Ap4RatvmrYyIJvt0VmSO8X0azbR4MgOAhuqZ90OirXTBw0owkbNgklBFEt/6N9NKX77PXeZc8TNi9Y2CjPOqftKX4UPHobyFro7vcziA7NnQ2U4LsvXzXhQjsiu1fDtau+8Qclhj989rkORqZdn1S91TzM92V4Hg1dJCTkpXxdXW/wmvoez49tU0clYRoxyLIc1TRMfvn2+aG/xw0Vf7ITqEC5GpRwng+WIHdmARs52YejeNS4k/f1Jb+VQPMGT+mzSGcLf9UwhkcVEhTHgsStpbDgD1Lm94g2fpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhKNKiXaqlaWr8BJEf8/1Hc/a81odR55FFXEwebrcJA=;
 b=K20fUoMenCOjy1ASQS8RqHuOivRMOqbSQMHgkGunUzZfNfxfM94eELI3B4nYWL5c5OJX4PP4B4va0aGuDvALAeFU6f7s7QC7IJxfdNfooOABk58Nsl3aioG4xk7qL3/Js8f9bcbTDVzLOwOiJUS49kYncF61EVDH27gdvrSVrYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH4PR13MB6881.namprd13.prod.outlook.com (2603:10b6:610:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 05:25:22 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:25:22 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v6 3/3] NFSD: Sign filehandles
Date: Thu, 12 Feb 2026 00:25:16 -0500
Message-ID: <43379d1283567245c97a38eb00dfe79f9796df93.1770873427.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770873427.git.bcodding@hammerspace.com>
References: <cover.1770873427.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH4PR13MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed27ba8-b5c3-47c1-8307-08de69f71e49
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gg8orKQvf4+it9uqetpjL2JuGG/hb2MJapNTUw6jPKHgFiFxXVyFMJu/7sHb?=
 =?us-ascii?Q?nywadkq6It6U25bvEO31KJLq4orQQj6dtdkgLpuznxPA6eGu/9qk3iyp/C14?=
 =?us-ascii?Q?80jf0tGDuHNwifzf50SkV5MrUd5WdMLcQ1suS8x2c9SgvUTXixzUlouqEOx5?=
 =?us-ascii?Q?fOeenJdx+vdI0cKqxMVNInB0GGcAeR03f0O6JF+QxYA3j1O4Jj7Y6A+rvsQZ?=
 =?us-ascii?Q?bSOZ6J1GSCHqmPWqX0Gyg3aY0alyrcN2PGiPj8x8bd1qqNXCyFp4j4uT4OMi?=
 =?us-ascii?Q?W3hRpzgssTv1x0S0whj4ETFI9dwGWUJA9ropaoruepYjI+dgRJH/WvBzomaE?=
 =?us-ascii?Q?dFC3QbvzcdF8fMp1ygAtphUhT09izrazzcBZSGt5CJ9QmjOMjp0oYClFYZ5v?=
 =?us-ascii?Q?poyYfX4P1BFpFHR90A4TSsQHY5HR8qe9tovaDca3Xq86QF+rKL82qYGw8qn5?=
 =?us-ascii?Q?E0bZmA9iwgS4SZpAmmzXjsSTPDW7APTVwaZD8Q9tSUjOQhkXNloBHnq9Cf2K?=
 =?us-ascii?Q?vXNDQ3GR2N5pTcB8Xjw0S/rIZnUhjsvKERkAOsW1XA3sF0bxTVzXucdYba19?=
 =?us-ascii?Q?y+JNqv5J73RB4j1CXrihwoUskKUiKl9cP1xIKXxBVeMIINIVCDa694uW8hoM?=
 =?us-ascii?Q?1hghaP9rLimHqhnVh9DOyH9GTppZ51OHTrBcdX7tzeljnFshy5B9bXh4XWWu?=
 =?us-ascii?Q?1T7wIE6yAtkyp5ql0yJkdvWfLIaOcZ0N4Ny4lZBR5kwgsh8o/fDUhIwA3vQL?=
 =?us-ascii?Q?c3eBMsiN/bMXvp3RyJTm756SHYiGS6w8ts6IsRHf8drF9jk/hm8m5mk5CLZ3?=
 =?us-ascii?Q?EP6KL6MczckpB23pVaruMew0UAs+f9JCWW46MQPf8hvXwtAWN76Q9vLa5cv8?=
 =?us-ascii?Q?kq2zltWywGo0IUGiykdoMM7KCMzfT68T6P8/vT3FvkSpvzghhTPh86SgzFsQ?=
 =?us-ascii?Q?8iF0pxrDSgYYsuIPFLT1bDuP16baw4If9L2UxJYkUdxmESkxRLXpBLcrPExQ?=
 =?us-ascii?Q?SZbTVlSK+mDyIgXqFkUz/QOilLaLqySDp2Df4yftuXVpJ/aT2lLoj1wZdZos?=
 =?us-ascii?Q?NWQD+ZvitVh/9XcF5+cgRSZAqxQCzlv9tgXU3fIIbrsrkgxDd9HundYSMToS?=
 =?us-ascii?Q?+h4LzKsSUKE8rxkWCwJJNdoZW2oy2HzSGf/8TyUt2PjGMw9vSabtTQUi0uh+?=
 =?us-ascii?Q?FqM8Yg9CYTp0mtUwRYbLxjbmeuCFaNFMJ2sY7tN3P0w1+xgKSmcn1m+cl1Zm?=
 =?us-ascii?Q?NOCoUCPsndo6Fb/mLXauSTS9BTOhZASagqDhKw5Lnpj/dbFIrJ03fML4XCYQ?=
 =?us-ascii?Q?PaZdz8lPDWwNer3NrbOyvqMLgGwoYm5YdwZLSSjyK5f1XnF0x//5kbgPPbnO?=
 =?us-ascii?Q?OlJS7cK2UKDcP8BFvnUzjhTTMG5qGjOQfgBITEGkaC2nfO0XeLflv/za2/yV?=
 =?us-ascii?Q?Uya121xcweVXDQwiFZp8jd4opP+2dc8Oqp5K9tuGcbQHmvH+dS36S3dmfoQ/?=
 =?us-ascii?Q?sXFQ8tVt6fX3B7A9GAo2WvvTS/inE1kwIzcH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79bzRhYzTwNkQNd7vptSdfOc/5FWJ5GSDy7qu1UMaNHG6iP/Bp8RAczEuGh9?=
 =?us-ascii?Q?/dllCAoscQoq/QvBF04SP26ZERva4OeGSi7h3BoKH3b9g1pgVMcc2ORchz/F?=
 =?us-ascii?Q?E0fx7FIKlRHcVxMrqY/8OczU0aQ3bIzay8pLZDi34d/Q2/GdJb8qsLJfEZyJ?=
 =?us-ascii?Q?nhcm7r26IlVsobB1XwdyaF8EbzzGBvNFwDH9d+pHQ1taqBDdOVja+DpX+aEP?=
 =?us-ascii?Q?CFDmmpQNiequ3780UmmoGaP+8PlS86JyTQQR7Ww/me1vD8lsVhgTjBj0/+mY?=
 =?us-ascii?Q?ScVCp2RVGUUA9+wqI5kXRhWMvSmA37lPK24TRMNB15tCUhocuyJkp1p1Wvil?=
 =?us-ascii?Q?8xaDv0UTafqkNeutCi6rgRX8sPDn6SYjG/nvUL2wD7jXZvDjvJ1+lTnHs8EY?=
 =?us-ascii?Q?duWWpfBAiCrZ5p5NHsqeh7jKUAq8YOUw0rob002v5fYcylWgcqGgiulSKJMV?=
 =?us-ascii?Q?ayBuZQ69MvLpN1tOOCXAQDZjT/f1+QbaC70WaNobxwVYXoJqXCP9CdtvST5t?=
 =?us-ascii?Q?brj5bZY5AUpgf86sXYzNatjKgh+nDcYFp4r0E98flJgAom2Z8VLZT1wJYuVP?=
 =?us-ascii?Q?DTGYw3D8dTRHg6/v14P5ToNG8KOEyGzjO/60JQwKUeRdSKrzIutoknpsCJZp?=
 =?us-ascii?Q?0sqVPtNDCExo7eeYwnvc7fgVyYrEBIGcj1o/JoZhZfs8jhi1OIEodNyqvvoA?=
 =?us-ascii?Q?Ez+BCEMzM9CJysnOx1GxAMZAk+BLQ4upWN/20DE/TMNz/4Owej0DdMM59k9/?=
 =?us-ascii?Q?5xXZly+CVDV0hEA+RCrPOYO0+8w4p8g2OMrYMabR8ptXT3b5dGS2bOvUxfq5?=
 =?us-ascii?Q?vKlB5fSjoHgpsWIUrmv+dsJX4uopAmrE97KAV2EUD3GM0rC6QusDEO8LZfXk?=
 =?us-ascii?Q?0yRYMyv86bfeWUQOLKf+bWwTS0Cj3dp4pIOZ+FAdmki1MeWssu4dkanaNDIl?=
 =?us-ascii?Q?WvAgBmYKVJHwwk3+/DXnKBAmivXeWvBol0ewE4ac3kmuuQY1u/is3JuhMwxJ?=
 =?us-ascii?Q?ZEPqlXQxzTTJUcDq0BA596GmZP8cD9mqXn7gE4wPSCUKiV8cwoe+IjNj4ig2?=
 =?us-ascii?Q?uj4Mmpy3IVV018EZPGStcgfsLbmpeZdfQ+UcKYL3rQnqZydaY9WmmIFjbJlL?=
 =?us-ascii?Q?vMYnCqsdTmV8zTT0KiWL9XSRAIr9590skRulPBc30XJvej5o9rWS4nMOfPXR?=
 =?us-ascii?Q?6af4w3Kz8SX3eFED6nIrfTIKOhVCByrnwkfavo32lGIwOGJnIdbMDuK9ewDg?=
 =?us-ascii?Q?c/T8MUYHYSuBnBJkgQXCxfpF94kkv31gFBKBZOB+G1kwaoKE8OYeLv+SRkgu?=
 =?us-ascii?Q?ITS0L8MhmTkS8tAqRmtkOTqXEGKaZdeMdwmu0mhSd1ljuC5OdIkOeLZqysZA?=
 =?us-ascii?Q?iVGADGqcf+Kd6SORgRMMmhDZKU2KzmoWjCW57xYZa4cjzW+2Hj1Mwaz5zaiF?=
 =?us-ascii?Q?BJSSihUDbFmHZ315smnXaJ8U7rxAKXUt2w6laHCRBouMll8OH1m950q4HyJi?=
 =?us-ascii?Q?KaS/QKlWiFepDWyyB0dDCs0BZLLVLkirfS08tGD0L+b8WtQQbX3isoMrUz14?=
 =?us-ascii?Q?nxmbBfYCePMlUscfs2/LwWgabEGBVb/5hb+ib2VedJ5Mlt+RsxVkpdqbjzdC?=
 =?us-ascii?Q?aFXbylrECZIHCzgXF7rXHmL66qBa9+/jKlAWlizME6WG90Ut1Y2az06dwm2f?=
 =?us-ascii?Q?Ti7oRfVR1TzZGvSUvwf+s3+Ddgw/nP79VUsBCZZOgpDXtyv9gQJqw9RMBU1v?=
 =?us-ascii?Q?osV86rWvm0HIs5GY3DDhc5TXlYR9Yqw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed27ba8-b5c3-47c1-8307-08de69f71e49
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:25:22.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+yd3etEfxL13fWHbOKVPQulkIEUDW4XtijIzIv8Ph9L51yK1IIys1WLtDZYGIB4UyASTQHIq9LVTUR8JYGKnY9tYRCur6qToNPBWB+x+z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR13MB6881
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76994-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E91C12A68B
X-Rspamd-Action: no action

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using SipHash-2-4 as a MAC (Message
Authentication Code).  According to
https://cr.yp.to/siphash/siphash-20120918.pdf, SipHash can be used as a
MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of forgery.

Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte SipHash to encoded filehandles for exports that have set
the "sign_fh" export option.  Filehandles received from clients are
verified by comparing the appended hash to the expected hash.  If the MAC
does not match the server responds with NFS error _STALE.  If unsigned
filehandles are received for an export with "sign_fh" they are rejected
with NFS error _STALE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 75 +++++++++++++++++-
 fs/nfsd/trace.h                             |  1 +
 3 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..54343f4cc4fd 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,88 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+Signed Filehandles
+------------------
+
+To protect against filehandle guessing attacks, the Linux NFS server can be
+configured to sign filehandles with a Message Authentication Code (MAC).
+
+Standard NFS filehandles are often predictable. If an attacker can guess
+a valid filehandle for a file they do not have permission to access via
+directory traversal, they may be able to bypass path-based permissions
+(though they still remain subject to inode-level permissions).
+
+Signed filehandles prevent this by appending a MAC to the filehandle
+before it is sent to the client. Upon receiving a filehandle back from a
+client, the server re-calculates the MAC using its internal key and
+verifies it against the one provided. If the signatures do not match,
+the server treats the filehandle as invalid (returning NFS[34]ERR_STALE).
+
+Note that signing filehandles provides integrity and authenticity but
+not confidentiality. The contents of the filehandle remain visible to
+the client; they simply cannot be forged or modified.
+
+Configuration
+~~~~~~~~~~~~~
+
+To enable signed filehandles, the administrator must provide a signing
+key to the kernel and enable the "sign_fh" export option.
+
+1. Providing a Key
+   The signing key is managed via the nfsd netlink interface. This key
+   is per-network-namespace and must be set before any exports using
+   "sign_fh" become active.
+
+2. Export Options
+   The feature is controlled on a per-export basis in /etc/exports:
+
+   sign_fh
+     Enables signing for all filehandles generated under this export.
+
+   no_sign_fh
+     (Default) Disables signing.
+
+Key Management and Rotation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The security of this mechanism relies entirely on the secrecy of the
+signing key.
+
+Initial Setup:
+  The key should be generated using a high-quality random source and
+  loaded early in the boot process or during the nfs-server startup
+  sequence.
+
+Changing Keys:
+  If a key is changed while clients have active mounts, existing
+  filehandles held by those clients will become invalid, resulting in
+  "Stale file handle" errors on the client side.
+
+Safe Rotation:
+  Currently, there is no mechanism for "graceful" key rotation
+  (maintaining multiple valid keys). Changing the key is an atomic
+  operation that immediately invalidates all previous signatures.
+
+Transitioning Exports
+~~~~~~~~~~~~~~~~~~~~~
+
+When adding or removing the "sign_fh" flag from an active export, the
+following behaviors should be expected:
+
++-------------------+---------------------------------------------------+
+| Change            | Result for Existing Clients                       |
++===================+===================================================+
+| Adding sign_fh    | Clients holding unsigned filehandles will find    |
+|                   | them rejected, as the server now expects a        |
+|                   | signature.                                        |
++-------------------+---------------------------------------------------+
+| Removing sign_fh  | Clients holding signed filehandles will find them |
+|                   | rejected, as the server now expects the           |
+|                   | filehandle to end at its traditional boundary     |
+|                   | without a MAC.                                    |
++-------------------+---------------------------------------------------+
+
+Because filehandles are often cached persistently by clients, adding or
+removing this option should generally be done during a scheduled maintenance
+window involving a NFS client unmount/remount.
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..36e32c3d2920 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,59 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+#define FH_MAC_WORDS sizeof(__le64)/4
+static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return true;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return true;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
+					&hash, sizeof(hash)) == 0;
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -236,13 +290,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_badhandle;
-
 	fileid_type = fh->fh_fileid_type;
+	error = nfserr_stale;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
+		/* We don't sign or verify the root, no per-file identity */
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH) {
+			if (!fh_verify_mac(fhp, net)) {
+				trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -ESTALE);
+				goto out;
+			}
+			data_left -= FH_MAC_WORDS;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -258,6 +320,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +562,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (!fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 185a998996a0..5ad38f50836d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
 
 TRACE_EVENT(nfsd_exp_find_key,
 	TP_PROTO(const struct svc_expkey *key,
-- 
2.50.1


