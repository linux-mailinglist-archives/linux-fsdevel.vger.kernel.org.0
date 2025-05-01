Return-Path: <linux-fsdevel+bounces-47843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A3AA61D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1880E1BC2D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881222A7E2;
	Thu,  1 May 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQwCBmO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eNcSjjdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2C227E9F;
	Thu,  1 May 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118730; cv=fail; b=bVusrKzbli6v76Unw8fFNbyJGQk8yTYUf2embkWjo/7rDlxyDZBeRy6kYNfoMfc3D1o60euGH8YoE7DgQbQ1p+YWytCUirX9jdCeuQhBpVgergKVfnsb924VfjQTdPRlrhwiaMltrtHLBRCXcJJPjjBcPjw4K+2dB2NRWdOMHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118730; c=relaxed/simple;
	bh=9eT+lXdOnGGoGzrugdHnlM6/gxGf6vdsPRVIvBGiSt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RrZXHpC/9rV5t3uGpEW0yfOdvYs7ZIv1f6vkwdYWqeBX0ewFxcgAmmlsW93i3NhFoFjAbQU1zzJcpL0rSnR6CfZlXLCsPZW7GestTBjAadIDHnNhfVtLCJXSli+DhfaBtyolf18FrfAezBiZc6bZCLJNi3MhA2HXdBR0fdEKCeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQwCBmO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eNcSjjdi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk2gT005135;
	Thu, 1 May 2025 16:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=; b=
	cQwCBmO6asPZf02GLQW/CgoGgUFoGZvEN0p5ec8cRVuIVXa7E83r3qFGBnEfZ2sX
	0EOt2AeYdQIW+Ff4AjKnbM0ioNcFrQNIkZjmw75M3nx0p3+XWt7ro8mIIkDnIhHU
	S06XKGLQZtwpg39qy1BMpEmJYfc+wOmdbRvxlyl33aFH/LjxdaWYba8ht9kjomrc
	ScCHlizOBQUBzOC70a7ghz5Sa3UPCPOoAm/db8Y6cumdKWQyBjYQnjwcLziMd9+h
	4TloiCjtopPL/8V4gbDj5YkGVDSYpn99Vn/JsUkeH1fQ8wZIrzrg/or7zmuxF2cH
	ZF6iM1LNsHKr3AR8u4uifA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqkh2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GKbAh013815;
	Thu, 1 May 2025 16:58:36 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcs6x1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFb8grZRDDSHJbkD//maE97LSSvjRvHBvZ87+Ffq0Utrsu7oI9yXdITP5NIbW1THKmdT0DXhZ2WT82SnhmusXwnVl5kLMp2y6rQhifE95bn5g1sWNtogbBYB7+FeW6n8flvdqr+6T/r9vfNuCgO22riyjc7RLemfv8H1FIc/0ml9lMepCLrTxFz1RzJo5/FbO3Bq9hGRIeLX8k2jgIf1+FlTVXctBHy5bCtcPF/GXia8GjW7vgER/WgU54pp8MSi34U8G6Q+leyeuJHJbp+YCXuX6mQNa8MrahmuGD7iEXHs7G1Y8USghN8yLEuV4E202GkmQsUVN1zbhZ/4o34/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=gXmimvvOZtSz3KgzSBtWuTA8m3LSJX8kCVLCDjEd643uDHLigbg7UVwIAY6+8lAZEVDn9RLp56fAspLoLK8GH0HrOn39BYkz1kmW1beB2jgWdEVe7qOTVgTMapzUEdfj/YpuCs7QMH9KQ+GE42oTO+5TLIn7bPXElvVT6AjELkKZohJ3Vet2yeOVHCJZNDEBu926qnQNTGWL+2CEEhsj5WqXD/U8CSByv/f3MoC1mUgWJlvy57tc30Hhr2biQgRgkjJJJ1TXRd/KqgktLKINSusvVvi79ZOYhEooDnpu+DnyDPbhHUhRlzMFuSkH0pH6QMA569MofQTfj+PsO+/rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=eNcSjjdiEGusU2rg6MUWglula7xCr38ehgP5bBPD3tQ+5qvAPQHO3SW2VBy9B6uEvthTbTQQYG5U6o+Un4lzobYCGzJRJ3LOF9iuXJdQQab/UDZHvzim9AnrjvBxwT0x1yceO30aKaI95pMknzaBqFO8l/Iel26yKAQYHkwiuY4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:58:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 08/15] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Thu,  1 May 2025 16:57:26 +0000
