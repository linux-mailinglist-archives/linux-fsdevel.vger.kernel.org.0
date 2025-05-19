Return-Path: <linux-fsdevel+bounces-49450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1439ABC78C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F64A2F62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939720CCE4;
	Mon, 19 May 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bcLoL4Os";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YdZvPx9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85861E531;
	Mon, 19 May 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681380; cv=fail; b=l26shHEYycVWKTG8CKN3W4yNEB3wHYPS5ya1j8w0/nVo4+yRhAZ6borHdF46GdgmtUrj+zrlCHrMb6wXZlQrIOJte5OSph/VzS0HS2xgF7kxcX2XOwrC4GjNjTzc9rUoXYyRUvSowDL49vO80yA0EMMmWcc9JA4mdsfrAF90hys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681380; c=relaxed/simple;
	bh=PYYcg9J1xD6g/IfZfBEHEVvk66+OQ70OgHRcmX8vJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huoWuMav3CA1bczg0Cn7Lvo+9lOhVqucEQG5mS+uYpOT5+erZ2FiP6bA+Xmzw10hJMEtmRWYLLW4o3QppXKf3rwnBqFeMpHKu82duGVGs4rgcXo47m2F4HtXNY4YJyXfaswYNW6NX+zg4D8vDwF8Kz50yrTklGwI5W5mKhxxgLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bcLoL4Os; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YdZvPx9o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMoPY026232;
	Mon, 19 May 2025 19:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PYYcg9J1xD6g/IfZfB
	EHEVvk66+OQ70OgHRcmX8vJ9A=; b=bcLoL4Oss7tqE7SL60O5W2OR62SRVPw57o
	GoE6sodIzfmNJjT8VLkMLr11QgBWRjNprX/87vE5AFFe4f+jPleElCxB1fscm0k+
	vC2sUVI+0nv7mdrsPhfGD9k7JD4ay/voQ7D4p8M9EhRLPpQMtGZFFfzkVPAMb2Ls
	4BXMjyg+zXy1pDdqyca8Xn28FE2mSrYHcIvFK/Q/Wr4xvEAOuZbPBN4jpc4sotnB
	dPlITOSQYqEtespois2uFItQTMWpp5BymKt2ywuRRiT09kW+nF6CrDiy2vJD/X2V
	TjTqA5fO4gs4uStxBVLt2aAZJjn7xN/L+XtbIUmz1WYljpcKbmzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84ks9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:02:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIidZU017402;
	Mon, 19 May 2025 19:02:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7au6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 19:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3POYnY/fgtPmMKbog6Rvl7rOEo7EKwsHNdaPyveE0zhyrpqwK8jEAEn7wn2UPOAuhbhlBWjjlOxG8D4WJ6ztKwgwjHH9CQ/aLcPwbfQJEkDYRUb/UvOEwp6a29p5nq/cg4BK6V/BWe4Gaw5wbFAYhNosGYPAv9GpesCZEPQrHeImIWXFgHVamyslaKZi4XhZy1wfeQ4P+HQvpp8g9t7wTZ+m1upf0Ey595SfUsmjjcHQk1X4aQKPOAZt/cFX6hCzDWMwoMQu0/3L+syStGsnXchdY0imWFOQMylAUNVkOjIZBvusaXKk72Ouy7RRAX0mGFdJXm4zDGAqnpHiMycrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYYcg9J1xD6g/IfZfBEHEVvk66+OQ70OgHRcmX8vJ9A=;
 b=PG69KtfiwgcajSEYoQeRZqNI2rN434fWZe8vuT+KZ0KYdd00k2E4IKlXBh9mIgVEbILK2AlL/x+F8668yr/XrpwOomy2LFo2EqsFCvtnT7azvcasFuiQfq78JeEJdJBK9LXCO2HRMlJG+QwBQGOoDVJZJM2jF8bj+kwmjePxCFhpy5qDel9c5fiTgnSOi7lVoZS2jdYRu9/JLJGUKuihnCRvrjhWablB9T3nLZZ9dPSe55kn0AyG/hYXWbcx5bp0EiMd42HTX/PfAGgm2FNsnYL4h8jTTNPRfPamLYgQKbavE1oYqum2Hz4O+qIegUmGUkiK6crckDo5GO4M9yawFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYYcg9J1xD6g/IfZfBEHEVvk66+OQ70OgHRcmX8vJ9A=;
 b=YdZvPx9ot4+ll1hX3etyP95pm8kB1naZiU6oK2fyMLcJf71Jb1127xMfJzYYY276bthPX8Unob8Hh7JIiw0mFCs+TyAQ/11YT/dBujzDVwE/aIDbef3utv0wotTGh/yqszZaYM8fKuP/QMK3qDgFbkyJcn4ITTOsObJdW6HEdDQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 19 May
 2025 19:02:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 19:02:39 +0000
