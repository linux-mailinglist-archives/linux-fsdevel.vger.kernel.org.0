Return-Path: <linux-fsdevel+bounces-26187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFDC9556F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322E61F21738
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366F14C5A1;
	Sat, 17 Aug 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hkD+5fs+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jzF1opbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DED13DB99;
	Sat, 17 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888121; cv=fail; b=sbPJho6loS69ZeK8vIdSiqYnX5ph+3IZgRbvB4GTlY4ANdq/ItlBSeq+ZYbZfnMXCxgvEcWyJWzbbUdlK6XEh1ONC5uIFk5bmX54x7kJoBW9MbYpNMOQskWoVkLviaXoKj2d5Plm2xHjn5XG7ceci2JPHn7zhhVWICLS6LBdBRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888121; c=relaxed/simple;
	bh=uey86mawGgjQ2zBh08bbumFhlwLLXCFFEW9qw22c5PY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nN3SBjy7Y0NIZYSndeUy0JkTmnN1tbK8c0t3Rx2n6HE8T66bFncteB03jZj9Psxx+nXnK1hGfpzPX9jWxl36SiftRoyIrlX80Uh+uUEK8gK0W5aRIAHUoW+TSxVmVPUmXtsgs/cmnEs6MjwYEX/28/X1qiQdd4YsHOtArWKfocE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hkD+5fs+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jzF1opbq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H3bSeu019336;
	Sat, 17 Aug 2024 09:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=x7MRNL5ixPtIWt
	QUD964Pde6zO2gLY5yYZqDhBa6i+A=; b=hkD+5fs+WTOwq+lZwyzNl57L0+pwul
	NWKdfk/ZY+Z22xiOZ7yviXnTyfUS8DkjEIWe4qI5SHyeEMMPVzQh27yogjT2SDSS
	aIP5wxWpJJKs1ajeWHOD3l2EsyqTDmjC84lmuTxOH5fu3jokX0vkZfwzDxPDO5bD
	RPIsOGZ6XEebHrJOCTuD83itwmZaH233PjyhLlTeItuXQv/aLso4vp+KaFX6LOy/
	kmq7cKUOybUTkkxemzAFqY/+wolEZtm9KgOxiLJS2wwUs2HY/5F/JrG6q/uj0q9S
	J1yxqUGPolEQWxpHTHbP0Rd1c0cWovfv8EToESBuG924VQ+Xk1mob8Pg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hg7e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H87Ykb037368;
	Sat, 17 Aug 2024 09:48:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5f26w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azSZDx4qM+cTZg76m7kLm+jdunGi/Vmz+b5S9oBW1WvXcggrrZEic/pUeafhj52PGj78fveJoHYUPrYcGcxLfIICR9MOZB9ivcKlzsYxVibq4eo648QA8EgFJW6EW4wHMvaxcFZbW5HZV11Cg14ahFNPJC7J3AO1sMsmnqeZpfNEBXynZie014euUhUlifVcCsIwXej4kYlcacias0tG7xCmMujgosNdIpw/0GPb76PgMSjeOwD/tHZVXWroxxZ7jsUGvb3C6YvlDrTGunge3lY/mKRsgIsCHmoFft6HEIXsxP1+tsEgivzrRcXB8hvVUnMWZkDkpndBzU15J8d7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7MRNL5ixPtIWtQUD964Pde6zO2gLY5yYZqDhBa6i+A=;
 b=mbPnfqw/xOJX9kNmv0qdGdGed3dNXg8BsTVLd1bvjoIvs2s6U0wnT9KZ1Fg4F/0k9sy2q0biHGBewRpykCEfN1Fn5+fbv4hnUH11DR+TW4NDV+osZjD/9+ef2YHBrxP/mDU9jm73YD+WYifoIP6CH+ak/z5ihuFBVGIAyWNTssle3DGplRNmMv7j2aohA+rd96AjJjfJfZFbA/YmwmF30/L+86c/Fvp+wO9eErUNzWgDR4bfhdzmuQ2vWUfW11M0xc+SWx6IgF9siZBb9uA0EVXXmU38m3k2eHfGYrrS/waZ1p2wvHgMI3XuOHN6zNC9V17d/kd5EfRUnLPuifmGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7MRNL5ixPtIWtQUD964Pde6zO2gLY5yYZqDhBa6i+A=;
 b=jzF1opbq+qsWq0h1ukRu2mL/STi9o3K5yzt10aNmxh5uC9cYYEwfoi9yHLKi1EG9MSQtUS9Eb6t6zppyo1Ng97N7eJAK6mPcvXt6t36ItPaPWJ5l4lxgqy8Tqq/NcJJBJnUWeTXr0jZrdeKvkEPD9ZZWT+aB3Daokqb4hgXZ8XI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 0/7] block atomic writes for xfs
