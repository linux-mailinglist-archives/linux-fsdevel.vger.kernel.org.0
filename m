Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A781F794395
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbjIFTKL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 6 Sep 2023 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjIFTKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:10:09 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98361E41
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 12:10:05 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58d41109351so17850327b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 12:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027404; x=1694632204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkX+J5EM5enh7df0o5MYGhhqFKI4D2hwIpC2ueReZ28=;
        b=jKmkRg8R0vaql9bFcW1cgrrKkB669UQlDgNxH0pH2psbImOUFVP1YAfqcEuPGxwywY
         R8PpnMLFV82Dl+hagcYY10kbNamzrUb0qAPc//vkWYIfERlnHxNq2RH9iFZCFEK81D4o
         No6HNV/IFRabJhKHVMkUSUjgOr3Xnf4RWct/M8b/HmXmid4EbNuFVkpYQ5VXJn9iS5b3
         MW5eHHUgQGnLiwWClY575l/rBOfZ/Qp0kvTBgeMrtghQXd6S0sQ/dAyjOc20GaYYU6Aa
         VI9JxML0NPqYPmDJ6Ka1Lkyr18UQnAy4i8n2UJvfDNA68f1xZgZyoL5G2ZPUGfkSR8bR
         vAYw==
X-Gm-Message-State: AOJu0YwXPJwcJq6L8lM18r+zinYBv6QdB6+i27RnkivjOjstpQOlMcR7
        Kg3V/yIneoDiWp8vC+8SAvZmjvAQhS+ymw==
X-Google-Smtp-Source: AGHT+IGqLwVHqdA0vvjn3e8xUt3MpiARo2xtGE/bewbQVeEOEfmUia3VKIiMDJaGqZT4D7OP/bd0cw==
X-Received: by 2002:a0d:dd94:0:b0:592:9b20:d551 with SMTP id g142-20020a0ddd94000000b005929b20d551mr638392ywe.0.1694027404598;
        Wed, 06 Sep 2023 12:10:04 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x67-20020a817c46000000b00583803487ccsm3902025ywc.122.2023.09.06.12.10.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 12:10:04 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7bae413275so1819668276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 12:10:04 -0700 (PDT)
X-Received: by 2002:a25:2601:0:b0:d71:6f6f:73da with SMTP id
 m1-20020a252601000000b00d716f6f73damr497667ybm.6.1694027404176; Wed, 06 Sep
 2023 12:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org> <ZPffYYnVMIkuCK9x@dread.disaster.area>
 <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
In-Reply-To: <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Sep 2023 21:09:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxigtcGS23Ppwc-Wh6hyiPPwbb4R_iZV56OnD46EdMjg@mail.gmail.com>
Message-ID: <CAMuHMdWxigtcGS23Ppwc-Wh6hyiPPwbb4R_iZV56OnD46EdMjg@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Wed, Sep 6, 2023 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
> util-linux has already implemented X-mount.auto-fstypes which we
> requested. For example, X-mount.auto-fstypes="ext4,xfs" accepts only
> ext4 and xfs, and X-mount.auto-fstypes="novfat,reiserfs" accepts all

I hope that should be achieved using "novfat,noreiserfs"?

And let's hope we don't get any future file system named no<something> ;-)

> filesystems except vfat and reiserfs.
>
> https://github.com/util-linux/util-linux/commit/1592425a0a1472db3168cd9247f001d7c5dd84b6
>
> IOW,
>         mount -t X-mount.auto-fstypes="ext4,xfs,btrfs,erofs" /dev/bla /mnt
> would only mount these for filesystems and refuse the rest.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
