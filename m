Return-Path: <linux-fsdevel+bounces-23394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D514A92BABF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5950C1F211C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506FC158D8D;
	Tue,  9 Jul 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kvEH4Q93";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IHt7SWNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9D12DDAE;
	Tue,  9 Jul 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530763; cv=fail; b=lpreZdvZL4me43OxHFRj2IDrpAMGAFQIklnqsA1XnA+wXNmPQ2sX10UWx0Yl0wBJzn9SNjKkdSB9oWickD4CtC4pubC+K+/ebL0D7qfhqE/eW9J8CyjyPyGLRYhe4DVDvMguMe0or7fIUCrdGc6a11y4SvaEp3enzovxVsZt8Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530763; c=relaxed/simple;
	bh=ieU9oHxgKikPB8JjoTy+KOK3DbTBo+GByEfKfAYeeNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWQvU6vitlLMYIkEsG3V59JoNh3ikEsUm84nWljKZQrelUNj2SVZiLqiOYrtrp1tDJbnYFTo8CNC86HMGyn7eAFlDDYDmgFtd0ncSTh1rnfoiF9nsoRPD7TmNE1YxFhCfbWgVuLLToNMjXl48YU4ZI3Oirw1XXPXvQKgzzbX2xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kvEH4Q93; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IHt7SWNH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT1Fs007967;
	Tue, 9 Jul 2024 13:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+D6teQbFuDqFem1
	oRuyUcKjPHknU12HSVEOSdtrPuAo=; b=kvEH4Q93QsvxhQTn01xiQM+NcUH/gi1
	leUsq6NCT23HXhhAHp5pNHWX/tCosZVpAGjlWCH8i3ywW0gi/koeYN4F2Mpgez8a
	Ug2BZ0YjzzfyfpQ38DvlCymEUKDYqVU1b5goYSHMJx888lLCpwsOKzhWwt+QXj29
	2AarkKpKnzam/X1Un5RnXvpSDbYTXgMj51c/jMUS6YGH+GK+4L8Hm+gBgziN4uRq
	AY8wBR4BGtlkKlkY9lahA9DBaFTIG7jFyPipBY/WPhfKu4HJPqb2FzTyHs6hmamn
	LtxrLzr7wkIqYe6P/tiPOJ/m9g45AD7pH8VXkGYBQcNMKTP8d8FEWTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmwyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:12:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Bgljk028168;
	Tue, 9 Jul 2024 13:12:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tttn4vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8eGMc1OxloHocCCAlhVRRQze3wPNoF52IZSit1Aqr+XkMjz1sr3LG91P59ylJOEVutApq4l1mvBwzvEZEsF1XcJx5tMKcMvM+xZxKNDwckMoiVjZWQNDc3BQZIXlMjyHKkPk4u7Yw0XTuzixu+qzWZLpG5Ehhu3foQJ2uieCV9Xc8dt3dX8kTEZfDeXOk7RKsVp6j1p9cqgD9f43OIzmfHr+W6n5IRZOtbN5UDvjAJccliv6te4PKyl1DD5QiLvG5gYkxka3kDpwVCkMCXNfNhnsAM9MsO2qumOSHXZqi0CSqpXTGfS+Kn7jj5UQ1R4xOLgV5fF2PFW+jvTzwkwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D6teQbFuDqFem1oRuyUcKjPHknU12HSVEOSdtrPuAo=;
 b=QqkIXUHiaIqJaZD5459AvOvoTFd47jMxfjSfGAqGoNHFH/c9NM2/lj3Tgc4eiLYurrU/rbEbylvc+qwaelaPdRypt45a5cohHqb0SYrC9MsDhlkcXRqFFT8C/hZSCtR0vbCUkT8QEvohFg6QJycq5MisjXDITnPqJcRHs9JISpoL5smamqQ2nehVaZyrOu0WX3uMie5tWNzmn1HvBnQdAepr6bOK0SoUs5/mDJ9ronlZ9thdYNE2Ju7zWpcJ2rkHaqgc53Mizl3qblrys/+OY6AZmtBPLlWHo5JEgOxp689gBWlelO5toFL0SlxIs8y0tr0G97rBQkeb+IiXHCYg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D6teQbFuDqFem1oRuyUcKjPHknU12HSVEOSdtrPuAo=;
 b=IHt7SWNHUvmIE+kwmwoSm+xG8Wy6T7MwPXGHFDBYFQUlDt+IrvUV9/Uih2sI4xsBKO9mN/AwUnghnHzA2pgv6lRIWi0r8xSwg/C2dwbT14vt2cWq3ARxA5wDgxPfGnvbs3RCZyzTtX119vQADe0FIRIrdUw/7/nMSqdgk8q1apo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:12:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:12:24 +0000
