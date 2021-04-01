Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE3351379
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhDAK2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhDAKUQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 978DE61056;
        Thu,  1 Apr 2021 10:20:11 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:20:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     hch@infradead.org, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        hridya@google.com, surenb@google.com, viro@zeniv.linux.org.uk,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Export receive_fd() to modules and do some cleanups
Message-ID: <20210401102007.jalrkgxk4vevfkjd@wittgenstein>
References: <20210401090932.121-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401090932.121-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:09:30PM +0800, Xie Yongji wrote:
> This series starts from Christian's comments on the series[1].
> We'd like to export receive_fd() which can not only be used by
> our module in the series[1] but also allow further cleanups
> like patch 2 does.
> 
> Now this series is based on Christoph's patch[2].
> 
> [1] https://lore.kernel.org/linux-fsdevel/20210331080519.172-1-xieyongji@bytedance.com/
> [2] https://lore.kernel.org/linux-fsdevel/20210325082209.1067987-2-hch@lst.de
> 
> Xie Yongji (2):
>   file: Export receive_fd() to modules
>   binder: Use receive_fd() to receive file from another process
> 
>  drivers/android/binder.c | 4 ++--
>  fs/file.c                | 6 ++++++
>  include/linux/file.h     | 7 +++----

Hm, I think we're still talking a bit past each other.
I'll try to illustrate what I mean in a patch series soon.

Christian
