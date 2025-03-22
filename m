Return-Path: <linux-fsdevel+bounces-44760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A94BA6C822
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 08:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434A77A4D02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9471B21AD;
	Sat, 22 Mar 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PMfHLzPY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b28F6HbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EC18A6A5
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742629551; cv=fail; b=i1NhWpDL8bjickWXKKipijppZs2wWyZrZYz7OHWZm6q4N7K8357J1PcDo+XGy3MZpAwug2R7eSr1bQU70G01xCApGHRE/yySjZkrYYCh9qIyD6+1ufZmjitfR7xwQLcfLhd1P0AWN3wUEx+xIEjtLWP88cJoBZFxKINwKt0Yqdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742629551; c=relaxed/simple;
	bh=3697MBsRGaTGpdZ+eqLomVusZpuTt9oho1vV3EEZ6p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVtbAYDxM9ZOt7buOJNKJkXJ8hpTg4oiQ5TSm9EN53bugATfivt6XkIie+SkjIz9GOmZhsRYk92PtLMn1pDurA2r9N2eAJIyeewpd5SanLH7zO8K82X2QyoVCibWCKor36iz3Elf+WX98sqvKopADw7scMHkHx/uJ89itGqPyO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PMfHLzPY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b28F6HbI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5EH4H031639;
	Sat, 22 Mar 2025 07:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3697MBsRGaTGpdZ+eq
	LomVusZpuTt9oho1vV3EEZ6p4=; b=PMfHLzPY49+3GGhiFt1QysoDZ7/kBpuz3R
	xN7QGngGIW7x5us+Am8nFzJbjBd9ARkhGftpGP4FSw2dIKBAeWi85x97IeG5cvcF
	3Qc0ljn6JqLFB9hdRXzd3CqDoRk69naERmjhJjWcG21dbYRtdJUgEgo9qaJls+n9
	wVHA47+xCGnhXfZvMsPZcZ0DzuSLfdXChqGc2d/BhOhJSv13LapoBhHgWwnHmaTS
	aFV8ZFH9uSJbQTRz+r8idK8a11SMrUGwUsTf3s9XfcLAJ5C2TGA27RS54HjVYL8L
	QbblaEqsQe8YsMBPxwNRdX91aCQt2q6dOLD1xKAh0nJYjyScEfZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrg41g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:45:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52M399pT007407;
	Sat, 22 Mar 2025 07:45:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn65eq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA8IEwfRBNzRmP/Q0hkXJ5F1Jennz8xBztI16o3XF9e6ua9zlC9w1fjE0VN+E4UnGqBJtXwFprJvXknMffCqpnpQ+E97wfG/pvtN0GOzpRqBkpNQ0Ltwevw7ziKIbKq4+bO1MdifblSNbv81wQEZChU1M6nve78iSv2SJmyq7xC/DKWycVHtB8YiOSa5jBpfwqoiJInTVjPJomzxB82Rbc8Rbv32cLOFrtH+6B8JCdkvF5f1KRhaQ5bJ1NIT4QAzyAb3i6JWiYfqTn+XTk+9/ZBg0k6r9pLSyCZBXHQlC3rP9aX4CQrFAXRe5tJ/g3/1UvRnl6tuQ48OuPE371Ho/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3697MBsRGaTGpdZ+eqLomVusZpuTt9oho1vV3EEZ6p4=;
 b=VvvkTEAim9enrZLZrqDHzcQDQWJrkXwboRQAvqgg68oZfnVe8peoN8ClkCO33d05/c+uSPBmIKgesVr2hXzekXJC+Ul5irwjrVegT/12rgoH2aOdwae/T4feAQmVf9TT5Il+6lm20CiC+P1z9DW0jdSmjnlyhAVBtlWw/QM80svk88w/I7m7QQuUz/PGCEZx9WVmbKT9KUgZxfqB3I+/VoFXFdYFGkF7ddcz/nO/W9kLi9xcHO4Af5nEufDbXxpzE9e6slJrzFiy6o+ntqKnSjZI/9Jo1or5vuOj9eV2/D9r8zdM+m9BDPAvo6h0xCg/Z9+gkns01w2/rVAYH3N0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3697MBsRGaTGpdZ+eqLomVusZpuTt9oho1vV3EEZ6p4=;
 b=b28F6HbI9CZG/bLoV5VY2EYFL5mH5wcz/rlDTDQqhkUoVWdfYMsI7fW7+dgAZljQIIZm8KieIIYZeUOfQ8jInYcg6IwFSWp+DTtd5eUrmTrNXHf8Bkthrxjf9F78WqmLV1cTfVAufxA7OsbARpOv80i2BRY5JwU0m3uOsJbY+fY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 07:45:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 07:45:32 +0000
