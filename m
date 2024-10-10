Return-Path: <linux-fsdevel+bounces-31620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A7998F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E61F222B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE071CDFBB;
	Thu, 10 Oct 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKHWinVB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mOB7l7Js"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9CE193419;
	Thu, 10 Oct 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584168; cv=fail; b=I1+CZZyra7hnzG1dtSJwYVerpGOeQjmRsZXS8CFro9MAotiGcIkov3aT7RR48yprSODDQgbispgXjv4qL/Ytid5WJp1FlrkPbnRaCn+/LizI4MT4IcQ3Q1OlLEZPM6hivIPBsdXydyBGpBqUFB0CSgcaclTk0KLXtnCrx1tYBAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584168; c=relaxed/simple;
	bh=jXEwy1cIG013Nmn20lq6z+GZtPlGLcL+Ggwmzsgur1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qIIuSPryF0l2HkKum13h74bZZf1D6+dWPwZjbgJgZ7mR1V4F7oQoPOIup34JTlLhpiNqvMy/4nD9LNrdxnPr9NruUMOq+xOyE0YCPUD8Z5wkgsTmphNW2c/U0H44IEVzEQYSiPKP2k3V+nApPaMJRRQU+P05a4Ed/S/q/ZpS9VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NKHWinVB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mOB7l7Js; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHteVf013553;
	Thu, 10 Oct 2024 18:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Hz0h0h0XOOiy1O+X
	+Llq/CysKHWSSxoQM8TyPcQQTys=; b=NKHWinVBjba/HY/1azklEY60Mw+KCeg9
	BndjCdAO+JVF2yLHaMh0a6i0aJcoWdC0Ty0dU76DvfuUbp//6Ml2/+cIyquv1KzP
	8+keaSrr/a2lkoXOwz3BvrNGfzXkkb4s5lTWWxwX333NFhj5PJxWFFd46ozzoBkN
	zUK7vLSRIKjnSJNvfaJVYCB7eAyqpNItk2eNqh/l2y21wQMI+41ZkTF7xNJN275c
	jy9JoTqW2qdaatFDdUqz3Ftmd+yFqAtiEr+oBD1568shAnxMXPBhSuLUi8uoWQWi
	iyBQQFrcq8rdFfc7sMuJAHGZlOtcr3ONH2Twy0gRVxm+js6TrEnbLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk8nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHKAae027678;
	Thu, 10 Oct 2024 18:15:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwaecea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxnmlgVT/IWdRq4gP+ksC+Ll/frGzW1Fk/tinHIRAsOGKC3lc7Z+YFZ9Kvia6mL2bRVzuP5OexSQKz22RgvCSiZYAzdiJhybGrY/stWrKfV6IcI2ZGffk3VmjZLZCuGHfHtak0bh/kPTMxP46dnULhHdEyoInjZwISEovumpUaHKF1w9iAjm3IkBZ25z1tmZvPAaRwGCytgN0gY6CbkXeGvks8IpunpuFTrKwStvFyTiU5nYg1YIxiRA9JfsD6gCo6DC6YDd9ARxEPjVOSg5Vo/bRn3FalyRlhLtovx5eeb8suyCJigexY9MbNPNHEySjF/RK5C/dniO3HbktPswGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz0h0h0XOOiy1O+X+Llq/CysKHWSSxoQM8TyPcQQTys=;
 b=xcc7jSVP4J4c1fJqYN7PcaGGutmT4TfVHrsJeT+LlvhDK8oOTh674epFc9CQufDRprya/aQI9IBMCeXINY6+KXC7R/GP2EvyLepvPW4ecyFMp8bQeBkKvIAHeW2qSzt8YdSaDWmGoiDCHnSG27jOlu408txF9b7LJmxPh2nYKWNWGHHWbgoVAAIJNuKGBITBRU8zGYVchJp8ArkJVB2MYWbm4mTxm16hNvc+U8PxO3D5CeEed4pNBr8dz5ZiAZZyQQeFhGITUg4BfAZw2eqMx9/d6t7TxCfrcpcKLET+9zt5PItWR6DvVtl70E8w0jd4acOdgAiFHvrfykXTZFc3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz0h0h0XOOiy1O+X+Llq/CysKHWSSxoQM8TyPcQQTys=;
 b=mOB7l7Jsf2LFQo46cpX56JFjDEyhwB3WkcGDjSjbJq/IdL6bRmF8PdHVljKU+8vJNU9Mpb6EQwMRdqyOZFyuhnx3ESORuCO/15Q+0EjgU+wMRHaHyJZZkjjW19VEMULWulKLeF/6OTfFGSUoNgvijrmn4c+IlfX0EJy2w+2RiQU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7826.namprd10.prod.outlook.com (2603:10b6:a03:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:15:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:15:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] introduce PIDFD_SELF* sentinels
