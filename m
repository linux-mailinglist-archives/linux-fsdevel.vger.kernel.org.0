Return-Path: <linux-fsdevel+bounces-48196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28131AABE8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21FB3B9F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35801279913;
	Tue,  6 May 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sTjtuv2H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qlVezZcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5326E16F;
	Tue,  6 May 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522342; cv=fail; b=NtjvaFIaaXOVZrztNFHeEWUn2O+mDeNrIkmMmYbD4Y8AuABdISjc4ZI3usXOiOZ/VPx6l+29BTRF1KD4ydqRRksaRyIdrEoV6K2/MbptySvmKte+JWPrAi7uriJmjgMYVFaV/x0Dths3n63HAjxBWale/RqkpZFvL/HSbnZ8J84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522342; c=relaxed/simple;
	bh=9eT+lXdOnGGoGzrugdHnlM6/gxGf6vdsPRVIvBGiSt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okhjcXO5UuAWlYXA3Xa+GTRYlJNfML1pZqAvdktqhO1gKz5ktWax63dQPGL7/o1cVbsdy7hNorrDwlGna5cHDpZ9kCxgaXUyTX1R3oQx5Gif18qhLOWCFzfMUwjIARjWFGmnfePtjyLjwYQvJBLmQNDLsarNcuEDHyB0XElmMlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sTjtuv2H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qlVezZcG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468bajL027331;
	Tue, 6 May 2025 09:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=; b=
	sTjtuv2H0lk3GdcDtbIwMV6f8tuy1ox/zL3FgTcq707Dac7yB5TW60hjlgvX1KT9
	8AqABLO99Lq4kdb7nv0IO/8qzxnnpdecNW4AFC3RKD9bNoOy5WcAGk4CsdGmZGuG
	7L7+IlWVC0psKUDImD7kGw0lnFQVU+xYa8mdxc6so7y8KRujnSma/wOxwrulaEXs
	UoaSBpk+WhNUi4BQvFFguUIwkgvda+aMJBKdw7WJHcInpZR7hYAIKb0MshdZ8Cyw
	BTMHue3Fsfy2GLB73a++iRyQfNkVOgODcdf2TeySVHGxEdpeiRgt7LMlO1nvrMAF
	3Yb4+fK0qXEEFnWrmEzVUA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff2t02kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468G3bN036085;
	Tue, 6 May 2025 09:05:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rn1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9GIwuvpN5xB+9y+Zj9BFkC9xr3/rnfOAqsq2ByWJCBCJqq3zoIIje8VuKJkunzHZkla2L3U54VodCBorfhmtf0sOaQD96Mi/8VqlA01k0v8Jzob5nTop88Pc+1LZBY+SqlSHF1ZApEHK+0lV6pVNsogikGGP+kiwjzw/IbfPa7PNroCs/peS7NVsq4m/Rye6+GwVL5TkLE7aH7BBxn34O72C8+QR7+9mDrx7AAUrGmyLNJ8A10GE0FjooEdKdJNgumfJDniL8/3jUoXjIrdv7is3TMiahrHaTbFHyNmrWaQSfxMLrGjFHIc/HYoHfs/fO687093utPsU8KkSXFwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=TMrhqx+vTYbAjKqp0nN7vtg/Ezn15wXSxxfFhyvI0PIYZ2AwonWwv2OS73qyaXwtNe7Y8ea+2IR9+5amizYtvO26anU9xWX3Kdoz+XsJsEHmmb3jJABI/WpJdStF16Ebzn7qrHkNdCQMRzJ6YwlKozZi9PfPu7NlupZPo2IkbgkGLj3qk52GZ10sxZJXm2GDU4K3I4/UlMI+c886fuQ9qDeIaikcNQ4ZwvPnBns7/ReDVrNeE4Bo9WDDZc0LivlacvCGmNmmZA5101W+XpFtjZs2qhIOzevIOmwfod/P2rsulsLfBoGOQOCkyRegn6s00XvJKNgl9PUiV4zMCeMW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHPrOF330Ob5KselHNKq17d8XF2FSszAu7gGNAU1b2Y=;
 b=qlVezZcG1agiqeQ0WIwVt5zyZmdSiVNv4yOhrLZj7kiJ3lv8QQBr+whPuhoaelmBDMmle+rvLKgZxQHW0gIqgT3Yo2/bpkoxRGI3kZRVfghQNCF9L2dJKCEIcV5dI7BeCHh2l//hIjd31h5HFLA4wAXzjdioibGiZoqJCvmGuEs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 10/17] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Tue,  6 May 2025 09:04:20 +0000
