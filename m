Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF82329425
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhCAVti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:49:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1496 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbhCAVqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:46:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d609f0000>; Mon, 01 Mar 2021 13:46:07 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:46:05 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:46:04 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S514tyzUdAbpkp+4cxWzlJSBz4kiwNLZeODZHgGrUH5l10SXzGixKDtEt7YGRN6/KallSTQRjnifqKnNO843GzBFIj+LTXP93RCZeCdhs7o3QkEALz/I0vefzEM1ptSwyrNbsaLXXdbsqy4d8WPcJ5KEBDKbDecPc7frS9ak1q2WFfFeIxC+8/IavN6VsFNQKee0kxVPJxoGM1NmQi4UcBNFQ7XTwjtJqM4qzIqP441d7BWLRm9EyLyXFTx/LoEFEs+r3bVHsWPNu3VDI2e6mLmwOOQy/JmvQNkt6NYw26Xhf1UM5kfT6CiDHJA7W99O6cKc5qCGSgIPQmxjN2oaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoMjO2L5llyoS1lYKS2V6UX3evN0CzxXfwaF+skbRwY=;
 b=Mm3Rl3xbQeg+pcqk6Xr7D1WjO7GrqpSK31eeMbe/fD+70WUjWD9vE2MtT02kJhBjNl5YqCONU4kcygS4LRIMnV4peIwFhWszR0soHv7l3WeBSYS+yp84V+anrwXX9+m2KMSI1ietrHZnIOwg00/qXY+cIYPdioAlB8Xii8t26FPJnsKyRBnxloOmmX4zDwi6Aixor1zmpPw9tlXG+YFo4CyJCWIP2X21D1afWyEIXf6KG+GF/PqFJQu0eBEEh7rTGRMO5kXdSyEAjbxZ+yO1YgWbgQfVaeSlEe3EEBCpq33deznpakjcxQu2EWYPA7u3YSgazbDOTROJArBESa7hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 21:46:01 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:46:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/25] mm: Add get_folio
