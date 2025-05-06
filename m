Return-Path: <linux-fsdevel+bounces-48202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB30AABE98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BFE7B1FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0E26FA4C;
	Tue,  6 May 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WrtnduNZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tTMiuBFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD067267703;
	Tue,  6 May 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522409; cv=fail; b=FILL7J7HoKdWgmMBl74UwMKOMrdir7TB7pqL1Ii0ziQxAW1c6XBkgwxNgS2CiRA/OyDYUnryBdhP5aXgyfpmr4l+ovzIURzmHOY4VxiSR+ldrDaxJ6XPUBybr11Fju67Yz9fHX415+ndC2RwFNeDEvW6tiMJ2XTUYu8893Z47aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522409; c=relaxed/simple;
	bh=zin1cGnHDBDRrW3jNLQStqqddLgWyLLs2LbDahuY/MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjZMpxze+o5d+qYHNvbUwpc7pjqCoUGJ7IGjgiVJoidYowPKCfaHKbeyzdBVS2jE8bs+AiWHDGbkIVerbNDAQhGbvpLofbCWKC0IhoTSxcoOpS6jQ+fJcT4IZa7fDNbVYzKAjX0/g18+q1exGODrgYGcE0ns/gpEJITWTKxxWQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WrtnduNZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tTMiuBFA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468cw42032218;
	Tue, 6 May 2025 09:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=; b=
	WrtnduNZ3HycQQEc99M2w7W53zYosLSOwyfouVHq10WrcPrsd2AB/uevmCeUkhzT
	OWDZ78lyqlSc6epCgQ0KR3c94ad6AR855nujGrq6pB1PwW0vfYPO/iPBMQB8bzYX
	sWLtzDSb8br835wziyZJBQsIj8TkyP4McJHi47TB80HYqqsJF5vjuW8NXV3+dBsH
	c9mJG6hoFRj43Gkjq2EWcnsvN5VxI7SAYbN9tZ+YLbZZ6P0tkZbVKEmKwfE3i3Ez
	S2V/I51Pa5sei4LRex5sJStPMEDqN1cf9x8Zqa6KxbD0RTEYlBkQDWs0aIJX6+50
	d+K8hwdYq+XzRPS2clwjxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff3mg21e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467sm67012165;
	Tue, 6 May 2025 09:05:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0bwr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioyfetr/MUlVbWjr2myh6Ud3U8gofWwaphO/DyzitsOkVf0SCvLiCVXoQQSc/csUF5TwnpvzmLYjwtXMlAzjWuTqytv+/z+eRowlpbI4rvGneMfdG3cSR7ZBP5PKJZuUS0+emoA7S57RyO0gIR9AptPbCeEfdlixR85w1Ni130LhSbeqb+gNz5jA0567OhO8/PGY3N6aeqIXfiOrA9BxARkT28FkG2wzzulsvF68/3UE/6cQGrCGvBgOEsSKW47HQ4bKYoDf9vXlqybUB6E2N6xNo5sVo6LiWelEMvN9xuZtffpM3N03NT94kPyRlc5wwGxRhHOA38St8U/ElZ+bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=XnHyqtJDrR6ztnv+dCa/e/59C/IjFtL+x6oN90AEEDAj+Bnty0VHfzGjViGrz7VzPMgF51VweQUn+JxVZlEdtyiXlXHIsnxBp10i7MaoPrnMRFvqTsJdR5+bHujz+hPwZQ2zDZsIA379dMldEyJHJBj7YUfq0O/JxuYZdXRXuwAlhlFXaxmxV+mx+18njAVWmKnKqUmDpC8GfyXYaiKX2GdPimCrsZFkyVwhLPwtoKqYtCx9DUprSCOPaPRwTiwWOUChzwaASvOfvq9F/VT8qUSbexTunbM+UUcBz4EBlkVJ/paNV1PPTf7a05z9fAshaP7b/xnY5J5q/Qdx4DujXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srLclYblBb9JiBMt5Z335oUdMAMav4Fb0kt3AvrsdFQ=;
 b=tTMiuBFA+vfEBvAXBmouIMG8rj2Wf1gXd2wuaFo74bG7zudrKAsMXMjTVjpyia3KAF2Op3Lw2GeaYSSnlAmqSvEh4rSyfqMG/bUe09UTPrQkWdr641RVFu8McBkQq2GOftwI7YOhnog6rPYmJpn4S+iP8zEUMYzyMIY+03th9VU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:30 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 14/17] xfs: add xfs_file_dio_write_atomic()
