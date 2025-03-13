Return-Path: <linux-fsdevel+bounces-43920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8FA5FD36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B3817D5F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9926A0EC;
	Thu, 13 Mar 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqxNtu9A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1QefpxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD726A0B3;
	Thu, 13 Mar 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886021; cv=fail; b=EYR/X0ISuUPPoEBOBykHUtblUhuR4ckdRnUysWo6o7lqh7/2F+E7XK+X2urmC+FSz/CavoLCZSFRtMesqwQnYIRno35eA5NR3DFj6EFF4rq+Iy7Irxai3dDVhv7+IJL9kZMIBkn2BdmIw0tdcGSMizA5fr2w64URhDV1XP/1ApI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886021; c=relaxed/simple;
	bh=+4MSbO/tw5bH5vVgvJFcVdI5Xp+giwe7wqy82FRgQGY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LyF2GehmJcuW4WJOKr7iQtw0N8QIZdHclaVfTKMecPTDA5g79nuIGsHj0bG46U0KChxKIKCdxXpibWJSXtNERM1bfg/4e7sLMZa05nRiE0fU4Qfgcmt39hWk6V24bhnV9VhyyYDAwN4QJu1BbDRfBRKXPxrUhX7YDlFZSFeRqYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqxNtu9A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1QefpxM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtk44014266;
	Thu, 13 Mar 2025 17:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=k8TF+Jc6iCu8DcIo
	3XOC6cMOnTjos/mbZ+VGwVrWMZg=; b=UqxNtu9ACCBFZytSxATYi1PHgCaunzL0
	lBRJF37qZaimVPic3tFS9g6Skr+tmMIiSUeQRFf9w87DN1cJRJ/7cAwsZPCUXmJi
	ZDhaz2PZ0HxXRzB7iego85UMT1xsbqwmcnGQWgEvpM3+ulvke0xOLZqJ4mWXtZzZ
	+YNo6CQYVWsOrbekvO4M+nV377Zz1oOiw86OhXCfdJ4dlk1ASY8FMmSV818URFBD
	ScfdGfhF4GXR+InwBmJMfFF5SMxN/xYqJ/ykqBQqVInSvI0e0Yt3w5GLpcvg906t
	0hVFTvUL1P9j1R6lHjxp7lVzZxQo8+V+3jgBC3ET5QI0AILFtwBi0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvsnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DG50Li019547;
	Thu, 13 Mar 2025 17:13:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXNr3pvYPCqS1m+o6pb3OeUU7QxtwWMQOH43TadcGUBHUonZI8sAZ4btbK6Lt+g1KcL7VBHqXxJg5VRKkCll3bz0xhhwu9Qmjdx2HejTmi8nXUCJsym88uZCU7q0n8Cwepmhd+8iGY2qB7Ppcx65sKzSaayDs69fYnVx4qqHbj9CM1pQjDLeA1iWuS2fUs+ukFQNun5b6+85q+KyZNNLhfIs/qrnPfHV87ifFDgjw62HPvsWMYobDXZlTIzaTShlmN7y+H/MjWm2arBd8K2PhZckblCAV3vpGmjPmOKxRZZpiV+Xcf8yYWMqkkAyKEbDALnWsk6wPCt6lLvYNcxPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8TF+Jc6iCu8DcIo3XOC6cMOnTjos/mbZ+VGwVrWMZg=;
 b=qqk9I4kO7r4ZNNQ66CKsZeEvVsSaIInk9j6A4RVgK4ffsM6dkNoCwW2XaQ52/izD0AycAqJyYbgPIUJC9tDxoGX+pAbGodTqfgdFwoZ7qIb5eCg9fdta5Aes7Gbyet4sUj4yXDPT85TdKBbyFNbaqI6K8ba80M8q/jMEM71f9XCGg04AxA3SPg7/l9NwFyZt1pU5HAzkbLJ1oE3vQJXHU0KDJsKTm++c7dlgsbDqAfc0oTsmG/+TjVd6j+ks6ZtDWUjqA+tqCuzsK287FmzJJplA2llZamxj0ls2bm7YYyXscUqhTfdj9oc7GLJ5ZzrzruKNv+3Y+k0JQ89n3MqEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8TF+Jc6iCu8DcIo3XOC6cMOnTjos/mbZ+VGwVrWMZg=;
 b=J1QefpxMFa/7am7G3WwOAxlblZvRHhrep8aOQKOBg28UnYMChPvexb9lhI2Zqa2F0OClofh8XpBLLoZ+fEbJ8gi39VwuKx2+hhrumpJyQAmjAai9fzZfETRaEhS+LEwWExT1ZSIGOqzqj6JD/f3Ef3mYPeapXUDNjx4020C0/R8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:13:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 00/13] large atomic writes for xfs with CoW
