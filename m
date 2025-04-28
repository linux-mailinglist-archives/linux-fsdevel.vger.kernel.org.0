Return-Path: <linux-fsdevel+bounces-47519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F355A9F477
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A2F189A410
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFC26F445;
	Mon, 28 Apr 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P9L/+fh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LuGsvJXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257C170826;
	Mon, 28 Apr 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854328; cv=fail; b=bksmmMcdm7G2KejEsHX9tYqYSjRpOMvyjjmDMk+IidrWYXTlGazkSpxknCSk7SKIRMbXmjtGrdbfLUf8nqB09CqvPwvqr3qpfly3zeylN8+KhJkLDh5Tpwg31jUZFNKPnLKy+ielHbkcCzk84dkIps+Iq4kWfhbeoV0IhdnwQ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854328; c=relaxed/simple;
	bh=HMfAYsOOpS1ptacbrKjNG3535P2IkqLKtXUtXX52Axo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbcafjWvrj4CgpVU4IkSC0kJMLaWKXd2fRHLBZHYlgi1HcvkB6FNW29y1niufmJLxvVyPvoLqMa0ADDwG9Vs8uUvhEgJlJyOvG++Uxno17W9HHSvLKCp5bNSuN08eoUZtFjM76xUR5NAfC55wUwAD7o6EY/EBjUIieP/bamElzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P9L/+fh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LuGsvJXl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFMufc010772;
	Mon, 28 Apr 2025 15:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6SEpk+QPFmrzZJxC+PZbcE5Tvj9QobanAltJInJEGFw=; b=
	P9L/+fh4Sph182tLVFNdp6x1S4ChjYo9V+rt3snZ4OQxt8D5xw5MssEQfPok0Tua
	0aCR8LfKBmeMOb5pWlNJZt7drRVrqQp+Y/t2/B441w2TmCcs0Z+43/XV6OLWz78O
	7KK/xIl0GTAOKwO+yeZ3aaeb2IsFDh5Hn0edeqwa6YaTnyE70ijz5yCbFZHSw69g
	z6Qm3EaQFkFccghwIvkG3ntv4HsMlJZ0G6pV9vBML9BeqjScRk1AaeMHFl7uHPZ6
	EaaxT6lI+ot9/LheZkdUyLgdcksGMW0lUb8pOBnY9fU8ulIzHGUIi1Q1HOEQ3jjW
	XmEgqe3dsLkHrd7nnyDtsw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ac8f818g-36
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:31:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SE2Ij5007618;
	Mon, 28 Apr 2025 15:28:47 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8b3bp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDuqCtff/nl1vtydJDBOuOjEHOaIjD7OM+/RmkhuCWBK6oSj05gqzCseATJ9U2/WqntQHlR8hd51o1XZfodo545RKpAYVcdKKXyZRN8+SIBLkfLBs4l/kqID9nWZAE10kizgl6qvgZ/gfZliSrak/WBxrgA7VU4WEQLp2Q3LUJCbhwiyvB6YKLp9dtMYWgiCFNvX6xTkj1qs8cFfKkSb4vT5jH8J3EqOJn6qf/5Jdplsp4bQSJSyWk5fHNuUUyzm+4EcUOsd6zoxG+vr7CYSxzhPvCxL4LyOHJ8AQMOzqZ1AsXEhTH2kkFUT6+ZDkYup3Ny93B5Fwxtf9S/XKMJQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SEpk+QPFmrzZJxC+PZbcE5Tvj9QobanAltJInJEGFw=;
 b=gqhqt3yxWwQQWyMhK75t6trXS0jBYjFUYzYq9sWxoxIMwtnFReJULB+w4icpZGZbMBH5Z7F++08IX/acrxhQo0mN+3YlJGFrbw/DuNKXwcdEw4sASGfQsL7IGa35+qmPNL61Wc1bN/aZSVtWCO2n+ylr1TPqmGIh3ZTdC04qVuJJBSisMK7l5QB+6M5qFaIm6aXyS/YpL3Oob0866eNZXZCWSsTT6o7t69LahbxqHwLFQvEAeprT4d1XHHb74gN42fhFhPsdjN674fJd2TjSW7Ii25ldIoIbAjej+C8+zpMrMFPZTnbTfNhgbcu6QckEFc+g5BRfg3OBTscBtTBlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SEpk+QPFmrzZJxC+PZbcE5Tvj9QobanAltJInJEGFw=;
 b=LuGsvJXlDrcC7NXiAs22SHnKWJ/1fdtffK0YTMmCGxZ3IaPS1C7ph74tZoOX6TNNi7NklJ+rEiUgUJD2FvFHW2bIAVuuCGKJqVF4p4iE/3o1wHHwD2duH9fIU7eoTPTpZuSokP3sEErPabQZkvivm2udfKFARcV6yQ5Ietmjo20=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 15:28:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:28:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication in mm
