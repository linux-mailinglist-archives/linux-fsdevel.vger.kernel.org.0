Return-Path: <linux-fsdevel+bounces-10234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D07849202
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 01:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0ED1C220F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E6A55;
	Mon,  5 Feb 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgLXrqmf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/g1qGV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E465C;
	Mon,  5 Feb 2024 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707092032; cv=fail; b=t62wf9ibMhXtHQ+1k08oWKSGdzSD9Trbzz09FPyqfcm1I9qSOCmzKnNIRF2nvan0JzIC6TiYjYpdRkv6LOhoz/H7ThNyAbMlnA/SHk1ny6DiAZWTKka/NuFBdfaWjO3qc5v+lL1AmoWLq8XUCagMmVQ+6mxhcIRQqCK5cudaDpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707092032; c=relaxed/simple;
	bh=GoK3hyQvAMW2zwdeLcSK+3IaN28LulrD2ZYnJZaY2GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WPnqj9hWrpR4bfYa7krwkNXgN0RciET7IZCfnUab2GbmgMwo2ZxxigefNpbfpudT7XQGhKPbuDDd3nDsrofSn+mebC0X1A2Q5+VcL4I7HEEkEdSiDQEjnOjC5NlQ/HW92E9onvp7WB+oJtx3CRLXVHP3q2YUZH0P6oNA3Gnw/wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LgLXrqmf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/g1qGV5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 414Mufxv000792;
	Sun, 4 Feb 2024 23:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=jjm1Sx1U8QtO9oiKh7WtWfuTOi2K68YQDCjzsQl5Kx0=;
 b=LgLXrqmfJm0WeWNcZYijBdGv9LT6jcmJwXAHjnR6OTbCJ0X0SUl56WYriosbygZ7gYPI
 Ab5bqBKouR2YLWeqsXvCGkv/hhOhNVCKdpx7GpYJuOZRzO5SsynjpJgPFLrF3CQQ0X1i
 arBHtieh1eTyvfa+Un/JgaYkFC3rqJlziRw8QF3UmpFqf84w0kYmpp0Hy3pP5GCSZTV5
 t9vZ5Ap0e2QoHK9eXh7jB0kuBee+VM/SGpSdporoEnarb8zpi0C5I30wsgD6UjN04OdK
 tD17Bl8wOPbo+2AdVlCujar+rde7URh2g3jY+XRdy/qh+8bNL6QfPTrTbe4bBsyfzHGL 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdafc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 23:44:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 414KVw6D036728;
	Sun, 4 Feb 2024 23:44:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx4xxwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Feb 2024 23:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q05/wEV8apetUcEtep99pp1s++HGNeQzX6J19q/HrOGJynhUA/lsgHqBYAODKO7FvvljVQOk0V4Soa45PhTVAkP82pyDHeY6U3uOhIYkhDdSafv7BLbm6lpPJCa9y9WdtI7UWD63A8Hy+ocHjlAMgF7LXgYnnPBG0H3AYSi8Ri0fgeBQuX7ta30g8GA4xTi6o3b+8eI0PguMUKHF5UX6XgC7EL4IlCFySxtaFZlQ4ZN1IElBz/+3RcjjgE1G9rU5t0hGknFRgiBYLGZWY8iARVqpfdme5uxovYCDQ8rhr7sA6K75dQQtzYdaCcVUMWaixBCAJbSkReWspFcy6BHdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjm1Sx1U8QtO9oiKh7WtWfuTOi2K68YQDCjzsQl5Kx0=;
 b=IOs/F0nLLGBeWyDYtntrXpp9eQ6fBfdAYr6nxltpTPtl6dIkMvktELSVoV08+IJQj5lo26UOBbP9w3KA5vSHuHn/PcCzTcY/DAm9aQ8BpJmwTPjCEaafHcawkG3zOEIlDw+sBrGbCgEoKlpOvpIKCeU0L/C+1HcMc/XYOngI8qWDcm2s4luenOiLkk/MFNdTmK/j7eG6FvF/xeRnGI2sx7piDkI2q83zq7d57Dj35prA8ZWsjcvgExratvY7Q7KhJbk7IfHUFOovFIdfggbAVIaMst+klMEuAaKniS8CNcljtas0wyjxxVD49ERoNhAV+SdQHoFzyQ4rfo6UB0mpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjm1Sx1U8QtO9oiKh7WtWfuTOi2K68YQDCjzsQl5Kx0=;
 b=m/g1qGV5RJIR/WprU51XEhjX5quYUHmURmZwpiqZeY8tZ3tqA3WeoY13gCgZaXCzEJTNtHlp3sOn2nBsQ9lLU9AG8TA8ZNbcreNuhl1pMdrvFZhB7Wi9qTy+xfGEgdpnl562eaz4XWboougnudOvk3UUHXss7XNtERGdG3xRzao=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 23:43:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 23:43:56 +0000