Date: Sat, 22 Mar 2025 07:45:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <ecb0419a-939f-40a8-97bc-ea2294e65807@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
 <9699c035-e629-447f-b237-c8fb5c1e34df@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9699c035-e629-447f-b237-c8fb5c1e34df@lucifer.local>
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: fa438fa9-fdda-46c3-55d1-08dd69158647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6c/tPiYrtzNevijdloEXZQI3W4k1FHJzxl+TKXLwlw7V1gUxfjGxA/UmkeU3?=
 =?us-ascii?Q?KqFyygz0Uc12yyebrRgZ304bDlIG8joKd/UyfImrk4gNsjtrF8DVZdmfqAIo?=
 =?us-ascii?Q?31Hw/d6U9Ed7J+uKkDf6Q68iYwdmTRwnRkYzrNYyn73kQaWOtSeCj3aZe6SK?=
 =?us-ascii?Q?RD6pLrTbA1xNqvPDxpZq/VRZb8SlBpigPRUc80y2e3IbrXfhga1IGms9gj7n?=
 =?us-ascii?Q?4ezjO8UsRiB/vbIbYU+aNCLNSa7xNV24m6ZiARbjY7j/K4/idtslp21fHyqh?=
 =?us-ascii?Q?wF1oqwGJUO+fbF32Y/Nnad9sKqqnXbTBbaThybwS8BLQVWrmpJbaJ6Cy16jz?=
 =?us-ascii?Q?b0k1CjWjly3/8TERk/F4xCrzsETwky8xTVeha2yXynigDH/BsMDicouuAQ/t?=
 =?us-ascii?Q?LlHWH+LiwI9TsNYkoS/NhpmsdZrE9B5toAAeKA/CWKBfl79E98+umAqleh6Z?=
 =?us-ascii?Q?MjJCTJqMjcqtzgT2NnzeECORKNbvQC7SfOkldBQB2u6JkfCdM/n0cyzGBaUW?=
 =?us-ascii?Q?QUoCwVHo8AbhY4FI6n0rEEw73s15lLUgXyDedhJczfkUAj/idyluEIuE2RPB?=
 =?us-ascii?Q?SbD/5wjx/bWdfPvoqkNEJsUdyEdXOEO4f1I3pxijJo5Sw5z3tf6/lV6e8vBo?=
 =?us-ascii?Q?X4aZf2XF7ox/07uQf9BDjHbpi8v5xki4O/PZsJo+kX4xmWVYZBNDU3UUIMmz?=
 =?us-ascii?Q?gKSldDi7U7ngytlRvn4pFh8UFajm00h0hRH/ucuO3kEkhasNbjN2YVjzNzEh?=
 =?us-ascii?Q?t1qRa8ghmzLQmSghVtbdTOo4erGYRUA/i61txMsfmcyxMYLVdodOtu7YbA/2?=
 =?us-ascii?Q?3belIbrU5KFHffJI9Cb2JS0pjI9KOuqQUx/4LPWsNqE2Zrttf98B3oxcVRHj?=
 =?us-ascii?Q?TICKw56c/AokTCeCF4Brw4LRYqCA3D7c46CDkOsXrQy7UaFKcemhRQuulwxW?=
 =?us-ascii?Q?6F3GByt0eR+8rfYF2mzcXrgRvbftm9prTxoBzFRAUZTPs+GmhOlscD2J7Rst?=
 =?us-ascii?Q?WWhCZYO73JxXENA8I32J71or7O/p3sdGBzfvTwdMLGbeZhSU3Zd6CZP6ArQH?=
 =?us-ascii?Q?Sf0fQ0FK7kff1EWmNjvpKUe7L4RnhHZHDVQ7FqONIGLgafuHmy0XzGNW5VPz?=
 =?us-ascii?Q?qDF9bLv5h0dEKtMA8xEcBYxznRuUzznjffJFN/X5y/JQLqamFhBqx5cjHYRb?=
 =?us-ascii?Q?Mm+B0TFPR1x26sh+i09Zao1tc6lvXXVgiD8aB9rxcmw5v9fFl1cDG2mTQ9AR?=
 =?us-ascii?Q?0nR/24FKT88OZNsD8tkW7XeIJJuktEyIiVvj4QyGy7FhNFFgzSJXOKsAhPmX?=
 =?us-ascii?Q?YPdWvHae2eHSzTDrpDjECtA3Y/ByBT0KjyRHfdZGQN7Jg+Kq0MxAhlXdBzX+?=
 =?us-ascii?Q?9ktbwIhbbxDBw/Iz5w6uUXwJjdAcXWAkeR+txEiCzrIFWABXAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xw7yoXNr7stl22ks2/Ox89ZNY2U8YEXsOwWp76e2e4oVbhBkbgW+jw/PyRSL?=
 =?us-ascii?Q?pv68RXeS0euYP7GHJmNH3Amvs+vxlCsJLk4rc7JhEvA6lKtDE8Y3fVSI22Wn?=
 =?us-ascii?Q?71THrRwEpPduBlqfgmhu4jzlzp6nohiz+yANGtBnA+H5WQV8bqGckHrxqfQq?=
 =?us-ascii?Q?O2EorJznagdYg4jfY0GXfPZke56eQ4TskG2KTrWvgrRlHSIM54ei/51xTuYv?=
 =?us-ascii?Q?7eq9mcEJbmEfRxJiF5EvepTzNuMyC6sN9J4bv7iYr7/0ZAdKLDcOAHl8x0Gi?=
 =?us-ascii?Q?zphHQ9hqsUHqnp9SeeRTn6pZ3HFHTK/BfMJpsbad3oWPx2pSijqQ0XIlKU0H?=
 =?us-ascii?Q?UnoBu1kgjaW27fxGMu9OkwAiqriV/hOQjfjnzhr9at2VO5atUv0lk3PmbBYu?=
 =?us-ascii?Q?foX+PcXmPsZSfLrLtH2U5XYt/ccyA9uHHxVWKKi/LtxOe+rql8/98UsKdLjS?=
 =?us-ascii?Q?UfiugXYm8PovJt4k+bM8BmL6VV3rZwqv+RVMQKsW3LzFK94P2EXeeg4RYixu?=
 =?us-ascii?Q?WqwXaGuGmLk6Jo1Q1CWOo/EFtHLzlS3D1qIWszX8zzNDTdFUI7MHQgh1eSSY?=
 =?us-ascii?Q?yG//YLW0E+t7Z9qdaiqe9fVkCFiI50S3d7Hvn+RvAwQap4KdL44VAYS6M0p3?=
 =?us-ascii?Q?jv6d7EqY1KM7kB605P/fMCuqhOPR0dGdsBpeJHEcwhTesuXoeed6clC5CV44?=
 =?us-ascii?Q?T+tCMFEhTvAClZWlHJTx7Dfohd0Ot8PWXsODzXa2Azz4nqTfiaBXTC8Q8SZl?=
 =?us-ascii?Q?D5RZWdOc0JuqjJ9RHFAP0rCYTDrOz8ZJtPMtfKvEpLkG2oVoRg2m7Uae8yFa?=
 =?us-ascii?Q?kQLm3e3gs8uij4C9t6ZCm7pTOvPuYAVzIWAat4Dxo/dZn7K0u4pKIcYzyvi6?=
 =?us-ascii?Q?yiQPOznsbZr85QK3RU28cGiTv2OKVNTAcE8J1wz1HaO3tV0m6p58HtYOkFIc?=
 =?us-ascii?Q?mWJlr1GYl2dP88qM+X5mdgSV+KMu0lRZdH1vgeum1xbjeBrCz3o4obozyOF/?=
 =?us-ascii?Q?/WH989LAuD3hMhfUJJtp1qPGjD2IfiiTN/PQ9qLeLIHD4+xMbTWrenhsiPjz?=
 =?us-ascii?Q?1hu6314GLnWRp5tS4W8Css/Dmjao99kkGAu3r17FBvXsKlzcAyZ6I3UWg9E3?=
 =?us-ascii?Q?Yo3juVW1I3UkWS02xyvDx+WICyMgb0yBu5nuq1IvERet+j0S0q18BPrg8MW2?=
 =?us-ascii?Q?oLgxgKS9cw+zstP2RYtRYbg23FdIowaKfaUUbypOG33vBOfAavSGfJLfzSri?=
 =?us-ascii?Q?jTTCyx/CGaDnhPVD164xUCcKgacZzRMBQnkUqaLqpcq3tRq9PvHRy6MuS5Yz?=
 =?us-ascii?Q?mRn1H0d1Yk6AFBfMacv6h+kBEF15uBOrWfhHaozmZ16c1C2jXFv2BkxASbE/?=
 =?us-ascii?Q?alhGuz9q1y7OygHsWS3GwyVb/H5GxI96/bUcQHkmRI3rfo6NsLJw560AvihV?=
 =?us-ascii?Q?q9LItsffSpPkkAleFBzCz9XlNzKbia+MdFdVkgMPviPQGM5NIgAXJnrhJR1E?=
 =?us-ascii?Q?5TRT5WyCJOq8iWQ9VBzEBDCC86zXkWFFZX5COND0yeJjIJmlkUFLJgBwLW3W?=
 =?us-ascii?Q?q83P72nQhLRNmm5oFCqnAEYYOzMXPlFW7P1QkEuS1U+qFM8HwC/6UV5GpO95?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pj7GS+iPJGQwfhC1PgFnN3dGzQbOM7WrUy8IVY8NX0h+LX6s6g5fjgwPHQG/oaB1v8EjaUydQvw0AQk3P1fWINU8RqQqggfD5ch8OgdJXZfPgQ4pjhZ2VECOHaJI+/rJYc+LSZJFlao/Xo8jBgnSffIZOVEqPtAn8PsTWU8IDzZ+IFy3GuZ5xkaU42JKH9PC05Ik8cQQFAgYh9QxaUCwtQ2wycpg9qF52r62mE5PdHAJvkc5aa463efnozXlfUo4LbCT80DewnuvcuIwNTnLaC4xg/EcJrPPUoBVUDC/qfQYaov6co9ZHuwlM2kVoNBlopa+xso1Zjj9S2xUkQrqjFlN8vB+Vzzclznl9qgrWjbvjJUitBn218vnVXzfykF2uBsayY9vo7n5NwAZZPParmawlu5VDD/bbK3nUxGFUCKNVo9sFEk8O8f6lTctKg6UkgYhBJ763i8Vt08GysM+zX9RAa7U1IUlDMRH6pN3OdcrPD0vEgItlDbzz9pX1ms2F6im/78vqqB3oT3ByfCRFeAPLWJ4wa/1xOhYpmRF8qSFAiS+Edxp2MDOgnikAhwOm6N4W8crp9iCyaexUlxttKEere+BJQCi2l2LpU77nmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa438fa9-fdda-46c3-55d1-08dd69158647
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 07:45:32.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QQQM6NgEyZkdDkOypcqE/XOL2Y+P/4hmaQy6vLzlNuZTZsSMTeNFMJJwTrMx1CATbK7zgt8KYrbymqJKiNGK6tPTD3rp8GY+6zSPfRoi30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220054
X-Proofpoint-GUID: NuQN_nexfVs5LSD8Xh5PlMHVCAWET0Xh
X-Proofpoint-ORIG-GUID: NuQN_nexfVs5LSD8Xh5PlMHVCAWET0Xh

