Return-Path: <linux-fsdevel+bounces-53392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A09AEE538
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71656189E919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F0CA4E;
	Mon, 30 Jun 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GvmLweEb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mCh+Dypx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A92571C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303082; cv=fail; b=WIdj1IgcAOA4yqiat//+vwx0thJXXa9kTxkkzCXSC/QvqILY1A/m9CJqGNRRfH9o7oQ+Rt/gXEqibOxSavYvU2iJT2ez/D8rOXWvs7CEIn4LZl4KC3pblehLhadI3Hj8rlV5EjjHcLlLZYVqQ2nF6rY1Svsvar+fnj+N8YWU2ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303082; c=relaxed/simple;
	bh=FGo9c6QwIOoEO/ctFzkwwPwJ1zkPlI3yStPZAcEcQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GoDqhikzDtEfljQxiGp8kGRlIpBYflNdIoSFlgr7Xupv7h5qlIST+u/2/q7HxHfiZ26Y0QdrcDDSREsdgI3YTZOEY898/zIYUngEwGtOC1SatGqeNkppyEuechyolI6f9DpeT5e75z6/fOnUYxI7ARLHXrFZGg8v3ZLCxrgBTlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GvmLweEb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mCh+Dypx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkxGH029588;
	Mon, 30 Jun 2025 17:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FGo9c6QwIOoEO/ctFz
	kwwPwJ1zkPlI3yStPZAcEcQ8M=; b=GvmLweEbYjnRwcPshlIM+apjiZ4UEhyFYr
	oO4oyM9oCzaRIvgAiiEPq03ChVRB41AJL388hGU0xFVnyhcTHxIeSkA05hrLauCP
	C7wRh/dvtMo3XbUT6/NEOiJ/hMnK5FouLlmDukFoAg4g3uK/K1s3yXZWMJbO9T6g
	4Ii/x0KYhj1+z2NPhcJ4u7i6jBz+QVW80EpgW0jzvSnswZMDrfHm2YyUdy7NCkAa
	W+CdSM3/0wQ6uhEosXnEhwo+J73/j6S8mQBZOYIMSYzjdu5dEbOMWyjAcWyCE5Ec
	AX2CAE+F3N0evPRiP+NvsyxEUZ6EHvFtz610WC14+Vr4ax6VCI/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef30p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:04:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFbXuw011621;
	Mon, 30 Jun 2025 17:04:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8c99b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQTyVfor//tPaoN3PBWQzKU5E7lBzCax1k0NaSGtOQL9EDPjn4k5fdFd9FAqp6uYLe5Xtr5R4aMx8FPtz75gFqRSxRTsUvgCJXHfcz+w3gSTPAfrHTtwo2FSihL3+C1utx4CoDrbzjcetADibuxUlVDxJh6swrUy95MluU6GxfhT53BetNUBtIyqoit+3LUNt6HhRbbBvcTcDpOUZQ6IGEfKcMkwEw7Gk82SQgmDcfK+KaNQmT7kgmuEQHUpIdknt/KxwmyLa7XviyFOIU8dmKfs31sUxl9ZewVEyOEUoZIMVsZtlpK4XXeFU7EkikvQMtDIPWIN4KiIcdm/rf0cqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGo9c6QwIOoEO/ctFzkwwPwJ1zkPlI3yStPZAcEcQ8M=;
 b=f2Mtv8yX53Ylyf3NGHh48kqmvcUmbO7N8iirPYXOUxM7/lRCo8oYrywxZrD9xy97u9KhNfstQT4Avo396sN4RXQRk2SDp1fAKI86zFotfWDyZeUHOl7OQQV+FGGVPFVZshGftNR+k2VQ0lyA2nyKspvUoaEAcR9inBmEKk8ApkCgBDmB/zmW6lDkxWsVyTgf5DkpV2WJmZbL6aLJsRhm8H7L4zjwEijtOQ75t2VjgwhTUFvFrqmFeZsYV2+w5ohueZcaYy2RifWGMMgavlfPyBxpIGvolkejeflCpqG9F93yO20rGoZ1UZGvXRw8aPhdLV62+tuXofqClVkfZ5wGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGo9c6QwIOoEO/ctFzkwwPwJ1zkPlI3yStPZAcEcQ8M=;
 b=mCh+DypxSE6t3xX7TUaLTJLKeYa61mTOt8aPGyDjd9CXxvjQee1DACQ7pLj54sFmBHpvVxJwKg3rHjwefwEL0LQUCA70d4c2VDRgtYZVo3xA+5qPfCDUd/ZHceuNodvhK2MgSbii2SyxwXoOe73wZQ4MMGNEAHXtxS3vsdQWOiw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 17:04:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 17:04:34 +0000