Date: Mon, 28 Apr 2025 16:28:17 +0100
Message-ID: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 74261ddb-a0a4-47d1-2c7f-08dd866955c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+0xn3YFuERchfDIA7OrYRb8HrbfAmrM+4KVdxTSBrvKUueGrP0OyC0W9DvB?=
 =?us-ascii?Q?Tea89Yv2ff4K0g00o3mbUO5v/rustqLVxwNjR9KE+p9mneau17zYXKkYdY8/?=
 =?us-ascii?Q?TCbDWH8654V2iGLrZcoV3WbnW2LdI9oIQ0t1yTZ9LvFaWqd+blimHKiRhwQq?=
 =?us-ascii?Q?HZhgXS86ivLCAAqcLH8riafNs3y6rXZlQnIoqSCTo0k1bfRH9l8uDiSuKqWC?=
 =?us-ascii?Q?9Kg7gWbwTp1VpT3ttCrdde86AQfHcPTSYhGJK5NcOqPsjzkrT0lCRV6OdNu+?=
 =?us-ascii?Q?zDZ7vYoTAtZfxBegciUMuInfppVF2O8LQGCP15M8i7QsWJ3DfVBiuFE8Z5kA?=
 =?us-ascii?Q?zBjcUUR/AiuuEvvcZ3W4Uel1e2Nx3hGIfRx/mhlIax6V/Dw5YFuawammgsMR?=
 =?us-ascii?Q?3N3+RmrEPMMJ37D6mnAB/x5ox239/6MyjiInxYxq+uhD5zXEhPVPDfuqYTpB?=
 =?us-ascii?Q?1Rn45dvQGIHnxaGJGUHn2uVBwcNKPMUMu+stHL6hlfP7kND6Q0mZL29PsUP/?=
 =?us-ascii?Q?5Y3kiVQGLfsXABDGpalsE5g/GkkTm6Nb/dTHWEBrnIr8JL/gMs+1wQapM+4n?=
 =?us-ascii?Q?+/NEV88nuyDzwcRt3OTDFVcoGtphpceR3N0H8L6+yVvU/qYTYiOoWsxC+NRm?=
 =?us-ascii?Q?cTEw9RK/41hFC9VajyvloymmBoEpkG0i9W58P28Peekio0FJHHh3flIFK4r9?=
 =?us-ascii?Q?YADejKrgLorKVoqFWE1FFLR1xshsRp08V+MjqPQQTwB3hL0r7R/eqXCEnhZ0?=
 =?us-ascii?Q?tkV88No2T8X58/GwpeWAo7ZldKppRIr1smVX0i1T+so5ozNNX7Uou8Ygmsm1?=
 =?us-ascii?Q?32J1+7hiVFnZrbPt5z+y0MeeJd4rTHnnN7PAdCxZwXIsVKtIqhfc1q4X1xEW?=
 =?us-ascii?Q?vSn/GP2bIpwvX1C/Ve0nu7cMKUVVIO8p76pD6JY6k0TJuy0L1Biom/bqcSpj?=
 =?us-ascii?Q?igCTDfGrmDjMX9Y7LduMRNyC3Tq2NmlzJH2VXwma+pbIg2ABfY60oytLXxLw?=
 =?us-ascii?Q?w8jGD8/ijrP7MsDFnFdqCPfJq9OmGOKAdaLL8VFjFDgju/FZ+Z+12Jv71bLR?=
 =?us-ascii?Q?cVxrXdqaaQiQXPE4rsDq7bV3WF4WZK7wIVEoUYdNvOe3sIgzzEgUASAyr06w?=
 =?us-ascii?Q?GTyDAJlccUZF08hQ0qNDb+a5WyNyCu6lhPVf/ebG5YL+SArkK9ktSQkyvInc?=
 =?us-ascii?Q?vBT+XGsIo88v/o2+azIXgrhl/siAp2+Gi/coDxTB0u7LjyYIbeQU/LvJgy+z?=
 =?us-ascii?Q?vWnHyGxbju8vEx/q96H7TRni4r/DBNJjs+yT0l6smiirWBsRo3Wv77410076?=
 =?us-ascii?Q?3ZKltgUTlRRGiAK0ZdUN8J5w2NxEWT3Yrpnrb+TrOEZTXL7KHFQuV8ntJ5HM?=
 =?us-ascii?Q?naASWAU/lZkSuEodxwfLtN12voPtoIXnPS4/M7gSPtXXyS33oYwxGLH+UWUz?=
 =?us-ascii?Q?1awKnvZzGs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Goaf4kux1WCOKBpvI+2YGBuGM48Gx961HFNSYsI6C3J/8EAQtp9ywfLrTyh4?=
 =?us-ascii?Q?Q3aWg0ccaJQoFrTvRmnCrGJ4QV8NyKnep81PfSjYb11hOcugK14P9bGCSXLT?=
 =?us-ascii?Q?cYiL7qkbH8rvIiTqRf5nV5m0ZvAhRyzPQvMs84E9pb4PrTjk6LVZ6eJDJ9DD?=
 =?us-ascii?Q?K12K1+nSUT01oI6Pl5tcXN2uZS+nqT+3c0qK69WtN8kYmJhVdrS6ZI1gGxie?=
 =?us-ascii?Q?DIMIwYWbJVOJfaYQoWYDKluNhoBEImpeDL7dxCMFfD/M3ENiTWLrPbL/XI0W?=
 =?us-ascii?Q?aozd9++smptwYp7AHLg3yi4HaTo+EaZMgv9uTt0K9Tu0jaAQwhlRFhx4mCgq?=
 =?us-ascii?Q?s1pYfCLYp530A1QM6+COuZ8ZCz1oQL6ntoZyF6+HY7u2GjoBu369mhk4A7xv?=
 =?us-ascii?Q?E3eDMnQG86oZWkM4lJ0UVAKEoYrOZBYQaYUKmOownpvEY8qY8kTu4fMSS2LL?=
 =?us-ascii?Q?NPcf0F3xAr6ga0uD+zLrqpcO6GlBc4gKy9AIJjJl+2YXjKYm85m6yTa72qRN?=
 =?us-ascii?Q?78aGAhnZ/uFFWNnqP8UnC1MSKW0yiLqID6fkHLr6YOF/jS1CbTABG9FYZLuu?=
 =?us-ascii?Q?I0+Mp3GQbjA5sXmEtfIBXAA3ugS2WRqYPAtPVXZQQLxYd3k4wegovgpvvH/f?=
 =?us-ascii?Q?zCXy6F0FyvWk96vHRrDSFnBO3sUuexmRy+ITcqnufoq+UqYBCycQ9mAgXGUG?=
 =?us-ascii?Q?uB1dQ0UqXPPyuj9hUFhRRMfHXK+EBdAgTVyBasrZfMeU+J38l66qzyJQVnSD?=
 =?us-ascii?Q?hfgF34pxvwIgH2dvCTn4w9jaLLCDO2DCCr8x+859TY92TmLNdHQAe0+ROwm4?=
 =?us-ascii?Q?wr1hx2LeAkJPNwNRQCdFkntVHeloSjzU8l9FXA/lBOXLW4dGX4DGeCLVGbMl?=
 =?us-ascii?Q?/Pr6JYCZPZQzhoukhPZLCySb+7XoVP3UNcDSCpV56lBJRxN727+aVcYd90ct?=
 =?us-ascii?Q?zhPz9rtH5XGuiD//lsDiCOk6lKQAkjnrGIV1Hq39SxfNRmOWwfKM6w03cMt8?=
 =?us-ascii?Q?M+LrbqZDZtPCh/bdbRQvCNszD3GYcAnIpZ/NXIuL3cGTItmmUrjemLRTYp9x?=
 =?us-ascii?Q?SUklH282iP5sOxXjEI6l59kt8j92zt8SYEmPQqFLFRKdt2nhOX9DtoXeeNOV?=
 =?us-ascii?Q?1Msml4fL+3jChentt6c0qcx0KHlRUxVuR33fZVS++0/LjTkECK0UIldATLPV?=
 =?us-ascii?Q?VK/JKrRBJyrsZHVw0WzbAvQgaBVQLBLguaQcFGd+kyrqzo9b4azyLDqEZikf?=
 =?us-ascii?Q?Lg7B01kmwLtPzBzDOCO4mfD5vSS6DvEVGQBE7vSt7cxxAa+Dhy4yo2/mjDAR?=
 =?us-ascii?Q?Wo8y6sITp4W3GLxYZLszxjyc76SVtOQweJFiocHv9gsC9X0nQ116D1mbeA8J?=
 =?us-ascii?Q?54h5ixvZ+AlrgCyZHVcUWqDCH9sOY1Jkt80dKbR+cG3c8Mt0fCZ6URqopPmW?=
 =?us-ascii?Q?9GNSiCD6p/P9uF9tdki9bbiIXjQ1ml4CtiqXFVvud1kuYZbzd/R6RCg0QplR?=
 =?us-ascii?Q?/ex66zqqTJXDrug8P6BPRPhQ93qfqOsa5wq5djn2UQMW+W71BL0O91bcJw6Y?=
 =?us-ascii?Q?X1O5UYvquSk2IAujva44+F7mCravPR8TD/h66q2EFCRzj76wdEV/P+mOniFR?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jZTBPQAeiZlklbhX7PB6+VMrk+TiUgdRX6bwJ0+l3Qs7XkSUe4WZ7p4Vwmsl5Dz459Rt8OImB8P89kqs5XA+Y/7G8VfavSuNuM80pCqv+Lc7+73TgL3EHD2MrTf/gePTrQeXcHQjY/Rq+inKNbQvdBSmJaKI4Y1+JfcDExPmnVtQWMZdp8lJpIX0pvs2iUXBWUMr+xY/KqZn1aJ+Gq4vCpGwjQpeln5Y7ZX0CaiS2I8oEyv/pymCTx0bXvs6iXC1VgMClrJDCNnsZcOaWibrn6NtRTilFPM36REZUE647frJal/BulgJDQVKYKx6BJ5+k4T+rN+azQPGIxRRHs/t14ovslLr47J8reWIp6UfOU3Rb8Rvisc6YOxFaNQ63814+5kBocemfHtlVzDVcl/0I0XSEmTQW8bzAhfVibrlNzKPsyIt5A/h48N7WdwiL07lllmFC8/kr3l6fvKNvKub4+G9y6HdpgQojZKdir2jYv3FFitMNTaHSGaoH/yvIew3/NOgC+VBwnx/NKqu1tj9z3n5Lgq2ME4Mehymhu/Xh8Pdbsh7dWDyff7i5ujhaDW0KwxMohS+gYpuHM5tqt27pXVZhwVjz3OqjSYBoIkAdIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74261ddb-a0a4-47d1-2c7f-08dd866955c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:28:32.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QwRMai9iEJdzjNr9Mis1kbuDw3UX1NFP5as4RjXSjju9pLgRWCLUw1c4eSofVdrnFAtE+k1pARblTxNprP9GyYHRMc2Rf1QRVObDJtew9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280127
