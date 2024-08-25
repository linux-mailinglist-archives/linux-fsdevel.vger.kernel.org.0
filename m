Return-Path: <linux-fsdevel+bounces-27067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60295E42F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B561C20859
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFF8156F3C;
	Sun, 25 Aug 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIZkpkKo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xmul9WwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB51155A43;
	Sun, 25 Aug 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724600792; cv=fail; b=hnlS7In4u3R+5oitB52wE+tw1z5DZ7Ys4FUbMdlyXcL/hpTKrpb5mTgiReepZhpXWHKumlFdv8zsCto8HwKjlh7Y/IaJASkFXTOgnY30hj3wuBMon/AqbnI3dGqYJjLkRNtCpCAK/2OH13J/aqG3pVnpWcayvtZVQsjTBXhhC/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724600792; c=relaxed/simple;
	bh=hEUzB8ceF5/aQihAJzHHA1tkTH9Ej1MC1DZ2W1/eUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rp9Crdq813q+sMFkDMm0neUqPV/b45QSUT5b9uqca6CMWMdpQUnhGPyqEc2vDoMHxrYtVuY2WBAW6prp0sjM1JZl177x7BHvbhcnxE8nYwtmu+5xoNx7IPSqnKfnElRzfqEXoDb+l4FLrALIdWWAOiCHRadrtGfkvz3Qkpchueg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FIZkpkKo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xmul9WwV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P5ucAt027660;
	Sun, 25 Aug 2024 15:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=GSLBUgarOCpf09x
	MgSzxQ7Bwk9JB7Tf6jqZJb25y1SQ=; b=FIZkpkKoDR4QMy6dA8VRr26V1mCvwxq
	IAZGnV1IGoX2Y3Ykn0tj+MNF0SgIsv8tgPu1Afo5hbPKEbEaULblCHpobeg5s2jb
	yRx29o2Wst4UnL3k0MDbExgnORu43aoIt9STMNQgC55lS2OnIzDgfaqm5ROLbEvF
	e5ulcTPa0OCfntlgVGAKy3exAmx/wtMkfKCWFj9ZeyFXJXENfZaUf+v73lBuoQhu
	p7tzptrA6YkI2AQhBpoWQG/+ZWWVQQ1auv9hUKxXAnb95q8Kvz4fPdM8yE+Cj194
	W5Tk9w7fKULpzPtLXEirv3YffsU6Xnrx+wqXPaEF+OMVnrucxO24o5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177na9kwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:46:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PFYDdx011153;
	Sun, 25 Aug 2024 15:46:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4187c9r4n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1q25tLfQwQqyFIV9cOFnZacPrzUJ9n+nI3uKTpyGJYeMrQAiL7dzqQb6lGA0502yNfvng0s3h/QcDQxKroM3jQFbyB45S6erk4lEHT3TQMl/7SGiJToMXv+n9fNI4DsStj0DQFkC2VCxkclU9mBYTevujMJVi/QgS1DwBw9sDasJauyiCO9Y5gQSN1Z0ntC7LyXey5axSONzdwvNOZLLyu8hMyCRa/1z0tKibT5uCYI0o07t/DtxnBwSokqlmUJqfoH8TYTEFM5y964abUVNgIVC8yXUcb17eKEup7AlKha/9QUrInq/KIAMIaWi5iVl9zb/I3n+6iAskSORg2l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLBUgarOCpf09xMgSzxQ7Bwk9JB7Tf6jqZJb25y1SQ=;
 b=HwP9z1zBsjZ7JGZNvbDW36mAHhz78IfzT/X3YDiEOXH43XdluPgfCpfCja2Wgegx5hreN94eZNzWy+qsJLeJVQz+Kb3vvaI8Mr3zseDvrL1j4BMuAPHfiJD3mHvoL/C7eED3O9aJoRQa/8t8ZVbUuVw3/Oq/jRzTry3u+WElEOy4/fk6pL2cUhpl2RnJiS5nRb09l778rEG5anGo2Gt0YpPQTHEJh0Jin20Jvx2YEpj1TzKLLzGM9h26tYSq24gJpPs5eTTVO+XfX3pVndV8T0XCoI+omFJjkc9YG8RhU5+HeQxbKjXxUP5mf0hBDDN2y53YqEl5MdHl3YAOR2V3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSLBUgarOCpf09xMgSzxQ7Bwk9JB7Tf6jqZJb25y1SQ=;
 b=xmul9WwVQOZkg6yGJ2iknPBsduZWw1/tkrfugWbwnu0VFdx865MhCEmOYYYN/cfgmrhYOemYqWMG93XATStpQiSPjTFs0+V/pD/XVCIwQ0LO58KU//aZAijOFYNciEAdzVWwAVeXk5r1a5ANGpvld7iNBCPBlzZu0alPxcbiy+c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sun, 25 Aug
 2024 15:46:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:46:13 +0000
