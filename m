Return-Path: <linux-fsdevel+bounces-47536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD76A9F945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F643AB795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C796F296D3A;
	Mon, 28 Apr 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gem6D9Lc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uyh6/uw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D276C61;
	Mon, 28 Apr 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867710; cv=fail; b=BU8UUzEjQy0N91qcAKJc8mg+Kv7V0pGGLhRmaP589tnA9fYkKm99ZoKw6WbAdIL4IXmj4gNW4Fqv7PBZklenmsa9jR8pf/HNr2VVMCAfPWd/Dt5RDOwsSU/vO5ItP3zwUSyQAsBzQV/nbNlYE5yo6oVd7e58t46mgqdEoce26Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867710; c=relaxed/simple;
	bh=l+k/3IScMYQztaZUU6+qdjmAnx/4vsBKF6lwZgKaiXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOAoRthsb+Jt0GQ6aqFuFaDgLlzkWWHD1m64br+TguXlB9dB1/mEjF9nsah5oaSXazgi1j5cdHcnuXNaO4DwL9arNGXGgRoTU5ISzCq9k2cSdEpFkR77suwbDILD3Og5anKLZj1+z273xtKB/oNFd26ovywmRsCG7sHyU5H0ANQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gem6D9Lc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uyh6/uw7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIjmDe006792;
	Mon, 28 Apr 2025 19:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=p4tTx0eIGjoahuWGP8
	wfaenhQQnosD1iRiLDhEirANs=; b=Gem6D9LcGZ8keXZ4RuM0+DJD1gszwax6Qa
	KSeTXBed6Ub6WW3jHe9bZQlzGISGFPTk/bOkgXsVrQjMMUx3NsfYU58B0flizrjs
	vSwhnvCRGrHwIVYmieISPsKOgbH9vARa/fK/nAlz5kJLyBD+JogGyBECBNK3dUGa
	vT/nTlYnGk9HV/s6u40399PECdYud6oqYrtCVQouOBRg7R0OWq/Et9GbReGZmyJ3
	WbFPqE4NYd11M62ix/ZYl5CoxfpdRqG4vvYxCfe7xYc7v+XeUSRPpwhrkjaENMY/
	VrmVXfB1S95s+IOPe/2cy5zdJ2EmFPNct8f4pC77JwIyJTbhaL7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aenug4c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:14:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIEH4D035336;
	Mon, 28 Apr 2025 19:14:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8m4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE5500+7V/aypLrP6oPq5iZ5jZoryhopvyw7uX9tkUuXrnBguN0fBKvrPBVkVydM+XNaLsA6BF/EvT685XryF4cbIwnmEHrTzRUJE2d6ocF6g96p/5IlfCVD6q0b4RVzT8iX63b+1CXqR+Xt7ATc0hur26YDp5Az8J0uxRKSENigNd0FYDLRoJtc96SH/oYpLEoQbKFl/QFIPeTqkFlfh1WXVZ86xMngTtfQPJqEnXYLI0yJqXoky8W4KuytdbDiOAkprT19en3QiT/TPaRnnQZQIW5cFbqfTMsdMeaX9Rnzy3sDar55xo6c8ioOm7odcLrwPOXO0YIJaB8TaW85dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4tTx0eIGjoahuWGP8wfaenhQQnosD1iRiLDhEirANs=;
 b=DTuxR6KCdoU/kvVI77t27LP0vMjNL/qN+4Y5KtqSSNB6eqyYL+OpAuV84iu0o2Z2Qqb/TitzRUC1p5JLsPzILxXWRYG5r8iHoPJdDQOTD4nGbZTm4zpZII0tx2CJcaaSzy6293X/pLSQ5M09NKUOi0zeBdvaPYcXYFBdLMW6lMqjxzIyyq/j+VBzJ4W7lOlyp7m9qghKqgzYU7u+hgscXq2z+chzI3YadHEHOIvV/aapWeLjgEQEmZeabDY2mmjWEI5JaQuSYhWALaNiEzYlTD6d2s7mAgT/XoOgucP45eONX1w/5mMNP9nTcIYvTC6teYz7FTL8f1jSSSnMBPT8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4tTx0eIGjoahuWGP8wfaenhQQnosD1iRiLDhEirANs=;
 b=uyh6/uw7bdJtZvU3YQFpFurmXxKfxUCPDwvDimcMI+JF/7R6vs4EIWK6YISaVsWMHf3WZ2FhCF7DO7qwZAHabT2zhOwWqiD+T6OxEQksqfXOOjgG4vAtqV+qZ8FbuVXGflstI7FvrZPM0yDKriRlXnNZnr/ZNOTb4LqIUU/wvgM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 19:14:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 19:14:49 +0000
