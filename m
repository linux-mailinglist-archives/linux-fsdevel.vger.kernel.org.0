Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7931CC5E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 03:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEJBEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 21:04:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59364 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgEJBEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 21:04:24 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04A14KL4042726;
        Sun, 10 May 2020 10:04:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sun, 10 May 2020 10:04:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04A14KVP042723
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 May 2020 10:04:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless
 access_ok()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
 <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
 <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <db18b423-22b5-585b-db91-45f2251bae66@i-love.sakura.ne.jp>
Date:   Sun, 10 May 2020 10:04:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgqyW2ow6yO+yz_0v4aKd162Lwtr24c5nKjZRG-2vW8PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/10 9:57, Linus Torvalds wrote:
> On Sat, May 9, 2020 at 5:51 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I think that this access_ok() check helps reducing partial writes (either
>> "whole amount was processed" or "not processed at all" unless -ENOMEM).
> 
> No it doesn't.
> 
> "access_ok()" only checks the range being a valid user address range.
> 

I see. Thank you.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