Date:   Mon, 1 Mar 2021 16:45:57 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <64776836-AC91-4F62-81B0-F52C1124B39F@nvidia.com>
In-Reply-To: <20210128070404.1922318-7-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-7-willy@infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_A28B92A7-8A30-4E14-805F-1C648DB93C5D_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: MN2PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:208:239::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 21:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94822b5c-514a-4d38-5fec-08d8dcfb6803
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256A96509A4E6B054FF9ED5C29A9@MN2PR12MB4256.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZIO4dioSWh+WxQjaRdQF62YavvxapUmZSk9GhVtKU/WBv6qqKyAPDCoHCLCOJlwfvWgc7DUM/4Kd8ON+xqqVxSmfu/7kbgMM9aHCdj5APbP7P98GiHxnQ9Y+S/NLnVa7+GK5775Y4ubem/qYepNAGSZBkn2m1hE7V+kZzTXTRCgpshc0H65Hv6jqDviWsWXgia29390TbkHxE3tQT81xHn6bq0UHNf/Pudnqd3KI63BdoCvH+Uq3biaL9oVui9E9FPsba5u9UXomqKQ2Cz3xd9N/ZjHCyRgAH0PIIjYleCis2Cfoi60xWyYYExQygHpYG6BK4WahC78xfZeoCt6h1BNzVSPHohy+YcLzJgYRK0r3zQbj7s9av4Dq22XcQuMOpCTZiN8+l/s4lqg+TGSeCyZhb0F48oUIj5GCFuiGlE5Ip5yfw5DNScKboZwzM4uzZStsXshI+iWkaH76M3q8ImiY9L/jIeYQIK9s6JtoLiECUMFT0ceDaiuvKHhNf7M3HKt3KONKLCsAXPAfeDUqmNK0ZbyLRcLyfHHHhoe5dA0/jZe4OCSp98aKahREO90eBcbefkQyQgcqqckXTQlPv/+MeWwC5xtj7rBUAU3QsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(36756003)(8676002)(6916009)(33964004)(235185007)(16526019)(53546011)(316002)(5660300002)(16576012)(186003)(478600001)(6486002)(26005)(33656002)(66476007)(66946007)(66556008)(4326008)(956004)(2906002)(2616005)(86362001)(8936002)(83380400001)(6666004)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEFEdit6RUQxUmVzNzdvYlJtSjVVL0VuU1BBcnhVemhydFpEQXFoc2VNbGpI?=
 =?utf-8?B?bkRTZXNzVzNJbWpadmpCcytDUGl5UzJSODdkcEpsa003UGwxQkhQZmVrdFJY?=
 =?utf-8?B?MjFyQXRHaUwzTTlOYjBlQmVsc3NrK293bkx3VjVxU3JaOWRyWE9BVDdiMzUv?=
 =?utf-8?B?RXlTY09JZnV0cENGYXRiWGpUMW5IZklQU0U2YUV4TUZjNlhxeXRwOHhYaWVK?=
 =?utf-8?B?VlF2S012c1RDalUvKy9rK3FLUkN5VklRaE9TelBST05rZmxveWhwMXdoZGRh?=
 =?utf-8?B?UHhObnVlRi9Lbm1DdlBFbVBZSG5nVGxwSnhzM0dSYW1nVXdhWUNZczd3elh0?=
 =?utf-8?B?Q1owUUttTlEwWklrU0tmRHI2dHQwNnBEVWMyVGFqSm16MWZUbDgvRFA5TXh6?=
 =?utf-8?B?aTdQMkdnL3kzb2hVdXczYU5LcHVzN2t3UUNyR0tjK1B4VWtZNldGVXhFUHcx?=
 =?utf-8?B?d01yYmE4dGR6ZWZpamJOQVZidXBZQit2dmxkVEJlaURCZ1FmdXNWeGdIOXE2?=
 =?utf-8?B?VFpSNWNFREhUT1NoMi9LbWlRcmtKK2NvZitITDIzUmU0ZTdXZzN2MWd1Q1hQ?=
 =?utf-8?B?dWtLTlhDdmR5MTh0VDRKaUs3MVJzSXRiU3A4M00yS1k3TWcwWW5menlRSzF4?=
 =?utf-8?B?MU1Vb1h3Z1ZsSFVTUUZ2MWRhS1lBcG51d3l3dnhWa0lWZlBUQ0lvc3lHd3hs?=
 =?utf-8?B?VUlqRHozYkd3TTFXenowem51eVA1cXZITnJMd3AxU094OXpTLzV4cElpei9l?=
 =?utf-8?B?OExQNmQyTmpxTGZpdGxFNDM4QysrQjYrVVkzWXRESHJLRTNEc2xQVU9sWnh1?=
 =?utf-8?B?emxtbHlUK1RTVDk4U1JJc3NxVmRxWmxxSW55Wjd3cU9pZTJwN3Rnb3VrVWwr?=
 =?utf-8?B?OFdFODZRSi9BYlpaS2owcVVBaUs2cEV6NFA4WjVmK09Pa0tkUXpva0lHUEVU?=
 =?utf-8?B?anpHZ1lJSnRNQjdETUNvejZ2aHFCTFFuMTE0RlIrTzdFNHhKWlY1bFRzUDV2?=
 =?utf-8?B?N053L2M5Ly9mN1NJeHhhOXZFN0VqSis1SGNGZkhoNk1IanpPRVZWT2tqZkVH?=
 =?utf-8?B?OEtmQXpHVExsbnR1UmU4MEVQVU81UThHWCtsd1VQYXcrRDRhY1JmUnNBNTNI?=
 =?utf-8?B?YXVITllWNUxPZ1I2am9rUk1KSTRFcVZyTVE4bVE4L3pEWk5CSVkvN0NzQmto?=
 =?utf-8?B?eGN5VElSSGlvRmZSb05wb3NYQXpUbTEyOWs1Mk5NVkVwOW5lY3NXc1haT1ov?=
 =?utf-8?B?eUdpUXF5S1ZYMjB3eThhT3VUT2VsQ256R1dBRGVTa0gwRWRMLytBdUE1am5K?=
 =?utf-8?B?UjQrSTB3a1pDMzBhZTNjdFp3K3g1Z3owOTl1em41Wit3eldNSXBQelFxY1J3?=
 =?utf-8?B?clI4aFRqSG4yb3BUeG5hL2lTMzlzcUI0elI4Z05qaWlkU2tiM1hSYWlnUGcr?=
 =?utf-8?B?bUVZS0x2TWwrRjZXSThpazNVa0h5NmtLVVlXTXFkNDlOTzhNcUhJenJJYktE?=
 =?utf-8?B?NTUxVU9EOS9jWHZZcXBacDJTaEQxaE1GTEVQNU9DbUpDK0drWlM2TThNakll?=
 =?utf-8?B?d0Y4WnFwTTBOcUxiQmk2WUc2NkUvci9IUWwrbHFuL1d2TWw3SXVqNVB6R2dC?=
 =?utf-8?B?V1A2b3pGT0Rpd3lEbWdwWWdlREdYeThqNmFNb1pkMWFpTEdDbSsvZXd1MEVY?=
 =?utf-8?B?czZmMXNvdk5ZbXBhVDNNeEswTm5HbjgwaDlPZUVUc1c2bEZCbUQyMGJLelNh?=
 =?utf-8?Q?grKsja5gKI7DpnksR2g2FHCHh3izvCNOLa1AaDh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94822b5c-514a-4d38-5fec-08d8dcfb6803
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:46:01.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbrVxYZv/9SaHkdyTko/9szQISK8bl83D+qQRrLggyOF1IvfRPlklHTpx+lpKz8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614635167; bh=mmfpVTwsOMPzrBhW2hqEfJ5GupmU0pytDQj7cbsyO+s=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:X-Header:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=AFZNC/HozpkqDq46F1p0JUdqEA+T5nq8GT4pz1uO2iPxBdDeDH64R2Tlm/YpXkquq
         4aS7leIcHFOxsgeGKU/2v4M3RkIdK7bu1JAlFEQZePSsFfmTH+EqGMSk1LeiuwOut3
         j34MtPQwAkj6DaJVX4qWi31LA1ZV7OlttMxYpA/2luH0Wh8SNXHgM+H1ln7zpqZoST
         j08TwyMeki5S7Z7wnNG5OeDRKE/LoyXG+UJkTNS/cqRmPKU9KkNvAGMCN0HfhPQ0/f
         Gu4epSUI48tOPPRHUxHTrP8gvw63pMutCxFGV13YVajkr1j94GxT7XpAAIc5/m5pst
         a9Rpfs0G8SSjw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_A28B92A7-8A30-4E14-805F-1C648DB93C5D_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 2:03, Matthew Wilcox (Oracle) wrote:

