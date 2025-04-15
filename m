Return-Path: <linux-fsdevel+bounces-46474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF743A89D8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579C6189F3E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8694296D2F;
	Tue, 15 Apr 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ppw1/77F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nG4HuOls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18528E3F;
	Tue, 15 Apr 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719424; cv=fail; b=gTqyDhHyn8W0nS+FYO+4WNIPCdDHp3FTf6tJ6ZxBkAEqyVyxsbri3QtJn8Gf2r2ts30Rm0X8UuF7Ur+vGJrtCtoqq1IDmogKT4yI+ljRUXNIMKYmJ+VT/GcV9c56Piywacn8MFtPxPRV24obtlVAa/yp42un3HAhObi623hLm9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719424; c=relaxed/simple;
	bh=aBbCgTE+0p+dUqM5/IOXqx+WKdyzVIPaWCYBrY++5Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtBEr0KitFPwtfP88T7VsWFFtH+N7kaE84F1Xphus4NgEHgTnA1LZXQMAszsywHGDqi/QNyf1DJqJ/etFB+ZsihTI239ELB7D25jvzJT4x42Z6sslIVCwcWOPw6AJlfIyCMdbC+4MFC0P8n98MOwx1jlbdCyJo8PwrNS5W8eCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ppw1/77F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nG4HuOls; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6gRc9006222;
	Tue, 15 Apr 2025 12:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=; b=
	Ppw1/77Fugrms8yBpsswBVGCXOxfnQhrZEocN8zSJnC81yyEX38ItCz9dE5mbDvt
	EJTSbW3KqHAj2fLa60ewBzsUI1UgJSn8qRq0UutHmcLdTknIgyp6gTIGiiWXlBh4
	o+RoFlwMdaVwPYJiaUOHmsmkOYfa1Z/wXjwOO3hPc/HgA4JSL81UOjwuZJFkVNqS
	RzNCXc0tiKCDla0DWYwi8wA7yqonebevPbs9ndg/BngQKtxwR/0RUzzf3o8VXaz6
	v47VQdDtEvI0+xzTkLtL07r/EXSXRnw3SMBAaecA0K2wiXnNvQr++6EbzQzArKoI
	e39Osl0GTTcSITngmTLrOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180w9j48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FB6Hqa038842;
	Tue, 15 Apr 2025 12:14:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8xjf4JwZNLj7JeVWjC+NYC290snMDgdd0Dg5b1Dfw1pg4Ojz/PM37Eo8NHDIc7sKf2w47Pp0onGDC6BxGgyX2i2pLutXL4DssYyX57d8aDD/d9LybOiKObhMoxs0w3ABWKvZ2YBWDHj93SAc1MYz3leGbsE0GC/9ctRaPrdnwe9iEHkiBsGqGNIBv5ADrb1ZzTNSbuiryetQbCEMoSSp7WrgfIdqXecGmJZ+JKHZZOXOlb/nyhtuFf9NyOv0sGoaw78NPE7dRpW1vNKNCRkXbcM+fX3ke66k5I6Zys9yiD/mj8PL4y2pSmtsZm1qQXvhlyL57NA5E0g2oTsUYrSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=csPi6F5w9rYigdY3vltRWVQY99F7OHByblk/xQ5TXFQ8p/5JT1q6nQU/5METmZNE/HXiO2JnikV4mCGo5UPZzMTBGLZOW8gxvI0xkXxjxRzT4E2rUq4KU1DPyzxjp0qyKxN6pRZRg7HxqRwbLsP0UQLScx2U9oevmOTGgopcRhPFL/7KzbZeVaUvbOJE6gCARlfamb1oXxvniiMODiyJd0QVSWYjKAqxZdthv//9jWyEyowQawDkWpaU0UT60gOrVMD92DVY+VS6bVH/zAN0AxzyQqyoJbSomMvYTnmR5cUTnjnDLyPsBl0t3V9zc9Df4q64sCnN6Uhp2GFfTr9tNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=nG4HuOls+R2wsAreaBuuWi/ra+kpLdMwxvgcsWrnAp8SjtBYxM3UA2CJ5iNT9ua2MnYW939VsOmIBNOZsCUDXzGYBet3qogBRu2Mg1BX4K7l87X9RxVOnAhiJI49QKGKsIyjGe7SB+/qkOrSR/gnfjCqtVpmcT3SsaW1CT1BjXQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:43 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 03/14] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Tue, 15 Apr 2025 12:14:14 +0000
