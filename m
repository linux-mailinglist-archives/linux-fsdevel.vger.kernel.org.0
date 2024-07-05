Return-Path: <linux-fsdevel+bounces-23225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55127928C53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7C283423
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660916D309;
	Fri,  5 Jul 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZemfifL0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NbxzMkt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86D225A2;
	Fri,  5 Jul 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196859; cv=fail; b=s0elGYdU6kbnCMLfAKea82R1xnOenKbBVouGU4uesPISjOW9NvsG/H+u4fClQC36bt4vx12tWspWYddMi8pk2Wu3HGwdfBOpiaKvIXr2UtoSp+mcLKQtIzp19b03rJnVrPiw1x2pipCnRr6YjytaO3FKmrkqO+r8VMLrliRcAQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196859; c=relaxed/simple;
	bh=dSJQH6zfU5QX1ZaM/4cYamfXiff6T7JST4rjdWxkhQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cmdv6yBlfOTZOdCn9A8fIg1iXdO9gzADmWOeTWB3H8EbZ++o4qTVsThMGWKIxyGIENtnyI/TxEcU8g9Pvxl/8yeZAz/Tp17fgicsfKpCFZe2IX/piKCi9ysjuDmhQpQOUVnGU1HXSuERz6Fz4E21QEky/3UcjwkgP6XRhbUAtdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZemfifL0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NbxzMkt2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GNSkL001566;
	Fri, 5 Jul 2024 16:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vlAYBQJBsgxS6fQgFAGJAsbVGHASzWHqWCB2/1SxHag=; b=
	ZemfifL0b0OdwV6Tva9x7LjfOL6QNlMA9P1ON8FuwnSHEVoWRbbPuQL9lVjoaiPb
	QrpbkWM8cqEiMNmVPZBceCCYGVxkQx3AV/wideCu/wetdt7ezf+QaGIxMBxsFLd6
	vpkbkaqwo0FPLYZU8iymHn9iVR+0f4zCGWOpPBvCqb5jNLKxVRE2AeeGD5FiHMRV
	SZBWlWi+jr93trZGuFT7mNa99DGvpaOmRFm2mlgCQIEiEeTeMqBPrnKOxCuE7JpO
	2jAl5b5kqm62BXB6QnHlmu3tDtJofLHWU5jHvbIxZKqC0Xe9itTogbLalQs2yv7O
	I7ZijXZCArGyj3wHdy2WMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmbcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Fs18u021462;
	Fri, 5 Jul 2024 16:25:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhm3mc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeFMKDjYg604qgGQ+Vwuw1IAesqoGNEL7RpG6dyJQozm1ih6njTEP40XSTNy4q6yic99jrmcmriQwRgM6Z8eenFdK+0P6SVte02OsoJJCL2TZ0Ps0I+gnlGswDG1XRpSFujo5onbNPiPUqZ9AFxggRXAXpj8fsSinw5jGhPJdThbpr/S9lH5E0UCpuJu91vQKVyVL9iKr7cziCEJEr9+t3RDOGyxE2FivsRVHuqtV5zzzqoBTr4wxr9ozVPkpNSyN0eSdjIr8h5SVHCHRmBLYkXXg5+JcAxZZcHD54e/n3kTj9EINc+XyLBoH/1z0DyMqLML9tHPN0ClCTw6th45sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlAYBQJBsgxS6fQgFAGJAsbVGHASzWHqWCB2/1SxHag=;
 b=d6SwcIumYjVeSrmXx+DAZQQ3mExRSMVpmrb6lY2ViiDHid/t4zKgTHD2WXEo+SRFNpJP7cNTH0SQ5U/TfRH6kRRCAgiKeIeUnLoDdOcy+56m35LGjAWk7qFrcyTi1/dhWKup5r9yPirgvHOeyZAG9AtJViqQgOo2Ha8NQi9w+Pb1Gf9mV+24AKW8JGvowjDqrCy5rD3kU1mgGSQokRf+arYLRVJwIfdojEk9uaLDXL0WyeuEGQrKsTixiywuX839jLzbCfNcR3v6G9pFq8VoGZ0k8vSh3TYE0z/88plWBYxNITHQdIPSygIwUbOQPGFcP4+6NP4LCRId/PbbV5Ad9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlAYBQJBsgxS6fQgFAGJAsbVGHASzWHqWCB2/1SxHag=;
 b=NbxzMkt2bDX9DahwEo+t6m7UfoYtNZ9x96YM9PNH0thxmqULM7K3Ny7avyD8EepXkmBDWaydGWohY/LbEcSzOpWBOw5ecv0FigrHCkAMZc+RBFFuKGpTl2TcoxBfLJDAltwqrE472YcwKxQAaQUau1qtwui7+z4lgiVgmaXkoAc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/13] xfs: Update xfs_inode_alloc_unitsize() for forcealign
