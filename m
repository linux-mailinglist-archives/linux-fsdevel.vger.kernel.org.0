Return-Path: <linux-fsdevel+bounces-38325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F79FFA1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CE118839A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3A1B5EA4;
	Thu,  2 Jan 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpH810wK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HWKQxNLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA2191F60;
	Thu,  2 Jan 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826701; cv=fail; b=bL/hGwjxumDb35H4Dz4pX/ezXvhylPAGrskA5KOocqaaGScoyeZdTa01SjgI0xPsDyR4nIqpDjUX0Cfjx5kAOVj0pQd1w66CtuRq58Clj7V8bXJBxa+90uqOSXuojLULjurkMvxCuhWho6Y0/PSzzf8PsTNW0uSd+J/61Jt6BXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826701; c=relaxed/simple;
	bh=MJ9t12TgjZvqcrHrVZ1Imc56VXpyRVUEoM3BhtDOGrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uz82Zg29zfAtOh5ozFMVozuUNlTuViRjoi+tt79ixzs6cyLdanXpbAYS+Vxxu8zuzYRg+s7iwzZNsG0rK4EFpicMT0TjHiKXzLcCxTvBrLHFOD/bu6wtdNecz8F4K+P5UV6YDsdw1WoFGB2tkfHV/oiK9rN8BtejzkMVxaYzsJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hpH810wK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HWKQxNLJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Dtv0P024654;
	Thu, 2 Jan 2025 14:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eel+vuNBGT4aK4raL9Cbhn4x7jQbMj0b8vAB77caeRg=; b=
	hpH810wKj9cbFgSMSyjS6fXo4nIDVBuBKH9Pavn8jf93mxjYxLEwPcanD8gyX2uX
	9kjkdxBEn4f1ELgxUhIO7IKG0dBFueYjDsUMAG+th0A4CZuSORIThRpBszZs7fNw
	nyd+kXb+GF9jRkFvNxKC8wwSupbgMK1ZI7ZkECZXrrHYMF9Qfp4It7dtw97K6DuW
	wQaCneHfGa1bNI3FjXQGc2RP93avh2UosVKyUP6IcHcVFNiLlMEc3tuW9GQ7J0ZV
	JJpcaRUjixNLhoK5BLzcWJGTMSVEay0LMcGCmKN2LktEk47vqAsh59y6RfC0NQHN
	mI7eEkeXoVd/QkPDvjn2og==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb889n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502DZNhD009071;
	Thu, 2 Jan 2025 14:04:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8tsbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsLoZwGHx5erFCqj5BDTbm+AQm7a9YL+68A/hHs+xJKfq7qGo19DNyiC17fnqzQBtwfavQht2Oq8bHUthhzjO6rZS6XEFsW/TxrSYGtJIKCClJ8fsjpWiaOp87ssys6Q1HgsK1EhAArqH5zDONvD1WjHJg8gu0S7ylMUVUg7RFwKuiwJdM9LdFYT55dhq9stdUFF3CExfF3k88aTaW4ZYqeuJqg+gzyqzbrUM8n6QkdGgKqXePuPFt9za582z/TQeEQx3h+747G9oeIalDaZTfG9TCNJwR8JTC1QFaCW9XiHOc5cGTI0ZezLMRGNahp5C5IQUPB1OKKiL/lre5rQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eel+vuNBGT4aK4raL9Cbhn4x7jQbMj0b8vAB77caeRg=;
 b=qc87nw++zPiJxv1osYHDXV2EK0oNlg+0JGTmdl/eCyip27QQfrA/iHg2wAwxYjWZ+9YptIbCvu4W53VKWXUJPUxWmnOVkIgxYnzljdmgKpnyf++2Ys8IVZE4ObhihkdXiOnEOfg1B57pBE1hagMlAHqOr2exGTJXZOWkfzjH43mLEABgj2Sc6rHSSgIUE0xNI9AgkvzJWoG72SdFJPWDLfnK0kpn0hfdHzzRkDFgr9Ad9bgEn0KZuisQfR1ycB1azyS8oPAWpom6XZu+X8TCgFeYiNAoJezcCiy8ppSvKrJGkvloIGOaGf+mriBVF40yQtXXFFCpFYW29QfRjn5ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eel+vuNBGT4aK4raL9Cbhn4x7jQbMj0b8vAB77caeRg=;
 b=HWKQxNLJyMTiJgBbQTghRLU/7p0r4dZ4BGQmMch1axvAqTKdsgH8oZhmv44tcyCAE0PanAQfNlds+jqthgpHx0Fz7FGCRUsUit1cdCiO8C4M3LV0J3uHxC3dV0YFjIUelltP/71cC0TgAeMLS1P52e9qaLuGShpU//tOu/4X3Q4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 14:04:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 6/7] xfs: Add RT atomic write unit max to xfs_mount
