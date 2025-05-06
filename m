Return-Path: <linux-fsdevel+bounces-48215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F0AAC0B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F09E1C26ACC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAACE26FA4F;
	Tue,  6 May 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DeOGc5vr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmHsj85M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C827511F;
	Tue,  6 May 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525734; cv=fail; b=J0/AeVBIlCaFgvw3dELeqooXI5JZDSXVt5VyHNWbiVTcnFH8dYwsxHQAxoDwH4bMSpHijlbRYcG4Uf6Y4d6OS52DA/Dd6y2wSoZZoMPF0lCv4pkP6SxbnpwnxrFqEMwpZb5+NmmGJ1N2onLqWa/wvn+bOzYRxA3oaeVbf7KMYgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525734; c=relaxed/simple;
	bh=GU1YZg2iKry40uhSADxc8PkPcgmn/Pzwpr7wMwPwoec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKdALlUquVpgGZcNX8+x/AAyxdKEJ0/+KOdf5D/r7BQzTvDWfqQsDMowppPxTrQqDKo8DGGHHU1hCExeXTr7kkQyD34otzXiQpLic0mlvyxlMGDsM6WjyK/ZCtIJvAtPhN+2iW/A3y6CKvcMVGXnqpSDxCN9KzRMf3/byjtE5o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DeOGc5vr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmHsj85M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bbug027344;
	Tue, 6 May 2025 10:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GU1YZg2iKry40uhSAD
	xc8PkPcgmn/Pzwpr7wMwPwoec=; b=DeOGc5vrB7iGeURTksCRyZsgcbG7/p9da8
	UIqFfYMAXehblhMfUWGhpl/VT+PjTSCA0Ad3tYP5gBQCosmcTYBINfj0RKy9IulQ
	ox1htZbO4FEwTyYOV3XpEfKMfu6QpyeaWfg66rgL3nj3zv/Svgh65ho0T8mFhJ9i
	jfJJyfoMMIZBdj5rPWYlkFbp+E/T4RWxKSrKciBKcZMpcsnJ611zzzBiDA0Jjy0z
	UmwX3SSxHzGsdFZbEE6aH3ujnBiLz7qXGBS0woR4gEHGLAZsBDnuMKWFtAzNd6hE
	08GmAngcExWNV2p+oSYi+MRWOVnkYI7QLSOBTBQj++QLzhUp8cLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t066a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 10:01:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468W4Pv037648;
	Tue, 6 May 2025 10:01:49 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8hyhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 10:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFEWA01M/SGUk2fORVU434lVGztPUdeB75dlNCOm2quvllqreUAMeomFd3Odq8TdLk55zjAsTfVZb5h0i1msEtWtXuC9hGuAIvT1wiY5Tj6bRrKTZ8wunuPo6SKCDmSJcWpozSFlIw7n2BW1Wo6bkyJRD1OAEEG8xXux1XA8jAc+4YHX9bjsYg46/0YMHdAvALnb5h76uV5EQ3Hx9z/9iW56Nnr1ZEMnAs+8QQQ8EiT51ChqkfbFWsHhaIIi1ftuR3AgsnLgH1d6X/kZ3q9FSU2vdh6AEYol6kx7QN/i7MhJyXlyvlhTccEETYCnvd4ivS2cAA4TzTxG4kwPJSkwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1YZg2iKry40uhSADxc8PkPcgmn/Pzwpr7wMwPwoec=;
 b=m8G0r52RIADLESYi8kmZgvzujc4kQ3WabnprsvVuIXNx9HuUiS/M68aJlqGpD8TEe2m7dCFnGlb7xZMurPwlbq+OEo9GWL56a5clZiFvkB8df0IRddf2xSw8dJfYjKNvSEufxJRCKXR8fsLNhbIyamSPtHz0XTml+REzD0qU4OytJGAYvSA/iMpB68D+d2WXZf7LFmrBfTIjHzwXkD8c7lL0Glo7glZVnJebPsBoumEcQmm6qIXvD1n2sRpBVI8YEDEjJTXDURl2nVIQlX2WMBWA259EWPlzfwrjZjnkmktqQsnl7VX7ygFu13Hc2pdQWTFfRRrWHKmcWbU/JA/Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1YZg2iKry40uhSADxc8PkPcgmn/Pzwpr7wMwPwoec=;
 b=kmHsj85M3I+vN2ZpRZJ4AwnWp/3Jm+aMiDLGoEqecC816nmwRDF87MyoZzB0LolRf+ZvrQtDeTrLQsTaYpYMk8LgQGg7rZL4O03eolJN++NKrKmX1alVSz8j3jX4HKTQdEJJLol7ZpR+ZIxVCXDM63R/TRgoi56MjlpRtCtGExI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFF6170ED89.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 10:01:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 10:01:42 +0000
