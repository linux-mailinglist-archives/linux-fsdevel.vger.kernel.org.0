Return-Path: <linux-fsdevel+bounces-28571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7396C21A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B046B1C2235C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774E1DCB30;
	Wed,  4 Sep 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gi9JuU1Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCO22gun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4DDDCD;
	Wed,  4 Sep 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463235; cv=fail; b=CDiNPsJWOnRZv+6hIc03xnJLc49QgFTIL3Et6NYrzCg7tymOrmgSUykxYtE6TUZmLzC1/ZdErOg3gloenuqy8seWziXKLyDinwrJhV43Mhh0qNXvLg9FysHFhvBR2zhzTrzBzvfWQXGZgjo5ozc0G0NGOfIo/8sRFCZ95gTYsxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463235; c=relaxed/simple;
	bh=NkYsShJcuZKqumYpFpgiMD5AvwBdXRiKEhJ+pV8QbQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/wE0hJe2Eag4PAoBDB19pE5awZ/RbGsANn5QtWValGQEujG7VaWUYLzNLoGx+Lc7umZFpMQasRotPB1VkzeF0kwltpzkAE4I2ULwaoAPZcrMZS8bbm8vwquEBfEdjisAFqBPYKLBYYvdTwXIuwyhJh0L0EsvnovrI+9zMBDm4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gi9JuU1Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCO22gun; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXTpP001576;
	Wed, 4 Sep 2024 15:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=aAv4EinYLwLT4Ww
	Yj3VKc0xca83PiC/owjKhGAARmOk=; b=gi9JuU1ZvBgNJrImDSIO6hHyB9OGJAj
	bqascUQUYs/PmShvJaujcMjITtu6mjW3bKXLUjsLP10LjefifSQslFwvtlXQRMPD
	1cQl2api3mgO5SLHlsvJ0fx7tTSljUJe+Oow/9G4nFHhT0INCPgxHltEVs5ux2hi
	xk4qXZ78FKa8vf3xSi+G6DruB9qXhh2g0iyq+Gv6PnX99wIi43UCDCaYSEsNVAko
	UnOHoIFQ7PQ0u1zBajJQLDUMWIPBdG/kVYzwhnWnQNxCCzgFVyXv1ZGKw/zBznNI
	WhGBK7NXI/fntjTjk74YyZHD+nRhlxSBMtAmHG8cbQL/gK6HvoLuWYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsabsvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 15:20:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484E20QR023570;
	Wed, 4 Sep 2024 15:20:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9qhu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 15:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPJSk9qCu1XfQm4GmHFnKw18J8k/3Nw++nqo2UrkfQ+KBFmncLUvkrxtjZ+guUzq2RViXxJGFqAcfNMPAnnfMI9Lf5L5sQRMc6OwuM0CyiL0n9B4dROll0zAl10WRKytpJT670A4X39Nx8YkpbzdOqOqCtFnD6BQR2cAbg3KjzMnNzC8iUE/GSEpY5DsugBX/t/hUvRuePoXTn7oR72Tc5RZKlx6jY603ZfqtpkfQIU3/1jlvCHcdwWndUq8iOnz1S5uShmPjvhGrbyv+TT4Bmr1yy36pOtQ5rWDgnaQnIweGI6YedKSzqS4Y75HrNOKfFu5S+M24De6lq3fckS0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAv4EinYLwLT4WwYj3VKc0xca83PiC/owjKhGAARmOk=;
 b=JkWIrGUl3PFvB549YIRy7svmbrRMs1tAIUQcChxULKon4S3ZhOzNF03BxURQKBwu/gDcCH32xAuET35zisKrBA/IOJGdelhYgQgJj3RKMCNYCS5s3tUc9OyMgO+adX2PuqbOTeFedFyZ14Lge++NznPxgrHtzmwkMep6ahyb+XuAqU3Zjegt2zAwg9wMKNfkajKk7qpEdBshAOz8Q6E602SfrSCHhZ2m0KpngW1AltB/Z/E3nynA/xkR2X9eviF9aoUgsXfYOu2YL5ggbNtP7F29eXrWfQjZopWm6e9hcO45pI6FPD1nsnWM+7oFkQ+MohJYsKLkaGesAuE9tzlMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAv4EinYLwLT4WwYj3VKc0xca83PiC/owjKhGAARmOk=;
 b=lCO22gunAF/76T5D484Sd2v3SY/GW0mzmha72YVdF5ZuQu3ib26iFUhCysjEvrn/rUjOhvn3+WpGxJ5U0GyzuJHi0BHMzzSe6ON8qTrX9UOXyv3sSxxPz/9R9lRQeRQ5VsxpLpLjK3ldPWe4MNhUhAT2Xd5cjcvQ289D2mgszcA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Wed, 4 Sep
 2024 15:20:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 15:20:04 +0000
