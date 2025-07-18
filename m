Return-Path: <linux-fsdevel+bounces-55418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E31B0A0D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21FB5A6DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A129E119;
	Fri, 18 Jul 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MdO4x5QC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YgA2jCrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DE79CD;
	Fri, 18 Jul 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835312; cv=fail; b=fjq6F8JvZTJCGIDu2wvsqkDIfD0gZDAF1yF9oyAhoS8xlTkizrIVjI0Y9R24v9icXQHJOvzMXHZha2QUG+cJoH0apJuMpIVS7jjp+DFMo41i70/ngB9z8yTNAN2VIxA+vuU/e3E20HeG8q+XZ1FjTSCegzeY87BizlpkrweENuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835312; c=relaxed/simple;
	bh=k44LgwGiJYcAaZvwoAOSh/6TBhqEgP5xNsuqmV1V+Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbriVq0IlzbPf43j3WWNDjsmSIH7pkPmzjuczZc+I6jV2c9mNJbqN309gZt/esnvYtZ8X/FKBkwbCVYA8bnK/C5J2tV+GP6I35cvCYxXNF3U4BNlpy9GxEI0/KIogtkfhqupfeXkXHnzsiSDFOezNd0m+IcR/wEzZyy+ASBUaLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MdO4x5QC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YgA2jCrQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fgPi022854;
	Fri, 18 Jul 2025 10:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oXhln8PObnl1zreY0S
	3Dze7FF9fLf3SovbnLjYZAvko=; b=MdO4x5QCE8VLEeqibwwawg0oZHqpK7PaqQ
	InN4ST8nwY3nHOI3J5Oq6A0Ls8WAFIffBcxRaQIuXVK74m1ic2jnRkvQIYeUtTu9
	eV2xz6cBnzCFO8D6Jbke8N2BuThrLAdj5ZdWKzoynEJtofn9Fe/WJJMHDPcK7a3R
	vu1qsbuhFRBmeuAXGiYzcfroPihMzMws+5iBgcnjtmvlliGN2cJw9uZ0CO5zqKwa
	46O+HRnkkhSkL1Eu1mE+jGpmTKEzyzVrvkDJZ6fSsvpdSEFB55OGOx+hHbN1VTBE
	RROf+5rJ3qDA5ZhFt01KD48pnmDvtm900av1COJ3OA3Gs45NZeqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx850pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:41:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I90EZP039600;
	Fri, 18 Jul 2025 10:41:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dyc7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlHm/4RswFZarGgEMySvyvNBlRRcloBg1PcSbAdvPL9Eji9Bmx7+/jdwvJZnyhIZkxOGp+umdCEy7qthWtkUb2/PAi4JZQfT2zXQtPNidO82saSjhiF7nMpuLfYU5PUSDTLn1PKHhmpOpj1Mk0OyknkH4IVmAm78iVE3lx+Upa6mpGSGOnSD/KRAfsm0KeL4BDBMQ0LATkxuuMQbPOmRRURMIqjH6KZVVLV1gu/C8keQBUEK0E83wHT55AhBbBANTxJTzJeczTw1r3BCwDu9R6XJvoH79dtbrDRm2YIyvHjothBQPOdn0pCri+btzCIY/a7MaUoq1HSbh5p3KTf6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXhln8PObnl1zreY0S3Dze7FF9fLf3SovbnLjYZAvko=;
 b=DRPOyUfqbZkanTQiyGsRCRT3ApOSX4HpNud4uoFjJvQJefhI/UDPcTFa2W9/MucFkvDbnlDVeDjQX9Rg0DvVgmInabFxBRRRZVxUiJ3K/sIrrK5Ggx/t1QutNqGiuLtDJPW2jD+mz975f7NV7RILM5EvKq4PWf7EOrJO0uPJ28imG/0+lbu2+mE9AAJmQtpHqCdTvE41sSAXcjWKmJFRZU89TBWa/aJWA5aP6Xf5oubE7Dx/+xitqALSEQ0oNgvM+ZzHMsE301s+m9bP9d/oDNzlxBX69aU3eGDo52G9khLj0QX4z466Rnl2WUC/UTw0zUhG16Bkgqq2dHBJVYJivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXhln8PObnl1zreY0S3Dze7FF9fLf3SovbnLjYZAvko=;
 b=YgA2jCrQW8Hay77fGZJiiiniIavf6i5UsN8/IrCFgK49o+wRiV9UsCqWOzbdUS3qDxNg5kLtTzVCwPoAGvC9RYMS/HSnXBAQvSKqICF8FYFU7049Qb2KCTMavmRRg3JIcGoc2uHEJbZtNLSDIkKFg4d83Ik3BsVOVG8zjnxfA/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 10:41:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:41:10 +0000
