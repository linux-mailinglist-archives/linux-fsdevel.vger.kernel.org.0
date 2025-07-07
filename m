Return-Path: <linux-fsdevel+bounces-54108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D5AFB4FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77621AA5737
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A93F2BD5A8;
	Mon,  7 Jul 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0bfDn4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sz5XxaAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606C2BD590;
	Mon,  7 Jul 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895865; cv=fail; b=M9eVyye+PAHRmFQf/iEZlFKxB339e8+NX3475D3JFgFP2Ter7j2YeyqqcueuqfJfCMnvS3lnDy50jQGRqknOrbLybbhAR4Mr14unBCGy38P1kw+erKMJlvKMbbRGdwjqJOvznGIuY43KmCjECytrCSDVqKmYmeFC8C8QvIbq2q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895865; c=relaxed/simple;
	bh=CjttOLUANXabXa/WPgbryCREK4Mrn6lIpZRCmNJjVX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skn4fj6Ora5O+G9b1RtrXmHT0Dtyw8VI5atTjJU6GYWSiQRnVyZzFAvJ+B/m/+ktVn1dSI6abV6tAOHwmsow8CLIHS1rTc5iRx/O0EVBEN7F79XqTtXal/+I9x9Z05Yk5wdn1ZqxJWIB/M6l7qZov0GSIH0h31sC8LwnpNONk5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0bfDn4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sz5XxaAZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567D2dpP013360;
	Mon, 7 Jul 2025 13:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vpS055Xxe4QlgQFPpH
	EY7FALX03Exi2dxwS/x8cu7B8=; b=W0bfDn4E6HJSre0+FmKGxivVplHlwxKat6
	k/IuYNsjbTlBO++NIQW1uPGBf+GnMYU4qVPTEpHdUnChJd/zEppMAt4gOvK8AU5+
	z9g8D6kNdU8xPx3VYhPRTibS/RbNtGIMffjy8viWDN/uYr08+2yThnBTyw4BMiyZ
	eKO8HFfFWuB3N+WdRwZw8wCZzYiQfoHHE2+35PZ561/GIdvclcQZQETbMO+owbsd
	r48TbDHOLNYrrcFnfL9zbsgs/IibtdPI8u9ZRh3boWTlxD2qAvqTA8ZtPxIuARmQ
	RsRSUEqGB+SsKSxKehMkdHrBeTaKVtuFsrCjTIsfXanUCOxkrWXw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47res003xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 13:44:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567D1glG027319;
	Mon, 7 Jul 2025 13:44:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg889we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 13:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIaOe0AaVtxOoPCjlAjIzoVGhVtVdajCFV8NUPH/HMrB57tA47I7CEteS0rYn8EPiAzXL1Rx4H3Jh+20srIOwLIttfJWOulXkrYzXafFWdLWjo3xeVEYE+B70ASoiw81g1xksX2u1ow2jIJVqrYtA1OxUj08cv7vJcRxHdBA2Uk4uYGPIeMpMjoYh/YCSosVGgg2ekMIPF/F2PiDqjhL+z2hFWIoS6L4Yz592hxaLA0CGzwDNUW9kQlHMnXCjtMu1XOaGG8abmXxV3yRJwSKyNGTsgB3h+7TpCv+sgUiHJ8ktLMCXHMFrJZ2Y5CtkDWkDdzugPwjzxfA7LWovCvq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpS055Xxe4QlgQFPpHEY7FALX03Exi2dxwS/x8cu7B8=;
 b=ucgWLaSWpYo6OHAkO3gn788ZUs78kDZfvR7ox+BqTAyy1Hwep8SlWkM882NIEDFR50cWVRF9bPITekWtyR6xXbiELLyXJFa6QxMTuBSZp/ml+8YarbBQqUkpdAtEAGEC8prOQV8pUc9u7E8op9ntNJ35fh75jJsKgUXi45jj03JL1kT7+Qb5dkzq6q2Kmu8BxEZAZi1U8VcRRwJVFvy8mmbNZ73Ux1WYnX+I6ecYx9hCVDITouVYQ4Auf9eQH279I/euVBswKsJZx//8JeYONg5t2vtoMjk5V6EFlyLtNTO1Lt1XrdYF0EHOO8C4ojgtm7j6Jcgbt62I92XHE8+3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpS055Xxe4QlgQFPpHEY7FALX03Exi2dxwS/x8cu7B8=;
 b=Sz5XxaAZfkK/x1uzTsRCWom9kKOr0SNuR1gWEj8cfENtXSmvBDa/5VrqM2v/AbjWRFOvtwYut2QaRYLc9xh1x/wZBLNF3AXNxbOzFb9m8m5RZdXAG+1PhpxlT1BtlhW/UP/LoyQN/A9wTl7O8Z7arkl3ENNyPPrkmVLS65JnwKg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 13:44:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:44:05 +0000
