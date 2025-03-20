Return-Path: <linux-fsdevel+bounces-44562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE0A6A5D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50226881220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840A221F25;
	Thu, 20 Mar 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDq4a9lk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iTzAiMb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE19221735;
	Thu, 20 Mar 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472209; cv=fail; b=EpXYop9r3lPs6/SqcRzKJuOGA7VvFxeJ5dxCgsUE3VgGj5Zt4y4UWF9/xg5/gjzqnDG+Ocnx+Mhr9r609MUWT3F1Hs9W0S9tSVig06Q8qXJKUN9GfAxm426H11rF/MPqkzrwHGznwha4+rWVqSZUFvMbhzW6JRNZza0H1MaHpU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472209; c=relaxed/simple;
	bh=fZWzpdc7blt7oOpASM1kskw24j1CHNyENjwszAFDMxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usoQgJdTExsmAPBzu1rHX0DoQilgmPAn0MTtpug4JiHRbOSUMbSKPpQH8ItfGWECxEzJg//QNAGNXTRTQuRJOfYFqW/+YCmQX2nriaKiw17IK2I9cZGSGmrbBL7d08y68q9xYSsG3y1vZg0LXz70vzvWWrzvIVLuDmcdzWz+mDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDq4a9lk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iTzAiMb8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8Bu3v030551;
	Thu, 20 Mar 2025 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j3E1OfZryech0SU+PSDrhkYcm6Sv1qHqTWhmr4cK5i8=; b=
	bDq4a9lkyYIJaZRrlJeUkdLsbxFE2OUQrux1Z6LDm6WkJ0rZTd9QSAvGPT/BzTjq
	jL5Zfh47pBb7ejWeT+ArM1ARUGnY6hLBj/9rhbfwKGv/MKBUwZvrOmY0ZciLpef/
	p94MRwGyN04G2fn5kBx8fB3ieweDfTvsUZjHyhuVbgvSI4oxy98ndZ1Qo/pM6wcY
	N6Bv1YA0m1GBezJzWnBXdAnD6AyXPmf6AYMbB1TzgYGi9k5uMUapUUp5Cnf3MIxE
	jJQ8tPDIgPM92s6qAc9J2v/H7dc9tr63oRMu+SDt5RX3ePVh8omCEGY40nbyg6H6
	thFtMGuJbIVxJ0h9A9OPOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s5xhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAeP9X024475;
	Thu, 20 Mar 2025 12:03:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbm9xdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p40MqEvPxQxTUdq3qQFMKi/dUebqrE/Hig39TBCeMqa+iHF2QkcanJCnn/rCFmEj1QHGPsu1x26kb6xLguR1wHuNuSwlDWeeVnnpPhotkae4JtXb+WoJq4W+3NfgNujwCjh4Wg/61+WcDK2Zx8uyjV/dqcGwz2TSGsRAA6uAd6g3yYCEUS8M/6hKcd6JYnmaV0C7p8xD3J6KNUgERlD7b5Uzi5RWQ85rBn1/7Eghx+bktGc/WjrtloS6jJS2Q1Bbhg+UJMjTPAPEzBATmQ1TDA0lgTRx2C26hP+wXxjNbMAkBgOdhxt4y7wYzTWRfhBFxEOcQxFkAUbxhfalHyrOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3E1OfZryech0SU+PSDrhkYcm6Sv1qHqTWhmr4cK5i8=;
 b=LwEbcYOYyTSXtSUxQegGAzzPRXh2mo2Hr+hIzZORB1MGtc++aQf/zOhv8i4grF9XYg9v4dHAfcqVyCU+JOKK6XdMNXziJ760cdGX91KUXB9YSz8cXSnRBPQTzDTaTbuFxWysgrQcg+gd20cm5VB83zBRGg0kykeqP7qO7TY25AYGEbktieZ2N/iHcFrve+TMPm68a0K5CUMfzwxiu+EsbzQIeq5EBXFBmS2Go9uStslIb32bvoqAkcrI4x9EFRix9d3Eyg2HpfmLsM18c42RVAv5m12ecthzfizkUndP6asPiCq/DVA7CH75tZMDDeJulENEqePMXxkFe1ksEWUsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3E1OfZryech0SU+PSDrhkYcm6Sv1qHqTWhmr4cK5i8=;
 b=iTzAiMb8+0LTt99h+VvPIHOleCnvlrHhrGEqo1qSy93aq9XPRF2NokaIwMWafwFO4UJ0AZJslzSL3kyBC9T4ymeTNdgGeLmyw0jxONWkFjx0z792euEmd6sjqh3EnOflz93A4/vvRu7l290oa37klSMkrkSgBTbnoIiURwpV+DI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6902.namprd10.prod.outlook.com (2603:10b6:610:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:03:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 12:03:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/3] iomap: inline iomap_dio_bio_opflags()
