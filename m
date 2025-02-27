Return-Path: <linux-fsdevel+bounces-42777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53653A48778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6B3B86E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CC1F5827;
	Thu, 27 Feb 2025 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IpMuPlvM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bIBGnrHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093426E97D;
	Thu, 27 Feb 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679742; cv=fail; b=cGj2gmgYLmHf47mlJUxtk+v1Z4i2HUffAR/nJqZ38OEcziNQ+YxU/UhUDjHmmZDcp5kQnyThyCsoTwjkBz88weNmfmIjl0K6CPQuqiaBCe8Va0ycmgDfJygDRieGvsjtWIkDQC3CssBc8G232L264izj5IhMwIQy5RRhriVxY9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679742; c=relaxed/simple;
	bh=Ew5mmVK8Q58H3hyOE3GF/xUDrrAIp6SiKFKY0WOHiKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOokr+V4qWHnMzWuiZca+6IRoFQmRcayi+QIIHAfjquIl+PKGz11rhBpB2nEJL9WngSct1oR3PXgwDG4VGoVeqGlRXBwZPIz5DdycpWHxBRvh1mrH/aDlHlyL6f0cqMJd5KaPzBxsernxc/vwcV2JPsyk9q/1RrftNBXZHgzH4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IpMuPlvM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bIBGnrHT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfiuk016050;
	Thu, 27 Feb 2025 18:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=; b=
	IpMuPlvMZ8hjntYS9i4tG5AOHGInxpMAMzRBBTux5byxg5rnyADxrIrDp/kNkj8d
	5zhRdKbMc/BCaWTAo67L7x8R7Cj+GVnkeV1E+P9xdeLPKgtc0ih++1OLW1A91cQG
	VaU+YRvYcGqN25dhzyW/7bQ/ldFIpQo0E+xR2PqS0Fh/6o62U7WLLNHV0Wdga+JO
	s01k2zAZGIuCDJBzRHKENyPTJ5RsM5GJcxq869zPDuD6/xZwNPIzGqOEM8iFpUNy
	BVvmjNPs5tJnim4Knx1RekSZUMbUhIqde4YHlWG1Om2wyiUrRTo40kvsAL7YhAkI
	pHuTemh76/3OUPCzPlNr+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse407w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHVKR4012522;
	Thu, 27 Feb 2025 18:08:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dqknq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGuOh9+6S7N0eXXu7wqXW6hyxG2pEZgwkYxkhQnZ+Wzvtj7MzeHLmZg+m8wR9mtsuXCnVIySmjIllu/dnlvuG7qWaq6PKLc6EvtCKve05yibXlunoKbftT1+Y7T6ng07WfRIkhz5/IXvaTdnfXLofptxDL29d8YddSOkgUk4rM2Q41gpNmaZ/St06xFMu67NyX9v0TH7kaWB36BJxVEHyORQd2WIv6UwgJSWicNq7Fi3h+JJvTBZmj7sAw65VED6HsGM5p+whZd/L+d9dLFzsH5k/AIoRC8VKavLm/KFlGqYBIHM8U3cgs/hxuwqmtFkMk7Pg9RO05WdRSM76+AiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=;
 b=rlAQM+Gn+4MaXQvJTV0MX0g+ctw1Vbv6p6s97c8rboMofi0YJ1BdgVMcw/xQK3TTPL2FaQmhPvuPTVRpLFBiCvcavFrLo+1j0u9SlH7nCVJpwFiJG1hGAE5JD2d743PwTbYu4MQs4tamGTA5DA6V0FAIVKIQ7G9kh/+tcrbtvZ8Tc1P8ccUPA43WGt0G2cNP0qSyVKXVzkraIdEiCnr3uCRh9zjcb8c9YbjNDe1dAW7CXdM3dR5ME27pZSH2Ar1V0KGVBrFafkyMZ9XNpSz7H0ztuP0NlDhUyE0JALdc9iSRNPcjnZ+8l7Abmqq61GtwHq3eBPTNm2ywWfhA+8BQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=;
 b=bIBGnrHTIrKkcv6QrvRezj71+5tLA+9zQScfAYIymswj9prV4mBfyCb+m76ItIxrFb+ynd/39w4l2LKa07kiXfFMwNqsedinb3zQo/qGOwUr2ZD5QGRgZB8Q09Ao2Sk/v9SiJ2vHSOeGmucucS1uHcJH1+iZFfvHEzk240L6jXw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 12/12] xfs: Allow block allocator to take an alignment hint