Date: Mon, 7 Jul 2025 14:44:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+a5d1c9dfa91705cd2f6d@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "fs/ntfs3: Replace inode_trylock with inode_lock"
Message-ID: <d18a4aa3-bd7d-4c4b-a34c-48ba7f907ecf@lucifer.local>
References: <20250707124738.6764-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707124738.6764-1-almaz.alexandrovich@paragon-software.com>
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 04abdfc7-1f37-400b-3b5a-08ddbd5c5750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUTAB4AcEevafSSa/lZHxP61ueyimq3Wuj2G/O5itkdKVaokV+gcpagbD7PZ?=
 =?us-ascii?Q?lPaHdHfiFCB75L80jOeYjOWd0hVux4NV4exOYnjXP1VlmRh2b90JR5/9Q/4o?=
 =?us-ascii?Q?rrpWus+rRRPtnnR/spTJrrXcbwo3m2nxWCejJAfnLUkSnVy7fmDpX0NDEWAt?=
 =?us-ascii?Q?1vvf4v6p8PpF4tvVYFR5ddoixTnekHzEH8cYY7ysLfzSme8K8KDi1n78MUX/?=
 =?us-ascii?Q?kg47eAUdyyGP0BPhYcaoKcnigcOCNIffORDWOHmz+Q1EturSm4asMYm32bfr?=
 =?us-ascii?Q?NmjMcIi8DvepWoZHt6cO26JJ5SUxmJRgBWQrRPt2N02GwdQL2mCQbo7bRf7e?=
 =?us-ascii?Q?cOlDx9VkNSzQmaaJRICrUlFpqwd210Emjxtav+YuzKSDKEX8cc7iWdMNnbnG?=
 =?us-ascii?Q?6vo/cbePPhkNLG07DQSMvNTQWOqFSS/FKTtU7UuA1iSV3giiEGepU+5J1B1f?=
 =?us-ascii?Q?yfWkgeXy8VYcmqaLzEOhO/7G5vIKvBaEgJgj/X46G+cxNiz92yY5Iw5UvXWd?=
 =?us-ascii?Q?H8Yu6xFFGj8VIWUiNOPdK4N8VQVHJp6Ww66ldcGrTu6jJSUPyYjcVDlRWKEK?=
 =?us-ascii?Q?+E1VGqLBhelvErjXL7y7WMQAocTODOyyfgO9IkPgwx0syvnUJldVN7AkhbsC?=
 =?us-ascii?Q?yc/4yUvp13m/4NNqBB5cPqoiJrx/TYsm5qHVENngZecfSwU0yI7pq/Gyf21w?=
 =?us-ascii?Q?pWZp2AgRHazLuk1QvPEyHTYcJnsUPTRW8nzQnAjm/V0CyOs6GjtQvqKyxVLU?=
 =?us-ascii?Q?6IW6ZW/Vcyu5Engdv6onNBn+9yRzy3GUPy663UjrpSXc5Y928Dmu+kTkp5dm?=
 =?us-ascii?Q?ERuNLDDR2fIm1JNiZdNr8NTcroJew8sgjbUuQYOtPzd/Co5B6Ma5jQkyVGI6?=
 =?us-ascii?Q?V1Y57dqNsADfqwwJ4hB1Kk5EVOfaYIs1vK1GnzpRadOcmBkI/QzowvqrTZtj?=
 =?us-ascii?Q?816BV4oxXSLk26El0syCWyfOj3NfPfKEuh+QWTf7rObGVgzFSqcl1bFfT9RD?=
 =?us-ascii?Q?TG6Es4FDyouoin7tm0IS9DZnseyOFV5hGsaDFjxO5jlOE043JJJMhYi0DRWj?=
 =?us-ascii?Q?Fnrm8VC202sgILLDZ0b0LAI7K7TU/tZzbyoRBCSK9h3FGsBfgAdaggTd8cVv?=
 =?us-ascii?Q?oMOQXZDuzFk6OjSCtOiwz4QJ7sNC5oluw9js65z+qzE/UiHfRwRsFcGdPul6?=
 =?us-ascii?Q?6wNjIjaKmmopqa4MdMf8/lQ7Oz6N4lWb2AtaQmp4PrVGi5pT5A0C51YeQLJN?=
 =?us-ascii?Q?zt4ibI93WO3o0TeqM7KbLvUg9QhL/+vboRb8MiOwXWegHkav5tPPSYKgE+Xp?=
 =?us-ascii?Q?4TbXWB4pzi9VZXIS6uYBRFjaVL6sxXL8gicKcY6ZKpmuao4glBKKhejY0h+b?=
 =?us-ascii?Q?5FpQrDsJ4Mfv7Op87GiwU9gy9b+LJzDlf56REbjqomaNYjh3t5FAxhubFj9e?=
 =?us-ascii?Q?0w5AOFjK2x4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2Cw+fBX6gJsShFnG3sHNewFpmV4tiM8CUmfQWXImjfnOYLvADZ4p/Upl4pU?=
 =?us-ascii?Q?XwO++oQHmeKolMZbrPOn4rbbYuzhauEfId+tcRq30K0i4yIvNZvC1L1D2qBK?=
 =?us-ascii?Q?m8fQTqZNnfHAWa33b79vcdWLb0dAabal+30Uio/xWXCAPw1qOpLOyB+WjLfh?=
 =?us-ascii?Q?KjcG8rM10kIftzAv4OPD/ik/wKBNAGmmgxuvUiojN6EJxySZH33lnnNjrgud?=
 =?us-ascii?Q?2vLiCP4cOZgXACIIW2Cijio+k0ZKyc1Wft04BWmHoUUc1yBqd2gTpCs8+Eyn?=
 =?us-ascii?Q?DLvoYvUSmxaaw/pXcdEQ2k0trHinXz7lkKGhDLTdvLYDK+ZkWtw+yLNJitSz?=
 =?us-ascii?Q?eeBr1Ii/N66vqIXd1vMK5+0BGsd41Pj4PLp7wG2GL+o/zmYzhuTJOHeOr7uk?=
 =?us-ascii?Q?HQf8q5mqAoMJ1CdhwmULHlqYBIVflM+oDMqfef4wq+5xuFJ5Z++6J1zr1AIh?=
 =?us-ascii?Q?V1yCorZZDnB5+TJ+E+feNAAF/9LXwo8wBjBAo8JGaAEEH1HANeA7/77viZ/z?=
 =?us-ascii?Q?NXxP1n97YxcVn3o0YEfbIttDpgGS0vuVZsbcKEG0ETBAkDiwCAEWdtVF6hga?=
 =?us-ascii?Q?vhg+wqFkG3HTD0hviUCyoy02m1xqf5Hl5gW2YDv/OI+ksXOyWEusGG6DEQjn?=
 =?us-ascii?Q?1MdknQ0cV2Epr2558YWyk5wxPNJGfxKdU9KDFwWRv6AY3jO+n0X+3OBZFB3x?=
 =?us-ascii?Q?sVgUy4/lO0Sp1b0DMF3Foltt+0/wDWwq5kcXMGpS+XZ3wUvqCxpg5x7fjFbK?=
 =?us-ascii?Q?+z3gscaLp9dAMTWiByxLzr6PdBtAnOUEgRytXNx581+3lZHGHglPd5hHQXhJ?=
 =?us-ascii?Q?O2cPKF/l4DIkwU9PqbMfqXDkpAp4AWn3dIMfGXJVCbuLyJe71MsOfwVci8wj?=
 =?us-ascii?Q?AMWnw/IWNvkA4iKulji/azYiGb1zr83DBkbl5+42Qj+0nwyZ5qiaabVcbmpK?=
 =?us-ascii?Q?mBF1VwY5bzlrB0XA1uTWrVWp+j/UtkzJIQtLPmrwIQ5B9EYCwXIIP+unBf6X?=
 =?us-ascii?Q?5ybgbksSZtMVFNQFSPw+1KNToW/rO50jYN/xCZvzCwthINwkg3nBSPJLxABK?=
 =?us-ascii?Q?MGXDvM11afzSjMXi3rXLdBGpEcMHLD3EqS9VW5+heMneF29G2VLfwp72P7fq?=
 =?us-ascii?Q?E2k1o+eRf5fRgOM7/SHOZK1ffOaklomDS8lQKEZadqmvoEhPfz0E1kpcqAj9?=
 =?us-ascii?Q?J8Wwe/Ril+W2ezjucERYY4Gp9wfLYWE9E+hp37EWTBClAz8YR5AoyloyZB2Q?=
 =?us-ascii?Q?DhJsCrrc0xBm5hl9Vqg4BxfvfbIoza50K52XHjUanJSqG1L22NfxQnfG5uPH?=
 =?us-ascii?Q?FsxKDpRqYBitiEX4zYXWIp4PAGSGm5UzF4G7ryeG9EyiC6/UjnXIRNHRp8Eb?=
 =?us-ascii?Q?VDWzvH/S1jo3mK2QL0VON+sfvMWUUHSLcHjNdUwCR+wnS93T0zvTzpqI0tAp?=
 =?us-ascii?Q?zTB3maIz8956RgounFjy5S3EOygNT6o63wTg9gCx+65ZZtgo7nrF1JWkrYV8?=
 =?us-ascii?Q?FhaQ+zFvBc2xeUMW76Fjb+SqBu4ZkspLJX0hWxOlV+/deuksT5jtWh1/INx/?=
 =?us-ascii?Q?o5piuxldOLsm3lzQd3uc+k/dHCV4By3pN7rrzYz1MjbAqZkykf2V/flEOBke?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XB8sw5iaXxVJYN+BYDjtbnkB/2R3glMGTNSUnWjjGT+lnyqYD6B0p8O2Yc/b2xGyEz1iwTn7eg46yUPelOpCHveHaf4OsQpZYOQpJJhcYyTC947v0lxCUWhcaVZXGlyE2J2CHChzCf5hhTAZUprQ5xFQ7UP1iGw7UOYsyZAx136+vYDBShDW+e6vJyk0kxGn6VtC9P8dMO3NVby/xP2bKceTlYA5cp8ngoBNNqro09ytY0lZjQH5vESjBB5INVskA7b+/3QSa48gwSc3llglLS483yMJdItKiFkAjEYo70utVmRzXu+ZhwEjVaHp4UVboa7ze5tTpVguJz/dyyYf1rtU09R2ZqRdRx8PKkEdbvCmUjs6yks1A4Yib91BWwsLPXdMM+fpLCGzzEobyQZfxU6CxbM2NK1yg7rHg3YMG6qQ1YTz0pkJOLUkeXNKWew0yVP68sNMR18xBkulLc9A2ZD9SKtmEo4D6dw/tymXxJ39IPuVdm2aQmcpGNkLgaxRFJA4kcVu6BI/YYmelSYlTQUPDzsM+CpSxPX/A7TMpr3ZlxSUMLDtAALGsMzyvh19H1Hd16X5IGdi4mh0A7LgGMVur3fapZ1PI3hQzv6/9WY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04abdfc7-1f37-400b-3b5a-08ddbd5c5750
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:44:05.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5aCG0vQ/H8+amvuc4SnnVPqGD32piP5ednMklXsJyryAvLM5YEKMffrMpP677A+koI1WG8yA3lG6x/F8fcOYc+Z4esxb03hJM9IjDktub8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MCBTYWx0ZWRfX1PsRqdqVBXs3 bIrCoJpSHkjCHMbVWb8YOgDKm3GvOWOSbDwP2zaKVTZYlcmCe9HXQqnQf6kGCwt7mZ6M2NghBWw URtkSDbetIbccemL4a5+x7gyQDYiZU4RPEaRzMq5KXXOhsi242NlcEo/8TChQjCy0AvPjyri1ok
 TwOWX5bMgGReWWocV4zsTDM5qUnpNd/IMg2mu1u79ZCeyzxjO2TSMu2jFoJ889gqboLyeXMckxT 4oaqDulatVWds1RxH7GkUF1GrBRR16tHHJfef2eWtg5DWy/kMxs13iQhdy/TGpADSkn9i/ybACH S8qymjr1GAHnuiinUFTv7HdsnPpRIl3ZA4QwyVSjGe2WbMlutLp+nQLFcQIyiu0vQXEUyvVAtKU
 fKuCHSgiHhTpA1zoSXYQ9eQzfhi1AaTuZ1qssncapnP451blvpsUbPlthtlmCV/UmXokehdL
