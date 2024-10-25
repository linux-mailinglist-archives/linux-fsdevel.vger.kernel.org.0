Return-Path: <linux-fsdevel+bounces-32866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5E9AFE8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A70B285F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30861D90B1;
	Fri, 25 Oct 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tq3GGf2b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J4ph4TGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E41D4159;
	Fri, 25 Oct 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849325; cv=fail; b=hn/7vwdrdRSrfIk2xUaAp1sbTY3/N5M0NugeUDcb3Eltw23DM85VwqhFm7OFT36wFq86bEiwk5jfx2Kj9X7Xe+GupAl/XmW98Wq/tgoApghUcPy3yi2fqdzBOrKt18ukAsmrp9PjNijiN5nm5tgWi1ZJwNwn0f4+2z9anAXpzJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849325; c=relaxed/simple;
	bh=1GpvADSqsq4tnlLFx3u4o6Wwyrnin5JiXLi20OUiVgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6DYQD1BVGIP1nY9VuuziZhG8vO+RUJyRYUjd88RY6dQ7dvf/nCHF8TVcxEtbeT6hF9/ZrIxdBTF1WNNq75TSjDRGJ4ZrNhpYAaQrn5FKHgGSt8P3oD8znBIbfP4Pf9pl7TSDwg1iTc14TrZVnDifW2mhhC4tdxdbj3IYKC2Bt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tq3GGf2b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J4ph4TGT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8Bavr014269;
	Fri, 25 Oct 2024 09:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=; b=
	Tq3GGf2blwKua78D5b7tXt+1Xp3ZmjdcFm4xc2xy9aMhvGdjaFh95s++PISFfXYQ
	+6+X0liyhm+T3AepNFZzcqK/kqyuj7ff366YDkoM7puw6oPhtfVsv8t9kb6EdRWy
	UfpA21s+dGdQhGYbRcc0Wr02L0p5l4jrXjngWiy8bCMj1Zcagwk5IuzQFwqhnade
	T1Ke7Sx8lPlk6vhJiMOX/ZIRn4LoqfT0IB2cgnBfGhPzLrzCsRU8LhYp4MlDLzpY
	L3BgaFDjQrvMsPsRSoAqykZoakGPmJhrRtG0CZ+yfFuMrKz+wVcYlzQXR/cN8/kP
	2ehv3nlkTmKdofo1nWQHTA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55emffp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P9e10I039385;
	Fri, 25 Oct 2024 09:41:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdnd53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXYmR3rk79OjqiibuYJBWrYLTjQv0/5boxrJPvQKoYkwu1vjUyF93AfhqOBJFeQaxbcwroPG1psnb8uVhrmCcHgQvEF9neSJZac+PP9mUwF35kCSrPIfMPZUlLO+bPJky8K0IKOfFbHZDnfyJrVL7wkOlg7hSX0/3lBKe6aGH2g2X/3vP5I+QIs9YyaJbVDGoZYBkSWxl+GC//GhtEC+ZbS/C/1wxJ5swSzwp+gtQ3iTsWH7iSt7e64RgXRTab2nU5WYL9VC993Phx9Msv9VzWPnlGHXwNMLN8UotAFFeslcTkWEXt9Gttbar3L012Lu34KBObZNiaQIlRDnnkZkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=;
 b=EF8oeItZYjT4suTbnO3me1syQ3p2tDrM+ZIbJdOSy9hV7hhyCJNBLmdm/8O3Ay8DNc1uH3Yo8VgvdGX4B057nocYKNQZpvBVENa7OSQlNDuzHnujTHKW927WsO9OTEYv9HUMD7JxxDlLamTOf3RuPcm6sl9VIvPxmovmxD0Lm15JH//lSlrEXP2UHpP9PcABywIpsb4uuQ+LUPNw0EOW3GrnUzm7dtduseLm/GJLbaygcDOppWsJHbf+G5tvliJAHncVX7NLcXi/zGtrxB/Ctm/3tcN0U3cm720CoMbxpD2T06TpPRzpzOa+NHYjmXYrNfeGOK3K61zxbps3hXYc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=;
 b=J4ph4TGTPwGzxtT0xyHOl2QRQrYlZiwhvrbtkaQebPWiblSpAHeP9oKuqfdn3vYLo+j52fxJS9TQWlWuu1dkabmI3GzQ+lO/84JkKvFRrXjOCzBzvC7Q1Xip057mnPA89f+dcFcgZIHGgFfWHb/JrOPQ2kRGjeAeFer46yHgd38=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 1/5] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Fri, 25 Oct 2024 10:41:30 +0100