Date: Tue,  6 May 2025 09:04:24 +0000
Message-Id: <20250506090427.2549456-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 921c50a6-1fe3-4781-441a-08dd8c7d26e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8xmaYjw1AWDsxkHlZ/Q67iecThsgVcc8liKlhiALcEE8Fi6ylNsVnD8HBciF?=
 =?us-ascii?Q?g98Yy8zF9ryKjMUkvzhFw072QWnJVOp2cACG8mF3AF2iMsBR6SySj+ZdU6Te?=
 =?us-ascii?Q?ZTC2plJAXAE0Rw8/orCslBNzf/8AJ+q4nOuhzVn8BBXMmMXQmMYLHHqiALVW?=
 =?us-ascii?Q?5yNy44f+EfGawcEho9o2zayFPdjGutKri22yn73Y2co6ZjF/3GpmFxfMCMdF?=
 =?us-ascii?Q?FK+So4tpbc87KFt53w0MWn52liRWiscoKpxQIZ+H/qlDI5w+c0xFFPmpj8LN?=
 =?us-ascii?Q?EDeQjdRCIKU/KMvqYU686kSDTNcIHbCB96KQ5gPGcUjIXWjt0YJLqNTBWwe4?=
 =?us-ascii?Q?OEx5Dm+aePiRDDP1uYuTSyBIh/4ZRGv068qO1JvwzhnQj7whfdYdHQtaaDdl?=
 =?us-ascii?Q?sS2z1U7Gdl+DzBEZfkLrdzPflNHvHVsE2azCvVf1MUPXtuf65HY0PSKKH17F?=
 =?us-ascii?Q?2W/dEPVY8QHYBy46H7UW0uEqXFpt5dHTlBP7IxBPqRlKb2yto3YSjj1LEmoZ?=
 =?us-ascii?Q?bqc+XBXJFpqvzAv5ZDqMrISovSf40BBD2bwu0DuAWwh4oCYD7kbqfIdrFkn0?=
 =?us-ascii?Q?a7iF7VZE0Sr6JFUinqmi9qD6YiFpPAx1cA7QXA/WvUTzkRDBM2jY8lawnA7B?=
 =?us-ascii?Q?/vgpI//j68G10emQSsuvhmQmQoNqeqMJWtoazMQaqx4ihjgD1eMfz0nNp2/7?=
 =?us-ascii?Q?DimKxh+N5n7K0SwubG4sKWoanF/4lU9rZKYZz/LIFSBgj5tOwH8/pTUFuvyL?=
 =?us-ascii?Q?H28B3aevb0IKRjpSFSGBckPIYoKDbFF2E4n7T3jRptIcXzTMi6NY3TQ2mp23?=
 =?us-ascii?Q?7ZOtdLY94o0lKj6TeZJRUTlrNuQypNy9HFNRR5Dx+qPIB0ey9Gg/UOgOIKEM?=
 =?us-ascii?Q?8yV6gKYXaTvEMPvQGeCZ1rmj2bRcHMDdFFWd/m1Y8wYjJI4T4CxKu4iJdBTQ?=
 =?us-ascii?Q?VF3Ldj8M6rYn5lmA+tchgDmWdikr/8ndqiUlp43j8NWTUa1cPwTlczH4Q+Vs?=
 =?us-ascii?Q?i7clRt8LYJXpWpv7wGjauQAAPui5UzrGJJz039VmFsOqBYILlLPpdgH5b7kv?=
 =?us-ascii?Q?z4QEruyxXF06OmnuI3nYgf231rmg1eMyi6FgrGNzkLuAM3teKTqADuvZ64fL?=
 =?us-ascii?Q?YEET4z5DAo5HpC6sJZlZumQLv5nEARY8/1Y7raRnmMq6EWv3DcSfPG2pjPO7?=
 =?us-ascii?Q?tcJqxthb/fGcdEuWZaGRIdi19xNaLXjStyBNWPOr/qPei6R7ICPd1noZbBOD?=
 =?us-ascii?Q?AOI4qc+laeMAUfwWmwETfIL1rW3+0liqtglNY71LCiYxAbG69cH/eM6oliXi?=
 =?us-ascii?Q?zm4kV4fIGarxpumDOnETPwJWV7BfBRFuMpc3uO3jr4uDybfQn5B+5xBNJBFa?=
 =?us-ascii?Q?gr478UUgF2mKV9gOYphfsfbV6+dfT4g29A2C4OmgZXO+OEw2Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lp9TaTm9I3CDYvTWaUgOzcyUMHp6WK0g/L03qj1+16YzpzSxsSB3pkjO/S/n?=
 =?us-ascii?Q?ys8PBs70uaBuYjccUA67/Gy/pS6SrPsWRtj3CyfhR2roUVBst5f0mNS0OVzS?=
 =?us-ascii?Q?3KmK/QfZNkihgIsDWwcSxZPPZwOBnOj1bmHN+xoEFwpmqLYKgzWJzcydHCjI?=
 =?us-ascii?Q?trh4AopHpjlJE+AT2QX7MprW8Dp1xaM6ZdcJd0w2Na/dOnhC5xOZvq/+CU04?=
 =?us-ascii?Q?LYH9YpVrpSptW11KYBG+4isF5L38hZFrlU4lXP+sY+fzEP2X0GJqdBeDOnEd?=
 =?us-ascii?Q?VcFYcmi82/mFAPNuLbeteeg+yRK9vC+M1lweIOEa2uZwfXVqqV/GIaaURQsZ?=
 =?us-ascii?Q?oQGhhzQ4GpG1H0NEPACLUgnOzQ7izM+F4qirp71lgPzXIsbWfwXl7lxyEu69?=
 =?us-ascii?Q?B3ozJxvrxrRp/o10q6aKMzijR2vgIJ+lU3RmYnmyY9bGjDTeoxDIaS5gzGUN?=
 =?us-ascii?Q?wBJM5ejenm4s0MFe7t/NJuml0cbbvsnbv/3+elkLAT4YFK+D5AU7vhYmWu8F?=
 =?us-ascii?Q?VvVcdQBRDcnX7JEy11ZH5I2mIQ9+MHOMjJazY86VJUfvlCBYA1XruwN0OAjh?=
 =?us-ascii?Q?KZyrwCLH2i8JrPCieKUhzZwfKSnay1KSk3dkm+3LNs6QGivCd8V84aqzRIix?=
 =?us-ascii?Q?17Tc+CozK0moAz3eGWNbD/nL7a0hEKKzZzsfba/G4wvjM8Lr9D29EKHAb334?=
 =?us-ascii?Q?kkKZ1Hoqy6AR96bOjyaQEG5mngszJqrZ/064/9T3JNG8TKzb5If55ybThA7F?=
 =?us-ascii?Q?CaJWluiLsRP6Z/6DnejNv5xyGA5Wmj6g+3Vz3ji3f62Zm71TEYs7zkMWgoty?=
 =?us-ascii?Q?Hif8vcACeI0ZPqRFGWPkx3jdG5saiugI6GG6MNlrH8AGfUrdszXXc/Dn/EBF?=
 =?us-ascii?Q?PBDKx5ucyaXO+wmA4zyhgwW1vtX2Yucvc6+NtLeCDTzrvAPDLNb73HbjYwy2?=
 =?us-ascii?Q?y3JP5Fuhka9yl9uvyyx/Gjfg31hDe48uAwGYG7RB/wNMtECt2fWPcz0Jcqgv?=
 =?us-ascii?Q?EwiNzTbh2rEcjA5yc3b++jZTdw5S7Rpgp2WWSMxH0RkEB1jH4wmu2Az6vfAa?=
 =?us-ascii?Q?3TcflAtBVdf0/76M8JJkSO8Ze4RoDTrpOxItpxHmw9664agQdZNsVZnav6qQ?=
 =?us-ascii?Q?VuqfR8tV8FPAM35Thv2gY2iktyVPvqYps7S4bZyOx/aFHkzVxG8v9lAj7aUp?=
 =?us-ascii?Q?kGgjIN5eYkW6lJ7kYPzNuEfzSJ0Kf6ZRKBL+veQFixjmEUtvviyztyfU3VP8?=
 =?us-ascii?Q?VdsgkzbvlDT+D15zJD2KCK4P6UihCgS0W5OM1gufhcAlSGbFY7mgLLkKnvZL?=
 =?us-ascii?Q?1QNuRZeUWWQl3n8DJNiCFNU5j9/EmL77jYoQihZkr6gqLcyEpc7WUMbtnaw8?=
 =?us-ascii?Q?bttcV5oI8pFbXHgei8Z4T/TM5GBIajlz0w4zIIj1hphSHq0jW2bA1qPwow7/?=
 =?us-ascii?Q?dk8dy6YmT4nvzjcjEmOgmWURlXezP378xQlpyfBtSHd6sAThTNzu+tH6/efI?=
 =?us-ascii?Q?h8y0Yy5V4HpgkxBwlaGNNNDsonBUaDOWIzGHaklM3e55v29MRYf1hZ1Cp/G0?=
 =?us-ascii?Q?8XPWBCXUQDNRkN7jZjsdjDIJRzCJWwZI1srCxBT/XCl/t38bkji4FfytGww6?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/xTn58ZJyV2TGllo6qc0q6BR0AvcoI8zWlkCMau0uwakABOkwy+juTFnFZNyIDxKBv290mO+gyPKPOfoMxa0gU0W6D2jf0xg+c7F4H51lRl3EUwVgkekuXWeC1TXPcwD+kMiPmaizZZ4dx74FhPyIvpxhoFnr62GnVbg/R4r2vVQOyDfoCVOZhdfba9ULJPABAR4ZCHeIUU9eVGbQzQOKlkLXGOEXEhcAJ8hP4ZMHfnPsJw3mKx9eOGwMQP6BYWM2a6ey5cKF3vGRztGe9lfQoVg6lae8Zew9IwZmG8tw7OXUs7+/XTCqS/jKenJV2WNuXLs080HRthuRCAls4/O/4+Zezs7erW6nz+6aUTxntusR5zGZHnQwHB8hrLkvUX42ryqYd/YPMiMioRZhDEF2dt4S6BNZmO0UEkScWDGkgYE+5OF5giYi0x8XkaZIJT3FBzrioymKnZMk7UWwKh8qGrFc131lKkfUD5T+5PMDPRb7v3wS2Ay4Wcdw3Eggu4Op2YNupgHwMBdp6IqolY7jguWsD2ovaZIGHNExKQy0TNdoqbI5XdtEQxeHplvgBE2P/9WgQ0J7E/PpyvEk1RW9iJszYvgzFbc5rMqZ/vDbGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921c50a6-1fe3-4781-441a-08dd8c7d26e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:30.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCUOhTlUdff4RwzIina7+eEsfgeLhXai9imlVJqva8e1BDbJaSOfNM2WNgWjhrKZd5PM/qgeblqRpMkqoJvYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Authority-Analysis: v=2.4 cv=e84GSbp/ c=1 sm=1 tr=0 ts=6819d0e1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Y8Big0Z5EXcV7lnze7oA:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: JtuRSpILFmCCTX3mrw6Qyq1KQ3y5hhKI
