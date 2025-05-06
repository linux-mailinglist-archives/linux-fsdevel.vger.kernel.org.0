Return-Path: <linux-fsdevel+bounces-48201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3DAABEAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF50B3B83AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BF27CB03;
	Tue,  6 May 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5mUZlNK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tITZi/Lr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED3267703;
	Tue,  6 May 2025 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522360; cv=fail; b=WAUoxVPJuKZgk7pqFO1/+3xumij7tA2bAkRWrGxtx8/QfyEloWe3gFgm5aRzkhsakBM47Ces77YHdPtZ4Vdq1Ad2N7Ev6Wo758Cw1Dly1tCNWFtQzzthzAUjRBC51mdRlh0zOHlKGi+EcdmJvxUVJFPAbvdbxel81B6J3aclxuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522360; c=relaxed/simple;
	bh=omQCzwIYOHb/v47TpyDUVzryefmC/a2FfO8c/Hl2iBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2QKTcFRMlUMtNxBLovPn0rQe7lAfMh6BdWI9WdQMERbhnpA7KlD7Pl+lzLIJqq6YJ+rXCW9gPHtqvbqOhHg20IzcYLFA6gYEIVpf6oRjsYJT20czf+zSfKKe53AePHZmpz2G/pRA7Y8gdZQF3oRoD/qpKA9lf4O2mA1hmm6Fok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l5mUZlNK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tITZi/Lr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468vf2M023352;
	Tue, 6 May 2025 09:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Sk/hsrFNgdFwYGGW453+H9tAgZuzI3Ul23Q+7k64nHM=; b=
	l5mUZlNKJwxM+BYPDEe3Ip2Pj1cvrZ9L/pnkRbuncYLP8NSnim82MRlgfqJ7jJyy
	C50FGHPPHvPE2fdpm1bs1iR4QLbFqYWjXVMcP7T0CFVPfZ8B9ovmH6ptyD4GeKsU
	2z6WyGRvWFEmiwgIPYCImAtBpDEWxeH/tzJp+qDKjIRCEiXaPYeh3vgbe9PrKy+m
	dOjO9kJkcHd6WcLz+PgJiJkF2ASG/Jt4IU0PXpkwdZAlq/7WpVbfm1Df1gVJOZ1c
	Cy7DhFNpXLn8y2dhXLdYnQwKWCZ4Kri4NTh/DrPBeLYhRYiY1/CWMpBiKsfkfmEI
	FE02byJiuyQpDfJxKQ57NQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffc680fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468C3Wo036063;
	Tue, 6 May 2025 09:05:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9g9rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI165eOJyWjflm7Bz40ox5DK7kV5FLBA9TtuogiKJuQv9qwf6vB4005G0INVLVrxtyZPhdMOIbSg0Wza5RpOSv0h+hvMHurYP1/OG77W13w9k1NyzL9J1o82FT4VmMUHIW5NcvlJOkeGfoOK54CIEDFzA7coOz193b2oT/iZeaZhQcfrXSOhnuXzmNz8aAZCn+fmP8ggAd9jPQnA1D7tVvzCBw8WV4JDHLsWlKGmXOfeUwfIonTmIptzeez5Tu15fE1JzBwpt9OaWU1oPgFeT7MS62+NpDlqiGcaRCmrswroubeuq/cqy7H36tGZjG0JjTeGAemtiBH7Mcs/Ji0Ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk/hsrFNgdFwYGGW453+H9tAgZuzI3Ul23Q+7k64nHM=;
 b=CMhsW5BGLpSyQSTOfomIJoYPikRxVqtssAhMuB7j1OFYf+oZYRqTJhY4DtdeP/7M8Zzb70hJdNktA91bOdSrDqixGtx1GNTvNP8rSw3Zz/98lxZ5se+4tcXaUdf+dWlGG2Ztvd/ZYiLejOx+ALWz4fBKHkPEp28mocCET/gDE66fkArcJofaJITWE6NDxrHVGNSLVj2fdFmRdD/dTLN03YtyEyuOoHjla2EelbWTOAEEYfE33JYXarU2+DPuft6EfEVxDu7aDnA+E6VxZNqZgH1WmLfUXgaWBb0DEb881GX8pS8NCkGhoGzPZtVoI5e3MxTxj6LDwfholMmscrEJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk/hsrFNgdFwYGGW453+H9tAgZuzI3Ul23Q+7k64nHM=;
 b=tITZi/LrMM0XNHRAMBjMoRTelhaQFllLvpPKebhfGoKxU3asTJr9ijzwF2Y5ANLkiOzsjuGJz5oXxcrRoaoyxtBY5GiKYEMTmmLqQvX9KUL8gtm5gIOOMb2AOr9S/d9wjgm9P8S+mZp4BRCcKC+uP/UrdKP/DcHbN5ZslU0MaRM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 17/17] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Tue,  6 May 2025 09:04:27 +0000