Date: Tue, 9 Jul 2024 09:12:20 -0400
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
Subject: Re: [PATCH v2 4/7] mm: move internal core VMA manipulation functions
 to own file
Message-ID: <upsnyynhrw2pgxswt5hzg2ptpscujtugkznwgighza4qth3fpt@xl6q3condu67>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <8622e12013139411ad44eca5813839c34574974e.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8622e12013139411ad44eca5813839c34574974e.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:610:4d::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 48080821-d414-4a66-c774-08dca018c5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ipUgB2QJaGaClvUGF7uuXvwuvCAefty/hFlp/S4rFy65aeH7Bnp51SiQpt5r?=
 =?us-ascii?Q?eHwxshTEfcdOiZo43g+iJ7fHeKfCMTN+yYtkQyRO67ae3C2VuyKOA3V6/yyj?=
 =?us-ascii?Q?HakYoPaipP4WdmHIasOEQYi47nrnKBcBlrOVosrwwHQVKF3ERXQfcV9UKA60?=
 =?us-ascii?Q?TCLqPPrEAYX3/Rzq2S1THBBgIGH7ho65t/xDAw3c0sLUqsn3ad6I8Kcm2Gyr?=
 =?us-ascii?Q?ya/gbjPzHmA30o7x+PDLfb7zH0YlZBTs4+ys4U+JY+WQ0vmDKhJmOKxLPbgu?=
 =?us-ascii?Q?t1nGk/B1rIDIGLNphM++qkq41rrLTRmOjsh3hhpapqxH8/UvH1nhUF3gbzrh?=
 =?us-ascii?Q?W1yraYZXb3hwv+2hR5Sp5WIZSbAfW7pwqaxuQ4nucMSxN9P/Bvvdl1YiniGi?=
 =?us-ascii?Q?pkkWSNglF1JsQo5fWlJi3+MkedpEEq5/AuX4cXa9vSyQpmseKt9LlnWtgy6T?=
 =?us-ascii?Q?zJdhjqMEQWRQ4XIUjZ2i57EV0kGn0N1wMo7KRXLYHfyAfZjhluu+KrRo6Rn/?=
 =?us-ascii?Q?vAPcP4CsMdFQupt0Af3H9a+PGOOgpz/mnYDljszEhT26WR3abC72tPZVFZ2l?=
 =?us-ascii?Q?LRc1OO6Q6fhbDITcB+1SbmtCtOaJCqPqI4Fc686hlnW4Woh9RdlH0MGat52T?=
 =?us-ascii?Q?dxQ7AKNrCjVS+am4SXucdBi4pn+HdgVwEDSL2sIJQSKib4Qxga/nyGNV0k5t?=
 =?us-ascii?Q?cKaZuwDOciOfSPCS1YJPX+AXkVW5Fexu2pzbcufZXdWAHF15umb8z0F/ae39?=
 =?us-ascii?Q?3aM+PmdpUnUmKYK7C88A1n8+4RdV7YOQdLkqnZXxdwXfn1sN6YbB/6wXSAfs?=
 =?us-ascii?Q?N7IcqjSPlOWX1W+aGJ8kPRNOcOaEgKPTNRORbeGGzTOu2x+kWbD37f9VpEqJ?=
 =?us-ascii?Q?HOMsSSxmGYEaviqfZBdckv2MqqBJLAqW3ImE+gqhHeZ9VxcIqGB+M39and0n?=
 =?us-ascii?Q?afOvu+xm1ZWSIvWbbBBoAxoRqj5fm7l9/aAQExLDkwxZDIu/8lpzPRh895ds?=
 =?us-ascii?Q?HhlsbjytlEETZVAfzLW/CVHcRx9nT7I09HZK6Q49WU3cfzmnlijgA7erou7+?=
 =?us-ascii?Q?Dy9fss+lxqpaQ48QlrREOT3z4lgG5NKQ8UMHGh49V2eUm0jEg3LG0jbJdxhk?=
 =?us-ascii?Q?Dl5RHrs53/5WTzlSrSaiGYLwKDeXbsYsDEVgE7hicppskqCcIDS739r5KZFU?=
 =?us-ascii?Q?86Y/mAyogFXX9IGz5a8ogOcdntC36Q6W/BhxN6bwFg01yd+5PMgJtCoWuz6B?=
 =?us-ascii?Q?rHt/FE6I7qbroS7p5VtqgmoBFCW52wDFkx7Cq5Es3143GEqnSKI/NsB0meMK?=
 =?us-ascii?Q?3IDmulyAN7y5dq0/AWURDyNOtZG5nI2wD/vL46NkohN/sQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jJpCRwojM7IEcAgtz9vtYFAAtcMuuMy2RnSISgyjVl9qXX9pDRhcsA6jURnR?=
 =?us-ascii?Q?bvVC3ssgQmLnQVX0HWtuXrn6PvIk43C2iWpThyPIG18i4TA6opywkNOAExKR?=
 =?us-ascii?Q?QRC2lavWh4iDCIKAHLvOfcWlg4errFusPHweSf08PYg9WGhTFoBLuJwgAuJL?=
 =?us-ascii?Q?u88Ti0uV6q2nHRTiEaJSRJTmqDzL1Y3ZkFJ3EG8oF0jtwCg9KooK22yn1xg/?=
 =?us-ascii?Q?OQA8EG/PACZxGH9Q+G8hJtRWNdgfZhCtcupzKyaJM+m9G78uo4uoM09uFSh0?=
 =?us-ascii?Q?0U/yjTucKIYxeCmy3BWE/84oVZxHeBy3UAHFvtmCTlAt8zhXXBIHZY0xK71n?=
 =?us-ascii?Q?xDiPKyYD8bU1EUJlwGkzXLaUSHM9eb/EzUj9GNMdX0DCh1UgBtufrRk8TjDs?=
 =?us-ascii?Q?FFhfvbqPLpx+bt7jgnPfeSb91qrV2g8qG5V0vBm+bM26np3+rMjW9FGahuh9?=
 =?us-ascii?Q?QHtm3cFMlZPjC14+kIa7ALrGVsaDhVQO9d79bfnwfSdqkgWDAJIe97mFSCgu?=
 =?us-ascii?Q?v5U6GpstDY+kQm6GP0Q7cOjJcHUpG3MXbX1eiaA0n2+Ul8jHkWIep+TDps6e?=
 =?us-ascii?Q?e6u8VM3KMSf6P4MjMlTodmB8WWskwRPDcImAlTCMs6a3PA1bgk3nRA8FpppV?=
 =?us-ascii?Q?21jaZAnVDeK5+ouB5Sx5uhzKE7YepoAZavirTKWvKu2h9A+KaFJ1TgtEZNpG?=
 =?us-ascii?Q?jeF91n50LxxuMMTUd4+hfbemW9wi5tK0zDKKkOJyUWRYeb2NJwUpXltyaYSv?=
 =?us-ascii?Q?KIC2OamgwviSXVyrkYsIX3KopdPghctmZS0RFadOszI+ixU0XUKn+FCHRmWL?=
 =?us-ascii?Q?2E03onazo1QcpzSr4Rq/xbKV+/FnK+U2BkxG4T2UdIpOjRzVWuLFc+CZYwbi?=
 =?us-ascii?Q?8rjkVw9J/BXN9UfBr2FFqMGA7u8JSRYPX2gmCcqMp2hPWd2ID1c9FNysEjKa?=
 =?us-ascii?Q?zv8xXQl42eFtskhdgHyKGCwIL8L0tk+eyU7l6A4m5feAJHjg1L2cbc9uXjin?=
 =?us-ascii?Q?VzBNcxFQ3DeaQjEL7SgselV+UUSA2dT4kTmgRzHvfViL/I+wEHCLb+6zDeWZ?=
 =?us-ascii?Q?LgV4q2wd4GS3Ta/I6VTu9G24MfdQgky6ghAp2JG4wsCTnfpG07gsG0DDAd/U?=
 =?us-ascii?Q?/C6PpjRUbt/29BV013HVoRWBS+rsriMPhrEDdqXXqT5YDksqBSjpXZI9tkN0?=
 =?us-ascii?Q?EiT3G+gNs33nA29HxfKOvOWQ8CF0bv7mbqExliZVEst3cFVtXS5Xk8owpYQP?=
 =?us-ascii?Q?h2FZZg/VT/pM4k8IDpITAUL/uJfQi/rh3Rnj1koHFIL+IqwWemXlQpIzzGej?=
 =?us-ascii?Q?KDBPXzCGa7pvuphD2JuUjNYVxJdXBCEU6O7bI6ILk24u9WfAs6QreuGNEnwG?=
 =?us-ascii?Q?/NZGM5ylQO3AGrYapsWvdxUCBo74LtaH59EWXmYAbnPm5ISf1sZv4uj21jRw?=
 =?us-ascii?Q?lDQzFSJ3oQsRuoH+XVA5s/uuQgkqoOLII/oXV63Jv701oc6y4hNGJi0UsFrc?=
 =?us-ascii?Q?r0R9aCSxMDXX5Cq2+pX18kjxesNWBS4up3muE0caejWZXfurQIyRv6QSjOwA?=
 =?us-ascii?Q?Zws7tK/cd+MP/BGmax5+xKNuqQhD6j7f27WEw+N3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N2hi81xbp8woRIW623hM27J99jLwbSOR8aLPVLfrbYxoZkYNv4Yu9kdgszyG41Ubd98z2u9i/9QEFg8n15xMBUfUjqKq3xk6kQDTgPjG0zzVrAgJwmiQxm672EfPn+C3RE1ncKZMQIkfCCkkbA3DjyLr5kFz8Pzk4usrfKG6pD6QkqRw8DSUHyp9jCKcfh43E/YWnVXcd/AEerRzL2vkKr4MhIo3GhMsr5oChtKZy20gDr75Q4y9koWrzHcKE8ASLvnM/YW2OKEpmNlN93T7SBnIb+Vx41W04w+Sz0lNeRLAAWNnqPJdTvSDcwCw9bW6n+1ddEPwoPi69a4DZ+U69FdNIR+Q8I3Rc86EgVZqLsBB/aAN5M6y92Vi9UwkjGgs90YEJLJTC7/GHFSY6G73VeR4yqN9sVIbzPXFgfB7oWGi2Q2psw5TGWXitdRMkeMpJvK+MBJT+puvMQu1HtXp8n/rBjAD5+a0iJZr4hrPu8y5d+AonWK2hXUPopudVYYuYEduSjMXtbT72dFLlR5a/F7qceFV/5bdniJisRWoJoIbNWM6NvnLAvmNREzkSUBxRt+nahUR4GKgcORX7LSN6msgzTeSN3YMBofXqj+dkt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48080821-d414-4a66-c774-08dca018c5bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:12:23.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFTu8UWfAP0CiXP3dmZYXy9hlp3MHtRmtNpiQT+GNYsZVoVO3NKK0KKG0idSngi3dqeGxXErL6mVCqag+D41QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090084
X-Proofpoint-GUID: 8bbMi8teJmExztEV5RzHAxgBEE-QFpIp
X-Proofpoint-ORIG-GUID: 8bbMi8teJmExztEV5RzHAxgBEE-QFpIp

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> This patch introduces vma.c and moves internal core VMA manipulation
> functions to this file from mmap.c.
> 
> This allows us to isolate VMA functionality in a single place such that we
> can create userspace testing code that invokes this functionality in an
> environment where we can implement simple unit tests of core functionality.
> 
> This patch ensures that core VMA functionality is explicitly marked as such
> by its presence in mm/vma.h.
> 
> It also places the header includes required by vma.c in vma_internal.h,
> which is simply imported by vma.c. This makes the VMA functionality
> testable, as userland testing code can simply stub out functionality
> as required.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


