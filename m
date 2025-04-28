Return-Path: <linux-fsdevel+bounces-47543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40900A9FAA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571E5466D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8A1E1DF9;
	Mon, 28 Apr 2025 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtMBNju9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b0HnKKJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB421D5170;
	Mon, 28 Apr 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872180; cv=fail; b=qf/PWuVH6Ijy8zkIbXJdsXB/SJFffZnDMaTzv6gd7+CBSmAO1LhKIjWqc4EVQVJkS4Si+DDn1LmErL2rfZX0deRwOnDgnokD93yj1aKgGGDoz6nPiZiIolGRq11naQ0OBym7e3epCRg6QB0DHkoaw6nTLQhYC+PENnW0W58iesI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872180; c=relaxed/simple;
	bh=z3fOv5TZrmIH7K3Yjq5ujxKC3tLslw4g8g1hqVHF4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbr2JNyXFv1nPsBJ5HhirpEcaIM6k6v6LEVz69zeZw4ipQCzKSrt/DcN7gVBHYM/1VEbVr+RESy84ySanfc1nArNDaA7mBQCtA0QICPiiH68XmPGe1gdaw6S4ua1f79+zL8bVTHbgGZvtDzFfHpmkuusX9P8TZhjaxsA6qcVwDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtMBNju9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b0HnKKJJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKJVXR008332;
	Mon, 28 Apr 2025 20:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EJCP+bQnR8UwRvNvk0
	M8Z27hNNxbW/z0PZbPyFvpDQg=; b=jtMBNju9XxRIk9oCYYuohRQ61wtn2RgbEv
	jkNX66lC7VsO0vzPsM6Nb0V+DbZh9qfgM9Ln/LTknT8kePkSC1R9fGUfCQuF5/sg
	KmZxvDjsC2ti4MgviOIknwP0KqLkKPY0/OUCm8g/HKt2bAeKEl2NFsphFNbU6KeZ
	i/7zkpi+kp5OfnTDvaANpWp0bgTRi0ufwPTTswmlJeHJ7gj4tJ0QJyLspeRfko6b
	pWQN89pISwae5lTYBvBKLphHa985tEPA0iCEEKEZfSYLIHLWnPlExEEjXNFr3Q2Q
	uSggwjR0YEsqEAipJHIk1aAiBeK494U8WZqFHHGrRRggSePT/40w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ag38r35a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:29:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SJvfTn023924;
	Mon, 28 Apr 2025 20:29:23 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012014.outbound.protection.outlook.com [40.93.14.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxf65wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K85LgfLcZkw+DAqLv9pbdTJrp824D6rXiOYD6PVz3PDtyh2c0gSuJYanKO+IH7oSJu6u9Xx77EjA9FDzrEyJniRrDzHCo60aq0M3Kq22O+jai8Hi0l939DwMesBvyI+9taNbvs38o/qHdkJgSKmeH9MXUrF2y7G+A1ErBD71luoKHvbEOO8qeJV8yfhlVvcGulL1fr8LBL/Y4+9R8nbY+RqiLXfPko7DeBj6Nb5tYmrGwQ60kXgeTd8J9Q9M8FDuCvkaCxcfaUKU1c0Pteb4BhV/qK3boCyZeb8cSnSizKIqdyC0hUGzbaXKJzX/Jc4twTlqQclQ8CjM/Lr44AgQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJCP+bQnR8UwRvNvk0M8Z27hNNxbW/z0PZbPyFvpDQg=;
 b=EmQHSqtTiWE8V4/YAqvgZVKYi+cnM0NZJjt2OCzkZwbcnCF/tTnZyPs/tzxpN+9oOIWOQU/qFokILAws+MoU2cwIe6JLj5R6zYzAveTR5eWGBpPd0fEMS+Mu+5rcuC6aktlfbjoSPLBDs5yBtRpMUJ11PGb14krNVAV52CRWIvnVCOEeGVw/ro8jokdM+BwEbgYXOZ5lCK0F/2jZzwFG9jXdKJAUKDm7FTCTfKtHOu2qYhopt9DnnaSEqeUE5N1uXMRjEJ0P4xVS3ppxhJvvcSkE/llSd2bYGCLFNNfM1dYgr4IVLRDYkxM459cM4jvUut4ZEUioseBzPxjeWc+B3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJCP+bQnR8UwRvNvk0M8Z27hNNxbW/z0PZbPyFvpDQg=;
 b=b0HnKKJJEfXzs0wXuJJKVFk+V72McoyPOs066gQ4ylhKpA0eTe1Nk6jRKCf8i20JkoHvXVEdqDGa4O+5tNkFel0xUbGwdxGm12NjsmRZFpMgCjdedplNDLsTHS2tai8Hh7D2UHFb6hRAWqcwhl2JvYQJ42/Ue7pYfBbmXdBb81s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 20:29:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 20:29:21 +0000
Date: Mon, 28 Apr 2025 21:29:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <b2c9cbf5-c39e-4a38-aa50-7e37145176ab@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO3P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: b376ff92-9f40-4f36-d702-08dd86935b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhouDADOoOi+jufKMKc9ACB5rJB6geRSBVtgL9tnAzFK9AIi9aYCCi5J7BvY?=
 =?us-ascii?Q?46YKyikyBsxwESP0VMaXNk+oRfY6TgMNty/9P+7TLzLFrXFR9aCRITr5zg3D?=
 =?us-ascii?Q?zFffajG+hQfLpWFdEDkK14wMYnKaNiUrnyI7o6ilr/SRYg1pvdi4IwgaREoj?=
 =?us-ascii?Q?ykdFAC7JmmOe/a23D5PGpX+GCZfBB2vVsaael1ozgAuXTd1tpc5CgoVqLw3W?=
 =?us-ascii?Q?eEgoHEn+WIzrVUevYSlaW+9wkC7C1jiYgNkNGDBapLSiM/qYUVawUckbH38/?=
 =?us-ascii?Q?mVLEip1jZT165wm9wY1KtHEKxlpt4C5CnpJ0G+waIxDZobcgVNhjNGYVSmSz?=
 =?us-ascii?Q?wjIs0SZL54J2V85nA7Q7N9rS5ABlulq0QZEfp54HXFldbwkJ4qy7EXUc2xgy?=
 =?us-ascii?Q?nLUlEyIN3vYFa1CVE20VzIorexIFky5AevNJOuUTCD0NfZg43hHfUaPRFS9p?=
 =?us-ascii?Q?ionXtavmgzzqYv60B9JMJvNeb7oHunkoJWNjcX1MWvcOUGUF3vWOOJW+aT37?=
 =?us-ascii?Q?GEyIhlepRnYhTbXn0BBUrhe/7Qh7a2UVb7dsqW4Q9SXnW/vHg7+SDENgRV4b?=
 =?us-ascii?Q?UVI7xSG5m8fFvIl/5mJMxqUvibNdN6VxCrIV0yenzg3cXrJZtHKboY4WuMFv?=
 =?us-ascii?Q?PUZqRKDaim1pHqiHQYbWsXYQEdoUVmpo5fCXUcZoNqbBSSTxFrfxNCIUw5Nl?=
 =?us-ascii?Q?IKgQG0DTUml2Au5/uJd1/zJeMi9M+H4fXK/hqei7CvuBajIkbKu+IO7EPL6p?=
 =?us-ascii?Q?kci8PO1o1pyobzBqLX3hFxQo2WX9rnY1PixVPofA8sExnSbYn3H2u/feNjUT?=
 =?us-ascii?Q?eAutacQSedwxpjsQp0ScnN5tJ+SrEYlDcFcnuvV7bDNJfLWkCxGimZXUDHFC?=
 =?us-ascii?Q?sOT+Aij+uxVQVFqNY9bYDKy93ApLjLeUEL2w5J0SGM596bDrY2HM7f3aZ3Jh?=
 =?us-ascii?Q?i1Yqw3n9Di1hkB9l4E+BIvds2fxUspCPJeLgn1WZ1qcIPz5/Sy1bHLN9038W?=
 =?us-ascii?Q?mzMPETIOA6feqmBxsYrqncy9ynseKNIB2Z1cjJYPIxJD0tqUsnaThJ3iVRK4?=
 =?us-ascii?Q?YLYpVzWi2SUAQdsbZ3GdRfUgrCxauwIRFr+Fr5OtzEiPORB8LMZud/w6uOnE?=
 =?us-ascii?Q?U1sy+7cdZe3KnixccVpLSmBIm3Nj2bl2MDHYi05nOy5TTdWgggZUv5IoqcHc?=
 =?us-ascii?Q?T8QXC/SDRDr8uRCYXuEy7OntmZ4STsSNle2vXqn1SCcPaBtrPpLUpFpWE1JC?=
 =?us-ascii?Q?SKbO/w573iYXQ6R4F4Q4HHv06x9CuRzRP4Kf35BGvYVeWA9dTx7LC6iSTSsM?=
 =?us-ascii?Q?T80+N2a6YQ+l7Bo3WKmdcVO3Wu59OJH8piURcVFmhyBap8+zxgpWn27vIP7s?=
 =?us-ascii?Q?E0wjZkTBmhMUQoyWSsDX7yO/JDT75ySiaRGSGVb0AcEzmzYVbO9JHFGKuXsG?=
 =?us-ascii?Q?n5L5Z8hueUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8jwWQSp03opaS8FJ6VWwtsemhpDb1nvcEt/qK2ZcNRATTtmKnFTfikyYS58t?=
 =?us-ascii?Q?INTPZTmrWrUrWvTAFwpHeVLKi4z5X9yT7mwdfByw7aOBG4i1KKr+LdrDQCUa?=
 =?us-ascii?Q?C/VKPcBAUAyBL462nXTS/CDiSbKU1SOW1R3IiD9Cq81MEAQEVXlQGFWil+uQ?=
 =?us-ascii?Q?PIsECgv/l2cEtF80x6k7y767T+EZcI77m4mqqrPf9n+oG01y2E9SHVJBm/nL?=
 =?us-ascii?Q?LdbeupjoclBXi3bmGcDkwLbeWewel1+0v+jxHMuQgYokvuWZToMQsN6qVM3O?=
 =?us-ascii?Q?iUW2MLCW0ZW07uQs9vdOvDeSXwTLbBd/4TjyLl0p2/6RBSmloW6eD1qAEgJF?=
 =?us-ascii?Q?hrmXw+vHRol49hhu9BR4Ihqt1YDyLmJTuflPPlYO2h9P1eE/BKFW//1mJLj1?=
 =?us-ascii?Q?Rhipx/OMaCinDoF+NewK+2duks1a/uarQSWlZPd5ZWyu/nvzrbuQa1DVLCjo?=
 =?us-ascii?Q?3mwyeiBDVncMWS+mv1DlCzpd2BvtN2e1RciYao/x6yT6gUVO4Lr/6Njx1aGl?=
 =?us-ascii?Q?45m5mQNKMfi0EOxuP1+mDq040xxJu9HT5MowAURtnTfj8z+6GujP9G7fz/Io?=
 =?us-ascii?Q?5GZtqU3tSA/3NhDyHomEkne0FaJGYLzrTI5T2xg0pGDps5N4bWf0pn+a55vs?=
 =?us-ascii?Q?0eLR+UjtTaUFo7kHMItKIVR9b80A215iyKwJTAlImXuUF//8mEDf9/gnUm/b?=
 =?us-ascii?Q?U1uyrSQQwpt+ZaL8cCikz5qXd2UG53P9lKSRKcXfsGMKvZBQ8llH3CMcOMgp?=
 =?us-ascii?Q?2z45F9WNxtqSrTkM1agcBy20F869xDXrlikBO03B37dfMgOsIgq2CHiNV40w?=
 =?us-ascii?Q?JClYvmvocKItkcgsoUs3vIGP+cFUGSif7jk9W1C82zxGYXfoGJKxBzykoOX+?=
 =?us-ascii?Q?WGsvC6Ydt3xqqPuKLAXXnQZIrkP/aVsxaBroEdxar5+4/IE0a8gOSNNLUiXF?=
 =?us-ascii?Q?Fi4D61k5jKrWGik5ekGEAYbWG9czvcyl8p6Sm/CYCqOBGVM2vwNFYqSZtilg?=
 =?us-ascii?Q?F1I9pR2tTC+m/VFkZNDCgTzgMd8TrSsNTsP3nKUeOgKxXWGs+Gljljn9tean?=
 =?us-ascii?Q?p3RTaxSb1IvetpWkdVgqVfbSLycHCzz5e4XO6Qu+YW134JjJ2x/MpQ2swf/h?=
 =?us-ascii?Q?/Nw+c6Ti4Ofq/aUbZUJ2oPc2196FANe+TVElKJNlUJQX9+4uDbtlVug9YNlx?=
 =?us-ascii?Q?3dvJ5xoAVu8GuwnZgt+9U/gsqISY+R2cWFPjLvMpXyjma3ffbgh91U6M3w8J?=
 =?us-ascii?Q?rkz6iXti0HnT0uPPvW1Ci60wJ9KGU/xuVMUaTXmJdJrKYEAPq0K/HeBBl5Pq?=
 =?us-ascii?Q?qfmp0D32EiGwohApbep/Ngm9LSERmitwd4gQZJ1ZBVOYo/IgcQx5J/gf9vj6?=
 =?us-ascii?Q?GYWiF7o24O9tfOWeGIHe2W2tWlCURb8KtRCXZCP5Fvh8p0mm8OGfM1RQYQMn?=
 =?us-ascii?Q?yx8l7CISbPbRHZ/y9pbkbbG1o1AIZuD+eAKsN0OgYdYbZWg8Uges3cnJ+8fd?=
 =?us-ascii?Q?69hK8AaNhtY3nkwsacVXwb4N7dcqnnArKb/7EVLO8jcBQQb7+mP6of7LyFNo?=
 =?us-ascii?Q?l2gQJJlrhO2aWwqL1mC2dN8HfAEglPaCdqD4+o9SREFRnzlZzvHf8kUKNl3F?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QNuCbokJLCG3tuo3X57HCP8Qz2fCffyNY9xTs54C+a7AlPz0pbwLEs025+2IB0pBIz6MZRKW9cwStSovJOg11D3fAUNcBIVMobOHUolp941o6wkymInBT4K8mAe+498ud98RL3y1BgqBFRYo9WCett6x7QLFYp6CfBvODKVXiK+Z/X2tBsNy8klQwQay1SuZefQA/5qkVtLbE8/He1v68MS85P4xuCtFjeIKCEk4R+1eA+f4zlVFVqsm75At1fl9btpzfe0AW1BCpj6eoUPi9JNWvhdzIrUemtmebMoMa/mv9Wxn0ivpxMwC076Df8ikeeNhsJp6zfvoYW5kS0LhU+SquWo1GKAMy+WrP7/YfhS3phN1eeiDt+i3WC/nOsllz4pTqsg/hW8LCDnoyfhyHEfIlEogcmYbVbA3nUDwqo+IoSxAWdM2iqBw37k1ULyGHfbZYk9giPdZdxoqaPC0Rb1eWh9EZR1pvJ5qpapzy0pnbdY0BcJFS1wADL9srKLl2L2VcSohbGhiq+pMI33gwR77EZFQPj8VUvZxgy5asllirRuEHzuN8dJn/4v+K5aCvWrHeWqe5fM/Bt3YnVYFcRW1PaslQv1ZZhh+ZSgiBj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b376ff92-9f40-4f36-d702-08dd86935b75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 20:29:21.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRhInDIOGUsobocO1x11sZl0EYTJ3/p29jk9xXA/zfHU1qDZbcVNuKtaxTVRdi2zTAANEx39GkcGB1j1AEfGpy/RNoiCODHhzeXJ4wzZNV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE2NCBTYWx0ZWRfX+GrUcfp3w3AK i0TYyCAUeVz+SpDazmiutfaFJ/lwTN0foI+d26d9/N8qjtMxJF1JzdWloJ398kKcB58CdbYND6l GyyIUZ19F+0z7ugxc1J+3PCC0JXeNYk7/DfACKsauMmXqocIhLfBOppdHfp1tSa7PAvzNmU5fKT
 SC7CW/6VwNwrcv6ic2ov68XLtBzwRKq4OF9BuNxq1e9NsPzUlvRch2DJDuDC2qyZnCYau5TgsVP la1u7uOjq6H+GTH3RfpingPnmCjzU9Mar8jn8gatrrXya9mgNTbrluemDQm0RUKA89TdpR+cjbj REZyv82zq3fxN27mWCJbiHm+p6Dy4NFj1qlv/VmKPyM+U6qIBw0sfuLdKe2fr07cx79xNXIBxfv 39s7FDoK
X-Proofpoint-ORIG-GUID: GTudRsDt0OiVSlN2tSlgQdFkXEZ_X6z6
X-Proofpoint-GUID: GTudRsDt0OiVSlN2tSlgQdFkXEZ_X6z6

Andrew - I maanged to typo vma_init.c to vma_init.h here in mm/vma.c (at least I
was consistent in these silly typos...).

Would you prefer a fixpatch or is it ok for you to quickly fix that up?

Thanks!

On Mon, Apr 28, 2025 at 04:28:17PM +0100, Lorenzo Stoakes wrote:
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