Date: Mon, 28 Apr 2025 15:14:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <v4gd5swog7nbzy3atupcj6apbg5k4m25lanyfrvx324w5pbkzz@j2brxlfhvptn>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA1PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: f987b757-e372-4f34-c8f4-08dd8688f259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+geNOMaG0Qk4hDsg4x2kRs6OZA5ciKjXs0sGTfLkhEoTeb0FBvQzQwxLXmil?=
 =?us-ascii?Q?o2Y5cB0O7pnjyhUeibzVQA5VDiPIAvYKRbUIwmHr6JED7a/bOGfR5e4/U3Ee?=
 =?us-ascii?Q?x9iSP4S7WUx+JDTmrskxvnX1VEZn7UboopqvbdGtYGLZthYf86LLEzY7/onn?=
 =?us-ascii?Q?dqurd+QptjQX1h15NS6ICXR8Jx7ACC80sszuR6Nd0P6I3wCD7XocOkSgmgXD?=
 =?us-ascii?Q?KHXaz2S75ajbwHGf2lno22M119uJHv7bPrie5k9+hEH5354hWHFeONvXbI2V?=
 =?us-ascii?Q?+tm9widOZIYQlpPX5QWice7xVPF29sWZ3RisZf+5MrBjD5v0zNqulr4nJUey?=
 =?us-ascii?Q?4Zk2rZRNSKcEzNU4nF8IDiEqHTVCN0ObQrx2PoqU4UHFznzNGizWM5xfeD/U?=
 =?us-ascii?Q?1XPXnrBQNNKwrLviAnaz8IhhMRMLCPAru3YMKqxROWhCkaRXOWpTg4RRco23?=
 =?us-ascii?Q?O/FHJ5A5F2PuwnTIqn2Vkyn9Rw1rxZBzZPltSHafg1cUTIodHJl+ufT/6nCo?=
 =?us-ascii?Q?JxB5l2dM6VprN6Z8fgRzaaNSmrXirYY6rAK0mzppOPsFU6jRFbLAcTa+tZlC?=
 =?us-ascii?Q?z2hBJWU6Yhad8r5x3L9e3VpMJnKd2g/bibrddICfiEYbFwDyWabowyGh2WNe?=
 =?us-ascii?Q?xE0eUWtsZm3w3ZKV5r6lrTG+MRsw48ueSt9WE9RPTSgZwOzvCMfrCeg4Md6S?=
 =?us-ascii?Q?HtLah7hkevWQOqgLSrmlUXbfdxTq96HAylRJNHu3Q4uIC3di+hMeE1NOLhF8?=
 =?us-ascii?Q?pce/SZCqNm8ToDufNPUn3qx3/6zeBEizJmwU7sIyYm2Moa7E7pU1lNIav2FR?=
 =?us-ascii?Q?edowGkO91UppsqQ/IfReTTacW1bCt92RHk4KHrUQ6/A3rODKxnxx/1a3PctJ?=
 =?us-ascii?Q?BOYhvk70C6ZFiqFfs1hiPAzx73XwOUy6YVOJ9IIooOzFG7qPf2UclB1UDMC6?=
 =?us-ascii?Q?FmTQoqT/iMDeFsK149XbyWnR9K9heHdelG7b3YSVp+D5sKpE2jgGcFS2I8PM?=
 =?us-ascii?Q?mNEXFhpt71EBtFtVv3SwoPwtxNxp9OmXkWKPxIxS+I8+JGOH1/u3jXAZloYk?=
 =?us-ascii?Q?dAAi5KVKzYzqID9un+n5bCd9FCJAVv//8Hl+Z+FPxd3UO2V7f+JIERhX/bLo?=
 =?us-ascii?Q?9S1Io728bzI94F6+Uba4GZJ/M7z3HWuqeSCa2ZWmEa2cjYLyu/clCXWf76EZ?=
 =?us-ascii?Q?GQeR4Uag613VlDIq/AVcQFrTV1eV/AXiiePxBmGOlVz9fJlbdLHLP2dno/9x?=
 =?us-ascii?Q?LnH0xi9aCY/ANDwcu1OKucyIJ4MViYQhpna7ZpJEsgjtaG4ZwrSBgQwLLsJi?=
 =?us-ascii?Q?fj198Zt3damQ8tJQNqpzIX/SoodVHXJ7qoq12cjy81D8WtWX8ik/BbWwUw7o?=
 =?us-ascii?Q?OQ7tBbNy9cEzyVybkCFeR6XUJIkqubL7ypPFelciO0J+yaFK4kLgUUoAq5qZ?=
 =?us-ascii?Q?dVCrp4jjXqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDwzhrFKDTI9/Il5jVf620/lOf5BCgy2b0GJht4ABQiKQVo1ckwDdKBVO0IN?=
 =?us-ascii?Q?m9CuwFuRoG5nVX3zfx5cw+9y4kvu4qt3E+ZxcexrKeHuQnPjVou2L4djHKDL?=
 =?us-ascii?Q?8xpeFU0UM+YuspUz8fAPOwqbLl/wS3eHKT1JWu0SwOOGfNDoUsW3GHCRvxGn?=
 =?us-ascii?Q?upzcXy3mHoSVbIxe094lzh4/WYB3HBqeppOgCs6bcqG60hP21r6CImH/GKRM?=
 =?us-ascii?Q?AmpI87FjcKsdLTRbFWHVRijR6f5ZLA5J0SCGbAaQUwY5zoOypXdlGLT/7b05?=
 =?us-ascii?Q?055+MLml52SAiFXrey3f3Eov45rcOX74//atASgBz0NaKCe4JfcLlLVNNfO7?=
 =?us-ascii?Q?WEx8dAY6MUFnmq+ywfu7Lk0K4njhqBn+9Jj3aNG43oP3SLRdik+W/YOT3Uok?=
 =?us-ascii?Q?bHP7/zggnMoiuqoptTBXjogXM/On5tNDaaSZp7ysfTuOFEfiqvhdEdMy7LOq?=
 =?us-ascii?Q?L+NiFQQu0bIIYOQ9hyO5ZsWxXFA4JVuzfa4ToGiU/bVXUjKiyUBqClRIAyHO?=
 =?us-ascii?Q?SHTXhFyo+kPRu8H+YQYdsb37nfkrnKnrXwwpNrEmNhS9O2lx5La76qku+/yI?=
 =?us-ascii?Q?aoMcbRx1MMz6hIw1rVYlW2bvMV5tV3KQfl4KWNW1VIIy9KUdsDASrzXLSEP6?=
 =?us-ascii?Q?08C/9nH/5Ra5xMCZe5YExd8F5YtwZRsvD8YEA1BUbH6JDc4eby0JZmUtCD5O?=
 =?us-ascii?Q?4TuKhe80rhWiO+hoa+GfsCjfOjMKIh0k1PlBJ9a5/j4lGqaEKirrDoNUq4qz?=
 =?us-ascii?Q?xCNXIevSI6DuDdeP2RbGpetCTeN6wAGJKqGVhxgUMB/ESpIe0yq6+c7SYMdX?=
 =?us-ascii?Q?yScBqsz5Aq1uLss75AseLzqXuY4r76jHXuE9Y2ZITebitO8WSx6I3u79sfpn?=
 =?us-ascii?Q?q+eNZ86RRk4uZgmBQAUXngXll/AafT3dOmdKC76zYUXMapvzw0/8h6wLjs/h?=
 =?us-ascii?Q?mefHEvVNUBlmVkw6M9I3JdqhuOZ/oZ8Gp9e6dAxeMlNlPo2ZljCfSJmMFBhY?=
 =?us-ascii?Q?23j36BYyNIpjprMDf1qhiocAekgCjc+jptdxhQJRFXudVEzBUHrMxH4m/0IN?=
 =?us-ascii?Q?llWS0mNkecQvJf7ACYfsBkk/sxIUQ3hmv1oPJXmoqbAJIeAM17yD2cIiQD62?=
 =?us-ascii?Q?j80GDrT+FNm24EGy9S/Tdg6gSzF6UZLJNBlToleJh7oBUQ1AzBOKlUUWxCHi?=
 =?us-ascii?Q?c3vO4dybcgCBlMcxZ5OmFyLUVajmWY/zdKtL9HPoRf66Q405J+FJzFcASezR?=
 =?us-ascii?Q?Wj3V3HD6IOKvo7STL/qc5yTXc69j9SxKDgggJNldODFDke0PZVAj6lXL7855?=
 =?us-ascii?Q?EPr603oY4JF51kjNso4mXrEXIXhyLQtOS9OJ29MxpjxpijZJQdAe6WEJQe0Z?=
 =?us-ascii?Q?mYLSuGzNlvk2yCsZ4ihp5ajE5ehewKAvK+CPF52AjSW9hViBcMY6R8vbVI4u?=
 =?us-ascii?Q?VMHsz3FZ2OTf/Tb2sh7E/JB1qL+7scQr63IjySNux5vAmd74tWldf5nMhGVP?=
 =?us-ascii?Q?277zhq/a3pWCIE92NOuDEAEdf6bhSqROgbCKr0FG8y3eAIgSOv75TEYtdtWI?=
 =?us-ascii?Q?w8YXYbYz6PLYlTaDFcXdsyUWmlQ8kep7g16TmzX2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D++g8Vhb+Flq914UfsgoqaezK0Bb5ojEN165h9gRXLpWS9D9kRuSRSuoi88OoDh0ddh/7PMJmlDzDUH8bVoBBKeAG2hox4T/s73WbCzRnBqb+4jS0R6OebpVsT5e00N1ppk5MsqvO1xH+hgideQ3pJsuNahb3/RrW4ftvBwPD0agut/3JdRAb6SW/98RmcoIEcsk0JUy6N2CHoYNxcZF2DLvK/wJQ64/ANbKf8Q3iiIjlp/4a5e7q0p7BmdgIHx4BkFOyOxBhdA9JwG+opUuAP9yBVa4PSCE0HdAL3mpGN191XBrYwvcbnvDBbJ3SWxOJSIDQLCEpZdUpAmqU8U2VAMy/gz3DyJ+M98VxqZ53q9CYGgJDo4XmWg2/f4/L/yWj3VtGxgl2By0+w2AKDK6Nn3+8tC9VITvCFT71MijUBNpMNeqthneaxo2bEul3GGSqOGFshNWgcgc7OqAhklDq2L2VTr5o5Gpxg9OwEZSMvGlX/QbRBKANi/LJqHaIXpUPqk2IjJ1vzLWMLdbFXWNEPjVgAbXmKLD3pG1JNwpjJkKaXdiQrm14W+kXeijWsxntbQV1WJurC60wm7/zUcQrXdNm+f+Tiqv/rA6vlL6xLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f987b757-e372-4f34-c8f4-08dd8688f259
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:14:49.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nISOCPgPFnms5Nf5BO4EFCxYarzzsmvAs1YgvxPSdRQCoRjqsJlkl/sJw6Np/AYUAuMXLCDWPUC3obnMdSBTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280155
X-Proofpoint-ORIG-GUID: 2ug-ZteQCxIJDG2AezNqvBnQfeijWicg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1NCBTYWx0ZWRfX5zXPd2Re6dry x3tD0tqpL5v1b3esi3Wl2g7rdg5wdGQ7QktKriBjsiyXBlyVGIG0xoJ99PEeGzw5YyDXPF+LrHf dpoDguNXZLu4Ef1MacryQGR0sVITZfVYy9mjb6RTUzbH/3e3Py0Wb7CEhaxAT7j7ftm1Xxp4thG
 rFuKqRbk2FBWU5wZd/ABpyj4wRD5MHHFT8onUMjBvFUFaxctgE6eH3+3Dsbkq5A7dJ0WCi/FU/F gAY6NgAkgGvN6KCVn8Uhqn/vuGXyV7u3nq3ofYDXflBcIpWw0igpujQ9/dq+dMe70rwCEVE9rtu J4JrbzZv9YI213VQPkkujRlSR6CIi5ElceOuQ0n5PEsuCb3YZOWD0RH6ONiVHbWK9JbTO08hSGM SvxP8lCq
