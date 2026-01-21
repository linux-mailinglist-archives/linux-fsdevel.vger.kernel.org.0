Return-Path: <linux-fsdevel+bounces-74921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCFMA105cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:38:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB875D68B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04C0A80D42C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD133EF0A8;
	Wed, 21 Jan 2026 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Yan7pi53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023128.outbound.protection.outlook.com [40.93.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5481EFF93;
	Wed, 21 Jan 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027066; cv=fail; b=LiSSH+vtWRJbRagwB8eWxGLf+CrkSWLs1EXNFPRR234MoLYoy1uBZt5bz0XP7Se7S6oAa6BU9WCkP4rqVgdfCKB48eC6L9QU1R/dvRcCtJx1vvsWGlROaRzITXVMel1zi7Iba3F8VfOhcaQqUUdxkTOIrBzWIw75+O/88l0offU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027066; c=relaxed/simple;
	bh=gHp4eyi8ZAbDlbhukNagYNpd9zQAx0FPTLBLR0P4t98=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JDumqzhdYpKdGszreKUmjqUfT58wLhGWTuVEVOXtqMlzEZXfvJ+4ECf2NImNVLJJB5j8zpxctgYCGUj056dYZUW+cveYsYfCiVGtTVD+FaoMdXass4fspUVARfVkaEnh+HPrRkQHdWklTwH7Q7XqFfaFOQSuabMl3ZkPJ9azfUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Yan7pi53; arc=fail smtp.client-ip=40.93.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUGfwIHYLQcuGuE8A2BAJgp4jvJYWfm2jNXw4ulk5zLF3BdknTgJMKjlj63eyI90lxR22I8RfNMuvrbnSIdiSPiTRty1mlufwycma/Oea6DHAd1/+XHR9181eSRlfxlHzT92ePkuma+AEt/RLk95Q0mMr7d02lfCZNUjkaldR66rUOCCQJbSCIyyPv/VRMad0AcGixFUgxwZeYaSgtCXtfEperUKVL0v/RUDW4xYub3/DmLBYqdUoOUdopIPXMhI+mRIhYAuYB2jwrJUiP4zyCpgJckm30zNJJz4miirlYzrGadKeA3afBBcj46JNCkgnhggPonOYyRBkL2pXCpgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9I7whk/PYBTOmpL1wfHNR8BNopdMyCsEvJaXVGL4Ug=;
 b=fyUPGxgjDj1xfxPkEEgeumjE+K6BGZUJSZCaZYAdXKBqesyz/S22GnpUSiGYPFHL9ih/1HSvNt44nk34wE0h5FXLGe78PcxqTG/VoM0t1uNmyad/vF8xrPA+ua9f+qva3KGP9TEXsrNQ6HsZRmJVflMXcPMzpGByplvdFYvyD5MOkCQV/SCq5d+msacvpYTaPpkQXdBtkTCVuVJbEze7fkVneIeNQldnH2p8QSMyMhy8CSvpcROA8Mvv8CHEqUQHpybiWMWleQ+iuXtD3cQ1pf8v9M+EIC+BElhOjwM4gUTjE1YV00xdczmDq5GhSYawaQPFMLsRDVGtsjMvcXJkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9I7whk/PYBTOmpL1wfHNR8BNopdMyCsEvJaXVGL4Ug=;
 b=Yan7pi53A7rI2Lig69CSvMBmmoeP07CcRHhYWb7jaf8nd48KHx4om8f8psdjy2KjnPBg37/vmVVAaNBSAUkiqrqfK802ui/t5HH0T/hBLoz9H+pPWbjBQhTSrUyvQ/nrvWpJOjAViG0l5mS/XZIrg/SpxGaCILobNrq9+WuEoBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL0PR13MB4514.namprd13.prod.outlook.com (2603:10b6:208:1c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 20:24:22 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:24:22 +0000
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
Subject: [PATCH v2 0/3] kNFSD Signed Filehandles
Date: Wed, 21 Jan 2026 15:24:15 -0500
Message-ID: <cover.1769026777.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013317.namprd07.prod.outlook.com
 (2603:10b6:518:1::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BL0PR13MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: a0663da1-ab09-4d45-0cb7-08de592b0fe7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yHuJN7uD8/dH5j3BQTfNUMZmtbLgHZ6X7jXe1ZsckOWbRVZ6/PQIKRSQGhb8?=
 =?us-ascii?Q?rT+jEEUDFsPEjn02mHXFniy7yVaGOP1YgPIWvYjQ9Mvux891RnKdFni3jGoW?=
 =?us-ascii?Q?eQ/K0BMhuhnKqHBsaf2CrwbDebQf/8urX3uhTpunYukl5C74BhSc34X5YL5j?=
 =?us-ascii?Q?bN0PaImNra1l5mTeFr5sg3qqx2Rd3Mel/yIm5bBeRBTP9OuQKpNFF6OB2+Er?=
 =?us-ascii?Q?s5QdlKtWfHNw098F/xuCNdrBg+7S/CxIQY3y/4msvgDT6xTPD9uK1zU2CslB?=
 =?us-ascii?Q?2o47G1L7oftj+iX/X1/5gODbV+Qmjr9kRtw8tolUkj10etdDaaQ0MIEOKqH9?=
 =?us-ascii?Q?mEvG2ZfKHd3qOm7KLZQqkaJ+vUoKBUNc2cjZY3J3hsIZpH3lxlsG6289bRO1?=
 =?us-ascii?Q?KxWT/DCfn1f/j0O+Wr6MMgGxfNf93xlFfbsfDxsi9XUPdKdTr7qyZ27xxCZL?=
 =?us-ascii?Q?+yijoJ/9tiNiF3ErFwS08yF6Dbk3qqvRLv57LEVPVgYLKNDITWyCwPEQis/t?=
 =?us-ascii?Q?SVgEFgc67FE7ITBVueCIrCkSjfy/OpMvuZUjxrb3s4ZxdXIf3y/wXxsAh7OF?=
 =?us-ascii?Q?eRsJL0sOb6/ObHp19/ixWOdlQRfZyg1QQkinBDTVsXsF9qQSXCC0Tuc5UxAm?=
 =?us-ascii?Q?RH8URo4vQUl7DqgoxVLki0rWRpn3Bx6j45gZdPp/7NotX2vk3WP4w1OBFdxK?=
 =?us-ascii?Q?rblj+VjfZTjxBfq2Lnrr6zqMC5FjIuhp6uaylFOaaRTsuz4MTsACPEYtI+8n?=
 =?us-ascii?Q?Hvv4LTncjZZ9bzociQlnKtozu6malDrn0EgRbKjsubby93kgFd8r4ab7/jNI?=
 =?us-ascii?Q?ASBosGjhcTWyogMwXgo2Fd35MwSPQoGjUsoA83Uk6EjPJndXU7qJ8WJswbYk?=
 =?us-ascii?Q?5MdEI4gf6YwWRqlY3MPyaD0k0glPtBx7+beImW5V7wXPsFddTCQYL4yxmRhU?=
 =?us-ascii?Q?5qiIy+/H+J5NpwQgEdwo5+cxyQkJ2aCM5AjVXmUt0xZvxiKtL+2bc1mBtWFU?=
 =?us-ascii?Q?0c8bwfaeFY3WcHD6E3XIHi3KWQELrK5REwT4+jSMaIfHyihBWrjbwOb6ETf0?=
 =?us-ascii?Q?YkG3yA6JRYokX2mu1hiAqj1bJum5hXrxVXk8u/O0YeOAB97vM0uOPWn5+jnI?=
 =?us-ascii?Q?XCsGaMlIz0rhSRGKVkfNYHV5PQutPgk3IcZueW2/UkHOM+6ACx8gOe9hKhNg?=
 =?us-ascii?Q?YKtUir0TkLIDjUshNuRde45YNvoZgWSnVZq8MMqprpt0yaQz6XLJyxp6T4jJ?=
 =?us-ascii?Q?CsVtqRWy3phu/rrZ3SA+rPJWvV+SaIGGm5ywRAAcUUp1JWpl6/H6f+PuIzJJ?=
 =?us-ascii?Q?AD2thxmPXf2L+1+FLCrJxoTQcNCJcLm+/lc6Sy21VcZrPZvr7r63x3y6apoO?=
 =?us-ascii?Q?vvTYGE3530QTRE+Y41TCDBaV0qe4xvbnpQ57gkztAwNVDVfSjEuJOUSFBDa5?=
 =?us-ascii?Q?mZ9kUAfq5hnl5mmFNz+xtXUZ9ueSXiap4ir0aWOQYKd7kd98w6lxj7Py0oWY?=
 =?us-ascii?Q?C0X3/TYgIfMK3tX0qjaQX6bUqqzcEF3CceA21+OpaUpTNnnTlbeM1szjJjQl?=
 =?us-ascii?Q?6mjQcrvC3z8+4uWn49c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prURQO08lkH7sQaJJWbvRgT7FPM0/OkBJIIB8r7H5A5T/Ssz95FC7i36gg4W?=
 =?us-ascii?Q?ihOZy0teSbRszBKw+yZYRq3MsxvQQinkPwvM/A27u1esDiFVwsC+aw1meRD7?=
 =?us-ascii?Q?AiZLUa1I8C73VhOEzQURHU54PDPEPO8r0VaXEEcIJaV88wkXeS6nuyzWviT9?=
 =?us-ascii?Q?SQ4+0OlK2MreEAbhbbREN5ADKhiwDvSTvevefHBYhf/AZ4X0pjGGgBUYkM9g?=
 =?us-ascii?Q?+Twe996ab03Ikwea6rzR7k951C4ATEV2M4tvGgrAkx/zvJsHJv4VAtOT1yZl?=
 =?us-ascii?Q?R3nCzr2NxphHGRE+nWqc9ydl+ZpAZaWkO2vWOBsUrcHC/IX+E4P5ebfXe2Xt?=
 =?us-ascii?Q?PVHkkuM+c4wp4p+xp5k9uY5fvSUpInaYHyq/t0wmfUdtPRYtytrIAyAHU+WY?=
 =?us-ascii?Q?TTLhBlUcMbKEwxRBqpkJl9MzlLVMSZd76PGntrdoHCo+s2O1rcW+m52qZAqP?=
 =?us-ascii?Q?rVV75Zvbu3yXy+WkKQPIejosCdFSdKX9jrv+ZmN9nBG//guUm8PQ/PzHWDpN?=
 =?us-ascii?Q?gZKN34mDm3w9w5FnF1tGF4dA4Xvr3zWU4I+mcy3bs9CXM6itKhJIl8VQ986T?=
 =?us-ascii?Q?bsVi7dxNbk1gBYlkYeXsWgOdTn/jWYcGYeyELA0QzxA8IcwnAbxYaU0GLO1J?=
 =?us-ascii?Q?Z6/6hotGD7C8KuoVb13XlDbnpLUR4AD31qGCbkP+2PoVVpltWdWAtQF6Mf55?=
 =?us-ascii?Q?V7uFOTKsB18FGdzNypaYzuYC7Rd60aVR7u49dhd6Obhx9d33u9w4WzG+bmBE?=
 =?us-ascii?Q?x+W8Idtpd8zo3N9PWim/J6SN7Z/jf0ef+HuFo7/DgbEyDghFzxbVPdbZclV0?=
 =?us-ascii?Q?7RPIm458exigjlnza1zQSh6ztAQbB4vWxXK0lxOKQIAkQKajD3B2ZYiqnd08?=
 =?us-ascii?Q?q0O+7K1ZU/s7gfkmdUbaXiCar9UAJ5pqJhkMlQsOf2ICcCVotRj4tondOYjA?=
 =?us-ascii?Q?0tJrEX98StZKwaiVjCQJZFYX936ehy/vLBGOOY3s6xI2Eh43ELyZrsep0Mh+?=
 =?us-ascii?Q?t/yc6aUFNJ3WuUX5uWX1EWRDGZunZWtGG8PnNLzfDA04NWaRuc2TpPeT7T1o?=
 =?us-ascii?Q?Dq9QaVyNQrRLRRkZqj51SCSwgMFhqpK8QMpyYL2DUVPGc61wdfMg18v71pX3?=
 =?us-ascii?Q?Mx8cYUlJi7Rq1wJiiHrfvDa7+jFYlawqgwU+P3dw/9sLWzrJplNE/VOWiko1?=
 =?us-ascii?Q?E0d6foAtCqMdazoV2GhW7BTfCCuitcR84cGvpZxGc45wJJWhRd98olDdwqvv?=
 =?us-ascii?Q?37RbmcB/IFOtCY8UdNeUE5lzNMXOd3bWcz3nG0N1I2UlpA9IPon9tja6Jhae?=
 =?us-ascii?Q?7R6MALWme4nJ2cfYFDVBdTS0iFOsItsuCgOOLX0bfpNKra3dRFZQyfD5MAyw?=
 =?us-ascii?Q?ZDzT6q4UGCNbsqAIy3Y99v6G0KQO52Er0oVTHHiQH6Yfk22KDc5ZytsWuBJL?=
 =?us-ascii?Q?+pgx6h9qgoEyi1bMNip48Jb1us/a9lHfbIXSNLe+zq/Hu86TpLe1JCBudMqJ?=
 =?us-ascii?Q?brDv5Bkqt97RWnEMCna3jkwEmqrXErZAfeiMfa9arRMgfmltpOqyYXCoQa2E?=
 =?us-ascii?Q?/tt6mUf0d5vWD3qQBSRSrAsxZt/MGqyK9GpN4jp57Atn4ehSYOd+VefpBs+T?=
 =?us-ascii?Q?WdKyqhGHUdQle3BEY8J94DWm3oih1Btcgbl9SXdrgMqd+jw/r7DlxhZkVSVB?=
 =?us-ascii?Q?guBFbx3ICOxDKxHzSj4rT6b2RRV9LYmjSwJZFc5Nx/nvNmEXVxOztDPjBXQc?=
 =?us-ascii?Q?4iX/VM7Cs5EmrRLzI/QEOCc9jNsz2Nk=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0663da1-ab09-4d45-0cb7-08de592b0fe7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:24:22.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up2+aUQ/BaonmPmYHkRcy+cMZPGStvyEBsVZmix2UuEaw3fUBVrjJV1F0yI95mpAbSnh701fet5yIdjuBAG8wfWFZkrAB6+V/Oh/q8CyMJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4514
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74921-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 9EB875D68B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/netlink/specs/nfsd.yaml |  6 ++
 fs/nfsd/export.c                      |  5 +-
 fs/nfsd/netlink.c                     |  5 +-
 fs/nfsd/netns.h                       |  2 +
 fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
 fs/nfsd/nfsfh.c                       | 73 ++++++++++++++++++++-
 fs/nfsd/nfsfh.h                       |  3 +
 fs/nfsd/trace.h                       | 25 +++++++
 include/uapi/linux/nfsd/export.h      |  4 +-
 include/uapi/linux/nfsd_netlink.h     |  1 +
 10 files changed, 209 insertions(+), 9 deletions(-)


base-commit: d22020d8bae386de422692a0957e991843927643 (cel/nfsd-testing)
-- 
2.50.1


