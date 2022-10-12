Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF65FCA22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJLR6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJLR6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:58:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B02FC1CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 10:58:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f23so16946486plr.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuAk5hsnZSvAvw2wDCUvGvOXLRInHQhqvp0BW6poLwo=;
        b=UBiG7yHuvbThq5QxATiWf8UzkROoEQsIbKTWOgvr1cSEsFd375KUdPgARAjslccbNJ
         ArMmZ6FUehCeXjOYoYdMt01ZOVXN6/NmH+M4YoEMgUz0dm5hkTrv/+BotiKUAI+ttxbA
         rENVdmfne7MGbUXF96giy/btcYsvzPXQDYcy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuAk5hsnZSvAvw2wDCUvGvOXLRInHQhqvp0BW6poLwo=;
        b=UPMl5SD5IWx43mAFdEQMbKqwmuCjcOaHKQbEBtP/nCzASHjU/EiY3iCSDDVHtiPc1v
         ZjuNKsDV0ksqlDk+OG3iXWJR/BNiBu/7+hIsHk1oI2Du42V8vv3xGVn4pONdox4IJq1v
         1IqlxWDWY6rcMZvf+XpPiwUrA935r+apEZldX3IAz0Fi3euBFG577VjwhLQjGOfxpIPH
         o3m3dVDNCGeWI4kGH09ehk98aUv2Wq+Xhl6vaKJRBJtbSQQ4ILKo0XNZ8fYiH/XMqVxn
         NOZkZ2xCSzU61QK+ZuKI9lbpZiWnYpEbzhLz4LXwyRUy5P2RmSpWXkl6phv9UfqFAcRu
         736A==
X-Gm-Message-State: ACrzQf2XYUY7mZK4Zr28E67dQuRzhw1ZE/nmM1MrDtnYsv4FZPS8a73p
        x3xK3NGofhONCoD/2TTJvWKy3Q==
X-Google-Smtp-Source: AMsMyM6VWK/GmWFoY0YIGv8lIKLXnRH2iuzrFBw7I21YH03Ejw15cOU0bNxMOhtyjvn3yMX65x8nmA==
X-Received: by 2002:a17:902:bd45:b0:17f:6b19:bf6f with SMTP id b5-20020a170902bd4500b0017f6b19bf6fmr30613889plx.73.1665597526239;
        Wed, 12 Oct 2022 10:58:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902e14400b00183ba0fd54dsm3715572pla.262.2022.10.12.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:58:45 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:58:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 2/8] pstore: Expose kmsg_bytes as a module parameter
Message-ID: <202210120958.37D9621E8C@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-3-gpiccoli@igalia.com>
 <202210061628.76EAEB8@keescook>
 <267ccf8f-1fea-7648-ec2b-e7f4ae822ae4@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267ccf8f-1fea-7648-ec2b-e7f4ae822ae4@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 12, 2022 at 12:33:36PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:32, Kees Cook wrote:
> > [...]
> > Doing a mount will override the result, so I wonder if there should be
> > two variables, etc... not a concern for the normal use case.
> > 
> > Also, I've kind of wanted to get rid of a "default" for this and instead
> > use a value based on the compression vs record sizes, etc. But I didn't
> > explore it.
> > 
> 
> For some reason I forgot to respond that, sorry!
> 
> I didn't understand exactly how the mount would override things; I've
> done some tests:
> 
> (1) booted with the new kmsg_bytes module parameter set to 64k, and it
> was preserved across multiple mount/umount cycles.
> 
> (2) When I manually had "-o kmsg_bytes=16k" set during the mount
> operation, it worked as expected, setting the thing to 16k (and
> reflecting in the module parameter, as observed in /sys/modules).

What I was imagining was the next step:

(3) umount, unload the backend, load a new backend, and mount it
    without kmsg_bytes specified -- kmsg_bytes will be 16k, not 64k.

It's a pretty extreme corner-case, I realize. :) However, see below...

> In the end, if you think properly, what is the purpose of kmsg_bytes?
> Wouldn't make sense to just fill the record_size with the maximum amount
> of data it can handle? Of course there is the partitioning thing, but in
> the end kmsg_bytes seems a mechanism to _restrict_ the data collection,
> so maybe the default would be a value that means "save whatever you can
> handle" (maybe 0), and if the parameter/mount option is set, then pstore
> would restrict the saved size.

Right, kmsg_bytes is the maximum size to save from the console on a
crash. The design of the ram backend was to handle really small amounts
of persistent RAM -- if a single crash would eat all of it and possibly
wrap around, it could write over useful parts at the end (since it's
written from the end to the front). However, I think somewhere along
the way, stricter logic was added to the ram backend:

        /*
         * Explicitly only take the first part of any new crash.
         * If our buffer is larger than kmsg_bytes, this can never happen,
         * and if our buffer is smaller than kmsg_bytes, we don't want the
         * report split across multiple records.
         */
        if (record->part != 1)
                return -ENOSPC;

This limits it to just a single record.

However, this does _not_ exist for other backends, so they will see up
to kmsg_bytes-size dumps split across psinfo->bufsize many records. For
the backends, this record size is not always fixed:

- efi uses 1024, even though it allocates 4096 (as was pointed out earlier)
- zone uses kmsg_bytes
- acpi-erst uses some ACPI value from ACPI_ERST_GET_ERROR_LENGTH
- ppc-nvram uses the configured size of nvram partition

Honestly, it seems like the 64k default is huge, but I don't think it
should be "unlimited" given the behaviors of ppc-nvram, and acpi-erst.
For ram and efi, it's effectively unlimited because of the small bufsizes
(and the "only 1 record" logic in ram).

Existing documentation I can find online seem to imply making it smaller
(8000 bytes[1], 16000 bytes), but without justification. Even the "main"
documentation[2] doesn't mention it.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/pstore
[2] https://docs.kernel.org/admin-guide/ramoops.html

-- 
Kees Cook