Date: Thu, 13 Mar 2025 17:12:57 +0000
Message-Id: <20250313171310.1886394-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8359a43a-4b9d-41b9-c32c-08dd62525bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9JRHXeVS6lIk85m5fajfLVqqOlmlIhsIyv1Qy4dTQ21NwgX9gGLtaqDKwO5g?=
 =?us-ascii?Q?Q9FiJjWtQ/i9gTTS3beXjWgs38WDI/DP2I4fk8Vr0y0qr29j9CQ3atGntnmn?=
 =?us-ascii?Q?CNf9OJXb/VAhCuhCmPbxlXyzzgk1dPA/8m5m+YLX3NPLlzXqrcsFPu6BLXKf?=
 =?us-ascii?Q?pRjo/dZh7Zux5q/W5eOzYrnkXrStZajLuVQEiuGMceOorpperR6S29CCiEFL?=
 =?us-ascii?Q?wz58B1OLB/MlPr9wJnPK8WedfwaPbVAVrEWMCRP1Psd5WdX4Wn2WyRsnqJzY?=
 =?us-ascii?Q?7FN04r/vOypoZQAhofGzI3K+mvNnl1eoOtOmV/f356hVAyucwLTp2vFesqMz?=
 =?us-ascii?Q?1/G9hn5YutVhw5XVyoOoUnRSRoTXutx4bZmdxiSv+7xwNmvyQ8ueGPdNWELh?=
 =?us-ascii?Q?rVs2XPeJF1q0+B2Er/2HkHie5yNH4PaX5MxZr35xf5jNnID6xwNWAuBdCyw5?=
 =?us-ascii?Q?nHH8ZId9uF1p4m2b2rkWyNtFZPf7tXEyiRhRWCEgiNkdIodsNu/KJwt/nBcd?=
 =?us-ascii?Q?Mcbf9bG7qRP4NRBAS0tAQxAMxrpYuHZeNJd7K+k/90u/inoWWbee3s99R9on?=
 =?us-ascii?Q?mSV6D6QV9iHpBF1C9CgEorc7Se0MwPeD0pXz0WITMRMTr8+v9kPyFCW/GMJ0?=
 =?us-ascii?Q?YPqHRnFSO/Ot7hARpj42JbfvjTqCG8PDz8F0yM78SCp9SSO6Ycj29sbOi7Rz?=
 =?us-ascii?Q?r3EdDpAyO1Fmg5xIdLw4BNXpFrv4U5oTJ4Rwxrm12Ssa/PyB7321Bj1DN6vR?=
 =?us-ascii?Q?FHKCjJvfK9Btugeaey3SG2mol5I3SkrdRzlhhzuNi2f6DqPplcfKa5mWdYhF?=
 =?us-ascii?Q?lAyjQiDcHCMNVAjWP3NgfT5nwfAWcOwib+OOUwBm8yGIn72Jxll04arq2/9R?=
 =?us-ascii?Q?OsAaw3PHsPJ1rmUTxEdFor/RKZWEUbgzJfAny9ButI1Du5UUoYRZgk8d+aj7?=
 =?us-ascii?Q?OvLq2J8MgGW/XPPuw9II6qNeo0LEi1LD6+qwk/2B5m4QQVksV005mASlzmkw?=
 =?us-ascii?Q?N4lRdYeL4WuyKi1/dnDrznnyPxvxd2z7tBCJkbyKv+EFh6YhLMeEPN0TWTAw?=
 =?us-ascii?Q?U22GhYvvG85rLJ5a9VP0RF0OaLHoqe3CVdIQ6xKeo10KSF1UcvsrBwllqCXx?=
 =?us-ascii?Q?g3aN37LwuScHA2kYaP/F0FfXrIUOJjl8gnGRnygyphT0htCIJRxeK0L2QMoL?=
 =?us-ascii?Q?UYgNgrIHnX7G0qjiX4HYMFSe7eJpibyPFgG75t+OaUlObksyKibPxnEh4ceY?=
 =?us-ascii?Q?QLIlzHLTIfQVGmAYElRE69uowSye9cN0Y1yxmKfcyrYVTHzvJot5JerRFyIL?=
 =?us-ascii?Q?OENh7LO1OLgsq96d+u1uQQAnaa0YIRXZsU3yjHglGlCsq03r5zvNe8b6Zg8p?=
 =?us-ascii?Q?PMVjoFARkkpr8PpeJdIt4U2Zqk0b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6O8fSDpINmdydCT6R2Pv/gmobZZL4E9rcETwi/Y3csKByrxRxWWDm8fGvUu?=
 =?us-ascii?Q?LJupgtf5ktuRnQUN9xvarz/g4pBRjzEC6z8bpyK8rTOWrXaJliy7bwzxVt6O?=
 =?us-ascii?Q?VOYjEaN/RLcLpUrI3GyxgrS9pr3HQO8ImgCJf7b3RpeE87eoi5hsnknxRfWA?=
 =?us-ascii?Q?0shl7xsudeOdh6w/Lq8NWenKF/8Ty63Jz/FAQRAaS60ZtxEhVbQG6lFvw8Oh?=
 =?us-ascii?Q?FRk69AvRapqfNRAdzmb+KKk/faemHUXukySimZeNOJ876U/5iUS70CIXZ5EH?=
 =?us-ascii?Q?G6R7XKN3EyZ2Nn+ZaYDl+/MeUZS2mNl2Sao6en10/7b8Aq+W6JHmZ3USSIoe?=
 =?us-ascii?Q?M7FLNGudurpcFNCzbnJdRN5xvKn11fth3BPmxcJWJ3y4FubwDCbbBH2P5x4/?=
 =?us-ascii?Q?rrDZZyh482J8vuyOxduDAh52ZMh+VR5JUoQ9qmeHTIBsBkIeissMgMT273FH?=
 =?us-ascii?Q?zFhbDFPKpFJMZp3hT8V2bchax0T+wnClCkaNETXMnW26ehyl+tVsldQz1hva?=
 =?us-ascii?Q?mDsHmwNJ2XK7vzZlCRliDknLNfZm6vvUsYNEccGRcjolPVJoUXOMWQwKErRK?=
 =?us-ascii?Q?XMvB6whEpTm04i55xHUIsdKCCiCq12XnSfNw50FTBvo8W76CqMnN8qCEIIl2?=
 =?us-ascii?Q?BdRqeHHU6QONSPdaiAUp4AnRAB1URyW5RAmpylW6bb2l5KFdSojQ/1cT3XtS?=
 =?us-ascii?Q?UbRo/T90q3VTb2YQ7Eayc3ovGoJ1enK3kVNOhwQcgAGLGEKhCjmXRK5taPgz?=
 =?us-ascii?Q?Qmo4M2jDMrBvcDtrL7DSuA/2EJPHKqn7oYfFPyO1kia2MG4tVGBfeG47HfE9?=
 =?us-ascii?Q?5uQaHxrzr9NL0KsRvVFShi3KtBVJUmlx3FLInKnLNgE2ZPDHDjlo4JQ0xRNA?=
 =?us-ascii?Q?zninvIiG+/cuu2DDpP3WN5g12+npWi2r0BenYSORxwVE1spH7EdM9yK7799y?=
 =?us-ascii?Q?bDh3QdY7FAQ41qHFSFs17qR4I1Pg7NthSvrPmc8L7c9asXo5h+Pj2hCA0YP4?=
 =?us-ascii?Q?Q1rJ4iTInQrn4iK4gti/DRz2YCexCo5LIGBENVdxMFEIhTMd2ST25BkcUyIl?=
 =?us-ascii?Q?xt55sxf534QBbEhgG3o66ScD1wJv6F35P3s1ZZFG0v/uh0H3L9833AffCdo4?=
 =?us-ascii?Q?GkY0GgmMp82XWtrzXCi4f8xb6YmMw0khYoElQg2PlVslAPje2roStBVKSFAl?=
 =?us-ascii?Q?XZB1Z+2FpA49zF+F+uWcvtGFeBZcTfBfzWNYBC5ihnOiEl6+9QZ2dMiqPmTk?=
 =?us-ascii?Q?06+IEhUDAD6qapbV+zstGr3+/vLCBvpqKU2OC7Hmv1T5bq3W5+XAC3S3y81s?=
 =?us-ascii?Q?AEAkqvWauOitRNqUAgReNeDpKLxUZyWDhKdNA6rL4QGNQA54izqhcgr2I7vB?=
 =?us-ascii?Q?i6mUEjMlleJyL2x24WkK7vao5mqYzMCRWGE/mmD6a/FHxqevXqFfgTABkWH6?=
 =?us-ascii?Q?P5Nvae9LG8p4/eqN4MOaebBxegUzTT7yUY3mCA8+MjKJ7vx9oE6zy1dVEOJy?=
 =?us-ascii?Q?u4hghAuCBb8ZsyqQjd6nVh86WKip+KdOc4HKuqH9d5VH0bRDU90aXg3QKF/I?=
 =?us-ascii?Q?kW4RyUUHf7xlfc8dEuRZfvwOVWxXIllmywwdvlqlURa1H8fEdNNgOcR6Ycmd?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LEbz28xkwiPsHpA+LhFcUOBcYyII56LxDHyNDoZv+7fMby6VA5+F6/J75QPRtgd8emdMjk8jDkImmqr7J6/t0kwCA52tYF8Sx+MapKveJAjicEaNDIIftv32Avg7QF/6yX3UNpY0yqXnjPMPznAFN/XzFKWQ3dlL4oLHzGcQX7MuMbmA1DQTjIDcacWTyCBa65y0j1HkFEFXxU7qT0q+YhdimqctO82ChRYk6rNHqeVGUU8kg10AIJVDjG69k/7aiiztqIv4XSfJXLXw7P/d5p3ngT1kY5wGQziemNDjbK7eiv8HmUBwaxyYGkip2rjtFzfm+5HPhLPBLDiGZ8yMwU2vQdhgurHlVTGxuu61r6vEmhgnrZdRvmvuzQPT2TcW2N3UwTRYdfZJ94SJX+3Dlg7XM9WytoV198OzEL127w+8SmSvHHLXJpW8Cm/dCkCvVpSHyvZmOAbM/8LgLw29MNQ1fJkEOJ4yTTj0HQ0z40nNifyfLZhyGHMNYrh28UcXQfZEJiKHu7qKEhy/0PQVGbZIiJUry3ImL8FJVr9AUq92owFmin3s2FN7pYDKvIxOc0Sz1YI1aUAk2kSFdZsvyNRBv+7CitvLJsjMQ3vPX10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8359a43a-4b9d-41b9-c32c-08dd62525bbd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:22.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4wkeF3vRr7ldWe6UVzsDuqlvUWoqPpjcDi2IUdvpQl8uyQDMQX9R9j5/U/pRA3ZgSmb3evFRgnshtFHA10aHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-ORIG-GUID: Qpf-hNMVmaEq0mrWhiEKisGcxX3GqUu_
