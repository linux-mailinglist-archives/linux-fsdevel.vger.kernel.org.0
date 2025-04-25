Return-Path: <linux-fsdevel+bounces-47391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A02A9CED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D821C0199A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18F1F09AF;
	Fri, 25 Apr 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aq0SheM3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mra6LL/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9951E834A;
	Fri, 25 Apr 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599699; cv=fail; b=CZ3stfA3MKh5oatjHregCSyCdovnxFQtx76EDGb0yGVImVljvHDeHWsnVkKWysUCNwbH8iUDk52s9sXXZax9j9u8ms271lRisS+67IiUXAwDlTjPLPB0/Rx/9wN3VNezRBr/cSPAYbN8FWGMWV4ACyF71D37H0CQR9eTxvFAiuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599699; c=relaxed/simple;
	bh=vhyRG/JMpCMXbWf/h58kEurOxkJsEDMMRsmJsL+TzWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxZPaLhocLmOGRi34S9V5hYXc844COHJ9ullUH4QF3klUqDfFVXOWFhLXE7eavAH3pIgnXuSwXS0XbnUvn4UtfgJiEQcaLiYj2mu5YGweHFjBqBdhbzgDEzGRcOuesAtthGyzwEHyuyIwEjz0N5yJwelP0B7Mnm0hAeLd+88e6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aq0SheM3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mra6LL/0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF6XtL030091;
	Fri, 25 Apr 2025 16:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jikh2lPnjrtboV+XxURcV757dR1KfcV+nxMAsjBrh0Y=; b=
	Aq0SheM33+9+mn/J32+D+gxdM0adPSXUF4Pg41CfrtzM7cn7pb0nMHB+/MbGPhGJ
	z+pC30MOL13rXllXXaiZksEFLzAk8lYp9GhtXlpSfqgx4Qp+BLvQBuy2J5rWEj4u
	j61S70fNeZpayxDi9uV1l8VlTk3FUom7iR7GE46flq8tcHq+o1Tz2oIZCSGcmPcK
	0zlY3iUijD7wuAFPwB5F1JGzfxPpanslL1fkg0T4W+RICwVqF4xUsiAJN2nrhShL
	n29+LgV5tXihFxFZ4Gt77PDu44BkAPVRdaaRoY6QS8BEZNYDRglPRjmpdEhnq5Hr
	fXzZUVMO5oV8ws27uEp7Dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cr60ebs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:46:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFMqCh014191;
	Fri, 25 Apr 2025 16:45:59 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrvdgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq66OKt7iDToviriymCZg38nGoNQa24Hbrx0U732m7ukW8YW5mpsE9id5zKkiNW0nU+L37UddPx9HWGtoJkPYWzLzDYmJLgVPxHJv5Lr3gDDbd+OVIEpc5XDP3pTCbWaj7j6w1twPYiaxnFOptdFEybpgUcJkRFk2cvVLiI1YqxajShptWI9HPdtXp9SPPvMm+XUG+Wsh00+cGNocD/JOvhcq4LiiYh6yG5rCg/vVpJEoVCG9Ri2fuIXlSx0+0yzgh0uuTN2O56SbnT4PhW+LKlYpUyssy/chwnApWc/FTTHnYln0wqVZBGq6j+djuW06w3IhJ62Wa2BDnjSS92dMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jikh2lPnjrtboV+XxURcV757dR1KfcV+nxMAsjBrh0Y=;
 b=cRhpIIAL6GAibwGaLCr8URs0fqw0hKDl0SuEKZZsyRJxgX1835wUmNTL3n8XtnKXjDCwI9k/XJHxs6UeswvX3cQWrmwdwy2nN6eZZTOYzL6NZPoy19YiQW/0h43/pzURw8IVBR3wcyNTeB2xG98d4bYP4ZSovtqGs4r0fcg3I62DjE+04bD6g18LohYDLmfHlAQG3ZvCs9D6xBjnyG3CNOb1Hdg6okOVGEGrlRChRYAwpTIeY6akkD/AvdqWByMke6jDqzatqDAroHIsJtA/Hpmx5xtt+Kc+VgOr7QzagWnklwAr9hZXEDERIYwtNgyeVCunVaJWtb3mPPDcSaLF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jikh2lPnjrtboV+XxURcV757dR1KfcV+nxMAsjBrh0Y=;
 b=mra6LL/0qPzZ0lMwbVjaiH9+GMitzKz5VW3K1kdgcSEhascLqbMIs1f7wxyXm0u4LRH8bnxxBi+UgSmv7Yj248jU7HcBPFCVEgLFZyQzBK803Ptcij5ll/3PbmnHOIyx2QdBfYJABh7DJ08KKU81KaRzwPjpxUJt2lcw5kYADdQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Fri, 25 Apr
 2025 16:45:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 13/15] xfs: add xfs_compute_atomic_write_unit_max()
