Return-Path: <linux-fsdevel+bounces-22969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D99245AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E219B243C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F71BE22B;
	Tue,  2 Jul 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEW9a9pU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ECKAL/RC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9515218A;
	Tue,  2 Jul 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941122; cv=fail; b=orOSS5wGbcbcjpPETo95RBh1TVgUBHfGKIKGwiKMwxd0wDbFcIj+RePq34x4zKGgfjDtrKXzgO0SPe0fVGpPnV86fzSAk8oOsUhvL++z2r8R4HopPNmJ6Ifj3XokAsj03d5/41+yau5S2uPTDPLK1hCvb3jijuxZL6RQ6cl28Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941122; c=relaxed/simple;
	bh=p/L+WBT/aIB3GNidMgJrTZMHm8hIArQ0p1nEFNhE+l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gP5IehLv26kje/KkinBqoXUZnR0W70xoTUSzFeReFpLzjyRaEeM49Eull+KxxmOR0BFrBv1zf6nssKM+Xo1B2BpGVR78Bv7MMzgck/pS1h4ukRSJ/uAfDEFzGpV53z2o1k4x4MtTymC/aX7zs9jJeuC+cflgKvmT94GuMiLIMDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UEW9a9pU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ECKAL/RC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462GtVnv009153;
	Tue, 2 Jul 2024 17:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=JZUZXYq5D1aAmj8
	LFN7i78en8L3vB4uRjUnUT8QmSgY=; b=UEW9a9pUlIJ2Q5bhg5A9caF1ioXjQUA
	9TeA6WCwLqbG7y3Y8or3e0TX9MNNLw9XqzZ8PFZaUndS06RZajsNWavZfHF4/DJm
	NGKaTqEVxM+OTTYovTjRvjSLiqvkgHbsyEC+sL15LYmUKN0nrbWO1jfcDjY3fH/t
	HOTYDEgd9DMaeIjoxvL9LehWpeovywiKRrjDdW7EpV1E9benxmCv19h6BzZdCkQa
	3XkN1Rkr+/Wpt5YdohxYBJL352LBqb2rqZJoh40ftShmV56CKJ46333HsaL7KliK
	dFSZoEICzlYH2liZ59+aT524PgjxgYbj9BO/uOmvBMbd96WdWbJF65Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vspb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 17:24:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462GONt9010211;
	Tue, 2 Jul 2024 17:24:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qefuvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 17:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTXq/pImYv9EyKqhIEF+A9vIK1FVUPNKgMDKPfz8z8JhNhpMIuLPPJxZyTery83PmQI+wcsS7Y2sDzYE1aLvYtrn4gVOQnp4SDLX8+Wpp8iMLZsBmvAT8177rFoNKHXhQNUzCTmLchdk0H2twBKVF4j2OjCla8amM7Kng2hxP73k6iNGMKijJvdNmQlfr4AJtROLR9ukKtqyh1mBEknwDABQ1jCdVmFrY4EO787/Cwvic2jo/Woo+Sqh0TEZDUAfiFkVqALiTjumaTqRD2bvymSygWlx2pFlybEqY1gK4YYL6znNTAhq7V9EkzWLPTNYqC4F0hIgVcUjA1+4FbcJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZUZXYq5D1aAmj8LFN7i78en8L3vB4uRjUnUT8QmSgY=;
 b=efIsZ3xDiSw7J/d0iGMYuSIG+LYlLwKdLRYM4QqdI4pbT3qFdHVq8NBs4zio2MBIgeI6mfXrLWZRdgqh1J+YQ4Z7FYSKxa2waQeByU2rMFebPL+DXen2GMqrVToZ+3X2WJKeP1rOquOO81meAaiXV7Ryo51CbEBaCd6LE2QqjclIX3fbg71ZFf2pKqamFMEG2paUMIOB4Hn7RYv7QFiJxQP1lMJwjtHVVrrQNdoFkzFDN51V2ngHNc3y32DRSqa5aslSMgvB0hyHA1+QcA8fMVIv/3RqZFaWtxK5MWtbgBWwwNKiWG3f165mPK9ft+7TiQnEaqKLamWOSXGz85Rh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZUZXYq5D1aAmj8LFN7i78en8L3vB4uRjUnUT8QmSgY=;
 b=ECKAL/RCP15Fd2PhckWI+2c31mROVwh0dMcAGUPgnXx1bhwniR4teUwavHvtqZZFiNBO+JA4ocBg9ccEdiT/2k1TjJ4/RDpqcitb0nWUvL5VixdTLM+xg2YmERwqNE2orYf0T0+T8X59Qelw5DoMkib83jQkN6FvCC63I4m70kk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB6167.namprd10.prod.outlook.com (2603:10b6:930:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 17:24:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 17:24:39 +0000
Date: Tue, 2 Jul 2024 13:24:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 3/7] mm: move vma_shrink(), vma_expand() to
 internal header
