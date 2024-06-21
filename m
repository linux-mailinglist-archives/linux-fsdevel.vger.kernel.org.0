Return-Path: <linux-fsdevel+bounces-22100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C569121AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38ED528226A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8608171663;
	Fri, 21 Jun 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9kc/FqK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XuH7+0Ow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B3170849;
	Fri, 21 Jun 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964442; cv=fail; b=YrXYj4eL1RRcRagGmB5tC9YG3OBqrYh+qqTlhtga/05WYzxOcc52UgFw+UCrLw7yZ50Pf2YJhDaL21DP3sxtETzTrBHab0Y2g0cYtXlfrdLhvlogqH6oKdU5ZP/UNb6aqNWJjDP+HDBPKZBgaVQ0xh1S1NjWxHWe5q+1o7ElsZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964442; c=relaxed/simple;
	bh=5gV2ZZbOczLEbIwF/w0Qbx8CIPJ9JAUn93Cf1etsAxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8YMlmVX/6JbpoMfba1ecPGU0GO1MLnAx/EhV3JFg3dxnyASke6iYXMGR2RKE3n5cLMmnxDaPL6bCmdu6cMUk0jnhvMYb+B3Z/ivWoOeN+dJ9IKG+T0hZrQkgb6lEDJ72HSKgxDpw2yKa7PEnVQG9M84m6wN1H7yJnHFe6o1i+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e9kc/FqK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XuH7+0Ow; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fShi007114;
	Fri, 21 Jun 2024 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=lfuBYEjC3Bso2fSI4L6QpuFe97Xlh1NX0HFaJB0ytJM=; b=
	e9kc/FqKJSst5BZl20sCSl/AlbHqSocnChaZPJgKp++67cFaN4ESqL3jSLdY+yAt
	kNZq1u8M+ZjckyCgsBG5o3TdZEdb+NXMlHlKanmbsLoGk/DaeSyFik+q3Zq4OSLe
	0WVjmObzWJhuLerzgPFM9Qip8jzFDjUKEiveq5N5itxTbqSFPQhksgMWKiCS5VND
	km36pbn0m+zi/ofXu0sZSkDD5NyfYbzb9dN+yYWQpMjvDl7LFB9yvuxbu7wlUomj
	eJJsrjfaIXOGSMsiNjdw/f7fbbQoP9OUKafCUjaSPuXtwdUkBHlCguA1goQBovJt
	f2VyfJfXKy2zIYaJ9kXvgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkf9dpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8MZmi012854;
	Fri, 21 Jun 2024 10:06:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4er7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr7S86CjipQRfLOmZIYXyFaaEzG7PPpE++5AoYwQ2E5jfMaALbwrRjDMaO85YxL13PTF+oV1e+wsSbNCMyMRiBhVc4wAOH8JcXz+mGcXwC+DP9fc94CHteSSpR8MIWbVEvkU2Viqzv2lAppowhQrab/NllSfJWCHWGi+SPR39bN/pyF1syO8hhQ4188qyGZrHPJcLwiriIp8iekl7T3crNeelF37p9AD1omRPzFp5/U6teQ2AA8L8enns60l3+apRKtZA+VM1T4eg2smaKaMU8n61EQjntSHHdOHDacMRmDrbXpRYR5o1g6ucFXOVb3g0MP1feKdYP2IDHCubGOrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfuBYEjC3Bso2fSI4L6QpuFe97Xlh1NX0HFaJB0ytJM=;
 b=GN77d3AkZqos9hOAbpOhTktGUt6sSn4XKFLpVbL3WYuY7ytfePFWEtqq5W88MwPXMc8z1rYlunEQ2vXb/1heI+UQCLkTuyTuFv3z5dZr5g9rNqTZ+06I60o9+WSadL4PAYDpXh9quuW7uMBR8umlnoTxg2J53FXRF2xElqD/ofacKC7Cmcw0AjlBKUnTeRnUElmbmUH0zF20ZyaUqxig1wnNSeUoLCDfIT985HfShSAyUZAa5iVb3RDYChYoURyVcIvcV5T1I312pxmmbP8mmcqm6JYYumSThtSHMqv3Uc+vgHkkZkIdTlaWShVvrpEbiyUNaSJeoHGxTYE11e35qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfuBYEjC3Bso2fSI4L6QpuFe97Xlh1NX0HFaJB0ytJM=;
 b=XuH7+0OwVxRXA9MNRiBAbkK/+94vYuXHrCzCbRrDXdhCRrBXrI5M7Q9tohyQh1OQdE09i2XSATVf2nU8aY21dFSpIfpypb7O8uyp157TRr1vN4qNykcJLq2s3D3QFagk++YqGExCLsXVnQBjPpYB4TO9pub4SPwT/wQUFrPcH4o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 06/13] xfs: align args->minlen for forced allocation alignment
