Return-Path: <linux-fsdevel+bounces-67283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5CC3A624
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B5C420E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAE2EBB83;
	Thu,  6 Nov 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vh0+VPq0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M0crV9sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6030C622;
	Thu,  6 Nov 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426019; cv=fail; b=pB5ospth+IMkKvg+FJ4JU1WRSgC5TXZxuOI6DFYMy5MsRy24NaJeibNAoHrtce1eQ4w6U5vvV+5IuxWQD0UEtAzdu//GTkpcfYLchN3lqST37igf/LBgtk4v4ilhSVD0ez22XdYAbHn2XXjhyvSpTJTJHLsTxmftej2h2i7nsXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426019; c=relaxed/simple;
	bh=bomeT28G7JskK2jERGmwOkLyQUUlx+8UqQNQu6E1ay4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEFoJ/sxXZ6plxyhjLFbmuOC6fBGXU25pPbqiFxk3K0SMDnLNhjAfAm+wx1yIPYY2dcKty8D47uzo36xb0moDCtC5ldRWdLxao0zsQnOyU4bRhlYPKTNu+8yDVgQzegMiba6mTYgwjSNDkhfcxTgi2sIUokGyvEc4ZVDD4CcG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vh0+VPq0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M0crV9sv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A62Ifxh032322;
	Thu, 6 Nov 2025 10:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=; b=
	Vh0+VPq0hJEkDWlm2MP5VIXpMmYArjbIchvtxBcBoXQ1SMNEan8NbOZesX2MfK12
	hzvsR8emXbxH+k5Q8gbSEDZvm0kQzD11v2g+DV7qzO2TnbPLTDxIaPDKszTv8xtD
	p0WgGH/xC9fFs0dIYHbYkS+gJWHeT1tTioGOs28AzRo/+RNC4IFpp7GYFFgd/dnn
	N8+ZyQj51P0kQbiovFkWoXj127DqduKlAHNX70juBLBfjoGr1lPZhxdwDvzO2qca
	ebp7NKMgp8kwyryb5gBS80cCalG5WtQjMawWj9pCle0OIZEcuBaj7/tXGFhwUJ44
	p3cop991AUkNQYhBZJaZdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at91qq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A694eVH035862;
	Thu, 6 Nov 2025 10:46:36 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58np2bcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFh0ZS76h9JbsHiGWIKqFhq6YL+itIUB/Kx2nLpl36ExPwcMS5WG37MB2LGWEaMGfqMBCGHkIildU9aH1/8FcWqRVMYJYm9j6GH5fkBt7i7eohTQy8AsrunRM40uCaeviZn2ezaM73OOyjFjwqPWnkeOdfU1ADzxakqUZiUGPrm4z42pn3+lLeQzlw0/t7Fa3RmrBa0Qbb9jHfFTzgnEp1B6JdCsujx+ztXbY41g9z+9Uu3JjmgpskYw2spvNPIQXuAfJt+ragFiLCBhkzRNOLOhF1NSBPElAzNcnpQTmfdrZyA+PuSeBKJNo8r5mKA0oeGh5WEfmeagVn0InwVrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=;
 b=V4Xidj6c+oBQvlJ8sJ6BY7fL+PMobHErGSYPD/eAlB0MyNugTCtYZ5asgnDyf/NpsTLyLmi9OdygPeFw65PhB88CGm0GQ5XrNQJXSDu2W9yQgIw8e8A5paOe2kCd+5BmnRyPpGk6UWA1Ucd2BxkeROXkmXHvuDr/kEC9wXP1AhDIMeD7zRZHXGGn2cl4OnyTwLlwdj7tJlkkQw+UGhG9eE8NQeXLoa/JfkY8SEtXSYwDdpYCMfI47r+4S+DL3yqATAV+J87XcpdKowmzBIji4vnnV566gB8uKUgscr3K18bqYYENe7uFL5YPezLrPJfnkJ1Usy9AnzSHPg3sEz7slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6/T38T5zZKTJldzxmf2c5KhA30BP48594uIkLQc4aQ=;
 b=M0crV9sveY8CvghV7pdMBMkCR0d38nPumoMxD7HGJ3BUqUw9zV/CyHDCf7NtFFV60bhFJsZI+sy6YvArDu2pZ61rxBgabQ/at2ThBeZFMqtPLKhGUzOihJB9WimDwX0BJDqv+mpqvi/8vIeLfApVLMojA/Zhc4auiRFN5u9TUeA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:46:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 10:46:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v2 5/5] selftests/mm/guard-regions: add smaps visibility test