X-Proofpoint-GUID: Qpf-hNMVmaEq0mrWhiEKisGcxX3GqUu_

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For XFS, this support is based on CoW.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on 4c6283ec9284 (xfs/xfs-6.15-zoned_devices, xfs/xfs-6.15-merge)
Merge tag 'xfs-zoned-allocator-2025-03-03' of
git://git.infradead.org/users/hch/xfs into xfs-6.15-zoned_devices

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to v5:
- comment on atomic write checks in iomap_dio_bio_iter() (Christoph)
- inline iomap_dio_bio_opflags (Christoph)
- many comments added (Christoph, Dave)
- reorder patches
- rework iomap flags (Christoph, Dave)
- add xfs_get_atomic_write_{min,max}_attr (Christoph)
- add XFS_REFLINK_ALLOC_EXTSZALIGN
- change XFS_REFLINK_CONVERT -> XFS_REFLINK_CONVERT_UNWRITTEN (Christoph)

Differences to v4:
- Omit iomap patches which have already been queued
- Add () in xfs_bmap_compute_alignments() (Dave)
- Rename awu_max -> m_awu_max (Carlos)
- Add RFC to change IOMAP flag names
- Rebase

John Garry (13):
  iomap: inline iomap_dio_bio_opflags()
  iomap: comment on atomic write checks in iomap_dio_bio_iter()
  iomap: rework IOMAP atomic flags
  xfs: pass flags to xfs_reflink_allocate_cow()
  xfs: allow block allocator to take an alignment hint
  xfs: switch atomic write size check in xfs_file_write_iter()
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: reflink CoW-based atomic write support
  xfs: add XFS_REFLINK_ALLOC_EXTSZALIGN
  xfs: iomap COW-based atomic write support
  xfs: add xfs_file_dio_write_atomic()
  xfs: commit CoW-based atomic writes atomically
  xfs: update atomic write max size

 fs/ext4/inode.c          |   5 +-
 fs/iomap/direct-io.c     | 125 ++++++++++++++----------------
 fs/iomap/trace.h         |   2 +-
 fs/xfs/libxfs/xfs_bmap.c |   5 ++
 fs/xfs/libxfs/xfs_bmap.h |   6 +-
 fs/xfs/xfs_file.c        |  90 ++++++++++++++++++++--
 fs/xfs/xfs_iomap.c       | 141 +++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h       |   1 +
 fs/xfs/xfs_iops.c        |  40 ++++++++--
 fs/xfs/xfs_iops.h        |   2 +
 fs/xfs/xfs_mount.c       |  29 +++++++
 fs/xfs/xfs_mount.h       |   1 +
 fs/xfs/xfs_reflink.c     | 160 +++++++++++++++++++++++++++++----------
 fs/xfs/xfs_reflink.h     |  14 +++-
 include/linux/iomap.h    |  12 ++-
 15 files changed, 499 insertions(+), 134 deletions(-)

-- 
2.31.1