Date: Mon, 19 May 2025 20:02:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <d8e20b76-1eed-459f-8860-a902d46bc444@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <3e2d3bbb-8610-41d3-9aee-5a7bba3f2ce8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2d3bbb-8610-41d3-9aee-5a7bba3f2ce8@redhat.com>
X-ClientProxiedBy: LO4P123CA0254.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7056b1-b46a-4541-7ccf-08dd9707b9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52ePOjAc/K2cDHsWygV7pOD4+fl33rUMyesefk2mTpyjVPmd2RGSyfnIYUY2?=
 =?us-ascii?Q?8JVqsnJdiA4HvLHR19PEifZHezGNyhovblkxLqzk+036OviquS5D5QRTyRp1?=
 =?us-ascii?Q?dk/UHWRYZxFmMZGyOFm9sbh64ztSXtEzNwljFPyYH5AqDvetgi3puVoVhXuX?=
 =?us-ascii?Q?qLRneT+z8qk4dCxFkeIeG3FnbC0vLToxPBUVTQWvcCImM3n1ugHw3CgBc6pG?=
 =?us-ascii?Q?N8IhLOAB1cW0UfVcNXHC9cg8MzuRVOBmF5TiEIEj0KEcNmf2CGETp1rrS13E?=
 =?us-ascii?Q?JZ+nAi5XOeOOrSdiWkwxuCCjJ5fz69jXLj+JpL4ShPoKaRm60+GCVQB2MX7G?=
 =?us-ascii?Q?4MRUVbTzPIb8llcaus2ISP0D6lPTYcnZ3s2sBvzgbw4K0gDvQDSvulwImozN?=
 =?us-ascii?Q?orxA3PMG9cSOh6Cs1DFsHDN7sc8Z/nRlXemulpKyN8jnuRwWGfMZ+40t/2/P?=
 =?us-ascii?Q?/smIVsIRSRNiX7smmt7Y6+kwoiBfUFXoeKO7HHGwrWyYfDpZs+PljNvm3kHh?=
 =?us-ascii?Q?NbR1hwWsCcjOXG/LAfSW0+HhTZE8jqEfspg/b0+RCAx4xkdtyjCgebvQDWxc?=
 =?us-ascii?Q?xV/WZ5TgnxpP1HOOJx01rpbSxKCUm6PVQVupBCemowSpyJhU2Nm2bvp4Yp8Q?=
 =?us-ascii?Q?93bZJbJvxsWoWfRrSBzAgud1IZWfIJ719X+w/Cgmztg3yrYZCPUwdUANX1d6?=
 =?us-ascii?Q?BXcVEyi/70b4ZpP+bgjIxSvNQmGRSyUnfRaDP+m8xeg/mPL7Q5KR4UytxAPq?=
 =?us-ascii?Q?XJ2ZaqF+FwBXRgrXoEC6At3sz0sIbiOyFoVBc7IrIrj7jxItrMELNRlFLHN/?=
 =?us-ascii?Q?HLd5LKT8IHhrX+P6xqQJqGSTWsVPJFKnZucwlaTgs+eNF3VtehvreirG/9p/?=
 =?us-ascii?Q?bDXYrl0852sQ0O2SRI+cJ+r3LRRhdfmT3NeYLohqzU13QO4AMMek6Jqldg7T?=
 =?us-ascii?Q?buGmYSluS2bCpJhXTeFJPsscATL+TocMA9KPruOv+tvw5pED+4TmNxe5xjVf?=
 =?us-ascii?Q?tmoTSUGnvTIcfEbpqKT/hGuXDLrfaZLRD6EW7tLSbJ1I0D+JeAe20xDoLxsY?=
 =?us-ascii?Q?ypBCL7HQ9R+AuZ532YqqS4gWn78k0Gi/rBxsgrghf7WTFk/bOGja+AFn44mk?=
 =?us-ascii?Q?pxa1TeRrMsN/PZ0z4jc0J93nRPMf+0qKjA3rB5vUYn0lB4MLCX2mHSkruvjE?=
 =?us-ascii?Q?m6jGsb0VETZ9/xFtgXpJt7n44y+zIvu89O3Gu3374oYrZne9FAxBb4GXAl6s?=
 =?us-ascii?Q?9grkiaImiIy0Cvf56xAeDCfRaGBsdl1d0/VH9Vw0tFFCI1M9MZ5TrFqV1CHJ?=
 =?us-ascii?Q?OcgA4FtwEZBj0hwEx0J4tjjD6b3nKRABM6HYjcOHCJxztmGw9xQY1paEj5z6?=
 =?us-ascii?Q?vE7KrVO0npRsDeyJSFVebSt0H/h+T1Amzn498LDd3JBXmyXLfJntiBnnQfI7?=
 =?us-ascii?Q?aTkMyhGgCdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKEPSL4yRP0Ci59VqhnlFgNZ2AoVlzW3A+kUbsJs8AanyhzvRpffV2ibRdUU?=
 =?us-ascii?Q?U2c8SI3pFxFo+YiP2qlkjZpv2I+n78plF4/5LxTw+GM7DLWFCy1rfjRn3cW9?=
 =?us-ascii?Q?31U6Oxz6QrG+0l6Ch7zP2GYcnrpO25tp02cMR8kG+ox+IL2V0h6Q2+0iQ8Et?=
 =?us-ascii?Q?qWhmSQ8PZIgiNSDNwgm5kxudDPeA4fwNYXu148rO643nw9DZBboVSbyeCy8Y?=
 =?us-ascii?Q?J1I8AB7r5bvIpGMEN4JJVNRkUgJi/+Zo2tJmIZXraGBxojDyn2UQFofi3+jm?=
 =?us-ascii?Q?3I9eT3ry6+rqH8lzP5rfzhABajJXwLhY/ZvtdFPS8MZ4r+TTdMqTP1x5aaZt?=
 =?us-ascii?Q?IZbgVAwbpWu0LtSNMPc15id/PYZDlJdZFNyNRsYdyscdQNIRDUoNWYXQKHW+?=
 =?us-ascii?Q?vgnO7CaFmGE76jVW6C8bemLNnQf6aehsHJLbLHlA2BVveB0FMM1T6+Z6O1Lh?=
 =?us-ascii?Q?fhTzbFsEYmIW6PwsqYfsAAJ9PU0lg2/GBQCvOT8HA28h4JE17yV6RvPthZaq?=
 =?us-ascii?Q?5NvZ3eTNlslkyWiuaD4RRbaxFZFn7d46GAhJyDn5ikJ0mdG5D1SmgKhyHlII?=
 =?us-ascii?Q?FXplKhD8yzFk3rvrgV2+DcfK9pPUTS0GiFvcDNtxZitapb1lTNhYEQObLX5X?=
 =?us-ascii?Q?ur0tzo51SHGbbejwjkHt5t5DEKZ6jfgpP7alhsnf5f0upjohi4VerXHs9XH6?=
 =?us-ascii?Q?vyAdDsVEbNvflsrp8Pn4pZOfNIRCXczD5Wtx0kRKXmu62c9eySP4+urhncYk?=
 =?us-ascii?Q?uEHaHHiwknfHPVadVFoxGVs68TVEwQ8IWiVz5NlWe1x2fQsznM/DtmxQ2AeZ?=
 =?us-ascii?Q?7r7/LMDISkLb1L7EjdUbIcrZY8J37pGz6ZqB2R4A6wHwyhU65CnXsIe6PsxJ?=
 =?us-ascii?Q?9W8Jejs0r4TJKq31yjBVH6s5S79AGxsHZMfHu8fBJDdxyNrE3nKIcrvLnr/K?=
 =?us-ascii?Q?kfXBuvx2mrjzSqLi2/e2u0hDzloTzJCe+uiFRk6ANOSKbHhLLYj8xytSHzmh?=
 =?us-ascii?Q?UM9JMXfTs0gROrEfOp9vawyolcM20LYHzhO/PD3N2xerWtGU4UhSvMhHds25?=
 =?us-ascii?Q?yk6qL7vSl/zOtFGtGeXJImdKizpW8t+0guyXG/kvObMts2PeLtP+Y/APAE4S?=
 =?us-ascii?Q?DzfigU+IQ0OqS9+uHfTs54tXVSowgaNreJ3jp6Bm96IZpybqlZ8WAUde6uO+?=
 =?us-ascii?Q?72saTDKCZBlReKT8k/v2K35YcnSyM0hkz+3wdgO/JgBKJv2OSjW205mXNKC1?=
 =?us-ascii?Q?wKhZkc7cds23Coz8KMF1dog0EYRdhlpBlJThf9WO4uCTNIKRx9gzSZOS1311?=
 =?us-ascii?Q?Edsyc4dLoTowpqG+smpKW/Obx4duHozkMstggssuD2SKHPM01J5WOH9sT4b6?=
 =?us-ascii?Q?z7UK8Z86blyvK2EIWScltHimkN52v+8JOApV+aRNPND/veQss8t8aAKks/bB?=
 =?us-ascii?Q?P92UhNe8SMSqLU6iTb/THz4y31UEKZpJCLuAWJCl7H4CdRcQsH50YP4mQPAK?=
 =?us-ascii?Q?OeUasbNm0l755sfzuxXNjvwxHC+WE1s5l+oNcgp2i+xsqQKK9HkzZDtl9C+K?=
 =?us-ascii?Q?vUCtReLwXhhmM+XdrlhnEcq3oWb8MD/SFMlCnXsU8pYZDfP0LxhUKu8Axa+S?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SZsxWpDHpok3OdmFPJssaSo/AErcCZhcCuWZQEfxM70B9xTBQcccI1PU3kj8FxFarmCPYMJ0+aw1ilw58FHC2hVQMdpo1tGdWhX9Od8oiL2LFbeTog6LUz0iv+OQNVRsWUyVo7Yd+4j/0ndXznPlrW4lvMB6+z/z/PNdZJElbaGRpVNdwGAybHj6LbbulK4DflyRaYHvtMI308IP3HAmaCZ5HN0WS+pd/PQl9Tsf2GYhfQN5B1p/814Bso0acLqKtjOl/8aMDPzXdEmFD6/9dP2pLZ5uU6/DEJ+VNiLQ3wUCbWxxHWR8QkihddjtlT/pn97Fo+l2KG+XA2IzCB0f7d1K0lsCWoG7BCyQ3t4csH/YiPhFWZrvhnp+/MIKQfMUMhTTwuErdN+ngVK1yRgDTwDU9Yiv9uw6F1e2+bypzxFcEROG4x+psHgIoFmlRojTXQuPng4cFjNqJ07eekA5/tB7ZEZfJBrkflK//KCUjIPxVMrnA7oOG/X0OwjbbfmqOFWbsAIDkoHF10GvWeviLOtibf4UITDkrQLLs56Hqi2FUfX3PYxXFaSx8S2CRvCGTNbJtoxCaWGuNLZIoVW8JvvY5UrylC9Hh4MYu5/Ep4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7056b1-b46a-4541-7ccf-08dd9707b9dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:02:39.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HDA27Fml0EFPdKlRQ01PCg6cgMXrlyb3a0NtkBV6qyrhk1FsiyWZvA7VldPFhnYyS2W1bVKaVpKdS3DTK0njokd8tOvpVhS37rPDJAwxzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=806
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190177
X-Proofpoint-GUID: zxMZtpxiGMLB8iGhnPI3aMNUHh91uG-r
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b8052 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=7LK4IZ4H1aP7fGsMG8AA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: zxMZtpxiGMLB8iGhnPI3aMNUHh91uG-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3OCBTYWx0ZWRfX0Ju6gEQz7h9f sKC037fuhFXxkoMoODfgfLSQ4Kb1jCmvt4iCZIabkrQMSs50qmIezZnxY0BYDfGGVKojLnCTOIe tYnotGCPlvHJqPTcDPgzjZqVQzlXzdsjSyKEPaekymFLR7N9oH/JJGtPuFhoWOh7GlCpA3ZUSgS
 ReBomk5wNb3PfGRXphTkyDb0R9GwNkzf0yU3ejTtbcY3BnAzsTMSGIknp9Uz/5UGY4A/kx/nAA+ VCJd4fhT12Bi9TMC0zJA21WDc15AHv7Td1FulNVZuddncspbt0/nB6YTyErtP1MKiCJqEKZ9eqw uqPuZu3dDTz/e2h/TIQ3h0VIB+dfDcmaD3+JATLNaCHBm+x37zHXcO8AOLdENxrAWWc6nHhmiNp
 MpXYUc+0hR4lRKCXjz2o9539UX4CDv+Ya4rHYf4Jy8cxRXYkLbqrEiMruKnavgMz9SylmCzp

