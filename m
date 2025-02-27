Return-Path: <linux-fsdevel+bounces-42781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAAA487A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F0516A003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C12356D3;
	Thu, 27 Feb 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTt7K8GZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="czIC4d9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC41F584C;
	Thu, 27 Feb 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680203; cv=fail; b=J2bzpY0cjkKjFmOukQPHNI/6WevUHZOQH51wYEwvwsejQiZNQR3h0hGuLsTQVsjuU3M7s8cps33rd0XeJvt9lxbQzq1XOWGgwoA/QUlSj5MueM5UzWQNzVTU1fh8i6XOpF2fddw7BXdvOl8bwIR30Z1krJ9an1F23Vs9zKmsss4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680203; c=relaxed/simple;
	bh=Nbu4TqT62xCn17OylykG6bmUT1AxqQ6Rzo4PElWlBB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4amapKQZ7ENOJ0aLOfcnJwxuy6VAnWjLqBaTGmffzH31hHDnsm4gCp//GujO75she2P8A7WEqB44PtA6DDene3vvRFZCWNMrCXarB9RkKeTek9nk/kvKflZuFNy3U8NrraqYzHl7m0f7h71I+5FFEJjta17UdzPTuz+acW58ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kTt7K8GZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=czIC4d9o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfkxP005600;
	Thu, 27 Feb 2025 18:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P/+ApcAcNL7o3thA0sV9mr2CpDhelM1vxeoL1cDXdjA=; b=
	kTt7K8GZyc3JuwGwjkzju9NtALwUgeWLWm6z8KIgCVKJkndUnGf0iwT9MhkqMh7g
	zAYqHSUhRs+gnm6BeKe2RcMBajXd03Klfj3JIeRV50eHYL0C5S+esyxoIL84tXpB
	G67qgmYHtJfFQdrcJddQFBg1//+N8sT7MV2F4q2ovD8S1ii4SdIWbDy0wTnAVZF8
	CBLrTk2wkr4i7rdbQlnAgwTAFckwQaFD53u9JdXoOW7Hif5pJ68VA37LNniJmZFe
	BFo4I6Rg7EMv/b3rHY1IADxGKxsYEzVLh2GB12dtu+tWR4VTZlLapzUGAtazM/oz
	UdserH2bUqQWSHC+a6qPew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3yaj-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:16:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHcwhT010193;
	Thu, 27 Feb 2025 18:08:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c6suf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQpaDfQPz8lznaoR56dUs8BxA3lSEm3/vsVmzIFTRZW983b4xq+9rX3i5VFW5ShcwgBeSFK0I3UcAcGq3iJPvZp74CJ9CiMpeQcTq8fHDnQHPeovhK72q1qJJmSqhK4zjURejn//SETHJXca7pCdwkeLt9WRnzLY4PtribEWgoyn7vT4wV3bKjP5oLfxldLJFGbWOgVDAppVLkzi59wgQTfMtv2YA2p7ph193ryaOtfYPBXmFcJwMUhSdFE+agd1fB9vDQTCz2RrTW3jWFIFAP3XGHYyXYOLxdFClamVdOCNM7ijqCla8nnoKtrh8Nfw/UNfYp2ihuja9PCax0AEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/+ApcAcNL7o3thA0sV9mr2CpDhelM1vxeoL1cDXdjA=;
 b=E3TbiC2JkNsW5LLipDGwVBvZiWswAb/RmoEd6pcVEuqyxDUC9fy6HjYH4J9/Nxwte5wEt9THKCQBcczNlUC5zFP3ZsnFDI1mwBdwFkpxLfMP06PYwpkCrXsX2A9FkomwByPzenX2lo5zylN+VVfR+W1DNh9acHaoeUoFSyXg+SNp/okkIJgp0IjrMEv7c6/bzKjsXvy0OD807P7SDYCr53o49LC6i2OThkX027nk31/xOgApqph5ZtLjOQVBoPqOIlzZdCWkO7WeolV0w8ztOZmugT/D0F1im+CJRwJJWGxwQ+cXGcBC8CpEIqbGlBzR74vj3RwMI+CVl6OYiul9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/+ApcAcNL7o3thA0sV9mr2CpDhelM1vxeoL1cDXdjA=;
 b=czIC4d9oF4zJPps6WlhgBNwpcs4j/vbE5yGPdY/wZeXmqwXHB/+rZSemsc8QrLhdYNSyF24hgWenco8VbTcF7i8vuenD4HJQpn4avgKvo3xc4Xkd7iwiwaVBnbWG0p42fwk8Vv4cc9wFQwe6nXc4584pbislL1JnD+7GqGymKPE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/12] xfs: Add xfs_file_dio_write_atomic()
