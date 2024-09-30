Return-Path: <linux-fsdevel+bounces-30331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C94989E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5968B1F23631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B518990B;
	Mon, 30 Sep 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REb04Jve";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SHExCieI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465D188739;
	Mon, 30 Sep 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688184; cv=fail; b=gGwruJ5dAK7KJD/6d/ZCqMlhZ5erFgsjKSlJjfHXmt3Uhq2hnoGKOoXDNxAixG0FIiTpq7+WXksyZ+sgQi59M4rGJBFivhVpUN9QVdWo6162gj1Oe3PqXutTpcrFusyNSQfj50q0duK+pCvJkT23cXIGBAXnubFmdyf+Sffena4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688184; c=relaxed/simple;
	bh=7fwbGByVMqnoEagp2Br5ei9A5v0aAERUCSVcJthsAZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAw4gRmAdSEQqME9taQL+haA1fIq5BsTDlSEe5K9Ffbc8P3qMqWxQgezg6MWJlKLZIYD1VgH2jsiGDs06+oJyCKJRUvlaqDBKJYY6kpfD+lK2u083/lcWeseI0Xtdpdw5i8djvtIusOpFYZGFI3Tm2OZapUb2PxFLetVPdp5QNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REb04Jve; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SHExCieI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2uIuQ007117;
	Mon, 30 Sep 2024 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LxIwM5Kze2ba8NdY6DiW5Q+trqcF92YGIvuODcHkpVQ=; b=
	REb04JveKwlwnsChJNlJgp/MufFtd7/+ki1BOKHh3dUK11MQUwQ5VO268zGT5IoM
	uvuShKwKD9kUq6kP3efwghWpSiyusoykn9Ijf4O3ImlNUmBR7UsgwO7PxRbTPVR9
	ptW+fAVj5PvhFGXLeosdQ1clr6Zf0Ul9h8ARwiKrtuw12+pP25WUIZTsNBfgoccY
	udy87k8XIKzjRN8xOl2tTsR+ASGFlub3ewMdxHi9LB9Y8NKQNPus0EjZU7oqcv4/
	DXYi1BW3PRt/9JGdp5EdYeYd9/xQwln+E4+p37PrYuwTFYFDoW5T8WK3pJkbcBD9
	x6dPvZ9Svg/cJpfGBjrKoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9jrgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8HwFu012532;
	Mon, 30 Sep 2024 09:22:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885hj7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 09:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM/raC7iCI4P1nz+v0ATq2uExqy9de0U332LxZfjbgwtXTZtwJMSmzeeGwOSfdoLC6Jw9+EkQzitPYYhXshwq1/gVJAK6iJ8TN12u+qiQKpz7muGmhH6bcPKnFeqx4u1lVJLARJcxyKDCY9GQd+lvBm1LwBv2g6fOACPde+Fy28O4eQ7vz6W9JTS0lAXSVYWgtIcIbt8I+pl+jQ1/UdLDn+d4OTIt+6u//wPTvF88ScCp9srQQ9rYTewhgIuJ6/TN0/3bpQYH9K/smWNxeuoR+MAQ0OMjBqfpDP0cCpmDSrR1MrKFLeTSiLF+O5AE7IkWd4aSaCRXGN5+6WmfMrpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxIwM5Kze2ba8NdY6DiW5Q+trqcF92YGIvuODcHkpVQ=;
 b=e6C+ZrqkZM5XpF1pGyuXwfhRUb0tHQXgXMQIjIvBSwn/Xa8766aTZXQ1I0Q04Tmnqyf4P40hUK9vUDC9YA82Xa+rfqmIvaitJuw7MNe5B51HN7V6HF66ugpkfG4R9Yo/mAmeaEAb+9iz1Bf/6pmtEY9kil0CRBBIBq7o9FTWJf/RvqvAVvGajiRryy8DZgJix5deVtDPj5yPcT3721qpvoVEAkZOgjA6568ATC2PyqLb6eMV6wExOToV+GfUdgDoZ6cDaenB4Iy0n3UQhBbDovyLZXBlQD5a+6AhwgKMYLK7ECT6XpjRRBWdQLcVz2o25zbG7AthBXOESZIt8IS33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxIwM5Kze2ba8NdY6DiW5Q+trqcF92YGIvuODcHkpVQ=;
 b=SHExCieI+ZYEpupbXCnZ1zG8KQlMiZ2PY50x2dZD98L+pnUgDpef9U4N/rcAJ7ayP2Bu2kySx4psb0p0S3XYZoQIcQy87sne3Yu9gIB2TdfpE3wBeIix17ybBGBdQn9tbG6CDtC5meOR5sxhmb0y9QaPK9q9fBhl5eTaVHVLlRo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8134.namprd10.prod.outlook.com (2603:10b6:806:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 09:22:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 09:22:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] pidfd: add PIDFD_SELF sentinel to refer to own process
