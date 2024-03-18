Return-Path: <linux-fsdevel+bounces-14748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EC87ED5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C551C21A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813D535C1;
	Mon, 18 Mar 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQeReZ6n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yKD1kHUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AA52F6E;
	Mon, 18 Mar 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778814; cv=fail; b=dqMDLDUgY9FiPgmLqsO8wX8N9H0Xz9F2hqOn5Xpib4LOXdHI1wudECLMrzVZyM1kpgxY8izVRy3jn4XsSbh4Se51B1tAYZBJeJWP9jmVYwo5N7HGnPM0AvFaYQg5Hjo53utH1/VneLvrhCBBi6gBtTxkkZUGk3xgPQj5WlhRS+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778814; c=relaxed/simple;
	bh=AGeXrnCbkuIrQ5tmM5TsmTjCpMNEMg/CHge75Cp+t7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pLVdnB+pIpqNaqjCG0zlHxSc4VcqKeEXwf8AZU3cS++BO6Nv4KtpLrzXQ4K2i+CG/drmPu2Tn/m4kkdPszCw9tTo2dKWGmn1OnVAA08anavPgLoIMYSL6Px9sgCV5HR0lcKwGZhoLP5Qor/8lT4AlEOnnNIw8/l9N+tshgK41zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iQeReZ6n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yKD1kHUc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDNsNE023848;
	Mon, 18 Mar 2024 16:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=4PMvrqdmYAJyGUkHAxMRH/kYG7qgWE3Ayee1fEW+rTs=;
 b=iQeReZ6nREcbr5KViXjdftkHMd9X8khqYxBpIWB2Nj/zhDb/t5SXOKKdhuJvwEHddRvU
 fFG0JG68VcIS1FUq5tUBAhph47BRRhLXfa3rRWKyNpmnm5ffXh6uPsu+1Mc+yDMvS1Hc
 jjPwcVrfLK9tg7h9W/cLx4zFrLr+QNaCCU+fePUEZepHYseLBxc+dEV/VhJRe93fvfR6
 XQUgIzDfxunMQyXkwYAHD3AF8m3U3BsUnf04BrXr43QupvyvUir37Tae9yRDGzyoxL1t
 fIaMOWeA2iF4jhPWdGVuKNAIh7Bt7tFklqa4uQvnF3WY7wjzlh9XgBmiWi9CNHIDM1+q fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272ugbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 16:19:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IG2Kw6024309;
	Mon, 18 Mar 2024 16:19:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5ay4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 16:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcsi0reisRFDy6YjYGSa3R7mtGN9Gzq/GfayMC/0iBAvI6eoDIaA8kI3jPdndDa4d6mMgezOlryl6LAu+cOOPvQg4+YocRm1bUgKdDDyqKusg/Zi/DrQPwqK6Kr+5OmeLLQ0KzXsfOxMZlNEh3NHYpSstI7nOCP57qNrTyXzD0UqznvYf7err2w9nU7iGSW9sayu7I494LXtvQ335yH3hRlhGvDeJTpmVlHI27YBGghjOQk9LVO0klb0YAGGM0HpgqCgJt9323+/Y07ihN5bn5RuwJvQZeSX9RSY1OAk/Vg823sOxQLmWEW6sizvIUbD07Wy84r0B4zxYLqRS2e43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PMvrqdmYAJyGUkHAxMRH/kYG7qgWE3Ayee1fEW+rTs=;
 b=SqZPJ5fybJClKMehaHLPhi/XXGFn5okQgU3nrCi5xbUxMV7ohiK2XFz14rzVmAoqgXcfp1Z8go7UnewGARDpj5lwS0RH7kyCn3ewEkEnw0kM3BHSIsn+5gvVpa3zDs5cG+HtUkObo+qKULv+sPmZGSnMt+1OXVnAe0vgp4h83FaxUIJsjaw835Ld4svlTTP37VenBl2Q+NfByoYXE5A4GwN6tFbGVNRNFNWeNgoKH5QZjJkWYVFi5cBfsuJ6rG7/THXctn4agGVR+WqmlRsOjLOCh0Mw8508fuat0A1d7xxZQicijw5eJuJ8CUzgMFCLELmQyU7+Jya/JLYxmnSXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PMvrqdmYAJyGUkHAxMRH/kYG7qgWE3Ayee1fEW+rTs=;
 b=yKD1kHUcnIAZauIr0bMOi7GJulbM4mFw10gIP/HgXzxx2/1A0DzzlqiWVxstEKs4suaF6dqZ4yudIhWzcCOMpsLnkwDeeXPkzaT3xl+RMakVdzETohVKlItdRmDKzwZglt36ciIUihzyIdHm8OA0b2zg5Blw9L/ZFDCTaqCcnh0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Mon, 18 Mar
 2024 16:19:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:19:10 +0000
