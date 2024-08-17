Return-Path: <linux-fsdevel+bounces-26185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CB9556EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C7C2830AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A4149C64;
	Sat, 17 Aug 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtsSpQAM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eQLwpUSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E88143723;
	Sat, 17 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888119; cv=fail; b=qJwFGWlF2oJt4OnnJYmPEstoLppgFxIe6iJlQyWt7ZRVERTt8ML3OOduyQyeYPfmzN2AOQGFNlo+oeP6sq+8761SMmOk34o40DzEqN+u5FbyJckr/QqQ456ZK+XoSqkzCTzMNXhAxH3VEEwu59FrGUpGYRDoSY6CIzo8ckB/f7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888119; c=relaxed/simple;
	bh=GYx7CpZu+ABnTqW6ZZtiDZhVHmU+L1Ki3PkGG5AMl9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Riqji5Xp7o6PR80u3LgGWevUNLEFcGoPX7GWnb6z5bfwX+0SyaNiq0QL2DsRYqbL65UT0xVImTTLi1Go1Fzt15Ru2lzazTaaj4QttrGxnYLOVZN6qdjmnY4W7i/0h9Sbea1MpYnDm4jKq7/9dkpA5114/k/RJBO9nA9gTQG5++U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtsSpQAM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eQLwpUSY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H899rT016343;
	Sat, 17 Aug 2024 09:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=4FdaJnhZHFCRUjbwSGkwVcBVhcAaRCPdrwgw6Q3ROfc=; b=
	FtsSpQAMlr2lrFcBPLGGhKhC6abTd5pPfniUlwtXgLSIegCtEH/ychJJynyRfjwH
	SxnOsA9tIfWwX01uakc4tfPTtAgi599bki84fkqhuRCTTUU79jSbvB5QWpHyA/9a
	DlpJE0I6nsfpdf9nCcfm3DBnfxI6QFFOfcAHX0rtl74wT2omOOkkY1jsTM4I9TIO
	6/CZBgJi0WAJo2533Xecd3TQ3rzFsqLhqMqtS8Zp9Bd7kzcLnEkac2rdJ5cHHGqN
	hXZa3p7xqaF46TcGQDBuKN/3v9U0ljAzWm5Koyy8pn7t3Bg1dzJPKjDzPJpeSpfV
	Yf8vOpVkrzOV+6AtkFA6Kw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dg7mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H769sZ002603;
	Sat, 17 Aug 2024 09:48:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5y3xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqcW5V6dS2Yco0u+QXIRiqvHV7A8ZuB+BIk+zcetQb/pHdvon1Ks2RWz3+REPgqD5Zd7v4ARnLoS9Nx+P4Bv5nWMjLDzcRBQIqDLe3t4wc03uXjZK1jDZrM9KeEWOFP+KxiqAWaeAfOqetRs/dwCFBTkXihp44U10yT/MHMUVBovF3h7XAplW0hTcVnZzlrMXe7UzS/NmiYwy2tVtzOYYUY6dt8bhTb0NlR1b5OU5Y1XXAgOj0O4WLuVWxis8CosukH4oSh/a7zIsRxnvOgBjUse5y5fj68ymbXr4oikvlZjB7KzVSDGm1NWYrKksOvMqj4+3I0lfZckq1+b9WpPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FdaJnhZHFCRUjbwSGkwVcBVhcAaRCPdrwgw6Q3ROfc=;
 b=JrV8vHQDHNYd/AtYVwHwGhMUID3i4il6ftnrbJ37uXvcKGVSu5IlQewTOnn+bvjOQBxtqeJspgCHlXgG4awOj9exJ7v/bvelrcfWohzXfxlh7VEvPbs/dm/tggKhWqUlTPSJksUR0s9AW9O3wKUAMJLLeBaLjnzH60H4ndN0Vy9/6Z5TmVzmdp5yuPGc/Vk2ptE3DSM0j11Ls+j3mNZeFot2VKJmu8dg5G65LnMfruRYZuTDa/yHjDglTXKr20r6GXe7va5BITgBhPXegV+1yXYDiWfvZ8DjuWkKkVdRUzlQbd9JTzUdAzGKIGBx9rskBhWH6zXR39VxK87Rl0VP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdaJnhZHFCRUjbwSGkwVcBVhcAaRCPdrwgw6Q3ROfc=;
 b=eQLwpUSYkV24SNCFFUBFpw4Zwt8R4bBfH4HNUrFnRmGKuT3taOXRrCLzB7C8/XlfyrIot2q9gOiI/73Xp13hmxMKAJUXN5f3XxyFB8CFDZQSchhlHaCMQ+ZR/1trQ67aFyasOM1PEhkSqm7nVxdHW3K4QBhL/sGsoOQMs4C2h20=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 2/7] fs: Export generic_atomic_write_valid()
