Return-Path: <linux-fsdevel+bounces-47818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C8AA5D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38A11BC51DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0F21B180;
	Thu,  1 May 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ea7Ma2EK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iu10UcUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568A21ABB6;
	Thu,  1 May 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095862; cv=fail; b=sD/K1nH2YNBvBgyEsPishPtxMhla0x1Vq+XAnnyJoqQedKXwGIj1/JsFYBs2gLEv+flM2l0+Dry1kXa7oKukP3/Ccb0DxtowTfNQWd7a1M3zBg+ij5GMET5bjcDKNGZjw+/hJmVac2ALiUi/AzuFDp6lvWX+DoZAunEejHHOjeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095862; c=relaxed/simple;
	bh=vcZMkmYnr4J7NidLqExRCZAK5ypc7by+9udxsnxAjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/xQ8jl52OVABvu2HBV7X8X5F6QmxlRZICW9JEZZmB1zoiDYZmZLkF/bAokPbnnKQRSzVM1//OPoHp6odS9bAho93/doYbNHDXOdJ+Gljbr2Yz7+Y9LbKUYk12s19Dffv8FIU/pVdE1K5mYfHNWpBxDFMrRmYdrYgO2wEU0FKZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ea7Ma2EK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iu10UcUQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418fvOc020040;
	Thu, 1 May 2025 10:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vcZMkmYnr4J7NidLqExRCZAK5ypc7by+9udxsnxAjDY=; b=
	ea7Ma2EKSb3ldVRFalVJQZapZBjSsYF+JR4Ijkl+Uu7hAL46NOlblPEk5E7CLKbY
	jQyDLhzmJy6+Y3pdhi7p06TR/tz9R45RmFbuMfxEesxz0XboleXYCASuwz2yS7JJ
	ZzEjpR/d5nCvMsCsixv8yurq+ZCDHFXbFtviCpez07RJxQ3iODGT7fTlqf9TlSSc
	IeIlrzUZqoYFmQtvSVT8HYYv8lwYMsuNdqySGpJzWe+pdYRcjoSFbtOMbtA7vZXG
	VnZBHtZ9J/KZgNTo+Je2HnbgNC0WwrxDTEfJC1rtPOxg+doc4X4N5Nz+i1SqVGHx
	Eu8klkSA4l3O7SlJ25vF8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucjtrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:37:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5418w6Cf033479;
	Thu, 1 May 2025 10:37:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcde9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezHbPPAjcYRASSsFHbx9qX+P3RiPOdWArGFVfkDIjIW7NAlOZIc+GOYxKW3lxMhICGidvqYUGhX9agSrMwtKHu3KuH2YkYWrHMvLJjTmxVbNZFXC4juzXbWdgzVOYXQfxjnYat6J6rrd0B+tEKey+P05J9fAicgCcY397APmebJjs+ft2LR0ar+PIW883e0Zsv64nWEXQeks7p92RSzTm4htCQp3RivnTM90fKZI+umqGOrGN08wNccVI7wmw+dRY5Yghep7Ris3zdQWszYII2na/z49VJZl7O3DAGBq04JN+V/0H+3Kh5UQqPM1/t1wuxjMo1oe3OyXJ+T5mVQINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcZMkmYnr4J7NidLqExRCZAK5ypc7by+9udxsnxAjDY=;
 b=eztg6lwVO/RksVYgOXC8SzbflQ+UH0LvbuEXdgBNpisKtftJ8gNR4bX+UOjFAZYXA/8CBS/mF3trgL7xIN1tWKBSjvmd5r6Lj/a97JeHj94FLUcSpfFIgU4eRt/AQ5JK1plj+ZZkX42ZbQ5hBiIAQteNIzdSXO/7fR30aPx1XOvFwjKoOQ4/Mqk8WOYXpdD4x79ZwZ0FYjBfAAZKYsMSbrH/wpkrC2Hh0oOfTufJFKSlRRq9FNednhNKbGoS8ulz1Vh13aQA8Dkw+6c0C19CwCdNeveCM0FJBgk66HXKqBwTwUB/ZqXWhZIm2+ZBrMKWiF+4O3aISPTsz14pjN7WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcZMkmYnr4J7NidLqExRCZAK5ypc7by+9udxsnxAjDY=;
 b=Iu10UcUQjnJ5fjcmYVEQrAAtC6lq3A8P2tyUE5w6POMTWg8SISkpErfwA3AcOfzVJAuuqKDHkD3dxjGXK7I8rDr8cEPB77PA262lwSjEk2SofKdmUOb7D14akqbMlMjrssr1xMryhBhlQr+LhHsR0Z1Y4VIKSu9jca+msLz0SnM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF7113AF9D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 10:37:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 10:37:19 +0000