Michal has kindly already updated, but the subject in thread is now misleading,
correct one is 'Better anon VMA merging' :)

On Thu, Mar 13, 2025 at 06:41:40PM +0000, Lorenzo Stoakes wrote:
> As with the ongoing evolution of this, as previously discussed, the focus
> has settled on merging of anonymous VMAs and improving this mergeability.
>
> I have an RFC series (not upstreamed yet, but should be by LSF) which
> optionally permits improved anonymous mapping mergeability by passing a
> flag to mremap().

Now posted at
https://lore.kernel.org/all/cover.1742478846.git.lorenzo.stoakes@oracle.com/

Also with a pre-requisite series at
https://lore.kernel.org/all/cover.1742245056.git.lorenzo.stoakes@oracle.com/

>
> In this topic I'd like to discuss that, anon_vma in general motivations for
> it, why it's hard, etc.
>
> This dovetails with the original proposal - bit is a less ambitious, more
> short-term 'how can we improve the situation' kind of thing. Maybe next
> year there can be more :)
>
> My slides are at ~31 right now, so I wonder whether I could have an hour
> slot for this? As I'd also like to have some discussion of course! :)

Just for the record haha - that's no need for this :P I have already cut my
slides down to 1/2 hour.

The remaining ones can perhaps be re-used at a different conference where I
could go into more introductionary depth on anon_vma etc.!

>
> Thanks!

See you all in Montreal! :)

Cheers, Lorenzo

