Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF91F6AAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgFKPPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 11:15:00 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51079 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728425AbgFKPPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:15:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DA2D35BE;
        Thu, 11 Jun 2020 11:14:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 11:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=mbP/c7Zh+UG74gGWVl4xZP+lch
        svxpJUzk1CyV5rpiQ=; b=aIOyG6+xRhaXc+6OLxLr0zFCxu4sHFoVRL44HrfOdZ
        oQel5q1HJ46JviW+2qpaLqE4mXAd3Vq4FUSxc0Vdo120xjUabDi/85UeTbuR2Ox8
        UX2CqHiT5mFhRY4fnw0ZhwGFjWmc/d7GH/JP/ICuQ9rlxi3mx2Xi37heE8x1UNKb
        c8js0e+Yu1mLZ8QmRlH42T6/4AnitbOpiJ4vXnNgZRbTXVUwUAUOZ+kU6/2LXTck
        yriMzz+vmY9EmLpxrXExa9nWi8xp/LEgdplRRgXoGuvH2HKKUMOmwsRCtRz9xVfm
        /3kzQ/tPT/2cfzWZBW97cYb/5o0BNrrXOJZy9f+P9K9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mbP/c7
        Zh+UG74gGWVl4xZP+lchsvxpJUzk1CyV5rpiQ=; b=otW+a/3M7nDknV3NODCwU3
        1TE/MSk1Yhg6PXG9/aDRX3mpIqmlFOJWIptxLI7OuJMbcpOKhsBUcOgzDyhasgDI
        v4s3Mz9XuEs+ZUEAhCGyUUeHoqrB3jBSsyT1bYBL2VMpMMex5NLaJqhxBAFrzMSA
        URInPJEQqeovjJbzI32v42znIGEqpMS+c8XSSpgq1/2b+wK+D/K8ztKTQAcE3vLZ
        SLIYkK0HOedMYsphWO7teZvGPBTqGu9a58jhqam9g1rWMG7T21ygRwzZ9FbIwP7P
        Ea0APpmVKCMKwg8VHc6VsYjM3OLTwwQtRpI9rJV75cWHKj4Fyxi0maWgMCT1QsUA
        ==
X-ME-Sender: <xms:ckriXkPXy4pV0pCSKYlDnKtCdcAfdXNQ6DnIrLJ5C8iEeyl87xoQrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgesghdtmh
    erredtjeenucfhrhhomhepfdgkihcujggrnhdfuceoiihirdihrghnsehsvghnthdrtgho
    mheqnecuggftrfgrthhtvghrnhepjeeujeetjeffgeelvdfhveekiedvgeffhfegfeektd
    eigedvveejfedvhedutddunecukfhppeejhedrieejrdelrddutdefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:ckriXq_16g94uu606hp94eN4VZUUG_KpxLZ7QMeZDHL9KEPBw0C35Q>
    <xmx:ckriXrQteha7jvpTcnlO0bKHv0WYF_3zEMC7O0eQ2ENbIyxF9HuQ1Q>
    <xmx:ckriXsuZ6NX_DfKtCsvf5X-dnEjFK6kyzYAr_afdD_mAjTgOrkhupw>
    <xmx:ckriXoHzLnX8xmrhnQS42iWdz4SZzcapPNr4NNFbSf9-0_u8VON7qA>
Received: from [10.2.166.236] (c-75-67-9-103.hsd1.ma.comcast.net [75.67.9.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFFFB3060FE7;
        Thu, 11 Jun 2020 11:14:57 -0400 (EDT)
From:   "Zi Yan" <zi.yan@sent.com>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/51] mm: Simplify PageDoubleMap with PF_SECOND policy
Date:   Thu, 11 Jun 2020 11:14:45 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <A8271172-074D-43E2-928B-EE267544EA82@sent.com>
In-Reply-To: <20200610201345.13273-6-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200610201345.13273-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_44D74A30-D1A2-4272-80E2-5EF81B020730_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_44D74A30-D1A2-4272-80E2-5EF81B020730_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Jun 2020, at 16:12, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Introduce the new page policy of PF_SECOND which lets us use the
> normal pageflags generation machinery to create the various DoubleMap
> manipulation functions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/page-flags.h | 40 ++++++++++----------------------------=

>  1 file changed, 10 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index de6e0696f55c..979460df4768 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -232,6 +232,9 @@ static inline void page_init_poison(struct page *pa=
ge, size_t size)
>   *
>   * PF_NO_COMPOUND:
>   *     the page flag is not relevant for compound pages.
> + *
> + * PF_SECOND:
> + *     the page flag is stored in the first tail page.
>   */

Would PF_FIRST_TAIL or PF_SECOND_IN_COMPOUND be more informative?

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_44D74A30-D1A2-4272-80E2-5EF81B020730_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFEBAEBCgAuFiEEOXBxLIohamfZUwd5QYsvEZxOpswFAl7iSmUQHHppLnlhbkBz
ZW50LmNvbQAKCRBBiy8RnE6mzBAhB/9RPEgOo5xCLbS1n7upmOU40BpKZaxVUeBX
+VGnxbPtM9Pi78CkZew1B0gDa4TGam+kx2HfVhkL038T7U+OhXHZgTZlL95JR0sJ
jco0EPXsRJAcWVt/h8KH70OQhNyL7go5Wj+Glb4mM2ceUvfUN6ldDbL4uLqpoigi
RKqMiwaqqPQ5fjh9LRNQJ0HW7BCUtsUp3TvgYSYoTPN57W8ojcAqnCfanRgvtD4J
33KYQWAidnv7L3ZtLi7ZIHbKgCV9+aAlFscQ8UcNwHtcwPA8yJEx8+a1E7iw/F8F
pzU9hhi5z/5WkeOdbowIr+036mLPNUeulu643uUxVJp3XyN15WlH
=ZXg8
-----END PGP SIGNATURE-----

--=_MailMate_44D74A30-D1A2-4272-80E2-5EF81B020730_=--
