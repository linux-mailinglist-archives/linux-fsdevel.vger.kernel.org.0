Return-Path: <linux-fsdevel+bounces-17393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71908ACFA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA41F2174A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5A152510;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKNx7Css";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bMnDHCBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46F1514F2;
	Mon, 22 Apr 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796858; cv=fail; b=frXahRyIPr2lCplR6et/H1+jtIxFMy0ovXSLVIgeAkOn+zzd6WeHNyiLo2L11CpMqXRUDpdgoY+zSJrvrIZSdMXx4M/upGtVzxCnzz4yvjp5vT6CCcWf/Cf3mT7czwjn5PT5AJ8Ogr9Pum3Fj7hd6qQN5OkpHoblZZrgU4Nz5+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796858; c=relaxed/simple;
	bh=eR5GF6zkNHtRoTGcBz4fQyZQGOXKmq0dO+a+s/0pQX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xv0ycLQCMELYb0ivEXbp80CCw/unumSJDkSKZLl2wpRmgmy6bXecL/Z/oL/5yCXDYBLKNcVLQk3w9coYpkBG7Ma5Md9J0b6kZnl1TxrBBinBE6B8H7nqNcN4Cto5Lf0h42wIV+8dPFyaA1ODfETmrOSqbvo8gOW/K/D+N3/TfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKNx7Css; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bMnDHCBI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDYCVD028754;
	Mon, 22 Apr 2024 14:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=2Xn5Oquli+l4IsJVekV6nhgZjHWFufS+Ek7zvaqQCU4=;
 b=JKNx7CssMorgnQUZmuCkJoAVMCuow0teeKlxedHi7FWKRFz/w2HWlaBG0VVsn3AFKVpq
 KrNP3+7rDRK5/V3n8kWWUqdizyJrUzdkCNP/97YUsKW2Wowo3J27LfM+flqxptfeAKMi
 IqW39rC6kSKzSEHD/OJJsZfVaBT1earVoKrBgKrzBRqJeiI+I+zBLvnV8osZHgvzV6cX
 mfJY8KhED26EcEB/Iw/H5lJBExy/VFCNG8Fux/lEFPa9WiKHkXkbqsX7SMsDIeD26fQS
 GIeS7SYr6doMlKLtcTgtUMI+IDaWZhvgAjokoB5dhjWMPX2dPSWu8U+JADpqUCsR6Vcr Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aujsyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ME3wk7034978;
	Mon, 22 Apr 2024 14:40:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455qv7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBOixMceyXTbiX3f3BVna0tDjF5ue0lShPvXs1t8SU18kqsgNNCHVcYm4Wp/RU6mOi6egJazwpFWau70mbVMPgIAM0mvwuxvrBC5ZJ8aoeOKjEpqztyd0PVEBg2j3AtmCcn4EeuKUTcVDOGHXgkXoDncugTrjTHT0vYyDQdQ/6cC/KaONtawUhsCTAWTXK542EwhV9GSmMFsdEBgXPu0Pn3qW5gqWgMenVwq6avcGv8/m+VjhnLOSCHLeqonig2sdBlvJKvl7mbYKVy65xs3SleoHLkHDNH0RRHxY64zf/cQgeMrWtuXuFthOGtDO5SX9GdBIrCmxoXQSpXnB3sV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xn5Oquli+l4IsJVekV6nhgZjHWFufS+Ek7zvaqQCU4=;
 b=RT9xW18nB9grxwzebzh2xDBML3meO1kv6hHwne13cLTzLjzmK3ILf6X2L5/d5i0B9QNuLn1okThyuLBqbRRRSyz7myhBwcUVahBLrBRx/Vb3wTw+OwCkHra8skpZGAS34SOSD/Untc7vkRofXB6TQE4ym4ePpA5QxxF+HVuigL4m4GQxUDKERY2ZhPASH2l2gBhsr2PW7C9oIGAUu7DKvmjSdglCLexG11oRLSOXk37tQ1KqmhiA6DnCIYQl/R0AOkk08qvrvLOM1o+0iGDUjHU/ueGGhpLCQncr0vyU1rDE3veaXq+auWD+pJXkxkTfJLzspc4hHloN2ZagW3CsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xn5Oquli+l4IsJVekV6nhgZjHWFufS+Ek7zvaqQCU4=;
 b=bMnDHCBIfpOslhj9Lx5LkS5gP6bncTIcFaw6MnXzUBTZ016scisP3bDfXovS9jjZw58MqmAefSOr2j+5LJ+VXXluFhnSRu+EeTgM1APTgOekO4qQ9QFRUEbG2R91/oyXS9im6FGi0VMsfzC3EWtpeQRxAPSO/8hC+nWCTDrKolw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 4/7] fs: Add initial buffered atomic write support info to statx
