Return-Path: <linux-fsdevel+bounces-64504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33FBE9392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 063EB4FEAA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80432F693C;
	Fri, 17 Oct 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q73qeB59";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jGl9TSo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44574257859;
	Fri, 17 Oct 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711588; cv=fail; b=e9KaHARsnI2Y/ZB/UEL7hS+glCpPEJIjMyEe4d0uTYADqMpatI2Fv0RnDOGxdaxxLN+1s56VFXZsYCz05ZE0seAlMPTuvbEGQrDKYb6nVLyAbA/5cz5aZbXbSFE4mwCE1ap7++j8ZKP125qzbjNNsJkGgFfLtpnUt5KEVF6MSG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711588; c=relaxed/simple;
	bh=RlAakL+VFDPAkF6uR4O8iATR4bbXEw0f51v46JvdAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPjQraNn2kQonlHTn8qhZ68St7LPrS2Vl3rx1ia2ks/o/Ih9RZO1+J8PCHyiQV2nQkJXWDcW+HhY6IL7JADvCfhYG64nWYJyfCPSj/z/epaxIhobMtqb8xF/DdzJYcxtswQfgnUwKAPyIa9u2D26plJCAzGk/801EZ2aP8t7gz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q73qeB59; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jGl9TSo6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdals014041;
	Fri, 17 Oct 2025 14:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SNTVvqY3KSKVp8CVvS
	Jq1X3ZpFlyhLREguTCkXPefyQ=; b=Q73qeB59E/43J1VNQ7u0JwW/TOH7s7iG4/
	rZc2eJb2QslqAY3av0+xeFlSgyb8JbOSikEVfjdTmeDNb+DGvMFFk3YpgU+uS3tL
	y8fr3Bm5JRnasgwnsP6T1rkY4WwVYd2Q6vcwxnX0bNznY3ELKnydVXHHlQYwI2qK
	++Ni9LH8e4GKxB0LTLELrEsYQNN07pVXoapaqMMm8cO5JIzD+vug50cg2Rsz+vro
	pkxwEseRZAaNeJP3Tl3u/EI0r/Z1i5mgIqASOJgz3OuXgnqE18+HrKeXQ5tA5pKM
	1ldW/vRv71KhU6SfpaDDM/xptiMG5GhjksZdKj/+/9cM9f80h1zw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c35gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:32:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HE4F7E002310;
	Fri, 17 Oct 2025 14:32:19 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpk5atq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbCEr/5XLDJiB9DF7xkrBT/RWA5fIaMVE2DHcXMoIpVvhxl9+ZcbfR3SBf9DTeTlaFKd7lx7ZeJ6a9eoErpipBwRiIu4eBTOMJu4L4iyiA5FpDHk4nrIYabxh9iBOJN37RIfJP4QdFFE+qu6XJUoRZWgWQmTC0EygC5VPPg10T2BQHTBkCz6xJs9yDg123q1bDOyiLdAv0SVepnecu1JTPZLl2WwQ6Sk6naAON2kA4BcgZ2KFtxfqkcozIPaqBDsQkvN6Lge3jMldOkVFetfY4hQLzjV6ple2sb0SXJh4ct1k1Lqwr5c64sJG/k7IARZo7YxIitUwGiKcQ96cqhCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNTVvqY3KSKVp8CVvSJq1X3ZpFlyhLREguTCkXPefyQ=;
 b=JZ9diY8qfCbEhtPMcnQikkE5ddNXxQziQK1XYQ6KFbSPE/qQ+wnsXoMXu6RwqmmxEdUhqGEmDHjLyuos6th+NIwlas6aTb903LQfhEOiNwM9pg994Cm+zZ0O9mrRwXxKT7gJ6upyEXVw6ah5d/jSDo2oAowsywXd52VjCMKUWe2hIyLhuMUdamFDyjUjePrCN9sfAQhtRITSa+r28LSWUr9nS4ZlvSRD96J7p32CMzh8/1nLYAu9oD+Znp1C1yrraGF5ZVpBU6zh8sTc7cvZ7RwoKyT4SvAUc5rNzqIltF+Cq24a/b8gekad+3y+3rVqfAwtfk4HbHuqQCsxlBHI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNTVvqY3KSKVp8CVvSJq1X3ZpFlyhLREguTCkXPefyQ=;
 b=jGl9TSo6UGTn+bpyprfNVN30XVj0LYr2nvtMBFaOpvzdlQcEnvxbWiQahvYwQNfdm2sn08Cpd1/prmEMtyD72CEqxYvzz1UQdmG7dxeNpIaepwjgIAa/nQdfucVYdtAqnknx54ZPkOC9i3Iy3RHYNgxJkLQzLKfttU6cJsR3g+A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFDB63D4CC3.namprd10.prod.outlook.com (2603:10b6:518:1::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:32:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 14:32:15 +0000
Date: Fri, 17 Oct 2025 15:32:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
        david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <557fd56d-1a4c-4c65-8db6-34546c9ce8be@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
 <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
 <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
 <16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
 <9567b456-5656-4a48-a826-332417d76585@lucifer.local>
 <FEFDFFAF-63BD-463A-B8B2-D2B2744DEE2F@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEFDFFAF-63BD-463A-B8B2-D2B2744DEE2F@nvidia.com>
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFDB63D4CC3:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b139f6e-eb32-41ba-e4df-08de0d89f812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0LXv3e116tesfThWOUrm1BIhYBVNdNLg/5FX+RxFslpTLjX31An1aOsp7qm?=
 =?us-ascii?Q?t1RBjSWbDl0PHGTKQ0nnzTphVa7qBtPgZBXsTtF6NrNIk1v1xx2+yhFgCz8N?=
 =?us-ascii?Q?9fA99Ye5WU3s/So1c2cS4ElTElMzvK3pU7BminEVaarznJCOzHDTUF6q7xTA?=
 =?us-ascii?Q?dAfH0TZxnVDXz6Hrh2F5xLoA2ztrGFmozJv/u/BMduaSB6qsoQKuLwlYAMRv?=
 =?us-ascii?Q?k3dxQrs7gTRhmMBV6EYCpCts9Xn5cpELs6fejbwM6RM/YeudCyJfww5QWVjd?=
 =?us-ascii?Q?HvmP16O4HV+IncC/TNkKmJLwleaCk7QfG/n6gp0xH+AqOQHGpmfUCL5vYYqk?=
 =?us-ascii?Q?6xh+1qilS0SNBIGtVpLoHYDIpc04k++QfR4zRmqhI8+Fsp2GiVg4JGfxsHXv?=
 =?us-ascii?Q?q//rtTCrhQXs3XEdP7MuQ03fMdpid+bzcQOUQR2yPczz9X+jvGx4BuxFiV7f?=
 =?us-ascii?Q?lYntTYseZujPMx3vtzCe024XFAkflPGX5U4XGxF2y8LdWAbGtkn4ifrvz/ro?=
 =?us-ascii?Q?E6YSQoZ+mwiOX+QpCpLCbpIc9d4Gv+J/FMI3CRJqIkutiWUjWUw3wfAT8BE/?=
 =?us-ascii?Q?wcXRaqMym0QaL32FlmA/9auh9bYX3H2cL0c5CoMhnSdIrllx+HMP/ShlrE/L?=
 =?us-ascii?Q?MCt+VcJU+YGDqwamxlMrKpXbFnoGddHmLm3VAjqCuqlsPiVgvkHnorvtvWn2?=
 =?us-ascii?Q?NDmjjCUfovMiDfSyq0JKhJ4pTVhF71uS7tSvVmNRyIeyqK83Ye9Tbw1mC624?=
 =?us-ascii?Q?SSap9yjLDlZNjJkfKGVicijj5b9j6TiAQxd3i0BwIlYUxSIUX6AkqvvTL+YN?=
 =?us-ascii?Q?yRO9TgLVnRbiuF7Oa6db8wNYcrCg6w8jCa0IXTpbe9ZngX3DXx3+xCh7Tbrk?=
 =?us-ascii?Q?/Go/rHIrFrrs7yJISrRwBEZa13tShzlEZCvIigsLZp10/nrqnatdU5DqwQbo?=
 =?us-ascii?Q?XN9C/DLmpHM3JEsuqmKJJa/QGn6Ef9FJXsYop3+UJsCtJ6b2oB2f1MfCcezc?=
 =?us-ascii?Q?tYhbfaiaz9OGqwAccqpWA2cr347dfbjzctp4AvQ+Cci+hKO1j0BqQcUiLHA3?=
 =?us-ascii?Q?rC+gRWHBen2TVY+z6fpvm5PpmnT2UL14vU9mN4XCCKu4YEKL1JgcLsgrwmwJ?=
 =?us-ascii?Q?ZHTO59znYrIGOUVay2t/QnlMAWBTr540n9ChmTfmmkw4nqxUc2H/MHBrhxt6?=
 =?us-ascii?Q?yeMEki9GTL3aLYrnPrBZUfKCkh687IZ6aibPbtlpqlmEGDteHLxttZHaFbOn?=
 =?us-ascii?Q?1rGPcbOXRcu9dseT4hJuy8b7JRkufTWVotKnVu7TJh/AKydXO4X+QsqrFeyw?=
 =?us-ascii?Q?pkVSyHEjZTTgtqPI9CMH8xIMBNedcvhKtyzrtgrEwou8OvXlEgCtN0QWxgYG?=
 =?us-ascii?Q?3g1JYQZiqg/KzIUxRL0S8je+4mnzJNbC0HdXpl0UG9iu6xPyEzE5PJFrdx/s?=
 =?us-ascii?Q?vZVjgicRKcUIvBW0wS9WN/rN6dQyqca6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aSYjaTNAIXWKEKCHrNJD61uFQZumObbG/atJY8dNFTIvJia6GUCu9zAQmEg?=
 =?us-ascii?Q?eHOd+bradggnzwdD5yub3V7UNgi3xEFBwjOlQSLg9UYR8qswPZgw76UdBAFe?=
 =?us-ascii?Q?G220ZaTvQECt+kpQj4WoIQMG/sovZcG0A8aAJT/o+VR81nUfXNE+9xz1+J4F?=
 =?us-ascii?Q?0OkjY8EISWYZejIhXJeEPeEiAiAx5wDsqzjdvmBUK9McYSWDb8BphZ3/dtcY?=
 =?us-ascii?Q?zeQmm6LVC6hRt9CiAE2O5lny9KvCYlsn/suRkgfmvXzJmdETQIBe4WPj2Sao?=
 =?us-ascii?Q?5BGLNeFW20FURSX0VF5G+x6voTIMHczxhNRMsCCMtMx+ge/bn4Mv9+5dP+W2?=
 =?us-ascii?Q?rkB589hJUU0mDDsMwR676YC7YREpbe6cOseC8oBFeQ/wmwTOcxMmSbuQvZ21?=
 =?us-ascii?Q?Ft3ELQFdDGWZfBn/J+C2w1l4iy6ZK0FyfLnta7Uf+wKTcsH6DM+13iYeiXB0?=
 =?us-ascii?Q?03SNHfssuy4EXWqNOH0a2Aes+rkM9JiC1eS24nsKRd3dFvTPDy8+S8scttR8?=
 =?us-ascii?Q?ZtI1wiRhqMlEWXDYvjWj1dKHlyikZNUajeV+SQYKFlnm2sMmh7oqUO7LK/Eb?=
 =?us-ascii?Q?qDFwpN6/cZvKZKpfUh7lQhc1o02w8o7+3w4FL0ckhu1l5+igI0+u86Y2DG7N?=
 =?us-ascii?Q?VZEoVGHGnLsmTP26n6Z+fX5tBFHnqfyFJnK5k6mkVeLF8v+FiBm7mMa9B10U?=
 =?us-ascii?Q?tdwrBBslyHPj0q2Kl21+yuXpb1y9fBPL6uhQQod/cv4TGjbmh5fwfPIzUS6D?=
 =?us-ascii?Q?MlNipN86yGLDZGZqETIWkVf4aWs/HrWkGIenzdJsdCDEpFUg8g2S0LxGQaZ/?=
 =?us-ascii?Q?0wEqFWf7Na3pnTgd4HAexO+JoIfZWDhsMr4Y+Oe63r4e9y028A6ROV4Fc/EI?=
 =?us-ascii?Q?6Nx73a/5JwXbdFAnfUwAIb20Ag4VpLsVUWOPU5ReVRbCQNpaL/2h4l/qiPM8?=
 =?us-ascii?Q?J7UEUEjcy6Tk3qxLLc4MUdz0xUJOEJwwFEc8Xthw6vstWBckWZTOd3oYL4du?=
 =?us-ascii?Q?HpEGphUnhWn1P1ii97GTzfKegRuXZo5PAtcJKqZr6CDX0nslZsJu4so4LnTl?=
 =?us-ascii?Q?qtwyC8jdPm/N4+OL/9TlKDkCCyfYOA/eZQqXUE5K5+XO4PMMcqL70HcwadtZ?=
 =?us-ascii?Q?naJcu0zq8xPpUHkZI6LhUqPV6VHaxTIIn1bl0PRNl50f1S4U5KDG+HvisIUc?=
 =?us-ascii?Q?0nYQxK9ktP8lOPXLG9ZxBl5qQguzmMB9uW22PTXnov2T3FHhYRKREyDuqFsa?=
 =?us-ascii?Q?NbGvHPPJhXxPPv2yv3MOEvywM3CoN+V4AcOMw/nK0Y9X0AjEWCxUXfr+ZCmh?=
 =?us-ascii?Q?Bg84AKNvWoLmWEbaHnTBVmT4GDUIm+t7kCvujomxBRsvWhSpbrr3CCjrc/d/?=
 =?us-ascii?Q?3yLDAQsG/kdl1DG3IJHVuT2JgBJeOGQHaAJodrcy6KDOFA/UQ8q0p/kn1vE8?=
 =?us-ascii?Q?vJLVide8+nG5LQGiACwqBp38se8ux5RxqhHTdycoZ1qxw1dtDMxkkKbgno4U?=
 =?us-ascii?Q?O8cfd/gR28RjoCHWIeCTqLAoZQgu9d+HKwL1JzNA4u/fxKdcf2v7NyrXIak6?=
 =?us-ascii?Q?P/sxu/haw0NUWEwrWg9u2zVDmXNn5+YFx9CeF4Zaht1yOG/Guj2HJNwVm7qq?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BqOqkb3SWeWAy0x1cVQMbRl1VQfrvf7Dt1snia83x+KvtTcvQtljYinSuZh3LSbGcaaCDAzf5UqznDjoN8dFaOchdjQuA637XI79893oPFkUGVgo/J/a6lbG/YypATW283boqWROokJwLHcWLpy6DHxyIcEHLtd3rAmBmj2D+c4zqirg/raGrTnT14VMTheVg5RKEJ27c+M7n9Cpwa6lz7qJwwXyslHjW1WPE2SNkpQY45cy1ukbbblAX/jg3qpwsUnVcf+RXabM1b89ATaaS2wBHNtecsJnqXyDtynBs3NVO0SupYDe/ptBTOSOpU3N0RyHnsnJIERJFRysVHGN5KWpit/NwB4ah4vlMMDnubh8EsS1LasJnKs0XyAs5pc3zECJrYjYf2kSfT8WcTxHKR/WbjdTQ/YX7i6zus6u6BjrbwfVe27FXzmQo8YMbLc7glVxlli8lyPok4pNXy/QQMw2VdJMIabPSesY4U4C5tXpcBeHa6ZlopW4copal1wTWA9FZk/Yi2n+QvH4FfeAErUyG7rkM3XnS1t4K0RECSVAAk+lk/IOnqqrmxUA5lsHRyhunsnkRbiKN23WYOEGkcMBcCVEoh+vyyl9iSZEvzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b139f6e-eb32-41ba-e4df-08de0d89f812
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:32:15.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZqV9F/2QrDAqlYME4j372kwybdfuMrJ5sbUm89p3aYWjMxTknVxoRfUp1SwcXtMduB8XC+hoYuu1FMuc/AkfwsJqC/fBbFslcnYHqcHrPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDB63D4CC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170107
X-Proofpoint-GUID: 5MRR8ecsvjZshdOwhrK9r0QGxS_gU6DR
X-Proofpoint-ORIG-GUID: 5MRR8ecsvjZshdOwhrK9r0QGxS_gU6DR
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f25374 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=ocnp0TCbM65VgZBstS8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX/1fI+S08Ej5D
 SxPcDcuRhEa2yHRBPeC161ruacpMA/9igwTGArgf+epvtXlaoaHqMFt1RYH+OsghX97Zb2yM1X4
 eJC27NgRdOVwsjMvem+UGwZ84qBsWVvmpy1LwI5qM+wEyPjAEpgRRPGFNjY/XDHmHr9P818Nlkb
 sm20kfdTcCCLQVMtoUatOMr/K0neMMpzblyb+Nco1mDmLyCHeOnp06Mb27qRZcfLcF13AjIStPe
 qYv5TnH0f30a0NSG4ZrtH/VLB8KOPyaqRQaeCLpLhbsjnTmDiGdKOAhU4diqNeFmVPYBMKT6Ps0
 zh1beJnYqUgZ9pEp+BGSgSbtD8wQ7S4bq9DoGKNozt0D2H7kwSPmsj7hgklRCMRtJeLLVadxo7j
 cRftt70g33sdkBVnichCqs8rUwTgbMLNuivH63F+oP5GFECZTyc=

On Fri, Oct 17, 2025 at 10:16:10AM -0400, Zi Yan wrote:
> On 17 Oct 2025, at 5:10, Lorenzo Stoakes wrote:
>
> > On Fri, Oct 17, 2025 at 10:06:41AM +0100, Lorenzo Stoakes wrote:
> >> On Thu, Oct 16, 2025 at 09:03:27PM -0400, Zi Yan wrote:
> >>> On 16 Oct 2025, at 16:59, Andrew Morton wrote:
> >>>
> >>>> On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
> >>>>
> >>>>>> Do we want to cc stable?
> >>>>>
> >>>>> This only triggers a warning, so I am inclined not to.
> >>>>> But some config decides to crash on kernel warnings. If anyone thinks
> >>>>> it is worth ccing stable, please let me know.
> >>>>
> >>>> Yes please.  Kernel warnings are pretty serious and I do like to fix
> >>>> them in -stable when possible.
> >>>>
> >>>> That means this patch will have a different routing and priority than
> >>>> the other two so please split the warning fix out from the series.
> >>>
> >>> OK. Let me send this one and cc stable.
> >>
> >> You've added a bunch of confusion here, now if I review the rest of this series
>
> What confusion I have added here? Do you mind elaborating?

There's 2 series in the tree now:

v2 -> with a stale patch 1/3 + 2/3, 3/3

v3 -> 1/3 separate

If I use any tooling (b4 shazam etc.) to pull this series to review, it'll pull
the state patch.

if 2/3 or 3/3 depend on 1/3 then it's super confused.

All I'm asking is for you to resend/respin the 2 patches without the stale one.

>
> >> it looks like I'm reviewing it with this stale patch included.
> >>
> >> Can you please resend the remainder of the series as a v3 so it's clear? Thanks!
> >
> > Oh and now this entire series relies on that one landing to work :/
> >
> > What a mess - Can't we just live with one patch from a series being stable and
> > the rest not? Seems crazy otherwise.
>
> This is what Andrew told me. Please settle this with Andrew if you do not like

Didn't he just ask you to send 1/3 separately? I don't think he said send 1/3
separately and do not resend 2/3, 3/3...

> it. I will hold on sending new version of this patchset until either you or
> Andrew give me a clear guidance on how to send this patchset.

I mean if you want to delay resending this until the hotfix is sorted out then
just reply to 0/3 saying 'please drop this until that patch is merged'.

Otherwise it looks live.

>
> >
> > I guess when you resend you'll need to put explicitly in the cover letter
> > 'relies on patch xxxx'
>
> Why? I will simply wait until this patch is merged, then I can send the rest
> of two. Separate patchsets with dependency is hard for review, why would I
> send them at the same time?

So you're planning to only resend once the hotfix is upstreamed completely?

Sometimes this can be delayed a couple weeks. But fine.

As long as there's clarity.

>
> --
> Best Regards,
> Yan, Zi

Thanks, Lorenzo

