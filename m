Return-Path: <linux-fsdevel+bounces-61762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86AB59954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEBCE7A6AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D2A369980;
	Tue, 16 Sep 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdpNnmeS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXtxg1AK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652536934D;
	Tue, 16 Sep 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032058; cv=fail; b=R2xlZQVfgvBS1qtvd9S0kCd6kIjQvpWVqLB2bcfCO2+DmAhHVFecIXVXln/2V8KqPYsZXs2fPBe0Qea/cAY4r6thBup6roVz4wMfGkp2hx4asNw0dGUo4FxePTYR63F8/qYXCk1anzJtUYMPZW+cQCAltHkEqBgj+HUpEA9W6Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032058; c=relaxed/simple;
	bh=KGdmBihHuOdaDlp6lyMrzeihdTHkcBoyemyHoKN4HnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CrN0OYNIjZJEVyg7hcqHAZd8qJaziku7lX8Ugt0ABB6C8bTSUjOfxzcvwnFBwrM3WheTbUQenCEtTsP8rzDMFSssvvHpSCHP2F33r9KEYdnbFP3OMmtilZcYtzQRkPRrATB4+wCGFNPDypgUVF3k9HggmobN2nuBlS+LIvollNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KdpNnmeS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXtxg1AK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCwka5021987;
	Tue, 16 Sep 2025 14:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b33d3D+U03qa1jp4XjWJx6a0FTPGIni3R3hyQVNt4Ls=; b=
	KdpNnmeSuZ+OWkyGqaKctq+Le6VfJhbdfuZSDWOBwmvDpdsYo406gT1E1SjGR1cY
	/HFL7h01bpEHY9A+IAe5b7GuoETcj3yL1qEi49SQ3aQLA2xO9XB19yqHuLnh9clp
	oHmFcWrJFWvTDn2ByGbM5lT6CB6HAL5ue2VNB5GioXm4cPlDd2tZ7uE2/2qZ6rAb
	yu45nbBIsApbNkhC11KeVF5td3j0+fQFG9AHpPlo7trUbQUs65fSO5GhF549xzXe
	QKHqTnRv8/hk2iZ2g/iQ4a22DIbLanTcl68oxjJLNvx2djFjda7DAycX9Ll39DNO
	tdV1nrjSm2Acrs1fY7bCpQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yd8msqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDfijV033734;
	Tue, 16 Sep 2025 14:13:34 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ced7h-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLSw46qD8RbTYoQljGmGiX0eefh0rd1/uX7k5fyIajnXECObhJxTm6ntardSgvalOeFaNA/FE4BzR10TpyMYhooJLKbGdZDYu6Hthg+QbmbI6o9xs16cA17M64+oAl+zCwAU57qw+1UcMYs9aVbN7IviEzgPlpWyPJlFuCJOmKkgnsiSAHWR6y/6KFkiFiQI+tixpvk557XHkHpXsAbi1LipxnWg568XCJiFrpOToiGCIcjuPqkgenmoxAcW6ByJNvqFERtU8BZO7RQqNiJYMhoH1DkTSseGUOvqz8yU2cOuHKLj6o0pl8Kp64wzRHfoEBlvJp7BnrN3wX7y0HxztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b33d3D+U03qa1jp4XjWJx6a0FTPGIni3R3hyQVNt4Ls=;
 b=JZCaAHtvlSG3eIjHVekOFNGaB/tvt3MBHuowppES/RGy/sejCDRo7V0fUp1B6CQMQTguzvJel1KTJrqach7Ct8MC4i3w39VXrh6dZ6ea3orj+E2ytd3+bQkmIp0no1TbgR1l8Omm5aii5zNDjsogGZBAHRx38qhlraDQlC7E5GSaJ+8yIBWNy2thB33ovNDjE/hqcHAzaPJi4DHTxqQPrLMDfwWJCjHNr0eGQkIDqWy0aTJqVyXapFufCeISnmM11vSXDPakpKFgJimSWVCGERTYIyc5PCsKrng+ooqKygR40oLHym/Q91MNjJW8if0uDJzEq6sYbvEfPl+yJA3QwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b33d3D+U03qa1jp4XjWJx6a0FTPGIni3R3hyQVNt4Ls=;
 b=aXtxg1AK/OL4togyLRKyu7wCV8RUSSl6MCXHEbFtbAyOyUXz+nizDlc/hIEaqV1eSC0aOOfPJ3IDGbwcv4PXeQUJsaZP7UydJ+RGy6/bYWDUHCQmFesfo4NqqopdSfSu7VwdjTMfzmZfIm7L5yT2f/hp4eDPig94Sm3hcsB85Nw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:13:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 11/13] mm: update mem char driver to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:57 +0100
