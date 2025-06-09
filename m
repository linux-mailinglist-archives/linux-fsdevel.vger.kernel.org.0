Return-Path: <linux-fsdevel+bounces-51042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04584AD22DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C8D164FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D42217648;
	Mon,  9 Jun 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MbOB6Zqs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qhvqBP7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245211DE2DF;
	Mon,  9 Jun 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483978; cv=fail; b=pw517Mo7zZu/2akCuoeDle8b8P1eiHYQix1Sv3zbLiYipQnTm4HS3V/7EHdmCV+0RSLdOV2BjTzB6l1Ks1CGCBF22sXFQIcx+rseCN69dX/ZWoBlgqcziEhoIGkhbPCF1TpXWXjbye41j857Xym+Dr9iv0k5WK7DPDR9zPeB1Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483978; c=relaxed/simple;
	bh=eWztvxdONO5C0YnUwjHAtCBXSvg/3GUmoOMiZuaZgng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYb2xaEem6k5/MQMOBepK/5cJyxWHN+24jJlTJTLwrW6pqvDNxIo4DLCU11T4Nd/EZIisf18gk/065JntGgnmiWrQ5JUqqnbMv9tI/44+bGnHGe4NcPtuMp9i2go4QlMIOo/4NpxQHMSwjv/vVhlBJO3U+pbCq+eXe0a7BFT3go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MbOB6Zqs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qhvqBP7t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FXQk9030944;
	Mon, 9 Jun 2025 15:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=c1X/8gTCtxEedIiF9f
	5I+QD4/yp7NHqBVBjE7Dd8Rsk=; b=MbOB6ZqseJCeGU2n1q5kimGIXv8hUBrJET
	y5lUgVvakYRutWbovSuoLHp7ns8QhSPoqjJMwq+IB5Z68gtMRlwhKlbO3iZApThY
	aC+ngH1XkUk2B+npxGCXvRxXII0AfM05tuJ+BqMIwvd0G+55Xd4QDjDjF/JDoVFt
	zYYHBBjTILvvDOj7Zd3/rOicAVcgODjWd5Xk+qAcIAOMq/rtAu/BA7w/RMDIvkMf
	0/5y+fptXezBm85I4LFQ+X2qpoM7KUjmf0EC+1BAO7rlriqFCet7UlqHJiyd/RyZ
	azUIW+juQmG0paqPfe+8oKrKr0dtwHaIK20Ji60YwJenqTFNj5fg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v2ed2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 15:46:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559E8jxx007717;
	Mon, 9 Jun 2025 15:46:00 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7bqup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 15:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peffo9zRyQuc5FRY7lrMfp8oVjZ/7hN6jnyFzUOd6QIrHDANOOHCNNmmNgZdigkc5rwu7u8ax8G72czhLYIEt58j6XDaexxpqwZHVGfKii6FM8Ot9KFimoTbA0OyTESK/A2+kSl1FTY5mNYqLa9s8Q0F2oMy33AavwWXuuAyoOfUKdrXhonLBquqbeIwqmVKjagGJgDfZX4rpmBGpHXe0oYQXDiiB9cgCcL6EuqAR744cFrZPAGTKfGM3pmFgoa9SbNf+LMfm8VGv3AwGz9yDcWUy+ttlBbzv1sUD5pjoGWWB3WnothxxrBQQ0wme42vKtIGPOe2CtxDkE4/RPazfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1X/8gTCtxEedIiF9f5I+QD4/yp7NHqBVBjE7Dd8Rsk=;
 b=CeJaKgJ5DQWvcj78x+PYt77G2q3RNAE27R6nkSezdEaIv4IgYyAH5qkjOiP5rwD6lSEqVapMaTggdmgOjmKQ7oZAwVMrEB1pSZNbEW9/k+EIIG/e9Lr8v1uh8W8UZrpBoDVT5Y9ZocLeQaX9SFrlWH8M6SIXyX/dmxB21O14w6OlWBy9zOEWj5rFThOwi5CicZ5It/JfOUHdA5wRBi7vrt8s2rHQ67BZanPSaeVfA3CDHuP7s3T/M93EBUw/KCM77HBi28HorVFx74kOGbLeZmW++S6kLoOE5FM79fB9ItUnPUrA5VBAHtSTBW/1K0B+MNxa1GJFUH62VdOyPBUCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1X/8gTCtxEedIiF9f5I+QD4/yp7NHqBVBjE7Dd8Rsk=;
 b=qhvqBP7tbA8NoikTGsudlkpTv81w8WO69V6nAt1g76AUG2uZY2nbGrOPyfmEtV/9ZyK+79nOu6iWILuzRZ1q1yFXAVT+HQ/d0YfPK38F/2PxywCfa8Qv4XmEV5VLKMoUFllXYfzldMebz7ktV046oEWuS+6x1G0zFGqRLDavNRY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 15:45:56 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:45:56 +0000
