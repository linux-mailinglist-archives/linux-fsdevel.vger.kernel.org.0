Return-Path: <linux-fsdevel+bounces-54055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48201AFAB04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9775189D352
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F844275AFC;
	Mon,  7 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REwHbmLh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xLLtHkOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829226E712;
	Mon,  7 Jul 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866215; cv=fail; b=b8nMQ19PMlNTttV3SXCCbGRIwEGgB2t/doE3Ky1F97nMTuP7hIaC5NVYsJktzPmT0RYJtkPMSJ1apLHk51zq5ISgu0Z2w7sd6FI6/IR6O45RrdwhKXJr8RNL3aRX4o0AhKFd8ao6bet3EmCzPRbysI5KQtDrr7rNOjoazBE27os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866215; c=relaxed/simple;
	bh=eX3Bt/Q2HgquhsnAvOucKRuVpaGYip2k2QEYy+Ssdtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNFYrEvUD75xK08wHGfmN4p3H8duwcgPAOR8yG5hfh5aQUNopoWfxDIY6C2EJXgx6v8/lxsg/w9PyMhKlPemtdqlveEL8wDzAjQ6YZXGnPRe5uhoHf6u9HLUa2vFtdaaEqIlgGWhg6PL8akzCq0AmXnxQY6MHAvcVu9Ya4/G/60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REwHbmLh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xLLtHkOu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566NoX45012289;
	Mon, 7 Jul 2025 05:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=; b=
	REwHbmLhjdNP+Bb2cE1MrtKfCRqt0cfZ3f0ernmFi3SnWxGatWOItthBDSyu2Cdh
	PJJZBP6EXKuLZ9wBsZjvwheLcbMTpfYgs8rhl+QQUAF1ruTf8Q+9dKqBYjmBKCRi
	qlzHuLIHujSmPsi91uMAh2tj7xJAJv1EploXPnBYteCJl9lde16UFwX61dswmejS
	VEycD9oW5aoxxHABZ5fZSOcb4Fw+xK+lcjE2MYGrKbb+NCWC+K5zuyhO2GfXJE4x
	+/iWBT78n2sJD/LvdMDAbFe2KRBAr0KPY1e0zDKPYUY8yfn9u/hygD8iTGrh/2cN
	b4DJP9VwgOeUYAqbpQIZTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptyfj0vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBw024285;
	Mon, 7 Jul 2025 05:29:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnuegrLYwUBeTOW9fVRU8szGac9D1YgX0DUyX5qAQ/hQ7niE7yScJVesUHa74HZJAyKAUwc94y3Pw6tEs/J5YOykSVjF6cdDILUNX/5U8IhmMbR3doXQ0y7ofrA3L6rY6sum76e7ASW8kpe2Q1+XEiYr1tg3GNPCROsIG86uYCP1G/SPVI+YyQUpowYZTx1BZGCsUHBfMv3juLoPebupd0CAx7FmXL4V4ReE7LpfZYgJ7EUg2nE+OZ/XZSvAf5av+b1e363zeSojr58O5HNo6kM23kh5/oik8A2Te2MkKLsbkQzlhxew6sfmFPBfXhQJDQITeIL52JCbU8rSqbE1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=;
 b=ti96Ase7q8okmt+LE9AG3BY/Mg6595f34sEIuMek/4l7tzMU8ug6lvzfk+W5G6yFj4EhqxIDUADusQQ4AAnNBk+CRy9yaJIUpQLdgXuhpqJNV84DwKJQQ+/COJ+zhzBW4Z1BIRxKuQ5vIYaKJms1eHF5JcUhLZcFjE9a9/x/lWhrD2phxOM1+bzjZXu5vK38I89oi51W8+nGhd7kAaPeNSo1wmC+qRd20vmD/8FBcPJGMSMhh79ALnyimMTH7+A+Pbok1xRYxwhoZBXkmYHvc4GZX6PEVQu+e6YhNC7mSzp3b6ZLnDN7TeTuJZeT9GISwBt2Y+4KRc6PhSft6jqJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEMKcr1TletxdCHvl0D07RiYtYzAexLFvYg3R7snJ/0=;
 b=xLLtHkOudOALaCfF6aKlKFp//iZrSqH5gqrQyLIGSjDqoXu8uKTG4JvN09bdLWKktynFnxOzKZZzR9/uyCQWH3iYuhbyLWImrGrxGuY1yduoGkwXBjlebhYPOuldg2sMsrNfs8ao83niH2lv+NME87GtYtow7u9DRAqxsmmkqoo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 10/10] tools/testing/selftests: extend mremap_test to test multi-VMA mremap
