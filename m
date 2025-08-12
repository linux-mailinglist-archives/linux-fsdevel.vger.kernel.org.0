Return-Path: <linux-fsdevel+bounces-57506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1621B22832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B241BC6822
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1D26E6E7;
	Tue, 12 Aug 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1pB+S/R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLmqVJWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56415464E;
	Tue, 12 Aug 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004333; cv=fail; b=HcD0nlIg7zn2hUQywixR0m/YMIGNEPDvtPsRpyCkC0um+9bEY/lKMXPkftqmkOB96jg2e+o5TwxQBctaRDJ5Yl6Oy9561MLJ2RXN0xhq3KQwv1+We7WGWOLcEW6Ci+O2kQPg+r44MgyjwTF6pHBYs6+x7i6j68L373lo0Tyl7xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004333; c=relaxed/simple;
	bh=2zWLr62ZNm2tWegVE035Uanpe32jIE1Sc/6zBD+jGHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmaFmd5urpF2FN462G1rjbNt9gte4iIEqX+JQ7cfLrRAWGjm30PVN4k5Hbl031XMMoNShhOLLR4Sq83lfXl6fo84q3CW1+wHHnBfh1CBvjkIOl2fZCPYJaeMxEakm49vGoqdOmdKla/ufz39NyTYU9t06btbG1vr7khQKfPB9f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1pB+S/R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLmqVJWf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7bc2W006561;
	Tue, 12 Aug 2025 13:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kexL78knPsb1+thpe2
	OYtdKYpsiEhcBWgZXoTjtEVAc=; b=W1pB+S/RqWt1FxiiRozeIUvU+UIBzQGUOE
	nAIVb5WGABZn6qYTYM0cen3eWmrvHL6AxmkUXVygpw3uwzZPBpjY7eM6SRL7PC3A
	QlA04shwpHAsq/SgylbkMafPkmruPi+yiOW2ch9LNxePYI8c0dYEXKwOcLDK8EN1
	WkD7CBm5mjdr+R+My6oAxzbdOrXRTNWdSCn1zZW8JDLVQ2/mcdESh9SU51q1Yizm
	eHHKKlwrgHHAUIB+XaAtzmCN+DBxFh7MZc4dLxh6IPUP5STTI3aTyZuAUFjlr3QO
	crNxkhV04H9m6pAcMTWYB1Q4E6NP+DrJjmgTrI4yB7EGUOS51UZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv4mta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 13:11:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CCZQiK032666;
	Tue, 12 Aug 2025 13:11:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs9xs1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 13:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEuF8YafGxRMJKWYOlcsCj0Pt2o4MaESbf60UoqO6mXHmKndt6swiDGZgzove2HsH981b7IVWMXu0cegzlMIsFIzdqhM7/UKR0oEbVL6KJEKe3evHvjTnGzV2CAj5LXjck86rguENMqaAp8d8Pqipf8S3TOmF2lFgKZivoER6YCDhelugEKvHfR5zFXH/NqzvkjBcigxcLcJzEsKMxyR3K1QIigvXLsXo7YIYcqureJlUwTenxqWKIBzqS1CLd0eU5whIj+7GOhoHIHrgLxpKsTkaX8/k8DU3tRiTd705iiah5RAjJn/JIJh8knVpdMmRyv6K4PUts3z13Px3+5YDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kexL78knPsb1+thpe2OYtdKYpsiEhcBWgZXoTjtEVAc=;
 b=E+j6J38Xfr2DIWzbZN2sd24niyEWipF9yzPyE1mulzo31Lbvpbd5QcpGqP45K1u+ZvTlN70vJEJiFOVR17BK6B9Q+yWSxstaESeMv/pnIguOQ0Ba54AAEVic+9CWYZMHM4Jsd6uCm896D+Lz+qpnavoSjBSbj5criZaJvaf321CGqqTLJJlDh4G41FT2nV8U7pA2iMXqFmTMSjqKvD1irfV/qZS0wTXqPUw3Nh0IDrY2UIKCPHkPcW2I9o6ZRztaPD+PxwirwZ2O7/5HMpeQIA2UqKmqZ/DpNmGtNcgyF2+lzYobrRUo6xP36xlXLIGNux3rSuLXk6a4nGelLgQrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kexL78knPsb1+thpe2OYtdKYpsiEhcBWgZXoTjtEVAc=;
 b=uLmqVJWf+Huiv/lxfpscx6I/J8wMJfVPuTLgnWnWQYLFQ1wfDBCIkqB2EFdMOqJ87BPXEPTjyaeQrr7FiRJmQmFXu1XRfaCef8DVPP/uYCWTLfPEGWQ7wmNtlT6v8Q/+DQocXk8L/pvSXMkWZVRztMyB6Ra1tB0xm1vj5bRWdUY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 13:11:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 13:11:28 +0000
