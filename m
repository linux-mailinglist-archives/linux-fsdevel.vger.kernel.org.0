Return-Path: <linux-fsdevel+bounces-54047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21BAFAAE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9E7A3079
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE826F449;
	Mon,  7 Jul 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YBKbXLwb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uS2t3HWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E126E6F2;
	Mon,  7 Jul 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866173; cv=fail; b=su+ps8ouYfiwF/4lmOdt3fF+uUeeSE7oCMluHAf6TdUBZj4MPpJQTZ3G0csYEP5EJcy/yFHF3hCRJJxHQTalC6CcmOS5ifVc7gPR3iGJ140HuBTn0GnMO4NjT+t2F+uHxAJcJQE7lnlVD3pbKKyHOCUawzJ6be4+5BCqfaW+1wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866173; c=relaxed/simple;
	bh=rM+gNUbucVSAaJXX0PQT8joEW4YYR8UyZdx09ocqJV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaoHBVsQiecd/1Tq/QKU6u5Oa/SyFRpllwqkE7Ejo6AIqNyeYapV0nzOwfGIGSh6uMKloCcecpl2kZjZj1CB+vsaaAtJC65y/jfCCv+TGM9nPUKwsQU3g2cc6flZlvezKpyMf/XFjNdmoO8MoXpuFSFTEdEVVx6MSDBmzHAlfB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YBKbXLwb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uS2t3HWz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ3wF030637;
	Mon, 7 Jul 2025 05:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mt/uNiezVl958yGt3Ra8dBDQv8TYGgz7gz5YY7QXtHg=; b=
	YBKbXLwbmTPyGasxxbbsfUD23v87mRH4skRHnRXVDGKnzNMtLVBUAV8ibjHfQS3C
	+Kea+po3yyIyqPT8iTjyNFZ3hUqR4ls9Zg6qRWZZnMSJ80+H4ei5p4kKuMg5oOAc
	CmZWouM1wTMxjYazp8SeIybhDRVOBiGAud9V6MSoOMNZ2QaZH+HyBf4vscEz6n/E
	HEMOkIels0TOgqSqybXXbJXCNEvIPZcNFNX/w4pIho2CdaZ86mQqbcFjpsEIgyaQ
	gbLuuMZ5JNpBn3E7jqJ7bH3okgUMsed6FNNnynWsNhOalUL7UPwA3aNV+DhLVyMV
	ol1+usKhOpKeoIxlVzFNbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptn520dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBn024285;
	Mon, 7 Jul 2025 05:28:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf4MskZLFu+iIdUuA639AzkRXLLW5mAPK8bJjp5/fPD0hQ2PO/pacFN3zjxRWtTjvHsjib3EBmANd/gQ1d9/1cwJZtiXvXbz2uDXkEt4yzeuJ2QyJDTvcJXmMpAdQSDc4qGfXGdcx5LKrofCbOIpKedhls+oEbCb2l4QVXk8xd+VnE/8PDOBuAnogzYqKd+5bi6FwarJhoU5pRzp6I1WlBZlQEK0ofirEDwbQ+3QdEfOxskfjUosQyNMZNI1GQOvbjvvkR9xat5G+OEJ3rYgyhaKYkrQMNMKs4HMhy6ywYUnrdYyFfpTYjJcZ0WXLfoXMZ0+rbw+71a2zKdmRgJXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt/uNiezVl958yGt3Ra8dBDQv8TYGgz7gz5YY7QXtHg=;
 b=zPeQ6Oe9D0cOp+HqmS7QECFB1WsIdToEEvT7rlJOOu3PgyTSLklzXVb4p6XZzTlKZI+hr4QTJy0dpOFQmmmfg54Q3WVLC9pywAD4NFHnCvlViC0gEFUSHogBo1OMc1PYoyuoXgBAewAa9FdkN4ZUfG45Mx/x/02HWpMrZYLS/RymZlqH+hYml/jqWLtT+b69us7w6egwISQoN5O+I5D00N5lUIRcf3DHo1VGU/C49glcPbf0VCjtoNu/cpb1gzGr/EvKD22UG1Y8iMPy1jBquYbyQZqVKhIpsbZpDzKeOFQIkyjzvyAyYgD06ML+iloGp9xDu84fbxQMBJjfwOYlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt/uNiezVl958yGt3Ra8dBDQv8TYGgz7gz5YY7QXtHg=;
 b=uS2t3HWzAlIWVMJTRPKXi5xlIRPAD5A7xySGxoSCmSyBa+YlhG8iA19caIqc0tYcbybdftLdReOtBxKFS76d09bx3XFVo/7WGhaXi45KV4KpzI66VPeOIgDGdmcav+LWuzIsKRuqwXaYmdDcSIpPEcg7PgVCc76ouUkGYjulMrs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 04/10] mm/mremap: cleanup post-processing stage of mremap
