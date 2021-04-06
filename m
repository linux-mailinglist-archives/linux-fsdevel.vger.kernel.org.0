Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C72354C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDFFJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 01:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhDFFJU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 01:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D7AA6139B;
        Tue,  6 Apr 2021 05:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617685753;
        bh=LqjMrJSAzijL431bshxV0LVdpKWP5C/U0bzpPFaPPKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z7GuahCgW+CfUDeOOiNubLpgrAQ3l1kD+SezHa02EE9DOzaNePYWlKhma+tQgyVUO
         tLLL+UjyJmH2I332r0yAHP1gLOuX2Bph6HZUxL7oQx8GWYwGMz1B5ok65TV16U8QAn
         LTBVbH+SuwqMGYXLaew+LpY2I6bkmWY13axbHpyI=
Date:   Mon, 5 Apr 2021 22:09:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] fs/epoll: restore waking from ep_done_scan()
Message-Id: <20210405220912.b916e5f504cd2c11d7288cb2@linux-foundation.org>
In-Reply-To: <20210406032226.2fpfzrlyxu2wz2jw@offworld>
References: <20210405231025.33829-1-dave@stgolabs.net>
        <20210405231025.33829-3-dave@stgolabs.net>
        <20210405185018.40d437d392863f743131fcda@linux-foundation.org>
        <20210406032226.2fpfzrlyxu2wz2jw@offworld>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Apr 2021 20:22:26 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 05 Apr 2021, Andrew Morton wrote:
> 
> >Tricky.  339ddb53d373 was merged in December 2019.  So do we backport
> >this fix?  Could any userspace code be depending upon the
> >post-339ddb53d373 behavior?
> 
> As with previous trouble caused by this commit, I vote for restoring the behavior
> backporting the fix, basically the equivalent of adding (which was my intention):
> 
> Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")

OK, I added the Fixes: line and the cc:stable line.
