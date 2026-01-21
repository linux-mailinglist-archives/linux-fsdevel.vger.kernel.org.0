Return-Path: <linux-fsdevel+bounces-74924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE0dLcs9cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:57:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B75DB07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923A1B2E8B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5AF40B6F2;
	Wed, 21 Jan 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="fgq4wfEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023128.outbound.protection.outlook.com [40.93.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B833EFD11;
	Wed, 21 Jan 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027076; cv=fail; b=bFwUkLJrN1x3V1NJTS9E1TZ7USwQ5UGoLjoCT92bmQXnGB3wH9o3e3siOUfgUFUaAbzia7yhIW+ePkezkG7uLYw6maYNQthX7mJAIRU63tkxGOIzmC9IQRdwVhnDDHvZ2DBiVC9kDqPQKudZldk6MREM6B/2LF4+1qF/dFxZuis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027076; c=relaxed/simple;
	bh=j4UpRJtAFUQg+lOvZv8BEYKIniML/tB5uRYpqh+Odxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhinpJjST0Mi+kdkVIr3yTn0TB1P+d01q+kLGNXRGL8iuUZegozOmMQSKGOAFQgOdcqcmQgsiRurtg1q8D21lGtMT3yXSVltJqQIwuz37cO/Q8olARiuWi1Uhl/p7e6gxczxhPsmVeobNLM+Lrd817IDLoo8jj3cYjqRPGFPUtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=fgq4wfEp; arc=fail smtp.client-ip=40.93.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLx4r2arSQySlDfmX/eYQYa8cjlVUAvoBxLbtfhk3Qj/bjmYKLKvC+kfsKlQHLNLcK8Z/w0jzsX+T9+QyEi5AKVkV1x/m0+6unN02i6Fo9Q8mlI843zV+8/2fcbdsjo+FIqnAyWDkyROTGdv8zCv69A9kgmRlvMTqzNX1vCQRCYGKOkrez3jKUI8ItAMj1NqninYEXkyCtLmuFYE5oPm7IhGRKODJnEyALQ4CFuTjzUsl9h4DiEseZ64LdFlXzSOUBeNyyyaY6Tg1W8BUwYAaED67oSqqxYlZDAcnhcQrIo13XZzRJmRR2y+gYZ6bfJjeAyi+fO3JWu5QBpDcb7MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu4jEtwEMerHa6kGvpApXDza8GQBVq15ZpoYvltUKq8=;
 b=dBhKQoE7ob8f4793DjlsXkusPELRvjDEHP/xQL39m8KAiS30JxZUgRuv8l6W+udnfwphGzODxADZe9+dFNFX/AfGSBpFiHgDRenlOM7HppYwaJ34B6i8o1kJlSlzRe4gTVdKusi/deGLolUoJbl4X3lJnfxwhHDbqcZbgNVlQsMdisANj1geNMrPtwfzMxaNK7g6uEKntdLL684sv2bUVeCRkVFjjrob5l2xK8SSIrCIEaNTy94lDaWlXYhM0m9k0AYbNe/yi6OfTAUF2f4KPD9H+KQ5c5N0DIyEnjzxxxWPKEST1iK209EsSZt/B6NRSn7d22L3jN1sk8XxAWpFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu4jEtwEMerHa6kGvpApXDza8GQBVq15ZpoYvltUKq8=;
 b=fgq4wfEp1G5sFnbq7ZAi+PnmFBpaR4aRwadGrcaWGQP0IToq3MoHcT+xL7SGxBYUU6oPfb2sZ9KILE8fx3KCNnaaJnVF/zF3JyV5VCXIyVftFpk5chSIjQOMMvRpM0J5E9L6BIKkjz4t+QFK28Q2btKfxc1V2Jm3+cznMCOEtHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL0PR13MB4514.namprd13.prod.outlook.com (2603:10b6:208:1c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 20:24:28 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:24:28 +0000
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
Subject: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Wed, 21 Jan 2026 15:24:18 -0500
Message-ID: <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e878b97-030f-439b-f501-08de592b13c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T96iaGPJoSZc6G8xo+8Sojay91Rl4jSEMRzLNkQUwHfc9yCYt3sgPYxiuO7q?=
 =?us-ascii?Q?b+XC0tCFNb4tCumR3wq9w0mugfOm7ehsN+xRqhSqHruvWKgNWL7x+cYXyQ7r?=
 =?us-ascii?Q?Dx/xGEmyJhJrLxi1eoWZZS5n89cnaWlmpS9nzKBXsOc40dOT60iAwBtTNfcE?=
 =?us-ascii?Q?19z+48EW5hijpIf/yqgBFJB12o4w63Im3IYU6K586eJTBB8f+/DQyQJmC9Kn?=
 =?us-ascii?Q?BjGIUZutX19FbdwsUQhHm3E2KR6XtUVivPRzocwnQwLc3fqlld3qVyBSrXT2?=
 =?us-ascii?Q?auehH9o3L28iQGB0rg2pqO+pfj56xEmNS9nlAUN46hgdfzxGCHYyN1D9iUK4?=
 =?us-ascii?Q?qxdDkBPbV0zWCzQc9D5t4CUN2h7/C2mXKHLYH9++/keEGHmyIy3PZJtmV5ho?=
 =?us-ascii?Q?7wX/Iv66A+aELvAH7BNWyhAzIufo7X/2G10IBvzEDdsl0b5R/qSvGtnANgMW?=
 =?us-ascii?Q?KDIs8Ec2JbKvsubgFtzL1NwlM3OvOdjcztmMMT2QSQuTKrV0LqS2ZP8aVIbM?=
 =?us-ascii?Q?Suytv1MXznaxkMXzd5mpsP4IVaghIWQmTC8XTsuwLysKnZ1hTqUDY6CKRE6t?=
 =?us-ascii?Q?ZLPpT136rp2SJEm/ROKG18Je1GIr8/MK8uT69pTEN2vfxrTuAGlpxX9ivxvX?=
 =?us-ascii?Q?B73sNyACuVR+EVEwkXP1LdpiychJKSkttta8t+CL1KSQzup+dADTo3f8OuXi?=
 =?us-ascii?Q?yl9coNZ29m5GsEwFfCYghZo0/08e9FahvWGO9cIOBiWOr1fD5WD3mjZQDtOa?=
 =?us-ascii?Q?345zIeaz5JaeF5BDTBLnOvTfX4dMTcNTOLGQx1A6hQ9ZszwE1wb94eu7QHy8?=
 =?us-ascii?Q?T/wIh9Jr95O825VWAKDnkAxDlBPPXwgUg6ah4Sts1oC8Ll4mPVA7Aq0Za+ai?=
 =?us-ascii?Q?YOTBRdI7LN9BBFP/DwQx6xD7047hZdFIRIFwH0PtVT+9eImoDus9Yz8AvnrF?=
 =?us-ascii?Q?oU58rnXIXOG0taY/KuN9wFYCXNxVZwTS3PFIRVrImP09Hq9xWKLdV6YIUYEu?=
 =?us-ascii?Q?/4BJkuWWVR2QgNO7/7yFjHrZaDatNUz1oTJXkdfJml/kgWN/SjQEb75zj8eI?=
 =?us-ascii?Q?sJ/ZbAZspSpGxs+QzVzM5mT68XsAaZw4BLRskcUzvEbaMvCtJD43NfeTtVCp?=
 =?us-ascii?Q?Lq/Zew5nWGsNnkc7zwMrgfvgsopM8BR7f1OCLxSXECkJQwGBMFCovbK0IMVp?=
 =?us-ascii?Q?dDBAij1VCkvPP9KKqz00Qr4hT5sOIPYQQov26KHR/EnN6Mjx7j4KxrqhD41H?=
 =?us-ascii?Q?IcZDwvuesASucLwhyG0rG2VY5lKvgOKm6QyjHIE0EL+TCnPh/3UziaMP6Ag2?=
 =?us-ascii?Q?pm6S2YBPGLF2iA6yj2f34bsYmuSpcfltcNc+tsCMMCNtAHvmFgZUW5XWc30t?=
 =?us-ascii?Q?qlKxYCptY0AAQS4bIU/e/EU9FtICkGO7xvnwbkc+iSQJEH7r2Xzq3GSwDFYV?=
 =?us-ascii?Q?fw09QSLFE5JVG/J8C2seYXU2tJ9GGkH3cN7xp54aTMPFJKAubdQMObX7e+zh?=
 =?us-ascii?Q?Wuu2qanxp9O4YXVNaxDXdzgaI+dxWDHtEv9CuRqL6WzYlvP+7yIzWgocOc9X?=
 =?us-ascii?Q?PDGgWfsdvOhD7iCXikE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JlTLjx5uI5HtKpnUYADa658231CNw62G3kdaPp8Ii0yYP+byI1od+P9aFr4v?=
 =?us-ascii?Q?cIwVhRK93ba9lKWjS1k4zyqjgpF+st+LPirjA1N8q0OxwFMsg5nyKKJz1/cs?=
 =?us-ascii?Q?SMYMTlO4PGYvVVQs949a40zUsdoON39/j+ihso3zXKTEd/is4EG0oeNTTPOv?=
 =?us-ascii?Q?UHhG2R66287dFv2jQrZnyyl1G91nhTVHe6bM5xiE7u2QuBwjm9HC0B64S+iO?=
 =?us-ascii?Q?LSu/T50L8oe8TyH5IWYIH1sZT9q+cx8JO8QBPAHHvVCL3NO9BNCt3vThuJDJ?=
 =?us-ascii?Q?N1f41xIo7CeTisqgKDj/9RNn7f0txGfVMB0tL1PA6ItlDEuPvPk299a2rDxG?=
 =?us-ascii?Q?r2sAlNtjzesAWOKGBViT/o5uxaYe8IPLUfNmzz+sYdelwxXdK4jcDD6XhBPR?=
 =?us-ascii?Q?RHZpN7FUuKKvdAP31moOEGfBN1KGyjlLtVP+nDTxg9UYKlxacPdB2NzoVatd?=
 =?us-ascii?Q?x2CsjO/uaUe/r06kvEjLukmSxnU85E59HJ85S/EJ4g+JfMvSRYrs1ZwLBeo7?=
 =?us-ascii?Q?kAUxiCeomD+xS2iIKWyXxGdE4usz1lQNqbxa8gGGk6j47JNNcrjNIbqnvzuX?=
 =?us-ascii?Q?l4MovuoNQFeHcGMHAGXtw/aswZA622FndBBFD+wcuIhxQBfmn5QcEwI/ifq8?=
 =?us-ascii?Q?hpZafJD58B89odbsE+Dge3rbnpyMmlBncyn2ZZgqnlKgffjQKCMV0iOUJWm1?=
 =?us-ascii?Q?e/eMNt2UQXIN/t91eFp3/JTybbuBKS9Fvn6vDOnqikGp+VH84ky7HjbGmMnk?=
 =?us-ascii?Q?HDg7uuyq4xYgh5snll00Zvo39MC0XYGBBMnbTUAnXSPc1dxEZLhLcOurXlEL?=
 =?us-ascii?Q?vzwg2jsjrO8Mfs06PrF1WFRIrnbjiMw5UGp9hCgho4UljGi10y7K+ma6h9bt?=
 =?us-ascii?Q?2ZnfZMOs80Cz1KwD1Hruk4S2XKtLvyM4kOwj+yv7wQOj4mQJ+HOArfVW6IPl?=
 =?us-ascii?Q?Xi2RSoIydkeCv9r0R7+RePgDMKUkHN1q/gQpPwPqtmfiT2nNp+A54CPvNNcC?=
 =?us-ascii?Q?8IpZ8Pwk64LGhE1/WIBY4x5eonP3oY+BBzDga0P0RKk7uKhkP20sO3RnJqoz?=
 =?us-ascii?Q?hKnmOnGeNDU09YTRiONMjwaJWXUrIUp+X43rGd/xHIQh5vXJ1gm3zml6QI6I?=
 =?us-ascii?Q?RlJcbV8plsg+wawvm8ohQ9GCQCnIS+3SSZPZ1/mRNoO8Au0v03Zcm7cAOOJr?=
 =?us-ascii?Q?B0jUp7lcoU98Np8VZiLfFW9F31+HuL1I3bdC4b+pjxpY1nZbWjqDV5F++N0B?=
 =?us-ascii?Q?9vihhO8TkHxYVYp0z9YyZhCHM0+6+jUOgETo8CNNd1knQ6hh2CzH9Oeiosfv?=
 =?us-ascii?Q?jEqMUW8TTlztwtI4cSHkLKS9b1nq/fGiCvTZluvQbfI12+NT6BacKpYLukBx?=
 =?us-ascii?Q?FiXM4GAtyEoxaWd8rroaKaq5L/zUNm8V2JUG7p8XW8kuTjrx+rdDptjnIiO9?=
 =?us-ascii?Q?z13LYG4HP3YOfIrFK34YbtrCiBdyjOPr0Ga8Pi3FT4dZ5BrTbLNWWkWVR1h2?=
 =?us-ascii?Q?06f5Bo2M+5hqbBlqQPB9WiMrgdgiuxd9rBR07aIObCWbevnmsv/9Hzt/3sSA?=
 =?us-ascii?Q?YLFBiZnTWCQouHCImIz9avT/uuzVZR7bwrdL1Ga0CvxgFc+Ss+4jweKiIuSw?=
 =?us-ascii?Q?Gq5oFLBCq7mzLxNCnvnnD6jsfwCzUOM0jw1ZOcQHF0lYj9g0ITPz0RoGu0st?=
 =?us-ascii?Q?LIiew/pJ3FqEGcvCXdSGnk70frtD11q99vjaNcSqrHnUazAH99hMOfsZE0lR?=
 =?us-ascii?Q?Y1IDMN0BHLOpzSX+y6ZGgPi6bNnhA1k=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e878b97-030f-439b-f501-08de592b13c0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:24:28.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc2buJVILPkznB6zrFr8A5VsQdvHVnZPWIHoK3mz8hXp5+la5no9xRWkf9b0T896kLbc+rz1CCC5KtSSRXjYZSHPpD8PztVBMOZeP5INoOI=
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
	TAGGED_FROM(0.00)[bounces-74924-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 357B75DB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using siphash as a MAC (Message Authentication
Code).  Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte siphash to encoded filehandles for exports that have set
the "sign_fh" export option.  The filehandle's fh_auth_type is set to
FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
clients are verified by comparing the appended hash to the expected hash.
If the MAC does not match the server responds with NFS error _BADHANDLE.
If unsigned filehandles are received for an export with "sign_fh" they are
rejected with NFS error _BADHANDLE.

Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsfh.h |  3 ++
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..ea3473acbf71 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+static int fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return 0;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return -EINVAL;
+	}
+
+	fh->fh_auth_type = FH_AT_MAC;
+	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return 0;
+}
+
+/*
+ * Verify that the the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	u64 hash;
+
+	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
+		return -EINVAL;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	if (--data_left < 0)
 		return error;
-	if (fh->fh_auth_type != 0)
+
+	/* either FH_AT_NONE or FH_AT_MAC */
+	if (fh->fh_auth_type > 1)
 		return error;
+
 	len = key_len(fh->fh_fsid_type) / 4;
 	if (len == 0)
 		return error;
@@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..7fff46ac2ba8 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -59,6 +59,9 @@ struct knfsd_fh {
 #define fh_fsid_type		fh_raw[2]
 #define fh_fileid_type		fh_raw[3]
 
+#define FH_AT_NONE		0
+#define FH_AT_MAC		1
+
 static inline u32 *fh_fsid(const struct knfsd_fh *fh)
 {
 	return (u32 *)&fh->fh_raw[4];
-- 
2.50.1


