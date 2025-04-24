Return-Path: <linux-fsdevel+bounces-47295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88444A9B9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6331B8154F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166628935D;
	Thu, 24 Apr 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1/+ahXu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BroQdtUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B428468D;
	Thu, 24 Apr 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529360; cv=fail; b=Gl9MpWqqd1Y15EF782lUXeY7yLeaUy0y4L6c+xUfxC4spp9Vkoo0QeJ8eGeVQdCLb5eqT8MwL6UhB5VTeXbW0RICbS+m2NucMoc2z8/jZMy7NySew1uzYhd5HuxqVcQyC2JEbbQSdOd9dPUwbCb7JvkNuU+SIIx+Qmwi3I1/gNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529360; c=relaxed/simple;
	bh=trgS4T3Wb0TtkRN7sVx/klRDJl/SSpLtmRJ8UAEGjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VrVhoxk2KS4aS3qwBV+X8E3XWw1MyXYsnWFO4xQ2k4IMIscE/tBZYah9DUGICV6fZtrB6voKmbwhvHFU9nWFzli5nwFmTHcv2fYqAO70KsBd8XD3Cu8VpTTHmdG2V/HZwxX4AjU/QWbfPH089LBibdlWAh+KqqZajagIKF1sJZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1/+ahXu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BroQdtUf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJggP9013210;
	Thu, 24 Apr 2025 21:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jwa3zdU9B2fjyWo3
	gy4P1A30erKwdv1GIQYalflvsxU=; b=j1/+ahXuEeWXl4Elf8UypIWA6XVbHwlb
	4SbmwewV9zIx6u8Dbl5Au/oFIIS8VBFAvBX8CV80ShsFTDD3nogjJyBPj0pQWWoy
	6d/pScI+GBfMYDXAtmqIvpP0Pim1JD0fHeb9PGr39rE8neSv9gGXeY7udPz50lcU
	4hNPL8AhVQu/qIarXJJT40q3wpnNfQRwI8hGiNA674i378sYM2oTJk6aV1pw7BnW
	HSUTxuDrNiOU0Ua0FTtnWB0eHoHvjS3SGHey6HHseBqeCRkFRxkJVlJhySqZlHkV
	LIMEwHyS/L6w8cutWPPr5kVYQS80kQxaZK2ejg38WS3DXKngOjj8Wg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467upe07h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJ9Q74025240;
	Thu, 24 Apr 2025 21:15:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbsmggm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gywjNIL5VAKINt7XbAUfPzfnCQkiVssGkFMdBA7j9Csz9LQgqmjhbyJ9im6i2GVGRqDTETTQCDehjAI/37hofFekMUYvNlBiE3pPc40BX/TZL/kvqG1JZZZg23gPKpzb3NLSTDxbDotFBceQg5C/Cwp+2buVG6B0BD89ZHZVIuqcIdQUmYz+YU9k0ZtPIE69mm4vZvvjHhaudbuKnoROE+6L5vi3CSP4fJkyGCbPl09XGWnQuR4tP8uumhvm5SPdCfVjYuQOWBYhLhoK7VjuKdBGZgD1cd3TTF0eoaXqGUpVmklpSAiVwuLMrVpG952Bsilfq4etsnfpnwChtpQRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwa3zdU9B2fjyWo3gy4P1A30erKwdv1GIQYalflvsxU=;
 b=iXM7cYmeZZbXpXxeaiMl03rMyrt9P9VOuiZpOH9A7X881TB27/niy0GpAOvfOy2hiOexr/+R0ND8ghI8n7CZrL+IJwyGKQSqNTKId/bz8GdEgZ7mJGbTsjB7rebbMQc6W4HqDQgxCyslLMDhHuErUrzG9Y1khxrp5SxBbpA5QVSh0FsCeg0ZaSEptTYgV4yIn051BdFSb6bssY39GN/GhJTCykjGrq1wxwG4lekz1w0jBjZybxPCDAVeeeFnQE/F8quqsr6LTTHblbRAmp/BmXyPxeJvud4uraZJYmFqvsQQguQJUIsTRti8pncN9XoM8N1kyT5a+eJS8Ovq/MMWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwa3zdU9B2fjyWo3gy4P1A30erKwdv1GIQYalflvsxU=;
 b=BroQdtUfaAQztA+mEonJCp6PTazJ6Ufd/6pK7pHwUHUgZVK5rManA01UGIzDc9Ioh+g99w+EcH+QwOeRUteyPr3Rbuw0elffyXrqrkNDbaf1T09FbL8NXUcNTk8jE78dnIwOJ0Gimf154bHMq1ZZv5Qi9NAOEM6ZAke0YVRrd3Q=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 21:15:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 21:15:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] move all VMA allocation, freeing and duplication logic to mm
