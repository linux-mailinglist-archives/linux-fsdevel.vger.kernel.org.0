Return-Path: <linux-fsdevel+bounces-19288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349278C2C8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9966E1F2389A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5C13D250;
	Fri, 10 May 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Te3Q0ZRD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emEr/ln6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598113B597;
	Fri, 10 May 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379716; cv=fail; b=IrkKcEeas+PTbsCZoKg7dXq9tmi1dXDAJ43CahHhNMNGPO/n2NrRgCXDNG1uwW5D8ei+IGCPg9JQ+luZveUcY8eQxxpGTDKZo5gnVPR4kCjXkQTf06OQtUNxTsQdfT+ZSSZXKa6xWuk8PhXEGNJZ8JJ1p6kBS/j9I/UDpSnLQtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379716; c=relaxed/simple;
	bh=7lQZFLlCQOmo92uygBrIWLV4YDzSgaHLmBapXLwacGo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T10jtEw44+I9beRAHSPLT3qZdk8nuYYb6w3m9ePy85Xg8JTKx/DwDyL9BSzMAVYfux/KWaVwAy2a/uMwmeM21zz38zsoTTSsWDu+sL2UWW2JlsTeRph9NHBZCJMXRzeloxCs+Un1AIsZmkia7shUcB2M05h4mkHSEBX2gUXqets=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Te3Q0ZRD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emEr/ln6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ALvYfu011345;
	Fri, 10 May 2024 22:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qtk2SnK65myvCTT1i0kNbId9OSIZ9zBDQlltkDTsTyI=;
 b=Te3Q0ZRDgdjR/t63SK38wVJc2JhcrpDIzv7p/aO4G21tNRIRIstuSG3HiiQXYQbDxAW6
 N74gq8YczGrsSBXNYhVpUgNNmI6vQUkXY4Pv98Cl2cRy78N81cVQyMHfb5lQw+ksoLtX
 VdKFp/1IzRib4v4/hRQrPjJjZwF4/m1kpT23tCbqMUXqxWCgAAQ6uOvjZEXsnjRZ+qxh
 CfEpqaOzijM1KSQUzCAv2MwdF9SJZ8xrVNyKdu5fd2AH/hWh349BhGzDefiwXBduiMgy
 jZcIXEQwQg6Uf73bPnhGanpnMZhXQZyBj+YCcQln2C/lZyRtTEyFTco/Zq5iVmo5OUy5 lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1uxur0v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 22:21:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AK6kKY019342;
	Fri, 10 May 2024 22:19:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfrpgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 22:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIR+e58l6CvAOy5H2OEvam+FcVwqzVrj6C2U1l3nzF4gPPyGSyajAflELogOEOyxRIAWf7X2JhkEZQ5Lx8Fa89cvS6GpLRJwoqVv1BRqJVl5nJ6DxiGMRlOt1OjUFdrKYENXExw9WBUNobcKmoRmm9+gY+pwXRrmyCpVwW9lSofLg4mj2shhRuXAk+biCzOtBJzy9Em+tWyWIKR4ENO53ib8V/toCBl0aj7m955ZSgq+ByW1nZ8KG4cDHG5J2YFLyjqV02o90hCkvJkhuutXZSKmR7MVTe+L2lpFeYCZM3PPXZIG2tUZDaj9+SlMmbvNdlLXItvTM0ZVDukhi5IKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtk2SnK65myvCTT1i0kNbId9OSIZ9zBDQlltkDTsTyI=;
 b=ansQuOUbD7IUj30iPdvG4+8qDaiAtmqMf2K87VBR9dKt+21YbovDKI3ooi5AdExyKy9Yoq8Ed6bbouJ+kIQxRyy+toZtlG8ozEKNISbJ2P81GPHLtUjjtZcFUdE6BytaN1AtZ1ZTQBKyLr6KzVZSARV63MJlxxEz4KPNclOVPvHhb+Hs0et9UQA5yyWOEaU2pkEHvlhq4OkJhVq8NgQ9JkecBvammiAjVCqh7mLbJMCraU7R2+wycKGx2rHSvp+umz552bduJ5u9PLKslrV/eLKT7QnOdN92RVTHbdf4HkpSVb4Nwl4iZK5zYw/9h7r7L0zUGRgL1WOdvMEvJU/9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtk2SnK65myvCTT1i0kNbId9OSIZ9zBDQlltkDTsTyI=;
 b=emEr/ln6p1R6RgwX5Oo6Q/5pWbladTJh2F/zzLVQ6Fl4hunUsj9Qt5P63qlcYt3zMkXgYOfgZRTDU9ErfrYL1wcr/VdqDf0Nv4J/2D59o5rn/CnRZgtR3fNrA/bkY9ExeRHYBD4OPse2KOLM0wT9/oWd7Q85DBJ8jTiJafIICq4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 22:19:05 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 22:19:02 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 0/1] fsnotify: clear PARENT_WATCHED flags lazily