Message-Id: <20250506090427.2549456-18-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:a03:100::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 55919adb-fbff-4bdf-46d4-08dd8c7d2adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HM52fWXnhTtdCOnHtxxi9Nk/dzCYOy/YBUrwNmX6VpE2SW98Jh9cvuGjQfMZ?=
 =?us-ascii?Q?m8IONjx3pkiiA9wBTq2fwyd2/SYQq4pm2tx2qPopi5UysogTLfCFA0GJ8eSK?=
 =?us-ascii?Q?Cyfh0EtFJ6bvWL3TK5P2tlhW1BWLNt9S1pOfZWiYRg1HmWObGu79dyYenhky?=
 =?us-ascii?Q?6wEn/37lYTLE2ShDbDnYaiuq0fGy4pbF8RZczgRvYZ6NTd+vzZacYeh2eyl9?=
 =?us-ascii?Q?OQnUNndTumNvhXgYHQYQHOATi4mST/O8pUaIuo3PSoGyjf1ApYBJkFFPgc8L?=
 =?us-ascii?Q?eT8HmNeedgcultvp2CTN8xqY/5YHSLu5r/6EncQjNcYlUPk0gnGcUVcp8qQe?=
 =?us-ascii?Q?UlM15SgL6zCJrFK7i3tsoRf6r4W6YCQwEWNwt1L+R+eoCYN7Nw/MkcgmHQZg?=
 =?us-ascii?Q?2VxB5hky/CDH0coz+1R/P7FFl1NkzdrNnDO8VF5eGmF5h1EEINr2NgKyhlwf?=
 =?us-ascii?Q?bPUV8B2YyodW8ZrHe/IRDVjEhYvkfGyH+9WoAIHjqs9JVAJQm3gRtT42wsf2?=
 =?us-ascii?Q?kuWD7zjTUdzDkKibPWInX4Oq8XyFEN/T8CsrrqWiCL2ItTgkZCFp4pA+wbAb?=
 =?us-ascii?Q?48joaoX8nqnLz6dsTgKjvoiRAyAdIiZS+Gnd5v0SHtKFEDlTnconv2m0+L9j?=
 =?us-ascii?Q?3oTjM5Yw5woCRKE5slufDYPdHudBKN3kZURfo9m/7klfgmO0U5z2hXxtvIxP?=
 =?us-ascii?Q?qUFAP41zFtv39Z9eBNMkQmEaoAsNSa4gdTJYEerviIci/ua6NnFSv8FSK6mK?=
 =?us-ascii?Q?VVk8G1oVHPSnfGOHXaC8Csf9i9W9T0jVnc/wO9+03QUH36WcGZF2NbZ46ZZJ?=
 =?us-ascii?Q?ZJAoq22bPXiQAhvsvPMft2T5u++HCREqfV3H+Vi7s3Cuw3G+vXUVCtG+gFtS?=
 =?us-ascii?Q?9+Xcpp7clk5XJsnoWFuPC7PMjSKiehzwfKL+rEtfSpSWRelwrG+cq915+m+F?=
 =?us-ascii?Q?HNcK596vSZ/n5wWnVMQbG4yBlhdmpYE3B3H9N85Tgsyme23Zb9I16BgrND3n?=
 =?us-ascii?Q?Y9ZpX1TTCSDCIbw4XZWLxqZQgSDA9pIaZQFYl0yRuDtfomi/2jQ6S68H2DH7?=
 =?us-ascii?Q?NbPzyN2WTRLuwXbf50X7m5XCTOv8ccKL8VA5gHdu8iIbyweycVrtPk4JOhTF?=
 =?us-ascii?Q?KbhgPid7DIA99sBJCaFn2aSIf06x5NvVUunNxyv/+75Dwbkghmkdwh6yYK40?=
 =?us-ascii?Q?B+/Rtk0E1jEKaazaQj9yvq+6bzJmFxr2LWszpvmiC32S8fxLz1Ccyz6a8Irm?=
 =?us-ascii?Q?Y0ARUD6yJAKe27ibInL6nqGiwoK/8VOR+j1I/vPMhtTzRFAsqGmRhptlQ7aT?=
 =?us-ascii?Q?kEiFyBYx6LIBUNJKPHRb+4sRzEG64c5bCKXKh5GQ/n5dhy9Bbm8XaF+BVngo?=
 =?us-ascii?Q?5R8/GS6+V680K0nske3je5DZF4cwBMnBnBCZR2fD5cMsTf7H7XVDTsLul6m3?=
 =?us-ascii?Q?96o8vVQiHV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4JJPOPN3wSbTKaYPNA6kOVrERQk4FeFt+8OwPTY3swOKaDEPexE6ELNXM0y?=
 =?us-ascii?Q?X6i+cr/c5RDwNPjcRCUahZ4Te6DQoai01phJqlxicAHvgqeVQK75n85zqsf3?=
 =?us-ascii?Q?gjmCfotzBxg7ekyvATZtERMKiXIHL1n1SXLp6z+PWalEdXYR8CwHqwRubV0v?=
 =?us-ascii?Q?2FLIPaRHtSF7QEM1jGQNjv2lwexj4YQH1H1yfKbztj9Caj0N59gNd9v+Jgp9?=
 =?us-ascii?Q?5cVbdaf8U+P2TDoEVwJM/Wln+z5R9ulD9Bek3kDpOW0m11Y2NTywCAyKNB+6?=
 =?us-ascii?Q?AxZ+rDKmz0Rvquxs7S/2VzP/emqV2Qx3xZUBT5ziyv3InUPAx0j/ZG6pXe5/?=
 =?us-ascii?Q?MU9Ssk/75k59ToiSM1MFN2Wml9bWzeMrEMCLNRnF7O0vqzfJZKDAYHJzpdo7?=
 =?us-ascii?Q?HwYgrMWU/hgS4vkmBsfNbbbhT5J4zAF64iKYV7UlNseJZ/cWibLIEP0jyL78?=
 =?us-ascii?Q?RLAZfJHpc4K0a85Tm70DdKIR/g53wAEEkDLYXqYniDdOx6T1qZfUdYJRPuCK?=
 =?us-ascii?Q?RHRc7CO/r6L34KO4NAnWNUCQjTlKuT8h/0Pt/4frMpk8BToEr06hyiHLO+kZ?=
 =?us-ascii?Q?FR3qV4e23+NnQsz0jczrRFeh/UK6rNO5hOGyOLw4HOn6FjoVYDpbTGdIh/ZP?=
 =?us-ascii?Q?qy8AubjfomCgSWVJhOdy8Ay8bjvgmtPQThuh89pcc73ZcJ9y049mqt01Q64Z?=
 =?us-ascii?Q?ZnxUnk07joWPOiiSRj304wdxJMQASQTOhAd0T8ixvzDVwCsVsX1KQV4haLPE?=
 =?us-ascii?Q?VjwimUU7QqkK6TLhhog3ckGSdvEfftf6rKqxgJImS3iKhp3dg47CarxVilyH?=
 =?us-ascii?Q?xUM0m7hL6ybdtZ0M6iw1gXxS8DfPPllv/4OLMVD8hee03t2inJ+p2Rsie1bq?=
 =?us-ascii?Q?yPzh6QOwx+T9yI6WUq9KPyQKOW4R/zLA/vYdjR2LghJVFORpih8sZqL2AajT?=
 =?us-ascii?Q?6eckw2UU+Hgxum3q+YbgCTifB5HHuvyaotsP4Ej3m6wmJaksDxCyMnt+9jO6?=
 =?us-ascii?Q?sTiIRSeKvAirhSdUarnuSVE6ed6DMzF6SWpjk0Je7+ZJFG6NP2WXFQCGkBhV?=
 =?us-ascii?Q?KOvyIw8gVOWPXfsflh8ptVruV0BlwDvENXLKtRgJHJkJaEvrqThaafmNTl3B?=
 =?us-ascii?Q?GUeSPI869xzuJJhreRolu/Kms0QK/3aMHl7CNuusRVcZ+0cIY7fwagxk1PJ7?=
 =?us-ascii?Q?xrSTpjiH8KKfN3luqZjOANDSGKyDBxA2MutbRCv5CGcK8142TRbkK3WNwbko?=
 =?us-ascii?Q?wQDs8ALO28qemv+XyJd9X96KzusTWZB3/yR5QejdP5fsnvV4WpLuUSfTFLA7?=
 =?us-ascii?Q?EPDiSX2hLhhDOzcUNJDpf3Gdx4Qh20XJblKJpggYGQudufrzvJ2KfhKqKv1t?=
 =?us-ascii?Q?WIvdXkUEBg++U3wrfMbx0GdADkiZyxcvNgcX1F0zy83c7UaM3XsYTG2vwayp?=
 =?us-ascii?Q?+/IF/P2h5d6LdtpZCUjrQ6oPtJ/CFWkjlhxpGX0TiP/H/jVmEMKOwmfaQoOQ?=
 =?us-ascii?Q?yC2Au5Bp+zTiqt5gocMxe5tAzJ4b/44AH7/i84aCIcYzi0yyYs7HY2TTuLCC?=
 =?us-ascii?Q?9j5hborH4CRAspJ2PzcBUKrDsUYQ1mcxd8Ktte7YSOCEg26Q0D0A1W+BgFXu?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBcp0+YddAM6PEayqQ19B9vjQhroZQZlw6P8Ha2DRU/ezdNMGbPzzJiLTRTEIIQ2n1UG5bOLooa2abnFgKrejfLIWQFlKCdGVJNWhgZ4Dsq9xldip/NnC8GgPe+ScjTf8jvGT3XT+WDaXIalcY1+318AbCDsLCiCXeGfvgSAUUrk6GVlJd3EjeImvMSq4BROrLUW6YJXGK05godK2YPYk6Vki9O6W73hQ0vJJiLKG+DECbhidD0FIvV3iyE1Bshfp88riotDd4U0TM6ZjOItIOXlXrN83t7AOoKYe5G7hO3gLNtme7rnzNP8Ojq/x1tysSOz/ibBTs2uuM57HdtfvkDRrdnH3WPht3qxyw5Z0i3Dh5mkSYZG/LC1X/Opnc1O/aYHhHVo6BWHwu9p6T3JOgiJ12bf0Uwwx9Oban7l0Yy8NVPoxg9832g6AxXKAyokc0Xx6yvn/k9FpXcnXucuGsRiEcedoK/x7uxzjzJ1WHT6Jh0oB0xG0/ax/G47sM5+4H3nxD3UXXV7zvcfqCCadK3DAwg1EpxJ/YNnh19COklz3jK5HcxJXQEX5z4P1hYo84CihcFwXbXkqFq+ra3uhTng1X2jhyCI/Y8nsubhxS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55919adb-fbff-4bdf-46d4-08dd8c7d2adb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:37.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpR32EXgvysqEBvC3YqsoWSlPFW+WALTGLwZ2wm7jeNvTf4OdtdHEW8njzwnC+l9clCWH6uofiOh9wAcCs8AZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-ORIG-GUID: Op8xvHtgk4UR703jlMGCYkL7QRrn4_-N