Date: Tue, 6 May 2025 11:01:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <0c91e20c-c834-41da-bdbb-3d1de4a21b0a@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
 <20250505-woanders-verifizieren-8ce186d13a6f@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-woanders-verifizieren-8ce186d13a6f@brauner>
X-ClientProxiedBy: LO6P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFF6170ED89:EE_
X-MS-Office365-Filtering-Correlation-Id: 503e912f-87f7-40c0-8e32-08dd8c850073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cr5HaLgXWPAfbrleawVNq5o+5ngiSv9ZhTgJMHGAhxlVoeGLYdp5vNm6Yh44?=
 =?us-ascii?Q?JJET+WMtMsE3nFTdrRa9qK3fRceglimhQphWrJxivk6OSiBI4Q0kQdzRe+iE?=
 =?us-ascii?Q?E55nOoMRCY+Lu6rqz0eCQ7p8uZzvGQddHyuFhp4cG4aUi65180A2NZpwLslR?=
 =?us-ascii?Q?AncBFr1x1Q3Irm1qY/5oPeY7BHCTWYv5ZEcG2NY5pSesRGC9LXwWRUWxwhdn?=
 =?us-ascii?Q?GvxyV5HLMYu5b7gw/beWIkv+mm58WVaLifTirnT6185IEhmAPb83t+JNnhfM?=
 =?us-ascii?Q?kLqBXLpshxFfwAQ1pnl2LZM1hg5YTgHrHnhmPhNrCAGSYXt4PEzQzcF5uqqN?=
 =?us-ascii?Q?VhriE0O5eTWFMuBPIVQBmDhxFtfyWPgtboUykJF+mSsnk66W/p/zuVw7Zt5R?=
 =?us-ascii?Q?LhEiLr7tKDShhU25ca/OjFEW4mAjSppaG+D8/VOMQbVSiKEHyl7p3zti+8aE?=
 =?us-ascii?Q?7JVtijrJaGuaHNGYTmWuxLWsmd6w9VNb+vyJu/JEpuqcRH7bjlMtA4g2DIjQ?=
 =?us-ascii?Q?7xBsmx2TtRVn+3eIRYbuhHk+fQaZwF8FnLiokglNLB87k7u5Ca4qbsdkN2Eh?=
 =?us-ascii?Q?+8LRA4Oc3ajqEaze2ki6xkeVFJlvc+XbOL3Msx7pODk0uR84Ekba8xM8x/E5?=
 =?us-ascii?Q?tGXPSfQowR16Qe17RfKXJBr6zaeCgJ0GgGqVHnHLrAWC6/WlODN+HS3En2+A?=
 =?us-ascii?Q?d7Cw4lsRE8bLhMW84EQtss2isswagMg6kyV03lPOKpkhEgLGtxGCIL+cD/QH?=
 =?us-ascii?Q?Rhv3x7TKt6+Zgro+VAHQk4VRucNI053+1Dt0JRgo+9mPKUJQFqNLyo1ZFkFI?=
 =?us-ascii?Q?lNQ7I08IyJx9Gzp9GPLyN2Elo4GI9fdmDFQcalm13b3j1UAMj+d+0m/fhjAy?=
 =?us-ascii?Q?ayemkvD1bZHgLtG2kka9lat9sfp2UKTCWcL32MmuqaWRYDQv8r8edTZrrTmM?=
 =?us-ascii?Q?NfQJilnu+BH2QUn9W0eLKqNV5mvLOl+comZTFLJfzocDBB2HyxHq75bTqOKB?=
 =?us-ascii?Q?XzOcJcY6ISeMGhKKGodQU1yZc3UIO3Z0gBtgfzMRCnD6Q5RN+nfNzd+Y5H5r?=
 =?us-ascii?Q?o+6N82ZeHCU3GYdRQ54ih2VAnJKhpz0wfCrAnptJuz3ZdAQCq1IiQNZShvG3?=
 =?us-ascii?Q?uiCkxr4zpKQ4Or7kfUzlgf6aJVmXktMt5HmgPsTwJVN3C13qj9J/o/28zh4f?=
 =?us-ascii?Q?TfhuZSS2DXv7vFlomgcbfJpzX1ct7ZCcSfc8tRd7i+SUaqFbyssP9CKPRACS?=
 =?us-ascii?Q?dMDBpS+mHOVXNwKop6yiJ5wle4dxP9m/rJCJygYDjZguiaXqHssDppVkZ0vb?=
 =?us-ascii?Q?oc3BZBmTa9+/F33N0tfVE5rPKHeIEsWDr8+rBRKT/Yd3pJtOH+AzuPD42NaV?=
 =?us-ascii?Q?5eHXkD+z+1dWhT1ZP3ZaAOHVGX6pwla+8xavaL9lr/N+FDhgKxJqqmw6Ydjp?=
 =?us-ascii?Q?t/wjUyPEv6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7FdSp1UUrAjEzkggmUUHozJE5M+bsYhaXehNm0wzZ9L3g3ABut9fN/qTS07?=
 =?us-ascii?Q?AGIcgjnRThhKKQlokuBcHshAXqNFd5JNgLbn2+NZWrIh0mPPDaW2W78hrNeT?=
 =?us-ascii?Q?oD+RNFRTO0XLA4Ldhy33TPsonrFjgHjodzQ1cMkzgLsZDxX8HTfFI8997wCb?=
 =?us-ascii?Q?4/Aw9ktg6WXvJp/nqZJmMP4MZP+2WvLyiKJFgrCPgFa+YA8UCoFfVH3dJTnU?=
 =?us-ascii?Q?3F7SmeGApbFDV+s+08oKH9NtoBW6L8rKyhFli4cOoGy5wCi9XIr6b7C+5PJT?=
 =?us-ascii?Q?YCZ/OvVXzWRZlYL2GcVL1tCk1wjEkM6lxrpcZ3F2O2+7+fzwjnjErmicncST?=
 =?us-ascii?Q?LkrijUORmRHwtwpu0FN5lb6hyxvXrJDCIvk7/N8BG8+xT+VaDuYei9TKSy3Q?=
 =?us-ascii?Q?PdkCZNL9XtYpSbJEjAl1OqetcM8LPgc8uNiv+CFWACse5rrw2Y7RoNDLDvQK?=
 =?us-ascii?Q?yCF5s0MyrqpPaU1gNgzgCSJL3AgxwoH05QMBQ4h19Z/Lxi6zILPinKhhjT3W?=
 =?us-ascii?Q?kNLYxHyX901GX8/xCXkcgxxbK8tGgeIaGPZrnbL5GfMiA88GC+2B/CTzrb8N?=
 =?us-ascii?Q?ILJe3ctZIxtNS7NmfeqxNdV12czP2YQYUl3pzdtK7NQa2jwCFYKf4KH8CLpb?=
 =?us-ascii?Q?Db1nsSm40i/qco4sj2GlQaWOZ9hwzC65BcmnxVTzWUcRzgX6DWGmuaU9nryg?=
 =?us-ascii?Q?2su5wFXhdlp6jOylm5XimquOw0a/r1TzB0fMxslIrx2PgHXPa+pDx5ku+CvL?=
 =?us-ascii?Q?GBQpaTHGPGImHphUA4PoZerOx5Q9cIvKji02Z9DWvZOOedpGIBuf0EQXTTkQ?=
 =?us-ascii?Q?WX8GU6UeZ7BzeI3q2nUwe4ratkB7a41fX9qu8UqZoR2x7OL2c+GInJnBzRSC?=
 =?us-ascii?Q?H4xsY5dFHqXya6CB2U7zYskasvOo60UqUezbj9CVEGsnvQ3oALhRaceD7NDx?=
 =?us-ascii?Q?bLz6mlNuscRXpvFfSLtOzV1sZ+nVEmvZyu5fGyOu1paUet+uYLSI9QRDJUP4?=
 =?us-ascii?Q?e1V3CWgm/XR78+ArIb0YMYmHxkOREI7+83S1CPnTFOXqBf+jFrsTpwmUXs2W?=
 =?us-ascii?Q?Q6lkyL44sAUxBvf7PBISX4p/xLKEhv/L8vbwrmEfT7NjdEEpXGkS6rFs4A5i?=
 =?us-ascii?Q?D6XCEX1+h/miOxewN1PTP2rb6C67mjVHeGws5tCm4kmyHzq1bsuxHlrTw+8W?=
 =?us-ascii?Q?XoPYvBFYtZYoMBS2G+F5X1o3yHKc2uIZsKWSBo6G0IetZ7Jdsz4Vfnc1BQYi?=
 =?us-ascii?Q?7Xt5tDNyqMQ8IY0sMWMO1eevH6stn4JjRMRQOXBBNq+Suup0ZjgNkjFwORSH?=
 =?us-ascii?Q?R+SgUlkeDhYiCY8D87sLNz2pWUWBOTigIr3sVcALVGa69wDT+96kb8oQWsl2?=
 =?us-ascii?Q?u4VcceoDiX731Wsr/KdktarDO0GrMtN01GzqaBZ07enBGQe/fpsprLq7nZzs?=
 =?us-ascii?Q?I6K3kjKTg6gVLoWUlQA9Z/Uyyg/MzpfnbBFejbE1q4+GKnj7hGJUNmPt7FgR?=
 =?us-ascii?Q?c46FqnJk+FESK6xMhbN1Lj8GZMIgcipGnp2nFFokCvQc33qefspWgIEncOpW?=
 =?us-ascii?Q?tGXOYx3IPYc599hShRLS9V44EVrvqiISvVICKw0WJvM6BjL8UAvWDxmB5INn?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0JRyjG/dDEL5LJn/owc9hIr6XPU28SUFhaaC71cqzs1hjtWr2ej7Db1TVw4Qw42SNevQAwdk0QH81G/I7KC3omAWTuUvSwV+0OJCMy3ZjfB9RmdTsX/J4iyCwdUO1LtAzjbRfDNpR2coAh8hf14EB+Sxj+rPc6cbtrP+myIfC/IYCxVv/Qu1bkJUHutAbWL5fQO1qM0EmeeG3lLi3OVA3OaWoBv3V+dpahF5lo9PY2L4K2iT1G0lDvtq1J0JWjMxK4fgyDiX5SsdXp97fzh1zicpEg/8QZbaeFd6mSGpiWUpKorLJ/raHebErvBULkXaH/O+ufxZueW0M5fiMVJIfFQQteVF2BMYk6Tg+3oA6BFA99tPC25GExVsB66ajXBaIx2NIV5K4UkKpnNJ0EcDuVlis4zz1qLf5IVDHaeAjKkgS9ZloEJgU/c8UpOINUUFmDlvA8ho9BSqbWvMWpTXuKmI7APaQ6vFlCfSn/+BlY5EuKir8YMwFvynOjTGy3Qt2apmNBKj7POaNiH9YlICUdOpWawshEyEShW9Yy1XN3+qmL/DRCuSiA0ePfy/bTnuwMXV55Jjt+cJgHdSz34Tx8Nh3TJRJsAlN3xvj+Q9PlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e912f-87f7-40c0-8e32-08dd8c850073
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:01:42.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPbhfpMcG7bCbxo0L2yaaX/lyBYaJzxVureSQnYK9LAtzGlJucYB/rGl4Qo3NlG95mPEnHb4sPf2ZC2RQHplA4b1ER2aVJHskuQNM0SayW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF6170ED89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA5NiBTYWx0ZWRfX2/07yLVXNEli pjB+aGw4zYC+R1Hr1y/45PA5lgLEJH752OIYSFSELAOYId9pSy68pOnaqQikpV6T+1D5U7GufKK CJTI8PMg3AJhAxCdXZzxKJLZtEo7qFfm1B8CxnmHYL7Ofp8l8/inMFP8QoRscPaEsgx/Kn1m/Q/
 kaKjQgAeywOUb/cS4OeuSj0POlhh1jLxxMbXuZP2/W16B0K7KkvarG68HRXwDgMxxCZMPwpouaI NaQkPfQOts9vGzXmkJ6Z19tHCnsFxQAZNETZXHPWJ8sSKFqL5OzcyoiYpCTEBnAcSGGOu3bDWx2 At1PSsoA8GgtOVRYAHFNem7ju0E91rcPhN9ZOyEkzZcACr2EXSsJP9WFaIwyDEwP+j6Ny14kF5M
 jk9MfGTFTUzLZFBE6fYGbHxnaf5yHI0txSPK+LVqIHUtsoNQjqemoobCr+QIE4eP5S3elwO6