Date: Sun, 25 Aug 2024 11:46:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 00/19] nfs/nfsd: add support for localio
Message-ID: <ZstRwsA1AGRVzFbF@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
X-ClientProxiedBy: CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f650b12-f2bb-47ae-18ed-08dcc51d0c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnE08h+Q5g0wTHdCJjBAWqrsP7OQ/9QwZjIxchNn/j4aB813Ukliet6M8SiC?=
 =?us-ascii?Q?cRu3EwphIEwz2h1lBFoPkq7WklJBN3bnuHWeZtwKM1aKexLISXjfd2OPW64b?=
 =?us-ascii?Q?qvl5/MyqoshP25zd1xeByKSMGpYDyJvds07ejb97tk5SQx0IyGgxrwCah8B+?=
 =?us-ascii?Q?EZq/0VVsiTyvnZ7Z4cAU6F4iA+dals2o3q6/e+qRwTh8Ef1DyOm/LrSDfAko?=
 =?us-ascii?Q?e+4t7m7oisHlub3rb+Ti3Mm9DS2SiZSwx+JSksTXk58O+2YTIQxmMmEKabts?=
 =?us-ascii?Q?ttPdFQD8ryr7BWVaYne0atbTZenTWKexlGxKzBcVLr5CyeoaxhJcynpZFND/?=
 =?us-ascii?Q?+g4yXZcEcktlPYYXaBW65nNAXzeErANOLqNHJaX6y2YtMd5pnTvW56GD8FfJ?=
 =?us-ascii?Q?QGBhg3bBVPFREhJ3L8duZOSwFu14KxEbRljgtNubIwj7Ooxy9YTrb6ytvo3g?=
 =?us-ascii?Q?oYE8cemfoKQXb9Gs1JtZjupY0wR066v3d+6Ap5VsdC/TyETCSra50PQWClaF?=
 =?us-ascii?Q?N4zOQ6t2Wpf72ZWUBhIiMOWFMP6x/dwKf41UaDFjbsf6ctEPubMDIHxcxR2s?=
 =?us-ascii?Q?QcIMsz2xRspBf1I+NI2FfV6tIDbx6TzzpM1eUjmMhiM/uqufYv4JuZUC06WL?=
 =?us-ascii?Q?/rA6DzT0WXiiggsEgvuOy7iSgvbhuGaA9mjo0AabJKljMihwe7ppdstmLIIG?=
 =?us-ascii?Q?pwhLseJXXruuQqCqahlkAOpqhKy4nBR8y3SmarJEG93qiHT8t4WfjSJpmda/?=
 =?us-ascii?Q?lkBb8yyLqQjy93z2KK19eii5fH8mfxDPdCVKhOmeHijeW9lWmalbXr6/5y6w?=
 =?us-ascii?Q?JimB1QXvEsvJ0N7Fu2gZwV8N1QeqEhmaUS5v1fXdmJgpEJM9RqcWQr5Ijbfk?=
 =?us-ascii?Q?Y/s0F2XW26wFpTNUXjw2bT+wbBKkXgPP5Cg5xYtNazevFMAUxwNN47U1qs3y?=
 =?us-ascii?Q?dpl1Oo765RF/ApPqR+WezhRfw3gdLu82T6G8fT0KtigXG9BHytDzciOhC8C/?=
 =?us-ascii?Q?GIYmk/qFBWdXTcl3TtlawprZI1Px5zssBF5U/+eBdCYG5S6OsyR5pGn//WaE?=
 =?us-ascii?Q?RRtn4laYJHvgsFTmt5U5DDq5BEeV/X8waOf0e0UG3pWcBCs2lMgtA7sJ01aS?=
 =?us-ascii?Q?ONIRC0WXqX4vEkhlCfPm9STmeF0SbDPW6UojaYl6YHub6gAZbrGOztK5bDmk?=
 =?us-ascii?Q?K/ktEuV1FnY/YcRlE1uSqemxKRNZxF00+PbYJS0AW3BxREneeh+Y0HNwjHPU?=
 =?us-ascii?Q?InleFU8j+rUUwdkG8m791EzTOr+cWeDaBxCUH7Yq3FhZ82/hIFpFnUPQtcxh?=
 =?us-ascii?Q?YxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4y0N+p0nP+hxZdGJvzRHQfIzUsggtr+9KLij0HYhbIQ0sX/xChrudhBwlTP?=
 =?us-ascii?Q?X/fX8Er3uJyGLgoCf5igk856lYDL2YB+8cwWdINYfReq8j6CWtoqIfKFsduA?=
 =?us-ascii?Q?n50fp0xvliJ/a7uszxsGMoBUXfAHZijFem91w0XD+i6rwW1i5hOtfvpHc4lX?=
 =?us-ascii?Q?mDXFDrtTmgt5fR/34UHzJo3nrj+ozpr3wtVfJnOoMChSE7MYIiHaMVbx0QE5?=
 =?us-ascii?Q?pw6NMjK+yXnWcVmkMXZ8YWuAUVP5EQMm+GGTtFcAlxe0gOMppwO8xAwxp7/E?=
 =?us-ascii?Q?fjar6cyiyG4OStQV5HVKR3GkRFW8WYpvEL6jQkJ9/0+jjspvS9mh350AcTQY?=
 =?us-ascii?Q?jlVZZRyeOmkiXN198w0/LLBZtC/Gudfpo18acoLIul7UJr73YpEvByVL+JZ3?=
 =?us-ascii?Q?qNxr8bMfW7r5ziau8t30llEQ//1MoWLtPyY+Qy0hi9WfmMFTh/KkKvN2tVnI?=
 =?us-ascii?Q?mjShpbaJ8rzbktzSdkUN/Kb7jruS45b0CWsi3Vw3huxMROE7MZIGvQNtTR05?=
 =?us-ascii?Q?iMuwS+ghy2cC/FmI+F7F5PmO8ebYUxzhGVOKsWAAMt/7Ow4r8yRqZBbjOYR3?=
 =?us-ascii?Q?hMM+UELbQIwW//d/ZIRHy8MQ4zxDkHn1AReACJbuEwuu8mQHHentNNa1epZ/?=
 =?us-ascii?Q?TOvRHdlkB1q33XtgaN4KSwffd+GX41IdsyhNabUEMEL1XJJFwek4mazabWgu?=
 =?us-ascii?Q?s1oJdZX2Cw/aWvRRpxe1n44N7+XGR4lZANsS3yeP1w7eyGI1oOrrkZ2HYdbc?=
 =?us-ascii?Q?tUiw9bkH8wVzMZGhHiBT2MGqwgThW/cC5h84Rlm2sP0lrJbDs01phwiweIhC?=
 =?us-ascii?Q?bofnpoQ/1F/Oz4LYfLV27OoiAeB6pG1NT5G0qwPVbIkkL4MEEzO5Im8WDzT9?=
 =?us-ascii?Q?2+QKGv2gTizqmS2LMQtiLsX6f02Qbpw5NXU+F2KiCXloUutk1kEfQeRP5gyd?=
 =?us-ascii?Q?D7pnz1oryJAmlxGOAeYw5kjWXNtbya6l1gKAGgR+Z0++CcEr/TvVJPxzzMlj?=
 =?us-ascii?Q?A6Kgiyz6f3aG00YoWm9v2BDWRRHTT0Tz4FmcRm1PFVgGB7SEzvtZxDyx8fsi?=
 =?us-ascii?Q?KE6FrRCnQDxoSZIFrlteRJZTxht/kNSc9Lga3Bbvp5x7oEbEcGaCWPZfXdRv?=
 =?us-ascii?Q?mYXx6JlOc4jcoL+KI2lNAwSl4MtIwQIwwwYGhp0OQfQ8UW79Zrb3JxXv8R9Q?=
 =?us-ascii?Q?JNmU8L7py45GhK0UMDYtzDT/1SDyQCrziIMJSLW+AKVNyp0viRnv0JsEkZ4a?=
 =?us-ascii?Q?tbgdYKQxVMbC/9QW8tf1y1evM0TDKR/v3sB8YTz1mIF+2SAFF14L9Pdnbkjs?=
 =?us-ascii?Q?uStcOp8ko7FIIaEMABl63sLBvftXwTnIGh0V1xD6uzNUZBqj+G9XLfF0cwJz?=
 =?us-ascii?Q?B46EEiz80qIeNXN95TY5nIG/FCxEAlbkKNmrOSRz7iq5ragwMI4dTpf6jvgU?=
 =?us-ascii?Q?JqLHQuLF7LROfU6KDUN8J7P9LFPad0cgWT/YwlP6hAYeUKTg/cXbfZYJdITS?=
 =?us-ascii?Q?Cq4/II/4+KnCyMaJslVYPw+vHqwOdJDCp/svdySMEpiny/TbLZ5yN3Mnk0+E?=
 =?us-ascii?Q?LgemX7aEL8XrD4Zjjs7VU5Scx7MI9u3Ata6ADhmd4fOQGGQsRqefLcusktAl?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5hlQdXZVndQPdiPRqFiSzOEjYnXRyZehkcWvaHx6bEkwuqojqEU0p8nxo54XiblGy+CayYbA8k/18k/u1ZLfVJKeklZX3TzXRpqr3oEE1T9KkDyZ9qPMkKlCSH95uBbAXERhSE4vRAIHQXXyRNN/nh4BbTu6as6xQ4OSi1Py9UFLxX64OEReGbwsEaPK3aLK18KqtEHujeFFnUb24NBu+uCWaQU2CkRfniaQaS3WDmQR1IGDfwY/Xn+m3+nzvWfTE+pc0wMtiWFdWuyydv/H+O5ErvheqR9UDoxgbf2ntwyZMuDZHK+hMEWBYhJ35P3EMUNwDLytnC4pvRQSQvCY8Xf/m3rJ3oMAII9+yTJ3SZgdFVXOOq9YKR2M7T7st/HT2J4IQmZsAYRidBA8KE+e5R25APtW+kjRb2hoJiSWopedXxZmR+jKZ3Ur3kfMoDim3YxfxI6KXE9FyXzhejxwH0IOVZyM5jleRojzpnOWnlrpaBWPBU21en4H60dNlagaFOhelmyO9qCMRf/GOztqkcTNy+J1l4cNRAJg5pYqvI89obVkEizZ3VybNsiyP1kyEbvHMDphinlic1bRu4uRXTg3i2NJypoSBNADjC9TSKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f650b12-f2bb-47ae-18ed-08dcc51d0c69
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:46:13.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ2Aas+6zDcdLy1wKhjkQ0NM5g9EtWFTHt1vOBnNdr9KnGfSjXPuy3qgyi4CiCwA2TuPtbVzuK7fN/FYaH8kEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_13,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250125
X-Proofpoint-GUID: oGe_EpCOxys3tUjEtrengO1AkX90pMGc
X-Proofpoint-ORIG-GUID: oGe_EpCOxys3tUjEtrengO1AkX90pMGc

