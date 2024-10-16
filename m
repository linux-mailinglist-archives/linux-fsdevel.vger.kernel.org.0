Return-Path: <linux-fsdevel+bounces-32087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0149A066C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7141D1F25B70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135ED206944;
	Wed, 16 Oct 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BP1uftVq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z1yLVznL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3721E3DC;
	Wed, 16 Oct 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073042; cv=fail; b=tPnT7LYKJrqnod7MAuaqe1Qa+4TFpNir9XMDwDQjCumXyjchbWWefcL8OD5OnXaMFC4nOCzp32S2FeTNUu3u20pJQNJq6RdfRTWHchW4bZIldolqemixKzdTiDBle5z/EXkvLPziNviQ6u1Q+KIiVWl139CSUbQWoQyeAOmiZBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073042; c=relaxed/simple;
	bh=X3U10wfn6VZKScjWTDOaiqO+ijk2vv06rH73YhyzAOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hscaqralAM/t59o+Ybkp8zU+umSedxy+T2VJqd4ZHq+VgEk3U4cVlBqzvBGUbnHpaGbTKZpZOFi5X3xp2EjtI7q4Bdrbww7U/MVODR0eZ2xw8al9rQ5XWjZIs0O6833VhVYgWKv3C1riS/mR1LDAibfXvF4T+XQjksFWFaZppOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BP1uftVq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z1yLVznL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9teBX001150;
	Wed, 16 Oct 2024 10:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=; b=
	BP1uftVqabHMNV0HrW02rCuArpGIReKauYbYUOGkRJkgmT12cZtu1qz/J3QZ1AcE
	fOeDsZ5NX7mSoMeefLY+qtO47+nWOx1e7TtLggr+3jHmSUygsDXslMjQnYwupmmY
	Vfni7Env259ePYfQYhipIaIp8YjnY+P2B1tPL0W1nW20Ofi7GlV44LvCr4i9DU8U
	IQ+Vj6/zAYSjY+6QlotwxpG2VqfETY404todPpuGmzqaYqZDbI1ET8UCWb0v89Qc
	V3Sit2io8M5SkByJaoD1MWHqm2CasbSG3RccDO97y4J9sx6OmnADbK2nJ2yKemSF
	gGGeG3L5TX+7JFQfyFHkNg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ckpqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9ANiX019471;
	Wed, 16 Oct 2024 10:03:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8mrgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUuWILLTtOJTIJsk69t5wLKy/D3Yk+2hht4XLk/ZWXqzyuG/2tGMBlzHkVRNxZNvq2D4a1D75c0RX9XGkNcxSERC1R7VL6waMTIm+BRzTAGGWpLHCs9DMmLxAx9pKrzsHPdpR/6jo5lWQZlP2eujHhLea+JcDdQRpEGy6Our7042UEmOWNuYds5HTiilxHRIQ+oI3KVk77MYED+7IjHXlYal2oWzWC64/mCqO/ah/ECKwrl4NFsb8ZBPz8A3Kl7lAl97DCevOd8+dHivJlL+BGPeozh6P8bqpGF0qaNwGseLAwPGAbxAyZ/CTHcn2hsMXVqyA8DEim/lcE+WHLuQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=JwD84ub5T1LjL8h1eRmzudg4b5rcbby6EKBCsHN2ngwE7QmvsgZ9ApgDjrhjuK1NgYqDPNy4Ree51ytPxQ6O27LBUp1KQvComqqOMvXsFM0czcvPtneX4xmjFuOxQJicHb/QgX5B5IRZnwQ+xl5vKn4Ddo3A0wD867IQ66rW5uQ/CoiyY/gHcNbNteDt9YnK7U8BRhY+kg8UNkNPtaJD5MHY6oPPrwO+b7eD+tbqT6VBGeRbWkGgHrHZPatAOIt0333dZrZLOrof02OQxvb91Y3kA1dxbaeYQO6DNie6UbWi6RcBf/9/eMa3vBFOpTTVFnKbheSD49D4HOg9Xq8RxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wz+PKAUG3I3uWHJFoCK8hDmtQ0OHydkijKbkOLn0cE=;
 b=Z1yLVznLMOZ6bIrbuF9hBp25QxE/gkBQJvUiM4UXHtibsCZAaVdZcetsvuk9ned0FvPAIt4pOKw/NnrNCYSUHXFsQTgSFnSIBLPDZGsWegFjqGIrnAXQDgF9Jc63tP8rLqo+WHTSsC+SDCM3WLpNUMQXPy0VeM132vMw+/rPFQ0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Wed, 16 Oct 2024 10:03:18 +0000
