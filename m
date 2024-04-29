Return-Path: <linux-fsdevel+bounces-18144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C418B6090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A76B2150E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DC129A7B;
	Mon, 29 Apr 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HaMSHxDQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dyyQmRcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69A12BF07;
	Mon, 29 Apr 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412984; cv=fail; b=FuT5nuofcemBaQoLL3eguDKJNRPvRuNqqLss4ef/kWJi9C5v19o2VQlcX0zmOkuY6ES9efZiJm1Xu8hiXSYoEP1tVY7Rp+gDmaTBNf/ZAbv6kzTX1fWsTQBwW9cT8nKqZlOFhGyzHboQw+Ir+Io2vWviE6fcs6Rj6ec0YxHgXSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412984; c=relaxed/simple;
	bh=/KvSl3ytoQgkFU54DbvpofpRa2xymhmiQfYdRCadIc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIxi3e5v+NQWguGJAq6k4uh724kJtkFu2s291Yq9eg/azdaabe8TI6Bh35Xte39rkmUij9wcUkfGHfWOBdfnT28pjN7NSDjteq8NQP6eFR03LfZNQwrCoHb/jHWNOJrjDHJX5/qB8jqIGCkdtzYz5O94V7NP/YPWqswSE2ecGVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HaMSHxDQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dyyQmRcU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmQb002371;
	Mon, 29 Apr 2024 17:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=SheU/MsThsAx1QFkm4UlXzRTBBDYDD4ovPjB66yRbSQ=;
 b=HaMSHxDQaOJ9qQfEN57fqKFHyVY73QqfKOCy1lrChfByk9F9XRwvVbR5864FVObIept1
 ql+M+u5y7DMWDRlygjE73a+kjA1oF8BWS5AlKimshUDvG5ltlD0lU+eUz/InAqfDmOOo
 rtIcD8vKp/ixCZy2d6yKUKGfRRMi7ZTgF8YVkbuAPG95Yw5lIrNTaVaLqp9LpRu6Je68
 YNc31nH4Zanssvynb+S0whnB1peDK6DG3wyjCfx3kTkCXwPMfqEzp8et+J14BaAEzK39
 UHWOXCHD4qvhS1viw4BzanHelkwGJjMPfn+8UDKZAwHMMbSdHlboofZwgKNIEFBT92LV 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqseu6qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8f016783;
	Mon, 29 Apr 2024 17:49:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4L0QWnLL8kKpDf3A6YNMUK1vOoB43A6+hFMYAoYWOwrovP9PLVD5eqlvcSQdZIo6Optmw6pMriX3yj5njI1F1LNSoulkrzUl5lApYRmfq0R57YIvrstkmVFpBgChvNl34Ww+4ZK/U1Oq1evgC264x4Jgh8RBfBJdpSVWMkIy3yI6ssmfylhjmqmt6iND5Rij8yipYLjUD9iDRgcQz/8lFd9kkt9+wPXYAAcyOcJvDOog1uCvOivIaMW1qORvxqGIYIeHFHeh/an0K7LExbUoq/d1dhvPjegX1LTVJpwzJxqmF5VMF6/euIQMYvziyhnT7Rta4mK4903GYSJefj9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SheU/MsThsAx1QFkm4UlXzRTBBDYDD4ovPjB66yRbSQ=;
 b=mwW6FJQdueKT4AR49N2Rl8aeAcnCmtNvPpQjdKeeoYd1HXdeVZt7k3XWr5sIy0s3tY66+gFsQParYwyEVEP1wQLeOGpMhlrorqST6Va07uku2jYXxA16gLMC+heosqG2kXjobdXLfKRqcHSReF0fktZtSoc8WA7wkB6/yLM01s90RRO4Dm5CE0u16Dmt6txqYLYV23BO+AAoOyH71yp454oKQmW3BOsXWW/eZyQ/p/kqUzfHB2YucjxPe1+RVDMBRvRLtIqvX/vSr2kl0Ln8auLF91LJ+QirakDDpFCwEK3Dv9fYdgZib5TGUiS9o9d52sXC2DUQXH2cc0pxaUqiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SheU/MsThsAx1QFkm4UlXzRTBBDYDD4ovPjB66yRbSQ=;
 b=dyyQmRcUXmqadrLEouVZ2Tvzz7HnwvFsx9vIXH1WJBf2lkrawun6s2I7bF4V4W/PYEGyfemITX5jx6Rm1kyY7QE0UcKbcxBlKqBmCCwiOmJAOSAzVW3URCpV4Gtktdlfa+XpBTpganBg8spdANl3d0geffAo6Kp9+eWOzM/H+Hg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 18/21] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Date: Mon, 29 Apr 2024 17:47:43 +0000
