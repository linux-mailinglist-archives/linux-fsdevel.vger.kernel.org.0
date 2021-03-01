Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0032932F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 22:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbhCAVGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 16:06:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11380 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbhCAVEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:04:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d56aa0000>; Mon, 01 Mar 2021 13:03:38 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:03:36 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 21:03:35 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 21:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYofCel73ULFc0mMxiaS46xzr+F19orrYzQyX+eKziPQb42OQS+iTWt0oEbVTjNh3tABILc0JD9skETml1O0vgfTRP/78qzaiG0bz8VQw0XVlLlq1eUO/5LvsH+q11BzzivoCYuZrbrYpZCEE7HVzw39A6NGGrL8MB4I2eKpktSSVx9fjs9JFPfq2/y75aYm1dNde+ufkD2HcD2VmV8ZYTF5glHbgta+jUEc/8LYa8/T8tBKD8eMRx59t/WWGA47HNell5ekBK1JQn4g08OC426+e0I7yIC+IWbMjQAp4gGhfW48boYTU+5L+SvF8e18gZ2Mk6VUnLssUbTjHqTqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnHquyRjh+jV13ysPWeUdLrL9hUMUFMZtng1986xSXY=;
 b=U3g0JFVh2jgxTm9b9Qzc9Ef/vc5v5cZGKs9kzepDMYoVghLGuNJOOTvhfz1kvPHhQjfm7eHQGSq+SvhVSjIdQlmxnL7iBSb1UxCOIlKNcWqwGU3/pf9uiQFfLUCWbCkiBKAMmlzpQa+rHhs+4Ro0o13L7p2MP8ss7cSSfwuJg6OzVYu4s04YPJuFRL7YkbN5Q0SjbOuwlm9yL1gIaiFoDotEpnOZQsMovdVa+4CXBgZ1HTXKuyIwWWOuRPNdhpv1zUsXD1RYa9Dl7OC6t5vsoIri4h73hXdHIl2rhzNX4taA88DYRo7gKZ3uH5yf8BuLH5MSNIoccnGioXB4s5E2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 1 Mar
 2021 21:03:33 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 21:03:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 01/25] mm: Introduce struct folio
Date:   Mon, 1 Mar 2021 16:03:28 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <520C0A42-3C42-4E60-A305-6F45B4C57A62@nvidia.com>
In-Reply-To: <20210301205306.GU2723601@casper.infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
 <20210128070404.1922318-2-willy@infradead.org>
 <68723D50-AFD1-4F25-8F10-81EC11045BE5@nvidia.com>
 <20210301205306.GU2723601@casper.infradead.org>
