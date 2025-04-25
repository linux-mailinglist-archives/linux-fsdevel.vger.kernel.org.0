Return-Path: <linux-fsdevel+bounces-47389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A53A9CEBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2609C1BA6975
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9461B87D5;
	Fri, 25 Apr 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLXLbynD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZMQFQAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886481ACEDE;
	Fri, 25 Apr 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599656; cv=fail; b=UA8BI8+m/iWPB6jt9fDcy21yq09D0qUsYN6AdsH+wX8PD3zOJDn7GsWsWF8vwlZqQdFMTbMbhl3Ig676lK6WLRuLQ8lIIxaE21c+ILGWIjxnhgD+yttzDoo08mfIA7vgYFd6PsEgqlrG01rUI8IVTQgqsjM7UNOijKdx1ZglOaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599656; c=relaxed/simple;
	bh=c8JUi8wAZniC8AQJslOqFhNGOVk8BQNgs5nAEdWV5t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3kf+/zXR9MeBLvhP6MG1XrdAKBm+g/Ti0DZXkng5CEMinOg77llLmkPkzxPPBCPOKLBdmCZMumgEI0qBq8Yec8OwoGdj2ipjfUX4nPvCHldNKLtlA4t+Bmr1zxplZ6tES3DYDdG/7vTP5w7j75i92M9PVQguZfoT4vqAxW0Mbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kLXLbynD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZMQFQAU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWH2W005082;
	Fri, 25 Apr 2025 16:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DD+eRmg1IIjzfeaimxvw2fJxbBnhpj9ektV8Are4M64=; b=
	kLXLbynDkGRhqUv0J2GxSWnyQgL0aMQNiOWcJfJ5WND0SJSUB6xGNf/KlLuwF+G7
	Wzvi/TTkXGPIVHc95lPBgwFtbtzNoAJZDjVa2nvyPjmRZrhjruiDpeECzOfV/WqE
	Ao5Qz9yjYO/Ejb4oBsTVs54BTEO5MKo/YQrlg4Au2pvsGgHAXEmuyXir9//+uniy
	qHROBHSaXKqfxkELhSKez8JgBx8TxPYIypnhiYpxks01mFt+rtymi3ILLwihgTqh
	bQyc7NP0DtGlG5FqqtGiD4ajWBDzmXqv8KC8qQ8lm+KCe2R1d5G/Mtp+7IzHvecy
	kj42vEO6rN+hzqQnXNbDwg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFfdoi025324;
	Fri, 25 Apr 2025 16:45:40 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbtnft7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs7b/m6JH/ARj3E5WQjFyXQCxj92z99i+yaXDj+bp8J6ZN+kR+A8dQppJnuNL6nsfGDZrGUJvbg1n170GreERIaVid70MM36ipuYZ5rRXMb0FBjQRNNys8X0NzsuIKNYEH6aThNGILApZvDRiqg3ZaiHgwJUycb44uKJFrVawKZZK0kK6qBrSdxbka6utJRWKIDYmuDJClqMiIcpOtXvqoJy9bU990rBuPfc7zyFXkGzqcDiwltKrDL0Qw5WKxQFzr63Ft9M2Qbm9sxSvAVyIyP51UISHRomMKVKiNNUX8ySrgTYcZZZA4/AAtUojTwnhVLwz1GN7+LrC6yNvj/iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD+eRmg1IIjzfeaimxvw2fJxbBnhpj9ektV8Are4M64=;
 b=bNhwnLiRcrR9BzavFLhd9iN5ssC7bIXHjpLwsS32Uv1jjfN+UIVmsHvAep0X9HKtCobHwFDCJ0n+OB/BYmoM8QDVSXz4sCcPAydScHSvvI2O+/lcgkRTaCsmYX7z6YWMYqkUoH8NZNHIoGQrygVu/zwE6XgPYrkHR+IqBkb0230LY4xwhtx8udlTP863MR5jpSy83H+qy1wq/2byd1KVLDmlrpAmxJ2uVZBE90/Kf+ACkMAtpzwM4VXQPvdDQqRQl+MaO1HAs++I0xhtLsjmvZ8WHEQxAhIOr6Qqa4DjhAGEdGbsLWvSjNfLSGHbQWH6wad9b40OvtY5Ge36h4bQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD+eRmg1IIjzfeaimxvw2fJxbBnhpj9ektV8Are4M64=;
 b=qZMQFQAU/XODhd6shfX2G1erSk20RiNUpzg7UTXvaoMTHqGOarrxaeSwJRPY/mCFt533x7NLAtGSeTHeY5RJoOMe3HNIxymxbISe6qLohX8I/82Rnt7rq06P2doSGQgwETe9RZLsnwpGZQ7J6j/J/qPqjbfQGS1fKQJzOQy9KRY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 04/15] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomic_write()
