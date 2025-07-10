Return-Path: <linux-fsdevel+bounces-54527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85878B007D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696E7189FC5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295427FB03;
	Thu, 10 Jul 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8C4+Z6p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GpMBSzPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50B27E7DD;
	Thu, 10 Jul 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162724; cv=fail; b=cNsAEQLEiq72JD2IDzgz/dnx6+k3rFCURqlzPqZTyuBgsN2qexVeMneyxmYF5ClIKudYDoZ40sMosA7NDjLM9IypNJkyzcLJFbZzxeQ7iJ3qv/3e9mO40ug6zPLp8pHQv74/3y3PIhFfT8oIye9O203rl8DvsDCjLlj2lBfaf9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162724; c=relaxed/simple;
	bh=WwlZ5rCPvFaMfkS6flik7WqVgUEuUvf6OXDktBBPSjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gV9VIsHTyR8lt1BOdFl1+Aqob3eTpHcV1qkrZWuhTh4fR87ToQpezADuK408iIjTt8XqDTd2psmFOOfVzIanaq3+t7jeUe0Ij3fZCVRqXnvtZl49NR5IOu2F0J6OkF1xwLgA2b1MN+mIKU3bX54qSuPM1WK/4+6i31KjBt1JD90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H8C4+Z6p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GpMBSzPM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADHPM4020307;
	Thu, 10 Jul 2025 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0E/sMzb/aj9NW0QnRwBkCJjrM0+EqK22NFvcWeKYd0E=; b=
	H8C4+Z6pCRHfsg9WjliPiAfzJufBK6n/0+DrFd09TEU1OmOaUxpKl9DPVEq+nVOz
	vob+Mcuspg4OXJDRU18fEBXMP/fMwp4lRGFxpAUlZERtncZB3FHdrvB1lnTNiYJV
	KJhp5opHwv/bZdHTqVmHVIapRGKyyAj+8rArcsr/kRRrmcN9/jxzpbkkXyndtAvW
	7IFQOS5HJrjenwIJ96BOZyQ0xdNYOniwoHZniWrK68ndUeJTG6jHOp4sMqONjg1+
	oZsF1rKg35D26zhyQKvS6N8SM7jtQDVLkEuHec2iOkqPGIVFFiWYitEYA0P6dZkA
	SLmTnsBjXOXAw4+wfzvKWg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47te8w0dr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEQWfV027344;
	Thu, 10 Jul 2025 15:50:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgceyws-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD9eOSdzAo+uh12NodKDIhhDfEkB3m9mI1xoBCaqB2QTpqrTNYXiY6DOdckOpG6UKCxEh6akISa8nNIzGTGHFr4G8N34ynLUkdXDEHI0TzgFImemf7Ya93F+44+rMcC+AujISUgXe02lscm90P+ymSfN2Obi5i146hikSveS+NZGK7jqTegC0tqEBai7cB8b37h8DRID7qojBYagBO+uXm4v+9mcglHeZSZX034DLlTNOp0HiV+q/1pP4tWZsvjy8z641LrCGNzhacaQRkx1NmnB06rrVhINCap1rAtbK6zilS8j0f8g3VF4auu1H964YiqKlmo/XZG4BgVXZAQSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/sMzb/aj9NW0QnRwBkCJjrM0+EqK22NFvcWeKYd0E=;
 b=qhVwgrtpm6To0HMxScMQqhDBpoMdr1WYmCVJsvSP1AJG0AQ5Q7ZApahqqLRt7Ze2ZdLW3a0q3397hcH6MBha2k+KQi15SRVb+wutkTRzR8bM8RcoKgtRwqsJyvYoyvuvl7h3gmSkV6sB+9nbcEp7jX+OGDvKeJcVZGB0Z0jBbGk2WiOsD10c9EC1Feeb7wAIrS9S1V4i4N7UZdCFDN1u5NxhUOdq0nk97ce3KCT21G9cGoPCi2Xby1wLGNP1x9ezrYpf/NwY9IhC1vGWudkAE/3FkQslb/xMYqrIVewhIZKrYxgg36FWlIRo+CcZFFWxC38Wp42ooGWpWkMubuzuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/sMzb/aj9NW0QnRwBkCJjrM0+EqK22NFvcWeKYd0E=;
 b=GpMBSzPMADtqLxzKpWyp2TDlqCkcKd2k7uJ4wEW1UHZF9RDRDwBa3tRc5PnfQkGxPQVCwGJfzUH7+4xMkuy5m+b+wSOaaYHQo+JFI4QPiuDPOIKyQzNRNdpgLL7W9iy1MYSwUU3Imq7rB1cbn/pVu3j+JZzfSHmxp+/yqdvX4+c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:50:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 01/10] mm/mremap: perform some simple cleanups