Date: Sat, 17 Aug 2024 09:47:53 +0000
Message-Id: <20240817094800.776408-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:408:e1::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1078afad-3157-478c-6837-08dcbea1b7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyEnLWG8sh46eq1/CiTdQtMbUPqBGIYbKwa+mZo+f7SKZ3qCulJ5TC8TMB8p?=
 =?us-ascii?Q?6f/BpolH9+u4t0ioG9t4YyQlCvAl0CqA+y1aQYdYQL+Ya4REKKn5ElFJ+Xf3?=
 =?us-ascii?Q?1sZsRISS4ZGu/X5ijAsSb3ULHkxCCuy44LlyxwdtHRjDDXXJpA2H/uIS8tqN?=
 =?us-ascii?Q?mqudzY5vKVPEdrYvx6AX+4cZmnyc75NAlUaBl5lrA3ek2xg0I+K6AOb3Akzg?=
 =?us-ascii?Q?M6b5cn9n9Y8E3vW4nNf4PtA7R5508wLRuRV8SGb/P/vcf4jF/hCb+sCvRk3y?=
 =?us-ascii?Q?fiWXnRZntTGfjwIX14a7ZwIXygKDWpjTrQTHZ5dko23DzBJ6smR0xv6Q0fW/?=
 =?us-ascii?Q?yrAXtNgcP3GNtFGlB/RmZMzKqg9hckpbhUOj0zurBLdSqojk4O1p3K152dQC?=
 =?us-ascii?Q?WBRMaQ6pCmcsz+v6bF731Skwi1R/CV0AU+6v3vOqW0VAvazPd2w5Spt7ewo4?=
 =?us-ascii?Q?3w1rdlH33fnj0sQCyIUFgJLhwOVZbWzjGWHbho0ojKMkffe3r08I18hTwWkn?=
 =?us-ascii?Q?Sxa7009myWMhhoHUfaAZ8AI0dk/bivSEuTVKtcrlFjmPydf36GYyi2ZY2Dpx?=
 =?us-ascii?Q?+CKcaWSUBPjn24wFFRcgNnPiAF9GOfdQ0QNRF/sDAsf0oZdFh4MNyrwl5GXQ?=
 =?us-ascii?Q?hK643DpS3hs6Qr3zxse26bUMNvaNJs+JzPeyRWTiZsCxwR4bMVNLoZoVi4Vc?=
 =?us-ascii?Q?t9+0Ffdnym3VKRVrDfmFquZmATOW/A62TnrsOO3Ek9muZswxVwawk7Bors4X?=
 =?us-ascii?Q?ox+S7WQrTedg9xEpiZc99ycifjAAuRihI6/WKq6pgsNee6FcxhyCyQSKUD9/?=
 =?us-ascii?Q?3YdoCsfT4FFBcKZacrVVbtvMH2UNQhzwJzK5DbbV3DBt3zTRjeSJM/4vJ+cf?=
 =?us-ascii?Q?zPf+DABKCPqwbC2Sb2PUrJK2IO172q8S2JYEMiE1dpn/84hiLqzTZ3GiM8bY?=
 =?us-ascii?Q?7AVPfXeXZ9Y7xe83E4tQOYO6LOuzckmPNDHXoiUTCfiVwkl1RPO8g8GSvNOL?=
 =?us-ascii?Q?7+O02g1t3cJ9QZJYiI5fQy3X8b26jkc284X9I2/UwpQtm2Ynh5bByOr8s+La?=
 =?us-ascii?Q?z5rckliB4BR8iLLlXp1lOG917UrtkcNY9FFwbJXMJttfZ7r6Pwimix0nTAlQ?=
 =?us-ascii?Q?vncoi3tpBzF8QTpw3aiOauOf7MLCocdjxyEgt5L+TOu7U02Jc7gZKBMEujZu?=
 =?us-ascii?Q?B4HvgWykBvmH5fpzw+Q///5memNXY5W4awL1IcImPw9iSJW3u9v0Q8b+ZxVR?=
 =?us-ascii?Q?dP3EC32OTTbxe5sqGs0BqcEb9W2XUkjcpuSQ2x7/mkK/94weCVL10BkPC/d4?=
 =?us-ascii?Q?YHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeuqi7dz036scoZP0PzjrYprWvb27afGIbEgtFBcfPCuXi9WxpAN9jhS1lhN?=
 =?us-ascii?Q?zxVnlo1GO3oHsU/NM/Md9X5JoQsajijnmEtvt6YWt6wIb3wQPJfJ+xUEKWOC?=
 =?us-ascii?Q?xdOCn0EcCsyNoe0Ns0/pxvB6PEiEOVIPKRUgpuWCBjB59i3xFnFr3JZaTVNv?=
 =?us-ascii?Q?82cngS0924Jy8ya+x13Gd+jn11qiYlAPHF+HCREm5VJyFSOQkIfK4ZqQAg5F?=
 =?us-ascii?Q?g7V9GbdLY4PntUrQ2tOhwy1TLVOp/d+Oo4xsvREOxjyhNauo9f1ooV3XbNhk?=
 =?us-ascii?Q?nx9Vy5l5YdZ38lGoQ23UE4LukoQEuRchtHV+1F9BZaIMDgPO8IbQTLl8jJt4?=
 =?us-ascii?Q?MLx+p8wWj6zk3KAMJZTgEr2BqcA4rmjzn9i5wauF5gY4UQIWgejdtQw/9rNj?=
 =?us-ascii?Q?OjB84Z0lZfll5KUYpiJjGD/NlIbaQXSsSzUW/uLh8M+m/VCAjmXPIMv1wU2V?=
 =?us-ascii?Q?M6LUCTjA5KZ89Ev7R+UORWU0MuAl/uS3H7XJyUJAOtcWboxJSaucyuF1N7n8?=
 =?us-ascii?Q?is6bczMPtHBu1R6lj4Bqdt9LkfRJHWbRTrvj8Qx4Tmyn6Z0W2VCDIzUycU5y?=
 =?us-ascii?Q?XYNQN5VcUMv7Pur54Fv1vpCL5acYi2oMbZfUkvkS9BVe7FZDKKQmeepo1zEl?=
 =?us-ascii?Q?VnKG8kBLjve9qktF6sOu6bAoWvUyxHjH9fJOVvylfMDOxL3gbw5+KOn3gkvA?=
 =?us-ascii?Q?RkYFtkxlDXwyAoMHy9OOA/D8elKuAiwBmlCCg/qsJTc8uaJ7VXbDGSdsSyZp?=
 =?us-ascii?Q?7NxwGy4YnNLaAw0mENwUaGm+smM/54SXZHBk6LFkFUlYItHly+wadEW9H5kp?=
 =?us-ascii?Q?snYkNQtN7oNxg1xW+O9KISYi6hbNlbB8gMziopOCMrFnxEo++JQjadA1ClSx?=
 =?us-ascii?Q?JocvrdPWppvQvDeaegHmpWxSxpNjrAszlQ4tRNQleIoOCgWjTOjyoacZQHUy?=
 =?us-ascii?Q?BXaCVXej+T0amfKLTLzRcq307BcmH4BlpaO12EMuwtBrq6A6kP0q4NX/Q8Md?=
 =?us-ascii?Q?nZK4Yd+qZupdTE1IxZQjbUfDpVdzjjBymEdiPMt4wSQfaEZsoSv1mEnrvmdQ?=
 =?us-ascii?Q?CotPO2B20+D9lQjj3/v63TlWQr5IMWck/xflx9oDcFxjvmfLteF4wgVdH6hv?=
 =?us-ascii?Q?k76orBHBWTjR5TakxmvJLboeKIknMigaY/1S8dixGchXZxu2MX/IQYI0BovM?=
 =?us-ascii?Q?TOULnE0RdReA+yxJpKlbQIkuuUrJdroxPXhiywHDHIx31zCS2ON1qRDTxUm6?=
 =?us-ascii?Q?khFvmYn5NvxR0PL8xwwPC03YueO5UHCartVlE8xK56JZc7coB8jw3T0OGhF3?=
 =?us-ascii?Q?f27bIzOCerM34NH3MgxjV0hVBXmeF/zt5yH8+eBmXN7FfXvwhJQFykObbW8/?=
 =?us-ascii?Q?V+Tbu6awM0Kty9fRfDsGh7YxB3U1PQ9cm4LgKdPC4cMM5NV1mMP9TZx6Numl?=
 =?us-ascii?Q?GkmHairX8OqyTQ28YFoljz0yzga/u+uYF858y/Wa8x8Qb2ibEf491L2tRPP3?=
 =?us-ascii?Q?eDMhtQi6r1yP6U2cU3GOPWk75jetNKsZYowep9oAHkQf7hJp6TDoAQlOzULe?=
 =?us-ascii?Q?TTD0KhOKIvShWMPFBOb0b8SzmH0FnHahenbKNYViSDievSN6mKITiKSc7uyx?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7mQIrn84IkOYtW8r6hRENdVDngQrQUj503X+VQqdQhAjk20g7W7DPOeTWJ4zfDqtUdwQoDDnhdj7vAx+56QqVnltzBI/Ve7R1RMb+3Tail/F3RARVOsBb+8ExSxoealndOIjVuFYIXDYVW/46h8MUgaWmLhNzlz9LIqxAw0DFszL/S+2bMsIx1CdcwYZqTiC9xd/OoSNb6YrQX+s8dfkkQ2Rupo6DafRo5skeklpCwTWqSZmzHwFbZAA4IxEjP1U7FmZPIJ3BAez+/upRrXgvP6w/1zLfOcwzOctWXL61EPnaq91ZIaxuUsaC1CAHaw6QEs+k/SDbrEF5+cBVc8nK1fvfn1wI9QcP6TJeBeby4JR7vIlCwld6VwyDNCmrFqy6/w9CGoH+UIsK/LzJIzV1tg+bT9l17AMYcHkBsqgEHrcbOa3yF4q/VfH+UBjjU710SvPq5vEXng2kI7bCby1YkHzNPnoHD/0ZnXEFO/D8xoJWDRqe68wFYJZlr6689kTR/BXLGhIJ067CTZVr+IMG9tA/AkaydGO0ga0rBpoSBCID8WJTgZGxUFUalg1JHCl1WqutDSByZgGm03rmhcOlIjzQ2h0th/Z2fJZErn2C8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078afad-3157-478c-6837-08dcbea1b7cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:16.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfqoVKnvUJnPlGuM7QdA5jLfhdVqSXkC29HyfyQw3idWQ2e0jkrKsIKESWipFhklS7+4ZDAWpu+h9wv45lOSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: h7VWPAOwOyaTfs41iPuKEWz2682Cflpm