Date: Thu,  2 Jan 2025 14:04:10 +0000
Message-Id: <20250102140411.14617-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b3d45e-9f6c-47eb-d6ab-08dd2b3667ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wc99lgkhgNrKGhMWQaOFHQz+OUwdn7KzoO12TYnBFZiwhIp8edib+FE/CLll?=
 =?us-ascii?Q?n3zJvSvt12TQ9WpNH2eY5vAk9DAJIVvnnT3nR9oTAvCj2CcUCQb998EsbS3/?=
 =?us-ascii?Q?ff3pnKAfT1XYpM6hTkk4YXc6pUl9HlmZ6V+rU2eg2mrzfivOr+yss6wo0nJn?=
 =?us-ascii?Q?uhmFjk0XMkYXJ9ZBehiKKwrov2pys/JmxruCFc8OnRZERDuXu+Jw68iW3pF1?=
 =?us-ascii?Q?oEvbkPcfFdLJ6DSfu37ioOlZtFw9MfqAuaYBP0lCAskLNmY3sp9L5og6Uq3H?=
 =?us-ascii?Q?+IolLbujhpwmPfJURwlnBn3RzYPC3wDgE5V6ofp/GgekoGsGl5khTm/HcJWq?=
 =?us-ascii?Q?787W5f+IShXBy688JDaKHh5pGBBUJ4G5+63eWLVzEdn3drTpXnN+GG67+cz6?=
 =?us-ascii?Q?Cdr4ntxUeSZLINyk3ozlc7bGM2X03QP7PsOtJEm4yscT+jQS2zXjqvsw8pHt?=
 =?us-ascii?Q?goJkWpSdoQ5NhUGDcQ7UZCXfn2LWomylubExZnYJpREVGUWXHbyX3kGtyO39?=
 =?us-ascii?Q?mnwGjK+fzvIjRr7t8ktipZ/2224C4732+qEZpvBxOx4FSN242TrfLME/AWyY?=
 =?us-ascii?Q?XhMFIcexyx4RISCPr6ZWiexwKScg61zguXsW43VvhlQqzjN8WZGKbB0dNRft?=
 =?us-ascii?Q?SEn04svABMYv7Gp0OD1UJYAYj6C1UIeL71lMv9Q3vh/7zdw8+o4nHq6gMtqw?=
 =?us-ascii?Q?CflSdhKSL/jHvlm4vFT8VZSQRBBCjwxTWdeiKOihSodnQNdD5XaRui2JRWx0?=
 =?us-ascii?Q?KShfUoCwHy6BmWIwuqQmvyCSE9wENj0M/c7UMl6TbUrdiIyZGojAfql51d38?=
 =?us-ascii?Q?9mKwBtX28cz4XU1uDSP/glyqiAfe19gfplrbggdlZTSOTbLlyAOKFwEcCLde?=
 =?us-ascii?Q?VA3LCPCvADEvRTKed0+cIRqnzBjav5hsVGj+/yAE55OVMJZZc9wkUF1AC4Hu?=
 =?us-ascii?Q?Fh83LTkV4cEyfswznM8VLwwkpHyvPRkAFsNu9LSnkeYI9kmpx+g2brtUj2qC?=
 =?us-ascii?Q?lrzZ2AHdNEiFQYVJ/L19BDqIKYrLr4mYqefUOhv8yppZO4utepzWkzMQljN0?=
 =?us-ascii?Q?c84EeoQi6lpf1juXvRrIR7k2P3op3TQpxAH3DU+/oHU6a/gOFDQ0z8nbpzMv?=
 =?us-ascii?Q?dn9ujtnyybkIi3d9gciEdlTmXPK9Pkt6lWLTH286ZKDS0+4BBdcrb75nwSmP?=
 =?us-ascii?Q?82K+EwwjywZQ/A1NMV06mzRpLTSzkjRGqotDm9boLXItV/PkXUFgVG/5O6Ie?=
 =?us-ascii?Q?cp1mvZUGgBdUgDz/KiexPdesZ4Fn1qkh88aR58DgOp6i+MH2y7nJm4DE5nl5?=
 =?us-ascii?Q?xrg71ujo4XUBp59YjukOfX5aQt3TfJ3DPr6JIb+GnNPo0YrAwvVrJKFK6mdu?=
 =?us-ascii?Q?XRr8RYgm7v3lDoPEYRGmOOYP0L2y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQEeEd/azelVsLdqFGbSmniNXPsvz5j2K6H6+5OUlAnHCaxkL4SiEdfREpnF?=
 =?us-ascii?Q?N0xyYqSgsLlu9DZd1zJaxyb2Q13W8qLMLT+Ag+OUgaiCNxKzadjzqA5DKlvH?=
 =?us-ascii?Q?hw9PvGmJ9hf093Ebj1+9iqHLQIceIo/W5ZpqiAL090IOTICEOKVJ4KXY9qFj?=
 =?us-ascii?Q?I2QMgOmA2FYuygzQNH67AOFzQObCO20e6D5uFuJ9kHJIS3q14CZWoyI6ZVpQ?=
 =?us-ascii?Q?3eZflRjB4Hly3jnCZez0AKLEC7eXbMtFIk/6RKEnPoCWW0+vwmr952GiTnRB?=
 =?us-ascii?Q?7F97GQQObKRwg5isZEWRSENUctgO8VgOfBsg2KmVea7oWRChVF7YK6yKjxmg?=
 =?us-ascii?Q?rJ5Ew1cJFOU7urDRbueQhSq/6ybR+HCpgQnyZ9etq3VSMHjG098aYtCaHjsY?=
 =?us-ascii?Q?u4Bmznub01zMVNTfZ3CQkabVnPBMY0p40B2VMITX8Wsdb8uf56hG8lK3NPys?=
 =?us-ascii?Q?quQNC3Kke6WFAuHF/aRZYf+yXu/qtvJ9z9Q0RK/F/J8IA3atwb6+MAeq0B48?=
 =?us-ascii?Q?vLO38jbJHJteCTLrouP3KX2jm7JuALc67S976eGZE3IACjOTtf6Yt805DUc5?=
 =?us-ascii?Q?rDxodO1n/ik8femyI9UM17Ud0izoSAqYYIObkSbwdeCLwoEYxwGAW9wuBn+R?=
 =?us-ascii?Q?4qQ1pZMUWydPBVlTTbojAaOWVYyZkET7/4JYTH3120hxMFA7eSIYAPotA2UB?=
 =?us-ascii?Q?toJanXdX4bY+QFd/6lnre9+FDpL/yLcEnASydN8dfp0wdQESwbvuqX3otS33?=
 =?us-ascii?Q?sc2JYLgugpKyPCNKJQgAUwa3X5gdmzrKHK0Liw6K/Vw8TAI8/37S5EdTpQA2?=
 =?us-ascii?Q?et8vDg1P+mhNalLdXK4oqYI2Ne+UUqWpFWnI8gOzGVlbLk898hZ1WFAuSUQ8?=
 =?us-ascii?Q?CbbPGspsNBzt9jXi2x55Gd9yNyUs78eJKon6ESTbSOTiy27voLKwjlpg6qrR?=
 =?us-ascii?Q?JGD/oxiiXOdZVmZ3dr/MRKAP/1zlt8aRFjG7BOfWyCNVoUKPMi5wrXp1Id4K?=
 =?us-ascii?Q?qmmVubf5xTUqupHr/Rbfyq1BCJDM4vLJLuiCmXQG35ur69TF+JRiIvlMD1T4?=
 =?us-ascii?Q?Xcg9R5sDEA5TFr2YpzkhemsFdYQkLQexMsblp5JkGSMWwTMxc322SGl2qhe2?=
 =?us-ascii?Q?ezoftWd+i/ZDaKQaw2rv3kyGmUxmqtr42B3duoWfYLdpLkWFoX/BwHggxrcb?=
 =?us-ascii?Q?SHJSB2SuTOigZ9fTvDyL16/rcvTF8eY+g9Uus3BfBHZrVUhw1kQteG5FDmOT?=
 =?us-ascii?Q?RSS7rj51M0VtY7F/Hi/N7RWsKpZpDeqJfAKFEJk8QTHGCjipzXmyHvA83/4w?=
 =?us-ascii?Q?B9b3fx8MtbgM+kGcDsE3O7dub0ejUUMp8yS50YwTls+nSlY3YRUprFPljjv4?=
 =?us-ascii?Q?5HEMws2bCanB0JmHMxRTWSbJ6f2ZNFNxbPosjqD7Xa6EIDJHyAXZG04lqE6n?=
 =?us-ascii?Q?3hHRvQVEGPU8CPAC1lKzp1LTQasXpd459Fww9gqPOVGrRGxNmpLArBeq6VUi?=
 =?us-ascii?Q?IyM8ap9BdS2zU3O/jZX50tUHju/gpJ3rYiP+co6l4rETM4/vtEAGND30PIGe?=
 =?us-ascii?Q?e1jDL/FnMOnNNryWnEKB2ksKd8drwiVlQXsAeoo/rPI2TcpXH97+SIbEAZC3?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SePt+uYhqeegpVvjWLzYG5lfYT3UEXlyFYovJo+MY+BiI+yxuLHR/wyT9v+avtEEVTKjwQJ4DtGPZrdV8abFfLi15QQ7A/BmVBPv7aMPZJYMaBXFsAG+pk/+8Uh+7zWQouxp8j/xZatrTIRbZ6C3yzbMpvrYm+cK42zrcy5a4oa48VD73gxfeBIpn+RLJ9Fj9hPATi9QE+thHrGHycStVAweEFgJUMUZXn+ojpHomSzdRZ+eqJNK+zaNm0UBDSGOYO+qbiFdMIy4e3Nwb9UcmzEgVxUdwj8DF377f0ET0hRPnNgo3iqoMCIWV9SpP9ZsoChBoWEbvq1LliJ96xhY8h5ZJmUOGSlra4MA9/vjzVlUAL6pY6G9omme+9fvrD9bO/cazwm41PAZx1kuYkla6GOVngg+FebnPMpWNFae1Z7iL7CPfP+YGuPO8PJJ+An8WCq5iKyMR2/RvU220c1ivu25zHWDytBsVzZcA9RgHO5Uj3k4R4UcGyu5h+/ZGiFlRBTLBUcy56LmgGQmvrI59kFeAqziMHiDOL5y6oACsAZmf0d4ytxqNR2a12usEmypVfmyHqeNTNclDp+YdW8/IXn+7ljRg2Eljo3ajVXgbUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b3d45e-9f6c-47eb-d6ab-08dd2b3667ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:42.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV26QjyOjQ94pYkPN9Rmm4YIok7SndiqJZlVSot3fbE0VRPVjOkW48ax5DVF1QVxMnjDpIW0wj2SpblPfA3Kig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: 4HZ2QW9U1iVLrf_BVagBqgyPMXkHeCE6
