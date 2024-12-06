Return-Path: <linux-fsdevel+bounces-36667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D709E7800
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106A9285978
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E84202F9C;
	Fri,  6 Dec 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j8fVbEzs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="USg32rZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550521F3D46;
	Fri,  6 Dec 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509212; cv=fail; b=HmMLoK/ydGB1tzOs1ivZJ/SAcGkaO7rq6mxm2GhSo6tkGXqA3DYGQOzRIFDx9TMW6mr2O0j/f44QoE5PcFIgq4SCJfUc0zDn8hQyP/pOxUQ5Z7jSpIOxyrBlK+3NFQCHeELEGINaEsw3C2jjZJVN3b4wnG5j/DshwtqaIc/bgM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509212; c=relaxed/simple;
	bh=qE97LNoo5jvcvOu526mno9mDJ0/5wTTs4ZfzvzsSRBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmLP0840YUyouQYz/r/v5Cgk2hfdxyDV+b7HuuFJ9kNUw2aeyfh49d670y7v3golYDt7ZDoDh92p6aqrQtmq823Grcf/v1y730gqvHvUc3drTmVjQR4Px/zCiHtYCz1v0NnTqrm700chuyPszlQZBjs47zPMKkeQyGEHZZZrKas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j8fVbEzs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=USg32rZg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Htsuf016502;
	Fri, 6 Dec 2024 18:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DDndv4L0OGAOyJgUXJ
	Wh1dmoSlqq0TVXRvkYq+VsvNA=; b=j8fVbEzsDp97qgdz5lUAJvMav7XdxPy9OD
	9F1x5f9MBBlYCRP8qjcGOhOLR2wMGIoPShK6LlelaSSt0MRDmhME8+bGD4ycIvlR
	SS5jPb+3syWdWGl/7txTSMPUC8DE1HLurkTIYvPVQGArJR6Db5NwL6cibIg3dNzc
	50Dm6g9vS/4iwwkduHq/rt5ffm6w2sTCwbrBVd7y1WxUbK8kKARB6LkV+ZEnvfIz
	khFIJIkgStWbvyyxt/vOYlZkbcmvZGnF/+zCYLDDBgu1sMybFVOLzENmKBISYHnt
	GDClYptA/pdrpDePdljFNz72L/F7Xx8USqToDT0g8fjmE+TOMbUQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbx4f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 18:19:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6HNC3H040008;
	Fri, 6 Dec 2024 18:19:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836yh3rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 18:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UREZZpEZAWLZMGt6g1/B503mKMl1Ewd1Poz+C2CuhIyCU647WzesMxNNpGiOgdiNaJibMjVF9C0NhSAdbTT976yN76c6m0XJxBELm/KYtxTursWZ3uloEOM0bSRxYqEm7rLXAymxXTfZt0dmFvUNu1GuAAQLTTxA0QtWFEhP98ZxyzASa0v2iWKJQqjypSUFbxFvk6hQEaubhSTZkAV/Zob0ixHMonbih5HaugLjmsdRbG4vpJoN5liPSff2kYTuGCOlUa6WLegOOcnE7cxHrT93FYsSH+9WROmLxGEK88JwovTjfIARVG8ay8H/oeTrfhsF6tefuUnQ5v3C+A6c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDndv4L0OGAOyJgUXJWh1dmoSlqq0TVXRvkYq+VsvNA=;
 b=inforzJaP9ghq6naK/ILuasB19GNzNdp2RkYrhUsBCNwH3lw/cPhCaY3dKCJv9Y36/wU/B3JUTKOIDngVSsNtvwA3iCZH+H1oGA4L/5o57jALwZzAlOo4kfVtm3nenbmupXnONxKNqnwFQMsEiFZusGZX3/ma7NQ7zUCBtnn59/VG4zBWA4WEOU2aASHcdvwuxib9Nabmdv9LzztkNRb87NdG1QIUEi+uVe46wg/UIwbX5iKGnIE6Yxxnzw8WY8md204fVa19oe35BtV2eKeaS0TQK5QvBzzrX3LqFwZ7QR+40bLfssrVeUUEH9yKvKWs3mXJUVFkBn9Mtw3zZExBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDndv4L0OGAOyJgUXJWh1dmoSlqq0TVXRvkYq+VsvNA=;
 b=USg32rZgWeWseRNOOz5/73eey29SxqBpig6Pyt7DB5huzeKUUSpf13c8eQR/lex7+IzLKmu+7vu8uPKkdAwWj33v6pgs4LLuxw8mDkC465iEJT+uE06CjcQWvZw1qegQ+49aGfXrLE47+ES1inBIIEMGR3Hb/0154wPyqbWc2Mc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 18:19:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 18:19:52 +0000
