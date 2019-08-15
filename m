Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D4B8F607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfHOUyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 16:54:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54744 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfHOUyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:54:12 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7FKrxYY010342;
        Fri, 16 Aug 2019 05:53:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Fri, 16 Aug 2019 05:53:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7FKrxcf010338;
        Fri, 16 Aug 2019 05:53:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x7FKrxNA010337;
        Fri, 16 Aug 2019 05:53:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201908152053.x7FKrxNA010337@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] nfsd: fix dentry leak upon mkdir failure.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
MIME-Version: 1.0
Date:   Fri, 16 Aug 2019 05:53:59 +0900
References: <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <20190815195958.GB19554@fieldses.org>
In-Reply-To: <20190815195958.GB19554@fieldses.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields wrote:
> On Mon, Aug 12, 2019 at 11:16:11AM +0900, Tetsuo Handa wrote:
> > syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
> > d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
> > injection) [1].
> 
> Thanks!  But it might be clearer to do this in the caller, in the same
> place the dentry was allocated?

I'm fine with that.
