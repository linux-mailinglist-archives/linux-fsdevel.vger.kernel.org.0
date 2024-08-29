Return-Path: <linux-fsdevel+bounces-27877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AA964A0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1BA1F22002
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22DE1B29C0;
	Thu, 29 Aug 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fY9Nr75m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A5Zr5R+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE91946DF;
	Thu, 29 Aug 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945361; cv=fail; b=UnUptUIbz9QbknCUIbpLPqAjuYRThMy7f48eS2CWYzXqsOOvTpRipYDK7M4moKXk3HskhT06Tga/ULF2GizzCpDXkz7NqyRKrtDmbzlIjqgNZLyxrKZiSWpX2VnHrMf43n6ZEP3qEubfQzl725IzBHizElPWiAEBjQA+jDgoxwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945361; c=relaxed/simple;
	bh=u33xXs0pwHnYwp9Me7uWrWEWFRzGpwgIgivfP9wGFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUtIouTi5jqkjt4Erw8Md4Yv8RXeRAUBIa2Y3iSZurRXedyAfcSuUcf0N24YVv0H4Y+6BeY8lmu64BWQb2qG3fNeKqOykGv9O+ux4y0YLNd5PUUN1E97RqOS9soJJO8+wJLb5qUBSWpnZTS2kX3GnDwirOY/qgDVp3GYk+sCNd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fY9Nr75m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A5Zr5R+r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T84UMr013632;
	Thu, 29 Aug 2024 15:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=xm7ByHMRbEm6jC1
	uyJlMbiDAmIPb3LDpJhhYbKl2IRQ=; b=fY9Nr75m9AUNr3TtIPcHpUyLKJJoKkC
	WyRpPeTIiASyjlFBhUG0xBamVY8u4GcejdYAgM4Fcy2+WZXi8mw40FHLDcQL4UCc
	hY6aLTe1eAl2nbBeKVmdIJJeD0Wdj9h7Q/JQmIAEeMMPw3LqcxplfIF38ibLEDSw
	8lEfZOc4nbx+OBWHMLuKAOO6h5C2HHb1XUJ2JYtbqnNdNEpfdfCkY8DGSCeTObmS
	UY6rYgiRywWi2/lGmHyqF/sq4lNclcI48VyjPeGVaeVMk0pB0pFuJa5a4c+xp5Ax
	Tvb8b1TwaCXHRg3IzKTxupoEUHU4sJWcbt5LG9jSJGVIYgc6REZyp9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pus4frh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:28:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TF3MGv034856;
	Thu, 29 Aug 2024 15:28:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw58sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWmWG24ouMALi7Hcj5plHBd5cE3AH3eP9UCH4z76xARlVy1+vGIplxdnk13oKjENXXBlh2tZHF7/9UsYv0hLfo9DdDsZR0IZjwMAy9mF+vThTF+1PYpcghmqU397m+NPVSsU7YfMNfEOjLQuvgf4wl1GpKn1FIgPg4ghQYLBSn2MobDYAmxTfLmLqNPlQkRWkpTLBkwSJ1K8p248jXrKcR6wlCAXDlo61lUHf8GmwdajSAFnvqiqKeCMSlPnghJ36roxM4DmLpWhx0+kHlKueKKwe9I9fQdfwxaYlpVcQWqbPZBs2OyGFl3UwojrIFvgZ3P+n5AP+idj0nz3RL5h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm7ByHMRbEm6jC1uyJlMbiDAmIPb3LDpJhhYbKl2IRQ=;
 b=NoEJsTdzEEWVWV1D5ewSac1XVelkpAp5ms78Z0Ca+3/IZwWPV0K92kW9/zIPB0emWLKQK8FN84LUKf+ew0mrHxMO6TumSjfS7Iq0G7jgTz7FLNIUoZDuZ4al84fs2ODIe7XKHaY9GVv1aEwzTXr2a9dy4tDA4XYL0lVoF5fQmlSeT32g1whBWl7OQAkzWzXgmViemBNNb99Fseu90tA1pK/t3MuzS0l9iJyUvzElMU20GGwo/1qi/dcwwYOjDvtC3JOFf6UwSkJopdF/17tQHpN3iwuyQEDc2GyHUmOKO+0RYgQ/lihZz6LrmEVUjlqBy7NS0TKZTA0k2v2mtabM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm7ByHMRbEm6jC1uyJlMbiDAmIPb3LDpJhhYbKl2IRQ=;
 b=A5Zr5R+rJ3sPUPK2KZ+2DD32QXLkKjbo33i2Jj/RnvcHcwV/3FmSRKZpoZbcxlL9Vv71LwA9wJGvOehFSJCxq+FXT7qFnwal3HFowU6LKatFs+QIvhqD558hZKQBdw65OpH5rEaHR6c67bwoyd2c68LLRSY7L4TuKbZ/YxXfW+A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8158.namprd10.prod.outlook.com (2603:10b6:806:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Thu, 29 Aug
 2024 15:28:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:28:52 +0000
Date: Thu, 29 Aug 2024 11:28:48 -0400
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
Subject: Re: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Message-ID: <ZtCTsNfht6O7uxev@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-8-271c60806c5d@kernel.org>
 <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:610:4f::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 86be896b-6399-4a78-136e-08dcc83f4990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUydrQy6298etut2NzC5phDnS+kAfR6Vyaw6Kg2K2JVj7WcbS1wtbz6624qC?=
 =?us-ascii?Q?Kl4UIOF49pGrlUQDIzRa8CKkTXrEHO93Nzgb9B0dXfJ496QVngU+6Qix+QYE?=
 =?us-ascii?Q?2Db6pFDJ24uS9ODeOUoshX8J3vfrlTlSWX7ByWp+1zM9gKiYLAfCd0wBhMvJ?=
 =?us-ascii?Q?dkqyPO2RKM59dZYmFZlQVS+jceQkp3A/facq2YEkVoIGb8/hH+SpBxU0RZHE?=
 =?us-ascii?Q?lhuFm6GTmF56p4XYVNURS8hU8K5cS7Qc8n6skiE1hZ82pS2j3RR3AUvdgWP7?=
 =?us-ascii?Q?I9XvrmZQ19O74gZ8UwagQxiLCos7Qcnwu2ca3gU4vQkEdm/tHmPJ8xqGuaUl?=
 =?us-ascii?Q?xzqfn3EF6CiTRE8POYp9krXn1uTIGHL8Iye/cv7TuTRl16s6KEhinIlmCWVe?=
 =?us-ascii?Q?v7j+P5IUlDEoOLEbejJRmAl/3KPb+esan9rGdkdpUDQfCPdBM84X2IN6HMEQ?=
 =?us-ascii?Q?oR2tPhzcQxNb3lxOP35LPGlo49PO+7fMdhZnKsw2CbNLka5fvgaQ8LClGgOV?=
 =?us-ascii?Q?4V3Shr04WRzu/7hG/u/HWfZvJIAW31/A0BAJ2XeE5GF5f+zlQlDq6lnYJsAX?=
 =?us-ascii?Q?ld4gsQRqWPXDslbpK7bVMcS62TmdSK3xWO2EcmTaVgn1U+SAmtBjDILBvpNQ?=
 =?us-ascii?Q?c1w5MKdlzX9yP8p4+7PJrAS9rd+JZ9me63XRsgIHEwKSMeywsgPAnsCEU5px?=
 =?us-ascii?Q?iV7/n4Iwq8TSGjPUOkfUDevqAnGDAZ3VpfhyI12aXcQ0xS1fi1Z5gcoDqcrp?=
 =?us-ascii?Q?Jm5yFPW3avamI32NDYYX2TKrGDA9VOjrj52swatGF8iZtXePIzzfhQ+w417k?=
 =?us-ascii?Q?CDg+BwNjCQOJTE40bvTerTfYtStDMGRPIcBjkPd2F2IsrGwipXtdDkMhAbuY?=
 =?us-ascii?Q?k6IpjKnc4jxszH5ettnMp1GIs4+3xxxJKtr8NOX2tEb9Ed+5XIMtvemZXmda?=
 =?us-ascii?Q?sLABudVCDyipd5/U79drXUbVciosimEYJ21cQZNc2U16qGN7G8BoNhzjDfUG?=
 =?us-ascii?Q?VYVaO6WUUqxTEfT0VyfjXxUNJaESFgwhL0QpLW7nbHlHRCphTdOPuRSNoj7Q?=
 =?us-ascii?Q?5idbeY0x24T9qnYNWo0TsRSQ/Mw2vqUorJBcO+/uv9mNHPMuMovmysX0T6AC?=
 =?us-ascii?Q?6grKUCkeDf7Szm58RUYFt/k0I8khm2PeLcOpg0wDTJImRgk7fqW/1ZWXsNJA?=
 =?us-ascii?Q?CoetSnHZRA330raKvD5oia2UkozkoHvA5YY8TTGcER1BQvrANUDhh1axYRWc?=
 =?us-ascii?Q?v68MhLNOZ7v6PliBzvIM5sv2H3KyMCyXeg29jXTKRqXOhjVO0y/az8i1peJt?=
 =?us-ascii?Q?6To=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqfz8BBxaeFS9kCWdA/u2KtMgicTS1Tl3VLYvneAuD7k1nA3S1WW9P5DeZOe?=
 =?us-ascii?Q?flvwmsQOUoDYj8kQjzWlR/28dncDa9BOedcX45CQtufP6R11pxObv1JtUM8g?=
 =?us-ascii?Q?pdwhRbd0y09BNRVe/DyM2yviTUYnlPpfGSj8hCCBt1iDwB6rFkW98Vr6NeT+?=
 =?us-ascii?Q?v6V3HMA0poePDpc/ye0J/sBEor+gtDewaKl+x2e6voM97H1mDvZQ1BPJG2tI?=
 =?us-ascii?Q?Ax+GdhPZMkx7p/z4IXr3CasHt+6bBt2pvKbV/F2bfhdxIRL0dqBxcKyE4ljF?=
 =?us-ascii?Q?2q6msCjE4x5Cr0n/jqPOVOTOlvGIph4UKPCgcDuR25nwJmLxXs04yqaEsgnY?=
 =?us-ascii?Q?NgJPngVmxmG/SE7R4E2hWDdZb0RAXYp2vbNkTwYeNVx4oXRdCTjFjk8Gc6Lv?=
 =?us-ascii?Q?DiIgFkWg6J8L2o25Mc4dpHEPLqL/GK7F12E0mh/K3CYzSnGCsXFrD1sGDe3y?=
 =?us-ascii?Q?iu3FDH092byqh1IS2PgAqXqCbKnSIFOQPJv20okemPiDX0R/aPJCgxIfSGZy?=
 =?us-ascii?Q?KkyemrboC5lsWBk5BAx+ph6tjky/6QWMbBFPQ9TD+1ja6rnCDtS8a7hcVZP+?=
 =?us-ascii?Q?WrX7Re+4iIumS8YLxnhKSaMoBjq0dUpsYTR7b962jac9aRRvusw/x2K5nkfG?=
 =?us-ascii?Q?4zpxCBttXZHoTBqyJZCm1cS6d8nMr4lMEMuwRnZENYstlBUNJGLNk9UogcbJ?=
 =?us-ascii?Q?AsQO9AokBlvfxttujJOCsT4bhqYjOQam+w0Nr8BGiPEqIOxoBFTamz8dP9se?=
 =?us-ascii?Q?aAl26CblHmHXpJedbZFvp6E8R/0ukWs9zEfomU7Oz4N0EEcIuSQdAEAUyfUu?=
 =?us-ascii?Q?awXbVoTzyh15UF4d95vAxZ9exf1Begov8rW0a2WoeyH/KKOivMeaFt9vDmsh?=
 =?us-ascii?Q?TQi1DRqiawc3EIFvZBqF8pIxlFNZ7gUHL1sH9TiG8UdkIWIZG6TJ+Fg4YOL/?=
 =?us-ascii?Q?DHjYgRkaIl0x5gccPBzwHTm7tKuW4ulYdYV6bgz5eWonbMXMuSQOJxA1V8H+?=
 =?us-ascii?Q?hHj4MsdgaVqgAt6+l+F8LS+PVWt+80VqmZ6ZcqYla5repyepGVNxjYMNwvqH?=
 =?us-ascii?Q?yyF9/6Io8QuslwS3yZYi2juCMmG7wN/c9qBWsPI4AMK+Y7cPiWHrwdPv5MW7?=
 =?us-ascii?Q?dzZ7vPbO2k8+swph381ThmCNgDavmf4tOhFGRYHxY6zfzK7bpOSWAJaD74dS?=
 =?us-ascii?Q?Sdgip62pRgu0BVo0BMRbocTLBXS8gNMFoXypQJxgQZrF3I73AJTNwPh1KaSi?=
 =?us-ascii?Q?FDuBKE/QoXUPSWwDHDbvqqlsQ33IhRr1vUFw01iWP4Hgpsh82BAx9LzUpFAS?=
 =?us-ascii?Q?QFKZPeyp9k8qjmgvqxQCIhClqTcsJaoC0GIag0dLjD3mUX+2laeeHgKO3Ipv?=
 =?us-ascii?Q?K19nA6SkPi0SrMtW9xnvS3Q5WPeU90HQikehCMeESWqePvV8UBQTAFNXeyMT?=
 =?us-ascii?Q?F/EIPWkd5NzxoFv1ra7ULLtvqI/mDeJ+zponiEGU1tr8QEYdojNJ4lk4rHMf?=
 =?us-ascii?Q?LQtG+XN2JdeBNKb0dAYajag9vFrrFfm43fvda5h9D59F50n+ovqGSnxfJXfU?=
 =?us-ascii?Q?0G/8VRfyC94amqRZgKzUppgumlc1E+UIMYP1DRu72bt4yHE/qsJq8GeLh62t?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cZBqTHVZ3K439mdL6pPM8i8T9jVS9jXJAUn/+EcBb+dUER2+RAhQkExWCQ6IfV1v4rlJd6/TrCIZ/RhGJiAGpZIXmI5YwsFBDEdIUrenTVLaI+4Tt0Io9cUCuLzqgwLgFk8CrX/Vjjurt8wWEaIMNyVP9lX2HFpme5+oSrOtKIhYc94UN6sSVr70uS1W8bSWQQjzd8Wh0UEoVC7CQXdGyb8I6TejPHTz5+DfqXoEYqWOz0EQyQUp2OFzEuYiigIBxsSZENT4hPIErXzByWrLlqza48+oizwf4qftGP5G3QU4psmNO6f6w8zdi+Pn1TU9Pk9PRdXqIzFmrkk+0G8lpNP7V7Cr+ZKv2L0HkLolfRh2b5KyuFG9SFWLsc4HNbj3Cfgh1Sv8pxRbSbEDEymgQUjpCCt3tW04zqVuH/amF0tcrK9ZqaSfxFr6VQR3aP1+6qcwrb7QgkCrVZF7Zqt9geHKL6c3JWhhzI+6DJngtRUfmc2aiNrtkoKrZ5Sk6p9UrewWvHmL9/8jk5hrbUKxgEbJYtGSRH5cSMdEW88CbRZiu21N4AUpf971FX6KWF1/26J9xvA8u97fnry7SnD5bNROdQMClNJ21Mh82ji0ELQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be896b-6399-4a78-136e-08dcc83f4990
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:28:52.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85GRdp0GfWPPFGBpzI99/rWK3/3vnETWGo5lYmYprfnQPVIdy9DTMV/8PEczJWICG6KJK6iIAM/eqmzEHlJvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290108
X-Proofpoint-GUID: PVtzd-WNUIx3irLTzXqtmft1pQ1r78n9
X-Proofpoint-ORIG-GUID: PVtzd-WNUIx3irLTzXqtmft1pQ1r78n9

On Thu, Aug 29, 2024 at 11:13:49AM -0400, Chuck Lever wrote:
> On Thu, Aug 29, 2024 at 09:26:46AM -0400, Jeff Layton wrote:
> > Long term, we'd like to move to autogenerating a lot of our XDR code.
> > Both the client and server include include/linux/nfs4.h. That file is
> > hand-rolled and some of the symbols in it conflict with the
> > autogenerated symbols from the spec.
> > 
> > Move nfs4_1.x to Documentation/sunrpc/xdr.
> 
> I can change 2/2 in the xdrgen series to land this file under
> Documentation/sunrpc/xdr.
> 
> 
> > Create a new include/linux/sunrpc/xdrgen directory in which we can
> > keep autogenerated header files.
> 
> I think the header files will have different content for the client
> and server. For example, the server-side header has function
> declarations for the procedure argument and result XDR functions,
> the client doesn't (because those functions are all static on the
> client side).
> 
> Not sure we're ready for this level of sharing between client and
> server.
> 
> 
> > Move the new, generated nfs4xdr_gen.h file to nfs4_1.h in
> > that directory.
> 
> I'd rather keep the current file name to indicate that it's
> generated code.
> 
> 
> > Have include/linux/nfs4.h include the newly renamed file
> > and then remove conflicting definitions from it and nfs_xdr.h.
> > 
> > For now, the .x file from which we're generating the header is fairly
> > small and just covers the delstid draft, but we can expand that in the
> > future and just remove conflicting definitions as we go.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  {fs/nfsd => Documentation/sunrpc/xdr}/nfs4_1.x                | 0
> >  MAINTAINERS                                                   | 1 +
> >  fs/nfsd/nfs4xdr_gen.c                                         | 2 +-
> >  include/linux/nfs4.h                                          | 7 +------
> >  include/linux/nfs_xdr.h                                       | 5 -----
> >  fs/nfsd/nfs4xdr_gen.h => include/linux/sunrpc/xdrgen/nfs4_1.h | 6 +++---
> >  6 files changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
> > similarity index 100%
> > rename from fs/nfsd/nfs4_1.x
> > rename to Documentation/sunrpc/xdr/nfs4_1.x
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a70b7c9c3533..e85114273238 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12175,6 +12175,7 @@ S:	Supported
> >  B:	https://bugzilla.kernel.org
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >  F:	Documentation/filesystems/nfs/
> > +F:	Documentation/sunrpc/xdr/
> >  F:	fs/lockd/
> >  F:	fs/nfs_common/
> >  F:	fs/nfsd/
> > diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> > index 6833d0ad35a8..00e803781c87 100644
> > --- a/fs/nfsd/nfs4xdr_gen.c
> > +++ b/fs/nfsd/nfs4xdr_gen.c
> > @@ -2,7 +2,7 @@
> >  // Generated by xdrgen. Manual edits will be lost.
> >  // XDR specification modification time: Wed Aug 28 09:57:28 2024
> >  
> > -#include "nfs4xdr_gen.h"
> > +#include <linux/sunrpc/xdrgen/nfs4_1.h>
> 
> Please don't hand-edit these files. That makes it impossible to just
> run the xdrgen tool and get a new version, which is the real goal.
> 
> If you need different generated content, change the tool to generate
> what you need (or feel free to ask me to get out my whittling
> knife).
> 
> 
> >  static bool __maybe_unused
> >  xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 8d7430d9f218..b90719244775 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/uidgid.h>
> >  #include <uapi/linux/nfs4.h>
> >  #include <linux/sunrpc/msg_prot.h>
> > +#include <linux/sunrpc/xdrgen/nfs4_1.h>
> >  
> >  enum nfs4_acl_whotype {
> >  	NFS4_ACL_WHO_NAMED = 0,
> > @@ -512,12 +513,6 @@ enum {
> >  	FATTR4_XATTR_SUPPORT		= 82,
> >  };
> >  
> > -enum {
> > -	FATTR4_TIME_DELEG_ACCESS	= 84,
> > -	FATTR4_TIME_DELEG_MODIFY	= 85,
> > -	FATTR4_OPEN_ARGUMENTS		= 86,
> > -};
> > -
> >  /*
> >   * The following internal definitions enable processing the above
> >   * attribute bits within 32-bit word boundaries.
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index 45623af3e7b8..d3fe47baf110 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
> >  
> >  #endif /* CONFIG_NFS_V4 */
> >  
> > -struct nfstime4 {
> > -	u64	seconds;
> > -	u32	nseconds;
> > -};
> > -
> >  #ifdef CONFIG_NFS_V4_1
> >  
> >  struct pnfs_commit_bucket {
> > diff --git a/fs/nfsd/nfs4xdr_gen.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
> > similarity index 96%
> > rename from fs/nfsd/nfs4xdr_gen.h
> > rename to include/linux/sunrpc/xdrgen/nfs4_1.h
> > index 5465db4fb32b..5faee67281b8 100644
> > --- a/fs/nfsd/nfs4xdr_gen.h
> > +++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
> > @@ -2,8 +2,8 @@
> >  /* Generated by xdrgen. Manual edits will be lost. */
> >  /* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
> >  
> > -#ifndef _LINUX_NFS4_XDRGEN_H
> > -#define _LINUX_NFS4_XDRGEN_H
> > +#ifndef _LINUX_XDRGEN_NFS4_H
> > +#define _LINUX_XDRGEN_NFS4_H
> 
> Ditto. Resist The Urge (tm).

Actually, renaming the header guard macro makes sense. I can adjust
xdrgen to do that.


> >  #include <linux/types.h>
> >  #include <linux/sunrpc/svc.h>
> > @@ -103,4 +103,4 @@ enum { FATTR4_TIME_DELEG_MODIFY = 85 };
> >  
> >  enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
> >  
> > -#endif /* _LINUX_NFS4_XDRGEN_H */
> > +#endif /* _LINUX_XDRGEN_NFS4_H */

-- 
Chuck Lever

