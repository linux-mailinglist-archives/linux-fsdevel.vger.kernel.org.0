Return-Path: <linux-fsdevel+bounces-60000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC433B4088C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611001B2684B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F4313E04;
	Tue,  2 Sep 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c8A4JV3p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WiKgztro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE543043C3;
	Tue,  2 Sep 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825724; cv=fail; b=pqYCxOcvjxbf3YmQ1+AvH4nr4JWDv/WaQ9T02PhXNyeiPnahLkB7Ix+gj72mYkQfP6m8y+q2JGplOvuC/at/QToXBtM3xNLvROklC5kvQ/7ox6qI+wNstn2js1tNGMMoC0t6E+WcCDQ13zpvPS+Vap0HgNSFgO0CE/sGqmYDFWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825724; c=relaxed/simple;
	bh=irmrxuGZGuXC1CirwafcEkmokle1WydyyaHHumx+d6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LlBZc+tED9JGaYzBY5qmXHh56100i8YBlbBs2egti2cYlQY4CqgYTl5/AR8sMmD6m1pAowoWeXv3ByEs3BkdBdjNWDJD5QtRf6oJQXGcA5cV7al6PldCKUtlAvgGWCAatvxK6ee2DLolZ1boqs1Quppu2PfejY0L6v0Tjezcflk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c8A4JV3p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WiKgztro; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dfp7e028611;
	Tue, 2 Sep 2025 15:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Igm7zpbn00ESE8LFKw
	OZcDuI4euI+U2b3e7roeMVdVE=; b=c8A4JV3pbU/hupbV112JKlZpYLdhU1JkD6
	1XDf/lExJrAwQbOf53L8GuKMJctpL+TCi3pZ+bHHBDbpLZ20sjE0kiBmm3iq7izA
	sqZ5BKC+l6omz77wodesXe/aOvgQieMgfZfonn0yXPTxjGQeba1e+dmo1lf0p+OK
	C86+slc6/bDzB/LRdfmxhSq+UYlRR+TrqSAD+i4CIxjuHarQpIo0d7ihRujZi0L1
	XVBRzrgU1vlXgo0pVSOQ4kPIzi8fvk18jTF00bKdPFC/HtOIOftwZk79UXQKvPQ+
	i0SBJTvCuUwzpk5gTrahq1K68MOCFgfS/mQx3kt50XK0pVcwh2Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnc9uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:08:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582DWGJf040151;
	Tue, 2 Sep 2025 15:08:24 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf9h6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jytnwhDzQtlWfzMfq7nJnlOjEC7cQQ1oeLhbUOmNc8qagzlzPZJkUx9YGfJGlxJSsMSGfp+6gP+SCtMEJM7P73JjOPxHWzPBpL6OQ+1/ERgcvmz63RTiRs7g/tbsihKEjcSnoSyruPtrSGLO8qjTYv7z8Cct+v72Jg/OhLW+42Ugb46IIR4Jl3jMZBlVZqwSeIIhmoc+ViDn/nsyqyxVPmdyKXzmgstL2LzenzZ8emnjzXnVR6/m8g3ekZOPVuBclq96jlRFPjgRoZRb8Zlxk1cYCumZNs8ExuEmLcu6aCp1q/94hBQ5UQoXymNCO2OwupTBrnjRC8aOdLOyPLIo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igm7zpbn00ESE8LFKwOZcDuI4euI+U2b3e7roeMVdVE=;
 b=RFhVmhrbGmDq8llfEd/zrevER+uSziFM4x8o489QtD81hc61HHOe1Z9bs05fdnb+AYffANs7/FU33fAbirULPwpfpGRMse5S6rJ7IXAImy4ZerPLs2yGTQDEbKVqTzxStoaJMn51xbhEa0xkirKfoV+sThe0ZzPC7bawF7w1wA3Ibi71bOviuHO5v6BTyRTLiTT1FznDE2hDvpoeMMDhj2JnxpqswQSc2o5aQ05QWKxRj4OZS2DzNV9eZ//EXoeFGO168FIEJfZ3jjjYu3OudMcgy+EwwhqLgH5KusNDRR0GL0EMaEQ9+14TPH8y9BvyoJBJBg/CeyjxCbX7D2Kljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igm7zpbn00ESE8LFKwOZcDuI4euI+U2b3e7roeMVdVE=;
 b=WiKgztroJHFKuGuq7wpIQ5ay1+gdWEpezoJjM3UlF0x6dkNNSihqpeqM+7PFPCd+fSVkqoFrAdQsoYwwbHzggeeUH8ODQwBd79q/D9hTpq36d1HgMFXo5RxfqV6nUQElbGbDPJJpWNwXodF6ZdMIZLhcTS3jf3/gEqGoOFvA5Fo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 15:08:14 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:08:14 +0000
