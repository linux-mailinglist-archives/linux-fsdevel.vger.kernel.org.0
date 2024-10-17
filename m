Return-Path: <linux-fsdevel+bounces-32260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E49A2DFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A401F24D70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C822738A;
	Thu, 17 Oct 2024 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BkWTXW4R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="skBwsOhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D8219CAF;
	Thu, 17 Oct 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194059; cv=fail; b=kmq/L009bGtTgL0fSt6XdEV22+rbomcf1fAVb2YD6/Zwmdx/GDPTUNthOV5J0/Z9N1zw3u45VvnCYRQ1x7JQxNXaCNyaMQ9h5LJ/u9yeUqiGla32q6YL6Ey/NaFeSeUgWc+BerNhk+3e9soiDetWlQQvyvQfYZtDlPm7KoTRC8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194059; c=relaxed/simple;
	bh=hNGRtktqdpIlcVmCJ72i78I2ayHRGXqSqoYLRT2GvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AfofGZ4g/NZUeTDOZxb0KOey0FLDaOLfCDE0RYKdrDupa0/K/IwefLVDk3uEWoh4nz4WH2LTNgD9BwaOgScuTeAHfvcLDOMfS22jKj+cVNrH17rlLaZzLlr7+megVDl+NgitfyREE1Whj7G9+hn6M9Lu9a3eEGO9vn8MMuBFadM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BkWTXW4R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=skBwsOhx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvUI024516;
	Thu, 17 Oct 2024 19:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/Ceu8/wwh7+1B1fFKv
	lCde4rlsfKugpyoWExq9/8VzI=; b=BkWTXW4RyPS854G+UmJgHvMuO16MFU+6eP
	0N4nmMyv0KA7arCP1MdbdS7Q4Y885wQrVTr13WBZnZOvHEkI20xV7po7dKBwyW1y
	ImION1E/Rp0yhCtpF7LtuYnDumeXJMrPFa8XK0yeeyE4dXhpabL5Uh0W9yyuBctF
	MQunrQuZM7dJSfbqi+EcMTghqcaMnhCLsnNv44LCxc0n+eeazvUt3L2a0G7gNHdO
	EoEwPr3J3fsYeWuWHo7VhJOajJeYVbKxrNRRUY8D/DoR5qZEOYlqVowQFx7T0iOi
	i7T7BJ/9V00q6he8n0W+WTU2AlhDvEszdvxub7Qcb5lryxQ6dUoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpv18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:40:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJ1CNr014016;
	Thu, 17 Oct 2024 19:40:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjapj03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyKWJ6CYwhtG0vSGRlp2jBqKN2EWKYfmvRzo5wz26taYmhHaQXBPqtSGvXgBUP1X1CQvyaW4qjK6ZZB/bg5r/ScDd0fmWCKla+3BG89gumh3cXsute/w981D123RO+oQRqLXI3OCz/r6zQgUbrbg3hxp1mwTIRRRy9Ttj2f7KB/c/PY27LFbrUC80YeW0sPsLfWbZHw+I5TCyaWoj/ZDh5h27nFBmhWXWpOIzlqK38C1E9s2U/lN7IauAePzhXJyhMew/uQZil+4x/q0VY1beezJP3R9f1dAJID9Y2DEB81ZtXlXZLpKJrEPt1SYdJ/Y7MH1rQHse2Bdupfw4JRJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ceu8/wwh7+1B1fFKvlCde4rlsfKugpyoWExq9/8VzI=;
 b=Z1zD7hnnUF87oRPsEpUXOm2oQBMfryR0mfFMfHC1emJk4Tnya3CXJfawWPEZMFbhEwSgeSSgh5quOUHccaaHMOrUsxnKx7ORoJAk9da6AKtUjDsy08+qvp+EW+X+8OMxJ5IeiNW5pJqntzKjhp0wwOwqiLfCGMqxKe++jyis/8A20TlWNkyFgi97TPi+HAzDxz5eUEknGjzJ3N8Dfxzx3jXF1QRyuj016S7ZAQFGVpDpTsmnPW6O0Bw9DoGLQEgrPqzTdVGLDWVQvIIuBkw+uV7Tp6ZLYglJCBtZJLvpw3DBg+H5ZXOBOH4CRkf5MyjbiJoJcJ79p0GNClDHq8ZuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ceu8/wwh7+1B1fFKvlCde4rlsfKugpyoWExq9/8VzI=;
 b=skBwsOhx7odcwzd37VZkeHgFHKjNAEK6yJbWYhqZjtd0krcoBhCW996EmNJAw8OXfXDsR4UQkQY++5OrClPltSBPkWBqNK+YBY0DMV/TeK0DEm2Gi9gNxVhMAhG1MIzZvOmmkeOj5nrX6HdUTyHCZyY33JLkfjV+X+TI7ItG+x4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 19:40:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:40:31 +0000
