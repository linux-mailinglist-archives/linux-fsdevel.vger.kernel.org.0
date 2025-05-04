Return-Path: <linux-fsdevel+bounces-47995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAAAA8517
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D60189B5C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BAA1C700B;
	Sun,  4 May 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrOKf13x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jtMr7yYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD81993B2;
	Sun,  4 May 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349229; cv=fail; b=uI+kDRZr+TlKL9qzyIj3f62jMHpuogRZbT0+80Ju5/UndonTOwX58TCTxeIv0x4jdk52+Lmbsw5wBNrIXHSlfKFh+aRPxV4ijsdBV0ItSULSWuLWm7fDgySe6Pw/v4xVI0Q5pD8ONogJom62kN8X3c9ZChLyb1HRSnl7jB6nClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349229; c=relaxed/simple;
	bh=lESyKXmcD/WIInZy1ooaRbLsrQrEG0WmZvzyJ3JgkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAMnPoabOl14okQLMq3spnw+F5I3kB40zcY8SegyMciw5TILoW2cUNbXTphOtgRyY7hJqCsZzIYmDbjIP+e7LqHIvffG/75IyBocB51oKJ0lG+FFmMABiIkjxU3/TUqtJi27WpR5He7yPbSNhlqJdi0RjB/h15LdYJFWn97Sk2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KrOKf13x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jtMr7yYQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54483pjF022462;
	Sun, 4 May 2025 09:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=; b=
	KrOKf13xYA61kRoTLErdOTR3kNw7Ooqsv4BhZ+A8NGEZfRYwtz9PU2Of8+gsvEkc
	/52hT5JO5d1au+gxRqq/u3D/O76+SXO5u2EQp/lNwSAN/1iddE+qWTDAGZB8szgZ
	CKwiAolX0xlH480saUidwTB5TEVZiBMmuC7TpsMsRirfogX05i7FuorOMvxe7qLe
	EisAfV+5DGJOkZG4Tw4tNDWI360YPwaEN4OMTXBAjU69OLjIWeyGb2QuuMGIbaVc
	8McxPcP/0iuVb95g0gzuDQUGEdNtnP3h6o3cQRSJ9h+Sm+8G8urPrgI9a4rmnve/
	aFhfO1455mqSodkvuGxG4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e45cg24q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5444Nu7F035905;
	Sun, 4 May 2025 09:00:14 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghqy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GITCzhQp6EKSmWozzEGKwYNYdWZgbIH28oPE8ZV6z4kEqei5+M1t4DABsK18AK3d3zB1p4gbASKLnI2Q7siKnYfh4x+W5m0ytrIQzHppB981VH/mK3UUKU+c20Xdui1DnjK6wAlE8SLrKFsaYwsdRsrKU1fdOlA0XPVcLN2VQ0xz96HKZp5/Ey3SkvHBiQPEtO98eatgdvJzv6TFnE5d9c/IgyaF040f9iP0IZ7rmti8zHwtOhcAwQFJxH5BD7A22PlP6jy5JmHuJRewsSAUPRiVXr5yaPcqzxXO3ASnM0o7mVwRoylhJqv5Z06LLzpRLnXW+goPBXuGp+6KWcK7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=vUMDWcpX6+ZSp9yLHkFYAWqaIh5O7cf68A9v5xI6XUsQBYKJJGC6IZzj4/0rhgIo7rOmteEHZQJ8sdk065mpV4hXp6oviiIGQa5aRjfNqWe4R3RZbCbgMypZTNq52rwNGYA7DkGiEABYsbCFG9j1TB/Vg+lwSt5uQzc7ZgpwyIQvXW13SdIQDk7uRiuK98IChkEm+nEykEb5W2PQK8Grtlpa7/pBZHIyl80AYG57EpAvWk7heZ7mLJ9lcArrgrdGGsnVTo/IKVJnhDskS21rjaro/PKb4Cz/XGjb3eulL/LX2/QKEamYCWCn7U/HsFA+PTDVVYoFJ1cXABeRsHH54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=jtMr7yYQyKSLuLxEAyT++3Vb1O+Lxq3ADVcQtAqnCquUW2aYYXealfzURydiNCk6NWTGU+4XS3ACLx1SI+iP0dwnFgFb9+X4QLZK3FzDQV8qIvPo9QOv1BmUVc/Emozbi3q/Lis2unrLBeyR46pGY++loNxh+NHh7nyI2C2bFCs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 12/16] xfs: commit CoW-based atomic writes atomically
