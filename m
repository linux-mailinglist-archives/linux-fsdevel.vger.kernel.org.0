Return-Path: <linux-fsdevel+bounces-47829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F30AA5F96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327643A89D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52C1C9DE5;
	Thu,  1 May 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1zj/MUc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="beY1SaAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90928382;
	Thu,  1 May 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107877; cv=fail; b=COFLxR8tgNilLHHjrT6SMGF+Gd0/3J2FpHfYkmaCER4hEbBgSwWzjWSssrS3xpdAs/FHOsiJd9A3d0IpnoDP2WpYGu6eoDmVohdhMLhUnRCYSx3zWd60iVc9sPiDbivfCB3/e7PeuwmQ7LfdSE4mCfcUACZvel9hkTlAc3hoRG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107877; c=relaxed/simple;
	bh=XqmNx5+n5ZCufLJEj8SvF5jEnomP0HBlaLDA3HR3L1U=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQmXW3s93Vjyd1rug3So6SPvvG+klIC2+2dT4QqfZ9mBGEtw1JobMBK54KdQYtnw990yASJ9jFBn3a7q5fMWu8rdxYiNhyexNQLL0YgxG/D7g+odmWoKvt+KbN1W+VmTwSXvV+mI6/+uO1cGG6Z7zaVDUnzr/TkIe+J9F5m5kFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D1zj/MUc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=beY1SaAz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418g1BL007535;
	Thu, 1 May 2025 13:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XeAwCEXnipTO7MDpJK
	urw6JHRq+VCebaIa2yQzcvAYg=; b=D1zj/MUcf+YtDz3QTUbPPadIRr3hHXYI39
	alfU3L0qOWBuKYKrbjktnfAAVRutWC/l7b4OfrRhn72h5sNTP4VBvSCXXbbpEZLa
	maTAtB7XO1eiMrBIODQsgmC89XloD1cr45XH9xBjqA8OExbt5kPjKTFfK0Q7Egqs
	LSxgyTGMhCcHHSDSWiqSGPKEMgj8ZspIOO4kp9pCmiYB8qQAg4P1KwQhChC9+S/t
	KyL1m3vVCeywLmu7Nd7TLHgAB1fqAEBysRliQmpMDfyJ3bBrymL3zaRPHPI14GJH
	d5dxcz/PYBHlRsQwxh28v8uixQVFDKkOgNk/u+jfId0ZUQPQSIdw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umb1fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:57:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541DA9rY023782;
	Thu, 1 May 2025 13:57:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxjt9be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kp0+oNmj1WCkRuoS+UQHs1l2GQojgahGN7NGk0BLSn7+HicDYTqiScEy2i77gvE4HF8ZLsWaHd0Jrn432/ZXD81QXQAlWpxg7RlIxIqTN9x0iRc8m4//G9JKhU9ErcANFCdDGi7JMF8p5NEAZwXtaaeACZEh23umAAoV2Jm6ezm36nBuuKOrWkBNU81POFsSwXo2SUnDbBwRZjHI9A9T9qxda1VLD0wBZVN5uz1ARlP9XR/CWNtM5hcfWOjBKFsyBTujXPCVp6m5EPA3mgTxhmmalCNxeVnSBOZZ1LbSaZ7G+skQeltfnbvo2laUhV2g3j6oT1XH/J3sU8u8trCROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeAwCEXnipTO7MDpJKurw6JHRq+VCebaIa2yQzcvAYg=;
 b=NyB6iH84nWQ2bNZF4b5ddvrQkrahYip+N1OGluG0QrNIQAx34v03GRIaQfwgFIwkdO48U3lh0o1eizvFqs0bOGxErk3Rhnyir4DI+JWBR1T94+3XPxmfLxYcemOHJuXsUl/wmZqPLAkRKY1oNM0OW0iO95wIs0eUMTRyDio5B8JWQo728i/RtywGdYnaLgJJW6YEDQupfAzvFNQr9xtCKhsoQcuLZiidXYVCB7t+ZI6rTcY8W5fkvd/mZkAKh5SaIClhtU0fWNKA2Xu2ASrNDaRZCIHmTaxNJORzs/JQykEKvZi7+QaJ8PKdBxLTknCHfATrFLHYO0nH3/1pysf6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeAwCEXnipTO7MDpJKurw6JHRq+VCebaIa2yQzcvAYg=;
 b=beY1SaAza02YIY8AD2SQBjpcm24zSSf5csUtQ57bSubGUeJQrWWQjEITafqPK8i4cjcIT8pMOXvLRMHZTcdlP4PlQV8eg5m6B3j8Z3fIPiiSQkWNKFfYVnFprH4nm9gk9ebqvLL9ymxhX5Xijsp+a5ASohYA2sR3IXsyUSQT9JA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6511.namprd10.prod.outlook.com (2603:10b6:303:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 13:57:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 13:57:38 +0000
Date: Thu, 1 May 2025 14:57:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <b98bf241-bad5-4ada-9a03-6a79e2ab81c4@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
 <gv6kqbd7p4a2qfccxyxusgcctfr2ny75d3yfltczlcbpcxa5bc@3bjc2jynvb5c>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gv6kqbd7p4a2qfccxyxusgcctfr2ny75d3yfltczlcbpcxa5bc@3bjc2jynvb5c>
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: f91942ae-e092-406f-fbd1-08dd88b821db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?95Cgea4L0OSSAR9Gb8pwZC4bNydnfscYrmpYRrljLEVb8idmUKdb8sA7hr4n?=
 =?us-ascii?Q?U1dHWPhoaKrsIFD7qtXAJ0+rstY1ovTAXZfnCMpEV0e/JmUa3PWqUC+6oXMs?=
 =?us-ascii?Q?Jk/uEAuWzxc2iO/yaF5MPj77EC0YvSJSmRaT3oBu9ipJOMHc5m9pxwnA/cL1?=
 =?us-ascii?Q?DdQgzVHXxhZPZ67kIy5Bpyw0h69Ro2GibFkWYh494Hq03kege+3OKB2ADM1M?=
 =?us-ascii?Q?pOCFDevDqdASAG2ryefzTckLO2d6xcfkZYWcozByByE7b6OWhXR71Sk/G/WB?=
 =?us-ascii?Q?VcVqw47Q9TKQe5ExKVinGfZrDRcLdMsZ72IrCAdBsQJaNrew4TDfUYVb3NLo?=
 =?us-ascii?Q?7+ESrVv4XY0UHZgKE8kSKHJpBN7I+Vn9pKpsE+gDUVlN1deruYMF2gwX96wN?=
 =?us-ascii?Q?zJozyNKHKn4+mq9eZ8EVPZ/PXhGxytMhMay+xrkIOWW0sXrWn1fleIGrlwDc?=
 =?us-ascii?Q?+Nyonb5cF07xraN6AzbaLA3aw5UooKFzy5XKMiVbzAEabyIe2WZBSSRYU/3y?=
 =?us-ascii?Q?2+Yg/Mx9jW6xplhwdyyh9VFrF8FAccTWYkp3sD9fQy9jricPZWuURsFyBwu/?=
 =?us-ascii?Q?V6m5F7W3/RLTdKygL4ygPUhTNuo3MVUbX9R8NzbYdSFBWRhFOJ8jrctnRN5a?=
 =?us-ascii?Q?Nry0qcbKLp+0erplpYoDHJuYy4yZZsHMGbb2zcdVgTb6O8wTHEl+s+Lx82cM?=
 =?us-ascii?Q?ZOFj0h2gaR/61EA2lMd+NmG0Ysi/eH7ArnWdCHSC14AKEn2i4KOkpunH9qPN?=
 =?us-ascii?Q?E9eyGkk+RaU4M3GAx6YfXKDVFaeNEP+2RVUsNxrz6oUYP6DprlQCmxCpbrwT?=
 =?us-ascii?Q?T14yi8zVp4NdyiaQRBn1C9qLT1KUBa9uY2yq+bEndxDRz2N/rSiAHFZDMytP?=
 =?us-ascii?Q?jEO+F01Tk7Juk+BUf+2tivIc3vaj9ByVhhWIW3kNowlgBY1GsqOXL+NNeYjK?=
 =?us-ascii?Q?PKocXmV/ce0tw3zyGdJlkoUJz+JhQ6PRHWKQTB9x6pcGSMkJsgrJsbe5svoi?=
 =?us-ascii?Q?B9mS5SyXErUKrqhRad0LxxqiJrHRNUKsmAJuTRvpyq6AEPk9dIyX1m7TKtNX?=
 =?us-ascii?Q?+6GFD61ZIPGBoz33ZyXZwP61KoldT1pZJ5Y7StZ2qARPYgfjUoNIcH76SvEc?=
 =?us-ascii?Q?NUUwFTVh4rGHNvHszhMhRb2OR+xUdXIZRg7s3qi+66GePqEBo3EYZF7yyXaj?=
 =?us-ascii?Q?Dqd8ws4NOCcMoNYJLIv4nEpnrNFZ0kXr98koyM+lT6YvDgqIEDDA6AdccS3J?=
 =?us-ascii?Q?4e8K+akIazxIHtltAZsoh+Ay+lB8hoz9v/K4kEy2zow677tXxzBJgGVnrrb6?=
 =?us-ascii?Q?qS03QzKj1eVN6bIdZo84wWEF+6cv9CTuMHUx1B9l00lOTEV4p6OFF03zb6lY?=
 =?us-ascii?Q?550d83ZbJ4GTp3t3RARYMyBKzI6I0BgWZYD3FbhDU0KM+ClEMra43hsfA5WR?=
 =?us-ascii?Q?w/Gm1WJa+MCCeZ0V6H2+2QMqMuso4I5lAILBNdZbna0K8QpmY4i4EQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/KiwF70F/ldpjvLOpzn4kgA3JrREUQKzCpmnKrY/AiCv3u6sJZpwwBXd4M1?=
 =?us-ascii?Q?jUW5FdKkxz6mjW9NIdt4RkcN4cP2x5s9Av/2GEKYY32fPoa3KSR9gdpZWT+t?=
 =?us-ascii?Q?rMBS9cYWrvnuXiPoCZ6qXBqz/OdlnuC5Z8KczboX9SVwsiZC60Pqw2Y56hYa?=
 =?us-ascii?Q?nolKF+OauHhUUiQ4dNPcnjpuPcRTVPhN1sB73Jpz2P1HSW1SNY6VmCNvxbez?=
 =?us-ascii?Q?+W8+pWs155/SxZn63QuBBGRCexGhiWEF/V7jUtIpW+FBcXTt16LJwchP/4qk?=
 =?us-ascii?Q?xSZUGIxprG+97hQQJ2aYMzBiTBsiuZDlSIbHqU2RcJaqGcbjPh5yNaZhdmsc?=
 =?us-ascii?Q?wdL/X/Ykd7Me4axtiTEOGPgDRcakTXui5JIP2FcvNMqSGm0vvFjhViEgUoUV?=
 =?us-ascii?Q?TcW+VKbGDjr1nLT80368jM8lILuWhay6q4xXzimI1v9u+1iffEP/f6rhnG3Z?=
 =?us-ascii?Q?pAWiESxQJq9PYMtw6V0v7hwACTm2zhrBAuZKtDn96GE+I5O89mB1sJeg9viy?=
 =?us-ascii?Q?oh0Ah0sx+9I3JACNlq7SrC3uUbOrGFL7LtGxLo+d3lCPcYl3N9KWtA98rdIq?=
 =?us-ascii?Q?jTPc5tPKUbhHTOmz62yj/L+4wyQ5NCZ4HqnzxkVPlCN26sIHiSUI7kTzxbra?=
 =?us-ascii?Q?x8QAcOrXKtEeK7vn+OZE9f+ZUqeYpzfcRvz1O4wHpa4Sv9XHnm9t02ktYk74?=
 =?us-ascii?Q?gNbpw/Sfhu0k++N4svtUiO3XiLIg7+qsOM+BdJcqoaYED/LOg/5yE5vc3NNC?=
 =?us-ascii?Q?2GR3lQpwG+rrLmLIRvS5+tJ4D5z2XRRDC6GvAcOKNuz2kdzx1Cv1Ntsah+7f?=
 =?us-ascii?Q?1BR2p+FojJBto8LylzLYe2AMULFA/mz306bMyHPnZcpq519Ip2WPO/xq9lYS?=
 =?us-ascii?Q?Zf5YAENBtfolJt+dj67P1xZ9AyH/FSn9zPa5rsd7I6Fu3p3TnvYNqYejrKjx?=
 =?us-ascii?Q?KrMXnw/kPsU7L3roErJdpkF42nhplMGiwII8dPbkyuD9wfsOG7EOEkVYAXBN?=
 =?us-ascii?Q?4xeLQwLTxgOtjVNqSyH7Wqotyaxdx5qFwHL5p4MRPtZZrSUMZ8pA2T0wonBS?=
 =?us-ascii?Q?cWme/PAoJUW5wvXAt8Y6GL8kU9Dk0IuL+3BgP/G9B5a0wcyLCGrWd4vKCE00?=
 =?us-ascii?Q?IFfwTlEsV9NPnszjzhoX/txAAuUskB6RzOla4nn+rhQ5PayT1wuk0tmnvgiL?=
 =?us-ascii?Q?GHCkth8XW9WCsFGTMgQQdCTfmDVcTSrZXy5L5t9Oq8DhjtD6wkfvzRtSkQOl?=
 =?us-ascii?Q?9zE66RagpSFodoGha0cq2nG4tWH2HYVsfAgcg2l1/0mQVSNleU5T+WZNGSx9?=
 =?us-ascii?Q?oCa0Ial24uq43tIh0e3Q9QyrW4AlGqhQO0esgrIVbvVx5N8B4uiOc09kf+jF?=
 =?us-ascii?Q?cQvVJqqwKBvodSliEoHFytHzuRIR1OVIqWITTsemQ39cfYrClY7tYFPhjHyn?=
 =?us-ascii?Q?QDle0kPUe7RJJxo+oZZALLqMbQnBaB1T6b1M3fRRiqTuxhaefITpk3jq8CbD?=
 =?us-ascii?Q?7SscACzByobqi4KST3ZJHcd2loZNW+8dSgvRin3JnwV1kRzAut8Otp34Tap6?=
 =?us-ascii?Q?M4IKPWUA7HCp6JI4Deg0vV0a5bbfqmvsH/VGn+wEFnJR1M92hCpwUCJ9ghhB?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8+7IkJUA6s0b5IwKrWR3Vprqe5OWSkbTUXOHZh3XS6nq47TC33lDvKreERlKy8m5/Fa3t2BR/UdOkWmNhnx7bwa6CvPrfPbtTIx/+hxHOmhB0NV2rEbZsWHCtdr7xc/SnLWiamIHw+n6hzdbnO8XVRY3cpYhkel4vUW6GzBtwQ36IvdMZA0Ce4r9acfyzTkAin8hU1CmQ727AEhWHl4ni+P5tGGqhTNrweRLjZI0GzaFQa2YK7nrgwQgl7Fcm7ri9Nad9+SUu1acvF4g9rbUHMjJuRfOa1wuwnMjRX4BvKlubmQ0QbKM8vFFtqCVK+kVVC4412H6NHkXVbXm0d/v9hEF4ol0C7WYvUElU+OpwcTjJa+0qkQiiegqLPdZJ4ccAUgcEFWCbSr9p9Zps7syPXTJB4EJPUN7INYUCJoUmFfINIgma6TcVD57moxWt7Ve6vBPq+cCAF3XrwlNnnlcD/WRXUVJV1jjvGWajhbEbmH4Dtmwi4Vxw8DyF/hUcK/VKCYsrTLhrz5RQaWP4wMvGvHhPs8u5BLktOaxXtFnkzHuuhG2lM/8hwFBNFOASBpjiBPAIaMQWuLQ9danHasmyGYqmKX4hnV2Z9JcVjXI3dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91942ae-e092-406f-fbd1-08dd88b821db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:57:38.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkNqylqfksRViZT95tVEBGF5UZ4i2s9O5VwdY1OZdcNecCTl+Hk1eDmelhfaZVmRY4NcElrGNVNOgCQUOZJnM22TWI2coZLhk2JZCSUdTw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010105
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68137dd5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=k_gSOr24rlNN48mtMyMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130
X-Proofpoint-GUID: 5WqfNfZZjb_9RkqHokzyvsCEIj6JYUFi
X-Proofpoint-ORIG-GUID: 5WqfNfZZjb_9RkqHokzyvsCEIj6JYUFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEwNSBTYWx0ZWRfX75c42++6RGdK 1ZxrTj8QLnOta2JjfoYUIAaC0ammAywApSroZFGdvOwa6uCsrRuFNqPG05wOWpqmnvDlpJcr7vU +5QP6skG84D0btMJuMuO/dyQVAsuBz6tAo1gWUhsiPc+IlYnNgB57XoYJdQtFgAvVenAdG8mLpb
 IAoc3dgzSxxYlrkeXp0/rfuf1ZYyWHzoPz4bnwaItsRPBdrxbak2lbnfPjvk4eUkS55I3AzVnRM zFMSY+7xcI+ATjqHZVKO0bL17NOciexOxhd5UZeYN8OL+oPAs2fM2XXweSmXBx19k6PDzzH9+Re uRZahlCr0fjToZPJcG1yeTsYSQJ+9Sz1rGkFNgVcbu71yXYRwNi12h3HtCtBTnJxPqNf+OEIyaT
 MK+fIioLQGdzYnmGPYC893x8spz9zNeZ05BVdwlcGrfJ5l3UYvGhEb7GVTS9m4B8ZN0xR+2V

On Thu, May 01, 2025 at 09:51:26AM -0400, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250430 17:58]:
> > On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > > Provide a means by which drivers can specify which fields of those
> > > permitted to be changed should be altered to prior to mmap()'ing a
> > > range (which may either result from a merge or from mapping an entirely new
> > > VMA).
> > >
> > > Doing so is substantially safer than the existing .mmap() calback which
> > > provides unrestricted access to the part-constructed VMA and permits
> > > drivers and file systems to do 'creative' things which makes it hard to
> > > reason about the state of the VMA after the function returns.
> > >
> > > The existing .mmap() callback's freedom has caused a great deal of issues,
> > > especially in error handling, as unwinding the mmap() state has proven to
> > > be non-trivial and caused significant issues in the past, for instance
> > > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > error path behaviour").
> > >
> > > It also necessitates a second attempt at merge once the .mmap() callback
> > > has completed, which has caused issues in the past, is awkward, adds
> > > overhead and is difficult to reason about.
> > >
> > > The .mmap_proto() callback eliminates this requirement, as we can update
> > > fields prior to even attempting the first merge. It is safer, as we heavily
> > > restrict what can actually be modified, and being invoked very early in the
> > > mmap() process, error handling can be performed safely with very little
> > > unwinding of state required.
> > >
> > > Update vma userland test stubs to account for changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> >
> > I really don't like the "proto" terminology. :)
> >
> > [yes, David and his naming :P ]
> >
> > No, the problem is that it is fairly unintuitive what is happening here.
> >
> > Coming from a different direction, the callback is trigger after
> > __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> > that? (mmap_setup, whatever)
> >
> > Maybe mmap_setup and vma_setup_param? Just a thought ...
>
> Although I don't really mind what we call this, I don't like the flags
> name.  Can we qualify it with vm_flags?  It looks dumb most of the time
> but we have had variables named "flags" set to the wrong flag type make
> it through code review and into the kernel.

Sure, will do!

>
> That is, we may see people set a struct vma_proto proto later do
> proto.flags = map_flags.  It sounds stupid here, but we have had cases
> of exactly this making it through to a kernel release.
>
> I bring this up here because it may influence the prefix of the setup
> call, or vice versa... and not _just_ to derail another renaming.

;)

Yeah, 'flags' is one of the more ambigious names in the kernel
generally... I did go back and forth on this one but this is a good point,
and it's an easy mistake to make, sadly...

>
> >
> >
> > In general (although it's late in Germany), it does sound like an
> > interesting approach.
> >
> > How feasiable is it to remove ->mmap in the long run, and would we maybe
> > need other callbacks to make that possible?
> >
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>