Date: Mon, 9 Jun 2025 16:45:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <a54bea89-cad6-4d9a-af5c-f2a6b42640cb@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
 <202506092301.jUMzAZW1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506092301.jUMzAZW1-lkp@intel.com>
X-ClientProxiedBy: LO2P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a97fd9d-b953-4b34-72c7-08dda76cb925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Macc2vsjpzVVPTb7yOCMTG0N6adN4a2nK1Wk+o3mvjENfE60E6+dCiTxJwN6?=
 =?us-ascii?Q?cI6GJNm37tjrJ8YTkx+GRwI35BeqwM7za78p4u0kHUzdmNqBVjFPQbB6rf3U?=
 =?us-ascii?Q?wg5M2KpKa26nt9VEEWWoSrV3iFiu3JoGV/07ua8t8axOeT2BzaysziPKkVly?=
 =?us-ascii?Q?juu8DcoBrmDKISoKhAl3bgtW1LRDQCJy2Rf6mWskfUxNuV2L3OquKBi4rlwT?=
 =?us-ascii?Q?cJ2MJMxIAJ+D1jWa7y/eIkJcw7E60ii/lWpoxoS33clNMnPhlOP9GibBxZTK?=
 =?us-ascii?Q?kaJ0hrYDPXzI1vW7npXdSukBA2txVUJIE42W00rrRuVtL+7QavWgAzLzm3UF?=
 =?us-ascii?Q?jnVSJDvCa4pN2fgxxrBun78jz952b60hnWRWurggKiSOto9XxD8Ww2972ThU?=
 =?us-ascii?Q?N5eClJfOGokR1ZJzYatShC/oqrPG9NkY2087vjv6RAT9Q/tIsSupnHZzl+dI?=
 =?us-ascii?Q?KTOjhMdmnRNwde5SXMEKNgesfmAMoUBUHWjskr1O35WrfpzNNSTR+0HzTSwl?=
 =?us-ascii?Q?i2RM+nwy07HeL8/8b8pJaPac9h8O8VhjAJXa01cY0cRkmnLtj+QCrOU+qpRy?=
 =?us-ascii?Q?yeUP4jtv1I1CsFpAzK5G2kUokI7HcjjU/0OWeEk9ZHxqk2t2dSA8BZw8tGPt?=
 =?us-ascii?Q?OD7NUtELmMxQcs51rC3tcvSdrNn9NMR7JbyPmUvBujhqdyaPq1GMDrFRfN/V?=
 =?us-ascii?Q?MiqL1OYF/KPZXQuZqGHHWfR5r6TTNPaSHGW2ECOPWj10+gmVbvvIInAfmUyG?=
 =?us-ascii?Q?ZXDqVsLzWCYnU1aNepTdNv2A2kEsyYzxF4T3FaWnouA8vLZlt/SEq9bAKwDU?=
 =?us-ascii?Q?nk8nE4k3O3DHyadLAQFUa8ME1W/inw2hIFaBHl+K0GO/oG1JnN+GWOMMqf3S?=
 =?us-ascii?Q?NeWeuqcqwv477fF0bIYnSV+BWbEj0yRnwCDFWGztYW6VO1lHnCGmgHW/pRpp?=
 =?us-ascii?Q?A2nKWBbWf2UBOn8+kqmrttixp4EpXoPGXjeKded/rdgtLzTnN7tkMfHx0L0r?=
 =?us-ascii?Q?Y3hzlYgKrznR4mOS5SC1Jc0B5zCEHerD1CasFzT9eD48huSYvEOp0lDNh6GB?=
 =?us-ascii?Q?0MVCPlEkFeGwH2v3aWGYVMQGNVHWaM16K0Y/bv5ti9jDmrjtyBMTCVEw6r5e?=
 =?us-ascii?Q?77URzZDDIEYlUI0c6XfCiEUt3lYpIwwqlgjz1XkUvPdhxr2Y8x2wMeSdBrQo?=
 =?us-ascii?Q?Q2kfCu9eo27GaXHKsZyLP/9Qgv/vZqcsveWIsFYBnt7KX+L5JnjsmRDzFt6A?=
 =?us-ascii?Q?92iUWa7zjz7/KHAmHtzjSrdoUICkRIHmAVDD1m2xCPQ3lT3Zk8+G9BXo6q1e?=
 =?us-ascii?Q?iTsVYK62HR1nz9IR6unC5r/DZFxgmEQkA6n8pN6ELT9UVYQk8MjujDzAkKvU?=
 =?us-ascii?Q?M4zMcJMNIJDPGdXESqBime9O/4e5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RUIIWUY8ku3pRII3UAXKnJTcH9L41fQ8A9qwy2Qj+Bcw+eCcM+NzRSmH6LJ7?=
 =?us-ascii?Q?PAyRYLs49VPWjG976Cmh2V2hlvTJ2MRAmm8l2WwAsdFegWyZ3HHxao7Z0SRZ?=
 =?us-ascii?Q?Sz8aUfWUmo6x47SzARhkFckxSgbCWW02XWSHg7gm+Ux9yLhajxdLa2zZuw8v?=
 =?us-ascii?Q?2RBt7lrMhNUn/r5bJOyXIAjpVZ/pVbhT1y3P2sTT8ZGSkSyjo5CA0siltfn3?=
 =?us-ascii?Q?EqzDsEcg+vwerEiPfbNNHf/vhfYvFkKiDsecpGL2mA0+f90ihTTubPe/Amlb?=
 =?us-ascii?Q?v6v8z0apSCd85hMSAtGHLRgdwIlsVjw79rTh2A7qquDvW3HTRHySPB4HxHCk?=
 =?us-ascii?Q?2sEew/EPV1Rtt1CaLdcQh1nzjHdbb3aeB+Zqx8R8CNN2cyZ+UMwGiopML/dj?=
 =?us-ascii?Q?iFtHVg/fj+CwBOYsL+gULhTzozz7hx+6BVzisrtZ5P9SVrCa0H2X6TPrbSIc?=
 =?us-ascii?Q?adLitw+clmMzh2UD4o/LOn1yJ3XnMwtIYEdbIl8YwgxR8k7qJPtCrlEae2xS?=
 =?us-ascii?Q?JAJD6BVJF+PvLjqyUbj6jGlJoDT6+2V4Tsj59sG5Qkv+qGwpHeM047K3rnVg?=
 =?us-ascii?Q?skGTvfMI+setKobwmVZd2SncicvJ9Zc9TTxrIfud+nek6X2Y6R0uQBbn3rPV?=
 =?us-ascii?Q?6LC5y+mG2UYSPwV0ENi+IVcOUcjHC2tm+pLhTCuEx1Phz+VJQztfDAXl36NP?=
 =?us-ascii?Q?mgE0MJxqEowoYogoWsKg4tvmQDWLTDrQIu52JaLdHH3XNw2jfncEj7hgaVNP?=
 =?us-ascii?Q?bsUPZSSfrPq5uGoazl3gvFWWwoqBjmIlEFbNhPkgJWF4+RHlb8ZJtTILaQGn?=
 =?us-ascii?Q?dtAQuupUNXYS++1CSwY9cOo8HkzY3rlHw0jbFxgefhgJcNQDVY6VC16qUNxM?=
 =?us-ascii?Q?7vApOGJFHIm820r7z1im20xaPX4LZneg4fVb4LaVtDLpw6zSBzXk++8/TbD+?=
 =?us-ascii?Q?bSaMs2Jeit0tL3Eo0mLW/pTnfjEUNxmv7SlKVyqbea2x/WnUeppl7Fym5ncP?=
 =?us-ascii?Q?A7ScSNMVuvwxQilzPDI+/4eg150idtOaP0nYa/koLM/KyfU5wTyngcaLmYLj?=
 =?us-ascii?Q?SSOEWaVJdbR6KtOv6Tq7tfL3rdSYxyXKo5WR0CzFOHe9hySc9fBGjLlM6V5W?=
 =?us-ascii?Q?C2s+NubpSdrcVIgVLztPweHHxQpPLri73EodLM2aeW66rSrpxIyVOd5TgreH?=
 =?us-ascii?Q?r78s6O9STHknDbZBPjBNjIBu49KgHvUYgd9Cm6cKWUzVwfGednyCJS4gSz/z?=
 =?us-ascii?Q?NuwFD/oYKjBa9h7ZETAlvM06AT5nr04vUzXEj0FA+6wvvZG4au0QZz7+vDxL?=
 =?us-ascii?Q?WvozVR/zWhYd4ProEzozYRtRafCeZCwk0cS9wAq6C0La8na+B5HFiY+qlSxz?=
 =?us-ascii?Q?ytb3TtDVStS+8UNRk/l00CpLOOETKtdDQybjUjdTk3+kgUIUwYPXSxFweykT?=
 =?us-ascii?Q?fi1+jbdlfxp9zsL0iduQXfRpWxwSyi/h7ckb1v4G+Zf+zEvEAnn6XtP2nD3m?=
 =?us-ascii?Q?QNEvF+OZCW6GbA2VuG9rAxcmtvb1xERcvOyb3NNL1c9WYHdstoMKOvHWDizC?=
 =?us-ascii?Q?2Kcg75WtMjRyleH/TKwsSJqEDEEpmnmq5M+qVKyxy7157YEeQbBDnbb9bftL?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EF4pG4cStNVIezLl7xjnDAmC7dITDwsaIfWATsuB+GZhBYVz9DC9vbiQvMWmKWrLZvvbbgpH4PZRiLnesugRkTDwKONrsACXM91tNru7lnJbR2CFw6vHEG/1f7d5f5FIy3vHPz3FpqBJPozyUF+be/yEVUTIsavn5bvGgqO2iA8MGMop09YaMIg3bf9WvyFxlZAWaVQAZb5jnvH0hXit7LCqPQtJjSNo9W00TcdTIZI/7B9fz5lifKpkKUPyoEZZcMYGQ5D/8neYJB8/YVa2OT1/AOiZsfBio4TICQqHIhPmLQujWb0jFueufx7T2cmMIE3qSSt1AbBtf/hvzLRi2KXvTon73IW1VjLjL5Tyd+MO95CPsitTLft22ulx9BJ7ELWRKuz89QkjSHUxMuUijHR/nYB6TAsXMxKSHQ+utfnNcyuIqYiyYsEm9v1neLIdKvOZ29lVQErB5tqWlDPKbbVlVJLj7JN1xjGXi57D7C0Rp0cb7ArSdJ/4TuSGyNHSCXPeETHN77z+DgUQAuRPom1H0KQ0tpuS7LpF7rE8TO6I+ECmi3DsGNZf1F8ZAf+/XwhiJcsT/Ui3qEVnXu+FQQdjA6e9X4X5aoYI/VhYTpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a97fd9d-b953-4b34-72c7-08dda76cb925
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:45:56.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAGp4moSg1yzEwYT4PTrN7zU39aHyXbSgEnZAe2IJCIMtEu8XH6I0BI80N09/Gh+j1C+QECPx0+hjsC1H1rjJY0mxkH/UkGBxHrppBGyb0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090116
X-Proofpoint-GUID: SGDovp1lwG9rRp99JvkhdLI9bNC9ePYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfX6lb+LTfqRPy2 aArAwlLA1ejugQHdy/s4NcTVZZzK02DaRfsPkfsJCNIu4hqVbjZ/AhzgwQR7r0DzJmjX/SPTmXm /YdWJnviI7ufF9PWPQz5eNVaueVwm2GAxQi86GyN59Rh+eOKSp0FEB+gQWvDvs2W6sH07cPJe+R
 cX6X6mSZ2DOIg3a4IzP/NYkeTzyzoE+fNWRGBsVyRXngBGZsR2TKAEP6ihX9gNMaqJVo8ZnzoA9 dFDtmJ+vQhRKyE3CaoWDLsOLrRy6yhdEWfDEIdEnnRhfzSm/K1Dg6SRS7rxofItYBj5wYh3gWjZ xVl0yfGExyhSnGYaCKjGaWuBV00/PmI9gk6vclMZOV09MyTo0m35/viHUHMZXOdgOfBjpVthsER
 VwvH84R5ZShV8bTqJZwCWyFD/+KKK+n4HpZ15ugBoRZJUcicvue/VC5nQcRkUesTlnpO6XHI
X-Proofpoint-ORIG-GUID: SGDovp1lwG9rRp99JvkhdLI9bNC9ePYY
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684701b9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=xM2VzbmPY0w-3v3zW-8A:9 a=CjuIK1q_8ugA:10
 a=mmqRlSCDY2ywfjPLJ4af:22

On Mon, Jun 09, 2025 at 11:40:25PM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-add-mmap_prepare-compatibility-layer-for-nested-file-systems/20250609-172628
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250609092413.45435-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] mm: add mmap_prepare() compatibility layer for nested file systems
> config: arc-randconfig-002-20250609 (https://download.01.org/0day-ci/archive/20250609/202506092301.jUMzAZW1-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250609/202506092301.jUMzAZW1-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506092301.jUMzAZW1-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Warning: mm/mmap.c:1921 function parameter 'vma' not described in 'compat_vma_mmap_prepare'
>

Thanks, this is due to a silly typo, I put ';' when I meant to say ':' :)

I asked Andrew to fix it in https://lore.kernel.org/linux-mm/dddd402f-1705-41a2-8806-543d0bfff5bc@lucifer.local/

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


Cheers, Lorenzo

