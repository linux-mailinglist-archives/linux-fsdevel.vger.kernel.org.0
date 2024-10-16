Return-Path: <linux-fsdevel+bounces-32092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F79A067E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F00B21795
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB02076C7;
	Wed, 16 Oct 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVnpvViY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rC64dnSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A61207213;
	Wed, 16 Oct 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073056; cv=fail; b=gOPMR0svGJWTat3bCWnRT83NPIyMy8g20ETk5FcaBz0+birACeYLmpRlm+dCupI5FSLp7SI7RyLekbo6VCqb2NV5c+10bKzzWU086cIwJsTXPucNbC03faUIRfzVJlEN9P1JhhZCe9BCeWc7aHLAq6BuJMC0NzOJRi64Xvyg45M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073056; c=relaxed/simple;
	bh=GOiCNcapzhN1Hi79FTL2lTsFiOc15kCIgEEDUH+f1WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+9D+EViVqxU/mlZvUafBS0bw4ipu3NM1zbiLjTGf6RsBQHT9ckVVNiD5ZK/p7HWnrBBYxI9nD+bSH7IJ1lPaEqggbPKmQNxLBrpcwyraa37/kb5CuzBgrleVSQVVzvnHnZiiFk1A5d+XiLP+w+qVTro6WgJUNBEtoUcuKA7F68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVnpvViY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rC64dnSz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tfEb010088;
	Wed, 16 Oct 2024 10:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IbaI8wdmvgvI+qEvkhliJjNYO1Y1ZNPP3yej5CL/TWk=; b=
	RVnpvViYpXyY3hg/MT//R4BxKlNSm6J0KdJ96STUG55x47WpB2XHMK7UtFbFvl6I
	xa3TmqFyGHBgEpu5XFHoKgi/m0Lp3Uh633rDr9FTL5XXfss482FPNnvRUrO/eGDQ
	RstnaaiN+DwqlrGr6K8Mv67m4HPEOGxnVQnlG+1IdNq4ey5/kM6NEWkVrM7rOhUG
	xeXl1Llr2FX3tQqcpVzreMhnEcWTnpHcfEecH9A2VG2a284ZvEi+ff7roje82V/g
	8JLpJ59JmRIJOMOB5GPnrsHCb3o2pQfVwM82WY4LuQF16c19WOhXIw02+3v3GzZ3
	iTN5bXYPJrxSVraRCWweFw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntbdg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8r0Zu026718;
	Wed, 16 Oct 2024 10:03:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjf6eet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INj7BWO9t+ksOsnlsjWWXvzGry5xASX47cU5uziXTMktbRu0hcyQ7w5IMaC07U+F/cxtgNhXw32gxkHiNlCYwBBMm6xlVW03wLlUVij91NEWC41poEzzKvTPzkFWKRvrBnQE5qPIUnKATMjTAjRxokRFk8TINGZthtV+sBgvWrsgBWra/so5uUxrfalaero1sGm1T5tdEu+a+Zk30GeXMRBZNIH8t5no2CY6i9V2JOIeLmG4VxyJmSPJPMAjhbvo6PLqIZAoGzf9o0i8VEdfYm6P/K0b0olhIO7zNZ26q2g+x/hk7B0Kma5wKZrRKt0QUVjlsC656yyvovwJ9jfFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbaI8wdmvgvI+qEvkhliJjNYO1Y1ZNPP3yej5CL/TWk=;
 b=aURvqxVcJSoL0FK1E6qJRoGjaunbpG1aNWgc+Sj7uRSvVBWYsimKDKeIuGmIlhLccRgo5eHjtCNe5KN7aG/DSaMxntXE6zWf57wadWsIAgX3yN38XeYBTkjxjZFMr84+A0tIvINJWA/fptxRVbUoNdx5wmexIUs7e7YRYr08E4pgmJORizV154xzKnMtaikboW5ej+LFbITIC8fA5Corqfaeay0pwrNBmmBfMT4CEitTjyxIQ79If4v57PVbWGHZBienh1I+9YupnCZBj8RSB138aQDN5P1wJHM+t1McV5kWMbDdWQgUQ9Eri8ZMVPtMtS+mQs6/I3NZJSzVOTiZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbaI8wdmvgvI+qEvkhliJjNYO1Y1ZNPP3yej5CL/TWk=;
 b=rC64dnSzl6yDg7A8pBYgta0UT0GP7z2+vpV7ooiePYO3JD+GtoEM9Kn08bYq+5tS8LLW0q8NK/t+ghgMW88egfwupB8BbqCrPEI8QH/0OdFiXqbDvAAvqHVQ2KTnHnOtEmIlz9TBbW9WgA15GHwxwIYoGZPJ7y2Sbcb8/xeQ8k4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 5/8] fs: iomap: Atomic write support