Date: Mon,  7 Jul 2025 06:27:47 +0100
Message-ID: <d21f091bb617d0ac31b6e541d6c6ce28afe880c1.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: da9beba5-00c7-467b-62e8-08ddbd17228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCgONxCenL1nrU7yUc6XSuBUeIhNU8A1kStP/akQMqwF51tPy2wHU6SIdQUJ?=
 =?us-ascii?Q?/x/8dNQiY6upfSPmAps08ne1yZcQ5HGj8CYHouqHT2F/3o+fA5ubhJsYYKUz?=
 =?us-ascii?Q?QcuznCDw1fc9IPmpojGL+k/3VuYfc4hfC7H45l1wk6trc1pTQCHu6+5hCaPH?=
 =?us-ascii?Q?hpkrvi/PngWpkwZ3nJ/C3rj5HoGckGO2yMB6kIDfY/HwoNHrPkKOvTEJKMVJ?=
 =?us-ascii?Q?8PDkY9stG2diMEgyTI10AtQdD6jcglS0DV8qSHAUTKS8MG8qqKNmfNKJml4r?=
 =?us-ascii?Q?If9j/6Sd0ypvtgQZF7fWvtNZP+1r4AJpID3KHuBZIwcM+0J3N5t7S0kY568w?=
 =?us-ascii?Q?JFxZZPhvgirwDLEM8CBrjOJwRqLOmVugd/Hgb3371JWC8BNMKkgvAo3FZPcx?=
 =?us-ascii?Q?/BitNRsOHZeekrxyDiEk2yzI0NFZjq68Ktj3tLuCuUIkykHtScVN88Z17CQt?=
 =?us-ascii?Q?UV/RdhsypCgVdGK9NB5wgKQrrD59tGw2u7tGuVi11jjbhwN1RkWR9C6WfSIE?=
 =?us-ascii?Q?C3STHvXscOUEPVSVmR06/S2zBbaTVtfVJ2SvuOQW1riVQRu9XaAfOF+I4sCA?=
 =?us-ascii?Q?krcgRnI/xkmUb6RQz1xbbYRS77o27okY/Bxyj7jH4DR9oVAEjIl3OzrRN8hs?=
 =?us-ascii?Q?jr0AnYBDRIW+BCkY7dBSaHTr65IK5hziZfDHeFTV/6M6ex0bhoeYJX7UIfN+?=
 =?us-ascii?Q?vZZJZnIy+qAFyvY1GONVuNf6aOy0Vg3zmaKbGYjjRKMCFccRvZHa3ySomyvf?=
 =?us-ascii?Q?UYvz0AL9Y3ux1mi5qPoqqJgzY6Wwlt/g31/cQCBttoM5mjS5PrIIFY/S00Gi?=
 =?us-ascii?Q?Xdb7+sR63cA0sLPgy6SZREBXTy7yGs3KI+NuzFAX16eLZuS7swdOtyiqYvF6?=
 =?us-ascii?Q?U5/fyYYW4DzeYf3YaSX+vlgmTjQADLt2Xz+w8ErxQvxty14DJyhJwtbZURsf?=
 =?us-ascii?Q?VkeXeNSf06wnb8oKwfBgmr6qslSPF1oe5UuxandchZpEg7HI2yyzO4Q+OA2B?=
 =?us-ascii?Q?nEfvQyW2byLiJkR2jJ2q5xi0pWIPz6tDEYnPiwfzfA/W3fSAdaioLgRgc+Ol?=
 =?us-ascii?Q?smSwoJvXlhtXU1ulE5OnEgkyEZvwLIIDreCAfBiOmtPC8AtICXOBHV/ubZRb?=
 =?us-ascii?Q?rXIQgu9nIngBxcnpoWByWoPs2sSlHuMpQcr7kFMPKl5KJQ+jwllDWhSUkb3N?=
 =?us-ascii?Q?oOeQwkKyBzxn1cqwmyzHYspWJxj06+SZ9+/iuwn7HuIzv+B5ch8uwdaGqfse?=
 =?us-ascii?Q?sWEt6L8xcgJXuC0nVrCgTWco+bRef1gQRKfC2vJYK3V4r908cFN5nRZHBCsN?=
 =?us-ascii?Q?BZ7uV1NI8DeAB1vaqUjm5Tho5197w6EXb9RgnhAD7kvX/8W5mI4NHRa7i3Ae?=
 =?us-ascii?Q?SrYBnke0PrwtDr1zg78/PEuz33+GdevBX2rYceTvXOeTqg5oLIzKko+ke5V5?=
 =?us-ascii?Q?DzocEPemKeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cn8F3YSOK4ycYCKL873C0LdZjJg+KCeFc98MMAQDOpUSEAfiBaSU7nsjP4Pb?=
 =?us-ascii?Q?QfNvunNBvKwDfCoXuPhvAd8E/9WHG7+X9Zvc6pTuquc7HoLCrynlr+3eOW2k?=
 =?us-ascii?Q?eJzlr9LGu/XfZM2xHUwyYhFqR+huh45pmbCrlo0TuGBx6zxxei/cq9bGbdIT?=
 =?us-ascii?Q?E1kUmvihNHhjQ1eZDf6/sJkBb09CJcqDpXkydYcwHSy1eDME/L/0IhecY/f+?=
 =?us-ascii?Q?kcQVo047l5qscdmDHfOfDFrPVlLilozv5wSXMdMarpvaUbt1BttUvNKiE7x6?=
 =?us-ascii?Q?QgZsXjUNRVbjGsXu8hanvwSFw1+npL0tLiVI55WocHbKeGGK3FGlnthk1lQq?=
 =?us-ascii?Q?579jdN9MvW6Rh9tBj79t9yy+Ed0XGL2upXaJmF5y8+AMUXmoWSlx5CTo6E+h?=
 =?us-ascii?Q?QtLFcWRSIQAN2Sa+b12gjb3qNuW7bvpSW3Uc/r6TDevcNygm4gSo5YD64q++?=
 =?us-ascii?Q?PWZ8EPLIftZJ32QR1m/18hN4M/A13ZFYUPYDO9CSBJlbmHfLAYkTcROks5JY?=
 =?us-ascii?Q?uSgUNZr+cN5ldU0VWUXZXPjKze06pbppGkM19AgKQaB4s4fGKRtxoViYA5/X?=
 =?us-ascii?Q?qpmtGQqM+fpXH8Agb+VTzXZUef9rNP1eGvw47g1smW5ep5oJC2jRgR8WvKzI?=
 =?us-ascii?Q?/sN9TXzkx8rzxPfVDTitqf95DAyrQS4LnAkvecGPSqaS+dUSkEp98qE14p2N?=
 =?us-ascii?Q?HDHV9lYWbw8tunpo7YzVQDVfrGAakr93NiqjnNY9kwadOh+d+J12bAwpuupx?=
 =?us-ascii?Q?6yIg5y1B7Byni5H7esc/QaTO+84SRRqCbwoFGO5ZsTLIvRwktmDw74QHUVvu?=
 =?us-ascii?Q?omf/D1k6Wo/l/YMUYx7P6Acl9S8f/8t8xaUpOgNOxkE3shZB8COUuK75Jkll?=
 =?us-ascii?Q?1nbGedONLQKC+NRxBKya3BUsNO8EAcqvzZIQlXSkMWe9cVOZCZiIZ5klwslB?=
 =?us-ascii?Q?gQyF0MIlOZabB71AILBtAPkET46Vn2YpawKC6D0ukef1Dp93riws2/5pMA74?=
 =?us-ascii?Q?j8CFHmjgFchdn7/uDUIBJcAn3h1W8m9wuJ8obAP1Rqdr5vW2MapuJ88V7IoI?=
 =?us-ascii?Q?QNvgRZmc7DaEl9rdGxBWG0WulD2olycKU/4BwniZDVVYq8Ns6vgVCxN6i3TP?=
 =?us-ascii?Q?KjuPlZ/Pn7NvfnBZZ86JDC/Sq8Zt7/8UIpNNzrKAwBdtUZ+75CoPRptreWPK?=
 =?us-ascii?Q?GpXcgY0aABGJBcRcdc2aRcvRG0RCrFPU3Ki3yIeJ4o46aS+T2pkPF55qFejd?=
 =?us-ascii?Q?B456SPz+jFLnuVKKx7A9kGUhOlxAQmtYu6pnYTgraP8k909vqbaUQaWOvQJq?=
 =?us-ascii?Q?e6QLd5ho4RDov1Bx3kFDt+NKVeBkKNaE9Moz1vvvu5Vrn8MIfx68nzVK9xLQ?=
 =?us-ascii?Q?k+a1tKd4Rcln+KzBGFgF8J6jOSrQ7D5FJx4JE+SJ0/eo5i1OlZhXLN7OoEAl?=
 =?us-ascii?Q?ET9++8qOKlaw0CeYRGUO2dimT7A456BSF33uRWesFNjyxsi8iQr3UnIXI7eq?=
 =?us-ascii?Q?47znsSx4DiI/VWlm51QfOphmQs8JILLAMJ3tm0zeQLqm81sGB6fspjKti4cn?=
 =?us-ascii?Q?ITijoAymCN9jlJti9gs3IjgmCfWyTdIY6eVxWlzayHlWAEU7RprQEz9xlf/S?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHB6a0Mrzo2/c0x3SRBO6YofDSIi5PurNd/B61SSsS/a/W5LXwPabHMIBKKUo/cQ8MvoxguUdG6p4q7J5Q+TS5Edg1hhtK+7RW50O1hMlcNQLiR2vwUJ4gMstN5cfAABaOyVBPea7XBNOJsWVDOF6RtCNkByD2c99rkdCtS5+KKHu9SfxH1W4bbwJkhvZTjHUQw7msTrRaeDta/XX53fOV49v+8A4/Xs+X683IBaD08isIPfz/9ripKOtFh88yksLMPv23ACAKbfsU2Aw0or86vbhLwHOP0yHVb9t05/KLGFg7bow4WgvugaLe1SJMDl2syNB4iHpXI+freB/BzVw4kS4M8wzaE5nGMUbn4Jk9X6ftrtKMcFn2n1yoikQm+88X02xMU/VktctnlYRaXw64ep+QedGOSEXM+xnfzdAwhfHpKCpy9cOzGyK6s3vjf6QaFkviCxM9EOP2UESfKB1gVGD01M8J20YCLnuZdIJmhUnP0i1ONL+tCnhbBOFXItfjL+SqhSmgFbr/RvyNduPvT/ZBWl75JQDIlGVThvw9v762YNk4ENnnsfCVg+/T1u2cJxtgc1n+9PBnUlqV03ndpMrjG+IC5xbxL+mENCvKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9beba5-00c7-467b-62e8-08ddbd17228d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:41.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqsAFklCOfdh1PAP7YajU9KdLteIKQ00572Xvb29+B29BvK+JdW9v30AQos4vD64aJsXhJjb5yYitv/AX8dVaN9Z+FcrJGTgsRmWA330cj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Proofpoint-ORIG-GUID: 3VK0uVGLmKJiGwOSA0AE4DrVkC8I9hQz
