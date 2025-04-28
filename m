Return-Path: <linux-fsdevel+bounces-47518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C893A9F476
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C707189A1A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734832797B0;
	Mon, 28 Apr 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvmJOmON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDqbEvSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409C29D0D;
	Mon, 28 Apr 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854298; cv=fail; b=A1UBUcWjSpvcYokgZ4RiNKXghRP1DVRdWzGfnySTutKIyphG52G1gmxGrJHW7EKVuY2gwBKgO/+vhWPqz76r6eeDm935vw6YO7PqrLbQjuuR6XO+sJRx4+ilCfGb4fsKCp4vZBUkMObuFRaoAt97X5YLUO2g502IJZCJ40oxMs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854298; c=relaxed/simple;
	bh=G9q5fFpZt2w3BQVsbdUq1o5ggLEr3bJ5+C4V8/9veo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KesKbmwMF5QLAESwCcDW6pBrJoHPbJy+j1R6B0ERKf89hQkEDjTqORjQpnN95B+UE3VI0wRLEt5YgIwMVvS0bbQ7gQ2hxjREQodWUgbu5cFADwsNuQsNtt82ptXy14P6B7fsDGKBUOOTPUPmDInCNKjDIJlGcTpz9tvH2nDqszk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PvmJOmON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDqbEvSf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFMtGv010745;
	Mon, 28 Apr 2025 15:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qOX46yNSMPDy/eRyQ29rSt/JJQ4uQ8+t+Us6WQo3UR4=; b=
	PvmJOmONupaKEUMD9jfMm+m1fzS29eooK+/15ld0k34im3hVQLAQOejrPndJTnyB
	TVwo9wSGTq6DWI7x/kUSAd4+fOBf0Fjxu839I60DwQKjg6iCOZiucQ8e1GnlgfHg
	e+YghGcZczrZ3nTmq0mqUWa3P3ZWMEGNGzwXjfIxqUy78OFEpojoaa+nghwpOZ1X
	KXbBuXc+iRntQ9zGl6ompgIZvAUMSmUog5m+kK2fqUYF95pHdPc9n4CLi1Sayxb+
	wCmEqQ83A5VYPsqMf333r2Eqed+F0edsXzVlejWq0IoYPLfb5dPRFlB4BcgcV9Ns
	iNIYi9XkzUdFwJyQgBsJ9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ac8f818h-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:31:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SE2Ij4007618;
	Mon, 28 Apr 2025 15:28:42 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8b3bp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqLrh03d4hnAcW0eZVS/hjFqtMXec1QsU0CYcLmhQytEFlIwdwIMogaiRc8iMDogRUo3N6fU0zDhf2AhgFcms71QmMjUKd2G5rm3sIdJCuXz4F986opelOnbDPfHj1BdZEkFSqKO4KzHoqrhF4E7tAD9HTYf1b3qxMSzjd1AZAmRlJcVoHdi47+b7OekmwVSgvMD7p2gAkmBK+dC6Vqyd8NgBNvTBtP7L2Q9nYyhyz9KEoiSGnFAn9eYXTypH2dlzAnTeJWvp04/rZoU1Gu+V2R0aFDJ0cJCt2/dbxzeWS/rCUMxDevAs6Mae226CSSyEsnmJuFFNniBKUN6Ycp2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOX46yNSMPDy/eRyQ29rSt/JJQ4uQ8+t+Us6WQo3UR4=;
 b=q1zXHOt+PXFUngsB3DFfkFqYIYBcUYLt1rNZvXK3eMxJxg/BUr5jtT14hU/tPrV1DQ9tsgDhaIKR2pgLdSZF+Q4URs7NxKENDwbCMAVsoha6QnMmXhYlriO2gpAJ49AT6A+5BmmEQmXOTip4jbIwNUwP4ywmjeUdBGIBQtw9pX2xXzyjzGeQ/PQ9NYhbcGB7P2YxvsuZpysfIBlTVUcTdJUtjZUHjd0dCCs/7oHzBAm5e5Pu5nnxZZxthnyBMhHKnaEAbdKPsLtnFQ3G1yRMbpCkA2CfNDoaB6zBf/UodNEulzZjnLVLy9PTuheAkumtHAelkMnfjRpA8H6ozYryZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOX46yNSMPDy/eRyQ29rSt/JJQ4uQ8+t+Us6WQo3UR4=;
 b=kDqbEvSf/ZwX47Tx72wUqmcZsU2v/p8prkSUwwxALMZIKXBdhBIaqoSH0UpeZYFrUMSctQIQpm44AigDpVGAsl7+faSc6xyHH68uNEL5Eb5ZRCvQNffnnTG92YuOqC8N+sH7mRUUAcrOjxitNrV3yrV6MscdoMbhvkpZWQU5bCE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 15:28:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:28:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mm: move dup_mmap() to mm
