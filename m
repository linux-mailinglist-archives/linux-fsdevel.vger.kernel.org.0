Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86B6538E20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbiEaKAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiEaKAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266782170;
        Tue, 31 May 2022 03:00:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l19so7698191ejr.8;
        Tue, 31 May 2022 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9n4cw6tJMuGq8sS9FRBgBhCHODwjr6qBUbzPf/1V2sg=;
        b=IzX+BgNjUX84qtPBtVsu+ZQQ2nO4Huw6BvTBNd8rhiurCDNaaV5UMg4BXEj7C+GRmG
         pLAlNrJvCnrtY74d5Bo/qYvdZdIp6QkYn6H+D4DPT+ND58p4F/z8e2zkIZQsRYdjuNP2
         1DxX3EdJHY8KDTNcYKELGBk86yao2J8VuJlSo/c21/2arZjhHOW0lpAc7cG/anLi+GyZ
         EIYmtu/053mPuutoapsZROblF0FdT729/3v6UpunSQlMe0lkJeQVmj9gHa/cACRiumXh
         G4ykLDd0yxJynuBwQinr7e62C8Qnq4ExNeWx17W3s71BABDAerQSHOy+HAkfJOD712fC
         cGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9n4cw6tJMuGq8sS9FRBgBhCHODwjr6qBUbzPf/1V2sg=;
        b=veFHBMChSxPX/Sxx5ZdURFIquiS2Vac0Pqqg/b2YpH+vmb+CtPvKa9Xk7jf5pORaHh
         qoWXw576SBcVdoe6k1Tdyj7WYNG5XmqWkyi06pXjDewasGW38Fl3i/QB7aQAY7/dD+On
         /zZ6bgq82JRx4CHAiX+OjYKN9C5qZdDz1tdHXPgSTvXI9ZeuY7dnPTXfkuU5gwgC+3b9
         i7vKEawZAFcQqXKlkXDu9SilPQCPQpD1owxved299cf5PPc0NwDVrALaAS6n9gZpqcEi
         Z+x0SHM1psHOXqpWkvRUAJoHGggqgteItvChGxYPZ+T71mfPTvY/ecN5N8QHou160cE8
         GODw==
X-Gm-Message-State: AOAM533s5oQMEPgddujTAQ5KAbk1OJSykK2TNfqB8alImmtF+wohldBv
        CEOn8TCXT4KnG8fWb74ksmkdWysylPY=
X-Google-Smtp-Source: ABdhPJwCJfAmChYPGSG1MS5K/vbZUKtFI7ycuya8OGZo2oGfMsdkIctwKWtBLMWRNLTmB2Z1/mcwZQ==
X-Received: by 2002:a17:907:7d88:b0:6fe:d709:6735 with SMTP id oz8-20020a1709077d8800b006fed7096735mr38261002ejc.76.1653991210599;
        Tue, 31 May 2022 03:00:10 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:10 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: Per file OOM badness
Date:   Tue, 31 May 2022 11:59:54 +0200
Message-Id: <20220531100007.174649-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone, 

To summarize the issue I'm trying to address here: Processes can allocate
resources through a file descriptor without being held responsible for it.

Especially for the DRM graphics driver subsystem this is rather
problematic. Modern games tend to allocate huge amounts of system memory
through the DRM drivers to make it accessible to GPU rendering.

But even outside of the DRM subsystem this problem exists and it is
trivial to exploit. See the following simple example of
using memfd_create():

         fd = memfd_create("test", 0);
         while (1)
                 write(fd, page, 4096);

Compile this and you can bring down any standard desktop system within
seconds.

The background is that the OOM killer will kill every processes in the
system, but just not the one which holds the only reference to the memory
allocated by the memfd.

Those problems where brought up on the mailing list multiple times now
[1][2][3], but without any final conclusion how to address them. Since
file descriptors are considered shared the process can not directly held
accountable for allocations made through them. Additional to that file
descriptors can also easily move between processes as well.

So what this patch set does is to instead of trying to account the
allocated memory to a specific process it adds a callback to struct
file_operations which the OOM killer can use to query the specific OOM
badness of this file reference. This badness is then divided by the
file_count, so that every process using a shmem file, DMA-buf or DRM
driver will get it's equal amount of OOM badness.

Callbacks are then implemented for the two core users (memfd and DMA-buf)
as well as 72 DRM based graphics drivers.

The result is that the OOM killer can now much better judge if a process
is worth killing to free up memory. Resulting a quite a bit better system
stability in OOM situations, especially while running games.

The only other possibility I can see would be to change the accounting of
resources whenever references to the file structure change, but this would
mean quite some additional overhead for a rather common operation.

Additionally I think trying to limit device driver allocations using
cgroups is orthogonal to this effort. While cgroups is very useful, it
works on per process limits and tries to enforce a collaborative model on
memory management while the OOM killer enforces a competitive model.

Please comment and/or review, we have that problem flying around for years
now and are not at a point where we finally need to find a solution for
this.

Regards,
Christian.

[1] https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html
[2] https://lkml.org/lkml/2018/1/18/543
[3] https://lkml.org/lkml/2021/2/4/799