Date: Fri, 25 Apr 2025 16:44:53 +0000
Message-Id: <20250425164504.3263637-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d638dc-f71c-4768-9ef7-08dd84189b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWfYCbl15eLvjoIdh3qO/QhGB28QJenNnqnJCwQChpi0VddJFNO7NJuGlL1M?=
 =?us-ascii?Q?rvAjyDKBj8ENBMFAqIpgYkJaMtHL56XkLCwjgti4iecjJQZGhZEk/rsGA3wz?=
 =?us-ascii?Q?RLN/jkGAe40nFM+PObPYe6L8k1XxY3U4Yn9/0FrStnvHXwlP/uMXd4kDkSxp?=
 =?us-ascii?Q?rjNbJFiVRRn6TuvmGYLtETZxrOKlPNKKIV8+n/LagLRW4oxSdXbiMJMRkzA1?=
 =?us-ascii?Q?o+CHGD8aSBWUC18wTf0xyQrbuhCfbJQS8pDQ39/gJs09iPdiTPh3gaOR1dkS?=
 =?us-ascii?Q?mm3QFdCwo1CNFxQ0T8giDW+Ffz+jq5nsjScsOvwxmMwVwmB+qcAVjt5Ev34n?=
 =?us-ascii?Q?PRtAN1cNPe+IDqw8colQ0ImCdP08rtw3TIOEdyHup+dZbXkuzDb/Cn2oOkHK?=
 =?us-ascii?Q?Z2qGTLCgdWFhcyZKx1nTc9JAXkDTTMhVmIhh01IWAho6tPhYI6Qn6jJazrcz?=
 =?us-ascii?Q?SqUX2+XC0oB+J8r1eM3e0BFFquRvx6odm0sGymT4G/Cmx4pUrnOAFFJ/dMlX?=
 =?us-ascii?Q?4boQ71HIdM94U7lxtA/lpq4+twNeyxBLEBQzJLYFsQQOJEdJhrvmaMvTYqLU?=
 =?us-ascii?Q?W7O9o6PRmPWj+Ftu8cZzLu9ireXEVVGvUPV0uzU5BJY4UuFlqEKY1FiXHBIl?=
 =?us-ascii?Q?rOKtd1HQOtomOfTqrR2AQq+nBWEwcpFvzbUYejVm/j+HcEVTS4Px2Puqxv0l?=
 =?us-ascii?Q?i/R5cUJt4RJxvfSX2ZzlWiQ84FhKjA2tELsZkfa3qvGKi4+CUdbH5tqzPq9E?=
 =?us-ascii?Q?aIUsu0f4MnJoe/DAskXp6LA8KXQHwSGsg8e363wvGTyZ/S5Gs7L9+Rl9TAko?=
 =?us-ascii?Q?/Cg9bvVGC9O8A4KiJhSEgATtpri/8EOyOFAcadTQVxwU10GoD/vBUMhvVhV+?=
 =?us-ascii?Q?cp+/9J/n+YVx/Tk0wDHCHvf7eVtlyeTlstMTbXjS7Nt6PRZh+546yXoOG7AW?=
 =?us-ascii?Q?8V/9jsuwVbINZVXR2WaaEWJySQEH0QttJJd73z08VTAqWmvS7WQTtj3tN62x?=
 =?us-ascii?Q?yLyJpZrwDGjkEZ2A1lghU3IwEg4uO0zj9+QKHoClNx27fGSZF9fP/F5syGAb?=
 =?us-ascii?Q?snsRP1zjpLsGNHuzklCaWqKPuKObfySAj1p6amssNYZQpWQbNUyTLB7tLq0v?=
 =?us-ascii?Q?mFoONpKYTURdFQeGAl3qA6HmLD6Ni4u5OIiuO3aNvvnnoej+Ct9TuFwko6MS?=
 =?us-ascii?Q?P4pmGxSYNCUVLlliK0UM1WF0iMErQ84ISbZR3F8RHwiQ87LHnkt91haOdru9?=
 =?us-ascii?Q?Z6eKjnX2zWRLON1d4KT0qdz8dnstafFkpFr43TfVhH3cxBBcbsrriglgQcmW?=
 =?us-ascii?Q?/D6qUsC0WjyOmvIY8+fH+EL/y37RWaA8xI+7PlaHdc7AEb3Xfyiivmj3hivY?=
 =?us-ascii?Q?rkTxq5vfkwMOYiTrrCIAYhjxOr/ABVIlgp510dz1Fn+eengPfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3N7nNgFFIEW5iZM76F1WhZFNRBPP0PbGissjT1ZAaqKrLMoFMWrF+GRD8ky8?=
 =?us-ascii?Q?q5rf2hUW7WLaAc/XuAh77GB0qODhumpEFRjbeUrw8X2kp8dDffZrkvb9wG9d?=
 =?us-ascii?Q?rDkEWtumTAAhxrOP10yuhQdDawJKafR4hzY9P8X+h/W76V9U7JgkzW7Ov9Y4?=
 =?us-ascii?Q?qpR1VLlZNfa4lrwWoe3aprJdiPmB6I0uKy+HgPKpvEvEoCzZgAnKhmAlDgoJ?=
 =?us-ascii?Q?Xv9+fuf2AJyHdWRdqp4ZHjds+dDsEq04EjcyD6TLxC660GXxHtx54dE8tduK?=
 =?us-ascii?Q?L2bRZExwgnPKiEXAENHF6J4y1utjTVZs5cUJ0V1+vIoKuQtaxIu06nH+9nHV?=
 =?us-ascii?Q?8mVUky1C+hZ9K+otNNZFdm11kfVEIxcGIFMmpr8FfzbFquBr6kFwcMfjOnGW?=
 =?us-ascii?Q?hQSaGZlZecU6apKVkh/i8HUCBxpcW4D7OPu0Poh3hFpUVnaIw11PXAXqaVEX?=
 =?us-ascii?Q?/kAoKkG+jmo8VnUsYLOE3LU7SFx6mZOPRkRzvE0N28RXaSokVwGsS8wwFd2I?=
 =?us-ascii?Q?fZK2hBxsF/4qIe14FNXaJx/qRhSy1oGSwhgFiJlbskeKx2hoa6p9B/sE0Jop?=
 =?us-ascii?Q?9iBqe6J817EOwMaSixmmVKTNjaEQEXJysE2293bRQN7ZJoiSAfdgf12qg8R2?=
 =?us-ascii?Q?iS8YyJNwcL6R+g5phZxoCYK6wXL7PCmp3sSkZyYPzPifAyTIC2G0vS9iwhtz?=
 =?us-ascii?Q?NglRBTnBW4njPFKF8UsZBl0W73R0rVgx/hlcgggS51/Hi8WOU3IUlwtgzyy2?=
 =?us-ascii?Q?Du3vTriaEsRlbIawQVQZYdAARVUyUKoi8CZ/56YdyPvdpGhFgOwQLoURagDL?=
 =?us-ascii?Q?P4RPl4/91y9V1L3WaZ8g5hlI/vjxDDE5gNchUpzavy9R4oLXqhvMC7BTlUUN?=
 =?us-ascii?Q?wZZSpGmRB1sK90WPvRzjKXxIgCzK0y8jlSZq+alONLoihfhbzdnowz1zXImB?=
 =?us-ascii?Q?ASMsdd+LIeHq9rNSqrK4SJW8jpEv/AFszrS9nK5Y2GH8TlZ7dqcA2A5qgb1w?=
 =?us-ascii?Q?c84FrW4Ntwk/MQxSvEpgZmn9N5ppHyb5fkFWf3dehX8xH44oVlvP3V4p6sC8?=
 =?us-ascii?Q?64zTOxjm/ZCT4dwptsk8d1zYuUzK3BwekxiAJucRicP1x4Z6X97IE+NUjTFO?=
 =?us-ascii?Q?XKHPuVma3TRrjGAvkYvO9XhGy3fvXDbIERrTFQ3dliGwZXYa4BA+BMj5NcAp?=
 =?us-ascii?Q?I+eCHwk4aXTZ9ec4QAeT1iZ9Q6psiUjPPjKYBHjXZ6kok5jpktyZ8me8zEz1?=
 =?us-ascii?Q?2pnRcUJlTk0xbNw+nU83T8EYeEtR6vh4AjqIFlPJnQsW3XjylTPkxKLGlw7V?=
 =?us-ascii?Q?g5e0ZSdzl3lBZQbEmyCph01Rn/Lz3dIyyXTdfmccZxubV6GnmAlmBGJvtjPd?=
 =?us-ascii?Q?3UNlM0p+Kfpx1hC8BlHcTH8Tr42BdwgB4YdYp1g9n6aOvafhd6NxUsqzDJTT?=
 =?us-ascii?Q?PUhz/DPeByt/1+EYwWkrQCZmPrq2Belxrw2AS/WWkB5aa10EvhzuTOpvvAdx?=
 =?us-ascii?Q?ZzmJ48lg/WIy6Upthcvth6uMo9j9yGacVKURdiyDWut9GgftGJj7YN/VxFcF?=
 =?us-ascii?Q?FOawwBJsJ8dP/EEuyExIdUPlXW2mV/kn/h1WBIPlWgzfkH4frZ/WQ4w63VNZ?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EnR6Os9+yO9hzbu9z4YrOWeK0cWfpRo+DNwgA7Kno0bBKhUtlj/qWyf8tFEkSr6TDE4xBTeAoj4a7cT6hUy0XPiW6o2H3dsWAwryOVdDq6FZKApZlM8IB2DZ/J19d4CD2sfzNpWt35vc25tkkfyaS5CtIURodxmbpEvcyeowi6VUbQg4RgnwT4kJhYWMIkSAjIlsJLUUqKshjni97BdbFYfVQQlh/X2GK3Wd4aNFb4LGSFvjxdxZ7CcfwGdRWaWGypMfwhoOkJTvXS2PMnErGH8vZzMjoInYRc7WHiTbnQo8L9aBvTlvPuyWCJt+LPi9S4N56O0d43qy58JjTt7C6k3LBJuACddxQTpfeU5PUy1ps0AjdzmRApOKk9jDaSwXiOa4F2LDBqyUD5mrq84sqTOghxfTge+KQ3vZlXrgRIc85s/BUS7VjiCVsB4QUcJZ8Ksl+NWByr6eqtWOf8MfXSEKa05hNxStpfMWbLgJ/B3PCxl3wH+exnxqk4cXlSq1TNyTz4hQp/CB3KXVBAo/Ayi9dFT1jUjcQHXMiUF+NxUxZwLogyGvvyGcYs8QdwgV9PXUz7ojnMDWmtfiRVNfmqBnpvHHUN3DpSf4FriqcX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d638dc-f71c-4768-9ef7-08dd84189b37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:37.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34FyLQlqLhKGo6K4/5yk3Srv7BO1s6vH6nU73UCywX+rKhyKNWj0zTLIkNp24N5o5VFTiUUnmd2wvyvmo6dyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: -vC8XZ-L6Vyn7v5eHQMM9wtGTdK7b_np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX01EAqRzMvux3 zKWVayFs4P37EJAe2WBZbkvPA/SWVx3zVDcno7NfSh5JiFZETUK1Eo7CWSY+sR++koTSLJ/fyVT p+3rey2xAaczZPL1SmWVP2qYKpvUj58xlJjaVIPyvauZET8A7s69OXjhvMpGuQUriOkM4yevKO1
 ZEzVgsYcCv0oapOnrHcdzDKlcon95206/TQXpgZdVz5z2Jsb/vArv5II6p+eqGWUxxFF07Xkdtx zq5HG6/Fz0fXoS0LiRSUd6xMF0uN4mUi+JsXDtEsvO57YwM+Eo0TBDL61E3OzgyvPJHEUfQFfk9 nxO4dBccTa0HhqCC0fISFV5vOqYVpekH6YY2mmbWqEhWSL50ICxKHX+MY0w1Z+IkM/W1w7Ze6HS cRbTazsC
X-Proofpoint-GUID: -vC8XZ-L6Vyn7v5eHQMM9wtGTdK7b_np

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[djwong: add an underscore to be consistent with everything else]
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..55bdae44e42a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..bdbbff0d8d99 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomic_write(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..22432c300fd7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomic_write(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


