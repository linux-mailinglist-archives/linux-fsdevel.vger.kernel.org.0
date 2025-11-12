Return-Path: <linux-fsdevel+bounces-68075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AAEC53314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88EB567A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9F339B2F;
	Wed, 12 Nov 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gD8FvBxi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w9eLhfwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3162BEC2D;
	Wed, 12 Nov 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961880; cv=fail; b=ZBQo82E2gOISivP8ZpHxEdebIKKRCqfI0GVm2eH06k1bQ0nywths5im/9RHE8Klr6SCsKWu/k7E8atYzGhgBeBpGr+Pasjr9Y3AWQ6dhmN/yLyPOzx58SsGxhqoXqkIg/wWInvPjH19PeD1oCrNJi8Jc9E0Ya8knpW8XQYBNMHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961880; c=relaxed/simple;
	bh=uL9MPJLOI4l4f6owWcfd6CwHmwCLj9aucprbb8h1JIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJHrleB4uMQN/x4CUBmKShGs1YEaxJBCI7ayFahyDD5k1zxeJWDr7HEkLFISEoVirWvWJC2G5YCFkrlv7Fke0C45AlAgamUgzpNNo+ANPekCfG3c5MNiVRIv8osR3LFjR2ptsWvZbI1ulrs/2F1WMd9aLvmwC0l84kBrgcZhZRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gD8FvBxi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w9eLhfwc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFREsL008567;
	Wed, 12 Nov 2025 15:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uL9MPJLOI4l4f6owWcfd6CwHmwCLj9aucprbb8h1JIg=; b=
	gD8FvBxicSmZ6jS2fNgwkR4pgivCIUIxDM9ebtEx4In9KGVHqtXmlpiOSI/i+KMG
	OZEzLf62MgUcHYNZMeVThlad+3BNbCWycowtE7YxXKaRy3Tt5i4EGBIJYBGqoUcz
	9dKj114QK+Qxw38U9YJ4kdFXBreD2BiR4A/iT00ZDewP0V034QsV0XhpY8ur64fC
	GWmd7GbpkzxEFFUm7HcBG2bUbCUHoEc8tZ5C0gTzI38HUGu7deWNuzueV0+xh8g9
	Wu9Rt2XJkKWqdiUiLV65p/Ceb2sDOt/zzoVPOIzz0GDN4mKUp8iAZk0yn8eqXGK5
	BouUkXCY6ppW1fw+cscFxw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr1gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:36:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG4Ek005332;
	Wed, 12 Nov 2025 15:36:49 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaauc44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7eKiNSNtMO/Yvc+JVYEgfSHG/U/0p4beDM8qzTJm+4oP1RtEFkKtVuFSBTJ27DFywa+u9LWasXeIFiTzCiuiIP599YLC39a78u1iyfxdoKRIbQwJB/x3usitRkLS4D4KFy+SWtwm8VqHpELyxyPci2HEXtkwOQTkCDBT4yFklOmAHcIo7CRl5Y8lE2Fhfn1c8VwS0mMazaTSbNxOE+Yx+1UnT4e98jbFaFIiFnxaJKAXV6nbJAvN1zjM4MBppxKTqylxK4bfe4zqxIywa39MktL5akj+3gYvIeT+9sZLY91gAfHCACLBI8RjFO3JRM+gNAZX8K0K6waum9u/0GNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL9MPJLOI4l4f6owWcfd6CwHmwCLj9aucprbb8h1JIg=;
 b=Ht6G6qL3Ni9f7B0HqT6GzB7v9qwwV6zqKf5v40XlFHDOBEbHlNjgvfBJHsiUr3IDlMMYgPoFfFmytwzlduBpMpUlIVYgISr1D17xIwl+yuXVIW2cVMX/w21Ax5mf1JfW5Qdn3ZvAiXCc2xAGaYls0q49wEgAVMw2kFHuxCUUfqVTR9oPUjEj0ged0dFgz0gfMXHwtjFviYkqcdjnRmlUaXbScpUjBnJ9e1Ot2oKRgCW2HeqXt5FRgT7RGsdyG+FwI3emIhrDo7fp7Pl1dbMEpyKwyT1LM5FJii34GHKZALLdcg9wLylUdKAmRblxdh36ksF2BAAeRSl5eQz9jXPbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL9MPJLOI4l4f6owWcfd6CwHmwCLj9aucprbb8h1JIg=;
 b=w9eLhfwcdXgreyGfjMCm/KDl+jXzkebhhKNdsufQ869lRhGu3bW6CDpxrxFnxuSbMQ4dstY8QZPrCW71uTY69n7eiFYrTiLsNY9Cee7pqNyF3zYVLZjjJCAOFvTC0EUNnVBqpN5lDabsQ0L3ly0G/Ha5JU3r69A6w4UDjsR+DTY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB4998.namprd10.prod.outlook.com (2603:10b6:408:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:36:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:36:45 +0000
Date: Wed, 12 Nov 2025 15:36:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <a948b201-30e0-4ffe-ba81-e033afd94ba3@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
 <6c7c5f86-a9d5-4b7e-aa08-968077f66ace@kernel.org>
 <B02ECB62-606A-471A-8139-81327D2F6B5A@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B02ECB62-606A-471A-8139-81327D2F6B5A@nvidia.com>
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e77536-1b15-4da6-fedc-08de2201491d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjRKR0Njc1pZWlJkd2VLR1pmUzd2QUNHZU9hbW5xTWVid0h1a2U0cEViL1lx?=
 =?utf-8?B?bU1aeVFqbnBObXZMRk5JZFMrbmdKbThEaFp1Q3poWlZjQlowcXNsb1U5OTFC?=
 =?utf-8?B?dDd6NTl3ZmNhVkRENGpTbFJCRGhaRWVLcHIzWFl0T0Q4RFhZejZlVFpIdkFx?=
 =?utf-8?B?UzRmNW5UajFiUW5abXFJUkhxaWJqQkRXQXo1VXpwSVVPWkc4Z0RKbC9vNlZI?=
 =?utf-8?B?eVVPdXNFYitmWWVkMXhKY0Y4RGZOcWF0QmcvM1lkNmlvTnlxL3dzRHZsWGM5?=
 =?utf-8?B?TE1yNSsvVEhIUE9KMGtHUU51ZHdRSFNqWEpvZGYycDNaZC9vNThpaFFJbkJ3?=
 =?utf-8?B?Ymk1WlBwY1hxc3NhMUl5SnR1c2dOSUdOVElhcDhVcGZSS0tBbHhzTnFPb0Nm?=
 =?utf-8?B?bnh4TlRXVFZNZ2RId1A0cEJCSitraFNYdzFmTlowY0R1QkVsNlVmUUhGWTVP?=
 =?utf-8?B?cWlvMXlHKzJlTk0rVkJ1L1JYaklrMXR1enpBNU9wTElKVjhwTExOVHZWZHVK?=
 =?utf-8?B?STd6L3B1Nk15OTBMbEZkak11ZEQ1UXo5R1pOeC83UlVaT1F6dW81WTdjWDg3?=
 =?utf-8?B?YWpwTkR6dXNwNU5tR0phcGZRcWNPajlHdjVqOXJwbTl0RGJvdW5XRkZuTkdj?=
 =?utf-8?B?Q2ZENkQ3QTRaTWxVU3VRVlk3K3VMVjNtQ1h2Ukg5WlZ4OVhTcVhFYm1qTVRj?=
 =?utf-8?B?YXJEVUJUS3Q1bnJVVlV6SEZ5UkFLeDhHRGRBdDF5eHltSWdRZTRjMVR4ZFB4?=
 =?utf-8?B?ajZzSXZQaXNZckZrWERvQS9jSU9YdXZzN0NERHVpelNmaENVQUtlVHhZU0tz?=
 =?utf-8?B?YSs4YWhra240VkM5UVNUUk9qdCtqNGk3cnYrLzM2VnZrbDBpQktnWkJsS3hL?=
 =?utf-8?B?SWt1VHZVN25SK045NjhON3NtdnJsKzlZVzhOQUhyZWdhSFc0bDVpUm8xTTVw?=
 =?utf-8?B?aTNsQmJoKzA5ZnNUbmc4Ly9lbExuT1hXZHhrSUlBSVAyYmxTcHJ2ajFrY1N2?=
 =?utf-8?B?aTZIcm5USHA1SllvMThhMFFzMlRNSklVaGo3SlJZUWJvYUFyeDNxVlRwN1VC?=
 =?utf-8?B?OEFiUmxOYnhROGp5QWo2bUJrbmJCOUlFa0w1OXZ4bDVuTG10TUNPVTFhWkFV?=
 =?utf-8?B?aXZ0cG1BTTNVN0dWNWF3ZDdHbVVIRVFnaE16a3NlVGd6S2hyVjNJTDRnMkJ6?=
 =?utf-8?B?ODVxM2JreHFONDFXcDQxY2JYdjJMSTNiUmZCYUdhemhVeHZMUlc4UWI2TWtP?=
 =?utf-8?B?VlEwR1pTejFWa3ExQXJaK2drbEg3QzBGZnQ5RUNpRGRNMDRUMk5GdHpqS3gz?=
 =?utf-8?B?Y0ZHRzZTSEdSaFpQYXNZK1VKeTZzc0F5VEpQOXF1SWo4T1o5ZnlHZHFRemh3?=
 =?utf-8?B?MXNNV3NUZVljNmZaakZCenhoM3hHVzQzT0ZKSkU0Z2pyYUlzUW5NeTFLWTJm?=
 =?utf-8?B?UHpTZWVUZHhZdzAxVkxmak9HRGkyc3RxeWJQQnpyb2lEdzVWZHZrZWVzY01s?=
 =?utf-8?B?SHkwTzVoOThIcXR3b0l3L2ZKcXB5cW5Vd21QRmlIdkl3cUJmcGZXcEFPc2Jq?=
 =?utf-8?B?dHhGSFhIZmRpU0FxS3BPa2FUdExPQWJtVTA2TmNFMDJ2NGZuQXExUkxDR1BK?=
 =?utf-8?B?dy9ZYkRieTRkcGRkQmlIZWJ2L2JmWkI1Q3pLOE9FLzJETm8wdC8yNGxodXc2?=
 =?utf-8?B?QktjM1BEQlQ0N2pod1pHTHVNN2NHSVpOSXhzNGd5Q25xZ2kwZWJMejRpOGNN?=
 =?utf-8?B?TlBhSFBxZ3daajd4bnlzTFBKSVJwMVRTN3A5YW9iekhSaHcxU2krd2ZHYjd4?=
 =?utf-8?B?dFU2TVQyb1pGTGZNYnpySTc4cEJBc1lSUCtlWFZ0Q01Gd3U0UDI2MVA3OHo4?=
 =?utf-8?B?a00ySXlSdUd1RjIxOXU0SFVzdEQ0YW0za280cXlCaG5CS3U1WU12SExCYWhz?=
 =?utf-8?Q?gxkJjYFY+hkQUWhwjpSOZBs9JRf4N8Wn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUR0L1JNcFExbEw3WW1Cc3JNWVB3VVRaQmQvUU1JS293WndlemMyejlwQzVU?=
 =?utf-8?B?ZlF1Qkp3d1lQenA0WHpPMEZuUHE1eEtRb3kvTlNLMkxudUNuSDE2WU8zcTZt?=
 =?utf-8?B?eFVhb3lINGZwQ1FyUVJydGhoOUMzamh6eUNxM1czM1A3aW9Nb2toQ1NYQ2Q5?=
 =?utf-8?B?OUFFUW1UV1dPL3pGNWEzc1VGS01RMFpiSkVVY3duUmxyQmFlcEc5QTV3aW9z?=
 =?utf-8?B?dWljQnUwcFpndXB6dDJJdHdoM0JoSlVnT3JPZkNEbHhmMUdLWTVmcmszemxw?=
 =?utf-8?B?a3VhcUx1bFNUcXdqRThZZjJqdG9ldm1RZjNPYnIvdGxLSlNvMjUzeUhLWmVN?=
 =?utf-8?B?ZGEyVGRjbWNvSWtRK3hYemo5RUJMQXZjQXMvY1RDYkp2dVRKc0V2K0d4Y0pH?=
 =?utf-8?B?SEVCLzcvaG5mdU5kMC9tZHZDS3JVVEdraTdBL2xvbVduQXhYVmMrT0E3MUZu?=
 =?utf-8?B?NHMreEFSN2hrWS9mOVVPa2dLU3l3SnpSenlhNlRNWjNYWjhrcXpseHh1SXlw?=
 =?utf-8?B?STRoSTNaSFlxNERHYzdQYmdUWTFYeTR3WGt0eFprSjhTeFd3NStuNXFHUGdp?=
 =?utf-8?B?OHBwYmNvMHpZWjJtNEtEWmUwWWY4Sk9nb0VXYWx0dVVoZ1JSRDlMcDhhRnoz?=
 =?utf-8?B?UmNOUytIUlZzc0Z6N0hOSHBsTXZCY1gwY0lSbmF3aFlkRHMrUE54NjNJcGx6?=
 =?utf-8?B?UmlzSVJ0REoybnZheDE3cU93ZHpMa21yalJZT01STXZFbmZqZGlMd1JHbzFn?=
 =?utf-8?B?OFBrWVhNYkhwRWJLWnh6eEM2NWE3RURHL09reTQ0Y0RKN2hId3E4OFd4OVRo?=
 =?utf-8?B?YThIbjAySTJ5VE1EUCtuakNuQUZFWWRjMlAzNWd1NUt2WmdWWi9ONUNadFRS?=
 =?utf-8?B?U2JsdFZWUVdzZUEreXd6OGRTY2VEM2ZxY1hCN1JXRFdHZlRaVGdWVmN4RG5Q?=
 =?utf-8?B?MlFrSzF2cTBYWkMxaDZrazdaV1ZFektvbzF3WGNMSEZCV1BxREJoZE1laW5j?=
 =?utf-8?B?WHloT3ViTVJVZ1F4WGJkb1BIbDFnQmdCTGtRMzBOL0F4UnoxcE51RXpFc0lt?=
 =?utf-8?B?bE92Rm43c3M3Ni9tYVZjSFVoYkRmeDhKdVpqNlUrdzU2SkZTR2lVWWgydWww?=
 =?utf-8?B?eWQ2NWVEZjlMOFFyeVhnK1NhTnJYSTlZU0dKUm1yK2RnVUJYU0NBR2Z1MGhB?=
 =?utf-8?B?T01OcTBrS2VMQmVEdWZ3Uk13ZEFSaU1TNDMrNHdiVkQ1U1lZUXFiTEgxaHQ4?=
 =?utf-8?B?bUt2WHpBdnltOUxmRWpiakhIT0huTzQwTWNEWEVPL0oxS2FIN2haclFFSGVm?=
 =?utf-8?B?YmQ4cG5sR3k5bXF3NU9HZ3NWYTA4dzJlYUM1WDhLTTduTFhXcEhLTVYxZGw2?=
 =?utf-8?B?ZUFmQ1hOVkdJUXpxUlQ0MzVWNXBqZ1ZCSHJPQ212QnBBOFJlM1B5V3FLN2FW?=
 =?utf-8?B?YW5ab09LQzZCRldZQUEyZjhvc2pTUXpOYzRCQTB3M0h5YTdtTlhuUmVjRzZK?=
 =?utf-8?B?enhVclN6MnMvWktlY3FtZklTOXlZQWozcGFlM1ljL0Zpd0JKQnFQbTNtNElK?=
 =?utf-8?B?WVp1Z1NNRmZ0VTNFMjZ1RE1ZU1ozN2ZqSllpWGl6MWwwZE5wR0VWc3luaEdH?=
 =?utf-8?B?blFvZ0x6MmZlaU4xZHRMNXdrUlFHNm5iKytidFRvZjZEQlhiMHVXMCtBTjNQ?=
 =?utf-8?B?dmZTblZubnJuTDVaNytwQ0YzNHJLNnpYMTRKaU9LL3dwU0NJZzNCOFRCSnZL?=
 =?utf-8?B?ZFRmMHYySU9sUTRhaW4rQTVBN1pWd2s1TDNxTU1ZckQ2bmNpODhWaUZKalJE?=
 =?utf-8?B?emI5U3Zmc2lLM2JxUEFMYTBIVTlqZ0dZVFFDZm9UZkcya2hkdHVQSit3ZG1P?=
 =?utf-8?B?TlNaYUs0NVZCVjJkQUtiajZJaDJhQXhpMGVzdnlINFFLcmQwVmJHd0Y2dG5H?=
 =?utf-8?B?RkxUR2t0VmhvNC84Q0hpVnRtaGZkODdEKzhCTHFsenNXNnF5anpnaDJNWnhI?=
 =?utf-8?B?U3A4SUlPL0Nsc21NbENxWDRlaUx4NUlycTFHSXRraUNXbkx4OHNyZVcvWmM2?=
 =?utf-8?B?TUdxZE1rY1RXZm42allsU3BpeFdCQ3pOTVlBYVlvTzRwclUrUzlzbXJWd3BY?=
 =?utf-8?B?a0RGUUFRelpjaTdkYlQyMWQ3Qnd1angxSDhQYVpoMmxoK3N5RnV0dGQ1Z01J?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bDFvI+HYXFknN39WJpk4xufShnNycEOqTrmFydQLKstMiN1GHYBYU/NBhLW0RaNcQoRXPGwPaCpVx3SlxcELT8+B1rqKULyHzIEfxe49XKck3QQvRg6i/265UpedrrRzWwa7+bUKL2sHj8Anc1R0eOd8PzB49KuhnIpbYX0OuIOvyRo9slWQxrWf5dbDQSIiV0J4mV82uVHfUnjg6BMB9j7To3ZDFPjNxkdo33Q6FfFjQZ5DPooSgHHlvBjoqzc9uAMQY5pnK1ucWTcJ7XloecJUEULCX1NjaCGNnOg15s2L+KREJZKwqc4MAhNiO4Ra68zNMmzIbsu1EkLa7r+T9GXrqehPmx99477JUUjuONdMA8DhQrdT5V6kN5JCHnDsaCO8xgpB1iaSszCZD8544USUPQ5X/UPxQ2EY3YvIovB8OtpU1wSqTF/U4moZ0kImuvP1twEi1rk2pisqzT7lOArDoF9oOeXdUQSqrKA/P4hUI1AF33mo2s/GUNxvhxVy9DsJpz+WFTy5gsQiuEBkza9IBoOt/UGbqXkEgWff4mCxOQ6FQpwrZqppX7IxonJuD0DpL1VbeYvlh9IFBlt4G3ddMc+x5gBF0xqnM0nsem4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e77536-1b15-4da6-fedc-08de2201491d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:36:45.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL3r0SN7mepvaArzBkIiSeGnjLZiQE+0pOxYhPiYFHfBi2QwzSqS+EoJPyBkR4LDsI9/UZ/moXR8WyNdoCKzd57baa50rVyqkzhvKHe306w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=720 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511120126
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914a992 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rCarSFuA8aE_LGZ_h2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: smJZV6J-P6xtEAeKZJVbbDkJXABpMMM8
X-Proofpoint-ORIG-GUID: smJZV6J-P6xtEAeKZJVbbDkJXABpMMM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXw446rs9YQvDk
 2FAQmspe+bgMOiYVfJr8+e7A28f9G2a9di1j2fsvr+At68Rr7WNkK5oru2n7kZ5V51HbPSI6kNn
 daZ5Pp/SDjxOFd/XzbDnlNvm/AAL3jeIznGwr+s6HjjaYlOkQ0YpbO7n3UBJsTWjOpYkAhxI5Ou
 +bbRCkSbBBD8Fxh6Xs9bQe0zhrdZ99rCUHZ7KdSFrbJAowje2Qe8eB3vzWHYUgYj67+gOBwwgyv
 F/U++qdzuaWU9iDZT+EsuPNt4WnTfR87jJ9axHono9pG18H8bX+6g6E7PbWSNiBGVLTTGgWcEc+
 zXSKrFKq+KyrN01t0MFcRXhRNDe0hODuZwmrpHj+JAVwNEuO47JW3owtfavbc3cbUSJZsDxVcod
 TwFpn1HbeMfHyj3cTVFmIGMmDiM7Rg==

On Tue, Nov 11, 2025 at 11:26:03AM -0500, Zi Yan wrote:
> On 11 Nov 2025, at 8:06, David Hildenbrand (Red Hat) wrote:
>
> > On 11.11.25 04:25, Zi Yan wrote:
> >> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
> >>
> >>> The kernel maintains leaf page table entries which contain either:
> >>>
> >>> - Nothing ('none' entries)
> >>> - Present entries (that is stuff the hardware can navigate without fault)
> >>
> >> This is not true for:
> >>
> >> 1. pXX_protnone(), where _PAGE_PROTNONE flag also means pXX_present() is
> >> true, but hardware would still trigger a fault.
> >> 2. pmd_present() where _PAGE_PSE also means a present PMD (see the comment
> >> in pmd_present()).
> >
> > I'll note that pte_present/pmd_present etc is always about "soft-present".
> >
> > For example, if the hardware does not have a hw-managed access bit, doing a pte_mkyoung() would also clear the hw-valid/hw-present bit because we have to catch any next access done by hardware.
> >
> > [fun fact: some hardware has an invalid bit instead of a valid/present bit :) IIRC s390x falls into that category]
> >
> > Similar things happen on ordinary PROT_NONE of course (independent of pte_protnone).
> >
> > A better description might be "there is a page/pfn mapped here, but it might not be accessible by the CPU right now".
> >
> > We have device-exclusive/device-private nonswap (before this series) entries that fall into the same category, unfortunately ("there is something mapped there that is not accessible by the CPU")
>
> I agree. I am fine with the categorization using pte_none(), pte_present(),
> and softleaf. It is “hardware can navigate without fault” that causes
> confusion. Removing this comment would work for me, since people can look
> at the definition of pXX_present() for further clarification.

Well I proposed a suggestion :) I think referencing PFN is problematic ecause of
those softleaf entries that may also have a PFN.

I think better definition is that the entry is valid modulo the present bit.

>
> Best Regards,
> Yan, Zi

Cheers, Lorenzo