Message-Id: <20250415121425.4146847-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 415c68b9-655a-4d29-b600-08dd7c171b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTxoBW/jcRcY3ERD5he7eToIR6QJYPDxoQSYUanlaDnYX/0E0FwxY+rH/+vg?=
 =?us-ascii?Q?zMSZmJ+hqGbZzkbOhu3NtZWXMlfYQYrELX760c9Jq/yBd9JOAaJ+/Fvoc8DO?=
 =?us-ascii?Q?CnEMr2LYherMc6WIfdvt1HUUnsAL45qs47NlolNEu6Jfy2Dg/FzH2/CfXn5B?=
 =?us-ascii?Q?qMG9IRVsItxZP9YlhfhIj1i5YkY6nwxFUF07WqPUdw9hZQU088dm04lvz3kX?=
 =?us-ascii?Q?Kjoh12+rdQkCxsN5Fh//X1sN+NO7Nc9pCdfrB/ZWF28dAmOgz9eWHhswPuiB?=
 =?us-ascii?Q?ZSDYxcjA1PNPWdfMB0PUCbXom3ZLwJQVmJDwJ2Zp8/LQqUrSZrDpzPk9ok5u?=
 =?us-ascii?Q?0To8d4RMLiZodw6jwzJNMafAmx2qpeVM69oW0oFkxLL7Cz3hHwGP9uwT44SJ?=
 =?us-ascii?Q?EA+6O190mP6t3Q6Zi269mQwhGHj177emxhJ4IA+KwWRTHQ9slcDiKgc4c9q4?=
 =?us-ascii?Q?y6zLaHSmb3qXGj4vgmmsIrQwET8eVUCT4TwRD5UbmHOwCJsVb23eF4c4vPKu?=
 =?us-ascii?Q?gicpSm/ibUvqA+X6EificRD/LzfL1Q+S4r4TuH1ua38V5C+sYW7SPXpBHOw6?=
 =?us-ascii?Q?E2TVYGpzQxFtD2ePjf5h34HOTx6HJshvki61M3gdCtx84jvZYUFmjNFKOIr+?=
 =?us-ascii?Q?mR47XjKdwx+otmXms6x0+q5+iVm3OM0FeLQjptOb4wktOVCyVtruNUIkMi/R?=
 =?us-ascii?Q?l3Mv/2yc+WCU8DVAd+yi4e/qRRDN7Y8ptTctynd4ZsrDRFSHAqk5Pqs3klCX?=
 =?us-ascii?Q?DH+D3sbj/AU9Jkvgxq7dzNcVbBmWJF1dd+XUBK1A1m1ducPrmburA+s1mMkR?=
 =?us-ascii?Q?Yp/4mPZy08z56hkiN6gbycg/wLrvHWoHhFYKCuviDJv+RIMKK/iExXSQVRN3?=
 =?us-ascii?Q?aJ3GNeykosA9qWJdMJaoOvpXZCKjkWzS4ZJZJIaaeUeRGxn84aMNES7enDW1?=
 =?us-ascii?Q?YaLSol52GabgewUki7yyrU0d8wh7zbFIxFq7bvXjxuVyrY1jCuvrrdBmIZqQ?=
 =?us-ascii?Q?nBG64/fvh3l2c5+XtEKaTDEQAabT2dreM1SoUvaWFC7fKzv95Njhr/fR7V53?=
 =?us-ascii?Q?Hd0xCnfHudds8eaG78rw4mPCQIf0AHJCDU1dC6249B0C2w1ldj0xyoLkv8nN?=
 =?us-ascii?Q?5fswSd0n4S4pxjnkpks0bXQkTB2kDcjfvmEJ13pL12e/BU3ZRddOZX/I0ml+?=
 =?us-ascii?Q?rnQ2oQksAGh09Agfojy9/TO5rx9hQOGeYlon4grt8zNvnpG8mUQ5JTdC4Q/C?=
 =?us-ascii?Q?bJ/GtStO4e6Bvf4+ryPjdHGqx9LI8uRUMk9r3/vzrg4d/Bhcjgk8RNig5Q6B?=
 =?us-ascii?Q?qDYFQ/cnfVFUHlwhqv/XRpviomcLAGIju1umVbxK51mOd1IIQ/QpT/l+Gbte?=
 =?us-ascii?Q?yFPoCS+ona3KaB942dmJdLMmteVUagNZW/GE0Y4Wr5+zY3u0tJgp2Or3kZ22?=
 =?us-ascii?Q?Z9F4KubJQAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIMCpu0rqCccbocpwugl3RCe1TRi/P1UL4k4mUPOdwpshguLcnql4ck0sP4Z?=
 =?us-ascii?Q?fUmAPvsBxCUCH3fGt7NtfGN94QVrwVUR+9qmJYe2DcaNFItzrfcg+mgYrW03?=
 =?us-ascii?Q?CRM2rjTkCf+avo7VNvsr9OeaLDHg3Rk2Tg5+88Oo4xmmqUVvX7wF8sTmxieg?=
 =?us-ascii?Q?qF6jWx7SAYok6dvPA8XgJitmZIAFyvCgAOcaICaMvMTOZPS6dfINwkJ5N2ny?=
 =?us-ascii?Q?jkbEP2E8PPMSA5eFI60DNHYzqbrY+LfloeVBNW4NIxEKIoFM63pDx6GkBzGD?=
 =?us-ascii?Q?WgimiExsfwMfKP8rCsuWoXSSQu18lBduPz7v3c1eH/T8ZCokES9IMG8KVfAP?=
 =?us-ascii?Q?Z50r5phL+l8NPGYRIsQg2N4CWtUu4YrzxZrIIcFn5l4lwMuert4xi91IRkJd?=
 =?us-ascii?Q?/ILFpsrhWcm31hkpkzGwMdgRaSzkzQHcrpHwJ1aI1D0oequE9uBqu5GLVOKq?=
 =?us-ascii?Q?hACxHBzTWpAHUPJequYVFPMo3oybUeOimPKXMRDRAAk5l8MbcDzYpBjwSTMU?=
 =?us-ascii?Q?ejFrc9+UcdhPirM7Z59yUrQDQUGS7+Kek/Q+uwphwdrAXLmVZmCpWQ+gVTYZ?=
 =?us-ascii?Q?YwvTZ1/HtJ37lnjYSVq4FtkZq0XP4TPOWvKup1aXi8FBZhXszKIwD/oamHCC?=
 =?us-ascii?Q?j8NlJZh5UHKnTX3gYC6zI+hxRI4aiZpTM/1jPvvN057bUDGmF4MfFw5D9H29?=
 =?us-ascii?Q?q+YOQrxwOOMMXvF+vPrWF32bidWBN70XdPNL4fW66zyjmp2Y9RwvB7ObMnpt?=
 =?us-ascii?Q?2et/ySaDuS+rFJma6UARD7/isiDJvYNxVqzuyM3E6WpwOkzzGdpbJcoFayW8?=
 =?us-ascii?Q?htfzWOsmdulK2n7Vgj+IMxFId09s1G80Q8cRheHgZtdDuXiTrpJNqmL8ZlEr?=
 =?us-ascii?Q?UK2PDAcKcBTCSA+Rp32bn3cRW+LKth0LmwhmedzB4vw9K5W0034qBxC/hvst?=
 =?us-ascii?Q?XTBbDbAFP1czGnfFOST8ToDW4cw5Ee8Lcju6hyp9UJIKFZRkLu2ishIujSWU?=
 =?us-ascii?Q?Gerx9PHOPFk2tNQJBJLH6dMHS01WvOPxHV3/80L3NlZ+gCi1AreZdZXY9Lsa?=
 =?us-ascii?Q?1xWI5R9beg1F08IEd9d0VN+UwWMO1RZuUcqCIvYsrD+jqajfyuBup8QKVbL/?=
 =?us-ascii?Q?iHCkAsgVTmo9g4pSfn2XFecOkB5hqoMPTMBMShF2QuiYUMr0+f+gOJBJ63UD?=
 =?us-ascii?Q?QGP0p2ysS/oGUK7X+eCLCZBjVQI2xM7RR5KPA+c2ck6kmpLDz+8cNQ6WCUlb?=
 =?us-ascii?Q?CMRkc1Jy3kOs67eAyEktCLjJ6JR8g69jh+nAHB+pAqI8NuVUUweWd1eClHkp?=
 =?us-ascii?Q?vnGHaNu0HAGzGyg8KfLvMEFs9os+TniMwBhVYX7RurncYAI9MWJKGBdzMpzb?=
 =?us-ascii?Q?XR8vIqxi1o68O5hwlK67MDtgFSQhdE5awLfAwFdx4Hbi4W7JtDaKcOW39Ovu?=
 =?us-ascii?Q?z26dGfYfqlNsmVGdfELJ3JehiNHGFbsN4Suu4LBuZyOK1GB93E4CwWxA6YFa?=
 =?us-ascii?Q?UMOkAG4QEqX8ztCrLCKmKQBPGxghJQl2e5szVfNvjRcGpJMWwbqD1WAhLYsg?=
 =?us-ascii?Q?1KQfAVWQXx5DgIVPu8jUJniCPHfRuJG0TNO2pjDI2d2w9P/jKvjDbz8AG0tN?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FfRPLFITiCvwP7RxrIgUuVBGLGDYKYhSIiQVammNYN5nRrMbi7f1anzT1FJQosNrq9Ygoxsp7ghr3ywydedB6KFAvRw+oIZWPGmRP09pAkybk26PMYlU81blIrrqjzLZOdytqF7AVMwvf8fIjw8BUOpdFoHXZfXjFEC04/Cy5wszF5v9ecPwE5BGAMKWy5f7wGO48r8kWar9786E/ScgpzDNKwYZMiYQZh4SXhzaaOrQv9ICqkbebSXRIwSRdeaA6/KIzEHguC/2R8pUUQE6ION1ubcStD/Lxc09YCZmWbiatosaB2c9OflgWKosJMbDxZ7lflzAfC1vADZTy1PPY5aARP6RBSHlIKpPPjRdinb4ZFN6a2trbYH1/D6tZzq4So9/VApFanVmBf2FCsL5u8E4urWr7ctlnsK54RTlV4b3y1Gcnitrnot1BTQ9gBBDY8H7zrHbMrYcpuCJnRXhJ2zTD/LzYBGRGujnDdcEDcqPA11NdW4D9/whtQZkstFnBSa7TahG+K3kQmJQG1D6GmX0QNwaSjvk673tdqf9j0j36+MNb7GzYtyDTQj413jaTGOQ1hN4126kjS+WZ3c3Zzzv1Qjtjc921Cc6Av5jpbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c68b9-655a-4d29-b600-08dd7c171b23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:43.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHNz+T6G26KwXy4cD96bEk5ZmEvLQP8QiIUKxJyQGbycAjPco72wIx3jAOrCtSlPMfRyzCyD2zHuZ/iDQMiamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: T1bgrOwxnZDGz5yIEpxxd4EWJROTh1bH