Message-Id: <20250506090427.2549456-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dbedf5-305b-48bb-034e-08dd8c7d2219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLK5nLVceE7AZeVE/uYO142aoAIE9IkPbhHxpQQARuGqKWQwdWwQ3+1v3ovl?=
 =?us-ascii?Q?sBUxYokQlqJDIlZFEN0um4RgDQ3eE/nNJRT96m3NWgw5xafwfciPpiTRHWrh?=
 =?us-ascii?Q?SVLK8kRMNevOHKaeLbzrTug5P+0W+qaO3IHc9T7SH39LGD4LMgc60Geb+Fx9?=
 =?us-ascii?Q?KIPrhmtgx2qBDzR78AuEymejR9vjXkbtsvaaz/4j4YOd9Ti/GPvw/mP/8tzx?=
 =?us-ascii?Q?gcuqRGxrFY4GQLlIjd9U7dlVCp1KMFVFxF4wl0hE86F6pokhr+JxutDk7tIo?=
 =?us-ascii?Q?W/rZL/I650LiEJZ5AIwNKdoCeMamLzJPCXSE1b6orF1HuaIMtn0sOnDU54Ka?=
 =?us-ascii?Q?Bh2ujj/kQ70E5Bw69ibQBFbe+dE4QluL8pkzIaTLxy7A2j+VmHxTLi2gwuZn?=
 =?us-ascii?Q?zsd1E6HW1d6CNKfn15hXP1JZFwOZvYOXCQfyegcSsgUeeKfAvnw3KGrTf4hp?=
 =?us-ascii?Q?N00RQGiQTcBLXWE9zzWctLaughGHp/FD98uG1yvzDFv+6AHO/pSJNRUOC4Bd?=
 =?us-ascii?Q?gAD267aAqp4HBrUYD70co6pnDaIJKH2I0xCP+xmHyNI4NTXKm7v5VURVkIxg?=
 =?us-ascii?Q?8Sv7tnBh+6QaHPeBcSq3ZXUSBrGePugsAtKA+/pW9XmK3hoHkt4YlpP0usyH?=
 =?us-ascii?Q?qyfkeVuExiFVy3H5alhzSI/HehPzUO8fozouqJ2Ow0ha6BGSXFltu9Tp/VB3?=
 =?us-ascii?Q?mE1O/GHeo9iSCx0b8t/WrNWNtVFWiNS9EphBtYBe6SyjARMADDW9ltgWP7/H?=
 =?us-ascii?Q?UDDc63gy9Z61f/Z076ZlbiEldLVR0b7MLs9jYgQY8gEZ5TVvj55cEb8Gpnyf?=
 =?us-ascii?Q?kQhHkVMHcgIdjPA+ospeorrfw1W/qBsSpr93zVSHz56d3RQ6aXbi2d91vcEZ?=
 =?us-ascii?Q?8MqGnVAA13YAZ+s8byZpIHto25hn3oQmpGmFZKo+kt16vxo3Z61DIKH0xpEf?=
 =?us-ascii?Q?9ClPsmbumAH71s0WSPZfJ3K3vNU8oA4kYxlxa51OZw1NEhAWP4ybZr1trA8w?=
 =?us-ascii?Q?MpaXiAB0Wf018Aqmm2xMzWtf5AEmye4CjIpd9Pp6mzwJQz4p3giTNo1b5MhU?=
 =?us-ascii?Q?uNpQwduZ9pX07yEIdV33L2Lw/zAHdtGVb9XYdU+sUKp3B1eJK+iRnbXapEDZ?=
 =?us-ascii?Q?D1HZWrKI0zb9gFZ4X8ojBcMKXf6nQEmJ9QcdolMtGGSVse3q/Bd9utuqBmGJ?=
 =?us-ascii?Q?2pNBRXkXMEQzYl2LpuxVa/aJkUCRU39ayUENYHMXj/VOKG2LsZDca4FiyYdp?=
 =?us-ascii?Q?IRCbmZX2BJkngGLU1TaNsXtgLaz9pd1cVE5kiCKac2LEkj+1LjDCu+GbAOz1?=
 =?us-ascii?Q?oYx9CEgM+LKZ4kZEll3+coN3UOudEQjf1lV9nKeWr6UwPjHt0zcxLQAARZ74?=
 =?us-ascii?Q?4I5Ldf7Q8At1DzkPdBKYSN76UytTZg60i2E6Yv0B8EN+giiHjh/Lp1ns6oAy?=
 =?us-ascii?Q?KI/bNi74m1Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbAehM8jSXda/5m/IFheMlHd6gY3eBO80ox0WZz+HLOCrblYhGyG6+SvnxE4?=
 =?us-ascii?Q?LwOq148Ee8XmovT89vyhyZ8N22FHYiu+q/Dea52K26F1lQSXlB3QoDfr8g8J?=
 =?us-ascii?Q?3U9m9IcnvI67EEMqnXmfBb0Ym68BVVhFH4AorqkCJ9hI506E0Jev4CY6a57v?=
 =?us-ascii?Q?xFSej2nTwINUZW2wpY8QRLPvokkkQp59vaN7DonOb1eiZAEUkO5kh4FovOKd?=
 =?us-ascii?Q?ByUejwEHR1QWLYNGhmaoBCjgZVKb1QvcVuidql2INXiFUJO4me673vLvSWF7?=
 =?us-ascii?Q?axXZtCFGIt+hsXpFd5OPRYfnuP6Lm3JIE+HfyFHg2X1z5OAysW/ZewE+O1CU?=
 =?us-ascii?Q?lclKgvMly743Mq7XB42QDJKtlPkBt7dSAXiKOQy4ankY8AJHABnY6PMJhlSV?=
 =?us-ascii?Q?oaWCAZp7lLhYqM05ihbtfq//kO4d0G7mr7Rmk+4j8s1Nf1SyjJbqwO5Vtnew?=
 =?us-ascii?Q?kJM2cuIuUzFRbdjZLezIXFQ/HtBQjbLxgu4ZrgBEt/2y+Cnv8m61knggs9So?=
 =?us-ascii?Q?chdB39XYDVhAvllSjEmnhYQhdAv2k0KEOuaHYqzDt0OOmjJU7vcHIVrjqe3E?=
 =?us-ascii?Q?cFq7P6G+XdceKOvQoWfnS5bLAPQAAI8FLhzrmyY83KVEWIdAyO4TvUGhasSu?=
 =?us-ascii?Q?5KuBzo7ITq0Y9ifwgvJrw8fM8cgINq7EXi1lRmm3BtfmtGeCxzsWxv4cUuBh?=
 =?us-ascii?Q?RJpjzJewFg38DrgsttOVrjYtwwMsvhKLtM+Ck1qww4vu26cRBjk/qxeKwPEK?=
 =?us-ascii?Q?/mM2Hw0oAhzggDTCveCbgBurXzUDd2uqrL4O8RfhPsuYsy7h3Le+qzTtR65j?=
 =?us-ascii?Q?7vD14kJEoHqS34ThPkMQeRTICUdT6JpOUkcrjfETJsESEzOn9be9XLDfLebg?=
 =?us-ascii?Q?xjUkjhcadDwfMmHU6cgP7jcFsWmS0jZ3QAs67x4F2qB1kcKMfZ3k0ftv96qF?=
 =?us-ascii?Q?toErCOZO7Fy90XrSytNdhmp3Tpz3Eubxr/7Ys+UO6pH5jX0nq34WQYyh9Yw9?=
 =?us-ascii?Q?uiPhenbvH/nat3y/hxKDzbKtLzPL0zyR0DgyvQ5IjO57LnXm+DYnUSm+Vp/S?=
 =?us-ascii?Q?BnaF/+koAPG35rzT80L37IeRc0uApHhsF3SKfRSSPnIQ37b2yfe8869VM0jt?=
 =?us-ascii?Q?PZ4ZoHkJtcDsTzTXqyo+oZ03jFKnJxZ0nYtG8m/GjJqrPhZYW1hxqHmJH19l?=
 =?us-ascii?Q?8CiLtdFhdF4+U9n0lICsyE2/dSau2nxmz41EojpfyRcGJEhZd/9x4rNMSevs?=
 =?us-ascii?Q?kBNoOKH/6JuWrSGZZYmMIuS6XFV7af8/ff3o3qHoCQxnAmbv2SEBuEfrDLDQ?=
 =?us-ascii?Q?KSVMhmOYNZm0MoeIjwf1/HfGApX9vDS33GnXNSUg2pXuKE2RwbNYZqsBUZIQ?=
 =?us-ascii?Q?YexlazQe5eftdsR8jqPw5uaHnAuVzUzpLBK+1db7zxE3REq8zQ/cFR4krwfv?=
 =?us-ascii?Q?GE1e3Fg8wt9Z+t42Qjj3H+FyqLPDKFQFrY+mI+8T6EZqXT8nng5P36AYf/LJ?=
 =?us-ascii?Q?DeIWSbQdzXB0sI6o4NaUSJte+724czsgbw8vbc1/KZWdipDqnR1NeYnRaFon?=
 =?us-ascii?Q?IJpr+FbLu1klBrblXctTtx1aBmO3iErBYqBhbIdO1NfRZke2++H02FILsgQA?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U0J5L7nb8F7tNROsWuoIgfinuQrtu9p48c3Tm2XIACXFZ9fOVcniM0w/GkcWTNzZegAUKTD+uW88sKP5gm/Iv2WHUAzFlQYU2v155t0jkTDMYl5dDW/w9yZkdVH4e44wf6Z4R+tqB63bRIYOIAZeGZvmomHzEl3nszDKN8NrU1s0kJrk+AFInfB9NxxELdQZzKB+8hcrb5o3EsteBBKOTSNTv0RoTgtN1ByvBKCeHklchta7Zg28tzT++B4bxQCeLprqkREigzY9BVIc1GTWbGXUWYlnoaa3Ziue6Wd5Uw63fDvqwzObFty59yEwXm7/8gq0HrDKOSaaZu5JpsMw5+lahQpBKg5567tu6bGXODDeftYUslBA9rZx8mLpO2F8ztqosiT+ogrFI1uAxRFuHwtaZwFAjNOQbTjgVeMkw3L/mOmqqiHPO/ddJN3oVaaLd53oaGJOH/wEF3Fv6kkXqQObCtJ1YI4PzbUdOq9TlIZXnn5g6iCxDkhRe5ru3ycHYYffW3Iweos98zhuJx2JM8ospdtganC5bx5ADjy4/j5rGXjetaAAHym45GU4kBqa5f4AWMIg95mV70EWvzAwZ17QqbZab9iXcr+Kva2kd5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dbedf5-305b-48bb-034e-08dd8c7d2219
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:22.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q42G6yTxU26OTEEt+DB2pyethfwlH04okTQvVKdZm74CULMzb1mXSTguZQ7djeRyAP/zHoAn5aIowHJP3bCiyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX1VYQtk24Klli /bP/2YYSH/zlvUKP0l5tNZbXTh0m8b6a1DcVWzI8aRWzOx85WLKhGOqTAqFRz3l4zeAXjppVbVC LIo28u3hZnAQgloay49d8kCvZIJtKd0oJUo781jllzLm23yMAhi+7JcRXQBRwmBm1ykt/h0r9Lx
 GScbR8hxR3pLicaQrtL0eq+VZjS5Rbu5vRPIfi19ns47Casi+zbZZgQeOdXg3CbwsHSmMskF7VA dGrdh4lIDaDUd0yiBwQh5vDL7fhhLsQafLPzagmVh9VCH/fLj++4X8R3KbP+s4KdAnPpwseRnKj EeKB1gacTFCODbbHzD8+ju4YOzuQ0nurcCmUhmDgSIb1JWV4yHNew8t/unJYVQm6D8e1+BCG2mb
 1J5U5O6WpSyCAanj4I9Nc8ZmyCXV8+HfWNKZ+JSO2hzUuW226w7+GawhsqU8dErfhUaFaNoo
X-Proofpoint-GUID: u-lLBzdMccr_D097iKkChiL8c40gX5pd
X-Proofpoint-ORIG-GUID: u-lLBzdMccr_D097iKkChiL8c40gX5pd
X-Authority-Analysis: v=2.4 cv=Xr36OUF9 c=1 sm=1 tr=0 ts=6819d0da b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hT51KhAs6gTkkLCEbPYA:9

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 55bdae44e42a..e8acd6ca8f27 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 22432c300fd7..77a0606e9dc9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomic_write(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomic_write(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