Date: Fri, 21 Jun 2024 10:05:33 +0000
Message-Id: <20240621100540.2976618-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db0a61a-0aa8-4e71-58cb-08dc91d9c68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U4ks1T8w57CvxhBEbL0KRPQr8Bu4I/WQ0KtBLxkHb37acflfZevZ3Lk2xK8r?=
 =?us-ascii?Q?Aro7Q1ZHV9pBlwaJwa2BaLabaUyyR5MIBt4fD81L7wjVdmvv7sBaMB7ADztk?=
 =?us-ascii?Q?dVPWKKigpsKnip3LT5AlJJ7yBbLKL3NBKxBcFh7poCE2K/WEI9kM1FBtyjQs?=
 =?us-ascii?Q?7XOP5J5dQlP2qOwjql0OXEFCh7fPn0W5npK9YksGdyQ41qEWcZse3Qv3v5v3?=
 =?us-ascii?Q?dlPW56wcAbpGy4D71jGpUJOWgm0wvmdjpaAU0bmuelY1ThCtqeNwtmBtZ8cZ?=
 =?us-ascii?Q?M2Fh3AYPl0jE5WazfCPKhJXTmHTbUV+Qzim4m4BZ4BhyC+ap7ED1YWWWKLn4?=
 =?us-ascii?Q?qKXDHAuXXoGBk8xzj/4Hygs+qC2eAOekyu/hiwy2ZVj5g5OGvxgOJ18eNTb5?=
 =?us-ascii?Q?wLQkCd+BkokLrefgpubWJK3aYMpINBcXUHwUYqU7YqTKqSwml9y3wB+ro8JB?=
 =?us-ascii?Q?kSvHL4VKQ1DAozPWKJovROQVUeyQhBvp214DnIrXuwdAz7UpW6ja7F9BKRux?=
 =?us-ascii?Q?q1Et6M5BMv7dP1/0uEknzs0j9emGwIBvWDwQoCzH32H0zU7fbktUPA6FF97V?=
 =?us-ascii?Q?8u8sv2ueabDYYcXCPDg7xH+Gjg3dTCv2LFkW8jRgWfjT+IxY5So/MraaQJ/5?=
 =?us-ascii?Q?XkVDtX6e6g/lsOJr9LiiuD+7u30Lxzz8THnFr6TZfNkRKRJDZvNMQQYZF1vM?=
 =?us-ascii?Q?fbsb2QFLtJbWvTc2XM7HzxvG5fye5EDLOrjO1hlv/BfKdkmpSoKPAHdMPnHS?=
 =?us-ascii?Q?Bijp2jGBwKJgy5vnRIgIPGyc/EbRU1cqguUUoQ0db5MV82DxQcwm1wk5dWQF?=
 =?us-ascii?Q?CxkrO9d4PZQa+N916qmx+WUh+5FjcX5WwU+rSZ/bMBN6bXfX1gxaGjFXhz8E?=
 =?us-ascii?Q?ydv9KMTtxJ+NnbY67wGaCxslCIWwo/hBYQEFf6h8lpeEnYcJdjnzmyfLvEpF?=
 =?us-ascii?Q?nwDJ1IlyMTSTZt0pvJq64/H/hqjSLWL8yujKpN7cb8tNHL5oYNSzfEF84jzW?=
 =?us-ascii?Q?3GFruiN+diUcJSJZKBYcO7xwgU/LR88gZCn3ObncN+40Y3KlPQjOfbn7i0aN?=
 =?us-ascii?Q?lzaeCOtmjcHfrEDHblnMsoW95cg9Ja0eQCsUivR129LdYpw4TJo7UOxlSWRb?=
 =?us-ascii?Q?x9WhoZHeohPBEftswA7AyR00rFrV3V8A+8vfQmO2VNScYnyJTeBuXbu+Rnr4?=
 =?us-ascii?Q?PaadNANvK8SWCC5yD+lWv9LvB37E/1Qp9nE6MrgEPAOS8Islr5CDU/CtZe7L?=
 =?us-ascii?Q?9cYU3jyfR1n9+89CZ0mOkbrwABfES+Pp86bCIOj/C//xL9Tx9af8T2qDX/sD?=
 =?us-ascii?Q?lWrJFJJeBNm1CmeGrVoV1Nhh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CaMyFezTdmYjm1aq+E1/efw7GkNk6ND2ZQgEJfoYAbOOkkkpK/MMCHUGmz9q?=
 =?us-ascii?Q?ZM/y2w3G1NkUopC4Md1QPnqEIgHqOeoa+tVngjH/y0vdnirKpnpFvDA4+2Cj?=
 =?us-ascii?Q?UiuH22a6W8rvg8HwhZY2HBDn/AUKIWJmWFJ0+UfTRblhKjRRt8Wi0a78AFtt?=
 =?us-ascii?Q?vaXiSCoVC76uuCUYOOPaR+f2ZuDsjNFBer6aFx6yXDeSuNNEaZhGF+MU960f?=
 =?us-ascii?Q?uG361CNGpGXzKMPZvLA3/PVCZn189GyZ9Sapp+05hfX0kCHLWe0Q/W1HGq+q?=
 =?us-ascii?Q?PpdjNhHeoKUc+7PVCgdd4PZ1hhdVtMrQG5GUGahgB5LYk6NFW3fWYv4IvkJX?=
 =?us-ascii?Q?jl7tVBROH2UNn9IpYnX9M42ExjZtHNvE+Rgv6IWZb+Z3c58CGSG4PD4shN9S?=
 =?us-ascii?Q?hjw/mYZqZVb7tnFVnmYpuzTalXcscGaEC0i/rpUKVAe8f5VxKlQLcdBf2Ymv?=
 =?us-ascii?Q?LYWp6zaE3frrbxCZjWUtYaZKXF3cvcYn670i+u5f789UtgwwS2ZT3MZ2GBy5?=
 =?us-ascii?Q?6sxy0HNpd/0Uy8ordKC/spVCHpPCUiKIW+o8oeUjDm7m02xSBDTnDGShOBih?=
 =?us-ascii?Q?WjAk4Bvzc8R1SWO2Ng0lo3KQrFSLhTXKTlF6GZg0rqItG+JiW+jPkTvsOiLM?=
 =?us-ascii?Q?6dPlk0HPXNdKW1Wekr1SQrfQPjVP//CCHJvSdP2/GrLVrTeB3uznLdaqwQgd?=
 =?us-ascii?Q?vPZjiEcavYM7oqUISWeNwEtC9yrmFE7r2NOezCFPR5hKE4DQAdFvy6lu8Wg/?=
 =?us-ascii?Q?1t2G6qU+31D0UIG6yiZBsj3AtgKthTah0YhoHk+zZyQgCAXVw6EHJqmWJw5p?=
 =?us-ascii?Q?TwlBwzmtRY5CSAdJJL6dZ6ZtGc5OaA7IlHPYK4iANPz2sLr1luugI2EEgBIO?=
 =?us-ascii?Q?QD04MBtOCKceTU/2z7FikLAIQIl/NTpSwsFU3nrtUJuQsVTdKJ59pMl4UPni?=
 =?us-ascii?Q?Jhhu8y3r+llJjXl8pVcr2/xaatz+hyEGqLwNZ95W9Ew5829RU7HrX+TBI6TG?=
 =?us-ascii?Q?ph2rYoScXKQ/yCu9IM7pEsKmT/zJl3M+wPbaA7H9Ej9jehUEXuOhKWuJSJGD?=
 =?us-ascii?Q?sP6KuDqDaVkjK5Aph/9L/dvXOR/H9PsfYs7P4v1kCoEQjdsV9f4SXwO8xLBT?=
 =?us-ascii?Q?UoH8IB1FxVy5MnMh2v4dPiNG9zxJ2dWSVtq0tGAoRVZ7iCs9xeOVfeHVUy/P?=
 =?us-ascii?Q?aiqoANOFJHTAzbJNule4zaJpukjO8rAAlbVowNKD1hKO+ahSjqXumWRdnmq2?=
 =?us-ascii?Q?F38UPy2eaJ8ITow6rGYnz1yqiO1nZHAAcNw6g+EEe/2aBMwVx1R0FLGIYGuR?=
 =?us-ascii?Q?Z2DudMjRli7Kx1dYP0EVQATnd5BqPRIhrnfqfDVr1WEadSgQRZffk3QPQn7O?=
 =?us-ascii?Q?3BovKn//N3mhiIjmGbFM4he2vqTvwHDDzSLBkRb8u3pUjeCZLyJ8N34MhHCW?=
 =?us-ascii?Q?YJeHEfJ/zwV30jjftiz6f7Ug0tPZ7FXz3ESILnVkEEH85P1j3t7ENaR4NvPq?=
 =?us-ascii?Q?4m7XrQW8p2LhKlOEjJd0DHUD1Lkpvd1ZhoFMKsp/H5K/Aundj8t3VI44q8c1?=
 =?us-ascii?Q?2VY+FEsX9lRjjldsNFTG9sDG2sqoqXMW21k3EKq9xxaygzfOCgBtIgy4OqHo?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cfaDrJ56/CEZ85Ff5Em2lD8sFasIALuxlqCF3Vk9tYFx/C3z6P2JZHVNa/CUZiRw78jd2PbzI+fibOKCMkRDJd3BoKI1eoxGk4KpP+wAPnjdmRpYBNEvXqbw4EyRBvzfVNHIfFQQ56eHsWrgXK0G6ttaacevc0VMZrlPfWtEK3f4K4/3FyQoKX5hbvTdm+th5TdeyPngLAGmweg/nvA1FrbHkxkwyfa3KfyBW8oOp2dDmnQmd2fGf0wEDrLt9Dc/qhL8/vxjPQwFZF02S9rlwACLTWGhlwAH3GbyPBQmREuhGK2ELfrW0MBiiVLMwrywkquIt5vLp8lnARLfQ82jAD7mJ9uwRojBpQmJKBb3CuQttR+VkgUgHlJf2gjflOtmETjd+Efc0cTv7wYarCI6ppLDvHYg+NpXu7pSjNTgDG/mQ5t6zDk88r+d+sNIF8jt/275ckGGOTi0wrhnFDzKneGJfJlxmcwqIH4bguIT36e6mFnLFY0jmtL7YuGt/rMqCiatW+a/LwKwoj/QOsPf5nxA0gi9CS81oalkROdAvHgMtQ0Mupq6j2JWIYkfcAXkfNSYufJzgFpiwUxmnnl7SzzB1MRoAGiSGYjN6veEh9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db0a61a-0aa8-4e71-58cb-08dc91d9c68a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:10.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2TzNSDxRo2gvYKPPLNmiI3LmXvEMB/gLVoYkEre5S5LmkkeAv4COZGkTZ4dbbE67P61nF33JMqEPjIzpJEPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-ORIG-GUID: 1QeJ4xZC0HVkIbzcYhWFRSuFdp4MVcCE
