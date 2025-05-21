Return-Path: <linux-fsdevel+bounces-49595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E1ABFCBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674417AE88E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10428FA91;
	Wed, 21 May 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HVSY4aus";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kezP9yDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435928F93B;
	Wed, 21 May 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851673; cv=fail; b=UbzkFTgGUbheH/ZGn379mDQqxRfa/8G/4Io/74hNDIWy2QEpcDHYr6ZpmlU7Cl+f+R9NveHP3Gb0GMmlRlSoN/nELSwmstof0SNNWrOglNDBBiO5bjVVRP5XifF5d2pFKgPu4VUWsW9cnpg2hBx1k2BIjCqdUi3w2sV39jLHbwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851673; c=relaxed/simple;
	bh=ngm2/ZpxfWckNSaa/SkGY9g8uxcpQVHPVE2yUF6Y0X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugrpvqVRFUL0wi2mPJquClfdRJd2Ji/1t8tK5Rk4yXy4uOiN0idb2OEiEOMyCpfVYxpt64uzybK82KKsvPOA6uvGhGkwKhrJCO2uX04oilMU1X0uh0G7GBmQ2vVX6eZzDHKWkAKaz+mk2OLyIV5hHQRvG7fNRrCWs8+tIMzD3Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HVSY4aus; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kezP9yDl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGuqE9013246;
	Wed, 21 May 2025 18:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z/MWt8fKSWc/VhnmpoGSQF3TNUvvFWhQLq+O2BAiICw=; b=
	HVSY4aussMRLdkvKqHCAHd2AaArcVD4wsvL5Iu5P0MlsyhN5O0vUDJV+bDSN4hPn
	ZzKxoA5yL6qhtjXCTtMkEk4nvQSf0VQJP/wT3VgweP18Rq/JLXfeCvwGLm+sSCWA
	UiyvHs1j9U8GqoUKuM2nF4H2AUa/GERWVEIPxWaqfR7KSzYQEXUTAAXCX1uMgEfR
	WRIK1qC7kJOHz8p8VVeKiJsFXTO1UOeSv6I6OPANfiEABKXmPveQBe1lsxVKHPgV
	BXbA5e6JEPMqlukOJuea5ZkhryqDwGoh+3wuI0RgL+2vsVqjsdvcLVGSspd3v/qz
	jAd2Auym6g1pBCzsFBb/Nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sjc2r8qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGqjXZ033596;
	Wed, 21 May 2025 18:20:52 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11010012.outbound.protection.outlook.com [52.101.51.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwenq3u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG+QmwtEX9ma5qYYDuGPtYjztKdyJzOz3L7JmPYz2VrOSds1P9m1WEagN9lcVaE9i2R0rxTk84is1vDH1gX22A70Z0sgR8R3o2rqId6HoA9azdvluGrqC/Ap56XBby475swipxrwcJoepw9T9G6OgLiVtMc4mz3d3vvSOQSqGKH9FOZ7I2GdQwG/R4xbF0DSXDCFcspAto2tf5yEruN7b9jvLIc+YXAiAoFPLXs0h2GgRfUckGxTnsCkBqOxVhWnVHJKqT+kMNB2eFTYpnywwv9iTA27BmXO7l615R8/ymB59pMduQFCqq6yfQWSxfmj96+G09o55MhzXmaD62BNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/MWt8fKSWc/VhnmpoGSQF3TNUvvFWhQLq+O2BAiICw=;
 b=csr1zJpu+gd3Nvm0ryKPNW+YRSXV6RyHw3Pe+EV4nP6acBR+H9rObwkJnQ1AvJAX3Y5qOAYUHhhoyRbeBYMWgcus6JwX/UbmJ1x37BC3m4/mxC54D8LeYt3M9fOLmScdHuiBEe6lLR51hyqMq97zL/e+QhVOZh4a4tAkyX4/8D3c5oZ09hv/oiCbtM1bfObApuFvLW6PzFjZdikYXdiAS0/rgUhtLT3ibUR5HsZ8QWASSAE/PcYWHL7dpzRBwL2havOy51E2z6iftjP+XPpNxqkFwahjiG872QFgm3H6eTKlwhCkzUfHwhhSamytypcLdLwsWn2P+HZDDJoFVplzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/MWt8fKSWc/VhnmpoGSQF3TNUvvFWhQLq+O2BAiICw=;
 b=kezP9yDlKKOOcDr+YoQYHZhL34Ed2v45U8WD5pN/GpB88pyEljJZeGnZaJeLA342Zu4PLOIT3hup+MEIZYpHEDU8UeBZO10oq589AH3CP4qqlCp7uk8CBjJC7HMPCdjymocQFQal5VxCTtA72j1YUg0TVs354wnecaEPYl6w2/M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:20:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:20:49 +0000
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
Subject: [PATCH v2 4/4] tools/testing/selftests: add VMA merge tests for KSM merge
Date: Wed, 21 May 2025 19:20:31 +0100
Message-ID: <cbe5274aa4440be230d87a2b48aaef2b6d73403e.1747844463.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: fffdf48b-9033-4c8d-2cec-08dd9894369c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?diu2c5l01Y5Nvc+428OoYx+Hg9QEAi2iX/uotsqz95N9v84PyR6rMIWwbpU8?=
 =?us-ascii?Q?3+K54b0eQkJfNpxTAXnLhwzg4RGa5FtDhD8XvRmT/c4+YoqUec9+QIis37UY?=
 =?us-ascii?Q?oFjQ5AdlC2Gj+uEzLaW6WeY2tXmCB4AL2eLjhUV5zDJik58v8uxF7Z7fSB1i?=
 =?us-ascii?Q?11cIWI2KTBguEyUsY/N6FPrnMCp/10Rl6QqaYUIAgJB5utRQWjw+7/ScCgVw?=
 =?us-ascii?Q?6PqIem+hBAEfSzmAR1P4KtspBQ/eIGCL6fntXyAQonr/6skG6fcvt92ysrLE?=
 =?us-ascii?Q?zT+WUqdQO8zqTTDy8y2UwIFiblxjLScWSBnrqe9Pn2hJA0Hzg4s2gf138LEv?=
 =?us-ascii?Q?d3PZBJpDF7hx4duC/EqPCppVVVoRRB1FlXfXqB5d7LW21oz5/0uRGrRW0prz?=
 =?us-ascii?Q?B9mSsk/XBi0/A25oVAJjwoK2UwOUGxDFcQPPD0FSzS+1pJvvps+diOCapCdH?=
 =?us-ascii?Q?LjB9FOdKhhug8cDuG0cvvWHlnMPApQ0BDUwkrOQ+r1ZgXGiWHD4nY+AhdJV6?=
 =?us-ascii?Q?al8w3AzxkoXzc2UnmGax33+tlKhopDpx9ikxmucw0K/mmW5j16SDthUxiva9?=
 =?us-ascii?Q?aGzW57N8zv+cI7RzE0/2pntVDJ8pR+K9H5REDRIJZevHYpXYpbI9aGo7E056?=
 =?us-ascii?Q?vZsgbsOUJFzkFe32XqYzzkD2fGK/VK+W095IIhAuSucEo7IYxnEerlPTPPcz?=
 =?us-ascii?Q?2Mnfe2m+ZwAgMGRbucxGUjl5Qqjhp3PVejdvZvQbheJ6kCGPLWN1u7fFf/CI?=
 =?us-ascii?Q?eEg/X0j8QojWjKcJ6RSpc+M3OTG9xKd8Kp/Jxzb2GXrBvhg1wWGJJIGRg7F4?=
 =?us-ascii?Q?KWfZ4/JyZX1AUB8n8l0cMDKrmZyjwZ5yD5vn5iVriK/hhwUsfXHA3oULUMhw?=
 =?us-ascii?Q?cD0/N2dbCEm/zWdjmUwkljp3nCOBUeJB6KOCdXlCIe4f6nmREOyXuUnpSCPg?=
 =?us-ascii?Q?NttYNuxymW9Afb7oW6VRtTo+svSGNlj+yJ1Bw47F1ruOKzcAPr9vYXrLdtyA?=
 =?us-ascii?Q?eQfOOGMJzJ49zlDYC/cpWOEmSbycGQKHEtSRViBFthQI+JyPDhXN6I9/9AJy?=
 =?us-ascii?Q?ROXLwZ8BGxk/wRomZUrJfSQAM5SGi9UV2BX2pogiNX7qKfSmir1LDMZHPzj7?=
 =?us-ascii?Q?9pryDujl5gLd61NyoJS6LavcSyLk2DxFpu7Y1G49WMBHBAhffBSz3g8bNhdY?=
 =?us-ascii?Q?sjHXQ+pLMR8viz/xNtLHnfPLFO2T6ig6ZE3F8/3sdn0OyGhyXX1OP79g5P0z?=
 =?us-ascii?Q?94Gvp/jZ+9Hcd7YbJRItRLtVdvbuWBvVIKnCMCY/q3249qRW3ZrF/RKU+dwg?=
 =?us-ascii?Q?eenc3v9PrEh8Uu6GgEofLogPXl+fxEBmezkaJt0hn/P3tYqIcqHY9bVvdWLW?=
 =?us-ascii?Q?BRTvC592xRLzBC89mOryI+rslvtSpGsYLdjLhbVNQ33KHn9Mxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YQtuohlJHDxy8B6QI+xhfbEt5BXnMkXvYs7CTSzj1wEECNqR3Zhoh+SR8J0?=
 =?us-ascii?Q?GYI8vwtBGL53JCx3BF9Ub1RiohZe4PTmu0M4ESbcgo00A2FMawfjh1Q7ngxW?=
 =?us-ascii?Q?dHFOQcUIsJA2qrQ1rAC7/se+kctDcwPiG/ESJLAYty/M5hhh3RtKPT7IoxA9?=
 =?us-ascii?Q?CCYu6pQ8H/EURsjVPkn8ZBYf0odkmMtXZYtwO2nvdNBsm1g/uYBV59HilleE?=
 =?us-ascii?Q?1YfZv5eWYsmhC2vQsvDyDRDricP0UAlJwCsDSXNMhiF5aCoy58LomoK2AM63?=
 =?us-ascii?Q?mXSwVDXwhzbL8sJZowOuChpd2wrddZTSekOMddKXLyRy5+CGMKY7Cs80kjBT?=
 =?us-ascii?Q?gCEF88caf0a7JpDPTtVK9IX8TQLcJ/o1ApWssklIsuG7ORFHw21Q/PxpR+GX?=
 =?us-ascii?Q?1eUGEfylUUh3REpclOfOaXyoTPiqd+8FYdFn17jQ7swqcb2hqAl/emtAi/Nv?=
 =?us-ascii?Q?v+WHbBH45u1HlhdilEQtK5aLNEGC3mErzrmb6gXR6BKUbt4iYw+rNhP+hgL5?=
 =?us-ascii?Q?kl01ZO1aIDNvNfpTQLs0C+eFbFZiaTMZVd1Ysq4FoBnSjaz8KJzA+GTOiLx5?=
 =?us-ascii?Q?Y3kAR86d6gUl3iNUr9YTDpN1/I4Ka9OlEp7JmZsf3lHEVzfZQFRFzjPeSvKi?=
 =?us-ascii?Q?3z5q7NnXAN6GdNLP24cb1QPhiGMD6MzWJhfpkj2jchXzD12QdLGWC8cQmzjX?=
 =?us-ascii?Q?LrpBAHg9WgmVHMcx481TVYUqP+Y5Vx/bTideI67hGCL0LOQn8sv3i5zm1kY0?=
 =?us-ascii?Q?9JDwSwSj/P7oIUFeogLqhS48fO+QaXw26f7LWWMwv9dFeT+35Q4+v2vgnkuu?=
 =?us-ascii?Q?bEm3UWcWQQZOffN+EZW5K93mul/oZdwQAvcipab0IfnGdBQ7E7BbcZUdKKee?=
 =?us-ascii?Q?dAMvfqpa8r5qD2cDhduJo9wrgNsnAIkIqjs3lGy6fJf74LdVni2x9mXfHCuy?=
 =?us-ascii?Q?vBIZ29tjJbm9J7YjRwCQZNVLq6hVhLeP1hWJD+Sl0YKIHCJ4S4+Ud1/k9cDZ?=
 =?us-ascii?Q?/oSh2YIlWXqv83FlkGZ7bddp61sjAzq1isvExcEt7bx+yJobpXHQDPPzrfE0?=
 =?us-ascii?Q?P5uVmK38GXJQQ6lDy8FAUEIkkb9cG12G2Vdsa/0WoAn4ulPDp3qyAgBd1UCL?=
 =?us-ascii?Q?R2uRj/+yEcsu6nzO6K99aU78nMc630XmWBZ4H1V2LX/B3kUpUdTCA7QHtz7m?=
 =?us-ascii?Q?FI9kdFAX0nh/oWkH8JTKwioYmToe1h48Vyf+ktOpgvVGTpm4LG07cvDOssJP?=
 =?us-ascii?Q?qfa4GYZeOiwCd2pbJGEJYbCX23k66RbEPOfiqxc0kvMWPTZXm+2ZJFfU7VhZ?=
 =?us-ascii?Q?jsi3qFmhKhM1qY300rFXdBTIbRD4w4WrYOcDUFnmQr8xPGhVicebHHy8pcVo?=
 =?us-ascii?Q?HgGev+vR4nCdS4klfuXyOLtTcW+1Mksy5PIc+OGFOJ7JjmkVOYF1UVLEKcGX?=
 =?us-ascii?Q?hqAtGolk/wUctjxmLz3Csu2vCVuA4kBW6fapT3ZI6E66wQOTbU/CLfdytOJ8?=
 =?us-ascii?Q?j0YNj6/AkP3p5G+SlvPWWfRWHLUzvMsgQvHkA5e8KgUlnA6085b4pJJkbT8Q?=
 =?us-ascii?Q?WHNrxgnEY3JkJlC/fF/FmMrGJgDpYZLgF+hzU7tvkL5Zoj7mlLPLcRBDX5g7?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0sUiWhn+Ce+yc5OBD1t35ou3BNhXUjGcJOB//yk61vAYkN7Fu2DkUQIhB93ZLPMb3RP3X5YMhGfC7tM1xJ3HFIyjgXqJhB8bDoU11rpEUQRcskG5Nd6KmBxH7mYopWFJ2rq7g7Lfz+5BtM1th6UIEs11Cw7vEoqVYb/3GiVZiI3hJzcMrg1lQMi6c6OHpYM0SI5h0QvqKh0ONVFJP7xySQOkLfTlaQFJkeY/qIpyFefB5k9nc97cDzLYtb46uwa/GUfmYfHX+tmGfA7VbYQX4StjpdGC/IRkECXR7Gj9P3TtpXtgO8nSDJIKiGavuXsQayugT9YUcS/GX6leVRJisTmfe44ibFpJSwPZoHpu+qwrm12MSdqXJft1DMVgc+RfYVnfL5rnhfN0ANR7PEueakX5B518BCyK9YG3e6cVAMqVcIl3thBPaxxAzcqVHetAuxzMAHmEjXKXjCJh1vdKb/f/xFvIDGiDO/LeE6ngxKpEgA1nHhT7IWOCNCv640dx3glbAbIhW0J5zpw+ekuL2cLnkRk5E81N6VT9wS98+78HXQl5nC4UA95DO3cIRLjEAnmo+2KqLrbWqa1GkOiHJE/9wzdsJ/SaHTmsvo9WgVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdf48b-9033-4c8d-2cec-08dd9894369c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:20:49.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk7K5vb+3KDsXNvY2pErdOXtoN9bBdFL4kbbDXGGGL3h/ZBDfPmH4rUDaAmWO1y64n7YXdtenu3vUoK2bp94IqvK2p+lgJtUDOFXMLEOBlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MSBTYWx0ZWRfX8YKOxv4ZU5ZF NMVJ0ogY1UxUTvJQVDGUUegdRXvznoIPGad2H05p3Lg/gp/D3Zaalo3dUaYJ6K/NB2PHSEPYNsZ eCQDBYC2FoVvqirH0UCqS2Dn6SXzoEYdA2+/z+IpTGsf2tgNhFZiOKLAQqgtfPyogkSeoQTEIk5
 0BkXn6+JEDgZ/VVb/4MwiDK3JJ19FiNAgDwP53rr+WS3323BebG4xU9cAkspODR07GNYRK5uvR2 MhQ+RY74xKUs54K6+sNPOrFTetD7o0L16AhdyByqp5PQ4FtoVuuBBtGTI17LzOYkKG8vMCAykO0 GdDjML8v22LJn+vZn9nTGo2FhdHYp78ciSW1+pYBXmKoLHwkAYi7FSOCaaz+qzRP0maAvbwNRkm
 kWSVyB6aqmzXPal0FSTzlvNHULwbYoH28deGxJOHZO5rXWw+nKHahmOQQSsBfU2KftHz0a+H
X-Proofpoint-ORIG-GUID: kQ2SArx_1JMgu3VMnMYqi185wR64usHm
X-Authority-Analysis: v=2.4 cv=GsFC+l1C c=1 sm=1 tr=0 ts=682e1985 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WX__GcUTe9ZGzPOcXVoA:9
X-Proofpoint-GUID: kQ2SArx_1JMgu3VMnMYqi185wR64usHm

Add test to assert that we have now allowed merging of VMAs when KSM
merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).