Date: Mon, 22 Apr 2024 14:39:20 +0000
Message-Id: <20240422143923.3927601-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: ee42feae-6dcc-4c83-28d1-08dc62da23f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XX0Gxw0SIgb9ELWkJjZyFkOImxruU9LeX65ziGK6XasRsUHirWMUsMhT3wzr?=
 =?us-ascii?Q?Occkw4ZawpIcYOnW0zELpZuTAwdyUC903rGXp9J5Jw7qBSiefGtrdcWAKD5m?=
 =?us-ascii?Q?Dn/rnBlO9GP3jf3T+YdaISl7BmfRLa8i5ulWYh8khggg21eqrjE3V29UYROI?=
 =?us-ascii?Q?rQq4HmJMyX+HGYafE7Vr9YzBujA5jzhOwrUJ2timuvRJhN3T47SS8yQfUsMY?=
 =?us-ascii?Q?jk0OEx5M7Vl7vPH3GJol4YlFzZbJqstxW0XbL81g1t8O3a0iMxcyFsxqHhvQ?=
 =?us-ascii?Q?HHpeZjFgDlV9xAhObV8SEnkkSkTE0tPBt7A+TNY1gIpr9VBYUO3wmR88uHJr?=
 =?us-ascii?Q?3o0O8YvBBw06UAhXm3dTx5ui/Hi5oPIceqIGg6ksvOtVWIvNAb7nsQRyMVxl?=
 =?us-ascii?Q?DybZ/osl8/h9OK4EakQyqOsioAPTnvI5Pv2jB8HlZuIETxWyywrG2J9BKNT6?=
 =?us-ascii?Q?igkO52flBkYs4l5uTyvWsO1wMRYQYUBbWlo12KehbQC6somr2vO0/IV9J3Lu?=
 =?us-ascii?Q?woSp7+3XqCpfZMG6Oe8wvHu2dhAGfzn6T11UI30OYnAjNt3jHOKdLMFJPsVA?=
 =?us-ascii?Q?7axJ+6Ju4swDwv7lCGpauTEH4ILtYMXJvJhWGR8q7L+X5Z1+0G+kR4iwPM2E?=
 =?us-ascii?Q?EbeQFROrjJyr1RkendjaxCtlry9u6wRhd4sNHddtuafuUW6UQljhz2OCTfIA?=
 =?us-ascii?Q?XOU8hqUncbmHrRaHk2o0r6KOppRErWB6c4ZM5Dpum8/sWwoY1vvBmCYHrTCH?=
 =?us-ascii?Q?O/8AVWQH55X7GrzpPmeOZwq5m+wrsH/prSVXElnOOA0JZiFK/VGxmCNtj2Uv?=
 =?us-ascii?Q?9kG63g2m0RxEyVL3ZC4nVPyPJUarQYvBazPAM5pHg4hu8EKdZ2gTSYPI6K1Q?=
 =?us-ascii?Q?8zjy7gdTvDngRY4Zifpb/PG/wIvHj9maNWVrSB+nmpQf5WNBorzfzRGAcb1k?=
 =?us-ascii?Q?PPKx80KfqNmPTokfmd6+oTjuCtiyyrfZKVQQz/XhNeV9/WU9HMjT7aeaNn8h?=
 =?us-ascii?Q?I5xDkRQSIs7Q6D8fw6vrpADLrO33U2VDWVc4bu0Lq5j/wtwnc/W2Q17kdMsS?=
 =?us-ascii?Q?x9MQsdPyCLOEebGbI7kNNJXtjnnx+TlW0khHaSVyet87IcINyOFnVD5kY6LS?=
 =?us-ascii?Q?PXIhfXhHrJUngKki7zNQALVfRR3aFWfGIVGQii1AhfA8wA3KYQI8DKBRpbZv?=
 =?us-ascii?Q?Mjqywogg+hTgM34WAGipZ0wzur0oP7WkXzpu8WGYRyDCDfqDjEi0Kv/2KMgj?=
 =?us-ascii?Q?ITJb7Ef99563CVRIFF2e6JsH6aaQtV2KVvYMe4B4NF9dC8CJUDcG7hBKgYUg?=
 =?us-ascii?Q?ysW4OrilEwZ42386eZALeE+m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Iwe/tex1X1AwjdbSJTrRiEM/DNDLbRX4K7C3r69/SIQFmfz4dwCWfABpyZ8A?=
 =?us-ascii?Q?/dKKzdbm/njAS98l3RLSIsbBhGvLBKzzmWvLND6W1dpqDzgh3GN+9zzTZzFF?=
 =?us-ascii?Q?lFyr5DNxbcKuMteqP4Unvvq/HOucaV3OWzaNxe7RXmWtegTDKMcRCqMAtVtr?=
 =?us-ascii?Q?yMLWf52GK6R7LmtxqEaBW4ashTM3EPQwA8VZSJ3a3zVq0FM4Y2FYaumHZhIv?=
 =?us-ascii?Q?Y0YhSuOpbTPq7Rat6oak51mAVqClXV5tURnHdOACDSvLrUx8J25a9MC3neTp?=
 =?us-ascii?Q?7ODIA8Ix94qx9SyWdIk91Dd3M4BcFjG2Hj5KW+0UoDn4/+PTm2HFXoJpRhMu?=
 =?us-ascii?Q?qeDPa29ESrBrakKknt4y9XWESxhgSPkWhoIAA4zvf48qaZM9TinzftZJHVpl?=
 =?us-ascii?Q?dNoZrObPG50tNt/3+MyDfHYtegSnN9MjLemyF3NiJkea4fUWs/jqe31pVJ8W?=
 =?us-ascii?Q?7BLhWND+ikJU/rK2Zqx3AGsEm0W8MbeRIQAfrHPSTeWXNsQLb0aMOECYzZjD?=
 =?us-ascii?Q?mNG6MvpMNWfKTTvGX2N/ieNnenmLGmsIJbQtm63mrahXxpJ9E2pPcwHZ2d/V?=
 =?us-ascii?Q?A2noaxtS3CzVlpoEHKZ38QVCwigRrpxPnX8VKabiB5Zm8CmPiRAplRx3U/IP?=
 =?us-ascii?Q?CZsZZ6HGhGqUeI0gtQxfLJHCRWRRAcBKVQFN5of1lOzZbQpt3JLZRc81iWZz?=
 =?us-ascii?Q?LuM906v8VLlYT3sKGYeguGgIpigXJ0K4BJTlYxYqshWCykWjpTCzR6Z2FaIp?=
 =?us-ascii?Q?+8FFiEhIjRQyS2ESfoPJnWEB0xpWZJo6EjiNQbN2KSO093vP20EseMf4cvYJ?=
 =?us-ascii?Q?ymdJCPMg7tflvJLrDPtsFftV75ukkmTQmumVN0T/3nkWz0gsjKpWazRuv5Fm?=
 =?us-ascii?Q?HGQDQDV8JWvedas28zj6Q52QSZD/JL6Aq1KCqIEzfIQTYvW0vMi07DhpB5J+?=
 =?us-ascii?Q?WmSTvE7pw+OdC6l/54pOzwjvcsrl+Y6hZNFRWvo9GxellOtFGYKJNxIRjdlZ?=
 =?us-ascii?Q?9iQuOHFg9VyEUiRbYUnfC9x3dQKZqvNyo+JUda9fER44Gqg7LwKGd6NKtnT1?=
 =?us-ascii?Q?hsZms8oH3Brb2bzaAYDI9aeeX1IO6RXm2eQYE4XOeKSHBvOEdadOeePJpEdV?=
 =?us-ascii?Q?NgVlnvva0exwAx0bS7ixfbLXQTCdh70AsP+OMZheiRNDKZT1HQH15iY0Dwjv?=
 =?us-ascii?Q?S0ADUX6YSB/kk6LUil7fyDo/ffq3pU7dOqFvBPVJOOPGIbpwUsBHXwOhW/aU?=
 =?us-ascii?Q?LWz7OvblLJr3HIJMDXBAZyYumP8Gdgu/n49KGo5+suSXnawJKVrlVgbjUfIF?=
 =?us-ascii?Q?puVcQkEsryzLdBgjqPogHs1v3JLbNk3myHegVTudoMaVczamp5SYWV2THJXZ?=
 =?us-ascii?Q?yCGQf5UyBRijVsWeyXoRYGJm+t5cFphDKZbxlwdqoLGCQpLJTsuejoAK9/qx?=
 =?us-ascii?Q?8MLRDxkVm+y455074CQ5G8ltXklI51MrniOD8F3aLW/avlGOcxJ7CcOEFAZw?=
 =?us-ascii?Q?Yd3o16cMWg1Tb5lM6uIk/u59VyqViTb7r0cydX/RpqCwyKze/RJ42yR+FVkU?=
 =?us-ascii?Q?tEoZ5Zly6pv+37Bf+M6XwMCjw59Kk3N4V8oIowjLUmmqBg9VWEX41I1/9pky?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	puhXGsFzldkJHKqXdSsn35ncaI4A7IaTjc4fsGo1K1kTyi29SNY86EWE1WwXCkm3fDIJwSuRwvpqZH1yG8sCYFS6ab8vCfpCNw6p9EU7V5B30rD36h/rnZ5PhSgF65d6lQl0rPWwcmuLOIf06oP10RVYosHS1mglKkFa+Alrcw15mKQcwXh2jmbMjYi+iI/hCu0t84I3H0B08iW7k2J5oHInFZCo69GSCXgFIfL39s/kOJo+rgf1hiQSmNqRQ1NutZxF8eQ+74Qz9MXuL8YAp85LAG+HQMmRKMJ6NWaZmq6HF4GLqvl8oHVQkJ08q7Xdgm1IJ8Ura4GZS4gFDzgzWjZEcQsG22ykAQbYEhJUQkBtaDWeleLDqvYvSfw/s4ss+9YWeHX9SK8HJK2vNIpIl3QgaHc6LxUFgMZBXjTIrYc1siNEw0HQYHXSJUN2NCETeUmesYI8U+NzQ+nDOnd8zOIbZxHWDBb983fxu5etyvikiF1cetcEtW8WbgzfHsB+F+c1+3yRgvBtxN6DJquhvZ5XhoEWmth/PkGhD5OE6Aoo/nkGyuoCoKA45HkGV27kA6+kiF5HskeREnbWCZGvfoLCwoDr74KqSjSEy1v6xSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42feae-6dcc-4c83-28d1-08dc62da23f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:22.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD5oj7108LaVvLvDXF0i2efhkFZYYaN4I6ZHW/RhsAzhaeOAjfA2qnQgZgVSz1dntUnL7ybXbcKpsytZSxpsIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: _02o-5q_qYeMjcHU_hlFTTylJf5Tk_QH