Content-Type: multipart/signed;
        boundary="=_MailMate_99DF7D6C-AF24-48A8-8D60-A170315F56C3_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 21:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebda2b25-6e0d-48d4-4f88-08d8dcf5790c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4517:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4517C52A0BFAC70A7A2CAC97C29A9@MN2PR12MB4517.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezWwGdMWU0IJQ61bb7I6J7Q/ZNozECEudLD4o01dXWSKiHQzfEBjNI0YmoTmZY0TZh6CvCEoB2YQvT1wJ8HCyyMbd/r17XoOYkXMaPk+mHx8GEXlCvyDOPmBN07XA5F6emQ+YhIIfrOhhz6EWOTEk4UHbgHUBtkT37F4b1mepZJHoy1DWlo/8julAu3wj3c0y4dbvcoPXcWuuNtbRAo+BY3zuEpdLFu/HuKjGjiACLkI1udnaEvkODD/WU3conKdPPs2+HyiC5xFA6kaRNr4C2U948kibzal2CXHdCEYOu05HMegiJXheTpxFOGjriuyFf7UNXc18LfXux9NKNjtqeb2/6OkrHNXaHGBPfE8KzTmWu5bBL4i2h1KEiB6sUqSyedHk2gbIEqoGGGEwG0iz5WTHSo/XKkHU1f/+mJe3DRDZ50qacABS6PfQu5LNOvt/tJo5NoelakFkc4t5wQY8UPEVY6beehSEZLIUs9ehN5JYwn2rBV55HURaei6SFglQmCXgw+il61o6TNXlqlEoVZY3NjmIuyXXUV7TTbew5lc8kG7tNHhge0TMy6vvj2/P8gusd7RzEnK0+JNoGIFIzs/pdoOEve61fsWM9QuVuQ8ZTi85N79NYeRq6WvUkLvmnvjiPC16hA+mHmlWwkWJR8XscsG9hURneXyMlfydTcDdbw73XZkbdyTuA896h2K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(6486002)(86362001)(956004)(33964004)(2616005)(16576012)(186003)(26005)(36756003)(316002)(2906002)(53546011)(16526019)(235185007)(8936002)(5660300002)(8676002)(83380400001)(4326008)(66946007)(66556008)(33656002)(6666004)(478600001)(966005)(66476007)(6916009)(72826003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUdFNGVDaGs4V2M0YVovd1JDZGRDQTE1Z1lDQkd4QmUycGF6OUlPSndNN3Nq?=
 =?utf-8?B?WVZpTlB6WUQwZmhxV2NGTjZVeHF4WjJud0lTRUQwTGtENUIzSzhiS05ZZGZC?=
 =?utf-8?B?bWNhM0lBMlNyT0IwaHhPTG44S3NRMzcyRXRPdGJqS2ErZDFYM08rUmIvVUl4?=
 =?utf-8?B?ZEhTbE8yKzE2YzZTRjVxemcxeThXYnZzdi9iZVlaTkJKVFRRb0wzL2o5VXlJ?=
 =?utf-8?B?MlJjNk1iQjIweVN5ZnkvVjdCeWE5YXlRMUZwQnZ4YW40V3pNVFZWczczVFZM?=
 =?utf-8?B?WmF3d2JqSm0yQmNuQVhaWUx4OFFpMkxMNnlqVENvOXVncDFzaGh2b25xb20z?=
 =?utf-8?B?blQwS1JFRDdDVCtidjhyMEUwQmdyWHRLeVBIQmNMR3hncUpsMlI2WHRBTURW?=
 =?utf-8?B?YjVNSm0wazJ3aDhtVTFJNlcwaG9nREhsZ2xtTE1HaUU5ZEVSTzZkaFVwV2Yr?=
 =?utf-8?B?RWxZR2UyeUMweXQzYys5c2hOK2wzcjIrSkFvbW5zN2o2am1zQkVxOFRwTnRL?=
 =?utf-8?B?cElxc3BlNmtySlFmdWx2Z0laVEFhNVNBbUtreEthMFVtNWd3VEM2aDV6TC8y?=
 =?utf-8?B?VVJrK3lTejBBQnVVR0xjdDRUdzB1QXNVNjAxenFBcEtQU1FQQU5EZFRYZGxO?=
 =?utf-8?B?VkpVbkc4TUxrSm9UM29ZM1V2Z1U3MU1KK1RKbUVGQ0dCZ2gzUnl5V3J0bHRM?=
 =?utf-8?B?S3pTVXhjOXZEcUtIV1pYN0NVaHdhajVoUWxEWEhydnhjSkkxU0JIaTE5WGlM?=
 =?utf-8?B?aGcraWx1SnB5REtJSHJwM0xBbmZkTmhZeHZTWHpWemZYelo2eUdTbEd2a281?=
 =?utf-8?B?dmZFaDA4Mjd2L0J2NUVsNDNTZlMrVFFJZmQvR05WN3Jwa05xSlFjWlhKdlMy?=
 =?utf-8?B?bTJ2ODJ5VEs2ZmpFblN3NFBzWFM1dnk4U2svczFHVG9QOWRPMnJNRW01bE9o?=
 =?utf-8?B?a2FkVUpUUGp0Qnpsc1pBYTlYRXZhcGRsRkE1bWkvUEd2RkdpTjZsV1ZzK3lN?=
 =?utf-8?B?RG5Ua21SMXZIbURQWWZUeGxJQ1JjK1VHNkkxYitkVDd3MGd1MG9WU05QdWE0?=
 =?utf-8?B?VzV5ZXZMM0Rub093L0JCc3hZeWt5Z2pNOGt6MEZBUmdQK1ZlMnR4MXJpN1lQ?=
 =?utf-8?B?ZjdlR295Ym81SzlHZU8wejltbTU5OElEYzUzeGZwbmd5cnpzVjJIcE5BeG01?=
 =?utf-8?B?TVhLbXY5emt5NldUOTNyYkdUUEFXZHdUL2taM0JlNkJNWVJnVWlmYnJPeDFO?=
 =?utf-8?B?TEN1MTVzUng3Yzl3cTVMZUdyT3BmYW1PeHc0bWR2VmtCalVCblpFalZIMVNX?=
 =?utf-8?B?NWV1N1pFdmhOWXpKcnBHWDFuNUM5WGE4YXJydkUvdVA3TW16a3hiUE9BUlUv?=
 =?utf-8?B?MHFUbGlPTE1uMTljVnJIcWZtTm0yVUcxaTRJc1RWb3dUMnZsSi8vR2QwRG0r?=
 =?utf-8?B?UWlWcEN4QXkySnpJVDVKMGwvVXZtbEVJY0Nnb0hNMlRqYmV2WUhjMkk4NjFF?=
 =?utf-8?B?djM2RmlHcVgvZkdBVWZsT2xTMFRiR1JpL0hwc2hpa0g2OWQ4UnF0U0gzQWxM?=
 =?utf-8?B?bmsxYXpXYUtFR1VabUNuZCtEU3hrTFJDV3JTS0pBclpucHR3a2ltRVZobjQ2?=
 =?utf-8?B?Y29HUjhvOGxsWDJvWU0zM0dwQmVjNll0Nkx3WDB1RFVGR29sL0JaOFR0ZFVw?=
 =?utf-8?B?QU5RVHZoZGgrZFRnb3YyZHFmVlpHZkdMam54K2krMVBKdEZNTklMYWtjSHVP?=
 =?utf-8?Q?IAWwtge8WGmYgQyNHQ6B3Lxl19gqr9ZSz1AkFeK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda2b25-6e0d-48d4-4f88-08d8dcf5790c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 21:03:33.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqlNLFVWI2LcgrQ/Pe17d0XlxOhfeKowgh2PxbamRVvh+Pit+guP5w89SsH/D0M4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614632618; bh=5iGl+KNYWDxJaM/XTSEqOpzfbuHpoYP2/s8JsClEFU0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-MinimumUrlDomainAge:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-Header:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=csv6SJBBPPzo5PSDtqshVI3i80e02eyrQd/cMS9JzgKAbZZ0qRV6kBeDfpCY7RQXG
         C4UwpuZqDzk40iDWFYYckXhAt/MZzNSx8VhMyBvWrzYaNkBQq8ZPr5egDB1OT8TkrF
         KP0M1V1UkwnJXQXz+Vukp5jWaGUzv5klfbRW3WZJ9644c/RcEP7BO26neAoNyVrOAV
         0coNPCvV68/Zcv5gX4aU00F3sJi1syUNDSuA/kbWyFM/37NyMV8pn4IIk5Rh4w/AUu
         tYfMZPG5VkdrfCD3a6cvTInt4WxzhhODvpOCBx9ccpQLTOgDmam/955Uv6MmTZ+wvu
         LocXpbvXpvshQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_99DF7D6C-AF24-48A8-8D60-A170315F56C3_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2021, at 15:53, Matthew Wilcox wrote:

> On Mon, Mar 01, 2021 at 03:26:11PM -0500, Zi Yan wrote:
>>> +static inline struct folio *next_folio(struct folio *folio)
>>> +{
>>> +	return folio + folio_nr_pages(folio);
>>
>> Are you planning to make hugetlb use folio too?
>
> Eventually, probably.  It's not my focus.
>
>> If yes, this might not work if we have CONFIG_SPARSEMEM && !CONFIG_SPA=
RSEMEM_VMEMMAP
>> with a hugetlb folio > MAX_ORDER, because struct page might not be vir=
tually contiguous.
>> See the experiment I did in [1].
>>
>> [1] https://lore.kernel.org/linux-mm/16F7C58B-4D79-41C5-9B64-A1A1628F4=
AF2@nvidia.com/
>
> I thought we were going to forbid that configuration?  ie no pages
> larger than MAX_ORDER with (SPARSEMEM && !SPARSEMEM_VMEMMAP)
>
> https://lore.kernel.org/linux-mm/312AECBD-CA6D-4E93-A6C1-1DF87BABD92D@n=
vidia.com/
>
> is somewhere else we were discussing this.

That is my plan for 1GB THP, making it depend on SPARSEMEM_VMEMMAP,
otherwise the THP code will be too complicated to read. My concern
is just about using folio in hugetlb, since

If hugetlb is not using folio soon, the patch looks good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_99DF7D6C-AF24-48A8-8D60-A170315F56C3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9VqAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvxEQAIlKHEV3H0khZrrm6TL1x8xXtVWd9ozIqkew
1cknsMfRP3a+FxDDJ9afRjsBm50YY2xLmNIvLlRO++XC3/xziFiBSgHGLrDjIKU1
nU4sg2WXK/rg72+ODq3y88MCo8uRCX+ph40YNpWbKCgUGjEQCTc7Y+YMPRrlwzV4
lxE0FfrB1cY40ifB82fia3Ml4VnoXncZ8BQuUFnkoexz1iSr6wrjiEOFg7Q6CHJ+
CyTwkUJ8mPVJJoL3Q3DwTZ4ucZ8TKU6QhkIW9ByRrhqggho1zi4lpdBcb1H1KOva
TdP1EY3d2OCMfPf2T5/G1uHp/CgKUTTAj42YVEHSSSdLWjzrAH7XGya3j3cT5rsU
iz4jsXg9BRrnmQxqzwdd2EQsZpH7lajtxzuwWZXzZ5s/NriPxZhte6sv8MsCYqux
sNvPAwO4TvESzwrZqya4q+8obzWcG7jKqJA7Dy+3K/enUDpZBb9sXJSRKRr9vzVM
rG+8tNdMOLQ3WvLX4/qJeiBoJAjClvPz9/Nq201/0VVzKTlZ6G6Q6KrKtdZVARpL
KqNARoP8C+YM67s+GWr55Lj2N7pFIEFfB8gn2ZYEi9KfzRdzcWIv3KX3xBx7ITxH
xwYuab0Tdp/9REVAi5SY+8vxmQ0TPsOImynt02WwCTmRflJAXBiZ7DD21Zfp5PNy
cuxB+bC2
=/26m
-----END PGP SIGNATURE-----

--=_MailMate_99DF7D6C-AF24-48A8-8D60-A170315F56C3_=--