Message-ID: <03d4fce5fd356022b5af453fc5ab702c2c3a36d6.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0399.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e731dd-80d5-4098-38ae-08ddf52b25b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7nYAEGUNrJxKlwe1+Qm9shd1IaFVP/CaG16EDGjHRpJlB8u6OT9VhtB5UsU?=
 =?us-ascii?Q?z+pXxcqpk72M7I7VKyXmtoepKFILUcN67uO8kRJj7PaarB+OCKEUyc7U3BP5?=
 =?us-ascii?Q?eWrXoYMsB2bPIoWnENFnRppDLQ6rKg2cNeQv1Nar1jrN++921BlEN/AaMIU5?=
 =?us-ascii?Q?9s4tnlq2pm1FZ4YdtHh9r5hW3zdZW6+vXwZGSCnRPLiysj0sQJpZSSd562uD?=
 =?us-ascii?Q?Ysssm7biViscPsude7pTWm0SYX/ZpjUgiHWe0A+S/KzZ6Uwlx9V/4YPCFu7v?=
 =?us-ascii?Q?hDFSjWqKb7QYTYmRRxFuJDkts0utTdcPGVoK0Rqyagnm4qnIZNyvoHmpDdI4?=
 =?us-ascii?Q?BSAzweHJwx98mHHtyg6cu1ihhq2V6/YMZYZZSnLO2V+vLb1/ceBfQhLlaIKp?=
 =?us-ascii?Q?kHOA6cWI9kE51LaWQ7y4NLe4E6jJOISiRO9HsLM7QYpk9Dy0i2xNSXDzWlfn?=
 =?us-ascii?Q?lPyVjbTOAy3NXg04VuqezX1AUTxHZ3WvJXneMjacTaYX6uA7bGh6kR5J1EhX?=
 =?us-ascii?Q?0604WBK9sD7gpuLvcg4sTLW++EO+y0Zg3z02fh+rMewNWlscX4ok5IZkZ0rX?=
 =?us-ascii?Q?Aws4Tfz+UtK4QJhp9cITAQud7CnAWMOJ44XQvHp/tepMRk4UJvbdgL4SEnLM?=
 =?us-ascii?Q?7v6sETSYQAYOSK77reb/WxZ9JBYNBQJC0nVHVmyziEW+tX0Vh8TVMVAXDp8y?=
 =?us-ascii?Q?RC3lOsgkd0svgIa5PLkJzl2rBAgGH1CiyrI9lqL+MLeZ8FyLl08Uir5qwrLX?=
 =?us-ascii?Q?EPG645/3j+j0cl1eBSTrPFaKuO4oXnTPRoqQrO9q/WWqsv2Ge0bKHeduZ+dX?=
 =?us-ascii?Q?XxkOX/pmzhIFrxTgAzhtuAXlXl7ng4pXCF/WivX0v8qp38vG/v4WUoN8DbOM?=
 =?us-ascii?Q?EDpY48TvNCTxsPCeU2leLv/lXzGNslWeI+Wzt5L73OttgWpXUYy1eRbkL+5Y?=
 =?us-ascii?Q?o6ZuNILt6KaEcuc8CBqzRfTEv6tswwFQaWxgZJ3+2koDvBRJcdtnefpoIhcB?=
 =?us-ascii?Q?QAQlro6v8n+W6QPgayjAk7z+t6vWywzGXgebvrA5RrBolgHbr37a7HqtYiwz?=
 =?us-ascii?Q?WpFmIMEHefyiQ9UagIIQlSkiCkH/8w/Ysg1mVGJ9iTGy2+it4pVEnSNQL6Nz?=
 =?us-ascii?Q?YnWznfPqZd7EN9E2xup3bcGU0xxRlt4pfN3pw9fURMrS+0VYARGKEEKMV++q?=
 =?us-ascii?Q?BxRLQ7cO7ycR03Ics6sKfy5U39Q+/VOS8qcVtF9fbBX1IJaSdSvVFObwcSmv?=
 =?us-ascii?Q?g73eFrmeIxH6S6/I1O1Y4gJav/jWS1haPnluTVgyEvvYTqeixV5lAZxMefqi?=
 =?us-ascii?Q?InezUnzvscqDuBJ8bhHSHXsfqnAe/YMm+xCmqHEkGTwCllhoIrEh7raCrqZ+?=
 =?us-ascii?Q?iCQcXhrivatJRnkI1INVfHZU/siE3wAoY67jG1DktiEESyoWl8UOrKMrIL1U?=
 =?us-ascii?Q?/ld0pohC53M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ou6ZmABBQXQzJuJVkq9vKfzC/b//NUADi2xCZnx7pGa+Z4LvF84ewitEmQ7F?=
 =?us-ascii?Q?A01kI0F4CanJfsbGJd2poHzHZzMbw2uDZhorwq2ggGs3aZ4hxKdURXU8AHHB?=
 =?us-ascii?Q?3gyPGitd6BbEJFBIf2XyY3k6LreMD0/22oLRw+btPhoXNpcetvbnoe4PQ2Fr?=
 =?us-ascii?Q?X3skrI/96zh6V3gKpwq+By6gq9S9iIbNaAcTTYh9Gj/QebwNwl8z0PlMzRfm?=
 =?us-ascii?Q?7EnDm46bqg7uKCTz2s+CF7XaGTjCDmWNyCY+oLuTZJq8kaSAiYDM1NnG8aPT?=
 =?us-ascii?Q?dOS5WW7ILweAngvC+d8rP9BwSThW/79eggZotRTRP7nEK2zGFu4IbfuFJ8bQ?=
 =?us-ascii?Q?oS6c3dlTQ7AxzFQobsMbHXTgPOlrQuYYjS9PUaYaMFTOrnEYJBmu6jplNnmV?=
 =?us-ascii?Q?aGvHGiR943NzXs4Vivx80StefPRVKt7gqkcEGEbl/D/skkEEPOIfS7wSygiK?=
 =?us-ascii?Q?6yO8isJvqHlZgnFFPKrRyW2Y2973mJZDblpCDmg3HXNgXBkonFIuGLEkWm4e?=
 =?us-ascii?Q?LigtW081pgnxvZGhL8acsOIqRQa171TV+fv0Ld5WBk43LJvXK2tlSRbU9JSz?=
 =?us-ascii?Q?HFr6o8oQI+ZhzmxpYhuZ3bkihU986BW6YvDJb6w52umabo1+rFWzNVcPdHn8?=
 =?us-ascii?Q?CvgvjTJWVvAofuIKBz9eVyy4Ffsy5RIfQaOMOy7Qc5gDUWMJgmnF/tR+h/Si?=
 =?us-ascii?Q?PzRaUzHpsnHQuWbQ6iTol5xorfZVdoL1jh54lSOjeOx1Qm6EqJSVq9lkSKgp?=
 =?us-ascii?Q?zRLd7fSoIs674utcHimHU40DC7E2AKh+3UVUE6aojuoIBCZpjl+izfSwWsqd?=
 =?us-ascii?Q?3PoNAGET2cA8IRYA6JixPvVY7WJrNQifesETsGly++rFTQqrLMUZxqGy9i+v?=
 =?us-ascii?Q?1WOG8FldWbx+muCeQ82Rud4xyPLuPrpK06eQxIQhpqgl1Sbmv5Z/b1aWh3GP?=
 =?us-ascii?Q?BeEpp6l7nck0CLMIshtWH4J8k6nOwIHmEL0UD6FF8fgJh1J1Ze+RArWIW9S3?=
 =?us-ascii?Q?vIwnOpMZbVKG29CZLmo9cmVM4FBvXONWgzkyL9fy6DuNiENFHf+h10Cy01vm?=
 =?us-ascii?Q?o5pXmbZCyTDEiwZnkqXmzstYj30tabf2flxjMtMqmdu4kq+zXMB61KonxuSS?=
 =?us-ascii?Q?Ipw+nvv39tS5JF0FGvA1BVNrYI5Jk97mhKvZMO3BViogPGkKSD8gWFZYYqyx?=
 =?us-ascii?Q?N14YjbrTfnLg26P/0pAJljDbC0pNB79ln1BujQDFIVEwaum71/vZ6xvyUhxD?=
 =?us-ascii?Q?ZDoNbe8HOMrH+Rv+8qHYHcccbaQ67AJ86uewxW9gQfsR618HsvsOkq2HN9XU?=
 =?us-ascii?Q?kklZn+Yjp/Sbp8CJ7hJ8zmIaIMQaRGs5ubFFjseEXvn2XuQHrQG5vgK2gnvC?=
 =?us-ascii?Q?dI2BtIWVTpqLiEfwKrCkARpMVv4tR8ugqHb/Pl+1mFH7p/VUEbk7+GzUgLHM?=
 =?us-ascii?Q?7pEDIpH1KWD0Tvg7XqLHRbdBHzOGhf0YoLFQam6BlAPmnEwJdCTIIODvx5d2?=
 =?us-ascii?Q?bMyLJETOpIXOKu8b+paIjJAyKPmz43bGUxz2JZtwp630DB0dShQglnE310Ev?=
 =?us-ascii?Q?AFms7OgUjf4Z5r8Azaf/sfEEn5hM0NyFTfvgKBxNfv+LbnW4fHNVVtctiwfj?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MQIYlNjiYcInfuekmLrqyzKznvrO6FhPZ3r2kpbivAuBRGaZ58Sclvh0wRgRGt0mMCWE/XNOrklQLW1ArN203w69sxfjQmJitcrItoKfW0DSuZfIUq95/9+JIs3oBSdjtCS5cNeutUAuAcrSQSJWal7jOUh1RJttxHSBw8PN6f3syUqADy3gy4TK9imfX+z6VigR07qkLAxBXZ/GGu05Cb2jvLvuhd0S6wHdOrh5n8G2X9J2bbxa40PHFkFCJRIqVttLvpplau1fxER0PrH+AZx39/DAR/Vc3FOfvHfRhlD5jM0u5h8/G6906BWLJftqY7lip4jSN0Qna/LYmx7ECkJyquG/JBTQ5y7D675pfU2aGv1LSGPJ1XZsW7nf0mLjpVXTEUvoiH3S+qnqx3N1wdm1kYZ+JUhmxJVfK4q/2CYSGi5Uy5rwFNtYGVh8kBdZD/XXn73M89hHC9jxB1wJIghOGM5CIRAhpTpU5qOJtc5G1splYyHFotIPNOBs3M4gEO1s3p6CvL8tsnjpnkfNMWJAu9odWhcoWTk1eUL/DQQVj3EofTavzNKxKgmfC9M8cPK4UB65eM8ZM87JOAnb7U7b4IjXyqejUevLW8Y5Nns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e731dd-80d5-4098-38ae-08ddf52b25b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:02.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9eZ7Vm5AY+p19/xyHaveBIAqB1ylG3Q6bdqkWN9AcHeLA/SnWAl1rqpgel2fGpv1lpltWE18Mz8Fg9teKJEK71wZHmt6X+caWYdaYbY9r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Proofpoint-GUID: dUZGsKuT8klOIU1MhUPhA72VIApGRhzy
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68c9708f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7X8Cq549UNVAXTOeWE0A:9
X-Proofpoint-ORIG-GUID: dUZGsKuT8klOIU1MhUPhA72VIApGRhzy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNiBTYWx0ZWRfX8j06gPEWBKud
 OPljl1DwU44ZKN7FcmFsuZExR4bXrxIRyCRO9FQwtShIO7Re1NxnpAigHy5p6Eut4LdRZ822ZHe
 ezEHw6QvWFaHEManFYAADUCj3DFH9VRhkKSh23w5VHgtNVfwHwAz1mopsOx0wJtAimOzdDQl4BV
 sBRDUz/LFSlYGMms8OdQ0kvdyj0kDGKKgNA8za+DASSHbPk1vnTckL7hdKwpWcQCofsnsZZJZmu
 F1D9WIFI9xL9DKkVJw3/UJYW3/MVTf1vfojHa53MSBQ93CKakiiERFD5C3sNwogu3WEGtj7C9iz
 IeMFMYtS4zBGIr4jrtX3mHR9QByteMEAUthnGNAiiOxEPqeBrvJ8gzCA/e2tm6BavMmTRvd5Zhq
 Ho3Ssd1F