Date: Thu, 17 Oct 2024 20:40:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <b7cb4e50-e623-496c-9cbd-e5882ff59d8c@lucifer.local>
References: <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
 <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
 <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
 <a6f56949-7db2-4587-a3c7-3c583cba2fe4@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f56949-7db2-4587-a3c7-3c583cba2fe4@linuxfoundation.org>
X-ClientProxiedBy: LO2P123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::36)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 31acca11-9fac-42a0-d441-08dceee38fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiOolz8jcXsfh/belejXxakgDuZQ5Zeue15tUIxm3zVPe5FQKJwxk9+0eSQt?=
 =?us-ascii?Q?2FXgn72MkGYtME3G+MT35hJIZY6xT4nfTzPn1JzzK84yFsHhrVhxxCwAvQim?=
 =?us-ascii?Q?HmbJEo7QGI48G343uGEoTmJZcwsgaIz51BN9hgKHiP6uhGaBPGjiESDoGOsL?=
 =?us-ascii?Q?1rFOfWWCvrssL9IFefitPdVNzIcxSXunHAGSGDJXc9maL36Zwj+dB3kY5wis?=
 =?us-ascii?Q?bvPjKlK35JR2Aya5UZsg6JMpNFrcN6IrzQQguXrgrXLeqH48TE/N5QK6SrbQ?=
 =?us-ascii?Q?9Xma+UIA9v6iWfDp1c5Ws8aeWbJr1IsMm9QoTF2AKmZmE30l+1Vp/x+6PBW6?=
 =?us-ascii?Q?JPAzPe7Md40WrZhOz67nLUXSaI/P+jk0Dzkq+XHt0BpDbIm9klkgIIME0F78?=
 =?us-ascii?Q?f3ppP5/Jo2nSx6Pmw97hCQHYTMEn58s8q9fRBtIuO85p2GBwbDVZOVD8dEwP?=
 =?us-ascii?Q?wLi5DmhBIsUgLd91IzvVzeVX5BTlE8Q8dUITokNg1RIaNhZTG7b16O3dKgk9?=
 =?us-ascii?Q?kskQb9Y0aED281pORZjb50HdVILT2lQO+zKQxa+x0ZwI+Q/deD/5nww75MmJ?=
 =?us-ascii?Q?xY0FXWZurCoN0BoIicLu6wjjwmNvTRkYX7r7h+GdT4QlmclZFi6RamRqNks7?=
 =?us-ascii?Q?NQy0Fit3HB9FsU5XYA183iyCQ1QvP2tj0Fk/+qbacaNPbBkHKnv+as33dBG3?=
 =?us-ascii?Q?9UrD8XpkOWQp0ainGzxz1px7+qUvsxFoi3eqYa5mdwJdpoVgFZALOhG3K5Ha?=
 =?us-ascii?Q?mixljAAgejOrt7cUrI/TRk+dU/yiWjxeK8NYXkLtv2PT0CVeV5O/aG2CseFe?=
 =?us-ascii?Q?enWFnOsJ8HSLPvkbIfA+IMFTq+72Yr1/pzYUy31X4ExntEj0St3rOF6CE9oT?=
 =?us-ascii?Q?8eN8psW8NLpqm+yOzx4/y74RLLwKIm/Dx5HjpnMPWDeXpNfcVgqj1QBFz0XL?=
 =?us-ascii?Q?zhAO9MDoVPtwNBCgfyyydXi6uebaFMqf9l+sOBH8nsXfl7fgL+ZXPUZ1E2Nw?=
 =?us-ascii?Q?7fwZJDVw/uiJGcbLOr80s9UnWVqMnBrfTdOBbMlmfmisWntBMt2XuVkaXtKi?=
 =?us-ascii?Q?SrGJoHVHCzwU9hPm0mgVXNNESwbagj1JXXwRnIR/vqvZrwPb9foJYsaMJvAs?=
 =?us-ascii?Q?szDKWdt/QU06vyDiTbaOJzzmYa7L05uXY0UFD4ZHpAVG8tHLg5KukIX6OFUX?=
 =?us-ascii?Q?JgI0ae/Qvbdx5e7W4m+i7AmrH6199Pt311qeA34moK+KYI+AKwzoGhefaJq0?=
 =?us-ascii?Q?0bBsWEePCmueJwHpL9ldgMelVbAHIL2LQdcXThrGWcLm8NJFnOl+uY9M7dXX?=
 =?us-ascii?Q?xwoVAhiOKhnN3yT4zMZEl036?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xR39j7WpSb0PLgK5pF71n2/HPhzPF0D2od4E1qBV46BEaKXBoA08bSvNxCH?=
 =?us-ascii?Q?8ZQfieELfDLkgYDyv51himhsIIjGYX8eyW0dobZCUgzcwuIMmWCXQ2cJJU64?=
 =?us-ascii?Q?UMQ7FnB84i0AhzeU7+qVcUV4esFc+RXs54T+ShjzDFLGUc1ex/YXnMb5uuYm?=
 =?us-ascii?Q?Z8jWCYTu6Zq77PvOgiVUDV8Xgdg7QcLplCGsyBhWTK8B9b+sXE+suB8clcan?=
 =?us-ascii?Q?6VVPAymt57oB6BifchO3BqtcwrGQx8rZgYEqR8veabzpJJSVUStTq+zUQNnr?=
 =?us-ascii?Q?M+/IZxHZ9tKKAxKMuLUti3Qr+ljXgTWvhAH77xeq3uAAGEM9uQyh6BaQHU52?=
 =?us-ascii?Q?lPvQjaQWc9+ed4GwFJWt1bk5LfCIIzUlko27Pi6OPmrlLbYu1XFlK63Cr6hV?=
 =?us-ascii?Q?QBsTRNR5si4zsvfF0K/2JcEGeJnpXY1Jm+d/vRH9/WPnA89Ge45Sap+VBqkD?=
 =?us-ascii?Q?kXOBQT+MLtvIH7rQvgJkcS+vKkn0MWGoQOKckHrHU1Xi7RYGX0pD65Bjc+YR?=
 =?us-ascii?Q?Tj65OU2YwY+QtLorcG2Y0kesomECnc+F8nVf/5daysbCLkXaX9BVPbaEH20b?=
 =?us-ascii?Q?qqU/Fpi6roKr03/fZAEsRVMiwaTFzNNfBIAPcaHsi005mqEsTXyLq20x8qeq?=
 =?us-ascii?Q?D+AMRHc8Ki1obG9hcTtiNRryXJHaLFpWROBFej4xQXrYvGN623MosPSK/dp5?=
 =?us-ascii?Q?g1eHcOlZDrSZhG3zn0f9WcRsy/D8z/ZqBigl3LXvghVHkF0zxO7adzN48BXH?=
 =?us-ascii?Q?IeE0cQSCEQZl6+q/dTxsc7tdQnE7VgiwMgwUnoDz8ZU66WvJ6qy4XrY+cBbb?=
 =?us-ascii?Q?HAkDWFNArgMbAEbK1EOBmaUYm41cLDCkoI2HcrHTeuE9DSWyPcaXQm5h5LGn?=
 =?us-ascii?Q?X0UrRSLpFKLrIl3tIXXjhKR8ruCncYfrqHGz8RfPC6YNAQyzDO5GgojQE3er?=
 =?us-ascii?Q?HOP5d6jYQHtZ4Tb2/NqqUfQy6zrSFKSs+zlW2dZucwJUeM+v1rPtvRnntzuG?=
 =?us-ascii?Q?JfOIBsAwl7tYvo9O32as5jOIl69iivIZ7TqzPs0hXFFaMQQgpLgdQpg1AgwQ?=
 =?us-ascii?Q?dAXlR3Rdgz5U7e2HqswYT+nN336bM7wJz7haQiHcRYdbLYs4zi6YlNA5ssvB?=
 =?us-ascii?Q?3x1uTe1CbOT2CWR26sJ9mN0BuwcGJ+1RZDCgDKi8Qo9OXd6DmA2cSJWwdDhI?=
 =?us-ascii?Q?KdU7/6qufE1CcnbHIOvWliugQKQwIOkUhm9CfsDDP/BVUn+lQZy57hBXQxP2?=
 =?us-ascii?Q?fUrk3rUmcGudOUASU3+bX67lcfHHDnqD0wDJ1GyvcgY7NdHVouKW0+wysmfA?=
 =?us-ascii?Q?sichOToCS8D+rnqLDVuq4PJZv4M596vFY/fZ5HQyA7dSVjKn39EpLKFYW2MP?=
 =?us-ascii?Q?mpk6jlg1Qi5+K+yymu6ON9cJOqsb4RrJjDDP9B3UgzfZXTX9hg1pluFdRKgN?=
 =?us-ascii?Q?k17iLezqV2eEd+Xrr6NdypVqbl+ZIVtq3OyyYKhbG9FdMQSr639DFyeX2qN3?=
 =?us-ascii?Q?iSW0ETx4/65EuBjLVK58lRguTs2nsLDobWAvigcwaJrA2971J1BEDPhRa2Lk?=
 =?us-ascii?Q?O7wdaL5R+O0DfCmzqg39EndscKxWCrAAVT41/LePP+mIW5rYxJUlgfZgC99h?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AmuU9mgYxM2/tiOQAn4j8DmoDIYf0ynnFpkbnVNHAmaQ1QgSQ5FHUKZDX1KAnE/DFybHLmAyDBgs5wW4gS5jGTT3xxCiAjIn+UoEta5lbKyvBI6kfFmp34u4OiA513eSeRz42Yl/zB5magEVlJgOPZn+TTjwl6tLBMCdbZewkeyM7RVIo4AeVGqSluMYnGzMkMOdEYoJzpWinJkoHIwBp4F3heTtgeG5oseLVtry1yH0ciY04u03Jprv9UrjrBcr2is8ZYWZ0mBQbFfSKe8q6O8Fd11QYVQRgW+jrzxnhPodqa2DaL1Ltnz/oJb7m6N9cE66/r+x1WS6/TdcBe4QsfAd4rsbdBV4O5QnLfkYeHij/BCkNf/a8oIzjoRwFspKep2VMRKalMYMXXy8iHVUFm52Mif8CxN59vXqyTckKi/O1Gs6jDctlax1aDQ4jw1V1zrjucyqIUej6rjp3h7tLAzmz365AcIjU6rn/4PJ7OAl1ZvZ4AdlXfd2oK2me2GETnI++xAOUe87/wyqbIu9x3BdHE1HiwO4VX6X/sUGjzbsMho6A1R6Zyr6mFrxLyyBWTYDQ9yNnbsVKuwc75ZbelNGcsJCMhwNkfeuyWsZaTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31acca11-9fac-42a0-d441-08dceee38fba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:40:31.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r6FolEbwC+0d9aUY4RPWB6jDp8p9bOcbfcY6kqVdXngLcQPfp/NLFPrW6x+7FaiLXbQ9d4d+gjP4WN/yHCx6mftW3Fk58SvUIFAjciAlco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_22,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=974 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170132
