Return-Path: <linux-fsdevel+bounces-47997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79243AA852D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C53A59F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB31DEFC8;
	Sun,  4 May 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUriLf0N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HoK24fpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F921DB951;
	Sun,  4 May 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349234; cv=fail; b=TilRatVCv3t5vChNAnNy93JaBG96In86J7NLTiHdtUIRSfhwnyIKiVzQ4SZdXp7Zip4SRAlEf0sDdjjTrBkJ3elb3Dl12xieAPoWP5gvU9Ia7TMctg6R5dLHbnjUWZd50OE33W7nK0XDQoMbBwzTdY8ROKdrGaQMI4zJdn6UrEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349234; c=relaxed/simple;
	bh=grD7ifJZSCzAsDbA6LAY+ymaIi6biQ4JtrUjxHisUfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EX0j/AQsqIn7uW3alw43uDbqgSRtFU/nfFXm6HJhXDa8y7bHklx6A2/0y+tvKX7qa48o6pErDmhpr8ztbQY2Ar00Fqba3dGfCo0ZKnJlMJH6evLoGvYNtj+vyGfmG9XthcoUltSzpFX2yuj6sPSR85G595cJlwrHGEaR2RurmUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUriLf0N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HoK24fpD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5447MmsQ013216;
	Sun, 4 May 2025 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JB+yRRLFDy8/oY8gCkDWw1Rql7iafCnpEv1JJwhIj0Q=; b=
	YUriLf0NG9dmuxSGXj/QYmo4tpkkYQy7Zr3Z0AIVdH11bY41Y8HOvciy9GmVq5CH
	MUszgcltZ6yS34e23fR1DmQbUMYy/wTjPgv6dQo90s0UfBex1OyVua+Xy5Bkm1kE
	nmfNZwHjuZ2FlN731KmBPAtM3So8VF7xcWUTIbo9vex1bnGkk2WT0T7aYawsUoGt
	R7kELOQ1K7XyYpXIGhDl97Z7zesqNMablckxIYKRz6evXAyj+WcJaLefWdEMEeX8
	unlwCJEcKPbgDpYePlJCPyHyW8aQtinnpAb4oiPejRtbFSkK0riVt5QelLi+hYMm
	ZNkG7NyN/wPxja8gn0gK5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3smg2sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5448iX5M036027;
	Sun, 4 May 2025 09:00:20 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7lgwOgFRU2dk4d/nQs5f0Qa1W71UeiyZ3J6SUF5nN1fR5Uu1qPdH1ui85oH5auTjpVX46+FRKhfMEqLrh47tVHOKLy5MntvwXwuiR78DAOxT7A4DBdZVvaEs+xvPVgSY5U9E0otJzp63L7aOam+WjGt6Pt9Z29spgVacg45pwGX9vp0UWwds6HFxVJn6EE5Iw6jSRmkWKPOQWULxMrcdvWNo7LQ2YSZcq3nis1yFoV5toRuSZL7IHI7DqavM4i/1CRa2BP1FOXJMA3/K1z1Y+LpnZFcIRp6DrFYlo0Fqfdwc06pQDpvOhOQB//h6WvlAUd6+JVWDpizAkqbTfZ/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB+yRRLFDy8/oY8gCkDWw1Rql7iafCnpEv1JJwhIj0Q=;
 b=dpmHRg3GZ2mRhhqc7qDTYMlCnhZef40eaYAHiQwRdDq0LUkvXTlrIxFekwgFIfYhpp8t8i7LPbZsSv/ZJnQKKKi2xENOKIDAYRObU9JmH9qGSqTbOhPoRjTY/72hIdEMa1Mh4qb7MLmWqAut/vkpIj6fVmBcsv0qiGyZulNIF76sqVEOEuG9GmS/aK5VUwROqUzRgewk0DiwhCv37icPKFLjRPQIj/jZn28Sq7kq5aEajJNSREgTdZpEb6q1hSB+v29nSwdRcACRKrdeo3UDXkNA3DptmIb6Jj4N+uUvVW+N+jJ/5RrCSeyMGBF1V/d/blOsYi+SAP97K498NV0iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB+yRRLFDy8/oY8gCkDWw1Rql7iafCnpEv1JJwhIj0Q=;
 b=HoK24fpD/jEeIi2U5HQ7lC4TT3AbXZJ2iPLK8p2ULR/wjTZtofYNgM+woRmLMLql8EQsWusM2CLxX08WhQYD7AuNj/chrTJ30sr8tcZ8ojUp9HwhDfasP9THgvywETeX/9DLcST4/4uHPO7ltxNi8AyVPTiHaAriORk90emxVcY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 4 May
 2025 09:00:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 16/16] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Sun,  4 May 2025 08:59:23 +0000
