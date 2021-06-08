Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D939F666
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhFHMXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232561AbhFHMXb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C41F260FE4;
        Tue,  8 Jun 2021 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623154898;
        bh=yRrNZsGy2SkBvwwkFFI2X5RqxpYzv/2ZWX2grO3P6QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxYuGUlpE+AjNHABb4nPATB6KOOT/HGWF0sN0+WkOwqiM2EldyY9tcQL9LPIYnuLb
         H9arbZVOqP8wsUpOvX1ojalKzZxCG2udOLrcpXwkgV5ZpI6LOVqioDR4CPe8idZBM+
         d9kHuF65pbvaL5m+TUMByOou6/Dx2Xs093nHJ4bA=
Date:   Tue, 8 Jun 2021 14:21:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][v2] fanotify: fix permission model of unprivileged group
Message-ID: <YL9gzn71T82YOdbF@kroah.com>
References: <20210524135321.2190062-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524135321.2190062-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 04:53:21PM +0300, Amir Goldstein wrote:
> Reporting event->pid should depend on the privileges of the user that
> initialized the group, not the privileges of the user reading the
> events.
> 
> Use an internal group flag FANOTIFY_UNPRIV to record the fact that the
> group was initialized by an unprivileged user.
> 
> To be on the safe side, the premissions to setup filesystem and mount
> marks now require that both the user that initialized the group and
> the user setting up the mark have CAP_SYS_ADMIN.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com/
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
> Cc: <Stable@vger.kernel.org> # v5.12+

Why is this marked for 5.12+ when 7cea2a3c505e ("fanotify: support
limited functionality for unprivileged users") showed up in 5.13-rc1?

What am I supposed to do with this for a stable tree submission?

confused,

greg k-h