X-Proofpoint-GUID: 2ug-ZteQCxIJDG2AezNqvBnQfeijWicg

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps more
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.
> 
> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
> 
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
> 
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
> 
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

One small nit below.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS                      |   1 +
>  kernel/fork.c                    |  88 -------------------
>  mm/Makefile                      |   2 +-
>  mm/mmap.c                        |   3 +-
>  mm/nommu.c                       |   4 +-
>  mm/vma.h                         |   7 ++
>  mm/vma_init.c                    | 101 ++++++++++++++++++++++
>  tools/testing/vma/Makefile       |   2 +-
>  tools/testing/vma/vma.c          |  26 ++++--
>  tools/testing/vma/vma_internal.h | 143 +++++++++++++++++++++++++------
>  10 files changed, 251 insertions(+), 126 deletions(-)
>  create mode 100644 mm/vma_init.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ee1c22e6e36..d274e6802ba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15656,6 +15656,7 @@ F:	mm/mseal.c
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_exec.c
> +F:	mm/vma_init.c
>  F:	mm/vma_internal.h
>  F:	tools/testing/selftests/mm/merge.c
>  F:	tools/testing/vma/
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ac9f9267a473..9e4616dacd82 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -431,88 +431,9 @@ struct kmem_cache *files_cachep;
>  /* SLAB cache for fs_struct structures (tsk->fs) */
>  struct kmem_cache *fs_cachep;
>  
> -/* SLAB cache for vm_area_struct structures */
> -static struct kmem_cache *vm_area_cachep;
> -
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>  
> -struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> -{
> -	struct vm_area_struct *vma;
> -
> -	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> -	if (!vma)
> -		return NULL;
> -
> -	vma_init(vma, mm);
> -
> -	return vma;
> -}
> -
> -static void vm_area_init_from(const struct vm_area_struct *src,
> -			      struct vm_area_struct *dest)
> -{
> -	dest->vm_mm = src->vm_mm;
> -	dest->vm_ops = src->vm_ops;
> -	dest->vm_start = src->vm_start;
> -	dest->vm_end = src->vm_end;
> -	dest->anon_vma = src->anon_vma;
> -	dest->vm_pgoff = src->vm_pgoff;
> -	dest->vm_file = src->vm_file;
> -	dest->vm_private_data = src->vm_private_data;
> -	vm_flags_init(dest, src->vm_flags);
> -	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> -	       sizeof(dest->vm_page_prot));
> -	/*
> -	 * src->shared.rb may be modified concurrently when called from
> -	 * dup_mmap(), but the clone will reinitialize it.
> -	 */
> -	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> -	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> -	       sizeof(dest->vm_userfaultfd_ctx));
> -#ifdef CONFIG_ANON_VMA_NAME
> -	dest->anon_name = src->anon_name;
> -#endif
> -#ifdef CONFIG_SWAP
> -	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> -	       sizeof(dest->swap_readahead_info));
> -#endif
> -#ifndef CONFIG_MMU
> -	dest->vm_region = src->vm_region;
> -#endif
> -#ifdef CONFIG_NUMA
> -	dest->vm_policy = src->vm_policy;
> -#endif
> -}
> -
> -struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> -{
> -	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> -
> -	if (!new)
> -		return NULL;
> -
> -	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> -	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> -	vm_area_init_from(orig, new);
> -	vma_lock_init(new, true);
> -	INIT_LIST_HEAD(&new->anon_vma_chain);
> -	vma_numab_state_init(new);
> -	dup_anon_vma_name(orig, new);
> -
> -	return new;
> -}
> -
> -void vm_area_free(struct vm_area_struct *vma)
> -{
> -	/* The vma should be detached while being destroyed. */
> -	vma_assert_detached(vma);
> -	vma_numab_state_free(vma);
> -	free_anon_vma_name(vma);
> -	kmem_cache_free(vm_area_cachep, vma);
> -}
> -
>  static void account_kernel_stack(struct task_struct *tsk, int account)
>  {
>  	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> @@ -3033,11 +2954,6 @@ void __init mm_cache_init(void)
>  
>  void __init proc_caches_init(void)
>  {
> -	struct kmem_cache_args args = {
> -		.use_freeptr_offset = true,
> -		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> -	};
> -
>  	sighand_cachep = kmem_cache_create("sighand_cache",
>  			sizeof(struct sighand_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> @@ -3054,10 +2970,6 @@ void __init proc_caches_init(void)
>  			sizeof(struct fs_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>  			NULL);
> -	vm_area_cachep = kmem_cache_create("vm_area_struct",
> -			sizeof(struct vm_area_struct), &args,
> -			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> -			SLAB_ACCOUNT);
>  	mmap_init();
>  	nsproxy_cache_init();
>  }
> diff --git a/mm/Makefile b/mm/Makefile
> index 15a901bb431a..690ddcf7d9a1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -55,7 +55,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   mm_init.o percpu.o slab_common.o \
>  			   compaction.o show_mem.o \
>  			   interval_tree.o list_lru.o workingset.o \
> -			   debug.o gup.o mmap_lock.o $(mmu-y)
> +			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
>  
>  # Give 'page_alloc' its own module-parameter namespace
>  page-alloc-y := page_alloc.o
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5259df031e15..81dd962a1cfc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1554,7 +1554,7 @@ static const struct ctl_table mmap_table[] = {
>  #endif /* CONFIG_SYSCTL */
>  
>  /*
> - * initialise the percpu counter for VM
> + * initialise the percpu counter for VM, initialise VMA state.
>   */
>  void __init mmap_init(void)
>  {
> @@ -1565,6 +1565,7 @@ void __init mmap_init(void)
>  #ifdef CONFIG_SYSCTL
>  	register_sysctl_init("vm", mmap_table);
>  #endif
> +	vma_state_init();
>  }
>  
>  /*
> diff --git a/mm/nommu.c b/mm/nommu.c
> index a142fc258d39..0bf4849b8204 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -399,7 +399,8 @@ static const struct ctl_table nommu_table[] = {
>  };
>  
>  /*
> - * initialise the percpu counter for VM and region record slabs
> + * initialise the percpu counter for VM and region record slabs, initialise VMA
> + * state.
>   */
>  void __init mmap_init(void)
>  {
> @@ -409,6 +410,7 @@ void __init mmap_init(void)
>  	VM_BUG_ON(ret);
>  	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
>  	register_sysctl_init("vm", nommu_table);
> +	vma_state_init();
>  }
>  
>  /*
> diff --git a/mm/vma.h b/mm/vma.h
> index 94307a2e4ab6..4a1e1768ca46 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -548,8 +548,15 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
>  
>  int __vm_munmap(unsigned long start, size_t len, bool unlock);
>  
> +

Accidental extra line here?

>  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
>  
> +/* vma_init.h, shared between CONFIG_MMU and nommu. */
> +void __init vma_state_init(void);
> +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm);
> +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
> +void vm_area_free(struct vm_area_struct *vma);
> +
>  /* vma_exec.h */
>  #ifdef CONFIG_MMU
>  int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> new file mode 100644
> index 000000000000..967ca8517986
> --- /dev/null
> +++ b/mm/vma_init.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
> + * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
> + */
> +
> +#include "vma_internal.h"
> +#include "vma.h"
> +
> +/* SLAB cache for vm_area_struct structures */
> +static struct kmem_cache *vm_area_cachep;
> +
> +void __init vma_state_init(void)
> +{
> +	struct kmem_cache_args args = {
> +		.use_freeptr_offset = true,
> +		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> +	};
> +
> +	vm_area_cachep = kmem_cache_create("vm_area_struct",
> +			sizeof(struct vm_area_struct), &args,
> +			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> +			SLAB_ACCOUNT);
> +}
> +
> +struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> +	if (!vma)
> +		return NULL;
> +
> +	vma_init(vma, mm);
> +
> +	return vma;
> +}
> +
> +static void vm_area_init_from(const struct vm_area_struct *src,
> +			      struct vm_area_struct *dest)
> +{
> +	dest->vm_mm = src->vm_mm;
> +	dest->vm_ops = src->vm_ops;
> +	dest->vm_start = src->vm_start;
> +	dest->vm_end = src->vm_end;
> +	dest->anon_vma = src->anon_vma;
> +	dest->vm_pgoff = src->vm_pgoff;
> +	dest->vm_file = src->vm_file;
> +	dest->vm_private_data = src->vm_private_data;
> +	vm_flags_init(dest, src->vm_flags);
> +	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> +	       sizeof(dest->vm_page_prot));
> +	/*
> +	 * src->shared.rb may be modified concurrently when called from
> +	 * dup_mmap(), but the clone will reinitialize it.
> +	 */
> +	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> +	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> +	       sizeof(dest->vm_userfaultfd_ctx));
> +#ifdef CONFIG_ANON_VMA_NAME
> +	dest->anon_name = src->anon_name;
> +#endif
> +#ifdef CONFIG_SWAP
> +	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> +	       sizeof(dest->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +	dest->vm_region = src->vm_region;
> +#endif
> +#ifdef CONFIG_NUMA
> +	dest->vm_policy = src->vm_policy;
> +#endif
> +}
> +
> +struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> +{
> +	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
> +
> +	if (!new)
> +		return NULL;
> +
> +	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
> +	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> +	vm_area_init_from(orig, new);
> +	vma_lock_init(new, true);
> +	INIT_LIST_HEAD(&new->anon_vma_chain);
> +	vma_numab_state_init(new);
> +	dup_anon_vma_name(orig, new);
> +
> +	return new;
> +}
> +
> +void vm_area_free(struct vm_area_struct *vma)
> +{
> +	/* The vma should be detached while being destroyed. */
> +	vma_assert_detached(vma);
> +	vma_numab_state_free(vma);
> +	free_anon_vma_name(vma);
> +	kmem_cache_free(vm_area_cachep, vma);
> +}
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index 624040fcf193..66f3831a668f 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -9,7 +9,7 @@ include ../shared/shared.mk
>  OFILES = $(SHARED_OFILES) vma.o maple-shim.o
>  TARGETS = vma
>  
> -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
> +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
>  
>  vma:	$(OFILES)
>  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 5832ae5d797d..2be7597a2ac2 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
>   * Directly import the VMA implementation here. Our vma_internal.h wrapper
>   * provides userland-equivalent functionality for everything vma.c uses.
>   */
> +#include "../../../mm/vma_init.c"
>  #include "../../../mm/vma_exec.c"
>  #include "../../../mm/vma.c"
>  
> @@ -91,6 +92,12 @@ static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
>  	return res;
>  }
>  
> +static void detach_free_vma(struct vm_area_struct *vma)
> +{
> +	vma_mark_detached(vma);
> +	vm_area_free(vma);
> +}
> +
>  /* Helper function to allocate a VMA and link it to the tree. */
>  static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  						 unsigned long start,
> @@ -104,7 +111,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  		return NULL;
>  
>  	if (attach_vma(mm, vma)) {
> -		vm_area_free(vma);
> +		detach_free_vma(vma);
>  		return NULL;
>  	}
>  
> @@ -249,7 +256,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
>  
>  	vma_iter_set(vmi, 0);
>  	for_each_vma(*vmi, vma) {
> -		vm_area_free(vma);
> +		detach_free_vma(vma);
>  		count++;
>  	}
>  
> @@ -319,7 +326,7 @@ static bool test_simple_merge(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->vm_flags, flags);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
>  
>  	return true;
> @@ -361,7 +368,7 @@ static bool test_simple_modify(void)
>  	ASSERT_EQ(vma->vm_end, 0x1000);
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	vma_iter_clear(&vmi);
>  
>  	vma = vma_next(&vmi);
> @@ -370,7 +377,7 @@ static bool test_simple_modify(void)
>  	ASSERT_EQ(vma->vm_end, 0x2000);
>  	ASSERT_EQ(vma->vm_pgoff, 1);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	vma_iter_clear(&vmi);
>  
>  	vma = vma_next(&vmi);
> @@ -379,7 +386,7 @@ static bool test_simple_modify(void)
>  	ASSERT_EQ(vma->vm_end, 0x3000);
>  	ASSERT_EQ(vma->vm_pgoff, 2);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
>  
>  	return true;
> @@ -407,7 +414,7 @@ static bool test_simple_expand(void)
>  	ASSERT_EQ(vma->vm_end, 0x3000);
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
>  
>  	return true;
> @@ -428,7 +435,7 @@ static bool test_simple_shrink(void)
>  	ASSERT_EQ(vma->vm_end, 0x1000);
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  
> -	vm_area_free(vma);
> +	detach_free_vma(vma);
>  	mtree_destroy(&mm.mm_mt);
>  
>  	return true;
> @@ -619,7 +626,7 @@ static bool test_merge_new(void)
>  		ASSERT_EQ(vma->vm_pgoff, 0);
>  		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  
> -		vm_area_free(vma);
> +		detach_free_vma(vma);
>  		count++;
>  	}
>  
> @@ -1668,6 +1675,7 @@ int main(void)
>  	int num_tests = 0, num_fail = 0;
>  
>  	maple_tree_init();
> +	vma_state_init();
>  
>  #define TEST(name)							\
>  	do {								\
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 32e990313158..198abe66de5a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -155,6 +155,10 @@ typedef __bitwise unsigned int vm_fault_t;
>   */
>  #define pr_warn_once pr_err
>  
> +#define data_race(expr) expr
> +
> +#define ASSERT_EXCLUSIVE_WRITER(x)
> +
>  struct kref {
>  	refcount_t refcount;
>  };
> @@ -255,6 +259,8 @@ struct file {
>  
>  #define VMA_LOCK_OFFSET	0x40000000
>  
> +typedef struct { unsigned long v; } freeptr_t;
> +
>  struct vm_area_struct {
>  	/* The first cache line has the info for VMA tree walking. */
>  
> @@ -264,9 +270,7 @@ struct vm_area_struct {
>  			unsigned long vm_start;
>  			unsigned long vm_end;
>  		};
> -#ifdef CONFIG_PER_VMA_LOCK
> -		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
> -#endif
> +		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
>  	};
>  
>  	struct mm_struct *vm_mm;	/* The address space we belong to. */
> @@ -463,6 +467,65 @@ struct pagetable_move_control {
>  		.len_in = len_,						\
>  	}
>  
> +struct kmem_cache_args {
> +	/**
> +	 * @align: The required alignment for the objects.
> +	 *
> +	 * %0 means no specific alignment is requested.
> +	 */
> +	unsigned int align;
> +	/**
> +	 * @useroffset: Usercopy region offset.
> +	 *
> +	 * %0 is a valid offset, when @usersize is non-%0
> +	 */
> +	unsigned int useroffset;
> +	/**
> +	 * @usersize: Usercopy region size.
> +	 *
> +	 * %0 means no usercopy region is specified.
> +	 */
> +	unsigned int usersize;
> +	/**
> +	 * @freeptr_offset: Custom offset for the free pointer
> +	 * in &SLAB_TYPESAFE_BY_RCU caches
> +	 *
> +	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
> +	 * outside of the object. This might cause the object to grow in size.
> +	 * Cache creators that have a reason to avoid this can specify a custom
> +	 * free pointer offset in their struct where the free pointer will be
> +	 * placed.
> +	 *
> +	 * Note that placing the free pointer inside the object requires the
> +	 * caller to ensure that no fields are invalidated that are required to
> +	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
> +	 * details).
> +	 *
> +	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
> +	 * is specified, %use_freeptr_offset must be set %true.
> +	 *
> +	 * Note that @ctor currently isn't supported with custom free pointers
> +	 * as a @ctor requires an external free pointer.
> +	 */
> +	unsigned int freeptr_offset;
> +	/**
> +	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
> +	 */
> +	bool use_freeptr_offset;
> +	/**
> +	 * @ctor: A constructor for the objects.
> +	 *
> +	 * The constructor is invoked for each object in a newly allocated slab
> +	 * page. It is the cache user's responsibility to free object in the
> +	 * same state as after calling the constructor, or deal appropriately
> +	 * with any differences between a freshly constructed and a reallocated
> +	 * object.
> +	 *
> +	 * %NULL means no constructor.
> +	 */
> +	void (*ctor)(void *);
> +};
> +
>  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
>  {
>  	mas_pause(&vmi->mas);
> @@ -547,31 +610,38 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_lock_seq = UINT_MAX;
>  }
>  
> -static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> -{
> -	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
> +struct kmem_cache {
> +	const char *name;
> +	size_t object_size;
> +	struct kmem_cache_args *args;
> +};
>  
> -	if (!vma)
> -		return NULL;
> +static inline struct kmem_cache *__kmem_cache_create(const char *name,
> +						     size_t object_size,
> +						     struct kmem_cache_args *args)
> +{
> +	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
>  
> -	vma_init(vma, mm);
> +	ret->name = name;
> +	ret->object_size = object_size;
> +	ret->args = args;
>  
> -	return vma;
> +	return ret;
>  }
>  
> -static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> -{
> -	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
> +#define kmem_cache_create(__name, __object_size, __args, ...)           \
> +	__kmem_cache_create((__name), (__object_size), (__args))
>  
> -	if (!new)
> -		return NULL;
> +static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> +{
> +	(void)gfpflags;
>  
> -	memcpy(new, orig, sizeof(*new));
> -	refcount_set(&new->vm_refcnt, 0);
> -	new->vm_lock_seq = UINT_MAX;
> -	INIT_LIST_HEAD(&new->anon_vma_chain);
> +	return calloc(s->object_size, 1);
> +}
>  
> -	return new;
> +static inline void kmem_cache_free(struct kmem_cache *s, void *x)
> +{
> +	free(x);
>  }
>  
>  /*
> @@ -738,11 +808,6 @@ static inline void mpol_put(struct mempolicy *)
>  {
>  }
>  
> -static inline void vm_area_free(struct vm_area_struct *vma)
> -{
> -	free(vma);
> -}
> -
>  static inline void lru_add_drain(void)
>  {
>  }
> @@ -1312,4 +1377,32 @@ static inline void ksm_exit(struct mm_struct *mm)
>  	(void)mm;
>  }
>  
> +static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
> +{
> +	(void)vma;
> +	(void)reset_refcnt;
> +}
> +
> +static inline void vma_numab_state_init(struct vm_area_struct *vma)
> +{
> +	(void)vma;
> +}
> +
> +static inline void vma_numab_state_free(struct vm_area_struct *vma)
> +{
> +	(void)vma;
> +}
> +
> +static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
> +				     struct vm_area_struct *new_vma)
> +{
> +	(void)orig_vma;
> +	(void)new_vma;
> +}
> +
> +static inline void free_anon_vma_name(struct vm_area_struct *vma)
> +{
> +	(void)vma;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

