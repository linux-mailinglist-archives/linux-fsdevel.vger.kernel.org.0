Return-Path: <linux-fsdevel+bounces-27874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF179649C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EE2281133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE101B29D0;
	Thu, 29 Aug 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahu2+OCX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LZlzj02K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FC1B29CA;
	Thu, 29 Aug 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944692; cv=fail; b=AxTFIovZTLmPP/Cz+d1cdWc7mD6551ak0jU8ri5xTQFSBHYS1/QE67XUMCAHrSD9mbFGbeEBELf0DzR9R7/BaXsdTmV4N3blqujtZx1W1jhBY7q2/jRge6VLD4Rresa6jBr0KBW3MNrY1ef/rpJfUx10ns9SMcWRiGJyysVZQVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944692; c=relaxed/simple;
	bh=SYc/unyHofZTJGZYzI2SWDg97oGGsScvIcGmhFZf5U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azf0im5sUWN/kzIsWXKYRdWN/DABhFGBIOoaGQC6BMerUfRDtTejCpwp68Ffr/fd4amic0M5gcfRRhxpPMkE1ywTommUo3W0v1kbBDylgs+YFg+Xq115yftSKnqTAqoPUcQs8hRWmE8I3pJ/MV42XE7V0zf0TH6koCdp4BaPLek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahu2+OCX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LZlzj02K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBweVA012341;
	Thu, 29 Aug 2024 15:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=bvl9TWXA+Y+LzN5
	OdWUOsbACvBCbcFfH5DFqKR2IQrA=; b=ahu2+OCXvHdALsyDgsHkjCDQzBTkzcz
	NGdKb3dI/a23oBO7TC32PtRYTAB7WamEAdNH2hA80GAgcXLBwSdf1y/SEc2lNbFR
	emZySx8NGj0gykz0PmHr4WGTowxdYVe/V+oAQMnKeXY3+hDIyIbpjEtMHojHYqsy
	nz1YdEuIKPMh+ywamps0aUPAKAqZZzGoSgkupsKNveWrQ3diPGCMhV7ECn/13xME
	c2wN/6clULY6uuBn+mTSpRQG57xKoxP9s1bcjWZ5Zu0U6aemos6wVeACoK6hpQaK
	AACYffzY0q7ClZVDwo/o26AJpIKGLKNTsNqvnk9shYsN50E9ifcGONw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukmc5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:17:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEep61031845;
	Thu, 29 Aug 2024 15:17:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0wuybv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuVg4rsVVoddjcotRzOhU9InnHOMseXbGz8cPTEqgrJSc3HJeu0cy6Lz4qB2Nuw68dF1ugOq8uIVGS9v9KOJ39Au/pHH4hVVkpz5AOogkfM1QPlu1yPNj5K3+KRIDBfGvz7MwVEECM5PsatXAC2defSSGVpPtCF/Buhyy0nfiQ1p+DbYl4KvGbZgj8QUB5uh6AsafvtlSjDFRUZklruYo0SuA3PxorLKUqUaLf8tZSfOF6hph1jhPsyTYP82pLY+jww//a8vMxknreL/CnxMF55Hv5grxLMT+rsjNJHYApHh4Lbr7Ag8usmIgHeU/UA99U4thPpp2ZA7Y9gXWPeYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvl9TWXA+Y+LzN5OdWUOsbACvBCbcFfH5DFqKR2IQrA=;
 b=tsP5NNEoNlwFXhK6BqxfCzLPGBU2iS9KXT8DkTIVju/9wCvo6m8E4ufTf7CgMNmcY1tZsPxB+ULV7euRnlOn1HbamLP37J5eGMxUQ08aroDcoNB4MtapiMJN8vHWwUlc9+D8VgpqEnV25cd0yLMiNcE+kkngaHAFzeCSdVuWr4XtKybho1PFe+7BBwxPyM4uJtm0rmDSjWxiTFAsWbInT0V64I+94YKLfOl0Rf47xHDSst4aZ2C7kC8NiN2D+9M3lP1vnlB/EGiILZSL18IKCPKEwn7dhxRHIHhSb8h9YMKFgOn0lgyZzl4YsovuZIaBWKV/We6aQggATL5DpwJvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvl9TWXA+Y+LzN5OdWUOsbACvBCbcFfH5DFqKR2IQrA=;
 b=LZlzj02KFcsD4DcKNElzxvhOHQeqfov9trm6sLHaWybKlNMwibTcVA5Dlu3X90ja+fkAW1I8+QsxiJErXWaIWDM8Et4ltfCEbPb8L6lbCmQPdGdcT5/AdgLyG74ptGkT1Xs3ad5HFuLRh9YBrQF78csfSCWFj6NARKYAscSGp4Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7849.namprd10.prod.outlook.com (2603:10b6:510:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Thu, 29 Aug
 2024 15:17:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:17:49 +0000
Date: Thu, 29 Aug 2024 11:17:45 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/13] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
Message-ID: <ZtCRGfPRayPPDXRM@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-1-271c60806c5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-delstid-v3-1-271c60806c5d@kernel.org>
X-ClientProxiedBy: CH3P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 606b2405-6fac-416b-188a-08dcc83dbe35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWK3xv9M0JlsJ2mvF5QcTgKPn4t3/SzJUrB36v3apyL1uNYRLA9g9LC9PLw9?=
 =?us-ascii?Q?mPBnplZ3NdMSDJ9C/9+b9BPkhsZY71+x+kNxFCt/oSDBaJP9XO2aM97BrMvQ?=
 =?us-ascii?Q?+cEFY1CD7XbkSg5tahyCN/XxYUdLkBDgFyUcrPCmG3Am9uQH/L4EuDwBguRp?=
 =?us-ascii?Q?etKjLil1Oln0Q9sTALpTJVmIIyK9qf8WQHiDJF2qo7t8jKGwrCFTtpdazCVe?=
 =?us-ascii?Q?xY0lZAYkiVGx4QNQsywdxxZooTqvvwiNtgq0L3veylQO6334wM1mdG/q0lV9?=
 =?us-ascii?Q?eey4nUwV/EkGsPNjUhABZ5zX3iHtpQxmiQSuB18MDwQOkeWrIeyXdV0sXsYw?=
 =?us-ascii?Q?iEvbxPBUA8di3Pyik/tUfvQLQAE/R8N1nMHIOjbCDGyWJ4D5zbCfC0TauMHn?=
 =?us-ascii?Q?2ElvUuBrZoKDTvZAHRucTAn/zPFOWXhQTVY9H8p5p1C3bPtd1Dg9HCsMCzp2?=
 =?us-ascii?Q?aAk0cU+5IgYtWJYdUYBdiRHg6TvoF44gyaDzaM67sUBVcBXLOYp9Hdat5dch?=
 =?us-ascii?Q?tkUtZGxQXfukGQhI+VQSRM7Kx8Qt3r360lKc00+vUSHUIzfinm2mi4m0e9a9?=
 =?us-ascii?Q?wnxYiYyCYTE8p79JiLPZTl01RLwYJ2T+1En/Cc38EebdqyBrHvnciX9oIiMX?=
 =?us-ascii?Q?2uvcf3obXyVwzbaQQulByYC/TFn8bZLBJCV2RRgiMtGAPJb4CeRdE0nYigMc?=
 =?us-ascii?Q?SFJpndCeQupLNNmrdqkJOCRZ2RyDVcW0ADuLd+ONykTzXKqD5byM0p3ria/7?=
 =?us-ascii?Q?HW30PyjDJzVLgm26dsBu544hbYZUYMavUqj9EVjgVMHgpxWTTTjfR4TVjqP8?=
 =?us-ascii?Q?gwR+2VJI8EuTdvFvV5BdQmFLTZQcTc8wQaH1YZh0LJq08fBuWfz/swsJwLbH?=
 =?us-ascii?Q?xoHr6bmlT9ZAV4y6wj+tfmQVDMzqhb8SfrszoJdl1o5ycRRODAfM4Mu1rrRQ?=
 =?us-ascii?Q?FKLiwnEpf8VSO4GOLIHzMYRs9buK0tJFQim+wql0yB1bRfK3t02OgE/o7yQp?=
 =?us-ascii?Q?U/9b5ICnk5uzd1hqIh0KYtCxH+ZterpgeTX7/tdtuMyta9xtdm3th9X1ml/8?=
 =?us-ascii?Q?g/SG7Q6rb8MWQfpNl+P+SYw/McJcrOzJ1CWcWBqI3GYBOPiflHbpjlRK5wRl?=
 =?us-ascii?Q?gyUoHjoV8n9jEQZ7mvoXXqJHk/9e/so4cT5GZM6LtckSCbOE0wyLocvb6XOj?=
 =?us-ascii?Q?Y31ZvsIysrs/YHO4hnQazK4iFGrYMfqEqeJKs1tlgerfhM82sX+NI4VZlzw5?=
 =?us-ascii?Q?t9aLr81uQ1LH4Ml9amgRbclnbhyHbRL9+YL+jSIlAEHr/HmQ0K8NhASdSbBi?=
 =?us-ascii?Q?RB9njW3fOCFFIEu8IWaoKbCVqHggnfaJuAMKY9ZJ6nO7AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64CRdlo+87UsFp2P4RsAC0FUB3QfC0XhTg5DfAUqfEma0ccScMe6Y+33elju?=
 =?us-ascii?Q?eo8Ynh+MZGlkVVYr3WUfQSUg1cw6X60H76UGXksd7RDcnSbqH/s70y5gTOUk?=
 =?us-ascii?Q?Bjbx4fdSPLyB2AnN2FX8+Otg6HzTnyVccAuUQwhGjP/bd0ZEaZFn3CG/0PG0?=
 =?us-ascii?Q?V3SJ0hBIN7zGNFCA20fpo7lJyareFQkAHPYVge9z5QrhZGi0Lo1O71MsojBN?=
 =?us-ascii?Q?lGlhoIEk8gXofz0bFGrEiFunq70yUNpcJGND8rsAiSFCSJA4i82plxTjGqf/?=
 =?us-ascii?Q?sm54BqQkDVH10f9Aa0yEPzS5L2w0IYNb4BGOFWY8eSQrRY0xq+wGCdyG+IPG?=
 =?us-ascii?Q?9hVeDaBh1QyjkMzH5LrYKwem6SOBnQXLYYJ8SZZDU9qQPJtMVaLP/ihB5G2L?=
 =?us-ascii?Q?E2HUNRo7dwVN7vrNvaTaAJjDC94TZ7W4RcyCXbebhZmJJeyTbMpJ6lEOq1nG?=
 =?us-ascii?Q?npl7E6DyqckKtnXkzlv6S2S87l5PeDOdzOIgCJxa6PCOuLipCbakZ4DYjsCJ?=
 =?us-ascii?Q?qQF+Uqu1lKDD93tKxRZZeR28JRNn4cpDgcqEepW2JEZ9fDkcQiw2wVpzr53v?=
 =?us-ascii?Q?WykjCyVIS1lDF3yNYKdH0uhTHf9WgwOcPzKVULhQUAAC21k6YRIDOQU0VEli?=
 =?us-ascii?Q?7QaKli/eOuwUr9Czs2UN3ckgnaiKCMGFgdABECbR/3IQvodGnh6jTIDmeBmz?=
 =?us-ascii?Q?2E2G4tzQ1lH72Yf8IJieeAq+gu+zFVer3f2GSkGa15MYSwH4eJxGRlbIZsyM?=
 =?us-ascii?Q?UDd8IcUjF4J/KCJlfhJ6v2p7AELmku0VrnEpKDpqb9vk18u3Qr8k+l5yQC/4?=
 =?us-ascii?Q?rz1bKar3+a17mkbvgMk/13zdmDDCn2fVI3WmdXEniCgMddN41wKOBg2os5ME?=
 =?us-ascii?Q?YrVLOgmkAd4Uc75NWGPM+SaodyeeayQ5GKxEL/fN2I59BlCnPl2xp7a6bPEH?=
 =?us-ascii?Q?p15//wtergJC6RIThrLKt9zFNPowRqrocqNW9mNgXLENOU7ECCSvo8QGgF9l?=
 =?us-ascii?Q?P/iY+Y3SauKmUSrSWU8a2VA+JZhV/JA08OtXyhU6SZhBk56OP27OCKY76fbG?=
 =?us-ascii?Q?GHFCf2CrEqRElvWg6U/IphTEu5h0iKrOyBfV3IK44/dp8PgUVEPCbrRxQX5+?=
 =?us-ascii?Q?HyQri/RfagUt5A6jrhiNOh/QG5WAca/Iy7bBFUSj8WxE+bb8waD8MpGCr2wT?=
 =?us-ascii?Q?9Nm8qIwZHtB+GB4oDU1iJFshzuOmuSfet0SxEM8eiQz4o7kVAYzncdLMb/Y+?=
 =?us-ascii?Q?XmhCIe/VyJkNRe2dnw49Q1SOG8FjsTbFQoi7+EHcI2B0gt6AfdI3u6QWaiQ+?=
 =?us-ascii?Q?d9Mz52SCGZmDrmQhL/Y3GebkPZmmARh83Ogq2egtdluDUbsC4oFiEVNgGIeX?=
 =?us-ascii?Q?NjCRt+EgVyTCBCfppMPyxQyjbp/RBtSmgMHXZSvbiagd6QEgUEaW2+FRpBbT?=
 =?us-ascii?Q?ta0TGA6gjGqNgxd8/CboJoCWTYBJ39wdZk+C9QLR1TKIYoV3bOSx+h5LNftE?=
 =?us-ascii?Q?9v92IdtXw76TQIu/YeVwWX7XOBQSXfj/X/q0LquPMKGIPaXmcDREXLi0jvUp?=
 =?us-ascii?Q?zlIDj0dMFSK/BQeNBkTf74LJZraU5WDPpu37TOS8tnc7QpF0L/0lhO5ku/xv?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eutfrBJexNYKbzbxrAYwH58ID0iB5NT0JuE3mjMvxhyko/gf4m280mgW3/qpjB3k8YFOWdmDB62I/pE9FNXAIWldLTc/aACs4mpDzvVb6VljZTT1M6BPKBNeTnvg0XWgjbiNbhUZnfkf/ZH6QNG81CxC+HGlLqdq4hEwrPSfIKSCJ2OYM+LXd0a7LdXNvsdNwhM3Nrxt2B8TcToTp9oGfa5rba+IKizVMssQAmPKwLiAh41AmCeIyy8aJuqJw8DFOXVyQ/pVRpNXLlq8bM9btQt75AJXlZWY2d/Ip43t3iHRmdyR4i2fQrLHsPi8GHakkk+S1xeEMaTMrCcvB3QQF/4lpFX49ylcwo1yaSet2uCbt03fKzZSaFSY/f2NO1jdrTDZNt2KwUhVHYoNvcgpwhER0WbevUeog5zHPIm/iwb8lg8YtRokCGHVLCDBb60qeEUODXoCVsN6H7dIqqfYXxe+skBk0bsIdbJs2bGTwbt0cTMA8ndRHZEiAF4P7BdPCDR0kkVqZlFn3CtabDLWJ5TTg+rkVOxnp74E20kth5YoGTS736PdXdGWVCSwNxA57tmeA1GxwGwj/tIec30rwbtgHS93nJ3SJ2QUppgrM0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606b2405-6fac-416b-188a-08dcc83dbe35
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:49.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6Z+tBHzZ8afxjWNlVz4cEhx4pRod66RZtElt27TZkscx3psSvbapamKlHB1j7ml6xcXsVhB4GI4s7WL9u0HgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290106
X-Proofpoint-GUID: yqcmw_p5-kFh4DC6fpMGNPhIj_p3LwqP
X-Proofpoint-ORIG-GUID: yqcmw_p5-kFh4DC6fpMGNPhIj_p3LwqP