Message-Id: <20250504085923.1895402-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:208:239::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fdf0c8-9622-4997-e834-08dd8aea16f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ke9tehcHYdcvL6O/aPPfqIW0bnhVVYpVEcR0oH3+rMCYDv/uWjqL0Mwb4wBf?=
 =?us-ascii?Q?lxEcZ1pqec1sopTz0fOVBbesxw/UFGnmrVZPhJI9EnNLa/uqkCqjCTposrAv?=
 =?us-ascii?Q?ya8BQdZjI7ALtEZobsTBDSkbOE+glX6zZ10J4L+pB71ii4SD6rJCO/NfMjPI?=
 =?us-ascii?Q?3db+kkL1rzhH9b5U7LFY+gELdvVfo0zMl9hxMYnGZVaBSskb4QzhkMMtrJgH?=
 =?us-ascii?Q?Z+zQFrqd2yFyObPDdBmy6sO0tiukXO0WW5yCNdSU9PnTvB9Snql1rY+8OMZZ?=
 =?us-ascii?Q?JyT97iFkC4GFpAjn+3sxEb8n2A7kocSvSFkO817HwseVEtGLFGyTR6PPj+P5?=
 =?us-ascii?Q?t0F85Zvc/20pomhqwkN4mBfGhTSywzVsljZTqrABjrI0fbtx81UYHjpZOIKC?=
 =?us-ascii?Q?cLIjQoDrgYx4oHRgwjgWdLC/EGRUOj663aFQyRVmVxVN+1Q6srABcMAiBLs8?=
 =?us-ascii?Q?yNyvgrOi8LdbeM+Ce467+UlfA0MXSX723BF/1cWm2Qasdj7rXHhmaRS2CSCM?=
 =?us-ascii?Q?kQUJMJio8sbO4Cic4YWMl+qNGHOt8pnjTSPqHptYpDG9rojJI/u0XshSWxqG?=
 =?us-ascii?Q?HoSsGYpOXTLdd2OgxEz+AymtR0UHu5/rm4koMnmcgryzvba2pZh8HrvaLean?=
 =?us-ascii?Q?9ATfxp3OiobIF4j2s1Z0nuglaSFLiGgHfnRovKlKT+uTYVDNvzFd0Jj/Ft1s?=
 =?us-ascii?Q?HpMeStMPi6C4KsqCJiW6jroiJhRiuWj8aK0cKRDr2ydMA4/99X9KKb/03Fna?=
 =?us-ascii?Q?fzgNHrYxtZYVTzuzzmtMmCMfLXn49GTDNiIsh1K3p83hsP79XRLDGPwVOQEB?=
 =?us-ascii?Q?SHIOf/SPxIiuDGh/QwAfnBqIu5vmy3aTjN8b6AZgz+0qF8u/zzzch9NDT+Zd?=
 =?us-ascii?Q?UVtErb8S1GlnhXUmSXsYgfFOePEE16MC02D6YS8AFqZJftT8n1C3aPhODgPp?=
 =?us-ascii?Q?4TtTKSPgjis8Oe9ULSPqPubd5uTgwpYDXOWOkYxZ/nd6jk8jJX8rkTbjrGxt?=
 =?us-ascii?Q?KdXY7PVwDEkk7j8FTZHbH5XXj/qYw0qNoNeXZ3N/pJXb2TUEiXSou2wHI1OI?=
 =?us-ascii?Q?42UntBNW9K2CIpxFzKeJHRdqhw8lzqw2/RDfqkM3Sl61cyKWQucdblVxqugk?=
 =?us-ascii?Q?8e+xSTDo/K7e8i1ewP03urWUumBcddOqr49Ee6pRk3dFMB0VSkU7bw0zSdrR?=
 =?us-ascii?Q?yrXL7MMaS96PbhifRbO6eTaxa56f9QHkI6wUfxOxLiceukBJgM6wD9t/5THA?=
 =?us-ascii?Q?IeHwBfTMI1p2hBRMcfos31HMiTLP1s0zA/VKntuzZ+OdYF5Rzd9kU1NZt5ZJ?=
 =?us-ascii?Q?VDnI22MPtTNFYm8FJO2SMLc/thqatEk0VWK2SRXdU0q8PzlQLH7LFPtgIj2W?=
 =?us-ascii?Q?7VLvwq8uF6l5auS48s8RDxvE5yjarKS1+hEiSY0NGDV3/sLw4aRCWl0fESZs?=
 =?us-ascii?Q?fQ4H68I/vro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d9rPZqd9BsWWYO38fZBOwzHx/TBRMCcLOaRKgyRSC8M4QuMRGuY3mmFBuHER?=
 =?us-ascii?Q?X7U0UpRrqA2Lq3WHjVC2Hbxhq2usJKvamyqAsfS8BhmJ2JMDUGrolrIY8PeL?=
 =?us-ascii?Q?zxgM6u65Byx5AKus8XtCy0JWLXDyYifKmBRgcQYm7PfWct+CaR4c54ACpFvG?=
 =?us-ascii?Q?eNpLF5P4NaDlS60grl1C3/JvQtPJFatI0Nuu7fAUCSOEywcBWhff1A/77+q0?=
 =?us-ascii?Q?UzwlXTV7gJ2FdbiGNkHO7XdwLSzBxSyB9FrS+1plLT8Kj72H8DFKgMxskKVo?=
 =?us-ascii?Q?SEQ9XNGAIc4yE5ELtg5Co1wGGdqjA3cY/MHWPz0QEsqQmLbEtQIRWvK9ayYG?=
 =?us-ascii?Q?cUPAKGC9AF34mcEo5KZwT04DyvJmJGDOuJgIXrVVfOBowiJQu+nFhDsVfAwQ?=
 =?us-ascii?Q?5cv0ldxytFZ5yJg9I480RRhNQfGuzRygjASHboEL+gemagu1NwPYYB7x6Sx5?=
 =?us-ascii?Q?n+f+W3lNeav7jHbEW1aDaNKLhbAHczQU7oAuFK1dW7qEjlUDJJWwuWDy68Qb?=
 =?us-ascii?Q?o58h5Em6dSNSk6x9cbnmY0rG5yOkIBxtqauSZDcDdTYWrMy+/dpxWT9vciM9?=
 =?us-ascii?Q?b784oPBSus7YKdu6X70FQeXtxTaBq7c6a3LTK7UbP1Z2Yq768umeOUp9AEVX?=
 =?us-ascii?Q?Ku+wO8ZNlW2OvAqaXm3Hu8g+nkdquFHgqh1OWdaqbYooXdF+e9AAxiYyB0J+?=
 =?us-ascii?Q?1IYsdoatnnLCn7aTKPil1siRMZdOfrR4HSUgvNFxkLSwnW+k1+9OfR57hHS8?=
 =?us-ascii?Q?qM/WQdOmtbWTodlbJU50Ag7GFAB4VuQu7xfogXpztEbgtfUodGBXYtA4oMgC?=
 =?us-ascii?Q?6KkRCZ9arVqSCUQ0TKy7puuO0CHXe86KoZpJ7fW1DbR1C4iC1qSGlD5M9DdT?=
 =?us-ascii?Q?q/RrFr3dYd51v6sH02scMFrw6c0BFtNn8uTeyW3be3qLzma9Aq+fN86AuAgU?=
 =?us-ascii?Q?NdLvMjrPCDHpR1Osnh1AzguywuQu5iF4kEEvgDNIOVyE87NYrkHElZvKEMvX?=
 =?us-ascii?Q?T66vyWhPFt61Y0vSAdmOLTb/ops1Z/5O9VMiHJViR8FJWj567JzPOkDuDV1J?=
 =?us-ascii?Q?imIajPS0wpimcB8G/JbDtN1upiP703q1q1741DzP2XPvXc2u5w//FApBkjtX?=
 =?us-ascii?Q?llVXsVfDZG2ZZ1azCZsrOSJLNa8NQTd8Ho/SeXyvI8HhZaeqMn0Rv9TBwWLo?=
 =?us-ascii?Q?zwVb+WbBPCoSjjaGD9PW3589VH8Wv5He0v+VTZrAr9jgRL9mfxTHvBBkgtQC?=
 =?us-ascii?Q?y18mYQpUFnoSbYi3jeK8xDuSrhNzdhP7Py8cNhOsfJoFfZBlRwfYgexG1NNM?=
 =?us-ascii?Q?o3MeZDy0rLKTMefTvDC5st7vFmi91KWt4yNAVpKtH6ubRP/z044utMN/DJtJ?=
 =?us-ascii?Q?ID6etJWcc4I9MPzFWpuksvmWR97t8Dcp9JoNQo+rOJqs6gdsKOPv3oFdjfF8?=
 =?us-ascii?Q?0ptPY5K40QOyCYf1qDzSih0YhQdZfV97ezqHw9dc6h0W3JPFOk1GDTF2Erbr?=
 =?us-ascii?Q?CZU3AmieaXaLVsdvNcsxEvovgFpIZ2xdxJHeD2tqVLm9RK9K8/vvnmMEmiAJ?=
 =?us-ascii?Q?uHsm0UE6UvRRRFbymX3aV7Ke7n6/se0z1Pnxje/Oz1+wx68VqA+HF04d9GdO?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kihQRJLTvmxGjS/pdzYMJdds2JOOTgONAiF8HqdzmoTqT9LKWKeOZGOf25zosztSYEgXYUOADV1mqs0s7cUWIziUFdb5Xr1dx0v84kHj/zzDoRX2LwkSEhiX9AfcP8qweneRQSI/eHJR1lRxjbEgrgam/vHjCnxtrVpippy4wO6+owIBRCyNqry/h4S7F6cY3tEO3Yejb14gpVJs990PgsxfGU2X6GQk5XJFZ6wyOcrJiPmZ22vaTicFGUiNNRMS4MlZ4jVpwLWy3mbIN3uzTBpDjhKT2tTGi7Vto+u1ElEdZ2XPCFrhRT3Up7gP2P11/2FONp2vTb9QFGqqOHKms+CtTTo1s5pwj2jNmbb4D9PN6O9YdG9WuBeTF6CJiZAnEVkySHB5SW7322+54QmJYntGXHA8ftAKilwDN65N72CxE5B0sJGDHFm+GxbN6b7RaD2+DvcyIysPUByaEVNp9CLaHJSOzBRA/7dEf+R+ykTKVJnRWYJ/nlxEnlPB1nI1HjrQ8e/ziC7hSI6RW/T33JGjv8l9c+RzTgK3e8Irw1bGgCruUBUfB4PwT2SlwlWXxQsAIYp8nwTfzl6qm6tb+QeUIGeH1cwVJwpdi6unuIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fdf0c8-9622-4997-e834-08dd8aea16f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:16.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iimnE/9M86qg1zXHAS9htBhsvUXk2VlFl88SONidPRYoOc2nwK7NBCdrUmvGrOsBC4VZ5+bQRMQT/7BPVo4WQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2G6ry7DAxait jgeAkUSGCuthm/WuxbTMv9y9UmrdhFfgqHSlEyVDjMay50rJk7g486eb3qdyjOoi2lmTTswsiB4 SyaxeNHMxzwFI27bSgnx84hpllIGokp16giqF/Daom6oIDiFDN++GH9I3RXYqXnFz7sJyTYuP0Q
 XAUSzLl7AUHqbyIftqG6FF+2Jz06ivzaG4gsEYbOBknHEtfkNcMq1ecVo9MtyQz1OkOqSRd4w8B uQqgQr+zdO3mAtJdUY94w8+Pg3me8Or9VyEraD1DviR1oTDudhLsVpHcG1CnWMZoG86HmubnXVB y0Ls2hahjSRVYJUlG7GQai/s4S0N6Bn7bdKUD7QI9g0rD9S2wb3DYDKYq/iWkapZS+SqtXlyeP7
 /JGRsv7CTgJsBW4SoBb7wAhnOWkU3NV8+Kb3+cbnklG4ypmaeOuEQCejZnbw+IggyNp8utJn