Date: Fri, 18 Jul 2025 11:41:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <9184274d-2ae8-4949-a864-79693308bf56@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-6-david@redhat.com>
 <46c9a90c-46b8-4136-9890-b9b2b97ee1bb@lucifer.local>
 <7701f2e8-ae17-4367-b260-925d1d3cd4df@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7701f2e8-ae17-4367-b260-925d1d3cd4df@redhat.com>
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e738a3-3429-45c3-1b09-08ddc5e79bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/or4S7xFX5Hwy1+fn5H7MStXBOn4w0Nj1bFGt1GVqG6wxL3VLbaYzZ8oQNwe?=
 =?us-ascii?Q?cMc3bfgwRu323UNWpN+LZHgSvk5XygUTkb6yXFCsM84tue8Cf+vgDuHDU46Q?=
 =?us-ascii?Q?iAC3RIGrkGvZPQ2nv8ixIEym5mIgZ62VqwdoXFPlUN2OpD6evyGSG2dVoWPR?=
 =?us-ascii?Q?EWtoAecOhaqy+hf/A5OOJ9Xe9xGW10iiq5yPBhnjVOFpsnZClF5h7B6C1ORS?=
 =?us-ascii?Q?GGiMXGQ+w2Q50MeXRXIAr/n2n3i3mXArFRi4kyg5cku+PWNlHmkp5/2BacU1?=
 =?us-ascii?Q?mXqe0w4FraHtUasqhE1AFRl7cqxJttKuGpO6IX33D7orwinfJwbaIKdqLE1x?=
 =?us-ascii?Q?2P5r5nUzrROZobmNix48B3LnBAUZ8vrpz4ixwhYQKh9AKxsbNUJHoDnV20pK?=
 =?us-ascii?Q?U+dgJzxpcC5qYRxz4CRP2u7J5fkTSvodibZUCaqMRrP5OsB/11uG3d3VM9bJ?=
 =?us-ascii?Q?n2ZRDi+qnMR3KByz1Ipdw+jVmC6809c7FoMuKSBfonCiqfOYDy0H4s0P9FoY?=
 =?us-ascii?Q?VhinZ6lXsI/uKaCOye4pOBa/y7aMVajWpvYe6qR699d9mFjlcxkpjvwvnR6f?=
 =?us-ascii?Q?p0yriwCPLRGqWEIn0alfS8vUaIRDDeu2+iI58HFNUJFq678RTV8ORD6gIpvy?=
 =?us-ascii?Q?NnP2EO9yPAzhSRmuETK+VsS8+WB6I8vHBto6In2LmVkfUcTkJnLAKQHCscTG?=
 =?us-ascii?Q?hNp+T5E7ZTWifDcn1D06LhBGZuz/1uYMz1z/ZIp5MZRyxOOj4gddlu6iP9tD?=
 =?us-ascii?Q?u3t3gCr6MqQPUPk7m1oKiVnRv6DtnluPF8Lf98WA9ttaZdoWkfiHlC4x+vvI?=
 =?us-ascii?Q?JOEp6HwOaVR0YHak+OmL2F7xH7pHEZWpqCKatCZDZgqLJeVTmW333YIFLWX6?=
 =?us-ascii?Q?+n3rliRS6fdHrNDfu+U2wD3UjnyvhHRNT6hAnZFcwXRahOm7+kND0RyDdTyy?=
 =?us-ascii?Q?pd0mAaX3YpfgJsb5uREUywtNIzBl+xNVsCD4zxTqoTFg7VvN5kKPoJr8EiMO?=
 =?us-ascii?Q?yHthVzxcaR1M+OtaOVwDfgxBgI4/C2FJQDRfKhJNZ1oLmS61Wg2ok4arI/Nc?=
 =?us-ascii?Q?EPGD3o6Y4uov9FdCg8QhpP3P5ZlnmCYeN1V3gXk3z69b9yjhY+JxveaXtb65?=
 =?us-ascii?Q?vKADXaWql0dGigVN+UcBhYFFXJHih1xVCJTY9t6lY3JVntBo6eqRqqKtq2aC?=
 =?us-ascii?Q?WYjmhkfzKbmsr/nxqwyX1EBWR4Jmoth5WtMgFV4T9M1eFccf0iJG5WWDbZBY?=
 =?us-ascii?Q?uNdHYEiGJYjKJZT4XIiIzKUQtUPZgANhcj2Fhs2nIskLp4HLg2kKCK/RhEMC?=
 =?us-ascii?Q?4jA9EIZLElJVKZqDKP7yVwRteTWiZ0fYLNnguMptsaePNUXckAg75dbsMfzs?=
 =?us-ascii?Q?wXKH+q7OrAA8c90SgjPY/qMOWp8w1/SnTlFVFH+0vA3HJ09DwvtJNehlyJ5v?=
 =?us-ascii?Q?fPTbw17oe5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFKxd7cqWP8FwmmhsfvGpge7IC7UH3d/QgIA1NExZcD/ceNi9EcmS0LWCKoN?=
 =?us-ascii?Q?AU/8NiyofhGzEtVLoZhFiWd8sHG9BOPlIyjnfvavS68A3h5nVpxnSD/JdX3v?=
 =?us-ascii?Q?YrlwGWdoWkftJuktKZM7n9YLaqp7+3AW7mQ1UKxusmNE8nvcJoGI8Ck79aSO?=
 =?us-ascii?Q?g4ynEn/3ly5btd6T7wIkEwW/RzbGWDNzZMn+VDTP6U388LNRQJQ5q/v0S+Yd?=
 =?us-ascii?Q?MUZ8qG/0INxKyKM1TzCiINE7TH92PMnnpqYAvt4u+l0DdDu7uB2800NZ6WNw?=
 =?us-ascii?Q?nvS2dugbGxYuX6CCA22rznaebjwz9MYybBcNRYuZuj5FOIv38MkpMyZWAIg3?=
 =?us-ascii?Q?616IQC4tk+ztqw/oYhQrW9h3ceo+3YJZqic6MYV4NKXEZ2zSHWIUiFuBf3LT?=
 =?us-ascii?Q?IhpQN9jSOHgJP6ml7mBstCAeg3ntarhBzxUDCJn00vmMvXiLhg/TCntakYQH?=
 =?us-ascii?Q?YLSN+2c8ZD8a+qk16ogQtaktxQKJ91/kwX/VrT8JWbAVDjDIVrJe7lkFGG8s?=
 =?us-ascii?Q?frPlACTxzBoRwqGheTtNZ1+eyiaYwFl1PQ2XE3m0wIyZARUdLnJJvG30h60R?=
 =?us-ascii?Q?POasuxLwNS7H0m/OJmfEpBQjxmJ9aJ6Ms3E8Kk3yATPLdC+/JDfWR3q1DDJ7?=
 =?us-ascii?Q?PBrjLp/VXRFCRWQoGW6NE39Dmoce6rnWtB26dye+b5b/G6YjdqRRr3oEqiqP?=
 =?us-ascii?Q?DcyKIAe+rwKZr7Fsyyiiw+j2dlwuT2Fb/tVLWhlt9H3lcZAup5Wrdt/9zLB7?=
 =?us-ascii?Q?mpuIPbVOeCgnYKQqHU8adze+dUs6AQ1WI70xKGK/SS+Nn76Bz8VVmJTOaIvJ?=
 =?us-ascii?Q?0eOhqzHGnFgvlSLWT752h4fHefW9wBLXBJToW592iOg3EBJPn0NZKhVEwYOm?=
 =?us-ascii?Q?2TcXoGHrgWXm/ZxlC19WSwXrXGv6xktYpnGZLRDnlsUcP6BYAzYUPs+/UgFS?=
 =?us-ascii?Q?3KBRxU2BQ8jAtDDAWEA+VzIET1rp9NijOjXRJJifpzPhWvPXMouRGhQqkx72?=
 =?us-ascii?Q?REjyssCCXK1Hnd2vfdn6Ata5RQwfxjKeTkQX+jFHK6Pi6RS+U1rutoul7vms?=
 =?us-ascii?Q?lHeTlPYeTZsPMH+iZqTBxWLerHtKFA0TAs3ITgTB+VKHL2Qeng8MdKyGnfMC?=
 =?us-ascii?Q?6U7nj64q/IDwkp/Zj/ZzQFEwUt8OoaCQM653VPiQKls22Z6ALsZefnz5Bj9n?=
 =?us-ascii?Q?UFCOM0ZyTnpLsPCi850XafmF0wAhmR3QXQHvz674VOb5IZ77o+0JlFBXi69Y?=
 =?us-ascii?Q?fC/S+R6m94XM9NvZ+F76iQFeXdh63/Aho0b/+mBVKDQJqgDn4E3x73iJzaYQ?=
 =?us-ascii?Q?l0lwP4qLkaatMvgdvsZlVhLhH6hyJkcwnfzPy2yUc+CxTeiK0ami4hs/L2BH?=
 =?us-ascii?Q?xMWwTzdHCUouziCuK7LjXzivJ+cU2WbFV6nrh4uyg8OebZ9Mt75f5e0OA8+c?=
 =?us-ascii?Q?gRsZ3ZdAelma+u7hzpivhMAtmnXs1n7RkjJxfqVkus8MCCqOtFM6E9QdaA64?=
 =?us-ascii?Q?Q7Msw1GR5PzRtBXRhTtzC4WcNHfPVcrN3JzxphSlwxGq3CpETiOzbYx2OmXo?=
 =?us-ascii?Q?oACZKuFJQce+udUonyqhQyfi3tV6DcJ+AFMV4wmjxU6ZL49BT//QjOVg1yhL?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ra7tGYyblGcrr7fvgF/pL49Jll2TRWQt0B5lf20uTKSWpi+xm8eIJHspvmO5BXDGmTYuiWWmZN50UO3/H+VJXohwdFQAuKyabHPp8hH4g4hQFVc1w+0uUIIhzTeEQVgxhkxV5C1bUW83iDnVrrlFF7dOucOiAaZyES4jNXHU/T2fl0i0RpLKRuILF4PTFg+0R2Ny/AaSq68PPha87kdd29EODpSHq2e5oY5w8cLl7AYjv5Li2h3JO0N9IB2rK+hR2BM5ngTQD2ZAFXdQ2wkgl3p3HX6Clh+auJYdHGO0P4G8IqCtmgDKnxU0JvapgBxA5HscXgZywBpKCpoa9tdG0DdwBGDH+fErEAswmIwanXqQrdWLOaAYhP6z/HU+WqTBccogfr4v01gDWR0ez1ftUUdsaPVUvdYOUKWawf3qweQG/MXpzaSmmK37WSTQDbYWTzBtEuThFfJa0alAyorBUxIwNIuO1hVz3yTB5twvRaBQbW4ixC6l4piyeSBLrCthj5KwCkSGcowy8NwZJ+AX+ub4Si8OdAllOrE5w4d4TEpsfJJ7EUQbVDuig1Vlv6qXoF6EbzQGacK8yn9w7N6dz1MoN3SkgJyr+X0w+F31DJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e738a3-3429-45c3-1b09-08ddc5e79bec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:41:10.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7ivQ/eKuMX4gOGvNRgXM5uZEHk/Z1KLmaeGuJzYDdOasR5vDuERVeTp383oJtBxwSrvWbMaU/4N8IewH7QpnERtkP/0GkYRhI3AHNodEyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180083
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687a24ca b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NB37xtsDAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=jMqo8YrOKwJ3oZfz4ZgA:9 a=CjuIK1q_8ugA:10 a=IlkzfGtsIyjWS4YjqO81:22 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: uTwbEn2C7EnIwAZc5ZImBZgS8Td-WzQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4MyBTYWx0ZWRfXy4VOs2rUxHdH 5m/CV413sp67l8PcqDpt+7b9xNAfLHLIyhCifxFCIl1AHZnjfC1/DHR3OrODdRxumMQ7Bnb4GRL oFXr+Vpaqcw8YgXIYtYg2f2hP/e4Ue7JE/wEo8COcySdVP6X12myjzu1OkvUSs/wKP8ziX0j+mq
 1H9teGgJnXBDblkYs/hFaGuoxbjSmOMUoDPqHzz3NS5CkV5BY24xA9XCO59tP0li5cTRwQKtXEW GSDqn7hsj0L+DfW1Q8jwIxBLcw95kWYwhPdaFeZ+dZYM+9LbvSO4Ha8wkYjlF9+ePYtS3e188/M OH6Chpf9+/7vsOd6dcdmHBUo/rRiQhwBqGK6QXDKaLmgItgJ7AtvyWBFuOwQ5DLZU20kPZz6cim
 HK0upnzh1dIV9xa9Ab0kOvanKkE5VzSes7UapuHHYPCv4Wm6MA0F2uZb9AkE6qVHr+9z0tWy