X-Proofpoint-GUID: yYSDmwzVDTbJ203-qsQHxOZ6pGJ4lzAN
X-Proofpoint-ORIG-GUID: yYSDmwzVDTbJ203-qsQHxOZ6pGJ4lzAN

On Thu, Oct 17, 2024 at 01:37:06PM -0600, Shuah Khan wrote:
> On 10/17/24 11:38, Lorenzo Stoakes wrote:
> > On Thu, Oct 17, 2024 at 10:37:00AM -0700, John Hubbard wrote:
> > > On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
> > > > On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
> > > > > On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
> > > ...
> > > > > > 	#ifndef __TOOLS_LINUX_PIDFD_H
> > > > > > 	#define __TOOLS_LINUX_PIDFD_H
> > > > > >
> > > > > > 	/*
> > > > > > 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> > > > > > 	 * work around this by setting the header guard.
> > > > > > 	 */
> > > > > > 	#define _LINUX_FCNTL_H
> > > > > > 	#include "../../../include/uapi/linux/pidfd.h"
> > > > > > 	#undef _LINUX_FCNTL_H
> > > > > >
> > > > > > 	#endif /* __TOOLS_LINUX_PIDFD_H */
> > > > > >
> > > > > >
> > > > > > Then the test code needs only to update the pidfd.h file to #include
> > > > > > <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
> > > > > > the pidfd self tests Makefile and we should be all good.
> > > > >
>
> I like this solution. I should have read this message first before
> handling the others.

