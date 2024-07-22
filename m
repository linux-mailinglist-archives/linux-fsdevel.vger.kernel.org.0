Return-Path: <linux-fsdevel+bounces-24057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D91938CEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480741F286F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7916C861;
	Mon, 22 Jul 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLM3ZD1A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dirdkhiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22616C698;
	Mon, 22 Jul 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642278; cv=fail; b=qyhXFRDI62UwP17KcZOAApjezxtqldd0I0UDvJEgUseRU+dXvsshr9lT9CQtmmrjxn8TuCxIRooJdZHO1EWuAokR+eut9DE5v9i7ZOtC7pA5YNaIRlN8ki9NPh3Hz78q4gNj5B0qKpi/pLCate6yeIIm1DQu69983a9tn6LOnOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642278; c=relaxed/simple;
	bh=B5bYSHJCdu75tCCc94+IqWTT3qh3mb9pm/Up3m6VmrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQIGqHqF+RbXnz7arDjBTgoAB33QyGlJaElIe0lV6Oq1JbR1ERhzPBS0R+EcNHha/74UlVmYyeiYu4BimGEF2oRmuz9D5RuBEieY0R7TuQKg+Bu+9iBV1hESpa6wOWHihTwZiWu1qkFWqI/tcXqIM2B1AYZAanFWaK6CGTTh5Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZLM3ZD1A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dirdkhiu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7d02Z003160;
	Mon, 22 Jul 2024 09:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DI3DCTBhTLEkeigmbUVEz4XFZrGHsIeFwNY9PKQr4MI=; b=
	ZLM3ZD1AxdGbHWMyxeNBdOPvb9KkfC0ll8OMY+I14KlfsX+ymyYPAbFqCVl7h4Fo
	i2PPo3eUxOLsq8l2DrMKRJCI2kXlAbPkESDUNHT1BO97XxZgN42rCVlTi4WtKESN
	F2HQpT2YVntUvljw4nmbNzdjCIrE0t7DagrU9s5ueC1v55k2q0Hxqu59XvjvV3c5
	qIZa10nMAv7Gs4Y3rNlsZcKmf2kzuI2juP0mDRguONUTSbYVKTB/oh1fm5t1P+Rx
	ZtnenRLREKPPsXJDnqBXB/k1C8nerwaL2Klo0ZUrHEOav42XrkbFY+t30BOefVn2
	a8HC7zJ2pfwD+T4H2ComMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft096cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46M91hE3008950;
	Mon, 22 Jul 2024 09:57:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29yqfab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPnR/py77kkdBxim6awjZAYEKSP8+Fs0kSYf5AME8WyfbNUHZrl8/i5wmug/i1k6EWtqUjnZqOswmbuRKyo61T1SnolN15EIY5njIjxSAqcB0Lp3gBisJA2eNjqVKnKsrwqKFTnQJ8sVsy5JAGOzFP1f2VyDDuflfUO4lr/sv6EiGtxGgGmFNEZ6kMPlZ41awqNSCQo2J8rqMCbE1XwiTW61geuUiTWWe/hob3IScOvyk2jlBHuSJu0UxU9JUUcCds8fsMkb6oHA/QhpMasopcKezWaVqBPQ7nAkBDDgn69Q65mUND9PK2LoLBVOEv4pVKB5M2vKQcGSqoeKJwzlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI3DCTBhTLEkeigmbUVEz4XFZrGHsIeFwNY9PKQr4MI=;
 b=WuKG3UBK6q+8ad6Aa3mOezxKaWOMEyx72AsJa5kIa5sEKSox/+MedGtxZA1xnAW4On8QsbMsPPBAdaQou+SkPqU9iXWuDeu1VZrxle+xcMOoCVZD4iVS03kBWGCtbX8My480jDzZsQbDIIU4ZEXGUelooYEHOFj7VqWw11ExxqbGz/csWUVHLf6fHjqo+IvuT3PSk+opw5f/z0Gw2268N2+bHDxQlg/+XWZHZuMv4vGgB6ujoZO6o5/2MvSKmid7Ovucpsi2uI7bW810DnlqIJ5Dt/qJNOKUCKPdl49M4UHZMHDfZV7meiRojVLzGaDfq2MJqa+gAskuZGsRF/kC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3DCTBhTLEkeigmbUVEz4XFZrGHsIeFwNY9PKQr4MI=;
 b=DirdkhiukbZA1e6Kp5n7GEOHeGmdTOXBmio/ue01A+cE0K6JThoVXSaW+q6rsstML0PVfsB6aJ3QKsZUcWRvC7mChjWt/MSpavR++4ct2YqTE2SFwyIGokWSEx951Y2uRwqbwIgyPwmQcis/tzaJzrOTS1bmt63PUdPavNIUXz4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 09:57:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 09:57:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 2/3] readv.2: Document RWF_ATOMIC flag
