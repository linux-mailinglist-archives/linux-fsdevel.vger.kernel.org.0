Return-Path: <linux-fsdevel+bounces-60152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9826B421D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE277B183A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FE3090D7;
	Wed,  3 Sep 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWduVfSf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rdjyu218"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F22F4A0B;
	Wed,  3 Sep 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906520; cv=fail; b=TWbcm5Rt+JxWxvGQ6x/V1SLUkvQx/0LbDKz+OU9vqt/ecQyXauqJyESOCp58R4qMw0BzZ2j2JrzG8NkhWw6yyaXCk8F/MM+GuZZDUn7orzutoUsoV/8pfUIiMk+NXri20w3mPJ1p7wF21HQdMcfzCwtSPvdZNHfrpMXnxZK1TT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906520; c=relaxed/simple;
	bh=jpjO/rqhHO1oElIqO9DRH3KVmMorKGjTpKCdE/J/UgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iAMRqfd5UQ6PF7BF0PDtWda/e/ht04xT6yCfTkiEb+HV8n+OuH/DY0I3XAEoHl/cI2T21+TJAZLnMwYqT/4oDeStXxbQNlXJlUYSfXoPbwrm8XCVmScAl84XzwokLnI+UuRe/6IMdi8QGKBvzGGq27/l5AvqDaTB/8BtH8ODRmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWduVfSf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rdjyu218; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NAu3015996;
	Wed, 3 Sep 2025 13:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Iefi4vRnzDFnQzV0Jb
	FNram3Qyn92MFiiR5Xg8B5KZg=; b=KWduVfSfs1uinV1evVqJxZH1D7Wf/Yv/4U
	2L+YtzcFa0wGcRauzpVCbHdtaB1P3HZfNTHAeVnp3338akD3hQ7+NZpqod0SZk07
	91sQ9ernnFL5DC6s9TFYUdqD0qN9gVyZZik6mmJuiQJtMagYjXFVJ/VwcBmXH+Y3
	xDwuCZZlwXR5afgVf8uGpEMb7AZ9IdzbwuLNpy3oaAPx38qnRwnTfhp5mNKAWuOa
	Rj/ZmFkUPJ+9BZyu7Cy+MfUmWSz19N+CfFH2cN9NHHQiEbPl5HEvLJLgyeUwO3vZ
	znvfErEo55mwPGUnN4EsBDYVtONfRuA6QUYF8j0o460p+sBTlDjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussyp7xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:35:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583DSExR030957;
	Wed, 3 Sep 2025 13:35:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraeenh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNkM3JF+IUr8D1OOeWUkLNys3qyAWIlF3fb0POMnBArQULmdZ31A7VLSKGiDnq37W2szdKlEyZdhOPY30mIoU0nlYoYkjbNiy+tKISjJesNV7IIeR9S47ibSx0kMIyCNvNz3i/PwmulRcLuib5YoGF6nYms0K4Qh5WI05n/RndLrycYBvL+Ke3j6xpAKbPtjpuIRYgBiAx5wXuglrfPApKjOTYbtPJsAE5aAf7H3rK4I8uzuNQ6kBMSzoOg71EvkpB7l1vTYMPMDJc+Clw7f5N/mMZlVw5KAoasSGeg4wYUvK/RI4+C2MHkPM1kmcUrylC2lj5LZA80g8BxxErNTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iefi4vRnzDFnQzV0JbFNram3Qyn92MFiiR5Xg8B5KZg=;
 b=E3mS0aGTuaijJ1ODrkSAShiGcG9JS4TG/GMvrh8BFonFzQ6HRxwkQCfrIZdhU027tmNmLIS8QXAW8jtoRbnNWcrG+2MpwmZSWFtWasOYUMBKj50r9ufJBgg+yxVqoFsYX9EDUwZ4OYkCmh9FQiOQyx4SVE4W+GC9NM9eRxQvKTfXACyoK2EmoLuPbOOpgy35LLyDhcw6iPdgZC5Wfe1mI45KwcZmkDOnkncYd27eRgOocJxOVsK0+6aupTq/mOBptCwBthc0A+s5W6hYtRDgLtVK3VWp3EqBlW2ZzHT4TbzaRO3BCm2pVIYVLSGAsOukIIZQocSHfwp5tDgSDmQVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iefi4vRnzDFnQzV0JbFNram3Qyn92MFiiR5Xg8B5KZg=;
 b=Rdjyu218CfVr1P6Fb+o09+95fgu5TRjxsvnC7Yli+Is2Nz/cjrTFGuEgcMusD61Z1z9fr4cHVJebezpoFIF0EqXaOCL9xg62dihpepyDl6GWle9mG8GgKzcZPkVCZDJVqYhcieSAD/6vJr1QvRZ7lMdOeNKDg3GJ74bO1T1S5ns=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 13:35:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 13:35:03 +0000
