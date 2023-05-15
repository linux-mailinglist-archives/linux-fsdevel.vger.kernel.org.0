Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C51702B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjEOLQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjEOLQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 07:16:27 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B74172B;
        Mon, 15 May 2023 04:16:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba7831cc80bso346576276.0;
        Mon, 15 May 2023 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684149386; x=1686741386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTbXuYdaoyxAlzcRp/fw5Y/X7Jv1gcBGl293JJcjEdw=;
        b=rHvms3r0j62HT8lJLCgjCOTVIvfLAuQQowXP8AlPbnL6ZdyWDLMK5IwWZH9as9mBWi
         pq0PzbvF/mx+rD6DVkQk3fjS477v0OxylXei5cwqQcrzF8gRJiH0GlT4Oox8bYu4GLrB
         N3+IOgs3o+BqCPUHE9+VAav5BHIGiuKOk3gVX3b1Sfk0yf1BB2u6uiqw2mcyKGd/x1gf
         xmnyc09sWRSVZoXzSO30cCgzd3imc9NVHznBTuiVFfgJiA12Uh9fMx/gmMffJxzsyDUO
         RcNyG5WSoSePuBrPVRq1oc/kE2nN0ByBIfb7qGJnsOvLNqlRgyzQnmZCDAkx4wu8gR6a
         6F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684149386; x=1686741386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTbXuYdaoyxAlzcRp/fw5Y/X7Jv1gcBGl293JJcjEdw=;
        b=kWDSnbAcyt3iri41976YRRISaim0kKezz0lm012bIeNvZfN5WuMYUi5qSqgG6y0Vlf
         czQ/1OjlVmUgJoLOczP3CZpH66/sliGFdLSpZYZlbf/r0ANFzpPubtRXo60AUQ9rYOci
         6GMGd0DuI34q3AAm4E7gb3tCNjONUNG+2PyFHA7J0BGSM1z/+RFHMBok+73Ybpm7Yont
         Zf4BO9GXwF3lmw/G6QKw9hxrRQVweC0DKzIIb/PnQiOTGXSGGRDE0f9YBmPEhXgQt+2Y
         FCQ3m2bYbsGliabGHsFXijE25zkrhLxEOigUZtIWXZlk+dPTQyUsVIcpoYALv+sqv2xj
         nLCw==
X-Gm-Message-State: AC+VfDxH6NsCAolASxyKCaBzgLQinQeltuIBqc2UudF6tndableCc7pe
        ZIOjRBk92wXtxnYPjlDDRsjsLy9ivPlBvP8empY=
X-Google-Smtp-Source: ACHHUZ7QVbn3hySRl+aLqYhn67ydlgatwvX69Pf1I7JU8ZGH/GA9QBvjTHpIba8iZ14uKS84WLqgoGh2gvTDtVFk6K0=
X-Received: by 2002:a81:1b4e:0:b0:55a:1cdc:2ed3 with SMTP id
 b75-20020a811b4e000000b0055a1cdc2ed3mr19282070ywb.2.1684149385714; Mon, 15
 May 2023 04:16:25 -0700 (PDT)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Mon, 15 May 2023 14:15:48 +0300
Message-ID: <CAPnZJGB5izL9LzLVFHOGt5rNg+V0ZvVghebXS41U7HiGwXoEUg@mail.gmail.com>
Subject: Re: [PATCH 00/32] bcachefs - a new COW filesystem
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kent, please, make sure you dealt with problems specific to another
fs: btrfs: https://arstechnica.com/gadgets/2021/09/examining-btrfs-linuxs-p=
erpetually-half-finished-filesystem/
. In particular, I dislike this btrfs problems, mentioned in the
article:

- "Yes, you read that correctly=E2=80=94you mount the array using the name =
of
any given disk in the array. No, it doesn't matter which one"
- "Even though our array is technically "redundant," it refuses to
mount with /dev/vdc missing... In the worst-case scenario=E2=80=94a root
filesystem that itself is stored "redundantly" on btrfs-raid1 or
btrfs-raid10=E2=80=94the entire system refuses to boot... If you're thinkin=
g,
"Well, the obvious step here is just to always mount degraded," the
btrfs devs would like to have a word with you... If you lose a drive
from a conventional RAID array, or an mdraid array, or a ZFS zpool,
that array keeps on trucking without needing any special flags to
mount it. If you then add the failed drive back to the array, your
RAID manager will similarly automatically begin "resilvering" or
"rebuilding" the array... That, unfortunately, is not the case with
btrfs-native RAID"

I suggest reading the article in full, at least from section "Btrfs
RAID array management is a mess" till the end.

Please, ensure that bcachefs has no these problems! These problems
scary me away from btrfs.

Please, CC me when answering
--=20
Askar Safin