Date: Mon, 28 Apr 2025 16:28:16 +0100
Message-ID: <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0384.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: acedf857-7abd-4845-4a9a-08dd86695454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzMupjAeH75E1gwO0xdGFhL94WQaSFk7wPMMvgZsChDArvxTb9zIQMAyMCv6?=
 =?us-ascii?Q?1PYZC7KmorWNcbw8QFu6L47qQqVn+zLk8b5QVXB14+W5ABehQ8+ybqywElQJ?=
 =?us-ascii?Q?ytb45H8a79U9UIvl2MoEqErA5L3sa1WouXiUgm2hrUdCJdPCjG1Xs9oS7y6/?=
 =?us-ascii?Q?lAfMIVFU6ywaG95wtgZXVoN0mLu8r0Hc60ev05Rajy5PW7GTmrvpiK5j/aPF?=
 =?us-ascii?Q?wjt9MuY3XN6nHKJOuESCjfy/SIE/nqqN8smYeVjvQuJ7cdStJPAtesrZMd4A?=
 =?us-ascii?Q?q+VJxYRMgXjqXMUIa3gfMI3pyBmgN64Lu4gBa2ym1Oah57bsE0Z1g8+rYJIn?=
 =?us-ascii?Q?7A5A1Nq9hg6vA28jwG3G0FetufvHP9vbPzyYd7PtgCkDE4u4wXREawASjhbW?=
 =?us-ascii?Q?HdLZ9N1zphe5KmmIZb9uM8153AIpJmbbDkgT4vFmsewzvbUTF0fpplNF3Up2?=
 =?us-ascii?Q?rraC2MawISKiqyPDx6EwNmVKKNpc4CfbVT/xA5MH0Solg986kve17ycWvTkz?=
 =?us-ascii?Q?4fnkUvEc8WRD1weN10Cls7PCh0bQsl8KtFkUShq9vVz0UEAG+s6d8RmWTjKg?=
 =?us-ascii?Q?IoqTCz8qN9lzrlunL2T7Rs8vac7vdd25A2XpW3aqTIKgRkXqGJGcFTzEKXv6?=
 =?us-ascii?Q?DGV1W9jn5GehSsDr2yERHhbfU9p4N8XSbk1WtMPuaUG/z5mH6fPARJKKdL5U?=
 =?us-ascii?Q?UmrxemXMZ38dSZbyEaPdgnqRWd6K3klOweY+VYfE9mwkllq4+gD3sr/fXsOn?=
 =?us-ascii?Q?tQSXQsczlf0QapHjHMC2CAiEGNjWh8A3u7iLcTm931JS7bNgHnA4my89ZRMq?=
 =?us-ascii?Q?4S9S4esn9yaHSPLyhX9pORfR8aZjxdScZ6EMDrFUccd0++d1xi1yHsdwEMQk?=
 =?us-ascii?Q?mC0a7diJCcXMlCe9xchMUvXjLUv8wOJ1Ap/LxhmFiWqUUUaDCbQ7dtAoyMcK?=
 =?us-ascii?Q?JKwWZMYNuGl8CVVsXqm4Qtcy/2R7gp+QuJI8B2uOV1execKLCdS4DXgk620n?=
 =?us-ascii?Q?u1Q1JR3awkQX7/DcsJ1cNeIDFnNE6QjmuwmtkZJK6Kbv5Y8XzKSBA6Xrn9SQ?=
 =?us-ascii?Q?C/nClNcqgWLa8rl/wX5VQJb51bIxT4767MZJOzaFtf6o4brDmGbUJN4JGtSI?=
 =?us-ascii?Q?om7GQixR7ygTrZCA8BTfqY2yj5tJVy1qoLYLVZfWhnIxMvrzPp8RF4L7b1g4?=
 =?us-ascii?Q?BOZ/aCKFR7uq203ZzrAPRSMNBafmxoRI9nRYg6TCvZIMEOiTVf8+cqFgx/Bt?=
 =?us-ascii?Q?Gjh5fh316fRp2zB5/qzOgwpbetM/Je4KMSrYqey+l6fjl+c62fzcYqHR6jDw?=
 =?us-ascii?Q?Dt8WmFZa0+Pm1/MJs64DT8ViLz8f1WPthr/A2wo19Y/DbepFinx5x7KtNIWX?=
 =?us-ascii?Q?YmFr5Z6xkNgeglQgOjoxDfmmBIr3drPDcQCxRZB4Oz2hPfacCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4g0gQPPJa+W8O4VW7jkEmlk/QCbuaQanbVhTomi1HzAHa0guBfImTjwpZp6?=
 =?us-ascii?Q?N7N+sf8IkfmffcsU1u1/ZlkLfGn9YyqgzYEjpwJKM0mS1vTy9lgBC6AxxMTE?=
 =?us-ascii?Q?+5DCOtaqF9pe1N5s3HC/73b/wi04anOLrG1/2NvQKEJRzrChFzTzQk2Qa5En?=
 =?us-ascii?Q?IrSKlpWmRwpyUGfA2/SvQ6J3zPjHYXGEGHurMDMyeHGKgI0N5tfB2NJ6kakR?=
 =?us-ascii?Q?xfwYrElQ8wXS2AWMmeI4E5PLScAaTr1OedPnUHhzspdxs4CpB7jGa4Gc4WSM?=
 =?us-ascii?Q?Wpn83ZtJsA7wd8ZemlUhkYKY+QLav8wrSa6TUU7qan/iVpJTikjeX4+zOBTZ?=
 =?us-ascii?Q?N5DAFzZ6S0QvOZRxbbLKZrHMIA0cXcoqPmm/MqT/dlayY/Iedm5naP6NV6SY?=
 =?us-ascii?Q?h+wm9BvBUYQQUw0HnwJFMBOmyDwj4juSdH33utNj7wGtrs+QLstSyBZKKUWf?=
 =?us-ascii?Q?ygWtWoUR8O8MEdqtPcLL3uu+cPzD8KnpFamHCjK7OaKFVbbHoJQvHP4cFzz1?=
 =?us-ascii?Q?BJ0a0unQDObKOnU/Qx1r6+uuKzRDVii1Qj6fcH1xgJZDxV0N2x8S5ScbNl68?=
 =?us-ascii?Q?PKaieS0QfQu6cbADak+6tszRgbJHs9gUq/YrCz6DUlhT+VRk1bn4ymamCKvk?=
 =?us-ascii?Q?K9M2OurocrNZOIYy5gqpmYoRyvlBxOAYyRG6riUBhEotWZwcuk/qR8gkGRs4?=
 =?us-ascii?Q?1EwcOekiMHDtMXQufB0AazGGX7PF445A4a5/Yg7cblEG6PEnLrnLI+1oTA0u?=
 =?us-ascii?Q?nyaVMIoF6fEMyd9w6SyP5eJgougEv+c8Mc1QOtOl6zTC1doyLK4Z1ksf+jq5?=
 =?us-ascii?Q?M6fP/m+juww32DfMpaFatEBmqoGyMiYfxQ9LjyxUqXjF2GiOCPuyboSPX9gi?=
 =?us-ascii?Q?1glyKdGB8lnM2JaKEvt5fOIQPkpP+nyylQl9gjlUb9HS1WLOfgxrdDUZ/PKo?=
 =?us-ascii?Q?kNcBBq2prR5I9SY0HrpyEjkY1m2Ay6OaSSRzreGfAvLdjEpPt0vRr0/MHcoX?=
 =?us-ascii?Q?lwKdm/W7TZr8QGA2ipowUHjYxQ6WvyQk+8UNdbQt8MSxRMmOwUlielvM827x?=
 =?us-ascii?Q?+lFNprcqx1rn/X3NNohsUBd8Z2B/leM5uKLYRSl+IjDhSEXXJb6AMf1TMWk4?=
 =?us-ascii?Q?TvVwLc/i5yqK1VLpDpQ0lC0W4fI/vQ+RVN8AM7riX05ytLg3Tus/41DeoZ35?=
 =?us-ascii?Q?WzfSkbTcdfhv6bt+vDRDxKp3jxlNKOTgfyQvcQlOKH+SX1qngb+qKQVmk8D7?=
 =?us-ascii?Q?78OOtTI2/8LSz9PARIbR/Ca5fo2u5fg5NgWldIUtvjkWgoTMhUfb3yGrGz4S?=
 =?us-ascii?Q?lpOf5kbYKU1uUXTbEbMlhM/N2LFijgeAjTWEKlTt8xvcjQReeX52Bc/YBPjy?=
 =?us-ascii?Q?xAqMi4aR+wpuv03w5rTGldBLb3mLN5QPTq5uh+k1h7MJ83j+BeeMMQRAqLiW?=
 =?us-ascii?Q?k99LzWoD2DXD7FaWucuX0LAzCHdc1YoXO7E1iFxtRvAb+07PvQVmYdPaqYR5?=
 =?us-ascii?Q?KCVdfh05ZFBqCg31Rg8bPDvBMDJDPI9myCkO4Yr2Ybyx8QpuCcpxBuRAGNDs?=
 =?us-ascii?Q?phjiEAhYlzPP7iwwswgKf0VrjxqPW01UpI2QlEHIp7lS4Bbb5z4MmGVOYGLV?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hz0UIS69OzTdjuumJWGffr3x+8lJsY8yUvAJWaPAoMFp3bDwgicA2gpJhIz8+K5QTc2Wrp9u6lAN8epRDXKZ/Cth2IT/Gt+SvL4aUInroyc3jaV9FmFgJPavbm6sNt/JqBcZZSJEDT6tHTLMPDZ4ZXsNqJxQIquLO2/vKkooaM8aDxSSSDBZz/K1Dy32y76jFY096hg8T4XVZk7GMEgGSs31vi29RJ0LoPQ7BcZ6Rn0I40qJFrQHUqmMpnIy/bDfgcBa9/xxtnlMOCTo1tKlqHxU1NUoWtBoZmrrwPvhn9mnumaf/sR/VNYQhXGyL3k3RfjS5PnCaac3PjxEu6muAADxxonsv1sHQFsFxOYzzZdrbNU9z14+zWhSDXkcbH0vLFCRvGwxlk1x/UPsf+Rjl63/aMYjY7gf/pyeEEeGvR6Zx34LNXSxPfXp0pTgg+ruSVz6xtrZlGRZ1QI68s4nEv10YiAG5T31pqmwEQN1zro2aKFa6BRS7lfH6MjI5aKhZkRSzKrXdfPsjbn7E55Efc4PCVne7GLCw09JwpXcEJNAouHfD/jhB+pZeTzTab2yddtnm4dzSCqT6AnCl3EUAzS8/CE1Q/V+kzktWn1GC4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acedf857-7abd-4845-4a9a-08dd86695454
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:28:30.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iJS+dAHGbKLVhiNZ14wWUvClZ4JdugyhULu+0NuhJMPbfR/yzxy6IuNiNyPGrSVSeVrTrV5DumpVe28XzPHRZ7PCtJ7FcFNkXKH3y25VYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280127
X-Proofpoint-GUID: fVCGq3jtu3WSxiluT2AF6nTYElMh9-Og
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNyBTYWx0ZWRfX+dSicsMy7XpD XSnAJuiWDIltZ/aic/EgpH8XRV87ukVobvBhQq4NaNYlDmg11MebgGm1UDgTYrJbdxFXlWZYBWB OKSkW/w8iUwYfmuo52kNWgRpl36DdHNXtSYkO4R8tvAHYDZTy/QSfqkrXCBEPOXNlDEaaPrVfr7
 DD95owuZvFWlu6RAQuqo603Wv8Q2vHRxpln4G2S43SxDvMGKQLCI5v+kOvMFAe2os9P3V8HuHku NORuy92Iol2aQ5TyAIKYB0fRSFBtq/JyXyI+6X59m7GcYHsPxdU5pNZraEDdvtOfxSDKtkvVLFl dmxCLqVG950BY7N+BH7BPtw5iePs8d9U4TxPRYTyYDIrgb1WaPB+b6hx0qAAN/oZtctzHbQSKqB cMD8n4AY
