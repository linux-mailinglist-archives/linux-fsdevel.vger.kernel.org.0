Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4E7974A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjIGPkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjIGPW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F510F6
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vzKuZ842cAzlIH6IxVey8/Ja6H/+16lqE7iCte1YoSI=; b=qw4opL36m1OgTXUi6aWEL+F0fl
        ChDxJryGV+TgtKo9TBuCDMR7osiXYqegOEHct7cUTn/4N3BvOgIoLVFZlycA6Ach30G0K7H/StV8k
        7CyH6XSNJTLv91+cgXsgyEywDbAkWkbLnJAfoozkbAs29kaUStoJ2T69vsjt3yQyZFjJbI/GuLRiQ
        Y8uskT6ZqJiOWN6K8wEa8CEx+bXnnMHL9zrHlrfXaQ6lSbFGj05Vf+Bsc9Ikx4gHNvJyoIfW2bRVU
        9QZcj7bRC0ZC5qxEnvA0w+XKnXCFZgncYSXTuax69IF64za2U+C0byznhusGABzZ0NDg05yTO5s3d
        OXTexkJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeDkk-00Ai9y-5E; Thu, 07 Sep 2023 12:04:54 +0000
Date:   Thu, 7 Sep 2023 13:04:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Christian Brauner <brauner@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPm8ZpGzlY+Sgc7j@casper.infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlC0pf2XA1ZGr6j@casper.infradead.org>
 <c89ebbb2-1249-49f3-b80f-0b08711bc29b@leemhuis.info>
 <20230907-kauern-kopfkissen-d8147fb40469@brauner>
 <d62225ae-73dc-4b45-a1d9-078137224eb5@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62225ae-73dc-4b45-a1d9-078137224eb5@leemhuis.info>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:18:27PM +0200, Thorsten Leemhuis wrote:
> On 07.09.23 12:29, Christian Brauner wrote:
> >> So why can't that work similarly for unmaintained file systems? We could
> >> even establish the rule that Linus should only apply patches to some
> >> parts of the kernel if the test suite for unmaintained file systems
> >> succeeded without regressions. And only accept new file system code if a
> > 
> > Reading this mail scared me.
> 
> Sorry about that, I can fully understand that. It's just that some
> statements in this thread sounded a whole lot like "filesystems want to
> opt-out of the no regression rule" to me. That's why I at some point
> thought I had to speak up.

It's the very opposite of that.  We're all highly conscious of not eating
user data.  Which means that filesystem development often grinds to a
halt while we investigatee bugs.  This is why syzbot is so freaking
dangerous.  It's essentially an automated assault on fs developers.
Worse, Google released syzkaller to the public and now we have random
arseholes running it who have "made proprietary changes to it", and have
no idea how to decide if a report from it is in any way useful.

> But what about hfsplus? From hch's initial mail of this thread it sounds
> like that is something users would miss. So removing it without a very
> strong need[1] seems wrong to me. That's why I got involved in this
> discussion.
> 
> [1] e.g. data loss or damage (as mentioned in my earlier mail) or
> substantial security problems (forgot to mentioned them in my earlier mail)

That's the entire problem!  A seemingly innocent change can easily
lose HFS+ data and we wouldn't find out for years because there's no
test-suite.  A properly tested filesystem looks like this:

https://lore.kernel.org/linux-ext4/20230903120001.qjv5uva2zaqthgk2@zlang-mailbox/

I inadvertently introduced a bug in ext4 with 1kB block size; it's
picked up in less than a week, and within a week of the initial report,
it's diagnosed and fixed.

If that same bug had been introduced to HFS+, how long would it have
taken for anyone to find the bug?  How much longer would it have taken
to track down and fix?

