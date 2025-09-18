Return-Path: <linux-fsdevel+bounces-62132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC8B854E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2EB1C066C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE222F747A;
	Thu, 18 Sep 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HiwF/9vD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXjhW9TM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133B34BA50;
	Thu, 18 Sep 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206596; cv=fail; b=Ec/7BIt6zr0PHvVS5H22uFqdKJq+yVu3cmd3wmbZgv19DS6vXRJu8DyiQxMfzSMAhg3QrtLmmdK86rNWd83HiWF8OlYMTuXlNJThy5vzpUoRFyb9z4WRKMshjyVqJs32pL0soHLKyXfmS5Stwr7hccS9ex73+IXQvkKs7Ea+rgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206596; c=relaxed/simple;
	bh=ER0Ru3XZe8GE7vTX+VrPHMveeN8FQZG6xU3gJdfRGoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uHPl5mGKhjPxwufdFK4JcFhTetZf4MH8zAiMXAdsYT2zG/gAk7oHTkdqOwJblou4RJUOYQjMtXjAtRq5/27yb3IJrpyzqJSzvRweRApQ3v6kJxRw14T0KGQCa3bRvnAMY+u4XgZz6gK6DQn5wcpJUxghdUWddcsYLFW8t+XNPxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HiwF/9vD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXjhW9TM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7gjqH019426;
	Thu, 18 Sep 2025 14:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nKdr3xtdGN6NZf88C7
	s+6fMgxPejCC5spdCwOojknrc=; b=HiwF/9vDXnevA39wLZGwVk2GPZQbSxVAQG
	Y+OIsFZ1GQ90Lf+0EdTUjbXoS9XOJ8N1glNpjZtpGpnwfGtYaFG/IwIs5VqZUeYR
	rbEBg8WxG6DZS5TZy/H4R08OhWpA4H3LtCzjXe79RmLY2iamsAlmXxxWPE/A0u6k
	6ykGPjpo+DWLWMm85hbTa/pYek2ISrUmb6edmpdqwyKYmwmxxiDoI7/7ik9Posxi
	ndi9AAnUE+PEbBTCvkfw5HB2agYUE6MGFR9Y/BmU2EuDD/RdwD+a0lR9MB6nTGlY
	StIItYmm/+vH/tSovD3LaogwPBtZvWYpS0ki6b3to5kbTqpvQBQw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6kn0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:42:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEOPEl028776;
	Thu, 18 Sep 2025 14:42:48 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f7rem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLNQeco3Z1yk+ohM8BhqmfuaY4is4jMo3xoMBxyYvzt+2UXQBEO8FhOlrftHcdY6/W9TrK0tpeNVeCCEvez0gqlk5lOxF5pJdsWZiez7XtySPU3eqRi38eZdcjyyCwI/ZaRUIKZfa37/jb3N9Qbj00e9pAUfdz5L3MZ3tsWcJwCol3fEs3W0CgV89J1u7AvZpv5onz6HUHy+vnQcQnEGS+iqcm5H6xj8vPkt7qu4WoLHA4R8nvNwcZ4KN+dceHveq6EbFOimqVie7Ac5r8iw+3beOm0ZPG9Tn3Nk1hM7SWhmal27n5cC+MDSLf2CrmCmPgkE1c1WMGn5awATC5hbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKdr3xtdGN6NZf88C7s+6fMgxPejCC5spdCwOojknrc=;
 b=ip4EXo+Bc0L0l28jxOxh8FL8xIK2OzsllmmjxzcuvhtRp98uNTFmAxMiVkdlqzaAWh3Z9jtPBiJ+7Hq6sC/XrmZMaOsOnZy5Gc0puoWFL7khZx6IuDqaEtrhvKRBHI7PdhuPgFCvaSLrCD1r5aFCQ1EGPhQbuw21Chi9cSJLAGVFws7+ys1FvSpwVn6IgnNDkv/BiRE3DmFX7qNrTqDXD5UBC/7YenDyWEnVi4Ao5RE3HzSxWXntSHs7AqMj3k54UiW+Ud5hvle9EBKAx595MGdVTCxZWrNxKvpnUlsrl2IM/krrhcM3tutXvzyoEEK1zErF/k5Ax981l9dzLtCcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKdr3xtdGN6NZf88C7s+6fMgxPejCC5spdCwOojknrc=;
 b=aXjhW9TMFnk1pw+yh1LMWVB56r+q9OpUTQyWBciuPBvvtuonXwh8N/sPOk+lfq1u+wp/sNM6bT6aGknkI4ZUgFygzQ9w4fWvPSA1hoef5ifR3YUk4W2did5j+bBNMYNBwJ7vXSaKRMjYgkNPTd2MUVvVGVH41UBuACpDpCfNowU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 14:42:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:42:44 +0000
