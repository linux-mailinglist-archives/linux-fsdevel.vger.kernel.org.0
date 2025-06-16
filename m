Return-Path: <linux-fsdevel+bounces-51791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E336ADB77B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3114188D6C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D2288C23;
	Mon, 16 Jun 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AimOaZ7F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Em5qXqoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D22BF003;
	Mon, 16 Jun 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093235; cv=fail; b=Ke+ztil7JwR+TzZHJe2xRrGCNJXWBtvmZCXSeQI9+YphMVbALJ0GKJ45WSAzXVX4mn7EOVCiQdeapplHLMeYvO/+805IjTFxk4wir2Ebh+N0OnEHSYfHixa+/R7M+yDCgauEfPHbltvBRx+rVy7VszdB/vcK3+XCMoDmRhu274I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093235; c=relaxed/simple;
	bh=Vw6I9sH/P+AfQ7z0WC62Nob8a6WjuhaIOLaJ6bis0rU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=WGajSREZ8B8a3Y4udnyF6QoDUPWB5TubCCckwG88dDqFcacBu+Ns56fZtpDydlCB9jrNmxUvw450zIUEl8uVP/QnjuAA+QP+6ugZ5CCAyX35lTk5DPJnwc/V8zy19bKm76fayCcabT4EeaKNemEMglxGKWGihQoHAROY/aSFvpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AimOaZ7F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Em5qXqoC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGtWqd020095;
	Mon, 16 Jun 2025 16:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lr+kMeFxWBl8Jfcpx9
	mJu0IDhIPmpJj7JWXR5vTBOWk=; b=AimOaZ7F3J79mIvuWy2bdJPL+EgGcxs56D
	xOVS4YP12jOUidtfFmlUDrOTJV9fmY11OtVSEdWCXcMTHtyT3EniGJMlKw9CuUWR
	va9SL8mc7riuwAWJKCXzLbY8w1VNwDYoKI279WjiSOlqY2s5dPry3l41vgDBjbLY
	jxciTdJaFjxxRfE/kHJ3XlnYAmC7JVKQkoPRZ6bcObBB44l87PfVmzvB/H3vg1pd
	KK/Hnh64bxDikVHCBx4cIt4IUH+mwU1lCVoHT8v3oXhxf2+DPjAPmVF7QesZ/Z+G
	uKi3StY9Hay154jksZtR5ktfiCpgi71OZzZzWTiD6dvchAxTPR3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxk62c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:59:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GG0XS9036359;
	Mon, 16 Jun 2025 16:59:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhep0cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrUYjNWbt6ITXtJMoSTzznwpRwIAIGe7L4HERpnAyor2m5Yo/Hf3p8VlAQe16DSeRkxuJjVeOMtf1mDlaK+GJAK/ShAUrnp5Lxd/OO6O26S+nP1cSGM3zlRu89GOzFpOUK8wUJsLebHe9DHBeVJzPFubPWRflkE45iHCL72rj4LmtcOJdf4EwhDCidOOAC4Agw4oJFBEidsLdGalt7c/W+y64bWGqwnmbsiItMSgF21w06L3Clj7F3SmiQucEr2u2QMusVX1FsFiAvx1hOt2nt2LqFZUKUcB/clcCZ3vwQPiXGODZsCVT53vMGa4+Uw0yVA0SGDZLBzRKng7XxujnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr+kMeFxWBl8Jfcpx9mJu0IDhIPmpJj7JWXR5vTBOWk=;
 b=PAQBadcVNEG3i6sd7CoucZnZApHUPLaan8uCj7GDbkKQLYNd2UIq2zr7pcGM3+MSgYPcXCE0nHFr2qpJ3FPnqLxGv+bX8SCvlneW+0r0fX3Qs5pq501ZRO8kW7fqIf7Z9ApeQANvHLfiaIB9NAPxhRW86owrnBzp3Esj6AR4bZl3HxcyW5EzHOUylPUSE3ientTv2Kr3NL65uucpdk9jB2OPlTG4cXpNy7wfwbfKHJEaKOJE8L7P8uiCdY0ej3AebLduyjg9ayOhQ6umCPAfczrKpcstPJThfGoZlSp8ycfpEb7LQHEM6mj/scdwGIBAtoOw2mM2scX+nViz+s1k4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr+kMeFxWBl8Jfcpx9mJu0IDhIPmpJj7JWXR5vTBOWk=;
 b=Em5qXqoCgeeZ9AV5hQ4B9jAYZi3M8IJ1LraVnZlolXUaLqkI3SO+8Ddgha6HhD09n9cLPb0fkKxLz+8GPGfLlVBOjD4mrfiIDSe7fdLtH1bS1Ch6iWXM2Qd5dvTTZTraAex7e10p1St5tkkWO4/2xlIJ3a92fTXd+jM+8pXokQQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA3PR10MB8417.namprd10.prod.outlook.com (2603:10b6:208:573::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 16:59:45 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:59:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Zhang Yi
 <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250616-wasser-replizieren-c47bcfaa418a@brauner> (Christian
	Brauner's message of "Mon, 16 Jun 2025 16:27:07 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ecvj1v50.fsf@ca-mkp.ca.oracle.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
	<yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
	<20250616-wasser-replizieren-c47bcfaa418a@brauner>
Date: Mon, 16 Jun 2025 12:59:42 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::29) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA3PR10MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: c847d5c2-fd94-4ead-2386-08ddacf730ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3hv0eOzKCBx7p1A1O9oTfYay/Tmpo1qIH/FY8w0STvHFPgoC/fuOavSsBD3?=
 =?us-ascii?Q?IDCHVKiSjJyy37jw1yhF6DC459STtzXDPjyuf3BospPnDsgH1JjTTAUoyprc?=
 =?us-ascii?Q?eTl/YfpR2o0N0GGzq7il9PsRiw1aflNY8hP58kl4QXDhFHd1M1lQvhYp+0gX?=
 =?us-ascii?Q?5nS7QRWP7DSJlKSF8ozEffwXskyooEScVItwRlTgaAQesb2C98kTY55+XWnW?=
 =?us-ascii?Q?liRiqscLPCarJ8dVaG7tE1YpvohsUSgfKK1DJ7P/3/YtJtxm3xOznJyXkfI2?=
 =?us-ascii?Q?Xm13DgWGRMU+QXwHqbBOBpjYjDD27vxASEb2tdGj2HKYKALWOJ2IXuWti+aB?=
 =?us-ascii?Q?NMav4kWwF5AorQsdOs9ZW3KJrG28RlwUpWMsqNYvaMoMDLtWXzR0irDBBhLB?=
 =?us-ascii?Q?0N/KuL6KVpE58PwRfpa/VLnoIXSZo5P5SjmPar6yadrS55JQHPOTguMpYJ1z?=
 =?us-ascii?Q?ckd7ycY8WxQKqU/oOtd3CANJEFpCim8jR1U3W03VEE3THcF2bsbNeNF6dztd?=
 =?us-ascii?Q?+BciYELQnrVEWdBQfM8hvtM3iNKEOk0bukBUw1CHouSoVrdPf6pF8ovGJb48?=
 =?us-ascii?Q?zMfYJ+mFunlziEPSqqonvFD8ibmm1eqmvuAROf0qptszmwbGIZOy1IO97hup?=
 =?us-ascii?Q?+RaYnAmx77DpfLUSddqB64+zU7FHurk/spdJ2eqtSt8Mcqhknj39fA78/iPo?=
 =?us-ascii?Q?S47xicbg59Yr7+tI32pwLgwZrdaE6N4LXqUXhS6CQM347ySS7LxQxXSKolOm?=
 =?us-ascii?Q?W87KMg83cwhy9Dbk+OHalDKJWvPQH54qDw2D5gMoaol7V9xEaDKVjr/KhT51?=
 =?us-ascii?Q?4PnzM6m7fzEYDco40jCl9JrZyHFNqngUG9CtlTCxTbKWO4lZC/0y2VwWnREh?=
 =?us-ascii?Q?qvmJ9vme4+RgFFlrkqGTsVX/UmDvkX6r0mwp7b5ZOHmVFS+JyNvYZeWpw2AP?=
 =?us-ascii?Q?Pa93YuZgoviVM/uucKTVdAcM/J62zKILq1T/o5NWMbQk8HHCqBxG6vPBXG5l?=
 =?us-ascii?Q?wkHcuIgX1ceuLiE9AwvBgH2F40+EYZnGzNGfIdPCEpE/yOHVNCj631F56Rkz?=
 =?us-ascii?Q?jPF93kyx8P1trJemaLdN0Tugy5cs370vkiwOANsauc1hrv9oMJgVQKPE/OKz?=
 =?us-ascii?Q?cl30m7KzIx9ljDyL6CJfW1xLQp0rE749Q93NWHHfa2V1sPmGMDTtkKKsRXsR?=
 =?us-ascii?Q?0p4ZxJfTFcAY8WtjQR1AXeU8La8XgLaTIv8Luw0QiAW0ltNSs5HH8J1uqPgA?=
 =?us-ascii?Q?DiCXc0vYPEvW+/WthrVLD0T6qwPzBDUxEtC7m2d63Eg7h9BkTWUmiQdQVAD3?=
 =?us-ascii?Q?P5RX8YA3rh23Qbo0JaEl6FSQ/MzGsB838taCXENuzK19cWLzcadJoFM0g7U6?=
 =?us-ascii?Q?DGP6i/OtJnW0BPNz6O3rWro7XJCE9R6VFd6yQIeW34JteQIO90+EzaV4waa8?=
 =?us-ascii?Q?Ie1XxruClS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sihuxFi5wzurRWqrFRo9zeonWgDjlvqJd5GDYYGieZvjI81HhBLgIWtXcD7U?=
 =?us-ascii?Q?zlAI9l7zwYsqRHityORhCZGQ/7Rjl9Hh9NjSK52YgHAW0gBuJR1HNIReab1Z?=
 =?us-ascii?Q?oHWFsW7g8y8xr2JYxXg6XcXSTeFFUL5ru9EUeVhIDxIFhmfX6JvBU2L6KiuK?=
 =?us-ascii?Q?eJUfiWonk2I0Wd9VF0LLmYfpPMuTSmzHuRUsfesssg//0p9YUEDBM2yEnHyp?=
 =?us-ascii?Q?sr2GQNEhT7WpXLZrstTud7vpjYMpR8YJwcC/4azg3CPzw8iPWlK2tpW7wrKg?=
 =?us-ascii?Q?k1/m3Z2RY8ljOeduf+FpkidEWVQjF6LLnSMQvazShZfD9weSiJQBbk3Tktkw?=
 =?us-ascii?Q?Fek/74KOVQ1yzrRJxP06ehPv4K2F0FI5t5vQrjVupp2S1d1N5/13ADM5wr7u?=
 =?us-ascii?Q?C7BhOfpxr4IlcZ4eKalwkV3BJ0lFfqEAwMKnlaXZJUCNbBx9KWjFZOB3LSXE?=
 =?us-ascii?Q?7/NaZrATdxJj3X8KjxUdMLIfhrNyNb0up3/91KvW5sFjuc4UxNahp8X5cd0T?=
 =?us-ascii?Q?7vjUwZY/mUP3fedTLjzuerGvCk6rCbzrahcDkmWGh2Rbr98vcMnKSc/3nbll?=
 =?us-ascii?Q?gVNxis4mj3mSoRBWoLod3nbKStz7W5OqWrJfhOi6L+vCKrXdrUZ7HwpTowoF?=
 =?us-ascii?Q?0gjJFbkk3Uw/EVsD7snfJJ4D/7h2rJOHQMp7dPiPw0VKsxEO/Aba+GUJDXLK?=
 =?us-ascii?Q?8OwnbH3xlFs6EkH/CdfH/3I5TuHJD8bQUZIvOAbPqYg8yeCOGmUuwK2Zmd+J?=
 =?us-ascii?Q?/pjy+Ll1gXVD/dj3jHWwxAH+brqUnxAC4QgOBJYarGJ5/SSHBlKDKiLG6Jf/?=
 =?us-ascii?Q?t46ofp4UVrww52cc76J2vrlQQfDA8qBmEXO09rqpEW47CpCnukb0VcXRcG2X?=
 =?us-ascii?Q?Rjo9ysMVcs8iJg+MTKlYtKDfyLj1wuN5PFBKMsK5oYb5HKVOaZ96eK942Q22?=
 =?us-ascii?Q?rwIUvBm3jwRxQ+4K9ZYUhDv9TM0geancTINDEthinyGI2KAL7mkz681Tg0q5?=
 =?us-ascii?Q?ykUoJFsT9Yyx1NBfPyZAwQvU5mQxepcotv9BNFjUD4SaD4Zp/ZGZRZBGImHl?=
 =?us-ascii?Q?r6A+AtdQ+FzBb5apXn8lRzDxUv7XClHt3olQgHUIcuOPtzHYoFV+1kgTVCKS?=
 =?us-ascii?Q?Av2JXndjtHTp2zWhI/ueN5f1q4AP1PEbR7HrbbLxYQP6ldFJ7B4QlZfvm6dV?=
 =?us-ascii?Q?kbzK8eXkrSvTsFVQcJR9SW5LlkxQsIAL/0PxUQeP2gFf13SSgVOX3WeGBi7s?=
 =?us-ascii?Q?I+bvV/Bre0RbpdRgzdrgmudc0MFeFtS7qnCuQ06j+1I+ehmwpwwSGWd286Or?=
 =?us-ascii?Q?dz2j81WUHFbwQlgijvPU9Yn2wblLwSd+lLAigl+PN5KZmUUc0gB9GIxf+wos?=
 =?us-ascii?Q?/KiaoSKEqwLyNurTi7xunjlrP+kDAh7vCzxtWN7mSquW3cbWzknLls586Cm2?=
 =?us-ascii?Q?51g5HTwWkz+8uC96IGaZ+IbG9peUIOIScB768VoIwFXCeArXDEiOKpQ6LzuV?=
 =?us-ascii?Q?o8FKAF2pEmMY7BzuH89Lktq9D9EJKVeyB+dMvVLL6li453bm0l4lY0rJHQty?=
 =?us-ascii?Q?urvDQ4K/y85C0LIs9E7hrpZQMJpNfqBYeppCJJK4z+d5y15ifL+fAG5G21IS?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzDVeLBooR7NtBpT7F3ezXB+vNKsoeTyt723z9ls9/5G3dYlkW22RB67wgMwmEalQhYG25kl2Zs8RlaKCbMVwxCNui4PB+MjD4+UI1vLIlzwwteEy56DPny5pex0RWuulGd1N7FWa4yB/cnLGQmutMNDQAWtz/8LmDXedJib5FpfgEaXg6kWP4AvI2v19084YuRSdDRY6u8xYTeMO6oTfMLoIJ0Rd2OwkOmEH+Jdgjl0mNY7ufrNm+iAl5XjBy04gMIZiOENQc0lB8ZiOy/KcRk2U1ZLJwFfLFTbxY9ONzvAN7Oy1rC98G0bT756QMmhiey18w55hpStuBrpKHY5Nx4XMsVcy4lipvfh1PEZN3qKwMMS8TKoZ5ElSUD8EFUtp6uPkDIKWULbREMV04+ePvwU0L7ys1vgZu4E8aGtUkm+8plSPQbEEMC8Ij2lzjk7eIcBMYk2HRmNRmAIq9xhGFDIv3UtzBYRvywJB9phKK+dald77qVhQ2lV5HGr8bC3hvKSWq85N+T8Am2KEsszgwJK5dlNodqc0rdcQtVSZ8CR2NPxcIX6dxbUQ5Dnpf9VJIrKWig1j9KX4mZeghCr9MXBoFHO2JNnYXzSL4nu2Ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c847d5c2-fd94-4ead-2386-08ddacf730ff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:59:43.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4sRYJqVBSxtTV1ykoHWJHmebWpCMGaCCrLXtTDoB/zK3Du8POKWAgtDrGZknrDxrFdocY0x4RLVmRRwrl2UJhRZ8IwR4KB95NChorgnXko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExMyBTYWx0ZWRfX8UzfH7yIj/gy 0etHR14Ny2pWW+gTsbxavN/GDC9HE9wJ2QaxidHmlAB5kw6F3u3sFi3e/IpgPfU3zHCiJSVpKQm lDNmV7ndSJyyqRgTVsSdCfQruDPfifuXm0q7Z8yM3O9hXHXzFiIoc+vi8vGE8EIBVokEds1WL1V
 o3tG9KZq46oCIlX4nB1+XzMFXGnrDzNKoYjvCl+54Kqqgba5A3zHEa0wVjz63K9xmN4eKuEcxOz /sjSyVbwdfktXBxO0dJLC1Z4SMm+KHMWdYrWNlMS6eqsTD3nCGdaYmY8p8F2qxCOsZmzETT9p8o 5wzLdjAopwy3jjXeKpe42+7j3/J/IcAnzs0OvRRhGE5rPvCxrOSFvJeQbNcoyTKM8sYAHSZEmHo
 GUAZE469kXH/a/21ap1S+hwlhMgZJgC3u8X6jdryX1JG5P01KfpFRVlYCmqFLEO9Fj4EytJt
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=68504d86 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=IOy5DzlU3eQs1KpyGJEA:9 cc=ntf awl=host:14714
X-Proofpoint-GUID: XjJle5KaxWlGiRRUDcew4-wm-RnwuIVy
X-Proofpoint-ORIG-GUID: XjJle5KaxWlGiRRUDcew4-wm-RnwuIVy


Christian,

>> This looks OK to me as long as the fs folks agree on the fallocate()
>> semantics.
>
> That looks overall fine. Should I queue this up in the vfs tree?

We're expecting another revision addressing the queue limit sysfs
override. Otherwise I believe it's good to go.

-- 
Martin K. Petersen

