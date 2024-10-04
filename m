Return-Path: <linux-fsdevel+bounces-30944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84A98FF96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA39DB22964
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12E14B075;
	Fri,  4 Oct 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVssqkJr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WWVynBZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92ED1494C3;
	Fri,  4 Oct 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033836; cv=fail; b=lRm3SPrPuFjatxiZhcWWyGo4Ey0nGbUTEY/to3mZEl18ZWDzosdnH31zx5Axl2Ca9y9nhH/RwhnyL5uoU/FLGLVf9s58kv6AVbhfTRmlG15xjr6ChmH6gE+p6DiBw6NpHdUz4WCRJ77G3tf8CCKd5rEB5rcX1I87VX9M3meszfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033836; c=relaxed/simple;
	bh=m4fx0+cCtC52nY4lgOxPzkNwkAToDONzLOcOPTArYK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKuIIdY6EOqv7/nPUif1vJnRxa/FRMkAn671+9VLxQHThxgloIIGrnqJIrPtEIILlBpA+tWaWExqDIH+ftTImyq1gfi9GXA3gltpnOk69MXt3fbyLs0WJ7uOT3otgBhC+jirs8qPQRNIaQxIkxzLCH5OuGlE4xnOQW2orRWebPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hVssqkJr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WWVynBZ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tcAN015023;
	Fri, 4 Oct 2024 09:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=; b=
	hVssqkJruoqk8BN9Iw2n596mIbRkgr6nTOq8bUySxnNCDcKw+SE7Riv94bjuKoiX
	uglLKkuyyzE+ED7FSY8noxWk/dmRlmIkgmqhf6nLlPylfejurdDnwROEUMVCBeM2
	YmrQdhB9t1LkvmfOArbL6vWksu2fPPl+Stk6MxaamuaJUxmbSZ9EidFzTlhG0m0V
	gMYsE2YcAg5xl0PBpO4dpfeMkDoFEmIlLOpsdVRNp1SsXc4NP4HRAZ2n0VZJTxQ7
	AG3o9g2shkI92UJl3S92+GL1P0AcbfIiRYKw7h/BZCQFjCkwEuF3Q7k8dRyHPdrj
	Cw7sOPs1B2K42NXyIZ9ngQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42206m16dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49495IE5038110;
	Fri, 4 Oct 2024 09:23:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057118t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMetLCU2V61ILkNH24E8EaT2jyUdFNMXQkUnG6ezonqVpANz40qb3HG5nAYx0uDCzhJLqMq7WhbxSrjn0iTMoNn+lK+mcLDqyeAkHM/93qvfpNg0bx+Ua2c/kd/UGct/hT9UfB1SbX6XcbTJFxBdI1648vqObv8MnKmMLyp8PXeJQq+TQAh7tpyTci6sPfPs3VD/EfQiugiOqrmqAySD+u54hPaUleE3+MR7bOyTMkChrAtgeQR4CyjyfyFFsztJyFHAwkMaahmg+vZSx8cx2UB86YgVPaR3Z3E+dezrqI6QL/flBvKW52pH/f9b3/Qz3DDjgKuqAjN8P7pdcV4j3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=;
 b=Zhz9e82EDPbqmdatEL42uMZCAc1AjxNqtiguCk5Cin+QhTN/0jLyOOEHNXFLy17OjihQZAA/9WTF9IiI23yA4NtMMTyp4qtaUgxvB3R2mafHpQsbW6TYUCn1FXTguiF0I8BBOm3DAY5rkfoyivrf8vwajvv4c0QqxxymZm+3rm8+B/YrAthHPgLufXpoWLYsr9xIlVftkuCvbZsJojeJijEmS7FfxiJFnRYtR4OHzQ5NEkgm66R3AwuExa8Dwn1Eya0mn9+Z8pe/i6OwqVnnBxBsrfQ9WGqTkqHmw7MhKZGHFrVfc5FDcXhI7GPaXCgjBZM5ZIt0UQ8pOk1axpl68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPSQkBKXTw/U8/Qjn5+7yaMQ+m34nUuJMuR5LnQyssk=;
 b=WWVynBZ4aKuYGj4WoXFQUzxQ0n3cus1p2nKSI+7xqJK/ht4L+Pj62DBf1WG3vpnzaSaRGzLUW2W8bYT3gJjdA3Eg9VUBV7M7pxbuel929S+Kxed7fJJmK1VNfLN/GYHtMmzgL2oALBghTwmifZbRnd24Z4RlSa81tiymBB+QI2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 4/8] fs: iomap: Atomic write support
