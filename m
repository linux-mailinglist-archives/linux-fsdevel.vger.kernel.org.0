Return-Path: <linux-fsdevel+bounces-49593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC6ABFCB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C65500333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8828F515;
	Wed, 21 May 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JR4+GhlK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOZL4cL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1951528ECD8;
	Wed, 21 May 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851669; cv=fail; b=h94uJak+DSXAlnJtOJkTfVQFYxCfJ2pstauhHJzpViponnwE0BeP/GNd2seI+HMrO/eDJhKfcBDQaMic7UJCYoVxzW/AHC+A6wWARcut7JsNkiHdffM9d+F/XEWwqExQCdupHc1LEi7DcemvvooK7IjZBCyxqeQT8jH9pYpNmLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851669; c=relaxed/simple;
	bh=Noy+JZjIxGqzh7DeML3jFpEdmxKBRcaOZVsuNZDi8Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEgEh1+MW2jiDL8bbYIXSKyKkMjdS16xNNvbVyCG6T+9CrRQsCwQaC5AxMRq6Z3ArL0XIFyTL4r2brBUEpsBeQofCcC0oXRNTTVDrpOD2D1FwuHhcxiNXisawp3vl5Nrx5vHXh0K8g9meC2hAf7oaFzG7i94nQ0g/wq0a2D2CDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JR4+GhlK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOZL4cL2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHri2b013601;
	Wed, 21 May 2025 18:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a3zHwt0ULv4DFPZByY1aMK7Qim8V4qyWhhHxBBjQ6m4=; b=
	JR4+GhlK2Dhd96vJyFVqQqhPzg0cJKAAIy1fuxI1LwmiMsmvFpOpbvreXpzBe/n2
	nwvbxw2+9echoJYCEvQ19Epvs17NzzZ0b2Ll936L0FDmz4psbxyFN036KEU+GW6a
	SOVT7vtdNNbxMB/pY+6Y7y83pJO1LMSbwsVhyqfIXSACCiaCJPgppYFuOt3v8TKv
	9gGWDmUWVuDvdf4NYNiMgc94jWY3HHlUn/Pkv0gH63ai5AOPqciH0U177JrS8rHm
	e1afcMrEC78xRwIwigmMPuAbfx6jZWbj4ICzJw1UvsRN4Nwrhb6ziODLr8CelfS2
	K770uJGmUzcafDMcI9hu6g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skmc81q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LH0Ccx020240;
	Wed, 21 May 2025 18:20:46 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu799g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMZnT3J0h8nPHwuqJN1uWSfj0Nb5qc6F3WQ0GH3PJ8BZNWlrWQMjKwJUzqay9hCz/2+41hSDJkhPSRG65gRswtFzGYSqDQj7sk19y/pXqpwNV6QBV/mFU7HU60clt/GCFWekjvttjpsz+YEQdo4jF1CXSjioKhCnOYa5+a/VAxLVV7wKrE+QYg2XTSR+IOhX9MPX9lcNkvpU5eQ5P36JZkXKhTL0ihWK8RILfA+4a6D/XlVB3BGR0IEmjTH0ZayF2ev1NxwtcPG5wT0EQVKHgDqcnKGaQqC+M2a7TXEkohh7Rm7HW9R3k69MhfhHPq+OmPoJ7esVOc6WczkepKWZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3zHwt0ULv4DFPZByY1aMK7Qim8V4qyWhhHxBBjQ6m4=;
 b=cefizs3zi+Vdu1+kA57Ci9/P1ixFjRsQJrT8vrXTm+GRaqyVG2pGpCPSKdYbvjnZfZRKNBhYs4EpLFWyvjPAwWgIcU2vzj5pJZWfl9AxMYxKG/mo+TPehtIPEupzZEs6HllqMFsC+nm98boN51Zy7an93KYoqX/m8pfjULz36mzLYwcKZx+227LGK7TVkUTchfjzOhjn1WAPQDsjEII/95gXUap7paGron6z44nxUu2EUS19vWWm+nH5zh63UF5TfW8B4Y77Av7+fY03knDZYkxF1AaQ29a0PO0k65wUGa+PcCHv/eBnmh4dX2WANe7W6z0naWtPKSpLmunKe+r5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3zHwt0ULv4DFPZByY1aMK7Qim8V4qyWhhHxBBjQ6m4=;
 b=lOZL4cL2B8ZMP5ZAEY99RUyiawHNGhl1Zcpv9Qeir6UsUPyat7Y7U9qZmIYegvsHYqwF31tolMj2JXg02FL1Xkz2f7wnuFioTggk0wic7U3LySyaGPtTbsfRyk82uhMPTAD4aPlAzqG7ro5LT5ZxMjDy7NPAvjKgDVU8eZ81TsY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:20:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:20:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH v2 1/4] mm: ksm: have KSM VMA checks not require a VMA pointer