Date: Wed, 4 Sep 2024 11:20:00 -0400
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
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Message-ID: <Zth6oPq1GV2iiypL@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-3-271c60806c5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-delstid-v3-3-271c60806c5d@kernel.org>
X-ClientProxiedBy: CH2PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:610:20::46) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: fa20ca0e-17ff-4b17-eb81-08dcccf50d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYIDnYX4u7bVU/Sh2g9IF3UvAyOgpnTB0GkTDkT0Kw7l4CBRb7XFH2i8d8Q1?=
 =?us-ascii?Q?bPZYm6OPm2226LGno10D2V7+QhKUFpV+d2uZ4YSFCbhkBoZwmao5xyOvncce?=
 =?us-ascii?Q?1O2jSCjQ/ySEcmqTcYyDVft9tzpDkd45i/54wKhr9bSol0YZqMTUicqr/ssf?=
 =?us-ascii?Q?pNxBT0NQmQ/My7BVTT87CglJpDgVq8QnW1CG8XXI14VIWwNwoNfq/ikhk0t9?=
 =?us-ascii?Q?AVQ6JOr4YpLwg0gTAVjKM+8dljQO7OVYpzTpGIsQH9Gmebf6Z4SFRehkuzAj?=
 =?us-ascii?Q?ZgEyBXFrQmlS4AcYbPt/zcRQ85Pzqw6pjUlcRWp8dG/r0ZJq+316XzwemO3g?=
 =?us-ascii?Q?CTTC5xns54ACu11JpOjHK8WHx8uCmRpGiBJWVwW+sXywQf9MT+I1HDTZzV4c?=
 =?us-ascii?Q?ZlgUg26Cl6HyKGoXzl5UJ1icxZC3MJ6uj1zfy2FOplpGuVQU9uTTotgLocZe?=
 =?us-ascii?Q?5ZiI1BQd5sxhp1GrPl4v13eiVqH2tfDkWaI9LqfuIGFg/2hAfj0wgCnWFId0?=
 =?us-ascii?Q?Vjbu9M2jG8nEmdxIBV+PataY+tmieN+ajSrjHNOcSQU9bbB+Dn0zaDpEJdmN?=
 =?us-ascii?Q?ZXZMrTYQ8AhSZlKYrxb1CQzFY/Q5fwSK7NfP8kIk2S08TAdX1qeZ7P3xv2Hz?=
 =?us-ascii?Q?sbVb4sEhB3pMEOp/Iq5EhqzsRjGbJo2Klgdz9LxNgohlnh9Glyu7NRLked6e?=
 =?us-ascii?Q?G/IQ9TcBgmO4UdrUKWvo2mAoslrnAI+B3ulxgbuotc8PRE53md32lbabxxFX?=
 =?us-ascii?Q?TF2PEOrRj3/+i3D7rUQImBzakPp34Iyn1f2YCSAwl7+53L72D+vifOaEI8o8?=
 =?us-ascii?Q?AUthJfa7WbY/lTALO6RTynOrysFvKw8RdU5zb98KYlBT4wamq5STFzOupM+w?=
 =?us-ascii?Q?tV3KpfBb6bBUAoDmXKDZ5hFEjPdifAr1MCQ1HWF2WOZkxMzMILeqvOKxrj0b?=
 =?us-ascii?Q?SffjIJFc846fn3DR0hRecCx0SfhwedjHS2CLGqZDTixN6UzUPOExcZ85sGVf?=
 =?us-ascii?Q?vRTo7XHaGru0ICIRBrf3wlnZoG4ahHw1iXxPn6S/w99V7WgO4Y7LJAzhFSXk?=
 =?us-ascii?Q?fdbQW8gFbe1ZhlsWHtTi3p4/VEc/6e8XbUOedTYvWGnMxzhrHOzQeOoDK/iM?=
 =?us-ascii?Q?2bzGqiwQaBmxuAAGN9VmA7Kt18kzNLzevELQthni/5cIBA6RiSpaCYRGZn+q?=
 =?us-ascii?Q?ntEZYrPvfONar13xKJlQLME3Jqn2NO973RAMN5WNuPaY+fXU0unhBO+2nr7T?=
 =?us-ascii?Q?F9B93xOgv44Plr0K3nkHV/eOrXh1+fT1pL8pNkKJSt4L/HR5i4CAGugAHTVJ?=
 =?us-ascii?Q?+Nn3Dl4J3DIrJSoMvgehpLt7i9DfBkQZ1t+9uBFyIDA3yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTDsnixWYeKLTQd05qK2MThHTgAGBz5CA+fwi5rxk6ZfFj1cYD1wci+k5Ukf?=
 =?us-ascii?Q?Ivm9Uz72jxUkHVEXUh9fCyByRRSiYP39bpv2CzSe7l+33AYhJ7/eCMWVwO1D?=
 =?us-ascii?Q?WzGmGxAYfexUOREL7YnsK3m3DUa9AvwtVoAYz/9udPPxzCr4EHWFEIzlrMu+?=
 =?us-ascii?Q?G1frvhFagAQfNxc1JdHzUdoYy/J9q5WPBZLllH9d6FDTJkX7nZ7oD+nIyIrT?=
 =?us-ascii?Q?N+0/bMzroCSHNFyfAknmT0AFGDjQlBJ2tNmvTCPcq8WbblMDZ5iDtqHGrJsY?=
 =?us-ascii?Q?RnmWSmSHfnMQykuiH32pYBubM0Yr2CotWHLTQVEr1/TaKyGM/PYTJxazs2GB?=
 =?us-ascii?Q?th4Aw36PZwEu5nkiigNtkRohWqX7zFoIViolF6tP1sNhKBKaMEL/p8+ZtEtA?=
 =?us-ascii?Q?XHD/Aq2YSpiJU1JR2Y8eqqTpE08XzQq+q590IDRu8a2lyn2B11ARN4eq65ov?=
 =?us-ascii?Q?/iZ7yfFia0sgZTJqRbghRuzZH1nPOTZdX13YZVDkTJDFckf2pxTGEvDwF9A2?=
 =?us-ascii?Q?rRocpAd7sFTOH9Xor1g0n0PxC3EU3lne0z/U4HigQslo4vwfYjtcDrJ/kAt4?=
 =?us-ascii?Q?ZQatOaMkHKsbEMX/1AqTqLg3ejT3k6lLHwYnHEB7KIO8DmbLPYbTdweuid/s?=
 =?us-ascii?Q?HidvxkkgAMw23Two5MOcGuXUZRf/G6jXwkNulu3x5zK0tI86tEP0xXr5rmO+?=
 =?us-ascii?Q?/pza7iJTZE6VGKUgBI0OBJn3JtCnqHxOtPtfxgq3aJwLcNWfAZ2iT0yCDwG/?=
 =?us-ascii?Q?JsWweTJpoIx+PJerAGGeAXQeEQFHSEzW66Vgc1YV6y97ICwie/L1Rd0hoMZX?=
 =?us-ascii?Q?fRdUtDQ9fewbYYKPJoBqBUGrtPlyLs7H7bvNGH9v/uwQjayAgRInYEWsaIwI?=
 =?us-ascii?Q?6jEYNAFMV+Hv2W3N38V6MRq2M9Zaonf07JDNLjW1fBp7RRIV/bUhHtYg1+06?=
 =?us-ascii?Q?4qUU0uX4Ma+MePzPKfQFZPrNm/kKBjpgh2gmtNIk1pNMkg+lVxe36/oYPYaz?=
 =?us-ascii?Q?zRX2ybgP1+EZOIksUoWsR2ERvSChw0v5S2KJLWPHfUbG5JRoGBvdggsjpNrK?=
 =?us-ascii?Q?SQFNqiWJMGLaUaX69d47LZ1Q2xfSBwdca92YTLfMKDhgqXXRHxjVTzHrBaF6?=
 =?us-ascii?Q?K37Uw0MDzsmm1puG1eIlZbl6ltmwOnu1onmt/EKgVUhITEhoPnm/FrjammMg?=
 =?us-ascii?Q?8j+UcCVSoXj3yd5FybLyaclSsFSIRNFhoFyxJzx6cmHTbfhhnlbdRhIZCezK?=
 =?us-ascii?Q?cE0hqs4SEVu3PM0z4chY3SgYGr6FaZSDmAqAARwH7b2kfdM3AyCvBwSB5nOs?=
 =?us-ascii?Q?C2PYj7l4uFhgJu4r0hDQU9RhmtyA5gStKliHDyyRPRJ63k4XPdjqpHvs64jk?=
 =?us-ascii?Q?kWARfry2DksD2f4PMEz5cMeQLkgM5woI6N0BmqOroDEMx8lybTqFm8bAPmcw?=
 =?us-ascii?Q?00X4DCITOIlh9Xc9JjWZJ/j2qH8JWQ3Ls+uv31261RZ/ZuEHsFwXL0vbAWyv?=
 =?us-ascii?Q?5TED7SZHA3/TdXpsgmW5OX9PIBHz3MnQ3TO7xK4xGwElD8JKDbeHnrluIeiW?=
 =?us-ascii?Q?xNn6XjA6PYgrwm8hEldkZH2hKht0w2vTAmKmhDAy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rJGQvnAfaZhZ0wLEBmbKGvMckyUVGI6awbrG/GmYBDL3tF813uJrf5LpDJE6TdgGPDFFwowjqkDQgqHvuwTxqoC3NhyCDI6YwldGws4lEgKgApgieSPigcnngLAnCZWyTlUCXyEET0GnQmVzTgAML6K92/eJmE6r69V1voiQ89BfsGRaXnvBSrKQA6xulFV7mZRpBZ6FPa+nJDZADCFL1pjqSYjChQLpJiDcu+A2uHHChsPBn5GFeWReN21qzeXzxcQPOizV23lBoo4Stdp7TkM5CPmUjsqy+Ha2OVGzkM1ZeVz+jZC8Pvph2Rtqf/Co5ZefaxwC2kvY5QJTqi3ztOe5xr+pq8P/2EI3vfChsb8H0Q01choysbhDZaRugdRRg4UGQvSa5cAo+RfQWXwWJJdhc+4cKCb3/IW1KCF55qIqxIAy/xBFHB+TBwyInH4BbndEYB1ngIMC0qnyW8SeJTuwwz/AKiwZ6a9givasXvkQ40zA+/WxVOcEwZKMBYBgO8R88ybPDu0FyXONe80czM84TXYsDdgRSnVGkTlyPuHjg6ntZA6hlotXBOKNryp57JT2b73m2Fw7M9IE/tIcn+5zKG/PnMuCGmVMr3y37d0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa20ca0e-17ff-4b17-eb81-08dcccf50d33
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:20:04.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XElseds4lKwafZUwBDlpHI3AMJxi1RgKxLzKCTHf9b0mq+xiHvrExTDFFdO6DJJZ0tXdW6XOgWrTYw5rkmJCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_12,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040115
X-Proofpoint-ORIG-GUID: ZGV8bBE6Neiu6PNDy7eeUzXzpXpcCHJu
X-Proofpoint-GUID: ZGV8bBE6Neiu6PNDy7eeUzXzpXpcCHJu

