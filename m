Return-Path: <linux-fsdevel+bounces-47390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F498A9CECE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700851BC55A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A21FF7B3;
	Fri, 25 Apr 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAbJ67mJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fv+7D9Mf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8319A2A3;
	Fri, 25 Apr 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599678; cv=fail; b=sI1gpiII9FCyx7ERNuAx1ENwwxtsHrL8GvevbrB00SuDWgyGo/NLq8bGvoxTZKEcgWPaWcR/jGIbwbCn7IZrPRKGTnnUUcx3kk6PPorGl0ntbXzC5RMy0/NFP8lfq2KHtwHP6QMbUDXSnhaxCBP85TRlxAEQbBpcOcnXLl/bMqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599678; c=relaxed/simple;
	bh=XwarE5lozIuD/DoeA3qDqC0eBa2mHAhvraQvBi8WVB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuC1S8RjzV27zFKbHr+gOl1UIgscl45uo4kwTaPg+zkLt0yubzDcz8XwkTaenJEvU4m50aO5cHVG3THoomUPDKx5t7LeBZgPKGZl5+Bzw5W9Aavu1Luj8IsMndjwG/t4U372l48o6pwbaOgjdDjbQKPB5hWetMYaxdjredjJ27k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hAbJ67mJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fv+7D9Mf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqVev008413;
	Fri, 25 Apr 2025 16:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=; b=
	hAbJ67mJJaT/LBIJMNvpmO4RLTYU5l2M5l2iXdZv+yguoCN6GO5jggMpdiPTHGPV
	sNb0+xMv5cyF1/LamKsJzXaTRI9Nr4tOTiWds/FNXwvKVuSLHyz9xgonF4Lvixgq
	zhYD33houXk1OTVbKPBJM88DIH7uMheCJIsINkqBL+6nOXr1bcT/8GDTbQjk0bJt
	IKgqaYzDlajBuAU2Z2tdXe8Q3vzB4TmWwvuMFvzKRwAGA6YMUbkSRvq3CP3/lvRE
	l6WPWUZ4c4ie8b0P1wpefq6zY4VX6JGWJ0ayqXCtNcHR6T78NZqgEMBVjatl7Lke
	A3d+QWkX1N0IjpNg5XPFhw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r9f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PG17KI025167;
	Fri, 25 Apr 2025 16:45:43 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pud19vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nebDDEv3r2ZVQC88ie3xR1zWEd97rCGOqz7M6CPA3Ah8LzXWEcxLic33xhvj6KOEg+x7bvof+V6bU8B50Sr1cXdNtwAjjw1zAA0IIjkxjKWfu8qxcoF3ja7e6pqOx5FuvhOVi4kc4mf+vQXgDZyXg4omLzfgfQZfQU1h8KHFrbOTjlSVAGpeNC0lqPp9Kce0KmItMFaBXcLwtfkLhdoXdprhIsJtDVyrfmBoTAgmewtQGGPK52/+LU9Z+nxol+tAlqN/hPsMc71cz6FsLpgmd/n0gtsIgyDKHdk6CoWgPcJlGGsvXpTzX2qmzrcrBRTv4S1jV/cLIrRTAJcPCwVgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=;
 b=nrrfkDlTB5B1eMjo4d0inyzz+pOeMcQKoer9LhxMu8qVQHmiOJejwv8qNbBmZBOA7VnNkjeZ/5pihgaL5w5rQGspV1iF5Usu4RAJI1z7haYHP9aoyO0n/n4AWW1UPlW8RJBKkA5gGI3zNzApv2MH0GqqwBO2INu0JJCxGXYCk6xshAtCYi+c6dJazdwywtNcHUMvWuLNEmNY82SGuBJcjz+7kwFoS4+bc8al8GlV9cTkfZzBX+AOUSZT+tgmN2Rw/pyXGmoqPSblJm2if8QgQplnfq2bEpQjrEVBUvkVHbAuWxiKL6UiiSN97R3VvCS0jjuieOtQb8AeZlibHatz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jrk5rO0oKL5JqCtDI8hF+s7OWc6MOeUBncPCr3djAM=;
 b=fv+7D9MfobSlkyPgbY72i7850tUoQ6vG9ELeQdSb0nHgQ0D9kad9j+uKvN8e5VaXrIxU6gOPoyvbWmduYvHXUlmjTHhgs33SCrXmZ3K85vdM7vMf2Es1alNy5LM3PQGfI2Jbfkje9K/J40Nx0SRsy2iTEcLowZp+R5oEgGaBzUk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 06/15] xfs: allow block allocator to take an alignment hint
