Return-Path: <linux-fsdevel+bounces-50557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDCACD51D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03AD3A470A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062664A98;
	Wed,  4 Jun 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNWmnvQo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJDW09m9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4981E;
	Wed,  4 Jun 2025 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749001763; cv=fail; b=i5cTdLW+EuwAo0Sz9ea0H3Ke4yOXcDJZPSVLa8k1fH8lK5vYXlLoOiaiZYoto4nddJklRw1BRXyyePLjPot+m5jhROkZDotMUfSFEcQt78iEdPaUIGR3tsAg2ZbPMYobhjo0lXpoSp9v6qMfJstHSB/7cybaLjyjZak/Lx6TDFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749001763; c=relaxed/simple;
	bh=2vVmyWekkn16T2PIA78Hqkp8xJYSAO4txSakub8nAaE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bG6QEYH+VBCn4gctxwmi8+PtpLMfcKkyUaE89xxnn0R8uXCuogx+JMQkvNJcwiVepqmuizfX+pZpWr0Dv0qBz2w605mQdI5gDyqfTTQBz9DOKTxXuj7sdB1DZvTnXJ6Up3mXjhhm8a6g48ecr0cSW64uAbwLpvGZKINn60GPdsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oNWmnvQo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJDW09m9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553MN0wX027665;
	Wed, 4 Jun 2025 01:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eam5j9Fw/Hgr32IQnw
	uFXhEf5MWJ/rS58XZj6ewj2G4=; b=oNWmnvQoXEoHduw522uKZOQJA5ms/8dKms
	hhglnyZdYTh4hnn5qqfGaZWckecv2Rt4N8FveiFWj3cZ0OUTALa1YeA7YKfdJKuk
	X+W97qSr4LyscxTnkRqPVUT5vBatZ7jnkfO1hbgnxIH1vt7IYs7FTeeh8/aILx4Z
	Mj7qZdH16EJfrKS6t6cmW4ZQMzN+NAZAmykwcaEtLmdDW44faAGpeY3Vs6XGI5Oh
	DXrr2aRjvhd9PY/QCXD1LMGDUXc8IJqhJpP0XhzzHNgHVDmUZHUzLsYpN9e8Am39
	w2p9mG+Ks1Nd4JI3D02O7JBtVRXaMrDJPRwv1SYclIsm6KNkogdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahb3mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 01:49:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5541ZRwE038505;
	Wed, 4 Jun 2025 01:49:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7a6nuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 01:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph2h1aRlbYhvWFqkXejm7VCjzxCN3y5y6mKQEOJSyc7s473siNJGqPVmN2/7TVqpWE6kT99E+3s+xYtD5/cBiFAs1An4YE6l+rv/mSP4FjVjDahVCCRHemKRjDMP9WLSdQzJ166UKT5sqtM4ENFQKpC4HfILLsrQkP53aze6nz4Lai4GjCZ67BTlazRkSdOSStRS0h6nvJlFSCIuMpCvgFQiXsmup06I8bY/1Rsk2o3NR/NEGkKNOO0BBGPZyNLHpzqDKrSGGg8wfUatWNvu3NlY9odFzG0NcZVdOMO4PeF4wQ9sGJrjBRS4HkuTtbS4jFDNjd2AZ5yUIJwfn9d3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eam5j9Fw/Hgr32IQnwuFXhEf5MWJ/rS58XZj6ewj2G4=;
 b=byEHCcCCMfXAxULO6PHGTc2KGlgv609Y7AzOlTCxGYbaTEicEpOIZGAbF6YJLNf4JTU9ZvN37h1jaQjgZUdeuXNW2VuQmEA9HLoB/wRbZir7yOCv0QgQBokOz3LAqxT7lfC4ydwDAZw8HWQm4g4x1PUjxYO3pTMohozqZ/kVxxtKzHg6a7N8IhXGUkcfydS9EMFMvnglKISN7L846swZ0YSI1wZimsHoxhC4KW/UJNJlj37tfSYDQhVdKIUPN7KHNA9QkfKLXD1g8q2kKcomD6mI1U3m84NINeHDJ47xFZsi8IgT04BBXKmVivjX2Ra3HwwCWHLtHADaWD6ZsyfnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eam5j9Fw/Hgr32IQnwuFXhEf5MWJ/rS58XZj6ewj2G4=;
 b=YJDW09m9fMxQJ0NhYcROFnJJlKszL5Q2+5TmxFHNbAreWG9tBMzgJ+7v/mMew4WBIvx6+1RPM+BDRpgLU+dkDd84LX/Mt3zvdurf6MfS0w05OiSXcNTOxZ6vNm7dK6T3/lHaM3QkAw2mLBpO3qCZKjV2kExZhOW9Up3zR82NvSk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PPF26D9E501B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 4 Jun
 2025 01:48:59 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 01:48:58 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta/Anuj
 Gupta <anuj20.g@samsung.com>, jack@suse.cz,
        anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        brauner@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aD6WjAVeSL0tNv7D@infradead.org> (Christoph Hellwig's message of
	"Mon, 2 Jun 2025 23:30:36 -0700")
