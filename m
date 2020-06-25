Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761D120A5EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 21:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406637AbgFYTej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbgFYTej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:34:39 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64532C08C5C1;
        Thu, 25 Jun 2020 12:34:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D468F139C482D;
        Thu, 25 Jun 2020 12:34:37 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:34:37 -0700 (PDT)
Message-Id: <20200625.123437.2219826613137938086.davem@davemloft.net>
To:     greg@kroah.com
Cc:     penguin-kernel@i-love.sakura.ne.jp, alexei.starovoitov@gmail.com,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        keescook@chromium.org, akpm@linux-foundation.org, ast@kernel.org,
        viro@zeniv.linux.org.uk, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, daniel@iogearbox.net,
        kuba@kernel.org, yamada.masahiro@socionext.com, GLin@suse.com,
        bmeneg@redhat.com, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200625120725.GA3493334@kroah.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jun 2020 12:34:38 -0700 (PDT)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Thu, 25 Jun 2020 14:07:25 +0200

> I really don't understand the objection here, why is this any different
> than any other random kernel driver for what it can do?

It's kernel code executing in userspace.  If you don't trust the
signed code you don't trust the signed code.

Nothing is magic about a piece of code executing in userspace.

I seriously think this dicussion is trying to create an issue
that simply doesn't exist in reality.

If some kernel module executed "/bin/sh" it's the same problem.
There is no way to argue around this, so please stop doing so
it's silly.
