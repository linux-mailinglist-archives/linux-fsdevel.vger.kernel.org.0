Return-Path: <linux-fsdevel+bounces-23392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7D92BAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B991D1F2394D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487B15F318;
	Tue,  9 Jul 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8Jt4l+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iSHxiUBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA315699E;
	Tue,  9 Jul 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530615; cv=fail; b=tYhe6bqahSP+AvBZIrWVe4q5MDVn2l6OcgGZRMR/5wMNJVKHNuhqleb05534nw/gL3yKLtArXZIEBOY5MLYzWhFC9sPCdCI0lY1V2Kmb3M0u+goZgCmOL8dw5Ypg1aFb/jczGrqgTUo6UCp9TMMQCwIIQEoYKlmTPVtIbM0lZsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530615; c=relaxed/simple;
	bh=8IKwuwHOpLP2kBDHwWwlK2kYC7cLeSJsS8hjp+E2mEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uV6mzaJsFp5u2NkTmgV0KKxoaHb55HOkdoZCUrj152TF3dp1XkUhLamtzAND9/DwbTbNEXHM2L0mJBfeseyX/C+j2ZGdvb/rD92rjgHsBkhHU9FkJpvfzpnxu/lNOO7zTNdetBfzU2Ixk/NIYV6WB2wE1FE/HIacVx5qQcu9wc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8Jt4l+A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iSHxiUBH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT1Li008016;
	Tue, 9 Jul 2024 13:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HbnkKfN0CTlcoA8
	dZBJ+XycuyCjCIOGUhNV81s1a3tc=; b=U8Jt4l+AJ6tQ0aVMpXDtj3a8SNBXh5R
	I640H6ZzK01S2+14k8VXY1KbMlJ9iWXmysc/C6R32jGgxiTXNY/9zG9+sEN9C3Eu
	lCHEyju7LynnZ1QnTLVN8as9JZY9cjTmOtExr1REDAnFP+blWtQKlrefhkOFUUHX
	m+0scH4eV2D+TL7Jjue6I7dXcRncnHvA47b8LuOFw0serYPBypCyRkWgYs33NFK5
	2FjWr5ljK9z6RMN+rF6ohevrfPEs7NfZlug3CtZoOEXSb1ARP4d9v+XJBo/6fmL7
	Q7mJlvzyi5dX/aAX3hA3KGKKajpiW7uRuhtlvzOek7MIXoK9GzaMBCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmwrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:10:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469BeT2h014345;
	Tue, 9 Jul 2024 13:09:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgx5w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T71ltQL3z6qSxYQXewoW3O/iUsZwMjI7kLqft0tqNeRed21t6e/Ux0HgItjTazRSX1WW4HF2FM9UL9IDDERH1lplJASWBtlLSaNJuEJnNEeTM88IXqLyYhj++FObGljEWD/FoedyfGl/jhYZIGEXkRV3DrF7rKfQ9NNKaytW7nFSCgVpcN5QuJ7kj/7AXfD8J91bZoaoKaAOkKl2WRY7c3WM9+eQerrMFm5o55RJlxubXjUyMJMVNSFFXKXSGtkwvwEHQ3pZfATqxsLgiTXXGDFVxf7FjaY9O2SIilIhsu2kHxOOv7EbfzSIkkaii/oMa2odhDEhdd1jzArKf91XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbnkKfN0CTlcoA8dZBJ+XycuyCjCIOGUhNV81s1a3tc=;
 b=hWBJneeggyhIeyYiJYsi60JKJ6vNweU3Yk2OUI2bU97kLRB/SOdxK1ofgIk49n+vwedXqpxJPLMjeqLjHpT83pgAzKykyGkAP0wxr7xs1gwsmJwZz5kDUs+wOpSdbe/balxNFEd43bfyKLbLI88c5soTeWND/dYTlYjqnVh73h6Vitz6IPwQVu9bnmSYbIUf3SrWFe9Zw9pm8mu7ceoUgAQ7pUpuyFcA32BCRaX7DqgImJelmnrpyrJ4PMRvBqT9WP0lQuh9k2w4qn3yT2TWBTu5rqtH5wzJoE/HqNFUHixI4l2abUp3KTj/I75SHeimrnkbQuYcMpcXx48pGAgSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbnkKfN0CTlcoA8dZBJ+XycuyCjCIOGUhNV81s1a3tc=;
 b=iSHxiUBH2YlF3BNTJXEg+WQtJP6VohMCdD+c/u8RzEnHz9rcu5qfD1q41GOOTac9Tv0Zx8levgCERWjsdYfUUygknRb3fKPBbNJ9NMxobCdYlpN+v3yRWQlrXQt0I/EZfFexSbtJ51R1/W/reK3/Qv0AhcDtAeNfWhC0YqN172Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7107.namprd10.prod.outlook.com (2603:10b6:510:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:09:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:09:57 +0000
Date: Tue, 9 Jul 2024 09:09:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 3/7] mm: move vma_shrink(), vma_expand() to internal
 header
