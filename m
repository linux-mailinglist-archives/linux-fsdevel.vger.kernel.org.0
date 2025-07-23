Return-Path: <linux-fsdevel+bounces-55824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB41B0F253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C07583FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565652E6103;
	Wed, 23 Jul 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJ0kBfUy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iz2xc3Hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8C1F09AC;
	Wed, 23 Jul 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273866; cv=fail; b=jhAx7IC+brLAZp5b5DfS7wtOS825GqJ2z4GpT7WVJMN8X9nvw8yZoHAD/ee3HZcuvu0zEQyimJsx5PjPmR07XjD3q8/bIloXDqHjtUjx8LtA8NlKPrJgEgEGrSoxLoUfsm6MvZd4KiC3szWL3VhHUuODr98K+4ETQVcLjGRO44Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273866; c=relaxed/simple;
	bh=XTPTWPN6tVMMrP0mIYboIagDxkLIq/lKwhg7G3SfK98=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IflwqrTDCKkHCI/UbP8SQe1Zv8tdEzFmU3RPuNLaVtcs9KWmBc4lQ9vOhg65kPfCHY5fBlTMUJd37TuE/rPs3LmXDUW7OTfbNmKk+jTRAfvNxFVt2JfaO4w2UINaLRexs7QB0WMHRpyYsM8MaCcj9i9Usp+HyCqYM1Jhq5eVoZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJ0kBfUy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iz2xc3Hd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NRN5023570;
	Wed, 23 Jul 2025 12:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=e7XcfLb29S3T2mAV
	e/5Cn695K617ZvRFH4jSyat4pbs=; b=bJ0kBfUyRakwOIYIi+SGzOG7izGwYCHB
	tN1lpipEGnN3VrdjXHl1ujTFfF0IrkE+oH2k2tx4oknRLrtxjHwm0J5+jZn893vd
	/2PHnVN2RySJmMvzMZ4uhsjEvAl5o1QB5ajbiZV3J+ulOxG09GgjjlQn+4QEnz9z
	Cxf2rDdAVe85IcNdupDja7sXh9gIBaoVPMSZdGp5saUNwFqP1AFSf9EVxX5hLQfu
	T2ET0FjpjYnoZz/u0ZNLWmNFb6V2XecqtH3sbQLLXm1sRyeYYEPoyJqrGDoWWcTA
	RDrogNYhCSoIjJD1e79b48bVpEE02n6btoCyk1V/BMam8SmGCfL+kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9qfm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 12:30:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NAaWPO038352;
	Wed, 23 Jul 2025 12:30:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tajjkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 12:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8oBukWAE9R8g8P/1VKGK1osSn3qMURLkCmmSCm/tG1Mb3j7d3l7tvD7YT4xnC9F8vFQu5RIRwZJ8s4B9JqfHMJkUHpBUka/CM3ooNi/BNq3U+CqOKN7pINNzW0gMe2CJweYmXexC3t22Gm4B7FY+klnzBP+/LsCk1DnLf6kXb5/kcLHKgXVR1OgutK3HuIkXf3siYK6ba9B6qGS/Mi18F2HHWQubOygtol7ZhFxhhKUu1+TapE69gYUlA6QDDoMsSsENMtYbYiRLE4mGwbKWgUpXgeS1lLI73PAiJvdR9VNKdp7BpmoYIvdYpckx8Gu9eQOrDSBRmaqLkTqSMQj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7XcfLb29S3T2mAVe/5Cn695K617ZvRFH4jSyat4pbs=;
 b=u73sD0s+PLQk307z/sfmA0uKk8QZGh2kHhwudkFpbf5Qxjuxcx+8bk5uAeQ1hAI4Hr3wvxIPTmJNwfd9trwJQg06cOdw5r4IIr2f7wc6NHFVLlfpY2VHwDPndu48OhhuU62E4cxBncUze9lKhuBBVO5hv37GKFy/FI42LsU44Pmkc2He0Q+GDBxuswPyOlvbFw2a7RWx3PQakoAvHpcE6HNALsn8JJw0q9xzSSeDoQ2kCXCEKyhTjc0KPf5K2dwu1K0MaJXa6IBoRgujYh0KSdGlgDAmQR1SPaGq4dFwk8/V5ZxTF0f0fGbWYaanh4+Egu3tuRaO192Gy5WLfRWi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7XcfLb29S3T2mAVe/5Cn695K617ZvRFH4jSyat4pbs=;
 b=Iz2xc3HduiV9Ca4LC7WviBNI7ee3gfRBjJCzcWlzG/+vGxASUZuW3sg77nw6TJNGdNabbrVYsdnd4EPigrccFU34REC0x2JkIHmRcA93C/Prl6dE9B3tRlJpb6BK/24hdSOYoqU+j8MoI09Tb8KiSHTUk/zvy4/BRzdz9CrIp5Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7184.namprd10.prod.outlook.com (2603:10b6:208:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 12:30:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 12:30:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH RESEND] doc: update porting, vfs documentation to describe mmap_prepare()