Date: Fri, 25 Apr 2025 16:45:02 +0000
Message-Id: <20250425164504.3263637-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6b383d-4275-4f65-08dd-08dd8418a695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PnjZkbMoGp2Zwd4m6NU4FvveTJ7YzSbWnrEmdnDV6y/2Ty67hA2M2uD35VwX?=
 =?us-ascii?Q?3d+Ku+48NLyNvK3z3Ffnr4L1dZ41XUDdgG97WMLfOF904SoUDMc6hU5St87Q?=
 =?us-ascii?Q?Gwja2zbjzrf2ARO/NmIMjaSadxq7tPO0SNamMteklwZ9g1VRq4LSWWBPfCG3?=
 =?us-ascii?Q?4uT9kA/BBxgLyoGXYNDp1oo8YXdSofUzGpHUBbX3dS1U4qK0sKPTuEyQ8FJR?=
 =?us-ascii?Q?5W2n5pRlUjsZCo81rPv/maPoRSuOcYQCZ8rHKmHgqUWARQh/Rfc1ThER0Yuv?=
 =?us-ascii?Q?z50uD5MN1Vue1XzF4pHQDRWJNvHvJ62+57gqco1ZPB9jXjx/EV3buNG70ClS?=
 =?us-ascii?Q?yYl1ptYyoOrkFD9A55x7Y35r1J6Y69ZhkzsPN1u3RRiMc8PzfFn3uwGwIZxX?=
 =?us-ascii?Q?l1Kr87ibjnF0/xQj88mw2unB5YECBcrpVcuDlKFBhSbAxU65Kbfm2LWoO7Dp?=
 =?us-ascii?Q?rrMjQp/vWJlM67Pms8m6jClPy2YeUrcTBE7Cr4VjKgLqXxzgnf4r/84DCjuN?=
 =?us-ascii?Q?11Q3jnTPiKB8IThgS2hXU3CR8gJjOoJskI3YCp+OXJNm0DJTDYVAzEeci2G4?=
 =?us-ascii?Q?2uCe65rYMXazZ1fNcfn+ycNtpOg5PP5Z5AG+XiKe0JVrHZxDYz5w+d2zTBj4?=
 =?us-ascii?Q?zT5upXqmxsXuKkxJrAW5UgA3SnLjfD5LFjgkos373XpbRiA/y8jKUiQWW78V?=
 =?us-ascii?Q?iBhoJQH/6+6/IICzFeTTD7uyHx+gA2g+F1k/xMTMKhIPD/Reyvu51/2Q21Jb?=
 =?us-ascii?Q?R9ZcnV9XLyoPEzOhfn9LqZS832Ag2zjWNifwwVP55WUEc1V1OkvWFekrKGfx?=
 =?us-ascii?Q?YXnMXCMmgYUuH3rOA3ylcc19r6/2dmqErjFeoVd6RncS2VN1LWZgFCpmoAoD?=
 =?us-ascii?Q?aT671elC8q7TXTGEvsdCEk7ufnQZ02y4o20y6KuEIGjP1pWjyQr4YSM6ZhnX?=
 =?us-ascii?Q?72wTbceP0vSy0+Ixf2u/Fdi8xmYnkXqr9lgPUSXw/C7l+yjYQ3/Knvy4FZth?=
 =?us-ascii?Q?eH1KY4J+lc6FkszIGuaLuqC/hUDX42AqfTWTQGryuqY0YDcw6EF6AM44O0vN?=
 =?us-ascii?Q?G2k9ttd7oPFmbwMRfuOOHQThPlmPMEE1jZ0vV3C4z6tFIuihMW45EFfw14wB?=
 =?us-ascii?Q?l2rUE5QHKIpJk9aCeK5Znc1FUxlyi6W+hOFY6k5mxOaxHPUr/U5+6GtLsDJD?=
 =?us-ascii?Q?yXYsjKT0VT5FHLDjDyWvkz7pqTJQHeZM6BHlF/ysg355xnbX/I1cw6c/OZC0?=
 =?us-ascii?Q?NHdO11oCXOjM/KyNTzc/a7Sne6QQKziU2DNiRtMDZw3ZDg2dOsgay3T/u9Xf?=
 =?us-ascii?Q?RSWu90r2VzMz6nN50/PB+2/OIoIhLGmsWoIhyzSX2H1WF/J7npmsNZtn5gJt?=
 =?us-ascii?Q?oiaUPtMXP5NgYgU9/veWAj0k7iAcEI2HMaJRL+Ah5dss04n5ln6oPs7DENmP?=
 =?us-ascii?Q?iDXqMJKyCd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rzNd145AWNtxkaz3WkT92+IxMsmkqSYkhntJehxOq99tMxk3eIcxY8XTfzs5?=
 =?us-ascii?Q?hswokl0awz46VmpHggvYQRDMzM+UHUd4MbEOzonRpE8iJtcoTynjxK/BFBD0?=
 =?us-ascii?Q?DxvsZXYtMh5BPnkfsiRiX6I7WMkdg4o89rsk2bIZ5Y6SY+5vYzZt9an9RVbN?=
 =?us-ascii?Q?jbF+/1gF62roHSYhOvcvk7n1TuN16BzJBULm9VAzcVGVywUtiM8JxrYYAv4q?=
 =?us-ascii?Q?Oq1gCXFOwTPofJIquHy1+4shurDEykrS7qJ97kCB7Wj7109S5VFWbEaeYVkr?=
 =?us-ascii?Q?W2AZ0LVovcoshbo3bcXgBUSaKm2Y1TL+dWEGvgZlwKGm6TXHddrkT00e5n6u?=
 =?us-ascii?Q?ckIJD3lYbsmLrU6zz9xtUJd5MJ7n64X5Pf33uv3BFZv81yOiGYqX0dIOXGH6?=
 =?us-ascii?Q?JwTc3m1dDUXkI39GYWQpEMlRZ518yV7At4y/ecTs/WDoNuk7zI2Cvj9wMZub?=
 =?us-ascii?Q?ZEfxsUURNQM5sb4y6Mb7xXI0bUkky4UzPZ+4M7A9pxUUpTE8eah1Bg7mt3hq?=
 =?us-ascii?Q?NfPHah6UVZ7O7ceMx703G0tZmQL+jYlx7oEVrtweLD/pe/9+U91jpsTOGZQZ?=
 =?us-ascii?Q?de1ZsfqJpEArZavVbnNe0ynNtkGg0TlR8MUzN8nxZXWIYej2m4hglT3zGrd0?=
 =?us-ascii?Q?LVWQLvUB19HLpDm4JzTAPMLSThWBE5V6EJQ+Z32DVdrKJ+D8FI0iBYUnlEJD?=
 =?us-ascii?Q?3k+kTto16HQgB4m4f1FOashMRXpnHVyIoykDXd5wObXAtcMNPH68O/NtT2Sw?=
 =?us-ascii?Q?gIrRSHYYJVxBX9WNSBJ/wLd/jo21TxEeh8lyXV0sia8ktnZEalLBNqCcYQmH?=
 =?us-ascii?Q?Bg9OsYWf0wJ24m6ik4uHmJsUUHMk8v/7QS1uC9V0zvlU0Yjm+s4HO5xUpRmY?=
 =?us-ascii?Q?o+HSZYTuopAd8eO9Cb8fdYO5ELlcN4CJM95a5hrpOH7GAc6vx8QSIJKcX4Mi?=
 =?us-ascii?Q?ZcXzn2g3xcNEfddLyk/2524CyXpjKvTMik0KwQ1nnvvxdVHOawJyP946YE9a?=
 =?us-ascii?Q?YtOcI96jvGrkaZMTsot7YDBvJOR9fyoK4egI76P9OQxlM6zHpTOtJ+dzkmI8?=
 =?us-ascii?Q?CnpZ7OuWQpyABnkwz+sAlXWYf3yzuZDf3zpA6i55hsvwypS+Cw5ouIaqXfTs?=
 =?us-ascii?Q?ZOVM9zLux3iUHptlJVi7GEVWDY3IPl0GiVqTzxmGGEk8uUvOvinUsUYD6xaj?=
 =?us-ascii?Q?VOPUvZqV7mF2c3Uu9T2LAb5hKcU2GBPZFP4AnCbSutkaDYBRkqvQZpQU2s45?=
 =?us-ascii?Q?F0PRPFBq1nl9nBanLKliNa+llDN8i/cwigVjegCxzvYZvKnumKRzK+jkWM3+?=
 =?us-ascii?Q?AdPljKRQzY+8oYggv5N+bCzwPFGuoikB+Jffp5zhMaGRa0MA0pIhH0miq+Rz?=
 =?us-ascii?Q?br4AZF9vXYjbYJewI7eNZkWpxYaBdB40anTohJvgvZe0YCxsvZQtc7rx1X9d?=
 =?us-ascii?Q?oDgtl2qD2/B727HOxSut3JmlsIrP5H9Crgo0VgfFd1I1iXldsccYdaqfwDU6?=
 =?us-ascii?Q?nXYxBfAAZsIAT39NcpH4JWq53/kmOGibUCkjDMzmTSo9zXYOgjZUU09dng6Q?=
 =?us-ascii?Q?Wwdr/Jkf3aBy5Kz3qIZF/GT0inpocExTsahHZ1vw+moQK5laJHCmvE2MTNug?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	20L1l+qrfOrdl7PNpYOODboYnf0hPV6tFqQTlFwDtNWZLVvihMuaY9s6DilIkLV9MJiymvKu47JsOwItpA8LZ6FHLEf/RYnNvzn1+68t/gBFIhiuW4b5hX+hYHWhcA1Golkr6AQOGzw6EpB8AzEpp5mVBpBj7H0L7FBx+svRZQvyz1TloV8bCmWbM3ZvUdwgv36WplLu+anyQCSan2EfHwbOMGeHWnmSyVcjooeWEv2KUgYn7Ph9iW9OV+TuLG/aRvXykb4DviapcomvwgtvHioVSh26vEffjb3j8FUiB+MJwi5RdpLH4D0jNHtdFcJwsxazUJgE1NdqJQExeMcKKrR/L5ZiTU4+WtQGRmwtHVzq2+ClsavRKNLigwiu0XpdKl0R3AX/tu/kXYYVWH/TbNFv8zu6r7jHfmbsIrh2tZNgEIqHZ80zJyyhzsBHIONPn0WoY7ORj6ccOtKgQjy5ZCO9O3BTfiZqtpSOcu4Cavbg+/GRIC1qi2jwSCMCnnKEk9SNl2MeKW0WO3cnhPeEhjanlnpxWD8rwd3uSvXEvDXJljBwgQ9i0wH+t2Ewc0OTTiwuZtF6/6s79TELYe2XGMBBoy/YbZaQjkPNPekmYEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6b383d-4275-4f65-08dd-08dd8418a695
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:56.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIEvh5ZWtOc0HAeu9SKqkPpTWRJGMPvOs7YeyuUSiG+1jRt8qVm2JIDvZf2WBkPG37T9oPqdjViOqBm9Litlog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXxkimaz2AOXGC kiqLC9ziZB3mNZ7SMPRJxOEDRhzJrIhWzm61HYA2kV3BaqwP0740ISMEhoNQi92rGkWBQbQOlPr jaduj1HCuR4sjmCvaotWGS9hueDQqxDs7D8xTqRetE3KleA17WHFZq++kEqGk/iBj0OPaunlPa0
 qLd2pZeUxOB8EXtm/tOA2CYcCqPW4n9FtHEjmOVyUji661UGUST6HOQuKS2SIZeGhH5lTiNfoWv cN/P19RtP+QtM2yEGuIJCaH9qIuL1am0LBsSghZqy6XPfX4pE9QQ+7rNMwmsusgar3wzxwe4jAi THcIXennBRqnUfYYQDSUF7yY0rNbUsITDM5yTcRjkdfNA3+sxZvDLeXBBDaNBH4NgxEPf5TRpYL 5PSaqFdu
