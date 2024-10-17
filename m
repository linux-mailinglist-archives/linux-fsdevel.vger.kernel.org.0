Return-Path: <linux-fsdevel+bounces-32243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E059A2AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF901B21BFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CCB1DFD9B;
	Thu, 17 Oct 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AbligBS7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KP2nZjqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF01DF74B;
	Thu, 17 Oct 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186121; cv=fail; b=JjAfnzhFFaVUBqQDwYkAEQrjhfDWtGt2cIYkaAJUF1su3v6bN62oZ2428iKLwE99cagq0AsT/eGQ0DEz44d56KLxckvu6g6vyK1KpEn+gmqn+m9D4UPVCzZq5aKSCovixh2x60zVdxFdvaGTsHq2GpoiIi1tGFdKbC4tlP84kog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186121; c=relaxed/simple;
	bh=C0S2IkktnrKEzcLu0G/ulzpW99Jk1JrcNdAtQJfgXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j50dLRZFt4jbM0fFPXrTdbhTDmRIqkE48o5rwT9bBmUnUJkiaW082XOTbglrdH/NIufDNA+rnn+Fu/xSfKOAS/Tj1j9xIS2CJhFpMCSfg51YBwCGdQS9DvHSJCrfPxdq2MV4wd2CvnNtsbK0a2efWI29kZiL4kJOn2l3wFBu5b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AbligBS7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KP2nZjqe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnmn019219;
	Thu, 17 Oct 2024 17:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FfgoLmXphgeU3BpYwu
	EU02U+m/LwkWm9ReHrZm+qOIA=; b=AbligBS71zi3s+frW174eMOMNwt1Q8bXaF
	Gkq6FuUuyruPwIsQ0VNckOo56O3RY7aERsy5AD8NK0ZKN9zWftG4umxHy1j/tHWj
	dfHH8kJOOOn7iQtLtFCoGIOZB1iiCVCUg0ewPZGYQSPI8ynUie4ACLB4TIUFft0h
	ayH53WsKmJnD3FXQesjfnBmmCG9cUPbw8pH4qleqMKTrODy4Fb1q7shBp/nLjiAo
	nv8yeAkCvHso0FnvgZxsagd6sqtXTJO/elk4lYajZGXHrCWMLXJVHjN+9Vp14tqg
	/1hqh3cfoX971TpSOviURf3tQDIvLD9cTjiF6kC1VAhs3rrXhwgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cqdj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGWJ77026241;
	Thu, 17 Oct 2024 17:28:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjajckq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxOdAzR5YbJIMKxc35PufLYtZm72RN1fc2XRJZrOyiMx5Jpd3b8MlBpKWGZBE+n1aSDpFnzZKqApTepK9Nr2gscKXmGJItAj0LcSRcWFCEeOVWNkVtig0t87qgThcOO8GVEOzW5OMF/UzmGnITAwwnpG199K7cXoFqNLXKpNKtaDlGd+klLtg7syxlJGLYQl5u7kIK2FK7wNOr7N3jE+g6eGbBEw48Qh4gJS1rOXCK29VplqXhvX8h9/b9YQ48yiKC34EAadDTbj/J7qda71pJz5WUY6QDnJ9bpBRAkvlE+VJkxTNpPj/09e9mu5qxy1Gsru5HjeCBfsWoS34DwKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfgoLmXphgeU3BpYwuEU02U+m/LwkWm9ReHrZm+qOIA=;
 b=RFu2dTB4N0IwptT34sYpJqnUCV6jYQF/sjiDBv9+2SGKfi12s2a0S4AnzzJvkZ6y1m1RpmjS2OnlpOQNSvA78OZd3tLglM8YnuaOAXc11kUAwdd9yd6dqLagSoq9uczIB4ZfVXuMVSD0Ts2BXk12aJlScy7Fa0T0UKtefFGl/yS3K4LRadDqI4ywmp27IWXbtHAh1E6HvjuJcfWFB314g0v53fIbV7bN6uu9TMJ8Eo+fz4cmSXgqVzzBW8q0ouh30MeVmawL7pFF4pULJMTU3fLo0bfSiyZk+Afq21GNjCd5T4QBk9fDLU5cI+ua7R2v3Enq7PDxwE9OlCSQlZ5gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfgoLmXphgeU3BpYwuEU02U+m/LwkWm9ReHrZm+qOIA=;
 b=KP2nZjqemrCwriOFSencbWUgkqHv/ZgfbZ7TFG5+xzGaAtBNZ4/7TbJtr3hoBpjis3cYgy7MwC66l2IGsPQNavd7e6atiG05L9NxJBJdbjWPfV4u2p1Sic9D4YHahxEeIb7ymKGfabTHbD60xs5GaiuTW/jbspywm9A6TJT/msQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:28:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:28:21 +0000
