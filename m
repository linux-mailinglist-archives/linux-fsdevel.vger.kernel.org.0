Return-Path: <linux-fsdevel+bounces-76992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCfkH1tkjWn01wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2F12A673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 06:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD201313BA39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F7283159;
	Thu, 12 Feb 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eACOdb1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021142.outbound.protection.outlook.com [52.101.62.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C23281370;
	Thu, 12 Feb 2026 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770873924; cv=fail; b=tN+WmhM28l38WlFjYrWg5r0I5L3oWxvC4BGQWYnMSp9c2ECISjgm0PyDIUU4GKop9yqX785eJ58kBFAkLyH8NlHKuUv2KEGgWDxRY13YR6eKd1BWlU2xrahMoyWexw5CZVfFwxXiFTDpVqjADqUQf3gCQQxpdsYOMdUDC472MZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770873924; c=relaxed/simple;
	bh=6OTdMCyGnlaRinr8Uo4fz6MoQ47xpMp8UPAgTLi+qi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIpgNwtbh+tGwkOHWy+7N5fojCyJjEP40EqzfaI61OS+JfL1uOJQrXOWfkxxqcVZVu2bbCqw4ieKTQgRXwdkxGIq2ART7ucbEsNl4/SqPJ0BeygVBfTZ96tNgBL9Rx+4M3PRMlcTna5Ui77tnco7zJY4UerEgQvaejvRwTYxQZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eACOdb1B; arc=fail smtp.client-ip=52.101.62.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3JBaXdZ1tqCkHOfYtLyFEY7dFQj3j8b/KkltSsQkxh1/zzewsnWI8hRvjj1juA4LQfXlUO93GKkIdjD58Pl/Ue3o0nRyZBemyL+s7VOqBJwkrIMBILgXmwoYJnkCc7REIEyNnxwD7YF/dN+nC7ZsAsKKuOfgjTbvzwVI4i2TglSPdtpvtb3VfDBKJJ/XIL1UZ4SWWfJ7zovrny32Vy2GGIj7CThn3ePTiGV6uvLRJ/M/ukti9tcVSKJMVz9Xu8viBwFV85nF+ZrfReVNKB6g8XCm5vpkkiCyIV7TWUgESdb85ZaDnMi0xiNPsSR1wURxR06/jG6nMhPF8UcRWAzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq9csyw0nqGlAp9ayeNqE0yXrBlVfEpLjl0FqqKMSNM=;
 b=douFmiKfs9QxYufeHBoOHDeKUI2DtUPyKEww8VnyZP2rlQWC8A8zQh/NZ87WUYj1ycq9E8u+Qtk+y2uvagWpk1QoFt4gXiFzx7nnVB5ZFjDjhpxJtAu0nZZ9gAG0WKKCs3y+G1/jVKsOsA7HIGU+SrrD9CBeJSHUGYhxFLmJ3IebscpKqkEHAXR63vW958ucfInQLc+B9WKPsd4NK25ZyinfMYM/mhmAvHhVMnB1fW3TRoVoMPIiHdSl7qPQbk5Y9bOmtV8/5+nUFXtghP8ivn7/wC7sHf31xMncibmzIwBCBRi3OTZZtgQUV3WsGKGDxATdld5wgRFi6Lunu9KruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq9csyw0nqGlAp9ayeNqE0yXrBlVfEpLjl0FqqKMSNM=;
 b=eACOdb1BGVXUF6SktbUHJ3Gm+cukphqEzvSq8kE+Vi/UEj4Imh/1LfTv9V1jJo+cZsSWaIGEKP3/fmvTUEoBuqj/XEvLNx6kbntvANPIWAF8tJqOGdcBVCTuofPYE0R05+xh4tB3CydBWsOAJP/Mm+Ryzhou8uzoeFJz3ZPsT3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BN0PR13MB4695.namprd13.prod.outlook.com (2603:10b6:408:125::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 05:25:20 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:25:20 +0000
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
Subject: [PATCH v6 1/3] NFSD: Add a key for signing filehandles
Date: Thu, 12 Feb 2026 00:25:14 -0500
Message-ID: <add9277af86714de8ba1b848cdc3fdf61e114b5d.1770873427.git.bcodding@hammerspace.com>
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
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BN0PR13MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: ac129a05-47fd-4681-d7e1-08de69f71d01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JApqATZexJlKSZ+SgadTwxwQJ5Z5FcytLY5tpVTIxqNYwguO25y5gYnXraV2?=
 =?us-ascii?Q?u210Qg+ox9vY/U5doLT07i/55TepkO6h+1fWPkhzLVtoXqi1RWUBdXnF9Whb?=
 =?us-ascii?Q?QuxS3UkEu03vgtXQVScTRwA+KiiFLrRMHkyJRU2t68EsvC2hYRlRkNuWs/m3?=
 =?us-ascii?Q?ijZCtRtgpz6TSb/t5974EnPipAq7DffhHV/Ko6NnddgjdpY7kF6RxcWiLAG5?=
 =?us-ascii?Q?h/vy8yLGALJi7nd/yAEd6cA4S0Trkpc8wA9Q2fFNPP4MlElmfq3kUJt4zTol?=
 =?us-ascii?Q?G+YecwOb6+LP2jd4WowLogvjBd4ClAbyaYTKfd9HFzrgHD5gG1kLeDDHhihS?=
 =?us-ascii?Q?OYJ7H0xuG/VF6YlvrBw3CztCOFmDONVpo7Bf6Fus41BXxcMmfxXkImRW2XMC?=
 =?us-ascii?Q?ljcMnQua4EOp3tzl+2IEyjCU6TMmAbP+UED7y8WbdKCS5jlEGKYP+FOfPier?=
 =?us-ascii?Q?STEHFJ/0JzI++ALHSa4NuR/Oun7wjN0/hM3aQZI408PUfZUdSpyNuXkpgQ/o?=
 =?us-ascii?Q?VnsYMIf8IuPfI24efH7staIOPhwJdlHz7oWmgoow60K6YhEveZqwSswEXBle?=
 =?us-ascii?Q?4S83fktwUSprPqg+LeRGu0PV9aK8kWlhpLgz0wMcFqP6bcz4g6d/11J6+UJx?=
 =?us-ascii?Q?WDbO0MecJdC8ud0ngoCzqLscx2QkaMI6J5IArowP7O7lqQqslAvchR2poctX?=
 =?us-ascii?Q?pPe7vD574mx27BOs+gKYm7lOLDHAWLwChIb90v+0YWhqu1QY+En8aw5fYTd4?=
 =?us-ascii?Q?yhCGXXj9fk0GKPyDd6uuSDn110k6o+9qB1IYqFz691kqjwK+tB09P7F0CgPB?=
 =?us-ascii?Q?mvNRwbjb8C9k4NAnNDOlX3zh/we8TIpk/zBOinEULSsY746ia4iz8NM+Al3E?=
 =?us-ascii?Q?WU2Y8/r0jv4OyIpBPB8FFj8hcP7rCQhbVMqG3miEA7tpsLt3Uy/gIolVexiX?=
 =?us-ascii?Q?V2MuuF7yWpsVzEnoaDYXwRpQdKqbcOuu9gE0oZaMlL+wjncsfjXrmgLfxlNa?=
 =?us-ascii?Q?EN8fGQInd7EMPEiwdOObtVxx8+4Q6rYIwGgJOzsuWJLYFtkTbGHJpiO9vCO8?=
 =?us-ascii?Q?Qw5JmwlC5bzYeY2hCempSKicsKJicg+0JznsEVtEP4oZ5s7nFCTlz0eWKvIj?=
 =?us-ascii?Q?jU0e1cUmyppaFTpuU7Xb9FRauTxMXiKxH96+OP2rmbxP9//dqZd5+mbUH67y?=
 =?us-ascii?Q?dSfdZVO4TwA8uW+NE9QDAmcHwiO8kRS4iYFjnCZ72CZ2dx8GksA1tjbwjWUx?=
 =?us-ascii?Q?O4PXxGrBRL+RipY2KbJjdpD8u0zr5gDGi6KhJrNfFtuL+ZOJI7vjN13m9GTU?=
 =?us-ascii?Q?gRcfH/pfCvs/ycme//2U6fS+ptI17JYxOn7OqUergTZmZ+aBNBE6YNVHXnou?=
 =?us-ascii?Q?0MMtpNHo6rZmDE8kQINnZuh2VLTabqmh4h/yBNOwHKqI09aWxCbjbmxdmzdG?=
 =?us-ascii?Q?94xyzULNQPyHEq0dV31TzJ62bhhjjSeKI9z00ehltl+AO2BOtS7sOdHJNymK?=
 =?us-ascii?Q?F8P4QsuYWU1SN0Yeq4jTrOOyL6Iam7AsdCsCgxxfhObKu+9U4ma3QaIKyUIe?=
 =?us-ascii?Q?EgFSgjRBZhh9+ItHT0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQyLFHTYQvBuPeV0iWY4Hq/Nz8auwMm6paSN7cfyd3PEEPtQtA7vC+mRgsBl?=
 =?us-ascii?Q?xCpV1aRnuWEoIejOHcaIVjJf77x6MatAYL/mNq3lRvvb3Sm44L8ZK14slk3D?=
 =?us-ascii?Q?SLYMlP6lwnm8ppaRzgB3FXz2UYCJqHd7/iKBH67fy6R+w1yzDP3wT6lkLBLw?=
 =?us-ascii?Q?XOfLzMMf8KbUYJRdpytQsT9dN2etlj8OYI0+VV7pVn8VChydFGJP47+ZsN1Y?=
 =?us-ascii?Q?kCVqi2TbuQo/wvcPJpCYa/F9s0XhGGcpwuO+mxEN+l7/R78pWBt3nR4RY3Hd?=
 =?us-ascii?Q?vWYovPVrRUaMlsmnZwBgdAK0p2S6S2Q4CVfe1dJuTterHKLefjmBGQPl63nv?=
 =?us-ascii?Q?dzKgWbGLCbb51E4FFkCAlQGi+ICFYho+je8qD5FhZNPZWynnvDqcupGOYG/g?=
 =?us-ascii?Q?YQHh1/8AvKbp22TU7RJQFe6TTFtdHxYUCVowf6mA+RPGRDEQelQlE++s/TE5?=
 =?us-ascii?Q?l1msROPlk7+xtrG9PyhSoLCvicvjyyWHl96Buv/bg4/9RhYYmVKMac3No6jn?=
 =?us-ascii?Q?VSG/JWVJeVGlzPfT9Hm2Jfa3G3cmyb2+nNJZ+nEoUTBtH2pO8lpW0xjhb8V/?=
 =?us-ascii?Q?ceAtHVpxQsDEWNBT777P5xGWxrpoEHgbw6Zd3YmlzF2RqiKp1Y8/dO2NWpp+?=
 =?us-ascii?Q?z60F6uenlxKCpMdH2AsPwhCKA4/SQ+mlzUfQbMypGuGNngZCV4SK7ZG5f2Fm?=
 =?us-ascii?Q?OJmVPwn6j5f2N+QCGYjH/rtJSV/i8fkpKvcZ+7Rk8eLH8AB9Mq04M9SBG1Iv?=
 =?us-ascii?Q?Lm/CISahNS2FhkHU53mP8rWJp8ToGYHT/9SlpWt/9Uf7zWpV0b+2Bz2bJ/J+?=
 =?us-ascii?Q?c1TW7qoUS7IpC18FX9kLG0bQA22kCiJ0QPt99WYxHu61Q0gfi1WsHOG5zqPS?=
 =?us-ascii?Q?M2CEg23blTjUFMnZxSMWjqC10liS+wIfX4WU9QDwWL8X9ksoyBA1FMT0pNL8?=
 =?us-ascii?Q?vPfqAKbWXmeVoUen6m4c1Bo1HNh8vSs//pgeGvV6yHH5aT6GmFYquoNFxkFQ?=
 =?us-ascii?Q?QTKRiq9aiEVmWGmTRaQZp6RXhBs9BzECQQ24O70A0R+xpKpTUZjU3Rrh5h+2?=
 =?us-ascii?Q?u484rIpkBQ7siWzu7IkKllI3W1wNSA8HPwuDnjfqt9e2n0iv8iKMmqKC3rFn?=
 =?us-ascii?Q?FTAN4qP0OtbtrhOF3Fy1FJTbtrdpcWJVTzsGDX3jHFRvEBxQbb8OZgvjcj9w?=
 =?us-ascii?Q?rPSIdiF/Qn0zWQxMBEMckpGeBt2UM0xaZRqqGmyO03iigmCcs0ZHoqxV/9wb?=
 =?us-ascii?Q?p4ymMLl9O7+d3M/YpCfts5bBEvTbjqtW6VggSiNH8t81ri/wjubyVbzLlNh5?=
 =?us-ascii?Q?LuWL2AVpTuqYxx9xfITgeO9rThqGeJaXs8L5adz435aDp9oJgiGYrYPKNuPN?=
 =?us-ascii?Q?z66upu6XRkTMIHdclrr+nzdD4vDo+CiDFIg0JzC2GH7wNx1+p4KWGyCHpd7G?=
 =?us-ascii?Q?Ee5T/36Ks2rpJrrGWW+cwNaidvTPxSsuTEXtZIf6s1C4IapKbP/zX6aXWQTu?=
 =?us-ascii?Q?/ebtIljz04bZ99vqqjJw92I3LzsmC8X/hGJb8ANRW6I2PoMwrv4P/6I2xKrX?=
 =?us-ascii?Q?1muKGFk/T7osZcugjNlRkC0npw7i6Yh61wkjruu/0gf/Xc12nHrJ4yPrS2h7?=
 =?us-ascii?Q?yU80pGxQFxqYFcz1iPJiT9OxeYjOgTRokSyzXeN3b/8+VG5SMIAKtXFBjhsl?=
 =?us-ascii?Q?jpZF7TRKo29FjjYoPn7bdbscHAcq0Bla3/O1GFZ3Ky2jK3luua+GwZWIlEev?=
 =?us-ascii?Q?MHMnNhRZqDEqzo2NUEdUjBkSePfs+EQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac129a05-47fd-4681-d7e1-08de69f71d01
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:25:19.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJbroZ2dFb8m1vUYafbvbMuemeWvqJd6mdTJhZJvLyz9nAl8Ihd2VPn2SMUhDMZnDGpwSQHB3Z0bUjtlgIRMzubofSbCScjtUAOZNF2MG+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76992-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00C2F12A673
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  6 ++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 41 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 22 ++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..8ab43c8253b2 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,11 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
+        checks:
+            exact-len: 16
   -
     name: version
     attributes:
@@ -163,6 +168,7 @@ operations:
             - leasetime
             - scope
             - min-threads
+            - fh-key
     -
       name: threads-get
       doc: get the maximum number of running threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..4e08c1a6b394 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
+		.maxattr	= NFSD_A_SERVER_MAX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..0071cc25fbc2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -224,6 +224,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a58eb1adac0f..bdf7311041d6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,35 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ * Callers must ensure the server is shut down (sv_nrthreads == 0),
+ * userspace documentation asserts the key may only be set when the server
+ * is not running.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+
+	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
+	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1641,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1671,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_SCOPE];
 		if (attr)
 			scope = nla_data(attr);
+
+		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+		if (attr) {
+			ret = nfsd_nl_fh_key_set(attr, nn);
+			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+			if (ret)
+				goto out_unlock;
+		}
 	}
 
 	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
@@ -2240,6 +2278,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..185a998996a0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,28 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__field(u32, key_hash)
+		__field(int, result)
+	),
+	TP_fast_assign(
+		if (key)
+			__entry->key_hash = ~crc32_le(0xFFFFFFFF, key, 16);
+		else
+			__entry->key_hash = 0;
+		__entry->result = result;
+	),
+	TP_printk("key=0x%08x result=%d",
+		__entry->key_hash, __entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
-- 
2.50.1


