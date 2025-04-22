Return-Path: <linux-fsdevel+bounces-46933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD9A969AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D6A7A6BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC757284B40;
	Tue, 22 Apr 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wz7ohoRW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VcEBq4wI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500D284B33;
	Tue, 22 Apr 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324937; cv=fail; b=ZL/N9KnP9I1OiPJ38CSPjedOcsTMQ5hsxuHdQzR7JWzn7AKESx6jEElVunmX0679xsH/3uAxUZxBfRfvnie/atiXzyujmIIfln4uP0JUmhPAEnE2QWWyko5o6VTNClQJEsTur+Ucb63eXzAIijs0AJ/JhWLQyysmxrjxtcOE+ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324937; c=relaxed/simple;
	bh=5u+GbHU06ZK08aeXXYAR9iNBKDMNLkD3h97Co7Kcsso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpZUQHqdApumYUIwz+EnbQGf4gyiyhW/IhJnQeauMcljAi08cYu4C3ZFl3920dRZap4kblOalR2QAXtGAF/n1BhNWajMkXqrDQ9hL+aphXTgWhVe8jGFjKaOYnt7LOpgjnfPO109GfieTM9DojguMHHMkncFlIZqzD7gK1n6/gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wz7ohoRW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VcEBq4wI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3BUs031447;
	Tue, 22 Apr 2025 12:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GXTPyqaIDRxuwe58VO1ToDoisTtoontPjBBkYq7GHbM=; b=
	Wz7ohoRWlfLOFJXWSZ3UYD0XnwapOI3HDeDf7XNucMvm4UikPp+Vsj6jVBctzuGH
	fieGB54Mmw0iQlzyFaPRAQ8zqRGN41fA6sh03XwV4utjhge0Xq9ycxti1u2bHtSm
	kVnrrc5juQMV03D923AvC9hMeigIHM9nZmRdN6HOHvqEBpVeCVxJ60Qww8m7igIQ
	QV/C5LjyXjCFLR+hvd7ZJDuasLaEndcPNhTAKLJFlE1ijD42lUbH36pgZi3TeWSJ
	7WWKQL4n85cG/xp//4LLr6H/AseGX4CDf3t5gt+dMa2J9uggulN/Jsna/TOkc8Wz
	O5zAt4ttty6zg3lrNCmbgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643esce2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBpMX6005858;
	Tue, 22 Apr 2025 12:28:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011030.outbound.protection.outlook.com [40.93.14.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dejga5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwGoXbIN6+1aVVuiU1EK0ZKnme9ZK9vKjYn4GDj95S4vr4Q6Gb1J3VtuizUvPGOg407lo3d98Vz6bMOl5nL40fbxuY6OEz7RFH1mXwPPpkL0wtAQcE/qqNzGn4dm8fIfquZoWz9aed6BJfR00D9tcNuqUNJYZtkyvkZVldY3hhcE9hmAyyd7bFQQLYt8n00BNuXnYWdQwwo5ROPCiY5U4m0kNaKEKGCIicAvMd8yFksowKwJVbw8Q3tyMztb/L1hh/H7z1BiKoglx1/K3EGubsNxaoFBedLjQs9bW+FgyabP91eakew5Gbjhz02gGG7cHdI0aJ5MK/SYt5OXq8iYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXTPyqaIDRxuwe58VO1ToDoisTtoontPjBBkYq7GHbM=;
 b=GVeyQTRWjIgfyVyOJiDex7KWMmoN5QCsY9xurK8ApOnTW6v5X7mkRSVpjQN0EpdKmJs8siO4ECE1y46973DOgFwBxnVZuRqYrnG/T5byhw4/pSv8fqrTDTs+7G+xxY0DXoE56y0kfHzFSFKnegPes6JYoVv2aR8IgblfRdz/MGIYKpzgqSseu201Fe4iEP9w3EJ+V9jCPrqBHtmia8ZWOFptIQfiFRRjd1XjGsWOPPtxbE6IUMlNk2Cvz8g4TEGjdCniYXgAVBk3Pz9exR47Q14WeHCFu3x9xAO6Z1fMA3rBqTBdV2X2YzI00ung4ZBpoRIhlH+7E2UGwuZcE5MlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXTPyqaIDRxuwe58VO1ToDoisTtoontPjBBkYq7GHbM=;
 b=VcEBq4wIKGLr4woM9UR1aFuzlP9UTlYm2GwP3jWJZKGTarbUh/dfs29IalynmilpignWINngYWV5c2JcInLqPi45jZDEvr/24DjR2321WL2EC5eQjaKUCYvzf3O0ltB6PGSpCm9FhC05qm1z3P6yX8XILU2F/Nb9cqnF37facc0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 11/15] xfs: commit CoW-based atomic writes atomically