Date: Fri,  5 Jul 2024 16:24:46 +0000
Message-Id: <20240705162450.3481169-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3b1d88-05e9-4506-60f9-08dc9d0f1076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R7ARFIlK8WJqcN6aS4E+95CFdnIYJsUUpwT1IrIOf1OkKM23ePtIQ/SIGlM4?=
 =?us-ascii?Q?jx/pksa5OMP4UnW9WIrTjYkv24pIaviPJAYsFUKQ1FUpkaMRuUEY7Z4LBKUJ?=
 =?us-ascii?Q?+yxsODUS7pRJT/WzP0/ILKy1R9PsxUlCJFOLxwysK1fm4C2UeluVO2cXaLFZ?=
 =?us-ascii?Q?q7udhGE/y3hxPFxEFEWb39VRGmutcrBsLLjX8nG3dMsHjxTxTXDp7f4bjFvc?=
 =?us-ascii?Q?OfWngtF35aVW4f8kpDPwpYPPv4v1DhsegcG0CdD33vtIJnLloQUNxKOtxWat?=
 =?us-ascii?Q?QlcLcudW7o1R2pt9e4nIqaXicG+XMADDlnkORslX4vW1UQ4/bTkVllbWlRAO?=
 =?us-ascii?Q?0/qPTflpLf+o3a7kM3bWa+Z/3SnEQ4zZNzp57GRm1UFtCDH7FCPlbTOXSsok?=
 =?us-ascii?Q?WpLP5euPZNdD0o7oWRAEHEzg37PQ6hln4UpfeIVsmyBuv1bVEnsQFQXGX4qN?=
 =?us-ascii?Q?lfTo4BDYpQNdpgGDI1OL0qU68W2wWwg8zG5ZDwVSBwLeeP9jBZBDxLtJkUrV?=
 =?us-ascii?Q?DvW4uyGqP3JTJze05o+pqDGXypmSu4SqJ7/Q5/JMijEMYAcqp8vBLNjoBKVa?=
 =?us-ascii?Q?gvGZp5aq1Oz6kW6dRQaFfKFWd998SI8VkRwwYhJkPYnUrA8zxOx6jwPuM7KE?=
 =?us-ascii?Q?IxDBn6y/QjP/7jRD5VJ+aDAr+cfRKJvdMyEIK4Cqx3a/lqxuXDVFM32nyw8Z?=
 =?us-ascii?Q?K+JzMuUIXsc+KHm/OhvW1+0NDHIiQJpn57EWP+lXgsIayPQwqhTCX5dX+dj1?=
 =?us-ascii?Q?SapdovR9T77gUYB+NtdtzNEIWsoPp+vkK396UkPBhH+KPZCq8+8Dny6JEQ+T?=
 =?us-ascii?Q?77RYnjaJqol8HZ4RuQUyIARZHLU84zgeTKo8IfcwVXvjMitBBsX+nDKqxK8I?=
 =?us-ascii?Q?meEQzD5IY+8di0a+D2iDHNYB+RoTvNtsd4ZPJehF0d7d+1G/7RtDWEql522i?=
 =?us-ascii?Q?/IGI5mp2uOL+9Nzq77z9tsP/vlZbBFNCt1JX0mwW/PKik4eFVYVS6Onqj1LO?=
 =?us-ascii?Q?ZJQZ38Xonak2mgamFX3+yMakdwQkdDPiyCHDiA8bFswDyhmPSMxMes487Her?=
 =?us-ascii?Q?sK9G0H8oIBtHlgF80adBsTNGOMXVz1jJ9bNodE8F6GUmcjGCovtBPn6HF2gL?=
 =?us-ascii?Q?bsD+1iJe94MLZTdBKepiOi+26lvOn1tQxCfBICL7anNx7nc6U98c3Oaq1EZz?=
 =?us-ascii?Q?mY2+ceCK+6cWgHIBYGWRn4ji7qjwAO8kf72XvGZGd0tvm4PXE6SN+zZkxGxn?=
 =?us-ascii?Q?gP3n9xZnhlhHM3Pp2AkmatN5a503eJQVyTwvBk4RrmY/g+PaTLsL4HgR0A/a?=
 =?us-ascii?Q?TqYQCl9qZZcrFQLFaPO5KNeh6ZuKAspwgvVVCqyrNEJqag=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zsdQUxMVLrj4aKXKAhLntKeomdP6M5Cywrgnq2hLfxmR1pPwhgGnBtDAd65c?=
 =?us-ascii?Q?b54r6t9JpHNbNgKekPKsbj53pAmOt9gnI7PGnMFp6q0PL2iS51ZUxYlha/FK?=
 =?us-ascii?Q?zVv9X986GGSDCKoQZVGzmsLCHZXSCHvJPEbWfvSoO2ZJerWx6ieL1lA12gAi?=
 =?us-ascii?Q?ppnJafxlHfEDm1jTBRAanK7sLJLTx3lxEUgG1FgT2CMVc+p1s6cUfY4nKMbU?=
 =?us-ascii?Q?CBl+2uKSrXxSHqU7Q1G+h4Kbs6YTBYaR82qGNSz/eCpCN1eO1EXR6UduK8U6?=
 =?us-ascii?Q?tz8qnq/K0PyktGhsmrSTa8b8VNyIUA8uamHHA7zzsh11+vvEKjFcEgTPz8YW?=
 =?us-ascii?Q?k+FDHdUG4Wl+1k8qTT+OXspxFVLqc0qdizIv8KYdzbBKOkOZfz1XkPOwREno?=
 =?us-ascii?Q?hKK6Ao/fD4iGmzp8u09t7fI2Ed6CTDttA2lizhusDsv2NDbqR+3lB6eyhU0l?=
 =?us-ascii?Q?olJfj9kToxqtG3TM8+80qzAa765NqE1dC83csQEt0up0GMsLmhFuqd1WBGgw?=
 =?us-ascii?Q?EC9m75/YzlWlZj+mMLtsgx1LWdCn/sZUnvO52QGvUjtEn4rEnL4MH/kkA59g?=
 =?us-ascii?Q?0/EUMO5DF+qiqItBwgON/CHd7hQplZNlrMXcFZBFzzfQ/I9BnkpCwuJhAZ4K?=
 =?us-ascii?Q?JxjNtICEhI2swmHVkxOPugYQYVlhZb72COessg8nuQoQiwELEb+3Dlf3Hr3z?=
 =?us-ascii?Q?xqE4zL4baGqLWfMPBGfx6K2KhqpF+EV4dLhbwlTCol0fcDc61goBcjyaolL3?=
 =?us-ascii?Q?R2xo+htLJCi0UiJStZhIsAkncUxFsIkbtvElottUuA5dvTXF1EQWw8Fg+Zd/?=
 =?us-ascii?Q?+Id0m59/YJ66hnPyILZdIy+t5uZXlMbHxouSLF1ooy8ttiowXdh96H/V9ZLF?=
 =?us-ascii?Q?JlFs20QH/AEjd1MD82fP9cWkjL6Fny5sCWkHuTIIQAl4un9muaQQZqFX6nk/?=
 =?us-ascii?Q?Z/eT+Gd4nd2p+cJgtsOw6W3SGbyqx6OdQAOzL1GyP8IxnY9We2IVMKKPRH5m?=
 =?us-ascii?Q?miLj3zIsuI21FgTmz7qMb39uZGKrLqlI4DwHlMBUIikoFpdFwyvtNqlfB740?=
 =?us-ascii?Q?47tBMaoOZoWstNeD9gvPDa765Z5Dn2DdAZFss5waUewxQO2SLziX59Qs13y+?=
 =?us-ascii?Q?6ipPqSC+rMTPyHkCBE4epEOw/9wzOlZS2XIuJdjF8RwDg91k3iYUdfPtIBUy?=
 =?us-ascii?Q?sDbLKsKnp+k5lpHNY8+juuXJTJ735nSbS+nuztf8f3jjAF/cngg0q00vob4o?=
 =?us-ascii?Q?uahWaHb1R6dRleLjrWK47OyjTbW+Fsv8HRcpRK0BGYq6xorZjSDjkbIRZY6h?=
 =?us-ascii?Q?k5QOaPUtVr4BTlLEp+LDhUbcOG915uePLspIAI2j6OrmK66tBx//7DArpDLq?=
 =?us-ascii?Q?w+Cu9sZHCegnPIqRLI1WrVSSJa6CofmLtBhEvszFBSRo8lCycW5U2cNu0uv4?=
 =?us-ascii?Q?mDMTrtreo2+USqYiZos6R7pffgdFyJcdSQ9hawlbfsGIWx8RzZbHjFVHzi7H?=
 =?us-ascii?Q?NudFEJ9dhd1dQU69wOKNJ9IWBiQ9A/hfWyC1JAMwJS2So0EyET5Pj4yd8j5C?=
 =?us-ascii?Q?2h55q0ckVKuqEBckqaWiYSFXh3ON5okYfxB9bDkj0xwHw4ef9ZNblA6/+CKP?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Tv/1r8QPCRf0uGZWVrSYaoh+f6idKB+nC6eYj0J9trbUoY+OzZauKQxSkL03nofMue2dM03SY2/kDrHxwneadV6FuTNlnDqwZ4GW0Q4DYfLujz4f7RNTaQHY4Onq3We1o5qjKuyhrEK9QS28BOG9QQYDSVAAoP4bU5dznozECb8EAqo3KuIoy+CMioPvxKJjwoWbDMlttTWfOb1WGO3v05OpGObJ4mmeBREtJphjwOfwdYttaEbKUQlHZ49UBQMv/cVYjo0Ta01r7bRkQAHOVzG57IjOpLdDIW9RjluMw/CEIgkms1hW8Gr8cJ/10+3he5OPllb6IQcWSklXtXRJYbJOdlYpZ7RjNct5LADe0tNNwr1lR7EsjsypPxkZN0XqLUZ1uhBDtBPvGQQpU4z4xhSQEyldNXbaunIMugyzl4fPw0nhwzfc5XxPH5dCJAFIaBYLKGsmXfWHD+ZozVRq8a6OeJw0qVgYxypFf0gQ0ETdh0P1vyHGbqo1sV2VYeKAX07PYY1e1iufWJhZ7HQe/Is05rucKQYV8eZVlkCIj/PcKPzF1umRA2tROxEvycC9GO5FJ90RE0ZznDk/gnVzFL54Z8R2Lpkg2A0l6Xixthk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b1d88-05e9-4506-60f9-08dc9d0f1076
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:20.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2tSy9+f96rPYZUsNQR8daqvphXjeiJHBzwFQm1JnHCY8Xw8kJQ+i8yuP6eSaaSyWY9YgMrtMUSc/NtsSbkrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050119
X-Proofpoint-GUID: tgKXK_JtonLkeTTVe9WHC3BXbxGYNvuc
X-Proofpoint-ORIG-GUID: tgKXK_JtonLkeTTVe9WHC3BXbxGYNvuc

For forcealign enabled, the allocation unit size is in ip->i_extsize, and
this must never be zero.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index caffd4c75179..bf9e84243f23 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4301,7 +4301,9 @@ xfs_inode_alloc_unitsize(
 {
 	unsigned int		blocks = 1;
 
-	if (XFS_IS_REALTIME_INODE(ip))
+	if (xfs_inode_has_forcealign(ip))
+		blocks = ip->i_extsize;
+	else if (XFS_IS_REALTIME_INODE(ip))
 		blocks = ip->i_mount->m_sb.sb_rextsize;
 
 	return XFS_FSB_TO_B(ip->i_mount, blocks);
-- 
2.31.1


