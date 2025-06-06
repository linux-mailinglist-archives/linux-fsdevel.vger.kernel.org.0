Return-Path: <linux-fsdevel+bounces-50798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F06ACFB1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDA16F612
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 02:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49441D7E35;
	Fri,  6 Jun 2025 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQsRtXXp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XHW4woIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3329A2;
	Fri,  6 Jun 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175641; cv=fail; b=dW7sQHcnEuK/KM+x9WfrEdmaKE8r2KYFpECmyeoDftLiDKZjywd5+rWKsH7OAbLPqRYObQ1X2+GUPSAUQ6Bnulqwi/JuNaBT70lHtIzX+mOgDEtOJxHfLoji0jHNZdWPMvVHqueK4wkmDJDLmQxXPk7S2s9emvuurYGCmZdP85w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175641; c=relaxed/simple;
	bh=tyu3ZZj09J8HcL8m773xjplp2Bcy7Lm5cXXlbr3L6sw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bSCgK1o3nngWNULgBiWfTuK9bV4iRS2GzrT/Zw4ZhIvYK3sa148IZ1EkYtYNo+B+Ivm4DNXx83TsYGwgKlHCFvHtfs2ka+Gqvn/+6FGDkcSGVjCKQtq+MxRau3uWBwx6S75yJng/pbui/YCWMoQh9ntH0OBTxulIf97k28uHvt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oQsRtXXp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XHW4woIx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555KwPjY012785;
	Fri, 6 Jun 2025 02:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PehMEh9RUNB2zizzzL
	pXqmT8jkZR/T13iQEVP9MyV3Q=; b=oQsRtXXp6tBL0NSgJ5Snhi3ADinA1QJTOO
	5Ztj74Qph56NWN0UVWadzveTm6Lxk0w0aJl4LulMNj3kjSJlnQJ57EJEAIakRy24
	eo3XTol/qHLgGIwOOeBTkDEXHfb6Wt3dWfA9b/KSztnz1HJPai66e2M1eLPGvW5Z
	ww81aBbfS0BnGJ4eFv8/XAW/uk4PKrKxm7E1WCR2GhiCuO8S0ezJivxrt7NbuiqJ
	m3HFWobOg9vifg7CRI+JnjRwLMIseUIYvEQ5zR7M0U+ibbA9X5/D5jM9xU+jJCVv
	X7V2AyU4SzCfl+/qD7/zcZaSuDdMGDO+bRadC1NEHCAdVMIy0n7A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gf4pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 02:07:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555MsS74034879;
	Fri, 6 Jun 2025 02:07:05 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7d178a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 02:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buu/8uwvuOprRYPqqMK24SffeW3Ulyqbx23V2rn6mTom34ZkbAVqZtXjlOYk9XnHKjo0kIzPQ8tfzt/naa5dOZDKYR/CuiyPE/lDfLcKK9T1edLalQiXjdR/a53HGAwKeMEZheR64sfdB1GnpIjm20Vda37RsScP0qEQ4sagPatFMh6hX/p+IUf2wVKbrwM5aKXy033+E/NTfRXIRo25VcJq4GSTujHhjpFWCBLbq5DZJHppE6TRsbstlVgTGwvPNnNyT0+3l8UO5ygqe4DmjD4aVsDVUJNR0YZ6FJqe1QuGWl97c7RYPlR4OGHkD7HTsTage0IvjhP6gc8k2Xy9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PehMEh9RUNB2zizzzLpXqmT8jkZR/T13iQEVP9MyV3Q=;
 b=hyzvuZbHAWmO/w8l9e1rQ3nz7lHSLihKtlS+lFTWj2gUJchDlyM1JycQY/JZ3nY+VGrjYbLqOcVUAqSXuRfcObgweqZ/Y9WzotmGKhFGEa1OTyiKtnWYnQ93+3GnbmT3ot1aKpKMoFksvNJ/zJklaNh/meA12/N3m9q9QRBQtdHlHJi3c4fd4+2ba3Mfo8732vGxCX2Qd6I/YWzLRv3P7O69QdQ00ry9NBZAwUxxASDUAdnhiWLWDcDcU1Npp2lSJ++7EY4vGn1HwzTXMCWGT4QKKDAtZoblJUAiytb3F0/+I/8DdENCDHt/ZbWNkjWTnkkbngww6beKUxr86ydkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PehMEh9RUNB2zizzzLpXqmT8jkZR/T13iQEVP9MyV3Q=;
 b=XHW4woIxYyPNTozEyEm+qXnfXQnElAHGVh04fGKHsZddIIGA0pkgnpDnDVFqYy+5ggHHkHVtbTiiep4ZTINYfdPdPYxB6QtgyMVutqWElgpAvoLRSQDyohTFvR3re5c9llxR404J84UCP/s0x3L7lfv/y9VLrD+8wlWUMo3Cogc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM6PR10MB4217.namprd10.prod.outlook.com (2603:10b6:5:218::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 02:07:02 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 02:07:02 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
        adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250605150729.2730-3-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Thu, 5 Jun 2025 20:37:29 +0530")
Organization: Oracle Corporation
Message-ID: <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
	<20250605150729.2730-3-anuj20.g@samsung.com>
Date: Thu, 05 Jun 2025 22:07:00 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM6PR10MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a470f0-fc14-45cc-3ff4-08dda49ed3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zff4sb0j/R37zysWvvU0s/zFWlEGKFRIXnrwhuEvbO//mGx1QBukD6AA2jgt?=
 =?us-ascii?Q?U79pzCVQU/Tyquz+euFoVPT5JJOhsq3MKbOZllwSIdIhV1gvWhwVQ/eyk/kA?=
 =?us-ascii?Q?QeITeJJjAivZec8scLz+NxpxYg+heZxgn1iru0Y8yp/HmqiktPOQOJmNHuU6?=
 =?us-ascii?Q?ynpvdy56FlrcBifh/gIYPuGI9XEi2G/dTG9GUE5d8Ns42hUWjBHwee2ahQmJ?=
 =?us-ascii?Q?gYVE+HUzsv8oRVW2E3xUQC9nOgGaM6FHvHLPpGgaQoaRVMnzVtg7tPMn1ArQ?=
 =?us-ascii?Q?G44ZUp9Fb2BUolYrO1vVMAyVqRiGrj2K+2ucDwfXbtMSSq+m0csczP+RahEc?=
 =?us-ascii?Q?IJ4aPD3WeIDLSTqzTjP6qrVD8pvLWNay5lyOd3sin9gB7nEADSC+70Y0OLk0?=
 =?us-ascii?Q?FsOEXyfB6164dgPPZn8ESl0E2JpTCUy3UEPBkWxA59lQAiajnnsiP49tobDA?=
 =?us-ascii?Q?ljqcNmIiD5AlfZx8dJYg00a5h4tsOIO62XyDw4UHrD5dI3AH5TXM2rrQN12p?=
 =?us-ascii?Q?KQBz3V3ycA6d/k8/Nb2cNfICrdVLYh7rOmQByFPnz309OOzvUSpRgrfF5f+v?=
 =?us-ascii?Q?zBUQNSglsopw58ntsDoawKfZ6joXnsfUiGzQpfozRFN2SwkyX3+hyiC8tRCS?=
 =?us-ascii?Q?fPISTh/QWhx3XIsOKdSj6sl126Xno/Pr/0WrR8ZD8ODQJB7ctKXOnxNkZDGM?=
 =?us-ascii?Q?LoEz7CVCqW7z2sxb1ffDZSGd70xxKVywVUsdFuWXLuDTk7vhSQy1hTbMl+Ou?=
 =?us-ascii?Q?rjCW+u5IEcBNZE1+JAQdEt1N2iALbhoU8iVL4Ts6aOn0dgG2wddInJVGcWnt?=
 =?us-ascii?Q?BYOGU8lMwzOSmSmm6+kc5iLlZ0fcG2UauIwYwH9kJh/HV6V1EbqrUKcEboum?=
 =?us-ascii?Q?A7dPSc3X4dLvRrTMMTn36seA/m8pW0BSt4JQK43KyIS9fiZ0pP06DzEltiMN?=
 =?us-ascii?Q?ALixfiBVXU+rbNVRWPbsX/OH88wOHYoqWFsqIUeH68J0VzLwOdh9upzGZcHF?=
 =?us-ascii?Q?64v5S8MUePK/4aqNqMLd5eyOfjtTwrDoH6T5iuYEbCQfVJaRnVQdhkyADVgU?=
 =?us-ascii?Q?F0XzmsjDE2xYYmzgWZzvH//B4yMeAIertLwCMqPlFDfDeTD60PhhLatPwC+U?=
 =?us-ascii?Q?HRgMLJhwK5nRjOpYGuoN0bHw7SDWBLOuMDvo4IhxPQrMFCo6EJl5rRzz6Y8Z?=
 =?us-ascii?Q?wNx9phbV3OmhfA3KuMazshDVMB9eO25oCIlSixVDSDf9oU+CjHY6cHZdk/Js?=
 =?us-ascii?Q?P5CO4vq/OEFV1269XYHPqlUDW8A3YrzNIzagwkENzgLubEOXn29c+RgK0gEo?=
 =?us-ascii?Q?U9tr4WSUwTVxvBJZ/i5CY7gVqVzm8qM3QQTUWLdIzBA3fxbCzg1Y6cxAM0Yq?=
 =?us-ascii?Q?VhorEdK/aO7mFc2oF7FG9CbhYFZoIHIR8DraulCj3Wz9HrIYsUZX7MvFoox4?=
 =?us-ascii?Q?QestKDyejx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWQ86Ub4nqFuJeqLTtlQn+PMIrnVZ4+8Y5N80gsG7+uCZjnswtHD+eL4NNmg?=
 =?us-ascii?Q?j2OZF3kwYiCh31GxWAcv1tJUHBWUDU+6/gO0vkQUJbs2bJuN+NYVFH7IYGYO?=
 =?us-ascii?Q?z1Rzr39c1ycF6jhHR1OMRSUfxbC73rmlcmQfKavE/+VFr45nZBleTyC/oKiO?=
 =?us-ascii?Q?cp9rZEeVwsmK8ePES7uJL99eCDxzc0xcdExnc7FMdDC0W4ndOmZjCNE9CWWb?=
 =?us-ascii?Q?t6Epw3N9QNcAXsT1Gw6kOkJ15ZXmxEyO/1CIItxRniBzUYbM1ay2PuQWJwrD?=
 =?us-ascii?Q?7Hi4Y99WPqtXV5kQmGpB5ZT5QOSav/WhphfGrl7dyzq4WoE0mj6vxIzZeR8c?=
 =?us-ascii?Q?9lZ3t2pHWT/dzIlQL5IVjWBjFbagaSkKFTvHyhCO4i30jZ/2H6f6kX6os58G?=
 =?us-ascii?Q?WG+ZC+S2D9PmT7/RBdxh+/GR3OmKWFBF6nFtQ0Z9Hq/45FHCBWhBwK3AIFg8?=
 =?us-ascii?Q?bX4c9o4W1elEJt7pK2CLMoIUrDvyy3JJJoEYS7O+imi+fmlhMeb6NvnusQHG?=
 =?us-ascii?Q?2UQ724idIEWaN5V38rNBhgo7dHZv1n9vevDNocvvfPwP6sUvnCtikR60VVwt?=
 =?us-ascii?Q?JjHyHpAFTkQbEfosqkWXGmK89GUlpB33dBkRWwQntmVCgYLj+8bP6ODBBlIY?=
 =?us-ascii?Q?hwc2mUAkSY7ziT9JqpXnCM+QSWAG76muZScfIWmNk1tt7ilalPkWZkmmEtqT?=
 =?us-ascii?Q?n3d/yl5fV5FY5++faTiSj3J+9QeGjzAvhC2jci6JH3xU/LPqDp0Hxpz0rdE0?=
 =?us-ascii?Q?JWhcqZOO5ysGWm8yXarWwL/X5+76jgDaIIuO+KxBqKfZeu5GjcFKvXbMMUR4?=
 =?us-ascii?Q?0Qi/nPk7VH7H2LuXO2bbghPxidveI4lqfGYX0Tkr8NyZOhsbSwvPtBjxdL1X?=
 =?us-ascii?Q?Z1muZYa4QHOPWGSy7Eb128yHG5it50vCjROGXz+H3fuV2O1JEeseUPqceEUl?=
 =?us-ascii?Q?WJm1cQyJalLmA59ZU5g0vxKCWG/76mZ3BEgthM7lU87I7Cewd69HXZAjsBIJ?=
 =?us-ascii?Q?TZANxkr1TWynhCzHd1OnxCdOxzLumDIGAtDWEWSqhFoukz9mNU9qf2iyZbto?=
 =?us-ascii?Q?QVXMtW/jZbmc3/B6j9rF+p9UfuLo8scddZShWgtRyd6vKiOiPsC17VcZzJXY?=
 =?us-ascii?Q?yltzCwddneFA4BDc01F+X3BY9+gy3X6pCs5thymihtw8mgwRDVdhfrk8LJOr?=
 =?us-ascii?Q?Ry1ypc1kio1HKoIyhjk9s5EiZJkhVNJOwWKDoEIv7+5Au4XT6XnKfzpjZzVo?=
 =?us-ascii?Q?C9E/qn3eXMnzi8YKuD3x4EpniJ88yBb1Ik1uG0hvgwgZRhesQOH2PK//gV/q?=
 =?us-ascii?Q?xdtjZMfD7VBBGXF8oJjC0ia0PwRGpa+6YBmpi2+9dU8o2lpgDDWcO045jEvd?=
 =?us-ascii?Q?JebT9d5EPeZRQACGFHrtrmTGJ3AHPx/SScyYNoEhl/w557Urgdm8P8TjD+ze?=
 =?us-ascii?Q?smHgzmWuXI1F8fZ8AnYqwuI4UkDC6pXuK6BOqgAB9OucDK1v25g+B92zmyc8?=
 =?us-ascii?Q?6nJo0uU2xL/Vd4UDmETprQRVurIB5e/2lRbvxJafUVari12eL29VbN8dpQTH?=
 =?us-ascii?Q?9ld8I5r78YECteoY4T7bjnRQadRb4uQwekxlabzEtKUYXX7B3PO+WEIEuWPM?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zwcsxpxw8Vf+8vybATwCAxtGbUMWyCHp1Aiyrp6z6P1QrbTfOAT9c4O2ELnwmEToHh7MjbW1O26jLTvJEW7Kj76zwfDZy1/bcYyYVR5zsb5S16IEiG6JT1I4dNsLGnI3tEAIiNopNgl71UVlJJZsVx6lOkJjXt+Vrg6gR85NNN8dt+sl6ZenlWm1t4Jq5Z8vucaaPinKl1XFRhufaxtUZslPWbsr7MPi3ca+GOSKlfADFvMwArIPHFKAGcw5mRB8mbmeyUjhmmNGuga1NEkEky7ijNhf4GFlrKT9rz9MyUUhVslVTsirAWXVjvgZJ/CcNmKk5XSb//H0En+WTkliPdDxZn6Jnck0Nf6xUfrQhWj+14hnvEhV09OcmijW0uZseYK3GJuWS05O2Cg0f02XVm4Uyxyb4I2qsuFGSs+uBP0L3Bs+qhe+Bu3x9ZrftTUn4MhQHDTTO9B+zqLPHnm/TqfPMGKDa8qHomlj7qxbm3Avt4aCV3I1hhZbCuRTkERW6iFF2ag11mT0pWFPXMUYjDKaf7PkWHvWFpCiCKi7jilPsiRmF/ycO3gy5n1/z3RGQDt950r4inpl3B8SUPWjHhsVuEFDBttR1YY2KQVicx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a470f0-fc14-45cc-3ff4-08dda49ed3e4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 02:07:02.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8gmDkWNoxpyTFZ3uv3k7cT6UsW9b0PJgHVMyvURwux3adRQXt4gWldpcHccvvCNiEMOCy24aIyTSCdONnqHGEQsveHAU/ukVu9D7W354K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAxOCBTYWx0ZWRfX27casToO29Re XVLmc8PRn7TUEJo4OFGudnCGH3KuGlh9294mNd7Dof/KGHPUpM0N97oHKeIXVA3j4pLHbWVmLUM ykdNwNi040wExnGl/eZF+fSNhGWTUt3nDk5kJiHlohxw5fODHEVWS2SeB8LGv+Xzg4KbNBdIT1v
 swJY12fpV8Ut5BH7qZK/MYkbhBpmTvrxvJJTkyn+B3EVz5XWAm+OwQ0lapNMoqVerSOH1dX12as x001VFnej19oCSFWA7m6fkutccsDBoAo6qj9yiV2NwH86y1NsTP7+/JBoYgC6jZQh2gq4AmQi1c 3rJDvLeksCTTrfri1ZZSKELHG7JPJWe7GDwMR6lnmKmjPwtCMTRf+momdR/8T4zI9GIUtOl887i
 1x1mEh4x67FD1Nbwj1hI53H1JcsSCui6VQnV3hiRugCyjtyFhRB/gQ6njfJTcDmNU1OalKfG
X-Proofpoint-GUID: XnSnAZ4uP_kGoo3KGCej3G3ZCFkpofLv
X-Proofpoint-ORIG-GUID: XnSnAZ4uP_kGoo3KGCej3G3ZCFkpofLv
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=68424d4a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=83ZMCsI8JKvb0knCFyoA:9


Hi Anuj!

> A new structure struct fs_pi_cap is introduced, which contains the
> following fields:

Maybe fs_metadata_cap and then fmd_ as prefix in the struct?

> 2. fpc_interval: the data block interval (in bytes) for which the
> protection information is generated.

The data block interval (in bytes) associated with each unit of
metadata.

> 3. fpc_csum type: type of checksum used.

fmd_guard_tag_type

> 4. fpc_metadata_size: size (in bytes) of the metadata associated with each
> interval.

data block interval, perhaps?

> 6. fpc_tag_size: size (in bytes) of tag information.

fmd_app_tag_size: size (in bytes) of the application tag.

> 7. pi_offset: offset of protection information tuple within the
> metadata.

Yep.

> 8. fpc_ref_tag_size: size in bytes of the reference tag.
> 9. fpc_storage_tag_size: size in bytes of the storage tag.

Also good.

> +	case FS_IOC_GETPICAP:
> +		return blk_get_pi_cap(bdev, argp);

FS_IOC_METADATA_CAP?

> +/* Checksum types for Protection Information */
> +#define FS_PI_CSUM_NONE			0
> +#define FS_PI_CSUM_IP			1
> +#define FS_PI_CSUM_CRC16_T10DIF		2
> +#define FS_PI_CSUM_CRC64_NVME		3

I'll be adding CRC32 support soon. So maybe make CRC64 a "4" so it won't
look weird and unsorted in the uapi.

-- 
Martin K. Petersen