X-Authority-Analysis: v=2.4 cv=Q6jS452a c=1 sm=1 tr=0 ts=6819d0e9 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vofBRnjZkZwxpctGmH8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX6epp1t5eovr0 ZSGO06G80GhAzmza64Tbe/V8BLft7nVPjYelhgNtPPeHPymy8E+9xxETMXDvv/4Y6BJ/Qu+oM+x lRdl3at5zcN1fKcLLBwIsnXzMS3EdZH7zd5tkCfxdzBQUSKjHtP8IsacUSyHElckv1KU9Pz93Zi
 893jihM0re2+2sKmYMt+pusDPeEhkwBJANPijKOBFlI0jGRtkGW4boMopEWwBifGnF4RpDKpS4E fy8U3/jU93FKlLVg/F8fwUbheyjAiKA06bGg4iA2y102ZzQu9o4WOV6J/0+msLH3UmNrq0CCbHI cdC6WcK8bO71dm+OxomLl5EMmfYQKU7qH7lNST+IFq9WLFQeYtPx3wpA/k/D8cypniXFtRm2+d3
 W+GjUmXhDfOhf6tk7VJL0u4xWqTeP8zHm8g6PwrK0JFJI3a66kVf1R/ks6TcBtJsgF7cKEi2
X-Proofpoint-GUID: Op8xvHtgk4UR703jlMGCYkL7QRrn4_-N

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.  Note also
that xfs_calc_atomic_write_log_geometry is non-static because mkfs will
need that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst | 11 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 69 ++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  4 ++
 fs/xfs/xfs_mount.c                | 80 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h                |  6 +++
 fs/xfs/xfs_super.c                | 58 +++++++++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++
 7 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index 5becb441c3cb..a18328a5fb93 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -151,6 +151,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   max_open_zones=value
 	Specify the max number of zones to keep open for writing on a
 	zoned rt device. Many open zones aids file data separation
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index e73c09fbd24c..86a111d0f2fc 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1488,3 +1488,72 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log blocks and transaction reservation needed to complete an
+ * atomic write of a given number of blocks.  Worst case, each block requires
+ * separate handling.  A return value of 0 means something went wrong.
+ */
+xfs_extlen_t
+xfs_calc_atomic_write_log_geometry(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount,
+	unsigned int		*new_logres)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	uint			old_logres = curr_res->tr_logres;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	xfs_extlen_t		min_logblocks;
+
+	ASSERT(blockcount > 0);
+
+	xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	/* Check for overflows */
+	if (check_mul_overflow(blockcount, per_intent, &logres) ||
+	    check_add_overflow(logres, step_size, &logres))
+		return 0;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+	curr_res->tr_logres = old_logres;
+
+	trace_xfs_calc_max_atomic_write_log_geometry(mp, per_intent, step_size,
+			blockcount, min_logblocks, logres);
+
+	*new_logres = logres;
+	return min_logblocks;
+}
+
+/*
+ * Compute the transaction reservation needed to complete an out of place
+ * atomic write of a given number of blocks.
+ */
+int
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	unsigned int		new_logres;
+	xfs_extlen_t		min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * use the defaults.
+	 */
+	if (blockcount == 0) {
+		xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+		return 0;
+	}
+
+	min_logblocks = xfs_calc_atomic_write_log_geometry(mp, blockcount,
+			&new_logres);
+	if (!min_logblocks || min_logblocks > mp->m_sb.sb_logblocks)
+		return -EINVAL;
+
+	M_RES(mp)->tr_atomic_ioend.tr_logres = new_logres;
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..336279e0fc61 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,9 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+xfs_extlen_t xfs_calc_atomic_write_log_geometry(struct xfs_mount *mp,
+		xfs_extlen_t blockcount, unsigned int *new_logres);
+int xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 86089e27b8e7..29276fe60df9 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -742,6 +742,82 @@ xfs_calc_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	const xfs_filblks_t	new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_group =
+		max(mp->m_groups[XG_TYPE_AG].blocks,
+		    mp->m_groups[XG_TYPE_RTG].blocks);
+	const xfs_extlen_t	max_group_write =
+		max(xfs_calc_perag_awu_max(mp), xfs_calc_rtgroup_awu_max(mp));
+	int			error;
+
+	if (new_max_bytes == 0)
+		goto set_limit;
+
+	ASSERT(max_write <= U32_MAX);
+
+	/* generic_atomic_write_valid enforces power of two length */
+	if (!is_power_of_2(new_max_bytes)) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes is not a power of 2",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_bytes & mp->m_blockmask) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_write) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max allocation group write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group_write) >> 10);
+		return -EINVAL;
+	}
+
+set_limit:
+	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
+	if (error) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return error;
+	}
+
+	xfs_calc_atomic_write_unit_max(mp);
+	mp->m_awu_max_bytes = new_max_bytes;
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1163,7 +1239,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_calc_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2abf31438e0..5b5df70570c0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -237,6 +237,9 @@ typedef struct xfs_mount {
 	unsigned int		m_max_open_zones;
 	unsigned int		m_zonegc_low_space;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -804,4 +807,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 77a3c003fc4f..8e3ae1749855 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1343,6 +1347,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1527,6 +1567,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2137,6 +2185,14 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d5ae00f8e04c..01d284a1c759 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_log_geometry,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