Date: Wed, 23 Jul 2025 13:30:36 +0100
Message-ID: <20250723123036.35472-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0573.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7d0709-f9e5-4d37-cf20-08ddc9e4c15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVZG+DziW7QoR9wjX24Si7ogwJYYAfZaiHDPtujHrdr5iUBGrQ+oUI1H3a1R?=
 =?us-ascii?Q?u/hONC+n1e/ov97eiy3oUEQNhETWe6cFKUTO92+s6g4tSgEuCPUdsitn74XU?=
 =?us-ascii?Q?RDIrDWDc2vhCe9fIqOnGmSgpL86zSXCiMW3vqcZ9+v5M60b+hY6mWJtcF8r/?=
 =?us-ascii?Q?5lh5XE3Uo9x27Ph4gWV0OI/NtKcAUJZcYNUuC7HHfjFlkxr+NWKZOCdqWyzl?=
 =?us-ascii?Q?HyrmRUxuxNF5J8xhjMKXoEX7LXDnJx3i/fzwbOmhPne7DlhW/u2LXeHJlBnH?=
 =?us-ascii?Q?lePRyayU8vxDDXiGP85McWH8Ny04a3lFdKASdxgIscVDCFzepRd2e2UkUbB5?=
 =?us-ascii?Q?gb8BVrxKVw3YWqgypXrjTcSb5XvYHsmas62oMt6LX/pBAZmuKJ63u8A0gcPr?=
 =?us-ascii?Q?ePAW9c88y1WUzRr40uII/5veUXCvDf5e2wTEwbJkCKpAiykDKy8YYMfcN/A0?=
 =?us-ascii?Q?pjumTgju64gSDuJy/+MoIcv5D4uhYGmPUfSiikdBP6LVuczWjl9PD4tTTJzJ?=
 =?us-ascii?Q?X+2JyZHLQtaAtbu2jK54HxMf1QTD0T8aXoVN7mP1sKjSluRQ920XHVIbop8l?=
 =?us-ascii?Q?+fbGe7xklfaDaLLE9Xfb6T2lDc9hrgG+bT9Nn7EZpQdWeUBQ33xKvQRxNYGO?=
 =?us-ascii?Q?NxeIj47u2dVgEvBbf2M+l+Eotl+L5C/D06qpqAVlk096zhvwGm6diLn+3hvu?=
 =?us-ascii?Q?6Joz2HI4NkOT3sK55Ui9JIWQhgrNgHVnntsDcMBXhczN78NK92tazQXwQoJy?=
 =?us-ascii?Q?U0VKJyKO2YMmUgHLiHwVi36n0K70AWpiouLwTwzqQBswECNm1q6TWNM/XJuw?=
 =?us-ascii?Q?c4j9Q2TrXkRnkSQeSCFEvOQ+uGQygzZkirLnOtmMMTTxZofbUW1ERDBy5YeP?=
 =?us-ascii?Q?JOfZwrUIQidYQjq4DQAEueJ3Zf7+jy8DVClW4A+U3vB5e8Yo2jq8JIL7D9Pf?=
 =?us-ascii?Q?9475twqK6dKrKvUq5rWpluNS6eeFF0eWlqsP/ON2dERdXNKw3GaqWHAazAih?=
 =?us-ascii?Q?aAmAVbng/s+Sqclpbw7D3owJc44F3KLyVxmRbF6DljCB5AidmtoK0oyWV2jq?=
 =?us-ascii?Q?ZrDft61hLg0OKXAUZGNKfhhxBkrmRXtUM46xwBJJiVoCJD3aTkIbp93knW8Z?=
 =?us-ascii?Q?jxwkNKjLDcSTbcDXYpYHp7aPa1OYX45ut0x5zXcki9dOTQChQsB3N90bzDdL?=
 =?us-ascii?Q?4pthlK1f5SOaKc93wApPa2HtWEKLtjNRh56Af4Qkp8ac7MpHjgIiHP1VbSeL?=
 =?us-ascii?Q?wPQ+k81L2MWBZehEzJjqLf9SRmmhMF3KXbwCHDbmoOYZzv4z3W+zyR7ZA6km?=
 =?us-ascii?Q?HCO2KDXhagX/Lx5cwZCNMbjaFRgB4gtNxWlZ8wouo3q9VBkKvwojDzEw6vtC?=
 =?us-ascii?Q?5CNOe9nKZCLY1F5fKl0LsNRTqlXggEIF2zcJDhbzocn/P/WH3Zw/kd+9/mc6?=
 =?us-ascii?Q?c+hk3ZXcK1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKQaLzhmIXlE/5iM2f32sJbfYLh6lcEsRodGmYYELaB/bCyPfajXrVxfAZ0J?=
 =?us-ascii?Q?l5PpJb/8HSVvtxrfytSVADgU3pwLzKeY311EvqmpWpO0LVcctZ8ASbSbUi4O?=
 =?us-ascii?Q?8QaRpzonfA6c5JVfrl+vCiLf1A0J2CWPldA0YSOkPmBRXagUQHCesU9hfeRy?=
 =?us-ascii?Q?T1RsUhmWQxx8EVcjh01NASRlUzrvF87RFcIZ4ED1Bc+zJRCI2qMpwAfRxOZ1?=
 =?us-ascii?Q?4vY+E8hq+w1LG+vuPChquuvhoorJLNZoS8TeEtDRN/no3DKfLXELGLsbtF/4?=
 =?us-ascii?Q?+I+torrj4NdxUF+lwlILb40TQjGNnxtlxG0IVBqtoj3dzgFj/knj++kQUaGt?=
 =?us-ascii?Q?43LzVK6MAPbFpq0nFTTcw5JD+9xmmEPZ/nP/TMkddhqTaS4ZY69CIP+EiNVd?=
 =?us-ascii?Q?bw59N0Pi6oCkMcNtnIIRXi4ykP0Vhlu8qr9Nrs3fh9Qi1Fd8d4J0SgDgkHbX?=
 =?us-ascii?Q?Jn8534bZ5MDpCwPL8eWVOwMZXSbbMYZJ0RwivlB+S8hVprNQcY1HtY0DyIKb?=
 =?us-ascii?Q?NlUSeBx2sf5yEAx4a+0+ewwV/DKZ3aV3VA9n6CE0CaMCmU7aiOGnnV4ulrsL?=
 =?us-ascii?Q?QIAO7iRJ7/aHPmIPCVsu6SY9Muo8dZD1C/znAzdoe1FiQUnbxG9ksnyHnwm1?=
 =?us-ascii?Q?OYennsw/mcCY3rO8XaotLJeD0Gjz19Ed+fCTQ9CnH5/YAzc+sQ8MYVpICGzj?=
 =?us-ascii?Q?zzumvYLXA43KrmbopD1rTvAXvoZc/JT8/xl/bus+ob8xT3N/1UZ8A0L04cED?=
 =?us-ascii?Q?xXO9aK+idzTAMDdsv1d5Urpp6tvIMutgINcnD7HCDkTtFWCTNunIVUngkRLT?=
 =?us-ascii?Q?L3B3ituoTQ5zd7tYOVRy69q9qdx1fBVTgNNHdN/faCgmUuku6g6uXKrRhW3/?=
 =?us-ascii?Q?two26wN+IPOJrbXWuq8DglISHpe55Lwxb8jkCd4nmM9Uk+tinV9DJCMhDHai?=
 =?us-ascii?Q?qjMKl6qYs8t37gXrF1bgrt+KKi0htXIPixot6YXTmDlDCldfpW1JxG9L0DIZ?=
 =?us-ascii?Q?agKZaf2PE6czxm3eLYif+PxzJj0u0cQmU5z/1CQo6HZ7w1evdWwvnEpHgQv4?=
 =?us-ascii?Q?vCXvY7OJSiXuDnQ2KVMg+LgG7KCl04BNmq0SxpJLTJyPua0o67a2tk57mcZo?=
 =?us-ascii?Q?ytdVFEHyiT6aXSDMiz7fh+OysamS83ckwCpcuoOY8MoXbptAH0LYz7eoXI4Q?=
 =?us-ascii?Q?y0+nG+Yu/+wsOT2B5RYpHINjpoli9N1m1wznIbjI2N+LYNAhbvZCv62llFkY?=
 =?us-ascii?Q?wV7fNb8NoIFcejY09hj0m3a7bl3kBiXA931iQ7yDHkHGZ1A86NbsL/YY+2W1?=
 =?us-ascii?Q?xyaqMGJFBzaAl5t6kPIiZA+86xU0LFGK1SnVu5Tb+eft+EjD4H25+/fwFHQG?=
 =?us-ascii?Q?zQm3iU3/5IJuXSa+7uXP60+7i2gHeSUlGmbnXSjLMUO/qDtCEPO8m7O5SE9i?=
 =?us-ascii?Q?/rsL4katc0a+PK/xruIMpp60yiwMtwiozotrI6ypUzPgDvquAd+XPQX6I4ev?=
 =?us-ascii?Q?Bm7zgVj/fSInhomFhP4Dcj36eVIbfU0XoPUQ8nVaFHLnn7l3vIwXlimHeXGC?=
 =?us-ascii?Q?RIbsRPzrs2Z5a4f/R/510tfaxVaciI7BgTvLhHsxmQZrRxpZd6wg+4vXJBAa?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/5zYasTMhz+WjdwNSalPR44YV3UlKcwcHf4k8MNHn1gqPTaUi4nZ+mUpbdvUSA0ZrTYLQWmu60J5h8KhlPLX2oGtpPbiMoXrRkvQRK0ZO/x3JqrDipQyiCya/qFQzX/eDEpgiVJ+zrGKeGKokwwWE6IiIgR9yWw1mP9cn/7JOJJvQ1TjCPEVYrgTJ3srYo+8h4O0vAKjvQXoz+JOoAQ/HtmCMy0BlSvmAvvlx+AaXdxAH2cW320uNLgCVkuR0m6bVNFfyW4xg3s2B+67Xq7ZphJVaAcYIte3db7Whr5I7zzJczEoxguPDV4VDtBtuXUNr74iF/gTMusYvXgteQrIXrfJOSJ+VEef2B58+rM3UxRzzloL1qNlevBm3GOy0rV8/Lc+cEj5sQiVmlwcEVW29OCfgeQYVbjU1xRYCmXw3/Tk6PTtg9NPc89qcfwzrtRsFpbfQnSf22/Vhl/o8sAURbcWvRCGfFF5YOK7FuVpQ+xL8IibAK4dOmAZ+h8ffVCeHf0oxlKIyNYMuQZtQ16ZXDqJ1kuWbZgjsjUbX3OP0e7w719kmvfpB1f5dQyiNIm32Zy8jGZ326Fjft9QRwXNXn4GxeQ1ZYBlYDRD6yjMjao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d0709-f9e5-4d37-cf20-08ddc9e4c15d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 12:30:49.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0ziTwN0XsdtUfSWQI2w0hNwO0rSeNCGDG+LTF4WW8rw9IsURf7m7ttVg7P4rTu69dl50xggzXRDENupDUkdsbgwnwGy4QqOFy/AVJFNups=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230106
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=6880d5fd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=SomDLjyQAOBwc7QBVS4A:9 cc=ntf awl=host:12062
X-Proofpoint-GUID: oTC59opedgKG41lOkMZ_0_wQUNGz5eSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEwNiBTYWx0ZWRfX+YnJJvi5wlf8
 8nUXT+h50C9VYiXVh1UaE/pbjG+R1LWsqK76fbReG9JA+j+D5D8sb1CRbaA5MIh/VjWtUm4wwc9
 K0KhVlxF5eNx3Jw3hKYyRvVOtTFZ67BYms/nfHTgndls38oo4iAp8B825+WVA9PzRwcwUsN4GmR
 WSZCwJD3wa1B8+0qgJR/71zLggg10o1fWOnUu4VuY6uhccVCm9lYotiqBCFOCNwdLoE8hwtZDwP
 cAzVH6abM7O0tj22MwnCUkerJ+baWSQ0+PBAcFLM1uEDSb4EkuPUCY/cnq0MCA/nkVyjDWBcwww
 K8l8TpRDbpFQUmMqaD0TBqlq6adBSu+ZI0wj2Bv27vqrfKo0y5Err9JPqq00dDd0KJDPRzHhTJu
 CtmTZpD8GiA6QTarYnRCds+ZTgZAZDw/8a+U/WepGZrOfmqJBoLnxLHAue+vD/5JF2Y9t7fK