Date: Mon, 22 Jul 2024 09:57:22 +0000
Message-Id: <20240722095723.597846-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240722095723.597846-1-john.g.garry@oracle.com>
References: <20240722095723.597846-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: bae33a41-0d1e-4377-4e4e-08dcaa34bb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mNTWWEY1QNT2LTCpaXDglWaOtr9kyw0+/kN4gQe79Ij7VzL3Q90vC22/FWCX?=
 =?us-ascii?Q?cxmoCUzP486YRD2vBIhdXqD6p+Bxt9U9rJFxuqLREueZegkZc0XPWmIXHGXJ?=
 =?us-ascii?Q?NrPcr/+NFS3nRe5JtC6dv7gq6JiwGAZfO3gUJ3BpTwQVnSDPyrZirBJHedtV?=
 =?us-ascii?Q?j90ib1fxu/sBCV5XPqnnYfDupSwu9CU+O1SXn3b8/nrZDySMHT1IWd4eDPve?=
 =?us-ascii?Q?UsmLmLfUADIu3q5DAfXRB6qI1eCv8l8JT9nd28nbzcm/XqG9NjCDcaYGOnjQ?=
 =?us-ascii?Q?VwfsqfN1w0vYuOaYwyXT/0YZrafm9BV2934c0BjXpT0pHPNySPV++a89XItk?=
 =?us-ascii?Q?KpCMfDI2U6ZsMrpq+eoJfUvQVBVnOUoKprYuqu1enlBB91x1YC7xyCN4rkkX?=
 =?us-ascii?Q?1zZvXxrXPlYY0S2jT7t7Szpfex4fiRZw4MEv6rm1HHwjEhu7sDUoaz0J3KrF?=
 =?us-ascii?Q?vIWd8y0nzM124kpsVLc74X7ghs2s+pIIYb7G6E+m3MpKasP+aQq9pxkxAtcX?=
 =?us-ascii?Q?Ayt2KeKbPVj8Fp/Eq5Sik0zXNHE0ds+l2CNfdNM+qmGc6LUjLI52oPFZKF4D?=
 =?us-ascii?Q?8VGad2tKDU9INw0q8J8EGKurj8YSC862un3PFq/SviK+ztobezjxnugS5/k9?=
 =?us-ascii?Q?K5+fmIyJ3vt8LQUeJCaSF+7HMlS39NS9E+eJk4HA2HEm9Q+Q0ydEj3pla23M?=
 =?us-ascii?Q?ceOCORKDa0TusxogWZtK++JPLtDslJFfMiivAQCzbOqRQGDGCoQnaC3vjFh3?=
 =?us-ascii?Q?KnMpZn+f3CQIgn3r+ooWaJ65PBnBg9GaegB9Dzb/1nlp9swUbgDH0kmrDJ7k?=
 =?us-ascii?Q?CJI0rRDLOwfKQx/gh0W0xL7M1snq2UJrJvJIsFv7FEqAlTcEU8FOsp3rtjO4?=
 =?us-ascii?Q?6RDSjtzH84e3FzpvS36VUiH7zUQnQOjGPXuqMnmUwuBBEW/ox8K+mg2+/KBO?=
 =?us-ascii?Q?INwz0L76I2XDCcJQ0YheOa99IUZN80M8RFu94qQcWkEtKtst93Sb4MyyOhUx?=
 =?us-ascii?Q?+QvYNXDSggaVgxvZTZmt0H77v+PaOEo+EWk0HnazcmsSvFSVuy6vOw8APgf5?=
 =?us-ascii?Q?vIOuj3sf+2AYIvNyJ+sEy9jprhf+be1uI2U1H5mfSGfZPnnT4AvkpU3UCp0X?=
 =?us-ascii?Q?3l4SankgAsqDN/Zcc+jR8MqR5L7BTie6kCuQj21K5GI40XfC33R+rGGtqh2+?=
 =?us-ascii?Q?EpiP8G209WaSsWCeN697VuNhnliky+FZjPiI9gla/pK9Wa1xoIAKtBoX4bH8?=
 =?us-ascii?Q?RvYo27lzFriWFVqxJyL/ldMKR8Jg6stfAwrmAv1/JyTj8vCUDqcb3tWySG5K?=
 =?us-ascii?Q?AqRCU4pMwEgywnf+WTgTdNv4CgSdPXYJ4HGqvS/f8g0e4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sGJFT6l+Rrul1i7LFgKqOyIsCLXIp635RbBeLkXo4fD8DXMww48Ty7NDrSr?=
 =?us-ascii?Q?PCnth8kCOBY2JnkaKGMlDWLPRqzIgy6lwovR2yBVEUU3HEFe8Z1Zm2dlMyvO?=
 =?us-ascii?Q?6BUvTfXKqcenXwtpzuhWuQjBuQoJYn8uhdKTWwhvdCBuUBdxAP/HDLzajnd7?=
 =?us-ascii?Q?FG5I9B/tYhtpIvkmHq+GN29cONDFpjIeEQqIwVhvSSwvv1evE9xEnjH4xB6T?=
 =?us-ascii?Q?Hj2A3gL/flYlhbSWIXYIl1Kb+Q2BAiZp2Qz69/bVbY1DHByyCHKcSjgyiDHC?=
 =?us-ascii?Q?hPPbynD8hRO+fBw9EazK1vJE0gxBr/FBCyn4p4nzc9N0sjRjP0hbnQNaIgcW?=
 =?us-ascii?Q?V+GNE9OIuInYXyNpMW+6m1yrp0H7gfN2RPZaOvb/Xm2U8traQhDqQfO0KQK5?=
 =?us-ascii?Q?82KPQ5lSFvb3jRNH7qY3YfxszMZqbLILnLfKVny93zylVdiFaEUC5yy/LYdW?=
 =?us-ascii?Q?GBqdXsb8k9k3u8OKJ88Sk1JIo6bWHV77wwOm6YHy7Ny7bE8N3MHea9zvtckI?=
 =?us-ascii?Q?u+8ooqhRuvRpxf9HSteZ8uGTMk/uaBlLemLBiawSwH7QGlRKsvF7iv2WLmfS?=
 =?us-ascii?Q?O5niDXDCM+JulEqOO0LRXLo5cMuGvJAHy/a42RhIBxIFHY2Nqb7979JK3g68?=
 =?us-ascii?Q?rxiO89ZWLMHuPKUoMDMjYUz8rcMPKWOcI9wtyA8lOoF4n8Mp2p/saAwrs5Y/?=
 =?us-ascii?Q?fDnvD6qRA310AOIQF3j18+7rOr0fLTgKIghg6BTpThkWgFjQug9Be75OA+rc?=
 =?us-ascii?Q?EqWWrgdmiUF7UgoW9e1qlDCxG6MeTE2cgoXZnAV94LbPegciGMriuqGxVZ/q?=
 =?us-ascii?Q?VgrdC0P82CLE5nzYlOmf+U3Y5fZhrTWn2tj/5txMc9WcuxaHbmo5gayjk2Gu?=
 =?us-ascii?Q?zeGRG31Owfpc+H7qcsYsVKg9A6wraXHxiCsFsr6FMsE+VPTb7Fd0fUAKmWcW?=
 =?us-ascii?Q?SCr4YdqLni3Fn313ZJd8AlL5A1eU1fg1d+HvUqN1bFyELmO7GXwiepjjd1nq?=
 =?us-ascii?Q?Q9NTUl5JDFcJgRuD/r7GUN1EtvLLoloRmkviwGejmW/g8s1KB3klcDma+HEa?=
 =?us-ascii?Q?GXTPQBFx4/QnFS07BZiRO4jyZ215bbSRJoCc3oWOOD57jAlQKKCPYmI9p0pk?=
 =?us-ascii?Q?wri/3WD53bMBE+PImJCWhudVUVN2/FvJO50O7uMndiN1nkLY9VBMZCg9kEd2?=
 =?us-ascii?Q?tjv/vuataVFrPQS+dLjOJ2rz5PfgpS3cgA/JOp2A0Ly4icGIwaIz0XuDsvcK?=
 =?us-ascii?Q?H8DfCOJP0xoEvXTEaWrLYYIpZcEX/kPWHP5QRBisC2uy705JnP+TSL9b5QPr?=
 =?us-ascii?Q?bWZQhOjS5NJQp+5V+SGFPe5wwUd3vQd2WXATXnS8qv+30FqCJyZOjaBJtRZE?=
 =?us-ascii?Q?xMi+uxVEmjXgSTb/2dkbbHzRhLrTSQ3LvJB/vsSur1R2jI37F2UpT21sqIQu?=
 =?us-ascii?Q?7/jfFomeysBxxu8XfMQCtCCbbzaiR44JKNMzf8zQj33vihb0WIo/TjrrQco+?=
 =?us-ascii?Q?JQSdTcimRrvcJIurkc0qortHw7FyaHlzu58XF0VeiCwNVFXMpWLOlsuTPOQ2?=
 =?us-ascii?Q?dpVnh6zVSnYOqfq1UxT4BGunqGHzkypTrCbhKA+VSCkjhOjbG6BM0GGiyaHT?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cQ3nyizxdyOuHBk+mGhfRl/EmKyLRX8gMxObYRoqR93WQGXVOMn/fFKJC7/jLNOfHLOyQVw6jT9s/+O+/BoLhq9WYylLagjpf1PTTuY/6v6E8/DNklo6patjoVUuG0mHlJ1yUiYdraAfvfBgk5I8IxlqwVykVM2O6Gy986ib3ckfqYb2neyAoZVBtmW/AKtQgwkl0rUAdoKKTFx5gCoNZfjE2Ut1FSzflife1reMw5V3nAOYtTaPexybpqMJUK6y/mQ8GxbxKLz8xSrdUuJ8KnTh8Q+AfsOAduRtQxk8sbGhPw7UuR67s6/BWeKCSitSzkPqhPFNUw6Gom0JGLEeZ8ejQ1P/yXPiIFhhPooMDrjNAMc3ixyyu8uqlXaJV/yoD90g7e1Xh5Fqlat1vjol7kMFe7L5vlufWsRSjhsYjY+GxKtMt9vXrkrFymqHoQvmmgm4D9qjxVxwavqNw4ah/YpQ4fdxI+QyWykB/GXGHncSlN3eCvsfRJV9C041ofGuKMqT8IdV/yb+ZSgR+floEuO+xwp4KcUElJowHm37SQys47s8ZmA3y5iVNkjZ2MJiSRoNCTTJWZI5eE8FIs93XeDzVRDOSYY4WidzXWUyecA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae33a41-0d1e-4377-4e4e-08dcaa34bb60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:57:44.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bxEiboGC9QU+e/G+YVMI+4KUCbVZJgmYfNwvwLA09RKKlRHK8bLi5KziyWx2ZFMsUGj4qlLDpvWHGYKIhlHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220076