X-Proofpoint-GUID: T1bgrOwxnZDGz5yIEpxxd4EWJROTh1bH

From: "Darrick J. Wong" <djwong@kernel.org>

In the transaction reservation code, hoist the logic that computes the
reservation needed to finish one log intent item into separate helper
functions.  These will be used in subsequent patches to estimate the
number of blocks that an online repair can commit to reaping in the same
transaction as the change committing the new data structure.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 165 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_trans_resv.h |  18 ++++
 2 files changed, 152 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..580d00ae2857 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -263,6 +263,42 @@ xfs_rtalloc_block_count(
  * register overflow from temporaries in the calculations.
  */
 
+/*
+ * Finishing a data device refcount updates (t1):
+ *    the agfs of the ags containing the blocks: nr_ops * sector size
+ *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Realtime refcount updates (t2);
+ *    the rt refcount inode
+ *    the rtrefcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_rtreflink(mp))
+		return 0;
+
+	return xfs_calc_inode_res(mp, 1) +
+	       xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
+				     mp->m_sb.sb_blocksize);
+}
+
 /*
  * Compute the log reservation required to handle the refcount update
  * transaction.  Refcount updates are always done via deferred log items.
@@ -280,19 +316,10 @@ xfs_calc_refcountbt_reservation(
 	struct xfs_mount	*mp,
 	unsigned int		nr_ops)
 {
-	unsigned int		blksz = XFS_FSB_TO_B(mp, 1);
-	unsigned int		t1, t2 = 0;
+	unsigned int		t1, t2;
 
-	if (!xfs_has_reflink(mp))
-		return 0;
-
-	t1 = xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops), blksz);
-
-	if (xfs_has_realtime(mp))
-		t2 = xfs_calc_inode_res(mp, 1) +
-		     xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
-				     blksz);
+	t1 = xfs_calc_finish_cui_reservation(mp, nr_ops);
+	t2 = xfs_calc_finish_rt_cui_reservation(mp, nr_ops);
 
 	return max(t1, t2);
 }
@@ -379,6 +406,96 @@ xfs_calc_write_reservation_minlogsize(
 	return xfs_calc_write_reservation(mp, true);
 }
 
+/*
+ * Finishing an EFI can free the blocks and bmap blocks (t2):
+ *    the agf for each of the ags: nr * sector size
+ *    the agfl for each of the ags: nr * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    worst case split in allocation btrees per extent assuming nr extents:
+ *		nr exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Or, if it's a realtime file (t3):
+ *    the agf for each of the ags: 2 * sector size
+ *    the agfl for each of the ags: 2 * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    the realtime bitmap:
+ *		2 exts * ((XFS_BMBT_MAX_EXTLEN / rtextsize) / NBBY) bytes
+ *    the realtime summary: 2 exts * 1 block
+ *    worst case split in allocation btrees per extent assuming 2 extents:
+ *		2 exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_realtime(mp))
+		return 0;
+
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_rtalloc_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	return xfs_calc_finish_efi_reservation(mp, nr);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rt_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rtrmapbt(mp))
+		return 0;
+	return xfs_calc_finish_rt_efi_reservation(mp, nr);
+}
+
+/*
+ * In finishing a BUI, we can modify:
+ *    the inode being truncated: inode size
+ *    dquots
+ *    the inode's bmap btree: (max depth + 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_bui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
+	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
+			       mp->m_sb.sb_blocksize);
+}
+
 /*
  * In truncating a file we free up to two extents at once.  We can modify (t1):
  *    the inode being truncated: inode size
@@ -411,16 +528,8 @@ xfs_calc_itruncate_reservation(
 	t1 = xfs_calc_inode_res(mp, 1) +
 	     xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1, blksz);
 
-	t2 = xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 4), blksz);
-
-	if (xfs_has_realtime(mp)) {
-		t3 = xfs_calc_buf_res(5, mp->m_sb.sb_sectsize) +
-		     xfs_calc_buf_res(xfs_rtalloc_block_count(mp, 2), blksz) +
-		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2), blksz);
-	} else {
-		t3 = 0;
-	}
+	t2 = xfs_calc_finish_efi_reservation(mp, 4);
+	t3 = xfs_calc_finish_rt_efi_reservation(mp, 2);
 
 	/*
 	 * In the early days of reflink, we included enough reservation to log
@@ -501,9 +610,7 @@ xfs_calc_rename_reservation(
 	     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 			XFS_FSB_TO_B(mp, 1));
 
-	t2 = xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
-			XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 3);
 
 	if (xfs_has_parent(mp)) {
 		unsigned int	rename_overhead, exchange_overhead;
@@ -611,9 +718,7 @@ xfs_calc_link_reservation(
 	overhead += xfs_calc_iunlink_remove_reservation(mp);
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 1),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 1);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrsetm.tr_logres;
@@ -676,9 +781,7 @@ xfs_calc_remove_reservation(
 
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 2);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrrm.tr_logres;
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..d9d0032cbbc5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -98,6 +98,24 @@ struct xfs_trans_resv {
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
 
+unsigned int xfs_calc_finish_bui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
-- 
2.31.1