X-Proofpoint-GUID: 7cC1pLJleBLT7bAK7Gxk98jNFnxMeEkg
X-Proofpoint-ORIG-GUID: 7cC1pLJleBLT7bAK7Gxk98jNFnxMeEkg

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Amend the max atomic write computation to create a new transaction
reservation type, and compute the maximum size of an atomic write
completion (in fsblocks) based on this new transaction reservation.
Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
reasonable level of parallelism.  In the next patch, we'll add a mount
option so that sysadmins can configure their own limits.

Signed-off-by: John Garry <john.g.garry@oracle.com>
[djwong: use a new reservation type for atomic write ioends, refactor
group limit calculations]
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
[jpg: update xfs_calc_perag_awu_max() ddev check]
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 94 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  2 +
 fs/xfs/xfs_mount.c             | 81 +++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  6 +++
 fs/xfs/xfs_reflink.c           | 16 ++++++
 fs/xfs/xfs_reflink.h           |  2 +
 fs/xfs/xfs_trace.h             | 60 ++++++++++++++++++++++
 7 files changed, 261 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index a841432abf83..e73c09fbd24c 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,6 +22,12 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
+#include "xfs_defer.h"
+#include "xfs_bmap_item.h"
+#include "xfs_extfree_item.h"
+#include "xfs_rmap_item.h"
+#include "xfs_refcount_item.h"
+#include "xfs_trace.h"
 
 #define _ALLOC	true
 #define _FREE	false
