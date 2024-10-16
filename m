Return-Path: <linux-fsdevel+bounces-32097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9389A06F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883DC28755F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C791DE3C9;
	Wed, 16 Oct 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QnwsVeHD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T6gLNDuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A0206E87;
	Wed, 16 Oct 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074062; cv=fail; b=nz3NZu714f1I/lUXioC7o1b4RyB8PRQpCQq8A4XcSo6Q3+uu9lK4y5YXZFsEh/SPLo04Bt62SOmip9DSXIaBwihK9blRtaKwFZ7z7hm4GCLJ1n4e43UAJyw62TRDIvQPp/W1R77i9+WR6vERWFCNZVLSeeo0lXRzTmYsrzG9rt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074062; c=relaxed/simple;
	bh=DN32Fd0ZS2NHixrjIEMgzkRN9X+8QCVS3IG0rdQ1ZEo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gKzo9rmzXYW2gN/oLvysPl/6mKaTaLEHyxUxsmDttFyDkdvJg39A8MQ98toMMg5rxvuK3qPS2geNhmIlB/J7q7k+/mEbOegLQU+2TgUJXpQ8JnPvkYSexl6+Jg15lBr2bxyjRv9YqfvHpZiluVYGAO19xaZCRQxOWPd0Fy0oTp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QnwsVeHD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T6gLNDuw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tgqQ022173;
	Wed, 16 Oct 2024 10:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=leaylDcupTOZI9b+
	oNGbuEFvgzqLFfPeGFEA0raKqb8=; b=QnwsVeHDcBANv0Ra/c26k1nfmTOq/SX6
	Zn6QQ60L4bOGq8MAlyPOj+rGzWe2mnwd0vFJ1C31niOW/t1J37bvrA9pRuSwd9TX
	Cy+S3Xh7Vc0DdIhctuvHuogLXuDujnM3VSWpiCukk5vKBd3Kd+Y3ZWTTh+y9Q22P
	VBYmUZVHqQRtbzxiVT7HH4eu24ahaj+HCd0c7HhafS/69AGHypYtSLJY7vckSD5D
	YfsCDldqWWzO9RDvJgaP5DCcJnHdB0vFKHWVX1GzqORRsI4ApLxxxXyniBtvIIgK
	Cw3QqiQ4I7R/MI8Z8MmGhCbUcD+0jcPQnP8f1HsEVzNbAdusjSmX4g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcjyud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8sFmU011048;
	Wed, 16 Oct 2024 10:20:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjexxb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2bbu8ny67QQ91Qi8gwt78XmiGS4zdTsPLeIKBAi/6vYEQq4wQpFk+F8JPxHmsPBDKIXUUM0mzerP4zWHya8J4C3F/O5feX/g17wLEThplM7OkGLkUvhQZGJR7N7O8iiVH27hi7Qn4BXgpjUrUN0rcUGsQv9Dg/sIwuHX8iCJCLa2Jv7nxi4WEo5rkD1GDPsUa9YdSNFt9MOGKcJw5Oh6y7WhM7nIEtnlv205wOtPasE0qZaVm9hQ3jpOQ7yZrTLpofnhtjf3RgYdVdpwnKs2O1Ipo7cKO1uvt1h0z/ooJ71Mi8t++NpotNfjfr2iCpd2us92K5yN/JZSraCZYpo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leaylDcupTOZI9b+oNGbuEFvgzqLFfPeGFEA0raKqb8=;
 b=xJFUVFOvO6ac+ZbxLWhbQh4C32Vcz0ZgaAQIK8ZLwAkXW1Q1XTysm4a/taHaI1DOZgl0LOYkhX1FtEKJfYKiTYzEVSA5Pj9Qta6WAHDGk4K1GGBxNGZ1vP9SiDzhaU5ohsR35xWVZzk0qHkPC80Zb4HW4KzUDt/THHOFrAawbWs8BkQ/NoxCprtgfnY3d229R/o8AW0t0ikkzwrKrvdh8LHnAOK+ejEP9KEHju56I4nRs92SMV9Mb+yeLQYZGiTmj7EVZGr9bilOWocaKvSDejV4kCS3AnSXRKgnwHl8vgEUXwioNTHQxcXdNFb1lBT40kojfK6zgmQ6UlysstNalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leaylDcupTOZI9b+oNGbuEFvgzqLFfPeGFEA0raKqb8=;
 b=T6gLNDuwvu2EAU7h2rev/XV1vhHs6c8zSTX/phRNc3QyUTkbLKv9ML7ScPo1w7U4XF7vdFR44grIatJIbflOuZQlCR/zeKKCXuuHEVQEd6xlIu54Qb6nRbhxKAS12pMfXA0knnihEwKSnheQA1R3o2z/IHmD2Ad5B9cW7IsFEZ4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:20:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:20:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 0/3] introduce PIDFD_SELF* sentinels