Message-ID: <lm2brkhp7jfqgfazr5dlz2pxvz7k4fhpfie2gddkcijwmqf3j5@rqoy7efjnpvb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
 <b092522043d0f676151350e65be57b5bb5c8d72c.1719584707.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b092522043d0f676151350e65be57b5bb5c8d72c.1719584707.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac298ba-1d6f-4835-fae2-08dc9abbda2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YAeLQf/s6joqTomeDv0PDLF29iKrhzFriu4494ABErRz4/qrQGrEIdJzb8Us?=
 =?us-ascii?Q?5tl00EkbyK2BDSG/AAe7seZmsRBwQHBJhf5u7UKxfoNQAlqRPsjRZ7hXMRLw?=
 =?us-ascii?Q?e8bflOhO4XS/PLXIrFCGdlfC25A0JwrZoAfJojlEuaDO7GjaHrMW8tdU+Ijo?=
 =?us-ascii?Q?Zs7rs2qxmX2nLpm/1oAm75UtiAYI+BlX87iMuIoBs4wl6KfsxcMoIX486jrs?=
 =?us-ascii?Q?iCH8sMva60W0/MJw749SAGRXAkaNP4lKWJI/AlbYwCmVYh44NsQF0QcVNMC3?=
 =?us-ascii?Q?rzo1+oqLM2HPgniaP0JP5gCE9sIMdJj4l2aUbcFX51vvOwXWyUzz+fXtRTxu?=
 =?us-ascii?Q?F1GQ21hjNgvS2u8cszWxTc3CHXW87GaID26a6MRdihLg+tA2qMuEuxKgI0x9?=
 =?us-ascii?Q?1SQaL01Jb19pccFCA8x6kmr5WlroVn2JjeafsrYZ2OB1PzhfY940Bo5ewtAB?=
 =?us-ascii?Q?NqYqRPgf20rumOvbq0VQeLIcSQB5kb9SDHC7ugPVXDstfvx8lR7lq49YcOVS?=
 =?us-ascii?Q?nFiNs4yisI2ixlYCf9C07Se5QYlZZy1sFGSAJZjWZ1HgdAAi0lbFAZOe4VkQ?=
 =?us-ascii?Q?5S9Oriccypx0zJKGWp6lgqLYzzOAmtYgsRFYfGqdR5GYC0IPvInWj+3H48XP?=
 =?us-ascii?Q?bYh0EdM2YX70q2KTKzEOD5rXXKG6hO/BOZvN529+h1gCM49eFPxBEakdMZRF?=
 =?us-ascii?Q?BRdCYAskMYaEpWwhLtCE/fAVZbVbJILUVUuO0o9+SbMjIDx+fdltsOO4L9TW?=
 =?us-ascii?Q?I23c4z21mN0ci4Sscmxg2NCXfXSxZ6Ejb2Z9T7GCSeyxJBHE1kz2los4bNTy?=
 =?us-ascii?Q?YozTIMe8bSoWxk2Kjf+qlzv6oEdeGZQeMPv79vfhvzVI4Xtcw3WXhj3YmoYM?=
 =?us-ascii?Q?P5IwY9BZ1taFSp1p7PRG5vCwlR+hdhGpWzIqT6mFM5mu+KA7EKXnvyBW8RCI?=
 =?us-ascii?Q?WMmpQTNmo4X68amO4Ko2z5Bz+kDJtamojM2fQE3SU+KdTnIxaSoOpS96Vp0X?=
 =?us-ascii?Q?F8mct9vJvXh4R+A4j28Dw/IvSXLSdANOG67sMdxx/oZicjv+6hZHJK5Ni7Kq?=
 =?us-ascii?Q?cqERmCMQATtdVO39lrMN+6fTFWuqU+xNElgz3Utwlwm71nqC3pijPzzVHu31?=
 =?us-ascii?Q?jsmqAK/yQ6zTw6hdGdq2nO6wFE8WTpkj6RGadhltTjLHTLiFrgXBtdPJgNgM?=
 =?us-ascii?Q?GkzrkG+5O/cMnTiC40P+7YXdLp5IxxFd/B/zz8c1ChupETIODMONQ0gWysT2?=
 =?us-ascii?Q?yZIk/ECEGq/kctY88ckHVGSBdnjokFUDs5r/hvEgb9DzO/FiRMGNrBj52Ugb?=
 =?us-ascii?Q?4RrPpx0jprxlV+XOGcFzxy62NTbJWnOvdpreycXRUQfETA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b8rwdiPnFNQxqREuHcMmOAjPHlr4g/XbbD3DGlI70Xjc95Ul90LZgUQgFW48?=
 =?us-ascii?Q?rhqGtP6p/EwLoPl9nuf4L62UioK1pFqB+SAZzlQoyje0OnIItcahu8Cyinyp?=
 =?us-ascii?Q?vTPoO9UkRmZZ0gNX8EgicxXOIVrKO1MBiAWfQ85hRqcG56+59ya1R+qcLQ//?=
 =?us-ascii?Q?i+re9YozAbQ1LjCoxpaGf9Jjy2FMfqh2gKrsdnjUgVb2fOERHX9+Wf98fgU1?=
 =?us-ascii?Q?Pjq7RuGmjvkJ7NyDS6P54yYLxhy91tKm0ossszE7hWs1c7VzV8EHgZt9EIQX?=
 =?us-ascii?Q?yWRGUbDiGdVUcLYpY/vqJdOK6ESLWo8vPVhvvypPj8ewiklh1MFd9f6zTl26?=
 =?us-ascii?Q?Mf0jVVjb9HcJkwZMpVtFsR017SI5S0MClCIZiFRKiPxGvFtF9XfKkIgYDuvW?=
 =?us-ascii?Q?I8UoJ7EjMIjysk8/AbWmLZ5FxmOwye6hEAR8DUsi36ewgwdcGiICMGRITkxW?=
 =?us-ascii?Q?jte7p7lCMPdRgx8Xor1CL6ZZePVWEJa7JnFqg64okD2dwqTlHRWNTkpIXifE?=
 =?us-ascii?Q?RyD0x8mZhKkJo6q7zcEmt1TsBfLItDsMIc5rBMa1EqOrip/oTWWnHAnHWtRI?=
 =?us-ascii?Q?9qPnMLA8uBLrlohoavcbGwkpIOuSiQxv+gkxf+QnpCvBvzoI8iUti4ZFRhZg?=
 =?us-ascii?Q?G14fsY4Cmlh7ael7PzmVUcjfO7uEdIbJXgIaoFchTbujaDy4P8/DHjc8lMXb?=
 =?us-ascii?Q?WtKygOvQTGFF4fx0HM/NUcJa+E4Tfe9b4kwwhr0Gs0etvGcZTVdYp94l7ozf?=
 =?us-ascii?Q?629snlcVTDhfmG2S8HHUDfBV1k96TDotW5LPbp3E3sbW8SDrq5papKzbv9DU?=
 =?us-ascii?Q?0/vvBxCqEp33eU3v8ox6JyYNsZWYXqDAtgHJHa38tkFsIiO7LVFnyx6heG/n?=
 =?us-ascii?Q?u61uqB3jRiIc246J/dBEUDpF/8s0M8S8odqAcETVveomum4+D2c0t8fJlIgh?=
 =?us-ascii?Q?ov43L7rIVj8WOMG0AROJR0xi9ZUPeEganWklz9R0RW2IhsrwvzLR5TTwMHfc?=
 =?us-ascii?Q?eAn0gDvaAj69Oe+mpiq/KZoIkOPTtxTEZgi9O448yChJtXtosWCwxjK3iTy/?=
 =?us-ascii?Q?6Ipekk4f7BYpwnSfV2O18UOoPnR/T1mhQcXh3AKy6R+u8Oiy7LRHS69cnkg/?=
 =?us-ascii?Q?1S8FOI4HTHOYxVQzRb+Y9vlmMyoKTom4dXlHRhbvzgBiHXYAx2DCLRAHpm2x?=
 =?us-ascii?Q?0veQVQu9ML8Cawjxt4FpCCTfwAqhK643s+0joEHbHujwMtqZeGuaegi8YMRw?=
 =?us-ascii?Q?CttilO9jPbYaAAF38Z6j9VNiZupZ7JUguA7L4dgh1XWHqpLZnyZUd5McT7X+?=
 =?us-ascii?Q?UQZeP2/MZh4Yl+nW6kZL2CwFI6YpnRwPgeUXNFj6hEjl+UpOShSUXW8SEeMS?=
 =?us-ascii?Q?gu+PCbsiXv3dUnYeFaBn8eWkyWzYF025R02v+ICS/QBC5h4lbj6os5WEWWLC?=
 =?us-ascii?Q?1G3R18qbumN3TZaesFlV9hSkrrxuCzVrh88df3cw5w1S0jCriff/aU7FcPg2?=
 =?us-ascii?Q?RVVNafbCOajfEgTC4QR4+l1y6inKpi6dsasOhnHUo1b12/OawFVFoByOmeTV?=
 =?us-ascii?Q?OcOiokgysdd/8KfY+XISpc7n1eDaJt3EzEPPYZ5x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SIGyLrbDH/mrGpWwO5ilhmZLHxyw0EP6AQdClZE8nIuTKnHDfH09163H1N4Z0okQ9O40F5/ZshKGorXa3yRyrsr7D+GpFkKovdXlmtSo/0QdR8J7YGBGCT3B+0WDyag9egQPNBJ5bbSbrw2CnOQZMjjSNAKIP7uzDJyd+4ngfgGcBZ+ErPME0NLAYWLoAUOTnm7XPOTCdBUwb6qox6V5CuwUd30kW1V7Cd7U+7j0UkdERtNGyux1xoezrr//2RIjOxy/PiNyepsi6+fWvuWfpzoBSZQN87ViUxtJTF+EoE/VaJC1j0GTh8C+/DN9A0TYBEfYlUKdt3xO1amY69NNLwfY9kBHrbV9anZmI818bdi9R2kZ+itBfExIN+j65Y7i4fNNGND+C2LezmStyNRktRXmazz305hFiuOMZL+6uuAYSuOycNEk7XzrqbHFE1Wg4Z60dDZZD7hvIHxq6N8FXZjBR3nW1NAVudpVuyvIbDspWIf6MhoKgIfVRJzuiVHEEielH+cLNwkYRYDURjlHR2ox1KO8bdtqLCgDTBK7MNnFm40CBNR03cpPbR943TmjqIR1v5Bbb7ZnrmO5kiZJWz7ad2EIxLlYSlI6fdpnUPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac298ba-1d6f-4835-fae2-08dc9abbda2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:24:39.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAXSbw2AlntaTCgFwyjnI7Bg8trvL2IDOrgV68vWK3vOSxwk8ejrBvVRzRXxYcKs/p/2cirZpSJPBkW0WyfLQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_12,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020128