Date: Thu, 27 Feb 2025 18:08:10 +0000
Message-Id: <20250227180813.1553404-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b793cba-8769-4ab7-a327-08dd5759c5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ne4Ba8Exobpbs3GvvnUEG9zeMXFBA8/QinSdSs7S3fggS06vjZOKR0h6VzPC?=
 =?us-ascii?Q?dzY61CDF62S5uiTt6OR8TDhcHiBky8WVKOxsRLNO3DkJBtN/Jb37qw6zWfMQ?=
 =?us-ascii?Q?NhlV6V7wNN5pp7O4m3TxYT4UOpbjairXZ5hlSqPdcFpulfIVDXoxBEY48NbW?=
 =?us-ascii?Q?5y+fs6zmLq26pQSZe1rm1ngliQz6OENalPnvFimSX5cefH2EU8qvN/OOiRrb?=
 =?us-ascii?Q?GDqGygQGCTfHJMpIWT3qzvfdH8apVJXyN43blD85pXSEpblBh0HzeKdsZBi+?=
 =?us-ascii?Q?CXas8lQH+MoHfLn8934Akr8xpHGqTGAU7l5XF5HAaalfKvcgCl/HkTK6ZCjx?=
 =?us-ascii?Q?5K9TczIrQtDXCfKqxQJ58p02qbRZ6i5kRh7SNYRBMvEXe7q6rErmawoZ1bu6?=
 =?us-ascii?Q?656XKuGmUHUeuJMkNGEPhWCepHmwC+8AczHPVDTHhiUaJozgROA+NFS7r10Z?=
 =?us-ascii?Q?wn26lP7hyGViWu6PTzkzUtML55Pkh7IuySR37Ac3xIWT37sAd6bo9gzL80Fy?=
 =?us-ascii?Q?+a8vpO5U1lCHg8S/GmxR0eNyFbJvlhQWrrWJBNTXaa5V5buBYQz7SvpmMRjS?=
 =?us-ascii?Q?pRHxPPS3lRZEgqnuGIjSGFWHTLiksD1IoKig1BHEMnnrzJ923bP+Q3WI99JU?=
 =?us-ascii?Q?yWmp3S9hyIF7pJrSJZGH8XUvpj6BhHUPfYhIs6QwaJRcrnwzoG2gMA8UUZkn?=
 =?us-ascii?Q?tuyuGhtFkP+5GNSrjvaQ0cfOBhfuHen2yeEfzkKXkPa3pK8UfXasNfzlxtIm?=
 =?us-ascii?Q?ju+fNxVEYalVexhLTWVkRHRbo3LBjKjB8/AvUwxw5nzc3m2OtfMKSb/m1eo0?=
 =?us-ascii?Q?edLfM3ZvyXKTcW2t/2NeiUYSUnbeYaKor2HCPp2dLz1TJNbRxKmjNdPskhjR?=
 =?us-ascii?Q?ugaxuu1CReeErdPzQRcYbkWmlFuDES+/72ZYQ+0E6RiWWQlCv177VKxHLgAH?=
 =?us-ascii?Q?SGe0CK0qo0fDMRpMAeyNwV3Jej6iQku1/3M51D/uQdFfXYbop+NzBDUAimQm?=
 =?us-ascii?Q?N0mtdrTzrffJJWwg9WT8YBuJ1DVyP9zcgfBNhct7mJ+xnILRbd1WHbwNTugZ?=
 =?us-ascii?Q?7ufaYZheFDEd4rF/OGeSBBs/vr5ZM0pdUbyBTGb2Gc3MbsIl7VnGIY1bTmVC?=
 =?us-ascii?Q?kI6V8vHe7ZLVrRUR7Q3i1YzjW5rL1xhWPw8E3EfFVRd6CkRNrq4eJe9t8Fk+?=
 =?us-ascii?Q?Gxo6SU6pEl4hxA5y150JhiyIQoIpNM9kbA8xqZJtMbmP/wH67CSvp49s55Be?=
 =?us-ascii?Q?tOQGUjCyZKY9NjC+m8nZq0F80U78n2MX621xm5W1LgYaoQ/ea1pYDQmOsc4d?=
 =?us-ascii?Q?pLO/DDBnj7zfaCCjP9wyEUIbkaIfff5fUYEbUOGydYgrF6wbyI31lSe9kzoV?=
 =?us-ascii?Q?gemwGzNWTK39i/Ui7t3wwNo7UIGe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1faPDsWKGNKCM3zUbcgvxyuDcrXCgISfB63dX2YMDO9D85q1EbObQ0Xf8KU?=
 =?us-ascii?Q?aLtupueDgWKl3y510V4UJ7qVIy9CFZLpTeVEY65wS8PzcIVgHyj6wlgR/zFl?=
 =?us-ascii?Q?AMrMb6LyrXFXXZm/gqaCrxqgSb63DaRD745P2ev9LwmTdbcDZkMR4hDR3gmJ?=
 =?us-ascii?Q?gQ/nCsv63HO7rPWacx/WPLN4tu6lvbuhnXEVroGW/H+mjHcOzj7ZA9tNsHuB?=
 =?us-ascii?Q?/rLTz21HNINljTmpBK9u6s3Vi8T/6LdeQIo9zMmjEUL/N0A+HrM9Rst3RI/j?=
 =?us-ascii?Q?9Zu9yLLGNR7ciO4Wn10TwP9oWsl31ClmcdKThoq/H9yt044IBPwUTaBapOx3?=
 =?us-ascii?Q?ZfzaQ3HRX3zsYLPEOKg0BSCN0hXiz4nqQ7nu8Fc7DVAYfCDhKLG5J5A0VmKL?=
 =?us-ascii?Q?PymsGxSeB67N0Kal/EPw3gRvpqmKWdiob7RsLXp6dGLt4dDSbHVXNg1mTFgr?=
 =?us-ascii?Q?4futf6xpfJs4egaIqd8DABp9wqdKM332JUcF4jE1gwz8AYEYTRalhqgGf75N?=
 =?us-ascii?Q?h4p/opxPJ3BziGhE9s4tt8EucmQRa23lOzf7OvF9tGQAaBa5xvX3I2esgYnX?=
 =?us-ascii?Q?KlxUEDgv3uWBw1Ass1vIsfXygEa+tGVPWzpUPIH76qImpx0tVy6Co+RkscRo?=
 =?us-ascii?Q?VVzA7ofCoB6GKHF0ztaZq0QFFunMm7Q6SxzJOTayQabF0KuCH1AzPNAN4R8p?=
 =?us-ascii?Q?ySXmGmOUmGb/+z6LV3eY8nJfi83DM2NOS1N+Gcu7ibzVj894/46aEOVPPqwQ?=
 =?us-ascii?Q?jXMtflNBgAkjUpUQc2NWDrIM7Fqsv8ZeRobfn/sf2bDeFmuZLMuEK66p51BJ?=
 =?us-ascii?Q?dEMUiOzlk/dg77PcEmti7n/9vJa1Xxr+906Ioda7CZYIe5po61Ka4OWfB2BL?=
 =?us-ascii?Q?jKcJ7aaoEny6Ro8Enyy3hsy3+XRLdtaJoybROzcKInFiiu3Bjk9SOO4r0oZl?=
 =?us-ascii?Q?WjhRmkjrqUPDGDaZM4Q4ra5wtiBBZ8MEt1wPl+4IFzUm7+HEZT1FnXRQaRd0?=
 =?us-ascii?Q?d2Nj/PJJO6vLc7o8FX/MlHJOCgxxTBe1Arbf2OfAItFLZaMrZ3xK/TS9NjcG?=
 =?us-ascii?Q?rlDbAFuiaTeMso21RvWDyql9JYrrvTL2MacZqh6xdeZXQXgsFCr+R0YuHuf5?=
 =?us-ascii?Q?qEFajIG775fAnxnPElVg3dA2X+THs9DKi1ahfVGb7544a/evGnfhW9/rp+Hw?=
 =?us-ascii?Q?o//PZZsAZmjNeZIT7/jYGMpNM5esUyJeIWbt9YSnRjEiDZTfZ7gYOHhXkWGr?=
 =?us-ascii?Q?dreDrDXANZDrAj32D75N1JlSGb10Vu1nXvSH0mwLEHF1BrShPME0Y26MlWz0?=
 =?us-ascii?Q?Er/lEWisgK8MOKPkPOEKZ+ccAJjaAFmZlqM8suLOVoLbI/g0LSX+1hoIqNUJ?=
 =?us-ascii?Q?jGXfRWpBTD0ZmRVnoScMHQNLXWdv0SCZjw/+YPKanIpnXbXZayb8gPNvf1H9?=
 =?us-ascii?Q?8dWZquNe9SNtBO1o0SEmyMt+vaj1DtZrb2AGTbPPE5BL+5QhTCSeOF1HlnC/?=
 =?us-ascii?Q?nCE4ewLU6VrQGKEr6Ej+Nho985j6/Wpiy/WmMTedLGAaqlq00J3Z6FVCY18A?=
 =?us-ascii?Q?Q3F0uSS8LETBkJmvb7/+CAJNq+DHSr7ZcGuBeFzLSoDamWT9wERL3MhIRPv5?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wD1U7otD55IZ7pDtXyan5O/XTLE44L/i+VwC7ITrDCJvojN0ytWqWjwj37UYbyV57ODEJNFBAlMMPg2pDXDd1nzfK8DnSIx5EI+1g6T7BubTqa/csovienlXVhEcK+Ar+KZL2ckAS5JezOwX4x2x4ZAoIa2FuoHsJ04OlljFG1d8TQIM8lqyTdZB9YJe38guq5aHyc7sVE2LGn6RFWwingdmXXMaz1Y42RauTuZ8HRDpLgxYedfK/i1WRiExaHDC+xZJuD0GVoF9hOUD83ZF/OwTSmz4REu+Zof0PKB5qdUuWR/f93HOH5IQBITf6Sq3sXZ17Q3qUY+fQqxP4Bc7arZ4Nvbt7GTJC2IWabOQOGhDrlB5kiBKrsgcaP/MoZOvLtEATPAfqpXWWlcRIcUeU8Wr78PWuR0/TSh/xGlVm3TX9WatAPZ24gxwFyOGFDhQyQkW0Ok8suCSLCTG9hYRUthIqgu2QzOayZ2n80qNyZtIk0Rs3MEiJE4N88tgDYXf4U4i08AbUtRBjEHW87klwPTMayIK12KTaL0TmXboJ61OoKEgH5db/fRcXcOSBPZzifTXUaq6q2Nqg8PsRceFoW5HP4Ue9g3ijedGjZY11LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b793cba-8769-4ab7-a327-08dd5759c5fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:44.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwpHkJd3PEiq6LxfXJsfdLMw9tdahRi2iuoMsLgvI8PUQyU2hVdqcBCuUD0g7IvRGYr6WRjp7JGgNCu5TXOQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: Rd5DGELiceqbvf1BVgTfNS9dEcplXUYr
X-Proofpoint-GUID: Rd5DGELiceqbvf1BVgTfNS9dEcplXUYr

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

For CoW-based mode, ensure that we have no outstanding IOs which we
may trample on.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 258c82cbce12..76ea59c638c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
+	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
+		xfs_iunlock(ip, iolock);
+		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
+		iolock = XFS_IOLOCK_EXCL;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -723,6 +763,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


