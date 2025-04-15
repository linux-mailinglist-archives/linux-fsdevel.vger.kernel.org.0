Return-Path: <linux-fsdevel+bounces-46469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F0A89D6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF181636AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C76297A61;
	Tue, 15 Apr 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j/h4EvVI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TghJFtc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D5294A1D;
	Tue, 15 Apr 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719302; cv=fail; b=XvkIxoLG9kX6b+m7nJIdpAP9hXtE9bgN9oJpJBjXFbB9H6bijJLeU1UmBhHpRLjyvR1AukEpHJSEw7PSUV+cYQGXvE6Fmw7kfjgt2eGBpNRaBdbthwP3SZQKRQVnsq6YIPEZYkRcDLrB5nX5ExGEp1+qPcOk3u9LYMqndE1OrY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719302; c=relaxed/simple;
	bh=/Gc9YxwkEPXlQwpTWBqIaTS+N0I2IhLUfDnljXWFgSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsY5TYhk3xiC9DaiMy/VV8x3hwfrOM8qR6F/3vRUmdnfVRu19/JyVfswbgUrBdpAOtNFBb2JkmE2zo4eFpMjt3kdXXihMkBmnQdz0JPC08JYFQIcT/VCc9IwNwaQsDiVvLk+n8hx5xWvoFYakUfu7gtPr4+Y+U8eJc6jwy819NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j/h4EvVI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TghJFtc0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fpK8021579;
	Tue, 15 Apr 2025 12:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=; b=
	j/h4EvVI5C1OCk88pp79qtZGi+4URPZKhKL5BDZATQ5sytjx14CsPycYCfJDNfLN
	68kyMLjH+8k8MwRMxu10Rrx1fsDlbLaSd0Bty+ELyqiH+npL+zy1e73/jVA+bQED
	smoIlMX1Guzl8XBYz2Rc66zV7m57lXq0xOQOXcPzt/VS9eFixhHr0tLjDSHNVRM8
	hiuZfob9KCHlL8a5iYemSnYqB20UOJeA4ZYQkWhE1yoj43bWzHrdfQF8YzSfoYkE
	DwYc+nDlRqgfHh0NvjB2p6Q35YK7zj1yfkaNVT40r7f9+5ACJiVWK6PxHo7tsmcW
	Uc0WhlMjwIxjoYhiiscJFg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd1ds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBb4CV031005;
	Tue, 15 Apr 2025 12:14:45 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbaewrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCOXt5DFsv/H46QX9sjGNRd1cHZzWW+eiN8yIJ/7j/UL05nf0tiS14jd/UNDfKArWOTVfPyX6+CcQkQHAU15aSvO3s9hbTDXRew3Kb7oKW+bkBW43HM6KFds276ZdH1+LNccNyEMj85RaeL2S2nPRBlMkilLbClrU1N1EE7E7CWwoiQU8yrcqOnhLjuLB691fQbMxflm7f5RqySJsjvzyj7TgYbQHr/WvqGA9oiKte28F3/VWJVsUt0Eh2MaxJjcfE3TFxHVPpO7OCbA/DMqElUiDHd0ygNQ69hKd+/ASPbb7SRXBF7zCntVyEdG4vIU+nUzpVyHRpzWqfPT53/daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=HHbcD/jmyfsvejXrv8f2Pg4YXoHnlvt0DhA/RXshbT8Z8CczDvSPaazUzkZy4sk+th9F93VX1biq0sUBLZpgFSHUaUc2TMbl8YMGS5q2DdqcAIfGDkC6PXCSekvDY9QmFrINu8fI05ymPCsHBkMtoxd/GUJB6nDmGa80QyTdX7clB1DWnzU2ibK7JQuXpDscVEvYpapOnV0aesLb8FIT6EYhqHuM/FNcQSnyeeNPwJq7OvKQ+yTxEMtDXq979NTvMUFWDB8l6xqNkDG5vo4DN6TLutsPG0o2o5LA7ABvBwv2vmtQdSmOURnflxHz5ZF2FRO2KvnBL9XTXloZ71Ib4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DLzKEzxZWroZS79L7ym5z5u37TJWbokIXzfpxvotNA=;
 b=TghJFtc0iIr/PUOJ4l3yP0LEMtoCOnVguXeDafftwoCqdllwEwZw4weEQtOgvz2vsQUPvdqyV1ENzubeekEXvIzisG/Y7yX/dzN/9aiMNyFimd5F/lOcb3B3OVo+j7xDAQLo5muIGkW4iW/Hg5vRJmkS+MGAAYCpPXul+Vnwvzs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 02/14] xfs: add helpers to compute log item overhead
