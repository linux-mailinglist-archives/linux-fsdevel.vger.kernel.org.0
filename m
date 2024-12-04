Return-Path: <linux-fsdevel+bounces-36477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06E9E3E94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADFD283776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68F20C48A;
	Wed,  4 Dec 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxrDeZsJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zD0SdK0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231D20B7E4;
	Wed,  4 Dec 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327048; cv=fail; b=acbFfXOLJbGrIZ772lzkmcfSSNASFYcym/NpKQDCDHGSMKzvw24AOZtYvbu3RTaComlBry5w0nAeABzHPxJyhGdl8guJb5pyJ5Ls2uL6cklm21mDqOGaFeHWi/PqK9K+Hd729FWjdjxYLLrBgDjQf9FrHdG18+3+xSxqjlDBA5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327048; c=relaxed/simple;
	bh=stvtAqdLaMnBGfSY8drr9qr6qAsfd5UpveEinRpr58Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLTOqALIYK8/0Umyba6pS79v4nLF+6u2L3M6iQIpHKXlb30ydzxagiE8i9lsv2TC5spEpJMsAoGN0ODL4x8TGfUUmXV6Ze3v99TwXh2AS914YwIT/7EQSx25q0KlSdj4B4OMg9ueKEJCy0iayEBG39wfRj+dD1kb7y21ElhywMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxrDeZsJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zD0SdK0n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0xtA027470;
	Wed, 4 Dec 2024 15:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/xc+AImhXfj4/FQYfDqzhX1LED4orvbRlAxdQUkvhEY=; b=
	VxrDeZsJFbHwlYz1o0qImniBfc6olEsdGpnJpki/L4nqZIaVil5+3SMYBtZVD43C
	Y2WxTlJVYzMWNKZ1sZ0ZZ1rF4eEVNJU5ERzzw02DqCeXmSIwUdHqEMVM/wF05ZT4
	Ta9QjQ1GFmd7cXZ0PGwCqwJ2zQIVLS6vizh7CcibBoEa+x9NroYPePElG6v3SJAC
	+t6vO8ZrvJQEihCdazEuo/bFNWwqW3ytU3iVpwCYtySWWw7VL4b8n/fk+q2jjNsF
	FQxKLeinTzFDhqrgOHJuNxR80LPpTWa8mRsKHlmAkJXqzNWztkG6ItCSPcA8MxMZ
	A0dP7WzyusIpE+7iaLIELw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg28sge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EgVhR036956;
	Wed, 4 Dec 2024 15:43:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5a3u48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wiscqnuawn7GzKOuxbaAblBswClNiEgAdVRt2hM5cWHGeTpEzXMQEn+HxGfmBPAxw1PySlegG4tvSJkA/70vEA+W54uC+vcVNUcgatmN7HVK8J+xZQiRyo5Bc16uj14jqkXLO8gaeJIyZztIPXg5aQrvutTcJsrRB812sKkr6Afsn/T/FwwsKGz12owU/A5x4sD9FgV5DD2glN2L78MMsVCFgbblj0HqqQrD0+xtsDoPVDG7fW3jz1O6Lx8SmbGOHXU2kFMFak3AWp2rf1BLu2BPPX4y9v/67xVdtnubGxDYfXHgO/3O3/Uhds11epwpX7rn1tgUtIKFmw8AFB4ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xc+AImhXfj4/FQYfDqzhX1LED4orvbRlAxdQUkvhEY=;
 b=fTaLEZ0SP3VlQvBoapbPz7oljlhC4V6nEh01becof2AT4dYmkavqTqJ7dCozA1g0JBEzhDu6FhF4B7NZuMCfTPD13TcKuvmvQ371H44APviVBYUYyKsHBKoy3zcBEibkJpiD4v2WAyNTwAHKy3oL68VDseIsG9SZ85PkVMYde6b+Y2MdJNWFqBsouXeJne73y/I4oEX947SLHFct4h0PffJ9BGi0lK9GF1bZm98KqjarTnXQwJ4ZNZIWu7ivF8qLcxj0AaLcX6YhZF5Ph7ShECWmUe7UUYcAxsjJ8Q9OFzFeUxzZtNGNFTgaBHW7XhncrvIMZlqorzPJ8tbZkCG5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xc+AImhXfj4/FQYfDqzhX1LED4orvbRlAxdQUkvhEY=;
 b=zD0SdK0nOOpoLtxkMK5q+aE3UEnwAZia7uN0u1ByayK2MBA2LNp17QFuaTviVvNRO9876643Bmzug7LyORd5UHL4svZmwkUPdT8wFmwOX7fxd9kwSH699pOyTIwxn2LsOAkc/9/Beip8aH8ndgoputCvSQprXSmfZFX+JVb6Gug=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:43:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:43:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/4] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Wed,  4 Dec 2024 15:43:42 +0000
