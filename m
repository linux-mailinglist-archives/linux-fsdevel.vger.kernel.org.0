Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711A96F33C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjEAQzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjEAQzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:55:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88D1717
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:55:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24de504c5fcso2043092a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960110; x=1685552110;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgVoyGNNM2CEwgGlnNhwRO5zW+BCSfKlhykn/JkHIoY=;
        b=2YKjiLNW+kfuA2PzlgEprNmYD56U2DvqAYUQT3SxKi2Wkcms/FURL1MvVV4lKJqj8O
         6/Ns7jrOtbP8ic5/FVYS4laNGQMz7H1sQUQlCcm/XRw/h77Gbtg2COyXGd2xvroS0fJn
         qwWPXD+NTjhYN8F2PIhFlV9xM7/YRbLeL8oWUbHvCo0bmT2YG7Au7XFXE7JF9tMEE+O2
         Razpx64/yqsX3p0ZTAuL1qwvem7fqbeaFnGoyPVJo12mzY/mv/yC7mdLiyEupHVMtu6T
         xYmQq3px4UJy+E+76my+C+5ib12oMdQjlgTcOmFRh/w96xFVezYHyxkBpY3bPmKf/8tt
         YK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960110; x=1685552110;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tgVoyGNNM2CEwgGlnNhwRO5zW+BCSfKlhykn/JkHIoY=;
        b=TFiog0oR8l1m1T9AyxKv33GW8F/s10hrFX6/P2NgNk1noQBok5ATwJaLiO5jtF0Zd2
         z+H/9hH/tefbI7uDArsPo96qKwj06qVxCr6suq6wb6H3ut1qqLyFpm9efyxYPfLRi9J5
         oaMyVDleH9g/sBgtSy/ltGYRbLAKiOaOXyb+WbPS+kM92tg5qyhQKB7QCHWfrw9mWZzi
         ic2KoXp8NbDheBMnOtkV32CM2t8W+0C2F6Ay/WvYRMJ7i/iqfdp0RpnWjAniemsSscd2
         3uX8j3tyfCKimgSbfxM8r5DC1S8TD2kXAocGqZ+v2l1zQT/1a32hqRe4/rR/n2kgf7P1
         DkFQ==
X-Gm-Message-State: AC+VfDx/lmB4sbVtQXK9Rriu+FstMZE4yzTg28u3MsmiSupMi3vyMbBp
        yLZzfs4DCF/FJWJnRc0cW7/ePnkG1KU=
X-Google-Smtp-Source: ACHHUZ4eBSTFzzY/h621MY7B4DCDMh7rr4Q0GpDOy2/h5VKYZfljnAlN4rMUCg0PfIpVagexBlmQ2RgWd74=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:390d:b0:246:66d6:f24e with SMTP id
 y13-20020a17090a390d00b0024666d6f24emr3850182pjb.2.1682960109840; Mon, 01 May
 2023 09:55:09 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:11 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-2-surenb@google.com>
Subject: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=" <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

Previously, string_get_size() outputted a space between the number and
the units, i.e.
  9.88 MiB

This changes it to
  9.88MiB

which allows it to be parsed correctly by the 'sort -h' command.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/string_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..593b29fece32 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -126,8 +126,7 @@ void string_get_size(u64 size, u64 blk_size, const enum=
 string_size_units units,
 	else
 		unit =3D units_str[units][i];
=20
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	snprintf(buf, len, "%u%s%s", (u32)size, tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
=20
--=20
2.40.1.495.gc816e09b53d-goog

