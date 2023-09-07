Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970B2796EB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjIGBxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjIGBxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:53:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482AE73
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 18:53:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18CC433C8;
        Thu,  7 Sep 2023 01:53:15 +0000 (UTC)
Date:   Wed, 6 Sep 2023 21:53:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230906215327.18a45c89@gandalf.local.home>
In-Reply-To: <ZPkDLp0jyteubQhh@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
        <ZPkDLp0jyteubQhh@dread.disaster.area>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Sep 2023 08:54:38 +1000
Dave Chinner <david@fromorbit.com> wrote:

> And let's not forget: removing a filesystem from the kernel is not
> removing end user support for extracting data from old filesystems.
> We have VMs for that - we can run pretty much any kernel ever built
> inside a VM, so users that need to extract data from a really old
> filesystem we no longer support in a modern kernel can simply boot
> up an old distro that did support it and extract the data that way.

Of course there's the case of trying to recreate a OS that can run on a
very old kernel. Just building an old kernel is difficult today because
today's compilers will refuse to build them (I've hit issues in bisections
because of that!)

You could argue that you could just install an old OS into the VM, but that
too requires access to that old OS.

Anyway, what about just having read-only be the minimum for supporting a
file system? We can say "sorry, due to no one maintaining this file system,
we will no longer allow write access." But I'm guessing that just
supporting reading an old file system is much easier than modifying one
(wasn't that what we did with NTFS for the longest time?)

-- Steve