On Fri, Aug 23, 2024 at 02:13:58PM -0400, Mike Snitzer wrote:
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> 
> Changes since v12:
> - Rebased to rearrange code to avoid "churn" that Jeff Layton felt
>   distracting (biggest improvement came from folding switch from
>   struct file to nfsd_file changes in from the start of the series)
> - Updated relevant patch headers accordingly.
> - Updated localio.rst to provide more performance data.
> - Dropped v12's buggy "nfsd: fix nfsfh tracepoints to properly handle
>   NULL rqstp" patch -- fixing localio to support fh_verify tracepoints
>   will need more think-time and discussion, but they aren't of
>   critical importance so fixing them doesn't need to hold things up.
> 
> Please also see v12's patch header for v12's extensive changes:
> https://marc.info/?l=linux-nfs&m=172409139907981&w=2
> 
> Thanks,
> Mike
> 
> Mike Snitzer (9):
>   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
>   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
>   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
>   SUNRPC: remove call_allocate() BUG_ONs
>   nfs_common: add NFS LOCALIO auxiliary protocol enablement
>   nfsd: implement server support for NFS_LOCALIO_PROGRAM
>   nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
>   nfs: implement client support for NFS_LOCALIO_PROGRAM
>   nfs: add Documentation/filesystems/nfs/localio.rst
> 
> NeilBrown (3):
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
>   SUNRPC: replace program list with program array
> 
> Trond Myklebust (4):
>   nfs: enable localio for non-pNFS IO
>   pnfs/flexfiles: enable localio support
>   nfs/localio: use dedicated workqueues for filesystem read and write
>   nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
> 
> Weston Andros Adamson (3):
>   SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
>   nfsd: add localio support
>   nfs: add localio support
> 
>  Documentation/filesystems/nfs/localio.rst | 276 ++++++++
>  fs/Kconfig                                |   3 +
>  fs/nfs/Kconfig                            |  15 +
>  fs/nfs/Makefile                           |   1 +
>  fs/nfs/client.c                           |  15 +-
>  fs/nfs/filelayout/filelayout.c            |   6 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 142 +++-
>  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  fs/nfs/inode.c                            |  57 +-
>  fs/nfs/internal.h                         |  61 +-
>  fs/nfs/localio.c                          | 784 ++++++++++++++++++++++
>  fs/nfs/nfs2xdr.c                          |  70 +-
>  fs/nfs/nfs3xdr.c                          | 108 +--
>  fs/nfs/nfs4xdr.c                          |  84 +--
>  fs/nfs/nfstrace.h                         |  61 ++
>  fs/nfs/pagelist.c                         |  16 +-
>  fs/nfs/pnfs_nfs.c                         |   2 +-
>  fs/nfs/write.c                            |  12 +-
>  fs/nfs_common/Makefile                    |   5 +
>  fs/nfs_common/common.c                    | 134 ++++
>  fs/nfs_common/nfslocalio.c                | 194 ++++++
>  fs/nfsd/Kconfig                           |  15 +
>  fs/nfsd/Makefile                          |   1 +
>  fs/nfsd/export.c                          |   8 +-
>  fs/nfsd/filecache.c                       |  90 ++-
>  fs/nfsd/filecache.h                       |   5 +
>  fs/nfsd/localio.c                         | 183 +++++
>  fs/nfsd/netns.h                           |   8 +-
>  fs/nfsd/nfsctl.c                          |   2 +-
>  fs/nfsd/nfsd.h                            |   6 +-
>  fs/nfsd/nfsfh.c                           | 122 ++--
>  fs/nfsd/nfsfh.h                           |   5 +
>  fs/nfsd/nfssvc.c                          | 100 ++-
>  fs/nfsd/trace.h                           |   3 +-
>  fs/nfsd/vfs.h                             |  10 +
>  include/linux/nfs.h                       |   9 +
>  include/linux/nfs_common.h                |  17 +
>  include/linux/nfs_fs_sb.h                 |  10 +
>  include/linux/nfs_xdr.h                   |  20 +-
>  include/linux/nfslocalio.h                |  56 ++
>  include/linux/sunrpc/auth.h               |   4 +
>  include/linux/sunrpc/svc.h                |   7 +-
>  net/sunrpc/auth.c                         |  22 +
>  net/sunrpc/clnt.c                         |   6 -
>  net/sunrpc/svc.c                          |  68 +-
>  net/sunrpc/svc_xprt.c                     |   2 +-
>  net/sunrpc/svcauth_unix.c                 |   3 +-
>  48 files changed, 2434 insertions(+), 402 deletions(-)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfs_common/common.c
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 fs/nfsd/localio.c
>  create mode 100644 include/linux/nfs_common.h
>  create mode 100644 include/linux/nfslocalio.h
> 
> -- 
> 2.44.0
> 

I've looked over the NFSD changes in this patch set. Some of them
look ready to go (I've Acked those), others still need a little TLC.

For me, the big picture questions that remain are:

* How do we ensure that export options that modify RPC user
  translation (eg, all_squash) continue to work as expected on
  LOCALIO mounts?

* How do we ensure that a "stolen" FH can't be exploited by an NFS
  client running in a local container that does not have access to
  an export (server should return NFSERR_STALE)?

* Has LOCALIO been tested with two or more NFS servers running on
  the local system? One assumes they would be in separate
  containers.

The scenario I'm thinking of is two tenants, Pepsi and Coke, running
in containers on the same physical host. They might want their own
separate NFS servers, or they might share one server with
appropriate access controls on the exports. Both of these scenarios
need to ensure that Pepsi and Coke cannot open each other's files
via LOCALIO.


-- 
Chuck Lever