X-Proofpoint-GUID: mBrJ3yJoTJ0DNqIBP1GT6Sq26l48vil4
X-Proofpoint-ORIG-GUID: mBrJ3yJoTJ0DNqIBP1GT6Sq26l48vil4
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819de0e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Va0nHYGuEqRMCmU7iJ0A:9 a=CjuIK1q_8ugA:10

On Mon, May 05, 2025 at 03:29:08PM +0200, Christian Brauner wrote:
> On Wed, Apr 30, 2025 at 11:58:14PM +0200, David Hildenbrand wrote:
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
> >
> >
> > In general (although it's late in Germany), it does sound like an
> > interesting approach.
> >
> > How feasiable is it to remove ->mmap in the long run, and would we maybe
> > need other callbacks to make that possible?
>
> If mm needs new file operations that aim to replace the old ->mmap() I
> want the old method to be ripped out within a reasonable time frame. I
> don't want to have ->mmap() and ->mmap_$new() hanging around for the
> next 5 years. We have enough of that already. And it would be great to
> be clear whether that replacement can actually happen.

Ack, I am committed to making these changes myself and will be putting effort
into doing this (and obviously liaising with others along these lines). And
absolutely it can, and will happen.

This has been an ongoing bugbear for me for some time, and recent issues
relating to a direct consequence of the overly permissive callback (that is,
relating to the merge retry we have to do afterwards) brought it into sharp
relief and precipitated this action.

So you can take this as a personal commitment, and you know who to shout
at if needed ;)

Cheers, Lorenzo