Date: Thu, 10 Oct 2024 19:15:42 +0100
Message-ID: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba669a4-8a28-4e3b-03c8-08dce9579127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kliIaetPpahc676KFbtk7vnN73N0UAowfjDnXE0ZdOrOHK+7ZWizTnjFC2mV?=
 =?us-ascii?Q?gzZawm47BsJAhW3VXVmVxHUqpEkajeNvtytQzjcnPzgfov23/2a3vDzWelw9?=
 =?us-ascii?Q?sDrYnHifRR254XQLjC7N2t8O45UWQBxvTviE2dagTPcLhk7oIuNtVopXWaBk?=
 =?us-ascii?Q?jQdUDNJ85d4JRqI2EydhOSlen9k3MsP7XZLihxosyQgdM+j5O1EfkswMHFv2?=
 =?us-ascii?Q?WhUF62ELRc0wJU3oChl31l/7k5MJMqQ7sNJbz9QvcyZ7lcG4ChasKWuRyNKe?=
 =?us-ascii?Q?BLmQlUWInj68V6OH5UsQq5ZZt7ORSwS2Fp7HGOvtezZv3RFNt0W7e3cRHFeu?=
 =?us-ascii?Q?+bjEb59G/Rf9L8y4rXgCOb6p8CHwtHXV4gAN0vD6hCsNPla5TX3CKUV6UnDK?=
 =?us-ascii?Q?7BLC3Apz78m/9jsP33pjgmZp4Cdby5Jq70Yp2x9LDshgaEi4N4jms6CZaARU?=
 =?us-ascii?Q?k/2q6M2oqifTZlTMVvninfUqkwK6I3HZAb+9cBuhlt8F4fCF3w3fvICMBm7v?=
 =?us-ascii?Q?YDpBBvoxnmKnL6T6eOMfiC7ZnxVrGQ3MmNx6epC9ymqwUfj5y3ICtOw0bMTP?=
 =?us-ascii?Q?J+boNoOhav4wy6enr+FE1MdwpTjjurFnVlBCElHrAtjJ7HDgwaaCrtDh13UG?=
 =?us-ascii?Q?wt/JstSN6whN6Og+XnBHK82yqx8tTGozp79h6O6SjOCc+TiIkWfWoHCA+slz?=
 =?us-ascii?Q?i8SN7LrVds0ch4BmRDGv4KgMj4crPAVkYZrUiu9eqfjIeIfd2sOZZ9W6GzE9?=
 =?us-ascii?Q?XBVfYaj6w+1SQ3RcERcVgnkLw7BAcjbYKd8L0WDTPs/0xq2ZZl5/oEGrb20D?=
 =?us-ascii?Q?gl6lH9qcWrG9Pm782juYf66mq0mdPpbCsqFDVyH1av/ig9UWFf7mfCbUlJiB?=
 =?us-ascii?Q?NM2d8r2fp0v7orRxzZZjyMzcaz5OHt7VpPomZFcisL4NmwAQjfEaszS0xSWW?=
 =?us-ascii?Q?/lEh48Xn+j3TMQVf3NZRk8t69dZYJpnGzTk3Roxdt5O17w6WK8taetsuSja5?=
 =?us-ascii?Q?LaHpK0eW20Egev7Fi2+ogGNAy1C0aOMmsIrZI4D6o5Wc83EyWyMUgeBV8QN4?=
 =?us-ascii?Q?5uu8kkqbBowgepGzpBtfRoWbkdm/6UFZv5lbKb1j4WhbdQkHxUbncbuwFZ6g?=
 =?us-ascii?Q?4p44mzAgYOZnMppdjA2KSbeJOLAfXckz6vXM+WfWkjv4NHqEXysM2fzylrYQ?=
 =?us-ascii?Q?xYAs6zR5lN/X7mfBf684Utwp6EjCWGL1+TGS5Eg1eAXTz/JSWiIFmP1NeTaj?=
 =?us-ascii?Q?zB/cVQCclZNV7Nu8rHAGLD18x29HLbTuSNtAFVOlmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QJd85yaP8XJ/i6FLfl5D4s8x9aZqNvXapCP+hOGUZr2eilY0bZ28ZD2D1rr?=
 =?us-ascii?Q?ueVR3auWNSLyu71VxJgc7jurA+Lxewm15gsCyj22MD4POlWRMqN8w4WZKDCl?=
 =?us-ascii?Q?bdCxteylmTNzDOUyymJhfpwJiJpimv5klo9yUpg1jDD/IstXSujzfHPHBEyX?=
 =?us-ascii?Q?5iKte/8LhJd7Y8piKgWIDGSzjbWO8sD+VNvStbPd8Uv4RoHWYVOeAV3vmO5E?=
 =?us-ascii?Q?GsteOslD/FZkJsYwcw97w1NWRrD/xdYLYSiqvpcIDKzzP1NVjFkU3i2cbOk+?=
 =?us-ascii?Q?8WT9SuBDj32Ve68fapJc5Cnkr/ZERI6XUDtNqswQKgVcPcQniB6B4iD/UqKn?=
 =?us-ascii?Q?NA0c/XjjNm7eUo7k4DXGG5FJsG2gebOA/DhFn+2j864j76jwR4u0Q5f2S88Y?=
 =?us-ascii?Q?GnyQlpnOgVntF4Npm4D2WxOIiTURsIPIjx8fiA6a6lWwNc7y4uLsYSvlb56+?=
 =?us-ascii?Q?7ATgS8tjlBPnTV+YcOI0ojpnGrSdniCbO0OphThenwcGEhUmTG1GSILbjUGb?=
 =?us-ascii?Q?IN6LJ2bMQLneBn3sBHOmTJBMu65muuawF+TPX3XKIJER8KIscU4Gq2VaiK+Z?=
 =?us-ascii?Q?y2BG74gAk8i1JvqkKYwBW+nPz2A9+5k71JwrLiAm/EKD0MsZElyHz20nL/p2?=
 =?us-ascii?Q?qzV32N6ED0P4GwwJHUPAW/D+uMcgWzjLw+CD4z38x8iYG9VyRDEuUwC6Q1lC?=
 =?us-ascii?Q?Yx9d+ZM+xVF6tYOonSRDDpzaDc8sv1vV2p66CGEJpss5PPFXib2OIEI22ffg?=
 =?us-ascii?Q?s8b4+02ZTq6Z76mekVPZl/a4NvzhGaNeeIOEGxBAtn1304KIH0ALec5Zs8fN?=
 =?us-ascii?Q?ICLb1aL8Yt3e3qkYACjwVdE2qKRbeAiH1ELO9XGieYB/ACTsCjEN/eBKUsZJ?=
 =?us-ascii?Q?7CTAurFh5TcHxU8zVuY9tjBwNrnujkxSI6E2/noiL+rKxfy2+QF8YT5usSC/?=
 =?us-ascii?Q?iUpI4SlfhgTdfASEfhcbgDNYbAJJPlaYr50OyZs0/sb+oK7BJnfImrOp9PcP?=
 =?us-ascii?Q?vLvo7kIdwWGRdMOhOc4rs9n936Hv42u0u8JnPIQblNl2xmfsUvTReOhIGtpd?=
 =?us-ascii?Q?dQGSZ0dzSTdqGBBWlUACWrnuEVsNnr6NX9MPHRWBwhuB5B49WMkC4XkLSPsh?=
 =?us-ascii?Q?Y6smam6iTPeRKZFqJNQAoJ72TJLzvkUZSJ4NRAzkkN9WN9ArNQ/1ZHB6A68k?=
 =?us-ascii?Q?wcgIalm0sJCQOcionV4NShKeFGFovUMED4K/rJk4ByFYZX52etUOTCrR4rW5?=
 =?us-ascii?Q?zQ4nN3PkGri65wn/n2mkERsHGxVdLGuCMm7GLKmB3g6b8KIyDAWqZzYJD+DE?=
 =?us-ascii?Q?pwXW2AByQMHll2Fw5b4SdoRvoKMPqMS8ZR10W+5izXPL/ZMyj40XNjyqpabn?=
 =?us-ascii?Q?3oCw8nSfdJGCMxu/qUaH7EeNgUf87efHUhniRTUYPe/VWdU9SKEf/b+iK2bQ?=
 =?us-ascii?Q?OQFrz19lsdRUsxyOgfsZtwMLW7VcIZ0/dXDWT/sw42UGMWxc0N5pnNbkJ/9m?=
 =?us-ascii?Q?yfZJg67hDR1JaXzbwMOWzq4JqCmkqzsjFZci8yKR0QgCDxXQ3rOVyr+Lsh/K?=
 =?us-ascii?Q?1mGQZiqtmuH0n5rqYtKDvYiB2VBnic8tloq3B9uD5U8bnAu/yfdyi/X5gHjz?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+ERtxwm6mO8AE3uqOISfCDVXka2H3GsgwVTCyDqW9fxlH+Fuy+ugLVux4nmu2YSm7c9RVINuzNCrswSuAAanE82m1vRcmxfW/J4jcJDgFvjrH197MX1pxlJqx1xnnCWYWfuIaS82C7Jex4Poo0yUl4hJLYykwvh9ys36+LsEJI99Q9NnM2HnzA3O0CyyLsxIuMB1uaC8I2cmwwsSAMQ03oTKUB+p1x7YyXLGfSwx8gFu8fBMNz80omofVoLaf4DftYRG3HspSLCW28I5jbXXm35LU/dWHFNXD2X5ODY7WuXgu7L1AU++G4GsCEtn2KjJ30LUaKf+/wmQeCTSsgNHYSwByI6tT8PRavchuurxJ4wTkBQ8L5Eqft5eabhFwt4tReW43t/MptZ2i9o7b5EbQaXy/6innr3GJBSOoRCZDWY5exykEZ3DHkKlp2cZEyHeqAq0yQw7ZV7udKQ67AFEXPkn+rQeN1VSep21DbYBeZDf3yP1DYcu81WT7pgHca8wkOtFTNKYuOgkEYwDYPsDADmXT+Nno4jRaZzlQBJmnrIgNA2GomufFH5p4zI6O1BuBDH+xZP0CdWIDQr/aaZn/MB+m26BD+rp44+oor+zRPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba669a4-8a28-4e3b-03c8-08dce9579127
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:15:48.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/HYwNMW6KWjw/T9EVOJ76SNn51kNNFCAeQiB0uHGexWJLyiqQyWdYtF3QTxzPiLX6utYnXKcsT8iqQl6vrZ1ApyC03mJQtzchbTR6qsWuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: -9BnUN349CMi41VV344tZ1bCFdZMGunI
X-Proofpoint-GUID: -9BnUN349CMi41VV344tZ1bCFdZMGunI

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.

RFC version:
https://lore.kernel.org/linux-mm/1d19f18c-5a60-44b5-a96f-9d0e74f2b02c@lucifer.local/

Lorenzo Stoakes (3):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  43 +++++-
 include/uapi/linux/pidfd.h                    |  15 ++
 kernel/exit.c                                 |   3 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  73 +++++++---
 kernel/signal.c                               |  22 +--
 tools/testing/selftests/pidfd/pidfd.h         |   8 ++
 .../selftests/pidfd/pidfd_getfd_test.c        | 136 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  67 +++++++--
 10 files changed, 330 insertions(+), 49 deletions(-)

--
2.46.2