Date: Thu, 27 Feb 2025 18:08:13 +0000
Message-Id: <20250227180813.1553404-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0380.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: eef67bce-a0c3-4a5a-a158-08dd5759c888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8miQUIDRkOTfv0g/tF1BLR7IHGLE8qi32d6hFSiTctO52MJqWjlj86Ff2Ko/?=
 =?us-ascii?Q?oiUh0MnsK9k81+NxSIWMfvxFlCmUoeqcKCPlypSe7OsUmrXgZnbGLkVbyN/c?=
 =?us-ascii?Q?dmo6wfkT3kWsXAG//ppxKepYxn52WcTlLwgY02qgGn2NoSF3qzvko0GJV1fk?=
 =?us-ascii?Q?f94xWzBwMQ+InBEkXDeRQVNuY6HvAnezL5LJtE7mRvyqkkbJqfot3pr784g9?=
 =?us-ascii?Q?1ji2vxTqiO2jTapx/t7wdklFC1/xZ6dsXGF3dsvx3jecJuYN7isY6ZmExhHZ?=
 =?us-ascii?Q?kkRWq0FwG2dWd5cHj0CVB/LZEBO1vr/JoMMVa/tqX1N3BBI3Ij3HLP+k7It8?=
 =?us-ascii?Q?B5erIM4SxTg85eMG7EGahR7zz5NSMPpXiO7wKokmOFWOCXaKcgdspouFGgOm?=
 =?us-ascii?Q?/8oDPWxWFMLMRqxvqNO8yq6eDP84Dchtt+xCIZ6TX4tkZ0y+4PjFHm1j3bWV?=
 =?us-ascii?Q?M6o5WPoaV3rjREpH/LTtoeHSOLvPVpZ28Uqvb6KB02BVMmLnkX9C/f8Y1j4l?=
 =?us-ascii?Q?lLZtVNvt2fn2q7NvjNvoJbHbH991mysrXgCUBlKyAgbyLD8mwhiuTHScC58y?=
 =?us-ascii?Q?9JsYI/vInvz7SJEwqN1h73SVBbw+/wALZyn6l4XFSpjT0H2NBrHf4lxBX37C?=
 =?us-ascii?Q?glNoHmACB/dbNldQi6esixM8/aVNqkPq6afjUi8iEB0r9+IiL4DumVeXC+rO?=
 =?us-ascii?Q?7xyeCe+qdw4J88FjCT0UIBDHK2x+6DJ5tIp0ilZ1R71XgYK5BhLv7i+O3QJr?=
 =?us-ascii?Q?Qb809WeCGl8LLqf1yMmaYXmM4GkI10RBqpKL3R1w6fJe5ruQ2fcavzeF1MRz?=
 =?us-ascii?Q?4uKbmdXCREPRz14DHBjRYZJdPjjZYLzR1QYzkNfvLKv6vI6e8TzbnOipr6KP?=
 =?us-ascii?Q?gOv9/Cg8SmRxER/FQh7oxT0QTvvxrvLyy02YF1zwA52jPO8BYke8z2sSxkFK?=
 =?us-ascii?Q?yECVUuRLqPwa+AB9YWMi0VeNuApXgp2FKYZGZoZpuW9YAeSgdJtUlYfvtmen?=
 =?us-ascii?Q?nXa3fltTNc3SRnfTTOlD2xoHZqheUobp7rm4jzEzR593aC7rlj3A1xsqaS6d?=
 =?us-ascii?Q?7m3GHV+stUqHqjpPzdpOSNm0lkzVpEYIC02uH7rWERVTUY0YjIJWpTJby5Zg?=
 =?us-ascii?Q?WC/uza74Frpg07b7fEwJPrefzvvEU8gLzcx5PCLqLAxlJ0AesDc3FkVcm6To?=
 =?us-ascii?Q?UVC67NBVKgBzGKPACdVXfbMefl216ylpSgrq+p+LmPlmXe6o5ABYE+zr3whQ?=
 =?us-ascii?Q?27Q1hd4vGc2lVMQyi+mEQqJ5GcO8fKJiTmT0uSq2PmA5JnSJRNmh9y1Tj9xo?=
 =?us-ascii?Q?11P+mS2wr3Zs2KdTJivfpss+YMetTpGVAxLiwojd9NufGRBp9e3AuWyxhqGm?=
 =?us-ascii?Q?4a4+FMPRLz+dhwrsCRs2CMXaoMqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivbXHubwpM94bTNeg4WhEWQtgYo/N4qmTywo4e1GSKdRSO/J1Ygt0BGNRj92?=
 =?us-ascii?Q?HtRcBzDDcEshyf7elaDxkVv8WFVXR1V0pjOKFr7hOZraSl3NYQCeM4W4EEjV?=
 =?us-ascii?Q?CrxOu/GkzgHozx3PJiLmC9nGp0QsGiF+DQv5hTm63IesJcAWprY6g9Yp4o+P?=
 =?us-ascii?Q?NsZQscWcwZGYZSx2CUhogKtfFTCjkdjq7mSI3OYIk6Ta08CrfVbakcC4RVhi?=
 =?us-ascii?Q?eFJ6Xb4OIGh+TeOvaY5JfePkHhTTvYkVCKZoEsNl75AhwPNxFaNkl7aNMtAF?=
 =?us-ascii?Q?+aA8xv7CMBpBnQbcKavpW0yVDCiS+LzRAJtdC1p5VUt56hZa/OWTlqUhRmzN?=
 =?us-ascii?Q?KEltvFNwXBiTffr9Uyz+5olw+hXgHKJqtfh/FlKMx6Bo+aMFeag+Zvm43UJF?=
 =?us-ascii?Q?Jf/OrnqDj2NnnKxMGf6iTKHg8HcAjvmhp1EkFZXAZ0If9thGek6anr55PkO8?=
 =?us-ascii?Q?FuPRIjqXBC/v1sLpw9PWORkyo8pKuuFw5bO5sCkqhgkYk/wvK2e+Wn5TjT7s?=
 =?us-ascii?Q?E6P26CYl2iMJIrhxQTf/Ht+tGkL41DvpnChLTEVFwE1DfGRdm2NKCQsT3VSS?=
 =?us-ascii?Q?i3ZxIT9rM/MYlIRYNH+BXHFS+2mtEl2B6W4f5V9H5or+ElkJjZRVj37oOT+A?=
 =?us-ascii?Q?lxDkgfqet/Kw/1r1fmfAEpdBnq6F3AOkFgd6OIWWbL+AiUO2O7bpNQ2WjoHM?=
 =?us-ascii?Q?r4S4B3e/wrPCuEri/Iv2Yi2lCvzrO+bEeAigAqZGk2iNDYJZsUtcwsam5sTP?=
 =?us-ascii?Q?+5V5sYU0geVSWrVqjYXTMxpMC2pqcb550v5Mep+b2Ku2h19P0s4e5yDlwP1D?=
 =?us-ascii?Q?akNVHdFe3Rn1hhvjxctfeRcoIJg1huhw5pOd0uetcwp9hOB1WUw34MipazO1?=
 =?us-ascii?Q?KcOEwIi61x21whKOWjebBMVmnlVz6SW4VDGZRKxHW8KRS3Vc6Yk8GRdxsYzo?=
 =?us-ascii?Q?+e08Z62aekG9MLi2HnpFyb3155HG0/1H4uXkEhNGAYh38IUYgFpG+UB6UAsj?=
 =?us-ascii?Q?x540173TTG9PlFUc2OutSdSUwXvlKGXJhMuyxdXCdqkEeLPFn/IDKeMBOMO1?=
 =?us-ascii?Q?+W6mdPO7KzqdKQytS1NdPNrCpvytqGtcBKRNQJG9N9ayVQEqPFpB0j5HfrKt?=
 =?us-ascii?Q?dyX7Z1IXGZRnxcrxzUvYIvZl2GztkTzoaGOsWFF+FcLDGhNMmgtXamsDs+34?=
 =?us-ascii?Q?4IZ/B30cW49ZBvUr2eHn52B9rpIhwYSt4H6MXH8nDlv++638LRvGts5Hydrp?=
 =?us-ascii?Q?qmtgDA3Oo/501LodW+NrLJFU3FqMBdXfL1WyT5PSK/l8wvpRU5hSSt1PlFQF?=
 =?us-ascii?Q?nwLYBuP6H3RXv0po95BRHWxY3zMM8vgnoV8HkD4rwnMXj+KPTw4XF+rs2JT7?=
 =?us-ascii?Q?bTPKAxTtiCGVAdF3qvdnEM127tduPyqTUKmEcidOGB8Wi7sXmh8NkSs+wEzP?=
 =?us-ascii?Q?LmpmHcWRc7Ktn3YPw+Bd3SsbwrByMaBIN3vka/OX5S/tBiK0ipU0U6oEK7M1?=
 =?us-ascii?Q?fkkVXzfDdf9jgJszwFUmDkFe1+Y6kE8cTxsCoZKcit0tPmzw+OMvCLdbHpyQ?=
 =?us-ascii?Q?q8bGG9PQS4/7OTffzQcnBeZuf1kYH9ZWAcHsjVh4qvPTQ2x2VrxN/g2D7DVu?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iu01Z5AevwxhuGBNrzKXhm+F3QnmorXrm0My5tR5hlgCBbbV4I0olsGM/sBABe7mZQeNP0t8ELZGXhHKGi+eO1qeQ+s22qpHWd8IhwHHS5jUoAcvDjXZDn2zo6n2+5AkNyou88ivRWnwPVdbkrRjDTIB4KQmlzKunhCTfX7cBaKqmylVNsTgMw+QYL9cTlOgj3mb9v5x50iEUtbosSQcHWP7QKDpklfHjerhxK9fEjG5XzMrukDj6tL2eFgj80GOCppBZKfWAHIZdz92xLzbMkhQbMZlUwLI0OtQZSZ2Nm2mQXoRyYl37Xo8UyN+3RFsnOVuSqbRtT2O3j3k9J7QA/tv0jGjISWWPs+E8H/y3/GW9I5FgHm5mceZAAO3BwuSR9vnMxt3193HPrRw42+m9K5kBK+ky8uFau5oJ3sfyqDdenTp+3AQsPgL4ERuuTLNIk7+ki9IcTYua4xNyRNa7tSRmINMo8GP6MzuBafc06zxx5dG1jhPs9jXrplVEFIwEd1M0IM4ImzqiPCI3bIF0r5HMJKObandoTJQ4RYbLno0uFvNY+qfJaTjQEUr4bmVvEj+gvLj72zkRcU640/P3VB4QsEUWO+rcXzKIxKiV30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef67bce-a0c3-4a5a-a158-08dd5759c888
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:48.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHwuaXuAgtjhpD6201MZrcLyWNdEgNZw426NRbVzVefZjdttGgUVRnqkpeLCAiMFqvGdhDrr0WbOQJTMyKojhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270134
X-Proofpoint-GUID: YcHLTEcB7JXmc6r7T2Pq3nFsTnYsTDKn
X-Proofpoint-ORIG-GUID: YcHLTEcB7JXmc6r7T2Pq3nFsTnYsTDKn

When issuing an atomic write by the CoW method, give the block allocator a
hint to align to the extszhint.

This means that we have a better chance to issuing the atomic write via
HW offload next time.

It does mean that the inode extszhint should be set appropriately for the
expected atomic write size.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 fs/xfs/xfs_reflink.c     | 8 ++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0ef19f1469ec..9bfdfb7cdcae 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
+		args->alignment = align;
+	else
+		args->alignment = 1;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 4b721d935994..e6baa81e20d8 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 844e2b43357b..72fb60df9a53 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
 	int			error;
 	bool			found;
 	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					      XFS_BMAPI_PREALLOC;
+
+	if (atomic_sw)
+		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
-- 
2.31.1