Date: Mon,  7 Jul 2025 06:27:53 +0100
Message-ID: <fc6dd9a3ecde5e7b1808dcb275ca8cf843f0e0e6.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caa6c4e-27dc-4dc2-c5c4-08ddbd172a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yeX1KeiATtYcfLn6YcdZYiOvmYDAnQTKPjlxyLoB+OIbQ8EFPUb//ZdiXWoh?=
 =?us-ascii?Q?+648zRu4NlnyemLL/mGwOI8vapYQyDFNo64VN0Xu/rqb8+lMTjJSp3glbFnA?=
 =?us-ascii?Q?SiC4UCW805q6D2+prc5+pVqseBuw0uteGQvM5FfSpDzmfB2k7me5vGXlaX5m?=
 =?us-ascii?Q?cpYY8qwZVE7yK81TogpgCMUEvijsvJ9ur54eTKKfqX6BkrPTpI+b/fMm5grD?=
 =?us-ascii?Q?syboO5CPvinZJ4NBmq5Jakl2wXF/bMhrB1rWmk6S9z5x7kQPexgng/amH/zR?=
 =?us-ascii?Q?UIUkfbpmRxglFaU3IkX+6ARcTW6bZ7NbFdIGzLYbYv8712TRSdD3ybrTmqYx?=
 =?us-ascii?Q?xnPKpuD4ChrKVbpstXm7o4Nkub+EmiCsIIkdqQ9L4tbsMdJnynFXk94Erviw?=
 =?us-ascii?Q?hISAIalli/8+LenTgfdZ3xAuttwI26i2XtgKFTGK5QwbNMc3C99gfoN4+kJg?=
 =?us-ascii?Q?Jxzchea30vPXKOyTdK2qK3ziiJOISvSA6971UYLF15cvMVaUABbZiO6SYI8K?=
 =?us-ascii?Q?J0cnqwTRxITfG/V71CEWm8Fb+YnTz3bCm/yhcft6oI/HH/sEc9Nm8sJkmI6Q?=
 =?us-ascii?Q?Sbizm9/N9RgAvjkRh6ex6HltnWxgQ3v25FpPhMkyjYryp6mxncPJJuOQ6BKH?=
 =?us-ascii?Q?r3y7oDTuZEWfgjR99GIIRSjh/iMVwg+wiNtlVYbfXH1G4kqMg47SKWnuFN59?=
 =?us-ascii?Q?hARMruRNH7mR0WbXigG9yexRHMruNPTCmf5bMA8utHxIudsw+A7PQT8Yi5ij?=
 =?us-ascii?Q?j5WF9VH6HWDHzgI3Bq/vIy9TsHctFjpL2RZx42DzXhBl7mjzSuZxyUcTvcW/?=
 =?us-ascii?Q?JdXX/XvPV9afko0YqJAsar/5dwXfZ3GvtYhcsIjoT52tVg4YOz69oTWvL57b?=
 =?us-ascii?Q?bpnYhoxULGmeRuDLQWdGC5dAJvTBE398tukPCerFfFzqg8b3KnYHItyi4wRA?=
 =?us-ascii?Q?zEuZBpuEt5FKgk13QkIyM668oz156NKbSu25P3BohilgSK2PAGCMbx1urMzT?=
 =?us-ascii?Q?CzxxUC6QcErMvwKNqdgi0We8PpE/U9JxXiArnHW0UWc37r2MezdIyw5jpO/Q?=
 =?us-ascii?Q?Mhs+AhqfOXHcItBqnOTlqDXemwbAv+oku7nnfg6+dWuOy890C7cgUHnleGIl?=
 =?us-ascii?Q?T3V8dFDCO+y0BR1nmVG2RxbprUz6kkaaDJOw3R5fV8jsYy7peUOzOzoidmnX?=
 =?us-ascii?Q?B445CYfnaFb/Y0roUCJ6999BWzfMFkPOooXY32Yrd/Ty9J3CXHtGGXOlVnYY?=
 =?us-ascii?Q?F1rb4RLRFsUJvngmKj4zkvGFO9+di3j6VtPAQFYtD/+IUWCt/uHBv99sdxGR?=
 =?us-ascii?Q?0c1gbc+vNlCAyMQCFXCcZF+JCOsttGImug3ngh9Vp9fYy11bo66+8MI9ucZ7?=
 =?us-ascii?Q?WP3S2FJlhQNImy8H9vQId1Y1jtM6+reEgt8QpmqUCSDKsIf1oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HNQfq/XXmAlaCIFB66iEUWL5kEI2DyvU6RJVQGB5TUhWzdbojgIBSSkBnmN?=
 =?us-ascii?Q?8xwdn92ljSLfc64l9cIX27moMxzh4ab7MC6Eoz2mxdPCcRE7w2tKNKbI3gXm?=
 =?us-ascii?Q?PSdMoxIc9GPdwxtkjensZlzRL7VdQfnyp0IWf6HPj6NOzrPOIydvFiDaqQLT?=
 =?us-ascii?Q?mCaQJYYTIlO5yZFVK16ogKfX6QUmtRhiS7pMHnqnyb85hx30FUufjdWeTOAj?=
 =?us-ascii?Q?P5aFlGfr3kmWuMw6fPj2TKEYv7DdKttMuxyCG6qyBJQwXHM6nHivOi7QWMmI?=
 =?us-ascii?Q?ZmXNfheKmw0TL1JbR0J+FT5xrcwmhVTSDc1cQIlQTV4l+Sm4Gr7FpqxllkDT?=
 =?us-ascii?Q?HB213qoXvteb3bLVabrO1UfxknhnDxDIiAz21u0WNKBp/ouMHkB0xh3hHT4d?=
 =?us-ascii?Q?MJ5ZSEkYLqaFsbp3GDVw6izI5jLcKbzXJAjkDjeV+emVKG03/WcDeox5Kjy5?=
 =?us-ascii?Q?ixxWXg1xB8zimhgwaXHKhtLfQckwrCTPty+nzLY1DxopyYGWupvfVserjWfF?=
 =?us-ascii?Q?TCQ1o/N9IME8kEIyKYv7NCSZtp9jUP7zKnn4Ls8sLTRoK850s9VQUePPE/Eq?=
 =?us-ascii?Q?TAPXnOhWS5z83yRDOY8Tw/QdtSKny50Jx3C+bkh2W+9wEafIZ77pjPIPeWKY?=
 =?us-ascii?Q?whbrwLeX9IrB694La1s8fXe86rpcQLqW1IMuTYeeV6f+3bD/8mJNFi5kbXF+?=
 =?us-ascii?Q?vScZnrKU95dWDrKgAZhAGRKssGgoJj0IAQD88mTH5A3Vr7hmKDCwGY7MDUSP?=
 =?us-ascii?Q?B8jsEPb8PKCiHwyEcKG4AGkv46yPck/9129zQsNPigS8fUEQMjSrIWb6SykO?=
 =?us-ascii?Q?5t5sbCrw/y5ljBlLdLDUXmdPHiU0BzJvvPUTbxXeBvodcJW8ZO6Vy8lQDKxC?=
 =?us-ascii?Q?otHEZ+bGViodP4KGWyD/FcfvW0bPyjH4PoN/9V7meUxqXi3OWH0q7TQFSQhL?=
 =?us-ascii?Q?J9jXcYYlOt+blQzMirvpU4qzFJsev0MCEmqzZRoqGcJb5/ekTas3V/bLwkSe?=
 =?us-ascii?Q?NMjqnRdhSnIZwwDrjbROmeaapjtzGNxZ41orBcUn7ajhCcetyiGLmuu0AzRv?=
 =?us-ascii?Q?vTlISAMPKUBuSNLsHDTUGiqabkVgMXZfW5ey0VPF+3olAiJcpZ4a+7hjZRYV?=
 =?us-ascii?Q?LM6AwgkFh81RE3Ne+d1hMufJ0fpBbgZpaiT3xcJV+f+Ba3OTWy0hJidM0kB6?=
 =?us-ascii?Q?fHLyaMOzIRQy6gQAxVT5APg2prdboEDFahd6scYsDKasgFLW4y2E9U1nAUDj?=
 =?us-ascii?Q?On38ro9FdmC/aumxXBCuKhGC8TCss17mE3neK1Q3AbvZwwrJhKzZWJB3FtEz?=
 =?us-ascii?Q?N4uTo6/YP/KSKjfyK9dn/Sw1+YiDqQ49v7B3n8qZYA/xo4w1/FMiKjQZmX0m?=
 =?us-ascii?Q?c03rAjli1IPeRtbzr4wC5T8GkGN/gycgaZHHQ6EFInfLMzXHfQZDQFjnFCIs?=
 =?us-ascii?Q?JTj8UAropp7vvyFRkLCqt4oAI1fcF1aAticgy97h1tUfhuoFeF5c9OCa3lzx?=
 =?us-ascii?Q?6YXA2MkEXoUH/E++Xh81oq7xZNRMLBFA1X0Na/fSuY1T/zNh5eED2eqxqtDI?=
 =?us-ascii?Q?aLU4hZm+ruMTpN2S3ixW5MdDYjHuiNwVCG+jL2N4LhmGDtBZ1hgMyOO75+pr?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L1LueSL9HyETGNcm5r0Eie4Cs8Iwc6WKVRk17Vw+9mtVH3Dmfcgkf4+HwnEYTQYfTUhHkfHT8pE9aZDH+YerXCCknYtN+hDqCr7RmNyVUduUghwEWKzTFMLLedDJa88d+RvWviIebEhXdrXm8FYykRakaMh7kJYcS9S5m/T+PHijlYO0c3VXExf/KEjtPFLmx1BcvPg28EuIM5rTBrlf0VXxeoHBLBWggIDnVE93AggEg6FrBR/4rbaVogaCv42ztIlEBvgfVzUPkX6722YI56Fl+cxkTgyLdrpp5Bn+rw7+EjN5ts/yul7NxraHDnc4ZUYjWigy1qzv5oS0me8mSHybWsXxuvM3fyyHLtRs/k1+iHrFfBT/KiRsqhMXB9kpCUwH25JvO7RtP4qL4HtCWcig5cseuT2gsyLl1eVIVFtdFc/GKDxg6rFe9ib1dBi28BSrL9t1CQ6Q8xaf10OXdbvTFEH5zR8C6QMiySR8ZzpqDyy193YMGhonTNiWEW9Ao83yKiNtcTyjZs0fRu2uhnNjr/CqiWfmUs44B+t6ZmK7zotfoEIXqH049lpji3vYFDEHEmEj4sdHyYWg4w9UIITt2ueXZ6yF1eNRaD9H3Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caa6c4e-27dc-4dc2-c5c4-08ddbd172a96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:55.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpzYQeJ27u1qZoZNKu38Tn3I31/+SoGD75xaZMHXHCTXOyrVBKXymhYDq1wwWO0Qgd9Fq1xbc0uygJ8WQwfOo8XVHuKZYClN7SLZK3VyQzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=686b5b1e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GuY5gsdr9MwsYxRlPWUA:9