Date: Mon, 30 Jun 2025 18:04:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for
 simple mappings
Message-ID: <f86fdc87-cebc-4f64-8c56-4270c0ca593d@lucifer.local>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
 <CAOg9mSQcpC+Y0gMBZ1KO-Fofw5a=6NaSpM8+b+Xq3ZEgUQcOew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQcpC+Y0gMBZ1KO-Fofw5a=6NaSpM8+b+Xq3ZEgUQcOew@mail.gmail.com>
X-ClientProxiedBy: LNXP123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 42767747-ee00-412b-caad-08ddb7f8301e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CdqzAcYcWwdyi/JXxPNSBAWf6sU0nIfQbt+KOeqB2dtYgZNBCssXteZKrjkE?=
 =?us-ascii?Q?ZGWi7g9N03Ov6riMk8ZaWsSmQ5Pqp4z5c9FTVj23hn9Gk3FtdRAdfOGOah72?=
 =?us-ascii?Q?qrm9E6KG4KPGwJfODBPfKL6CSiRWlQr7pUoWyfYgJpedYSsSWjlAq7IX/tsp?=
 =?us-ascii?Q?nIA4DeRAJsMF5drIkC/+19lYPaCW6vyeyinO+JD3PhWVZNSsgZyx/shRNXy1?=
 =?us-ascii?Q?VINr53ZSJwJBJW3OQp4OR4/ZjzK48kNxkh9c7n7JCFwacZ/cHO9u/f7exf0a?=
 =?us-ascii?Q?PW/y1Ti9x8l7Hr26eFPQNVC4mOyGIhEoGG7AacK8QRRSTcCquHcB4/SjGydX?=
 =?us-ascii?Q?waZvKYyIG8mmbHWhOq1VDGgSrg04VW2bO/4mC3RjOX+YTyWlgTWwADsgwk6k?=
 =?us-ascii?Q?AbWuRHdCoj9c6GAWdSkIDa0Yn0b2XAZ896vCtZ+m0XC3G0BJu8+Mm9ZTE9Oc?=
 =?us-ascii?Q?HAIlnqTpTT7WAswJ3K5xyodnw2U8xYBhiaOwnp/dL+dxNT1grhHeHjlSW2yB?=
 =?us-ascii?Q?uhEpoMh/RA4Xa4lw1U1M71hc4A6rbY+2z0s5bZlpYas7xbMfyU7wvXNJ3gR9?=
 =?us-ascii?Q?2xzDatc5NVuqa8T+qPSLZJ5DHYrmylTSWoAAINEX5ZQYlLVdLrqkS2dWh93u?=
 =?us-ascii?Q?XAQk/I6wzvHEvKC/O1csEf4ztVU5uNWNOdye5lLei3Gw/NxLcdgu2xiQiEf2?=
 =?us-ascii?Q?lqJ3XYN02/DC6AplrVI+1YaFItMnRqJIYjm3TMYI20fzlsMIa/HnS75K0nD2?=
 =?us-ascii?Q?O0xepib84ShXJ5kWrJImoPCfoE9vmcBJwbn/UaTUqef6zn+h2Rzyj8jTV+kt?=
 =?us-ascii?Q?0ywxhf1WNpoTyXgLr5KFU8L9JrbQurGBx0PY5rnBlP1cdcMpCTkD8ArAP7/b?=
 =?us-ascii?Q?XZMfrTqfZtI18yFAvWLoza/OEoGnhYgJEWFdOttzXNZTmB1sqhlqcQfo1whG?=
 =?us-ascii?Q?RQdbvQgw1LyL9xumCNcrS/8cnEmyF44CT9kIQExLrmtap6nvxxbCODxXgQ0l?=
 =?us-ascii?Q?LRnNw07kE1W2BVsAU9cRR0VwoX+Aagp/Smb7+Q0dwAonUN4FoWFk4L7bQt/Y?=
 =?us-ascii?Q?wW9sIMwI6OUjOCJQJv++NOGOn1ZCtfW33uv0PN5IJyFMsBYLWr54n/6ltHtQ?=
 =?us-ascii?Q?8MM43wS08IYwO4rn+0INOqk/nNQy8bF/Pyfhrk7Yx/YdVBxNz1TvpHgsRne0?=
 =?us-ascii?Q?5Go6AqaxwwjY7vVNrRcksN/2YZS3K/y7yQzHMTsC3Ub4U+mTyrPl6fseiFPv?=
 =?us-ascii?Q?mSUyjNqfcN3/d+m+48AvqwgHIGHsuOIWDMjKLGx8MfazaAIp/A85OcRLJkn1?=
 =?us-ascii?Q?KlTPStnCO30d5zK/1iVGzFwHLIXZ9IQxzYCX4DHlavTHUdOU6lXOzcR7IbT7?=
 =?us-ascii?Q?jJGVeqoWtZh/ny3GtHJj2fUis7JDs3sIKB3HvWWxccYUAIyQ7LY267yKKj9C?=
 =?us-ascii?Q?0HEjOhcBfqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+BOVbIzTyZXlY4+YLzRjjTP10tVnAsNaFxzTr6MR8OURIoUjujR3i/WbekE?=
 =?us-ascii?Q?MYUaTyH8j9JDCo8mTeGGIuAA0Y+gJq/novNMSUduCRoXPE/fs9ksrfZTBcoD?=
 =?us-ascii?Q?hvbBzZ7tvPmO5CmTccaZmA74C846qNLZWhzewMpmqQWdQZXwLzI05MXHTpfg?=
 =?us-ascii?Q?q7e1gHwVKOQg4hXfgBvlBLL7DgkjU+Cbqb0NRtWq1dgW7EA4Zzw90EWHkGUm?=
 =?us-ascii?Q?8oh1p70hBmp7jM53FBO2WVjWeqQ17qeLPfBuT5GfHFij7wa48hGiDbbeKbAK?=
 =?us-ascii?Q?8xMw3I2+gjyfWvvRsto0nZ/W2Pp21WoPJBR0oSnpTWypwwjlulVianuDbjHQ?=
 =?us-ascii?Q?MMPUN0u3N4HkIz9DXnn7VLihwAFRB9MM5YxvabZeCZZ7ERVaaleVYrcuNoW2?=
 =?us-ascii?Q?WXAtEQjjEsxika3zOtblTq1Au1paKE4PlbVqNVR+56kDxIupPIOEeYzwbVpn?=
 =?us-ascii?Q?fCu6MGziSjqug9R5qeXkaGL6oYGG7/DLlKGWr2Y0wJw438ucBfvmbssXlBZE?=
 =?us-ascii?Q?kdpqBd2mqR9NaJyBf5cR/HfWiQSA7GvgbgQZKSHcdb5ueegVU9ERiaExWece?=
 =?us-ascii?Q?NKMavbTsmDthXa/kfOMOMmTzAqYg6x0Oy3162q+li91He5tvkbUxOHJbs2+h?=
 =?us-ascii?Q?HsVylYUsuimBqJ6161fqeU7Z4522XbP/UuAvq56ILiV5ZQwEmv3f1pS/W5If?=
 =?us-ascii?Q?LBG/evHG/QTtskHyDHfRF26xoBwa3NsljGE+CBh1B2jfZYiM8ckE8zTpbA8d?=
 =?us-ascii?Q?E3qTLb7amc1l66VSWe/lMwnseFLZa4kdGbN98Sx3aYwnogzZ/9AqOtMjIIAO?=
 =?us-ascii?Q?mDte88b7ShheynJEkCgSW20u1Hxt2XIE1raDS4kSLhMC5FoxbGdJOIXYZyqs?=
 =?us-ascii?Q?0bSMqR/6AiPDqENYVLhLPEUDx1nW46LeN1z7wvnhWG1CAAye1cop1x4LXwz1?=
 =?us-ascii?Q?pfUaNYwRn6zzeYDZp7FcuILuJ/JUU1nQIUj/Yyn19X+WcvZlz298Z/HkOOBo?=
 =?us-ascii?Q?lf7swAJh9xas/FjV8pORUsbC5WFcA0F38gySLFU60aOS76AFnWohP+Odnzir?=
 =?us-ascii?Q?7V9dDukCffM5qNRJ5cbSSD85ePsVKY17uRpxL6oozUxWK2Te1zbAy8K0Dx+j?=
 =?us-ascii?Q?BDeCOGzXb+BP8KZDcCahniGYMCHDIXwLPijNL7QsNFU42W8cJXRgL/E82DN/?=
 =?us-ascii?Q?Hbi//4l8BRjecdcwoNguVWd+u3cURszku7kluVuyqejRZBM+9r2zxebTEUNF?=
 =?us-ascii?Q?2xRkRWDJ+BiNESPM9pucf3Km61xPAi+qHvZPxOLyrjnOAxHrTfdCUollabWi?=
 =?us-ascii?Q?5diR4Rz7LeE2u0y5D91iTCPW/gRGobaGpUI7QUpK6O8zLnnaTEj2B39IPsPg?=
 =?us-ascii?Q?VoBHFBC/XdLIDb6EesXbszHWCwJdnjb2ykgo6EmPGUG7EXorHZkfdOhamc3H?=
 =?us-ascii?Q?8e47XgraQIIaeHiKDFBkyAeVhghXtq2Brnj++VAzmr4xQUkfEI/s1jVPQOfo?=
 =?us-ascii?Q?grxkcoNTkXcwMf1gOSqnXJkRg6WluBSqbq6HJCsqbKlSlq7lis6tIZyPjF9J?=
 =?us-ascii?Q?uPvhIoN3P09n5sqUJNy0sEwoD1u8xqtjSXD77uVFq4Ck1wGvg69juVqRk3d/?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HIfJXNgK5tFwoGDB0hTMOdoJFOYvDiKz8/Rst1Rb/dN5xV94k75EXrQqxgYlhCrxIG1LXycZwFRvtdOi7LtiqzDgrZpZtSh+p+j52ry7IwjgcUTzBa2dggJfTKOVGF5FWbWZasKf1tVjHLlXDplP9AOfSjqexOVS2IcsxLo8RxPNZPp+1jzQqC8apyVH9IWv09SYpFbwB5T/926zTx+6CjsBhNCbUhELObyZq/at2tnKLyx0EBti3sMTkBQrSxPnttYg37t1tZkflLnfpyUwehDsYJk5oW7a3ZuWYgQOh+BceWM3Nd0EYzp1pRP0T+tnP82RfAtn7Y7g8Um7hS1Rjr1lTcGyYyizIc9FSNZlm4q35BPcB4HnZb9vf/YAwGdLFOVCRSkVsw62htg7L3WKHCLrhgbg5cg4kC/U2t81qHTT6MlkE55mAFGL9vf8f0TybxRWOmigai5zA/xGpCicDCzz6EnmQyZpHEPMLb78dtyKtW2V1jiSqgyawV94YfpQ/Kykrnbug+LJeH0DskQXSStCFSq5cNm/vCLqtgCdCME/pIVTK6ho9HiQ2n7m+K1Eh1RWrDpZzUXXLHj7HCXiWo6B25X12pZRqgtptGFOS2o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42767747-ee00-412b-caad-08ddb7f8301e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:04:34.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJPTFymyVOhwCNlx11lZ3/GOMgz5zw0pON5gDJi9l0PSubZu8x5xjU5iMpzFrntQOh2AOBPqIbtetHiP624+fdn/cInG5CZ6vOZdW7r18Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=679 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300140