Date: Wed, 21 May 2025 19:20:28 +0100
Message-ID: <b7f41a3d8a8538d73610ace3e85f92bb20f8eb42.1747844463.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 7021fa97-4990-4dbf-5bd1-08dd9894327e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IiqBRiLbsfBboAulR5sRHXxsWBMJI+tFY+GlQtm80nuSEgUoqJYznFLE1E/K?=
 =?us-ascii?Q?Jh8t4BOJ/f8OlMzOC691rKS0IQEgNxtzZ+rZtzzN4LWaK18bj8YVE+axv1om?=
 =?us-ascii?Q?vW/xvAO7S6X/YBwJ7rOOtMe/cmUaj53ag13q8IL9DeYzo2vngM0JxkAzp43M?=
 =?us-ascii?Q?jkIk9xfXgCmZ91m358QZ6WKLyvT1Yjh2ohPkdEbhx0eFN+TKeBDG7DfN0WFe?=
 =?us-ascii?Q?sPLFAAfs/wbTiYr8f3Kvcmb3YHGXZWj+QSWpRb6MsHDxwqaR61O9NPQXKsdh?=
 =?us-ascii?Q?o/i9M/9MIKE3wR5ExZo7MtquGhkcJFLbn24YS2W/ow0PUdOywndqQ4QCvHT9?=
 =?us-ascii?Q?NU2axq4/o1LCF/uRpdK+2QCv1c3AEQCaU7hHl3QmJ2KJALv4lXOxxLMjN7rG?=
 =?us-ascii?Q?T0Ux7yL3GCqOLVDNe1MyOMZ7mQ9w4bYYGDr8nFD4T6tqrqG/kD73+ONACe2g?=
 =?us-ascii?Q?uNE2USeOL2D2D5on62gV4AKsQ9sQ3A2CT+v+NiY2HN6eLOQwJdOX4Teflo1p?=
 =?us-ascii?Q?al9acNB0wcbijP3OuYaZhdHsm4K9V6jqRWY30q2Z3EHpo1F7uPI4YQfpjwyd?=
 =?us-ascii?Q?2bDuMt8+D89s+thuG/6Cxu7+nU2yD42GyNXqV42aEZo42MPuCwcHWUXRAd4s?=
 =?us-ascii?Q?v7UeHHuzG7Egmsma6mIMmpT9TQofmsN7PxDOsVMF93yGmIchm8aEMwjEAXl1?=
 =?us-ascii?Q?zTgyA7QKGD/JRscTG1GlsFBrqqe0oasR0OkdhQy3VhCSuGmM9ICLLTPhkzX3?=
 =?us-ascii?Q?y0aCDPzbpIaeZAl5hxgLwQreilT65UQ0tUmnOheSofpOjIoXna68nqmkLim3?=
 =?us-ascii?Q?wdMP/zKgtLlmgxm1EFbsB+EHHlmgKVUK8QGcbyiVF2CihWvXJb26DC4eqs/l?=
 =?us-ascii?Q?mU9Hl3Sh8m0XRnT2WWy8wlgPCnQsUziolkR14yFoyqYD5yMuqVM9kvDBslM0?=
 =?us-ascii?Q?Q8Wj08d6SzFVMa4hpW9a0nCu0RHgYLaOHsZ10342nFGusyQXcGP9oRQin1NG?=
 =?us-ascii?Q?fztVmLoO2gJxFmUhiC+TlZ/a2w8flUhX8zlUbQ8gXDLxBlFzN8GXj+9tYCTS?=
 =?us-ascii?Q?+yjLaTqnxFn5fFfKf1JAB9wZZeAY4aPz2XuPJGKChPDQcInTrlwUX8fUtwzJ?=
 =?us-ascii?Q?f3uU2dDzDoZzMhk8CrrqvLLgd2PZbIjwSHeKJYqo1MkVb1bBQP1YcKke8P7N?=
 =?us-ascii?Q?MTckltCsgpMHKeweq2CQQuZCCMBnRQRqt5RyDViHIw6lMKHtEgZ/Cd3slQXw?=
 =?us-ascii?Q?v8xJ13opymvv1hOhJwCDxGcgr0onx74/IBGDplcj6CKLig7R/D6sC21vnrtW?=
 =?us-ascii?Q?CmqZitFsFYiXh6LgIzjcyfiwEVGDux83Rz7+Bo/SgFj/RhPh0PihaRsRny8F?=
 =?us-ascii?Q?qb9tTz5F9yON2f6GVC2UJtZCxsq4HvlgDtMuoOsJ06Q2x8PkP2k9qKe13qZv?=
 =?us-ascii?Q?inClArl2olg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2q1cWCZsXW+dJYfaL5L908sMmHE6J7LBPX6BUx38jzgCtvs3EeOsNeWsVsX?=
 =?us-ascii?Q?mPuCXSgIUSUEGvpicTpuUso6LBFBmJ5wVSVdUUXKwPGQ30aImcYTYp9yjDn+?=
 =?us-ascii?Q?FZB8xgSIaYk91uyOSa55FS/l9q8dkEO7ffZ3R8G+io/vr4RzMW0pOFdXmImv?=
 =?us-ascii?Q?V5SQgF436OzCqP7YbHiDvQnUpVCtpOuAs2YULKHZ4q9aZh9JkO9Bwy0lpqGf?=
 =?us-ascii?Q?9C2RI9d2uxCWe/rjqTm/0wdRMt07ZIiKPb+0UUzmkAUUlGaxnmkqvWz7zmmo?=
 =?us-ascii?Q?vZ0DhAm5beldPm4zbaXtkb712/oVeq4XBO9stpAnOqb4vBr9gDrxcLFiaR0n?=
 =?us-ascii?Q?1vdAOJCc8GbCR3OnJqkXAPcYQJ+bN12YTXOf8wCZ+QMU9Vm/xEoArBCmRvTP?=
 =?us-ascii?Q?+ic+jHlhUuGWhwODBYJnRJhMbP+mLu6XllbK8AIN+h00Y3mPEPgx9OONhFk4?=
 =?us-ascii?Q?YH30YdVSMQY5aSYO7SbsRN38b3fP7v2IZYV3G3TUAlEx/hoNk7XZqEokZoxq?=
 =?us-ascii?Q?lteLZ82N1851ehHDkIU8v0O0TTOLm8cyr84UId28FftlEXiVJSaK10i2LK6Y?=
 =?us-ascii?Q?fU0fWzy1GNo95EdV7yNETgHi7FT6j6xCOE1I3Jpfy2gKZ8pmkxoxnqhhgkpA?=
 =?us-ascii?Q?51FiQKNK0ZJoOMJsVs8O0KU8ddZ8KynNEj0GPIqf2puE/B0N4+r77In9BD0P?=
 =?us-ascii?Q?s7Ks5Dd0BeFkgO4WDiMTVKOyNtfDtBCzftGkR2+6dSjxjxaP8+TihhnwrZyW?=
 =?us-ascii?Q?fanBBioo8QV+ki4o+Y2BlQn+pphpyCPDwth+b+MTygXuOl680oz4D7fB5ogM?=
 =?us-ascii?Q?864JHb0uzt2ChevDCv2CE9tgWrSIStsWuVEDs5poSDqfY6ikEQdeQutKEptG?=
 =?us-ascii?Q?S1vuc9GZY5KugfEbrzwgEUIJ5HNOT+4UC/8eseVnJpTkl3fEna7WfftGHwmj?=
 =?us-ascii?Q?Uu7vui0nT/kE/+V3Se26QKKuTflbQNkYJPDEQOSDP7tB486i5THzpltgRkiw?=
 =?us-ascii?Q?RILMO/B60wcXKJ0PtFv5hUrySc2CKUatOMy9lMwwhR6jrzEPCacZnh1HqBNE?=
 =?us-ascii?Q?A3P6raahoyzBCog0aYKbmptSg1rSlAkbczEHdgOJFZgXv1zEy2TdC7mVhHfa?=
 =?us-ascii?Q?XdKi30RNtSeIdFKwELG4iNg5To5AtkStHY3IL6/QkLwQGXN/2o/ScImYrYhu?=
 =?us-ascii?Q?PvA8OpF8mII3b5TJSqoQh7rovKhgYJWVP1tz2vOV0+GcUOJxVUUJBCsacgYJ?=
 =?us-ascii?Q?R9hogItstItGS+4bkuwiAQYthaAo6ijrb0ep1Lqr+AzT/bip6Jffi841MaVY?=
 =?us-ascii?Q?SyWSAVhmk2SIPnL23pIijmvRiEIHu+Mh07Gk26ApLArWGDuwISJKR2VOwPx9?=
 =?us-ascii?Q?2C7APwoKNzcKSuro9PB527076aNfRpluUVXclHLIyKQJh9whJfVT3sAouqSD?=
 =?us-ascii?Q?+1pDxJq+D5cABxxhkjlR5LmTvBCgY4y36HR8hywSy1MgztbN5Ss8/zv9ek5Q?=
 =?us-ascii?Q?V/kWCq3rqbu4+C4BmG6AVIVyRuJlOOCTvuVjZ/LIy/UO1Wnb7HVZmp6rfhxw?=
 =?us-ascii?Q?q0/O1m3EGGDYIOVplnioZmgnE6GCzm+pQosuIF+SnEwSquNQWiuFx5Ku7OsH?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pZ1fI/c5mxwyG4c5iLqoqG71/vnJfam+LBw802bPiSoWqcjo9FKca2UPkNIcj2mLbTKJXXa/egRljEfp0c6gfnE3N7F+qeSRppJyXF362SI14bzgAqcIoDnENEWzqfLMmcp+aGY4itJhmO6dBE5cM/yCh8lzot7uBLhw1ZRLdbYJWObL1Qrs+6wApLfP/zMt/DLSWSOcwwLVNtS99dwoxV896WOnu93U4vu/PFpCjy8sugHGux1tjC+dVHmF2vUw9lJHHdFX8vUmXeIvEZbaGDHYT8A4JuzjK71LzepgbfAzF4r9GhbSpJq6v4uUxpKzNzgoUSXFsi7c3FOzGOVyG+BBv2CSWf7Q7AssSI0KAiQHYGeodvgYdrl6Ix3h8x0KHWlC+1LKOOX56Z8c7RSSirvQ7mMLL/467Mj1zqN7+mWM9MRlqTIncGTC9QK6BxMetyt4UollyWzfKDd1BskxHOj3jzgtgKy3IXE2620T2OS7GYz+faO+rWH2HegGN9hoZByrrbECYloL7rwlj1tXv98JECaHARqc32ROvE+QRaTTWAmtGAQpmD7bgCRPO2eJVfVNA7OuN26T71v00kueQGqXrJ04UpZIN/AMC+ZEvlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7021fa97-4990-4dbf-5bd1-08dd9894327e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:20:42.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jS1Kcwa492Zowo+c0EP3D8lRCkh3O4Jb7Y9MM1+VRNZvXFJWb1rE1e1WSWkkGkq4qF00+jMASvM8b+O+wUUvl5Xy1Ubti6bA8sUcOXu92E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MSBTYWx0ZWRfX4kfAAslYSRGw zOgJf895UmiwHJ3PLZT05tdds7TfL6DNP1B+m0oKJxidmqg7YzrjKMRZGkQE0JqjP6rewBSgPKa VtFs/6ofUsHoiOA91xUUjZNcOJixM809WkFZUFJ/uI53Hw2IBRenAV/Ts8PDL/bx2Cr6dlW/BeO
 gaXcT8NeY0qZwdgEzOCL8e2KnbrIjSWc/UFY7oOBy1OLvTUPNf81Le5sVgIx7U3vI2DW2wnG5UX bLi12kwKU13aTLaYUunmP3ti5qNQD+GEbdNWT60Ftu6jOWjuuZ70SsRwwlPFfxBTlpjD83ZkWwu 5NyhoYlrTYLM6/iDCuD0V+DuY7kV/Bk/1ouUq+9+L2AKTz9E691qviOzopSQNyW+/AHS0LQfnu1
 WpLYlM2pYbe07NsB4Xwl+dYt+b8Y/c7Zf3m90G0r0DgguN4S5zeRujIfAAZd7ZeGb++me1BM
