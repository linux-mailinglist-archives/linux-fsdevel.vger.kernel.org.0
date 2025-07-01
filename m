Return-Path: <linux-fsdevel+bounces-53507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A6AEFA0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE74420A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8E274656;
	Tue,  1 Jul 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Erv242uZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eYcuTdJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A744246784;
	Tue,  1 Jul 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375880; cv=fail; b=UPhD01NyAkK7h0k1nSZjonYKhy6MoPVRQmQto+/9axW4n8l1gAJZlkehNoP+PwBFy/OHxbKQDUj3pKfvFdmoJCClhpXZbJJR8U8ijEnk7ccjzA9/GyYdZ+rb08CLKr66TBbIMP7/dal2x/uhRdRhvrL5llPj2VyMtHBoaTLOr0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375880; c=relaxed/simple;
	bh=ztrIhH9S+n/77cmjtzVUk+MjDS6m/ffvArZNojE4h+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Syr9FxlspafpQqM+fNixvMEWvPLXm/u4PeTA1ikPsyutDtLRqVupSi5qHfLbBIj0tpVYJek8UyGPs/7Ui4B4VXgC39WiLrJ+ex2qwP79u8kIdpGpFL+mHTqXwjOYZM+60WQEsg7RYfSj+dlz9OZonM4aCJkg1ZTfRzTVZjEAoJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Erv242uZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eYcuTdJF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9Exd030398;
	Tue, 1 Jul 2025 13:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YEEZDUXoPAy6o+C/IJ
	vL8b8mowv2oRhZRiZ4J6iDPeA=; b=Erv242uZD/CoB0SMN+8wt+fQ+05cjgtSIY
	ep2cHAqN9EJtxfg4c7jeDI8g2k3GYOQGIjfWkpG2+rpHJ86IB9e7/KUKHFfRpC1W
	NDtdNcdiuE003JfpXDTdvv1nSslPhZXeU5s6hj6zmbYBHi9jj5j4klowro+rklPC
	NlBsWxOr2q0WKOoNYorbq5j62ArRdFrA/Q7GmOodxne/AksCQ/crfbSnXnqKnf6z
	52BV5IBoJ5FxYJONQAA9UOefcKmxuQqn/o7HO9F7IzrGKylno7Lfe5lCNdfY1c3z
	ROLTSCL8gTmkAJdcJ4aqwvhX2fRkIRbEuBokK9tojl0OmF1D3hKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfcq5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:15:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561CgUrF005846;
	Tue, 1 Jul 2025 13:15:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uh0dm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V64lRovYFpgFJTK7BECOBdn+F5+KwvZtTpTqAcfKOUOHJA2xWjlaPTF55fERLxVXY9wU9s7nB27FqWHPZsoEbvv9bBiofwy+ycgG6XbxwSv07/uz440ouZcmpNJpvPH7yz/1akt1wx77MaZ8hQ3peIpVTNbCiWuQOmHJ32k/CQD8yCJ/O7OlxFdkg6KRJIoew/8X3TXgcrCA6XMPwNkAs5RjjqpndVE6uepRIqukSWpBw/+2cvy3MNxrMEqGm73O+iTnUhD7AJ1DNJcg2koF3V+hwiH1l3KR1++BfTqRNoAfa03+Uqs2bOYZ2G+MzAU6Eop+a0rz2fvYUIsL8ckFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEEZDUXoPAy6o+C/IJvL8b8mowv2oRhZRiZ4J6iDPeA=;
 b=JkzVsM9m3piKDe+YF2Q4EstdWUyy9W6L5yHo7sdlmyOAA3IJeR/3Chr5CpExiIscRBPE/zZlzbfdNSbA+x3nWkP1DKwF8ugMB23goLwbYlcZeQOvmoTf/xPYB2DJAIBkYzG7R4zYnuknGUxY+UUnGRzwgTnzbLKOwEAafxaOKftqAj5vMso8EmJmbRcg0OCsKqwjQdL/G12PogGMJocTmBvMHXMC4hkJUsKBSYSCAHVWSTskZeoUPvoFfVuouYapHhn3c7rPlYD2ZGXrQ8MOQFGtwfjEwaC+nJjl0CNhpap5oqcyqNasmlsBEBWEYYIqTdgGrQAaj5WVqZOwJ301Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEEZDUXoPAy6o+C/IJvL8b8mowv2oRhZRiZ4J6iDPeA=;
 b=eYcuTdJFEU9TaBF6aLPRwnAm/DlvMk5qUXvxyYkYE33/fRN48i3wPakqWBModN9+YMjiIwMed9FmfLb0vzkxpebZiAMfpjXxzH8WtJOxG91sbcRG92N5f0CjeSC5TRNoi4ifrwKIzbvxvcsj7jHMKYiArPPGMVxARg2cU+6l134=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6914.namprd10.prod.outlook.com (2603:10b6:208:432::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 13:15:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:15:02 +0000
Date: Tue, 1 Jul 2025 14:15:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 25/29] mm: simplify folio_expected_ref_count()
Message-ID: <cf100225-5c2f-42d7-80c2-418dcbeaa21c@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-26-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-26-david@redhat.com>
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 57065b5f-728f-49ba-7ad6-08ddb8a1499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5acJ1zwvHbx7PURInbAIKCGM8cH/NL9U+7uLJB5fdhgvDKI5rwgKJPT9Nyqa?=
 =?us-ascii?Q?DOb44AcGQvAZXlTm7Emd9NG7/kEckRI5jGxJ/ao295sOEJc0wy3+FEaloYQE?=
 =?us-ascii?Q?668TzudKr0rMzM9Xb38eap+Ld2iwpR+FTO45A0jtWPMXvFhJrKJnZkd904GV?=
 =?us-ascii?Q?nzmlqSl0RyZx1wwzMXNM8M+2D+NHF7iuanrlI+mqGpQ3edd2nVdYY0CnrXeX?=
 =?us-ascii?Q?LnlNYXc2D6tb2cISkxe2qQU8F9b8hMEF59CylDF4Sv1SbtJMV/A82IvTq6xA?=
 =?us-ascii?Q?XO7KR5pBFqovgz2ZrUU+yqjOIe854BoW0LzOZGLzgCnFpep9kFu70+Bt36qr?=
 =?us-ascii?Q?YgMZ80s9+RWSeWH7ZOsxXZsbnrI8yF3FFffNe6BeaE0VnH03r5e8L4uLkTz/?=
 =?us-ascii?Q?kY16b8x2TAuAxwU9+5b0a9dAZg7iIIIhtbVDgoH4FN7qzukh/iceqK0VZ3+h?=
 =?us-ascii?Q?aXwp6ZLixCppg6C6AsPwt2nx1IKV8NzxwofVNH7UbFxPIetCPSJxPj/WfeAw?=
 =?us-ascii?Q?F3CO3Yaoz3joCLWo1du4t+rNnrivmglHUUAf7lYaFvX6tt7pRcGTqbT/Svpb?=
 =?us-ascii?Q?X7mmtvjBQeydBOeF9SC7l3mNalU5BsIGsdfi8zmkVzQohCq4/EtH0YeX4Qt7?=
 =?us-ascii?Q?fPjOiRXMbEK0x6DOGez8afsxbkDqzRNRqw0fWL1quSkpPSqkb38zZ/1wn1km?=
 =?us-ascii?Q?rBT+srUPlUxS/EvzkbZa1eEtTw5aSEhvBexEpyl/7JaGC24Jmd3Drkk+PxUZ?=
 =?us-ascii?Q?Sm00poKvupF8IldIQ3WDMWR95l874jrsDK2jRP7FjCbyO+Cnepao9iqcrwqG?=
 =?us-ascii?Q?aXIb81NtpxQ+JVE+l0PCNPs5mm1f5t+PqoQvOXhh95QUWVUIKPKdWxXEjVHY?=
 =?us-ascii?Q?pRKgZjh29v0GwRkdve/6uroa1CGZ17WBOjuplv6nm58HRsZv8/LSkfFWjyO/?=
 =?us-ascii?Q?Z76oe5Q45aBhNWh5QJo5fafQv70NsP9zMp7ss2HwmCY7ZQ11FVn46NJLVIAB?=
 =?us-ascii?Q?93yfQItDjajXefc4iEDBiTFMAM4J4EhgFZS1ZZZpKVZCXf/bCqWGPv3UYtSc?=
 =?us-ascii?Q?Pf5TxmEzC7a1M5Dbu5AptsWs5R+TRMUpYEIY52R4VYybppGbKGyFXjFqe0Er?=
 =?us-ascii?Q?DIstO0QADnw2pxuxdcYzTXMkPPxwWZEOosd2UIAIZgGCN3KMbySoyvByyEKm?=
 =?us-ascii?Q?819+k5DLLK1KCouFvgUXWymRlT92WZtgPOGxMIIkfR+MCE4vY0PkB04Y8XZw?=
 =?us-ascii?Q?oIR6y/5gYQO0Z9IB/N30QHTUgYY9xXeJUZ8DdtLQhG5rPiYYbhscTZ8iRBjk?=
 =?us-ascii?Q?kQbAF/vrPGDJ3FRBONZvkmuzv3A4r87trhS4Tv/TjKVVBLov7kt21hygzve9?=
 =?us-ascii?Q?jdBNxoPG9NBT+owhx+fp4wL9lDnfsRb7WyhPc8/KmoQqH2kT1ls96KmqMpQt?=
 =?us-ascii?Q?s24bXAbulRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OSs/3qihIhrN9o2Nuz+Cna98hYdPGypmafbtHyGKUKzNahaA82yhiVjsSACX?=
 =?us-ascii?Q?djT3DhPTbXPtsdkNDLwBM8gFRjMcdkqEIa+DnSoTNLMmxNRtiyE6L5a3lzTk?=
 =?us-ascii?Q?ya8IZn3G98y1rkfdAuXY/e1Vo2OCj1YH/SbQd2cCORnxP70RAV/ghQ59wOoe?=
 =?us-ascii?Q?sUs5adu70XhvUUQdt/fZtl6IWlJ9h09GwChaHhgf85mUaIdBmihMbt36O0nM?=
 =?us-ascii?Q?i+Adpn8cJgaWwIriLeSvUgCKRSIPq7RX4pB+/I1lGrAjon/cN9Ikzx/KYSfy?=
 =?us-ascii?Q?vg6EVBtryD/o9c+vaxsLGp9t7pzx3pOkj50N4D+WGlbsr+IcV28Wvr2xkAna?=
 =?us-ascii?Q?ZTjVZEk2mSRtoNmSlDVaq+m/GETVWp4Ed0+gZvFE2n9CSx1+BcuGC5s7w5Hs?=
 =?us-ascii?Q?DB9bYL3Uh975JOiRLNjY6oqUorSjN3dClHX/yK1sw3WmBtExirlo2pD/YCeU?=
 =?us-ascii?Q?vt2Gv9HC1I+Fn4tlP4bIX7KuHHKgNyROICFwBpd9fsA4WBzbq/vnV679Ub2w?=
 =?us-ascii?Q?ZC7oZeOfyFxKSZ56CJAFckWwq7b5pD6gWnfbmg61HLUhU4gkrdYpgGc1lI94?=
 =?us-ascii?Q?WFtcTg6BEIancN6fgiR++jNVZLl8Y7sD8dVCJeFDTw/TYdGENIg3LFi35Q+V?=
 =?us-ascii?Q?tzY9FZG9+3Pts7J+Bn/TSey1Yy+3lfop7OSU1DlAmM8X6Vi61e0uZbGqmwiD?=
 =?us-ascii?Q?W7nY8ayWSr4b86k9jT0A/QCEttJx5NqSz+j6UkHHGSPJFqthIGPgAFirzMAV?=
 =?us-ascii?Q?poR4QyHtjseUqsqL0aOISMLpY0UwPs47/aQ3hWBnJ7SQpu4adGqWsvMi+qK/?=
 =?us-ascii?Q?D7OuGrtv3U6RI+9qKZw52VvVbPKCxuZO7XwqCvly0eaLxyJWhE3AyGi8OQav?=
 =?us-ascii?Q?o17jIZrUpEDc7/Z80cBIUxlY+npfr6a2KQSD8fe2ni4KfKWG5K3+LCbuDCe4?=
 =?us-ascii?Q?oSp/zzd6xwkJXcBicQvNe2v9oigTRRtxQd2Is1oYunSHTOLKB/BqPvpz81vr?=
 =?us-ascii?Q?9D2u2EUHSXHppsNA3rCHdw+hznEjUpnku6jPo7jlOWVdvztvhaADyn+N/6Wv?=
 =?us-ascii?Q?EsaGZrvDqzxfgbzDwI/hbpnu+YbcOK3z4cPW+2PhSURRPfL5Vnk9nCswgYjU?=
 =?us-ascii?Q?+//AFy+Tt5cJJh5nXA5deAoxbwKXnCqKO6ygXwJGzdO1JRPDEBYEArPTVX6b?=
 =?us-ascii?Q?gPOzUnUyBSPTfAHutILBgibx85SsycEZbogOPr96CY1+mPnzHcT3kI7VEgW5?=
 =?us-ascii?Q?kOOUNRtF99vZL+YpWC1avGJJYTJsTzWIb0Ivj9LJDqKmgiyF0xqtBoOhCixo?=
 =?us-ascii?Q?/yiArjddSCgW6nI4hhi5Y4jUg9DFHXU5HqCcEKw3MFutRo2ryg//UtL8FhG3?=
 =?us-ascii?Q?vq87GrAl1W19Nuey7FpUGDkPOsbSZzkLZ4su5AQ68PsvxvHn7yYYj/bOPEwR?=
 =?us-ascii?Q?fhKhKT4Ud6jwOUP2nx4IItJwPTkQciN8shGqxYUcy+UVWBtiVepyFTOqgYK4?=
 =?us-ascii?Q?rlig5lX2nktLfuXO/7R6wftWJsnvbrw+oqSBKdQF6jaQLjW7ehYePlfYU23X?=
 =?us-ascii?Q?+nTOy9Qk/SgHPj0spwUvMKH+VLOsrQJ5uNaMA+vad0jjKG6MWdItHUBHOvlM?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E9wFTVjp2tKES8kG55zWMyVqBLKZL5h1o+klOZslyOyPpnSJdd6pVigviPxlBFvZRMXwl4I9sdQLosVwywlu6FTdSzGrmGOWrmVCmdgc0yyxHV/bs7zUWEtQCl5rufVvIFzxjWiTpuVYRp+0Bh1h0V64/8lNCGhDOxOaxzz6Oe4JiclrlYkBJ09KUVP1Kzjn3fddI8tZsUvmizXbMQoewiyTiMXeEA5LTd58yaPrAALq9vbm2srg+VxuIpRq+K/kPjadBK6RrTTtTsjRPf0JLqYDVV96XPqPE/ObxItxGTJ2MwT2caDb+Ywhq8hPVXB/YjGQKkPDCL5L2toDEnuIoV2g4phKJE5/obyU1x674AMISCuiENKMhn/aUEtX3CgR4rickCDyCQ0GSGBvr+2PKF+dPoxiey+kcZHWSGJTI+vWvobSfUwbYGXb9GTaA28C8xCSMChwfKouux/CXPvy7r6b1xQG4K10ONiAFkfTCcNCC9zL4y5FEgtntnJ4M5VgI9KSNPE39KFEPqskHD72JXXTeO6BJEahJ/P+whv0kQ0KdK4H9GQ0AmtgsKBWB1gr3wJ0gojUVkDAgMdxmZnGOVpVfO1ZA3qKgxKGAFJ0c0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57065b5f-728f-49ba-7ad6-08ddb8a1499f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:15:02.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hGa4uQcEB9B5kG8vWkqo0Jwge615dXKuQZEP55Kq+QE2D/6dfbnZmlX/4IS4AOvii8qcq7oHUlgH92wjV0Rmlm/UyUZazsX76/86q0JAqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010084
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6863df5c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_8tl2_tmljWMe2TOhnIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-GUID: MOqS9TFddSNOQWyY0GRx7DjAa8G6NXJR
X-Proofpoint-ORIG-GUID: MOqS9TFddSNOQWyY0GRx7DjAa8G6NXJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4NCBTYWx0ZWRfX4Vw7eCAJxmWa zc8zK2D+2BmtjyiKq6ROt3WfLnz5Uj5SRWhvXy6em5K0PSm3aN7LJP4pUhbV2UtbqRpCg4U8s+V kx8hqTOawIE/3299eGHZjYtEd+Fry95frcHbjBI4JXqooAc40Me+bBozHO/fa7Hmr0jlbZh5WrJ
 b1mms5q5kbwamn5FQjbsQaBl4u01u//T/2BWFmm3WyHaB2ovElkvui3sTwKPfLh+IG0W9248Jxd I7XbOrypvEn6566HxTc5A338sYqJSNK1gn+T7YvnIN+mhGj3PqdSVG3O38qZOxCozXFeb+EEoyT PdY8Bx2UJlxB48iTSgycsVaIfmXQee/++jvEkoHXlJ1e4F+nGDEIojQFxbId/nkspIRySD8SCSQ
 vEON4KW1Ie78Ml3qZULmrBYIgOmbK3f7hmsTWkf6aJpEUfzg0ANTPdw7+PUwp1OtKF5rPlHD