Date: Sun,  4 May 2025 08:59:19 +0000
Message-Id: <20250504085923.1895402-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2d866b-4f2a-4e3d-abdc-08dd8aea138a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFfMmxV3BFpVuBEVqEIJpGOYpDiYG7uWAObBR1SM4wSA5grUJ4KOvuRv1Csg?=
 =?us-ascii?Q?WA5Yw6jtPevyj+P5oCuN/SdlPOextL/ym/hDAK4Or5QSeoWxvPUlRfgnZ8TO?=
 =?us-ascii?Q?gNtOv2jXb0F4Sz7zC6zhh6eCR/F8I1+9Po2pXzgBmPX72asTgk+FiB8QfRt7?=
 =?us-ascii?Q?fj1P53DY+EHE+7l7S2QZ9zn6DZ8O35dpReN7zU/fq/GdBT7UrNjdpe78rNbO?=
 =?us-ascii?Q?ZH7kxWv9NkJ0vmZDif0jIeiesDfrzGPnks76YZtKvZRE+U2RUe/y4/mnSrx+?=
 =?us-ascii?Q?lwrmEYn4XF3I2RH9He9TgeIeMYZcMSR5WX1BwvmNjJ51ELCiMz1sYF5qFQmt?=
 =?us-ascii?Q?/YjkzsqaC2DrG6wo0OgffuSMF4NpTPMoVWBfuvt9Tt99BLgSnBqdT0Qk046m?=
 =?us-ascii?Q?MUYo7VZy0rhnPKRW10U2QWCdM19Jz7dEzb9fQk4H8NUsg1qOs8bdW544PWMb?=
 =?us-ascii?Q?rFHs6QUyfwLtQGBr9vX3HvRqZTtW7mPxhLZzwJD6apx32YW4poRQtBvn4vX2?=
 =?us-ascii?Q?LPiV82l6dBPFVObnkEczg/ru/qBH89k4hlxUUNDoklrUOVBJIAIYL/ixMmE0?=
 =?us-ascii?Q?qlHqcDAE5B2GhIM6VNgP5uz59Nruaf6JQIKBl3HMeQ/SdkPBeY3lck03okPe?=
 =?us-ascii?Q?cYx2wGN7xZKVgX9t644jmLBytcEMc8OCb3wJXHYT6gzdyId/uRO0h6UyYIGf?=
 =?us-ascii?Q?YpSsBaPkDFJ2PY92iI+Nxl1J81mNsU43liz5mRUXm+zG/D78mviTHh03skKo?=
 =?us-ascii?Q?wNvwBa2BxBiEqYpfM2CtHgF+IUNiccAFhAuj90t1h4ZGdm8vlOtDB3aGaumc?=
 =?us-ascii?Q?6Xi3q4QBu+mCBHFxoqU0e++Y9jLijlVCkmwbJ+Gf6/vIr64wMR81Xhynz5hS?=
 =?us-ascii?Q?sddhONBHuvSSsPq5jkGFyaPwYfDCb/S/7PP0JORWOva5nuV1GkDU1eR5uuRI?=
 =?us-ascii?Q?GXhRCf6hu6lVn3FS5+tgLJvfm4c3Fgtuw6057IlPo1M1Kom+81GpY9BvLwTR?=
 =?us-ascii?Q?IH5fXeaIZpkq+UNRzZLQg2NX0aa9MIR50Ydn4hAGPkW3x/+KKENGMkW+eOGM?=
 =?us-ascii?Q?XmFz3bxGs1FwKew9S2ljhoDDSekn5PzDlBQ7NGi8l0Sb1T/g1ObuinHJ73Gt?=
 =?us-ascii?Q?LMx5+FbOt2wnNjezCbbDUREZeD/jI26ZMiJm0qTdHCb0kV2pj7cIDirktUa/?=
 =?us-ascii?Q?9ZTVOGYlCcR7F7ZEhyUJ0v45PiUd6L9q6XJsCum/mG8IMrvzropmdIl8Bujh?=
 =?us-ascii?Q?7VOsOHPe+3VLuVM+f3SSMYWLEssuS7uejQb59RsAFbQ3k4pyHFzrgq+KbP84?=
 =?us-ascii?Q?b1Uj20yIBuePIUuiG1Kq72epkjSslGdhA1Ace1F/d7QBRMJNMqmRQKn6N+/e?=
 =?us-ascii?Q?5hxH8iEgZOO8viOvcIUrNUOPiMOKZwr33P2GysBnMflGbhcK0NcbK0MVakmu?=
 =?us-ascii?Q?0ez5ySj7dYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/8jRSNPyv1aWzKKvDyKNx6O51jirgStIZ6Ktg5BtijYlON7j9l0UCahhGJd?=
 =?us-ascii?Q?TJmF1ZPNcbxCgqQV6etOYmbAhJZA6q3Mz9NWUJCoDOiL6A6FAza8LbpI4JZB?=
 =?us-ascii?Q?P40a5dZ4SWu7Ox9gD1tFrNcIrcTN7NdDhsthnOZJ/KJdryZOStqY1R5OVvcz?=
 =?us-ascii?Q?fTBgNffUCK7pBK2P/Efr2ne67b7IAU9atz7lDNKqaOkWSOqrk+vSBmxnjpkN?=
 =?us-ascii?Q?fxZaD0WZh8R1JZ++wMWSSsnRZkleBrAAfGQpJDQ0Inb1lFsJTfLInDcnPjek?=
 =?us-ascii?Q?gV5xr1PShslcdPXPg1ustcD+vE60/3nEY7XFCzZkdk51FpQui2g43DZOuSpF?=
 =?us-ascii?Q?c/FstHBCBrqZ5nbfDTaKG5ygU8h7dTF7quzgHGvlgmL8QMy3InKhyWSqENwE?=
 =?us-ascii?Q?syP7k3tXFiqIdTHDeaSoy/pEM5VxdFGIoyQf2KtpFrtIsQb6OqHhV+Fyaeev?=
 =?us-ascii?Q?n/1ylOBncp77i8Z1h6e+nhQGQICZHxQES/VHhUgjvHMImS3Iq0xwWYOMBRqp?=
 =?us-ascii?Q?kC6aCrdVuuPhpR/SNYa+zpyl6/xfy9SmlKi4AtC6B762n4S5cP40U3eU22KF?=
 =?us-ascii?Q?/k7axx309lKeMpghefy+0ZxJsmEoJWBDJbor1g23Fy+TXI1HGPXyl4lMqmMS?=
 =?us-ascii?Q?28hkGUJKasfjpdtLot7eYGT5amMt7d+WcshUJjjhX322/P/oQnMYypg/xjgF?=
 =?us-ascii?Q?nv4ks9NgLNVMlrXJTnwcTmE0tXyBgvsA0PrHsBhWea2XmyQ/2i2C1G8gXfm0?=
 =?us-ascii?Q?FOa3NnVD9QdNBJcnGe2TPY4hvS/SCspfEWL/BYDCaKTxwaNpJb23PVhtOun5?=
 =?us-ascii?Q?NlmBzi4kR9Y9J6t8o1UKW7s21EAecKC4FnxmZ8/Eh1KHzKlAtKlzZhPKLEpp?=
 =?us-ascii?Q?rWLQ5RC6ZGnpurJ8EawbtJsWqDZchq+DoPXgzW/45E5KpM3htusrKOk1azZh?=
 =?us-ascii?Q?Drq/tF9uW2HRlm9lYpMv9eL4vobksdXUbSjg91lDIwYAzJyqXUo/9ErSIx2L?=
 =?us-ascii?Q?3ko4V88p92lM2ayOsu1BfUhwhShyM7ppOEGsswzcupF75gFf3VvxkdrXHn08?=
 =?us-ascii?Q?ME20/ty5fQzBzJTUnZMBaMONusuxhUtrZdEqY87ob1JsV/3zBJzEQEKc+2ry?=
 =?us-ascii?Q?lJesGLulwhwQ79SHLtAO6JGwdXpAJmqMMKrYDMQbkYSSfXhfv91iVL3V2Ay/?=
 =?us-ascii?Q?GfMv1DvBZVjPH24THSX9/F49DPv17132SkMwCYxp4IK5QM0yTDM21z3LCw01?=
 =?us-ascii?Q?zr1Tz7NecQ001TiqWIIDMKboXzY2LxvpEusVIACPhT8tELYFhoWz+Yxn5nb0?=
 =?us-ascii?Q?74YD4xMzg9W2GTD64r/HaCD1vtbr3vqyXHY0s4WFam+zq8uVUuX7aeKAziNr?=
 =?us-ascii?Q?hf2WJkrzR/Mf9Do5or+WAQXliMYvGbwiwtLv9AopddtSSb+ZVinGdgBEOAw4?=
 =?us-ascii?Q?S3pjlIEUOTUY1gR9LOCO4AngwIFPZxtH+6RPYjWRgSAS4Bo/KdF8R+bLe9NL?=
 =?us-ascii?Q?SLwvTKSiqKPQgwtUOwQe3ef3yaXIRORko8GokNS8jYsMW2Sp4Vqed7/K/Ye5?=
 =?us-ascii?Q?S5QGsP/p/NKRIkqnNHW7ovogR+YMt8vR+S2VJ3AKeyf/b0O70xxAyVbibjJG?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vrFAZYKiSKUE9szCsN5LHhAlHU+geBgFUIsfgCyA7kJc6DMvna8iU2qLm/iQQCkEKmn/ojGtZa95pFkE23tVVFlhLbb5pyowvKXAnhbelBuKwarWiHo543WPhfqXyKgEAda0GZXa3go3/lsGFoXuPlKUEbf4CojWz9zwlArxj3RQrKJee4giLr1cNUpSMDB1MaKGpcZ+DHG8PNgoJ+tvAGm91CDeAwAQtYiw4tVRfoKR8BJOkNDdjv4+8THkEhvmnwkLYk+9xm2dymzUTfYWe2dAUBv/ClCYYO2xgSv69zjO4HuOZBwDFJYl4lS9Ue4j0gTtfZ5u32cUalDDUu/V0iemF0Blzrdlks5n6YJ13qP2OkSQ9tXhkmB1QkEGqoj6ACJuWYh/Fc0Ux+qEoIX9etHZGc18mSDGI4HkvnVVQymTmE+cnmj8H3vmYETYNTrsJ1Idgq2V8SDrflHPEx4V4ZGrsRS4u7Zy1L+i8kQMukbV8OYIK+Bt9W8D/2b3Fq79yGrK5Nd9sAGNsoNdvGKcz6Us6RQKNaziusto79vyQfdg5mYeecVwqT6k9OZe+n/9ZkdPkv4IO8bZ49eyJfGHAbBn7QETXgz1f7ILZz7z0K0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2d866b-4f2a-4e3d-abdc-08dd8aea138a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:11.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHK6NbRqtb2BHLQVrsYqwhPHw/UEBY4y6W1Dvkf3vyUw2Fa/viwkNbEUx9p+ngIfO7rCJkJHIaKcbTvtRz8YAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-ORIG-GUID: 6TE8HyAlYEJ_n6aqSwTvfi4cV5ygqbOC