Date: Thu, 18 Sep 2025 15:42:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mm/selftests: add max_vma_count tests
Message-ID: <b9b949d4-279b-4894-a829-9649e5f3ea9a@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-3-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-3-kaleshsingh@google.com>
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: c54e92ed-3d5c-4337-2854-08ddf6c1a073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODA6lqF1hDRmW8jbq75CyxvCaxycjlrktZXuBCQB2G9EoeFVUkSUZA4ukz2h?=
 =?us-ascii?Q?xtMwu4zTlPQjS8vCVM5St3U4OwVkZ/f0IQJv0SIlVruKibk9Mju3wZ7XiUOD?=
 =?us-ascii?Q?94ZgyZVBYhwB1Zpf1iFNJ4m+1235eOj4OLpNTbQHxW/DBt3KrVzbOu584AFR?=
 =?us-ascii?Q?ifBdidFqCa+6EmMAP9Tl4ImPrtm2kihLqWoEf5DsLFo7puhDQl6Zvkc3wnXx?=
 =?us-ascii?Q?D+TqRXGSa4RymubFixgR/uMR+0spIG4BysnO4ttoZtQ/uZ6stHoCGd/++XX1?=
 =?us-ascii?Q?kSxdMVjJD/8G4hkOBgKMeQqYQS0AyOgrcB15EPqX3vy2dlKPFNSJtvs3/ygm?=
 =?us-ascii?Q?h4mmeByjDIh4gk3vgBGQK3kB194x75YXrEP8sS0gqJbdV0PMFFQl1BNSfjOy?=
 =?us-ascii?Q?qyBy1z4SXJ6Ewq+XJrCSYS8GGpgkA9Z4t+9v58NU5XJgQ5jQGfJ8SjlOV3M8?=
 =?us-ascii?Q?In61+xBXV9GXqKq2AoxZPNiuVHLnaJolvpgkXvbImrQ8fHBBJ+JS0ZtC0Lb4?=
 =?us-ascii?Q?ZHKMS79grWP3mU8e3nIuww7lWH7HcTbNtbeMfJMp/lVNkRmCJr3cJvpblGJP?=
 =?us-ascii?Q?7q7Zr2RP+hbmMhnK9ZYz7VLFaV5pbGB/Ymeuk+NQ72eLKX091iLRpSOW5SqW?=
 =?us-ascii?Q?Vzz4VqHz/RAXnU+HQnYLuw+IuH/DPE+gNABVgTb39XKGiE6gM8DatWV3aar2?=
 =?us-ascii?Q?raL56cpiNM2o6R+GI1d5C2p3tUV/dJZEGiH4EF+Mg9mpbloMArT9FCCVEUAT?=
 =?us-ascii?Q?8CCvJJ4PIFMYxcBlxB8ED0ns46nGApkcHH8gOQSGpTRWbsBJm3NhVDKiCiY8?=
 =?us-ascii?Q?UQSwO778cc9h4cLrGSpBa+zFUSnqTgCTjUyE1Om0g0GU3nbz9aipCgte9bX+?=
 =?us-ascii?Q?q7+xkdwDDFgpirWQ3PzWoaHrM4gxbINJsIKiBKB84BwO576P7qQZsCwhCb9c?=
 =?us-ascii?Q?HSHCgLf+iP9RRj52Q/pmRNXSt2KqUKsXduxN/2A+bHiaYkBeQm83HuHXl/y0?=
 =?us-ascii?Q?GsLSoM6UOMGTh9ejGIL2llQR79yzSZDA8b0RPVWi/kGUTcFEAdl6MSa+QHAx?=
 =?us-ascii?Q?B8DHWecX2dcWKImbY/ox9KlZSN7isbUSnmboV9b08Yn2yVsWPVvNl6q9TAbB?=
 =?us-ascii?Q?TsjUfraiKO1laupRUfUYiWtOuKiJONk3AfY9dApxqJBaGRxscYPog/kfbxqH?=
 =?us-ascii?Q?+k3xdx4K/9g3ajcdS6k1e7B56vSGu7gt0bkLqQ0OFnzTc2G2n/DpKJTcmjdt?=
 =?us-ascii?Q?hZvABWXq+QeE/5/YBVDEmE3bTHzIo1XyYUo+A6P0zwC0R3pTED38wLCXpcoh?=
 =?us-ascii?Q?unzfJYifvyv94t0eazI875bL7zml2seqpQtLLkX4jO1i2O3vP/976T62xq/8?=
 =?us-ascii?Q?t1tie2Kiu1cXtWgJy1o13ZaY6AcR5ZmpRKBr/K8UTb2x8wPLH5siHivun5k9?=
 =?us-ascii?Q?LO5ivqRYt24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Fgs9NSWYAJOc8IA2xa7aMfY6qbS52YC5MWWgnQCpe603dnoWALXpha/rVbe?=
 =?us-ascii?Q?esholi71ysh0hH4RJ18jbLLRzbzrmjGweVuuEPm7DJC+w2WahyTwMnRpo3PV?=
 =?us-ascii?Q?IhMknTsIuUVZS1Vg4nVO3QeSWgdCSXOzysVNI+p77h6q5mnX3PFaiRl434tl?=
 =?us-ascii?Q?FgMS/ZVHdoK03omyHBpEUefRgBCWs+wcOXSFV2UNBKu0LU4AAnD6sdKAcFFc?=
 =?us-ascii?Q?UtEil3lv+z/c8YftIz9xQngcgvbflfwSC+LfxtHBXzZHswte8h1+OFlxbcEo?=
 =?us-ascii?Q?kpm5wwjHBi3DuKxoULAmL9IjOdkE48ku+hEsIdbKSQzKPzsMsqVty9KMjOU7?=
 =?us-ascii?Q?yVLHXqKzz7ileaSkSF58bU1iZfD7KI/dljbXAyrIRRVsUXnCKW5OcOMcxfMt?=
 =?us-ascii?Q?DXAKceFhncVGSyDaDavgOO7mrbcYDB5bH66G5YmX381LxJN8tNE7lmtkxb/1?=
 =?us-ascii?Q?+pDUpq2hy8VYx71ZhfEZKcrMJloRd8ZOLakJMYdJtp8b7/cJqJQE5nRt1P++?=
 =?us-ascii?Q?hxCQzedxQZrNbBNYNB2i5q0phM9lNX8qHeW8GJb2hJQDg7Fyx5Okzu73AJvv?=
 =?us-ascii?Q?gQmqTc8mQkLl6DtvRoMttO4WuSAlaUPO8lVpMbDBKmwG8OspIn9oZi8OynkP?=
 =?us-ascii?Q?hr3P2HunfTgfFKSp+PGpinXcTsWbB07/jtEkhaLVcrU/xKt4IE+ZLuJ6ZF5c?=
 =?us-ascii?Q?prREFZp3/8u989YiV8unr4ebw9fj9Dk77bq7TT4wiJ27pmC8sx5Up3fewt3q?=
 =?us-ascii?Q?fCT4j2WF5HTvStqfcsbNaqMMxdOP2mTB2esgOd1E5x/iP0ndGIqMy2ASN8/2?=
 =?us-ascii?Q?QAEK19ByegP+ki0O/XOTdX2N4IF1GaPHLogbP9BRl4aMUNXYQCb8rhnp2oII?=
 =?us-ascii?Q?h7x2UW3gLwcMs1krdPQOM5rBIHuKA5jTVow7X8FtOqPI030AgRaa5Smn38Ta?=
 =?us-ascii?Q?+6QnCgiw7shATrpXLOkFAXjKlc1S2p/mMG7sb55oBFmg3OZgmBjAr/LGKzBg?=
 =?us-ascii?Q?q5xBjjsD7TpDFlDkG/hG9Q/tVfsnjyfXlpj77sd+B4wMYLR+6LJ8PDVUGtxn?=
 =?us-ascii?Q?/gtV8NBVDnlbzFZEfDP9gd2+J5e3UwZX/E0PZfq3cED6Gq0e3QoxezfyBGAk?=
 =?us-ascii?Q?1OwCkBM7DfL0MA764pSAG5cTFy+1lclPpVkffPQAll9PZiDc4YK0pdqCVNMa?=
 =?us-ascii?Q?X6UYfwD0vxafYrcL72pwDxtRpwave3f42MKsRLLqYSUnrp482UbQJJbUMxm0?=
 =?us-ascii?Q?w0gyc+aArbTvcQDkMgAssoz2BqyTNWV0qgIn3l1T3iJSD5RW/Y4spcqWoVw5?=
 =?us-ascii?Q?IEtyo2mjELodGyHsv1d+r9ZxG8inUrfr6lYAiIRHZV+qeDLBvNLCxQeY4iOP?=
 =?us-ascii?Q?Imh7aRsR9g3G7LJj66YvLTGCJmRhxkp1S+Z8EtTQGqhM3pxBcT+Fey7RQ5NQ?=
 =?us-ascii?Q?O1Fl8v8NcTxlbKVf6G04jeMcVcqTO1chQIeBRJq6hrFSVtnohIGv5CF/AhsX?=
 =?us-ascii?Q?GX+/1hd5SbwQrspCrVXpgdi2EgYX29FwhFahEoy0XN9pEJ3vuQIj5LzsRo/x?=
 =?us-ascii?Q?Y3/Iz6uv7elNunW6JPBfO3/0oMZr3Se71XCtV2cx10yOgGolJjgVhlkYo1VR?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UQ+PGsrUV/FpRPtfZmSBORbNHXb+VbmXrPNd7EFcWD2Izn/LZZ0nt2O2Y7M98H+XErAZUpFSbUnGHJuY69QrwPAfwfTllG9xOrneOFW7IwHFJCVk2UUDmvJhh/+Pf+aToAkBHqUHRPL5SblZROIj2RRG+lwLwQ7pL/RBghDp7dBj9wwpHcch70+PP29Sg22XkvAwbz6KRXW02/n81oKIzvp8JnDwqn2aWldufDjkFOhrVzd5cQtznqfdiCluZ+mLEkIvL1GWsUm3n1/mVepYNtDvpdU5EYkiB0inV5TSS6EFFdbW/evT9HjMzFT8NJPOhz4IaIkxni045x9HgjvElIqJjDSV0J5ls+NMvsudKr19PWKj4cqNOV490vhvp16jm3PXFNYZTHKn1jyzHpjcyGUaZ55GqwFA105WHgPLf+QDSvNDML8vEwNAx3SqZ/nEYVA39dnat7CeC8r7mSyYljGvSAcwXcNRB0sM5tdgVTok+v+pmHxsejiiNbqwdyb9wu17T8x0W7BDBtYL+QN0wGmcK624Czf6e79lxOQovat6A5gzXgHRuCqVuC6L0exq/PG6cYN+iijFfnujLaT1peAVUAebzkHe7VAeD6XCp+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e92ed-3d5c-4337-2854-08ddf6c1a073
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:42:43.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjgDs/GFqY5MiTR+YepDLAN5QHpdYq2aReB4LonWJzuqh2TcXGnOLxBLFj3pgQTpK90MHvhnweIjGn1xvLv/yf2SrFLSM1E7MnZvNmjZwg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180132
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cc1a69 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=_QMlCeqSJ9HL3_Dg2ZgA:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: PISyb1UEm-HRWd143kaBEjD6VAhr9TmN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2EWnjdOgGBzu
 sD3k9SjwMjq/j/DsB2neDniVtmYjb1EwfHyfS+F/dCc0J/DpHDJ/KeCQhCiRY2DDxJ6I1ig5xT1
 Mnpca2DyjrlZF8iolGYyunWmH4etZB+Dq9ZxSanBCIQ3khz2NW4tOIOH4wgQxb1AZSQsU6oCYwQ
 mSzyHmdfvQG5/vv3Bvp/4M9sAtbZwevZXUds1Y24vI7je2NVKpTMTQuYFWZQD1W4ho3f05tjq4c
 8sEGU42sRR/6J4XgAtCEJvlUYalGrpgJCh34W/R1JQ8V7/kfglLxF4xvW4/hBqjh57UhIqyDMdS
 AvM3bbOxUmUMYY0Du1nHEgLgWZOhkPzKMrN+shZj6l6LJ1dEmXREaKVqaiRtLpHumNult0KtGFS
 22pIzB9T
