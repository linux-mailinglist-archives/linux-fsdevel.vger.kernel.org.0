Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28753402A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCRKCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 06:02:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRKBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:01:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IA01MR068694;
        Thu, 18 Mar 2021 10:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gRu8SAPyt5Qgb1RyO4vM5YQvjxNP7hBl2Ab7mfdgtQo=;
 b=C+QANCW1aTM3riqyHQs1kh5Fh1TlfWhAPa4YW+a/v3aFo1FW9tqEr4RUBpECsyoUCKYq
 K1VYOEVqBifiInaHWCCidR05Y74X+HdCz1I7fcqhQlNesSXzuoE6H8Bvcy5Y7D1VHoAM
 3e4RrsAXPVQRbge0CuN8YlM0xLY7m4npkAeUxQQmi3mHa4uMTXC2YiWJMWMYtIHmDIZq
 foDa/0mp7bSkx13/R/7kwLp2n1Eb7WWVxaHpIvfyz7JbbYMhmts9KhwRblE6VVVzILEw
 QZTdM9gUmZupPXGW2oEqreMhE6zmXhpu+slHeOEpm+zpiD+DeBWQtbCRvExxSrw6h1rc 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 378nbmexb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 10:01:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IA0pjp154958;
        Thu, 18 Mar 2021 10:01:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3796yw0agf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 10:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/++qlk8u1mLbaJf/vPcLrGPIbOfOYcc/R1/7LE37oRaYi0Uo08e7v0Pi/1nPWnOWVe8Jx3uIkPxe7BObdnKBjTShsmIK0Uh1h5LwUt3yUfZQDY0f0tAq/vfP2mwM+CpvBMRk12jmhtWIWub6J6gRc5cTIFo2ahM8euLWmfEmvFe5lkuliRQYqPfpNx0jm++S3tGRXRcVoL2I5U4ZSkzQ/sOh9yDju2KgwJ5F//JbIqzunSwLDNsxYqJWS2YM2S368xe/usiG1n3v1NowMGrsqyKddvgIGGaA/BvOWrfW/sH32Ha8EMtxLOcOlsaMg4FoL79rx2hj20pmSSnVzAvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRu8SAPyt5Qgb1RyO4vM5YQvjxNP7hBl2Ab7mfdgtQo=;
 b=XqAnRhstk4XucjDd1UZMDjL6qZmpY8k7XGFQrLbKoz6LdEYacZMyKPFeFxj8ISAh8d/5h3dGpv3S+C9etIilTKQ29HRMpr7+prd6gGbC33w+Wvo1BFbeNLrLgDtSHhRhJOoc5RRe1p01sYXzbiaowejLo1farDQCM7kNNvcE84noFpfRkjowOlbf78n59VP+uFHDujl9rO74tdTqH5cPWPB7vLDQ1GYg0IW7RWxSJXHyEtda4+7a2na8cc0nczdiW7ZuA6P6VHtbHgyZdAAxBx60vQzDVqUAaCOgYvYuvL7HzDuH93QjFoLpqHgJPNZOX45ZqZ9nHitiQg0ILWiunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRu8SAPyt5Qgb1RyO4vM5YQvjxNP7hBl2Ab7mfdgtQo=;
 b=ilVQTLkrWTsX4jwEGZmx5Y1eH0M/OmiwHO+46FuaIi6Gph/A8wJiM5doVWT5Vw+9HKqGsyC+Rz9sTYWkk9lZ7E7Fb6LnuRoxCtXMZBPjcaqe3067pJzmNLvd0xbzbg461TJs1MC7wQ9dYcciAnjTTLjf6H4xoojgiD0wqoCP7g4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 10:01:15 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 10:01:15 +0000
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
Date:   Thu, 18 Mar 2021 10:00:54 +0000
In-Reply-To: <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:153::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Thu, 18 Mar 2021 10:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60eedaa8-9311-415b-2715-08d8e9f4c45f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4305FD8F7B09E996EA4024E7BB699@BY5PR10MB4305.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byxDBJHFR5pka9M4HK4ZFgOH53gujS71ddluMJViv7W2OYdE2cQRIgTfpaM3Ce6gdJ+CvB88/dLNbtknC8Gb8qaOHf4KTlOjpbAFKKpXoZhe1yfKMi5C0tXBlpNWp1shhH1aKN/9G6vWGuXuy91qe1kbUclSxkclxEs/WXhv86ory0G3dqJCP6gl6OGyftkC6vCyawXYBoWPfWsN5LQH3uILDARV5u+CQV0gKYxXQBOQHxsq7g6fCAcQaU36eLmI+B6+uucmnvnm/VV2uFsqfAeGGJnXQsJ4mKogCuhsEYlV1iw0dWkZ2EeQHy5MCCbHIkvuPtINVERER4jfECKc7gImQd8q8ng+gOZ6jtC2/UWKJ52U24RfoFK/mRbEd6CtYfpCcGiRsS75D2ttuiN5y7WgZ/iv+h7BSk/DRiov36A8/7is88H4dTvpllZk8bxCQ8WzayShMCW9YQO+4I4FoAOWxDE6XBjAccyg0l9Gifozfp4bKqSpEC1aHe7VRCX3PLp7ue1UM/8eqpecNXtH7aivZdgU0I988Azz1qdRmdilqR3bifonO7X+QC8ByBKtM7RYj4/pJI1q00tE1AFyWT2g1W/b2jTicl/OXNtW1w9A1LXB9NM7Ocu0tN58jKZYD5tJmZJWF3qY7OsbKLTpo4/phXig1KH6kOrtjidHD+AvJpVPSHRh+eitWWpNmayDgIVfw6T1LvnBrwNiraSgyCXZeytBU23JURI2vxgiP/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(136003)(396003)(376002)(31696002)(36756003)(38100700001)(316002)(83380400001)(26005)(4326008)(54906003)(2616005)(16526019)(86362001)(7416002)(186003)(6666004)(5660300002)(8936002)(16576012)(6486002)(66556008)(2906002)(53546011)(15650500001)(966005)(66946007)(66476007)(6916009)(956004)(8676002)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUY0YTI5eHR1M3ZqTmZxWXpIaEI1bDgvWmI0UmZVUVpOdFhvS2F5cG91UTVX?=
 =?utf-8?B?OGxOMllWc2t0VmtTOFVwdWxZK29JbUZGUHdhYW93RVRPNHpxVzNDWFN6a0Rw?=
 =?utf-8?B?UHhGUVg0REZzZmZaMkVBdUxhQjdXdy9SbXJ2VXJCT09meEF3Q1V1TDkreUFH?=
 =?utf-8?B?ODgzeG16eDgyTk54Vjl6YmVVZjVlWUpoRDd1S1J5VzQwdENhUlpSMGk1d3pO?=
 =?utf-8?B?OWhpR1c4VVVLQVVCMDNZdDdLU2JCNDJMVFN2elk1MTQ2SnE4cGVuT2FZbG5F?=
 =?utf-8?B?OG1IUXo5UDVzK2dvQlN5Y0VTa1lEdkUzeGRHaVFJRjFNZm41ZlcxRFczdmFL?=
 =?utf-8?B?V2VONTdmWDZJRW5qajZrcmxtNmxpbkdZYXRUU0FtZDVzbDdtV3RtOUxYMXJS?=
 =?utf-8?B?ZVFBdk5jT0NDZTY0dDRiNGM3emJSajFCTTNUcFNJcTRmajEwUlhobk1UYlIw?=
 =?utf-8?B?cEJrQTBTbmdGZms2a1U0N3F4QUlwd2lTa1UxRHZ5TlZIYURnWDdCRE1nd2Zx?=
 =?utf-8?B?bTRMK2Z5UTQ1U2lJem4zWTIzUmJEQm5JWmZyajluKzVadHV2ay9qYjBNK0I2?=
 =?utf-8?B?WU93c0tzZnNjb2ZuYmVrVkVydVc4QS9uL2sxb2U5QkNqQjVvKzI3VGRQVE9Y?=
 =?utf-8?B?RGszQWJ5R0lteWR0VUtyeUFTellFQUg2cG1MRFYvVmttOUJPRzVyRFdmWEpm?=
 =?utf-8?B?WXBkeGd2SHM0WVlsVXd0NEJIdDVJOTdjS3dOWHVUQ2Q2cUVUTWk5aFI3ZEd1?=
 =?utf-8?B?VGtIUitKdHhYckVXemNsL0lGWk1CUWlxTjh6NFlSNmZZNDdVT2NnVFZ1bUFC?=
 =?utf-8?B?Q08vM3g0WWV4bGZYc2tKeU5MMFJyR3VJb0V1eWNJRDdmS3UrOCtHaEgrVVpI?=
 =?utf-8?B?SzlTZmtmUGh5SFNnWFdNekZzUGxlMjFKaFN6Y2xZcTQ2Nkp2TzZsa204a2ho?=
 =?utf-8?B?bHZzUHpKSmpCUUlXZ2g5Z2lCQjlFVXMzODd6MG9pQklicGp3RDIwZ3IyYzJL?=
 =?utf-8?B?ZVVWWHFFeHkycmlzYkZzbHNpSUI4WWVQT0J2WitCT25QWVAxSnlkam5JNWNp?=
 =?utf-8?B?Y1NBWHlIeGs3Z0xVMzNHT0tWKy9yMGNsaUZMOFlETTRwS0FvOUEwWVJwb0h1?=
 =?utf-8?B?Q3BWS1BJQnhFTkFSc005SjZydks1b2JxK08xeVNwajJUK05HU01SWjdtNXRD?=
 =?utf-8?B?bUFNeHlsOHRBVEpoR2thazdTZ2llVytZdDdIOVIxMExON0hrZllEL2l4SGo1?=
 =?utf-8?B?alpIMkVsYTJPSTZyNTFHK0d1YnhHSmk0bjFXUWVEOTV4RTBPNjF3enZkck5v?=
 =?utf-8?B?RVo1QmlGQ3dPalpoNG5ndC9MSVE5NHJURVA4UUlEa0VTVFI1TG5GYmpTMFVS?=
 =?utf-8?B?bVBoZmg2MXRrL1lBY2J6S04yTWxQT3cvRzBDYzdyK0J2a292QXREK0VKdm1s?=
 =?utf-8?B?QlJZQy9ZK2ZHSkw4YnY3c2ZZb09nZ0pLNE5pdVk5ZEhuMG5YWDQ0U2JQSVRk?=
 =?utf-8?B?NCtUVS8xN2tlYk5mYnhWY3pFZ09XdkhkUnRHQjdXeFlCRWtpREhQQlViUGJC?=
 =?utf-8?B?aXkvMyt0Nnp0YXVCVlNBbFJPbkE2SjlUSUhMZGh4K3RNZnNXc0hPeXpKeFhr?=
 =?utf-8?B?RjczaU5xajljMWR4UEp4Z3g3VUFLQ3VvSVpKU2tiSXNpRjA3bDZ1VWRIcFFI?=
 =?utf-8?B?eG5FZ2NVYUw5SmcxRnpoWGdQSnBYbTJRdDg1Z2kxRUtmUnl2bkdPRnlPci9M?=
 =?utf-8?Q?azdKO4LFzodVwMsZDQ7CBAv52FB+iIFil03o2R2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eedaa8-9311-415b-2715-08d8e9f4c45f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:01:15.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRIoTtzRpxuNzf01nf/BI8M7xrbxKDRjEiSnP4gVDgNioDvmX6SIX9GG2uUfAvIvi8FXdyTktiJGwC8jcSr7VQYx6/n/ejCwsDEgurG/9iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180073
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/18/21 4:08 AM, Dan Williams wrote:
> Now that device-dax and filesystem-dax are guaranteed to unmap all user
> mappings of devmap / DAX pages before tearing down the 'struct page'
> array, get_user_pages_fast() can rely on its traditional synchronization
> method "validate_pte(); get_page(); revalidate_pte()" to catch races with
> device shutdown. Specifically the unmap guarantee ensures that gup-fast
> either succeeds in taking a page reference (lock-less), or it detects a
> need to fall back to the slow path where the device presence can be
> revalidated with locks held.