Date: Fri, 6 Dec 2024 18:19:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206010930.3871336-2-isaacmanjarres@google.com>
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d38534-226d-4d1e-5b62-08dd162293c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRfyUsuHNUXsYdVN9VlSA5GwJl4W7dDNssANqkAxkQoFezc27OKFyXFqQdJR?=
 =?us-ascii?Q?VVuM7AgziN2UydFe3JFFtJp6qIhfrEvqCgcj/fLfb35+QOrcWzkDWCNsOabZ?=
 =?us-ascii?Q?5qkhEmA6rU12S3/omu1Yw8LZPWCAII/6jWX+4FnrmWvlFFoIZDY8ExzqPKF3?=
 =?us-ascii?Q?IxAsf71UrZvAQjnMsa2z/7XxvcYLgLHGfMwNYfb2RxkJLiqRqCFZMXfJMOh/?=
 =?us-ascii?Q?2+2hWPM4Je+SC1YFAwdi3c4YgrjyS8wVUggz+xHpx1epJKfyxUpVSXmuzZCE?=
 =?us-ascii?Q?xT6qjJwabd4vt1VxV/TP55ojkcbcuJRusLkUVl+36SdHc2xuiiQzCCDeGqi6?=
 =?us-ascii?Q?LAmTzRkG+HDFWIN91kgvtP4zXpwVW3bsO16JJv7TInRuxrXcQda54qAiJv5u?=
 =?us-ascii?Q?XgQkbRtTudpDsPybQB0NdQ6TCpR+lvQ79IM+20xpT2JSwbWi+ChSIsHNy5kX?=
 =?us-ascii?Q?y6Pclx2JHE81y1rpc8Il8agJZL3Feq45DiFL+HYjEiLen+xUkN+CH/nXQltX?=
 =?us-ascii?Q?qtzdJJqK6t1bgVOljrSGcI+nFi4whNuGhXrLWGNg9vOhESIJywWS2xCcZfLy?=
 =?us-ascii?Q?N3swOBDm5OxoIoKxeBX+M7K7lV8KHz6pMBLpWcUKuxnEDWZ2Ye+WuhcojNkB?=
 =?us-ascii?Q?rULjK6Ct5VGe3nvKDq/y3cNxIlmvdOGmFrTU1UGqe0jFhwAYVyF4JyxgLn+R?=
 =?us-ascii?Q?GzDAN2r/qpjAKX5JEru0SrBxzbsR4OoH4dd+3hcGpqPIVlhlkps9DlFLcuv6?=
 =?us-ascii?Q?LaF8RXyiyUquSQIod7zJ31TBlHi1ykeAJyM2L/ChC0de2uJ3/kwppsr/bWmh?=
 =?us-ascii?Q?8qQoVg9A7aGpn2YrGvJosaamP9bW8igF548Qa/66lWizXIAxYSPFvw3puVr8?=
 =?us-ascii?Q?2usB40kEx2bLSUFkLfkm9Hsl2qzxuO0/78nGU1v3kPYaeKxD790jEEEMR7dj?=
 =?us-ascii?Q?3M5jomenqjg4jKHxmQOdHp29A8e6sp34VtxXQgngQNown8k3pCWUdzDKr3Ca?=
 =?us-ascii?Q?qX8aEQvoRLwHf7Vtu0agPRKY5UcDUgcQX7xGDM1ILQLtZcdHk1QR0QMzQvKT?=
 =?us-ascii?Q?odl3FR9ACpD5EGpvSaPIUD6+M0YTiIL3qPSNgAikvoI09TOH7DWPrEhL2Th+?=
 =?us-ascii?Q?7trQEnpYY3UlEjVgYnNUS2vUsCO6b2wLuLJ5KNTD6eVCxcnZqbzxo/U8SzXS?=
 =?us-ascii?Q?Pa2AEtE6BXCcBWJIRYEHfABuH76T3WqAwBf6J3Tdy4pDJUZTb0jNVGzpupGr?=
 =?us-ascii?Q?L96r9/xT1RcxH8tKqHnFLntos8WlmA4TbAmzZ/3+8Pue2loBsq/gMkjlLZry?=
 =?us-ascii?Q?rTQ3SGYl1eln5YFXe1g8Qb/qaYmlGIXUfNr1Q1ukuRtGgDflOrY3396Lr12T?=
 =?us-ascii?Q?Vv/PLFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hB6bZSvxWDE5+8Trh7zjexhqAO3roeV/xRpfS1e2J1JWA2oAU6BRH+PoIRxY?=
 =?us-ascii?Q?HaprRFZh77PGLbc220o5FkVrKU0h4/OOWi73y2J4vLiRcK+6f5Z+Y+ILzohz?=
 =?us-ascii?Q?48hoUmHh3LPc3Y93bDQKhNRQqjoSQLYO1HA/YxlEhjyTMcgc95pmIwNorDfg?=
 =?us-ascii?Q?RFMz5OK7812wXqu9Y7e3PrYRDqBqKYl5eN5Tc7PddnAqpzxnfSeMFpS1XVQ6?=
 =?us-ascii?Q?pgcWWLu3d8PtDzwk4V1evkPHJI23MKbPoiAU2Sntof1dL97FPJMa/iFDEuuz?=
 =?us-ascii?Q?hOBmuoX30J1ACJ0W1b1OgyOYxCzsw2XAFBMhGHxvurRnv09jHToRu9vqSNl8?=
 =?us-ascii?Q?swGkUHDk0HB4l9uw25YhDS3hLUq3ihbJ9MEJL8Dpf5BHap3QXQgmjKB7ICCl?=
 =?us-ascii?Q?dYFlOCFUpHcxCrKEMnZe8Zg83OUsVAypOx6fz6uSMBb2JNZT1VHyI/bazS+z?=
 =?us-ascii?Q?KhmDH+e/weiLjmPmc9d5Vep37zm24fTcDtxrqrE9QK4omEWFF+PwI9M/2eHu?=
 =?us-ascii?Q?yXd3ct52zryHf70lg9X06yyOT8NP2ZnekBrLkS2a7FmZqqhfSdCf+nr7Ta4F?=
 =?us-ascii?Q?ecX1J1yw6RcVKxEBlGWqme0Tij8YAOdZKDiGc+QQuVwfqGJnb+er/PsZwDKX?=
 =?us-ascii?Q?T68cMqvAF8yZeWcMspZC7Iy2jK76tmdBZoLU1bHnOga4/h2J+6V7rWW3kpl6?=
 =?us-ascii?Q?JX/EMfiypoj+Yu8K8rHhhMciqC1IKK/9bFM4ZWWbduZuPAUCH5Phkh4zs/ak?=
 =?us-ascii?Q?OiyI9CBkMxdom432PQE1LjmnEdMuPGl2nh/8N8SvzqssxeXU0s5MB1kx/+Hi?=
 =?us-ascii?Q?wCDoxNYNc7JCy79bfCr1Ns5XYvaqReepVY50s0Gl76o5HF7MaoT4ZxJTiUl/?=
 =?us-ascii?Q?4bZ1yB0hmq4vZAGnjs/mcs7lA+8MH7mEiPMmAethUxEBUGTlDHNhw9I1Rl0R?=
 =?us-ascii?Q?7vqFWbX4RHQCXzAs/+oNaasYixJX0dbAknLbBWb3qDdtPkHx2e37xNrM6EUp?=
 =?us-ascii?Q?1vEC71IC3Pp6QA7RMU5sP0a+l9KE2mqeUnqbFuHbjuDxHbuM1W5i+H7PJ1Fe?=
 =?us-ascii?Q?0sdsUyQKF4+rtZU4N1mF3YBU+1G/cJ8Sygs6DEMVKWp7i153iBu7NQzNYNvD?=
 =?us-ascii?Q?5NaqRAqy3AZNtJikwD2+Oz2I/5LN/bnNdtb9HdxjkZAFxr5qGWRYCBGizutF?=
 =?us-ascii?Q?Mo1jL2t85fFWgrgZwJEa93QPCEXFDyPbZhAS2WsD1Ay0IozEQE/VkLyCyeUD?=
 =?us-ascii?Q?4XwLtTnb+TNz/D2xRPYwybNMdrtRFzWDKaBwCQ1fjLKegWTIGcQSg2H14oon?=
 =?us-ascii?Q?mYVEmQF8wtpmzD2Hf66G/0TQ3Aeb/SHHoAxztFLHMQ3UyA/F4zysQ9RFCRzp?=
 =?us-ascii?Q?I8Ox3OxujNa40iONLRZIZMRi8EQoHfPSa+cVZyECPn1HHn6yOunAd1sjJGr0?=
 =?us-ascii?Q?ktyL/DaNBqW2YJ1PSmrodjlHzs6v54kcMY5qI6nGEYJNvMHO8wg2HkVRi7pE?=
 =?us-ascii?Q?3nm+kvd30MaxIJUn73wumlI1Ose4rD1ZRjGoDAEhngZbxhFMaOC6LSIFMJ7k?=
 =?us-ascii?Q?oa9zoPkeS1HiY+tb8tgkd3R9o5EHDoMRSw7WURo3ui/LJGsWdacNuiDsml+C?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ipr7QXuQ45z5I/wlmqWxKk3hRGI4lLGooiJ+l4Y26WvwsBj97Rl6DSJzTigD3XfM4hJMSbI6ioC2rhCxjS/CECPYb+envQ+tJtZSonqqTV/WL2EP7qrW1nwZjyDzogQ92gqvVQ6rVrjsyXmeO7pCKFBjcytZczc01xZE+Gqz86iRGIKKhTjO+lVSBY5hdVfVfta874nIrfSbOewCn2IILXc/QNc9gnmLUnTiyeZ0okF4VzAfaQw1V0JfR9+pp3PqcEkf1sg4RutIA3Iq4O78r3sKHLX7neB114DS46QMjJ8vY0MiwhGt1YhKNbx6buwZke8RQiD5hYII86lYPl8z0wlU7ltwROWhvY6jk+5nHGC9/Q/7gWmJbYkEMRhSX8f7twQLTUAGtiocuC7/5E1ZsqPsq/9POQJjkDEZ4tGTvJcdsO+a/hGoy76ZEYna//dj6xNMlrLJuR8SB4ebGFi3eWkKCBIMVjQtYGWRCNCuJmTQf94V5oLQF+LMuU1eFNclN1Kf2l49ioN7rUEuECI0yMY9Op6UqAnZyAtdR11iiJkc9R0q9IhrbGxtLG+yHjPJ+Joh+CfNsIMnHRxwcsTI8B5n2l0+rRovUwLjIa59ub0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d38534-226d-4d1e-5b62-08dd162293c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 18:19:52.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goeihIPDJKNDpi2cAUzjSh42je5Xd8bTlbglMVw7mEsxO2Y5ISDNCsc4QyZCZ/ZSAHzV5C+zkjhK2rnA+Kgjseb+PVEn18KFhjn12wms8qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_12,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060138
