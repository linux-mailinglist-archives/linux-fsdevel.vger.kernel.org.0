Return-Path: <linux-fsdevel+bounces-50087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD70AC8192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372DF4A5835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909622E40F;
	Thu, 29 May 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfSyOgB+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xXnt+NxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310B23099C;
	Thu, 29 May 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539000; cv=fail; b=l1/PkNbMnrM5iKQtcxvjfr6/ea+2XHCoektpT7G5uYgvOmCmu8IfYByV81dGTzS/rEyidmzqGaSJUAq612FegGq0tUNaAP8YgmEgTQHQNh90EEyPUmOTyIxzqptjvsOLigT2TO0jRZqu3T5xcBInENC6EGTzEFbBqcN7tKE5d4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539000; c=relaxed/simple;
	bh=2OD1UtQ73wvRxYPiM1a7xn1FVfxBSxFFaFSVzphHTkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soi6wCgjfEfNqh2javj158bb+aHF8QBZQox7TDvpI5SEwI9Ly/cIBBUAB87rsPsj48DFCmtoL4Sn4Mt2MajIiL481je7Ey/QmJIDkdvnkI5VzLoQ4t0K1/j8dC35AAhJNrO+0SaKDvrMEIhM9JBxmmDiI60eNtEcExnHsigPEmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EfSyOgB+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xXnt+NxX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfqxx014972;
	Thu, 29 May 2025 17:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q5mLcYX5F1FxHdw65KNsqfLJbpFl8wkfbNCp26qhXrg=; b=
	EfSyOgB+ese3FMJuAWHheZPb2hvioLv1kgm4a/HlO4w2F+8vJAZwztCtON2nd5/L
	Bpm+kQrjGAfK2KDJDuzCc8mYOFz/VryzeDDTOPl2PnBQs9t2jG9/65f9q/3qwvXp
	Zcoy8HmmV+PAitwM/599urIDDFENpaNcF93yiHvwYtPjEPMR1Q46092qUrnzQhpY
	2HtcRSu73cUfuQBoOw21rVpmi3Dgg4GnFcHhNI8/qDAxEI9WkQckXEyP8t4v53Vd
	Krjn8VC+H/Ar9Llp2bBQcSxbra32Rx9uceIr4NTtxbJfqcA1Jruh8MaSwv7kkp9l
	U0tfsZa5/c/Ov/nezxFhrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s8j93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFr56T025467;
	Thu, 29 May 2025 17:16:08 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jjfrtc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX5wI2jratcO3CvjTeBkgX/0rkALAu4bEo/+AN/F+DDC2BZPudSSTjVVyiJq1MhPeK5/RSLXpb5sOx04re47dwC4kcWM1JAX9YD7Hlvnwq3+SBqHLwphbYfmBFAG8YGX4DeXKVarqldeuU541z+4Oacf46voekAln/GIprIuwwAGIUvu6R7AUwje5aoQzijCnehNuzC+DZI+iZhkjtK5/PLNBcZSSrOvDvdUK2QnHtvAsWGEuYbgo2yhl8BLrASg/pMWtyqwk2UmYkX66ZHrvj8JDKi90BU342Mj7lH1t9jpaSiiUUJEgTnhyzi2ONlAw153p7MAxr3jY28N2RQN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5mLcYX5F1FxHdw65KNsqfLJbpFl8wkfbNCp26qhXrg=;
 b=Qux/jWJvKfSUF3Kqjfo3itIE3JJ/9yBFyQIPAxxTM11IMqfUILPM8eniv7ypvvYf3/DTWTBFtgI6hBJcgYirt5v24CSic9vxqHEJXSgrZj7bdp1BQbJTQwTPloUFiQRfiA/Pxdfh00upNO244BzghHmb8WuHpPL5QDAb4AC52rslp6ZXrtLAD9ajJuCI+CE6zv7np5sv9K3Lz2dhNMyOqoKnj2t62SSOfE+DRMee9WZlOqnlzwFubsY4QOFvfgJ9KOmR1cmkwJv3NP3U16eKB1kjnwDl7t7xOyLZJSzcAkQsqRPsQY5tmUSeaYpkxV4c+T2BJr3vWuRT2bOJdaemgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5mLcYX5F1FxHdw65KNsqfLJbpFl8wkfbNCp26qhXrg=;
 b=xXnt+NxXZK7n0ZdxAEKiT2HrF3SXKGzIxOhkqL5eM4G2Lrq/FcqtxhYCYSLJDYavBPol2YuVKiiRv5QkHAOsjkzBQgm5cIYjFjlzmDUkm9P0pAAyunoWCGVOmOqill8UpTj8ZLUyB4+QszATxXMoBY5awlYs/EVXjXcegyl6R2k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 29 May
 2025 17:16:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 17:16:04 +0000
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
Subject: [PATCH v3 3/4] mm: prevent KSM from breaking VMA merging for new VMAs
Date: Thu, 29 May 2025 18:15:47 +0100
Message-ID: <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 793c5490-c53d-4496-5d5b-08dd9ed47e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGX49/ON8WpEesXp+qAAHW1JoaJ3lbUbKzbGzfCaDXMqMm+/MepYK1TjYwR1?=
 =?us-ascii?Q?mMloVae1x6pebw4XQNh8qZ4gxl9DRYC0S/rZCc44GXgMmV01MMmIVvmibN7r?=
 =?us-ascii?Q?kadGSJ9tYO0RpHuRlK+eCe7UH+5ED5c1ek8K5QD+Mv6uxSXv49Vm8prbwToi?=
 =?us-ascii?Q?9kTF+25xDdNXwV6vUfCMbPVIKRZi1EXRhHQgZX6FAeK/ToRVhjzrd1Sco53p?=
 =?us-ascii?Q?ZIuoFCOn7I3Jc7L9/O6F9rVgiyI/gEamqIh0GFO4Rs9dWxKwFETBygz6GV11?=
 =?us-ascii?Q?eRwxiqEVetU2GbkvPEBlVJQgrZhtutYEeopcnbmqV4n70YS+5SaNX56PciEU?=
 =?us-ascii?Q?Sq33koZi4+fk9Vy4x4dhOVEsVCZDSV/EGCVUtnJ+cJCYeLaeed6JFcu1iVKw?=
 =?us-ascii?Q?5dC/KopZxVTzISXsUlTfqPhvpVwHjIYb4rfnmPAVln03UlAYXCm9SfCbGluJ?=
 =?us-ascii?Q?mLyWOIv2UJo/o3l350sCJmBkHhrJF/NO37MO99biaRLxNpU/+KvAUZakM67O?=
 =?us-ascii?Q?E5+xuqEOMwzZjZrZdR5v/UQ6nSMAvZdUbSbgnMvMfZJULW9uXJ0553zyEZiU?=
 =?us-ascii?Q?44AFdwUpojjsUy+XE5d2DaR7q51w2TsgnTKSsp1Eomoi7NGzRVQPNvQ2B2pg?=
 =?us-ascii?Q?fCSopjmzcvUpZ1Rx1RmKj8l4fgyXrG0B2yFOdLR9SZyExpc8UVwvOZq0ndAA?=
 =?us-ascii?Q?wX8vi90aafdlmtF7kGTtA4/Z8rjnuApmXHIJ2vPnY+iLJifVHM2vOCX4pewG?=
 =?us-ascii?Q?6xfo2iRu35kj62ZaaUSnOAD6narLWwU24kayHo0FO/e39Eft/eLMXgwwG86X?=
 =?us-ascii?Q?BJ3y7JqkdsbGen2yG+mLv3Ba59SP2WAGs+yKU0/KL/WfzrHNCbkdfD7VKXyp?=
 =?us-ascii?Q?gNl+KI9OUp/t0tYsdd5XpIN6rFmx2Xr4+nJHf7nmhebS91WJaps8NI2/SxU/?=
 =?us-ascii?Q?ZKm4i1UdUQB0mitENXX7cL3+8562zPc+11dqF2ERfq3BA8hKpZOLfQkCnL5g?=
 =?us-ascii?Q?tMhT8Aw1EK+lQhbLz4JE61pF0y1p/kHDvXHj1CYPLOxHSjyCNcLniAahrmQ5?=
 =?us-ascii?Q?uPVNsx3jvZrrlba7aqtMIHWKicde0Si55kQK/F/xM768CDR/SOgpge1epxMr?=
 =?us-ascii?Q?m9NyEWG8y0PYYCNsTo4cQNCiiql8jNxVbVxn2gLzQjB5ZWEYRA8B1aXaNc3F?=
 =?us-ascii?Q?tnrPy2Jn3H2p5w3zeWxxF9tNVmBhfyTzRidU8qC8vb7tkRHgDhSew+n/w13Q?=
 =?us-ascii?Q?77i6a79NlsRsaSyA/HEqVy5BWinrRiWVTANc0KsuNZfglPa1lmruJQbmI1H2?=
 =?us-ascii?Q?CQbX3cGPsYMJCUbRXhStW4jI8KpoS1jH6gqnBcN5/N0Ug2xac64apei6d6l9?=
 =?us-ascii?Q?PCQryy2jKTLvxthtK9h8WoPSTIs4h/Lq0ZDd2/M+3+DdzvYhtgMXPvNAX4JF?=
 =?us-ascii?Q?1jqErZeUO+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIfDvBcCdhcOU3iaSd4YyqiDfdIjMW0wDUkqxYJdmP+fRywQuU0BVSFboH3d?=
 =?us-ascii?Q?jpEWBIo6vuxHJXBeC4LZnWcfO+NkxNEwIOlrkD55NZsvmdtrJ76/R5nuqflo?=
 =?us-ascii?Q?3StQ1SPNlILC6wTMeBjVzkrqzHx8H2ULGS8PDjgFyCYzaOL/OsxK8ZOqQYZx?=
 =?us-ascii?Q?CMyYME5nQvzySJeVRollbbD2QC8iqdjrQQwTqaSwy7SHblh0A1y+Mgu8hYQJ?=
 =?us-ascii?Q?jnOATatEt5vECjnzeEZAJiRuUzwTDf07M9YgNRxiYC/lFI5RHq35PuuahkRA?=
 =?us-ascii?Q?PKxHU+4NBuvBkfUTsgSxQ7Ei1HF5pYUb9uu6paU32mS+OBETK/3Og2oQe30Q?=
 =?us-ascii?Q?ebnrfN9eS8FbEJbQADXmWnZpMhS04TPnVERj54X43LMqR54N+Sjd3dRnAgJc?=
 =?us-ascii?Q?ZEf0I3G0xWBFjLY+I0Tt73991T2GD5ckGgcOmQSwkOMyU428y0k4JITAGTaj?=
 =?us-ascii?Q?hqvafVtPyiP9HnXKUwar59EW/NxRXDbc9ipE7UTSdD3UzkK42lAxfoBVB9d4?=
 =?us-ascii?Q?rtd5vQ3wIP4JH/HQbMC8B+pMWm/b9xM/z8vOOoE6qlO/W4g9hGDcnLYHF1qQ?=
 =?us-ascii?Q?Xct55SprC+INXsytfIhEe7TTxrLkmhTwm334wzVtw9e1AQSJxSXBb0oPlJdY?=
 =?us-ascii?Q?JCRNK22eOIwuPTtw1ftMKRZzM1y1q4xGxLnuMPjkM2D8TaPhVGfHPy7EH62q?=
 =?us-ascii?Q?JtpuOuOSDgVhS2txKxehOVOXniWC/Rp7mX1aOF2FcsVlagCCx9AuWHkZMMnS?=
 =?us-ascii?Q?9mO18wknbh4sankCMw1Bpnv8RsAah2TK6e8Wew3nCeOkZZG94+/MdF+DumUJ?=
 =?us-ascii?Q?sF2N/k7PY9PjFqzInHMq4Z0Uoj7K/bRAjV1FVjbUjtGwNzQ1ujHbe9Bl10wa?=
 =?us-ascii?Q?ltTzNXX7xDP4zMdnqriVeYhIfWhnOfRDBTds2ZJ8lvSl74zVFH0OfDhPO0gl?=
 =?us-ascii?Q?4KQ6AyWJtUMxB5aa302Bu+iHJfEO4tiNSQE01wkjzjR5QKsbmpifLqpRrOzo?=
 =?us-ascii?Q?4HAtOWitSw9Yq/kSDujOofXRkus+Xr5lH6SO4KTLFs3Q8leLVHPXMS9PSktL?=
 =?us-ascii?Q?Z02LjN3k7q3TrgKciZfGN4FEu93M9jmOwolnjJpOV8iqXMCkKgmvBP/39efJ?=
 =?us-ascii?Q?0xt8JK1DG/5W9hFfe7tfxyhnjjiAsBVNvWA7Mm+6UyeFxa1Iz+pzIYJqmHKN?=
 =?us-ascii?Q?jXIEgdQc6E3vatNhRGR9W6eoC2wvDUsy6TbwGBUzIu68X8so1ekv0j/Se7mP?=
 =?us-ascii?Q?j9Oe4aHrOyXduIJUk79/x/Kfl/YGNvDSf0728FThjRVM4EoQ8QI+deFucbX5?=
 =?us-ascii?Q?yf/zLMC1W4MWbA6yCW8DZh2FLg6IXT1tORY3F3LevetkJPaScyMKBxPLhaOl?=
 =?us-ascii?Q?8U5VCVxWD06ABmx4eMSRBYXedJm67d4zzhSdW7HI0vZsf8xaCBd8dvquBMkg?=
 =?us-ascii?Q?+LcWI1GCjHRWa+u5UWMfN7qb3zj4uEncneg0r+GssMyfQm41oPwK94wqlo2h?=
 =?us-ascii?Q?0ehtULpvduph9fnKKQ60Jlp1LAS3XAU22wtZxPiqWk+ovVcxO7f6AzeVqnLe?=
 =?us-ascii?Q?j2BPt/YR+FQhustiMrDyE+nY0wIMPYxlL1Br02Bb6VRfxTSCT+4sgeHdk1HY?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G3xlQ0jnbprPt4BPnLbhSfnzfxvyMVyWsX2gxeyXmfZbpuWK2BsYdt3niZ5n0uFHVW9gjYchsXJ4gYArGWElmypmlWTYkwdKfRgjymFbG8jangYjTsFMlzu6zlrtf1xToSECDYEFFYVNfnWPNXtEj2Y1NThsIOoUTkXvWRUjAqHuDMELJZ0KkzGcfHrTtpAq4WmCpWsGd///uD8WHlHvKJJrgWPGu1rNG+uqjRyPQYpYc8JshLEwC/zQLwyykolKYXym+iQVbNjwFeEc/MZphlfq9NgpzMBOlqfZTCTl2KeoRN6nw9i1PSdSyEiUINbuy6q9XIkZZax2cvTE9dYuNJR5z8CBo8HtoiGNv7pCl8yUIl3tqlLdmVkhpayvqLoj2gRi5RjL87GGfaEm4ZMKYsYnTXo8VfECUlvGMW1nMXhD99VAUgEEYCtmC9arQo8Pris8jBRJEbVuEtuHznhJpINq1URiMmCy6kkHRrbgGL2Tf6JWj0PibOKVXec5ku1aUS1BfcWD69F47Tgpa9O2FSUSfWhVKQiOWqSsrD+aaPwWvnFG4H14R+QEYYLYvGDVNoEgg3RQpCmZDdkpXaVaqvpevxM85ZlMOVOJUmnWp0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793c5490-c53d-4496-5d5b-08dd9ed47e6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 17:16:04.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDP/4bRGtfW6d8xzrY7n3+6atCauizYvSuhnR/aJs9ab9MZKzTyp4/DUL4I2Yolp+J3E8CuJJKVfFxuWpWdi4Cmhq38xbgPjRKEJ4VRLGCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfXyds+4ckxqtD9 VkMiWF8HTh1gv0YrQHlN4B6Mtf8HzV6Y49roH183w2jI7XldX9TiopIb5Xw9dDABVR7YKJGAeCv gyyKW36OVPdT8xJAZ2Rr8MtQ7gAAffL+6eJZ1biPL8H+vXc3+Mp0AB2qf+mMTAAe4xL3yKVW6D4
 GZD2X29wi+s9QtarV5Ov95hG412gQ8Fz5lQqDCndxvxAcHEwvdaSC/TLc6Nf2gqdrJQP47+R8zE GgtzWzVzYKIUxi4O8UQza33cJ6uXo51k/5FC/FMqjUihyg0IZVM5rymOB/tFqacrVaktnRHfLV9 q7LhJk+JMhz+ZZR27qJQoUsvpEsnS9KG+ppCO9Ghmz/Q3x7Y/V3zKmmq4cghEAVvs8EIfOZZ9b6
 W7RVL676B6OSaakW7QT/pn5BbGGuz6U943N7pLfME8hZSakgX6Ywa8UTL2jNDGnJCggI4nVc
