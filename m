Return-Path: <linux-fsdevel+bounces-42221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F8A3F3E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6416E357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF9209F5D;
	Fri, 21 Feb 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IPWAltJo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Si4Xnoq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB20E71C;
	Fri, 21 Feb 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139548; cv=fail; b=WHoor2esJsNlecNi/ROVdGDg7tcDe6EwLwugjaJqR2SwBs0njjNFz8KBJmeMEoWss3VhWGeNtT301FhefuKGIuOtgTfh83n5vzNq4gZj2/dH6CAcv1pHzCARsq7ER4PzjWURA8AhGqOFQExUjqoXivlhL2jzqntHIVEE3vbA86U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139548; c=relaxed/simple;
	bh=ssTonn2+0suZifZwx+lCVrum435w9wd9xMYyzRqw/bg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kqXUikIrXcg6poybZy54ckDblr70clAABshlP5ibYIdaJqavZOqMPzzQm+TNuIIWhTuul+BIDCA7wHfac0qN1LozUivdQx+CvByQL0JlgbNWEwK/H/1guxh+rXV+O42mKOkwiQsdxY5X6HaockYNf8R7ahWqWeYfsQXglePLMv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IPWAltJo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Si4Xnoq/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8ff6C016642;
	Fri, 21 Feb 2025 12:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=MwPqZZ5uihCw0/Ur
	EoxROWhl2BKNUq+EJJT1pxxyTnc=; b=IPWAltJo6uygzdXHGaROuwhg7wZLIBg7
	pd+o/rIWxssHY51tL9R6Pmm5CxAqVLjCGlCYQMiAlGnxnsL54Ed+4lQDqJqtCRvM
	MuF/EwAE0sy9+SmFmD5fxJSYIF1J09M4ljgYFGpXHWE4ehF7SgZOg7Xin/T+eolA
	HYX57eriPNnMvCWxqRnE7Y8nNFC5143iT7i2mWa17ym93E94/M9eRpo6GYycOVqb
	m4ga2nxCpkBui/JkecBVaRvL2BvEoT4yDgDaCrqT09Io/SHz/uHCa7nt2cfZs/ov
	bWck+8rT2y4uUdWFpwqdNAK2qiFsPKy5//6EhcUN55T2EWXMjn0VxA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00np3yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBGubJ025565;
	Fri, 21 Feb 2025 12:05:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090g4yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS78p4Hh2l0N1DJifI6wkKXvBb72YGySeJRgJ+rpListW7WhUR17wl0D94bZjz2ySkbycUiIa9+h6N9dqdL70JYj5RGf48x6Bxr6elrmPR2oIs13zSKrm5B0UEQ0mfjmSiJ8Ip0PbjEipbPX8ER+Yn3Z4+NMRhVyEJxl+K1SrJ4RzFP879yzsc/PEhGs68TUUxafYVgb8/vsmtoRqX7698BXbKfiBD3DAMfGHhZ+bewDv2LhUhGpV3cTAwMWmRQ82+TxoiwXb0OBiHBWK5pz/Xj3lsEj0QeZYJ+y9JpNIhbVQJYkEGmcuYVSFRzrbjfvIqqFd6BOpXXrZz43BVvjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwPqZZ5uihCw0/UrEoxROWhl2BKNUq+EJJT1pxxyTnc=;
 b=N8CRDgFejjH94q9IrSFveP/PVbw2tupUHn7GkDC76fyF7L/xpm7iGC9PA9LsOHN3UoFjeD+z8nRN8G93rwZrwo4buswseOaqzyxcgynHj1IkKnfxXa3pkQKCi0JChIhJtBXOKOVhpfivhA3eoEACk4GiUd9EhCYN6IPsO+8NkCoQEeINbbXvoqyWM5oVuzsIYXAFtWQNIEdc7qw7bztiT5Ng1ur/foh+qpEisCdct2oJxCf44MwnswzP6c9ZxAO8SVvD1whJziD7zEMM62H88OprLDikyoZWLtly+1yCKiJrDuE6BI6b2sjOz4MvFScMRAp9LymrjJeMIqd/hxLm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwPqZZ5uihCw0/UrEoxROWhl2BKNUq+EJJT1pxxyTnc=;
 b=Si4Xnoq/M1jBIhU2fq7T8FrpmDjBcpPl8wfBrlX4udsI8JeCGGCC2Je8fcj38EJvFXKsoJb5TrPtj4sjeUSfRqZRId3h0USCh4lVSlGxnPsSwqRWdlS5/SGxAjdFX0BV5NfCn6LW8+WUbUTNY+7T2ynfORo+ZbuC/DTPnXhlKQo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 12:05:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 12:05:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 0/2] fs/proc/task_mmu: add guard region bit to pagemap