Date: Mon, 30 Sep 2024 10:22:29 +0100
Message-ID: <94c6ecc5c659b54f62fd7930dd9026a7ebf8e53b.1727644404.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0544.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a5d1a1-dac3-45c7-ccb1-08dce131723f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thuhJbQrUhdUPvtpypibyeQHQ+4hbkKBASu28CWcfeYuiVSeKm44lvrbrdan?=
 =?us-ascii?Q?BlEiWZCV3fc38i2dDcg/7AKFYKep54nJyWppnwFvLwC8fgJAtKRPQUMfgV9I?=
 =?us-ascii?Q?Z/VUnRJd2027TopWlnb5uwnveE3aApOxh3s7wbeq888sWVinpUUe629EiNll?=
 =?us-ascii?Q?IQL6CgX6awTpBRzgbSLVPY6FZUo3gvIdiOdn4z8TzD36ccTJHNG8mO2TSVfK?=
 =?us-ascii?Q?X/+JqZjNreJzLYtz3WFvEcSua05XW5B/929+Q2Ti79EWV8zd+CauPNUunafI?=
 =?us-ascii?Q?DdWQhjFdfla1HJpxWXW/5yJdQ3llDgCbt2FDppTMWPMPrVdUmPhKIPNks9eT?=
 =?us-ascii?Q?dObcqYnPx9mmhX1vMqZO41b91EFiBhsqmd8bHtoZFD9V6QBWTSXGWhDov/+E?=
 =?us-ascii?Q?8rBE0dbi5TxejhFZkhVQi2xCPjbjSCpECxA7LiKEyBf8q4SK3fZoYX10+bHH?=
 =?us-ascii?Q?vGohYfL77uHh9jpvZaX7oZZMsDBWQheyKn4jsrWie0fFyQYf+wDLH+/sokiu?=
 =?us-ascii?Q?iqLqkbNbLPV1QTEsMVKRveCq6M7Zj8iJmzzF6YMYiD7Ak+7cW9BYDJwRGA3h?=
 =?us-ascii?Q?4bUd+DpT08f3GQ2FuNiqqmVO0LaoX53wWfI8qQFlB6/Ok+7i4B+Yt1OwPoZz?=
 =?us-ascii?Q?ww8xPmqQtI1Jh5F/nV/XIJnXyn1atZvYpKsgZQcnEzvGb3K4w5SaXlsS4Cr3?=
 =?us-ascii?Q?v13ZCAZOxexNWy1mkCmWs5Lohb0r8FUELn8FwhPzDtMNX6eQ4xtVGjObuOZE?=
 =?us-ascii?Q?W/JS5eeKlv28APjyM0W8XbNJKcrms7EBpwCT082HQeWznyHtpH32inn+CMzZ?=
 =?us-ascii?Q?DUQn6NOKb3dL+eSXuH3ccAsbG6Bb42gxAfDauDHajufiqsmJ+3DZj/9o8tiw?=
 =?us-ascii?Q?BUyVNPCcIYJWpcOmoa9Gr7ai+4C2Jkd3VLmPFeHCKpggvR0YwoW/WNoUT27I?=
 =?us-ascii?Q?al+AImihWhuKpii3WVrXkm49Yinye29RM/EwLv5Cjnx+YnJNH3EPIOPOl3ff?=
 =?us-ascii?Q?v0pFbvUsvUR9PCzIzKyQRmLIeG/SDv52tRdKzv7a7GCbbCuHXA80jkweQ1v+?=
 =?us-ascii?Q?hEk9f2+E7hRHYJEeWtcmskbywbqD9/um9IBXuSyXB7rV/8DK5RaM5u13XVNM?=
 =?us-ascii?Q?/BLZx+cYtSuYr8HY9c0RocOhTMdt+RA0h8ZowVwwReuy2AxEhdpTqCtedfH9?=
 =?us-ascii?Q?htQQjmxOlRSpakopBiOCFoML6TrBOq/HLChroHxrr3adaNl58/UqJvSABGFv?=
 =?us-ascii?Q?DgtJ/En4dOiv2NmHPEPOeq5f4S/MhjULJ2V9VJzIi3kdfa60WLIpQgPibjdn?=
 =?us-ascii?Q?hOG/VBiLCxMjKEn0I+VZfbURayg05tLkYkXg0i/ri1NfFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ga0hg48hbSWkwI/Y163CPMVZySp3BJNxU9tPGRtGFNNvHpI10tyGxEuP2sz?=
 =?us-ascii?Q?ISOzIg4FnctOUrlIxYSNv7A7U/UiBZn7soLx4pPKuu3pTBkYnEov7jWSxpRN?=
 =?us-ascii?Q?s6su88bKrONzkEARrej9GuGiVovRP58ywahglZdqCZJVYaekWhcd8sakVDoz?=
 =?us-ascii?Q?KVFtctMwZHLSUAtIkTC/8LOxL9uYHS7fwG/YT5kB80/woZvntg9t2jb0RydN?=
 =?us-ascii?Q?Fo3GEa8Qf1EyRGnAte2UvYMM67scRBhObhufdtRphWVZw3FU1xSBVqX1koLa?=
 =?us-ascii?Q?/G+yyA4vWVanwJ7jP9rChj/gsuYbhmwvHrw4udgoA1Ne3OwWQ8oOFHLrbAXm?=
 =?us-ascii?Q?Fqf0s2wouxtvCKwh7MQ9zsGVqIGvaK05mCpdE9uUVG9qzhE6ZY7rVPIn6dt9?=
 =?us-ascii?Q?FT77aRSmi9krHvy9vPLW+/Zxdwlzup8AKBBL8kqnvOp2tdqrhm8P93uTBH4V?=
 =?us-ascii?Q?kMee/yPCyJlYampIa0lI0T1Lks87Tt6Ft31QVIFVz3KiSrCQIrNf8i2NWf7p?=
 =?us-ascii?Q?lLQj56hQcYrIhQRJHwQoPUd5Gy7QS5qWeKqgPL9Ik9eX4gsPRBOLMqSfpu30?=
 =?us-ascii?Q?nbKGkLF9h7GExjtF5Smtg4dMlyAktBTwH3wzh/0rlgHu+nsPXHuJ7jJAyV6u?=
 =?us-ascii?Q?nXFN++xy5QYmUOegXy+Vg7riOjXnShXZoyDx7jy280P7rhMd+Koa0as5SlDC?=
 =?us-ascii?Q?z3tqlFuncaP48ENNQUHMhuwIDek/fTpwvOTbZ0mbbYZ0ZIsz6PHenxiAsum3?=
 =?us-ascii?Q?LVIls1yG6eIv3bSIdL8ESuQCAgiWq885oGaE5pWcMVpr1Lh/t0BEQG28TmSj?=
 =?us-ascii?Q?ZsGqdeRaJm9xi0b0yO8h5zH0Tk9RQcZwLSy9VrkH3l0Bk5ClRCyGoicC7YF6?=
 =?us-ascii?Q?ddJ577QC3LKviN7mm++dFbA70Btb4pFS7x5GMMGNYudrE0R69dbrwaZKOaxj?=
 =?us-ascii?Q?LFvpaeA96frd3BUDNaL4kcdVUuWCbyBHV7WxLF9jipzDYRmscFt+BEw8BIDB?=
 =?us-ascii?Q?SEK0a5KjAonKSeiTcAPjzvb3BJ4IG86PzRMKmAQ3Z4E/hZvqD0uOkeka7zR7?=
 =?us-ascii?Q?aZIL5oovihipKH2zZhhjdBIpelHVqUAyEKMcfSdQD0Fq6Q120XE3gUI2UV1Q?=
 =?us-ascii?Q?2gKMvrJ8UG+mHEK9tUq8dc3kl3v/HQEdxqheDjMUkTc2v/Ja47O5ZyzUMnSV?=
 =?us-ascii?Q?tDupNy8TO/jQC/8kjQZes54irHy/DC37E+88yFWVQLtBoHFQiynAPXSAAdoA?=
 =?us-ascii?Q?NmxAnDAb4x2+hEH3d2llxBPpmSiicldx/IzadFg5qo++bkC5njWcqFnrvSgP?=
 =?us-ascii?Q?F41BJ2PcDZKuEaj6ed+qA0kLNkGQfhyxNJiMUHOcbMgK8Ni8EpLii/G1UrgZ?=
 =?us-ascii?Q?BqFju7+Do9NAtMfwsx5k5JT2Hp5Bg0vzu7L1UuzaoDJBQwxdhu3I/TxCWY0R?=
 =?us-ascii?Q?V9nptJ5n5B2fan1ETOr9yvW++C+A5MoS6XiZUkD6jOBwN0DXL2tYSMQIQRHz?=
 =?us-ascii?Q?U+KZKtk/QbFJUydr712REPwwhzYl3s6t29VBoUfz+z1F3SvpGAMOpAg4N7s9?=
 =?us-ascii?Q?+wznSlIoUdh65q1VmOXZjWKUzpTZDp5oLW+RD6VBo+OuM0wXeyNKXMGtqGUh?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IWZkln30y/V39w5hV6+shYF7rqiuylKpvk7a/ujMMGU06uRjPKyH2aXZrVhShg5y5iypvR6jsaMfY7TL+MPPRdr5A+02aDyMt13G2y13rj2U4UzGkCHrvM74LQ7+IfoOVVNcwziEOq0eHy2CPI9grI44JZrhPIXOV016eFBnqpG69uNtastzYrLzES82lLhFz/bFWPtSyIheDYhKZVHPxp09hXqq1M9nNSC63fl5UJCFzU3bl7haaw9tC0JKS7itzEvsx5aFZg81gMkSiP2yoMZrzbs80Lk2gGL1kdBmAj0GoZvX4nXOQCdmyUHD/hmfgGTiqUg1WGw8rC3xtcHYgkfBPjT1/t1mAUi0l3nXf8/xL2BVI+TvuZmSLZsPdYvdwsV7NZ5SS72nwLjnSRhz9dTlqWCN3fZ/yl7UMldS688zamOU3yQa+cCabsGfH0XLMMBUejYACcHZqTe1P0HKKC4bfS5MyUE3/lxybmTqDbGaYprLPclkm1XWymyS8kaQRRiY0stKzUNty+cAGr5cEfW2mecPRsPF6i7KOqOoTZmHSTRd3vp/EMD1EXW7cQmZy/IKnNV3cncK4eCXCX8MizfxP804cGrNasBrYdxafoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a5d1a1-dac3-45c7-ccb1-08dce131723f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:22:46.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI6jjyFtNygk+ZNrzpHm5nVsY9mHRRH6F5zCiWFS/nJlGisrjScO7i9BLvzcVR8dcCZjmAC7/wZ2zMLblT1uucLeFoS+zjW4z8Hot9a8D3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_08,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300067
