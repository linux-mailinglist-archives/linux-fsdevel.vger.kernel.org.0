Return-Path: <linux-fsdevel+bounces-31623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF9998FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4511C23679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682511CF7B6;
	Thu, 10 Oct 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bzzjo22f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0A7uzA93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4C1CF2A6;
	Thu, 10 Oct 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584178; cv=fail; b=tXZsVfHwPYMhGI3J6KSx6k5Aquiq5I+eKGMdlBHibQipb1mJuV5I7quhPsZ4QnkDj62dbnOMC8R9kKzbOnp/sAbAgVde3jBCp8UjArC1etagNWEItE5Ztq7qahVeYx0O+KJnyw6cvdvz5LBVWJgWAJx4MnbAzI7X0mS2OlB1Zis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584178; c=relaxed/simple;
	bh=b4YeloLLv2ivS4l0WI4P7BQ4ZHCLYZ2BMz1SoAHMszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTI+rO159U2p49QgrNelfVXVMEcixiPsqG3dtMj9lh9F0TLpmdhOqYWuCh4qObFQTeVUI0fOSXojqGnsdwvQLtG22ne0MMeFLxZhZl2JFAwSUIm1OQvV33gx39vGoIhLQRF0Pf39IqBaCPy6eUX1Xo8CsNAOou5+a3rzJjgfeCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bzzjo22f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0A7uzA93; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHteBk008811;
	Thu, 10 Oct 2024 18:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6KeT6i8tSvadI47e3vGCkdV91NduoC+jrAaJ8w45sK4=; b=
	bzzjo22fcrPELoKIfCRPCd8QAClNSxcm1WrwRPaXk9TW6cY5bYK8ABP1CE9xSOlf
	UbP99R74l2VnQ0ZbFMLPPMMz50VNogapsxy11gV0tAaplkIiqM2Srq89E1tt/fdW
	EzGPR5xaoIrRrzsNy/6s+84txdpUPNFA/KdxnwvaErG9q7fmzQTPkBNCbyFTh3HK
	JjP2YvMO/IyXcJC53YiyHGt/91sLhleBl7qViUstKuPiMdTdEYqB5zvFamN7VDlv
	lCZOfUgvLQpUheIBt6Cxct1E6wPbgKQi2aIKZ/V6kANJXzIA0wJJpjBu+DccaqSA
	KCV7etwRaNQjti756Meqwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ykdg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:16:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHG4jQ017547;
	Thu, 10 Oct 2024 18:15:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwag77j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0L80BylXFRn28bcjsHwhRu9w/9R3JXRprm73lS5BlQj2WWf5g1GKYK9Bha/ruAzuaz8GKtZwcNvfPMWNIYv5JJfM3ytN6fcKKMeW/qp/vb0MdRWs68kcQOzuTrBqQ62vb+NYD/gLQBP5c/Yef5Ac0pdVmIg/Ct1um1mGVtYT2jabx0GTlchdOwxWgDpFC0y0lTo9w+myS9MlCziMqMnQuvEnOzD4jgOsTzQ3NQOgq1i59Xyz8LIefZC+1WltXNlUKJphoESUs2Z3UqvLG5ucbfl/JryrR2mjRxJ898lAQb0ErFBUPQkwk046JYUdTwrAd8wlsUuTdtDgRm/Tx5+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KeT6i8tSvadI47e3vGCkdV91NduoC+jrAaJ8w45sK4=;
 b=EfD2tO2aiplInii5tiQSAEAd2gbs/Lh9oux5gpID01mw2w1Nw7L6H50Y1Mg+rYu4DrBYpf+RQy/9SJGH8Dqoa67GgiLYHUfF1M2E5F9rigOv7gLYKcBlcUVeJBkDcIs0bFkOVofKcqTBIpx0c6nNdXgbD43Q2hou7BansrfPi68I4sJnMMHpNvq5+BRISPHN/sWl5NZdTWflEJ8SafEvrVf4U6zz5ODao2P4aAdB6y2dawCygUE6VYNI/fGCSzNvj0/UCCU1+ROavZNvQMXdc3uQzbqEgVFHqif3sSoXyMU8zxIOOd7W708F4IHLEqMKT4xzUM6dQlz9gZTOdZ9kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KeT6i8tSvadI47e3vGCkdV91NduoC+jrAaJ8w45sK4=;
 b=0A7uzA93YAFAZhDos8CxKpDnCfBZEUyKBmN8lOVGolkYnUpd/s3L2L937v9Jfpv+FZ1Xkb8ZnCPE6HsrvOIZRZeim7Spl7J0voKuvQJF+f9LJTcF0iFBzuH1FrZHf3h7VOJVVUn/oYavWwYjABW9INNCL7kVKh4SNIueK3dH3HE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7826.namprd10.prod.outlook.com (2603:10b6:a03:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:15:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:15:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Thu, 10 Oct 2024 19:15:45 +0100
Message-ID: <8917d809e1509c4e0bce02436a493db29e2115b3.1728578231.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5689e1-eebf-4793-fe98-08dce957962e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XA4/eo42Ihn2u6uAUycXFriAdpxUBTYQR8v7t8ze+ka0cUHhn+V6ovuqmwwA?=
 =?us-ascii?Q?ubJkJfqoeMMtB6s1CK9bzbPoS3R/eEG7Q1GEdn5OjshffhCCQscSKeS5r0Gp?=
 =?us-ascii?Q?QoMyBpwXAmRfCE8+jLxnpS2E2hQlAV/SidYg7EueQG/b+TpuQHk9oSxJ5kUi?=
 =?us-ascii?Q?kwyrVK6gHzI3SC9rCZ65vsmCKOz3SIZ1rbE6Bw737zEMDegz8/lwKL48qleK?=
 =?us-ascii?Q?X8AsyH5BBeUV1rGZwcnbcmj9Ry5a/2bFZGdiOHXg6zqZ497GW2IBz7mc8yLI?=
 =?us-ascii?Q?vInyALSvk6bm6RHLXx6611BmJijZgAv1RbueIg/0bRmvvJNoTycWRTVbzFMK?=
 =?us-ascii?Q?5JhWhu0ZN6kSnqmhLEOofFCnLOJfR+CP/KgLAv8Z/UOKO/cEZdA1Ls4VaKCW?=
 =?us-ascii?Q?/lqwnnNagKXeMB8hecEM3XsJreU5KlcENkOWuleoQ6J6Q4Oko/LvSdObMR5J?=
 =?us-ascii?Q?p+Mrxt0NL+19is3kjy8mBQmsxMZ6jVDtC8z3g+gnGqGtAg9ehGdtV/2+QPjy?=
 =?us-ascii?Q?ZMbOd+IDdQ2/e0BRha/G2uon2/ZMd6uVw+w7m1JPUzmY6oy5KnX3EF/EParp?=
 =?us-ascii?Q?fNOUfZzDBl8nZ7UANuohuMVNLYwr00EAwwLXakMNv2tCmXZ8XRnouxyJpRxa?=
 =?us-ascii?Q?Efjr67rXDhcylHuJd1/iNNsV3thhueC+YCVYP3mWtW0/CWqG8sU69j6HH1hA?=
 =?us-ascii?Q?59qkpYZ8qqVPxTSF00+rPjvhdzqUSUZrGissjvS1yU7zX0Yxyyj0xm4awGw8?=
 =?us-ascii?Q?W2uPo4dxSWaHBA4pTBvRFchUHP1UKU9NCfEjIWaKxfX2yH56YalzORT/G4Lw?=
 =?us-ascii?Q?Z/VrytA9T66eB+Q19rbvJwAPpiM5HU0M8p2BadtExGyaT2DBrvqlUzGgt3eI?=
 =?us-ascii?Q?X8VokGJ5+OzB51ua4MvnmT0KfD5jrkLl9wrryQd2xGHS6nu5wRyCIGdVIodH?=
 =?us-ascii?Q?y6IzXhRpWyCAI7FLlKHZptRM2S3VN9lCWW8DPxv6x8CdaBri7gNbYLxztt8w?=
 =?us-ascii?Q?nobNw4G/4bUfuAgj63EKJEhC8eTyN57LM1yZPUo334PFwIISGGCDCrosfQHP?=
 =?us-ascii?Q?29XQ4aCYEi6VP6m8Ok5h+HCedKCZJvDauT4Lc437y9Hdj2JCHXxCBBtpFs9H?=
 =?us-ascii?Q?ZH+2Hz8WFlVskaML3DQS2Jqco0jwsTjpWyn2cqA7mytDUjNSkOasBuXroH/T?=
 =?us-ascii?Q?2d611kKUdkzgFqMicRgPVxC19XXht0Wu4L7dYyclvotUk+/PFaomKLsB4qRJ?=
 =?us-ascii?Q?tk/RIZXoHr+GBLZdc1/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZ/9TgNW4Kby/JtQAWdROsI1nfK1BIE3Etdg8qa776xMoLnmhtGtRwXhn244?=
 =?us-ascii?Q?p86gA6yl0sLuapgS/WrNNqblR9Pom22xMUXCIdegFwqYiip4FnPh9UuwvBaQ?=
 =?us-ascii?Q?GhjuhK8SBPYhK8WrRCHyzdAg4dYD8S56zGOiOjJtd2IQ+1o8xBCrwXySFpC8?=
 =?us-ascii?Q?tLJpV+y9V22jg2aYReH8/tAyq7Dufh2Tr1MaZ5caWjsyKM3GwTCgTqAiqiuL?=
 =?us-ascii?Q?LVM2pbotpgc0eDf6McXxBXtS22ZPRrfXutc6AjM1nIVYgolvmk1Fen0V3hkI?=
 =?us-ascii?Q?iWcoGipOszef48zmIyusSEqFKCtLz+pfIEu2DSiyUAd9khMTIdiWVo6xAY4k?=
 =?us-ascii?Q?HbrcC0AqWJJAYE/cfx9HK5VR5fxDPK0vdv9/24LFtbwrr9KqwZBo2ZuLJUon?=
 =?us-ascii?Q?Cw+yxWjk+aDRag/+IAfF0tA/p6sf2OmXLNrl167yyCV4RWfzlb9yz9ATTScg?=
 =?us-ascii?Q?T/ZwX8hwQ5IiuBjGb1hk088Ot9Q5XnN0JGXZa+3t3UUSlOahQBfG4LUax0CA?=
 =?us-ascii?Q?XrHEQCyDylCY0QnEzZ6hlo9xv6uPlxhuFe9NyFsVsXa1DwA4sz6ncQNlgE1F?=
 =?us-ascii?Q?TzEZ7NvQ24Pzya5/80s3kpATNSNzDkQLvpy+swzbkmz6E8/1BdAZRu5MMHZN?=
 =?us-ascii?Q?Z6RpNyTIu44LEJ7tfNQ8NYbWE2Xvk1HInaoS3QSvbW8fpsmPrIkrbQRtbu7i?=
 =?us-ascii?Q?o9hpDt05aOZ3tQrfsxBHAkohN5rX31jp67+sS2YA+17HdtE7UmJMBaReSxm4?=
 =?us-ascii?Q?e+uvpz9iyGkDSzlqXiNYmrtsgyZhybb4UnA29RrBkjVl64vil2rdqpZ8N/0h?=
 =?us-ascii?Q?tXOwmd0MCqPTT4BZ2mm10dYTJk4vEexVOHjYDC6yJpw1gIs0t6vs937U2Phl?=
 =?us-ascii?Q?mNGkjasYvsm7js8JL6Bwjoick5n/dt74dLkrAkKggw1fGEBMf+6Kg1bNd3fy?=
 =?us-ascii?Q?y/gjvvY9wRii3PJsqJdhO4KtHEve4/x1Vx1/zRhKZzHuBoNXHBCkn8ZXR9By?=
 =?us-ascii?Q?435kGtqEHKjjvf0kiJF+YrXeKbNuYfyCPTZxhXsDhAc58OEEXter7cOMLHp7?=
 =?us-ascii?Q?ocE6GwiKQRWkm57V5Ytf4RU/r2ZC3GfHGV8+MO0SmQ+fUc8kB4xa8BMSemKF?=
 =?us-ascii?Q?v7kqSU3vPmOJ5Iy5WOuIPYhXkGYt2sg/57GLMV2wt8PwdaKdwfkdik5NAlCx?=
 =?us-ascii?Q?U/HLYIIddP0un4V1HNZfZ9VFYxQqQZN3x51I+fgMbCa7JVtQeaJ6GogHDCDN?=
 =?us-ascii?Q?+t32Mx9GYt1xkgGFkYYSgRGBzyL/fw0S6ZoBlHf3Il+h9sp9suvmlHoz7xj3?=
 =?us-ascii?Q?YSwo1g7EFFGpZh57YEiUDHlHvYvzowROujjAKto7AHiwiNZipxdRzD9fBNYz?=
 =?us-ascii?Q?qYEmhEXO+yiuVqCffAwaw/zIXOAUGfiOZJ4pWKVXH45tqfC5uQewPm9Vckt9?=
 =?us-ascii?Q?tn1ILnh/MWW6SUwafXWO5N8hYJA5FR0cUFyucZe3qeFDE0AGbMjpG6wGAzgJ?=
 =?us-ascii?Q?twTULH/Ssn3d4TSeWSetUT+iByVOwB6FsGS+9s465IGqWcS9mv52qyb8Z1/T?=
 =?us-ascii?Q?a/w7ZnE3iee/KTjArjzadloeGVBQOQXQBe1qTZULiG2MWY0fPyqRfyjuso3e?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EMsnoFw0fO7BdnJYjFD1TXrc7vDhFP+d/0WpvOrpwqZb26lBZYbttdnIL/VPoiVbbkuQn/7dDiuU6j/X2Ni6zGLtvdd0XjpZgXbaxBnbA2Q7i29rA0TVF3K5tHX/4h0JpBUE/TTYLJ0MkJlr84DybnX7eM5rLVv8ygtkQ7eCYWYVT4u/Rm03Sb07rhCFkUai+Goa0qek+h1IdASodF54mnwxlVCOV4SoJqhptCSSb4VwLDMmovESG3S/DzZw+nmNXFfREtKl1dMP7AZMff8eqJOLI/tfXgIm6fQZxPqPoVyVWVGbUXaLm1RAURYVHtH+Ez03vpSQKLD147Ctr2TMpkgMESP0mZIzxncTQ8tgvGOer+kQaJaQwVsECur+sK2yenPL4N3C41IY8IuxG2G5Bp1NjlY0WGvoAniUiedEJrcuVvkFMwa9MKz9PIVPW7/ShleiShDmRGTXHTEcHWGYkJA2RpVRB38ycIfQJwAC+fRxlevzZ3Lo3fewfI0JgI7+tHKayfYimR9zTW4jNgh7yqhjsOnyGzEIxn17mf0pOHud8kbxlPir24zdc91KOhX1YbCXRyrP8O9KGcxk511uqJDgu/GGn/OcpL6g8CsxVr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5689e1-eebf-4793-fe98-08dce957962e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:15:57.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a+212iPYmLMB6RLCo7n9NvR4Tu5FZw/bLMbSaoueVNSnxUbWZHDEFimYbKUi/t6WdKOhG4a8p5Hm730ToYMiAQcCyk7xuUpKeHYnb4yen8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: aUz6TG5t2AsyeymEqq-se1F8tLCe3v-S
X-Proofpoint-GUID: aUz6TG5t2AsyeymEqq-se1F8tLCe3v-S

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   8 ++
 .../selftests/pidfd/pidfd_getfd_test.c        | 136 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  67 +++++++--
 4 files changed, 213 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..1640b711889b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -50,6 +50,14 @@
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+/* System header file may not have this available. */
+#ifndef PIDFD_SELF_THREAD
+#define PIDFD_SELF_THREAD -100
+#endif
+#ifndef PIDFD_SELF_THREAD_GROUP
+#define PIDFD_SELF_THREAD_GROUP -200
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..10793fc845ed 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,89 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int ret = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fail.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		ret = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (ftruncate(memfd, page_size)) {
+		ret = -errno;
+		goto exit;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		ret = -errno;
+		goto exit;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		ret = -errno;
+		goto exit;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		ret = -errno;
+		goto exit;
+	}
+
+	if (memfd == newfd) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		ret = -errno;
+		goto exit;
+	}
+
+	if (ptr[0] != 'y') {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (munmap(ptr, page_size)) {
+		ret = -errno;
+		goto exit;
+	}
+
+exit:
+	/* Cleanup. */
+	close(newfd);
+	close(memfd);
+
+	return ret;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	ret = __pidfd_self_thread_worker(page_size);
+
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +349,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..ab5caa0368a1 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	ret = send_signal(pidfd);
+
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int res;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -74,17 +106,34 @@ static int test_pidfd_send_signal_simple_success(void)
 
 	signal(SIGUSR1, set_signal_received_on_sigusr1);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
+	send_signal(pidfd);
 	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	res = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (res)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, res);
+
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
 
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	res = (int)(intptr_t)thread_res;
+	if (res)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, res);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.46.2