X-Proofpoint-GUID: mdh_w7B4AZOq1ZHPpyncZEAM0dzKE26s
X-Proofpoint-ORIG-GUID: mdh_w7B4AZOq1ZHPpyncZEAM0dzKE26s

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add RWF_ATOMIC flag description for pwritev2().

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
[jpg: complete rewrite]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/readv.2 | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/man/man2/readv.2 b/man/man2/readv.2
index eecde06dc..7737eb65c 100644
--- a/man/man2/readv.2
+++ b/man/man2/readv.2
@@ -237,6 +237,50 @@ the data is always appended to the end of the file.
 However, if the
 .I offset
 argument is \-1, the current file offset is updated.
+.TP
+.BR RWF_ATOMIC " (since Linux 6.11)"
+Requires that writes to regular files in block-based filesystems be issued with
+torn-write protection.
+Torn-write protection means that for a power or any other hardware failure,
+all or none of the data from the write will be stored,
+but never a mix of old and new data.
+This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
+The total write length must be power-of-2 and must be sized in the range
+.RI [ stx_atomic_write_unit_min ,
+.IR stx_atomic_write_unit_max ].
+The write must be at a naturally-aligned offset within the file with respect to
+the total write length.
+For example,
+a write of length 32KiB at a file offset of 32KiB is permitted,
+however a write of length 32KiB at a file offset of 48KiB is not permitted.
+The upper limit of
+.I iovcnt
+for
+.BR pwritev2 ()
+is given by the value in
+.I stx_atomic_write_segments_max.
+Torn-write protection only works with
+.B O_DIRECT
+flag,
+i.e. buffered writes are not supported.
+To guarantee consistency from the write between a file's in-core state with the
+storage device,
+.B O_SYNC
+or
+.B O_DSYNC
+must be specified for
+.BR open (2).
+The same synchronized I/O guarantees as described in
+.BR open (2)
+are provided when these flags or their equivalent flags and system calls are
+used (e.g.
+if
+.BR RWF_SYNC
+is specified for
+.BR pwritev2 ()
+).
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -280,9 +324,26 @@ values overflows an
 value.
 .TP
 .B EINVAL
+If
+.BR RWF_ATOMIC
+is specified,
+the combination of the sum of the
+.I iov_len
+values and the
+.I offset
+value does not comply with the length and offset torn-write protection rules.
+.TP
+.B EINVAL
 The vector count,
 .IR iovcnt ,
 is less than zero or greater than the permitted maximum.
+If
+.BR RWF_ATOMIC
+is specified,
+this maximum is given by the
+.I stx_atomic_write_segments_max
+value from
+.I statx.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
-- 
2.31.1