On Thu, Aug 29, 2024 at 09:26:41AM -0400, Jeff Layton wrote:
> This is always the same value, and in a later patch we're going to need
> to set bits in WORD2. We can simplify this code and save a little space
> in the delegation too. Just hardcode the bitmap in the callback encode
> function.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

OK, lurching forward on this ;-)

 - The first patch in v3 was applied to v6.11-rc.
 - The second patch is now in nfsd-next.
 - I've squashed the sixth and eighth patches into nfsd-next.

I'm replying to this patch because this one seems like a step
backwards to me: the bitmap values are implementation-dependent,
and this code will eventually be automatically generated based only
on the protocol, not the local implementation. IMO, architecturally,
bitmap values should be set at the proc layer, not in the encoders.

I've gone back and forth on whether to just go with it for now, but
I thought I'd mention it here to see if this change is truly
necessary for what follows. If it can't be replaced, I will suck it
up and fix it up later when this encoder is converted to an xdrgen-
manufactured one.

I've tried to apply a few of the following patches in this series,
but by 9/13, things stop compiling. So I will let you rebase your
work on the current nfsd-next and redrive it, and we can go from
there.


> ---
>  fs/nfsd/nfs4callback.c | 5 ++++-
>  fs/nfsd/nfs4state.c    | 1 -
>  fs/nfsd/state.h        | 1 -
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index b5b3ab9d719a..0c49e31d4350 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -364,10 +364,13 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
>  	struct nfs4_delegation *dp =
>  		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
>  	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
> +	u32 bmap[1];
> +
> +	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>  
>  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
>  	encode_nfs_fh4(xdr, fh);
> -	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
> +	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
>  	hdr->nops++;
>  }
>  
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8835930ecee6..6844ae9ea350 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1183,7 +1183,6 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>  	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>  			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>  	dp->dl_cb_fattr.ncf_file_modified = false;
> -	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>  	get_nfs4_file(fp);
>  	dp->dl_stid.sc_file = fp;
>  	return dp;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 79c743c01a47..ac3a29224806 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -138,7 +138,6 @@ struct nfs4_cpntf_state {
>  struct nfs4_cb_fattr {
>  	struct nfsd4_callback ncf_getattr;
>  	u32 ncf_cb_status;
> -	u32 ncf_cb_bmap[1];
>  
>  	/* from CB_GETATTR reply */
>  	u64 ncf_cb_change;
> 
> -- 
> 2.46.0
> 



-- 
Chuck Lever