Message-Id: <20241016100325.3534494-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: af2d4001-c4b2-45e8-fe25-08dcedc9d0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+djMUAuY/FQ92fZIENw2NEqouvW/e+bxZTjsFUUp2vOdXj7UE0YyLwUzoWwN?=
 =?us-ascii?Q?8JLwFyZ4aJp2HBQv23+mZDJs3T/TwNpnCZfDoB4fqRL/HTKO07WXW1CevO0O?=
 =?us-ascii?Q?X4jBpvjiNkCQtFxo69g1G5VFGnJxLya5XCPrXBeu6OE80Fer/k/XXllm5h2d?=
 =?us-ascii?Q?KXzBOPArB3TV3kEm4TMEDR/pDqB02fiHkCF3fQrtsnbeBoNLpIbuxGSnHTZR?=
 =?us-ascii?Q?4RTXErAxcVeuqe6SJ3dnvW3T/5SmMu9kYKHd0PFI+nNLq05IKueS/lQyHByn?=
 =?us-ascii?Q?7TdP1ryMd60/sQbo/HxXHp7QTHmLVpmyb/nlamWH2ifKgbHcbvx1rYXMIbTi?=
 =?us-ascii?Q?5FX3yHFhjQHbzHuY81IALTagnQcmqn7bWe+EsJbJEsa10ALmYiiDcBKQzhjM?=
 =?us-ascii?Q?O4at74AxVRQrjrnO+EWJdupOo2EER7vOJ/tC7LTaNgETHtlrqdTd1K/SObW9?=
 =?us-ascii?Q?g+R2IJrj9BSsiv9XXWbqCXVrHSJBxcj81mRO45JASIBZyoRyShcjwQnZxJIp?=
 =?us-ascii?Q?oQjNW+m1QshrErxW6CFlBf5IaNwhrhbSRC+9XTvwFZjK88ceMcJnk5R2uglm?=
 =?us-ascii?Q?SshLOmyS9lTvmb3/Um9VIL+LXEaBLHFH3W/Z6VbsZ4OseHsHoJJnoQUvoRi+?=
 =?us-ascii?Q?F0b4ILsjz1QHFcx06qn0Lz9ngop8oPKQyzPkw5UPQyl7ygUnZLBkxceWY/Ls?=
 =?us-ascii?Q?J4VGt0hjXZy2ZtiPvnYK2dv4pzUPVcX0GiObs/2jtODSuuDhUMbd34Y9PYZO?=
 =?us-ascii?Q?Oc2zCpSucWO0OrsObIhDO2VQuKzwCiydOSOICSNs2GIbL+kCS1dXEMwSrag0?=
 =?us-ascii?Q?xGSU1TvzcMUN4nw9fqrFvw7AjT5yx19xQx2RwRPKqJgrR+/x/avrZ0rxcLGQ?=
 =?us-ascii?Q?JplAQGG9JfJmeij67IEymTRuK7cvpTDKeQWdlJWrhVPJYytCb+vPnDl1kG+i?=
 =?us-ascii?Q?+M07uyJ0yzyUpd7AA+ZrKYW42kFgeRwVn3Oo9MUcJIKKB0fLviNSF6PZax0J?=
 =?us-ascii?Q?UI/VF/yX0FPslsca+uNKzQEId0W7ps39HMKVySw/LKWlBCs1DWWNhEcwiM4Q?=
 =?us-ascii?Q?15ZSqWQl4v6cjBVcVghMkG84MCBFNIxeDqq9dqhTGuBktHcd42QqL5SGZYLI?=
 =?us-ascii?Q?8QeSfFjqCHdEeqLR1FLPEJH9s3HFePh9x/MpDJcfxaC+SlraHoikMA0ga3Tr?=
 =?us-ascii?Q?rKvnFQPyMLiyipmKzRDv1wZxXby4qAhOE3Q6b/gzAzAEfRiT9PgUf6OMGJJw?=
 =?us-ascii?Q?jXEXSavHymhZR4Oh6edxjcCBPvJhz0RxCC2i7qX2I5IVQFBqeJO5T//j7Qlt?=
 =?us-ascii?Q?gyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyL+uVHS7QPaZ37CmWaipaOZ4GvHf9o0TDThSeJxpsX+czC9P/blvJTB/ky/?=
 =?us-ascii?Q?jDP3x1rVemFptO5az59ZwLA7y2MTwmkcGE9KnidQ4U6MW6ucF/Kgoi5D1PCU?=
 =?us-ascii?Q?+VpcE/I5cmgsmIHG00doWWUp9DfrPmwa1Gb9o5c8z1504iMWFweIBs0gQSzV?=
 =?us-ascii?Q?kVMMqFE8qZN5CeQZSsLMqHs7f1MnPCgmpsCA/1t+n6+m4F0VAIs2d4l8HBX8?=
 =?us-ascii?Q?yqIu20bVHGax8Q3u0+UHz/Vl2yWp9HNuAZ/QgfE6Ooc2IhGvcIPbEYmCXPjE?=
 =?us-ascii?Q?ePSXWHX0mnhKF28DYBOpUMJ/uCyw4G+e1YhMuWa9zrRi/pLtSzUiDpdM44er?=
 =?us-ascii?Q?TocXay4OVnsJXmpecaAY3vdZpPJI1ll4pZJhPTQb0OActvRoIjFk1vVPjgW3?=
 =?us-ascii?Q?7ZHaaQykFAXUvq11DMvz6pE+prTqrX6lSGpu9byKnMTJswv22lUzv3WCvU2M?=
 =?us-ascii?Q?s0XwiO8W4tw4SijXicy9MutsZ2HlnIYQff7kv9yrKmi+uwDKJrRf0XD+4VKQ?=
 =?us-ascii?Q?P98bCfK4G5ic3KV8yAJ1keqmfaB6XhcKm6iDJkWEFyrLWP4kKbDLfmURw0WH?=
 =?us-ascii?Q?rCs+285x6385z3i7THtVUKRsgoBSiR9bm8M93H/5eCoeOYcOy4DjgIbdDL38?=
 =?us-ascii?Q?6mz+uzd4Dj0P3qwTwLFqNeyoRt7wD6o7fVUYXSwH9o2dsca7B+zUCeN9JIWR?=
 =?us-ascii?Q?DO9oJvqo5GQcaqvx2iNrM8oEFP+j75U0+xTRLguMq78I8yLlnC6w7XW1cTH/?=
 =?us-ascii?Q?C4jSP5W7Cyitm63csjgzoTh7TduSgZHkhyr2WK7aaoSY1LqM2ryA4r7i83no?=
 =?us-ascii?Q?mX6jayIY9FLjDOHoVlLMeqJCyvoov+tsV3gg5PCENKyHL92ULniCY1IPtA+T?=
 =?us-ascii?Q?NuVilXbWG6hzBURL9gu+9urrWqGVO8dfiVWgrT0kK4d7OktFFFFs9PTYRemg?=
 =?us-ascii?Q?bGs3WRMWW4ZKRFXHnwDPajukuxVPOrueNejoWR3oLEernGqPSrsiujJksAdQ?=
 =?us-ascii?Q?fEzQcly4v0MLeio5PMVie2AVmn48zSWkih2fz0d1tdhi7aelr0+LLc1v5IP2?=
 =?us-ascii?Q?U44pDlWU8K662sZQXL5/aSSACL0/fu7i++NExqHds2XYFr1qMR/4VTw17zUD?=
 =?us-ascii?Q?zAz5ae5lR6oSU+HONMjqWyEF+3kzfj8FX/b68n1Vz4mgIbL7WAR2bEtFc17E?=
 =?us-ascii?Q?s9rulyAQ/CdMKzcbGWYdBLch2qKFAOJmq62imbfP7wukC9n4oJh7SifMyhhG?=
 =?us-ascii?Q?TlxlrqBueOZuAHvgUfrAcLqJ0GH4YmlByFHZtx7qNYzfNn7sEILGvf5fxqF5?=
 =?us-ascii?Q?ruwO43R3VaGUSOkgvy8fcg8kCHcez+xAG1dDC1DpXywUI7J++Wppg5SJOKt9?=
 =?us-ascii?Q?lAdI9XpoTpm3Myan5LNX7bHXTSbuYKwEQebAelFGE5DY3cUQYuA9TTJMhr7q?=
 =?us-ascii?Q?M2s4oxxDL7dauAq/EesrmPPVIagr2eKqRMupDMWkVfB1f8WQEFlIAwShijir?=
 =?us-ascii?Q?boHPDB1S7ZGm1IpVTVfo22/B4Gg38EwgTm9Hjj6CWHyLniRSgi2/ZTHFHPWA?=
 =?us-ascii?Q?Z9TeB0YhSFbM1+SrN2xni020xzDJfqBuUSbAQlE2t2Z6cSjw+s2tgGXSopQF?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gef1wZOyQJeNWF0JURc6QH3cmgBM3pigN+Sg2X2Z9LhVYHhkebsNiP/mfr+ZQuOjhjwkbu0gJxvxZtjdMM55zKN/olknHtp3me7/wRfhAy8nkd6uOiSrrQyM0aWsl7Ko1z1X48ZoW/mhEO0AA9ukWsizO4jNjC7/pRNA7USFBJ/Z3N/QUmfR7oRKySWQNxUigcB26iSLoutETTwg7bR7QDBfv2rmI3E7wiuoq8TVPurwlDXIX5JG6zxNj9fvouugN6bNcGhTsseIXHllvfS2swPLckv5Fp2v3BorpNscMJIAA6n2XEXAeLssuJ6NzYbFCeaG6F+hD8ddYlHNI3Uy9KoMx6N6Oq0sTGloQWJyDGpmZ9xLD/70cRHMoY4jAzvtFn3uOStrUiOTQNyPN0RVHPLGAXJZkTwd/qBm6BYRNOGl1NH9KkTtjgGb9kv/6TvIjIeThTeYJXV01ECp4fxtRNUnTBWYacLsMCsMv1swv1CiKIN1OmDPap6Clz4p7lcK2w01KfO/EBC+RBO4H4CPlUJATkWYjkZY3st89YW5L/Abg64FhQbzkAB6FjeXAHIfo2GII0UNIiKy9frfx4iEDuKzvGgSM+Qhjyh7LGdLvEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2d4001-c4b2-45e8-fe25-08dcedc9d0e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:43.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvENMEjr69HVB0EJwCBQEL3bjq8nI395PJxu6k1wxR7FrHKl4rVY5uyU8bdefkr4Uf98sRHrZ19frigyefFTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-ORIG-GUID: TCUXOZf03HXU7Ntpm0BhyqEoBBi2llq_
X-Proofpoint-GUID: TCUXOZf03HXU7Ntpm0BhyqEoBBi2llq_

Darrick and Hannes both thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 8 ++++----
 fs/read_write.c    | 4 ++--
 include/linux/fs.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e696ae53bf1e..968b47b615c4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -35,13 +35,13 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 				struct iov_iter *iter, bool is_atomic)
 {
-	if (is_atomic && !generic_atomic_write_valid(iter, pos))
+	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
 		return true;
 
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -374,7 +374,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
diff --git a/fs/read_write.c b/fs/read_write.c
index 64dc24afdb3a..2c3263530828 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,7 +1830,7 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
@@ -1840,7 +1840,7 @@ bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos)
 	if (!is_power_of_2(len))
 		return false;
 
-	if (!IS_ALIGNED(pos, len))
+	if (!IS_ALIGNED(iocb->ki_pos, len))
 		return false;
 
 	return true;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..fbfa032d1d90 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct iov_iter *iter, loff_t pos);
+bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