Update the mem char driver (backing /dev/mem and /dev/zero) to use
f_op->mmap_prepare hook rather than the deprecated f_op->mmap.

The /dev/zero implementation has a very unique and rather concerning
characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
when they are, in fact, not.

The new f_op->mmap_prepare() can support this, but rather than introducing
a helper function to perform this hack (and risk introducing other users),
simply set desc->vm_op to NULL here and add a comment describing what's
going on.

We also introduce shmem_zero_setup_desc() to allow for the shared mapping
case via an f_op->mmap_prepare() hook, and generalise the code between
this and shmem_zero_setup().

We also use the desc->action_error_hook to filter the remap error to
-EAGAIN to keep behaviour consistent.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/char/mem.c       | 76 ++++++++++++++++++++++------------------
 include/linux/shmem_fs.h |  3 +-
 mm/shmem.c               | 40 ++++++++++++++++-----
 3 files changed, 76 insertions(+), 43 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 34b815901b20..0136b82c2a29 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -304,13 +304,13 @@ static unsigned zero_mmap_capabilities(struct file *file)
 }
 
 /* can't do an in-place private mapping if there's no MMU */
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(vma->vm_flags);
+	return is_nommu_shared_mapping(desc->vm_flags);
 }
 #else
 
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
 	return 1;
 }
