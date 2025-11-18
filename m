Return-Path: <linux-fsdevel+bounces-68905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93058C68062
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDBA43839BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1B30498F;
	Tue, 18 Nov 2025 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKvHpOH3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ozuQcM/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D62FD1AD;
	Tue, 18 Nov 2025 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451243; cv=fail; b=Oyym+mzFol/qg9o6D3cXnGtaRe3MDrXem/PPYboh9b4K0GI9/PFtL07UAqaAdacY4eVfTKSbNO5pYVXVJFGIH3EgHs26NpU9RngclZkHnffdEeXUe3Y3YEwiwIR0i3/8VWt++t1v17p7+WTCHD2PLprXyRNOuXd5AA0j9oLQF0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451243; c=relaxed/simple;
	bh=UAXUwfd+i7WF7Ir36GiwPryliYmAx6a1ym7AekiDDWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ksavKDy1/rp66V57+sJvmCn/KhZVCr+ZQ6cpJKu6WbV6/XDnQ+SBwExOr8YDazCwTcRz1C1B5uijvO17er7GxChfqGoJD6qz9Wof25n/Rzef9vZmqIydYCZm9sWtc8KEF4vFXwemdjEsufX1MykXogUb/OTRDjI4YXjELMsKYg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OKvHpOH3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ozuQcM/O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6NP1K001881;
	Tue, 18 Nov 2025 07:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DrmnSujz/deh49cFYj
	nnCeBJ3kgeYiJaKBEXVFh5DK4=; b=OKvHpOH36Kn2SzqMoxYg3MvqThdNTJPJR6
	wFFWIiqtBj8siyXYwkU74cDr/kg7E5w4v4AheY/cB+oo4hFDUgus0EoygHjb3qJn
	rOvP3bl/p99mYtsZOKlv3fr67cR3kO5mMoO2lU5HHMrPat2hSRRSKw3rl/35AeEy
	carjCa46Pz1n6O7g9nFE8kqI2bErLf3u7qEDCaD90qhxn508r4G0Bj/afFPF7Upu
	FvPp+h20587npIQWrmBrOrMKFHfiIQoY4sDoARThnW0rdmJXotcVouszYHiu73JB
	NOYD07I//rZdCIkEZy0kpoxHizwMaYsbYOzxnzaLnmHeQ9aGu+gg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpv982-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI669FJ004363;
	Tue, 18 Nov 2025 07:33:26 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8hfwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp9L3XuuLuf7vG/4vvOH/oTRBxySB2JlDaIM2WSBhgQiscLjmtsMGojzTksKxGpRrpu0/sanMo/uRI3x2uQx2lPB10XwwYscyvpWRUkH0bpQaYa94V69wsXJULxhlD71x3pTxTOha8NNILD8NK9taDq7j/0ip1bY19d3O9nefVSLeIptCB63JoCblVjv7hvBZmS8GOc/+SAZgRQRIOLe2jTRJOjZhNMCps3wkLLbl3tHqM63QkwjvD+095vywj2+cTcDi1e4wnU3EozerjmRp57x8/yLKZC1Piksf4ABVByF4f7ykWpviAk3tLOnq40erA8VIG4Lbyf1MOQ6euMdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrmnSujz/deh49cFYjnnCeBJ3kgeYiJaKBEXVFh5DK4=;
 b=beNGAyUnTM4hVIKeZAW4SOrILgrtiOPe7LiARAZnwvVWTfwtXr0FuIKSC7tlyeHbzFdRpZy4eRd8yFNA/+kieFbd1Bv6SFdb7V9kC/9g+iwEnlTwcJJf6wXMbTK63YOPZZyK2EL/uEmIMk+NAn5dcoLc1+Oos5/oukgsxIvps/h9dnulZT2M0Mi5lH3YqkeJGcl2UBaivOKTcP3xYML7BK942Z6n68l8VbrUsNeuc2+RmpiY8iW8cFXp3lzpDrWr5l3lE2hxBWFeq/akdr5BrAiT+fJxXYkU7l6Fsg1IjuSVHx1xwZyMVxllX2hvchAmeS7lN+UBqz2onFOgpO12Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrmnSujz/deh49cFYjnnCeBJ3kgeYiJaKBEXVFh5DK4=;
 b=ozuQcM/Owafl9Lf8sTmpI4wlHy/Qg+MAKRgrtBZLBjLgBSAHAJWoe/03sqLV/AKGBMJgLskg1Oe7MHu2WN31mHfDQqrNp96a18KKdIVc0sKVtMRyEgqpCqUVSySW81ZWvilYN7C/f+Vd8lmP1MaYq0r/g6SmYiFKMi0UYd1ENDg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8634.namprd10.prod.outlook.com (2603:10b6:208:56a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 07:33:23 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 07:33:23 +0000
Date: Tue, 18 Nov 2025 07:33:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jane.chu@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 1/8] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <6ea6d33b-be16-4a00-9b0b-ce4a5dbecbd7@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
 <1c4b521a-f84c-4a3a-99f7-ecb9ace3baf1@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4b521a-f84c-4a3a-99f7-ecb9ace3baf1@oracle.com>
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d03e4dd-e369-4a46-4909-08de2674c0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHW6zXGAd6SQEQOGfdrd+qTFJhYFkVMvgAGrg16D7ADTqolsjXXsQ7y8qChc?=
 =?us-ascii?Q?sHN4xh+xZCifqulEw2d5GePDNcxI6gVZh16ChqPKpP6Rnevsem9SCub08x6W?=
 =?us-ascii?Q?MF6W8/2L0AuBH8OEiKo9v/NNT5nfg4b9HZ3zoHIgBMdN2Uth7Oo5sOCJGvHo?=
 =?us-ascii?Q?3wh+icfjP4JIHFSB1qNGsx31/74HgcXzaOZx+FXElXF8QFKh61xYVd9NtJOM?=
 =?us-ascii?Q?o0nmeBeu5h8et2i5l48svw5mXvzmhs0Q0n7ZkKCZ20z76u19b7n7KzSt68Rz?=
 =?us-ascii?Q?Jvbl782K0XHwsD62q/pvUsUeONcZiOqJZ7B5U7eHyQmnT8ykydwkh3wuENLj?=
 =?us-ascii?Q?SNOQ1d/YYpE3J1DJH2a0OAaj94rR6exjWXXSWVzYAQGiz9733UZNTXait2F8?=
 =?us-ascii?Q?TE1V8ULO9YoN/CJYpoXxwNsIWE19nHQkB/NS6TN4KovIM8Z9W4WKQwoRAGVS?=
 =?us-ascii?Q?d27bZcQwvNdYLBvCB04oRMLsJxgeX9SNqGDAoqc5JXPV4ym6rtHxaAITv0sp?=
 =?us-ascii?Q?tNxpHXQrjCa7Tcs43yZYXLSPwPzQYR0SujkKZlqQ69nYsUogNtbG4xATqIM2?=
 =?us-ascii?Q?7IwS+IFbQvvADeA6XurXpBLfIefVgOo9y7Ceudiz+AniTYc5+MuHLKteTdOd?=
 =?us-ascii?Q?GOtpuM4WiYLp88rsXWeAB97Kz80+BR++dwZnYHKqrZn62R+Lok1Rz3JkBl4Z?=
 =?us-ascii?Q?Ur3JHYOwnYSNn+8vzM8ytOXBr13OMI4uNw21IzIukcZHpwnCwIpCHcnZqBtu?=
 =?us-ascii?Q?LDQxvWr02L3TuVVYoJUNX2zXUsrdX8jiQEnOG0yIlSBBi3n20evPZXGUXnla?=
 =?us-ascii?Q?iriR2bZPH+3aQSg080iz1JuASfa3PwPVkt49TKWuSMIxwpAMCaYUwf6++L+/?=
 =?us-ascii?Q?3tfrLyiKnCgitET6S5rn3aloYGCyZ08oHxJB/yqAwP467f9ZX/oVhB3t0g7E?=
 =?us-ascii?Q?rZg8NOj281B/ugf7JzZwPWMtdX01WeMDrCeJbNLRJ7DbMP7r2gl5zLswO2dC?=
 =?us-ascii?Q?dIsg+BlHFRGtpglsdDneS8/C0SM6Qo4e9OqhpvFwQn1BdyEHL2xBU9Gk+Y3Z?=
 =?us-ascii?Q?EesfVF0NgEuDV9sa6z/R6J5gKKW/qeiEY3AyptmhWQLEp7moUPuCqQ1J/Oim?=
 =?us-ascii?Q?DS9HDJDd1Y3F0MULGOcki8SQzV0YnENLdKNPREEx0SMgoKxojvtYt/rYYToj?=
 =?us-ascii?Q?Qc0kEPueVX+SRBzJslFqvTmKOZnJBi3FB2OIJN+gDk/89ZLHZBT770p1d6Dh?=
 =?us-ascii?Q?Q0VqmQfSg4jQg7NYlmOLUvSTeMxvh7YeMwuBfQISAkgGx0s0FRAuqLwTF0wl?=
 =?us-ascii?Q?tOpNKfgUC2YTrJ8q/QZWMJz5Rb2P67AZx+LtpJSurbOAPATFsjchWYCQ200B?=
 =?us-ascii?Q?ejL/uG9LikE+rQeTFW0d4nG6X6HZ/OHPD6HRDGehtG2uQpIdy/VF5cbPBwdm?=
 =?us-ascii?Q?cLB1JBREfMaRSAiH/yyPs/Wyfa04CAEy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOxa1TE43NZDhm1Jnl6lSMtwY03cuoSce8KmAgPV4Gdbqk9hOLhTwvPG8PK2?=
 =?us-ascii?Q?Xj/zfZlSgZdZXpfTeHy/GZAugIJtWcM9uhp07+VCAU0iV14Zap1ZdQnNWrSH?=
 =?us-ascii?Q?tM8Q4+z5e9U/2juG7wEcCLRuJEzMgaYUBdAL4fHIX2f22e6SJ2YmGY0Ew2xn?=
 =?us-ascii?Q?7JQRNOt+M4xAjMF7pvc+pD75XKLVS/H8+45ip2jQ4qfFtf8WzCdt6wPYMaM7?=
 =?us-ascii?Q?U8GimCLR6fJXBl1yh5tUBH2z7n/kwZ2KqgkcLdDsrpZJInZ0Icd7rS155USM?=
 =?us-ascii?Q?2v58B6z4lRWLec9IYe27W7pPVM1J4wvzHOF+RSd8WcWdbytoBGl2tE7I/Ew6?=
 =?us-ascii?Q?wRoJAEgnsJ7olU0cNXP4byYcmEr6Nq2DdfRi9sIaV5yWFKyXYVXldoVNjMHp?=
 =?us-ascii?Q?LANCJE/qHZXWsbNS0ASe/bax59+LgunYyMqxaZ6QLxe8XeeCMDaxibGi6URb?=
 =?us-ascii?Q?dDi3NPNU1tggmDgM2SgyIzWpI4nQZBgf3OAYpMEE25NJ50WV2KAqLKXFVn8E?=
 =?us-ascii?Q?o62MMeRbhGXZ8B1CQozaohmZrFay3dn0sJcNye+5QAt1Y0OTcfmS6GGnb+C7?=
 =?us-ascii?Q?j56TlpOvc+VZoOiDHzrK2IFlG5C0OoajZJQ8GG6RF+wvQop0qgGtpuVfpFNu?=
 =?us-ascii?Q?22psjNjy/xXG1wMObMmN038zdwKGxBnOiZjwCDtZ5Sd2tN927CCaNOZutoRo?=
 =?us-ascii?Q?29n+w0uU+v8dYjQ3fVZeHBsIcNHAiTSCEdb8CAYbPrOId9XzTaathha2NlBq?=
 =?us-ascii?Q?ZRNXwCj5x9KqG0EMofkRB9iRslDnNci3u6j0dZtEJX5hKLiYeh0tUht7sskM?=
 =?us-ascii?Q?OlQNu8tOal6TR90mlZzdsFrZwFP0hMNERhe7PGAk+OEpdRYPaDmZ55Pqp6LT?=
 =?us-ascii?Q?i7DD8Q4s9yY1jxKBrbZYjh/2oTrGPinCxSzdWqtO+EVpKXx0TptuYX7R+wVI?=
 =?us-ascii?Q?v2DIa3wmbungfaCkXKD3MxXmr11WNudvt58y7bOK4eqIak+oJAu91ZzUgD2V?=
 =?us-ascii?Q?AZIbQEV0HcndudHJD4ihykahGOj4a99SOFboWGMG4kSebdKshITNc880aXQh?=
 =?us-ascii?Q?MfO0n1gevqjr7tfL2Mry34vMK7O2uDG0m73KX/YcYHkNf0FCfyWE+zIqBwsL?=
 =?us-ascii?Q?MZ8Fwd4n/njiZ2oVj/32C/7LxrziCgdTB0iyq3T1PYTLRY2O7MGRMBMhjdWO?=
 =?us-ascii?Q?SCOxFEhxKZg+U/Q7DSRzNTqebqQBXMFzuWdhcl4VV7FfizqafGm3S294Itbl?=
 =?us-ascii?Q?y/0iWth/BzBCuH7g5oMJfi18xTypmN/PFgsLLDMEzvWE2k7eAP8H/TCx0qhq?=
 =?us-ascii?Q?jC+RCDWbdVfQYTtxmFXmw7mVA2AucHmmLVqk2a0mxdr/pywGmg3ldxIHy++E?=
 =?us-ascii?Q?mOmIT1qoUpx7fahKrCJnmXgTgw6CBxycYcpPQnkb2Y5IeXU0RDyWH1nlwStQ?=
 =?us-ascii?Q?8iqz9pNXkfU9cjMMqK7IRDoKsQlPGXQiNzK5CFOTkdPV9xrsxcoWruPAcV+G?=
 =?us-ascii?Q?R1L/9O0gfKkvdKSgHlkLTICODPig3oYXRhbAQLvFJsGKYDju/TzXJOagMfeC?=
 =?us-ascii?Q?Ej1cTitCmlRDBqyo4l1GjoFoRJZed0BAFx72g0Zo8UVOJHszwkMNNz/C8Z3e?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aJUSwD/VRCYXVD2CQ0n1GTukObnQCMUqojEcaNktoQeSn8g9FjamAMKISlGgpXgImKmpN43yVFGHaV7H7UwnvYqOcR6BPmbNyZNuyy0UtZXuDGMcSF587Dm7r+HjbNjJec3yPi4c2oGB8oNdI81VQNqJ3QrahUrWFNZf/TnwEPvxATJIvCd8SloUp2x4APTTHBQh2Fc8/HA54P3qK5df2T4zzTVNCaOeWEhK/iR8DYbVTI8boHWoCm1nn2jA7ONU5FZa0SgpNfMPT/6VIyKmq1TkK+VE1PJ3NwJbc2J7WPzYAesO2OD1wOLbcUQ1NhdyV51/i4xWNLc4Main6e19+p5ibasVrgD81HjVvta3ahGFCshD/oHiBAi4lnOrf4HnYoXedNmHxR5uLeziT0h/HdYZPH/S8b1z+p6wiGd5d3re3a1relWXMzWQ2nYeLyxlcBl0AtZy3D05ZuSOxdrUqyqMwatrsC4haBk9SrkSlNCO66100GPU2SPEBZuYBTFvrTbu3Pqg5vgMxqjSUQ1SMy40xrmrmWBdtSTW0AxPffOl7FreUiqZFhRPs367NUa+KdyGmh2r07aiSaanpYglD6B8hgp7t1yfv+kKtHNRUKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d03e4dd-e369-4a46-4909-08de2674c0f5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 07:33:22.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74gmcQBUhW7+J5DTCg8N6Bk5WubM4cYJ67dRlkBW9RtUdThR9ZBGffc5n2vuzyDUzVZ9L/CFhxeBml5SFVOnR4oNoJuvQh4DB9uic2c0zR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0+1JvP8xSL1D
 fCUGOE7Opr9JDDLZkbQxYChYmKqEMTvl7v22le+ro9k0EDrif0eVrgaYW9eWiofyRR7rSDIbbZD
 JW/MMHBKvqsn1OKrtyjc0SRLw7oZS4KfppftKwy9M5LefcQKlEmRdhHjENXSEPPCWZXTlHMnGba
 KX9iMyXKOLR7zFi6LG93p9EEYzr+Z4XsOAxJvYYFNeYt/nMejIQDtYgF/2rfMt1Aj1sNFvdZ0UZ
 h5pV18zWIdr4klAfGyCrqOK7E5NbTYcSlF185/5HvdhXzUyY4YmkGst7DhwPg9j1dMt39Z9x+n1
 9YhFQsIr6kMQ2rzyPzD06hTwM5Dcn0mjFnvuUBZZG94scRovPoe+GgQfMGsZuEXgOz/ag1DXBeQ
 gJ7BrFOINd6oQCwvFxixmuGcAGqFLQ==
X-Proofpoint-ORIG-GUID: feu9JS-bZz63KYV8zJMT52cJzUSebpOv
X-Proofpoint-GUID: feu9JS-bZz63KYV8zJMT52cJzUSebpOv
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691c2146 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=CJ09Y-ZBmrjvR1qJUpIA:9 a=CjuIK1q_8ugA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22

On Mon, Nov 17, 2025 at 05:05:26PM -0800, jane.chu@oracle.com wrote:
>
>
> On 11/7/2025 8:11 AM, Lorenzo Stoakes wrote:
[snip]
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 046579a6ec2f..334732ab6733 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1480,6 +1480,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >   	if (src_vma->anon_vma)
> >   		return true;
> > +	/* Guard regions have momdified page tables that require copying. */
>
> Nit:  s/momdified/modified.

Thanks, Liam mentioned this too and I forgot to fix too, going to respin and
resolve :) I must have been tired :P

Cheers, Lorenzo