Date: Thu, 1 May 2025 11:37:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <36956515-35f9-467e-9102-d6bff55f28b7@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0268.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF7113AF9D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 49effba0-cc42-46e2-3fbb-08dd889c25f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXprZ0h6NUNhcjJTYlB3R1pJaTRZbkxQemxRSHpJZDJITjRXcUF6UTdXYTU3?=
 =?utf-8?B?TGtJTmNrUXI0Nk0ybldjbmJzZGRqY3BEV3VLZEpqUUlXMVVsd0xqZXdwRW5P?=
 =?utf-8?B?ZFNQd1hKVllyMDVodDBDVFlPUzFiSEhOeUxTc1pPaVFvT0Z4L2tibzV2b0RZ?=
 =?utf-8?B?S2hWU2x5Wk5IakZQbGpadG5sWmlTNWQweFpGVkJuTmhuYmo4NnIwaEVYTEsz?=
 =?utf-8?B?MnF4ci9aV2hzS09mTEh2MzVJbUhlQ1h3cGl6NE1odG4ydzhMN0pXTUt4WnQy?=
 =?utf-8?B?S3NBN3VjOFVLWEpYQm1aQ1pKcDRVTmdjMVdpTGVpN2ZlOWhPRFNiWFBrK3J6?=
 =?utf-8?B?bmxpSUlERDBWM2x0SE1zVllmWFI0UFh4NlV2NVJmYUNsVkNhZlZ1Z2dUWlcv?=
 =?utf-8?B?NTJtaVNUblRCRVNLS0VWVjlWSGdic0hUUXpROWRMWEpjUnVRanRYcnNVM2gv?=
 =?utf-8?B?MC9ReW9oVlExMTBtenVnSGU3cVVUTUd3Q1p4dGxyUlpJZktxNWpJcTFUa0s4?=
 =?utf-8?B?MmxNN1kwYUJWMllMSmdETU9TcHBBMFYwaVlNb1NxaVkwNm8wdHd5UGN3czJp?=
 =?utf-8?B?QjJQMEc4dXFJd2h4b2I1eU54MThUNWJhQVpMd0RqZzNwVWJKMGtGc2I0ZWZN?=
 =?utf-8?B?dDNybC83c2UzaUlGMTZEbG4wMkhVdTg4cVVmSHhXR0tyOStxMXRGZGk3QmM4?=
 =?utf-8?B?eUtKMHB0R3JJZzBRa2FrdHZkTFlVQ3E5RWtRckdraldkNHNsTWp3cWRFdWpu?=
 =?utf-8?B?NkZ4a0lGRGcyWVdEQWpaWTNwQnVjU0d1dk8xQStNaFpUYkdJSWZ2bG90dlNh?=
 =?utf-8?B?bUpLaG1vVnJHcG9pWWJ0VmRLZVpZV1RwTHlvMUM4b0pJZUxncFZjaEFoak9H?=
 =?utf-8?B?VktCT0llYjZ1NndJRmVFZWU0QlJxN0dHN1BWdHd3RmVDZFREWlZFMFVCMmlu?=
 =?utf-8?B?TThpM3Z3b2FvU3gvbUw3QnB3UzRaNXA5Z0Y5SmxRdkFkUXZhTGErcTE2VS9r?=
 =?utf-8?B?SXZWcGZINUNWTDBXVnhvWUNYSHF5WWZpWVpRRFRtNEY1bm4vbE1Pc2VOZ3Z6?=
 =?utf-8?B?Uk54UVRreVJHc2lRM1NPK2lBbEhsNHN4aU1idmFZVHpFd2tHR2MxQ3ZaMmFo?=
 =?utf-8?B?WVQyNkJibS95d0crZHpQOC9tMlFuOVlrQVc5T1J5dHA3M1BFS3RTVWRrSHJR?=
 =?utf-8?B?WlIrUnJ4VStVUVc3QXhaQzVUTXV3cFFKTkUwV1NFcnZJSWwzQWUxUE1vYWti?=
 =?utf-8?B?UFJWMitDc3d6TW1pMkEwdUl5S2N1d25WM1ppcUZOdnFTZW84RC91YXY1bUQ3?=
 =?utf-8?B?amJZNmtWRXJpQk50QWFBeEVieEhkWXpHYWlQb3EzWW1FRWY5K1JuTUV1Umtp?=
 =?utf-8?B?cjZlb3pTSUdaZnRKd0xEejczZWFDcWZYSzA5TFFwQS9vUGtaeWhPdE5YZE00?=
 =?utf-8?B?amFDVXMyRmRjUWxVNkhiaWR5WUVEYkhBcHl1ZjZKUjYvc2xha1ByMXcxVm5N?=
 =?utf-8?B?QUlOVkN1S3BKeXplbG41VU5xalZiWXNRZ2xHVllucU8yM1ZXcW5wM2J5WWVK?=
 =?utf-8?B?b0ZsYmszUFJsTEVVQ1g1RktMYzFGYjFWR0NYYWcrUEx5bXRnRWMrQVd3MFQ1?=
 =?utf-8?B?YndGM3Y5cHdQcjQydHZabk1BRmxieWtKQWdFZTNuWHd4NjE0N2ZqWXZKRkFn?=
 =?utf-8?B?RHMvRDg5UmVtaVZIb0dMMDlxdmFValNLL2F6U2ZWRmZycWtoTTI2cUxuWGNG?=
 =?utf-8?B?WVRSVjRlbnl0S3Nvb1QvdjhYcldIWWdnTmV6YnlzNVdueDBCSktOblQ3cHpV?=
 =?utf-8?B?RzdWU2Y3RGpKeG9mOXNkOGw2SUxjVmk0UmtVTzBwVnhXa2IyTk1TQ1dmOFor?=
 =?utf-8?B?YnpYSElHbmpOQko4THQwS1dobW1tNmVycnVISkhoKy9KTFZhdXpPQmg1N09z?=
 =?utf-8?Q?5GLoWmKIiME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE4zdFRGUlJXNHVOZENGU3FERTB4dG9kNytyODBtbnhNN3FXMFh4Z2hOVTB6?=
 =?utf-8?B?SUUyNm84SHJ3eVdidlVUS2cyLzF1WFNoTHliMHg2citoekdadlE1ckVHSVNq?=
 =?utf-8?B?RUQxWXRZem54UU9KS3FJaXhseHNEc0VyTnVQd2I1Vm5ZRGVKZXdnTVRUcUVQ?=
 =?utf-8?B?RlFJNGQ2NU82em0wc1h0YXM3QTNXQzZEbUdyT0FNREUralB5VVl6SWxSOE9D?=
 =?utf-8?B?eEl5SzN6UGdmaWVUU1hXNzcraUNMbWFhcHZvV1VUOHM1dXd3b1J4Y3dCb0ta?=
 =?utf-8?B?aDdZc2hjUkVkV0ZLcjdUVElRazNUU3R6UG5DbVFZeml3RS9yU0VEd0RLNDFw?=
 =?utf-8?B?V01rU3VzZ1pLRDNFaVpGUmRJZXZJak9uS2tId0IzbVEvNkZLTTY2RHA0YXAy?=
 =?utf-8?B?MzQ1eXFPK1U2K0pJT0JwUXpJbXdZYnpFUlhmSGMvQkVpK2FFNHJ5RHYvL3Q3?=
 =?utf-8?B?WWtEU1dpNWR3UmVoMzhuMlhQVm1Wb3QwcENuTkNrTHlnY1c2ZzNkdGE4YzVw?=
 =?utf-8?B?RFptNjRpUTZocXU0QjJ3bEYxM2tkQ3lpeVdJbXFSL0h1QWFHeTBTSlVUeTRX?=
 =?utf-8?B?VzhPaDZhbGVmSStEOW1GUS9IRGtOM25odHVmRjE4VXBxV1J5V2JXSzlzbThX?=
 =?utf-8?B?VGNxSkpGUEk1b2NVQ2R2RXRNdzJpeUxuaERZbUJtbS9IUnpMVGFVWWN6RjU4?=
 =?utf-8?B?M0hDNk9yREZwWDE2T2thRURnejZLMXN0L0s4TTJKT2ZycTNpajlObXY1OCtp?=
 =?utf-8?B?UDZMeEhzczJUQ0E5akVNQmVLMkkyN3Z0cWpnbHNUQ0dxWUhQSHFrVEI5MWZ6?=
 =?utf-8?B?b3RWNVVzcXNNRmpwc2dxbHk5bEtrT0tYa3Uzckh3YklVRTVFR1FGOFNEYmIx?=
 =?utf-8?B?NHZ3ZUpsZlBlVmthVmlRQjV3OWxYL1lHaUJLTjJqU3BXQmM1dmdXNW8ySk5p?=
 =?utf-8?B?dVcyeWJ2MzNEbWNwTjkxdU5YSytvbXovOHdOeEtxbzE4Wm9xdkkyQzNObWVB?=
 =?utf-8?B?bmhOOXhJY2JUR0Z1OGRXZlFHZkt5YjRGMXVTelYreU5jRHBybHkwOWtycDdT?=
 =?utf-8?B?U2JUR3ZFbUhlZHZnMjdoaml5T2xRSXBWSlc3VWVRTnNXL09SclBodEZCQ2dP?=
 =?utf-8?B?WTVPekM2MHBDaklRN0FOYWw5SnNYSXdtVnJwZnVlUE8xQ0E5Znh1S05PLzI3?=
 =?utf-8?B?cUx5TFFkY0V0SGtkWFpLdGZINTBVbENnelY3aWVybVRZaVdEbUpRNlZrZnJN?=
 =?utf-8?B?UTdCMGJzbGQ4VGJZcFd0VFNLei9NMGZBc2ppdEc4cGdzWllvWWVzT1ZHUnVQ?=
 =?utf-8?B?c1FNWjM5OGR6YVpFamIvWnJjKzhVeGxJMjhZYURuT1JGNXltZmEzejJ5M3F4?=
 =?utf-8?B?ekxOb01qVWluNmRKVURpNllnYTZwZ3pabHFCdG5ZNW9EMFJkWlNkZjhNYTRT?=
 =?utf-8?B?QkFDZFFCdmdrZGU1bEY1OWVwQnhsRjZvRmtIaGh0NVhDYzc4TUhJbjJZTmVz?=
 =?utf-8?B?MXZoR1J6MmI0cXJXcGlRNXlGd2RBWEpadUd0TkY0MWxEZ0xDYmRJY3l3N3Ax?=
 =?utf-8?B?NHhLOXZxMmV6YkxCSGw2S3pDL0QxSkVUbnVMWjB0RVY2eGYxQXdBZ0QrR1hJ?=
 =?utf-8?B?QnptWmladklWZ2lLMzBNYVBvNko1bGc5RUt5MWpCc0lEdkxLcUhIUS9WZC90?=
 =?utf-8?B?bldjcytTbk5HekFkMUxLQjlOMmlrL1ZORHNaTlJRUDVjYzR0UnFkMkJERk81?=
 =?utf-8?B?R0k2ak54TmVWb1pNS05qb0NqNHZDR3FidGYxSTFIRkZTV1RtSXd6dzk0UFd3?=
 =?utf-8?B?eUZtMUNVd3hTcHEzM0pFRis0eGxBWjJFSG5aTnJsRzBwM3AyVWRBMVlQWUV2?=
 =?utf-8?B?UWhDVjFmMVpvUDBCRFQyVXlSVzhOZklMUjRjdHo5c0x5N0Mrd25FcjQ1S3FM?=
 =?utf-8?B?bmNtd3YrekorWXVMTlR5eXRCV0pHcGVkWVgwTGFydTN1WWJlMVRwSXVHamN0?=
 =?utf-8?B?WVQ2eWFKblJLWE1Ub3dZak9FRWdXSFloOTAzYmpZcUw1by9OVnFlYUlQSmYv?=
 =?utf-8?B?bVA0U1BjbW9BalhTbTJnMVJPQnJWMmVMS3g0QncrL01XbDJsWnRBZUlac05j?=
 =?utf-8?B?UnNrSU1LczBrdkdnY0VOdkszSlFwb3greThFMFBYb20zM3pKc3ovZEU0aG5K?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SVasMA8XU0mgKjR4qGpH1OtkabD60wweAoi+DCEULxvQs5lZcsNO6MW8Jp1wuERwpMBzDKFX6SIYcM8D5HMWxYoW3h+hiW2QI1Y84wy94A34j679yjQ5p7AfY1W9vSdJtUHLNCfaZENbde+NauVciJ2mUQSFAdTEAhCcdKADKPKtOxgD2m2AF3G2tQ4qc26tTsQXc+hiT0xKEU/PynJ3j3OKCscfQgzD0WEZLAtQCec6EtyqCg8oNYo0JbMdm1NyO/okXi+04LWrq/vWG/te+GA8WMOKezXLTZLfbk7U5Fj04hq0TUun44++5b2/ZdSwzNUxHHqBPXRpiZ4UOXueD4M3wrPusRV88Q3mljw6U36Y24zbWd7960W30X2Uu1ZHQ3M26jLsvUvMFVxNJtlfj85J1iNitGMgzxTL/c3qxkS6ohpyH1z7THKM/q7EE2+QtvF6EaouERl8KsNXSkCHgXj/9UvrQR37lL0BuQ2hq7i6CR64OaiNuB1+g8efaPHkjaa6xQdKBSgkmQPMAeI5+PdOgk3UlAANLLQAg2kTmkqI3BM3xKR8eb+ZbD6kS6CMeMMLqaO3qKWpNU7gDSAuN1UT1ZYSHkYO1ot3eYJlg0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49effba0-cc42-46e2-3fbb-08dd889c25f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:37:19.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YFLaTkQY1wJ6k2W8F4fiRmvVcv2ZkzMzVGrMFE7amoI6ej/cJoMbwroc3XEpD5m4iGS9MEIuvEfDwIZnlBSt/lzSkdRc1thbvE3qtmjiuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7113AF9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010080
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68134ee4 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pPTw5VjWxJJn03ta6FoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MeYU5CA-s8SdD1ky-ADshN4GZtWo8zqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA4MCBTYWx0ZWRfX4c5SaRuokYJ1 ks6Vni+M6dmEbVP4HnJLlbnwHkIFc1XS3vLfPzKMoYVlGqiI7RKt/ao1oKHqPa0qIDDJNYxP+8J q7LCbMXYJQbfIaaOpqJmVY0uc2yu4taUtVg00Xvwb+o6UVVKhK4Mguth8FNUkW4gVPBJghBj1Ws
 jxhdEMjIO5fzxUjYlpmCwk1dkF3Pd+teRozMyvLaiwzmXr7d2NdyqCeUEtY6yNG0gzZWso5vh2n cwoUMM4nWycHzuv27bwLYLQHLKiD6UvPzDoYXGJJwP7ghfTDonqHmXl27qV+rlmlIbZndVxXNLW pdxvfUB9Look5dRGbdTSjqH5Dz4SgDOIXyQLDjWipT7U7NLZcXddAn4iwrUNQxLSeTRzsIUW4Ys
 6jZ60xjM2V5AvJTvjKOmgsdWmTtGmEbZy6bJH+ReUQxgjw+fWfeFuCuAhRzREV0SYfb9qY9j