X-Authority-Analysis: v=2.4 cv=B5650PtM c=1 sm=1 tr=0 ts=682e1980 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=lOzPg2vIf24U1BXouUEA:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: PJz_GS3aD607VDtcgv-EuPGSyxwTtg3e
X-Proofpoint-GUID: PJz_GS3aD607VDtcgv-EuPGSyxwTtg3e

In subsequent commits we are going to determine KSM eligibility prior to a
VMA being constructed, at which point we will of course not yet have access
to a VMA pointer.

It is trivial to boil down the check logic to be parameterised on
mm_struct, file and VMA flags, so do so.

As a part of this change, additionally expose and use file_is_dax() to
determine whether a file is being mapped under a DAX inode.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 include/linux/fs.h |  7 ++++++-
 mm/ksm.c           | 32 ++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09c8495dacdb..e1397e2b55ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3691,9 +3691,14 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
 
 extern int file_update_time(struct file *file);
 
+static inline bool file_is_dax(const struct file *file)
+{
+	return file && IS_DAX(file->f_mapping->host);
+}
+
 static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
-	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
+	return file_is_dax(vma->vm_file);
 }
 
 static inline bool vma_is_fsdax(struct vm_area_struct *vma)
diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..08d486f188ff 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -677,28 +677,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
 }
 
