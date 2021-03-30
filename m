Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4273634EAE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhC3Or4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 10:47:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61529 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhC3Org (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:47:36 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12UElLuM041883;
        Tue, 30 Mar 2021 23:47:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Tue, 30 Mar 2021 23:47:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12UElDi3041634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Mar 2021 23:47:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.cz>
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
 <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
Date:   Tue, 30 Mar 2021 23:47:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/22 4:20, Linus Torvalds wrote:
> On Sun, Mar 21, 2021 at 7:37 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> syzbot is reporting NULL pointer dereference at reiserfs_security_init()
> 
> Whee. Both of the mentioned commits go back over a decade.
> 
> I guess I could just take this directly, but let's add Jeff Mahoney
> and Jan Kara to the participants in case they didn't see it on the
> fsdevel list. I think they might want to be kept in the loop.
> 
> I'll forward the original in a separate email to them.
> 
> Jeff/Jan - just let me know if I should just apply this as-is.
> Otherwise I'd expect it to (eventually) come in through Jan's random
> fs tree, which is how I think most of these things have come in ..
> 

Linus, please just apply this as-is.

Jan says "your change makes sense" at https://lkml.kernel.org/m/20210322153142.GF31783@quack2.suse.cz
and Jeff says "Tetsuo's patch is fine" at https://lkml.kernel.org/m/7d7a884a-5a94-5b0e-3cf5-82d12e1b0992@suse.com
and I'm waiting for Jan/Jeff's reply to "why you think that my patch is incomplete" at
https://lkml.kernel.org/m/fa9f373a-a878-6551-abf1-903865a9d21f@i-love.sakura.ne.jp .
Since Jan/Jeff seems to be busy, applying as-is will let syzkaller answer to my question.
