Return-Path: <linux-fsdevel+bounces-46468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA9A89D69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D103BDD9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A02973C8;
	Tue, 15 Apr 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="clVtkVsY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yYSGqiFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC2296D32;
	Tue, 15 Apr 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719301; cv=fail; b=OWqtpUsbISjmUUFsmYANDGQtuoEtuBJig2g9MzTh89trhBiajyxlWOIvxmmCObo6qveapL2BvucfCuO6Rv8Lg25391YGc9RvYE2lfEAwMl01H7PuL7wLDesswepHqoj48wGh4ISZO44CmvtY5XtP1WmnMgTiSir/3R7lgR3jajU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719301; c=relaxed/simple;
	bh=MYS3ImCwkABPW5OQEXi1s9uudYw1zWMQnI5ViTAHVPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfpyB6bqPob6a/3tqrAaSIS0JtJUFhY14M1wkCN6iQngKN1SBnlKsP/iXhZbOer6V/Whd/z2rgdgPr0TijYKwDCoTvYFQujm71p/LZFi1mF8CwtkjIZG5U7OKsriID+NJk8uO1yvY5i9P0dGagJCz9YBZ8bRLXO3reaXmebfdWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=clVtkVsY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yYSGqiFb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fnn3032426;
	Tue, 15 Apr 2025 12:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xjTvL3RPR141S5zgrWRMIkIh6Nft0D9VJwf6Vp/fnCg=; b=
	clVtkVsYRyVqUhcDgTtQ2RysyToK49ZGB3sV98Xh8cjHI8EJ7KR1QG0/McF2oJ9P
	dnR6mxfBOlD1YI5AB/VUju/k9/F7Wh6Dzj9PiPWRjBCab/gwYyhxcRane+iP9QJ3
	ty7XMls2VDYS3WerTRZhSjMVsGeKazQXAALBWyPxXyIIwdNg6Hbutvoxyw6jhZel
	sMubpKZQQDrjbQZHGs87HvGg/dCQRDkBvKoVqQTT3WEyDP/PsOkYye0hQ0HKXk3D
	Im8xx5Hn5EaN1qnI97sGMY03el3it6M67eQy9qV17nZZXUAL1DOJgEZbPgTxUL1L
	ia/DBMQO4lSIHfZcIQ2Q5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju9k2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBStwk031119;
	Tue, 15 Apr 2025 12:14:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbaewty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLP3+oIEwIW9stkOzdA7bayHgziA/hncsr1kVHVTgjrYvfH/oaVgra2FEg1xxIFClEwkjE6f7v98W/17FKGLkQirVzwMIFObQCqfy/ZEAB0AQ5mvWWH39kskizhXyHPCIyO1QEfaFeenuQ6Vas/PjHAlvbDmqZTEtXG2CEUDQI8yPNzC9EuHv6EdrQRys9IbrtlAo1remRcDJVyhQ+xYot724wk4G/TGMyrOGQqTvDhFEuUJKC/gx7VNcJmp5qn9RHkxtHM8fWneclUDbGo0J0KO+pfrpNmULOH+Sczu03oLWxQkE9rg1ZbHigzRdkGonaw5tTdB5oWd5m3fssws7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjTvL3RPR141S5zgrWRMIkIh6Nft0D9VJwf6Vp/fnCg=;
 b=SoC2v7xEsfRV2lc+9jt6QOKG070UTy/vqO9cr3/U7WTGpMI5WTwT8E4buwcohNHKNFRe46iTiUDSLLqaFOpl+y2tjvZ0RZk3Uvoj7GeFB4BrXocy4p8UDYJKHGnyTaqujAqxzTPqHwG66xILT2rY2CjNR7bcFQQiFdqbI9UNHbqEgqcBdwYNhmd/qNXW5JnQiuQkNgzJsQqp0UmaEHlt8NHpzwl4OLo15t+YhBfevAJnqHZhr24Aj8oZH40ZkCnRWQpfe4pyKeFNTvyvkiPY+KpjiIXOlXiGb7qvvT4Eu9X8VG82oaKa9QGPPQ/xeUnxGWoPzoijVDHp/iM+Hp25Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjTvL3RPR141S5zgrWRMIkIh6Nft0D9VJwf6Vp/fnCg=;
 b=yYSGqiFb8MSbxFg3zj70CY6FYRB3QkP64+MJQ66Dn5EKhMQQoPIR7j5SkTAZzyf4qnBmTd6EeDxVve1uQK1pW45S6CYW+b2SoLi5C3p/QAMGAYnbirRIv7REbiDQT1Rh+cUaTQJAmzzmH6IkF8iKBSSzAq//eYC0vU1/lpw/NyY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 04/14] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