@@ -322,46 +322,49 @@ static const struct vm_operations_struct mmap_mem_ops = {
 #endif
 };
 
-static int mmap_mem(struct file *file, struct vm_area_struct *vma)
+static int mmap_filter_error(int err)
 {
-	size_t size = vma->vm_end - vma->vm_start;
-	phys_addr_t offset = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
+	return -EAGAIN;
+}
+
+static int mmap_mem_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
+	const size_t size = vma_desc_size(desc);
+	const phys_addr_t offset = (phys_addr_t)desc->pgoff << PAGE_SHIFT;
 
 	/* Does it even fit in phys_addr_t? */
-	if (offset >> PAGE_SHIFT != vma->vm_pgoff)
+	if (offset >> PAGE_SHIFT != desc->pgoff)
 		return -EINVAL;
 
 	/* It's illegal to wrap around the end of the physical address space. */
 	if (offset + (phys_addr_t)size - 1 < offset)
 		return -EINVAL;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
+	if (!valid_mmap_phys_addr_range(desc->pgoff, size))
 		return -EINVAL;
 
-	if (!private_mapping_ok(vma))
+	if (!private_mapping_ok(desc))
 		return -ENOSYS;
 
-	if (!range_is_allowed(vma->vm_pgoff, size))
+	if (!range_is_allowed(desc->pgoff, size))
 		return -EPERM;
 