On Mon, May 19, 2025 at 08:04:22PM +0200, David Hildenbrand wrote:
>
> > > +/*
> > > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > > + *
> > > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > > + *
> > > + * If this is not the case, then we set the flag after considering mergeability,
> > > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > > + * preventing any merge.
> >
> > Hmmm, so an ordinary MAP_PRIVATE of any file (executable etc.) will get
> > VM_MERGEABLE set but not be able to merge?
> >
> > Probably these are not often expected to be merged ...
> >
> > Preventing merging should really only happen because of VMA flags that
> > are getting set: VM_PFNMAP, VM_MIXEDMAP, VM_DONTEXPAND, VM_IO.
> >
> >
> > I am not 100% sure why we bail out on special mappings: all we have to
> > do is reliably identify anon pages, and we should be able to do that.
> >
> > GUP does currently refuses any VM_PFNMAP | VM_IO, and KSM uses GUP,
> > which might need a tweak then (maybe the solution could be to ... not
> > use GUP but a folio_walk).
>
> Oh, someone called "David" already did that. Nice :)
>
> So we *should* be able to drop
>
> * VM_PFNMAP: we correctly identify CoWed pages
> * VM_MIXEDMAP: we correctly identify CoWed pages
> * VM_IO: should not affect CoWed pages
> * VM_DONTEXPAND: no idea why that should even matter here

I objected in the other thread but now realise I forgot we're talking about
MAP_PRIVATE... So we can do the CoW etc. Right.

Then we just need to be able to copy the thing on CoW... but what about
write-through etc. cache settings? I suppose we don't care once CoW'd...

But is this common enough of a use case to be worth the hassle of checking this
is all ok?

I don't know KSM well enough to comment on VM_DONTEXPAND but obviously
meaningful for purposes of _VMA merging_. We refuse to merge all of these.

Anyway this all feels like something for the future :)

It'd make life easier here yes, but we'd have to be _really sure_ there isn't
_some .mmap() hook somewhere_ that's doing something crazy.

Which is another reason why I really really hate .mmap() as-is and why I'm
changing it.

So it may still be more conservative to leave things as they are even if this
change was made... Guess it depends how much we care about 'crazy' drivers.

>
> --
> Cheers,
>
> David / dhildenb
>