Date: Tue, 15 Apr 2025 12:14:15 +0000
Message-Id: <20250415121425.4146847-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: eba17243-89ac-4c7c-cfee-08dd7c171bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pd3qRn6NeRb1H1C092t3aIqX50+it9T+0ZazRqLqf2DnAkjD8g0Qpiw4bJKa?=
 =?us-ascii?Q?LEHxvd/6/nDBqmAR819M/v0BSg/+a82z1ZChGcx6CTlfjGM7w6teGeqMj889?=
 =?us-ascii?Q?/LK/UVrJjzZWlTBe4VN9ck8Uj4nNTHM7BxfSEnSP1X9fk/KU8vpeCPHaQimN?=
 =?us-ascii?Q?WWvltcA5g9+LdrRHD/gb/enw+shhU9B948VYl7JC09C3wiZKLuDy9uNa5fXM?=
 =?us-ascii?Q?WLZOiMWYEmeRK/eRt4QxP6wizkdKD2b5IFSLy/UrE9zlE6l2vC8nQhil3bFH?=
 =?us-ascii?Q?CE5Ikf9DlgGjyWq6XOQiDJ5r6qqoE15rKepU/9f7jxsutJzyn4lkVqjkn3Of?=
 =?us-ascii?Q?QzqqBKKlSkHr1dKdzRSuPKOSiVD0yE+An51GrN5a3cZfbX6OqRQzFj/TypAs?=
 =?us-ascii?Q?iK9QPeYd0uxhd9qSIOj9oVRehBnMNGb96jpSzyZHix0E0AJH+anZJ0U4C0my?=
 =?us-ascii?Q?qEVfNpj3P/C9x8JBDW3HmhDU+3NZdIM/XvpQR52nNerH4qJhGb7bHc8RnEnR?=
 =?us-ascii?Q?NEiv9yEuZ+jNLBV9UI76N2DdUyaj15d6MEpEZ/MoEIhUupQkes+YqfUwTmHl?=
 =?us-ascii?Q?XWpfdQkGYBRpDzWrPubUZNmbfeUZ5rfSfMloW1gq3CUjcPJMtMy+iq9QJQTm?=
 =?us-ascii?Q?MoBONfj2emTXDcHof3lSHfkqHhMgi0cwFjlmFr9JBZQF8lXndICZq8IXl0gN?=
 =?us-ascii?Q?tLY6rkIehQ+eedTNw3VUCGH7hNRZCxFgXBq735NUedJIVUmLG5NzPSWJKhvw?=
 =?us-ascii?Q?GiiNAAdpYbVZB0UoVEM4aIZUz49x4rf7XMSFoImQyF5bTwxIoGmjl18zayNk?=
 =?us-ascii?Q?1mAQQviNRzV6ZLdiuPoMeZW+2JmgsziQl2wOaqEDhBdgqxgTTxSNuzfdJ3eB?=
 =?us-ascii?Q?kKXNL62fZqdgmDKMzsOGLmFnGt175TJM3hpf6o44YUv/4Q7io5LM0CQMA+/V?=
 =?us-ascii?Q?1vfviupPYc+6jyAgmImXUlLIa5i2wW/ShyVyhtW+zC3n8ZQ4joGdTUnBgVjZ?=
 =?us-ascii?Q?u8Vx7LXVCKVH1B8zCauDazFcvumGQLCiYzPyc7n0O0LekzfyOFKyXHwBKuKu?=
 =?us-ascii?Q?0HgGBqQYc88qPhFQAxPxICB3niMoYzY88foRMZaxjeBwT5xpv4HDmUekAn0v?=
 =?us-ascii?Q?lLVQdWAAR9MnRDHKzRR2/KlTLSCJUIaO5odZNR2IjUY0anNAgYD5j0g4c7Ji?=
 =?us-ascii?Q?o/TamBEjU8UR4Wyzro3fO8gPwMtQFSKwBiE9YGus8lKFMZ7Nbd38AQ5LFa0z?=
 =?us-ascii?Q?tna7wh4YkdCuogR7aQSnoVpM3forTJGcXFTGZdLHI5XmKxX1ynthw6lav1VX?=
 =?us-ascii?Q?vSOoTIMCOt2NTjNTmTyAQi/3tHTDqcpLeYG9jYJARiLjCHpttPPFJ2ikvz4E?=
 =?us-ascii?Q?dkJdnImVKXPudTpEkqoBRV3rB7we8nJqGS0homacJ4Vy7Mwmbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQYdF7zn3geokpipaLZJFOHVwgTlqzw2BGlbblj7JkDC1F2WI/0c0hLDvBJi?=
 =?us-ascii?Q?9mEPTDnJb9gamYN9K/Ckgy179tXCCW8v3rNJVSQLmlSubs9AikAZZhnAwp2T?=
 =?us-ascii?Q?OZ/69aTcon91P5XzAF+AVq6r0opWal0l9CLI91S5mneK6h5feI2Fcg7FbD+y?=
 =?us-ascii?Q?T0xSvjlzrCG5GTsPuc5TW9dqvECnXjTjhIntLv3QluQ2SwGIEiEnQfDqFKSC?=
 =?us-ascii?Q?Ryg+8HXTFJH7tcDsJZUX6krlQgQsqRwQkmg6x2MJBGnR/nzk1y2h/YFB8Wkq?=
 =?us-ascii?Q?bRsTRiNMf//tM/wamGUsrWBJ9vXdmbyo81ZXOGVCZ7WiD2KIqLGslbIrIlGM?=
 =?us-ascii?Q?b/evO5oWnfvBvlQBY7fR4ZdvSyyJ6lGfLYb3h8ZOiblWQp9QlzQbHW4EsyLk?=
 =?us-ascii?Q?+Lxmz799tsINvRqT23ssVL2cbHUjQZt4EAb8AMgnIlCEXWFdKZvxIYwYPXFp?=
 =?us-ascii?Q?XjOS290xComUhl+8bFLPsqhxd11lo7R2vWmoknVqUGhKOKQ0hy9FkZaOvKX1?=
 =?us-ascii?Q?rDa+k15+y176fsCZbcuuekVmyFRPdwm/tG+2PHaHZNJ2Dn4Iq2HZR27B1OtG?=
 =?us-ascii?Q?ltfsQPHN3L5RrxzKovlU6dnNDbMCPu18C8/OPhxrlQUlH7ob0dC7OkjG875E?=
 =?us-ascii?Q?1t84rllaG7EXkV5iV2nMJtPseY04UxDSKHwx50j99Om8zqrHuNjtkdIgQwU4?=
 =?us-ascii?Q?93/5j26uQgQgdg6n9MkePH30ro0F4Fz7fqz8iURGeWGVbSWePjt4ckPuR7HY?=
 =?us-ascii?Q?MToJ5ZAmZopXZp/S4nXCBGB87QBZA6GzJ9ahsyD+zaagkqQMvX8LfyKF2ViP?=
 =?us-ascii?Q?aTIQqykdH4OEGFPQWw3ywIbnmDNaXTNeyaZW22QzQiFVWZ1q+ojIiK8M3vB1?=
 =?us-ascii?Q?aJ/0NW/Fzh64HqBfvVNSNF8IJExp1habQAjXA2BovgA6MVbQNw6n88Wmy6qS?=
 =?us-ascii?Q?KntiL67H1gofuu5p6lz05drHTvhxoVBJR6HCNgLH/+P8yXJNM5YHk+UFTm6f?=
 =?us-ascii?Q?aIKLnG8+wCOEDJ0vSoUVu/xs/hNJnztON3oOwwjOIs9aZEvv7X1TRxqiJpeH?=
 =?us-ascii?Q?NG0v2y/HvMMjcH14S3l9xvYbCgDK+HIPQDpQe9PSBQa9fUJpP+IOTvPrnWLQ?=
 =?us-ascii?Q?yntuKtw6/Z6XhkzYhvUz1VACWeldyALHIoq/pxDBDh/1IoHuIU274J81UFNB?=
 =?us-ascii?Q?ztCJdFSZn4HwAFdauF3DUEgHQWYgv/f5NSnpDEJiz+Zcj7w5/4QZe01gOi26?=
 =?us-ascii?Q?iNeIf/SrHyDSm3T/qxBDcbjCkDnHsGbmA4Q76/nmXlHMSW+MbKd13XN1wbNL?=
 =?us-ascii?Q?CrCNS++2WMIxqXJu77jXkkEv56cysAAeD+hGEqx3i1DCJ5uoLwGXSzLbLYuV?=
 =?us-ascii?Q?X4g/4bstdOx0j5u80y0YMULHebwOIKN7XFSCHmgaD6mD0LmqdHtPlKe+RGJC?=
 =?us-ascii?Q?gMIOLgabQTwmW+pREmbOHzcBlKVZGiGBGqg7IaBSg8rsxLadxbSmHNi6Uhln?=
 =?us-ascii?Q?jhzoLrJIsmBaXBIr+uDut40zz6CjO1tBnNTgTqq+Ci5+5/EmIB01O4353Y+M?=
 =?us-ascii?Q?Vj62PwGhjS5x7M2WxNcnLEnvxKLSMJBB0kRR8weFyweLAYTqYla5zYRYNbqm?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FD0eQKhhh6fM+7aZWbLfPs1L3Ux745W9d+3rZru3rFhgp0cwchLz5NM+Q9Por9oJDIkup8Wt0XIAkyH/abC/LAtsXBsC82N/s6NONPjo0bgPaQ5VJ2ume4VjwBJOtubz+TBdDoiGYYGjXjHbNPXjrClR7Hr4LTexqmTIlIane+wcvdeD/yEH5aklsDPWItDnlq8Zh/IDYWaLGgr0dfHPv077I1MD7TUT3d5+5VCQB16B5CyISHZWqlxpvJ09Wlwdg0TKcry4PBs0vNgx+Sx4X/7E/RlRYZt/GqnAkyMC2dL/FtnqB3KC/Vw6mIBtjZvxNheHMyo8Y21vdO+aLaxlywixElxEImPt/cPr47vpYU3nIs9vglT1g52aheF9n2C7Qcd1ZR8JCWuD2PzDZC4niF2AAJ8GKUAGNVgx+P03oBonrRZuvMlyfAnmoXO2d8rAqSgSxXCraBqI2qtl+mLd7WU+ia7bWxHAY++27sZT2yl9QoJb466oc4KYe9Oyok1pJH/mBcrYxiEeezvs8xg7GHOP4pfpRZ2i547pbFRIODnWKPb5nFuGKnIG/DQAbXFrj0x2WeUM1991rufF2D6Eh/plFDqI5/LL6vVvv1xtGz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba17243-89ac-4c7c-cfee-08dd7c171bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:45.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7eoVSuKY1WD80boDezeaf4TXpFRg1FcoEkA5v4LRZuiCjObWbLd754Kipb/N4BDt9xYUzQG60M0Fp0iTSo+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: 1F-NxBQhMg1LnaPCGMkukhdtoPmXoz2K
X-Proofpoint-ORIG-GUID: 1F-NxBQhMg1LnaPCGMkukhdtoPmXoz2K

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..653e42ccc0c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..cff643cd03fc 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomicwrite(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..d324044a2225 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