X-Proofpoint-GUID: uTwbEn2C7EnIwAZc5ZImBZgS8Td-WzQP

On Thu, Jul 17, 2025 at 10:31:28PM +0200, David Hildenbrand wrote:
> On 17.07.25 20:29, Lorenzo Stoakes wrote:
> > On Thu, Jul 17, 2025 at 01:52:08PM +0200, David Hildenbrand wrote:
> > > The huge zero folio is refcounted (+mapcounted -- is that a word?)
> > > differently than "normal" folios, similarly (but different) to the ordinary
> > > shared zeropage.
> >
> > Yeah, I sort of wonder if we shouldn't just _not_ do any of that with zero
> > pages?
>
> I wish we could get rid of the weird refcounting of the huge zero folio and
> get rid of the shrinker. But as long as the shrinker exists, I'm afraid that
> weird per-process refcounting must stay.

Does this change of yours cause any issue with it? I mean now nothing can grab
this page using vm_normal_page_pmd(), so it won't be able to manipulate
refcounts.

Does this impact the shrink stuff at all? Haven't traced it all through.

>
> >
> > But for some reason the huge zero page wants to exist or not exist based on
> > usage for one. Which is stupid to me.
>
> Yes, I will try at some point (once we have the static huge zero folio) to
> remove the shrinker part and make it always static. Well, at least for
> reasonable architectures.