X-Proofpoint-GUID: ydGmZ4RLdIsurzxpdtlxEYZN7HpngWDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNyBTYWx0ZWRfX/b3uicFBU9BO Nce5zgaN2xMmdIsEf6qlMI3WwfCcmpGL9OfSh78MarRSqk3+XifPIKRVyCWTSSmkghddO8w4Fo5 k6xfzAF5v8wx4/VJJxUeQo5SN+C22JeA5MejXc7+LMXfD9+T6dsMzjn9Tu48wr2Jy71WVaiIamm
 do1XIWMWn/8fd1jWSILAl/6o23HxBqX4YkgQfOmHSYL/fbCLcKu/RQ17ISy0C4LoYILtknNJq3b s6FqmNH2zSd9R31OJy5sRQ3amcwDYGOZHtsbrwu/J2FIayyip9DSI8i0XyBn3pzN5oB9dFoxGvw 3AFbQ1WG4LLkRmhTZjx6v1rLKgX1gR2U96dboqmh/cTtuS0R1oB2naZryJN/HKKDtctB57+/vb7 WXCX1YBN
X-Proofpoint-ORIG-GUID: ydGmZ4RLdIsurzxpdtlxEYZN7HpngWDp

Right now these are performed in kernel/fork.c which is odd and a violation
of separation of concerns, as well as preventing us from integrating this
and related logic into userland VMA testing going forward, and perhaps more
importantly - enabling us to, in a subsequent commit, make VMA
allocation/freeing a purely internal mm operation.