Date: Fri,  4 Oct 2024 09:22:50 +0000
Message-Id: <20241004092254.3759210-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d40de6b-4a0d-4656-eec7-08dce456315d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8rBRgt8l7S8sHODHyRxp4PKJyKXXwP1a6/B/s5+aGPqeKODnUCMiIDkXGDd?=
 =?us-ascii?Q?YR078aoEd30cAfY/GUf9iQqSK6HXbNFO9Om7bGH6jZtVQuA5p4To2tIPklmy?=
 =?us-ascii?Q?BYsWbFR9IanwUS0ZoQ6KdMcU4cqZkCtR/FmK66yYwnPHISqMlBIvjnLL6NXv?=
 =?us-ascii?Q?7bLuGDyJutfMsoWn/WEQcbvrKKRsZGutJclgX4httxyC3gGQtil5b7k+fopW?=
 =?us-ascii?Q?IR2fp/JmouMJHNe0lcRo4D/Mf2Vs4g/G9mMUw6ZoPaLM3wDk7mL0i6zATm1G?=
 =?us-ascii?Q?i0Xv4010usmNaN2x6k1rqsrieAK6efPuHELoQf4oLXoKv8QDpEZXUIm7lCPM?=
 =?us-ascii?Q?WrEvFInP+y+XTDwVGj5vblC5UcCcKPa6Oi1qiqmDiACBI3ovBEvaFauv20VC?=
 =?us-ascii?Q?/1Whq8FL2A3YCoF+hVL4E3a4CUH6qdiKE+Ig+TRGvcyLxuKMaI2TZfKOf5Or?=
 =?us-ascii?Q?iD8uV4/JzaArC2+boufftrHX69Exd74cFDsUwNJpqJrje472XLx8otaWCgoY?=
 =?us-ascii?Q?OWt39iNS5BK4aHJ1KLNw74+m+RZKdWaTnrikIKzVV6+B4DPiUssxHHNQ2xJ0?=
 =?us-ascii?Q?EwK5YWV0vK8W63XC/nRdJakyLb/upRu5vi0mWiNlkwcO6CqIsuO1mD84J/xW?=
 =?us-ascii?Q?K+fbC7O/hT6wSONVguKYSHgEQfEgsyzKIIyDE9QvSYTq4Jhahgz54HnMODLf?=
 =?us-ascii?Q?4HSlT/dDDtT6Vi12SjQVjxMb7qgPaUB91n4QiDDUEYTUFLF7JHY5mt1BDXS/?=
 =?us-ascii?Q?lzIy+Y9MvV6hWp6fCftw5B8ey422l/9I0XWN1LQ5BdjhVs1amS2h0YP1IKRi?=
 =?us-ascii?Q?hiGLujoaY8g0WAcVGAlBHns7oBazO2VhHrK5MMnnFa+LjWxvUeZrIiDBUirR?=
 =?us-ascii?Q?ZAU8ui170sUfEynO4wvFRapgjjplKQLatT+ShnzEMbohy30hzve17R4SvJw/?=
 =?us-ascii?Q?wfmVsegOLUAmguT5TGeVURxXgB31d9YARVpjgTXdsLlUp6b6C7vh8SoKiD2s?=
 =?us-ascii?Q?JQp52hi7U8p8gUOb4uABD2MHi/xjeBYut93eyLtfJQ0WNyHPqVDcL84O92RB?=
 =?us-ascii?Q?moFS+HX8aHO0yRnLzD58c7tj4Qou1NhO96TwCow4FU0BvdfXFsDhJqO1Xl6D?=
 =?us-ascii?Q?b6/gKp5j/mHXnNIzA/mxzykZ1KnqQ5QSElPxaKcA5Tp2AcFNfj3MgXKDbH9B?=
 =?us-ascii?Q?e9AUZF+EhJKlujDku3e9yNN6JVMw61a0bcVXd0FYlfGoyVSDhK1vRQhP3qOd?=
 =?us-ascii?Q?vxjq1fIu/CSYD7jDvK/zcM/IK7C5J2rgUOTIVmKtyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GC8IfZnXxRZ6nm8ugxvn4Z0TbltaBbaqmz3pYm7kG8kDU6EQJLguk+1GCJDm?=
 =?us-ascii?Q?+Mn3apSQ+1HoVnP3UsmCDR7P05sJIiaQvsTJluzw35cgLE7hPr1xJmVWJBn0?=
 =?us-ascii?Q?HACvIn1NpqbeuerKURyLAHC0KrSa0dA03ymYYYR33Qnm+IeErssS2hJIhT3g?=
 =?us-ascii?Q?4/wC998soN+G3ghNXH+UMR7ZjD4TwXtnihIP+BGhcpzR+nRZkCOMvucAaAC1?=
 =?us-ascii?Q?tEEjI4alObpfZEkcGn4YBcyi8JYzOYS2g+Ig7wnCuokwKeqDWUvMRADCqJwF?=
 =?us-ascii?Q?ajFUyEU5PEZsqT1jDUPFm3WUS0wglS42feL+rTzpLHj0ghuFGDxP9u5acH37?=
 =?us-ascii?Q?rmGSsI/zmqKT4nxXrQD8auHAAwHKbknmz28Nb8L00TvyRQvXrrzff+waZCVe?=
 =?us-ascii?Q?5R5En0BNTznrmIr6cHCd3dofQbBrQ+38WQI5SBay0z2FMIJlXAepOwg3SOyo?=
 =?us-ascii?Q?0i4WfWM2NLlwuX5Dtl+AUWaokuMLm5s493LWx/+kN4WnElAjq0F1Xhjcx2sH?=
 =?us-ascii?Q?JVwcMaAVc6McMnSBYrZz5S2M06DU5ar8wuuGM5lqJfHGTatFjxEHOHwbz9ji?=
 =?us-ascii?Q?A6jW/0If6NHu2ArH2D/TaUiMChZOuha2V/WRTb8jwenT/GaDlW7Tjf82grvW?=
 =?us-ascii?Q?qcvAZClsqe860F+8cfORsWDa3lddY+fvdGCjY5bbijvyQxPwDq8tpAmOOJJD?=
 =?us-ascii?Q?8dL17cePgyd1auMCHJhR1n5QhzK9E94sbg4TxukizJMEzgQvl87UoYN1GElo?=
 =?us-ascii?Q?HVWLjlfSnsTtv3rwGyjBHOr81F2qoeP/eSUPSGBGMEqoTrwSAVKi5b4B2IlS?=
 =?us-ascii?Q?Kbx7KDth84H2YMZxBmtbQMRFj55L/d3vpWmsR4ZPDs3WJUI5oh7sVEZ4sF3/?=
 =?us-ascii?Q?Li6wqu6kYp4M2EIT2LS/DM4Sn105hiEQu5fHgO9hutlGg8I/DcGIanLErdnj?=
 =?us-ascii?Q?7ivkUkXl7MdMj1qIKEmdRwM3lEg9oRBqWlCutaIQUqkan4e8dUhwRUx2oRgB?=
 =?us-ascii?Q?cAdKPMBHIfaCdnFEXiHtyqWbMDdRWfbD8SIL3YQ2F+0IKQvwt4mYHOZEmRrk?=
 =?us-ascii?Q?KX6qsKzk/u8ZXxKTEtisSqtpxETaXIECqvP8W2ptYka6W59AP4nv/otTR2cs?=
 =?us-ascii?Q?45fw1X9uag4m0rm0PL3rebM7+QgVE53bo4k59zObsebxKD3Z4ezrQnVfge/g?=
 =?us-ascii?Q?x/XSPp+9mSjVkK7dlZQxbf/4hQIpA3JnNh7lDH3wSP6DEDkOR95qMwdBev5G?=
 =?us-ascii?Q?XZlqRCd0BQc8ky6vkUknLZj+tYFa8vQNkJ8NsN74hNuP4TRqu7FJ3FolBmdR?=
 =?us-ascii?Q?Yp+dRQKdQfG31ZaNS4thL0zBIYGjJqp8mPXASyjqhGveFbuQsiZbmZkdPHI+?=
 =?us-ascii?Q?80eixMovrgAno9yjLCrN8UNAA7NsdS4HxFr+yAj4nYrAsa0uc6ycvKFm24hq?=
 =?us-ascii?Q?tI0djYM6uWO2unQX33l0rXAeyxjlR5+bb6Jmea77u0fmmzJRWB1IldGGvgs3?=
 =?us-ascii?Q?iwZa05w8abdhYP38Lmx74LxiiZeoPF9rVn0lStLkCLXVtSJ6kHPeKOYhLzXH?=
 =?us-ascii?Q?u6e2lE/veduKAkYvJMVn3p7dnMTvtVy1Qwki3eAhxXKbTrA2izpctCG+vaOo?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aEXs3uUpFNZ725+sGe9ejJHm0wh5g11z2h2jIGZyT/AsmMXuFZxq7FKUZguWZ02qslV4m/XXu9OVLTvkqPpsQ+P2/UPz/K+9X4h4oCSvwCaouBDfnua8dsIh+8xkmw2cLRtWZ9Y8+Faf/PXEwAx/QjDIAkWysE0zTvv8fTDJgZGh0ZofDUMoTFz2GYv+GZfzr43g2rQRmirR6AvaeV7hoeU9rAbih/Ie9pV4jHju5x3o0C3kXsKQb+yQoeSm21hFWkCOWCa8XR6a+RCpiiDs5siVeoC7x0keNnECxuUjopqcjFy6I/QF15Y9Syt0NKxvytGb66FEf0+n7Fh4G7KglTHOzdDa87QvQlAytMpUf6ivPY/yrekNcHqH/LgPpAOmvHhdbYTzH6ykIIYhrbSaCYjZOMqYwoQjquYzSOVSX86FNMZ+8iTGRMGotw8i9yMLWTlGWmI/onMZQAcIGtmEkyYH313+3tqos0QLgW4ViC7DiT3DTins9f4jNnXh8j5hIm0CO1j3WRnHCcUFB65Zxu2N84HQ4AxnhREcP/InAD09xF6hK7ofPE+3rzFGs+pyJVF2m0rhjuK07fdt5rmGoAVhiUjNtHQQmV+pi5RBwKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40de6b-4a0d-4656-eec7-08dce456315d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:22.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V94kJ0FHaC7d6gDwZ/FO/yhhn4//KmTRkZ6UYZyLn4UhZuoQvC5Tk5mxzzK6OwlNGhTYvXj4S4Yfeh/LhgdEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-GUID: qa-lgDrQvb3pRkv3gZghMqwHwEh9llVo