Date: Sun, 4 Feb 2024 18:43:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] filelock: add stubs for new functions when
 CONFIG_FILE_LOCKING=n
Message-ID: <ZcAhOW0A8U3h2OTf@tissot.1015granger.net>
References: <20240204-flsplit3-v1-1-9820c7d9ce16@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-flsplit3-v1-1-9820c7d9ce16@kernel.org>
X-ClientProxiedBy: CH0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:610:33::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e8c76c-af00-416e-3684-08dc25db2711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KNiYmzYiAkJpagDxL+9M+/rImgHxpP5fJUHCtDs+BCNcauoPPtZSzkcUatIRt0dtRuAnXA3WNLO3FCiDcEQVcMG9sW/x9VZxMcNb8/A5jnpG8BB7ECsQEJUnzAHNH4YGUSEjAYbaTEKgE7BRKy4KOdeJGoyoXdoqfeGRtn57AAXtXJr9+WBnErG5K4d6yt+ynOWBKEqbN8aWbv7Z7TRGF8F3+hiPYHR4tRSj2mDAttchv/58WHj74+wWovaR/TduapRquQX++Ad33sMfO+tOWVHDsIPMhENMHk5S5j5HfrdF9a0UGlkrASJgZI5Po3yUyWII+Iig3Qy38JTpuNJKxLdzqF67tkHLs1PyamijGY5WFl7ZOx0qoE/eh1AwuiNgZk9CtT1WGHghjVcTJrlqEIZyR/BVpz+atsihdUwoDOg2Ql0N08PYiwKQYZkBToA0b9wL9WCwxSYizT+jF7+WTqw89VOeMmvK3ZKG5G+2lCG56V0e818uTd0/KsLeyMO1B4A07HiNm8ruJoqNHYPxoZO0ZXsumWqXfoJENuXaDUI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(26005)(66899024)(966005)(478600001)(6512007)(9686003)(6486002)(6666004)(83380400001)(6506007)(38100700002)(86362001)(5660300002)(66946007)(316002)(66556008)(6916009)(66476007)(54906003)(44832011)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fae8BaF+aUEvkW+7nSUPqVZUuei/MzGrfrkky4HM1+MFrsbi8FtF6neqfH5E?=
 =?us-ascii?Q?Jbt41P1hACAPEJA4OhZAjKqS6Ccf2Go2dOH6qhlG9U6lIwRwWPE/fewDXTOK?=
 =?us-ascii?Q?wXfh0fuUhYdG+7D2FO6yLNbhyyzXlvUC2IorAxA9h9uGYAdapMp03WSfhYjf?=
 =?us-ascii?Q?G53i4rdXWtdV0Yl2Wwr7q3VC4GAHvKLjUDbqowx5EHNEfM1SocQDbf56vYAO?=
 =?us-ascii?Q?kqjrOwVwk3oLIXxi/illwSv7puep3S0HJrtw3zjQWLkfj2pu2NHxdz1+WMn1?=
 =?us-ascii?Q?r2hGX1uwwadFaPmuEK5/SvQB9Yhxl8g+cdzLTzADUsjSHp46N4LCnbxKnNOv?=
 =?us-ascii?Q?Ne4CiCyTxQR0O/dWumecsqASPzc8+X5RrPBQvbVD0geYEwkyA6tvRLpto89v?=
 =?us-ascii?Q?lBWhwscFm/Irx6yHQaoX+8kBDWOSklopj6Eput355R0Q0jEFd+Mv9BHaBLaY?=
 =?us-ascii?Q?SDiaZyjJwpLUufDYK/SOJYXa6Xv/gU9k/9P2zlvhrWI4mCWEm1UdEU4obN3F?=
 =?us-ascii?Q?7KjZCFFEjzu+O0I0TAoQ1fEvzH0vNzARGjMvJUvJyyP1GyRz7zXKXz1DAMnu?=
 =?us-ascii?Q?HglPaiAUWeMswsJki2cSiiDrIysqENmmSQUh0ZivXe4sN2G0QuINTEGqkVaG?=
 =?us-ascii?Q?+5fduv4INF1dG4Ru021OKyJkQMsur8iOuhcwIr54w/bbLC6xGC7f/QE9yK63?=
 =?us-ascii?Q?JHF5e9u8np0VqdPQzvC4rjSCkVTNLM2/i2rqq5OtFhQAyyjmjwD9vEbN7veI?=
 =?us-ascii?Q?O8jb78acO2dZBkkG7spsbHFpzJdA+UFq3r4R0YniV0hltvzYNfSw+3uHUGpj?=
 =?us-ascii?Q?l58C71WOmdfiQRfv0m/X5f7kH+43Hy17qAfiX7fyD5eI+3nfAs/Jy6ZysU5x?=
 =?us-ascii?Q?dS4iNGG8n4qOAW+YWJ0gcW7cRQ+QianxhIAsf3QXh8znan08gDg8IXUW8WCe?=
 =?us-ascii?Q?e7SeLQphiuc2IDeowehSiUa89RtlqHlstezvO+SyryIyR9QyG8o3xQ9VsIih?=
 =?us-ascii?Q?dd45SFJpDua1tLcMkfghRUM/0eksjEzYEBcpQLQglCPP70F9jrFp1IWABU3X?=
 =?us-ascii?Q?n8OhYXOoShYt/1Wy9dqX/v9jQB5Ne6kM1vYNa8ynbZUV6fqCDaXxj4HHOe3e?=
 =?us-ascii?Q?hC8NGo/5MptS3EiOVjJSfqDFK/fMSUkEYtUfh43XVGRpJ8r4s07lSXZXY0DZ?=
 =?us-ascii?Q?mbB/vRvckUf8VXpbZlPGHzZ332UCvK76hh0UNyxlK/e9QwsqLcWeYSxrjtsU?=
 =?us-ascii?Q?bFae1+JS+EdPe6aNg8QjzUe4RbpscD5g2XGzeRDzy1Vm6cBy983MgArImcwf?=
 =?us-ascii?Q?j0hssuxcw0grkQw01sRva/dWtyxzdB9XKn4aOLG95eJuNRjqYUv2HSmYheXf?=
 =?us-ascii?Q?+o7z6g7Fe9Ocb543ExaYsSjvvazKMfq1lgTGxY2rviPoDgAmVGWgiKd56BPy?=
 =?us-ascii?Q?spTTmAxWFC6+rpLYjGe91ksBC68kX3IH9o+iWeYwPW79DCtZ9luJ+qH6g5T+?=
 =?us-ascii?Q?Tta8qs1x722XvKFEjT/dau5yN1zlPfvkVZ8IOsdza7H/50mSSxzHGYcA0Xx0?=
 =?us-ascii?Q?zNjYmTWpt5y39P0neuuKTiNNr8hDIe76CuTMc6p8JQGm1j6WmwT+GxqMHng/?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FULYwG6/Cf0HADcBkPpcq+ZDLX0Av6EjtN7rhn2gdiEbgIFEKHS1JyAx7qKsrHqcGfaJS2HZ2t8S122HV8mTVUoOjTdXkzSJdDaDWW9ap878EKWOLhUEubHfrhpXkrWXEAI9qo/8dy07CMJ/UJnJYeCBAZiACXkkXqEa48MRwBKMf93oryox2jCXZkWSbNo26MhqR4tFdUXbT84TX47rZI1KS5B0s5hxi2FjApCjAxqlk5ZQSsiUq5gZ0b9o2ADpZQfS8E1VYjT1WVAPrS6K95vxHvXU+1E8DqpAHSvrYl3/LbYRontdnPh6B8zLHYsUnmVFSwjVbCFrKsDBCnNYoQmJM4vVpnIqdEe8zTEI5CPyQqMM9gayqSgBY1MurkJz9+kOLuM4xtNYlUK0XdDNLZzNKIPymtmfGdFE/KJEShCsCudnV9MZyX1bheAPMn00ErN4VIfExkN9m+Caax+g3Tah7A82uparVm6hXHwnCeV51eOz6HFeojZaz20vVxHLqMdwP/Hd6JZQNY3M5f5dYe6li+13UqGqAbIMnAzPqBc4GTkYw8QqMTGsyZkxXrUQygXrkDzSVAIR3hX2Ji5deAvGHkLtgyPiRWhYJRT1qNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e8c76c-af00-416e-3684-08dc25db2711
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 23:43:56.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOVdRSdFiPMI5NfGCC7NvMTi1S7xZydpx42B32tsmCyTeCOPenRuARv4sSc4ztTbZ7qS1+9OHfPVfchTAfNY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402040183
X-Proofpoint-GUID: se6Of1MwbsCekeWEafOSaKqgDXxPfEG_
X-Proofpoint-ORIG-GUID: se6Of1MwbsCekeWEafOSaKqgDXxPfEG_