X-Proofpoint-ORIG-GUID: ZgNLJoo9tdu3MbxjnLZ0bemPesfymgKC
X-Proofpoint-GUID: ZgNLJoo9tdu3MbxjnLZ0bemPesfymgKC
X-Authority-Analysis: v=2.4 cv=bNgWIO+Z c=1 sm=1 tr=0 ts=68172ca5 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vofBRnjZkZwxpctGmH8A:9

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.  Note also
that xfs_calc_atomic_write_log_geometry is non-static because mkfs will
need that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst | 11 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 69 ++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  4 ++
 fs/xfs/xfs_mount.c                | 80 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h                |  6 +++
 fs/xfs/xfs_super.c                | 58 +++++++++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++
 7 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index 5becb441c3cb..a18328a5fb93 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -151,6 +151,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   max_open_zones=value
 	Specify the max number of zones to keep open for writing on a
 	zoned rt device. Many open zones aids file data separation
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index e73c09fbd24c..86a111d0f2fc 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1488,3 +1488,72 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log blocks and transaction reservation needed to complete an
+ * atomic write of a given number of blocks.  Worst case, each block requires
+ * separate handling.  A return value of 0 means something went wrong.
+ */
+xfs_extlen_t
+xfs_calc_atomic_write_log_geometry(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount,
+	unsigned int		*new_logres)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	uint			old_logres = curr_res->tr_logres;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	xfs_extlen_t		min_logblocks;
+
+	ASSERT(blockcount > 0);
+
+	xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	/* Check for overflows */
+	if (check_mul_overflow(blockcount, per_intent, &logres) ||
+	    check_add_overflow(logres, step_size, &logres))
+		return 0;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+	curr_res->tr_logres = old_logres;
+
+	trace_xfs_calc_max_atomic_write_log_geometry(mp, per_intent, step_size,
+			blockcount, min_logblocks, logres);
+
+	*new_logres = logres;
+	return min_logblocks;
+}
+
+/*
+ * Compute the transaction reservation needed to complete an out of place
+ * atomic write of a given number of blocks.
+ */
+int
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	unsigned int		new_logres;
+	xfs_extlen_t		min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * use the defaults.
+	 */
+	if (blockcount == 0) {
+		xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+		return 0;
+	}
+
+	min_logblocks = xfs_calc_atomic_write_log_geometry(mp, blockcount,
+			&new_logres);
+	if (!min_logblocks || min_logblocks > mp->m_sb.sb_logblocks)
+		return -EINVAL;
+
+	M_RES(mp)->tr_atomic_ioend.tr_logres = new_logres;
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..336279e0fc61 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,9 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+xfs_extlen_t xfs_calc_atomic_write_log_geometry(struct xfs_mount *mp,
+		xfs_extlen_t blockcount, unsigned int *new_logres);
+int xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 9c40914afabd..f639af557b4e 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -740,6 +740,82 @@ xfs_calc_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	const xfs_filblks_t	new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_group =
+		max(mp->m_groups[XG_TYPE_AG].blocks,
+		    mp->m_groups[XG_TYPE_RTG].blocks);
+	const xfs_extlen_t	max_group_write =
+		max(xfs_calc_perag_awu_max(mp), xfs_calc_rtgroup_awu_max(mp));
+	int			error;
+
+	if (new_max_bytes == 0)
+		goto set_limit;
+
+	ASSERT(max_write <= U32_MAX);
+
+	/* generic_atomic_write_valid enforces power of two length */
+	if (!is_power_of_2(new_max_bytes)) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes is not a power of 2",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_bytes & mp->m_blockmask) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_write) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max allocation group write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group_write) >> 10);
+		return -EINVAL;
+	}
+
+set_limit:
+	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
+	if (error) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return error;
+	}
+
+	xfs_calc_atomic_write_unit_max(mp);
+	mp->m_awu_max_bytes = new_max_bytes;
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1161,7 +1237,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_calc_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2abf31438e0..5b5df70570c0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -237,6 +237,9 @@ typedef struct xfs_mount {
 	unsigned int		m_max_open_zones;
 	unsigned int		m_zonegc_low_space;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -804,4 +807,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 04e361664710..c2c8d8aa487c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1364,6 +1368,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1548,6 +1588,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2162,6 +2210,14 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d5ae00f8e04c..01d284a1c759 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_log_geometry,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