X-Proofpoint-GUID: ho67eIDdKqZQA2XUrwtOJTLYhCeOAVxR
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68389658 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=voKXtF2y4SdawcW92igA:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: ho67eIDdKqZQA2XUrwtOJTLYhCeOAVxR

If a user wishes to enable KSM mergeability for an entire process and all
fork/exec'd processes that come after it, they use the prctl()
PR_SET_MEMORY_MERGE operation.

This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
(in order to indicate they are KSM mergeable), as well as setting this flag
for all existing VMAs and propagating this across fork/exec.

However it also breaks VMA merging for new VMAs, both in the process and
all forked (and fork/exec'd) child processes.

This is because when a new mapping is proposed, the flags specified will
never have VM_MERGEABLE set. However all adjacent VMAs will already have
VM_MERGEABLE set, rendering VMAs unmergeable by default.

To work around this, we try to set the VM_MERGEABLE flag prior to
attempting a merge. In the case of brk() this can always be done.

However on mmap() things are more complicated - while KSM is not supported
for MAP_SHARED file-backed mappings, it is supported for MAP_PRIVATE
file-backed mappings.

These mappings may have deprecated .mmap() callbacks specified which could,
in theory, adjust flags and thus KSM eligibility.

So we check to determine whether this is possible. If not, we set
VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
previous behaviour.

This fixes VMA merging for all new anonymous mappings, which covers the
majority of real-world cases, so we should see a significant improvement in
VMA mergeability.

For MAP_PRIVATE file-backed mappings, those which implement the
.mmap_prepare() hook and shmem are both known to be safe, so we allow
these, disallowing all other cases.

Also add stubs for newly introduced function invocations to VMA userland
testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/ksm.h              |  8 +++---
 mm/ksm.c                         | 18 ++++++++-----
 mm/vma.c                         | 44 ++++++++++++++++++++++++++++++--
 tools/testing/vma/vma_internal.h | 11 ++++++++
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d73095b5cd96..51787f0b0208 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-
-void ksm_add_vma(struct vm_area_struct *vma);
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
 int ksm_disable(struct mm_struct *mm);
@@ -97,8 +97,10 @@ bool ksm_process_mergeable(struct mm_struct *mm);
 
 #else  /* !CONFIG_KSM */
 
-static inline void ksm_add_vma(struct vm_area_struct *vma)
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file, vm_flags_t vm_flags)
 {
+	return vm_flags;
 }
 
 static inline int ksm_disable(struct mm_struct *mm)
