Return-Path: <linux-fsdevel+bounces-30941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51898FF85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7851F22479
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21A1465BA;
	Fri,  4 Oct 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PueZH2l7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OQFNbddH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB0136345;
	Fri,  4 Oct 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033813; cv=fail; b=MI6BFsJ4b80oUT+KA2wgGk6N9A+7OG7w7sTwP8VBp2PAet5SGFUPKCjLGocv+IHXkL/ftmxqgJh1g1Q46ccA+7S4xEBnDwz/J7ruVdzoFRM04+R82SKckxsraeebAYiJDEXAH0+zKRkExAPl6Fp92rV+12+AOdWM+ciBLPmUdM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033813; c=relaxed/simple;
	bh=VYomgq7XPScT9hq7HFcQVndBFPpuoTrLVq3Yu4X/fWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ers25l72nSjFcIkFcnP9FgjyvktI5PUTfSgCWr/Vda5l0B30CiIVzbawIkQ9NH7tNihgp32meGE33/5ng+ywTMOT1GZkcfLC3OwwKFyg89MXFm6DRaYWBYXiWBeGJFbQpkBWC/eBXlzWo+gXeV545xedMtUn7rwAn/PLeKdInnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PueZH2l7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OQFNbddH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tfxA009097;
	Fri, 4 Oct 2024 09:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XHBSpW4EsR4GoFQKdwYRSrTS5Gxr2Ae2VonrBgoXKcM=; b=
	PueZH2l70Chlsi2KVN3sTwmGRi3QpmRyso74MgsNMKqWpcnc4oY83Fc72rCzozIG
	LKqBSAZskesjcF/BV2+8o5BXbSeGfu3U8QuLJaLJrOxOcwtMeYjRtQArF/9KJM+8
	iqc9KGcqCSBHwRR8pbF+Anobem8HHV2UzmHDXO9R47foUbbTw9NEjJgiZgznSZxS
	UfL2KD4jrAwAyCC5FKxTm3T9cfjcY67qBrE351eLH4d0hrbbzSmk+dxPhcxzJrDv
	Gl7yV1JVY2N74ZXfgXgrwx4rRAlFvXfqScDyNA8kzkwGiLd6FUthH1lZQ8gWSPQj
	e5YKoCT7lnz3/EM0ZhL+7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204917xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948fmVP005835;
	Fri, 4 Oct 2024 09:23:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4220568vra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVNmDeTvihUM0mGcxpGpxMWSDQigKovcP3uwfCO18axJtF8+4C8UKdEwQ+mQEKUHW9rVakaecDzaiZDrFy2vXk0S9j+/qhOzEo1eOZSpvw37++ldA5YRog9qQ9rxhRVEPaE7coszK2yCuki02lwSzVkP1dfU9dh1h3wqhLLhTz6g2H+MwjamGVmzxOSOjzzAhP+DKUUkTvkSTXlEmVaIcjVtdBllScONk/VayjHVxfdLbHaVKB7RxlnuCAhtW6LnftQnmSFhV0m7+JKLGUooZ0AP0hONovyy4+c5pkZ5rDOe3f+n8p2pbFeU6KSdY01w5rntsouN2PdwHfxba0Mq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHBSpW4EsR4GoFQKdwYRSrTS5Gxr2Ae2VonrBgoXKcM=;
 b=y8PSIMUi+xDYy7LuhTNNgkCElvXrQDfXJn2XwPOq2rVE7lGH/1eho2jN6Y1H3GWCiaXf+BqJWZuWqLx5oNKqlAatU1wdVwX63DFUjEHOIZFtgHoAMbhkpALqr2Qf8gD3BkI6vWjNqWkyLXpZIax923m6CY2lz9uKvtLnpmu9m305QpCxY6qt2bMh/A6pj2wQLZlM06bpVuUu4zxF8PrhHiGMkxf0nC1ex+tjwycdnGkK2W4DEJBX8LFCatkW0WrSXoCay454zSRQhic5C0ji8U4zT60Jvpb9PV/rI/VWIqa0p/G8sjRyEYywHKFwSTWUnDCkUVOqArD5ntBfUvWeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHBSpW4EsR4GoFQKdwYRSrTS5Gxr2Ae2VonrBgoXKcM=;
 b=OQFNbddH49CyjfGUObUSncl9sC/9A5AKnACn7KKRxiYdVvlp9Kq1thIHAJ1/vyBqlgsGefi0KVNeDSLP50qvdG7AF6tO1gXrOXFI8QNEUFhFL6h9PBylwtxTjtc7iGsyU8HQ1fn36nl1gUZeCoDQW/xG4ttG0R/ka0j/KKTCXxU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
