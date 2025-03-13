Return-Path: <linux-fsdevel+bounces-43925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F054A5FD4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA3019C2274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBE26B977;
	Thu, 13 Mar 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PViAvtZU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3Mxci1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D826B94E;
	Thu, 13 Mar 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886033; cv=fail; b=DCb2ui89mM1i+HvmOFxbcJ/6ChsIYZHbdC6e1pcwkUuG9RBz0YG5L9doJN7VAMueAcOXk3x73nY2fjUHZjbKMRZUZiDqt2EKctaTwlXjkyOcl8Cm7Tb6aMlsjpsJlthuiFNhpI72QQ5VvZ5N47Iq3wkhCrQgxLIfEsW3Em+DNng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886033; c=relaxed/simple;
	bh=EUU0Cz2CLDePvVDv55/5iPpikkl04WiLSLOYlvSLs/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqd8wWOZrci/FjbULgRXomMviaVFIn6URfE7iS2jlQNOMlQO1JkodJ+ovUzbRM1Sy8dBANhz2vdL8s5HrFJWNZOkgU40kiLgYHwgFFc/hr1gJj7tFkL2D/kQ9Dy/mUh3t+x/5pe+K+sdTvRQNeaHTfoUV5DXPYa50pamKBJF3R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PViAvtZU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3Mxci1D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtuQT020758;
	Thu, 13 Mar 2025 17:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ap8mP+KyuOB9iTjQ4+kRQyXqFhY8+A2ERD9SWrcwXnM=; b=
	PViAvtZURQZU+rV43zJtnD7l2uZXPalgOuPe/NbXtfH3LnnFUV9kFMlcERRtq4lU
	QGDydONyT1XFczU6onKN4B2mzIDpNEhI00OjfuvmYdGdekJBbrJOqxD6qeo+x8Ei
	4pfinrSk3h6IES/WGC/pvV+6isnVhPKGPHelnncEbaJxnh3rlRcDacCYFXL4eoCk
	l+/zC0vjX2kBrAF+KFVNHR4vc/M6xy9JIirCF1VJheTMoLtc90DR6USz1fFRI0eM
	bNNpUiNFcbulxbb8I2pVDHGfI8T8Qs+bZmoKO88cuYw5tz8eIT3pzoz9aTCvhnLa
	JUPtReIJ7Fnnh55sb+Fkxw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvpx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGXaNK002204;
	Thu, 13 Mar 2025 17:13:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn90p33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIjsRIAe6BC48TgTxyNOBbwhlyPGcFCVG+m4duJqyKyqsBMn7EHdozxR91CqpgOR+jklAP6sM6dFr3ObH6iK6XDIvEXglxcl6K6NMypYKyB0cq8iHNc7XXzr5maH5EUtxcPTOICg/LcRpvMYEKJMDnG+It4KlpHOeb2XmHmno/12IZZO9OToNK+xs2vrPnVUKNYwqeWOZyer0D0eITojvI49P2CdwsVuTyRt942xpVNaqkHvTHreEPHgwumm3nUiIG0bNJZB9GhlSMUP0hShOwVU9CrWEszT0VZw8F8XalVcStlV1tWXu40Z872cp9k+r0o/DXJBIV6clOm1o/XZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap8mP+KyuOB9iTjQ4+kRQyXqFhY8+A2ERD9SWrcwXnM=;
 b=d8kvVrsH3cdhwk6PBzc9OvGRJ4cc7QkTG7GkNYRYsv5QMzGJhRy9OQsO+zQl/5cCU9uzD9zrRQjJOVuLUeuXnRoO2Rutpt823npvTh/BwL6SToaXwuqX3HcWYLLKnCDVi2bztfIa+EuDwQ8tVjNwiNVwL22hQ400BS+snPqbfA8MvhuYZWhdZS9zK8Fw2jnu0zmV6KuV0aEf+hNktP2CTptln/Z4MX7lSfA5cQHANpdDEZnV4UYazFsBM62EnZbmLknUWKZf67HBDyC1mIV2Y43Iyxwd6Z6eQrfv5o88dsw27o6aIwKDz3FwFlkPq5a3ipJX0WNDxDgVVVsCDZdIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap8mP+KyuOB9iTjQ4+kRQyXqFhY8+A2ERD9SWrcwXnM=;
 b=z3Mxci1Dtw9y4oT3Hu5Y8x++z0yrRwEZvH8p/gBg3po2CZ0PAAY0OUHdHgA6iB4qJ5/RsfS6imvTKL5QJVbFFLPiSFZgklPxFm+m0yHSDxmhTos3+p7CshRKBQwGgFMJLAPJG+lvpI+iIA4WatCljEQ1HmmeHYZJuLUhzbLPFp0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 07/13] xfs: refactor xfs_reflink_end_cow_extent()