Date: Tue, 12 Aug 2025 22:11:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, sj@kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] mm: remove redundant __GFP_NOWARN
Message-ID: <aJs9dPMdY_W5uZdc@hyeyoo>
References: <20250812095747.121135-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812095747.121135-1-rongqianfeng@vivo.com>
X-ClientProxiedBy: SE2P216CA0012.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c1143f-7259-449c-3465-08ddd9a1bf0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/l3ww3zLph8Sc9ZZu/XrmflKV/wS4Fr7jsN1kWsTWr4cJ6LhXxtDMi+AGO21?=
 =?us-ascii?Q?JPPmtuSuOoQt8cp7pyS58JvGPN/Xd0lUH1ZWsb2gvzGEU/d8rPRrLsmXQTqp?=
 =?us-ascii?Q?d8mNoNP41aUynzxuEr/dD8ng+gUgKCwNH7q80AzJUSMaQ/lVIMBTOjbqviBn?=
 =?us-ascii?Q?PIock9x9jYPxU8jvAgAhukO+o6TRPQRlvAWSfu1UR2lzG8KRFDt9iGd1ZK+Y?=
 =?us-ascii?Q?F8q2eALdD5ZokZtXTW81AzSI/Edr5ABU4cud1DvKcghZMmZzKZDeMSExV24T?=
 =?us-ascii?Q?slMGQDfgPZnTx6HJsFu3ZfN5EsMfqY/ZvvFnqjd9f5n52J/AO5sRtqNpr75a?=
 =?us-ascii?Q?/GZDxZhM21qrPCjrBk4SjGbUtQEZ6J3ytsrqazdTwvyaYoi3LoWFtbZ3glmA?=
 =?us-ascii?Q?aII8VXW/Gajj+12H1NGqruw6ZnN5Ss5z/DDrrEj0Y5Fl7IZnTEiy2G1ZH2+x?=
 =?us-ascii?Q?NanmivxE+4yiX7BZD3RrlaJerKUlXLPre+WNTnakZGURUYN9Anc7RKPvYSyE?=
 =?us-ascii?Q?21uf7j6BqAuEM0Lx4bYsRzqdMEXq4A6Xyyrri/+ZkM/l8krwBpKYva+E2m5Z?=
 =?us-ascii?Q?5yhq2gDOSNbqaSW9gUF4dhZSyWRsy0uy7Llub38zY2yCLW245Ge1At38hUpe?=
 =?us-ascii?Q?Kqv6g8dSWk0c8pQHMBv7We89v94ui/nrPNfZ+vxVUZ4aHGyeCipb13bPfVuh?=
 =?us-ascii?Q?3tMtGSPLrpopM95ZbC3sshTZid0BOQtDPU2XVx7AiwWi1B9Hpr5q7eJiDAJi?=
 =?us-ascii?Q?wBZ/vhxjR8KXIF+4VgpKkatgFLD7ZPdCehqVfVLQOaEn9G7XphqGmSbyg2Ys?=
 =?us-ascii?Q?oRNgU829KXBzbO1Uj9V9nnQ5oPo5bMkfam2SZyUs42dNAvf8mQlYvT6laHNK?=
 =?us-ascii?Q?QVk8G37+9HoCdXi+8qGGT8URTwHQYe4u0KhR2rmhatqnIT4AfSgNTTeVCdf4?=
 =?us-ascii?Q?3uPE05N+1mPKGAvHGqt8dOA5uqIJK9HxkwlnCAeuv3T317ihm+hmLpn5Uh58?=
 =?us-ascii?Q?+RASAjOtwfECwZlQ6aP3kQXmobC7BwkeLRigtcgNjJ48vLrtq6cTd0N3STxm?=
 =?us-ascii?Q?OlKddJlUKGjpeUhSs5qEpAT/tfz85q8Xb91wY9b++rtIZtYucM7OjzhHaGXV?=
 =?us-ascii?Q?VW8fiadrMLXMyB65YWR5df8/Sb1nGustK2QG7RR2cRzgXb5lF96zix9XMNxV?=
 =?us-ascii?Q?G4+mSVz7+lKycUXVUT4IU0LI9sYp+AS/WS/8Zf9f6HkH58Gfcn2ycsZZjWdI?=
 =?us-ascii?Q?mP4zIKIvK30C69XUl/0jh7dRwWJsotEC5XgBHjTVCsu+PVqdtf8mGZ0WD4M8?=
 =?us-ascii?Q?TjuPlW3tsguHYuAyvWXBMwm5ctscm24fcia1tDF50MYZZLVlod6MirujA0mN?=
 =?us-ascii?Q?ZHxQCtvmASCBHRgqgaZaw9q5n2wBT3ls3jy8cTbCVsvKBJvKyQy+2XyQjWGj?=
 =?us-ascii?Q?M7ITdZy5zPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVAFJd5LDroJGkPNEKL3WQxHxI9qfeJKlnOzlPpE4g/ytsiZSJ2pKjCgV59I?=
 =?us-ascii?Q?1HCgITZiWjFMxN1K9pO2R7dXy6Xx2h4tiHM+rITNGi62JgzRK/cAF01UylY0?=
 =?us-ascii?Q?wrd+qLER+YBCojG8xjMzhgYE6B2mwAyXQqQulTUChFqgG82LzSfFy99DJEIc?=
 =?us-ascii?Q?uk9QumflRDODVyhhV+4TNh5WRFSlo5YaR6pzNcquLPzdsQq61WjvYQGoXaMb?=
 =?us-ascii?Q?vr6Xj+wqbRdaugsJ25O04dJLrAGorgXUcliKl4j18IYEC1wmnlB11IaWX3ji?=
 =?us-ascii?Q?OS+KCLbwmo6oDpduk16vW57OEsTdaVlmYL3LNTibQlZZ8J9KG1pMjmtgr3hP?=
 =?us-ascii?Q?YSVrpQMYL9Obqxuq9oVdN2LtlBo1wGMVYRqKwyS4Ly3/r65gS0dgP/xlP/PZ?=
 =?us-ascii?Q?Y7IDl65sJtrJLcz2TvSmdUiGVyCEFjztzGoIvOYbumC15Vu4AaNmDoCHKVRm?=
 =?us-ascii?Q?j+qQwWBXR0x4P76IwchWqlQlrg0WXYz/p8NTsdTLID8qTM9wW6sf095QSpdz?=
 =?us-ascii?Q?32MgtIir/CxngFXEL3lMJRv6/BNpJ77S7KSRsu2ar9/1FFbvfhj9RFPcbJsh?=
 =?us-ascii?Q?Zir1m+5sAqBMynPUUPsNtrXKljGFwJoJ+20fTIyqGyt4a3WYqRosw2SmXON7?=
 =?us-ascii?Q?4ywC64+Wm2/ydPo9ppu5DBA3ZYD/xfKODXgYqYq4qKZZtsC6MVXCpqrUAptf?=
 =?us-ascii?Q?F+mb6PvNRvsfyslNin5Na4rxCMPTiyDI/WirC/0VnIgHS7IyBL6otYIx3W7h?=
 =?us-ascii?Q?FpqfqUuD2IS4eEXmFViQsTObg20evbtOqiNDj2925acaqLrdtRemc5CWTHDS?=
 =?us-ascii?Q?Sc3jSDQAp2m1yzO2Td83JM7aINNyFusSFKxrnv98da5Mmo6gXn/705Ew0aCF?=
 =?us-ascii?Q?gH6K2Frsj34Zgkg+SO1QauEhuJg1f57Q1sasY60ddnmJJRqXYZzCpL241bCE?=
 =?us-ascii?Q?7/KX262CCVzH/N/ahgIqrGAkYEh7y9q+iv1AgOJyymJnYsVctIwD6LERndOc?=
 =?us-ascii?Q?lQ9s6hqyhEaBtMhI0i6iEwYL70jOQxO2PIKXKRBCZZLEANaPSXGhIIxV+nZp?=
 =?us-ascii?Q?H3ZK2NZHjderJ+ZqSrzGqAcu2YNf2iEY0Lp6HVwKvpUOmzs0xRaw4Csynsbp?=
 =?us-ascii?Q?jbVERYHu/hGZKEjyRtdexgMG/5Z4mZdgYgRWn7e5Z8vkNwBGrQ0EbQjDJwt/?=
 =?us-ascii?Q?u9vJvfuh2KlX31PahI8pQyy8Qly75U1h8SWDVh72/MLFWwcaKumptV7lgHqM?=
 =?us-ascii?Q?m5IM8tF1jS9PfTiyqyMDthVp2GppnkfgV4YiZO5JMByl7sYwVUOhh2CbV384?=
 =?us-ascii?Q?yVZGDoEtLtrQGCdDcu1o2/0MW0rEnXWuogUQFfMdP7xMWUKXWFWiIZ3s1GJd?=
 =?us-ascii?Q?7gl6R8A3F2nbTqRfQziBy9OobnZKuKCKELGpiKV8otcJstk1yvHbFUOKvvtC?=
 =?us-ascii?Q?ZKUqcDPFhQpM5MAa6vx8KhbaWHyXc4YV7R/xwfkN1GDMWWn7F4ipzxtKSjlD?=
 =?us-ascii?Q?d90GgpCenFeiJUb15S3kNoYie7Ke1qv/TI1ZOFeD/JQhcg3E2dlcaARNOc6/?=
 =?us-ascii?Q?zfLHlE2CLSoyfXvzqXi6o4m+snIhgoyGTUT9jNbS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fr1v86Af9qqcNzU8R4VEGtnR0PVQ81BIAR2xewLreqUmJijL5uS2JG23qgRk4PM3Ykah9BrSGr54rr1hZCXcKICN/Y9IQ6pPkKhv2YUiHR9RRjjnDdqlF7SKEVLDYsj6pR/tPPGvkhf+prRIM/nh80di4Cq2y3JCiKiRmb2OO5xBwoJS1wSIiBOp6fDj59ecCIIhek+cUlAfjLXhT8ZqGsRsXawZ9rNx/Wbse4SFOn5P9wJnzW4zlP8QDm7BO/QPxuSIzb8NNYsjbqKJ0qlSxLXnzce8sEeNTXyrtLQ0biFZ6rPbPuNpYfhhTk//FfMXpLdOoaTqDxofOx7624tAq7m+gTi9rVWjafGRZk1OL72Ea+avp6lU7MVN7Nm/BWyaab9RaTYNpCAJ5ainLDOhdARZgolKBeEWluE1xMKTUyYtae67di+FvfFTjfmjWP0fnwAT9e5oF+RiSyElmSJh1+UXa/KTC397bqCoCIE5zzCoNbJGFXrqZIU1zF0KGmsazhOImqpNtGZIW/uRajAZ32NuSzbT0keKy/FE4gOXwZTGrwZJCfxvFNCh2igonm7QHl6e36vHDwsB2YwiwpcJniUwIjnRfXAGZMYPAYiJzNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c1143f-7259-449c-3465-08ddd9a1bf0c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:11:27.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8I8AXRDXIZE+t0Y6Ua7qa3uEU40fCFV0gnc3yBrkIuVCz/bdW8onriz3lBASx2pUoauG4yz91xDQB907xePsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120127