X-Proofpoint-ORIG-GUID: oTC59opedgKG41lOkMZ_0_wQUNGz5eSd

Now that we have established .mmap_prepare() as the preferred means by
which filesystems establish state upon memory mapping of a file, update the
VFS and porting documentation to reflect this.

As part of this change, additionally update the VFS documentation to
contain the current state of the file_operations struct.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Resend:
* Rebased on vfs-6.17.mmap_prepare.

Original version at
https://lore.kernel.org/all/20250721095549.21200-1-lorenzo.stoakes@oracle.com/

 Documentation/filesystems/porting.rst | 12 ++++++++++++
 Documentation/filesystems/vfs.rst     | 22 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3616d7161dab..48fff4c407f3 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1249,3 +1249,15 @@ Using try_lookup_noperm() will require linux/namei.h to be included.

 Calling conventions for ->d_automount() have changed; we should *not* grab
 an extra reference to new mount - it should be returned with refcount 1.
+
+---
+
+**highly recommended**
+
+The file operations mmap() callback is deprecated in favour of
+mmap_prepare(). This passes a pointer to a vm_area_desc to the callback
+rather than a VMA, as the VMA at this stage is not yet valid.
+
+The vm_area_desc provides the minimum required information for a filesystem
+to initialise state upon memory mapping of a file-backed region, and output
+parameters for the file system to set this state.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fd32a9a17bfb..c002f50a9cbc 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1071,12 +1071,14 @@ This describes how the VFS can manipulate an open file.  As of kernel

 	struct file_operations {
 		struct module *owner;
+		fop_flags_t fop_flags;
 		loff_t (*llseek) (struct file *, loff_t, int);
 		ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 		ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-		int (*iopoll)(struct kiocb *kiocb, bool spin);
+		int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
+				unsigned int flags);
 		int (*iterate_shared) (struct file *, struct dir_context *);
 		__poll_t (*poll) (struct file *, struct poll_table_struct *);
 		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