Date: Sat, 17 Aug 2024 09:47:55 +0000
Message-Id: <20240817094800.776408-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b70d32-346f-433e-361b-08dcbea1b99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?41JPtk0amngSqcctOtEk4GqXXekId1b0Q6OsZwcADTccH7/m8JjF2J2UkJmz?=
 =?us-ascii?Q?6Y0307wjrlnOwBUoHFV6F/S4RfA0XM6YaEebsWwfBJ/ufi/tTP/BZhg1LfK0?=
 =?us-ascii?Q?ow3qej/vOQ5fEm1VjmKfp6lfNyx6ZZm6hTpe1ie3IjMxTlgH6EUp4JMcSNzh?=
 =?us-ascii?Q?7UrIn0pHSDrBrMa6rpl/uuZJhn/XQP9JfA0pkpMMXjATzKK46bYt4uEwxngR?=
 =?us-ascii?Q?vK+trRQlFgzbm1gVJTvVyFa0HRX0RUUc177TWx6GeASu8we14/ftKIYVY58s?=
 =?us-ascii?Q?3rs4QIJGJZ0g6MMEiAHfeB4g6/43hi92XLls8zBb9kHHNmxPa6EFd0CipL13?=
 =?us-ascii?Q?dWdsFIR2LIdxu8iEGtU1JcuXzKLMIy9VAuQSq7cR3x1MJwPmQ1e9iakjtYTC?=
 =?us-ascii?Q?bJntH3Kqx6+U8pnUuVZBCLG6yzd66UQan+a/LTaPgLCbC0ipaImbyZV/XlxB?=
 =?us-ascii?Q?WODCVwnmBZMEKAi86Whs+i5tlS8/LCvKIgtN7YfPowp7CI9zZd00JOysOQTB?=
 =?us-ascii?Q?Of/1FnVOfxQmgDTKFwr7dFjpgnIXHV+DK0igTBBQYCRYdheCnCwG8xLSKJJw?=
 =?us-ascii?Q?1cEYQa+RAoktq4lfxzUM6npooS/Iee6ydc1e8JSJ/1WwCZxtQE1OZtFDdaG+?=
 =?us-ascii?Q?+BrN3a2mpcH73l1ijeLhvDSoJVg0Rd+LISrjsHrHkn6Is7VdhZRPBE1G5qzN?=
 =?us-ascii?Q?b0CXB9inc7UCSmbVXnv5clbthomSnTJwZ/VvBay2pJ2Vz8s5gfrapF6AlbAP?=
 =?us-ascii?Q?a1X/FyBIgXy48jyyPeNGR+DtIaze6dSpbS5vudDg2rtGdHY0de+IIhHVl5/P?=
 =?us-ascii?Q?JPm0bYGRF2ZoL4ORKzENJLdZyNSfztNA64E2lz4F8TjKiaQ63nszhRE8duta?=
 =?us-ascii?Q?68O74PrHNVhFYZWybnXFFiuZGe4i3g/7YUdO4ofXuGNfqJum3o3D/RTrVX0Z?=
 =?us-ascii?Q?nFFAXUfYlKXszjGW/7PUHsab7Juj4RsKFdbI5r4oIF1JK1o8MkqhKquyafHl?=
 =?us-ascii?Q?OiKKJME3qPJmqhLcNeE17R58munPUPX53scUPOXDWeDOT4AcG8ygllKerFxF?=
 =?us-ascii?Q?bZ8R476xkZUXeXWt6nBcxOKGl1G5eFe93VIOW0D2JjUPXk+nRiIVw46wQZ7E?=
 =?us-ascii?Q?V1S/k3Jp9MmRmBehUacGP9AJ1CYKjd5CfLBqiPP3cUP5bLo3RCW5etIbBSMg?=
 =?us-ascii?Q?qtN6GBvNpNmv2erVeOqWJbV7g2p4e2/rv2iNNeBkue7nlUrRZ3w5k+G94spU?=
 =?us-ascii?Q?s5J1z6TVj7s7z0+RHpDBI6gSg8RNDGMteH1u5tXN+1XnBr3hTKPYP+UpcgqS?=
 =?us-ascii?Q?MWuFcM2xYinAVQnfMdXla2/9uR+QWasKDZ4yxja9ZFo1ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcaXeOZL1RW1fK+LfJ11ZxsG2+q0d7nknbP3vglVL3bx1ABBWF0/di9AGCsV?=
 =?us-ascii?Q?u8zqWM4kq0Td404xoQK2fx2sm2KBe9Vh/jaccbIVRBYjzOmGIMbXOtTF01rU?=
 =?us-ascii?Q?jNrRgvbNVwGK1EqNivOuBTVU0IXxXz4dzifJ7pqRbkkB1M8H2c7MQZfBR8UX?=
 =?us-ascii?Q?Coa9IRfUjojL+BDBMcP90YQKkL6p7ueyf3UL5ejQTq6er9JlkFOXbluSYKJp?=
 =?us-ascii?Q?j9AIXAqdWCkMcqnNRiFoBXs8HvqgVrV9/jRaM2Czk/0goZhd7tMzRJLo7VI6?=
 =?us-ascii?Q?BAW3Sa9ceo4lOWdcCSh+wNB3Mczw9r7mY4RVVjEo/luriHzWs4TUQwRshdEy?=
 =?us-ascii?Q?1ZpNAE0rYkjhQuU+cYQlYD7bXC8moQUk9CwQM9alHsFPNmfEI0XRakMupZXv?=
 =?us-ascii?Q?ggFqrI39bP6bveIqAxiMcIS2mtf0rWFYIkK4w99Gqf31g2uwOh/BOMXTWynb?=
 =?us-ascii?Q?vEnkAByuF6L0WArphWMbQkSFss0Y9zNg57Iusv/XK6+A81TmfoBDjZI7bXwD?=
 =?us-ascii?Q?2QppII9X+4kiAhGfY/oN0CJzYYGVxZS9viZipqGLHERS4VdwRd5YtGY2deMG?=
 =?us-ascii?Q?4xflrV41YZzcnUjVdRxb75NQTfzLt/K0bGfm7bicOj54H0YzP4/Fkh3eWI4b?=
 =?us-ascii?Q?vjZaqMDJfoLlW9mnrTVQsWgtpV19Wbzf66CGddvOADJggQfwPQJLFUV42W52?=
 =?us-ascii?Q?6+0t/LHLHeuY74VelLjP6i85Br7jRax4n4eUJV9bMEW24CVIprDoA4rsffh9?=
 =?us-ascii?Q?Vtr+NOEPmaV/VKt1aw8QgccMHhbPj0I7xN1EcW5QfLVjPnZRqKXAIfFOYuUh?=
 =?us-ascii?Q?W38LV74thZjfMpUfksyiX7BRXkbplgh54dO9ysOQ7qnki2YVLj6KG0RbB7Bg?=
 =?us-ascii?Q?bBC1qB9W4qTAPxh614GYx+3Bx0qki3K6tGcgm9EcyjKCydCf5vPz+bnAifzP?=
 =?us-ascii?Q?ci4KCoo8aIlvy15qc7/5s/72W2hvJIJTR++uvIIK3/Lpv13LJM5AZm35d2SA?=
 =?us-ascii?Q?KK3+t8MV6/fAGaqEwhTd1mgTFPUhEHsb9MVLu9I8oAWDJ0V5m9lzXv1KOCUQ?=
 =?us-ascii?Q?DsGLuRyVtrIfLl0oy1UlxfkghEAIdw2XZOF7qd06M7sfJGZ3eIYl5NyYRi6t?=
 =?us-ascii?Q?T6H/5VFRUH7RmxXFwYtnkzTYHLZAgAsfHV6Rzcqc1BAMKmOvjwUd8rGevchh?=
 =?us-ascii?Q?uWIMaJ2DGzLWRM61emX3bu9lMsWvODCRuQwYoiXehqgm1YA5M2/YylKpC4G+?=
 =?us-ascii?Q?C6Alf5LeBYxyFTxJ3zHxOF6gSuenJ6hGJZTLQmsXpSoaqjgRYrInHfdCt8Ly?=
 =?us-ascii?Q?iMBgJ+HJ91NkR3LjTPmcWptJqujEaXO7m2lr/e3UXL4pfakFMJqgxNo/Wx9R?=
 =?us-ascii?Q?BSTfnjBkUSV0EKqt7LHxEh2qdht1XP3w+J7Mzt0JSCYxRmMC2gUA7OL4b4Zs?=
 =?us-ascii?Q?lfUaZ++yzcpi7kFw2MYo4Brt1FRLLDt9nRaDIYs1zSjIihXa7WvuSI7nwdfm?=
 =?us-ascii?Q?Dkw0UXmT+PN2rpe6JeJoRb33l/HJ0Dndh3t4fz4gLZHY26am5cMo39Rbo91W?=
 =?us-ascii?Q?dEagvr5eo5vW5ls1/3/IPmto7v9PJ9hWjRPU42HfQKDFSO5RPK/7jyryFAtA?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6f6XdWmFP60C3D3nX8x14/NQnmvgzHVmonfZwofIb9gYJHZEFRwVA/EewoauHtpi2Hzzwy+LQXjZ1yyj2UabPzwW8bulwzaDue/IDuyHbO8lu8MjKCBe9CAz9STMtaJqQUtJIeTPdXmjCQP0dOlE0V7ABfY0giawYaq2kcor/ZnBX0jZWp2lLFtuTlI0LbloNJn+tTK5BnN12Ecl7YNvThiqmvqga7ytaprFm69mtTpQ+zUl/+KYqsvCqeC4x2aLM4FTo9CqvmhUIV1S43KUQkb6pi0nS+Y79IuUdhCVcc7pzx5LiHae9qAlRqwWkmrlijZ4y7RulvhYIVzsEHx6/FzhGMsy+jbOPSts8O9JkZH7tBU44m4Z+PYKYaNcFctAXt2jVo0IPjKFsGop3oIulxIZIlgGJiGOVIhwDgyRpIcDNsOqTEyyS5+Ny2eTYFBgog1s8K4DvsQmP1oUNmWJZo46orTWvJrqAIHJhttv198tz16tgmxrVxAGo4pxurbYsgZ1BAT/ILTL+gWIWsUuWKMIilBijiJzCEv1ordB1qnJLhswO5rRbt8vbApKGRbG6k9YIT2dTzY2J85ICZqrCL/c2fLfqojoKgHc3FWvokk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b70d32-346f-433e-361b-08dcbea1b99e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:19.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QLuAE3daQc1xw3z4ak/Uu6pfCNwGcJt0BFSMs+Tk4o9V3lq7mB5U1ynRvLgPErU1ffN8SCJrUI+C8gojIKbqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: SfNKAJQ73vCXxAczbD4yBopie0_-aaKF
X-Proofpoint-GUID: SfNKAJQ73vCXxAczbD4yBopie0_-aaKF

The XFS code will need this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index d8af6f2f1c9a..babc3673c22c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1752,3 +1752,4 @@ bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


