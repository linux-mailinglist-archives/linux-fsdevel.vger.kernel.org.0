Return-Path: <linux-fsdevel+bounces-57723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4CFB24BE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D95617886D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3DD1CD15;
	Wed, 13 Aug 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBBKyIn1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hWXggvR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D301A0BE0;
	Wed, 13 Aug 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095468; cv=fail; b=qNL7rW0AT7LrOlwE7L3JJI6M4Rmfz9OxqAXfhP+uViM89UTSKjz8hydM0iSDvUrv9Uxa0wKscgn8teZmwtYzsKDIChNjf4EvgpVnhQfcaufpe/ORhrQz9xRjjXelcuj0ENH5CuZ/9HlQZRnZa4EtpcSEohv2Yy4DWONSO6mkxZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095468; c=relaxed/simple;
	bh=rNLeJHvFvWWDzREB9jT98AkDmEFVMDUDquXxlxFLATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0f9uWwTNkzMul2hFOJjtVQ9nvA2ASWO84js4etwoJvEhfHgljdppqjr+C91Pj1KuwxRkWeLlRPsru5mxOppaSHqKCIuayI4BxXqT1BZ5XOseQGZLkz56+lXuu8wtj4hXesz7kY1i/C/vGlLzW8qANu/f2+9SnRlehWTyD6Fakw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBBKyIn1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hWXggvR+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNUr2002205;
	Wed, 13 Aug 2025 14:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E/y8qMvQ2mbQgLhetE
	7+JSE+giOl4QGyTSnHAQq6+Tk=; b=kBBKyIn1LFNWdiCUqW6DYQOi1MPU75Va+k
	Nim1MLck2aITqSAEk67LDcSoYIkwHh6ZkxueRR0JSPHVh9nSQ80BkBX3EFeZj+ig
	kuVSwswOzhmvh/t0bAwrMGZ5rDLHK3KH02UH8HJMLv7fidA9A1L3tInw/KSnKU74
	eMFJxhw6kzp10Bmh+SHTvCCh+AyfgWabZj7DAtSJXZPZTaxwk81c3X+S2PiqvNV6
	WgjKLJwJ5i8JpFT1DRlyhm6d9yGve/ttCSuAmbiT8oU4fLKHRvWb4h+urQs/FzRP
	/4AMUUOHMBGxnf24b2IbCpadmmugXLVJIQoL9f82wNZxIIkSpRCQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dqjwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:30:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDATMm038561;
	Wed, 13 Aug 2025 14:30:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsj18vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG+c71MycMAzItvU6QfSkFfN/NREV8drkm7ro1z0IKUDLIHTYG5PNuZWeBlT01+gXEwPba3uwgIKG5bQNeu1DYjisZveWuRnpHtHSQGUwqCk6fm3kfWQY8d1nSS9KypWquc1gXmeFbowg4gmJemVO/ujFWlGaEwLAE8JuwOdP7+L6mILNFhSCsMt9oxM1zDap1A/o8goK9c/d8xuLzGIMw9LoqExdIivBJQt+Crmzv1A2jv2cPOuV48Dd8rAtKndAckJXxaF0la/USMmD0GWiLwWMpSoiXhdTAjVcwRICB4WkfR75ADE6EwMcVwHNn0hN/P4+MEkVHUDTju/8bWHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/y8qMvQ2mbQgLhetE7+JSE+giOl4QGyTSnHAQq6+Tk=;
 b=GW25gFiPGhgMvDd2Fo3gGf+UC8W2H30rsjSe08sz66lHDVJAb6Wgk71Ssw4pmli2bvsidFypqVTudeJIkO54jA1zkNxkhOjuYR5etoVvaWaqJp3Lnx9IyNUOXmSeNzmdssDG0vP1nYcGWvwIEAf4i0dxz6k1ncRmy7DtYaQaW7NuRPjmJYEdisKp/ICMJfmQpehvrvzFem5pQJFUbAgxc2CuqSgL2nlLP/fLkgvxFMTeLu4L33cO/Y/1RkDzfEJkjsxRujv0hVrR8iZcnorOSNwHFNPN+/mvSHCftN3pd43orseLjQUAPKWA9G8h9E/fU6dYno0sHk4X0Wu+4apt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/y8qMvQ2mbQgLhetE7+JSE+giOl4QGyTSnHAQq6+Tk=;
 b=hWXggvR+Ek7w39iuwQt4ezdqhXC9Al8FnBqeufjDCSc157DFGPVTZuenp3blsO/KVZTCJbyPMcO+fWVVPMWndpz1TaJ7W0y3djKSm7k90Lda4bgF1saDhvQLfxFpJzMY8Z7ZKTkltlNk/EeUmGertzI6PmiaBJiPMVdcLiY3YAY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF9390CCBA1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:30:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:30:04 +0000