Date: Tue, 2 Sep 2025 11:08:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <fbxu5tqrhtrvxznrk7xpkzvl4uz5o4jhb427vupc3u42x3u6mt@e5exfypuzzs3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c6b605-1f90-4b93-5fa9-08ddea328a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?882my8lZdWpMtn5NHy9hY1yCSy4O0du3/mbqaVQyveCo9ada/SO5IpLygVR6?=
 =?us-ascii?Q?Q3Nw5QiEb1BVRoa3fMVH864GXdvmGI0123I35mjLfouxiOZu0JU3SOSm/az/?=
 =?us-ascii?Q?TAU1HAFWaR7lB7gWjYLWmEw3hAjIdwS5vvRLmfkd91l2f9ix+lEwcgyTL/Ac?=
 =?us-ascii?Q?EgwEPpW8dlOrbcFvOWdvcqO0T4WvsbZKyr2RZIj6WKb0blVgbpQ8EIyDW+Rj?=
 =?us-ascii?Q?RmWMplx1PuNYeBX8vgaY0R7lcEaZDCcdBUQiPoFAeGhmGm+9PIGABb6LdV9B?=
 =?us-ascii?Q?W5BrCdZBV5Ra9lo/WHDm55GipgTJqcvR7P52RMP5xGde9mKkVHcf9BwN1wb0?=
 =?us-ascii?Q?QUS1+O3FJHY00LFzPm6lj+XlA1Q5CON6S9YOl0GTKuHxLvDwFJN211HBnoGO?=
 =?us-ascii?Q?JSovbPcX+hAT1I+UX5ku4sn0uDUFznEScK7FE4xW1nH0JhPPyA06QD/qQnb5?=
 =?us-ascii?Q?YBMdL5RtcVl/ADoJOa1pldRXyiLusxtHG8KPdlRCiF5fs0mj4HeHcK08HaDG?=
 =?us-ascii?Q?9Jcv65gkbKn9tT0aj8cm776iwbFsOR3ZUBuw/NefBlCK3jzKkSPRfs17UKD8?=
 =?us-ascii?Q?0ZhkUsGgyNnJGza2WcdO+IqgpPrTiPhETEvJZzN9d/ikaxSkhz+qsweMiHhg?=
 =?us-ascii?Q?EpX9ueqWlXILEKCNn8cPfpbe5ddH+rjzA8zPghL5VxG2VP51SiSFD+ST1+9c?=
 =?us-ascii?Q?WckFyfq/1ixg6MXCkEt1RVIsBSEcyvbSEEwxEA4lo8IXzlL6Hz4CUF2ayVFK?=
 =?us-ascii?Q?s/NSRvfeYl93CvGwVhB0TmwhonZ/IvIbKkTE3DYsq6/ekiHkCZsYo6bFm6dp?=
 =?us-ascii?Q?ypbh45XsqEkytF71Ky+onEX01m+jMtMnRAngm4CdNuFEMB5JYqLZFFfFK52U?=
 =?us-ascii?Q?xEGQ+3FnE5i6Ulk6YP/4jcLctNd0Mn1+Ua6koUOItz6oS9ZDjvayiNO9YEaO?=
 =?us-ascii?Q?cPeGX3Zd6K7nKwN/cMK5S4HLQHXwY6gAk239nF3btppA+uJ2zfTcy1Vibo9U?=
 =?us-ascii?Q?VN9fTKTsETlORrM7ISCu8uxWISHdqw90CrC/KvDsdr7QwRMQ1CZPPJa7Ps+z?=
 =?us-ascii?Q?hghZSpDLfuwBXARDb0VW2FGjYxemlyzg+fTlnlwB6z3iHs1mZfS2n8NJPwSS?=
 =?us-ascii?Q?sUV6sl9nYAMkb8/lWuPdJyhMibcpclJ0NBlwrjEp+2/508R94Agh3yAHvXLZ?=
 =?us-ascii?Q?/SU6GHe91tL8FfinWSShFsndr8rCOEAUzoVGFT5JjUVHEoSMZQ2esZvNS+F2?=
 =?us-ascii?Q?INJzlG8RFuADNRVYaKr6tjH/YKd73M7qYDa03FtgMmaM57rKQqunTM+3Z0hC?=
 =?us-ascii?Q?YWQyDBEQ96nvlj50BXurk5kaTO4vqr4Vo+/5wAbgbu6XuFondx36AXL4r6Rh?=
 =?us-ascii?Q?/voApvfDVIf/aItCWRzQTWTwkfpSqUN9ZCnFXIKaDcmENeOeh6fyhmYAs4xg?=
 =?us-ascii?Q?p9HPsAiXJqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NubpePJzBdFTQG0S+hdD0AdkbNZ0Zedso0ltSRHrQd+N8qa190lhvqTFm1cb?=
 =?us-ascii?Q?vhw+kOHEDPCvUw/BQIeVzgmfnFZRjzXToS391XY7Y/uMQjkFe9j1jKv2kcxw?=
 =?us-ascii?Q?o2gJLmCs4alBVAcDTB3Cl5DwsGm6nAjlYBIqvGlsU4C/lUKVtcEHZdMcJ3ta?=
 =?us-ascii?Q?YltDlcHRyEBRuhjRMsvWk8cyiufNIHFoBvmWMFuDo4YCfd5Lq4RVezDXWnPf?=
 =?us-ascii?Q?qsGZKxPIVK49pCj+oy0jspGVxzXESdZtgM4bFpY6MYGZXLLK0+6bTmhAPej0?=
 =?us-ascii?Q?9hoonCF4AByAifojA9FAG9kQcf8neZ9D3dgWmM4bPppRo4jN8/MFTHVmz45a?=
 =?us-ascii?Q?h4eXj0wskX1oKc/f3IVqCg9MCm1rJQxgsrkkaH+fGFNENByvJUyjiGS/rF9/?=
 =?us-ascii?Q?gTLpgP2Lb93niPP59VCOwYPpjBNZ2AfDaxevefUb/BWCkgXN7UgsRmEqFgdG?=
 =?us-ascii?Q?jnO8iAtdDFd8O8yffoJk8/blTaSM9zf+oKN2KO2kKVxfqIoQh2Xb/maPRf3V?=
 =?us-ascii?Q?5KixQTQ7wAUIeMVHfTeJBehoaF3VJ6Odgkk4qoWTaZse6OJ8ygIX8WtVN9y5?=
 =?us-ascii?Q?GlZ+IElQ/f3obKjMjKIxeQ80EZA1+4lK7EUrmnTT74IL1F1HaxHtYOWJ6vLw?=
 =?us-ascii?Q?qnkxifnL4GoQAIOy5gkufAIM9R4+nWaTmmB4QCQvbccGbQXwQhk90XkXQncw?=
 =?us-ascii?Q?F0/k1V6xux3irpI8IPetDevFLHYTElxXxTGI37dugfx6Yu4O6Fcr2V6rJ+3h?=
 =?us-ascii?Q?D9ZpeRdwfv/EfAXn9r98ICSVAYgRuo9QySTH+KNS90wM6CLcOe6kAsWeplYL?=
 =?us-ascii?Q?++AsVmhsKN5t2Ok6mzRIMEFFQ5uwvXsfR8guwQzwMDwBxtyvydLDHcqGyio1?=
 =?us-ascii?Q?1VNB8OURMYNK5mNDsvLpER+f+PBryFyfGoiOwt3E8h/nr1ufj7Pw7I2pDLss?=
 =?us-ascii?Q?ZVGLNtxBQMQb3Pu82wx/nTi1M7kq9+0+m5d8rMQo6JTIxBKZ1RPGBmz9K97h?=
 =?us-ascii?Q?Hnnd41sIsM4CzX1zqe7bbOs26XkyU4xHU64aSlRuUTVTBTnylH1DTCmSxZER?=
 =?us-ascii?Q?LTtyc8dS+UxAHk0U7hrgX5AQU1zjuKrHk4Ot+Mw11BAFnbYU0YSLkj0jKTos?=
 =?us-ascii?Q?FARRr0Hiv4lmkiDGSjYSu+xEoUmR7s1vBxZhjJ22tkcTdoUXKdt+hmI/jyHS?=
 =?us-ascii?Q?cJZxCkNdd4SJhp0sB+bFL+vPyNZjHC8oWS3ay2FgjrXahyFsrfEqmJN+Ncbx?=
 =?us-ascii?Q?tCEV2VqLG4tx5FDWYujO9FtDSONp1Y5McHR9fkWyHUUc/ySKRArVNCjc2uwb?=
 =?us-ascii?Q?iSOmWZ/hbCAENvHrZ+HE7pJWqQtS2go58er1z8xb4vfVYhBzZdyv8UjDr5pN?=
 =?us-ascii?Q?TWmrE/vGU1maIlHuhl9p2DPdX7IUF5Q36M7t/zMNzRqJE0+5+Bmg/Wf4UVgT?=
 =?us-ascii?Q?+VyByW6gmk0CPhpk00hdTgfia+JXc1HohkHnE++TQU2PKjqUtB1ptHFxTXzC?=
 =?us-ascii?Q?Pi+tHZFYMnKUiQyiJoEFhs1yK5gmVQRyr16O5DVtntVLxret2pZBa52eI3Ns?=
 =?us-ascii?Q?ytccLIMVYT/cvdJnKVulH/omL9pcqtAQeirW2XsD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lG25ECWq3MS3wDnIe4dERnMynJ85lQmOKf0FG0ZxrjG5bcTc8lg/CWI7VODTssYqfi5PHQqctudLvA4qz2NNG5xY1nMptbV1WX1ZgnpKn2xIipcN8Mnu2DBFvPWdY6fYNZXn28gjk7Tixbtpqt5ladQ4o6PuqGOP3nCDVf0VyJrvxmPZRKz+Tr/zXJSHY4ODwlcHD8KhI+OVmevZglpUcJrSpngHo/EVAHr2YJ0RfDfPViXVYZhuMtVaKNsGXSiRsr/8a2WW36/PNcAMrxwP76WdTK5dSE0zsFBZKsKROqRBP8hvrjy1H9RvKv/s1lfQ2YcGEvbvgQ8kB4U+rurjMF/HNTUOTox641aG661KCGzL2+s3CzdTKF6d91drI4KcQJAQXdczMoDGrU2Jin/QkHFo5rc6BkfcJWNiiyb7bsrUZRgkgjtu1ML83JVqhUjJfbEs/fmBO3H1n4KrPgmrr0/g+69xMUHIZTADc4e7DTTVxfMIm8r5zPmQOu+zL7s+Dizbr/M9LLyZyTO7IhJ/PTJnIBwwPEw6FTDXh670VhjQPXQpIsyYrzMsHuM58kc+p4u0iKG6ViIqIuEh3ULmYn/9fbvqD198oU01CheMXPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c6b605-1f90-4b93-5fa9-08ddea328a25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:08:14.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oLn+koid95lKfp4seQLz3Y4hKV9xPxRW9Hn+ghiyYgcjvpN0GxnaeS2voN9BxUvGXswUwIAf6vDa1VyAH/3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020150
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b70869 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=XXLuw3lC2WaUIAsW-tQA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: ZnTq9TibBuLZO5nf_CAnyE0tRdrGAq_J
X-Proofpoint-ORIG-GUID: ZnTq9TibBuLZO5nf_CAnyE0tRdrGAq_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8PDrSfSbyQEe
 ClV3PVQMSkiTFRF26CpuUGYc268Mqsmf51ZwEBeg3ao4dAudNX4YVH/HY3qKdJcr3sAnkE9tAYm
 Tmv5ZYkBJ+Nv3PgBpkHb7jN4a+ebJ7+Mkw5eRmCqlVHj7kFzJS2Zuv0DJnPDQl3+o6lQkMoc+q7
 V83s6VXzcDUqHLBePGRSnXwoIn43al0Z4Ifv6ujdXZXJM7lQYE++5OnMdeEzCmkTJ/BzSgOOiGb
 jJ7N3ouy/Dr292F+5K238tez3crS/2J7ddCOFjw4GPhTO0XymgFffh4tqu7/ctWMeV33PpL5gan
 ofRfI1BXzLP2pW3fzz3ZAKQZaK/jSABxuO6etIJYCbf2yAAWQzzkW672DqKWLk5UZ25h42B9i+3
 VRb5vkggqHp9QKKuk4eJwBA2ozjpiw==

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250902 06:46]:
> In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
> nested file systems") we introduced the ability for 'nested' drivers and
> file systems to correctly invoke the f_op->mmap_prepare() handler from an
> f_op->mmap() handler via a compatibility layer implemented in
> compat_vma_mmap_prepare().
> 
> This invokes vma_to_desc() to populate vm_area_desc fields according to
> those found in the (not yet fully initialised) VMA passed to f_op->mmap().
> 
> However this function implicitly assumes that the struct file which we are
> operating upon is equal to vma->vm_file. This is not a safe assumption in
> all cases.
> 
> This is not an issue currently, as so far we have only implemented
> f_op->mmap_prepare() handlers for some file systems and internal mm uses,
> and the only nested f_op->mmap() operations that can be performed upon
> these are those in backing_file_mmap() and coda_file_mmap(), both of which
> use vma->vm_file.
> 
> However, moving forward, as we convert drivers to using
> f_op->mmap_prepare(), this will become a problem.
> 
> Resolve this issue by explicitly setting desc->file to the provided file
> parameter and update callers accordingly.
> 
> We also need to adjust set_vma_from_desc() to account for this fact, and
> only update the vma->vm_file field if the f_op->mmap_prepare() caller
> reassigns it.
> 
> We may in future wish to add a new field to struct vm_area_desc to account
> for this 'nested mmap invocation' case, but for now it seems unnecessary.
> 
> While we are here, also provide a variant of compat_vma_mmap_prepare() that
> operates against a pointer to any file_operations struct and does not
> assume that the file_operations struct we are interested in is file->f_op.
> 
> This function is __compat_vma_mmap_prepare() and we invoke it from
> compat_vma_mmap_prepare() so that we share code between the two functions.
> 
> This is important, because some drivers provide hooks in a separate struct,
> for instance struct drm_device provides an fops field for this purpose.
> 
> Also update the VMA selftests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