> If we know we have a folio, we can call get_folio() instead of get_page=
()
> and save the overhead of calling compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 873d649107ba..d71c5776b571 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1192,18 +1192,19 @@ static inline bool is_pci_p2pdma_page(const str=
uct page *page)
>  }
>
>  /* 127: arbitrary random number, small enough to assemble well */
> -#define page_ref_zero_or_close_to_overflow(page) \
> -	((unsigned int) page_ref_count(page) + 127u <=3D 127u)
> +#define folio_ref_zero_or_close_to_overflow(folio) \
> +	((unsigned int) page_ref_count(&folio->page) + 127u <=3D 127u)
> +
> +static inline void get_folio(struct folio *folio)
> +{
> +	/* Getting a page requires an already elevated page->_refcount. */
> +	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
> +	page_ref_inc(&folio->page);
> +}
>
>  static inline void get_page(struct page *page)
>  {
> -	page =3D compound_head(page);
> -	/*
> -	 * Getting a normal page or the head of a compound page
> -	 * requires to already have an elevated page->_refcount.
> -	 */
> -	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
> -	page_ref_inc(page);
> +	get_folio(page_folio(page));
>  }
>
>  bool __must_check try_grab_page(struct page *page, unsigned int flags)=
;
> -- =

> 2.29.2

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_A28B92A7-8A30-4E14-805F-1C648DB93C5D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9YJUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKOy0QAJICYbo0tpR1you/zC4VytR3bVray0xBJksD
kMuD3TdXsazy+g2F+VPPpMAEMl8Dk/UbWWjI4+4c9U/h3WHPEubSSuRYldlS/faq
xw3AzWRPH90w4KLW/DvSP/Uk+ontvMv/kq+CTVv9mJT1OFA65hm78OUtiyX/XLG9
q95DdBswaOOKYA5ZZBFIwduw7m2j2xsqQt+zOuii9TrLENcl02O32q5s2kbCwTS8
QZkp9g4Qzk8pMAwQByOm4NORWFpKlwhWMIaj1jOkYJwH+QdGU7K4j1Bg+d5Hv2wX
XMYcBOZDqnYvbnV1JyB/tzYoJ9WH8xPOipisZGgxWmo1i2Ohubwd0zk2gebkeJa9
ScvkqK+OPZUqDYUO+3Omhb8SWPvXbYFAxwkHI60yCid6lmI5wa7J/JSNUMCMSuvn
sQaJmLleTDHD1IVQ4KZGdAoxKIIoMsFCPPx/4e5dFFJR671xFBoG1/4Qp4wMlkxA
JyaYDk/OnWt5g+PcrwsTi0TfGEi3xiuXBVqW10PjziscMGmlb8+Z0kez3U3Ng2hf
O2yD/zrWg2tQ678YhQC3v5svEodtSO/jIacnGciwnB4rYpy6SmjNTxfkmTzQmm8/
v7jVziKK5IydFTBErqaq7jrC7y/QMBi+XNca4xRkDY0kUOKtYt6tf3t+nKD1IMoH
LX7g5xUb
=tBPu
-----END PGP SIGNATURE-----

--=_MailMate_A28B92A7-8A30-4E14-805F-1C648DB93C5D_=--