X-Proofpoint-GUID: KW294RZ5cDoXepx_wJLLgfHCwCVMd34r
X-Proofpoint-ORIG-GUID: KW294RZ5cDoXepx_wJLLgfHCwCVMd34r

On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> Android currently uses the ashmem driver [1] for creating shared memory
> regions between processes. Ashmem buffers can initially be mapped with
> PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> permissions that the buffer can be mapped with.
>
> Processes can remove the ability to map ashmem buffers as executable to
> ensure that those buffers cannot be exploited to run unintended code.
> We are currently trying to replace ashmem with memfd. However, memfd
> does not have a provision to permanently remove the ability to map a
> buffer as executable. Although, this should be something that can be
> achieved via a new file seal.
>
> There are known usecases (e.g. CursorWindow [2]) where a process
> maps a buffer with read/write permissions before restricting the buffer
> to being mapped as read-only for future mappings.
>
> The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> that mprotect() can change the mapping to be executable. Therefore,
> implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> since it would not work with the CursorWindow usecase. This is because
> the CursorWindow process restricts the mapping permissions to read-only
> after the writable mapping is created. So, adding a file seal for
> executable mappings that operates like F_SEAL_WRITE would fail.
>
> Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> continue to create a writable mapping initially, and then restrict the
> permissions on the buffer to be mappable as read-only by using both
> F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> applied, any calls to mmap() with PROT_EXEC will fail.
>
> [1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
> [2] https://developer.android.com/reference/android/database/CursorWindow
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  include/linux/mm.h         |  5 +++++
>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 |  1 +
>  mm/mmap.c                  | 11 +++++++++++
>  4 files changed, 18 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4eb8e62d5c67..40c03a491e45 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4096,6 +4096,11 @@ static inline bool is_write_sealed(int seals)
>  	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
>  }
>
> +static inline bool is_exec_sealed(int seals)
> +{
> +	return seals & F_SEAL_FUTURE_EXEC;
> +}
> +
>  /**
>   * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
>   *                      in which case writes should be disallowing moving
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6e6907e63bfc..ef066e524777 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -49,6 +49,7 @@
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>  #define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
> +#define F_SEAL_FUTURE_EXEC	0x0040 /* prevent future executable mappings */
>  /* (1U << 31) is reserved for signed error codes */
>
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 35a370d75c9a..77b49995a044 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -184,6 +184,7 @@ unsigned int *memfd_file_seals_ptr(struct file *file)
>  }
>
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
> +		     F_SEAL_FUTURE_EXEC |\
>  		     F_SEAL_EXEC | \
>  		     F_SEAL_SHRINK | \
>  		     F_SEAL_GROW | \
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b1b2a24ef82e..c7b96b057fda 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		if (!file_mmap_ok(file, inode, pgoff, len))
>  			return -EOVERFLOW;
>