Date: Thu, 10 Jul 2025 16:50:25 +0100
Message-ID: <300ecbf0827e4a2207855358810b4cbc5d7d54be.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: f845017a-101b-4c1f-2165-08ddbfc9877f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERuBe43+n/o9rgbpPfjM/XoAMqjZJeGh1+YGtLY8Inxthq+qeAqlzKq5ladj?=
 =?us-ascii?Q?h9+4BI4lTUnmC84J9o3wlWDxPhfd5b9aOTQ/YJHyOqEBpjA9x/XQ0zwfB8Bm?=
 =?us-ascii?Q?8QP0nbnjtPiu2GwcUyZfP+z/Jbh1MKbgzmI4z1uWe7INBhYDwa++kW1+SiUZ?=
 =?us-ascii?Q?jqMuHD/go63GeYr3mpgSp/T5XwVzzE/UN2FP/6/g8uyoG5py6cG1958LjIWT?=
 =?us-ascii?Q?NSvi+wacNB1ucp5QVfxTXj6WPY2tKQJsk+tmXpk4FxQnFcUCiwUjhZeyiUrV?=
 =?us-ascii?Q?LNJ5uILDT3jh/q6RqHyFIfi/hhFhxF/2faiZC1vvjHH6s9V+8iO7ah0RhDt/?=
 =?us-ascii?Q?r7a09STUmjb+tg7pOVbNtQblHJMWd+YQvg6HNXjU8DSln3R0SxtjymNl/hhy?=
 =?us-ascii?Q?RPUTof0b4rYKoWQd8ryCfF42aorvULs/UqLGMPlB587XkRs9iOAGJXJ9vGWW?=
 =?us-ascii?Q?kOo+bw9UA4wuGxjG2POt3lLzMyorkjahe+hEkJ9w4aqELmxVTbZmBr2wx0o0?=
 =?us-ascii?Q?GTcCXvMuM/Kob15DRC2AbDa9kZ1KVUhYtfg102OkadxTJIKV207v927di4QZ?=
 =?us-ascii?Q?GDZV0X7/t77dMKmZvfSHpHvHNj5nhVcfFhhqmZ2EM7aLKQCr8GohtLOnVHzX?=
 =?us-ascii?Q?2fYZwmwWcbVuyKAT54eIfqBdg2LooY+KJs6MzxEsaPJI4ZwR7KrCzhWqkoUE?=
 =?us-ascii?Q?68D+2hy7qsq8ysTOnsKRIR/D8H2FWcy5rxn87qfXcpIuEvPX742+rxM8NECM?=
 =?us-ascii?Q?pZcWo2R06/AdEjVzkjYtibEIKEYx/9B4rBdk+9Qh2vLxeEbCiAcHP/0d1mjd?=
 =?us-ascii?Q?3jlEnCGyGTrT4+rWlARUExztD+dsTfQEAPok1BcnP++vc/OlHGMej8htGjB9?=
 =?us-ascii?Q?6nQJW+3Z5R6DvLV4eXhMpnegNxhT/lwamA+q77/hnwCd5phF4z4VL2K3NDma?=
 =?us-ascii?Q?oU4WRJ8EFG3sRSFov7bWRqO7xnDHWy1SDyeLLuZIZk0AzUpB36AU90kmUQAc?=
 =?us-ascii?Q?u6gb/iYqYn09Peyqq6wWJDyLm5WNAcpgojCk/oWpfdJUzNU5IkLek+A/2/jA?=
 =?us-ascii?Q?TcbBZwlzGkjjs5QIE//4+dkc2VOAHBIhJb/PL1biO/eyolc1xwbt1M/jIH6r?=
 =?us-ascii?Q?dTgaO8JZG6a9zD0LQZQqZq9Pc0M+byDwhMZsp2eHKLLKynf2fVgEqUTQ36Cu?=
 =?us-ascii?Q?etNk72bydomBvzR2y6xDX96EcBM1GmWiB375muwsLxkn11Q8eaHnQ9LYN3cW?=
 =?us-ascii?Q?LGyEp+qUqAhfBCgDiJz0vu/IHvX9Od3A9kVL43MG65x2rkNXtJgVjp/kFrB/?=
 =?us-ascii?Q?zR8q6HUN46pfQjNLZ447sz8CnxxhRsTSZinbxn/N57GEZSIQMHQHticczrKy?=
 =?us-ascii?Q?zcNfeHgdFhXu6npY3f5HkXWO71W1LiZWlwC9uhk5i23Zb1+MXbD7iZAdP2a6?=
 =?us-ascii?Q?mZzVN8ElPdM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3IqnJSbjUUCwA5Yo/GJLrIgnqLPviRqHHnyE4shEgGImtFqmzp2JS/AVrBY?=
 =?us-ascii?Q?2baRzGdKsJUL+QBZY11OU1Q9NzVGao+Z+GFkHbpKwdBUDw/+Q+LTIRYL5u27?=
 =?us-ascii?Q?1zM0pm2KG6vaDvKkeddCa00p4f9DxxLAGQMSbGkX1z2XiZpwPyprXizGVxj+?=
 =?us-ascii?Q?HkLJahykr6fjGCr/zwGEYt1aXNXLLG8XeCs2D0ygmbVzkKoDKpjMfUDNwu68?=
 =?us-ascii?Q?FUqWn4pp2ZETXcCUBMYI0uqObEvWL3/ntVDAYP928sLatyt9IXYQtqZVx0a3?=
 =?us-ascii?Q?VXxDGLOgzR7/HEhuCVb1u8BDkSrzUq52hy4004miB+jyOiTT6U35VqsUwB6l?=
 =?us-ascii?Q?RcePXuUK48ORvrpb4aaW0nv8Mmt2fCyEN1zQ1JaCaS8Z0FXVKXUpuxAUlih5?=
 =?us-ascii?Q?TyMk9veIob2Vn4QzXFpJKv9blypnqOu5I3UGLPQP26rXtojdoVyjHpvfnmmv?=
 =?us-ascii?Q?rfy750eD6Iifa3M/ya1Jax48LezDDOSqhyBZP9RXrJVfWz52suzog4BGuXhf?=
 =?us-ascii?Q?EGsg5cRl7nqWOKReRpxMrECvd0YZXUwEyu0FbNyPBgGg1oI8pZf9w/QKOqS6?=
 =?us-ascii?Q?h08hquaI6pN0FMaBmRmW/U18RfMol/5NZyWhLGyKYE1sV/+hwXjqJ2FNR91J?=
 =?us-ascii?Q?8XdwzVZMjsPdFDaK7oW4WCBSaxzFnTpFX0By/viLshbngIGQ3XjPdo3aTLXJ?=
 =?us-ascii?Q?dvqtOS4QMjMnu0u84Ba+c5aIYPkxr6ogEQ4FENlZUaaYxQ9ba9JFaHQTry7c?=
 =?us-ascii?Q?dkfCVsZVRCBEq9QjBNVTTDOLhAaydl93zLl1p/nl1RGchrHaCA/k5CIMyJGj?=
 =?us-ascii?Q?XtlDyPu8F+V4LJsaCmDhgxliMTx5r45o1ZmVtudQGqzwtH3k+cc/g3lkVYxw?=
 =?us-ascii?Q?PaZrGAJ1O0L9NhGS7xxX2BHiraalCFTiLHEXErOJIwYEr3j0C7NaKiCvBBWF?=
 =?us-ascii?Q?YHszSXxBtcuRSXXN6WVJGKl3Hm9zM81hq6aQT7mSCaspUXGGViwHmTcA2JZy?=
 =?us-ascii?Q?o2fwbuUz+foILOTpWkbysfrtdT8gbhxCSHn65KIozGOtiDFR0CO6bwlgyIsO?=
 =?us-ascii?Q?YQYaDCEmXMuCyNOHqt7M5r2sCgnjyi1tQe6Hkj/UCsryHzLVTBizAv0wCS5t?=
 =?us-ascii?Q?qNlQpKVXsThEhaeXJp24kzedHAyJa7sSdM6dPyMLY8ui6GzwOSpTNz+89gNg?=
 =?us-ascii?Q?h62/58YUSSJFKQWPDNxVWEQyNOXh7FgOeXezFwJ79SS7drpamzz9PiqztaGc?=
 =?us-ascii?Q?ByOvCXrsPPMX96O6FrpnkaM5jxTmyAxYE8O09Ol94iEsyULnhFwPjvGc4+Yt?=
 =?us-ascii?Q?WnFBgY73tia2Qv2XANWEXbJaexvVBZXMzzEVd0yox9iUr3u/+w+IPiQZmoD7?=
 =?us-ascii?Q?wlPVbexBBlppPwma9TH/9PQrTsVTM/l6wHZJs6BMsmi8PFMGmDez3oECm4rX?=
 =?us-ascii?Q?eOn7iqksPtMbHbW9Qw+mKFpRVITP8midW6REc4l5WondKDPSa/82CPyvLI8C?=
 =?us-ascii?Q?cN0ruxoXF7aA81/9e+OfDIbzoEIwVSoF/ZfIAFDd2ahWBtfALVixcbDKN8pP?=
 =?us-ascii?Q?X5gIvH702DrQtk+TvCGUz9+1OTgP+lbFSbz+fjf22JRpSGlQruHAIDdUex36?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IOv2MgssH/ubOWTtBaLxkscAi/xd/fPE+EwMmz6AT+nhh/Yocqg/gHdQMPWeaFsaCAYIWygZ29TGJJ/XQc5iCp/OLXCzq+/ru7ohkc/SYrPLgF0EZ4yH8wSOGxVgHsxlLHJ58G07P2Rda97Gvr/N//wAXiLPSKPOKw4TEJI42AWOeA1wqAJ4LEx9UPjWbdNSJ1dE9gYSUcj8klRqtWMoJOm0HQynl2WMCeA43nMFyuc4sMlBKdMRvSUPPPSXi0b2cHebhcL08U/M0C5LCOWzD3ritfO52ijJ1cd93CPP8yZrheDwCZGx7RjPFHxmGZ6IQWs8gstjYz3boqL3n7wizo6ncPbFTndXjLsJ/x8RndvIvMINr7gCEZ8EtwXexA34m8CLfMdpE6/t35ZQXwCu42GdngXtmr5BjbMPraaqRhcg3Wb2qwvLyC4cdWqb4fafD0d4hsU8iS9lGH40pEsG+H3pGf65l6INcajD5COh74j0+Y1XbniLIQ4f8/PCBPfqtQGl9yeU/+wW9xMWcUBerAyNkH3ZIfz6FPYqFa9qjku4MT8Cl7luzb1k2SoOlsKwcONiQ5dH4qr1VhTPRWBE0jCdfk+1MAkue1fB8ePUIc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f845017a-101b-4c1f-2165-08ddbfc9877f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:43.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhIAqpkNfXQazSzJc+NeaMVo+NVW1RdLvn15Deh3WDEITLE3/xdfKqlJfMCF1xVLRTmnMNmlQuRibKcZq2f3qXTPPkGapM223nmV/jB5qqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX1UmOT0mmevqf 5u/Y6QJ02djF34eTzZB71DVEXvwvTyVJLOmHYh6TxafPmDXPc4U9fwVhS/SC04FFGIrxTC8A99x utvZ8aHER978t/tdR9OO6zvwRuVo0YzzYrbqY0mre4vwa1R+NwsSxgxak49dylLavUHRC9HTpeM
 I4utAtQ7WI92T7cvBE2OqJ9zxI/PN3ygU8i1Q+Zcq3T4jxHFEqnl2jwnvwtGrD3nDCtRPQXE0mD OquAK12YQeq+WRU3dO2wHdJ08eXTbV0llCWgwg0OjNfD7+j/O6cJmMoGTqfe54hcchQCC8PxEd8 xkWF9Jt74XYF0jTvMKUgGhbVB3WSyi/SDbCpoplQqfPvKjD9d911bkL4rwPWU8RYVbmOxxPUL/i
 2RZ5pf1st2nOD4aYLY69w4uHvhh/eBroa4IQiqkDm/8n24xe31D3gTUZ38toaFWmxfyqwyOE
