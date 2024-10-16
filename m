Return-Path: <linux-fsdevel+bounces-32093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C79A0682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DABF284C51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68163207A08;
	Wed, 16 Oct 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fE3e6bl0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLmJpQsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAF2076B3;
	Wed, 16 Oct 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073057; cv=fail; b=psN2cvN+nG2BEsvRTYQtDy/I3311RNrOUjGt9mF1N99+ynDVrXq9A4JPMD0fKswtcwSwrx9jwvB0q3E0+7WY4+hJyG+7bPTt/kbJGoinvO322QZ56nis3Nxt8aecLujj6nN5upM1UPVqp4n0PiSV1ZpAL3xkGMLJYFt9DvlaHA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073057; c=relaxed/simple;
	bh=3k8YlyWoedrDmcHXS8vYxXDkrXJWfaJ0K/l8qe3kGXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLLq1+j/F9/6VVeG05oUMS+fbLS4/Sg+7X1k5xuCjSgzDNa9N9CLJ+HBMOVU948MeRY6ScevGybSneKeSL/U2YuHffvVpqm3WKqsbFXTiIelXgNrdnIDrnvENNPt46KKGKqeAJYAV3rrEEFrqs3QqcGiGXPsc5HW1jtCnTYYmIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fE3e6bl0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLmJpQsM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9te91008695;
	Wed, 16 Oct 2024 10:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=; b=
	fE3e6bl00n14EswgaBibBVX2OJGPQ/qdTuTuR2mefVivxkfviL71ts1Tpreci52J
	ODyFa/mjddCL+dqvNCgrF2LsxTRS0INNskbL8Y3eSYggmknHNZ7x83oWQF1NolxC
	sIKqpKl9rVxbSSsxzT+QOQfqtTfMELbjIfjOi05dEF0hIxzjI5x4nM4PY23/NpXT
	Z4NmI/3GByk8xhk9KnMXRZ6GGuCLbT9ALRbg7DMDTyEDUxG5Nk8fp+4JujYW2bBu
	u52NYQ1UTB006NiYWq6JLOj+Oqy/hnppC+JIFPolLElBKyzdBiTBqHHeXbFRsCV3
	6ncISedpnOciMT/idEzE6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09jv3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:04:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Ht01027269;
	Wed, 16 Oct 2024 10:03:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjf6egd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j76lMh1rGZBK9YlpFuDXtQaM2NxAOwddmfShnWKgAXfh+CJL++Mnmyh7hkaBh3WPe1gQO6OkEk+3CvWbnmqgAc6UQ6vpEUmi5aHsiL2FdJsVJnW3l//TNq9agAWJvc/VYuNprR3ow2a31U+MruwOjmypTE2Q32AtXHAvDgwxuD277i3wHrNyfoOfvOSR2QtapbjOscysjgkVAZMRxWgD2hpLKbRQtJbPSZVXzxAPkTG+knDHDigudsTDYGBlK5lz3OauIMx3gHRJtmG6KEJPJYAbaU0R27cSDvSA6aGqE8UYsV95K+QgDZoO3ivILLbf3enXgF/ucZP5Ii8jxa3++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=;
 b=XwKuzzA2QXJJ9x9eG9bsDFakmykGHNY/XNhtKZyswTZhDIrwnuhcjnOZ4Bq667t4rkwL0GTs2BNn7ViwttPG0jidL+GscQzLWYFX9hIRNvuEPRDKWjM5DXVGQm2ZXBRNhdO0FsFJ9h7JoI8fJGs3b4KvrOfOzzHGEnOiIH8mFsZUnr5GQRREvKGtB5UAvXtzttrjSAcb2wNbhyz/xchXUvf/uReikdeJraPNvq7cTO3PX9y6npffzW6druaVwEejklqWxq+FK6Dt58iI1Dc6i6FCSrdRKJq/ATCNMLdVYWZqNgEfE2hY8eyPTnYPqzyuxolAvrFNdTqyhgJF9MX9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TBUcSBMjRN+CVXfAOayVUIdEUhKXjFo9KkvWHdeKsw=;
 b=CLmJpQsMOXwsjpkvZtL9d7ijBkpFYxiDi/3el80k0DAuIH5x83TFBzi8EeL6d2tn25eKbgQR1RT/DE3gm/2P4FIKh4GKk+xeofWS9levAhnzc/2EBZXHPQUV04VHX8c+GwIXDtIbknwR0rG328F742Cur35Wi5yOvlUOHgIwJ2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 6/8] xfs: Support atomic write for statx