Date: Wed, 3 Sep 2025 14:35:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Christian Brauner <christian@brauner.io>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <c79508eb-118a-4f0b-a411-3439471680a3@lucifer.local>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
 <202509031521.aEPzyTZp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509031521.aEPzyTZp-lkp@intel.com>
X-ClientProxiedBy: LO4P302CA0032.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae61699-af5b-4586-041e-08ddeaeeb00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?izR7dDwidKpOayirzrUUTIQgzoCjnesbtzfFRKpPxrG7bzwZSVGIGoIZLX2l?=
 =?us-ascii?Q?ptgIoF5kNrObBcQnqFA1nPPJwhnbccCyuY94EqMXvqc+duW/5qbw25Q9mAIs?=
 =?us-ascii?Q?yaJViIuS1wKSNuOv4i0liCgrwkq3pf/Pa1w2PeOLD9emvYvIIYgIGeLKfVA7?=
 =?us-ascii?Q?Nj2XMutWcgTL8Wv/O1VB9qV3404gi/9F2aQzzP+KHwyznv3UPoGGvKUt1idr?=
 =?us-ascii?Q?9Cm+i4FnwrhQtUvBfBCNz2XFLtvOL6Gn/v/wayQYiVewgXElQFAU31jCYlBP?=
 =?us-ascii?Q?8DutXblmdjHx9OxZ2YQ3vLJ6X9xmHZPnrFLNxk3e+qZ9hNitpx9s7Ajcnu2S?=
 =?us-ascii?Q?uCB16lajN/Nz0XTcpkF73VosEFCcZvMdNhgzUTPrKDKF1xo86eQUdggVxI65?=
 =?us-ascii?Q?8z26VkNFuSRZwBrChKcN10K48T/C7KQMU6Lfb6hs8J4sHEYvdgRL1J2Q+mqO?=
 =?us-ascii?Q?ub4zwTNWbI1/MkFXyJQs6c7GI662s+13+0Dvjau3rgVx8FdaEnZyTnuLOXmF?=
 =?us-ascii?Q?o4lKMUfr84H3ud+CoXu2MLvwptG15AkONkZ01CqMh2Pa9VdsByRqCs85Okz/?=
 =?us-ascii?Q?AivHdnVBSagpNWk3FBvTAP6n00SeVJ0SVPeEhmjwIu/hSvGNhpg3aGjGEieM?=
 =?us-ascii?Q?u06A9443WHKAuGj3JoY70RowzSVxlf+O9Xzus6hjFI1P6EFsHP/VxPWsq0TE?=
 =?us-ascii?Q?nRCebNbFYK5MrUy4pP1rw0jPjZ7wiZkUuDxSQysPa+Pi83NqUKPbRwJyARez?=
 =?us-ascii?Q?KXMBr//sQCQKUi3SeGfy1QX6zivdDLFIOaYJE0gEW+R+jJkCLYF78oOKRPVz?=
 =?us-ascii?Q?dAYYuJcCl0m04V8QcVDYy79a0m+vWkSNaIkEssLzsZb1s4YH/MmNNdw3QIdo?=
 =?us-ascii?Q?WYudZXgmhulQeiCqI3ecNnpsBA666fLqPaNKQesm51f3aL8cU5OUmY3sYb8i?=
 =?us-ascii?Q?jSqQdkLBveD3Hl7DtmMuqOq1ha0Zk8ANCduUsWEStOELfpDQCd0SQR1I0WxB?=
 =?us-ascii?Q?IVcMlIev4qRXfTlWpH9u5QOHjZ4OK6iQDncxBkFy3LoAdc5QLHaC0gk8fZPV?=
 =?us-ascii?Q?9o0BKRq51jvd3Ps/u0Qhbz24kTianmg7QjpJdNDgiN5q38SEZeZNrFAvpKX6?=
 =?us-ascii?Q?plO4XLWOpRlDiqYsIWsqmrxoBwkciw/YTWPGW8j1WWTCtFiB12quAlpjWAtR?=
 =?us-ascii?Q?INW6GQjBwMXD3aA8uv8KnqFpUUEpLieKLzurU99Tl1epH2Vo4/PDXItK5iih?=
 =?us-ascii?Q?EMGEFLe2wdOrmSlaEYULaHfaSPEwahEWblxBs7lJeEehH7OHs9Nb5m52cZ+7?=
 =?us-ascii?Q?zMDnMXlB8C73v0Mt+Lx/sIGjGjhcIiug9zCUf6Vtb/6bpkZw79Bai6ie3O6e?=
 =?us-ascii?Q?+VRO7DM0o0L0S/rwEoOtfCfNiMhb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ls4g6cID6YPgbVqXVCXjKeem4MBG/7fq/BTYHbyMtplV4bctdpQ3fsrdZyz?=
 =?us-ascii?Q?OVlj2A2AHTMxiJoXvr4a43VqhI56LTzKDOyB3tp55MiGyF0G4Wg4D3GA7ma/?=
 =?us-ascii?Q?Ep1VTAlvsgLm6MVlRXNt0j4WVutPf3EcwRYd4GhkalA07YVMEXwzzL94nY1G?=
 =?us-ascii?Q?cvnuFRTFdL0M5O2s0juQgwj5SjP6e+gDOlAUtGaN9Tr41dMv9p5izHsg4HLL?=
 =?us-ascii?Q?DAOauVNiVW+mO5jRcXOZEAvYWWYnn3Nu7ENwpAD63xly6eyYAaRIHOql0UI5?=
 =?us-ascii?Q?zOn7542TiArS9vWhDQD4zfyC3Z5GQnyJM0gHATlEQ2p2s8RMyn6P9NVVXTMp?=
 =?us-ascii?Q?saiisDW2cCLzVvZyDexxjUVjsNMtYSnn7fO9tuxXzm4zy4mH/fV36doy8+iJ?=
 =?us-ascii?Q?TbnfeSz9BThZVax54oTzNSf0Dbd69krmNE40Guv6gagY8O4puB2mXQAH+CW+?=
 =?us-ascii?Q?tlZGtXXeYXthZqHxgJfRlzs6Ej/pl0Z+p9DV6+F+aVQ+1KiG9cTJ8gyxJ1jW?=
 =?us-ascii?Q?nwcmAfSs2tAYolsaXpUjFilZDsD2FQ89QX0nBKIwh7m1oMURgR0/0W63Ypiv?=
 =?us-ascii?Q?Why/zgDPosNDAzJTGdkkEWb336DhT5i80yghXt7l5xUmKUsuwje4kIDBADx9?=
 =?us-ascii?Q?s6MyDOctNDDFVEUp/9dWWpfQaFiIYATTt7MXpjYHhQTUALwG/Z9pBTrsWmQV?=
 =?us-ascii?Q?/pnB5M4RMyMUMIpw2hWDxSUgpSJ5pAYbdSgbACosheIVZd4TPUqE7ee1UD7F?=
 =?us-ascii?Q?82MM7Cu0JGGN0BMHOuzEHYGRW14T06D6rHfoDXYWnsJd7hXELQbR5X2blwgD?=
 =?us-ascii?Q?ZVSev6GXbiE+rqSXpnue9hUPNYj8dmy37iOd+DjYY9y7kAdqKmftoeI3aSE6?=
 =?us-ascii?Q?AHExI1Lz3cfVmaNetaHXToG1OtzOwIIweIHH58pswBlRjRR/aOHY6uScRDi+?=
 =?us-ascii?Q?2rAuygtT4TlLE+mZjHGMfrkFjfhOVGx2dwCI4zSaW/9hrbIjVLHu2z8ogWWe?=
 =?us-ascii?Q?xQ3wX1gUgOuq1Z8994n+wCE+YtaMPri43KQdTnG13GSjvMOdzt+yOaYoKA5x?=
 =?us-ascii?Q?FvVpSRi0yFTM38E1GSFlxVCVpR8RAg5sI+Z+82D1kHevy2lD5b32IKBgbs/d?=
 =?us-ascii?Q?eKXQS6+V9/KGAiaE2bFZMg7R3CFxrQVo9XX61jfN5+4qDYbgcirhaZJtAP/v?=
 =?us-ascii?Q?Ugi2qDnlUpVx7zRk17wHUUiKTCoqhvdL56MdjMhi4smCYWvG13eHNo+HBT8I?=
 =?us-ascii?Q?X9dvnSY+ggB/XoJz2C6ADOJsTuoykUxVkvZCmBWzfVaWvmwqTqWLvIOQRFpG?=
 =?us-ascii?Q?YgMv28sTgajjBrTDzAP55uwvc52dAUltJeRWK7KACh8rHlRsGnB5Ty9O/U2/?=
 =?us-ascii?Q?QmJPrLsMGlTqPKJwQ8sI5gUPAgqRYCyunRnmEo5fq1+qiPEz7iNB34WY5H4x?=
 =?us-ascii?Q?toyS2/m7B7i0Xypt7GmMhBDvlALzPUO15M9eAdj4V1eXWbIZwcQfeNfG2miE?=
 =?us-ascii?Q?syMcROFijbk/hnr02L4AYpnYiMD1jm22LXoHmZm/6zbizmxBVmpvryaH5tBE?=
 =?us-ascii?Q?+sk62g6QmL/2Y875KMcZU70WqsT3/S5Kz0M3/JWIz7if198K8QCnhmcPYlaC?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LurXw2Io1Fctt5iIntnRjNexqmu0IWbjaUNKobICr7vA2VUM3IqZ+ILOlAVclaXBjxf9V6g0XVdArxMdnJt1hhWFpDOyNw0oWHne3EmxFTG1DVPHSI9hkSLZkaCfAVcKASuPJVGqOoFKtHAohnQGHQ6PrS5cdoigKFUgqNF93Jv8BkwwzGnIKRulUba1AeTf6h3D8Vt09shgAER226xTCG1Xegvwt9Z9PVr1jfrmlJMI9FRqaWEoJTANBQqBaeK/jFu4ld0eZGQE/K+usXN8VfXPS33GU/Ee1aLBQ4CbZbBoniwzIzVxvW9mtIWySTyhPJcUHny4bk9JWMHpVsCM140ceqiPaJjtjICT+DZf4HjBV9FKLwOIydR9GHjgnKSyGfVE1CPeCCVAkww4DGchAHZZadunci4GFL1hm6cdxvR1WJ7JP+Hic4tf5D1ejkHoNe5O/bjdMNdEIqy5bNGECYd6Ud4XYzs1ZgiXmdDEgTuUwKjx/y8IUta/uR1TLIuAVP3J8BVQq750QVr/V020bbRoLlUywQ0lFhRh5fuJBN9SB4ZlkpGwWvoeRSxxvZSshJGH7fABil/6h8k2PT8u0YGpN+arHDF8yg2wH7VHKMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae61699-af5b-4586-041e-08ddeaeeb00f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:35:03.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OYwVvJpJubEMS1P4rrdIYc8wcSqfeXi1IuMGgQsBTyjHO7UjZuBEMTEY8kpHF7oTDprqktUZ9qzBkPy3Wa6qmbT4/dB4eG7+JQsxbWDtkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX8KDgqbMkfPs/
 OM6uGN/rwZ/qAcmB/DbdXnLIM2YZhsjG/m66LQ8V7lJDX8kKO+BcszEsxITeopcFc1+mBPElPfx
 SVoqH4V2yeF2uU1anUZRP2WwME9AWjXAG9bZAuAikp14Ta9qlmmTg+jPPoJuaFzZo1zlIQVbUZZ
 tz22ZK/yt7RriQPuKkBvny4kEmH/J2+OvsG6BcH4VogkMAH2dZCn50ZXOMKtY8cxc7IeT10VhX1
 F9wdf50Oop94vNQ9/qGAU09zM/FpugKMIDMOuzKyCWMt+zJ53a0UIhhtcN5MkfwDiDUURMGcFbT
 /urCFozPisMMDGSp7Gr4fcTfqBlHd14vuCSSFkPEl7r7GwusVas0KDimAFKVHQ0YAnovQ+okXJ8
 YQToGPmB5zXxnkbdqNiNAMgxiSvNyw==
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b8440c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=XtbzWmrbHnPqotb3VYQA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22 cc=ntf
 awl=host:13602