Date: Mon, 18 Mar 2024 12:19:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 12/24] nfsd: encoders and decoders for
 GET_DIR_DELEGATION
Message-ID: <ZfhpeUPApU7Xh8QY@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-12-a1d6209a3654@kernel.org>
 <ZfcNh4O3i19P25h1@manet.1015granger.net>
 <6bf5ecb35cb3c244c072d0ab5248a2b0b1da25e0.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf5ecb35cb3c244c072d0ab5248a2b0b1da25e0.camel@kernel.org>
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 6680e1cd-f8ae-4e51-4ede-08dc4767247f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HzlMnov7Ro4EEnTuRsg0bwPDnmWpQ8vy0V1pfRhqd+A1Wugl5WZKbnH2jMCQGQqyyaVqoUdQ+0zdpGl9SAmQe14pEuY5U0W1E1Vn0Z+Q/ojQUephn7g/t75kWKBQ4YKXrTh8H1c9Zm5JcGjRgOZqRkbrizWcgAaF4iPEXTDnlCDQkLAUUVnh4R2gwILTSt4hDvjZlj2/JoH9souipwRsQjPjJvJGYWxb8vJcDY4gg3bbjdJMXhBvyTTOjtlHuBf/qteSx1EfIENW2z9fBbhUAW7zz2YMY5a4GV64VJjJavUT4Rh0yhYj4dndV34l9kFJk8seVnSzbyiYU8OkVKinbQ3/YGGT+SNLaNuJnOS3lIQQGuoxFKgnT25xYU2RQN+hXKn5gbhow+68IifT1iB9/cftQfXyfbIdF5ws5CQxI4WBhAguvFcsHS5sqgeFDpxAzPT6//9jzpCBBJc1fYtV3kVM5LJaEeb/MmaeIK7kBFpKSImV+VGz6Apa8mjTj0rzauBtWbGdOq+92E/9q4lt5Xcmr+XGpey3jZZd/JiAG11/VvCw0GEjjdyx7yAQ97nj0B34J+Hw3JDzwvAoS1RQLZQRimQUzCGwADNkRArWZhnp/3+Gpo1h/yOvLyI/3EX0TDuYGHXI/iYxLJbSKArd6jonBk5Bt4i7d25OVLZa4x8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TNd4wauDxeGMj3wkpVwYyGmx0apvLj4uadcxnjvlTgVSlCJ9E58k2S8P7PZ0?=
 =?us-ascii?Q?V+vpLF5iUoBD2+Zkm6l7nls5DjMfQndCoJ/mhkNl7kgSGuwYdq9r62DJwnYC?=
 =?us-ascii?Q?8U0b+/J9pQuC4aZDUW3F7peiEj7fWvAKLaSr7/Y63k9Gr1ujGjsst9dskN4R?=
 =?us-ascii?Q?y7cxK8wQJhd4zkaoXsDLCGlf4O6/S/oRMdXYmxANlPVVN9FMepbVG6NQRHXy?=
 =?us-ascii?Q?fUHGK0LYPYX2bLu8bSbrXeP/jP7XqymRho6rXNfEC1o/mM+C2LGdNp6cCZMF?=
 =?us-ascii?Q?c09XMk4jA+DOyMzPL8SLYIHeyVu8twfN7nKbE88ZiOd9liSWGbGlFXTkBtMl?=
 =?us-ascii?Q?hTUrqyMNNVejv8/H24k96h/gbRmslDwRjKDzAZclrMPd7YVTzPtecV+U7Xtz?=
 =?us-ascii?Q?O0HEVpOfzMVTGAz3RfBUISMcFy5o/VblxnJaeqXlZjtB4IMaUPgz0HGdBzo6?=
 =?us-ascii?Q?dBQ/Ro4O4gKYY0Z1ghkKEtTiaCV3nMNZTGJJqGck1UcvgcciBPW2+m4gJiUE?=
 =?us-ascii?Q?vHE9/o0hS13yg+CuLXrOirrVPfz2lZ9XSuin6NmuypVxTx0FrxEWsM9UdOwd?=
 =?us-ascii?Q?ah/D42xqDlSIYb5LPBlJyuUqTDBRGy/kVnxD0DwPKuFPGQTmTC6e/PJOYgYa?=
 =?us-ascii?Q?hGvsSxlUrtVD6AQt2TyPR6ihTHERF+Ei4U0rTPTEquRAT0dSoNn5OWRaf5eo?=
 =?us-ascii?Q?Ast6nz6OrYRbp+u2GXPFJxzj/k0rEdbSBb937r3gf8LZByAnK9/kzb5jLxIF?=
 =?us-ascii?Q?HrbfycYShQ0ko00zBQL/0TTEsGgdN6KZhKoDWNiEUdBE6eq6LuBeYWkdVYei?=
 =?us-ascii?Q?F1AhcV1wuDld9zDDk67Er8QG6bnayNq3HJT4+IgkqthP/w3ghSDUo6C/HctF?=
 =?us-ascii?Q?++/MnCnJKvyQryIadesi3ZW0Y32wsU2kAOT7F3NccY4Mgbm8MOtRT4JEFcYK?=
 =?us-ascii?Q?/PpdlratMGkJ3cTcFfQXKo1FrmntuxvUaRZMYbLe5tXh2zYsGOXL1B6Ci8eW?=
 =?us-ascii?Q?Y7uGERIxp+hMvU8WkNjeM20023lxD/L8CtrqymubFPHwbn2wDvJ4aNcDtIUL?=
 =?us-ascii?Q?uta1Gn0lzb6kMdeyvGlQSKh5j2VtsVxuZODJPN7Cfxm9qWTFd4EA70zYIE/0?=
 =?us-ascii?Q?PcQ+aKePUSqqsbviGZoXULYTcl9TuNMEIOUp8jhtaRshTwrCtRp6wQRMhRpu?=
 =?us-ascii?Q?jfz6PV4Cg/YOHjdMK3nXOtzA2fbsLgzs6uWm6oKBPgZcBnXVSK8VnmCsRWLa?=
 =?us-ascii?Q?DbM6f+5Y/0JjWc7CzsB2P5Mhy8Rshx9P96xFDe2gunJWjhfr5s9nWI8nXgHh?=
 =?us-ascii?Q?IS+/Q/1ZQokT2gsHYwOpBdYXqUVEnj1je/qydqm2vykgyIhDUsa6Onq2WoVn?=
 =?us-ascii?Q?HvYI5Mddz2rhs8HND1hW78DYibqbTWVBWZbLEsBwYer187DALpfCBKhi39Jp?=
 =?us-ascii?Q?Lo+DSfRpx/WUv2JzRNwqEm1uhTRpaPPrUxA5TQh6AEeHZZYjXOIgvmAEl+qB?=
 =?us-ascii?Q?7Y4lk0YjrJrbjTuEtbzRhkdrAUGQgcv4imP3K2KF6JWa+5KVeTAxYYGxm1rn?=
 =?us-ascii?Q?yMNVXdjJOnrDfljEN6G09qmcqhXjWgFU2b0cymFgHGbgHxZl8eOsz3ynyFX3?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yii9KbZ3ySfnhX2m6Q3oI92JWuRx8nWRMlMCGw5ddrMtyJ82nFnYsbPia2qfMEQ2hJtO9ZiLm/gmhxVH8MDDG/5jAsxaeTf1plPmXFm9tpZba0A3VydVJDwke5E7lGcAHYVEs9Mlmlntc1RNt9cNCjLk0ruiePTqCZ7/e6+6p27Hm+gm4xYF0Sh6PJD0NUHmAhd3UuXyoEpihu26gyXIdszjz5ek5YsbSB3yCqVfylYE0joZgBWF0gOEFvwZ5p4etuxeI5Q5ZunEGL8gWV+ETUMVf+8WHrr/dlIhsqpLEYcOrUEEjS/A5nya0x5Q24aUhob6fI90SLW/JOtr9GqKWuel/alT2Pvhs7FFeqcUzg3FzCfFbLhPw9AaZOlyquqkipOuBImEbzGXuncg70NgWeZ+oZXZ4lrzds5gGU6ZATIVEWub7qRnj2odCzSDVqumfvOL1qI4c+X/jADyy7tSUP51PdA/bAw6aFOGGjM4do0UODfRhaMVktCp3GYGNLzlZYKjtXInPx58o0TWtvdOVAZL5SHG+ghEGjGyG/44c465jfPlKJvP6gXIwvLRzwJr1QcyMHRcyOQaSX+REu6bUCpsucDRIaezuS64OZKXUPM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680e1cd-f8ae-4e51-4ede-08dc4767247f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:19:10.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxvnYLMzN2nr1ZnyJk4dkkRSKTJjSq+0ewbAjrwoA1dvAqG5Fl/Gb++tgNiF+HgtOLH8bycapg/OJ0pjTP1WQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180122
