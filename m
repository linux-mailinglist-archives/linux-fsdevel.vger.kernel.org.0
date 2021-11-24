Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BAB45B09C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 01:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhKXAR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 19:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhKXARh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:17:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 697136108F;
        Wed, 24 Nov 2021 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637712869;
        bh=xo+CUcZM0HsGEh+HR/CKl+YdldQlPJUubPudUZl4ywM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sLfJW0IXcDfi/vPNrmXoBFiFTruGlTbnMjLvIxkgNTwNi3fAD+x6Y80r8L90uovEs
         KgQZQmVqJJL/Tt/RG2PdefatvW+CGOtJUvgMcDjIp3IMAhVwo2PDIfdQBETz/SYmBE
         SlcuqnPfHYth+ukiAhAC0xI9D/oiHoaglIMLFFFM=
Date:   Tue, 23 Nov 2021 16:14:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] sysctl: first set of kernel/sysctl cleanups
Message-Id: <20211123161426.48844f7500be5ca6363b3818@linux-foundation.org>
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Nov 2021 12:23:38 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> Since the sysctls are all over the place I can either put up a tree
> to keep track of these changes and later send a pull request to Linus
> or we can have them trickle into Andrew's tree. Let me know what folks
> prefer.

I grabbed.  I staged them behind all-of-linux-next, to get visibility
into changes in the various trees which might conflict.
