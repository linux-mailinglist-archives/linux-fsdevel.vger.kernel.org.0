Return-Path: <linux-fsdevel+bounces-48187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F086AABE50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C93B8C7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AD267389;
	Tue,  6 May 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hszJ2GAV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mu9B5AIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04379264A7A;
	Tue,  6 May 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522324; cv=fail; b=Ly0XVrZ3GWcXGeyN7X6jDSsio5rnrK83Q+sYy64PSAAnKX6/n3wGJtg+oxMpQIzloDJUQ//iSS4VDrlyd2olYQGMdwsSAtPO0Mz87+gwMOfF2+FdA3zBuw+9rxe4golwiZLxr/5iCv9LfbXmA4cfnO2jDbRZc0zXanEIn/NIXe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522324; c=relaxed/simple;
	bh=LYJ6Cs/4XLAQXRy+nRHO5LkObUZwhTyEFDQCIxrf4sg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iXE0tT8HxdNbJLjboi0oaHvFQLVnwo6wmQfwnw8+RHgxcnTQgWB98VS5djsKb//uJhtWoo9DEpB+eSPtMIvhA15OcVO2CIgzVuGs5XjD//e4Xjx7f6xyKWdCGv6uWCIiaruJmdYe3HE+zLQK8vj+K2iJ8ryh+CpvMTPT/U3poLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hszJ2GAV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mu9B5AIx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468g7tG014803;
	Tue, 6 May 2025 09:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=+rJsQkfoYN0p6fwe
	iNxpKsrimAN7FzYessVP9xqNUN8=; b=hszJ2GAV2qlYkWtYn3BVZ9NpbAgHhJqF
	Baj3NVpLKtOgAFIUfTIzc2UJngYXKRPLrGrxiXYwduuw1QeF3dDqRw/9de7vqbjb
	U22IKgfLx37U0/jesICyE3N9zWsbiwNefoxa4b3jDLGQOoX02VStItkhjQIG4fCO
	wk/OYB6IxtDoRz8lhb97XOrMK52q0Wf/yT3i2bJiD87z4Y/7W4QegMOYjJs3BxPm
	eXCg8dUJjXth33jdpvVksn2QQFoUon1z+eFL63141JCYg89Oiu13gVVLWduLhYE3
	nOHhIcoKroGNQzjHF46wXUXSWFcGsOWqhx/aNqRYHV9q4noNYXoV0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff52017m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467qT5d036255;
	Tue, 6 May 2025 09:05:09 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9g957-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9ed3X+YVYo2EX9Ms9hb9MEM/5jSHKuKDQKUWFtIlLRq2cugemmX9vo0saPjhKnUBwHDgzTBdWUhREBuceINi0WA1NsE+9p2dPZO0qHWQgzLmHOTHyld6NNBbK22/mR6fMTKU9KcsiArmQy/V5CQAvwj7SKGZmBEevKzN8stvB5lnlNRGhweLPmHu8fj2vn9V5HVwIXLKUXH8vxNlIVEH6wzGDJ0DZjpaATd8sr1LnO3dcZ3IqdbrHc25Hpw0cfb0iqtjAQiTYFd1M3Qt0d5yRU4Sauxbp2J6gxl13Qys8aiouwBL+yJ2ciqrKFlkQ6SUNhgQSLt3WHFq7VVK6rnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rJsQkfoYN0p6fweiNxpKsrimAN7FzYessVP9xqNUN8=;
 b=Nl67l29JxJVtoip79n9NQVXwKA7MKZRcYs4eHbis4LEgM4j8dxA00CHCWP1fKYq70dtDCrsDDw8K7sWuvTz+mqCByqlFYWHAAV+mtHl5bc5rc3F92BU5iEXi2ygKMUSQuGJaUZKVt7vg566eSmN9AF3z0fsuQpDwDengaEPTxV1BRoz1UBmxHoPIWLoWF5/IF7++mCklzFZIheqjkeLXf4Xbor+WJIxPJrnpAMpS2Fb4ajGl0Ugw3C4EfCKpgxv+xES7jsdwVkrsXXimv5eToWV7mlpoyFMPgOgAiiUVVKHjbcfvM/aM9vsfYPy+6DP7XBSu0jcDbVr0rvYaOh+YIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rJsQkfoYN0p6fweiNxpKsrimAN7FzYessVP9xqNUN8=;
 b=Mu9B5AIxMMR2aiLsv+3CHv9hYT6MRIohj0TKHxI5mMiXGlW0kcpCM/dN1eOndchEMiENLHhxss3lkctP+hxQ+OrtnU/BND5J/eHE0SqAeyz/JR9OiLbuDNcJYWJSFg+5aaax5m71I4wAKQx//yNeNOpXE8LYbvwvmisdUEYifSM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 00/17] large atomic writes for xfs