Date: Fri,  4 Oct 2024 09:22:47 +0000
Message-Id: <20241004092254.3759210-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0561.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccbcfea-81b1-4ced-911a-08dce4562c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjXIxm9mrXjTSxyKhAHpWdOrP/48K29jxHZFKeis4B/GR/Yy9aaydaNx7bMl?=
 =?us-ascii?Q?quQjO9z/8ciKWG1rfuMRonbLdWXV8i14VDNpBB1znJBEtIQ0ZCMM4UDZA8Pa?=
 =?us-ascii?Q?Drldakf26ioc6ve+4/OPOD4q9o0L2JG4S7RQ+Osoe5CPuRgYZV5bCIVGg81c?=
 =?us-ascii?Q?CC5ZBo5+5vuD+fGONN+onYApeCJoRuYjiN114aZ5YA3MfTzlvh12UoZFBPZ0?=
 =?us-ascii?Q?6WDF2gj4aTrvS1bwvPt//Ae9pGSo7JUj6BuORiWPjIZgrfF9k94q7zPtlwzR?=
 =?us-ascii?Q?CWWIwhzcRZDn/+CUKUZBIRGda7J8FM2yzAeKtl6R2IZHU/jSkVRNfZWLgypd?=
 =?us-ascii?Q?mjIKqVZiuFpoa31susZ9kve86DHTA1HdNuFL2uN76zG5NiqhGZ5WPubQ2Igu?=
 =?us-ascii?Q?AIZk3pyyordCf023h8z+eaCgfSc23xFpPheEPBSqWr9n/B2ZbcJX41C8/oKV?=
 =?us-ascii?Q?RtDepwGz5apnxDHZ0Nfh7RR0aE90SSwnie7aSzHIf6gbqGntmnVXc9hWQrZv?=
 =?us-ascii?Q?ZWkqX45C/y7+2TQyO1obh291xrJT2i/ZEW71esM90r+BhaH4Pfqs10jplu7d?=
 =?us-ascii?Q?OGrouPlChwYgcZrc77Cq6DeA1gse9DikKrMSK+w9MKDrlPZkPFOujSyybO9e?=
 =?us-ascii?Q?dJY5RRLTXDe/U1WCDNeu6GF150FHFCNopokAmVejZe8dqLhFD0epFgox03HV?=
 =?us-ascii?Q?gesGApFImz8bCQXHcsDWsbL2yGOajoyDqrnN4mSu+KYqttCbXeej6XKagiPA?=
 =?us-ascii?Q?+DL2fznbGxx0nT3HpgYLStzT/J3OQFJiYVHlAPl5Iml80evCUM1K/Ez0MZSg?=
 =?us-ascii?Q?xYGdxBDnCpDPadiHjdKswVU5HSzYqYm6bShAI7rfKBmZlpSX3sHYPRlmgiwx?=
 =?us-ascii?Q?n/EVroR7iAv93uScLfm7BxzC2mDejx2SaE6gL3y8AwfHvrfNFde5TCKtMNmP?=
 =?us-ascii?Q?YP8i/qulheJJsTYhG4jo0h3f9z/HnseaHk8HEMiiq+Iffrdy1wMJ0hyfgKG3?=
 =?us-ascii?Q?LsP3J9Dct01Tau3XfOoIt23QP72Zr6nlo1lg6iODLzJS0VCx9ZHHgJzss2/U?=
 =?us-ascii?Q?X+gbR9brUydse6mFksXyzcTRfyCT/Alj3KW5yT9y9K35b/2f1JBqOMvkXgNl?=
 =?us-ascii?Q?F/DCOOzfcAG7o5w7H/pPGZwTLyTFzL4nbEXnnOuOcwokGoknPIrQuzMZbon5?=
 =?us-ascii?Q?drgeUCZNLgfU5Zc6tZa80JPFgqgncJnQKxWRFO4yilBSrujpHyNJfjD99/mX?=
 =?us-ascii?Q?n99g/wHzMEXJya4uXHXP+IBhwbcDjIl/GECoI0ViDNP9nbJEltamcRLoqDq3?=
 =?us-ascii?Q?YaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zx5kt+tB2oFfYUNRIDEeWqP7dHCXPgoQycgYYcqzlgvbC8U+0tzWryS465K6?=
 =?us-ascii?Q?BLiXfgd14fFQfyufCWDRgDnah+YvGyvct0MPbqHo37oewX7PSPIEDL7GhaIZ?=
 =?us-ascii?Q?SDF349Mt3oLZzbeVaYctp07u4EmuVN1srHwgQNJt8jnHJqhucFQNz6SCJ1R0?=
 =?us-ascii?Q?5jt7bDJMeZaAZEIDEtAEuffZ9sTMMiZ5ousQrzbG6kbQncpML8+8NO7s35jZ?=
 =?us-ascii?Q?yfXhQ2Tv6m0m8U7C4/XvDSvx6ug73003Rg++Ewq7OT+OScfQTERXwWl8QOPY?=
 =?us-ascii?Q?w55ks8pRALa9G+zyJNOofMyJtmZ3uYO7AFQB3UYsQ0a3iZNnbz/VlZYY7blK?=
 =?us-ascii?Q?w3zTPhqobBsv0auwxNlqj4ar65H+g922nWoAq/oX+5EZkR6+MYhPPZMZC/3G?=
 =?us-ascii?Q?CMEx7hnZDE09IPuGLiXBY/XPzDHD5Q5UkMlcfATUZlRx8yg2WcX09Xx3l3LD?=
 =?us-ascii?Q?9up6y5NPkcCq0umrjZRkAaP5NT7Ev4mrcd/QFdBUvzcIAPrHZbCrbgtjDnHL?=
 =?us-ascii?Q?H5LuzUP9a9xO2DvvdC4yQWhMcJci7C3g4h+qwtTOZQDOmKy8WutcTI9qO1tr?=
 =?us-ascii?Q?py6ghXFvwBixZWRaK4uHOmZMjvqJE4wHIJmLExer9ti7XKXAT5TURvMIVA/Y?=
 =?us-ascii?Q?JH/6LWDRCuY23z1qxy9HRz6X1mUlKIIHtv9P9GXB44gw4ras9OVbRiaCn4r7?=
 =?us-ascii?Q?askvHYnOWwDDuYzSsKQnvEyuqbnZtJ/RuWB4CBDT6WrjhY5IS1SKF71taN/u?=
 =?us-ascii?Q?Llo5cb//ZyV6E/HTvhsf9NQYNUImiXt44DiZ1+M24Zipie3XqzzvqBimLwoU?=
 =?us-ascii?Q?lp2GHSgmikHaIWGMCC4W/jMZr88hn273BjqjoQfYOqz5BiX9i/wOn1yFWHHt?=
 =?us-ascii?Q?5t0NT6z8+f0TAwmHR0OHEpb2RXvJmGLfWkSOnULxED9FOBYTeHcJUMdutN3J?=
 =?us-ascii?Q?AHpzKw+j1XqdklQ6/Yw9v4v6CrcVvTWbdYVr+Hfi5/C8W+89ahPPcAwa4LKg?=
 =?us-ascii?Q?6kEfjHWZMjclGQtC49iRtEDw9yCU8lkYvalfv+28UzhnqgIu+ulM6Ms89Z5i?=
 =?us-ascii?Q?WlyY1MyVr1OsSgvUnFSqJ1zj1hUs6QaCkXYkZjjZKC5JTzvxa1vcnuSS3Kd9?=
 =?us-ascii?Q?EbMHncKVRUiJF0406pdzfje7pOp77Kglyhr0Js8lY6NWXBL3xxpc763weJPq?=
 =?us-ascii?Q?KWut32mH2IUPY2lS9Bjoi5tM58VErIFDtyIrayuCB/5jHdks0dnARmTppcEN?=
 =?us-ascii?Q?UaRRv8p+dO/i9XkXVEUwMhY0DjQ59wpPn3hxMS900+FDdvvsd8djEpzGmwU6?=
 =?us-ascii?Q?qBztzH8Xoq+/gFWlu+FH3PCDjs4adlkAh90y+yjYn67JMCJX/D/nJasETW9s?=
 =?us-ascii?Q?4cFzv+J4GV1D7OdMmuwg6RUVH2TnV9d4z5EWcmW764S99W5e9/jNjZVLos4C?=
 =?us-ascii?Q?X2jtvffUUk8sb8AYmYHQG3V45ycpFunpl6tAjSinmVsHjmXY9NNyv60fSsS7?=
 =?us-ascii?Q?icrihUTTlMKbYU0qhVYtmgsretl65nYQB91vrU7EaZkjlpHzK5HLSP9hhSsl?=
 =?us-ascii?Q?7CeNxa9BFMiTAhq02u0w98UQNLrKvQLXntuci9MtyqLCzk4FrPFKbsHtUtN4?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tVr2VSzYJiWreRlIIEBD8pRRqxmVuDQl03O2ux1IbOt3kV4qXOoR0pYWPyXQ5lMBXiIdKSHSKsVhcljYfIDynf4WV/yIAlhnqjtHtwvi/7ezs4fBYij8xJrYz+towOxPwcIOBTNvrTfDzhZIjWCjVnsy/+c1McwrYXcvutbEVDNzoIJqftosDW6rIbdMXOsP7mYuZV8JSDkyhw2LNkxdOC7okwyI88cdnlejirx6jvblvrTbHClIVRTMaqQggnrQjFmLJS6d9yuOmcl3FrGNeMp3fUICSmLlxMCY0BtvqnCIxmw9OiDZIpLTKGBIdqOrdwA4nMB8DdcxuwmxME42fs73HSIHb8xbU8KRO1s/od2gsws1BNoWC7ba2C5ie9YpnJCshUcT1UAukmfoxXaCXd/Klw5dTNs/Vg/dXwjQYRtZLacmtkkfH4DUnEIL5ocsFq7RgZfycyA7h86/pIz9pqsQ/PUiZIhLH+ReTVr5VUYp48+Hy9ci8DaScLRmeH7mnkqCgd3h1JpeB6ckJbwB/AmfwOsksuwbxWks7dpmpT05B8c0LU60rfBepR9hj/i3d7HcVFmwgmvASYOCsI7gWo8w84km5ZsLt+Rq+0iZj98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccbcfea-81b1-4ced-911a-08dce4562c2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:14.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SJV1PjiwDt5+u+Hj8YNr9V8pxMGr0su+Ge3Z2VgHrWpuiDlvSVZtCwRGM9H1Y2kerhjz5nPawMLRa2p+i1+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040067
X-Proofpoint-GUID: PbYhVnXpSRFmwPUbEB5ODjexd6_dBxJw
X-Proofpoint-ORIG-GUID: PbYhVnXpSRFmwPUbEB5ODjexd6_dBxJw

Darrick and Hannes both thought it better that generic_atomic_write_valid()
should be passed a struct iocb, and not just the member of that struct
which is referenced; see [0] and [1].

I think that makes a more generic and clean API, so make that change.

[0] https://lore.kernel.org/linux-block/680ce641-729b-4150-b875-531a98657682@suse.de/
[1] https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

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