Date: Wed, 13 Aug 2025 15:30:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 4/7] docs: transhuge: document process level THP
 controls
Message-ID: <fde39251-9432-43d3-b69f-3e55e3abcbf7@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813135642.1986480-5-usamaarif642@gmail.com>
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF9390CCBA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bcf65e-1703-498f-72fb-08ddda75e4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzK9Mci2fZUqHzxr1eBiMs8Pe4Ytt0VrfafdjpGlkUvw5GChg13ckjBwo/mA?=
 =?us-ascii?Q?9iJKArXbxQOoMCAltjgt8nL2jMgk0eKveMTzjfLDps/jtwJnjU/isae7uHcI?=
 =?us-ascii?Q?KON/0qlzJRTCjttZ8XpsfyoXoiogsGasKIA1el0eFdP3VcowEznIjwozV1hM?=
 =?us-ascii?Q?SX610dcyqpnD8q9imEnHfdBWbUkOqEGyfR2bQUbfrs5AbSsDO19WcBLcIw9x?=
 =?us-ascii?Q?Aovy7u0ztISqtIj8pRQ41WZ7W3Q8g/VTc5KYZQ/xxorovSnKqbK/gHBLfqft?=
 =?us-ascii?Q?UM9kzlRsAEXZ0xvwL6Gzy6O6luyW9ixc9Gn4zkH8QgsCKUsHK1te+sd+VAjT?=
 =?us-ascii?Q?QdXLD3KxlC7kWXLP2m9v0JBL8jK6Ja/TS39QHpGS4hP/L7lrGEOHRmizfBOr?=
 =?us-ascii?Q?P/QvJcEOJmnfzKeCc1BDEVKAcbVBsW/TXba6whzVJ0CWzoADP4Sy+A4qAv9n?=
 =?us-ascii?Q?LBSe3CgMvGHunvWKKor+vt1VWRs5zCd+dzL9BCksXdwTJ7c0YM0T5wePZceM?=
 =?us-ascii?Q?X6QX+sIjacrQnCmdAipiv8DqG5G4BBcsfZIadU2tC0O3c3rGnGB8vibp76SP?=
 =?us-ascii?Q?/XBJYjFjVcTTM9y/vG+r9JVnMvT4hTmhl73/oi4Xh8fHC1YULMVuQlMwNlDr?=
 =?us-ascii?Q?FsxsMlsdGTPDdc4Spc7vney69UMFqJtu9iIHGKfkWEGSwe6A60tHHBbbqgiU?=
 =?us-ascii?Q?EZZUl6bwyko4WEXb3665rLaQy8JpMliLo34WMmwLDDSKWI/7vtiq/CFGL2pj?=
 =?us-ascii?Q?mGVvvH5dewTY+vjJ0KTpAf6L4f54iBM9bjstX/+Vs+ZNDqa2w9lnsJxGMyFt?=
 =?us-ascii?Q?F9CRZtXOtSB4M+lkQUapEZJeLFBnXAhPEMG7Rooo0i7W+Em89p/9bqEFg50P?=
 =?us-ascii?Q?YZq/qXsimuZokACmzKkxN542X6u06RHyf5LS3MaoqS2W5dhhK44WXUIJI9EF?=
 =?us-ascii?Q?uyY1E4abEaOHaFFx9AB4dmx5F58fqQo6tA/KlsA7EnsMBeTn1ggxtZkVDqro?=
 =?us-ascii?Q?+rb+XJE0frOmfH7lw/7JrM9w0XATjrVA3+t1UsY2YjgRtDG6gkxTygSr78Dp?=
 =?us-ascii?Q?eHsQ5lFouodDBefGmn1wj1dCN5Cx+JK0546rl2Jw7kyMQ8y2tLSS99apscnA?=
 =?us-ascii?Q?2NVlxGeefR3xNivH71w1vv9k8Oofmcy7zRNozBBJ97Q6XgLwF2CmCYBfgT9Y?=
 =?us-ascii?Q?WC11QoFp4jFS1fiQjA52YdLdH0XpaAyaNAxzrda/ZZPCEF+AWNKWVvXamyXJ?=
 =?us-ascii?Q?qPTvYnAzUaT90iSThhuK3KoDAhIpI0wXswPMDxd+9cVl2iK6KsmPSi7TDTkS?=
 =?us-ascii?Q?Kg60uNIsyJv6Dp6gOHAi/HhTMgd7KQt8DCctLp0CurfFVhULr32j+fFIuj5c?=
 =?us-ascii?Q?gshHiZML1Q11MKxk5R+ZsHqQtQwdzaDbyeX2yC5C8j2oyWAB2xdpO0kxmEqD?=
 =?us-ascii?Q?krlHzUxjky4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qBhGqgKi9KfbwID+zB5+EgYNhW7FQctBvEWXg38iqfSQ2FkyHkiH99SyLsw?=
 =?us-ascii?Q?VctpJ2fYaE4EiHRYwef7jw6x+zFhicer1Wo5WwTo2+iyqCu9PFO8zFZZPZTN?=
 =?us-ascii?Q?rcBqbkvk2QB+FpwD5KG5NmDefN3kmLkb0VUMvpoJU+t8nNCk3Dj7qLrPrwvH?=
 =?us-ascii?Q?dp7nj2Vns8jikQ6inqd/TjQ8/tRd374UoMXBpTz5vyGOQTjVDk3mdrKh8TYT?=
 =?us-ascii?Q?65gzK/R+TBHOjYyglv6+WewyjyKMaguPzRCZOXtp/PvTY4RreVO0TOGMFboK?=
 =?us-ascii?Q?N4CK5jiuGK2loZ2CB8BRuJB7B5r7wqdT/ojKlACZWm3YLytpfQMwCMr90ycg?=
 =?us-ascii?Q?st7urxK4cuh9pljrCxGuLiaZ1Wr+/95kv9jtFZbv26dYE7sNiZdmy2yFtMqg?=
 =?us-ascii?Q?9RBzPedwIziMqd18lBF7g4R7wQB6qXh0KgMPA1+quvV3p0Jtru1ttz+4Q9gv?=
 =?us-ascii?Q?KgqAd9bYKwv/6REdbI3whOS5fOzRyccl22K3FIijKVuhjPL6wvCkMzDHgKmN?=
 =?us-ascii?Q?ss7tIg/22+vyAPKknTqrLC6aN1qWXiDuy0YMzvrjkLMSB8WDcet0mBzPQuGA?=
 =?us-ascii?Q?Jx1aufsWbfnldoTKVarWVR5ciq12Wcc5pLBer8ZDC87DAeyDshCjf59SqySR?=
 =?us-ascii?Q?xiO2slCTbV5I4EuWQoD9CIibEdGTVPhMp3q0p5eDBPNKMR3KIhMe6qpJ4V5+?=
 =?us-ascii?Q?xRVvf7pUTmpS5boYcFELww3nPgczum1ux20N3nvUdx4R0yflj5sGtijhE3aO?=
 =?us-ascii?Q?IC2+XCZ7vma/5+jmQmh+fID743aLIFfZsLeGgBpqzG8Qhef7B1jJv4Ctha54?=
 =?us-ascii?Q?O6MdVGSr45bzzYCEBIFb6lRIO7Kc/or4iEIa0OhkjY/OZnbaJ6GnETczuhPm?=
 =?us-ascii?Q?zPWZyley3ma9xyB8fKsE6OQSAIRVCe9Pp/Xg9K2bifFf9GavLCz+jSrH4pF/?=
 =?us-ascii?Q?9Co1M13vMDbZm/U/KS8a0rvHqatAJZA05dO6CjnznhEgSoEt9uA/NIViTxEM?=
 =?us-ascii?Q?BGqCCQtmHQsgsNzrA8UaEXTRK9jwOWN39E9o8Sz+7Fq8zj8j/DU60wEghw+w?=
 =?us-ascii?Q?B9z6WWy87lBjlC7ND9vuZ2AGAl+Y1qgPyW1pjV6PQGLsSbor4K/xdIzjen4P?=
 =?us-ascii?Q?zVAPVcohTz8Wasy6/nSDcnkPDL+OPr/yoV46T/pCFp0+AnFnDS637wXUMy4x?=
 =?us-ascii?Q?tgoNvbB5POGmijGzy1sKAdrMFfAiB8tIPNxwnX6UH6Y2QOLBczalE9V5C8Np?=
 =?us-ascii?Q?rIjTTnTY+Js7g7UjLSZe+suL1aHyNENmqy7JdQkqAuuUk+cf4kloD9Ys06j9?=
 =?us-ascii?Q?kUy3nZd7t6w/Ki88Wy4xmjsuCtnTGZPFudw2Bxfk1sJ0Sp4SnRqx0TcylR5E?=
 =?us-ascii?Q?wxsmg6sa2lpfE+jfEtGcur5opjPFGQ5DjI684PmOWwhD9ZbtnJNMIqMxJDGk?=
 =?us-ascii?Q?ojh/mYbkobMj8rzn7THYp/tWwalaYIYjU8oDcu6CmHwySLCYUxcuF+vwzuh+?=
 =?us-ascii?Q?IB9RMc0SGapHiQvkqnsBE3Ibg5TGRMe7NaQllxeqyH9wT5NdnGZl+RtGwjrS?=
 =?us-ascii?Q?tyCo03T8Ng+FU41CmIqZWinStbNgAz3DUVInfr4aW/1mcdGP9cZZ3hcgnPTN?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w6zwXFplpyW58WJDRzD1m6qzrexxzuNE/PJQ/u4E2mZkklUQSEaoj8h1LuW8liKWmqmIAF1oTrOyM8AOmgRY/LBkvFFvtXUwcbs2lV2E/4RfRvFYaW5VuPFjo7k8ey0jsZ7My6XGxkAI/i62DuNUtpKaig5CccDrELBDuT/rmLOsZfsx5NmdcHYvjb3hTjw35Oi0h8N0XEAxetyomlqCmg1YbNYsa2TL2THRB/2nToaHW16pQ7rsHtA48Axj+VyG7shR92gDIb2IHLiO8UJ5/jrjjVi2rkakzpt2UOX9gWLp4iPPCGE/SAsbkROa12ml4dxO/GI/uRyUusNjcU/EkcVEdtFkKiLw4JNOjZOb7R552gVrbdAyuU0ivpctIDkutXAxvgH5j1Jvb9KVnd4zrJcMjV3hPrnBleTq+jxZe3IK2d020Ou8SKRN7GNQYYIoh7ZdQWxye+oQCENC8u7WrCm2dbGNC6oEfmXURA6z3cj9YfR3c7EliAnXZt3p4ZUw59c7eWUYueZXID5UF9dU2k9moH2ieftXHGYXYqjLmnB/MFFuONcb85F6XtnbONyT2pSH+PEM5LMS+KZbao+OPh9i16ispeeh8nfkbCLEmyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bcf65e-1703-498f-72fb-08ddda75e4e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:30:04.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvetGaTOJa/B4CqaXec0dezmuqLsKp3VWY+TqXvKpx4WOAJlroKmneagdpJ06TlXdwUasNtlfBffAvkbgUChpneuAm97RlJFGE0tcbJRKdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9390CCBA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130136