Date: Thu, 13 Mar 2025 17:13:04 +0000
Message-Id: <20250313171310.1886394-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec4d80f-a1cf-4a1f-364f-08dd62526373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0GebzOm13L8XsAqMjQHiHI/nzsws9txU7Vl3awlX6HK56UA3GvARS95bfKnv?=
 =?us-ascii?Q?y7OH+KW8Q/dn4lWLWUfSS5slbsllGogLJYQje8hHOR3imjpwZxQzjI8abM35?=
 =?us-ascii?Q?0k55HYphr0JdmWG+IEBmd7VMvgBe8ey++w/w/ZtXQX7esRSsJpppBkVXH95H?=
 =?us-ascii?Q?j2Ee+Muu0C5T4CdOfGL+Azvp/XYBEF6Hko1NXn0vVP/Wc6hzp7Tlk4EDEYpQ?=
 =?us-ascii?Q?Lb8qSxbA0fEi1zMEspB9DIldgxuttw1IEzSetW1UgNHVWO5eMR7SNpAtipCj?=
 =?us-ascii?Q?Bzlo/3opENumEQw0BZSxAH77jJn2cJ2OX5u/rtdEdoDi9hkXTiEenX7Zd57x?=
 =?us-ascii?Q?mYl/8KqtUMfuJYl2i5ygbbMRonFqA0xF9hmPtZXqfB9Bc3M7JsoW77m0iUSG?=
 =?us-ascii?Q?qcb+bkfaNgCE6z1rYYnchOrUR1wks3dxkWUDUPKBXBdhGDNyPkidZcvFkECz?=
 =?us-ascii?Q?Dc7TMMnKKXYEZxU1pT/UyannQLYuO/QrswhDNaUkpwNyLrI4Bp2bKxhf66JQ?=
 =?us-ascii?Q?FSErAaCyg4KRliE5bELb7Fzy079j01bfdLOEsjltIHOSxTvGaEPwvp3NfLiM?=
 =?us-ascii?Q?o2NdOf+ElqsHxDzE+0otpNT63+Cd0NanXZqC+vbbs+LpzKAqm1+q4AFEeEk2?=
 =?us-ascii?Q?9UI110QhpErhn1xrtl+9GvHB+kcTEAAsx1Imy+FO6hCKp0SU2q560dtWUdtQ?=
 =?us-ascii?Q?KGrSYnCePd7ZpU0odMuJqbCynRixo5hBqwUOVG/c9KPSCphD+oYBJ4+zlLNv?=
 =?us-ascii?Q?dciWZJFzMemud22g2POMoWjc5qI4vpcDhAEquDNNDsmVQrRqv6V+boRr6QBH?=
 =?us-ascii?Q?eHNItkGuTspjkdSjXhJUp7Me/jjAG9quuYv36zIfXDi+QScibXVZhy02s8wI?=
 =?us-ascii?Q?oHcAGY9V1Rk/gG9i0yfIdiELtqedBLBtvhVBl+/YABvOxiTjf4BBX0i/vhsH?=
 =?us-ascii?Q?d3XC7n7gW6wEMsoNHF2pnL/0h/rvszNzuX4walpN0YrUI7U0agrnO9IzUxvI?=
 =?us-ascii?Q?NMdQzZCfAzIjhlrmx3Ylyfu4fhSXPGjb/Ru58wmlpbNy1P7oqNKgVFeMKexg?=
 =?us-ascii?Q?p1Trr3m+wt2sVCwFWVCUp6ZhQ6rUw+PUxOkzg3QwB1uNl2V74AyVX0plMh4D?=
 =?us-ascii?Q?dat3MOWvruInSBqHPh01NlqB5U60BXzDEZgWl++8WQ41mB1kLYhvIlVi2CfM?=
 =?us-ascii?Q?aWiXfyixy6XCrLRgAopEdcJO5+34hQkESTdd50z59lupt/KEbuiJGNQY/Pdz?=
 =?us-ascii?Q?WBlCj/Ez7ZJLexzVtT3gtZCgcKEj5vfDWrs6sigk7mvfElBzhODBQmoYpO7p?=
 =?us-ascii?Q?pRUtWrHt8wRi67iUzflqQ0zrlS2+692VkMaVyfDIo8apbRTqevwYlrTdaDr3?=
 =?us-ascii?Q?z7Lpi4p139iiDC/dZKNZRif7JNp7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p58E+M0iuh8xYMSS43yhIRyD8BwfGGglQtDnqNERCqgm1ziMjSyitf2qBeFe?=
 =?us-ascii?Q?xFvgNFbFmTP5pWqZ0YaK9uqYYMgyg6xdXDLjFD90M2Tj9DahCFzucgz1tNUG?=
 =?us-ascii?Q?icGaJrSKFtQKTZ8SS52V62jB64qAitMyzzHaJgExb2gw40ERutZ1yh0lYdFX?=
 =?us-ascii?Q?2JGhgZz5Vyvu0h4BkYw6FM3+MRiJRLr+dnGoDbmxOdfD5asJPrreo05hOJVT?=
 =?us-ascii?Q?dTQ48XApeQTUu/7fe6P4hk3uyGhgbFPnotPyYQMCrhTEJVN4jio65wCfqIf6?=
 =?us-ascii?Q?pYBgrxdrty5v8HceowKN0YcCm0po1eRq3j73mXqzAGSltT9XNJUsUx9mYetv?=
 =?us-ascii?Q?IeW+42fvO85jGMoNc3HOTjZSCEpRdHP+6UU9zb9aJWhMnAsQdIJG4OvjPCAl?=
 =?us-ascii?Q?gNjtinK0UXygZ0ltolQmca2Wx93dPZnvZwlMuAo6ItheX1WjOzM2ZtfOmDbp?=
 =?us-ascii?Q?oEP5DuXdwit98pt6affWjG9Pdv9phJimie1U2Ollvq7DC6sJG3z2ahChLnRS?=
 =?us-ascii?Q?f+wIQQ0r2ouOnBWgDQtQk80VOZu1LGsrukGzradgwC5+3fWXP/PuXzblyQ19?=
 =?us-ascii?Q?OQ+HCiXsXmBdW9gsbWkRGdRzIKv+WrhBm0Kot8suedhCcx4bnqQ6XzC2dlZ5?=
 =?us-ascii?Q?e4YJU4N9eheCGYY/FxYZr62AJce7gtokLdhSPorfSlUyARqEVUqXBGbtFbtH?=
 =?us-ascii?Q?hfgpXKt6MbKsT23X4YOWO2qZlhKZpJfVdTZhFpVnugscXMZrnV6KvXMUXdRE?=
 =?us-ascii?Q?Q2GUvolygBiQ4fZram9XvtM1IDckju0vrbDx7862LJZ6UqS4zjn9UC16JCvw?=
 =?us-ascii?Q?N0qUacG0bUUU9RqJJqnQkClaJC/aFXBDnfnSWeMnQrR7mMOChCw9+k70QJun?=
 =?us-ascii?Q?2vZ9w1guSJe0QAoOFpNRVbSfq3cqBgUVVXi93b6jZtzZfG0wu2uvDEXAErCu?=
 =?us-ascii?Q?Nu1onIoC+zdeMi1d+DCzyEunTFa8MkbtvZHDp0DqVqDmXXWLcBoramqplFpI?=
 =?us-ascii?Q?+6JHfE5u98IVHC3tOkxSpmZxETP8Mx85IiBIvtWC4Ax9m/pDheLGPtH3KUgc?=
 =?us-ascii?Q?sAv61JMjz6d7QZSkN5/pEZBrFaiUxMYmSzhdDszv80Q3lXobvFg/uBkiXg8w?=
 =?us-ascii?Q?lIblKR6apNxzZcml/uxcdyZUVrTfURNviDJ+P5awMTk/UjtUjrJtK7xFtGbj?=
 =?us-ascii?Q?ccyoRxwVwhyXpk7vExgRInVryXAhXTz8rIYVcpVGQkOo44eYMDmbMRAacZrm?=
 =?us-ascii?Q?tljjz/wWUrsV3j2aWUaYgI+gzuZwFhtlvPqkmkS+VFrxxL+xUDec6AHwqu43?=
 =?us-ascii?Q?lQ/NnV9qX8uUpyx+PiOgYuxpG2VIli/CPPPcBM+ixqVtxIfsigQETLh41Bgp?=
 =?us-ascii?Q?JduXb9zXUeuTJgfWycPpHurE5dFlsZA5WxW7R33qXd4L/JH0wRH3eTyopuEX?=
 =?us-ascii?Q?c4Lf6eHcoTbOqPcQcxq1v5hiMuLHTb87TtctmcKPMJvhwqCY9X5m/RmC6SgV?=
 =?us-ascii?Q?A6ruka93yGeOmlBu+7k3QKCFzhvpC/Zn6f6/sC4ydFs6HcKoECae64kYRwWA?=
 =?us-ascii?Q?9rfIxT1x2c6to8ZH6ceKUc+YXrZjK//1tIDsXjNUtMkD4GhSzz4pXmInZt7w?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hmTkNVTwBd0zxCb4gAXT+XvSph2Ihd7mN1A/QmOyhV8UWq0qdPtW6iITvd5Csm9K8LWspPiesmN0KFZJNwdPMEQg4Xt37lmxj6Sqm+zfJ18B0pAGuxqANhts6BqX6nHK0i+AFXqDbMboteEZbkPO7RRz+TAD5LcFiIzq3igxd1sg2MIDrqzCVKGLMtU2zkBPHS60iDXXElLHfCpG47CxrAz0/t2enjp+tL1ztILoMFCu6WrWZ46fi/djlajhEDV30thgovca2qAGFsOfWkR6gOpBuT/4bRh2xNVOZjP1irzukD/4kR5WCS473EMTIiolSB8dVgwoH7eETuhOPF+9R77/vaY9cuWxBuW4RB8xTe1aCVzYel/u3/XTznTlpBkL3dPpz47yk3Yud02d0OlZ6c95JIHpK2Q7yqjt3jOdgR3SjPQo6v/15Tu31FFvPL2dVO9wH1kJBVNbza9o3j2q7HdwkCT5usrIIiR2GKG7clGURm8NVj4fm7CbO1GkeV2GKgqrtrwzIcqxxuICgZnS2gZXO1pYG8xH43sL1QoE+Jw2vpUva7uETYbN1yy+LAFkZFNzS+pCmLMV33oBiRotUzvict6UAFDpexsLc5PriT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec4d80f-a1cf-4a1f-364f-08dd62526373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:35.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqvNXzujlqrhf7Z7hzDTQ2YGdqzkECVVIUGWLft+c8fQqNjiLhw3IWJm0cgYx05avu6d81xiUBHihxEiUEp3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: Ci0Ie6R4xB_E12-3yjIVpqDW7BqVrGv2
X-Proofpoint-ORIG-GUID: Ci0Ie6R4xB_E12-3yjIVpqDW7BqVrGv2

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f8363c6b0f39..674a812ecb4f 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -790,35 +790,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -827,7 +811,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -841,7 +825,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -850,14 +834,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -886,7 +870,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -903,17 +887,46 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