X-Proofpoint-GUID: Qrt-xRKm0-x2_V3sjSvFPW2zdhXLzBXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfXwCz4XukYCsjt c8faWRFEiyvYjxP2Ufd+qmncV18yxX8LFpFI5wN3AAYSFFiiR7AOsgUP8Wbnr5Em43t7O/JWYsD z0C4BGj44/LL6pNMdCJAbmmEdDwLH4EqadCkQvZHA2VZJ5wvw6+LWZsJsXsyZYdFb/2JgzJA14M
 PZyxORAdR7SmNuSHMUZsqfn4BO1WWceaFO8D6KkIcDQtI8CWz79DM4q5C7rPtQbvmE+XX8CNxnr ISf91WIeDO1/PBN3YKN2NxF6wb3y5BFeiAMzwt7MRLmr7rEZdbjnq/q1PVQW7F89ty7kyLCTRUv zCaC5+gtCRBLHuWqPhNrnY/u49ObU3kVrLvnEJwKG4IANoA+UHrpKAt8liRVcB57qvYg7h+Embx
 QNxEcYYhAIVyCbkJeArZhHeFlpSAOc/icwIAQw8HVRhQOZcQHgzi0JUpBfW1+RkGikGIaspd
X-Proofpoint-ORIG-GUID: Qrt-xRKm0-x2_V3sjSvFPW2zdhXLzBXH