On Sun, Feb 04, 2024 at 07:32:55AM -0500, Jeff Layton wrote:
> We recently added several functions to the file locking API. Add stubs
> for those functions for when CONFIG_FILE_LOCKING is set to n.
> 
> Fixes: 403594111407 ("filelock: add some new helper functions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402041412.6YvtlflL-lkp@intel.com/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Just a small follow-on fix for CONFIG_FILE_LOCKING=n builds for the
> file_lease split. Christian, it might be best to squash this into
> the patch it Fixes.
> 
> That said, I'm starting to wonder if we ought to just hardcode
> CONFIG_FILE_LOCKING to y. Does anyone ship kernels with it disabled? I
> guess maybe people with stripped-down embedded builds might?

One thing you might try is building a kernel with both settings
and compare the resulting object sizes.

CONFIG_FILE_LOCKING was added during the git era, actually, so we
have some reasonable archaeology available:

commit bfcd17a6c5529bc37234cfa720a047cf9397bcfc
Author:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
AuthorDate: Wed Aug 6 15:12:22 2008 +0200
Commit:     J. Bruce Fields <bfields@fieldses.org>
CommitDate: Mon Sep 29 17:56:57 2008 -0400

    Configure out file locking features
    
    This patch adds the CONFIG_FILE_LOCKING option which allows to remove
    support for advisory locks. With this patch enabled, the flock()
    system call, the F_GETLK, F_SETLK and F_SETLKW operations of fcntl()
    and NFS support are disabled. These features are not necessarly needed
    on embedded systems. It allows to save ~11 Kb of kernel code and data:
    
       text          data     bss     dec     hex filename
    1125436        118764  212992 1457192  163c28 vmlinux.old
    1114299        118564  212992 1445855  160fdf vmlinux
     -11137    -200       0  -11337   -2C49 +/-
    
    This patch has originally been written by Matt Mackall
    <mpm@selenic.com>, and is part of the Linux Tiny project.


Embedded folks might want to keep CONFIG_FILE_LOCKING.


> Another thought too: "locks_" as a prefix is awfully generic. Might it be
> better to rename these new functions with a "filelock_" prefix instead?
> That would better distinguish to the casual reader that this is dealing
> with a file_lock object. I'm happy to respin the set if that's the
> consensus.

"posix_lock" might be even better, but no-one likes to make function
names longer.


> ---
>  include/linux/filelock.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 4a5ad26962c1..553d65a88048 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -263,6 +263,27 @@ static inline int fcntl_getlease(struct file *filp)
>  	return F_UNLCK;
>  }
>  
> +static inline bool lock_is_unlock(struct file_lock *fl)
> +{
> +	return false;
> +}
> +
> +static inline bool lock_is_read(struct file_lock *fl)
> +{
> +	return false;
> +}
> +
> +static inline bool lock_is_write(struct file_lock *fl)
> +{
> +	return false;
> +}
> +
> +static inline void locks_wake_up(struct file_lock *fl)
> +{
> +}
> +
> +#define for_each_file_lock(_fl, _head)	while(false)
> +
>  static inline void
>  locks_free_lock_context(struct inode *inode)
>  {
> 
> ---
> base-commit: 1499e59af376949b062cdc039257f811f6c1697f
> change-id: 20240204-flsplit3-da666d82b7b4
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 

-- 
Chuck Lever