On Thu, Aug 29, 2024 at 09:26:39AM -0400, Jeff Layton wrote:
> From: NeilBrown <neilb@suse.de>
> 
> It is not safe to dereference fl->c.flc_owner without first confirming
> fl->fl_lmops is the expected manager.  nfsd4_deleg_getattr_conflict()
> tests fl_lmops but largely ignores the result and assumes that flc_owner
> is an nfs4_delegation anyway.  This is wrong.
> 
> With this patch we restore the "!= &nfsd_lease_mng_ops" case to behave
> as it did before the changed mentioned below.  This the same as the
> current code, but without any reference to a possible delegation.
> 
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've already applied this to nfsd-fixes.

If I include this commit in both nfsd-fixes and nfsd-next then the
linux-next merge whines about duplicate patches. Stephen Rothwell
suggested git-merging nfsd-fixes and nfsd-next but I'm not quite
confident enough to try that.

Barring another solution, merging this series will have to wait a
few days before the two trees can sync up.


> ---
>  fs/nfsd/nfs4state.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b6bf39c64d78..eaa11d42d1b1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8854,7 +8854,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>  			 */
>  			if (type == F_RDLCK)
>  				break;
> -			goto break_lease;
> +
> +			nfsd_stats_wdeleg_getattr_inc(nn);
> +			spin_unlock(&ctx->flc_lock);
> +
> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +			if (status != nfserr_jukebox ||
> +			    !nfsd_wait_for_delegreturn(rqstp, inode))
> +				return status;
> +			return 0;
>  		}
>  		if (type == F_WRLCK) {
>  			struct nfs4_delegation *dp = fl->c.flc_owner;
> @@ -8863,7 +8871,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>  				spin_unlock(&ctx->flc_lock);
>  				return 0;
>  			}
> -break_lease:
>  			nfsd_stats_wdeleg_getattr_inc(nn);
>  			dp = fl->c.flc_owner;
>  			refcount_inc(&dp->dl_stid.sc_count);
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