Thanks!

>
> > > > > Yes.
> > > > >
> > > > > >
> > > > > > That way we always import everything in this header correctly, we directly
> > > > > > document this issue, we include the header as you would in userland and we
> > > > > > should cover off all the issues?
> > > > >
> > > > > Very nice!
> > > >
> > > > Thanks!
> > > >
> > > > I saw from your other thread the idea was to take snapshots and to run scripts
> > > > to compare etc. but I suppose putting this into the known-stub directory
> > >
> > > Actually, I'm not running scripts, because the only time things need to
> > > change is when new selftests require a new include, or when something
> > > changes that selftests depend on.
> > >
> > > > tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
> > > > here.
> > >
> > > This is the first time I've actually looked at tools/include/linux. That
> > > sounds about right, though.
> > >
> > > >
> > > > Or would you say the wrapper should regardless be in the uapi/linux directory?
> > > >
> > >
> > > No, not if there is already a better location, as you pointed out.
> >
> > OK perfect, I have a patch series ready to go with this (and addressing
> > Christian's comments).
> >
> > Shuah - if you are open to this approach then we should be good to go!
>
> I am caught up with the discussion now. I am good with this change.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Perfect thanks very much, I will send out the new version of the series with
this applied, much appreciated! :)

>
> thanks,
> -- Shuah
>