X-Proofpoint-ORIG-GUID: PISyb1UEm-HRWd143kaBEjD6VAhr9TmN

On Mon, Sep 15, 2025 at 09:36:33AM -0700, Kalesh Singh wrote:
> Add a new selftest to verify that the max VMA count limit is correctly
> enforced.
>
> This test suite checks that various VMA operations (mmap, mprotect,
> munmap, mremap) succeed or fail as expected when the number of VMAs is
> close to the sysctl_max_map_count limit.
>
> The test works by first creating a large number of VMAs to bring the
> process close to the limit, and then performing various operations that
> may or may not create new VMAs. The test then verifies that the
> operations that would exceed the limit fail, and that the operations
> that do not exceed the limit succeed.
>
> NOTE: munmap is special as it's allowed to temporarily exceed the limit
> by one for splits as this will decrease back to the limit once the unmap
> succeeds.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v2:
>  - Add tests, per Liam (note that the do_brk_flags() path is not easily
>    tested from userspace, so it's not included here). Exceeding the limit there
>    should be uncommon.
>
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/max_vma_count_tests.c        | 709 ++++++++++++++++++

If you add a new file, update MAINTAINERS. Should put in MEMORY MAPPING section.

>  tools/testing/selftests/mm/run_vmtests.sh     |   5 +

You're missing a .gitignore.

>  3 files changed, 715 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/max_vma_count_tests.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index d13b3cef2a2b..00a4b04eab06 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -91,6 +91,7 @@ TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
>  TEST_GEN_FILES += uffd-unit-tests
>  TEST_GEN_FILES += uffd-wp-mremap
> +TEST_GEN_FILES += max_vma_count_tests
>  TEST_GEN_FILES += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  TEST_GEN_FILES += ksm_functional_tests
> diff --git a/tools/testing/selftests/mm/max_vma_count_tests.c b/tools/testing/selftests/mm/max_vma_count_tests.c
> new file mode 100644
> index 000000000000..c8401c03425c
> --- /dev/null
> +++ b/tools/testing/selftests/mm/max_vma_count_tests.c
> @@ -0,0 +1,709 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 Google LLC
> + */
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <linux/prctl.h>  /* Definition of PR_* constants */
> +#include <sys/prctl.h>
> +
> +#include "../kselftest.h"
> +
> +static int get_max_vma_count(void);
> +static bool set_max_vma_count(int val);
> +static int get_current_vma_count(void);
> +static bool is_current_vma_count(const char *msg, int expected);
> +static bool is_test_area_mapped(const char *msg);
> +static void print_surrounding_maps(const char *msg);
> +
> +/* Globals initialized in test_suite_setup() */
> +static int MAX_VMA_COUNT;
> +static int ORIGINAL_MAX_VMA_COUNT;
> +static int PAGE_SIZE;
> +static int GUARD_SIZE;
> +static int TEST_AREA_SIZE;
> +static int EXTRA_MAP_SIZE;
> +
> +static int MAX_VMA_COUNT;
> +
> +static int NR_EXTRA_MAPS;
> +
> +static char *TEST_AREA;
> +static char *EXTRA_MAPS;
> +
> +#define DEFAULT_MAX_MAP_COUNT	65530
> +#define TEST_AREA_NR_PAGES	3
> +/* 1 before test area + 1 after test area + 1 after extra mappings */
> +#define NR_GUARDS		3
> +#define TEST_AREA_PROT		(PROT_NONE)
> +#define EXTRA_MAP_PROT		(PROT_NONE)
> +
> +/**
> + * test_suite_setup - Set up the VMA layout for VMA count testing.
> + *
> + * Sets up the following VMA layout:
> + *
> + * +----- base_addr
> + * |
> + * V
> + * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+
> + * |  Guard Page  |                      |  Guard Page  |  Extra Map 1   | Unmapped Gap |  Extra Map 2   | Unmapped Gap | ... |  Extra Map N   | Unmapped Gap |
> + * |  (unmapped)  |      TEST_AREA       |  (unmapped)  | (mapped page)  |  (1 page)    | (mapped page)  |  (1 page)    | ... | (mapped page)  |  (1 page)    |
> + * |   (1 page)   | (unmapped, 3 pages)  |   (1 page)   |    (1 page)    |              |    (1 page)    |              |     |    (1 page)    |              |
> + * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+

I have no idea what a 'guard page' is here. You're not using MADV_GUARD_INSTALL so it's presumably an arbitrary PROT_NONE page or something?

> + * ^              ^                      ^              ^                                                                  ^
> + * |              |                      |              |                                                                  |
> + * +--GUARD_SIZE--+                      |              +-- EXTRA_MAPS points here             Sufficient EXTRA_MAPS to ---+
> + *    (PAGE_SIZE) |                      |                                                         reach MAX_VMA_COUNT
> + *                |                      |
> + *                +--- TEST_AREA_SIZE ---+
> + *                |   (3 * PAGE_SIZE)    |
> + *                ^
> + *                |
> + *                +-- TEST_AREA starts here

Can we make this vertical, it's obv >80 chars and it's kind of hard to read.

Also isn't this hugely convoluted? Do we really need to set up such a
complicated set of VMAs for every test?

> + *
> + * Populates TEST_AREA and other globals required for the tests.
> + * If successful, the current VMA count will be MAX_VMA_COUNT - 1.
> + *
> + * Return: true on success, false on failure.
> + */
> +static bool test_suite_setup(void)
> +{
> +	int initial_vma_count;
> +	size_t reservation_size;
> +	void *base_addr = NULL;
> +	char *ptr = NULL;
> +
> +	ksft_print_msg("Setting up vma_max_count test suite...\n");
> +
> +	/* Initialize globals */
> +	PAGE_SIZE = sysconf(_SC_PAGESIZE);
> +	TEST_AREA_SIZE = TEST_AREA_NR_PAGES * PAGE_SIZE;
> +	GUARD_SIZE = PAGE_SIZE;
> +	EXTRA_MAP_SIZE = PAGE_SIZE;
> +	MAX_VMA_COUNT = get_max_vma_count();

Dude we are not COBOL programmers :) What is it with these capitalised variable
names?

This is really horrible, please don't do that. And why on earth are you using
globals like this.

(Again) use the self test harness please :)