X-Proofpoint-GUID: 6TE8HyAlYEJ_n6aqSwTvfi4cV5ygqbOC
X-Authority-Analysis: v=2.4 cv=IIwCChvG c=1 sm=1 tr=0 ts=68172c9f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=psqDkX_6r_7HCtZpQ-8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX0mAPKJ9gtdd3 us8RXbt7FuiMdIn3XEq6Orhz6kGmBrQhoAdF4XRjgFaWnmU8mfKoPJ/3vfT8a3zyxksU0MyK93t WM1XzDSzCjs6uCFv6Qh7dBKDXG7XAsMaylYvmXnkzZ7dQwldEas1OrqFjqIu6w5ak8QqZSoqiaa
 Vag8oGS6IgmyF+jvSQhzzXec9P0cydB5Dz8CIEP/mpGp0OYatzV0/2WBwqXR69nh7LvfkqEnO6L SE193/SFJOubWp2iBOntfnK+GyhtnvgULTorxmvBcFPNxsHmIfV12r6yx6IFunGzKpE9EJ2o2vm jMCLYJiwECuA6R3+UmQ9c6NQBXgqtsr81TTup545TP0l91qKrF+qVyZS9dFf4E3+hqgGv427KkR
 OkshNjGisGoo1MCaR1uATucFnJ/C+9BYR7vLp2xGjLSS8NMxQPd7xs7n73Fo+9s/HBS9hiea

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add tr_atomic_ioend]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_log_rlimit.c |  4 +++
 fs/xfs/libxfs/xfs_trans_resv.c | 15 +++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index d3bd6a86c8fe..34bba96d30ca 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -91,6 +91,7 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 	 */
 	if (xfs_want_minlogsize_fixes(&mp->m_sb)) {
 		xfs_trans_resv_calc(mp, resv);
+		resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
 		return;
 	}
 