Message-ID: <yp2uorqma3gyt2uwfjmjcifhqgslit3c4x32662sba4spn5y2e@iya75ryl2eek>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <2182710009e222ee0a57ad975ed560edf965f5ee.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2182710009e222ee0a57ad975ed560edf965f5ee.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:610:38::41) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 570d7b18-ed43-453c-e00c-08dca0186e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SPnoEBhdGvbziNn13B4KZSbgPHPGpg80k1DRgMjPX65NW48PYUQVAZI+Q1dq?=
 =?us-ascii?Q?hZwHqjuNkBTcPNIOWJz9aXAYZsdnvFWLfY6wGYdQsMh0Psu1AsI/+r8N4UQE?=
 =?us-ascii?Q?S72tQXJn1KLy7k71PYoJGSFOzBfjywu8yT3w01klF/jenkwULiYVrIV93d01?=
 =?us-ascii?Q?Rq8HWUvX9IRvbiiKZsA8pTgkpEcB70DEzZaDGzMPga/cpgEMoCXyUzMT2RFp?=
 =?us-ascii?Q?o2FKHyeF+6tKBzpM4M2r2T8/wFKiIwO1yUTcWJPx0VUgUeVwY+Ca1MGxYSur?=
 =?us-ascii?Q?BZBbmHcsZs/r6HwoUa6VF6QtstSZxKjBIx3v+DnmX/p7nidpVKRM1Z5Rnnsz?=
 =?us-ascii?Q?PDNM2JiwllPPvvL8iWB5BKauyFsflzy7N9U3mxllWYlWOpOyMd/I2QaeuPNL?=
 =?us-ascii?Q?/17FMul9poptV9gmZJLz9zQBdxi7mSCc+Y76r5HW0Al5d9ToFWPbVGqWvmps?=
 =?us-ascii?Q?MEovbTNS976avFY//wXNrQPMFgrZ4tUsoJuOKNFKj7JiOg4tJ3ZdiWtuXCQC?=
 =?us-ascii?Q?at4j8dW5PVdnlLZjvEtRBhQ13DvdwhDv409fRSJ75Gcu1qQgMS0fMm7fIfU/?=
 =?us-ascii?Q?2iHh8rZgWJtVsECSlbpTndNU+ijRy+sUYOUeUBBXCCmVrEC3HFU4ftAMS9w1?=
 =?us-ascii?Q?ECvAXU5MSgLOjGC8Qf+C36A7axD+9yti+RN5aZVluK9HKcqmwrFFtNxkbCnd?=
 =?us-ascii?Q?d9LmHFC7Ky2n/IfMXeu3kyLIrdiqsTV83ixjaQNFZgFA+7SJ8G6QRZ8MnGC5?=
 =?us-ascii?Q?cGElqWtYZ1zWbYqjDk2d+8QEkWaPcmpwyNe4BZgw+DqG8Km6uOygyGT8uyT2?=
 =?us-ascii?Q?eYwYypZUWVoIY1p+lLNVlV0rmNlQLV34wS31CLpGvQ0d5QejWWT/PFN1UthK?=
 =?us-ascii?Q?oD+9lPxYb6oYbhIHbtgIY8YaUYQ0yFW48hpaDw88awqq5+47S/LlbjCXnfNb?=
 =?us-ascii?Q?3BSyQn/EiwQhUDSvtXGc0zPTjVSzbjJquoSHTi+NwhkezbOCU31uFdZwjWpI?=
 =?us-ascii?Q?nCmAT5veeb2RCS1UUz6orJzrJy89Nuc7q4OyrprUGlZTVhYHdWbqb6pRkVmS?=
 =?us-ascii?Q?S6ObpTiZP6+6M9B9vMn1Uz/lSctuMm9FLOkegFZJjp8PMdfm4tQ8EuqrKMM2?=
 =?us-ascii?Q?hh74SXHDaaeyDuciw5clRoccUEcCiShqT/1B8ZlG3H08gC/Kzk07t7ELywDN?=
 =?us-ascii?Q?dzQofjCYfn/OxCLp5L11eg1UrEmEP7SNMP0m3jmtDuTI5NmhEz8vZUdobz6f?=
 =?us-ascii?Q?D6MtKq5wtOBnr6Y9WR6u7rJjQ0uB7z953YjLmFv4YS9KNADVkiO4+YA+4HY5?=
 =?us-ascii?Q?lKm3NBdpt5yF9Zbyj6Ue+QZDnhKYCTY+z7qcNeU2SuPTmg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tAiLPnnrhhv5EzPHbRKF27QeqTgnZni5wUaa/UQcaaf/iiS/G+05F+7HPEuu?=
 =?us-ascii?Q?Nauft0/NK+JCn+YctPvwxKJY0iLvtVEcNC1lJGsZHz9cVD5UX7HPJiduDIhO?=
 =?us-ascii?Q?gTNOZPI+CsTZI47P/do0rfOdSsc3k58ySZQ48SCy9IDw5xe6MNjWlrNHQ+aS?=
 =?us-ascii?Q?LCeVS7zxnl/c+RHdtWJ/aphu4cBIoR5E9c3eRNWGklMFYjCczz5JBT5Gr8aP?=
 =?us-ascii?Q?AU0IrURE0AM08MdIStuYEW15tsV2LyuThQYev61a7Tgfs8AkLewAeLm7SG6V?=
 =?us-ascii?Q?tsE+l4SO64dnZjrVI/FE3TV9X717WhwBheQiTWgpARUJegVe1A6yOJ/VdwrH?=
 =?us-ascii?Q?ZpYIDiAWAtDrAnBiLQaUOJa10sBmuZuZ5zYj1BPn7UBGjXv4kQiSP9HaBgrk?=
 =?us-ascii?Q?Vu7y5xYg3ylB6pMmRxQikiC9VEn5C0+5ssK5XwIKE7UOvv2RndaN3n0gxgvT?=
 =?us-ascii?Q?3OgYqJt1hx0cWnmnBKqs8eNP8nJBa/rPUyvZ8YCpJ12punnlsqdObqDY9Gvb?=
 =?us-ascii?Q?payRFy/mSDAlCO0E1TBpN/V1r/G3UsiuYqoEfchFtdukfc4jA39EeLBw8rMQ?=
 =?us-ascii?Q?w7QBeZ6wIh72JIrmUwF4BiVEHUJ4F2pxdKr/3itqol6DTNJVEkj2LjyX0VnC?=
 =?us-ascii?Q?FbPEfMvG6zSJL0UxX8EiWa4wJgp8B/TvwwKKM4Sb0Tofy971M43n20Mu2oUc?=
 =?us-ascii?Q?6YbEj0jnf88WfanUD8vf+qQJ3HLqcqE+D0G7aJYuxxWfwc1UWmqLSNeE0pmv?=
 =?us-ascii?Q?bEZ9CIeu0flCX9PklT/Icazn0uqscXEc26RXlQYmD3jaMFi+vQzkiA2SVjAM?=
 =?us-ascii?Q?JiqN9SJk3HUHnnFKkMXUrzyMlQic/gxyKUwz1OrWUdD0Jm+birvo5JeJEp3g?=
 =?us-ascii?Q?054OWwYloweByeHefcEDCzlTSUg36UJwDRQe6rPHwP1EVSRAYgMuuaszcCTb?=
 =?us-ascii?Q?ytF/C0I50AIeC1gRwV4ax5M94MPj6C2T24Ao6N4sOr/B5BsvFb+37u7eCfpX?=
 =?us-ascii?Q?T0CpKMIURkqoDMg+jrDWtMRQAePjlN9SMqA80rbwotFjVkG8I9sgDoM1H9Q2?=
 =?us-ascii?Q?SngLX8tQWqZ3L9W57/NTbHdS+4OWNsakg6x2kpEszvjumUlR1rIWPpkRdV8R?=
 =?us-ascii?Q?fPcOjgauCCqs50RSuflYFVnKB3kB2JFjRqgIBXeC51X9ws3vwecQ62n5UXbE?=
 =?us-ascii?Q?UuoCbTh4YMHjlYLTOwtwCC680fUXCUmZ/X+wdfLs1T46erF2uf7jSM0HoRKM?=
 =?us-ascii?Q?sN891aFncLNlV9foITrZipT18bYg0++Ye88vcyhyr6XmBqnOMY0dVEdUywo7?=
 =?us-ascii?Q?XaAHoCo0gQ3/bMadiGyEJ4+YLC9HIwgrtvvNxBO/+nAyJ5VGwln4bTG8o4jl?=
 =?us-ascii?Q?QZDgupV7oKYyUDSGafOidmjofkzJrOEXHklEL/s0YyxEJkCA7GsIoiRnkYC6?=
 =?us-ascii?Q?6W0GfRyKPtGm3PGQ3c/DXPkdc8vk7ntkH0iPXzFC0AEUOO9uGlSoQy0Y5l2B?=
 =?us-ascii?Q?kQKEcDgH0YH8GqgEOaj0OIK+to5E8GsP8g4yqlP6WTx/cRilQ0KDSHHTLwXn?=
 =?us-ascii?Q?jd2AUwOMYksyAPDcrANfMHNPktHoegFDlQa4VdAM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8tD0/OqutU2J00ggtjc+4YaSGxZ2LyOENbVuDG9tUe5CtBcMgNGLhpQjTdj9a8AFNInukxgpJ19zBW/oxMamoNiRlP3umRLEHKMEgzuttG1qFLqIY8Xx2Ao4xfE53ZVFqkf8u+M3mmFuemX32I6SAX7+agP1db+43qXy3imaDtzUDBuvcfhq/IiIPk8FVnHfbueDBHggsNb3ii702M4l/48QS7DIADg9RLWlRxuf4oAzaML33jXGCJcWfq/CNubLqqeYFy4LHVLL7dThCDYcKKYpJvATjPRRMA7+A3SQoBMNOCSya5Da7B9OfSXh0FDvK83gPP5R6bYE2vP8OHwhcLoK/99LtZkXUkXvhXtA564uGqfPPE9ut8KH/BM2zgzOwtegGb7I8I4XaD9rSXOp49clT5jHqxoj+pKWbH/Dz2HqQMWExFUPExLPnc9md7Gvd6xT/sn3IWb3QX13kP4tL2xG7ZOur85Z7gmDkqxdLFEwGtLr2d0NtXa6HgIGM8sZLh22osYfQ082Qu0pdtatNlNEeDfDyhznmJQoOAAMG1U9bnlcAuD3crE0clnR5yESXNrFMN4ZOHnqgy0USTTcFl5oWxvHDI1OWumEzU3Eub0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570d7b18-ed43-453c-e00c-08dca0186e80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:09:57.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfyNKdfG10Mb0JoptMZfTH7mQtc9nSkRtKfo7eRhTF4z97OmVLchsKzN+36bJ2zJqZ8VQZ+by3EtDBGOqH8PGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090084
X-Proofpoint-GUID: dq6uTlmWiXTomAM93S3nQA6BwQX67-vP
X-Proofpoint-ORIG-GUID: dq6uTlmWiXTomAM93S3nQA6BwQX67-vP

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> The vma_shrink() and vma_expand() functions are internal VMA manipulation
> functions which we ought to abstract for use outside of memory management
> code.
> 
> To achieve this, we replace shift_arg_pages() in fs/exec.c with an
> invocation of a new relocate_vma_down() function implemented in mm/mmap.c,
> which enables us to also move move_page_tables() and vma_iter_prev_range()
> to internal.h.
> 
> The purpose of doing this is to isolate key VMA manipulation functions in
> order that we can both abstract them and later render them easily testable.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