X-Proofpoint-GUID: Em4ozqov_tANE5hv3Iv9aq6L8CzLeryT
X-Proofpoint-ORIG-GUID: Em4ozqov_tANE5hv3Iv9aq6L8CzLeryT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0MCBTYWx0ZWRfX9Kckqddn99aL LZhkQMVNH9oRzFBiKuEfWlt79oNHaaXP/MhWKNLBW6zQLG5Io/vCY9g+zHYPKaBaI6mrGXVLahO 0pCrk2i74bIkdjMIcvvb+6lSBagjm1xinSk/QtDX37yGpX8bMhKMfcXdRhNjizF2ty7z8Pp7jBe
 JevmDpJ7FNMW7KjdPY9Y7pRxQzvWtNMXN9vpjqZeVHjXE8nwD8XyPKJkZwM774kmF1PQY77sDO+ VDWHT8BVmNGIj+KhslqyKGouBvovKM58zyIUgXT3BapULdBzCwBR9XQCun6TZ3y/HpS7FCHXBLr Odeo2AnWdW+ooHXasCrLgUSUBHs3w6a3H9smg5Q8NRjmYhhKUDzNtCaptEW0Nb5nPDYWAyJxhvU
 mxN/+KUg2uZ6Xf93jIoS2HUgr9Pnqd9RDIkMb89//omGO1QZJhqDd4IATsOlsUf12r/DMsqw
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6862c3a6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=V0YIjy4R7NDmwhDahQUA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 12:55:30PM -0400, Mike Marshall wrote:
> I added this patch series to 6.16-rc3 and ran it through xfstests
> for orangefs with no regressions...
>
> -Mike

Thanks Mike! :)