Date: Thu, 24 Apr 2025 22:15:25 +0100
Message-ID: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 978a97b6-3d4d-4167-b895-08dd83752a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RuA+EcegQItjFw9ymbnKwnZJWAYzOqODB/Tr1oehNKjC792caX6+5ETyqiBZ?=
 =?us-ascii?Q?rubqTojktXMBtUpxxJ3iagJxe1CjllXSiePo1U1Nm4P2MI4E4kpioJbavMWI?=
 =?us-ascii?Q?XlyICq7yLL5v3kNEtR0dbnfJo/WO1RimenGlEmJlC9CA6u+7JANaImROpxFE?=
 =?us-ascii?Q?A4G8EYWfkNhLzNZPz/s0E9hvS47BIRUI/i9j0OvE50kf593GHAskl/AaKX0P?=
 =?us-ascii?Q?iVyD/g989O+umOojh48xN9I5yqTrQ6FzSqnPYY8AhPEAtuCM0nwuiCYvxc7d?=
 =?us-ascii?Q?2EBZxNzWlUBGWDhnMoSaCttp/iENJiyDqMxqW1Su9Q7Gm9Oih9+5HU3+ATwD?=
 =?us-ascii?Q?euiOgLQ1muEgfszHFWL7epDacVvHCbrE2qkJlQRMvBotxa+8tGS7XLoexDqE?=
 =?us-ascii?Q?47x0PHFpVYzNRwhGPi+BF+VM5HUPlJFfDxx0FQ3G1TfZlEgbHcuIi0hO1YEu?=
 =?us-ascii?Q?Rndf9AshIjx2jfIByij2/P/ZHe0DMUfzaoDBG0Twg3W3DzO/poExslg7ceUo?=
 =?us-ascii?Q?KHYAcj+50WdjK0/0A5UIxCXJ3aooRrHF8qiNO0wVoi6GVHYAVawlOVEEtg1N?=
 =?us-ascii?Q?wv2/mhcrjlQUM0xeR/NrcST7htAs5NUYXIaBXZf5rtfbqYX5Ecs95ULM736c?=
 =?us-ascii?Q?IPpG0yDI3l5J8Pdyt8+UgmpZEUD+yhCKdWgKuB27IMBqWWQLfiivivAVSAah?=
 =?us-ascii?Q?KVm8HOyJLY4OMl+tAnWUPhtWKKgZho6M7dJsBS+MN8NPIcgXmkJW5eW0Et7O?=
 =?us-ascii?Q?2y91panOoq6l8P+3AWzD6pbvJTHd/r9WFkADx5TauvQW4EC54GsS5qbYNoiU?=
 =?us-ascii?Q?PHrKyw2OVhifQ/8Cu5e/SEw4E4Wod1xQUtG4NNot1IRrxR+EwtGxFwndYMZK?=
 =?us-ascii?Q?kIgdmF1228uY37Pnv1SD5AvVOswFE3b1anNhHBURHsoHJFV1nvRIKorFzJOB?=
 =?us-ascii?Q?um/gaqxZmIjqOWK/rhbPonohihKxP9qFHPe5JQquv/WepZrlAcZzFNYGoOHu?=
 =?us-ascii?Q?mMf/PVCJtm6jp+IzxSIHTU5bQ7GWx7RvVgTtgVyn52Iijq+RwP3265Dnn6Nj?=
 =?us-ascii?Q?mQ2ILC2+ngXByRM6qXrRsUjDLAE2TTXG9dIPZA6GbQy2Jr7eRzOen8C8D8hx?=
 =?us-ascii?Q?1o/zp/WJDVJAr/Qp2zEj9qeT7gsLRlhtOweDKN7I1ZDzmF48VB8QA/8owg1V?=
 =?us-ascii?Q?hUUsfZ/3ScYoNEi8jgy8XI5C0U+Aopb1xgAwMuI/i4PdqUX5UtuS1k3I9l2J?=
 =?us-ascii?Q?byhf806qTK9YxPT/Fyt3ujThVxQCsuI3wPKATFYOYRy9RSvZBOTNsrOeJUL4?=
 =?us-ascii?Q?D/VICjd4kbQ98ThquHb3jJhA0QQtuDLUQFnWSY34ww/ZrYAk/EbF2P+7vrMH?=
 =?us-ascii?Q?ASB8cc8METxtB86E5lw51aCX8zC1JwR+Gqqvbe6P2nb7NPxPp4fjb7YNQhh7?=
 =?us-ascii?Q?4W1by88mZOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?as3IAWJ07hiqdwmM6hc+Dwb4ahz/ctww7s8+Ahtdo8EnptFIcqYpOKtBN3T9?=
 =?us-ascii?Q?EP4nsQPel3deQObtvhy6oOVobKK2azg9H2uH8NU+JO27YPog7h8KgXO1PmlS?=
 =?us-ascii?Q?REPo6CJecVhAQI+0qrDm3x2H0sxwwpEaZlzc/UOno0YhnzvhmcJvYAHvN9+F?=
 =?us-ascii?Q?1KH7z+nMqwYssqPmHmLCIAiIfGVKnJVaj7yzS45am3Tg5D/4TD3Zr5wPaZ2n?=
 =?us-ascii?Q?xopHcjRoWN+kyVnWtK6/pntX9OzucE2ypdCYUWyWZGM8rc2TN6qf+OgDrEIh?=
 =?us-ascii?Q?mKAsnkvyhZvNF+DR1ssukJcFlJl90opv75jhS2Q3kP+CnZXrzhuJjtCjee0y?=
 =?us-ascii?Q?Zr2UQZVqU2BrC8A+RQGVZgejJbSd+163L4kSezuSRXieTup1f1U3jjKIyW/K?=
 =?us-ascii?Q?ceL1bLHRGyVuyIWIGAUoPZHybxyXOZjB2RALwgG0rlfrje2K6i2dCjY5nEBy?=
 =?us-ascii?Q?tGTpcJZBt45KRFsU0OOVMgj6xM52SZBA12gTAGpAvfT8XPBq4hTNVcfYW5Rm?=
 =?us-ascii?Q?VExI04Rl85jb/1Te3I4Ivqgv/AysxwgoSbjc6eC/ipbA4czyMuZ7vhF72SrZ?=
 =?us-ascii?Q?aX8ajj0UjoW8KYiJVmfiCwPM1Zd2qJ2t8ly9uV7D3OHHvLWxq4QnD6F3WiF9?=
 =?us-ascii?Q?6lodewYsbq+2nXrvAptRGnIKHTvm17K3AMfFphTRU6jV47/EjBWEzrkSzocs?=
 =?us-ascii?Q?Sy13Lv/e6bfm9qK9ZQ2ykVhWouBJC6mdyoqp1UvzJVUTPw2xe/aADxuyyxTO?=
 =?us-ascii?Q?ohkpAbr1ncWwkWGDnXfqTyBNHq8M6Wi9p5n8rjajng7JBOHY+sSzi5o/4O63?=
 =?us-ascii?Q?IlnAquqzv82L+mQyMrN8Fs/ox8xZ+WcolxUyNGKp+eyECdPqdFWsjgJQTN6R?=
 =?us-ascii?Q?EvQWCwd3I2UyejVp1Gdo7jPpkQLoAnM92SqL50ciUcRtiVIMUtqYTjQ2cU6T?=
 =?us-ascii?Q?PnW7LBkENgaczmEHPdgFpk15tehqbLxAdYQvqZe8cq3gn0LLDY+JjpC43M2t?=
 =?us-ascii?Q?mFbWq2YwZERUgIK6rOkHoXROgmYwld8kjD9Mq4NGb47KNxDpXjrc09fCI+UY?=
 =?us-ascii?Q?Mlgjkg5B4JIR93/rmwh150+FxAk6Ep1Mf+luhdRoE1nqT13w4Sa7Qdh5dJNr?=
 =?us-ascii?Q?xmyf1kVhnxq2nJg7eE27Kkd5FtGZMKT48a5lnsMJLKleKw+FoFb16rEhKHQN?=
 =?us-ascii?Q?rs2FuNXSrxQSlkG8nXgAeDeKhkXPg8xiiIDoaKu9oz+DQPsOO0cqignWeIsj?=
 =?us-ascii?Q?5BNHBEarHcsV46qnyHpNgMURbc7ZWyMzlIzY0RLbN+L1RtzLMrsieay/Mbb9?=
 =?us-ascii?Q?NNU5+Da1ZRfzHfO+dLoJE1xluB/2rd8uWbLvGbVeiNIf8tMnKws/JXtVOwiA?=
 =?us-ascii?Q?pcfocF9jmG1n4x87PUod2f17H/IvcOb4CeXX8r/uBpeVM3Brk3GjQ2pla/GN?=
 =?us-ascii?Q?0/xK/OJhW/dSHRml6G/rvGtcGJgmrZ6rYqqp4hVNfjoMOeRXeeJ6Y+nBQLBw?=
 =?us-ascii?Q?KcZA67uzZo7TsOtiD7q2Cb4xGeLfB0/PS63xaO4P2zsI/xUK4S3VJAHPO2Fq?=
 =?us-ascii?Q?ba4eilp4EIN8h+d/XFErvCdxGDz6xuECooTlPT1E3fDv4pp6EUflrwyUt+mC?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aDUydF8LcspnfjSmFd+bCxGcTFh7H8wo7vYd4ziLuIZIXsvn617Ml4uO5maKGWb7+HPChgrk7b08cS/9seEZpTpdUkQ3qwbNj/XYzD2buCARPdlE3r1TOgq+nsoEufv4QoCTOFM3nx7THrZp+TUbFJ51XD/+f5keybVZhwaPU0mD5R2YP9/5A5TWPxsxrerLZE40MgACyhMXqnMy5j7VU7X1MNmiz4ITbkWp/uu1zGwU3QtVn5HU1oz5ikgnI4J66yRKoqI+J870S1T56hiHgeovNzfdpgrz0ZFRyZgKYVc/+d8GU0ETYQ+Ipo5V/n6RrkY+hwk8EAANtxVQar7v65ANMq1YUTUdQuMTpI0UoKoj1AV9AmdebjlNB1Vb+43A6nCZEmH9vAJNH//JmvW8bBa9w0eL+DXdXC2Lw0qLDL3QaQpCpoI3ihWp5ofUm65zQzviNzleR6Ku7jaJwGHL1Gm/uNNM6aEHP9lQf1oOIRnni8agZlRUxsRUbHGWHk9Mv0mLrrQFCTNatn9Z8mvponLOwj99SJCXvu2kCUKHWKWcoSLlW3B4pZizyNcI/+gw+xUN1AcVFaY+QFAtfGKtj5Vo+iGTYfQhkHrEKT84YSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978a97b6-3d4d-4167-b895-08dd83752a1a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:15:39.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD0Zw9J6elwhaB2B++dZZwwg35mUhOHQg36m2E4MAeEgwnH2p1ZATU01KPOj2ujcjL5Rb6XtVN2dxhr32ML1txo/6aDjpfLAq83OUT5CLpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240149