Message-ID: <20ff34d7de698a0537adbf4ef67b509eb250961e.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0463.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: c39148ee-579f-4e9e-88e9-08dcf4d93c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1yl3XzSsq6Ib4Z0QMQ4HWbAyhgz6ilGWA5LSd+N9VGOCM2806Mj04Q3Kx3J?=
 =?us-ascii?Q?/jZQBofEUO/CLIq+hbBAUPbIOxow7PVOkcqIEOGW+ck4+zr9snFeJnPkp1H8?=
 =?us-ascii?Q?Zx3YhHhAs4aHcQpZ5yOqgswgZfgOwfdVMdnC1vCYau5qd+y34ysLf/4H1/tu?=
 =?us-ascii?Q?ZECltjJBYi4wSW5qdkOu8w8rb8clj808WDZmY/KcxAjd2QNA7ebh0HXrGxmM?=
 =?us-ascii?Q?qO7qJCDkhe5ePIb302AxoSGvw+9aRKjfOhWOS7ZLNU1cE51hu0lYEBNgIrvq?=
 =?us-ascii?Q?eAGFMGZFF0l3gHalPE4jMWFqJtjAaWpk42xflxh5VS0335Kivq4L49L4qAMa?=
 =?us-ascii?Q?eGiBf92RzB6/JgGJs1DH8vF1ec2rJwcuaJf2SZXhqzbB8cs/QUiZC01pydSd?=
 =?us-ascii?Q?z0elGr8U1fRK5sGcET3Xr8XipgDfZZYs1X5CP3sSfRxJZr6vDLBnxuUMq3kq?=
 =?us-ascii?Q?u7qiEuUvg/yO8kV5lXDdiGQHYX46klOGwyA34UJ/NXT2jzCOCTPDDQYWxz53?=
 =?us-ascii?Q?DQV/T9GpJdnENi58zUHPM+L32i1xOIwQYkff7LIMp1Gras5lfccE6ye5VXdh?=
 =?us-ascii?Q?Yh+dtAhVob6ocoAqSwd2BDCQPQ/3aCVRvGwKmhNo5N7XICVDBaOnOzAoIgJj?=
 =?us-ascii?Q?pu0Q1znMWk/3dH9csL+wdSmzxxsjL8Ulu0uruvzNRcJVKpiTlRGmSHfq9y/D?=
 =?us-ascii?Q?9pgGpmTbY6oRDvjaEtG3z/M1km08r1td6P1dN3rmiGkPdVD1IqkjbWD8d4aX?=
 =?us-ascii?Q?BLxuL1z4dgcnHgk8nO3SKrYe2HXLyu1Y8BpFIhOeOW6OeK1xEgpCZQoMXFq0?=
 =?us-ascii?Q?/wOHl87nEZS35pDpY2UUm9igQLZSSx92Wow/dDIFbjOM8HBJsUdX9vFHNUgm?=
 =?us-ascii?Q?G94sC9LWuVZpi6PHz5ViGqT/RPKlNZ6NX+Tlqhmd0A5In77n9z71sOcefqC7?=
 =?us-ascii?Q?L3uVeXrJb1xE7ECxzp/Ejzjd5LGWZWcKpI3pIUwCsxMKElh0Y72xIHiWPY5v?=
 =?us-ascii?Q?CEPbVqhBDKkUD62NxGtzEI/azqJWcIzLWWXpjnuBfGSKpevf0831hrFCAoWF?=
 =?us-ascii?Q?N6ycuHbVvaYdFjdQUu9o/5puiGDOTs05eAsViXgSy0wuiFACDojCwh3oegBk?=
 =?us-ascii?Q?Tb4gD1wanNVWP8c5NZLYeovZxuSujZQqs4UhOJJMN5gm6VZVqvhu8naGyIA+?=
 =?us-ascii?Q?I7RE0ghikx4hSaIMRGxWK3uor4GgvgWOX0VUrt+epfCQuwuIwLEpiTckaqMY?=
 =?us-ascii?Q?NfBGRUENa8o3ZvnoDcYpWC3nhZJiWM/KygdLhoKYahymz+yhka/ekx4b6hmM?=
 =?us-ascii?Q?03FiVRq04zywE3vSSHQoWntu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgQpL6LYelysw/Qqgow0WztzqNt6BHY0YSKUc4w0LI67AmIs+djLpns8FMdX?=
 =?us-ascii?Q?Kyps1mzepEnJg2vPShO/YRmxdGd9y+c+TUXbLwAN5L5bYi2VdRCKCbYBoaW1?=
 =?us-ascii?Q?jUNFchYNf7w763NNaZ1LNZHOSiBuXSJTJaV3kEFf1IIeRDJ1Hg2o/P5F6v1e?=
 =?us-ascii?Q?X5b8PlGxYrZCblaSnVmS0TOOeDJldAEoH2C47gsaBLxpEc1gUKtn/A1BZVXI?=
 =?us-ascii?Q?zpMclQGnt5zS7u1m5RDadPhSs4ZdXAo8csYu6O5hmRDOazWYawUpIvk3XsKf?=
 =?us-ascii?Q?c4LSbrVschhVAJfE9nFZlqDiHiwBGLx4RFt2Yhpqvsl1BiSsFLJDeI9Iqx9Z?=
 =?us-ascii?Q?4H4LmOk7Z2Esn/UA3TZfqZAP8BEziqC9hwg1dGxHEOA97M5FntqAQQZOePAp?=
 =?us-ascii?Q?OkxJKDV/0dli8E0T8pxeWOGXm0qm3fPuAlkYgccsgIKvHN03fvs8U+3MuQZP?=
 =?us-ascii?Q?42kXE1hMqywKnE97HMdMCgHiJmk1viWYvIAHo0RRb/1hiEjAkdHQQzDcnLWK?=
 =?us-ascii?Q?5RoE6Rm4SM5GB2Xa/cc7uHfOXaZSHUbf+OyhYiR4f6T1g9IN9qyI7gV8kIaL?=
 =?us-ascii?Q?trQdUqOVtl0Xv/BKm6eVsAgHGqWNm/q+tOVh3v6Mf8r4Dj6sfcyOUaJlV/si?=
 =?us-ascii?Q?eJF4CGDPL8ejj9B6EzbfYBn5qnKT1USbJnDp/EFcDLsCkEq5gKMMjbKihk7L?=
 =?us-ascii?Q?U/jlS1BXwML5FYXDNfpCp6MjjSCmqscsAf8FtHQmVa8Atzte2GjqTaPYVFaE?=
 =?us-ascii?Q?i4Nt0prUfMzDZjj85AjZ/nkWsudjy6rPDQUm6MnxVa/KVi8K5sz1+bcHDTAb?=
 =?us-ascii?Q?/h0zlGLRR1XzPA65L0a1xUM8oL4PgEyL8WZCGVWHxgETRL/3gChbKSIF5jjN?=
 =?us-ascii?Q?XD+SVQV2WMnMkzcLeqitG0QAfCxgdP2VktoP93ukPJiXpuqN42v7oQz7L69Q?=
 =?us-ascii?Q?TLtAKdr4nsrH7L0IARoW8oE25mcl7Yc59duUuwVYXLXtqaZaFc9LU5ulYwpn?=
 =?us-ascii?Q?kR+ujaG4GTLAnpBqdT41qL9VDRHg7qqrSj7pzQ8HTkGz+AGTobjxBlT8nugg?=
 =?us-ascii?Q?XqEKDsMsutmmy1m++HsF2ARa/TLPL+ILctMK5SfheonfdY4XAC+HvswR0xZL?=
 =?us-ascii?Q?cyyqJOKWiVAoP1QCCQ5ImmZP3L0GKbjzHOZiw5Gne5pq3n+aJrKFXi/T7cVH?=
 =?us-ascii?Q?AnxoIn6TVNA2eBwitvGRXxCDJIQwfTiK3yQm60l5VbnPVdPApjcf6ZrF3GQ9?=
 =?us-ascii?Q?j6NTK0Hef9BJZ040DYFBAniae9NK5S/xqApYqKM6a9YsJrqrN4XiWlyNbvrs?=
 =?us-ascii?Q?ALHSKQMgAgBCvUrtN8MTINkTdSMJjWDf6S/pdkVxM7GlEX0DLcNGJL7bCucB?=
 =?us-ascii?Q?popewMDwWH7sNaFUJi3x1IiMt8jFzGJwdD//DfUjvp86vdlYuPrlfo5dpGK3?=
 =?us-ascii?Q?LD/7kYoM8hYxvYKyR8GeIJcFAXp8kr458nonoVGcTr6MaacyBbRL5Bh14gVA?=
 =?us-ascii?Q?X1BmjyRDQOJ8fnF5W+FN+xpWAJNWxs31JUXhslN5bvp3izNN+5NYKm+xYAZ1?=
 =?us-ascii?Q?oAMb8n5ea3BrMtcMJqLL8gucjZwO73WBIG1S2xSF9EoIFoKFmcygAbBGqeQB?=
 =?us-ascii?Q?GEtl3aNKZUJUNaABYONZDXXzKZ4arlhtzRz4ZICAQTx6bkne0utXI2E3bsdf?=
 =?us-ascii?Q?5NQWAw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+XuP+tBEOzGq3zhUKuZQ5rlVHkHoRJIlyvs5Xoa93mwS36QVyu4rmFIl9JG4Ba2uxXQOWEcIs+xqnH8CQZv9vVzEQ/NasVBLfOykuLyOkbq6QYth3Vve/laZXPM1vDfRBOdbOV0MtgVkoDgmJMppUHoCiBqmznRmJvCdRHXGMZDEhHVM9lQ+OD9uyWxWRTUw2hiAz69bHKdsxb6ZBX20hcg53M6mBbIsocuddDlh2WUzreHHMNV3aFogt50StNd9TmzfzWRDVHVVuAqkrA88jzKmGP0T49NxZNcWJ2OzoQC0gfghksojrDg6sjBNk1rB4vE9ebn1A5ygdPCLNDGNl0i/joL6R5Y19Hlg8i/+sxzg8x941X18pcaw55tkShl2DHvnm+Q9rbiiMHiNQW4hyuEhUYtZK0X95HqKKcpShs3IJankRniro8k67KrWK7YGE/LYbw3PLQWJtq9FnBGGapmwvc4VMt/uMPqVU/WK+r96oFhha7pw9MmAa8iQ5kR7hSD4L/BSfq8lORHtJsGD+9EGqCr5q5KNYodAYpdUEBv0i7ElNANx0Ug3RGkBA45kEOPjFvJLP51Pga0gBkahM3XyexAJyJmPcH3Xcc8Z6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39148ee-579f-4e9e-88e9-08dcf4d93c2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:43.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoCHD4W+gMVz56U5GGhpWxsrkgCSNuFa4SKhVbniEjMXe9zrUoaQJw5MnhFiH8zpX/Klj8luYlRWC+XcVgvvOUicBZrvT/pU3MyHedXx61U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250073