X-Proofpoint-GUID: 3VK0uVGLmKJiGwOSA0AE4DrVkC8I9hQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX+yMX50qOt1th 2nUOe/CgIU+8zbfcmt4nKTPxJzUxHgJLAfTJoXG9NUMsIkqqDZGusOCl2sIQYR7zGH8F4VHaxEx c5OXQIHXKD/S9DZUvcBrAJItVH2NsyBTureZ04ZsYEJmFRXosBU9/ELR2Do+V+p4NrfSvtmBRD3
 /5rE2Wm4RHWBCdEpBFjKKdOTCfSxwgb8Kclb56WVlzEKC1eRwzQrjxfKZTgRFFi2Wsj3An8hZ29 K4p65/IJqy5a4MDo0XEdJUjC6XOv2ODtBKnqOSnOFeBJv/douvXvPchn5JdlzzpK+fIC9JWucH9 eDoRi+FCaGdHzKisHHvc/9bt+WUP+pbCIB/Xbuf3uwN+aZa2GAa+oqA3fhwH96GjN71pt5Kfx7H
 gBrU9TQGezvFmDwIHwAywPrDuso+pU4bbDLBBam8Bj+uBj3bnfQQQ0P5+JGyloviQZYeMQdE
X-Authority-Analysis: v=2.4 cv=UpRjN/wB c=1 sm=1 tr=0 ts=686b5b1a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ULdmrcW3YHslXA7JyQcA:9

Separate out the uffd bits so it clear's what's happening.

Don't bother setting vrm->mmap_locked after unlocking, because after this
we are done anyway.

The only time we drop the mmap lock is on VMA shrink, at which point
vrm->new_len will be < vrm->old_len and the operation will not be performed
anyway, so move this code out of the if (vrm->mmap_locked) block.

All addresses returned by mremap() are page-aligned, so the
offset_in_page() check on ret seems only to be incorrectly trying to detect
whether an error occurred - explicitly check for this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 60eb0ac8634b..660bdb75e2f9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1729,6 +1729,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, unsigned long ret)
+{
+	struct mm_struct *mm = current->mm;
+
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1754,18 +1763,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
-	if (vrm->mmap_locked) {
+	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
-		vrm->mmap_locked = false;
-
-		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
-			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
-	}
 
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
+	notify_uffd(vrm, res);
 	return res;
 }
 
-- 
2.50.0