Date: Thu, 20 Mar 2025 12:02:48 +0000
Message-Id: <20250320120250.4087011-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250320120250.4087011-1-john.g.garry@oracle.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: eff4403e-5d56-43cd-cb4b-08dd67a72e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jJ2U0K9L22XROcHtplmVUYDGw8o3nbz8lN8BI3hbhQWsPV8+ZNV9+a86Azp?=
 =?us-ascii?Q?Y+dbas1e6LhJGqSG8+Alll5+qa/5nN3APGewZbRim8LhIfvGbR+mBNrW/4Du?=
 =?us-ascii?Q?GsAt3RSRikMQDm7AZkGh9190Yg/n8MXw7xyylze2Ic5mdYuWcEm5dxIHZ65/?=
 =?us-ascii?Q?vcGNrv7hqDjJ3ffLjX0nigUtdCBMPOvDaGmo8FaiqWIV6OcPNbmzYJ9wvS0q?=
 =?us-ascii?Q?8u0mwHnnvy5MdZYJyQtTQt8OCXivgaJl/igqNzWUXpcJa30hoitA+p4tPxjP?=
 =?us-ascii?Q?nDpeSG+dXoXIVgbIsesE7pHXbIJValIMnxZL2YuaTeIKR7VwzxJufiPRy/X2?=
 =?us-ascii?Q?dhEe5zPqATXPEzg581tcPMaVCPE6OfffcE5Cc3Fu+3r2X2KHnR8Nm6Nt7qkH?=
 =?us-ascii?Q?8DYDwKi0ucJabsEM9dfdg3inLlmiMWIMLAFA29LO/eiC/wUdp47tKSjL70XT?=
 =?us-ascii?Q?yejlCGLaEK90NT/K8MS9PiqIhwzfANvNTGa14oz88jAWZ8tGX9olb7nmDZOY?=
 =?us-ascii?Q?g6vx3K7B+JUal/Sz9jJX2lGQOHqU+lW40qv42pfBzWUqEPzx0J7W0Ns84pg/?=
 =?us-ascii?Q?bvBawM+E8polnz5gRpLvw4MnvV9BKWfm2n02/CzDPX5uzz+HN4qZOh3DeYqV?=
 =?us-ascii?Q?Zlf2x5V6GFQl9RvIBR4PznNvnpGuTMhA/X7utnYvwCrIkuFSo1HCrjQ2cpMS?=
 =?us-ascii?Q?M/mVLBPUrT2qUIah4nFXmFOfKjbxNJqKmk/1IndSGr1JlMi73Rj5AenAj44h?=
 =?us-ascii?Q?W4/yxzd0zHzYvqbtUEwnmpqsZT4yXgdHvzr+9T5hVP0Rq52/j+clWj4RTzaE?=
 =?us-ascii?Q?0dVOq6HeBmiGhJquFcb1pTYrfyw4SM8PAAkHFBQVra2Wl9SGOVLtbgMkpqUW?=
 =?us-ascii?Q?UtkAa5eL5fhnYeAXkF1OwI1bYk/TVK3rQVS0nSW6k4bsprgAZlm+bYW7Fd6x?=
 =?us-ascii?Q?xQhn3G/62yP/uAvBuU936Z2WtTMZ+LLoDiW5nbouCZ0/hvdpD87vmAAn+ieN?=
 =?us-ascii?Q?rFpx84fS7HhtUEjnqq6RMADBc7UrH+00UhKHpvjmXpVphZgLWOOjENmO9gyB?=
 =?us-ascii?Q?mI80sRvJfKRBA4h8T7dpIPmwU4/U6key44uscUyLqixpb0KVPfcBoBv90rDL?=
 =?us-ascii?Q?aIWj2bksoESbG1Xu8I4NOy/qYKPy42QiXFqKFJdEZIFmCFRPxT9bxmL+Ag0p?=
 =?us-ascii?Q?yD/LxxcrjeQas0D7DQaZJ2Oq39cu5PXgPTSlFY6oS+HcDJdzAQ94bG3MAs+l?=
 =?us-ascii?Q?NIkv1KsvxYYFdm11pf0J83UsdeNBgBT29KM8XxCvyl+fct7S2c7/EjWHLKrb?=
 =?us-ascii?Q?Al5wzue3K9Jz5pu3j5wGAFNmryb/CNRzbTQ3Rdh/j2hnj4Pknemv1Eaj5+Kl?=
 =?us-ascii?Q?CBifkaLYjz6tqvZeL28wXRb33YcT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkvsu1eevt/AqXQ8XuacMFoMiRzBgg1QS4LSsWTXwUGxJT9dcwG/CrUgU2Aq?=
 =?us-ascii?Q?+SDK/S4bTFgmVfWlk6ZdNow58E/wpMZiKYJOFF9x8+ZBrWdfFfo4d5X8AbZC?=
 =?us-ascii?Q?YVVrRT6nnvA70EqFw5K6O/cP2niEgmlOtApGWaYgq74BJt8KpjkBZW59eZx2?=
 =?us-ascii?Q?HgzL81F2Y0KBBJIeQC47FrgA78wVcujc0opTNFsmLMpm18oCI5MVquTGiJcw?=
 =?us-ascii?Q?yW74kGpzz6e9I7FTOBE1ch9x5eqj0EXTqDwWPiPTseHPOBFL/BWMWgI0yHRX?=
 =?us-ascii?Q?88IQ/50rQBk5ZQWENdGaj7AJoY7prkZKuVcyWRiD5mtc1i7KS287mOhLtF+a?=
 =?us-ascii?Q?IhOA/oz0va5wSRiNOZpK5cczbnrDw1B4JavxlV3armYHCETLQImRnro5iwvh?=
 =?us-ascii?Q?DIvHDiGQR1Rl51z4uDNMqQ+QzvzzpnIcrrITgONnm5UzMprykLxyK3h3bR75?=
 =?us-ascii?Q?m0+nWlBLuqUl5TekMwZ/KgVJri41Oj357CtfU0KfvzPfdX6G58BYpaBKR35k?=
 =?us-ascii?Q?ZMU0BzkyJymOk0ekWMRlKq6AYVKPnzQ9Mssb9qxd0geIJ3EwW7/PiaSigI0S?=
 =?us-ascii?Q?Zqga/3ETvXTwr9oJhu5RkeFLWItQTwoF+CdncN2EKsMtKmuSJoG4+w6sXFZi?=
 =?us-ascii?Q?KJpMOp06ru5wy3EJPaC0NWtheVS+Prxu1QWMeE4RddZbwGRyTlBsbcfMje+x?=
 =?us-ascii?Q?Jjy+PU5JxQGg5SCB2yQVGFoL362+rv7dbUXwHI0vKHRk15gzXW3YNy+Urch5?=
 =?us-ascii?Q?O6L74FbxTsvhUh+h5rFPLRRM8nW4TyUPJD6l3EzAe2peHeRbpdyGktRfK8bb?=
 =?us-ascii?Q?4hpxjBA3+yGUJtNK+zmtKa5Ovj6N9+o0CMCptRV1ukgClShut1ASHzxQ7r0O?=
 =?us-ascii?Q?tApijrNln75KQ74PXjKcJtZ40W/1znjTFU3hECT2CrHyo3ocs0ICutxU8trC?=
 =?us-ascii?Q?UZy7qfw/it9FpuSWWyXIru8AK9ansXUijK8huyiItZpU0q6AKnTmbpz+oyAk?=
 =?us-ascii?Q?GMHaj/FuCzIomPAeX+84nkXBiKpLHrJpXE96i3HQiydTuOmwJmPS97tfJ+XU?=
 =?us-ascii?Q?zOgXefIbUu2c4ouh5SNWUPmYZ7RB65QwHuqa7KxV28VY2xUrtHViL/LXKwGD?=
 =?us-ascii?Q?+ppmQ+VDs2abpZKkaMWWOY3uTFAGFjkvx4IyB7zJlv2nUkgzA/M7cPhxqjOq?=
 =?us-ascii?Q?OGVLpPoHKCGbIPY7mV+8BQy7Bx3KOgfQk8XiR7P7wbFmiPAKybrCRv7mU/AP?=
 =?us-ascii?Q?hobAg8YTW0a1P4nJym09q+2pYnL/YJ4e2+bZD5zLybyYFzJzdrVrOxCwe5RG?=
 =?us-ascii?Q?MpJpfhGkhZtloMbu4JC5ovJ/A9N+9o8N1sjTwulW96USoo/CgTc6rETNVXb1?=
 =?us-ascii?Q?G+iN42xtyZop8AaAztPBPFGZEKchqv1Ipr2Y40l4baW3Wgn5Z2h7J2i14lou?=
 =?us-ascii?Q?STaEAP3o2lUY0ITpiSguZbA/VE6Ocz6dnrj0LNKjb3eV4bgAsL4KMakoYtBB?=
 =?us-ascii?Q?81fc/sN8jt4gsUBHTKXiXr3Y9RI/6MpzHvl602JF2CZM59pg+7s1FA9bPBog?=
 =?us-ascii?Q?J0YavMIlL2UH4CTCJkLCjghnO8XTWo8obKwyGRt9nTS4gPlhGnYThhwBtR5H?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lgzyinwua7HX0sZcytI5KrLtIlccFORH34+ciuXuSIEBhfjrmLllIRcR1A1q2Xt+FzAAwR6ORX8Jf0FQlEIml8q88bKrA2mJQqf2EPQmI7TYp0a7ug7r8et7o7DVM3w56asrVIbUT67rzA55YgxvQgLPox1sMkDiRj37b+CxFDD/AcU4pKIeYzU152uOWs+wNMlxLt/JJ6OOF3Xgr++aVcBZMFvr+nCYK4KV/hUCN0iL0BFlFNwiqL4hr0g49NmEUrKBjrQ2RtbZu00+lX8/czMucNLUiTpWumj7o+TgIP6RfhJejgZ7/RTOpaGNLEhlLJU9KCRGzcwCIGztvPHYHLKKPtAA5oa/Wyk3yMoG9JIxxJvNz14PQE8aJa2hDMSub7xl4sy69qoJxuH8GFL63v7whwjGQ0hjqJTS1Q6p5GtK5RgfDjg87VHxgdQt7kJLLau9cVsHjDiKBrIpuaUi0kPq4oClNvypFIZNyji2Tpksy+xM2rWuM/cYWcsyh2R4UJHDZYGbOT1LY4ILtR3MmMrCXpiI0SevPEwpkqUfFQXk4NdFk3RiZKNjPW4rPBPK99/2dyRTNbVaJv39Ui77cnNu4r66FVucl3n26SR+Yyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff4403e-5d56-43cd-cb4b-08dd67a72e5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:03:09.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lIT0J9ayRUd0t0RZQRjVP3a0NtjqKic4GPu5yyYpTJjZJWHZD5oaITdLJq1uFo4lIRIaXnzLBLZhn8HSkaGRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200073