There is a fly in the ointment - nommu - mmap.c is not compiled if
CONFIG_MMU not set, and neither is vma.c.

To square the circle, let's add a new file - vma_init.c. This will be
compiled for both CONFIG_MMU and nommu builds, and will also form part of
the VMA userland testing.

This allows us to de-duplicate code, while maintaining separation of
concerns and the ability for us to userland test this logic.

Update the VMA userland tests accordingly, additionally adding a
detach_free_vma() helper function to correctly detach VMAs before freeing
them in test code, as this change was triggering the assert for this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                      |   1 +
 kernel/fork.c                    |  88 -------------------
 mm/Makefile                      |   2 +-
 mm/mmap.c                        |   3 +-
 mm/nommu.c                       |   4 +-
 mm/vma.h                         |   7 ++
 mm/vma_init.c                    | 101 ++++++++++++++++++++++
 tools/testing/vma/Makefile       |   2 +-
 tools/testing/vma/vma.c          |  26 ++++--
 tools/testing/vma/vma_internal.h | 143 +++++++++++++++++++++++++------
 10 files changed, 251 insertions(+), 126 deletions(-)
 create mode 100644 mm/vma_init.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ee1c22e6e36..d274e6802ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15656,6 +15656,7 @@ F:	mm/mseal.c
 F:	mm/vma.c
 F:	mm/vma.h
 F:	mm/vma_exec.c
