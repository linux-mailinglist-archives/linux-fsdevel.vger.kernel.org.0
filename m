Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB88381804
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhEOK6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 06:58:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhEOK4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 06:56:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAtQN8099833;
        Sat, 15 May 2021 10:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tvkLSC6QrS/8CBSyYaAlK52m5mWVXNYO1QNeUG/b6uk=;
 b=MUTyZe4ezHcCmJ4YUW/m4vUDboQL9PjgIafRUp+5GreAlFPtXY3jWxsZiGpCgdAhWunt
 hIjQlqHcWPw3VDAnHDAwqFUa8W3cpiETxjuefJyJsUIaRcO1j5r1uBYCm6+YJHGO5Iqx
 bYVmx/5v//YeScZT8RKZ5RbwmPS9Ph9ZwQWsac3V3LqsmbrOG81wBjMWzYzHp3A+07eD
 PpJEgn8hZGGRGBS+2QfQpIuXOy9PJnUxQzWu7CqXX5xHmNuHjORMWbpvTY4kItBhZuTD
 J3beohun0/syEB7m1mzb5IVbJsnWyvmOGkCsygktcYvBxnZ7GCShtc3gveTmCuqoFImF sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38j5qr0c36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:55:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAsvGZ121456;
        Sat, 15 May 2021 10:55:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3020.oracle.com with ESMTP id 38j641hrg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZkzYW1yg1Ahk4Qonym0nYYWJCdYn1ZoRoBegEdFoHzi2sx3RIoepOBP9o102k6yFcb06BzuR0drhwEKRwknSzMcOAqskmTFaKCAgwJeC9eeiw/uqD1wgiZac79YVtnUUQ5+PwaGBhRCCgWqqlwG74HiRMGQ+CZmnsiPUjwwHidTHHWnKkSbj1acZIktvzsFy27YnKdyDwjw/wcicsqoDCQ7MefQPBhR6JAe530BmWN2xfXZnFOY5BtdzQuK21zu0Z0Av9naScy6BXwrvwsm8281L5r8qoIc4KluxoFnEsGZo9Sa6BE0bLANWqCAmKnc76NfrbtseGi36PxCQMxPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvkLSC6QrS/8CBSyYaAlK52m5mWVXNYO1QNeUG/b6uk=;
 b=MdqwBE4qSjlvIfYWkk6Ry3PGQl05Xz+/badagQoPT8BIp6RhBby1PCvlySQFzZuVxhp8bNGm1jT1Ueyx+Dom8nBh5EeghBl2UHI1fbHC6VibxRvwuYcGcKhL4TrtXkuirARPamvM/ytzeHmqwEsyditCNOHYTwhTSWabVkYCiV/6v6LlOBAHcmn8As/0mVOtYf0fuTiVkr1mfeCKxlatDXJOdaJcNHgp9af3ECMReID/Wc4CxpDvVxWA21trKNMOqRDE2mCDkOamu0ZViOW79ygBP8HsH2cDIpghlHotAw8jUcF84OIKKoRPgw2P/gikvnztUZaq8qvVxoEaKFbO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvkLSC6QrS/8CBSyYaAlK52m5mWVXNYO1QNeUG/b6uk=;
 b=liq7oxci2JtT1mXY4bUvo/7qPNRbdzQXo4Fqhgb5+pObGrccBRpnRbRtqPPfYlpfPhOlUfpaP9iMij9b1gQKmteS4pWGPRzHLcnAzzSIkija1eGSfdxtnSwouRFi20hN+2hjmwpv9XoQzyEiGXXESMVlb3XxD2n0CFh4knXjamI=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR1001MB2200.namprd10.prod.outlook.com
 (2603:10b6:910:3f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sat, 15 May
 2021 10:55:19 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::6988:8f21:a040:d581%7]) with mapi id 15.20.4129.028; Sat, 15 May 2021
 10:55:19 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