Date: Tue,  6 May 2025 09:04:10 +0000
Message-Id: <20250506090427.2549456-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 78886586-67dc-40d9-0060-08dd8c7d15f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1gj2i1E2ndl6pYo0d7hxG93wXo5AAsoCsbY1BTHqpb6MpEXzK9WtORoQQx4?=
 =?us-ascii?Q?yCrpl1uman3h+ObTG5uJpaRSX5BA3BrBQd5tprgR7s+57cI6/Ut/VwUhb7ny?=
 =?us-ascii?Q?9/Sq91WTS/WocTU6Q+85LcAHC/JAkgVTXaL9Iy3DnJELqt4nmB3wk7Vaud92?=
 =?us-ascii?Q?nV3ohQaKjES1R1UKufAzu/eFkmZDbIjWqK0UP4AAJevyAvtPmnu9QHMSxaB0?=
 =?us-ascii?Q?ngCuQ3leqzIfE2FjGN7ZBIpZOO+rCs6U3exM5Ousj3Ej+baW9boz8g+f+7Ta?=
 =?us-ascii?Q?rAreiOaVMTk1Cm9nn2EfDmTefrLr/Gk3AhDwF5mPLCQIfpjWSBNqkPDXxE7b?=
 =?us-ascii?Q?QVbbU3PDpGSg9TwSSOSBsK7FUWcQzBKje92+3T40iKZk8pEPfMLQwCgRSdv1?=
 =?us-ascii?Q?ezHzIJb4WrHnjShlChoYbAZAw5jKIF17SnloeXbVH2vu1qCdNPkM8OeE4T8B?=
 =?us-ascii?Q?jAZ4Rn46KpXUgx/pPy4rH/1Ap9RMWRnHVKyhs79FkEw7FDVTYz6I42Rfln+3?=
 =?us-ascii?Q?TaSKi0zpCA4RaPmUnnHI5vIAvJmB0KLkdjGN545e2hha7hNPxJgJ1ixN5F47?=
 =?us-ascii?Q?6BQ1siSZAjxasJvwnRQ/NUFs+pJJ6gAwYTWyYLG1Cj/RFY/C0Zb3iogJIuit?=
 =?us-ascii?Q?24rUQX99GmFW8V8o+LIwiBK8Kg0+GfJljPTgKDnrmxzhLb5oLlTa3igWj86Y?=
 =?us-ascii?Q?+Yweh1RovE2Y9LrksgNooTGYJRMi+IzcA7ufhlnwyzdp4+c80QeMujiJSyAe?=
 =?us-ascii?Q?GGiUW7l7Ax4sGcIgLzpahuy6T7qtOLH2zU11E+v3YqbHH1kGEjZDgIxtdpHB?=
 =?us-ascii?Q?T+MyKxM6dxPqTdBiwloP8/gG870c9aZJ6wenfX3K+b8rHAqJcuVn0QN25NqH?=
 =?us-ascii?Q?/Soz/pmnYV2Bmm3IVDv3IU3wS8eCFxYwDiUfPOXA+geKOAkibDEgO7mRDzul?=
 =?us-ascii?Q?CAkRIP6lsKJc12p0xZUP4L6Y5wHvSOLWHzsnnTZENL4hhGix/+e7YwMd2QEW?=
 =?us-ascii?Q?zUdlWGiQn0iueZJl7kIZ3BCeaAkIzuenau753q7xw5ZXbIqZjB0QajhqXQUz?=
 =?us-ascii?Q?i5Ainm3QClxB9/XbedagBsXrkL3BbxS2UZlgnD5moHAxJ1Wne/dvndwhcc/K?=
 =?us-ascii?Q?ltfJMgsxQOrS8e+h4FWXNZ9eH4OYLTjhfbA70lDr6IH8CkqguV+WdqXI+qIL?=
 =?us-ascii?Q?4UlFdxL27NWahbnoHS6QQXJtNSmvfrXHARN6wUT9CQ9PrVMfCoP/zLwAg5yX?=
 =?us-ascii?Q?cKPPCNIHz8cEEVmJEOnGxvLjqInu/kjg9tefDZTzJj1+hGpbGYU7WW4fClMK?=
 =?us-ascii?Q?2SQ8Gx7CVOA1R3TA3VOOaC1tMVWeM+xyjvkJlOgPDXK8L8M7M3vtdLct0vgU?=
 =?us-ascii?Q?4GQ6T21Ftq11iMg4XGdPE9mYdrQV0S1jaGzrE2Curmo/AoMgmQZAfVrRY4JA?=
 =?us-ascii?Q?3yn+5uPyRIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PU/PjGVZpgxhd2/1BE2p3YPRbOBcHaYVyDFcyW3tmXwbZqG/Mi9Jx5ACS6B?=
 =?us-ascii?Q?srA+ZK/YjI8vzRHTAy12UGpPm2/UTrJNJ8OL44BKkcTHp7n6sWeWMfxXbEfh?=
 =?us-ascii?Q?kogoPucbfmHGxbNtxdyWrboLrPYSu0GJ2sKvciIJ8LS0UhtnyXb1bu/ncQMs?=
 =?us-ascii?Q?9OZLhFw1iC2QGWwhRGndtmHZvqXEiYq1FiMXnV7t+g1frc2Pe/jNwXl41zd/?=
 =?us-ascii?Q?CIwi7s2KXcn0nKOppFIp7lS/wJezIks5kC/G2y+pIbII4MBKaY+ofMj+KGLx?=
 =?us-ascii?Q?58gNKs4Chh7tjv+Z13xkHGfu+E/5rDvbBmQgGzi4oVxenUV5Bu1RT1tnoLQ/?=
 =?us-ascii?Q?X8cDBIokfnbsSEvBa6VEbLNXXG83nvDTt3vrl5ZIzagVTHOide6ANznu2VZK?=
 =?us-ascii?Q?2Dw0ccQj/yZraP57QL6yLVWo92BMZTO/g5GfwoHCYJgX1TQWC6IO3q5vsoi5?=
 =?us-ascii?Q?hbfj78oc4jShDPvD6NzjNpuGlaqmd1HFI+r+xjroSPsmRaWbNarNb6ozv04e?=
 =?us-ascii?Q?ICBDFACSw/+2GwBNqwyKGKQH5z0+rVLRFADfb0mw8oYku88ZcJCq09DJ0yAl?=
 =?us-ascii?Q?Kwqudp5JvADB9/seboFYrmtDFCAdccN629zDnU1zu3uE2F1Ts6KyUCIAAcNM?=
 =?us-ascii?Q?gG1dWVac9r9QzjeeVgLevjGRaXGAI9ak0cZPzynCocLaERO2S2hI3fuGUDbE?=
 =?us-ascii?Q?7qwq7E9s5ovMWMQli+wX9U01q1fC4tnGXdNA26S5zkHt8D5Cn/23WGToLo1l?=
 =?us-ascii?Q?2fhtaqARH+LyaATJvXPWiKl2ZarK7mCoJmAqJXWSvP+IOtaP/B0OFoW4GvkX?=
 =?us-ascii?Q?WsYxJwHCND3HsjvnF1Y2mKosd95zOxfm1ujUcLmDZ8laXm0OcGrBae3gR1r6?=
 =?us-ascii?Q?4OY8hSyyvKs1DWrP0u3OXlOurKxtWOgscMm2whrgCai94mP5C/6C+fsnld1G?=
 =?us-ascii?Q?RGTBu1nj9aI1XaJWpt+9eNryuKwD4+dU4TBCJrUjSlykSDcw0Wd0Hao1A5yZ?=
 =?us-ascii?Q?UwnwI5zKar0PwB+WvsuVYbRKzH/BVQof/vvP/ES305vYRDkLjSElDkLA9DfY?=
 =?us-ascii?Q?2qUHchi+BrREtwAD3EmbUOjZfFgn0NhP4aGVM5PLMHhrd9g7KhwG85KHb0AY?=
 =?us-ascii?Q?3q1TO5nZtNLdojX/UbkqCpX7/8ldaup3mVFoTn2l5QnCVWOgbl9ket+VpBPc?=
 =?us-ascii?Q?t6EM+rmteCE2a2ruPAOQCh38Euo4XMda/wwsEfAaK9ZjvZzw8eV7IU9WpJSc?=
 =?us-ascii?Q?B1oAPiNzT5Dq6PnzlLjJBHS1td3B2jaqTpuHpjLhRfQ82avgPKyM78ydrGR8?=
 =?us-ascii?Q?DHSMPvNyUzY6/8hM+iBe6iH5nlDsh42iWiKvIpL1SogusDQ+iwFc/+myoN7g?=
 =?us-ascii?Q?yZdmjREDP8pEMV+9rYfV9akSCkmORwzFDCO6iUTitCcaR/nWgZrUvQd/mPWc?=
 =?us-ascii?Q?FxhN1w4b3xZmhqCTdctWfOhtLpplRSEaOKeZ2daCLNwk4A3TvX18/qn4aeJ/?=
 =?us-ascii?Q?YXdEhO+qPWW9TYYXxasd3+ICk8E4mXTvB3rvxCypvfpNG0ZFzIrY/NWSFzUu?=
 =?us-ascii?Q?grxkjAeRUvHpfVlEKpjf+Yi3oAhtdCFuPfrWaF4mzzZcybhR7JVes/S4poY/?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HBKNjegAP4S+/EFJEs5HDXQVEMAF7vX8l/6p9CxEgcui8bS7hwkL2lkpOXDV02dDuMgOsKOcCptHpO5TsxSt3ow+X7AqfwzrEWZ4D6rt55r4YvqrjZ6eCAXQm6258FjO6df6rUp7LA5roMsk7d48ExmRijx07oduwP7NRRjZsIFnv/AMCIh9/PxzmOtedWWRxar4JtdJbNLPGTNVGcvpHM6NoLML0166nx5WogvG7/4P0XNGJ0YQyJHy9CyRwkfNkhSuH9g+ph/Co5YnJJA4DTd98E7c5VfwrhJRf+xaC6WlsCH6lVxwWzlMQet016rxuvLuOeTRrL08LHSV9ru+z99j8RjYqAxPjyHKQovoryzeBMkbiX76+VSBP43qDhIB3dhK4kWNO3U2klAtieLachKgWXc3TuEnN9C4QmvajsTnDcrInVz8q9rmKWRi8Vb6ieLbdrHAdqnws0kvbIK7ThtWxkmr33TZYU94sffXlHJf0WnE+F70YGgwp0JBm0thC1ESYdrKhvIjPRCoTlnSu3avLub+BIb1EF5rrL+OaUf7ULUh8WNgiBVj4tahyT+WgpP6Tmzqkm8gqxWoMY91RpHYJGnzsalztjsNFUmKaT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78886586-67dc-40d9-0060-08dd8c7d15f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:02.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zt13YwWHB37efhEDLIVtdM2Kl6C6sSt61FcUZPpcfqFnonLsz3VqEQFdc8dUjVPeqXblIZ4dhuM7DAZqQP9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Authority-Analysis: v=2.4 cv=etvfzppX c=1 sm=1 tr=0 ts=6819d0c6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=04d_y77oF55RfSPHe00A:9