Date: Wed, 16 Oct 2024 10:03:22 +0000
Message-Id: <20241016100325.3534494-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: de0c49cf-d649-481d-ea00-08dcedc9d801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69GAg1y6Ic8mhrEVsDzXGdV3jE26K23c/q1UKjyd2R6ttB2iK+B6uTQ6z9vg?=
 =?us-ascii?Q?m6eYnVkfua8MSRvnDkWkZY4cAPP6Ur9sawEca+1yS58Teu60MDITVxOKdv+6?=
 =?us-ascii?Q?3LRyvL8Vw0AV+rale1/kxtpBgMNZu5HNIju02Q9smqG81PRvVZAcryXBEm6V?=
 =?us-ascii?Q?CZQW6/zbDDp4dwuOF8N0hoMS+WNEjpIhiBQPuxwWey0WdqBui9hDYC8T4T1J?=
 =?us-ascii?Q?5zCiYAFXyE7h6yY0NSR+xmUeWbJ4Z4Yb3Lgm7HEAXfl3qBecQVx/OQPeN2sF?=
 =?us-ascii?Q?enAAPYHULyzZtBX0gPkzrCwXMRicqQ4gHwLWEz2YTbWw3E68FuvaPvI2g0FZ?=
 =?us-ascii?Q?/HXuQny0lLqBX9bKQ5To0ocwn2Tm2DJUrnLUfftR1LDt0aUFgD7AAuiKiUnp?=
 =?us-ascii?Q?D8WQWUUvSRjp5QAtyTQYLETyVAE2t3AHLT6k4QYv+H6EIhBNd09JFw1BBu8J?=
 =?us-ascii?Q?zlFk7P7VdLuWqduwkNOz8Qg+UUc1i/6Z4QawiBf+j5ocIwngXldLOmMMD+Xt?=
 =?us-ascii?Q?PYiADdPyadugO9gqjG+cTdJj/pc32vY3Bp50x3LShctUYg5C+5tYmsxjbnea?=
 =?us-ascii?Q?Nzvs+WPFGo1U+V+mn9LJxEeX67YNxJsxTC0ON1z6EhxTm1snsGrBBOuRHCKv?=
 =?us-ascii?Q?xUpf2UUKY3WFzaSObmOjWHgrAbyt6PrUybcl1tY2/Y7BbC99NQmNEupBs/eR?=
 =?us-ascii?Q?Q6RlqmH5o2FhCIY9EMOxxx4pahX2j6crO2/rKrHSbfz2O7tmYJYgSRoaR46j?=
 =?us-ascii?Q?gsGId++NQH9LiTRaPA9R2h6GPUMaFr0YhZv5szHKE12OXIyG8JqQsuCNkAhL?=
 =?us-ascii?Q?mIh71SP01VzaWYfGeMsJXpK9GDrbsWVvKrs7keFowkSi4xdsQtqJjfwDyKQ/?=
 =?us-ascii?Q?cjEbzn1OWcNs3gy8BArqLFyQoZZq03P6VFB6e16BdGe33Yx2FUKihHgvKD+G?=
 =?us-ascii?Q?EKe+uVjhTNuqWVe4qrgmXOqCzMJab7P19o33rCLkSZFcie7Zmw4uR8mcNi0k?=
 =?us-ascii?Q?mpXiwKYAMhS4k9TqaCJ3u35kegyzGQ+SVELWkz5uuIILYE344wy59UC/7xVj?=
 =?us-ascii?Q?jpTkLYnXfmRHJeLpmftNFKkT7SlFCwtR9VyFkOEDwxq6D4THpzH94mKAm+8P?=
 =?us-ascii?Q?UhX78xgxxEBRQ80Izfl6NdYC9mzDKGZfWxdkjJWxrxJmJmZI+KHypgu4DChg?=
 =?us-ascii?Q?PKXIDVEizpJFyjP+fFvs6PHDTOMsFoOtL6N46RUP4bHTYeHi1I5by5xkUXq1?=
 =?us-ascii?Q?MQg5CuutinlNmlVwjS+iOTDxv5MeRbvYQFBhXDMOZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5tunbVVUWfO/CNTsisNmd49OQ+TSaUm4COLFZg/mWRDt6IJwD5Xu3lEpMb+B?=
 =?us-ascii?Q?4xEt0n0Xb+XojFmADY/oT1JAcyqDOUUFPq7MV16cPSQX1Fm3RSViOeN8HHbw?=
 =?us-ascii?Q?BFRuSOraIAvfHgBuFitTwyZ4vsh/fnFq5ga7eussZI003HNJpPMda03lYqy/?=
 =?us-ascii?Q?WnKzmfE2ZEx0gDZmLP3M2bKdL4gUF5mHEsORy1G4L70N0Ws4qoAuXAd1ty0l?=
 =?us-ascii?Q?d8IK1lG1n5gFNdQJHGqLltaXnKzExZE4YMAwrjJ8+0Wl9lnZM21s/RkTiLyt?=
 =?us-ascii?Q?TF8Xo+WTbVKq531KpTp1rQWAbaVF5iGbLUX3DprlA4Yn/Pvl5fYRhYx1tXE8?=
 =?us-ascii?Q?tHY4/lpoZX7KkqTNE6jtJe9Dg2xSR3E5BBqm+1uBhiNmx+cu7IwFA511LiMf?=
 =?us-ascii?Q?St302Kh+TlmJxfdg0GcdvuIYHG+8628X7KGYbJ5KFeGFJQfgPbHsINxOFZcY?=
 =?us-ascii?Q?rvQANchPeCtp7Zgx2B4W56Qq5/G48LTtJ5GXxzowi9DTYryJb5eXPEv9Gpn4?=
 =?us-ascii?Q?ZCJM0yRmKpW0XyF/mvyIKOLudRNcMMokYMwtxTMza2FAV97j6gh+a0/rlsSc?=
 =?us-ascii?Q?xW8AMHKv8apckfiVLoFXcpSfZoCGeGXAlsXur4IHJ2dTzFRYexlsRWKSlNp2?=
 =?us-ascii?Q?K/AqRR7MtxXn/ja2DdqVfgionjYq36vfgRkZeMN+VIfEfExMstXqksuBBus4?=
 =?us-ascii?Q?2y+zDQTzdHZwVHOjaG2u6Tz/WMMpa/HVwDxJk8O/y0R6opO2y0duB71H16bf?=
 =?us-ascii?Q?wPyHAwm7dG3dQqfthrtIAibD1SQLUxiMMAzhCocdyAr9tOIDBB2To1deQnbw?=
 =?us-ascii?Q?p+luMlWgTJ0AZ3n3Y7LXnFeHqfIklYCU071KBOaqVeGeirNmDw6XmYHNHWz+?=
 =?us-ascii?Q?odBPXjdstJDs0efJMjPSCnj/Vb2E6ddT2ZVKIBTx0RQJV9IKZFh8MG79NZNN?=
 =?us-ascii?Q?TutUYxElxkCrPB9UAUASpsa57mI+LQALGjrD7wip5pHI5p8RKU21Vd0TSozT?=
 =?us-ascii?Q?wlk9c27l3/tdlUOC3mZSumLIlNjdhPWMxv86lx0I1HCmHESFqlCRrf2KUCN0?=
 =?us-ascii?Q?J2hXSPJrqjX45o3Klly/AQozqTqNPKdajaT3JO8OjuZwHWOxtiaopxd7lVN1?=
 =?us-ascii?Q?S7D7T0MkJMXGQK5DcDCuSc55uvdqSaieAiWYbuGCSxNskzCYjzMD8emrD+EW?=
 =?us-ascii?Q?t3YdXdNJ1u55FZRXQtwOrVTaP/yOlpmVfZN4ivI/zIv7tZhxqIn8VWB3vYFd?=
 =?us-ascii?Q?Zn+6drPcD/J1X/pHSZ8uSwbkfvSupCCUzOWrQgVwPPBefbhtcXQytMwBs987?=
 =?us-ascii?Q?4eVJMW2MKt+lgCjMbfnxZ0wpCuI5Yp+HFY9yBNecqAjM+EgPm/EPeOliA/HH?=
 =?us-ascii?Q?5qZk9E1BvgMXtMB3mrsZYb74mwRD34V4IXAp+In0IfgQMt/A7EECZjCdoK7O?=
 =?us-ascii?Q?mwuVcawV3mGrXJj4Kxx7lLnZbm8/eni5HZxTAqiaN2CW8FKwc+geFMciddSw?=
 =?us-ascii?Q?Qp5iB7SIqcFzfC7CnkHCE2n3ob03vcGuP+CGZtx3jVY26K2ukZ11y4cjKxhI?=
 =?us-ascii?Q?bVZRGXIZrzdXVbFH1SVIEhZHFPtajqFbPd8fc9RjsJB3bbf1xyw/eaFvpzSS?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pZuAD+uk0i0RA1dQ0ezeO3w4CU4jsWXJuCXfG0u/0BMpirgpUqo+UWtj278e6NrANoHFayvzKCboumA5v4WRVQJCm4cNlJMtYM2bLF7Q2Yccn00dY0mGnJ6Eb5cpHBcmlrnx5eHruTPh2DE4Z9qWZx/jRfa3pmr5ulk9LpE7o8t1ZeZzxxOyuwZWjSCPILW+Jg63VbEjoACq5PB95h8ScCFs7fYmCnyfBCLaK8B9Md7c9W0FBGn0j4klKkSQ8fEF/2d4tx3E8XEKh+uxQm9owaBzY8wefR1Kx7cbHpCxWzvKJIJAFMtqZ9/nOVrfkGmCUgKysVlYVEAR/4mvCEjNt2IUAxcAL0X6E0O28xGdWGX0DP8KDIrL7gy0K8vaR9Ie0dRVEsNFcSjByksRkEGp+aVZyjJ24uFnZUNjntJgXVv/3G0p0IugoOa8c2hgb4Y37cm87xCFLwSgY+9EomlrW/rXc4RJ3kESdY2MOGJ54JIrRmpZU+ms+Bk7HTsC7nOGxtxQ/seFf4eC71/XyDWyr2gm20gYjqIuDVjekUFB3Seamw0redZddViVD2brxz3gQBXyGVp6kA1PkWpLTYdSN9mOJXW4jJ5GgESSJ8yhtsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0c49cf-d649-481d-ea00-08dcedc9d801
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:54.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78rYFDsEmAaj+oBvZTJYEaCthpWUNhVLaVVPqPexm/d0KK416IAC1n6p0g3wqqgnRKxzgXLdB2WNO4Cgx7QCWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160062
X-Proofpoint-ORIG-GUID: Ojg1hsCm37P9PLCW5h4M15p2XToQx6bg
X-Proofpoint-GUID: Ojg1hsCm37P9PLCW5h4M15p2XToQx6bg

Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
flag set.