Not maybe in favour of _where_ in the logic we check this and definitely
not in expanding this do_mmap() stuff much further.

See comment at bottom though... I have a cunning plan :)

> +		if (is_exec_sealed(seals)) {

Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
I've not tested this scenario so don't know if we somehow disallow this in
another way but note on write checks we only care about shared mappings.

I mean one could argue that a MAP_PRIVATE situation is the same as copying
the data into an anon buffer and doing what you want with it, here you
could argue the same...

So probably we should only care about VM_SHARED?

> +			/* No new executable mappings if the file is exec sealed. */
> +			if (prot & PROT_EXEC)

Seems strange to reference a prot flag rather than vma flag, we should have
that set up by now.

> +				return -EACCES;
> +			/*
> +			 * Prevent an initially non-executable mapping from
> +			 * later becoming executable via mprotect().
> +			 */
> +			vm_flags &= ~VM_MAYEXEC;
> +		}
> +

You know, I'm in two minds about this... I explicitly moved logic to
do_mmap() in [0] to workaround a chicken-and-egg scenario with having
accidentally undone the ability to mmap() read-only F_WRITE_SEALed
mappings, which meant I 'may as well' move the 'future proofing' clearing
of VM_MAYWRITE for F_SEAL_FUTURE_WRITE too.

But now I feel that the use of shmem_mmap() and hugetlbfs_file_mmap() to do
_any_ of this is pretty odious in general, we may as well do it all
upfront.

[0]:https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/

>  		flags_mask = LEGACY_MAP_MASK;
>  		if (file->f_op->fop_flags & FOP_MMAP_SYNC)
>  			flags_mask |= MAP_SYNC;
> --
> 2.47.0.338.g60cca15819-goog
>

So actually - overall - could you hold off a bit on this until I've had a
think and can perhaps send a patch that refactors this?

Then your patch can build on top of that one and we can handle this all in
one place and sanely :)

Sorry you've kicked off thought processes here and that's often a dangerous
thing :P