X-Proofpoint-ORIG-GUID: mwWND3r-Y1qfZT6YeZhG6zRUrh2Oz_wY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NSBTYWx0ZWRfX/7bYEOaOGWVg DNGD2jn0vJd+Wz1JhV5vsfQKK4dgczREDMtv3yJ2ptMUo1fTN6dKLQG/+ry6e8b5wLn9OpErh6C LzBcAblwtX3DUo6uFOfEaJPhZ+9VuGq4IxY0m9XCnZz9O2ECJr/CILF60FrsEID0qkX+e+ReLZh
 DF09ameo4CZV1TOVqHBDWhUupH31TC9knm7OIsL7jZ0aXAobf/fw6uAFtWgY55/3PWeoiQLo8hF mvw/JGSwN6/pDd4mr/0LtIk9eYY/L91y8uw8HwV1UGroUct7Pw9AyXgKksTm/OuqsBXtXEYuPB9 FTFhN/sgDUIy/fT9mrYwuPzHPqQ/ej97kmJHaESZN3vCTfqkLbgohc5hB1TlZB4LDNuUT5FPIxE
 wDPPfetFieNBjjAwsXnMl60eqS9XA/4OBGlxRmfFxYk5BHrwfAEedryoXaAV0qGNsFgqVusX
X-Proofpoint-GUID: mwWND3r-Y1qfZT6YeZhG6zRUrh2Oz_wY

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