X-Proofpoint-GUID: BEw3_Xac6ycYw7oS9e5HcR8P8MCfQcD9
X-Proofpoint-ORIG-GUID: BEw3_Xac6ycYw7oS9e5HcR8P8MCfQcD9

* Lorenzo Stoakes <lstoakes@gmail.com> [240628 10:35]:
> The vma_shrink() and vma_expand() functions are internal VMA manipulation
> functions which we ought to abstract for use outside of memory management
> code.
> 
> To achieve this, we abstract the operation performed in fs/exec.c by
> shift_arg_pages() into a new relocate_vma() function implemented in
> mm/mmap.c, which enables us to also move move_page_tables() and
> vma_iter_prev_range() to internal.h.
> 
> The purpose of doing this is to isolate key VMA manipulation functions in
> order that we can both abstract them and later render them easily testable.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/exec.c          | 68 ++------------------------------------
>  include/linux/mm.h | 17 +---------
>  mm/internal.h      | 18 +++++++++++
>  mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 82 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..5cf53e20d8df 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -683,75 +683,11 @@ static int copy_strings_kernel(int argc, const char *const *argv,
>  /*
>   * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
>   * the binfmt code determines where the new stack should reside, we shift it to
> - * its final location.  The process proceeds as follows:
> - *
> - * 1) Use shift to calculate the new vma endpoints.
> - * 2) Extend vma to cover both the old and new ranges.  This ensures the
> - *    arguments passed to subsequent functions are consistent.
> - * 3) Move vma's page tables to the new range.
> - * 4) Free up any cleared pgd range.
> - * 5) Shrink the vma to cover only the new range.
> + * its final location.
>   */
>  static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long old_start = vma->vm_start;
> -	unsigned long old_end = vma->vm_end;
> -	unsigned long length = old_end - old_start;
> -	unsigned long new_start = old_start - shift;
> -	unsigned long new_end = old_end - shift;
> -	VMA_ITERATOR(vmi, mm, new_start);
> -	struct vm_area_struct *next;
> -	struct mmu_gather tlb;
> -
> -	BUG_ON(new_start > new_end);
> -
> -	/*
> -	 * ensure there are no vmas between where we want to go
> -	 * and where we are
> -	 */
> -	if (vma != vma_next(&vmi))
> -		return -EFAULT;
> -
> -	vma_iter_prev_range(&vmi);
> -	/*
> -	 * cover the whole range: [new_start, old_end)
> -	 */
> -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> -		return -ENOMEM;
> -
> -	/*
> -	 * move the page tables downwards, on failure we rely on
> -	 * process cleanup to remove whatever mess we made.
> -	 */
> -	if (length != move_page_tables(vma, old_start,
> -				       vma, new_start, length, false, true))
> -		return -ENOMEM;
> -
> -	lru_add_drain();
> -	tlb_gather_mmu(&tlb, mm);
> -	next = vma_next(&vmi);
> -	if (new_end > old_start) {
> -		/*
> -		 * when the old and new regions overlap clear from new_end.
> -		 */
> -		free_pgd_range(&tlb, new_end, old_end, new_end,
> -			next ? next->vm_start : USER_PGTABLES_CEILING);
> -	} else {
> -		/*
> -		 * otherwise, clean from old_start; this is done to not touch
> -		 * the address space in [new_end, old_start) some architectures
> -		 * have constraints on va-space that make this illegal (IA64) -
> -		 * for the others its just a little faster.
> -		 */
> -		free_pgd_range(&tlb, old_start, old_end, new_end,
> -			next ? next->vm_start : USER_PGTABLES_CEILING);
> -	}
> -	tlb_finish_mmu(&tlb);
> -
> -	vma_prev(&vmi);
> -	/* Shrink the vma to just the new range */
> -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> +	return relocate_vma(vma, shift);
>  }

The end result is a function that simply returns the results of your new
function.  shift_arg_pages() is used once and mentioned in a single
comment in mm/mremap.c.  I wonder if it's worth just dropping the
function entirely and just replacing the call to shift_arg_pages() to
relocate_vma()?

I'm happy either way, the compiler should do the Right Thing(tm) the way
it is written.

...

> +
> +/*
> + * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> + * this VMA and its relocated range, which will now reside at [vma->vm_start -
> + * shift, vma->vm_end - shift).
> + *
> + * This function is almost certainly NOT what you want for anything other than
> + * early executable temporary stack relocation.
> + */
> +int relocate_vma(struct vm_area_struct *vma, unsigned long shift)

The name relocate_vma() implies it could be used in any direction, but
it can only shift downwards.  This is also true for the
shift_arg_pages() as well and at least the comments state which way
things are going, and that the vma is also moving.

It might be worth stating the pages are also being relocated in the
comment.

Again, I'm happy enough to keep it this way but I wanted to point it
out.

...

Thanks,
Liam