X-Proofpoint-ORIG-GUID: BHQhgcVjkEWSlBaWRb6ZeNRN7bmxM0SG
X-Proofpoint-GUID: BHQhgcVjkEWSlBaWRb6ZeNRN7bmxM0SG

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which narrows this to one approach of pinning
the pid, with an optional output parameters for file->f_flags to avoid the
need to hold onto a file to retrieve this.

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 30 +++++++++++++++++++++++++++++-
 kernel/pid.c        | 42 ++++++++++++++++++++++++------------------
 kernel/signal.c     | 29 ++++++-----------------------
 3 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..d466890e1b35 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,35 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ false, flags);
+}
+
+static inline struct pid *pidfd_get_pid_proc(unsigned int pidfd,
+					     unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ true, flags);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..94c97559e5c5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,32 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags)
 {
-	struct fd f;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
+	struct file *file = fd_file(f);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
+	/* Pin pid before we release fd. */
+	get_pid(pid);
+	if (flags)
+		*flags = file->f_flags;
 	fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +758,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..9a35b1cf40ad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,10 +3897,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,16 +3910,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	pid = pidfd_get_pid_proc(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
@@ -3939,7 +3922,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
@@ -3978,7 +3961,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	else
 		ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
-	fdput(f);
+	put_pid(pid);
 	return ret;
 }
 
-- 
2.47.0