> +
> +	MAX_VMA_COUNT = get_max_vma_count();
> +	if (MAX_VMA_COUNT < 0) {
> +		ksft_print_msg("Failed to read /proc/sys/vm/max_map_count\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * If the current limit is higher than the kernel default,
> +	 * we attempt to lower it to the default to ensure the test
> +	 * can run with a reliably known boundary.
> +	 */
> +	ORIGINAL_MAX_VMA_COUNT = 0;
> +
> +	if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT) {
> +		ORIGINAL_MAX_VMA_COUNT = MAX_VMA_COUNT;
> +
> +		ksft_print_msg("Max VMA count is %d, lowering to default %d for test...\n",
> +				MAX_VMA_COUNT, DEFAULT_MAX_MAP_COUNT);
> +
> +		if (!set_max_vma_count(DEFAULT_MAX_MAP_COUNT)) {
> +			ksft_print_msg("WARNING: Failed to lower max_map_count to %d (requires root)n",
> +					DEFAULT_MAX_MAP_COUNT);

Probably partly a product of you not using the harness, but you're violating the
max chars per line all over the place.

checkpatch.pl kinda has a fit with this file, can we just try and keep it to ~80 chars please?

> +			ksft_print_msg("Skipping test. Please run as root: limit needs adjustment\n");
> +
> +			MAX_VMA_COUNT = ORIGINAL_MAX_VMA_COUNT;
> +
> +			return false;
> +		}
> +
> +		/* Update MAX_VMA_COUNT for the test run */
> +		MAX_VMA_COUNT = DEFAULT_MAX_MAP_COUNT;
> +	}
> +
> +	initial_vma_count = get_current_vma_count();
> +	if (initial_vma_count < 0) {
> +		ksft_print_msg("Failed to read /proc/self/maps\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Calculate how many extra mappings we need to create to reach
> +	 * MAX_VMA_COUNT - 1 (excluding test area).
> +	 */
> +	NR_EXTRA_MAPS = MAX_VMA_COUNT - 1 - initial_vma_count;
> +
> +	if (NR_EXTRA_MAPS < 1) {
> +		ksft_print_msg("Not enough available maps to run test\n");
> +		ksft_print_msg("max_vma_count=%d, current_vma_count=%d\n",
> +				MAX_VMA_COUNT, initial_vma_count);
> +		return false;
> +	}
> +
> +	/*
> +	 * Reserve space for:
> +	 * - Extra mappings with a 1-page gap after each (NR_EXTRA_MAPS * 2)
> +	 * - The test area itself (TEST_AREA_NR_PAGES)
> +	 * - The guard pages (NR_GUARDS)
> +	 */
> +	reservation_size = ((NR_EXTRA_MAPS * 2) +
> +				TEST_AREA_NR_PAGES + NR_GUARDS) * PAGE_SIZE;
> +
> +	base_addr = mmap(NULL, reservation_size, PROT_NONE,
> +			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +	if (base_addr == MAP_FAILED) {
> +		ksft_print_msg("Failed tommap initial reservation\n");
> +		return false;
> +	}
> +
> +	if (munmap(base_addr, reservation_size) == -1) {
> +		ksft_print_msg("Failed to munmap initial reservation\n");
> +		return false;
> +	}
> +
> +	/* Get the addr of the test area */
> +	TEST_AREA = (char *)base_addr + GUARD_SIZE;
> +
> +	/*
> +	 * Get the addr of the region for extra mappings:
> +	 *     test area + 1 guard.
> +	 */
> +	EXTRA_MAPS = TEST_AREA + TEST_AREA_SIZE + GUARD_SIZE;
> +
> +	/* Create single-page mappings separated by unmapped pages */
> +	ptr = EXTRA_MAPS;
> +	for (int i = 0; i < NR_EXTRA_MAPS; ++i) {
> +		if (mmap(ptr, PAGE_SIZE, EXTRA_MAP_PROT,
> +			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
> +			-1, 0) == MAP_FAILED) {
> +			perror("mmap in fill loop");
> +			ksft_print_msg("Failed on mapping #%d of %d\n", i + 1,
> +					NR_EXTRA_MAPS);
> +			return false;
> +		}
> +
> +		/* Advance pointer by 2 to leave a gap */
> +		ptr += (2 * EXTRA_MAP_SIZE);
> +	}
> +
> +	if (!is_current_vma_count("test_suite_setup", MAX_VMA_COUNT - 1))
> +		return false;
> +
> +	ksft_print_msg("vma_max_count test suite setup done.\n");
> +
> +	return true;
> +}

I mean it'll be fixed by the test harness, but even in test code let's please
not write MASSIVE functions that do a million things. It's not really readable.

> +
> +static void test_suite_teardown(void)
> +{
> +	if (ORIGINAL_MAX_VMA_COUNT && MAX_VMA_COUNT != ORIGINAL_MAX_VMA_COUNT) {
> +		if (!set_max_vma_count(ORIGINAL_MAX_VMA_COUNT))
> +			ksft_print_msg("Failed to restore max_map_count to %d\n",
> +					ORIGINAL_MAX_VMA_COUNT);
> +	}
> +}
> +
> +/* --- Test Helper Functions --- */
> +static bool mmap_anon(void)
> +{
> +	void *addr =  mmap(NULL, PAGE_SIZE, PROT_READ,
> +			   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +
> +	/*
> +	 * Handle cleanup here as the runner doesn't track where this,
> +	 *mapping is located.
> +	 */
> +	if (addr != MAP_FAILED)
> +		munmap(addr, PAGE_SIZE);
> +
> +	return addr != MAP_FAILED;
> +}
> +
> +static inline bool __mprotect(char *addr, int size)
> +{
> +	int new_prot = ~TEST_AREA_PROT & (PROT_READ | PROT_WRITE | PROT_EXEC);
> +
> +	return mprotect(addr, size, new_prot) == 0;
> +}
> +
> +static bool mprotect_nosplit(void)
> +{
> +	return __mprotect(TEST_AREA, TEST_AREA_SIZE);
> +}
> +
> +static bool mprotect_2way_split(void)
> +{
> +	return __mprotect(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
> +}
> +
> +static bool mprotect_3way_split(void)
> +{
> +	return __mprotect(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static inline bool __munmap(char *addr, int size)
> +{
> +	return munmap(addr, size) == 0;
> +}
> +
> +static bool munmap_nosplit(void)
> +{
> +	return __munmap(TEST_AREA, TEST_AREA_SIZE);
> +}
> +
> +static bool munmap_2way_split(void)
> +{
> +	return __munmap(TEST_AREA, TEST_AREA_SIZE - PAGE_SIZE);
> +}
> +
> +static bool munmap_3way_split(void)
> +{
> +	return __munmap(TEST_AREA + PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +/* mremap accounts for the worst case to fail early */
> +static const int MREMAP_REQUIRED_VMA_SLOTS = 6;
> +
> +static bool mremap_dontunmap(void)
> +{
> +	void *new_addr;
> +
> +	/*
> +	 * Using MREMAP_DONTUNMAP will create a new mapping without
> +	 * removing the old one, consuming one VMA slot.
> +	 */
> +	new_addr = mremap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_SIZE,
> +			  MREMAP_MAYMOVE | MREMAP_DONTUNMAP, NULL);
> +
> +	if (new_addr != MAP_FAILED)
> +		munmap(new_addr, TEST_AREA_SIZE);
> +
> +	return new_addr != MAP_FAILED;
> +}
> +
> +struct test {
> +	const char *name;
> +	bool (*test)(void);
> +	 /* How many VMA slots below the limit this test needs to start? */
> +	int vma_slots_needed;
> +	bool expect_success;
> +};
> +
> +/* --- Test Cases --- */
> +struct test tests[] = {
> +	{
> +		.name = "mmap_at_1_below_vma_count_limit",
> +		.test = mmap_anon,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mmap_at_vma_count_limit",
> +		.test = mmap_anon,
> +		.vma_slots_needed = 0,
> +		.expect_success = false,
> +	},
> +	{
> +		.name = "mprotect_nosplit_at_1_below_vma_count_limit",
> +		.test = mprotect_nosplit,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mprotect_nosplit_at_vma_count_limit",
> +		.test = mprotect_nosplit,
> +		.vma_slots_needed = 0,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mprotect_2way_split_at_1_below_vma_count_limit",
> +		.test = mprotect_2way_split,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mprotect_2way_split_at_vma_count_limit",
> +		.test = mprotect_2way_split,
> +		.vma_slots_needed = 0,
> +		.expect_success = false,
> +	},
> +	{
> +		.name = "mprotect_3way_split_at_2_below_vma_count_limit",
> +		.test = mprotect_3way_split,
> +		.vma_slots_needed = 2,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mprotect_3way_split_at_1_below_vma_count_limit",
> +		.test = mprotect_3way_split,
> +		.vma_slots_needed = 1,
> +		.expect_success = false,
> +	},
> +	{
> +		.name = "mprotect_3way_split_at_vma_count_limit",
> +		.test = mprotect_3way_split,
> +		.vma_slots_needed = 0,
> +		.expect_success = false,
> +	},
> +	{
> +		.name = "munmap_nosplit_at_1_below_vma_count_limit",
> +		.test = munmap_nosplit,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_nosplit_at_vma_count_limit",
> +		.test = munmap_nosplit,
> +		.vma_slots_needed = 0,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_2way_split_at_1_below_vma_count_limit",
> +		.test = munmap_2way_split,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_2way_split_at_vma_count_limit",
> +		.test = munmap_2way_split,
> +		.vma_slots_needed = 0,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_3way_split_at_2_below_vma_count_limit",
> +		.test = munmap_3way_split,
> +		.vma_slots_needed = 2,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_3way_split_at_1_below_vma_count_limit",
> +		.test = munmap_3way_split,
> +		.vma_slots_needed = 1,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "munmap_3way_split_at_vma_count_limit",
> +		.test = munmap_3way_split,
> +		.vma_slots_needed = 0,
> +		.expect_success = false,
> +	},
> +	{
> +		.name = "mremap_dontunmap_at_required_vma_count_capcity",
> +		.test = mremap_dontunmap,
> +		.vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS,
> +		.expect_success = true,
> +	},
> +	{
> +		.name = "mremap_dontunmap_at_1_below_required_vma_count_capacity",
> +		.test = mremap_dontunmap,
> +		.vma_slots_needed = MREMAP_REQUIRED_VMA_SLOTS - 1,
> +		.expect_success = false,
> +	},

This is horrible. We don't need to do it this way.

Use the kselftest_harness please. See the guard_regions.c test for an example of
how to use it.

> +};
> +
> +/* --- Test Runner --- */
> +int main(int argc, char **argv)
> +{
> +	int num_tests = ARRAY_SIZE(tests);
> +	int failed_tests = 0;
> +
> +	ksft_set_plan(num_tests);
> +
> +	if (!test_suite_setup() != 0) {
> +		if (MAX_VMA_COUNT > DEFAULT_MAX_MAP_COUNT)
> +			ksft_exit_skip("max_map_count too high and cannot be lowered\n"
> +					"Please rerun as root.\n");
> +		else
> +			ksft_exit_fail_msg("Test suite setup failed. Aborting.\n");
> +
> +	}
> +
> +	for (int i = 0; i < num_tests; i++) {
> +		int maps_to_unmap = tests[i].vma_slots_needed;
> +		const char *name = tests[i].name;
> +		bool test_passed;
> +
> +		errno = 0;
> +
> +		/* 1. Setup: TEST_AREA mapping */
> +		if (mmap(TEST_AREA, TEST_AREA_SIZE, TEST_AREA_PROT,
> +			MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, -1, 0)
> +				== MAP_FAILED) {
> +			ksft_test_result_fail(
> +				"%s: Test setup failed to map TEST_AREA\n",
> +				name);
> +			maps_to_unmap = 0;
> +			goto fail;
> +		}
> +
> +		/* Label TEST_AREA to ease debugging */
> +		if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, TEST_AREA,
> +			TEST_AREA_SIZE, "TEST_AREA")) {
> +			ksft_print_msg("WARNING: [%s] prctl(PR_SET_VMA) failed\n",
> +					name);
> +			ksft_print_msg(
> +				"Continuing without named TEST_AREA mapping\n");
> +		}
> +
> +		/* 2. Setup: Adjust VMA count based on test requirements */
> +		if (maps_to_unmap > NR_EXTRA_MAPS) {
> +			ksft_test_result_fail(
> +				"%s: Test setup failed: Invalid VMA slots required %d\n",
> +				name, tests[i].vma_slots_needed);
> +			maps_to_unmap = 0;
> +			goto fail;
> +		}
> +
> +		/* Unmap extra mappings, accounting for the 1-page gap */
> +		for (int j = 0; j < maps_to_unmap; j++)
> +			munmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
> +				EXTRA_MAP_SIZE);
> +
> +		/*
> +		 * 3. Verify the preconditions.
> +		 *
> +		 *    Sometimes there isn't an easy way to determine the cause
> +		 *    of the test failure.
> +		 *    e.g. an mprotect ENOMEM may be due to trying to protect
> +		 *         unmapped area or due to hitting MAX_VMA_COUNT limit.
> +		 *
> +		 *    We verify the preconditions of the test to ensure any
> +		 *    expected failures are from the expected cause and not
> +		 *    coincidental.
> +		 */
> +		if (!is_current_vma_count(name,
> +			MAX_VMA_COUNT - tests[i].vma_slots_needed))
> +			goto fail;
> +
> +		if (!is_test_area_mapped(name))
> +			goto fail;
> +
> +		/* 4. Run the test */
> +		test_passed = (tests[i].test() == tests[i].expect_success);
> +		if (test_passed) {
> +			ksft_test_result_pass("%s\n", name);
> +		} else {
> +fail:
> +			failed_tests++;
> +			ksft_test_result_fail(
> +				"%s: current_vma_count=%d,max_vma_count=%d: errno: %d (%s)\n",
> +				name, get_current_vma_count(), MAX_VMA_COUNT,
> +				errno, strerror(errno));
> +			print_surrounding_maps(name);
> +		}
> +
> +		/* 5. Teardown: Unmap TEST_AREA. */
> +		munmap(TEST_AREA, TEST_AREA_SIZE);
> +
> +		/* 6. Teardown: Restore extra mappings to test suite baseline */
> +		for (int j = 0; j < maps_to_unmap; j++) {
> +			/* Remap extra mappings, accounting for the gap */
> +			mmap(EXTRA_MAPS + (j * 2 * EXTRA_MAP_SIZE),
> +				EXTRA_MAP_SIZE, EXTRA_MAP_PROT,
> +				MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
> +				-1, 0);
> +		}
> +	}
> +
> +	test_suite_teardown();
> +
> +	if (failed_tests > 0)
> +		ksft_exit_fail();
> +	else
> +		ksft_exit_pass();
> +}
> +
> +/* --- Utilities --- */
> +
> +static int get_max_vma_count(void)
> +{
> +	int max_count;
> +	FILE *f;
> +
> +	f = fopen("/proc/sys/vm/max_map_count", "r");
> +	if (!f)
> +		return -1;
> +
> +	if (fscanf(f, "%d", &max_count) != 1)
> +		max_count = -1;
> +
> +
> +	fclose(f);
> +
> +	return max_count;
> +}
> +
> +static bool set_max_vma_count(int val)
> +{
> +	FILE *f;
> +	bool success = false;
> +
> +	f = fopen("/proc/sys/vm/max_map_count", "w");
> +	if (!f)
> +		return false;
> +
> +	if (fprintf(f, "%d", val) > 0)
> +		success = true;
> +
> +	fclose(f);
> +	return success;
> +}
> +
> +static int get_current_vma_count(void)
> +{
> +	char line[1024];
> +	int count = 0;
> +	FILE *f;
> +
> +	f = fopen("/proc/self/maps", "r");
> +	if (!f)
> +		return -1;
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		if (!strstr(line, "[vsyscall]"))
> +			count++;
> +	}
> +
> +	fclose(f);
> +
> +	return count;
> +}
> +
> +static bool is_current_vma_count(const char *msg, int expected)
> +{
> +	int current = get_current_vma_count();
> +
> +	if (current == expected)
> +		return true;
> +
> +	ksft_print_msg("%s: vma count is %d, expected %d\n", msg, current,
> +			expected);
> +	return false;
> +}
> +
> +static bool is_test_area_mapped(const char *msg)
> +{
> +	unsigned long search_start = (unsigned long)TEST_AREA;
> +	unsigned long search_end = search_start + TEST_AREA_SIZE;
> +	bool found = false;
> +	char line[1024];
> +	FILE *f;
> +
> +	f = fopen("/proc/self/maps", "r");
> +	if (!f) {
> +		ksft_print_msg("failed to open /proc/self/maps\n");
> +		return false;
> +	}
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		unsigned long start, end;
> +
> +		if (sscanf(line, "%lx-%lx", &start, &end) != 2)
> +			continue;
> +
> +		/* Check for an exact match of the range */
> +		if (start == search_start && end == search_end) {
> +			found = true;
> +			break;
> +		} else if (start > search_end) {
> +			/*
> +			 *Since maps are sorted, if we've passed the end, we
> +			 * can stop searching.
> +			 */
> +			break;
> +		}
> +	}
> +

There's helpers for this kind of thing in vm_util.h, let's not duplicate
code. Also you can use the proc query ioctl thingy (also helpers for that in
vm_util.h) rather than having to spelunk /proc/$pid/maps.

> +	fclose(f);
> +
> +	if (found)
> +		return true;
> +
> +	/* Not found */
> +	ksft_print_msg(
> +		"%s: TEST_AREA is not mapped as a single contiguous block.\n",
> +		msg);
> +	print_surrounding_maps(msg);
> +
> +	return false;
> +}
> +
> +static void print_surrounding_maps(const char *msg)

WHy are you printing a bunch of noise in a test?

> +{
> +	unsigned long search_start = (unsigned long)TEST_AREA;
> +	unsigned long search_end = search_start + TEST_AREA_SIZE;
> +	unsigned long start;
> +	unsigned long end;
> +	char line[1024] = {};
> +	int line_idx = 0;
> +	int first_match_idx = -1;
> +	int last_match_idx = -1;
> +	FILE *f;
> +
> +	f = fopen("/proc/self/maps", "r");
> +	if (!f)
> +		return;
> +
> +	if (msg)
> +		ksft_print_msg("%s\n", msg);
> +
> +	ksft_print_msg("--- Surrounding VMA entries for TEST_AREA (%p) ---\n",
> +			TEST_AREA);
> +
> +	/* First pass: Read all lines and find the range of matching entries */
> +	fseek(f, 0, SEEK_SET); /* Rewind file */
> +	while (fgets(line, sizeof(line), f)) {
> +		if (sscanf(line, "%lx-%lx", &start, &end) != 2) {
> +			line_idx++;
> +			continue;
> +		}
> +
> +		/* Check for any overlap */
> +		if (start < search_end && end > search_start) {
> +			if (first_match_idx == -1)
> +				first_match_idx = line_idx;
> +			last_match_idx = line_idx;
> +		} else if (start > search_end) {
> +			/*
> +			 * Since maps are sorted, if we've passed the end, we
> +			 * can stop searching.
> +			 */
> +			break;
> +		}
> +
> +		line_idx++;
> +	}
> +
> +	if (first_match_idx == -1) {
> +		ksft_print_msg("TEST_AREA (%p) is not currently mapped.\n",
> +				TEST_AREA);
> +	} else {
> +		/* Second pass: Print the relevant lines */
> +		fseek(f, 0, SEEK_SET); /* Rewind file */
> +		line_idx = 0;
> +		while (fgets(line, sizeof(line), f)) {
> +			/* Print 2 lines before the first match */
> +			if (line_idx >= first_match_idx - 2 &&
> +				line_idx < first_match_idx)
> +				ksft_print_msg("   %s", line);
> +
> +			/* Print all matching TEST_AREA entries */
> +			if (line_idx >= first_match_idx &&
> +				line_idx <= last_match_idx)
> +				ksft_print_msg(">> %s", line);
> +
> +			/* Print 2 lines after the last match */
> +			if (line_idx > last_match_idx &&
> +				line_idx <= last_match_idx + 2)
> +				ksft_print_msg("   %s", line);
> +
> +			line_idx++;
> +		}
> +	}
> +
> +	ksft_print_msg("--------------------------------------------------\n");
> +
> +	fclose(f);
> +}
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 471e539d82b8..3794b50ec280 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -49,6 +49,8 @@ separated by spaces:
>  	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
>  - madv_populate
>  	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
> +- max_vma_count
> +	tests for max vma_count
>  - memfd_secret
>  	test memfd_secret(2)
>  - process_mrelease
> @@ -417,6 +419,9 @@ fi # VADDR64
>  # vmalloc stability smoke test
>  CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
>
> +# test operations against max vma count limit
> +CATEGORY="max_vma_count" run_test ./max_vma_count_tests
> +
>  CATEGORY="mremap" run_test ./mremap_dontunmap
>
>  CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
> --
> 2.51.0.384.g4c02a37b29-goog
>