X-Proofpoint-ORIG-GUID: 3GL76HGIgQcbRFKJfj1eS80BctHYcY2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0OSBTYWx0ZWRfX47pcmfioJ1zx yopGmoGTqvQJss8Zzqhm6tEiiNRCSIOFDAdLk3uNfMCTYIv/IvJi/AYmzjCrcQ2gOkDax5hzWU4 Ek5s9wQsAOikIF+gNralYz1YADbrtNE5IHfVumVbJZ2FJW9FwnpmKoKodqGtXNdUUoCzaANjF7y
 NzC2HcZL+x3xN5w4XPiG3ZPeHUpphIwifY6XJUDFbWJ10OGuzx/KByQRMZwLJqTLkS7NpRKVPn0 Mjr4ddtjNSHfzSsxwVbHpTzvKHuLH3PiQov7mGHIw0NOnoteYE5+JRARxTy7SRXKTaH+zZjs97l Ozs2oUtv2ORaXhdkmBUYo81YpGsGrdlxdS4jhqIIr6cu7zEuI3G+pghxByrbsFgrSTQS2+tN8N0 E7N068SG
X-Proofpoint-GUID: 3GL76HGIgQcbRFKJfj1eS80BctHYcY2n

Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
which is a violation of separation of concerns, and leaves these functions
exposed to the rest of the kernel when they are in fact internal
implementation details.