Date: Thu,  6 Nov 2025 10:46:16 +0000
Message-ID: <b535069ea375281fcbeb7c60b615bca0bb92982c.1762422915.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3fc5d5-5fbd-4c10-952b-08de1d21c0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeWu8Zu49uNcBwlb37q/QHeBCzjqqUZyiKRYC39u5YeJ8xJESlp31CCEyK7i?=
 =?us-ascii?Q?W/njQjuGtp5bAfx5PwxwsbrCeuJozWNbG7ybpsGUh9fIL4TC0KgIyXiRzvWB?=
 =?us-ascii?Q?IumSMuBkjsyVdgxsoyI0YKP+OHvkMjNyVjWbUBDUUTIoJwjGp+QjUq7xzBMn?=
 =?us-ascii?Q?FWwQMwNBWpfiGx6vvRHzY7i7Y1jstrjhUniwYgDfhu954uNfQ80wDl2sBbea?=
 =?us-ascii?Q?BdyjXRvlbcCf+1P1hnM9JBkiPAp+xOCScFzwmu+tNHDjnv3AChJAQ2IP7sjY?=
 =?us-ascii?Q?y7hHH/HuJGvmZZVu0RZr1G9KE+/25dHz7/QoJCa5pJMnaEA5Bhnhv9BOw2/3?=
 =?us-ascii?Q?MOCjql4qJzMew6vzlJCP+z4XYOCBGa4ZYSL3xH+qj6Jda+oykqQLxKzTj19Y?=
 =?us-ascii?Q?EgIZQHVbGShe0rDjFq2pOMJc85e6RvwGBihuxdHfd4IYuB73/f1J+LiO1Vj6?=
 =?us-ascii?Q?EKTzlTCqkG8H8qDoiVNp+WGpdlGA6BFC+yrWBsXhtQGFweIvrjbSSRtZk9QL?=
 =?us-ascii?Q?LLgXd2SwDIwlhKthBixgQBAosTVN3p/htmbrrQbafsGr1T8cN3WmPKhhrgiZ?=
 =?us-ascii?Q?PTgF0psnTQ9x/4fzBQp174EGKfFERrG1VqeKBDYvBW+utOgDL4rXVp+0ipIC?=
 =?us-ascii?Q?UIKRbR4PdAXfx8Tyhp0bagMD1ZNMkJ+CVll02poz+TZOQLZC7YAv+FmVkOUg?=
 =?us-ascii?Q?hW5paVp0sJCPr7IyB+dLwi2Q+3UW0W56d3eCK63+D9m0DnSCyMkdDs33l6g/?=
 =?us-ascii?Q?6wd+6Rk5DpWTA7jzot7DLbYFTMjUJE1QPlMtc80aYS7wRtPqq5Y5FdIZ0+sF?=
 =?us-ascii?Q?X0BKyy9PZgYWoaci4RQ8YZbr0Sh6CdNAOYX8lRtGZC0kL9IaBlJqLbCeBOPa?=
 =?us-ascii?Q?VlnIN9XQXoF5BjF+xtaC2/KoYLP3TJ4fMIAv0ZAKr/Q0Y52USYbPBZphTjM/?=
 =?us-ascii?Q?8/BN/6bkWA5IAUYAC3+emZ9XIoOvnp7xeJZ+T+bnXwLL27jPRt0aQrP+E2AD?=
 =?us-ascii?Q?NUwR6f1WLMwS9K0uFu4vU5dFIyGxnUmgFd2M+RttiIyBK1i78OdQOeAyfNqZ?=
 =?us-ascii?Q?TbC0wJuvf0MDwQxh42yFPM1zH8fsXFIaYo7Dpnrln01BaHkKHKZFCvZogP4P?=
 =?us-ascii?Q?8X1MinZ+x7JomdknozOorm8sfy+Hd6ge4wtDRTtv45wHNKO39hFvrpq/CI/8?=
 =?us-ascii?Q?gNc+grwl9Cx5JbAjmHxmprMMFgIuYG7OxQgUlVosI97gxsfiw88xz9dc2+Q6?=
 =?us-ascii?Q?TUqCk/TveUvl8/iiJnP914xg5vFq38d8AfF/YWstRToX4vdhvPtZ7LMD/qLR?=
 =?us-ascii?Q?XxGar5rxC5y/m/Sn//txG5hHui6bbJNx4h53j9YJg1d6zGIkIEqnzlDcy+Bm?=
 =?us-ascii?Q?H6svqPq1h/npQ/dt1Px9gS5eT9FtXqmvL0llPctvxjoDS+cyPVKFDTVmUIk+?=
 =?us-ascii?Q?9hIHgY9aGzirkEuaCWVqNnnvQlDT9ALQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wweVTeIB8am1GmtZzNLovSqn7xx9XJNAfMk+1FfAec/lgEPaXtMeftAP1EqH?=
 =?us-ascii?Q?T214cgmdHrNFmIwM60I1cv4PByUduA0vG9AaU2/eR+DV4JOcdJS6G7F3UNvq?=
 =?us-ascii?Q?x45x8k9HggZHEuSSGrKUrkioHnQL3Ho2JYpHpIBN+yLls8qSDOfOWOq18rKW?=
 =?us-ascii?Q?mpMxs63SoqusBD0vajmN6o5512hIQ4rKVDEZ7fW2TU2GCj8dVwoUhG/UMHaR?=
 =?us-ascii?Q?rnzaeKRoDMceHkArc00Gzyaj+RFEMj3gOkUU4tCRM0Jye/5/bhCCJeLPMtPU?=
 =?us-ascii?Q?/U3bfW9gDzJXRXirtHxlHoKRYepPrODgS2xoxdPcBu8aEv+UCshTL3wQqTtj?=
 =?us-ascii?Q?zaiE6Ehnvc1FPnhKwxS9qXqBs1GobJng9+uD4KINO2o9kZVNwzfSValxR1DD?=
 =?us-ascii?Q?jCp1K4K05AEkfn++p4r+10f9y6cd1gHBwzjq3iL8QjkmabykcsDZjLke2i1+?=
 =?us-ascii?Q?bR2etKVKmOevHltWhYEFogZ9btSLxUx8xEfrv7knS8ztWCgfKq7lTpM+gii0?=
 =?us-ascii?Q?Fkaupucz9wky+8JJp0dZJdYIGw7VW4vgv2rRBLOoaXQgcrw3nrPSCzcd76vH?=
 =?us-ascii?Q?/Nfd9Zz+oV9WbrfcfodeK4DC2S3fDDclVVM39c5+NY/1OeJT4pfDzu1KKgdT?=
 =?us-ascii?Q?UdbswOHLEG0lEgm3CXnNewNgARlHnV9woL8IvkXr0YqtwK+fUOKxXnDfoxxM?=
 =?us-ascii?Q?Iq+rEPSMXtBCFviuzRDPPhe/DK1jlixDx4urpKhPQUrlkBjAt/XQ7vwdIE6M?=
 =?us-ascii?Q?88ZQnmkiz/a/QqUPerCTGEDqGZIoDQKfYHh7axcQwC9Kyn7dOtYUoXdFYy41?=
 =?us-ascii?Q?vHYR00yBAOuwCuOYb1N+x6Dd8nfIqx0ZpDrTfqC9Ex8QleJQfJz74IPlScqM?=
 =?us-ascii?Q?7Z94K7kWVaYxSLWMOvPCxJdjgK8572nE3cjldKFldJee+uYCXRo0FhqYnBY+?=
 =?us-ascii?Q?XTKCCySZb66Tt8utDbuPhZSfS22kwPbkwaqU2h9tCvDQMZ1Edg9LYS2A4FKc?=
 =?us-ascii?Q?35Djw7pwTn63pxaU/k4wmGob2roxncntyAzP4KerENoveW8toq6ZBA2PQANs?=
 =?us-ascii?Q?SwmZARb3VpdSgteJf3/1yk7Get6MXIn6UHYmooJFBULExv82+BMDHdmaju+N?=
 =?us-ascii?Q?clxR6brW0DQ0gt0qcy/d825TkSOJX5WSUyI6JywI2JNCsbEhz/pyQuYQwvmx?=
 =?us-ascii?Q?+D5r32ZVpb510r/9kzobV5J3C5XAterMrustYpwhxLWsb/QIzJxmHIjR8vHK?=
 =?us-ascii?Q?gNnmRvJ6SnbDtpMkjkZgQaiaweiI0BI4oX/gd6YDq8D0u3xN60zmGkXdtw/w?=
 =?us-ascii?Q?gXK0XnrPq24bw4BEtLA5vGgAY5mqVzNxUwh4yDm5Fz4R+tLoEWIZObbT3ZJY?=
 =?us-ascii?Q?9ZbRDkiSq+2A4/PlEOfk7WvVev18p36cneBsH7CPPp9yR8lIZD40Sp14/60A?=
 =?us-ascii?Q?VZWORXe1Sr0e5ncxYYf/IIv2r71WaqGyVfAVg+YC21nkTwwEcD55sZJdMvnK?=
 =?us-ascii?Q?4UhdDwfuIClc90eNJOZ6cc4q/L4HW93yKlvLUSd7YsrrSE4q/GD7v23+uJN7?=
 =?us-ascii?Q?7jtm7jKCwHo6mxNg3Ngp87aCchsRAgw6lrVLhodjLr1Z9mmczTTPOmlaiGnd?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tUzWNsYc5GxuPdtSyJreM7DeNPLWCuaa48bFZ9Lx4xw8Isw1ynSq/h5I6FePpgAT0GAiB1wX4bV/QL/T27do+xjU37+m4aYgGRqX4UluXPyx/rPVDwD7Kc4/LjQfdBY5ulU9rwjxg/CqD09u1KmMA4scm+qBb7dZDsOvbSfMW9+K0ZaagP78KwPdiY+2WlbK3cSj4yQRWLMR94OlQLo05s7c/aMgmFCO29ykh7pNJUAzzMwATGzn2Z9hUGVy8dXcdTxvU8NeawBa6rfugy+73io4D5pd5GlGyF5ZD/FlGoQ6Jx/jxQ1ZXoh/oDx2MOZ4FNF/19z2i9a4rkHQh/VKtBaNOm/5HZHxyBmhmiZ+vDvcpP2rey17t4f7AQbK/U9ObGTIxnVFfMfzlXeJDI/4pKoXafyFt1wM6e9mYU296cKdeK1zzTsaMbfYKLTSG+3JBBuIvYpuxOeMFTNMu93kFJT4LLajzGkJEtBKaYTsz4o63v6sbd6Ncg523Ahro5cKtAOdZNE7dhe8LZYFHYkcOaagQDTHVvIZlmtCFEcNiNYIrnuHKT1RWwF5rfXpAYYn3ptItRcjhCIdYrjNRRJMk2ghwDgat5tEJY7j4b9XnIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3fc5d5-5fbd-4c10-952b-08de1d21c0a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:46:33.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWKzAGb1+wtnxSNm3h8WFR7cKKuUn+KA+QT64fPTn1dEKvsp7MQC7xmuyDq3uo4U+g65XrUlBBcBjKJDNxtvUsFhOSoeaj9DSk7+N7N+te0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060084
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690c7c8e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=7oKVWYA_E11v4TV8rOgA:9 cc=ntf awl=host:12124
X-Proofpoint-GUID: Rq1anBKADCsFCm23yctRw0UZkB_JeUz3
X-Proofpoint-ORIG-GUID: Rq1anBKADCsFCm23yctRw0UZkB_JeUz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX9igYtP42osce
 s+rx7zHcoyoLnJcGDyGN1a6ph9CCy9a2omGw7b291yZxJ3WhYZtS54+6CTNWiOajawcRqgAjhko
 PQB7zIT2/APwuV8WY6l1WpgBTQPXAY6H0yZwS5kwcJRYwFtF/J8iWK0k8ZN3HGoc6/YrW5oLRIQ
 2rZvcZscXs7etAJAfaHGln6c5u5spcLeuM9Ihv9jOeT12squ2u4A2w/qPhC5D8xB8CVXV+Aykj5
 jNe8WEJRsTsNyfan1ILeUjXtJu6Rbx7JRJHH1iNH0EIynZhtjiolkeRNDlicozVfIvZeO0Zv/I4
 pV/n+utFmsPGwLHDNNN6CDXwjVbdXEuxUgDOBeWhdYeE0ntmzVY839fWxoWK3ScluaU6wKznzfp
 t8xBrh7UqGgUZBU+mk9qQPwTVb5MIc8Qmj23pvwTYpt8CEcYjMc=

