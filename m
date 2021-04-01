Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477D3512C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhDAJxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233616AbhDAJxc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0A2061056;
        Thu,  1 Apr 2021 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617270812;
        bh=uWjbvTO2WwgODclJI58uaXmPHckyqLbVbTRDI2A+ceM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+4quU5PU1udpHsVgN0JN+IN8KXxML9/KwALZxKFxr30vDrLYB4pepnKSiWGYCx6Z
         AZs8eEt6hnUUOJ6L9LrF/8RBxhwOiDZvAVszLBzzrpa5pHoq83VOFiYu7FA2NmAfAF
         3IFcWjv5AHaJyLG0qKzs61Obbsb9KaDph9ccbrKk=
Date:   Thu, 1 Apr 2021 11:53:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     christian.brauner@ubuntu.com, hch@infradead.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        hridya@google.com, surenb@google.com, viro@zeniv.linux.org.uk,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Export receive_fd() to modules and do some cleanups
Message-ID: <YGWYDog+YhgeD1mS@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

But binder can not be a module, so why do you need this?

confused,

greg k-h