X-Proofpoint-GUID: h7VWPAOwOyaTfs41iPuKEWz2682Cflpm

This series expands atomic write support to filesystems, specifically
XFS. Extent alignment is based on new feature forcealign.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

XFS can be formatted for atomic writes as follows:
mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1  /dev/sda

atomic-writes=1 just enables atomic writes in the SB, but does not auto-
enable atomic writes for each file.

Support can be enabled through xfs_io command:
$xfs_io -c "lsattr -v" filename
[extsize, force-align]
$xfs_io -c "extsize" filename
[16384] filename
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[extsize, force-align, atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 4096
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...


New in this series is a re-work of the iomap bio creation, in that we now
produce a single bio, which may cover multiple extents. Extent-based
zeroing is dropped.

Baseline is following series:
https://lore.kernel.org/linux-xfs/20240813163638.3751939-1-john.g.garry@oracle.com/T/#t

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/forcealign_and_atomicwrites_for_v4_xfs_block_atomic_writes

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.11-fs-v5

Changes since v4:
- Drop iomap extent-based zeroing and use single bio to cover multiple
  extents
- Move forcealign to another series
- Various change in ioctl, sb, inode validation
- Add patch to tweak generic_atomic_write_valid() API

Changes since v3:
https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#m9424b3cd1ccfde795d04474fdb4456520b6b4242
- Only enforce forcealign extsize is power-of-2 for atomic writes
- Re-org some validation code
- Fix xfs_bmap_process_allocated_extent() for forcealign
- Support iomap->io_block_size and make each fs support it
- Add !power-of-2 iomap support for io_block_size
- Make iomap dio iter handle atomic write failure properly by zeroing the
  remaining io_block_size

John Garry (7):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs: Export generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 block/fops.c                   |   8 +--
 fs/iomap/direct-io.c           | 122 ++++++++++++++++++++++++++++-----
 fs/iomap/trace.h               |   3 +-
 fs/read_write.c                |   5 +-
 fs/xfs/libxfs/xfs_format.h     |  11 ++-
 fs/xfs/libxfs/xfs_inode_buf.c  |  52 ++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.c |   4 ++
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/xfs_buf.c               |  15 +++-
 fs/xfs/xfs_buf.h               |   4 +-
 fs/xfs/xfs_buf_mem.c           |   2 +-
 fs/xfs/xfs_file.c              |  27 +++++++-
 fs/xfs/xfs_inode.h             |   5 ++
 fs/xfs/xfs_ioctl.c             |  52 ++++++++++++++
 fs/xfs/xfs_iops.c              |  28 ++++++++
 fs/xfs/xfs_mount.h             |   2 +
 fs/xfs/xfs_super.c             |  12 ++++
 include/linux/fs.h             |   2 +-
 include/linux/iomap.h          |   1 +
 include/uapi/linux/fs.h        |   1 +
 20 files changed, 325 insertions(+), 33 deletions(-)

-- 
2.31.1


