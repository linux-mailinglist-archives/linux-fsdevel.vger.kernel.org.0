Return-Path: <linux-fsdevel+bounces-37374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4CE9F17DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3541E188F7D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703AE1922C6;
	Fri, 13 Dec 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gzWM8oF/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="McSi5TuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF911155A52
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124395; cv=fail; b=oUEDg5XmplFoAH9kPB52ZoEDkTb1IOErJavzy661DE6qmDRICVcaHc2o/2WD7ijM15YgZAaO2zLD5zoc4pZZ6Dtx4u4irYQMM6les5ElVm5QHVGRcM95gmWXgktWVS1GsBNXvUEcjHOKK3HnTr+4XjHluZsVTfgR8xYBaeP2BlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124395; c=relaxed/simple;
	bh=4zr8BX5GsuiijU6rm8VdnHtZEkAcAjvORUU1CbVV2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DE4+kIVmLUngCoVushQpiSJIMf/jmItjHJcHz/1uJ1tZpwkxE+cxAp4kK1EN8wNc6wC4Msbo8tdBJ9whRhmf35WmuqQAk7VKyUgk9paAG4NZiry96EK7yosdMradzo6rL/qLvU65c1dqjItX5Iy5E0neZVCS//YhyO+wkrSSLAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gzWM8oF/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=McSi5TuL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKBotL015459;
	Fri, 13 Dec 2024 21:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VNCmO0OVz4WHDbeaZY
	ZzmrYgqLx5YPbP70KFOuMycW4=; b=gzWM8oF/8ZYRmowF5vRTLBFaJuMp06qKrV
	wEFu6ML4CgsASUIN/+MvoPrVw6PQ3mUqTN5IkaecOjGl6E99Tf060Wx5TUF6Ge/S
	227JJCB11gWCS59gsTJlRc8FRRoz2qJzDDSeQsyDE7wxRI34IhvRzb/Vj3tcJaT/
	YkseCBn/JSNArroqgpZjGEMOFcOe2Ur4N5KdnBoPDOd+M1Jt0hnQ7xGdvIXKrhZf
	m0ita2kA7yT12NdGbGRM3X5I30vgYrey4W7zw+SFEmMLTq+UnqEnRkRPq3KR8NX6
	3gjRBjTDXfnFLVK/nI16WDjZUQN7IWN1F0WlsTC2GpcTnY0IxRXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedceca2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:13:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJPHCX034911;
	Fri, 13 Dec 2024 21:13:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctmg2dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 21:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiTei2t/sBBY+WHdwXKptYf4KnsdNm2qaad40krWHmSHlYnzWILdVcpYDgHSDl3LeOjaKuTlyyibnAKX1VyiIQmTqRkwQtCFlsVUYvGElY8+eJQXIRs81SBiY0vCDZLuE0hnnsX3/QKYVHpuhVDrj4Fkj6wgRnyDeDE8RoJYH1gcn1SmJwQ0LxJwe/8H+hsVZo4uPdbX7oRvaYhJP4jzhvj0ZpdXhV6XVtGblVYfnDMflcg1xzLSjAZ5Pek+9FpEIAyQiT3/QRmxtDuT7KDU2UI/vFmtS1Oq9DRvh/VB7cCCBCdS/9T54W1GIdNil0aeYD5DQGtFrx99HtrK6idJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNCmO0OVz4WHDbeaZYZzmrYgqLx5YPbP70KFOuMycW4=;
 b=i21yB0WMAoLLCadPPZPUsbfG/aXj4u1ZwrJ9SRAtNI2Cb7SyxXWLlY9fmdkOo5Pqm4Hu+xGFAS2JUnZEqOo9oCTs9zFPKOjnZcq9nFQoth0KOJwm9IvVW7anXJ+IPt2KX1FUja0hcprrEYwFRdh9acQSrkioYqduzMS+2tn70tr0Gef37zkYG0Wycf4y2bIvx94TtpbYjO1UHCQVHUF1WhcWownwHo9ZvYtuQPY+sy2HNTdq9zis3/sIZegHez5pKiAK8O7IumOxDFoEgH2qEZ9Ktt0r+r/jflqBFRtdPdxd0TD/NhwiwhFFbN2VVNI5RI8aFi7qYckJwrAeDIfOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNCmO0OVz4WHDbeaZYZzmrYgqLx5YPbP70KFOuMycW4=;
 b=McSi5TuLhWnklI9yp99QKWOJQAPd/Mjn9fHkcwsLpprdlEYbL3sDWsfBAf+SzYhZa214phTpwnQwfHV0lkBxwnStMYBSNoFjznJTwnarHGWvswfWdBSItr2uFvMhXm/yIxlo5qeQ250fizdCJDVuG4idlsJOBqLHuiTBp9mxQt8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7808.namprd10.prod.outlook.com (2603:10b6:610:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 21:13:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 21:13:03 +0000
Date: Fri, 13 Dec 2024 16:13:00 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <n34ehrnw5ocf74yvnn5wjtye6yj5xbjbnwpa57ditxgbibzgfz@vla4ukfjj454>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
 <20241213-sequenz-entzwei-d70f9f56490c@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-sequenz-entzwei-d70f9f56490c@brauner>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0409.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 63926860-b100-42d1-3758-08dd1bbaee65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEBzAP/9s3HbOnqokD69q9ESA07pr92vFlRmFRXM0ydJJeGnHvUnEvSdtyJt?=
 =?us-ascii?Q?9a5YHclqMg7Xh7MbU+yRkLJnffNipen/EvDGqKILy8V8kzkhWQDFruP3xYHs?=
 =?us-ascii?Q?o9VkrOiEE0YhE7x97/RjGyUGChVCqHyyzJWNw9vWOq1EcX4iHFC2BKD3ROBW?=
 =?us-ascii?Q?DYlCQRxfgNduOZkS5rt1ljICa2NJpqmakXREnRKokVeDAFGFbo6RQifL5epa?=
 =?us-ascii?Q?r9OJmBB6mlzq4IElIPvWQGUl8f3xE3LOBJn9dSX3+Pd96b5sPK8ZYIbS1T7C?=
 =?us-ascii?Q?uyvfRswp2pvtS3fjuYIS8tlqryrmDRIcTLWiJSBenYF5Rwwltl5BKJ6Se2qK?=
 =?us-ascii?Q?Wgx4RfQiJaTD4jOs7bVVBRVhEJaE4shMFKxDPVsQ9d80elFjhX5PrKFoYMMy?=
 =?us-ascii?Q?pf7W2DXCxvdJ+PwiO3A5PORvKlxFPTbQNoBqPKt1ClZN41R9z4wno7PKhXxB?=
 =?us-ascii?Q?i/QkWlL2LbbISJaYUW7ODtM/QPFTQXHyjb6ZA15Ffic0dbxyGqC0kfQopBtp?=
 =?us-ascii?Q?YvuhEEgQ40/rIZYAkeJBO7yqcYilYsHttP6kz2j7jj8s7WGpn68UkB0PEptA?=
 =?us-ascii?Q?yy7zrI2T7y4baekrwS1XKgATF14IDpUL4+3XyrX/fjfjtdyY+dmHnEwyhCbw?=
 =?us-ascii?Q?VPn9Lk30zVyTW5hNXYegR5TyY6llfRL8irdM4JpOYBtzez4qZVKkdYtvF3ny?=
 =?us-ascii?Q?cpxpdwZsn+rZWjZJRPHY5R9v0DBgIfN0AcOT8Ao019Nhgrh79ihEwl/zens8?=
 =?us-ascii?Q?rcJstVHNYiZbnf2QK4dkMxV9xnqbVON2hMgyCz1r1IC8BfUC9CFjlsiOwoMJ?=
 =?us-ascii?Q?w0gRWyieusn2nv3IBVirlD5Rn0jN4nfLbDmQZO6rZ8jd9zhzZrb6YWLXGatF?=
 =?us-ascii?Q?S8DHkzCoUg4+kI0y8XTyaO5Ocn+AVCeSoqoG2Z0SYnR1eXipBl8hFvX80Vh3?=
 =?us-ascii?Q?bmoFb4kbMe90jtX+l7+qQZ6DN+ydCk5PV9sxwtd01mZgNd2GHcqyEJNPbfgF?=
 =?us-ascii?Q?sw1LEX9CFMalubFXdnfjBWNUQC/Thf7tHYArCYqmP5SOXjAAxogym/zNy/ea?=
 =?us-ascii?Q?XfmVZKLtzRFneMgX6M2h6aaTgwllflkjTJrit9szZE+16bqNtuEc6NYzQe3S?=
 =?us-ascii?Q?b2gDhVulZBuoE+COz+8aqSPteMhYH2aoFPX/7l2qswPxjie+4xZjpbQBhviA?=
 =?us-ascii?Q?quutOUFnhO/ai9Z2AK3X6XekgyDOmbOOdcemz5MucoP/aP8saLZ804i0gfWW?=
 =?us-ascii?Q?6AGaDXrmDqPQn+KeITU4jU1N5CqUkqN69s/fIJAqFLdHHZm3cSvrGrs/yiwi?=
 =?us-ascii?Q?yfW0Xv5QYihM/jSkYA6kQEaPXn1UxPRM/YeXpeXA6vZqBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCFRaTs+Ze8wJgOlSORpu5BSlOKqA8DbMuMlLULTeDQuZKYFpVWx6HsStM+s?=
 =?us-ascii?Q?hwG4Bd2X6QBLpWR5+2DC/fG6S00q6o90kDi4qo/m2xn77mtfsbcUMGXRjmmU?=
 =?us-ascii?Q?LCn2ajQ4DLONuBiOcTHXk6O+ice93qu+JLtJBWDDYh2osfeLYeNrE1vjdyPk?=
 =?us-ascii?Q?Wf3rGEc6zcUca24X/m7K0ai/A5nQEeitmzkTFloXzbcGrMkjnY+BaM95KqE9?=
 =?us-ascii?Q?rQfpXPb0Pm0jPIi6fpo+0BNDAOvYMa84OO4tfnO7Dif8BZWkwTU4q8A3WX+E?=
 =?us-ascii?Q?J+WMo+Iebfv8jyQOOd8t5hwfc/fc9kXl5j7PtwAINaSVZPXpO0uhn0Hm0guA?=
 =?us-ascii?Q?vd09UhPCHi0xC6MfI284rtAcIdkV5tl2AUyOtCzH7y8uAQT7iNzAq7C+X12v?=
 =?us-ascii?Q?YnwGh5oxWgbEi94jtkrbBNYSLWHBZwFXLZtb+ecZVCUApyUBam6r/piwyezY?=
 =?us-ascii?Q?lCHPIpFE/1hvp5zOewQDoARQ0muSTeiM26z8/3olH0GL1anEenbXHW6uoeBE?=
 =?us-ascii?Q?PNY7DnoFfXF1hmIqZgRuLR4SOZ85MOZM+kjGumKej0VoT4waQj1P6voqJYTY?=
 =?us-ascii?Q?4/Z+U4MCoI+aqPVZIKkyzhPnIvPbHGf6zMfTrRwviqRYGMFjf3QJcoiEI802?=
 =?us-ascii?Q?jDnpy/FVHoMtQNQTp6FMf5a5O4QL3z447b/AqQaYdM2ralSJXYhkeuHuLA7j?=
 =?us-ascii?Q?BymetiiOkQ5URqQvLpUxLTS72RJJ5su1NYJ3qwmny9AngDdxUBXbmm3KJc/P?=
 =?us-ascii?Q?2zQQWbC5DDw3c15ZN2p2muBYdp/3xKbP+Acl4KV6PYhMJCri9Cp8wfbz44L3?=
 =?us-ascii?Q?WVoxC9dWnasHgX7Aki5+AE97t9J4/ZiAPArsGkLxgq4/cow8a+Dw7JfTJyhd?=
 =?us-ascii?Q?7atIDcW6eYqu5By2t8xrS8m7bTXBVUQ/CHDGU38J3aKUccHcEzY5HWblI47Z?=
 =?us-ascii?Q?EAVhVF2dDGhO5ShQ1VLBYpQ5hjPtRBFykSAivxPFyf8o6NMiZZpMt8BXjPRM?=
 =?us-ascii?Q?79+vcVpLKKOTRMUa6aEKZdLCXoNO/aTI9TLneppRBAiTl43ABN0P58A7k/QG?=
 =?us-ascii?Q?8/BQ+jL3Y3pjj77smT3b3XjglavXQYcASnFqfDerr8YIyq9SVaJhjvth5EHi?=
 =?us-ascii?Q?TkiHtH1dtPkozXosHkOsyRjAFXfygdygQZfjJi3u6GCBmX3E9pwupH8ptnnH?=
 =?us-ascii?Q?EMQBfngETw4at1ro1X2aAQb+s3EHUetnye39C2EAk0W7RkWOzfUJ7PfJzcJ6?=
 =?us-ascii?Q?705Uu4S2vFj0GacqxpagKmUf98lHXcgrATKnt1y4Qm4vn2f5vcBm0bU2voDU?=
 =?us-ascii?Q?IerrqiVwlsVz/cw7z5gXI6wo3A+BIknVm3GVzRZdK/YobUueRJy5PUZk8w6y?=
 =?us-ascii?Q?QmmyYmJMyQb8iOMl2WzH6fbO6rOOS9rp/sfXDvKI7qiI5Y9Od0itpLJEdleN?=
 =?us-ascii?Q?bIbTq+0D4Jpuwo8c0mjVHTqbS5nTejKL80q0t0qsdzV3x81YbYpimXaS2xWR?=
 =?us-ascii?Q?1+ycktV4k1lBlJ7z1fkQ4gpgzN8q1hPIMoMi2RRbsQmScfdyAlgQMv2IlERk?=
 =?us-ascii?Q?MVeJOanss2GWudESoN9A6IYI9wQOrOlDzW3c1j5s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9t4obJHJN/yrAYKn1RAwSgkB+0tZhfbgO+rVf+XOgxLlpPGaNuPVpXj2XDpH7pDeozN8BCoghe4VdpyNcyqbW6IK2WqB+gPifmCCPD58nRdKsf+CmGMgPCkUcv6B1on7QcqWce4Givu40YOp1LL8I6ArSyMqe5tQachLOXEm9UQeH/eDkK0Q1+Ek2F67pEH7HIksnnDAT9AUm4hYeDyp3zmtNp9lzR5+4LIkjQgpwn7LH2pnu9FnwoUoJCHl2swnmOncqFFZDk3zH4v4iJ4Zk/xzhjHhO9p4NHipWD5YvV/LwHjyaGYTaV1rNJ5HXjhtwUl0brZ3IVDClzVjsoV6TGzDt5FoewtBlFyYH5s2J7vzS6ZX2f6yckqFrEQW26fHN08Y+q6iuYs6LKJm5tEK4vjPGAubGpoDDbNrCVICS58q6M4bhkLBnVPYufOOHs9ccmrAj3hx0EtnjCXmDjGG+66jFEhg40N67fp0gT+dt26U+6AmCO+Fxs9JK5I0PLJkkMNdEfojWkCQ+rMrdhKly/hMgWdsEmYIrSYl0wfEo14fuRO/j9zAGGAlpkzgSWyEokqFKBmfEdmNkQhE3M1K7MW2ejroUbAUBJNpCr8oCOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63926860-b100-42d1-3758-08dd1bbaee65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 21:13:03.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB/DA5pP+RpVlohZhhnmdXO+Ha6+AJh5lKKScuGMpbVVBSgTPLcWPQCweDC4ndHG9OGH+RBo3lXx1j45Wh+o2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130150
X-Proofpoint-ORIG-GUID: oNfrFOJ2uewG1s9AUm_yNvEA1h7YrzbG
X-Proofpoint-GUID: oNfrFOJ2uewG1s9AUm_yNvEA1h7YrzbG

* Christian Brauner <brauner@kernel.org> [241213 15:51]:
> On Fri, Dec 13, 2024 at 09:11:04PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > > I've replaced the macro with always inline functions that select the
> > > > > > lock based on the flag:
> > > > > > 
> > > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > > {
> > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > > >         else
> > > > > >                 spin_lock(&mt->ma_lock);
> > > > > > }
> > > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > > {
> > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > > >         else
> > > > > >                 spin_unlock(&mt->ma_lock);
> > > > > > }
> > > > > > 
> > > > > > Does that work for you?
> > > > > 
> > > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > > close as possible.
> > > > > 
> > > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > > as appropriate.
> > > > 
> > > > Say I need:
> > > > 
> > > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > > mas_erase(...);
> > > > -> mas_nomem()
> > > >    -> mtree_unlock() // uses spin_unlock();
> > > >       // allocate
> > > >    -> mtree_lock() // uses spin_lock();
> > > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > > 
> > > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > > retake locks and they need to match the locks of the outer context.
> > > > 
> > > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > > take, no? Any idea how you would like me to do this in case I'm not
> > > > wrong?
> > > 
> > > My first inclination has been to do it via MA_STATE() and the mas_flag
> > > value but I'm open to any other ideas.
> > 
> > Braino on my part as free_pid() can be called with write_lock_irq() held.
> 
> I don't think I can use the maple tree because even an mas_erase()
> operation may allocate memory and that just makes it rather unpleasant
> to use in e.g., free_pid(). So I think I'm going to explore using the
> xarray to get the benefits of ULONG_MAX indices and I see that btrfs is
> using it already for similar purposes.

Can you point to the code that concerns you?  I'd like to understand the
problem better and see if there's a way around it.

By the way, I rarely use erase as that's for when people don't know the
ranges of the store.  I use a store (which overwrites) of a NULL to the
range.  This won't solve your allocation concerns.

We do have the preallocation support for a known range and value.

Thanks,
Liam


