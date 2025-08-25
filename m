Return-Path: <linux-fsdevel+bounces-59097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D23B3467D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C0234E3492
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60D3002AE;
	Mon, 25 Aug 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUzG76VM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FZRPVaXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202962FF66C;
	Mon, 25 Aug 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137465; cv=fail; b=e5+DEUQxFx4xrYc1hnA/Ss29PRaHwregogYmtDcbgdKRXK9Fu4x5fDybXEpLQr/ZAtQ/hKa22hkt7CsL+bZz8I5QeHgkrSktHxHov0DT3Y/2gYktqKtAtyr7SxIRswub/DcaNEus/7fb8RHcaKpD2peRfr9orKDiy/w5VYmeHk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137465; c=relaxed/simple;
	bh=VeMQsSBMdHub7kTYU8vUr0XwLu0lG9oDwQIJ7nMNxIE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pRc8xPL3n7xBKrqpksniO+lo8jSGo6d2hTBrR3yPzRcSjHFgigZu8DfGvFjz4ElQaaGedLYSz7Zjs48vFCr69Fld0K4OUO/RjZ+Ohtfyjpoo1K74eel1MLhFznedLHJEZueazsVieIX/bF4kDd9s2FZJ0tgIbklopE0CunM+XUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dUzG76VM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FZRPVaXp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFkbnc017182;
	Mon, 25 Aug 2025 15:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QEnpKb9gPvGg/M20em
	co49m+J5fWEFuwEeAJuNhlFCI=; b=dUzG76VMoaoLfnl9aup6cV7rl7NqBMTYmP
	7a5VyUVkv9rSWExCg35ghiC+k+e5P3rE3u9OpZv0xKxu6wa77YjW0zMjVwaRg0+m
	z7rlGY1Y4zyn3AH3QuGS3mGiNMPsUny3XUvTMLs0C1xQYAozFnYh9pKMc4FUoLQ6
	beiO63d3WcwhboAN4jwrrZoQ//+2R5g+YF3qK/AMJoGb8/DMvIDRdObdLUHBYmlM
	262/cPIFJ0Sxfs1LLq94F3LhM2EWnUmSqRHlrWc+lfwxIY4IItD5AIIxEvfbV0zJ
	Wxf6luaielB6SzLMCHOlRwFbDW6wSVpdxTxrRwXnnKveX9yAOOkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678tk0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 15:57:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFZ20v012233;
	Mon, 25 Aug 2025 15:57:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q438chvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 15:57:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+RZSN4M7LHgDmlhdAShuj1ev7WzvuYUawe8Dcv8FRg/vxW+3rVbSMojOiR5HHnXBmdAPfNR93y/ApaA7r1kxFscy+Iae/AC8Ua7dMW8SW8aOfk1iUIKoVRYzwpyu0XAQMgkWC/8zaQzyPqQ+qN66iSF3sPodj/PKoi53t9Lo7xEGDsygUhsCEQpNx+VncIYDHGAg0hqH+d2JT+UWJpQnTAu8kAa6j4ou+q1vfMf7cHwF5+GVZju2G3AdKmOq2itEXUqlX1UDWf8EllkRr/8PLeJTOafwSnEMp3d5JDh4mcjo6AMGY7wGVkXXY9tqxNvBvaUCXrtqx5zDp3bXbx2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEnpKb9gPvGg/M20emco49m+J5fWEFuwEeAJuNhlFCI=;
 b=Oku/0IlFv4rHWwg4wt2x4NxnpsWthO0UtUtCYcBSWqN958ey18ROuYX0QVeSVRa1CfWYuvcP8KS1Kto4vwzw/oRuTOWYn1YtAp/7LyQyDqdeqqcrYX1l3h2DPolhz177P20XWz+k+5NIO7jkilbofVx+Zeuq+JQX77hvbY3/9iq0YdzzeadIdZotnUiSyKkgKI+Ie+1DPpw8SR++G4VuXcyCJYTHDF4ef1os22P+ZTI2Xil7kT55Mnan8GXse43/4x5rek6K3RsRAMDu2Pxevw34su07ax6gXZcJsK5U2QPl8DfxV4z/8uB+ddqbR2GxRudGw5WoACCqdL5uPBjRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEnpKb9gPvGg/M20emco49m+J5fWEFuwEeAJuNhlFCI=;
 b=FZRPVaXpP4/Aw4lruyZ99moP+QC9Kq7K5p/7y5arC0RvetPv+p64heYUF+Jlnzr86KO0SwA9flGWLs80794OXB7QlA50eqhMwZpXTdReJo7+YFD3V92Mmv633xS/KWQTE5bsfgqlpppuPdqfYaZMKgQCSrcOOd0iYEnbNVXGfZE=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 15:57:14 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 25 Aug 2025
 15:57:14 +0000
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, bmarzins@redhat.com,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
        martin.petersen@oracle.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH util-linux v4] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250821061307.1770368-1-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Thu, 21 Aug 2025 14:13:07 +0800")