+F:	mm/vma_init.c
 F:	mm/vma_internal.h
 F:	tools/testing/selftests/mm/merge.c
 F:	tools/testing/vma/
diff --git a/kernel/fork.c b/kernel/fork.c
index ac9f9267a473..9e4616dacd82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -431,88 +431,9 @@ struct kmem_cache *files_cachep;
 /* SLAB cache for fs_struct structures (tsk->fs) */
 struct kmem_cache *fs_cachep;
 
-/* SLAB cache for vm_area_struct structures */
-static struct kmem_cache *vm_area_cachep;
-
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
-struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma)
-		return NULL;
-
-	vma_init(vma, mm);
-
-	return vma;
-}
-
-static void vm_area_init_from(const struct vm_area_struct *src,
-			      struct vm_area_struct *dest)
-{
-	dest->vm_mm = src->vm_mm;
-	dest->vm_ops = src->vm_ops;
-	dest->vm_start = src->vm_start;
-	dest->vm_end = src->vm_end;
-	dest->anon_vma = src->anon_vma;
-	dest->vm_pgoff = src->vm_pgoff;
-	dest->vm_file = src->vm_file;
-	dest->vm_private_data = src->vm_private_data;
-	vm_flags_init(dest, src->vm_flags);
-	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
-	       sizeof(dest->vm_page_prot));
-	/*
-	 * src->shared.rb may be modified concurrently when called from
-	 * dup_mmap(), but the clone will reinitialize it.
-	 */
-	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
-	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
-	       sizeof(dest->vm_userfaultfd_ctx));
-#ifdef CONFIG_ANON_VMA_NAME
-	dest->anon_name = src->anon_name;
-#endif
-#ifdef CONFIG_SWAP
-	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
-	       sizeof(dest->swap_readahead_info));
-#endif
-#ifndef CONFIG_MMU
-	dest->vm_region = src->vm_region;
-#endif
-#ifdef CONFIG_NUMA
-	dest->vm_policy = src->vm_policy;
-#endif
-}
-
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	vm_area_init_from(orig, new);
-	vma_lock_init(new, true);
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-	vma_numab_state_init(new);
-	dup_anon_vma_name(orig, new);
-
-	return new;
-}
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-	/* The vma should be detached while being destroyed. */
-	vma_assert_detached(vma);
-	vma_numab_state_free(vma);
-	free_anon_vma_name(vma);
-	kmem_cache_free(vm_area_cachep, vma);
-}
-
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -3033,11 +2954,6 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
-	};
-
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3054,10 +2970,6 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = kmem_cache_create("vm_area_struct",
-			sizeof(struct vm_area_struct), &args,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
-			SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/Makefile b/mm/Makefile
index 15a901bb431a..690ddcf7d9a1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -55,7 +55,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o show_mem.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/mmap.c b/mm/mmap.c
index 5259df031e15..81dd962a1cfc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1554,7 +1554,7 @@ static const struct ctl_table mmap_table[] = {
 #endif /* CONFIG_SYSCTL */
 
 /*
- * initialise the percpu counter for VM
+ * initialise the percpu counter for VM, initialise VMA state.
  */
 void __init mmap_init(void)
 {
@@ -1565,6 +1565,7 @@ void __init mmap_init(void)
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", mmap_table);
 #endif
+	vma_state_init();
 }
 
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index a142fc258d39..0bf4849b8204 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -399,7 +399,8 @@ static const struct ctl_table nommu_table[] = {
 };
 
 /*
- * initialise the percpu counter for VM and region record slabs
+ * initialise the percpu counter for VM and region record slabs, initialise VMA
+ * state.
  */
 void __init mmap_init(void)
 {
@@ -409,6 +410,7 @@ void __init mmap_init(void)
 	VM_BUG_ON(ret);
 	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
 	register_sysctl_init("vm", nommu_table);
+	vma_state_init();
 }
 
 /*
diff --git a/mm/vma.h b/mm/vma.h
index 94307a2e4ab6..4a1e1768ca46 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -548,8 +548,15 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
+
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
 
+/* vma_init.h, shared between CONFIG_MMU and nommu. */
+void __init vma_state_init(void);
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm);
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
+void vm_area_free(struct vm_area_struct *vma);
+
 /* vma_exec.h */
 #ifdef CONFIG_MMU
 int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
diff --git a/mm/vma_init.c b/mm/vma_init.c
new file mode 100644
index 000000000000..967ca8517986
--- /dev/null
+++ b/mm/vma_init.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
+ * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
+ */
+
+#include "vma_internal.h"
+#include "vma.h"
+
+/* SLAB cache for vm_area_struct structures */
+static struct kmem_cache *vm_area_cachep;
+
+void __init vma_state_init(void)
+{
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
+
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT);
+}
+
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+
+	return vma;
+}
+
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
+	       sizeof(dest->vm_userfaultfd_ctx));
+#ifdef CONFIG_ANON_VMA_NAME
+	dest->anon_name = src->anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
+	       sizeof(dest->swap_readahead_info));
+#endif
+#ifndef CONFIG_MMU
+	dest->vm_region = src->vm_region;
+#endif
+#ifdef CONFIG_NUMA
+	dest->vm_policy = src->vm_policy;
+#endif
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	vm_area_init_from(orig, new);
+	vma_lock_init(new, true);
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	vma_numab_state_init(new);
+	dup_anon_vma_name(orig, new);
+
+	return new;
+}
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	/* The vma should be detached while being destroyed. */
+	vma_assert_detached(vma);
+	vma_numab_state_free(vma);
+	free_anon_vma_name(vma);
+	kmem_cache_free(vm_area_cachep, vma);
+}
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 624040fcf193..66f3831a668f 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,7 +9,7 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 5832ae5d797d..2be7597a2ac2 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
  */