-	if (!phys_mem_access_prot_allowed(file, vma->vm_pgoff, size,
-						&vma->vm_page_prot))
+	if (!phys_mem_access_prot_allowed(file, desc->pgoff, size,
+					  &desc->page_prot))
 		return -EINVAL;
 
-	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
-						 size,
-						 vma->vm_page_prot);
+	desc->page_prot = phys_mem_access_prot(file, desc->pgoff,
+					       size,
+					       desc->page_prot);
 
-	vma->vm_ops = &mmap_mem_ops;
+	desc->vm_ops = &mmap_mem_ops;
+
+	/* Remap-pfn-range will mark the range VM_IO. */
+	mmap_action_remap_full(desc, desc->pgoff);
+	/* We filter remap errors to -EAGAIN. */
+	desc->action.error_hook = mmap_filter_error;
 
-	/* Remap-pfn-range will mark the range VM_IO */
-	if (remap_pfn_range(vma,
-			    vma->vm_start,
-			    vma->vm_pgoff,
-			    size,
-			    vma->vm_page_prot)) {
-		return -EAGAIN;
-	}
 	return 0;
 }
 
@@ -501,14 +504,18 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 	return cleared;
 }
 
-static int mmap_zero(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_zero(struct vm_area_desc *desc)
 {
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (vma->vm_flags & VM_SHARED)
-		return shmem_zero_setup(vma);
-	vma_set_anonymous(vma);
+	if (desc->vm_flags & VM_SHARED)
+		return shmem_zero_setup_desc(desc);
+	/*
+	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
+	 * of /dev/zero anonymous, despite it not being.
+	 */
+	desc->vm_ops = NULL;
 	return 0;
 }
 
@@ -526,10 +533,11 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 {
 	if (flags & MAP_SHARED) {
 		/*
-		 * mmap_zero() will call shmem_zero_setup() to create a file,
-		 * so use shmem's get_unmapped_area in case it can be huge;
-		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
-		 * so as not to confuse shmem with our handle on "/dev/zero".
+		 * mmap_prepare_zero() will call shmem_zero_setup() to create a
+		 * file, so use shmem's get_unmapped_area in case it can be
+		 * huge; and pass NULL for file as in mmap.c's
+		 * get_unmapped_area(), so as not to confuse shmem with our
+		 * handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
@@ -632,7 +640,7 @@ static const struct file_operations __maybe_unused mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
 	.write		= write_mem,
-	.mmap		= mmap_mem,
+	.mmap_prepare	= mmap_mem_prepare,
 	.open		= open_mem,
 #ifndef CONFIG_MMU
 	.get_unmapped_area = get_unmapped_area_mem,
@@ -668,7 +676,7 @@ static const struct file_operations zero_fops = {
 	.write_iter	= write_iter_zero,
 	.splice_read	= copy_splice_read,
 	.splice_write	= splice_write_zero,
-	.mmap		= mmap_zero,
+	.mmap_prepare	= mmap_prepare_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
 	.mmap_capabilities = zero_mmap_capabilities,
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0e47465ef0fd..5b368f9549d6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -94,7 +94,8 @@ extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
 					    unsigned long flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
 		const char *name, loff_t size, unsigned long flags);
-extern int shmem_zero_setup(struct vm_area_struct *);
+int shmem_zero_setup(struct vm_area_struct *vma);
+int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
diff --git a/mm/shmem.c b/mm/shmem.c
index df02a2e0ebbb..c5744c711f6c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5893,14 +5893,9 @@ struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-/**
- * shmem_zero_setup - setup a shared anonymous mapping
- * @vma: the vma to be mmapped is prepared by do_mmap
- */
-int shmem_zero_setup(struct vm_area_struct *vma)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
 {
-	struct file *file;
-	loff_t size = vma->vm_end - vma->vm_start;
+	loff_t size = end - start;
 
 	/*
 	 * Cloning a new file under mmap_lock leads to a lock ordering conflict
@@ -5908,7 +5903,17 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	file = shmem_kernel_file_setup("dev/zero", size, vma->vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+}
+
+/**
+ * shmem_zero_setup - setup a shared anonymous mapping
+ * @vma: the vma to be mmapped is prepared by do_mmap
+ */
+int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -5920,6 +5925,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	return 0;
 }
 
+/**
+ * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
+ * descriptor for convenience.
+ * @desc: Describes VMA
+ * Returns: 0 on success, or error
+ */
+int shmem_zero_setup_desc(struct vm_area_desc *desc)
+{
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	desc->vm_file = file;
+	desc->vm_ops = &shmem_anon_vm_ops;
+
+	return 0;
+}
+
 /**
  * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
  * @mapping:	the folio's address_space
-- 
2.51.0