X-Proofpoint-GUID: qqVtlnX_zax0GYAxNbBQyamvYSHgP2tu
X-Proofpoint-ORIG-GUID: qqVtlnX_zax0GYAxNbBQyamvYSHgP2tu

On Mon, Mar 18, 2024 at 12:12:06PM -0400, Jeff Layton wrote:
> On Sun, 2024-03-17 at 11:34 -0400, Chuck Lever wrote:
> > On Fri, Mar 15, 2024 at 12:53:03PM -0400, Jeff Layton wrote:
> > > This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
> > > clients, including the  decoders and encoders. For now, the server side
> > > always just returns that the  delegation is GDDR_UNAVAIL (and that we
> > > won't call back).
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4proc.c   | 30 ++++++++++++++++++++++
> > >  fs/nfsd/nfs4xdr.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  fs/nfsd/xdr4.h       |  8 ++++++
> > >  include/linux/nfs4.h |  5 ++++
> > >  4 files changed, 113 insertions(+), 2 deletions(-)
> > 
> > Just a handful of style preferences below.
> > 
> 
> Those comments all make sense. I'll respin along those lines.
> 
> Also, I may go ahead and send this patch separately from the rest of the
> series. I think it would be best to have trivial support for
> GET_DIR_DELEGATION in the kernel server as soon as possible.
> 
> Eventually, clients may start sending these calls, and it's better if we
> can just return a non-fatal error instead of sending back NFSERR_NOTSUPP
> when they do.

I have no objection to the XDR pieces going into NFSD before the
rest of the series. Thanks for this implementation!


> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 2927b1263f08..7973fe17bf3c 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -2173,6 +2173,18 @@ nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
> > >  	return nfsd4_layout_ops[layout_type];
> > >  }
> > >  
> > > +static __be32
> > > +nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> > > +			 struct nfsd4_compound_state *cstate,
> > > +			 union nfsd4_op_u *u)
> > > +{
> > > +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> > > +
> > > +	/* FIXME: actually return a delegation */
> > > +	gdd->nf_status = GDD4_UNAVAIL;
> > > +	return nfs_ok;
> > > +}
> > > +
> > >  static __be32
> > >  nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
> > >  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> > > @@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
> > >  		* sizeof(__be32);
> > >  }
> > >  
> > > +static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
> > > +					  const struct nfsd4_op *op)
> > > +{
> > > +	return (op_encode_hdr_size +
> > > +		1 /* gddr_status */ +
> > > +		op_encode_verifier_maxsz +
> > > +		op_encode_stateid_maxsz +
> > > +		2 /* gddr_notification */ +
> > > +		2 /* gddr_child_attributes */ +
> > > +		2 /* gddr_dir_attributes */);
> > > +}
> > > +
> > >  #ifdef CONFIG_NFSD_PNFS
> > >  static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
> > >  				     const struct nfsd4_op *op)
> > > @@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
> > >  		.op_get_currentstateid = nfsd4_get_freestateid,
> > >  		.op_rsize_bop = nfsd4_only_status_rsize,
> > >  	},
> > > +	[OP_GET_DIR_DELEGATION] = {
> > > +		.op_func = nfsd4_get_dir_delegation,
> > > +		.op_flags = OP_MODIFIES_SOMETHING,
> > > +		.op_name = "OP_GET_DIR_DELEGATION",
> > > +		.op_rsize_bop = nfsd4_get_dir_delegation_rsize,
> > > +	},
> > >  #ifdef CONFIG_NFSD_PNFS
> > >  	[OP_GETDEVICEINFO] = {
> > >  		.op_func = nfsd4_getdeviceinfo,
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index fac938f563ad..3718bef74e9f 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
> > >  	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
> > >  }
> > >  
> > > +static __be32
> > > +nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
> > > +		union nfsd4_op_u *u)
> > > +{
> > > +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> > > +	struct timespec64 ts;
> > > +	u32 signal_deleg_avail;
> > > +	u32 attrs[1];
> > 
> > I know this isn't how we've done XDR in the past, but I'd rather
> > see these dummy args as fields in struct nfsd4_get_dir_delegation,
> > and also move the comments about whether each argument is supported
> > to the putative nfsd4_proc_get_dir_delegation().
> > 
> > The actual implementation of GET_DIR_DELEGATION is in nfs4proc.c,
> > after all, not here. This is simply a translation function.
> > 
> > 
> > > +	__be32 status;
> > > +
> > > +	memset(gdd, 0, sizeof(*gdd));
> > > +
> > > +	/* No signal_avail support for now (and maybe never) */
> > > +	if (xdr_stream_decode_bool(argp->xdr, &signal_deleg_avail) < 0)
> > > +		return nfserr_bad_xdr;
> > > +	status = nfsd4_decode_bitmap4(argp, gdd->notification_types,
> > > +				      ARRAY_SIZE(gdd->notification_types));
> > > +	if (status)
> > > +		return status;
> > > +
> > > +	/* For now, we don't support child or dir attr change notification */
> > > +	status = nfsd4_decode_nfstime4(argp, &ts);
> > > +	if (status)
> > > +		return status;
> > > +	/* No dir attr notification support yet either */
> > > +	status = nfsd4_decode_nfstime4(argp, &ts);
> > > +	if (status)
> > > +		return status;
> > > +	status = nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> > > +	if (status)
> > > +		return status;
> > > +	return nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> > > +}
> > > +
> > >  #ifdef CONFIG_NFSD_PNFS
> > >  static __be32
> > >  nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
> > > @@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
> > >  	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
> > >  	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
> > >  	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
> > > -	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
> > > +	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_get_dir_delegation,
> > >  #ifdef CONFIG_NFSD_PNFS
> > >  	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
> > >  	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
> > > @@ -5002,6 +5036,40 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr,
> > >  	return nfserr_toosmall;
> > >  }
> > >  
> > > +static __be32
> > > +nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > +				union nfsd4_op_u *u)
> > > +{
> > > +	struct xdr_stream *xdr = resp->xdr;
> > > +	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> > > +
> > > +	/* Encode the GDDR_* status code */
> > 
> > In other encoders, I've used simply the name of the field as it is
> > in the RFC as a documenting comment. That's more clear, and is
> > easily grep-able. So:
> > 
> > 	/* gddrnf_status */
> > 
> > 
> > > +	if (xdr_stream_encode_u32(xdr, gdd->nf_status) != XDR_UNIT)
> > > +		return nfserr_resource;
> > > +
> > > +	/* if it's GDD4_UNAVAIL then we're (almost) done */
> > > +	if (gdd->nf_status == GDD4_UNAVAIL) {
> > 
> > I prefer using a switch for XDR unions. That makes our
> > implementation look more like the XDR definition; easier for humans
> > to audit and modify.
> > 
> > 
> > > +		/* We never call back */
> > > +		return nfsd4_encode_bool(xdr, false);
> > 
> > Again, let's move this boolean to struct nfsd4_get_dir_delegation to
> > enable nfsd4_proc_get_dir_delegation to decide in the future.
> > 
> > 
> > > +	}
> > > +
> > > +	/* GDD4_OK case */
> > 
> > If a switch is used, then this comment becomes a real piece of
> > self-verifying code:
> > 
> > 	case GDD4_OK:
> > 
> > 
> > > +	nfserr = nfsd4_encode_verifier4(xdr, &gdd->cookieverf);
> > > +	if (nfserr)
> > > +		return nfserr;
> > > +	nfserr = nfsd4_encode_stateid4(xdr, &gdd->stateid);
> > > +	if (nfserr)
> > > +		return nfserr;
> > > +	/* No notifications (yet) */
> > > +	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> > > +	if (nfserr)
> > > +		return nfserr;
> > > +	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> > > +	if (nfserr)
> > > +		return nfserr;
> > > +	return nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> > 
> > All these as well can go in struct nfsd4_get_dir_delegation.
> > 
> > 
> > > +}
> > > +
> > >  static __be32
> > >  nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >  		union nfsd4_op_u *u)
> > > @@ -5580,7 +5648,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
> > >  	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
> > >  	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
> > >  	[OP_FREE_STATEID]	= nfsd4_encode_noop,
> > > -	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
> > > +	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_get_dir_delegation,
> > >  #ifdef CONFIG_NFSD_PNFS
> > >  	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
> > >  	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
> > > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > > index 415516c1b27e..27de75f32dea 100644
> > > --- a/fs/nfsd/xdr4.h
> > > +++ b/fs/nfsd/xdr4.h
> > > @@ -518,6 +518,13 @@ struct nfsd4_free_stateid {
> > >  	stateid_t	fr_stateid;         /* request */
> > >  };
> > >  
> > > +struct nfsd4_get_dir_delegation {
> > > +	u32		notification_types[1];	/* request */
> > > +	u32		nf_status;		/* response */
> > > +	nfs4_verifier	cookieverf;		/* response */
> > > +	stateid_t	stateid;		/* response */
> > > +};
> > > +
> > >  /* also used for NVERIFY */
> > >  struct nfsd4_verify {
> > >  	u32		ve_bmval[3];        /* request */
> > > @@ -797,6 +804,7 @@ struct nfsd4_op {
> > >  		struct nfsd4_reclaim_complete	reclaim_complete;
> > >  		struct nfsd4_test_stateid	test_stateid;
> > >  		struct nfsd4_free_stateid	free_stateid;
> > > +		struct nfsd4_get_dir_delegation	get_dir_delegation;
> > >  		struct nfsd4_getdeviceinfo	getdeviceinfo;
> > >  		struct nfsd4_layoutget		layoutget;
> > >  		struct nfsd4_layoutcommit	layoutcommit;
> > > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > > index ef8d2d618d5b..11ad088b411d 100644
> > > --- a/include/linux/nfs4.h
> > > +++ b/include/linux/nfs4.h
> > > @@ -701,6 +701,11 @@ enum state_protect_how4 {
> > >  	SP4_SSV		= 2
> > >  };
> > >  
> > > +enum get_dir_delegation_non_fatal_res {
> > > +	GDD4_OK		= 0,
> > > +	GDD4_UNAVAIL	= 1
> > > +};
> > > +
> > >  enum pnfs_layouttype {
> > >  	LAYOUT_NFSV4_1_FILES  = 1,
> > >  	LAYOUT_OSD2_OBJECTS = 2,
> > > 
> > > -- 
> > > 2.44.0
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