X-Proofpoint-ORIG-GUID: 5OIAfnUMvuVb3Uv4UWyR5usZGSMGzWe1
X-Proofpoint-GUID: 5OIAfnUMvuVb3Uv4UWyR5usZGSMGzWe1

On Wed, Sep 03, 2025 at 04:13:42PM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on gfs2/for-next linus/master v6.17-rc4 next-20250902]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/gfs2-udf-update-to-use-mmap_prepare/20250902-200024
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/20250902115341.292100-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] gfs2, udf: update to use mmap_prepare
> config: x86_64-randconfig-005-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031521.aEPzyTZp-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031521.aEPzyTZp-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509031521.aEPzyTZp-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> fs/gfs2/file.c:1582:18: error: use of undeclared identifier 'gfs2_mmap'; did you mean 'vfs_mmap'?
>     1582 |         .mmap_prepare   = gfs2_mmap,
>          |                           ^~~~~~~~~
>          |                           vfs_mmap
>    include/linux/fs.h:2393:19: note: 'vfs_mmap' declared here
>     2393 | static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
>          |                   ^
> >> fs/gfs2/file.c:1582:18: error: incompatible function pointer types initializing 'int (*)(struct vm_area_desc *)' with an expression of type 'int (struct file *, struct vm_area_struct *)' [-Wincompatible-function-pointer-types]
>     1582 |         .mmap_prepare   = gfs2_mmap,

Yeah silly typo, to make life easier will send v2.