X-Proofpoint-GUID: _02o-5q_qYeMjcHU_hlFTTylJf5Tk_QH

Extend statx system call to return additional info for buffered atomic
write support for a file. Currently only direct IO is supported.

New flags STATX_WRITE_ATOMIC_BUF and STATX_ATTR_WRITE_ATOMIC_BUF are for
indicating whether the file knows and supports buffered atomic writes.

Structure statx members stx_atomic_write_unit_{min, max, segments_max} will
be reused for bufferd atomic writes. Flags STATX_WRITE_ATOMIC_DIO and
STATX_WRITE_ATOMIC_BUF are mutually exclusive. With both flags set, neither
fields in statx.result_mask will be set.

For buffered atomic writes, stx_atomic_write_unit_{min, max} must hold the
same value.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              |  3 ++-
 fs/stat.c                 | 26 ++++++++++++++++++--------
 fs/xfs/xfs_iops.c         |  2 +-
 include/linux/fs.h        |  3 ++-
 include/uapi/linux/stat.h |  2 ++
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e2a9951bd2e9..b80c78aed9f6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1213,7 +1213,8 @@ void bdev_statx(struct inode *backing_inode, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			true);
 	}
 
 	blkdev_put_no_open(bdev);
diff --git a/fs/stat.c b/fs/stat.c
index 0c0c4c22c563..cb8283534616 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -94,19 +94,26 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @dio:	Whether filling in the fields for direct-IO
  *