About 17/17, maybe it can be omitted as there is no strong demand to have
it included.

Based on bfecc4091e07 (xfs/next-rc, xfs/for-next) xfs: allow ro mounts
if rtdev or logdev are read-only

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to v11:
- split "xfs: ignore ..." patch
- inline sync_blockdev() in xfs_alloc_buftarg() (Christoph)
- fix xfs_calc_rtgroup_awu_max() for 0 block count (Darrick)
- Add RB tag from Christoph (thanks!)

Differences to v10:
- add "xfs: only call xfs_setsize_buftarg once ..." by Darrick
- symbol renames in "xfs: ignore HW which cannot..." by Darrick

Differences to v9:
- rework "ignore HW which cannot .." patch by Darrick
- Ensure power-of-2 max always for unit min/max when no HW support

Darrick J. Wong (6):
  xfs: only call xfs_setsize_buftarg once per buffer target
  xfs: separate out setting buftarg atomic writes limits
  xfs: add helpers to compute log item overhead
  xfs: add helpers to compute transaction reservation for finishing
    intent items
  xfs: ignore HW which cannot atomic write a single block
  xfs: allow sysadmins to specify a maximum atomic write limit at mount
    time

John Garry (11):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomic_write()
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_calc_atomic_write_unit_max()
  xfs: update atomic write limits

 Documentation/admin-guide/xfs.rst |  11 +
 block/bdev.c                      |   3 +-
 fs/ext4/inode.c                   |   2 +-
 fs/stat.c                         |   6 +-
 fs/xfs/libxfs/xfs_bmap.c          |   5 +
 fs/xfs/libxfs/xfs_bmap.h          |   6 +-
 fs/xfs/libxfs/xfs_log_rlimit.c    |   4 +
 fs/xfs/libxfs/xfs_trans_resv.c    | 343 +++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_trans_resv.h    |  25 +++
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_item.h            |   3 +
 fs/xfs/xfs_buf.c                  |  70 ++++--
 fs/xfs/xfs_buf.h                  |   4 +-
 fs/xfs/xfs_buf_item.c             |  19 ++
 fs/xfs/xfs_buf_item.h             |   3 +
 fs/xfs/xfs_extfree_item.c         |  10 +
 fs/xfs/xfs_extfree_item.h         |   3 +
 fs/xfs/xfs_file.c                 |  87 +++++++-
 fs/xfs/xfs_inode.h                |  14 +-
 fs/xfs/xfs_iomap.c                | 190 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                |   1 +
 fs/xfs/xfs_iops.c                 |  76 ++++++-
 fs/xfs/xfs_iops.h                 |   3 +
 fs/xfs/xfs_log_cil.c              |   4 +-
 fs/xfs/xfs_log_priv.h             |  13 ++
 fs/xfs/xfs_mount.c                | 161 ++++++++++++++
 fs/xfs/xfs_mount.h                |  17 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 146 ++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  80 ++++++-
 fs/xfs/xfs_trace.h                | 115 ++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 38 files changed, 1351 insertions(+), 127 deletions(-)

-- 
2.31.1