Thread-Topic: [PATCH v10 01/33] mm: Introduce struct folio
Thread-Index: AQHXRq9z5MmwRAsVWkK5UfPtNlIVHarkZDYA
Date:   Sat, 15 May 2021 10:55:19 +0000
Message-ID: <0FF7A37F-80A8-4B49-909D-6234ADA8A25C@oracle.com>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
In-Reply-To: <20210511214735.1836149-2-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:3d23:2196:422a:2535]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45a418c0-6dd1-4d43-3e2a-08d9178fee0f
x-ms-traffictypediagnostic: CY4PR1001MB2200:
x-microsoft-antispam-prvs: <CY4PR1001MB22004B774DD3127F99710E60812F9@CY4PR1001MB2200.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vv1yordvjjlmnwKrd14cjcueCcsgsL8dztvf8RYtR2Zc1NGSm2yvkWZV7JtVYs6powRZUg3718fpehY+r7twXfCemEilIpESBZqyFWn97GI7dWvWyzNOmgiAaZsnRp7N8EljaxRJ6vdWz/O/10w/cNbfDMdl7ljv7vV65iH7vwNjRO5frPEpfE+l+rxf/o/U0JOsVvkkUVKj+WdgTFLqdav02SaK1iaZNPo/g5O2htHauyXXhrbtDSK3KxODR+iyIXklyyMEuL4btk5DZmOFkqeGaxupBQ8Mvea6L5EffWFMXn+UaLjJuLkEqCBUenQJxSSJ5edD2DqV0Rq6hQZwzrIBBljaHmkByH8zYwnhC31yNGfKqXDcDl/IEDJ26ky55J5WBo9L80wLT+fhmyOREJPh5azu2HvZesasj2OMNrCnpkgpXEV/mgr/bwZvk+tjUZaZsIMD2Txdas/2l6WR+tyron+RRD6sshFtY8zw5QXDCxbDTEQBf47bvPnBkUN897R/l4n8xAGWjSgZHo9OUliFiOi70yrSHz436vq0r0vMT6zaWs1tZ/+P8/FxkbB6wwMAvdPS9V55v8UftkklG2pUGPtlkq2hTb1hbRdTJnTCfySsiOYeuA6enIJPr3pseiZP6iNyTrdLBWNDgmTA8zL/fXzEqGQFYB0bmP/t8nA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39850400004)(376002)(396003)(83380400001)(71200400001)(66946007)(6486002)(76116006)(38100700002)(122000001)(54906003)(33656002)(316002)(66556008)(8676002)(186003)(64756008)(66446008)(2616005)(8936002)(44832011)(5660300002)(4326008)(2906002)(53546011)(6506007)(6512007)(36756003)(6916009)(478600001)(66476007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mOz+QhwUQRZARBMPG68YU85eHEXpuLaq6FbJn6hJrRggZsIxJfiGzTBc7sgS?=
 =?us-ascii?Q?Z37V7ONISq0AniJc9yf9rz8tRjj01nsX7lb5tGSkrH82dUPC2lJm1PFKX53m?=
 =?us-ascii?Q?hXfKlpgWbhuptE9ZHalKe93YukOCkaBdFTk8ogNu8yiCS6CRpFYkNsUdAsbV?=
 =?us-ascii?Q?lRNanqLiO8vZeyW9LZg4GHcwX+NgvFksmAj/0YzR9O+dlryiROCeiGxqs5PB?=
 =?us-ascii?Q?IYQlmVAgaeV9V+Rk9yRxWSdicgQOSmqPka/0ZMms8t1bPmuWQrcVRf8jXEWA?=
 =?us-ascii?Q?v6E+/DPemEmaA1AhGGhgkUvSyDDMfKO9nXODNADOQ7imgVkvbGer+dYM+Zav?=
 =?us-ascii?Q?iv/TWDI1E987VD2xFNYADTe1+1uTg0+2C7bL6uMcqP0OPr4ijHkxSk+tCU3I?=
 =?us-ascii?Q?NyU0+opMrjIHOovwpNIjHWRoqos2TPVSr7GM504QGqX5xpo48300Zf+0sbMG?=
 =?us-ascii?Q?5dXgUmrltY4yvER7tbSadI+fszlhOmqfvJ20XM4LB5hdrCY36Gx84b75PIE9?=
 =?us-ascii?Q?YL06CaL38ZHaklfRvhgHvtx8OA+TCmusf0ye5wo2TZONboBkPuFSdT4Bwe4z?=
 =?us-ascii?Q?BEb0YmawwYQ4VMbfeuh2Jmn6HkPwF2ZuRYwPMDU5gNoKOUqpcOQgdHKpqvfq?=
 =?us-ascii?Q?MdS4ZYzlnVGFy7UKelE5ByjOWzYzGCJVn/+tqn7criBRbZOPRQtQJM4pMnuI?=
 =?us-ascii?Q?vJR63ORMiAaessEC9NU8db48/hHHZNTr5NInR3gytIj8DEhCvScvolgPASPZ?=
 =?us-ascii?Q?N+xpscG+gMHzX0qQjBei5Wlxrg3uvf9kKDmlcQ4indZ8Q8y4wuNr6RsGAS+v?=
 =?us-ascii?Q?EStcN15j9hilsMr1Q65zdcchV5wgGddTrPoSRX0iYoRNAijb0eQ6SNkUoElS?=
 =?us-ascii?Q?+Fw+HE9pVZ0dKrtM3HPwm/9+2aCScl8MJXXgsk15ywzZDqnlAxw8VgRfyzu2?=
 =?us-ascii?Q?XUh53UNXvkoVwprgr4uWuuUatiCTJWdlqlASv69z/B/ymHsoF9Vl1UE88kny?=
 =?us-ascii?Q?D51F89S4TJhzH3U81A3wRVD+tbFm9pvBpip+P99XDNclRBQZ0zwjnCvIoOjA?=
 =?us-ascii?Q?ywOPOtF9MqI3suXcKvr6BxO4xKS0spUhLBwH7BqcjwxVZ/TyKW1X6wZg4u4M?=
 =?us-ascii?Q?jMhthEjSdWmSiC4gpDTItkVn3OkwMJNqBM/EgoYbr9Z2HSs1aNhSgfVNqgt3?=
 =?us-ascii?Q?+Pvfihe0eUYjWk5Mqte4SPVHxoQZjMuESWrZWdlvhmGFkPZ1DQ5wVVc8wK1w?=
 =?us-ascii?Q?WzbRjUaWUSvfz2y11DKPo2VijP1+nHk4gKhdxQjqzlFrYvm66KUhfWG8Cpih?=
 =?us-ascii?Q?7oUP07zO34zjlvpbLUqkFamxVfSoHO/SdleysdAG8iB0kNkp8iOufV0vCqKj?=
 =?us-ascii?Q?KIuupOvjuKhbQzAd4llt3eyanIQcmGwarfc8JNJcpESk/RVxRA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D063F472840C6444849A22C9389FC596@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a418c0-6dd1-4d43-3e2a-08d9178fee0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2021 10:55:19.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rsf9+6t54tk1XDPX0EXGfpH5rstiYrpl9sX7sWfcAtbHSPmh1/ncx9BAWhRJkf6FiH4Q402hr+5/LE0gPyJUw63SgMuWuXUAFcf2sFBdFhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2200
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105150078
X-Proofpoint-GUID: -33O_lXolWigzaHt8t67xbwVLbdagdLZ
X-Proofpoint-ORIG-GUID: -33O_lXolWigzaHt8t67xbwVLbdagdLZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105150078
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Comment inline:

> On May 11, 2021, at 3:47 PM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> A struct folio is a new abstraction to replace the venerable struct page.
> A function which takes a struct folio argument declares that it will
> operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
> In return, the caller guarantees that the pointer it is passing does
> not point to a tail page.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
> Documentation/core-api/mm-api.rst |  1 +
> include/linux/mm.h                | 74 +++++++++++++++++++++++++++++++
> include/linux/mm_types.h          | 60 +++++++++++++++++++++++++
> include/linux/page-flags.h        | 27 +++++++++++
> 4 files changed, 162 insertions(+)
>=20
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/m=
m-api.rst
> index a42f9baddfbf..2a94e6164f80 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -95,6 +95,7 @@ More Memory Management Functions
> .. kernel-doc:: mm/mempolicy.c
> .. kernel-doc:: include/linux/mm_types.h
>    :internal:
> +.. kernel-doc:: include/linux/page-flags.h
> .. kernel-doc:: include/linux/mm.h
>    :internal:
> .. kernel-doc:: include/linux/mmzone.h
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2327f99b121f..b29c86824e6b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -950,6 +950,20 @@ static inline unsigned int compound_order(struct pag=
e *page)
> 	return page[1].compound_order;
> }
>=20
> +/**
> + * folio_order - The allocation order of a folio.
> + * @folio: The folio.
> + *
> + * A folio is composed of 2^order pages.  See get_order() for the defini=
tion
> + * of order.
> + *
> + * Return: The order of the folio.
> + */
> +static inline unsigned int folio_order(struct folio *folio)
> +{
> +	return compound_order(&folio->page);
> +}
> +
> static inline bool hpage_pincount_available(struct page *page)
> {
> 	/*
> @@ -1595,6 +1609,65 @@ static inline void set_page_links(struct page *pag=
e, enum zone_type zone,
> #endif
> }
>=20
> +/**
> + * folio_nr_pages - The number of pages in the folio.
> + * @folio: The folio.
> + *
> + * Return: A number which is a power of two.
> + */
> +static inline unsigned long folio_nr_pages(struct folio *folio)
> +{
> +	return compound_nr(&folio->page);
> +}
> +
> +/**
> + * folio_next - Move to the next physical folio.
> + * @folio: The folio we're currently operating on.
> + *
> + * If you have physically contiguous memory which may span more than
> + * one folio (eg a &struct bio_vec), use this function to move from one
> + * folio to the next.  Do not use it if the memory is only virtually
> + * contiguous as the folios are almost certainly not adjacent to each
> + * other.  This is the folio equivalent to writing ``page++``.
> + *
> + * Context: We assume that the folios are refcounted and/or locked at a
> + * higher level and do not adjust the reference counts.
> + * Return: The next struct folio.
> + */
> +static inline struct folio *folio_next(struct folio *folio)
> +{
> +	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
> +}
> +
> +/**
> + * folio_shift - The number of bits covered by this folio.
> + * @folio: The folio.
> + *
> + * A folio contains a number of bytes which is a power-of-two in size.
> + * This function tells you which power-of-two the folio is.
> + *
> + * Context: The caller should have a reference on the folio to prevent
> + * it from being split.  It is not necessary for the folio to be locked.
> + * Return: The base-2 logarithm of the size of this folio.
> + */
> +static inline unsigned int folio_shift(struct folio *folio)
> +{
> +	return PAGE_SHIFT + folio_order(folio);
> +}
> +
> +/**
> + * folio_size - The number of bytes in a folio.
> + * @folio: The folio.
> + *
> + * Context: The caller should have a reference on the folio to prevent
> + * it from being split.  It is not necessary for the folio to be locked.
> + * Return: The number of bytes in this folio.
> + */
> +static inline size_t folio_size(struct folio *folio)
> +{
> +	return PAGE_SIZE << folio_order(folio);
> +}
> +
> /*
>  * Some inline functions in vmstat.h depend on page_zone()
>  */
> @@ -1699,6 +1772,7 @@ extern void pagefault_out_of_memory(void);
>=20
> #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1)=
)
> +#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(foli=
o) - 1))
>=20
> /*
>  * Flags passed to show_mem() and show_free_areas() to suppress output in
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5aacc1c10a45..3118ba8b5a4e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -224,6 +224,66 @@ struct page {
> #endif
> } _struct_page_alignment;
>=20
> +/**
> + * struct folio - Represents a contiguous set of bytes.
> + * @flags: Identical to the page flags.
> + * @lru: Least Recently Used list; tracks how recently this folio was us=
ed.
> + * @mapping: The file this page belongs to, or refers to the anon_vma fo=
r
> + *    anonymous pages.
> + * @index: Offset within the file, in units of pages.  For anonymous pag=
es,
> + *    this is the index from the beginning of the mmap.
> + * @private: Filesystem per-folio data (see folio_attach_private()).
> + *    Used for swp_entry_t if folio_swapcache().
> + * @_mapcount: Do not access this member directly.  Use folio_mapcount()=
 to
> + *    find out how many times this folio is mapped by userspace.
> + * @_refcount: Do not access this member directly.  Use folio_ref_count(=
)
> + *    to find how many references there are to this folio.
> + * @memcg_data: Memory Control Group data.
> + *
> + * A folio is a physically, virtually and logically contiguous set
> + * of bytes.  It is a power-of-two in size, and it is aligned to that
> + * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
> + * in the page cache, it is at a file offset which is a multiple of that
> + * power-of-two.  It may be mapped into userspace at an address which is
> + * at an arbitrary page offset, but its kernel virtual address is aligne=
d
> + * to its size.
> + */
> +struct folio {
> +	/* private: don't document the anon union */
> +	union {
> +		struct {
> +	/* public: */
> +			unsigned long flags;
> +			struct list_head lru;
> +			struct address_space *mapping;
> +			pgoff_t index;
> +			void *private;
> +			atomic_t _mapcount;
> +			atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +			unsigned long memcg_data;
> +#endif
> +	/* private: the union with struct page is transitional */
> +		};
> +		struct page page;
> +	};
> +};
> +
> +static_assert(sizeof(struct page) =3D=3D sizeof(struct folio));
> +#define FOLIO_MATCH(pg, fl)						\
> +	static_assert(offsetof(struct page, pg) =3D=3D offsetof(struct folio, f=
l))
> +FOLIO_MATCH(flags, flags);
> +FOLIO_MATCH(lru, lru);
> +FOLIO_MATCH(compound_head, lru);
> +FOLIO_MATCH(index, index);
> +FOLIO_MATCH(private, private);
> +FOLIO_MATCH(_mapcount, _mapcount);
> +FOLIO_MATCH(_refcount, _refcount);
> +#ifdef CONFIG_MEMCG
> +FOLIO_MATCH(memcg_data, memcg_data);
> +#endif
> +#undef FOLIO_MATCH
> +
> static inline atomic_t *compound_mapcount_ptr(struct page *page)
> {
> 	return &page[1].compound_mapcount;
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d8e26243db25..e069aa8b11b7 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -188,6 +188,33 @@ static inline unsigned long _compound_head(const str=
uct page *page)
>=20
> #define compound_head(page)	((typeof(page))_compound_head(page))
>=20
> +/**
> + * page_folio - Converts from page to folio.
> + * @p: The page.
> + *
> + * Every page is part of a folio.  This function cannot be called on a
> + * NULL pointer.
> + *
> + * Context: No reference, nor lock is required on @page.  If the caller
> + * does not hold a reference, this call may race with a folio split, so
> + * it should re-check the folio still contains this page after gaining
> + * a reference on the folio.
> + * Return: The folio which contains this page.
> + */
> +#define page_folio(p)		(_Generic((p),				\
> +	const struct page *:	(const struct folio *)_compound_head(p), \
> +	struct page *:		(struct folio *)_compound_head(p)))
> +
> +/**
> + * folio_page - Return a page from a folio.
> + * @folio: The folio.
> + * @n: The page number to return.
> + *
> + * @n is relative to the start of the folio.  It should be between
> + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.

Please add a statement noting WHY @n isn't checked since you state it
should be. Something like "...but this is not checked for because this is
a hot path."

> + */
> +#define folio_page(folio, n)	nth_page(&(folio)->page, n)
> +
> static __always_inline int PageTail(struct page *page)
> {
> 	return READ_ONCE(page->compound_head) & 1;
> --=20
> 2.30.2
>=20
>=20

Thanks,
    Bill=