On Mon, Jun 30, 2025 at 03:00:06PM +0200, David Hildenbrand wrote:
> Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
> folio_test_anon() test only.
>
> ... but staring at the users, this function should never even have been
> called on movable_ops pages. E.g.,
> * __buffer_migrate_folio() does not make sense for them
> * folio_migrate_mapping() does not make sense for them
> * migrate_huge_page_move_mapping() does not make sense for them
> * __migrate_folio() does not make sense for them
> * ... and khugepaged should never stumble over them
>
> Let's simply refuse typed pages (which includes slab) except hugetlb,
> and WARN.

I guess also:

* PGTY_buddy - raw buddy allocator pagess should't be here...
* PGTY_table - nor page table...
* PGTY_guard - nor whatever kind of guard this is I assume? (Not my precious guard regions :P)
* PGTY_unaccepted - nor unaccepted memory perhaps?
* PGTY_large_malloc - slab, shouldn't be here

I'd maybe delineate these cases also.

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

On assumption no typed page should be tolerable here:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6a5447bd43fd8..f6ef4c4eb536b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2176,13 +2176,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
>  	const int order = folio_order(folio);
>  	int ref_count = 0;
>
> -	if (WARN_ON_ONCE(folio_test_slab(folio)))
> +	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
>  		return 0;
>
>  	if (folio_test_anon(folio)) {
>  		/* One reference per page from the swapcache. */
>  		ref_count += folio_test_swapcache(folio) << order;
> -	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
> +	} else {
>  		/* One reference per page from the pagecache. */
>  		ref_count += !!folio->mapping << order;
>  		/* One reference from PG_private. */
> --
> 2.49.0
>