Organization: Oracle Corporation
Message-ID: <yq1zfbnqtrq.fsf@ca-mkp.ca.oracle.com>
References: <20250821061307.1770368-1-yi.zhang@huaweicloud.com>
Date: Mon, 25 Aug 2025 11:57:12 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 803ff3d3-28e6-49fa-356d-08dde3f00f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zc2iPgP4NtDKja/wLOU7JZvdtlNEdrtjE9kKuRDA10DmmckVmzriPm73bgib?=
 =?us-ascii?Q?oJRsKFbYCU2qRUgYUBZB9cIOLEcUdfL62HmOX8eNYo/9mvKqwe+QBUI4d1O2?=
 =?us-ascii?Q?IbY6m8SPEpU5aEL80FmyCDim/xiPwr8WbhphgHwEU0MGraUx3TTfQMrLivh2?=
 =?us-ascii?Q?1b5F0qkLf0ZOcfuZfvihV2Sxn+/D9si4RjYNHZJLEpi/U2rqRRUESsVmgsfg?=
 =?us-ascii?Q?Nw3k/TkH7loiDEDZwnNxcdwWcPcSyhA5+yxvf10Rmd0M/3FN2LwwFEyC2BWx?=
 =?us-ascii?Q?8mR3PdLpbbL6Y3xwA/gX9UgxThXBg/KcXDlF3kLLVZjP/Osl6/gDy7sEeiIg?=
 =?us-ascii?Q?BLI9PhCX+jmFqQRPi3ZDKVFscnlks1JzbrOOBHdc0Qi9hTH84zmzSR3nBx0T?=
 =?us-ascii?Q?w8a/PIQ23UT0n85QGt4pxM1l7P6df4VYbU6TDIhwRaPSwLqwLpzujph85J+N?=
 =?us-ascii?Q?NUrrzfKlhdOjxY9ZoR+gXlg/niqKF+NgiOn3ToG8nP623xgg+p9mL67B4k+N?=
 =?us-ascii?Q?nlUqEO33fWHrx1OZCzpdzrdgLoQhZhrAsEPbVydy3vlzWyQwxNnnWCxScS6I?=
 =?us-ascii?Q?N0yzKsqbaJwAc70K2Y64purKHY1ospBmy2Zr1q6OwKzMiZiEE+clZ1i+TSnH?=
 =?us-ascii?Q?czZn3VwEXfW46DJUym6B9qJ67D7SjK1zNG/Q2qz20hfpF+7xunFWcGmxymQM?=
 =?us-ascii?Q?DvqjKfmR4YiIYWGucSDxMaVG30l2IQRlPuJcqlht8IFvCfdevILmbgyo9Zrf?=
 =?us-ascii?Q?YyYUXzmg/Qf+o4Bxo+w3vZEP5LR8a2W4RZx4bF7mFUGcYgwT55K3wwpez2/K?=
 =?us-ascii?Q?RYP624vFRAakSSu7F4h+R9TqTY7ZWA3VhWZztHPKSjaMM2kyUqjcYz+ObAL1?=
 =?us-ascii?Q?ANgu1eWgqBRQXmFw89mEn/auW3HfPyXvRjmiNeA9uwrHD/FYAWCOb25SMRXM?=
 =?us-ascii?Q?O6j8JpTMKaCsVo48M9kqvOg1aC0FdLAKJY5M2weYZXl5t6Frhw7s/kXe2Eg6?=
 =?us-ascii?Q?DFWiOk4ltlr+xb2MJqJPo1tpqtjddy7tp0YndQAgpothiBrWJaw76Kst9M+c?=
 =?us-ascii?Q?W4FpDWCF/ma6w3kBHtFmTuPLdtZkkpmoPczegMz3Hs/WrDFuKaATyqfFSmUI?=
 =?us-ascii?Q?9LJMLWmlan8OLMpQonao/gXhqbWXJqn35QssdV+bhEPDtEsWp0GWCl6Z3xZO?=
 =?us-ascii?Q?qhOUFyFcZO/c3R8FXqQoRuABIDhou0BIy0r3/RdrrIfj/A77FuZmyS2ZiPZh?=
 =?us-ascii?Q?Me+DR3ZhoqiLbxrg5gfawah+DE55E2oGyTtS4ZLAQMrIZSrk1utu/+PSOoMy?=
 =?us-ascii?Q?MhmY1Q5iOgVRGEwLR2kx08xiidsOuUrrMfWnlCE9ZvIVhJ6xGmxuO5qQtLrU?=
 =?us-ascii?Q?lOj80xcfF+CbtMSJ6v0Kn7LgHXERzkd1FeCqxQoWoVbb6pqMwTwUB0axErtW?=
 =?us-ascii?Q?6oWakbajheU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fjv7kiitYO4W89r6hND0jDyrMXiZ/+yW/5xt4e/8yZ3hVoxrQAYZMOIE969P?=
 =?us-ascii?Q?GhKP4zvW/f7a7B7pzLP5lwS+8tVPkdtIn7CwlGOv1HZ8j335poLYs6fYj95k?=
 =?us-ascii?Q?q+mtNzGAmUiaOUScIhOKVA/xOJkY7K2W1NSBeZJ3BZvQYuYhFWUuAqFUMASM?=
 =?us-ascii?Q?V14fNdCep8QHuQV9VajwTC99ttRwtIyu7H+A1Xtim5Go3I/EWQMwJ5i9JMbf?=
 =?us-ascii?Q?An01GBNM4glToiBXYESM98z2Xm1d7EsDkRi61H4HzlZzXC+2xitxaotqsnYp?=
 =?us-ascii?Q?xZYjO/KbQVnJ8XNLB6wWq1OLC2jtEsyq9Dscg9A5D6HTULECsuF9BaEvTUmI?=
 =?us-ascii?Q?oAvvo/X67VAM3cGW1nS5y3foPtcDgbMmY0KHfBV0OvZkFuk2b+Xoxsts9o8O?=
 =?us-ascii?Q?qheYriUBm535qtr77hK3nxNA+Nx8FpbBwZTU7Lsal3kN5y7RGtUV1YLhYtMN?=
 =?us-ascii?Q?Vffz5wT2F0tBdxeXn2lqEgA6noKSL61nYapLqzXn90ZEx7E8l9SVQwM2z+Sn?=
 =?us-ascii?Q?7NZ/S0s8JI6+iIcY7vjzrX76zEVxfEwp+2nlyOa9k3p8XgK3COYty7EgbvAh?=
 =?us-ascii?Q?oo6TEmiSZSaeZIFerrMJZm26ilR656ZUgLAhxxH2DXyCgT1JwxBuTDZ5dabQ?=
 =?us-ascii?Q?uFVIj6pfPvqSet3S4OgJLr9QbAOaEmzkDTrOM3KxZODRNc+80JyiB49OM5yj?=
 =?us-ascii?Q?ff5q+bYpd7yU2UzjQPiresTLO2qquGs3a15Cujfo1oxssxXOE7gqQ+K1viVU?=
 =?us-ascii?Q?CEq0WHLR3p7vRrx6tGuY5tOuM577HEqg+I74DKOILj+dZYhbaULFThWuamqU?=
 =?us-ascii?Q?Gs88sLtvTwIfQQaM+Wm7855VivUEYBrDR7hEtLW+/j2XkeYq8lTHw5RSVKld?=
 =?us-ascii?Q?c86tU0i9+RiE+nZNSb0/DqV8cgBdumSJJddBXNcjCxek3Hf8+GOv6p8bOxrK?=
 =?us-ascii?Q?8bJqoooPFmZfCIjM0D2YdHPcvk6ETaPC/ekIc/NxZlLeUL9gU3V7+CoO98Zx?=
 =?us-ascii?Q?owss0zycO0YyP2xMxpzq2AWuOvTFHNkKCjrFUxO3sTJBHr/G30I8Z2ilStn9?=
 =?us-ascii?Q?hSAl6+lRi5hSnf90lLrUmSuHuszZDIm2v9h65Rtivm8p2Q4xvuuat5GIWk/J?=
 =?us-ascii?Q?hntHnU6ZK0dz92une2CoisfNX/ZFTLtlWMVRd5AuEYG7oAZUVSXh/foIGQJ1?=
 =?us-ascii?Q?I3FGvZTZxd9zQvjxQckd2M/tey6lrI+YsPJbe7V7VREWeWtowFQap/Cxts9w?=
 =?us-ascii?Q?lGHTy5v2K+FaxGK4PPXuYlhWFzyu2PwjchsQkR14ThIYC1IyO/neRj+iaJey?=
 =?us-ascii?Q?Jvkcfd4eZI/gSGHZ3cai+fSvBdR7IXu7Yh3wVL64+eZsceiy+C8P+GMqmnXg?=
 =?us-ascii?Q?wmZwuAwpDDY0nYNSZq78DJLwIoGVoL/+pVcNa1Cp9rNHvmVuzhdG1WHu/vXR?=
 =?us-ascii?Q?5LEmuvEuuhFpvNFuuCGQPHKAFd3pLvBC7dw5mrtLbCjKvuD7sYzZxosWVH9e?=
 =?us-ascii?Q?1RFxnv0wJX7m8vjwbsC5wwf2y/KAecHDhuhY2b9kY0ancCcBcYUWPfH502WH?=
 =?us-ascii?Q?IRJuNR+KFIdKH8AJixH+4sbZSMWa1Ck/nGm2hFciDRlMEfyROmmlJ87qBTBh?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I+3Wfp3EI8j4HqWINaUitM/fIHBg/ZHWgUuNO2sUH4hVU5a9LAguvqSinj0m008M7hVTcAOEx06+0Cyn70+L9Dhx42HU9cgWyrvqqRgv75UGQXSpTBF3Is/lrzDkXWPKrqSvMlUbi5OCMeKslxPZn9UdFLSt7unMgtNpbeTlU8oglnOBB5rzOQL1FGu5rWhiySsp9FOi9dSlns15cmdhqPvOfI+3lZSMGptMy871La+EYwckQiF5C1qf8DjdIZKTUiTBGAMKCtoFArSAL7phESPg0WJnVG6P44kiwx8pBkfzSCXSUwmI5qk5PUz3S2gUwvujsRTdgM0Il32QBCaCb8RZFf17h+DQ9tW7win3AST8pc0/CVGa16HYVjcMLRHhbgYSDBbMsM7+h4z5oFSMZ2gNN1+o3lt8Mqs2r7/iCjSOHJJy9RYI3LbDRcqXrBgdsEUUYGXpOj7bGaCW/Wir0PLejwrys834w9uwmuBhdDeMP/hdVlOMbPePNqmJTzuJMpeFCaJ0UzsymiwqOfuWNW5Snq/ShwIpHcvY6pLlGVXRqCWvcUiMgwr1wTE91V69mi2L2rbfQge9CxAW7trysT/kvXt/5oWoR8hrVSo9ovA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ff3d3-28e6-49fa-356d-08dde3f00f3e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:57:14.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOapH7b+a9/MAZ0I/42A+PNqlCcPXJ8E8oXoXsm3eoibBSbF/H64kzRKFtsCzX43F2y/FaWWFUCauarWpUuEl9945HgwjXYhi7mXpXDdw5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250144