X-Proofpoint-ORIG-GUID: -fhJi65tH8xxphKaAqWoQ5pYGyXa9oXf
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689ca172 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=i246SMLqQT06k-XJdMcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: -fhJi65tH8xxphKaAqWoQ5pYGyXa9oXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzNiBTYWx0ZWRfXw9e4NLfzS845
 8ZlXPmtfZ/GB8Yd+GcHaplm2PCyoyFjOF4X5LOor6dfLxaX71JrnNp+TK7p/iKQ4h5o2ecdOuRQ
 l4bPopMIfFD+5Mh3JFxRNsKVGyfZ1ow9L66AsViRwL9u7qX8bQfUvVxWpu7T673slZaXXVS0kqb
 MTUyu6S2JrOIwLIgmmJxX4CW+6OUMDGfQUGNBH23mp0FUet7sUz3Lm7b7wOcgTFJsv8qohO0Gh6
 pu3q/SBUrciIyE9hGJQ0ijF4DnD+NC33IbQ1oex6I+mwPsiiyowET1wRqPxLy4upKmh6AgCPNQe
 7eMCT02earu6Auo/MEWDHOqsaVhznBBZWLMeKiJ5sF8vLi8MA/Mk+HbSi5fKyf6JuXQ0bsEE5ty
 rk7WivOv4DiduoseV8dInz7044ktg8CwVoEO052WJKclfetzogGghJdGS3n5zkhCIcHguKWe