Message-Id: <20241204154344.3034362-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241204154344.3034362-1-john.g.garry@oracle.com>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 90969aef-f201-4396-ed83-08dd147a7625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djsYwCRatPAGgMRsEMD1Q/2brPEVOrPyZemmf3JL7HNK6JaGLMx8Wk9VrUrO?=
 =?us-ascii?Q?XiuBBYQuBZZTlMcCQ1+0k38cJicMhH/HuE2B9l8mOekeiOs2nhb0ICdrjkpA?=
 =?us-ascii?Q?Ae5r8IdwlaSUt9t4D69mfU+TOg0ffGE2mFf/uiWdNIHJi4QTW9tN1LJnx/zR?=
 =?us-ascii?Q?MGvQgAm0pYElwaAOPj/oqX3/YBuC/GSPnuH81OMlwC7gQf6VHJ3KDgyevZPz?=
 =?us-ascii?Q?VJiNzg/zOAgzCW1PkCmYywNKu7A3Igkmho3ZSM/6l1YybwHI80mOw6eDIHvM?=
 =?us-ascii?Q?+Md7a7uH2IhB3AyEmxHtrFGgRTz/Kb1+bmXBRa2/9bjeAP0xSdBMScQTINkM?=
 =?us-ascii?Q?g++P32xuhl356ljPSRoqmptUNC2ZkUJlZZ8zz1IQSNr/FvwSZ6012VtNMlZl?=
 =?us-ascii?Q?SBsEjKjeyrxLzlBhUW3D9rpYbIvOdsm96yhYFekRIshGmWalVbnv6ukWpghQ?=
 =?us-ascii?Q?JNS+qIDLApo2Q6wb2dX37+oPypfQstnzI6kLblmtwTEfJ5pBmLinXv+e6ENc?=
 =?us-ascii?Q?mFRCVNFgHAbatonxzWZs5xP3E5hg0XELItFVti7QtaCsr2+sxm1+VUzs8qJd?=
 =?us-ascii?Q?Y6N5LMZoLETw8//1mexlVtFWbCeMpgc7zORsNXpcp2UWUQYPwKPpYidDyXE+?=
 =?us-ascii?Q?1Cvv/hBaD7pt1/dcRgOsSylSpsV+MgeTXvCxfGKDCiDP6t7QCL5OFC/s0jfU?=
 =?us-ascii?Q?dQeVcVeHVvG9WbpT538Y+wHne7o+GjicBxAuYWAV7aaqszIjvBF8ySPCxVRZ?=
 =?us-ascii?Q?jrBUC5k8Ug12paamqglS06UExOQ7kSW7806YUOrYcUn7r1821L9I30hr2szf?=
 =?us-ascii?Q?bv13g4wxrKDwxewLWbWSe1Epo2Tv2FPYybG4dMtBw5iQiiCNN1HzCLVWx2BO?=
 =?us-ascii?Q?bFi/E9TrqvLDdzCXRPw98Vz8Gkw3z+b01nS4ACf7Ed+x8WWjDHOLdm+HjgYp?=
 =?us-ascii?Q?+rI6zPr4GVcp2W1RYJSNluYvOFud1/bJC1V+Tn9z50sPDsKkcSuaf7l4fuoB?=
 =?us-ascii?Q?Lc/aZskF6/7rrHriWBSZvF4XgNkKuXc4go5TViNKeGUHq5P6eN/+i1MO5oYs?=
 =?us-ascii?Q?RrbdrREIsiX01da17Z+sjSxNDDSCg+rvloF6OEAeWVOgHezRGHV83MZ8xVBn?=
 =?us-ascii?Q?aMNNCrsu/YR04WYGv96hpG0s0IeWI7MqejuwDKRIs4Q3Yntdqlteqv+Toz9w?=
 =?us-ascii?Q?ghf/223w7JIHp/vkLlgiCRZHH56A6Xb9YZ0sFLZc/07iFiCcpDZyVv+Q2CYJ?=
 =?us-ascii?Q?Wscefz/7GC1v7qSPlfMmBZdPmDk/IUwI+1dR5R1ffM55IZ/ZAt2qe1FCcDju?=
 =?us-ascii?Q?0NQrSH5DJsvdvLHA1mntU37vk9vZj3qrfE1OPrR1+cCY8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WnrEr7oMw+evm3KuOHHSl+VD8z8MFum3ccNT7rMPKbFjRE8tZFXBEvsoBAJF?=
 =?us-ascii?Q?SJVCJKlAEsZ5NVZ9oOWqmxlBTr7Q5Fn63fR7H+qxewyUb2eAg12zfauigk+0?=
 =?us-ascii?Q?ZJmQl5btvO9VUzGz25itNKkt73sCBmZeUVvPk/eJguLTBarTX15SIUqfAnGf?=
 =?us-ascii?Q?ZC7H2LQm6Y84TKT+ma58Su/2smxmA/7HwbFLX2IH7Gn+fxa4dvz6kUSKroUk?=
 =?us-ascii?Q?ESkv4HSLZV5vmNRtMSl0x3u646uPxGHK2Lwq8sk17iIVYrucz1JdzC36If/I?=
 =?us-ascii?Q?2zoB6jft5URCOjOQZ4urB4CDGQJY3F1RJHEBEq3fU43+qPWkkt49RBrcsape?=
 =?us-ascii?Q?/RV4MEOzbQCIG6qCidGSh6ylHKM0iWpjdrz3K33i/5xVEq3X9Zh5bgiIMyfy?=
 =?us-ascii?Q?OlHY4IBs3hA0FPYCkay7SX9X5l3GPfe764HIKSMpKOUBJlQQ1MqZ1CzWUg1z?=
 =?us-ascii?Q?/kDURplMfQ+9iKsXYi5jifIUh+XIkOfPTIqohrWb9QFowcZFuktUz2eN7yeo?=
 =?us-ascii?Q?TDzsii+KoVWtJSvuiieKSrua0+Or2vGQ+SnF5DEbPnLABFjBe0TwV4PWXDhL?=
 =?us-ascii?Q?J0At1ufm9KjUL/xdAhTRy6dmnzR0r/AiWx89v+ZLIKSewtZYmhorHQecG1Bk?=
 =?us-ascii?Q?f2LOeTlQ0VGhvIkKWVueJnjNhsMvH7V9jsk6hcWQZIZoRYgnnKBOCk0hABBJ?=
 =?us-ascii?Q?W0kJDw2ZbhQQSbw6ZXkdvpHZSQL7bE0kzQ2ozXLkKY4KEUnFFqgBOTDDGyOR?=
 =?us-ascii?Q?JreLCpnc3effDslzm7/Wlbq8poD37e7xUjhJZrXJEckNSJzGXdA/VFfZszX4?=
 =?us-ascii?Q?69TzPyzBrHwSn8qefeyz9AZo/2B26F1TeR/fuuRl61PwPJMNmStmdvxiImch?=
 =?us-ascii?Q?0TfXXHL70BgiryRG1uWJ0nl283JHJJvniF8bQU3ZPyf041IKOLnGDyUskgEz?=
 =?us-ascii?Q?TupzcNIduPx8YH7ROXNvPf6VC285TITtWdPjmPwR2WQoP1XjgVQmA8ATLwus?=
 =?us-ascii?Q?YFxKr3Z5pq5YZxmB75zZNb9jlGqVgNUEvUWwMll7IwHoNHdsQMWDceoo/pME?=
 =?us-ascii?Q?KACuMOomYp56WjF4LedGUpNEzUO/rWbp5BEyvcvef0eHK4gXyIxlj9vq1JK+?=
 =?us-ascii?Q?WXau0EZTuJTav3DD6Ccc4mzjm8Yi3C9JeFfjOLti6No3/uz5+UAR8j+uqc4x?=
 =?us-ascii?Q?WtDXDgIaOyhu/vjc7v4dKsBMkXV6logV1mDlrU9UD4VIcJbmsFzY+f/3GHDN?=
 =?us-ascii?Q?QsavwBR0n8Lc1hyExVB1ZuvaXANW793tW1x//K36ECW5T0h2cP+8GpOsC+yV?=
 =?us-ascii?Q?aM3swgROnjGCrivGB6kqBFrqDLPMWExLHhm47tNY60o59tCr7Ex29Gck+Ygt?=
 =?us-ascii?Q?gFIVlzs76P9pMsR+kUnXGm2pPJhZc/61JPfZ7hVYtM0dGxCJhOuVO4tznMiE?=
 =?us-ascii?Q?gZVur27j+e2tBQ44p1983SgUc/PXETzhnqZwLsYiq2KF8L8z8H2MAdHHLWvQ?=
 =?us-ascii?Q?s3VgER3h4Oj9u7vELsKNwh6hNC3w2wafpFKykd7Vvh4Ttc0BSm9ZzUl5qcrG?=
 =?us-ascii?Q?V//ho7q+pio+5e+9wENHgm0mqNpaFM91xMZeFmgAx4/CnhUKSLAaNZH3Uwzx?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqwjozAvDMzAMUhJDF5jjG3O70D/PmuUZN9WFOiXTpu9YGi/lmfAIg3Dp3eISdrw/6SSIZGUKExjSalaZ3V7022hPtOLzlXLW1nvI806x72tWRctOLLEV2Hvz+rPsrd14YwF+t1dNpxpTIfRQa9zMe0ruhJZhKbKr4bKZITUyBJ/A2a/Qv4XBFeh0hFJvwaRKA8vgfO5X5q3hpqiZpaIyLS5QTacHFExsQ1AuDPUjm6Rnw8dT4v6CE9MdRee4rS3of2TzarJ1zr3OpNigt1mfpw4OhfYI0sqBiyuFir1cy5+hojw2seNHboKNXdANTKhONyfYpQu0UfOW4wSGLtXNIYeanx+ahefQsqNebmJk4kFuK3FXUleqqRSFzjzLA40PrDDPQYwtEdyc4CWGwAyGLp7QOq2ZV8+uDIErlDf+g5c763z/s5miertGuJbP9j7xLo6pB3a5VFy4rLW5xjb2s546Jtvg7cKIpNu/wSNaynHsGNo7assvF+gDuzDaphWhE6qtW8/Y3nYABQ66BwiBrE84xau8N3GJn0a2yW51NhIx3zFTVVyJj2yzt5F5EgipxYjDUuu10N9ORmbIUQwJS+qfis9Vrv6QUkXq1AzHMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90969aef-f201-4396-ed83-08dd147a7625
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:43:55.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ9/WXzn9Rl+YcOfls1M3uuFU0tPrHRQQSvVniSFMjrfflvKnRr9SEIJWh7itj7fpjwzJsQQPlAG7fl4cRA6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_12,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040120
X-Proofpoint-ORIG-GUID: c9oh4bihTpkfRMSU-JnMlvS3rVe7A7i_
X-Proofpoint-GUID: c9oh4bihTpkfRMSU-JnMlvS3rVe7A7i_

Currently atomic writes size permitted is fixed at the blocksize.

To start to remove this restriction, use xfs_get_atomic_write_attr() to
find the per-inode atomic write limits and check according to that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c |  2 +-
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4a0b7de4f7ae..abcaba71fea7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -853,14 +853,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 207e0dadffc3..883ec45ae708 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,7 +572,7 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
-static void
+void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..82d3ffbf7024 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+extern void xfs_get_atomic_write_attr(struct xfs_inode	*ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