+#include "../../../mm/vma_init.c"
 #include "../../../mm/vma_exec.c"
 #include "../../../mm/vma.c"
 
@@ -91,6 +92,12 @@ static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 	return res;
 }
 
+static void detach_free_vma(struct vm_area_struct *vma)
+{
+	vma_mark_detached(vma);
+	vm_area_free(vma);
+}
+
 /* Helper function to allocate a VMA and link it to the tree. */
 static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 						 unsigned long start,
@@ -104,7 +111,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 		return NULL;
 
 	if (attach_vma(mm, vma)) {
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		return NULL;
 	}
 
@@ -249,7 +256,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
 
 	vma_iter_set(vmi, 0);
 	for_each_vma(*vmi, vma) {
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		count++;
 	}
 
@@ -319,7 +326,7 @@ static bool test_simple_merge(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->vm_flags, flags);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -361,7 +368,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
 
 	vma = vma_next(&vmi);
@@ -370,7 +377,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma->vm_pgoff, 1);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
 
 	vma = vma_next(&vmi);
@@ -379,7 +386,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 2);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -407,7 +414,7 @@ static bool test_simple_expand(void)
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -428,7 +435,7 @@ static bool test_simple_shrink(void)
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -619,7 +626,7 @@ static bool test_merge_new(void)
 		ASSERT_EQ(vma->vm_pgoff, 0);
 		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		count++;
 	}
 
