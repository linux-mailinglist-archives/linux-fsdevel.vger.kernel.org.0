Return-Path: <linux-fsdevel+bounces-32265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06AC9A2F37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5241F248C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA502296C4;
	Thu, 17 Oct 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOYIhzOg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I7ZDkq9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59C229108;
	Thu, 17 Oct 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199195; cv=fail; b=cMgzJQm5uQJfI5h6qF09xQB9P0QyqLdPr/25NbqQPxTJzByWqztnY0bjj3evxa/wGs038nYOoL0ZGzrdCy0g/R7DhxwIOgKw/Ecr9IhkWnuCZy/vRmrifrf6r2LWGqrS1UwF9KdCchgUv1Xg5nrW3u6Tg0sapOeAE5FWNZLh3pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199195; c=relaxed/simple;
	bh=YI9DasuSOfwi+oR5w10ozbjARqQgvfOeYupZFyqp6Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAvgsSrY7UcVwdfgqhY9y4QrTUxL63ChrF1/QhSddpcXvybPfoNObScoW7SSa6wGcvGGPANzLROcWOpww7o7X3mzJM5AJfJsTz9xv+G+wDdRSYa5joDHt8hFqnsCkEr2jpnVaJfNrUMlb5zu/pp4Oq1y++VpD9801hUFyjscTiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOYIhzOg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I7ZDkq9w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtdiF023291;
	Thu, 17 Oct 2024 21:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5exZp87Hyw8QhpkrmxgTDysAv2Qvb/7fiLg4CynYXQU=; b=
	QOYIhzOgAjpkp2KywseZEr8LtXLY7spZRm6xvMZo8dXFfPRsgvXBnvzw1Gkhl305
	aAyk9W82PUoIYbM9tEz9IP7oCbWDAAjw2Xd0ZfkLPJ49akeDKhfmIi9AzYqpIlDh
	EoN0yy9W8DMzVSYaDc9g4mBiyGvvhCNQtUuXuQLWx+rM4G31tM1MVYXfuT85k+UC
	URYck2FkMmCR2HIoFPDR8bpsUTSBpzBoCYc2dm4oRQhOTOnZBHDwxI+Hwt3NMkkD
	CA8Pe2llBwwZyRQwO6inxnwP9OZy/EfWo+Zp3AI979qIKqY23JWnddTfNjfaP++X
	YD8K6nYbGv3Jji0OYrqsQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcq154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKa5Te011154;
	Thu, 17 Oct 2024 21:06:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh4kx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/tbMpw5FPgpDIqhEy65ARcgIphLcRTyKHURjZQmuxKA3MRCbwmI3SYL8E9GFK82KABvNPjZrIdrbaulXED5ANTvajyVtE6TQ0zuS+SmU9iwjMoHHZ0CIcqzs2AdXD3o2vb6oPEjkkHJpKrENotsthxaKei5Zqg2KTO9Z1SAZnnT/IfeAKRj3T9SDcMZMk5USt7G74l+jm5CqmbdImQUvpyOtI2N8bOfUgiLVHcFLRsu9Olf0IBN/st4Da69cNiA0OBdfTv817qAkjdXE9Y4fe7Xn5u3u0/PbgCaXv44L01KAsjdppqHIPljene5RjVKVEWtdHY4jml9E+QlTGHvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5exZp87Hyw8QhpkrmxgTDysAv2Qvb/7fiLg4CynYXQU=;
 b=uT4hy6UT5hl3vTnZXGbL9GbWLQ4EgZnIwymejRK9tBx/G4f46FwKOxJN5ZCiT6gE1DKJBhcgTV5eqmv0erE35SqmgNoDgV+rPy991m00Egk8Knw0xVYF6VvonVQ6FZYrZAxbIaioitu6+u8KazEIvnw+/ZpfP9sxB2cVCL74Rx1+SCiQ2rwlh09dlgurrPgcub5y78cF1K3de82M/9+EXCysyXA8fL1mN25Ts1BtRD04U9i7fkS9QmjgUI/0XBZ1Zk9x3imxSBQJelTTNEv2jKzbEhHPR6E9IEU4SBBwdln8uaSXthSC1xTQ2y72r3FCSgJjI9v3Q2kgHhjHV0MgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5exZp87Hyw8QhpkrmxgTDysAv2Qvb/7fiLg4CynYXQU=;
 b=I7ZDkq9wqcqmmESAjKFQZzSEaS5WqokMFvBxvzIECgEshGzJ50//Qyym+NI7EuJc6haRVQpJfvD8FZ/wCDkeM2ho8/Sylv9jmiaf420/SBWQ15Z7G0ZZJYetf7Gz/CcrVl8ErIQim+jT2zPYejkVydVPE2iykuOS7CJkXMmy+gY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 21:06:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:17 +0000
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
Subject: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Date: Thu, 17 Oct 2024 22:05:50 +0100
Message-ID: <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: cdeb8eb5-c6c3-4ac5-8896-08dceeef8a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jY4w9TVr2H2iYdhZQaGHnl++9pskNkjsLr2iWZn7kNqVJtCQ8w6+npxvvsOZ?=
 =?us-ascii?Q?fTXSBaQtrUZqXa+rMyI3eEHh6zZon9B1Mh+c35B1W3x4iRDbUV7irqb4cgIA?=
 =?us-ascii?Q?/bSoAkeuiQb74r3InwQsZORQRMPggt28mjEggaxCzy5vv4RI6HmCF3PsuDjt?=
 =?us-ascii?Q?pxgPO7Ew4hLGir+I3LyO2zjMpXhIjM4H7tbBlvnAcBLcOt6EN1mJO2J9G+gd?=
 =?us-ascii?Q?gOjwzy54pwpb+bpkElEGfaM8hBBmWXE51ztF4knMLiFWhij7TdfAM/kDZOwD?=
 =?us-ascii?Q?6hsw9RcV0m6B/Vgfk6vglnTfhsnGyDP3JcoCO7UF1uuk6Oopj3dunzlwkjr5?=
 =?us-ascii?Q?S0TYn2sXhjl5CFdl2h5E7BzC77xvc7SNJ/i8EDEPUTp2sEsM4vmF3wZDBCL0?=
 =?us-ascii?Q?r0iqMygyl9HO2xy1izWuVe4CcrUJmES9beefKpzMBjg1qSuhM1QF9cj7Bnw2?=
 =?us-ascii?Q?ggMpJheUFQgC3lq67M8iZ57aiSjK2ayq4xuTngpLh5eDGh7c/56K5r3DDkl/?=
 =?us-ascii?Q?W7BO3mcKZysyE1EHAuYx5Hyq+A60tvwDi9CH52pMLEQXgRXeWI9zf1xsKza4?=
 =?us-ascii?Q?WXVcUzqi9sharjXJ5Y/L+Tse28OW67A/hq2AmMaJTakK3oQcpgCl/ibBXNLP?=
 =?us-ascii?Q?AevdyMFhX8XHPVoPDyhfdG3OYwzdIT+yY2ii+hNoeTht9IjTMG73+kP6Bj5D?=
 =?us-ascii?Q?6TSK3TN4wckwIcU8R1tYJIIHzqOXxSFDhGXv44u5ydMJpbL2RzFzr2YCwMAK?=
 =?us-ascii?Q?nmeFkRmQuGYD4ZG1phBRZJUWGtFWeJ43LubxJtyBk1z5HCDA2r24kykL9eUP?=
 =?us-ascii?Q?pJ4Qstp8rUe7JPJlqmdwyK8ZAt+diOcxfR56q67mknOtC28TyJD390TXsBdO?=
 =?us-ascii?Q?WhV3cS7DWD/coLTaag7lZOUF2My3Q8PtGq0Jg/ENZ3Xu2hwgSqA13pTT6h/j?=
 =?us-ascii?Q?jjFg330bOKociGyzJ/kWHROwB7vNGH2hfk9IB4baJlNy+wXTfTkTQy7Wv5KL?=
 =?us-ascii?Q?sOHT4DzJemJMcypquKMYaVpWHoJKpFE4/2PorhI/SMk6zA19lDT66ur2r7oL?=
 =?us-ascii?Q?wuMdzTxvgNmUnoCjHiEhcPYdDlRtQUIA8VPUEoc3TUjMGON+Kk5jhY8uoUcR?=
 =?us-ascii?Q?pLVwjrktfOFYz1uC8Oph1ZNFZ84AYHwfLnwdu8lwZAIdNEApCIj5LMaDKyt1?=
 =?us-ascii?Q?HH3pckOl4OjVHU5eyUHO9Hgviy3FV8k9T5P6ciYrcl3owXULUnE4A0GWbE1J?=
 =?us-ascii?Q?gCyDGi+QTA+z2vae0N2J83xYFDf+1EFNNuEOvqK/B+Z9Ta2TOZzrLR2KEHYg?=
 =?us-ascii?Q?/OwOUTBRe3TsYbbfduVA3jtT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMpHIV862dnO6ErEDwvkK8U3TCWQjvohtuL0nlFMA1zElBfQQncDMMkSBGc7?=
 =?us-ascii?Q?gwOWYqfEzJOKbArna01FLnZrq6muGT6UvlaCRRwoiAik48oebYT1G86G4UED?=
 =?us-ascii?Q?OBLqkbG+VVrOrNdVUxEj4/IttG6cGH3TZXZPBr/z4b8jTebJ5xSjvBzkjviD?=
 =?us-ascii?Q?mbei6fMxZoiwHlb9B/hUavoASWqanTF3erXrw2n4TK6zoLVe13W0p0aB/6Qa?=
 =?us-ascii?Q?bGxogmNkz449VmODf7CQcRo5lYCXH6oI6NtWiM0VQovPQsNQ58h2dTkTQc42?=
 =?us-ascii?Q?qhbUMNaqziwf8jtqwexEQj8i1x0SAzE+T/ad/9RAreBXHq720DAHvqnvGpaJ?=
 =?us-ascii?Q?LYUYvtV09PlOcv0WbfoxJDEl/Vc76suKVDWAxXTeZBbogacP3E3I2ZPVF0nE?=
 =?us-ascii?Q?oQIukffttWdPvol/qiPQY8QhagF6xU62zNse6bLBbQztO/7tfuBU6jxlwT3S?=
 =?us-ascii?Q?DpqbgViQkMjb8U3KkGimEUALFCCUz/3+ci98CgfRbERg8PnkrG7DzZS9hUQY?=
 =?us-ascii?Q?wEtttcQHennj8t33bqA2I1FLaLnR9XvCCQ4StKabrrszcqWXLtt5jz4/YBXC?=
 =?us-ascii?Q?3+eRFlUekvAWi7nuWZTA5IwRsxFUV2xQMqqsglhnGHFu9omnqKNWdZEs/MCg?=
 =?us-ascii?Q?+XhgQjR21zvMjyK+BgXw0gbE1jRRIT3RLzfGR5AWWPlMmJ3iorVnsysdzubm?=
 =?us-ascii?Q?3Q4zYBEuk4GdLlpy2l3PsAO/QkvfCg1Oyz6s0jQ/aW0K6/SNKvWlqQplfLTL?=
 =?us-ascii?Q?yKx0QdYDGZ1MTJnZAemOzMFLLh97/WjFeWL1Yr9UgqxQIOZ+D3VeVVas6R8u?=
 =?us-ascii?Q?LApKhZyBW44JVKPel5vaoks0g0pZn8joA5lqyh2tb/jwJbelHUzZREyvJZiL?=
 =?us-ascii?Q?GhG08oF+0tRpiXYFx7ZaNi3LGu8KKuSz2ojz9lwISnkg7K9f2g+G65PT9SSN?=
 =?us-ascii?Q?1Mhb/hjLtsTsWfcQ+HNTfu6baRLn1CJGaDjsLUIauL9bnBL2AT6ZUQ/zx79/?=
 =?us-ascii?Q?25DKq1zVumCzlQIRrTXhS/V0do8xCbFaDcRAa06AzCXFcVO0tM+N+6c8mYpA?=
 =?us-ascii?Q?0STP5lffCYstcZRHeJzoPSIjf6AHqnoDtPnLpBmrZAWM5+VHqpEGoySL3RVs?=
 =?us-ascii?Q?8CWPy6NW+0OXJSunSktiCX2EgRM/c1Ek516IspaPEB0CEwGRDgGcEXH1P6KY?=
 =?us-ascii?Q?rQFNcD1jvS7HlqlMao3pzHtazejvEKLqaz3LlQxcFb1VcEZ3OLCd1RvfX1JX?=
 =?us-ascii?Q?WMALTBECM19MjThGGQL03ukkmf13NVom1dYK4K5aVtrHLQU3ofmJqXX8Tw7F?=
 =?us-ascii?Q?0j5CZmUdo+fpoTEqoU1qZqKsPURllTBuZGfPtSLYWC0lS3CqzefPEXleNOgb?=
 =?us-ascii?Q?N5eIRBpo/pBCb66NijIhU4DxygnGXM6t3TxPUVfyOhQtMlUmuE7uvBy5/2Aa?=
 =?us-ascii?Q?R8OZHQy44QrQyf7ByZZ/nEzUDRIdg8adqhkNuR+us2z0subAoFT8A1F9b+vo?=
 =?us-ascii?Q?Czv0G1r269zKz6jfkoJubx7AL3l7HNkB2ZnYcdnpf8Kyz5AklaXkRDP55E6F?=
 =?us-ascii?Q?PesNKEfs1oC10+OPReEoY8pGkkc4uwQrwIIswOLLGhnuE+OrPk7FWz9Ve8fP?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XURm8Wh5SkGfkou5rO6/DjmqDpGeIk3OOtgen6c+7d8y29DlIsjZfH3CoWyxsmCJPKv85fLb7WaY4wE2Qs1rfe7MKTb01GE4mYX3hWvq37pBtTP/8+t+iB5uFTAu6vzsmegxFyleVcuFBeOM0tZ9SDHQ0tSUwYSLAVY3cHDW0Rip6XMMQ9hYXfhL/tV5oy0hpWnxjlS2yL6xh4vetWT2TOuL/I9UJCL708jfVNUmdgCRazMwuw5S8g2ee+jUjazWV8lVGmdjvDSc0TN3T/sQqrLmgGt1B2ve2pWlTg3RsjDsS58FeMpSZr/kkRMDtoHnwlzSvRzbu0n8bqdzgmxU7b2BtuNq6xML2ZXUnBJ7CjlXtsSsCNpZ/3AxKLbNMn1hnKMj9DXoFNduh75tuMo9/nbuieOvws3CVtOEwwBdotsdwGes4nU5O7B2CW4q/twfdTJc2QWYOERyjs5hzeddt6QJozIeNvvsh3hM/wUrHM+rynLSENzVDnkrzBvyhN3S5R5RrNXgqF3RUZAuHrUqrdbcLFG1sSiUEOZawp+QB+kjpBW9vXp8XsSI4LPanv3eY5CuGPwDwedfZRAlicXqtZxLDhaLxc6erl/etwie07M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeb8eb5-c6c3-4ac5-8896-08dceeef8a96
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:06:17.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sthmw3vRmjtoR58sUUaYY90TZaldkZqSetynIp30Alp+qPwEv7FBM/X1nQ7IbHxCslA1Y4Gu1u3cv/mvRjz8W9d5iFOzXuFu95z9bK9+GNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170142
X-Proofpoint-GUID: Mu7vfuw6qPso43wA6bEgjX1QeMbU7fWs
X-Proofpoint-ORIG-GUID: Mu7vfuw6qPso43wA6bEgjX1QeMbU7fWs

