Return-Path: <linux-fsdevel+bounces-55265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEDB090CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2947E1C41533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF02F9485;
	Thu, 17 Jul 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JrIIkCp+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uvVlB4oN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE933208;
	Thu, 17 Jul 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767016; cv=fail; b=qCNgBlgSv/eOR5Wzig44JpesDHceM/oXSHyUGhwY76eOLgh5rgTRKNPyukT78SliLMBklHB2zR22nVE2uETnb8rtbY2mjv90KsLKFXHVwz9wh4Kj4Y9fpObGxUzJF9Aok0Iq/gHC9At36UV8sPRIcEdmVsVlGEl2Ji+86NEASf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767016; c=relaxed/simple;
	bh=NTviHWPTcjkorHaSLcF+P8jS3nHvEKEwHhq6izkRg4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TjcTGKpYKyvtJApLmz8VWC7XRLJa4bgePp6EbIZ0faj2tRSi2ys5HnSqtsuI94gyYp6yCFQvwHY71bFc1NfxynuiSm/RKEIPLC++ehu3tGO4v4kD8DtH+Wf7UTbyrFEY4EtNnLWsTbK2StMf4q79CMGeq5Ka3NGoemaHZKZdKsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JrIIkCp+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uvVlB4oN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFfuUk005146;
	Thu, 17 Jul 2025 15:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DX2UPNmtHAL4dVlkC3
	9u9XdvImx9yNnvDis/ZnXMMX0=; b=JrIIkCp+DozC9iU7Cwvo3QTrTqAwjDsjDv
	fRnjRjzz4hi9FHr4BFd6yGtkj7UWg1tJn+fStfPVeuzd0RNBaeQSAQNxdxrcstTL
	qgtw9exPuZ80UyZhni/wwiN03pBK2iDWV9QthK0vZWGt0/NLB32G3v1PqLYgBLDx
	jjJlxWh2JVWHKohxugCQo80A0R5qkNamcaRmBEmR/nGZnDhmXfdi9rxdwR4AXdmv
	xSdFY5m/Tt2tjNOtN2VWV2HZDLSYoPpRRh9Dv41aW8ZqakbpDhc5DD+OXZ235nMO
	PQWKYY1z6S20EI7n6VeLjY60G4SSWeQBb3iU1cwO20xU0ZJ79lgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr139md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:42:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HEAi6E024016;
	Thu, 17 Jul 2025 15:42:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cv3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkZnipgcpMvcquyuUZW5RXIVq4peQ0/kDC36giyxsLEbFU7w/UWFnAqymdzFzKlvMgzg0x/AVkw4uNiWxk3mfTgXN1aFlaOvOohC1pNNCpuxl5r8WBrPN/yWooS04ouMFjZEQe2q6caPI85kP3YY+qo0vSAkbO7iaLh7R6VJaAQexl3Sb6GxtQsmplhHWuYRfadP/JJfBAwxB6Jf3LXdK2eh9nSvxxTWPjYbGo1zen1ybRF4qMNfXzJ937OsclbVfkxWdxtnUgbAQCdbjiOUS7gm9AoCJC+Nkwe4mEr73QPkYixpKIwOdY1y8elJx73CxEMTyV8khr0YTXzvtbFTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX2UPNmtHAL4dVlkC39u9XdvImx9yNnvDis/ZnXMMX0=;
 b=mIOTPp9m3YdutKsl6eXzGXX/INeSlzDKIHVoxaNPGG404Gz83EeJBoOdOVLHY+MewZTBc9Qj2vqrSAKTaEHRtzSYjqmKqSnToSKmSEXIhpKG46tNDZabsjYtqDNkNLCOedEH3PgSogGgfVBpHy1Z99zQrXkkEr07NiQnOAf8uELX2VET8lxMNIKBULqoBfQxgqAoUFJRCGAop3oBpSOHB9po9/6RnZq18U/6fHT3mf1rA5jWIyCcmvnHT0qq9rgZk1+8aNsVIXdu57RgbG/hcUJg3GGMoBijwbnhtlWT2pgHnczCcRU5ZBXyAcNZpjFEQJED9+z5J/Rav7zZi8QnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX2UPNmtHAL4dVlkC39u9XdvImx9yNnvDis/ZnXMMX0=;
 b=uvVlB4oN7bhgSok6R9pspHXlFN57JLUbX3ft+KnPDU6Lb//0EI8DB5LB3/A0ywHak8ykTweFqf5x58oLmleJ0Y4eFwyxrkk3cfSDRaBWDKEPxV5VN9clfV9hM0Xd2L0rSJtggQhhuAZI5DsnoUN1V19FzPR9oAkfrU6tVNuXHW8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8323.namprd10.prod.outlook.com (2603:10b6:208:583::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:42:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:42:38 +0000
