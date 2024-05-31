Return-Path: <linux-fsdevel+bounces-20657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB338D66E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E1F288253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE8161B4D;
	Fri, 31 May 2024 16:33:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80931155CA1;
	Fri, 31 May 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173185; cv=fail; b=p2a36Y80qmxSvaq4AgtrzVOcQqqc4rbCkohIXtsTK/1i5zEgs580vxvPTPDH9PjX8LkLwG1rMK2Kt/RpR3F3yMq/77RFW4wT4tO5/GW+QqRIPQjkh012gkF7lPBb+ecFPxHiu7zU5KOApSp7U43M/GaX0pRX5e70NIdgGqzhMQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173185; c=relaxed/simple;
	bh=nn2hICc5AVthLqmPv/tfpgqPd7gRSdH38dYm3bfD37c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FoX6GzicDVJTfrLH/VNqvH2PG/HGbkJpB52YoeB3w1opmIFmBICIe6KOnaXIR3xATjddu8aWY1gGatJg82etPLIes+5Ie1oYUb5yLJvz0B5nSHqJuk2GPvAkLrCsHEP0bThdO5SxSz5/1XogOvvwkl/TXQrKKdb2+Lkplly4Ktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9VZxu030206;
	Fri, 31 May 2024 16:32:46 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DGwGJXYNQp?=
 =?UTF-8?Q?7c4anFKgay2mbvPxBx/3edfDkmGb2FBBfc=3D;_b=3DEktvtpFlAguoZNERaGo4?=
 =?UTF-8?Q?+3RSrPoOrfQXI/c3tmjY2Tdgc+s5choG0dj4nyc6XtZyLAQw_rHsqknzeeu2Djx?=
 =?UTF-8?Q?5w0+5NHlCDTnrzPKMe5QCf6aLT5WAB3ucMV+KaF9V1UmSqPILVHSs/_Jlc4nSty?=
 =?UTF-8?Q?B76wEiNiBJ2HnouqK49bwz8EaskGE3pg4T1Z74mnu54q/DcL/cgWb2MGVlB3_YE?=
 =?UTF-8?Q?GanvNFzDP446fydGnPuGXT6LPCxqESMk59C7ppegE3uU1ZMy5qubsQFi446tPEA?=
 =?UTF-8?Q?efZ_gLxK9qNGsklvOmlS91ujufKesIs4ReLKuKq93GcTsvw2cZvBv8CjdmS/sqm?=
 =?UTF-8?Q?RYt3VnQEr_Nw=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hgbk7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:32:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFSSCo016417;
	Fri, 31 May 2024 16:32:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50u2xb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0eKvqzJjeGJ5XRp1l0hId6eJWukmUSll7jFbKj86Phouu+lfc1RP5MF8AMHXhrEN2iAUlvB1HriGAdymNS3Gd07/XZo4KMk/2tueV+R6hJakysuEbJfVHVkxKA3rBZQVMVPlW5fgXupEPaKi2cLExdhlN5FnPoB5Hf58RaL7LVM5W+8ISsUJjrVF2Zt4+yD57B3L1oCgtkjfC1fUOt7L9SjpoTa58u7gSTLKlS8VzasjEC+zgSIH7N0t6IlLu3+3WXkH7tUp0eVdFE2C+aA2lE57gChJJmaX6xHalPG+Vyp3HgYJgKBcLOdZYEX4j9Hn0V9jwgzVEAR9xUD8eJ2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwGJXYNQp7c4anFKgay2mbvPxBx/3edfDkmGb2FBBfc=;
 b=cvp0kMr2njqVgVzjxyTqHbVKM5oWAk5ULQOv29Ac1y9m5aLff9fzNpvyHPcNOpcRindMzOX/SPSw5buPRFthOdzlxjNFyq+zykCwNELQf4JCjRPOe7UUFPtOkZ82M8I6L2owSf6oz/2D26RhymbfKruyoul4uy5/xiAdd5I1WjbnQXbJghXdWXhMse4KowExj8EzPkMLpsZC/Nx+yfM+Ea4W37pba1sV/jvC97Mbxz254Fk38tLEEpTkOeMHqs6f+wTX2JB631C9YrjR8ZHAYuqta6IYLQHWK9rKo58N6MtzOsRWYNvEAleFLkIuzq9EWNh+FPR4KZHlnyn4QhJiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwGJXYNQp7c4anFKgay2mbvPxBx/3edfDkmGb2FBBfc=;
 b=gxUsVm+xgaVHagQPHCP0PD4tqPN1YGw76j/xHcFQ2oi3pLic1Ey4NfE+ACofDdr7BwW7aXpAE6bVyTMb24p8dEnpUJh62642K4TFjRbmqszcZh3NdQX6B0vWO3c7L5oWoa1SfP00uWzKuJYWZ26Ym7WcX3dGJ/GwySqpzoVJ9/M=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 16:32:42 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:42 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] Avoid MAP_FIXED gap exposure
