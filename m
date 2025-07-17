Return-Path: <linux-fsdevel+bounces-55292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF6B09545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DAFA61A80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393A21C9E9;
	Thu, 17 Jul 2025 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyZp77ti";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DTxvtt8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A71799F;
	Thu, 17 Jul 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782186; cv=fail; b=dEm2jLYQYtPGCsnxYc3jk53YxD6VgLoRTPHGytGRDsBfgjXFMqbXt/Pn0/ELRZLMow453Kp2p284iQskorQ+BQQZSQgApxbreFRmNsjnwqODFcjTaWb1X286NERoUi1BDwEeY9UZ0UAR47h3phQjbQGHbzusBAsFTwcWidfN6kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782186; c=relaxed/simple;
	bh=us6+mMOPIHPhH1SFoN6uTfm7nBKMPeOB+yj7sbWaPj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r7mDhciuuPeoXgqRXUUb6p36XjfTBIGdJwMKny1aXeyby1YC/251TpE3ytnSrQ58XdKtl9RHDtycScvzZ+DX4TEy7dfrXEVdoC+qSUeiRrSK2m9PrrRRoqmlcEaBUprf58LwKan4/KpBXjSj0nJqbUdbhzarwIEqgHdW3FZokpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TyZp77ti; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DTxvtt8E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXoTl019105;
	Thu, 17 Jul 2025 19:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=k9ZMd5oUliJpkQFbZt
	Kws7WQNqdJvQA5ZTb93CN7ByI=; b=TyZp77tiBJTVwineSpzqXw1ct63H2Ymg4n
	ccODidApyjD9DcM0Jeg6/3XA/eOnnLMV5PCSlpecs1qVMwGk/EvgwVzle31YNzEN
	DMiwn/4tmT+M5c9u/oJjTNrUihdrTTV4Qsmc55PYdLUlPCkkwTA1yy6kgOAevLI6
	iFsrga3oDu9CpD6RnRtyVqf1zRaWJVz676wMWz24VvvlahpSaNrFZY1QKw/V41Ut
	RTwnCiFFaLIxkqNvNLDNKiSMZvXdw/TGMo6dV6fPXKsJt7eygYF9E6WPfZnBZ3j5
	AathQpsYzuoyioTEK/gW2DcnYk8uzqepR4ecYEyuGlnRlOWLSanA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4uthn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJWhfN024538;
	Thu, 17 Jul 2025 19:55:48 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011019.outbound.protection.outlook.com [40.93.199.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d5d5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9s08NE3Qwx/3lTbrIsdIzAA41DALP+C7iOAihcKA3WkBkZc+j37/2qJBjsgefDZD20iehV5P/DgMm6rle1Jm6daqEteKepfdFvmr6jjGtxXid9sA1TqoM/oHf2gbfRsKHb/pVO83fjUVUmPPzsBEOWgwEbJRWxee5sJdEJaxYkKY42B3rjHUKlxVY+0SddShI9jflr2fGXIGKL4RJgcLA31fR/LeIn57xU/rYaMz5UlBdEXoRdoaQs5uOr8ZE56HNFw6v/GJ0hLishbY3zOuChKTT0S6+BA0md+QhkPw3dA4QxVC6xlCjy1ZrWv60O5GQ2mfErYFlIP5k79cbp6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9ZMd5oUliJpkQFbZtKws7WQNqdJvQA5ZTb93CN7ByI=;
 b=HH210V/DGqzTD65dYMoQRGPV5wKNBRmQGs1sCWoy2zT6SxxXebzQHQ5ZMcd7HgM5hGsw2lAEjswG0CE7QcvT1cNpC3o4grCQdCZ5xkW4xG3p+LSjqUI+Ap0uSD8AfoSGQB7AfvqjgxmXYVkiGsd81Yf9a6z7pfgeZcgI3At9Y9gKmiXx2gGGibJCb5NOpGa1cXz92FhKdThXXFOwKoNnULh/drs3ut2LobyYUii5AgMTG6R/LkWBdZyXK5PAyI6LO/hJgTex1KnrSSBG0Fg/n0awYh72qS+AVqK4ETea3TtpVi0ejnXNWV9rpGA3G8aPWXhUdgmjVbABgyvQ7vE3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9ZMd5oUliJpkQFbZtKws7WQNqdJvQA5ZTb93CN7ByI=;
 b=DTxvtt8E/35xJABp9ypBT5wRZtZyvRBY5t4vSHfpLKmjqWnv3+xmZv/NKG5wDy0AqUyS6Ea9zT9VsWhaFVDr0kqf8NwUXMV/Hj4ubK9eQJaZpexgdCPGkXpH500WIs3/y7Nk/78w6FqzvVJ+aY3wQXQ1TBHktbmM1SBHBR7AeRg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:55:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:55:46 +0000
Date: Thu, 17 Jul 2025 20:55:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <50190a14-78fb-4a4a-82fa-d7b887aa4754@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-8-david@redhat.com>
 <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
X-ClientProxiedBy: LO4P123CA0635.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5344261a-23d8-4270-7742-08ddc56beb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MIPl6Zzzt16nG3kTLFiUwEPAcIB2FZdxAK0F5Yx4s0IgBTUZyEgk1WlmH5GO?=
 =?us-ascii?Q?92uK+MrfOk9N7Tovqkz+YP1GYY+gwvPwNe47ya+WC7lNb54lxYrCH/bO+a06?=
 =?us-ascii?Q?BrpMvQBtOwyuIKKSf1h7uAbkoQlYNhGQfoGWfnLErZrfnumAfz34Xuh88z6s?=
 =?us-ascii?Q?1jhsLPqZoCQ/NVknAN6uDl/5dwyu/JjlAZ67Zy101dIPs/m49etRB/UKoRG4?=
 =?us-ascii?Q?y35/J2WDh0kXvF01PdQPwnaAxy4gO1t5KjjCvfrlq9nvlsNGksKY2wXBkbxZ?=
 =?us-ascii?Q?Rjymeoo09xi9oi7mdaOuTvtRwUzPYovGK7zoJQFp05oFo254snj2edoJtDgQ?=
 =?us-ascii?Q?94Qzu9jBKHe8+vEaAJWsmZgvitblNYapc5vTmEYLdYnrTaC/z1vCnphikG2W?=
 =?us-ascii?Q?1OTYseqGueAtlsS2PPbxRFxsY5Y1nAauYHR2oFRXk0d14145ATcxviwgZbOn?=
 =?us-ascii?Q?lZUoOglF5ictp5YnwigjfRS4roj5h33wU+GxzZoEHE/liUvh+nJir0aHVvK0?=
 =?us-ascii?Q?xk0Af0eB9V/+pyL1hRGUZne4ffcVcWBfFyuuNm0qBt7E7tulD8vI8R3/Crob?=
 =?us-ascii?Q?MozOLL4Kf7eqO25hmQREMqt7BVB70spVu3pho1mdSIX/M42Xbj1HRr+Lqt2k?=
 =?us-ascii?Q?a+wefRL8hLFi/nAgpnOC7sGdb/lYp02ZA0HXdwG9KFkpb09eumu18dSF2e0l?=
 =?us-ascii?Q?zfvcRywVpQpdHSGMXn31/VdtFztkqX8LyLJajTWp8TBmU2s3F/3FQ/p4U7Sm?=
 =?us-ascii?Q?GRKUGAWAs5ab1u/vEUbE3BrDgzeJVTKx48z72a5UgPhpQqfbac6nkAP+A5Mh?=
 =?us-ascii?Q?CXpsGMKIf94lfBUvArb+8EueLD2FOzlx00CJkhrssagUyv9QM6e410+E+obd?=
 =?us-ascii?Q?TFpbKJ9YVLBz7Nrk2NEUueG2pXBhBo+QEr1BgYWIoNezPismGFr0qQdRM/KB?=
 =?us-ascii?Q?bOrP/r8pOEboFykfefu5kMuiXY/9xbj4p3MtfNFZp99UXLaPHtV8hnwvkY3y?=
 =?us-ascii?Q?/5Qh5ij7LHIMizvLvZaP/JHrxyGKDZrrb5mT2GSDSY3PIJZZ1Ji+ZKI6AfUg?=
 =?us-ascii?Q?a/6w4p4c3tOpg7yME2rANN5qaTInwX/MAMsCYqRA8UXsrzmxSBpEigGvlKUF?=
 =?us-ascii?Q?tnMGuTkXGSlFbf5gKcXnqo0dPDGGAPmGHpBD/KEc/IpSYKtnYcYzOxkVRrAI?=
 =?us-ascii?Q?HHJcK7m0BqB7fSPa/jd/AdcpbOaS22ATU+SXhIEC1t73g12i3m9lWGZRKdEy?=
 =?us-ascii?Q?YuXano+MJdpt6vszAkBbd/0CaJMGygXWRMiGhQHqlqrM7H2zjrpWnAizbmC/?=
 =?us-ascii?Q?nop2YVh88rpFj6QJnnsGVIGPIvk6vfcJUJrLjzEdXxzhy7iNcvaPwtVQbatn?=
 =?us-ascii?Q?EOjquxJ912TjvFYf4/Vz8/G1y0843Js+xpH05PxXvFQ9T2J//LuIEwW/7eI6?=
 =?us-ascii?Q?g7WDJ2zfEyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxedC7D9HsCiEd1ByG1bSobgmGA6iMjpXiTXuMicpIrv/4hbyZEMgsfGGq5k?=
 =?us-ascii?Q?mdIrMfe9i29/vwfr0tZCp3qpKcH9rVyJ3zRaIpMd0hrkf08RnEnIPfXm8M0V?=
 =?us-ascii?Q?cHLR1ZKE8dElzqfXaK/2hKOZOsQbeGiYpDrus75eEex/GlvizCvwBnWIgjlI?=
 =?us-ascii?Q?RheSpMfZZ5wTe3wFAzUqGJs1/OXj5PHyHW8/nGRFvMR1mWxxtQutb/w8gqNV?=
 =?us-ascii?Q?dEcZpyowhIkumAbXpsD1v0lAyCsAK7tcXlWKk/S0NpArg0WBjfs12+OunauJ?=
 =?us-ascii?Q?1+oyTCsR8SJE/G1iS6Lc6rbILziv34jY7JBqQYPJcDO+qhzORJzsr44ckX6O?=
 =?us-ascii?Q?Ap0KPEX+YwgRQhOW/GzWSwg+80CeA8P5JMMYd5YocOUOTjTg8y5G71Ga2r57?=
 =?us-ascii?Q?8DDDtTo0YNYtGyP2O+EZtOX9im1Gy3tgM211WqVR0HZmumhSgqGx7HG7Lx2k?=
 =?us-ascii?Q?eHqKV32n9JFVHTo56ZrdKZlBXBtn15pnbygFhpwK9r8tIswJOLYV69QzMmwM?=
 =?us-ascii?Q?JicIaL7l2OE1UxFSuheF5qHgCpsG6VBCfnhhKqg2gyac2FOoVQ79rfUJDk05?=
 =?us-ascii?Q?o9rLVMt1uP2J9edurxAgF1xswYqF4FfNzBFzpPS8+X7lOOaJApeQZ/LBevbI?=
 =?us-ascii?Q?W7l/jvTVMEVnJ/6dSnIZ/LD9yrZq8fVdm5+zz3Zsdu0kxONDUJi3hIezaFAt?=
 =?us-ascii?Q?+o4gpA3LJZk+OivP0Fcb/gBilXMqxWFztL+5lXXo9bQ4Z/BYN8iuuH5Qbds2?=
 =?us-ascii?Q?+uZzv8v6FhkckrSXUsc8f7dxmOBF5AMpFQ4xjoLT3ulw+BNd9v12m1kCkDCU?=
 =?us-ascii?Q?10qHWDNqkJwCBvJK5ZyR6d84t5re4hP4sccQGM7HmZclQdUbNEXXcIBcQuGd?=
 =?us-ascii?Q?p7jfdUxXaGYU+fQQAiXu9BZg8ns+thefeePN2MPtesDaH4uMVBnmwW3x6ooT?=
 =?us-ascii?Q?Q/WUg1dbMERYMWrWhziY9/zLncst4lVsum19Dh1bsoutN4KG4nygYeHWIHhm?=
 =?us-ascii?Q?YsbteFs/aLsZRVh61OZEAdUNdtaTeWbBVkXcBZLCzZWpq3cNCwPxLPgq2fmD?=
 =?us-ascii?Q?dpJhNyRy9ABMKkjwTQhJYLd4KffYcBuVrSINnHShdXGePed2N2WtgD8KsoXm?=
 =?us-ascii?Q?tbvdnWMDO+Avxseo5CMD/f4N/rJm6Xclk1enEx5Ayrbeihsx1dxNZaxFePyO?=
 =?us-ascii?Q?wWd9J9UUn9lf43DNAWV0wY5SdOWJTmXRyDpNsYIwxrdeGg+3EmLJURTcy0WK?=
 =?us-ascii?Q?vi0vb8XVlEgiGpY+WjWuEJjWecdEEfBqE8a57A/9uuqcyUlY5xXnVNoCxMM1?=
 =?us-ascii?Q?Dt5EjJtigvke94qRQ34zWPP841Q6uxX27wUAaex/hu9SSCHDO7XM40mCE6Gy?=
 =?us-ascii?Q?+IQNBhbANiPBof11Rn1mppN3Xns0ViwAtsNLSzsQ/74hsx7iJ7m8pwCfg8hN?=
 =?us-ascii?Q?N06ya9fzGJu0wVQM1I0TyxCVN3gPijruHSKbfYjNLPibmVXvDtmu9f/iw0Hw?=
 =?us-ascii?Q?h+4SugyhwEMkOTKQPTnRb+MmMEzBxomTfojQYuRzRrYk/F6tKsxczZP8CjHU?=
 =?us-ascii?Q?XtPGfy17EEYAEKuRklv9ktOwAklmeKnQyUVMg358/jyvY9rpqi70ctM8tUsu?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vfdSfmOn+zq6WNoAkAuEN6p9PFhPkgUA3xo8bcH2QdbM/ACVP8MpFwyyG02l/5VvI9ZNDYTZY0ZJITdaO+oaUzADybbq0eyFTAhNzJ9Ck8SmZksEdCAMSF+VsS8eu9fNgMVX4/1a52ZKxfaqnRc3kP08W+rO9zSYelwVW+wNnULpX0hWX/vwBHkRnu2GSoSwfk9DSR/k09Gz39eN6ZTV5A+5KUJPltTFKH0TqRxw3E+6v+Nsq1pRZSzBsqk3YjpRvdmgGAviG/H7z2v2TvzQ1gWBDY3TMhHTyybT4e9WeuiFjI2dqWl49roTd+csdYRV5tEKPH7oJmoUiAF4LrLLb9tNlo2yClyOeoJQ0JOet6TcrhLO+XO3hpTuxwCQXUL33I0CC1pEhQgX8Gbs75DsJKkmxSeCNRr7rwT7Et2MbZ7t3oXtB3dIpDwUjaEGJFuLmds1g8zY2biBDQo3kZcGt6j35PkY95dnjIW3VP4urgI3MlzAMKCbh0m+tKM6ReUmSpQ7G9dhfvveuQryO7Pf+oYeWKuaxg5uGnZo1Yw8LyUuTaU99mz5k6ba1FE9mvPem9Wvv8KUdAVt7/ijhXrhmi03CBPXVzjoy/uhzmniGOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5344261a-23d8-4270-7742-08ddc56beb79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:55:46.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIrlPQl998WfwQRqBinFdbtv+FIjHd8PaCNdyL83z93m+LXO4tNZl2lm7M7OHhUfAkJXiJ9lAhk0g2weTHxP1f8lLxeGg1m366l/VXDmHxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170176
X-Proofpoint-ORIG-GUID: _Vj8K2jFbyIiyABoHSMSks5CxZlAW0-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NiBTYWx0ZWRfX+Y1JeZhKZH54 Te6blM3IoEoJh8W37Ly8kobM3yPlOcSBAJ8S5GLZEpHUL4AuW+OMAhAdUh1mTPPWjsC9WObg7BS Z8j6syPI79omTCwtW86b2wqqCbBCqLDiAhgPzFAZtRlnGOw06npHG/HW1lhSxdJYcXmciYXYJWJ
 yap0Lo3lX7eh5pybP+o9FCN6wwCf+UHnDLZA0HXlUTxnrCvPhRA6IeHjG2/i7fH4XUSGenoLPyD SkzbMsyJets8WdnqG3LW48OjYYntEioKRZ9hjJXZhIY0xCFn6zdblfSNCW5OvPuInFISDgcTFpG ndPMJ8Lt71TuGqmWTaohEcD5SuXBSYf48R+OWOSFG+RDZse468MMOphFQuGnrsG/fsM/m1y5QbX
 whQVtOz2HT21hGEnDwu6QyYRc9tbfLTvujTJenKjaC3oRX3Tpquq76or6dlHC4s+uWXd0wHI
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68795545 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=lxfUvszjCgD01uZTbxEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _Vj8K2jFbyIiyABoHSMSks5CxZlAW0-J

On Thu, Jul 17, 2025 at 08:51:51PM +0100, Lorenzo Stoakes wrote:
> > @@ -721,37 +772,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> >  		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
> >  		return NULL;
> >  	}
> > -
> > -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> > -		if (vma->vm_flags & VM_MIXEDMAP) {
> > -			if (!pfn_valid(pfn))
> > -				return NULL;
> > -			goto out;
> > -		} else {
> > -			unsigned long off;
> > -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> > -			if (pfn == vma->vm_pgoff + off)
> > -				return NULL;
> > -			if (!is_cow_mapping(vma->vm_flags))
> > -				return NULL;
> > -		}
> > -	}
> > -
> > -	if (is_huge_zero_pfn(pfn))
> > -		return NULL;
> > -	if (unlikely(pfn > highest_memmap_pfn)) {
> > -		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
> > -		return NULL;
> > -	}
> > -
> > -	/*
> > -	 * NOTE! We still have PageReserved() pages in the page tables.
> > -	 * eg. VDSO mappings can cause them to exist.
> > -	 */
> > -out:
> > -	return pfn_to_page(pfn);
> > +	return vm_normal_page_pfn(vma, addr, pfn, pmd_val(pmd));
>
> Hmm this seems broken, because you're now making these special on arches with
> pte_special() right? But then you're invoking the not-special function?
>
> Also for non-pte_special() arches you're kind of implying they _maybe_ could be
> special.

OK sorry the diff caught me out here, you explicitly handle the pmd_special()
case here, duplicatively (yuck).

Maybe you fix this up in a later patch :)

Anyway, again it'd be nice to somehow find a way to separate the special
check out from the rest.