Date: Fri, 25 Apr 2025 16:44:55 +0000
Message-Id: <20250425164504.3263637-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c712e0a-9f79-40b2-8ec3-08dd84189d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykDEUm6heENH4o2nGNNlK1ZcOUu3IO33olgiJ6gfQrm97snCVoy/7in47pRI?=
 =?us-ascii?Q?ii8qGts2YZv5+4X3hp3MoLshqGpuZSt9p0t7oeoLTR8YpP2sD3je4AeuaHdW?=
 =?us-ascii?Q?WJpBMgNxOmiLCBVCCAmqGkvHX1Fef/HKH4DCujh6T30pBFDBzxayPdkmQu6X?=
 =?us-ascii?Q?0tYbyKkyRcZDOfp4v4TKR2SzmF/9gaZzLsVohNwMnTn0r8NOF35JmJRA/uRc?=
 =?us-ascii?Q?hVRu+9cdUfEizeW03QHqu6j9v23GMsqd+ZZQ2uf1dX8cShl4Pw7VlSujTKMc?=
 =?us-ascii?Q?zxTbdSzIaIyt/lfdkOhbV9Iggi0zJHTNhnBfFeEE4rcho6pRrUBPpCgXd5Gg?=
 =?us-ascii?Q?ImEz+n1KhTNmz7WpARwRyyGXZijBTpQikDFScfOkZUh3dyOk+FxI6RKGNdHx?=
 =?us-ascii?Q?KnEAtwzA765N+3gtSMRms83KQj8Oc8U+w9vXwAfP55kjBzw9+JyRUc6kbcbr?=
 =?us-ascii?Q?FZ4WOlpMoBUBx/4e7y7K6W99IFPFBJlKHsP5yFByuYqSVd+x5z1QUYzGSaKT?=
 =?us-ascii?Q?exMkcX+OcJDPhzjXVcRZYfWMb2by75FqimmfhTPtfUPf7U7NfOcawiZvsy1A?=
 =?us-ascii?Q?foSJVnkBykQF5XFffQZl+b+7rHrFjMlpQKXOdvjZWaaX1zIyE1kYPOfLMH8m?=
 =?us-ascii?Q?eF/DdqL19PU3zA1c2tJNnPgYTQn4FBC7AN8WuoDKPxreLxbDYNpiS3rAqsWF?=
 =?us-ascii?Q?Zp+9HeS1SFP4LyBaQzwVqu2bIsQwQoXxD9Wj3GGE4llwwMsrJ3nht/Tx8Mu5?=
 =?us-ascii?Q?jkKiJSrL+S8aMCSwnOYDJzau1Q4GYZo4NfXg0cF+8jp/b/JBAy11V2pzeOqD?=
 =?us-ascii?Q?x8l18/JPl+E7RYLIoNiyoZaaICLBpLaqcW8iighjex7p5sTizrcChuYx6bnf?=
 =?us-ascii?Q?2nsUXd0EcIcmAiYhA1seE2kiAfbBythUk64RjFSENR0+Lbr1EnKdSiqhW8pd?=
 =?us-ascii?Q?VW0XRAvOy/UISQQm2EzJeaw9oMrF4ycNwZxX4k9omiAGdFB8Wp1tEPDxnqqZ?=
 =?us-ascii?Q?i7vZChqPxtLTb1SWawvdUF5bJbUSkhvU0AB4tpl9eCwmcaQkVIRSj12mB3R8?=
 =?us-ascii?Q?D4kDi2VS5IOLjksAuyN83giWm8llnuwI7foajQH2XcU9lwnnjdZGSfNvTGdl?=
 =?us-ascii?Q?7c5b6H8bLwA4CWTC5i0gSuS9s1JFc8M3R+Zt+HvxHb/6Gz353NTNe5MQgQ7D?=
 =?us-ascii?Q?eYi4TVAbmApY4xxFzTDfIDTUyeb9COQqkTQCU5Y9Ua6SOBgpXULSH0IsSE1v?=
 =?us-ascii?Q?PlPGMxCVmw160rqYNU9vhKQBs2KL0FSgpnAowHPlVjTWvEn+U5flIQXut9h4?=
 =?us-ascii?Q?8s85vPxBvGTC6hSgSg9bztVohiNLYJEjWN9GKnQ9S/KhCnvAuDH6VHQU7QTH?=
 =?us-ascii?Q?Ik81E/V54mcrxuUw3KkFPe26kdXMr88Sl6IU3+UVWyrzhDDhHTueWTpOp1JH?=
 =?us-ascii?Q?btUx77i/OC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjZljkkwq3nh0a7vN5M+Lu9BMWh4B/zdmQkrYUCHySPmSRwREuc39UUh7nMl?=
 =?us-ascii?Q?Oszc1CKX9y6/k84G4qAokkqMKUlXqXAOmcE0x5KyjA81hhPIC+2H2+trjCFD?=
 =?us-ascii?Q?0f9WN7ZqlJ2utLM0d0UM8c87VByl/pUuZkwArjMmXCMsm/6b9xttvHe86K3K?=
 =?us-ascii?Q?MoYOi+U34GubXWSwGJY1AI5YRbxmwf0tJtlFeuhIa16LlQpwmO0CGoXlEDTR?=
 =?us-ascii?Q?ILMX71qrRUhJdfiS0/+BAQUHLhAYLTqSZjaHvQy5ZgPu77vQ2qBYcxIiK3H4?=
 =?us-ascii?Q?wOn41kmdrkMWsFQJUDvIUONRViihVzrVD6xqXMqpAiN9rPtygE99709Lbshc?=
 =?us-ascii?Q?g0Y35xrhXq3rYzyfV/M2NhfU6YzNaGXQKWLDaBB78SB1rFpKcntxD8+1flsa?=
 =?us-ascii?Q?yCgqfAH/R57pjvd8TtAkveyEMd4snXE5sJXtWo+jUVIzbVel6nToo2os4u1m?=
 =?us-ascii?Q?37gTzxjymaybu1t0ptOAsEA91yPiFQp7Vdk5eklN2aq0HDl35ZmuU/5ojKbO?=
 =?us-ascii?Q?oMpebiwg2ZySfPJXAsxGj5ugbI2I9z+uWDbb94s8LF60BerGUmqJ6I1SlGDU?=
 =?us-ascii?Q?8MEa465UUWvMlsNNxa2Wln0/o7us1l2l2fBWLZnEVvMnbC3ZpjrFrU/TEhUU?=
 =?us-ascii?Q?Bu4rZ027prTo1y5DVjA+y/USde/nH/3HTdNRHjoN1sDApnzW88YGynS8ZhfZ?=
 =?us-ascii?Q?okm7DjX3ORMORQlXTY/PWIk9YXWh5I4jIG/G9CQQwcx1GyfLdtP6ZiMBdDrd?=
 =?us-ascii?Q?1U/lEWPGy/KGwPpNrBS1xbV966flmXbKgG9RqCxLQIPEnjNVy86rpEIyEvYF?=
 =?us-ascii?Q?KUk9M1D5MjFfIEszZI9S+DXmJfAAMoHZ+3I4hnz9YoufQYxn8ondAz6/Wslf?=
 =?us-ascii?Q?omvZpYxm7T3Y46pdr6BJIWbtmAm7mMpAV3UEpZzCCdpKFjcswQulSfG3yi+s?=
 =?us-ascii?Q?Y9joLKhdHZpy+D7ozjB2QBhdVqtwhkKGsc+Yc9w1YlrInYGAzS12DuO9/9q9?=
 =?us-ascii?Q?EL0fVsQoN3YfoL9scyQKGM7vUjkfa8sJUQuaoCtqFRczb2jmLsHSv0+bSKUp?=
 =?us-ascii?Q?tONRiTO3EEJKfT8pco7q4wKRwIRhTbZFs0g77tUrnvrnZcnpTz6wm+x+qE99?=
 =?us-ascii?Q?QaLXjJS08TsB4eXMAvjOtLO3mAR/RA3wjKtyZMuf1jbWKHj5/K91Pi3k4WZO?=
 =?us-ascii?Q?Pzf0fEvYh6jY9LGYQbEkeKZ8Uqz2FpqmV2bfl44536Rgo2t6pkuuQCfLsWbp?=
 =?us-ascii?Q?nGFOP8eqJNntuw7/ITppGI6nWoPzBfU/c9BYVbr4jlibc+RawhRK3GyYAn54?=
 =?us-ascii?Q?AX1l4ICM0NtQisP5lHkOcZBPeMOesZolhsrEfwZUfPMj0yOvMNfAhQoOAUb1?=
 =?us-ascii?Q?7ZOACWU2eFs+S2sS1jCQYp8H963wD/I+UQbflRs798JZiCBUMU7noR6AQj28?=
 =?us-ascii?Q?bUXJqivASK1Ztl8yQ4/GlwpdnIDndNsGt0a7aX2n3aJiLl2L4mgOY4omzU5j?=
 =?us-ascii?Q?uv73gVbnTPrgfoBrmdu5VmzzuNw8tu242y5k0KKz/23GRiPQ/uyibg6+2Wqi?=
 =?us-ascii?Q?yZDaYtfsGIR9eZrezwclfQaWoiTOvn6cXECrxS8go5kCv5Hr5Xn9cf+1mJRJ?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aqGchO68kgQqu6SvR9PyzS2azrW9sS1TF9xSHwLk9Ln1CqRBl0Ai8CHfLUUcgPuruz8Fe+zcK6aqa6IHP4lNzHvZMC17o28UFWFh5+vqoYnNjxNP1pdOGs3eEIw8RJpaI90jIaKzDJwaUYEmti2a9Ui26rDGSwyuFxnSXmVJ1tjkzwaLLQclWva4YY3Iclg4GF1tyNN52urwyRnNBMyRQGIfPTHxvhhQ7iSJ7EZJe9lRw3S1XpvYJiJ8rDf2LOU9oqaR8J9zGFIOQsolflnWP+LsefqHx2KRjC5AzTxc3MKmHQnHOUBqD3PMBn31blSYjJFoDCE36KY78E+b3SPxjSY28AqtCmQTfeLGey4c4JhijeP3CTzcKcsnOmMonYSHF7qmSmMFylKhDP/ewwF2Tq0O/feEBagMFZit0YB3IhYS8c1VjZzMxcG06XgRp7BfsCpYTIqAgmnP9xJ+/E5o2ir4MSPk7uKShMtB9x7glM/kW/cb5rdsdGc2yI8IaTUZUAIznwapM54pQHyMGuABDtd5dAs7DAf7B0DjdNUy/imsYJRFZcpROWENdmJ3k4tiqTb0qKVjSRushq4TGqPCplrb5J2k8i18Hm2FwUeHrzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c712e0a-9f79-40b2-8ec3-08dd84189d9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:41.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAxBA4c8uy/HrRGNcruthohYh8gIsGbrQguxYw0tA5A0DBZiPZTGbi37NU4jWBC0X9LHxiOqe8Wjj3qiZ+yWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-GUID: vzVze7QuorqCqq2cHEU1_FtUnVjx6lBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX1nJaTUU3N/6B Gr659zJ7u6d3e7/FpP4V2QCS9o29onsIGNx94u7sW9HOgw/yiRG156pfpYEeR66RBzP/nxnNmtw U1kHnOyT6U12RefzRmdpseCpxSva0RnI6TESbhAO55t44OwEdAYexTwaRE6MjEyE6QzvYBLKnba
 PFeJMukHZ6Q9jxhD6of6Eziq0rBqAE08tEbpi+F4++o8/gZvCeTE1N865v1A+R3xF2zv9h+SXu9 Of3791TDGmMGO7qUjsRbvFTRCFdo+evBMsG9Dg7owX/uPiXs0/B1WCwxOr/v9nxK9pj4NCNBVt7 mWqYQeAU7oDF9LHlkzZRyKkN6azNtM+v33CwwsGzXkbDlMwEDmiu+vIcLFr+e3BbAiYfFvqK9V1 aY0Gz//w
X-Proofpoint-ORIG-GUID: vzVze7QuorqCqq2cHEU1_FtUnVjx6lBi

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