X-Proofpoint-GUID: MRgd7iwWyUX3745nFOiWNPUqGKmm2jP6
X-Proofpoint-ORIG-GUID: MRgd7iwWyUX3745nFOiWNPUqGKmm2jP6
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68ac87de b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oMu4CXH3tChyjeE4K0sA:9 a=MTAcVbZMd_8A:10
 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX1/Zes8rsnQq8
 wncl+LLMticS4rN8jQXi4dtu+7SxO02er+c4vfu4chz8I6wKhbj9toxpB/qQcWhQ8ROhI0HWUIi
 uhXVxR1aXtzqaoIco/1eFb0hjfs5UcT60cEs1wBWLApSm4mDUyy9qt4BIOKvJs5NO57uXPOgJOY
 GguRAlNzEQu6ut53gne/1kHewu7l636BPImqf9Wg2JbGChStHldfG/n+3RvnFwt17i/zMk9iI8z
 5uFA/bKkOWq/ZBpPa4mK9WKGqyfiZJI6XiwgkfjidaTOUiIjkD31YY78oD+365XYZVP4IswIXsT
 nM+qbfGtG+93jGvahiMaZxkzTh8O+dE6FufV3YI4ui6/xTZYIzox5Vis+jpioToH29PAdysBBDJ
 7gps61gdD7qFggsixsdGy4kyzuEO1Q==


Zhang,

> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES
> in fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the
> fallocate utility by introducing a new option -w|--write-zeroes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