Date: Fri, 31 May 2024 12:32:12 -0400
Message-ID: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: c13e5292-a236-4fa2-53d2-08dc818f4b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4v3QOHQ+zROZxnGpna2fpdGeW61+uEk/dMxdO1qCYGq3Ef9Aw4UufNOtfjEh?=
 =?us-ascii?Q?2x7fXWxvIYpwERZqB4MJnnEUMpr5PsFQjiWpbnu6O1iH5y7MdbR+OxWIts7Q?=
 =?us-ascii?Q?VaIkbgnSngJC5nro9xjwYIDE0Jc4V2RSHxU6pwYt6oW63HNuiOKDnzcw381K?=
 =?us-ascii?Q?Pe+c7sKf8XZ6NcaMzIjUjjgyROcpYHGHwRoTK26XAGxCwi7zNUnVkWCaxYwZ?=
 =?us-ascii?Q?izQOhTRoSrp/Qo4modg5ineq3yE3Wb8fpexx5QJ/dUm343LPnJqd6tDKGpKY?=
 =?us-ascii?Q?C5dpp2aXb4TQlXuQsSOAPFbLyURwHxquTaNCWzLNBMI2X3nnpXTjXjNJ/e/I?=
 =?us-ascii?Q?++KYjNMOXKVHWTg2hViBWc+bTpDSW6lUcul4+sKnT20P7wt9XGac93o+j7Iv?=
 =?us-ascii?Q?8j2yKE14HzI8xyP6VVYjpInXpM9Wyy7ZcBblDV0VCJKtzx2yIl2bQHQOrv9h?=
 =?us-ascii?Q?ZScaT81H0IaG/GTzacJqC4JJX7uHNucwbB7QwsggD6bWcdYkGEq/3L4bZ2wP?=
 =?us-ascii?Q?/+JKhEl5aieFyVeodtxmHol+7ReVRm0ymJfYmPIqFZxYnORX6VbBF8Zwl1pQ?=
 =?us-ascii?Q?wmqVmfYvf8KN9IqDyRu4w6e3gKRebAdK7KLYc5HZdmbgafKc5KXn1BCf6j52?=
 =?us-ascii?Q?96uPoMVu1Iiq4Idd7PykJgBt4mbU8FyDhfQPTrXJOcqIfdOPMlU0Z2MlMe3W?=
 =?us-ascii?Q?bgpMOngLK7jK7YOYWRGb5J+EqytTzPVCR+6P27NEzEFjibvvH04rCluTQNGr?=
 =?us-ascii?Q?BqrG1AluD7iX3qwbfYWPwVfJ7sYTxQ1l/8wHPKmTDa5wzp5DzNJJ7Mhym866?=
 =?us-ascii?Q?7Urf3sSAgNd5Rzi322HoQnS7MRT3P9UJEEK02O08csk4rKTGsPK+3vF9HJ1y?=
 =?us-ascii?Q?B2B0i3zBzNc60lRGm5iHrsFVAqqhdJzDUzFLl3s9J3GgY2DHMtnNvfauEBe1?=
 =?us-ascii?Q?qR9iBic92auXwfLSaWLIs2QMrAMnJNPomgbdAMlITdwtP7s9qcLbEzvxGy49?=
 =?us-ascii?Q?Krg+IcMfe9PLuhbJi49iz7e+qjLD+g9+rId5bZMLxIJXmh/I9zqCspVitRbX?=
 =?us-ascii?Q?ADek16HpJOFwBOuX03K+mCLidw49ZndQDQUajy8o3sUvCSxI1uSpS/Hefe9R?=
 =?us-ascii?Q?ltHrr33F+mkVGfAjFy6CoPwqHaiuS+4r6NUlO4cf9M9o43jU251HPZqbO7bB?=
 =?us-ascii?Q?5c4nNzycTMi1s3V3Tx6BDHEWLuUHqIFh8WlZx1uELDs4qMT+dij4PBSa58I?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0udmhyvLiMDbaJ1bSYhS/BqzrVIf+EBqVRRuf5nn0y13g8qcrTK1w/SAmgdD?=
 =?us-ascii?Q?WrfOAS7ihW1EK/bET0zqhuy+UU4F5jMgVtN//zkFtCGiSi7wVvIzTuXTmWaz?=
 =?us-ascii?Q?B94eiS8yMrt6w2uEQTovMPcZ4D9EaocKlVDap35OQT9EZDTzPxvkSg+ieL3l?=
 =?us-ascii?Q?lr87odLa3Whgy/469y+TyM660rBnXbNfkoBXCpSjrXqWSmApuPvJKH8qF6TR?=
 =?us-ascii?Q?zNNG392stHfPsNCZ85b7D/4mg92kPROlOWO4aYhXdDau0M7tSbe+kkzlKsIt?=
 =?us-ascii?Q?bStanqZi2G502IIYGH518x9wNZK5jsdx9++Fy5HUKYPlwQIdGHdUznAGqE/D?=
 =?us-ascii?Q?ii5Q9lGNsoVqgyqTI+/tFurnfbeR3kzdLx6Ib+I3FO9JwLJ4Yd2vII538uRa?=
 =?us-ascii?Q?EIkxOANDR/BkeAH5HHzJ0NSj7+PTNrm059pLaU9VDIElTnc9Y/HWF8DtuyF/?=
 =?us-ascii?Q?XgM6O1mcWj/TOWtmORAqS1hLZKRXalK3D3hHmaGxrbmNhrhr5BdgClfKxZk9?=
 =?us-ascii?Q?dS6KMDCG0w2gMvfcmiuI1Jm6SFZ5nlY5uAuc+uOvvwvhvAewlPTufeU9Wub0?=
 =?us-ascii?Q?8ocq21M9AjwTFOGvPhPhTz3f85xCW/4bG1C5apfhL4kERm7NtZo4mfluMlQu?=
 =?us-ascii?Q?x0IwjRuCCq08gI1xSIP5Kaf806agtsqVZwq0xEH2y2OGTqCep3IBuJScvaUA?=
 =?us-ascii?Q?sM4G+eWW02KuaGVfTyDgiY5TX4qEYM2XYRKqvVcssjtqoHw4MBuBRxFwXskZ?=
 =?us-ascii?Q?tWTmidDsjs0EWOelSpdFigMpizGMjcWdS5QuPlhwMMpU1j7cYSmtLWn9ZVp6?=
 =?us-ascii?Q?DLPTswxdVMi+r3BX1yqRVzD3fIFBgCO5fn88/sLoAI8M91RB+DXOtpfBeOvE?=
 =?us-ascii?Q?LzPA5YAo6JZIXm/nN3RJkFCJv2/D5vXilI0gd025MqFRd+/i09PD8j77e8Ii?=
 =?us-ascii?Q?lcvf21I0ENvxVb3EQ3Au5bhI4xuFH6oWYp7pDkfwBqZZ2zZNciquxbCW45am?=
 =?us-ascii?Q?Z5zhXiGIvXk4l6oUbyTQibu96O8b2bIM/BNlqVR3TAO1A8CAMo2jbrS157H+?=
 =?us-ascii?Q?DUJtd1GzhU0we+ZdMqgjJlZWYnc5D/cZvILZpWQ8O0jYyWChATHBV5YV7ZSS?=
 =?us-ascii?Q?LwMq6w3L2v2GxlsMdD9zgbEvzSPxDUnLSom+kGgOxegF7ihmeDqyI8ZnXd8F?=
 =?us-ascii?Q?vkpEfltEO5V9Rp5p3GyvofQUudi89dLgwcuOyCYiEmK6gP4VBlgH4BcD1hoj?=
 =?us-ascii?Q?7HX9cENDJc+yNUFdRRrTjOryBgPi61asZt65ALo11cnGF1wZbVGgp2NJBk4x?=
 =?us-ascii?Q?MrMtuWLQOTrcQBZ0tEMtUCkviAwaA/TTmGG6ys4jAQ/QxKRIsgi+nTz4NGxd?=
 =?us-ascii?Q?TvH1NspnegD9DdzS/ftfmRS33MbmvjKQowdBHCI91AYxHjkNEQPczlSzthDW?=
 =?us-ascii?Q?ohMGLmLY3Vxil++xosRziw1mzCrGVBnrSH4uYwzHScljApdhbchO7J9BmQfs?=
 =?us-ascii?Q?SzlwhhnhPVE7Uxr/MATChEtrHRz3YD0/vQsEUJUgs5QVhf2nhWfpDNdz9fGN?=
 =?us-ascii?Q?Emc94THuqt9b7tjZhBvILwV7rVMbJCQnsQu7A89okkz20LEMJnwQkX2Ou+ct?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6930PmU8jYcW63wcEr/AByPFjQP4cii1Ujp4yleFXhUwdAq57Jtqr/EvNWd7dFKQC1PYYJwvuG4HcD/8Db1tfCK7YlLIPXd40UUn57/k3qEbcG0OFJh1v5b0o6gmXJXr2Q8qjKPi6DZ4bWypqUymVfv21r2CkRIu2ZC7sf8UBKtXhZJyWvSK5bgeq7Ks67I/fTDtCov4DeMJhG1Ex7UPeYfqQKZTOhPBl32UgAWRHcBqsJEFz+KUQa3jv3zMJSCa53BHkVU5QsQ+kgVzP2oR4kDK6YlDospgAjpJ+0yqln0kvacxUynrm5xR7kusmtzpMA9odfjNZnfZ3tsvB970EfSfZAhBkf7uEroLeSX0RYofSJwaFBmews9c8StLqVs2PTTGCagCvrzyuZkF6LYb66PjbEC2w4l6iwF9q/GhMr472gXQtkszNdFX6RuSbDXfQpYJdCpvBikWR1UV0JRlHsjtydNjbXnnwnZrEJT5F0/cakxRH9HDQX+8fXZOFPkIS7IfgVvRyclKahTbMLZxFtCL/4PP7de2X/Sodce3cBh2Y7SsJr+q6O2GLAwHwQjt7qzZeRdT2sMcN75YWlkLm0rJvtXGmyZwpDWL76ryMb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13e5292-a236-4fa2-53d2-08dc818f4b44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:42.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG9ouDVWfCqXwZK6oyKbos/kcxsv7xSCm42kvJDY9b2puKTXePC+iOS0b8vz0mZ60xwuqvEDv2mzOIo5sz6Scg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=732 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310124
X-Proofpoint-GUID: OPAubzvUnpHQsM_EW-f5rHhSBnytq9BX
X-Proofpoint-ORIG-GUID: OPAubzvUnpHQsM_EW-f5rHhSBnytq9BX

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas in a side tree.  The second part completes the
munmapping of the vmas after the vma tree has been overwritten (either
by a MAP_FIXED replacement vma or by a NULL in the munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

I am sending this as an RFC as Andrii Nakryiko [1] and Suren
Baghdasaryan are both working on features that require the vma tree to
avoid exposing this temporal gap to rcu readers.

[1] https://lore.kernel.org/all/gkhzuurhqhtozk6u53ufkesbhtjse5ba6kovqm7mnzrqe3szma@3tpbspq7hxjl/

Liam R. Howlett (5):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Split do_vmi_align_munmap() into a gather and complete
    operation
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Use split munmap calls for MAP_FIXED

 mm/internal.h |  22 +++
 mm/mmap.c     | 382 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 258 insertions(+), 146 deletions(-)

-- 
2.43.0