Resolve this by moving this logic to mm, and making it internal to vma.c,
vma.h.

This also allows us, in future, to provide userland testing around this
functionality.

We additionally abstract dup_mmap() to mm, being careful to ensure
kernel/fork.c acceses thi via the mm internal header so it is not exposed
elsewhere in the kernel.

As part of this change, also abstract initial stack allocation performed in
__bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
this code uses vm_area_alloc() and vm_area_free().

Lorenzo Stoakes (4):
  mm: abstract initial stack setup to mm subsystem
  mm: perform VMA allocation, freeing, duplication in mm
  mm: move dup_mmap() to mm
  mm: move vm_area_alloc,dup,free() functions to vma.c

 fs/exec.c                        |  51 +-----
 include/linux/mm.h               |  15 +-
 kernel/fork.c                    | 277 +------------------------------
 mm/debug_vm_pgtable.c            |   2 +
 mm/internal.h                    |   2 +
 mm/mmap.c                        | 254 +++++++++++++++++++++++++++-
 mm/nommu.c                       |  75 +++++++++
 mm/vma.c                         |  89 ++++++++++
 mm/vma.h                         |   8 +
 tools/testing/vma/vma.c          |   1 +
 tools/testing/vma/vma_internal.h | 151 +++++++++++++----
 11 files changed, 550 insertions(+), 375 deletions(-)

--
2.49.0