Date: Fri, 21 Feb 2025 12:05:21 +0000
Message-ID: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0534.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: d35d363a-eacd-4563-8826-08dd52700740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWSVOijCuOonesy+yZpgpSSBcjrIcH28jiCAr+HV6Sf0+Oxl/Q6E2qdBovZl?=
 =?us-ascii?Q?4a8lBFAgtBh0WoGqZ+IpY0ebXrL1Sqlg1/71J/j9WP9Z1GoT1gsiU04IJg7D?=
 =?us-ascii?Q?r23yZQR3pko4hnL6ZxfRGFHpSzoVGakvMOFTphMIqImbFQDUIw3cRpm3oOlA?=
 =?us-ascii?Q?EtLJromxSqoUIpFvfdfXpm1C49Jg540q08MyQP1KhpK0UfCnEegt/+U3YxSR?=
 =?us-ascii?Q?eGUGDGP2nuLc5xwRcSf2rYpP44/29Tt1IKecF+MzcuUjOp42ag7Y7/VTxZr1?=
 =?us-ascii?Q?wPBUtWHO8cXmilUjabNzF6bRdtuxOCkYkqR6JR29O140qNRyUA5wuC8QZzxm?=
 =?us-ascii?Q?Li4YEvy05kXFIKfFdYSxaD2GUUH5doPvtDn7hl+JqgpCv1TJTzRmbQ/LGmNp?=
 =?us-ascii?Q?5ndaF+ljtRED4d8lz9WTjdm2WsDarwEmVr7DogT3FmQoOMvjOAiZEUZ0jbNU?=
 =?us-ascii?Q?XLIissiTXzuRVCwjZtLkBqnyt77IonSO/vc2iRfD8AXweFjgK4I+O52yaZkC?=
 =?us-ascii?Q?ov3inEUQkR2Jqngspuh+JCUsoikhWb73j/1xbGQ1RxAwJ3il0ePoBuR4Jkb/?=
 =?us-ascii?Q?A1i804BdASevdVR0YYFdP81XxTvvtyqd01Jf0am/ZiuKTicKqt4x1Ci7c+Yt?=
 =?us-ascii?Q?S4k/3vpTXDDGgm2n7XnNDnJhWtWwCQnj1QLRFBcjya+tazmSlBOhQHhTlpWf?=
 =?us-ascii?Q?omkuR9xdUQt4ndfOJ4D7NUV10A8uUk70yyZ+BWk9I87yx9LcWl59o32Mcz9t?=
 =?us-ascii?Q?qbJsRX0EvuNpd5ksy07l0et1PLx2V92JyYT591ppRJv2iCsY45FPM8fjammK?=
 =?us-ascii?Q?X5jzrmMnphqtYTGQ6su+8LrXEN2nLgO80695ypHvU3tjWA6Ic8o7xva+5npY?=
 =?us-ascii?Q?CC5H4clM9IBL2wN4DQIBRJ1LLJPvwGlPztBLdM8t3UQskGDefT05AkK2bbC6?=
 =?us-ascii?Q?YWuVhpkV0YEnvnpDPr5gYKDwyELH0iVdGNIdrDRz2SqAbAU3xJzhmO25j1Pb?=
 =?us-ascii?Q?5ZCvurQzJ37sfBTUfH7q2MdJAnS57WZJHq1W10O/L/+yXUW+7A0t2KYofOY8?=
 =?us-ascii?Q?P31PblWyu0YgzUwjg95MskpqN//xVls1zTFkzSm/MkiSdx6LtG1qOzMxp26a?=
 =?us-ascii?Q?I7LbwOcmwXQCKTFU/XfFg73LOco1zForSWVnlkxwNqImZHeG15awdgTZQ/la?=
 =?us-ascii?Q?klLGXZviw+SkKggR8Dl4kLDMV2F90/NnCb58GOCHa8pSQWSe0vsCv4/5lf+4?=
 =?us-ascii?Q?ODFajRtB/hypLCUK2rMXNnDz0Sh0rxsnOOYpooS112AQg8tBF3Erb2uOo4dG?=
 =?us-ascii?Q?FdkgyfY6p17701HQgRTCDWa9AUkfCWO4TgdnWQxW7X7vWK0RHKqYTjT7tey2?=
 =?us-ascii?Q?NH49JB/7yZYjM0xt4yPr2alwqgiZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coK28HQLCvqA45iaKXauKT/zgg2lchoinc9MLuadqgFFG6zYJY2uV7Llt2XB?=
 =?us-ascii?Q?USgR+P98pUBXa95WakgmIe9EhbjsGoCRpdIKbHOPDH/dWwqGF3AfEuC/EchD?=
 =?us-ascii?Q?/y67loiwAfnzzirzZfgI64Soxct5GE1l2/NzzYMHod7oZeD8+in/NmUxCUlP?=
 =?us-ascii?Q?gOxcR6lM5svJlZJFkX7dGZvDj5r3vnzFwtMCxmVy0Xb5tTbkJ8LDlS0Smkkb?=
 =?us-ascii?Q?NJc9v7uIn73zlTiLePGO38vzJeAkoP1T9eEafxSHqXzWWIc90fYukrznSem1?=
 =?us-ascii?Q?cO2NlRUli6nbTob61XHITYgdOpqEdcCMhDvptkv5F/7XaaWJ0AItVRMBE6IC?=
 =?us-ascii?Q?wy63UHQJ0nHFRo37eKCtspzgkK0Olc4ITN0gEWcMZ2/SE+1cWfjMMhOYC8dn?=
 =?us-ascii?Q?IGghsfj+h0pk1CgLDDigdMhNpLtAOsHrVAXHUT883rYT3tRd3t1XcOgJxjvU?=
 =?us-ascii?Q?eDMhCJqcXUMkki6p4B5b/TXeqaLBpILDtukLyJwt6tHuqfLNn8+JkkUFwRfZ?=
 =?us-ascii?Q?4U7Xfc72Qv85IRKRunniM9omf9hXKVAgyXR/JjxmHusr9HaOiCEcclHsnqEO?=
 =?us-ascii?Q?+S3xRDn3opMLCmT0WJIjzIXxV/g/QeUHZ8aK5uUSxhfkdnQwvRUj8oUHjwvS?=
 =?us-ascii?Q?fGuY+dK+FyWIdlxyaIIvwb9Axm7HVo4ArvvGPY/hYJZosKw0gunm0vBVrMl1?=
 =?us-ascii?Q?B2YYXJDOP4mVn/mS1TXPNyxLzr04G0y8t794orTS5q2RBD8R1OzysEFmAkxg?=
 =?us-ascii?Q?cG79WMZZ5U2L4y/OGrhdQS2LSLya99Df4RHtIBPD7HEDiCe4HhTPEx+ji6bV?=
 =?us-ascii?Q?44zYzB9WuuW+UwkWRecgwujVKlKJtIC2uBbK5OhUVTVfQSBjvgNEg9B8APM+?=
 =?us-ascii?Q?5PtnHZh0WMiaRkTEZvW3byAja9ZDjh7EuxIU2tTYYKCrm2Gj4VzorS8wnYpc?=
 =?us-ascii?Q?VAMoRb8S17fE/XvDRY9yr35VZwaXvEvqIUjuV5Xj23CY/yq+wZFyDSzaA713?=
 =?us-ascii?Q?URrUYAakX6lpJEFL78B8ypVIsfilZ7zSrFKq3W/btxW9fRICsnGRaJqA+Hf0?=
 =?us-ascii?Q?99fROAM5e//LxJTVKkMVHJwZw0Q9aup42e1PY1Y3g0x4Wn+kK4HOhVQUibH6?=
 =?us-ascii?Q?B/DzOoR4435oY3tr099zgwDjnsmVe+lt0RtiBFCYcYcvtC/R39AHK7joOEdF?=
 =?us-ascii?Q?Emn9spKEQrDsyqmakcNWjNL5uxbuLwzY8kSS3XSX0qJdo9mcgsX3YZTxLxHw?=
 =?us-ascii?Q?JhyItHsMgXe6QE+L3F2wOq+5cI6KNUl7fKQbbHL8/0ZSeG1n3YUCQHVn2Kud?=
 =?us-ascii?Q?o/8IsKBjsYH7NqlBpoFZ0+kx1CHX0mEtGL/KCVVEP417AShuLgqzL4Oz3jt8?=
 =?us-ascii?Q?XO1I42l3xyCgYeqM0e8a7um4Q3r0E8GWiqv4l3uhWezB/UcW875aeCnayVVl?=
 =?us-ascii?Q?PzadXkM+DXJUpFrsMe8A5S44jseg96yCKcZf1X1zUSMgh3J13olC8niwlQdZ?=
 =?us-ascii?Q?4uFkdCsUaB5wEB+liCVj1VtGVuXGSdOcgZIfN5Ds7ukvgNvejiv0d55EGo5A?=
 =?us-ascii?Q?9jZEc6CSr2z6SOZ5mS9PWpOhhGDpIXNyWvWxyFoJdQ4RYpsEAySDBUHo8pAv?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cQCQDdRJTaXTCtRfnXyS0JJfylLJGL5Gkr7FtYlZxi88AKg80XRKSa0Cv2SBcneEqySwzyno1KwqWbgSflUJVhR3tc6PrJrKOkA1n0Wzsc7TW30Yi4zJuKMkrSOdj0RFpsoLNpXXF73FR7JR4ipGnJCTRi0vxPeMNGV+5s2lR1brX1o7rwCkoNQFXGFHxCx9v63BJhjV1wj6l9AyIwgY2A69SiZcDNUDIhlR/34os+ThSihfwO1wVDV5d3CpsoBDbf/KjWbAGyvCu0W3QRj08+IeAfNa6T07ho3uTaRuKRbTGwZauxwKCZH+wBr9V5+EdHl2/w0bPQBxohb5WCf+/5sQkA1xF9JBeXugYyTadGxAjdYOxMq2KQ8Ak1KSJlY6zS2EszoSk+9zd9wFvKz3abj/Hew5Y4+dFV4oe77OfO9ghOObYGzRHXq6q+JvrLXin+FJeiQQWHvWpsC+iFD20Q3ndsDOWqlyYTeP3xXTXynibQ1tfnsqyd57aVTHZtdJBrCGIQr+V56XIGM2G+RBMmvjHW3isQzaXzjqBBdYwMM9kxOZWp/0vh6kDRBn4TiVBaKB3SjBd4dDLQZHl43dryBx00FQKrIbU+twULl/5BQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35d363a-eacd-4563-8826-08dd52700740
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:05:26.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VInSQCTgvP49nOe9atzc0F/oUKlMyY0H3y8bpETsAoU706jVp9Cl+9GRKprnEMsv9T/+Egz0LFLEc3UX0gxrIL5C5BupCxL1QSZzMjHftYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-ORIG-GUID: heYPK1S1pKX9DWaGRhoVqUBZdWlE6LIE
X-Proofpoint-GUID: heYPK1S1pKX9DWaGRhoVqUBZdWlE6LIE

Currently there is no means of determining whether a give page in a mapping
range is designated a guard region (as installed via madvise() using the
MADV_GUARD_INSTALL flag).

This is generally not an issue, but in some instances users may wish to
determine whether this is the case.

This series adds this ability via /proc/$pid/pagemap, updates the
documentation and adds a self test to assert that this functions correctly.

Lorenzo Stoakes (2):
  fs/proc/task_mmu: add guard region bit to pagemap
  tools/selftests: add guard region test for /proc/$pid/pagemap

 Documentation/admin-guide/mm/pagemap.rst   |  3 +-
 fs/proc/task_mmu.c                         |  6 ++-
 tools/testing/selftests/mm/guard-regions.c | 47 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

--
2.48.1