Yes, this seems the correct way to move forward.

And we need to get rid of (or neuter) the 'unreasonable' architectures...

>
> >
> > >
> > > For this reason, we special-case these pages in
> > > vm_normal_page*/vm_normal_folio*, and only allow selected callers to
> > > still use them (e.g., GUP can still take a reference on them).
> > >
> > > vm_normal_page_pmd() already filters out the huge zero folio. However,
> > > so far we are not marking it as special like we do with the ordinary
> > > shared zeropage. Let's mark it as special, so we can further refactor
> > > vm_normal_page_pmd() and vm_normal_page().
> > >
> > > While at it, update the doc regarding the shared zero folios.
> >
> > Hmm I wonder how this will interact with the static PMD series at [0]?
>
> No, it shouldn't.

I'm always nervous about these kinds of things :)

I'm assuming the reference/map counting will still work properly with the static
page?

I think I raised that in that series :P

>
> >
> > I wonder if more use of that might result in some weirdness with refcounting
> > etc.?
>
> I don't think so.

Good :>)

>
> >
> > Also, that series was (though I reviewed against it) moving stuff that
> > references the huge zero folio out of there, but also generally allows
> > access and mapping of this folio via largest_zero_folio() so not only via
> > insert_pmd().
> >
> > So we're going to end up with mappings of this that are not marked special
> > that are potentially going to have refcount/mapcount manipulation that
> > contradict what you're doing here perhaps?
>
> I don't think so. It's just like having the existing static (small) shared
> zeropage where the same rules about refcounting+mapcounting apply.