Date: Fri, 10 May 2024 15:18:59 -0700
Message-ID: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW5PR10MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aab3a6-46d3-4f76-5173-08dc713f3296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p0i4sjj1B60TVueq/Lv4Sw/1YUI0IqicXp/OC/iTBKg40w80EdbnOO4wRrXE?=
 =?us-ascii?Q?tofgy5WzYcBzX3JpyB9ULE9K3zdqVWqSi0sR5l6fP/ejyNOl+fS9cHXjVVtc?=
 =?us-ascii?Q?f/CudGyWZFHs8O3kdWcNJ410Fi7KgYTlckxhmYmoDymWgxdtxyxBzxbwA167?=
 =?us-ascii?Q?BOdxgp2NSadMnTqQ6eL8TrxYGnhhn2SPKVFiwqRxvf7kc2dnj60AyL8jmg8R?=
 =?us-ascii?Q?R18gyhtzb6AxUweWFEGJfYDTdIKSekZkeJx7wZ8Us1vtEKPu6fGBIqkJXF98?=
 =?us-ascii?Q?qCVLHc8v9VF+MF+wibA9p72u3/uUUTSbzkN/q/9fo5i2pCUohSfPiwFWlsF8?=
 =?us-ascii?Q?yEZMWykCP5TFoXL4Bp78ZaYecz4vX/9WweIUQrWXeA022NZMRmHg2eY99bVX?=
 =?us-ascii?Q?n3tyaKdJO1D2LGURQKRwzpZeY70DcICjWIos308LVpDFLjI6/cPcLdAD3k5u?=
 =?us-ascii?Q?eU8t2KTPnRe9DqfnhloZXBdk0+r3B3CMEVK6YdLmwk5bsNb2uS8EYJh2gNZw?=
 =?us-ascii?Q?aOQt9yFhCrLJK31qdYUdDZSfllIzzHfAeC2hkGzoTL96rROvgkG8uHioVWLj?=
 =?us-ascii?Q?/YfJsb+z2E+jfa/ZwvnzXRT5ZjDcgVDjm5XcnHurbW5AdpBmPO/z+7k6+gO4?=
 =?us-ascii?Q?sjZwQjq3zVoW6cS57LxgEtFna2zdFBCGVtyWA0JYdKVVc5F53flJCZ2/lF5Q?=
 =?us-ascii?Q?WImwNrFtB2yrVwKy2yloRh7/SxsBVppp6/vaMXMQUrZjaN1CiYtFKtY0+/dw?=
 =?us-ascii?Q?4NyNsl1bcbdtq5EJqXK4zTymkokC9+zSgfA5fXvNGt4SKptvrZsLzvZfvyJH?=
 =?us-ascii?Q?2E02B63bHxKq++nNUjOFEs36VhzxESojxT48O1JbFjK1dF38PKaygm2vviG1?=
 =?us-ascii?Q?DnZjQl39n7w8llRA8qkWK4czQnHk57QabSbO9CqTPKYRUFtcwvdrzFYab4HS?=
 =?us-ascii?Q?Ku16IOsc0jMLDVhfnJXU0/TVmayrvLt4HCkEuRvAxfA59jTyKXJpEwilHsNI?=
 =?us-ascii?Q?zpmS1n5OhS6NE0o6e1MFm6S83hr5Wpv0Wi/M0DIlVfZK+NrCurHhj/8KgLPu?=
 =?us-ascii?Q?OprQxkBecQ981WEC/Pqn1NAQvxXXjpzjB5CSApPvXHLl/gpJ/0b6U1Jaz3Bh?=
 =?us-ascii?Q?8M2tL6l/2CCjx98s5JvfUxOpcV5Mi/b64gKDdYKSr5Fo1UVN7QVRNjMqcyyc?=
 =?us-ascii?Q?J/89MAVobz7flMAlM3uqvJqc78GsYE5F+LdFH3yP4Jtt1iTEOFGRxjDwRCg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bOCItzT2yg1R0I8JIScUUvAulOtcB487uVNyXfyJa941ks5pTdvVyJGQ32Q3?=
 =?us-ascii?Q?hKg+9s8AkWQuHK82v0JQXaa342t4yRNqacnt/3X8B9j864uBvL2nXqyNRrGX?=
 =?us-ascii?Q?lu5fGuncH/7F71nVPGoLXnMCwpXvHpC/DD5HZ4dw5baZbFOMwph2+hmKQ5eF?=
 =?us-ascii?Q?XJr5HiSl2/DHjnJY9/jZLnN90fech1rIXy1bEBT+rlunMjktCT1NHKJ34Bon?=
 =?us-ascii?Q?wG88BytV4RTKmxZNI8Otjc//DuvGUH0L7hkMkFEzDq0QioP3Zhf4FjscDrA0?=
 =?us-ascii?Q?cBkl/tciPKA8TR1lk/o4rLhS9pEUX8VF/q2TMNtKBwmH/y6lL6n5c3D0CD5m?=
 =?us-ascii?Q?LJJNBW6qZA7HHFxP52HoD1rVhZyGFK5hMlUJlcngtZdPsQu44QD959V558FO?=
 =?us-ascii?Q?J8UnaXrBsFK1m2AQl1zXjVFO1S7ArytrgPWuPcdZBxxd9Q1dBgsXwVejeLLh?=
 =?us-ascii?Q?K2XdhDHdfsYDGa1HUqUT45CEQ/4WkIqgSk4IINjkHEhjRJwy3cGIc9DwhoTi?=
 =?us-ascii?Q?ziRTHLHpyMWx58XbWQAgrTWopAKn56gPJ4PKaw9bDaRwhHCNJ9nZ3/zyr739?=
 =?us-ascii?Q?hZlUA1FijO5kGZAQBlJb9SbS3diIqE+qbzlMuTkExfL0QjSffSV8PenSdIzk?=
 =?us-ascii?Q?uToIv0cDiCGI8Em+n96TEcSpXL/MuQcJW4L3+hH8tpnhxdNX5/KAzPVgoNkw?=
 =?us-ascii?Q?PfTc4GAY5z/I2TuA9xBXQ48oU+HoXcsTqrNvxxJzY09v4XdpHAGMjCpb+vO8?=
 =?us-ascii?Q?CYaduLG7OtsTqV0SubCpZxgbkuTVj1IN93q973BDmUYVp2+fV2DRQt/Gsha/?=
 =?us-ascii?Q?9jn6+R5W+rKCma0/i2EpxJSZLax1yyNK5AzSRCYikEc9wsUV6jqkKcJCwQUW?=
 =?us-ascii?Q?LlfXHHdvGThyWpolepjeFLt8TMBQAf05SJ8o4UP1KdcB9jg1cN5F90X5YN/6?=
 =?us-ascii?Q?E768b6NEK/PPdg8UF2ifRugoaWQUr18NEDKPOwhN5BGXsAbtbRKyFK+Ao2Wa?=
 =?us-ascii?Q?rESnNPbS3E9KFOocNjhHPkSZEDnC+nK9uNXrM9Ge0F8PzfxurtiYy1DhRyLS?=
 =?us-ascii?Q?pO4fh8+grAoZB+XMXq4OUqg9kyMScC2y2ZeH81IU3V2jPXJL9VlcL1mZFm7R?=
 =?us-ascii?Q?57Qg7W52FzuUD8Nf5iHXEmVbXk9oinRJ48Nxd0PCe5jzxpUOYtDkBBlDAxKx?=
 =?us-ascii?Q?WPHEYV0pG2EDgMhSCo/WEMZi12xck16NC8xkSoz/Nr0s9MYpkDq4iEIsPoc3?=
 =?us-ascii?Q?gpzZMYBOC2fFRBp/5OVtDkC1RODr9DWyMMmW/+4xpMnLKgFKFMEOo80ABTA5?=
 =?us-ascii?Q?Phpe/+y1izgZu7n1md/Z1hEIPXpuJjm1qQuBJ9QtNm+GE4lyl8hcxFodtJ7Q?=
 =?us-ascii?Q?wOE+glAGkRN/putT54G1KHGQuRxHyaFKSyg0rBWVl4Mi8f5s35qgYLYeKwso?=
 =?us-ascii?Q?34r86bVwX0Afkx32XhOnLw6P7ulKo3lGjAzBMrUXb9WMeXE1M8oaUT5h/AO/?=
 =?us-ascii?Q?f4sWL0iVoZKXFjaOHKO+QMgY2afcHxkVX3zYNfTFPabpXB/QfYV8OEz+vaXO?=
 =?us-ascii?Q?IfdsFGQbI6WTes4/haZDTFoTG9xav0pnQ8rRYG91DamlCT2Z9kF9gpxFNrrZ?=
 =?us-ascii?Q?Y2besyalRfpVbYLZXRrswAU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RGZIlUbCgizVJMlVezX1ykUaMDhgaXn7WGNFgpaP8pvzRYgAf4bQiETVQr9swSg5qULks5oLTDrDoIkLnc5aKLHZk8sq4iFwpQrO78eZ3szukeTYUbKGyYQS+quGS28BoZ2ur8qxKCWqkCwufjxuwJ1kgDK/zBn5gdZwQ3iKulyys2RErk29okb8Nufqor9qTuHFuMGqaYUqenM5g05dVyaeYotEm0gWPfMfaBpehSpGjIFVLjeTx4mfj8XN/8srnXp+xLiK70wIm/LCtiwM3LJ0gUf/p6DptkUuq4RAfUxtHaoXlQDZJq/71lX0m/iA0qJwf9i963YoB571EZu89bMgEu0ZQ2dzn7Ukq6nOPXbcRdRt+aR7pk2ekeIamKq8pRb8oT5WslK0zcC7YtEkN3TUVM+RlC635lmUhsdbB2/JLnO6qfF4XwG+cfPfeudrPtXX0uPdFjP1wNUcMM8YHr91lMf9wSpwmsrI4vEZkrPO3uuaJ6uWVUzyyUXtrwP157n9w/DuvSF6r9krTl88AI+h0durWfKgiLVFdUKC3liEwb0zV4r8IzHE8buNQWMuRJN4jU9wvxgB6lCui8Gnnw/j/+fBinMKjPXSa2V4RVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aab3a6-46d3-4f76-5173-08dc713f3296
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 22:19:02.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXggTEOB0jCg/KKvIjK2sagq97/MkJr/Kji9R+kWGztFlBJP4YRTcnvnHuCBcKCoZeVHhkaUinzcfGmAgVeeo4xXSqBCdjT0keyTuqLgPio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_16,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=790 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100161
X-Proofpoint-GUID: UqdjBcZ4oXmpDUh9zBviTu246PiJ2WGb
X-Proofpoint-ORIG-GUID: UqdjBcZ4oXmpDUh9zBviTu246PiJ2WGb

