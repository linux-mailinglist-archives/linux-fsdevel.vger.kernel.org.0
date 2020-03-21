Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACD18E426
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCUUHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 16:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCUUHV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:07:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5949320775;
        Sat, 21 Mar 2020 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584821237;
        bh=h4v4wi6KGC3a9U9y2Qw8czg3F1zTRdh/7i26t05GpTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pzJITh7ITYXGZpUjF5HjEePgv3Kena4RiSnw3WN9ybb2P4TzUF2jCHnzM6Eq7HLJH
         6YXPw5IdmlF9NgqcCtS/RfzDKymT8ReLa2YX03XfgAQMfzh4x6AX9LGPKbSLwI1jgi
         0BMMc4GP3vGfk5AWYmBnv3xYZs1+N/1hVY2kpmnk=
Date:   Sat, 21 Mar 2020 13:07:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com>
Cc:     hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, schatzberg.dan@gmail.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: WARNING in alloc_page_buffers
Message-Id: <20200321130716.c1da54e6e5b9897ae5dfde38@linux-foundation.org>
In-Reply-To: <000000000000f0373505a162d972@google.com>
References: <000000000000f0373505a162d972@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 21 Mar 2020 13:00:18 -0700 syzbot <syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com> wrote:

> syzbot found the following crash on:
> 
> HEAD commit:    770fbb32 Add linux-next specific files for 20200228

That's nearly four weeks ago?

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13507489e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
> dashboard link: https://syzkaller.appspot.com/bug?extid=0985c7ea18137bf0c4ca
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b970e5e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178e99f9e00000
> 
> The bug was bisected to:
> 
> commit c9e1feb96bd90a4b51d440a015ba2f1c0562de59
> Author: Dan Schatzberg <schatzberg.dan@gmail.com>
> Date:   Tue Feb 25 04:14:08 2020 +0000
> 
>     loop: charge i/o to mem and blk cg

That commit was dropped on March 3.