Assert that we observe guard regions appearing in /proc/$pid/smaps as
expected, and when split/merge is performed too (with expected sticky
behaviour).

Also add handling for file systems which don't sanely handle mmap() VMA
merging so we don't incorrectly encounter a test failure in this situation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 120 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 8dd81c0a4a5a..a9be11e03a6a 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -94,6 +94,7 @@ static void *mmap_(FIXTURE_DATA(guard_regions) * self,
 	case ANON_BACKED:
 		flags |= MAP_PRIVATE | MAP_ANON;
 		fd = -1;
+		offset = 0;
 		break;
 	case SHMEM_BACKED:
 	case LOCAL_FILE_BACKED:
@@ -260,6 +261,54 @@ static bool is_buf_eq(char *buf, size_t size, char chr)
 	return true;
 }
 
+/*
+ * Some file systems have issues with merging due to changing merge-sensitive
+ * parameters in the .mmap callback, and prior to .mmap_prepare being
+ * implemented everywhere this will now result in an unexpected failure to
+ * merge (e.g. - overlayfs).
+ *
+ * Perform a simple test to see if the local file system suffers from this, if
+ * it does then we can skip test logic that assumes local file system merging is
+ * sane.
+ */
+static bool local_fs_has_sane_mmap(FIXTURE_DATA(guard_regions) * self,
+				   const FIXTURE_VARIANT(guard_regions) * variant)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr2;
+	struct procmap_fd procmap;
+
+	if (variant->backing != LOCAL_FILE_BACKED)
+		return true;
+
+	/* Map 10 pages. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	if (ptr == MAP_FAILED)
+		return false;
+	/* Unmap the middle. */
+	munmap(&ptr[5 * page_size], page_size);
+
+	/* Map again. */
+	ptr2 = mmap_(self, variant, &ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		     MAP_FIXED, 5 * page_size);
+
+	if (ptr2 == MAP_FAILED)
+		return false;
+
+	/* Now make sure they all merged. */
+	if (open_self_procmap(&procmap) != 0)
+		return false;
+	if (!find_vma_procmap(&procmap, ptr))
+		return false;
+	if (procmap.query.vma_start != (unsigned long)ptr)
+		return false;
+	if (procmap.query.vma_end != (unsigned long)ptr + 10 * page_size)
+		return false;
+	close_procmap(&procmap);
+
+	return true;
+}
+
 FIXTURE_SETUP(guard_regions)
 {
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
@@ -2138,4 +2187,75 @@ TEST_F(guard_regions, pagemap_scan)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+TEST_F(guard_regions, smaps)
+{
+	const unsigned long page_size = self->page_size;
+	struct procmap_fd procmap;
+	char *ptr, *ptr2;
+	int i;
+
+	/* Map a region. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We shouldn't yet see a guard flag. */
+	ASSERT_FALSE(check_vmflag_guard(ptr));
+
+	/* Install a single guard region. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Now we should see a guard flag. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/*
+	 * Removing the guard region should not change things because we simply
+	 * cannot accurately track whether a given VMA has had all of its guard
+	 * regions removed.
+	 */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_REMOVE), 0);
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/* Install guard regions throughout. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_EQ(madvise(&ptr[i * page_size], page_size, MADV_GUARD_INSTALL), 0);
+		/* We should always see the guard region flag. */
+		ASSERT_TRUE(check_vmflag_guard(ptr));
+	}
+
+	/* Split into two VMAs. */
+	ASSERT_EQ(munmap(&ptr[4 * page_size], page_size), 0);
+
+	/* Both VMAs should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+	ASSERT_TRUE(check_vmflag_guard(&ptr[5 * page_size]));
+
+	/*
+	 * If the local file system is unable to merge VMAs due to having
+	 * unusual characteristics, there is no point in asserting merge
+	 * behaviour.
+	 */
+	if (!local_fs_has_sane_mmap(self, variant)) {
+		TH_LOG("local filesystem does not support sane merging skipping merge test");
+		return;
+	}
+
+	/* Map a fresh VMA between the two split VMAs. */
+	ptr2 = mmap_(self, variant, &ptr[4 * page_size], page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 4 * page_size);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Check the procmap to ensure that this VMA merged with the adjacent
+	 * two. The guard region flag is 'sticky' so should not preclude
+	 * merging.
+	 */
+	ASSERT_EQ(open_self_procmap(&procmap), 0);
+	ASSERT_TRUE(find_vma_procmap(&procmap, ptr));
+	ASSERT_EQ(procmap.query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap.query.vma_end, (unsigned long)ptr + 10 * page_size);
+	ASSERT_EQ(close_procmap(&procmap), 0);
+	/* And, of course, this VMA should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index e33cda301dad..605cb58ea5c3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,11 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool check_vmflag_guard(void *addr)
+{
+	return check_vmflag(addr, "gu");
+}
+
 bool softdirty_supported(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 26c30fdc0241..a8abdf414d46 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -98,6 +98,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
 bool check_vmflag_pfnmap(void *addr);
+bool check_vmflag_guard(void *addr);
 int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
-- 
2.51.0


