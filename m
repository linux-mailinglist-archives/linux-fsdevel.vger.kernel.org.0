Return-Path: <linux-fsdevel+bounces-23221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A9B928C48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FFB1C236A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F7173337;
	Fri,  5 Jul 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NuMp3eMz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkxhgXd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720E171084;
	Fri,  5 Jul 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196738; cv=fail; b=MAttATD5KhwTmAPtfMdUjebXEF01ckOWPeRuuxvdjhysCwrWGY31hdc2eDOiUySgs7qrGf/dPU8FBffKXF7E7rELWLdQ+7EIxcraMrd/zp22cCkfFvqdOz8QF76giPCr/da74K5sW6H4bA574Bf/GuCSmDPErj0p6bVD5xccY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196738; c=relaxed/simple;
	bh=wwqgAiTHSgyLmPYyn3J3t0tYESGjLmnJyRJ9xaf4qWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Re9xy/YLBkZHnXR2vuBY4KwoMzDtrMXQ+aTpVtDqCIsVMizpPg4KXOHYyhNgR/sw/b00HhmbCjJGLZVZ+OnsML66116O6S/rYNZR/oh0UtysIqxONyYu0mh+D34vu6SjKrXDNfu7/uMbtt6DQuNEzi+zwLDosUw/5+XHQD/6eYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NuMp3eMz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkxhgXd4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMepI013563;
	Fri, 5 Jul 2024 16:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=nUqjdO+97k+6nfPaQBADrHbf38zy3S9cZ5EqosvGqIs=; b=
	NuMp3eMz3ZhCTOLxc30PqPPopBUw1uxpnkbM3CxYZ8RVeduf3LOFkZg2yP4TXvU2
	LC8T2ODhF0bduUbRCUOtnXmTiPspSb8dntH2f0QM9nTEolB5r/cDCYLaVI3pgXOX
	GQFxTV0I2UOg4Krq/lGyD0+I0tDbjKatY68cUsWa8jAeBE0nmHyz1I+AlTGbmn5l
	n6lJEqpXwxFBNb23wxd7MzfmlOjj/9P9zz/SBgR3vGsowM2gy90xWFec73voBTTm
	ealb9ladxNZhcs+rRiZnBZVSkn/W8IC745bu46mFzrzKIlDxV/SU4lXcrfVyiN31
	emrht3AY8sPLF4BoSttWLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b496c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465ECGxY024807;
	Fri, 5 Jul 2024 16:25:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc1c54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwYJiLQKGKMJBJ0btdHlNdidT3GSuUnS1bic0JCj+s50eYW49PTAFuOVPd5dCXKXLHvaqzDplbVqvNTOwjUHEosZ4nRCb+ItrlFKAFI2bP3DFyldlvpc/IwnaSbMXRfuEeR2xEVjIMSTsAd5yc/Ybx7lQPseJWkPqP4VBOtKoJFDegkaTtLOD9TOmMbFtPegMmmgQKCGvTgi2UhMvlfT96AuhwUeTrXjYZxfV9uG8Dk7tyhOAgK4D/EZoVfih45P4LimdBz4OlKmW+Ib++C5kAkoxZpXDtSeoHZ/6lJ1AQBlUnnrNcWbUC30uCS4D0BIZc1w86lF4kFtOw/OD/53cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUqjdO+97k+6nfPaQBADrHbf38zy3S9cZ5EqosvGqIs=;
 b=E5hlJmZq//TBHnKtd0ZjPUdk6ml/lsZSa8NkakBa5j3oNhZfMc63KmZQGYHgsyYZvuUu2ruZQUOdCwPrW1Tf69SHz3Dm4TRN/nk/1Pt/H78vNMhQw2eaRKF806GJvZ574flsKwE7hcEGlNRX+UmVNMpZ0wkRdvK4yZM7WcOTy7qhy0X/tHhwspo1Lw8YBMcxHT1atogxQWj0MxMEEts0ehrKdow/90ctVYwrL7aOM3oP40BfL5xOc+o8Mqqsu7pDl+9XJ/MKdXdIL98HF02afPoNybymmWrZUbaoPLDeK6A/JSC2qFtM/8GIrS7aw7pqUTqlA4mzoh+NASZv5lrjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUqjdO+97k+6nfPaQBADrHbf38zy3S9cZ5EqosvGqIs=;
 b=nkxhgXd41JF3mEOnxzwHCPOw3Nk+is8NeNZ24KspTC7CTOWM5AEa6lNFIYXg9jzaVNMsDyoumrc9caJAEBV6t2R5Lc13cW3eFA65S9+0U6I2KOUBzKSk0tSax4Sn++itLT4MjIf1qSMGx0RLrxiQH6Zbuz+ujXyDW+bnz7ffjSY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 12/13] xfs: Don't revert allocated offset for forcealign
