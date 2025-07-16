Return-Path: <linux-fsdevel+bounces-55139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3AB073AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28FF1AA74EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C22F3658;
	Wed, 16 Jul 2025 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWUZxs8W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TPE82hiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23322BE647;
	Wed, 16 Jul 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662442; cv=fail; b=rDDcAxaeJQmZViHaKmQmjMwcOs1OKUuVfa8qBC4aSOTprrp5iBcDBd96kwLqKYC9n97WgZulWaedS4PqVzd9VoLoA06TGLpbPeWbrO2pcqaP57X4aaCK8cBx6FtjTds7z+H9K5zD+S/zsPYDS1uPFq7eDSMd8pDTFlFF/QYh5YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662442; c=relaxed/simple;
	bh=bmOoU1leFwHHeuU/Bn2zrau31QmWIbhbuTE4LG4Ti8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzvVSE1qYngbJuugVpyMsgPEBKaHlcTZfSWsoMw1xoKJbSMT2oEjponCByJP0u9Icc45UdhrlonRPxSvn/6nKqZl/LAChxxxfOZ9BvMBEDupvFgFTpGD0TFcJewy4XTllSu93VdZ4qEzMpxMUaUCXPFASeWsiPQTLZEzWZ8rNDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWUZxs8W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TPE82hiM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fpfX022959;
	Wed, 16 Jul 2025 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bmOoU1leFwHHeuU/Bn
	2zrau31QmWIbhbuTE4LG4Ti8Y=; b=eWUZxs8WssyH8MjIdD02GF+kx6gL3dS1G0
	+Q7IkYz/q66fPsZuH7K3zfK0MC1Dkt5ltxzEl95OBoDygjWo5Th41rfz83Kp+UGc
	RgT7GWhGQE8tp1G2LYJysSLLJlPtbnuEhyIUpCEV6Dy4XdBVPUlL6GfeYyr3vQwG
	/Q4PPEv5Wvp2dkrU1XuVSZc6l29Oy3avlV6+QdHGbXoqEvcwlZkDO0uPUrd0qLbL
	RfVEIkZmgca3hT31nW42tSJ+v4tMjh4fiXVY8n/yad6fERG/mG9saykcEFecxkyW
	/CFXtbvgye67/WCzy6EP3JcylISJr0wrdYwuEce7UuqNHwK3e54Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr10jnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:40:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GAWeJV011819;
	Wed, 16 Jul 2025 10:40:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b6khc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVGwUt8MSl4ALVGu8k9sAbiI91bq53blYUEoKVBSvn55ieedrW4/PlmsFDdhPWmpYGPDaOK89fIQbf1GbcV+S3ZBGAcOBs72npcne3zX8qccWUzpxqIZQ/MuZqd4T5KjJLKloeC3yhURz1pDEiN8cvK+Ux02UAe3xbryM09uTk/qL5+HdLGCaDD/qBBFSOYZ09By9d6YrVSHA+CKJWJkKARZdFehMDDmtSvAvll/PbKABPqTBaqEDyEG8LmMWjOHJuoErqEftq1WDpfqbta9bYRbSxeKDryoN9nbtm2CTmEd6f2/XZBOkAtbuvK6UAIswPHPTQ05aSsnYIaHu5fikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmOoU1leFwHHeuU/Bn2zrau31QmWIbhbuTE4LG4Ti8Y=;
 b=JW+TIhV8EPuT8886NYRlbXBKguOKpG7DySxqa1rmwvh1xhNzuStop/GeT4uVcQzJXeHRbU6LWc96syvjlWrZuFAwc90H7Vxv6UaQGNN6Q/KjYGU9YUUa79Gyi3/8xE0sKqq94BI1/WwsQtUwZtEd0W4KvyPSTn2brBiMDIKxuvNa0qUp6h+z9af9G648tbTELKg97NQ/QPtJTi6EdO2UeQUpPwtb2R0tiMr6wrdoTXcPTT9oEjGi3konkm9HUgagOj1r5L2nuwa+tusz+T8mlMhWrUnhldUFl1umU344hv4ZtZx3jMlNs/m6Udjo26bqz5tpDMl8/z5AwPdqVwSA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmOoU1leFwHHeuU/Bn2zrau31QmWIbhbuTE4LG4Ti8Y=;
 b=TPE82hiM1cVOB8Ehu0o12JcdKrqWLeIS/fMzelv1DNNac6hhZ4vuut7vVglIuzRoZ6j3jE5BFTuOOMo41zFrB/P/gVXrBFiX3sAJceO5oY6t3eH4z4CPnlbU52DwcAu8q0xqoedByhavgq4sXFVuhtWuurCkr7SlxcWguNOybP8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 10:40:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 10:40:03 +0000