X-Proofpoint-GUID: 1QeJ4xZC0HVkIbzcYhWFRSuFdp4MVcCE

From: Dave Chinner <dchinner@redhat.com>

If args->minlen is not aligned to the constraints of forced
alignment, we may do minlen allocations that are not aligned when we
approach ENOSPC. Avoid this by always aligning args->minlen
appropriately. If alignment of minlen results in a value smaller
than the alignment constraint, fail the allocation immediately.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 45 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 9131ba8113a6..c9cf138e13c4 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3278,33 +3278,48 @@ xfs_bmap_longest_free_extent(
 	return 0;
 }
 
-static xfs_extlen_t
+static int
 xfs_bmap_select_minlen(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen)
 {
-
 	/* Adjust best length for extent start alignment. */
 	if (blen > args->alignment)
 		blen -= args->alignment;
 
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
-	 * possible that there is enough contiguous free space for this request.
+	 * possible that there is enough contiguous free space for this request
+	 * even if best length is less that the minimum length we need.
+	 *
+	 * If the best length won't satisfy the maximum length we requested,
+	 * then use it as the minimum length so we get as large an allocation
+	 * as possible.
 	 */
 	if (blen < ap->minlen)
-		return ap->minlen;
+		blen = ap->minlen;
+	else if (blen > args->maxlen)
+		blen = args->maxlen;
 
 	/*
-	 * If the best seen length is less than the request length,
-	 * use the best as the minimum, otherwise we've got the maxlen we
-	 * were asked for.
+	 * If we have alignment constraints, round the minlen down to match the
+	 * constraint so that alignment will be attempted. This may reduce the
+	 * allocation to smaller than was requested, so clamp the minimum to
+	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
+	 * to align the allocation, return ENOSPC at this point because we don't
+	 * have enough contiguous free space to guarantee aligned allocation.
 	 */
-	if (blen < args->maxlen)
-		return blen;
-	return args->maxlen;
-
+	if (args->alignment > 1) {
+		blen = rounddown(blen, args->alignment);
+		if (blen < ap->minlen) {
+			if (args->datatype & XFS_ALLOC_FORCEALIGN)
+				return -ENOSPC;
+			blen = ap->minlen;
+		}
+	}
+	args->minlen = blen;
+	return 0;
 }
 
 static int
@@ -3340,8 +3355,7 @@ xfs_bmap_btalloc_select_lengths(
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	return error;
+	return xfs_bmap_select_minlen(ap, args, blen);
 }
 
 /* Update all inode and quota accounting for the allocation we just did. */
@@ -3661,7 +3675,10 @@ xfs_bmap_btalloc_filestreams(
 		goto out_low_space;
 	}
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
+	error = xfs_bmap_select_minlen(ap, args, blen);
+	if (error)
+		goto out_low_space;
+
 	if (ap->aeof && ap->offset)
 		error = xfs_bmap_btalloc_at_eof(ap, args);
 
-- 
2.31.1