X-Proofpoint-ORIG-GUID: qa-lgDrQvb3pRkv3gZghMqwHwEh9llVo

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

Initially FSes (XFS) should only support writing a single FS block
atomically.

As with any atomic write, we should produce a single bio which covers the
complete write length.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../filesystems/iomap/operations.rst          | 11 ++++++
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 include/linux/iomap.h                         |  1 +
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 8e6c721d2330..fb95e99ca1a0 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
+ * ``IOMAP_ATOMIC``: This write is being issued with torn-write
+   protection. Only a single bio can be created for the write, and the
+   write must not be split into multiple I/O requests, i.e. flag
+   REQ_ATOMIC must be set.
+   The file range to write must be aligned to satisfy the requirements
+   of both the filesystem and the underlying block device's atomic
+   commit capabilities.
+   If filesystem metadata updates are required (e.g. unwritten extent
+   conversion or copy on write), all updates for the entire file range
+   must be committed atomically as well.
+
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f637aa0706a3..c968a0e2a60b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
+	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (atomic && (length != fs_block_size))
+		return -EINVAL;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (atomic && n != length) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail (complete FS block), similar to when
+			 * bio_iov_iter_get_pages() returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iomi.flags |= IOMAP_ATOMIC;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -659,7 +679,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				if (iocb->ki_flags & IOCB_ATOMIC) {
+					/*
+					 * folio invalidation failed, maybe
+					 * this is transient, unlock and see if
+					 * the caller tries again.
+					 */
+					ret = -EAGAIN;
+				} else {
+					/* fall back to buffered write */
+					ret = -ENOTBLK;
+				}
 			}
 			goto out_free_dio;
 		}
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae..c7644bdcfca3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