X-Proofpoint-ORIG-GUID: HmTzf8z58VrX79xxr4B79-DVZ-sh1a8z
X-Proofpoint-GUID: HmTzf8z58VrX79xxr4B79-DVZ-sh1a8z

Add a PIDFD_SELF special sentinel value which can be passed as a pidfd to
indicate that the current process is to be targeted (as this is a process
from the userland perspective, this means from the kernel's perspective the
current thread group leader is to be targeted).

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in this case even for the current thread leader, reducing
churn and avoiding any breakage from existing logic which decrements this
reference count.

In the pidfd_send_signal() system call, we can continue to fdput() the
struct fd output by pidfs_to_pid_proc() even if PIDFD_SELF is specified, as
this will be empty and the invocation will be a no-op.

This change implicitly provides PIDFD_SELF support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  9 +++---
 include/uapi/linux/pidfd.h |  3 ++
 kernel/exit.c              |  3 +-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 63 ++++++++++++++++++++++----------------
 5 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 68b02eab7509..e95dd7b81ae2 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,18 +77,19 @@ struct file;
 /**
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
- * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ * @pidfd:      The pidfd whose pid we want, the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set, or PIDFD_SELF if the pid we require
+ *              is the thread group leader.
  * @pin_pid:    If set, then the reference counter of the returned pid is
  *              incremented. If not set, then @fd should be provided to pin the
  *              pidfd.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here. If PIDFD_SELF set, this is zero.
  * @fd:         Output variable, if non-NULL, then the pidfd reference will
  *              remain elevated and the caller will need to decrement it
- *              themselves.
+ *              themselves. If PIDFD_SELF set, this is empty.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..0bff5276b51d 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,7 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 
+#define PIDFD_SELF -200 /* Special sentinel value which can be passed as a pidfd
+			 * to refer to the current thread group leader. */
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..fc10eb2b180c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>
 
 #include <asm/unistd.h>