Date: Thu, 17 Jul 2025 16:42:35 +0100
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
        Lance Yang <lance.yang@linux.dev>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 2/9] mm/huge_memory: move more common code into
 insert_pud()
Message-ID: <872b3bb6-7ea1-4a60-9436-b98d3c3231a4@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-3-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-3-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: d0beaa5c-ccfa-495e-23ff-08ddc5488ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K6ymgZmVZ+qSQ22Yf+Qq0fsuicRW/rZZg+SNskymMgtE1tgFYzwPfyXqHYNC?=
 =?us-ascii?Q?DImwlixDOLvmsJL0eo4S1H42wUSw2WxcgM575LKqZT9X19UPYlqZqHRYRFIU?=
 =?us-ascii?Q?ao84mgPD2jostdKgvgDxLWHWginFanris29rjh9jBUjeVlA5fRS449/HsevG?=
 =?us-ascii?Q?ZJeErZn4Yflj8GwR1JnV7CjBthFOohjnJ+p0tZLastYToWiP7fx+V8uC992O?=
 =?us-ascii?Q?GB/W0HoeryJwEKhxNARgiMWE4fZ7cr7e/BKgNRY3saBOtW11uHYwJOlK+8Qy?=
 =?us-ascii?Q?PVPw4NQiYIiazVOOmsOCn4yl7VXLDnOrF6NoBRn3/O57fBT9zQTn49gi6sHS?=
 =?us-ascii?Q?8j3R2O/CoEsbxZ3DRQ6dGaue3k05+l53SPUUrKupAY6Nch/0owhGhY21gC4V?=
 =?us-ascii?Q?c6RahAwOvtDfN/imBUyPlWyss/tnlI9iyPf97ZbIp4ZiDcn3Qrb77/jfEJxy?=
 =?us-ascii?Q?N7ctOWx5Smt7SWwmKqqHxNryj4Hdn7l4wr8RTWK7uzFgE8WQQk6Wgc6P1X5b?=
 =?us-ascii?Q?lOW6XqoocLyC3TMLlYkkjh15u7QNKliLo7GLo2sZzPUl3jjP/jP4tpr44ua8?=
 =?us-ascii?Q?UhlIS1iDylUse9V2oHGrbjPLeXH9tLJArtDXPV9p3Deq8bj7WifIPFipmeDs?=
 =?us-ascii?Q?JiuUjjCuLB5rPpItcpYEHdzP4dbypPnKM5kX/NjcsL55tnmnDlWYo6Sa1d4t?=
 =?us-ascii?Q?FTBSuUtOEeO65vOqUvKuousllxA+diXzx9yEIGA5Tqfwz5pd1WQ8Vnj4sXSy?=
 =?us-ascii?Q?Z0tpkK7ixFY/STfR+X2ZgdrDfHxkygSvcvscugz4laNv0rQx2MwrTH2+zEdy?=
 =?us-ascii?Q?Dwd307DLrrHWmP98nKD/PLcIJ2/PRnYJ8SmUxkN/CJffk0OXyZvYvyauUIzR?=
 =?us-ascii?Q?3O1nDCqzSeLaOfUVMtFGkdnPb8Y8YMTacDPtd7wDsBm4AKSrEekcHGzyfQmw?=
 =?us-ascii?Q?D7kg3eBXiYL/7I31E1xFZd2f3TWkSUiKpz1kerztlrU/cnem82ZUhA00OHgR?=
 =?us-ascii?Q?afoX1mg2uPO9irrP47jx3krwWxhu8bkAd7P+U0EGza7wZw7ig6BD9IwwsVDz?=
 =?us-ascii?Q?azI5DAZSuhdN+iZP7p/PAowETZlQZmQ9SgJ+vNCaEw3RYrUJwzuYxlXMA6+q?=
 =?us-ascii?Q?nbB4xxL8K2AKtafbaw1Zi2FUir4vuvQAnh/Z+C55UxKUzYHwMOZ/EmL5impC?=
 =?us-ascii?Q?RyAgJgX5OagIndVMM1poZlzO3sRuGmo5mtAxkEN5e0QEkJ0f38+UOE+xNFJU?=
 =?us-ascii?Q?VSPPIPTEJsWvHA5fJRdxFmWLca/k/XNFlRv5a1G0AHOTEQ74f+CIAty/Bb3U?=
 =?us-ascii?Q?gbbew//HuieRzDs7ccitRb/6kZP5pDVK4uOptkVJt8ZnjM/qDY/uaYOVS7Pf?=
 =?us-ascii?Q?sxQAHSzmczBAwWL1MCzfguMNG7Z/SYF+6aeSgnWSAGGkxmbtHakQX5oixEAN?=
 =?us-ascii?Q?JTwC/bELyGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOR1uKOPOp2YBRUne7dO3kOli9gGpRoa6sUuAY4F9x3QO5PG7XAemJ9orCrT?=
 =?us-ascii?Q?xsnFJZvcWruCYEYYnzK9XvR1AL+rtUTVWpDTeklO6UCr3uj3e+MuVJI0lxZH?=
 =?us-ascii?Q?vtiuMSgTTPLAOVS+RqW3Vdnt3G6nuXoYOeRzyiTvA18zZlREW5ctBMtp9s4y?=
 =?us-ascii?Q?Eugq8sxkV20c7RURy9jMneGxWdfPZFmqBhSaDFTYXavsbXINN5hfg9SwO7c6?=
 =?us-ascii?Q?YV0J0+oxC9hXJtMcFr+6Zdrqb6dR64YYrjFgVlys2N3hxw+Dh9xSoVv+e6/u?=
 =?us-ascii?Q?oG3LQWHug6HYRw/ERNvu8OQTuTYfMFHXakXbNFWnHSlhevjdYKo3IQg8Aafe?=
 =?us-ascii?Q?bpIQCihMXmENwstpY5gr7IBTa15/gjxHlLlHUpsiNBjya19ResSiJJ3G4lCn?=
 =?us-ascii?Q?CHf+tV1gKoDJ6ugOc2xPOcpI/NpvHk6ZsOiApERjmXYPMtX4rOBcuZ/Y/xoP?=
 =?us-ascii?Q?VX6DMLzIOCLPXCg6NQ1WlDpePxqodnggylPiY6WrUX4BIxrycqIGBWsKiZ4M?=
 =?us-ascii?Q?wCtwOot4tqjprEEY926YzNrf+x1Go+9V6FzyKsrhmCFtP2qh0k8RrXc0b+fH?=
 =?us-ascii?Q?ILDGzvukrB1ErFzcY+Yp7IVkymjm+VW9nXsDZhm+K6nBtei6flK3kr3CbVHw?=
 =?us-ascii?Q?lh14MMsIUlMunkugDWTBGVDW5L2tiQNjcdozoqiG8XE+Qi0+MqngpTCh5eGl?=
 =?us-ascii?Q?NMe3O75r9mYVbAXpgz5SmhaK2cHTBIYrg2B3zhetfuU/OAUn4YsbCL0FcGEB?=
 =?us-ascii?Q?3yxGnI75L6ddc6uUbQA97e+rtFmKbdVKT49YdzQXifuyT/fBMRbpubB45gjn?=
 =?us-ascii?Q?1pp4j6+/oOVQkGAoG1rNc33+MD1Of7UYeenOgT7N5n65mt4wFB0PAoyfW5CA?=
 =?us-ascii?Q?dOs7I+DZmhvGxpw4lFR/wG7qdr72lkxtieZvJmb1iZ0QruiD2He7OBVRKPqJ?=
 =?us-ascii?Q?3QYgDFMPxhrge7eXeY8SWSBX6beIGmTH3QaukiY4u9hzDubebtWsVhxeJae0?=
 =?us-ascii?Q?TzgSJKk4uqD0pqNXe0gL7z1MYEDNzUYk9iWfSWRL0vxEgMJLzarZdGlo62cE?=
 =?us-ascii?Q?n1AUEA/pJkoL4rbr4U2Kqf4O2Wc5lluCPu2qcyJ8gQ8foxBKXwi4vhMAh+Ry?=
 =?us-ascii?Q?j9NEY029ZPuT+mq0jaSySqI3pbkzsxb+eXeqN/QjbP2VTfTdBWkSznW4U4lx?=
 =?us-ascii?Q?GQrj4UahQ5C3gvjT1dxFGUeK4iBxoCFYyoaKyrPde5wIfNdhQkDhD4p+CRcK?=
 =?us-ascii?Q?UkrPyEgDpMSB29GigA3l04msNmqSUaBfGl3dXwZdkwP4iJm1XHdQQhcsCjBg?=
 =?us-ascii?Q?ug4OsIjfeIRNEFsgNX+9FIKCFSE6Ex/Zhc4pQElTuXruK5jH152E++QhR/C9?=
 =?us-ascii?Q?FOSteWlvr7CjNPnaNw2uo12SbXwI+KKlCcF+DvhCuM2hREgUeilvCRwcW/xK?=
 =?us-ascii?Q?cqP+OndDgIKF8bwOdCpoY5NtRhq6WEeaoRO6wgkuKuDB04o2e33J999Vlofv?=
 =?us-ascii?Q?6WMTKGS77X5Z3yI6h7YJmbkc41a0YAHKcAGXtL+krvlMQ5YLwR9wbhYt3Xqd?=
 =?us-ascii?Q?L7IOfrfNMR1DAeLuCDhnvp9ZIKT3ci+bIbLjnp0L4JqZcFFUCpmFj0Z7mB3K?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n+RbbKz3We/+znbNtdj1jaroZgdewcRtbHRuJa5zDeH3Wu9Etd5w95nLEGZqB0z/S6a8HcoVec7y1LIF4bGRAFyvLrIHkACeWLGh4wsPejnPtX+Lj2PjIqHGMop7osWLi4mw9/BfKu4WQ1q+Wuj6X9XM0VuTN9AKogXPrZsv3bn21OTTUAb3KkfiNk5vnLpJzN5DI97LUk/irZQwPh+0NElfkOaNTQ6wRShRuOSWbV7DKxMCVsNBPQYUoUxl4zdUyuowrgf6MCXZr0wQV4t7+0Z+6SIgBmKzRHFx2OgcvFMKhesNS9AcCQjAjNAbF/DOvAvMwo34/YdlVxZW2HHLe7hH2P6+sEOE3j0M9w9lKsj3b7MLtjt53k4fuOYmPnnOMBBeB9yFSDFNfpL1M7Muh0YNLMbbkdJ55xbVA2Zvw6Km1LmM9u9W4t72F2u9hcWfuhdm6fDFEcBNO5tMH4niJ+ZgwakCdSd8pBaaixzQ6sl80jONh5migVjpJuVsRcWwbHvpgx2KEd9sfFWz3woq8Em2mnSd753Sq75OyiQQRbz0wHUTaiqzStVSyERF/Tp/f+LYnwvrflVrlOef1hOdBgPF+SKaSoj5GIMcCmz0DxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0beaa5c-ccfa-495e-23ff-08ddc5488ed4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:42:38.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhPwiscqNAw+A145CnPc+eRgmr0I74EfBd9zObDicfS5CeF+lC5LaqQdJYf2ORYFHdhgDEy3nOf/Hu9roR/iaW/N2XQQeaIC5sMInhs1bRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170137
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=687919f3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=zvnFcUP7Z4G_8pygN_IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4871as6lx46PWN6wqaBsXZ2KcYXssAYb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOCBTYWx0ZWRfX9NVX/2xk6b3F 1/xTGKibJuHCrKrwA+ClJGj1Nr7U493MsykfDKFlFBc4YxpPqotxtuh5vl6aDjsBgZ1FpDmn49H T7V7kSECXrnvETuAO588EOF8YqVsUtduK3F3ghlyunwz5ACjgbKpyL4XF3sD8eoPdoyD8PSK2g6
 FtzgSKrTCuHrmmMMhq5WfA5ElLp93sESK/ZPDIdm3kOG58eWytu7PZrX+6W8wnARQQlu7FaS97Z qla3Uh42TT7u8LlbB6S5lcJEt1Q+7MqPskoO89A/CC2vtXI6GRXcCAXG18LNlsOp7mSSuOyTvqi 6/x+8B1d0F3wM42eILHDKQ4CgbH1FCK/mHKoBA/cXRdMevOXk16xXl24/QvUCU/XyHlA40AW1Wo
 UTD3bNt1tNedDQ+dQNmfzZokWYeG2Yiy2b4fO+8DvZST8pGQI+bwYw9B6NAF3mkQCdcQJywD
