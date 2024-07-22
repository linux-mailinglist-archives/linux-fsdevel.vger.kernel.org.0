Return-Path: <linux-fsdevel+bounces-24065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD0938E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638E1C21203
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01816D327;
	Mon, 22 Jul 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIqmvS3u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yM7HsCvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FC16DC2F;
	Mon, 22 Jul 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649080; cv=fail; b=nKqwL1yISpNh7qr4gu7jv+1YG9ZAZW1NnkRhqQRfgE2VGsPo3d8XrXcTuNpTxgBgc63aIxslKeT/x+lmo2R7DQJvJ3P63Y7ZNc05VUHxuFBQACva1BOOegOsaNGrvHmkAjv+wtEFVlQMf3vCWnBepHIMnNf9gwIBIchW5icpbkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649080; c=relaxed/simple;
	bh=zRqPQifOWM/WOBysZNFRx+BLkI3CEK9wLt/M+r9XadE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkihZOx/OFlO1zOP3LAxBABY/d2B0GtNv1e1QbjBZUTwgrSnMZ1Cx0+fKx29GQakR5NB7uwVg9xT0WqPyircm5415bRt4ljKVar4d3zQHpP9ZUhHk0/VSOAfs7KRZhIukmyd4fnZUluieeRzU5VOqaD51DbmlbPo30nznb2ZDqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aIqmvS3u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yM7HsCvo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7ctnx017892;
	Mon, 22 Jul 2024 11:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Ug8Lvto7ZcFVcK30HensJFy0Z7Bp4hyDmQz5cHEj05A=; b=
	aIqmvS3uwCDzDKZK2Mnu0gPGHrPrdHKtlvTZjYmYMKyLm2ejNCncaq1fc6JN8KM/
	Gb6clUOLvDb6MFkg2lZeo9KKziO0FC/55yURNCH9VQ78Wa0lhL8u7R26v9kl3W0F
	nkfuD2dxFw3VmwPshzbLs37EAkfXwf5u0WV3UT4nieSjMxshIZswACiNLQNjzUiU
	yd5fw4bl/nzS0awkY2CNjydXgLzijeWQTkXUtTtsuCRTnCuKmkZM4HWxbiOZVqGl
	SG7vySXZEgrbebYKUkFKXhJNJCuGbo+9bsD2AfYbZkOXBu8D84Ulf+ivEW9/NU4D
	IX6jjiFItV1o5n8nAqVDcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe79mn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARZ1a017647;
	Mon, 22 Jul 2024 11:50:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29yu7y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwXWkVqp3zbUOylpgeNV6nNIdslqq1pJqeINpG3MFh14RBqS9ZtQTKlIWeZ2wwES+rBbJpAtz5KUiPZi3u+Eg9DHb6QwVJEwf8H9+CkpiR1pNFioIU7NAGSlVz2qAoZ0+JXlVoAbYTCD0S8/gZq94AyuEVgIWSsdDsLqmgjQKH2X1V6N+vXG1aOdbfHpsVtpP16ZonxcMiWjdiNbi0zjOVBAyPdhH12gSAJ6xsfDHaCmgKddq3S4JDTGIZqXtMV6HsfzPv5NKH1AeBRC+kf+lKbQWt9GyLYIZAkJSydpZSNLFlG8lNFhdBmOCrVfScH2Ir+3tXgF7QSFarqX1/3aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug8Lvto7ZcFVcK30HensJFy0Z7Bp4hyDmQz5cHEj05A=;
 b=f6/qmTvc+Xbr53PupoGTt2ifcses9JSSDn8oSKmPXxd7Z/Kg2Cbhx1A+JANzIdy+JSeIYAWM2lpH8v5BKKYRoWv1/ht/ZEeVT0GiZ3LFWO50keXhw+yqQNuH284SsoFXbq4ifLCMJaE9PK3Bg12QLEuD45kI26Sh/2C9sGDZtw2VcbkCeBsCN4mEHo6y83XWBlf0Dt4/Q0ddYk6AWgWj4alcImezVcujkfH2yadwageP4corjMl0zXU4sFYDy0YCTdZDazsK4tjUQNi/3Xh7+s0xf/c9yt56n9Lt+GoulGTxfMjqAB2NKT/UpFn0scwFFHn+CWzvgKS5DWKyMGoMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug8Lvto7ZcFVcK30HensJFy0Z7Bp4hyDmQz5cHEj05A=;
 b=yM7HsCvo9Fohl3q5fu2llVlmww6sVbpeFiSHVqZeVdThVVWvgPOZ9O6ucJMojW45/6GSxHFB34MqLOlW6FbWvkDMa9y/jLiPwROihGMZlzzSoJvPGQDP1Dj7ZZburPtQrdgsQ5OII0oIhphqjwCUOVVVJUHPFy2CvxWTzt4Uato=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v3 5/7] MAINTAINERS: Add entry for new VMA files