X-Proofpoint-GUID: fr7d5ohW1zJufRqqy7FnGNgkxEjRIazT
X-Proofpoint-ORIG-GUID: fr7d5ohW1zJufRqqy7FnGNgkxEjRIazT

It is neater to build blk_opf_t fully in one place, so inline
iomap_dio_bio_opflags() in iomap_dio_bio_iter().

Also tidy up the logic in dealing with IOMAP_DIO_CALLER_COMP, in generally
separate the logic in dealing with flags associated with reads and writes.

Originally-from: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 112 +++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 63 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5299f70428ef..8c1bec473586 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -312,27 +312,20 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 }
 
 /*
- * Figure out the bio's operation flags from the dio request, the
- * mapping, and whether or not we want FUA.  Note that we can end up
- * clearing the WRITE_THROUGH flag in the dio request.
+ * Use a FUA write if we need datasync semantics and this is a pure data I/O
+ * that doesn't require any metadata updates (including after I/O completion
+ * such as unwritten extent conversion) and the underlying device either
+ * doesn't have a volatile write cache or supports FUA.
+ * This allows us to avoid cache flushes on I/O completion.
  */
-static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic_hw)
+static inline bool iomap_dio_can_use_fua(const struct iomap *iomap,
+		struct iomap_dio *dio)
 {
-	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
-
-	if (!(dio->flags & IOMAP_DIO_WRITE))
-		return REQ_OP_READ;
-
-	opflags |= REQ_OP_WRITE;
-	if (use_fua)
-		opflags |= REQ_FUA;
-	else
-		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic_hw)
-		opflags |= REQ_ATOMIC;
-
-	return opflags;
+	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_DIRTY))
+		return false;
+	if (!(dio->flags & IOMAP_DIO_WRITE_THROUGH))
+		return false;
+	return !bdev_write_cache(iomap->bdev) || bdev_fua(iomap->bdev);
 }
 
 static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