Date: Thu, 17 Oct 2024 18:28:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f8fc27-a35d-44c4-bcaa-08dceed118c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+uURypqpjD20919pO+YgLesNZqe7zi48nUieXrfyKhoDvPP2wDtjFWJAvGC?=
 =?us-ascii?Q?nsz2lWCuTHIYmchp++OaOGLKvIkpGhB6/MOO0xXPkGNJTOJ1IW+E7Xg7F/Gv?=
 =?us-ascii?Q?ErklulDuiprMycLP3CQ97HFRrcDshOTulQUeOvV8bwHE55deaZX2haBzHcs5?=
 =?us-ascii?Q?q8A2Nq/z0pYvKmVVZhDS9mQhpDrscDnsj98gRjsPNL97qbmaeHVi/9jKhr7o?=
 =?us-ascii?Q?9VvKyY/9oVtMKbgJSyViNioKz6CgUBm5+GC/wJEIZk8l/B4VWJ8q6H7ORYau?=
 =?us-ascii?Q?1ABrkG1hBTIFlCh5hNkvA3wFLf+mEFjjPm3O6BWliJpS6hO4CwBrJUvFa6VU?=
 =?us-ascii?Q?gjUdtZfCnO3/j14F4xjf94IT76LdmVHW3u1UF7o8T6wHg8OBfguKSB1izrPz?=
 =?us-ascii?Q?Aa++Pk2mKULgWUEBeG3qcp4OX4WHkuUJLk4hyirDxy0Iw0H1t0tOD5Kmecfc?=
 =?us-ascii?Q?qLgIwkGnY/Nvckhi68baFED81apebp/twyOJ6AeUTzbGAmAZ8e58l8o7npA1?=
 =?us-ascii?Q?tTi77TNbWp034tJdixKHOIWD3xRuEuG02K5Y+s1LOSYqrRs4btq7Pbrm2I6y?=
 =?us-ascii?Q?NZGPMKqtP+WOStz66scnFn2RFs4oNTHdshzNIC6moeA7ww8qVZddzyzbJp15?=
 =?us-ascii?Q?l8QIbDIJouJAm771Yxx0oWfi5LAO1H6+F/GHLoPQC9IVOYlJzv7WaScC1ITq?=
 =?us-ascii?Q?yekB1hrVmEUp/zc3CwyhvHqZkaPOWS4svdDt3W1Uds3vG+rRTMwrEyVnD47L?=
 =?us-ascii?Q?oQNlRuvOgQWAiwNkbn7SSm9zq7MbN7bdpM2rQant3zMW9lrRRSSUiUEFhJfc?=
 =?us-ascii?Q?hHw1E9Ur5m+uUoqkh2i3t+LbA2z4y13LlPiMhWhEOUjMmTBW8eAx0cltzmas?=
 =?us-ascii?Q?g8FV+lrrzxUqFlGYqfXwxVI0RRBDnITGDL9AVwigdi7vr5emHfZWIOJQRChf?=
 =?us-ascii?Q?ZZyd9arQL8rQn9Fdsilv3Pe1I412WpkRu4SL0CkHzs3/331fCbQV4Sl/6wEC?=
 =?us-ascii?Q?ofyZx3SdLr+pyxKrzaFKC4sGXACtFR5SEFxtnfB2B2HCc6ZRIosJPgNq52ft?=
 =?us-ascii?Q?8OsVglepxKBWPjDDo9gyPvT1O4xsp/UvdM3eB0Eq1LX6QnOuIUY54ZIVia5W?=
 =?us-ascii?Q?DPdXP2B+8y9XFNiWwKTqbCCP1d1DvOLdnH8v/XmnKozwQVnIrR/p33pbtOX8?=
 =?us-ascii?Q?2pBvWN3+2+/lMECuSzGtg71U2DitETMafXLabKTB9E6/vCcDHxXMj7pvaffY?=
 =?us-ascii?Q?J4voKPLXGlSmyIxtAuhD7Cao+AtOXVkMMdQtKJeSxj5SH8a7PDNDeed7Z0Mv?=
 =?us-ascii?Q?Pqe7LnR0c7GBDjuoSVIZ75e1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aumBVI2PL9CRadHkYA7J4uw+0zdJKFu1TjDIrmn/aUlrfbiXbLcjhpnEvZCH?=
 =?us-ascii?Q?zQoBs5gXczvbpC/ARgmsUmC6nl4S/3EJia6pIUfJnOBLsbUt44Xa/nES8LVo?=
 =?us-ascii?Q?/nUVffa/yC6MMSpjeyti7eQkxeZliP93Vp7lbPp6MXJOgGAzzqAPoTliSPnJ?=
 =?us-ascii?Q?le2hkKcI0RUIE7+nxLRaIp3cFnkEQA1xiQS3XrIvQ01WlzbBbRPdF1kpZOg5?=
 =?us-ascii?Q?LLloRkXVkBQ2CkxO2qtZU6inrzPYZzJKqzoOo2TGeX9Cy4Odn69QCXMVBDlN?=
 =?us-ascii?Q?02pLLznvQ4MWZ7l0sBYwYDmmL6EJfAnIVt0sGJsyFGLojAdm5esyXcDsLBfT?=
 =?us-ascii?Q?jOaz8FJFvG/eWl0a7B68AlUSwIJO/DCjmvtv/YEYmXl2YZOTOfCNf0K3VSuu?=
 =?us-ascii?Q?zng7L+jZoJB6d3xzeuR/JyhVnhSDckBNhKzbja9BV/x2CNNJ0L3IeitZoHdw?=
 =?us-ascii?Q?BJXOYY9ljj9XE0MMTr3b5pfRJdq4kFzqX7ZSlmf0L/8zzSncR+aiYNKQVMVp?=
 =?us-ascii?Q?RPP8cC08ozfrv+rrQyD5Z6QND9oKHYCqjdMfASo6gQmKU19A0RqM48pZyzgf?=
 =?us-ascii?Q?SV8CUGn7U+8jUMudBfojd0CT3HVgLnueETfwZQrkIVmL1pvNGtDVrDEyH2mx?=
 =?us-ascii?Q?TSFGhYFG1Gcr67xDNSr9+XR9thYYtDfJef8ninyPlUbQ31/XGFh2Km17QwxY?=
 =?us-ascii?Q?DF+v0Vl+JRyeN+M7GQlwf1/CBnOu4l0dLdTgnBGOHnvY5RUqDY4XYPMTLpSz?=
 =?us-ascii?Q?YLC23Udtb+tSIYZzDh+ov4wRYCqophCP7y7C5HRln0A2j4JRioBxPzK5IUkx?=
 =?us-ascii?Q?gTbOuX37/iNoO/6M6v9Oo9gmqPdA09dAGlpupjzZ3pONgkfucEA74JkusoRZ?=
 =?us-ascii?Q?gQk09NcNoTkNxXbTkDbMuOA7cJ6NtGuM/aUjZvHTnqNgzx2i8KTnvlZHPGgt?=
 =?us-ascii?Q?FH5Xap9RgS6Xrt+XHiJTXjJsZi33LutNHdwWc/p/EL3lS2BTphwYcu/HQtbf?=
 =?us-ascii?Q?TEfFZKIgN7x1f10ODT2j+C+kPX/wQWnm8HxQEcto8rVNGHmMuohfCJ4pppbd?=
 =?us-ascii?Q?Eoo3u1Wm1TooIJkMebfNDOWsK2NgCastzve0L/Wox7cdExU7o0goaFhnWA46?=
 =?us-ascii?Q?yhQPyMQL52b422tKqBFkYMERFJZr50moQHm8x1dKK1QYgFd8WWagdiexWPwe?=
 =?us-ascii?Q?AHtB3ftO2Kh/Ki+cRRvujAz1G+uD8rJ5Js/3x57iwEIAoUR8716qiKrYwhyF?=
 =?us-ascii?Q?+/sVfSjFAtY3UieHE1hHObSIMkYnBUNouIBfvRmVwro/b7d85WY3Z4qwLM1X?=
 =?us-ascii?Q?dYSd1mtJ3+bDWCzpo1LrLuOD0YnxSWE3pRQrGv1Y93FIdKIrq5Vc31s5+dZ6?=
 =?us-ascii?Q?jxEnpfx3rYfu8dmX014fH/Sf88QhRMfAXC4Ff5wFeiC+jlLeFAlqkskzEtF3?=
 =?us-ascii?Q?l4WfoFt5oN+ciW4cb+Y4QcvQJlgYa1J8FLv+1fNwvpSQRTb8Oc+tKpr1zk9l?=
 =?us-ascii?Q?hUeb3BvkWstqjnvPWmjMETG3lP91P3ncepEnTRglM68PS3GbixuLRIRqoj4M?=
 =?us-ascii?Q?/1vPBBmgs7waKmVtWWnhLjAhkeVIcujbYvaza2sTKfSD+oRfYYuDV37ZrWcA?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P/3nSSSUKC28I6rTqYfnBSj/W5MxXOjaFs8yw8rbkgWU+EtND03Uf3+biKVlf0him6a837OfNBSnEUmjRv8AxcishjxsnLOowWzETNU8ub3q1NE/ssfy1CXS1/L6g13/gpIVMSvnq9iCUNXAHH/NG2Zsq53PNHJ2ILYvo7KoZckRyeFnpPYuBzdp8j24cUt8Z0WT3vzfFNyrpBnS2f5/Bg4pAmj8yNPk2dibISerOgB74fi2Cc2yeKvezL/spKp67JM8o2Q38cSSALjDpCVVamkmuPlQmbjpfpzLohQxjC9XQdv158rY9GRT0QCJc/twNBMx1ON7R8gT3mFeL00FsvbXusxGxZnCVtN2SAZlmTUpaMN7L/26DdDChCEeW8Z0CVxwZpgZ5+t1BmsWUme31ZzWiYOd6+y4cECLj1c/Wls1T/8aQvEmlmT8mRlQ3W40QcbbS8IGoNbjOBgT9IIEIdQofngb1MgttndBZftmsqpxZKwVV/p19gKMHa/wt3u24Vse6rZxifEktrA+bhYNE9CsszaW886AySaY5Al38sGcNnKY5Opu/mbrifhX1Lr/4BrE63M7tO6oX+unSHiHWdHJmy4OXi48AA3aAGk0H3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f8fc27-a35d-44c4-bcaa-08dceed118c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:28:21.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei/hrgJsyF3cScwKUg9iTt5BQjl6n4TtkUkD8Bnrni04yiGFd7CDD9Juk00wir48OqMk/Maactz+YMXo7DLq5fEXS8wLxSG6/7mL3WbYGNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170119