One nit below.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/fs.h               |  2 ++
>  mm/util.c                        | 33 +++++++++++++++++++++++---------
>  mm/vma.h                         | 14 ++++++++++----
>  tools/testing/vma/vma_internal.h | 19 +++++++++++-------
>  4 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..3e7160415066 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2279,6 +2279,8 @@ static inline bool can_mmap_file(struct file *file)
>  	return true;
>  }
>  
> +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma);
>  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
>  
>  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
> diff --git a/mm/util.c b/mm/util.c
> index bb4b47cd6709..83fe15e4483a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1133,6 +1133,29 @@ void flush_dcache_folio(struct folio *folio)
>  EXPORT_SYMBOL(flush_dcache_folio);
>  #endif
>  
> +/**
> + * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
> + * for details. This is the same operation, only with a specific file operations
> + * struct which may or may not be the same as vma->vm_file->f_op.
> + * @f_op - The file operations whose .mmap_prepare() hook is specified.
> + * @vma: The VMA to apply the .mmap_prepare() hook to.
> + * Returns: 0 on success or error.
> + */
> +int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, file, &desc);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(__compat_vma_mmap_prepare);
> +
>  /**
>   * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
>   * existing VMA
> @@ -1161,15 +1184,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
>   */
>  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>  {
> -	struct vm_area_desc desc;
> -	int err;
> -
> -	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> -	if (err)
> -		return err;
> -	set_vma_from_desc(vma, &desc);
> -
> -	return 0;
> +	return __compat_vma_mmap_prepare(file->f_op, file, vma);
>  }
>  EXPORT_SYMBOL(compat_vma_mmap_prepare);
>  
> diff --git a/mm/vma.h b/mm/vma.h
> index bcdc261c5b15..9b21d47ba630 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -230,14 +230,14 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>   */
>  
>  static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc)
> +		struct file *file, struct vm_area_desc *desc)
>  {
>  	desc->mm = vma->vm_mm;
>  	desc->start = vma->vm_start;
>  	desc->end = vma->vm_end;
>  
>  	desc->pgoff = vma->vm_pgoff;
> -	desc->file = vma->vm_file;
> +	desc->file = file;
>  	desc->vm_flags = vma->vm_flags;
>  	desc->page_prot = vma->vm_page_prot;
>  
> @@ -248,7 +248,7 @@ static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
>  }
>  
>  static inline void set_vma_from_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc)
> +		struct file *orig_file, struct vm_area_desc *desc)
>  {
>  	/*
>  	 * Since we're invoking .mmap_prepare() despite having a partially
> @@ -258,7 +258,13 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
>  
>  	/* Mutable fields. Populated with initial state. */
>  	vma->vm_pgoff = desc->pgoff;
> -	if (vma->vm_file != desc->file)
> +	/*
> +	 * The desc->file may not be the same as vma->vm_file, but if the
> +	 * f_op->mmap_prepare() handler is setting this parameter to something
> +	 * different, it indicates that it wishes the VMA to have its file
> +	 * assigned to this.
> +	 */
> +	if (orig_file != desc->file && vma->vm_file != desc->file)
>  		vma_set_file(vma, desc->file);

So now we have to be sure both orig_file and vma->vm_file != desc->file
to set it?  This seems to make the function name less accurate.

>  	if (vma->vm_flags != desc->vm_flags)
>  		vm_flags_set(vma, desc->vm_flags);
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 6f95ec14974f..4ceb4284b6b9 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1411,25 +1411,30 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  
>  /* Declared in vma.h. */
>  static inline void set_vma_from_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc);
> -
> +		struct file *orig_file, struct vm_area_desc *desc);
>  static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> -		struct vm_area_desc *desc);
> +		struct file *file, struct vm_area_desc *desc);
>  
> -static int compat_vma_mmap_prepare(struct file *file,
> -		struct vm_area_struct *vma)
> +static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
> +		struct file *file, struct vm_area_struct *vma)
>  {
>  	struct vm_area_desc desc;
>  	int err;
>  
> -	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
>  	if (err)
>  		return err;
> -	set_vma_from_desc(vma, &desc);
> +	set_vma_from_desc(vma, file, &desc);
>  
>  	return 0;
>  }
>  
> +static inline int compat_vma_mmap_prepare(struct file *file,
> +		struct vm_area_struct *vma)
> +{
> +	return __compat_vma_mmap_prepare(file->f_op, file, vma);
> +}
> +
>  /* Did the driver provide valid mmap hook configuration? */
>  static inline bool can_mmap_file(struct file *file)
>  {
> -- 
> 2.50.1
> 