We simply perform a trivial mapping of adjacent VMAs expecting a merge,
however prior to recent changes implementing this mode earlier than before,
these merges would not have succeeded.

Assert that we have fixed this!

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Tested-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index c76646cdf6e6..2380a5a6a529 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -2,10 +2,12 @@
 
 #define _GNU_SOURCE
 #include "../kselftest_harness.h"
+#include <linux/prctl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include "vm_util.h"
 
@@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
 {
 	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
 	ASSERT_EQ(close_procmap(&self->procmap), 0);
+	/*
+	 * Clear unconditionally, as some tests set this. It is no issue if this
+	 * fails (KSM may be disabled for instance).
+	 */
+	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
 }
 
 TEST_F(merge, mprotect_unfaulted_left)
@@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
 }
 
+TEST_F(merge, ksm_merge)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+	int err;
+
+	/*
+	 * Map two R/W immediately adjacent to one another, they should
+	 * trivially merge:
+	 *
+	 * |-----------|-----------|
+	 * |    R/W    |    R/W    |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 */
+
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Unmap the second half of this merged VMA. */
+	ASSERT_EQ(munmap(ptr2, page_size), 0);
+
+	/* OK, now enable global KSM merge. We clear this on test teardown. */
+	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+	if (err == -1) {
+		int errnum = errno;
+
+		/* Only non-failure case... */
+		ASSERT_EQ(errnum, EINVAL);
+		/* ...but indicates we should skip. */
+		SKIP(return, "KSM memory merging not supported, skipping.");
+	}
+
+	/*
+	 * Now map a VMA adjacent to the existing that was just made
+	 * VM_MERGEABLE, this should merge as well.
+	 */
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Now this VMA altogether. */
+	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
+
+	/* Try the same operation as before, asserting this also merges fine. */
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


