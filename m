Return-Path: <linux-fsdevel+bounces-39450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE2A14468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 23:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEADF164213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2AA22CA1E;
	Thu, 16 Jan 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjZVpF9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mk6tnywV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AC155756;
	Thu, 16 Jan 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065524; cv=fail; b=hfgd30F0Ze11juA6F4NBCmzaMax9SzNGw1cDjHQfKNHu+TJ0bF0flJI8U9wv5S4CN+Q1eMST0YukDma9xqJ0YPLTFNogc47aNnjib5NMcA2WubasKcUFKcYFQ9ovnay2B1Zs4s7/1GrlS/sH56qfGMbY6vC8PurKamsq61IX24E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065524; c=relaxed/simple;
	bh=fKqSUxT8bnk4V4Edi5R5/hj2avQoneMmU//uqVeB1hU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=jNJGA3psrX9CyFUGjLW9UNeQP7PmxQEAVMQjOKzHIkpmamKX2d9SeV3UP1mlRtg/8BnR9D5jde4ZieThKhVe2DDHsQ1+Ti+Qk5Ms0TbBvjscX+qXJb0IVs3Dkqwf6VRoo+fvdWXzbhE7oazw7M2SV2WCGBeWrPz0z/yY9Dn5y6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hjZVpF9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mk6tnywV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GMBtPE020062;
	Thu, 16 Jan 2025 22:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=y3hE3mSqLhG2bN5c6k
	DIlEwU9QLlO4z9Wmx0K9/K3MY=; b=hjZVpF9ESEF8v9MgvV5xRoIMCFVjE+BFuS
	NUM6kAegPWAe5Rs64rgi6VHTGO8j1s33KuHPagJ0NPKHEragb0kTE2Cu/WnjgxWi
	QHifEnKEeLJUmN5YarnIthN7FEaSjZHtBthnfVqWXAMEhpvLOKVoS5IK+tipFtiw
	Yw61l/rVg8+QTIoPsCAN4jbboUMpWr9WaDbJcvMZ55c5dDvjLtA7T4XGT926FS0d
	Ihy5weRUdw0Hk8wIab1Jk4OkUQ8D229etcfrLu/ILZPr1zKLs6TcYmHxhUbIRnld
	rG7YE4VH7mKCoRnHZspDtFosBQ/PBfHq3Anj9xKvtKj/DpWGwSpw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912v0k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 22:11:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GM5cJc004593;
	Thu, 16 Jan 2025 22:11:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4473e5k93h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 22:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEzbenIomfQlOjsQrslXZaZziSkNCqu7le/OqfmBKq8k1Sdrf0l0YS8zrXWyNFpy5QbePrgxFsAnZAHjVPWXfBFSgiXRUHC6WAl9zHfXgdRU4cdS7eM7jSphvGVTXafC8VsjsRmM0793XXIb8j6o1tC0ExlLuhOnZ1tCP0aPUrAKSMWjgJZgBEPZFApT1f1y8ewECLHpy3H0woL6bepmMN/Q1ulYJkXNhk4c7bzjw2Q+pcoE3kuj5vCdH1zNuArdA1cokalPdvh8rO4QKo2Q2Gh6tLAbS0WaMZYMMZce4x5HXdqNBvCpw9Rp7AXSwP9SUU9KybELAuQcjDuZMGtcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3hE3mSqLhG2bN5c6kDIlEwU9QLlO4z9Wmx0K9/K3MY=;
 b=M13+lXhnlaa1/deE2nPp8e01u3Zu9wYUxDkwhsiHg7S7d/Ps36/onaWb7UEN3lZ0qz2RoHT7pgW41lG6ai8+sFXW5t+TVjC1AXqmJmotMtOVu18Al3BwsYpbhxSXuR+OX/lVRGbpdBDgB8hb9ASrNTjxx3e5vFSTP3Er6/Yi7fXQVmboSQ+rN8UKwkcWS6crYTpoS7oTFrKsiLlPfSAYAm3uhzUbZ4bax3yIZmbiUsZDzKcTZ7FiiiE5b/rAhMT4YUHA45oFt6Q70aMCmdbYIpac6J7PVv55pF4x7dDUpYsrP4AQoL6QhFRLIF5tQcK6YXm3kZGWIBIOAzizr5Ik+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hE3mSqLhG2bN5c6kDIlEwU9QLlO4z9Wmx0K9/K3MY=;
 b=mk6tnywVGPLKlX7l1h7zKd1DDrl3dxxMf/jhEEpdarWfeDZQG6W8fLUk0zfEF4/uniVyRfo4XE2o87M2SqdV4EMGJxgdh+G8va7IBkKEzz2uK0Ft/2K/j/VSCqCMn+UHqNuY+pnf6ZYX9YvE9sys8pdQWxAGjkoMDzzkWjbK+Uc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB7580.namprd10.prod.outlook.com (2603:10b6:208:490::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 22:11:44 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 22:11:44 +0000
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig
 <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Anna Schumaker
 <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Implementing the NFS v4.2
 WRITE_SAME operation: VFS or NFS ioctl() ?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250116173000.GA2479310@mit.edu> (Theodore Ts'o's message of
	"Thu, 16 Jan 2025 12:30:00 -0500")
Organization: Oracle Corporation
Message-ID: <yq17c6uzao3.fsf@ca-mkp.ca.oracle.com>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
	<Z4bv8FkvCn9zwgH0@dread.disaster.area>
	<Z4icRdIpG4v64QDR@infradead.org> <20250116133701.GB2446278@mit.edu>
	<21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
	<20250116153649.GC2446278@mit.edu>
	<5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com>
	<20250116173000.GA2479310@mit.edu>
Date: Thu, 16 Jan 2025 17:11:42 -0500
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: bee5d542-a97e-446b-318c-08dd367ac345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvY3A1a9pO+Ol3FzDElMOziLG2uYjpAl6ITnityxoDG/6W1XDtcGcV5fqLA/?=
 =?us-ascii?Q?B4QOJPceK9EeV3hQLtW9X76e1i3R45JHOIMJwPVp20vh4nJKvnPjqQFWhd3C?=
 =?us-ascii?Q?6/tMkbF2buBcN5eJllAOlEtOoKUAOeE3ko3EfZTknJmd4SsOy6pR757hH8qB?=
 =?us-ascii?Q?WL8zgT6aZXHzEIJ1+d/J5/XJkmV7kCzhGMrL4iCTp73G9b9oqVYUUDfTjHfJ?=
 =?us-ascii?Q?AmY463BHsgrq+Jdg/yaWtEfOp+wOHPiG9QPvsfhIJmnIY72eQoGy/IGshWfB?=
 =?us-ascii?Q?2GJwPwCENrV0niEJXVTiahPkYL9DLzPIQqcrysJFvNJgE0jVxepWZP405S88?=
 =?us-ascii?Q?VUODIAPhFix2mmoe5c4MT8e2VJo4F/ndbI845/grWnopQoWnw95bQO++slyz?=
 =?us-ascii?Q?SYyLoXS0UtHTWpYFEtvMgU5MaitkLeJvXC5UrAndB0n4SOtGWn/Il1XXNhGm?=
 =?us-ascii?Q?7d3E70Zkpx6qC3j8503BdL/zmBlbHIWYiNhOjeQ2ZtiNh0skT6jrQzN91Sub?=
 =?us-ascii?Q?vHEj/1pNXlknL1JXs5cD6IJLdbWiKQWpbT4xddSa+8RHJnt+buBvXFdbxXE+?=
 =?us-ascii?Q?9xMoFj63zU3qU7fiCqL95pm5lOVAZpJz9ReSiKDHAgfpj11GoerSX8n8bNzZ?=
 =?us-ascii?Q?H6Vo+aIlGcijsgZN8YOZOUtIoIKCBWjWgsmGCToBrVdV9ysvEurGE1sJIClT?=
 =?us-ascii?Q?gmY47E9CageDMwmkMB9gblKDyyPT6H6pqf5nE97DROlh+Up7MT5Ad7I5zhiK?=
 =?us-ascii?Q?ckdWZcrkeyRr5t7cn2zPaYHwlPT5oqHZImd+y7MXJ7W6F6cvL3ShVWhGo1JY?=
 =?us-ascii?Q?KRS4TR+HXx1mhyb4Pb8bCuZZpoAd/S4c/3r9tRrrQgvYz1XSMtkMtj4N3dH5?=
 =?us-ascii?Q?5IxerxyS2B5CjeuM3oP+AS3+sZ37Rr8sfknSjRP79uBoVJCs+lFq7oY6F8Jy?=
 =?us-ascii?Q?YDks+Kq9LhsPu88TFjV6oFnnpPuCYht2v5s9f3PIMOLf5yZLLR1RJ4XJfVt6?=
 =?us-ascii?Q?NLDTH7hoq7ZD4+sA/HxMqAyepIGgRdfKgUxwNK03CassrKo8P1mfnPbq2Cug?=
 =?us-ascii?Q?z7R4gsKYomoOHBtZ92RJGcoL9H7477W9JJD6etGqgcGdvL6vIHx2Pm6FNRoM?=
 =?us-ascii?Q?sMOX+/5NTpB/vnbhct9j+7zuNZynz0cPgArXdLbpx4cv6fCm0fubriAtzsFA?=
 =?us-ascii?Q?rvEHhYYIJ1RHxtxk1zix1UQfS2dnet1R7AbqbVD2vOJwDziZ3eLfJkCJvSYo?=
 =?us-ascii?Q?ojrfp7AqSRs0UIcLdlLhml0q1CdyzyB8W5Iqb9c1R16dSU73ZLY+a1U7ECJx?=
 =?us-ascii?Q?WDKNi8N2kcbETTPDVZkdD6KiowDjzIbE96ZlAl0ovvSLRWvGCH5LrS52qF54?=
 =?us-ascii?Q?pgPpq574NePRFnBQjUfwxCOSiQY1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G04LGtSW5KF+2/TeWze9PQaCf5B6d1hKtM0iFdk7jK9Aot8Ula5q0Z4P5t3g?=
 =?us-ascii?Q?Hxeg29RHCEJEOOCFSOoqnM8wpuTeFOm+d4SWAg3H4SJ2OSdnrExHag2BrtXy?=
 =?us-ascii?Q?exz3EPdTe0B2vIHibkKXBDiTdXrZS/xuifU5JRVLMg7pBuErP3pCl+G+6u6K?=
 =?us-ascii?Q?9IdzVB/+2rBf3FEqliz4A7fxID80LQxEXlpH3zpML+b0abyibNyj3DqUWJdY?=
 =?us-ascii?Q?F2qEACPdDOwNQN3BPBcfh1IF90xzxk51k+D71cPz1flnUMFPtr1fuBXnstN/?=
 =?us-ascii?Q?DNhX/181xyBW09lIMlVY7qwzYJcV/luNqicJ0sXgpkzeEvWkyz1CskPMDem0?=
 =?us-ascii?Q?fgwOX/NbnGQgf4QtZZZm4/SNNeRrKhmferjK3DXB+JHnNmpkuXq5+h//JTlB?=
 =?us-ascii?Q?5WqGVnJEFJ+ZH3yOsXrB/ZhUk4ssmvnRJZc+wzYXM/OMpx8eDgJ2eoC9uxSw?=
 =?us-ascii?Q?mx4Zdk8Sf7YItYwLh5LX1WOwKw8vcQ2GBUNoddaQezEaXAUN4P4PXYyG1AX4?=
 =?us-ascii?Q?0HZaxXGMgdPRRAPOSsq5h+XXhoOPCQtLrhUPhYQtcxoerxuIzYRklR9et86B?=
 =?us-ascii?Q?/j/VeJKjvuWSRgW4UAJpHyH3dLCwsWllRgqmJwpQ+pfv5goCz0KzL1WC+DFP?=
 =?us-ascii?Q?a5hv9Tx14O7pCKko76d8pa8+2onihiO361229w6jfiiQNoG051+30cdROmvP?=
 =?us-ascii?Q?v/p/r8bbZXYjq9igB6SOX34Vm9Jgnxmpw7uJSDrHXXYr/Gu28OWng3ctIMgX?=
 =?us-ascii?Q?Djeg7HAH7jcsUY2W4IgY6WvphyzOGcbAnzoL9hwwkFuWtG1i1zrcK4MwJMdu?=
 =?us-ascii?Q?rwvLpr5UeCXFzvzXp8Gfca2aKMLMUPjuYfy33odZv5DXFVVruRUainNq54/r?=
 =?us-ascii?Q?UcEtYR+o14jp8CRT3hUncMu5mhB9F8jf4QgxlwpdUcIBb2+q/TKvZktdNcXj?=
 =?us-ascii?Q?Y+51/76k2G+HCSGCzj1Ax61grgYxGgqDIMxMbQ0xPPfemgW90MyUxjyibqDA?=
 =?us-ascii?Q?O7GsiLG/X82yUc4EZjHhbAkxh+tbq10SmLpMRbQFmmtUNyIxbqZ8aj358pDo?=
 =?us-ascii?Q?0p797GRl+TpaiFwbh2xuS3OJiHYhO1LEChAk2ZQIn/yt+XaMaWq5nOiaTOOv?=
 =?us-ascii?Q?Dfn+94uLlBI5AR82cR8YJ5hRJBfz2DZLp5y2zjuZXMwK1PBJ8hu9y8nP3vaU?=
 =?us-ascii?Q?IK2QaQ15hd+y47yLSjR2BYU+Z8yf9KyBkSBEJv48meFgFl1Kb+IOLf4F2CgD?=
 =?us-ascii?Q?5/setiMNxkPNIgPFJqp5lMTvjlQI9k6FzWQ1//ldhdmI6TZv1HOV5dfZt8ME?=
 =?us-ascii?Q?cjOJsKyVMSpSMId1vK28iUI0QqKbjMQK1AKy1Hf3TdarE/ELlTpz52mX7Sfu?=
 =?us-ascii?Q?CqfSlF+iWkHfG5A1yVWpmz3jnwLE5roynnNtKan4VE82rzj9jCHPcokDS+dd?=
 =?us-ascii?Q?mnl+TqXOzJZxqnGAUOTAtyJ6ysnVWVdQes/Ro/5oiyH/mOCXE52r9FjHBF8Y?=
 =?us-ascii?Q?12/LVmasyILGxD4sy1yJUlXsE3u1Jqw1+T2DGBY2N99hl+7Xlu34YBBFoHsl?=
 =?us-ascii?Q?SHYLEyxiR81E/gK6kZQje9xOi29PZzLW3uwkHfcV0SUKmVB6/bfOzlRq9vbF?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i4y9eGNf777BajFHJrJNkoRC1LEbE5xi4Y9fD2tHHfHuPFXfKOlK74BHhBVC6f8OihIOCNdFo87UeQQXIOmVaY04Qo7TjX7u4PVgsUBFJz8ApWTpfBZAxkuY7gOsuV+LTG5gfZTZ3IxzDiOx626VCliE4h9sLMBgqpyK7uCFvK5XY9EPPO+/5/CyoLXd6vftzUj/c2iUy0ZqGAH5nMlysxc9CMv8EoaIbqPkRpYvt83QIvy4x7gjQhwpYGeX7QSKn4iZS6wQnpkk8oVjsqFfPUQy6OSRRg5DdK4LBk+PlS4BIkbIdOsODZLjwHTWjq02af0QiUn2LedbIJglAhLwd7C570p41BZBDgxvWFNCN6JGnaqlEr0mIMdmWbqowP1lgr7qLYPBpvN0Hmyi1+pJXbMMex2QVJaG7PnMf4ZF7Ehm2YThDxUu9gc9Scd4bTSbea0dMJUrzSNIr9Dpv1tdHIcbnkoJc+jgyeCUEuxRAFME9T3ReUvpvroMuBuKYqvnhkbT52z0u1f+g3uMvlJp6N3f+kv5W4d/d2FhYKfg64tJjh9x5sUrPZ2eSN32FQzjZYvY4YRqh+K7PMivhRjj3uf/3P/8zxvf79iDfuNG6Fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee5d542-a97e-446b-318c-08dd367ac345
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 22:11:44.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kay+ekP5ljxivqyEAEwyXi1oUqfF8cbuwoRV145S2INF+B+JVagAlCXjnRFYC3qgM4pVolteiH+sII6Iu3woAelYPvfYvAntLAF5nTQ4ci0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=987 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160163
X-Proofpoint-ORIG-GUID: oiYeMaOdEE2w5OHTqqllpGS4_7_5Pkmg
X-Proofpoint-GUID: oiYeMaOdEE2w5OHTqqllpGS4_7_5Pkmg


Hi Ted!

>    * DIF/DIX (although this is super expensive, so this has fallen out
>         of favor)

Several cloud providers use T10 PI-capable storage in their backend. The
interface is rarely exposed to customers, though.

>    * In-line checksums in the database block; this approach is fairly
>         common for enterprise databases

Yep.

Also note that DIX/T10 PI are intended to prevent writing corrupted
buffers or misdirected data to media. I.e. at WRITE time. Neither DIX,
nor T10 PI offer any torn write guarantees. That's what the dedicated
atomic write operations are for (and those do support PI).

In-line application block checksums are a solution for the problem of
determining whether a database block read from media is intact. I.e.
in-line checksums are effective at READ time.

-- 
Martin K. Petersen	Oracle Linux Engineering