X-Proofpoint-GUID: 4871as6lx46PWN6wqaBsXZ2KcYXssAYb

On Thu, Jul 17, 2025 at 01:52:05PM +0200, David Hildenbrand wrote:
> Let's clean it all further up.
>
> No functional change intended.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1178760d2eda4..849feacaf8064 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1518,25 +1518,30 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
>  	return pud;
>  }
>
> -static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
> +static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
>  		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	spinlock_t *ptl;
>  	pud_t entry;
>
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	ptl = pud_lock(mm, pud);
>  	if (!pud_none(*pud)) {
>  		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>  					  fop.pfn;
>
>  		if (write) {
>  			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
> -				return;
> +				goto out_unlock;
>  			entry = pud_mkyoung(*pud);
>  			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
>  			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
>  				update_mmu_cache_pud(vma, addr, pud);
>  		}
> -		return;
> +		goto out_unlock;
>  	}
>
>  	if (fop.is_folio) {
> @@ -1555,6 +1560,9 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  	set_pud_at(mm, addr, pud, entry);
>  	update_mmu_cache_pud(vma, addr, pud);
> +out_unlock:
> +	spin_unlock(ptl);
> +	return VM_FAULT_NOPAGE;
>  }
>
>  /**
> @@ -1576,7 +1584,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
>  	struct folio_or_pfn fop = {
>  		.pfn = pfn,
>  	};
> -	spinlock_t *ptl;
>
>  	/*
>  	 * If we had pud_special, we could avoid all these restrictions,
> @@ -1588,16 +1595,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
>  						(VM_PFNMAP|VM_MIXEDMAP));
>  	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
>
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
> -
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
>
> -	ptl = pud_lock(vma->vm_mm, vmf->pud);
> -	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
> -	spin_unlock(ptl);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
>
> @@ -1614,25 +1614,15 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address & PUD_MASK;
> -	pud_t *pud = vmf->pud;
> -	struct mm_struct *mm = vma->vm_mm;
>  	struct folio_or_pfn fop = {
>  		.folio = folio,
>  		.is_folio = true,
>  	};
> -	spinlock_t *ptl;
> -
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
>
>  	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
>  		return VM_FAULT_SIGBUS;
>
> -	ptl = pud_lock(mm, pud);
> -	insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
> -	spin_unlock(ptl);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> --
> 2.50.1
>

