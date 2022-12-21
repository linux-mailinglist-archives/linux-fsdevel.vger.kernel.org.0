Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBA65358F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiLURq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiLURqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:46:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A36248CC;
        Wed, 21 Dec 2022 09:46:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay40so11710689wmb.2;
        Wed, 21 Dec 2022 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHIXXwq9GJR7IiFG9cjxzmXoHq5/NyIi/MmowMoFcIc=;
        b=Q3il+E9JxPydcRRSIEYGlKCJFFDsiK3zzFnsbAdvhYNR/KpCtELuzqdA7jVccs6C9I
         otUMu3sAxuG8E6MtMJ1/iMWQvgkUHEvWxYZEWvFgWf7USbCI8DY6iPXdIeWlwpwEwTQ6
         WV31VMHA41pxlq8D7cwArZYmsHITj2Z0IrrRP/5l0va08eFiqGO5iWtOpepJHw3cPc93
         QSZc4qLngM0EaT0lfhpDUwM4tzxj2C6iG4NeDwFlkXY2PicAPAjxlNpkUNSUEdDm6bh1
         rw90SQ/uzwr3l2tiLDtjbjVlZ8rPKD0Md33ocncx5KGVOGafHIHvIr1ndJ9H+PXlRyB6
         UEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHIXXwq9GJR7IiFG9cjxzmXoHq5/NyIi/MmowMoFcIc=;
        b=TliDfTsHBg9KwQQYU3mDnbZO1nCggLJyX/YncaaxEh8yq5i9rtYI4VcSA+W4r4HXei
         S5LuQ2n4Hd+7Ne50a+hwGPOqxhKajBs1gud7SMMoQ5r2UxzXCZzAzNX9Qxj+gMKkklLD
         bRp7j94yr5IVvHkNrDm5hY+hLyT/QdP9dmG/cs1j74IxY6xJlJcKjVvOw8umW20xZrSS
         ltv78ZdAMaRa2RJpJHiBX1DowB1ij2yxEOGEaGypOZjsuk8jFxZWyTJytZmFRJZloGu/
         oJuq9xUG3WW+AEE2Rfjd5+fA+wn+P5638/r3GF/V/532fUuT79Tl7mK2fjW5b73niZPP
         T+JQ==
X-Gm-Message-State: AFqh2kr+oGFWUUL+nlkGRn7kT6mkAnixGOMuvyGlf5vitblD7c2OJLl6
        e+koqm4iUaWF59S+sdW1w9FdijuOUus=
X-Google-Smtp-Source: AMrXdXu6KDdHibCmU5lDSLlWDNrxrQL2aMBrcIzCBvN0PY4oDdHKxhQd0k156KwfMY5n3txxFN/Wug==
X-Received: by 2002:a05:600c:3b02:b0:3c7:18:b339 with SMTP id m2-20020a05600c3b0200b003c70018b339mr2624237wms.37.1671644770167;
        Wed, 21 Dec 2022 09:46:10 -0800 (PST)
Received: from suse.localnet (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id k39-20020a05600c1ca700b003a84375d0d1sm3333452wms.44.2022.12.21.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:46:09 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] fs/ufs: replace kmap() with kmap_local_page
Date:   Wed, 21 Dec 2022 18:46:08 +0100
Message-ID: <8213044.NyiUUSuA9g@suse>
In-Reply-To: <20221217184749.968-1-fmdefrancesco@gmail.com>
References: <20221217184749.968-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On sabato 17 dicembre 2022 19:47:46 CET Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in fs/ufs is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> requires the mapping address, so return that address from ufs_get_page()
> to be used in ufs_put_page().
>=20
> This series could have not been ever made because nothing prevented the
> previous patch from working properly but Al Viro made a long series of
> very appreciated comments about how many unnecessary and redundant lines
> of code I could have removed. He could see things I was entirely unable
> to notice. Furthermore, he also provided solutions and details about how
> I could decompose a single patch into a small series of three
> independent units.[1][2][3]
>=20
> I want to thank him so much for the patience, kindness and the time he
> decided to spend to provide those analysis and write three messages full
> of interesting insights.[1][2][3]
>=20
> Changes from v1:
> 	1/3: No changes.
> 	2/3: Restore the return of "err" that was mistakenly deleted
> 	     together with the removal of the "out" label in
> 	     ufs_add_link(). Thanks to Al Viro.[4]
> 	     Return the address of the kmap()'ed page instead of a
> 	     pointer to a pointer to the mapped page; a page_address()
> 	     had been overlooked in ufs_get_page(). Thanks to Al
> 	     Viro.[5]
> 	3/3: Return the kernel virtual address got from the call to
> 	     kmap_local_page() after conversion from kmap(). Again
> 	     thanks to Al Viro.[6]
>=20
> Changes from v2:
> 	1/3: No changes.
> 	2/3: Rework ufs_get_page() because the previous version had two
> 	     errors: (1) It could return an invalid pages with the out
> 	     argument "page" and (2) it could return "page_address(page)"
> 	     also in cases where read_mapping_page() returned an error
> 	     and the page is never kmap()'ed. Thanks to Al Viro.[7]
> 	3/3: Rework ufs_get_page() after conversion to
> 	     kmap_local_page(), in accordance to the last changes in 2/3.
>=20
> [1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/
> [2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/
> [3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/
> [4] https://lore.kernel.org/lkml/Y5Zc0qZ3+zsI74OZ@ZenIV/
> [5] https://lore.kernel.org/lkml/Y5ZZy23FFAnQDR3C@ZenIV/
> [6] https://lore.kernel.org/lkml/Y5ZcMPzPG9h6C9eh@ZenIV/
> [7] https://lore.kernel.org/lkml/Y5glgpD7fFifC4Fi@ZenIV/#t
>=20
> The cover letter of the v1 series is at
> https://lore.kernel.org/lkml/20221211213111.30085-1-fmdefrancesco@gmail.c=
om/
> The cover letter of the v2 series is at
> https://lore.kernel.org/lkml/20221212231906.19424-1-fmdefrancesco@gmail.c=
om/
>=20
> Fabio M. De Francesco (3):
>   fs/ufs: Use the offset_in_page() helper
>   fs/ufs: Change the signature of ufs_get_page()
>   fs/ufs: Replace kmap() with kmap_local_page()
>=20
>  fs/ufs/dir.c | 134 +++++++++++++++++++++++++++------------------------
>  1 file changed, 71 insertions(+), 63 deletions(-)
>=20
> --
> 2.39.0

Please drop this v3 because of a mistake in patch 3/3.
The updated v4 series is at=20
https://lore.kernel.org/lkml/20221221172802.18743-1-fmdefrancesco@gmail.com=
/T/

Thanks,

=46abio





