Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1E6CA102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjC0KNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjC0KNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:13:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB06C1;
        Mon, 27 Mar 2023 03:13:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p34so4705710wms.3;
        Mon, 27 Mar 2023 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679911990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59tA2lCnliRvQCtKSZm7EmR6QrSpBlAsOZLbQEqcLPI=;
        b=BrWg7aw+Awtki2c0xRG2ewC1alYtCx/pT1kjf6sk3heQGvoWLEwubOi09TCbNZmlud
         tDZEzXQOmyhGGBwDLLMtQaA3TFwfRDMTZhtWme1IzfOCf01ybA0rKvEshjt4ToqZZAky
         QHPuu4VIvjk2WA0TJkDDZzgC35QuerjpKMOvL7UKuinwM9PCEYL/3LOSStS9c+DRIB2c
         +s5BdQB0FBfonPrM8RMASE5nuTxYSaarbcUJWY8QkUjaxbvUnsKYMM9dI8LKhqbRGpqq
         5jxL9NDpKc5P7o3hr4ae0HlVGMQxhPhgNZBEfkg2M00nNeBQnAR8db5nw8+fmxKXaLY3
         B+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59tA2lCnliRvQCtKSZm7EmR6QrSpBlAsOZLbQEqcLPI=;
        b=naZaffRl1kBabtGKCOmXrwGNL/N9np03BG1tNv3IPmXLWCPKscEoqMMfAgGoyW2v+G
         Z9/37wHMFMYDu7y0a5AFVo6uwewYbS8Vi2WXd9/dJJ1GoJlx14JAljZrgG3TAi0s3GOF
         /JEh7QWrEC8MZQ8xPOu8eIQ8GFjvF9VTCGTfkFpN7kXubkSnRIeI7apDs1dY3hKRMDhb
         igxckX5giqmv7OyN8we7mIwbxevA7vJ5TOcHGaWfsFo1VJbshslYjntMnJUhVEm7/gpy
         S3rd5JHsEW/owoG7Z5OLe9PokplKvzAs7tl8iRnBqxkHnpQQlTMa3jdfoNuE6E8mS+xh
         PrGg==
X-Gm-Message-State: AO0yUKXMZB92R2krX2I+N4DXhnHlpZ7YLaAtdZ9q4hNuEcFFrRMQWr6L
        ChyJz62PNeZEc6KqQiUU1oE=
X-Google-Smtp-Source: AK7set+bVHe7/hUAi2tiQsz/edpntTs8WNPcsTWmy0dO5OdEOWbwFoLcz9zWHfUpADOBZILauD9d1Q==
X-Received: by 2002:a7b:c5c1:0:b0:3ee:5bd8:d537 with SMTP id n1-20020a7bc5c1000000b003ee5bd8d537mr8837744wmk.5.1679911990061;
        Mon, 27 Mar 2023 03:13:10 -0700 (PDT)
Received: from suse.localnet (host-87-19-99-235.retail.telecomitalia.it. [87.19.99.235])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b003ede2c4701dsm8317814wms.14.2023.03.27.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:13:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] fs/ufs: Replace kmap() with kmap_local_page
Date:   Mon, 27 Mar 2023 12:13:08 +0200
Message-ID: <11383508.F0gNSz5aLb@suse>
In-Reply-To: <20221229225100.22141-1-fmdefrancesco@gmail.com>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=C3=AC 29 dicembre 2022 23:50:56 CEST Fabio M. De Francesco wrote:
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

Hi Al,

I see that this series is here since Dec 29, 2022.
Is there anything that prevents its merging?=20
Can you please its four patches in your tree?

Thanks,

=46abio

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
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
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
> Changes from v3:
> 	1/3: No changes.
> 	2/3: No changes.
> 	3/3: Replace kunmap() with kunmap_local().
>=20
> Changes from v4:
> 	1/4: It was 1/3.
> 	2/4: Move the declaration of a page into an inner loop. Add Ira
> 	     Weiny's "Reviewed-by" tag (thanks!).
> 	3/4: Add this patch to use ufs_put_page() to replace three kunmap()
> 	     and put_page() in namei.c. Thanks to Ira Weiny who noticed that
> 	     I had overlooked their presence.
> 	4/4: Remove an unnecessary masking that is already carried out by
> 	     kunmap_local() via kunmap_local_indexed(). Add a comment to
> 	     clarify that a ufs_dir_entry passed to ufs_delete_entry()
> 	     points in the same page we need the address of. Suggested by
> 	     Ira Weiny.
>=20
> [1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/#t
> [2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/#t
> [3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/#t
> [4] https://lore.kernel.org/lkml/Y5Zc0qZ3+zsI74OZ@ZenIV/#t
> [5] https://lore.kernel.org/lkml/Y5ZZy23FFAnQDR3C@ZenIV/#t
> [6] https://lore.kernel.org/lkml/Y5ZcMPzPG9h6C9eh@ZenIV/#t
> [7] https://lore.kernel.org/lkml/Y5glgpD7fFifC4Fi@ZenIV/#t
>=20
> The cover letter of the v1 series is at
> https://lore.kernel.org/lkml/20221211213111.30085-1-fmdefrancesco@gmail.c=
om/
> The cover letter of the v2 series is at
> https://lore.kernel.org/lkml/20221212231906.19424-1-fmdefrancesco@gmail.c=
om/
> The cover letter of the v3 series is at
> https://lore.kernel.org/lkml/20221217184749.968-1-fmdefrancesco@gmail.com/
> The cover letter of the v4 series is at
> https://lore.kernel.org/lkml/20221221172802.18743-1-fmdefrancesco@gmail.c=
om/
>=20
> Fabio M. De Francesco (4):
>   fs/ufs: Use the offset_in_page() helper
>   fs/ufs: Change the signature of ufs_get_page()
>   fs/ufs: Use ufs_put_page() in ufs_rename()
>   fs/ufs: Replace kmap() with kmap_local_page()
>=20
>  fs/ufs/dir.c   | 131 +++++++++++++++++++++++++++----------------------
>  fs/ufs/namei.c |  11 ++---
>  fs/ufs/ufs.h   |   1 +
>  3 files changed, 78 insertions(+), 65 deletions(-)
>=20
> --
> 2.39.0




