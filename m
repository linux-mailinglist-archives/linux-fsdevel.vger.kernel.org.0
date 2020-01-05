Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C189B1306BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgAEIIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 03:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAEIIM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 03:08:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C81A21582;
        Sun,  5 Jan 2020 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578211691;
        bh=oOTJPs6LmR2DgRdC1cSmWjBy+jne5zc4BT1JPO6UWl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJKHGl7BxjoLlMiGHqDoiyvzFnvm517dml5xm8zk4j8LSasKysNVY7vDg5km2hkLK
         dnY9/l6ctq3DtKSYZ2VRI2O7bqVtnpkFlINOysmnOK4XFOJmZ5FhjJV1dxoKyDJ7F2
         92DBI67HZbCvdn0XgvheyFDeR/sul3Tw/N/sG4yY=
Date:   Sun, 5 Jan 2020 09:08:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        fuse-devel@lists.sourceforge.net
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
Message-ID: <20200105080808.GA1667342@kroah.com>
References: <CACsaVZLApLO=dNCU07ZjMx4qA8dv1=OA7n31uD9GzHkSFCm8oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZLApLO=dNCU07ZjMx4qA8dv1=OA7n31uD9GzHkSFCm8oA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 04, 2020 at 05:15:30PM -0800, Kyle Sanderson wrote:
> [400280.179731] BUG: unable to handle page fault for address: 0000000044000000
> [400280.179842] #PF: supervisor instruction fetch in kernel mode
> [400280.179938] #PF: error_code(0x0010) - not-present page
> [400280.180032] PGD 0 P4D 0
> [400280.180125] Oops: 0010 [#1] PREEMPT SMP NOPTI
> [400280.180221] CPU: 5 PID: 6894 Comm: mergerfs Not tainted 5.4.6-gentoo #1

"still"?

When did this show up?  What were you doing to cause the issue?  Can you
run 'git bisect' to find the problem commit?  When/where did you report
this problem in the past?

thanks,

greg k-h