X-Proofpoint-GUID: q3NO4uc-5Je7lQusofrWssUkVXt8bBPP
X-Proofpoint-ORIG-GUID: q3NO4uc-5Je7lQusofrWssUkVXt8bBPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyNyBTYWx0ZWRfX/tt5aT2T57R8
 Y6NsDppz/7Y2SD5q1MQ2khNcgR4JbDYgQKtcjc4TAQwkjn41yDxQL9MYBR4PcTX3c6uARI9OZTV
 wJfYIUTtEY18Hm9PwATX2mvUIxqB0QDvVoFbKwavuyHmk61LapIoLRgE4Df1DYZsJszXNMkMRVf
 ZMgKW2j5lhFG0hcmUrW4jc56OHC9N/RH6akx5T8MJsIjickvsddxOMc87KE7OLs9KTFgenF2H0R
 EFD6VW8YA47DPYXSdo5YOcgLnWp6yKCB5AwJ7V2lV99xyQxEED7aJ1DiS2XkrpCemP3P0eM9lrK
 8w3QvNqaXQeHUF6zlu8ZicrRaRBwnR/2DCqCzU3EKPTTV4QDnZDoiWZ4y6q5vsyhwN3xZaDPPKm
 KYxsNpoL7T922YKVHTExfmtsk3ZsnTXy4yaCKkPqgZYuMtIhKp1BTB+nX8Pey5r/91ZONyUP
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b3d84 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1WtWmnkvAAAA:8 a=yPCof4ZbAAAA:8
 a=FxGaXRssHhVewV9F5S8A:9 a=CjuIK1q_8ugA:10