@@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && upid != PIDFD_SELF)
 			return -EINVAL;
 
 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..aee86fcaf670 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
+	/* If fd is PIDFD_SELF, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 26e2581210c4..9c037441afb8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,23 +539,28 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 			    bool allow_proc, unsigned int *flags,
 			    struct fd *fd)
 {
-	struct fd f;
 	struct pid *pid;
-	struct file *file;
-
-	f = fdget(fd);
-	file = fd_file(f);
-	if (!file)
-		return ERR_PTR(-EBADF);
-
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
-
-	if (IS_ERR(pid)) {
-		fdput(f);
-		return pid;
+	struct fd f = {};
+	struct file *file = NULL;
+	unsigned int f_flags = 0;
+
+	if (pidfd == PIDFD_SELF) {
+		pid = *task_pid_ptr(current, PIDTYPE_TGID);
+	} else {
+		f = fdget(pidfd);
+		file = fd_file(f);
+		if (!file)
+			return ERR_PTR(-EBADF);
+
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
+
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
 	}
 
 	if (pin_pid)
@@ -563,18 +568,22 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 	else
 		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
 
-	if (flags)
-		*flags = file->f_flags;
+	if (file) {
+		f_flags = file->f_flags;
 
-	/*
-	 * If the user provides an fd output then it will handle decrementing
-	 * its reference counter.
-	 */
-	if (fd)
-		*fd = f;
-	else
-		/* Otherwise we release it. */
-		fdput(f);
+		/*
+		 * If the user provides an fd output then it will handle decrementing
+		 * its reference counter.
+		 */
+		if (fd)
+			*fd = f;
+		else
+			/* Otherwise we release it. */
+			fdput(f);
+	}
+
+	if (flags)
+		*flags = f_flags;
 
 	return pid;
 }
-- 
2.46.2