X-Proofpoint-ORIG-GUID: 4HZ2QW9U1iVLrf_BVagBqgyPMXkHeCE6

rtvol guarantees alloc unit alignment through rt_extsize. As such, it is
possible to atomically write multiple FS blocks in a rtvol (up to
rt_extsize).

Add a member to xfs_mount to hold the pre-calculated atomic write unit max.

The value in rt_extsize is not necessarily a power-of-2, so find the
largest power-of-2 evenly divisible into rt_extsize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_sb.c |  3 +++
 fs/xfs/xfs_mount.h     |  1 +
 fs/xfs/xfs_rtalloc.c   | 23 +++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h   |  4 ++++
 4 files changed, 31 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 3b5623611eba..6381060df901 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtalloc.h"
 #include "xfs_rtbitmap.h"
 #include "xfs_exchrange.h"
 #include "xfs_rtgroup.h"
@@ -1149,6 +1150,8 @@ xfs_sb_mount_rextsize(
 		rgs->blklog = 0;
 		rgs->blkmask = (uint64_t)-1;
 	}
+
+	xfs_rt_awu_update(mp);
 }
 
 /* Update incore sb rt extent size, then recompute the cached rt geometry. */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index db9dade7d22a..f2f1d2c667cc 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -191,6 +191,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	xfs_extlen_t		m_rt_awu_max;   /* rt atomic write unit max */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index fcfa6e0eb3ad..e3093f3c7670 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -735,6 +735,28 @@ xfs_rtginode_ensure(
 	return xfs_rtginode_create(rtg, type, true);
 }
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		rsize = mp->m_sb.sb_rextsize;
+	xfs_extlen_t		awu_max;
+
+	if (is_power_of_2(rsize)) {
+		mp->m_rt_awu_max = rsize;
+		return;
+	}
+
+	/* Find highest power-of-2 evenly divisible into sb_rextsize */
+	awu_max = 1;
+	while (1) {
+		if (rsize % (awu_max * 2))
+			break;
+		awu_max *= 2;
+	}
+	mp->m_rt_awu_max = awu_max;
+}
+
 static struct xfs_mount *
 xfs_growfs_rt_alloc_fake_mount(
 	const struct xfs_mount	*mp,
@@ -969,6 +991,7 @@ xfs_growfs_rt_bmblock(
 	 */
 	mp->m_rsumlevels = nmp->m_rsumlevels;
 	mp->m_rsumblocks = nmp->m_rsumblocks;
+	mp->m_rt_awu_max = nmp->m_rt_awu_max;
 
 	/*
 	 * Recompute the growfsrt reservation from the new rsumsize.
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 8e2a07b8174b..fcb7bb3df470 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -42,6 +42,10 @@ xfs_growfs_rt(
 	struct xfs_mount	*mp,	/* file system mount structure */
 	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp);
+
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_growfs_rt(mp,in)				(-ENOSYS)
-- 
2.31.1