It is useful to be able to utilise the pidfd mechanism to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

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
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  8 ++++--
 include/uapi/linux/pidfd.h | 15 +++++++++++
 kernel/exit.c              |  3 ++-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
 5 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index d466890e1b35..3b2ac7567a88 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,11 +78,15 @@ struct file;
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
  * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
+
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
+ *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
+ *              this is set to zero.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..0ca2ebf906fd 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,19 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 
+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-100 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-200 /* Current thread group leader. */
+
+static inline int pidfd_is_self_sentinel(pid_t pid)
+{
+	return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
+}
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3eb20f8252ee 100644
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
+		if (upid < 0 && !pidfd_is_self_sentinel(upid))
 			return -EINVAL;
 
 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 94c97559e5c5..8742157b36f8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
+static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
+{
+	bool is_thread = pidfd == PIDFD_SELF_THREAD;
+	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
+	struct pid *pid = *task_pid_ptr(current, type);
+
+	/* The caller expects an elevated reference count. */
+	get_pid(pid);
+	return pid;
+}
+
 struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
 			    unsigned int *flags)
 {
-	struct pid *pid;
-	struct fd f = fdget(pidfd);
-	struct file *file = fd_file(f);
+	if (pidfd_is_self_sentinel(pidfd)) {
+		return pidfd_get_pid_self(pidfd, flags);
+	} else {
+		struct pid *pid;
+		struct fd f = fdget(pidfd);
+		struct file *file = fd_file(f);
 
-	if (!file)
-		return ERR_PTR(-EBADF);
+		if (!file)
+			return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
 
-	if (IS_ERR(pid)) {
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
+
+		/* Pin pid before we release fd. */
+		get_pid(pid);
+		if (flags)
+			*flags = file->f_flags;
 		fdput(f);
+
 		return pid;
 	}
-
-	/* Pin pid before we release fd. */
-	get_pid(pid);
-	if (flags)
-		*flags = file->f_flags;
-	fdput(f);
-
-	return pid;
 }
 
 /**
-- 
2.46.2