X-Proofpoint-GUID: JtuRSpILFmCCTX3mrw6Qyq1KQ3y5hhKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXwYn9zNarJ7yI WSHqi5g8hurGA+kYGfm9vPg5BwIeQxNjeZ9a7g0fvnPaU1TjgxJnJDl8QHLlil7KGbEVf+/3s5m 9EQ/AFwMJe37TmoqEjKA1YoFZw/0Xcip8lToOdtuodt8gmU32cyzYUhBUyj6d2xh+dMUnzCJnty
 uJAvu2Jjiimtv7nauTW21HSojZOgjNtbUzFffhkz8abioPoh+wrpb+VcWp0LfFDUh4dQwxAQUcA KpCjCzUBDdTS44DV6ArhucMhthNXKClBwtMWSUfR+AhBiBwRt/cayJbPhzfaZc7YQag0EM/Br/E HmX6OHntA3WqSvpvlqKcN3oTA2lOuTecJ7E6NyNHdwLut1PPgkE7VovPPgvq/N3MhjOhx2CsURR
 jsij7M4U1uCN8B5J8HB0smDKharpCAQLmN29ckw4izKW2M/tpzMs80vEYayuZWo1maBHUTHb

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

Now HW offload will not be required to support atomic writes and is
an optional feature.

CoW-based atomic writes will be supported with out-of-places write and
atomic extent remapping.

Either mode of operation may be used for an atomic write, depending on the
circumstances.

The preferred method is HW offload as it will be faster. If HW offload is
not available then we always use the CoW-based method.  If HW offload is
available but not possible to use, then again we use the CoW-based method.

If available, HW offload would not be possible for the write length
exceeding the HW offload limit, the write spanning multiple extents,
unaligned disk blocks, etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload usage can only be detected in the iomap handling for the write.
As such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload is
not possible.

In other words, atomic writes are supported on any filesystem that can
perform out of place write remapping atomically (i.e. reflink) up to
some fairly large size.  If the conditions are right (a single correctly
aligned overwrite mapping) then the filesystem will use any available
hardware support to avoid the filesystem metadata updates.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 32883ec8ca2e..f4a66ff85748 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
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
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