Date: Wed, 16 Jul 2025 11:39:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, peterx@redhat.com,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
        brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
        linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
        andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 4/7] selftests/proc: test PROCMAP_QUERY ioctl while
 vma is concurrently modified
Message-ID: <5e33a9b8-b0d9-4a5d-9b2c-280e3e64a70c@lucifer.local>
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-5-surenb@google.com>
 <7e0ec5b5-0359-4f79-aa5e-e1273f824057@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0ec5b5-0359-4f79-aa5e-e1273f824057@redhat.com>
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2bd64b-f15c-457d-d5cd-08ddc4551f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6OzpxYdouzty/4mTm7uEKlh72SbPd2JttkneAK2qqWYbNYKqPN02NDUzMEua?=
 =?us-ascii?Q?4U+brKcb9s3DTULu3S8oGQ2EWlQ10+3d3+A3wlgwUrs19HzXK2FWo5H5XHKP?=
 =?us-ascii?Q?eC6tdCyOAftYBzaR1d5aZrrqd732jI5hg/159c+jXgxEqcA9bb5ndXXsaaAM?=
 =?us-ascii?Q?wjQqPSwUp4LVTVmaw/OO4vSL4fQ/yEZBO1IGoM8Xq7M4K1NF1CJqd6qcCjtG?=
 =?us-ascii?Q?umcUBXRKlsyPzhWJW0H3LTcALpQKg94hmfioBlA/bxSBoQjIqMY+iXIua8MN?=
 =?us-ascii?Q?Un2k/dW/UlURKQ510mgTSVnOsdU6x6YqJf3ZzwYRnJ3YEow9Dbm4XfEoYtKe?=
 =?us-ascii?Q?hetMQVvlwV8JB4SsuITiXyK6xCUt6V7pgMoK3Ld8zTN1il9oQtTRoJxYaCYs?=
 =?us-ascii?Q?X5igEfYk615FwVx50ObzP83qZcsCETwGW3SfuEWU0ItNbciPGFFN7/EtXb8u?=
 =?us-ascii?Q?1pPzaREz8VDK6aptlHMRs/MLhcUK9ZYaP4eHqmbJgxG5i39LFYib7RUhNfNI?=
 =?us-ascii?Q?MavZ/w/qcfkwZ7yO3HR+L7LcL8AcO3oyMy2nX2GjbPVdoXIQxJl7xLyGdb0y?=
 =?us-ascii?Q?aJtRjTDgVgg1ReuAS4AEZ/nPKeMJ0y8qoTKMpMw4yzRwwPSO7hCZBrXc3ydp?=
 =?us-ascii?Q?ioJZzWg5dqhnFsBn4xPL24OyIhccqAednrkW0FLeUsqNCTIfLmubqlGJNJoG?=
 =?us-ascii?Q?KSK3UzzoyTmeRlvR0OimFr6nEeZGbEcMX2QHDmOT9Hqqkz8gwu03qxt6vZO7?=
 =?us-ascii?Q?875uOc9x8SczEfmoFE5+drt/Al8tAA2geyIyUL0MNlp6W4sH6edlQhPLN9x3?=
 =?us-ascii?Q?9+Z8/j21P+9IH7fDKyuUKZbbwRdKHJADkLkNefw8eXF3AYtthi7rfjlAFbhv?=
 =?us-ascii?Q?rB5PhvX4NbcjonrrOAi0mK9f6g5AMlsXl1CnKxOSWL0IOlPzGe8gCU4P/90J?=
 =?us-ascii?Q?V8Gi9zUjlNYl5r9MWwBXQVM7qHceISXyoo/hSgFp7Tg7tMXOIapeiBffmG24?=
 =?us-ascii?Q?qhucqhGh7ynWrC9+Fkbv6el0lVZif7gmCUJrvSl2Hc2H2yAvkNGfTR6+l9Qr?=
 =?us-ascii?Q?ZZzlqRz9F6EkB+21x7c2u9lIL9LczTTP9yHZrSxzjUp8Ct4WPsaiFGw0Ktlp?=
 =?us-ascii?Q?oO48oeOs3TQ7h52+0VYDo6OQyCL4Mquv8xA6rcZiQ2WQ6NlL4jfYiDgIIKH7?=
 =?us-ascii?Q?tvXX/3LbIH5PKjqUZwMrVST8NXUYkRHcFg8lSFqTOPiG1Eh4Qw4JkXZk/kSd?=
 =?us-ascii?Q?8SqI16+tmpoUE6/gN1FE1LXJRy/5ERtFE+cxZ5yZVVOhB94DWLztCinXwv6I?=
 =?us-ascii?Q?lpMLLk8wBJcVSvaoCgJVI5tfOiv/2vnYCQyOMyMPI7MpxaijgSJ9Akzpczjb?=
 =?us-ascii?Q?tEYTuYaIEfs313dKJhn4XaXAgOYGSkyhDMsLW6msA1Z2/eq8ZBeZa4KCpvwM?=
 =?us-ascii?Q?9dzMR+Y1eCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDb5ymabKwl0eltPmuLGM6o3HmCdzOYTNE1ZZC3frScv0GKW8cz7EkzFON4l?=
 =?us-ascii?Q?ERrf76oz5vHTaO6I5iII9IDt4kvbIgXRLejO5JugTLndON7dg0/wFrx/x9iB?=
 =?us-ascii?Q?pFvPqDOIxBYolDVZ7ZfsZIQWD3+fE2ksK8Bh//QkDb4GC1aPh7tU7whcz9F8?=
 =?us-ascii?Q?Bs1MV0f2XlLU3wwsiPoSzIvdNWFLekn1U51DkM0RmV4VUZCPDNM07yr+gVZl?=
 =?us-ascii?Q?Ag8SbkLEAzSoUTBGjG6tKOlRr2xKh5udtiYJ0CaiXG5puqN88DjPIOXDeSRI?=
 =?us-ascii?Q?Duv8lL3+FSIfqIatOlRh/lYMVrmtYCp+x05MoL9UZQLfs/2aoU1oFnSIXf5o?=
 =?us-ascii?Q?n49IRiv6VlExFrDIbX+BFaTrC7i7xMW67XFGLK1dHRS9RP5bKd17xdV7w/wz?=
 =?us-ascii?Q?zBfvarlV8ZKmLW5WWII2uNwWL99VOAHcN8tFgvjx8Eym/Eg9oJARu0qCYd/9?=
 =?us-ascii?Q?JeU+w9BkKgTT0xiustciyNuCkqKbiFw5Mkq5Gej/wzxZfRgaDLNZ0nei9oo1?=
 =?us-ascii?Q?qUKhLIgAGzlEFa4Tc5RKNUeQEeM2xfZj3Wz1zWxU3nH02k15j64UYmQQbveX?=
 =?us-ascii?Q?htFbRjdCnn5LQmNStTyUa1PgtDVCd1cFDLXl0nmGT5jnT/L7M5IHPyYCzyib?=
 =?us-ascii?Q?iqrrrGJmtC89jldEbyWIgcGBHDVulRKpXO6j5oFGbghk4hHLi21LQvskztYu?=
 =?us-ascii?Q?BjXAUT6DbXWt07GCEsulUha3NAfyqllb70ugvstE6ZmvmJ182BQv2qC8e9L1?=
 =?us-ascii?Q?yR1bzURgQ6TnXgg0cbI9chYrf50uunPRwNZZ7sdSq/9NTQbWoGDSI84XIRpG?=
 =?us-ascii?Q?lCtJDB5+FJj69MtQrpltf044SN9P2VT4aMDd55vOMcGvzBqJIDWcXuZip3xg?=
 =?us-ascii?Q?gWS73vS4E/Wo8WX0ARx6etBmZjj1pDll8FLJQ1oWkPEnJb71nA5YVvAXWsOC?=
 =?us-ascii?Q?KJbrWhu2/mwLkiRKi6Q/NSXuiEsv0vukhTZr138D8Ps3sNjsRXVHOuUSep4U?=
 =?us-ascii?Q?i5MJ8kHhcMNg89XR7F1ZeGpwwnXmX1cxJQPBfa8qAK4Kiv02KuiL6kvecD5J?=
 =?us-ascii?Q?vSCdRvDq2+xBUrimw32XVrqagWaV4Ngz//ozLuHveqA8WsONaFLgTr+hD/D/?=
 =?us-ascii?Q?E4KImaMVtYTUqzzDj78yId1V3yv4C4ISOXHa65x+8xjq24nyLFFwJBjp9J70?=
 =?us-ascii?Q?3aM22yTb7W7bOest0t+akEMzWkBndspVaux8KPPkQqY+YWtKD8enJeoXVswp?=
 =?us-ascii?Q?MiWIR0gDIn6ZiCCqXF8+xW3Bs13I7NZYWc8UYR/14Khh5zI/0czVZuszgFKe?=
 =?us-ascii?Q?DXQKuhFlKY1BD4z2aMxKxYd8kybmTmoIP8SQjiCuCl/S3Ow60qagLGgJpgVp?=
 =?us-ascii?Q?vhdarQOAa3B5pfNfZasFC9KwWLZf99idIkOZTVylH+vqLBkrkRS7SYL709dk?=
 =?us-ascii?Q?20skyfqHi2vL7avPUht532epoeEyPl2LctJT6njRopiDbb5uHoxRfPncXsEJ?=
 =?us-ascii?Q?vgDP+B8Cdbo8JA8edL994nm/0VvuVo7luOSDbRXNfQRmP/oWsiYYg4rOKLJ7?=
 =?us-ascii?Q?aKuDsWC6Nm1E82FYQr5nxuSPNP4XkQiqszQ0RyQ5s52t04KXRkhrApc1Qiqq?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xYbJsVB+tZW7HhJy+GqG965TYaOUTW9Cdpk4Ksj686A5HuhT3NNp/a54QuHx4jwEN+P0Uc7LxHw9G3JIcWPxOCDhnntFEo6J8jDdY7dE/BuEh9/cgBQjaL5tWHcq14wbwdHko86sVPtfTrrZOPaASDdDXZ+evpejIGiD+fCU8bA05DbU0UQZtuq626xH29hPgEfhcsuMohnfnRXF5LggWAhB7pkfoLZO38mcbA+wrPrskclXnGwCRmhde/IJharCrmc5vpMIQ7I4D9jHDAjiqxKNboUKHKrKsy+D4pGB3ewmJQEEnOjol0kNGI++mCEXmlfbY5bsidzcqqvV8UYzsaN5Pf6q9P4rF/nqEs9wTcvBLLH/PMu8QDEBTBNYeIfl9xx26jl48pd1hj3AEsFENjzZUgeTQLB4KzDSyembOYPp2cRvqWV3aF99Vf2K6nDnYCdqfCDUY/Jzqpgdi52k6UuFaDk/Xrs+rdTKu/JnCFp1D7YeoVhA/GvCUmTinZtLsGyKsX7QC/U9GPcBGHxXrgSLaI2Awr0hACJ5n/Y1F4t6D/w+YjOEFfVsAhPhVYIyzd1UJGfSV4IcWRtxJHrbIOxDKCLIHgaBaSYr1ASVfJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2bd64b-f15c-457d-d5cd-08ddc4551f40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:40:03.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMCzb6P0ZCzSDwYWzx4r1WiVW1TeTguoJhvAdz69HagE439vWv5x90vJq+WkdokEQ++BeOa0oHmsKpDegAd2KEHTlAjIFv/LR0KBepIWaPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160095
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68778188 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=c7OmAL4WI4DzpTt1oxEA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: aL6sNempQdcunBTo2ymoWP3IhlqtzESq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5NSBTYWx0ZWRfX36LgBjqF2wEE fiUuoL3l2eoJ4BzQZ+KgbxANhToXzWvLsobbfU3e/7yI/inDR/wcyyLDvbuRwi/7U7rNAu++Ma5 ttAXgHxGBjcdAor2OmIPw0g/zeUOr8LwkJmCgZiGp3vbVjijhJZrgkko3kfRCfWEl6jXtWxZa3C
 +FOmm71Z0IzAmsT8PZn2PqrNRiqNvCeYO+iCksL2QfLINBSeI0645b2emjkzzEyVRnjmnJNS9tQ x+xEUzJ8hFsZloVl2Wf93c3XkM3TQrpSfP6afVLlXzIJfcUhjlfT8N2LVI6pNYncyoZPVT0auNL m/ZoSnscLnuidux2KHviikaLtTRoRlIrEP4OI6+fEpd7fNAlyG9N1ICTtVO2biyfwQoChNsV15s
 5CTVd9he874VzTSZSULP7gSrMQaFZtKLeJkg2hR72xVSqpzTl88qpZPRbcmPLjXA92CEkaIC
X-Proofpoint-GUID: aL6sNempQdcunBTo2ymoWP3IhlqtzESq

On Wed, Jul 16, 2025 at 12:04:25PM +0200, David Hildenbrand wrote:
> On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl operation
> > correctness while the vma is being concurrently modified.
> >
>
> Wonder if that should be moved out of this series as well. Of course, it
> doesn't hurt to have this test already in.

Yeah that's move this out actually, in this series it's not actually
testing anything _pertinent_.

Though all the tests are designed to pass _before_ as well as after
obviously, so (as David says) no harm to have it here BUT - it's confusing
and a bit weird :P

So yeah let's just move this test over to the respun procmap query series.

BTW Suren - slightly unrelated but - the syzbot report I did the analysis
on is super super reproducable, so if you want to play around with
different solutions, using that should make it some quick iterations.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