X-Proofpoint-GUID: zJyfLQLDWGaSGAb8rGxqxtcXLgvnmFbm
X-Proofpoint-ORIG-GUID: zJyfLQLDWGaSGAb8rGxqxtcXLgvnmFbm
X-Authority-Analysis: v=2.4 cv=caXSrmDM c=1 sm=1 tr=0 ts=686bcf2c b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=GFCt93a2AAAA:8 a=2wLkd4g-V296xocmsVMA:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22
 a=0UNspqPZPZo5crgNHNjb:22 cc=ntf awl=host:12057

+cc hch given his response

On Mon, Jul 07, 2025 at 02:47:38PM +0200, Konstantin Komarov wrote:
> This reverts commit 69505fe98f198ee813898cbcaf6770949636430b.
>
> Make lock acquiring conditional to avoid the deadlock.
>
> Fixes: 69505fe98f19 ("fs/ntfs3: Replace inode_trylock with inode_lock")
> Reported-by: syzbot+a5d1c9dfa91705cd2f6d@syzkaller.appspotmail.com
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

OK you made me have to go searching to figure out where I suggested this :) it
was in:

https://lore.kernel.org/all/2076fb41-4017-4ae4-99df-acfb6148a408@lucifer.local/

Which is in fact syzbot+a91fcdbd2698f99db8f4@syzkaller.appspotmail.com ...

I'm guessing the reported-by you've mentioned here is the same thing but would
have been helpful to link the original report.

Anyway I'm with Christoph here - your commit message is really not great,
esp. since you don't link the report where I provided you with an analysis.

So I suggest you:

- Summarise what I said there in commit message

- Provide a Reported-by tag for the syzkaller report I gave, since it's more
  useful than the other one (which is presumably a dupe anyway)

- Provide a Closes tag linking that report so it's easy for people to see.

Thanks!

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 65fb27d1e17c..2e321b84a1ed 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -322,7 +322,10 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		}
>
>  		if (ni->i_valid < to) {
> -			inode_lock(inode);
> +			if (!inode_trylock(inode)) {
> +				err = -EAGAIN;
> +				goto out;
> +			}
>  			err = ntfs_extend_initialized_size(file, ni,
>  							   ni->i_valid, to);
>  			inode_unlock(inode);
> --
> 2.43.0
>

