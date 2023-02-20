Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518969D1CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjBTRCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 12:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTRCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:02:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B61ADDD;
        Mon, 20 Feb 2023 09:02:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eg37so3418268edb.12;
        Mon, 20 Feb 2023 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIXPG9Tfia4VG3SCp8cf3t2f7Ns1NurWtREmNjjn+9Q=;
        b=C2SRfLt8/RtKLfxN9ed/Yko3i3/BJMM4vVATAtuhwyK0ueyAendsJqzyAX5KOt2/LL
         qjR4KKiuom9zDVnLSnv39XdEyMH6SXKzOI+wp/5hBQQ/9YXzpIYQjQPfWWz8KapeLsNr
         PBn/Mmv/Z6BzyICL8uBRAjUwgn0U8p6ZLdiVJAxcLJCCqw55PuGexKuRkO1DsMZPh3u7
         od5ejshwMzos7R2vnVrflCdTPtODz3+8sPYz8DTYzFIqCP4PalH+XCkxVyvWoJBE0Hxa
         cr24BnjI6+bspeMh/XYcpwOCbgR4Vd/hqeOmOv5MzRHQ3b0mWbXi39EhpATQ0AEXk5bs
         0PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIXPG9Tfia4VG3SCp8cf3t2f7Ns1NurWtREmNjjn+9Q=;
        b=nFPnodlmh03HXF9DDIeLqZx09GBy0xmaPPZPCK8kRJIT+8uTxn3Sm/3Ex23bDKPzFy
         JBB2QLz13lnP3/J/B6zMpMvVdBNv34UrdXxxyhM/+NVyKIJqxvmm5k91oMtGRQXvYnFg
         WTVc7jPdD3zb01YWyEFqkE4wVLGHFnoOFARoMXSz3JJfHPAL3kgj4Gez6invZcZC6HpN
         PuDlzNmTU+yK6fFVNrIQJ2+ixngD/QWrRd6ADmI3cRgotf+jPRChajdBYojU1FDVduxC
         nDoVa3wt6xiXxcAaJOVDDdrWCXFJ4o5ZQPQP1wlrlMoUnG0HOEtakXJ8cWqZu5bxMjCG
         G9rw==
X-Gm-Message-State: AO0yUKXcbFemTWBZ0NkSjF/Ybz/iBpNU7PVRJCVsW8a45byTKpzXbS5i
        lYr7tBcmBQ2atNms0ScuBqc=
X-Google-Smtp-Source: AK7set9d9gEgqwgD/HzdEscSoraXTox2l1B0ZTaStLBNjd3Ol0z73ed8pSdEQ1amJLzNrqdmgl2r1A==
X-Received: by 2002:a05:6402:26cf:b0:4ab:7f0:1865 with SMTP id x15-20020a05640226cf00b004ab07f01865mr945848edd.5.1676912532385;
        Mon, 20 Feb 2023 09:02:12 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:ad0f:1d29:d8a4:7999])
        by smtp.gmail.com with ESMTPSA id h10-20020a50c38a000000b004ad75c5c0fdsm927227edf.18.2023.02.20.09.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:02:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Anders Larsen <al@alarsen.net>,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] Minor documentation clean-up in fs
Date:   Mon, 20 Feb 2023 18:02:08 +0100
Message-Id: <20230220170210.15677-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Jonathan,

please pick this minor documentation clean-up in fs. It is not in the
Documentation directory, but I would consider these README files also
some unsorted largely distributed kernel documentation.

Here is some trivial and probably little-to-debate clean up.
 
Lukas Bulwahn (2):
  qnx6: credit contributor and mark filesystem orphan
  qnx4: credit contributors in CREDITS

 CREDITS        | 16 ++++++++++++++++
 MAINTAINERS    |  6 ++++++
 fs/qnx4/README |  9 ---------
 fs/qnx6/README |  8 --------
 4 files changed, 22 insertions(+), 17 deletions(-)
 delete mode 100644 fs/qnx4/README
 delete mode 100644 fs/qnx6/README

-- 
2.17.1

