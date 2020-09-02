Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518C125B04E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgIBPzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgIBPy5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:54:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADF0207EA;
        Wed,  2 Sep 2020 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062096;
        bh=IHtVtHdYxHiYiXqtkZCw7iTPpeco0FFoKPfdxI8TWpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cCrb6qbZ4svy89laCWuH8ic/TTNtnTnXgP3Vh6xBQNJ0NIcYZ6mkGrBOX8vNHaV+g
         waB/MEhWyCJnI7aG6VhaiUlI3ixxOXOiM7+xLMLmXQHDU9uY/Y4YiKULCUl0E6G66E
         +px0EeS3fMFNF/XyMMNu74j03hJBSiCEbH6ZQOY8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDV67-008ese-8z; Wed, 02 Sep 2020 16:54:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Sep 2020 16:54:55 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] epoll fixup
In-Reply-To: <20200902153747.GL1236603@ZenIV.linux.org.uk>
References: <20200902153747.GL1236603@ZenIV.linux.org.uk>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <86e8eacb602dc01770681f3a414c103f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-02 16:37, Al Viro wrote:
> Fixup for epoll regression; there's a better solution longer term,
> but this is the least intrusive fix.
> 
> The following changes since commit 
> 52c479697c9b73f628140dcdfcd39ea302d05482:
> 
>   do_epoll_ctl(): clean the failure exits up a bit (2020-08-22 18:25:52 
> -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
> 
> for you to fetch changes up to 
> 77f4689de17c0887775bb77896f4cc11a39bf848:
> 
>   fix regression in "epoll: Keep a reference on files added to the
> check list" (2020-09-02 11:30:48 -0400)
> 
> ----------------------------------------------------------------
> Al Viro (1):
>       fix regression in "epoll: Keep a reference on files added to the
> check list"
> 
>  fs/eventpoll.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Cheers for that Al. I'll take care of the stable backports.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
