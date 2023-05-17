Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6C7067E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjEQMUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 08:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEQMUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 08:20:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81065198E;
        Wed, 17 May 2023 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NrmV1RlXNUksQObxSTnk5T7ZKt0dHdVGx6FKtxXOMuE=; b=lz5gMl8DB28Tk7MctDq2tS5GlA
        6jrqXdvhj1jiLFhVKu9DBa7R/C1q/NIQQzW+3uK7M1QZbsB+VkHpUo+2SfY1FTkpked+w8haV+oZB
        VJSl3NByTzlAgkfrlAEkODeNDuHWkNQyA4r6mm9EckjjrPNUCcjd5qjkBNy89TZbWuqR6KcOYko9c
        KEVSjvVE/iWEJYSQC4qIao/hxYfWZxBNHfY5dfhuCdx1nXs2GHVQjN6AdC1n64DkHzEUk5cfetqBc
        NkQhEuQxcWD0XuJIJelG8PGF+FmDmdrKyt/Y3R8S9ffXUS38IT0aoAKtMtjXOqgwZNYtI6dmURcT1
        M/1FPFzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzG8m-0054gz-A1; Wed, 17 May 2023 12:20:24 +0000
Date:   Wed, 17 May 2023 13:20:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yang lan <lanyang0908@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, brauner@kernel.org
Subject: Re: INFO: task hung in blkdev_open bug
Message-ID: <ZGTGiNItObrI2Z34@casper.infradead.org>
References: <CAAehj2=HQDk-AMYpVR7i91hbQC4G5ULKd9iYoP05u_9tay8VMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAehj2=HQDk-AMYpVR7i91hbQC4G5ULKd9iYoP05u_9tay8VMw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 07:12:23PM +0800, yang lan wrote:
> root@syzkaller:~# uname -a
> Linux syzkaller 5.10.179 #1 SMP PREEMPT Thu Apr 27 16:22:48 CST 2023

Does this reproduce on current kernels, eg 6.4-rc2?

> root@syzkaller:~# gcc poc_blkdev.c -o poc_blkdev

You need to include poc_blkdev.c as part of your report.

> Please let me know if I can provide any more information, and I hope I
> didn't mess up this bug report.

I suspect you've done something that is known to not work (as root,
so we won't necessarily care).  But I can't really say without seeing
what you've done.  Running syzkaller is an art, and most people aren't
good at it.  It takes a lot of work to submit good quality bug reports,
see this article:

https://blog.regehr.org/archives/2037