@@ -1668,6 +1675,7 @@ int main(void)
 	int num_tests = 0, num_fail = 0;
 
 	maple_tree_init();
+	vma_state_init();
 
 #define TEST(name)							\
 	do {								\
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 32e990313158..198abe66de5a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -155,6 +155,10 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
+#define data_race(expr) expr
+
+#define ASSERT_EXCLUSIVE_WRITER(x)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -255,6 +259,8 @@ struct file {
 
 #define VMA_LOCK_OFFSET	0x40000000
 
+typedef struct { unsigned long v; } freeptr_t;
+
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
@@ -264,9 +270,7 @@ struct vm_area_struct {
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
 	};
 
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
@@ -463,6 +467,65 @@ struct pagetable_move_control {
 		.len_in = len_,						\
 	}
 
+struct kmem_cache_args {
+	/**
+	 * @align: The required alignment for the objects.
+	 *
+	 * %0 means no specific alignment is requested.
+	 */
+	unsigned int align;
+	/**
+	 * @useroffset: Usercopy region offset.
+	 *
+	 * %0 is a valid offset, when @usersize is non-%0
+	 */
+	unsigned int useroffset;
+	/**
+	 * @usersize: Usercopy region size.
+	 *
+	 * %0 means no usercopy region is specified.
+	 */
+	unsigned int usersize;
+	/**
+	 * @freeptr_offset: Custom offset for the free pointer
+	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 *
+	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
+	 * outside of the object. This might cause the object to grow in size.
+	 * Cache creators that have a reason to avoid this can specify a custom
+	 * free pointer offset in their struct where the free pointer will be
+	 * placed.
+	 *
+	 * Note that placing the free pointer inside the object requires the
+	 * caller to ensure that no fields are invalidated that are required to
+	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
+	 * details).
+	 *
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, %use_freeptr_offset must be set %true.
+	 *
+	 * Note that @ctor currently isn't supported with custom free pointers
+	 * as a @ctor requires an external free pointer.
+	 */
+	unsigned int freeptr_offset;
+	/**
+	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
+	 */
+	bool use_freeptr_offset;
+	/**
+	 * @ctor: A constructor for the objects.
+	 *
+	 * The constructor is invoked for each object in a newly allocated slab
+	 * page. It is the cache user's responsibility to free object in the
+	 * same state as after calling the constructor, or deal appropriately
+	 * with any differences between a freshly constructed and a reallocated
+	 * object.
+	 *
+	 * %NULL means no constructor.
+	 */
+	void (*ctor)(void *);
+};
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -547,31 +610,38 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+struct kmem_cache {
+	const char *name;
+	size_t object_size;
+	struct kmem_cache_args *args;
+};
 
-	if (!vma)
-		return NULL;
+static inline struct kmem_cache *__kmem_cache_create(const char *name,
+						     size_t object_size,
+						     struct kmem_cache_args *args)
+{
+	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
 
-	vma_init(vma, mm);
+	ret->name = name;
+	ret->object_size = object_size;
+	ret->args = args;
 
-	return vma;
+	return ret;
 }
 
-static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	__kmem_cache_create((__name), (__object_size), (__args))
 
-	if (!new)
-		return NULL;
+static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+{
+	(void)gfpflags;
 
-	memcpy(new, orig, sizeof(*new));
-	refcount_set(&new->vm_refcnt, 0);
-	new->vm_lock_seq = UINT_MAX;
-	INIT_LIST_HEAD(&new->anon_vma_chain);
+	return calloc(s->object_size, 1);
+}
 
-	return new;
+static inline void kmem_cache_free(struct kmem_cache *s, void *x)
+{
+	free(x);
 }
 
 /*
@@ -738,11 +808,6 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void vm_area_free(struct vm_area_struct *vma)
-{
-	free(vma);
-}
-
 static inline void lru_add_drain(void)
 {
 }
@@ -1312,4 +1377,32 @@ static inline void ksm_exit(struct mm_struct *mm)
 	(void)mm;
 }
 
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
+{
+	(void)vma;
+	(void)reset_refcnt;
+}
+
+static inline void vma_numab_state_init(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void vma_numab_state_free(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+	(void)orig_vma;
+	(void)new_vma;
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