Message-Id: <20250501165733.1025207-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 88616bcf-2a3b-49f4-4a85-08dd88d1541b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74PGsK3eAbSoilaiYU8iFg79n8YY4PLE786oR0yHSF1qSE+l2B5CX9sbb2Gl?=
 =?us-ascii?Q?Qw1x9AzEFkVLmgVE15IjfxgTB7q2Ng65dh3aMYaOF9ohKJ5xVLUlyMn/lJuS?=
 =?us-ascii?Q?XlQI3zRfVOqS5TkZFJ13vaPpejol1yY+j9S9ImCMy5crxSG33iHcrjxWd551?=
 =?us-ascii?Q?z7CfS7RJogGyAM7/NcupOmN6QmysqA9N9FJVE6e33s0kJpbeEQSA66iu40uw?=
 =?us-ascii?Q?KjcBwfXP7r82TrYt4n3pAOkb8490pI+3fPDAog0Yi8Y0Wbg4QDVEUc454k0x?=
 =?us-ascii?Q?5BT2KrDGnwePC6svVKO6NJxk/RIoTUwu5FccFv3r5MjEk62KaqwQaDLwoV1k?=
 =?us-ascii?Q?rIdrCepJOUAiVpxD4QjjKhY8y91k+gR+VUo52uy/WKPbT4To08l8BC+ukgH/?=
 =?us-ascii?Q?wfJtPKLzE2gklYBZXELaEDnUp24lC10BnMpn/9YC9QCK0fgcFrLIOvsmqLBG?=
 =?us-ascii?Q?O4Xhn+/yvEd+kwytSxg0dRH1c3OBFCRgtsMARpuQHipI/sLStxnPSQVkaQtH?=
 =?us-ascii?Q?wtUUTfunt03WbBZUCUU2SOJFmi1DlkMO+o291Jt8SDkmM89v6uzLmo783ZZt?=
 =?us-ascii?Q?QoOFHNhEpctLVkGSd/iYgmwnsmUEaPgFmsOMqGo4ULe8vCRdwvUaHl24aO0i?=
 =?us-ascii?Q?CL1W7UruNkOIddBoDgVYhiK9RXTpyLgpg3sgBBkXVOqg/4pJi9JeCGJUmLve?=
 =?us-ascii?Q?2PVVZt8m2hZxe85V3WlPlTLV/u9DdWuzhUy8geFAEjH8Vel8mri3ZZd5jBTy?=
 =?us-ascii?Q?0lzBB9OwjfoX+RIMLPGAqEp13fzKTkFKWQHRXj1TPLk1p+2fpqeMWhrCPJRT?=
 =?us-ascii?Q?A/0ZqcjfYIrNNGpmQMSwPBJdzyYqQajw9VK9lPuERcsl4Hi0PkIOgA4Rz2M/?=
 =?us-ascii?Q?bc2VZZsu+UQD+WNihyvhCF2vgO1bAT4P/VmF6RokJhLrkx1jo3Dbo8X3k8RY?=
 =?us-ascii?Q?rThNgWVj7S5rXjilMllyTxsqNMnZXR5+B8oQ4PfMLdLIAyWW7ssVr3F2tcSA?=
 =?us-ascii?Q?+pgkRFf+uvCETgRbgYKMBjR22Vnr8PB2KdsmX2bNT8MO1cRqVx8DEdiFFvwe?=
 =?us-ascii?Q?wdI8jdi1qUbhaYwN7evk5g2pwtK/gEGmSQhiPOLI3GHuD7gfwbfWXE9/0Fg2?=
 =?us-ascii?Q?qAxKH9wg56kakbhaDojUPyqpBPoeBNzUiXoFfjhMkO9PrBugo8PcjS3o5MAC?=
 =?us-ascii?Q?9xK+rwt0gFNWQCdNNmXRcnAf7LYDdHs/GfTwwYbcQiJZwmzF+uFMe0ibOAxK?=
 =?us-ascii?Q?WfqeoksgrS8x/P/xJNj+uMrOTf9F6m7MosrTSQKPJjr9bh5WZSDDuFirDSgj?=
 =?us-ascii?Q?rNbS/LA0XpgDdL5UiJYdp7VPkHD9SRK530BxMZ5s62+7qMzRxItqWAT5YpfK?=
 =?us-ascii?Q?T75NLueKXFqAPaXv7got9nlOFdVWEj+nOgr3RS/nYiNEypO3KzwM8QH2Ka/l?=
 =?us-ascii?Q?tBxjgjI1O0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6uL0+0leZUeVZrgn4XHD7rcdw4uGFJIU62TWu4Yu7QuVguxgpV4Zen3jGDq?=
 =?us-ascii?Q?VMephTmSl/GFH0S8YRPtnmTqXEspTIJA+w0zQ+bgJBC6aPW02pI0ap7xGAbZ?=
 =?us-ascii?Q?pBSpDYd8u/lhl2D8AwxPkwvDFRtwsSmjxYg8hGEYWwGdHnnEt8r745H4sS2/?=
 =?us-ascii?Q?/UCmySQW94J15BY9LKSGKP2PRk12AjTVZNcVMUa8sIg3/qvwY+6LPcvhrfJJ?=
 =?us-ascii?Q?Tcp0VauE6E4PIJfGWXG6BX+C7yuAdt1D3S4Sq716pAe8L0VS64WYTBlXjlXN?=
 =?us-ascii?Q?59sfNYddkqdfN7kOgJLt8HIpF5DkZ7xNJKmprCGyDhlIVgJ5d2TkasxgGkuX?=
 =?us-ascii?Q?yPIY7ra8Mc6UGvmOwaShEpp6uzjnhA6Y0g1YJAFxf3kmSCnaca6HaUguc3x2?=
 =?us-ascii?Q?9YWw2p1Iv3d6Tl7fTyNfmN2+Z1zcP2HT/iFe6Bi5Kpib3sYOANpHKdCqAE/+?=
 =?us-ascii?Q?kMM2eO8+2FbpMYxTm6JTkzKDioyDEQQKN6V6EJAjk4u/vOmZuFPCnLAm0Ro9?=
 =?us-ascii?Q?iGSHoyA1ziULl4Y+QEuHC1QZ2yQ0U0FgjjNppPqNJvbcBWuRJSSe2uIi7wcF?=
 =?us-ascii?Q?lAIAlhg8bfJB/BqEIyAlvp+zznKkLEjc/GJBICLKmRf455dwlsYPtLfRFLkq?=
 =?us-ascii?Q?NvmL4szNveOo4s1zcMocg+asTBvnRDOJV0mjFZMjczEFIV839Ajpug36Ftku?=
 =?us-ascii?Q?05gBKYEqcrb5KkBnWTVkpbqIA6P6EeBsi+fp0Y7DpmwuCJazPazO8B3yqm/t?=
 =?us-ascii?Q?5ebhNmoXb26sJ0vY65ouNfydOiPMu97TOLHISyrtE3+i0snGJimmQg9uE+qg?=
 =?us-ascii?Q?UGDQYkFeLxAhoAoTtOZQrTlE2q5ZG4KveD8LhhZJFphljHpMe14kxQd9VaNX?=
 =?us-ascii?Q?XaJvizFZsCbwpuZrrTM7ArmLC4nktn4EzrgFOUo+d1xWberrczdLhfXyZd7z?=
 =?us-ascii?Q?V/K9n63g3hldhTO4LsLv9DjSwsZX5IlU36/qo9o0J457yyRtHzOw0eyJd9Cg?=
 =?us-ascii?Q?mgjaKvG3iURCNBVDk/H+FfjBKAlL0AB7m6zk7dOXvsHNFBiOj8rLQT1xqwgE?=
 =?us-ascii?Q?qzbgGMkkOT3E0M/VG2t7BQO8HJV7UnQzjXGAG5j5G0gdHFeg4pNygdURmnJw?=
 =?us-ascii?Q?jSYMLIETl2s3ArL9I55jULqmle4pZHxHnIRhnvcWRur2eOVD7/LB5UwCPhNt?=
 =?us-ascii?Q?nlG9uPjcK83+9NqvpA41Uc1MK2nSUjfLOKSFR+hjAop8zDXsrfEBUwSRCqr8?=
 =?us-ascii?Q?bM6GXeTSQm0rA4YN3LYd/aKJCmxSS2iG2eX1AGiJsLdANj4BjmORpBRvv2EJ?=
 =?us-ascii?Q?2XMy9qU3dTb8D/1eD8KH/jMshgc3U9LMVdgufWUI3VrbhxqGv9fbqwwWSKnH?=
 =?us-ascii?Q?oDJM2lD0WbnBw0mHS4F3J6f7oCuVtumI7h3rRHmP+a1iZRMZu49l27D0jY3a?=
 =?us-ascii?Q?CupQygTWDyMNZT1Ct1XsNgn+cECWKBddGcmlVN3vZbfi8YcOnW0HVFIoqgVU?=
 =?us-ascii?Q?ySZXndX3NYOlUfJjSHmKWRJO0TBZmTeWHSVFYn9XutyB10Srp4CJG1rOKfve?=
 =?us-ascii?Q?+w3kkYeHIKC2FKpyWK55c3WQICeeMDG5qM57yWyGwvrPoRgzbQUV6ZJq+ICQ?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4AQy6LlMniQxnEVmLxj/vAVAx8b15hnN7JTayGE6c5RQ2qQynQwWMYIn1hh7zYGr2lhOReR1ZHm6JD/PZ8rlT94ZSjMbnG0R5lKQ5awaphCkJyq4kiCy8diZW8AiPOoDJM20F6NUlKVwOPCIUerz8IdlPddt8gSyy5snmx290VZv0DQd2QesiXE0NCBagbasvO4U2z3S0ZT9OJF661s4HTsLooTMU/H7YEahwxV5JOCdCujM0FO+USVSd9SESJwvOcFvsZAcQIevCLSPCWg11csBi4moe5gVKrKkA9mN3/SfVAlekpymnJSCiS1sKb31ye2wQ/FYkO8lNkARkJvQ7KwAeSp3BqFhcqanU7DMVbLnkzM/cssircmGlG8gfvKXLR1Kwxmj03mcghB0pSuOh7CnLs6WZC8VQisUfIBT0AY/vNQJT+sbcDI0Y0GfID5Al8w4mvPAzbkAvKo3DUwi6I8gnCvTkpD+jJghUtr+LZpoSKFlXf1nWHrIWZ63KZCfTdkbuo8ys38KhWZPs96sMrLfdbIisRcqYoXYIrrHEEkzXvqU38SK80hhCkk/wxSOdERbw6qd56BDrrfdB3y6A6CW1S1C1Sl7Vo/CoK3xj+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88616bcf-2a3b-49f4-4a85-08dd88d1541b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:59.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ee6SUzDY0i3TT6t9zUdczFGeTA/6gFgNQX4Q7i+M7uqQa60UNMxkRydGdm96Xpda+8jwQBMG2hhQiO3RwINAnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Proofpoint-ORIG-GUID: 18qpr14o6N5f0Hgt9EQRntBPgyXev7Zr
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=6813a83d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hT51KhAs6gTkkLCEbPYA:9
X-Proofpoint-GUID: 18qpr14o6N5f0Hgt9EQRntBPgyXev7Zr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXzHWPESo5qwj2 Y+yfnc+aDxW3fVis6u05pya1NXtqvReEe6iJQkUCExOlpUjuAl0Av+guyhm0OLEd05UBw5jUhS6 wcUzsMLwIYgBk2DKinoeOctbtwN3nVGLO9XqE4FaL1kSrTD5o3EUVmWWMHsWDJ1IWqjw9wcexFq
 dyknDB5yXIqdZyHIg1AxYjjZqW8LGzWJZD09FsbS+dgxl8ueTiEu42zpn/vDEgaBexgW8PGpbwd gNuGtVhJlb3p4VBPHrxDc7PeBPzH1LI75e5uz2cso0PG+wb3Y3hWw3k5o0aXPNCU9YKY/6wRib8 EncjCHWA7Km2J/CpkbB0/dEmu/5nydNDG/Zjgg3qwRvH6Mki7lKG1JMXcF1HxRcdXTZGijyVu/y
 QNDTmA5E5nIgJQdLCnJoEjgwPOI3AsYc+h6O0Xb+Pjl7WhNKSOrdyQaFBFReucU+Ba9r3F7V

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 55bdae44e42a..e8acd6ca8f27 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 22432c300fd7..77a0606e9dc9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomic_write(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