Date: Tue, 15 Apr 2025 12:14:13 +0000
Message-Id: <20250415121425.4146847-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcdbbd5-d1c6-45cf-db98-08dd7c171a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEa3gi4oQQ1+vOhEpn883EQGI/OfQaAKnqAhhFv/SUKKFz9iOEUGviD/MN2d?=
 =?us-ascii?Q?THit7lEd8lXHTJY+GxcxLU3CTgcX+7eW6Bq0he7RuLHdLPtUp/Gj8eyfHI9c?=
 =?us-ascii?Q?wT5NNNQO45/i8w0qlDOXib2RS71QYJqoySAfi0Kw9rWeR3e5nAkpwGelxLRm?=
 =?us-ascii?Q?b+ENBuf5CnaUjfCbz0csxRVo0tTusFQ5QCP+TIlKbBX/roc1e73KigYgyP+U?=
 =?us-ascii?Q?4/uZG25mSczIvMOyZIWnCLCISa6WVpJbXmuQWDBZ2PbXL5wsKZvfhlUQ1sj5?=
 =?us-ascii?Q?xsLwdA7LGdYC767HGGaPh1T6LGuoHY114v/EO5OuMU8o9Qld3u8bQOlRGDxK?=
 =?us-ascii?Q?en1X1zdwmFblXMZ8SV/w/UXqk40SC3oUm/YDFUbxpWsuDIMCNzgs4AJS3Hss?=
 =?us-ascii?Q?bGDh9/ymK0Tdii+taNsuzpD0tCr+LKPyR4Ptjbgk054CIDVOxVThfQtaZnFV?=
 =?us-ascii?Q?GmzC6gZlGm3NOz/GAOYH1pkN7bsAOZZsUu9tgN85o1ygGG6kC6aDlk7/A/4p?=
 =?us-ascii?Q?yD06EQM8i/SzMUl807L23V4jEhMJFU4pwMbGFCME4CXm1xRgx1TaxHLMdO0W?=
 =?us-ascii?Q?NBdGKWOVRCWC1+EWGvXldUA+uOMz0CE1aIo35mNjPZGqbOqTXK+Ex30vLbx+?=
 =?us-ascii?Q?spgEVGwIQaTE86p62di5YHNlQAUyOW3EybvVgaJfqpXIJz8KQm7VN2tMF7+5?=
 =?us-ascii?Q?/X2/kT9DVrKHO1uGnFXT3HvLFYf4wNBzSeBOQC+n/Xfzgnik0D75lkG1VMWy?=
 =?us-ascii?Q?O3lDC8v/A6PXybD/X5zXk1AYXBe4Yee7dpb2Ji+lg0k21VKq2qR/vOyjdFPH?=
 =?us-ascii?Q?rLNIHBKQqtTG79xNXQ0bwfsQj9g61VQJNrZtcfx8THmcWJp8Jqzwm6NdGXp3?=
 =?us-ascii?Q?CVLJEtDQU4RScyiQ7NHuZdi0E+sOfDHuHczOj4n//mZLDMhoEegiyxKfsUUQ?=
 =?us-ascii?Q?tRnO6FsbObICJfyUHlPOZchZshwdEdkRE2VIWIAWP0P7/IuDHhGUwzQQXRMf?=
 =?us-ascii?Q?wB8Cxg2DScaDEAlm3dGTivCuE42CpeDEwAcsq+6+sF0AOgihyiXKwZjhk3qG?=
 =?us-ascii?Q?108TS1xxta1Tla7eYIPahb9Vc5/k1o4Sa8wizsU3jKQWNBLSOJMaKbaqhM+Q?=
 =?us-ascii?Q?ReHhOM1qeKXvFjSceS8/Tv/kEIWQkU3FIaFLJyifDShgCSRBZW64S8B/5IRg?=
 =?us-ascii?Q?nLUYtlr5nS3fuL5ahp+9il+GjZESmA11Crxbz6E+3LShq3G0rEMrJ14QXekV?=
 =?us-ascii?Q?aKCJaivsrFLxPeCHxk89W45x8qu/p3L0OJ7eTx4njRlwpg23OIxwCckXgRWj?=
 =?us-ascii?Q?r/jLrIIGzy0IuF2NR+8j3lG5msuutRkTiIUwc7+uW4Q2ZYtzQzbR1QsokkSr?=
 =?us-ascii?Q?aQgESWRhyFxaXEDPMrb/NWcLwgS4LCBQQsspOUEN56lK4dZUhLyPb0GqltVy?=
 =?us-ascii?Q?rcyvDlSN9R0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QvR6XTGGFr1a8X8ttMj3C82ibHg/aU59YQoTVvb7R9UFI6IiR+7QSZU+b4yv?=
 =?us-ascii?Q?vbPGksJxgEtgYM/273Xs8Klay2/vcP9SYiqNNYiJaXl4a7ctebFu/nqxyd3T?=
 =?us-ascii?Q?WnBxjNfnKuzDhYMbWerVS+9Yx730bUW2blFgdNrVso+cEgTBcElSYLt8c4Ss?=
 =?us-ascii?Q?FVgojzB3aftb0nCRSxQnEJXD9wVrcrK/oO3u6prKReamH7+vkRUIO1lED9YN?=
 =?us-ascii?Q?EmjYKRTPVgj84CgXFyOV1yu0cGrSc63lx3kMmqc+HRyZA/IeDpn5znihsbke?=
 =?us-ascii?Q?+x3IGAPNNcna9lAy5YCEyJ/ttb1cqsCzx2xFbLco7Ojky7e9FlVIuzYqelUN?=
 =?us-ascii?Q?dTCERhg21dCZ3o7Ra6yMnbKxB0eRr+cl/m2WelKdb+bO1ZnPhoCCAr61fhbt?=
 =?us-ascii?Q?kk1cQJgHb91DVFo0gNkV9p835Mx4kC9nfp7HoQdMnhFgxyH7TnKMKMWnNZml?=
 =?us-ascii?Q?k7d9oJ+hTk3EHEZhdX3DKreErZEfTRP8uJcdOwV6LK15WDRvIbT78XXoESZU?=
 =?us-ascii?Q?ZoW/M8G7Rd7c73sWOwiZTJSvK3JBWWBawBYhN+qZPg1THMdGhPX1QzQjil4S?=
 =?us-ascii?Q?4xTgg8H0ZpzQBjFoWxr6NUwaOpN4V1m8EDnIqpdbFYL/pkcULpOGFYTIQYKq?=
 =?us-ascii?Q?r+4i6m8Dh2wDSy4qyj77QU95bxIb2tnZnbj5FXZaauS1Vmz6cKlFOduK5Gr4?=
 =?us-ascii?Q?vLE1X3biXC9XuULsgGiWLjDsf+VwbmGxA1uUJegoHfxJ4GOhI73H3/q8GvfQ?=
 =?us-ascii?Q?iMmjfdkoAWsK9rsaaUzG9fCDrZTo5MbZqmhVZ7gTwgLXs4gWNMLwpsLDL7Ai?=
 =?us-ascii?Q?LRL7ZoZJDJKIMSvX46qu1zkAgJvghtsjufMyfyFYmDY3VEI9y9VvjosHRsEa?=
 =?us-ascii?Q?UE4gbu5B4Ipk9dNz8lUpZEHg9uca1/NZpAcpScO78Fgeo0Y30TxcHQkTQnKn?=
 =?us-ascii?Q?R5YA0oZ9jkgsybLKSF5mfel4xDnA/h9aCdmKpZH6rexZo6ZI4SAHxoqhUalp?=
 =?us-ascii?Q?JZrq0unJSnUTeItaxZCDOGXn3xylG1chw331wtjuJpFhsBpZMPHzueqfjWg+?=
 =?us-ascii?Q?khZc61k72pokJBRMCe2LQdLvJ/1thLp6si8vpSzOYI+xZG/28/wU421ytVf6?=
 =?us-ascii?Q?sL57NZESncPAqogIbYkgCt8NJ9XFQyKCVESQmXMrBBk9J3j0JNW/n6TAnQ0A?=
 =?us-ascii?Q?VpkHRKkRF3dM6oQH5JCMtlHLXeaniLtVdXedwpVtv1Wq3ghwzgpqGGe8FTq/?=
 =?us-ascii?Q?RawKmhC46Hd5eSuZn8LQqlsqXiATMntCuJG5UG+LUbwhFM+50z/iKwy65x0I?=
 =?us-ascii?Q?MoUC2mwH4h4nplCVHZRPG8QHD1p5PpxYvlw2LD1Os1YtIKq+ddNGjapf3bxb?=
 =?us-ascii?Q?gtMuQlPoXk1Hsuvaeee11XPK2yYOppLmZgV0teW6iHrgtfuyFw4wb8xGX+rY?=
 =?us-ascii?Q?fk4oGsVDZBD3Zn3hC91t/SkSJXzdALGGCFEDSaUKdUoHFyPYhmQARkaJi3hz?=
 =?us-ascii?Q?hj+5iEdKutvNvAFSkkj3Z8zBzUjrTwuw2CzKpvY72QPbtrkd1uJBzUK/3aYt?=
 =?us-ascii?Q?hPXhQoMfSRODGXX2EDukL9SmYrE6h4PbTDIgj9qxcEThEh9jZVergw4ex4YT?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HVv/vuyNtTUmipU0U5RUsKTjo/jUyu+218OzvmOpQYbIFjiwN4CZHubCQvttQF7w4UIR3FYgdT5kW8ioZiRagc8I4BotueMPRutoJyOYtMDCGsBclx9VEppF+AY+fj0DbWjTjHa0m/1q5/TQoAbK14aq2FoBeqLo73UNuwxt1XwFhl8N612Qg62c4Cu/OiHCPaUyaDiaTH8Dige4NK+J1SbEBudfHWcaR+HUrkA51OF/ie5FK9Ksqs10JNuuzCK9OCfgcX1461mpd9povRsO41P3Le6K/36vBf+EUIw0D81vglTZiVak2dU+VeavxX4+lu7y8pCBr3zkFQ+HpDUQ60DSixMsDJK4WPQH8TCxDn/ep4FjM8/ysgTM4zEk/ddSMcUYdx6PyYjIPmmWnzMZOFq8skbL5dV/78rNFX4W/GiD51HqcHLcxJn4tNtyOWfMsVfMngizbfQfen4GGrl1dQMEx14wlUTCzHYKgI2BYGK82Ftd/K+C/CF3hF7eGGRMTUyJhMGGvvxZA1nkT+7qJJKp2FNXjCN9mtJWhw627jWOoD7bTQz6rFhynSgvMFGaKV7XAJ7eunnOUu+4anUlZ8bhrEMgLgiZQAvO2MDyrY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcdbbd5-d1c6-45cf-db98-08dd7c171a62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:42.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BiduD+lZidQHBEKek2bJbDCdWmJ50DTGnj46ayx/z4xOcYm12KLhDUcQe7ByUtN4ZFjxDGKBIwgnMx5vGE3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: FNKRpx625l1CN8W6llj4QzIrTSWs3SfI
X-Proofpoint-GUID: FNKRpx625l1CN8W6llj4QzIrTSWs3SfI

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