- * Fill in the STATX{_ATTR}_WRITE_ATOMIC_DIO flags in the kstat structure
- * from atomic write unit_min and unit_max values.
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC_{DIO, BUF} flags in the kstat
+ * structure from atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      bool dio)
 {
 	/* Confirm that the request type is known */
-	stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
-
-	/* Confirm that the file attribute type is known */
-	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
+	if (dio) {
+		/* Confirm that the request type is known */
+		stat->result_mask |= STATX_WRITE_ATOMIC_DIO;
+		/* Confirm that the file attribute type is known */
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_DIO;
+	} else {
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC_BUF;
+		stat->result_mask |= STATX_WRITE_ATOMIC_BUF;
+	}
 
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
@@ -115,7 +122,10 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 		stat->atomic_write_segments_max = 1;
 
 		/* Confirm atomic writes are actually supported */
-		stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
+		if (dio)
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC_DIO;
+		else
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC_BUF;
 	}
 }
 EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 37076176db67..05b20c88ff77 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -655,7 +655,7 @@ xfs_vn_getattr(
 
 			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 			generic_fill_statx_atomic_writes(stat,
-				unit_min, unit_max);
+				unit_min, unit_max, true);
 		}
 		fallthrough;
 	default:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 08a0b9a4da93..1147d031d5bd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3243,7 +3243,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      bool dio);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 05f9720d4030..9eef921b3942 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -161,6 +161,7 @@ struct statx {
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_WRITE_ATOMIC_DIO	0x00008000U	/* Want/got atomic_write_* fields for dio */
+#define STATX_WRITE_ATOMIC_BUF	0x00010000U	/* Want/got atomic_write_* fields for non-dio */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -197,6 +198,7 @@ struct statx {
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
 #define STATX_ATTR_WRITE_ATOMIC_DIO	0x00400000 /* File supports atomic write dio operations */
+#define STATX_ATTR_WRITE_ATOMIC_BUF	0x00800000 /* File supports atomic write non-dio operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1


