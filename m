Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6D586BDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiHANXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiHANXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:23:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC953206A;
        Mon,  1 Aug 2022 06:23:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id id17so5783946wmb.1;
        Mon, 01 Aug 2022 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cBC0flO9jfjA5qWqGKr6imd7xX+89K8DOSR1Ng5E6g=;
        b=mn5VG6THHU82Ok48ra/iNVZ5cyfOsrQo722cV686eyjSnXNi6FOHrEQxawNhoa/DmA
         5jB5YDXONuCsPUNf2aX7WLzZfWquJNDs92urtqP0veBMW6ygiPKsgdSv8fYsQfm3swsK
         PbSjYsMsvCrLhefIUFU2gki7cxL55rw74Y9hXV+On/ZOcAz5FbLAWANamSOxz8zTZVK7
         0D9dHU9RPS0bNidV/h6HX0JbyXTjL7p3seFDYB+gWfcYhfh9eJf+jwbWi9YfwNDANun9
         81GxSsIMwJDiODdYA10p3SfIeE8TqDtdSuJfwl/XRMEv+WvdSCE1DrrK/YmQ6V7qzMCd
         AUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cBC0flO9jfjA5qWqGKr6imd7xX+89K8DOSR1Ng5E6g=;
        b=gviD99D8vnIYdZ/GM92ynjSodvPAnVjEDmIeJNxgrqmVyGhSJCKWbRlRX0UZLIPIEQ
         H6RUHJ0+QqYEg73U9Fj5XPkKZNHnXeNUpz56AZpV52ZkaRoPbjgP8dMgvLu5Z9cDQUxu
         X+5frud5J/IPugOjACcfjeHZnFZbo+sLe/86C/VO3vEJwLyKYvh8W1TnCYpdhhPdQNMh
         MnDm4xJaF2hQjgP0PmOPliwsbDjzgdxssImV7t+hoacIzL6+x2FjGThpzuLeecyu6JrE
         kZELHfonWiFiR3rJmMdh14XIuVAh2+ci+AiwVnR/COZ4kXBaAtDnVkzlUTNM15ee44hT
         gNBQ==
X-Gm-Message-State: AJIora93fy1rALkcTCnwBVJHJUhthGKkQ+b7P6qjsaREQhW6G54iJD5e
        F7IsENqNGwmN7PSFUbp5yuirRL97sjU=
X-Google-Smtp-Source: AGRyM1vuaPAnjAn81vbP4LlW1u2VXCfwuX+w5crZ20yfZaSj6Z8OuqTcwpUtLvyJWbGxc103+GAH0g==
X-Received: by 2002:a05:600c:6014:b0:3a3:7308:6a4b with SMTP id az20-20020a05600c601400b003a373086a4bmr11046599wmb.122.1659360225502;
        Mon, 01 Aug 2022 06:23:45 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id d7-20020a1c7307000000b003a3211112f8sm14582796wmb.46.2022.08.01.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:23:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bnode.c
Date:   Mon, 01 Aug 2022 15:23:41 +0200
Message-ID: <3688658.kQq0lBPeGt@opensuse>
In-Reply-To: <20220720154324.8272-1-fmdefrancesco@gmail.com>
References: <20220720154324.8272-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=C3=AC 20 luglio 2022 17:43:24 CEST Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> Two main problems with kmap(): (1) It comes with an overhead as mapping
> space is restricted and protected by a global lock for synchronization=20
and
> (2) it also requires global TLB invalidation when the kmap=E2=80=99s pool=
 wraps
> and it might block when the mapping space is fully utilized until a slot
> becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in bnode.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in bnode.c. Where
> possible, use the suited standard helpers (memzero_page(), memcpy_page())
> instead of open coding kmap_local_page() plus memset() or memcpy().
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/hfsplus/bnode.c | 105 +++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 57 deletions(-)

Please drop this patch because I'll send it again in a series of three, one=
=20
per file (bnode.c, bitmap.c, btree.c).

Unfortunately, while working at the last patch (btree.c), I just noticed=20
that I had missed one of the call sites of kmap() in bitmap.c.

Therefore, I'd prefer to send that again in a patchset and find a way to=20
test each of the three of them on a QEMU/KVM x86_32 VM, booting a kernel=20
with HIGHMEM64GB enabled.

Thanks,

=46abio