On Wed, Aug 13, 2025 at 02:55:39PM +0100, Usama Arif wrote:
> This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
> prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
> flag for the PR_SET_THP_DISABLE prctl call.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 370fba1134606..fa8242766e430 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -225,6 +225,43 @@ to "always" or "madvise"), and it'll be automatically shutdown when
>  PMD-sized THP is disabled (when both the per-size anon control and the
>  top-level control are "never")
>
> +process THP controls
> +--------------------
> +
> +A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
> +and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. The THP behaviour set using
> +``PR_SET_THP_DISABLE`` is inherited across fork(2) and execve(2). These calls
> +support the following arguments::

Thanks that's an improvement putting the bit about fork/exec here.

> +
> +	prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
> +		This will disable THPs completely for the process, irrespective
> +		of global THP controls or MADV_COLLAPSE.

Thanks for including MADV_COLLAPSE aspect!

> +
> +	prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
> +		This will disable THPs for the process except when the usage of THPs is
> +		advised. Consequently, THPs will only be used when:
> +		- Global THP controls are set to "always" or "madvise" and
> +		  the area either has VM_HUGEPAGE set (e.g., due do MADV_HUGEPAGE) or
> +		  MADV_COLLAPSE is used.
> +		- Global THP controls are set to "never" and MADV_COLLAPSE is used. This
> +		  is the same behavior as if THPs would not be disabled on a process
> +		  level.
> +		Note that MADV_COLLAPSE is currently always rejected if VM_NOHUGEPAGE is
> +		set on an area.
> +
> +	prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
> +		This will re-enabled THPs for the process, as if they would never have

Real super nit, but could be 'as if they were never disabled'.

> +		been disabled. Whether THPs will actually be used depends on global THP
> +		controls.
> +
> +	prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
> +		This returns a value whose bit indicate how THP-disable is configured:
> +		Bits
> +		 1 0  Value  Description
> +		|0|0|   0    No THP-disable behaviour specified.
> +		|0|1|   1    THP is entirely disabled for this process.
> +		|1|1|   3    THP-except-advised mode is set for this process.

Thanks this looks great!

> +
>  Khugepaged controls
>  -------------------
>
> --
> 2.47.3
>