X-Proofpoint-ORIG-GUID: VfcRKgQGPZIVWOcabxmZZMEuaII76lWd
X-Proofpoint-GUID: VfcRKgQGPZIVWOcabxmZZMEuaII76lWd

On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
> On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
> > +cc John, sorry I forgot to cc you on other replies!!
> >
> > On Thu, Oct 17, 2024 at 09:08:19AM +0100, Lorenzo Stoakes wrote:
> > [snip]
> > >
> > > In any case I think copying the header to the tools/ directory with this
> > > linux/fcntl.h in some way stubbed out (we could even stub out fcntl.h
> > > there?) is the sensible way forward.
> > >
> > > A 'just include the header' is simply not an option as it breaks the tests.
>
> I should have read this one first, this morning, but I missed it initially.
> :)

No worries easily done! :)

>
> >
> > Ohhh ok I think maybe we could have a good compromise that should (hopefully!)
> > satisfy both you and John.
> >
> > I can introduce tools/include/linux/pidfd.h that is a stub wrapper around
> > the pidfd.h file.
> >
> > So it can be something like:
> >
> >
> > 	#ifndef __TOOLS_LINUX_PIDFD_H
> > 	#define __TOOLS_LINUX_PIDFD_H
> >
> > 	/*
> > 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> > 	 * work around this by setting the header guard.
> > 	 */
> > 	#define _LINUX_FCNTL_H
> > 	#include "../../../include/uapi/linux/pidfd.h"
> > 	#undef _LINUX_FCNTL_H
> >
> > 	#endif /* __TOOLS_LINUX_PIDFD_H */
> >
> >
> > Then the test code needs only to update the pidfd.h file to #include
> > <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
> > the pidfd self tests Makefile and we should be all good.
>
> Yes.
>
> >
> > That way we always import everything in this header correctly, we directly
> > document this issue, we include the header as you would in userland and we
> > should cover off all the issues?
>
> Very nice!

Thanks!

I saw from your other thread the idea was to take snapshots and to run scripts
to compare etc. but I suppose putting this into the known-stub directory
tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
here.

Or would you say the wrapper should regardless be in the uapi/linux directory?

Thanks!

>
>
> thanks,
> --
> John Hubbard
>