X-Proofpoint-ORIG-GUID: fVCGq3jtu3WSxiluT2AF6nTYElMh9-Og

This is a key step in our being able to abstract and isolate VMA allocation
and destruction logic.

This function is the last one where vm_area_free() and vm_area_dup() are
directly referenced outside of mmap, so having this in mm allows us to
isolate these.

We do the same for the nommu version which is substantially simpler.

We place the declaration for dup_mmap() in mm/internal.h and have
kernel/fork.c import this in order to prevent improper use of this
functionality elsewhere in the kernel.

While we're here, we remove the useless #ifdef CONFIG_MMU check around
mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
CONFIG_MMU is set.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 kernel/fork.c | 189 ++------------------------------------------------
 mm/internal.h |   2 +
 mm/mmap.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++--
 mm/nommu.c    |   8 +++
 4 files changed, 189 insertions(+), 191 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 168681fc4b25..ac9f9267a473 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+/* For dup_mmap(). */
+#include "../mm/internal.h"
+
 #include <trace/events/sched.h>
 
 #define CREATE_TRACE_POINTS
@@ -589,7 +592,7 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	struct file *exe_file;
 
@@ -604,183 +607,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 }
 
 #ifdef CONFIG_MMU
-static __latent_entropy int dup_mmap(struct mm_struct *mm,
-					struct mm_struct *oldmm)
-{
-	struct vm_area_struct *mpnt, *tmp;
-	int retval;
-	unsigned long charge = 0;
-	LIST_HEAD(uf);
-	VMA_ITERATOR(vmi, mm, 0);
-
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
-	flush_cache_dup_mm(oldmm);
-	uprobe_dup_mmap(oldmm, mm);
-	/*
-	 * Not linked in yet - no deadlock potential:
-	 */
-	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
-
-	/* No ordering required: file already has been exposed. */
-	dup_mm_exe_file(mm, oldmm);
-
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
-	/* Use __mt_dup() to efficiently build an identical maple tree. */
-	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
-	if (unlikely(retval))
-		goto out;
-
-	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(vmi, mpnt) {
-		struct file *file;
-
-		vma_start_write(mpnt);
-		if (mpnt->vm_flags & VM_DONTCOPY) {
-			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
-						    mpnt->vm_end, GFP_KERNEL);
-			if (retval)
-				goto loop_out;
-
-			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
-			continue;
-		}
-		charge = 0;
-		/*
-		 * Don't duplicate many vmas if we've been oom-killed (for
-		 * example)
-		 */
-		if (fatal_signal_pending(current)) {
-			retval = -EINTR;
-			goto loop_out;
-		}
-		if (mpnt->vm_flags & VM_ACCOUNT) {
-			unsigned long len = vma_pages(mpnt);
-
-			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
-				goto fail_nomem;
-			charge = len;
-		}
-		tmp = vm_area_dup(mpnt);
-		if (!tmp)
-			goto fail_nomem;
-
-		/* track_pfn_copy() will later take care of copying internal state. */
-		if (unlikely(tmp->vm_flags & VM_PFNMAP))
-			untrack_pfn_clear(tmp);
-
-		retval = vma_dup_policy(mpnt, tmp);
-		if (retval)
-			goto fail_nomem_policy;
-		tmp->vm_mm = mm;
-		retval = dup_userfaultfd(tmp, &uf);
-		if (retval)
-			goto fail_nomem_anon_vma_fork;
-		if (tmp->vm_flags & VM_WIPEONFORK) {
-			/*
-			 * VM_WIPEONFORK gets a clean slate in the child.
-			 * Don't prepare anon_vma until fault since we don't
-			 * copy page for current vma.
-			 */
-			tmp->anon_vma = NULL;
-		} else if (anon_vma_fork(tmp, mpnt))
-			goto fail_nomem_anon_vma_fork;
-		vm_flags_clear(tmp, VM_LOCKED_MASK);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		/*
-		 * Link the vma into the MT. After using __mt_dup(), memory
-		 * allocation is not necessary here, so it cannot fail.
-		 */
-		vma_iter_bulk_store(&vmi, tmp);
-
-		mm->map_count++;
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
-		file = tmp->vm_file;
-		if (file) {
-			struct address_space *mapping = file->f_mapping;
-
-			get_file(file);
-			i_mmap_lock_write(mapping);
-			if (vma_is_shared_maywrite(tmp))
-				mapping_allow_writable(mapping);
-			flush_dcache_mmap_lock(mapping);
-			/* insert tmp into the share list, just after mpnt */
-			vma_interval_tree_insert_after(tmp, mpnt,
-					&mapping->i_mmap);
-			flush_dcache_mmap_unlock(mapping);
-			i_mmap_unlock_write(mapping);
-		}
-
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(tmp, mpnt);
-
-		if (retval) {
-			mpnt = vma_next(&vmi);
-			goto loop_out;
-		}
-	}
-	/* a new mm has just been created */
-	retval = arch_dup_mmap(oldmm, mm);
-loop_out:
-	vma_iter_free(&vmi);
-	if (!retval) {
-		mt_set_in_rcu(vmi.mas.tree);
-		ksm_fork(mm, oldmm);
-		khugepaged_fork(mm, oldmm);
-	} else {
-
-		/*
-		 * The entire maple tree has already been duplicated. If the
-		 * mmap duplication fails, mark the failure point with
-		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
-		 * stop releasing VMAs that have not been duplicated after this
-		 * point.
-		 */
-		if (mpnt) {
-			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
-			mas_store(&vmi.mas, XA_ZERO_ENTRY);
-			/* Avoid OOM iterating a broken tree */
-			set_bit(MMF_OOM_SKIP, &mm->flags);
-		}
-		/*
-		 * The mm_struct is going to exit, but the locks will be dropped
-		 * first.  Set the mm_struct as unstable is advisable as it is
-		 * not fully initialised.
-		 */
-		set_bit(MMF_UNSTABLE, &mm->flags);
-	}
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm(oldmm);
-	mmap_write_unlock(oldmm);
-	if (!retval)
-		dup_userfaultfd_complete(&uf);
-	else
-		dup_userfaultfd_fail(&uf);
-	return retval;
-
-fail_nomem_anon_vma_fork:
-	mpol_put(vma_policy(tmp));
-fail_nomem_policy:
-	vm_area_free(tmp);
-fail_nomem:
-	retval = -ENOMEM;
-	vm_unacct_memory(charge);
-	goto loop_out;
-}
-
 static inline int mm_alloc_pgd(struct mm_struct *mm)
 {
 	mm->pgd = pgd_alloc(mm);
@@ -794,13 +620,6 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 	pgd_free(mm, mm->pgd);
 }
 #else