@@ -1394,3 +1400,91 @@ xfs_trans_resv_calc(
 	 */
 	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
+
+/*
+ * Return the per-extent and fixed transaction reservation sizes needed to
+ * complete an atomic write.
+ */
+STATIC unsigned int
+xfs_calc_atomic_write_ioend_geometry(
+	struct xfs_mount	*mp,
+	unsigned int		*step_size)
+{
+	const unsigned int	efi = xfs_efi_log_space(1);
+	const unsigned int	efd = xfs_efd_log_space(1);
+	const unsigned int	rui = xfs_rui_log_space(1);
+	const unsigned int	rud = xfs_rud_log_space();
+	const unsigned int	cui = xfs_cui_log_space(1);
+	const unsigned int	cud = xfs_cud_log_space();
+	const unsigned int	bui = xfs_bui_log_space(1);
+	const unsigned int	bud = xfs_bud_log_space();
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent + map extent into
+	 * data fork.
+	 *
+	 * tx0: Creates a BUI and a CUI and that's all it needs.
+	 *
+	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
+	 * enough space to relog the CUI (== CUI + CUD).
+	 *
+	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
+	 * to relog the CUI.
+	 *
+	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
+	 *
+	 * tx4: Roll again, need space for an EFD.
+	 *
+	 * If the extent referenced by the pair of BUI/CUI items is not the one
+	 * being currently processed, then we need to reserve space to relog
+	 * both items.
+	 */
+	const unsigned int	tx0 = bui + cui;
+	const unsigned int	tx1 = bud + rui + cui + cud;
+	const unsigned int	tx2 = rud + cui + cud;
+	const unsigned int	tx3 = cud + efi;
+	const unsigned int	tx4 = efd;
+	const unsigned int	relog = bui + bud + cui + cud;
+
+	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
+						 max3(tx3, tx4, relog));
+
+	/* Overhead to finish one step of each intent item type */
+	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
+	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
+	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
+	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
+
+	/* We only finish one item per transaction in a chain */
+	*step_size = max(f4, max3(f1, f2, f3));
+
+	return per_intent;
+}
+
+/*
+ * Compute the maximum size (in fsblocks) of atomic writes that we can complete
+ * given the existing log reservations.
+ */
+xfs_extlen_t
+xfs_calc_max_atomic_write_fsblocks(
+	struct xfs_mount		*mp)
+{
+	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int			per_intent = 0;
+	unsigned int			step_size = 0;
+	unsigned int			ret = 0;
+
+	if (resv->tr_logres > 0) {
+		per_intent = xfs_calc_atomic_write_ioend_geometry(mp,
+				&step_size);
+
+		if (resv->tr_logres >= step_size)
+			ret = (resv->tr_logres - step_size) / per_intent;
+	}
+
+	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
+			resv->tr_logres, ret);
+
+	return ret;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 670045d417a6..a6d303b83688 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
+xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 1082b322e6d6..eebd5e7d1ab6 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,80 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+/* Maximum atomic write IO size that the kernel allows. */
+static inline xfs_extlen_t xfs_calc_atomic_write_max(struct xfs_mount *mp)
+{
+	return rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+}
+
+static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
+{
+	return 1 << (ffs(nr) - 1);
+}
+
+/*
+ * If the data device advertises atomic write support, limit the size of data
+ * device atomic writes to the greatest power-of-two factor of the AG size so
+ * that every atomic write unit aligns with the start of every AG.  This is
+ * required so that the per-AG allocations for an atomic write will always be
+ * aligned compatibly with the alignment requirements of the storage.
+ *
+ * If the data device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any AG.
+ */
+static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
+{
+	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
+	return mp->m_ag_max_usable;
+}
+
+/*
+ * Reflink on the realtime device requires rtgroups, and atomic writes require
+ * reflink.
+ *
+ * If the realtime device advertises atomic write support, limit the size of
+ * data device atomic writes to the greatest power-of-two factor of the rtgroup
+ * size so that every atomic write unit aligns with the start of every rtgroup.
+ * This is required so that the per-rtgroup allocations for an atomic write
+ * will always be aligned compatibly with the alignment requirements of the
+ * storage.
+ *
+ * If the rt device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any
+ * rtgroup.
+ */
+static inline xfs_extlen_t xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
+{
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(rgs->blocks);
+	return rgs->blocks;
+}
+
+/* Compute the maximum atomic write unit size for each section. */
+static inline void
+xfs_calc_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_ioend = xfs_reflink_max_atomic_cow(mp);
+	const xfs_extlen_t	max_agsize = xfs_calc_perag_awu_max(mp);
+	const xfs_extlen_t	max_rgsize = xfs_calc_rtgroup_awu_max(mp);
+
+	ags->awu_max = min3(max_write, max_ioend, max_agsize);
+	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
+
+	trace_xfs_calc_atomic_write_unit_max(mp, max_write, max_ioend,
+			max_agsize, max_rgsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1089,6 +1163,13 @@ xfs_mountfs(
 	if (mp->m_rtdev_targp && mp->m_rtdev_targp != mp->m_ddev_targp)
 		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
 
+	/*
+	 * Pre-calculate atomic write unit max.  This involves computations
+	 * derived from transaction reservations, so we must do this after the
+	 * log is fully initialized.
+	 */
+	xfs_calc_atomic_write_unit_max(mp);
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e67bc3e91f98..e2abf31438e0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -119,6 +119,12 @@ struct xfs_groups {
 	 * SMR hard drives.
 	 */
 	xfs_fsblock_t		start_fsb;
+
+	/*
+	 * Maximum length of an atomic write for files stored in this
+	 * collection of allocation groups, in fsblocks.
+	 */
+	xfs_extlen_t		awu_max;
 };
 
 struct xfs_freecounter {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 218dee76768b..ad3bcb76d805 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1040,6 +1040,22 @@ xfs_reflink_end_atomic_cow(
 	return error;
 }
 
+/* Compute the largest atomic write that we can complete through software. */
+xfs_extlen_t
+xfs_reflink_max_atomic_cow(
+	struct xfs_mount	*mp)
+{
+	/* We cannot do any atomic writes without out of place writes. */
+	if (!xfs_can_sw_atomic_write(mp))
+		return 0;
+
+	/*
+	 * Atomic write limits must always be a power-of-2, according to
+	 * generic_atomic_write_valid.
+	 */
+	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 412e9b6f2082..36cda724da89 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 
 bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
 
+xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
+
 #endif /* __XFS_REFLINK_H */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9554578c6da4..d5ae00f8e04c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
 
+TRACE_EVENT(xfs_calc_atomic_write_unit_max,
+	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
+		 unsigned int max_ioend, unsigned int max_agsize,
+		 unsigned int max_rgsize),
+	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, max_write)
+		__field(unsigned int, max_ioend)
+		__field(unsigned int, max_agsize)
+		__field(unsigned int, max_rgsize)
+		__field(unsigned int, data_awu_max)
+		__field(unsigned int, rt_awu_max)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->max_write = max_write;
+		__entry->max_ioend = max_ioend;
+		__entry->max_agsize = max_agsize;
+		__entry->max_rgsize = max_rgsize;
+		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
+		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
+	),
+	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->max_write,
+		  __entry->max_ioend,
+		  __entry->max_agsize,
+		  __entry->max_rgsize,
+		  __entry->data_awu_max,
+		  __entry->rt_awu_max)
+);
+
+TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int logres,
+		 unsigned int blockcount),
+	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, logres)
+		__field(unsigned int, blockcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->logres = logres;
+		__entry->blockcount = blockcount;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->logres,
+		  __entry->blockcount)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