diff --git a/mm/ksm.c b/mm/ksm.c
index d0c763abd499..18b3690bb69a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2731,16 +2731,22 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 	return 0;
 }
 /**
- * ksm_add_vma - Mark vma as mergeable if compatible
+ * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
  *
- * @vma:  Pointer to vma
+ * @mm:       Proposed VMA's mm_struct
+ * @file:     Proposed VMA's file-backed mapping, if any.
+ * @vm_flags: Proposed VMA"s flags.
+ *
+ * Returns: @vm_flags possibly updated to mark mergeable.
  */
-void ksm_add_vma(struct vm_area_struct *vma)
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
+	    __ksm_should_add_vma(file, vm_flags))
+		vm_flags |= VM_MERGEABLE;
 
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
-		__ksm_add_vma(vma);
+	return vm_flags;
 }
 
 static void ksm_add_vmas(struct mm_struct *mm)
diff --git a/mm/vma.c b/mm/vma.c
index 7ebc9eb608f4..3e351beb82ca 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2490,7 +2490,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 */
 	if (!vma_is_anonymous(vma))
 		khugepaged_enter_vma(vma, map->flags);
-	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;
 
@@ -2593,6 +2592,40 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 	vma->vm_private_data = map->vm_private_data;
 }
 
+static void update_ksm_flags(struct mmap_state *map)
+{
+	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
+}
+
+/*
+ * Are we guaranteed no driver can change state such as to preclude KSM merging?
+ * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
+ */
+static bool can_set_ksm_flags_early(struct mmap_state *map)
+{
+	struct file *file = map->file;
+
+	/* Anonymous mappings have no driver which can change them. */
+	if (!file)
+		return true;
+
+	/*
+	 * If .mmap_prepare() is specified, then the driver will have already
+	 * manipulated state prior to updating KSM flags. So no need to worry
+	 * about mmap callbacks modifying VMA flags after the KSM flag has been
+	 * updated here, which could otherwise affect KSM eligibility.
+	 */
+	if (file->f_op->mmap_prepare)
+		return true;
+
+	/* shmem is safe. */
+	if (shmem_file(file))
+		return true;
+
+	/* Any other .mmap callback is not safe. */
+	return false;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2603,6 +2636,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool check_ksm_early = can_set_ksm_flags_early(&map);
 
 	error = __mmap_prepare(&map, uf);
 	if (!error && have_mmap_prepare)
@@ -2610,6 +2644,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (error)
 		goto abort_munmap;
 
+	if (check_ksm_early)
+		update_ksm_flags(&map);
+
 	/* Attempt to merge with adjacent VMAs... */
 	if (map.prev || map.next) {
 		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
@@ -2619,6 +2656,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
+		if (!check_ksm_early)
+			update_ksm_flags(&map);
+
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
@@ -2721,6 +2761,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Note: This happens *after* clearing old mappings in some code paths.
 	 */
 	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	flags = ksm_vma_flags(mm, NULL, flags);
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
@@ -2764,7 +2805,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	mm->map_count++;
 	validate_mm(mm);
-	ksm_add_vma(vma);
 out:
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 4505b1c31be1..77b2949d874a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1468,4 +1468,15 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+static inline bool shmem_file(struct file *)
+{
+	return false;
+}
+
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct file *,
+			 vm_flags_t vm_flags)
+{
+	return vm_flags;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