-static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
-{
-	mmap_write_lock(oldmm);
-	dup_mm_exe_file(mm, oldmm);
-	mmap_write_unlock(oldmm);
-	return 0;
-}
 #define mm_alloc_pgd(mm)	(0)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
diff --git a/mm/internal.h b/mm/internal.h
index 40464f755092..b3e011976f74 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1631,5 +1631,7 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_PT_RECLAIM */
 
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9e09eac0021c..5259df031e15 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1675,7 +1675,6 @@ static int __meminit init_reserve_notifier(void)
 }
 subsys_initcall(init_reserve_notifier);
 
-#ifdef CONFIG_MMU
 /*
  * Obtain a read lock on mm->mmap_lock, if the specified address is below the
  * start of the VMA, the intent is to perform a write, and it is a
@@ -1719,10 +1718,180 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	mmap_write_downgrade(mm);
 	return true;
 }
-#else
-bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
-				 unsigned long addr, bool write)
+
+__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return false;
+	struct vm_area_struct *mpnt, *tmp;
+	int retval;
+	unsigned long charge = 0;
+	LIST_HEAD(uf);
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (mmap_write_lock_killable(oldmm))
+		return -EINTR;
+	flush_cache_dup_mm(oldmm);
+	uprobe_dup_mmap(oldmm, mm);
+	/*
+	 * Not linked in yet - no deadlock potential:
+	 */
+	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
+
+	/* No ordering required: file already has been exposed. */
+	dup_mm_exe_file(mm, oldmm);
+
+	mm->total_vm = oldmm->total_vm;
+	mm->data_vm = oldmm->data_vm;
+	mm->exec_vm = oldmm->exec_vm;
+	mm->stack_vm = oldmm->stack_vm;
+
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
+		goto out;
+
+	mt_clear_in_rcu(vmi.mas.tree);
+	for_each_vma(vmi, mpnt) {
+		struct file *file;
+
+		vma_start_write(mpnt);
+		if (mpnt->vm_flags & VM_DONTCOPY) {
+			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
+						    mpnt->vm_end, GFP_KERNEL);
+			if (retval)
+				goto loop_out;
+
+			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+			continue;
+		}
+		charge = 0;
+		/*
+		 * Don't duplicate many vmas if we've been oom-killed (for
+		 * example)
+		 */
+		if (fatal_signal_pending(current)) {
+			retval = -EINTR;
+			goto loop_out;
+		}
+		if (mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned long len = vma_pages(mpnt);
+
+			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
+				goto fail_nomem;
+			charge = len;
+		}
+
+		tmp = vm_area_dup(mpnt);
+		if (!tmp)
+			goto fail_nomem;
+
+		/* track_pfn_copy() will later take care of copying internal state. */
+		if (unlikely(tmp->vm_flags & VM_PFNMAP))
+			untrack_pfn_clear(tmp);
+
+		retval = vma_dup_policy(mpnt, tmp);
+		if (retval)
+			goto fail_nomem_policy;
+		tmp->vm_mm = mm;
+		retval = dup_userfaultfd(tmp, &uf);
+		if (retval)
+			goto fail_nomem_anon_vma_fork;
+		if (tmp->vm_flags & VM_WIPEONFORK) {
+			/*
+			 * VM_WIPEONFORK gets a clean slate in the child.
+			 * Don't prepare anon_vma until fault since we don't
+			 * copy page for current vma.
+			 */
+			tmp->anon_vma = NULL;
+		} else if (anon_vma_fork(tmp, mpnt))
+			goto fail_nomem_anon_vma_fork;
+		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
+
+		mm->map_count++;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
+		file = tmp->vm_file;
+		if (file) {
+			struct address_space *mapping = file->f_mapping;
+
+			get_file(file);
+			i_mmap_lock_write(mapping);
+			if (vma_is_shared_maywrite(tmp))
+				mapping_allow_writable(mapping);
+			flush_dcache_mmap_lock(mapping);
+			/* insert tmp into the share list, just after mpnt */
+			vma_interval_tree_insert_after(tmp, mpnt,
+					&mapping->i_mmap);
+			flush_dcache_mmap_unlock(mapping);
+			i_mmap_unlock_write(mapping);
+		}
+
+		if (!(tmp->vm_flags & VM_WIPEONFORK))
+			retval = copy_page_range(tmp, mpnt);
+
+		if (retval) {
+			mpnt = vma_next(&vmi);
+			goto loop_out;
+		}
+	}
+	/* a new mm has just been created */
+	retval = arch_dup_mmap(oldmm, mm);
+loop_out:
+	vma_iter_free(&vmi);
+	if (!retval) {
+		mt_set_in_rcu(vmi.mas.tree);
+		ksm_fork(mm, oldmm);
+		khugepaged_fork(mm, oldmm);
+	} else {
+
+		/*
+		 * The entire maple tree has already been duplicated. If the
+		 * mmap duplication fails, mark the failure point with
+		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
+		 * stop releasing VMAs that have not been duplicated after this
+		 * point.
+		 */
+		if (mpnt) {
+			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+			mas_store(&vmi.mas, XA_ZERO_ENTRY);
+			/* Avoid OOM iterating a broken tree */
+			set_bit(MMF_OOM_SKIP, &mm->flags);
+		}
+		/*
+		 * The mm_struct is going to exit, but the locks will be dropped
+		 * first.  Set the mm_struct as unstable is advisable as it is
+		 * not fully initialised.
+		 */
+		set_bit(MMF_UNSTABLE, &mm->flags);
+	}
+out:
+	mmap_write_unlock(mm);
+	flush_tlb_mm(oldmm);
+	mmap_write_unlock(oldmm);
+	if (!retval)
+		dup_userfaultfd_complete(&uf);
+	else
+		dup_userfaultfd_fail(&uf);
+	return retval;
+
+fail_nomem_anon_vma_fork:
+	mpol_put(vma_policy(tmp));
+fail_nomem_policy:
+	vm_area_free(tmp);
+fail_nomem:
+	retval = -ENOMEM;
+	vm_unacct_memory(charge);
+	goto loop_out;
 }
-#endif
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b4d304c6445..a142fc258d39 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1874,3 +1874,11 @@ static int __meminit init_admin_reserve(void)
 	return 0;
 }
 subsys_initcall(init_admin_reserve);
+
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	mmap_write_lock(oldmm);
+	dup_mm_exe_file(mm, oldmm);
+	mmap_write_unlock(oldmm);
+	return 0;
+}
-- 
2.49.0