Date: Mon, 22 Jul 2024 12:50:23 +0100
Message-ID: <22a61120c04cfe807f35e941feb9345608057713.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 93afac34-d114-4a7f-c3a2-08dcaa448af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgTAil2Ue+co/zfqwipNnHBMoubwbKroPk2oSDkL8F3o/xxEHCuEZJTJD0T0?=
 =?us-ascii?Q?T7RdGpgNOJc7QVaLTNYD/bgh4427zjBEnyV1NAy+7gjIsiES3hvGJSRba804?=
 =?us-ascii?Q?83q4abOT+DtrMYBXCcZPgus4LA18MaN/iYDye32dtfbxnLSybiCNhm5/HdaZ?=
 =?us-ascii?Q?MaYlVN9D4Nbnemb2JCjQkMvlNip9khtIA4X9lyWEKqCRqjJsDRGZK0HNjPu8?=
 =?us-ascii?Q?JoSrPo18v99Vhaxq39wj8bhlM3Eoa9IcrGoaNJMU0g5MKncjEiV5Ajbf2GjF?=
 =?us-ascii?Q?Sptvq7EDd0iOpSxuU7ZK8p/xrWjSQ1oRHSzL1YQARKNBZFJ+DWF8T2c0OT8n?=
 =?us-ascii?Q?M6nExHUPOSLTquAF169douz+ij4Y+3vG6BBEiMVMs84voHs1BUWffGb8hAfE?=
 =?us-ascii?Q?5IMX3cNC5T8hqTW94v1x+RfhmfAOXvpa0AJVBlfoD6JicFFspVV9dhNcsmUI?=
 =?us-ascii?Q?/WFP8gjuTyOk1Mgie7et03KzzCKlw1Qsb8wWi+hEj5CgscrQgD25BuGmUVGD?=
 =?us-ascii?Q?RBvN+fFFilgQkZC55PhWVsr4WU15Zgju/l7KdIDnnqBkmObAf2sbEXeVjE9F?=
 =?us-ascii?Q?zjOmONWNThWHXwfzz21ktLKtvsxYIJyHmBEiti2qY7c6oWcXGFVvrIF6TksM?=
 =?us-ascii?Q?G99foSS8YCDZ7TcamsZ1jGTTvWPRpyIEZuhPdbl+odwrLG3yP6MRBmAAFbUj?=
 =?us-ascii?Q?kZGsN/zhg/vzU7CkuP2NJg/nVG+Ip8iZ+M2R3h1KzdyqcXAaXWxkmvtlHJ1E?=
 =?us-ascii?Q?+FRZ9zTWL+TwO5PQiPxHSvMoVvDeArQ3ZYED4+FRDqy5qzPvcrxAfZ2A3CEk?=
 =?us-ascii?Q?eTLeYRu+O4Y+lKdfh0qkWtVc2coD9qX0g1Lf9II3OuQyKvkV6YlOs8jtIb6x?=
 =?us-ascii?Q?LpStxhgMcaYPMjm+r0hnTXyAEZHCDHyQQ/aUHO1OPAcoZQCIDwisTrKmLhCH?=
 =?us-ascii?Q?aaBHXk955zqvQKFyQG3+bO3sY0RkDC/43Y6UUYId5g09rqs0wsJojser+V1g?=
 =?us-ascii?Q?5o8Yo/6j7FrPqkR5S4kiFXgqP7lessXewesW6MniZ+eOmW3h/lGshrsndlW5?=
 =?us-ascii?Q?747eBo4C7O3vEohhoF7G8+tLlPVH6Bv921J0dOyvrtD0qlN7btJtEFUiKLkD?=
 =?us-ascii?Q?rUCkpNBV95djDj1/M9/H2CNH9svTkXQNK6qDdBMO3MkYZR4IHfKAb6u2gOPk?=
 =?us-ascii?Q?LYk5MpgvaL8mHjKHjzoY/7CVLC9W5Ht2KVtsinShtcwjoeH+SHrDMN7az1Jc?=
 =?us-ascii?Q?Gf7xcrHIWkzxDWBnbSzjQO4pBALNtHOOFgN6ShOOlE6/07zgrFsrqyTExciK?=
 =?us-ascii?Q?ekA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UaklZ5kWJzJbg4xUOrD/7OovfoHypZxzEi1LdxPzuM4QCQhsFStHDEGrnmjH?=
 =?us-ascii?Q?C9eMEvl/5hk67gz5+CE6jPjrwA4GiAsb2sESg2hwSTSxPImPLh5qfBzXRCoL?=
 =?us-ascii?Q?tKpMXiuayDjeaxlM0HUxjOBvF61sIH0/vdlxBD43hMYmzutkYHW6kx2YQFbz?=
 =?us-ascii?Q?7bZkjp0TsUM9oqw/34YSVgAJuFl1Z05hu4d0p2BYgw5At4yyhVQ4zkL8quR/?=
 =?us-ascii?Q?NvqttKDUwfh0ZFE0k+kDhdjsnsuHeMXtz7sAl3OGLZlTVMfE5fXpMzqYta7D?=
 =?us-ascii?Q?IszcZ0k1I4VxC9PTwGf/HUhu99jk+AfkBXtPF67vKgkqNLHZbZQMPiB8P1pq?=
 =?us-ascii?Q?Xaa51aV44A7MhpGxITrOt4bfaOWn07fmxsioZtCqnM63F9qd16HBrXVSOo7j?=
 =?us-ascii?Q?0py/8hd5/O/SrDh2+kCDYDvICgVlSvfqaogD3TYUfAYgoxjq+FW0J/Wp1em5?=
 =?us-ascii?Q?AtrR/vo7Qyh2FmPKsQqA3UDjpGm8na5LYxAjCaFtNn99KblgSpXumNc5Wkpm?=
 =?us-ascii?Q?4OWW37AT8r9IKvYHktRH13VtdppyMFKi+Tzkl5B26pduob3sfetKSZL6XMDC?=
 =?us-ascii?Q?lVa1jgKYmL8UvcsYRCn4DYw/UI7ImJHSLNIF16d573/BcJCKLZlC+3MaUv1o?=
 =?us-ascii?Q?DhrYaBv/JsGYOaOSBVYxOW2KjRS5tYffVSQODc83izZDF+MnKpQ6sIdF4Sne?=
 =?us-ascii?Q?JRqgXCL6guPHUbYEUZQC470ds9UdvkJRv/5t5k6FXnZ60FQrm1xc3L8Txk6l?=
 =?us-ascii?Q?jF5WxfazgT5R30KB1udVD5WGa5pNGNsNefEYkBwdGjopyy9fpWk6qZKffQiU?=
 =?us-ascii?Q?JazwgRbcJy2teBeQU17FZl3xSFkXNJOEQhi3gcPYHYbSuUHXdRMzFSPSdA6C?=
 =?us-ascii?Q?SHUpF3QPETZPEc03kcbQsecV6W7t1p1JwLGdPCRSecjkfmoJSba8EFInjfS9?=
 =?us-ascii?Q?ZcWHCBix+tQ7SS65MfCiEG897+BibVpAT2jw/IhuXnHMgFeIXBkxDP5qfn4K?=
 =?us-ascii?Q?CPuNrBn8owoHeGWZKZ2sU2FUF0UbceRUbTrIKGEmyzyHhp316YD19xTZReCM?=
 =?us-ascii?Q?5JlfMKZkSWIHBqThfLnIk9LrXjJ6SnjIg7SWJrLj5SIcYUXy1BNWNKHFvTg2?=
 =?us-ascii?Q?oOTbPEZ1rcRhGdvxQfb9upgzYNmG+tzJc565tO3wOEQy/JBba6RtH9X7icYw?=
 =?us-ascii?Q?19Wx565Qa9zOXbL03Osc3pH7b8MtlSUiqQ6BDiNh5P8qcSAent+ampwu2EUR?=
 =?us-ascii?Q?2UcC5k/Fk3yl+Ovs0FsWN98xtQe4hj7A4fw6vi5RZwEnK6V4dhKE8T65TlXo?=
 =?us-ascii?Q?woZAPnTgGDNBKz8q9Q4bQdnoIQVFGd9SD3MF7E+8z67vZF7RrmNgrJZPyzrk?=
 =?us-ascii?Q?LyiyKguZ3JD02S2FvKoLZQlg53ZPypqXYXZKXIS36T6UacFPJLRvLgxddPi7?=
 =?us-ascii?Q?qkK2LsYy39SkpcbAMKlEyDMemGkYnTA+W/4RBkebbYAGCa1hHr2Dy1JlVeOZ?=
 =?us-ascii?Q?QsEPcHKANeMOAMRGoJCSwkC62WHmfj/EomImLVHqpRlzxVfXRDo8pU3eAETy?=
 =?us-ascii?Q?rszi714Uv5QhWPwHpj9qiMJEuJGtvLRE808GvBWAU+ZLU3PYZ0/Lk5JayNzO?=
 =?us-ascii?Q?xv/M6P8u3gyP7XGdqVvmuT7t8XBFI16T6LlWVf8xHzNSqcAXqIQpt2TrlIbA?=
 =?us-ascii?Q?zMMHjA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vnmi05fa+fBx3P8uoTui8MaBiJvZst7rXGT3bbaebzEYqRX61o2NnaCfUhUHHb9CAtMZs8YutmiChZmQdrXSTC1BBlzm4y4sfiHzIG88kli/zTrMxNkxMfh5oaomrVfLKkBTFYIyzVAy7zUjVe9U4QFFsdUSq8eMJq5HbIdfw54fX3r/ezsV8ffuio31RqxLgXNgEGVWdM2EszK0okJgxe1ZkoP5LCSyGb9QhgIxLxsTo0o/HXcdv15SiQ32ccDhLi2A6GPJZOc8+N9SyayuPrVy8mNpTr8bl6+fjEJ5lA7tnYHua7jNf9eoH7FJOmETL8DSCLPiuqBv4L4zAMtWsZTmYoDm6tIt8QdLqBR1jEuKewTncgiL7rekVJt8IJgZv21JgPtiQmWvP8rowJpvFOYA1CZ2tp+hvaiLhFhNeA3nCwslb9wCpp7NdFDAtWRefgXpZOv7iC3fcmFsF9XMHZwBzSPerMyiLISi0G19Cqd2LdfmqNxVnumrBHSOPXYvQQ1tgrZcxU3Mf3fBNTAlOoPmnFer4NCn4gY86eWuRmV2rbAZIfnUMgyOkrEhrEhF/pDGpzwf1zxrVWTU+K6Qt3IMzOcdWxAli83v3MiPoAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93afac34-d114-4a7f-c3a2-08dcaa448af9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:54.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCWOYlAz9RQHpwPj5r1A2QYuD1QL6V3MQ937mHzjKYCSJEqTrAz9aXTL2qKOLra7KPUcX3nMKYmSfOFRl3WvXdrW7ilS8UXZFH4qyV4fD1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: tSpX4STV0Dbevj9jJqo20dzZizdJ7wyT
X-Proofpoint-ORIG-GUID: tSpX4STV0Dbevj9jJqo20dzZizdJ7wyT

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0baccca11de..5d39702afa4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24319,6 +24319,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	https://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.45.2


