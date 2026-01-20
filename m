Return-Path: <linux-fsdevel+bounces-74633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFPEGu9GcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:24:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25650627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFF6CBD8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6441B35E;
	Tue, 20 Jan 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ilcf69h6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022143.outbound.protection.outlook.com [40.107.200.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777739903F;
	Tue, 20 Jan 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914204; cv=fail; b=Y46ABkqETYK9jV/ordzSPWjFp8GHZjvy1XKAxHWVT9u3dbn6lVJbzKzvN/9O/1jQB3ZU1qLXWicvvGq6grtZ7WSCCSGQhyWZ4L6Ywp7osfyiMqO3zrzp2zs9ZnRAOG+Nfksb2GjpUvbAozT5eLRgjkZQuL6jtFP8vK4rPS+HU3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914204; c=relaxed/simple;
	bh=1ayv3VBJ6fOQD1t89GciW4+2YP9SN4s47PBegZQ+V9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQh1PT3VbH1oceJ1cI9+SafQtmK1V4hgiY88PUwTodc7y50xENQ4or7uEUW0OVwzxjgb0CxIxr0RltDRnEypuhTJ1dyFIaPN2EApD9+1O6RDeUjVNjOMGL+RXxSPC07N1fJodow8w2MXXeq3IocgCI3kiCEPjDGvDNx0B+ToPRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ilcf69h6; arc=fail smtp.client-ip=40.107.200.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqrrEVaOfbKn4qrDLgubQqye40NORctOmKpSCpoDYKfauMuKogyk5r6JGd4M4I5Fokb30yd4s28McolMTGNS61HGxmj1ebIJG96NyY5jeDuebqtmuMEg+atxWxrHEYyjLaIzb7jW8pxnUu5OOlxTfJqlu4W7LkE6upfUceflPzTydydj2sOdVL0G1WLReCjqF/BaqwxALWYMJ3VyuB22SIVWQVGMlOmHtdVV6Zb3KCXoZ8cTodx7sfBLzRJtMuDNhLP0caaa8p7P9QTU4ueorU32lmaZYHtUdvgHjtKWbNBt4gJYdURogARyJSSPOoCi1dh97bdGbHQZLK9ilgVySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If10Ap5RSaV98KIbvm6N5jZScpYO5c/yZYhdt8LHruc=;
 b=wXmLbjEKb8S1iQBMkhBdzTwrdK/O/OT/mGGVqAMXnao9g96KKl+xX1NsJw9mAqz7H/+04qjArE/LoLwhKOwavQLC8Rq3QziWLCuzrBXvQUp46Nq23kiZqlFuu3S4s7rgy3ROWfBY80G1CRmTrQxIqDaKLYCuMf43etua0EIMXJpYKIrQY0ie/mz8kOGG8wkH/spGiIW6djsGJrlS1TI81LmGaCxM8vjyQlctTap3gYkYdFxUJppuO54F/PlxzCaOe9tk+dvgrp56Ug3PM0L6fv9YZeOMNrhVjHoKfskZ4R4m8aprf9N9oIbWEjxnDLPyZIvufUDbuD0Yu20MsLF5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If10Ap5RSaV98KIbvm6N5jZScpYO5c/yZYhdt8LHruc=;
 b=Ilcf69h6yRbuoGO53mhC7FWhCe51B6zzJdVTtpp6m95Xs9736hljccPJSzpVFu02FWrX85gcAaETACmgfFpIzf4Bzfj6qMlq5NUuPF6I98+xm60bL94MOVSKUVTQJztqScbr1vwunKUxZQtKshiK970nPFF5GGMcnKa6GF+fBX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MN2PR13MB4069.namprd13.prod.outlook.com (2603:10b6:208:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 13:03:19 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 13:03:19 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Tue, 20 Jan 2026 08:03:13 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <223B0693-49B1-4370-9F17-A1A71F231EF3@hammerspace.com>
In-Reply-To: <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:510:325::20) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MN2PR13MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8bb945-7c95-48ec-a7e5-08de582448d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ijacTGNw7IEmgTn4gcb2o0OsUeXZ/HWh5LCfOODinvVDs0fwMk02jt5qtmO?=
 =?us-ascii?Q?XS5vfkeAz/aQedJmaCt5/yvfUtvQo7vs1V4O/0bfqxbUp2lMWQc71J0H1647?=
 =?us-ascii?Q?HceWgH9f4NoIbM8MEPlGkWDVS+2h/J2CjsPvUe5BDZB0qa92qahNdibfWBta?=
 =?us-ascii?Q?4HCMCMhPJ1cWrDtcgV+HR13Xk0pUZY12whVLUdxgMCU4YgYz34doF4yxeLCV?=
 =?us-ascii?Q?RSU3TpjBHS2RgTV+tYhr+B+ef3kHib1Po6F3rO06L6QWQ8YR8Q/BRZmgjQmG?=
 =?us-ascii?Q?hNcTuRY3Ptrlo28O7+C6tnqvNMAVif4cMXWaOqerxOBZ4DQ+lIqalUj1OYPO?=
 =?us-ascii?Q?CaLv0OKwcuuW2T8KVy36ExbKn+9JXmiSz/yC6flLGSlLbCvPcgnOKImECy5V?=
 =?us-ascii?Q?FuIv2qXlT7MChTVcIrq71c8lAVBMl5EYBQfp67iHnAbD+Z1zlThPq2LP9HBM?=
 =?us-ascii?Q?XX3CjpWj43CobWpnYNdvuFT/HvS16GUYEDKGEoZ1A7YesGq4IcJVlZEAuBi+?=
 =?us-ascii?Q?1Ael7o/SmTqo3o1umS3ezSMBFvCJN8lBRpTUuil8CB2s5XMgAPdJ3FZigjsW?=
 =?us-ascii?Q?P4goRwwCap7XWFUp/L4SBRscCmFV96GE5FIWJq06NIE5Wnjm0HMy/EQ1glSb?=
 =?us-ascii?Q?Vhu81MGSdLNysscT1Cc97n8IX2Z+uQAaGjM2za03RnWhw1nqfJ5wej7QFtU5?=
 =?us-ascii?Q?UfzrnJDsJzKGUuSSkHa9u9ZIA7HolFFxXxLRjCRChAYu/Gl4WXfHIgEsIswm?=
 =?us-ascii?Q?1TjEO6c5ejNKBbuDYhMPfHMdG1vugULM+LLQJDmzzwRTVOoPYsdvuDtUl1Sf?=
 =?us-ascii?Q?FO+w0O4nNWFQaYTTHX7mY2VCKG2ZUq77YVY9u0ZvXtWvsC1KEga1mAj+zMIQ?=
 =?us-ascii?Q?iJia5Um/h90kTpzPKP6xBQ2sLr+P2EzqN67ij8CVl0PpQkPE0LqqVPKrT84D?=
 =?us-ascii?Q?LvYYMmOY4q4GSbBg4uwrzmvGHJ8qDnvb2nUcC7TpMR0PkEav3fyrskXCpg8k?=
 =?us-ascii?Q?uKSAyxiDNmcZmMY2TQaZZHhnlmGQBifNeGELyX6H+SSSpYklMVVQM+Ij1MW4?=
 =?us-ascii?Q?9noT+vaiKv2J+0cIujBaOnEXN140n/K/Z1pSNeERxagvRDKKGE1VKCXamNtf?=
 =?us-ascii?Q?FhmVNBx0OX5Gkfx6ObzMWTnTqElSngHCqt0272N++DGKtWpUIkbhO/W8VS/F?=
 =?us-ascii?Q?dgndd+xXXvShoiy5KovbDy9I8a8qEjEm/59N+uQPXQhd1addasP8u3QTnB6T?=
 =?us-ascii?Q?+YqYA7XEJgUIh+zLLf35bXPozwNbqAp5llxyoUD+Xl9trMSrbafRxzgRgja8?=
 =?us-ascii?Q?LsADJU2hGNDbTcfwc9H0h2F747emTt7/BZKwsX7Q7Rfrr0yRPyvVzJ2wTaS1?=
 =?us-ascii?Q?B4GUnJSnRR9qkQZ4vaOo2hKPQzCv1AIXVTZORtJN46CB9a0saPxTlxsEJkTe?=
 =?us-ascii?Q?KID4jp+Kbsq5svU8oFy4NCgBf84QIhJGSLgvVAzuKbFXw0yjBcd3gcdH4grX?=
 =?us-ascii?Q?gNaycBac/vLBitLB3d/JFCcmivUXumeeMHxExDhbGfpDyotmkbJLQNceCYN/?=
 =?us-ascii?Q?n7fs/BDQu3kirD5PkU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDUCzaDAcR50SQr5NhJyFMkUxo/S1GYxyUT3dc6km8IxTyA1bsrIIGc52bYu?=
 =?us-ascii?Q?ZxuzOBad+zt/+6q883AnhqgAjjbQ8koOvFBD+3VNir+cl99qCnHi/Bk9+rML?=
 =?us-ascii?Q?o16Kt/sGEUNh/pmalXCV7VnqyQp0aFNKkDSls4A4CzFOxDPRylMudImRdpOJ?=
 =?us-ascii?Q?XsRiJEpgmZr7my+K3C4Ktx2XlkI4uiqZ7Zg5vZ14s5D/wKeM5ZF+mv0z69qK?=
 =?us-ascii?Q?+NVQbLSlEpNSB2xLYYwiS0s8ENnfyALdqOqb89QRNpnzEVD059tKhDmw8ZNE?=
 =?us-ascii?Q?77ytnLp1+FWmm3HbV3aQODTHJ4vTrZ1vjcGExuVJoclZaSQfeSMZmZlhT6D9?=
 =?us-ascii?Q?FdgsQI7ozSmOLKTuaJrmYmSgxEObUjZ+6GUuYxyr0NnPOmtb0a+s/1ickg66?=
 =?us-ascii?Q?qSlPUjzHyJA2eLB6EAbOLKbPvV1Rb6WorO9itEu3oYpdR/O9ZD+ONV/amk8Q?=
 =?us-ascii?Q?MpAg11asK5NBZjkUjmHZsXlDIZmk+tUustWQSUpPbZLlHowdiChUksINYyVZ?=
 =?us-ascii?Q?QRhXM+0ciaaPAVD6TimnHm1ZOAC2yl1KlbHY9eEmfmY0GCv5l5PE1N7tiCN/?=
 =?us-ascii?Q?Pw7v2KaE6hjVhN5Uj349EWk33jISrpSAxcU6gr//QzNKbR1vXbPrMUQJ4slI?=
 =?us-ascii?Q?UWm9Z+v0tQRB1BCrpWso0xueCqdONqMOba2GCsXIfWXVnjwOy1SrQYrSmk7v?=
 =?us-ascii?Q?HIlDznvqCWKfRCcLWxdOcOWDHoBIvs/iZAHRqzUEOpFPBiSAQP5JPpKi1McF?=
 =?us-ascii?Q?Hwl7FFWgLXqsDABkOyzrk4t8JX0Kw4kDTmeJoFR+I3Fc56WlfzLjwr/67bTX?=
 =?us-ascii?Q?bXKz4SxSCwM6J0CqV3HT8DJNtk1G+vg1QG1JrjKKsIsW/Ir/lh4kdd0sLeDd?=
 =?us-ascii?Q?97IixtNbQdsLG/VuGmQlbg08LPZWW7h+xNCHLQRotLLDVj8Zci+YGSWKaGjr?=
 =?us-ascii?Q?WSUK1O/bc/OGLsJ9fNP58pgKP2GfJipWMyyjix7wgq4c+tNghV3q6PvLdqDJ?=
 =?us-ascii?Q?QuNR7FRXJuODcW4Q/doSE3cOes0ElpC/vCpBsD1ZmGuKVWl5yq/ZKIVNNUpD?=
 =?us-ascii?Q?5dZYOpHDrWVsa7+Qer0eEt3zSY435XcCvnY5PFDbts+PotQfGGwRlARNHPTW?=
 =?us-ascii?Q?3cAjYpQboPCs2Q8lrhOoYUx0WKAZlyJALcGlU82yMAaIU6CdXQ5kKUMvNsPn?=
 =?us-ascii?Q?dao9QL6IGYMOpdUX28UJ12YblIlHCYNQaSPqHN5XB80hDPeBBb197ZxHdEV6?=
 =?us-ascii?Q?+HfefV1AgKLUkkYJ7y13QDQES38UkIPyxGMs+2dSGE8a83XU7gSUsUvzM//R?=
 =?us-ascii?Q?h9Ws+fiKk4OujOSRsPBuW6fRO55+Pd71oQ1Et1vq6AgzphHsbYLxunZMYuWF?=
 =?us-ascii?Q?whZUZWkAd7sc7mhDkdOyNBLmkgmf2ujB6mz2p/v4hhC/PnvLO+PN74PX9Hdw?=
 =?us-ascii?Q?obJHilfJSoR5j4BV/j7UScumW8PLkkmv2ZNPSBxlfvcTTzZLd/WbGoHoXQa9?=
 =?us-ascii?Q?qN8UqaEKiJ4W9ne4YNzLfjwv1TprfOvNOEL0hiVYlj7yJCEd7HrI8+jHq7oq?=
 =?us-ascii?Q?qbuyaPYUUXr9teFyggwjAphDR7HNqGDX+b+GGC58jJVTJlqlIWLMpYU1H9AM?=
 =?us-ascii?Q?Nxa0rL9cmpRDLyyV5zHZjaylffN/q/x5M1JUplxaaw/UHSjjSxZ4B7/TlkO+?=
 =?us-ascii?Q?qw+VoMrVTdJpbp257fWMLilkGuKqcpsHDzQz933bVqbLaDZ54o8VVHRMVqJ7?=
 =?us-ascii?Q?eDvluZ4vdmSEVSkJmc1Lcj/2N39fisY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8bb945-7c95-48ec-a7e5-08de582448d8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:03:19.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2V7ohffP+Eh86Cg21U3MwY8jmtKpAkT5ilavv9HXi2Tr1GH3VNe4+0Xsv55cgdgL1m+1ohQlEfkidKQKCEb7NrPCXqFtgfW7nwz+IH6PDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4069
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74633-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 6F25650627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20 Jan 2026, at 5:55, Miklos Szeredi wrote:

> On Fri, 16 Jan 2026 at 15:36, Benjamin Coddington
> <bcodding@hammerspace.com> wrote:
>
>>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>>  fs/nfsd/export.c                      |  5 +-
>
> Would this make sense as a generic utility (i.e. in fs/exportfs/)?
>
> The ultimate use case for me would be unprivileged open_by_handle_at(2).

It might - I admit I don't know if signed filehandles would sufficiently
protect everything that CAP_DAC_READ_SEARCH has.  I've been focused on the
NFS (and pNFS/flexfiles) cases.

Would open_by_handle_at(2) need the ability to set/change the confidential
key used, and how can it be persisted?  Neil has some ideas about using a
per-fs unique value.

Ben