Hi Amir, Jan, et al,

It's been a while since I worked with you on the patch series[1] that aimed to
make __fsnotify_update_child_dentry_flags() a sleepable function. That work got
to a point that it was close to ready, but there were some locking issues which
Jan found, and the kernel test robot reported, and I didn't find myself able to
tackle them in the amount of time I had.

But looking back on that series, I think I threw out the baby with the
bathwater. While I may not have resolved the locking issues associated with the
larger change, there was one patch which Amir shared, that probably resolves
more than 90% of the issues that people may see. I'm sending that here, since it
still applies to the latest master branch, and I think it's a very good idea.

To refresh you, the underlying issue I was trying to resolve was when
directories have many dentries (frequently, a ton of negative dentries), the
__fsnotify_update_child_dentry_flags() operation can take a while, and it
happens under spinlock.

Case #1 - if the directory has tens of millions of dentries, then you could get
a soft lockup from a single call to this function. I have seen some cases where
a single directory had this many dentries, but it's pretty rare.

Case #2 - suppose you have a system with many CPUs and a busy directory. Suppose
the directory watch is removed. The caller will begin executing
__fsnotify_update_child_dentry_flags() to clear the PARENT_WATCHED flag, but in
parallel, many other CPUs could wind up in __fsnotify_parent() and decide that
they, too, must call __fsnotify_update_child_dentry_flags() to clear the flags.
These CPUs will all spin waiting their turn, at which point they'll re-do the
long (and likely, useless) call. Even if the original call only took a second or
two, if you have a dozen or so CPUs that end up in that call, some CPUs will
spin a long time.

Amir's patch to clear PARENT_WATCHED flags lazily resolves that easily. In
__fsnotify_parent(), if callers notice that the parent is no longer watching,
they merely update the flags for the current dentry (not all the other
children). The __fsnotify_recalc_mask() function further avoids excess calls by
only updating children if the parent started watching. This easily handles case
#2 above. Perhaps case #1 could still cause issues, for the cases of truly huge
dentry counts, but we shouldn't let "perfect" get in the way of "good enough" :)


Thanks,
Stephen

[1]: https://lore.kernel.org/all/20221013222719.277923-1-stephen.s.brennan@oracle.com/

Amir Goldstein (1):
  fsnotify: clear PARENT_WATCHED flags lazily

 fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
 fs/notify/fsnotify.h             |  3 ++-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.43.0