Now that we have added the ability to move multiple VMAs at once, assert
that this functions correctly, both overwriting VMAs and moving backwards
and forwards with merge and VMA invalidation.

Additionally assert that page tables are correctly propagated by setting
random data and reading it back.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 145 ++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bb84476a177f..36b93a421161 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -380,6 +380,148 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+static bool is_multiple_vma_range_ok(unsigned int pattern_seed,
+				     char *ptr, unsigned long page_size)
+{
+	int i;
+
+	srand(pattern_seed);
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		char *buf = &ptr[i * page_size];
+		size_t size = i == 4 ? 2 * page_size : page_size;
+
+		for (j = 0; j < size; j++) {
+			char chr = rand();
+
+			if (chr != buf[j]) {
+				ksft_print_msg("page %d offset %d corrupted, expected %d got %d\n",
+					       i, j, chr, buf[j]);
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+static void mremap_move_multiple_vmas(unsigned int pattern_seed,
+				      unsigned long page_size)
+{
+	char *test_name = "mremap move multiple vmas";
+	const size_t size = 11 * page_size;
+	bool success = true;
+	char *ptr, *tgt_ptr;
+	int i;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	tgt_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (tgt_ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	/*
+	 * Unmap so we end up with:
+	 *
+	 *  0   2   4 5 6   8   10 offset in buffer
+	 * |*| |*| |*****| |*| |*|
+	 * |*| |*| |*****| |*| |*|
+	 *  0   1   2 3 4   5   6  pattern offset
+	 */
+	for (i = 1; i < 10; i += 2) {
+		if (i == 5)
+			continue;
+
+		if (munmap(&ptr[i * page_size], page_size)) {
+			perror("munmap");
+			success = false;
+			goto out_unmap;
+		}
+	}
+
+	srand(pattern_seed);
+
+	/* Set up random patterns. */
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		size_t size = i == 4 ? 2 * page_size : page_size;
+		char *buf = &ptr[i * page_size];
+
+		for (j = 0; j < size; j++)
+			buf[j] = rand();
+	}
+
+	/* First, just move the whole thing. */
+	if (mremap(ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Check move was ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	goto out_unmap;
+
+	/* Move next to itself. */
+	if (mremap(tgt_ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, &tgt_ptr[size]) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, &tgt_ptr[size], page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Map a range to overwrite. */
+	if (mmap(tgt_ptr, size, PROT_NONE,
+		 MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0) == MAP_FAILED) {
+		perror("mmap tgt");
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Move and overwrite. */
+	if (mremap(&tgt_ptr[size], size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+out_unmap:
+	if (munmap(tgt_ptr, 2 * size))
+		perror("munmap tgt");
+	if (munmap(ptr, size))
+		perror("munmap src");
+
+out:
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
@@ -721,7 +863,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 3;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -848,6 +990,7 @@ int main(int argc, char **argv)
 
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
+	mremap_move_multiple_vmas(pattern_seed, page_size);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.0


