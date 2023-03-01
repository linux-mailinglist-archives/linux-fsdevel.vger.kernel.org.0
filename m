Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4A6A71B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCARAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 12:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCARAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:00:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1DE410BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 09:00:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a2so4240181plm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ovbh2Ow5Lqvqr3WKhiVlyFb7KfbpfT0ZYOesBpWl4m0=;
        b=grUVyn7vzAz6c1+XejF+kJiBzdOK0iJNKed1S2cKdkfJCnVvMx5PYO3477OAh9GG1p
         Uo4hou31ELVeGMvd3+Cf71UAWMeqctc04MFqZFOZbaKpmmkgcT6u8ZFCz2jRqHxzcP0M
         M16hBzzWnP9PSVqm/0E0+SppJsdbKvhuExH/f9a4K0pLKg+VzgZ72gSpG4CYzieO8rdw
         jyXc2SOmYfTUqTQq1ffqygpKAhAjtw5K+krUESvTPagUilWbuNXBgIhyWWsnESUCQhof
         sO2yGRbKweMc9eLkuWzwsgf/Z3xeG92CeHVAR/Af0hQqtE1xEZjhpkvSrf5kOHdbpfzp
         +xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovbh2Ow5Lqvqr3WKhiVlyFb7KfbpfT0ZYOesBpWl4m0=;
        b=kym4wvB8mD4zkLGP/hWyAAwS/QTOrBaKqXkPqGXiyJdgfYBzSorhQMOhJ7QtnivhMz
         2Lu0Tqyn3Ju2GfNZlmJBmZvJ14Z6amRI9SVB6pG2/PXgAREIR3P9g5Xbl2w9X1gUS3uD
         gmgUxlTOxLWlWFkW2hdRT0fHnBCTiTO1SZ+yFstI7+mj3jYxjGvxU7qnen8oNJJnsZQp
         NmtATe9wHJWKQtEjGO0GPqwux+ya9D++0e71genN1KnnAeI0R5bU6C8wz8R24LuTnsOz
         UKxPfA4N59PUyghuYHarfGcN51l4LTTv8bJ02m75Xob+16R/YAqUe7rcK15A0gnpyKyZ
         Ye/Q==
X-Gm-Message-State: AO0yUKVChc6y1JImm2PfW3znFr54E6efzg5GDvMamJtzDRzr77lKiMH7
        urdrFKIXxwI1FdqN3gh6JrU=
X-Google-Smtp-Source: AK7set+2QlRkKoWmVdH6Tezjq9aeyQJTb4v8/cm93NNNaOJPD6EOXrRft986vyW+HvhURZQ4z6QbYw==
X-Received: by 2002:a17:90b:4c4c:b0:233:e305:f617 with SMTP id np12-20020a17090b4c4c00b00233e305f617mr8188672pjb.32.1677690012757;
        Wed, 01 Mar 2023 09:00:12 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id s17-20020a639251000000b00502ecb91940sm7671585pgn.55.2023.03.01.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:00:12 -0800 (PST)
Date:   Wed, 01 Mar 2023 22:29:56 +0530
Message-Id: <87wn40mmpf.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
In-Reply-To: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> One of the recurring themes that comes up at LSF is "iomap has little
> to no documentation, it is hard to use". I've only recently taken a
> little nose dive into it, and so I also can frankly admit to say I don't
> grok it well either yet. However, the *general* motivation and value is clear:
> avoiding the old ugly monster of struct buffer_head, and abstracting
> the page cache for non network filesystems, and that is because for
> network filesystems my understanding is that we have another side effort
> for that. We could go a bit down memory lane on prior attempts to kill
> the struct buffer_head evil demon from Linux, or why its evil, but I'm not
> sure if recapping that is useful at this point in time, let me know, I could
> do that if it helps if folks want to talk about this at LSF. For now I rather

It would certainly help to hear on what are our plans of
IOMAP_F_BUFFER_HEAD flag and it's related code. I know it is there
for gfs2, but it would be good to know on what are our plans before we
start converting all other filesystems to move to iomap?
Do we advise on not to use this path for other filesystems? Do we plan
to deprecate it in order to kill buffer heads in future?
e.g.
root> git grep "buffer_head" fs/iomap/
fs/iomap/buffered-io.c:#include <linux/buffer_head.h>

Wanted more insights on this and our plans w.r.t other filesystem
wanting to use it. So a short walk down the memory lane and our plans
for future w.r.t IOMAP_F_BUFFER_HEAD would certainly help.

Thanks
-ritesh