@@ -107,6 +108,9 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 
 	xfs_trans_resv_calc(mp, resv);
 
+	/* Copy the dynamic transaction reservation types from the running fs */
+	resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
+
 	if (xfs_has_reflink(mp)) {
 		/*
 		 * In the early days of reflink, typical log operation counts
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..a841432abf83 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1284,6 +1284,15 @@ xfs_calc_namespace_reservations(
 	resp->tr_mkdir.tr_logflags |= XFS_TRANS_PERM_LOG_RES;
 }
 
+STATIC void
+xfs_calc_default_atomic_ioend_reservation(
+	struct xfs_mount	*mp,
+	struct xfs_trans_resv	*resp)
+{
+	/* Pick a default that will scale reasonably for the log size. */
+	resp->tr_atomic_ioend = resp->tr_itruncate;
+}
+
 void
 xfs_trans_resv_calc(
 	struct xfs_mount	*mp,
@@ -1378,4 +1387,10 @@ xfs_trans_resv_calc(
 	resp->tr_itruncate.tr_logcount += logcount_adj;
 	resp->tr_write.tr_logcount += logcount_adj;
 	resp->tr_qm_dqalloc.tr_logcount += logcount_adj;
+
+	/*
+	 * Now that we've finished computing the static reservations, we can
+	 * compute the dynamic reservation for atomic writes.
+	 */
+	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index d9d0032cbbc5..670045d417a6 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -48,6 +48,7 @@ struct xfs_trans_resv {
 	struct xfs_trans_res	tr_qm_dqalloc;	/* allocate quota on disk */
 	struct xfs_trans_res	tr_sb;		/* modify superblock */
 	struct xfs_trans_res	tr_fsyncts;	/* update timestamps on fsync */
+	struct xfs_trans_res	tr_atomic_ioend; /* untorn write completion */
 };
 
 /* shorthand way of accessing reservation structure */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e8acd6ca8f27..32883ec8ca2e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..218dee76768b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_atomic_ioend, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