Date: Fri,  5 Jul 2024 16:24:49 +0000
Message-Id: <20240705162450.3481169-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0352.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d33d1e2-47d4-4121-a6a2-08dc9d0f12d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K5zovPFcvZ0IJxRAaa1emqDT4qJm/EH5p7tvZzJrEAEu73USDeaq6xFz397u?=
 =?us-ascii?Q?2N9npDdxHizVtOvyx3NYOs2RR0dulx081kFzqbxFHYG0KERQOX+UU6v31lJs?=
 =?us-ascii?Q?a1bETQjocoA8NM9yR9k56D5tmnRxLUJp4mkpjmyZ6r9gNYmp8veLEpyS+1UR?=
 =?us-ascii?Q?7AOo2pJiWQ/v0yu1AeFja0VRic6tpcGwxJaEqDKVfd0C/gpaToP0m8NQpTam?=
 =?us-ascii?Q?+lFfyXezigKkxFL/0sOpWsKMPs5c8mBejYHj/4KEfozKeBumHD1E66JWlGTy?=
 =?us-ascii?Q?2sASLRbusKj4bTS85T7grQZr3/gf27bQvQsmNr7Z20H6Td9kq6hdjiV4WX3V?=
 =?us-ascii?Q?/jj2Q1k1QGMpryo7zi9cUi4ALK3O/zx3QvggqLAvEdtV4UFmJM7vv/9AXr+X?=
 =?us-ascii?Q?eUh+gG/oNnWmJzUGX6B+TCd2suKR/1LkarOzAv77+6nel2tK9Gnl0dU6tH29?=
 =?us-ascii?Q?LFIOcb5MXBSh69TeYAogJg/Fe8SfkPcj+JAuWN3MlPqdyAo7beOlPCKDzbd1?=
 =?us-ascii?Q?sPFtdl0c+IHtjEPTp9gTh03/RXJvg/SJ+ZRqAcOLlUpstp+R2vaUnLj1dITa?=
 =?us-ascii?Q?PrwaweFGVgUW2oCqkfGpb65GueXYCukMuLyj0fTm+WL3poTtPTjVgLYcaifl?=
 =?us-ascii?Q?K05tBG5Sj2Ta5DSboCR+67CGEiJoNK2EXB1NFqdMd287nc01qulO1WwOP2Z3?=
 =?us-ascii?Q?XiXM1sPlFAeXkDbbsbtPG4i7n8G/JVDzzUg+KCJmtKFJnv6YolPi+H+K9l3P?=
 =?us-ascii?Q?F6Cy6igLNuE9jWl6Gio4D+p8+VUbnw0+vLeGZ3r/1VLT50L2W9Iq2z28TYiJ?=
 =?us-ascii?Q?2MhjTbkUyjNMp6hBCOgccBZO7Hdo+4xEGJbpFM8s7ZIdvATuxWnsTNyROla3?=
 =?us-ascii?Q?8Da2J9PD+fG/lXAG7WREpLLx6r9FtS7vZYkKbljrvvn8qLwBdXN/xhnmSUfz?=
 =?us-ascii?Q?07GANzFUHf79lBefM9aN0vCrXBDcdjaVFisoMYaInhbmJ6SmAPtiRKZE7AFf?=
 =?us-ascii?Q?gBtGfeUDQlu9CcXLoOdmENQa7IZ1nh1fZdJjurslfoKV70Lne0kWoyvuCWCL?=
 =?us-ascii?Q?AEAifWM2NP5f1ug7/iLZmTlaRiUoVnCzSeZNmv1yo2smfXrYEhjPLhLxQpGl?=
 =?us-ascii?Q?6Dkoq4Z64xgY6WxP88DMhR61n9ZQBTLQqv0EFdDcUqe1mvmLqi/pWX9v6gia?=
 =?us-ascii?Q?wkeAHs+Wh/MzWqeen9tJhrTjfnEI0cEsi63kNMqukHUjx14AYdixxZ557tBz?=
 =?us-ascii?Q?HPkF98NovQHEhJYR+AVV2we5jPHuDusqjo5YSenIMvJp4EKPuFRomdfxRf77?=
 =?us-ascii?Q?t38gp5lkkzaMvwNgI8kPsHLLD3VhcqHQasOwjeleeyCN1g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a/0X79t+6I5+x3MgPCvhaAO6JTO4hmeN1PX0fBiHh8jiJACVmUbSDVq+xLbe?=
 =?us-ascii?Q?/3QBa8iAzgCBeV9t+zpwLSGnGvBJX/rQP3KmTfzob19/OC7LBi9KSdUg23IJ?=
 =?us-ascii?Q?KEclDFItZE1VdkpFqOrJ9fDadG8ov2I+1r+BweHe7I+03SGIXdwCdY8+o6W/?=
 =?us-ascii?Q?MkPYgOzKLjOqqFWrqS9KwMlXrunMqlINrJhdHdQD8U6vAcQuOnpII/noS0rH?=
 =?us-ascii?Q?O0sK1+v6sVqXVkQ08QvkM6HRehfOyXOrXy1w5WuNTtsu4arZW5GftC/R1rD3?=
 =?us-ascii?Q?IpBB12M573THy0yXepL6w5jDvbPaB6qCJu9UXIp9frO3bBuGTNkw+KuUuinC?=
 =?us-ascii?Q?+b72dX8SANTCW2qksCqzuTBMtU/UdfyoKRPvmgM3v7kx53KeKoaJ4x3RpjyC?=
 =?us-ascii?Q?q4bhHw4cZqtiZO2kMpBTPld21N8kFcJOTk/1w0GbIXc030tWCNaIidGBcsS/?=
 =?us-ascii?Q?JY/3rFKzVzqgxa8oD1rcWmJUc+tWnSjiIDkEQheM8Sh2YGrbMfyik8n08XT9?=
 =?us-ascii?Q?hhAPk7l2ERiiQ32CW4qr3iK5atTj8QdEcd0XYQtH0E9dJ694QvO+7wc39O0B?=
 =?us-ascii?Q?4bOeB2nZkzPr35NVnZwbm55KceAnUw+lmYQm2+J6rPZa3Y1gbxWu/SEtzlwA?=
 =?us-ascii?Q?J4eYQ4j/rFA8BxFNPFU/oIUynY91Pv6s3u4pdG02GNRnbz/H18cprAZt4pDS?=
 =?us-ascii?Q?u+TMczGTvUJKzTp6q6WqbBW2lRv2xHnMpknH0a6MWng2iiOOHDCe+g0nDsWP?=
 =?us-ascii?Q?4Rq2EqJ+2kJTMGmbrQalI3sBNmAWMCVbwdPZfngDwB9mp55FVx1ybzwT8xVd?=
 =?us-ascii?Q?Rvoez4IQjzupy5VVIOa8dI2jx4y3p0NBb4prBbDjRV7zftryYPRoUpX56VKH?=
 =?us-ascii?Q?x/lvjCLsBR47KYFquekBym1u7KJVdr8jSqIe/jrUjZZlpeF3RxM0b7wiYvJj?=
 =?us-ascii?Q?qt9E1H3rRg5UMH9z295EIkQ55QSkLyqM24ufA8/DNjwiM2+Ir4qNSJQoKovu?=
 =?us-ascii?Q?Ih+TwIsImjG6o7p4xzJNNCrVIt4lluq6T4Q3Cdm8YoT0rLoi4LWZcheHF6q3?=
 =?us-ascii?Q?5aaSXRwDBqOTGcArp8YkognU4vB0tmWxYtBcZkv+VZin8MiXGAH/OFelCslm?=
 =?us-ascii?Q?IwJi9gwKIfemx7otAecwX4QbIcZDZaxJU5QZVrOsAthx0k1XfsSDgvLKABTY?=
 =?us-ascii?Q?5Wtn9smI3tcPLX1m4B+P9oq0x125yCfbX6d2mrb08I9fxMwaZoKhTHz/J0U2?=
 =?us-ascii?Q?DaO6RlygThu8nR1uRYwyJj1f78oA9RH43j5iJJgmDKGT0WpB+scZzhZCZApz?=
 =?us-ascii?Q?GWHztveuH/xGJrwab+dRFvc3Hb4u3kCe53rdHZM0gDG2fGw57Bo6FjixEVFX?=
 =?us-ascii?Q?qf75KWMuFL6/iR9ja38vPH0W6c45b6JVycLb1gblsQmk7c/FUx5fNu1NO5cC?=
 =?us-ascii?Q?dvWahM+SyQXXgNC/FzW5bE5UxoEgi8ydzkkmRHxqoft4J3nV90cDRiw+JRdr?=
 =?us-ascii?Q?IIA5aavqsu+Wv813slZA8J2w3xYLziWxYjZOF1OAej/blK9OQ41M/24gdo/j?=
 =?us-ascii?Q?hfmtJqqCKt+3SBQ6OwnA7wwJ0VvG9OzIDxM90BvF3XdT4dOCDsIiOUQw02yD?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2Zv/KoAo5PvaLF5QpbtFUmXnOyH7zXETpzf1NJU1g+S/qVbjZpdHm5v816/6ObSsOF1l9cb8VghayCmB79Yk+1ZOTYtP3bVb/k1ApF0M3xUDWYgCdQ+ilKspPgZtSfsD9bgZIEhg3TKWvrQ1wGG2tgDFO5XYICdSFq5AsEAX/X84X6sPFVFZvWe/jPgAv70bC4H8EPzfj77mCV7PogN2ZMNagosH48Dd9kr0tNh6+aMvz5OQbErsRgszfVRyje+ZFq3XErpl7LoMdRrmnpy0Ukt6ggmh/YTd+9gLHhG78UaMYHqvKPcpOh+v22+vA6VFxRXPcAF052mKEdTEx4DTfQG9GldLkOXCGFZv/0VWy/chx7ofbMT6wcgHix+VEZfMsEc5YlOFi4TGXrpzkRqhh1SQkb84KGiUlaURWHOBbCD0LXudfkJsKynm5ziFdp+8/1ks4u/HWuh5udarh7iIXLhl5CeLsakcqjFBBAMA4tfcgORM0i0hSAZcRv630MsGZTAsDerXuV+FsT7AcOFD6hC/TalhVsk41tzRzTvbZb9Zxh+8S0VD8MUAvHuvRg1VfNvFqb2ZyMYO6/lNqLargAYvNmFwHKFbXM5u5Q1/TRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d33d1e2-47d4-4121-a6a2-08dc9d0f12d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:24.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAv6ujsfRdFqM1polloOqPqftMEMGKRnv/5XxnCvUXuq3+Nb/eBnrKhB+eUEmnsn0snJ7F2x35jfHeu1xTNCWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: B2gzC2RxReFgOk3zOBdoPDDJoZapq3YN