Date: Wed, 16 Oct 2024 11:20:36 +0100
Message-ID: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 220da6e1-bba9-4e07-68f3-08dcedcc3173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmYkoa+onQCPnDR0j3oy29sJQU1LsjE61tC1EHV/Re4kIG7jd2tsy1e+75GO?=
 =?us-ascii?Q?05rCjcwS/NKcldwhyq9NVygJrlCtjgiiWGUsp8L22NYj6A+2bR3c91qzG1ZA?=
 =?us-ascii?Q?Y7uYcto+zCp8JDuy3G5zzFFLspaJJSsI/FHWu8Y4smDx8Dol2Y4l+x+tXNBI?=
 =?us-ascii?Q?qqbua4Tahauv3il6dgscUS5b+A+gdkKBzEpmBc0NqWErX+J5TREwu4J5qIre?=
 =?us-ascii?Q?P/UUgJLYuK4Q4l0Ekobm5OQiLz6vsbwOXZGo/JNOtssUK5xnxtVPrFrNECNE?=
 =?us-ascii?Q?JKNNXGGWvZcp4neMc9d4TI4IeSDHnB3mO7mAkhZx58erX/drBwIYx11yk1wf?=
 =?us-ascii?Q?FvM+2QZ03iHZAKLrRyjBodk1SxQ6VkrqblVfw7R4Nd7bCGOORCR4FANKMlqL?=
 =?us-ascii?Q?9WbhsgBa07szSs5M+JcWfNsyuanh3wElwYO4Hwl72IH/2ZR1SBZ5+YRWh/aU?=
 =?us-ascii?Q?zoxTw+x9bKEofET1m5GhdcTkq9TUF3YveFg/VZJLJ/VY5DAn086e6BZiWx8r?=
 =?us-ascii?Q?nmPFTUcFja/ohgYSP5Ae9TbfpF9/gvXTjQgxGy4PEdhHgPl45DR70l8Atifp?=
 =?us-ascii?Q?FPNKR28Yo+2wDvjkdF0QNS/jQG5+o3pnWu9fYCydLTdLS0fBkXFqmWhelxzx?=
 =?us-ascii?Q?ujZQcSb9jwGFuo5u1t6wi6oTsvZF59O/q/2zN5CJ5w6L2QdzwOZcUrAVXw3I?=
 =?us-ascii?Q?/aNoHa7jc4WE39lRwR0aOv8hw+Ljbq/rFaisLLyNsWN3ctnv8sn3QxqR+vbL?=
 =?us-ascii?Q?GyHz/5t99/fl05uA2KL5iKiVT2qTk/gNOfEoDvI47RHufimDLKxpM3x1kgrj?=
 =?us-ascii?Q?tAC6BXzz/c9lFR1bq03LSD47qoS/jaWZGhftZGJBcG2LEtNGdPoSBvlTYq2R?=
 =?us-ascii?Q?07MKct24CUIOMtu8m8Ia7M/JHxTqQ32Im3eq3AZsWLwF64NPT5ZQZN5Xoh0M?=
 =?us-ascii?Q?vkhz04kzxnoyHaW+q0YNLOdDhiXo3dofxrAf+h91m4fDxCxKfC6V7VAexY31?=
 =?us-ascii?Q?1DT55CRN79dUWqFS30s7xpJgG5yvVxFtjFtFNpBK4UWMpd95k38kulwdq5mf?=
 =?us-ascii?Q?fxkU4OLmhyoDK4jn17dzhzLGJUuneKjIKumewKszc7nvyA9gVkUqdo63fmK1?=
 =?us-ascii?Q?aFUQ6BE0VyjJAcnyJrLx/s25SpmDzb4mxXx2xAVayFezV9RaSQq5kgb/p2zB?=
 =?us-ascii?Q?KwNyxrI0hdKuNNayhE/YtHu1IxqIZUZp+FaXUBm6/PQf4+JOEZCfKELznqid?=
 =?us-ascii?Q?QbU5Nh/F41C4sv4J9VvQjD13+sIkc2Q4EIfic5Mj4yl2Rwh7zBLMdqKu4344?=
 =?us-ascii?Q?TbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UI/FRr1EvIfK2hoFdz1ePtxCWqJsyz7AZCHWT0dtV5+Jbod3ylT8DZyWizqL?=
 =?us-ascii?Q?7D44Z2tC5XlO79EgJNOXdWwHoGpNlzG4cDVAMyRs2NVzXuUvk4N7CG0e8EeJ?=
 =?us-ascii?Q?e1TiXHs+8GomxeCtfVZzo4EaDDfjuBD+5anS3iIkroWZnapsv3vsV83HZOOZ?=
 =?us-ascii?Q?JqaS898sDEc6+QlLh/TMjbh7oBWWBkh/fheQ9fJmXwyhhVfwQK+23ghjx1Yk?=
 =?us-ascii?Q?Ah+YR/2aeN6wDAippgKqCMBs69LBssQaFIqAQSESVmrlM29Uk4ztQXUw2U1z?=
 =?us-ascii?Q?N0ZZh1ZbuXlhht0kQ1Ez+NxATEjh7461OVtNUtmJX72Ou/TlTjXJAX4nS+YY?=
 =?us-ascii?Q?bJxnhK9W1AU3zNL0ReR78Alr/uK1ybkIAHS7ksswwoNCLRHoN3TspBSOelio?=
 =?us-ascii?Q?oc19oaAZcBjZVAw5sGw6y2DZFBKrbAgCVKFaDpyqnETcgCg9ZIwRLVXgh4XO?=
 =?us-ascii?Q?X0FkkF2+ye+vIgO0G3KLMzMvA6Q+n2v2j6kLKYPTKyzvupKyTy2SUN+84rNp?=
 =?us-ascii?Q?0LTzmWr5zlGYG+RsRkE+fxtmdFhbukHv3NhMolyPwTOxqO3kHfFFqR4zH4fJ?=
 =?us-ascii?Q?imXAsNjy1CAjUbtWjzUQx+0R4ArCL3Sq92VLhHVDpJN91UipcmidtgzxNUiU?=
 =?us-ascii?Q?KjN7aM2KJWC8wNajpxtO+6zPiU3Vb64hbu0PG2NuREROQihO+evarAxrFw6u?=
 =?us-ascii?Q?SOv0lC6ikmfrkcwg4iw0KK1eA7MiLaiG3ZQh5aM730tGeERE2es3G9QrUoDL?=
 =?us-ascii?Q?h6ToiQ1Y7D6rFnKSMIBDj/k5g//CRNzmGzv9oLyGkovKZGqyM1GNA1E4kUCO?=
 =?us-ascii?Q?fjTgwZVaS29qBI6uZo28mCyPZdFEdgaQm9nCygEifCsS5uWQG2osM/s/3RR4?=
 =?us-ascii?Q?1EawpEBjOwjmddNZStXXXJSKkT/yw2Q4YULwpwVauRdKj7iM/7ZYspaSmFir?=
 =?us-ascii?Q?CJVMSq2TQI3Yma2KkmJfzmSqYE8KLD0ob1qEbLsEXPJcC5NvQ1gaEwPZlkcn?=
 =?us-ascii?Q?nBxgenXcy+xYTTQ3qUG4xpq0BVAsp/Z9MeCMsvzcV9BY0HKhx3FUH3Puldw2?=
 =?us-ascii?Q?rsco34r+gS3Og3oEATCN2vfl753ccytW4XJDyOUeSPfLA+6BqxYvBcet6UoP?=
 =?us-ascii?Q?Z4fl1UpM+prloxrGZ9MGOKk693je1XT+2KoschkPou3tPbaziaDMS3iYN+c+?=
 =?us-ascii?Q?L8KPCqfcn7luwZcUEV0SJ93TOS2kdXFNP/TSzVg6MATVpH7RYxTzgsuXN/c2?=
 =?us-ascii?Q?MJV3nSSt2OEKqX/eR2n4a2exfAnHrKrUmKnWggPHxU6v5/NagfH8gIfxHdL4?=
 =?us-ascii?Q?tLdXB1G7jgYg/1rH7AUZgpMl3eiUucwKVZ+28fXTj4SIbqcbberCLG7mZWFe?=
 =?us-ascii?Q?lKjQg5xyeqfEmY3D5QmyX+xwx4HYZizbChkE/tol+x3JnC3NMGREu7vO9RjR?=
 =?us-ascii?Q?Ge7lcpIj324MWbHZ6+sI632/jPrhqj/un54g+CyUAvcevG0IEl+e9p6SWYio?=
 =?us-ascii?Q?OniByPPBDRUl1nO8K6wBpijA6Z10v5SA7TI4J7Te+kYyyvsc59oMWBaM4nQT?=
 =?us-ascii?Q?i/kSJqeuUQDD0JxrdA/ZPDfcfI1l2fJ/aDuTxhdgFB7Qioq33mt6flES2m1T?=
 =?us-ascii?Q?xjemisKMGnPGQVWpNmiaITi6wzI0EANgW2GfVBkgsscndpLo0Z4bsQUEE9dR?=
 =?us-ascii?Q?LEPr3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hbaA3yGoLgyg2uEhipMgUVaj8QGw7TVtiPhuBBbA5uLwg37jnPk8YakwMEATG6u2JPJstL1Ah1eD/n9ygMpn6DSbqPhl80D/tyoP3z/MAzs/fHHh7SigHk2Vy+3E/Wddp7hvtwWGEZOpzp6TioDTEWlsgOH4L/Jmndml20Y1xp+wQ4dm5pAo88Tu47Q1gZr+h/oSeSiYBSm86v9nFZCmfIXwp3fEsXdrW5uouT/7qfimbV6lmLcLDnSdLS1tPQUzOG8h3XauHcUzaKvJ2Dodi38dFUbD93Oh4k3pg/QWPdiS8rI7EhTwsIBt3Bvt4TbhEtzJse3nQZGtcVjyI1keeMl5pHc+DGP9A5tDxWYwLqpYij+LTqPmkpXeeOMJgxvTACWd9p6fBMgDR7l/g+E5y5btjKAMh3kXNAAHD7HIwnW9UcAgL/atVsYLuqUckN9WdDtdyvcfD8e71Gv4yCvl/u6c2v+visQRke/h8q1kdIgtrAsZ6oqYDNODCcrMMlkMQ67PECQKYlMBFahRCplgK2cHldRQWcIwNgooU8Tu2hS0eaeDviC99hOKFRhf8bQtVzmo7JXjYqDnsxpJDnSvSWd3HBRZG1RSttTgKk1JFsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220da6e1-bba9-4e07-68f3-08dcedcc3173
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:20:43.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAHOmQnuUpJgjpuW6l0Do7wHauj/KuqIaL0cADjZHU37lR5m/g5dLG1J01LpdrP+4AsKoFV7Kh8LwnV4tK17RF9Gkjw+jrk00MZ6v0/gjYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_08,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160064
X-Proofpoint-GUID: bsVEN6zScKpUXQGksAeUvpgR5VChdQIJ
X-Proofpoint-ORIG-GUID: bsVEN6zScKpUXQGksAeUvpgR5VChdQIJ

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

v3:
* Do not fput() an invalid fd as reported by kernel test bot.
* Fix unintended churn from moving variable declaration.

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.
https://lore.kernel.org/linux-mm/cover.1728643714.git.lorenzo.stoakes@oracle.com/

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/


Lorenzo Stoakes (3):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  43 +++++-
 include/uapi/linux/pidfd.h                    |  15 ++
 kernel/exit.c                                 |   3 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  73 ++++++---
 kernel/signal.c                               |  26 +---
 tools/testing/selftests/pidfd/pidfd.h         |   8 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 10 files changed, 342 insertions(+), 55 deletions(-)

--
2.46.2