Date: Tue, 22 Apr 2025 12:27:35 +0000
Message-Id: <20250422122739.2230121-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: d884bfa9-8798-4d40-4b92-08dd819934b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zb08aoHTiHpDs8s8yIJ6l2lQmxSiKJzVCMRyfjcEWLGU99ki6YX2hjBIMhbj?=
 =?us-ascii?Q?PtTSKiTM93GYjWx4bG+XTym9nbDftM0xswNpawyUuPrEB7MqGwF1xzrqa50z?=
 =?us-ascii?Q?0RmdVTLMyHfGlpUi+zdRtfGTltQLYrnCGi7q+sM8T2VSYAJLb1ShmJ8hZR9G?=
 =?us-ascii?Q?Jm2fLjqmbH7BqfVKqgmy0ezfUVVQN4qgt3ZUnDnewUAIbmITbEPaa453PY+a?=
 =?us-ascii?Q?yZQRigJ2Cq1g5YTBpeb8hEwGQRcHfyuyvzfrkZGuy44KaZv0vDo3M1ct3bt9?=
 =?us-ascii?Q?kuTbNKaZvFcrvnNEqQEuEu+4KVqzae9OhdV2KWC0QDYT0wAB2mzGG6Mt8TKP?=
 =?us-ascii?Q?mUYzMIXxGZoL9bb/lyE3dl4JTEvCKPCNHyiA2ZzaGfO6sSL1doO27fM7zzXY?=
 =?us-ascii?Q?XN5lmUrJawYluWW08C30o6fwB55MKstZZK6xv8iKlrjXp/RCbX6WhXEkQqlY?=
 =?us-ascii?Q?8HNdx5ZC+R+pwGlAqL72Tw4DsFg8uZJKji+bUy2XLWTjRZZR7wynOxyRSPig?=
 =?us-ascii?Q?ElwC26i83/A9avh8ZTU9rmHir/RAa7VGBA48swn7kMdlUSDh9cL/uIYLJrxd?=
 =?us-ascii?Q?Dd/mlFa6oc4tbhRMTlvkjwZO7J0kzGNTlRVdCN/DEchD5nCQbdnjNbcB9GWy?=
 =?us-ascii?Q?tPNb5FxMUzrXAf6R6nHWVU9JEn8c1d5O0tumQ07IApWRWgSGDfmEc1Lb32KK?=
 =?us-ascii?Q?1Nr0YRSbewiXo71MiEL5W/ifRQ8rQ0e7O3COVvPAfrDow74fmkp1x0s7Dlkx?=
 =?us-ascii?Q?knTqetjtioYp8LO7SNhnngo+TGSUjCxGGa77x16lIfDQj6hQIvpL/u9WU7R5?=
 =?us-ascii?Q?54vrpdbo9un35WJJ/UQtzkyeQlMnsFxh8izuQ34ACo5SA9g5wUPcXZCH1id5?=
 =?us-ascii?Q?JUELkG/ETHLkCdAuiOiNGRq/ApTb8VLm5c5mYWXVAlUzKsNSj3PaN1thUp1I?=
 =?us-ascii?Q?FJs4gvg2mQuNpB9OkBgcvH09j5nqBScZ5R+M8tE4eNg6ojiyJhU7xiNtkr6z?=
 =?us-ascii?Q?5EkfcBvVFmuYaz2OUduPQu/7oiUhk0uxWoisKHHzhMgVQSHRGx34Wr/hlEVW?=
 =?us-ascii?Q?JruYRWPVcBNBBf94pNPFABv699Nt9Qq8553iINYR59GPP9QtURFl83lP3I/Q?=
 =?us-ascii?Q?fISxIV7lIDGlAVqccIh+Eu9lIOT3LE7E5PacNS9VQSM1oSjDeXaIE4xaKm6A?=
 =?us-ascii?Q?FOHSx7t24kyOaROI0ysWWzlHMsc7R96ihJP2dDZOPVI19afYhbnPbNRFiIIH?=
 =?us-ascii?Q?CIQ3xMWuttgIUKnkKHdPqJw4rc/2B2JLo0120ZCIS/JkzTyepskW5KzXgdHo?=
 =?us-ascii?Q?bmTdmvBLIL8JcPqYV7i3MxfYIct/EURUggphVFLtYhwcbA59Oq9G5LkoEY3m?=
 =?us-ascii?Q?/FSGb6Pk8iX9q+aOiII5WrnWYBUAywd8oMOCJWKZ1LBNDYw3r/ycQxo8QB6b?=
 =?us-ascii?Q?queIk1SehAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsRw6P9n9jU8WztUJKXhhcQJwLEKABIOhRoW5wb+KPNcweAFJS/dW/aGIi+7?=
 =?us-ascii?Q?eSzSyp9qeMlnWj/9+lp9BHuc2Nut8RGuokw5coQtpVHj12Rtz7Jp3rIEHsNB?=
 =?us-ascii?Q?8B4zfwiHKb/3BNmu4yNJgUgaVkVNFUSPflFR2aV+wJnjCYU+87E9hQjxwg+P?=
 =?us-ascii?Q?pslz50urnjbFgtDakDS+lfJvoJ2eLUBx6C81qdt/aFnUVaupJVmJy9vZnCo6?=
 =?us-ascii?Q?M6whGgOj6F7wSxnE8YQnH970Uk4WTDuaS1jeBPh1Vk1q70fsoevzL0rlK4Kl?=
 =?us-ascii?Q?KhrMezccu+ESSkkq1QBsvDshYDoPFyEsZmPAMjt3pqZ6/qN7r3FgNG8or28F?=
 =?us-ascii?Q?NvE32q8d1C0trDGWetQqnqzTcxzE7CNoXGKRnnj/BrLYWwPM1HkcrO7/vCon?=
 =?us-ascii?Q?XNCOKjHt9VS+r2Sw0shcGL8hGhsFqm+K6r0ZyAoJVMlZqehcHQr4c9shjzT6?=
 =?us-ascii?Q?0rzb4uZ06V3tpoGmlynOvRujzpuKnASwKog7yNpssGmkVqetuP0muid18GpH?=
 =?us-ascii?Q?W0DSPGOtFJw+CGnbGHzwBUDejxL77Zlbwp/CfgNGPnfmnsocPdqxpBIIyMRf?=
 =?us-ascii?Q?ZOXjTS+533wr+ge0UHIw/YAeB3me9BulUJ3VOWaULxwYR/soPiiFeyAnJcZs?=
 =?us-ascii?Q?a1aEW4vMJnjUTSDaWDZaiE6PYBkevzrcslWEo4l4mlsnjnufTHB30Gb7oOz7?=
 =?us-ascii?Q?lFLD4BuJx5xkpJPEiIlTmA4+1bx0roU6LEAF7cMMhO5D/rxfUuWw24xTune7?=
 =?us-ascii?Q?WMGdcpWDQUB8FndaOeHkvTx4WGPS5kpsF7VZOeQgpafnW4YAGzGSbyG77yrC?=
 =?us-ascii?Q?ORRixACaBnFgLZN1LRA8il6OpKGQ4wxnYR2iIxMRb0DubiCn/HLF11r4dfBN?=
 =?us-ascii?Q?99fHqrkmcWACW4dTM4gtSucv6CNieGObo75gSDeyxTWFxxGhtIhxFWfBLv1s?=
 =?us-ascii?Q?wFyWknyuxH+EYSRAoWdAQsR3jhr80l/860T6oTD7gRsKtkxAIRYp7vGKuXv1?=
 =?us-ascii?Q?CpmSTiPyPXTqmAu3JudSSq3Jrsr+dXAj8XeaaSXMyT0MUhz8vwrRjveqPBgb?=
 =?us-ascii?Q?2CxA+UNXsGMdPXzKoYUzNitVzSF+MTTbHP4ROzK0aW512hb5vXU9QFw48DQ2?=
 =?us-ascii?Q?Op/qDfXQudILK2LwhL8N28XFNt6ttTIYAD47oq1Y9rIBwg/yFBQbEpd5RoT1?=
 =?us-ascii?Q?jVmJBvLGR6s2Ds+S2/4YJh8CDFSo54hYHtnBOTT+lUrlPSCYQL7L5gU3s/kR?=
 =?us-ascii?Q?n/6gzJn6zUwWyV8MeGrOG5KbbnA8wwOt/NAvxXkMqsYOHiFIb5oRf137eUcC?=
 =?us-ascii?Q?LRHpVvAW4poQDnV/G4Mp2sZuh0TqJ/y9SC3xodlnyyoOqUxA+l0Goy7VG7/j?=
 =?us-ascii?Q?WwN/RGKhS+sKO7gmVN//y2FDetfJbaROelJsPn43iG/p5oXk61A8D1M6S+ht?=
 =?us-ascii?Q?W4nQyqA3+4IZLNECdOFG3VHSfJbmz/B1JyQ77LiVH0zD9N5zc7a1nz1l9PqM?=
 =?us-ascii?Q?vQF1NDaaFBb6KZfspug+Vmt64/rxm5EHRIzfdX2mYlHCbvB1gUyQT7iJESpQ?=
 =?us-ascii?Q?JkqR+S+8wstR9xXmu4t/8JLhlX0uyPWQZTvPxu95l4fS+KYLNyTuYy5uJWgM?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ga9DtDk4nvUsZth3NK5f2hHdVizwGP1HxWjwk3i0zser+go8IqS/8DMGO9Oa4NpySKE7BHX2fYi06LzlwrApUrc+URBe1Tio4Pq1Z0Xb4Kh6WE5+d/6TCf6YlHTYDgd9aPzJVfzNYDoGpHHxcq5BN3HwiylhP7atVJ/Xcpu3u3qPT8I4iqs5WrgGHGnr+W21oEQkIF647OQXve3kDvUrTUvPBEFhTYOvcqJAaLEItfE46vkaHuLvOyO4rTnemabKMzmQUcP+NdqXXRcsF5qxFmy5be4KCDojoUU7simaLQ/HtsVOCu9bmcwl7AJyvMcosuf/d2k6kilEOJDXwXuQQd2GzdEovqJ5EhPw5KxtYd9tDuNPRn2rL3UysI0EsIOm1mgWgS5B5FQFMREbw3MdIzjrgOWaXpqmZ+8TM5LW3dsoeVtd2qGIFXQ2wEK4qJuvn1stqUeLRjgzlixuNp6lyWe0747pnv/N3hB5eT8ZtTGoRUQbKeTz9jy66miy/1zxl2TQ7RHn2t0/JOTa78Lv20GFufMkTuinCom+DlY9NMtowECUC1PqU2U4fN/RUzvn4CdeCO5liiRH9KOOCTLB1HuAfSffgv1S7Y00GOGepZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d884bfa9-8798-4d40-4b92-08dd819934b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:37.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJv5mKfYZwswNNPmoIht3FDe1OgjV4nNVKZGEpDkwvPEM8Kso/Cbxhh8gZtblVUiTaiw6GU56+hd24/xPDbUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-GUID: 0oAFuOGvtwsUjsE_j3UsaJFfj-HWHbFB
X-Proofpoint-ORIG-GUID: 0oAFuOGvtwsUjsE_j3UsaJFfj-HWHbFB

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
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 18 +++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..6c74f47f980a 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1284,6 +1284,18 @@ xfs_calc_namespace_reservations(
 	resp->tr_mkdir.tr_logflags |= XFS_TRANS_PERM_LOG_RES;
 }
 
+STATIC void
+xfs_calc_default_atomic_ioend_reservation(
+	struct xfs_mount	*mp,
+	struct xfs_trans_resv	*resp)
+{
+	if (xfs_has_reflink(mp))
+		resp->tr_atomic_ioend = resp->tr_itruncate;
+	else
+		memset(&resp->tr_atomic_ioend, 0,
+				sizeof(resp->tr_atomic_ioend));
+}
+
 void
 xfs_trans_resv_calc(
 	struct xfs_mount	*mp,
@@ -1378,4 +1390,10 @@ xfs_trans_resv_calc(
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
index 1302783a7157..ba4b02abc6e4 100644
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