[...]

> @@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>  
>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +
>  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  			     unsigned long end, unsigned int flags,
>  			     struct page **pages, int *nr)
>  {
>  	int nr_start = *nr;
> -	struct dev_pagemap *pgmap = NULL;
>  
>  	do {
> -		struct page *page = pfn_to_page(pfn);
> +		struct page *page;
> +
> +		/*
> +		 * Typically pfn_to_page() on a devmap pfn is not safe
> +		 * without holding a live reference on the hosting
> +		 * pgmap. In the gup-fast path it is safe because any
> +		 * races will be resolved by either gup-fast taking a
> +		 * reference or the shutdown path unmapping the pte to
> +		 * trigger gup-fast to fall back to the slow path.
> +		 */
> +		page = pfn_to_page(pfn);
>  
> -		pgmap = get_dev_pagemap(pfn, pgmap);
> -		if (unlikely(!pgmap)) {
> -			undo_dev_pagemap(nr, nr_start, flags, pages);
> -			return 0;
> -		}
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
>  		if (unlikely(!try_grab_page(page, flags))) {

So for allowing FOLL_LONGTERM[0] would it be OK if we used page->pgmap after
try_grab_page() for checking pgmap type to see if we are in a device-dax
longterm pin?

	Joao

[0] https://lore.kernel.org/linux-mm/6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com/