Initially FSes (XFS) should only support writing a single FS block
atomically.

As with any atomic write, we should produce a single bio which covers the
complete write length.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../filesystems/iomap/operations.rst          | 11 ++++++
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 include/linux/iomap.h                         |  1 +
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index b93115ab8748..5f382076db67 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
+ * ``IOMAP_ATOMIC``: This write is being issued with torn-write
+   protection. Only a single bio can be created for the write, and the
+   write must not be split into multiple I/O requests, i.e. flag
+   REQ_ATOMIC must be set.
+   The file range to write must be aligned to satisfy the requirements
+   of both the filesystem and the underlying block device's atomic
+   commit capabilities.
+   If filesystem metadata updates are required (e.g. unwritten extent
+   conversion or copy on write), all updates for the entire file range
+   must be committed atomically as well.
+
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f637aa0706a3..ed4764e3b8f0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	loff_t length = iomap_length(iter);
+	const loff_t length = iomap_length(iter);
+	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
+	if (atomic && length != fs_block_size)
+		return -EINVAL;
+
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
@@ -382,7 +388,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -415,6 +421,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (WARN_ON_ONCE(atomic && n != length)) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail (complete FS block), similar to when
+			 * bio_iov_iter_get_pages() returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -598,6 +615,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		iomi.flags |= IOMAP_ATOMIC;
+
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -659,7 +679,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				if (iocb->ki_flags & IOCB_ATOMIC) {
+					/*
+					 * folio invalidation failed, maybe
+					 * this is transient, unlock and see if
+					 * the caller tries again.
+					 */
+					ret = -EAGAIN;
+				} else {
+					/* fall back to buffered write */
+					ret = -ENOTBLK;
+				}
 			}
 			goto out_free_dio;
 		}
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..4118a42cdab0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d0420e962ffd..84282db3e4c1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1