On Tue, Aug 12, 2025 at 05:57:46PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Maybe

.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
                        __GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,

in mm/damon/paddr.c also can be cleaned up to

.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
                        | __GFP_NOMEMALLOC | GFP_NOWAIT, 

?

With or without that:

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

>  mm/filemap.c    | 2 +-
>  mm/mmu_gather.c | 4 ++--
>  mm/rmap.c       | 2 +-
>  mm/vmalloc.c    | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e5c9544fee4..c21e98657e0b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1961,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp &= ~__GFP_FS;
>  		if (fgp_flags & FGP_NOWAIT) {
>  			gfp &= ~GFP_KERNEL;
> -			gfp |= GFP_NOWAIT | __GFP_NOWARN;
> +			gfp |= GFP_NOWAIT;
>  		}
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index b49cc6385f1f..374aa6f021c6 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>  		return false;
>  
> -	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +	batch = (void *)__get_free_page(GFP_NOWAIT);
>  	if (!batch)
>  		return false;
>  
> @@ -364,7 +364,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
>  	struct mmu_table_batch **batch = &tlb->batch;
>  
>  	if (*batch == NULL) {
> -		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
>  		if (*batch == NULL) {
>  			tlb_table_invalidate(tlb);
>  			tlb_remove_table_one(table);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..7baa7385e1ce 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -285,7 +285,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>  		struct anon_vma *anon_vma;
>  
> -		avc = anon_vma_chain_alloc(GFP_NOWAIT | __GFP_NOWARN);
> +		avc = anon_vma_chain_alloc(GFP_NOWAIT);
>  		if (unlikely(!avc)) {
>  			unlock_anon_vma_root(root);
>  			root = NULL;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..90c3de1a0417 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5177,7 +5177,7 @@ static void vmap_init_nodes(void)
>  	int n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
>  
>  	if (n > 1) {
> -		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
> +		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT);
>  		if (vn) {
>  			/* Node partition is 16 pages. */
>  			vmap_zone_size = (1 << 4) * PAGE_SIZE;
> -- 
> 2.34.1
> 