Organization: Oracle Corporation
Message-ID: <yq1jz5se0wc.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
	<20250527104237.2928-1-anuj20.g@samsung.com>
	<yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
	<fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
	<yq1sekheek9.fsf@ca-mkp.ca.oracle.com>
	<aD6WjAVeSL0tNv7D@infradead.org>
Date: Tue, 03 Jun 2025 21:48:56 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0609.namprd03.prod.outlook.com
 (2603:10b6:408:106::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PPF26D9E501B:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f69792-b16d-4fb0-ae8d-08dda309f8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8PZg7X+pjkGCMJMQAfzWlh37bfAvEnvRKytWvhENT1PD4xEW261dUA4uxMn?=
 =?us-ascii?Q?mkUdBWDKoQOOnM/0yp+1uY7Bo8SvF5dC1kMWNV68PAU3bF9nT/Nqm+TZ1TAK?=
 =?us-ascii?Q?KYAIJcx+QZmH1GvztFKX17b9yIzLSJwTQnr8+xgn9Io7Z+js3DnUusMZkzMJ?=
 =?us-ascii?Q?YMPcH9ySlUcJ07r0eqiepoXhpIaVmF2pWLcZxhQZePznNwZqr+MFZwmRtDbE?=
 =?us-ascii?Q?BouwnlU7veY1kqQKCs5iCFIOavJiUE2xNU0PtDxVoglO9DH+9iQ0xVrX8oz4?=
 =?us-ascii?Q?kiGA8uax8V4vVCbHp+frWag6PDFbVggBIsl2N3b7tlOF+HFhFDkDVAmwSocx?=
 =?us-ascii?Q?5sJvBNXLfIaswt6mvZiLGnXVsUctQT2lp22by92uA1qEVxBg5+oIM/pa3iu0?=
 =?us-ascii?Q?ZUI4+JAnh8Z9y8Ny1Xq20gbxiaf7g2QJwpqElk9OGIl+6g/xEuZRUuimqggb?=
 =?us-ascii?Q?ddUtXysFUplXnhkbIGShp6z9n2BSAZqjmYYh750pDMk11rCbIog5oj54bAIt?=
 =?us-ascii?Q?s7dJSHguXK+RNvenFCHd6At8FDlQoLDKn/rgxK54INpq9PdEfd6ndCrr1URX?=
 =?us-ascii?Q?OblOkTgT4JNGRNY6oFcCA54hfPGyAUbIPqPUfSQc8NR4e53PlfxNT2z46plr?=
 =?us-ascii?Q?tmnKoYYwSfqGEw5ZWPDWa6Sy9L24+/mV0c189V36wq3EgFP2lV9khSz21qGd?=
 =?us-ascii?Q?wQqdSX9uH2UU7AS4czZKcaisH1KklG2bxLowbDYKQFExZgKgjlEfhcVaCYNJ?=
 =?us-ascii?Q?qx73VHaGnYe4NZjPik1iiHSDYBEZE/SY12aPj959Cxk5XIXsqkX+U/xB86qp?=
 =?us-ascii?Q?p6joInmg3nR+NflveSsKhiYrqie8pkNqxQCVxJ+CTuVf/I9sc1sdPqBlBr6X?=
 =?us-ascii?Q?jBGPaoH5pYoWmAjLWe1MDVxPwnLjRBRDcjHOOKuGFZEdpmKo38ztxjUfKCg2?=
 =?us-ascii?Q?utz4JIi+9SiEzObfkpucixlQVRcwQKgicKTKn+6UY/PmCUotvTnbbrwnDwh2?=
 =?us-ascii?Q?jJZN3miFLeAKz9ABOqCiadGScoJeQkFOCDlGLhU0zWveOxyR9chjMHj4yM+W?=
 =?us-ascii?Q?n2ucTIkzUElEJmUul7ckzlY+w/l3gq9i7XQre0hupoRip27KtjaVotku05nu?=
 =?us-ascii?Q?L454gwBRq9WLHE+VoUGb1XN5J4kyb/D4/LNfNSX1xTylUPVDG0gRHUbDsyjA?=
 =?us-ascii?Q?JAtMwmTwIYXXgZq9copT+vTmHuYsawtlnY+KMx4ede8W9P+fm1QPybyVPlgz?=
 =?us-ascii?Q?g3vsj4P0mn7X6T85Goiwn1X73sNoDZzWQBiB72RR/B+JMnl7qIRElKfrmA+B?=
 =?us-ascii?Q?faTX5rcec/3LsqGTErsT5DQUvdihqENyb70+E4ON5LhXCy89gswAgPosDlFp?=
 =?us-ascii?Q?Tws3J4CQ9XVDkaERNvc9dKAyKxl/abGBxiVmB+O2ySTRvCB6oHvcRXTLv4Wo?=
 =?us-ascii?Q?9DvZ8LjLrrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34p0kaWjGIIeOxQ40usyUTac8aR+Qdjb37lxX79cyWb/e1Ud9dg8FsgoY/hT?=
 =?us-ascii?Q?QxTlnptnKHl15XVkTKTfyxVS/gXolKXn25QrQyCVJguUZwloexeIXPNaQk0u?=
 =?us-ascii?Q?ZMNlY7O9+Bs0MAzw9I5DSINWI9UrZDTS9lp/w5GLOYOkO4eZAv4XfiOhzw5T?=
 =?us-ascii?Q?L3eBo2x3k5u/rB+L09cultHt0Q5vtIKhF/RIAjzqAprjk8Kc0EyCNWpDluzc?=
 =?us-ascii?Q?OSwCmrGLmRArQBRbIJcOne459L11/t/B4YIDdkBOG0tvr4Grkrq3cmb/jGiF?=
 =?us-ascii?Q?3Zii8SNSscHUnCKvdD346/cZTRKvPwxuGF/jdeFXGaLRmuH622QRWdEn1xnD?=
 =?us-ascii?Q?09UH9KaTAJhTA7eCs6et0HYwd4zpSy2R8fGIcLNubuXbF4a1SIv5yIaxkZku?=
 =?us-ascii?Q?uIBaKjfxnwyhoCBuZ4QMnbaqRDcXC4ei6WLLfgZsCn1JQMVaHhQhvmx4w+jj?=
 =?us-ascii?Q?P4cYDWFy1A0OKcbtq8KdBAEz56LzAQ+fzatyYLionxZhSqnSCL7fLzaE4Ose?=
 =?us-ascii?Q?CW1W3wKFq7cwNwJOgrHIGkpuwGzdmrqmGIgqETLWVR1uMz03QcaDKeN50gFE?=
 =?us-ascii?Q?1H96YL5X0z6nzm3Teemwj64J/Bm9V9PPgoP24+zqem1pqugxjF9GhpizUZ5N?=
 =?us-ascii?Q?SJ40dvUhUSpG5adUacp1LMyvKvhLYXreWFcl5hNNtn++jY87eaBwku1iEUXe?=
 =?us-ascii?Q?s5C5Jak69ZEYQdcWSqalAmG6LmYK6s1MVySTfBp2aTm1c1geoIO4RrE2klr+?=
 =?us-ascii?Q?Q5P9Z737EfBuXJb6erwfO/+EQEPUQ4SyBVi7RT0H+xDAbs4GqK1EL2NuU3Kl?=
 =?us-ascii?Q?1EINZlKXJSeUL03Yh18xtTLf518VH63aRBXASHAKQ6CZlXhjpTAODpB4z0D5?=
 =?us-ascii?Q?SQmnamQEoZQIQApV9N4q9sQtquuSQAgTvLLEYxnqA0ssQkpl34jiIVb9J2e7?=
 =?us-ascii?Q?PXaRF647Qaz0Ga0SM7z0HmICPzc2D3XHxkFK85qHSyGmXAVOCN69ikT8BuKv?=
 =?us-ascii?Q?GCXEyFpotkNIkO6ewsJylL6WKz0/73fF4ghvDPrExvx4vrl05VXfpC4ynjMd?=
 =?us-ascii?Q?D77qy9eLzlAk0J1QemL9xd+2xhnH56WdC8Z5fT2JtKZojC1NxRXvLT7R+xu4?=
 =?us-ascii?Q?qa/Z6DBsWqjdlWxCVv4VD49P+pBQ3Uud4mAkf6aV2kp3S0PbTz2vsHzhmq6F?=
 =?us-ascii?Q?F7YAjCe/zqT0q7PtgExkvjw7qSabiZPzdG/BtUXcC8QEqlkSSnR9aT5IcOtz?=
 =?us-ascii?Q?n1VdvSCkqqTOQnc/FsPqmvkTpwmg1iI1APjnnEuO6yHfxjFkfVxQarapITeG?=
 =?us-ascii?Q?/f4TvZY09SWmH5HFjYvA3V80kivFLK94SR9Z2k8454d29JWDDyB+lGT1ydil?=
 =?us-ascii?Q?rJI3Q2b8ywP73vLZCf6WmIkGlwCs0C2dRTErAKKkr6HohOsVukFPsodIQl8Y?=
 =?us-ascii?Q?Ry4tUGv9zb/WusSk7KBPeSdk1S3gzIJLyDgdg6aHZLH7NyzI4UbibRRDwxi8?=
 =?us-ascii?Q?7smtmIKA0a2v+pWflEZAjosYvyqwdwgG4r6c4xiVZV8HIekdOGeYal82BEEj?=
 =?us-ascii?Q?Ny6qlZyxGJCRIQeDn20rPUs1tDJyiaXvWRdAen52tlk5Aa85WbOs1DFtrvN3?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Clq+TVrHcn6QKt/VYCfNlzXJ2v1RFPuHI/tYfrt6GdBk3EAfHW6kBtxfx5XtC6+8pH2Bu7Xe5vaOwBtSSDYl2jn87fyH+/NEGpkPwpLHV+aBf/Rt2DlkN2n3NjQMaUprL8sLohd2Gw9Wx5GYwqbc7T+EqZCgClGq/94tCLfIibqAPdrCF8YLVgUxWf3GHNTfTXXZrwu/DFn0EfTEHkG1guXORLjmcyz9s69tbNW8vXdEg06bP/vPerd1MrC9REwCZz6K0tkAznGNTy9N0sFdbW7djz7FJs2aAB4LlmsP01o9gXGjXLif3fMdSHPMdOh2DAPE08UG3a4efjtF3AKJX7nc1Wf0v8iwj4yEWQBQUVlzBCW/cJspOQqbsKojKrntqz2WDiKtbPI4Tg62meJCOEAilD8TUd3xbllwBNkVIAzGt65Qg4IeazoJW0imfU8NxfOxneYHw6szywMNhQ4nuAXiT4cIQtEOo9C2JGSlwBfbckATlfcXYa7TRtnSTS/9GNStoT8swYCdYGBm2mcXXeX1bw5Z6LI9aYlKP8pcy0yFdsL/VjYyUK6DeXSOJpAv5z4EZ9PX2p1RDjuO/BTpUVu9GVZ6A2WgGpLIJcmsuRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f69792-b16d-4fb0-ae8d-08dda309f8f3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:48:58.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZGUc4j0JuAidIwFBjtLLl/D4uv27wDAJ9FUOSOh/gVFToyd2dBEoXcgN7Bgx962eGhKcDvU45VhcGao8IBH25cThosT+7EaYTFrqRhGKuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF26D9E501B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=697 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040012
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=683fa60f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=8LBpRy6bM1bJYx1OpK0A:9
X-Proofpoint-GUID: _flM-9OfnCbDZv8-uNOhgxut-7ZlgsG6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAxMiBTYWx0ZWRfX1Nwbl8iMeCAN i0YqImpakPoRwlyhbeIUJp2/jxNi6uM/OvS4ISFgbLwXYc5CGXV0vY8qVjM7LnlrBmkeVFI/bIA MZ9vTs5JwR2s5QqkiFevhGhLWDNW1P4iHrcoETSok80kWmYmp/sozGMFfQDLwVzqAczEdekMWCC
 3W1wNONIhlcajfX6xeL8Ph+quRFXl+npKFwWtygqNYXehdiDp05X75j9Z4i6RDcDdcBkJdGgTGG pKRutnvb6Dwd0o/eTTFFjGadbSG3ho9m41QoVIAxh4Jd9wzFVbPO2UH3gmQwLgkgbUYuZ5XA1hp DAPynCnAYbo+bYQ4pf8AAzDHeND/JZaprQjH4fvOdCX+LRQ0qpF4/jhk86iOBGL61oT0FyDANO0
 ciLVrbEvehO7bXxKYgXhjXvQPBKyBYd4BHLGaOTnWwwHmCPrBPlZ+y3VACe1obsK00ilAlQr
X-Proofpoint-ORIG-GUID: _flM-9OfnCbDZv8-uNOhgxut-7ZlgsG6


Christoph,

>> It would require quite a bit of rototilling to metadata-ize the block
>> layer plumbing at this point. But for a new user API, I do think we
>> should try to align with the architecture outlined in the standards.
>
> As in exporting the total metadata size and PI tuple size?

Yep. An alternative would be to have uapi defines for the PI tuple size
given each of the checksum types. But I do think it is clearer to make
the sizes explicit in the returned struct.

-- 
Martin K. Petersen