It feels like all this is a mess... am I missing something that would make it
all make sense?

It's not sane to disappear zero pages based on not-usage in 2025. Sorry if that
little RAM hurts you, use a microcontroller... after which it doesn't really
mean anything to have ref/map counts...

>
> >
> > [0]: https://lore.kernel.org/all/20250707142319.319642-1-kernel@pankajraghav.com/
> >
> > >
> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > I looked thorugh places that use vm_normal_page_pm() (other than decl of
> > function):
> >
> > fs/proc/task_mmu.c - seems to handle NULL page correctly + still undertsands zero page
> > mm/pagewalk.c - correctly handles NULL page + huge zero page
> > mm/huge_memory.c - can_change_pmd_writable() correctly returns false.
> >
> > And all seems to work wtih this change.
> >
> > Overall, other than concerns above + nits below LGTM, we should treat all
> > the zero folios the same in this regard, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!

No problem! Thanks for the cleanups, these are great...

>
> >
> > > ---
> > >   mm/huge_memory.c |  5 ++++-
> > >   mm/memory.c      | 14 +++++++++-----
> > >   2 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index db08c37b87077..3f9a27812a590 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -1320,6 +1320,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
> > >   {
> > >   	pmd_t entry;
> > >   	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
> > > +	entry = pmd_mkspecial(entry);
> > >   	pgtable_trans_huge_deposit(mm, pmd, pgtable);
> > >   	set_pmd_at(mm, haddr, pmd, entry);
> > >   	mm_inc_nr_ptes(mm);
> > > @@ -1429,7 +1430,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> > >   	if (fop.is_folio) {
> > >   		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
> > >
> > > -		if (!is_huge_zero_folio(fop.folio)) {
> > > +		if (is_huge_zero_folio(fop.folio)) {
> > > +			entry = pmd_mkspecial(entry);
> > > +		} else {
> > >   			folio_get(fop.folio);
> > >   			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
> > >   			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 92fd18a5d8d1f..173eb6267e0ac 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -537,7 +537,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > >    *
> > >    * "Special" mappings do not wish to be associated with a "struct page" (either
> > >    * it doesn't exist, or it exists but they don't want to touch it). In this
> > > - * case, NULL is returned here. "Normal" mappings do have a struct page.
> > > + * case, NULL is returned here. "Normal" mappings do have a struct page and
> > > + * are ordinarily refcounted.
> > > + *
> > > + * Page mappings of the shared zero folios are always considered "special", as
> > > + * they are not ordinarily refcounted. However, selected page table walkers
> > > + * (such as GUP) can still identify these mappings and work with the
> > > + * underlying "struct page".
> >
> > I feel like we need more detail or something more explicit about what 'not
> > ordinary' refcounting constitutes. This is a bit vague.
>
> Hm, I am not sure this is the correct place to document that. But let me see
> if I can come up with something reasonable
>
> (like, the refcount and mapcount of these folios is never adjusted when
> mapping them into page tables)

I think having _something_ is good even if perhaps not ideally situated... :)

>
> >
> > >    *
> > >    * There are 2 broad cases. Firstly, an architecture may define a pte_special()
> > >    * pte bit, in which case this function is trivial. Secondly, an architecture
> > > @@ -567,9 +573,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > >    *
> > >    * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
> > >    * page" backing, however the difference is that _all_ pages with a struct
> > > - * page (that is, those where pfn_valid is true) are refcounted and considered
> > > - * normal pages by the VM. The only exception are zeropages, which are
> > > - * *never* refcounted.
> > > + * page (that is, those where pfn_valid is true, except the shared zero
> > > + * folios) are refcounted and considered normal pages by the VM.
> > >    *
> > >    * The disadvantage is that pages are refcounted (which can be slower and
> > >    * simply not an option for some PFNMAP users). The advantage is that we
> > > @@ -649,7 +654,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> >
> > You know I"m semi-ashamed to admit I didn't even know this function
> > exists. But yikes that we have a separate function like this just for PMDs.
>
> It's a bit new-ish :)

OK I feel less bad about it then... -ish ;)

>
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