X-Proofpoint-ORIG-GUID: B2gzC2RxReFgOk3zOBdoPDDJoZapq3YN

In xfs_bmap_process_allocated_extent(), for when we found that we could not
provide the requested length completely, the mapping is moved so that we
can provide as much as possible for the original request.

For forcealign, this would mean ignoring alignment guaranteed, so don't do
this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 07478c88a51b..45694ceea35d 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3492,11 +3492,15 @@ xfs_bmap_process_allocated_extent(
 	 * original request as possible.  Free space is apparently
 	 * very fragmented so we're unlikely to be able to satisfy the
 	 * hints anyway.
+	 * However, for an inode with forcealign, continue with the
+	 * found offset as we need to honour the alignment hint.
 	 */
-	if (ap->length <= orig_length)
-		ap->offset = orig_offset;
-	else if (ap->offset + ap->length < orig_offset + orig_length)
-		ap->offset = orig_offset + orig_length - ap->length;
+	if (!xfs_inode_has_forcealign(ap->ip)) {
+		if (ap->length <= orig_length)
+			ap->offset = orig_offset;
+		else if (ap->offset + ap->length < orig_offset + orig_length)
+			ap->offset = orig_offset + orig_length - ap->length;
+	}
 	xfs_bmap_alloc_account(ap);
 }
 
-- 
2.31.1