X-Proofpoint-ORIG-GUID: D-0-rKEWAJR09ttFzVo92TYa8Z5gUYma
X-Proofpoint-GUID: D-0-rKEWAJR09ttFzVo92TYa8Z5gUYma
X-Authority-Analysis: v=2.4 cv=O5M5vA9W c=1 sm=1 tr=0 ts=686fe157 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YqzgIYf9a6bYxjmC-oUA:9 cc=ntf awl=host:12061

Patch series "mm/mremap: permit mremap() move of multiple VMAs".

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually?  Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is
faulted, then moved back and a user fails to observe a merge from
otherwise compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

In order to do this, this series performs a large amount of refactoring,
most pertinently - grouping sanity checks together, separately those that
check input parameters and those relating to VMAs.

We also simplify the post-mmap lock drop processing for uffd and mlock()'d
VMAs.

With this done, we can then fairly straightforwardly implement this
functionality.

This works exclusively for mremap() invocations which specify
MREMAP_FIXED.  It is not compatible with VMAs which use userfaultfd, as
the notification of the userland fault handler would require us to drop
the mmap lock.

The input and output addresses ranges must not overlap.  We carefully
account for moves which would result in VMA merges or would otherwise
result in VMA iterator invalidation.

This patch (of 10):

We const-ify the vrm flags parameter to indicate this will never change.

