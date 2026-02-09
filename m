Return-Path: <linux-fsdevel+bounces-76726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDfCDQcjimnLHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19A113666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39DB2300DEF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F338A9A6;
	Mon,  9 Feb 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="B/tiFHnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020120.outbound.protection.outlook.com [52.101.85.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C938885B;
	Mon,  9 Feb 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660599; cv=fail; b=egrZiLxzFNsrkvLXFYRzQevOdxOSV0seyorLteWS0uczXYY4f7jCHE/WGf2483nxNsQu6J5qA21Pflx4pRnYHQMv30ySDcztLoLfUl6QrXmVOBs3CH/w8ruu4If0lDhePgNnDNmv74mg3kqqr0Ngz8Y5Fq5RyEZmW9p0RfXQ1cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660599; c=relaxed/simple;
	bh=vxJATQ8oWG62xGWeam8m1hAJuV7TY0k0ea8DWOvluHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxxLroM8D0MR+YiZFjlKmBw8SEMFwAhL7IVKGdOPdbo8HW5dtZ2lXEK0pD2BEFT9VW1+uJoQ0FG/bsVA5bVhFJXPVBi2UKXKkf6cLGsRiM0y1SOxktZplc3xk+NTMerL8Oj40a5tvf2oJRPdAmcgKcrdz1YJ9tT4tiTCKHW3R6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=B/tiFHnN; arc=fail smtp.client-ip=52.101.85.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grquwVOrUQ/vi4mx/6JRl20xWZuqlq9ttLMuiU8oYJ9EwJ196KdJ8CQ5vPAT29W98TAVyTIVsEGxLNhRGjgFwiYFL369BHRSc74yK40xGLd8hMzW6hJ/JIdUYOordTDmtnxK2mhbA+v5VjEkX3q8il6h2Z/yuhLZdq34FWR0Ml5fDzGakMOmtxZ+/PO25mWOmymjZA+AMsPQAjnjK+leicS/aQ224QhmI9ZhrId3SOCiJPVSe9Hwlp1WDNhXsjPvV6vDS04+noT9hnCu1zBSlVqdHiv2VsjjcSig9qVaUwrn9q+2Nm+j8mjbUwmSXb1Xi5BrrZulklLPega30TYj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/maTOTbHbY0MsMw1rCDa0AX4tksDOU4zJktqUdSMVk=;
 b=BhItCN7Ghu0RX7lRleNArU7L13BIXTfIzPhPXUc3X7Ho9C/Cec2749fOuBMiH00UzgwIcKPoPt8rg1x7+7C/g7cCv2aobM3W8jXSFFpIskEGyImepbjoumxlpo+X1mhyaE68Mdiz2ssDKC4ISLd0M8gas/Ime8pt2hEK5XcPFTsK4g0RqFgEtXLRHQLKhJrKig8S/O5kBdrmf7NX0KfZ5NP+wObUT9Dno2oVF28QaZBO8JSixhmnJj9r2RwJDwkVq66829mrYFPGwdFfksvrkr9GTIgavdhljWsiUhCK+7FhhQfImvT5y4Ir9NiS3RwJSLGm17smZhIPBE9GxfcC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/maTOTbHbY0MsMw1rCDa0AX4tksDOU4zJktqUdSMVk=;
 b=B/tiFHnNLQk9/w0fdHnCv9+fg0wBv8lD+fID4tfpa3pnlU8jIn5j4YhDFpnpdBX61B/dNx3VrLLxBlZyh7EnRd4SDYY1Pxf91//aB2li0HoETTZVgSAkAPdOchnqo1eod+qEpXRWRcbmHKyhVXNG6rdRhKV5qTMJeh14CZiUdWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB5170.namprd13.prod.outlook.com (2603:10b6:610:eb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Mon, 9 Feb 2026 18:09:54 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:09:54 +0000
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
Subject: [PATCH v5 2/3] NFSD/export: Add sign_fh export option
Date: Mon,  9 Feb 2026 13:09:48 -0500
Message-ID: <8000ea165e4311f0d0e9f0dd9fa7194eedc4bb71.1770660136.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770660136.git.bcodding@hammerspace.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: b1985f8d-8da1-43db-aaff-08de68066d42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqXvwG3B+itSifCruF3b9F0xmFggDVYrpuC9/Hgdh4XhRLoELdQebLGQQE5f?=
 =?us-ascii?Q?QwlP/f89X1hhEbl/4Fv65eCHsfV24PRFkGQASPX/6vttBNajfi8dfgljtKe4?=
 =?us-ascii?Q?Qg7JsTbvbg+WzXBV4nsg8Dv4xTv1m6BZYt+zLxl6M6jnS1evLeBJGLAqoBhO?=
 =?us-ascii?Q?KpvfKD4C9FQ7hJyZ2J2yQq5ZPK1XtehMOLaIyCsJ6/LoZNufMaUFLzH2Db0s?=
 =?us-ascii?Q?fKdRim1gPDuJlK1lPbjxBseYy/SAgvzi1OWWj2hpnxa6uNpLRXN0v/wGZvIn?=
 =?us-ascii?Q?iUS6F7AJJtcvgkYpBzo87WdY1Lu5QhzDbO0voY8SydmKJm6CwHgsqsJQfz4a?=
 =?us-ascii?Q?/siuOAGDTMIauR+S/dlJIATasod5b9vpetURkwdq8ajNYhPdDdse+59xs+kq?=
 =?us-ascii?Q?PsVeljWBhFIJanbJYhmVUfmzyLaNNusdrWzvT1hxJTmWdHmBNiyzIq9bjml7?=
 =?us-ascii?Q?0effBVUB2NZ1sU56gXd2WuVz81TJ52hiNdGBjEZSwzpqf87yCztqjqgCMM/E?=
 =?us-ascii?Q?G20F7lI9PQMtpJOrKS1RBwBe1hAN38dumawndiZGxbgkylKDq/8eXvalWHrE?=
 =?us-ascii?Q?c+q0L9kMbDH5AGUSa5IrkCXyvuO7Oz6ZV0aEQWqUskv4uOQr1VG7iF0/7KG2?=
 =?us-ascii?Q?B/oEgsPB8nrjgacsh3WTZEmRwTUURmbKZ2jjNYEG/7ablGnYuGn3n0Cb+qGa?=
 =?us-ascii?Q?PoRh05WJnR0i04KtgrG0s/X2tSM6ikC1TiMZi9b62iS48AU06XfOyosB2BOl?=
 =?us-ascii?Q?Pl1XmKVtopUC+yqSF5XmKI8nGrktLDnyqdAmxPHReXQOWslqZUhU02jbCTQn?=
 =?us-ascii?Q?VOoPbySeniqzlRsvolTg517WKZ9Fp3RqBceRhuN8xwH8x4K34Zq9boGswrQ/?=
 =?us-ascii?Q?akOtOsN7YnDTxElzzcjzcSQQGZdqfpZDBPEEoWYHusrkfocznPtfAfD/daGH?=
 =?us-ascii?Q?j81okCl0R7fOntDaXhQvUeXj33wY6CCdGLKajva0vOOABQkfUQLJWEPuZPkl?=
 =?us-ascii?Q?+YiNEMmEQKV4s4k1rE+Wi5zH6ApdS/BW/mtsGguYNrdFYM4GNNKtUCrdyj8B?=
 =?us-ascii?Q?kvt3ciEejdswnYtNEv47cHMfW69YwAyzNYYyd/OmmAdLI319O5AoDIE/ZTUb?=
 =?us-ascii?Q?F0PT+uxWzOElHRuU1jpYiUB4gT5WPLWJuZOOXT6cQOVLHSdiTCOIH4aquMsJ?=
 =?us-ascii?Q?3TIFO2ehpHmlRbbI6cru0Ka4xRbFpR8NLACepCLPN47tepjdWslE8Bl3kkyp?=
 =?us-ascii?Q?FhySK52HqrTMX4L372dcbZyi8CGmCq8NIQeT6yWuJPpN8dIA7Qt5z5tuRxqI?=
 =?us-ascii?Q?d07bESmvg7WU309YcyBTi6RAWkOF7arlpyrnzw+t9BaIeaNPYMuW48cei1W+?=
 =?us-ascii?Q?yeoNctqUuYgflkaSLjNgsnsKQAUOlmHh+jc/VzKkRc9BEh91IF4GgBseofsb?=
 =?us-ascii?Q?Fmld4GDtp6pgOVe1QilRAoHh62Wf2GVnbcU04urRE3VFMQZr3+2NgDTcMXfs?=
 =?us-ascii?Q?OcxLGBoiH4riB9LvQgHylDosa4LDm75+H5CSm+7SlU/RbKfPciz7aeXEwPpm?=
 =?us-ascii?Q?YJuL/Ru4g3ZXiGlJCkw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9bTZnCbAdMCyyX9xHwmGMIzsriRLi8TmGHoDF1piaiguYvjfqJV4JpVRC48?=
 =?us-ascii?Q?8ugqExfql64bOd3dfU3vNxJo418FmcBbIZvU2S0eadCxoByEQ32EamIC+QeB?=
 =?us-ascii?Q?/OlrJta6ZM17djFTG/EYUZd4gr9dhgSAim+mVkl456TKY83qLP7R+zcGDe7g?=
 =?us-ascii?Q?PbjyYlaJZME6GlBFK8aXOYzwqJGYsS+S5ATAdYVdeTog7W7rcrwAKvYWTTj0?=
 =?us-ascii?Q?+9J408SLBgU/J/lQrwJA/Fk0ZfUvHZ/vf9V7MBvS39qriiToCADGdyGL4G0X?=
 =?us-ascii?Q?oi0sswVYOBIRxuHQqry8Uf0Gdpe9c1ZyKxEt4RX2MGOqRSagEgfDnLQ+hhmm?=
 =?us-ascii?Q?aXdAzc1d1i8AfhmYfqjNex4T8UL7NfI7ShG0DIch9HUVvXH85MfICMdYIft6?=
 =?us-ascii?Q?DY375IYpUvlsibMIY7iXC5dIv3i9Zt6GK4QYayTXHD9agHKdOwoLm77fH10l?=
 =?us-ascii?Q?IkHzcZMM4qiGd1mh7M9phQV9AWvOC/BJ6ngIh9xUfxCtjGT50s9xPe0PpUJB?=
 =?us-ascii?Q?r01mzct8l7i5fVuwNu3xlfesiUgv8ruagy3sr2rU+2ebnduOV0HYyArANefO?=
 =?us-ascii?Q?+5xz4mZPD093m1S40ySU1Q8RXzPHAws6LuahANsTwfQEUF3l+/e+jHn8ev2d?=
 =?us-ascii?Q?EoEFZOEj5udqpTOX4Iz60ocgiXTJu65iLvDW3hPSVwSi6krGrEo9z/kiLAYZ?=
 =?us-ascii?Q?hhFYEg2Z1nPyPjSoYdznhwA0kZ1hgnyTkMVaruH/8drKnctLaF7cA3LEwWS1?=
 =?us-ascii?Q?6lckqe3nbQff6O0qnhhtH907OzXnYZ0tWTdn6cANjJiOT8bdNO99fUX0Jj41?=
 =?us-ascii?Q?uiepjdJ+bLhGWwcq/YXzRvOHGQjc+4Otu4H23NZlenL7ifFBp2yMlLKOgUQE?=
 =?us-ascii?Q?HaJWIyecwzQd+qCtXk6VAwb/tkb33rnqsGNhrk5n1ARfinAR6ouX3cEkNvFN?=
 =?us-ascii?Q?+aP4PHTT8d/lG5ApRI8VFA7VP/gkZ17eHQ+PWnpFGgyOcaBCIu2xETQAUTb7?=
 =?us-ascii?Q?Jb/vvf5AtT1i0d6IRQQi0YgLt9J90UyeIq3d4uyULL+5OpRHJfYbtm7hn3ha?=
 =?us-ascii?Q?cmkrk2FqiazOpiK92KJeKFYKFzyZV9uaCqLhYT+gjrzrXCcgJdTKsBlkCAWf?=
 =?us-ascii?Q?8PnZjyzY/2v9UZavBKzWHSt8gzrbPDzyY2k2IrhUpRGdLKlrEDztxMfFWORl?=
 =?us-ascii?Q?Ww1xwvUKUcxXCMpyEjQF9SCnJcTd35IYOYFr79VtOyhXoRdELqPxxo3aDVWN?=
 =?us-ascii?Q?qecctPVhJoSeUyqM3b8ASGAaCSn9lZ7Ut8V215DsBB0F1eXCHIKYEMHCjsqI?=
 =?us-ascii?Q?7KAVVOyGkrSXx6+b+TYork8/9TrtY2UCTULpDgvystlmfODx7qoU34JxGgVi?=
 =?us-ascii?Q?S4pFcc65Qtvf3VYq8Ww40cAFxty134Qqz2kFzqbjfpXnzYFnxpliW9oTu3/u?=
 =?us-ascii?Q?FLtHdTCZci2PNTCn9kHu3z41WegMv/plq/2JefzSey5Gpc2PkIGxxT4TEa60?=
 =?us-ascii?Q?tvp1cS8vcT948F/qL9j9EKYKkkpVZG7RLwEPihWucXxlUXhW0o/eOZFHuwBG?=
 =?us-ascii?Q?w3CzYV1iLYBIj0mtErSU7JTtzMYQEcpz0cyiNTVbh+atu6XB0R3Ib6vRDy1N?=
 =?us-ascii?Q?drkSxLeHjAsI8ZY0sp2K9OHSpVzQpU18oXRRtMRyqFAg5YKtSAGLhb+eAyle?=
 =?us-ascii?Q?cSw7AsEnAO9LVXUg6lHzZDENnLe/sCDfFr/nITZo+O9nU2BIxrGutt9fXQNm?=
 =?us-ascii?Q?6RT6ivVWRg9583BBOrCB+nRwP1Sh3ic=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1985f8d-8da1-43db-aaff-08de68066d42
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:09:54.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fjbsYtAzl5NIJXa945vzYw5M8Jedl6exzPuJNup6EUgfisDlJJrIDuPvjTP7LI1wcwRhNPHqocA619OLBUdQkQZiIHtkmXxFF2POzKgau4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76726-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD19A113666
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