@@ -1093,18 +1095,24 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		int (*flock) (struct file *, int, struct file_lock *);
 		ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
 		ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-		int (*setlease)(struct file *, long, struct file_lock **, void **);
+		void (*splice_eof)(struct file *file);
+		int (*setlease)(struct file *, int, struct file_lease **, void **);
 		long (*fallocate)(struct file *file, int mode, loff_t offset,
 				  loff_t len);
 		void (*show_fdinfo)(struct seq_file *m, struct file *f);
 	#ifndef CONFIG_MMU
 		unsigned (*mmap_capabilities)(struct file *);
 	#endif
-		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t, size_t, unsigned int);
+		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
+				loff_t, size_t, unsigned int);
 		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
+		int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
+		int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
+					unsigned int poll_flags);
+		int (*mmap_prepare)(struct vm_area_desc *);
 	};

 Again, all methods are called without any locks being held, unless
@@ -1144,7 +1152,8 @@ otherwise noted.
 	 used on 64 bit kernels.

 ``mmap``
-	called by the mmap(2) system call
+	called by the mmap(2) system call. Deprecated in favour of
+	``mmap_prepare``.

 ``open``
 	called by the VFS when an inode should be opened.  When the VFS
@@ -1221,6 +1230,11 @@ otherwise noted.
 ``fadvise``
 	possibly called by the fadvise64() system call.

+``mmap_prepare``
+	Called by the mmap(2) system call. Allows a VFS to set up a
+	file-backed memory mapping, most notably establishing relevant
+	private state and VMA callbacks.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
--
2.50.1