Message-Id: <20240429174746.2132161-19-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0378.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9120590c-995d-4612-d6b8-08dc68749fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EpsgECvyMpJQxt7ONQ7uvu57GdId1xIrbG21ZlKQi/F5SlWzt5XMW0WSV6Su?=
 =?us-ascii?Q?RZs8fowFVt/2rmEOz49zcPpGXNBvYEMXqHiRUtwcM9v4NIxlhE6rpxs2Re17?=
 =?us-ascii?Q?+WB16oAgmRP/52UiJHhM2ixrceG/9afx4/iBUmqjQcpr4OGzavEokXhD5eOP?=
 =?us-ascii?Q?PPlslSV7AC0mqX4iLtWOQV29oPcg8y9glAuhjrccWrGQIZmWV3ZL66M3g2d6?=
 =?us-ascii?Q?mqzXyj+2v/VfwEenD7UDrWIsXZYo4zcm2TVjdg31PwzfURkOT3REktrJdvpi?=
 =?us-ascii?Q?fWSyoiShhY4JM2fGuodb4XuuNZTEU2zhhoeuft7ZQugUt6Z6zmmqPFSRpj7r?=
 =?us-ascii?Q?xbveeVvqByQvpthRN+fwVlhXNbNUXEWqcK9KQvsCezFDZ6HNaLakR0Ld+rVB?=
 =?us-ascii?Q?C1emQsV1Fses8t6S5uXMw+q+n9736q0P7GKwTvroyVyin0kE0VxRrEX9siK4?=
 =?us-ascii?Q?/koZMdiY6EHXvQbmsS2POAeBqlHx70vfP7kE3zZ4l0UnOBgnrtx3r1F7ioj5?=
 =?us-ascii?Q?JAwe1GyqoUdF6dxcdIQNBzb7o/8bx/QA+/+jLmuYjBjc8MmZo/RO0+gGOY4n?=
 =?us-ascii?Q?NOA7GZNjw18f4nsnO89m4CkJmRu1kK5Xa1j1L7pVrk2YB+x078b3zzOV4ZIG?=
 =?us-ascii?Q?qo9+0cU2WSWlxNX9TiGf1FjegMiwY2koPcB0Cycl3ME0015AAo/GcqRxRm/f?=
 =?us-ascii?Q?T3enMay8ug8+0PhpDtz03oj9dFNvBqmeZALq8vNXorFrszlbcja28afjhvun?=
 =?us-ascii?Q?lvB0yU+7GQ+B+o7bF9QeamImRh8G3YQFDBw/tXV9uaQnlgNC8sASO6Hq+oTz?=
 =?us-ascii?Q?SVFMJlej1ZCgLiS1Qfg94axFyWCKzFIFng44Hh37hC0kfsouj06uNeuTjIWQ?=
 =?us-ascii?Q?duwCcUO1dXOt087x6Edc4Twq2EMH+2sfASoSeEfN1Cdox9eoD/jCw96kbKGa?=
 =?us-ascii?Q?hfQKW9HteVO3dufJW/HWRvrZFrUE8yUAaFD0KzM9EUVvvaCeJo9QPw+M6d8W?=
 =?us-ascii?Q?NWjPSYyUtai4GQ/aDJ+5LJucZf7Oxcd4AIpwTuO88/ohwrg8zm9oquhG2Kpc?=
 =?us-ascii?Q?STbtaFsvS2NOcSlHncY2fCU0/GoVCcsByEfsbf6H5Ynom7LCyNn9HOMARzzB?=
 =?us-ascii?Q?mit+hM1gVR2QTi4dAMK9qSSQr/v9z+4T+AOcVByHHGZm+IaK4vSIHPjnGhnq?=
 =?us-ascii?Q?DtLVPB8usFsnAqvvGkS3a3tCxsK9Wr3Ew4d/z5gJw/Gdy8G/2rzKZPc3+ZeO?=
 =?us-ascii?Q?6ZZ+t6eIqnX4mfyqA8PfTdsPUuV+6lfbf+VF4neQKw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nkkeVKvPY1sgr1IjLpx7gVxewy2msyoWUquiU7w/MzmCntCsLGoGxYcJO39P?=
 =?us-ascii?Q?65d5b2k2E5UOwBgYJFcylm7YhCWXngLorM3gRcoBBsI00BmVkA766oh5htmN?=
 =?us-ascii?Q?Y0LdVnsytQIpIwOMb7bZDNW4LhVumsrk1tli89XmT8cBu58RnYVjOrXGPR2O?=
 =?us-ascii?Q?RRpt5hFMWiiH7jvSYaeTd2iqaAUfVLR5LwcsQZTm1hPEO1DITkTVFzryave/?=
 =?us-ascii?Q?bf7XzY/UNrs2o3NFgC9K7rli0deHrzGwmdvOGpdlEDwQ2BI0EUD6sHaxG2Z7?=
 =?us-ascii?Q?mZGyRGss2LFGLa15IFOIXh1fLwWdxTR4i0OPykQNF+xgSl1/6Bfu3gEaDOj1?=
 =?us-ascii?Q?0A9VhtT/z/stLQ5jlEmEYZU9seSWj/Rk/1idqshoFyp925+KJIc5mxeoE/jw?=
 =?us-ascii?Q?NHpGmtIkU1z6jaGEAYxciUD5PBnlnP979ruvF+ASwiG+QFfzsJ4qQiEgs+Xj?=
 =?us-ascii?Q?FfaBvWCbF2PxB6r0/E2ZFQrQqqSx/jPcrupC8nOV2EbxfPw4hT1tkwkv9ttK?=
 =?us-ascii?Q?sIvyzD7cRmecLrsX7JYXD3QE1aigptmllzqN01DPYnXWWRClULbNRg8ybtJC?=
 =?us-ascii?Q?VRl7mXf1QwQBA3EKdEReq3mhJlwiDhb15vrAOyvRtv7tbSbqNzuRbDsR5Ob8?=
 =?us-ascii?Q?2g6VyWSbtUXF/KeEBVUZrWJCCWeHgAby1igC95CDtWIgXbEtAPEDji05hGYT?=
 =?us-ascii?Q?K9/3ycU+e1G2Q1qKZZfLFjlBwONyi0Y6Tus+j8kJomUkb8Mmefu3ECGg2EXg?=
 =?us-ascii?Q?dM/3/Uv/E3lFaigkR5x+XQRfYegO2wiMyy62GmKTXSgMdN8X3T0DVg09d8+n?=
 =?us-ascii?Q?GCPQLDSPFjKlQxGrxmWbCHFK96lpAFpn5TaMDvji8iaCZD3339BHypBK8lEi?=
 =?us-ascii?Q?z2QaqvbpzuuCqk40S3LIop73Rv4adM2NybTFj8f/tEH5PB5rvYM9kwMnyU0o?=
 =?us-ascii?Q?/rJpeWJ5Z8n3Xze/mgDZEzlhp2GQ9LHCXU59mrqrxu9RJhI2Pnsk4fy5ngkP?=
 =?us-ascii?Q?2gaqpjZl8XZIuK4CdZzmbdjilYadCfP+T6SwxRLvsybopOKtlOZzYZDIcfC2?=
 =?us-ascii?Q?4MrItuASpB8lVP8MagYz8FvrxogY+bgC1p+TU4vsvUTANPnK/5eTJ3TWxLu/?=
 =?us-ascii?Q?1wOlDqp1tfthsrVgxMrBJ7HdyjcHigiZvZwYeFEyXr4Vw9EdGvhTELwgzAhJ?=
 =?us-ascii?Q?g3IpieMISh3ZYFPnGQ2UWxk+P6vswmyVkPAZZj0Vui9W5ZduEspShtxmeLIG?=
 =?us-ascii?Q?ONIpoqlbQzRl5AkzoE/lWSMtr9MS1aOtnXE4Di4O1GkqV4qFneO9TveySMnV?=
 =?us-ascii?Q?RIu1vjdrt5IBBoSlcjT+id+Qim6pfAO/BjrD5K+zjurrkbNz1HUVzOCr7KG7?=
 =?us-ascii?Q?R7770IShbR863JlLTTo6iLzH/Hp8YvnjhNEJNZgjWbejyr326ipz65WxTUDw?=
 =?us-ascii?Q?fl+Gk4pJLbAtJHCXx9xlja4jWfssF16TaHoMkcZlDumXsoZWBuck4EICdo6/?=
 =?us-ascii?Q?vR3i9bDQzdVeKOXCeUtBO75iC+x6BpW2ecTKUG98LXWi5MqvC63kuTyE8MqK?=
 =?us-ascii?Q?g8cRsKhty/F/gwCpBx0QkmsXkZzEUVnBqOFljUJHulzZGtRZ+pfFffpXV6VY?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qx6LbGXE4z73CAymEKUxr+b7b56RCvCBm+NtUPBLRbzcY1hkzoxwyyyGlPBF8tg41Dk3SRPH5D/UlPlMpPy4uEB0BTawTvM5Z1hHoY2YkSki834fWhj3TPtAXoX8Cr/0nQJZBKT75tfrg2wWFcPb+4sLKmzZOjLc6/zZORtgGunU8StMDB9tjRloIo+opWe8lY95kAc8O2Xjdxum6vLcKJzq93b/Qizqa9QA0bUObwJbmmjReL4z/xsDeKj9J7wqRHN3zY8wSQSp3jWikAt+chvzz4l0Q0peCSojT9RZDRK90zM4yqV06D+rvz23XjHGmFWW+TUxcn16UT3mqFtWufxV8IFo5RMj+p9p41dmuU7x22InRkZfq6o6RzypAEXjg+3AZ5ZtmVoaMNRJb54vo3AtDHC86waWl6Gh+6FoU0EB3VRDJ+9ncqNPC08vbpZDgpJZXyLuMCQRqDCMVJaDzme+b5cohi0fHD6CjiaEEGd7W4J2xW4bicnnALk6MARJNdPV7mDemreVDi8SV5yUq9H+E6wGOEcaz/DJjpdwVFWaOgiLexRsIHRMt4UWhJbVxDcdHnu1dhOihqCvqAURbkaDJI2XjtCrgUDZByDx1LY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9120590c-995d-4612-d6b8-08dc68749fad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:48.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXiXVu2UlgC2fsBy/7UPIV51UKdIBOuVls0x7v0kADLrPc7VGSK5WJo7drS8OPn399fEozAsqVLCsigynvfzxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: F-RIy3EU8DDCt_LTN95REpuddbvZz3h4
