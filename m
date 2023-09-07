Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95427796F17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 04:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjIGCva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 22:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIGCva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449BCF2
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 19:51:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F323CC433C8;
        Thu,  7 Sep 2023 02:51:25 +0000 (UTC)
Date:   Wed, 6 Sep 2023 22:51:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230906225139.6ffe953c@gandalf.local.home>
In-Reply-To: <ZPkz86RRLaYOkmx+@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
        <ZPkDLp0jyteubQhh@dread.disaster.area>
        <20230906215327.18a45c89@gandalf.local.home>
        <ZPkz86RRLaYOkmx+@dread.disaster.area>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Sep 2023 12:22:43 +1000
Dave Chinner <david@fromorbit.com> wrote:

> > Anyway, what about just having read-only be the minimum for supporting a
> > file system? We can say "sorry, due to no one maintaining this file system,
> > we will no longer allow write access." But I'm guessing that just
> > supporting reading an old file system is much easier than modifying one
> > (wasn't that what we did with NTFS for the longest time?)  
> 
> "Read only" doesn't mean the filesytsem implementation is in any way
> secure, robust or trustworthy - the kernel is still parsing
> untrusted data in ring 0 using unmaintained, bit-rotted, untested
> code....

It's just a way to still easily retrieve it, than going through and looking
for those old ISOs that still might exist on the interwebs. I wouldn't
recommend anyone actually having that code enabled on a system that doesn't
need access to one of those file systems.

I guess the point I'm making is, what's the burden in keeping it around in
the read-only state? It shouldn't require any updates for new features,
which is the complaint I believe Willy was having.

-- Steve