We rename resize_is_valid() to remap_is_valid(), as this function does not
only apply to cases where we resize, so it's simply confusing to refer to
that here.

We remove the BUG() from mremap_at(), as we should not BUG() unless we are
certain it'll result in system instability.

We rename vrm_charge() to vrm_calc_charge() to make it clear this simply
calculates the charged number of pages rather than actually adjusting any
state.

We update the comment for vrm_implies_new_addr() to explain that
MREMAP_DONTUNMAP does not require a set address, but will always be moved.

Additionally consistently use 'res' rather than 'ret' for result values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 55 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 36585041c760..1815095c4bca 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -52,7 +52,7 @@ struct vma_remap_struct {
 	unsigned long addr;	/* User-specified address from which we remap. */
 	unsigned long old_len;	/* Length of range being remapped. */
 	unsigned long new_len;	/* Desired new length of mapping. */
-	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	const unsigned long flags; /* user-specified MREMAP_* flags. */
 	unsigned long new_addr;	/* Optionally, desired new address. */
 
 	/* uffd state. */
@@ -911,7 +911,11 @@ static bool vrm_overlaps(struct vma_remap_struct *vrm)
 	return false;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
+/*
+ * Will a new address definitely be assigned? This either if the user specifies
+ * it via MREMAP_FIXED, or if MREMAP_DONTUNMAP is used, indicating we will
+ * always detemrine a target address.
+ */
 static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
 {
 	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
@@ -957,7 +961,7 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
  *
  * Returns true on success, false if insufficient memory to charge.
  */
-static bool vrm_charge(struct vma_remap_struct *vrm)
+static bool vrm_calc_charge(struct vma_remap_struct *vrm)
 {
 	unsigned long charged;
 
@@ -1262,8 +1266,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
+	/*
+	 * If accounted, determine the number of bytes the operation will
+	 * charge.
+	 */
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/* We don't want racing faults. */
@@ -1302,12 +1309,12 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 }
 
 /*
- * resize_is_valid() - Ensure the vma can be resized to the new length at the give
- * address.
+ * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
+ * at the given address.
  *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vma_remap_struct *vrm)
+static int remap_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = vrm->vma;
@@ -1446,7 +1453,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1571,7 +1578,7 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 
-	if (!vrm_charge(vrm))
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/*
@@ -1632,7 +1639,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	unsigned long err;
 	unsigned long addr = vrm->addr;
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1705,18 +1712,20 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 		return expand_vma(vrm);
 	}
 
-	BUG();
+	/* Should not be possible. */
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret;
+	unsigned long res;
 
-	ret = check_mremap_params(vrm);
-	if (ret)
-		return ret;
+	res = check_mremap_params(vrm);
+	if (res)
+		return res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1728,41 +1737,41 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 
 	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
-		ret = -EFAULT;
+		res = -EFAULT;
 		goto out;
 	}
 
 	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
-		ret = -EPERM;
+		res = -EPERM;
 		goto out;
 	}
 
 	/* Align to hugetlb page size, if required. */
 	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		ret = -EINVAL;
+		res = -EINVAL;
 		goto out;
 	}
 
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
 	if (vrm->mmap_locked) {
 		mmap_write_unlock(mm);
 		vrm->mmap_locked = false;
 
-		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
 			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-	return ret;
+	return res;
 }
 
 /*
-- 
2.50.0