@@ -340,52 +333,59 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
-	blk_opf_t bio_opf;
+	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	bool use_fua = false;
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != iter->len)
-		return -EINVAL;
-
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
-	if (iomap->type == IOMAP_UNWRITTEN) {
-		dio->flags |= IOMAP_DIO_UNWRITTEN;
-		need_zeroout = true;
-	}
+	if (dio->flags & IOMAP_DIO_WRITE) {
+		bio_opf |= REQ_OP_WRITE;
+
+		if (iter->flags & IOMAP_ATOMIC_HW) {
+			if (length != iter->len)
+				return -EINVAL;
+			bio_opf |= REQ_ATOMIC;
+		}
+
+		if (iomap->type == IOMAP_UNWRITTEN) {
+			dio->flags |= IOMAP_DIO_UNWRITTEN;
+			need_zeroout = true;
+		}
 
-	if (iomap->flags & IOMAP_F_SHARED)
-		dio->flags |= IOMAP_DIO_COW;
+		if (iomap->flags & IOMAP_F_SHARED)
+			dio->flags |= IOMAP_DIO_COW;
+
+		if (iomap->flags & IOMAP_F_NEW) {
+			need_zeroout = true;
+		} else if (iomap->type == IOMAP_MAPPED) {
+			if (iomap_dio_can_use_fua(iomap, dio))
+				bio_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+		}
 
-	if (iomap->flags & IOMAP_F_NEW) {
-		need_zeroout = true;
-	} else if (iomap->type == IOMAP_MAPPED) {
 		/*
-		 * Use a FUA write if we need datasync semantics, this is a pure
-		 * data IO that doesn't require any metadata updates (including
-		 * after IO completion such as unwritten extent conversion) and
-		 * the underlying device either supports FUA or doesn't have
-		 * a volatile write cache. This allows us to avoid cache flushes
-		 * on IO completion. If we can't use writethrough and need to
-		 * sync, disable in-task completions as dio completion will
-		 * need to call generic_write_sync() which will do a blocking
-		 * fsync / cache flush call.
+		 * We can only do deferred completion for pure overwrites that
+		 * don't require additional I/O at completion time.
+		 *
+		 * This rules out writes that need zeroing or extent conversion,
+		 * extend the file size, or issue metadata I/O or cache flushes
+		 * during completion processing.
 		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
-			use_fua = true;
-		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		if (need_zeroout || (pos >= i_size_read(inode)) ||
+		    ((dio->flags & IOMAP_DIO_NEED_SYNC) &&
+		     !(bio_opf & REQ_FUA)))
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+	} else {
+		bio_opf |= REQ_OP_READ;
 	}
 
 	/*
@@ -399,18 +399,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
-	/*
-	 * We can only do deferred completion for pure overwrites that
-	 * don't require additional IO at completion. This rules out
-	 * writes that need zeroing or extent conversion, extend
-	 * the file size, or issue journal IO or cache flushes
-	 * during completion processing.
-	 */
-	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
-	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
-		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
-
 	/*
 	 * The rules for polled IO completions follow the guidelines as the
 	 * ones we set for inline and deferred completions. If none of those
@@ -428,8 +416,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
-
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
@@ -461,7 +447,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic_hw && n != length)) {
+		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
-- 
2.31.1