X-Proofpoint-GUID: F-RIy3EU8DDCt_LTN95REpuddbvZz3h4

Add initial support for FS_XFLAG_ATOMICWRITES for forcealign enabled.

Current kernel support for atomic writes is based on HW support (for atomic
writes). As such, it is required to ensure extent alignment with
atomic_write_unit_max so that an atomic write can result in a single
HW-compliant IO operation.

rtvol also guarantees extent alignment, but we are basing support initially
on forcealign, which is not supported for rtvol yet.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    | 11 +++++++++--
 fs/xfs/libxfs/xfs_inode_buf.c | 36 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_buf.c              | 15 ++++++++++++++-
 fs/xfs/xfs_buf.h              |  4 +++-
 fs/xfs/xfs_inode.c            |  2 ++
 fs/xfs/xfs_inode.h            |  5 +++++
 fs/xfs/xfs_ioctl.c            | 21 ++++++++++++++++++--
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_super.c            |  4 ++++
 10 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 0c73b96dbefc..8e32fb068430 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -354,12 +354,16 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
 		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
-		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1088,6 +1092,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define XFS_DIFLAG2_FORCEALIGN_BIT 5
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
@@ -1095,10 +1100,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
 #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 12f128f12824..5e42ec1dadb6 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -178,7 +178,10 @@ xfs_inode_from_disk(
 	struct xfs_inode	*ip,
 	struct xfs_dinode	*from)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct inode		*inode = VFS_I(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
 	int			error;
 	xfs_failaddr_t		fa;
 
@@ -261,6 +264,13 @@ xfs_inode_from_disk(
 	}
 	if (xfs_is_reflink_inode(ip))
 		xfs_ifork_init_cow(ip);
+
+	if (xfs_inode_has_atomicwrites(ip)) {
+		if (sbp->sb_blocksize < target->bt_bdev_awu_min ||
+		    sbp->sb_blocksize * ip->i_extsize > target->bt_bdev_awu_max)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;
+	}
+
 	return 0;
 
 out_destroy_data_fork:
@@ -460,6 +470,25 @@ xfs_dinode_verify_nrext64(
 	return NULL;
 }
 
+static xfs_failaddr_t
+xfs_inode_validate_atomicwrites(
+	struct xfs_mount	*mp,
+	bool			forcealign)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_atomicwrites(mp))
+		return __this_address;
+
+	/*
+	 * forcealign is required, so rely on sanity checks in
+	 * xfs_inode_validate_forcealign()
+	 */
+	if (!forcealign)
+		return __this_address;
+
+	return NULL;
+}
+
 xfs_failaddr_t
 xfs_dinode_verify(
 	struct xfs_mount	*mp,
@@ -624,6 +653,13 @@ xfs_dinode_verify(
 			return fa;
 	}
 
+	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		fa = xfs_inode_validate_atomicwrites(mp,
+			flags2 & XFS_DIFLAG2_FORCEALIGN);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e746c57c4cc4..a9ae8ab7d610 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -165,6 +165,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_INOBTCNT;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 		features |= XFS_FEAT_FORCEALIGN;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a18c381127e..6e7ac6c90ec1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2057,6 +2057,8 @@ int
 xfs_init_buftarg(
 	struct xfs_buftarg		*btp,
 	size_t				logical_sectorsize,
+	unsigned int			awu_min,
+	unsigned int			awu_max,
 	const char			*descr)
 {
 	/* Set up device logical sector size mask */
@@ -2083,6 +2085,9 @@ xfs_init_buftarg(
 	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker->private_data = btp;
 	shrinker_register(btp->bt_shrinker);
+
+	btp->bt_bdev_awu_min = awu_min;
+	btp->bt_bdev_awu_max = awu_max;
 	return 0;
 
 out_destroy_io_count:
@@ -2099,6 +2104,7 @@ xfs_alloc_buftarg(
 {
 	struct xfs_buftarg	*btp;
 	const struct dax_holder_operations *ops = NULL;
+	unsigned int awu_min = 0, awu_max = 0;
 
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
@@ -2112,6 +2118,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		awu_min = queue_atomic_write_unit_min_bytes(q);
+		awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
@@ -2119,7 +2132,7 @@ xfs_alloc_buftarg(
 	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
 		goto error_free;
 	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+			awu_min, awu_max, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b1580644501f..3bcd8137d739 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,8 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
@@ -393,7 +395,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
-		const char *descr);
+		unsigned int awu_min, unsigned int awu_max, const char *descr);
 void xfs_destroy_buftarg(struct xfs_buftarg *btp);
 
 #endif	/* __XFS_BUF_H__ */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index db5a0f66a121..d674fca22de9 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -609,6 +609,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_COWEXTSIZE;
 		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
 			flags |= FS_XFLAG_FORCEALIGN;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3f13943ab3a3..d796456215e2 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -321,6 +321,11 @@ static inline bool xfs_inode_has_extsize(struct xfs_inode *ip)
 	return ip->i_diflags & XFS_DIFLAG_EXTSIZE;
 }
 
+static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d1126509ceb9..94a6d9f6d0d8 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1112,6 +1112,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
 	if (xflags & FS_XFLAG_FORCEALIGN)
 		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -1122,12 +1124,16 @@ xfs_ioctl_setattr_xflags(
 	struct xfs_inode	*ip,
 	struct fileattr		*fa)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
 	uint64_t		i_flags2;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or atomic flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    atomic_writes != xfs_inode_has_atomicwrites(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -1164,6 +1170,17 @@ xfs_ioctl_setattr_xflags(
 			return -EINVAL;
 	}
 
+	if (atomic_writes) {
+		if (!xfs_has_atomicwrites(mp))
+			return -EINVAL;
+		if (target->bt_bdev_awu_min > sbp->sb_blocksize)
+			return -EINVAL;
+		if (target->bt_bdev_awu_max < fa->fsx_extsize)
+			return -EINVAL;
+		if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
+			return -EINVAL;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index a8266cf654c4..5856a72d431e 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -293,6 +293,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_FORCEALIGN	(1ULL << 27)	/* aligned file data extents */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -357,6 +358,7 @@ __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
 __XFS_HAS_FEAT(forcealign, FORCEALIGN)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 63d4312785ef..757c90b3d71b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1710,6 +1710,10 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 "EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
-- 
2.31.1


