Return-Path: <linux-fsdevel+bounces-55184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37069B07E13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330993AA8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F92BE7A3;
	Wed, 16 Jul 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k9jUedKN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JiAOvvGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560228F51E;
	Wed, 16 Jul 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694626; cv=fail; b=ewZM26oFyl134m0Y4vLE/5TDwh0xZqntoKo7ZTuLKBJZxPCRU92pUugKVc+zK9B0RruUlEPkLbfoSfcCKfRfBtxNUTVk/8DDezCbrYpYoc15zJDWnI7HmdQb15Avw7Qpotz+ikpom2EHWTlURm6DyDS89sunogntr5LzzwMwZq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694626; c=relaxed/simple;
	bh=tSSSrJB1KngA15NOLmnFMq6OR9LFlOE5XJa9MN844eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLBXS5LGSsQ3wYp3R+XrgZsv+eCJMA8ZtDBAGMDByb730faXLd4UagaG2B3R/0zhEOz8aAij5uV+XyIVljPpbmT93d4wWrRCiuzmAUJu8wXT4lWlFuVFZxyYrc7ZOWBJDzj4J04wFnVK3chE3mEViEDEMd7l7khicUWy6r/regM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k9jUedKN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JiAOvvGd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHfoch028678;
	Wed, 16 Jul 2025 19:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=taIjO+Qzgkhs6LoRPF
	P4Wjmu+qymbHV5malh5rS07+Q=; b=k9jUedKN49nKrD14lZRmx7U7A49CiwNuw+
	RtQeSSHVtODGAKuILJsuENG6jMXdNI1Zq0USo45gWf5G3VIB7wkbkFuz+UDOKlpU
	Tbq/CjPMrmy+ZllVYxqMSoVUlwiMbtXzhpxMxPF1Jo6IUsH2wLEb/uJpy487Q9mv
	a/Z4fyydbHh7G/UvUWoMTrlq4ZGcH2sNtmpO1Jpb0JirCOQtWQRZyGqjgivyOL0I
	bGeusTnxVi9LK9EsAOiGYAQsRwc/XsxLWJJtcJO2ttrIaE5x4CYeB+JJqYhHCwl9
	1iTif2uTZzvm/N5mxEaQeUP6CxCg5lknMGLjD9dh+WZhIlPIV3BQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx81uxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:36:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GJAi0T013024;
	Wed, 16 Jul 2025 19:36:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b9ut8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0NkVbFZF6/fOaeMCRLBw/gjoR98tvDX/xiJN3PqJclCK2FEx3gP/16xVoQa+RL61lYbZ5qb3qfwgPDo6D1hoD2VaKIug+aQqjkCXvbM4wcHY4TlDUAgPPZsWEHe8kzPOWIzXEFo9+tXarW4wMAqLk+seLCOorq8d13Hyc7H8EjH+d4pivHWOrvEA3CHeJsa9QLMOhyOkboelzBWDhpCCfjpRdqjD+VBGQnXma2A6BYK7PYMqbSrtegbm3vhJKQulLez+0SFDzSozEOWlcCVreGxTVyYrpenRKtlGGPwNGevE7yKFO/5LF3dxppJ5fNhFVwEwLr2FGCuwY+fGVbndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taIjO+Qzgkhs6LoRPFP4Wjmu+qymbHV5malh5rS07+Q=;
 b=juZPL3sOc2+BkSeOCiYwv7L4VuNTc3Md8umAqJ+Pbslb0NQNSjTYSM7vQXvWrRWJx1YLPe/zmooNabDrvqeX3albxtA/0uimHjhP5foiWzZjLh/OboCJbh2lUAOU2dBznq6iExU2AzNCEfYEGvhKrWtGfdnywjEwTBXfAv3F7AbKIFsyX2qO9hFwOz7PnSYZKMZhwKSrrFb+CCXVOEU1wId4vJRr7MZE0YcRjykRElBVUTDA40PdV89irmqXL0aCMnt4Cl3XkBZt9rijb8JxctKg12nMGTtpV97CWzxRz+F11biy5jlEqptNEuMZEgistDsYA46zPoKyO8e0hoLImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taIjO+Qzgkhs6LoRPFP4Wjmu+qymbHV5malh5rS07+Q=;
 b=JiAOvvGdOb54+/ub324uSiGoxqgiJgwDwErHGbK27+wGgjnrJ60k8vP5cXxFYrLPP5j/y5VasZNbqz0PHUp1pr9IKKpgYmB9fSbzsEDbNvQ/eqKqRYZ7JKeaQf9FngezKbsLji13AvplYzHurCOAqG4lNwMfd1RkMgiP9DOE/GI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB7979.namprd10.prod.outlook.com (2603:10b6:8:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 19:36:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 19:36:26 +0000
Date: Wed, 16 Jul 2025 20:36:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <4fbf4271-6ab9-49c0-b30f-c8716bf19f09@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4b5aff-480b-4fbf-0610-08ddc4a00e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3mgdPvfpc5402XnlIldHkyqc/z7WHUXXmLUxS2R9x5Qw5/JDp+LE1bbanlE+?=
 =?us-ascii?Q?29m2/EMUmuW/fV3CrgMaHvklrpKxZz63vkfn+LAOhMDO44yqjhIUIp14Roxo?=
 =?us-ascii?Q?LAJfSvTQXD11nDY+PpWGesEN3KgjDV3yMebxe2IxqUhWU/3JehXNycL9oXpi?=
 =?us-ascii?Q?N6ifUru2JbyTOLGsP7zgb+M/Te5XSTq3v8NovFRS7ibpWC/NdpU/5hJ7bchu?=
 =?us-ascii?Q?qMToCZrKAg5pfBnnicLxMjqpyJLKe2i0fcJN882NccNv34jSlMC8SXDu3tVp?=
 =?us-ascii?Q?TJzxxy6j2y9y6akhioUqnuR9/qw0ZV3wIdJ1vI6QvVcOVKFyR2IxxiicDdp5?=
 =?us-ascii?Q?tEDjc+14t9/khtAkaHvGyQ7xzuslaY8LitVAY0qoC9VS/qJTzqfEqxh4Um0c?=
 =?us-ascii?Q?qtoFzB+GWBYDc/gPjRQDXcQ5hKV3UH7XE4r5+jqqJSMN/syJ1NEGtWcVeNcq?=
 =?us-ascii?Q?gnzOqCsiXaRrPkermSb3Gi5of9ap8/EPK46OMmZwHXZmrBx1DNpSy/aiCSp2?=
 =?us-ascii?Q?+fNp12sWlwhmuZJkJlfjh+bOU0+bCGLUl4VGeM/QpZanrzLXQPqPO/SiJ/et?=
 =?us-ascii?Q?x4tI4VHSmpx1rObak8iiSYe9igNdF6QxdDsHZC2fY7tIvPJ0iY8P0poKlF3z?=
 =?us-ascii?Q?GtsPewYj6UUuEd3sPXkLE+vK/NOEFGAqYAi1tvRyozY67sOnbDrNWrsvQAzG?=
 =?us-ascii?Q?S9a4N7ydNgH1xwZBUPk4FZmAskym89Qnqi8Vp8r4QdCg1iqC/TxtivG5TlOH?=
 =?us-ascii?Q?eGWEGVotmuOJ59/UUhqBSm1Nqn4yeqUDb6oPO6o+nUFc9WhMerPWDwpJp6DG?=
 =?us-ascii?Q?N3CeFM2QQQO5tt7amYIEs1rV5oRftHMOTAkGl5W68WpgTpBOC3vANOZ+IeI7?=
 =?us-ascii?Q?pu2gcTXZzu9kmO62JOq1u2+GCX1NIaT68I3I2EzM8s5E99CXLWIpzzk5tYnQ?=
 =?us-ascii?Q?Go5EaBSk7oanLL9Ebf97CptHRLcoBrz9NEpdSy5GSisQqucTgxJ2HRjoJDVc?=
 =?us-ascii?Q?YWeoxFvywFsk3XfcH6NUxmuJ03xnXlDQSk4P5amy+rJvmF5HPY/lOtgd+1v5?=
 =?us-ascii?Q?goQF7l6LEde1Gf7E3umeta7ChQy/web1/ETisnhAia2Kl2dQfnMifCkclNVG?=
 =?us-ascii?Q?3x/d0GyxoxxxFXSkMJUIf0dYBGXua5W0wKxNvdAkg/Zg8rNS3y0csRr4urf2?=
 =?us-ascii?Q?/d5xJC8dvx/p6m4UHly71ydUxorxPejf+CGp6DrBOM22J8SmvQyMZZgbzgaD?=
 =?us-ascii?Q?RPuhY4JW/eFBhAhGLMHwbT2gCRBfikwlzyVRT7NloP80vJ9ljTyu0iDqyvaN?=
 =?us-ascii?Q?H4uDsFGudq8caoeeIrRot/rLRBwd3bC4oPPzU0DisGw/7OGqghtZcylt4P6U?=
 =?us-ascii?Q?nJNqRzzSF2iWzMchDUz22g0GAFHTnbYvHtkJHNQ13ep1BjHDoqoG8pTzKLef?=
 =?us-ascii?Q?0/wYiv08dRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zeYa4CHeCdO6DmQxAA5sEyfvivvsv/W62cD7AZ2/gyEuS13lUCJgtWK4HF6L?=
 =?us-ascii?Q?/jQB0XszSJVZ7V8r57g1HaChl4CdpOPmCwvNqS1dtkE8vPAIwPehN/jsJ4v7?=
 =?us-ascii?Q?9EvTwh+m2S2b1CDIVJDmioTYFTMKZWym2oT8CTFO7EfOwOaouODGXjTKc2yZ?=
 =?us-ascii?Q?adnEcuLMvcOiEAiwdYB7glLUGwklE3cf19fMZr+XmP96SEd94w2n/GYvyMjK?=
 =?us-ascii?Q?mg6XFZJiOkKBnSybCu08VZefsya5malh9ys1PlCxq1LJUEPLyRyzhFMXI2Hx?=
 =?us-ascii?Q?ML1K+OT/Px0UYpZspvTe+WM1MIHSCKmJ0yXGGwfwhob/cuGj54q7FCgR05K+?=
 =?us-ascii?Q?er0bCxfgH/LLSgH/uLBSpUhWOdTni7O+jRJ04WJkO7Ej00N4zQu5hnS5LHHP?=
 =?us-ascii?Q?4p/9kUNRaRLftc1tOkeabyXeLj4ruYv56Qv4yNQeOA/bKH6/tXZztOQByNLf?=
 =?us-ascii?Q?P0BaW+pVo/mzPhSrXiwpZ2KpbYYsS0OmUlrXOsAPhRVXWfpW5aeCxmhkO6gt?=
 =?us-ascii?Q?8Ykqvh/7Xr7wQQX4/wxsgrq7hRSi7WR64GnBGlWBrV9igFtYbOfRi73hDqrS?=
 =?us-ascii?Q?iEPm0MXGNyCHg3PIZpg/8Ju3GM46fiTk1f4MBpop5P5Ga+R1apN4Fqd98r23?=
 =?us-ascii?Q?/7g3jP+4hiCgbIJBxHSwq/e1sb6pAflkX+P1tejuB1GBmc2+ti4t7n5rCNq6?=
 =?us-ascii?Q?O9tmD4jxn5n5JCDT8m1IF3ezq5YrgHKBYApI4h3FXaoXk3jWqYBdqgdznQ/d?=
 =?us-ascii?Q?4EgOBCAIOAFsvamDBDVlYBZFm/gvO5eA0Ydd4y0JJZKffXi+vNZrfkd9aEI4?=
 =?us-ascii?Q?whmlm6Y9gvMBj8ZRhppXtW0HolMzsSjoIV+jZfAn6A2WueCFQFB6Acnk9UfM?=
 =?us-ascii?Q?2IbrZ4LRPPWdvReLpRa7InUrX88e3ZCx7Bm//nvq7hXop+ZU/M+DTWHILDhq?=
 =?us-ascii?Q?2MPLlpOZ57N5PAXZRXpFMBK04G5BdEemP7l5J9Jt6Ce+SsbzU4PZ4wvvbYJZ?=
 =?us-ascii?Q?fPlxY8AGLMUy9BeqSiSQoQX9AVrtu9HHDNbwnunQ8y4QF1ZyTiB2eM8fE98S?=
 =?us-ascii?Q?g3W880pzcsbmMfBFP2NktWi79fyBfPJ8ziHrxR7TlQ49qykYCBqyb5QuHYej?=
 =?us-ascii?Q?mLhPid7lQ8VnxvkIgBHaeZfc+gFEOcqfBmGUxj1yykNM47KlITUYPT+c98nG?=
 =?us-ascii?Q?jRyo3KAFxWog97Dvu5q4rr5qZB2d5qIWXLFhs8ow1LlhpZ9TSLsnvaAjWsM9?=
 =?us-ascii?Q?npoC/7om8tWExRkSVrhxrJA5uQCl6Pg/ALcEHl2pyhJTj8cr6wsJSoKWhobO?=
 =?us-ascii?Q?w/Ir37tKzyqNhJnTtmD6448SqlXEtknA4nZL8i7Ho0ul4Rc4y3YYlMb05vMF?=
 =?us-ascii?Q?JHQ9de/b7u5cCpeNBZpM2l36cFsMcyr4Dnbo2CdUWYjcUZPN9hLCUStZAgO5?=
 =?us-ascii?Q?UWAm4JsbdYARxHtYOYoCAjc29+I4JdCDX0UFgA3YCd0kPg2YQFz4dG5wNg+0?=
 =?us-ascii?Q?GI3IkD0x85Yi1ap56kJQ7KWaNWMVzRUcSWadnAuri19Os5idZrynFJzEN3mH?=
 =?us-ascii?Q?JHnXZLF7jvZrypWQr8lx8MEuSdpC/kx39yow3IDZ7Vw1X2ShtoVyagZdWwaF?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDncMVh+YPTpy1622+S4f9iZq2vhsCbr38soHUipBPiVaGKv/c2JECQcYn9rcjnSq9G2tDlm0qs9U26QvtjjKohzIR4/Ip4tCMs0tv5lo0W5614MfbEDR4kEx9w6K/2XccOFJ5SJlcTYs/YFvSgMCJsI9xTjfPK3COxn/1ZwDyThy8dKLW3jJwYtyodSO/dDaJS1c+W53qDOYSFzdT53SPYSOkotc5r0H6OwdCwvb8XgakswL9eASjgdNC9OrPRaaSO1Eh8PhSTPTXlSxRy1wP6AgSO4XH9ilw/oJ9Ww9qSC0C4Y62iBki16Ynnv69k94km6UFAeMoLX0wcunFT3fHgDr54hPYpT6zRxfY8RlqgAd0TbEaVFJDWkl2MoMamBKroC1ftXK47BGx24T/MEHrCNNVQqHYWyL7iLe85yeI1feUSpvbVit0jm4xGcZBjMH/yW6BrHsm9bbzJ034dRkIqR8EzW5rU2PBk9lvQZvxAxH4vWjSyRxaBkYVk4WwtOegi1Lsq96Z3N+FfcfkZLfXoFFEuj91qcaPIoFkMp6gA1fERdr0oK1ZTdqOt+4qrnhQfHyGHTI79QrgvA6H8oSch0Oj3X0rSwKrI3MwTRW30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b5aff-480b-4fbf-0610-08ddc4a00e0c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:36:26.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h87vJCAjqVx64w2GdtphsQc20uSpTlcU32LXc1xiXzC/ZxZW8uQ/4kBPjaLibRZAhgrC+YsNKV6dFO2EkCmAmSfwhHT/RtRPG5zINXgTuF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160176
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6877ff3d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TKIclwkbeNPyZvKG4icA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 8u_TlcGuZxRORkDkRSyA7kk1n0KHbPFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NiBTYWx0ZWRfX2kXaD7aXJPCP RegYiObxl5W9K92m1EoJpiv9soiPA5tiGNtwOhyFuJuVi7UsTl4GMS5t2HXBnGP8eKVoaGgHbnW Z6ozt/JT2qBqC+c/DoPc0Cujimh11289+WGHXW0I53iQlx+Z3ERIDVUSDGlhSf1pvs1Y31Hiecx
 PIyz3rXc81xgmE8vXMt74qeXBu74tvGdaHyr/h5b9v/ae72Kdzn2NLsvAuTQ8UjPd/l1TCUzq+0 OX8XcOuWeepTWH2THqu+zrpaSCnbLeppmV9cjkaK6Tz5IOvCS9NVudCah8+KQj9EcdH5ClxQysz M0+J1HGSe74E9xuPPiN0KB1voiQUlidwwjH86KjxsPefp1PFlNUkqtoafbePpNHV27YbHgamHRv
 kIeDxNlYHAKb+OpVl1oLeWhNPCwsW1bs6okiWGnmdMy4BoYow/Zc/VDwS/12dHcfH5nL8BbK
X-Proofpoint-GUID: 8u_TlcGuZxRORkDkRSyA7kk1n0KHbPFK

Hi Andrew,

Just a quick fix to address issues raised by syzkaller. I removed this code
previously based on misinterpreting review feedback as indicating that I
could do so...

In any case I have tested this against the repro (a well-placed RCU barrier
causes reliable repro it turns out) and confirmed it fixes the issue.

Thanks, Lorenzo

----8<----
From 4e07d53c6627af21847752ec71f5ecd00afab03b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 16 Jul 2025 20:29:54 +0100
Subject: [PATCH] mm/mremap: reset VMI on unmap

Any separate VMA iterator may become invalidated when VMAs are unmapped at
nodes in proximity to the current position of the iterator.

Therefore, reset the iterator at each point where this occurs on a mremap
move.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 7a2e7022139a..15cbd41515ed 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1113,6 +1113,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)

 	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
 	vrm->vma = NULL; /* Invalidated. */
+	vrm->vmi_needs_reset = true;
 	if (err) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_acct_memory(len >> PAGE_SHIFT);
@@ -1367,6 +1368,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
 				vrm->uf_unmap_early);
 		vrm->vma = NULL; /* Invalidated. */
+		vrm->vmi_needs_reset = true;
 		if (err)
 			return err;

--
2.50.1