Date: Wed, 16 Oct 2024 10:03:23 +0000
Message-Id: <20241016100325.3534494-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 0091ef6d-23fa-4590-c5af-08dcedc9d92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r04yUmANPn4UqYWDjNIf61Jd6SUcRHMqp7HWrpnVYjh3LYyadQ22CWrgrM+C?=
 =?us-ascii?Q?o3mRn4f/9VWwpeBkIZAHNag/os3+ahi6UqViKoopl37/CoL3Rd08iasEJEnl?=
 =?us-ascii?Q?oSai7HobhjixzKEii/DJpdqKudSZ+nOmgw1JImbW97u/bTvDWDBh1Zwgw8pR?=
 =?us-ascii?Q?RxFfD4HgkZr/83OBxv/5Hkh/UwlZD205LpTJbp4UQ+HaJYEmV6OFiTeixE4t?=
 =?us-ascii?Q?EY6wgNjN7gr+jaGHx7A6pqpQf9Vbm/tNnimWZqhB3rksIzIciNvHmVOHZIV1?=
 =?us-ascii?Q?A9EhgXKj8rawwj/QwkNSz1K26v3VymOTnhNpXd1Dzx5LgKpWPJs6cPAvbUcX?=
 =?us-ascii?Q?YT5rNeXmTMtOfo2OY9if1uMlr99cYU0T3N3vjA3Ss09MlFzMRABLJhCq0BQc?=
 =?us-ascii?Q?J0qBAWZyLdLHpCxlKslValK2aacGh/dq0e19V1OiCyBdHhXA/HzOG1EpvzFH?=
 =?us-ascii?Q?LT8gCs8F95Za6a4isq+fVc+/C9h/VVdX7ssyNjjL1hIgzyzyLvZ8DoxpNVIO?=
 =?us-ascii?Q?lGXvcwmBZopxCTH2m3ajEAuqRbaxUFIJWPdswP7Sudj1bp/tYw69k1T8Shpl?=
 =?us-ascii?Q?nakpoMlwSsnANLGLXqKSM6ewb0/MT5j09ARNigBj9HIVljkgUYLDbAmTMB0G?=
 =?us-ascii?Q?9fGQnhJ3VqUXBjmuIDMCMUwPLh/q/it9MpN8ltvBPaULiNYTjillcZRgWCI5?=
 =?us-ascii?Q?Hsw3iRWt0Es+elv5+/MfcVuGdZ9gQuxXo3SwClXgLBDRZokC43uTCD5rq4iF?=
 =?us-ascii?Q?WgDtfCre4ECUEdF19HRPswgyJI2hQq4Arp1Cu75Nwlg7hWnFZiOo7GdVZ1NX?=
 =?us-ascii?Q?0oSlwss7JHtSAvxXOw1LBeQi81+7Fbo+k1zEVAA7PG8cjWtMm7U/+3vWvrtJ?=
 =?us-ascii?Q?Tc9t+bG0cHBaBrqZ/6UhU07zpKeKjm+WKfwSjgMgLNHYWSUQPEki3mzl3oa6?=
 =?us-ascii?Q?I5mWDzfHyEVVBU0YzlKWUZxm8n9kJBOd1a8Va5HYByT4SMjKdHTo6IgGvvB4?=
 =?us-ascii?Q?hzSk4b3cw//rJ2FG6w5R09NeLWNdrmZDXHKEzomgUksxvARgFKesxo2xC3sD?=
 =?us-ascii?Q?YpuCAo584cY7ZkGlzTujg+SWZSU7pJybBKqXdYFhJ5T78LmRpGyO3hAA0Fsu?=
 =?us-ascii?Q?EXu/0CexSQJSCgLOB4B7qWTdPxOeaFfzosRi1rgea8D959pmgPjZbUT62VWA?=
 =?us-ascii?Q?y3CFOeJakTmQfbR63MOpXISTb4zK7PpZODM8wNudwFoVtabJzRJGNN0a0u++?=
 =?us-ascii?Q?hTl12FEQTFNwan3ONawEngjxD0mCe/Ny2CYlkdr2ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBSBhkfsKtnpOWEvh9AJO+fq6pSiXOuXBfIYTtpkYXR6piUgAF1AQEYx6CEE?=
 =?us-ascii?Q?g964yFWQnPE2TGR7tdPkKoWXGrX+M2ugX9xQgTeWDcqZo4IiH4rCRHA/oZRA?=
 =?us-ascii?Q?iBFE3NXj3SpKcoxOZ9edCBacJLsluShjhRifxJqgLwmuLBCdG3QOElRZt0bJ?=
 =?us-ascii?Q?GvraFyAEKf2nTyRT2BOk+WrbVK1hbWvOOj0RYh3SgmUelLcHgMMvcWy9x0Y3?=
 =?us-ascii?Q?xMSA0QgZo0gzlcJyh7U4TW4y+OCzQ/A9fYKzofYrrbNs9mcSngr0li2CvPy+?=
 =?us-ascii?Q?61CA3bQCVNIS/112BNPdECBYFeLvlvQtdgmTe2oy71OhD9K0PhGssZUpay30?=
 =?us-ascii?Q?fsYU10NvjoSvBWF27B2CLGAe1XEkgOyFlWOFO7VmcH3aWKZA7YZXRhZTgKCy?=
 =?us-ascii?Q?TqfoV9r8JvZBsWlyv8NIewKtWh7SLSNkkNWpGKnid+Yf6m8HRF49aAhOMpen?=
 =?us-ascii?Q?h/YqeUjIOJSAknKC5i38vWXjL+ZAE1zDPuw36W18085Hqb75IFRh4ucRYHhv?=
 =?us-ascii?Q?0PZv6LUmgh3RtetJbQXj73M8wTaOczGKVe5AVZJQLhFr5moGRsvJtyB4HtJe?=
 =?us-ascii?Q?QM+z/zpbDHB7L1unJkAKogLQ1RpTjJm3ilGjoih3t3y5yLegQwncLM4qmkFn?=
 =?us-ascii?Q?2+WYA+tBMGwmz9dG+Q7TV/yMcI11n3Hk3w25KHNhD5Ty3M678cqiSbBrJZR7?=
 =?us-ascii?Q?O0Yi4v2dRkwixr++VYZwoT5EhBtzDSvhj9mX2KiPsXaVnveEelDHZrfhsnpj?=
 =?us-ascii?Q?YLvgPsG92AzlDrSIFAGcZ69K/nrSSGZ90ryePHWpZrDYokjsL14+D828RXSf?=
 =?us-ascii?Q?NXBUge4yLSKvDCRUYnJkMvWhKczciUCSKA2MwulKFFDlzrA8orNgjWUxKnmo?=
 =?us-ascii?Q?NB0XEna4IjAIgQii5ZL5zipBFtnGBPbD18pHlPX5/ZmYM3UkcJEPphoSQqCP?=
 =?us-ascii?Q?Su01kZMvLVYnt5Un0zVrHm3QdpZow+PDwgv0FaHeOjAOna/nL+ne2jlfWM4k?=
 =?us-ascii?Q?n0zaXQcFLVlaREOWgL69OCpwL8h6YrjT826zQBzDQZVOXBYqnavxxl+VBUhw?=
 =?us-ascii?Q?VK3sw7msVJJtdILZ+TC0sqA39RjFRdT8Quc1VtSXZ1l5PEkHGyPIjPxuJI1R?=
 =?us-ascii?Q?/iPbttCI6dBBFKLXX/FTVoekZhgIBMpF4eqPx6XoYEB4v+e1Fx2Wa60Vq/lH?=
 =?us-ascii?Q?Oe8dDsce5Kb74UDps3hLjeJZM1eVCwUcWwptFF5sSFm6PqUQdB/TE6JZxgSo?=
 =?us-ascii?Q?ilkMb1596bsQPEaCHFeuV2gswt1acfdKXH11KUNv4/sjfFm2hrNAmsbliYty?=
 =?us-ascii?Q?70Mqud4w8qH6TwHxMPzo8aGVRrPuOOimeJ3QemqVDNQ8cIdsT2mOwvXlEMlz?=
 =?us-ascii?Q?kFYx1LYTGGZsTJLf6vEO0pFG3RP0UM5IzF/caLrO/b/O8EA/fzpWXkRnOcVY?=
 =?us-ascii?Q?mi/K8ovbuUBYK51yD9Na3cbOYlz8LeLALQMjx/JUx554aze+qBoQ9+dg4x1W?=
 =?us-ascii?Q?4DRCxv4RoU4g2cmG8fCULSlO2BGPStPnlPBt4yxkBF0x6InRxLdqwj4BQQMg?=
 =?us-ascii?Q?GZOVzWZ3cfDuNWXiT8PX/AqnVFucFn7AJXPfuzx84HfAW19g3q20pJ0eXR9V?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oNDV8rI6fILFSsjhEIrGZXq1G4C0U840Mwib94I38l6NHIiiYVCBHjtXuCob72UkS8IhSCuxu3wIjAoWl0L/gMbMVx98eaxcUEZUuoPKqiHGK3B77Mt6ZXnGrPDCVspXz8z8oftMryG9TUmCFmaulExu6yU1nk/9ywC8nQPOBAYlvmoM1ostaxGfycwX4/MpyslyPsyBAj1xSHxTg+RFl41/Qd/uwpaeQabxY+TyLUQ0o67llZBDMsFiao05D0fXW2hDDTtMFwhcINMWREWIm8txJKRwkIZ4KJUjZ9H5LyT+KM21IyAbK1bMZABDCAPe5WPk/PCtomhm44oX3McvWTjwSEmRxRDpV3Px1GN9DAj4xPvRdJMwOn+P8tK0YY24NcM7Sg9BmUmPuSEBL44+QbrFfuo9Uir2RlFadD6qz2/RFOmX+JrLuQU72HsEZ5Nio3bZSuVVFA30qDcKvA9/dJ/4W+UV/hQOY/gM7TZC+8/ZUONHSn4fUGGNK+AlXfdhtMfs6EsnCI2tEvqbfNMhexn9k0tzpd2KjbSM6jyJcoEfhvh2SPY3kW1Jxjhi4pXIc1VRGPvBvsu6pAxLhUDDQvlHSnG9BEJ7bRSfqU8gcGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0091ef6d-23fa-4590-c5af-08dcedc9d92a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:56.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8TFwPQL3rj2Dbjeka5PWVsZd1q911BrYvFfeVrwjZSfcUQIXEjKoWAgZywdH7SZ/0HffpF3VPToTvsoo2gI2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160062
X-Proofpoint-GUID: Mymwdgc0RGyVstsPyxwvmmAHmGmSIoe4
X-Proofpoint-ORIG-GUID: Mymwdgc0RGyVstsPyxwvmmAHmGmSIoe4

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size. As for
max, we limit also at FS block size, as there is no current method to
guarantee extent alignment or granularity for regular files.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   |  7 +++++++
 fs/xfs/xfs_buf.h   |  4 ++++
 fs/xfs/xfs_inode.h | 15 +++++++++++++++
 fs/xfs/xfs_iops.c  | 22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..e8196f5778e2 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
+						btp->bt_bdev);
+		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
+						btp->bt_bdev);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..3d56bc7a35cc 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,10 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	/* Atomic write unit values */
+	unsigned int		bt_bdev_awu_min;
+	unsigned int		bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912306fd..73009a25a119 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -327,6 +327,21 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
+static inline bool
+xfs_inode_can_atomicwrite(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
+		return false;
+	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..5cd804812efd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,20 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +657,14 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int	unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min,
+					&unit_max);
+			generic_fill_statx_atomic_writes(stat,
+					unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