X-Proofpoint-GUID: MeYU5CA-s8SdD1ky-ADshN4GZtWo8zqU

On Wed, Apr 30, 2025 at 11:44:15PM +0200, Jann Horn wrote:
> On Wed, Apr 30, 2025 at 9:54 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> >
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> >
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> >
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> >
> > The .mmap_proto() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
>
> I wonder if this requires adjustments to the existing users of
> call_mmap() that use call_mmap() for forwarding mmap operations to
> some kind of backing file. In particular fuse_passthrough_mmap(),
> which I think can operate on fairly arbitrary user-supplied backing
> files (for context, I think fuse_backing_open() allows root to just
> provide an fd to be used as backing file).

Yeah the fact these exist is just another example of us being far, far, far
too permissive on this stuff imo.

I mean it's useful ofc, but the fact you have multiple layers of being able
to do _anything_ isn't great...

>
> I guess the easiest approach would be to add bailouts to those if an
> ->mmap_proto handler exists for now, and revisit this if we ever want
> to use ->mmap_proto for more normal types of files?

Yeah good point, luckily we abstract to call_mmap(), will have that bail
out in that case, thanks!

I think by implication we shouldn't allow .mmap_proto() and .mmap() to
co-exist, rather in future we can add additional callbacks as needed (see
discussion with David).

Will respin accordingly... :)

Thanks for taking a look, much appreciated to both you and David! :)

Cheers, Lorenzo