-static bool vma_ksm_compatible(struct vm_area_struct *vma)
+static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
-			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
-			     VM_MIXEDMAP| VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
+			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
+			VM_MIXEDMAP | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
-	if (vma_is_dax(vma))
+	if (file_is_dax(file))
 		return false;
 
 #ifdef VM_SAO
-	if (vma->vm_flags & VM_SAO)
+	if (vm_flags & VM_SAO)
 		return false;
 #endif
 #ifdef VM_SPARC_ADI
-	if (vma->vm_flags & VM_SPARC_ADI)
+	if (vm_flags & VM_SPARC_ADI)
 		return false;
 #endif
 
 	return true;
 }
 
+static bool vma_ksm_compatible(struct vm_area_struct *vma)
+{
+	return ksm_compatible(vma->vm_file, vma->vm_flags);
+}
+
 static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 		unsigned long addr)
 {
@@ -2696,14 +2701,17 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-static void __ksm_add_vma(struct vm_area_struct *vma)
+static bool __ksm_should_add_vma(const struct file *file, vm_flags_t vm_flags)
 {
-	unsigned long vm_flags = vma->vm_flags;
-
 	if (vm_flags & VM_MERGEABLE)
-		return;
+		return false;
+
+	return ksm_compatible(file, vm_flags);
+}
 
-	if (vma_ksm_compatible(vma))
+static void __ksm_add_vma(struct vm_area_struct *vma)
+{
+	if (__ksm_should_add_vma(vma->vm_file, vma->vm_flags))
 		vm_flags_set(vma, VM_MERGEABLE);
 }
 
-- 
2.49.0


